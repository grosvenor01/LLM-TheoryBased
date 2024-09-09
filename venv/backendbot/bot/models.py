from django.db import models

class messages(models.Model):
    content = models.TextField()
    date = models.DateTimeField()
    messageType= models.CharField(choices=(('Send','Send'),('Receive','Receive')), max_length=10)

