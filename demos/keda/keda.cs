using System;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Host;
using Microsoft.Extensions.Logging;
using System.Threading.Tasks;

namespace keda
{
    public static class keda
    {
        [FunctionName("keda")]
        public static void Run([QueueTrigger("queue-items", Connection = "")]string myQueueItem, ILogger log)
        {
            log.LogInformation($"C# Queue trigger function processed: {myQueueItem}");
            Task.Delay(5000).Wait();
        }
    }
}
