Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE0251091911
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 19:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3JBT-0003UP-LQ; Thu, 19 Mar 2026 15:37:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>)
 id 1w3JBR-0003UB-QR; Thu, 19 Mar 2026 15:37:29 -0400
Received: from smtpx.feld.cvut.cz ([2001:718:2:1516::210:153]
 helo=smtpx.fel.cvut.cz)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>)
 id 1w3JBP-0001pu-3v; Thu, 19 Mar 2026 15:37:29 -0400
Received: from localhost (unknown [192.168.200.27])
 by smtpx.fel.cvut.cz (Postfix) with ESMTP id E62A5F2B3;
 Thu, 19 Mar 2026 20:37:19 +0100 (CET)
X-Virus-Scanned: IMAP STYX AMAVIS
Authentication-Results: cerokez-250.feld.cvut.cz (amavis);
 dkim=pass (2048-bit key) header.d=fel.cvut.cz
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id 3ITumVY4hEtg; Thu, 19 Mar 2026 20:37:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
 s=felmail; t=1773949038;
 bh=SSKP9gHN4dxnhv1s4EF6iPnAcJe9eTL4NQqQCg7kiic=;
 h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
 b=cFxUdCVxVdT6IXstpZR68bNABQTPHilx3vArv3M7s0ZmH22JcxrWimrobubkDoLxF
 cSaE7L/Gc+fScFEf/lxDM1O6L5Hq8KCipONMTmhpQy7WgNTC7z0qt3O70r7URaEYcu
 Gpod51517pe2UAopehVhlyutJaFVnpt014uEGxxDCfivHYOGVonXdXMw1NSoc3hB63
 zhZpkHOQjhqAV7stIOjp2CJL5VjbUINC+ta3tFl6AShrdhpIkB4r0GzQ7ZQAziN+nv
 X3/v7Nuo96Sa2jAiqmHcFtO4p6SFN33duEFsPWXbwztMF56Vl+dzGT2De+fQtnN5Bd
 IfE+dUsdC6tyQ==
Received: from [147.32.86.147] (unknown [147.32.86.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pisa)
 by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id F393AF2B2;
 Thu, 19 Mar 2026 20:37:17 +0100 (CET)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: =?utf-8?q?Maty=C3=A1=C5=A1_Bobek?= <matyas.bobek@gmail.com>
Subject: Re: [PATCH v2 0/7] hw/arm/sabrelite: Add FlexCAN support
Date: Thu, 19 Mar 2026 20:37:17 +0100
User-Agent: KMail/1.9.10
Cc: qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 "Marc Kleine-Budde" <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <cover.1773866323.git.matyas.bobek@gmail.com>
In-Reply-To: <cover.1773866323.git.matyas.bobek@gmail.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <202603192037.17674.pisa@fel.cvut.cz>
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

Dear Maty=C3=A1=C5=A1 Bobek,

thanks for the patches update and resolve of the review comments

On Thursday 19 of March 2026 20:13:07 Maty=C3=A1=C5=A1 Bobek wrote:
> This series adds emulation of the FlexCAN CAN controller, version 2,
> found in NXP i.MX6 series SoCs. The controller is integrated into
> fsl-imx6 and the Sabrelite ARM board.
>
> The chip has two FlexCAN controllers, but the Linux Sabrelite
> device tree enables only one by default. Linux kernel with both
> controllers enabled has been tested to work properly (using a custom
> device tree).
> See docs/system/devices/can.rst for an example of QEMU command line
> invocation.
>
> More information about the implementation can be found in my bachelor
> thesis [1].

Tested-by: Pavel Pisa <pisa@fel.cvut.cz>

I have tested the the whole series with my setup
and SabreLite kernel to communicate with host CAN
utilities over SocketCAN

qemu-system-arm -m 1G -M sabrelite -smp 4 \
      -kernel kernel-imx6q-sabrelite \
      -dtb imx6q-sabrelite.dtb \
      -initrd ramdisk.cpio \
      -serial mon:stdio \
      -nographic \
      -object can-bus,id=3Dcanbus0-bus \
      -object can-host-socketcan,if=3Dcan0,canbus=3Dcanbus0-bus,id=3Dcanbus=
0-socketcan \
      -machine canbus0=3Dcanbus0-bus -machine canbus1=3Dcanbus0-bus \

You can apply my tested by to all patches as well as

Reviewed-by: Pavel Pisa <pisa@fel.cvut.cz>

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

