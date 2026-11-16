Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDD4606E48F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rCxVS+8G
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSueQ-0003r4-HP; Mon, 16 Nov 2026 06:13:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueF-0003p0-Tu
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:19 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSueB-00027e-Hw
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 06:13:19 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-490d59c3edaso1957827f8f.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 03:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794827587; x=1795432387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ga/sbnWQ8Rp+xdNe/cHzOy1FCcskcCSsEElXR/zwWWM=;
 b=rCxVS+8Gm1rFLfwsHZ6QegHqFPx2i5fOn4FSZfg5yrZ/zXrB79ZQFTBm89G0VK7XBz
 8T5SdsQYTVpoewCWuOerldzlItMGVAnBmqkRgnEf6TG0HKo5VvWShaGNqpVuT57FY4kp
 OZp1EMtkSGOBcEImt7pAxE4fCNU7Vf7tqUydJJnHSZtQhbWOoXZOB7/SHlgIkkq3U7RA
 pUVljgAKjUHvLAg3UOSFidg0TWcQXt0/9RGdouFBGeH/54CvEKGY8BLkfiEVYv5nsc3t
 yKTFWFVCkV7lxCkV/CjXHGhv4pLZ7uIYzRDGN6w9NhbyD943E97YSmlHqen7FeVJ8LZ2
 splQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794827587; x=1795432387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ga/sbnWQ8Rp+xdNe/cHzOy1FCcskcCSsEElXR/zwWWM=;
 b=lun1IavqNi9DHTKVyyG8DXhv5tTlhw1cVjuM//4JU5Ly5XWtLyht+UYo0m4RVMpQ5F
 q5hGN5nKjHzeIRH0CBBsaAqTu90lwpWCuARRUfHL4xIr0t9OEOV2mOL8AHEtCzu4LDrG
 L8JtpFTEPBWkXXL3PwXWUzf1Xap+cLc9aNDtDENoVQV/X0nk+la5yMfn9OOUzqXXCcPh
 3lKO79kiyii3AWNSbnlfgNuGcCOX+sEznmlEa/KDM+mbAZCbi+8qMLLXllliDtU3zEIb
 ViO+1zD4EH7z1+wsbnn6IN19l76Uv98DJhU+X5hs1g/xSty9GDJtMA3LMsMhbtsv/sIy
 STtg==
X-Gm-Message-State: APuU4Z9kfbWd+UKMv1uu5rALhjiHd6h2fTYtZOb5cqlbMGjM0CeIqpba
 pCxITXATJ9e0bZVu3s+nOMMaHm5nNMDmJZa7fF3/JJLX1LA+8XDxK0vWAjnv7Jb0AtLaHq3HUvn
 tane/G/o=
X-Gm-Gg: AZFdTZdWF2rEY+/iqOnCl7Zs3iEt/dwIoBVDFwS6eZYeIwHWHhkEA/QKRyFJnuH3MBi
 9PvQrltMMeiLuAtLk5QSg+KtYUDqK2ExmOhF/3Cg8QsfHa+Px+Nx6TZ51ykD/pxD1Ik38/0DXca
 sFRYc+p/2M6rcx/l29Ge1JxuLMd665iuL/uRNzt8G9+cP2GBP7feZ6xexyLpbpQsCnkQ+XHoJyw
 GbspzOfy4vP5foSv48ebPINZ9CycsHr0haODVnl++4Q3Ble9GJ+v02qs6Lc5QlINMS+t5GCEy5C
 tfkwd+o6DFvsQ8VY2pcBB4xZX3yJj4WWn7cZ8teZksKwE6LF+zA0qnfbZuMtYElv94uu8Q1LMV4
 zXVnfONyt4HSoeeA5GBrDPgTheBj0Lf/OcSBDCOmI4IPHOLL221UXbNb+ZYr9fpbxM+zf2h+La/
 qfcuGG7F2g2CjcCG9J3NmclQfvYLtqVFZkiR4nYFlQwd9McHIq03LdXGbgDdjruIt15ndzzjc7D
 rkRb553wL355EOGn9l5AkWli+kV4akSLsvX7cpfLomjJiQONv9pochXazXJgOHlV4GtjQHxiFYO
 YpnwxgyQgsHrXfiWBe/4a+necVcOVmS7a8AJeGoA/hCV9amvZZgt6m8i8BS5WzwO/ze46cklLmN
 n2gGYXnY9yy+AkocC7s5t8eaiyzjraFFBh3dIb0uamDIxrcxnFYrNBeE=
X-Received: by 2002:a05:6000:4211:b0:498:364d:7509 with SMTP id
 ffacd0b85a97d-49b02d4cd48mr32112594f8f.24.1794827586600; 
 Mon, 16 Nov 2026 03:13:06 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c6d079a2asm19490469f8f.16.2026.11.16.03.13.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:13:05 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/33] hw/ssi/stm32f2xx_spi: avoid transferring data on DR reads
Date: Mon, 16 Nov 2026 11:12:31 +0000
Message-ID: <20261116111303.1692832-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116111303.1692832-1-peter.maydell@linaro.org>
References: <20261116111303.1692832-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Manuele Conti <conti.manuele@gmail.com>

Writing SPI_DR already performs the synchronous SSI transfer and stores
its response in spi_dr. Reading SPI_DR performs another transfer, using
the previous response as transmit data, and returns the new response.
Consequently a normal write/read pair clocks two frames on the bus and
can skip bytes in a peripheral's response.

Return the response saved by the write and clear RXNE without starting
another transfer. Repeated reads then leave the peripheral state alone.

Add a qtest using the upstream netduino2 machine and an M25P80 flash.
Check the JEDEC ID, RXNE clearing, and repeated DR reads. The test requires
no board changes and reproduces the unwanted extra transfers before the
fix.

Fixes: 5ae74402d1f ("STM32F2xx: Add the SPI device")
Signed-off-by: Manuele Conti <conti.manuele@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20261021065238.15220-1-conti.manuele@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                      |  1 +
 hw/ssi/stm32f2xx_spi.c           |  1 -
 tests/qtest/stm32f2xx-spi-test.c | 50 ++++++++++++++++++++++++++++++++
 tests/qtest/meson.build          |  2 ++
 4 files changed, 53 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/stm32f2xx-spi-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3d53e104c5b..15942aaba3a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1225,6 +1225,7 @@ F: hw/char/stm32f2xx_usart.c
 F: hw/timer/stm32f2xx_timer.c
 F: hw/adc/*
 F: hw/ssi/stm32f2xx_spi.c
+F: tests/qtest/stm32f2xx-spi-test.c
 F: include/hw/*/stm32*.h
 
 STM32F405
diff --git a/hw/ssi/stm32f2xx_spi.c b/hw/ssi/stm32f2xx_spi.c
index 871d57324d1..da1dbb7bd7a 100644
--- a/hw/ssi/stm32f2xx_spi.c
+++ b/hw/ssi/stm32f2xx_spi.c
@@ -82,7 +82,6 @@ static uint64_t stm32f2xx_spi_read(void *opaque, hwaddr addr,
     case STM_SPI_SR:
         return s->spi_sr;
     case STM_SPI_DR:
-        stm32f2xx_spi_transfer(s);
         s->spi_sr &= ~STM_SPI_SR_RXNE;
         return s->spi_dr;
     case STM_SPI_CRCPR:
diff --git a/tests/qtest/stm32f2xx-spi-test.c b/tests/qtest/stm32f2xx-spi-test.c
new file mode 100644
index 00000000000..619191cf6cc
--- /dev/null
+++ b/tests/qtest/stm32f2xx-spi-test.c
@@ -0,0 +1,50 @@
+/*
+ * STM32F2XX SPI controller tests
+ *
+ * Copyright (c) 2026 Manuele Conti <conti.manuele@gmail.com>
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+
+/* The first SSI bus found by -device belongs to SPI3. */
+#define SPI3_BASE 0x40003c00
+#define SPI_CR1   (SPI3_BASE + 0x00)
+#define SPI_SR    (SPI3_BASE + 0x08)
+#define SPI_DR    (SPI3_BASE + 0x0c)
+#define SPI_RXNE  (1U << 0)
+
+static void test_jedec_id(void)
+{
+    static const uint8_t jedec_id[] = { 0x20, 0x20, 0x14 };
+    QTestState *qts = qtest_init("-machine netduino2 "
+                               "-device m25p80,bus=ssi");
+
+    /* Enable SPI in master mode, with software slave management. */
+    qtest_writel(qts, SPI_CR1, (1U << 9) | (1U << 8) |
+                             (1U << 6) | (1U << 2));
+
+    qtest_writeb(qts, SPI_DR, 0x9f);
+    qtest_readb(qts, SPI_DR);
+
+    for (unsigned i = 0; i < ARRAY_SIZE(jedec_id); i++) {
+        qtest_writeb(qts, SPI_DR, 0);
+        g_assert_cmphex(qtest_readl(qts, SPI_SR) & SPI_RXNE, ==, SPI_RXNE);
+        g_assert_cmphex(qtest_readb(qts, SPI_DR), ==, jedec_id[i]);
+        g_assert_cmphex(qtest_readl(qts, SPI_SR) & SPI_RXNE, ==, 0);
+
+        /* Reading DR again must not clock another byte out of the flash. */
+        g_assert_cmphex(qtest_readb(qts, SPI_DR), ==, jedec_id[i]);
+        g_assert_cmphex(qtest_readl(qts, SPI_SR) & SPI_RXNE, ==, 0);
+    }
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/stm32f2xx/spi/jedec-id", test_jedec_id);
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 79946960869..626791d1eb4 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -258,6 +258,8 @@ qtests_exynos4210 = \
 qtests_arm = \
   (config_all_devices.has_key('CONFIG_OLIMEX_STM32_H405') ? \
    ['stm32f405-timer-test', 'stm32f405-rcc-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_NETDUINO2') and
+   config_all_devices.has_key('CONFIG_SSI_M25P80') ? ['stm32f2xx-spi-test'] : []) + \
   (config_all_devices.has_key('CONFIG_MPS2') ? ['sse-timer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_DUALTIMER') ? ['cmsdk-apb-dualtimer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_TIMER') ? ['cmsdk-apb-timer-test'] : []) + \
-- 
2.43.0


