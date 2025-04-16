from django.urls import path
from .views import HomePageView, ProjectListView, ProjectDetailView

urlpatterns = [
    path("", HomePageView.as_view(), name="home"),
    path("projects/", ProjectListView.as_view(), name="project-list"),
    path("project/<int:pk>/", ProjectDetailView.as_view(), name="project-detail"),
]
