Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886DC1094471
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2026 12:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3vFs-0007uG-4S; Sat, 21 Mar 2026 08:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>)
 id 1w3vFo-0007tr-CE; Sat, 21 Mar 2026 08:16:32 -0400
Received: from smtpx.feld.cvut.cz ([2001:718:2:1516::210:153]
 helo=smtpx.fel.cvut.cz)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>)
 id 1w3vFm-0008E9-2q; Sat, 21 Mar 2026 08:16:32 -0400
Received: from localhost (unknown [192.168.200.27])
 by smtpx.fel.cvut.cz (Postfix) with ESMTP id 929131D3E8;
 Sat, 21 Mar 2026 13:16:20 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Authentication-Results: cerokez-250.feld.cvut.cz (amavis);
 dkim=pass (2048-bit key) header.d=fel.cvut.cz
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id 24d0DMBMfDQ4; Sat, 21 Mar 2026 13:16:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
 s=felmail; t=1774095379;
 bh=lrWJrmvDOvPhQqfjMIj8/1gXYs+NrU6uWZYqUUj9WTc=;
 h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
 b=bXFKaOPPGDS1aBr2VmuidLzV8A0PTT0iGqZ+6Vhsg4PHDDe2id+S8MuXsIHDFesH6
 SrLj+J5ILmRh+WzBq+CdM+uAbCoakbX2p1EvEKSqeLmgQ4pZ+tI7D1xjBG0X9STOSd
 VVBpspnwQ+vdW3+W69Z2IKM2gwQ+8ikRD9Z89IF2etLZ7Bc18JVW5UHQ1xR/wmySGM
 kjkrOGpoAup3lnwf6AuSJjDZP8J9LFABvHSNpNsCMSHLV/ATYZ9aVe0sdiMR7Z+AIa
 lC5a3XzUnLkAur+/w927R8eaCQXmxvyQSszBQ3yVYzNPEMsYx5NW4IursorNjW9rGX
 7rizcWmFGyc3Q==
Received: from baree.pikron.com (static-84-242-78-234.bb.vodafone.cz
 [84.242.78.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pisa)
 by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id B87D31D4AF;
 Sat, 21 Mar 2026 13:16:18 +0100 (CET)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: =?utf-8?q?Maty=C3=A1=C5=A1_Bobek?= <matyas.bobek@gmail.com>,
 "Marc Kleine-Budde" <mkl@pengutronix.de>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 4/7] hw/net/can/flexcan: NXP FlexCAN core emulation
Date: Sat, 21 Mar 2026 13:16:18 +0100
User-Agent: KMail/1.9.10
Cc: qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>
References: <cover.1773866323.git.matyas.bobek@gmail.com>
 <e790990bfaaebf2c1dd884c2c2f4eab5de6d4076.1773866323.git.matyas.bobek@gmail.com>
In-Reply-To: <e790990bfaaebf2c1dd884c2c2f4eab5de6d4076.1773866323.git.matyas.bobek@gmail.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <202603211316.18181.pisa@fel.cvut.cz>
Received-SPF: pass client-ip=2001:718:2:1516::210:153;
 envelope-from=pisa@fel.cvut.cz; helo=smtpx.fel.cvut.cz
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, NICE_REPLY_A=-2.101, SPF_HELO_NONE=0.001,
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

Dear QEMU maintainers and developers,

please review the code.

On Thursday 19 of March 2026 20:13:11 Maty=C3=A1=C5=A1 Bobek wrote:
> Added the FlexCAN2 emulator implementation core, with
> CAN_FLEXCAN Kconfig flag and MAINTAINERS entry.
>
> FlexCAN2 version can be found in i.MX6 SoCs and others.
>
> More information about the implementation can be found in [1].
>
> [1]
> http://dspace.cvut.cz/bitstream/handle/10467/122654/F3-BP-2025-Bobek-Maty=
as
>-BP_Bobek_FlexCAN_final_4.pdf
>
> Signed-off-by: Maty=C3=A1=C5=A1 Bobek <matyas.bobek@gmail.com>

Tested-by: Pavel Pisa <pisa@fel.cvut.cz>
Reviewed-by: Pavel Pisa <pisa@fel.cvut.cz>
Signed-off-by: Pavel Pisa <pisa@fel.cvut.cz>

I have tested the series final result as I have already
confirmed in reply to the cover letter.

I have gone through all commit and tested that the QEMU
build without errors even for all intermediate states.

Mark, please, look at the header definition license
as Matyas Bobek has expressed and I have already
announced as pleas by e-mail during FOSDEM.
=20
Best wishes,

                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://control.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    social:     https://social.kernel.org/ppisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    RISC-V education: https://comparch.edu.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home

