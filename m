Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A2B8C88E63
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 19:50:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5qD0-0005MC-FJ; Sun, 13 Sep 2026 15:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1x5oqG-00010W-LR; Sun, 13 Sep 2026 14:22:18 -0400
Received: from www675.your-server.de ([85.10.213.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1x5oqE-0003bg-9V; Sun, 13 Sep 2026 14:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sayyadumar.com; s=default2511; h=Cc:To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-Id:Date:Subject:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References;
 bh=gFS9Xb1WO+z2ZPqHNl0TD1839UvVvx8FCWk1gWi530M=; b=qGAHV0CAUEy+C/a52adGBj1ize
 eZO6ACfMA8hgAWonpsh3OppZcl0dScFRCIWWVFIVFtIfPaZ+YrRaVunHi6iI8T6QdPxNMXQlFf0I/
 HCBRP1d0F5b9TuDX85tABL1z/OjTNPLFcX3KVOS+cpvDZXX6j70hywZVOCbGX5ktIVlvvn+z4R1xg
 wLsW/CKzOR8wXYvCbYPgtK4B2gVlGMxJ8EeovB/63Noin+2x8Foi37XBVi8RsO4oWKrJYdQrWUpFs
 aO6fqO8mev6RXeYCIvbTbIwQCn+uSoAr8QIzTYowxk5RmQFIDCZ1X5Gqnn263iUbF8UNnpzbiFqtZ
 50rlNlOA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www675.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <contact@sayyadumar.com>)
 id 1x5oq5-000LWg-1w; Sun, 13 Sep 2026 20:22:05 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <contact@sayyadumar.com>)
 id 1x5oq5-000PM1-0b; Sun, 13 Sep 2026 20:22:05 +0200
From: Sayyad Mahammad Umar <contact@sayyadumar.com>
Subject: [PATCH 0/2] target/rx: add RXv2/RXv3 CPU support
Date: Sun, 13 Sep 2026 20:21:04 +0200
Message-Id: <20260913-umar-rx-series-v1-0-5a5841a5d1e9@sayyadumar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw5AQAxA0V+RrjUZjxB+RSyUDpV4pINIxL8bL
 M/i3gscq7CDMrhA+RAny+wRhQG0QzP3jNJ5Q2zizBRRgvvUKOqJf4eGLJHljEyego9WZSvnN6z
 q326nkdvtvcB9P6ICeSpyAAAA
X-Change-ID: 20260913-umar-rx-series-0bfbbfe6b074
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, 
 qemu-arm@nongnu.org, Sayyad Mahammad Umar <contact@sayyadumar.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789323724; l=2862;
 i=contact@sayyadumar.com; s=qemu; h=from:subject:message-id;
 bh=9lk5zmMne3zlIbO22nryvFD35xytV/b00ZAjDNaaGzw=;
 b=d1PXdbbIBJN3tLiUms6MpmqrLXyD742T2ejcnx7nOB0U+84yGmpYN5qb99M28ux6Vu4Mr/5Nb
 mv81xQBQ+stAoMB4i6V58duWX2ZhQEYIctp/PlWqUv25UAOUo+UC8W/
X-Developer-Key: i=contact@sayyadumar.com; a=ed25519;
 pk=CsAjTLRCB7+pnzmj8902JER4gL8CTzNQFxlMZTl4wDk=
X-Virus-Scanned: Clear (ClamAV 1.4.3/28122/Sun Sep 13 08:26:25 2026)
Received-SPF: pass client-ip=85.10.213.182;
 envelope-from=contact@sayyadumar.com; helo=www675.your-server.de
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 13 Sep 2026 15:49:41 -0400
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

This series extends the RX target with RXv2 and RXv3 CPU support,
forming the foundation for the RX65N, RX651, and RX72M machine models.

The first patch adds the CPU definitions, instruction support, and
translator changes required by the newer RX cores.

The second patch adds the initial RX machine and peripheral support.

Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
---
Sayyad Mahammad Umar (2):
      target/rx: add RXv2 and RXv3 CPU support
      hw/rx: add common RX peripherals

 MAINTAINERS                           |   20 +
 hw/adc/renesas_s12ad.c                |  324 +++++++++
 hw/dma/renesas_rx_dmac.c              |  317 +++++++++
 hw/dma/renesas_rx_dtc.c               |  169 +++++
 hw/gpio/renesas_rx_gpio.c             |  256 +++++++
 hw/misc/renesas_rx_crc.c              |  219 ++++++
 hw/misc/renesas_rx_fcu.c              |  985 ++++++++++++++++++++++++++
 hw/misc/renesas_rx_romcache.c         |  139 ++++
 hw/misc/rx65n_sysclk.c                |  190 +++++
 hw/net/renesas_etherc.c               |  955 +++++++++++++++++++++++++
 hw/rtc/renesas_rx_rtc.c               |  330 +++++++++
 hw/ssi/renesas_rspi.c                 |  319 +++++++++
 hw/timer/renesas_mtu3.c               |  509 ++++++++++++++
 hw/watchdog/renesas_rx_wdt.c          |  193 ++++++
 include/hw/adc/renesas_s12ad.h        |   61 ++
 include/hw/dma/renesas_rx_dmac.h      |   57 ++
 include/hw/dma/renesas_rx_dtc.h       |   42 ++
 include/hw/gpio/renesas_rx_gpio.h     |   64 ++
 include/hw/misc/renesas_rx_crc.h      |   30 +
 include/hw/misc/renesas_rx_fcu.h      |  191 +++++
 include/hw/misc/renesas_rx_romcache.h |   30 +
 include/hw/misc/rx65n_sysclk.h        |   37 +
 include/hw/net/renesas_etherc.h       |  109 +++
 include/hw/rtc/renesas_rx_rtc.h       |   52 ++
 include/hw/ssi/renesas_rspi.h         |   61 ++
 include/hw/timer/renesas_mtu3.h       |   73 ++
 include/hw/watchdog/renesas_rx_wdt.h  |   48 ++
 target/rx/cpu-param.h                 |    3 +
 target/rx/cpu-qom.h                   |    2 +
 target/rx/cpu.c                       |   57 +-
 target/rx/cpu.h                       |  124 ++++
 target/rx/disas.c                     |  383 ++++++++++-
 target/rx/gdbstub.c                   |   44 +-
 target/rx/helper.c                    |   56 +-
 target/rx/helper.h                    |   22 +
 target/rx/insns.decode                |  125 +++-
 target/rx/meson.build                 |    6 +-
 target/rx/op_helper.c                 |  357 ++++++++++
 target/rx/translate.c                 | 1225 ++++++++++++++++++++++++++-------
 39 files changed, 7873 insertions(+), 311 deletions(-)
---
base-commit: ff1d2d19d7e24893e2012d879f8e73077e17b9bd
change-id: 20260913-umar-rx-series-0bfbbfe6b074

Best regards,
--  
Sayyad Mahammad Umar <contact@sayyadumar.com>


