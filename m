Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2233AC5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 23:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK3Tv-0003Jj-FL; Tue, 27 May 2025 19:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK3Ts-0003Ib-SL
 for qemu-devel@nongnu.org; Tue, 27 May 2025 19:13:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK3Tq-0001Dv-UC
 for qemu-devel@nongnu.org; Tue, 27 May 2025 19:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748387590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L8xxihyV1kwj1WX+SgxHrTlMY975PGImx8ozXT5u7mk=;
 b=M9GpP/B6Aszmg4shXrGyXElJXh+HHngMHdHJsKQxFsL93RQ4W6JcgktGebmOziC4PSXB+z
 XDWln+SQIPr+jIIqslaIuEmLz74vcfH8z7B2xRcSNnfWFvcsurDsBMTZU2iFdW+8AIjrsU
 f809ogBFKuIfPWOyBXY/Kp4j+Cztlh0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-Iu4NqknGN2OjgOOIh0dbAw-1; Tue, 27 May 2025 19:13:08 -0400
X-MC-Unique: Iu4NqknGN2OjgOOIh0dbAw-1
X-Mimecast-MFC-AGG-ID: Iu4NqknGN2OjgOOIh0dbAw_1748387588
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-478f78ff9beso116118981cf.1
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 16:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748387587; x=1748992387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L8xxihyV1kwj1WX+SgxHrTlMY975PGImx8ozXT5u7mk=;
 b=ubGXlD7LxVYwimoUVCI+OAjvc/WYbHEoUVpwG4lKnd/djQhXXWpioGvdb5e6T3DbHS
 jBK0GAW7wDI38bVu1agO91hTslq/Z52JvYdk9WQsSdOmAySSTe8fRIWjnqoSzP5f9RRu
 f3gVw0KpGZSL6f835qQZRSbpgho3+/RNJtuGmsl2M71nvKT6QNQS3VKGmT9YQL84lVVJ
 CuCq+I79sO4sOpLit/cIRC/m5Kwn9AagSWSXZFGK6yg+DATaVrCIjX0X8ca+vp2vxX1N
 4QyGjuhg1ZWgKF293FKTI4mxmWrOLTCt55aDZSy1fq9o1PM7ZN5Ei/BheMku22KKEWDX
 r4QQ==
X-Gm-Message-State: AOJu0YzQ1Yo8NzcosjRJMfkqasbOx2imSyc60WvZRFHOmXmY7WuioAV1
 R6yAwHFRl0KTylvkdgM/KG4SNJ8aN5NZMw90tlKaxQuNL6p95OgeORHsiarr4o9BYUn/VMBjyc3
 Ua8Hxlrr/NjJPMoFOCNeFlyeWKncRAIc4ieVTKJIR8ye5u9caFebdXOP+3lMvqCVCEJqb+58IF9
 fknG5zaRuyJx2uUDA1xpBdXKY2+EejU3IFLrR2CA==
X-Gm-Gg: ASbGncsEKJHZObhzsCd20ZG2uZWU46nuJyRp8ib5BW18Fl/g/U8w/W3c5vDgqFEpOoN
 r+y+bT7DsE3zlXlBjR005PYvoGrdyCDKP02QeHG0Gyv3jJzr7Xv5QOPqwcKs3KejxNuvhAq/uGY
 MOrlxObKchfNHEhV4tB7mN3KsNCNmN0qUEq/ub6PfU8PhbQ4S9fGn2nLvGt3V9I5BnmlQ8yZSv4
 AN0NMRq458TF1EezW6u/fbcF4OUVS/UMjygwpxgzMEWVPTgb9tgNfEXCmqnSgnyEyANeQUYZfKv
X-Received: by 2002:a05:622a:4c0e:b0:48d:7c95:4878 with SMTP id
 d75a77b69052e-49f46e3b379mr236342641cf.29.1748387587549; 
 Tue, 27 May 2025 16:13:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1sxba2rgi/DbE8hy//0giKNyhhtBIrget6BSYEYRHm6fbQONqdiKkdz2qg3Okp6dp6mXDog==
X-Received: by 2002:a05:622a:4c0e:b0:48d:7c95:4878 with SMTP id
 d75a77b69052e-49f46e3b379mr236342301cf.29.1748387587183; 
 Tue, 27 May 2025 16:13:07 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a2f939cad3sm1984441cf.79.2025.05.27.16.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 16:13:05 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Alexey Perevalov <a.perevalov@samsung.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 08/13] migration/postcopy: Report fault latencies in blocktime
Date: Tue, 27 May 2025 19:12:43 -0400
Message-ID: <20250527231248.1279174-9-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527231248.1279174-1-peterx@redhat.com>
References: <20250527231248.1279174-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json                   | 13 +++++
 migration/migration-hmp-cmds.c        | 70 ++++++++++++++++++---------
 migration/postcopy-ram.c              | 48 ++++++++++++------
 tests/qtest/migration/migration-qmp.c |  3 ++
 4 files changed, 97 insertions(+), 37 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 8b9c53595c..8b13cea169 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -236,6 +236,17 @@
 #     This is only present when the postcopy-blocktime migration
 #     capability is enabled.  (Since 3.0)
 #
+# @postcopy-latency: average remote page fault latency (in us).  Note that
+#     this doesn't include all faults, but only the ones that require a
+#     remote page request.  So it should be always bigger than the real
+#     average page fault latency. This is only present when the
+#     postcopy-blocktime migration capability is enabled.  (Since 10.1)
+#
+# @postcopy-vcpu-latency: average remote page fault latency per vCPU (in
+#     us).  It has the same definition of @postcopy-latency, but instead
+#     this is the per-vCPU statistics. This is only present when the
+#     postcopy-blocktime migration capability is enabled.  (Since 10.1)
+#
 # @socket-address: Only used for tcp, to know what the real port is
 #     (Since 4.0)
 #
@@ -275,6 +286,8 @@
            '*blocked-reasons': ['str'],
            '*postcopy-blocktime': 'uint32',
            '*postcopy-vcpu-blocktime': ['uint32'],
+           '*postcopy-latency': 'uint64',
+           '*postcopy-vcpu-latency': ['uint64'],
            '*socket-address': ['SocketAddress'],
            '*dirty-limit-throttle-time-per-round': 'uint64',
            '*dirty-limit-ring-full-time': 'uint64'} }
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 3cf890b887..a18049a7e8 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -52,6 +52,53 @@ static void migration_global_dump(Monitor *mon)
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
+        int count = 0;
+
+        monitor_printf(mon, "Postcopy vCPU Blocktime (ms): \n [");
+
+        while (item) {
+            monitor_printf(mon, "%"PRIu32", ", item->value);
+            item = item->next;
+            /* Each line 10 vcpu results, newline if there's more */
+            if ((++count % 10 == 0) && item) {
+                monitor_printf(mon, "\n  ");
+            }
+        }
+        monitor_printf(mon, "\b\b]\n");
+    }
+
+    if (info->has_postcopy_latency) {
+        monitor_printf(mon, "Postcopy Latency (us): %" PRIu64 "\n",
+                       info->postcopy_latency);
+    }
+
+    if (info->has_postcopy_vcpu_latency) {
+        uint64List *item = info->postcopy_vcpu_latency;
+        int count = 0;
+
+        monitor_printf(mon, "Postcopy vCPU Latencies (us): \n [");
+
+        while (item) {
+            monitor_printf(mon, "%"PRIu64", ", item->value);
+            item = item->next;
+            /* Each line 10 vcpu results, newline if there's more */
+            if ((++count % 10 == 0) && item) {
+                monitor_printf(mon, "\n  ");
+            }
+        }
+        monitor_printf(mon, "\b\b]\n");
+    }
+}
+
 void hmp_info_migrate(Monitor *mon, const QDict *qdict)
 {
     bool show_all = qdict_get_try_bool(qdict, "all", false);
@@ -202,28 +249,7 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
                        info->dirty_limit_ring_full_time);
     }
 
-    if (info->has_postcopy_blocktime) {
-        monitor_printf(mon, "Postcopy Blocktime (ms): %" PRIu32 "\n",
-                       info->postcopy_blocktime);
-    }
-
-    if (info->has_postcopy_vcpu_blocktime) {
-        uint32List *item = info->postcopy_vcpu_blocktime;
-        int count = 0;
-
-        monitor_printf(mon, "Postcopy vCPU Blocktime (ms): \n [");
-
-        while (item) {
-            monitor_printf(mon, "%"PRIu32", ", item->value);
-            item = item->next;
-            /* Each line 10 vcpu results, newline if there's more */
-            if ((++count % 10 == 0) && item) {
-                monitor_printf(mon, "\n  ");
-            }
-        }
-        monitor_printf(mon, "\b\b]\n");
-    }
-
+    migration_dump_blocktime(mon, info);
 out:
     qapi_free_MigrationInfo(info);
 }
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 46a8fdb6c2..2aca41b3d7 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -166,20 +166,6 @@ static struct PostcopyBlocktimeContext *blocktime_context_new(void)
     return ctx;
 }
 
-static uint32List *get_vcpu_blocktime_list(PostcopyBlocktimeContext *ctx)
-{
-    MachineState *ms = MACHINE(qdev_get_machine());
-    uint32List *list = NULL;
-    int i;
-
-    for (i = ms->smp.cpus - 1; i >= 0; i--) {
-        QAPI_LIST_PREPEND(
-            list, (uint32_t)(ctx->vcpu_blocktime_total[i] / 1000));
-    }
-
-    return list;
-}
-
 /*
  * This function just populates MigrationInfo from postcopy's
  * blocktime context. It will not populate MigrationInfo,
@@ -191,15 +177,47 @@ void fill_destination_postcopy_migration_info(MigrationInfo *info)
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
+        /* This is in milliseconds */
+        QAPI_LIST_PREPEND(list_blocktime,
+                          (uint32_t)(bc->vcpu_blocktime_total[i] / 1000));
+
+        /* The rest in microseconds */
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
     info->postcopy_blocktime = (uint32_t)(bc->total_blocktime / 1000);
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


