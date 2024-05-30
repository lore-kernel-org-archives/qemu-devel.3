Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C309C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 17:51:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCjuY-0003s3-6C; Thu, 30 May 2024 13:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sCjuX-0003rU-9u
 for qemu-devel@nongnu.org; Thu, 30 May 2024 13:49:57 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sCjuV-0002SM-D5
 for qemu-devel@nongnu.org; Thu, 30 May 2024 13:49:57 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f61f775738so6692565ad.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 10:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717091392; x=1717696192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6IWWhHyfIReAoyuKPFTir6WLrARTyk7MyySJZx8v8IY=;
 b=LbENw2dr/TNmqoHOzpqHovhp2mLDPE4yjqa9r5fE9JPF555xHbHGPNNOqfTlj+xg6R
 K0UUBd7FkpBkoWbJmlO+yuJSc2OhQnwFASG1v9dO7CytVvbIHvPvMQn2d3AryznPuMMS
 wHJ+3+k3XEyrB7sdD8dw2GOkidKob2b1+giX1puasnpUaoRtvT6cIF6Z3r+rYf4bMe2E
 CqS8/Cw6Kg2L8Eu9pHwU4tBp8AGYRHJDII41+20uwhJQo3UM8p0UzBjXOnPZg3mPyEF4
 NuJ5EkfYdt+VP7z986JQJoJNNNwX9RGNJUWxO2YMXpunauaABj4Z9Huc9D+T1jTd+Qpw
 JjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717091392; x=1717696192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6IWWhHyfIReAoyuKPFTir6WLrARTyk7MyySJZx8v8IY=;
 b=lJfZn+UDx3j+yLT8kfU+4jg/emfWcSezuN2/mfnKnpPQBjcNFWkiwhJ/Guh/Z3rt6e
 wKqSh0Uw3GUnMfzaJVdqfi9VZ9rsLReKwXpUb5d7sSozURt41kn/2SQU7t2DGkCcJXl1
 RgtxZFmRJ3SxeX+bvgKMDOPTkJWAkW7hWSLZJ5tjGStIkHfqMkAc2aGGrZdgkTVrNZ3O
 94fLA7sPUuB8E1ShNmmtK4bUdyM8WBSXrnKb8mYBvfPN+L+Ty6yHl2ACmiuuhOoKR8sp
 K+OtvSqPxzetfeOYWSjpKkBPhQ5dyrgywyt8ACJa9HdpiaK+hAi+LwzcqVCqFKtoqOZx
 RCfA==
X-Gm-Message-State: AOJu0YyR7xJvQFrbsZxUYjSBzjEYDeT4fqCQ8+qLwRWVkzfKH7o2FcVU
 LEjI3XSUBhzx0+MHZHrb6qT27uGZMFO9Unj55UINBLioTRA4QK0zavA9M4xx0JChy5h00Me1W97
 ghD8=
X-Google-Smtp-Source: AGHT+IFAwF5cR+Jg7SUirFkFs9vWxwXiFldFvhwxAhkaK9VVVOTf6vSHeI8x1+uvDPOEf/Hw07wNTQ==
X-Received: by 2002:a17:903:2385:b0:1f6:1144:a112 with SMTP id
 d9443c01a7336-1f6196087d6mr31883245ad.25.1717091392121; 
 Thu, 30 May 2024 10:49:52 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323deb38sm590405ad.124.2024.05.30.10.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 10:49:51 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 3/6] sysemu: generalise qtest_warp_clock as
 qemu_clock_advance_virtual_time
Date: Thu, 30 May 2024 10:49:36 -0700
Message-Id: <20240530174939.749163-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240530174939.749163-1-pierrick.bouvier@linaro.org>
References: <20240530174939.749163-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

Move the key functionality of moving time forward into the clock
sub-system itself. This will allow us to plumb in time control into
plugins.

From: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/timer.h | 15 +++++++++++++++
 system/qtest.c       | 25 +++----------------------
 util/qemu-timer.c    | 26 ++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 9a366e551fb..910587d8293 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -245,6 +245,21 @@ bool qemu_clock_run_timers(QEMUClockType type);
  */
 bool qemu_clock_run_all_timers(void);
 
+/**
+ * qemu_clock_advance_virtual_time(): advance the virtual time tick
+ * @target: target time in nanoseconds
+ *
+ * This function is used where the control of the flow of time has
+ * been delegated to outside the clock subsystem (be it qtest, icount
+ * or some other external source). You can ask the clock system to
+ * return @early at the first expired timer.
+ *
+ * Time can only move forward, attempts to reverse time would lead to
+ * an error.
+ *
+ * Returns: new virtual time.
+ */
+int64_t qemu_clock_advance_virtual_time(int64_t dest);
 
 /*
  * QEMUTimerList
diff --git a/system/qtest.c b/system/qtest.c
index ee8b139e982..e6f6b4e62d5 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -337,26 +337,6 @@ void qtest_set_virtual_clock(int64_t count)
     qatomic_set_i64(&qtest_clock_counter, count);
 }
 
-static void qtest_clock_warp(int64_t dest)
-{
-    int64_t clock = cpus_get_virtual_clock();
-    AioContext *aio_context;
-    assert(qtest_enabled());
-    aio_context = qemu_get_aio_context();
-    while (clock < dest) {
-        int64_t deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
-                                                      QEMU_TIMER_ATTR_ALL);
-        int64_t warp = qemu_soonest_timeout(dest - clock, deadline);
-
-        cpus_set_virtual_clock(cpus_get_virtual_clock() + warp);
-
-        qemu_clock_run_timers(QEMU_CLOCK_VIRTUAL);
-        timerlist_run_timers(aio_context->tlg.tl[QEMU_CLOCK_VIRTUAL]);
-        clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    }
-    qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
-}
-
 static bool (*process_command_cb)(CharBackend *chr, gchar **words);
 
 void qtest_set_command_cb(bool (*pc_cb)(CharBackend *chr, gchar **words))
@@ -755,7 +735,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
             ns = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
                                             QEMU_TIMER_ATTR_ALL);
         }
-        qtest_clock_warp(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + ns);
+        qemu_clock_advance_virtual_time(
+            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + ns);
         qtest_send_prefix(chr);
         qtest_sendf(chr, "OK %"PRIi64"\n",
                     (int64_t)qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
@@ -781,7 +762,7 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         g_assert(words[1]);
         ret = qemu_strtoi64(words[1], NULL, 0, &ns);
         g_assert(ret == 0);
-        qtest_clock_warp(ns);
+        qemu_clock_advance_virtual_time(ns);
         qtest_send_prefix(chr);
         qtest_sendf(chr, "OK %"PRIi64"\n",
                     (int64_t)qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 6a0de33dd2b..213114be68c 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -645,6 +645,11 @@ int64_t qemu_clock_get_ns(QEMUClockType type)
     }
 }
 
+static void qemu_virtual_clock_set_ns(int64_t time)
+{
+    return cpus_set_virtual_clock(time);
+}
+
 void init_clocks(QEMUTimerListNotifyCB *notify_cb)
 {
     QEMUClockType type;
@@ -675,3 +680,24 @@ bool qemu_clock_run_all_timers(void)
 
     return progress;
 }
+
+int64_t qemu_clock_advance_virtual_time(int64_t dest)
+{
+    int64_t clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    AioContext *aio_context;
+    aio_context = qemu_get_aio_context();
+    while (clock < dest) {
+        int64_t deadline = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
+                                                      QEMU_TIMER_ATTR_ALL);
+        int64_t warp = qemu_soonest_timeout(dest - clock, deadline);
+
+        qemu_virtual_clock_set_ns(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + warp);
+
+        qemu_clock_run_timers(QEMU_CLOCK_VIRTUAL);
+        timerlist_run_timers(aio_context->tlg.tl[QEMU_CLOCK_VIRTUAL]);
+        clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    }
+    qemu_clock_notify(QEMU_CLOCK_VIRTUAL);
+
+    return clock;
+}
-- 
2.39.2


