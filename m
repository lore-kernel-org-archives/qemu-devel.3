Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65587D58B07
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 12:23:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w26yb-00054h-HN; Mon, 16 Mar 2026 08:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1w26yZ-00053u-2p; Mon, 16 Mar 2026 08:23:15 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1w26yX-0005hV-Eb; Mon, 16 Mar 2026 08:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=aYHOxNnA/zcD7U/idJWiUoqpEOacYa1baa72Lj+g7Ys=; b=DTGPIrUM/L95TDc
 WCVT2p0EDRdLZqXrKFNoGNGYZmn/7aXekkeJWuWFsurmjnUqN47z+holWoYn0olvDZ3IQyb4hEhPi
 2Be7VVqV0GzfwhEtTEzcho7EmX/YZZJfJ2dTHkUtJyrYXHeWd/uWfP5WF15lnt39P44OOwHL8rnCi
 IY=;
Date: Mon, 16 Mar 2026 13:27:01 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, 
 Glenn Miles <milesg@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 3/3] target/ppc: Explicitly declare BHRB related register
 as 64-bit
Message-ID: <abf2K4rNDUfwOeXf@hive.localdomain>
References: <20260315170832.40331-1-philmd@linaro.org>
 <20260315170832.40331-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260315170832.40331-4-philmd@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 15/03/26, Philippe Mathieu-Daudé wrote:
> When TARGET_PPC64 is set, the 'target_ulong' type expand to
> the 'uint64_t' one. Use the latter which is more explicity,
> similarly with the TCG and migration APIs. No logical change
> intended.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/ppc/cpu.h       | 10 +++++-----
>  target/ppc/machine.c   |  2 +-
>  target/ppc/translate.c | 33 +++++++++++++++++----------------
>  3 files changed, 23 insertions(+), 22 deletions(-)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index f4438982928..2332c509524 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1373,11 +1373,11 @@ struct CPUArchState {
>  
>  #ifdef TARGET_PPC64
>      /* Branch History Rolling Buffer (BHRB) resources */
> -    target_ulong bhrb_num_entries;
> -    intptr_t     bhrb_base;
> -    target_ulong bhrb_filter;
> -    target_ulong bhrb_offset;
> -    target_ulong bhrb_offset_mask;
> +    uint64_t bhrb_num_entries;
> +    intptr_t bhrb_base;
> +    uint64_t bhrb_filter;
> +    uint64_t bhrb_offset;
> +    uint64_t bhrb_offset_mask;
>      uint64_t bhrb[BHRB_MAX_NUM_ENTRIES];
>  #endif
>  
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index b44c3ccf0ae..65594f5e1a6 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -723,7 +723,7 @@ static const VMStateDescription vmstate_bhrb = {
>      .minimum_version_id = 1,
>      .needed = bhrb_needed,
>      .fields = (VMStateField[]) {
> -        VMSTATE_UINTTL(env.bhrb_offset, PowerPCCPU),
> +        VMSTATE_UINT64(env.bhrb_offset, PowerPCCPU),
>          VMSTATE_UINT64_ARRAY(env.bhrb, PowerPCCPU, BHRB_MAX_NUM_ENTRIES),
>          VMSTATE_END_OF_LIST()
>      }
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index ecf75c1376e..996e6551436 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -3502,7 +3502,8 @@ static void gen_rvwinkle(DisasContext *ctx)
>  #endif /* defined(CONFIG_USER_ONLY) */
>  }
>  
> -static inline TCGv gen_write_bhrb(TCGv_ptr base, TCGv offset, TCGv mask, TCGv value)
> +static TCGv gen_write_bhrb(TCGv_ptr base, TCGv_i64 offset,
> +                           TCGv_i64 mask, TCGv_i64 value)
>  {
>      TCGv_ptr tmp = tcg_temp_new_ptr();
>  
> @@ -3513,10 +3514,10 @@ static inline TCGv gen_write_bhrb(TCGv_ptr base, TCGv offset, TCGv mask, TCGv va
>      tcg_gen_st_i64(value, tmp, 0);
>  
>      /* add 8 to current bhrb_offset */
> -    tcg_gen_addi_tl(offset, offset, 8);
> +    tcg_gen_addi_i64(offset, offset, 8);
>  
>      /* apply offset mask */
> -    tcg_gen_and_tl(offset, offset, mask);
> +    tcg_gen_and_i64(offset, offset, mask);
>  
>      return offset;
>  }
> @@ -3529,13 +3530,13 @@ static inline void gen_update_branch_history(DisasContext *ctx,
>  {
>  #if defined(TARGET_PPC64)
>      TCGv_ptr base;
> -    TCGv tmp;
> -    TCGv offset;
> -    TCGv mask;
> +    TCGv_i64 tmp;
> +    TCGv_i64 offset;
> +    TCGv_i64 mask;
>      TCGLabel *no_update;
>  
>      if (ctx->has_cfar) {
> -        tcg_gen_movi_tl(cpu_cfar, nip);
> +        tcg_gen_movi_i64(cpu_cfar, nip);
>      }

Move to cpu_cfar patch!:)


>  
>      if (!ctx->has_bhrb ||
> @@ -3548,22 +3549,22 @@ static inline void gen_update_branch_history(DisasContext *ctx,
>      no_update = gen_new_label();
>  
>      /* check for bhrb filtering */
> -    tcg_gen_ld_tl(tmp, tcg_env, offsetof(CPUPPCState, bhrb_filter));
> -    tcg_gen_andi_tl(tmp, tmp, inst_type);
> -    tcg_gen_brcondi_tl(TCG_COND_EQ, tmp, 0, no_update);
> +    tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPUPPCState, bhrb_filter));
> +    tcg_gen_andi_i64(tmp, tmp, inst_type);
> +    tcg_gen_brcondi_i64(TCG_COND_EQ, tmp, 0, no_update);
>  
>      base = tcg_temp_new_ptr();
> -    offset = tcg_temp_new();
> -    mask = tcg_temp_new();
> +    offset = tcg_temp_new_i64();
> +    mask = tcg_temp_new_i64();
>  
>      /* load bhrb base address */
>      tcg_gen_ld_ptr(base, tcg_env, offsetof(CPUPPCState, bhrb_base));
>  
>      /* load current bhrb_offset */
> -    tcg_gen_ld_tl(offset, tcg_env, offsetof(CPUPPCState, bhrb_offset));
> +    tcg_gen_ld_i64(offset, tcg_env, offsetof(CPUPPCState, bhrb_offset));
>  
>      /* load a BHRB offset mask */
> -    tcg_gen_ld_tl(mask, tcg_env, offsetof(CPUPPCState, bhrb_offset_mask));
> +    tcg_gen_ld_i64(mask, tcg_env, offsetof(CPUPPCState, bhrb_offset_mask));
>  
>      offset = gen_write_bhrb(base, offset, mask, tcg_constant_i64(nip));
>  
> @@ -3571,13 +3572,13 @@ static inline void gen_update_branch_history(DisasContext *ctx,
>      if (inst_type & BHRB_TYPE_XL_FORM) {
>  
>          /* Set the 'T' bit for target entries */
> -        tcg_gen_ori_tl(tmp, target, 0x2);
> +        tcg_gen_ori_i64(tmp, target, 0x2);
>  
>          offset = gen_write_bhrb(base, offset, mask, tmp);
>      }
>  
>      /* save updated bhrb_offset for next time */
> -    tcg_gen_st_tl(offset, tcg_env, offsetof(CPUPPCState, bhrb_offset));
> +    tcg_gen_st_i64(offset, tcg_env, offsetof(CPUPPCState, bhrb_offset));
>  
>      gen_set_label(no_update);
>  #endif
> -- 
> 2.53.0
> 
> 

Otherwise,

Reviewed-by: Anton Johansson <anjo@rev.ng>

