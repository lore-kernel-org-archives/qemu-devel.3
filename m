Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32184C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 16:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJFAe-0006G4-Bu; Mon, 17 Jun 2024 12:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sJFAd-0006Fm-6p
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 12:25:27 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sJFAb-0003Vv-7b
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 12:25:26 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-35904026d72so407334f8f.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 09:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718641523; x=1719246323;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pbHciCM9rdswrIx9LNF1/9GIczqDC/LiRaO8Y8qPpHY=;
 b=kbSHToYu/7h5oNIwhs/8etojdw/3N9mOGzBmZcxfyJ5U6A6HAzTRipQGn2efb9aFJz
 4YmMtwAsxOyz0RQA0SOflk7nnrqOA3kxw/Eiop9lFIGmpB/Of3qbnjyN1Tu+0TnZkG5R
 CyfosFgkEpfKSAzuaQn8CTk+oEHEbfzSS8iwizTNAZdzzEZnBrO0eRGuPDYqsKtXtOsi
 guAP8KC4CpUk8NnqJOim+DSqqkCWYUAaLMHYTJ+qbgeoKEFHiF6Pu25VL2KEBo/QO2LX
 qR07/t1DD91FTI98g99sei0MyKz8Idd9IGADQT5KzUm/MAgx6vIG7Zqg4JyjWsUQWkiu
 TyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718641523; x=1719246323;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pbHciCM9rdswrIx9LNF1/9GIczqDC/LiRaO8Y8qPpHY=;
 b=OfDh+veUr1Rk4OHmsqDPsrSE08kyKT5D74etQdYkVUqht1IJrvs3FsK4TU5v20ZNGO
 XuZH69J1MJc3wSV6YfR7bnT2XKUb+egz3vsgyQbjSd0va+kk9Hz2sVXabXagQ2pdf4Gw
 ugAZYga/iZEItc46vGTzj/OOTXUeyBgpJwpikUjN47nFCQUVfedl4A9ZN+a9pfd3jLoY
 pPOZljj+b9nzcIuzQ7O0q+TIBNfhz9CgPSOxRysQ20/WWAnhoTWKZ6Jg7yjNGDVm8a+E
 P25hSJaZFXOzSUOVOv2KwIoP8xHV/P/EIYVesuqQY3AXkQSVPEu7gl9gaz4ILMdeHNTx
 s+MQ==
X-Gm-Message-State: AOJu0Yw5GZe4odDzprFNKwUIJbWBeGrxVCfWjxHCrwNNs+pYHIVitedM
 XXnHeyzFagYHATnQQKIhiJh1IPv+mUITZH8MrFHLdnqxhAksQ7P4hpTppZ2uogd+RYrXqckj+UW
 lqGc=
X-Google-Smtp-Source: AGHT+IGMNz4A0UR3Rm9wMaB5WE2aurAOSY1jvQsBsCTBASF3z3cEKVwWktLQ36IUfJ/I7vxkNIfU8A==
X-Received: by 2002:a05:600c:4ba5:b0:423:573:ab52 with SMTP id
 5b1f17b1804b1-4230573ae49mr74498055e9.0.1718641522793; 
 Mon, 17 Jun 2024 09:25:22 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:8ce9:8054:2dd1:4211])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422870e9681sm201763685e9.28.2024.06.17.09.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 09:25:22 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
Subject: [PATCH] tap: use close_range() when forking scripts and helper
Date: Mon, 17 Jun 2024 18:25:18 +0200
Message-ID: <20240617162520.4045016-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
takes a considerable amount of time. Use close_range() which only
requires to be called twice and factorize it in a separate function for
both call sites.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 net/tap.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 51f7aec39d..6f5bf06bb5 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -385,6 +385,17 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
     return s;
 }
 
+static void fork_close_all_fds_except(int fd)
+{
+    int open_max = sysconf(_SC_OPEN_MAX);
+
+    if (fd > 3)
+        close_range(3, fd - 1, 0);
+
+    if (fd < open_max)
+        close_range(fd + 1, open_max, 0);
+}
+
 static void launch_script(const char *setup_script, const char *ifname,
                           int fd, Error **errp)
 {
@@ -400,13 +411,8 @@ static void launch_script(const char *setup_script, const char *ifname,
         return;
     }
     if (pid == 0) {
-        int open_max = sysconf(_SC_OPEN_MAX), i;
+        fork_close_all_fds_except(fd);
 
-        for (i = 3; i < open_max; i++) {
-            if (i != fd) {
-                close(i);
-            }
-        }
         parg = args;
         *parg++ = (char *)setup_script;
         *parg++ = (char *)ifname;
@@ -490,16 +496,11 @@ static int net_bridge_run_helper(const char *helper, const char *bridge,
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
+        fork_close_all_fds_except(sv[1]);
 
         fd_buf = g_strdup_printf("%s%d", "--fd=", sv[1]);
 
-- 
2.45.2


