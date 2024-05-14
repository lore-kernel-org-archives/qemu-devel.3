Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E080C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 14:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6tHm-0002BJ-EF; Tue, 14 May 2024 10:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6tHk-0002Af-Si
 for qemu-devel@nongnu.org; Tue, 14 May 2024 10:37:44 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6tHi-0004LM-Gm
 for qemu-devel@nongnu.org; Tue, 14 May 2024 10:37:44 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id A9D85CE1290;
 Tue, 14 May 2024 14:37:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E27C2BD10;
 Tue, 14 May 2024 14:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715697457;
 bh=c6zbKcY/u+6k3QMYIqGcmKD3nAqzK5fhpkExxkvu6Zg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BAvuGuVXoV84AnYc2LH2PoRkC2rxPijZ/of9QC11NbgBE/i9+6I1d44IBGihdqwhZ
 nHuPKeBFDNMA9p0kUlZYgFSlmBhk44DaREmqhqaI3yfWRhQ4jQ7o4dXAbEQM8Zy9v5
 Ze980wcqP5YcxehYY/emEL/nofD3fmrte7AN9Z5oW0QVWk8kcvP0nAQO+DJBF9vuol
 fI1xKrulZdghmmVJbcXqmZke0e8gkDppdySIFIaGa6ddTB85ZDP0+uFPMG8Y5Ty23h
 s0UHASklfjxz9Lrf/xeFm0/GRaENhKwpTO4i9DYYlcCIWX5/hEfq654HsuuRnwD9eu
 XWiVG4TNc7zvQ==
Date: Tue, 14 May 2024 16:37:32 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH v2 08/45] target/hppa: Add install_link
Message-ID: <ZkN3LM1pWLfzVowQ@carbonx1>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-9-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513074717.130949-9-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=deller@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

* Richard Henderson <richard.henderson@linaro.org>:
> Add a common routine for writing the return address.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

> ---
>  target/hppa/translate.c | 54 +++++++++++++++++++++++------------------
>  1 file changed, 31 insertions(+), 23 deletions(-)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 08d5e2a4bc..f816b337ee 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -634,6 +634,23 @@ static void install_iaq_entries(DisasContext *ctx, uint64_t bi, TCGv_i64 bv,
>      }
>  }
>  
> +static void install_link(DisasContext *ctx, unsigned link, bool with_sr0)
> +{
> +    tcg_debug_assert(ctx->null_cond.c == TCG_COND_NEVER);
> +    if (link) {

Just wondering:
Doesn't it makes it easier to write here:
	if (!link) {
		return;
	}
and then don't indent the few following lines?

> +        if (ctx->iaoq_b == -1) {
> +            tcg_gen_addi_i64(cpu_gr[link], cpu_iaoq_b, 4);
> +        } else {
> +            tcg_gen_movi_i64(cpu_gr[link], ctx->iaoq_b + 4);
> +        }
> +#ifndef CONFIG_USER_ONLY
> +        if (with_sr0) {
> +            tcg_gen_mov_i64(cpu_sr[0], cpu_iasq_b);
> +        }
> +#endif
> +    }
> +}
> +
>  static inline uint64_t iaoq_dest(DisasContext *ctx, int64_t disp)
>  {
>      return ctx->iaoq_f + disp + 8;
> @@ -1787,9 +1804,7 @@ static bool do_dbranch(DisasContext *ctx, int64_t disp,
>      uint64_t dest = iaoq_dest(ctx, disp);
>  
>      if (ctx->null_cond.c == TCG_COND_NEVER && ctx->null_lab == NULL) {
> -        if (link != 0) {
> -            copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
> -        }
> +        install_link(ctx, link, false);
>          ctx->iaoq_n = dest;
>          if (is_n) {
>              ctx->null_cond.c = TCG_COND_ALWAYS;
> @@ -1797,10 +1812,7 @@ static bool do_dbranch(DisasContext *ctx, int64_t disp,
>      } else {
>          nullify_over(ctx);
>  
> -        if (link != 0) {
> -            copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
> -        }
> -
> +        install_link(ctx, link, false);
>          if (is_n && use_nullify_skip(ctx)) {
>              nullify_set(ctx, 0);
>              gen_goto_tb(ctx, 0, dest, dest + 4);
> @@ -1892,9 +1904,7 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
>          next = tcg_temp_new_i64();
>          tcg_gen_mov_i64(next, dest);
>  
> -        if (link != 0) {
> -            copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
> -        }
> +        install_link(ctx, link, false);
>          if (is_n) {
>              if (use_nullify_skip(ctx)) {
>                  install_iaq_entries(ctx, -1, next, -1, NULL);
> @@ -1911,16 +1921,17 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
>  
>      nullify_over(ctx);
>  
> +    next = tcg_temp_new_i64();
> +    tcg_gen_mov_i64(next, dest);
> +
> +    install_link(ctx, link, false);
>      if (is_n && use_nullify_skip(ctx)) {
> -        install_iaq_entries(ctx, -1, dest, -1, NULL);
> +        install_iaq_entries(ctx, -1, next, -1, NULL);
>          nullify_set(ctx, 0);
>      } else {
> -        install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, -1, dest);
> +        install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, -1, next);
>          nullify_set(ctx, is_n);
>      }
> -    if (link != 0) {
> -        copy_iaoq_entry(ctx, cpu_gr[link], ctx->iaoq_n, ctx->iaoq_n_var);
> -    }
>  
>      tcg_gen_lookup_and_goto_ptr();
>      ctx->base.is_jmp = DISAS_NORETURN;
> @@ -3899,10 +3910,7 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
>      nullify_over(ctx);
>  
>      load_spr(ctx, new_spc, a->sp);
> -    if (a->l) {
> -        copy_iaoq_entry(ctx, cpu_gr[31], ctx->iaoq_n, ctx->iaoq_n_var);
> -        tcg_gen_mov_i64(cpu_sr[0], cpu_iasq_b);
> -    }
> +    install_link(ctx, a->l, true);
>      if (a->n && use_nullify_skip(ctx)) {
>          install_iaq_entries(ctx, -1, tmp, -1, NULL);
>          tcg_gen_mov_i64(cpu_iasq_f, new_spc);
> @@ -4019,16 +4027,16 @@ static bool trans_bve(DisasContext *ctx, arg_bve *a)
>      return do_ibranch(ctx, dest, a->l, a->n);
>  #else
>      nullify_over(ctx);
> -    dest = do_ibranch_priv(ctx, load_gpr(ctx, a->b));
> +    dest = tcg_temp_new_i64();
> +    tcg_gen_mov_i64(dest, load_gpr(ctx, a->b));
> +    dest = do_ibranch_priv(ctx, dest);
>  
> +    install_link(ctx, a->l, false);
>      install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, -1, dest);
>      if (ctx->iaoq_b == -1) {
>          tcg_gen_mov_i64(cpu_iasq_f, cpu_iasq_b);
>      }
>      tcg_gen_mov_i64(cpu_iasq_b, space_select(ctx, 0, dest));
> -    if (a->l) {
> -        copy_iaoq_entry(ctx, cpu_gr[a->l], ctx->iaoq_n, ctx->iaoq_n_var);
> -    }
>      nullify_set(ctx, a->n);
>      tcg_gen_lookup_and_goto_ptr();
>      ctx->base.is_jmp = DISAS_NORETURN;
> -- 
> 2.34.1
> 

