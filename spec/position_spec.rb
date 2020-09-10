RSpec.describe Position do
  subject { described_class.new(1, 3) }

  describe '.new' do
    it 'sets x' do
      expect(subject.x).to eq 1
    end

    it 'sets y' do
      expect(subject.y).to eq 3
    end
  end

  describe '#move_to' do
    it 'returns a new position to given direction' do
      expect(subject.move_to(:east).to_s).to eq Position.new(2, 3).to_s
    end
  end

  describe '#to_north' do
    it 'returns a new position moved one unit to north' do
      expect(subject.to_north.to_s).to eq Position.new(1, 4).to_s
    end
  end

  describe '#to_south' do
    it 'returns a new position moved one unit to south' do
      expect(subject.to_south.to_s).to eq Position.new(1, 2).to_s
    end
  end
  describe '#to_east' do
    it 'returns a new position moved one unit to east' do
      expect(subject.to_east.to_s).to eq Position.new(2, 3).to_s
    end
  end
  describe '#to_west' do
    it 'returns a new position moved one unit to west' do
      expect(subject.to_west.to_s).to eq Position.new(0, 3).to_s
    end
  end

  describe '#to_s' do
    it 'returns the current position' do
      expect(subject.to_s).to eq '1,3'
    end
  end
end
