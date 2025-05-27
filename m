Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE379C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 23:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK3U2-0003LO-AH; Tue, 27 May 2025 19:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK3U1-0003LF-6d
 for qemu-devel@nongnu.org; Tue, 27 May 2025 19:13:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK3Tz-0001GU-5w
 for qemu-devel@nongnu.org; Tue, 27 May 2025 19:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748387598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=almEcPBg42VMuICV9qumc+0V+ZU5Aoz/MV/O8MQua0c=;
 b=UWp6XFsHbIg5gK8e33tn7j278CZmd7l/Wr7qOzR3b8HeSpYwm7pTJDOnXn+DM6BBHxVX9L
 F0bHlLZHGaIhA+sC48z5YJ26I1Ekb8mQpvfXvf6qAqLYfSbSlceE57AvW2ubhGCxCdz9W/
 Yb9THSHoFnnPj8smb4kAZHVFjEsVhC0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-8sZa0iaMM3-tQj9cKylQ0w-1; Tue, 27 May 2025 19:13:17 -0400
X-MC-Unique: 8sZa0iaMM3-tQj9cKylQ0w-1
X-Mimecast-MFC-AGG-ID: 8sZa0iaMM3-tQj9cKylQ0w_1748387597
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4767bab171dso34760021cf.1
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 16:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748387596; x=1748992396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=almEcPBg42VMuICV9qumc+0V+ZU5Aoz/MV/O8MQua0c=;
 b=bBY1aW4fmQUMs7IaYuuk/K5vsjz1y4okB7ruBrkmnSIrRAAcGQmD8mlTgKryKbCb7j
 5hY/sEBKr/TTkulaPP/TP+/Or+/KE74855/N1ezSnRJIGDKFAv+G2YgsoALaK0Aj6lfl
 TAXuPfmKUK6BWnuil3J6CJSVaTjyvYFzfFEzO2coSq8knmwiKz82ewtYqpjXxuDUsZ+k
 9A3faLZO1syx+WEDaLghqQ4VbNP94PpbCEg5ChDNyFP4eE6i9A0vDgQFyDMxht/epStT
 wdJcK7Ef3V/BVev80sccOw6Vxu1XAFLPLZ6kFilqRXB4pGDLkACpqF2aUBSZVTSoQGEE
 O0Iw==
X-Gm-Message-State: AOJu0YyB3Gqm2DCJpjNkgA7D4DNmJvt68Tfw4fDKw+SOW0AhHgBevbit
 5W1qwT4M0LTbwyU6KKhcQeVA2wrq7b6EOjztOEPTOVnV93eJEzhiQfsOZtAa61tYWDGQZhuUOXX
 XIKe1H7wwhUimesGmwkrsqYxhzdVXGLiC7tZ+FHy49Moci5BSUIzE149f5DJUz8UbUte7eqnFhs
 eiUmYbHaedECjAvY5rdn8t7t7y1uyKK7Nd1LuMFw==
X-Gm-Gg: ASbGncstG5HtEZbw3y1cnztNyfT7SNm6z49aK7vG4rL0p0jix+OPtilJ8rnzAnU2WYE
 DjcvHHSUW2FnloMXlPlSW+oGUjRIq963jJwY6yxkj68ktxH3xgP8b0D2odtsKE3cet6fA5BpdAo
 1JyLO19JoUEsDUQziZbX74WOYFcqCZ6rBGU1kP9+fzzOk+Ua54Mw5N3SdW9MikTaALs0uODZQSN
 h9ZHGI5NdAufNdEAGGxXp/xqNTmhTBMq4M+I8IfZHCAYassjNcBHNYODZD1/ie2vruFWcP9jqXQ
X-Received: by 2002:a05:622a:4c0e:b0:494:af82:7804 with SMTP id
 d75a77b69052e-49f46e41135mr249614721cf.29.1748387596409; 
 Tue, 27 May 2025 16:13:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoMTD7dUUuRYmBAE0vc91/Zv+uXWyW7DnzrG018RVhE03Et2KM56h7btdPmdL1oNzXDhmnjA==
X-Received: by 2002:a05:622a:4c0e:b0:494:af82:7804 with SMTP id
 d75a77b69052e-49f46e41135mr249614141cf.29.1748387595875; 
 Tue, 27 May 2025 16:13:15 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a2f939cad3sm1984441cf.79.2025.05.27.16.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 16:13:14 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Alexey Perevalov <a.perevalov@samsung.com>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 13/13] migration/postcopy: blocktime allows track / report
 non-vCPU faults
Date: Tue, 27 May 2025 19:12:48 -0400
Message-ID: <20250527231248.1279174-14-peterx@redhat.com>
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
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json                   |  7 +++
 migration/migration-hmp-cmds.c        |  5 +++
 migration/postcopy-ram.c              | 64 +++++++++++++++++++++------
 tests/qtest/migration/migration-qmp.c |  1 +
 migration/trace-events                |  2 +-
 5 files changed, 64 insertions(+), 15 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 8b13cea169..f59c473842 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -247,6 +247,12 @@
 #     this is the per-vCPU statistics. This is only present when the
 #     postcopy-blocktime migration capability is enabled.  (Since 10.1)
 #
+# @postcopy-non-vcpu-latency: average remote page fault latency for all
+#     faults happend in non-vCPU threads (in us).  It has the same
+#     definition of @postcopy-latency but this only provides statistics to
+#     non-vCPU faults. This is only present when the postcopy-blocktime
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
index a18049a7e8..bdfc754d70 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -81,6 +81,11 @@ static void migration_dump_blocktime(Monitor *mon, MigrationInfo *info)
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
index 066dc9f3ce..bc6736f262 100644
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
+         * blocked, but only about system-wise latency reports.
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


