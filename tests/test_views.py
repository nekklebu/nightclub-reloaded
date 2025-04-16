import pytest
from django.urls import reverse
from portfolio.models import Project
from blog.models import BlogPost


@pytest.mark.django_db
def test_home_page(client):
    url = reverse("home")
    response = client.get(url)
    assert 200 == response.status_code


@pytest.mark.django_db
def test_project_displayed(plastic_cups, client):
    response = client.get(reverse("project-list"))
    assert plastic_cups.title in response.content.decode()
    assert plastic_cups.description not in response.content.decode()


@pytest.mark.django_db
def test_project_details_displayed(plastic_cups, client):
    response = client.get(reverse("project-detail", kwargs={"pk": plastic_cups.pk}))
    assert plastic_cups.title in response.content.decode()
    assert plastic_cups.description in response.content.decode()


@pytest.mark.django_db
def test_blog_displayed(that_one_time, client):
    response = client.get(reverse("blog-list"))
    assert that_one_time.title in response.content.decode()
    assert that_one_time.body not in response.content.decode()


@pytest.mark.django_db
def test_post_displayed(that_one_time, client):
    response = client.get(reverse("blog-detail", kwargs={"slug": that_one_time.slug}))
    assert that_one_time.title in response.content.decode()
    assert that_one_time.body in response.content.decode()
    assert that_one_time.image.url in response.content.decode()
