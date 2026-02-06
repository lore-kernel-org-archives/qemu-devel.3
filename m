Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272F2EB28E2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 08:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voGxA-0003Jh-LA; Fri, 06 Feb 2026 03:12:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1voGx9-0003JZ-EX
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 03:12:35 -0500
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1voGx7-0007up-85
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 03:12:35 -0500
Received: from [10.22.1.213] (unknown [124.195.210.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 1B5EF421D7C;
 Fri,  6 Feb 2026 08:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1770365544; bh=TC6f5xSSw7a7Q4UurTCVman669Hkzk1k7canGGHz1F0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Ok2yTO1HU2koovlOYLBlyL9+Sm86sEfeSsYSBAekMvMlrJ23J7QWlF1A3NBkrClJj
 Eqn3h+LrjrqYE5+uAf8II5rL50R2cKq0A5d2URrr2CM23aF2LGLfiPNzgzJDr6Vw9P
 4JRXZpgArUWAxHebNTe9lw0DrClR+SLf71qcBxjU=
Message-ID: <f3bb434d-1bf0-44d9-ad6e-4386cc2eb540@jia.je>
Date: Fri, 6 Feb 2026 13:11:38 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Add LoongArch v1.1 instructions
To: gaosong <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, git@xen0n.name, wangliupu@loongson.cn,
 bibo mao <maobibo@loongson.cn>
References: <20251119122822.1513788-1-c@jia.je>
 <98c32742-a116-48a6-f015-6f72d0e7be4e@loongson.cn>
Content-Language: en-US
From: Jiajie Chen <c@jia.je>
In-Reply-To: <98c32742-a116-48a6-f015-6f72d0e7be4e@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: 22
X-Spam_score: 2.2
X-Spam_bar: ++
X-Spam_report: (2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

Comments below.

On 2026/2/6 15:40, gaosong wrote:
> 在 2025/11/19 下午8:24, Jiajie Chen 写道:
>> Latest revision of LoongArch ISA is out at
>> https://www.loongson.cn/uploads/images/2023102309132647981.%E9%BE%99%E8%8A%AF%E6%9E%B6%E6%9E%84%E5%8F%82%E8%80%83%E6%89%8B%E5%86%8C%E5%8D%B7%E4%B8%80_r1p10.pdf 
>>
>> (Chinese only). The revision includes the following updates:
>>
>> - estimated fp reciporcal instructions: frecip -> frecipe, frsqrt ->
>>    frsqrte
>> - 128-bit width store-conditional instruction: sc.q
>> - ll.w/d with acquire semantic: llacq.w/d, sc.w/d with release semantic:
>>    screl.w/d
>> - compare and swap instructions: amcas[_db].b/w/h/d
>> - byte and word-wide amswap/add instructions: am{swap/add}[_db].{b/h}
>> - new definition for dbar hints
>> - clarify 32-bit division instruction hebavior
>> - clarify load ordering when accessing the same address
>> - introduce message signaled interrupt
>> - introduce hardware page table walker
>>
>> The new revision is implemented in the Loongson 3A6000 processor.
>>
>> This patch series implements all the new instructions. The v1 version
>> can be found at
>> https://patchew.org/QEMU/20231023153029.269211-2-c@jia.je/.
>>
>> A simple testcase to test the new fp and sc.q instructions:
>>
>> #include <assert.h>
>> #include <stdint.h>
>> #include <stdio.h>
>> #include <stdlib.h>
>>
>> void test_fp() {
>>    float a = 3.0;
>>    float b;
>>
>>    asm volatile("frecip.s %0, %1" : "=f"(b) : "f"(a));
>>    printf("frecip: %f\n", b);
>>    asm volatile("frecipe.s %0, %1" : "=f"(b) : "f"(a));
>>    printf("frecipe: %f\n", b);
>>
>>    asm volatile("frsqrt.s %0, %1" : "=f"(b) : "f"(a));
>>    printf("frsqrt: %f\n", b);
>>    asm volatile("frsqrte.s %0, %1" : "=f"(b) : "f"(a));
>>    printf("frsqrte: %f\n", b);
>> }
>>
>> uint64_t rand64() { return ((uint64_t)rand() << 32) | rand(); }
>>
>> void test_sc_q() {
>>    __int128 val = rand64();
>>    val = (val << 64) | rand64();
>>    __int128 *ptr = &val;
>>    uint64_t add_lo = rand64();
>>    uint64_t add_hi = rand64();
>>    __int128 add = add_hi;
>>    add = (add << 64) | add_lo;
>>    __int128 expect = val + add;
>>    int res = 0;
>>
>>    asm volatile("ll.d $t1, %1, 0\nld.d $t2, %1, 8\nadd.d $t1, $t1, 
>> %2\nadd.d "
>>                 "$t2, $t2, %3\nsc.q $t1, $t2, %1\nmove %0, $t1"
>>                 : "=r"(res), "+r"(ptr)
>>                 : "r"(add_lo), "r"(add_hi)
>>                 : "$t1", "$t2", "memory");
>>    assert(res == 1);
>>    assert(val == expect);
>>
>>    // change memory content to make sc fail
> hi, jiajie,
>
> This method will not cause scfail.According to the manual
> https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.pdf　2.2.7.4 
> <https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.pdf%E3%80%802.2.7.4> 
>
> During the execution of the paired LLSC, the following events will 
> clear the LLbit to 0:
> • The ERTN instruction is executed and the KL0 bit in CSR.LLBCTL is 
> not equal to 1 when executed;
> •*Other processor cores*  or Cache Coherent I/O masters perform 
> a*store*  operation on the Cache line
> where the address corresponding to the LLbit is located.
>
> I conducted a multithreaded test where one thread continuously 
> performed ll/sc operations,
> while another thread persistently wrote to this tag address. The test 
> results aligned with
> expectations and matched the physical outcomes.
>
> so,
> For thie series
> Reviewed-by: Song Gao <gaosong@loongson.cn>
>
> if you don't have time to rebase the code ,I can do it.


Yes, please, I am on vacation. Looking forward to it getting merged.


>
> here my test code.  test on tcg system model.
>
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <stdint.h>
> #include <pthread.h>
> #include <unistd.h>
> #include <time.h>
>
> typedef struct {
>     volatile uint64_t low __attribute__((aligned(16)));
>     volatile uint64_t high;
> } aligned_uint128_t;
>
> aligned_uint128_t shared;
> volatile int running = 1;
> volatile  long long success = 0;
> volatile  long long fail = 0;
>
> void* thread_a(void* arg) {
>
>     int result;
>
>     long long last_success = 0;
>     long long last_fail = 0;
>     time_t last_time = time(NULL);
>
>     while (running) {
>         asm volatile(
>             "1:\n\t"
>             "ll.d $t0, %1, 0\n\t"
>             "ld.d $t1, %1, 8\n\t"
>             "addi.d $t0, $t0, 1\n\t"
>             "sc.q $t0, $t1, %1\n\t"
>             "move %0, $t0"
>             : "=r"(result)
>             : "r"(&shared)
>             : "$t0", "$t1", "memory"
>         );
>
>         if (result == 1) {
>             success++;
>         } else {
>             fail++;
>         }
>     }
>     return NULL;
> }
>
> void* thread_b(void* arg) {
>     uint64_t val = 0;
>     while (running) {
>         shared.low = val;
>         shared.high = ~val;
>         asm volatile("" ::: "memory");
>         val++;
>     }
>
>     return NULL;
> }
>
> void* thread_c(void* arg) {
>     int i=0;
>     while (i < 11) {
>     i++;
>         sleep(1);
>         printf("Thread C llsc success[%lld] fail[%lld]\n", success, 
> fail);
>     }
>     running =0;
>     return NULL;
> }
>
> int main() {
>     printf("===  Test - Should see both fail and success ===\n");
>
>     printf("Shared address: %p\n", (void*)&shared);
>     printf("Alignment check: %s\n",
>            ((uintptr_t)&shared % 16 == 0) ? "16-byte aligned" : "NOT 
> aligned");
>
>     shared.low = 0x1111111111111111ULL;
>     shared.high = 0x2222222222222222ULL;
>
>     pthread_t ta, tb, tc;
>     pthread_create(&tc, NULL, thread_c, NULL);
>     printf("Thread C started\n");
>     usleep(2);
>     pthread_create(&tb, NULL, thread_b, NULL);
>     printf("Thread B started\n");
>     usleep(2);
>     pthread_create(&ta, NULL, thread_a, NULL);
>     printf("Thread A started\n");
>     pthread_join(ta, NULL);
>     sleep(2);
>     pthread_join(tb, NULL);
>     pthread_join(tc, NULL);
>     printf("Final value: low=0x%lx, high=0x%lx\n", shared.low, 
> shared.high);
>     printf("=== Test End ===\n");
>
>     return 0;
> }
>
>
> Thanks.
> Song Gao
>>    res = 1;
>>    asm volatile("ll.d $t1, %1, 0\nld.d $t2, %1, 8\naddi.d $t1, $t1, 
>> 1\nst.d "
>>                 "$t1, %1, 0\nsc.q $t1, $t2, %1\nmove %0, $t1"
>>                 : "=r"(res), "+r"(ptr)
>>                 :
>>                 : "$t1", "$t2", "memory");
>>    assert(res == 0);
>>
>>    res = 1;
>>    asm volatile("ll.d $t1, %1, 0\nld.d $t2, %1, 8\naddi.d $t2, $t2, 
>> 1\nst.d "
>>                 "$t2, %1, 8\nsc.q $t1, $t2, %1\nmove %0, $t1"
>>                 : "=r"(res), "+r"(ptr)
>>                 :
>>                 : "$t1", "$t2", "memory");
>>    assert(res == 0);
>>
>>    printf("SC.Q passed\n");
>> }
>>
>> int main(int argc, char *argv[]) {
>>    test_fp();
>>    test_sc_q();
>>    return 0;
>> }
>>
>> Compile and test by:
>>
>> loongarch64-linux-gnu-gcc test.c -o test -static && 
>> ./qemu-loongarch64 -cpu max test
>>
>> Jiajie Chen (7):
>>    target/loongarch: Require atomics to be aligned
>>    target/loongarch: Add am{swap/add}[_db].{b/h}
>>    target/loongarch: Add amcas[_db].{b/h/w/d}
>>    target/loongarch: Add estimated reciprocal instructions
>>    target/loongarch: Add llacq/screl instructions
>>    target/loongarch: Add sc.q instructions
>>    target/loongarch: Add LA v1.1 instructions to max cpu
>>
>>   target/loongarch/cpu.c                        |  11 +-
>>   target/loongarch/cpu.h                        |   7 +
>>   target/loongarch/disas.c                      |  33 ++++
>>   target/loongarch/insns.decode                 |  34 ++++
>>   .../tcg/insn_trans/trans_atomic.c.inc         | 145 ++++++++++++++++--
>>   .../tcg/insn_trans/trans_farith.c.inc         |   4 +
>>   .../tcg/insn_trans/trans_memory.c.inc         |  22 +++
>>   .../loongarch/tcg/insn_trans/trans_vec.c.inc  |   8 +
>>   target/loongarch/tcg/translate.c              |   6 +-
>>   target/loongarch/translate.h                  |  30 ++--
>>   10 files changed, 280 insertions(+), 20 deletions(-)
>>
>

