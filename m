Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC5B8C25B79
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 16:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6v8T-0002R3-Is; Tue, 14 May 2024 12:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6v8N-0002Qg-JS
 for qemu-devel@nongnu.org; Tue, 14 May 2024 12:36:13 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1s6v8K-0007nT-Jk
 for qemu-devel@nongnu.org; Tue, 14 May 2024 12:36:11 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 227BE61227;
 Tue, 14 May 2024 16:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B949C2BD11;
 Tue, 14 May 2024 16:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715704566;
 bh=gyB40NyjtWgWdDbKqVbMBVo/7DogI8jaoIB9WKmTbYA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=X7QYPl95MBBzemVivwoWqnA2vJSg58Gk+64tYkEBTS7/Lh4rtMSlsK+3NrpdtZvov
 8meckXL4/H0uLp/56JIrzh9JfeLxva21GZTHPTijCqNz9NqfggnyUyxDtD6oQ5z/nW
 XdOW98Ouai6gLNRr+DGTSertx5atTX+gzRjW18KZ3Dqj8FYnNdhwMPbREpIASXP2/G
 e0HsoW94sOn1HnSWJwukTLpZHm2nZ77zguPfh6ZQF6g5WamcJnFikyP47Q5nXxIzlg
 hWXdyMwLVjiD3FXfxxoGH5z7ba3qaAKPfyyS3A2UGRj5WF0WIlle+NXnYYSc0Vcf61
 WQPOAUHluVbpQ==
Date: Tue, 14 May 2024 18:36:02 +0200
From: Helge Deller <deller@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@gmx.de
Subject: Re: [PATCH v2 24/45] target/hppa: Use TCG_COND_TST* in trans_bb_imm
Message-ID: <ZkOS8pUKCOg5NmUQ@carbonx1>
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-25-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513074717.130949-25-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Helge Deller <deller@gmx.de>

> ---
>  target/hppa/translate.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/target/hppa/translate.c b/target/hppa/translate.c
> index 47f4b23d1b..d8973a63df 100644
> --- a/target/hppa/translate.c
> +++ b/target/hppa/translate.c
> @@ -3515,18 +3515,12 @@ static bool trans_bb_sar(DisasContext *ctx, arg_bb_sar *a)
>  
>  static bool trans_bb_imm(DisasContext *ctx, arg_bb_imm *a)
>  {
> -    TCGv_i64 tmp, tcg_r;
>      DisasCond cond;
> -    int p;
> +    int p = a->p | (a->d ? 0 : 32);
>  
>      nullify_over(ctx);
> -
> -    tmp = tcg_temp_new_i64();
> -    tcg_r = load_gpr(ctx, a->r);
> -    p = a->p | (a->d ? 0 : 32);
> -    tcg_gen_shli_i64(tmp, tcg_r, p);
> -
> -    cond = cond_make_ti(a->c ? TCG_COND_GE : TCG_COND_LT, tmp, 0);
> +    cond = cond_make_vi(a->c ? TCG_COND_TSTEQ : TCG_COND_TSTNE,
> +                        load_gpr(ctx, a->r), 1ull << (63 - p));

I wonder if this actually fixes a bug...
Before it tested against all values >= tmp (even for which the bit
wasn't set), and now it correctly just checks the bit.


>      return do_cbranch(ctx, a->disp, a->n, &cond);
>  }
>  
> -- 
> 2.34.1
> 

