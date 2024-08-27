Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93212C52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 06:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sipyR-0004zQ-Co; Tue, 27 Aug 2024 02:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3JXbNZgUKCoQ1i3qxowwotm.kwuymu2-lm3mtvwvov2.wzo@flex--tavip.bounces.google.com>)
 id 1sipyG-00048j-P8
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 02:46:31 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3JXbNZgUKCoQ1i3qxowwotm.kwuymu2-lm3mtvwvov2.wzo@flex--tavip.bounces.google.com>)
 id 1sipy8-00069A-8T
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 02:46:24 -0400
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-201f45e20b1so56789215ad.2
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 23:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1724741157; x=1725345957; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=QAb7sPO/VgRC8CdmRh6+IgA62zqKsaHlo0fRBlzqmbo=;
 b=mXEiDGiCmMUPWgan5Tq+yp6CEk6FNy03Wb6/T3NG3R37+7T2tSVUNAgeRxpZUilQDl
 uRzXpBgriJQYBkgq8+RSpOUfo2cMgCnP2HkHVWwbq4qtsF791CfSf7O7NjLiiT2JA0/p
 ATtiblQ878KrjAu84kjrjd3gh9O1aGt3+Cg0piVLUipnDVGNZ+n9NSpudoJvMheHaUQ/
 Ceqb4btT5pXzdeXFmh6NDqpEpVZoMkoM26Gb1gTC9UoTkW7Uyymz7Pj3CCw1uDFoOu+G
 Y7g2SKilieAuQXCn3BWZEd5VlzCknRkzstFLsUfNlbJu30Ppqa0+1I8LMVXuYi364OOJ
 cJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724741157; x=1725345957;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QAb7sPO/VgRC8CdmRh6+IgA62zqKsaHlo0fRBlzqmbo=;
 b=sHZ86mdE3PEgq7kzcFdpatYrRg5FEszTHH3efZ0UVCQyDcBoqN43yIs0lB0rrrnNPK
 Pc+raU1qFXbrMWkBmBQ1HEFvGtxsiikniJqzv1/KKIiq8ihZUkiU2mjOMoW1ZvVi65zS
 kMNbZ/6+2Krkx+0gbUHbP+aW/iTr0mBGsNOSt5+Y2DszKWnlOIGDwONC6WEIWuxJYJ1N
 vrv/j0JOGLhuBjoOvuJqXXCjFsc3oS5uYoYsyejzhHoj7kQmC85bNPYEKacorwyOTAqp
 xUw7qmhMk+LsCjCK+pmh9v/hJ4AIguPONu6PoIfVpTKW0Mx95Z7lts5cOTmbnCLqBsqG
 Lbzw==
X-Gm-Message-State: AOJu0YxfDH1+2RcWnb58Nnk9u5+Gm1YlmWzU2SJyCdGrGzyqeGoptRIB
 9Hl5VsHDolkWbqixjXnwiJ1bdgXQYIBruArkLbfML/RgDlfUXUmqgkAWfL3+8t2xDVbvNEw5fxU
 WCiLpPn69nazqquGW8tjsoUykBKKno/gtS0VeDogngOgpSr8lbzU+86jbY/rIyWkDSMSW+gAv+f
 B2+lMai2/MAM8JsFpMnF9IKFP+sA==
X-Google-Smtp-Source: AGHT+IGGDHDaHIOyerwmDa1pORPASHNqhtE5CtalgNsFYqYIDRdbHccitQGm3u0FBIuFfW8Izaow1dOAOw==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a17:903:1210:b0:1fc:369b:c1b5
 with SMTP id
 d9443c01a7336-204df43252emr843855ad.5.1724741157078; Mon, 26 Aug 2024
 23:45:57 -0700 (PDT)
Date: Mon, 26 Aug 2024 23:45:18 -0700
In-Reply-To: <20240827064529.1246786-1-tavip@google.com>
Mime-Version: 1.0
References: <20240827064529.1246786-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240827064529.1246786-15-tavip@google.com>
Subject: [RFC PATCH v3 14/24] tests/qtest: add register access macros and
 functions
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3JXbNZgUKCoQ1i3qxowwotm.kwuymu2-lm3mtvwvov2.wzo@flex--tavip.bounces.google.com;
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
2.46.0.295.g3b9ea8a38a-goog


