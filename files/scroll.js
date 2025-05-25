function scroll_to_second_container() {
  const container = document.getElementById("scrolled");
  const container_center = container.offsetTop + container.offsetHeight / 2 - window.innerHeight / 2;
  window.scrollTo({
    top: container_center,
    behavior: "smooth"
  });
}
