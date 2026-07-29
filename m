Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF68C54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 11:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp2rj-0006Aq-33; Wed, 29 Jul 2026 07:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xinxie908@gmail.com>)
 id 1wp20o-00019p-53
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 06:59:47 -0400
Received: from mail-pj2-x0a.google.com ([2607:f8b0:4864:39::a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xinxie908@gmail.com>)
 id 1wp20j-0004Ed-S3
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 06:59:43 -0400
Received: by mail-pj2-x0a.google.com with SMTP id
 d9443c01a7336-2cf5e516e67so4615125ad.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 03:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785322780; x=1785927580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nCnQwREZ46dN0HG8gxHxD1hzR7ICebA42h1seeieyfA=;
 b=qtH8/WtqL4PDwMlXHW3gc2bcpViR/g/0Gcwkzmunlwvo1QxRBQgNjrbZ6Y7tGCnkuv
 o0zNWGfYCs3GXzOoknY6Cag4pf/f3YGhQR/jlsnufT2gQfsCBfT/CCgdkqNcc1ByFzCX
 3JwaZsAn8m/D+F02EEkgO7W/fQsK/kQl44QwycFo8te2AvxXmIcO4WrZIuS9WuKbuzlw
 vAokqduynREEcDk+ZhIN4BSEBlrqQILrfaLkKenb77dU7eLhPWuVh8NMI/94xn26/jk1
 fBGt5jsbP3FFxbJDfqgZta4Bs9nAqryokJp71pdFPyBTbcDxFFl5jf52ZgoeHH9jduY8
 8UnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785322780; x=1785927580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nCnQwREZ46dN0HG8gxHxD1hzR7ICebA42h1seeieyfA=;
 b=Cx9dzpxONW+kIPP3XAG96yrPpnKJ+SH85RVKNQVDwNR7gHz8y5b447670JoVvK9Vg3
 gCQ2yR4j5v1XnU70pwaHQuDaEndi7haBFt2matyC5Jkpv5Fj4xezQyWk+k3s5B7jLVQi
 6mM2z45eIV0bEMqzAFjgjZxLFVXWWKrid2t1W3848xdsEQ6zJSai++hcmi3mw/W/WWXz
 hQRcwJN+RgBKLNx43gQdf3Wn0dEOsdnL+aaq90o+Uk8kZfvVBa8zU7wY8/M5cv1/Hx3a
 SDzD9JsC0AnjKfWWc/k2p7mX61m8K+/ZRMDEBULyezWRL+/iZ3ou54xJJdE/s51ZWQxu
 fDLQ==
X-Gm-Message-State: AOJu0Ywri+7KPQWTJBjo9AVxAfY+ix1WCosIpn7BdMuLsBw9FjjAR6yr
 BFkQOoGFngyM6N6Ij333Tia2JzmMkRRaIBjfdglcA2LXm/YI+1RK6NtqS08b47QWIxigow==
X-Gm-Gg: AR+sD13yv8VkjNOYo3Q5o7Dks06uiXJ1ptUfzjR4jegto8rtKQQmDsYp+FI+LQe3w7K
 jYpzs41d/pvDFDloFUhi2YGZgUysBXKWQspVLnRQey2Ksm7ohkUyW7imgmD17G7LBim/YSZHqYn
 3qa0wBR1XTTHKAXlWKCNP5tlj2skd3F/KffesS8qsAkjDOrzzJaKtuoku0D9hJmcWNwHIXsK3Ub
 k2ikqONHIGqfz0wmkX349hDq+Jm8RLkw70ECSsp/03cuwl0H2zBUHTml6bKtqxm2BRyBJdeI04l
 yiaq2l5tWiB8u22lLvJ5BLvti7oaJoQEeozhtNreH3fTOjoTnON9398EO7Ae5jGAUO4wQBe+RWf
 FOzruF+HzxvtG4GbQfvZ7SXUNT2B4YUbEPIeS0Dyf4o+YHpjSqHr0+VKBmcIvojsk5AlwzOVN+m
 oiC7QInUiu9ecR5U1VnLmAFe5NMGXmTUcfh/j7zI6quUFIQ9S0vmDRBlAU7tIWRvoF0hCptgjg9
 y7B6p8/ZGOOcEmnKZ36
X-Received: by 2002:a17:902:ce05:b0:2ce:9c48:22d3 with SMTP id
 d9443c01a7336-2d015c3e0bbmr77503815ad.11.1785322780446; 
 Wed, 29 Jul 2026 03:59:40 -0700 (PDT)
Received: from LAPTOP-LOCIFOSI.localdomain ([123.127.39.254])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022bfa240sm9627135ad.65.2026.07.29.03.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 03:59:39 -0700 (PDT)
From: Xin Xie <xinxie908@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Xin Xie <xinxie908@gmail.com>
Subject: [PATCH v1 3/3] tests/qtest: add K230 SDHCI tests
Date: Wed, 29 Jul 2026 18:59:03 +0800
Message-ID: <20260729105904.272939-4-xinxie908@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729105904.272939-1-xinxie908@gmail.com>
References: <20260729105904.272939-1-xinxie908@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::a;
 envelope-from=xinxie908@gmail.com; helo=mail-pj2-x0a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 29 Jul 2026 07:54:24 -0400
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

Add qtests covering the K230-specific SDHCI register layout, capability
masking, preset values, extension pointers, PHY power status and
per-controller vendor register storage.

Verify card detection and interrupt delivery through the K230 PLIC.
Exercise basic PIO reads and writes with an attached SD card image and
check that written data reaches the backing file.

Signed-off-by: Xin Xie <xinxie908@gmail.com>
---
 MAINTAINERS                   |   1 +
 tests/qtest/k230-sdhci-test.c | 214 ++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build       |   5 +-
 3 files changed, 219 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/k230-sdhci-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 06285352c4..99c4c3294b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1831,6 +1831,7 @@ F: include/hw/riscv/k230.h
 F: include/hw/watchdog/k230_wdt.h
 F: include/hw/sd/k230_sdhci.h
 F: tests/qtest/k230-wdt-test.c
+F: tests/qtest/k230-sdhci-test.c
 
 RX Machines
 -----------
diff --git a/tests/qtest/k230-sdhci-test.c b/tests/qtest/k230-sdhci-test.c
new file mode 100644
index 0000000000..5eedb130c3
--- /dev/null
+++ b/tests/qtest/k230-sdhci-test.c
@@ -0,0 +1,214 @@
+/*
+ * QTest testcase for the Kendryte K230 SDHCI controllers
+ *
+ * Copyright (c) 2026 Xin Xie <xinxie908@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/timer.h"
+#include "qemu/units.h"
+#include "libqtest.h"
+#include "libqos/sdhci-cmd.h"
+#include "hw/sd/k230_sdhci.h"
+#include "hw/sd/sdhci-internal.h"
+
+#define K230_SD0_BASE          0x91580000
+#define K230_SD1_BASE          0x91581000
+#define K230_PLIC_PENDING      0xf00001000ULL
+#define K230_SD1_IRQ           144
+
+#define K230_SD_TEST_IMAGE_SIZE (2 * MiB)
+#define K230_SD_TEST_BLOCK_SIZE 512
+
+static void test_registers(void)
+{
+    QTestState *qts = qtest_init("-machine k230");
+    uint64_t capabilities;
+    uint64_t expected = K230_SDHCI_CAPAREG_RESET;
+
+    /* Only capabilities unsupported by the QEMU model are removed. */
+    expected = FIELD_DP64(expected, SDHC_CAPAB, ASYNC_INT, 0);
+    expected = FIELD_DP64(expected, SDHC_CAPAB, TIMER_RETUNING, 0);
+    expected = FIELD_DP64(expected, SDHC_CAPAB, RETUNING_MODE, 0);
+    expected = FIELD_DP64(expected, SDHC_CAPAB, ADMA3, 0);
+    capabilities = qtest_readq(qts, K230_SD0_BASE + SDHC_CAPAB);
+    g_assert_cmphex(capabilities, ==, expected);
+
+    /* Preset Value registers use the TRM reset values and are read-only. */
+    g_assert(qtest_readw(qts, K230_SD0_BASE + K230_SDHCI_PRESET_INIT) ==
+             K230_SDHCI_PRESET_INIT_RESET);
+    g_assert(qtest_readw(qts, K230_SD0_BASE +
+                         K230_SDHCI_PRESET_DEFAULT_SPEED) ==
+             K230_SDHCI_PRESET_DEFAULT_SPEED_RESET);
+    g_assert(qtest_readw(qts, K230_SD0_BASE +
+                         K230_SDHCI_PRESET_HIGH_SPEED) ==
+             K230_SDHCI_PRESET_HIGH_SPEED_RESET);
+    g_assert(qtest_readw(qts, K230_SD0_BASE + K230_SDHCI_PRESET_SDR12) ==
+             K230_SDHCI_PRESET_SDR12_RESET);
+    g_assert(qtest_readw(qts, K230_SD0_BASE + K230_SDHCI_PRESET_SDR25) ==
+             K230_SDHCI_PRESET_SDR25_RESET);
+    g_assert(qtest_readw(qts, K230_SD0_BASE + K230_SDHCI_PRESET_SDR50) ==
+             K230_SDHCI_PRESET_SDR50_RESET);
+    g_assert(qtest_readw(qts, K230_SD0_BASE + K230_SDHCI_PRESET_SDR104) ==
+             K230_SDHCI_PRESET_SDR104_RESET);
+    g_assert(qtest_readw(qts, K230_SD0_BASE + K230_SDHCI_PRESET_DDR50) ==
+             K230_SDHCI_PRESET_DDR50_RESET);
+
+    qtest_writew(qts, K230_SD0_BASE + K230_SDHCI_PRESET_SDR50, 0xffff);
+    g_assert(qtest_readw(qts, K230_SD0_BASE + K230_SDHCI_PRESET_SDR50) ==
+             K230_SDHCI_PRESET_SDR50_RESET);
+
+    /* Extension-area pointers use their documented read-only reset values. */
+    g_assert(qtest_readw(qts, K230_SD0_BASE + K230_SDHCI_P_UHS2_SETTINGS) ==
+             K230_SDHCI_P_UHS2_SETTINGS_RESET);
+    g_assert(qtest_readw(qts, K230_SD0_BASE + K230_SDHCI_P_UHS2_HOST_CAPAB) ==
+             K230_SDHCI_P_UHS2_HOST_CAPAB_RESET);
+    g_assert(qtest_readw(qts, K230_SD0_BASE + K230_SDHCI_P_UHS2_TEST) ==
+             K230_SDHCI_P_UHS2_TEST_RESET);
+    g_assert(qtest_readw(qts, K230_SD0_BASE + K230_SDHCI_P_EMBEDDED_CNTRL) ==
+             K230_SDHCI_P_EMBEDDED_CNTRL_RESET);
+    g_assert(qtest_readw(qts, K230_SD0_BASE + K230_SDHCI_P_VENDOR_AREA1) ==
+             K230_SDHCI_P_VENDOR_AREA1_RESET);
+    g_assert(qtest_readw(qts, K230_SD0_BASE + K230_SDHCI_P_VENDOR_AREA2) ==
+             K230_SDHCI_P_VENDOR_AREA2_RESET);
+
+    qtest_writew(qts, K230_SD0_BASE + K230_SDHCI_P_VENDOR_AREA1, 0xffff);
+    g_assert(qtest_readw(qts, K230_SD0_BASE + K230_SDHCI_P_VENDOR_AREA1) ==
+             K230_SDHCI_P_VENDOR_AREA1_RESET);
+
+    /* The virtual PHY is always ready and software cannot clear PWRGOOD. */
+    g_assert((qtest_readl(qts, K230_SD0_BASE + K230_SDHCI_PHY_CNFG) &
+              K230_SDHCI_PHY_CNFG_PWRGOOD) == K230_SDHCI_PHY_CNFG_PWRGOOD);
+    qtest_writel(qts, K230_SD0_BASE + K230_SDHCI_PHY_CNFG, 0);
+    g_assert(qtest_readl(qts, K230_SD0_BASE + K230_SDHCI_PHY_CNFG) ==
+             K230_SDHCI_PHY_CNFG_PWRGOOD);
+
+    /* Vendor storage is writable and private to each controller instance. */
+    qtest_writel(qts, K230_SD0_BASE + K230_SDHCI_P_VENDOR_AREA1_RESET,
+                 0x89abcdef);
+    g_assert(qtest_readl(qts, K230_SD0_BASE +
+                         K230_SDHCI_P_VENDOR_AREA1_RESET) ==
+             0x89abcdef);
+    g_assert(qtest_readl(qts, K230_SD1_BASE +
+                         K230_SDHCI_P_VENDOR_AREA1_RESET) == 0);
+
+    qtest_quit(qts);
+}
+
+static void test_card_detect(void)
+{
+    g_autofree char *path = NULL;
+    int fd = g_file_open_tmp("k230-sd-XXXXXX.img", &path, NULL);
+    QTestState *qts;
+
+    g_assert(fd >= 0);
+    g_assert(ftruncate(fd, K230_SD_TEST_IMAGE_SIZE) == 0);
+    close(fd);
+
+    qts = qtest_initf("-machine k230 "
+                      "-drive if=sd,index=1,format=raw,file=%s", path);
+
+    /* Card insertion becomes visible after the generic insertion delay. */
+    qtest_clock_step(qts, NANOSECONDS_PER_SECOND);
+    g_assert((qtest_readl(qts, K230_SD1_BASE + SDHC_PRNSTS) &
+              SDHC_CARD_PRESENT) == SDHC_CARD_PRESENT);
+    g_assert((qtest_readl(qts, K230_SD0_BASE + SDHC_PRNSTS) &
+              SDHC_CARD_PRESENT) == 0);
+
+    /* Route a command-complete event through SDHCI to the K230 PLIC. */
+    qtest_writew(qts, K230_SD1_BASE + SDHC_NORINTSTSEN,
+                 SDHC_NISEN_CMDCMP);
+    qtest_writew(qts, K230_SD1_BASE + SDHC_NORINTSIGEN,
+                 SDHC_NISEN_CMDCMP);
+    g_assert((qtest_readw(qts, K230_SD1_BASE + SDHC_NORINTSTSEN) &
+              SDHC_NISEN_CMDCMP) != 0);
+    g_assert((qtest_readw(qts, K230_SD1_BASE + SDHC_NORINTSIGEN) &
+              SDHC_NISEN_CMDCMP) != 0);
+    qtest_writew(qts, K230_SD1_BASE + SDHC_CLKCON,
+                 SDHC_CLOCK_INT_EN | SDHC_CLOCK_SDCLK_EN);
+    qtest_writew(qts, K230_SD1_BASE + SDHC_CMDREG,
+                 SDHC_APP_CMD | SDHC_CMD_RESPONSE);
+    g_assert((qtest_readw(qts, K230_SD1_BASE + SDHC_NORINTSTS) &
+              SDHC_NIS_CMDCMP) != 0);
+    g_assert((qtest_readl(qts, K230_PLIC_PENDING +
+                          K230_SD1_IRQ / 32 * sizeof(uint32_t)) &
+              BIT(K230_SD1_IRQ % 32)) != 0);
+
+    qtest_quit(qts);
+    unlink(path);
+}
+
+static void k230_sdhci_select_card(QTestState *qts)
+{
+    uint16_t rca;
+
+    /* Reset the controller and enable its internal and SD clocks. */
+    qtest_writeb(qts, K230_SD1_BASE + SDHC_SWRST, SDHC_RESET_ALL);
+    qtest_writew(qts, K230_SD1_BASE + SDHC_CLKCON,
+                 SDHC_CLOCK_INT_EN | SDHC_CLOCK_INT_STABLE |
+                 SDHC_CLOCK_SDCLK_EN);
+
+    /* Run the SD identification sequence and select the assigned RCA. */
+    sdhci_cmd_regs(qts, K230_SD1_BASE, 0, 0, 0, 0, SDHC_APP_CMD);
+    sdhci_cmd_regs(qts, K230_SD1_BASE, 0, 0, 0x41200000, 0, 41 << 8);
+    sdhci_cmd_regs(qts, K230_SD1_BASE, 0, 0, 0, 0, SDHC_ALL_SEND_CID);
+    sdhci_cmd_regs(qts, K230_SD1_BASE, 0, 0, 0, 0,
+                   SDHC_SEND_RELATIVE_ADDR | SDHC_CMD_RESPONSE);
+    rca = qtest_readl(qts, K230_SD1_BASE + SDHC_RSPREG0) >> 16;
+    sdhci_cmd_regs(qts, K230_SD1_BASE, 0, 0, rca << 16, 0,
+                   SDHC_SELECT_DESELECT_CARD);
+}
+
+static void test_card_io(void)
+{
+    static const char read_data[] = "K230 SDHCI read";
+    static const char write_data[] = "K230 SDHCI write";
+    g_autofree char *path = NULL;
+    char buffer[K230_SD_TEST_BLOCK_SIZE];
+    int fd = g_file_open_tmp("k230-sd-XXXXXX.img", &path, NULL);
+    QTestState *qts;
+
+    /* Seed block zero so the controller read can be checked independently. */
+    g_assert(fd >= 0);
+    g_assert(ftruncate(fd, K230_SD_TEST_IMAGE_SIZE) == 0);
+    g_assert(pwrite(fd, read_data, sizeof(read_data), 0) == sizeof(read_data));
+    close(fd);
+
+    qts = qtest_initf("-machine k230 "
+                      "-drive if=sd,index=1,format=raw,auto-read-only=off,"
+                      "file=%s", path);
+    k230_sdhci_select_card(qts);
+
+    /* Read block zero through the SDHCI PIO data port. */
+    memset(buffer, 0, sizeof(buffer));
+    g_assert(sdhci_read_cmd(qts, K230_SD1_BASE, buffer,
+                            sizeof(read_data)) == sizeof(read_data));
+    g_assert(memcmp(buffer, read_data, sizeof(read_data)) == 0);
+
+    /* Write through SDHCI, then verify the data reached the backing image. */
+    sdhci_write_cmd(qts, K230_SD1_BASE, write_data, sizeof(write_data),
+                    K230_SD_TEST_BLOCK_SIZE);
+    qtest_quit(qts);
+
+    fd = open(path, O_RDONLY);
+    g_assert(fd >= 0);
+    memset(buffer, 0, sizeof(buffer));
+    g_assert(pread(fd, buffer, sizeof(write_data), 0) == sizeof(write_data));
+    close(fd);
+    g_assert(memcmp(buffer, write_data, sizeof(write_data)) == 0);
+
+    unlink(path);
+}
+
+int main(int argc, char *argv[])
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/k230-sdhci/registers", test_registers);
+    qtest_add_func("/k230-sdhci/card-detect", test_card_detect);
+    qtest_add_func("/k230-sdhci/card-io", test_card_io);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 56ff860e21..0600b1e807 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -297,7 +297,10 @@ qtests_riscv64 = ['riscv-csr-test'] + \
   (config_all_devices.has_key('CONFIG_IOMMU_TESTDEV') and
    config_all_devices.has_key('CONFIG_RISCV_IOMMU') ?
    ['iommu-riscv-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_K230') ? ['k230-wdt-test'] : [])
+  (config_all_devices.has_key('CONFIG_K230') ? [
+    'k230-wdt-test',
+    'k230-sdhci-test',
+  ] : [])
 
 qtests_hexagon = ['boot-serial-test']
 
-- 
2.43.0


