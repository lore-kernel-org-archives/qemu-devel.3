Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69726C5320E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 06:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sipyZ-0005cg-Ss; Tue, 27 Aug 2024 02:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3LXbNZgUKCow9qBy5w44w1u.s426u2A-tuBu1343w3A.47w@flex--tavip.bounces.google.com>)
 id 1sipyO-0004mk-PG
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 02:46:36 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3LXbNZgUKCow9qBy5w44w1u.s426u2A-tuBu1343w3A.47w@flex--tavip.bounces.google.com>)
 id 1sipyJ-0006B0-Ax
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 02:46:36 -0400
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-20383bf72easo51894735ad.3
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 23:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1724741165; x=1725345965; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=bhR+L35SiqjkW6TlKGX3ijIk2Na9K+5U5H9NOs890v8=;
 b=Yn+xAIDwOrl3tvheW3eGtHUJu1ohEunRchqqROdFugle3FumG/58K9oaLjacawnUka
 mdS6apX5VjEDRAdSkhaXGbYsn2qMn1+CbB0wTsYZU/lqWYH46BXnCmUg+XGPp0mduPb2
 hkkrT+PSsrKQds1zz50BYYgTqYJcQHFqnwdNMRrblH6K3z+FkV/s0OCZD4RCiEIYpobZ
 Gr5+qJvkf7DjGBpCfeSYxhr5dhWfUXIjyI2AJC046ZHFt7IMF6r5wCJ9O/C19Cnvfr9n
 bel9ze/edUiMpEgfDfJZLPT3I2tFNz/5ZhasldLtZfcl6rHIbjOznRN1uPAkuKKRBL2k
 33Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724741165; x=1725345965;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bhR+L35SiqjkW6TlKGX3ijIk2Na9K+5U5H9NOs890v8=;
 b=aymDMAdA0SeX2FI/hwDPTnALcj5dj12BkIWpwZ85RGBouXNQDJNrqTay0qOvbGeOGz
 wwZXfqMKo8KEH0xv85J1Hh+M1Q2k95TDWxjFonrT6yTZVoe7MCREn4ZR6gSdBF8rKanM
 8X4Ep9USWbirg5Dfax3YPTtjPNMSLXVzhFFOdr8HGAVhZv5EQ5/mjN9qu/TNUNejwQXp
 nO0ao3IsFpQkTRZ9Vp7gTCvYOdVEyQI8joko+fAPywseal/jpmhrDHUKo45dC/4yUhv/
 ZfzTwCPQ2sE3UmpAhkFBNqK+Tk2culrDslmjrO6PUF58y+/aIi3LJ4MHBYkISgaFi+Of
 116Q==
X-Gm-Message-State: AOJu0YwqZnseV9aIbfTm1eu6L9XLNVtqeV7g2uZfK8FjfeygVk3BZq7C
 7GW7Ljprwo4iKO8/U23p7Uvi0IlA+6A+sZDTq/kOBHbePZsbtb7DzkQRhCji4M5mSsgLoJEhS67
 5zsu2Lmdpdd5/qrr5UEwvHYhHeuNg5LTtlHk44PmcsjPSlQR0zXniBQlaoeuNJ1A8bOCYWsFlOt
 t0o6cKOU0rukxpNYEeQjVuXgdypg==
X-Google-Smtp-Source: AGHT+IGqy0szNwUEWB4CrLtwthcLQXp7LfACKMjKDAVMpxrgI3D9EIZmWZoqGANHXI4KSsSZfOVRsqcCQw==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a17:902:d50d:b0:203:616a:8673
 with SMTP id
 d9443c01a7336-2039e4d5cdfmr12236925ad.5.1724741165045; Mon, 26 Aug 2024
 23:46:05 -0700 (PDT)
Date: Mon, 26 Aug 2024 23:45:22 -0700
In-Reply-To: <20240827064529.1246786-1-tavip@google.com>
Mime-Version: 1.0
References: <20240827064529.1246786-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240827064529.1246786-19-tavip@google.com>
Subject: [RFC PATCH v3 18/24] hw/misc: add i2c-tester
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3LXbNZgUKCow9qBy5w44w1u.s426u2A-tuBu1343w3A.47w@flex--tavip.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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
 include/hw/misc/i2c_tester.h | 30 ++++++++++++
 hw/misc/i2c_tester.c         | 94 ++++++++++++++++++++++++++++++++++++
 hw/misc/Kconfig              |  5 ++
 hw/misc/meson.build          |  2 +
 4 files changed, 131 insertions(+)
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
index 0000000000..3d7986a954
--- /dev/null
+++ b/hw/misc/i2c_tester.c
@@ -0,0 +1,94 @@
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
+static void i2c_tester_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    I2CSlaveClass *isc = I2C_SLAVE_CLASS(oc);
+
+    dc->reset = i2c_tester_reset;
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
index df36b45d9f..a0f7a52a23 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -157,6 +157,8 @@ system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
 # HPPA devices
 system_ss.add(when: 'CONFIG_LASI', if_true: files('lasi.c'))
 
+system_ss.add(when: 'CONFIG_I2C_TESTER', if_true: files('i2c_tester.c'))
+
 system_ss.add(when: 'CONFIG_FLEXCOMM', if_true: files('flexcomm.c'))
 system_ss.add(when: 'CONFIG_RT500_CLKCTL', if_true: files('rt500_clkctl0.c', 'rt500_clkctl1.c'))
 system_ss.add(when: 'CONFIG_RT500_RSTCTL', if_true: files('rt500_rstctl.c'))
-- 
2.46.0.295.g3b9ea8a38a-goog


