Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D268FA375A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 15:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp819-0005zx-G5; Fri, 13 Sep 2024 11:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp80C-0002Is-HA
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:28 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp809-0007oI-Kv
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:27 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-428e1915e18so9431355e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 08:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726240464; x=1726845264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+qmEseTcMrOSnHgL8jCeorP4aRytdfojAHoGyP1GeII=;
 b=oBDVjEB9ba/aQ57rtlMJxM6PC62zQyybK7TuU5e/FHxuIsBndhy4qD7xxkZoW0b4qI
 g4g4uGZ1e5FjxchpGexJ53bI0XK4VgsAVaZO7jpWKLQ7u7428EL6Vlv9TRCeIZ/qwM2r
 9IqgDzsOWD/4uFeYRSJhZkdASePToEE6/T+Id1qNxu2sMo7xBDZK+BJLaKKuJGl1DBJ3
 KpnSEj7RO8Iafz2FV1X3hun7lNEEXWHHA880GZ97SsT6lx4RfvYlCeLblDKsCadfeg0N
 dRH+1vjF4+KgRSz+0qwmgBcrJa3sGssRzziJ4hjhJlknnIuuoyS7kaSs/jCtnd+liWJr
 +inw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726240464; x=1726845264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+qmEseTcMrOSnHgL8jCeorP4aRytdfojAHoGyP1GeII=;
 b=qNuXzbo3pwu1NToKrk5opwSweJsvyXCfgbkcp/9Wxy85Xi2SqAxtsUZxxdZ8xHDbnZ
 a5kYyAduPFYu6b8KHEB/Lqwy5le42mOh27D9KDk3V6ar+wL1L65A1XIC9fRDDnFWFJpy
 R8D51IopWwh6cHpJ9AQU7nE0V3KWdnMLEuQFbGb3+z5qnuWlLojvjS9Qi4o1nSx7Q4wP
 gstGcV/+eBFcn03suKmRnfxkKvSUDLXEiEuYlrhdsYf9wini/UJ7xr5A1/0z/KGXQ+Bx
 rc180L8P0A3braFVmzMNuT0mxLSvGn3PVWlps/qfJRYuqsdFeJC9UzXtnYD68vAoGFPU
 xhbg==
X-Gm-Message-State: AOJu0Yw4dg2xawc7mYVG1G5MSepFzrN2Kg8CwNnfiJG249+VeTYs+5kW
 X4idKOjG/DPg74oy8xn26p+un/ptHyh4mwK3WD6yrJZhoadnIAhNWvsQpuG2hSHPoH7e/E0uuNG
 t
X-Google-Smtp-Source: AGHT+IFYxbaMX04zb+U+FggJrU5vWM6gxCr4aI0NvIZXGvisGj9495ZEOcFHUaIvhANCPVSV0aYMXg==
X-Received: by 2002:a05:600c:4f51:b0:42c:b6db:4270 with SMTP id
 5b1f17b1804b1-42d90722068mr20361455e9.11.1726240463619; 
 Fri, 13 Sep 2024 08:14:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b16bfbfsm29152325e9.22.2024.09.13.08.14.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 08:14:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/27] hw/net/can/xlnx-versal-canfd: Translate CAN ID registers
Date: Fri, 13 Sep 2024 16:14:03 +0100
Message-Id: <20240913151411.2167922-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913151411.2167922-1-peter.maydell@linaro.org>
References: <20240913151411.2167922-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Doug Brown <doug@schmorgal.com>

Previously the emulated CAN ID register was being set to the exact same
value stored in qemu_can_frame.can_id. This doesn't work correctly
because the Xilinx IP core uses a different bit arrangement than
qemu_can_frame for all of its ID registers. Correct this problem for
both RX and TX, including RX filtering.

Signed-off-by: Doug Brown <doug@schmorgal.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Acked-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Message-id: 20240827034927.66659-4-doug@schmorgal.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/can/xlnx-versal-canfd.c | 53 ++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index add1e0fbf17..9e825746736 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -869,6 +869,8 @@ static void regs2frame(XlnxVersalCANFDState *s, qemu_can_frame *frame,
     uint32_t val = 0;
     uint32_t dlc_reg_val = 0;
     uint32_t dlc_value = 0;
+    uint32_t id_reg_val = 0;
+    bool is_rtr = false;
 
     /* Check that reg_num should be within TX register space. */
     assert(reg_num <= R_TB_ID_REGISTER + (NUM_REGS_PER_MSG_SPACE *
@@ -877,7 +879,20 @@ static void regs2frame(XlnxVersalCANFDState *s, qemu_can_frame *frame,
     dlc_reg_val = s->regs[reg_num + 1];
     dlc_value = FIELD_EX32(dlc_reg_val, TB0_DLC_REGISTER, DLC);
 
-    frame->can_id = s->regs[reg_num];
+    id_reg_val = s->regs[reg_num];
+    if (FIELD_EX32(id_reg_val, TB_ID_REGISTER, IDE)) {
+        frame->can_id = (FIELD_EX32(id_reg_val, TB_ID_REGISTER, ID) << 18) |
+                        (FIELD_EX32(id_reg_val, TB_ID_REGISTER, ID_EXT)) |
+                        QEMU_CAN_EFF_FLAG;
+        if (FIELD_EX32(id_reg_val, TB_ID_REGISTER, RTR_RRS)) {
+            is_rtr = true;
+        }
+    } else {
+        frame->can_id = FIELD_EX32(id_reg_val, TB_ID_REGISTER, ID);
+        if (FIELD_EX32(id_reg_val, TB_ID_REGISTER, SRR_RTR_RRS)) {
+            is_rtr = true;
+        }
+    }
 
     if (FIELD_EX32(dlc_reg_val, TB0_DLC_REGISTER, FDF)) {
         /*
@@ -923,6 +938,10 @@ static void regs2frame(XlnxVersalCANFDState *s, qemu_can_frame *frame,
         } else {
             frame->can_dlc = dlc_value;
         }
+
+        if (is_rtr) {
+            frame->can_id |= QEMU_CAN_RTR_FLAG;
+        }
     }
 
     for (j = 0; j < frame->can_dlc; j++) {
@@ -948,6 +967,33 @@ static void process_cancellation_requests(XlnxVersalCANFDState *s)
     canfd_update_irq(s);
 }
 
+static uint32_t frame_to_reg_id(const qemu_can_frame *frame)
+{
+    uint32_t id_reg_val = 0;
+    const bool is_canfd_frame = frame->flags & QEMU_CAN_FRMF_TYPE_FD;
+    const bool is_rtr = !is_canfd_frame && (frame->can_id & QEMU_CAN_RTR_FLAG);
+
+    if (frame->can_id & QEMU_CAN_EFF_FLAG) {
+        id_reg_val |= FIELD_DP32(0, RB_ID_REGISTER, ID,
+                                 (frame->can_id & QEMU_CAN_EFF_MASK) >> 18);
+        id_reg_val |= FIELD_DP32(0, RB_ID_REGISTER, ID_EXT,
+                                 frame->can_id & QEMU_CAN_EFF_MASK);
+        id_reg_val |= FIELD_DP32(0, RB_ID_REGISTER, IDE, 1);
+        id_reg_val |= FIELD_DP32(0, RB_ID_REGISTER, SRR_RTR_RRS, 1);
+        if (is_rtr) {
+            id_reg_val |= FIELD_DP32(0, RB_ID_REGISTER, RTR_RRS, 1);
+        }
+    } else {
+        id_reg_val |= FIELD_DP32(0, RB_ID_REGISTER, ID,
+                                 frame->can_id & QEMU_CAN_SFF_MASK);
+        if (is_rtr) {
+            id_reg_val |= FIELD_DP32(0, RB_ID_REGISTER, SRR_RTR_RRS, 1);
+        }
+    }
+
+    return id_reg_val;
+}
+
 static void store_rx_sequential(XlnxVersalCANFDState *s,
                                 const qemu_can_frame *frame,
                                 uint32_t fill_level, uint32_t read_index,
@@ -999,7 +1045,7 @@ static void store_rx_sequential(XlnxVersalCANFDState *s,
                                                     NUM_REGS_PER_MSG_SPACE));
         }
 
-        s->regs[store_location] = frame->can_id;
+        s->regs[store_location] = frame_to_reg_id(frame);
 
         dlc = frame->can_dlc;
 
@@ -1090,11 +1136,12 @@ static void update_rx_sequential(XlnxVersalCANFDState *s,
     if (s->regs[R_ACCEPTANCE_FILTER_CONTROL_REGISTER]) {
         uint32_t acceptance_filter_status =
                                 s->regs[R_ACCEPTANCE_FILTER_CONTROL_REGISTER];
+        const uint32_t reg_id = frame_to_reg_id(frame);
 
         for (i = 0; i < 32; i++) {
             if (acceptance_filter_status & 0x1) {
                 uint32_t msg_id_masked = s->regs[R_AFMR_REGISTER + 2 * i] &
-                                         frame->can_id;
+                                         reg_id;
                 uint32_t afir_id_masked = s->regs[R_AFIR_REGISTER + 2 * i] &
                                           s->regs[R_AFMR_REGISTER + 2 * i];
                 uint16_t std_msg_id_masked = FIELD_EX32(msg_id_masked,
-- 
2.34.1


