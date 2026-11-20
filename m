Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2DB606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 03:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUF1a-0003bA-Rh; Thu, 19 Nov 2026 22:10:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xUF1Y-0003b1-Dq
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 22:10:52 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xUF1V-0008Fs-Fe
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 22:10:52 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxytE3uv9qEWghAA--.29807S3;
 Fri, 20 Nov 2026 11:10:47 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJDxRs02uv9qhxI2AA--.29499S2;
 Fri, 20 Nov 2026 11:10:46 +0800 (CST)
Subject: Re: [PATCH v2 14/16] target/loongarch: Add generic csrwr helper
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
References: <20261120012356.2656317-1-maobibo@loongson.cn>
 <20261120012356.2656317-15-maobibo@loongson.cn>
Message-ID: <3784e845-c378-d320-a8b3-0976e2b8e574@loongson.cn>
Date: Fri, 20 Nov 2026 11:12:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261120012356.2656317-15-maobibo@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxRs02uv9qhxI2AA--.29499S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Gr43GF4rArWUuFy8Cry8Zwc_yoW7CF1Dpr
 WIkr17uFW8t392v3WSg3WYkr15Aw4fKa18Ww4xt3s2ka13Wr4kXrWjy34a9F4kJ3y5WryF
 y3WFyrn7ZrW5XacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
 0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1Li
 SJUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.724,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 2026/11/20 上午9:23, Bibo Mao wrote:
> Here add generic csrwr helper. With default path, it checks the wrmask
> of specific CSR register and keep read-only bits unchanged.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/tcg/csr_helper.c             | 43 +++++++++++++++++++
>   target/loongarch/tcg/helper.h                 |  1 +
>   .../tcg/insn_trans/trans_privileged.c.inc     | 24 ++++++-----
>   3 files changed, 58 insertions(+), 10 deletions(-)
> 
> diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
> index 07b4b25fbd..4ea4b9b0f8 100644
> --- a/target/loongarch/tcg/csr_helper.c
> +++ b/target/loongarch/tcg/csr_helper.c
> @@ -17,6 +17,7 @@
>   #include "hw/core/irq.h"
>   #include "cpu-csr.h"
>   #include "cpu-mmu.h"
> +#include "csr.h"
>   
>   target_ulong HELPER(csrwr_stlbps)(CPULoongArchState *env, target_ulong val)
>   {
> @@ -185,3 +186,45 @@ target_ulong HELPER(csrwr_pwch)(CPULoongArchState *env, target_ulong val)
>       sys->CSR_PWCH = val;
>       return old_v;
>    }
> +
> +target_ulong HELPER(csrwr)(CPULoongArchState *env, target_ulong val,
> +                           uint32_t csr)
> +{
> +    const CSRInfo *csrinfo;
> +    int64_t *pcsr, offset, old_v = 0;
> +
> +    switch (csr) {
> +    case LOONGARCH_CSR_STLBPS:
> +        return HELPER(csrwr_stlbps)(env, val);
> +
> +    case LOONGARCH_CSR_ESTAT:
> +        return HELPER(csrwr_estat)(env, val);
> +
> +    case LOONGARCH_CSR_ASID:
> +        return HELPER(csrwr_asid)(env, val);
> +
> +    case LOONGARCH_CSR_TCFG:
> +        return HELPER(csrwr_tcfg)(env, val);
> +
> +    case LOONGARCH_CSR_TICLR:
> +        return HELPER(csrwr_ticlr)(env, val);
> +
> +    case LOONGARCH_CSR_PWCL:
> +        return HELPER(csrwr_pwcl)(env, val);
> +
> +    case LOONGARCH_CSR_PWCH:
> +        return HELPER(csrwr_pwch)(env, val);
> +
> +    default:
> +        csrinfo = get_csr(csr);
> +        if (!csrinfo) {
> +            return old_v;
> +       }
there seems be one space missing.

> +
> +        offset = get_csr_offset(csrinfo, 0);
> +        pcsr = (int64_t *)((void*)env + offset);
> +        old_v = *pcsr;
> +        *pcsr = val & csrinfo->wrmask;
> +        return old_v;
> +    }
> +}
> diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
> index 60ebf35d1f..719fa8b86a 100644
> --- a/target/loongarch/tcg/helper.h
> +++ b/target/loongarch/tcg/helper.h
> @@ -105,6 +105,7 @@ DEF_HELPER_2(csrwr_tcfg, i64, env, tl)
>   DEF_HELPER_2(csrwr_ticlr, i64, env, tl)
>   DEF_HELPER_2(csrwr_pwcl, i64, env, tl)
>   DEF_HELPER_2(csrwr_pwch, i64, env, tl)
> +DEF_HELPER_3(csrwr, i64, env, tl, i32)
>   DEF_HELPER_2(iocsrrd_b, i64, env, tl)
>   DEF_HELPER_2(iocsrrd_h, i64, env, tl)
>   DEF_HELPER_2(iocsrrd_w, i64, env, tl)
> diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> index 0a67fe146d..025b2f2542 100644
> --- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> @@ -43,7 +43,7 @@ GEN_FALSE_TRANS(idle)
>   #else
>   
>   typedef void (*GenCSRRead)(TCGv dest, TCGv_ptr env);
> -typedef void (*GenCSRWrite)(TCGv dest, TCGv_ptr env, TCGv src);
> +typedef void (*GenCSRWrite)(TCGv dest, TCGv_ptr env, TCGv src, TCGv_i32 csr);
>   
>   static bool check_plv(DisasContext *ctx)
>   {
> @@ -110,15 +110,15 @@ static void init_csr_wrmask(void)
>   
>   void loongarch_csr_translate_init(void)
>   {
> -    SET_CSR_FUNC(STLBPS, NULL, gen_helper_csrwr_stlbps);
> -    SET_CSR_FUNC(ESTAT, NULL, gen_helper_csrwr_estat);
> -    SET_CSR_FUNC(ASID,  NULL, gen_helper_csrwr_asid);
> +    SET_CSR_FUNC(STLBPS, NULL, gen_helper_csrwr);
> +    SET_CSR_FUNC(ESTAT, NULL, gen_helper_csrwr);
> +    SET_CSR_FUNC(ASID,  NULL, gen_helper_csrwr);
>       SET_CSR_FUNC(PGD,   gen_helper_csrrd_pgd, NULL);
> -    SET_CSR_FUNC(PWCL,  NULL, gen_helper_csrwr_pwcl);
> -    SET_CSR_FUNC(PWCH,  NULL, gen_helper_csrwr_pwch);
> -    SET_CSR_FUNC(TCFG,  NULL, gen_helper_csrwr_tcfg);
> +    SET_CSR_FUNC(PWCL,  NULL, gen_helper_csrwr);
> +    SET_CSR_FUNC(PWCH,  NULL, gen_helper_csrwr);
> +    SET_CSR_FUNC(TCFG,  NULL, gen_helper_csrwr);
>       SET_CSR_FUNC(TVAL,  gen_helper_csrrd_tval, NULL);
> -    SET_CSR_FUNC(TICLR, NULL, gen_helper_csrwr_ticlr);
> +    SET_CSR_FUNC(TICLR, NULL, gen_helper_csrwr);
>       SET_CSR_FUNC(MSGIR, gen_helper_csrrd_msgir, NULL);
>       init_csr_wrmask();
>   }
> @@ -177,6 +177,7 @@ static bool trans_csrwr(DisasContext *ctx, arg_csrwr *a)
>       GenCSRWrite writefn;
>       tcg_target_long offset;
>       bool rdonly;
> +    TCGv_i32 csrid;
>   
>       if (check_plv(ctx)) {
>           return false;
> @@ -197,7 +198,8 @@ static bool trans_csrwr(DisasContext *ctx, arg_csrwr *a)
>       writefn = (GenCSRWrite)csr->writefn;
>       if (writefn) {
>           dest = gpr_dst(ctx, a->rd, EXT_NONE);
> -        writefn(dest, tcg_env, src1);
> +        csrid = tcg_constant_i32(a->csr);
> +        writefn(dest, tcg_env, src1, csrid);
>       } else {
>           dest = tcg_temp_new();
>           offset = get_csr_offset(csr, 0);
> @@ -222,6 +224,7 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
>       GenCSRWrite writefn;
>       tcg_target_long offset;
>       bool rdonly;
> +    TCGv_i32 csrid;
>   
>       if (check_plv(ctx)) {
>           return false;
> @@ -259,7 +262,8 @@ static bool trans_csrxchg(DisasContext *ctx, arg_csrxchg *a)
>   
>       writefn = (GenCSRWrite)csr->writefn;
>       if (writefn) {
> -        writefn(oldv, tcg_env, newv);
> +        csrid = tcg_constant_i32(a->csr);
> +        writefn(oldv, tcg_env, newv, csrid);
>       } else {
>           tcg_gen_st_tl(newv, tcg_env, offset);
>       }
> 


