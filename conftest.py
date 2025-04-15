import pytest

from blog.models import BlogPost
from portfolio.models import Project
from django.utils.text import slugify

@pytest.fixture
def that_one_time():
    title = "That one time"
    body  = "Everyone remembers,,,"
    return BlogPost.objects.create(
            title=title,
            slug=slugify(title),
            body=body
            )

@pytest.fixture
def plastic_cups():
    return Project.objects.create(
            title="Plastic cups",
            description="A project. about cups."
            )
