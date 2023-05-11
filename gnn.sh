#!/bin/bash -e
pushd arbitor
EXP=5  MANTISSA=1  F_OR_P=emu_float ACC=cus_acc SUBNORMAL=_subnormal bash ./expr_manual.sh gnn
EXP=6  MANTISSA=1  F_OR_P=emu_float ACC=cus_acc SUBNORMAL=_subnormal bash ./expr_manual.sh gnn
EXP=7  MANTISSA=1  F_OR_P=emu_float ACC=cus_acc SUBNORMAL=_subnormal bash ./expr_manual.sh gnn
EXP=8  MANTISSA=1  F_OR_P=emu_float ACC=cus_acc SUBNORMAL=_subnormal bash ./expr_manual.sh gnn
EXP=5  MANTISSA=3  F_OR_P=emu_float ACC=cus_acc SUBNORMAL=_subnormal bash ./expr_manual.sh gnn
EXP=6  MANTISSA=3  F_OR_P=emu_float ACC=cus_acc SUBNORMAL=_subnormal bash ./expr_manual.sh gnn
EXP=7  MANTISSA=3  F_OR_P=emu_float ACC=cus_acc SUBNORMAL=_subnormal bash ./expr_manual.sh gnn
EXP=8  MANTISSA=3  F_OR_P=emu_float ACC=cus_acc SUBNORMAL=_subnormal bash ./expr_manual.sh gnn
EXP=5  MANTISSA=5  F_OR_P=emu_float ACC=cus_acc SUBNORMAL=_subnormal bash ./expr_manual.sh gnn
EXP=5  MANTISSA=7  F_OR_P=emu_float ACC=cus_acc SUBNORMAL=_subnormal bash ./expr_manual.sh gnn
popd

echo ""
pushd  /root/emulation/new_results/cus_acc/gnn

cp 1_6_3 1_6_5
cp 1_6_3 1_6_7
cp 1_7_3 1_7_5
cp 1_7_3 1_7_5
cp 1_8_3 1_8_5
cp 1_8_3 1_8_7


mkdir -p /root/results
function get_acc {
    name=$(basename $1)
    line=$(tail -n 1 $1)
    acc=$(awk -v num="$line" 'BEGIN{printf "%.2f", num * 100}')
    IFS="_" read -r sign exp mant <<< "$name"
    echo "$exp, $mant, $acc" >> /root/results/sens.csv
}
for file in /root/emulation/new_results/cus_acc/gnn/*
do 
    get_acc "$file"
done

popd