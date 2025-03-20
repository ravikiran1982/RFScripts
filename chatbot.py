import streamlit as st
from PyPDF2 import PdfReader
from langchain.text_splitter import RecursiveCharacterTextSplitter
from langchain_community.embeddings import OpenAIEmbeddings
from langchain_community.vectorstores import FAISS
from langchain_community.chat_models import ChatOpenAI
from langchain.chains.question_answering import load_qa_chain

OPENAI_API_KEY = "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"

# Upload PDF file
st.header("My First Chatbot")
with st.sidebar:
    st.title("Your Documents")
    file = st.file_uploader("Upload a PDF file and start asking questions", type="pdf")

# Extract the text
if file is not None:
    pdf_reader = PdfReader(file)
    text = ""
    for page in pdf_reader.pages:
        text+=page.extract_text()
        # st.write(text)

# Break it into chunks
    text_splitter = RecursiveCharacterTextSplitter(
        chunk_size = 1000,
        separators = "\n",
        chunk_overlap = 150,
        length_function = len
    )
    chunks = text_splitter.split_text(text)
    # st.write(chunks)

# Generating Embeddings
    embeddings = OpenAIEmbeddings(api_key = OPENAI_API_KEY)

# Creating Vector Store (Database) - FAISS (Facebook AI Semantic Search)
    vector_store = FAISS.from_texts(chunks, embeddings)

# Get user question
    user_question = st.text_input("Type your question here:")

# Do similarity search
    if user_question:
        match = vector_store.similarity_search(user_question)
        # st.write(match)

# Define the LLM
        llm = ChatOpenAI(
            api_key = OPENAI_API_KEY,
            temperature = 0,
            max_tokens = 1000,
            model = "gpt-3.5-turbo"
        )

# Output results
        # chain -> take the question, get relevant document, pass it to the LLM, generate the output
        chain = load_qa_chain(llm, chain_type = "stuff")
        response = chain.run(input_documents = match, question = user_question)
        st.write(response)