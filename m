Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4C9C48BF8
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 00:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb8jz-00069T-VA; Fri, 16 Feb 2024 19:39:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rb8jy-00069I-7Z
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:39:38 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rb8jv-0008Hr-S5
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 19:39:37 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d934c8f8f7so27591955ad.2
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 16:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708130374; x=1708735174; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q7NI6Uyf4Ttcuc/zyuTSXU3zmAAyzJ/7snw/vL2uCLQ=;
 b=A+7ECMEHbBYmVaybAF8cM0cQgyB2QbbPGAmdw42c1eTrDWJgwnCWPUmiClNEG8MF4n
 LM5LJzKfRWTOcYX4M6zFPSI53BDOfy2a5CnS+wVJMcCkSXAFxNnMnBtMGlM5c0JpOZga
 c/lPjXDvJFL5Zpg2XheUVB9zVwF8Vyg1ftZ1Sms4vsY2Vti4QWo+7QL/RMt5jF+Wqww0
 UhYwUwXfPo4qRyVoqD5Yenm9PhMlfuQoLa4FHn/eB3L9nK9ht7Cx/MJQUb9eC8Rmcmii
 Tka6xBilw+v9KNxiVbUjc7wSVA92oxPs4eC49FQPQLpES38G6V6g3i7hC/goIOWzp40L
 lE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708130374; x=1708735174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q7NI6Uyf4Ttcuc/zyuTSXU3zmAAyzJ/7snw/vL2uCLQ=;
 b=BVVwxw9mviGPhGHdkKeSr6ukvvFI3wibSxf69z1TblsfC1PBQJMkRal5spGo2X/wsQ
 t3+uFbEit1Nomgy9+1zTTC+iZ7QzuqbKxSx/fWle/vjjrB2u0bZ5rJ91OCXJ7OGxby22
 +F6qZB9z8AfrdOn/4VU2dMPd+SXYIwXry0s6Q4yzDjwL7m+htOWCKs42pnXktKuuDElL
 BzG4DnOsHnULTz6PcBg91CYFq2WZZxclCA9rybwGu+Ro0k/9Fw2an+pBgduyClyAHQ25
 WRBgk28EajfCujj3VrNlmeQ/mhs+Vj4eoGmwu8TBEzMF1DflVpjMiL6scYq6ppcaxqR1
 eYcw==
X-Gm-Message-State: AOJu0Yw9fb8RpbUPlNruKyNP5jwehq08QgdkM87coK1AsBNCf9D8YZZ/
 pi7f+XDOd7eVnt5oVhLj/h+MiLevL9lY/8l0mYtJgd1WXwrUgQ+r0/hEGq6CkxefDa0hQpXUU4z
 K
X-Google-Smtp-Source: AGHT+IERvVbl1Nqh/SxQ4vXHIXYlXb7EmGsyk0p7sbRMWQJM5CjOe3efsNTi27M5JRmWx3UZ/UWqcw==
X-Received: by 2002:a17:902:ce92:b0:1d7:147d:6a1d with SMTP id
 f18-20020a170902ce9200b001d7147d6a1dmr7161232plg.55.1708130374676; 
 Fri, 16 Feb 2024 16:39:34 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 z6-20020a170902ee0600b001d90306bdcfsm419325plb.65.2024.02.16.16.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 16:39:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: amonakov@ispras.ru,
	mmromanov@ispras.ru
Subject: [PATCH v5 10/10] tests/bench: Add bufferiszero-bench
Date: Fri, 16 Feb 2024 14:39:18 -1000
Message-Id: <20240217003918.52229-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217003918.52229-1-richard.henderson@linaro.org>
References: <20240217003918.52229-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Benchmark each acceleration function vs an aligned buffer of zeros.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/bench/bufferiszero-bench.c | 42 ++++++++++++++++++++++++++++++++
 tests/bench/meson.build          |  4 ++-
 2 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100644 tests/bench/bufferiszero-bench.c

diff --git a/tests/bench/bufferiszero-bench.c b/tests/bench/bufferiszero-bench.c
new file mode 100644
index 0000000000..1fa2eb6973
--- /dev/null
+++ b/tests/bench/bufferiszero-bench.c
@@ -0,0 +1,42 @@
+/*
+ * QEMU buffer_is_zero speed benchmark
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "qemu/cutils.h"
+#include "qemu/units.h"
+
+static void test(const void *opaque)
+{
+    size_t len = 64 * KiB;
+    void *buf = g_malloc0(len);
+    int accel_index = 0;
+
+    do {
+        double total = 0.0;
+
+        g_test_timer_start();
+        do {
+            buffer_is_zero_ge256(buf, len);
+            total += len;
+        } while (g_test_timer_elapsed() < 5.0);
+
+        total /= MiB;
+        g_test_message("buffer_is_zero #%d: %.2f MB/sec",
+                       accel_index, total / g_test_timer_last());
+
+        accel_index++;
+    } while (test_buffer_is_zero_next_accel());
+
+    g_free(buf);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+    g_test_add_data_func("/cutils/bufferiszero/speed", NULL, test);
+    return g_test_run();
+}
diff --git a/tests/bench/meson.build b/tests/bench/meson.build
index 7e76338a52..70d45ff400 100644
--- a/tests/bench/meson.build
+++ b/tests/bench/meson.build
@@ -17,7 +17,9 @@ executable('atomic64-bench',
            dependencies: [qemuutil],
            build_by_default: false)
 
-benchs = {}
+benchs = {
+    'bufferiszero-bench': [],
+}
 
 if have_block
   benchs += {
-- 
2.34.1


