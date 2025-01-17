Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC436C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 17:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYpkR-00042V-9d; Fri, 17 Jan 2025 12:03:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYpjW-0003Gn-1w
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:02:17 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYpjT-000325-FX
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:02:09 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3862d16b4f5so1355086f8f.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 09:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737133325; x=1737738125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L8kJ0tPbXRiactJqx+pB3Csr4gR7HQOz+dxOaEcVCLU=;
 b=N5r8aRTMHGlRpuPsknlVJPjuqTVX8Uv8OJkpsx1wOqi8+r7y1gr6yMPWabHtHDHz/t
 oMRGrd+lJIgA5K2eLwQyG03JRBNfRQEqfB3fKubc11fh5zFBzMXJf9oY17EEPZhmnwkI
 ipWsSPtjQhta1wtV/YmOkfb9ZEavigc7GVG9iaycQyYIjbt8hYi0Kfm7E3tE5IViE9Rb
 sCl0yNddxtUH+4pWIZLFz/yskYHCMQeuCTN94ICmgLUk7cr9cCbn4JDgQVOhwyWJEi12
 HsIOU5aWCsnnIb6W4+UWBI8n2EiszoNMprh87FF27J+ZQVGhJ1ntmIH0JXafDYHPIiND
 hW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737133325; x=1737738125;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L8kJ0tPbXRiactJqx+pB3Csr4gR7HQOz+dxOaEcVCLU=;
 b=oZKYXMtmdGeTWRj3fJPGyLdCDyk4oP2xN2Ra10EJjNiYBZ6y4wUMo6qzceDhkiuHin
 pAzyfsSPV8chZ+k21cgl1VUJ4CvOHG66Zf52tIyBCC3rcSm4R8EccHWm3QeqqaVkcWJQ
 0ptNgwyVlq8KwvOwfYqdW417JRpVAEl/gAJMcKQbJ5hWpYMOq/tCvsyB+tvQCsecjY5b
 pzJnXuShgHzitNYbSCBa8uz7GYsxryO88B9HkcQXU5jQYUGrR22fKMN5hTZ6EDlu+D0G
 G+afCI0SccPtO+K3LQ7AmleY7eS7ISdhlBCAZ+Gzgqfzc+XiOUUVUc7iO1TaC1Q7OdOJ
 15uQ==
X-Gm-Message-State: AOJu0Yxu8NQ58EVzbB1UVfQr40XbhKKVRWM9+kn6yJIUjEzaq753abIr
 9kjQEhbdPDnHHulOgUjf5pjown5oEeErJrycDjfWDPDndKymRu3KL2nq1ZVNYn+iT7eCor0P5bM
 Gsbk=
X-Gm-Gg: ASbGnctJH2x2jki+b6WNVKFweJb8GBmQdxTWTilLhaNKHxc65C+Y+SKYaz86I/NtXCh
 n2XEoQyvVbpSEeCqaDAhfmrW94FPrIw9jfnYZu82UEkAPLhNTnDMYitXCf5/EbkIQ+5Z68tXmnD
 jCzCUB3uRbX+rkXer1mAr0GcnXt8B0M41C9L1dUG02Q+e0OUpvC3+Zi5xSYh5b6UOXpshOBFgqc
 rcFfoY8xAkhmhB6N+YIL4vmq03j7rA4vpqaGEfVmlYl3U/l2stkZFbftpM+79aih7z9R1t1dWoZ
 kJ7CeloYH+ICA2+JAIKjnyRYle830fg=
X-Google-Smtp-Source: AGHT+IF8RkNXFlznmCbaA55oKUQ2kLBTxGDawk9zOI2Gnk9vyy5A4dD3287Nj01abFt3lE06SPE/xw==
X-Received: by 2002:a5d:6482:0:b0:38a:87cd:6d67 with SMTP id
 ffacd0b85a97d-38bec3b45b2mr7991327f8f.0.1737133323436; 
 Fri, 17 Jan 2025 09:02:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4389040854bsm40682275e9.7.2025.01.17.09.02.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Jan 2025 09:02:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3] qemu/compiler: Absorb 'clang-tsa.h'
Date: Fri, 17 Jan 2025 18:02:01 +0100
Message-ID: <20250117170201.91182-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

We already have "qemu/compiler.h" for compiler-specific arrangements,
automatically included by "qemu/osdep.h" for each source file. No
need to explicitly include a header for a Clang particularity.

Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 bsd-user/qemu.h                  |   1 -
 include/block/block_int-common.h |   1 -
 include/block/graph-lock.h       |   2 -
 include/exec/page-protection.h   |   2 -
 include/qemu/clang-tsa.h         | 114 -------------------------------
 include/qemu/compiler.h          |  87 +++++++++++++++++++++++
 include/qemu/thread.h            |   1 -
 block/create.c                   |   1 -
 tests/unit/test-bdrv-drain.c     |   1 -
 tests/unit/test-block-iothread.c |   1 -
 util/qemu-thread-posix.c         |   1 -
 11 files changed, 87 insertions(+), 125 deletions(-)
 delete mode 100644 include/qemu/clang-tsa.h

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 3eaa14f3f56..4e97c796318 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -40,7 +40,6 @@ extern char **environ;
 #include "target.h"
 #include "exec/gdbstub.h"
 #include "exec/page-protection.h"
-#include "qemu/clang-tsa.h"
 #include "accel/tcg/vcpu-state.h"
 
 #include "qemu-os.h"
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index bb91a0f62fa..ebb4e56a503 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -28,7 +28,6 @@
 #include "block/block-common.h"
 #include "block/block-global-state.h"
 #include "block/snapshot.h"
-#include "qemu/clang-tsa.h"
 #include "qemu/iov.h"
 #include "qemu/rcu.h"
 #include "qemu/stats64.h"
diff --git a/include/block/graph-lock.h b/include/block/graph-lock.h
index dc8d9491843..2c26c721081 100644
--- a/include/block/graph-lock.h
+++ b/include/block/graph-lock.h
@@ -20,8 +20,6 @@
 #ifndef GRAPH_LOCK_H
 #define GRAPH_LOCK_H
 
-#include "qemu/clang-tsa.h"
-
 /**
  * Graph Lock API
  * This API provides a rwlock used to protect block layer
diff --git a/include/exec/page-protection.h b/include/exec/page-protection.h
index bae3355f62c..3e0a8a03331 100644
--- a/include/exec/page-protection.h
+++ b/include/exec/page-protection.h
@@ -40,8 +40,6 @@
 
 #ifdef CONFIG_USER_ONLY
 
-#include "qemu/clang-tsa.h"
-
 void TSA_NO_TSA mmap_lock(void);
 void TSA_NO_TSA mmap_unlock(void);
 bool have_mmap_lock(void);
diff --git a/include/qemu/clang-tsa.h b/include/qemu/clang-tsa.h
deleted file mode 100644
index ba06fb8c924..00000000000
--- a/include/qemu/clang-tsa.h
+++ /dev/null
@@ -1,114 +0,0 @@
-#ifndef CLANG_TSA_H
-#define CLANG_TSA_H
-
-/*
- * Copyright 2018 Jarkko Hietaniemi <jhi@iki.fi>
- *
- * Permission is hereby granted, free of charge, to any person obtaining
- * a copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without
- * limitation the rights to use, copy, modify, merge, publish,
- * distribute, sublicense, and/or sell copies of the Software, and to
- * permit persons to whom the Software is furnished to do so, subject to
- * the following conditions:
- *
- * The above copyright notice and this permission notice shall be
- * included in all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
- * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
- * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
- * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
- * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
- */
-
-/* http://clang.llvm.org/docs/ThreadSafetyAnalysis.html
- *
- * TSA is available since clang 3.6-ish.
- */
-#ifdef __clang__
-#  define TSA(x)   __attribute__((x))
-#else
-#  define TSA(x)   /* No TSA, make TSA attributes no-ops. */
-#endif
-
-/* TSA_CAPABILITY() is used to annotate typedefs:
- *
- * typedef pthread_mutex_t TSA_CAPABILITY("mutex") tsa_mutex;
- */
-#define TSA_CAPABILITY(x) TSA(capability(x))
-
-/* TSA_GUARDED_BY() is used to annotate global variables,
- * the data is guarded:
- *
- * Foo foo TSA_GUARDED_BY(mutex);
- */
-#define TSA_GUARDED_BY(x) TSA(guarded_by(x))
-
-/* TSA_PT_GUARDED_BY() is used to annotate global pointers, the data
- * behind the pointer is guarded.
- *
- * Foo* ptr TSA_PT_GUARDED_BY(mutex);
- */
-#define TSA_PT_GUARDED_BY(x) TSA(pt_guarded_by(x))
-
-/* The TSA_REQUIRES() is used to annotate functions: the caller of the
- * function MUST hold the resource, the function will NOT release it.
- *
- * More than one mutex may be specified, comma-separated.
- *
- * void Foo(void) TSA_REQUIRES(mutex);
- */
-#define TSA_REQUIRES(...) TSA(requires_capability(__VA_ARGS__))
-#define TSA_REQUIRES_SHARED(...) TSA(requires_shared_capability(__VA_ARGS__))
-
-/* TSA_EXCLUDES() is used to annotate functions: the caller of the
- * function MUST NOT hold resource, the function first acquires the
- * resource, and then releases it.
- *
- * More than one mutex may be specified, comma-separated.
- *
- * void Foo(void) TSA_EXCLUDES(mutex);
- */
-#define TSA_EXCLUDES(...) TSA(locks_excluded(__VA_ARGS__))
-
-/* TSA_ACQUIRE() is used to annotate functions: the caller of the
- * function MUST NOT hold the resource, the function will acquire the
- * resource, but NOT release it.
- *
- * More than one mutex may be specified, comma-separated.
- *
- * void Foo(void) TSA_ACQUIRE(mutex);
- */
-#define TSA_ACQUIRE(...) TSA(acquire_capability(__VA_ARGS__))
-#define TSA_ACQUIRE_SHARED(...) TSA(acquire_shared_capability(__VA_ARGS__))
-
-/* TSA_RELEASE() is used to annotate functions: the caller of the
- * function MUST hold the resource, but the function will then release it.
- *
- * More than one mutex may be specified, comma-separated.
- *
- * void Foo(void) TSA_RELEASE(mutex);
- */
-#define TSA_RELEASE(...) TSA(release_capability(__VA_ARGS__))
-#define TSA_RELEASE_SHARED(...) TSA(release_shared_capability(__VA_ARGS__))
-
-/* TSA_NO_TSA is used to annotate functions.  Use only when you need to.
- *
- * void Foo(void) TSA_NO_TSA;
- */
-#define TSA_NO_TSA TSA(no_thread_safety_analysis)
-
-/*
- * TSA_ASSERT() is used to annotate functions: This function will assert that
- * the lock is held. When it returns, the caller of the function is assumed to
- * already hold the resource.
- *
- * More than one mutex may be specified, comma-separated.
- */
-#define TSA_ASSERT(...) TSA(assert_capability(__VA_ARGS__))
-#define TSA_ASSERT_SHARED(...) TSA(assert_shared_capability(__VA_ARGS__))
-
-#endif /* #ifndef CLANG_TSA_H */
diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index c06954ccb41..b76ca535223 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -212,6 +212,93 @@
 # define QEMU_USED
 #endif
 
+/* http://clang.llvm.org/docs/ThreadSafetyAnalysis.html
+ *
+ * TSA is available since clang 3.6-ish.
+ */
+#ifdef __clang__
+#  define TSA(x)   __attribute__((x))
+#else
+#  define TSA(x)   /* No TSA, make TSA attributes no-ops. */
+#endif
+
+/* TSA_CAPABILITY() is used to annotate typedefs:
+ *
+ * typedef pthread_mutex_t TSA_CAPABILITY("mutex") tsa_mutex;
+ */
+#define TSA_CAPABILITY(x) TSA(capability(x))
+
+/* TSA_GUARDED_BY() is used to annotate global variables,
+ * the data is guarded:
+ *
+ * Foo foo TSA_GUARDED_BY(mutex);
+ */
+#define TSA_GUARDED_BY(x) TSA(guarded_by(x))
+
+/* TSA_PT_GUARDED_BY() is used to annotate global pointers, the data
+ * behind the pointer is guarded.
+ *
+ * Foo* ptr TSA_PT_GUARDED_BY(mutex);
+ */
+#define TSA_PT_GUARDED_BY(x) TSA(pt_guarded_by(x))
+
+/* The TSA_REQUIRES() is used to annotate functions: the caller of the
+ * function MUST hold the resource, the function will NOT release it.
+ *
+ * More than one mutex may be specified, comma-separated.
+ *
+ * void Foo(void) TSA_REQUIRES(mutex);
+ */
+#define TSA_REQUIRES(...) TSA(requires_capability(__VA_ARGS__))
+#define TSA_REQUIRES_SHARED(...) TSA(requires_shared_capability(__VA_ARGS__))
+
+/* TSA_EXCLUDES() is used to annotate functions: the caller of the
+ * function MUST NOT hold resource, the function first acquires the
+ * resource, and then releases it.
+ *
+ * More than one mutex may be specified, comma-separated.
+ *
+ * void Foo(void) TSA_EXCLUDES(mutex);
+ */
+#define TSA_EXCLUDES(...) TSA(locks_excluded(__VA_ARGS__))
+
+/* TSA_ACQUIRE() is used to annotate functions: the caller of the
+ * function MUST NOT hold the resource, the function will acquire the
+ * resource, but NOT release it.
+ *
+ * More than one mutex may be specified, comma-separated.
+ *
+ * void Foo(void) TSA_ACQUIRE(mutex);
+ */
+#define TSA_ACQUIRE(...) TSA(acquire_capability(__VA_ARGS__))
+#define TSA_ACQUIRE_SHARED(...) TSA(acquire_shared_capability(__VA_ARGS__))
+
+/* TSA_RELEASE() is used to annotate functions: the caller of the
+ * function MUST hold the resource, but the function will then release it.
+ *
+ * More than one mutex may be specified, comma-separated.
+ *
+ * void Foo(void) TSA_RELEASE(mutex);
+ */
+#define TSA_RELEASE(...) TSA(release_capability(__VA_ARGS__))
+#define TSA_RELEASE_SHARED(...) TSA(release_shared_capability(__VA_ARGS__))
+
+/* TSA_NO_TSA is used to annotate functions.  Use only when you need to.
+ *
+ * void Foo(void) TSA_NO_TSA;
+ */
+#define TSA_NO_TSA TSA(no_thread_safety_analysis)
+
+/*
+ * TSA_ASSERT() is used to annotate functions: This function will assert that
+ * the lock is held. When it returns, the caller of the function is assumed to
+ * already hold the resource.
+ *
+ * More than one mutex may be specified, comma-separated.
+ */
+#define TSA_ASSERT(...) TSA(assert_capability(__VA_ARGS__))
+#define TSA_ASSERT_SHARED(...) TSA(assert_shared_capability(__VA_ARGS__))
+
 /*
  * Ugly CPP trick that is like "defined FOO", but also works in C
  * code.  Useful to replace #ifdef with "if" statements; assumes
diff --git a/include/qemu/thread.h b/include/qemu/thread.h
index 7eba27a7049..6f800aad31a 100644
--- a/include/qemu/thread.h
+++ b/include/qemu/thread.h
@@ -3,7 +3,6 @@
 
 #include "qemu/processor.h"
 #include "qemu/atomic.h"
-#include "qemu/clang-tsa.h"
 
 typedef struct QemuCond QemuCond;
 typedef struct QemuSemaphore QemuSemaphore;
diff --git a/block/create.c b/block/create.c
index 72abafb4c12..6b23a216753 100644
--- a/block/create.c
+++ b/block/create.c
@@ -24,7 +24,6 @@
 
 #include "qemu/osdep.h"
 #include "block/block_int.h"
-#include "qemu/clang-tsa.h"
 #include "qemu/job.h"
 #include "qemu/main-loop.h"
 #include "qapi/qapi-commands-block-core.h"
diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index 98ad89b390c..7410e6f3528 100644
--- a/tests/unit/test-bdrv-drain.c
+++ b/tests/unit/test-bdrv-drain.c
@@ -28,7 +28,6 @@
 #include "system/block-backend.h"
 #include "qapi/error.h"
 #include "qemu/main-loop.h"
-#include "qemu/clang-tsa.h"
 #include "iothread.h"
 
 static QemuEvent done_event;
diff --git a/tests/unit/test-block-iothread.c b/tests/unit/test-block-iothread.c
index 1de04a8a13d..26a6c051758 100644
--- a/tests/unit/test-block-iothread.c
+++ b/tests/unit/test-block-iothread.c
@@ -29,7 +29,6 @@
 #include "system/block-backend.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
-#include "qemu/clang-tsa.h"
 #include "qemu/main-loop.h"
 #include "iothread.h"
 
diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
index 6fff4162ac6..b2e26e21205 100644
--- a/util/qemu-thread-posix.c
+++ b/util/qemu-thread-posix.c
@@ -17,7 +17,6 @@
 #include "qemu-thread-common.h"
 #include "qemu/tsan.h"
 #include "qemu/bitmap.h"
-#include "qemu/clang-tsa.h"
 
 #ifdef CONFIG_PTHREAD_SET_NAME_NP
 #include <pthread_np.h>
-- 
2.47.1


