Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DB3D3940B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 10:04:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8EtO-0005He-1H; Thu, 02 Apr 2026 06:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1w8EtM-0005Ba-4L
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:03:12 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1w8EtK-0002cy-4A
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 06:03:11 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-486fc4725f0so6970085e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 03:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775124188; x=1775728988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DqqnnT4TrkCK/OHAWuLLo26XZUl9LPYdU8nqOdKZmII=;
 b=eqjpOdCfFxxnqnmo/xI7oGXnYQlTKMTWGo16ia/plR4fpja1ZJObIRMP2tCFweddlK
 imEyj3Q79E9+cd+CU6cVOiDpyoczG0+brKinbujBePrJRZqjH/Imxto+Pu3NUWghVY5e
 TxCoO3LQLg2kwaItylTfBcxRMmUpXS6HjVSADRMvCA3ePsjBPFWyowLVW7KBe4Eb5M4e
 x5W/7nx83hwPjI0197DebhQ77y6tcfCZR6g/r3Qx0rOQ0+/XSIpKeJ7ffJkl0VlLu602
 h+tHsl/ZiQWhb8fNVr8i78xUZ7H5G0eYn9g44zRPZg4fnlbkihihCjY6H5ZlLu7wuW+w
 nudg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775124188; x=1775728988;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DqqnnT4TrkCK/OHAWuLLo26XZUl9LPYdU8nqOdKZmII=;
 b=giPje4aF7lynyVfkG24Ur//IyDNi1zVrip1yC15JEe3LZSNgowEGROdHjAKuHRlddI
 Vl0Wl4mJZ7mRPmA6JIPZQT4Q0G+K7dNU4FDnt9ha6J2e+N5HXMAMWuNE2sC5tL9Wv86R
 yeZOaPVdk8pjdpn8t3ZdoazCHCA2/gghnKgORwZe8/EHQz47keWu7rME7XkH9CV6lv1R
 t/DEutDpfdtAcjEwoGRZTM8b/bQUKhFex3F+rO71uUEeVocfbHOrbQggsGRuyrWrA59P
 Z/UX3utwjeRq0j6IF+hBfBNKgtIO2QcRUbenToWCxUILQXBdDF9wUKY65jXLbW7Mv52x
 jRAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSJ9eLnbm5CEsJBnZIDVo9JUXIr+fv36dykVOcbRPf+22OztYxYCim0Epd3h25EK25GS6+L8y4XB+E@nongnu.org
X-Gm-Message-State: AOJu0YzeYRlMYSO+uRFFMkAI598GohOIZ3+9h2y1rDKEEQNCTk1KEWh1
 1yt0xbi955d7rXgXJUSRuyLODPJjY6p95G03SbgvFKTUroc0qYmAIdcjLduuqA==
X-Gm-Gg: ATEYQzxUr4/3Vkm+oML4SedOec0Gvjxoxmf1GTbmKDpUVwVGrr8YwSlX1Uf/VHcVaAZ
 7zxZlr312HE288geH9PBEG12EMF1vDRMS+dMt3XsdIDmV1S57esIiuULvXNiUgnpGD4ouNCn2jB
 RkyhXrd8Qzr0vVXQ7+cdS6vcIxdk0W4dw90Aojq/p+7MVnu1iygT1vK2ObwUJNvwChNwI1bpmqj
 WeUOhZtVQHLfYMAe7ilnmzRMG1To+JC0bKotr8E2Q8MaOJ4e5oxQi/Cj5J/mE8qzoZgk1ptj2WH
 d9k5lMTWROoRWDDRP0ve5qDNwMU7DxYC/5mxdljmJvej8AE8/xZ7DiL8ONPvyay38AEsBuYcH0L
 hJa5fHoUla5xyokakxyf8Y2XpnSKresM54SG85wVAIAApbiPi09xOi4PMwQxsFJQBI3IXnKswJ2
 4zB4kx2bwBfxbxcefvPsMq+eBwBe9AKP3SfJAceVQ=
X-Received: by 2002:a05:600c:19d0:b0:477:9890:9ab8 with SMTP id
 5b1f17b1804b1-4888e01f5c4mr25029835e9.3.1775124187552; 
 Thu, 02 Apr 2026 03:03:07 -0700 (PDT)
Received: from ehlo.thunderbird.net ([62.214.191.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4888a72baa8sm57180875e9.15.2026.04.02.03.03.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Apr 2026 03:03:07 -0700 (PDT)
Date: Thu, 02 Apr 2026 10:02:56 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?UTF-8?Q?Maty=C3=A1=C5=A1_Bobek?= <matyas.bobek@gmail.com>,
 qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>
CC: qemu-arm@nongnu.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 0/7] hw/arm/sabrelite: Add FlexCAN support
In-Reply-To: <cover.1773866323.git.matyas.bobek@gmail.com>
References: <cover.1773866323.git.matyas.bobek@gmail.com>
Message-ID: <D2D2A915-D9EB-40A9-921C-0DB50D4CA810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



Am 19=2E M=C3=A4rz 2026 19:13:07 UTC schrieb "Maty=C3=A1=C5=A1 Bobek" <mat=
yas=2Ebobek@gmail=2Ecom>:

Hi Maty=C3=A1=C5=A1,

>This series adds emulation of the FlexCAN CAN controller, version 2,
>found in NXP i=2EMX6 series SoCs=2E The controller is integrated into
>fsl-imx6 and the Sabrelite ARM board=2E
>
>The chip has two FlexCAN controllers, but the Linux Sabrelite
>device tree enables only one by default=2E Linux kernel with both
>controllers enabled has been tested to work properly (using a custom
>device tree)=2E
>See docs/system/devices/can=2Erst for an example of QEMU command line
>invocation=2E
>
>More information about the implementation can be found in my bachelor
>thesis [1]=2E
>
>The headers (struct FlexcanRegs and flexcan_regs=2Eh macros) were copied
>from the Linux kernel=2E Marc Kleine-Budde is the copyright holder=2E He
>has been kindly asked to provide consent, to confirm his approval for
>the inclusion of said header fragments into QEMU=2E
>
>Changes from v1:
>- removed DPRINTF (turned into traces or guest errors)
>- removed gotos and unnecessary continues
>- register memory region shortened to actual length w/o padding
>- make flexcan_* fns private
>- used DEVICE(s)->canonical_path instead of allocating new strings
>- changed DEVICE_NATIVE_ENDIAN to DEVICE_LITTLE_ENDIAN
>- removed ugly USE macro
>- used enums instead of define sequences in flexcan=2Ec
>- fixed FlexCAN KConfig conf (fixes build on non-arm-softmmu)
>- fixed style and other issues from Bernhard's review
>- better wording in docs
>- rebased onto latest master
>- Link to v1: https://lore=2Ekernel=2Eorg/qemu-devel/cover=2E1765826753=
=2Egit=2Ematyas=2Ebobek@gmail=2Ecom

Nice!

>
>Thanks Bernhard Beschow for the review and his patience=2E
>I borrowed some fixes from his flexcan branch at [2]=2E

You're welcome to do that!

I'm on reviewing v2=2E Since I'm currently rather busy this will take me m=
ore time=2E And I want to mention that I'm very much looking forward to hav=
ing CAN support in i=2EMX devices!

Best regards,
Bernhard

>
>[1] http://dspace=2Ecvut=2Ecz/bitstream/handle/10467/122654/F3-BP-2025-Bo=
bek-Matyas-BP_Bobek_FlexCAN_final_4=2Epdf
>[2] https://github=2Ecom/shentok/qemu/tree/flexcan
>
>Maty=C3=A1=C5=A1 Bobek (7):
>  hw/arm/sabrelite: Open code DEFINE_MACHINE_ARM
>  hw/arm/sabrelite: Introduce class SabreliteMachineState
>  hw/misc/imx6_ccm: Add PLL3 and CAN clock
>  hw/net/can/flexcan: NXP FlexCAN core emulation
>  hw/arm: Plug FlexCAN into FSL_IMX6 and Sabrelite
>  tests: Add qtests for FlexCAN
>  docs/arm/sabrelite: Mention FlexCAN support
>
> MAINTAINERS                   |    9 +
> docs/system/arm/sabrelite=2Erst |    1 +
> docs/system/devices/can=2Erst   |   24 +
> hw/arm/Kconfig                |    1 +
> hw/arm/fsl-imx6=2Ec             |   29 +
> hw/arm/sabrelite=2Ec            |   68 +-
> hw/misc/imx6_ccm=2Ec            |   24 +
> hw/misc/trace-events          |    2 +
> hw/net/Kconfig                |    5 +
> hw/net/can/flexcan=2Ec          | 1407 +++++++++++++++++++++++++++++++++
> hw/net/can/flexcan_regs=2Eh     |  193 +++++
> hw/net/can/meson=2Ebuild        |    1 +
> hw/net/can/trace-events       |   18 +
> include/hw/arm/fsl-imx6=2Eh     |    6 +
> include/hw/misc/imx6_ccm=2Eh    |    4 +
> include/hw/misc/imx_ccm=2Eh     |    1 +
> include/hw/net/flexcan=2Eh      |  142 ++++
> tests/qtest/flexcan-test=2Ec    |  424 ++++++++++
> tests/qtest/meson=2Ebuild       |    1 +
> 19 files changed, 2350 insertions(+), 10 deletions(-)
> create mode 100644 hw/net/can/flexcan=2Ec
> create mode 100644 hw/net/can/flexcan_regs=2Eh
> create mode 100644 include/hw/net/flexcan=2Eh
> create mode 100644 tests/qtest/flexcan-test=2Ec
>

