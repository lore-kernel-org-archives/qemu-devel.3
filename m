Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F069C71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 14:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ59J-0003zw-LD; Fri, 13 Jun 2025 10:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ59H-0003yw-VY
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:12:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ59E-0002MP-FW
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749823965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3i05mM5Kf5Mf9n3r0qpk8pmYqkJYk9eZcgiq02HTyoE=;
 b=UQM+3PIhE1V19ReYVrR1AQjz/SubhL8nX/2a3LIhp64JfgsnTcopDl2IaCVN4fcLiKUNI+
 tlUHzNnADn9L1ASVrWMUQNzbW4177h7TtQZh/M7zR2ZrxjEQi187KKfCMUrBWy2x8L6BCH
 i77SzEITmzit7rWzckC28V5v7nqQvBk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-Nv_kLPq5NxW7m72BremU9A-1; Fri, 13 Jun 2025 10:12:41 -0400
X-MC-Unique: Nv_kLPq5NxW7m72BremU9A-1
X-Mimecast-MFC-AGG-ID: Nv_kLPq5NxW7m72BremU9A_1749823960
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4a5882b7339so25650011cf.2
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 07:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749823960; x=1750428760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3i05mM5Kf5Mf9n3r0qpk8pmYqkJYk9eZcgiq02HTyoE=;
 b=THvQW0brj/Lu19hcThNr6O5I1sGOR6vYyvgRmKqOuz3joQLziWs0Z3pDlTF38W58Vq
 KhfniMR3ZFSQXXsiaiDNAv4e6hj/kylSV9Oobqxqy4TcTL8rdOUt3gkcquzp01jR3pyy
 Fad5401Q3tyVrQCfQK+FflqjBlp0dgnCz9nM2++QAQ0i5hmHAvkCYTO0GtIttKhc9tYN
 QRQI0gcCoFuG5AdWFgYSZ9V/ypMCZ8vW16a12PmjmtO3lJMzlaO2TRRipd3bOt9DtQnq
 nN8sG7vL1hWovmt2lEdrwM41z/xc9KLrwRJVHBsyqp+alL/zNgpDJmvVs2EpeNZOrsWL
 MrOw==
X-Gm-Message-State: AOJu0YzsMbjsq6Py9APBctSqILyf3bw2BaQe4inrdG6/dG2BI+2QXAZy
 OFwEXVPY4gqvDL+z8sjvoPXftSYmBSrC0e7ctOHD9/I+PC+LzOgPTj84BMJnkfPpnIW0/dQSrIV
 xC4A/chl0i7FFzKU2EqcdvfqW1LV1hMomYJmBrQ8OunK/zQWybq0IfH7wojD++ET8cBx7XE9jpB
 z+Ww8WMXsHJGJyT9S566PkmH2UgULaobZ1mPcmMQ==
X-Gm-Gg: ASbGncu4/G1g8o05BLrCmDkjLdMDuhw6JMysdqYH0IcICJIZMZGgoZomQhj2qVAV8CT
 dOI61SqsVHui17C0RdcRQJEzMgw/fdfg39TA0ZY7xhcfAwITMFBdNqBTZ/F26bQscBIS8vVLjlB
 MFHzdxrdLlahwAhJdg9b7GtnOHv+vfhfhnfTbdRr+86U4Q9BtSiTa1mQ/2V9T/KB/xB5NllpZoH
 itYXzT7LENduT9X2e9LFSlwdJbcCj3to4j/BGP+SXN9rQ1WMCAlzEQTw5V+QYdTYYVuMo/+6vcB
 6MMizeViwy4=
X-Received: by 2002:ac8:5cd0:0:b0:4a7:14c4:2385 with SMTP id
 d75a77b69052e-4a72ff1c496mr44385601cf.42.1749823958825; 
 Fri, 13 Jun 2025 07:12:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEM4VKkG3eFF/XRZsyNegzjZLfmIEDQQdj8yUhuoeLUmZXRuneVPxLmZPtzuh7uOa5S5di6/g==
X-Received: by 2002:ac8:5cd0:0:b0:4a7:14c4:2385 with SMTP id
 d75a77b69052e-4a72ff1c496mr44384921cf.42.1749823958041; 
 Fri, 13 Jun 2025 07:12:38 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a72a526cc6sm17141641cf.79.2025.06.13.07.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 07:12:37 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mario Casquero <mcasquer@redhat.com>,
 Alexey Perevalov <a.perevalov@samsung.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3 14/14] migration/postcopy: Add latency distribution report
 for blocktime
Date: Fri, 13 Jun 2025 10:12:17 -0400
Message-ID: <20250613141217.474825-15-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613141217.474825-1-peterx@redhat.com>
References: <20250613141217.474825-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

Add the latency distribution too for blocktime, using order-of-two buckets.
It accounts for all the faults, from either vCPU or non-vCPU threads.  With
prior rework, it's very easy to achieve by adding an array to account for
faults in each buckets.

Sample output for HMP (while for QMP it's simply an array):

Postcopy Latency Distribution:
  [     1 us -     2 us ]:          0
  [     2 us -     4 us ]:          0
  [     4 us -     8 us ]:          1
  [     8 us -    16 us ]:          2
  [    16 us -    32 us ]:          2
  [    32 us -    64 us ]:          3
  [    64 us -   128 us ]:      10169
  [   128 us -   256 us ]:      50151
  [   256 us -   512 us ]:      12876
  [   512 us -     1 ms ]:         97
  [     1 ms -     2 ms ]:         42
  [     2 ms -     4 ms ]:         44
  [     4 ms -     8 ms ]:         93
  [     8 ms -    16 ms ]:        138
  [    16 ms -    32 ms ]:          0
  [    32 ms -    65 ms ]:          0
  [    65 ms -   131 ms ]:          0
  [   131 ms -   262 ms ]:          0
  [   262 ms -   524 ms ]:          0
  [   524 ms -    1 sec ]:          0
  [    1 sec -    2 sec ]:          0
  [    2 sec -    4 sec ]:          0
  [    4 sec -    8 sec ]:          0
  [    8 sec -   16 sec ]:          0

Cc: Markus Armbruster <armbru@redhat.com>
Acked-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json                   | 12 ++++++-
 migration/migration-hmp-cmds.c        | 32 +++++++++++++++++++
 migration/postcopy-ram.c              | 46 +++++++++++++++++++++++++++
 tests/qtest/migration/migration-qmp.c |  1 +
 4 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 0f5b2d914c..d3016c0b94 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -242,6 +242,14 @@
 #     average page fault latency. This is only present when the
 #     postcopy-blocktime migration capability is enabled.  (Since 10.1)
 #
+# @postcopy-latency-dist: remote page fault latency distributions.  Each
+#     element of the array is the number of faults that fall into the
+#     bucket period.  For the N-th bucket (N>=0), the latency window is
+#     [2^Nus, 2^(N+1)us).  For example, the 8th element stores how many
+#     remote faults got resolved within [256us, 512us) window. This is only
+#     present when the postcopy-blocktime migration capability is enabled.
+#     (Since 10.1)
+#
 # @postcopy-vcpu-latency: average remote page fault latency per vCPU (in
 #     ns).  It has the same definition of @postcopy-latency, but instead
 #     this is the per-vCPU statistics.  This is only present when the
@@ -280,7 +288,7 @@
 # Features:
 #
 # @unstable: Members @postcopy-latency, @postcopy-vcpu-latency,
-#     @postcopy-non-vcpu-latency are experimental.
+#     @postcopy-latency-dist, @postcopy-non-vcpu-latency are experimental.
 #
 # Since: 0.14
 ##
@@ -299,6 +307,8 @@
            '*postcopy-vcpu-blocktime': ['uint32'],
            '*postcopy-latency': {
                'type': 'uint64', 'features': [ 'unstable' ] },
+           '*postcopy-latency-dist': {
+               'type': ['uint64'], 'features': [ 'unstable' ] },
            '*postcopy-vcpu-latency': {
                'type': ['uint64'], 'features': [ 'unstable' ] },
            '*postcopy-non-vcpu-latency': {
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index e1f9530520..cef5608210 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -52,6 +52,21 @@ static void migration_global_dump(Monitor *mon)
                    ms->clear_bitmap_shift);
 }
 
+static const gchar *format_time_str(uint64_t us)
+{
+    const char *units[] = {"us", "ms", "sec"};
+    int index = 0;
+
+    while (us > 1000) {
+        us /= 1000;
+        if (++index >= (sizeof(units) - 1)) {
+            break;
+        }
+    }
+
+    return g_strdup_printf("%"PRIu64" %s", us, units[index]);
+}
+
 static void migration_dump_blocktime(Monitor *mon, MigrationInfo *info)
 {
     if (info->has_postcopy_blocktime) {
@@ -100,6 +115,23 @@ static void migration_dump_blocktime(Monitor *mon, MigrationInfo *info)
         }
         monitor_printf(mon, "]\n");
     }
+
+    if (info->has_postcopy_latency_dist) {
+        uint64List *item = info->postcopy_latency_dist;
+        int count = 0;
+
+        monitor_printf(mon, "Postcopy Latency Distribution:\n");
+
+        while (item) {
+            g_autofree const gchar *from = format_time_str(1UL << count);
+            g_autofree const gchar *to = format_time_str(1UL << (count + 1));
+
+            monitor_printf(mon, "  [ %8s - %8s ]: %10"PRIu64"\n",
+                           from, to, item->value);
+            item = item->next;
+            count++;
+        }
+    }
 }
 
 void hmp_info_migrate(Monitor *mon, const QDict *qdict)
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index f4cb23b3e0..45af9a361e 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -110,6 +110,15 @@ void postcopy_thread_create(MigrationIncomingState *mis,
 #include <sys/eventfd.h>
 #include <linux/userfaultfd.h>
 
+/*
+ * Here we use 24 buckets, which means the last bucket will cover [2^24 us,
+ * 2^25 us) ~= [16, 32) seconds.  It should be far enough to record even
+ * extreme (perf-wise broken) 1G pages moving over, which can sometimes
+ * take a few seconds due to various reasons.  Anything more than that
+ * might be unsensible to account anymore.
+ */
+#define  BLOCKTIME_LATENCY_BUCKET_N  (24)
+
 /* All the time records are in unit of nanoseconds */
 typedef struct PostcopyBlocktimeContext {
     /* blocktime per vCPU */
@@ -175,6 +184,11 @@ typedef struct PostcopyBlocktimeContext {
      * that a fault was requested.
      */
     GHashTable *vcpu_addr_hash;
+    /*
+     * Each bucket stores the count of faults that were resolved within the
+     * bucket window [2^N us, 2^(N+1) us).
+     */
+    uint64_t latency_buckets[BLOCKTIME_LATENCY_BUCKET_N];
     /* total blocktime when all vCPUs are stopped */
     uint64_t total_blocktime;
     /* point in time when last page fault was initiated */
@@ -283,6 +297,9 @@ static struct PostcopyBlocktimeContext *blocktime_context_new(void)
     unsigned int smp_cpus = ms->smp.cpus;
     PostcopyBlocktimeContext *ctx = g_new0(PostcopyBlocktimeContext, 1);
 
+    /* Initialize all counters to be zeros */
+    memset(ctx->latency_buckets, 0, sizeof(ctx->latency_buckets));
+
     ctx->vcpu_blocktime_total = g_new0(uint64_t, smp_cpus);
     ctx->vcpu_faults_count = g_new0(uint64_t, smp_cpus);
     ctx->vcpu_faults_current = g_new0(uint8_t, smp_cpus);
@@ -320,6 +337,7 @@ void fill_destination_postcopy_migration_info(MigrationInfo *info)
     uint64_t latency_total = 0, faults = 0;
     uint32List *list_blocktime = NULL;
     uint64List *list_latency = NULL;
+    uint64List *latency_buckets = NULL;
     int i;
 
     if (!bc) {
@@ -349,6 +367,10 @@ void fill_destination_postcopy_migration_info(MigrationInfo *info)
         QAPI_LIST_PREPEND(list_latency, latency);
     }
 
+    for (i = BLOCKTIME_LATENCY_BUCKET_N - 1; i >= 0; i--) {
+        QAPI_LIST_PREPEND(latency_buckets, bc->latency_buckets[i]);
+    }
+
     latency_total += bc->non_vcpu_blocktime_total;
     faults += bc->non_vcpu_faults;
 
@@ -364,6 +386,8 @@ void fill_destination_postcopy_migration_info(MigrationInfo *info)
     info->postcopy_latency = faults ? (latency_total / faults) : 0;
     info->has_postcopy_vcpu_latency = true;
     info->postcopy_vcpu_latency = list_latency;
+    info->has_postcopy_latency_dist = true;
+    info->postcopy_latency_dist = latency_buckets;
 }
 
 static uint64_t get_postcopy_total_blocktime(void)
@@ -1096,6 +1120,25 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
     blocktime_fault_inject(dc, addr, cpu, current);
 }
 
+static void blocktime_latency_account(PostcopyBlocktimeContext *ctx,
+                                      uint64_t time_us)
+{
+    /*
+     * Convert time (in us) to bucket index it belongs.  Take extra caution
+     * of time_us==0 even if normally rare - when happens put into bucket 0.
+     */
+    int index = time_us ? (63 - clz64(time_us)) : 0;
+
+    assert(index >= 0);
+
+    /* If it's too large, put into top bucket */
+    if (index >= BLOCKTIME_LATENCY_BUCKET_N) {
+        index = BLOCKTIME_LATENCY_BUCKET_N - 1;
+    }
+
+    ctx->latency_buckets[index]++;
+}
+
 typedef struct {
     PostcopyBlocktimeContext *ctx;
     uint64_t current;
@@ -1118,6 +1161,9 @@ static void blocktime_cpu_list_iter_fn(gpointer data, gpointer user_data)
     assert(iter->current >= entry->fault_time);
     time_passed = iter->current - entry->fault_time;
 
+    /* Latency buckets are in microseconds */
+    blocktime_latency_account(ctx, time_passed / SCALE_US);
+
     if (cpu >= 0) {
         /*
          * If we resolved all pending faults on one vCPU due to this page
diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
index 67a67d4bd6..66dd369ba7 100644
--- a/tests/qtest/migration/migration-qmp.c
+++ b/tests/qtest/migration/migration-qmp.c
@@ -360,6 +360,7 @@ void read_blocktime(QTestState *who)
     g_assert(qdict_haskey(rsp_return, "postcopy-blocktime"));
     g_assert(qdict_haskey(rsp_return, "postcopy-vcpu-blocktime"));
     g_assert(qdict_haskey(rsp_return, "postcopy-latency"));
+    g_assert(qdict_haskey(rsp_return, "postcopy-latency-dist"));
     g_assert(qdict_haskey(rsp_return, "postcopy-vcpu-latency"));
     g_assert(qdict_haskey(rsp_return, "postcopy-non-vcpu-latency"));
     qobject_unref(rsp_return);
-- 
2.49.0


