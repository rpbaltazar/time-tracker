describe 'window manager controller' do
  before do
    @windowManagerController = WindowManagerController.new
  end

  describe '#updateTracker' do
    describe 'when a new app is in focus' do
      # NOTE: Probably I'll need ot use something like timecop to get the test passing
      before do
        @windowManagerController.send :updateTracker, "Magnificent"
      end

      it 'registers the start_time for the new app' do
        # NOTE: This is a pretty stupid way to test it, but gets the job done.
        # Need to investigate a bit more how to compare the dates/data structure
        timeNow = Time.now
        recordedData = @windowManagerController.instance_variable_get('@recordedData')
        (recordedData['Magnificent'][0][:start_time].hour == timeNow.hour).should.equal true
        (recordedData['Magnificent'][0][:start_time].min == timeNow.min).should.equal true
        (recordedData['Magnificent'][0][:start_time].sec == timeNow.sec).should.equal true
      end
    end

    describe 'when a the app in focus already exists' do
      # NOTE: Probably I'll need ot use something like timecop to get the test passing
      before do
        @windowManagerController.send :updateTracker, "Magnificent"
        @windowManagerController.send :updateTracker, "Timewrap"
        sleep 3
        @windowManagerController.send :updateTracker, "Magnificent"
      end

      it 'registers the start_time for the new app' do
        # NOTE: This is a pretty stupid way to test it, but gets the job done.
        # Need to investigate a bit more how to compare the dates/data structure
        timeNow = Time.now
        recordedData = @windowManagerController.instance_variable_get('@recordedData')
        (recordedData['Magnificent'][1][:start_time].hour == timeNow.hour).should.equal true
        (recordedData['Magnificent'][1][:start_time].min == timeNow.min).should.equal true
        (recordedData['Magnificent'][1][:start_time].sec == timeNow.sec).should.equal true
      end
    end
  end

  describe '#computeTimeDifference' do
    describe 'when app data is complete' do
      it 'computes time difference in seconds' do
        appData = { start_time: Time.now - 10, end_time: Time.now + 120 }
        timeDiff = @windowManagerController.send :computeTimeDifference, appData
        timeDiff.should.equal 130
      end
    end

    describe 'when app data is incomplete' do
      it 'computes time difference in seconds with end_time as Time.now' do
        appData = { start_time: Time.now - 10 }
        timeDiff = @windowManagerController.send :computeTimeDifference, appData
        timeDiff.should.equal 10
      end
    end
  end
end
