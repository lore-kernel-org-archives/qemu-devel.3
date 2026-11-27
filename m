Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C645606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nongnu.org header.i=@nongnu.org header.a=rsa-sha256 header.s=lists1p-gnu-org header.b=qSq/dGIG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rev.ng header.i=@rev.ng header.a=rsa-sha256 header.s=dkim header.b=Ax0pJI5P
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nongnu.org;
	 s=lists1p-gnu-org; h=From:In-Reply-To:MIME-Version:References:Subject:To:
	Date; bh=0xZYO1dD+MKVQc6P93xJWS+NiqPlaBxbaZMd9fXlEmY=; b=qSq/dGIGt4FbTL+LbAR5
	w6sGKMuMDoBT/+78CzMh6BfXVuQkscdiRW/SBqYYoB8DH39kLjE+MhRz4/J9oyAnExf3oQvt6DsGs
	Ugj7KLLJROAzd+dl2HIid7kniq286r++uFNUhbf6Wmgrt4/z9bXe7qeuNb6LbF48ZnlVcoqAj7KXH
	0OuOour8dmX02PELo8Pj1D7mvPtsVSIpXEmbbKjUkuw+Ipz0Ujr5XyP5UwJXAZAg0DB5po0I3HAt+
	/9xfdLftoYVNJOxThqYpintqmOewf3fhlsHKP7it0lCX3b5jOLrhNH+04Fnzj+EuNn/8UAAv2qaYn
	lGe06/IT9uCObw==;
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWu5q-000864-0p; Fri, 27 Nov 2026 06:26:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xWu5a-0007yy-MR; Fri, 27 Nov 2026 06:26:02 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xWu5Z-0007Cm-9E; Fri, 27 Nov 2026 06:26:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=0xZYO1dD+MKVQc6P93xJWS+NiqPlaBxbaZMd9fXlEmY=; b=Ax0pJI5PioIpVwC
 6RJt9/ihSAF3nMvuieo2DY6BpgZKr25fLwoFDaFFImgTiDLzRjbNCq3ZStM4GKz3Eu1mUYkhHeJQz
 tnO0rl+fm2pd48/F+sp+CAuIGDx+NeNR1uTCKpjbyjzACy4L/DL32CAOncEFtT9VCJtgA0W6obAUS
 n8=;
Date: Fri, 27 Nov 2026 12:32:24 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 23/24] target/xtensa: Use 64-bit TB flags
Message-ID: <awlqQ19ely0p4ou0@hive.localdomain>
References: <20261126233604.67722-1-philmd@oss.qualcomm.com>
 <20261126233604.67722-24-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261126233604.67722-24-philmd@oss.qualcomm.com>
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
>  target/xtensa/cpu.c       | 2 +-
>  target/xtensa/translate.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
> index c193396928f9..33054c81ca48 100644
> --- a/target/xtensa/cpu.c
> +++ b/target/xtensa/cpu.c
> @@ -60,7 +60,7 @@ static vaddr xtensa_cpu_get_pc(CPUState *cs)
>  static TCGTBCPUState xtensa_get_tb_cpu_state(CPUState *cs)
>  {
>      CPUXtensaState *env = cpu_env(cs);
> -    uint32_t flags = 0;
> +    uint64_t flags = 0;
>      uint64_t cs_base = 0;
>  
>      flags |= xtensa_get_ring(env);
> diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
> index 175fd4b5cfc2..57392ffd8319 100644
> --- a/target/xtensa/translate.c
> +++ b/target/xtensa/translate.c
> @@ -1121,7 +1121,7 @@ static void xtensa_tr_init_disas_context(DisasContextBase *dcbase,
>                                           CPUState *cpu)
>  {
>      DisasContext *dc = container_of(dcbase, DisasContext, base);
> -    uint32_t tb_flags = dc->base.tb->flags;
> +    uint64_t tb_flags = dc->base.tb->flags;
>  
>      dc->config = cpu_env(cpu)->config;
>      dc->pc = dc->base.pc_first;
> -- 
> 2.55.0
> 
> 

Reviewed-by: Anton Johansson <anjo@rev.ng>

