from django.shortcuts import render

# Create your views here.
def index(request):
    return render(request, 'portfo/index.html')

def aboutpage(request):
    return render(request, 'portfo/about.html')