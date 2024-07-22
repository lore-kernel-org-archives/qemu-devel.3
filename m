Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCD8C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0qY-0007FQ-7A; Mon, 22 Jul 2024 17:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sW0q3-00059p-1W
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:44:59 -0400
Received: from mail-io1-xd2e.google.com ([2607:f8b0:4864:20::d2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sW0q0-0004M8-GA
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:44:58 -0400
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-7f70a708f8aso195020139f.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 14:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721684695; x=1722289495;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aHdwiFgOy2Fjg9UYOTxrcvwQ73WzjeLsq+08Td07FKw=;
 b=KPevLR8Kw4G164GOnNtCGX1RWEy1dsq8PUT327Xyx6s4tFHQlpVPFH4XIIPX/heX24
 WXLvuyk3IeLSPwcedL/yUWVZIoH8daWF48nGYuisqLpxZbaIrzcvUIOs29ZYSafonNmy
 TttxDCChL0dOgwzoLi1Gkyggtnus+6nZmOaeqX8UK24Ar/K0MCylm+YfOqGkcA7omcP9
 0c1cSK/3zhDhVYXivvajBb+4mlsS+SEcfE0DThdsHk9jd043ulIljrVZzr0gBh/T2Cb0
 PhD36ghsItzQazl22gT3/GJHKQsjqd5wZ8C3Mj+9l4J9TOxWVyD515wvo677PnOJ7+I5
 8LeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721684695; x=1722289495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aHdwiFgOy2Fjg9UYOTxrcvwQ73WzjeLsq+08Td07FKw=;
 b=RMvteNeTexC5AVfUKzoU5I6GQFSmBOFr8nV/CLYthh85XD07wyM3m/aZpS3Q3BYW4q
 aUOTlBFTVrXi7+X8Tz7g0eg3kOL8OqCae7UGWRlxhQqILiJDG7QvPdnEnxqtF5cqLKR+
 rEfDkuim8B+wHW3kPMY7vczYLBCkBySo5nNWi6Y0vf654172W6C6sxdmlFeDHcTWtxrB
 OvkvYHRcE6uMpRFDZcUghSnHYn1QO6YkYiLSBBMesbbpnWSOU3xNALwxT2UI214L++9g
 T5a7lh5PLMPp28r0QeqmmoVD+cwwprOetd9wxH/RFHsvtgGeEvik6Zujy0TxGDf0rjWV
 03xA==
X-Gm-Message-State: AOJu0YzoQsb19yEw8ym0RI4B1myJEeTZYajvyMdLAKLX+7qmNRmYW9GI
 Pww9UbjoaeEli7TrqTauflZEJzXUv2NKv+w5u1i+dRuih9zyZaJaLCzt3myeVBMosXqhrKuSUD8
 WCgE=
X-Google-Smtp-Source: AGHT+IGfir1cHY9fvKV4XCC+2AhM8lT91fFGpISvwjfXREMglYLs1mFfcWdBGNGURyVi7f6aITVrGQ==
X-Received: by 2002:a05:6602:3fc1:b0:807:82c2:5247 with SMTP id
 ca18e2360f4ac-81ea3573c05mr132581439f.6.1721684694897; 
 Mon, 22 Jul 2024 14:44:54 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c2343d2ff3sm1816830173.128.2024.07.22.14.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 14:44:54 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Warner Losh <imp@bsdimp.com>, Peter Maydell <peter.maydell@linaro.org>,
 Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PATCH 11/14] bsd-user: Sync fork_start/fork_end with linux-user
Date: Mon, 22 Jul 2024 15:43:10 -0600
Message-ID: <20240722214313.89503-12-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240722214313.89503-1-imp@bsdimp.com>
References: <20240722214313.89503-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2e;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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
---
 bsd-user/main.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 82e94a03160..6d81452e51a 100644
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
 
@@ -112,31 +114,29 @@ void fork_end(pid_t pid)
 {
     bool child = pid == 0;
 
+    qemu_plugin_user_postfork(child);
+    mmap_fork_end(child);
     if (child) {
         CPUState *cpu, *next_cpu;
-        /*
-         * Child processes created by fork() only have a single thread.  Discard
-         * information about the parent threads.
-         */
+        /* Child processes created by fork() only have a single thread.
+           Discard information about the parent threads.  */
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


