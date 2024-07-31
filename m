Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF49EC3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 08:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ50l-0002NJ-PD; Wed, 31 Jul 2024 04:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sZ50k-0002HB-4G
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 04:48:42 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sZ50i-0004bc-GT
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 04:48:41 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ef247e8479so4374941fa.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 01:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722415718; x=1723020518;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q1X8hnMqcOSbqxXp33EZy6XsP0jjL/S5AUJi2hLZhJM=;
 b=0Mkp99U7+rQlECcE5tWZzBFSYz4fC/p/1nDuT/3Udn9n5inzkcWMag/naUtcvL1tLF
 Xn7M1+NlMXz5P0baKEIsI9WoOSSDOeogRt4jXdVe7cEiDWlPfo8JoXZ655aGzLzbYjyQ
 NC9NI8Oo36mvT6QHTZwmnMsmanQrWTM93XVEpUVJz+6L43axrxcAIEQPr+5Fuiak2ryy
 TwRqdwT/awa3H5CzJPsYvY+CURAjsmv7wUq23BXW9Y83kw22d2CtjphiZBbZu3T04Xuj
 PwJ4c1ezYZZd7qEyzVfC/yWbO/XOvIABG9qG1PU1I+RzLioDGypN6NIE3hHBSiRyZ/02
 ybWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722415718; x=1723020518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q1X8hnMqcOSbqxXp33EZy6XsP0jjL/S5AUJi2hLZhJM=;
 b=Rn6SMRPfCC0YbaGH8hQmweutZckiZn+QEa85QArJ4M/Ge0EbKo00jQgeDJapNKCg/r
 JHnMnHs99v8EWmpYqN0Yj4jFbcwAjrbNdqYd7h2zOh7PjMLxOvXK79xQrAYxMnRYNtyd
 5a3avsb0Vhr9+ROLuPJRyFmdUbdLP/BSPXgcryL1+O+yIHGfhuoAPcFAQagcDZWN++Bk
 MzkLKh7d0Ehuo/8E9E4p8xN7UQdlj026jxvjWP8A6HNyO8aMDHb4eAMK3qk/9J9EbUCr
 pvp0bsh6PRugJDNY6/d5dNwb/q9E+3nVEozlffWgA67H+LaPtQeYstYw+hBAE5BKZnUQ
 wOSg==
X-Gm-Message-State: AOJu0YwUanMPvPzeVYRfbF2jfQtJSGAfld3QmpTuqIgc/B7tQQf4IANa
 KbB+jhlNEEDUJYY+wsCd4LJnZIJuXkYBg4hGMOOsrasMWlyWY/IdAv1SI/kseFMMQLZvyg/GYv1
 0HQY=
X-Google-Smtp-Source: AGHT+IG5nyMLmjCWaiZJ8S93k+dKlfDj8Q9PSr8k5q5kE1juGXV4nNCSvtwDojdxoPbHs+rBqW7YtQ==
X-Received: by 2002:a05:651c:155:b0:2ef:2346:9135 with SMTP id
 38308e7fff4ca-2f03c8000e0mr67104591fa.9.1722415717439; 
 Wed, 31 Jul 2024 01:48:37 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367c0344sm16576425f8f.2.2024.07.31.01.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 01:48:36 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 2/5] qemu/osdep: Split qemu_close_all_open_fd() and add
 fallback
Date: Wed, 31 Jul 2024 10:48:26 +0200
Message-ID: <20240731084832.1829291-3-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731084832.1829291-1-cleger@rivosinc.com>
References: <20240731084832.1829291-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=cleger@rivosinc.com; helo=mail-lj1-x232.google.com
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

In order to make it cleaner, split qemu_close_all_open_fd() logic into
multiple subfunctions (close with close_range(), with /proc/self/fd and
fallback).

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 util/oslib-posix.c | 50 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 1e867efa47..9b79fc7cff 100644
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
@@ -840,4 +829,39 @@ void qemu_close_all_open_fd(void)
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
+static void qemu_close_all_open_fd_fallback(void)
+{
+    int open_max = sysconf(_SC_OPEN_MAX), i;
+
+    /* Fallback */
+    for (i = 0; i < open_max; i++) {
+        close(i);
+    }
+}
+
+/*
+ * Close all open file descriptors.
+ */
+void qemu_close_all_open_fd(void)
+{
+    if (!qemu_close_all_open_fd_close_range() &&
+        !qemu_close_all_open_fd_proc()) {
+        qemu_close_all_open_fd_fallback();
+    }
 }
-- 
2.45.2


