Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D80FC61DC6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 12:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzZU2-0005tc-BN; Thu, 27 Aug 2026 08:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wzZTx-0005qa-Vi; Thu, 27 Aug 2026 08:45:26 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>)
 id 1wzZTu-0007kq-Fd; Thu, 27 Aug 2026 08:45:25 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Cxf9NZMZBq0rAFAA--.15894S3;
 Thu, 27 Aug 2026 20:45:14 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxRs1ZMZBqVUsUAA--.27115S2;
 Thu, 27 Aug 2026 20:45:13 +0800 (CST)
Subject: Re: [PATCH v4 11/20] target/loongarch: Constify CPULoongArchState for
 various tlb_*() getters
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, Song Gao <17746591750@163.com>,
 Xianglai Li <lixianglai@loongson.cn>
References: <20260824111711.26297-1-philmd@oss.qualcomm.com>
 <20260824111711.26297-12-philmd@oss.qualcomm.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <c774122d-c9de-f218-baf1-0988307d9291@loongson.cn>
Date: Thu, 27 Aug 2026 20:44:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260824111711.26297-12-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxRs1ZMZBqVUsUAA--.27115S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3uFy3GF1kJF43urWUuFWUKFX_yoWDAr13pr
 W7AFyfJr18GFZ8Z3s3K34YgF1qyr1fK34a9a4agr9akFWDJr1kWrWUX39FvF18A3yrWw4I
 vr1xAF1DXFW7XFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
 AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
 XVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
 8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
 Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
 xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
 cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
 AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
 14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2L05UUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.247,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2026/8/24 下午7:17, Philippe Mathieu-Daudé wrote:
> Add the const qualifier to CPULoongArchState when
> the argument is accessed without modification.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   target/loongarch/cpu-mmu.h           | 20 ++++++++++----------
>   target/loongarch/tcg/tcg_loongarch.h |  2 +-
>   target/loongarch/cpu_helper.c        | 20 ++++++++++----------
>   target/loongarch/tcg/tlb_helper.c    | 26 +++++++++++++-------------
>   4 files changed, 34 insertions(+), 34 deletions(-)
> 
> diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
> index 54fb732d62d..61b59f3d3f3 100644
> --- a/target/loongarch/cpu-mmu.h
> +++ b/target/loongarch/cpu-mmu.h
> @@ -30,14 +30,14 @@ typedef struct MMUContext {
>       uint64_t      pte_buddy[2];
>   } MMUContext;
>   
> -static inline bool cpu_has_ptw(CPULoongArchState *env)
> +static inline bool cpu_has_ptw(const CPULoongArchState *env)
>   {
> -    CPUSysState *sys = env_sys(env);
> +    const CPUSysState *sys = env_sys(env);
>   
>       return !!FIELD_EX64(sys->CSR_PWCH, CSR_PWCH, HPTW_EN);
>   }
>   
> -static inline bool pte_present(CPULoongArchState *env, uint64_t entry)
> +static inline bool pte_present(const CPULoongArchState *env, uint64_t entry)
>   {
>       uint8_t present;
>   
> @@ -50,7 +50,7 @@ static inline bool pte_present(CPULoongArchState *env, uint64_t entry)
>       return !!present;
>   }
>   
> -static inline bool pte_write(CPULoongArchState *env, uint64_t entry)
> +static inline bool pte_write(const CPULoongArchState *env, uint64_t entry)
>   {
>       uint8_t writable;
>   
> @@ -89,17 +89,17 @@ static inline bool pte_dirty(uint64_t entry)
>       return !!FIELD_EX64(entry, TLBENTRY, D);
>   }
>   
> -bool check_ps(CPULoongArchState *ent, uint8_t ps);
> -TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
> +bool check_ps(const CPULoongArchState *ent, uint8_t ps);
> +TLBRet loongarch_check_pte(const CPULoongArchState *env, MMUContext *context,
>                              MMUAccessType access_type, int mmu_idx);
> -TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
> +TLBRet get_physical_address(const CPULoongArchState *env, MMUContext *context,
>                               MMUAccessType access_type, int mmu_idx,
>                               int is_debug);
> -TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
> +TLBRet loongarch_ptw(const CPULoongArchState *env, MMUContext *context,
>                        int access_type, int mmu_idx, int debug);
> -void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
> +void get_dir_base_width(const CPULoongArchState *env, uint64_t *dir_base,
>                           uint64_t *dir_width, unsigned int level);
>   hwaddr loongarch_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
> -uint64_t loongarch_palen_mask(CPULoongArchState *env);
> +uint64_t loongarch_palen_mask(const CPULoongArchState *env);
>   
>   #endif  /* LOONGARCH_CPU_MMU_H */
> diff --git a/target/loongarch/tcg/tcg_loongarch.h b/target/loongarch/tcg/tcg_loongarch.h
> index 7fb627f2d63..0f20c60d73d 100644
> --- a/target/loongarch/tcg/tcg_loongarch.h
> +++ b/target/loongarch/tcg/tcg_loongarch.h
> @@ -16,7 +16,7 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>                               MMUAccessType access_type, int mmu_idx,
>                               bool probe, uintptr_t retaddr);
>   
> -TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env,
> +TLBRet loongarch_get_addr_from_tlb(const CPULoongArchState *env,
>                                      MMUContext *context,
>                                      MMUAccessType access_type, int mmu_idx);
>   
> diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
> index 123cad3d930..3401e7ed727 100644
> --- a/target/loongarch/cpu_helper.c
> +++ b/target/loongarch/cpu_helper.c
> @@ -18,10 +18,10 @@
>   #include "cpu-mmu.h"
>   #include "tcg/tcg_loongarch.h"
>   
> -void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
> +void get_dir_base_width(const CPULoongArchState *env, uint64_t *dir_base,
>                           uint64_t *dir_width, unsigned int level)
>   {
> -    CPUSysState *sys = env_sys(env);
> +    const CPUSysState *sys = env_sys(env);
>   
>       switch (level) {
>       case 1:
> @@ -48,7 +48,7 @@ void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
>       }
>   }
>   
> -TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
> +TLBRet loongarch_check_pte(const CPULoongArchState *env, MMUContext *context,
>                              MMUAccessType access_type, int mmu_idx)
>   {
>       uint64_t plv = mmu_idx;
> @@ -111,7 +111,7 @@ TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
>       return TLBRET_MATCH;
>   }
>   
> -static MemTxResult loongarch_cmpxchg_phys(CPUState *cs, hwaddr phys,
> +static MemTxResult loongarch_cmpxchg_phys(const CPUState *cs, hwaddr phys,
>                                             uint64_t old, uint64_t new)
>   {
>       hwaddr addr1, l = 8;
> @@ -146,11 +146,11 @@ static MemTxResult loongarch_cmpxchg_phys(CPUState *cs, hwaddr phys,
>       return ret;
>   }
>   
> -TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
> +TLBRet loongarch_ptw(const CPULoongArchState *env, MMUContext *context,
>                        int access_type, int mmu_idx, int debug)
>   {
>       const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
> -    CPUState *cs = env_cpu(env);
> +    const CPUState *cs = env_cpu(env);
>       hwaddr index = 0, phys = 0;
>       uint64_t palen_mask = loongarch_palen_mask(env);
>       uint64_t dir_base, dir_width;
> @@ -273,7 +273,7 @@ restart:
>       return ret;
>   }
>   
> -static TLBRet loongarch_map_address(CPULoongArchState *env,
> +static TLBRet loongarch_map_address(const CPULoongArchState *env,
>                                       MMUContext *context,
>                                       MMUAccessType access_type, int mmu_idx,
>                                       int is_debug)
> @@ -299,7 +299,7 @@ static TLBRet loongarch_map_address(CPULoongArchState *env,
>       return TLBRET_NOMATCH;
>   }
>   
> -static hwaddr dmw_va2pa(CPULoongArchState *env, vaddr va, uint64_t dmw)
> +static hwaddr dmw_va2pa(const CPULoongArchState *env, vaddr va, uint64_t dmw)
>   {
>       if (is_la64(env)) {
>           return va & TARGET_VIRT_MASK;
> @@ -310,7 +310,7 @@ static hwaddr dmw_va2pa(CPULoongArchState *env, vaddr va, uint64_t dmw)
>       }
>   }
>   
> -TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
> +TLBRet get_physical_address(const CPULoongArchState *env, MMUContext *context,
>                               MMUAccessType access_type, int mmu_idx,
>                               int is_debug)
>   {
> @@ -376,7 +376,7 @@ hwaddr loongarch_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
>       return context.physical;
>   }
>   
> -uint64_t loongarch_palen_mask(CPULoongArchState *env)
> +uint64_t loongarch_palen_mask(const CPULoongArchState *env)
>   {
>       /* PALEN stores physical address bits - 1 */
>       uint64_t phys_bits = FIELD_EX32(env->cpucfg[1], CPUCFG1, PALEN) + 1;
> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
> index a4b90beca65..6194b976c36 100644
> --- a/target/loongarch/tcg/tlb_helper.c
> +++ b/target/loongarch/tcg/tlb_helper.c
> @@ -35,9 +35,9 @@ static bool tlb_match_asid(bool global, int asid, int tlb_asid)
>       return !global && tlb_asid == asid;
>   }
>   
> -bool check_ps(CPULoongArchState *env, uint8_t tlb_ps)
> +bool check_ps(const CPULoongArchState *env, uint8_t tlb_ps)
>   {
> -    CPUSysState *sys = env_sys(env);
> +    const CPUSysState *sys = env_sys(env);
>   
>       if (tlb_ps >= 64) {
>           return false;
> @@ -238,11 +238,11 @@ static uint32_t get_random_tlb(uint32_t low, uint32_t high)
>    * field in tlb entry contains bit[47:13], so need adjust.
>    * virt_vpn = vaddr[47:13]
>    */
> -static LoongArchTLB *loongarch_tlb_search_cb(CPULoongArchState *env,
> -                                             vaddr vaddr, int csr_asid,
> -                                             tlb_match func)
> +static const LoongArchTLB *
> +loongarch_tlb_search_cb(const CPULoongArchState *env, vaddr vaddr,
> +                        int csr_asid, tlb_match func)
>   {
> -    LoongArchTLB *tlb;
> +    const LoongArchTLB *tlb;
Here it is to constify LoongArchTLB rather than CPULoongArchState, 
should it be split to another small patch?

The other looks good to me.
Reviewed-by: Bibo Mao <maobibo@loongson.cn>

>       uint16_t tlb_asid, stlb_idx;
>       uint8_t tlb_e, tlb_ps, stlb_ps;
>       bool tlb_g;
> @@ -291,12 +291,12 @@ static LoongArchTLB *loongarch_tlb_search_cb(CPULoongArchState *env,
>       return NULL;
>   }
>   
> -static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
> +static bool loongarch_tlb_search(const CPULoongArchState *env, vaddr vaddr,
>                                    int *index)
>   {
>       int csr_asid;
>       tlb_match func;
> -    LoongArchTLB *tlb;
> +    const LoongArchTLB *tlb;
>       CPUSysState *sys = env_sys(env);
>   
>       func = tlb_match_any;
> @@ -594,7 +594,7 @@ void helper_invtlb_page_asid(CPULoongArchState *env, target_ulong info,
>                                target_ulong addr)
>   {
>       int asid = info & 0x3ff;
> -    LoongArchTLB *tlb;
> +    const LoongArchTLB *tlb;
>       tlb_match func;
>   
>       func = tlb_match_asid;
> @@ -608,7 +608,7 @@ void helper_invtlb_page_asid_or_g(CPULoongArchState *env,
>                                     target_ulong info, target_ulong addr)
>   {
>       int asid = info & 0x3ff;
> -    LoongArchTLB *tlb;
> +    const LoongArchTLB *tlb;
>       tlb_match func;
>   
>       func = tlb_match_any;
> @@ -837,12 +837,12 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
>       sys->CSR_TLBREHI = FIELD_DP64(sys->CSR_TLBREHI, CSR_TLBREHI, PS, ps);
>   }
>   
> -static TLBRet loongarch_map_tlb_entry(CPULoongArchState *env,
> +static TLBRet loongarch_map_tlb_entry(const CPULoongArchState *env,
>                                         MMUContext *context,
>                                         MMUAccessType access_type, int index,
>                                         int mmu_idx)
>   {
> -    LoongArchTLB *tlb = &env->tlb[index];
> +    const LoongArchTLB *tlb = &env->tlb[index];
>       uint8_t tlb_ps, n;
>   
>       tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
> @@ -853,7 +853,7 @@ static TLBRet loongarch_map_tlb_entry(CPULoongArchState *env,
>       return loongarch_check_pte(env, context, access_type, mmu_idx);
>   }
>   
> -TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env,
> +TLBRet loongarch_get_addr_from_tlb(const CPULoongArchState *env,
>                                      MMUContext *context,
>                                      MMUAccessType access_type, int mmu_idx)
>   {
> 


