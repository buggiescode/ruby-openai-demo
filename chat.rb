# Write your solution here!
require "openai"
require "dotenv/load"

client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_KEY"))

# Prepare an Array of previous messages
message_list = [
  {
    "role" => "system",
    "content" => "You are a helpful assistant who talks like Shakespeare."
  }
]


user_message = ""

while user_message.downcase != "bye"
  puts "Hello! How can I help you today?"
  puts "--------------------------------------------------"
  
  user_message = gets.chomp

  if user_message.downcase != "bye"
    message_list.push({ "role" => "user", "content" => user_message })
    # Call the API to get the next message from GPT
    api_response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: message_list
      }
    )
    choices = api_response.fetch("choices")
    first_choice = choices.at(0)
    message = first_choice.fetch("message")
    ai_response = message["content"]

    puts ai_response
    puts "--------------------------------------------------"

    message_list.push({ "role" => "assistant", "content" => ai_response })
  end

end
