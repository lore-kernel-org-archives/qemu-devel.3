Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176E3FA3755
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 15:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp80w-0004Zx-Vm; Fri, 13 Sep 2024 11:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp80C-0002If-Fg
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:28 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp80A-0007og-1v
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:27 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42cbaf9bfdbso9516205e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 08:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726240464; x=1726845264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4FM2OayOf1fgQoj9kOGqYfKVibltYv0skfRKZ4uJLb0=;
 b=bV6sIT27l4TcQiJC7+sczp04VRFUFg5kWJ1Tl5FLHladJ0kKKp0fP+5+aKGe7M0Fpt
 uzmSnTU13muR5mU3lBl09clBAjCG3Vlq6996lIm2llZayUdr+BjTfZp37WmBpy8S5daZ
 vWKcDYo49M96NQOIlieQxcA6CzKNCFL05kKK8tL/F2btp5Tv6t2lW0jFWeU3OMaUZd+D
 eabc+kmfuBodjgTMQRS2c0jVTAUFq5Bp5wa6Y0jJTqsLfWS3/kojIckvYS5pWCxxBXGy
 5Jia1ktMSr5MaVMzLPrYpTZKHJ+ah3BLYOYxzDSf66sSqdeNIbd53AdPhivf4xjiRhTH
 VyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726240464; x=1726845264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4FM2OayOf1fgQoj9kOGqYfKVibltYv0skfRKZ4uJLb0=;
 b=BspLtA/5GNpRgew0aT/5LDJh8DrYgb/JR6NO4UpvhiBX1XruC08wLRwx3VoASTSyV3
 nzB0SY1kp9Cb3W6ulu3KyTgfA2KutGlw1Hw6TaQ+FlDC9Q61A/VU7qxNDw/00FFJkFqn
 WVTnC5KvpD65IY0l9n29/wkKFYQM2hMZHF3ZhGNlMjqP2rzF5R0b0FARbdg0ExsmbVd4
 kT/dnZnSnHEn0T9O3INzj8zFyafHkgRqKwFy49ZZ33h5CY+BHOX1WJXraTZ6j9fe68bc
 RYX7AjY84uAEGZTRT9U62Q2R/+b4klMBxvz/HYhVWXY58ibspWFlBoOL//TNhO4csVxR
 95/g==
X-Gm-Message-State: AOJu0YykWJSUnA8aYhY6Ggom5d4ybG5E6RodQOyJZ+PcIRlDuzY3bvzZ
 yk3996n2gHaVaR26Sjhw0LBWuuKX6gZGjwbsYH5zig/A7/6bGiXrCYUeGSavwIh8HF4RXgJmLgp
 l
X-Google-Smtp-Source: AGHT+IGwOTzOePe/UnrYu2xiijR6YdazFn8f6KJhL9rbu58+fGkIYYYRzjmuPzDi/BgNpY0rLHDziQ==
X-Received: by 2002:a05:600c:45cf:b0:42c:b9b1:8342 with SMTP id
 5b1f17b1804b1-42d90829ad9mr21644355e9.19.1726240464276; 
 Fri, 13 Sep 2024 08:14:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b16bfbfsm29152325e9.22.2024.09.13.08.14.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 08:14:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/27] hw/net/can/xlnx-versal-canfd: Handle flags correctly
Date: Fri, 13 Sep 2024 16:14:04 +0100
Message-Id: <20240913151411.2167922-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913151411.2167922-1-peter.maydell@linaro.org>
References: <20240913151411.2167922-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Add support for QEMU_CAN_FRMF_ESI and QEMU_CAN_FRMF_BRS flags, and
ensure frame->flags is always initialized to 0.

Note that the Xilinx IP core doesn't allow manually setting the ESI bit
during transmits, so it's only implemented for the receive case.

Signed-off-by: Doug Brown <doug@schmorgal.com>
Reviewed-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Message-id: 20240827034927.66659-5-doug@schmorgal.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/can/xlnx-versal-canfd.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index 9e825746736..9fba5b9dfc5 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -872,6 +872,8 @@ static void regs2frame(XlnxVersalCANFDState *s, qemu_can_frame *frame,
     uint32_t id_reg_val = 0;
     bool is_rtr = false;
 
+    frame->flags = 0;
+
     /* Check that reg_num should be within TX register space. */
     assert(reg_num <= R_TB_ID_REGISTER + (NUM_REGS_PER_MSG_SPACE *
                                           s->cfg.tx_fifo));
@@ -913,7 +915,7 @@ static void regs2frame(XlnxVersalCANFDState *s, qemu_can_frame *frame,
          *  15                         49 - 64
          */
 
-        frame->flags = QEMU_CAN_FRMF_TYPE_FD;
+        frame->flags |= QEMU_CAN_FRMF_TYPE_FD;
 
         if (dlc_value < 8) {
             frame->can_dlc = dlc_value;
@@ -921,6 +923,10 @@ static void regs2frame(XlnxVersalCANFDState *s, qemu_can_frame *frame,
             assert((dlc_value - 8) < ARRAY_SIZE(canfd_dlc_array));
             frame->can_dlc = canfd_dlc_array[dlc_value - 8];
         }
+
+        if (FIELD_EX32(dlc_reg_val, TB0_DLC_REGISTER, BRS)) {
+            frame->flags |= QEMU_CAN_FRMF_BRS;
+        }
     } else {
         /*
          * FD Format bit not set that means it is a CAN Frame.
@@ -1058,6 +1064,13 @@ static void store_rx_sequential(XlnxVersalCANFDState *s,
                     dlc_reg_val = FIELD_DP32(0, RB_DLC_REGISTER, DLC, 8 + i);
                 }
             }
+
+            if (frame->flags & QEMU_CAN_FRMF_BRS) {
+                dlc_reg_val |= FIELD_DP32(0, RB_DLC_REGISTER, BRS, 1);
+            }
+            if (frame->flags & QEMU_CAN_FRMF_ESI) {
+                dlc_reg_val |= FIELD_DP32(0, RB_DLC_REGISTER, ESI, 1);
+            }
         } else {
             is_canfd_frame = false;
 
-- 
2.34.1


