RSpec.describe Compass do
  describe '.new' do
    it 'default direction is north' do
      expect(subject.direction).to eq 'NORTH'
    end
  end

  describe '#direction=' do
    context 'when given direction is valid' do
      it 'sets current direction' do
        subject.direction = 'SOUTH'
        expect(subject.direction).to eq 'SOUTH'
      end
    end

    context 'when given direction is not valid' do
      it 'does not current direction' do
        subject.direction = 'Northwest'
        expect(subject.direction).to eq 'NORTH'
      end
    end
  end

  describe '#valid_direction?' do
    context 'when direction is valid' do
      subject { described_class.new.valid_direction?('WEST') }

      it { is_expected.to be true }
    end

    context 'when direction is not valid' do
      subject { described_class.new.valid_direction?('FOOAST') }

      it { is_expected.to be false }
    end
  end

  describe '#left' do
    {
      'NORTH' => 'WEST',
      'EAST'  => 'NORTH',
      'SOUTH' => 'EAST',
      'WEST'  => 'SOUTH'
    }.each do |current, left|
      context "when current direction is #{current}" do
        before do
          subject.direction = current
        end

        it "turns direction to #{left}" do
          subject.left
          expect(subject.direction).to eq left
        end

        it 'returns new current direction' do
          expect(subject.left).to eq left
        end
      end
    end
  end

  describe '#right' do
    {
      'NORTH' => 'EAST',
      'EAST'  => 'SOUTH',
      'SOUTH' => 'WEST',
      'WEST'  => 'NORTH'
    }.each do |current, right|
      context "when current direction is #{current}" do
        before do
          subject.direction = current
        end

        it "turns direction to #{right}" do
          subject.right
          expect(subject.direction).to eq right
        end

        it 'returns new current direction' do
          expect(subject.right).to eq right
        end
      end
    end
  end
end
