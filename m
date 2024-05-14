Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4532AC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 15:29:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6u4U-0008Bo-0f; Tue, 14 May 2024 11:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6u4S-0008AG-0z
 for qemu-devel@nongnu.org; Tue, 14 May 2024 11:28:04 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6u4P-0007Xu-ML
 for qemu-devel@nongnu.org; Tue, 14 May 2024 11:28:03 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 0BF89CE128E;
 Tue, 14 May 2024 15:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0458DC2BD10;
 Tue, 14 May 2024 15:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715700477;
 bh=xk1XVTP95UZxDGf5rTjklvxXOdpUqvCU9pBZ3UqG2nM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YpI9a5/J5j2eTTXMwGGeZ7vuAtQuJOXiOO1Rbn4CtlmBNEm68c+z+PydK8h4d7vsw
 aDwaEHWFctFcqS8WJi83de3H0HEXOkZagQMhLobyC0+BvGF74POleVme/R9FWzbdeS
 ukUMg4tlafalY5cjgWWQsBH0ARzL6VjODq/UsMc4XoV8nIncFfIswbq2q7l7VlxU+/
 nGzmbyU4WvFWEyCN1aIF/LKzYpqlKiqBFiY+AXcRzC1Wfr6Md+W8Tbbjd/R/W3vnf6
 b64NLMgHiLjFyYS7BaClzyKswg7ru+ORDjO5wYORnmGb4AsyFtmQBkQ/NOL+0Zqd77
 dMHeL5R+kBWiA==
Date: Tue, 14 May 2024 17:27:53 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH v2 13/45] target/hppa: Add space arguments to
 install_iaq_entries
Message-ID: <ZkOC-Zk0cMW8lOHS@carbonx1>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-14-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513074717.130949-14-richard.henderson@linaro.org>
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
> Move space assighments to a central location.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


Reviewed-by: Helge Deller <deller@gmx.de>

> ---
>  target/hppa/translate.c | 58 +++++++++++++++++++----------------------
>  1 file changed, 27 insertions(+), 31 deletions(-)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index d24220c60f..05383dcd04 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -624,8 +624,9 @@ static void copy_iaoq_entry(DisasContext *ctx, TCGv_i64 dest,
>      }
>  }
>  
> -static void install_iaq_entries(DisasContext *ctx, uint64_t bi, TCGv_i64 bv,
> -                                uint64_t ni, TCGv_i64 nv)
> +static void install_iaq_entries(DisasContext *ctx,
> +                                uint64_t bi, TCGv_i64 bv, TCGv_i64 bs,
> +                                uint64_t ni, TCGv_i64 nv, TCGv_i64 ns)
>  {
>      copy_iaoq_entry(ctx, cpu_iaoq_f, bi, bv);
>  
> @@ -639,6 +640,12 @@ static void install_iaq_entries(DisasContext *ctx, uint64_t bi, TCGv_i64 bv,
>          tcg_gen_andi_i64(cpu_iaoq_b, cpu_iaoq_b,
>                           gva_offset_mask(ctx->tb_flags));
>      }
> +    if (bs) {
> +        tcg_gen_mov_i64(cpu_iasq_f, bs);
> +    }
> +    if (ns || bs) {
> +        tcg_gen_mov_i64(cpu_iasq_b, ns ? ns : bs);
> +    }
>  }
>  
>  static void install_link(DisasContext *ctx, unsigned link, bool with_sr0)
> @@ -670,7 +677,8 @@ static void gen_excp_1(int exception)
>  
>  static void gen_excp(DisasContext *ctx, int exception)
>  {
> -    install_iaq_entries(ctx, ctx->iaoq_f, cpu_iaoq_f, ctx->iaoq_b, cpu_iaoq_b);
> +    install_iaq_entries(ctx, ctx->iaoq_f, cpu_iaoq_f, NULL,
> +                        ctx->iaoq_b, cpu_iaoq_b, NULL);
>      nullify_save(ctx);
>      gen_excp_1(exception);
>      ctx->base.is_jmp = DISAS_NORETURN;
> @@ -724,10 +732,11 @@ static void gen_goto_tb(DisasContext *ctx, int which,
>  {
>      if (use_goto_tb(ctx, b, n)) {
>          tcg_gen_goto_tb(which);
> -        install_iaq_entries(ctx, b, NULL, n, NULL);
> +        install_iaq_entries(ctx, b, NULL, NULL, n, NULL, NULL);
>          tcg_gen_exit_tb(ctx->base.tb, which);
>      } else {
> -        install_iaq_entries(ctx, b, cpu_iaoq_b, n, ctx->iaoq_n_var);
> +        install_iaq_entries(ctx, b, cpu_iaoq_b, ctx->iasq_b,
> +                            n, ctx->iaoq_n_var, ctx->iasq_n);
>          tcg_gen_lookup_and_goto_ptr();
>      }
>  }
> @@ -1916,7 +1925,7 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
>          install_link(ctx, link, false);
>          if (is_n) {
>              if (use_nullify_skip(ctx)) {
> -                install_iaq_entries(ctx, -1, next, -1, NULL);
> +                install_iaq_entries(ctx, -1, next, NULL, -1, NULL, NULL);
>                  nullify_set(ctx, 0);
>                  ctx->base.is_jmp = DISAS_IAQ_N_UPDATED;
>                  return true;
> @@ -1935,10 +1944,11 @@ static bool do_ibranch(DisasContext *ctx, TCGv_i64 dest,
>  
>      install_link(ctx, link, false);
>      if (is_n && use_nullify_skip(ctx)) {
> -        install_iaq_entries(ctx, -1, next, -1, NULL);
> +        install_iaq_entries(ctx, -1, next, NULL, -1, NULL, NULL);
>          nullify_set(ctx, 0);
>      } else {
> -        install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, -1, next);
> +        install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, ctx->iasq_b,
> +                            -1, next, NULL);
>          nullify_set(ctx, is_n);
>      }
>  
> @@ -2026,7 +2036,7 @@ static void do_page_zero(DisasContext *ctx)
>          tcg_gen_st_i64(cpu_gr[26], tcg_env, offsetof(CPUHPPAState, cr[27]));
>          tmp = tcg_temp_new_i64();
>          tcg_gen_ori_i64(tmp, cpu_gr[31], 3);
> -        install_iaq_entries(ctx, -1, tmp, -1, NULL);
> +        install_iaq_entries(ctx, -1, tmp, NULL, -1, NULL, NULL);
>          ctx->base.is_jmp = DISAS_IAQ_N_UPDATED;
>          break;
>  
> @@ -2770,8 +2780,8 @@ static bool trans_or(DisasContext *ctx, arg_rrr_cf_d *a)
>              nullify_over(ctx);
>  
>              /* Advance the instruction queue.  */
> -            install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b,
> -                                ctx->iaoq_n, ctx->iaoq_n_var);
> +            install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, ctx->iasq_b,
> +                                ctx->iaoq_n, ctx->iaoq_n_var, ctx->iasq_n);
>              nullify_set(ctx, 0);
>  
>              /* Tell the qemu main loop to halt until this cpu has work.  */
> @@ -3921,16 +3931,11 @@ static bool trans_be(DisasContext *ctx, arg_be *a)
>      load_spr(ctx, new_spc, a->sp);
>      install_link(ctx, a->l, true);
>      if (a->n && use_nullify_skip(ctx)) {
> -        install_iaq_entries(ctx, -1, tmp, -1, NULL);
> -        tcg_gen_mov_i64(cpu_iasq_f, new_spc);
> -        tcg_gen_mov_i64(cpu_iasq_b, new_spc);
> +        install_iaq_entries(ctx, -1, tmp, new_spc, -1, NULL, new_spc);
>          nullify_set(ctx, 0);
>      } else {
> -        install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, -1, tmp);
> -        if (ctx->iasq_b) {
> -            tcg_gen_mov_i64(cpu_iasq_f, ctx->iasq_b);
> -        }
> -        tcg_gen_mov_i64(cpu_iasq_b, new_spc);
> +        install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, ctx->iasq_b,
> +                            -1, tmp, new_spc);
>          nullify_set(ctx, a->n);
>      }
>      tcg_gen_lookup_and_goto_ptr();
> @@ -4041,11 +4046,8 @@ static bool trans_bve(DisasContext *ctx, arg_bve *a)
>      dest = do_ibranch_priv(ctx, dest);
>  
>      install_link(ctx, a->l, false);
> -    install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, -1, dest);
> -    if (ctx->iasq_b) {
> -        tcg_gen_mov_i64(cpu_iasq_f, ctx->iasq_b);
> -    }
> -    tcg_gen_mov_i64(cpu_iasq_b, space_select(ctx, 0, dest));
> +    install_iaq_entries(ctx, ctx->iaoq_b, cpu_iaoq_b, ctx->iasq_b,
> +                        -1, dest, space_select(ctx, 0, dest));
>      nullify_set(ctx, a->n);
>      tcg_gen_lookup_and_goto_ptr();
>      ctx->base.is_jmp = DISAS_NORETURN;
> @@ -4781,13 +4783,7 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
>          }
>          /* FALLTHRU */
>      case DISAS_IAQ_N_STALE_EXIT:
> -        install_iaq_entries(ctx, fi, fv, bi, bv);
> -        if (fs) {
> -            tcg_gen_mov_i64(cpu_iasq_f, fs);
> -        }
> -        if (bs) {
> -            tcg_gen_mov_i64(cpu_iasq_b, bs);
> -        }
> +        install_iaq_entries(ctx, fi, fv, fs, bi, bv, bs);
>          nullify_save(ctx);
>          if (is_jmp == DISAS_IAQ_N_STALE_EXIT) {
>              tcg_gen_exit_tb(NULL, 0);
> -- 
> 2.34.1
> 

