Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE730C71136
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 14:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ59I-0003zD-KL; Fri, 13 Jun 2025 10:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ59G-0003wB-9n
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:12:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ59E-0002MD-Aa
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:12:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749823965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WoyVijN1yRvTAaSZuMNvRxWVoxh2shcYGdBrpGC1Skg=;
 b=CsZaAQx/SNrQmka65taFrOmODeblKtEZIdTSpjP5mPJodujC8PXF4+V/5k4OaSOobKfhmF
 nJspJ6p8zxDuRxc7WVY4oh+Z24QZ8dZC3VFs0SoFL/8eybDNDFB9pAMo61dGbL4o4ibk1y
 y93o9TK0+jvBmwQyzo5D9BIvZu6Sjgg=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-oinI28isMT6yEq2m4q9C5g-1; Fri, 13 Jun 2025 10:12:44 -0400
X-MC-Unique: oinI28isMT6yEq2m4q9C5g-1
X-Mimecast-MFC-AGG-ID: oinI28isMT6yEq2m4q9C5g_1749823963
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-2e43c3e66d1so1717228fac.1
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 07:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749823963; x=1750428763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WoyVijN1yRvTAaSZuMNvRxWVoxh2shcYGdBrpGC1Skg=;
 b=tv/D+iufGkQ5bGiks29SjojP8GWoTeAVcHLPej/7vw1140uvuGxdJ4SRmlwfDqbA8Z
 Jx0P1ZbkOUR209UfCpO8OFgt3kU13OsbEULFKZ6TCcAHXiLQuM2AbByy9R54LOD7QORd
 PafbevQKv6nc8gfqIsNoyiN4kTDSA85hbj7FgsOASGOyfvbXfx4wc/29qrwCbW04owNp
 BGg2dthVUgVIu1AwTBtv5ucajSx8cPuiHUYG7IzOPj2yacQMLnbG00xPPp32dof9FX0G
 6esrcTdwC2lrder5KpIfY//29iu/aXVyuuiBch1IL/bDsjXBbXPnr1VjV9FLX6viI+jO
 p7CQ==
X-Gm-Message-State: AOJu0Yxny0kT3llobCNVEpr7l1/fIJqknSFYmPCSaiWgIO0oMg8ow3db
 kkiOvbTwS9Xfb/8lsThWDAKedHji4QZxazbOP0kkd+bUKSgiSOD5ZUuRlRu5S+IVfroQXqRGKrJ
 NKwxEaB4d/LqT2QsN9U5K3vzzmT2ZpLRpLF3zMDCXkLQj5Wokk4JzqQoABIIGBxf0ueTMPHS6nh
 jmM6uM5ELjdvkI7sKkLzgiQ4OaWxW3Kjxuvy+/QQ==
X-Gm-Gg: ASbGncvwIY4hyp67YO+uWyjOTx+IoTVBgflvIhRM+m9c8FBHJ0LZn+o+hYyunHwaCgU
 mhjqWolv0cwIeE3re7nfRJx+APRtiGQv8elM0U01Hvh6Q4HpALDHu1TjvFg8Hhe2Auc+fcJHJcf
 mfTg8wZxWsVX4AQd5Au5lnIzEVR0pxprXLpn8XrS4Q0nzx/ef8HW6GpDnscULLOyqBzrm/kfWs2
 Vi6ePWsi1qohhXrTxY6nsFciyP37yE8KNcwP5YpVkB8dYcrGDQkY55Ch3MI6BqNtwNWmZloRqci
 fllfns70irs=
X-Received: by 2002:a05:6870:600a:20b0:2d4:7cfa:6f3 with SMTP id
 586e51a60fabf-2ead50802d6mr1226820fac.20.1749823963005; 
 Fri, 13 Jun 2025 07:12:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4sUd5B0w4oGaKA64X0MBwRFiOrkJbrG4K9/SIGvbWADKmFyZsYGptyk6ai1SetBxBhEh1cQ==
X-Received: by 2002:a05:622a:8ce:b0:4a6:f3f7:4c2b with SMTP id
 d75a77b69052e-4a72ff335camr48454221cf.51.1749823951563; 
 Fri, 13 Jun 2025 07:12:31 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a72a526cc6sm17141641cf.79.2025.06.13.07.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 07:12:31 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mario Casquero <mcasquer@redhat.com>,
 Alexey Perevalov <a.perevalov@samsung.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 10/14] migration/postcopy: Cache the tid->vcpu mapping for
 blocktime
Date: Fri, 13 Jun 2025 10:12:13 -0400
Message-ID: <20250613141217.474825-11-peterx@redhat.com>
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

Looking up the vCPU index for each fault can be expensive when there're
hundreds of vCPUs.  Provide a cache for tid->vcpu instead with a hash
table, then lookup from there.

When at it, add another counter to record how many non-vCPU faults it gets.
For example, the main thread can also access a guest page that was missing.
These kind of faults are not accounted by blocktime so far.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 68 ++++++++++++++++++++++++++++++++++------
 migration/trace-events   |  3 +-
 2 files changed, 59 insertions(+), 12 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index dd3615663f..bf65d6035c 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -127,6 +127,17 @@ typedef struct PostcopyBlocktimeContext {
     /* number of vCPU are suspended */
     int smp_cpus_down;
 
+    /*
+     * Fast path for looking up vcpu_index from tid.  NOTE: this result
+     * only reflects the vcpu setup when postcopy is running.  It may not
+     * always match with the current vcpu setup because vcpus can be hot
+     * attached/detached after migration completes.  However this should be
+     * stable when blocktime is using the structure.
+     */
+    GHashTable *tid_to_vcpu_hash;
+    /* Count of non-vCPU faults.  This is only for debugging purpose. */
+    uint64_t non_vcpu_faults;
+
     /*
      * Handler for exit event, necessary for
      * releasing whole blocktime_ctx
@@ -136,6 +147,7 @@ typedef struct PostcopyBlocktimeContext {
 
 static void destroy_blocktime_context(struct PostcopyBlocktimeContext *ctx)
 {
+    g_hash_table_destroy(ctx->tid_to_vcpu_hash);
     g_free(ctx->vcpu_blocktime_start);
     g_free(ctx->vcpu_blocktime_total);
     g_free(ctx->vcpu_faults_count);
@@ -150,6 +162,36 @@ static void migration_exit_cb(Notifier *n, void *data)
     destroy_blocktime_context(ctx);
 }
 
+static GHashTable *blocktime_init_tid_to_vcpu_hash(void)
+{
+    /*
+     * TID as an unsigned int can be directly used as the key.  However,
+     * CPU index can NOT be directly used as value, because CPU index can
+     * be 0, which means NULL.  Then when lookup we can never know whether
+     * it's 0 or "not found".  Hence use an indirection for CPU index.
+     */
+    GHashTable *table = g_hash_table_new_full(g_direct_hash, g_direct_equal,
+                                              NULL, g_free);
+    CPUState *cpu;
+
+    /*
+     * Initialize the tid->cpu_id mapping for lookups.  The caller needs to
+     * make sure when reaching here the CPU topology is frozen and will be
+     * stable for the whole blocktime trapping period.
+     */
+    CPU_FOREACH(cpu) {
+        int *value = g_new(int, 1);
+
+        *value = cpu->cpu_index;
+        g_hash_table_insert(table,
+                            GUINT_TO_POINTER((uint32_t)cpu->thread_id),
+                            value);
+        trace_postcopy_blocktime_tid_cpu_map(cpu->cpu_index, cpu->thread_id);
+    }
+
+    return table;
+}
+
 static struct PostcopyBlocktimeContext *blocktime_context_new(void)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
@@ -160,6 +202,8 @@ static struct PostcopyBlocktimeContext *blocktime_context_new(void)
     ctx->vcpu_blocktime_total = g_new0(uint64_t, smp_cpus);
     ctx->vcpu_faults_count = g_new0(uint64_t, smp_cpus);
     ctx->vcpu_addr = g_new0(uintptr_t, smp_cpus);
+    ctx->tid_to_vcpu_hash = blocktime_init_tid_to_vcpu_hash();
+
     ctx->exit_notifier.notify = migration_exit_cb;
     qemu_add_exit_notifier(&ctx->exit_notifier);
 
@@ -827,18 +871,21 @@ int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
     return 0;
 }
 
-static int get_mem_fault_cpu_index(uint32_t pid)
+static int blocktime_get_vcpu(PostcopyBlocktimeContext *ctx, uint32_t tid)
 {
-    CPUState *cpu_iter;
+    int *found;
 
-    CPU_FOREACH(cpu_iter) {
-        if (cpu_iter->thread_id == pid) {
-            trace_get_mem_fault_cpu_index(cpu_iter->cpu_index, pid);
-            return cpu_iter->cpu_index;
-        }
+    found = g_hash_table_lookup(ctx->tid_to_vcpu_hash, GUINT_TO_POINTER(tid));
+    if (!found) {
+        /*
+         * NOTE: this is possible, because QEMU's non-vCPU threads can
+         * also access a missing page.  Or, when KVM async pf is enabled, a
+         * fault can even happen from a kworker..
+         */
+        return -1;
     }
-    trace_get_mem_fault_cpu_index(-1, pid);
-    return -1;
+
+    return *found;
 }
 
 static uint64_t get_current_ns(void)
@@ -865,8 +912,9 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
     if (!dc || ptid == 0) {
         return;
     }
-    cpu = get_mem_fault_cpu_index(ptid);
+    cpu = blocktime_get_vcpu(dc, ptid);
     if (cpu < 0) {
+        dc->non_vcpu_faults++;
         return;
     }
 
diff --git a/migration/trace-events b/migration/trace-events
index 02cdb6e7cc..9c1f3b7044 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -310,8 +310,7 @@ postcopy_preempt_tls_handshake(void) ""
 postcopy_preempt_new_channel(void) ""
 postcopy_preempt_thread_entry(void) ""
 postcopy_preempt_thread_exit(void) ""
-
-get_mem_fault_cpu_index(int cpu, uint32_t pid) "cpu: %d, pid: %u"
+postcopy_blocktime_tid_cpu_map(int cpu, uint32_t tid) "cpu: %d, tid: %u"
 
 # exec.c
 migration_exec_outgoing(const char *cmd) "cmd=%s"
-- 
2.49.0


