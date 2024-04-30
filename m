Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C7AC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 19:44:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1tNj-00075y-Nh; Tue, 30 Apr 2024 15:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1tNi-00075j-2n
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 15:43:14 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1tNa-0006li-Ht
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 15:43:13 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5aa2551d33dso4121499eaf.0
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 12:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714506184; x=1715110984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P8aiuTj5/6yjo0wKZf1j2mdDbeTtUm906YMvC+PIZPk=;
 b=KWkETIoyPXdYR+JOUg8Dxlxk7DS5MqnBbiKGSAp9Ov0cyrPPYPsVdFiHQctGXwmZeW
 Y6mRaRfbUVQ+Ka5lUWjWaFrqM0DEWq8jzj9yU3CJhUlxpbzOuhJM+HN5uTdKaokwf2EG
 VIO+GEgDWPVWYv9Ylpc0255cLaXdvKB8STVLjZqMuACCNUxgWuKCtjX+2fQCxdWnGkMB
 QcMns2Ytk/AUouO49WHxPRS4aoAMNUsE7okWFf69Lqr/RDWferasLaKYRbcHNUQi0wXR
 iyMN7k8Q+lUNyrbgLZKS0pzFNaXHRNIrvPbettxoTJ0Q5BZMZNvA5W6W6FHj3d6RYktR
 H4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714506184; x=1715110984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P8aiuTj5/6yjo0wKZf1j2mdDbeTtUm906YMvC+PIZPk=;
 b=HW2QQx9l1x10Totkk6iNDPdCwhh1BVjLwMrI4r71oTc/SJpU4QWrr62aUvR8RqKBCU
 J0dyupfFnxAVFU6/hLXYv4XQ8DK4ZWR/Jwhx0vjzJxFygi9FNyOvuBUYUQEeuQtwjDXG
 a6whd5xYOF4c1IPxZZlsOohKEo2F28Jy4GFX4odVum3JdHhVW0G6wVE4hXHB9gMlxS2f
 XJX4OpGW3mseU4FzIcpsbhhLeFXAe7QEy8G6DLK++XvWgrAXAlbRlKjqNW+VjZ0sWPLI
 6YyE8mRGXJqdmXe/yR86JlDUs/1T4n7A3FboAaKByDRY4WgiXlRUJ+hG2fnZwhbLReX/
 Pt/g==
X-Gm-Message-State: AOJu0YxsPdrIyhdFxxm75JnDUXqUZlzBxJ2Geg0RlVeiCLQjAfsHgEs1
 FKuIoXZE7XO/iItsenHs0JK6XqnfNouxs8DqMF17Z44dUrdvhbeUuTIswLo551c0sywBVXCRJDn
 F
X-Google-Smtp-Source: AGHT+IHfBl+oazG3UWvzGGlWkOGI/C2QhkRfYf3qCUph+JcVQY7TlL1sDBzIfoh3Dh2SjT+q1ioDUw==
X-Received: by 2002:a05:6358:988b:b0:17f:729a:8562 with SMTP id
 q11-20020a056358988b00b0017f729a8562mr391176rwa.3.1714506184111; 
 Tue, 30 Apr 2024 12:43:04 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a63360c000000b005d880b41598sm20861523pga.94.2024.04.30.12.43.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 12:43:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v7 10/10] tests/bench: Add bufferiszero-bench
Date: Tue, 30 Apr 2024 12:42:53 -0700
Message-Id: <20240430194253.904768-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430194253.904768-1-richard.henderson@linaro.org>
References: <20240430194253.904768-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/bench/bufferiszero-bench.c | 47 ++++++++++++++++++++++++++++++++
 tests/bench/meson.build          |  1 +
 2 files changed, 48 insertions(+)
 create mode 100644 tests/bench/bufferiszero-bench.c

diff --git a/tests/bench/bufferiszero-bench.c b/tests/bench/bufferiszero-bench.c
new file mode 100644
index 0000000000..222695c1fa
--- /dev/null
+++ b/tests/bench/bufferiszero-bench.c
@@ -0,0 +1,47 @@
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
+    size_t max = 64 * KiB;
+    void *buf = g_malloc0(max);
+    int accel_index = 0;
+
+    do {
+        if (accel_index != 0) {
+            g_test_message("%s", "");  /* gnu_printf Werror for simple "" */
+        }
+        for (size_t len = 1 * KiB; len <= max; len *= 4) {
+            double total = 0.0;
+
+            g_test_timer_start();
+            do {
+                buffer_is_zero_ge256(buf, len);
+                total += len;
+            } while (g_test_timer_elapsed() < 0.5);
+
+            total /= MiB;
+            g_test_message("buffer_is_zero #%d: %2zuKB %8.0f MB/sec",
+                           accel_index, len / (size_t)KiB,
+                           total / g_test_timer_last());
+        }
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
index 7e76338a52..4cd7a2f6b5 100644
--- a/tests/bench/meson.build
+++ b/tests/bench/meson.build
@@ -21,6 +21,7 @@ benchs = {}
 
 if have_block
   benchs += {
+     'bufferiszero-bench': [],
      'benchmark-crypto-hash': [crypto],
      'benchmark-crypto-hmac': [crypto],
      'benchmark-crypto-cipher': [crypto],
-- 
2.34.1


