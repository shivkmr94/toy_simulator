RSpec.describe Table do
  describe '.new' do
    context 'with default size' do
      let(:height) { 5 }
      let(:weidth) { 5 }
      subject { described_class.new(height, weidth) }
      it 'width is 5' do
        expect(subject.width).to eq height
      end

      it 'height is 5' do
        expect(subject.height).to eq height
      end
    end

    context 'when size is given' do
      subject { described_class.new(15, 32) }

      it 'width is given width' do
        expect(subject.width).to eq 15
      end

      it 'height is given height' do
        expect(subject.height).to eq 32
      end
    end
  end

  describe '#within_bounds?' do
    subject { described_class.new.within_bounds?(position) }

    context 'when x and y are WITHIN bounds' do
      let(:position) { Position.new(0, 4) }
      it { expect(subject).to be true }

    end

    context 'when x is WITHIN bounds and y is OUT OF bounds' do
      [-1, 5].each do |out_of_bounds|
        context "with #{out_of_bounds} value" do
          let(:position) { Position.new(0, out_of_bounds) }

          it { expect(subject).to be false }
        end
      end
    end

    context 'when y is WITHIN bounds and x is OUT OF bounds' do
      [-1, 5].each do |out_of_bounds|
        context "with #{out_of_bounds} value" do
          let(:position) { Position.new(out_of_bounds, 4) }

          it { expect(subject).to be false }
        end
      end
    end

    context 'when x and y are OUT OF bounds' do
      [-1, 5].each do |out_of_bounds|
        context "with #{out_of_bounds} value" do
          let(:position) { Position.new(out_of_bounds, out_of_bounds) }
          it { expect(subject).to be false }
        end
      end
    end
  end
end
