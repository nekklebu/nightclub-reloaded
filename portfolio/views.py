from django.shortcuts import render
from django.views.generic import ListView, DetailView, TemplateView
from .models import Project

class HomePageView(TemplateView):
    template_name = "home.html"

class ProjectListView(ListView):
    model = Project
    template_name = 'portfolio/project_list.html'
    context_object_name = 'projects'

class ProjectDetailView(DetailView):
    model = Project
    template_name = 'portfolio/project_detail.html'
