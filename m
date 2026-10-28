Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32077606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TepfgaW2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLzvi-0006uU-Dz; Wed, 28 Oct 2026 05:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xLzvh-0006uG-8M
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:26:45 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xLzvf-0006gs-Av
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 05:26:44 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2e977109392so3944485ad.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 02:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793179602; x=1793784402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z6NPgdWLsRUq67VzDfdjGLEAOiiCTDpko8uhmoQSOs0=;
 b=TepfgaW2+q6hbVhRzqICJUfWUsiAaN54LHtSOwtGpwkfGU2bMxvVZvzmcCz/SbBmpr
 mIj86WBD1VtsW/XoPpAZW5eb/lzXmDYLythWOTsqKW/O/bSXZ0/9/kGJUGDGZAFru3xp
 oe4cdje17Q0a8YQITaOLebSVUtFaKO5SicVl8wVaiNGdp+bJf+UfS7fv6kZY7Uirt2Hw
 v3kuI8NUOgxQY0FFEz8UeLTVgnSANKmQYdK6ke1wU45E82Do+k0h1ozGx3sTaIUpAxWG
 V+WAGX0c4O87JhlGup/hOVV6yrdU/aY35xUaE7mx7eZnIc3uFO+50Qnsz1WlMJvNjf+E
 MY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793179602; x=1793784402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=z6NPgdWLsRUq67VzDfdjGLEAOiiCTDpko8uhmoQSOs0=;
 b=UDVKK09W8x3ygNVksjY5QpbYeK29SHrg1E7qIN24g5xhjodhnD2NneAjRaGH+N/T++
 cqoQ8PT4ZJ9tHd4rvVGxE6WC8QJmV7qb8AafwuEqjJ54n2zadLrjb5PrjluFI7b6afji
 z17TE0a4NrZbFwRdP4Wg3htZHaOLR9S1xnuhK+3Nwtkjh/yI/IIqX/cZJSs3GPKrnJ6h
 LRwt7VLDDCSAexiQeODH8LrZD4M6Ohf+0Up+uN+kBeoQoBmR+N1qcKQ0+07kBvccTRtQ
 8PmV89533NG1dIY0FRjAv0bypRKN1dwwI6oDgv3rL0rqqHoX/f5l10DegGgOEY9KJ7WA
 4u3g==
X-Gm-Message-State: AFq9FYKpdsoPg76n5Xt+gZJh58at4yGSwF1tObtmYn70bfFKE+lSWWQU
 aWYja+VQRPBH+FxrydfQhAp7IyBIGeYjV8/BmjjdyTjfxRPf54+p1YoN16QS28EI
X-Gm-Gg: AYBFou3N+L5E4DimvI1me6VZjfZRHgKPxq4YekM4qST6FugcF9f9ca2vymKjcGn4Z3K
 dFxbWXXA3zD9eHDGtFRDVm1FWJTc5YaKJhstiX0kcwUMJuMLojFEvGq+koHYoVNrZvPQkeozlrx
 3/yT+GGMQlBPH/Sz2U+oV31aedO7gL5E1N1Hjh+eel9Qxeg3JqD/C+OTI6Wrz3/ZxWYntD1Zwl0
 OPPC4F9LAnbsug2aO4S+u8bw/JpWgjWaWdI5Fa1Y0v+765m0Zvw1uMKdPhkFlSesJEzYDpLuWsb
 YMO56wRxquxnyELJyzThHb2r8bDSW3A+2Iwc4wrtfFlx2brnHQ74qs2ZF5gE591I8XZUfo2shck
 QyL+Y9Og9uEJOuO2mSoyXrwRBHOXZKk1MtrINqetGf3FMyET7pEbEaal3MsXZWd/9jx9hVwms70
 OjgbC5ik1/VawFUulzlEgXyUXKfAf3pRXKlVchAN5Qhnqaoc5OwuNJuxFFB4OYEh2p3Nt1pjAyx
 CErtFFX2LAR/76YbPe5Q02vHPVFUsJk8tsaQHGhCqJ3BO09vl6ozZIxLXzqqhgzvwGw4aZsPzto
 RHG783sAU4ISq4pcI+Jc2LpO7MLGfHYtfyyv8rX01HDfCd0U1wU0KrdqnvY=
X-Received: by 2002:a17:903:8c4:b0:2e2:e3aa:7a35 with SMTP id
 d9443c01a7336-2eb004fe87dmr17468265ad.36.1793179601713; 
 Wed, 28 Oct 2026 02:26:41 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6b7a691sm19481635ad.26.2026.10.28.02.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 02:26:40 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V19 04/14] monitor: track IOThread users with QOM paths
Date: Wed, 28 Oct 2026 17:26:09 +0800
Message-ID: <20261028092619.1654474-5-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028092619.1654474-1-zhangckid@gmail.com>
References: <20261028092619.1654474-1-zhangckid@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Monitors that require an IOThread share the internal mon_iothread.
Account for each monitor explicitly in IOThread holder tracking, using
the monitor's canonical QOM path to distinguish holders.

Acquire the shared monitor IOThread AioContext once and store the
IOThread and canonical QOM path so the holder can be released after the
monitor has been removed from the QOM tree. Use the stored IOThread for
per-monitor checks and accesses after initialization, and reuse the
stored context for later operations.

Release the holder from monitor_finalize(), after resources associated
with the AioContext have been destroyed. This pairs the reference taken
in complete() with instance finalization and keeps the IOThread alive
throughout monitor teardown.

The internal mon_iothread remains hidden from query-iothreads, as before.
Management applications therefore cannot use it to determine which
monitors are using the IOThread. Nevertheless, track the monitor
holders so that they follow the same explicit holder and
IOThread reference lifecycle as other AioContext users.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 monitor/monitor-internal.h |  7 +++++--
 monitor/monitor.c          | 36 ++++++++++++++++++++++++++----------
 monitor/qmp.c              | 14 +++++++-------
 3 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 822a66d06d..856948067b 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -77,6 +77,11 @@ struct Monitor {
     GString *outbuf;
     guint out_watch;
     int mux_out;
+
+    /* iothread context and holder identity */
+    IOThread *iothread;
+    char *qom_path;
+    AioContext *ctx;
 };
 
 struct MonitorQMPClass {
@@ -109,14 +114,12 @@ struct MonitorQMP {
 };
 
 typedef QTAILQ_HEAD(MonitorList, Monitor) MonitorList;
-extern IOThread *mon_iothread;
 extern Coroutine *qmp_dispatcher_co;
 extern bool qmp_dispatcher_co_shutdown;
 extern QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
 extern QemuMutex monitor_lock;
 extern MonitorList mon_list;
 
-bool monitor_requires_iothread(const Monitor *mon);
 int monitor_can_read(void *opaque);
 void monitor_cancel_out_watch(Monitor *mon);
 void monitor_list_append(Monitor *mon);
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 2654b81890..4e2b96b2e8 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -55,7 +55,7 @@ typedef struct {
 } MonitorQAPIEventConf;
 
 /* Shared monitor I/O thread */
-IOThread *mon_iothread;
+static IOThread *mon_iothread;
 
 /* Coroutine to dispatch the requests received from I/O thread */
 Coroutine *qmp_dispatcher_co;
@@ -93,6 +93,16 @@ static void monitor_finalize(Object *obj)
     qemu_chr_fe_deinit(&mon->chr, false);
     g_string_free(mon->outbuf, true);
     qemu_mutex_destroy(&mon->mon_lock);
+
+    if (mon->iothread) {
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = mon->qom_path,
+        };
+
+        iothread_unref_and_put_aio_context(mon->iothread, &io_holder);
+    }
+    g_free(mon->qom_path);
 }
 
 static char *monitor_get_chardev_id(Object *obj, Error **errp)
@@ -164,7 +174,7 @@ Monitor *monitor_set_cur(Coroutine *co, Monitor *mon)
     return old_monitor;
 }
 
-bool monitor_requires_iothread(const Monitor *mon)
+static bool monitor_requires_iothread(const Monitor *mon)
 {
     MonitorClass *cls = MONITOR_GET_CLASS(mon);
     return cls->requires_iothread && cls->requires_iothread(mon);
@@ -188,8 +198,8 @@ void monitor_cancel_out_watch(Monitor *mon)
         GMainContext *ctx = NULL;
         GSource *src;
 
-        if (monitor_requires_iothread(mon)) {
-            ctx = iothread_get_g_main_context(mon_iothread);
+        if (mon->iothread) {
+            ctx = iothread_get_g_main_context(mon->iothread);
         }
         src = g_main_context_find_source_by_id(ctx, mon->out_watch);
         if (!src && ctx) {
@@ -516,12 +526,12 @@ void monitor_suspend(Monitor *mon)
 {
     qatomic_inc(&mon->suspend_cnt);
 
-    if (monitor_requires_iothread(mon)) {
+    if (mon->iothread) {
         /*
          * Kick I/O thread to make sure this takes effect.  It'll be
          * evaluated again in prepare() of the watch object.
          */
-        aio_notify(iothread_get_aio_context(mon_iothread));
+        aio_notify(mon->ctx);
     }
 
     trace_monitor_suspend(mon, 1);
@@ -661,7 +671,6 @@ char *monitor_compat_id(void)
 static void monitor_complete(UserCreatable *uc, Error **errp)
 {
     Monitor *mon = MONITOR(uc);
-    AioContext *ctx;
 
     if (mon->chardev_id) {
         Chardev *chr = qemu_chr_find(mon->chardev_id);
@@ -680,11 +689,18 @@ static void monitor_complete(UserCreatable *uc, Error **errp)
             mon_iothread = iothread_create("mon_iothread", &error_abort);
         }
 
-        ctx = iothread_get_aio_context(mon_iothread);
+        mon->iothread = mon_iothread;
+        mon->qom_path = object_get_canonical_path(OBJECT(mon));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = mon->qom_path,
+        };
+
+        mon->ctx = iothread_ref_and_get_aio_context(mon->iothread, &io_holder);
     } else {
-        ctx = qemu_get_aio_context();
+        mon->ctx = qemu_get_aio_context();
     }
-    mon->accept_input_bh = aio_bh_new(ctx, monitor_accept_input, mon);
+    mon->accept_input_bh = aio_bh_new(mon->ctx, monitor_accept_input, mon);
 }
 
 int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
diff --git a/monitor/qmp.c b/monitor/qmp.c
index eb44012643..b8c6c8b9d2 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -187,7 +187,7 @@ static void monitor_qmp_caps_reset(MonitorQMP *mon)
     memset(mon->capab_offered, 0, sizeof(mon->capab_offered));
     memset(mon->capab, 0, sizeof(mon->capab));
     mon->capab_offered[QMP_CAPABILITY_OOB] =
-        monitor_requires_iothread(MONITOR(mon));
+        MONITOR(mon)->iothread != NULL;
 }
 
 static void qmp_request_free(QMPRequest *req)
@@ -679,8 +679,8 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
     MonitorQMP *mon = opaque;
     GMainContext *context;
 
-    assert(monitor_requires_iothread(MONITOR(mon)));
-    context = iothread_get_g_main_context(mon_iothread);
+    assert(MONITOR(mon)->iothread);
+    context = iothread_get_g_main_context(MONITOR(mon)->iothread);
     assert(context);
     qemu_chr_fe_set_handlers(&mon->parent_obj.chr, monitor_can_read,
                              monitor_qmp_read, monitor_qmp_event,
@@ -718,7 +718,7 @@ static void monitor_qmp_complete(UserCreatable *uc, Error **errp)
 
     qemu_chr_fe_set_echo(&mon->parent_obj.chr, true);
 
-    if (monitor_requires_iothread(MONITOR(mon))) {
+    if (MONITOR(mon)->iothread) {
         /*
          * Make sure the old iowatch is gone.  It's possible when
          * e.g. the chardev is in client mode, with wait=on.
@@ -735,7 +735,7 @@ static void monitor_qmp_complete(UserCreatable *uc, Error **errp)
          * thread.  Schedule a bottom half.
          */
         mon->setup_pending = true;
-        aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
+        aio_bh_schedule_oneshot(MONITOR(mon)->ctx,
                                 monitor_qmp_setup_handlers_bh, mon);
         /* The bottom half will add @mon to @mon_list */
     } else {
@@ -789,8 +789,8 @@ static bool monitor_qmp_prepare_delete(UserCreatable *uc, Error **errp)
     }
 
     /* Synchronize with in-flight iothread callbacks. */
-    if (monitor_requires_iothread(mon)) {
-        aio_wait_bh_oneshot(iothread_get_aio_context(mon_iothread),
+    if (mon->iothread) {
+        aio_wait_bh_oneshot(mon->ctx,
                             monitor_qmp_iothread_quiesce, NULL);
     }
 
-- 
2.53.0


