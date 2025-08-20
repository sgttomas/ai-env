from xai_sdk import Client
client = Client()
chat = client.chat.create(model="grok-3", messages=[{"role": "user", "content": "You are a helpful assistant."}])
chat.append({"role": "user", "content": "Hello world"})
response = chat.sample()
print(f"Grok: {response.content}")
