Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E41CA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 19:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBzwh-0004Rm-8a; Wed, 30 Sep 2026 15:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dominic.plunkett@gmail.com>)
 id 1xBzOy-0000pq-Bh
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 14:51:36 -0400
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dominic.plunkett@gmail.com>)
 id 1xBzOv-000810-LV
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 14:51:36 -0400
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843c3ee4cfso2943217f8f.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 11:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790794289; x=1791399089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=r7i1IrT64o/7fZxNRm4nqi6zq1D/+yliH52iOpwnxDA=;
 b=notd2bkNnE833Aai97qG7Pbm7hEv1h9F6yS3TyxWXHU0Gsd1uqGWt/qfc8NIJFXeMg
 ztX/dQ3O7tZAXbKb1y3SLcrY+a+RSJYEiltGdPGAw9T9rgKNRVMAhIv0B+ARwjMjTZST
 jqkBZznr2AnJ/Qlva4U8X2ALIVQM6YVwq3EgZEBNYSGi9WimQ2C8vaa5lP1MTPz7jO4u
 BGTyA3C0m1UDAaoF0pk4qmq6SPuEj2qAIDVR+n7C2hte92L2YRAzRlN+DN+kZ6FIbUqt
 7wGICGJhOk5JrSxwhqDoeeLA8bZyniNaOam824Rnm9mg+mT8IzHvNt//KxJmYn6LjUv9
 9wzA==
X-Gm-Message-State: AFq9FYJ8IKQIFQOeg57uD4XvSnfwSdbIs+DWB40VEMGumE21wADGsSQr
 KW8gV2MUUD2Uof7RS7vJWOOXH42Iq5E9Js1zHTQx0ZbMk9QRCbDaMZygHQNppCDA
X-Gm-Gg: AYBFou1fjdD7zCnzBEG5gnJWDLazywsJMF6wq/NxaoIn/iRE2hLnU9hSNxE2iR7J05p
 UKn3iOuZ138NRgQj/mxuJZu5TSI51jiy5V0BAiblMpw8lTpTjH81Yfayn6tZmQ4blYmNiutZ2Oy
 razKhBsHRv4wey6ZpJ+GNvEnG+wSkmmzHc3TXAeEcCs6GyhFfllmJP+GKT6R/zDvpNiLOHYes2h
 moYn/Xkd/i5An5BM5daci05jljLMtpYzzjAemWiBnAlyCoITUdlMDnumlf6HVtejtNkI8I1uLKc
 OimGxuO+YykF5c6GpKTu2fNX5P5y9Rdh8WuiCV6M0IDEWcf8zIhDaRRK9xt4fBjou6RyOCJZOW+
 JUOKtZ1qkJVB17Ufjf3KaisLkICNFJt2eC7XDMNHJI0GIVgBTXtHumNWpo8V7NrvQR8it1QVzqt
 HXdalZvsA6rIJnxzeZOk58l3RZRpyEKu4pA9sMx4aZLwH1429IN3evqXI=
X-Received: by 2002:a5d:5e84:0:b0:48a:f11a:c34a with SMTP id
 ffacd0b85a97d-48b02579290mr4487724f8f.52.1790794289597; 
 Wed, 30 Sep 2026 11:51:29 -0700 (PDT)
Received: from tower ([185.182.52.52]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b068ff96dsm1162790f8f.8.2026.09.30.11.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 11:51:29 -0700 (PDT)
From: Dominic P <gcc@gcc.dp11.uk>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org,
 pbonzini@redhat.com, qemu-arm@nongnu.org
Subject: [PATCH 2/3] tests/tcg: Add tests for sign extension after rotate
Date: Wed, 30 Sep 2026 19:51:23 +0100
Message-ID: <20260930185124.3036980-3-gcc@gcc.dp11.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930185124.3036980-1-gcc@gcc.dp11.uk>
References: <20260930185124.3036980-1-gcc@gcc.dp11.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=74.125.225.76;
 envelope-from=dominic.plunkett@gmail.com; helo=mail-wr2-f12.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 30 Sep 2026 15:26:25 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Cover the rotr_i32 (ARM ror) and rotl_i32 (i386 roll) forms fixed by
the previous patch.  Both tests fail without it.

Assisted-by: Claude Opus 5 (Anthropic)
Signed-off-by: Dominic P <gcc@gcc.dp11.uk>
---
 tests/tcg/arm/meson.build          |  1 +
 tests/tcg/arm/test-arm-opt-ror.c   | 21 +++++++++++++++++++++
 tests/tcg/i386/meson.build         |  1 +
 tests/tcg/i386/test-i386-opt-rol.c | 21 +++++++++++++++++++++
 4 files changed, 44 insertions(+)
 create mode 100644 tests/tcg/arm/test-arm-opt-ror.c
 create mode 100644 tests/tcg/i386/test-i386-opt-rol.c

diff --git a/tests/tcg/arm/meson.build b/tests/tcg/arm/meson.build
index 8f70411dfd..fd82b5c7a6 100644
--- a/tests/tcg/arm/meson.build
+++ b/tests/tcg/arm/meson.build
@@ -39,6 +39,7 @@ tests += {
   },
   'pcalign-a32.c': {'cflags': ['-marm']},
   'issue4448.c': {},
+  'test-arm-opt-ror.c': {'cflags': ['-marm']},
 }
 
 # Vector SHA1
diff --git a/tests/tcg/arm/test-arm-opt-ror.c b/tests/tcg/arm/test-arm-opt-ror.c
new file mode 100644
index 0000000000..2579168a13
--- /dev/null
+++ b/tests/tcg/arm/test-arm-opt-ror.c
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Regression test for tcg optimize vs sign bit repetitions after rotate. */
+
+#include <assert.h>
+
+int main(void)
+{
+    /* Load from memory so that TCG does not see a constant. */
+    volatile int v = 3;
+    int x = v, gt;
+
+    asm("sxtb %1, %1\n\t"
+        "ror %1, %1, #1\n\t"
+        "sxtb %1, %1\n\t"
+        "cmp %1, #0\n\t"
+        "movle %0, #0\n\t"
+        "movgt %0, #1"
+        : "=r"(gt), "+r"(x) : : "cc");
+    assert(gt);
+    return 0;
+}
diff --git a/tests/tcg/i386/meson.build b/tests/tcg/i386/meson.build
index 04d438a062..4152371a3f 100644
--- a/tests/tcg/i386/meson.build
+++ b/tests/tcg/i386/meson.build
@@ -28,6 +28,7 @@ tests += {
   'test-i386-fxtract.c': {},
   'test-i386-fyl2x.c': {},
   'test-i386-fyl2xp1.c': {},
+  'test-i386-opt-rol.c': {},
   'test-i386-pcmpistri.c': {'cflags': ['-msse4.2']},
   'test-i386-pseudo-denormal.c': {},
   'test-i386-snan-convert.c': {},
diff --git a/tests/tcg/i386/test-i386-opt-rol.c b/tests/tcg/i386/test-i386-opt-rol.c
new file mode 100644
index 0000000000..e0393147e1
--- /dev/null
+++ b/tests/tcg/i386/test-i386-opt-rol.c
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Regression test for tcg optimize vs sign bit repetitions after rotate. */
+
+#include <assert.h>
+
+int main(void)
+{
+    /* Load from memory so that TCG does not see a constant. */
+    volatile int v = 3;
+    int x = v;
+    char test;
+
+    asm("movsbl %b1, %1\n\t"
+        "roll $31, %1\n\t"
+        "movsbl %b1, %1\n\t"
+        "testl %1, %1\n\t"
+        "setg %0"
+        : "=q"(test), "+q"(x));
+    assert(test);
+    return 0;
+}
-- 
2.55.0


