Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7916C60A383B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=g9Pw89x2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP1Aw-00072p-3z; Thu, 05 Nov 2026 12:22:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xP1Au-00072K-Ar
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 12:22:56 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xP1As-0007fc-19
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 12:22:56 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso19617065e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 09:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1793899372; x=1794504172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vCLPlRJ81XQrPsBTKtdwfyyvMSqUUn2sQiVHXVC+80c=;
 b=g9Pw89x2xVE7RzHMdi3K5G/CCKyvmQKl0vNQahc8DctqSNH17kgiAlzSgCMSnPbPgC
 PNwVQyuQWbCz17Cmn5aWfBiSypjWertmME20D8+J0G4h/7JoQBRAh+yUAfgO0izMA6cu
 e4RhP7HZdJUEyxrLmTjJ9bCFd8LCZOyUW3v8TkNifXuG+uft0b74hOwdariNLU59CA84
 vjt03PEoHjhaZMzfDoA4h7gP7SHDYVjoSn9RDz1i84glDggnW6UCJlANHOwp9dRmJBd9
 xT/5TIw53SfN0Vkf35H7j4uOUO9sfwrGYy864HgY/pXUeYH0D0CNAgiWPqAJ6JzMinwG
 OB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793899372; x=1794504172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vCLPlRJ81XQrPsBTKtdwfyyvMSqUUn2sQiVHXVC+80c=;
 b=Ny/ngmObLOOixk8fpbjmTIiHf4dpDxv2tt+QIwcq5El8L4NKnXAk4xbdhrl2FoOd7T
 USsfZPwNylXhWJFV+dzFTJZbG1T4WsI09VzoxlyZx6Q5XqUDMZ5BtEZ47H8MXCF+MGSs
 WpbeH3svhTG5mPirjkUD0PszwmjwwqErT/JmTzCmylOSRDXJN+/noKeX+Z5B0e1D9Vn6
 sJLrlU8JWVk6xr6LfUzDckhxLBpORj70szINi+/kUmaAiyAJc39bkSqbJPyC+pJzDy9J
 IfOiXv/9Co0HhOdQFE926wCPqzzUuFC+RRv88VocJZCILKv1Hh3Yjn/goQdoe+jaoZcy
 30Ow==
X-Gm-Message-State: APuU4Z8YNYh8/dSnjJzV0P59yzb9uHq2+XijE1d3EIneOuUuLEP73HCE
 Aoa4SbA1roUWgY7hAGjF0HxATZXCoSXqTw0vyTpfUphEkEci0Xb2P5OqgBFEcKLgv8ahUKKE3Vl
 MHhb5
X-Gm-Gg: AYBFou2BJPtaP7uMMotM4v/IzjOqLF/hA51OoFTY30dfl2AzwH+AFYxRVvplyxAP9XD
 ERafCDviRkfdSGtK1us6NIXTiw+s0+T+MgmEbjzg2YtbeLhC6/VdkVcobQ0yjbYueIp29ZW4ori
 D0gRG4rLQBczUFohi2MSzgAy6vOc6yIc74teVfmsVvm+MG5fxJ7CvdFQpRgu7RiX3PAd7qCFrUM
 yD/RYznP4s2r2V+6npGp22N+l2gwLpnepf8yXYstQJnS8x2zBeES15mzceP1t3UETdeI0ScssD0
 4YzmJVoO/8srGMSLnXVwrxyLzzSNJWx5n8MgRHjUDucelDCvC/JMMz8W1gnUmZJsI0xXn6G/5jl
 rwlnda9e9W1ksHFVADVrDAUoIItFwe8H2El/WbpURTk9v0IR2DDiAu/L0cTZi4EZzbdsneUIRo8
 SDVYVpJu4lj9p1Gbd62bNz+IIbfjW+My9sz+ks2oQDfgVA5GeTBh5f63sEy8U+RtVa+apuo/vBf
 jnB6Grn712cZPaurYptKbnZOFBqX9tFOq6Zo09qwx42KYAH3i3rqmB8TFzoueDHWSRwUFmAdks7
 bd7iKB3up1GVzxzgJZK7FUEaJA==
X-Received: by 2002:a05:600c:e555:10b0:4b4:49d7:bc62 with SMTP id
 5b1f17b1804b1-4b449d7bfa3mr71291885e9.26.1793899372447; 
 Thu, 05 Nov 2026 09:22:52 -0800 (PST)
Received: from athena.sw.ru ([2a06:5b06:b600:300:3848:9c8a:8cf7:6236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56e2ae72dsm130632255e9.3.2026.11.05.09.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 09:22:51 -0800 (PST)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Denis V. Lunev" <den@virtuozzo.com>
Subject: [PATCH v2 4/6] migration: add post_load_mr_update to batch region
 remaps on load
Date: Thu,  5 Nov 2026 18:22:42 +0100
Message-ID: <20261105172244.2804598-5-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911142345.3999518-1-den@openvz.org>
References: <20260911142345.3999518-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=den@openvz.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Denis V. Lunev <den@openvz.org>

A post_load hook which maps or unmaps a memory region commits a memory
transaction, and each commit regenerates the flatviews it touches at a
cost which grows with the number of regions in the machine. A device
which remaps per vCPU, as the Hyper-V SynIC does, pays that once per
vCPU on the destination.

Add a post_load_mr_update callback, called after post_load, which only
brings the device's memory regions in line with the state post_load
restored. During a load the calls are queued and made in stream order
inside one memory transaction, once the device state has been read and
before the guest can start: at the end of qemu_loadvm_state() for
precopy, snapshot and xen loads, and for postcopy in the POSTCOPY_RUN
handler, before the bottom half which starts the guest is scheduled.
The queue is run even when the load fails, as the calls would have been
made inline.

The update is a callback of its own rather than a way to defer
post_load, so that only the region work moves and the device state
other sections read is restored where it always was. What may go in it
is then checkable by reading it: nothing else in the load may depend on
the regions it maps, and a lookup made during the batch resolves
against the topology from before it. It cannot fail, so error reporting
of the load is unchanged.

The batch spans the load rather than one device because a remap which
repeats per vCPU sits in a per-vCPU section, and no smaller unit of the
stream covers the repeats.

Only the thread which opened the batch queues. The postcopy listen
thread, which reads the stream while the package is processed, makes
any call it reaches at once.

CC: Peter Xu <peterx@redhat.com>
CC: Fabiano Rosas <farosas@suse.de>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Denis V. Lunev <den@virtuozzo.com>
---
 include/migration/vmstate.h |  30 ++++++++++
 migration/savevm.c          |  12 ++++
 migration/vmstate.c         |  50 +++++++++++++++++
 tests/unit/test-vmstate.c   | 109 ++++++++++++++++++++++++++++++++++++
 4 files changed, 201 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 2901877308..9f7ae1a224 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -305,6 +305,19 @@ struct VMStateDescription {
     bool (*pre_load_errp)(void *opaque, Error **errp);
     int (*post_load)(void *opaque, int version_id);
     bool (*post_load_errp)(void *opaque, int version_id, Error **errp);
+
+    /*
+     * Maps, unmaps or moves the device's memory regions to match the state
+     * restored by .post_load() or .post_load_errp(), and does nothing else.
+     *
+     * Called after the post_load hook. During a load the calls are batched:
+     * they run once the device state has been read and before the guest can
+     * start, in stream order, inside one memory transaction, so the load
+     * rebuilds the topology once rather than once per call. Nothing else in
+     * the load may depend on the regions mapped here, and a lookup made
+     * during the batch resolves against the topology from before it.
+     */
+    void (*post_load_mr_update)(void *opaque);
     int (*pre_save)(void *opaque);
     bool (*pre_save_errp)(void *opaque, Error **errp);
 
@@ -1291,6 +1304,23 @@ bool vmstate_save_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
 
 bool vmstate_section_needed(const VMStateDescription *vmsd, void *opaque);
 
+/**
+ * vmstate_mr_update_batch_begin: Batch post_load_mr_update calls
+ *
+ * Until vmstate_mr_update_batch_end(), a post_load_mr_update call reached
+ * from the calling thread is queued rather than made. Other threads still
+ * make it at once.
+ */
+void vmstate_mr_update_batch_begin(void);
+
+/**
+ * vmstate_mr_update_batch_end: Make the queued post_load_mr_update calls
+ *
+ * Makes them in the order they were queued. Does nothing if no batch is
+ * open.
+ */
+void vmstate_mr_update_batch_end(void);
+
 #define  VMSTATE_INSTANCE_ID_ANY  -1
 
 /* Returns: 0 on success, -1 on failure */
diff --git a/migration/savevm.c b/migration/savevm.c
index ac48db7754..910199b868 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2226,6 +2226,13 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis,
     return rc;
 }
 
+static void loadvm_run_mr_updates(void)
+{
+    memory_region_transaction_begin();
+    vmstate_mr_update_batch_end();
+    memory_region_transaction_commit();
+}
+
 static void loadvm_postcopy_handle_run_bh(void *opaque)
 {
     MigrationIncomingState *mis = opaque;
@@ -2276,6 +2283,8 @@ static int loadvm_postcopy_handle_run(MigrationIncomingState *mis, Error **errp)
         return -1;
     }
 
+    loadvm_run_mr_updates();
+
     /* We might be already in POSTCOPY_ACTIVE if there is no return path */
     if (mis->state == MIGRATION_STATUS_POSTCOPY_DEVICE) {
         migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
@@ -3153,9 +3162,12 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
      * vm_prepare_start() closes it again before anything runs.
      */
     flatview_dispatch_defer_begin();
+    vmstate_mr_update_batch_begin();
 
     ret = qemu_loadvm_state_main(f, mis, errp);
 
+    loadvm_run_mr_updates();
+
     flatview_dispatch_defer_end();
 
     qemu_event_set(&mis->main_thread_load_event);
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 24004565bf..f4a3ae3552 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -18,6 +18,7 @@
 #include "qobject/json-writer.h"
 #include "qemu-file.h"
 #include "qemu/bitops.h"
+#include "qemu/coroutine-tls.h"
 #include "qemu/error-report.h"
 #include "trace.h"
 
@@ -250,6 +251,51 @@ static bool vmstate_load_field(QEMUFile *f, void *pv, size_t size,
     return true;
 }
 
+typedef struct VMStateMRUpdate {
+    void (*fn)(void *opaque);
+    void *opaque;
+    QSIMPLEQ_ENTRY(VMStateMRUpdate) entry;
+} VMStateMRUpdate;
+
+static QSIMPLEQ_HEAD(, VMStateMRUpdate) vmstate_mr_updates =
+    QSIMPLEQ_HEAD_INITIALIZER(vmstate_mr_updates);
+QEMU_DEFINE_STATIC_CO_TLS(bool, vmstate_mr_update_batching);
+
+void vmstate_mr_update_batch_begin(void)
+{
+    assert(!get_vmstate_mr_update_batching());
+    assert(QSIMPLEQ_EMPTY(&vmstate_mr_updates));
+    set_vmstate_mr_update_batching(true);
+}
+
+void vmstate_mr_update_batch_end(void)
+{
+    VMStateMRUpdate *u;
+
+    set_vmstate_mr_update_batching(false);
+
+    while ((u = QSIMPLEQ_FIRST(&vmstate_mr_updates))) {
+        QSIMPLEQ_REMOVE_HEAD(&vmstate_mr_updates, entry);
+        u->fn(u->opaque);
+        g_free(u);
+    }
+}
+
+static void vmstate_mr_update(const VMStateDescription *vmsd, void *opaque)
+{
+    VMStateMRUpdate *u;
+
+    if (!get_vmstate_mr_update_batching()) {
+        vmsd->post_load_mr_update(opaque);
+        return;
+    }
+
+    u = g_new(VMStateMRUpdate, 1);
+    u->fn = vmsd->post_load_mr_update;
+    u->opaque = opaque;
+    QSIMPLEQ_INSERT_TAIL(&vmstate_mr_updates, u, entry);
+}
+
 static bool vmstate_post_load(const VMStateDescription *vmsd,
                               void *opaque, int version_id, Error **errp)
 {
@@ -274,6 +320,10 @@ static bool vmstate_post_load(const VMStateDescription *vmsd,
         }
     }
 
+    if (vmsd->post_load_mr_update) {
+        vmstate_mr_update(vmsd, opaque);
+    }
+
     return true;
 }
 
diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
index 23f3173070..975032c2d7 100644
--- a/tests/unit/test-vmstate.c
+++ b/tests/unit/test-vmstate.c
@@ -29,6 +29,7 @@
 #include "../migration/qemu-file.h"
 #include "../migration/savevm.h"
 #include "qemu/module.h"
+#include "qemu/thread.h"
 #include "io/channel-file.h"
 #include "qapi/error.h"
 
@@ -1561,6 +1562,113 @@ static void test_tmp_struct(void)
     g_assert_cmpint(obj.f, ==, 8); /* From the child->parent */
 }
 
+/* Batched post_load_mr_update calls */
+
+static int mr_order;
+static int mr_a_post_load_ran;
+static int mr_a_ran;
+static int mr_b_ran;
+
+static int mr_a_post_load(void *opaque, int version_id)
+{
+    mr_a_post_load_ran = ++mr_order;
+    return 0;
+}
+
+static void mr_a_update(void *opaque)
+{
+    mr_a_ran = ++mr_order;
+}
+
+static void mr_b_update(void *opaque)
+{
+    mr_b_ran = ++mr_order;
+}
+
+static const VMStateDescription vmstate_mr_a = {
+    .name = "test/mr_a",
+    .version_id = 1,
+    .post_load = mr_a_post_load,
+    .post_load_mr_update = mr_a_update,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(a, TestStruct),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_mr_b = {
+    .name = "test/mr_b",
+    .version_id = 1,
+    .post_load_mr_update = mr_b_update,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(a, TestStruct),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const uint8_t mr_wire[] = {
+    /* uint32 a */ 0x00, 0x00, 0x00, 0x01,
+    QEMU_VM_EOF,
+};
+
+static void mr_reset(void)
+{
+    mr_order = 0;
+    mr_a_post_load_ran = 0;
+    mr_a_ran = 0;
+    mr_b_ran = 0;
+}
+
+static void *mr_load_thread(void *opaque)
+{
+    SUCCESS(load_vmstate_one(&vmstate_mr_a, opaque, 1, mr_wire,
+                             sizeof(mr_wire)));
+    return NULL;
+}
+
+static void mr_load(const VMStateDescription *vmsd, TestStruct *obj)
+{
+    SUCCESS(load_vmstate_one(vmsd, obj, 1, mr_wire, sizeof(mr_wire)));
+}
+
+static void test_post_load_mr_update(void)
+{
+    TestStruct obj = {};
+    QemuThread thread;
+
+    /* Without a batch the update follows its post_load at once */
+    mr_reset();
+    mr_load(&vmstate_mr_a, &obj);
+    g_assert_cmpint(mr_a_post_load_ran, ==, 1);
+    g_assert_cmpint(mr_a_ran, ==, 2);
+
+    /* A batch holds the updates back, keeps their order, not post_load */
+    mr_reset();
+    vmstate_mr_update_batch_begin();
+    mr_load(&vmstate_mr_a, &obj);
+    mr_load(&vmstate_mr_b, &obj);
+    g_assert_cmpint(mr_a_post_load_ran, ==, 1);
+    g_assert_cmpint(mr_a_ran, ==, 0);
+    g_assert_cmpint(mr_b_ran, ==, 0);
+    vmstate_mr_update_batch_end();
+    g_assert_cmpint(mr_a_ran, ==, 2);
+    g_assert_cmpint(mr_b_ran, ==, 3);
+
+    /* Ending twice, as after postcopy RUN, is harmless */
+    vmstate_mr_update_batch_end();
+    g_assert_cmpint(mr_a_ran, ==, 2);
+
+    /* Another thread, like the postcopy listen thread, is not batched */
+    mr_reset();
+    vmstate_mr_update_batch_begin();
+    qemu_thread_create(&thread, "mr-load", mr_load_thread, &obj,
+                       QEMU_THREAD_JOINABLE);
+    qemu_thread_join(&thread);
+    g_assert_cmpint(mr_a_ran, ==, 2);
+    vmstate_mr_update_batch_end();
+    g_assert_cmpint(mr_a_ran, ==, 2);
+}
+
 int main(int argc, char **argv)
 {
     g_autofree char *temp_file = g_strdup_printf("%s/vmst.test.XXXXXX",
@@ -1605,6 +1713,7 @@ int main(int argc, char **argv)
     g_test_add_func("/vmstate/qlist/save/saveqlist", test_save_qlist);
     g_test_add_func("/vmstate/qlist/load/loadqlist", test_load_qlist);
     g_test_add_func("/vmstate/tmp_struct", test_tmp_struct);
+    g_test_add_func("/vmstate/post_load/mr_update", test_post_load_mr_update);
     g_test_run();
 
     close(temp_fd);
-- 
2.53.0


