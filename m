Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8D0C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 23:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgBxn-0004uC-KK; Fri, 01 Mar 2024 18:06:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxd-0004rt-UN
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:42 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgBxa-0004DV-Ry
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:06:37 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1dc5d0162bcso25434825ad.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334392; x=1709939192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jFfW1DmYHFMf19W3HAUQWeg/5lBH99MdAkdqkDNLv3I=;
 b=QaWCJ4tqxnwojuuu2XZbWDjRPNE8LZs9erbE1yxXt7g7r0TfMZzcLMQhmP9POdh016
 mFKHwA0KCx99uPZOTlE8HJ8sDxuHXj4a2tB/nSyIlzMjktTmBYwBnKu55IOIMq9266g7
 YYrNwqVEPcU5n7SRGCRx2N+3lTUCh++USkL9AHoNPpXUIvsWCiI6HCRKdvN9VA8CWfvO
 srS96wOEIqhdFlGR2OYPUcOvp5w4E5h5y46TN4JpzNYf23fIHIlEFsTPDR41Vt9GV0mD
 d3VzmFGasZ5TWwOJXa/yVorbTPhTaxwHfJGnAMlZ6SG0MMxCKyJGFG001S2YWOuHu23u
 9Naw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334392; x=1709939192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jFfW1DmYHFMf19W3HAUQWeg/5lBH99MdAkdqkDNLv3I=;
 b=WCzUx9hLNB5ohBrv1Yv47cdWaqJbGYZZ6GIOPNKJTq4Kk24dcwU42AyULrcbDGM4kr
 Kvvybk/EXe+sH9NGsIg1YZzTb6d0EoZmo7rwf5nHKxBUjGoN7EedHLp0K6dKNIgYR3Ng
 DUSEw5RZdy7gttOJJXgzgqI24GZVvXQ/BGTGD7MV58kvJoIA2Q6Xr8Wyb6mRTCXOOw9R
 8lvAm5FkP0+ZN9atg1dFvlMMOcrQi8yzg/lGwAvsiqmivmztOXgyfocE8X+CHjSXPtSU
 /KQA7d3Cofc09HGb7wGIk1eMHRvvAWnWJefRrP70hkljHHQu41NdI7h4EJi7+YB4qBTw
 S8jQ==
X-Gm-Message-State: AOJu0Yy2PlRsyHjsP+u3NdbzIyfKcJ50S0oqQOt5KrBWPvVz4z6jLEEH
 sGVeSrk33Ha6W9Qtxl3bdv+cjDDoyQWttcmG8L78acXoZdgAn04RMhbj6eR/BK7XY1GfkjO2wq8
 S
X-Google-Smtp-Source: AGHT+IG0GtjAMANkWQJRGbfEz40ZPliBwNaaKDTMAo7IoH0sOookM6bsq6mkQI+mH6JqWjhdLg+dvQ==
X-Received: by 2002:a17:903:41ca:b0:1db:d66e:cd15 with SMTP id
 u10-20020a17090341ca00b001dbd66ecd15mr4038015ple.59.1709334392669; 
 Fri, 01 Mar 2024 15:06:32 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 lc11-20020a170902fa8b00b001dc668e145asm3988580plb.200.2024.03.01.15.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:06:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 08/60] linux-user/elfload: Lock cpu list and mmap during
 elf_core_dump
Date: Fri,  1 Mar 2024 13:05:27 -1000
Message-Id: <20240301230619.661008-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Do not allow changes to the set of cpus and memory regions
while we are dumping core.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 16dd08a828..6f9da721d7 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4537,13 +4537,11 @@ static void fill_note_info(struct elf_note_info *info,
     }
 
     /* read and fill status of all threads */
-    WITH_QEMU_LOCK_GUARD(&qemu_cpu_list_lock) {
-        CPU_FOREACH(cpu) {
-            if (cpu == thread_cpu) {
-                continue;
-            }
-            fill_thread_info(info, cpu_env(cpu));
+    CPU_FOREACH(cpu) {
+        if (cpu == thread_cpu) {
+            continue;
         }
+        fill_thread_info(info, cpu_env(cpu));
     }
 }
 
@@ -4643,6 +4641,9 @@ static int elf_core_dump(int signr, const CPUArchState *env)
         return 0;
     }
 
+    cpu_list_lock();
+    mmap_lock();
+
     /*
      * Walk through target process memory mappings and
      * set up structure containing this information.  After
@@ -4760,6 +4761,8 @@ static int elf_core_dump(int signr, const CPUArchState *env)
 
  out:
     ret = -errno;
+    mmap_unlock();
+    cpu_list_unlock();
     free_note_info(&info);
     vma_delete(&mm);
     close(fd);
-- 
2.34.1


