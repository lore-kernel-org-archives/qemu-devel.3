Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F85C52D70
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 14:55:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZtg8-00036Z-0M; Fri, 02 Aug 2024 10:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sZtg6-0002sn-2I
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 10:54:46 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sZtg4-0005EH-8u
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 10:54:45 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1fc5bc8d23cso4680145ad.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 07:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722610482; x=1723215282;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RbiqW0FBf0s4d09Z/i1Ew4rMVuSfOI51ePlXd/j06TE=;
 b=16ls7nVEFT3GqF3zQC/POivHH3K4kYwITUfq4r5LjswEWYDUPsaRT4aWp7iAwTJTVD
 FhVON1jkQLQTKP7lVzHth8q5L9uYbZApckvuHXZP+EpR+hUrnf6ybm338ZWQXvAcopQt
 kBFKnIuAIuQCbNNjed2deMx8x1g52ZWl4rERy5uNCS0OGZUtZG8xegnkkhcXCHYs4SAk
 zLQ5UK6owqSyWFG2pMFe+41yerULBxx6I2dHQzdKWSGgcZ+JoLqCJfHdFH8HSOnsaJc/
 SF0mvJtdEEd1Q2Ss1TyOU4yB/e7v7FV2EEkAY9JK6xojHUO7UI3kVV4nEH3kbF0BPMga
 G4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722610482; x=1723215282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RbiqW0FBf0s4d09Z/i1Ew4rMVuSfOI51ePlXd/j06TE=;
 b=HbgJ5an7XulZ+WqSDPyBPDgjvyDRXN+tecFHNds4CrKVUvHEay71LjfqJXzvXRZ/gP
 G0w851RaxGPZNGzKmp7kKl9XgYoxyNiKAmXR9ft9t8m1YKEdmXawCIM86YMXWm8QVpqq
 9+rU7FRSSsBuEz6nvr/feewBMSNeXSAHNWwGUlUcUiRf7evGH6up71rTERXN63Pyh9rB
 BEROmMF67RtGgtUJjdKt0lBnLceSCz8T+CXUDqfcn4n2U/OeuWvgBxCJ0VwD+9ydJm6v
 RfAM/wlRe/H6nPVbAvrc24KyIs7EuIG437JSL2cFt3Sif6dmBSbMNj4NOiz4twUQm20B
 cOfQ==
X-Gm-Message-State: AOJu0YwfN2mu7cWAZi2LXc2xoiJ59+VxPP/iM+PDW5mUjbOUOZZyw1LT
 rSYqOax0v+sfeHEoFKjh0xPzVdasOR9HDpL7OqmUV89XR9vKG9p9nuqFfgWH8Is2ILj/nJWlC16
 scgA=
X-Google-Smtp-Source: AGHT+IG3AXqGPRklcFjv4Zj4ZHxg2d7d4ZvupJgR/ISntF5u5kG/89iUoRmum4VrkD6MBWAnbc6NDg==
X-Received: by 2002:a17:902:f54b:b0:1fb:a38b:c5b6 with SMTP id
 d9443c01a7336-1ff57250140mr28789535ad.1.1722610481653; 
 Fri, 02 Aug 2024 07:54:41 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff592aee19sm17920635ad.282.2024.08.02.07.54.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 07:54:41 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v8 1/5] qemu/osdep: Move close_all_open_fds() to oslib-posix
Date: Fri,  2 Aug 2024 16:54:17 +0200
Message-ID: <20240802145423.3232974-2-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802145423.3232974-1-cleger@rivosinc.com>
References: <20240802145423.3232974-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=cleger@rivosinc.com; helo=mail-pl1-x62c.google.com
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

Move close_all_open_fds() in oslib-posix, rename it
qemu_close_all_open_fds() and export it.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/osdep.h    |  7 +++++++
 system/async-teardown.c | 37 +------------------------------------
 util/oslib-posix.c      | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 36 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 720ed21a7e..de77c5c254 100644
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


