Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E96C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 04:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXugc-0007vo-8r; Tue, 14 Jan 2025 23:07:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haomiao23s@ict.ac.cn>)
 id 1tXugZ-0007vR-Jz
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 23:07:19 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <haomiao23s@ict.ac.cn>)
 id 1tXugW-0006jY-2o
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 23:07:19 -0500
Received: from [10.170.133.105] (unknown [159.226.43.3])
 by APP-01 (Coremail) with SMTP id qwCowABXXtJnNIdnjnFgBw--.8842S2;
 Wed, 15 Jan 2025 12:07:04 +0800 (CST)
Message-ID: <c7d56bf2-58ba-4d2b-970e-318fe96fffad@ict.ac.cn>
Date: Wed, 15 Jan 2025 12:07:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] feat: add loongarch page table walker support for
 debugger memory access
To: bibo mao <maobibo@loongson.cn>, gaosong@loongson.cn
Cc: qemu-devel@nongnu.org
References: <20250114095444.392579-1-haomiao23s@ict.ac.cn>
 <958deda6-d300-fe6c-d683-172f82c0fbc1@loongson.cn>
Content-Language: en-US
From: Miao Hao <haomiao23s@ict.ac.cn>
In-Reply-To: <958deda6-d300-fe6c-d683-172f82c0fbc1@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowABXXtJnNIdnjnFgBw--.8842S2
X-Coremail-Antispam: 1UD129KBjvJXoW3KFW7Gw4kGF1fJry8urW3KFg_yoWDZw1Upr
 1kArWUJryUGrn5Jr1UJr1UJFyUAr1UJ3WUXr18XFyjyr4UJr10qr1UXr1qgF1UJr48Jw1U
 Jr1UJr1UZF1UJrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUy2b7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
 vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
 Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JV
 WxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I
 3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
 WUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
 wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcI
 k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j
 6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jz5l8UUUUU=
X-Originating-IP: [159.226.43.3]
X-CM-SenderInfo: 5kdrzx1drsj2g6lf3hldfou0/
Received-SPF: pass client-ip=159.226.251.21; envelope-from=haomiao23s@ict.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 2025/1/15 11:20, bibo mao wrote:
> Applied to loongarch-next with small modification with comments such as:
>
> target/loongarch: Add page table walker support for debugger usage
>
> When dump memory content with gva address, software page table walker is
> necessary to get responding gpa address.
>
> Here page table walker is added for debugger usage.
>
> Signed-off-by: Miao Hao <haomiao23s@ict.ac.cn>
>
>
> Regards
> Bibo Mao
>
OK, thanks for your review.


Regards

Miao Hao

>
> On 2025/1/14 下午5:54, Miao Hao wrote:
>> Signed-off-by: Miao Hao <haomiao23s@ict.ac.cn>
>> ---
>>    v1 -> v2:
>>      1. Addressed review comments.
>>      2. Fix the assignment of variable shift.
>>    v2 -> v3:
>>      1. Remove variable shift.
>>
>>   target/loongarch/cpu_helper.c     | 94 +++++++++++++++++++++++++++++--
>>   target/loongarch/internals.h      |  4 +-
>>   target/loongarch/tcg/tlb_helper.c |  4 +-
>>   3 files changed, 94 insertions(+), 8 deletions(-)
>>
>> diff --git a/target/loongarch/cpu_helper.c 
>> b/target/loongarch/cpu_helper.c
>> index 580362ac3e..930466ca48 100644
>> --- a/target/loongarch/cpu_helper.c
>> +++ b/target/loongarch/cpu_helper.c
>> @@ -141,9 +141,85 @@ bool loongarch_tlb_search(CPULoongArchState 
>> *env, target_ulong vaddr,
>>       return false;
>>   }
>>   +static int loongarch_page_table_walker(CPULoongArchState *env, 
>> hwaddr *physical,
>> +                                 int *prot, target_ulong address)
>> +{
>> +    CPUState *cs = env_cpu(env);
>> +    target_ulong index, phys;
>> +    uint64_t dir_base, dir_width;
>> +    uint64_t base;
>> +    int level;
>> +
>> +    if ((address >> 63) & 0x1) {
>> +        base = env->CSR_PGDH;
>> +    } else {
>> +        base = env->CSR_PGDL;
>> +    }
>> +    base &= TARGET_PHYS_MASK;
>> +
>> +    for (level = 4; level > 0; level--) {
>> +        get_dir_base_width(env, &dir_base, &dir_width, level);
>> +
>> +        if (dir_width == 0) {
>> +            continue;
>> +        }
>> +
>> +        /* get next level page directory */
>> +        index = (address >> dir_base) & ((1 << dir_width) - 1);
>> +        phys = base | index << 3;
>> +        base = ldq_phys(cs->as, phys) & TARGET_PHYS_MASK;
>> +        if (FIELD_EX64(base, TLBENTRY, HUGE)) {
>> +            /* base is a huge pte */
>> +            break;
>> +        }
>> +    }
>> +
>> +    /* pte */
>> +    if (FIELD_EX64(base, TLBENTRY, HUGE)) {
>> +        /* Huge Page. base is pte */
>> +        base = FIELD_DP64(base, TLBENTRY, LEVEL, 0);
>> +        base = FIELD_DP64(base, TLBENTRY, HUGE, 0);
>> +        if (FIELD_EX64(base, TLBENTRY, HGLOBAL)) {
>> +            base = FIELD_DP64(base, TLBENTRY, HGLOBAL, 0);
>> +            base = FIELD_DP64(base, TLBENTRY, G, 1);
>> +        }
>> +    } else {
>> +        /* Normal Page. base points to pte */
>> +        get_dir_base_width(env, &dir_base, &dir_width, 0);
>> +        index = (address >> dir_base) & ((1 << dir_width) - 1);
>> +        phys = base | index << 3;
>> +        base = ldq_phys(cs->as, phys);
>> +    }
>> +
>> +    /* TODO: check plv and other bits? */
>> +
>> +    /* base is pte, in normal pte format */
>> +    if (!FIELD_EX64(base, TLBENTRY, V)) {
>> +        return TLBRET_NOMATCH;
>> +    }
>> +
>> +    if (!FIELD_EX64(base, TLBENTRY, D)) {
>> +        *prot = PAGE_READ;
>> +    } else {
>> +        *prot = PAGE_READ | PAGE_WRITE;
>> +    }
>> +
>> +    /* get TARGET_PAGE_SIZE aligned physical address */
>> +    base += (address & TARGET_PHYS_MASK) & ((1 << dir_base) - 1);
>> +    /* mask RPLV, NX, NR bits */
>> +    base = FIELD_DP64(base, TLBENTRY_64, RPLV, 0);
>> +    base = FIELD_DP64(base, TLBENTRY_64, NX, 0);
>> +    base = FIELD_DP64(base, TLBENTRY_64, NR, 0);
>> +    /* mask other attribute bits */
>> +    *physical = base & TARGET_PAGE_MASK;
>> +
>> +    return 0;
>> +}
>> +
>>   static int loongarch_map_address(CPULoongArchState *env, hwaddr 
>> *physical,
>>                                    int *prot, target_ulong address,
>> -                                 MMUAccessType access_type, int 
>> mmu_idx)
>> +                                 MMUAccessType access_type, int 
>> mmu_idx,
>> +                                 int is_debug)
>>   {
>>       int index, match;
>>   @@ -151,6 +227,13 @@ static int 
>> loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
>>       if (match) {
>>           return loongarch_map_tlb_entry(env, physical, prot,
>>                                          address, access_type, index, 
>> mmu_idx);
>> +    } else if (is_debug) {
>> +        /*
>> +         * For debugger memory access, we want to do the map when 
>> there is a
>> +         * legal mapping, even if the mapping is not yet in TLB. 
>> return 0 if
>> +         * there is a valid map, else none zero.
>> +         */
>> +        return loongarch_page_table_walker(env, physical, prot, 
>> address);
>>       }
>>         return TLBRET_NOMATCH;
>> @@ -158,7 +241,8 @@ static int 
>> loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
>>   #else
>>   static int loongarch_map_address(CPULoongArchState *env, hwaddr 
>> *physical,
>>                                    int *prot, target_ulong address,
>> -                                 MMUAccessType access_type, int 
>> mmu_idx)
>> +                                 MMUAccessType access_type, int 
>> mmu_idx,
>> +                                 int is_debug)
>>   {
>>       return TLBRET_NOMATCH;
>>   }
>> @@ -178,7 +262,7 @@ static hwaddr dmw_va2pa(CPULoongArchState *env, 
>> target_ulong va,
>>     int get_physical_address(CPULoongArchState *env, hwaddr *physical,
>>                            int *prot, target_ulong address,
>> -                         MMUAccessType access_type, int mmu_idx)
>> +                         MMUAccessType access_type, int mmu_idx, int 
>> is_debug)
>>   {
>>       int user_mode = mmu_idx == MMU_USER_IDX;
>>       int kernel_mode = mmu_idx == MMU_KERNEL_IDX;
>> @@ -222,7 +306,7 @@ int get_physical_address(CPULoongArchState *env, 
>> hwaddr *physical,
>>         /* Mapped address */
>>       return loongarch_map_address(env, physical, prot, address,
>> -                                 access_type, mmu_idx);
>> +                                 access_type, mmu_idx, is_debug);
>>   }
>>     hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>> @@ -232,7 +316,7 @@ hwaddr loongarch_cpu_get_phys_page_debug(CPUState 
>> *cs, vaddr addr)
>>       int prot;
>>         if (get_physical_address(env, &phys_addr, &prot, addr, 
>> MMU_DATA_LOAD,
>> -                             cpu_mmu_index(cs, false)) != 0) {
>> +                             cpu_mmu_index(cs, false), 1) != 0) {
>>           return -1;
>>       }
>>       return phys_addr;
>> diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
>> index 1a02427627..bc2ca30746 100644
>> --- a/target/loongarch/internals.h
>> +++ b/target/loongarch/internals.h
>> @@ -56,7 +56,9 @@ bool loongarch_tlb_search(CPULoongArchState *env, 
>> target_ulong vaddr,
>>                             int *index);
>>   int get_physical_address(CPULoongArchState *env, hwaddr *physical,
>>                            int *prot, target_ulong address,
>> -                         MMUAccessType access_type, int mmu_idx);
>> +                         MMUAccessType access_type, int mmu_idx, int 
>> is_debug);
>> +void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
>> +                               uint64_t *dir_width, target_ulong 
>> level);
>>   hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>>     #ifdef CONFIG_TCG
>> diff --git a/target/loongarch/tcg/tlb_helper.c 
>> b/target/loongarch/tcg/tlb_helper.c
>> index 97f38fc391..564f336df9 100644
>> --- a/target/loongarch/tcg/tlb_helper.c
>> +++ b/target/loongarch/tcg/tlb_helper.c
>> @@ -18,7 +18,7 @@
>>   #include "exec/log.h"
>>   #include "cpu-csr.h"
>>   -static void get_dir_base_width(CPULoongArchState *env, uint64_t 
>> *dir_base,
>> +void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
>>                                  uint64_t *dir_width, target_ulong 
>> level)
>>   {
>>       switch (level) {
>> @@ -485,7 +485,7 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr 
>> address, int size,
>>         /* Data access */
>>       ret = get_physical_address(env, &physical, &prot, address,
>> -                               access_type, mmu_idx);
>> +                               access_type, mmu_idx, 0);
>>         if (ret == TLBRET_MATCH) {
>>           tlb_set_page(cs, address & TARGET_PAGE_MASK,
>>


