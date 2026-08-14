Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F45C5CFCF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 17:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuw1i-0004EZ-LE; Fri, 14 Aug 2026 13:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wuw1h-0004ED-34
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 13:49:05 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wuw1f-0007sD-IE
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 13:49:04 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-84eb992a881so976035b3a.2
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 10:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786729742; x=1787334542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DPSDviFqApdYu3jSw/bOhgb8XhPO4cV50Zgcj5hEc6s=;
 b=ZOYUM0RDUWnoGrHwJzLNVZVdZjayh3uk87vPugXfoZi0nj5FWvO3tyn94yu8cL2jTo
 oudm53qCpYQIdowMo5lpdC8T6egS5LIjNLFPKjyFkmo2wn5+mM0QfOmnsgQd4g4hskrP
 mFUhGQIpiuZv7qGdkMlh+QoMN/8Eb1VhIe+XzbSHX+7a3b3LOm+Ls0tJzMUX030mKxw1
 QMp3Gca7Ut5ZCCxRIkgnkhN24aSUuQIz5f4kuwjF3C1aqI8p7BrTR7rRR2m8zgsuSvoA
 ZOB4EUFngI398ULBNQnytGwPToyiYvy58Ive6giBvCk8DTfE47oxkoAgjclOqWtDYPO2
 tuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786729742; x=1787334542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DPSDviFqApdYu3jSw/bOhgb8XhPO4cV50Zgcj5hEc6s=;
 b=IhDv2mWebOYkaE/VRlRe8JDHNIZG5ElJryVs08dFsATcE0UENqinN6LpRIBqLDjdwC
 b8VCpziEs4o19fjdimyWwjB1p7IuRN8YRhz6KlVROaXw8viYjICaUid/zIHbFmuGXpEw
 VtL9IAO6sWXgb/XOnhQdSnquLYMWhSBfRMQz7pKQaj3jVFL4SLUU2ZULwW9bJ0OYQAPn
 9Yil4eLTIGn9gqnWGxwpxG7fDTn3GqQi0ie5ktnIoQoNJc1Uwq0123pI78GgTL1AFdwe
 0ZE0iYdIV/eijzpoJrFpEyZ6WDeaJsRrxEUUtNQZmLg/IcrzMjcDEZF0SWQfqNQ7fJkt
 t0UQ==
X-Gm-Message-State: AOJu0YwMDLXfzPxF9OmObdQ1g4YUlvrLKX7c6KTzOhV84RDtOwZR2yrp
 LDtDEUPFVLNwSKo5f/WBUwR1VgaCku5Q/xF7wYmYJ0kxb2L+l0/VmFCdHfvf3eIW1aZVuw==
X-Gm-Gg: AR+sD13PZzSv3Wqmqz8Sz0rKL3Q7/7ripZSRCdsKiz55AM8uoAQ42d83TT+t5mC8pX4
 ydehCEwdF9ym6zFGLHGW5BXV6JPsNlL9gPum1AI6pgk+Aq6wYd+qwqmEP1FVva/eGGoETaWyoO9
 4S2EIZQqviAwi6yVi8p8XQaXUT0U+guaZqlSOWVzBHiy/hIReyLrSNu5LqC/Y6aHO1jEaFMJUpa
 y4tOOrI/uxPLjgp3TNa8gjw95vtSi6e64JHC4N9upEJoJRPe0kIDsuzEHe6B12jzY4Iv+DcHoKP
 Pc42MP95tnuO+2B87Cv7AmA+66UrzhZEs41WHTObM8vlCgM+vJvK+rfIKDBd2vLmeyc2LZ4FbL6
 g3GCt4O6lbtFjQ5C5hh9TfXWbi6xtxnck3b5dWOo37vQHBNwZOeKctkAVIDoh+X0inZBbsp0cG8
 MXci7POyNI4JRfoAiYnGUwrWAFeXkuzIalj7q7rfXYsDHAK7CFB4PbetHPEnSAJBIpEr7YXfjkl
 1nJD9E2
X-Received: by 2002:a05:6a21:e8c:b0:3c6:3c5b:f2e1 with SMTP id
 adf61e73a8af0-3cc71d8de4dmr8745892637.32.1786729742083; 
 Fri, 14 Aug 2026 10:49:02 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.233.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-320e9df03f9sm6708081eec.19.2026.08.14.10.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 10:49:01 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V12 06/15] monitor: track IOThread users with QOM paths
Date: Sat, 15 Aug 2026 01:48:20 +0800
Message-ID: <20260814174830.1691540-7-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814174830.1691540-1-zhangckid@gmail.com>
References: <20260814174830.1691540-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=zhangckid@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: 26
X-Spam_score: 2.6
X-Spam_bar: ++
X-Spam_report: (2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Monitors that require an IOThread share the internal mon_iothread, but
this relationship is not currently visible through query-iothreads.
Management applications therefore cannot determine which monitors are
using the IOThread.

Acquire the shared monitor IOThread AioContext once, using the monitor
QOM path as the holder, and reuse the stored context for later
operations.

Release the holder during global cleanup and dynamic QMP monitor
deletion to provide an explicit acquire/release lifecycle and prevent
query-iothreads from reporting stale monitor holders.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 monitor/monitor-internal.h |  3 +++
 monitor/monitor.c          | 26 +++++++++++++++++++++-----
 monitor/qmp.c              | 16 ++++++++++++++--
 3 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 23829f32f9..caecceec93 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -153,6 +153,9 @@ struct Monitor {
     guint out_watch;
     int mux_out;
     int reset_seen;
+
+    /* iothread context */
+    AioContext *ctx;
 };
 
 struct MonitorHMPClass {
diff --git a/monitor/monitor.c b/monitor/monitor.c
index ed195fd97b..40944caf9d 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -573,7 +573,7 @@ void monitor_suspend(Monitor *mon)
          * Kick I/O thread to make sure this takes effect.  It'll be
          * evaluated again in prepare() of the watch object.
          */
-        aio_notify(iothread_get_aio_context(mon_iothread));
+        aio_notify(mon->ctx);
     }
 
     trace_monitor_suspend(mon, 1);
@@ -668,6 +668,17 @@ void monitor_cleanup(void)
         qemu_mutex_unlock(&monitor_lock);
         monitor_flush(mon);
         qemu_mutex_lock(&monitor_lock);
+
+        if (monitor_requires_iothread(mon)) {
+            g_autofree char *path = object_get_canonical_path(OBJECT(mon));
+            const IOThreadHolder io_holder = {
+                .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+                .u.qom_object.qom_path = path,
+            };
+
+            iothread_unref_and_put_aio_context(mon_iothread, &io_holder);
+            mon->ctx = NULL;
+        }
         object_unparent(OBJECT(mon));
     }
     qemu_mutex_unlock(&monitor_lock);
@@ -713,7 +724,6 @@ char *monitor_compat_id(void)
 static void monitor_complete(UserCreatable *uc, Error **errp)
 {
     Monitor *mon = MONITOR(uc);
-    AioContext *ctx;
 
     if (mon->chardev_id) {
         Chardev *chr = qemu_chr_find(mon->chardev_id);
@@ -732,11 +742,17 @@ static void monitor_complete(UserCreatable *uc, Error **errp)
             mon_iothread = iothread_create("mon_iothread", &error_abort);
         }
 
-        ctx = iothread_get_aio_context(mon_iothread);
+        g_autofree char *path = object_get_canonical_path(OBJECT(mon));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = path,
+        };
+
+        mon->ctx = iothread_ref_and_get_aio_context(mon_iothread, &io_holder);
     } else {
-        ctx = qemu_get_aio_context();
+        mon->ctx = qemu_get_aio_context();
     }
-    mon->accept_input_bh = aio_bh_new(ctx, monitor_accept_input, mon);
+    mon->accept_input_bh = aio_bh_new(mon->ctx, monitor_accept_input, mon);
 }
 
 int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 338d37cb7e..245f54a3af 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -733,7 +733,8 @@ static void monitor_qmp_complete(UserCreatable *uc, Error **errp)
          * thread.  Schedule a bottom half.
          */
         mon->setup_pending = true;
-        aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
+
+        aio_bh_schedule_oneshot(MONITOR(mon)->ctx,
                                 monitor_qmp_setup_handlers_bh, mon);
         /* The bottom half will add @mon to @mon_list */
     } else {
@@ -788,7 +789,7 @@ static bool monitor_qmp_prepare_delete(UserCreatable *uc, Error **errp)
 
     /* Synchronize with in-flight iothread callbacks. */
     if (monitor_requires_iothread(mon)) {
-        aio_wait_bh_oneshot(iothread_get_aio_context(mon_iothread),
+        aio_wait_bh_oneshot(MONITOR(mon)->ctx,
                             monitor_qmp_iothread_quiesce, NULL);
     }
 
@@ -796,6 +797,17 @@ static bool monitor_qmp_prepare_delete(UserCreatable *uc, Error **errp)
     monitor_qmp_drain_queue(qmp);
     monitor_fdsets_cleanup();
 
+    if (monitor_requires_iothread(mon)) {
+        g_autofree char *path = object_get_canonical_path(OBJECT(mon));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = path,
+        };
+
+        iothread_unref_and_put_aio_context(mon_iothread, &io_holder);
+        mon->ctx = NULL;
+    }
+
     return true;
 }
 
-- 
2.54.0


