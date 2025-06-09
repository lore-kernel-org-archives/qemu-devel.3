Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F095AC5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 19:16:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOhvs-0006NX-8B; Mon, 09 Jun 2025 15:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOhvq-0006Mo-Pb
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:13:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOhvo-0000qE-Dx
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749496395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VcVyp4UEqvWfTRq2gNYvpZME1z/wOcKZB/CmIJX+Bks=;
 b=E2lQ1409zuOQxV57KPzcCV3CQ4AG/hbSYRomGNPKg+++bYgLwWtasK9+lLrXn96F7amkbq
 Hi2+vOBfeS/21XWKRa4uT74eUdquuioTW6ssksJiwdLvUGX7FR/5M63+A7nOdCQywXvW/T
 P3uvjX6z+/WN0LReQkhr6rmoxa3Pkuc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-Ljqi6bS7Mieyte5NviyG9w-1; Mon, 09 Jun 2025 15:13:14 -0400
X-MC-Unique: Ljqi6bS7Mieyte5NviyG9w-1
X-Mimecast-MFC-AGG-ID: Ljqi6bS7Mieyte5NviyG9w_1749496394
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7c53e316734so724763185a.2
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 12:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749496394; x=1750101194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VcVyp4UEqvWfTRq2gNYvpZME1z/wOcKZB/CmIJX+Bks=;
 b=RStBuWs8VQqyTlMWWJ5xFX4RrWJK7pdw7SVnECVNUXkK5agtWF4zsfHz8AS3iCkxIV
 AXzZJ3u0CgPcmEpy1hb5KmTJQ5ok17gs5Ry6WRb6HRmQOtlHcPgHKheLI/GVPrEh6G/j
 dQQYod8aiWwI04Fquf3dVQmmgSVnCYAJMIxkHot/EjOqFBys9s48osu5hteZUPubFIxH
 8I6V7AoIqtrsynaxLBfpWrUjrS+XZGzKZ5IGQMCXtbo9qZnd0sinkUOm9guF2nPq2I8n
 bRJuDSuTnRTDmLxQVtphnsQW5qMeI3bs7PUhbScebJPAb8OAM0cv3uFC4wt3ysGbkk71
 nl/w==
X-Gm-Message-State: AOJu0YyAyOc9TH9YD+FvyuA99lqv25oPYXpzfAx73mhh1pSVylM8Ocvg
 3mX1+0f4dTChrkYTNav30L5lOiCZqC8MGbQNyzrlD8uTu1Z620LPRkm7V9YsYN5MerdttG7BMow
 xvSeTAJ6/Afr9jSYE3fMq66nB/12v2Wj2bBqGaddXZzUG7ekY1IkNl64eQsBDbZSoCJD7We1tbk
 FQo/LxmZT+G+t4dBDW8uMtM2CEw/RomLYXbGsC3Q==
X-Gm-Gg: ASbGncuLdc9iUVYaUCf20IovrHXraatlJMF2bhkCT2y1xhtw8nVR30vQVAx3Lyv5Xk+
 czVoX/sirgY7JxYEwOf40b4J56iqMA3eQkm+l0hA6m818JnlzfTB0ydIWGQm/HDte2lntgNXiwT
 ELqVm880CTJ3oWdFXwKoSDO1gPjhud3iiuqoY5h+j+ZY0A9FxDFHBPE7zfSAcE0ZILkRWch9+PK
 Up2wRV6Y1gKxhMe/hG1uWognP+w5ee0qSD1FedUSOuqZaKXlFSzXazYu9MDuL5LbxA2XWCJmDT8
 ZYvaibZUQThiUQ==
X-Received: by 2002:a05:620a:c54:b0:7cd:145:d652 with SMTP id
 af79cd13be357-7d2298484e9mr2125722785a.12.1749496393810; 
 Mon, 09 Jun 2025 12:13:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGT3mtxYQa9FbaQuXJ4uq+DGn1cqqyx7act6udAIlcvIo+ZBgR9ytoBWA7fZrx5RKC4e09/vQ==
X-Received: by 2002:a05:620a:c54:b0:7cd:145:d652 with SMTP id
 af79cd13be357-7d2298484e9mr2125718685a.12.1749496393387; 
 Mon, 09 Jun 2025 12:13:13 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09b1cc24sm55178856d6.72.2025.06.09.12.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 12:13:12 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>,
 Juraj Marcin <jmarcin@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 08/13] migration/postcopy: Report fault latencies in
 blocktime
Date: Mon,  9 Jun 2025 15:12:54 -0400
Message-ID: <20250609191259.9053-9-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609191259.9053-1-peterx@redhat.com>
References: <20250609191259.9053-1-peterx@redhat.com>
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
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json                   | 13 +++++
 migration/migration-hmp-cmds.c        | 68 ++++++++++++++++++---------
 migration/postcopy-ram.c              | 48 +++++++++++++------
 tests/qtest/migration/migration-qmp.c |  3 ++
 4 files changed, 96 insertions(+), 36 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 4963f6ca12..e95b7402cb 100644
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
+#     this is the per-vCPU statistics.  This is only present when the
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
index 6c36e202a0..600b0f8071 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -52,6 +52,52 @@ static void migration_global_dump(Monitor *mon)
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
+        monitor_printf(mon, "Postcopy vCPU Blocktime (ms): \n [");
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
@@ -202,27 +248,7 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
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
-        monitor_printf(mon, "Postcopy vCPU Blocktime (ms): \n [");
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
index f5c58a6ca7..98d4c29532 100644
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


