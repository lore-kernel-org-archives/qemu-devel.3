Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD39C52D6F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 14:56:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZtga-0004co-13; Fri, 02 Aug 2024 10:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sZtgS-0004OO-R4
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 10:55:08 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sZtgQ-0005HE-Ox
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 10:55:08 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1ff499841f4so2624145ad.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 07:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722610504; x=1723215304;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XxTT+tyZr9At4fgl+GpnY8w1n+uFaZlL69cg05NKgv4=;
 b=DBb8FimTboUF6FURQ3ZthP9PB7XPgibNTkAPe914KOA4o44E7xnQQO4bFzdq/Sz4cK
 umPK0FLGuna9B9acEumWEo42gT1WfpE6DJyWUIbK9d5ppURwXAQkKj9dvBQbjUi6Xjqg
 5fHzgMs014TN1RtggDjjn8GNIFDkFel4N7g8UZYPzk+kH/nQJL2gKei6xru+ylenhaLh
 S+yKeqIMyyeqxyF0ewnHw56nn/WArwj/BJYJ3rNnx/b2gAsopSQ/r+mjKVD6H4NlJmvT
 9VRXFypO8sCnpZU9GaOqiOnhSQc4lEhIuxbRFVZ5aGv15JU4ypYEnRvBcHyltSyNO3rh
 2glA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722610504; x=1723215304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XxTT+tyZr9At4fgl+GpnY8w1n+uFaZlL69cg05NKgv4=;
 b=NUaMhihWAf8B/+s4+JCHM+TtIHuFOMtO9HqxN53XZe2BREwuMaW6PMFLzrG1xyIN3p
 OVxtYATeeqlt/hWhCRozdKnKsQ+bXiy9pTrsDjJYg1E/zwcoFsJU/3ljuP/8TmSZAkxo
 R2Y+2x96zRMpUTkgl7Ix1z+8NR59hTcagr8BsYCuvKGLI3tEMQP5sTYsmWXyULYMTMy0
 mo4c66CNgMYszRASXSz1iBQGW7KHpAp4XV42Ova6VpqyM1Qrd/V6JEknX7aRjMlSdIXl
 8ToM7WAA4v/8O+Yv85rM0OQy49W19npd52/3shCRJEcgDP0tTCie8LVc0FnpIOpHnWXT
 ixSw==
X-Gm-Message-State: AOJu0YyZ+A1QdA+SQz7rm6rNAGQvFlhuUJOpNuQviKJdFj0NvV/kjocd
 e8/sGeIWyX9igv2vQbU4uILkS2Vi6gAskDJ3aiw5Wn8t8m0yHyHw0/Tu0FI77RqmC68KKr8EpcJ
 fFj8=
X-Google-Smtp-Source: AGHT+IGdnsLMOuDXwtzrZ5yS0wi/cF6PrYqO+0dllNNGYuPkSLXDvKpTphPkxfcutc8qpHRVUbw5/g==
X-Received: by 2002:a17:903:245:b0:1fd:aac9:a722 with SMTP id
 d9443c01a7336-1ff5728b2d0mr26232885ad.4.1722610503790; 
 Fri, 02 Aug 2024 07:55:03 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff592aee19sm17920635ad.282.2024.08.02.07.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 07:55:03 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v8 5/5] net/tap: Use qemu_close_all_open_fd()
Date: Fri,  2 Aug 2024 16:54:21 +0200
Message-ID: <20240802145423.3232974-6-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802145423.3232974-1-cleger@rivosinc.com>
References: <20240802145423.3232974-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=cleger@rivosinc.com; helo=mail-pl1-x62b.google.com
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

Instead of using a slow implementation to close all open fd after
forking, use qemu_close_all_open_fd().

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 net/tap.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 7b2d5d5703..3f90022c0b 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -387,13 +387,20 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
 
 static void close_all_fds_after_fork(int excluded_fd)
 {
-    int open_max = sysconf(_SC_OPEN_MAX), i;
+    const int skip_fd[] = {STDIN_FILENO, STDOUT_FILENO, STDERR_FILENO,
+                           excluded_fd};
+    unsigned int nskip = ARRAY_SIZE(skip_fd);
 
-    for (i = 3; i < open_max; i++) {
-        if (i != excluded_fd) {
-            close(i);
-        }
+    /*
+     * skip_fd must be an ordered array of distinct fds, exclude
+     * excluded_fd if already included in the [STDIN_FILENO - STDERR_FILENO]
+     * range
+     */
+    if (excluded_fd <= STDERR_FILENO) {
+        nskip--;
     }
+
+    qemu_close_all_open_fd(skip_fd, nskip);
 }
 
 static void launch_script(const char *setup_script, const char *ifname,
-- 
2.45.2


