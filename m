Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C81C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 14:41:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTjLz-0008Th-NI; Tue, 16 Jul 2024 10:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sTjLx-0008SR-VK
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:40:30 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sTjLu-0002Vh-9x
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:40:29 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1faf7700399so1627735ad.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 07:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721140822; x=1721745622;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OZofPCQ+lyFeGC/tiAwtLXwt0GFczmNX6hbCW61efdI=;
 b=1ub/je84UVXUmPQgTlBQ8bY8TNBn5NIgdDISHXLWP2+Ud+X50xMVcUbjHjoJAQN0oS
 e+7d6mrAgdvYCSkM0Zg54ommS1FpjMjBNtdSo8zggAeE9+/djgk71XpZaD0EHZQ3Dcy/
 Fy9QPcF9qHGFle5oEvLaKy8/NzuNY7VJJn5Dj6hjkN3GAiRtT8Cu6ESR0zNvgfNfNSR+
 /ngis7O1ZMhcYH+Bs/L9F0r6RXNG1U9BTfoxq17NMJ7aaOY+d/xBbjRFtWH0KBbtl8mC
 o+GLPSvLOiojETcotSdvsYdhhkk5Xh2BG8JmbpRD/0ArgkHSiC2E+A4K3zpdmGIW81oj
 9T8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721140822; x=1721745622;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OZofPCQ+lyFeGC/tiAwtLXwt0GFczmNX6hbCW61efdI=;
 b=Jt1MapvQQxKQaMPVs8rrAT2LTXQNLNl/zJbDXL+cogzsQwAmr0vALvZGg5Zb/xn80j
 V4MAonQQMkLbDBczWurh0mw4JuhqRk/gDQI1+S1UiUY8Uxj8gWD0w1npJ0z7ox/3Y6iJ
 EMMFf9jg6ggwteJbPqrutbiqWZ4DsweGUq9qN06HL4cq3OVHV3mkm9n6Nk6n7fnbPPyx
 V90qOXDBwmt7IjVHFj1JVT/sufUrpyt5rRi1S236E1WYxakoMOjonkLb180N2vMIcz0I
 aVSTGaneniZxCJEPRwT2gm9c3sJOqvDrWPp2aPPMVFVh1NgZZyMNIvrmRD4ob/vcecs7
 BkOw==
X-Gm-Message-State: AOJu0Yx6Gt3Y3vFe4Ya5VoU0ahSqnoVxOwbEg3v26ipwNhzOf1nhwwfv
 rKd1I8SMOXHtiAgaZsy+Qg4GWcRoRbLWrtJqbCjKrjafcFeaYHObCpZ7yhlTF9l/eZy+i0npFb6
 e5EI=
X-Google-Smtp-Source: AGHT+IFBU/H6otYezZ5IuP8o3z5AdrVLNd/vRE2tBsmXn8RGIgzzLEZRztoWH90BpPkbGsE3Lo8j3w==
X-Received: by 2002:a17:902:d2d2:b0:1f9:b19b:4255 with SMTP id
 d9443c01a7336-1fc3ba9b9d4mr23174295ad.4.1721140822116; 
 Tue, 16 Jul 2024 07:40:22 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc0bbbf7a7sm59230095ad.95.2024.07.16.07.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 07:40:21 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3] osdep: add a qemu_close_all_open_fd() helper
Date: Tue, 16 Jul 2024 16:39:59 +0200
Message-ID: <20240716144006.6571-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=cleger@rivosinc.com; helo=mail-pl1-x62d.google.com
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

Since commit 03e471c41d8b ("qemu_init: increase NOFILE soft limit on
POSIX"), the maximum number of file descriptors that can be opened are
raised to nofile.rlim_max. On recent debian distro, this yield a maximum
of 1073741816 file descriptors. Now, when forking to start
qemu-bridge-helper, this actually calls close() on the full possible file
descriptor range (more precisely [3 - sysconf(_SC_OPEN_MAX)]) which
takes a considerable amount of time. In order to reduce that time,
factorize existing code to close all open files descriptors in a new
qemu_close_all_open_fd() function. This function uses various methods
to close all the open file descriptors ranging from the most efficient
one to the least one. It also accepts an ordered array of file
descriptors that should not be closed since this is required by the
callers that calls it after forking.

Signed-off-by: Clément Léger <cleger@rivosinc.com>

----

v3:
 - Use STD*_FILENO defines instead of raw values
 - Fix indentation of close_all_fds_after_fork()
 - Check for nksip in fallback code
 - Check for path starting with a '.' in qemu_close_all_open_fd_proc()
 - Use unsigned for cur_skip
 - Move ifdefs inside close_fds functions rather than redefining them
 - Remove uneeded 'if(nskip)' test
 - Add comments to close_range version
 - Reduce range of skip fd as we find them in
 - v2: https://lore.kernel.org/qemu-devel/20240618111704.63092-1-cleger@rivosinc.com/

v2:
 - Factorize async_teardown.c close_fds implementation as well as tap.c ones
 - Apply checkpatch
 - v1: https://lore.kernel.org/qemu-devel/20240617162520.4045016-1-cleger@rivosinc.com/

---
 include/qemu/osdep.h    |   8 +++
 net/tap.c               |  33 +++++-----
 system/async-teardown.c |  37 +-----------
 util/osdep.c            | 129 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 157 insertions(+), 50 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 191916f38e..43a035d756 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -757,6 +757,14 @@ static inline void qemu_reset_optind(void)
 
 int qemu_fdatasync(int fd);
 
+/**
+ * Close all open file descriptors except the ones supplied in the @skip array
+ *
+ * @skip: ordered array of distinct file descriptors that should not be closed
+ * @nskip: number of entries in the @skip array.
+ */
+void qemu_close_all_open_fd(const int *skip, unsigned int nskip);
+
 /**
  * Sync changes made to the memory mapped file back to the backing
  * storage. For POSIX compliant systems this will fallback
diff --git a/net/tap.c b/net/tap.c
index 51f7aec39d..45cb963142 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -385,6 +385,23 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
     return s;
 }
 
+static void close_all_fds_after_fork(int excluded_fd)
+{
+    const int skip_fd[] = {STDIN_FILENO, STDOUT_FILENO, STDERR_FILENO,
+                           excluded_fd};
+    unsigned int nskip = ARRAY_SIZE(skip_fd);
+
+    /*
+     * skip_fd must be an ordered array of distinct fds, exclude
+     * excluded_fd if already included in the [STDIN_FILENO - STDERR_FILENO]
+     * range
+     */
+    if (excluded_fd <= STDERR_FILENO) {
+        nskip--;
+    }
+    qemu_close_all_open_fd(skip_fd, nskip);
+}
+
 static void launch_script(const char *setup_script, const char *ifname,
                           int fd, Error **errp)
 {
@@ -400,13 +417,7 @@ static void launch_script(const char *setup_script, const char *ifname,
         return;
     }
     if (pid == 0) {
-        int open_max = sysconf(_SC_OPEN_MAX), i;
-
-        for (i = 3; i < open_max; i++) {
-            if (i != fd) {
-                close(i);
-            }
-        }
+        close_all_fds_after_fork(fd);
         parg = args;
         *parg++ = (char *)setup_script;
         *parg++ = (char *)ifname;
@@ -490,17 +501,11 @@ static int net_bridge_run_helper(const char *helper, const char *bridge,
         return -1;
     }
     if (pid == 0) {
-        int open_max = sysconf(_SC_OPEN_MAX), i;
         char *fd_buf = NULL;
         char *br_buf = NULL;
         char *helper_cmd = NULL;
 
-        for (i = 3; i < open_max; i++) {
-            if (i != sv[1]) {
-                close(i);
-            }
-        }
-
+        close_all_fds_after_fork(sv[1]);
         fd_buf = g_strdup_printf("%s%d", "--fd=", sv[1]);
 
         if (strrchr(helper, ' ') || strrchr(helper, '\t')) {
diff --git a/system/async-teardown.c b/system/async-teardown.c
index 396963c091..9148ee8d04 100644
--- a/system/async-teardown.c
+++ b/system/async-teardown.c
@@ -26,40 +26,6 @@
 
 static pid_t the_ppid;
 
-/*
- * Close all open file descriptors.
- */
-static void close_all_open_fd(void)
-{
-    struct dirent *de;
-    int fd, dfd;
-    DIR *dir;
-
-#ifdef CONFIG_CLOSE_RANGE
-    int r = close_range(0, ~0U, 0);
-    if (!r) {
-        /* Success, no need to try other ways. */
-        return;
-    }
-#endif
-
-    dir = opendir("/proc/self/fd");
-    if (!dir) {
-        /* If /proc is not mounted, there is nothing that can be done. */
-        return;
-    }
-    /* Avoid closing the directory. */
-    dfd = dirfd(dir);
-
-    for (de = readdir(dir); de; de = readdir(dir)) {
-        fd = atoi(de->d_name);
-        if (fd != dfd) {
-            close(fd);
-        }
-    }
-    closedir(dir);
-}
-
 static void hup_handler(int signal)
 {
     /* Check every second if this process has been reparented. */
@@ -85,9 +51,8 @@ static int async_teardown_fn(void *arg)
     /*
      * Close all file descriptors that might have been inherited from the
      * main qemu process when doing clone, needed to make libvirt happy.
-     * Not using close_range for increased compatibility with older kernels.
      */
-    close_all_open_fd();
+    qemu_close_all_open_fd(NULL, 0);
 
     /* Set up a handler for SIGHUP and unblock SIGHUP. */
     sigaction(SIGHUP, &sa, NULL);
diff --git a/util/osdep.c b/util/osdep.c
index 770369831b..eb57a61d08 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -613,3 +613,132 @@ int qemu_fdatasync(int fd)
     return fsync(fd);
 #endif
 }
+
+static bool qemu_close_all_open_fd_proc(const int *skip, unsigned int nskip)
+{
+#ifdef CONFIG_LINUX
+    struct dirent *de;
+    int fd, dfd;
+    bool close_fd;
+    DIR *dir;
+    unsigned int i, skip_start = 0, skip_end = nskip;
+
+    dir = opendir("/proc/self/fd");
+    if (!dir) {
+        /* If /proc is not mounted, there is nothing that can be done. */
+        return false;
+    }
+    /* Avoid closing the directory. */
+    dfd = dirfd(dir);
+
+    for (de = readdir(dir); de; de = readdir(dir)) {
+        if (de->d_name[0] == '.') {
+            continue;
+        }
+        fd = atoi(de->d_name);
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
+                    if (i == skip_start)
+                        skip_start++;
+                    else if (i == skip_end)
+                        skip_end--;
+                    break;
+                }
+            }
+        }
+        if (close_fd) {
+            close(fd);
+        }
+    }
+    closedir(dir);
+
+    return true;
+#else
+    return false;
+#endif
+}
+
+
+static bool qemu_close_all_open_fd_close_range(const int *skip,
+                                               unsigned int nskip)
+{
+#ifdef CONFIG_CLOSE_RANGE
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
+    return false;
+#endif
+}
+
+void qemu_close_all_open_fd(const int *skip, unsigned int nskip)
+{
+    int open_max = sysconf(_SC_OPEN_MAX);
+    unsigned int cur_skip = 0;
+    int i;
+
+    if (qemu_close_all_open_fd_close_range(skip, nskip)) {
+        return;
+    }
+
+    if (qemu_close_all_open_fd_proc(skip, nskip)) {
+        return;
+    }
+
+    /* Fallback */
+    for (i = 0; i < open_max; i++) {
+        if (cur_skip < nskip && i == skip[cur_skip]) {
+            cur_skip++;
+            continue;
+        }
+        close(i);
+    }
+}
-- 
2.45.2


