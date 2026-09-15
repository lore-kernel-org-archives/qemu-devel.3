Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9BAC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:19:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6QEf-0003Lq-0h; Tue, 15 Sep 2026 06:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x6QET-0003K3-Iz
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:17:46 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x6QEC-0002wo-4S
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 06:17:45 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-398beb616f5so1185829a91.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 03:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789467441; x=1790072241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JoV/L3vaZSj9f3RbohvwlCdSIoQZKn965jasW56Se3c=;
 b=n8pyuYvxvSIhyaz/BBykDQlarifpjIIKdnbizMt0+8P1bF3irLnfSHI5Dnwgm6dYV+
 0AEgW5Y8LJ0Hcfi8ZJyz4BMIqov/LzgB/uK/OxgW/s1IA/2afnvWMtXG/UxGDWc3AVNg
 yZ90n7ON3arHartn0431q6UNg5Q73wIbzmbLN6P4ONiNANoItReVPvrmmhNmTpYKiNXY
 /OCXx3GPRnGwvya1Eg96ymDNVi2Ypa7kv5J9N0HyWnuNwfIgw6Jm68dw41xaua8GwW3g
 RcUNqRWB3IZ1WJQhJUrLy9ea6usZaPi/IIjm3sjo08azuC6NX/0DFZw8yzCWVNt0lXll
 byWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789467441; x=1790072241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JoV/L3vaZSj9f3RbohvwlCdSIoQZKn965jasW56Se3c=;
 b=PIhF3rBkOt31ojW3xogtMTeOOPSpfRBrcXjZvpgO11/Gm5d5FYvzdFvmXlgBUx4GBz
 AsMuqk2PWhOR9DO9iar0VUW0F1n6TjTdpcxChq06O17yeCc7KkmSMB+iEMfNJfWRR3zx
 O+uvirMz/oKO7hebQEGdlpd6tm607Mu0QynQ/wEBAJbqfXODgmHujA9p5pOQ048L9e2w
 pNMzjyStfKyG8XTyQ+mhi/sHEcfWU4nA9O+/xL+jTqUAr0MUbj45nE8LeyaZ4w3vJJiL
 BqmtrhXT9obPVMX31jVm6Bkj9sXVJ+Xn+BVG01N+Mt7Q4/6JysQwqGMW3MXFQkmbNx2x
 Pe5w==
X-Gm-Message-State: AFuF++niUnzQirU6r+5rwndR6NvuJqys41ICWDg5MLbF/RaFhepu3f0O
 CNCdidqV0BNpFjz3oCoTZIMWLtTYqIWYrnd3lAQhWWYo6+SBYgKo5+y/OCbKSA==
X-Gm-Gg: AYBFou2IqkGTOuxCrxQAi7rulTXMd+gViZK8oedEcUoI4pS0T9RogUOKR3A0+QrcfYm
 Zd2sSDxHjKFl6DAbCSbLz7heuNQIXb3npgO/Ew2H4SoH9F2QAXV7uqx3ZY1jb0ml5lf5lXP9pIy
 PN91T/2zvUnwTxnjORMor7B2D5myrrck70kEl+yI5Qnz4oTbJ8J3vhIUYz1UhQvNbaPcuW67r8Y
 S2tZMt3v6lvwc7Fp/8ZqWTdQj54jdphiiguiRgJ4uIQ8oP+/VkGORkegBwwfenrAt7vuoL5q9Bz
 K4xIvY4iMBbxgJ93YSOHR3D03mfZfrmt0upeYYpyrgqDXLpVnvBa5LfVdOifZmsWQgpQ6gRC/W0
 TlPUmRn1KIKYcvMd3PuTBkrZRICo6lj1+fRTbATX+NB7Z+2zkeD6Ayek5+YwRNDg+8FDHxxT+vz
 hIPLkxMadQp2VPLfHM3ehqBX1Ok23csS1Y7qri4fwtZuDskMP27E30PsQPoEpxIyKzuPLKWFf1F
 TRprCj3HSIgjZayh7rC5RmfnaZ8
X-Received: by 2002:a17:90b:2e49:b0:38e:7297:a92e with SMTP id
 98e67ed59e1d1-39dfe0e21efmr3481012a91.9.1789467441242; 
 Tue, 15 Sep 2026 03:17:21 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdacba6bsm4416868a91.14.2026.09.15.03.17.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 03:17:20 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V17 04/13] monitor: track IOThread users with QOM paths
Date: Tue, 15 Sep 2026 18:16:46 +0800
Message-ID: <20260915101655.3216101-5-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915101655.3216101-1-zhangckid@gmail.com>
References: <20260915101655.3216101-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=zhangckid@gmail.com; helo=mail-pj2-x10.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

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
---
 monitor/monitor-internal.h |  7 +++++--
 monitor/monitor.c          | 36 ++++++++++++++++++++++++++----------
 monitor/qmp.c              | 14 +++++++-------
 3 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 822a66d06d..020afdaebf 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -77,6 +77,11 @@ struct Monitor {
     GString *outbuf;
     guint out_watch;
     int mux_out;
+
+    /* iothread context and holder identity */
+    IOThread *iothread;
+    char *iothread_qom_path;
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
index 2654b81890..a80d8dbf45 100644
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
+            .u.qom_object.qom_path = mon->iothread_qom_path,
+        };
+
+        iothread_unref_and_put_aio_context(mon->iothread, &io_holder);
+    }
+    g_free(mon->iothread_qom_path);
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
+        mon->iothread_qom_path = object_get_canonical_path(OBJECT(mon));
+        const IOThreadHolder io_holder = {
+            .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+            .u.qom_object.qom_path = mon->iothread_qom_path,
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
index aec0315775..e235302fb3 100644
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
@@ -678,8 +678,8 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
     MonitorQMP *mon = opaque;
     GMainContext *context;
 
-    assert(monitor_requires_iothread(MONITOR(mon)));
-    context = iothread_get_g_main_context(mon_iothread);
+    assert(MONITOR(mon)->iothread);
+    context = iothread_get_g_main_context(MONITOR(mon)->iothread);
     assert(context);
     qemu_chr_fe_set_handlers(&mon->parent_obj.chr, monitor_can_read,
                              monitor_qmp_read, monitor_qmp_event,
@@ -717,7 +717,7 @@ static void monitor_qmp_complete(UserCreatable *uc, Error **errp)
 
     qemu_chr_fe_set_echo(&mon->parent_obj.chr, true);
 
-    if (monitor_requires_iothread(MONITOR(mon))) {
+    if (MONITOR(mon)->iothread) {
         /*
          * Make sure the old iowatch is gone.  It's possible when
          * e.g. the chardev is in client mode, with wait=on.
@@ -734,7 +734,7 @@ static void monitor_qmp_complete(UserCreatable *uc, Error **errp)
          * thread.  Schedule a bottom half.
          */
         mon->setup_pending = true;
-        aio_bh_schedule_oneshot(iothread_get_aio_context(mon_iothread),
+        aio_bh_schedule_oneshot(MONITOR(mon)->ctx,
                                 monitor_qmp_setup_handlers_bh, mon);
         /* The bottom half will add @mon to @mon_list */
     } else {
@@ -788,8 +788,8 @@ static bool monitor_qmp_prepare_delete(UserCreatable *uc, Error **errp)
     }
 
     /* Synchronize with in-flight iothread callbacks. */
-    if (monitor_requires_iothread(mon)) {
-        aio_wait_bh_oneshot(iothread_get_aio_context(mon_iothread),
+    if (mon->iothread) {
+        aio_wait_bh_oneshot(mon->ctx,
                             monitor_qmp_iothread_quiesce, NULL);
     }
 
-- 
2.43.0


