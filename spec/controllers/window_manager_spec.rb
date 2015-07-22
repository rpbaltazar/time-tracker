describe 'window manager controller' do
  before do
    @windowManagerController = WindowManagerController.new
  end

  it 'is able to compute time difference in seconds' do
    appData = {start_time: Time.now, end_time: Time.now + 120}
    timeDiff = @windowManagerController.computeTimeDifference appData
    timeDiff.should.equal 120
  end
end
