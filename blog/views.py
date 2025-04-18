from django.views.generic import ListView, DetailView
from .models import BlogPost


class BlogListView(ListView):
    model = BlogPost
    template_name = "blog/blog_list.html"
    context_object_name = "posts"


class BlogDetailView(DetailView):
    model = BlogPost
    template_name = "blog/blog_detail.html"
