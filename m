Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B3FC52D7D
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2024 10:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfGeI-0007xO-8c; Sat, 17 Aug 2024 06:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <32HrAZgUKCg06n8v2t11tyr.p1z3rz7-qr8ry010t07.14t@flex--tavip.bounces.google.com>)
 id 1sfGdy-0006U2-4n
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 06:26:48 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <32HrAZgUKCg06n8v2t11tyr.p1z3rz7-qr8ry010t07.14t@flex--tavip.bounces.google.com>)
 id 1sfGdt-0003IH-Cc
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 06:26:42 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-6ad97b9a0fbso54639587b3.0
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2024 03:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1723890393; x=1724495193; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=gYjLNYCYgmz+RuXhYlYlEGx1aZzBL8oMAQt3ozgBUbM=;
 b=MOtUUm6NUoHEj82igudWWXZ2Yqe9b1KHRBGUzet6PvF11kBlVNiBNNdN45c9fRld4S
 73zQ25j22bfi0SIiahF0H5xEUL3EvC8KLcMtvDsVnyBcoJBGelkuhs7ZbHnzwehjz3SH
 GN+S+FGAVFKlqZabSZn6NUFfadzJYpotpCVnDCeebaDamhqk/BqelW0aRKtmoSrxhCFm
 AqK9FPRtnZdiXhXAfx3E89ZsjgYa6tWNaO2EnNSBhIdKXgP8VWdenat1yfxmMxcgaePJ
 aUaIFBCoK20SpHdTzeKtTz3YsI42Tygc8Q9bvw2VFLN1BTgRTHYzqgbAIZu6tK2dsD8g
 5EeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723890393; x=1724495193;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gYjLNYCYgmz+RuXhYlYlEGx1aZzBL8oMAQt3ozgBUbM=;
 b=PYqRW/r4IMONHwKxizcWiiDBJE66sNy9UdIuqBUPra8J25hC5qylvMnBd/YPQCi7Ie
 lnpEwIwElsG1QGw04E1ACKF84FRLbhimSQB9koBTfJ19HE4Xkh9XR4aeIEBdGNy79XBG
 jPx3jWsu0lteidpGRcqggTagIzy4KUSbRa/5MvocKpAmSfO5YcVXXE4uxicpa2Wu61BC
 Tu10PJdRmr/z0lTgFTcucAIggv2Chu/SmUm4vKjRpgt+MXLK7UMA8eVofR+zTog0ttno
 X9RGRhNKDSNElhuL9iLyLdZdDl5alL7uH1la85Z2D8ghALdXvUF6Hus9SMtOuzjgtoxo
 AQwA==
X-Gm-Message-State: AOJu0YzOOpjaHuWXqukNnkvzOp05FQEnUf0cFmAnT7VAQXkxKIpnrDNO
 o9EdYk3OzaHXgY28R4MnkFX8Ydg6aJeWjL6u/ERtGcRWTQAwJrfrBu/R/fwh41PATT8ggZMmeEP
 iZPKgImJJEZBTdM+t3BRZpmm8bwDzCKE5ubsq4J/XLHTMrPILlzGUvp53em2IHzSZwQbpQoJ5gF
 UuQBi1T7sRCDGE9/wMIWe7cUIZNg==
X-Google-Smtp-Source: AGHT+IFaSSK3fanWGDJUNkBK2HfyOfl2bt5nAD1Ig09UZk8Dtz9NOsOMcyLz694GaIx1PKSs08n99tEEGw==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a05:690c:2b13:b0:673:b39a:92f2
 with SMTP id
 00721157ae682-6b1baeae4ccmr303877b3.7.1723890392821; Sat, 17 Aug 2024
 03:26:32 -0700 (PDT)
Date: Sat, 17 Aug 2024 03:25:56 -0700
In-Reply-To: <20240817102606.3996242-1-tavip@google.com>
Mime-Version: 1.0
References: <20240817102606.3996242-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240817102606.3996242-14-tavip@google.com>
Subject: [RFC PATCH v2 13/23] test/unit: add i2c-tester
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 thuth@redhat.com, peter.maydell@linaro.org, marcandre.lureau@redhat.com, 
 alistair@alistair23.me, berrange@redhat.com, philmd@linaro.org, 
 jsnow@redhat.com, crosa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=32HrAZgUKCg06n8v2t11tyr.p1z3rz7-qr8ry010t07.14t@flex--tavip.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Add a simple i2c peripheral to be used for testing I2C device
models. The peripheral has a fixed number of registers that can be
read and written.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 tests/unit/i2c_tester.h |  30 +++++++++++
 tests/unit/i2c_tester.c | 108 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 138 insertions(+)
 create mode 100644 tests/unit/i2c_tester.h
 create mode 100644 tests/unit/i2c_tester.c

diff --git a/tests/unit/i2c_tester.h b/tests/unit/i2c_tester.h
new file mode 100644
index 0000000000..14cf2ead36
--- /dev/null
+++ b/tests/unit/i2c_tester.h
@@ -0,0 +1,30 @@
+/*
+ *
+ * Copyright (c) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef TESTS_UNIT_I2C_TESTER_H
+#define TESTS_UNIT_I2C_TESTER_H
+
+#include "qemu/osdep.h"
+#include "hw/i2c/i2c.h"
+#include "hw/irq.h"
+
+#define I2C_TESTER_NUM_REGS    0x31
+
+#define TYPE_I2C_TESTER "i2c_tester"
+#define I2C_TESTER(obj) OBJECT_CHECK(I2cTesterState, (obj), TYPE_I2C_TESTER)
+
+typedef struct {
+    I2CSlave i2c;
+    bool set_reg_idx;
+    uint8_t reg_idx;
+    uint8_t regs[I2C_TESTER_NUM_REGS];
+} I2cTesterState;
+
+#endif /* TESTS_UNIT_I2C_TESTER_H */
diff --git a/tests/unit/i2c_tester.c b/tests/unit/i2c_tester.c
new file mode 100644
index 0000000000..2e4314fe6e
--- /dev/null
+++ b/tests/unit/i2c_tester.c
@@ -0,0 +1,108 @@
+/*
+ * Simple I2C peripheral for testing I2C device models.
+ *
+ * Copyright (c) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "i2c_tester.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+static void i2c_tester_reset(DeviceState *ds)
+{
+    I2cTesterState *s = I2C_TESTER(ds);
+
+    s->set_reg_idx = false;
+    s->reg_idx     = 0;
+    memset(s->regs, 0, I2C_TESTER_NUM_REGS);
+}
+
+static int i2c_tester_event(I2CSlave *i2c, enum i2c_event event)
+{
+    I2cTesterState *s = I2C_TESTER(i2c);
+
+    if (event == I2C_START_SEND) {
+        s->set_reg_idx = true;
+    }
+
+    return 0;
+}
+
+static uint8_t i2c_tester_rx(I2CSlave *i2c)
+{
+    I2cTesterState *s = I2C_TESTER(i2c);
+
+    if (s->reg_idx >= I2C_TESTER_NUM_REGS) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid reg 0x%02x\n", __func__,
+                      s->reg_idx);
+        return I2C_NACK;
+    }
+
+    return s->regs[s->reg_idx];
+}
+
+static int i2c_tester_tx(I2CSlave *i2c, uint8_t data)
+{
+    I2cTesterState *s = I2C_TESTER(i2c);
+
+    if (s->set_reg_idx) {
+        /* Setting the register in which the operation will be done. */
+        s->reg_idx = data;
+        s->set_reg_idx = false;
+        return 0;
+    }
+
+    if (s->reg_idx >= I2C_TESTER_NUM_REGS) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid reg 0x%02x\n", __func__,
+                      s->reg_idx);
+        return I2C_NACK;
+    }
+
+    /* Write reg data. */
+    s->regs[s->reg_idx] = data;
+
+    return 0;
+}
+
+static void i2c_tester_init(Object *obj)
+{
+}
+
+static void i2c_tester_realize(DeviceState *ds, Error **errp)
+{
+}
+
+static void i2c_tester_unrealize(DeviceState *dev)
+{
+}
+
+static void i2c_tester_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    I2CSlaveClass *isc = I2C_SLAVE_CLASS(oc);
+
+    dc->reset = i2c_tester_reset;
+    dc->realize   = i2c_tester_realize;
+    dc->unrealize = i2c_tester_unrealize;
+
+    isc->event = i2c_tester_event;
+    isc->recv = i2c_tester_rx;
+    isc->send = i2c_tester_tx;
+}
+
+static const TypeInfo i2c_tester_types[] = {
+    {
+        .name = TYPE_I2C_TESTER,
+        .parent = TYPE_I2C_SLAVE,
+        .instance_size = sizeof(I2cTesterState),
+        .instance_init = i2c_tester_init,
+        .class_init = i2c_tester_class_init
+    },
+};
+
+DEFINE_TYPES(i2c_tester_types);
-- 
2.46.0.184.g6999bdac58-goog


