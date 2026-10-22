Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D325606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 03:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJjQR-0003qE-8M; Wed, 21 Oct 2026 23:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1xJjQO-0003ms-Pg
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 23:25:04 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1xJjQM-0000B4-LO
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 23:25:04 -0400
Received: from loongson.cn (unknown [10.20.42.166])
 by gateway (Coremail) with SMTP id _____8DxTNIMgtlqPUYYAA--.4909S3;
 Thu, 22 Oct 2026 11:25:00 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJCxPs8LgtlqcA0vAA--.32589S2;
 Thu, 22 Oct 2026 11:25:00 +0800 (CST)
Subject: Re: [PATCH 3/3] target/loongarch: Replace address_space_ldq_le ->
 cpu_ldq_le_mmuidx_ra in loongarch_ptw
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <17746591750@163.com>
Cc: qemu-devel@nongnu.org, SignKirigami <prcups@krgm.moe>
References: <20261013032841.2482079-1-maobibo@loongson.cn>
 <20261013032841.2482079-4-maobibo@loongson.cn>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <2377a63d-80f3-1acb-480f-43b8f6322015@loongson.cn>
Date: Thu, 22 Oct 2026 11:23:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261013032841.2482079-4-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJCxPs8LgtlqcA0vAA--.32589S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCFWxZr1xAFyDWrW7GryfGrX_yoWrWFW3pF
 Z3Ar1ftr1rtFy5C3ZrZanFyFn5Cwn5Kw47Wayjk3sYkr98Wrn2v3yjk3sFvFyDA3yxWw1j
 qF4UAFs8uFW7XagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8xOz3UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.689,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by:  Xianglai Li <lixianglai@loongson.cn>


> In function loongarch_ptw(), page table entry is accessed with physical
> address, so it is similar with DA mode. Replace API address_space_ldq_le()
> with cpu_ldq_le_mmuidx_ra(), and mmu_idx is MMU_DA_IDX rather than
> current CPU running mode, since there is QEMU CPU TLB with the latter API.
> And in future if LVZ is supported, the latter API will call the second MMU
> page table walk.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu_helper.c | 60 ++++++++---------------------------
>   1 file changed, 13 insertions(+), 47 deletions(-)
>
> diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
> index 8a4f8ebc4d..d1d66742d8 100644
> --- a/target/loongarch/cpu_helper.c
> +++ b/target/loongarch/cpu_helper.c
> @@ -7,10 +7,11 @@
>    */
>   
>   #include "qemu/osdep.h"
> -#include "system/memory.h"
>   #include "system/tcg.h"
>   #include "cpu.h"
>   #include "accel/tcg/cpu-mmu-index.h"
> +#include "accel/tcg/cpu-ldst.h"
> +#include "accel/tcg/getpc.h"
>   #include "exec/page-protection.h"
>   #include "exec/target_page.h"
>   #include "internals.h"
> @@ -111,55 +112,18 @@ TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
>       return TLBRET_MATCH;
>   }
>   
> -static MemTxResult loongarch_cmpxchg_phys(CPUState *cs, hwaddr phys,
> -                                          uint64_t old, uint64_t new)
> -{
> -    hwaddr addr1, l = 8;
> -    MemoryRegion *mr;
> -    uint8_t *ram_ptr;
> -    uint64_t old1;
> -    MemTxResult ret;
> -
> -    rcu_read_lock();
> -    mr = address_space_translate(cs->as, phys, &addr1, &l,
> -                                 false, MEMTXATTRS_UNSPECIFIED);
> -    if (!memory_region_is_ram(mr)) {
> -        /*
> -         * Misconfigured PTE in ROM (AD bits are not preset) or
> -         * PTE is in IO space and can't be updated atomically.
> -         */
> -         rcu_read_unlock();
> -         return MEMTX_ACCESS_ERROR;
> -    }
> -
> -    ram_ptr = qemu_map_ram_ptr(mr->ram_block, addr1);
> -    old1 = qatomic_cmpxchg((uint64_t *)ram_ptr, cpu_to_le64(old),
> -                           cpu_to_le64(new));
> -    old1 = le64_to_cpu(old1);
> -    if (old1 == old) {
> -        ret = MEMTX_OK;
> -    } else {
> -        ret = MEMTX_DECODE_ERROR;
> -    }
> -    rcu_read_unlock();
> -
> -    return ret;
> -}
> -
>   TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
>                        int access_type, int mmu_idx, int debug)
>   {
> -    const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
> -    CPUState *cs = env_cpu(env);
>       hwaddr index = 0, phys = 0;
>       uint64_t palen_mask = loongarch_palen_mask(env);
>       uint64_t dir_base, dir_width;
> -    uint64_t base, pte;
> -    int level;
> +    uint64_t base, pte, old;
> +    int level, ptw_idx = MMU_DA_IDX;
>       vaddr address;
>       TLBRet ret;
> -    MemTxResult ret1;
>       CPUSysState *sys = env_sys(env);
> +    MemOpIdx oi;
>   
>       address = context->addr;
>       if ((address >> 63) & 0x1) {
> @@ -179,7 +143,7 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
>           /* get next level page directory */
>           index = (address >> dir_base) & ((1 << dir_width) - 1);
>           phys = base | index << 3;
> -        base = address_space_ldq_le(cs->as, phys, attrs, NULL);
> +        base = cpu_ldq_le_mmuidx_ra(env, phys, ptw_idx, GETPC());
>           if (level) {
>               if (FIELD_EX64(base, TLBENTRY, HUGE)) {
>                   /* base is a huge pte */
> @@ -213,8 +177,8 @@ restart:
>   
>           index &= 1;
>           context->pte_buddy[index] = base;
> -        val = address_space_ldq_le(cs->as, phys + 8 * (1 - 2 * index),
> -                                   attrs, NULL);
> +        val = cpu_ldq_le_mmuidx_ra(env, phys + 8 * (1 - 2 * index),
> +                                   ptw_idx, GETPC());
>           context->pte_buddy[1 - index] = val;
>       }
>   
> @@ -244,10 +208,12 @@ restart:
>           if (access_type == MMU_DATA_STORE) {
>               base = pte_mkdirty(base);
>           }
> -        ret1 = loongarch_cmpxchg_phys(cs, phys, pte, base);
> +
> +        oi = make_memop_idx(MO_LEUQ | MO_64, ptw_idx);
> +        old = cpu_atomic_cmpxchgq_le_mmu(env, phys, pte, base, oi, GETPC());
>           /* PTE updated by other CPU, reload PTE entry */
> -        if (ret1 == MEMTX_DECODE_ERROR) {
> -            base = address_space_ldq_le(cs->as, phys, attrs, NULL);
> +        if (le64_to_cpu(old) != pte) {
> +            base = cpu_ldq_le_mmuidx_ra(env, phys, ptw_idx, GETPC());
>               goto restart;
>           }
>   


