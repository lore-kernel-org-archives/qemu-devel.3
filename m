Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FF6E6F091
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 21:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6zOI-0001O0-Tq; Fri, 01 Nov 2024 17:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <38EolZwYKClsKHJN7A9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--roqueh.bounces.google.com>)
 id 1t6zOH-0001Ne-P5
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 17:41:09 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <38EolZwYKClsKHJN7A9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--roqueh.bounces.google.com>)
 id 1t6zOE-0000h8-Hf
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 17:41:09 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-6e7fb84f999so41433467b3.2
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 14:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1730497264; x=1731102064; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qz9eXsz1a5BbljAcV0F6fGtTdpxxvDLM/JivjXSwJNg=;
 b=IbTvAFmD22qrbrv1HPHMVAY7GL2DqKuXAWxu4unSh3hjnCcgCPStIgsnMHhBAFybMC
 Y6wGspvw7bQEA5ofqOjnQN7k/NY6XgmeY8xC6mxBYRXwH5rz41g7uByG1Y5nyE35HZ25
 vAzXKAOvl7Kzl0AujVAJLvc7Jp+BCdTrcuq3zwFfYudDYRQSPV6213IEIN3PoMgXrWlU
 dEKphgSEB3x8S7WrjanYhZGF/z2IDZrKaIJe6aGyVnerlhHRGfMPcQS7q3qHkieD89Eo
 r2gNi73n/yTPRlPHIedx5y/Ub63lmi44VLRSkyCXhY9FMPXYNryRK6vELVFGVdPaviO8
 Ks4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730497264; x=1731102064;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qz9eXsz1a5BbljAcV0F6fGtTdpxxvDLM/JivjXSwJNg=;
 b=idW4RAFFyVKRqZWNrvMM36U4fglhZT9sQnKueuRL8RPWUzR05Emz55judPwuyuM7ab
 z4iq2xM8llTw1sNTsweDuIH60/AuRXM0baL3yUJWU/5Sse0LxUE1FG2xrjzRzgAoxIoQ
 9PLXJy8cTo9xlVo6a/z3uOpOQ+6FJW39AwNYSDnf3XI48L3uboboyjEcPnVM6yRZ6huE
 9tGJeCjCf/CUxEiuwB6nnvcX83uoCO4pl+OQmXwD0kSteMrgZxFBWcV60LGB+UD98f3H
 5fZxY96mkuWhekhNbdNPys7MYWypbucGS8VocU9WEg8wE4JcXLg+RkbAQPln9UKc07nO
 HCTw==
X-Gm-Message-State: AOJu0YwomsikvgAG60hZcjrPr3/L36ZQ1sAUNjR191qxEjqCRB3ibWc8
 LE7YvNqngmexywY3mnn8DgvqAV2e2SI5Ul6j/M1OgxNjbQ4P/8Ti6Z9vCKkNpgFmE+FqPbbFjQ5
 vPg==
X-Google-Smtp-Source: AGHT+IFmbgWl4C3WqAmcPNh/43uY0h7e8wOu6VxyHRkc0tBeI0E0mJf9DTQlXzaTv3FNtkrF+manF8GEnSI=
X-Received: from roqueh.c.googlers.com ([fda3:e722:ac3:cc00:4e:3bc9:ac1c:1ab])
 (user=roqueh job=sendgmr) by 2002:a05:690c:4510:b0:6e2:1ab6:699a
 with SMTP id
 00721157ae682-6ea64beda72mr352017b3.7.1730497264464; Fri, 01 Nov 2024
 14:41:04 -0700 (PDT)
Date: Fri,  1 Nov 2024 21:41:01 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101214101.3376595-1-roqueh@google.com>
Subject: [PATCH] sysemu/os-win32.h: Windows clang-cl compiler fixes
From: Roque Arcudia Hernandez <roqueh@google.com>
To: jansene@google.com, sw@weilnetz.de, peterx@redhat.com, farosas@suse.de, 
 lvivier@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, Roque Arcudia Hernandez <roqueh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=38EolZwYKClsKHJN7A9HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--roqueh.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

This contains a series of small compiler fixes to enable the compilation
of qemu using clang-cl.

It mainly involves adding some missing header files and updating #ifdefs
to handle clang-cl specific things.

Signed-off-by: Erwin Jansen <jansene@google.com>
Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
---
 include/qemu/compiler.h   | 3 ++-
 include/sysemu/dma.h      | 2 ++
 include/sysemu/os-win32.h | 2 +-
 migration/savevm.c        | 2 ++
 tests/qtest/libqtest.c    | 2 +-
 5 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index c06954ccb4..7f532fe660 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -22,7 +22,8 @@
 #define QEMU_EXTERN_C extern
 #endif
 
-#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
+#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__)) && \
+    !defined(__clang__)
 # define QEMU_PACKED __attribute__((gcc_struct, packed))
 #else
 # define QEMU_PACKED __attribute__((packed))
diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
index 5a49a30628..f53b751fe2 100644
--- a/include/sysemu/dma.h
+++ b/include/sysemu/dma.h
@@ -14,6 +14,8 @@
 #include "exec/address-spaces.h"
 #include "block/block.h"
 #include "block/accounting.h"
+#include "block/aio.h"
+#include "qemu/iov.h"
 
 typedef enum {
     DMA_DIRECTION_TO_DEVICE = 0,
diff --git a/include/sysemu/os-win32.h b/include/sysemu/os-win32.h
index b82a5d3ad9..b5f1c61df4 100644
--- a/include/sysemu/os-win32.h
+++ b/include/sysemu/os-win32.h
@@ -70,7 +70,7 @@ int __mingw_setjmp(jmp_buf);
 void __attribute__((noreturn)) __mingw_longjmp(jmp_buf, int);
 #define setjmp(env) __mingw_setjmp(env)
 #define longjmp(env, val) __mingw_longjmp(env, val)
-#elif defined(_WIN64)
+#elif defined(_WIN64) && !defined(__clang__)
 /*
  * On windows-x64, setjmp is implemented by _setjmp which needs a second parameter.
  * If this parameter is NULL, longjump does no stack unwinding.
diff --git a/migration/savevm.c b/migration/savevm.c
index 7e1e27182a..c082015e84 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -54,6 +54,8 @@
 #include "qemu/job.h"
 #include "qemu/main-loop.h"
 #include "block/snapshot.h"
+#include "block/block-io.h"
+#include "block/block-global-state.h"
 #include "qemu/cutils.h"
 #include "io/channel-buffer.h"
 #include "io/channel-file.h"
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 9d07de1fbd..1fcb749602 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -386,7 +386,7 @@ static pid_t qtest_create_process(char *cmd)
         abort();
     }
 
-    return (pid_t)pi.hProcess;
+    return (pid_t)GetProcessId(pi.hProcess);
 }
 #endif /* _WIN32 */
 
-- 
2.47.0.163.g1226f6d8fa-goog


