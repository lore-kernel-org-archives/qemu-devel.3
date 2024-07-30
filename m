Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68902C3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 14:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYm4C-0003DI-RW; Tue, 30 Jul 2024 08:35:04 -0400
Received: from eggs.gnu.org ([209.51.188.92])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sYm3t-0003Aw-Tj
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 08:34:45 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sYm3A-00064g-JA
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 08:34:26 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42111cf2706so3809085e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 05:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722342754; x=1722947554;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=amdT7GOZcFRjKcSgOsJ0Xtj6iZAzzmW4Z/k0DIOKYcY=;
 b=zMakEwmiKJhTszO3eHZ36CJRieWV+oRFbQkGuCMxK4hp2y4JwwSX1MQ/2DwxO1nZcU
 4bPF8TnDDCEGOSlMgOdgyG2ATFjHLjRQ790yjOgUwdazbx3x83v0vAec2MgFrJEGswav
 G7WCSLoos4B1N2yVwOYqWifhw6LSUslJ6wgAS164nC8tqR8hlBqNRjg+aymqdzri6mvG
 rz596q7o/02ORzCykp9qjTNO0npoQ+ktRKRdHUuyXQUO1Py5gD6fKSasEv29d59Ezb+l
 3yJ1WN41hf8Fvr4n1yTDm5S+V6obD2uSTk5CZKH1KXPZX/gThly4TDxWTdKpfuIRBj6c
 Np8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722342754; x=1722947554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=amdT7GOZcFRjKcSgOsJ0Xtj6iZAzzmW4Z/k0DIOKYcY=;
 b=YHezpQ2G52SzO3vwXDMcP/Ot9OAGfgeJLwvjZX9sPjP6sKi5N7tTcWrxpC0H0Z1TLU
 BV/p1uQufZpff03n0JPM1z4jOPAAJBGNGS6XdEn0uOFs0j1pQXAMQeCPUYaSvd9U95AY
 +ud1gL9dKRZRa58PZvQpvqA/ZcroCxTLOU0wMou8xsE6ws4ZJ7iSde6S2a5ZlKOkBjK0
 z9XdrO2cW/7JVmfhyFu+s9Qxxl7Fc/g9M8vzLSZtdKpFKC/pHs/rC91PDdAoGVKfUl5L
 3erjrHK1AVSV0aYaHS+3J9DJ/wH7MagrTa3Om18I4zVdxSnEZzSuTlqiVo0aXSAa08JX
 s3Eg==
X-Gm-Message-State: AOJu0YwoiCua62HVMKgaAqArD8iufn4s6u0cmcELdPazTYjTzACLClgw
 +twoNCMKSFCXKxKjYERrYxHnOJQ2t6PNceN5M3dlOCdvBZF73keDvneTmZJUQ14pOHIXclg3IHR
 zh9w=
X-Google-Smtp-Source: AGHT+IFgZ57BfhHq/TcQvyfrAkOd7Tb/Imc1aMga0VFlSD5Ch20cr4WVOCdCLeGDAMM5dOUm1OieBA==
X-Received: by 2002:a5d:64a3:0:b0:367:4d9d:56a6 with SMTP id
 ffacd0b85a97d-36b34be17d5mr6845131f8f.1.1722342283446; 
 Tue, 30 Jul 2024 05:24:43 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36862549sm14577757f8f.106.2024.07.30.05.24.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 05:24:42 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 2/5] qemu/osdep: Split qemu_close_all_open_fd() and add
 fallback
Date: Tue, 30 Jul 2024 14:24:25 +0200
Message-ID: <20240730122437.1749603-3-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730122437.1749603-1-cleger@rivosinc.com>
References: <20240730122437.1749603-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, T_SPF_HELO_TEMPERROR=0.01,
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

In order to make it cleaner, split qemu_close_all_open_fd() logic into
multiple subfunctions (close with close_range(), with /proc/self/fd and
fallback).

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 util/oslib-posix.c | 51 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 1e867efa47..a6749d9f9b 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -808,27 +808,16 @@ int qemu_msync(void *addr, size_t length, int fd)
     return msync(addr, length, MS_SYNC);
 }
 
-/*
- * Close all open file descriptors.
- */
-void qemu_close_all_open_fd(void)
+static bool qemu_close_all_open_fd_proc(void)
 {
     struct dirent *de;
     int fd, dfd;
     DIR *dir;
 
-#ifdef CONFIG_CLOSE_RANGE
-    int r = close_range(0, ~0U, 0);
-    if (!r) {
-        /* Success, no need to try other ways. */
-        return;
-    }
-#endif
-
     dir = opendir("/proc/self/fd");
     if (!dir) {
         /* If /proc is not mounted, there is nothing that can be done. */
-        return;
+        return false;
     }
     /* Avoid closing the directory. */
     dfd = dirfd(dir);
@@ -840,4 +829,40 @@ void qemu_close_all_open_fd(void)
         }
     }
     closedir(dir);
+
+    return true;
+}
+
+static bool qemu_close_all_open_fd_close_range(void)
+{
+#ifdef CONFIG_CLOSE_RANGE
+    int r = close_range(0, ~0U, 0);
+    if (!r) {
+        /* Success, no need to try other ways. */
+        return true;
+    }
+#endif
+    return false;
+}
+
+/*
+ * Close all open file descriptors.
+ */
+void qemu_close_all_open_fd(void)
+{
+    int open_max = sysconf(_SC_OPEN_MAX);
+    int i;
+
+    if (qemu_close_all_open_fd_close_range()) {
+        return;
+    }
+
+    if (qemu_close_all_open_fd_proc()) {
+        return;
+    }
+
+    /* Fallback */
+    for (i = 0; i < open_max; i++) {
+        close(i);
+    }
 }
-- 
2.45.2


