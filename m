Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB4FCD5BAB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 02:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQFob-0006GP-J3; Thu, 21 May 2026 22:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wQFoS-0006EU-J6
 for qemu-devel@nongnu.org; Thu, 21 May 2026 22:40:41 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wQFoL-00057R-Se
 for qemu-devel@nongnu.org; Thu, 21 May 2026 22:40:35 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxhngXwg9qjz8MAA--.10942S3;
 Fri, 22 May 2026 10:40:23 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJCx98AOwg9q2jKMAA--.55253S3;
 Fri, 22 May 2026 10:40:14 +0800 (CST)
Subject: Re: [PATCH 1/4] target/loongarch: add LVZ CPU state and CSR metadata
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <cover.1779171125.git.prcups@krgm.moe>
 <94fb3d6942546c67f0126d08a56797406c65fde1.1779171125.git.prcups@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <21d4ba10-8b2a-bb8c-455d-f379ffd13259@loongson.cn>
Date: Fri, 22 May 2026 10:37:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <94fb3d6942546c67f0126d08a56797406c65fde1.1779171125.git.prcups@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCx98AOwg9q2jKMAA--.55253S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9fXoWfury8GFy8trWxZw1kCrWfJFc_yoW5GFW3Xo
 W5ZrWayw4fA3WfCF97Grs0qFZ2vr4xArZ8uFs7Xa15Ka13Kr48K3yrXay8trW8Wryjqw1r
 GF18t3sYyrn2y3W5l-sFpf9Il3svdjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf
 9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
 UjIYCTnIWjp_UUUY27kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
 8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
 Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14
 v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j0FALU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.97,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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



On 2026/5/19 下午2:30, SignKirigami wrote:
> Signed-off-by: SignKirigami <prcups@krgm.moe>
> Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
> ---
>   target/loongarch/cpu-csr.h |  42 +++++++
>   target/loongarch/cpu.h     | 125 ++++++++++++++++++-
>   target/loongarch/csr.c     | 122 ++++++++++++++++++
>   target/loongarch/csr.h     |   3 +
>   target/loongarch/machine.c | 249 +++++++++++++++++++++++++------------
>   5 files changed, 457 insertions(+), 84 deletions(-)
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
I am new with LVZ code, some comments may be wrong. If you have any 
suggestion, do not hesitate to raise.

Is it ok to define one structure special for CSR register, such as
typedef struct CPUCsrState {
     uint64_t CSR_CRMD;
     uint64_t CSR_PRMD;
     ...
};

typedef struct CPUArchState {
     struct CPUCsrState csrState[N_VM_LEVEL];
     struct CPUCsrState *curCsrState;
}

The same for tlb and timer since VMs with LVZ enabled has separate 
tlb/timer. About TLB, I do not which is simpler compared with shared 
TLB? It is not so important, the easier way be better for the present.
> +
> +    bool guest;
Can the data type changed with uint8_t or uint16_t? also named is 
changed with vm_level for example, so that nested LVZ can be easily 
added in later.


Regards
Bibo Mao
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
> 


