Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37C6606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nongnu.org header.i=@nongnu.org header.a=rsa-sha256 header.s=lists1p-gnu-org header.b=dKpztg5U;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rev.ng header.i=@rev.ng header.a=rsa-sha256 header.s=dkim header.b=r1e+2Rbn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nongnu.org;
	 s=lists1p-gnu-org; h=From:In-Reply-To:MIME-Version:References:Subject:To:
	Date; bh=9MN6vzTa8pwJAgv/exy5WVVbH/TFr4snuPsPlteVNNQ=; b=dKpztg5U8MBjYWHmHgNB
	GVVKICUUEkLhmJHv3KikB/1I+TP6Ux7xzs7mGoys5fx7O6NAexklGCzBJ4YfIa7gA06sXOKkYtjHm
	POHw/Z58lqhgP5uzi+RDfUgXob1c/nTMu9Vm/Uyf8mtg1vp21E9En8ABkDrPFTsGkvNQENuDN4/wc
	Aal3BWTI2ju/IKbNhAkMrDHuxpiCsjoNycHlYwmbC1dTPO9CEhFfyCdo5x2ky02KKlYnwmLtHmuL5
	BMORC6kz1JNQedt40WJ0OpwujmmxPUcA+fNneXOoA1LFXePNZyafDIErZANEnPVpKWrF7g1Rwmzp7
	kVuzqclq/7eCKQ==;
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWu4f-0006sF-Ql; Fri, 27 Nov 2026 06:25:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xWu4c-0006nW-62; Fri, 27 Nov 2026 06:25:02 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xWu4a-0002mV-BT; Fri, 27 Nov 2026 06:25:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=9MN6vzTa8pwJAgv/exy5WVVbH/TFr4snuPsPlteVNNQ=; b=r1e+2RbnVQV3cs5
 qQk0t5h54v8lX5hGmmWbTKc6KzffjL9FwcalRpcatTlPUi/MoTlUxlHIfpq+/DhmUAURFmIZMRE1I
 DxgXIkuPXx3rxOU55NMlTgay3dWG3gJu/sQaQMxkoeFiT0GpJE4QPt6UFxblwG4SEWyUepnhZl98e
 cg=;
Date: Fri, 27 Nov 2026 12:31:24 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH 22/24] target/tricore: Use 64-bit TB flags
Message-ID: <awlqBACW1IfUR30e@hive.localdomain>
References: <20261126233604.67722-1-philmd@oss.qualcomm.com>
 <20261126233604.67722-23-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261126233604.67722-23-philmd@oss.qualcomm.com>
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
>  target/tricore/cpu.c       | 2 +-
>  target/tricore/translate.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
> index fa782f82f00e..b77ad96fe7bb 100644
> --- a/target/tricore/cpu.c
> +++ b/target/tricore/cpu.c
> @@ -81,7 +81,7 @@ static TCGTBCPUState tricore_get_tb_cpu_state(CPUState *cs)
>  
>      return (TCGTBCPUState){
>          .pc = env->PC,
> -        .flags = FIELD_DP32(0, TB_FLAGS, PRIV, extract32(env->PSW, 10, 2)),
> +        .flags = FIELD_DP64(0, TB_FLAGS, PRIV, extract32(env->PSW, 10, 2)),
>      };
>  }
>  
> diff --git a/target/tricore/translate.c b/target/tricore/translate.c
> index 8cd6b58f66be..7f343d5626e6 100644
> --- a/target/tricore/translate.c
> +++ b/target/tricore/translate.c
> @@ -8389,8 +8389,8 @@ static void tricore_tr_init_disas_context(DisasContextBase *dcbase,
>      CPUTriCoreState *env = cpu_env(cs);
>      ctx->mem_idx = cpu_mmu_index(cs, false);
>  
> -    uint32_t tb_flags = (uint32_t)ctx->base.tb->flags;
> -    ctx->priv = FIELD_EX32(tb_flags, TB_FLAGS, PRIV);
> +    uint64_t tb_flags = ctx->base.tb->flags;
> +    ctx->priv = FIELD_EX64(tb_flags, TB_FLAGS, PRIV);
>  
>      ctx->features = env->features;
>      if (has_feature(ctx, TRICORE_FEATURE_161)) {
> -- 
> 2.55.0
> 
> 

Reviewed-by: Anton Johansson <anjo@rev.ng>

