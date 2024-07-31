Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 390FBC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 08:50:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ50k-0002IA-Es; Wed, 31 Jul 2024 04:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sZ50i-0002G0-Or
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 04:48:40 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sZ50g-0004bP-Bc
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 04:48:40 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3684e2d0d8bso394727f8f.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 01:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722415716; x=1723020516;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yvb2fdITY/6760paQNKw8FXGBghCfFjytCSj+DZtnsM=;
 b=iE7aVlQ84NehZb7rHKOmoiDkjP/0cOQVXLkxXjoDoCK+OL08yqdNjyAkngLmL5HZyv
 xHsCvWDn5bLH/6WE9c2R11suNLpueJG2X6vruNAjclum3gYt+2IwGqoCgtnQYnYVDKHy
 NaWliq6PbesAWiU/iUQL+CZ/fmk3W0cHBRjXc5fg/KWR5CtOhhLDee0G/F3E1k6zNFvz
 1Bpnc2bSQRFw/Cwil84TB2/htfnz4P6ByCSyK0OdbNxahtiITfI+aPb9WDp/WHFz7fHU
 jxdIE/lKAnVw1eeVBb96w3c3uxnJDl8cj8aESHbJI0+NnfrMxYlKQz5XKwRwtzpy9Ply
 ni5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722415716; x=1723020516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yvb2fdITY/6760paQNKw8FXGBghCfFjytCSj+DZtnsM=;
 b=XXhcqZ83xv+Vz/aRhTgyOogCTiPtDMR4169IFR7h2qD7OWteelf+lyiL0iH8WzNOdy
 N364M/Pq6ZbjtmlF4leU1uqcarSXllz9kxEUaW8iTS38RMASS9dht8hVnSj2FVgx7Ojl
 905v74QtiJ4OJWFX060iFkzL1Onhg576s0HBPrp+SkjxJKGqXjfHTFUKlY7m14kWAly2
 AtlrHGxUP9c6GoSvcI+hDTnEiPSHiYnonH23yM9ewBA/gBKkzMMSIC+NcewSllJf12z4
 3IA9e7fvtUcyuc5cXIC+ggfn3dnpLw8WDKvUztk+043U8qLS96eRnQyTeEWKUzjkWVSO
 +VVA==
X-Gm-Message-State: AOJu0Ywd01ZA/C5TeQ5NHb/Y7uj9r5CCdU9jGeKqT5kLXuPWZhf/2IFi
 Y5oHea/Elu9e8QzWrbYPomdb37vBMGWFVy8jwAjnFNjQQ0GhgohuWx2rwFjaAaIJ0hNkchJSvGY
 2Shw=
X-Google-Smtp-Source: AGHT+IFwudU6SBz46pqVnn7AwdgBaZTsttrMAOHpfnJeyP/NPz5OqpmrO99kqxXzQVCPgDCdg4vjwA==
X-Received: by 2002:a05:600c:138c:b0:424:8b08:26aa with SMTP id
 5b1f17b1804b1-428054f24c7mr84073275e9.3.1722415716060; 
 Wed, 31 Jul 2024 01:48:36 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367c0344sm16576425f8f.2.2024.07.31.01.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 01:48:35 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 1/5] qemu/osdep: Move close_all_open_fds() to oslib-posix
Date: Wed, 31 Jul 2024 10:48:25 +0200
Message-ID: <20240731084832.1829291-2-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731084832.1829291-1-cleger@rivosinc.com>
References: <20240731084832.1829291-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x42f.google.com
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


