using Microsoft.Azure.Cosmos.Table;

namespace BadAdvisor.Mvc.Data
{
    public class Message : TableEntity
    {
        public string Text { get; set; }

        public int Likes { get; set; }

        public int TimesCopied { get; set; }
    }
}
