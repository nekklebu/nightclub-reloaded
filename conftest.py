import pytest
import io
from PIL import Image
from django.core.files.uploadedfile import SimpleUploadedFile
from django.utils.text import slugify
from blog.models import BlogPost
from portfolio.models import Project

def _that_one_picture(name="from-that-one-time.jpg"):
    img = Image.new('RGB', (100, 100), color=(255, 0, 0))
    buf = io.BytesIO()
    img.save(buf, format='JPEG')
    return SimpleUploadedFile(name, buf.getvalue(), content_type='image/jpeg')

@pytest.fixture
def that_one_time():
    title = "That one time"
    body  = "Everyone remembers,,,"
    return BlogPost.objects.create(
            title=title,
            slug=slugify(title),
            body=body,
            image=_that_one_picture()
            )
@pytest.fixture
def plastic_cups():
    return Project.objects.create(
            title="Plastic cups",
            description="A project. about cups."
            )
