Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB02CC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 18:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWJxS-0002ZU-H1; Tue, 23 Jul 2024 14:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWJws-0001Bt-Mk
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 14:09:19 -0400
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWJwo-0001DQ-Lj
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 14:09:18 -0400
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-398039f8b7bso20029445ab.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 11:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721758148; x=1722362948;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fc1iffmEOa89zbsiVdbsLtEsb0Kc5g9RfeOgTm7uMho=;
 b=TlbP/ejfJrtjHXmWuqqRF8Z3//TAyHUPtkc8fQt3gZLdiBGOBTkIY+43oJ1QlwoeZk
 kC+4iRyFziKuRcdkRqQATXZaNNQW+cU0zTWTt9tn+K8p0xEdCN+ZoG7sB2tiIFZnzb3e
 y7QbXMzYBdKWRn9Uiq9tpv/yyoYbq1cwqW5phOwC9HfIcVWsxetepD2gBj3SGnNEwM0Z
 OQTA2n7PDLz2Zjmg3yK2rxURrpj9lrYYQrJs4VmIR+dqcUJ07Qs1dSG/EhRwfacsGcGu
 lrnmgOXY9FirPgWKAWw1pe9Ta1rtxWjsU2DmBkAFjvZee1n/PJlIT9ue1lE2scgIHcKW
 wOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721758148; x=1722362948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fc1iffmEOa89zbsiVdbsLtEsb0Kc5g9RfeOgTm7uMho=;
 b=vaYKzqKN+powyxpnlX3fmRekZpXxVDO9qo+5K80wLXnw7hTpxAQLd3ig4KTS333b16
 qk0f5KX+KdlSfFe/tVpj/laLfHZjj6pNsbsnWQR+ntpM5m1CpH+tq1XOGjKGp4MvFkeh
 ub6EZ0grbq1aHkgpJPI0q8GpA0cUB7AMNVV1nCZ902MTqvniMEdrPPIe8QlIkzSxRpkJ
 VkrG2CQ9DXDe5whjqx9XGlxGUEgcjzebT9PnYyAZPacm58n8n0IMcyj5jjyrhjVwzg4B
 V+zkLHvj9FPf7JMLC1eNBqMO7tGhTN8P5N8EQ6fF0ib9yqyZPbaflzLO8fgfAZOBsnUo
 fSuQ==
X-Gm-Message-State: AOJu0Yz+cne0fi1ZQ/I74uxDo7iSDb/yWzjILNNdzQhcZyLxsEk3m5NC
 PwhOL0TvneZOD/QXbtsDIZxK/pw48TZ7IISN4k6DCvtsc5RX2xJRC3Vu+zn6gs33tiikuS5/sGQ
 oWBY=
X-Google-Smtp-Source: AGHT+IH44/gLNSHqUwjcKFYqaXbfK+JEdA/jTWdHKHxs46AFWqUvx7YIuG4KGvG0Yrb5tGfK4UzieQ==
X-Received: by 2002:a05:6e02:1aa3:b0:378:5d14:f426 with SMTP id
 e9e14a558f8ab-3993ff5b8d8mr153514485ab.1.1721758148369; 
 Tue, 23 Jul 2024 11:09:08 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-397f7a2827csm33361775ab.53.2024.07.23.11.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 11:09:07 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Peter Maydell <peter.maydell@linaro.org>,
 Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Jessica Clarke <jrtc27@jrtc27.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 11/14] bsd-user: Sync fork_start/fork_end with linux-user
Date: Tue, 23 Jul 2024 12:07:22 -0600
Message-ID: <20240723180725.99114-12-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240723180725.99114-1-imp@bsdimp.com>
References: <20240723180725.99114-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::12f;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x12f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Jessica Clarke <jrtc27@jrtc27.com>

This reorders some of the calls, deduplicates code between branches and,
most importantly, fixes a double end_exclusive call in the parent that
will cause exclusive_context_count to go negative.

Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
Pull-Request: https://github.com/qemu-bsd-user/qemu-bsd-user/pull/52
Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/main.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 82e94a03160..cc980e6f401 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -35,6 +35,7 @@
 #include "qemu/path.h"
 #include "qemu/help_option.h"
 #include "qemu/module.h"
+#include "qemu/plugin.h"
 #include "exec/exec-all.h"
 #include "user/guest-base.h"
 #include "tcg/startup.h"
@@ -103,8 +104,9 @@ unsigned long target_sgrowsiz = TARGET_SGROWSIZ; /* amount to grow stack */
 void fork_start(void)
 {
     start_exclusive();
-    cpu_list_lock();
     mmap_fork_start();
+    cpu_list_lock();
+    qemu_plugin_user_prefork_lock();
     gdbserver_fork_start();
 }
 
@@ -112,31 +114,31 @@ void fork_end(pid_t pid)
 {
     bool child = pid == 0;
 
+    qemu_plugin_user_postfork(child);
+    mmap_fork_end(child);
     if (child) {
         CPUState *cpu, *next_cpu;
         /*
-         * Child processes created by fork() only have a single thread.  Discard
-         * information about the parent threads.
+         * Child processes created by fork() only have a single thread.
+         * Discard information about the parent threads.
          */
         CPU_FOREACH_SAFE(cpu, next_cpu) {
             if (cpu != thread_cpu) {
                 QTAILQ_REMOVE_RCU(&cpus_queue, cpu, node);
             }
         }
-        mmap_fork_end(child);
-        /*
-         * qemu_init_cpu_list() takes care of reinitializing the exclusive
-         * state, so we don't need to end_exclusive() here.
-         */
         qemu_init_cpu_list();
         get_task_state(thread_cpu)->ts_tid = qemu_get_thread_id();
-        gdbserver_fork_end(thread_cpu, pid);
     } else {
-        mmap_fork_end(child);
         cpu_list_unlock();
-        gdbserver_fork_end(thread_cpu, pid);
-        end_exclusive();
     }
+    gdbserver_fork_end(thread_cpu, pid);
+    /*
+     * qemu_init_cpu_list() reinitialized the child exclusive state, but we
+     * also need to keep current_cpu consistent, so call end_exclusive() for
+     * both child and parent.
+     */
+    end_exclusive();
 }
 
 void cpu_loop(CPUArchState *env)
-- 
2.45.1


