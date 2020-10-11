require 'rails_helper'

describe 'タスク管理機能' do
  let(:user_a) {FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')}
  let(:user_b) {FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com')}
  let(:login_user) {
    # Userインスタンス 実際には各テストケースのなかでlogin_userにuserが代入される
  }
  let!(:task_a) {FactoryBot.create(:task, name: 'さいしょのタスク', user: user_a)}

  before do
    visit login_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログインする'
  end

  describe '一覧表示' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) {user_a}

      it 'ユーザーAが作成したタスクが表示される' do
        expect(page).to have_content task_a.name
      end
    end

    context 'ユーザーBがログインしているとき' do
      let(:login_user) {user_b}

      it 'ユーザーAのタスクが表示されない' do
        expect(page).not_to have_content task_a.name
      end
    end
  end

  describe '詳細表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) {user_a}

      before do
        visit task_path(task_a)
      end

      it 'ユーザーAの作成したタスクAが表示される' do
        expect(page).to have_content task_a.name
      end
    end
  end
end