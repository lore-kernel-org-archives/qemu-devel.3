Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50963C369A2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 15:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1oBC-0002Bc-Rx; Mon, 07 Apr 2025 11:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u1nm6-0002F4-PR; Mon, 07 Apr 2025 10:48:35 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u1nm4-0001jX-OA; Mon, 07 Apr 2025 10:48:34 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-736e52948ebso5152082b3a.1; 
 Mon, 07 Apr 2025 07:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744037310; x=1744642110; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=50grsCyUNExDjQBR3M1QLWMMiStdz5s3sePxgxhYNa4=;
 b=BaQU72cvJCzWA0FjvYNiYXyG4u0MNKJ8L9scUsKDDXu0kTo9kQKrglyyCB2gfe4y+4
 7LtlAuqMJJ165dQuFf3wbVUHG6Z6FEH1cI/M8Hdl3/wc6uJr9RR4ljXKN3Ovrg7v6CuC
 uo9G+q1OLCdLXXXBM9kANcZ6qiUl3gGqVpdMzICiCV0CmV6nU+vyYZAW25hkkTNo12Um
 R0W7hWm8j7NaWk63JcafMJx9KIVRHZqR1t+Aigi6xmrLfg7iaEhNfGvzW6zR6vjUAOAm
 k/L7c6iae+A97aVsbqwJhQyojLekmSDF1aUTZVgKxl0EjDoPmuGaFb7AupJKhPcd1Dhy
 0yaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744037310; x=1744642110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=50grsCyUNExDjQBR3M1QLWMMiStdz5s3sePxgxhYNa4=;
 b=QdX45uzZXKROnThFTzUKJ5zel28xMOqgt7EjM2UKGrB0A9srB5oxD8C7NHm6Gsp2W3
 ERJX3pT4r5jApLOllhIUEw76mqEJGTIbgycJu5la5TAHD9MNujdX/6rxjYe/xLpLS2fJ
 ma+Jd2Vp7qRaNscpyB9Nay7YUSmKFKtQ+disGlkSn1v7VQWpsXUavABId9SxWv6ch4Ag
 Sg61y6RHx/aP3tqqa+0QpCv6p/2281Tvu0Ngcd/qIXXc2+WnDcdCWXKP41zIkGynDsqH
 YelvFk0yTz04M6mVVNwEkrIRtt0cs1nPENUnYpSpIzrLcSgpO0AO4JUCYPsnfnwH26nQ
 sLCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkSgwN42HPAlV3ALTqrqVPq0krNLNtqG9j/tvJjt78EKRfo2MsvOreDWHPLavjEpeZ1phcziT4WG6GuA==@nongnu.org,
 AJvYcCWd1WAXEXqNQK8PvPEp7Rkr+CT2ftQpTBo8pwfTa5TBepCcAFKMaQOgPULo7tZtK+2kgy5jsgnC4g==@nongnu.org,
 AJvYcCX/9UUjddouQQ0UQ9kkSKSJJlPhjS9P3PP8A+5fxVXR5HM6G8rKWD008aBtXUtdfweJ3RLGpggABuOJ0w==@nongnu.org
X-Gm-Message-State: AOJu0YzOvqU+sOTuKzDDnhEYOijxbbId/rGwR24H85tHWwodg8i+VWR2
 522Gh6VoGrXV9drEput6hLBVYvjAkm8oYO/Qlylp//iN5h2MEWYpho+pgRpM
X-Gm-Gg: ASbGnct1+BPlzA7XOxc0V9mxISwVnbBVRfAT+6lV9tbVV/1E/iPpb4z/RsLVmeEkWpi
 RFW91As7TdMbWfOlauBxYpwBSfa7BBkyp7nsIXQB8SsnCKfn9rvg/9F0tWw4bbEF87w+ApP84N/
 bKzP7m21GUtZi8sKJv+HxKP1jM8aSoQ/MNwaAj9UXXUInlw4t+0uCqz2D1yyEZZcFkvPeSMYzOt
 PNv9VoN2uHiLy1dUhGvUwBUkcJ61A7Rk+4Vc81o1FH3EcHNN6CA0Hh9jItDIUXutq70f2fi6CrM
 bi61cXqt6k0Ek8yV3aeIEbLNYr3eTmdnOOkXj57hgVzzxNpM5Mk69nZhwxisRQ==
X-Google-Smtp-Source: AGHT+IEtdgebOWYfB7Ru5RkfAP3s2nGxPBFQ/5hJFI03pD4SFHdP8PDukDExTccgtz8IaaGtRQK4/Q==
X-Received: by 2002:a05:6a00:398d:b0:736:ab49:a6e4 with SMTP id
 d2e1a72fcca58-739e6fbf853mr16492428b3a.1.1744037310339; 
 Mon, 07 Apr 2025 07:48:30 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:3b6:8b00:8768:486:6a8e:e855])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-739d97ef3c2sm8856960b3a.59.2025.04.07.07.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 07:48:29 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH 08/10] hw/9pfs: Allow using hw/9pfs with emscripten
Date: Mon,  7 Apr 2025 23:45:59 +0900
Message-Id: <16376e4b63fad6f847ceadb39b8f9780fc288198.1744032780.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1744032780.git.ktokunaga.mail@gmail.com>
References: <cover.1744032780.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 07 Apr 2025 11:14:07 -0400
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

Emscripten's fiber does not support submitting coroutines to other
threads. So this commit modifies hw/9pfs/coth.h to disable this behavior
when compiled with Emscripten.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 fsdev/file-op-9p.h     |  3 +++
 fsdev/meson.build      |  2 +-
 hw/9pfs/9p-util-stub.c | 43 ++++++++++++++++++++++++++++++++++++++++++
 hw/9pfs/9p-util.h      | 18 ++++++++++++++++++
 hw/9pfs/9p.c           |  3 +++
 hw/9pfs/coth.h         | 12 ++++++++++++
 hw/9pfs/meson.build    |  2 ++
 meson.build            |  6 +++---
 8 files changed, 85 insertions(+), 4 deletions(-)
 create mode 100644 hw/9pfs/9p-util-stub.c

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index 4997677460..b7ca2640ce 100644
--- a/fsdev/file-op-9p.h
+++ b/fsdev/file-op-9p.h
@@ -26,6 +26,9 @@
 # include <sys/param.h>
 # include <sys/mount.h>
 #endif
+#ifdef EMSCRIPTEN
+#include <sys/vfs.h>
+#endif
 
 #define SM_LOCAL_MODE_BITS    0600
 #define SM_LOCAL_DIR_MODE_BITS    0700
diff --git a/fsdev/meson.build b/fsdev/meson.build
index c751d8cb62..c3e92a29d7 100644
--- a/fsdev/meson.build
+++ b/fsdev/meson.build
@@ -5,6 +5,6 @@ fsdev_ss.add(when: ['CONFIG_FSDEV_9P'], if_true: files(
   '9p-marshal.c',
   'qemu-fsdev.c',
 ), if_false: files('qemu-fsdev-dummy.c'))
-if host_os in ['linux', 'darwin']
+if host_os in ['linux', 'darwin', 'emscripten']
   system_ss.add_all(fsdev_ss)
 endif
diff --git a/hw/9pfs/9p-util-stub.c b/hw/9pfs/9p-util-stub.c
new file mode 100644
index 0000000000..57c89902ab
--- /dev/null
+++ b/hw/9pfs/9p-util-stub.c
@@ -0,0 +1,43 @@
+/*
+ * 9p utilities stub functions
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "9p-util.h"
+
+ssize_t fgetxattrat_nofollow(int dirfd, const char *path, const char *name,
+                             void *value, size_t size)
+{
+    return -1;
+}
+
+ssize_t flistxattrat_nofollow(int dirfd, const char *filename,
+                              char *list, size_t size)
+{
+    return -1;
+}
+
+ssize_t fremovexattrat_nofollow(int dirfd, const char *filename,
+                                const char *name)
+{
+    return -1;
+}
+
+int fsetxattrat_nofollow(int dirfd, const char *path, const char *name,
+                         void *value, size_t size, int flags)
+{
+    return -1;
+
+}
+
+int qemu_mknodat(int dirfd, const char *filename, mode_t mode, dev_t dev)
+{
+    return -1;
+}
+
+ssize_t fgetxattr(int fd, const char *name, void *value, size_t size)
+{
+    return -1;
+}
diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
index 7bc4ec8e85..8c5006fcdc 100644
--- a/hw/9pfs/9p-util.h
+++ b/hw/9pfs/9p-util.h
@@ -84,6 +84,24 @@ static inline int errno_to_dotl(int err) {
     } else if (err == EOPNOTSUPP) {
         err = 95; /* ==EOPNOTSUPP on Linux */
     }
+#elif defined(EMSCRIPTEN)
+    /*
+     * FIXME: Only most important errnos translated here yet, this should be
+     * extended to as many errnos being translated as possible in future.
+     */
+    if (err == ENAMETOOLONG) {
+        err = 36; /* ==ENAMETOOLONG on Linux */
+    } else if (err == ENOTEMPTY) {
+        err = 39; /* ==ENOTEMPTY on Linux */
+    } else if (err == ELOOP) {
+        err = 40; /* ==ELOOP on Linux */
+    } else if (err == ENODATA) {
+        err = 61; /* ==ENODATA on Linux */
+    } else if (err == ENOTSUP) {
+        err = 95; /* ==EOPNOTSUPP on Linux */
+    } else if (err == EOPNOTSUPP) {
+        err = 95; /* ==EOPNOTSUPP on Linux */
+    }
 #else
 #error Missing errno translation to Linux for this host system
 #endif
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 7cad2bce62..4f45f0edd3 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -4013,6 +4013,9 @@ out_nofid:
  * Linux guests.
  */
 #define P9_XATTR_SIZE_MAX 65536
+#elif defined(EMSCRIPTEN)
+/* No support for xattr */
+#define P9_XATTR_SIZE_MAX 0
 #else
 #error Missing definition for P9_XATTR_SIZE_MAX for this host system
 #endif
diff --git a/hw/9pfs/coth.h b/hw/9pfs/coth.h
index 2c54249b35..7b0d05ba1b 100644
--- a/hw/9pfs/coth.h
+++ b/hw/9pfs/coth.h
@@ -19,6 +19,7 @@
 #include "qemu/coroutine-core.h"
 #include "9p.h"
 
+#ifndef EMSCRIPTEN
 /*
  * we want to use bottom half because we want to make sure the below
  * sequence of events.
@@ -57,6 +58,17 @@
         /* re-enter back to qemu thread */                              \
         qemu_coroutine_yield();                                         \
     } while (0)
+#else
+/*
+ * FIXME: implement this on emscripten but emscripten's coroutine
+ * implementation (fiber) doesn't support submitting a coroutine to other
+ * threads.
+ */
+#define v9fs_co_run_in_worker(code_block)                               \
+    do {                                                                \
+        code_block;                                                     \
+    } while (0)
+#endif
 
 void co_run_in_worker_bh(void *);
 int coroutine_fn v9fs_co_readlink(V9fsPDU *, V9fsPath *, V9fsString *);
diff --git a/hw/9pfs/meson.build b/hw/9pfs/meson.build
index d35d4f44ff..04f85fb9e9 100644
--- a/hw/9pfs/meson.build
+++ b/hw/9pfs/meson.build
@@ -17,6 +17,8 @@ if host_os == 'darwin'
   fs_ss.add(files('9p-util-darwin.c'))
 elif host_os == 'linux'
   fs_ss.add(files('9p-util-linux.c'))
+elif host_os == 'emscripten'
+  fs_ss.add(files('9p-util-stub.c'))
 endif
 fs_ss.add(when: 'CONFIG_XEN_BUS', if_true: files('xen-9p-backend.c'))
 system_ss.add_all(when: 'CONFIG_FSDEV_9P', if_true: fs_ss)
diff --git a/meson.build b/meson.build
index ab84820bc5..a3aadf8b59 100644
--- a/meson.build
+++ b/meson.build
@@ -2356,11 +2356,11 @@ dbus_display = get_option('dbus_display') \
   .allowed()
 
 have_virtfs = get_option('virtfs') \
-    .require(host_os == 'linux' or host_os == 'darwin',
+    .require(host_os == 'linux' or host_os == 'darwin' or host_os == 'emscripten',
              error_message: 'virtio-9p (virtfs) requires Linux or macOS') \
-    .require(host_os == 'linux' or cc.has_function('pthread_fchdir_np'),
+    .require(host_os == 'linux' or host_os == 'emscripten' or cc.has_function('pthread_fchdir_np'),
              error_message: 'virtio-9p (virtfs) on macOS requires the presence of pthread_fchdir_np') \
-    .require(host_os == 'darwin' or libattr.found(),
+    .require(host_os == 'darwin' or host_os == 'emscripten' or libattr.found(),
              error_message: 'virtio-9p (virtfs) on Linux requires libattr-devel') \
     .disable_auto_if(not have_tools and not have_system) \
     .allowed()
-- 
2.25.1


