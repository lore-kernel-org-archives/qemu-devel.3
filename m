Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603B1CD4F24
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 10:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN7J2-0006PP-7Q; Wed, 13 May 2026 06:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wN7Fd-0003B2-SH
 for qemu-devel@nongnu.org; Wed, 13 May 2026 06:55:47 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wN7FX-0001QC-89
 for qemu-devel@nongnu.org; Wed, 13 May 2026 06:55:40 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48e56c1bf5dso40004105e9.3
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 03:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778669732; x=1779274532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k6VI4nokCfZ+LKIGnO4eT2U19gP+31CsGFQKC59urGA=;
 b=BPJEblvT00vyWHz5mhhlHbPWsskL0sM/jlFYPx/QIs9+mWe3VmjicMJpUlP7ny1eTI
 WGPqR0cXcHzxSniovnnahHd5KnrIgeJDPauEDZNWjS3i1JKdZv5TsqPehGZR4TjkRP2K
 23wQEnwlmauWuk9LoPIbE8an81Q/LW7k3wSK/JtWC5vVLWUT/HzOBOZSIkkeWPW6fqKQ
 7uFGW/XgEpt5qJ93sw0bqOmisEN/kEDtA4k1aiIbpULoxDburA0nncq5Vu2QiaB1VNFm
 JqM0YMvfc6PsfJY9a0qo7eLRaHKgzt7HMARP0DCRkqirnKAiMFr0ombaPvhUBIu7ho+v
 NJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778669732; x=1779274532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k6VI4nokCfZ+LKIGnO4eT2U19gP+31CsGFQKC59urGA=;
 b=kvzlltKONWA+HS/Ku++twVrDD2YLSmJUQ/1nTh3VK0KVMlyNuTznzH5L++U6oTOlu9
 FiNnMQUZnBJ1eD+sBEaEF5jYtqq5K8V/dwQS/E2NlslQfQquZa/nEdNpfE4sPVZnhkrA
 gErFvJrYv6aq8XOGnrc5W1HZtOcAx+d96EOtTbY3LzpMugFjioBsi+gwHo8PURbWCWuK
 QtA44Qi9funvYvP9mjg5I2bTdBcz+zyRLy5zq7Ux5NHdcVHp23YVIAPl131HY4eGu7k4
 zDA6Hc/X/Yj8IgUhj6MT2H/aiH3vgeVVQCSxokO7dOUDfv9LSii5uiNT05ReMSNj5KbH
 c57g==
X-Gm-Message-State: AOJu0Yz2lU3ER9x87u1abudty+5V4GVtJ8sL5HuKiLJlh+hYYwIG8Ixp
 BkqRARQ0ZBXp1CJ2bPt7t2Or2ucDlanBvJq0twj+MB6ENug3mzEsq8D8uOBEbgQy
X-Gm-Gg: Acq92OHPj3cN6apam9s849y9+3orfepqPEzDaTgmu9WO52+LGtNsHudkrtuoPUby1vw
 3kPOAJnipv0RqaF4RJIuC2IHKBKj34kL2kG/FW4NvB3N5rFoLzvlyQtJFROLGGHgdr41ko39AHH
 8c37HGNg3cYShcz5kMQyel/D3qxkUAlq6P35/iVL6CEh/md98Ip1fCAxNWJ7H+QlpFOCDu4U0aU
 EAO7Nm0Y+W2y71VtvQV+WqUXNuNtLPXGx22l8FL8BfkleyVAtSiRVOfr/1wboNaSrFZAQcVjK/J
 rtSfWcwW9BYJiQ9xbzWiC5yKypMLjcpD3sYBap7tdWgI3fHTP2cIqVfCqc7NAk+NEQQFL8NJyZu
 5h1NLNosvLS2LWwpRoYdo5eJ94C48xIodxhSolaNLr8zJSym6ssSSH4yIQmyjkTIuBytpsu0Uc0
 qOu886oqwbhXw1l00Hlg3TuWtAdxTiz4MR6iNp56xQh5E3
X-Received: by 2002:a05:600c:468e:b0:48a:6fd4:d3d3 with SMTP id
 5b1f17b1804b1-48fc9a3d8c5mr36985055e9.20.1778669732417; 
 Wed, 13 May 2026 03:55:32 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com ([195.226.174.196])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f410d9fsm56062295e9.6.2026.05.13.03.55.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 03:55:31 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 YannickV <Y.Vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v6 09/15] hw/misc/zynq_slcr: Add logic for DCI configuration
Date: Wed, 13 May 2026 12:55:11 +0200
Message-ID: <20260513105517.146706-10-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260513105517.146706-1-corvin.koehne@gmail.com>
References: <20260513105517.146706-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: YannickV <Y.Vossen@beckhoff.com>

The registers for the digitally controlled impedance (DCI) clock are
part of the system level control registers (SLCR). The DONE bit in
the status register indicates a successfull DCI calibration. An
description of the calibration process can be found here:
https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/DDR-IOB-Impedance-Calibration

The DCI control register and status register have been added. As soon
as the ENABLE and RESET bit are set, the RESET bit has also been toggled
to 0 before and the UPDATE_CONTROL is not set, the DONE bit in the status
register is set. If these bits change the DONE bit is reset. Note that the
option bits are not taken into consideration.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/misc/zynq_slcr.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index faae98fa02..0ae5d607be 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -180,6 +180,12 @@ REG32(GPIOB_CFG_HSTL, 0xb14)
 REG32(GPIOB_DRVR_BIAS_CTRL, 0xb18)
 
 REG32(DDRIOB, 0xb40)
+REG32(DDRIOB_DCI_CTRL, 0xb70)
+    FIELD(DDRIOB_DCI_CTRL, RESET, 0, 1)
+    FIELD(DDRIOB_DCI_CTRL, ENABLE, 1, 1)
+    FIELD(DDRIOB_DCI_CTRL, UPDATE_CONTROL, 20, 1)
+REG32(DDRIOB_DCI_STATUS, 0xb74)
+    FIELD(DDRIOB_DCI_STATUS, DONE, 13, 1)
 #define DDRIOB_LENGTH 14
 
 #define ZYNQ_SLCR_MMIO_SIZE     0x1000
@@ -193,6 +199,8 @@ struct ZynqSLCRState {
 
     MemoryRegion iomem;
 
+    bool ddriob_dci_ctrl_reset_toggled;
+
     uint32_t regs[ZYNQ_SLCR_NUM_REGS];
 
     Clock *ps_clk;
@@ -331,6 +339,8 @@ static void zynq_slcr_reset_init(Object *obj, ResetType type)
 
     DB_PRINT("RESET\n");
 
+    s->ddriob_dci_ctrl_reset_toggled = false;
+
     s->regs[R_LOCKSTA] = 1;
     /* 0x100 - 0x11C */
     s->regs[R_ARM_PLL_CTRL]   = 0x0001A008;
@@ -418,6 +428,8 @@ static void zynq_slcr_reset_init(Object *obj, ResetType type)
     s->regs[R_DDRIOB + 4] = s->regs[R_DDRIOB + 5] = s->regs[R_DDRIOB + 6]
                           = 0x00000e00;
     s->regs[R_DDRIOB + 12] = 0x00000021;
+
+    s->regs[R_DDRIOB_DCI_CTRL] = 0x00000020;
 }
 
 static void zynq_slcr_reset_hold(Object *obj, ResetType type)
@@ -554,6 +566,25 @@ static void zynq_slcr_write(void *opaque, hwaddr offset,
                 (int)offset, (unsigned)val & 0xFFFF);
         }
         return;
+
+    case R_DDRIOB_DCI_CTRL:
+        if (!FIELD_EX32(val, DDRIOB_DCI_CTRL, RESET) &&
+            FIELD_EX32(s->regs[R_DDRIOB_DCI_CTRL], DDRIOB_DCI_CTRL, RESET)) {
+
+            s->ddriob_dci_ctrl_reset_toggled = true;
+            DB_PRINT("DDRIOB DCI CTRL RESET was toggled\n");
+        }
+
+        if (FIELD_EX32(val, DDRIOB_DCI_CTRL, ENABLE) &&
+            FIELD_EX32(val, DDRIOB_DCI_CTRL, RESET) &&
+            !FIELD_EX32(val, DDRIOB_DCI_CTRL, UPDATE_CONTROL) &&
+            s->ddriob_dci_ctrl_reset_toggled) {
+
+            s->regs[R_DDRIOB_DCI_STATUS] |= R_DDRIOB_DCI_STATUS_DONE_MASK;
+        } else {
+            s->regs[R_DDRIOB_DCI_STATUS] &= ~R_DDRIOB_DCI_STATUS_DONE_MASK;
+        }
+        break;
     }
 
     if (s->regs[R_LOCKSTA]) {
-- 
2.47.3


