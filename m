Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF95C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 10:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkMH1-0005Mq-4P; Wed, 13 Mar 2024 06:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rkMGs-0005Fr-GA
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:55:44 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rkMGf-0007BD-Ja
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 06:55:32 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33eaafc4419so494717f8f.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 03:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710327327; x=1710932127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o6QDwYzo62XZFD/GhIgkJ+Hn9SLx+3ew7YSnia2dKPw=;
 b=KbZcYWxHGSTdiKxGQwf0+6YciI+lXCywEJNgh8RUOjVXxU4loeOeb3Esp4e2snRgd9
 H2Z0REjfzgaKDNVgPjMDDDnLDjhKPeI41Eh/zxWsaKvJLwQRcvaiJVsKOvbD/g/Pgx2+
 bq8d7VtP3LsQsjbiIIgEcfwGfaRQJOyW0W/z1oYzlUWGyrDCKuaoGON1XOSz3RzYsADo
 s82UoJbgG0jjsbxyF86ju3V1PcL36Ie/aEoDx3qq+e585lkeH6ErPbzhD6r//pJ0Hq86
 aHIb1f+Mtxb+0q0vhduU79/+XQR7oeXP9JQAc0Dsysq5c5m9rEBKsej3U4NJZnZLnCJM
 LJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710327327; x=1710932127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o6QDwYzo62XZFD/GhIgkJ+Hn9SLx+3ew7YSnia2dKPw=;
 b=Drw9uJdb4Bw3jnbTZmsp7bNlR2N/5wRNS5CvL/1x4WE9hg1+ADtf9fp7xHfuI9bTcK
 qjQp5EJ9c86S3mqGXFbuQ6v59qcCIENmlXPF2pzSgoZEBgBHK5MCcu8ihZtsOCBEtihP
 5UtDUQQxqFk4R7H8wA1HoGDaTavI16nQJ7hob5z2CHhf4k5rdBYk8kDpx5TCcxjHmuNG
 r7xC5M7noVNzwstFn2ETCaK/quNxt72O0BBuI3OmquQB/11cPDJdlowLymYJj0WcOWh9
 IUNvCTfyWGBKikztBEVF84Zov+6nsI5XpZ9HHH0c/f3MMZJI6XA+o026RpCqoIbyYv4x
 Hp6Q==
X-Gm-Message-State: AOJu0YzBc96NTei2QXGMoUBnhcZnbxPQlwR/c2gyvrjKrgqaaxlB6PJN
 haP5/fz85+GSv8c2caWecdOhCgG5YJsSfSwl7fCC9t2hwqMfE4vFUrBCHUFCM949+OPsIgQbWpk
 k1lw=
X-Google-Smtp-Source: AGHT+IH2f6l+N9h9kzGaK/HSFs//sPvc8rd9tHX95QULWLEgH3PwyZ33UfRyMjLc2D+Y4zWt71TPmA==
X-Received: by 2002:a5d:5956:0:b0:33e:621e:35b2 with SMTP id
 e22-20020a5d5956000000b0033e621e35b2mr1808362wri.6.1710327327323; 
 Wed, 13 Mar 2024 03:55:27 -0700 (PDT)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 w17-20020adfee51000000b0033e1be7f3d8sm11390338wro.70.2024.03.13.03.55.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Mar 2024 03:55:27 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 3/5] sysemu: generalise qtest_warp_clock as
 qemu_clock_advance_virtual_time
Date: Wed, 13 Mar 2024 14:55:02 +0400
Message-Id: <20240313105504.341875-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240313105504.341875-1-pierrick.bouvier@linaro.org>
References: <20240313105504.341875-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x436.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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


