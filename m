Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794BB606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nongnu.org header.i=@nongnu.org header.a=rsa-sha256 header.s=lists1p-gnu-org header.b=hQeGZOjK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rev.ng header.i=@rev.ng header.a=rsa-sha256 header.s=dkim header.b=klEmT1/H
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nongnu.org;
	 s=lists1p-gnu-org; h=From:In-Reply-To:MIME-Version:References:Subject:To:
	Date; bh=npcAvr7cF9G1HEnFq0gosMpLCC5sZPtl0ZZsIriLY54=; b=hQeGZOjKc6MDRjLS2h9g
	FIbUGCRwy8Tk3VcJis24AKIYPN+myCR0lMQAMr3FaeGdp+nw7iQ9x+xTVnhZJNUF0d33ZSDQiQd+Q
	euR7+6+eUNDCNAK+BtIsnJPt4kN4FlHDm38CqKVZ41LMGnpc7eOxaD+o3XYdRXh9mPkE3btMCABjS
	sX6LGrljUqcKpmgkOw1MolHhNqnX/wuKh1KV160BD3GZdFIJgZz1waiXP6TNPJvJppyHTa3FV5bBp
	8eCdA2AYoRkwUwn5WrhqOyrLpO+6JfvEUHepieI4IZ7dBBRiooqVHRKu+FiReW7uhUh1q+l2t5min
	viF8T0sqLitAJQ==;
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWttU-0005QM-3M; Fri, 27 Nov 2026 06:13:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xWttR-0005Or-Rj; Fri, 27 Nov 2026 06:13:29 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xWttQ-0000Ob-F5; Fri, 27 Nov 2026 06:13:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=npcAvr7cF9G1HEnFq0gosMpLCC5sZPtl0ZZsIriLY54=; b=klEmT1/HB5eSTlF
 n2VtCulYIRfK/tZXStb0kz4WduNiNrma3f5HtdczQH2QRwse7YT/S/yk04Hwo2sqMzWG4XswYj3gb
 UqAjKt1sOpkrvMhqACx3pwTUUGDRZPjKmNR5qZ0CJ9rq8o+597O6Fz9ooy2v2q7DNGBb2QSrygYQE
 I4=;
Date: Fri, 27 Nov 2026 12:19:50 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>
Subject: Re: [PATCH 13/24] target/mips: Use 64-bit TB flags
Message-ID: <awlm13RC0s-WW3yC@hive.localdomain>
References: <20261126233604.67722-1-philmd@oss.qualcomm.com>
 <20261126233604.67722-14-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261126233604.67722-14-philmd@oss.qualcomm.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 27/11/26, Philippe Mathieu-Daudé wrote:
> TranslationBlock::flags and TCGTBCPUState::flags are now
> 64-bit, use matching types for the values derived from them.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/mips/cpu.c           | 2 +-
>  target/mips/tcg/translate.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index 324e5989cca1..fb2ece5c9a46 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -682,7 +682,7 @@ static int mips_cpu_mmu_index(CPUState *cs, bool ifunc)
>  static TCGTBCPUState mips_get_tb_cpu_state(CPUState *cs)
>  {
>      CPUMIPSState *env = cpu_env(cs);
> -    uint32_t flags = env->hflags & MIPS_HFLAG_TB_MASK;
> +    uint64_t flags = env->hflags & MIPS_HFLAG_TB_MASK;
>  
>  #ifdef CONFIG_USER_ONLY
>      if (!cs->prctl_unalign_sigbus) {
> diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
> index bbcccbbb467f..9c76f1bc00ec 100644
> --- a/target/mips/tcg/translate.c
> +++ b/target/mips/tcg/translate.c
> @@ -15127,7 +15127,7 @@ static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>  {
>      DisasContext *ctx = container_of(dcbase, DisasContext, base);
>      CPUMIPSState *env = cpu_env(cs);
> -    uint32_t tb_flags = ctx->base.tb->flags;
> +    uint64_t tb_flags = ctx->base.tb->flags;
>  
>      ctx->page_start = ctx->base.pc_first & TARGET_PAGE_MASK;
>      ctx->saved_pc = -1;
> -- 
> 2.55.0
> 
> 

Reviewed-by: Anton Johansson <anjo@rev.ng>

