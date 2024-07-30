Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B48C3DA7E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 12:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYlwG-0007or-6Y; Tue, 30 Jul 2024 08:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sYlw1-0007np-A6
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 08:26:33 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sYlvL-0004k5-0L
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 08:26:25 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4280772333eso1821925e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 05:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722342284; x=1722947084;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RnrHjU6Qii1wGn9F38c++27n0hhZOVgu1GhR/v/xyMo=;
 b=2EucOFsoztdsLMsgd7frNcbv8NsL6AOx0ce8oph8dNT/B9gbeeOHsLnUso0sc7HmW5
 ZQYtz6Vpkbvzej9PdcFK39RsQtY55cOBQErO+wdpIE+Gx/dh5D1GMR4EeUkP085frogv
 rR13sKD8c2t1pXAVdfchNShf7RulPqUb4b1RJ/ZKXxv0Zti4uPdyqG5QAxXEQfjTdyUS
 2xxTgsiNVavUjqHfaHXv2cxZTR42NqFkFNYruqQYINGv1MBouhTJ0SjKqT6o7Rys7QAi
 CtNBpkaQapnm+eWMSWCP7fISgZ5jsq82BNiEKvOPMMrDlDRI9cpMRdTCVTuYcpSPE+b6
 oSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722342284; x=1722947084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RnrHjU6Qii1wGn9F38c++27n0hhZOVgu1GhR/v/xyMo=;
 b=Hw1II4KuQsr0kW8807pdEl12nZ4GOakXno6VE5Ab9rgqC/OZNXWWE0sqy1XQH9o5JY
 syX3BZKLwx1UDUMkj+JAnp2FaOv6Y5WPHS80AM/nD1MGfxwyDQ1qhBbek0Tcju/cGLbU
 Hk6UuV69Tb076cmItmPW95YWBJOHQJFvWfo5pXFQC+DrKrhLJANTIgbaS5pDOBanHLzC
 LF80RwE2czxSLPDqYz7URPwv/6J4q6//usDJmJEb2RCXeu9soytCOK2X4JlgqH26wqIk
 Tm0aY38PzCLf8kjWRdk0PfTQdHeBjS47m2gi6sI3YdPlATlTtlMKeWFV0Y2psW8J4Yf9
 gOPg==
X-Gm-Message-State: AOJu0YyTsNIHorsLeYHBYN39o84+ja7N3TVOnafv3FaRur5uPgu+5n2N
 rcI+BNire912E0aYVokuEQERwu21s9LGxlu4tGyMhgas1ePK6WYPXqOpblv0+93OVA2pOvZ5dXO
 xefw=
X-Google-Smtp-Source: AGHT+IH5ayAWqqzxkiR2qNjnvOBYMAJ4N2mAzX6sT+f2+sKAqEqeaDDS5iESvYW6iq9Hk4pL8J+jBQ==
X-Received: by 2002:a5d:5f8c:0:b0:367:9cf7:6df8 with SMTP id
 ffacd0b85a97d-36b34cec914mr7329214f8f.2.1722342284118; 
 Tue, 30 Jul 2024 05:24:44 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36862549sm14577757f8f.106.2024.07.30.05.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 05:24:43 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 3/5] net/tap: Factorize fd closing after forking
Date: Tue, 30 Jul 2024 14:24:26 +0200
Message-ID: <20240730122437.1749603-4-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730122437.1749603-1-cleger@rivosinc.com>
References: <20240730122437.1749603-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x32d.google.com
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

The same code is used twice to actually close all open file descriptors
after forking. Factorize it in a single place.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 net/tap.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 51f7aec39d..7b2d5d5703 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -385,6 +385,17 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
     return s;
 }
 
+static void close_all_fds_after_fork(int excluded_fd)
+{
+    int open_max = sysconf(_SC_OPEN_MAX), i;
+
+    for (i = 3; i < open_max; i++) {
+        if (i != excluded_fd) {
+            close(i);
+        }
+    }
+}
+
 static void launch_script(const char *setup_script, const char *ifname,
                           int fd, Error **errp)
 {
@@ -400,13 +411,7 @@ static void launch_script(const char *setup_script, const char *ifname,
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
@@ -490,17 +495,11 @@ static int net_bridge_run_helper(const char *helper, const char *bridge,
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
-- 
2.45.2


