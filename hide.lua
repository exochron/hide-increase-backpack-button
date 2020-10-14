local frames = {
    ContainerFrame1AddSlotsButton,
    ContainerFrame1Item1,
    ContainerFrame1Item2,
    ContainerFrame1Item3,
    ContainerFrame1Item4,
}

for _, frame in ipairs(frames) do
    if frame then
        frame:Hide()
        frame.Show = frame.Hide
        frame.SetShown = frame.Hide
    end
end
