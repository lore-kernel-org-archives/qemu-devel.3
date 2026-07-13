Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A4E3C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 06:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjAVH-0005gk-IA; Mon, 13 Jul 2026 02:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wjAVE-0005gV-Ns
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 02:50:56 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wjAVB-00040D-9d
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 02:50:56 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxVerGilRqYPICAA--.10504S3;
 Mon, 13 Jul 2026 14:50:46 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxDcfDilRq77ALAA--.54623S2;
 Mon, 13 Jul 2026 14:50:45 +0800 (CST)
Subject: Re: [PATCH v3 4/8] target/loongarch: Add LVZ guest CSR tables
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: xianglai li <lixianglai@loongson.cn>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <cover.1783673526.git.prcups@krgm.moe>
 <0bcc5d30b6495f266413e773a4c1bbe203ac0b68.1783673526.git.prcups@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <77945892-2f6d-51ac-dde0-7083cb41afe3@loongson.cn>
Date: Mon, 13 Jul 2026 14:50:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0bcc5d30b6495f266413e773a4c1bbe203ac0b68.1783673526.git.prcups@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxDcfDilRq77ALAA--.54623S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3uw43JF4DWr1fWr17Aw1fAFc_yoWDtF1rpr
 srWFWUKFW5tas5X3ykG3WYk3W5Xr1xK3y2qasIyry8CFW8Jr1FgFWFkF1Ygr15JF1rZrW0
 vFWkAr18ZF42gFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcVc_
 UUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.494,
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



On 2026/7/10 下午5:00, SignKirigami wrote:
> Add the guest CSR lookup table and get_gcsr() helper, mark guest
> read-only registers and guest sensitive privileged resources, and store
> host and guest CSRInfo offsets relative to CPULoongArchState so CSR
> access generation can select the host or guest table directly.
> 
> Signed-off-by: SignKirigami <prcups@krgm.moe>
> Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
> ---
>   target/loongarch/cpu.c                        |   2 +-
>   target/loongarch/csr.c                        | 124 +++++++++++++++++-
>   target/loongarch/csr.h                        |  12 +-
>   .../tcg/insn_trans/trans_extra.c.inc          |   2 +-
>   .../tcg/insn_trans/trans_privileged.c.inc     |  16 +--
>   5 files changed, 133 insertions(+), 23 deletions(-)
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index fb03424ffa..492b17e136 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -783,7 +783,7 @@ static void loongarch_cpu_dump_csr(CPUState *cs, FILE *f)
>               qemu_fprintf(f, " CSR%03d:", col);
>           }
>   
> -        addr = (void *)env + get_csr_offset(csr_info, 0);
> +        addr = (void *)env + csr_info->offset;
>           qemu_fprintf(f, " %s ", csr_info->name);
>           len = strlen(csr_info->name);
>           for (; len < 6; len++) {
> diff --git a/target/loongarch/csr.c b/target/loongarch/csr.c
> index 309b826ca9..ed9d25edf2 100644
> --- a/target/loongarch/csr.c
> +++ b/target/loongarch/csr.c
> @@ -9,19 +9,34 @@
>   #define CSR_OFF_FUNCS(NAME, FL, RD, WR)                    \
>       [LOONGARCH_CSR_##NAME] = {                             \
>           .name   = (stringify(NAME)),                       \
> -        .offset = CSR_OFFSET(CSR_##NAME),                  \
> +        .offset = CSR_OFFSET(CSR_##NAME, 0),               \
>           .flags = FL, .readfn = RD, .writefn = WR           \
>       }
>   
>   #define CSR_OFF_ARRAY(NAME, N)                                \
>       [LOONGARCH_CSR_##NAME(N)] = {                             \
>           .name   = (stringify(NAME##N)),                       \
> -        .offset = CSR_OFFSET(CSR_##NAME[N]),                  \
> -        .flags = CSRFL_BASIC, .readfn = NULL, .writefn = NULL           \
> +        .offset = CSR_OFFSET(CSR_##NAME[N], 0),               \
> +        .flags = CSRFL_BASIC, .readfn = NULL, .writefn = NULL \
>       }
>   
>   #define CSR_OFF_FLAGS(NAME, FL)   CSR_OFF_FUNCS(NAME, FL, NULL, NULL)
>   #define CSR_OFF(NAME)             CSR_OFF_FLAGS(NAME, CSRFL_BASIC)
> +#define GCSR_OFF_FUNCS(NAME, FL, RD, WR)                  \
> +    [LOONGARCH_CSR_##NAME] = {                            \
> +        .name   = (stringify(GCSR_##NAME)),               \
> +        .offset = CSR_OFFSET(CSR_##NAME, 1),              \
> +        .flags = FL, .readfn = RD, .writefn = WR          \
> +    }
> +#define GCSR_OFF_ARRAY(NAME, N)                               \
> +    [LOONGARCH_CSR_##NAME(N)] = {                             \
> +        .name   = (stringify(GCSR_##NAME##N)),                \
> +        .offset = CSR_OFFSET(CSR_##NAME[N], 1),               \
> +        .flags = CSRFL_BASIC, .readfn = NULL, .writefn = NULL \
> +    }
> +#define GCSR_OFF_FLAGS(NAME, FL) GCSR_OFF_FUNCS(NAME, FL, NULL, NULL)
> +#define GCSR_OFF(NAME) GCSR_OFF_FLAGS(NAME, CSRFL_BASIC)
> +#define GCSR_GSPR(NAME) GCSR_OFF_FLAGS(NAME, CSRFL_GSPR)
>   
>   static CSRInfo csr_info[] = {
>       CSR_OFF_FLAGS(CRMD, CSRFL_EXITTB),
> @@ -35,6 +50,8 @@ static CSRInfo csr_info[] = {
>       CSR_OFF_FLAGS(BADI, CSRFL_READONLY),
>       CSR_OFF(EENTRY),
>       CSR_OFF(TLBIDX),
> +    CSR_OFF(GTLBC),
> +    CSR_OFF(TRGP),
>       CSR_OFF(TLBEHI),
>       CSR_OFF(TLBELO0),
>       CSR_OFF(TLBELO1),
> @@ -71,6 +88,10 @@ static CSRInfo csr_info[] = {
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
> @@ -135,6 +156,87 @@ static CSRInfo csr_info[] = {
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
> @@ -151,6 +253,22 @@ CSRInfo *get_csr(unsigned int csr_num)
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
> +    if (csr->flags == 0) {
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
> index c2b6b882bc..c39230f30c 100644
> --- a/target/loongarch/csr.h
> +++ b/target/loongarch/csr.h
> @@ -8,10 +8,9 @@
>   
>   #include "cpu-csr.h"
>   
> -#define CSR_OFFSET(id)                  offsetof(CPUSysState, id)
> -#define CPU_CSR_OFFSET(id, vm_level)                                     \
> +#define CSR_OFFSET(id, vm_level)                                     \
>                       (offsetof(CPULoongArchState, sys_states[vm_level])   \
> -                             + CSR_OFFSET(id))
> +                    + offsetof(CPUSysState, id))
>   
>   typedef void (*GenCSRFunc)(void);
>   enum {
> @@ -20,6 +19,8 @@ enum {
>       CSRFL_IO       = (1 << 2),
>       CSRFL_UNUSED   = (1 << 3),
>       CSRFL_BASIC    = (1 << 4),
> +    CSRFL_GUEST_READONLY = (1 << 5),
> +    CSRFL_GSPR     = (1 << 6),
>   };
>   
>   typedef struct {
> @@ -31,9 +32,6 @@ typedef struct {
>   } CSRInfo;
>   
>   CSRInfo *get_csr(unsigned int csr_num);
> +CSRInfo *get_gcsr(unsigned int csr_num);
>   bool set_csr_flag(unsigned int csr_num, int flag);
> -static inline unsigned int get_csr_offset(const CSRInfo *csr, int vm_level)
> -{
> -    return csr->offset + offsetof(CPULoongArchState, sys_states[vm_level]);
> -}
>   #endif /* TARGET_LOONGARCH_CSR_H */
> diff --git a/target/loongarch/tcg/insn_trans/trans_extra.c.inc b/target/loongarch/tcg/insn_trans/trans_extra.c.inc
> index 655dce329e..5a404632f5 100644
> --- a/target/loongarch/tcg/insn_trans/trans_extra.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_extra.c.inc
> @@ -55,7 +55,7 @@ static bool gen_rdtime(DisasContext *ctx, arg_rr *a,
>           tcg_gen_sextract_tl(dst1, dst1, high ? 32 : 0, 32);
>       }
>   
> -    offset = CPU_CSR_OFFSET(CSR_TID, 0);
> +    offset = CSR_OFFSET(CSR_TID, 0);
>       tcg_gen_ld_i64(dst2, tcg_env, offset);
>   
>       return true;
> diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> index 6728ce5ec9..2094d182ac 100644
> --- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> @@ -106,7 +106,6 @@ static bool trans_csrrd(DisasContext *ctx, arg_csrrd *a)
>       TCGv dest;
>       const CSRInfo *csr;
>       GenCSRRead readfn;
> -    tcg_target_long offset;
>   
>       if (check_plv(ctx)) {
>           return false;
> @@ -122,8 +121,7 @@ static bool trans_csrrd(DisasContext *ctx, arg_csrrd *a)
>           if (readfn) {
>               readfn(dest, tcg_env);
>           } else {
> -            offset = get_csr_offset(csr, 0);
> -            tcg_gen_ld_tl(dest, tcg_env, offset);
> +            tcg_gen_ld_tl(dest, tcg_env, csr->offset);
>           }
how about something like this:
     offset = get_csr_offset(csr, ctx->guest_mode == true);

>       }
>       gen_set_gpr(a->rd, dest, EXT_NONE);
> @@ -135,7 +133,6 @@ static bool trans_csrwr(DisasContext *ctx, arg_csrwr *a)
>       TCGv dest, src1;
>       const CSRInfo *csr;
>       GenCSRWrite writefn;
> -    tcg_target_long offset;
>   
>       if (check_plv(ctx)) {
>           return false;
> @@ -157,9 +154,8 @@ static bool trans_csrwr(DisasContext *ctx, arg_csrwr *a)
>           writefn(dest, tcg_env, src1);
>       } else {
>           dest = tcg_temp_new();
> -        offset = get_csr_offset(csr, 0);
> -        tcg_gen_ld_tl(dest, tcg_env, offset);
> -        tcg_gen_st_tl(src1, tcg_env, offset);
> +        tcg_gen_ld_tl(dest, tcg_env, csr->offset);
> +        tcg_gen_st_tl(src1, tcg_env, csr->offset);
Ditto, offset = get_csr_offset(csr, ctx->guest_mode == true);
>       }
>       gen_set_gpr(a->rd, dest, EXT_NONE);
>       return true;
> @@ -170,7 +166,6 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
>       TCGv src1, mask, oldv, newv, temp;
>       const CSRInfo *csr;
>       GenCSRWrite writefn;
> -    tcg_target_long offset;
>   
>       if (check_plv(ctx)) {
>           return false;
> @@ -196,8 +191,7 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
>       newv = tcg_temp_new();
>       temp = tcg_temp_new();
>   
> -    offset = get_csr_offset(csr, 0);
Ditto, offset = get_csr_offset(csr, ctx->guest_mode == true);

Regards
Bibo Mao
> -    tcg_gen_ld_tl(oldv, tcg_env, offset);
> +    tcg_gen_ld_tl(oldv, tcg_env, csr->offset);
>       tcg_gen_and_tl(newv, src1, mask);
>       tcg_gen_andc_tl(temp, oldv, mask);
>       tcg_gen_or_tl(newv, newv, temp);
> @@ -206,7 +200,7 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
>       if (writefn) {
>           writefn(oldv, tcg_env, newv);
>       } else {
> -        tcg_gen_st_tl(newv, tcg_env, offset);
> +        tcg_gen_st_tl(newv, tcg_env, csr->offset);
>       }
>       gen_set_gpr(a->rd, oldv, EXT_NONE);
>       return true;
> 


