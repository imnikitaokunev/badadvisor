using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Azure.Cosmos.Table;

namespace BadAdvisor.Mvc.Data
{
    public class MessagesRepository : IMessagesRepository
    {
        private const string TableName = "commitmessage";
        private const string PartitionKey = "fun";
        private readonly CloudTableClient _tableClient;

        public MessagesRepository(CloudTableClient tableClient)
        {
            _tableClient = tableClient;
        }

        public int GetTotalCount()
        {
            var table = _tableClient.GetTableReference(TableName);

            var result = table.ExecuteQuery(new TableQuery<Message>()
            {
                SelectColumns = new List<string>(0) {},
            }, new TableRequestOptions());

            return result.Count();
        }

        public async Task<Message> Get(int id)
        {
            var table = _tableClient.GetTableReference(TableName);
            var operation = TableOperation.Retrieve<Message>(PartitionKey, id.ToString());
            var result = await table.ExecuteAsync(operation);

            if (result.Result == null) throw new InvalidOperationException($"Didn't find a message with the specified id: '{id}'.");

            return result.Result as Message;
        }
    }

    public interface IMessagesRepository
    {
        int GetTotalCount();

        Task<Message> Get(int id);
    }
}
