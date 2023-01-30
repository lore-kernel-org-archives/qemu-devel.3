Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CA6C56206
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 15:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtS7u-0005sC-6Z; Fri, 20 Feb 2026 10:09:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1vtS26-00087z-5T; Fri, 20 Feb 2026 10:03:07 -0500
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1vtS24-0002J4-8g; Fri, 20 Feb 2026 10:03:05 -0500
DKIM-Signature: a=rsa-sha256; bh=fYomp+aGUznWhaP+Te2FfkZ0k+Rqrbj8Q85aJKAFHgk=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1771599781; v=1;
 b=NpZDTX4LEImvhDeBXxNMpLX5P105CsVfnwjFbuTQmK1ypI47wCAGfBDnMW0eg6QweOMpl4Qq
 dMph0k6cL2tkIu+VkT9BijBd7p4GREyQgswAM0KMgWMcAsvrYNfhXPDbLwit4CmbgQYLF9MQpcn
 rOdCqHrKqSygfdEEXWG6vySKyumPGejlyxzouQLb00+SmbPUV1YnxAH0G34yC4jhYFgREj5jPym
 jXKDNU5BLAILgG5s9wMtnH4Oz3PiKvC9MegOQbCi5IaDzf7nH3XxEUG6okSU6l5ki89RIy0ZqVK
 xqIMUysITOjjtZea9pJ7sgrYR0Na4jAC6+GM/7al6x77Q==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id BF9B725018;
 Fri, 20 Feb 2026 15:03:01 +0000 (UTC)
From: ~lexbaileylowrisc <lexbaileylowrisc@git.sr.ht>
Date: Mon, 30 Jan 2023 13:14:50 +0100
Subject: [PATCH qemu 02/11] [ot] hw/char, hw/timer,
 hw/ssi: fix device definitions
Message-ID: <177159976712.8279.7732381632410882915-2@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <177159976712.8279.7732381632410882915-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Daniel =?utf-8?q?P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 lowRISC <qemu-maintainers@lowrisc.org>, nabihestefan@google.com,
 Amit Kumar-Hermosillo <amitkh@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 20 Feb 2026 10:09:01 -0500
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
Reply-To: ~lexbaileylowrisc <lex.bailey@lowrisc.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Emmanuel Blot <eblot@rivosinc.com>

Use a separate Kconfig symbols for Ibex UART, Timer, and SPI devices:
having an Ibex CPU does not imply usage of these specific implementations.

Signed-off-by: Emmanuel Blot <eblot@rivosinc.com>
---
 hw/char/Kconfig       | 3 +++
 hw/char/meson.build   | 2 +-
 hw/riscv/Kconfig      | 3 +++
 hw/ssi/Kconfig        | 4 ++++
 hw/ssi/meson.build    | 2 +-
 hw/timer/Kconfig      | 3 +++
 hw/timer/ibex_timer.c | 2 +-
 hw/timer/meson.build  | 2 +-
 8 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 020c0a84bb..0cbbaedb2f 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -95,3 +95,6 @@ config IP_OCTAL_232
     bool
     default y
     depends on IPACK
+
+config IBEX_UART
+    bool
diff --git a/hw/char/meson.build b/hw/char/meson.build
index a9e1dc26c0..f47fa11bbe 100644
--- a/hw/char/meson.build
+++ b/hw/char/meson.build
@@ -2,7 +2,7 @@ system_ss.add(when: 'CONFIG_CADENCE', if_true: files('cadence=
_uart.c'))
 system_ss.add(when: 'CONFIG_CMSDK_APB_UART', if_true: files('cmsdk-apb-uart.=
c'))
 system_ss.add(when: 'CONFIG_ESCC', if_true: files('escc.c'))
 system_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_apbuart.c'))
-system_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_uart.c'))
+system_ss.add(when: 'CONFIG_IBEX_UART', if_true: files('ibex_uart.c'))
 system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_serial.c'))
 system_ss.add(when: 'CONFIG_IP_OCTAL_232', if_true: files('ipoctal232.c'))
 system_ss.add(when: 'CONFIG_ISA_BUS', if_true: files('parallel-isa.c'))
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 0222c93f87..e6aa32ee8f 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -38,6 +38,9 @@ config OPENTITAN
     default y
     depends on RISCV32
     select IBEX
+    select IBEX_SPI_HOST
+    select IBEX_TIMER
+    select IBEX_UART
     select SIFIVE_PLIC
     select UNIMP
=20
diff --git a/hw/ssi/Kconfig b/hw/ssi/Kconfig
index 1bd56463c1..c8d573eeb9 100644
--- a/hw/ssi/Kconfig
+++ b/hw/ssi/Kconfig
@@ -32,3 +32,7 @@ config PNV_SPI
 config ALLWINNER_A10_SPI
     bool
     select SSI
+
+config IBEX_SPI_HOST
+    bool
+    select SSI
diff --git a/hw/ssi/meson.build b/hw/ssi/meson.build
index 6afb1ea200..a3ba319280 100644
--- a/hw/ssi/meson.build
+++ b/hw/ssi/meson.build
@@ -10,6 +10,6 @@ system_ss.add(when: 'CONFIG_XILINX_SPI', if_true: files('xi=
linx_spi.c'))
 system_ss.add(when: 'CONFIG_XILINX_SPIPS', if_true: files('xilinx_spips.c'))
 system_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal-ospi.c=
'))
 system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_spi.c'))
-system_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_spi_host.c'))
+system_ss.add(when: 'CONFIG_IBEX_SPI_HOST', if_true: files('ibex_spi_host.c'=
))
 system_ss.add(when: 'CONFIG_BCM2835_SPI', if_true: files('bcm2835_spi.c'))
 system_ss.add(when: 'CONFIG_PNV_SPI', if_true: files('pnv_spi.c'))
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index b3d823ce2c..2fdefd0d1f 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -65,3 +65,6 @@ config STELLARIS_GPTM
=20
 config AVR_TIMER16
     bool
+
+config IBEX_TIMER
+    bool
diff --git a/hw/timer/ibex_timer.c b/hw/timer/ibex_timer.c
index ee18652189..858e1a67de 100644
--- a/hw/timer/ibex_timer.c
+++ b/hw/timer/ibex_timer.c
@@ -31,7 +31,7 @@
 #include "hw/timer/ibex_timer.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
-#include "target/riscv/cpu.h"
+#include "hw/core/registerfields.h"
 #include "migration/vmstate.h"
=20
 REG32(ALERT_TEST, 0x00)
diff --git a/hw/timer/meson.build b/hw/timer/meson.build
index 178321c029..cc02aa0dda 100644
--- a/hw/timer/meson.build
+++ b/hw/timer/meson.build
@@ -30,7 +30,7 @@ system_ss.add(when: 'CONFIG_SSE_TIMER', if_true: files('sse=
-timer.c'))
 system_ss.add(when: 'CONFIG_STELLARIS_GPTM', if_true: files('stellaris-gptm.=
c'))
 system_ss.add(when: 'CONFIG_STM32F2XX_TIMER', if_true: files('stm32f2xx_time=
r.c'))
 system_ss.add(when: 'CONFIG_XILINX', if_true: files('xilinx_timer.c'))
-specific_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_timer.c'))
+system_ss.add(when: 'CONFIG_IBEX_TIMER', if_true: files('ibex_timer.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_PWM', if_true: files('sifive_pwm.c'))
=20
 specific_ss.add(when: 'CONFIG_AVR_TIMER16', if_true: files('avr_timer16.c'))
--=20
2.49.1


