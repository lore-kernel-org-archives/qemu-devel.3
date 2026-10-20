Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE10606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 08:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lmichel.fr header.i=@lmichel.fr header.a=rsa-sha256 header.s=pharaoh header.b=b7M3i/8x
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ4lW-0004Cu-QX; Tue, 20 Oct 2026 04:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1xJ4lT-0004Bc-Id; Tue, 20 Oct 2026 04:00:07 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1xJ4lR-00078c-4q; Tue, 20 Oct 2026 04:00:07 -0400
Received: from localhost (sekoia-laptop.home.lmichel.fr [192.168.61.102])
 by pharaoh.lmichel.fr (Postfix) with ESMTPSA id 4A6ADC60347;
 Tue, 20 Oct 2026 10:00:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1792483200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lHrR27iyI0MeyoRrZRmp84ULOTdnuvhbigdD1Uvg9Hw=;
 b=b7M3i/8xX39FNyRE67FbiDijyJqEpnSrZuCva0zW1NTA0Q7Aq6E+PGhlbTLeZ5j76tWj0c
 P2Nqe6J1CHaGoKlvKmJQWzIoPD4sLMGfHbnQsOGVgXCUmEZZNOWS9bvtwiFJR1lvr0+pNV
 zUYfr+cIKhbr/4AruT2QoQe8toioY4yAWXZ2DalrvgLCSYpu99uLERPyhLC7rvSXCxEH3V
 yRmQQrJzmENv5vpd1N4U7wdQgkyU87ER4oRaaJ17NrsysjvR7IHEE3NY3BjrFzmoi/4/ep
 j1dE3laKzTAyx9CENEJppWeRX8JhT1j6inaDjHwZLfJDW1q+vivqQOh7JcuSVQ==
Date: Tue, 20 Oct 2026 09:59:59 +0200
From: Luc Michel <luc@lmichel.fr>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH] hw/misc/bcm2835_cprman: Treat invalid clock mux source
 select as GND
Message-ID: <atcff1SeRdLYmi9t@michell-laptop.localdomain>
References: <20261019161900.3271815-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019161900.3271815-1-peter.maydell@linaro.org>
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 17:19 Mon 19 Oct     , Peter Maydell wrote:
> The clock mux control registers in bcm2835_cprman have a 4 bit SRC
> field that selects the input clock source to use.  There are only 10
> valid SRC values.  Treat the invalid values as producing no clock
> output, as if the GND clock source was used or the mux was disabled.
> This avoids reading off the end of the mux->srcs[] array.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: fc9840850ba ("hw/misc/bcm2835_cprman: implement clock mux behaviour")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4695
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Luc Michel <luc@lmichel.fr>

> ---
>  hw/misc/bcm2835_cprman.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
> index f9a77ff9bb0..10cad07623d 100644
> --- a/hw/misc/bcm2835_cprman.c
> +++ b/hw/misc/bcm2835_cprman.c
> @@ -271,7 +271,7 @@ static void clock_mux_update(CprmanClockMuxState *mux)
>  
>      *mux->reg_ctl = FIELD_DP32(*mux->reg_ctl, CM_CLOCKx_CTL, BUSY, enabled);
>  
> -    if (!enabled) {
> +    if (!enabled || src >= ARRAY_SIZE(mux->srcs)) {
>          clock_update(mux->out, 0);
>          return;
>      }
> -- 
> 2.43.0
> 
> 

-- 

