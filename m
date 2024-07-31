Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78594C3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 08:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ50n-0002Vw-Mp; Wed, 31 Jul 2024 04:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sZ50l-0002Ng-O5
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 04:48:43 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sZ50j-0004c1-Oo
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 04:48:43 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4281e715904so2823505e9.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 01:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722415720; x=1723020520;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UZswZ/5MIFNXWQkpnF7EXAEm1eZvqChAOiAdHEAGgjA=;
 b=QVQT6SAmGMakOxVmj9JW3Kg69zF/kqRbgjgSDdIB9pZR8qSUbUjcvBdgmSWPAlqsxu
 NKSeOo+/ok9CRJFjLc8BlaCd2DjMNuwy5qbwF5YQXy400MitOnVMt4u0ASUc50ZO++rq
 RN0M2F6yre4gjRZCi9ZRWjkCftjNhJRxDoYMEzJ+oxYchICqr8EHWsBYJOQXl/wFYEUB
 J5dMOWatoD2WKzDWDX3g6IZH0zJYtSYXonjx+EtehaXHjxwMIizrrpVYhHUTAJp1z2qf
 wVqhKxIz8ghj3OaV+XcEx74SG2Xh3vBfBbGNOIk4XjO2q4jG5IDQ1a9+34xQ9uzGY423
 vDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722415720; x=1723020520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UZswZ/5MIFNXWQkpnF7EXAEm1eZvqChAOiAdHEAGgjA=;
 b=WyU+v+CNIZacmBuzicxkaPoc6FVg5dhDrDejsk1grJkV/LqGuY5lUVN31xsnqMjcnc
 ZMv0MjsKgqZdguw2H8NzhtbSP3tYIQ4b0u5Of8klTOMdoDaTvjQ+5wHH147S1U91dTHJ
 o4kKVL3eMlf6FzXqKHR+w2N5R3oS7Ga8SwY6ZS9xfZDYq5v/zOWgeEY96K+7aYZ7kDg2
 UTzc4chKGsoHPG0ElVcCkVj4Bb1PdBssvpZOi7hfCIj1M1Q+GvxoTCvjgrwgjw1GYAZy
 ZXQRIZ6RuA8F0iFXNbL1cKUx2rmlL3WfHTD+Dyv1sQmXZdmelnLbxdzcOMSqSSfvXZZD
 CqwA==
X-Gm-Message-State: AOJu0Yx0y34zrbmoNfI57DiyBRuu9Mmbz1JMeuUjU4TONkXmgGUiIk5X
 eJjYSBoWnTqXKUlQ/BQZrgADfi1AbFgR37pwOCN6YyiKqt2LVkNp12rmo2g7cpd/6Qv3C1jzGaq
 AytA=
X-Google-Smtp-Source: AGHT+IFrNa+Qcp+j0nYQbca6HofxQChaxNE4u33lZFNIqMyMdPu75bwou5Y1FquqlKshGujff9d/fw==
X-Received: by 2002:a05:6000:188e:b0:362:4aac:8697 with SMTP id
 ffacd0b85a97d-36b3497af4emr8144064f8f.0.1722415719751; 
 Wed, 31 Jul 2024 01:48:39 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367c0344sm16576425f8f.2.2024.07.31.01.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 01:48:38 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 4/5] qemu/osdep: Add excluded fd parameter to
 qemu_close_all_open_fd()
Date: Wed, 31 Jul 2024 10:48:28 +0200
Message-ID: <20240731084832.1829291-5-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731084832.1829291-1-cleger@rivosinc.com>
References: <20240731084832.1829291-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x333.google.com
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
 include/qemu/osdep.h    |   8 ++-
 system/async-teardown.c |   2 +-
 util/oslib-posix.c      | 107 ++++++++++++++++++++++++++++++++++------
 3 files changed, 98 insertions(+), 19 deletions(-)

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
index 9b79fc7cff..7583192192 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -808,11 +808,12 @@ int qemu_msync(void *addr, size_t length, int fd)
     return msync(addr, length, MS_SYNC);
 }
 
-static bool qemu_close_all_open_fd_proc(void)
+static bool qemu_close_all_open_fd_proc(const int *skip, unsigned int nskip)
 {
     struct dirent *de;
     int fd, dfd;
     DIR *dir;
+    unsigned int skip_start = 0, skip_end = nskip;
 
     dir = opendir("/proc/self/fd");
     if (!dir) {
@@ -823,8 +824,34 @@ static bool qemu_close_all_open_fd_proc(void)
     dfd = dirfd(dir);
 
     for (de = readdir(dir); de; de = readdir(dir)) {
+        bool close_fd = true;
+
+        if (de->d_name[0] == '.') {
+            continue;
+        }
         fd = atoi(de->d_name);
-        if (fd != dfd) {
+        if (fd == dfd) {
+            close_fd = false;
+            continue;
+        }
+
+        for (unsigned int i = skip_start; i < skip_end; i++) {
+            if (fd < skip[i]) {
+                /* We are below the next skipped fd, break */
+                break;
+            } else if (fd == skip[i]) {
+                close_fd = false;
+                /* Restrict the range as we found fds matching start/end */
+                if (i == skip_start) {
+                    skip_start++;
+                } else if (i == skip_end) {
+                    skip_end--;
+                }
+                break;
+            }
+        }
+
+        if (close_fd) {
             close(fd);
         }
     }
@@ -833,24 +860,68 @@ static bool qemu_close_all_open_fd_proc(void)
     return true;
 }
 
-static bool qemu_close_all_open_fd_close_range(void)
+static bool qemu_close_all_open_fd_close_range(const int *skip,
+                                               unsigned int nskip,
+                                               int open_max)
 {
 #ifdef CONFIG_CLOSE_RANGE
-    int r = close_range(0, ~0U, 0);
-    if (!r) {
-        /* Success, no need to try other ways. */
-        return true;
-    }
-#endif
+    int first = 0, last = open_max;
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
+        if (last > open_max) {
+            last = open_max;
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
+        last = open_max;
+    } while (cur_skip < nskip);
+
+    return true;
+#else
     return false;
+#endif
 }
 
-static void qemu_close_all_open_fd_fallback(void)
+static void qemu_close_all_open_fd_fallback(const int *skip, unsigned int nskip,
+                                            int open_max)
 {
-    int open_max = sysconf(_SC_OPEN_MAX), i;
+    unsigned int cur_skip = 0;
 
     /* Fallback */
-    for (i = 0; i < open_max; i++) {
+    for (int i = 0; i < open_max; i++) {
+        if (cur_skip < nskip && i == skip[cur_skip]) {
+            cur_skip++;
+            continue;
+        }
         close(i);
     }
 }
@@ -858,10 +929,14 @@ static void qemu_close_all_open_fd_fallback(void)
 /*
  * Close all open file descriptors.
  */
-void qemu_close_all_open_fd(void)
+void qemu_close_all_open_fd(const int *skip, unsigned int nskip)
 {
-    if (!qemu_close_all_open_fd_close_range() &&
-        !qemu_close_all_open_fd_proc()) {
-        qemu_close_all_open_fd_fallback();
+    int open_max = sysconf(_SC_OPEN_MAX) - 1;
+
+    assert(skip != NULL || nskip == 0);
+
+    if (!qemu_close_all_open_fd_close_range(skip, nskip, open_max) &&
+        !qemu_close_all_open_fd_proc(skip, nskip)) {
+        qemu_close_all_open_fd_fallback(skip, nskip, open_max);
     }
 }
-- 
2.45.2


