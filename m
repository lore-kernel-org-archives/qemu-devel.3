Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E2DC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 15:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYoQ7-00010L-4y; Tue, 30 Jul 2024 11:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sYoQ5-0000yx-2e
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 11:05:45 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sYoQ2-00041J-Ek
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 11:05:44 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ef298ff716so8604761fa.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 08:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722351939; x=1722956739;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MD3SZjQaELpHhaRRsED0fgSL5OizI87LWpY75t1A8Zw=;
 b=YbQO36ClSzLyvQLjUcQpdnXnnPoq6A/FD0NDRyT+9Wwy+9zoImhAXqkbOIoIB/YqWH
 O6IpmOi25bRGzrG8kJYfdDeARXzTilZdSs0AG7BWIzr1toQDfGoaq9qFyQWJLd11hQP3
 n1wsx+kwvzzDj/52/+j/bY0eRwlbEHZ47IHN0PC08QTYAxTQruubghHCqriWrg97v9vX
 APWYt683uuItJpWAL1Ex9rXT/c0tl63J42sxqa8irYsOtjsBGPPK5KasMFIF2bHLUqnS
 BCUIwjjWu9xKLQVeqS8b+F5U5J7/KTSSG8DF8BDR0eQuTz5KyR2zvgtu8xF2/C35QtE9
 xjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722351939; x=1722956739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MD3SZjQaELpHhaRRsED0fgSL5OizI87LWpY75t1A8Zw=;
 b=Ci0IrINsOQHqa9wZppv8vFS7MtdIa92wxWDRnjrY490h6hxOcI7M5MUKxYv0GMZ6XY
 3flXkuOoDUC4v4ezy6N7U+R5RP/tE00ZHjVuvbNPtmfP64eJbC4GAkjX0l+X2s66x1ou
 ilTKlBEcoPQpCK8QNXDctZVUd8cWC+oNU7XTr2AE8G22Ycp8jhC0qCDuUEPTFaRkSuEt
 ujwpAbcp28wpWRQ62tBsLEfTav0/bdmDEkTyqtoojXf5DlQ9IjKYP0WWJbyxiKCOSFef
 hvFx/yyRrarvhYOc46I7jm7ZUDHzFlBTYOPd7S4AEbPkPAQpm4WgSqeW1OCW22BSUpms
 Uznw==
X-Gm-Message-State: AOJu0YzPDqKdfoq5nwHek2IrojGZVko6Gth6+4eYJaLWqF1wJLQlIKJt
 ajT363YkhLqLQTY9Y1NjHS/jViuHHhbEPePKVH49ToniGQKRryZM/Ad+9Wwx5CHeMFbHu2qhThn
 Mqpk=
X-Google-Smtp-Source: AGHT+IHriaT1wvvutTP7Qzjy0U75fJZvDUaiSh3bdM3D+wHZsXRb9cA2f7bzk4c+4JC/Js4jE2GHRg==
X-Received: by 2002:a5d:5f49:0:b0:360:8490:74d with SMTP id
 ffacd0b85a97d-36b34d240a7mr7415237f8f.5.1722342285039; 
 Tue, 30 Jul 2024 05:24:45 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36862549sm14577757f8f.106.2024.07.30.05.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 05:24:44 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 4/5] qemu/osdep: Add excluded fd parameter to
 qemu_close_all_open_fd()
Date: Tue, 30 Jul 2024 14:24:27 +0200
Message-ID: <20240730122437.1749603-5-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730122437.1749603-1-cleger@rivosinc.com>
References: <20240730122437.1749603-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=cleger@rivosinc.com; helo=mail-lj1-x234.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

In order for this function to be usable by tap.c code, add a list of
file descriptors that should not be closed.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 include/qemu/osdep.h    |  8 +++-
 system/async-teardown.c |  2 +-
 util/oslib-posix.c      | 99 ++++++++++++++++++++++++++++++++++-------
 3 files changed, 91 insertions(+), 18 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 5cd8517380..0bf6f0a356 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -760,9 +760,13 @@ int qemu_fdatasync(int fd);
 /**
  * qemu_close_all_open_fd:
  *
- * Close all open file descriptors
+ * Close all open file descriptors except the ones supplied in the @skip array
+ *
+ * @skip: ordered array of distinct file descriptors that should not be closed
+ *        if any, or NULL.
+ * @nskip: number of entries in the @skip array or 0 if @skip is NULL.
  */
-void qemu_close_all_open_fd(void);
+void qemu_close_all_open_fd(const int *skip, unsigned int nskip);
 
 /**
  * Sync changes made to the memory mapped file back to the backing
diff --git a/system/async-teardown.c b/system/async-teardown.c
index edf49e1007..9148ee8d04 100644
--- a/system/async-teardown.c
+++ b/system/async-teardown.c
@@ -52,7 +52,7 @@ static int async_teardown_fn(void *arg)
      * Close all file descriptors that might have been inherited from the
      * main qemu process when doing clone, needed to make libvirt happy.
      */
-    qemu_close_all_open_fd();
+    qemu_close_all_open_fd(NULL, 0);
 
     /* Set up a handler for SIGHUP and unblock SIGHUP. */
     sigaction(SIGHUP, &sa, NULL);
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index a6749d9f9b..e7bffaea16 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -808,11 +808,14 @@ int qemu_msync(void *addr, size_t length, int fd)
     return msync(addr, length, MS_SYNC);
 }
 
-static bool qemu_close_all_open_fd_proc(void)
+
+static bool qemu_close_all_open_fd_proc(const int *skip, unsigned int nskip)
 {
     struct dirent *de;
     int fd, dfd;
+    bool close_fd;
     DIR *dir;
+    unsigned int i, skip_start = 0, skip_end = nskip;
 
     dir = opendir("/proc/self/fd");
     if (!dir) {
@@ -823,8 +826,31 @@ static bool qemu_close_all_open_fd_proc(void)
     dfd = dirfd(dir);
 
     for (de = readdir(dir); de; de = readdir(dir)) {
+        if (de->d_name[0] == '.') {
+            continue;
+        }
         fd = atoi(de->d_name);
-        if (fd != dfd) {
+        close_fd = true;
+        if (fd == dfd) {
+            close_fd = false;
+        } else {
+            for (i = skip_start; i < skip_end; i++) {
+                if (fd < skip[i]) {
+                    /* We are below the next skipped fd, break */
+                    break;
+                } else if (fd == skip[i]) {
+                    close_fd = false;
+                    /* Restrict the range as we found fds matching start/end */
+                    if (i == skip_start) {
+                        skip_start++;
+                    } else if (i == skip_end) {
+                        skip_end--;
+                    }
+                    break;
+                }
+            }
+        }
+        if (close_fd) {
             close(fd);
         }
     }
@@ -833,36 +859,79 @@ static bool qemu_close_all_open_fd_proc(void)
     return true;
 }
 
-static bool qemu_close_all_open_fd_close_range(void)
+static bool qemu_close_all_open_fd_close_range(const int *skip,
+                                               unsigned int nskip)
 {
 #ifdef CONFIG_CLOSE_RANGE
-    int r = close_range(0, ~0U, 0);
-    if (!r) {
-        /* Success, no need to try other ways. */
-        return true;
-    }
-#endif
+    int max_fd = sysconf(_SC_OPEN_MAX) - 1;
+    int first = 0, last = max_fd;
+    unsigned int cur_skip = 0;
+    int ret;
+
+    do {
+        /* Find the start boundary of the range to close */
+        while (cur_skip < nskip && first == skip[cur_skip]) {
+            cur_skip++;
+            first++;
+        }
+
+        /* Find the upper boundary of the range to close */
+        if (cur_skip < nskip) {
+            last = skip[cur_skip] - 1;
+        }
+        /*
+         * Adjust the maximum fd to close if it's above what the system
+         * supports
+         */
+        if (last > max_fd) {
+            last = max_fd;
+            /*
+             * We can directly skip the remaining skip fds since the current
+             * one is already above the maximum supported one.
+             */
+            cur_skip = nskip;
+        }
+        /* If last was adjusted, we might be > first, bail out */
+        if (first > last) {
+            break;
+        }
+
+        ret = close_range(first, last, 0);
+        if (ret < 0) {
+            return false;
+        }
+        first = last + 1;
+        last = max_fd;
+    } while (cur_skip < nskip);
+
+    return true;
+#else
     return false;
+#endif
 }
 
-/*
- * Close all open file descriptors.
- */
-void qemu_close_all_open_fd(void)
+void qemu_close_all_open_fd(const int *skip, unsigned int nskip)
 {
     int open_max = sysconf(_SC_OPEN_MAX);
+    unsigned int cur_skip = 0;
     int i;
 
-    if (qemu_close_all_open_fd_close_range()) {
+    assert(skip != NULL || nskip == 0);
+
+    if (qemu_close_all_open_fd_close_range(skip, nskip)) {
         return;
     }
 
-    if (qemu_close_all_open_fd_proc()) {
+    if (qemu_close_all_open_fd_proc(skip, nskip)) {
         return;
     }
 
     /* Fallback */
     for (i = 0; i < open_max; i++) {
+        if (cur_skip < nskip && i == skip[cur_skip]) {
+            cur_skip++;
+            continue;
+        }
         close(i);
     }
 }
-- 
2.45.2


