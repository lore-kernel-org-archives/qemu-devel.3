Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72489C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:13:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJa7-0003TK-8V; Mon, 01 Jul 2024 12:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZG-0000pt-Gm
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:50 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sOJZC-0005U8-KN
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:07:50 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ec52fbb50aso37587651fa.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719850063; x=1720454863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MZkBdG186zLNGmCWvbcnLg3ZsyZ6IKvGgCf1O/oJF1E=;
 b=s6t9vnvI1FzACPzi1qAqgdqz11XABJwrFwo3RsOPEh5C5871Kuiac9B7gqPdfPiF5P
 uqMZjnnVL3cmMY43LEvc8rzj/fLIEJBp9oNKgz963chLJeklfqHUwKmBpTqaJIoKXSP3
 CkkhX2OSPju9WwT0RqEngb+EEE+MPhQRzQaOkrzlfE21mQQIwmfmpH8FcrJkQLvWxyrj
 Y1ccKJ2xoXN8HRDw8G1VgcIw1M3O5Ni0PemX/yEIhBhdZmzTE/hh054dsghE3y5Clay1
 nNkasULBv4JqjPX4VnGJYyVWRRw8/8q+g2vKhh9Rjk/UeC3QIWOhptVDSPNWrwh4MxTi
 K+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719850063; x=1720454863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MZkBdG186zLNGmCWvbcnLg3ZsyZ6IKvGgCf1O/oJF1E=;
 b=bCuMtYf1vgyvprM1kqPvbm5F1pdG2LX711QlnRqlTxOWHHOaUc6dLvJR9lJZ6/qpOg
 8Sdg3kTaaES8ioNrNAmEzhGGBoaoCCL6pIjksva/Ll8IfAlooQECGsUA8drafgoUm7Se
 qzlp6XyFgvtL+Xhlts24rwFwI+IyvQbV/1ExpziJJu3J3UNeg+5k+/+NcK23KGoC9+6R
 lJbldNr5lGVfuS2OBF60ugsEnFPNy0CBWe8O2om/2wS9vOmnOxnqsr+cu04nhOhlS6Wg
 FhaGfQGLFlknbtWs4mRtTCBIF8PbfN3j03OQidLy9Cxoysk0rX7ZbBAP0kMXYh6xPNfc
 PEew==
X-Gm-Message-State: AOJu0Ywp3kCZxyF9Aag2nT3S3EMUY9W7a18aV4x45CuHfLHfPv6nvBVx
 +QhlnyfhpyejCPqBt1OC6obilPm/3CRvOjtIc2WKfef6ibesc8t16vEFY7ZhALb4JpEW/ceoCQw
 kTgA=
X-Google-Smtp-Source: AGHT+IE0xHH9zpwnjVu69hFbEROVa5u8NIr23rgrLhhQFbDnOJ37sFuccu1VuD13YCY+HBynsJuIlg==
X-Received: by 2002:a2e:beaa:0:b0:2ec:5668:3b93 with SMTP id
 38308e7fff4ca-2ee5e393845mr55492611fa.12.1719850062557; 
 Mon, 01 Jul 2024 09:07:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af557fesm161952135e9.11.2024.07.01.09.07.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 09:07:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/29] hw/misc/zynq_slcr: Add boot-mode property
Date: Mon,  1 Jul 2024 17:07:24 +0100
Message-Id: <20240701160729.1910763-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240701160729.1910763-1-peter.maydell@linaro.org>
References: <20240701160729.1910763-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x233.google.com
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

From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>

boot-mode property sets user values into BOOT_MODE register, on hardware
these are derived from board switches.

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Message-id: 20240621125906.1300995-2-sai.pavan.boddu@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/zynq_slcr.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index 3412ff099ea..ad814c3a79b 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -24,6 +24,8 @@
 #include "hw/registerfields.h"
 #include "hw/qdev-clock.h"
 #include "qom/object.h"
+#include "hw/qdev-properties.h"
+#include "qapi/error.h"
 
 #ifndef ZYNQ_SLCR_ERR_DEBUG
 #define ZYNQ_SLCR_ERR_DEBUG 0
@@ -121,6 +123,7 @@ REG32(RST_REASON, 0x250)
 
 REG32(REBOOT_STATUS, 0x258)
 REG32(BOOT_MODE, 0x25c)
+    FIELD(BOOT_MODE, BOOT_MODE, 0, 4)
 
 REG32(APU_CTRL, 0x300)
 REG32(WDT_CLK_SEL, 0x304)
@@ -195,6 +198,7 @@ struct ZynqSLCRState {
     Clock *ps_clk;
     Clock *uart0_ref_clk;
     Clock *uart1_ref_clk;
+    uint8_t boot_mode;
 };
 
 /*
@@ -371,7 +375,7 @@ static void zynq_slcr_reset_init(Object *obj, ResetType type)
     s->regs[R_FPGA_RST_CTRL]  = 0x01F33F0F;
     s->regs[R_RST_REASON]     = 0x00000040;
 
-    s->regs[R_BOOT_MODE]      = 0x00000001;
+    s->regs[R_BOOT_MODE]      = s->boot_mode & R_BOOT_MODE_BOOT_MODE_MASK;
 
     /* 0x700 - 0x7D4 */
     for (i = 0; i < 54; i++) {
@@ -588,6 +592,15 @@ static const ClockPortInitArray zynq_slcr_clocks = {
     QDEV_CLOCK_END
 };
 
+static void zynq_slcr_realize(DeviceState *dev, Error **errp)
+{
+    ZynqSLCRState *s = ZYNQ_SLCR(dev);
+
+    if (s->boot_mode > 0xF) {
+        error_setg(errp, "Invalid boot mode %d specified", s->boot_mode);
+    }
+}
+
 static void zynq_slcr_init(Object *obj)
 {
     ZynqSLCRState *s = ZYNQ_SLCR(obj);
@@ -610,15 +623,22 @@ static const VMStateDescription vmstate_zynq_slcr = {
     }
 };
 
+static Property zynq_slcr_props[] = {
+    DEFINE_PROP_UINT8("boot-mode", ZynqSLCRState, boot_mode, 1),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void zynq_slcr_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->vmsd = &vmstate_zynq_slcr;
+    dc->realize = zynq_slcr_realize;
     rc->phases.enter = zynq_slcr_reset_init;
     rc->phases.hold  = zynq_slcr_reset_hold;
     rc->phases.exit  = zynq_slcr_reset_exit;
+    device_class_set_props(dc, zynq_slcr_props);
 }
 
 static const TypeInfo zynq_slcr_info = {
-- 
2.34.1


