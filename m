Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA75EC5320E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 06:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sipxX-0002aH-H8; Tue, 27 Aug 2024 02:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3DnbNZgUKCm0eLgTaRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--tavip.bounces.google.com>)
 id 1sipxU-0002Sd-Av
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 02:45:40 -0400
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3DnbNZgUKCm0eLgTaRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--tavip.bounces.google.com>)
 id 1sipxR-00063u-Dq
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 02:45:39 -0400
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-2021ab2b5e6so47184345ad.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 23:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1724741135; x=1725345935; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=LDq3l3mSZOO+uo7Qk5jaY9LnmHfoo3Af6599hG6MOzA=;
 b=1o5ZIdwbzG8+nHe1Vvksg4nOobb9elmLaGjmjUK1LUrNslykbgNMVtthVbD6G8fjuD
 4T22gSiZsAtT1gG+gUJzwJ9WIvnIgOfBp9MbBMdOpEzTRPRTApWvttytYd206kL+5G0c
 3QKryHDpzxAZJVaIco6dT9VIivillDULo/k/WJXCS6SBXn1+BjDtxqr1/TYrTwyR90S7
 nR8KBnjlW4/ynMKrGFzOxJ1AGhzyb7PRiekOv5jT2K5cE9auo3rEx1YcRlV6HstSIjJZ
 a+WJ/VZZeChi+hHyqKquhDouYuZRtRFY0yKJzBn/5vk2P0KDdzeqNlTpOH3DHFCPdJQ1
 5A0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724741135; x=1725345935;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LDq3l3mSZOO+uo7Qk5jaY9LnmHfoo3Af6599hG6MOzA=;
 b=KR2t+d4EAR6rUyKeVvxtz2vA4L2VzDUT7XO4L/WnV9V0phhXcyIrEEQa6KMHIgWC2n
 yenEEVAiHZK+REXXDRnDu4hCnw/aIHblFT5FkNB+qikhLK4jYj1uSV/XBpIiG4v32tVt
 3E8NHe0cBJEbiY0zcFc2NrNwX8t7qBXJvo1FgyYvrkjnvRQeZbIVwp3AeNH7VWWbB7FB
 GqkBDeDwLNAI+j1x36+8XFP58f/hMttSCkaFi7QHHt07sl2hTj8L6Kyb/Z+SzVhfdLuR
 e36NuThmhX0t9nzK+IwrfYWhQDNBv0PrBhRvDeulI1W91bL8cl03WNll5K0fDnRP6+Wi
 hdGA==
X-Gm-Message-State: AOJu0YwEPv1dxmhNELzVbLa7AQLVi/MO2mT3Yk05on/jcM+GaU9JoYMU
 oObalHwwMD3Nv0uEEVMqk7iVyve5Xb5MGYPVUakdFHtDQNe9yRWpyKLr3cQE8RbYL7KrLOPpT5v
 ylmOiEwHMQycLXIi3bEmu2fF//2unvAUImbMp0X6CE0y1ACvBPi8OkYZQfUEu2fKHq+r/1U7rFN
 /nNYs2+yBHzurK6oDt4UqB/+AdHw==
X-Google-Smtp-Source: AGHT+IEA7jWaAuy0gthJkmsd7FLetdm8lDt8WB6erXm6XSLeZXLeJlXAyIG698d6VWhcqslToghiRw9spg==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a17:902:f541:b0:202:4712:e84c
 with SMTP id
 d9443c01a7336-204df43ca83mr936055ad.6.1724741134193; Mon, 26 Aug 2024
 23:45:34 -0700 (PDT)
Date: Mon, 26 Aug 2024 23:45:06 -0700
In-Reply-To: <20240827064529.1246786-1-tavip@google.com>
Mime-Version: 1.0
References: <20240827064529.1246786-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240827064529.1246786-3-tavip@google.com>
Subject: [RFC PATCH v3 02/24] tests/unit: add fifo test
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3DnbNZgUKCm0eLgTaRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--tavip.bounces.google.com;
 helo=mail-pl1-x649.google.com
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

Add a simple FIFO unit test that test wrap around and push, pop and
peek for both fifo8 and fifo32.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 tests/unit/test-fifo.c | 97 ++++++++++++++++++++++++++++++++++++++++++
 tests/unit/meson.build |  1 +
 2 files changed, 98 insertions(+)
 create mode 100644 tests/unit/test-fifo.c

diff --git a/tests/unit/test-fifo.c b/tests/unit/test-fifo.c
new file mode 100644
index 0000000000..3e6f007229
--- /dev/null
+++ b/tests/unit/test-fifo.c
@@ -0,0 +1,97 @@
+/*
+ * QEMU FIFO testing
+ *
+ * Copyright (C) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "qemu/fifo8.h"
+#include "qemu/fifo32.h"
+
+typedef struct {
+    Fifo8 fifo8;
+    Fifo32 fifo32;
+} TestFixture;
+
+#define FIFO_SIZE 13
+
+/*
+ * Test fixture initialization.
+ */
+static void set_up(TestFixture *f, gconstpointer data)
+{
+    int n = (uintptr_t) data;
+
+    fifo8_create(&f->fifo8, n);
+    fifo32_create(&f->fifo32, n);
+}
+
+static void tear_down(TestFixture *f, gconstpointer user_data)
+{
+    fifo8_destroy(&f->fifo8);
+    fifo32_destroy(&f->fifo32);
+}
+
+static void test_push_pop_batch(TestFixture *f, int n)
+{
+    uint8_t i;
+
+    /* push and check peek */
+    for (i = 0; i < n; i++) {
+        uint8_t val8 = i;
+        uint32_t val32 = i | ((i + 1) << 8) | ((i + 2) << 16) | ((i + 3) << 24);
+
+        fifo8_push(&f->fifo8, val8);
+        if (i == 0) {
+            g_assert(*fifo8_peek_buf(&f->fifo8, 1, NULL) == val8);
+        }
+
+        fifo32_push(&f->fifo32, val32);
+        if (i == 0) {
+            g_assert(fifo32_peek(&f->fifo32) == val32);
+        }
+    }
+
+    /* check peek and pop */
+    for (i = 0; i < n; i++) {
+        uint8_t val8 = i;
+        uint32_t val32 = i | ((i + 1) << 8) | ((i + 2) << 16) | ((i + 3) << 24);
+
+        g_assert(*fifo8_peek_buf(&f->fifo8, 1, NULL) == val8);
+        g_assert(fifo8_pop(&f->fifo8) == val8);
+
+        g_assert(fifo32_peek(&f->fifo32) == val32);
+        g_assert(fifo32_pop(&f->fifo32) == val32);
+    }
+}
+
+/* max n should be less then 256 - 3 */
+static void wrap_around_test(TestFixture *f, gconstpointer user_data)
+{
+    int n = (uintptr_t) user_data;
+    const int cycles = 3;
+
+    for (int i = 0; i < cycles; i++) {
+        test_push_pop_batch(f, n / 2 + 1);
+    }
+}
+
+/* mock-ups */
+void *vmstate_info_buffer;
+uint32_t vmstate_info_uint32;
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    g_test_add("/fifo/wrap-around", TestFixture, (gconstpointer)FIFO_SIZE,
+               set_up, wrap_around_test, tear_down);
+
+    return g_test_run();
+}
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 26c109c968..397f2503f8 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -47,6 +47,7 @@ tests = {
   'test-logging': [],
   'test-qapi-util': [],
   'test-interval-tree': [],
+  'test-fifo': [],
 }
 
 if have_system or have_tools
-- 
2.46.0.295.g3b9ea8a38a-goog


