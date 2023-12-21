class Lotto
    attr_accessor :lotto_numbers

    def lotto_create_number
        @lotto_numbers = (1..45).to_a.sample(6).sort
    end
end

class User
    attr_accessor :money, :user_lotto_numbers

    def initialize
        @money = 0
        @user_lotto_numbers = []
    end

    def user_greet
        puts "---lotto店へようこそ           ---"
        puts "---1.       lotto購買         ---"
        puts "---2.       終了              ---"
        print "入力 1 or 2 : "
        select_user = gets.chomp.to_i

        if select_user == 1
            user_by_lotto
        elsif select_user == 2
            puts "lottoプロクラムを終了します.."
        else
            puts "間違った入力です.."
        end
    end

    def user_by_lotto
        print "\n購買するLotto金額を入力してください : "
        input_money = gets.chomp.to_i

        if input_money.between?(100, 20000)
            @money = input_money
            lotto_price = 100
            @lotto_count = @money / lotto_price
            puts "#{@money}円で #{@lotto_count}回を購入しました。\n"
            user_lotto_confirmation
        elsif input_money == 3
            puts "lottoプロクラムを終了します.."
        else
            puts "100円以上、 20000円以下で購入してください!"
        end
    end

    def user_lotto_confirmation
        com_lotto = ComLotto.new()
        confirmation = Confirmation.new(self, com_lotto)

        while true
            puts "\n---お買い上げのロト#{@lotto_count}回---"
            puts "---1. 自分のロトの番号を確認     ---"
            puts "---2.      当せん 確認          ---"
            puts "---3.      プロクラムを終了      ---"
            print "入力 1, 2, 3 : "
            choice = gets.chomp.to_i
            
            puts "\n"
            case choice
            when 1
                @lotto_count.times do |i|
                    lotto = Lotto.new()
                    lotto.lotto_create_number
                    @user_lotto_numbers << lotto.lotto_numbers
                    puts "#{i+1}番のロト : #{lotto.lotto_numbers}"
                end
            when 2
                com_lotto.com_lotto
                confirmation.check_winnig
            when 3
                puts "--プロクラムを終了します--"
                break
            else
                puts "間違った入力です。 もう一度試してください.."
            end
        end
    end
end

class LottoMachine
    
end

class ComLotto
    attr_accessor :com_lotto_numbers

    def initialize
        @com_lotto_numbers = (1..45).to_a.sample(6).sort
    end

    def com_lotto
        puts "\n--今週の当せん番号--"
        puts "#{@com_lotto_numbers}"
    end
end

class Confirmation

    def initialize(user, com_lotto)
        @user = user
        @com_lotto = com_lotto
    end

    def check_winnig
           winning_numbers = @com_lotto.com_lotto_numbers
           @user.user_lotto_numbers.each_with_index do |lotto_numbers, index|
                matched_number = lotto_numbers & winning_numbers
                case matched_number.size
                when 6
                    puts "#{index + 1}番のLotto番号 #{lotto_numbers} : 1位! 20億円"
                when 5
                    puts "#{index + 1}番のLotto番号 #{lotto_numbers} : 2位! 5000千万円"
                when 4
                    puts "#{index + 1}番のLotto番号 #{lotto_numbers} : 3位! 2000千万円"
                when 3
                    puts "#{index + 1}番のLotto番号 #{lotto_numbers} : 4位! 5000万円"
                when 2
                    puts "#{index + 1}番のLotto番号 #{lotto_numbers} : 5位! 500円"
                else
                    puts "#{index + 1}番のLotto番号 #{lotto_numbers} : すみません..ㅠㅠ"
                end
           end
    end
end

user = User.new()
user.user_greet