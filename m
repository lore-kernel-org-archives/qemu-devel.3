Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D2FD10377
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 03:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vO6YV-0003T7-Bm; Tue, 25 Nov 2025 22:50:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1vO6YS-0003SV-Rz
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 22:50:56 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1vO6YP-0003Qv-NA
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 22:50:56 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Dx_78QeSZpwisoAA--.20917S3;
 Wed, 26 Nov 2025 11:50:40 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJBxTMEEeSZpyZ0_AQ--.49029S3;
 Wed, 26 Nov 2025 11:50:37 +0800 (CST)
Subject: Re: [PATCH v2 0/7] Add LoongArch v1.1 instructions
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, git@xen0n.name,
 bibo mao <maobibo@loongson.cn>
References: <20251119122822.1513788-1-c@jia.je>
From: gaosong <gaosong@loongson.cn>
Message-ID: <613a7dfa-c3f4-092b-3938-dc41f6fd3812@loongson.cn>
Date: Wed, 26 Nov 2025 11:50:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20251119122822.1513788-1-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJBxTMEEeSZpyZ0_AQ--.49029S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAFWUKF1rGryDXFyDJryUXFc_yoWrtFyxpF
 ZIkrn8Ka18Ja93urs7Z3ZxJF1aqF1xGry8uF9xtasayw4aqFy8tFn7Za92qFykCw4qg342
 qFy0yw15XFyDZacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8j-e5UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.052,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

在 2025/11/19 下午8:24, Jiajie Chen 写道:
> Latest revision of LoongArch ISA is out at
> https://www.loongson.cn/uploads/images/2023102309132647981.%E9%BE%99%E8%8A%AF%E6%9E%B6%E6%9E%84%E5%8F%82%E8%80%83%E6%89%8B%E5%86%8C%E5%8D%B7%E4%B8%80_r1p10.pdf
> (Chinese only). The revision includes the following updates:
>
> - estimated fp reciporcal instructions: frecip -> frecipe, frsqrt ->
>    frsqrte
> - 128-bit width store-conditional instruction: sc.q
> - ll.w/d with acquire semantic: llacq.w/d, sc.w/d with release semantic:
>    screl.w/d
> - compare and swap instructions: amcas[_db].b/w/h/d
> - byte and word-wide amswap/add instructions: am{swap/add}[_db].{b/h}
> - new definition for dbar hints
> - clarify 32-bit division instruction hebavior
> - clarify load ordering when accessing the same address
> - introduce message signaled interrupt
> - introduce hardware page table walker
>
> The new revision is implemented in the Loongson 3A6000 processor.
>
> This patch series implements all the new instructions. The v1 version
> can be found at
> https://patchew.org/QEMU/20231023153029.269211-2-c@jia.je/.
>
> A simple testcase to test the new fp and sc.q instructions:
>
> #include <assert.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
>
> void test_fp() {
>    float a = 3.0;
>    float b;
>
>    asm volatile("frecip.s %0, %1" : "=f"(b) : "f"(a));
>    printf("frecip: %f\n", b);
>    asm volatile("frecipe.s %0, %1" : "=f"(b) : "f"(a));
>    printf("frecipe: %f\n", b);
>
>    asm volatile("frsqrt.s %0, %1" : "=f"(b) : "f"(a));
>    printf("frsqrt: %f\n", b);
>    asm volatile("frsqrte.s %0, %1" : "=f"(b) : "f"(a));
>    printf("frsqrte: %f\n", b);
> }
>
> uint64_t rand64() { return ((uint64_t)rand() << 32) | rand(); }
>
> void test_sc_q() {
>    __int128 val = rand64();
>    val = (val << 64) | rand64();
>    __int128 *ptr = &val;
>    uint64_t add_lo = rand64();
>    uint64_t add_hi = rand64();
>    __int128 add = add_hi;
>    add = (add << 64) | add_lo;
>    __int128 expect = val + add;
>    int res = 0;
>
>    asm volatile("ll.d $t1, %1, 0\nld.d $t2, %1, 8\nadd.d $t1, $t1, %2\nadd.d "
>                 "$t2, $t2, %3\nsc.q $t1, $t2, %1\nmove %0, $t1"
>                 : "=r"(res), "+r"(ptr)
>                 : "r"(add_lo), "r"(add_hi)
>                 : "$t1", "$t2", "memory");
>    assert(res == 1);
>    assert(val == expect);
>
>    // change memory content to make sc fail
>    res = 1;
>    asm volatile("ll.d $t1, %1, 0\nld.d $t2, %1, 8\naddi.d $t1, $t1, 1\nst.d "
>                 "$t1, %1, 0\nsc.q $t1, $t2, %1\nmove %0, $t1"
>                 : "=r"(res), "+r"(ptr)
>                 :
>                 : "$t1", "$t2", "memory");
>    assert(res == 0);
>
>    res = 1;
>    asm volatile("ll.d $t1, %1, 0\nld.d $t2, %1, 8\naddi.d $t2, $t2, 1\nst.d "
>                 "$t2, %1, 8\nsc.q $t1, $t2, %1\nmove %0, $t1"
>                 : "=r"(res), "+r"(ptr)
>                 :
>                 : "$t1", "$t2", "memory");
>    assert(res == 0);
>
>    printf("SC.Q passed\n");
> }
>
> int main(int argc, char *argv[]) {
>    test_fp();
>    test_sc_q();
>    return 0;
> }
>
> Compile and test by:
>
> loongarch64-linux-gnu-gcc test.c -o test -static && ./qemu-loongarch64 -cpu max test
Hi,
I run this test with qemu on x86  and loongarch machine.
but the results is not same.
on x86
gaosong@fedora:/home1/gaosong/work/clean/qemu$ ./build/qemu-loongarch64 
-cpu max test
  frecip: 0.333333
frecipe: 0.333333
frsqrt: 0.577350
frsqrte: 0.577350
SC.Q passed

on Loongson-3C6000/D
[root@localhost gs]# ./test
frecip: 0.333333
frecipe: 0.333332
frsqrt: 0.577350
frsqrte: 0.577345
test: test.c:49: test_sc_q: Assertion `res == 0' failed.
Aborted (core dumped)

1. The results from frecipe/frsqrte differ from those on the physical machine. Is this due to precision issues?
    Should we align with the physical precision? Or can we disregard this discrepancy?
2. sc.q—I haven't identified the issue yet.


Thanks.
Song Gao
> Jiajie Chen (7):
>    target/loongarch: Require atomics to be aligned
>    target/loongarch: Add am{swap/add}[_db].{b/h}
>    target/loongarch: Add amcas[_db].{b/h/w/d}
>    target/loongarch: Add estimated reciprocal instructions
>    target/loongarch: Add llacq/screl instructions
>    target/loongarch: Add sc.q instructions
>    target/loongarch: Add LA v1.1 instructions to max cpu
>
>   target/loongarch/cpu.c                        |  11 +-
>   target/loongarch/cpu.h                        |   7 +
>   target/loongarch/disas.c                      |  33 ++++
>   target/loongarch/insns.decode                 |  34 ++++
>   .../tcg/insn_trans/trans_atomic.c.inc         | 145 ++++++++++++++++--
>   .../tcg/insn_trans/trans_farith.c.inc         |   4 +
>   .../tcg/insn_trans/trans_memory.c.inc         |  22 +++
>   .../loongarch/tcg/insn_trans/trans_vec.c.inc  |   8 +
>   target/loongarch/tcg/translate.c              |   6 +-
>   target/loongarch/translate.h                  |  30 ++--
>   10 files changed, 280 insertions(+), 20 deletions(-)
>


