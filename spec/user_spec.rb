require 'user'

describe '.create' do
  it 'creates a new user' do
    user = User.create(email: 'test@gmail.com', password: 'password12')

    expect(user).to be_a User
    expect(user.email).to eq 'test@gmail.com'
  end

    it 'hashes the password using BCrypt' do
      expect(BCrypt::Password).to receive(:create).with('password12')
  
      User.create(email: 'test@gmail.com', password: 'password12')
    end

end

describe '.find' do
  it 'finds a user by ID' do
    user = User.create(email: 'test@gmail.com', password: 'password12')
    result = User.find(user.id)

    expect(result.id).to eq user.id
    expect(result.email).to eq user.email
  end

end

describe '.authenticate' do
  it 'returns a user given a correct email and password, if one exists' do
    user = User.create(email: 'test@gmail.com', password: 'password12')
    
    authenticated_user = User.authenticate('test@gmail.com', 'password12')

    expect(authenticated_user.id).to eq user.id
  end

  it 'returns nil given an incorrect email' do
    user = User.create(email: 'test@gmail.com', password: 'password123')

    expect(User.authenticate('incorrectemail', 'password123')).to be_nil
  end

  it 'returns nil given an incorrect password' do
    user = User.create(email: 'test@gmail.com', password: 'password12')

    expect(User.authenticate('test@gmail.com', 'password123')).to be_nil
  end

end
