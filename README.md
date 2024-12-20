# fintech-solidity-test

```
project/
├── src/
│   └── SimpleWallet.sol # контракт для теста
├── test/
│   └── SimpleWallet.t.sol # файл с тестом
├── lib/
│   └── forge-std/
├── foundry.toml # конфиг
```

1. Первым этапом необходимо было установить [Rust](https://www.rust-lang.org/learn/get-started) (Git Bash уже был установлен)
2. Следуя [Инструкции](https://book.getfoundry.sh/getting-started/installation#using-foundryup) выполняем следующие команды:
```
# clone the repository
git clone https://github.com/foundry-rs/foundry.git
cd foundry
# install Forge
cargo install --path ./crates/forge --profile release --force --locked
# install Cast
cargo install --path ./crates/cast --profile release --force --locked
# install Anvil
cargo install --path ./crates/anvil --profile release --force --locked
# install Chisel
cargo install --path ./crates/chisel --profile release --force --locked
```
Если работаем в VSCode, устанавливаем расширения:
[Solidity (Wake)](https://marketplace.visualstudio.com/items?itemName=AckeeBlockchain.tools-for-solidity)
и [solidity](https://marketplace.visualstudio.com/items?itemName=JuanBlanco.solidity)
для проверки синтаксиса, возможности деплоя контрактов и вывода логов об ошибках.

Если lib не подтягивается автоматически, нужно выполнить следующие команды в терминале VSCode:
```
git add .
git commit -m "Initial commit"
forge install foundry-rs/forge-std
```

Для очистки сборки проекта можно использовать
`forge clean`

Для повторной сборки использовать
`forge build`

В файле SampleWallet.t.sol

- В src/ лежит контракт с кошельком
- В test/ лежит файл с тестами
- В cache/ лежат логи по результатам тестирования

Для запуска теста используется терминальная команда

`forge test`
