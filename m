Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DFCC5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 22:36:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOl6K-00076Y-Ap; Mon, 09 Jun 2025 18:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOl6H-000748-Tv
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 18:36:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOl6F-0007VN-R7
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 18:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749508573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=MA5onlRo8A748bsKc043Ry7H/0+b2VBCgHld/ZM2x4s=;
 b=UnC2udIMKLNBH4s0PoSkpZPBDPcMS79qtVrUvd/Det9Mrt8yVDdJxRyCCKjCQ5udrvR1/Z
 2+jZ++mIIgHYS+5nxI03Fa8E6KWDhVt3d3/h5YnHZjCIZX6Ay5z6mI+Uu5OChpsFrDqm77
 U6sqoMQmSB9bXa2l0eqIMYm7vGcUZVY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-AnktdKQzNRqnpmRtqQCBMQ-1; Mon, 09 Jun 2025 18:36:12 -0400
X-MC-Unique: AnktdKQzNRqnpmRtqQCBMQ-1
X-Mimecast-MFC-AGG-ID: AnktdKQzNRqnpmRtqQCBMQ_1749508571
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7d399070cecso170801985a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 15:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749508571; x=1750113371;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MA5onlRo8A748bsKc043Ry7H/0+b2VBCgHld/ZM2x4s=;
 b=dgOIPNwwe12jXF3F0xcIacDce1SUEXmLVU1iRsE4yKUJQaW2RB3XskFwZzfNe3SeiV
 1SDe3f0r2Yi787n+zD8rFlVNBypiZUahqbttUbnJlNcBCYfmD9O8pZSAYe2LlsGnXD7Q
 6i8hocFlGOn/kY+58wwEJt7okb8KqOAhVl4f3MAjGorakXB1F3rbaXuAUfkf5dXj1Cu2
 DK9PepE/NHbxFfJRgh2uDEAAkjZHYwsG5YFZbpmn43frgElO6WE+MEYzhRxJjQ2ONHsk
 O0UWZeVFxIfD2osFE+nW0g5/ktUY1+G+frwE0jCZ9F/CPNREbcqzMewTyLywsgRAFFEx
 SzBA==
X-Gm-Message-State: AOJu0Ywqc4zniMS9CAabtuVV7x22o6Piu16x/ZI48uZgYBq9gpZ2xphY
 XyXp3lh6Yz5MI0f5mLb+nyOfwpAew1YH3Xj1EBWxkK2ggunNsYNu9OZqhcLTUsdaH/WIkCUy51k
 wm8nRb7YPUdjhhENXLizmtx9SBuU+FQ1yCS98mKhGcCMTclcH1pUJeZjD4hk9z51/aBZvLz8OnB
 /w32CXQNvSd/Rv1bsYKrTERGj3UcdcuyK0urkxFQ==
X-Gm-Gg: ASbGncs8dOLXCLLAk67MC7cIoiCMp3wKE4hPi+mQ5ZqStEWPImmq//DOl6/nfQV9+7K
 onEqTU0KZHqjmtUe40kp5UiBHB5Sa/ViRsBsdBPyQbjAppeUi1dBX8vyRMa94kwuPs1EGk+3ICk
 npSEnLH3/8nHoj4gtHYcO2UMo6oMjc2cHsuh5lhbr5Bw5Gwd7z4m/k2rmzdGTl5ORpOZbRFJnDT
 Y4mgl14sJDxLn94OelIqtAMsIUUKohlB0WUeArDEGt33UKXHvaziEmxoylJF5VzxStYq0swt61m
 40zmP9wpBCM=
X-Received: by 2002:a05:620a:4095:b0:7ce:f5c6:e48 with SMTP id
 af79cd13be357-7d22986108fmr2098622585a.21.1749508571162; 
 Mon, 09 Jun 2025 15:36:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3gF0GlUceq7DzfmCYbIASGtWN3MN+jCsy9JESdofd6c0grRLCnJ8r44naiuNMntI2bKcLtA==
X-Received: by 2002:a05:620a:4095:b0:7ce:f5c6:e48 with SMTP id
 af79cd13be357-7d22986108fmr2098618885a.21.1749508570658; 
 Mon, 09 Jun 2025 15:36:10 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d250f64b80sm599951285a.23.2025.06.09.15.36.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 15:36:10 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 peterx@redhat.com, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH] migration/postcopy: Add latency distribution report for
 blocktime
Date: Mon,  9 Jun 2025 18:36:07 -0400
Message-ID: <20250609223607.34387-1-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
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

Cc: Dr. David Alan Gilbert <dave@treblig.org>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---

This patch is based on:

[PATCH v2 00/13] migration/postcopy: Blocktime tracking overhaul
Based-on: <20250609191259.9053-1-peterx@redhat.com>

It is the TODO mentioned in the other series, this patch implemented the
buckets distribution for fault latency traps.
---
 qapi/migration.json                   |  9 ++++++
 migration/migration-hmp-cmds.c        | 32 +++++++++++++++++++
 migration/postcopy-ram.c              | 45 +++++++++++++++++++++++++++
 tests/qtest/migration/migration-qmp.c |  1 +
 4 files changed, 87 insertions(+)

diff --git a/qapi/migration.json b/qapi/migration.json
index cc680dda46..7d9524a8ea 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -242,6 +242,14 @@
 #     average page fault latency. This is only present when the
 #     postcopy-blocktime migration capability is enabled.  (Since 10.1)
 #
+# @postcopy-latency-dist: remote page fault latency distributions.  Each
+#     element of the array is the number of faults that fall into the
+#     bucket period.  For the N-th bucket (N>=0), the latency window is
+#     [2^N, 2^(N+1)).  For example, the 8th element stores how many remote
+#     faults got resolved within [256us, 512us) window. This is only
+#     present when the postcopy-blocktime migration capability is enabled.
+#     (Since 10.1)
+#
 # @postcopy-vcpu-latency: average remote page fault latency per vCPU (in
 #     us).  It has the same definition of @postcopy-latency, but instead
 #     this is the per-vCPU statistics.  This is only present when the
@@ -293,6 +301,7 @@
            '*postcopy-blocktime': 'uint32',
            '*postcopy-vcpu-blocktime': ['uint32'],
            '*postcopy-latency': 'uint64',
+           '*postcopy-latency-dist': ['uint64'],
            '*postcopy-vcpu-latency': ['uint64'],
            '*postcopy-non-vcpu-latency': 'uint64',
            '*socket-address': ['SocketAddress'],
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index b234eb6478..b83befd26c 100644
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
index 23332ef3dd..0b40b79f64 100644
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
 /* All the time records are in unit of microseconds (us) */
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
 
@@ -363,6 +385,8 @@ void fill_destination_postcopy_migration_info(MigrationInfo *info)
     info->postcopy_latency = faults ? (latency_total / faults) : 0;
     info->has_postcopy_vcpu_latency = true;
     info->postcopy_vcpu_latency = list_latency;
+    info->has_postcopy_latency_dist = true;
+    info->postcopy_latency_dist = latency_buckets;
 }
 
 static uint64_t get_postcopy_total_blocktime(void)
@@ -1095,6 +1119,25 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
     blocktime_fault_inject(dc, addr, cpu, current_us);
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
     uint64_t current_us;
@@ -1117,6 +1160,8 @@ static void blocktime_cpu_list_iter_fn(gpointer data, gpointer user_data)
     assert(iter->current_us >= entry->fault_time);
     time_passed = iter->current_us - entry->fault_time;
 
+    blocktime_latency_account(ctx, time_passed);
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


