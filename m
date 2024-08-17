Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD799C52D7D
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2024 10:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfGeJ-00082m-G1; Sat, 17 Aug 2024 06:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3znrAZgUKCgMwdylsjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--tavip.bounces.google.com>)
 id 1sfGdj-0006IT-JH
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 06:26:37 -0400
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3znrAZgUKCgMwdylsjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--tavip.bounces.google.com>)
 id 1sfGdf-0003GF-1x
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 06:26:30 -0400
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-2d3c6b19444so2547866a91.2
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2024 03:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1723890384; x=1724495184; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=jtA7OMGXC3nm30QYl6tV2Lp1z3zMEOqjEyF7m4p3wW0=;
 b=E1eqUljWlYXGolZ6ln7ecFtIcNs+7rTMoBc0mzu6SqC0AAralv4xH4ybAN/ta/I5dZ
 Kbs0dNo+suNIZtthJzbk83lmu1kG3IwqKmqqFi3JwOEovJoeY0p/uf7sxsZyRfsckHqJ
 9uMRgKDV6MlsdcrPV+F3u/GosqlQnTOCDnNJ/JnuWPQQ5O3uyKcnjjXG94RuJywvTR6h
 Hb+e/6df3M+NBPXmPt+gt1/MgqN66zn+RzdfWNAGW1Nzhh9WzNyNOHG1qvZ47bx785Of
 5tz+DPtTo70L39ulLAV3Vf4CsDmMKG2kdMxFFx1hsF8QsoKJvWjld+KHBbxosnccVoyH
 vfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723890384; x=1724495184;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jtA7OMGXC3nm30QYl6tV2Lp1z3zMEOqjEyF7m4p3wW0=;
 b=bZvhXItFOTwt4Jx8sD6GcTzQ6vapqpA4ZUScOPBzuS9q63hm4/R4FJlcPSE2TW484p
 sdvVqp20lIUA/HYH6xdIUSlexmZFtyLxEkjXaRKsTJ0JRPfK2ocKMM6Vi9r2bby6BZp2
 yqk4733/pJ74IxdzgvBIr5erblOZ79nkPpBL22Bqkcbt/iAfqqmj66o0yAfMO3s2CyIi
 6DdEHpeAbbE8hggZA326qHancNPyJMUVG/jkSYeDOiuafG7IJrwC63ghO2Y50gzMlUWP
 0/3KuXmBXngBn8pmNVN376G3KQSl/mh1nYqKbgZiSItxZLNDhQgZxw/AKKaHgmBkmYHR
 r4pg==
X-Gm-Message-State: AOJu0Yx9pjZwC0VpL0CBBh9RJzV4swP1v0Pq26WmETPUtf9AV0AdMKcd
 MhJ3Ui00TIFmTDkUifmHBoMyPgMdzN0efttQjHkNMrLykQ+F+M7OxzIda7RTMM4eflY8art+Z/H
 HWNHWisWv8bf6MEBPXw8qUQJavcGp6QM1yRQfLR9eFvCKKDNDJSPepyC7/eOQGXGRW4R0dmdRot
 QmWcuGGo+oPuRltkng40JUOE6Peg==
X-Google-Smtp-Source: AGHT+IHqLCGnvqk5SfKoDchAGe98Yvz+BjqtGxMhv7MRSzMTCLfx7r3Dt3bBLIemJLcVYFgFvK5K+pMyHA==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a17:90b:2bd1:b0:2d3:b353:4ab9
 with SMTP id
 98e67ed59e1d1-2d3e00ebe10mr13977a91.4.1723890382242; Sat, 17 Aug 2024
 03:26:22 -0700 (PDT)
Date: Sat, 17 Aug 2024 03:25:51 -0700
In-Reply-To: <20240817102606.3996242-1-tavip@google.com>
Mime-Version: 1.0
References: <20240817102606.3996242-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240817102606.3996242-9-tavip@google.com>
Subject: [RFC PATCH v2 08/23] test/unit: add register access macros and
 functions
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 thuth@redhat.com, peter.maydell@linaro.org, marcandre.lureau@redhat.com, 
 alistair@alistair23.me, berrange@redhat.com, philmd@linaro.org, 
 jsnow@redhat.com, crosa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3znrAZgUKCgMwdylsjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--tavip.bounces.google.com;
 helo=mail-pj1-x104a.google.com
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

Add utility macros for accessing register or register bit fields in
unit tests, e.g.:

  REG32_WRITE(f->dev, FLEXCOMM, PSELID, persel);
  g_assert(REG32_READ_FIELD(f->dev, FLEXCOMM, PSELID, PERSEL) == persel);

Also add support for accessing 32bit registers with memory transaction
state, e.g.:

  /* no register access until a function is selected  */
  g_assert(reg32_addr_read_raw(f->dev, FLEXCOMM_BASE, &tmp, 4) == MEMTX_ERROR);

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 tests/unit/reg-utils.h | 97 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 tests/unit/reg-utils.h

diff --git a/tests/unit/reg-utils.h b/tests/unit/reg-utils.h
new file mode 100644
index 0000000000..9eb17ebe59
--- /dev/null
+++ b/tests/unit/reg-utils.h
@@ -0,0 +1,97 @@
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
+#define _REG_OFF(mod, reg) (A_##mod##_##reg)
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
+    FIELD_EX32(v, mod##_##reg, field)                                   \
+
+#define REG32_READ_FIELD(dev, mod, reg, field)                  \
+    REG_FIELD_VAL(REG32_READ(dev, mod, reg), mod, reg, field)
+
+#define REG32_WRITE_FIELD(dev, mod, reg, field, val)                    \
+    do {                                                                \
+        uint32_t _tmp = REG32_READ(dev, mod, reg);                      \
+        _tmp = FIELD_DP32(_tmp, mod##_##reg, field, val);               \
+        REG32_WRITE(dev, mod, reg, _tmp);                               \
+    } while (0)
+
+#define REG32_WRITE_FIELD_NOUPDATE(dev, mod, reg, field, val)           \
+    do {                                                                \
+        uint32_t _tmp = FIELD_DP32(0, mod##_##reg, field, val);         \
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
2.46.0.184.g6999bdac58-goog


