Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A402CDD552
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 19:30:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr0H1-0005jm-Db; Wed, 18 Sep 2024 15:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3qyjrZgUKCuYbIdQXOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--tavip.bounces.google.com>)
 id 1sr0Gu-0005Io-Va
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 15:23:29 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3qyjrZgUKCuYbIdQXOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--tavip.bounces.google.com>)
 id 1sr0Gs-0007Nf-C5
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 15:23:27 -0400
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-7190c5e73cdso70487b3a.0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 12:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1726687405; x=1727292205; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=LH2iO35jx1TQ4g6EFz+L7zqP2G1PAY0VCA+0NbB5ci8=;
 b=SWcgBzuyDFS1jIlrD4ukMp4WKe1YkNjY+LtgtUjbGENMxHFBJYRmL8bBJIVudVGz4b
 2ICWubBkM4qDVjF6Jz3UsQ56SgWZBhi5TaCr9NIPHTb+ljSpahqrs9Fr3jgpdH9zinA0
 BvIVtSGCRxFUXOlICSU3jbaoBLUb59qFOhu3omLRHDcgYem8x2c5XvUMZmiZk5CtMCzV
 M+kn2GQRiF1zhFCsiO+weNjzqTYSoK6JEpzxOQSJQn/JdDi1wXqnj7WTCwNVop7nFWDe
 HIItjQNC/+pnz1eyXPq3iYsRuZA9TvWsQup/xCBNfq2YwGvLL3UvSEbznPxn9hvphI0C
 5qVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726687405; x=1727292205;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LH2iO35jx1TQ4g6EFz+L7zqP2G1PAY0VCA+0NbB5ci8=;
 b=wzg5GsHmuE33mHWBZcKWo+lwEt+2z18zE2FUAEEzFAOZqizZ93FSGMOKRcEjlqja5n
 Cl9ZEl8/LwzzcRjd7ZL4M/+n2i2WK/1KEWRjoGlwE/qBp/vSCetFzsCjZcnY+JqIt+7K
 1w8Q/aSxiKEBNDtMDgLEp/TzasemM31VItaDvRG/3JjXMLD52Lhkl/FTQsIEq5Bd9P3i
 XD1B4ELZa79pAXCmAYNGOKZpuiJ4K3FOEDYiGv2pLLPH74MCpFt7x2fUXvFH1evH0bIy
 LlNFGnIVw30RrvFPBKDDKiRuDoHlg+IK66J0PPRd14TcoTWtPKyJLzZMBjbE4ul6eTkE
 zvpA==
X-Gm-Message-State: AOJu0YxbmFdJm809Hp7NAoaBzp8j36C2ViI44jXnZeA5GVAz0fguB19j
 9lqP85K6WwMi8q3mIRqxRrs/EjuTUq/XWPW/j/q+5wz9v3NphgBHt06IcJEU9feCu4vMEkTJOEv
 yYWlagrgXWMCvpv8Rv6c31YM1jemqiHWtpiXlf1XEQjzGET0fQ0PQHmvs3xrJK+0BaEZv+fYNVe
 Yi4eZPiu8Uv+vL3zsVkita3kG/GQ==
X-Google-Smtp-Source: AGHT+IEjoG7zUr2P2Fy4LWtZgZy8Y1sFKzhVgMbcwUQWX/mPhvM6Zr0Z3hH6QtqK5TNvxJMI/PT+shKS9Q==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a05:6a00:6f28:b0:70e:9de1:992e
 with SMTP id
 d2e1a72fcca58-71926060114mr60644b3a.1.1726687403885; Wed, 18 Sep 2024
 12:23:23 -0700 (PDT)
Date: Wed, 18 Sep 2024 12:22:43 -0700
In-Reply-To: <20240918192254.3136903-1-tavip@google.com>
Mime-Version: 1.0
References: <20240918192254.3136903-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240918192254.3136903-16-tavip@google.com>
Subject: [PATCH 15/25] tests/qtest: add register access macros and functions
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=3qyjrZgUKCuYbIdQXOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--tavip.bounces.google.com;
 helo=mail-pf1-x449.google.com
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
2.46.0.662.g92d0881bb0-goog


