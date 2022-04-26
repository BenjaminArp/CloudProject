import discord
import discord
from discord.ext import commands
import datetime
import requests
import json


bot = commands.Bot(command_prefix='!', description="This is a translation Bot")

@bot.command()
async def translate(ctx):
    message = ctx.message.content[11:]
    url = "http://193.196.54.78:4000/translate"
    body = {'text': message}
    response = requests.post(url, data = body)
    r = json.loads(response.text)
    return await ctx.send("Translation: " + r["translation"], tts=False)

@bot.command()
async def tts(ctx):
    message = ctx.message.content[5:]
    url = "http://193.196.54.78:4000/translate"
    body = {'text': message}
    response = requests.post(url, data = body)
    r = json.loads(response.text)
    return await ctx.send(r["translation"], tts=True)

@bot.event
async def on_ready():
    await bot.change_presence(activity=discord.Activity(type=discord.ActivityType.watching, name='YOU!'))


bot.run('Look in secrets')
