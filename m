Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8DE606A321
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 11:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ul04TW2+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVSeh-0008Un-SP; Mon, 23 Nov 2026 06:56:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVSeW-0008UQ-6p
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 06:56:08 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVSeU-0007SM-Hb
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 06:56:07 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8b30cbfa628so21058787b3.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 03:56:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795434965; cv=none;
 d=google.com; s=arc-20260327;
 b=pascJUyfvYcv0Th65yuVfvDEehkZ+lAZaykTRRdhdK5byHekf3cxm92dYwT0QjX26/
 /49Awbca/bN0FkwnZxZjpSf1LPisYuLmHiuD0eAXXENf4hxdPrQWv5VfF1fYenUUf4NW
 bDz/h5lI/ktsNEGUbP/zNVv+3bJ6GMHUFkuADIqyy1+b3TOgHzj5LioIapuz06yjB2yj
 neJ89HTPhfqcPsOc9Oq035mbPqEfl3Pj+UoK87a1DptLXaPnEL6lCkMbnaDGQtFHEZhB
 d5jf+NUF7Sht1CHnuZGMVnowgWAWBRfZd67c6rC/cBagz04hmmZe4cuKYw4x2pX6bEW1
 eJFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6zfdO2OzUreW8lGzz4kPeHrkisuJNtMzB/9BzM9B9mM=;
 fh=snxlMAIYg42qHdZMI+YhOCzMiAqS8e+xhFzZVt6ivAc=;
 b=YjZ1zCSjyALRuOYwK2lDnDtsbPlRlfbZBlHC9/DiCw5Ea4b73u3H9QKnizNtNoYLwE
 lYtNxzZ4HxxQHGZW7Q5aE+uUSpG9OHavPGws2d1DVYivBYSzuXkVocCI1PediGinzJ4h
 ulPpD2CI0M+SXsxcUHE24u7M0xdPE/34E4HxKZeNlEPtzoPw9s8Tsby5BtOAJfHSchF6
 ZV659R2TUFqD7yBgjqeNnrZvE5QyDlQvFxS74QUl1L2/ah2yHzt7a0xIqqk7Ka7gYfZc
 9UJX7ttxzt3nceaVqEJgq/ePJWwUUGp48BZ+YG5Cu0ciAjJRusy1dapmMFn28aY8DLnt
 FndA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795434965; x=1796039765; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6zfdO2OzUreW8lGzz4kPeHrkisuJNtMzB/9BzM9B9mM=;
 b=ul04TW2+fp/E8DUvvfk/uw/93u8LehVY/c5UjJtPHgDuj7MiK9FcWRHsjpL605hnLZ
 aR6Xn8GiauPi+JPSfW+ibb6UUWo01pDcqDsnmLGN31D/blCEjIzSlVFYsuqnBsQ7ZLNC
 +WoI6G3Fdd6fXcW287RKDtBflEaPXN2We7WAobq5JMtR+jk8BVcYfBZ+/Anr1uEyS3bf
 2rLSBMSAkilueElfmbpcS92eT+RPvtNfTHQ75zqEZQfX3bbcNm+CK3EGhgU5WLXf6nn2
 MaEHlMAJQXXpnI9rLyJOovEyUerZr5hOOULOq5Myy1o0F/4U9653siAwLSqz9wrubtcG
 68xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795434965; x=1796039765;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6zfdO2OzUreW8lGzz4kPeHrkisuJNtMzB/9BzM9B9mM=;
 b=hApPLVhWWJeBtK7PRRp+etqBZeabAXSBvjsOXVekopSyDIGjErTFMgBQRyBLvUz28h
 IgVOOd2eSzvmlHgvTAduSxV3Xmzhj3/wmbZAStZjQNm2hc0p0xwxmvmsQKSdMC+vv9Li
 jozOXJ1Iqqy444lMpNAFBk7SV7V7VNDjY3qOuziblZ2v6JaCOAxW/7nXg5N5vnHskeIZ
 DIA8oInOvF0PWrRpI2MXnuib9ryOzbGJnPljUMPTzj8XLIv1Zrl7LwHDCVMmRGXAgmnW
 kcPeGjkoYrTU2Dcuqw6lRMO8909Z+q62MCnXySpLC71putSMk7xAHGIIIWQuB55S7BzK
 wQSA==
X-Gm-Message-State: APuU4Z/Rtz4Nrqbc9vY7simNrjVpdxBSNzRQ6T4rvFmRftsfDGcsxs+s
 L4KqWsOa93W6sN2wQKC75y023KAJ9fIIFphdUwj23dacXycZvLhlalqw/FqIekrN6kaO9AqUClQ
 sxZmZNNj3x5Xo/WNB++67BqsdTPTr0D2ZZU40gC4jhQ==
X-Gm-Gg: AZFdTZc/jrukuZWdG9HT93W8qGBtbGqPu+UlPFcTJBOPfYUh/NLGy1JUCM5Z2TVChZV
 ZXEDdU1o+aUd5ZcqjCwSsHAbDmsh7zxV6rhinR2lXRAqXt1d0ZWJe/XmPdpYanoRPYqcR7/xU2c
 mRqALP4ilbnvexPtAhHwuapSq/m3CX8AdmcIgL99r5/+KqNtuJbjdR8ri5OceQK9vFo6gpxfqH9
 n6Z7EZRmREqreA9Wh7elphizr2sjkcBcWlHo08DV22ZcmVwXwWyAuvl6UPxPeyz8HMfgrz1PQ38
 PNrW9YiLMQvgHuLqlu/NH2HM169Auz2uovHSs8Oo8HsurXcnee8YTEFBwWg1nBTPlyPRiYJg1Ov
 kuQzq4FSo9pfropDMDY2xIEJJB3yiDtFKkYgVnESD/q21CFgdh6JhYzkD7sZjEKoWqCyVxyUrYy
 6m18tIdxR0H+eeFrvYAy/F
X-Received: by 2002:a05:690e:a45:b0:67d:e867:89a0 with SMTP id
 956f58d0204a3-67df43ce3b5mr4534725d50.30.1795434964881; Mon, 23 Nov 2026
 03:56:04 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117193205.8236-1-agarwaljayesh03@gmail.com>
In-Reply-To: <20261117193205.8236-1-agarwaljayesh03@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Nov 2026 11:55:53 +0000
X-Gm-Features: Aa3M54qcfvLnmuQmOVFjmTs3WfpvouOrJyliMPqg8vjFnUH7_Br0-aVmcX4MCzU
Message-ID: <CAFEAcA_4+PcP8f2DF+mtjkO5iO6eU6C6R6hjfBN7dg0o_TGPiw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/bcm2838: Route system timer interrupts to GIC
To: Jayesh Agarwal <agarwaljayesh03@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@oss.qualcomm.com, qemu-arm@nongnu.org, 
 s23adhik@csclub.uwaterloo.ca
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 17 Nov 2026 at 19:32, Jayesh Agarwal <agarwaljayesh03@gmail.com> wrote:
>
> The system timer interrupts are only routed to the legacy interrupt
> controller and not to the GIC, so a guest using the GIC (software that
> relies on the system timer interrupts through the GIC, such as bare
> metal programs or hobby kernels) never receives them.
>
> A qemu_irq connection follows one output, one input. So also wiring the
> timer to the GIC would replace its connection to the legacy controller.
>
> Add a splitter per system-timer interrupt line so that each interrupt
> reaches both the legacy controller (output 0 of the splitters) and the
> GIC (output 1 of the splitters). The timer channel n goes to GIC SPI
> 64+n, so channels 0-3 go to SPIs 64-67.
>
> Testing:
> The raspi4b machine started in the qtest mode:
>         qemu-system-aarch64 -M raspi4b -display none -accel qtest -qtest stdio
>
> Ran following commands:
>         irq_intercept_in /machine/soc/peripherals
>         readl 0xfe003004
>         writel 0xfe00300c 1000
>         writel 0xfe003010 2000
>         writel 0xfe003014 3000
>         writel 0xfe003018 4000
>         clock_step 5000000
>         readl 0xfe003000
>
> Before the fix:
>     clock_step 5000000
>     OK 5000000
>     readl 0xfe003000
>     OK 0x000000000000000f
> The alarm fires correctly (status flag outputs 0xf), but no IRQ raise
> 64-67 reaches the GIC.
>
> After the fix:
>     clock_step 5000000
>     IRQ raise 64
>     IRQ raise 65
>     IRQ raise 66
>     IRQ raise 67
>     OK 5000000
>     readl 0xfe003000
>     OK 0x000000000000000f
> The alarm fires, and all the four channels reached GIC lines 64-67.
>
> Reported-by: Sourojeet Adhikari <s23adhik@csclub.uwaterloo.ca>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Jayesh Agarwal <agarwaljayesh03@gmail.com>
> ---
> This was picked up from Sourojeet's earlier patch, here is the link:
> https://lore.kernel.org/qemu-devel/3cca4eb3-09d1-4467-81fd-27a5bfe19a3e@csclub.uwaterloo.ca/

Thanks; applied to target-arm.next.

-- PMM

