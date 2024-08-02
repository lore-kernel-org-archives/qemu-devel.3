Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D659C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 14:55:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZtgC-0003Nd-8Q; Fri, 02 Aug 2024 10:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sZtgA-0003Hi-NL
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 10:54:50 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sZtg9-0005FE-2d
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 10:54:50 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-78556f71c10so540502a12.0
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 07:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722610487; x=1723215287;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X+7HflQUF1blNin5hk/K36A77NZBIc7HR6vMaeAuKWw=;
 b=1AWUjK8UBd6Hg220NN25PYkvQzTxwymTIA7LBzMy91mqQ7TpvTb4QqQPODvWQ1RM6m
 6TxrdFvWUbytXYtYp97PvFAohEPsE0LINyGeGA0MQy6uHpAhncbQzOZcsl4Yx8stritB
 NFFeZ3kWBGFBiPIQAjHDykRRnhEeZkdtpHPktqinZHudHKh8AKDBo6V3DTz+npDJ/uhy
 tcPdpeOu1luZkc/vme84cm9OvHnx5af8JPwmPPY6CQYi/Ec/scQ+8gJ/aZ3lphpqUXA0
 tlzWbBSZgD0XVRLhVNDF7zDsJ37fEsXlYhlDkXS732lpPXnD0VusfHssiGj+r/0wXRae
 IYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722610487; x=1723215287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X+7HflQUF1blNin5hk/K36A77NZBIc7HR6vMaeAuKWw=;
 b=b56/veYmJWCiJ68Qiuik2UGRJMvV7KsAjSXZA5otuknR7RAzZMyf5tT+YvWieVMjDJ
 C+Vhptp9ZBec3qK3cxTj9SCqz6F6BsboP5eT5ujhO+ObwMeoosdeT5JmsWEt3BCUFggY
 0MVaPoT6OvxFsxdBY9zeRpAcwB0xyk7BuiEZ0U5nVssOcKEXZu8VO1kSkRVbre++XRyh
 aqym7LSr60o3+GmX4gZGbW2yk3gd4daj/QEx6Y7uKuwX7ompPD2r6UJlCB/ijAgngm8y
 Gq3WPqVB6K5YBK1HTsQlrkixlLijdymDS7uAYE8HrdqEoG1+JC3XWaHoF0MWlhLTXNGA
 IPZQ==
X-Gm-Message-State: AOJu0YwR5qoEe9CIXInZAoep7TfDYryC6MCYAIc+xHHIS69KRjq0Lj/0
 6hxfik0EdNZJ6BWX/XAo4pnZlC7e37i41fLG2qlv4B97ibdj0YQODuuQ3bvN8it8nGFH6a7WdD1
 XGWI=
X-Google-Smtp-Source: AGHT+IFUPQP1Y79Xu6jMeqfnMY3TX/XR+yQt6PoUqx01RM7rx2kqNKFBomG0P4iK6rHWabm+9FiLfg==
X-Received: by 2002:a17:902:ecc6:b0:1fc:52f4:d7c8 with SMTP id
 d9443c01a7336-1ff574e2c4dmr25525685ad.10.1722610487105; 
 Fri, 02 Aug 2024 07:54:47 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff592aee19sm17920635ad.282.2024.08.02.07.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 07:54:46 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v8 2/5] qemu/osdep: Split qemu_close_all_open_fd() and add
 fallback
Date: Fri,  2 Aug 2024 16:54:18 +0200
Message-ID: <20240802145423.3232974-3-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802145423.3232974-1-cleger@rivosinc.com>
References: <20240802145423.3232974-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=cleger@rivosinc.com; helo=mail-pg1-x529.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


