from django.urls import path
from .views import ProjectListView, ProjectDetailView

urlpatterns = [
        path('', ProjectListView.as_view(), name='project-list'),
        path('project/<int:pk>/', ProjectDetailView.as_view(), name='project-detail'),
        ]
