Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE96F459F7
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 16:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBENX-0005J5-GE; Fri, 10 Apr 2026 12:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wBEN9-0004Tq-0C
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 12:06:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wBEN3-0006b4-9i
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 12:06:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775837172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tbI06disgDORwnFIFCnFNVYHgBOJm601Ay3torDHaWw=;
 b=DoHsgdCJJE4CU6DRdsXStICLLuxhrKjXQl81UtlwzGCEJfiiQd3X/AvJj0t3p3ukgsoEMK
 jACCg8/D8Xlb7E8JYUio+9ZKfhEWtWrjmYsy1tqakEkzxEKJQr2VJecVyyFd3jv31pQjz+
 YvkmwOWv0dPmUCEE8HJXzd1mfUt0GKs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-OAqwXe0uNwGcXk2Lcwo2Xg-1; Fri,
 10 Apr 2026 12:06:08 -0400
X-MC-Unique: OAqwXe0uNwGcXk2Lcwo2Xg-1
X-Mimecast-MFC-AGG-ID: OAqwXe0uNwGcXk2Lcwo2Xg_1775837167
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C43A18002DA; Fri, 10 Apr 2026 16:06:07 +0000 (UTC)
Received: from toolbx.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 404891956056; Fri, 10 Apr 2026 16:06:04 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Christian Brauner <brauner@kernel.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH 17/17] FIXME: monitor: implement "user creatable" interface
Date: Fri, 10 Apr 2026 17:04:58 +0100
Message-ID: <20260410160458.3778874-18-berrange@redhat.com>
In-Reply-To: <20260410160458.3778874-1-berrange@redhat.com>
References: <20260410160458.3778874-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Implement the user creatable QOM interface and define the monitor-qmp
and monitor-hmp types in QAPI. This unlocks the ability to create them
on the command line with -object or in HMP/QMP with object_add.

For example:

  $QEMU -chardev stdio,id=monchr0 -object monitor-hmp,id=mon0,chrdev=monchr0

FIXME:  object_del is NOT safe on monitors yet. Resolve against
Christian's patches for monitor deletion & synchronization.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 chardev/char.c             | 10 +++++-
 gdbstub/system.c           | 10 ++++--
 include/monitor/monitor.h  |  2 --
 monitor/hmp.c              | 73 ++++++++++++++++++++++++++++++--------
 monitor/monitor-internal.h |  2 ++
 monitor/monitor.c          | 70 +++++++++++++++++++++++++++++-------
 monitor/qmp.c              | 47 ++++++++++++++++++------
 qapi/qom.json              | 43 ++++++++++++++++++++++
 stubs/monitor-internal.c   |  4 ---
 system/vl.c                |  8 ++++-
 10 files changed, 222 insertions(+), 47 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index b59972f325..42eb799d78 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -785,8 +785,16 @@ static Chardev *qemu_chr_new_from_name(const char *label, const char *filename,
     }
 
     if (qemu_opt_get_bool(opts, "mux", 0)) {
+        const char *cdevid = qemu_opts_id(opts);
+        const char *monid = g_strdup_printf("mon%s", cdevid);
         assert(permit_mux_mon);
-        monitor_new_hmp(chr, true, &err);
+        object_new_with_props(TYPE_MONITOR_HMP,
+                              object_get_objects_root(),
+                              monid,
+                              &err,
+                              "chrdev", cdevid,
+                              "readline", "yes",
+                              NULL);
         if (err) {
             error_report_err(err);
             object_unparent(OBJECT(chr));
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 20dcf7878d..03b7bbeffc 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -386,9 +386,15 @@ bool gdbserver_start(const char *device, Error **errp)
         qemu_add_vm_change_state_handler(gdb_vm_state_change, NULL);
 
         /* Initialize a monitor terminal for gdb */
-        mon_chr = qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
+        mon_chr = qemu_chardev_new("gdbchrdev0", TYPE_CHARDEV_GDB,
                                    NULL, NULL, &error_abort);
-        monitor_new_hmp(mon_chr, false, &error_abort);
+        object_new_with_props(TYPE_MONITOR_HMP,
+                              object_get_objects_root(),
+                              "gdbmon0",
+                              &error_abort,
+                              "chrdev", "gdbchrdev0",
+                              "readline", "no",
+                              NULL);
     } else {
         qemu_chr_fe_deinit(&gdbserver_system_state.chr, true);
         mon_chr = gdbserver_system_state.mon_chr;
diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 52df053c6d..dc7f0d0b48 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -28,8 +28,6 @@ Monitor *monitor_set_cur(Coroutine *co, Monitor *mon);
 
 void monitor_init_globals(void);
 void monitor_init_globals_core(void);
-void monitor_new_qmp(Chardev *chr, bool pretty, Error **errp);
-void monitor_new_hmp(Chardev *chr, bool use_readline, Error **errp);
 int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp);
 int monitor_new_opts(QemuOpts *opts, Error **errp);
 void monitor_cleanup(void);
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 387dab2567..02d3ebf7b4 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -38,6 +38,8 @@
 #include "qemu/option.h"
 #include "qemu/target-info.h"
 #include "qemu/units.h"
+#include "qapi/error.h"
+#include "qom/object_interfaces.h"
 #include "exec/gdbstub.h"
 #include "system/block-backend.h"
 #include "trace.h"
@@ -54,16 +56,47 @@ int monitor_hmp_vprintf(Monitor *mon, const char *fmt, va_list ap)
     G_GNUC_PRINTF(2, 0);
 static void monitor_hmp_accept_input(Monitor *mon);
 
+static bool monitor_hmp_get_readline(Object *obj, Error **errp)
+{
+    MonitorHMP *mon = MONITOR_HMP(obj);
+
+    return mon->readline;
+}
+
+static void monitor_hmp_set_readline(Object *obj, bool val, Error **errp)
+{
+    MonitorHMP *mon = MONITOR_HMP(obj);
+
+    mon->readline = val;
+}
+
+static void monitor_hmp_complete(UserCreatable *uc, Error **errp);
+
 static void monitor_hmp_class_init(ObjectClass *cls, const void *data)
 {
     MonitorClass *moncls = MONITOR_CLASS(cls);
+    UserCreatableClass *ucc = USER_CREATABLE_CLASS(cls);
+
+    object_class_property_add_bool(cls, "readline",
+                                   monitor_hmp_get_readline,
+                                   monitor_hmp_set_readline);
 
     moncls->vprintf = monitor_hmp_vprintf;
     moncls->accept_input = monitor_hmp_accept_input;
+
+    ucc->complete = monitor_hmp_complete;
 }
 
 static void monitor_hmp_init(Object *obj)
 {
+    MonitorHMP *hmp = MONITOR_HMP(obj);
+
+    /*
+     * Default to common case for external HMP use,
+     * as opposed to non-interactive internal use
+     * from gdbstub
+     */
+    hmp->readline = true;
 }
 
 int monitor_hmp_vprintf(Monitor *mon, const char *fmt, va_list ap)
@@ -1565,26 +1598,36 @@ static void monitor_readline_flush(void *opaque)
     monitor_flush(&mon->parent);
 }
 
-void monitor_new_hmp(Chardev *chr, bool use_readline, Error **errp)
+static void monitor_hmp_complete(UserCreatable *uc, Error **errp)
 {
-    MonitorHMP *mon = MONITOR_HMP(object_new(TYPE_MONITOR_HMP));
-
-    if (!qemu_chr_fe_init(&mon->parent.chr, chr, errp)) {
-        object_unref(mon);
+    MonitorHMP *mon = MONITOR_HMP(uc);
+    UserCreatableClass *ucc_parent =
+        USER_CREATABLE_CLASS(
+            object_class_get_parent(
+                OBJECT_CLASS(MONITOR_HMP_GET_CLASS(mon))));
+    ERRP_GUARD();
+
+    ucc_parent->complete(uc, errp);
+    if (*errp) {
         return;
     }
 
-    if (use_readline) {
-        mon->rs = readline_init(monitor_readline_printf,
-                                monitor_readline_flush,
-                                mon,
-                                monitor_find_completion);
-        monitor_read_command(mon, 0);
-    }
+    if (mon->parent.chrdev_id) {
+        if (mon->readline) {
+            mon->rs = readline_init(monitor_readline_printf,
+                                    monitor_readline_flush,
+                                    mon,
+                                    monitor_find_completion);
+            monitor_read_command(mon, 0);
+        }
 
-    qemu_chr_fe_set_handlers(&mon->parent.chr, monitor_can_read, monitor_read,
-                             monitor_event, NULL, &mon->parent, NULL, true);
-    monitor_list_append(&mon->parent);
+        qemu_chr_fe_set_handlers(&mon->parent.chr,
+                                 monitor_can_read,
+                                 monitor_read,
+                                 monitor_event, NULL,
+                                 &mon->parent, NULL, true);
+        monitor_list_append(&mon->parent);
+    }
 }
 
 /**
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 7557deb978..200f3ac284 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -104,6 +104,7 @@ struct MonitorClass {
 
 struct Monitor {
     Object parent;
+    char *chrdev_id;
     CharFrontend chr;
     int suspend_cnt;            /* Needs to be accessed atomically */
     bool use_io_thread;
@@ -133,6 +134,7 @@ struct MonitorHMPClass {
 
 struct MonitorHMP {
     Monitor parent;
+    bool readline;
     /*
      * State used only in the thread "owning" the monitor.
      * If @use_io_thread, this is @mon_iothread. (This does not actually happen
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 3860486a32..bbc234d683 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -29,6 +29,7 @@
 #include "qapi/qapi-emit-events.h"
 #include "qapi/qapi-visit-control.h"
 #include "qobject/qdict.h"
+#include "qom/object_interfaces.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "system/qtest.h"
@@ -73,7 +74,8 @@ static GHashTable *coroutine_mon; /* Maps Coroutine* to Monitor* */
 MonitorList mon_list;
 static bool monitor_destroyed;
 
-OBJECT_DEFINE_TYPE(Monitor, monitor, MONITOR, OBJECT);
+OBJECT_DEFINE_TYPE_EXTENDED(Monitor, monitor, MONITOR, OBJECT, true,
+                            { TYPE_USER_CREATABLE }, {});
 
 static void monitor_finalize(Object *obj)
 {
@@ -85,8 +87,45 @@ static void monitor_finalize(Object *obj)
     qemu_mutex_destroy(&mon->mon_lock);
 }
 
+static void monitor_complete(UserCreatable *uc, Error **errp)
+{
+    Monitor *mon = MONITOR(uc);
+
+    if (mon->chrdev_id) {
+        Chardev *chr = qemu_chr_find(mon->chrdev_id);
+        if (chr == NULL) {
+            error_setg(errp, "chardev \"%s\" not found", mon->chrdev_id);
+            return;
+        }
+
+        if (!qemu_chr_fe_init(&mon->chr, chr, errp)) {
+            return;
+        }
+    }
+}
+
+static char *monitor_get_chrdev_id(Object *obj, Error **errp)
+{
+    Monitor *mon = MONITOR(obj);
+
+    return g_strdup(mon->chrdev_id);
+}
+
+static void monitor_set_chrdev_id(Object *obj, const char *str, Error **errp)
+{
+    Monitor *mon = MONITOR(obj);
+
+    mon->chrdev_id = g_strdup(str);
+}
+
 static void monitor_class_init(ObjectClass *cls, const void *data)
 {
+    UserCreatableClass *ucc = USER_CREATABLE_CLASS(cls);
+
+    object_class_property_add_str(cls, "chrdev",
+                                  monitor_get_chrdev_id, monitor_set_chrdev_id);
+
+    ucc->complete = monitor_complete;
 }
 
 static void monitor_init(Object *obj)
@@ -570,7 +609,7 @@ void monitor_list_append(Monitor *mon)
     qemu_mutex_unlock(&monitor_lock);
 
     if (mon) {
-        object_unref(mon);
+        object_unparent(OBJECT(mon));
     }
 }
 
@@ -628,7 +667,7 @@ void monitor_cleanup(void)
         qemu_mutex_unlock(&monitor_lock);
         monitor_flush(mon);
         qemu_mutex_lock(&monitor_lock);
-        object_unref(mon);
+        object_unparent(OBJECT(mon));
     }
     qemu_mutex_unlock(&monitor_lock);
 
@@ -666,13 +705,8 @@ void monitor_init_globals(void)
 int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
 {
     ERRP_GUARD();
-    Chardev *chr;
-
-    chr = qemu_chr_find(opts->chardev);
-    if (chr == NULL) {
-        error_setg(errp, "chardev \"%s\" not found", opts->chardev);
-        return -1;
-    }
+    static int counter;
+    g_autofree char *id = g_strdup_printf("mon%d", counter++);
 
     if (!opts->has_mode) {
         opts->mode = allow_hmp ? MONITOR_MODE_READLINE : MONITOR_MODE_CONTROL;
@@ -680,7 +714,13 @@ int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
 
     switch (opts->mode) {
     case MONITOR_MODE_CONTROL:
-        monitor_new_qmp(chr, opts->pretty, errp);
+        object_new_with_props(TYPE_MONITOR_QMP,
+                              object_get_objects_root(),
+                              id,
+                              errp,
+                              "chrdev", opts->chardev,
+                              "pretty", opts->pretty ? "yes" : "no",
+                              NULL);
         break;
     case MONITOR_MODE_READLINE:
         if (!allow_hmp) {
@@ -691,7 +731,13 @@ int monitor_new(MonitorOptions *opts, bool allow_hmp, Error **errp)
             error_setg(errp, "'pretty' is not compatible with HMP monitors");
             return -1;
         }
-        monitor_new_hmp(chr, true, errp);
+        object_new_with_props(TYPE_MONITOR_HMP,
+                              object_get_objects_root(),
+                              id,
+                              errp,
+                              "chrdev", opts->chardev,
+                              "readline", "yes",
+                              NULL);
         break;
     default:
         g_assert_not_reached();
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 2ec9cca3a6..8fbc55757c 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -31,6 +31,7 @@
 #include "qobject/qdict.h"
 #include "qobject/qjson.h"
 #include "qobject/qlist.h"
+#include "qom/object_interfaces.h"
 #include "trace.h"
 
 /*
@@ -85,13 +86,35 @@ static void monitor_qmp_finalize(Object *obj)
     g_queue_free(mon->qmp_requests);
 }
 
+static bool monitor_qmp_get_pretty(Object *obj, Error **errp)
+{
+    MonitorQMP *mon = MONITOR_QMP(obj);
+
+    return mon->pretty;
+}
+
+static void monitor_qmp_set_pretty(Object *obj, bool val, Error **errp)
+{
+    MonitorQMP *mon = MONITOR_QMP(obj);
+
+    mon->pretty = val;
+}
+
 static void monitor_qmp_emit_event(Monitor *mon, QAPIEvent event, QDict *qdict);
+static void monitor_qmp_complete(UserCreatable *uc, Error **errp);
 
 static void monitor_qmp_class_init(ObjectClass *cls, const void *data)
 {
     MonitorClass *moncls = MONITOR_CLASS(cls);
+    UserCreatableClass *ucc = USER_CREATABLE_CLASS(cls);
+
+    object_class_property_add_bool(cls, "pretty",
+                                   monitor_qmp_get_pretty,
+                                   monitor_qmp_set_pretty);
 
     moncls->emit_event = monitor_qmp_emit_event;
+
+    ucc->complete = monitor_qmp_complete;
 }
 
 static void monitor_qmp_init(Object *obj)
@@ -547,23 +570,27 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
     monitor_list_append(&mon->parent);
 }
 
-void monitor_new_qmp(Chardev *chr, bool pretty, Error **errp)
+static void monitor_qmp_complete(UserCreatable *uc, Error **errp)
 {
-    MonitorQMP *mon = MONITOR_QMP(object_new(TYPE_MONITOR_QMP));
-
-    if (!qemu_chr_fe_init(&mon->parent.chr, chr, errp)) {
-        object_unref(mon);
+    MonitorQMP *mon = MONITOR_QMP(uc);
+    UserCreatableClass *ucc_parent =
+        USER_CREATABLE_CLASS(
+            object_class_get_parent(
+                OBJECT_CLASS(MONITOR_QMP_GET_CLASS(mon))));
+    ERRP_GUARD();
+
+    ucc_parent->complete(uc, errp);
+    if (*errp) {
         return;
     }
+
     qemu_chr_fe_set_echo(&mon->parent.chr, true);
 
     /* Note: we run QMP monitor in I/O thread when @chr supports that */
-    if (qemu_chr_has_feature(chr, QEMU_CHAR_FEATURE_GCONTEXT)) {
+    if (qemu_chr_has_feature(mon->parent.chr.chr, QEMU_CHAR_FEATURE_GCONTEXT)) {
         monitor_iothread_init(&mon->parent);
     }
 
-    mon->pretty = pretty;
-
     qemu_mutex_init(&mon->qmp_queue_lock);
     mon->qmp_requests = g_queue_new();
 
@@ -573,12 +600,12 @@ void monitor_new_qmp(Chardev *chr, bool pretty, Error **errp)
          * Make sure the old iowatch is gone.  It's possible when
          * e.g. the chardev is in client mode, with wait=on.
          */
-        remove_fd_in_watch(chr);
+        remove_fd_in_watch(mon->parent.chr.chr);
         /*
          * Clean up listener IO sources early to prevent racy fd
          * handling between the main thread and the I/O thread.
          */
-        remove_listener_fd_in_watch(chr);
+        remove_listener_fd_in_watch(mon->parent.chr.chr);
         /*
          * We can't call qemu_chr_fe_set_handlers() directly here
          * since chardev might be running in the monitor I/O
diff --git a/qapi/qom.json b/qapi/qom.json
index c653248f85..53264bcd7b 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1179,6 +1179,45 @@
   'data': { '*cpu-affinity': ['uint16'],
             '*node-affinity': ['uint16'] } }
 
+##
+# @MonitorProperties:
+#
+# Properties for all monitors
+#
+# @chrdev: ID of the character device providing the monitor transport
+#
+# Since: 11.1
+##
+{ 'struct': 'MonitorProperties',
+  'data': { 'chrdev': 'str' }}
+
+##
+# @MonitorHMPProperties:
+#
+# Properties for the HMP monitor
+#
+# @readline: whether to enable readline for interactive command
+#      usage (default: enabled)
+#
+# Since: 11.1
+##
+{ 'struct': 'MonitorHMPProperties',
+  'base': 'MonitorProperties',
+  'data': { '*readline': 'bool' } }
+
+##
+# @MonitorQMPProperties:
+#
+# Properties for the QMP monitor
+#
+# @pretty: whether to pretty print JSON responses (default: disabled)
+#
+# Since: 11.1
+##
+{ 'struct': 'MonitorQMPProperties',
+  'base': 'MonitorProperties',
+  'data': { '*pretty': 'bool' } }
+
 ##
 # @ObjectType:
 #
@@ -1229,6 +1268,8 @@
     'memory-backend-ram',
     { 'name': 'memory-backend-shm',
       'if': 'CONFIG_POSIX' },
+    'monitor-hmp',
+    'monitor-qmp',
     'pef-guest',
     { 'name': 'pr-manager-helper',
       'if': 'CONFIG_LINUX' },
@@ -1307,6 +1348,8 @@
       'memory-backend-ram':         'MemoryBackendProperties',
       'memory-backend-shm':         { 'type': 'MemoryBackendShmProperties',
                                       'if': 'CONFIG_POSIX' },
+      'monitor-hmp':                {'type': 'MonitorHMPProperties' },
+      'monitor-qmp':                {'type': 'MonitorQMPProperties' },
       'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
                                       'if': 'CONFIG_LINUX' },
       'qtest':                      'QtestProperties',
diff --git a/stubs/monitor-internal.c b/stubs/monitor-internal.c
index 23d58da184..cbec2f35e0 100644
--- a/stubs/monitor-internal.c
+++ b/stubs/monitor-internal.c
@@ -7,7 +7,3 @@ int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
     error_setg(errp, "only QEMU supports file descriptor passing");
     return -1;
 }
-
-void monitor_new_hmp(Chardev *chr, bool use_readline, Error **errp)
-{
-}
diff --git a/system/vl.c b/system/vl.c
index 2391811a46..e772e1401f 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1823,6 +1823,10 @@ static void object_option_add_visitor(Visitor *v)
 {
     ObjectOption *opt = g_new0(ObjectOption, 1);
     visit_type_ObjectOptions(v, NULL, &opt->opts, &error_fatal);
+    if (opt->opts->qom_type == OBJECT_TYPE_MONITOR_HMP ||
+        opt->opts->qom_type == OBJECT_TYPE_MONITOR_QMP) {
+        default_monitor = 0;
+    }
     QTAILQ_INSERT_TAIL(&object_opts, opt, next);
 }
 
@@ -1964,7 +1968,9 @@ static bool object_create_early(const char *type)
 
     /* Reason: property "chardev" */
     if (g_str_equal(type, "rng-egd") ||
-        g_str_equal(type, "qtest")) {
+        g_str_equal(type, "qtest") ||
+        g_str_equal(type, "monitor-hmp") ||
+        g_str_equal(type, "monitor-qmp")) {
         return false;
     }
 
-- 
2.53.0


