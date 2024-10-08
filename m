Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E27CED24D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 01:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxyuB-0004eG-A8; Mon, 07 Oct 2024 21:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3mYgEZwUKCvovcxkriqqing.eqosgow-fgxgnpqpipw.qti@flex--tavip.bounces.google.com>)
 id 1sxysx-0008CI-J4
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:19:36 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3mYgEZwUKCvovcxkriqqing.eqosgow-fgxgnpqpipw.qti@flex--tavip.bounces.google.com>)
 id 1sxyss-0000CG-Ps
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:19:33 -0400
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-71dfeda9ac0so1866077b3a.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 18:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1728350363; x=1728955163; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=ohI0GInatBpkkVc6LlITBXAa2f8u1GNul4wGD6o5kbw=;
 b=0rSL9sYhIKVm/xcP036gFjJ38oSIMXgXDHlZUNXIz4M2K8wHivHlEp7LRBarCHzD4J
 OmoVRMD/qJEn8rqnEkwfQa0f3kigbBBVKY4CMbiB++JSdEAVoCBMkbtxiVtXEPgWF0NO
 tqswvX8g9jeNPnuBNA84sNC0oOepRWggVs8jz2twPcGpmsZZ1vH+BGyu9RF4zjMyCzHr
 vAj5zWJk87Q6wysAhYRolVZWvt70s59I9csy0VI0oezUw8WndS1WsXvMhkTGIMPkmspp
 ZL9J8OoGrCKlVJ4dFxmfqghuF54CUlKbLHIMR4ZVOEiNW+exs+LGDhqVTrR0RVGVR0i4
 lWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728350363; x=1728955163;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ohI0GInatBpkkVc6LlITBXAa2f8u1GNul4wGD6o5kbw=;
 b=UEKRgPMkBAaTYG/t85t2s1bqIW/u/rJZDxmYjIkDfE/eOs/bc9uRF+dhter8txpQPL
 ky1ud0w4+60KRpy8J6Z2yhjai1VN5XY2U2hLkCC9dD0dMfW33MmBcSPhM8qs50Ui4BJx
 zNNMOgDmuC6T/4Uy64LQfJ5Zdr3Jefqmq1CyWqu5u0Om1MdHj0jh11AapXOphKCm2XZ1
 I1gNRFcS+5LsIgXMVTUzqFqJ0IlWnQRJXKKYubwVMX4V6QRXBCcJcmcVe6+PP5dcmM61
 iIPDYqEpB12OvEeyqPjaNa+L8nU2SbrpYRCWmmAHZsMVPa2NZ2c2XygnBYP7dnfhlOt7
 d8Vg==
X-Gm-Message-State: AOJu0Yy/LegDmbSxLNCq4XSYXjJmTCO8FkF0MmVYiQIaA8GtlsERmsPZ
 JMRgq3VAeuN3YO0yAlkF9NT23kS347DAuPgqHlEbODHNwtd43dtpfIYNnkIx2f+oXE1FveefbNI
 /MF1e42I2D8Vs3jDDkXJl2F/0mq0EQA1by2R1QeXhn4rz8ZTMUjhI5fhCEruuBqIHv32pMiovJA
 Mw6F/DNTKsAdVfzTJZMHHuDuUSbg==
X-Google-Smtp-Source: AGHT+IHfJoafZ1Gh1mSTL3YA6IgQyHpvaYVZtycBjAalruHqjj2i1J3dSMeXAFCXYRQlu7eKJ3STxUEy6Q==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a05:6a00:91db:b0:71e:401:6580
 with SMTP id
 d2e1a72fcca58-71e040166f7mr10095b3a.6.1728350361548; Mon, 07 Oct 2024
 18:19:21 -0700 (PDT)
Date: Mon,  7 Oct 2024 18:18:41 -0700
In-Reply-To: <20241008011852.1439154-1-tavip@google.com>
Mime-Version: 1.0
References: <20241008011852.1439154-1-tavip@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241008011852.1439154-16-tavip@google.com>
Subject: [PATCH v2 15/25] tests/qtest: add register access macros and functions
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=3mYgEZwUKCvovcxkriqqing.eqosgow-fgxgnpqpipw.qti@flex--tavip.bounces.google.com;
 helo=mail-pf1-x449.google.com
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

Add utility macros for accessing register or register bit fields in
tests, e.g.:

  REG32_WRITE(FLEXCOMM, PSELID, persel);
  g_assert(REG32_READ_FIELD(FLEXCOMM, PSELID, PERSEL) == persel);

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 tests/qtest/reg-utils.h | 70 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 tests/qtest/reg-utils.h

diff --git a/tests/qtest/reg-utils.h b/tests/qtest/reg-utils.h
new file mode 100644
index 0000000000..e09aaf3333
--- /dev/null
+++ b/tests/qtest/reg-utils.h
@@ -0,0 +1,70 @@
+/*
+ * Register access utilities for device tests.
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
+#include "libqtest-single.h"
+#include "hw/registerfields.h"
+
+#ifdef DEBUG_REG
+#define debug(fmt, args...) fprintf(stderr, fmt, ## args)
+#else
+#define debug(fmt, args...)
+#endif
+
+#define _REG_OFF(mod, reg) (A_##mod##_##reg)
+
+#define REG32_READ(mod, reg)                                            \
+    ({                                                                  \
+        uint32_t value;                                                 \
+        value = readl(mod##_BASE + _REG_OFF(mod, reg));                 \
+        debug("[%s] -> %08x\n", #reg, value);                           \
+        value;                                                          \
+    })
+
+#define REG32_WRITE(mod, reg, value)                                    \
+    do {                                                                \
+        debug("[%s] <- %08x\n", #reg, value);                           \
+        writel(mod##_BASE + _REG_OFF(mod, reg), value);                 \
+    } while (0)
+
+#define REG_FIELD_VAL(v, mod, reg, field)                               \
+    FIELD_EX32(v, mod##_##reg, field)                                   \
+
+#define REG32_READ_FIELD(mod, reg, field)                   \
+    REG_FIELD_VAL(REG32_READ(mod, reg), mod, reg, field)
+
+#define REG32_WRITE_FIELD(mod, reg, field, val)                         \
+    do {                                                                \
+        uint32_t _tmp = REG32_READ(mod, reg);                           \
+        _tmp = FIELD_DP32(_tmp, mod##_##reg, field, val);               \
+        REG32_WRITE(mod, reg, _tmp);                                    \
+    } while (0)
+
+#define REG32_WRITE_FIELD_NOUPDATE(mod, reg, field, val)                \
+    do {                                                                \
+        uint32_t _tmp = FIELD_DP32(0, mod##_##reg, field, val);         \
+        REG32_WRITE(mod, reg, _tmp);                                    \
+    } while (0)
+
+#define WAIT_REG32_FIELD(ns, mod, reg, field, val)                      \
+    do {                                                                \
+        clock_step(ns);                                                 \
+        g_assert_cmpuint(REG32_READ_FIELD(mod, reg, field), ==, val);   \
+    } while (0)
+
+#define REG32_READ_FAIL(mod, reg) \
+    readl_fail(mod##_BASE + _REG_OFF(mod, reg))
+
+#define REG32_WRITE_FAIL(mod, reg, value) \
+    writel_fail(mod##_BASE + _REG_OFF(mod, reg), value)
+
+#endif /* _REG_UTILS_H */
-- 
2.47.0.rc0.187.ge670bccf7e-goog


