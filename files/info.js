const blocks = document.querySelectorAll('.block');

blocks.forEach(block => {
  block.addEventListener('mousemove', e => {
    const rect = block.getBoundingClientRect();
    const x = e.clientX - rect.left;
    const y = e.clientY - rect.top;

    const center_x = rect.width / 2;
    const center_y = rect.height / 2;

    const rotate_x = -(y - center_y) / 15;
    const rotate_y = (x - center_x) / 15;

    block.style.transform = `rotateX(${rotate_x}deg) rotateY(${rotate_y}deg) scale(1.05)`;
  });

  block.addEventListener('mouseleave', () => {
    block.style.transform = 'rotateX(0) rotateY(0) scale(1)';
  });
});
