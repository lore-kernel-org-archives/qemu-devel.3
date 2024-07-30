Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E924C3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 14:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYm4e-0003Pq-L2; Tue, 30 Jul 2024 08:35:35 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sYm4J-0003EL-Hx
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 08:35:08 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sYm3c-00069m-Iy
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 08:34:54 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52f00427236so836847e87.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 05:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722342783; x=1722947583;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zBkVCmIiTiPE9vfd/7IXrJK8wgsdsb9XrAkbKfnUBLU=;
 b=PMNeYh53VtwnIsw6OAZqd52pwe1JNszCkhDPmaE+ATYUoJhzYQj/roa2UNaB1ycszs
 iTBMNA+cOUtOJ1QaQok2qss8gceKdfIIT5TPVZ2x/mdYQd//tstguP13X0XqdnXGSRnI
 Hy2lAqKHAQXL09E7ddP3nUwP7jGUh0aXABQ0Fd2L3SxidlTbabJvfCg0zwtjxiKq8QmE
 AHOF2Mb0XZ72Zgiys2MG2rA0lOMOeHDeWLKran9FNJDQDaR2JM6TStuY6yeeqC93jYbQ
 kHhYtV8fSGHu9+IVbERJUsQQBobPNLDIr4nRkJX5dcLZKLgCNM7G7m42HQ6AXEAN12uH
 7kAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722342783; x=1722947583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zBkVCmIiTiPE9vfd/7IXrJK8wgsdsb9XrAkbKfnUBLU=;
 b=ZQtxAMxgjh77uwWLc7uo24nJ29atSpYv8+MyoV7w5b1EgCv1KG8VIyC4LeE+ZzqhfJ
 HNpvDWYX4q7DVvN8OEum+1V8su+Am8k2SHRlFaXY/ur2NN7g9Zkar+KPiebxNT/D9RhR
 TFCUbQLsx9tbjKWbMDMwQGCWzMbIHJdXZhCXcJtSB1n9/I3BItUr7rxL8H1j/qd08rtB
 zW3S6w0d6cv1TxaiYw1nNXd1cZ0sBEk3TKlfKXmb906p6ukvMKluu723tENYNXwU3B05
 GiQUKUlJP7YbdOX4PBgDK2N/8D0j5T0PDzU0X5ppWwMcImLkC9F7afCDSJ+i3gya/9q9
 aAvw==
X-Gm-Message-State: AOJu0Yzrg6kUf39swlCWCePey0RLPDSJxMNuEKcGXDUOeiWCilL98RE+
 UP7TVEQ6RGX0l3OHhqJpvY0HXdG/+E/W2HYb9ZPdg9kJ1gx1h66QXvZpsLFnRU93gHbAYY463PI
 WmQQ=
X-Google-Smtp-Source: AGHT+IEniLmR/90yo57Z+so4cK1Xdbg2SW1Oh703uTXr1CvLJDhpsOaUUE/EmU3y1EXMH3giVIquyQ==
X-Received: by 2002:a05:6000:400f:b0:365:da7f:6c17 with SMTP id
 ffacd0b85a97d-36b34e592d6mr7731008f8f.7.1722342282500; 
 Tue, 30 Jul 2024 05:24:42 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36862549sm14577757f8f.106.2024.07.30.05.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 05:24:41 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 1/5] qemu/osdep: Move close_all_open_fds() to oslib-posix
Date: Tue, 30 Jul 2024 14:24:24 +0200
Message-ID: <20240730122437.1749603-2-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730122437.1749603-1-cleger@rivosinc.com>
References: <20240730122437.1749603-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=cleger@rivosinc.com; helo=mail-lf1-x132.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Move close_all_open_fds() in oslib-posix, rename it
qemu_close_all_open_fds() and export it.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 include/qemu/osdep.h    |  7 +++++++
 system/async-teardown.c | 37 +------------------------------------
 util/oslib-posix.c      | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 36 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 191916f38e..5cd8517380 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -757,6 +757,13 @@ static inline void qemu_reset_optind(void)
 
 int qemu_fdatasync(int fd);
 
+/**
+ * qemu_close_all_open_fd:
+ *
+ * Close all open file descriptors
+ */
+void qemu_close_all_open_fd(void);
+
 /**
  * Sync changes made to the memory mapped file back to the backing
  * storage. For POSIX compliant systems this will fallback
diff --git a/system/async-teardown.c b/system/async-teardown.c
index 396963c091..edf49e1007 100644
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
+    qemu_close_all_open_fd();
 
     /* Set up a handler for SIGHUP and unblock SIGHUP. */
     sigaction(SIGHUP, &sa, NULL);
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index b090fe0eed..1e867efa47 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -807,3 +807,37 @@ int qemu_msync(void *addr, size_t length, int fd)
 
     return msync(addr, length, MS_SYNC);
 }
+
+/*
+ * Close all open file descriptors.
+ */
+void qemu_close_all_open_fd(void)
+{
+    struct dirent *de;
+    int fd, dfd;
+    DIR *dir;
+
+#ifdef CONFIG_CLOSE_RANGE
+    int r = close_range(0, ~0U, 0);
+    if (!r) {
+        /* Success, no need to try other ways. */
+        return;
+    }
+#endif
+
+    dir = opendir("/proc/self/fd");
+    if (!dir) {
+        /* If /proc is not mounted, there is nothing that can be done. */
+        return;
+    }
+    /* Avoid closing the directory. */
+    dfd = dirfd(dir);
+
+    for (de = readdir(dir); de; de = readdir(dir)) {
+        fd = atoi(de->d_name);
+        if (fd != dfd) {
+            close(fd);
+        }
+    }
+    closedir(dir);
+}
-- 
2.45.2


