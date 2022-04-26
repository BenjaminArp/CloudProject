import discord
from discord.ext import commands
import datetime
import requests
import json


bot = commands.Bot(command_prefix='!', description="This is a translation Bot")

@bot.command()
async def translate(ctx):
    message = ctx.message.content[11:]
    url = "http://localhost:4000/translate"
    body = {'text': message}
    response = requests.post(url, data = body)
    r = json.loads(response.text)
    await ctx.send("Translation: " + r["translation"])

@bot.event
async def on_ready():
    await bot.change_presence(activity=discord.Activity(type=discord.ActivityType.watching, name='YOU!'))
    print('I am ready')




bot.run('Look in secrets')
