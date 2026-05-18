Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F30CCD4F52
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 08:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOtRf-0006ql-L1; Mon, 18 May 2026 04:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wOtRa-0006qF-Tw
 for qemu-devel@nongnu.org; Mon, 18 May 2026 04:35:23 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wOtRT-0001H1-KY
 for qemu-devel@nongnu.org; Mon, 18 May 2026 04:35:22 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxVuk4zwpqO8YKAA--.26013S3;
 Mon, 18 May 2026 16:35:04 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxSME3zwpqQ2SGAA--.44275S3;
 Mon, 18 May 2026 16:35:04 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: add LVZ support for TCG
To: prcups@krgm.moe, qemu-devel@nongnu.org
Cc: xianglai li <lixianglai@loongson.cn>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>, Song Gao <gaosong@loongson.cn>
References: <7f9a2f3f-896b-4415-b535-429b858fb337@mtasv.net>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <563c9386-9d40-7faa-a44c-356a2a3ae7bf@loongson.cn>
Date: Mon, 18 May 2026 16:32:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7f9a2f3f-896b-4415-b535-429b858fb337@mtasv.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxSME3zwpqQ2SGAA--.44275S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9DXoWkJF18Jr45CF17GrW7Ww1UCFX_yoW8Gr1UtF
 g_uF1xuFn7ur1Dua1akF4vv3s7J343KF1kKFWSyFykXrZ7Cw45Jw4rWrn5WFn7Gr47K3y5
 GFsrC39xXw1rCF17ZosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1T
 uYvTs0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9f
 nUUIcSsGvfJTRUUUbxAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4
 v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
 rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
 AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
 wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
 0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280
 aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
 xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
 x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r
 1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
 7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
 WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jU
 sqXUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.97,
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

Hi SignKirigami,

Thanks for providing LVZ patch, this patch adds 1900 lines and it is 
huge. I sugguest that it should be split smaller patch so that it is 
convenient to review.

Just keep patient since it is a big feature :)


Regards
Bibo Mao


On 2026/5/18 下午3:42, SignKirigami wrote:
> This patch implements Loongson VirtualiZation (LVZ) extension
> support for LoongArch's TCG target. With this patch, it is
> now possible to start a nested KVM-accelerated virtual machine
> on a TCG-emulated virtual machine.
> 
> Cc: Bibo Mao <maobibo@loongson.cn>
> Cc: xianglai li <lixianglai@loongson.cn>
> Signed-off-by: SignKirigami <prcups@krgm.moe>
> Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
> ---
>   target/loongarch/cpu-csr.h                    |  42 ++
>   target/loongarch/cpu-mmu.h                    |  37 +-
>   target/loongarch/cpu.c                        | 132 ++++
>   target/loongarch/cpu.h                        | 125 +++-
>   target/loongarch/cpu_helper.c                 | 119 ++--
>   target/loongarch/csr.c                        | 122 ++++
>   target/loongarch/csr.h                        |   3 +
>   target/loongarch/disas.c                      |  10 +
>   target/loongarch/insns.decode                 |  17 +
>   target/loongarch/internals.h                  |   8 +-
>   target/loongarch/kvm/kvm.c                    |   1 +
>   target/loongarch/machine.c                    | 249 ++++---
>   target/loongarch/tcg/constant_timer.c         |  62 +-
>   target/loongarch/tcg/csr_helper.c             | 127 +++-
>   target/loongarch/tcg/helper.h                 |  30 +-
>   .../tcg/insn_trans/trans_privileged.c.inc     | 353 +++++++++-
>   target/loongarch/tcg/op_helper.c              |  83 ++-
>   target/loongarch/tcg/tcg_cpu.c                | 182 +++--
>   target/loongarch/tcg/tcg_loongarch.h          |   6 +-
>   target/loongarch/tcg/tlb_helper.c             | 629 +++++++++++++-----
>   target/loongarch/tcg/translate.c              |   6 +-
>   target/loongarch/translate.h                  |   2 +
>   22 files changed, 1909 insertions(+), 436 deletions(-)
> 
> diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
> index d860417af2..4b0bb4d2e5 100644
> --- a/target/loongarch/cpu-csr.h
> +++ b/target/loongarch/cpu-csr.h
> @@ -180,11 +180,13 @@ FIELD(CSR_TLBREHI_64, VPPN, 13, 35)
>   #define LOONGARCH_CSR_TLBRPRMD       0x8f /* TLB refill mode info */
>   FIELD(CSR_TLBRPRMD, PPLV, 0, 2)
>   FIELD(CSR_TLBRPRMD, PIE, 2, 1)
> +FIELD(CSR_TLBRPRMD, PGM, 3, 1)
>   FIELD(CSR_TLBRPRMD, PWE, 4, 1)
>   
>   /* Machine Error CSRs */
>   #define LOONGARCH_CSR_MERRCTL        0x90 /* ERRCTL */
>   FIELD(CSR_MERRCTL, ISMERR, 0, 1)
> +FIELD(CSR_MERRCTL, PGM, 5, 1)
>   #define LOONGARCH_CSR_MERRINFO1      0x91
>   #define LOONGARCH_CSR_MERRINFO2      0x92
>   #define LOONGARCH_CSR_MERRENTRY      0x93 /* MError exception base */
> @@ -224,4 +226,44 @@ FIELD(CSR_DBG, ECODE, 16, 6)
>   #define LOONGARCH_CSR_DERA           0x501 /* Debug era */
>   #define LOONGARCH_CSR_DSAVE          0x502 /* Debug save */
>   
> +/* LVZ (LoongArch Virtualization) CSRs */
> +#define LOONGARCH_CSR_GSTAT          0x50 /* Guest status */
> +FIELD(CSR_GSTAT, VM, 0, 1)
> +FIELD(CSR_GSTAT, PVM, 1, 1)
> +FIELD(CSR_GSTAT, GIDBIT, 4, 6)
> +FIELD(CSR_GSTAT, GID, 16, 8)
> +
> +#define LOONGARCH_CSR_GCFG           0x51 /* Guest config */
> +FIELD(CSR_GCFG, MATP, 0, 4)
> +FIELD(CSR_GCFG, MATC, 4, 2)
> +FIELD(CSR_GCFG, TOPIP, 6, 1)
> +FIELD(CSR_GCFG, TOPI, 7, 1)
> +FIELD(CSR_GCFG, TOTIP, 8, 1)
> +FIELD(CSR_GCFG, TOTI, 9, 1)
> +FIELD(CSR_GCFG, TOEP, 10, 1)
> +FIELD(CSR_GCFG, TOE, 11, 1)
> +FIELD(CSR_GCFG, TOPP, 12, 1)
> +FIELD(CSR_GCFG, TOP, 13, 1)
> +FIELD(CSR_GCFG, TOHUP, 14, 1)
> +FIELD(CSR_GCFG, TOHU, 15, 1)
> +FIELD(CSR_GCFG, TOCIP, 16, 4)
> +FIELD(CSR_GCFG, TOCI, 20, 2)
> +FIELD(CSR_GCFG, GPMP, 23, 1)
> +FIELD(CSR_GCFG, GPMNUM, 24, 3)
> +
> +#define LOONGARCH_CSR_GINTC          0x52 /* Guest interrupt config */
> +FIELD(CSR_GINTC, HWIS, 0, 8)
> +FIELD(CSR_GINTC, HWIP, 8, 8)
> +FIELD(CSR_GINTC, HWIC, 16, 8)
> +
> +#define LOONGARCH_CSR_GCNTC          0x53 /* Guest counter compensation */
> +
> +#define LOONGARCH_CSR_GTLBC          0x15 /* Guest TLB control */
> +FIELD(CSR_GTLBC, GMTLBSZ, 0, 6)
> +FIELD(CSR_GTLBC, USETGID, 12, 1)
> +FIELD(CSR_GTLBC, TOTI, 13, 1)
> +FIELD(CSR_GTLBC, TGID, 16, 8)
> +
> +#define LOONGARCH_CSR_TRGP           0x16 /* Trapped guest physical address */
> +
>   #endif /* LOONGARCH_CPU_CSR_H */
> diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
> index 2d7ebb2d72..31093641ff 100644
> --- a/target/loongarch/cpu-mmu.h
> +++ b/target/loongarch/cpu-mmu.h
> @@ -17,6 +17,14 @@ typedef enum TLBRet {
>       TLBRET_RI,
>       TLBRET_XI,
>       TLBRET_PE,
> +    TLBRET_HOST_MATCH,
> +    TLBRET_HOST_BADADDR,
> +    TLBRET_HOST_NOMATCH,
> +    TLBRET_HOST_INVALID,
> +    TLBRET_HOST_DIRTY,
> +    TLBRET_HOST_RI,
> +    TLBRET_HOST_XI,
> +    TLBRET_HOST_PE,
>   } TLBRet;
>   
>   typedef struct MMUContext {
> @@ -30,16 +38,17 @@ typedef struct MMUContext {
>       uint64_t      pte_buddy[2];
>   } MMUContext;
>   
> -static inline bool cpu_has_ptw(CPULoongArchState *env)
> +static inline bool cpu_has_ptw(CPULoongArchState *env, bool guest)
>   {
> -    return !!FIELD_EX64(env->CSR_PWCH, CSR_PWCH, HPTW_EN);
> +    return !!FIELD_EX64(GET_CSR_IF(guest, PWCH), CSR_PWCH, HPTW_EN);
>   }
>   
> -static inline bool pte_present(CPULoongArchState *env, uint64_t entry)
> +static inline bool pte_present(CPULoongArchState *env, uint64_t entry,
> +                               bool guest)
>   {
>       uint8_t present;
>   
> -    if (cpu_has_ptw(env)) {
> +    if (cpu_has_ptw(env, guest)) {
>           present = FIELD_EX64(entry, TLBENTRY, P);
>       } else {
>           present = FIELD_EX64(entry, TLBENTRY, V);
> @@ -48,11 +57,11 @@ static inline bool pte_present(CPULoongArchState *env, uint64_t entry)
>       return !!present;
>   }
>   
> -static inline bool pte_write(CPULoongArchState *env, uint64_t entry)
> +static inline bool pte_write(CPULoongArchState *env, uint64_t entry, bool guest)
>   {
>       uint8_t writable;
>   
> -    if (cpu_has_ptw(env)) {
> +    if (cpu_has_ptw(env, guest)) {
>           writable = FIELD_EX64(entry, TLBENTRY, W);
>       } else {
>           writable = FIELD_EX64(entry, TLBENTRY, D);
> @@ -89,14 +98,22 @@ static inline bool pte_dirty(uint64_t entry)
>   
>   bool check_ps(CPULoongArchState *ent, uint8_t ps);
>   TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
> -                           MMUAccessType access_type, int mmu_idx);
> +                           MMUAccessType access_type, int mmu_idx, bool guest);
>   TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
>                               MMUAccessType access_type, int mmu_idx,
> -                            int is_debug);
> +                            int is_debug, uintptr_t retaddr);
>   TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
> -                     int access_type, int mmu_idx, int debug);
> +                     int access_type, int mmu_idx, int debug, bool guest,
> +                     uintptr_t retaddr);
> +hwaddr loongarch_get_host_address(CPULoongArchState *env, hwaddr gpa,
> +                                  uintptr_t retaddr);
> +TLBRet loongarch_map_host_address(CPULoongArchState *env, MMUContext *context,
> +                                  MMUAccessType access_type, uintptr_t retaddr);
> +TLBRet loongarch_map_address(CPULoongArchState *env, MMUContext *context,
> +                             MMUAccessType access_type, int mmu_idx,
> +                             int is_debug, bool guest, uintptr_t retaddr);
>   void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
> -                        uint64_t *dir_width, unsigned int level);
> +                        uint64_t *dir_width, unsigned int level, bool guest);
>   hwaddr loongarch_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
>   uint64_t loongarch_palen_mask(CPULoongArchState *env);
>   
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 8f277f7696..2477d84625 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -67,6 +67,11 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
>           return;
>       }
>   
> +    if (FIELD_EX64(env->CSR_GINTC, CSR_GINTC, HWIP) & BIT(irq)) {
> +        loongarch_cpu_set_irq_guest(opaque, irq, level);
> +        return;
> +    }
> +
>       if (kvm_enabled()) {
>           kvm_loongarch_set_interrupt(cpu, irq, level);
>       } else if (tcg_enabled()) {
> @@ -79,6 +84,26 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
>       }
>   }
>   
> +void loongarch_cpu_set_irq_guest(void *opaque, int irq, int level)
> +{
> +    LoongArchCPU *cpu = opaque;
> +    CPULoongArchState *env = &cpu->env;
> +    CPUState *cs = CPU(cpu);
> +
> +    if (irq < 0 || irq >= N_IRQS) {
> +        return;
> +    }
> +
> +    env->GCSR_ESTAT = deposit64(env->GCSR_ESTAT, irq, 1, level != 0);
> +    if (env->guest) {
> +        if (FIELD_EX64(env->GCSR_ESTAT, CSR_ESTAT, IS)) {
> +            cpu_interrupt(cs, CPU_INTERRUPT_GUEST);
> +        } else {
> +            cpu_reset_interrupt(cs, CPU_INTERRUPT_GUEST);
> +        }
> +    }
> +}
> +
>   /* Check if there is pending and not masked out interrupt */
>   bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env)
>   {
> @@ -90,6 +115,30 @@ bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env)
>   
>       return (pending & status) != 0;
>   }
> +
> +static inline bool
> +cpu_loongarch_hw_interrupts_enabled_guest(CPULoongArchState *env)
> +{
> +    return FIELD_EX64(env->GCSR_CRMD, CSR_CRMD, IE);
> +}
> +
> +static inline bool
> +cpu_loongarch_hw_interrupts_pending_guest(CPULoongArchState *env)
> +{
> +    uint32_t pending;
> +    uint32_t status;
> +
> +    pending = FIELD_EX64(env->GCSR_ESTAT, CSR_ESTAT, IS);
> +    status = FIELD_EX64(env->GCSR_ECFG, CSR_ECFG, LIE);
> +
> +    return (pending & status) != 0;
> +}
> +
> +bool loongarch_guest_has_interrupt(CPULoongArchState *env)
> +{
> +    return env->guest && cpu_loongarch_hw_interrupts_enabled_guest(env) &&
> +           cpu_loongarch_hw_interrupts_pending_guest(env);
> +}
>   #endif
>   
>   #ifndef CONFIG_USER_ONLY
> @@ -102,10 +151,54 @@ bool loongarch_cpu_has_work(CPUState *cs)
>           has_work = true;
>       }
>   
> +    if (cpu_test_interrupt(cs, CPU_INTERRUPT_GUEST) &&
> +        loongarch_guest_has_interrupt(cpu_env(cs))) {
> +        has_work = true;
> +    }
> +
>       return has_work;
>   }
>   #endif /* !CONFIG_USER_ONLY */
>   
> +uint8_t get_tgid(CPULoongArchState *env)
> +{
> +    if (env->guest) {
> +        return get_gid(env);
> +    }
> +
> +    if (FIELD_EX64(env->CSR_GTLBC, CSR_GTLBC, USETGID)) {
> +        return FIELD_EX64(env->CSR_GTLBC, CSR_GTLBC, TGID);
> +    } else if (will_return_to_guest(env)) {
> +        return get_gid(env);
> +    }
> +    return 0;
> +}
> +
> +bool will_return_to_guest(CPULoongArchState *env)
> +{
> +    if (!has_lvz_capability(env) || env->guest) {
> +        return false;
> +    }
> +    return FIELD_EX64(env->CSR_GSTAT, CSR_GSTAT, PVM);
> +}
> +
> +bool has_lvz_capability(CPULoongArchState *env)
> +{
> +    return FIELD_EX32(env->cpucfg[2], CPUCFG2, LVZ);
> +}
> +
> +uint8_t get_gid(CPULoongArchState *env)
> +{
> +    return FIELD_EX64(env->CSR_GSTAT, CSR_GSTAT, GID);
> +}
> +
> +void trigger_vm_exit(CPULoongArchState *env)
> +{
> +    cpu_loongarch_set_guest_timer(env_archcpu(env), false);
> +    env->CSR_GSTAT = FIELD_DP64(env->CSR_GSTAT, CSR_GSTAT, PVM, 1);
> +    env->vm_exit = true;
> +}
> +
>   static void loongarch_la464_init_csr(DeviceState *dev)
>   {
>   #ifndef CONFIG_USER_ONLY
> @@ -248,12 +341,33 @@ static void loongarch_set_ptw(Object *obj, bool value, Error **errp)
>       cpu->env.cpucfg[2] = FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, HPTW, value);
>   }
>   
> +static bool loongarch_get_lvz(Object *obj, Error **errp)
> +{
> +    return LOONGARCH_CPU(obj)->lvz != ON_OFF_AUTO_OFF;
> +}
> +
> +static void loongarch_set_lvz(Object *obj, bool value, Error **errp)
> +{
> +    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
> +
> +    cpu->lvz = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
> +
> +    if (kvm_enabled()) {
> +        return;
> +    }
> +
> +    cpu->env.cpucfg[2] = FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, LVZ, value);
> +    cpu->env.cpucfg[2] =
> +        FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, LVZ_VER, value ? 1 : 0);
> +}
> +
>   static void loongarch_cpu_post_init(Object *obj)
>   {
>       LoongArchCPU *cpu = LOONGARCH_CPU(obj);
>   
>       cpu->lbt = ON_OFF_AUTO_OFF;
>       cpu->pmu = ON_OFF_AUTO_OFF;
> +    cpu->lvz = ON_OFF_AUTO_AUTO;
>       cpu->lsx = ON_OFF_AUTO_AUTO;
>       cpu->lasx = ON_OFF_AUTO_AUTO;
>       object_property_add_bool(obj, "lsx", loongarch_get_lsx,
> @@ -264,6 +378,8 @@ static void loongarch_cpu_post_init(Object *obj)
>                                loongarch_set_msgint);
>       object_property_add_bool(obj, "ptw", loongarch_get_ptw,
>                                loongarch_set_ptw);
> +    object_property_add_bool(obj, "lvz", loongarch_get_lvz,
> +                             loongarch_set_lvz);
>       /* lbt is enabled only in kvm mode, not supported in tcg mode */
>   
>       if (kvm_enabled()) {
> @@ -317,6 +433,8 @@ static void loongarch_la464_initfn(Object *obj)
>       data = FIELD_DP32(data, CPUCFG2, FP_VER, 1);
>       data = FIELD_DP32(data, CPUCFG2, LSX, 1),
>       data = FIELD_DP32(data, CPUCFG2, LASX, 1),
> +    data = FIELD_DP32(data, CPUCFG2, LVZ, 1);
> +    data = FIELD_DP32(data, CPUCFG2, LVZ_VER, 1);
>       data = FIELD_DP32(data, CPUCFG2, LLFTP, 1);
>       data = FIELD_DP32(data, CPUCFG2, LLFTP_VER, 1);
>       data = FIELD_DP32(data, CPUCFG2, LSPW, 1);
> @@ -395,6 +513,7 @@ static void loongarch_la464_initfn(Object *obj)
>       env->CSR_PRCFG3 = FIELD_DP64(env->CSR_PRCFG3, CSR_PRCFG3, STLB_SETS, 8);
>   
>       cpu->msgint = ON_OFF_AUTO_OFF;
> +    cpu->lvz = ON_OFF_AUTO_AUTO;
>       cpu->ptw = ON_OFF_AUTO_OFF;
>       loongarch_cpu_post_init(obj);
>   }
> @@ -432,6 +551,7 @@ static void loongarch_la132_initfn(Object *obj)
>       data = FIELD_DP32(data, CPUCFG1, CRC, 1);
>       env->cpucfg[1] = data;
>       cpu->msgint = ON_OFF_AUTO_OFF;
> +    cpu->lvz = ON_OFF_AUTO_OFF;
>       cpu->ptw = ON_OFF_AUTO_OFF;
>   }
>   
> @@ -637,6 +757,7 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
>       env->CSR_RVACFG = FIELD_DP64(env->CSR_RVACFG, CSR_RVACFG, RBITS, 0);
>       env->CSR_CPUID = cs->cpu_index;
>       env->CSR_TCFG = FIELD_DP64(env->CSR_TCFG, CSR_TCFG, EN, 0);
> +    env->GCSR_TCFG = FIELD_DP64(env->GCSR_TCFG, CSR_TCFG, EN, 0);
>       env->CSR_LLBCTL = FIELD_DP64(env->CSR_LLBCTL, CSR_LLBCTL, KLO, 0);
>       env->CSR_TLBRERA = FIELD_DP64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 0);
>       env->CSR_MERRCTL = FIELD_DP64(env->CSR_MERRCTL, CSR_MERRCTL, ISMERR, 0);
> @@ -671,6 +792,15 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
>       env->pc = 0x1c000000;
>   #ifdef CONFIG_TCG
>       memset(env->tlb, 0, sizeof(env->tlb));
> +    env->guest = false;
> +    env->vm_exit = false;
> +    env->CSR_GSTAT = FIELD_DP64(0, CSR_GSTAT, GIDBIT, 8);
> +    env->CSR_GCFG = 0;
> +    env->CSR_GINTC = 0;
> +    env->CSR_GCNTC = 0;
> +    env->CSR_GTLBC = 0;
> +    env->CSR_TRGP = 0;
> +    env->GCSR_ASID = FIELD_DP64(0, CSR_ASID, ASIDBITS, 0xa);
>   #endif
>       if (kvm_enabled()) {
>           kvm_arch_reset_vcpu(cs);
> @@ -731,6 +861,8 @@ static void loongarch_cpu_init(Object *obj)
>   #ifdef CONFIG_TCG
>       timer_init_ns(&cpu->timer, QEMU_CLOCK_VIRTUAL,
>                     &loongarch_constant_timer_cb, cpu);
> +    timer_init_ns(&cpu->guest_timer, QEMU_CLOCK_VIRTUAL,
> +                  &loongarch_constant_timer_cb_guest, cpu);
>   #endif
>   #endif
>   }
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index 096d778928..8d3cae59fa 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -20,6 +20,20 @@
>   #include "cpu-csr.h"
>   #include "cpu-qom.h"
>   
> +#define GET_CSR_IF(guest_mode, csr_name) \
> +    ((guest_mode) ? (env->GCSR_##csr_name) : (env->CSR_##csr_name))
> +
> +#define SET_CSR_IF(guest_mode, csr_name, value) \
> +    do {                                        \
> +        if (guest_mode) {                       \
> +            env->GCSR_##csr_name = (value);     \
> +        } else {                                \
> +            env->CSR_##csr_name = (value);      \
> +        }                                       \
> +    } while (0)
> +
> +#define CPU_INTERRUPT_GUEST CPU_INTERRUPT_TGT_EXT_0
> +
>   #define FCSR0_M1    0x1f         /* FCSR1 mask, Enables */
>   #define FCSR0_M2    0x1f1f0000   /* FCSR2 mask, Cause and Flags */
>   #define FCSR0_M3    0x300        /* FCSR3 mask, Round Mode */
> @@ -93,6 +107,10 @@ FIELD(FCSR0, CAUSE, 24, 5)
>   #define  EXCCODE_WPEM                EXCODE(19, 1)
>   #define  EXCCODE_BTD                 EXCODE(20, 0)
>   #define  EXCCODE_BTE                 EXCODE(21, 0)
> +#define  EXCCODE_GSPR                EXCODE(22, 0)
> +#define  EXCCODE_HVC                 EXCODE(23, 0)
> +#define  EXCCODE_GCSC                EXCODE(24, 0)
> +#define  EXCCODE_GCHC                EXCODE(25, 0)
>   #define  EXCCODE_DBP                 EXCODE(26, 0) /* Reserved subcode used for debug */
>   
>   /* cpucfg[0] bits */
> @@ -255,6 +273,7 @@ FIELD(TLB_MISC, E, 0, 1)
>   FIELD(TLB_MISC, ASID, 1, 10)
>   FIELD(TLB_MISC, VPPN, 13, 35)
>   FIELD(TLB_MISC, PS, 48, 6)
> +FIELD(TLB_MISC, GID, 54, 8)
>   
>   /*Msg interrupt registers */
>   #define N_MSGIS                4
> @@ -389,6 +408,79 @@ typedef struct CPUArchState {
>       uint64_t CSR_DBG;
>       uint64_t CSR_DERA;
>       uint64_t CSR_DSAVE;
> +
> +    /* LVZ (LoongArch Virtualization) CSRs */
> +    uint64_t CSR_GSTAT;
> +    uint64_t CSR_GCFG;
> +    uint64_t CSR_GINTC;
> +    uint64_t CSR_GCNTC;
> +    uint64_t CSR_GTLBC;
> +    uint64_t CSR_TRGP;
> +
> +    /* Guest CSR registers (GCSR) */
> +    uint64_t GCSR_CRMD;
> +    uint64_t GCSR_PRMD;
> +    uint64_t GCSR_EUEN;
> +    uint64_t GCSR_MISC;
> +    uint64_t GCSR_ECFG;
> +    uint64_t GCSR_ESTAT;
> +    uint64_t GCSR_ERA;
> +    uint64_t GCSR_BADV;
> +    uint64_t GCSR_BADI;
> +    uint64_t GCSR_EENTRY;
> +    uint64_t GCSR_TLBIDX;
> +    uint64_t GCSR_TLBEHI;
> +    uint64_t GCSR_TLBELO0;
> +    uint64_t GCSR_TLBELO1;
> +    uint64_t GCSR_ASID;
> +    uint64_t GCSR_PGDL;
> +    uint64_t GCSR_PGDH;
> +    uint64_t GCSR_PGD;
> +    uint64_t GCSR_PWCL;
> +    uint64_t GCSR_PWCH;
> +    uint64_t GCSR_STLBPS;
> +    uint64_t GCSR_RVACFG;
> +    uint64_t GCSR_CPUID;
> +    uint64_t GCSR_PRCFG1;
> +    uint64_t GCSR_PRCFG2;
> +    uint64_t GCSR_PRCFG3;
> +    uint64_t GCSR_SAVE[16];
> +    uint64_t GCSR_TID;
> +    uint64_t GCSR_TCFG;
> +    uint64_t GCSR_TVAL;
> +    uint64_t GCSR_CNTC;
> +    uint64_t GCSR_TICLR;
> +    uint64_t GCSR_LLBCTL;
> +    uint64_t GCSR_IMPCTL1;
> +    uint64_t GCSR_IMPCTL2;
> +    uint64_t GCSR_TLBRENTRY;
> +    uint64_t GCSR_TLBRBADV;
> +    uint64_t GCSR_TLBRERA;
> +    uint64_t GCSR_TLBRSAVE;
> +    uint64_t GCSR_TLBRELO0;
> +    uint64_t GCSR_TLBRELO1;
> +    uint64_t GCSR_TLBREHI;
> +    uint64_t GCSR_TLBRPRMD;
> +    uint64_t GCSR_MERRCTL;
> +    uint64_t GCSR_MERRINFO1;
> +    uint64_t GCSR_MERRINFO2;
> +    uint64_t GCSR_MERRENTRY;
> +    uint64_t GCSR_MERRERA;
> +    uint64_t GCSR_MERRSAVE;
> +    uint64_t GCSR_CTAG;
> +    uint64_t GCSR_DMW[4];
> +    uint64_t GCSR_DBG;
> +    uint64_t GCSR_DERA;
> +    uint64_t GCSR_DSAVE;
> +    uint64_t GCSR_GSTAT;
> +    uint64_t GCSR_GCFG;
> +    uint64_t GCSR_GINTC;
> +    uint64_t GCSR_GCNTC;
> +    uint64_t GCSR_GTLBC;
> +    uint64_t GCSR_TRGP;
> +
> +    bool guest;
> +    bool vm_exit;
>       /* Msg interrupt registers */
>       uint64_t CSR_MSGIS[N_MSGIS];
>       uint64_t CSR_MSGIR;
> @@ -410,6 +502,7 @@ typedef struct CPUArchState {
>   #ifndef CONFIG_USER_ONLY
>   #ifdef CONFIG_TCG
>       LoongArchTLB  tlb[LOONGARCH_TLB_MAX];
> +    LoongArchTLB gtlb[LOONGARCH_TLB_MAX];
>   #endif
>   
>       AddressSpace *address_space_iocsr;
> @@ -434,9 +527,11 @@ struct ArchCPU {
>   
>       CPULoongArchState env;
>       QEMUTimer timer;
> +    QEMUTimer guest_timer;
>       uint32_t  phy_id;
>       OnOffAuto lbt;
>       OnOffAuto pmu;
> +    OnOffAuto lvz;
>       OnOffAuto ptw;
>       OnOffAuto lsx;
>       OnOffAuto lasx;
> @@ -480,6 +575,24 @@ struct LoongArchCPUClass {
>   #define MMU_KERNEL_IDX   MMU_PLV_KERNEL
>   #define MMU_USER_IDX     MMU_PLV_USER
>   #define MMU_DA_IDX       4
> +#define MMU_GUEST_IDX    5
> +#define MMU_GUEST_DA_IDX 9
> +
> +static inline bool is_guest_mmu_idx(int mmu_idx)
> +{
> +    return mmu_idx >= MMU_GUEST_IDX;
> +}
> +
> +static inline int mmu_idx_to_plv(int mmu_idx)
> +{
> +    if (mmu_idx == MMU_DA_IDX || mmu_idx == MMU_GUEST_DA_IDX) {
> +        return 0;
> +    }
> +    if (is_guest_mmu_idx(mmu_idx)) {
> +        return mmu_idx - MMU_GUEST_IDX;
> +    }
> +    return mmu_idx;
> +}
>   
>   static inline bool is_la64(CPULoongArchState *env)
>   {
> @@ -490,8 +603,9 @@ static inline bool is_va32(CPULoongArchState *env)
>   {
>       /* VA32 if !LA64 or VA32L[1-3] */
>       bool va32 = !is_la64(env);
> -    uint64_t plv = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV);
> -    if (plv >= 1 && (FIELD_EX64(env->CSR_MISC, CSR_MISC, VA32) & (1 << plv))) {
> +    uint64_t plv = FIELD_EX64(GET_CSR_IF(env->guest, CRMD), CSR_CRMD, PLV);
> +    if (plv >= 1 &&
> +        (FIELD_EX64(GET_CSR_IF(env->guest, MISC), CSR_MISC, VA32) & BIT(plv))) {
>           va32 = true;
>       }
>       return va32;
> @@ -515,6 +629,13 @@ static inline void set_pc(CPULoongArchState *env, uint64_t value)
>   #define HW_FLAGS_CRMD_PG    R_CSR_CRMD_PG_MASK   /* 0x10 */
>   #define HW_FLAGS_VA32       0x20
>   #define HW_FLAGS_EUEN_ASXE  0x40
> +#define HW_FLAGS_GUEST_MODE 0x80
> +
> +bool has_lvz_capability(CPULoongArchState *env);
> +bool will_return_to_guest(CPULoongArchState *env);
> +uint8_t get_gid(CPULoongArchState *env);
> +uint8_t get_tgid(CPULoongArchState *env);
> +void trigger_vm_exit(CPULoongArchState *env);
>   
>   #define CPU_RESOLVING_TYPE TYPE_LOONGARCH_CPU
>   
> diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
> index eb9684a4a1..bad6062ac9 100644
> --- a/target/loongarch/cpu_helper.c
> +++ b/target/loongarch/cpu_helper.c
> @@ -17,46 +17,56 @@
>   #include "cpu-mmu.h"
>   #include "tcg/tcg_loongarch.h"
>   
> -void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
> -                        uint64_t *dir_width, unsigned int level)
> +static void get_dir_base_width_csr(CPULoongArchState *env, uint64_t *dir_base,
> +                                   uint64_t *dir_width, unsigned int level,
> +                                   bool guest)
>   {
> +    uint64_t pwcl = GET_CSR_IF(guest, PWCL);
> +    uint64_t pwch = GET_CSR_IF(guest, PWCH);
> +
>       switch (level) {
>       case 1:
> -        *dir_base = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR1_BASE);
> -        *dir_width = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR1_WIDTH);
> +        *dir_base = FIELD_EX64(pwcl, CSR_PWCL, DIR1_BASE);
> +        *dir_width = FIELD_EX64(pwcl, CSR_PWCL, DIR1_WIDTH);
>           break;
>       case 2:
> -        *dir_base = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR2_BASE);
> -        *dir_width = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, DIR2_WIDTH);
> +        *dir_base = FIELD_EX64(pwcl, CSR_PWCL, DIR2_BASE);
> +        *dir_width = FIELD_EX64(pwcl, CSR_PWCL, DIR2_WIDTH);
>           break;
>       case 3:
> -        *dir_base = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR3_BASE);
> -        *dir_width = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR3_WIDTH);
> +        *dir_base = FIELD_EX64(pwch, CSR_PWCH, DIR3_BASE);
> +        *dir_width = FIELD_EX64(pwch, CSR_PWCH, DIR3_WIDTH);
>           break;
>       case 4:
> -        *dir_base = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR4_BASE);
> -        *dir_width = FIELD_EX64(env->CSR_PWCH, CSR_PWCH, DIR4_WIDTH);
> +        *dir_base = FIELD_EX64(pwch, CSR_PWCH, DIR4_BASE);
> +        *dir_width = FIELD_EX64(pwch, CSR_PWCH, DIR4_WIDTH);
>           break;
>       default:
>           /* level may be zero for ldpte */
> -        *dir_base = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
> -        *dir_width = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
> +        *dir_base = FIELD_EX64(pwcl, CSR_PWCL, PTBASE);
> +        *dir_width = FIELD_EX64(pwcl, CSR_PWCL, PTWIDTH);
>           break;
>       }
>   }
>   
> +void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
> +                        uint64_t *dir_width, unsigned int level, bool guest)
> +{
> +    get_dir_base_width_csr(env, dir_base, dir_width, level, guest);
> +}
> +
>   TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
> -                           MMUAccessType access_type, int mmu_idx)
> +                           MMUAccessType access_type, int mmu_idx, bool guest)
>   {
> -    uint64_t plv = mmu_idx;
> +    uint64_t plv = mmu_idx_to_plv(mmu_idx);
>       uint64_t tlb_entry, tlb_ppn;
>       uint8_t tlb_ps, tlb_plv, tlb_nx, tlb_nr, tlb_rplv;
>       bool tlb_v, tlb_d;
>   
>       tlb_entry = context->pte;
>       tlb_ps = context->ps;
> -    tlb_v = pte_present(env, tlb_entry);
> -    tlb_d = pte_write(env, tlb_entry);
> +    tlb_v = pte_present(env, tlb_entry, guest);
> +    tlb_d = pte_write(env, tlb_entry, guest);
>       tlb_plv = FIELD_EX64(tlb_entry, TLBENTRY, PLV);
>       if (is_la64(env)) {
>           tlb_ppn = FIELD_EX64(tlb_entry, TLBENTRY_64, PPN);
> @@ -98,7 +108,7 @@ TLBRet loongarch_check_pte(CPULoongArchState *env, MMUContext *context,
>       context->physical = (tlb_ppn << R_TLBENTRY_64_PPN_SHIFT) |
>                           (context->addr & MAKE_64BIT_MASK(0, tlb_ps));
>       context->prot = PAGE_READ;
> -    context->mmu_index = tlb_plv;
> +    context->mmu_index = mmu_idx;
>       if (tlb_d) {
>           context->prot |= PAGE_WRITE;
>       }
> @@ -144,7 +154,8 @@ static MemTxResult loongarch_cmpxchg_phys(CPUState *cs, hwaddr phys,
>   }
>   
>   TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
> -                     int access_type, int mmu_idx, int debug)
> +                     int access_type, int mmu_idx, int debug, bool guest,
> +                     uintptr_t retaddr)
>   {
>       const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
>       CPUState *cs = env_cpu(env);
> @@ -160,14 +171,14 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
>   
>       address = context->addr;
>       if ((address >> 63) & 0x1) {
> -        base = env->CSR_PGDH;
> +        base = GET_CSR_IF(guest, PGDH);
>       } else {
> -        base = env->CSR_PGDL;
> +        base = GET_CSR_IF(guest, PGDL);
>       }
>       base &= palen_mask;
>   
>       for (level = 4; level >= 0; level--) {
> -        get_dir_base_width(env, &dir_base, &dir_width, level);
> +        get_dir_base_width(env, &dir_base, &dir_width, level, guest);
>   
>           if (dir_width == 0) {
>               continue;
> @@ -176,7 +187,10 @@ TLBRet loongarch_ptw(CPULoongArchState *env, MMUContext *context,
>           /* get next level page directory */
>           index = (address >> dir_base) & ((1 << dir_width) - 1);
>           phys = base | index << 3;
> -        base = address_space_ldq_le(cs->as, phys, attrs, NULL);
> +        base = address_space_ldq_le(
> +            cs->as,
> +            (guest ? loongarch_get_host_address(env, phys, retaddr) : phys),
> +            attrs, NULL);
>           if (level) {
>               if (FIELD_EX64(base, TLBENTRY, HUGE)) {
>                   /* base is a huge pte */
> @@ -205,19 +219,22 @@ restart:
>           context->pte_buddy[index] = base;
>           context->pte_buddy[1 - index] = base + BIT_ULL(dir_base);
>           base += (BIT_ULL(dir_base) & address);
> -    } else if (cpu_has_ptw(env)) {
> +    } else if (cpu_has_ptw(env, guest)) {
>           uint64_t val;
>   
>           index &= 1;
>           context->pte_buddy[index] = base;
> -        val = address_space_ldq_le(cs->as, phys + 8 * (1 - 2 * index),
> -                                   attrs, NULL);
> +        val = address_space_ldq_le(
> +            cs->as,
> +            (guest ? loongarch_get_host_address(env, phys, retaddr) : phys) +
> +                8 * (1 - 2 * index),
> +            attrs, NULL);
>           context->pte_buddy[1 - index] = val;
>       }
>   
>       context->ps = dir_base;
>       context->pte = base;
> -    ret = loongarch_check_pte(env, context, access_type, mmu_idx);
> +    ret = loongarch_check_pte(env, context, access_type, mmu_idx, guest);
>       if (debug) {
>           return ret;
>       }
> @@ -228,7 +245,7 @@ restart:
>        * Need atomic compchxg operation with pte update, other vCPUs may
>        * update pte at the same time.
>        */
> -    if (ret == TLBRET_MATCH && cpu_has_ptw(env)) {
> +    if (ret == TLBRET_MATCH && cpu_has_ptw(env, guest)) {
>           if (access_type == MMU_DATA_STORE && pte_dirty(base)) {
>               return ret;
>           }
> @@ -241,10 +258,15 @@ restart:
>           if (access_type == MMU_DATA_STORE) {
>               base = pte_mkdirty(base);
>           }
> -        ret1 = loongarch_cmpxchg_phys(cs, phys, pte, base);
> +        ret1 = loongarch_cmpxchg_phys(
> +            cs, (guest ? loongarch_get_host_address(env, phys, retaddr) : phys),
> +            pte, base);
>           /* PTE updated by other CPU, reload PTE entry */
>           if (ret1 == MEMTX_DECODE_ERROR) {
> -            base = address_space_ldq_le(cs->as, phys, attrs, NULL);
> +            base = address_space_ldq_le(
> +                cs->as,
> +                (guest ? loongarch_get_host_address(env, phys, retaddr) : phys),
> +                attrs, NULL);
>               goto restart;
>           }
>   
> @@ -270,15 +292,15 @@ restart:
>       return ret;
>   }
>   
> -static TLBRet loongarch_map_address(CPULoongArchState *env,
> -                                    MMUContext *context,
> -                                    MMUAccessType access_type, int mmu_idx,
> -                                    int is_debug)
> +TLBRet loongarch_map_address(CPULoongArchState *env, MMUContext *context,
> +                             MMUAccessType access_type, int mmu_idx,
> +                             int is_debug, bool guest, uintptr_t retaddr)
>   {
>       TLBRet ret;
>   
>       if (tcg_enabled()) {
> -        ret = loongarch_get_addr_from_tlb(env, context, access_type, mmu_idx);
> +        ret = loongarch_get_addr_from_tlb(env, context, access_type, mmu_idx,
> +                                          guest);
>           if (ret != TLBRET_NOMATCH) {
>               return ret;
>           }
> @@ -290,7 +312,8 @@ static TLBRet loongarch_map_address(CPULoongArchState *env,
>            * legal mapping, even if the mapping is not yet in TLB. return 0 if
>            * there is a valid map, else none zero.
>            */
> -        return loongarch_ptw(env, context, access_type, mmu_idx, is_debug);
> +        return loongarch_ptw(env, context, access_type, mmu_idx, is_debug,
> +                             guest, retaddr);
>       }
>   
>       return TLBRET_NOMATCH;
> @@ -309,14 +332,14 @@ static hwaddr dmw_va2pa(CPULoongArchState *env, vaddr va, uint64_t dmw)
>   
>   TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
>                               MMUAccessType access_type, int mmu_idx,
> -                            int is_debug)
> +                            int is_debug, uintptr_t retaddr)
>   {
> -    int user_mode = mmu_idx == MMU_USER_IDX;
> -    int kernel_mode = mmu_idx == MMU_KERNEL_IDX;
> +    int user_mode = mmu_idx_to_plv(mmu_idx) == MMU_USER_IDX;
> +    int kernel_mode = mmu_idx_to_plv(mmu_idx) == MMU_KERNEL_IDX;
>       uint32_t plv, base_c, base_v;
>       int64_t addr_high;
> -    uint8_t da = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, DA);
> -    uint8_t pg = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG);
> +    uint8_t da = FIELD_EX64(GET_CSR_IF(env->guest, CRMD), CSR_CRMD, DA);
> +    uint8_t pg = FIELD_EX64(GET_CSR_IF(env->guest, CRMD), CSR_CRMD, PG);
>       vaddr address;
>   
>       /* Check PG and DA */
> @@ -337,12 +360,15 @@ TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
>       /* Check direct map window */
>       for (int i = 0; i < 4; i++) {
>           if (is_la64(env)) {
> -            base_c = FIELD_EX64(env->CSR_DMW[i], CSR_DMW_64, VSEG);
> +            base_c =
> +                FIELD_EX64(GET_CSR_IF(env->guest, DMW[i]), CSR_DMW_64, VSEG);
>           } else {
> -            base_c = FIELD_EX64(env->CSR_DMW[i], CSR_DMW_32, VSEG);
> +            base_c =
> +                FIELD_EX64(GET_CSR_IF(env->guest, DMW[i]), CSR_DMW_32, VSEG);
>           }
> -        if ((plv & env->CSR_DMW[i]) && (base_c == base_v)) {
> -            context->physical = dmw_va2pa(env, address, env->CSR_DMW[i]);
> +        if ((plv & GET_CSR_IF(env->guest, DMW[i])) && (base_c == base_v)) {
> +            context->physical =
> +                dmw_va2pa(env, address, GET_CSR_IF(env->guest, DMW[i]));
>               context->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>               context->mmu_index = MMU_DA_IDX;
>               return TLBRET_MATCH;
> @@ -356,7 +382,8 @@ TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
>       }
>   
>       /* Mapped address */
> -    return loongarch_map_address(env, context, access_type, mmu_idx, is_debug);
> +    return loongarch_map_address(env, context, access_type, mmu_idx, is_debug,
> +                                 env->guest, retaddr);
>   }
>   
>   hwaddr loongarch_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
> @@ -366,7 +393,7 @@ hwaddr loongarch_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
>   
>       context.addr = addr;
>       if (get_physical_address(env, &context, MMU_DATA_LOAD,
> -                             cpu_mmu_index(cs, false), 1) != TLBRET_MATCH) {
> +                             cpu_mmu_index(cs, false), 1, 0) != TLBRET_MATCH) {
>           return -1;
>       }
>       return context.physical;
> diff --git a/target/loongarch/csr.c b/target/loongarch/csr.c
> index fff2312f87..1c4505536d 100644
> --- a/target/loongarch/csr.c
> +++ b/target/loongarch/csr.c
> @@ -20,8 +20,27 @@
>           .flags = 0, .readfn = NULL, .writefn = NULL           \
>       }
>   
> +#define GCSR_OFF_FUNCS(NAME, FL, RD, WR)                              \
> +    [LOONGARCH_CSR_##                                                 \
> +        NAME] = { .name = (stringify(GCSR_##NAME)),                   \
> +                  .offset = offsetof(CPULoongArchState, GCSR_##NAME), \
> +                  .flags = FL,                                        \
> +                  .readfn = RD,                                       \
> +                  .writefn = WR }
> +
> +#define GCSR_OFF_ARRAY(NAME, N)                                         \
> +    [LOONGARCH_CSR_##NAME(N)] = { .name = (stringify(GCSR_##NAME##N)),  \
> +                                  .offset = offsetof(CPULoongArchState, \
> +                                                     GCSR_##NAME[N]),   \
> +                                  .flags = 0,                           \
> +                                  .readfn = NULL,                       \
> +                                  .writefn = NULL }
> +
>   #define CSR_OFF_FLAGS(NAME, FL)   CSR_OFF_FUNCS(NAME, FL, NULL, NULL)
>   #define CSR_OFF(NAME)             CSR_OFF_FLAGS(NAME, 0)
> +#define GCSR_OFF_FLAGS(NAME, FL) GCSR_OFF_FUNCS(NAME, FL, NULL, NULL)
> +#define GCSR_OFF(NAME) GCSR_OFF_FLAGS(NAME, 0)
> +#define GCSR_GSPR(NAME) GCSR_OFF_FUNCS(NAME, CSRFL_GSPR, NULL, NULL)
>   
>   static CSRInfo csr_info[] = {
>       CSR_OFF_FLAGS(CRMD, CSRFL_EXITTB),
> @@ -35,6 +54,8 @@ static CSRInfo csr_info[] = {
>       CSR_OFF_FLAGS(BADI, CSRFL_READONLY),
>       CSR_OFF(EENTRY),
>       CSR_OFF(TLBIDX),
> +    CSR_OFF(GTLBC),
> +    CSR_OFF(TRGP),
>       CSR_OFF(TLBEHI),
>       CSR_OFF(TLBELO0),
>       CSR_OFF(TLBELO1),
> @@ -71,6 +92,10 @@ static CSRInfo csr_info[] = {
>       CSR_OFF_FLAGS(TVAL, CSRFL_READONLY | CSRFL_IO),
>       CSR_OFF(CNTC),
>       CSR_OFF_FLAGS(TICLR, CSRFL_IO),
> +    CSR_OFF(GSTAT),
> +    CSR_OFF(GCFG),
> +    CSR_OFF_FLAGS(GINTC, CSRFL_IO),
> +    CSR_OFF(GCNTC),
>       CSR_OFF(LLBCTL),
>       CSR_OFF(IMPCTL1),
>       CSR_OFF(IMPCTL2),
> @@ -135,6 +160,87 @@ static CSRInfo csr_info[] = {
>       CSR_OFF(MSGIR),
>   };
>   
> +static CSRInfo gcsr_info[] = {
> +    GCSR_OFF_FLAGS(CRMD, CSRFL_EXITTB),
> +    GCSR_OFF(PRMD),
> +    GCSR_OFF_FLAGS(EUEN, CSRFL_EXITTB),
> +    GCSR_OFF_FLAGS(MISC, CSRFL_GUEST_READONLY),
> +    GCSR_OFF(ECFG),
> +    GCSR_OFF_FLAGS(ESTAT, CSRFL_EXITTB),
> +    GCSR_OFF(ERA),
> +    GCSR_OFF(BADV),
> +    GCSR_OFF_FLAGS(BADI, CSRFL_GUEST_READONLY),
> +    GCSR_OFF(EENTRY),
> +    GCSR_OFF(TLBIDX),
> +    GCSR_GSPR(GTLBC),
> +    GCSR_GSPR(TRGP),
> +    GCSR_OFF(TLBEHI),
> +    GCSR_OFF(TLBELO0),
> +    GCSR_OFF(TLBELO1),
> +    GCSR_OFF_FLAGS(ASID, CSRFL_EXITTB),
> +    GCSR_OFF(PGDL),
> +    GCSR_OFF(PGDH),
> +    GCSR_OFF_FLAGS(PGD, CSRFL_GUEST_READONLY),
> +    GCSR_OFF(PWCL),
> +    GCSR_OFF(PWCH),
> +    GCSR_OFF(STLBPS),
> +    GCSR_OFF(RVACFG),
> +    GCSR_OFF_FLAGS(CPUID, CSRFL_GUEST_READONLY),
> +    GCSR_OFF_FLAGS(PRCFG1, CSRFL_GUEST_READONLY),
> +    GCSR_OFF_FLAGS(PRCFG2, CSRFL_GUEST_READONLY),
> +    GCSR_OFF_FLAGS(PRCFG3, CSRFL_GUEST_READONLY),
> +    GCSR_OFF_ARRAY(SAVE, 0),
> +    GCSR_OFF_ARRAY(SAVE, 1),
> +    GCSR_OFF_ARRAY(SAVE, 2),
> +    GCSR_OFF_ARRAY(SAVE, 3),
> +    GCSR_OFF_ARRAY(SAVE, 4),
> +    GCSR_OFF_ARRAY(SAVE, 5),
> +    GCSR_OFF_ARRAY(SAVE, 6),
> +    GCSR_OFF_ARRAY(SAVE, 7),
> +    GCSR_OFF_ARRAY(SAVE, 8),
> +    GCSR_OFF_ARRAY(SAVE, 9),
> +    GCSR_OFF_ARRAY(SAVE, 10),
> +    GCSR_OFF_ARRAY(SAVE, 11),
> +    GCSR_OFF_ARRAY(SAVE, 12),
> +    GCSR_OFF_ARRAY(SAVE, 13),
> +    GCSR_OFF_ARRAY(SAVE, 14),
> +    GCSR_OFF_ARRAY(SAVE, 15),
> +    GCSR_OFF(TID),
> +    GCSR_OFF_FLAGS(TCFG, CSRFL_IO),
> +    GCSR_OFF_FLAGS(TVAL, CSRFL_GUEST_READONLY | CSRFL_IO),
> +    GCSR_OFF(CNTC),
> +    GCSR_OFF_FLAGS(TICLR, CSRFL_IO),
> +    GCSR_GSPR(GSTAT),
> +    GCSR_GSPR(GCFG),
> +    GCSR_GSPR(GINTC),
> +    GCSR_GSPR(GCNTC),
> +    GCSR_OFF(LLBCTL),
> +    GCSR_GSPR(IMPCTL1),
> +    GCSR_GSPR(IMPCTL2),
> +    GCSR_OFF(TLBRENTRY),
> +    GCSR_OFF(TLBRBADV),
> +    GCSR_OFF(TLBRERA),
> +    GCSR_OFF(TLBRSAVE),
> +    GCSR_OFF(TLBRELO0),
> +    GCSR_OFF(TLBRELO1),
> +    GCSR_OFF(TLBREHI),
> +    GCSR_OFF(TLBRPRMD),
> +    GCSR_GSPR(MERRCTL),
> +    GCSR_GSPR(MERRINFO1),
> +    GCSR_GSPR(MERRINFO2),
> +    GCSR_GSPR(MERRENTRY),
> +    GCSR_GSPR(MERRERA),
> +    GCSR_GSPR(MERRSAVE),
> +    GCSR_GSPR(CTAG),
> +    GCSR_OFF_ARRAY(DMW, 0),
> +    GCSR_OFF_ARRAY(DMW, 1),
> +    GCSR_OFF_ARRAY(DMW, 2),
> +    GCSR_OFF_ARRAY(DMW, 3),
> +    GCSR_GSPR(DBG),
> +    GCSR_GSPR(DERA),
> +    GCSR_GSPR(DSAVE),
> +};
> +
>   CSRInfo *get_csr(unsigned int csr_num)
>   {
>       CSRInfo *csr;
> @@ -151,6 +257,22 @@ CSRInfo *get_csr(unsigned int csr_num)
>       return csr;
>   }
>   
> +CSRInfo *get_gcsr(unsigned int csr_num)
> +{
> +    CSRInfo *csr;
> +
> +    if (csr_num >= ARRAY_SIZE(gcsr_info)) {
> +        return NULL;
> +    }
> +
> +    csr = &gcsr_info[csr_num];
> +    if (csr->offset == 0) {
> +        return NULL;
> +    }
> +
> +    return csr;
> +}
> +
>   bool set_csr_flag(unsigned int csr_num, int flag)
>   {
>       CSRInfo *csr;
> diff --git a/target/loongarch/csr.h b/target/loongarch/csr.h
> index 81a656baae..a0846353de 100644
> --- a/target/loongarch/csr.h
> +++ b/target/loongarch/csr.h
> @@ -14,6 +14,8 @@ enum {
>       CSRFL_EXITTB   = (1 << 1),
>       CSRFL_IO       = (1 << 2),
>       CSRFL_UNUSED   = (1 << 3),
> +    CSRFL_GUEST_READONLY = (1 << 4),
> +    CSRFL_GSPR     = (1 << 5),
>   };
>   
>   typedef struct {
> @@ -25,5 +27,6 @@ typedef struct {
>   } CSRInfo;
>   
>   CSRInfo *get_csr(unsigned int csr_num);
> +CSRInfo *get_gcsr(unsigned int csr_num);
>   bool set_csr_flag(unsigned int csr_num, int flag);
>   #endif /* TARGET_LOONGARCH_CSR_H */
> diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
> index 3249ab7ac6..b282da6ea6 100644
> --- a/target/loongarch/disas.c
> +++ b/target/loongarch/disas.c
> @@ -698,6 +698,16 @@ INSN(tlbfill,      empty)
>   INSN(tlbclr,       empty)
>   INSN(tlbflush,     empty)
>   INSN(invtlb,       i_rr)
> +INSN(gcsrrd,       r_csr)
> +INSN(gcsrwr,       r_csr)
> +INSN(gcsrxchg,     rr_csr)
> +INSN(gtlbclr,      empty)
> +INSN(gtlbflush,    empty)
> +INSN(gtlbsrch,     empty)
> +INSN(gtlbrd,       empty)
> +INSN(gtlbwr,       empty)
> +INSN(gtlbfill,     empty)
> +INSN(hvcl,         i)
>   INSN(cacop,        cop_r_i)
>   INSN(lddir,        rr_i)
>   INSN(ldpte,        j_i)
> diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
> index 3089d42044..b19c40b423 100644
> --- a/target/loongarch/insns.decode
> +++ b/target/loongarch/insns.decode
> @@ -493,6 +493,23 @@ bgeu            0110 11 ................ ..... .....     @rr_offs16
>     csrxchg           0000 0100 .............. ..... .....     @rr_csr
>   }
>   
> +#
> +# LVZ (LoongArch Virtualization) instructions
> +#
> +{
> +  gcsrrd            0000 0101 .............. 00000 .....     @r_csr
> +  gcsrwr            0000 0101 .............. 00001 .....     @r_csr
> +  gcsrxchg          0000 0101 .............. ..... .....     @rr_csr
> +}
> +
> +gtlbclr          0000 01100100 10000 01000 00000 00001    @empty
> +gtlbflush        0000 01100100 10000 01001 00000 00001    @empty
> +gtlbsrch         0000 01100100 10000 01010 00000 00001    @empty
> +gtlbrd           0000 01100100 10000 01011 00000 00001    @empty
> +gtlbwr           0000 01100100 10000 01100 00000 00001    @empty
> +gtlbfill         0000 01100100 10000 01101 00000 00001    @empty
> +hvcl             0000 0000 0010 1011 1 ...............    @i15
> +
>   iocsrrd_b        0000 01100100 10000 00000 ..... .....    @rr
>   iocsrrd_h        0000 01100100 10000 00001 ..... .....    @rr
>   iocsrrd_w        0000 01100100 10000 00010 ..... .....    @rr
> diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
> index e01dbed40f..8a06ab9868 100644
> --- a/target/loongarch/internals.h
> +++ b/target/loongarch/internals.h
> @@ -32,14 +32,18 @@ void restore_fp_status(CPULoongArchState *env);
>   extern const VMStateDescription vmstate_loongarch_cpu;
>   
>   void loongarch_cpu_set_irq(void *opaque, int irq, int level);
> +void loongarch_cpu_set_irq_guest(void *opaque, int irq, int level);
>   
>   void loongarch_constant_timer_cb(void *opaque);
> +void loongarch_constant_timer_cb_guest(void *opaque);
>   uint64_t cpu_loongarch_get_constant_timer_counter(LoongArchCPU *cpu);
> -uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu);
> +uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu, bool guest);
> +void cpu_loongarch_set_guest_timer(LoongArchCPU *cpu, bool on);
>   void cpu_loongarch_store_constant_timer_config(LoongArchCPU *cpu,
> -                                               uint64_t value);
> +                                               uint64_t value, bool guest);
>   bool loongarch_cpu_has_work(CPUState *cs);
>   bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env);
> +bool loongarch_guest_has_interrupt(CPULoongArchState *env);
>   #endif /* !CONFIG_USER_ONLY */
>   
>   uint64_t read_fcc(CPULoongArchState *env);
> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
> index 9d844c4905..114f115e90 100644
> --- a/target/loongarch/kvm/kvm.c
> +++ b/target/loongarch/kvm/kvm.c
> @@ -28,6 +28,7 @@
>   #include "cpu-csr.h"
>   #include "kvm_loongarch.h"
>   #include "trace.h"
> +#include "exec/target_long.h"
>   
>   static bool cap_has_mp_state;
>   static unsigned int brk_insn;
> diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
> index 4db53fec26..df7a7c9075 100644
> --- a/target/loongarch/machine.c
> +++ b/target/loongarch/machine.c
> @@ -197,11 +197,101 @@ static const VMStateDescription vmstate_tlb = {
>       .version_id = 0,
>       .minimum_version_id = 0,
>       .needed = tlb_needed,
> -    .fields = (const VMStateField[]) {
> -        VMSTATE_STRUCT_ARRAY(env.tlb, LoongArchCPU, LOONGARCH_TLB_MAX,
> -                             0, vmstate_tlb_entry, LoongArchTLB),
> -        VMSTATE_END_OF_LIST()
> -    }
> +    .fields =
> +        (const VMStateField[]){
> +            VMSTATE_STRUCT_ARRAY(env.tlb, LoongArchCPU, LOONGARCH_TLB_MAX, 0,
> +                                 vmstate_tlb_entry, LoongArchTLB),
> +            VMSTATE_END_OF_LIST() }
> +};
> +
> +static bool lvz_needed(void *opaque)
> +{
> +    LoongArchCPU *cpu = opaque;
> +
> +    return FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, LVZ);
> +}
> +
> +static const VMStateDescription vmstate_lvz = {
> +    .name = "cpu/lvz",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = lvz_needed,
> +    .fields =
> +        (const VMStateField[]){
> +            VMSTATE_UINT64(env.CSR_GSTAT, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_GCFG, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_GINTC, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_GCNTC, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_GTLBC, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_TRGP, LoongArchCPU),
> +
> +            VMSTATE_UINT64(env.GCSR_CRMD, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_PRMD, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_EUEN, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_MISC, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_ECFG, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_ESTAT, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_ERA, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_BADV, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_BADI, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_EENTRY, LoongArchCPU),
> +
> +            VMSTATE_UINT64(env.GCSR_TLBIDX, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_TLBEHI, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_TLBELO0, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_TLBELO1, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_ASID, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_PGDL, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_PGDH, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_PGD, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_PWCL, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_PWCH, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_STLBPS, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_RVACFG, LoongArchCPU),
> +
> +            VMSTATE_UINT64(env.GCSR_CPUID, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_PRCFG1, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_PRCFG2, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_PRCFG3, LoongArchCPU),
> +            VMSTATE_UINT64_ARRAY(env.GCSR_SAVE, LoongArchCPU, 16),
> +
> +            VMSTATE_UINT64(env.GCSR_TID, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_TCFG, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_TVAL, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_CNTC, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_TICLR, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_LLBCTL, LoongArchCPU),
> +
> +            VMSTATE_UINT64(env.GCSR_IMPCTL1, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_IMPCTL2, LoongArchCPU),
> +
> +            VMSTATE_UINT64(env.GCSR_TLBRENTRY, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_TLBRBADV, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_TLBRERA, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_TLBRSAVE, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_TLBRELO0, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_TLBRELO1, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_TLBREHI, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_TLBRPRMD, LoongArchCPU),
> +
> +            VMSTATE_UINT64(env.GCSR_MERRCTL, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_MERRINFO1, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_MERRINFO2, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_MERRENTRY, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_MERRERA, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_MERRSAVE, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_CTAG, LoongArchCPU),
> +
> +            VMSTATE_UINT64_ARRAY(env.GCSR_DMW, LoongArchCPU, 4),
> +
> +            VMSTATE_UINT64(env.GCSR_DBG, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_DERA, LoongArchCPU),
> +            VMSTATE_UINT64(env.GCSR_DSAVE, LoongArchCPU),
> +
> +            VMSTATE_BOOL(env.guest, LoongArchCPU),
> +            VMSTATE_STRUCT_ARRAY(env.gtlb, LoongArchCPU, LOONGARCH_TLB_MAX, 0,
> +                                 vmstate_tlb_entry, LoongArchTLB),
> +            VMSTATE_END_OF_LIST() },
>   };
>   #endif
>   
> @@ -210,83 +300,78 @@ const VMStateDescription vmstate_loongarch_cpu = {
>       .name = "cpu",
>       .version_id = 4,
>       .minimum_version_id = 4,
> -    .fields = (const VMStateField[]) {
> -        VMSTATE_UINT64_ARRAY(env.gpr, LoongArchCPU, 32),
> -        VMSTATE_UINT64(env.pc, LoongArchCPU),
> -
> -        /* Remaining CSRs */
> -        VMSTATE_UINT64(env.CSR_CRMD, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_PRMD, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_EUEN, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_MISC, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_ECFG, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_ESTAT, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_ERA, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_BADV, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_BADI, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_EENTRY, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_TLBIDX, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_TLBEHI, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_TLBELO0, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_TLBELO1, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_ASID, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_PGDL, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_PGDH, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_PGD, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_PWCL, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_PWCH, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_STLBPS, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_RVACFG, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_PRCFG1, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_PRCFG2, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_PRCFG3, LoongArchCPU),
> -        VMSTATE_UINT64_ARRAY(env.CSR_SAVE, LoongArchCPU, 16),
> -        VMSTATE_UINT64(env.CSR_TID, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_TCFG, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_TVAL, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_CNTC, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_TICLR, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_LLBCTL, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_IMPCTL1, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_IMPCTL2, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_TLBRENTRY, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_TLBRBADV, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_TLBRERA, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_TLBRSAVE, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_TLBRELO0, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_TLBRELO1, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_TLBREHI, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_TLBRPRMD, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_MERRCTL, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_MERRINFO1, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_MERRINFO2, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_MERRENTRY, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_MERRERA, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_MERRSAVE, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_CTAG, LoongArchCPU),
> -        VMSTATE_UINT64_ARRAY(env.CSR_DMW, LoongArchCPU, 4),
> -
> -        /* Debug CSRs */
> -        VMSTATE_UINT64(env.CSR_DBG, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_DERA, LoongArchCPU),
> -        VMSTATE_UINT64(env.CSR_DSAVE, LoongArchCPU),
> -
> -        VMSTATE_UINT64(kvm_state_counter, LoongArchCPU),
> -        /* PV steal time */
> -        VMSTATE_UINT64(env.stealtime.guest_addr, LoongArchCPU),
> -
> -        VMSTATE_END_OF_LIST()
> -    },
> -    .subsections = (const VMStateDescription * const []) {
> -        &vmstate_fpu,
> -        &vmstate_lsx,
> -        &vmstate_lasx,
> +    .fields =
> +        (const VMStateField[]){
> +            VMSTATE_UINT64_ARRAY(env.gpr, LoongArchCPU, 32),
> +            VMSTATE_UINT64(env.pc, LoongArchCPU),
> +
> +            /* Remaining CSRs */
> +            VMSTATE_UINT64(env.CSR_CRMD, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_PRMD, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_EUEN, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_MISC, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_ECFG, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_ESTAT, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_ERA, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_BADV, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_BADI, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_EENTRY, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_TLBIDX, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_TLBEHI, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_TLBELO0, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_TLBELO1, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_ASID, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_PGDL, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_PGDH, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_PGD, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_PWCL, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_PWCH, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_STLBPS, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_RVACFG, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_PRCFG1, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_PRCFG2, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_PRCFG3, LoongArchCPU),
> +            VMSTATE_UINT64_ARRAY(env.CSR_SAVE, LoongArchCPU, 16),
> +            VMSTATE_UINT64(env.CSR_TID, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_TCFG, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_TVAL, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_CNTC, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_TICLR, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_LLBCTL, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_IMPCTL1, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_IMPCTL2, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_TLBRENTRY, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_TLBRBADV, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_TLBRERA, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_TLBRSAVE, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_TLBRELO0, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_TLBRELO1, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_TLBREHI, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_TLBRPRMD, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_MERRCTL, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_MERRINFO1, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_MERRINFO2, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_MERRENTRY, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_MERRERA, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_MERRSAVE, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_CTAG, LoongArchCPU),
> +            VMSTATE_UINT64_ARRAY(env.CSR_DMW, LoongArchCPU, 4),
> +
> +            /* Debug CSRs */
> +            VMSTATE_UINT64(env.CSR_DBG, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_DERA, LoongArchCPU),
> +            VMSTATE_UINT64(env.CSR_DSAVE, LoongArchCPU),
> +
> +            VMSTATE_UINT64(kvm_state_counter, LoongArchCPU),
> +            /* PV steal time */
> +            VMSTATE_UINT64(env.stealtime.guest_addr, LoongArchCPU),
> +
> +            VMSTATE_END_OF_LIST() },
> +    .subsections =
> +        (const VMStateDescription *const[]) {
> +            &vmstate_fpu, &vmstate_lsx, &vmstate_lasx,
>   #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
> -        &vmstate_tlb,
> +            &vmstate_tlb, &vmstate_lvz,
>   #endif
> -        &vmstate_lbt,
> -        &vmstate_msgint,
> -        &vmstate_pmu,
> -        NULL
> -    }
> +            &vmstate_lbt, &vmstate_msgint, &vmstate_pmu, NULL }
>   };
> diff --git a/target/loongarch/tcg/constant_timer.c b/target/loongarch/tcg/constant_timer.c
> index 1851f53fd6..97892e3ff9 100644
> --- a/target/loongarch/tcg/constant_timer.c
> +++ b/target/loongarch/tcg/constant_timer.c
> @@ -20,29 +20,62 @@ uint64_t cpu_loongarch_get_constant_timer_counter(LoongArchCPU *cpu)
>       return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / TIMER_PERIOD;
>   }
>   
> -uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu)
> +uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu, bool guest)
>   {
>       uint64_t now, expire;
> +    CPULoongArchState *env = &cpu->env;
> +
> +    if (guest && !env->guest) {
> +        return env->GCSR_TVAL;
> +    }
>   
>       now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> -    expire = timer_expire_time_ns(&cpu->timer);
> +    expire = timer_expire_time_ns(guest ? &cpu->guest_timer : &cpu->timer);
>   
>       return (expire - now) / TIMER_PERIOD;
>   }
>   
>   void cpu_loongarch_store_constant_timer_config(LoongArchCPU *cpu,
> -                                               uint64_t value)
> +                                               uint64_t value, bool guest)
>   {
>       CPULoongArchState *env = &cpu->env;
>       uint64_t now, next;
> +    QEMUTimer *timer = guest ? &cpu->guest_timer : &cpu->timer;
> +
> +    SET_CSR_IF(guest, TCFG, value);
> +
> +    if (guest && !env->guest) {
> +        return;
> +    }
>   
> -    env->CSR_TCFG = value;
>       if (value & CONSTANT_TIMER_ENABLE) {
>           now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>           next = now + (value & CONSTANT_TIMER_TICK_MASK) * TIMER_PERIOD;
> -        timer_mod(&cpu->timer, next);
> +        timer_mod(timer, next);
>       } else {
> -        timer_del(&cpu->timer);
> +        timer_del(timer);
> +    }
> +}
> +
> +void cpu_loongarch_set_guest_timer(LoongArchCPU *cpu, bool on)
> +{
> +    CPULoongArchState *env = &cpu->env;
> +    uint64_t now, next, ticks;
> +
> +    if (!(env->GCSR_TCFG & CONSTANT_TIMER_ENABLE)) {
> +        return;
> +    }
> +
> +    if (on) {
> +        now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +        ticks = env->GCSR_TVAL ? env->GCSR_TVAL :
> +                                 (env->GCSR_TCFG & CONSTANT_TIMER_TICK_MASK);
> +        next = now + ticks * TIMER_PERIOD;
> +        env->GCSR_TVAL = 0;
> +        timer_mod(&cpu->guest_timer, next);
> +    } else {
> +        env->GCSR_TVAL = cpu_loongarch_get_constant_timer_ticks(cpu, true);
> +        timer_del(&cpu->guest_timer);
>       }
>   }
>   
> @@ -62,3 +95,20 @@ void loongarch_constant_timer_cb(void *opaque)
>   
>       loongarch_cpu_set_irq(opaque, IRQ_TIMER, 1);
>   }
> +
> +void loongarch_constant_timer_cb_guest(void *opaque)
> +{
> +    LoongArchCPU *cpu = opaque;
> +    CPULoongArchState *env = &cpu->env;
> +    uint64_t now, next;
> +
> +    if (FIELD_EX64(env->GCSR_TCFG, CSR_TCFG, PERIODIC)) {
> +        now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +        next = now + (env->GCSR_TCFG & CONSTANT_TIMER_TICK_MASK) * TIMER_PERIOD;
> +        timer_mod(&cpu->guest_timer, next);
> +    } else {
> +        env->GCSR_TCFG = FIELD_DP64(env->GCSR_TCFG, CSR_TCFG, EN, 0);
> +    }
> +
> +    loongarch_cpu_set_irq_guest(opaque, IRQ_TIMER, 1);
> +}
> diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
> index cd35ca93c7..a680c6cbfe 100644
> --- a/target/loongarch/tcg/csr_helper.c
> +++ b/target/loongarch/tcg/csr_helper.c
> @@ -58,6 +58,25 @@ target_ulong helper_csrrd_pgd(CPULoongArchState *env)
>       return v;
>   }
>   
> +target_ulong helper_gcsrrd_pgd(CPULoongArchState *env)
> +{
> +    int64_t v;
> +
> +    if (env->GCSR_TLBRERA & 0x1) {
> +        v = env->GCSR_TLBRBADV;
> +    } else {
> +        v = env->GCSR_BADV;
> +    }
> +
> +    if ((v >> 63) & 0x1) {
> +        v = env->GCSR_PGDH;
> +    } else {
> +        v = env->GCSR_PGDL;
> +    }
> +
> +    return v;
> +}
> +
>   target_ulong helper_csrrd_cpuid(CPULoongArchState *env)
>   {
>       LoongArchCPU *lac = env_archcpu(env);
> @@ -71,7 +90,14 @@ target_ulong helper_csrrd_tval(CPULoongArchState *env)
>   {
>       LoongArchCPU *cpu = env_archcpu(env);
>   
> -    return cpu_loongarch_get_constant_timer_ticks(cpu);
> +    return cpu_loongarch_get_constant_timer_ticks(cpu, false);
> +}
> +
> +target_ulong helper_gcsrrd_tval(CPULoongArchState *env)
> +{
> +    LoongArchCPU *cpu = env_archcpu(env);
> +
> +    return cpu_loongarch_get_constant_timer_ticks(cpu, true);
>   }
>   
>   target_ulong helper_csrrd_msgir(CPULoongArchState *env)
> @@ -105,6 +131,27 @@ target_ulong helper_csrwr_estat(CPULoongArchState *env, target_ulong val)
>       return old_v;
>   }
>   
> +target_ulong helper_gcsrwr_estat(CPULoongArchState *env, target_ulong val)
> +{
> +    int64_t old_v = env->GCSR_ESTAT;
> +
> +    env->GCSR_ESTAT = deposit64(env->GCSR_ESTAT, 0, 2, val);
> +    if (!env->guest) {
> +        env->GCSR_ESTAT =
> +            deposit64(env->GCSR_ESTAT, 2, 11, extract64(val, 2, 11));
> +        if (extract64(val, 2, 8) &
> +            FIELD_EX64(env->CSR_GINTC, CSR_GINTC, HWIC)) {
> +            env->CSR_ESTAT = deposit64(env->CSR_ESTAT, 2, 8,
> +                                       extract64(env->CSR_ESTAT, 2, 8) &
> +                                           ~extract64(val, 2, 8));
> +        }
> +        env->GCSR_ESTAT =
> +            deposit64(env->GCSR_ESTAT, 16, 15, extract64(val, 16, 15));
> +    }
> +
> +    return old_v;
> +}
> +
>   target_ulong helper_csrwr_asid(CPULoongArchState *env, target_ulong val)
>   {
>       int64_t old_v = env->CSR_ASID;
> @@ -117,12 +164,33 @@ target_ulong helper_csrwr_asid(CPULoongArchState *env, target_ulong val)
>       return old_v;
>   }
>   
> +target_ulong helper_gcsrwr_asid(CPULoongArchState *env, target_ulong val)
> +{
> +    int64_t old_v = env->GCSR_ASID;
> +
> +    env->GCSR_ASID = deposit64(env->GCSR_ASID, 0, 10, val);
> +    if (old_v != env->GCSR_ASID) {
> +        tlb_flush(env_cpu(env));
> +    }
> +    return old_v;
> +}
> +
>   target_ulong helper_csrwr_tcfg(CPULoongArchState *env, target_ulong val)
>   {
>       LoongArchCPU *cpu = env_archcpu(env);
>       int64_t old_v = env->CSR_TCFG;
>   
> -    cpu_loongarch_store_constant_timer_config(cpu, val);
> +    cpu_loongarch_store_constant_timer_config(cpu, val, false);
> +
> +    return old_v;
> +}
> +
> +target_ulong helper_gcsrwr_tcfg(CPULoongArchState *env, target_ulong val)
> +{
> +    LoongArchCPU *cpu = env_archcpu(env);
> +    int64_t old_v = env->GCSR_TCFG;
> +
> +    cpu_loongarch_store_constant_timer_config(cpu, val, true);
>   
>       return old_v;
>   }
> @@ -140,6 +208,61 @@ target_ulong helper_csrwr_ticlr(CPULoongArchState *env, target_ulong val)
>       return old_v;
>   }
>   
> +target_ulong helper_gcsrwr_ticlr(CPULoongArchState *env, target_ulong val)
> +{
> +    LoongArchCPU *cpu = env_archcpu(env);
> +    int64_t old_v = 0;
> +
> +    if (val & 0x1) {
> +        bql_lock();
> +        loongarch_cpu_set_irq_guest(cpu, IRQ_TIMER, 0);
> +        bql_unlock();
> +    }
> +    return old_v;
> +}
> +
> +target_ulong helper_csrwr_gstat(CPULoongArchState *env, target_ulong val)
> +{
> +    int64_t old_v = env->CSR_GSTAT;
> +    uint8_t old_gid = FIELD_EX64(env->CSR_GSTAT, CSR_GSTAT, GID);
> +
> +    env->CSR_GSTAT = FIELD_DP64(env->CSR_GSTAT, CSR_GSTAT, PVM,
> +                                FIELD_EX64(val, CSR_GSTAT, PVM));
> +    env->CSR_GSTAT = FIELD_DP64(env->CSR_GSTAT, CSR_GSTAT, GID,
> +                                FIELD_EX64(val, CSR_GSTAT, GID));
> +
> +    if (old_gid != FIELD_EX64(env->CSR_GSTAT, CSR_GSTAT, GID)) {
> +        tlb_flush(env_cpu(env));
> +    }
> +
> +    return old_v;
> +}
> +
> +target_ulong helper_csrwr_gtlbc(CPULoongArchState *env, target_ulong val)
> +{
> +    int64_t old_v = env->CSR_GTLBC;
> +    uint8_t old_use_tgid = FIELD_EX64(old_v, CSR_GTLBC, USETGID);
> +    uint8_t old_tgid = FIELD_EX64(old_v, CSR_GTLBC, TGID);
> +
> +    env->CSR_GTLBC = val;
> +    if (old_use_tgid != FIELD_EX64(env->CSR_GTLBC, CSR_GTLBC, USETGID) ||
> +        old_tgid != FIELD_EX64(env->CSR_GTLBC, CSR_GTLBC, TGID)) {
> +        tlb_flush(env_cpu(env));
> +    }
> +
> +    return old_v;
> +}
> +
> +target_ulong helper_csrwr_gintc(CPULoongArchState *env, target_ulong val)
> +{
> +    int64_t old_v = env->CSR_GINTC;
> +
> +    env->CSR_GINTC = val & 0xffff00;
> +    env->GCSR_ESTAT = deposit64(env->GCSR_ESTAT, 2, 8, extract64(val, 0, 8));
> +
> +    return old_v;
> +}
> +
>   target_ulong helper_csrwr_pwcl(CPULoongArchState *env, target_ulong val)
>   {
>       uint8_t shift, ptbase;
> diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
> index 8a6c62f116..648328a7ef 100644
> --- a/target/loongarch/tcg/helper.h
> +++ b/target/loongarch/tcg/helper.h
> @@ -14,7 +14,7 @@ DEF_HELPER_FLAGS_3(asrtgt_d, TCG_CALL_NO_WG, void, env, tl, tl)
>   
>   DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, tl, tl, tl, tl)
>   DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, tl, tl, tl, tl)
> -DEF_HELPER_FLAGS_2(cpucfg, TCG_CALL_NO_RWG_SE, tl, env, tl)
> +DEF_HELPER_FLAGS_2(cpucfg, TCG_CALL_NO_WG_SE, tl, env, tl)
>   
>   /* Floating-point helper */
>   DEF_HELPER_FLAGS_3(fadd_s, TCG_CALL_NO_WG, i64, env, i64, i64)
> @@ -98,14 +98,23 @@ DEF_HELPER_1(rdtime_d, i64, env)
>   #ifndef CONFIG_USER_ONLY
>   /* CSRs helper */
>   DEF_HELPER_1(csrrd_pgd, i64, env)
> +DEF_HELPER_1(gcsrrd_pgd, i64, env)
>   DEF_HELPER_1(csrrd_cpuid, i64, env)
>   DEF_HELPER_1(csrrd_tval, i64, env)
> +DEF_HELPER_1(gcsrrd_tval, i64, env)
>   DEF_HELPER_1(csrrd_msgir, i64, env)
>   DEF_HELPER_2(csrwr_stlbps, i64, env, tl)
>   DEF_HELPER_2(csrwr_estat, i64, env, tl)
> +DEF_HELPER_2(gcsrwr_estat, i64, env, tl)
>   DEF_HELPER_2(csrwr_asid, i64, env, tl)
> +DEF_HELPER_2(gcsrwr_asid, i64, env, tl)
>   DEF_HELPER_2(csrwr_tcfg, i64, env, tl)
> +DEF_HELPER_2(gcsrwr_tcfg, i64, env, tl)
>   DEF_HELPER_2(csrwr_ticlr, i64, env, tl)
> +DEF_HELPER_2(gcsrwr_ticlr, i64, env, tl)
> +DEF_HELPER_2(csrwr_gstat, i64, env, tl)
> +DEF_HELPER_2(csrwr_gtlbc, i64, env, tl)
> +DEF_HELPER_2(csrwr_gintc, i64, env, tl)
>   DEF_HELPER_2(csrwr_pwcl, i64, env, tl)
>   DEF_HELPER_2(csrwr_pwch, i64, env, tl)
>   DEF_HELPER_2(iocsrrd_b, i64, env, tl)
> @@ -124,16 +133,25 @@ DEF_HELPER_1(tlbsrch, void, env)
>   DEF_HELPER_1(tlbrd, void, env)
>   DEF_HELPER_1(tlbclr, void, env)
>   DEF_HELPER_1(tlbflush, void, env)
> -DEF_HELPER_1(invtlb_all, void, env)
> -DEF_HELPER_2(invtlb_all_g, void, env, i32)
> -DEF_HELPER_2(invtlb_all_asid, void, env, tl)
> -DEF_HELPER_3(invtlb_page_asid, void, env, tl, tl)
> -DEF_HELPER_3(invtlb_page_asid_or_g, void, env, tl, tl)
> +DEF_HELPER_4(invtlb_all, void, env, tl, i32, i32)
> +DEF_HELPER_4(invtlb_all_g, void, env, tl, i32, i32)
> +DEF_HELPER_3(invtlb_all_asid, void, env, tl, i32)
> +DEF_HELPER_4(invtlb_page_asid, void, env, tl, tl, i32)
> +DEF_HELPER_4(invtlb_page_asid_or_g, void, env, tl, tl, i32)
> +
> +DEF_HELPER_1(gtlbwr, void, env)
> +DEF_HELPER_1(gtlbfill, void, env)
> +DEF_HELPER_1(gtlbsrch, void, env)
> +DEF_HELPER_1(gtlbrd, void, env)
> +DEF_HELPER_1(gtlbclr, void, env)
> +DEF_HELPER_1(gtlbflush, void, env)
>   
>   DEF_HELPER_4(lddir, tl, env, tl, i32, i32)
>   DEF_HELPER_4(ldpte, void, env, tl, tl, i32)
>   DEF_HELPER_1(ertn, void, env)
>   DEF_HELPER_1(idle, void, env)
> +DEF_HELPER_2(hvcl, void, env, i32)
> +DEF_HELPER_1(gspr, void, env)
>   #endif
>   
>   /* LoongArch LSX  */
> diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> index 2094d182ac..19b02e6a78 100644
> --- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> @@ -39,6 +39,16 @@ GEN_FALSE_TRANS(lddir)
>   GEN_FALSE_TRANS(ertn)
>   GEN_FALSE_TRANS(dbcl)
>   GEN_FALSE_TRANS(idle)
> +GEN_FALSE_TRANS(gcsrrd)
> +GEN_FALSE_TRANS(gcsrwr)
> +GEN_FALSE_TRANS(gcsrxchg)
> +GEN_FALSE_TRANS(gtlbclr)
> +GEN_FALSE_TRANS(gtlbflush)
> +GEN_FALSE_TRANS(gtlbsrch)
> +GEN_FALSE_TRANS(gtlbrd)
> +GEN_FALSE_TRANS(gtlbwr)
> +GEN_FALSE_TRANS(gtlbfill)
> +GEN_FALSE_TRANS(hvcl)
>   
>   #else
>   
> @@ -69,8 +79,25 @@ static bool set_csr_trans_func(unsigned int csr_num, GenCSRRead readfn,
>       return true;
>   }
>   
> +static bool set_gcsr_trans_func(unsigned int csr_num, GenCSRRead readfn,
> +                                GenCSRWrite writefn)
> +{
> +    CSRInfo *csr;
> +
> +    csr = get_gcsr(csr_num);
> +    if (!csr) {
> +        return false;
> +    }
> +
> +    csr->readfn = (GenCSRFunc)readfn;
> +    csr->writefn = (GenCSRFunc)writefn;
> +    return true;
> +}
> +
>   #define SET_CSR_FUNC(NAME, read, write)                 \
>           set_csr_trans_func(LOONGARCH_CSR_##NAME, read, write)
> +#define SET_GCSR_FUNC(NAME, read, write)                \
> +        set_gcsr_trans_func(LOONGARCH_CSR_##NAME, read, write)
>   
>   void loongarch_csr_translate_init(void)
>   {
> @@ -85,14 +112,28 @@ void loongarch_csr_translate_init(void)
>       SET_CSR_FUNC(TVAL,  gen_helper_csrrd_tval, NULL);
>       SET_CSR_FUNC(TICLR, NULL, gen_helper_csrwr_ticlr);
>       SET_CSR_FUNC(MSGIR, gen_helper_csrrd_msgir, NULL);
> +    SET_CSR_FUNC(GSTAT, NULL, gen_helper_csrwr_gstat);
> +    SET_CSR_FUNC(GTLBC, NULL, gen_helper_csrwr_gtlbc);
> +    SET_CSR_FUNC(GINTC, NULL, gen_helper_csrwr_gintc);
> +
> +    SET_GCSR_FUNC(ESTAT, NULL, gen_helper_gcsrwr_estat);
> +    SET_GCSR_FUNC(ASID, NULL, gen_helper_gcsrwr_asid);
> +    SET_GCSR_FUNC(PGD, gen_helper_gcsrrd_pgd, NULL);
> +    SET_GCSR_FUNC(TCFG, NULL, gen_helper_gcsrwr_tcfg);
> +    SET_GCSR_FUNC(TVAL, gen_helper_gcsrrd_tval, NULL);
> +    SET_GCSR_FUNC(TICLR, NULL, gen_helper_gcsrwr_ticlr);
>   }
>   #undef SET_CSR_FUNC
> +#undef SET_GCSR_FUNC
>   
>   static bool check_csr_flags(DisasContext *ctx, const CSRInfo *csr, bool write)
>   {
>       if ((csr->flags & CSRFL_READONLY) && write) {
>           return false;
>       }
> +    if ((csr->flags & CSRFL_GUEST_READONLY) && ctx->guest_mode && write) {
> +        return false;
> +    }
>       if ((csr->flags & CSRFL_IO) && translator_io_start(&ctx->base)) {
>           ctx->base.is_jmp = DISAS_EXIT_UPDATE;
>       } else if ((csr->flags & CSRFL_EXITTB) && write) {
> @@ -110,12 +151,17 @@ static bool trans_csrrd(DisasContext *ctx, arg_csrrd *a)
>       if (check_plv(ctx)) {
>           return false;
>       }
> -    csr = get_csr(a->csr);
> +    csr = ctx->guest_mode ? get_gcsr(a->csr) : get_csr(a->csr);
>       if (csr == NULL) {
>           /* CSR is undefined: read as 0. */
>           dest = tcg_constant_tl(0);
>       } else {
>           check_csr_flags(ctx, csr, false);
> +        if (ctx->guest_mode && (csr->flags & CSRFL_GSPR)) {
> +            gen_helper_gspr(tcg_env);
> +            gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
> +            return true;
> +        }
>           dest = gpr_dst(ctx, a->rd, EXT_NONE);
>           readfn = (GenCSRRead)csr->readfn;
>           if (readfn) {
> @@ -137,12 +183,17 @@ static bool trans_csrwr(DisasContext *ctx, arg_csrwr *a)
>       if (check_plv(ctx)) {
>           return false;
>       }
> -    csr = get_csr(a->csr);
> +    csr = ctx->guest_mode ? get_gcsr(a->csr) : get_csr(a->csr);
>       if (csr == NULL) {
>           /* CSR is undefined: write ignored, read old_value as 0. */
>           gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
>           return true;
>       }
> +    if (ctx->guest_mode && (csr->flags & CSRFL_GSPR)) {
> +        gen_helper_gspr(tcg_env);
> +        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
> +        return true;
> +    }
>       if (!check_csr_flags(ctx, csr, true)) {
>           /* CSR is readonly: trap. */
>           return false;
> @@ -170,28 +221,35 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
>       if (check_plv(ctx)) {
>           return false;
>       }
> -    csr = get_csr(a->csr);
> +    csr = ctx->guest_mode ? get_gcsr(a->csr) : get_csr(a->csr);
>       if (csr == NULL) {
>           /* CSR is undefined: write ignored, read old_value as 0. */
>           gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
>           return true;
>       }
> +    if (ctx->guest_mode && (csr->flags & CSRFL_GSPR)) {
> +        gen_helper_gspr(tcg_env);
> +        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
> +        return true;
> +    }
>   
>       if (!check_csr_flags(ctx, csr, true)) {
>           /* CSR is readonly: trap. */
>           return false;
>       }
>   
> -    /* So far only readonly csrs have readfn. */
> -    assert(csr->readfn == NULL);
> -
>       src1 = gpr_src(ctx, a->rd, EXT_NONE);
>       mask = gpr_src(ctx, a->rj, EXT_NONE);
>       oldv = tcg_temp_new();
>       newv = tcg_temp_new();
>       temp = tcg_temp_new();
>   
> -    tcg_gen_ld_tl(oldv, tcg_env, csr->offset);
> +    if (csr->readfn) {
> +        GenCSRRead readfn = (GenCSRRead)csr->readfn;
> +        readfn(oldv, tcg_env);
> +    } else {
> +        tcg_gen_ld_tl(oldv, tcg_env, csr->offset);
> +    }
>       tcg_gen_and_tl(newv, src1, mask);
>       tcg_gen_andc_tl(temp, oldv, mask);
>       tcg_gen_or_tl(newv, newv, temp);
> @@ -212,6 +270,11 @@ static bool gen_iocsrrd(DisasContext *ctx, arg_rr *a,
>       TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
>       TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
>   
> +    if (ctx->guest_mode) {
> +        gen_helper_gspr(tcg_env);
> +        return true;
> +    }
> +
>       if (check_plv(ctx)) {
>           return false;
>       }
> @@ -225,6 +288,11 @@ static bool gen_iocsrwr(DisasContext *ctx, arg_rr *a,
>       TCGv val = gpr_src(ctx, a->rd, EXT_NONE);
>       TCGv addr = gpr_src(ctx, a->rj, EXT_NONE);
>   
> +    if (ctx->guest_mode) {
> +        gen_helper_gspr(tcg_env);
> +        return true;
> +    }
> +
>       if (check_plv(ctx)) {
>           return false;
>       }
> @@ -243,7 +311,7 @@ TRANS64(iocsrwr_d, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_d)
>   
>   static void check_mmu_idx(DisasContext *ctx)
>   {
> -    if (ctx->mem_idx != MMU_DA_IDX) {
> +    if (ctx->mem_idx != MMU_DA_IDX && ctx->mem_idx != MMU_GUEST_DA_IDX) {
>           tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next + 4);
>           ctx->base.is_jmp = DISAS_EXIT;
>       }
> @@ -316,25 +384,61 @@ static bool trans_invtlb(DisasContext *ctx, arg_invtlb *a)
>           return false;
>       }
>   
> +    if (!avail_LVZ(ctx) && a->imm > 0x6) {
> +        return false;
> +    }
> +
> +    //TODO: futher refinement of op 0x9 and 0x10-0x16
>       switch (a->imm) {
> -    case 0:
> -    case 1:
> -        gen_helper_invtlb_all(tcg_env);
> +    case 0x0:
> +    case 0x1:
> +        gen_helper_invtlb_all(tcg_env, rj, tcg_constant_i32(a->imm),
> +                              tcg_constant_i32(0));
> +        break;
> +    case 0x2:
> +        gen_helper_invtlb_all_g(tcg_env, rj, tcg_constant_i32(1),
> +                                tcg_constant_i32(0));
> +        break;
> +    case 0x3:
> +        gen_helper_invtlb_all_g(tcg_env, rj, tcg_constant_i32(0),
> +                                tcg_constant_i32(0));
> +        break;
> +    case 0x4:
> +        gen_helper_invtlb_all_asid(tcg_env, rj, tcg_constant_i32(0));
> +        break;
> +    case 0x5:
> +        gen_helper_invtlb_page_asid(tcg_env, rj, rk, tcg_constant_i32(0));
>           break;
> -    case 2:
> -        gen_helper_invtlb_all_g(tcg_env, tcg_constant_i32(1));
> +    case 0x6:
> +        gen_helper_invtlb_page_asid_or_g(tcg_env, rj, rk, tcg_constant_i32(0));
>           break;
> -    case 3:
> -        gen_helper_invtlb_all_g(tcg_env, tcg_constant_i32(0));
> +    case 0x9:
> +    case 0x10:
> +    case 0x11:
> +    case 0x12:
> +    case 0x13:
> +    case 0x14:
> +    case 0x15:
> +    case 0x16:
> +        gen_helper_invtlb_all(tcg_env, rj, tcg_constant_i32(0),
> +                              tcg_constant_i32(0));
>           break;
> -    case 4:
> -        gen_helper_invtlb_all_asid(tcg_env, rj);
> +    case 0xa:
> +        gen_helper_invtlb_all_g(tcg_env, rj, tcg_constant_i32(1),
> +                                tcg_constant_i32(1));
>           break;
> -    case 5:
> -        gen_helper_invtlb_page_asid(tcg_env, rj, rk);
> +    case 0xb:
> +        gen_helper_invtlb_all_g(tcg_env, rj, tcg_constant_i32(0),
> +                                tcg_constant_i32(1));
>           break;
> -    case 6:
> -        gen_helper_invtlb_page_asid_or_g(tcg_env, rj, rk);
> +    case 0xc:
> +        gen_helper_invtlb_all_asid(tcg_env, rj, tcg_constant_i32(1));
> +        break;
> +    case 0xd:
> +        gen_helper_invtlb_page_asid(tcg_env, rj, rk, tcg_constant_i32(1));
> +        break;
> +    case 0xe:
> +        gen_helper_invtlb_page_asid_or_g(tcg_env, rj, rk, tcg_constant_i32(1));
>           break;
>       default:
>           return false;
> @@ -400,6 +504,10 @@ static bool trans_dbcl(DisasContext *ctx, arg_dbcl *a)
>       if (check_plv(ctx)) {
>           return false;
>       }
> +    if (ctx->guest_mode) {
> +        gen_helper_gspr(tcg_env);
> +        return true;
> +    }
>       generate_exception(ctx, EXCCODE_DBP);
>       return true;
>   }
> @@ -410,9 +518,212 @@ static bool trans_idle(DisasContext *ctx, arg_idle *a)
>           return false;
>       }
>   
> +    if (ctx->guest_mode) {
> +        gen_helper_gspr(tcg_env);
> +        return true;
> +    }
> +
>       tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next + 4);
>       gen_helper_idle(tcg_env);
>       ctx->base.is_jmp = DISAS_NORETURN;
>       return true;
>   }
> +
> +static bool trans_gcsrrd(DisasContext *ctx, arg_gcsrrd *a)
> +{
> +    TCGv dest;
> +    const CSRInfo *csr;
> +    GenCSRRead readfn;
> +
> +    if (check_plv(ctx)) {
> +        return false;
> +    }
> +    if (!avail_LVZ(ctx) || ctx->guest_mode) {
> +        return false;
> +    }
> +
> +    csr = get_gcsr(a->csr);
> +    if (csr == NULL) {
> +        dest = tcg_constant_tl(0);
> +    } else {
> +        dest = gpr_dst(ctx, a->rd, EXT_NONE);
> +        if (csr->flags & CSRFL_GSPR) {
> +            tcg_gen_movi_tl(dest, 0);
> +        } else {
> +            readfn = (GenCSRRead)csr->readfn;
> +            if (readfn) {
> +                readfn(dest, tcg_env);
> +            } else {
> +                tcg_gen_ld_tl(dest, tcg_env, csr->offset);
> +            }
> +        }
> +    }
> +    gen_set_gpr(a->rd, dest, EXT_NONE);
> +    return true;
> +}
> +
> +static bool trans_gcsrwr(DisasContext *ctx, arg_gcsrwr *a)
> +{
> +    TCGv dest, src1;
> +    const CSRInfo *csr;
> +    GenCSRWrite writefn;
> +
> +    if (check_plv(ctx)) {
> +        return false;
> +    }
> +    if (!avail_LVZ(ctx) || ctx->guest_mode) {
> +        return false;
> +    }
> +
> +    csr = get_gcsr(a->csr);
> +    if (csr == NULL) {
> +        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
> +        return true;
> +    }
> +    if (!check_csr_flags(ctx, csr, true)) {
> +        return false;
> +    }
> +    if (csr->flags & CSRFL_GSPR) {
> +        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
> +        return true;
> +    }
> +
> +    src1 = gpr_src(ctx, a->rd, EXT_NONE);
> +    writefn = (GenCSRWrite)csr->writefn;
> +    if (writefn) {
> +        dest = gpr_dst(ctx, a->rd, EXT_NONE);
> +        writefn(dest, tcg_env, src1);
> +    } else {
> +        dest = tcg_temp_new();
> +        tcg_gen_ld_tl(dest, tcg_env, csr->offset);
> +        tcg_gen_st_tl(src1, tcg_env, csr->offset);
> +    }
> +    gen_set_gpr(a->rd, dest, EXT_NONE);
> +    return true;
> +}
> +
> +static bool trans_gcsrxchg(DisasContext *ctx, arg_gcsrxchg *a)
> +{
> +    TCGv src1, mask, oldv, newv, temp;
> +    const CSRInfo *csr;
> +    GenCSRRead readfn;
> +    GenCSRWrite writefn;
> +
> +    if (check_plv(ctx)) {
> +        return false;
> +    }
> +    if (!avail_LVZ(ctx) || ctx->guest_mode) {
> +        return false;
> +    }
> +
> +    csr = get_gcsr(a->csr);
> +    if (csr == NULL) {
> +        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
> +        return true;
> +    }
> +    if (!check_csr_flags(ctx, csr, true)) {
> +        return false;
> +    }
> +    if (csr->flags & CSRFL_GSPR) {
> +        gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
> +        return true;
> +    }
> +
> +    src1 = gpr_src(ctx, a->rd, EXT_NONE);
> +    mask = gpr_src(ctx, a->rj, EXT_NONE);
> +    oldv = tcg_temp_new();
> +    newv = tcg_temp_new();
> +    temp = tcg_temp_new();
> +
> +    readfn = (GenCSRRead)csr->readfn;
> +    if (readfn) {
> +        readfn(oldv, tcg_env);
> +    } else {
> +        tcg_gen_ld_tl(oldv, tcg_env, csr->offset);
> +    }
> +    tcg_gen_and_tl(newv, src1, mask);
> +    tcg_gen_andc_tl(temp, oldv, mask);
> +    tcg_gen_or_tl(newv, newv, temp);
> +
> +    writefn = (GenCSRWrite)csr->writefn;
> +    if (writefn) {
> +        writefn(oldv, tcg_env, newv);
> +    } else {
> +        tcg_gen_st_tl(newv, tcg_env, csr->offset);
> +    }
> +    gen_set_gpr(a->rd, oldv, EXT_NONE);
> +    return true;
> +}
> +
> +static bool trans_gtlbsrch(DisasContext *ctx, arg_gtlbsrch *a)
> +{
> +    if (check_plv(ctx) || !avail_LVZ(ctx) || ctx->guest_mode) {
> +        return false;
> +    }
> +    gen_helper_gtlbsrch(tcg_env);
> +    return true;
> +}
> +
> +static bool trans_gtlbrd(DisasContext *ctx, arg_gtlbrd *a)
> +{
> +    if (check_plv(ctx) || !avail_LVZ(ctx) || ctx->guest_mode) {
> +        return false;
> +    }
> +    gen_helper_gtlbrd(tcg_env);
> +    return true;
> +}
> +
> +static bool trans_gtlbwr(DisasContext *ctx, arg_gtlbwr *a)
> +{
> +    if (check_plv(ctx) || !avail_LVZ(ctx) || ctx->guest_mode) {
> +        return false;
> +    }
> +    gen_helper_gtlbwr(tcg_env);
> +    check_mmu_idx(ctx);
> +    return true;
> +}
> +
> +static bool trans_gtlbfill(DisasContext *ctx, arg_gtlbfill *a)
> +{
> +    if (check_plv(ctx) || !avail_LVZ(ctx) || ctx->guest_mode) {
> +        return false;
> +    }
> +    gen_helper_gtlbfill(tcg_env);
> +    check_mmu_idx(ctx);
> +    return true;
> +}
> +
> +static bool trans_gtlbclr(DisasContext *ctx, arg_gtlbclr *a)
> +{
> +    if (check_plv(ctx) || !avail_LVZ(ctx) || ctx->guest_mode) {
> +        return false;
> +    }
> +    gen_helper_gtlbclr(tcg_env);
> +    check_mmu_idx(ctx);
> +    return true;
> +}
> +
> +static bool trans_gtlbflush(DisasContext *ctx, arg_gtlbflush *a)
> +{
> +    if (check_plv(ctx) || !avail_LVZ(ctx) || ctx->guest_mode) {
> +        return false;
> +    }
> +    gen_helper_gtlbflush(tcg_env);
> +    check_mmu_idx(ctx);
> +    return true;
> +}
> +
> +static bool trans_hvcl(DisasContext *ctx, arg_hvcl *a)
> +{
> +    if (!avail_LVZ(ctx)) {
> +        return false;
> +    }
> +    if (!ctx->guest_mode) {
> +        return false;
> +    }
> +    tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
> +    gen_helper_hvcl(tcg_env, tcg_constant_i32(a->imm));
> +    ctx->base.is_jmp = DISAS_NORETURN;
> +    return true;
> +}
>   #endif
> diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
> index 16ac0d43bc..28043697d8 100644
> --- a/target/loongarch/tcg/op_helper.c
> +++ b/target/loongarch/tcg/op_helper.c
> @@ -15,6 +15,7 @@
>   #include "qemu/crc32c.h"
>   #include <zlib.h> /* for crc32 */
>   #include "cpu-csr.h"
> +#include "qemu/main-loop.h"
>   
>   /* Exceptions helpers */
>   void helper_raise_exception(CPULoongArchState *env, uint32_t exception)
> @@ -81,6 +82,10 @@ target_ulong helper_crc32c(target_ulong val, target_ulong m, uint64_t sz)
>   
>   target_ulong helper_cpucfg(CPULoongArchState *env, target_ulong rj)
>   {
> +    if (env->guest) {
> +        trigger_vm_exit(env);
> +        do_raise_exception(env, EXCCODE_GSPR, GETPC());
> +    }
>       return rj >= ARRAY_SIZE(env->cpucfg) ? 0 : env->cpucfg[rj];
>   }
>   
> @@ -92,8 +97,9 @@ uint64_t helper_rdtime_d(CPULoongArchState *env)
>       uint64_t plv;
>       LoongArchCPU *cpu = env_archcpu(env);
>   
> -    plv = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV);
> -    if (extract64(env->CSR_MISC, R_CSR_MISC_DRDTL_SHIFT + plv, 1)) {
> +    plv = FIELD_EX64(GET_CSR_IF(env->guest, CRMD), CSR_CRMD, PLV);
> +    if (extract64(GET_CSR_IF(env->guest, MISC), R_CSR_MISC_DRDTL_SHIFT + plv,
> +                  1)) {
>           do_raise_exception(env, EXCCODE_IPE, GETPC());
>       }
>   
> @@ -105,28 +111,50 @@ uint64_t helper_rdtime_d(CPULoongArchState *env)
>   void helper_ertn(CPULoongArchState *env)
>   {
>       uint64_t csr_pplv, csr_pie;
> -    if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
> -        csr_pplv = FIELD_EX64(env->CSR_TLBRPRMD, CSR_TLBRPRMD, PPLV);
> -        csr_pie = FIELD_EX64(env->CSR_TLBRPRMD, CSR_TLBRPRMD, PIE);
> -
> -        env->CSR_TLBRERA = FIELD_DP64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 0);
> -        env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, DA, 0);
> -        env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, PG, 1);
> -        set_pc(env, env->CSR_TLBRERA);
> -        qemu_log_mask(CPU_LOG_INT, "%s: TLBRERA " TARGET_FMT_lx "\n",
> -                      __func__, env->CSR_TLBRERA);
> +
> +    if (FIELD_EX64(GET_CSR_IF(env->guest, TLBRERA), CSR_TLBRERA, ISTLBR)) {
> +        csr_pplv =
> +            FIELD_EX64(GET_CSR_IF(env->guest, TLBRPRMD), CSR_TLBRPRMD, PPLV);
> +        csr_pie =
> +            FIELD_EX64(GET_CSR_IF(env->guest, TLBRPRMD), CSR_TLBRPRMD, PIE);
> +
> +        SET_CSR_IF(env->guest, TLBRERA,
> +                   FIELD_DP64(GET_CSR_IF(env->guest, TLBRERA), CSR_TLBRERA,
> +                              ISTLBR, 0));
> +        SET_CSR_IF(env->guest, CRMD,
> +                   FIELD_DP64(GET_CSR_IF(env->guest, CRMD), CSR_CRMD, DA, 0));
> +        SET_CSR_IF(env->guest, CRMD,
> +                   FIELD_DP64(GET_CSR_IF(env->guest, CRMD), CSR_CRMD, PG, 1));
> +        set_pc(env, GET_CSR_IF(env->guest, TLBRERA));
> +        qemu_log_mask(CPU_LOG_INT, "%s: TLBRERA " TARGET_FMT_lx "\n", __func__,
> +                      GET_CSR_IF(env->guest, TLBRERA));
>       } else {
> -        csr_pplv = FIELD_EX64(env->CSR_PRMD, CSR_PRMD, PPLV);
> -        csr_pie = FIELD_EX64(env->CSR_PRMD, CSR_PRMD, PIE);
> +        csr_pplv = FIELD_EX64(GET_CSR_IF(env->guest, PRMD), CSR_PRMD, PPLV);
> +        csr_pie = FIELD_EX64(GET_CSR_IF(env->guest, PRMD), CSR_PRMD, PIE);
>   
> -        set_pc(env, env->CSR_ERA);
> -        qemu_log_mask(CPU_LOG_INT, "%s: ERA " TARGET_FMT_lx "\n",
> -                      __func__, env->CSR_ERA);
> +        set_pc(env, GET_CSR_IF(env->guest, ERA));
> +        qemu_log_mask(CPU_LOG_INT, "%s: ERA " TARGET_FMT_lx "\n", __func__,
> +                      GET_CSR_IF(env->guest, ERA));
>       }
> -    env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, PLV, csr_pplv);
> -    env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, IE, csr_pie);
> +    SET_CSR_IF(
> +        env->guest, CRMD,
> +        FIELD_DP64(GET_CSR_IF(env->guest, CRMD), CSR_CRMD, PLV, csr_pplv));
> +    SET_CSR_IF(env->guest, CRMD,
> +               FIELD_DP64(GET_CSR_IF(env->guest, CRMD), CSR_CRMD, IE, csr_pie));
>   
>       env->lladdr = 1;
> +    if (will_return_to_guest(env)) {
> +        env->guest = true;
> +        env->CSR_GSTAT = FIELD_DP64(env->CSR_GSTAT, CSR_GSTAT, VM, 1);
> +        cpu_loongarch_set_guest_timer(env_archcpu(env), true);
> +        bql_lock();
> +        if (loongarch_guest_has_interrupt(env)) {
> +            cpu_interrupt(env_cpu(env), CPU_INTERRUPT_GUEST);
> +        } else {
> +            cpu_reset_interrupt(env_cpu(env), CPU_INTERRUPT_GUEST);
> +        }
> +        bql_unlock();
> +    }
>   }
>   
>   void helper_idle(CPULoongArchState *env)
> @@ -136,4 +164,21 @@ void helper_idle(CPULoongArchState *env)
>       cs->halted = 1;
>       do_raise_exception(env, EXCP_HLT, 0);
>   }
> +
> +void helper_hvcl(CPULoongArchState *env, uint32_t code)
> +{
> +    if (!env->guest) {
> +        do_raise_exception(env, EXCCODE_INE, GETPC());
> +        return;
> +    }
> +
> +    trigger_vm_exit(env);
> +    do_raise_exception(env, EXCCODE_HVC, GETPC());
> +}
> +
> +void helper_gspr(CPULoongArchState *env)
> +{
> +    trigger_vm_exit(env);
> +    do_raise_exception(env, EXCCODE_GSPR, GETPC());
> +}
>   #endif
> diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
> index 31d3db6e8e..7bc4911524 100644
> --- a/target/loongarch/tcg/tcg_cpu.c
> +++ b/target/loongarch/tcg/tcg_cpu.c
> @@ -43,6 +43,10 @@ static const struct TypeExcp excp_names[] = {
>       {EXCCODE_BCE, "Bound Check Exception"},
>       {EXCCODE_SXD, "128 bit vector instructions Disable exception"},
>       {EXCCODE_ASXD, "256 bit vector instructions Disable exception"},
> +    {EXCCODE_GSPR, "Guest Sensitive and Privileged Resources"},
> +    {EXCCODE_HVC, "Hypervisor call"},
> +    {EXCCODE_GCSC, "Guest CSR visited by Software"},
> +    {EXCCODE_GCHC, "Guest CSR visited by Hardware"},
>       {EXCP_HLT, "EXCP_HLT"},
>   };
>   
> @@ -79,9 +83,12 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
>       CPULoongArchState *env = cpu_env(cs);
>       bool update_badinstr = 1;
>       int cause = -1;
> -    bool tlbfill = FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR);
> -    uint32_t vec_size = FIELD_EX64(env->CSR_ECFG, CSR_ECFG, VS);
> +    bool real_guest = !env->vm_exit && env->guest;
> +    bool tlbfill =
> +        FIELD_EX64(GET_CSR_IF(real_guest, TLBRERA), CSR_TLBRERA, ISTLBR);
> +    uint32_t vec_size = FIELD_EX64(GET_CSR_IF(real_guest, ECFG), CSR_ECFG, VS);
>       uint64_t last_pc = env->pc;
> +    uint32_t badinstr;
>   
>       if (cs->exception_index != EXCCODE_INT) {
>           qemu_log_mask(CPU_LOG_INT,
> @@ -115,7 +122,11 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
>           update_badinstr = 0;
>           break;
>       case EXCCODE_BCE:
> -        env->CSR_BADV = env->pc;
> +    case EXCCODE_GSPR:
> +    case EXCCODE_GCHC:
> +    case EXCCODE_GCSC:
> +    case EXCCODE_HVC:
> +        SET_CSR_IF(real_guest, BADV, env->pc);
>           QEMU_FALLTHROUGH;
>       case EXCCODE_SYS:
>       case EXCCODE_BRK:
> @@ -142,35 +153,51 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
>       if (update_badinstr) {
>           MemOpIdx oi = make_memop_idx(MO_LEUL, cpu_mmu_index(cs, true));
>   
> -        env->CSR_BADI = cpu_ldl_code_mmu(env, env->pc, oi, 0);
> +        badinstr = cpu_ldl_code_mmu(env, env->pc, oi, 0);
> +        SET_CSR_IF(real_guest, BADI, badinstr);
>       }
>   
>       /* Save PLV and IE */
>       if (tlbfill) {
> -        env->CSR_TLBRPRMD = FIELD_DP64(env->CSR_TLBRPRMD, CSR_TLBRPRMD, PPLV,
> -                                       FIELD_EX64(env->CSR_CRMD,
> -                                       CSR_CRMD, PLV));
> -        env->CSR_TLBRPRMD = FIELD_DP64(env->CSR_TLBRPRMD, CSR_TLBRPRMD, PIE,
> -                                       FIELD_EX64(env->CSR_CRMD, CSR_CRMD, IE));
> +        SET_CSR_IF(real_guest, TLBRPRMD,
> +                   FIELD_DP64(GET_CSR_IF(real_guest, TLBRPRMD), CSR_TLBRPRMD,
> +                              PPLV,
> +                              FIELD_EX64(GET_CSR_IF(real_guest, CRMD), CSR_CRMD,
> +                                         PLV)));
> +        SET_CSR_IF(
> +            real_guest, TLBRPRMD,
> +            FIELD_DP64(GET_CSR_IF(real_guest, TLBRPRMD), CSR_TLBRPRMD, PIE,
> +                       FIELD_EX64(GET_CSR_IF(real_guest, CRMD), CSR_CRMD, IE)));
>           /* set the DA mode */
> -        env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, DA, 1);
> -        env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, PG, 0);
> -        env->CSR_TLBRERA = FIELD_DP64(env->CSR_TLBRERA, CSR_TLBRERA,
> -                                      PC, (env->pc >> 2));
> +        SET_CSR_IF(real_guest, CRMD,
> +                   FIELD_DP64(GET_CSR_IF(real_guest, CRMD), CSR_CRMD, DA, 1));
> +        SET_CSR_IF(real_guest, CRMD,
> +                   FIELD_DP64(GET_CSR_IF(real_guest, CRMD), CSR_CRMD, PG, 0));
> +        SET_CSR_IF(real_guest, TLBRERA,
> +                   FIELD_DP64(GET_CSR_IF(real_guest, TLBRERA), CSR_TLBRERA, PC,
> +                              (env->pc >> 2)));
>       } else {
> -        env->CSR_ESTAT = FIELD_DP64(env->CSR_ESTAT, CSR_ESTAT, ECODE,
> -                                    EXCODE_MCODE(cause));
> -        env->CSR_ESTAT = FIELD_DP64(env->CSR_ESTAT, CSR_ESTAT, ESUBCODE,
> -                                    EXCODE_SUBCODE(cause));
> -        env->CSR_PRMD = FIELD_DP64(env->CSR_PRMD, CSR_PRMD, PPLV,
> -                                   FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV));
> -        env->CSR_PRMD = FIELD_DP64(env->CSR_PRMD, CSR_PRMD, PIE,
> -                                   FIELD_EX64(env->CSR_CRMD, CSR_CRMD, IE));
> -        env->CSR_ERA = env->pc;
> +        SET_CSR_IF(real_guest, ESTAT,
> +                   FIELD_DP64(GET_CSR_IF(real_guest, ESTAT), CSR_ESTAT, ECODE,
> +                              EXCODE_MCODE(cause)));
> +        SET_CSR_IF(real_guest, ESTAT,
> +                   FIELD_DP64(GET_CSR_IF(real_guest, ESTAT), CSR_ESTAT,
> +                              ESUBCODE, EXCODE_SUBCODE(cause)));
> +        SET_CSR_IF(real_guest, PRMD,
> +                   FIELD_DP64(GET_CSR_IF(real_guest, PRMD), CSR_PRMD, PPLV,
> +                              FIELD_EX64(GET_CSR_IF(real_guest, CRMD), CSR_CRMD,
> +                                         PLV)));
> +        SET_CSR_IF(
> +            real_guest, PRMD,
> +            FIELD_DP64(GET_CSR_IF(real_guest, PRMD), CSR_PRMD, PIE,
> +                       FIELD_EX64(GET_CSR_IF(real_guest, CRMD), CSR_CRMD, IE)));
> +        SET_CSR_IF(real_guest, ERA, env->pc);
>       }
>   
> -    env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, PLV, 0);
> -    env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, IE, 0);
> +    SET_CSR_IF(real_guest, CRMD,
> +               FIELD_DP64(GET_CSR_IF(real_guest, CRMD), CSR_CRMD, PLV, 0));
> +    SET_CSR_IF(real_guest, CRMD,
> +               FIELD_DP64(GET_CSR_IF(real_guest, CRMD), CSR_CRMD, IE, 0));
>   
>       if (vec_size) {
>           vec_size = (1 << vec_size) * 4;
> @@ -179,43 +206,54 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
>       if  (cs->exception_index == EXCCODE_INT) {
>           /* Interrupt */
>           uint32_t vector = 0;
> -        uint32_t pending = FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS);
> -        pending &= FIELD_EX64(env->CSR_ECFG, CSR_ECFG, LIE);
> +        uint32_t pending =
> +            FIELD_EX64(GET_CSR_IF(real_guest, ESTAT), CSR_ESTAT, IS);
> +        pending &= FIELD_EX64(GET_CSR_IF(real_guest, ECFG), CSR_ECFG, LIE);
>   
>           /* Find the highest-priority interrupt. */
>           vector = 31 - clz32(pending);
> -        set_pc(env, env->CSR_EENTRY + \
> -               (EXCCODE_EXTERNAL_INT + vector) * vec_size);
> -        qemu_log_mask(CPU_LOG_INT,
> -                      "%s: PC " TARGET_FMT_lx " ERA " TARGET_FMT_lx
> -                      " cause %d\n" "    A " TARGET_FMT_lx " D "
> -                      TARGET_FMT_lx " vector = %d ExC " TARGET_FMT_lx "ExS"
> -                      TARGET_FMT_lx "\n",
> -                      __func__, env->pc, env->CSR_ERA,
> -                      cause, env->CSR_BADV, env->CSR_DERA, vector,
> -                      env->CSR_ECFG, env->CSR_ESTAT);
> +        set_pc(env, GET_CSR_IF(real_guest, EENTRY) +
> +                        (EXCCODE_EXTERNAL_INT + vector) * vec_size);
> +        qemu_log_mask(
> +            CPU_LOG_INT,
> +            "%s: PC " TARGET_FMT_lx " ERA " TARGET_FMT_lx " cause %d\n"
> +            "    A " TARGET_FMT_lx " D " TARGET_FMT_lx
> +            " vector = %d ExC " TARGET_FMT_lx "ExS" TARGET_FMT_lx "\n",
> +            __func__, env->pc, GET_CSR_IF(real_guest, ERA), cause,
> +            GET_CSR_IF(real_guest, BADV), GET_CSR_IF(real_guest, DERA), vector,
> +            GET_CSR_IF(real_guest, ECFG), GET_CSR_IF(real_guest, ESTAT));
>           qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
>       } else {
>           if (tlbfill) {
> -            set_pc(env, env->CSR_TLBRENTRY);
> +            set_pc(env, GET_CSR_IF(real_guest, TLBRENTRY));
>           } else {
> -            set_pc(env, env->CSR_EENTRY + EXCODE_MCODE(cause) * vec_size);
> +            set_pc(env, GET_CSR_IF(real_guest, EENTRY) +
> +                            EXCODE_MCODE(cause) * vec_size);
>           }
> -        qemu_log_mask(CPU_LOG_INT,
> -                      "%s: PC " TARGET_FMT_lx " ERA " TARGET_FMT_lx
> -                      " cause %d%s\n, ESTAT " TARGET_FMT_lx
> -                      " EXCFG " TARGET_FMT_lx " BADVA " TARGET_FMT_lx
> -                      "BADI " TARGET_FMT_lx " SYS_NUM " TARGET_FMT_lu
> -                      " cpu %d asid " TARGET_FMT_lx "\n", __func__, env->pc,
> -                      tlbfill ? env->CSR_TLBRERA : env->CSR_ERA,
> -                      cause, tlbfill ? "(refill)" : "", env->CSR_ESTAT,
> -                      env->CSR_ECFG,
> -                      tlbfill ? env->CSR_TLBRBADV : env->CSR_BADV,
> -                      env->CSR_BADI, env->gpr[11], cs->cpu_index,
> -                      env->CSR_ASID);
> +        qemu_log_mask(
> +            CPU_LOG_INT,
> +            "%s: PC " TARGET_FMT_lx " ERA " TARGET_FMT_lx
> +            " cause %d%s\n, ESTAT " TARGET_FMT_lx " EXCFG " TARGET_FMT_lx
> +            " BADVA " TARGET_FMT_lx "BADI " TARGET_FMT_lx
> +            " SYS_NUM " TARGET_FMT_lu " cpu %d asid " TARGET_FMT_lx "\n",
> +            __func__, env->pc,
> +            tlbfill ? GET_CSR_IF(real_guest, TLBRERA) :
> +                      GET_CSR_IF(real_guest, ERA),
> +            cause, tlbfill ? "(refill)" : "", GET_CSR_IF(real_guest, ESTAT),
> +            GET_CSR_IF(real_guest, ECFG),
> +            tlbfill ? GET_CSR_IF(real_guest, TLBRBADV) :
> +                      GET_CSR_IF(real_guest, BADV),
> +            GET_CSR_IF(real_guest, BADI), env->gpr[11], cs->cpu_index,
> +            GET_CSR_IF(real_guest, ASID));
>           qemu_plugin_vcpu_exception_cb(cs, last_pc);
>       }
>       cs->exception_index = -1;
> +    if (env->vm_exit) {
> +        env->CSR_GSTAT = FIELD_DP64(env->CSR_GSTAT, CSR_GSTAT, VM, 0);
> +        env->guest = false;
> +        cpu_reset_interrupt(cs, CPU_INTERRUPT_GUEST);
> +    }
> +    env->vm_exit = false;
>   }
>   
>   static void loongarch_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
> @@ -247,16 +285,25 @@ static inline bool cpu_loongarch_hw_interrupts_enabled(CPULoongArchState *env)
>   
>   static bool loongarch_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>   {
> -    if (interrupt_request & CPU_INTERRUPT_HARD) {
> -        CPULoongArchState *env = cpu_env(cs);
> +    CPULoongArchState *env = cpu_env(cs);
> +    bool has_interrupt = false;
>   
> +    if (interrupt_request & CPU_INTERRUPT_HARD) {
>           if (cpu_loongarch_hw_interrupts_enabled(env) &&
>               cpu_loongarch_hw_interrupts_pending(env)) {
> -            /* Raise it */
> -            cs->exception_index = EXCCODE_INT;
> -            loongarch_cpu_do_interrupt(cs);
> -            return true;
> +            if (env->guest) {
> +                trigger_vm_exit(env);
> +            }
> +            has_interrupt = true;
>           }
> +    } else if (interrupt_request & CPU_INTERRUPT_GUEST) {
> +        has_interrupt = loongarch_guest_has_interrupt(env);
> +    }
> +
> +    if (has_interrupt) {
> +        cs->exception_index = EXCCODE_INT;
> +        loongarch_cpu_do_interrupt(cs);
> +        return true;
>       }
>       return false;
>   }
> @@ -273,10 +320,18 @@ static TCGTBCPUState loongarch_get_tb_cpu_state(CPUState *cs)
>       CPULoongArchState *env = cpu_env(cs);
>       uint32_t flags;
>   
> -    flags = env->CSR_CRMD & (R_CSR_CRMD_PLV_MASK | R_CSR_CRMD_PG_MASK);
> -    flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, FPE) * HW_FLAGS_EUEN_FPE;
> -    flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, SXE) * HW_FLAGS_EUEN_SXE;
> -    flags |= FIELD_EX64(env->CSR_EUEN, CSR_EUEN, ASXE) * HW_FLAGS_EUEN_ASXE;
> +    if (env->guest) {
> +        flags = env->GCSR_CRMD & (R_CSR_CRMD_PLV_MASK | R_CSR_CRMD_PG_MASK);
> +        flags |= HW_FLAGS_GUEST_MODE;
> +    } else {
> +        flags = env->CSR_CRMD & (R_CSR_CRMD_PLV_MASK | R_CSR_CRMD_PG_MASK);
> +    }
> +    flags |= FIELD_EX64(GET_CSR_IF(env->guest, EUEN), CSR_EUEN, FPE) *
> +             HW_FLAGS_EUEN_FPE;
> +    flags |= FIELD_EX64(GET_CSR_IF(env->guest, EUEN), CSR_EUEN, SXE) *
> +             HW_FLAGS_EUEN_SXE;
> +    flags |= FIELD_EX64(GET_CSR_IF(env->guest, EUEN), CSR_EUEN, ASXE) *
> +             HW_FLAGS_EUEN_ASXE;
>       flags |= is_va32(env) * HW_FLAGS_VA32;
>   
>       return (TCGTBCPUState){ .pc = env->pc, .flags = flags };
> @@ -300,6 +355,13 @@ static int loongarch_cpu_mmu_index(CPUState *cs, bool ifetch)
>   {
>       CPULoongArchState *env = cpu_env(cs);
>   
> +    if (env->guest) {
> +        if (FIELD_EX64(env->GCSR_CRMD, CSR_CRMD, PG)) {
> +            return MMU_GUEST_IDX + FIELD_EX64(env->GCSR_CRMD, CSR_CRMD, PLV);
> +        }
> +        return MMU_GUEST_DA_IDX;
> +    }
> +
>       if (FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG)) {
>           return FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PLV);
>       }
> diff --git a/target/loongarch/tcg/tcg_loongarch.h b/target/loongarch/tcg/tcg_loongarch.h
> index 7fb627f2d6..ceba1e4062 100644
> --- a/target/loongarch/tcg/tcg_loongarch.h
> +++ b/target/loongarch/tcg/tcg_loongarch.h
> @@ -16,8 +16,8 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>                               MMUAccessType access_type, int mmu_idx,
>                               bool probe, uintptr_t retaddr);
>   
> -TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env,
> -                                   MMUContext *context,
> -                                   MMUAccessType access_type, int mmu_idx);
> +TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env, MMUContext *context,
> +                                   MMUAccessType access_type, int mmu_idx,
> +                                   bool guest);
>   
>   #endif  /* TARGET_LOONGARCH_TCG_LOONGARCH_H */
> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
> index 892e0eb473..fec0aeeb57 100644
> --- a/target/loongarch/tcg/tlb_helper.c
> +++ b/target/loongarch/tcg/tlb_helper.c
> @@ -34,6 +34,13 @@ static bool tlb_match_asid(bool global, int asid, int tlb_asid)
>       return !global && tlb_asid == asid;
>   }
>   
> +static inline bool tlb_entry_matches_gid(LoongArchTLB *tlb, uint8_t gid)
> +{
> +    uint8_t entry_gid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, GID);
> +
> +    return entry_gid == gid;
> +}
> +
>   bool check_ps(CPULoongArchState *env, uint8_t tlb_ps)
>   {
>       if (tlb_ps >= 64) {
> @@ -46,14 +53,22 @@ static void raise_mmu_exception(CPULoongArchState *env, vaddr address,
>                                   MMUAccessType access_type, TLBRet tlb_error)
>   {
>       CPUState *cs = env_cpu(env);
> +    bool real_guest;
> +
> +    if (env->guest && tlb_error > TLBRET_HOST_MATCH) {
> +        trigger_vm_exit(env);
> +    }
> +    real_guest = !env->vm_exit && env->guest;
>   
>       switch (tlb_error) {
>       default:
>       case TLBRET_BADADDR:
> +    case TLBRET_HOST_BADADDR:
>           cs->exception_index = access_type == MMU_INST_FETCH
>                                 ? EXCCODE_ADEF : EXCCODE_ADEM;
>           break;
>       case TLBRET_NOMATCH:
> +    case TLBRET_HOST_NOMATCH:
>           /* No TLB match for a mapped address */
>           if (access_type == MMU_DATA_LOAD) {
>               cs->exception_index = EXCCODE_PIL;
> @@ -62,9 +77,12 @@ static void raise_mmu_exception(CPULoongArchState *env, vaddr address,
>           } else if (access_type == MMU_INST_FETCH) {
>               cs->exception_index = EXCCODE_PIF;
>           }
> -        env->CSR_TLBRERA = FIELD_DP64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 1);
> +        SET_CSR_IF(real_guest, TLBRERA,
> +                   FIELD_DP64(GET_CSR_IF(real_guest, TLBRERA), CSR_TLBRERA,
> +                              ISTLBR, 1));
>           break;
>       case TLBRET_INVALID:
> +    case TLBRET_HOST_INVALID:
>           /* TLB match with no valid bit */
>           if (access_type == MMU_DATA_LOAD) {
>               cs->exception_index = EXCCODE_PIL;
> @@ -75,46 +93,58 @@ static void raise_mmu_exception(CPULoongArchState *env, vaddr address,
>           }
>           break;
>       case TLBRET_DIRTY:
> +    case TLBRET_HOST_DIRTY:
>           /* TLB match but 'D' bit is cleared */
>           cs->exception_index = EXCCODE_PME;
>           break;
>       case TLBRET_XI:
> +    case TLBRET_HOST_XI:
>           /* Execute-Inhibit Exception */
>           cs->exception_index = EXCCODE_PNX;
>           break;
>       case TLBRET_RI:
> +    case TLBRET_HOST_RI:
>           /* Read-Inhibit Exception */
>           cs->exception_index = EXCCODE_PNR;
>           break;
>       case TLBRET_PE:
> +    case TLBRET_HOST_PE:
>           /* Privileged Exception */
>           cs->exception_index = EXCCODE_PPI;
>           break;
>       }
>   
> -    if (tlb_error == TLBRET_NOMATCH) {
> -        env->CSR_TLBRBADV = address;
> +    if (tlb_error == TLBRET_NOMATCH || tlb_error == TLBRET_HOST_NOMATCH) {
> +        SET_CSR_IF(real_guest, TLBRBADV, address);
>           if (is_la64(env)) {
> -            env->CSR_TLBREHI = FIELD_DP64(env->CSR_TLBREHI, CSR_TLBREHI_64,
> -                                        VPPN, extract64(address, 13, 35));
> +            SET_CSR_IF(real_guest, TLBREHI,
> +                       FIELD_DP64(GET_CSR_IF(real_guest, TLBREHI),
> +                                  CSR_TLBREHI_64, VPPN,
> +                                  extract64(address, 13, 35)));
>           } else {
> -            env->CSR_TLBREHI = FIELD_DP64(env->CSR_TLBREHI, CSR_TLBREHI_32,
> -                                        VPPN, extract64(address, 13, 19));
> +            SET_CSR_IF(real_guest, TLBREHI,
> +                       FIELD_DP64(GET_CSR_IF(real_guest, TLBREHI),
> +                                  CSR_TLBREHI_32, VPPN,
> +                                  extract64(address, 13, 19)));
>           }
>       } else {
>           if (!FIELD_EX64(env->CSR_DBG, CSR_DBG, DST)) {
> -            env->CSR_BADV = address;
> +            SET_CSR_IF(real_guest, BADV, address);
>           }
> -        env->CSR_TLBEHI = address & (TARGET_PAGE_MASK << 1);
> -   }
> +        SET_CSR_IF(real_guest, TLBEHI, address & (TARGET_PAGE_MASK << 1));
> +    }
>   }
>   
> -static void invalidate_tlb_entry(CPULoongArchState *env, int index)
> +static void invalidate_tlb_entry(CPULoongArchState *env, int index, bool guest)
>   {
>       target_ulong addr, mask, pagesize;
>       uint8_t tlb_ps;
> -    LoongArchTLB *tlb = &env->tlb[index];
> -    int idxmap = BIT(MMU_KERNEL_IDX) | BIT(MMU_USER_IDX);
> +    LoongArchTLB *tlb = guest ? &env->gtlb[index] : &env->tlb[index];
> +    int idxmap =
> +        guest ? (BIT(MMU_GUEST_IDX) | BIT(MMU_GUEST_IDX + 1) |
> +                 BIT(MMU_GUEST_IDX + 2) | BIT(MMU_GUEST_IDX + 3) |
> +                 BIT(MMU_GUEST_DA_IDX)) :
> +                (BIT(MMU_KERNEL_IDX) | BIT(MMU_USER_IDX) | BIT(MMU_DA_IDX));
>       uint64_t tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
>       bool tlb_v;
>   
> @@ -124,27 +154,27 @@ static void invalidate_tlb_entry(CPULoongArchState *env, int index)
>       addr = (tlb_vppn << R_TLB_MISC_VPPN_SHIFT) & ~mask;
>       addr = sextract64(addr, 0, TARGET_VIRT_ADDR_SPACE_BITS);
>   
> -    tlb_v = pte_present(env, tlb->tlb_entry0);
> +    tlb_v = pte_present(env, tlb->tlb_entry0, guest);
>       if (tlb_v) {
>           tlb_flush_range_by_mmuidx(env_cpu(env), addr, pagesize,
>                                     idxmap, TARGET_LONG_BITS);
>       }
>   
> -    tlb_v = pte_present(env, tlb->tlb_entry1);
> +    tlb_v = pte_present(env, tlb->tlb_entry1, guest);
>       if (tlb_v) {
>           tlb_flush_range_by_mmuidx(env_cpu(env), addr + pagesize, pagesize,
>                                     idxmap, TARGET_LONG_BITS);
>       }
>   }
>   
> -static void invalidate_tlb(CPULoongArchState *env, int index)
> +static void invalidate_tlb(CPULoongArchState *env, int index, bool guest)
>   {
>       LoongArchTLB *tlb;
>       uint16_t csr_asid, tlb_asid, tlb_g;
>       uint8_t tlb_e;
>   
> -    csr_asid = FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
> -    tlb = &env->tlb[index];
> +    csr_asid = FIELD_EX64(GET_CSR_IF(guest, ASID), CSR_ASID, ASID);
> +    tlb = guest ? &env->gtlb[index] : &env->tlb[index];
>       tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
>       if (!tlb_e) {
>           return;
> @@ -157,33 +187,38 @@ static void invalidate_tlb(CPULoongArchState *env, int index)
>       if (tlb_g == 0 && tlb_asid != csr_asid) {
>           return;
>       }
> -    invalidate_tlb_entry(env, index);
> +    invalidate_tlb_entry(env, index, guest);
>   }
>   
>   /* Prepare tlb entry information in software PTW mode */
> -static void sptw_prepare_context(CPULoongArchState *env, MMUContext *context)
> +static void sptw_prepare_context(CPULoongArchState *env, MMUContext *context,
> +                                 bool guest)
>   {
>       uint64_t lo0, lo1, csr_vppn;
>       uint8_t csr_ps;
>   
> -    if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
> -        csr_ps = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI, PS);
> +    if (FIELD_EX64(GET_CSR_IF(guest, TLBRERA), CSR_TLBRERA, ISTLBR)) {
> +        csr_ps = FIELD_EX64(GET_CSR_IF(guest, TLBREHI), CSR_TLBREHI, PS);
>           if (is_la64(env)) {
> -            csr_vppn = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI_64, VPPN);
> +            csr_vppn =
> +                FIELD_EX64(GET_CSR_IF(guest, TLBREHI), CSR_TLBREHI_64, VPPN);
>           } else {
> -            csr_vppn = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI_32, VPPN);
> +            csr_vppn =
> +                FIELD_EX64(GET_CSR_IF(guest, TLBREHI), CSR_TLBREHI_32, VPPN);
>           }
> -        lo0 = env->CSR_TLBRELO0;
> -        lo1 = env->CSR_TLBRELO1;
> +        lo0 = GET_CSR_IF(guest, TLBRELO0);
> +        lo1 = GET_CSR_IF(guest, TLBRELO1);
>       } else {
> -        csr_ps = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, PS);
> +        csr_ps = FIELD_EX64(GET_CSR_IF(guest, TLBIDX), CSR_TLBIDX, PS);
>           if (is_la64(env)) {
> -            csr_vppn = FIELD_EX64(env->CSR_TLBEHI, CSR_TLBEHI_64, VPPN);
> +            csr_vppn =
> +                FIELD_EX64(GET_CSR_IF(guest, TLBEHI), CSR_TLBEHI_64, VPPN);
>           } else {
> -            csr_vppn = FIELD_EX64(env->CSR_TLBEHI, CSR_TLBEHI_32, VPPN);
> +            csr_vppn =
> +                FIELD_EX64(GET_CSR_IF(guest, TLBEHI), CSR_TLBEHI_32, VPPN);
>           }
> -        lo0 = env->CSR_TLBELO0;
> -        lo1 = env->CSR_TLBELO1;
> +        lo0 = GET_CSR_IF(guest, TLBELO0);
> +        lo1 = GET_CSR_IF(guest, TLBELO1);
>       }
>   
>       context->ps = csr_ps;
> @@ -193,7 +228,7 @@ static void sptw_prepare_context(CPULoongArchState *env, MMUContext *context)
>   }
>   
>   static void fill_tlb_entry(CPULoongArchState *env, LoongArchTLB *tlb,
> -                           MMUContext *context)
> +                           MMUContext *context, bool guest)
>   {
>       uint64_t lo0, lo1, csr_vppn;
>       uint16_t csr_asid;
> @@ -208,8 +243,9 @@ static void fill_tlb_entry(CPULoongArchState *env, LoongArchTLB *tlb,
>       tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, PS, csr_ps);
>       tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, VPPN, csr_vppn);
>       tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 1);
> -    csr_asid = FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
> +    csr_asid = FIELD_EX64(GET_CSR_IF(guest, ASID), CSR_ASID, ASID);
>       tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, ASID, csr_asid);
> +    tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, GID, get_tgid(env));
>   
>       tlb->tlb_entry0 = lo0;
>       tlb->tlb_entry1 = lo1;
> @@ -233,7 +269,8 @@ static uint32_t get_random_tlb(uint32_t low, uint32_t high)
>    */
>   static LoongArchTLB *loongarch_tlb_search_cb(CPULoongArchState *env,
>                                                vaddr vaddr, int csr_asid,
> -                                             tlb_match func)
> +                                             tlb_match func, bool guest,
> +                                             uint8_t gid)
>   {
>       LoongArchTLB *tlb;
>       uint16_t tlb_asid, stlb_idx;
> @@ -242,14 +279,15 @@ static LoongArchTLB *loongarch_tlb_search_cb(CPULoongArchState *env,
>       int i, compare_shift;
>       uint64_t vpn, tlb_vppn;
>   
> -    stlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
> +    stlb_ps = FIELD_EX64(GET_CSR_IF(guest, STLBPS), CSR_STLBPS, PS);
>       vpn = (vaddr & TARGET_VIRT_MASK) >> (stlb_ps + 1);
>       stlb_idx = vpn & 0xff; /* VA[25:15] <==> TLBIDX.index for 16KiB Page */
>       compare_shift = stlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT;
>   
>       /* Search STLB */
>       for (i = 0; i < 8; ++i) {
> -        tlb = &env->tlb[i * 256 + stlb_idx];
> +        tlb = guest ? &env->gtlb[i * 256 + stlb_idx] :
> +                      &env->tlb[i * 256 + stlb_idx];
>           tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
>           if (tlb_e) {
>               tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
> @@ -257,6 +295,7 @@ static LoongArchTLB *loongarch_tlb_search_cb(CPULoongArchState *env,
>               tlb_g = !!FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
>   
>               if (func(tlb_g, csr_asid, tlb_asid) &&
> +                tlb_entry_matches_gid(tlb, gid) &&
>                   (vpn == (tlb_vppn >> compare_shift))) {
>                   return tlb;
>               }
> @@ -265,7 +304,7 @@ static LoongArchTLB *loongarch_tlb_search_cb(CPULoongArchState *env,
>   
>       /* Search MTLB */
>       for (i = LOONGARCH_STLB; i < LOONGARCH_TLB_MAX; ++i) {
> -        tlb = &env->tlb[i];
> +        tlb = guest ? &env->gtlb[i] : &env->tlb[i];
>           tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
>           if (tlb_e) {
>               tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
> @@ -275,6 +314,7 @@ static LoongArchTLB *loongarch_tlb_search_cb(CPULoongArchState *env,
>               compare_shift = tlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT;
>               vpn = (vaddr & TARGET_VIRT_MASK) >> (tlb_ps + 1);
>               if (func(tlb_g, csr_asid, tlb_asid) &&
> +                tlb_entry_matches_gid(tlb, gid) &&
>                   (vpn == (tlb_vppn >> compare_shift))) {
>                   return tlb;
>               }
> @@ -284,17 +324,17 @@ static LoongArchTLB *loongarch_tlb_search_cb(CPULoongArchState *env,
>   }
>   
>   static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
> -                                 int *index)
> +                                 int *index, bool guest, uint8_t gid)
>   {
>       int csr_asid;
>       tlb_match func;
>       LoongArchTLB *tlb;
>   
>       func = tlb_match_any;
> -    csr_asid = FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
> -    tlb = loongarch_tlb_search_cb(env, vaddr, csr_asid, func);
> +    csr_asid = FIELD_EX64(GET_CSR_IF(guest, ASID), CSR_ASID, ASID);
> +    tlb = loongarch_tlb_search_cb(env, vaddr, csr_asid, func, guest, gid);
>       if (tlb) {
> -        *index = tlb - env->tlb;
> +        *index = guest ? (tlb - env->gtlb) : (tlb - env->tlb);
>           return true;
>       }
>   
> @@ -304,66 +344,112 @@ static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
>   void helper_tlbsrch(CPULoongArchState *env)
>   {
>       int index, match;
> +    vaddr search_ehi;
>   
> -    if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
> -        match = loongarch_tlb_search(env, env->CSR_TLBREHI, &index);
> +    if (FIELD_EX64(GET_CSR_IF(env->guest, TLBRERA), CSR_TLBRERA, ISTLBR)) {
> +        search_ehi = GET_CSR_IF(env->guest, TLBREHI);
>       } else {
> -        match = loongarch_tlb_search(env, env->CSR_TLBEHI, &index);
> +        search_ehi = GET_CSR_IF(env->guest, TLBEHI);
>       }
>   
> +    match = loongarch_tlb_search(env, search_ehi, &index, env->guest,
> +                                 get_tgid(env));
> +
>       if (match) {
> -        env->CSR_TLBIDX = FIELD_DP64(env->CSR_TLBIDX, CSR_TLBIDX, INDEX, index);
> -        env->CSR_TLBIDX = FIELD_DP64(env->CSR_TLBIDX, CSR_TLBIDX, NE, 0);
> +        SET_CSR_IF(env->guest, TLBIDX,
> +                   FIELD_DP64(GET_CSR_IF(env->guest, TLBIDX), CSR_TLBIDX, INDEX,
> +                              index));
> +        SET_CSR_IF(
> +            env->guest, TLBIDX,
> +            FIELD_DP64(GET_CSR_IF(env->guest, TLBIDX), CSR_TLBIDX, NE, 0));
>           return;
>       }
>   
> -    env->CSR_TLBIDX = FIELD_DP64(env->CSR_TLBIDX, CSR_TLBIDX, NE, 1);
> +    SET_CSR_IF(env->guest, TLBIDX,
> +               FIELD_DP64(GET_CSR_IF(env->guest, TLBIDX), CSR_TLBIDX, NE, 1));
>   }
>   
> -void helper_tlbrd(CPULoongArchState *env)
> +static void read_tlb(CPULoongArchState *env, bool guest)
>   {
>       LoongArchTLB *tlb;
>       int index;
>       uint8_t tlb_ps, tlb_e;
>   
> -    index = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, INDEX);
> -    tlb = &env->tlb[index];
> +    index = FIELD_EX64(GET_CSR_IF(guest, TLBIDX), CSR_TLBIDX, INDEX);
> +    tlb = guest ? &env->gtlb[index] : &env->tlb[index];
>       tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
>       tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
>   
>       if (!tlb_e) {
>           /* Invalid TLB entry */
> -        env->CSR_TLBIDX = FIELD_DP64(env->CSR_TLBIDX, CSR_TLBIDX, NE, 1);
> -        env->CSR_ASID  = FIELD_DP64(env->CSR_ASID, CSR_ASID, ASID, 0);
> -        env->CSR_TLBEHI = 0;
> -        env->CSR_TLBELO0 = 0;
> -        env->CSR_TLBELO1 = 0;
> -        env->CSR_TLBIDX = FIELD_DP64(env->CSR_TLBIDX, CSR_TLBIDX, PS, 0);
> +        SET_CSR_IF(guest, TLBIDX,
> +                   FIELD_DP64(GET_CSR_IF(guest, TLBIDX), CSR_TLBIDX, NE, 1));
> +        SET_CSR_IF(guest, ASID,
> +                   FIELD_DP64(GET_CSR_IF(guest, ASID), CSR_ASID, ASID, 0));
> +        SET_CSR_IF(guest, TLBEHI, 0);
> +        SET_CSR_IF(guest, TLBELO0, 0);
> +        SET_CSR_IF(guest, TLBELO1, 0);
> +        SET_CSR_IF(guest, TLBIDX,
> +                   FIELD_DP64(GET_CSR_IF(guest, TLBIDX), CSR_TLBIDX, PS, 0));
>       } else {
>           /* Valid TLB entry */
> -        env->CSR_TLBIDX = FIELD_DP64(env->CSR_TLBIDX, CSR_TLBIDX, NE, 0);
> -        env->CSR_TLBIDX = FIELD_DP64(env->CSR_TLBIDX, CSR_TLBIDX,
> -                                     PS, (tlb_ps & 0x3f));
> -        env->CSR_TLBEHI = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN) <<
> -                                     R_TLB_MISC_VPPN_SHIFT;
> -        env->CSR_TLBELO0 = tlb->tlb_entry0;
> -        env->CSR_TLBELO1 = tlb->tlb_entry1;
> +        SET_CSR_IF(guest, TLBIDX,
> +                   FIELD_DP64(GET_CSR_IF(guest, TLBIDX), CSR_TLBIDX, NE, 0));
> +        SET_CSR_IF(guest, TLBIDX,
> +                   FIELD_DP64(GET_CSR_IF(guest, TLBIDX), CSR_TLBIDX, PS,
> +                              tlb_ps & 0x3f));
> +        SET_CSR_IF(guest, TLBEHI,
> +                   FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN)
> +                       << R_TLB_MISC_VPPN_SHIFT);
> +        SET_CSR_IF(guest, TLBELO0, tlb->tlb_entry0);
> +        SET_CSR_IF(guest, TLBELO1, tlb->tlb_entry1);
> +    }
> +}
> +
> +void helper_tlbrd(CPULoongArchState *env)
> +{
> +    read_tlb(env, env->guest);
> +}
> +
> +void helper_gtlbsrch(CPULoongArchState *env)
> +{
> +    int index, match;
> +    vaddr search_ehi;
> +
> +    if (FIELD_EX64(env->GCSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
> +        search_ehi = env->GCSR_TLBREHI;
> +    } else {
> +        search_ehi = env->GCSR_TLBEHI;
> +    }
> +
> +    match = loongarch_tlb_search(env, search_ehi, &index, true, get_tgid(env));
> +    if (match) {
> +        env->GCSR_TLBIDX =
> +            FIELD_DP64(env->GCSR_TLBIDX, CSR_TLBIDX, INDEX, index);
> +        env->GCSR_TLBIDX = FIELD_DP64(env->GCSR_TLBIDX, CSR_TLBIDX, NE, 0);
> +        return;
>       }
> +    env->GCSR_TLBIDX = FIELD_DP64(env->GCSR_TLBIDX, CSR_TLBIDX, NE, 1);
> +}
> +
> +void helper_gtlbrd(CPULoongArchState *env)
> +{
> +    read_tlb(env, true);
>   }
>   
>   static void update_tlb_index(CPULoongArchState *env, MMUContext *context,
> -                             int index)
> +                             int index, bool guest)
>   {
>       LoongArchTLB *old, new = {};
>       bool skip_inv = false, tlb_v0, tlb_v1;
>   
> -    old = env->tlb + index;
> -    fill_tlb_entry(env, &new, context);
> +    old = guest ? env->gtlb + index : env->tlb + index;
> +    fill_tlb_entry(env, &new, context, guest);
>       /* Check whether ASID/VPPN is the same */
>       if (old->tlb_misc == new.tlb_misc) {
>           /* Check whether both even/odd pages is the same or invalid */
> -        tlb_v0 = pte_present(env, old->tlb_entry0);
> -        tlb_v1 = pte_present(env, old->tlb_entry1);
> +        tlb_v0 = pte_present(env, old->tlb_entry0, guest);
> +        tlb_v1 = pte_present(env, old->tlb_entry1, guest);
>           if ((!tlb_v0 || new.tlb_entry0 == old->tlb_entry0) &&
>               (!tlb_v1 || new.tlb_entry1 == old->tlb_entry1)) {
>               skip_inv = true;
> @@ -372,7 +458,7 @@ static void update_tlb_index(CPULoongArchState *env, MMUContext *context,
>   
>       /* flush tlb before updating the entry */
>       if (!skip_inv) {
> -        invalidate_tlb(env, index);
> +        invalidate_tlb(env, index, guest);
>       }
>   
>       *old = new;
> @@ -380,20 +466,34 @@ static void update_tlb_index(CPULoongArchState *env, MMUContext *context,
>   
>   void helper_tlbwr(CPULoongArchState *env)
>   {
> -    int index = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, INDEX);
> +    int index = FIELD_EX64(GET_CSR_IF(env->guest, TLBIDX), CSR_TLBIDX, INDEX);
> +    MMUContext context;
> +
> +    if (FIELD_EX64(GET_CSR_IF(env->guest, TLBIDX), CSR_TLBIDX, NE)) {
> +        invalidate_tlb(env, index, env->guest);
> +        return;
> +    }
> +
> +    sptw_prepare_context(env, &context, env->guest);
> +    update_tlb_index(env, &context, index, env->guest);
> +}
> +
> +void helper_gtlbwr(CPULoongArchState *env)
> +{
> +    int index = FIELD_EX64(env->GCSR_TLBIDX, CSR_TLBIDX, INDEX);
>       MMUContext context;
>   
> -    if (FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, NE)) {
> -        invalidate_tlb(env, index);
> +    if (FIELD_EX64(env->GCSR_TLBIDX, CSR_TLBIDX, NE)) {
> +        invalidate_tlb(env, index, true);
>           return;
>       }
>   
> -    sptw_prepare_context(env, &context);
> -    update_tlb_index(env, &context, index);
> +    sptw_prepare_context(env, &context, true);
> +    update_tlb_index(env, &context, index, true);
>   }
>   
>   static int get_tlb_random_index(CPULoongArchState *env, vaddr addr,
> -                                int pagesize)
> +                                int pagesize, bool guest)
>   {
>       uint64_t address;
>       int index, set, i, stlb_idx;
> @@ -402,15 +502,16 @@ static int get_tlb_random_index(CPULoongArchState *env, vaddr addr,
>       uint8_t tlb_e, tlb_g;
>   
>       /* Validity of stlb_ps is checked in helper_csrwr_stlbps() */
> -    stlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
> -    asid = FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
> +    stlb_ps = FIELD_EX64(GET_CSR_IF(guest, STLBPS), CSR_STLBPS, PS);
> +    asid = FIELD_EX64(GET_CSR_IF(guest, ASID), CSR_ASID, ASID);
>       if (pagesize == stlb_ps) {
>           /* Only write into STLB bits [47:13] */
>           address = addr & ~MAKE_64BIT_MASK(0, R_CSR_TLBEHI_64_VPPN_SHIFT);
>           set = -1;
>           stlb_idx = (address >> (stlb_ps + 1)) & 0xff; /* [0,255] */
>           for (i = 0; i < 8; ++i) {
> -            tlb = &env->tlb[i * 256 + stlb_idx];
> +            tlb = guest ? &env->gtlb[i * 256 + stlb_idx] :
> +                          &env->tlb[i * 256 + stlb_idx];
>               tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
>               if (!tlb_e) {
>                   set = i;
> @@ -419,7 +520,8 @@ static int get_tlb_random_index(CPULoongArchState *env, vaddr addr,
>   
>               tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
>               tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
> -            if (tlb_g == 0 && asid != tlb_asid) {
> +            if (tlb_g == 0 && asid != tlb_asid &&
> +                tlb_entry_matches_gid(tlb, get_tgid(env))) {
>                   set = i;
>               }
>           }
> @@ -433,7 +535,7 @@ static int get_tlb_random_index(CPULoongArchState *env, vaddr addr,
>           /* Only write into MTLB */
>           index = -1;
>           for (i = LOONGARCH_STLB; i < LOONGARCH_TLB_MAX; i++) {
> -            tlb = &env->tlb[i];
> +            tlb = guest ? &env->gtlb[i] : &env->tlb[i];
>               tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
>   
>               if (!tlb_e) {
> @@ -443,7 +545,8 @@ static int get_tlb_random_index(CPULoongArchState *env, vaddr addr,
>   
>               tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
>               tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
> -            if (tlb_g == 0 && asid != tlb_asid) {
> +            if (tlb_g == 0 && asid != tlb_asid &&
> +                tlb_entry_matches_gid(tlb, get_tgid(env))) {
>                   index = i;
>               }
>           }
> @@ -462,48 +565,70 @@ void helper_tlbfill(CPULoongArchState *env)
>       int index, pagesize;
>       MMUContext context;
>   
> -    if (FIELD_EX64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
> -        entryhi = env->CSR_TLBREHI;
> +    if (FIELD_EX64(GET_CSR_IF(env->guest, TLBRERA), CSR_TLBRERA, ISTLBR)) {
> +        entryhi = GET_CSR_IF(env->guest, TLBREHI);
>           /* Validity of pagesize is checked in helper_ldpte() */
> -        pagesize = FIELD_EX64(env->CSR_TLBREHI, CSR_TLBREHI, PS);
> +        pagesize = FIELD_EX64(GET_CSR_IF(env->guest, TLBREHI), CSR_TLBREHI, PS);
>       } else {
> -        entryhi = env->CSR_TLBEHI;
> +        entryhi = GET_CSR_IF(env->guest, TLBEHI);
>           /* Validity of pagesize is checked in helper_tlbrd() */
> -        pagesize = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, PS);
> +        pagesize = FIELD_EX64(GET_CSR_IF(env->guest, TLBIDX), CSR_TLBIDX, PS);
>       }
>   
> -    sptw_prepare_context(env, &context);
> -    index = get_tlb_random_index(env, entryhi, pagesize);
> -    invalidate_tlb(env, index);
> -    fill_tlb_entry(env, env->tlb + index, &context);
> +    sptw_prepare_context(env, &context, env->guest);
> +    index = get_tlb_random_index(env, entryhi, pagesize, env->guest);
> +    invalidate_tlb(env, index, env->guest);
> +    fill_tlb_entry(env, env->guest ? env->gtlb + index : env->tlb + index,
> +                   &context, env->guest);
>   }
>   
> -void helper_tlbclr(CPULoongArchState *env)
> +void helper_gtlbfill(CPULoongArchState *env)
> +{
> +    vaddr entryhi;
> +    int index, pagesize;
> +    MMUContext context;
> +
> +    if (FIELD_EX64(env->GCSR_TLBRERA, CSR_TLBRERA, ISTLBR)) {
> +        entryhi = env->GCSR_TLBREHI;
> +        pagesize = FIELD_EX64(env->GCSR_TLBREHI, CSR_TLBREHI, PS);
> +    } else {
> +        entryhi = env->GCSR_TLBEHI;
> +        pagesize = FIELD_EX64(env->GCSR_TLBIDX, CSR_TLBIDX, PS);
> +    }
> +
> +    sptw_prepare_context(env, &context, true);
> +    index = get_tlb_random_index(env, entryhi, pagesize, true);
> +    invalidate_tlb(env, index, true);
> +    fill_tlb_entry(env, env->gtlb + index, &context, true);
> +}
> +
> +static void clear_tlb_by_index(CPULoongArchState *env, bool guest)
>   {
>       LoongArchTLB *tlb;
>       int i, index;
>       uint16_t csr_asid, tlb_asid, tlb_g;
>   
> -    csr_asid = FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
> -    index = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, INDEX);
> +    csr_asid = FIELD_EX64(GET_CSR_IF(guest, ASID), CSR_ASID, ASID);
> +    index = FIELD_EX64(GET_CSR_IF(guest, TLBIDX), CSR_TLBIDX, INDEX);
>   
>       if (index < LOONGARCH_STLB) {
> -        /* STLB. One line per operation */
>           for (i = 0; i < 8; i++) {
> -            tlb = &env->tlb[i * 256 + (index % 256)];
> +            tlb = guest ? &env->gtlb[i * 256 + (index % 256)] :
> +                          &env->tlb[i * 256 + (index % 256)];
>               tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
>               tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
> -            if (!tlb_g && tlb_asid == csr_asid) {
> +            if (!tlb_g && tlb_asid == csr_asid &&
> +                tlb_entry_matches_gid(tlb, get_tgid(env))) {
>                   tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
>               }
>           }
>       } else if (index < LOONGARCH_TLB_MAX) {
> -        /* All MTLB entries */
>           for (i = LOONGARCH_STLB; i < LOONGARCH_TLB_MAX; i++) {
> -            tlb = &env->tlb[i];
> +            tlb = guest ? &env->gtlb[i] : &env->tlb[i];
>               tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
>               tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
> -            if (!tlb_g && tlb_asid == csr_asid) {
> +            if (!tlb_g && tlb_asid == csr_asid &&
> +                tlb_entry_matches_gid(tlb, get_tgid(env))) {
>                   tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
>               }
>           }
> @@ -512,62 +637,116 @@ void helper_tlbclr(CPULoongArchState *env)
>       tlb_flush(env_cpu(env));
>   }
>   
> -void helper_tlbflush(CPULoongArchState *env)
> +void helper_tlbclr(CPULoongArchState *env)
> +{
> +    clear_tlb_by_index(env, env->guest);
> +}
> +
> +void helper_gtlbclr(CPULoongArchState *env)
> +{
> +    clear_tlb_by_index(env, true);
> +}
> +
> +static void flush_tlb_by_index(CPULoongArchState *env, bool guest)
>   {
>       int i, index;
>   
> -    index = FIELD_EX64(env->CSR_TLBIDX, CSR_TLBIDX, INDEX);
> +    index = FIELD_EX64(GET_CSR_IF(guest, TLBIDX), CSR_TLBIDX, INDEX);
>   
>       if (index < LOONGARCH_STLB) {
> -        /* STLB. One line per operation */
>           for (i = 0; i < 8; i++) {
>               int s_idx = i * 256 + (index % 256);
> -            env->tlb[s_idx].tlb_misc = FIELD_DP64(env->tlb[s_idx].tlb_misc,
> -                                                  TLB_MISC, E, 0);
> +            LoongArchTLB *tlb = guest ? &env->gtlb[s_idx] : &env->tlb[s_idx];
> +
> +            tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
>           }
>       } else if (index < LOONGARCH_TLB_MAX) {
> -        /* All MTLB entries */
>           for (i = LOONGARCH_STLB; i < LOONGARCH_TLB_MAX; i++) {
> -            env->tlb[i].tlb_misc = FIELD_DP64(env->tlb[i].tlb_misc,
> -                                              TLB_MISC, E, 0);
> +            LoongArchTLB *tlb = guest ? &env->gtlb[i] : &env->tlb[i];
> +
> +            tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
>           }
>       }
>   
>       tlb_flush(env_cpu(env));
>   }
>   
> -void helper_invtlb_all(CPULoongArchState *env)
> +void helper_tlbflush(CPULoongArchState *env)
> +{
> +    flush_tlb_by_index(env, env->guest);
> +}
> +
> +void helper_gtlbflush(CPULoongArchState *env)
> +{
> +    flush_tlb_by_index(env, true);
> +}
> +
> +void helper_invtlb_all(CPULoongArchState *env, target_ulong info, uint32_t op,
> +                       uint32_t to_guest)
>   {
> +    uint16_t gid = to_guest ? (info & 0xff) : get_tgid(env);
> +
> +    if (to_guest && env->guest) {
> +        do_raise_exception(env, EXCCODE_IPE, GETPC());
> +    }
> +
> +    to_guest |= env->guest;
> +
>       for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
> -        env->tlb[i].tlb_misc = FIELD_DP64(env->tlb[i].tlb_misc,
> -                                          TLB_MISC, E, 0);
> +        LoongArchTLB *tlb = &env->tlb[i];
> +        LoongArchTLB *gtlb = &env->gtlb[i];
> +
> +        if (!to_guest && (op == 0 || tlb_entry_matches_gid(tlb, 0))) {
> +            tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
> +        }
> +        if ((!to_guest && op == 0) ||
> +            (to_guest && tlb_entry_matches_gid(gtlb, gid))) {
> +            gtlb->tlb_misc = FIELD_DP64(gtlb->tlb_misc, TLB_MISC, E, 0);
> +        }
>       }
>       tlb_flush(env_cpu(env));
>   }
>   
> -void helper_invtlb_all_g(CPULoongArchState *env, uint32_t g)
> +void helper_invtlb_all_g(CPULoongArchState *env, target_ulong info, uint32_t g,
> +                         uint32_t to_guest)
>   {
> +    uint16_t gid = to_guest ? (info & 0xff) : get_tgid(env);
> +
> +    if (to_guest && env->guest) {
> +        do_raise_exception(env, EXCCODE_IPE, GETPC());
> +    }
> +
> +    to_guest |= env->guest;
> +
>       for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
> -        LoongArchTLB *tlb = &env->tlb[i];
> +        LoongArchTLB *tlb = to_guest ? &env->gtlb[i] : &env->tlb[i];
>           uint8_t tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
>   
> -        if (tlb_g == g) {
> +        if (tlb_g == g && tlb_entry_matches_gid(tlb, gid)) {
>               tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
>           }
>       }
>       tlb_flush(env_cpu(env));
>   }
>   
> -void helper_invtlb_all_asid(CPULoongArchState *env, target_ulong info)
> +void helper_invtlb_all_asid(CPULoongArchState *env, target_ulong info,
> +                            uint32_t to_guest)
>   {
>       uint16_t asid = info & R_CSR_ASID_ASID_MASK;
> +    uint16_t gid = to_guest ? ((info >> 16) & 0xff) : get_tgid(env);
> +
> +    if (to_guest && env->guest) {
> +        do_raise_exception(env, EXCCODE_IPE, GETPC());
> +    }
> +
> +    to_guest |= env->guest;
>   
>       for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
> -        LoongArchTLB *tlb = &env->tlb[i];
> +        LoongArchTLB *tlb = to_guest ? &env->gtlb[i] : &env->tlb[i];
>           uint8_t tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
>           uint16_t tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
>   
> -        if (!tlb_g && (tlb_asid == asid)) {
> +        if (!tlb_g && tlb_asid == asid && tlb_entry_matches_gid(tlb, gid)) {
>               tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
>           }
>       }
> @@ -575,66 +754,82 @@ void helper_invtlb_all_asid(CPULoongArchState *env, target_ulong info)
>   }
>   
>   void helper_invtlb_page_asid(CPULoongArchState *env, target_ulong info,
> -                             target_ulong addr)
> +                             target_ulong addr, uint32_t to_guest)
>   {
> -    int asid = info & 0x3ff;
> +    uint16_t asid = info & R_CSR_ASID_ASID_MASK;
> +    uint16_t gid = to_guest ? ((info >> 16) & 0xff) : get_tgid(env);
>       LoongArchTLB *tlb;
> -    tlb_match func;
> +    int index;
> +
> +    if (to_guest && env->guest) {
> +        do_raise_exception(env, EXCCODE_IPE, GETPC());
> +    }
> +    to_guest |= env->guest;
>   
> -    func = tlb_match_asid;
> -    tlb = loongarch_tlb_search_cb(env, addr, asid, func);
> +    tlb =
> +        loongarch_tlb_search_cb(env, addr, asid, tlb_match_asid, to_guest, gid);
>       if (tlb) {
> -        invalidate_tlb(env, tlb - env->tlb);
> +        index = to_guest ? (tlb - env->gtlb) : (tlb - env->tlb);
> +        invalidate_tlb(env, index, to_guest);
>       }
>   }
>   
> -void helper_invtlb_page_asid_or_g(CPULoongArchState *env,
> -                                  target_ulong info, target_ulong addr)
> +void helper_invtlb_page_asid_or_g(CPULoongArchState *env, target_ulong info,
> +                                  target_ulong addr, uint32_t to_guest)
>   {
> -    int asid = info & 0x3ff;
> +    uint16_t asid = info & R_CSR_ASID_ASID_MASK;
> +    uint16_t gid = to_guest ? ((info >> 16) & 0xff) : get_tgid(env);
>       LoongArchTLB *tlb;
> -    tlb_match func;
> +    int index;
>   
> -    func = tlb_match_any;
> -    tlb = loongarch_tlb_search_cb(env, addr, asid, func);
> +    if (to_guest && env->guest) {
> +        do_raise_exception(env, EXCCODE_IPE, GETPC());
> +    }
> +
> +    to_guest |= env->guest;
> +
> +    tlb =
> +        loongarch_tlb_search_cb(env, addr, asid, tlb_match_any, to_guest, gid);
>       if (tlb) {
> -        invalidate_tlb(env, tlb - env->tlb);
> +        index = to_guest ? (tlb - env->gtlb) : (tlb - env->tlb);
> +        invalidate_tlb(env, index, to_guest);
>       }
>   }
>   
> -static void ptw_update_tlb(CPULoongArchState *env, MMUContext *context)
> +static void ptw_update_tlb(CPULoongArchState *env, MMUContext *context,
> +                           bool guest)
>   {
>       int index;
>   
>       index = context->tlb_index;
>       if (index < 0) {
> -        index = get_tlb_random_index(env, context->addr, context->ps);
> +        index = get_tlb_random_index(env, context->addr, context->ps, guest);
>       }
>   
> -    update_tlb_index(env, context, index);
> +    update_tlb_index(env, context, index, guest);
>   }
>   
> -bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> -                            MMUAccessType access_type, int mmu_idx,
> -                            bool probe, uintptr_t retaddr)
> +TLBRet loongarch_map_host_address(CPULoongArchState *env, MMUContext *context,
> +                                  MMUAccessType access_type, uintptr_t retaddr)
>   {
> -    CPULoongArchState *env = cpu_env(cs);
> -    hwaddr physical;
> -    int prot;
> -    MMUContext context;
>       TLBRet ret;
> +    ret = loongarch_map_address(env, context, access_type, MMU_KERNEL_IDX,
> +                                false, false, retaddr);
> +    return TLBRET_HOST_MATCH + ret;
> +}
>   
> -    /* Data access */
> -    context.addr = address;
> -    context.tlb_index = -1;
> -    ret = get_physical_address(env, &context, access_type, mmu_idx, 0);
> -    if (ret == TLBRET_MATCH && context.mmu_index != MMU_DA_IDX
> -        && cpu_has_ptw(env)) {
> +static void loongarch_try_ptw(CPULoongArchState *env, MMUContext *context,
> +                              MMUAccessType access_type, int mmu_index,
> +                              TLBRet *status, bool guest, uintptr_t retaddr)
> +{
> +    if ((*status == TLBRET_MATCH || *status == TLBRET_HOST_MATCH) &&
> +        context->mmu_index != MMU_DA_IDX &&
> +        context->mmu_index != MMU_GUEST_DA_IDX && cpu_has_ptw(env, guest)) {
>           bool need_update = true;
>   
> -        if (access_type == MMU_DATA_STORE && pte_dirty(context.pte)) {
> +        if (access_type == MMU_DATA_STORE && pte_dirty(context->pte)) {
>               need_update = false;
> -        } else if (access_type != MMU_DATA_STORE && pte_access(context.pte)) {
> +        } else if (access_type != MMU_DATA_STORE && pte_access(context->pte)) {
>               need_update = false;
>   
>               /*
> @@ -649,31 +844,77 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>   
>           if (need_update) {
>               /* Need update bit A/D in PTE entry, take PTW again */
> -            ret = TLBRET_NOMATCH;
> +            *status =
> +                (env->guest && !guest) ? TLBRET_HOST_NOMATCH : TLBRET_NOMATCH;
>           }
>       }
>   
> -    if (ret != TLBRET_MATCH && cpu_has_ptw(env)) {
> +    if (*status != TLBRET_MATCH && *status != TLBRET_HOST_MATCH &&
> +        cpu_has_ptw(env, guest)) {
>           /* Take HW PTW if TLB missed or bit P is zero */
> -        if (ret == TLBRET_NOMATCH || ret == TLBRET_INVALID) {
> -            ret = loongarch_ptw(env, &context, access_type, mmu_idx, 0);
> -            if (ret == TLBRET_MATCH) {
> -                ptw_update_tlb(env, &context);
> +        if (*status == TLBRET_NOMATCH || *status == TLBRET_INVALID ||
> +            *status == TLBRET_HOST_NOMATCH || *status == TLBRET_HOST_INVALID) {
> +            *status =
> +                ((env->guest && !guest) ? TLBRET_HOST_MATCH : TLBRET_MATCH) +
> +                loongarch_ptw(env, context, access_type, mmu_index, 0, guest,
> +                              retaddr);
> +            if (*status == TLBRET_MATCH || *status == TLBRET_HOST_MATCH) {
> +                ptw_update_tlb(env, context, guest);
>               }
> -        } else if (context.tlb_index >= 0) {
> -            invalidate_tlb(env, context.tlb_index);
> +        } else if (context->tlb_index >= 0) {
> +            invalidate_tlb(env, context->tlb_index, guest);
>           }
>       }
> +}
> +
> +bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> +                            MMUAccessType access_type, int mmu_idx, bool probe,
> +                            uintptr_t retaddr)
> +{
> +    CPULoongArchState *env = cpu_env(cs);
> +    MMUContext host_context;
> +    hwaddr physical;
> +    int prot, host_prot;
> +    MMUContext context;
> +    TLBRet ret;
> +
> +    /* Data access */
> +    context.addr = address;
> +    context.tlb_index = -1;
> +    ret = get_physical_address(env, &context, access_type, mmu_idx, 0, retaddr);
> +    loongarch_try_ptw(env, &context, access_type, mmu_idx, &ret, env->guest,
> +                      retaddr);
>   
>       if (ret == TLBRET_MATCH) {
>           physical = context.physical;
>           prot = context.prot;
> +        if (env->guest) {
> +            host_context.addr = physical;
> +            host_context.tlb_index = -1;
> +            ret = loongarch_map_host_address(env, &host_context, access_type,
> +                                             retaddr);
> +            loongarch_try_ptw(env, &host_context, access_type, MMU_KERNEL_IDX,
> +                              &ret, false, retaddr);
> +            if (ret != TLBRET_HOST_MATCH) {
> +                if (probe) {
> +                    return false;
> +                }
> +                raise_mmu_exception(env, physical, access_type, ret);
> +                cpu_loop_exit_restore(cs, retaddr);
> +                return false;
> +            }
> +            physical = host_context.physical;
> +            host_prot = host_context.prot;
> +            prot &= host_prot;
> +        }
>           tlb_set_page(cs, address & TARGET_PAGE_MASK,
>                        physical & TARGET_PAGE_MASK, prot,
>                        mmu_idx, TARGET_PAGE_SIZE);
>           qemu_log_mask(CPU_LOG_MMU,
>                         "%s address=%" VADDR_PRIx " physical " HWADDR_FMT_plx
> -                      " prot %d\n", __func__, address, physical, prot);
> +                      " prot %d guest %d\n",
> +                      __func__, address, physical, prot,
> +                      is_guest_mmu_idx(mmu_idx));
>           return true;
>       } else {
>           qemu_log_mask(CPU_LOG_MMU,
> @@ -702,6 +943,31 @@ static inline uint64_t loongarch_sanitize_hw_pte(CPULoongArchState *env,
>       return (pte & ~ppn_mask) | ((pte & ppn_mask) & palen_mask);
>   }
>   
> +hwaddr loongarch_get_host_address(CPULoongArchState *env, hwaddr gpa,
> +                                  uintptr_t retaddr)
> +{
> +    MMUContext host_context;
> +    TLBRet ret;
> +
> +    if (!env->guest) {
> +        return gpa;
> +    }
> +
> +    host_context.addr = gpa;
> +    host_context.tlb_index = -1;
> +    ret =
> +        loongarch_map_host_address(env, &host_context, MMU_DATA_LOAD, retaddr);
> +    loongarch_try_ptw(env, &host_context, MMU_DATA_LOAD, MMU_KERNEL_IDX, &ret,
> +                      false, retaddr);
> +
> +    if (ret != TLBRET_HOST_MATCH) {
> +        raise_mmu_exception(env, gpa, MMU_DATA_LOAD, ret);
> +        cpu_loop_exit_restore(env_cpu(env), retaddr);
> +    }
> +
> +    return host_context.physical;
> +}
> +
>   target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
>                             uint32_t level, uint32_t mem_idx)
>   {
> @@ -732,12 +998,15 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
>           }
>       }
>   
> -    badvaddr = env->CSR_TLBRBADV;
> +    badvaddr = GET_CSR_IF(env->guest, TLBRBADV);
>       base = base & palen_mask;
> -    get_dir_base_width(env, &dir_base, &dir_width, level);
> +    get_dir_base_width(env, &dir_base, &dir_width, level, env->guest);
>       index = (badvaddr >> dir_base) & ((1 << dir_width) - 1);
>       phys = base | index << 3;
> -    val = address_space_ldq_le(cs->as, phys, MEMTXATTRS_UNSPECIFIED, NULL);
> +    val = address_space_ldq_le(
> +        cs->as,
> +        (env->guest ? loongarch_get_host_address(env, phys, GETPC()) : phys),
> +        MEMTXATTRS_UNSPECIFIED, NULL);
>   
>       return val & palen_mask;
>   }
> @@ -749,8 +1018,10 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
>       hwaddr phys, tmp0, ptindex, ptoffset0, ptoffset1;
>       uint64_t pte_raw;
>       uint64_t badv;
> -    uint64_t ptbase = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE);
> -    uint64_t ptwidth = FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTWIDTH);
> +    uint64_t ptbase =
> +        FIELD_EX64(GET_CSR_IF(env->guest, PWCL), CSR_PWCL, PTBASE);
> +    uint64_t ptwidth =
> +        FIELD_EX64(GET_CSR_IF(env->guest, PWCL), CSR_PWCL, PTWIDTH);
>       uint64_t palen_mask = loongarch_palen_mask(env);
>       uint64_t dir_base, dir_width;
>       uint8_t  ps;
> @@ -771,7 +1042,7 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
>            * Move HGLOBAL bit to GLOBAL bit.
>            */
>           get_dir_base_width(env, &dir_base, &dir_width,
> -                           FIELD_EX64(base, TLBENTRY, LEVEL));
> +                           FIELD_EX64(base, TLBENTRY, LEVEL), env->guest);
>   
>           base = FIELD_DP64(base, TLBENTRY, LEVEL, 0);
>           base = FIELD_DP64(base, TLBENTRY, HUGE, 0);
> @@ -796,7 +1067,7 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
>               return;
>           }
>       } else {
> -        badv = env->CSR_TLBRBADV;
> +        badv = GET_CSR_IF(env->guest, TLBRBADV);
>   
>           base = base & palen_mask;
>   
> @@ -805,26 +1076,31 @@ void helper_ldpte(CPULoongArchState *env, target_ulong base, target_ulong odd,
>           ptoffset0 = ptindex << 3;
>           ptoffset1 = (ptindex + 1) << 3;
>           phys = base | (odd ? ptoffset1 : ptoffset0);
> -        pte_raw = address_space_ldq_le(cs->as, phys,
> -                                       MEMTXATTRS_UNSPECIFIED, NULL);
> +        pte_raw = address_space_ldq_le(
> +            cs->as,
> +            (env->guest ? loongarch_get_host_address(env, phys, GETPC()) :
> +                          phys),
> +            MEMTXATTRS_UNSPECIFIED, NULL);
>           tmp0 = loongarch_sanitize_hw_pte(env, pte_raw);
>           ps = ptbase;
>       }
>   
>       if (odd) {
> -        env->CSR_TLBRELO1 = tmp0;
> +        SET_CSR_IF(env->guest, TLBRELO1, tmp0);
>       } else {
> -        env->CSR_TLBRELO0 = tmp0;
> +        SET_CSR_IF(env->guest, TLBRELO0, tmp0);
>       }
> -    env->CSR_TLBREHI = FIELD_DP64(env->CSR_TLBREHI, CSR_TLBREHI, PS, ps);
> +    SET_CSR_IF(
> +        env->guest, TLBREHI,
> +        FIELD_DP64(GET_CSR_IF(env->guest, TLBREHI), CSR_TLBREHI, PS, ps));
>   }
>   
>   static TLBRet loongarch_map_tlb_entry(CPULoongArchState *env,
>                                         MMUContext *context,
>                                         MMUAccessType access_type, int index,
> -                                      int mmu_idx)
> +                                      int mmu_idx, bool guest)
>   {
> -    LoongArchTLB *tlb = &env->tlb[index];
> +    LoongArchTLB *tlb = guest ? &env->gtlb[index] : &env->tlb[index];
>       uint8_t tlb_ps, n;
>   
>       tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
> @@ -832,19 +1108,20 @@ static TLBRet loongarch_map_tlb_entry(CPULoongArchState *env,
>       context->pte = n ? tlb->tlb_entry1 : tlb->tlb_entry0;
>       context->ps = tlb_ps;
>       context->tlb_index = index;
> -    return loongarch_check_pte(env, context, access_type, mmu_idx);
> +    return loongarch_check_pte(env, context, access_type, mmu_idx, guest);
>   }
>   
> -TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env,
> -                                   MMUContext *context,
> -                                   MMUAccessType access_type, int mmu_idx)
> +TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env, MMUContext *context,
> +                                   MMUAccessType access_type, int mmu_idx,
> +                                   bool guest)
>   {
>       int index, match;
>   
> -    match = loongarch_tlb_search(env, context->addr, &index);
> +    match =
> +        loongarch_tlb_search(env, context->addr, &index, guest, get_tgid(env));
>       if (match) {
>           return loongarch_map_tlb_entry(env, context, access_type, index,
> -                                       mmu_idx);
> +                                       mmu_idx, guest);
>       }
>   
>       return TLBRET_NOMATCH;
> diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
> index 124dce6269..15c83ef72d 100644
> --- a/target/loongarch/tcg/translate.c
> +++ b/target/loongarch/tcg/translate.c
> @@ -122,12 +122,16 @@ static void loongarch_tr_init_disas_context(DisasContextBase *dcbase,
>       CPULoongArchState *env = cpu_env(cs);
>       DisasContext *ctx = container_of(dcbase, DisasContext, base);
>   
> +    ctx->guest_mode = (ctx->base.tb->flags & HW_FLAGS_GUEST_MODE) != 0;
>       ctx->page_start = ctx->base.pc_first & TARGET_PAGE_MASK;
>       ctx->plv = ctx->base.tb->flags & HW_FLAGS_PLV_MASK;
>       if (ctx->base.tb->flags & HW_FLAGS_CRMD_PG) {
>           ctx->mem_idx = ctx->plv;
> +        if (ctx->guest_mode) {
> +            ctx->mem_idx += MMU_GUEST_IDX;
> +        }
>       } else {
> -        ctx->mem_idx = MMU_DA_IDX;
> +        ctx->mem_idx = ctx->guest_mode ? MMU_GUEST_DA_IDX : MMU_DA_IDX;
>       }
>   
>       /* Bound the number of insns to execute to those left on the page.  */
> diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
> index 8aa8325dc6..db0650e713 100644
> --- a/target/loongarch/translate.h
> +++ b/target/loongarch/translate.h
> @@ -26,6 +26,7 @@
>   #define avail_FP_DP(C)  (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP_DP))
>   #define avail_LSPW(C)   (FIELD_EX32((C)->cpucfg2, CPUCFG2, LSPW))
>   #define avail_LAM(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, LAM))
> +#define avail_LVZ(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, LVZ))
>   #define avail_LAM_BH(C) (FIELD_EX32((C)->cpucfg2, CPUCFG2, LAM_BH))
>   #define avail_LAMCAS(C) (FIELD_EX32((C)->cpucfg2, CPUCFG2, LAMCAS))
>   #define avail_LSX(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, LSX))
> @@ -66,6 +67,7 @@ typedef struct DisasContext {
>       TCGv zero;
>       bool la64; /* LoongArch64 mode */
>       bool va32; /* 32-bit virtual address */
> +    bool guest_mode;
>       uint32_t cpucfg1;
>       uint32_t cpucfg2;
>       uint32_t cpucfg3;
> 


