Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF01C71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 14:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ59Q-00044u-L4; Fri, 13 Jun 2025 10:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ59N-00043c-7J
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:12:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ59L-0002ON-6i
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749823974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lALLJ7Kl3re5bx4CP7gHC1WJgi0gwi4Ei0KzYYTmm/0=;
 b=HFv47X0g04wZUMDcYJwYEWWpC5zei4aaUgvcItWJinf931cgGGx6NWc3ATagA9waZPjV3I
 MeeTkyhp1yJGoD6EYKejJMfYXJ75RxCCqYqe00yKmzv94CU9xU64wMCbAO/+PIsuLiA+CE
 afJO12DFJXjd8Lg4v4v/pYSBUxppAiw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-vH3WNZSWPhquQTqWDedQxQ-1; Fri, 13 Jun 2025 10:12:53 -0400
X-MC-Unique: vH3WNZSWPhquQTqWDedQxQ-1
X-Mimecast-MFC-AGG-ID: vH3WNZSWPhquQTqWDedQxQ_1749823973
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6fad5f1e70fso41611596d6.0
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 07:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749823972; x=1750428772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lALLJ7Kl3re5bx4CP7gHC1WJgi0gwi4Ei0KzYYTmm/0=;
 b=Vwc65VLOVuokf7MF6CMrnlJwKEhGkC6dPlu3KJxrY8q6tO3LQwarb4ViI22rUuNMrW
 YEAFr3kvwHSZtohZDGZ4MawvN3QsqO1WT2Ap9OnO5+D7qBV5PqEzMd4G6mjCV6AH7EIZ
 frH5og7PmWAAz2DkFtse0FP5qkDDiJs2jirLQC/a8eZ2M0Kdn0/ULcP1tm4o/urv7368
 J0nLW+8OjDbZ4Du7lBp+ZDbhRS+4kUKj0ZfTS87fxGhRANOD2J0P1n26/4TCq50ryzhF
 vuMwuXD6maGvRAWEcqCacm6HiiGLKpQZHAa7yvutWlhwBI4bqgVob4tlM43ZTy0lqp1J
 OCOQ==
X-Gm-Message-State: AOJu0YxsZ8OxZAVTdQdidZDmy0BsN2viZGn8RZtAsk4/mX85W11P0Qpj
 /B3V7oZD1Iv5HUPO2q74A82KVRDK56TlHz4moJnj4QyBg5Qa6P7EZNybbduMb8BQqmQ7DIy+nHq
 VPlp2q/e8GZiSbqvO965KWk093eMjNz9Ix6xISe1zOpyfqa9XyNfDGfBUTZ+OHjELzFv4E2aKW6
 GEVS7ynqL0NLGmolKLDYJwjXETsd6C5Anc4A+Dhw==
X-Gm-Gg: ASbGnctdKMaKVS45Nub2OTfga6yN4OKNWTd+Q5Tr4Cm3Tc4IhPN1wLB1BJM/7HJtJgz
 K3gTt32DnaBr+zHRHBA9yQukfbtxmfmCfG6WbPndfBXUyISfsy2AOJS8JyvzLB3hNih4Kw5iA9D
 MvULwih0kZAC6p0B6rvsB8DhQwo5ZH+cC7rVNIAT5rYnZL+siE3BSfGsYG3pmAxaVEbB4jHIMMN
 O9E2HeTh3wcuEqP2o/fK1lVc2y1Ig8EldmUjK5xk+PvQIfGVrVrhk5xBpt1QSMlxV69nPXEvcwJ
 8YXedny2Uvw=
X-Received: by 2002:a05:620a:3728:b0:7d3:914b:abe8 with SMTP id
 af79cd13be357-7d3bc4475a7mr733714685a.36.1749823961534; 
 Fri, 13 Jun 2025 07:12:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOFH6Xe24yS4mdBYS244wk5LxRKfc20GE18H6DDrXaDAxQzl530gEL326/3Vc8Xmx/CTvyOw==
X-Received: by 2002:a05:622a:6117:b0:490:8ffd:8f02 with SMTP id
 d75a77b69052e-4a72ff521a6mr53590621cf.37.1749823948984; 
 Fri, 13 Jun 2025 07:12:28 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a72a526cc6sm17141641cf.79.2025.06.13.07.12.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 07:12:28 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mario Casquero <mcasquer@redhat.com>,
 Alexey Perevalov <a.perevalov@samsung.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3 08/14] migration/postcopy: Report fault latencies in
 blocktime
Date: Fri, 13 Jun 2025 10:12:11 -0400
Message-ID: <20250613141217.474825-9-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613141217.474825-1-peterx@redhat.com>
References: <20250613141217.474825-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Blocktime so far only cares about the time one vcpu (or the whole system)
got blocked.  It would be also be helpful if it can also report the latency
of page requests, which could be very sensitive during postcopy.

Blocktime itself is sometimes not very important, especially when one
thinks about KVM async PF support, which means vCPUs are literally almost
not blocked at all because the guest OS is smart enough to switch to
another task when a remote fault is needed.

However, latency is still sensitive and important because even if the guest
vCPU is running on threads that do not need a remote fault, the workload
that accesses some missing page is still affected.

Add two entries to the report, showing how long it takes to resolve a
remote fault.  Mention in the QAPI doc that this is not the real average
fault latency, but only the ones that was requested for a remote fault.

Unwrap get_vcpu_blocktime_list() so we don't need to walk the list twice,
meanwhile add the entry checks in qtests for all postcopy tests.

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Tested-by: Mario Casquero <mcasquer@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json                   | 20 ++++++++
 migration/migration-hmp-cmds.c        | 67 ++++++++++++++++++---------
 migration/postcopy-ram.c              | 49 +++++++++++++-------
 tests/qtest/migration/migration-qmp.c |  3 ++
 4 files changed, 102 insertions(+), 37 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 4963f6ca12..30302f36cf 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -236,6 +236,17 @@
 #     This is only present when the postcopy-blocktime migration
 #     capability is enabled.  (Since 3.0)
 #
+# @postcopy-latency: average remote page fault latency (in ns).  Note that
+#     this doesn't include all faults, but only the ones that require a
+#     remote page request.  So it should be always bigger than the real
+#     average page fault latency. This is only present when the
+#     postcopy-blocktime migration capability is enabled.  (Since 10.1)
+#
+# @postcopy-vcpu-latency: average remote page fault latency per vCPU (in
+#     ns).  It has the same definition of @postcopy-latency, but instead
+#     this is the per-vCPU statistics.  This is only present when the
+#     postcopy-blocktime migration capability is enabled.  (Since 10.1)
+#
 # @socket-address: Only used for tcp, to know what the real port is
 #     (Since 4.0)
 #
@@ -260,6 +271,11 @@
 #     average memory load of the virtual CPU indirectly.  Note that
 #     zero means guest doesn't dirty memory.  (Since 8.1)
 #
+# Features:
+#
+# @unstable: Members @postcopy-latency, @postcopy-vcpu-latency are
+#     experimental.
+#
 # Since: 0.14
 ##
 { 'struct': 'MigrationInfo',
@@ -275,6 +291,10 @@
            '*blocked-reasons': ['str'],
            '*postcopy-blocktime': 'uint32',
            '*postcopy-vcpu-blocktime': ['uint32'],
+           '*postcopy-latency': {
+               'type': 'uint64', 'features': [ 'unstable' ] },
+           '*postcopy-vcpu-latency': {
+               'type': ['uint64'], 'features': [ 'unstable' ] },
            '*socket-address': ['SocketAddress'],
            '*dirty-limit-throttle-time-per-round': 'uint64',
            '*dirty-limit-ring-full-time': 'uint64'} }
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 867e017b32..8b3846dab5 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -52,6 +52,51 @@ static void migration_global_dump(Monitor *mon)
                    ms->clear_bitmap_shift);
 }
 
+static void migration_dump_blocktime(Monitor *mon, MigrationInfo *info)
+{
+    if (info->has_postcopy_blocktime) {
+        monitor_printf(mon, "Postcopy Blocktime (ms): %" PRIu32 "\n",
+                       info->postcopy_blocktime);
+    }
+
+    if (info->has_postcopy_vcpu_blocktime) {
+        uint32List *item = info->postcopy_vcpu_blocktime;
+        const char *sep = "";
+        int count = 0;
+
+        monitor_printf(mon, "Postcopy vCPU Blocktime (ms):\n [");
+
+        while (item) {
+            monitor_printf(mon, "%s%"PRIu32, sep, item->value);
+            item = item->next;
+            /* Each line 10 vcpu results, newline if there's more */
+            sep = ((++count % 10 == 0) && item) ? ",\n  " : ", ";
+        }
+        monitor_printf(mon, "]\n");
+    }
+
+    if (info->has_postcopy_latency) {
+        monitor_printf(mon, "Postcopy Latency (ns): %" PRIu64 "\n",
+                       info->postcopy_latency);
+    }
+
+    if (info->has_postcopy_vcpu_latency) {
+        uint64List *item = info->postcopy_vcpu_latency;
+        const char *sep = "";
+        int count = 0;
+
+        monitor_printf(mon, "Postcopy vCPU Latencies (ns):\n [");
+
+        while (item) {
+            monitor_printf(mon, "%s%"PRIu64, sep, item->value);
+            item = item->next;
+            /* Each line 10 vcpu results, newline if there's more */
+            sep = ((++count % 10 == 0) && item) ? ",\n  " : ", ";
+        }
+        monitor_printf(mon, "]\n");
+    }
+}
+
 void hmp_info_migrate(Monitor *mon, const QDict *qdict)
 {
     bool show_all = qdict_get_try_bool(qdict, "all", false);
@@ -202,27 +247,7 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
                        info->dirty_limit_ring_full_time);
     }
 
-    if (info->has_postcopy_blocktime) {
-        monitor_printf(mon, "Postcopy Blocktime (ms): %" PRIu32 "\n",
-                       info->postcopy_blocktime);
-    }
-
-    if (info->has_postcopy_vcpu_blocktime) {
-        uint32List *item = info->postcopy_vcpu_blocktime;
-        const char *sep = "";
-        int count = 0;
-
-        monitor_printf(mon, "Postcopy vCPU Blocktime (ms):\n [");
-
-        while (item) {
-            monitor_printf(mon, "%s%"PRIu32, sep, item->value);
-            item = item->next;
-            /* Each line 10 vcpu results, newline if there's more */
-            sep = ((++count % 10 == 0) && item) ? ",\n  " : ", ";
-        }
-        monitor_printf(mon, "]\n");
-    }
-
+    migration_dump_blocktime(mon, info);
 out:
     qapi_free_MigrationInfo(info);
 }
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 15ea106910..fe940f89b9 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -166,21 +166,6 @@ static struct PostcopyBlocktimeContext *blocktime_context_new(void)
     return ctx;
 }
 
-static uint32List *get_vcpu_blocktime_list(PostcopyBlocktimeContext *ctx)
-{
-    MachineState *ms = MACHINE(qdev_get_machine());
-    uint32List *list = NULL;
-    int i;
-
-    for (i = ms->smp.cpus - 1; i >= 0; i--) {
-        /* Convert ns -> ms */
-        QAPI_LIST_PREPEND(
-            list, (uint32_t)(ctx->vcpu_blocktime_total[i] / SCALE_MS));
-    }
-
-    return list;
-}
-
 /*
  * This function just populates MigrationInfo from postcopy's
  * blocktime context. It will not populate MigrationInfo,
@@ -192,16 +177,48 @@ void fill_destination_postcopy_migration_info(MigrationInfo *info)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
     PostcopyBlocktimeContext *bc = mis->blocktime_ctx;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    uint64_t latency_total = 0, faults = 0;
+    uint32List *list_blocktime = NULL;
+    uint64List *list_latency = NULL;
+    int i;
 
     if (!bc) {
         return;
     }
 
+    for (i = ms->smp.cpus - 1; i >= 0; i--) {
+        uint64_t latency, total, count;
+
+        /* Convert ns -> ms */
+        QAPI_LIST_PREPEND(list_blocktime,
+                          (uint32_t)(bc->vcpu_blocktime_total[i] / SCALE_MS));
+
+        /* The rest in nanoseconds */
+        total = bc->vcpu_blocktime_total[i];
+        latency_total += total;
+        count = bc->vcpu_faults_count[i];
+        faults += count;
+
+        if (count) {
+            latency = total / count;
+        } else {
+            /* No fault detected */
+            latency = 0;
+        }
+
+        QAPI_LIST_PREPEND(list_latency, latency);
+    }
+
     info->has_postcopy_blocktime = true;
     /* Convert ns -> ms */
     info->postcopy_blocktime = (uint32_t)(bc->total_blocktime / SCALE_MS);
     info->has_postcopy_vcpu_blocktime = true;
-    info->postcopy_vcpu_blocktime = get_vcpu_blocktime_list(bc);
+    info->postcopy_vcpu_blocktime = list_blocktime;
+    info->has_postcopy_latency = true;
+    info->postcopy_latency = faults ? (latency_total / faults) : 0;
+    info->has_postcopy_vcpu_latency = true;
+    info->postcopy_vcpu_latency = list_latency;
 }
 
 static uint64_t get_postcopy_total_blocktime(void)
diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
index fb59741b2c..1a5ab2d229 100644
--- a/tests/qtest/migration/migration-qmp.c
+++ b/tests/qtest/migration/migration-qmp.c
@@ -358,6 +358,9 @@ void read_blocktime(QTestState *who)
 
     rsp_return = migrate_query_not_failed(who);
     g_assert(qdict_haskey(rsp_return, "postcopy-blocktime"));
+    g_assert(qdict_haskey(rsp_return, "postcopy-vcpu-blocktime"));
+    g_assert(qdict_haskey(rsp_return, "postcopy-latency"));
+    g_assert(qdict_haskey(rsp_return, "postcopy-vcpu-latency"));
     qobject_unref(rsp_return);
 }
 
-- 
2.49.0


