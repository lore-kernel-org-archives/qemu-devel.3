Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA5BCD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 17:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSeMp-0006hX-NT; Thu, 28 May 2026 13:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wSeMS-0006VD-TA
 for qemu-devel@nongnu.org; Thu, 28 May 2026 13:17:38 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wSeMO-000496-RR
 for qemu-devel@nongnu.org; Thu, 28 May 2026 13:17:36 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4905e190c71so56029685e9.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 10:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779988651; x=1780593451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7XlZXXikjZPJNyVBb/rRAGZGRpHVkZDtSGlI/gZ7+vI=;
 b=Y80X80n+FZZVeZY6u62qP0P73ED1RaIOBbfdkmWOxx+hesZAUBUwT8ADjj22pxhzjI
 1vB2BWmyjvDVQD2rxrRiRYDvaE93Fwhqd7t0b5elP5KGXSCGVup7Tex6/+k1ZK27qE7I
 ldjkU5T/5J0eA35LzsacUbC3QXh1qU75UQdGgOxWAGZHC85Ru3JmS/a+W2yfmOXU800o
 6sDtBnZJxHqOar8uivsLCujglwPtgzunHUnNBpXdtHLePrb26txtOIbDevHgrSFN5sO9
 rgjWwk4PS+Q9N0UM97wipoFJ02zrOOngUrhgTxFdmTQGwTNmypg/qD51LQ1SZEV7bRHe
 iFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779988651; x=1780593451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7XlZXXikjZPJNyVBb/rRAGZGRpHVkZDtSGlI/gZ7+vI=;
 b=CaSw4HKgzFGXyvdkA2LKiGSUuwmC1o4Cel8zax+kWuOUSnY0MBADJxe3gA73uVCiYt
 Z0cd3SEDYYlYmHDCuuRqSLn3S5Yx/8IGCBZ20QYP2txRjVx/Bn7CuOTHyR/KnoQ583Mw
 AplMnyKz/VNphOOEkRk3oDNNuRdCNwfi7saUrZ1ZfmrI4hkQ92hA7RKZsfkgdNE8rr1b
 q2AvODAUKBvHJJ53wDcdEYZHZHMuUayeSuCdiYzzixV9uDmubLzdxXBLiJwur+ipvUh0
 c67R/3FNGURuI8hlJg9kFEJCN+tIQbNaACLjSlCtyQpsrnGNJYg9Islp5BZ2+yMm7NFg
 BAqQ==
X-Gm-Message-State: AOJu0YzJfxahpTselRrt0TvWyMxkql3Hm/GZ/W3awsA6XmFEc+v7AG9B
 Rfx4s811WOIqKN8ABh3Sk1fMLxBRNvkVt8w4aaMhJOGzYNom+7pQoCy7ahI8nEYO
X-Gm-Gg: Acq92OG+J+vwl5z3bml4lO0kYxecnI+c5XGQUePl892ATCZiYjecfhoDkmohN40TnK8
 qUuR9IyHip6fvu2T75zCpHgADnVBguarXI0gjfup0bYFsmmaV4XmNe3NesK452JEVgy4A1oc+N1
 JjN0a8313hj7iPmPIQ0TNd4Ddb5YcWlRrv+V1ffIN8V25F6NwZdiyVEsb1aU+S0jx3WkbEbLQs8
 4SvN2WiQINJBX62CxwhPWCA7Uu0ZUiB3xY4J525bE2vpHntceCMjuswcz+NOOTEgnwj+pYv9Oqe
 jKvmsq+fUSz/KWg9cvgBsdiBKgsC971AcIDaNUdejAYU7TP6UuLXo+Z2tTV4dOn00pkiCCzlvG8
 F8C4QTwquRvd8Cr9Sxkpaqbblj2/kIZUlGSFivtTtfUdhCxrw9mvP7GLbz/re/Jrjx+Vah9vdvU
 BdLyg9e0QP7l3Ufn7ykITyhyV5JEai38Avj8jh4kradGzQygodr2i23SLkVYc7KpS8
X-Received: by 2002:a05:600c:4ecc:b0:490:3c90:2cda with SMTP id
 5b1f17b1804b1-490426cef73mr446648735e9.20.1779988651275; 
 Thu, 28 May 2026 10:17:31 -0700 (PDT)
Received: from acidburn.pod.cvut.cz (acidburn.pod.cvut.cz. [147.32.90.2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49092968066sm53774085e9.15.2026.05.28.10.17.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 10:17:30 -0700 (PDT)
From: =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
To: qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>, Bernhard Beschow <shentey@gmail.com>
Cc: qemu-arm@nongnu.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Andrey Volkov <andrey@volkov.fr>,
 =?UTF-8?q?Maty=C3=A1=C5=A1=20Bobek?= <matyas.bobek@gmail.com>
Subject: [PATCH v4 6/7] tests: Add qtests for FlexCAN
Date: Thu, 28 May 2026 19:17:16 +0200
Message-ID: <7363e06de3b8a8eac0e7878bc15a0b9238cce06d.1779986496.git.matyas.bobek@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1779986496.git.matyas.bobek@gmail.com>
References: <cover.1779986496.git.matyas.bobek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=matyas.bobek@gmail.com; helo=mail-wm1-x32f.google.com
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

The tests do not test all of the FlexCAN emulator functionality.

Signed-off-by: Matyáš Bobek <matyas.bobek@gmail.com>
Signed-off-by: Pavel Pisa <pisa@fel.cvut.cz>
Tested-by: Pavel Pisa <pisa@fel.cvut.cz>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Pavel Pisa <pisa@fel.cvut.cz>
---
 MAINTAINERS                |   1 +
 tests/qtest/flexcan-test.c | 421 +++++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build    |   1 +
 3 files changed, 423 insertions(+)
 create mode 100644 tests/qtest/flexcan-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 36e056309b..45d5848da6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2108,6 +2108,7 @@ S: Maintained
 F: hw/net/can/flexcan.c
 F: hw/net/can/flexcan_regs.h
 F: include/hw/net/flexcan.h
+F: tests/qtest/flexcan-test.c
 
 EDU
 M: Jiri Slaby <jslaby@suse.cz>
diff --git a/tests/qtest/flexcan-test.c b/tests/qtest/flexcan-test.c
new file mode 100644
index 0000000000..87d947a806
--- /dev/null
+++ b/tests/qtest/flexcan-test.c
@@ -0,0 +1,421 @@
+/*
+ * QTests for FlexCAN CAN controller device model
+ *
+ * Copyright (c) 2025 Matyas Bobek <matyas.bobek@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest-single.h"
+
+#include "hw/net/flexcan.h"
+#include "hw/net/can/flexcan_regs.h"
+
+#define FSL_IMX6_CAN2_ADDR 0x02094000
+#define FSL_IMX6_CAN2_SIZE 0x4000
+#define FSL_IMX6_CAN1_ADDR 0x02090000
+#define FSL_IMX6_CAN1_SIZE 0x4000
+
+#define FC_QEMU_ARGS "-nographic -M sabrelite " \
+                     "-object can-bus,id=qcan0  " \
+                     "-machine canbus0=qcan0 -machine canbus1=qcan0"
+
+/* used for masking out unused/reserved bits */
+#define FC_MB_CNT_USED_MASK (~0xF080FFFFu)
+
+#define FCREG(BASE_ADDR, REG) ((BASE_ADDR) + offsetof(FlexcanRegs, REG))
+#define FCMB(BASE_ADDR, MB_IDX, WORD_IDX) (FCREG(BASE_ADDR, mbs) + \
+    0x10 * (MB_IDX) + 4 * (WORD_IDX))
+
+typedef struct FcTestFrame {
+    uint32_t id;
+    uint32_t data[2];
+    uint8_t len;
+    bool ide;
+    bool rtr;
+
+    /* rx only */
+    bool expect_overrun;
+} FcTestFrame;
+
+static const FcTestFrame fc_test_frame_1 = {
+    .id = 0x5AF,
+    .len = 8,
+    .data = {
+        0x01020304,
+        0x0A0B0C0D
+    },
+    .ide = false
+};
+
+static const FcTestFrame fc_test_frame_1_ide = {
+    .id = 0x105AF5AF,
+    .len = 8,
+    .data = {
+        0x01020304,
+        0x0A0B0C0D
+    },
+    .ide = true
+};
+
+static void fc_reset(hwaddr ba, uint32_t mcr_flags)
+{
+    /* disable */
+    writel(FCREG(ba, mcr), 0xD890000F);
+
+    /* enable in freeze mode */
+    writel(FCREG(ba, mcr), 0x5980000F);
+
+    /* soft reset */
+    writel(FCREG(ba, mcr), 0x5980000F | FLEXCAN_MCR_SOFTRST);
+
+    g_assert_cmpuint(readl(FCREG(ba, mcr)), ==, 0x5980000F);
+    g_assert_cmpuint(readl(FCREG(ba, ctrl)), ==, 0);
+    g_assert_cmpuint(readl(FCREG(ba, ctrl2)), ==, 0);
+
+    writel(FCREG(ba, mcr), (0x5980000F & ~FLEXCAN_MCR_HALT) | mcr_flags);
+    writel(FCREG(ba, ctrl2), FLEXCAN_CTRL2_RRS);
+
+    /* initialize all mailboxes as rx inactive */
+    for (int i = 0; i < FLEXCAN_MAILBOX_COUNT; i++) {
+        writel(FCMB(ba, i, 0), FLEXCAN_MB_CODE_RX_INACTIVE);
+        writel(FCMB(ba, i, 1), 0);
+        writel(FCMB(ba, i, 2), 0);
+        writel(FCMB(ba, i, 3), 0);
+    }
+}
+
+static uint64_t fc_get_irqs(hwaddr ba)
+{
+    return (uint64_t)readl(FCREG(ba, iflag1)) |
+        ((uint64_t)readl(FCREG(ba, iflag2)) << 32);
+}
+
+static void fc_clear_irq(hwaddr ba, int idx)
+{
+    if (idx >= 32) {
+        writel(FCREG(ba, iflag2), (uint32_t)1 << (idx - 32));
+    } else {
+        writel(FCREG(ba, iflag1), (uint32_t)1 << idx);
+    }
+
+    g_assert_cmpuint(fc_get_irqs(ba) & ((uint64_t)1 << idx), ==, 0);
+}
+
+static void fc_setup_rx_mb(hwaddr ba, int mbidx)
+{
+    writel(FCMB(ba, mbidx, 0), FLEXCAN_MB_CODE_RX_EMPTY);
+    writel(FCMB(ba, mbidx, 1), 0);
+    /* the data value should be ignored for RX mb */
+    writel(FCMB(ba, mbidx, 2), 0);
+    writel(FCMB(ba, mbidx, 3), 0);
+
+    g_assert_cmpuint(readl(FCMB(ba, mbidx, 0)), ==, FLEXCAN_MB_CODE_RX_EMPTY);
+}
+
+static void fc_tx(hwaddr ba, int mbidx, const FcTestFrame *frame)
+{
+    g_assert_cmpuint(frame->len, <=, 8);
+
+    writel(FCMB(ba, mbidx, 0), FLEXCAN_MB_CODE_TX_INACTIVE);
+    uint32_t id = frame->ide ? frame->id : frame->id << 18;
+    writel(FCMB(ba, mbidx, 1), id);
+    writel(FCMB(ba, mbidx, 2), frame->data[0]);
+    writel(FCMB(ba, mbidx, 3), frame->data[1]);
+
+    uint32_t ctrl = FLEXCAN_MB_CODE_TX_DATA | FLEXCAN_MB_CNT_LENGTH(frame->len);
+    if (frame->ide) {
+        ctrl |= FLEXCAN_MB_CNT_IDE | FLEXCAN_MB_CNT_SRR;
+    }
+    if (frame->rtr) {
+        ctrl |= FLEXCAN_MB_CNT_RTR;
+    }
+    writel(FCMB(ba, mbidx, 0), ctrl);
+
+    /* check frame was transmitted */
+    g_assert_cmpuint(fc_get_irqs(ba) & ((uint64_t)1 << mbidx),
+                     !=, 0);
+
+    uint32_t xpectd_ctrl = (ctrl & ~FLEXCAN_MB_CODE_MASK) |
+        FLEXCAN_MB_CODE_TX_INACTIVE;
+    g_assert_cmpuint(readl(FCMB(ba, mbidx, 0)) & FC_MB_CNT_USED_MASK, ==,
+                     xpectd_ctrl);
+    /* other fields should stay unchanged */
+    g_assert_cmpuint(readl(FCMB(ba, mbidx, 1)), ==, id);
+    g_assert_cmpuint(readl(FCMB(ba, mbidx, 2)), ==, frame->data[0]);
+    g_assert_cmpuint(readl(FCMB(ba, mbidx, 3)), ==, frame->data[1]);
+}
+
+static void fc_rx_check(hwaddr ba, int mbidx, const FcTestFrame *frame)
+{
+    uint32_t xpectd_ctrl = frame->expect_overrun ? FLEXCAN_MB_CODE_RX_OVERRUN
+                             : FLEXCAN_MB_CODE_RX_FULL;
+    xpectd_ctrl |= FLEXCAN_MB_CNT_LENGTH(frame->len) | FLEXCAN_MB_CNT_SRR;
+    if (frame->ide) {
+        xpectd_ctrl |= FLEXCAN_MB_CNT_IDE;
+    }
+    if (frame->rtr) {
+        xpectd_ctrl |= FLEXCAN_MB_CNT_RTR;
+    }
+
+    uint32_t xpectd_id = frame->ide ? frame->id : frame->id << 18;
+
+    uint32_t ctrl = readl(FCMB(ba, mbidx, 0)) & FC_MB_CNT_USED_MASK;
+    if ((ctrl & FLEXCAN_MB_CODE_MASK) == FLEXCAN_MB_CODE_RX_EMPTY) {
+        fprintf(stderr, "expected frame (id=0x%X) not received\n", frame->id);
+    }
+
+    g_assert_cmpuint(ctrl, ==, xpectd_ctrl);
+    g_assert_cmpuint(readl(FCMB(ba, mbidx, 1)), ==, xpectd_id);
+    g_assert_cmpuint(readl(FCMB(ba, mbidx, 2)), ==, frame->data[0]);
+    g_assert_cmpuint(readl(FCMB(ba, mbidx, 3)), ==, frame->data[1]);
+}
+
+static void fc_check_empty_multi(hwaddr ba, int idx_count, int mbidxs[])
+{
+    for (int i = 0; i < FLEXCAN_MAILBOX_COUNT; i++) {
+        bool check_empty = true;
+        int ctrl = readl(FCMB(ba, i, 0));
+
+        for (int j = 0; j < idx_count; j++) {
+            if (i == mbidxs[j]) {
+                check_empty = false;
+            }
+        }
+
+        if (check_empty) {
+            if (!(ctrl == FLEXCAN_MB_CODE_RX_EMPTY ||
+                  ctrl == FLEXCAN_MB_CODE_RX_INACTIVE)) {
+                g_assert_cmpuint(ctrl, ==, FLEXCAN_MB_CODE_RX_INACTIVE);
+            }
+            g_assert_cmpuint(readl(FCMB(ba, i, 1)), ==, 0);
+            g_assert_cmpuint(readl(FCMB(ba, i, 2)), ==, 0);
+            g_assert_cmpuint(readl(FCMB(ba, i, 3)), ==, 0);
+        } else {
+            g_assert_cmpuint(
+                ctrl & FLEXCAN_MB_CODE_MASK, !=,
+                FLEXCAN_MB_CODE_RX_INACTIVE
+            );
+        }
+    }
+}
+
+static void fc_check_empty(hwaddr ba, int mbidx)
+{
+    fc_check_empty_multi(ba, 1, &mbidx);
+}
+
+static void flexcan_test_linux_probe_impl(hwaddr fba)
+{
+    /* -- test a Linux driver-like probe sequence -- */
+    /* disable */
+    writel(FCREG(fba, mcr), 0xD890000F);
+    g_assert_cmpuint(readl(FCREG(fba, mcr)), ==, 0xD890000F);
+    g_assert_cmpuint(readl(FCREG(fba, ctrl)), ==, 0);
+
+    /* set bit in reserved field we do not implement (CTRL_CLK_SRC) */
+    writel(FCREG(fba, ctrl), 0x00002000);
+    g_assert_cmpuint(readl(FCREG(fba, mcr)), ==, 0xD890000F);
+
+    /* enable in freeze mode */
+    writel(FCREG(fba, mcr), 0x5980000F);
+    g_assert_cmpuint(readl(FCREG(fba, mcr)), ==, 0x5980000F);
+
+    /* enable Rx-FIFO */
+    writel(FCREG(fba, mcr), 0x7980000F);
+    g_assert_cmpuint(readl(FCREG(fba, mcr)), ==, 0x7980000F);
+    g_assert_cmpuint(readl(FCREG(fba, ecr)), ==, 0);
+
+    /* disable */
+    writel(FCREG(fba, mcr), 0xF890000F);
+    g_assert_cmpuint(readl(FCREG(fba, mcr)), ==, 0xF890000F);
+}
+
+static void flexcan_test_freeze_disable_interaction_impl(hwaddr fba)
+{
+    /* -- test normal <=> freeze <=> disable transitions -- */
+
+    /* leave freeze in disabled, FRZ_ACK should stay cleared */
+    writel(FCREG(fba, mcr), 0xF890000F); /* disable */
+    g_assert_cmpuint(readl(FCREG(fba, mcr)), ==, 0xF890000F);
+    writel(FCREG(fba, mcr), 0xB890000F);  /* by clearing FRZ */
+    g_assert_cmpuint(readl(FCREG(fba, mcr)), ==, 0xB890000F);
+
+    writel(FCREG(fba, mcr), 0xF890000F); /* disable */
+    g_assert_cmpuint(readl(FCREG(fba, mcr)), ==, 0xF890000F);
+    writel(FCREG(fba, mcr), 0xE890000F);  /* by clearing HALT */
+    g_assert_cmpuint(readl(FCREG(fba, mcr)), ==, 0xE890000F);
+
+    writel(FCREG(fba, mcr), 0xF890000F); /* disable */
+    g_assert_cmpuint(readl(FCREG(fba, mcr)), ==, 0xF890000F);
+    writel(FCREG(fba, mcr), 0xA890000F);  /* by clearing both */
+    g_assert_cmpuint(readl(FCREG(fba, mcr)), ==, 0xA890000F);
+
+    /* enter and leave freeze */
+    writel(FCREG(fba, mcr), 0x7980000F); /* enable in freeze mode */
+    g_assert_cmpuint(readl(FCREG(fba, mcr)), ==, 0x7980000F);
+    writel(FCREG(fba, mcr), 0x3980000F); /* leave by clearing FRZ */
+    g_assert_cmpuint(readl(FCREG(fba, mcr)), ==, 0x3080000F);
+
+    writel(FCREG(fba, mcr), 0x7980000F); /* enable in freeze mode */
+    g_assert_cmpuint(readl(FCREG(fba, mcr)), ==, 0x7980000F);
+    writel(FCREG(fba, mcr), 0x6980000F); /* leave by clearing HALT */
+    g_assert_cmpuint(readl(FCREG(fba, mcr)), ==, 0x6080000F);
+}
+
+static void flexcan_test_mailbox_io_impl(hwaddr ba_tx, hwaddr ba_rx)
+{
+    /* -- test correct handling of mailbox IO -- */
+    const int test_1_mbidx = 0;
+    fc_reset(ba_tx,
+             FLEXCAN_MCR_SRX_DIS | FLEXCAN_MCR_MAXMB(FLEXCAN_MAILBOX_COUNT));
+    fc_reset(ba_rx,
+             FLEXCAN_MCR_SRX_DIS | FLEXCAN_MCR_MAXMB(FLEXCAN_MAILBOX_COUNT));
+
+    fc_setup_rx_mb(ba_rx, test_1_mbidx);
+    fc_tx(ba_tx, test_1_mbidx, &fc_test_frame_1_ide);
+    g_assert_cmpuint(fc_get_irqs(ba_rx), ==, 1 << test_1_mbidx);
+    fc_rx_check(ba_rx, test_1_mbidx, &fc_test_frame_1_ide);
+    readl(FCREG(ba_rx, timer)); /* reset lock */
+
+    writel(FCMB(ba_rx, test_1_mbidx, 0), 0);
+    g_assert_cmpuint(readl(FCMB(ba_rx, test_1_mbidx, 0)), ==, 0);
+    writel(FCMB(ba_rx, test_1_mbidx, 1), 0x99AABBCC);
+    g_assert_cmpuint(readl(FCMB(ba_rx, test_1_mbidx, 1)), ==, 0x99AABBCC);
+}
+
+static void flexcan_test_dual_transmit_receive_impl(hwaddr ba_tx, hwaddr ba_rx)
+{
+    /* -- test TX and RX between the two FlexCAN instances -- */
+    const int test_1_mbidx = 50;
+    const int test_rounds = 50;
+
+    /* self-receive enabled on tx FC */
+    fc_reset(ba_tx,
+             FLEXCAN_MCR_MAXMB(FLEXCAN_MAILBOX_COUNT));
+    fc_reset(ba_rx,
+             FLEXCAN_MCR_SRX_DIS | FLEXCAN_MCR_MAXMB(FLEXCAN_MAILBOX_COUNT));
+
+    /* tests self-receive on tx and reception on rx */
+    fc_setup_rx_mb(ba_rx, test_1_mbidx);
+    fc_check_empty(ba_rx, test_1_mbidx);
+    fc_setup_rx_mb(ba_tx, test_1_mbidx + 1);
+    fc_check_empty(ba_tx, test_1_mbidx + 1);
+    g_assert_cmpuint(fc_get_irqs(ba_rx), ==, 0);
+    g_assert_cmpuint(fc_get_irqs(ba_tx), ==, 0);
+
+    fc_tx(ba_tx, test_1_mbidx, &fc_test_frame_1);
+    fc_clear_irq(ba_tx, test_1_mbidx);
+
+    fc_rx_check(ba_rx, test_1_mbidx, &fc_test_frame_1);
+    fc_check_empty(ba_rx, test_1_mbidx);
+    fc_rx_check(ba_tx, test_1_mbidx + 1, &fc_test_frame_1);
+    int tx_non_empty_mbidxs[] = {test_1_mbidx, test_1_mbidx + 1};
+
+    fc_check_empty_multi(ba_tx, 2, tx_non_empty_mbidxs);
+    fc_clear_irq(ba_rx, test_1_mbidx);
+    fc_clear_irq(ba_tx, test_1_mbidx + 1);
+    readl(FCREG(ba_rx, timer)); /* reset lock */
+
+    for (int ridx = 0; ridx < test_rounds; ridx++) {
+        /* test extended IDs sent to all mailboxes */
+        for (int i = 0; i < FLEXCAN_MAILBOX_COUNT; i++) {
+            fc_setup_rx_mb(ba_rx, i);
+        }
+        fc_check_empty_multi(ba_rx, 0, NULL);
+        g_assert_cmpuint(fc_get_irqs(ba_rx), ==, 0);
+        g_assert_cmpuint(fc_get_irqs(ba_tx), ==, 0);
+
+        for (int i = 0; i < FLEXCAN_MAILBOX_COUNT; i++) {
+            fc_tx(ba_tx, i, &fc_test_frame_1_ide);
+        }
+        g_assert_cmpuint(fc_get_irqs(ba_rx), ==, UINT64_MAX);
+        g_assert_cmpuint(fc_get_irqs(ba_tx), ==, UINT64_MAX);
+        for (int i = 0; i < FLEXCAN_MAILBOX_COUNT; i++) {
+            fc_rx_check(ba_rx, i, &fc_test_frame_1_ide);
+        }
+
+        /* reset interrupts */
+        writel(FCREG(ba_rx, iflag1), UINT32_MAX);
+        writel(FCREG(ba_rx, iflag2), UINT32_MAX);
+        writel(FCREG(ba_tx, iflag1), UINT32_MAX);
+        writel(FCREG(ba_tx, iflag2), UINT32_MAX);
+        g_assert_cmpuint(fc_get_irqs(ba_rx), ==, 0);
+        g_assert_cmpuint(fc_get_irqs(ba_tx), ==, 0);
+    }
+}
+
+static void flexcan_test_tx_abort_impl(hwaddr ba)
+{
+    /* -- test the TX abort feature -- */
+    fc_reset(ba,
+             FLEXCAN_MCR_SRX_DIS | FLEXCAN_MCR_MAXMB(FLEXCAN_MAILBOX_COUNT));
+
+
+    for (int mbidx = 0; mbidx < FLEXCAN_MAILBOX_COUNT; mbidx++) {
+        fc_tx(ba, mbidx, &fc_test_frame_1);
+
+        writel(FCMB(ba, mbidx, 0), FLEXCAN_MB_CODE_TX_ABORT);
+        g_assert_cmpuint(readl(FCMB(ba, mbidx, 0)), ==,
+                         FLEXCAN_MB_CODE_TX_INACTIVE);
+    }
+}
+
+static void flexcan_test_freeze_disable_interaction(void)
+{
+    qtest_start(FC_QEMU_ARGS);
+    flexcan_test_freeze_disable_interaction_impl(FSL_IMX6_CAN1_ADDR);
+    flexcan_test_freeze_disable_interaction_impl(FSL_IMX6_CAN2_ADDR);
+    qtest_end();
+}
+
+static void flexcan_test_linux_probe(void)
+{
+    qtest_start(FC_QEMU_ARGS);
+    flexcan_test_linux_probe_impl(FSL_IMX6_CAN1_ADDR);
+    flexcan_test_linux_probe_impl(FSL_IMX6_CAN2_ADDR);
+    qtest_end();
+}
+
+static void flexcan_test_dual_transmit_receive(void)
+{
+    qtest_start(FC_QEMU_ARGS);
+    flexcan_test_dual_transmit_receive_impl(FSL_IMX6_CAN1_ADDR,
+                                            FSL_IMX6_CAN2_ADDR);
+    flexcan_test_dual_transmit_receive_impl(FSL_IMX6_CAN2_ADDR,
+                                            FSL_IMX6_CAN1_ADDR);
+    qtest_end();
+}
+
+static void flexcan_test_tx_abort(void)
+{
+    qtest_start(FC_QEMU_ARGS);
+    flexcan_test_tx_abort_impl(FSL_IMX6_CAN1_ADDR);
+    flexcan_test_tx_abort_impl(FSL_IMX6_CAN2_ADDR);
+    qtest_end();
+}
+
+static void flexcan_test_mailbox_io(void)
+{
+    qtest_start(FC_QEMU_ARGS);
+    flexcan_test_mailbox_io_impl(FSL_IMX6_CAN1_ADDR, FSL_IMX6_CAN2_ADDR);
+    flexcan_test_mailbox_io_impl(FSL_IMX6_CAN2_ADDR, FSL_IMX6_CAN1_ADDR);
+    qtest_end();
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/net/flexcan/linux_probe", flexcan_test_linux_probe);
+    qtest_add_func("/net/flexcan/freeze_disable_interaction",
+                   flexcan_test_freeze_disable_interaction);
+    qtest_add_func("/net/flexcan/dual_transmit_receive",
+                   flexcan_test_dual_transmit_receive);
+    qtest_add_func("/net/flexcan/tx_abort",
+                   flexcan_test_tx_abort);
+    qtest_add_func("/net/flexcan/mailbox_io", flexcan_test_mailbox_io);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 728dde54b3..7bf1efcda5 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -249,6 +249,7 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : []) + \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') ? qtests_stm32l4x5 : []) + \
   (config_all_devices.has_key('CONFIG_FSI_APB2OPB_ASPEED') ? ['aspeed_fsi-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_CAN_FLEXCAN') ? ['flexcan-test'] : []) + \
   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') and
    config_all_devices.has_key('CONFIG_DM163')? ['dm163-test'] : []) + \
   ['arm-cpu-features',
-- 
2.54.0


