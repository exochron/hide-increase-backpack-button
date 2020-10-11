local frames = {
    ContainerFrame1AddSlotsButton,
    ContainerFrame1ItemButton1,
    ContainerFrame1ItemButton2,
    ContainerFrame1ItemButton3,
    ContainerFrame1ItemButton4,
}

for _, frame in ipairs(frames) do
    if frame then
        frame:Hide()
        frame.Show = frame.Hide
        frame.SetShown = frame.Hide
    end
end
