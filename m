Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB2B606A31F
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 16:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL1WR-0001EW-7H; Sun, 25 Oct 2026 12:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL1WE-0001At-3X; Sun, 25 Oct 2026 12:56:26 -0400
Received: from www675.your-server.de ([85.10.213.182])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <contact@sayyadumar.com>)
 id 1xL1WA-0004c3-VS; Sun, 25 Oct 2026 12:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sayyadumar.com; s=default2511; h=Cc:To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-Id:Date:Subject:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References;
 bh=bsVjyydiWDKCd3s2z3M1h3s2NL4zJWfEFTPZ6BOISNY=; b=AbdkbXDpHrxZu97WDeC/OghAmP
 Pa/Sz2Yurd+I7aVScyuZc2fiuiDBMhR7jHsjY7cmWrdT+OD15PuP18P8fmUxEeXauZ4zcBpql9biN
 hbhyxQLBYGxwF06QLAOqKXc6EJyMNHgCxdkp/SEmhhNeiCeNlFovNUuNZgxtHmsOQxKjGWJ4qcIok
 JXPuDClfKHmn0ADAm8Fmsk7b12kJwYE30OI8apQVAOGo46smViFO9x3/b/UmuLL4PjCl2FINn1YJq
 jOUmLgqsq1yes5o7UYpdIc+z/ezX+29Ecwpnrbn66ZJKWCzU1WLsoKyVpP8e+yVhzGwA6DDL1MssL
 lZiu9IEQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www675.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vv-0006kL-01; Sun, 25 Oct 2026 17:56:07 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <contact@sayyadumar.com>)
 id 1xL1Vv-000OzG-0X; Sun, 25 Oct 2026 17:56:06 +0100
From: Sayyad Mahammad Umar <contact@sayyadumar.com>
Subject: [PATCH v2 00/31] target/rx: add RXv2/RXv3 CPU support and RX
 peripherals
Date: Sun, 25 Oct 2026 17:55:16 +0100
Message-Id: <20261025-umar-rx-series-v2-0-9e846577cad0@sayyadumar.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6CMBBFf4XM2jEtAoor/8Ow6GMqNeGRFgiE9
 N9tYe3yJOeeu4MnZ8nDM9vB0WK9HfoI+SUD1Yr+Q2h1ZMhZXrGa33DuhEO34rlDJo2UhirJ7gX
 E0ejI2PUIvpuT/Sy/pKZUSUZr/TS47XhcePL+xheODEtRPgouSs2pfnmxbUIn7aqGDpoQwg9O7
 Gb5wwAAAA==
X-Change-ID: 20260913-umar-rx-series-0bfbbfe6b074
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Alistair Francis <alistair@alistair23.me>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowangio@gmail.com>, 
 qemu-arm@nongnu.org, Sayyad Mahammad Umar <contact@sayyadumar.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792947366; l=6595;
 i=contact@sayyadumar.com; s=qemu; h=from:subject:message-id;
 bh=W5feqGuI8vZoyoOyqPnEAxMo62yKzhJEEMP7MaG6PFA=;
 b=1IfCcOGiXUlfqxL86E/4PA+acd4IzKkkDjVCVa5cPqqZjula/Rrlq9pcMCsOb/37KKsDtpbl4
 U1yn3lFBTIfC0LdVALgs98Uo8KZsCpH2OojgEdHXlySNWU1xzRcOEE0
X-Developer-Key: i=contact@sayyadumar.com; a=ed25519;
 pk=CsAjTLRCB7+pnzmj8902JER4gL8CTzNQFxlMZTl4wDk=
X-Virus-Scanned: Clear (ClamAV 1.4.6/28164/Sun Oct 25 07:24:12 2026)
Received-SPF: pass client-ip=85.10.213.182;
 envelope-from=contact@sayyadumar.com; helo=www675.your-server.de
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 TRACKER_ID=0.1 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,TRACKER_ID,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series extends the RX target with RXv2 and RXv3 CPU support and
adds the common RX65N/RX72M peripherals, forming the foundation for
the RX65N, RX651 and RX72M machine models.

Patches 1-3 add the CPU models and small changes to existing code:
the EXTB exception vector base and the interrupt dispatch cleanup.
Patches 4-18 add the new instructions in small groups: the RXv2
unsigned FPU conversions and accumulator moves, and the RXv3 DPFPU,
the DMOV extensions, BFMOV, SAVE/RSTR register banks and the
three-operand XOR.

Patches 19-31 add the peripherals, one device per patch, each wired
into meson and Kconfig and enabled in the rx-softmmu default config
so the series is compile-tested at every step. A follow-up series
will add the machine models that instantiate them.

The next patch series will include the board models for rsk-rx65n-2mb,
rsk-rx72m and rx660-tb evaluation boards. The changes in this patch series are
already tested with the real example project firmware from Renesas
compiled with CC-RX V3.08. 

Signed-off-by: Sayyad Mahammad Umar <contact@sayyadumar.com>
---
Changes in v2:
- Split the two large patches into 31 patches: one per instruction
  group and one per device.
- Wire every new device into meson.build and Kconfig and enable it
  in configs/devices/rx-softmmu/default.mak; in v1 the device code
  was not part of the build at all.
- Drop the unrelated TCGv/gdb accessor renames so each patch only
  touches its own subject.
- Every patch builds independently (ninja qemu-system-rx).
- Link to v1: https://lore.kernel.org/qemu-devel/20260913-umar-rx-series-v1-0-5a5841a5d1e9@sayyadumar.com

To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alistair Francis <alistair@alistair23.me>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>

---
Sayyad Mahammad Umar (31):
      target/rx: add RXv2/RXv3 CPU models
      target/rx: add EXTB exception vector base register
      target/rx: drop plugin interrupt callbacks
      target/rx: add RXv3 DPFPU architecture state
      target/rx: add FTOU and UTOF (RXv2)
      target/rx: add DPFPU arithmetic instructions
      target/rx: add DPFPU unary operations
      target/rx: add DPFPU conversions DTOI, DTOU and DTOF
      target/rx: add DPFPU conversions ITOD, UTOD and FTOD
      target/rx: add DPUSHM and DPOPM
      target/rx: add RXv3 DMOV half transfers
      target/rx: add DPFPU control register transfers
      target/rx: add RXv3 DMOV immediate forms
      target/rx: add RXv3 DMOV.D memory forms
      target/rx: add RXv3 BFMOV and BFMOVZ
      target/rx: add RXv3 register bank SAVE and RSTR
      target/rx: add RXv3 three-operand XOR
      target/rx: add RXv2 accumulator context save/restore
      hw/timer: add Renesas RX MTU3
      hw/gpio: add Renesas RX GPIO and MPC
      hw/dma: add Renesas RX DMAC
      hw/dma: add Renesas RX DTC
      hw/adc: add Renesas RX S12AD
      hw/ssi: add Renesas RX RSPI
      hw/rtc: add Renesas RX RTC
      hw/misc: add Renesas RX CRC calculator
      hw/misc: add Renesas RX ROM cache control registers
      hw/misc: add Renesas RX flash control unit
      hw/misc: add RX65N clock generation circuit
      hw/net: add Renesas RX ETHERC and EDMAC
      hw/watchdog: add Renesas RX WDT and IWDT

 MAINTAINERS                            |  26 +
 configs/devices/rx-softmmu/default.mak |  13 +
 hw/adc/Kconfig                         |   3 +
 hw/adc/meson.build                     |   1 +
 hw/adc/renesas_s12ad.c                 | 324 +++++++++++
 hw/dma/Kconfig                         |   8 +-
 hw/dma/meson.build                     |   2 +
 hw/dma/renesas_rx_dmac.c               | 317 +++++++++++
 hw/dma/renesas_rx_dtc.c                | 169 ++++++
 hw/gpio/Kconfig                        |   3 +
 hw/gpio/meson.build                    |   1 +
 hw/gpio/renesas_rx_gpio.c              | 256 +++++++++
 hw/misc/Kconfig                        |  12 +
 hw/misc/meson.build                    |   4 +
 hw/misc/renesas_rx_crc.c               | 219 ++++++++
 hw/misc/renesas_rx_fcu.c               | 985 +++++++++++++++++++++++++++++++++
 hw/misc/renesas_rx_romcache.c          | 139 +++++
 hw/misc/rx65n_sysclk.c                 | 190 +++++++
 hw/net/Kconfig                         |   3 +
 hw/net/meson.build                     |   1 +
 hw/net/renesas_etherc.c                | 955 ++++++++++++++++++++++++++++++++
 hw/rtc/Kconfig                         |   3 +
 hw/rtc/meson.build                     |   1 +
 hw/rtc/renesas_rx_rtc.c                | 330 +++++++++++
 hw/ssi/Kconfig                         |   4 +
 hw/ssi/meson.build                     |   1 +
 hw/ssi/renesas_rspi.c                  | 319 +++++++++++
 hw/timer/Kconfig                       |   2 +
 hw/timer/meson.build                   |   1 +
 hw/timer/renesas_mtu3.c                | 509 +++++++++++++++++
 hw/watchdog/Kconfig                    |   3 +
 hw/watchdog/meson.build                |   1 +
 hw/watchdog/renesas_rx_wdt.c           | 193 +++++++
 include/hw/adc/renesas_s12ad.h         |  61 ++
 include/hw/dma/renesas_rx_dmac.h       |  57 ++
 include/hw/dma/renesas_rx_dtc.h        |  42 ++
 include/hw/gpio/renesas_rx_gpio.h      |  64 +++
 include/hw/misc/renesas_rx_crc.h       |  30 +
 include/hw/misc/renesas_rx_fcu.h       | 191 +++++++
 include/hw/misc/renesas_rx_romcache.h  |  30 +
 include/hw/misc/rx65n_sysclk.h         |  37 ++
 include/hw/net/renesas_etherc.h        | 109 ++++
 include/hw/rtc/renesas_rx_rtc.h        |  52 ++
 include/hw/ssi/renesas_rspi.h          |  61 ++
 include/hw/timer/renesas_mtu3.h        |  73 +++
 include/hw/watchdog/renesas_rx_wdt.h   |  48 ++
 target/rx/cpu-qom.h                    |   2 +
 target/rx/cpu.c                        |  55 ++
 target/rx/cpu.h                        | 122 ++++
 target/rx/disas.c                      | 367 ++++++++++++
 target/rx/helper.c                     |  55 +-
 target/rx/helper.h                     |  22 +
 target/rx/insns.decode                 | 125 ++++-
 target/rx/op_helper.c                  | 357 ++++++++++++
 target/rx/translate.c                  | 748 ++++++++++++++++++++++++-
 55 files changed, 7669 insertions(+), 37 deletions(-)
---
base-commit: d73149283205645625bfa9fe029cfb68e4c4a9ae
change-id: 20260913-umar-rx-series-0bfbbfe6b074

Best regards,
--  
Sayyad Mahammad Umar <contact@sayyadumar.com>


