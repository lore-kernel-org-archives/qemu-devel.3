Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3283CDD553
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 19:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr0H4-0005xV-FA; Wed, 18 Sep 2024 15:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3syjrZgUKCu4jQlYfWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--tavip.bounces.google.com>)
 id 1sr0H1-0005m8-R6
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 15:23:35 -0400
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3syjrZgUKCu4jQlYfWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--tavip.bounces.google.com>)
 id 1sr0H0-0007PT-0V
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 15:23:35 -0400
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-2db446a3d28so202845a91.2
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 12:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1726687412; x=1727292212; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=BasiRtQN5aAXKK780JUMkf3D1GTFkZQUDjsTNmgnDHw=;
 b=p3eemXqhfZCwbUzvszRaUHP7iKOrtuENZsNBLULly6tuUGMuF3QvIiS2eVfy6FZWvA
 iv6F4Er0MKY6c2cxubVOrSFEj0vSEySoIZZ2zvqKp4rrP5G5PrujvTg3AGnix6GGRTR7
 OITM5tZAij7iDMIILmP1Bptk8NUVpMESysw3HmmXfXywSrKi288hHwR7QhvSBriR6V1u
 awKUW/DGQPe8lIP5jgz2q4mCJxQ7AVzW0jkiF2LjYqyKDszqibrqRHIK3o72m2CS9dJh
 SdGDHGZ9FdLMsfBEmOwRTP1eo+R6Aw0V7tFYGx/9qySEszfP9G2LAYYsUTqXkY4EG02Q
 fMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726687412; x=1727292212;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BasiRtQN5aAXKK780JUMkf3D1GTFkZQUDjsTNmgnDHw=;
 b=U6bMMgMwcKk02zAhZ8KK8+Hv1NZGlh+HM2gB6KQROUo4SV4keTEZOlzeQjWpB0n0vQ
 8WhjsWQpMdHem9r58e8AuxiKIBJBwBFHG3KrMDHG8K3FTicmQED/4oEG8ebBtORW4e4Q
 t0BXGSAIzF5FFfBHOqwjnw8Wzn/vpbo/42RYEQ8cd6yXut7JEz24NTkeLPtiKRhOGoSj
 Nt5qw3FZUIVwTOYxFlZpXMTZdMpNau3s44DLkbOWFvQtkrbrTH8vejV1a5lIF+lZ4dAe
 FADoWQoix9AedfGrA6Ojwibkx2UFyxOuOWeRKGpUyWFdY7/ow1T4pbdorrrF9DPPtVWq
 u2oQ==
X-Gm-Message-State: AOJu0YxSsNHnmk9gL3gYi4bdjOL/cN2xsyz2tFAtcFNstGrutBaZ5+xc
 W9eLNq71VdH93D5hq0Lex9swOsCmAurmv//cyoJtrVMXLcB+crYQGt6SGa8xspo6CrlXN5+iImk
 1Jf/9cBcqX06SOEfvw3D1t0jXEUb1YmN5XOVx+kVjmRAF8/I4XHuHq4O/GR701B8VaXP6iOlQK3
 QPsQY+YfkzX0B20rWtUfaqWQOtmQ==
X-Google-Smtp-Source: AGHT+IE9pugV1W1gjuJk7mMtSsgn3Hz3rKDHUkp0c70pIqllMcHBraati2zSX2yJMxPbsD2VPV2Khw7cDA==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a17:90b:17d2:b0:2d8:e7ef:7d1e
 with SMTP id
 98e67ed59e1d1-2dbb9f199eemr66045a91.7.1726687411869; Wed, 18 Sep 2024
 12:23:31 -0700 (PDT)
Date: Wed, 18 Sep 2024 12:22:47 -0700
In-Reply-To: <20240918192254.3136903-1-tavip@google.com>
Mime-Version: 1.0
References: <20240918192254.3136903-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240918192254.3136903-20-tavip@google.com>
Subject: [PATCH 19/25] hw/misc: add i2c-tester
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3syjrZgUKCu4jQlYfWeeWbU.SecgUck-TUlUbdedWdk.ehW@flex--tavip.bounces.google.com;
 helo=mail-pj1-x1049.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
 include/hw/misc/i2c_tester.h |  30 ++++++++++
 hw/misc/i2c_tester.c         | 109 +++++++++++++++++++++++++++++++++++
 hw/misc/Kconfig              |   5 ++
 hw/misc/meson.build          |   2 +
 4 files changed, 146 insertions(+)
 create mode 100644 include/hw/misc/i2c_tester.h
 create mode 100644 hw/misc/i2c_tester.c

diff --git a/include/hw/misc/i2c_tester.h b/include/hw/misc/i2c_tester.h
new file mode 100644
index 0000000000..f6b6491008
--- /dev/null
+++ b/include/hw/misc/i2c_tester.h
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
index faaf2671ba..4f22231fa3 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -158,6 +158,8 @@ system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
 # HPPA devices
 system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
 
+system_ss.add(when: 'CONFIG_I2C_TESTER', if_true: files('i2c_tester.c'))
+
 system_ss.add(when: 'CONFIG_FLEXCOMM', if_true: files('flexcomm.c'))
 system_ss.add(when: 'CONFIG_RT500_CLKCTL', if_true: files('rt500_clkctl0.c', 'rt500_clkctl1.c'))
 system_ss.add(when: 'CONFIG_RT500_RSTCTL', if_true: files('rt500_rstctl.c'))
-- 
2.46.0.662.g92d0881bb0-goog


