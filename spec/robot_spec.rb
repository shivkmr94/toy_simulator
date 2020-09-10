RSpec.describe Robot do
  let(:table) { Table.new }
  subject { described_class.new(table) }

  describe '.new' do
    it 'sets table' do
      expect(subject.table).to eql table
    end

    context 'when compass is not given' do
      it 'sets default compass' do
        expect(subject.compass).to be_an_instance_of(Compass)
      end
    end

    context 'when compass is given' do
      let(:compass) { double('16-point Compass') }

      it 'sets compass with given compass' do
        subject = described_class.new(table, compass)
        expect(subject.compass).to eql compass
      end
    end
  end

  describe '#place' do
    let(:valid_position) { Position.new(1, 3) }
    let(:valid_direction) { 'EAST' }

    context 'when place is valid' do
      it 'sets current place' do
        subject.place(valid_position, valid_direction)
        expect(subject.report).to eq '1,3,EAST'
      end
    end

    context 'when place is not valid' do
      context 'because x position' do
        let(:invalid_position) { Position.new(99, 3) }

        context 'and there is not current place yet' do
          it 'does not set current place' do
            subject.place(invalid_position, valid_direction)
            expect(subject.report).to be_nil
          end
        end

        context 'and there is current place' do
          it 'keeps the previous current place' do
            subject.place(valid_position, valid_direction)
            subject.place(invalid_position, valid_direction)
            expect(subject.report).to eq '1,3,EAST'
          end
        end
      end

      context 'because y position' do
        let(:invalid_position) { Position.new(1, 99) }

        context 'and there is not current place yet' do
          it 'does not set current place' do
            subject.place(invalid_position, valid_direction)
            expect(subject.report).to be_nil
          end
        end

        context 'and there is current place' do
          it 'keeps the previous current place' do
            subject.place(valid_position, valid_direction)
            subject.place(invalid_position, valid_direction)
            expect(subject.report).to eq '1,3,EAST'
          end
        end
      end

      context 'because direction' do
        let(:invalid_direction) { 'NORTHWEST' }

        context 'and there is not current place yet' do
          it 'does not set current place' do
            subject.place(valid_position, invalid_direction)
            expect(subject.report).to be_nil
          end
        end

        context 'and there is current place' do
          it 'keeps the previous current place' do
            subject.place(valid_position, valid_direction)
            subject.place(valid_position, invalid_direction)
            expect(subject.report).to eq '1,3,EAST'
          end
        end
      end
    end
  end

  describe '#move' do
    context 'when movement is valid' do
      it 'moves one unit to north' do
        subject.place(Position.new(2, 2), 'NORTH')
        subject.move
        expect(subject.report).to eq '2,3,NORTH'
      end

      it 'moves one unit to east' do
        subject.place(Position.new(2, 2), 'EAST')
        subject.move
        expect(subject.report).to eq '3,2,EAST'
      end

      it 'moves one unit to south' do
        subject.place(Position.new(2, 2), 'SOUTH')
        subject.move
        expect(subject.report).to eq '2,1,SOUTH'
      end

      it 'moves one unit to west' do
        subject.place(Position.new(2, 2), 'WEST')
        subject.move
        expect(subject.report).to eq '1,2,WEST'
      end
    end

    context 'when movement is invalid' do
      it 'does not move one unit to north' do
        subject.place(Position.new(2, 4), 'NORTH')
        subject.move
        expect(subject.report).to eq '2,4,NORTH'
      end

      it 'does not move one unit to east' do
        subject.place(Position.new(4, 2), 'EAST')
        subject.move
        expect(subject.report).to eq '4,2,EAST'
      end

      it 'does not move one unit to south' do
        subject.place(Position.new(2, 0), 'SOUTH')
        subject.move
        expect(subject.report).to eq '2,0,SOUTH'
      end

      it 'does not move one unit to west' do
        subject.place(Position.new(0, 2), 'WEST')
        subject.move
        expect(subject.report).to eq '0,2,WEST'
      end
    end
  end

  describe '#left' do
    before do
      subject.place(Position.new(2, 2), 'NORTH')
    end

    it 'sets new direction' do
      subject.left
      expect(subject.report).to eq '2,2,WEST'
    end

    it 'returns new direction' do
      expect(subject.left).to eq 'WEST'
    end
  end

  describe '#right' do
    before do
      subject.place(Position.new(2, 2), 'NORTH')
    end

    it 'sets new direction' do
      subject.right
      expect(subject.report).to eq '2,2,EAST'
    end

    it 'returns new direction' do
      expect(subject.right).to eq 'EAST'
    end
  end

  describe '#report' do
    context 'when robot has a place' do
      it 'returns report of the place' do
        subject.place(Position.new(1, 3), 'EAST')
        expect(subject.report).to eq '1,3,EAST'
      end
    end

    context 'when robot does not have a place' do
      it 'returns nil' do
        expect(subject.report).to be_nil
      end
    end
  end
end
