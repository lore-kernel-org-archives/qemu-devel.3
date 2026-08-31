Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A05EC61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 02:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0sCo-0000pv-5q; Sun, 30 Aug 2026 22:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1x0sCl-0000pH-0c
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 22:57:03 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1x0sCh-0003L5-TF
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 22:57:02 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Ax29Fw7ZRq4L8GAA--.18950S3;
 Mon, 31 Aug 2026 10:56:48 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJCx9cxp7ZRqmfsXAA--.22967S2;
 Mon, 31 Aug 2026 10:56:43 +0800 (CST)
Subject: Re: [PATCH v4 02/14] target/loongarch: Add LVZ CPU state definitions
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: xianglai li <lixianglai@loongson.cn>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <cover.1787739852.git.prcups@krgm.moe>
 <17b4c21625c92521c49585de983babc0400b4836.1787739852.git.prcups@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <2b3ee697-6b50-0029-3f7e-e81359bfee29@loongson.cn>
Date: Mon, 31 Aug 2026 10:56:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <17b4c21625c92521c49585de983babc0400b4836.1787739852.git.prcups@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCx9cxp7ZRqmfsXAA--.22967S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Xw4kJr4DJFy5tFy8Gw1fZrc_yoWfWrW3pr
 W2kFy3KF48KFWxZanaqw4YkFnxXr1xG342g347KrySyF4kX348Wr1vg39xCF4UX348W34x
 Za1kAa15Wa9rXagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
 0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8yr
 W7UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.789,
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



On 2026/8/26 下午6:30, SignKirigami wrote:
> Add host and guest system-state banks, LVZ exception and MMU indices,
> CPU and translation state, and helpers for selecting a VM-level CSR bank.
> 
> Read host ERA and BADV explicitly when generating ELF core notes so the
> result does not depend on the currently selected guest state.
> 
> Signed-off-by: SignKirigami <prcups@krgm.moe>
> Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
> ---
>   target/loongarch/arch_dump.c |  6 ++--
>   target/loongarch/cpu.c       |  4 +--
>   target/loongarch/cpu.h       | 64 ++++++++++++++++++++++++++++++++++--
>   target/loongarch/translate.h |  2 ++
>   4 files changed, 68 insertions(+), 8 deletions(-)
> 
> diff --git a/target/loongarch/arch_dump.c b/target/loongarch/arch_dump.c
> index 9d84faef96..711b23257b 100644
> --- a/target/loongarch/arch_dump.c
> +++ b/target/loongarch/arch_dump.c
> @@ -116,7 +116,7 @@ int loongarch_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
>   {
>       struct loongarch_note note;
>       CPULoongArchState *env = &LOONGARCH_CPU(cs)->env;
> -    CPUSysState *sys = env_sys(env);
> +    CPUSysState *host = get_sys(env, LOONGARCH_VM_LEVEL_HOST);
>       int ret, i;
yes, it need similar modification with loongarch_cpu_write_elf64_note().
can we keep local variable sys unchanged so that the change is smaller?

BTW I do not know which name is better between LOONGARCH_VM_LEVEL_HOST 
and LOONGARCH_VM_LEVEL0. Such as in KVM mode, it is to dump CSR 
resisters of guest VM; however in TCG mode, it is for host.
>   
>       loongarch_note_init(&note, s, "CORE", 5, NT_PRSTATUS,
> @@ -127,8 +127,8 @@ int loongarch_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
>       for (i = 0; i < 32; ++i) {
>           note.prstatus.pr_reg.gpr[i] = cpu_to_dump64(s, env->gpr[i]);
>       }
> -    note.prstatus.pr_reg.csr_era  = cpu_to_dump64(s, sys->CSR_ERA);
> -    note.prstatus.pr_reg.csr_badv = cpu_to_dump64(s, sys->CSR_BADV);
> +    note.prstatus.pr_reg.csr_era  = cpu_to_dump64(s, host->CSR_ERA);
> +    note.prstatus.pr_reg.csr_badv = cpu_to_dump64(s, host->CSR_BADV);
>       ret = f(&note, LOONGARCH_PRSTATUS_NOTE_SIZE, s);
>       if (ret < 0) {
>           return -1;
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index fb03424ffa..2f7692dc93 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -282,7 +282,7 @@ static void loongarch_la464_initfn(Object *obj)
>       uint32_t data = 0, field;
>       int i;
>   
> -    set_sys_state(env, &env->sys_states[0]);
> +    set_sys(env, LOONGARCH_VM_LEVEL_HOST);
>       for (i = 0; i < 21; i++) {
>           env->cpucfg[i] = 0x0;
>       }
> @@ -412,7 +412,7 @@ static void loongarch_la132_initfn(Object *obj)
>       uint32_t data = 0;
>       int i;
>   
> -    set_sys_state(env, &env->sys_states[0]);
> +    set_sys(env, LOONGARCH_VM_LEVEL_HOST);
>       for (i = 0; i < 21; i++) {
>           env->cpucfg[i] = 0x0;
>       }
I still think that it need split to smaller version, such as
   1. get_sys()/set_sys() and its user.
   2. mmu_idx change for new added LVZ
   3. others

> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index ad30c73167..be982b7695 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -20,6 +20,8 @@
>   #include "cpu-csr.h"
>   #include "cpu-qom.h"
>   
> +#define CPU_INTERRUPT_GUEST CPU_INTERRUPT_TGT_EXT_0
> +
>   #define FCSR0_M1    0x1f         /* FCSR1 mask, Enables */
>   #define FCSR0_M2    0x1f1f0000   /* FCSR2 mask, Cause and Flags */
>   #define FCSR0_M3    0x300        /* FCSR3 mask, Round Mode */
> @@ -93,6 +95,10 @@ FIELD(FCSR0, CAUSE, 24, 5)
>   #define  EXCCODE_WPEM                EXCODE(19, 1)
>   #define  EXCCODE_BTD                 EXCODE(20, 0)
>   #define  EXCCODE_BTE                 EXCODE(21, 0)
> +#define  EXCCODE_GSPR                EXCODE(22, 0)
> +#define  EXCCODE_HVC                 EXCODE(23, 0)
> +#define  EXCCODE_GCSC                EXCODE(24, 0)
> +#define  EXCCODE_GCHC                EXCODE(25, 0)
The exception for LVZ is added however not used, it had better be added 
in patch where it is actually used.
>   #define  EXCCODE_DBP                 EXCODE(26, 0) /* Reserved subcode used for debug */
>   
>   /* cpucfg[0] bits */
> @@ -255,6 +261,7 @@ FIELD(TLB_MISC, E, 0, 1)
>   FIELD(TLB_MISC, ASID, 1, 10)
>   FIELD(TLB_MISC, VPPN, 13, 35)
>   FIELD(TLB_MISC, PS, 48, 6)
> +FIELD(TLB_MISC, GID, 54, 8)
>   
>   /*Msg interrupt registers */
>   #define N_MSGIS                4
> @@ -314,6 +321,10 @@ typedef struct  LoongArchBT {
>       uint32_t ftop;
>   } lbt_t;
>   
> +#define LOONGARCH_VM_LEVEL_HOST      0
> +#define LOONGARCH_VM_LEVEL_GUEST     1
> +#define LOONGARCH_VM_LEVELS          2
> +
>   #define CPU_VENDOR_LOONGSON   "Loongson"
>   #define CPU_MODEL_3A5000      "3A5000"
>   #define CPU_MODEL_1C101       "1C101"
> @@ -375,10 +386,18 @@ typedef struct CPUSysState {
>       uint64_t CSR_DBG;
>       uint64_t CSR_DERA;
>       uint64_t CSR_DSAVE;
> +    uint64_t CSR_GSTAT;
> +    uint64_t CSR_GCFG;
> +    uint64_t CSR_GINTC;
> +    uint64_t CSR_GCNTC;
> +    uint64_t CSR_GTLBC;
I think this patch can move to patch 1.

>       /* Msg interrupt registers */
>       uint64_t CSR_MSGIS[N_MSGIS];
>       uint64_t CSR_MSGIR;
>       uint64_t CSR_MSGIE;
> +#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
> +    LoongArchTLB tlb[LOONGARCH_TLB_MAX];
> +#endif
It can be deleted in this patch.

>   } CPUSysState;
>   
>   typedef struct CPUArchState {
> @@ -394,7 +413,7 @@ typedef struct CPUArchState {
>       uint32_t pv_features;
>       uint64_t vendor_id;
>       uint64_t cpu_id;
> -    CPUSysState sys_states[1];
> +    CPUSysState sys_states[LOONGARCH_VM_LEVELS];
>   
>       struct {
>           uint64_t guest_addr;
> @@ -419,6 +438,7 @@ typedef struct CPUArchState {
>       uint32_t mp_state;
>   #endif
>       CPUSysState *sys_state;
> +    bool vm_exit;
>   } CPULoongArchState;
>   
>   typedef struct LoongArchCPUTopo {
> @@ -438,8 +458,10 @@ struct ArchCPU {
>   
>       CPULoongArchState env;
>       QEMUTimer timer;
> +    QEMUTimer guest_timer;
>       uint32_t  phy_id;
>       OnOffAuto lbt;
> +    OnOffAuto lvz;
>       OnOffAuto pmu;
>       OnOffAuto ptw;
>       OnOffAuto lsx;
> @@ -484,15 +506,44 @@ struct LoongArchCPUClass {
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
>   static inline CPUSysState *env_sys(CPULoongArchState *env)
>   {
>       return env->sys_state;
>   }
>   
> -static inline void set_sys_state(CPULoongArchState *env, CPUSysState *sys)
> +static inline CPUSysState *get_sys(CPULoongArchState *env, int vm_level)
> +{
> +    return &env->sys_states[vm_level];
> +}
> +
> +static inline void set_sys(CPULoongArchState *env, int vm_level)
>   {
> -    env->sys_state = sys;
> +    env->sys_state = get_sys(env, vm_level);
> +}
> +
> +static inline int env_vm_level(CPULoongArchState *env)
> +{
> +    return env_sys(env) == get_sys(env, LOONGARCH_VM_LEVEL_GUEST) ?
> +           LOONGARCH_VM_LEVEL_GUEST : LOONGARCH_VM_LEVEL_HOST;
>   }
>   
>   static inline bool is_la64(CPULoongArchState *env)
> @@ -530,6 +581,13 @@ static inline void set_pc(CPULoongArchState *env, uint64_t value)
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
There is only function declaration, no function implementation and 
called. I think it can be removed in this patch.

In general it requires that every single patch can pass to compile and work.

Regards
Bibo Mao
>   
>   #define CPU_RESOLVING_TYPE TYPE_LOONGARCH_CPU
>   
> diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
> index 8aa8325dc6..257c3bbddd 100644
> --- a/target/loongarch/translate.h
> +++ b/target/loongarch/translate.h
> @@ -24,6 +24,7 @@
>   #define avail_FP(C)     (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP))
>   #define avail_FP_SP(C)  (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP_SP))
>   #define avail_FP_DP(C)  (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP_DP))
> +#define avail_LVZ(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, LVZ))
>   #define avail_LSPW(C)   (FIELD_EX32((C)->cpucfg2, CPUCFG2, LSPW))
>   #define avail_LAM(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, LAM))
>   #define avail_LAM_BH(C) (FIELD_EX32((C)->cpucfg2, CPUCFG2, LAM_BH))
> @@ -66,6 +67,7 @@ typedef struct DisasContext {
>       TCGv zero;
>       bool la64; /* LoongArch64 mode */
>       bool va32; /* 32-bit virtual address */
> +    bool guest_mode;
>       uint32_t cpucfg1;
>       uint32_t cpucfg2;
>       uint32_t cpucfg3;
> 


