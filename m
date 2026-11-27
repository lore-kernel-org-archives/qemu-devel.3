Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EC3606A323
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nongnu.org header.i=@nongnu.org header.a=rsa-sha256 header.s=lists1p-gnu-org header.b=Qj8Ot9rx;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rev.ng header.i=@rev.ng header.a=rsa-sha256 header.s=dkim header.b=q5qhF119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nongnu.org;
	 s=lists1p-gnu-org; h=From:In-Reply-To:MIME-Version:References:Subject:To:
	Date; bh=NyJeqzWW+t/SEyfv5SxCWC3ourgNCAxFARKeag04br8=; b=Qj8Ot9rxCxZIx0slzJaE
	tuRJxAsZGX7ZP9uWU93XOETPBPkkYvGLI8nE/QTPVSLjeviQ7ZyRwwtnpzhWYw2u7r73b8NCuPJfT
	6jGEBJ6xe75NMS8CHVnUoTIQziXi5yYtjJulOSUhBg2bZ8F8FRjcnGMI2sg3lpQcRjHzznQDJ4/pN
	S3KB4Y1mBRbFbYLEpk9EOjDZpmnzx4CE/BQOH0fvACK/Baor/Y0JgtuHlm2MM7I/6JM4DyegfQqp/
	acF0PatkSq0tVfqZwunB/lzEjzC8QFRCtlNUHFmUyWM86C3AFDTMJO9KtDzmTH/saRU4/QBQqIaec
	/2hFQJVr3FmGqw==;
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWtmi-0006fY-9l; Fri, 27 Nov 2026 06:06:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xWtme-0006dj-RA; Fri, 27 Nov 2026 06:06:28 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xWtmb-0005Lf-8l; Fri, 27 Nov 2026 06:06:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=NyJeqzWW+t/SEyfv5SxCWC3ourgNCAxFARKeag04br8=; b=q5qhF119HiQ5Ezd
 vbzablZafG5JXE9h7xFVItT0xHWQNdMDchQZ+0MNdElqo8esgebblv2qgJYyD4XNi6Shqv8lYwh3B
 hYMtA6CBVeSwB1gZZk4MmNN6zy82jZHUequgPK1QkPR8M49+0JMj8JMRVaTtoWAFG1zoYnJjc68gq
 +8=;
Date: Fri, 27 Nov 2026 12:12:47 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Rolnik <mrolnik@gmail.com>
Subject: Re: [PATCH 06/24] target/avr: Use 64-bit TB flags
Message-ID: <awllq9m6qMNoEQI8@hive.localdomain>
References: <20261126233604.67722-1-philmd@oss.qualcomm.com>
 <20261126233604.67722-7-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261126233604.67722-7-philmd@oss.qualcomm.com>
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
>  target/avr/cpu.c       | 2 +-
>  target/avr/translate.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/avr/cpu.c b/target/avr/cpu.c
> index 83710f565182..689d3f6ac5f5 100644
> --- a/target/avr/cpu.c
> +++ b/target/avr/cpu.c
> @@ -58,7 +58,7 @@ static int avr_cpu_mmu_index(CPUState *cs, bool ifetch)
>  static TCGTBCPUState avr_get_tb_cpu_state(CPUState *cs)
>  {
>      CPUAVRState *env = cpu_env(cs);
> -    uint32_t flags = 0;
> +    uint64_t flags = 0;
>  
>      if (env->fullacc) {
>          flags |= TB_FLAGS_FULL_ACCESS;
> diff --git a/target/avr/translate.c b/target/avr/translate.c
> index 3c5760609702..6a4e36f326af 100644
> --- a/target/avr/translate.c
> +++ b/target/avr/translate.c
> @@ -2660,7 +2660,7 @@ static bool canonicalize_skip(DisasContext *ctx)
>  static void avr_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
>  {
>      DisasContext *ctx = container_of(dcbase, DisasContext, base);
> -    uint32_t tb_flags = ctx->base.tb->flags;
> +    uint64_t tb_flags = ctx->base.tb->flags;
>  
>      ctx->cs = cs;
>      ctx->env = cpu_env(cs);
> -- 
> 2.55.0
> 

Reviewed-by: Anton Johansson <anjo@rev.ng>

