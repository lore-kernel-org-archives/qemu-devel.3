Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A71EB28D9
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 07:39:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voGR8-0005Ed-Sg; Fri, 06 Feb 2026 02:39:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1voGR5-0005ES-Rh
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 02:39:27 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1voGR2-0002u8-Dc
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 02:39:27 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxnsOcmoVpoGgQAA--.53273S3;
 Fri, 06 Feb 2026 15:39:08 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJBxSeCWmoVpAd9AAA--.55899S3;
 Fri, 06 Feb 2026 15:39:05 +0800 (CST)
Subject: Re: [PATCH v2 0/7] Add LoongArch v1.1 instructions
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, git@xen0n.name, wangliupu@loongson.cn,
 bibo mao <maobibo@loongson.cn>
References: <20251119122822.1513788-1-c@jia.je>
From: gaosong <gaosong@loongson.cn>
Message-ID: <98c32742-a116-48a6-f015-6f72d0e7be4e@loongson.cn>
Date: Fri, 6 Feb 2026 15:40:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20251119122822.1513788-1-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJBxSeCWmoVpAd9AAA--.55899S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxtw4kurW8CrW8Kw1DZry8tFc_yoW3WF1xpF
 WSkrn8GrW8tr4xGr1xXa4jvFyUtr4xG3WUJFy7ta4qy3yYqFWqqr18W3sFgF1UCw40gr1U
 XFyUAw48ZF4DXFbCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU24So
 DUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.384,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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
hi, jiajie,

This method will not cause scfail.According to the manual
https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.pdf　2.2.7.4  <https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.pdf%E3%80%802.2.7.4>
During the execution of the paired LLSC, the following events will clear the LLbit to 0:
• The ERTN instruction is executed and the KL0 bit in CSR.LLBCTL is not equal to 1 when executed;
•*Other processor cores*  or Cache Coherent I/O masters perform a*store*  operation on the Cache line
where the address corresponding to the LLbit is located.

I conducted a multithreaded test where one thread continuously performed ll/sc operations,
while another thread persistently wrote to this tag address. The test results aligned with
expectations and matched the physical outcomes.

so,
For thie series
Reviewed-by: Song Gao <gaosong@loongson.cn>

if you don't have time to rebase the code ,I can do it.

here my test code.  test on tcg system model.

#define _GNU_SOURCE
#include <stdio.h>
#include <stdint.h>
#include <pthread.h>
#include <unistd.h>
#include <time.h>

typedef struct {
     volatile uint64_t low __attribute__((aligned(16)));
     volatile uint64_t high;
} aligned_uint128_t;

aligned_uint128_t shared;
volatile int running = 1;
volatile  long long success = 0;
volatile  long long fail = 0;

void* thread_a(void* arg) {

     int result;

     long long last_success = 0;
     long long last_fail = 0;
     time_t last_time = time(NULL);

     while (running) {
         asm volatile(
             "1:\n\t"
             "ll.d $t0, %1, 0\n\t"
             "ld.d $t1, %1, 8\n\t"
             "addi.d $t0, $t0, 1\n\t"
             "sc.q $t0, $t1, %1\n\t"
             "move %0, $t0"
             : "=r"(result)
             : "r"(&shared)
             : "$t0", "$t1", "memory"
         );

         if (result == 1) {
             success++;
         } else {
             fail++;
         }
     }
     return NULL;
}

void* thread_b(void* arg) {
     uint64_t val = 0;
     while (running) {
         shared.low = val;
         shared.high = ~val;
         asm volatile("" ::: "memory");
         val++;
     }

     return NULL;
}

void* thread_c(void* arg) {
     int i=0;
     while (i < 11) {
     i++;
         sleep(1);
         printf("Thread C llsc success[%lld] fail[%lld]\n", success, fail);
     }
     running =0;
     return NULL;
}

int main() {
     printf("===  Test - Should see both fail and success ===\n");

     printf("Shared address: %p\n", (void*)&shared);
     printf("Alignment check: %s\n",
            ((uintptr_t)&shared % 16 == 0) ? "16-byte aligned" : "NOT 
aligned");

     shared.low = 0x1111111111111111ULL;
     shared.high = 0x2222222222222222ULL;

     pthread_t ta, tb, tc;
     pthread_create(&tc, NULL, thread_c, NULL);
     printf("Thread C started\n");
     usleep(2);
     pthread_create(&tb, NULL, thread_b, NULL);
     printf("Thread B started\n");
     usleep(2);
     pthread_create(&ta, NULL, thread_a, NULL);
     printf("Thread A started\n");
     pthread_join(ta, NULL);
     sleep(2);
     pthread_join(tb, NULL);
     pthread_join(tc, NULL);
     printf("Final value: low=0x%lx, high=0x%lx\n", shared.low, 
shared.high);
     printf("=== Test End ===\n");

     return 0;
}


Thanks.
Song Gao
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
>
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


