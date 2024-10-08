Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57EE2CED24E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 01:23:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxyuE-0005Ac-HH; Mon, 07 Oct 2024 21:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3oIgEZwUKCgMwdylsjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--tavip.bounces.google.com>)
 id 1sxysy-0008Co-3e
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:19:36 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3oIgEZwUKCgMwdylsjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--tavip.bounces.google.com>)
 id 1sxysv-0000Da-8r
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:19:35 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-6e2270a147aso75604587b3.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 18:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1728350369; x=1728955169; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=nCq9fs8MJ+mFnJecQKMchHHydT4SahSTnFv0Noo9rMg=;
 b=p8iTvODxXhY3EuP2vWuOgIN8T9ZfHG8xPTdYuYj8qiiKd+ua3Lrp4CMOkaZsVYZvCY
 G/M74SrW5rBZND41lCygiPQVEVEiPv/ERz4QISklBjuDOL7J5Yk5gt5uMR/kj2HXffv4
 SLLetMgjy6iXCClodZ9fcdLrRWDuxKsa/NsxKLXPutUOBbFUfXZbyMHswxsf0nGhGIAw
 wtKk+UrlSQjRVa5+n0o+ajawpxBSNdvh8AWk0h3Cv1AYNGxTx+uoLUL2EmcRn01VS4fo
 YgAT03tdHW0QhLtfWd8GpGrTqBJBwhWCbDl+PQE8XNt/5JqGDMrKSdwp9WgKQ+QFxHqv
 wumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728350369; x=1728955169;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nCq9fs8MJ+mFnJecQKMchHHydT4SahSTnFv0Noo9rMg=;
 b=Qy/g/0ztU4ZYCJcvSSCHHbsiiH3TDmO4xHgeztpF39esCkMXH/KNyga29D0Ug24bR8
 XPQh9i4svMGJpX6QADvHiMHGOslu3Uut4AinrFI1M+d/CFxD4BcC6DMiU0A1H3cIGqZq
 pU1VJtG7VIaWXkP4ZeSzKkCdl0A649V5zFbORxOh0K13v5QaTMNNe8FEfryXd6J0p6z9
 6jwVwIIzWF06N74VEBrrvBYRHAkCIxAZ1ki7Aimmg0UReUSqUR+GCQI66TKshW6Y+rfW
 SOLouC6n4yrggLrmd1QqMHTuTKSy1HqxVvbRYLh7yNYj5HRW1pusg2wHLn9yxh+5njnt
 kfIA==
X-Gm-Message-State: AOJu0YzutnqIMEcyJJW3d6PHx/49Iajvcbo6+FCA9b86LrIwgP6O2V3T
 SKJ81G9pkHXXuuCzg11vaBUGaQ2Cr0LP4iAdQgOY0/kbSScz7ZXw+rT1kl8pRulYJ/3gQ4hapyz
 vkr4X0fo+YvZHAmX1SyyU5qNvHV01Q53mjW5jtfarXFcqZ/4eL+di8mxxMYUC32noTwHQdS/eoQ
 6vV6otTwmC3G+H7LOXuET5fs2TYw==
X-Google-Smtp-Source: AGHT+IFUmkLVVZH+vWL0zyz0TcYFmOI86jHuXPIUgCaHGoy2/OH/FDqpkkmIBwci5b1oJCfJzaV6kvhkUQ==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a05:6902:4a8:b0:e28:e4a7:3206
 with SMTP id
 3f1490d57ef6-e28e4a732e6mr15578276.8.1728350368601; Mon, 07 Oct 2024 18:19:28
 -0700 (PDT)
Date: Mon,  7 Oct 2024 18:18:45 -0700
In-Reply-To: <20241008011852.1439154-1-tavip@google.com>
Mime-Version: 1.0
References: <20241008011852.1439154-1-tavip@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241008011852.1439154-20-tavip@google.com>
Subject: [PATCH v2 19/25] hw/misc: add i2c-tester
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3oIgEZwUKCgMwdylsjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--tavip.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.024,
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
 include/hw/misc/i2c_tester.h |  43 ++++++++++++++
 hw/misc/i2c_tester.c         | 109 +++++++++++++++++++++++++++++++++++
 hw/misc/Kconfig              |   5 ++
 hw/misc/meson.build          |   2 +
 4 files changed, 159 insertions(+)
 create mode 100644 include/hw/misc/i2c_tester.h
 create mode 100644 hw/misc/i2c_tester.c

diff --git a/include/hw/misc/i2c_tester.h b/include/hw/misc/i2c_tester.h
new file mode 100644
index 0000000000..f8292fc219
--- /dev/null
+++ b/include/hw/misc/i2c_tester.h
@@ -0,0 +1,43 @@
+/*
+ * Simple I2C peripheral for testing I2C device models.
+ *
+ * At the moment of introducing this not all of the functionality can be tested
+ * with an existing QEMU peripheral device, notably error paths such as when a
+ * peripheral device responds with an I2C_NACK during a transaction.
+ *
+ * It also provides a place where new future functionality can be added to help
+ * with more kinds of tests rather than trying to hack it in a real device where
+ * it might not even be possible.
+ *
+ * The peripheral allows reading and writing to a fixed number of registers.
+ * The first transmitted byte in a transaction sets the index register. Note
+ * that the index register is not auto-incremented on neither reads nor writes.
+ *
+ * Copyright (c) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_I2C_TESTER_H
+#define HW_I2C_TESTER_H
+
+#include "qemu/osdep.h"
+#include "hw/i2c/i2c.h"
+#include "hw/irq.h"
+
+#define I2C_TESTER_NUM_REGS    0x31
+
+#define TYPE_I2C_TESTER "i2c-tester"
+#define I2C_TESTER(obj) OBJECT_CHECK(I2cTesterState, (obj), TYPE_I2C_TESTER)
+
+typedef struct {
+    I2CSlave i2c;
+    bool set_reg_idx;
+    uint8_t reg_idx;
+    uint8_t regs[I2C_TESTER_NUM_REGS];
+} I2cTesterState;
+
+#endif /* HW_I2C_TESTER_H */
diff --git a/hw/misc/i2c_tester.c b/hw/misc/i2c_tester.c
new file mode 100644
index 0000000000..77ce8bf91a
--- /dev/null
+++ b/hw/misc/i2c_tester.c
@@ -0,0 +1,109 @@
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
+#include "hw/misc/i2c_tester.h"
+
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "migration/vmstate.h"
+
+static void i2c_tester_reset_enter(Object *o, ResetType type)
+{
+    I2cTesterState *s = I2C_TESTER(o);
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
+static const VMStateDescription vmstate_i2c_tester = {
+    .name = "i2c-tester",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_I2C_SLAVE(i2c, I2cTesterState),
+        VMSTATE_BOOL(set_reg_idx, I2cTesterState),
+        VMSTATE_UINT8(reg_idx, I2cTesterState),
+        VMSTATE_UINT8_ARRAY(regs, I2cTesterState, I2C_TESTER_NUM_REGS),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void i2c_tester_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
+    I2CSlaveClass *isc = I2C_SLAVE_CLASS(oc);
+
+    rc->phases.enter = i2c_tester_reset_enter;
+    dc->vmsd = &vmstate_i2c_tester;
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
+        .class_init = i2c_tester_class_init
+    },
+};
+
+DEFINE_TYPES(i2c_tester_types);
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 4b688aead2..3e93c12c8e 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -213,6 +213,11 @@ config IOSB
 config XLNX_VERSAL_TRNG
     bool
 
+config I2C_TESTER
+    bool
+    default y if TEST_DEVICES
+    depends on I2C
+
 config FLEXCOMM
     bool
     select I2C
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index bf0988fd43..cd29db37d7 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -152,6 +152,8 @@ system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
 # HPPA devices
 system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
 
+system_ss.add(when: 'CONFIG_I2C_TESTER', if_true: files('i2c_tester.c'))
+
 system_ss.add(when: 'CONFIG_FLEXCOMM', if_true: files('flexcomm.c'))
 system_ss.add(when: 'CONFIG_RT500_CLKCTL', if_true: files('rt500_clkctl0.c', 'rt500_clkctl1.c'))
 system_ss.add(when: 'CONFIG_RT500_RSTCTL', if_true: files('rt500_rstctl.c'))
-- 
2.47.0.rc0.187.ge670bccf7e-goog


