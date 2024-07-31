Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399ADC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 08:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ50m-0002Qf-Ge; Wed, 31 Jul 2024 04:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sZ50k-0002I1-Ar
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 04:48:42 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sZ50i-0004bf-CR
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 04:48:42 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-36874d7f70bso605324f8f.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 01:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722415718; x=1723020518;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MacBk+b81Y9XSBf3+Dejb8DivJ0DDo61Nr8SOpG9EWU=;
 b=2tDVLmMuCAeHdzn0sC78tz2O0WH5aqkqAPMt1D1nce0fwN4b9Iz/sKS+38OW1BrlOY
 Al98ulw5ft72EyWUx3uzVvyvfF1Ygx0RU+BDQIJTkjmVd/NNtwS+3tPhjoZnLVlOHrcy
 P2I8r+JEyitRuZf6KIstz/ZdH70ID/+xkeb6H8wEaD47nxdDXQbvFot1fTdxUrijj2J7
 0WV6UzVR4zJtTN2X9CZ6c5ATbOfkbCKmXDOwy6lNNgxpNgtq5pylwEQzXojBC7z4uem2
 nRkikAZcuoafPopqjyy6NZy1JJKebjpzQaNmE1I/oIbyrFLwpuzfqUavQtQ8rBmfl4j4
 YdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722415718; x=1723020518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MacBk+b81Y9XSBf3+Dejb8DivJ0DDo61Nr8SOpG9EWU=;
 b=kaAHXX3RF0JaY0kmqc3RFyLqNxXibIiAsHB1AbpYb1tEEjF6R/MgRJvt3SAcjdDSV+
 uMqUFlvVxv5Ih62DOM/m5cMtofk9Wi+H8y1gI+i3QCN0eMOCHO+NiNjU+YK+wGk5AwX5
 lDZQxRsalKmoibrGvBARzqO+XNAk0aaffOtm2vUCPmt6FoFCj3jHi1hznVnr6/ckvSTm
 YVh65M9XjMSDwqLrVNSIgYvjOUrpizHSVOMm1FZNGoNvDvrch1lO351gvssYqbf9Qcqg
 Hhvi8RXGVdQ51dm7u2xPLx4TsbhwA+3KJeCOgbLyoADZRWXbjh03HVmw6kGQDS3QcKzm
 X09g==
X-Gm-Message-State: AOJu0Yx0tjHNZw7JCpx2y3jAdwdg3YTxb9rINHCMXSllFJgh61xUR575
 SsIVgvV2szXTImhao7meQZ5wLJ6vQm6f80hWxlmV0FUajHsd4wRstm5hum2O0a6l9+apIFh+ewv
 j6uI=
X-Google-Smtp-Source: AGHT+IFD82QolmIrJcH+O9fEBiISrlJAJHBkvhgIcd+oMOnSShpF9H56hE3GWETiAQxXO5I4qEPmyg==
X-Received: by 2002:a05:600c:3ca8:b0:426:6cd1:d104 with SMTP id
 5b1f17b1804b1-4280578251bmr90184735e9.4.1722415718319; 
 Wed, 31 Jul 2024 01:48:38 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367c0344sm16576425f8f.2.2024.07.31.01.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 01:48:37 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 3/5] net/tap: Factorize fd closing after forking
Date: Wed, 31 Jul 2024 10:48:27 +0200
Message-ID: <20240731084832.1829291-4-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731084832.1829291-1-cleger@rivosinc.com>
References: <20240731084832.1829291-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=cleger@rivosinc.com; helo=mail-wr1-x431.google.com
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

The same code is used twice to actually close all open file descriptors
after forking. Factorize it in a single place.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


