Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CD1CD11DB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 15:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmbl3-0004kJ-3x; Tue, 19 Mar 2024 11:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rmbkr-0004Qd-17
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:51:58 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rmbkp-0006tE-1v
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 11:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lZapTB7uIvBZ/rkcRNjiHr0xGC6XXgImEMweN9A/43Y=; b=WG3Qv/GS+vP5wc1R7KGLmqxyu/
 EQBLzIbJPgRcr0AY9Lw/NE2nVM5L7CebTd1qMqsS84EUZh52VSlZvanUdSLxjGp6iw0zEiYOXuCmv
 RhIzLvmwrjvFOdx66eS6mU6foygCbKFnSg47ESi+aRogTCdbEC1UBbLZfDotpOtMzR2c=;
Date: Tue, 19 Mar 2024 16:52:33 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Laurent Vivier <laurent@vivier.eu>, Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH-for-9.1 1/8] target/microblaze: Use correct string format
 in do_unaligned_access()
Message-ID: <twwnjcapdjqwd4yhfmpzv75op7unsrzoialxa3jc5r73kmu2xt@7fqr6frphdkk>
References: <20240319062855.8025-1-philmd@linaro.org>
 <20240319062855.8025-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240319062855.8025-2-philmd@linaro.org>
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 19/03/24, Philippe Mathieu-Daudé wrote:
> 'addr' is of type 'vaddr'; no need to cast, use the
> corresponding format string.
> 
> Fixes: ab0c8d0f5b ("target/microblaze: Use cc->do_unaligned_access")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/microblaze/helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
> index d25c9eb4d3..0a12c4ea94 100644
> --- a/target/microblaze/helper.c
> +++ b/target/microblaze/helper.c
> @@ -279,8 +279,8 @@ void mb_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>      iflags = cpu->env.iflags;
>  
>      qemu_log_mask(CPU_LOG_INT,
> -                  "Unaligned access addr=" TARGET_FMT_lx " pc=%x iflags=%x\n",
> -                  (target_ulong)addr, cpu->env.pc, iflags);
> +                  "Unaligned access addr=0x%"VADDR_PRIx" pc=0x%x iflags=0x%x\n",
> +                  addr, cpu->env.pc, iflags);
>  
>      esr = ESR_EC_UNALIGNED_DATA;
>      if (likely(iflags & ESR_ESS_FLAG)) {
> -- 
> 2.41.0
> 
Reviewed-by: Anton Johansson <anjo@rev.ng>

