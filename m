Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E46F34C49
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 13:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCHGS-0008KM-Ry; Mon, 13 Apr 2026 09:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wCHGN-0008Ip-Un
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 09:23:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wCHGI-0006w6-Va
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 09:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776086612;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HZ1aqZabgLQpvCuwPaKybB2MjBBeetK6fS7mGxyWmE8=;
 b=Cu0QUuW1uxBYInIbEvkko4jT9o1jwS325OMw+QgO/G2euoOyc9U2oCBDkzBK+UlQMGMR06
 y/Hkn/uubkreXIPyFk97CRpGKyR7LDLVFzPgJVggBowMwWzHjAV/RWjqNK0B0ffWI2CUa8
 n0E45Je3/Rys23NVhSPUVNNFKuVNQOc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-RwRQx_LeNM6cuP59IAMnZA-1; Mon,
 13 Apr 2026 09:23:26 -0400
X-MC-Unique: RwRQx_LeNM6cuP59IAMnZA-1
X-Mimecast-MFC-AGG-ID: RwRQx_LeNM6cuP59IAMnZA_1776086604
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2913B1800361; Mon, 13 Apr 2026 13:23:23 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F169E180049F; Mon, 13 Apr 2026 13:23:19 +0000 (UTC)
Date: Mon, 13 Apr 2026 14:23:16 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: =?utf-8?B?TWF0ecOhxaE=?= Bobek <matyas.bobek@gmail.com>,
 qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>, qemu-arm@nongnu.org,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 6/7] tests: Add qtests for FlexCAN
Message-ID: <adzuRHcb4BVIRAS8@redhat.com>
References: <cover.1773866323.git.matyas.bobek@gmail.com>
 <33d03d96698eb7511321690d9b5a054f03aa8bc7.1773866323.git.matyas.bobek@gmail.com>
 <4244E4A0-CCE2-4E23-B32E-B6B9242FAA60@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4244E4A0-CCE2-4E23-B32E-B6B9242FAA60@gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Apr 13, 2026 at 01:16:20PM +0000, Bernhard Beschow wrote:
> 
> 
> Am 19. März 2026 19:13:13 UTC schrieb "Matyáš Bobek" <matyas.bobek@gmail.com>:
> >The tests do not test all of the FlexCAN emulator functionality.
> >
> >Signed-off-by: Matyáš Bobek <matyas.bobek@gmail.com>
> >---
> > MAINTAINERS                |   1 +
> > tests/qtest/flexcan-test.c | 424 +++++++++++++++++++++++++++++++++++++
> > tests/qtest/meson.build    |   1 +
> > 3 files changed, 426 insertions(+)
> > create mode 100644 tests/qtest/flexcan-test.c
> >
> >diff --git a/MAINTAINERS b/MAINTAINERS
> >index e723863a6f..dbb159f031 100644
> >--- a/MAINTAINERS
> >+++ b/MAINTAINERS
> >@@ -2090,6 +2090,7 @@ S: Maintained
> > F: hw/net/can/flexcan.c
> > F: hw/net/can/flexcan_regs.h
> > F: include/hw/net/flexcan.h
> >+F: tests/qtest/flexcan-test.c
> > 
> > EDU
> > M: Jiri Slaby <jslaby@suse.cz>
> >diff --git a/tests/qtest/flexcan-test.c b/tests/qtest/flexcan-test.c
> >new file mode 100644
> >index 0000000000..b5880d4119
> >--- /dev/null
> >+++ b/tests/qtest/flexcan-test.c
> >@@ -0,0 +1,424 @@
> >+/*
> >+ * QTests for FlexCAN CAN controller device model
> >+ *
> >+ * Copyright (c) 2025 Matyas Bobek <matyas.bobek@gmail.com>
> >+ *
> >+ * This code is licensed under the GPL version 2 or later.  See
> >+ * the COPYING file in the top-level directory.
> 
> IIUC this license text is redundant to the specifier below, but again, IANAL. Daniel?

checkpatch.pl  should complain about this.

For *newly* written files, only the SPDX-License-Identifier should be
present.   Traditional license boilerplate is only permitted if we're
dealing with historical files where we're required to preserve existing
license text.


> 
> >+ *
> >+ * SPDX-License-Identifier: GPL-2.0-or-later
> >+ */
> >+
> >+#include "qemu/osdep.h"
> >+#include "libqtest-single.h"
> >+
> >+#include "hw/net/flexcan.h"
> >+#include "hw/net/can/flexcan_regs.h"
> >+
> >+#define FSL_IMX6_CAN2_ADDR 0x02094000
> >+#define FSL_IMX6_CAN2_SIZE 0x4000
> >+#define FSL_IMX6_CAN1_ADDR 0x02090000
> >+#define FSL_IMX6_CAN1_SIZE 0x4000
> >+
> >+#define FC_QEMU_ARGS "-nographic -M sabrelite " \
> >+                     "-object can-bus,id=qcan0  " \
> >+                     "-machine canbus0=qcan0 -machine canbus1=qcan0"
> >+
> >+/* used for masking out unused/reserved bits */
> >+#define FC_MB_CNT_USED_MASK (~0xF080FFFFu)
> >+
> >+#define FCREG(BASE_ADDR, REG) ((BASE_ADDR) + offsetof(FlexcanRegs, REG))
> >+#define FCMB(BASE_ADDR, MB_IDX, WORD_IDX) (FCREG(BASE_ADDR, mbs) + \
> >+    0x10 * (MB_IDX) + 4 * (WORD_IDX))
> >+
> >+typedef struct FcTestFrame {
> >+    uint32_t id;
> >+    uint32_t data[2];
> >+    uint8_t len;
> >+    bool ide;
> >+    bool rtr;
> >+
> >+    /* rx only */
> >+    bool expect_overrun;
> >+} FcTestFrame;
> >+
> >+static const FcTestFrame fc_test_frame_1 = {
> >+    .id = 0x5AF,
> >+    .len = 8,
> >+    .data = {
> >+        0x01020304,
> >+        0x0A0B0C0D
> >+    },
> >+    .ide = false
> >+};
> >+
> >+static const FcTestFrame fc_test_frame_1_ide = {
> >+    .id = 0x105AF5AF,
> >+    .len = 8,
> >+    .data = {
> >+        0x01020304,
> >+        0x0A0B0C0D
> >+    },
> >+    .ide = true
> >+};
> >+
> >+static void fc_reset(hwaddr ba, uint32_t mcr_flags)
> >+{
> >+    /* disable */
> >+    writel(FCREG(ba, mcr), 0xD890000F);
> >+
> >+    /* enable in freeze mode */
> >+    writel(FCREG(ba, mcr), 0x5980000F);
> >+
> >+    /* soft reset */
> >+    writel(FCREG(ba, mcr), 0x5980000F | FLEXCAN_MCR_SOFTRST);
> >+
> >+    g_assert_cmpuint(readl(FCREG(ba, mcr)), ==, 0x5980000F);
> >+    g_assert_cmpuint(readl(FCREG(ba, ctrl)), ==, 0);
> >+    g_assert_cmpuint(readl(FCREG(ba, ctrl2)), ==, 0);
> >+
> >+    writel(FCREG(ba, mcr), (0x5980000F & ~FLEXCAN_MCR_HALT) | mcr_flags);
> >+    writel(FCREG(ba, ctrl2), FLEXCAN_CTRL2_RRS);
> >+
> >+    /* initialize all mailboxes as rx inactive */
> >+    for (int i = 0; i < FLEXCAN_MAILBOX_COUNT; i++) {
> >+        writel(FCMB(ba, i, 0), FLEXCAN_MB_CODE_RX_INACTIVE);
> >+        writel(FCMB(ba, i, 1), 0);
> >+        writel(FCMB(ba, i, 2), 0);
> >+        writel(FCMB(ba, i, 3), 0);
> >+    }
> >+}
> >+
> >+static uint64_t fc_get_irqs(hwaddr ba)
> >+{
> >+    return (uint64_t)readl(FCREG(ba, iflag1)) |
> >+        ((uint64_t)readl(FCREG(ba, iflag2)) << 32);
> >+}
> >+
> >+static void fc_clear_irq(hwaddr ba, int idx)
> >+{
> >+    if (idx >= 32) {
> >+        writel(FCREG(ba, iflag2), (uint32_t)1 << (idx - 32));
> >+    } else {
> >+        writel(FCREG(ba, iflag1), (uint32_t)1 << idx);
> >+    }
> >+
> >+    g_assert_cmpuint(fc_get_irqs(ba) & ((uint64_t)1 << idx), ==, 0);
> >+}
> >+
> >+static void fc_setup_rx_mb(hwaddr ba, int mbidx)
> >+{
> >+    writel(FCMB(ba, mbidx, 0), FLEXCAN_MB_CODE_RX_EMPTY);
> >+    writel(FCMB(ba, mbidx, 1), 0);
> >+    /* the data value should be ignored for RX mb */
> >+    writel(FCMB(ba, mbidx, 2), 0);
> >+    writel(FCMB(ba, mbidx, 3), 0);
> >+
> >+    g_assert_cmpuint(readl(FCMB(ba, mbidx, 0)), ==, FLEXCAN_MB_CODE_RX_EMPTY);
> >+}
> >+
> >+static void fc_tx(hwaddr ba, int mbidx, const FcTestFrame *frame)
> >+{
> >+    g_assert_cmpuint(frame->len, <=, 8);
> >+
> >+    writel(FCMB(ba, mbidx, 0), FLEXCAN_MB_CODE_TX_INACTIVE);
> >+    uint32_t id = frame->ide ? frame->id : frame->id << 18;
> >+    writel(FCMB(ba, mbidx, 1), id);
> >+    writel(FCMB(ba, mbidx, 2), frame->data[0]);
> >+    writel(FCMB(ba, mbidx, 3), frame->data[1]);
> >+
> >+    uint32_t ctrl = FLEXCAN_MB_CODE_TX_DATA | FLEXCAN_MB_CNT_LENGTH(frame->len);
> >+    if (frame->ide) {
> >+        ctrl |= FLEXCAN_MB_CNT_IDE | FLEXCAN_MB_CNT_SRR;
> >+    }
> >+    if (frame->rtr) {
> >+        ctrl |= FLEXCAN_MB_CNT_RTR;
> >+    }
> >+    writel(FCMB(ba, mbidx, 0), ctrl);
> >+
> >+    /* check frame was transmitted */
> >+    g_assert_cmpuint(fc_get_irqs(ba) & ((uint64_t)1 << mbidx),
> >+                     !=, 0);
> >+
> >+    uint32_t xpectd_ctrl = (ctrl & ~FLEXCAN_MB_CODE_MASK) |
> >+        FLEXCAN_MB_CODE_TX_INACTIVE;
> >+    g_assert_cmpuint(readl(FCMB(ba, mbidx, 0)) & FC_MB_CNT_USED_MASK, ==,
> >+                     xpectd_ctrl);
> >+    /* other fields should stay unchanged */
> >+    g_assert_cmpuint(readl(FCMB(ba, mbidx, 1)), ==, id);
> >+    g_assert_cmpuint(readl(FCMB(ba, mbidx, 2)), ==, frame->data[0]);
> >+    g_assert_cmpuint(readl(FCMB(ba, mbidx, 3)), ==, frame->data[1]);
> >+}
> >+
> >+static void fc_rx_check(hwaddr ba, int mbidx, const FcTestFrame *frame)
> >+{
> >+    uint32_t xpectd_ctrl = frame->expect_overrun ? FLEXCAN_MB_CODE_RX_OVERRUN
> >+                             : FLEXCAN_MB_CODE_RX_FULL;
> >+    xpectd_ctrl |= FLEXCAN_MB_CNT_LENGTH(frame->len) | FLEXCAN_MB_CNT_SRR;
> >+    if (frame->ide) {
> >+        xpectd_ctrl |= FLEXCAN_MB_CNT_IDE;
> >+    }
> >+    if (frame->rtr) {
> >+        xpectd_ctrl |= FLEXCAN_MB_CNT_RTR;
> >+    }
> >+
> >+    uint32_t xpectd_id = frame->ide ? frame->id : frame->id << 18;
> >+
> >+    uint32_t ctrl = readl(FCMB(ba, mbidx, 0)) & FC_MB_CNT_USED_MASK;
> >+    if ((ctrl & FLEXCAN_MB_CODE_MASK) == FLEXCAN_MB_CODE_RX_EMPTY) {
> >+        fprintf(stderr, "expected frame (id=0x%X) not received\n", frame->id);
> >+    }
> >+
> >+    g_assert_cmpuint(ctrl, ==, xpectd_ctrl);
> >+    g_assert_cmpuint(readl(FCMB(ba, mbidx, 1)), ==, xpectd_id);
> >+    g_assert_cmpuint(readl(FCMB(ba, mbidx, 2)), ==, frame->data[0]);
> >+    g_assert_cmpuint(readl(FCMB(ba, mbidx, 3)), ==, frame->data[1]);
> >+}
> >+
> >+static void fc_check_empty_multi(hwaddr ba, int idx_count, int mbidxs[])
> >+{
> >+    for (int i = 0; i < FLEXCAN_MAILBOX_COUNT; i++) {
> >+        bool check_empty = true;
> >+        int ctrl = readl(FCMB(ba, i, 0));
> >+
> >+        for (int j = 0; j < idx_count; j++) {
> >+            if (i == mbidxs[j]) {
> >+                check_empty = false;
> >+            }
> >+        }
> >+
> >+        if (check_empty) {
> >+            if (!(ctrl == FLEXCAN_MB_CODE_RX_EMPTY ||
> >+                  ctrl == FLEXCAN_MB_CODE_RX_INACTIVE)) {
> >+                g_assert_cmpuint(ctrl, ==, FLEXCAN_MB_CODE_RX_INACTIVE);
> >+            }
> >+            g_assert_cmpuint(readl(FCMB(ba, i, 1)), ==, 0);
> >+            g_assert_cmpuint(readl(FCMB(ba, i, 2)), ==, 0);
> >+            g_assert_cmpuint(readl(FCMB(ba, i, 3)), ==, 0);
> >+        } else {
> >+            g_assert_cmpuint(
> >+                ctrl & FLEXCAN_MB_CODE_MASK, !=,
> >+                FLEXCAN_MB_CODE_RX_INACTIVE
> >+            );
> >+        }
> >+    }
> >+}
> >+
> >+static void fc_check_empty(hwaddr ba, int mbidx)
> >+{
> >+    fc_check_empty_multi(ba, 1, &mbidx);
> >+}
> >+
> >+static void flexcan_test_linux_probe_impl(hwaddr fba)
> >+{
> >+    /* -- test a Linux driver-like probe sequence -- */
> >+    /* disable */
> >+    writel(FCREG(fba, mcr), 0xD890000F);
> >+    g_assert_cmpuint(readl(FCREG(fba, mcr)), ==, 0xD890000F);
> >+    g_assert_cmpuint(readl(FCREG(fba, ctrl)), ==, 0);
> >+
> >+    /* set bit in reserved field we do not implement (CTRL_CLK_SRC) */
> >+    writel(FCREG(fba, ctrl), 0x00002000);
> >+    g_assert_cmpuint(readl(FCREG(fba, mcr)), ==, 0xD890000F);
> >+
> >+    /* enable in freeze mode */
> >+    writel(FCREG(fba, mcr), 0x5980000F);
> >+    g_assert_cmpuint(readl(FCREG(fba, mcr)), ==, 0x5980000F);
> >+
> >+    /* enable Rx-FIFO */
> >+    writel(FCREG(fba, mcr), 0x7980000F);
> >+    g_assert_cmpuint(readl(FCREG(fba, mcr)), ==, 0x7980000F);
> >+    g_assert_cmpuint(readl(FCREG(fba, ecr)), ==, 0);
> >+
> >+    /* disable */
> >+    writel(FCREG(fba, mcr), 0xF890000F);
> >+    g_assert_cmpuint(readl(FCREG(fba, mcr)), ==, 0xF890000F);
> >+}
> >+
> >+static void flexcan_test_freeze_disable_interaction_impl(hwaddr fba)
> >+{
> >+    /* -- test normal <=> freeze <=> disable transitions -- */
> >+
> >+    /* leave freeze in disabled, FRZ_ACK should stay cleared */
> >+    writel(FCREG(fba, mcr), 0xF890000F); /* disable */
> >+    g_assert_cmpuint(readl(FCREG(fba, mcr)), ==, 0xF890000F);
> >+    writel(FCREG(fba, mcr), 0xB890000F);  /* by clearing FRZ */
> >+    g_assert_cmpuint(readl(FCREG(fba, mcr)), ==, 0xB890000F);
> >+
> >+    writel(FCREG(fba, mcr), 0xF890000F); /* disable */
> >+    g_assert_cmpuint(readl(FCREG(fba, mcr)), ==, 0xF890000F);
> >+    writel(FCREG(fba, mcr), 0xE890000F);  /* by clearing HALT */
> >+    g_assert_cmpuint(readl(FCREG(fba, mcr)), ==, 0xE890000F);
> >+
> >+    writel(FCREG(fba, mcr), 0xF890000F); /* disable */
> >+    g_assert_cmpuint(readl(FCREG(fba, mcr)), ==, 0xF890000F);
> >+    writel(FCREG(fba, mcr), 0xA890000F);  /* by clearing both */
> >+    g_assert_cmpuint(readl(FCREG(fba, mcr)), ==, 0xA890000F);
> >+
> >+    /* enter and leave freeze */
> >+    writel(FCREG(fba, mcr), 0x7980000F); /* enable in freeze mode */
> >+    g_assert_cmpuint(readl(FCREG(fba, mcr)), ==, 0x7980000F);
> >+    writel(FCREG(fba, mcr), 0x3980000F); /* leave by clearing FRZ */
> >+    g_assert_cmpuint(readl(FCREG(fba, mcr)), ==, 0x3080000F);
> >+
> >+    writel(FCREG(fba, mcr), 0x7980000F); /* enable in freeze mode */
> >+    g_assert_cmpuint(readl(FCREG(fba, mcr)), ==, 0x7980000F);
> >+    writel(FCREG(fba, mcr), 0x6980000F); /* leave by clearing HALT */
> >+    g_assert_cmpuint(readl(FCREG(fba, mcr)), ==, 0x6080000F);
> >+}
> >+
> >+static void flexcan_test_mailbox_io_impl(hwaddr ba_tx, hwaddr ba_rx)
> >+{
> >+    /* -- test correct handling of mailbox IO -- */
> >+    const int test_1_mbidx = 0;
> >+    fc_reset(ba_tx,
> >+             FLEXCAN_MCR_SRX_DIS | FLEXCAN_MCR_MAXMB(FLEXCAN_MAILBOX_COUNT));
> >+    fc_reset(ba_rx,
> >+             FLEXCAN_MCR_SRX_DIS | FLEXCAN_MCR_MAXMB(FLEXCAN_MAILBOX_COUNT));
> >+
> >+    fc_setup_rx_mb(ba_rx, test_1_mbidx);
> >+    fc_tx(ba_tx, test_1_mbidx, &fc_test_frame_1_ide);
> >+    g_assert_cmpuint(fc_get_irqs(ba_rx), ==, 1 << test_1_mbidx);
> >+    fc_rx_check(ba_rx, test_1_mbidx, &fc_test_frame_1_ide);
> >+    readl(FCREG(ba_rx, timer)); /* reset lock */
> >+
> >+    writel(FCMB(ba_rx, test_1_mbidx, 0), 0);
> >+    g_assert_cmpuint(readl(FCMB(ba_rx, test_1_mbidx, 0)), ==, 0);
> >+    writel(FCMB(ba_rx, test_1_mbidx, 1), 0x99AABBCC);
> >+    g_assert_cmpuint(readl(FCMB(ba_rx, test_1_mbidx, 1)), ==, 0x99AABBCC);
> >+}
> >+
> >+static void flexcan_test_dual_transmit_receive_impl(hwaddr ba_tx, hwaddr ba_rx)
> >+{
> >+    /* -- test TX and RX between the two FlexCAN instances -- */
> >+    const int test_1_mbidx = 50;
> >+    const int test_rounds = 50;
> >+
> >+    /* self-receive enabled on tx FC */
> >+    fc_reset(ba_tx,
> >+             FLEXCAN_MCR_MAXMB(FLEXCAN_MAILBOX_COUNT));
> >+    fc_reset(ba_rx,
> >+             FLEXCAN_MCR_SRX_DIS | FLEXCAN_MCR_MAXMB(FLEXCAN_MAILBOX_COUNT));
> >+
> >+    /* tests self-receive on tx and reception on rx */
> >+    fc_setup_rx_mb(ba_rx, test_1_mbidx);
> >+    fc_check_empty(ba_rx, test_1_mbidx);
> >+    fc_setup_rx_mb(ba_tx, test_1_mbidx + 1);
> >+    fc_check_empty(ba_tx, test_1_mbidx + 1);
> >+    g_assert_cmpuint(fc_get_irqs(ba_rx), ==, 0);
> >+    g_assert_cmpuint(fc_get_irqs(ba_tx), ==, 0);
> >+
> >+    fc_tx(ba_tx, test_1_mbidx, &fc_test_frame_1);
> >+    fc_clear_irq(ba_tx, test_1_mbidx);
> >+
> >+    fc_rx_check(ba_rx, test_1_mbidx, &fc_test_frame_1);
> >+    fc_check_empty(ba_rx, test_1_mbidx);
> >+    fc_rx_check(ba_tx, test_1_mbidx + 1, &fc_test_frame_1);
> >+    int tx_non_empty_mbidxs[] = {test_1_mbidx, test_1_mbidx + 1};
> >+
> >+    fc_check_empty_multi(ba_tx, 2, tx_non_empty_mbidxs);
> >+    fc_clear_irq(ba_rx, test_1_mbidx);
> >+    fc_clear_irq(ba_tx, test_1_mbidx + 1);
> >+    readl(FCREG(ba_rx, timer)); /* reset lock */
> >+
> >+    for (int ridx = 0; ridx < test_rounds; ridx++) {
> >+        /* test extended IDs sent to all mailboxes */
> >+        for (int i = 0; i < FLEXCAN_MAILBOX_COUNT; i++) {
> >+            fc_setup_rx_mb(ba_rx, i);
> >+        }
> >+        fc_check_empty_multi(ba_rx, 0, NULL);
> >+        g_assert_cmpuint(fc_get_irqs(ba_rx), ==, 0);
> >+        g_assert_cmpuint(fc_get_irqs(ba_tx), ==, 0);
> >+
> >+        for (int i = 0; i < FLEXCAN_MAILBOX_COUNT; i++) {
> >+            fc_tx(ba_tx, i, &fc_test_frame_1_ide);
> >+        }
> >+        g_assert_cmpuint(fc_get_irqs(ba_rx), ==, UINT64_MAX);
> >+        g_assert_cmpuint(fc_get_irqs(ba_tx), ==, UINT64_MAX);
> >+        for (int i = 0; i < FLEXCAN_MAILBOX_COUNT; i++) {
> >+            fc_rx_check(ba_rx, i, &fc_test_frame_1_ide);
> >+        }
> >+
> >+        /* reset interrupts */
> >+        writel(FCREG(ba_rx, iflag1), UINT32_MAX);
> >+        writel(FCREG(ba_rx, iflag2), UINT32_MAX);
> >+        writel(FCREG(ba_tx, iflag1), UINT32_MAX);
> >+        writel(FCREG(ba_tx, iflag2), UINT32_MAX);
> >+        g_assert_cmpuint(fc_get_irqs(ba_rx), ==, 0);
> >+        g_assert_cmpuint(fc_get_irqs(ba_tx), ==, 0);
> >+    }
> >+}
> >+
> >+static void flexcan_test_tx_abort_impl(hwaddr ba)
> >+{
> >+    /* -- test the TX abort feature -- */
> >+    fc_reset(ba,
> >+             FLEXCAN_MCR_SRX_DIS | FLEXCAN_MCR_MAXMB(FLEXCAN_MAILBOX_COUNT));
> >+
> >+
> >+    for (int mbidx = 0; mbidx < FLEXCAN_MAILBOX_COUNT; mbidx++) {
> >+        fc_tx(ba, mbidx, &fc_test_frame_1);
> >+
> >+        writel(FCMB(ba, mbidx, 0), FLEXCAN_MB_CODE_TX_ABORT);
> >+        g_assert_cmpuint(readl(FCMB(ba, mbidx, 0)), ==,
> >+                         FLEXCAN_MB_CODE_TX_INACTIVE);
> >+    }
> >+}
> >+
> >+static void flexcan_test_freeze_disable_interaction(void)
> >+{
> >+    qtest_start(FC_QEMU_ARGS);
> >+    flexcan_test_freeze_disable_interaction_impl(FSL_IMX6_CAN1_ADDR);
> >+    flexcan_test_freeze_disable_interaction_impl(FSL_IMX6_CAN2_ADDR);
> >+    qtest_end();
> >+}
> >+
> >+static void flexcan_test_linux_probe(void)
> >+{
> >+    qtest_start(FC_QEMU_ARGS);
> >+    flexcan_test_linux_probe_impl(FSL_IMX6_CAN1_ADDR);
> >+    flexcan_test_linux_probe_impl(FSL_IMX6_CAN2_ADDR);
> >+    qtest_end();
> >+}
> >+
> >+static void flexcan_test_dual_transmit_receive(void)
> >+{
> >+    qtest_start(FC_QEMU_ARGS);
> >+    flexcan_test_dual_transmit_receive_impl(FSL_IMX6_CAN1_ADDR,
> >+                                            FSL_IMX6_CAN2_ADDR);
> >+    flexcan_test_dual_transmit_receive_impl(FSL_IMX6_CAN2_ADDR,
> >+                                            FSL_IMX6_CAN1_ADDR);
> >+    qtest_end();
> >+}
> >+
> >+static void flexcan_test_tx_abort(void)
> >+{
> >+    qtest_start(FC_QEMU_ARGS);
> >+    flexcan_test_tx_abort_impl(FSL_IMX6_CAN1_ADDR);
> >+    flexcan_test_tx_abort_impl(FSL_IMX6_CAN2_ADDR);
> >+    qtest_end();
> >+}
> >+
> >+static void flexcan_test_mailbox_io(void)
> >+{
> >+    qtest_start(FC_QEMU_ARGS);
> >+    flexcan_test_mailbox_io_impl(FSL_IMX6_CAN1_ADDR, FSL_IMX6_CAN2_ADDR);
> >+    flexcan_test_mailbox_io_impl(FSL_IMX6_CAN2_ADDR, FSL_IMX6_CAN1_ADDR);
> >+    qtest_end();
> >+}
> >+
> >+int main(int argc, char **argv)
> >+{
> >+    g_test_init(&argc, &argv, NULL);
> >+
> >+    qtest_add_func("/net/flexcan/linux_probe", flexcan_test_linux_probe);
> >+    qtest_add_func("/net/flexcan/freeze_disable_interaction",
> >+                   flexcan_test_freeze_disable_interaction);
> >+    qtest_add_func("/net/flexcan/dual_transmit_receive",
> >+                   flexcan_test_dual_transmit_receive);
> >+    qtest_add_func("/net/flexcan/tx_abort",
> >+                   flexcan_test_tx_abort);
> >+    qtest_add_func("/net/flexcan/mailbox_io", flexcan_test_mailbox_io);
> >+
> >+    return g_test_run();
> >+}
> >diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> >index be4fa627b5..33239f1880 100644
> >--- a/tests/qtest/meson.build
> >+++ b/tests/qtest/meson.build
> >@@ -246,6 +246,7 @@ qtests_arm = \
> >   (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : []) + \
> >   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') ? qtests_stm32l4x5 : []) + \
> >   (config_all_devices.has_key('CONFIG_FSI_APB2OPB_ASPEED') ? ['aspeed_fsi-test'] : []) + \
> >+  (config_all_devices.has_key('CONFIG_CAN_FLEXCAN') ? ['flexcan-test'] : []) + \
> >   (config_all_devices.has_key('CONFIG_STM32L4X5_SOC') and
> >    config_all_devices.has_key('CONFIG_DM163')? ['dm163-test'] : []) + \
> >   ['arm-cpu-features',
> 
> I like that the test attempts to mimic real device driver behavior, which makes its intent recognizable.
> 
> With the license text comment addressed:
> Reviewed-by: Bernhard Beschow <shentey@gmail.com>
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


