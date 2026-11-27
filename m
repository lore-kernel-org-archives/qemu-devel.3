Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1447606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=akmwblTQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWwiA-0008Ks-By; Fri, 27 Nov 2026 09:14:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWwi9-0008K3-0D
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:14:01 -0500
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWwi7-0007qH-AU
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:14:00 -0500
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-67da69e7c31so8900949d50.3
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 06:13:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795788838; cv=none;
 d=google.com; s=arc-20260327;
 b=LOQmtbr6PiLYpjBHs8FFgxZI3Up2eWEuavV3Rg/TZlzGrJrxEDvinhDf9TEkj4q/gE
 q/U9WhT6P7X6tmSpmZZOmYBElOJ/y/buG+dGBhqRNlG3wXWsmJedwCmJjOtLRlVe+eQv
 A7oExQLyJX2LVQAdQCI7Aq5a+Bip09/zVpwZCwv68vVt6RqMgh2USNGB51Nfk2BPkoDC
 PFtyDugqvVUGgwFPmij9petQjD7TbPrzU3YyGq0Sdpr0mbHiNwAwQkSgl10JYm31IrwF
 cV6Fok+hTDEeJ71RwxTD5pYdtIEYyRUsl4Z05N2GdDeCcf1IqEOuIOvPfazFlDb5QaIq
 wYPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oaBbdLlfphZZGlonjX6ZiCqsOaGK5GdvqIRSesdyBoU=;
 fh=vC/uU4M5uV4UbxLhfWAsSLjz/kqUTNTugKKi/gUgbKk=;
 b=CbG6UddrT7AscoOzHPVfherx3jy1dx6Qu4m1qV2twau/ZgWEVVkdO/8LXWfpPTQcY/
 wN20OTVjXiwOTQi/MM5p4Jsml9ueQ/9QZA8CqqvHhAFpfIYzPCUq5Ceg4+4QeI9z5POE
 Z92Yw4lRWJHbpxVgr8F65/9SPYIHcvDY9mePuuu9dikIhFk5Gn5mUinOF55GGXuW8ksg
 GfdjwpSnaTkQ5RiQ2D+ImTY0JZIomomwDCVo4ornIwptzZuzcgtcFZNLnk/6NXShiprP
 A/3aYnap1EM2/bqhciGBxPb6XJpEFrg/eXnUE7Q/8Ga+bxpaGhR+bN+YhNO+fgYjgEhj
 EMfg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795788838; x=1796393638; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oaBbdLlfphZZGlonjX6ZiCqsOaGK5GdvqIRSesdyBoU=;
 b=akmwblTQ8iZh5lNEaj4+OQ970ev/p362A9t4aK9XlaXIARB9o1DZsGJ0EhiE0VqgxL
 tkWXtuQ5hrwf908HmzHi4Y2ZVI0lqXKq/ciVULfUugon6S5q7okWh5se+SZbW0Qfvk+l
 JVfrZnoXGS+XOdItvhQSg2FRDPztJdqNE2E/9rhsuU6OIDj7g9938LzeKn4OHQsYwN+c
 M9RyfRKD3A6+hxz6rrSD07glqrruOMFe7uKXdiR71EuGiqqwJcAiZjlC/iSjjxQ6nScS
 E4ns7wrmiGdMPDjndrUFCHg0+EhugIohITimnGBBsPhbX15lyOq6AqsnsXoB/S0N6wHw
 hL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795788838; x=1796393638;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oaBbdLlfphZZGlonjX6ZiCqsOaGK5GdvqIRSesdyBoU=;
 b=NFQzm3lPaZ3XmBqb2WS8EiPecFIo+GFS4yUR5VT9dXMkAm4M4mKeXQTyAg3q4UDpcJ
 +YszKyPhyQEJmCI+IbBzo/ajPxAcr7xzaIm8/2ekftyLGQ9OKiK6Ri41yptNSiRNwjOX
 yjrDyO72j76tPPdbTLKI3defN11RYlvwUAesovE83hvWTbg64FQ4/bZreDMM5ug9mWDF
 lnceO7zwpyazkDrXFxYRJQXpDnzrh6zPVEDxvrStpLml+g1uEIsjPvS6Qnnx3JqAj8pl
 hDuc65sAuPOOpgLElZHCYcHEZR0VsYGaEOy83LiEN4VGc7ArQBnmCO6TxdZ0LUu4xhKK
 fvOA==
X-Gm-Message-State: APuU4Z+v0+TrwkFs2uI1OLhWvS6F4KBDuFDGcijQTxqwr1rD1wwDTxuH
 mHilWgUAWbJYb6ov8CoeaA6f7EsWdSQCMx89w6K1B4dUmwWqrueQxKOFvDOByORz9LYTqVr2UGh
 TpsihFjMHWyWEcX8WJ0n9xHkcERX9mniCjzvOp6gWSQ==
X-Gm-Gg: AZFdTZffqad1Nz4GNkMsiFjhXb11Z6BEDQX3sENwSZBLn3/iRYB7ifV1/MBXZxvUYWk
 +rl7w+SWl5P0AjPPr/TZcb1JDT6rzQBC8BrXyMJlg+UEVnVVZB05oMUHl0AivJtj9n1YvwVEUjK
 x3beiD6IYMasx+rbedV5bqWSzNmZshAr1hHOEADOkS/+5YKCvP2fYYO89lP/BdvcIX13CzuDfqy
 +d15PmFu4MbIFS3Ip8JiYnbl8UeQP0re/XwOcPnJ0pBIQBVUi6RNYmT+MrvNW1pCQV8lJMuwkGy
 MiJu4We/WTvN2cANiwUfLKpysBmmHzzBxJLZQl0c8sIJqjrsYh+y6hkZwoi3YV+jdBjh26oLcus
 ULre6LuAgsiRtwMAeSu7V2fsuv2GQckKcp4vkEXV8Jn3Jf/sdnBFCFloTPlZFwATDl8x3feu8Pu
 rARjr3b9b7uOkawV4h4XYo
X-Received: by 2002:a05:690e:450c:10b0:67d:b6fa:b7c5 with SMTP id
 956f58d0204a3-67df4455d2dmr7692972d50.45.1795788837889; Fri, 27 Nov 2026
 06:13:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124073406.87537-1-philmd@oss.qualcomm.com>
 <20261124073406.87537-4-philmd@oss.qualcomm.com>
In-Reply-To: <20261124073406.87537-4-philmd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Nov 2026 14:13:46 +0000
X-Gm-Features: Aa3M54raCqCDpqfhlAY0HG2gcor3sMKJbMmar2yma18VDX1q4lfMHHGAR7BXUhw
Message-ID: <CAFEAcA9nFQNFs01pKHFgSxAPyZ76gEqsxHgbOwn5gcRNaS5-SA@mail.gmail.com>
Subject: Re: [PATCH-for-11.2 3/4] hw/sd/sdhci: Treat Software Reset bits as
 independent pulses
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Bin Meng <bmeng.cn@gmail.com>, Karl Mehltretter <kmehltretter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 24 Nov 2026 at 07:35, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Writing Reset CMD and Reset DAT together (0x06) reset nothing, as
> the register was matched against exact values.
>
> Apply each bit independently. Reset For All still resets everything
> (SD Host Controller v1.00, section 2.2.16).
>
> Reported-by: Karl Mehltretter <kmehltretter@gmail.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4745
> Fixes: d7dfca0807a0 ("hw/sdhci: introduce standard SD host controller")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  hw/sd/sdhci.c | 39 ++++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 19 deletions(-)

+    sdhci_update_irq(s);

This is a change not mentioned in the commit message, but it looks
correct.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

