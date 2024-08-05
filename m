Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C092EC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 20:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb49H-0002hH-8z; Mon, 05 Aug 2024 16:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3XjOxZgUKCsU4l6t0rzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--tavip.bounces.google.com>)
 id 1sb49E-0002Rj-3z
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:17:40 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3XjOxZgUKCsU4l6t0rzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--tavip.bounces.google.com>)
 id 1sb49B-0001Qr-WD
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:17:39 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-e0e3eb3fe93so3039972276.1
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 13:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1722889055; x=1723493855; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=nk3wy3iOlV41EdYWg2ADHBcnClsgP1AAs+CwqJBw/xU=;
 b=jn3Hed2apC4MeGSWIyxVR+3UoRxESiaQARUo11hPk8A9U/howsPgtHtpRm8PxwuzPC
 PN0dU2JP5Z3yKx/gHxU4HA7SOHzNyX8Sn0Q/WTHbEx42oCzrxuKRLUAwcsqXHJasEcQE
 x7jmRIZ0PBKsXx93uHvMSAndAH0jqv8nFVYAcS73kJQqVKxXQZT4jKz5fAZAO0dZGasb
 oc6GHrtWVTsx3fnhV+E19V66Z8vMp+euVaGydzuZpNQ2pVQK2c6aaGXv19/eV+bLUsCT
 vhFjRkU85vUjUNVQvIbEXSy+WIbupiWLkwAmWZqMoo6rbgLfH2n7lylw93a0YBBZa1QB
 ORuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722889055; x=1723493855;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nk3wy3iOlV41EdYWg2ADHBcnClsgP1AAs+CwqJBw/xU=;
 b=b2uLA/HyqQvrkDwiQruvvRbJ1sYc1zJUbMchxBpc0BNeuPq9p/CI5fNpPqGlrUc+xv
 M9InYmDs8UBDvSppM83J0VuDrAwfaPdunEuoGutdfp4R9ybe3PjfcVlWp15Lw4WyoOlv
 LGBt6UiIVfbnNRy+eURmE8ob1kPupqaXKhXeKkp01rHBLH0KVFYG8X8RmXPqUo8jg33e
 koppJNgh3ctZ2J6p01d6Q6MMy4MspW29E5todR6Rh1GsSmY9GTEgNRgmrQUQWdZBBXuJ
 OAhhShIFAF21ANdlhZDLzTAHQSKKXkw3XEyXMR7imloVGkjC3HhKCt2S4HSl7R+XRrD3
 9qeQ==
X-Gm-Message-State: AOJu0YxD14UKBg/DtbMuHycHj2Y/RjRNeO0NIfZNLjmx3lPYiaTHrWOL
 fW7wdLwkyhAkwesJzjV9jz/F2/7nU8bvXLemf1PQEV5epfCKDjeltp76vGoWqMrgzJMs/17wQ+8
 oAB8/18KSh3Iu6KHC4gMb0oMTLTtYgeCVh/BD2agPgYp6vOC4+F1spdK+TcZp2bblfK1NzQx/WY
 xIukSo9ZhrmlIGaochSldjwQk4CA==
X-Google-Smtp-Source: AGHT+IEii4/yzMfSp7LOsX7bSvtcsSwu3YPG0OH9OJP+3Z7rDF983ZAsDWCas7p00n2RRZm2FOn48nbu7Q==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a5b:404:0:b0:e0b:eb06:58b2 with
 SMTP id
 3f1490d57ef6-e0beb068624mr15190276.8.1722889054883; Mon, 05 Aug 2024 13:17:34
 -0700 (PDT)
Date: Mon,  5 Aug 2024 13:17:03 -0700
In-Reply-To: <20240805201719.2345596-1-tavip@google.com>
Mime-Version: 1.0
References: <20240805201719.2345596-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240805201719.2345596-9-tavip@google.com>
Subject: [RFC PATCH 08/23] test/unit: add register access macros and functions
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 alex.bennee@linaro.org, thuth@redhat.com, peter.maydell@linaro.org, 
 marcandre.lureau@redhat.com, alistair@alistair23.me, berrange@redhat.com, 
 philmd@linaro.org, jsnow@redhat.com, crosa@redhat.com, bleal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3XjOxZgUKCsU4l6t0rzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--tavip.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
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

Add register access macros for devices models that use SVD generated
registers. This allows accessing register or register bit fields in
unit tests, e.g.:

  REG32_WRITE(f->dev, FLEXCOMM, PSELID, persel);
  g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM, PSELID, PERSEL) == persel);

Also add support for accessing 32bit registers with memory transaction
state, e.g.:

  /* no register access until a function is selected  */
  g_assert(reg32_addr_read_raw(f->dev, FLEXCOMM_BASE, &tmp, 4) == MEMTX_ERROR);

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 include/hw/regs.h      |   2 +-
 tests/unit/reg-utils.h | 103 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+), 1 deletion(-)
 create mode 100644 tests/unit/reg-utils.h

diff --git a/include/hw/regs.h b/include/hw/regs.h
index 8d0da0629d..fd6576ba2b 100644
--- a/include/hw/regs.h
+++ b/include/hw/regs.h
@@ -59,7 +59,7 @@ static inline bool reg32_aligned_access(hwaddr addr, unsigned size)
  * // backstore is updated to 0x78
  * reg32_write(&backstore, REG2_ADDR, 0x12345678, wr_bits_array);
  */
-static inline uint32_t reg32_write(void *base, uint32_t off, uint32_t val,
+static inline uint32_t reg32_write(void *base, uint32_t addr, uint32_t val,
                                    const uint32_t *rw_bits_array)
 {
     uint32_t *ptr = base + addr;
diff --git a/tests/unit/reg-utils.h b/tests/unit/reg-utils.h
new file mode 100644
index 0000000000..f18ee07d20
--- /dev/null
+++ b/tests/unit/reg-utils.h
@@ -0,0 +1,103 @@
+/*
+ * Register access utilities for peripheral device tests.
+ *
+ * Copyright (C) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#ifndef _REG_UTILS_H
+#define _REG_UTILS_H
+
+#ifdef DEBUG_REG
+#define debug(fmt, args...) fprintf(stderr, fmt, ## args)
+#else
+#define debug(fmt, args...)
+#endif
+
+#define _REG_OFF(mod, field) (offsetof(mod##_Type, field))
+
+#define REG32_READ(dev, mod, reg)                                       \
+    ({                                                                  \
+        uint32_t value;                                                 \
+        value = sysbus_mmio_read_addr(dev, mod##_BASE + _REG_OFF(mod, reg), \
+                                      sizeof(uint32_t));                \
+        debug("[%s] -> %08x\n", #reg, value);                           \
+        value;                                                          \
+    })
+
+#define REG32_WRITE(dev, mod, reg, value)                               \
+    do {                                                                \
+        debug("[%s] <- %08x\n", #reg, value);                           \
+        sysbus_mmio_write_addr(dev, mod##_BASE + _REG_OFF(mod, reg), value, \
+                               sizeof(uint32_t));                       \
+    } while (0)
+
+#define REG_FIELD_VAL(v, mod, reg, field)                               \
+    ((v & mod##_##reg##_##field##_Msk) >> mod##_##reg##_##field##_Pos)
+
+#define REG32_READ_FIELD(dev, mod, reg, field)                  \
+    REG_FIELD_VAL(REG32_READ(dev, mod, reg), mod, reg, field)
+
+#define REG32_WRITE_FIELD(dev, mod, reg, field, val)                    \
+    do {                                                                \
+        uint32_t _tmp = REG32_READ(dev, mod, reg);                      \
+                                                                        \
+        _tmp &= ~mod##_##reg##_##field##_Msk;                           \
+        _tmp |= (val << mod##_##reg##_##field##_Pos) &                  \
+            mod##_##reg##_##field##_Msk;                                \
+        REG32_WRITE(dev, mod, reg, _tmp);                               \
+    } while (0)
+
+#define REG32_WRITE_FIELD_NOUPDATE(dev, mod, reg, field, val)           \
+    do {                                                                \
+        uint32_t _tmp;                                                  \
+                                                                        \
+        _tmp = (val << mod##_##reg##_##field##_Pos) &                   \
+            mod##_##reg##_##field##_Msk;                                \
+        REG32_WRITE(dev, mod, reg, _tmp);                               \
+    } while (0)
+
+#define WAIT_REG32_FIELD(ms, dev, mod, reg, field, val)         \
+    {                                                           \
+        int remaining = ms;                                     \
+                                                                \
+        while (remaining) {                                     \
+            if (REG32_READ_FIELD(dev, mod, reg, field) == val) {    \
+                break;                                          \
+            }                                                   \
+            main_loop_wait(false);                              \
+            usleep(1000);                                       \
+            remaining--;                                        \
+        }                                                       \
+                                                                \
+        g_assert(remaining);                                    \
+    }
+
+static inline MemTxResult reg32_addr_read_raw(DeviceState *dev, uint32_t addr,
+                                              uint32_t *value, uint32_t size)
+{
+    MemTxResult res;
+    uint64_t tmp;
+
+    res = sysbus_mmio_read_addr_raw(dev, addr, &tmp, size);
+    if (res == MEMTX_OK) {
+        *value = tmp;
+    }
+    debug("%d: [%x] -[%d]-> %08x\n", res, addr, size, *value);
+    return res;
+}
+
+static inline MemTxResult reg32_addr_write_raw(DeviceState *dev, uint32_t addr,
+                                               uint32_t value, uint32_t size)
+{
+    MemTxResult res;
+
+    res = sysbus_mmio_write_addr_raw(dev, addr, value, size);
+    debug("%d: [%x] <-[%d]- %08x\n", res, addr, size, value);
+    return res;
+}
+
+#endif /* _REG_UTILS_H */
-- 
2.46.0.rc2.264.g509ed76dc8-goog


