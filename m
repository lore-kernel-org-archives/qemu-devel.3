Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D1A606A324
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nongnu.org header.i=@nongnu.org header.a=rsa-sha256 header.s=lists1p-gnu-org header.b=PUzf0q0M;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rev.ng header.i=@rev.ng header.a=rsa-sha256 header.s=dkim header.b=V1Ab6gho
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nongnu.org;
	 s=lists1p-gnu-org; h=From:In-Reply-To:MIME-Version:References:Subject:To:
	Date; bh=ckdohR7rWt343522hN+pyTukHWTmhoGpVlXaDdHvlEo=; b=PUzf0q0M98Qwz06PSuUK
	ENOS13mXBmsi9/ixH6LoAKgdeyWxJJOY3SPUUe1ooK+qch9GJBv2KguYXJHeuAU9N8EkGXQ1ijQPh
	OOwQVs63e2v0NeBNYhgI+FWOOzJLk1s5OQckQD/F8og3d47J2h82Z0+yzx77Zqw1IDNMoRuqHPwkk
	ihNEmUfprUk09eLy4d/xd1WSLUPsfHAOCKPzYVhdDSb434MVMjFp1x76BJmfcs5vt/vEpZRICJOrt
	ojTqe+75vo5//dma4HXgyMtco/m/NU1nNcNlQ/EgNB3f7jJAngG1T06Iifwf4+p9JyS6SMyWgkrqJ
	wyY4VoXRluj21w==;
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWu30-0004YY-Rk; Fri, 27 Nov 2026 06:23:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xWu2z-0004WV-7F; Fri, 27 Nov 2026 06:23:21 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xWu2x-0004eD-QZ; Fri, 27 Nov 2026 06:23:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=ckdohR7rWt343522hN+pyTukHWTmhoGpVlXaDdHvlEo=; b=V1Ab6ghoDYkC/D6
 2zC1XOuJs0Cknuj0rn30XLh9Wco2lAd4+KvZwz8V3dh/wtYdvGu7ygioMTJVJmIfoq1mo5zmZPQP0
 v8mjzNhrfpqTa99FrA/P1Nv4X4XM58sKnfqdvg2irAkRANLvsESL8++uu2DgUYBQpAdw3dzUoSb4I
 kY=;
Date: Fri, 27 Nov 2026 12:29:42 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: Re: [PATCH 20/24] target/sh4: Use 64-bit TB flags
Message-ID: <awlpl8yXC1O6dXLE@hive.localdomain>
References: <20261126233604.67722-1-philmd@oss.qualcomm.com>
 <20261126233604.67722-21-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261126233604.67722-21-philmd@oss.qualcomm.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 27/11/26, Philippe Mathieu-Daudé wrote:
> TranslationBlock::flags and TCGTBCPUState::flags are now
> 64-bit, use matching types for the values derived from them.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/sh4/cpu.c       | 2 +-
>  target/sh4/translate.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
> index 17731935779e..90e3e4d52b82 100644
> --- a/target/sh4/cpu.c
> +++ b/target/sh4/cpu.c
> @@ -47,7 +47,7 @@ static vaddr superh_cpu_get_pc(CPUState *cs)
>  static TCGTBCPUState superh_get_tb_cpu_state(CPUState *cs)
>  {
>      CPUSH4State *env = cpu_env(cs);
> -    uint32_t flags;
> +    uint64_t flags;
>  
>      flags = env->flags
>              | (env->fpscr & TB_FLAG_FPSCR_MASK)
> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index 5729a757f191..0f43a5dced14 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -36,7 +36,7 @@
>  typedef struct DisasContext {
>      DisasContextBase base;
>  
> -    uint32_t tbflags;  /* should stay unmodified during the TB translation */
> +    uint64_t tbflags;  /* should stay unmodified during the TB translation */
>      uint32_t envflags; /* should stay in sync with env->flags using TCG ops */
>      int memidx;
>      int gbank;
> @@ -2177,7 +2177,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
>  static void sh4_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>  {
>      DisasContext *ctx = container_of(dcbase, DisasContext, base);
> -    uint32_t tbflags;
> +    uint64_t tbflags;
>      int bound;
>  
>      ctx->tbflags = tbflags = ctx->base.tb->flags;
> -- 
> 2.55.0
> 

Reviewed-by: Anton Johansson <anjo@rev.ng>

