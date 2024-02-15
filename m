Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF5DC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 06:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raV6o-0002Id-MS; Thu, 15 Feb 2024 01:20:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV6l-0002G7-4F
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:31 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1raV6j-0005M4-GC
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 01:20:30 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d8ef977f1eso4469275ad.0
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 22:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707978028; x=1708582828; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=emMi1h1Qw5IeyN9nGFR+tElZTiLuS0cNV7Vg5JxneO0=;
 b=zJFJ/SjXHE7Sqn4HUoCS/MuJRdx0bQFgr0XiEu6NKwX9V1tOOdkiIxYMukF1MJ3x1T
 xDl0bbVyhVwiwmeGwePBg8sJSMUodD6prl/HOM8ymn7Dkb/X0qZ3LsbZuTqosbgYsVMQ
 E4LQTqOtLYYtTBE4g5kE8MYQbDk6o/ieEJP5Eu1M1428qfnLBpam1IqQN2nsUM30ikoO
 shPccr5YcRFe5wve94Db2OWqNlBfZqCQDSfpsW41Dvvq2QNqEBawqcKxLoXUgReYWrlc
 Fq1EvqhbdqDbrniThsFqi0IRp4R5UwZhys7sdsHKr8aXoQ1bCJ97LW10EkA2o6elJX3o
 vTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707978028; x=1708582828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=emMi1h1Qw5IeyN9nGFR+tElZTiLuS0cNV7Vg5JxneO0=;
 b=Vdf80zVwVCgJ9qclKmSSQkKtGyU6nj/m0n0HEV3aKBEiW7Xhs2Rn9TKcotbkBzP1TF
 vR3WMVX/X1f9o4y2P2BT2GVfaEIo3aw+r2YErluJ5vF/EmpDg4mtxIYsx3qxT02dJYzK
 Q5negPj3Z4wotkQTuGQQXNGM4gluOgv6hdiw5IPwU5dDDCbUc1VZlaTNCxEySj6s0PwB
 SSUKLhINAQP1jdcItlbnfwr0PzaCq92UtVbMYlqxT7iNsBYwUMhMBppF47pEasEUSOK5
 eE9uV4jUGf129i5vZzn7QeKCHrXwsj6AODfu2YutIrkCQHfccN9aayvj1tWd8NHbyjGa
 rwnQ==
X-Gm-Message-State: AOJu0YwfkccT+6yl2kf6R6SS2U4GGIlkOuW2vmpVPZoQlpN6ScMdkYgk
 TcEuYh8/i7aEjm2za2NXSCth+nvh8goCQ5S6sadMRmf0Hhn0Eu7tis8Mzea8lKM3ipuocFrJ4/D
 k
X-Google-Smtp-Source: AGHT+IHQblyR9F7Qyb08Jc8NnbGd1b8+aT4L1UnTE6GwG6dVNrZ4YVJhGvFSki5qyJSE1WeYcr0HlA==
X-Received: by 2002:a17:902:654d:b0:1d9:6dc6:6616 with SMTP id
 d13-20020a170902654d00b001d96dc66616mr769027pln.68.1707978028155; 
 Wed, 14 Feb 2024 22:20:28 -0800 (PST)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902b70500b001d6f29c12f7sm464418pls.135.2024.02.14.22.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 22:20:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH v4 05/36] linux-user/hppa: Simplify init_guest_commpage
Date: Wed, 14 Feb 2024 20:19:47 -1000
Message-Id: <20240215062018.795056-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215062018.795056-1-richard.henderson@linaro.org>
References: <20240215062018.795056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

If reserved_va, then we have already reserved the entire
guest virtual address space; no need to remap page.
If !reserved_va, then use MAP_FIXED_NOREPLACE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-6-richard.henderson@linaro.org>
---
 linux-user/elfload.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index dfb152bfcb..1893b3c192 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1970,16 +1970,20 @@ static inline void init_thread(struct target_pt_regs *regs,
 
 static bool init_guest_commpage(void)
 {
-    void *want = g2h_untagged(LO_COMMPAGE);
-    void *addr = mmap(want, qemu_host_page_size, PROT_NONE,
-                      MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+    /* If reserved_va, then we have already mapped 0 page on the host. */
+    if (!reserved_va) {
+        void *want, *addr;
 
-    if (addr == MAP_FAILED) {
-        perror("Allocating guest commpage");
-        exit(EXIT_FAILURE);
-    }
-    if (addr != want) {
-        return false;
+        want = g2h_untagged(LO_COMMPAGE);
+        addr = mmap(want, TARGET_PAGE_SIZE, PROT_NONE,
+                    MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED_NOREPLACE, -1, 0);
+        if (addr == MAP_FAILED) {
+            perror("Allocating guest commpage");
+            exit(EXIT_FAILURE);
+        }
+        if (addr != want) {
+            return false;
+        }
     }
 
     /*
-- 
2.34.1


