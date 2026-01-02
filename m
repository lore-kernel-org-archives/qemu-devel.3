Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8A3FA374B
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Jan 2026 15:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vbh7d-0001gL-Pl; Fri, 02 Jan 2026 10:31:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vbh7c-0001cx-5H
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 10:31:24 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vbh7Z-0007pa-C4
 for qemu-devel@nongnu.org; Fri, 02 Jan 2026 10:31:23 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47796a837c7so78455905e9.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jan 2026 07:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767367879; x=1767972679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=psPRiZDwVMi86tEwW9bt9QRLKCr7U3Z7Bj1DdYhLYxw=;
 b=JVuNnH9UbcYSKgKCxe+5UQ8U6buZri1SxQf1ZHBmJ9PkNsl0c0sdeXHbsOjvR/Z7wq
 KemYIVrFaVealGOnXzj5Xq9K1d7Xc71f53IWDG47/o2i/RbOWg1kTowI7BP/vECCaaAJ
 4xzLT/u+rJRxNn5azE6BFei9sjTDrMlYuO4Es8ZAWFI8eCHu2Wt1r+t6WhOYz+/eQwh2
 KjJS2YzWV2iwwzTZwf+HmQtHInD5qW3aVNMfj7l1I5t9Mic84YoMq1JmgjDjZFdrhR+z
 cOgLMbWdwA6YlwWiTl/oaig2KmE+lGKF4FZONFqXqyXRnajQyRodFx4bkRkYa11a4h7M
 Dc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767367879; x=1767972679;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=psPRiZDwVMi86tEwW9bt9QRLKCr7U3Z7Bj1DdYhLYxw=;
 b=DkUU3pYG6hiohzVmEFuaGOGEnwt4Hf/PkgDS+M47VVqCGms8Ae/5lZ3a7b8+REFwtU
 N8pEymmtzLztn4wXXoNyZaqKBvSfh6MUBYLKhPiXsgBcEU9NtZ/AJe6dGz1e0oN4sHXm
 vdLJYcXQr0RMIgqSff+vZiVrjahndc3GiY8byAL+CLVwm63pBw1I6Aij0kRfVxYZxN1V
 zvpl9C1FcJcx0F4bUup64fN/5ajAaFKrKs1JdgvHAqOMBvF1+srvFNkQMlqbqKx+dJIi
 57S6CKZ7wgmbtra8zY/lc215p4l95MxTpLAHUNQDW1I4KoiaNfb3bVWyV1sliNGRvO/d
 +lDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBc3w6otwLf1j4fsz5DH+1920EeUowddgTwl9xwAWysVcSjdnxX3UNFRpWj0MhJ4H7ctRDUmLakFoH@nongnu.org
X-Gm-Message-State: AOJu0YyC9ERXVlvLCI5/j4F6p0XMEv9YVOaGQcp3X132EEV6teNEJIFu
 FFv5QmaedjS7HKSnTu8mtz0+9D8FhGCKE9Z81oedQ7ZSDad6pZYssUv0
X-Gm-Gg: AY/fxX581vUjvYFpNgew5/KGsQeMxSCvvoGe7uzWmIC76Urglzt16NPP4p9MIMD1R3Y
 VzLYv8irTDjtVKHLKTetPZj721M8ivCmv43xrxiHRvB7e7CEYvQA1yPmuaNcqTwbyW1DhmDHkxb
 GHWSSaTUHlascU6huTh5r5MHJ36JAjqINZlFx4li25epzzgYSr6NqQW94sFxBCfAZCojP6awGH+
 lO0dpZe0jVs4hdRO9O96bQl/DRZkB4V2lvQpIBVdlWpbhI4NJegZnSfRv85Jzp6Y+/Ix6MuS0Jd
 jYZddoTS9Q6YhHCIhLLWWP9Pyy2GNLX9urSb4CkPOB/Es8SBBeuvensjCkbKDXkXRcHzh+Ygkcy
 L1gBbcr+gGmn9fQxMHZI+csW9Igp9FQ+kYfrZ7GhDPpcV/M11GyPBJvvFsVUVhd+GigfTQqlJEG
 ZUKlUHwd2ew37yKDDXaQsUtII4FbnR9A+6lkyuZb+VH2B9yOGHr1lYTtxv6xYPbAcbx9MkGxFRo
 x6KdMAtjrP8i798wCjlmAhkhFxdldj0mQ8=
X-Google-Smtp-Source: AGHT+IEBpmNfBYwJFid12ok3jlrBlkZPcswx37fOt0bwGG+5CUZtF/Aiffo9umCRP4DP+9xpBtFo1g==
X-Received: by 2002:a05:600c:4e8f:b0:477:df7:b020 with SMTP id
 5b1f17b1804b1-47d1957da79mr459031625e9.18.1767367879233; 
 Fri, 02 Jan 2026 07:31:19 -0800 (PST)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-237d-1400-f91d-651c-a220-693b.310.pool.telefonica.de.
 [2a02:3100:237d:1400:f91d:651c:a220:693b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be274e407sm787074345e9.8.2026.01.02.07.31.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jan 2026 07:31:18 -0800 (PST)
Date: Fri, 02 Jan 2026 15:31:17 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?UTF-8?Q?Maty=C3=A1=C5=A1_Bobek?= <matyas.bobek@gmail.com>,
 qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>,
 Pavel Pisa <pisa@fel.cvut.cz>
CC: Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v1 5/6] tests: Add qtests for FlexCAN
In-Reply-To: <2e459b65578c758a60555548e7556d898c53b6e2.1765826753.git.matyas.bobek@gmail.com>
References: <cover.1765826753.git.matyas.bobek@gmail.com>
 <2e459b65578c758a60555548e7556d898c53b6e2.1765826753.git.matyas.bobek@gmail.com>
Message-ID: <854DFA7C-559C-4855-8731-87020AA0620A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x332.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



Am 15=2E Dezember 2025 20:03:14 UTC schrieb "Maty=C3=A1=C5=A1 Bobek" <maty=
as=2Ebobek@gmail=2Ecom>:
>The tests do not test all of the FlexCAN emulator functionality=2E
>There are some duplicate tests for features that were buggy
>in development=2E

What exactly are "duplicate tests" and how did this help?

>
>Signed-off-by: Maty=C3=A1=C5=A1 Bobek <matyas=2Ebobek@gmail=2Ecom>
>---
> MAINTAINERS                |   1 +
> tests/qtest/flexcan-test=2Ec | 411 +++++++++++++++++++++++++++++++++++++
> tests/qtest/meson=2Ebuild    |   1 +
> 3 files changed, 413 insertions(+)
> create mode 100644 tests/qtest/flexcan-test=2Ec
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index a0b152939b=2E=2E2b7fe904c4 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -2859,6 +2859,7 @@ F: net/can/*
> F: hw/net/can/*
> F: include/net/can_*=2Eh
> F: include/hw/net/flexcan=2Eh
>+F: tests/qtest/flexcan-test=2Ec
> F: docs/system/devices/can=2Erst
>=20
> OpenPIC interrupt controller
>diff --git a/tests/qtest/flexcan-test=2Ec b/tests/qtest/flexcan-test=2Ec
>new file mode 100644
>index 0000000000=2E=2E8f3eb5eb8f
>--- /dev/null
>+++ b/tests/qtest/flexcan-test=2Ec
>@@ -0,0 +1,411 @@
>+/*
>+ * QTests for FlexCAN CAN controller device model
>+ *
>+ * Copyright (c) 2025 Matyas Bobek <matyas=2Ebobek@gmail=2Ecom>
>+ *
>+ * This code is licensed under the GPL version 2 or later=2E  See
>+ * the COPYING file in the top-level directory=2E
>+ *
>+ * SPDX-License-Identifier: GPL-2=2E0-or-later
>+ */
>+
>+#include "qemu/osdep=2Eh"
>+#include "libqtest-single=2Eh"
>+
>+#include "hw/net/flexcan=2Eh"
>+#include "hw/net/can/flexcan_regs=2Eh"
>+
>+#define FSL_IMX6_CAN2_ADDR 0x02094000
>+#define FSL_IMX6_CAN2_SIZE 0x4000
>+#define FSL_IMX6_CAN1_ADDR 0x02090000
>+#define FSL_IMX6_CAN1_SIZE 0x4000
>+
>+#define FC_QEMU_ARGS "-nographic -M sabrelite --trace flexcan* " \

Please remove the tracing since it causes excessive debug output (remember=
 that this test will be run in CI)=2E

>+                     "-object can-bus,id=3Dqcan0 " \
>+                     "-machine canbus0=3Dqcan0 -machine canbus1=3Dqcan0"
>+
>+/* used for masking out unused/reserved bits */
>+#define FC_MB_CNT_USED_MASK (~0xF080FFFFu)
>+
>+#define FCREG(BASE_ADDR, REG) ((BASE_ADDR) + offsetof(FlexcanRegs, REG))
>+#define FCMB(BASE_ADDR, MB_IDX, WORD_IDX) (FCREG(BASE_ADDR, mbs) + \
>+    0x10 * (MB_IDX) + 4 * (WORD_IDX))
>+
>+typedef struct FcTestFrame {
>+    uint32_t id;
>+    uint32_t data[2];
>+    uint8_t len;
>+    bool ide;
>+    bool rtr;
>+
>+    /* rx only */
>+    bool expect_overrun;
>+} FcTestFrame;
>+
>+const FcTestFrame fc_test_frame_1 =3D {

Can be static=2E

>+    =2Eid =3D 0x5AF,
>+    =2Elen =3D 8,
>+    =2Edata =3D {
>+        0x01020304,
>+        0x0A0B0C0D
>+    },
>+    =2Eide =3D false
>+};

Please ensure a blank line between functions and other definitions (more c=
ases below)=2E

>+const FcTestFrame fc_test_frame_1_ide =3D {

Can be static=2E

Best regards,
Bernhard

>+    =2Eid =3D 0x105AF5AF,
>+    =2Elen =3D 8,
>+    =2Edata =3D {
>+        0x01020304,
>+        0x0A0B0C0D
>+    },
>+    =2Eide =3D true
>+};
>+
>+static void fc_reset(hwaddr ba, uint32_t mcr_flags)
>+{
>+    /* disable */
>+    writel(FCREG(ba, mcr), 0xD890000F);
>+
>+    /* enable in freeze mode */
>+    writel(FCREG(ba, mcr), 0x5980000F);
>+
>+    /* soft reset */
>+    writel(FCREG(ba, mcr), 0x5980000F | FLEXCAN_MCR_SOFTRST);
>+
>+    g_assert_cmpuint(readl(FCREG(ba, mcr)), =3D=3D, 0x5980000F);
>+    g_assert_cmpuint(readl(FCREG(ba, ctrl)), =3D=3D, 0);
>+    g_assert_cmpuint(readl(FCREG(ba, ctrl2)), =3D=3D, 0);
>+
>+    writel(FCREG(ba, mcr), (0x5980000F & ~FLEXCAN_MCR_HALT) | mcr_flags)=
;
>+    writel(FCREG(ba, ctrl2), FLEXCAN_CTRL2_RRS);
>+
>+    /* initialize all mailboxes as rx inactive */
>+    for (int i =3D 0; i < FLEXCAN_MAILBOX_COUNT; i++) {
>+        writel(FCMB(ba, i, 0), FLEXCAN_MB_CODE_RX_INACTIVE);
>+        writel(FCMB(ba, i, 1), 0);
>+        writel(FCMB(ba, i, 2), 0);
>+        writel(FCMB(ba, i, 3), 0);
>+    }
>+}
>+
>+static uint64_t fc_get_irqs(hwaddr ba)
>+{
>+    return (uint64_t)readl(FCREG(ba, iflag1)) |
>+        ((uint64_t)readl(FCREG(ba, iflag2)) << 32);
>+}
>+static void fc_clear_irq(hwaddr ba, int idx)
>+{
>+    if (idx >=3D 32) {
>+        writel(FCREG(ba, iflag2), (uint32_t)1 << (idx - 32));
>+    } else {
>+        writel(FCREG(ba, iflag1), (uint32_t)1 << idx);
>+    }
>+
>+    g_assert_cmpuint(fc_get_irqs(ba) & ((uint64_t)1 << idx), =3D=3D, 0);
>+}
>+static void fc_setup_rx_mb(hwaddr ba, int mbidx)
>+{
>+    writel(FCMB(ba, mbidx, 0), FLEXCAN_MB_CODE_RX_EMPTY);
>+    writel(FCMB(ba, mbidx, 1), 0);
>+    /* the data value should be ignored for RX mb */
>+    writel(FCMB(ba, mbidx, 2), 0);
>+    writel(FCMB(ba, mbidx, 3), 0);
>+
>+    g_assert_cmpuint(readl(FCMB(ba, mbidx, 0)), =3D=3D, FLEXCAN_MB_CODE_=
RX_EMPTY);
>+}
>+static void fc_tx(hwaddr ba, int mbidx, const FcTestFrame *frame)
>+{
>+    g_assert_cmpuint(frame->len, <=3D, 8);
>+
>+    writel(FCMB(ba, mbidx, 0), FLEXCAN_MB_CODE_TX_INACTIVE);
>+    uint32_t id =3D frame->ide ? frame->id : frame->id << 18;
>+    writel(FCMB(ba, mbidx, 1), id);
>+    writel(FCMB(ba, mbidx, 2), frame->data[0]);
>+    writel(FCMB(ba, mbidx, 3), frame->data[1]);
>+
>+    uint32_t ctrl =3D FLEXCAN_MB_CODE_TX_DATA | FLEXCAN_MB_CNT_LENGTH(fr=
ame->len);
>+    if (frame->ide) {
>+        ctrl |=3D FLEXCAN_MB_CNT_IDE | FLEXCAN_MB_CNT_SRR;
>+    }
>+    if (frame->rtr) {
>+        ctrl |=3D FLEXCAN_MB_CNT_RTR;
>+    }
>+    writel(FCMB(ba, mbidx, 0), ctrl);
>+
>+    /* check frame was transmitted */
>+    g_assert_cmpuint(fc_get_irqs(ba) & ((uint64_t)1 << mbidx),
>+                     !=3D, 0);
>+
>+    uint32_t xpectd_ctrl =3D (ctrl & ~FLEXCAN_MB_CODE_MASK) |
>+        FLEXCAN_MB_CODE_TX_INACTIVE;
>+    g_assert_cmpuint(readl(FCMB(ba, mbidx, 0)) & FC_MB_CNT_USED_MASK, =
=3D=3D,
>+                     xpectd_ctrl);
>+    /* other fields should stay unchanged */
>+    g_assert_cmpuint(readl(FCMB(ba, mbidx, 1)), =3D=3D, id);
>+    g_assert_cmpuint(readl(FCMB(ba, mbidx, 2)), =3D=3D, frame->data[0]);
>+    g_assert_cmpuint(readl(FCMB(ba, mbidx, 3)), =3D=3D, frame->data[1]);
>+}
>+static void fc_rx_check(hwaddr ba, int mbidx, const FcTestFrame *frame)
>+{
>+    uint32_t xpectd_ctrl =3D frame->expect_overrun ? FLEXCAN_MB_CODE_RX_=
OVERRUN
>+                             : FLEXCAN_MB_CODE_RX_FULL;
>+    xpectd_ctrl |=3D FLEXCAN_MB_CNT_LENGTH(frame->len) | FLEXCAN_MB_CNT_=
SRR;
>+    if (frame->ide) {
>+        xpectd_ctrl |=3D FLEXCAN_MB_CNT_IDE;
>+    }
>+    if (frame->rtr) {
>+        xpectd_ctrl |=3D FLEXCAN_MB_CNT_RTR;
>+    }
>+
>+    uint32_t xpectd_id =3D frame->ide ? frame->id : frame->id << 18;
>+
>+    uint32_t ctrl =3D readl(FCMB(ba, mbidx, 0)) & FC_MB_CNT_USED_MASK;
>+    if ((ctrl & FLEXCAN_MB_CODE_MASK) =3D=3D FLEXCAN_MB_CODE_RX_EMPTY) {
>+        fprintf(stderr, "expected frame (id=3D0x%X) not received\n", fra=
me->id);
>+    }
>+
>+    g_assert_cmpuint(ctrl, =3D=3D, xpectd_ctrl);
>+    g_assert_cmpuint(readl(FCMB(ba, mbidx, 1)), =3D=3D, xpectd_id);
>+    g_assert_cmpuint(readl(FCMB(ba, mbidx, 2)), =3D=3D, frame->data[0]);
>+    g_assert_cmpuint(readl(FCMB(ba, mbidx, 3)), =3D=3D, frame->data[1]);
>+}
>+static void fc_check_empty_multi(hwaddr ba, int idx_count, int mbidxs[])
>+{
>+    for (int i =3D 0; i < FLEXCAN_MAILBOX_COUNT; i++) {
>+        int ctrl =3D readl(FCMB(ba, i, 0));
>+        for (int j =3D 0; j < idx_count; j++) {
>+            if (i =3D=3D mbidxs[j]) {
>+                goto non_empty;
>+            }
>+        }
>+
>+        if (!(ctrl =3D=3D FLEXCAN_MB_CODE_RX_EMPTY ||
>+              ctrl =3D=3D FLEXCAN_MB_CODE_RX_INACTIVE)) {
>+            g_assert_cmpuint(ctrl, =3D=3D, FLEXCAN_MB_CODE_RX_INACTIVE);
>+        }
>+        g_assert_cmpuint(readl(FCMB(ba, i, 1)), =3D=3D, 0);
>+        g_assert_cmpuint(readl(FCMB(ba, i, 2)), =3D=3D, 0);
>+        g_assert_cmpuint(readl(FCMB(ba, i, 3)), =3D=3D, 0);
>+        continue;
>+
>+        non_empty:
>+        g_assert_cmpuint(
>+            ctrl & FLEXCAN_MB_CODE_MASK, !=3D,
>+            FLEXCAN_MB_CODE_RX_INACTIVE
>+        );
>+    }
>+}
>+static void fc_check_empty(hwaddr ba, int mbidx)
>+{
>+    fc_check_empty_multi(ba, 1, &mbidx);
>+}
>+
>+static void flexcan_test_linux_probe_impl(hwaddr fba)
>+{
>+    /* -- test Linux driver-like probe sequence -- */
>+    /* disable */
>+    writel(FCREG(fba, mcr), 0xD890000F);
>+    g_assert_cmpuint(readl(FCREG(fba, mcr)), =3D=3D, 0xD890000F);
>+    g_assert_cmpuint(readl(FCREG(fba, ctrl)), =3D=3D, 0);
>+
>+    /* set bit in reserved field we do not implement (CTRL_CLK_SRC) */
>+    writel(FCREG(fba, ctrl), 0x00002000);
>+    g_assert_cmpuint(readl(FCREG(fba, mcr)), =3D=3D, 0xD890000F);
>+
>+    /* enable in freeze mode */
>+    writel(FCREG(fba, mcr), 0x5980000F);
>+    g_assert_cmpuint(readl(FCREG(fba, mcr)), =3D=3D, 0x5980000F);
>+
>+    /* enable Rx-FIFO */
>+    writel(FCREG(fba, mcr), 0x7980000F);
>+    g_assert_cmpuint(readl(FCREG(fba, mcr)), =3D=3D, 0x7980000F);
>+    g_assert_cmpuint(readl(FCREG(fba, ecr)), =3D=3D, 0);
>+
>+    /* disable */
>+    writel(FCREG(fba, mcr), 0xF890000F);
>+    g_assert_cmpuint(readl(FCREG(fba, mcr)), =3D=3D, 0xF890000F);
>+}
>+
>+static void flexcan_test_freeze_disable_interaction_impl(hwaddr fba)
>+{
>+    /* -- test normal <=3D> freeze <=3D> disable transitions -- */
>+
>+    /* leave freeze in disabled, FRZ_ACK should stay cleared */
>+    writel(FCREG(fba, mcr), 0xF890000F); /* disable */
>+    g_assert_cmpuint(readl(FCREG(fba, mcr)), =3D=3D, 0xF890000F);
>+    writel(FCREG(fba, mcr), 0xB890000F);  /* by clearing FRZ */
>+    g_assert_cmpuint(readl(FCREG(fba, mcr)), =3D=3D, 0xB890000F);
>+
>+    writel(FCREG(fba, mcr), 0xF890000F); /* disable */
>+    g_assert_cmpuint(readl(FCREG(fba, mcr)), =3D=3D, 0xF890000F);
>+    writel(FCREG(fba, mcr), 0xE890000F);  /* by clearing HALT */
>+    g_assert_cmpuint(readl(FCREG(fba, mcr)), =3D=3D, 0xE890000F);
>+
>+    writel(FCREG(fba, mcr), 0xF890000F); /* disable */
>+    g_assert_cmpuint(readl(FCREG(fba, mcr)), =3D=3D, 0xF890000F);
>+    writel(FCREG(fba, mcr), 0xA890000F);  /* by clearing both */
>+    g_assert_cmpuint(readl(FCREG(fba, mcr)), =3D=3D, 0xA890000F);
>+
>+    /* enter and leave freeze */
>+    writel(FCREG(fba, mcr), 0x7980000F); /* enable in freeze mode */
>+    g_assert_cmpuint(readl(FCREG(fba, mcr)), =3D=3D, 0x7980000F);
>+    writel(FCREG(fba, mcr), 0x3980000F); /* leave by clearing FRZ */
>+    g_assert_cmpuint(readl(FCREG(fba, mcr)), =3D=3D, 0x3080000F);
>+
>+    writel(FCREG(fba, mcr), 0x7980000F); /* enable in freeze mode */
>+    g_assert_cmpuint(readl(FCREG(fba, mcr)), =3D=3D, 0x7980000F);
>+    writel(FCREG(fba, mcr), 0x6980000F); /* leave by clearing HALT */
>+    g_assert_cmpuint(readl(FCREG(fba, mcr)), =3D=3D, 0x6080000F);
>+}
>+
>+static void flexcan_test_mailbox_io_impl(hwaddr ba_tx, hwaddr ba_rx)
>+{
>+    /* -- test correct handling of mailbox IO -- */
>+    const int test_1_mbidx =3D 0;
>+    fc_reset(ba_tx,
>+             FLEXCAN_MCR_SRX_DIS | FLEXCAN_MCR_MAXMB(FLEXCAN_MAILBOX_COU=
NT));
>+    fc_reset(ba_rx,
>+             FLEXCAN_MCR_SRX_DIS | FLEXCAN_MCR_MAXMB(FLEXCAN_MAILBOX_COU=
NT));
>+
>+    fc_setup_rx_mb(ba_rx, test_1_mbidx);
>+    fc_tx(ba_tx, test_1_mbidx, &fc_test_frame_1_ide);
>+    g_assert_cmpuint(fc_get_irqs(ba_rx), =3D=3D, 1 << test_1_mbidx);
>+    fc_rx_check(ba_rx, test_1_mbidx, &fc_test_frame_1_ide);
>+    readl(FCREG(ba_rx, timer)); /* reset lock */
>+
>+    writel(FCMB(ba_rx, test_1_mbidx, 0), 0);
>+    g_assert_cmpuint(readl(FCMB(ba_rx, test_1_mbidx, 0)), =3D=3D, 0);
>+    writel(FCMB(ba_rx, test_1_mbidx, 1), 0x99AABBCC);
>+    g_assert_cmpuint(readl(FCMB(ba_rx, test_1_mbidx, 1)), =3D=3D, 0x99AA=
BBCC);
>+}
>+
>+static void flexcan_test_dual_transmit_receive_impl(hwaddr ba_tx, hwaddr=
 ba_rx)
>+{
>+    /* -- test TX and RX between the two FlexCAN instances -- */
>+    const int test_1_mbidx =3D 50;
>+    const int test_rounds =3D 50;
>+
>+    /* self-receive enabled on tx FC */
>+    fc_reset(ba_tx,
>+             FLEXCAN_MCR_MAXMB(FLEXCAN_MAILBOX_COUNT));
>+    fc_reset(ba_rx,
>+             FLEXCAN_MCR_SRX_DIS | FLEXCAN_MCR_MAXMB(FLEXCAN_MAILBOX_COU=
NT));
>+
>+    /* tests self-receive on tx and reception on rx */
>+    fc_setup_rx_mb(ba_rx, test_1_mbidx);
>+    fc_check_empty(ba_rx, test_1_mbidx);
>+    fc_setup_rx_mb(ba_tx, test_1_mbidx + 1);
>+    fc_check_empty(ba_tx, test_1_mbidx + 1);
>+    g_assert_cmpuint(fc_get_irqs(ba_rx), =3D=3D, 0);
>+    g_assert_cmpuint(fc_get_irqs(ba_tx), =3D=3D, 0);
>+
>+    fc_tx(ba_tx, test_1_mbidx, &fc_test_frame_1);
>+    fc_clear_irq(ba_tx, test_1_mbidx);
>+
>+    fc_rx_check(ba_rx, test_1_mbidx, &fc_test_frame_1);
>+    fc_check_empty(ba_rx, test_1_mbidx);
>+    fc_rx_check(ba_tx, test_1_mbidx + 1, &fc_test_frame_1);
>+    int tx_non_empty_mbidxs[] =3D {test_1_mbidx, test_1_mbidx + 1};
>+
>+    fc_check_empty_multi(ba_tx, 2, tx_non_empty_mbidxs);
>+    fc_clear_irq(ba_rx, test_1_mbidx);
>+    fc_clear_irq(ba_tx, test_1_mbidx + 1);
>+    readl(FCREG(ba_rx, timer)); /* reset lock */
>+
>+    for (int ridx =3D 0; ridx < test_rounds; ridx++) {
>+        /* test extended IDs sent to all mailboxes */
>+        for (int i =3D 0; i < FLEXCAN_MAILBOX_COUNT; i++) {
>+            fc_setup_rx_mb(ba_rx, i);
>+        }
>+        fc_check_empty_multi(ba_rx, 0, NULL);
>+        g_assert_cmpuint(fc_get_irqs(ba_rx), =3D=3D, 0);
>+        g_assert_cmpuint(fc_get_irqs(ba_tx), =3D=3D, 0);
>+
>+        for (int i =3D 0; i < FLEXCAN_MAILBOX_COUNT; i++) {
>+            fc_tx(ba_tx, i, &fc_test_frame_1_ide);
>+        }
>+        g_assert_cmpuint(fc_get_irqs(ba_rx), =3D=3D, UINT64_MAX);
>+        g_assert_cmpuint(fc_get_irqs(ba_tx), =3D=3D, UINT64_MAX);
>+        for (int i =3D 0; i < FLEXCAN_MAILBOX_COUNT; i++) {
>+            fc_rx_check(ba_rx, i, &fc_test_frame_1_ide);
>+        }
>+
>+        /* reset interrupts */
>+        writel(FCREG(ba_rx, iflag1), UINT32_MAX);
>+        writel(FCREG(ba_rx, iflag2), UINT32_MAX);
>+        writel(FCREG(ba_tx, iflag1), UINT32_MAX);
>+        writel(FCREG(ba_tx, iflag2), UINT32_MAX);
>+        g_assert_cmpuint(fc_get_irqs(ba_rx), =3D=3D, 0);
>+        g_assert_cmpuint(fc_get_irqs(ba_tx), =3D=3D, 0);
>+    }
>+}
>+
>+static void flexcan_test_tx_abort_impl(hwaddr ba)
>+{
>+    /* -- test the TX abort feature -- */
>+    fc_reset(ba,
>+             FLEXCAN_MCR_SRX_DIS | FLEXCAN_MCR_MAXMB(FLEXCAN_MAILBOX_COU=
NT));
>+
>+
>+    for (int mbidx =3D 0; mbidx < FLEXCAN_MAILBOX_COUNT; mbidx++) {
>+        fc_tx(ba, mbidx, &fc_test_frame_1);
>+
>+        writel(FCMB(ba, mbidx, 0), FLEXCAN_MB_CODE_TX_ABORT);
>+        g_assert_cmpuint(readl(FCMB(ba, mbidx, 0)), =3D=3D,
>+                         FLEXCAN_MB_CODE_TX_INACTIVE);
>+    }
>+}
>+
>+static void flexcan_test_freeze_disable_interaction(void)
>+{
>+    qtest_start(FC_QEMU_ARGS);
>+    flexcan_test_freeze_disable_interaction_impl(FSL_IMX6_CAN1_ADDR);
>+    flexcan_test_freeze_disable_interaction_impl(FSL_IMX6_CAN2_ADDR);
>+    qtest_end();
>+}
>+static void flexcan_test_linux_probe(void)
>+{
>+    qtest_start(FC_QEMU_ARGS);
>+    flexcan_test_linux_probe_impl(FSL_IMX6_CAN1_ADDR);
>+    flexcan_test_linux_probe_impl(FSL_IMX6_CAN2_ADDR);
>+    qtest_end();
>+}
>+static void flexcan_test_dual_transmit_receive(void)
>+{
>+    qtest_start(FC_QEMU_ARGS);
>+    flexcan_test_dual_transmit_receive_impl(FSL_IMX6_CAN1_ADDR,
>+                                            FSL_IMX6_CAN2_ADDR);
>+    flexcan_test_dual_transmit_receive_impl(FSL_IMX6_CAN2_ADDR,
>+                                            FSL_IMX6_CAN1_ADDR);
>+    qtest_end();
>+}
>+static void flexcan_test_tx_abort(void)
>+{
>+    qtest_start(FC_QEMU_ARGS);
>+    flexcan_test_tx_abort_impl(FSL_IMX6_CAN1_ADDR);
>+    flexcan_test_tx_abort_impl(FSL_IMX6_CAN2_ADDR);
>+    qtest_end();
>+}
>+static void flexcan_test_mailbox_io(void)
>+{
>+    qtest_start(FC_QEMU_ARGS);
>+    flexcan_test_mailbox_io_impl(FSL_IMX6_CAN1_ADDR, FSL_IMX6_CAN2_ADDR)=
;
>+    flexcan_test_mailbox_io_impl(FSL_IMX6_CAN2_ADDR, FSL_IMX6_CAN1_ADDR)=
;
>+    qtest_end();
>+}
>+
>+int main(int argc, char **argv)
>+{
>+    g_test_init(&argc, &argv, NULL);
>+
>+    qtest_add_func("flexcan/test_linux_probe", flexcan_test_linux_probe)=
;
>+    qtest_add_func("flexcan/test_freeze_disable_interaction",
>+                   flexcan_test_freeze_disable_interaction);
>+    qtest_add_func("flexcan/test_dual_transmit_receive",
>+                   flexcan_test_dual_transmit_receive);
>+    qtest_add_func("flexcan/test_tx_abort",
>+                   flexcan_test_tx_abort);
>+    qtest_add_func("flexcan/test_mailbox_io", flexcan_test_mailbox_io);
>+
>+    return g_test_run();
>+}
>diff --git a/tests/qtest/meson=2Ebuild b/tests/qtest/meson=2Ebuild
>index 669d07c06b=2E=2Ec081075161 100644
>--- a/tests/qtest/meson=2Ebuild
>+++ b/tests/qtest/meson=2Ebuild
>@@ -246,6 +246,7 @@ qtests_arm =3D \
>   (config_all_devices=2Ehas_key('CONFIG_MICROBIT') ? ['microbit-test'] :=
 []) + \
>   (config_all_devices=2Ehas_key('CONFIG_STM32L4X5_SOC') ? qtests_stm32l4=
x5 : []) + \
>   (config_all_devices=2Ehas_key('CONFIG_FSI_APB2OPB_ASPEED') ? ['aspeed_=
fsi-test'] : []) + \
>+  (config_all_devices=2Ehas_key('CONFIG_CAN_FLEXCAN') ? ['flexcan-test']=
 : []) + \
>   (config_all_devices=2Ehas_key('CONFIG_STM32L4X5_SOC') and
>    config_all_devices=2Ehas_key('CONFIG_DM163')? ['dm163-test'] : []) + =
\
>   ['arm-cpu-features',

