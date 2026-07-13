Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA43C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 09:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjCz6-0006Hd-1X; Mon, 13 Jul 2026 05:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wjCyw-0006HC-Lz
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 05:29:48 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1wjCyr-0001NF-Qf
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 05:29:46 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxZer8r1Rq9f8CAA--.10658S3;
 Mon, 13 Jul 2026 17:29:32 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxPcX5r1RqENQLAA--.55040S2;
 Mon, 13 Jul 2026 17:29:31 +0800 (CST)
Subject: Re: [PATCH v3 8/8] target/loongarch: Translate LVZ instructions
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: xianglai li <lixianglai@loongson.cn>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <cover.1783673526.git.prcups@krgm.moe>
 <afbf6f66a2bc98ad86161094d2700f8aacc60d0b.1783673526.git.prcups@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <3ab972fa-fb21-0b4a-3bdf-ac5b8a7672d3@loongson.cn>
Date: Mon, 13 Jul 2026 17:29:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <afbf6f66a2bc98ad86161094d2700f8aacc60d0b.1783673526.git.prcups@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxPcX5r1RqENQLAA--.55040S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9fXoW3uryxZF4UtFyxWF17Gw15trc_yoW8WF4kKo
 W8Ja15JF4rG390kr9xK39FqFW7XFyUuasxCas8Ww4q9Fs5WryxtF1rGrs5Za1xWry0grW8
 J3WxXFnxKan8Awn3l-sFpf9Il3svdjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf
 9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
 UjIYCTnIWjp_UUUYI7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
 8IcIk0rVWrJVCq3wAFIxvE14AKwVWUGVWUXwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
 Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14
 v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
 wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
 0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280
 aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
 xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
 x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r
 1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
 7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
 W8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
 2ID7UUUUU
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
> Add decode, disassembly and TCG translation for LVZ guest CSR access,
> guest TLB management and hypervisor call instructions, including
> guest-mode CSR trapping, guest read-only checks and translation context
> setup using the LVZ infrastructure added by earlier patches.
> 
> Signed-off-by: SignKirigami <prcups@krgm.moe>
> Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
> ---
>   target/loongarch/disas.c                      |  16 +
>   target/loongarch/insns.decode                 |  14 +
>   .../tcg/insn_trans/trans_privileged.c.inc     | 275 +++++++++++++++++-
>   target/loongarch/tcg/translate.c              |   6 +-
>   4 files changed, 303 insertions(+), 8 deletions(-)
> 
> diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
> index 3249ab7ac6..db0e556adb 100644
> --- a/target/loongarch/disas.c
> +++ b/target/loongarch/disas.c
> @@ -51,6 +51,8 @@ static const char * const csr_names[] = {
>       CSR_NAME(BADI),
>       CSR_NAME(EENTRY),
>       CSR_NAME(TLBIDX),
> +    CSR_NAME(GTLBC),
> +    CSR_NAME(TRGP),
>       CSR_NAME(TLBEHI),
>       CSR_NAME(TLBELO0),
>       CSR_NAME(TLBELO1),
> @@ -87,6 +89,10 @@ static const char * const csr_names[] = {
>       CSR_NAME(TVAL),
>       CSR_NAME(CNTC),
>       CSR_NAME(TICLR),
> +    CSR_NAME(GSTAT),
> +    CSR_NAME(GCFG),
> +    CSR_NAME(GINTC),
> +    CSR_NAME(GCNTC),
>       CSR_NAME(LLBCTL),
>       CSR_NAME(IMPCTL1),
>       CSR_NAME(IMPCTL2),
> @@ -698,6 +704,16 @@ INSN(tlbfill,      empty)
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
> index 3089d42044..b40fabe9d7 100644
> --- a/target/loongarch/insns.decode
> +++ b/target/loongarch/insns.decode
> @@ -493,6 +493,20 @@ bgeu            0110 11 ................ ..... .....     @rr_offs16
>     csrxchg           0000 0100 .............. ..... .....     @rr_csr
>   }
>   
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
> diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> index 48a42779d3..adf088627e 100644
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
Can guest CSRInfo and host CSRInfo be merged into one?

>       if (csr == NULL) {
>           /* CSR is undefined: read as 0. */
>           dest = tcg_constant_tl(0);
>       } else {
>           check_csr_flags(ctx, csr, false);
> +        if (ctx->guest_mode && (csr->flags & CSRFL_GSPR)) {
> +            gen_helper_gspr(tcg_env);
> +            gen_set_gpr(a->rd, tcg_constant_tl(0), EXT_NONE);
why the value of rd is 0 when emulating CSR read in guest mode?

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
> @@ -170,20 +221,136 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
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
> +    src1 = gpr_src(ctx, a->rd, EXT_NONE);
> +    mask = gpr_src(ctx, a->rj, EXT_NONE);
> +    oldv = tcg_temp_new();
> +    newv = tcg_temp_new();
> +    temp = tcg_temp_new();
> +
> +    if (csr->readfn) {
> +        GenCSRRead readfn = (GenCSRRead)csr->readfn;
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
> +static bool trans_gcsrrd(DisasContext *ctx, arg_gcsrrd *a)
> +{
> +    TCGv dest;
> +    const CSRInfo *csr;
> +    GenCSRRead readfn;
> +
> +    if (check_plv(ctx) || !avail_LVZ(ctx)) {
> +        return false;
> +    }

Most of the folloing mode is simiar with trans_csrrd(),
can we modify trans_csrrd() with non-guest mode support, and call 
trans_csrrd() here?

Regards
Bibo Mao
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
> +    if (check_plv(ctx) || !avail_LVZ(ctx)) {
> +        return false;
> +    }
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
> +    if (check_plv(ctx) || !avail_LVZ(ctx)) {
> +        return false;
> +    }
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
>   
>       src1 = gpr_src(ctx, a->rd, EXT_NONE);
>       mask = gpr_src(ctx, a->rj, EXT_NONE);
> @@ -191,7 +358,12 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
>       newv = tcg_temp_new();
>       temp = tcg_temp_new();
>   
> -    tcg_gen_ld_tl(oldv, tcg_env, csr->offset);
> +    readfn = (GenCSRRead)csr->readfn;
> +    if (readfn) {
> +        readfn(oldv, tcg_env);
> +    } else {
> +        tcg_gen_ld_tl(oldv, tcg_env, csr->offset);
> +    }
>       tcg_gen_and_tl(newv, src1, mask);
>       tcg_gen_andc_tl(temp, oldv, mask);
>       tcg_gen_or_tl(newv, newv, temp);
> @@ -212,6 +384,11 @@ static bool gen_iocsrrd(DisasContext *ctx, arg_rr *a,
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
> @@ -225,6 +402,11 @@ static bool gen_iocsrwr(DisasContext *ctx, arg_rr *a,
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
> @@ -243,7 +425,7 @@ TRANS64(iocsrwr_d, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_d)
>   
>   static void check_mmu_idx(DisasContext *ctx)
>   {
> -    if (ctx->mem_idx != MMU_DA_IDX) {
> +    if (ctx->mem_idx != MMU_DA_IDX && ctx->mem_idx != MMU_GUEST_DA_IDX) {
>           tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next + 4);
>           ctx->base.is_jmp = DISAS_EXIT;
>       }
> @@ -267,6 +449,24 @@ static bool trans_tlbrd(DisasContext *ctx, arg_tlbrd *a)
>       return true;
>   }
>   
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
>   static bool trans_tlbwr(DisasContext *ctx, arg_tlbwr *a)
>   {
>       if (check_plv(ctx)) {
> @@ -277,6 +477,16 @@ static bool trans_tlbwr(DisasContext *ctx, arg_tlbwr *a)
>       return true;
>   }
>   
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
>   static bool trans_tlbfill(DisasContext *ctx, arg_tlbfill *a)
>   {
>       if (check_plv(ctx)) {
> @@ -287,6 +497,16 @@ static bool trans_tlbfill(DisasContext *ctx, arg_tlbfill *a)
>       return true;
>   }
>   
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
>   static bool trans_tlbclr(DisasContext *ctx, arg_tlbclr *a)
>   {
>       if (check_plv(ctx)) {
> @@ -297,6 +517,16 @@ static bool trans_tlbclr(DisasContext *ctx, arg_tlbclr *a)
>       return true;
>   }
>   
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
>   static bool trans_tlbflush(DisasContext *ctx, arg_tlbflush *a)
>   {
>       if (check_plv(ctx)) {
> @@ -307,6 +537,16 @@ static bool trans_tlbflush(DisasContext *ctx, arg_tlbflush *a)
>       return true;
>   }
>   
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
>   static bool trans_invtlb(DisasContext *ctx, arg_invtlb *a)
>   {
>       TCGv rj = gpr_src(ctx, a->rj, EXT_NONE);
> @@ -438,6 +678,10 @@ static bool trans_dbcl(DisasContext *ctx, arg_dbcl *a)
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
> @@ -448,9 +692,26 @@ static bool trans_idle(DisasContext *ctx, arg_idle *a)
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
> +static bool trans_hvcl(DisasContext *ctx, arg_hvcl *a)
> +{
> +    if (!avail_LVZ(ctx) || !ctx->guest_mode) {
> +        return false;
> +    }
> +
> +    tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
> +    gen_helper_hvcl(tcg_env, tcg_constant_i32(a->imm));
> +    ctx->base.is_jmp = DISAS_NORETURN;
> +    return true;
> +}
>   #endif
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
> 


