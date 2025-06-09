Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEACC61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 19:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOhwC-0006Us-VH; Mon, 09 Jun 2025 15:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOhwB-0006Ug-Rv
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:13:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOhw9-0000t1-SF
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749496416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=23L5yPZvHG4Cl7o3uwV6lHe0CI7eepSc2KOqycRd62o=;
 b=ecf9L0GoIairV+52xAvaIsg8leJiRp6EoTUjl9VxqE4vT3x91TW+8VD1SXVGAPKXMcvpm/
 4mykBZlE/ue6ibxSh7b89UHQRQ+c/3dQfl0DsofmlQ3C2bixiqqr+tjV9pYBApu4SYQVos
 4WKzs8zlExDFP15YdIgS4ZDEP/pvOjw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-mvvtdy2bMtiJHXhAcf4-vw-1; Mon, 09 Jun 2025 15:13:34 -0400
X-MC-Unique: mvvtdy2bMtiJHXhAcf4-vw-1
X-Mimecast-MFC-AGG-ID: mvvtdy2bMtiJHXhAcf4-vw_1749496413
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6faca0f2677so130862716d6.1
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 12:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749496413; x=1750101213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=23L5yPZvHG4Cl7o3uwV6lHe0CI7eepSc2KOqycRd62o=;
 b=SKRqU7XxnGwN1wNT4ZS+XG2HMZDFeb8VMGu66S5LfCgLMjjUUf9gj4EhmP5XUQEsmd
 4fe0/kKa1rHT2tjk7xH/EVXacVsFbd/iQJDis5dTv6v9fYaljYCmPm7ryv7+WYCrEs00
 tE+0kwjnTKv59ik9r6/K/Cw2wqNJSlLKEcN3C3ZkSYzzTrRsFKdEItnOC7EHw/hNDhkx
 6CGbStV6ENIphbyVy+TBvwwDUayYY9lGQCqmbVVOVc6ON5gxIm/eiT480qMV+xVix08W
 dhQMZ6R7ptIqIAsVRC28xV+rS9119SSm8OPsChqFczO7mKvFng/6hOplNycydtL+rWzr
 RVAw==
X-Gm-Message-State: AOJu0YzpYg/w6ZsjumKciGU8ZaKpG/delXodBfWu8B0LSodMZMmkQgLh
 Wj5r6P9dJZZnwyKJmzdll9nLDS7qnI8Kz2D6bmZsniyFhXS+pUeouCoAQ7uNqMX9GUcW873aPSo
 +xfZS0Ol96GCM22DBORmmquVA4Pt4pEvemprlTSgYx/s4g3864oEdENjzt8JRz+p40kFFRkMekL
 /Y2hZ9X9MPxPG3YJDa5v4BCJCUKYyVSHE4yWmXFw==
X-Gm-Gg: ASbGncu4nERifnhC+ug/Hzy0chc91uyW6u5Y6PpOoLefdi7yuusvJoT4NhaLW/ZOHKJ
 xlJnVoCqwJFFRMWwqKTx5AKQbNjyvEph9u4zv58cCC/fGLM0ubJX8EBkAPN08/EpBv//IeldDbU
 qdkiK8DsUDu+lMTKfc4DbkDMUGudZmayTxrbpZIRVqkK2T6Qeo7P8INYKof8f+slMrfo2QxhIcu
 9Uc7rI1+Zhn8kO4R+GNxC3XenNPCvxMT/mqAYdty5XuR9vAEt32r08AwiDjx32O8cbF/nXQg38t
 NvM=
X-Received: by 2002:a05:6214:27ec:b0:6fa:c44f:2ae6 with SMTP id
 6a1803df08f44-6fb09054ff9mr257225746d6.38.1749496412707; 
 Mon, 09 Jun 2025 12:13:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHF96GhhxhC92Zns2AttJG0MFbA1nfpHLr3jh80NrwM9NjgrLAy87gpg+uUg5Zm/RSUhFB9HQ==
X-Received: by 2002:a05:6214:4106:b0:6fa:cb97:9722 with SMTP id
 6a1803df08f44-6fb0903b447mr242966006d6.34.1749496396377; 
 Mon, 09 Jun 2025 12:13:16 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09b1cc24sm55178856d6.72.2025.06.09.12.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 12:13:15 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>,
 Juraj Marcin <jmarcin@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 10/13] migration/postcopy: Cache the tid->vcpu mapping for
 blocktime
Date: Mon,  9 Jun 2025 15:12:56 -0400
Message-ID: <20250609191259.9053-11-peterx@redhat.com>
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
index 6ed4546744..494bfbab71 100644
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
+    */
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
 
@@ -826,18 +870,21 @@ int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
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
 
 static uint64_t get_current_us(void)
@@ -864,8 +911,9 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
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


