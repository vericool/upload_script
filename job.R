
library(cronR)


cmd <- cron_rscript("/home/ubuntu/node_api/upload_script/code.R")
cmd

cron_add(cmd, frequency = 'daily', id = 'job2', description = 'Customers', at = '00:00')

