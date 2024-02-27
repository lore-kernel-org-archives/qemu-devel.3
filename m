Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85195C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 18:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf2VX-0006Ya-Ug; Tue, 27 Feb 2024 13:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rf2VW-0006YC-Bu
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:48:50 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rf2VU-0001US-RQ
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 13:48:50 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e508725b64so1174325b3a.3
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 10:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709059727; x=1709664527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7NxH+YjseDTpq8veEE2IUMndw319v6C2n3pI3OsSxXo=;
 b=HzMcsNAAMqZdnfye7m1h4b6Gsv7P0ePdXCS2W4PLNFdWeuLUHGk99Zwsnb2X+ZUZgE
 XdpsjQY99PlF8YKwM2OXhNcIiahA1me9dnE7ZqyoHni/h3OzGOMkGwyZBSjIa7c9W1ts
 Zwx2WByyI5TU13vmKO+85UIXzffUAURXZayBg9po2TLa/VP3U2EUG+y2/lAnw6MJX0Av
 PhWcjHb+QrYe+OndqDkGJUKs9ueX67z1wy1/EsvhOSH4ILZg0zK92d2YLGdJPNkRIBXE
 AjSGGjbfODo2Z3XbaNJJlxqH5p22M53i9ODPI00PP0YXSJ7UVvjn5fGiFre+OOfbL0hP
 angQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709059727; x=1709664527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7NxH+YjseDTpq8veEE2IUMndw319v6C2n3pI3OsSxXo=;
 b=lpag/myTUOFdyYDs1d0KWfi27MgwcE7QFuL9DupccU4oA/u2BJeMYVx0tA/QabbQhH
 3fIccpcwbas9MgUOMOaLiPGW4tVYSm7F274qUNAAOqupnmrSyyBJ/AlZsXAe9GApS4eU
 HWqvFEwtMi6muUu4Wktdt2YaxOK4zkwz4J0GKCsPHi58JeYUkgPLz0+H6t6P/KBgSOqj
 IuWP2WbscCIXQpnrC7e9Fa6wTl3HLakOzBcTeS8Rz7oDu/Y/d3PZN5nVPerI14T0Gepp
 B/85lZU8xdO3rEeyZDU0b8PuOLukhv18x0q7XoD11Jphfobu2GE2xYoHr5qVmGphBqa3
 QFrQ==
X-Gm-Message-State: AOJu0YyPgB67ZMnlDqHyVO2cbsLKwnrkfo6LF6muwNXJlLUQV1W6y/bc
 SlqMSxTMV/UiKWivg8Eso/wuexM2qyEDPjRj4Luqe7be0KEgKlWV0xWfcGuT+aBbrfwxm/29hsz
 w
X-Google-Smtp-Source: AGHT+IFKhgFPVqYOgKrGIROfzwRi4WbdBCaBhFn8IVpngE0/HMnomyFasswSbMm2J4vEgsBk8LQfzQ==
X-Received: by 2002:a05:6a00:23d2:b0:6e4:f753:1e12 with SMTP id
 g18-20020a056a0023d200b006e4f7531e12mr10599709pfc.28.1709059727595; 
 Tue, 27 Feb 2024 10:48:47 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 h26-20020aa786da000000b006e555d40951sm533465pfo.188.2024.02.27.10.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 10:48:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH 08/14] linux-user/elfload: Lock cpu list and mmap during
 elf_core_dump
Date: Tue, 27 Feb 2024 08:48:27 -1000
Message-Id: <20240227184833.193836-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227184833.193836-1-richard.henderson@linaro.org>
References: <20240227184833.193836-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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


