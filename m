Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF1CC61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 19:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOhw4-0006QW-AD; Mon, 09 Jun 2025 15:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOhw1-0006PX-Ag
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:13:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOhvx-0000ri-L0
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749496404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H+0dxBgcrJD05UEZ9RtM2gpVlmr//hQAVm1OfgwPSoM=;
 b=JEFB8qyp0p5E3ONPgMTDRmDpu8xZ8jClMwbzPw2go8Lu7TEpeUQuZVKPwZFN61KrSsaHaC
 iOWmq6U6Bky9uutxNP8ukuaAnVMZn4kBickA5Ll1SFNubrCapNu6UvPTDV6smc0R85FRmR
 uKrBPo8+c6l1afrwK4N0jaCAQPtg1Ns=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-IIl2SZHEPYGg_vaVI7c6hg-1; Mon, 09 Jun 2025 15:13:23 -0400
X-MC-Unique: IIl2SZHEPYGg_vaVI7c6hg-1
X-Mimecast-MFC-AGG-ID: IIl2SZHEPYGg_vaVI7c6hg_1749496403
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6fb1c6b5ea7so21570146d6.0
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 12:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749496402; x=1750101202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H+0dxBgcrJD05UEZ9RtM2gpVlmr//hQAVm1OfgwPSoM=;
 b=nDxUzZlWA+4QZPXV+BrmltFuiB8VgicnVZDQC81ehVtFON90tBnBD479wtBcJ70RXx
 ETsJ4pieoo9mrphhgCoGofuFYGwc42FP/aguKEIHGaBeUWIlJMyqMCaZAlM4sGfa6hUB
 GsWAhJtEfe1ZhHmyFS3hWc9xPrXu0yc9XFpRQ/bh7BT/aBo0P7MZc0fmDYdz0gJVbN9W
 QJ0cnuLjTpkS9oebvFNg33WUBpT3rJF4MnCvY1sBWohkp9H0lFzAJCsq0KtrrlAz/kSa
 boqEvvl9h4ierksIQHH/JEyd36I3q+gpL1j1wx+mTxAkZDOGhSueEtqmQ8vhRUnE/314
 9Hgg==
X-Gm-Message-State: AOJu0YxRHBYn/Z22cDv6ND4jUWZgFKaoLqDqCcWIlyEyMDeUAFtdPmRo
 UE01EIyNmyCdryGsRCuuffiZA+A86AHFAjgKaFmblg5tMIbwWKcfviviLEdKvxfdVxOrYnrj5nS
 KrYhrv0ny7oX6sW7Ocklw+yVLRwUEcp6vZJQ+FhuXi91CghsGS9e1Mt9mjHSL/Cn7rPrIDXQH/k
 xsjtTFzOBBX+HkuC23NLeW3BUvfKHywV6iY9ujQQ==
X-Gm-Gg: ASbGncvtHr5u+IrQKtLN3HqPOGtlBDBkxyI51OKY7DuwDnee4xBMPYwpjyunGuuiPC/
 2wX+sQt88CLjKkJX62MGAB7rqOedItPUNQbd6Ua0TFFXkeeV1VI1oF86exNMkC8MrfdfNmhuudh
 s4Wjj7ybKryXTmLOrKet7saqvjFhlnkKral8uKfDc9OfNAHC2XAoon2Q/dvua6KVbPi0CpJQZNu
 4WJcrzT56/nkyW1M5kqKpzoMHcwJoNTP17W3S/ITpRBFaDFKSpyEChyjDghvxedqIhZisOhW15L
 iBjDkfjhVZXhjQ==
X-Received: by 2002:a05:6214:1d02:b0:6fa:c45e:34cb with SMTP id
 6a1803df08f44-6fb08f4f424mr220899166d6.5.1749496402457; 
 Mon, 09 Jun 2025 12:13:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSfmD8FfGk6IDmZYYwqE/naqggarJRNB/qS7CjmEcJuWUkdH70aGMZQ0vtqtwML4KUd8VpjQ==
X-Received: by 2002:a05:6214:1d02:b0:6fa:c45e:34cb with SMTP id
 6a1803df08f44-6fb08f4f424mr220898706d6.5.1749496401879; 
 Mon, 09 Jun 2025 12:13:21 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09b1cc24sm55178856d6.72.2025.06.09.12.13.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 12:13:19 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>,
 Juraj Marcin <jmarcin@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 13/13] migration/postcopy: blocktime allows track / report
 non-vCPU faults
Date: Mon,  9 Jun 2025 15:12:59 -0400
Message-ID: <20250609191259.9053-14-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609191259.9053-1-peterx@redhat.com>
References: <20250609191259.9053-1-peterx@redhat.com>
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
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json                   |  7 +++
 migration/migration-hmp-cmds.c        |  5 +++
 migration/postcopy-ram.c              | 64 +++++++++++++++++++++------
 tests/qtest/migration/migration-qmp.c |  1 +
 migration/trace-events                |  2 +-
 5 files changed, 64 insertions(+), 15 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index e95b7402cb..cc680dda46 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -247,6 +247,12 @@
 #     this is the per-vCPU statistics.  This is only present when the
 #     postcopy-blocktime migration capability is enabled.  (Since 10.1)
 #
+# @postcopy-non-vcpu-latency: average remote page fault latency for all
+#     faults happend in non-vCPU threads (in us).  It has the same
+#     definition of @postcopy-latency but this only provides statistics to
+#     non-vCPU faults.  This is only present when the postcopy-blocktime
+#     migration capability is enabled.  (Since 10.1)
+#
 # @socket-address: Only used for tcp, to know what the real port is
 #     (Since 4.0)
 #
@@ -288,6 +294,7 @@
            '*postcopy-vcpu-blocktime': ['uint32'],
            '*postcopy-latency': 'uint64',
            '*postcopy-vcpu-latency': ['uint64'],
+           '*postcopy-non-vcpu-latency': 'uint64',
            '*socket-address': ['SocketAddress'],
            '*dirty-limit-throttle-time-per-round': 'uint64',
            '*dirty-limit-ring-full-time': 'uint64'} }
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 600b0f8071..4445d6404f 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -80,6 +80,11 @@ static void migration_dump_blocktime(Monitor *mon, MigrationInfo *info)
                        info->postcopy_latency);
     }
 
+    if (info->has_postcopy_non_vcpu_latency) {
+        monitor_printf(mon, "Postcopy non-vCPU Latencies (us): %" PRIu64 "\n",
+                       info->postcopy_non_vcpu_latency);
+    }
+
     if (info->has_postcopy_vcpu_latency) {
         uint64List *item = info->postcopy_vcpu_latency;
         int count = 0;
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index fe0c2ce225..23332ef3dd 100644
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
     info->postcopy_blocktime = (uint32_t)(bc->total_blocktime / 1000);
     info->has_postcopy_vcpu_blocktime = true;
@@ -982,7 +993,10 @@ static uint64_t get_current_us(void)
     return (uint64_t)qemu_clock_get_us(QEMU_CLOCK_REALTIME);
 }
 
-/* Inject an (cpu, fault_time) entry into the database, using addr as key */
+/*
+ * Inject an (cpu, fault_time) entry into the database, using addr as key.
+ * When cpu==-1, it means it's a non-vCPU fault.
+ */
 static void blocktime_fault_inject(PostcopyBlocktimeContext *ctx,
                                    uintptr_t addr, int cpu, uint64_t time)
 {
@@ -1065,9 +1079,17 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
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
 
     blocktime_fault_inject(dc, addr, cpu, current_us);
@@ -1077,6 +1099,7 @@ typedef struct {
     PostcopyBlocktimeContext *ctx;
     uint64_t current_us;
     int affected_cpus;
+    int affected_non_cpus;
 } BlockTimeVCPUIter;
 
 static void blocktime_cpu_list_iter_fn(gpointer data, gpointer user_data)
@@ -1084,6 +1107,7 @@ static void blocktime_cpu_list_iter_fn(gpointer data, gpointer user_data)
     BlockTimeVCPUIter *iter = user_data;
     PostcopyBlocktimeContext *ctx = iter->ctx;
     BlocktimeVCPUEntry *entry = data;
+    uint64_t time_passed;
     int cpu = entry->cpu;
 
     /*
@@ -1091,17 +1115,27 @@ static void blocktime_cpu_list_iter_fn(gpointer data, gpointer user_data)
      * later than when it was faulted.
      */
     assert(iter->current_us >= entry->fault_time);
+    time_passed = iter->current_us - entry->fault_time;
 
-    /*
-     * If we resolved all pending faults on one vCPU due to this page
-     * resolution, take a note.
-     */
-    if (--ctx->vcpu_faults_current[cpu] == 0) {
-        ctx->vcpu_blocktime_total[cpu] += iter->current_us - entry->fault_time;
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
@@ -1140,6 +1174,7 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
     BlockTimeVCPUIter iter = {
         .current_us = get_current_us(),
         .affected_cpus = 0,
+        .affected_non_cpus = 0,
         .ctx = dc,
     };
     gpointer key = (gpointer)addr;
@@ -1173,7 +1208,8 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
     }
     dc->smp_cpus_down -= iter.affected_cpus;
 
-    trace_postcopy_blocktime_end(addr, iter.current_us, iter.affected_cpus);
+    trace_postcopy_blocktime_end(addr, iter.current_us, iter.affected_cpus,
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


