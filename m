Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAA7C71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 14:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ59P-00044D-JX; Fri, 13 Jun 2025 10:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ59E-0003vi-Nk
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:12:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ596-0002Kk-N1
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:12:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749823960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Ovn9cHFbbOnzTL416BsSHaOjwFIm9cgFfee3HTO6y8=;
 b=Q5qzH6CW9vOZy948uh0yo+RSLcPuekiI6dv2vyl81dlb9Irw6h7vjs+9hcDvB2m0GIHeoR
 QhTCPCY2ZZIBy6l2i2oTdvwS2WKh6lCqRdM2MgIZwyDtNuk0USpa4ACXXnozYpF0B/+CRv
 AnGJFwNLLzrUa1Z0fz7c8rcy92nJfOc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-q77b4VOKPl2HlPp3McsalA-1; Fri, 13 Jun 2025 10:12:39 -0400
X-MC-Unique: q77b4VOKPl2HlPp3McsalA-1
X-Mimecast-MFC-AGG-ID: q77b4VOKPl2HlPp3McsalA_1749823958
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4a57fea76beso44151141cf.0
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 07:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749823958; x=1750428758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Ovn9cHFbbOnzTL416BsSHaOjwFIm9cgFfee3HTO6y8=;
 b=O6xcONZxR5iZYnQ8Amfe2toI3TX6QKG8frD+yrUW7Err4V/wZkucdTZyTttMwhSSie
 LybD2SIzuKUPHBQtNPu0zh3gnYwW7DpdRsxV/M77JHq8X4K+XEC9YKyX51Ckpr1HKyal
 WlQJyMwX8tztU6RC+UV6ctVuw63QdBINtXhTWrGb7hd5hWd9wRQ+O2oFzaq+N/rr0n1v
 n2tPCxceFpxJVX8bq8aZW2RfOsEoQnZP/1iCaebp23kH+Ru7CG9Is6DR0ahF+tPwvYqf
 IaBRluDUeZYffXy57k5CR42oBOD/jGJIbwvHaBRNlke+DcY+tL96OeJidb9gxJph7KON
 QsNA==
X-Gm-Message-State: AOJu0YwMusoHHFan47d7aXOjkhHa7Zl3WouJXsAEoFHKoZRbCkkDOUr8
 m9jJE8RGrsmQFqapV0BJn6bKDFE0ZbhsAwxh5EGsnM+tt5aR+J2lE/iExWwG92gopsgkYiSafwc
 tEAtYFNncapZIUUjuxNt00yrwEowu5EMGy+C8hscNBO1gueYdPkePh4xlLGMfhDykBh+ZCLgtAB
 RvpyAtVUop2PTNzyoejj3Aj1uu6plnnD0Y0jx2cQ==
X-Gm-Gg: ASbGncuB37hT+3YcxjHy5v5W9lzXFUYOHrURLedCHSifO/klOKe+CFdUscG83llgu6h
 xvjysjAkGF3Kt49eixBC+0Kk7vzTaKiOkM3lR+//JjcyfgNZFrvRPV4HHCP+zETOVviVlTC4j9V
 Z9OIrcSYYTC4f30F9QkpJJjT8EwMRxUv/03DNh/gULrBB3I9m4EFOYZR+luJS3KwbNNDzMKeIif
 b2OMPuLqScbFsNnPVDlQDoEXndf/GEnHu/2Z2ZUCfoPHQSlouV3CuJHQAsFPUvwKL1FAVrrfZXK
 p1n9Pvu0n6Q=
X-Received: by 2002:a05:622a:580e:b0:4a6:eac8:58c6 with SMTP id
 d75a77b69052e-4a72fe7ac63mr65133621cf.13.1749823957439; 
 Fri, 13 Jun 2025 07:12:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGH/mc9he0aMumbb2nGu2xGorOI+nQbc920mlrtz3aeGfGomLV9dX5oLkQ7B/gtIjTlI/2XnA==
X-Received: by 2002:a05:622a:580e:b0:4a6:eac8:58c6 with SMTP id
 d75a77b69052e-4a72fe7ac63mr65132811cf.13.1749823956507; 
 Fri, 13 Jun 2025 07:12:36 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a72a526cc6sm17141641cf.79.2025.06.13.07.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 07:12:36 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mario Casquero <mcasquer@redhat.com>,
 Alexey Perevalov <a.perevalov@samsung.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3 13/14] migration/postcopy: blocktime allows track / report
 non-vCPU faults
Date: Fri, 13 Jun 2025 10:12:16 -0400
Message-ID: <20250613141217.474825-14-peterx@redhat.com>
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

When used to report page fault latencies, the blocktime feature can be
almost useless when KVM async page fault is enabled, because in most cases
such remote fault will kickoff async page faults, then it's not trackable
from blocktime layer.

After all these recent rewrites to blocktime layer, it's finally so easy to
also support tracking non-vCPU faults.  It'll be even faster if we could
always index fault records with TIDs, unfortunately we need to maintain the
blocktime API which report things in vCPU indexes.

Of course this can work not only for kworkers, but also any guest accesses
that may reach a missing page, for example, very likely when in the QEMU
main thread too (and all other threads whenever applicable).

In this case, we don't care about "how long the threads are blocked", but
we only care about "how long the fault will be resolved".

Cc: Markus Armbruster <armbru@redhat.com>
Cc: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Tested-by: Mario Casquero <mcasquer@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json                   | 12 ++++-
 migration/migration-hmp-cmds.c        |  5 +++
 migration/postcopy-ram.c              | 64 +++++++++++++++++++++------
 tests/qtest/migration/migration-qmp.c |  1 +
 migration/trace-events                |  2 +-
 5 files changed, 67 insertions(+), 17 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 30302f36cf..0f5b2d914c 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -247,6 +247,12 @@
 #     this is the per-vCPU statistics.  This is only present when the
 #     postcopy-blocktime migration capability is enabled.  (Since 10.1)
 #
+# @postcopy-non-vcpu-latency: average remote page fault latency for all
+#     faults happend in non-vCPU threads (in ns).  It has the same
+#     definition of @postcopy-latency but this only provides statistics to
+#     non-vCPU faults.  This is only present when the postcopy-blocktime
+#     migration capability is enabled.  (Since 10.1)
+#
 # @socket-address: Only used for tcp, to know what the real port is
 #     (Since 4.0)
 #
@@ -273,8 +279,8 @@
 #
 # Features:
 #
-# @unstable: Members @postcopy-latency, @postcopy-vcpu-latency are
-#     experimental.
+# @unstable: Members @postcopy-latency, @postcopy-vcpu-latency,
+#     @postcopy-non-vcpu-latency are experimental.
 #
 # Since: 0.14
 ##
@@ -295,6 +301,8 @@
                'type': 'uint64', 'features': [ 'unstable' ] },
            '*postcopy-vcpu-latency': {
                'type': ['uint64'], 'features': [ 'unstable' ] },
+           '*postcopy-non-vcpu-latency': {
+               'type': 'uint64', 'features': [ 'unstable' ] },
            '*socket-address': ['SocketAddress'],
            '*dirty-limit-throttle-time-per-round': 'uint64',
            '*dirty-limit-ring-full-time': 'uint64'} }
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 8b3846dab5..e1f9530520 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -80,6 +80,11 @@ static void migration_dump_blocktime(Monitor *mon, MigrationInfo *info)
                        info->postcopy_latency);
     }
 
+    if (info->has_postcopy_non_vcpu_latency) {
+        monitor_printf(mon, "Postcopy non-vCPU Latencies (ns): %" PRIu64 "\n",
+                       info->postcopy_non_vcpu_latency);
+    }
+
     if (info->has_postcopy_vcpu_latency) {
         uint64List *item = info->postcopy_vcpu_latency;
         const char *sep = "";
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 91c23b446e..f4cb23b3e0 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -192,6 +192,8 @@ typedef struct PostcopyBlocktimeContext {
     GHashTable *tid_to_vcpu_hash;
     /* Count of non-vCPU faults.  This is only for debugging purpose. */
     uint64_t non_vcpu_faults;
+    /* total blocktime when a non-vCPU thread is stopped */
+    uint64_t non_vcpu_blocktime_total;
 
     /*
      * Handler for exit event, necessary for
@@ -203,7 +205,10 @@ typedef struct PostcopyBlocktimeContext {
 typedef struct {
     /* The time the fault was triggered */
     uint64_t fault_time;
-    /* The vCPU index that was blocked */
+    /*
+     * The vCPU index that was blocked, when cpu==-1, it means it's a
+     * fault from non-vCPU threads.
+     */
     int cpu;
 } BlocktimeVCPUEntry;
 
@@ -344,6 +349,12 @@ void fill_destination_postcopy_migration_info(MigrationInfo *info)
         QAPI_LIST_PREPEND(list_latency, latency);
     }
 
+    latency_total += bc->non_vcpu_blocktime_total;
+    faults += bc->non_vcpu_faults;
+
+    info->has_postcopy_non_vcpu_latency = true;
+    info->postcopy_non_vcpu_latency = bc->non_vcpu_faults ?
+        (bc->non_vcpu_blocktime_total / bc->non_vcpu_faults) : 0;
     info->has_postcopy_blocktime = true;
     /* Convert ns -> ms */
     info->postcopy_blocktime = (uint32_t)(bc->total_blocktime / SCALE_MS);
@@ -983,7 +994,10 @@ static uint64_t get_current_ns(void)
     return (uint64_t)qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
 }
 
-/* Inject an (cpu, fault_time) entry into the database, using addr as key */
+/*
+ * Inject an (cpu, fault_time) entry into the database, using addr as key.
+ * When cpu==-1, it means it's a non-vCPU fault.
+ */
 static void blocktime_fault_inject(PostcopyBlocktimeContext *ctx,
                                    uintptr_t addr, int cpu, uint64_t time)
 {
@@ -1066,9 +1080,17 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
         /* Making sure it won't overflow - it really should never! */
         assert(dc->vcpu_faults_current[cpu] <= 255);
     } else {
-        /* We do not support non-vCPU thread tracking yet */
+        /*
+         * For non-vCPU thread faults, we don't care about tid or cpu index
+         * or time the thread is blocked (e.g., a kworker trying to help
+         * KVM when async_pf=on is OK to be blocked and not affect guest
+         * responsiveness), but we care about latency.  Track it with
+         * cpu=-1.
+         *
+         * Note that this will NOT affect blocktime reports on vCPU being
+         * blocked, but only about system-wide latency reports.
+         */
         dc->non_vcpu_faults++;
-        return;
     }
 
     blocktime_fault_inject(dc, addr, cpu, current);
@@ -1078,6 +1100,7 @@ typedef struct {
     PostcopyBlocktimeContext *ctx;
     uint64_t current;
     int affected_cpus;
+    int affected_non_cpus;
 } BlockTimeVCPUIter;
 
 static void blocktime_cpu_list_iter_fn(gpointer data, gpointer user_data)
@@ -1085,6 +1108,7 @@ static void blocktime_cpu_list_iter_fn(gpointer data, gpointer user_data)
     BlockTimeVCPUIter *iter = user_data;
     PostcopyBlocktimeContext *ctx = iter->ctx;
     BlocktimeVCPUEntry *entry = data;
+    uint64_t time_passed;
     int cpu = entry->cpu;
 
     /*
@@ -1092,17 +1116,27 @@ static void blocktime_cpu_list_iter_fn(gpointer data, gpointer user_data)
      * later than when it was faulted.
      */
     assert(iter->current >= entry->fault_time);
+    time_passed = iter->current - entry->fault_time;
 
-    /*
-     * If we resolved all pending faults on one vCPU due to this page
-     * resolution, take a note.
-     */
-    if (--ctx->vcpu_faults_current[cpu] == 0) {
-        ctx->vcpu_blocktime_total[cpu] += iter->current - entry->fault_time;
-        iter->affected_cpus += 1;
+    if (cpu >= 0) {
+        /*
+         * If we resolved all pending faults on one vCPU due to this page
+         * resolution, take a note.
+         */
+        if (--ctx->vcpu_faults_current[cpu] == 0) {
+            ctx->vcpu_blocktime_total[cpu] += time_passed;
+            iter->affected_cpus += 1;
+        }
+        trace_postcopy_blocktime_end_one(cpu, ctx->vcpu_faults_current[cpu]);
+    } else {
+        iter->affected_non_cpus++;
+        ctx->non_vcpu_blocktime_total += time_passed;
+        /*
+         * We do not maintain how many pending non-vCPU faults because we
+         * do not care about blocktime, only latency.
+         */
+        trace_postcopy_blocktime_end_one(-1, 0);
     }
-
-    trace_postcopy_blocktime_end_one(cpu, ctx->vcpu_faults_current[cpu]);
 }
 
 /*
@@ -1141,6 +1175,7 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
     BlockTimeVCPUIter iter = {
         .current = get_current_ns(),
         .affected_cpus = 0,
+        .affected_non_cpus = 0,
         .ctx = dc,
     };
     gpointer key = (gpointer)addr;
@@ -1174,7 +1209,8 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
     }
     dc->smp_cpus_down -= iter.affected_cpus;
 
-    trace_postcopy_blocktime_end(addr, iter.current, iter.affected_cpus);
+    trace_postcopy_blocktime_end(addr, iter.current, iter.affected_cpus,
+                                 iter.affected_non_cpus);
 }
 
 static void postcopy_pause_fault_thread(MigrationIncomingState *mis)
diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
index 1a5ab2d229..67a67d4bd6 100644
--- a/tests/qtest/migration/migration-qmp.c
+++ b/tests/qtest/migration/migration-qmp.c
@@ -361,6 +361,7 @@ void read_blocktime(QTestState *who)
     g_assert(qdict_haskey(rsp_return, "postcopy-vcpu-blocktime"));
     g_assert(qdict_haskey(rsp_return, "postcopy-latency"));
     g_assert(qdict_haskey(rsp_return, "postcopy-vcpu-latency"));
+    g_assert(qdict_haskey(rsp_return, "postcopy-non-vcpu-latency"));
     qobject_unref(rsp_return);
 }
 
diff --git a/migration/trace-events b/migration/trace-events
index a36a78f01a..706db97def 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -310,7 +310,7 @@ postcopy_preempt_thread_entry(void) ""
 postcopy_preempt_thread_exit(void) ""
 postcopy_blocktime_tid_cpu_map(int cpu, uint32_t tid) "cpu: %d, tid: %u"
 postcopy_blocktime_begin(uint64_t addr, uint64_t time, int cpu, bool exists) "addr: 0x%" PRIx64 ", time: %" PRIu64 ", cpu: %d, exist: %d"
-postcopy_blocktime_end(uint64_t addr, uint64_t time, int affected_cpu) "addr: 0x%" PRIx64 ", time: %" PRIu64 ", affected_cpus: %d"
+postcopy_blocktime_end(uint64_t addr, uint64_t time, int affected_cpu, int affected_non_cpus) "addr: 0x%" PRIx64 ", time: %" PRIu64 ", affected_cpus: %d, affected_non_cpus: %d"
 postcopy_blocktime_end_one(int cpu, uint8_t left_faults) "cpu: %d, left_faults: %" PRIu8
 
 # exec.c
-- 
2.49.0


