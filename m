Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C346C3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 22:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWk8B-0001IJ-Dh; Wed, 24 Jul 2024 18:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWk81-0000dh-BW
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 18:06:34 -0400
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sWk7y-0006d3-Tl
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 18:06:32 -0400
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-36da84df7adso1184125ab.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 15:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721858789; x=1722463589;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fc1iffmEOa89zbsiVdbsLtEsb0Kc5g9RfeOgTm7uMho=;
 b=Eah7PvgJ9L5+MbPzgxGgfSChOJ1sAeZuYPsHl3ReguNbhkxAlJ4ElwsV2oPM5Ep+vH
 gPCTHsH1hW0XqDbE4JDf1UVls/oKNtr2f6RgJgo6Ruuw5egKWtBeI3Eu5TvwnsAS+b1S
 hMXyWY86toqg27zozf7f02O8kWmMH7FYrkohzC7ghnIcQJm3Qm0lWl1Gvr4gbvEtFGbe
 gbjN414ZHo4B17BSjFM223RYaQVHeCv/F2o8EQW6MfP/z+njPEhIjt9XHm2IYSMaedSp
 uPxMuOIM8R6VU70rNUg7FzCKoGETfeF6Mjl/ONmwhAQ8aDa1W2txBONihqa1baDGxmTv
 M+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721858789; x=1722463589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fc1iffmEOa89zbsiVdbsLtEsb0Kc5g9RfeOgTm7uMho=;
 b=r6ckKiyq8X7Q4WQzCUIaRl1maQF6lVko9XmPRbR9BDLIzql44xouB42lG/+kAVDDAL
 lwFANe24J2SLfxN60Wl5p8SNLauCVaHMCEG/HoEU+0MWEMm9HEFrQbxcpY3U8CTp+o2v
 /2atbi9QUaSezTBJPhTrb2a+vPUK5NSOpXdKx75O67AcbXaw0rustdLUZqJNJleC5miK
 AmvpDG0+a3sfWlSTmQye3WsbT/YcYAWobKjY+42u8n1rC5iaKNdaYkwABBGzHm5mbNsD
 Ku/KxHoXCE1Oq5Qmh8SL5B/Xrj90ZcEAJda/afSsFElNHHqlRZ1i+dMUwNO59espVgTo
 N00w==
X-Gm-Message-State: AOJu0YyVwfyjKug5AsrBRFzPFHQkptMLzDdyymcTWi4/CsDPaz6G6RDl
 d0POHdKzfS8ZjFoDB0nX7UrDBTEOlYQ/S5Q1S+FO++rqIk65bVg+H8wwse1TlIZa6l06KE1BuKt
 xbL4=
X-Google-Smtp-Source: AGHT+IGfkLj37XGIgliMA/Pu4ftXFL8Z062WQDYV+jpGi/63t1+iyN7gHgu2F45GQWYl0/LZREiu0g==
X-Received: by 2002:a05:6e02:12e7:b0:396:788:f4ef with SMTP id
 e9e14a558f8ab-39a1a80ef7fmr25654185ab.14.1721858789352; 
 Wed, 24 Jul 2024 15:06:29 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c29fa983f8sm10086173.47.2024.07.24.15.06.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 15:06:28 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Jessica Clarke <jrtc27@jrtc27.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 11/15] bsd-user: Sync fork_start/fork_end with linux-user
Date: Wed, 24 Jul 2024 16:04:44 -0600
Message-ID: <20240724220449.10398-12-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240724220449.10398-1-imp@bsdimp.com>
References: <20240724220449.10398-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::132;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x132.google.com
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


