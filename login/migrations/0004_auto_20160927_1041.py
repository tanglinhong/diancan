# -*- coding: utf-8 -*-
# Generated by Django 1.10.1 on 2016-09-27 02:41
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('login', '0003_auto_20160927_1039'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='cellphone',
            field=models.CharField(default='NULL', max_length=20),
        ),
        migrations.AlterField(
            model_name='user',
            name='email',
            field=models.EmailField(default='NULL', max_length=30),
        ),
    ]