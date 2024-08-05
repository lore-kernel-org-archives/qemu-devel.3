Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D47DAC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 20:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb49R-0003bh-SH; Mon, 05 Aug 2024 16:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3aDOxZgUKCs8EvG3A19916z.x97Bz7F-yzGz689818F.9C1@flex--tavip.bounces.google.com>)
 id 1sb49P-0003P6-DZ
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:17:51 -0400
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3aDOxZgUKCs8EvG3A19916z.x97Bz7F-yzGz689818F.9C1@flex--tavip.bounces.google.com>)
 id 1sb49M-0001UI-DX
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:17:50 -0400
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-2cff79ae0f3so4096152a91.0
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 13:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1722889066; x=1723493866; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=yKViGbBXbgsf40jDlea1Rbu9Pc/wgyZ+coz/6jiEdWo=;
 b=TTFrgSvOk16Gwg0E4EM49VxC+sCASYSVRwsmx0NJw8dssUcWd6G5sV+UZRZalSF4LK
 aKKl+Xi0cZiE9A7JgFgR1/Gy2VGI5WTY5vCzenhmcM098lgt+FSMFQHXThgViK4+7GTI
 VrYkIbdrG5y506LW5/fPZGYXOsAl8I3zGA7Rk8vN58xyIoZCnk5MHpPMV3/TZcPmd3ts
 TydypEll3hXLJbTM8UfJPhZLbJTTZmv8P2tf8q09TGIIHyom2SCsH8dY00w0EvS2jt1X
 bLKe5WU3st0BOj+MmZpQs+dlvK1M83hBuh6a/et1u7kjeiLqtFGWR2P2mp1UzgHOWaim
 QVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722889066; x=1723493866;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yKViGbBXbgsf40jDlea1Rbu9Pc/wgyZ+coz/6jiEdWo=;
 b=avkh5edue9TcOe4FIaNdyfpuNaQc8IwTLC6S7dm5mSU7D4bUlVnHLzSXuOGzmJGEHl
 gn/LvHfGTtnIPOv0o3UJtkShgf22Cub5rgqyKw1ar7tt2+r82mw33uMZfOFjrQSd2pgv
 nNLXXiL83/Ki7/UCRHmneZ3ysHgOMxo7Iuzeth6Nn0PLVhyo6wl6HMg3GQDEigwMihAe
 8CWs+62NepgfLm2BK+gOpFgav+6uttQdFRvnTOP8GoCzfqizOLmWc57Dk20QxFItj7Y3
 p2OBuRqB3X7edbItL4TYQDxWKwRhbXYgwjUv5RvKjXV/jmqMKQCJxKgrxueKOkb3mztm
 wrwQ==
X-Gm-Message-State: AOJu0YyEeLbKFFVHBlB4TvcyU1U0TZFbQq4XsJFridhVEA9/5pXZOf03
 ls36nuJjkQ68HxAeeuPJub82P4eOz4L7s76SF31xXMpWfpCY8RPGtbW+KyOFfJA5jHF/0cOfNHL
 NCIsKPEqkYfEhjPDYf2/D6haeLQVyAC1TfqhUguSQgq5Lbf/vYCoYuAGYotgIY8wJUlmBkQunSx
 lbjXB803jre9rZkaSoCqq3rZ16DA==
X-Google-Smtp-Source: AGHT+IEru86bm/+1q+FLmL7wwlYksXRv1IHzcU3JoLAoRcdP6I9MQ8+1J/BYTCPAlqTiOGFbzd7E25IUmA==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a17:90a:c982:b0:2c9:63d6:a183
 with SMTP id
 98e67ed59e1d1-2cff955376dmr29109a91.7.1722889064153; Mon, 05 Aug 2024
 13:17:44 -0700 (PDT)
Date: Mon,  5 Aug 2024 13:17:08 -0700
In-Reply-To: <20240805201719.2345596-1-tavip@google.com>
Mime-Version: 1.0
References: <20240805201719.2345596-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240805201719.2345596-14-tavip@google.com>
Subject: [RFC PATCH 13/23] test/unit: add i2c-tester
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 alex.bennee@linaro.org, thuth@redhat.com, peter.maydell@linaro.org, 
 marcandre.lureau@redhat.com, alistair@alistair23.me, berrange@redhat.com, 
 philmd@linaro.org, jsnow@redhat.com, crosa@redhat.com, bleal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3aDOxZgUKCs8EvG3A19916z.x97Bz7F-yzGz689818F.9C1@flex--tavip.bounces.google.com;
 helo=mail-pj1-x1049.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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
 tests/unit/i2c_tester.c | 111 ++++++++++++++++++++++++++++++++++++++++
 tests/unit/i2c_tester.h |  34 ++++++++++++
 2 files changed, 145 insertions(+)
 create mode 100644 tests/unit/i2c_tester.c
 create mode 100644 tests/unit/i2c_tester.h

diff --git a/tests/unit/i2c_tester.c b/tests/unit/i2c_tester.c
new file mode 100644
index 0000000000..ea36a17f1f
--- /dev/null
+++ b/tests/unit/i2c_tester.c
@@ -0,0 +1,111 @@
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
+static const TypeInfo i2c_tester_info = {
+    .name = TYPE_I2C_TESTER,
+    .parent = TYPE_I2C_SLAVE,
+    .instance_size = sizeof(I2cTesterState),
+    .instance_init = i2c_tester_init,
+    .class_init = i2c_tester_class_init
+};
+
+static void i2c_tester_register_type(void)
+{
+    type_register_static(&i2c_tester_info);
+}
+
+type_init(i2c_tester_register_type);
diff --git a/tests/unit/i2c_tester.h b/tests/unit/i2c_tester.h
new file mode 100644
index 0000000000..9eebe1b6e3
--- /dev/null
+++ b/tests/unit/i2c_tester.h
@@ -0,0 +1,34 @@
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
+    /* <private> */
+    I2CSlave i2c;
+
+    /* <public> */
+    bool set_reg_idx;
+
+    uint8_t reg_idx;
+    uint8_t regs[I2C_TESTER_NUM_REGS];
+} I2cTesterState;
+
+#endif /* TESTS_UNIT_I2C_TESTER_H */
-- 
2.46.0.rc2.264.g509ed76dc8-goog


