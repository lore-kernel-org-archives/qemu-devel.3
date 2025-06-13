Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469D9C71136
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 14:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ59J-0003zu-Cn; Fri, 13 Jun 2025 10:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ59E-0003vk-NX
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:12:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ595-0002J0-NW
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749823946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0Az667joB4gI82vBdp1u3ODjK+SK+os4hYO97NJz8d8=;
 b=CAVt8Smc5wuR2Zq/eaf5sKAuL5Lqym8U4OXusqFIMi/Vgt5s0qXiT2hFtvFIYiwqwBM6sX
 kEwZfHFql8hIEKq18DaqWSkukaQDf7foMuujG/0bgqqNmnZnA9yLsRR5Psm53HtVv8NkR2
 u5GoJ7wK/rCNy75IsaBdsLF0iAGZAsI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-obcCNvy0OGyNCUTCZAIysA-1; Fri, 13 Jun 2025 10:12:24 -0400
X-MC-Unique: obcCNvy0OGyNCUTCZAIysA-1
X-Mimecast-MFC-AGG-ID: obcCNvy0OGyNCUTCZAIysA_1749823944
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4a587a96f0aso58798251cf.3
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 07:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749823944; x=1750428744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Az667joB4gI82vBdp1u3ODjK+SK+os4hYO97NJz8d8=;
 b=LhA8AlO+l5l/Ebvi9y2Zmmlza4S1Mp7rM+a+2Hg+wa1tQD2R8Syrrxgjw4EM07eLU/
 PGfekzpeFk8UTLi5W5jhB+9TfB3d01AN3AcsSOlXFKnycqolk8xm7t+3sEazvZqDBOTF
 RydXgFz6u+AvrViq0crWAq4giyHzmYxerXiLP9nWbal8PG9HutvPYimF3R4DriAELoBY
 IBvxP83P/RPjBRqod97K7yE3kyRhsbtIs7ofQORtFJOyKM4QpS9/dki1bmN+K5nvilOT
 yZi+Ff0wz7OEQzsuDy3gnjeZ+hgfB9lNiApwmJ8p36vkestU3zshM4FJNvkufYikjzL5
 umvg==
X-Gm-Message-State: AOJu0YxNNoqHJiye0kN+cqTfPs4ocsIznA8ANQ+HY/lV9GD0qX7dJoO5
 WbQStPuLOxdd6tZkQGTA5hy0kmNQtTzlEWSTMF5N9+Hd5waWpHtgsgi7IRzxQUUss+YS9Cq1Pf2
 oiNCud+o9v6ggYIfRZanTTnuYELRftsWRtGN0XJpDsyBWuNZ/JD9L+k1GEQBZPGudJ1al7qitHn
 xDu+xKjakTjZpBJYxsIHZbr/WU2wV48EmBpStdvw==
X-Gm-Gg: ASbGncvy+7STiD3qBrxTfvmhLQ/gwWiC+Mu0m3I6l1a4hBDgnuruSO6Q6XdV6yb5DBC
 T3o1feNaG1JoDeJONQl2HhLIQW5V1/TQkFmqAGIelwfbUsU7lD1761d1bXD4IZlKxbDXrly78A3
 58B7TmM8wVIkJzpj9s5gIoYKJkTryNWxwaw01U4xBhnWOSQJi/uTtsKIGqFbDEO7xvOSscrFG4g
 3gsxuh+RNpuhqr7p8A9AB/V/gA8p1hzrTPf9iY6pKTK298aF0QnYGIQHxSvFWVDDp1bAnxPOLcN
 FhzTusvjKmE=
X-Received: by 2002:a05:622a:191d:b0:4a5:aa42:49e9 with SMTP id
 d75a77b69052e-4a72fe9f8fbmr34453891cf.9.1749823943518; 
 Fri, 13 Jun 2025 07:12:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDaWfgk1OhjD9d6TgsebZpLyZRctw5Vf1Fu9fHwjVu+hqh8vrKzCeXxPv6NYXFQSQHZglnLw==
X-Received: by 2002:a05:622a:191d:b0:4a5:aa42:49e9 with SMTP id
 d75a77b69052e-4a72fe9f8fbmr34453371cf.9.1749823942687; 
 Fri, 13 Jun 2025 07:12:22 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a72a526cc6sm17141641cf.79.2025.06.13.07.12.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 07:12:22 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mario Casquero <mcasquer@redhat.com>,
 Alexey Perevalov <a.perevalov@samsung.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 02/14] migration/postcopy: Push blocktime start/end into
 page req mutex
Date: Fri, 13 Jun 2025 10:12:05 -0400
Message-ID: <20250613141217.474825-3-peterx@redhat.com>
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

The postcopy blocktime feature was tricky that it used quite some atomic
operations over quite a few arrays and vars, without explaining how that
would be thread safe.  The thread safety here is about concurrency between
the fault thread and the fault resolution threads, possible to access the
same chunk of data.  All these atomic ops can be expensive too before
knowing clearly how it works.

OTOH, postcopy has one page_request_mutex used to serialize the received
bitmap updates.  So far it's ok - we don't yet have a lot of threads
contending the lock.  It might change after multifd will be supported, but
that's a separate story.  What is important is, with that mutex, it's
pretty lightweight to move all the blocktime maintenance into the mutex
critical section.  It's because the blocktime layer is lightweighted:
almost "remember which vcpu faulted on which address", and "ok we get some
fault resolved, calculate how long it takes".  It's also an optional
feature for now (but I have thought of changing that, maybe in the future).

Let's push the blocktime layer into the mutex, so that it's always
thread-safe even without any atomic ops.

To achieve that, I'll need to add a tid parameter on fault path so that
it'll start to pass the faulted thread ID into deeper the stack, but not
too deep.  When at it, add a comment for the shared fault handler (for
example, vhost-user devices running with postcopy), to mention a TODO.  One
reason it might not be trivial is that vhost-user's userfaultfds should be
opened by vhost-user process, so it's pretty hard to control making sure
the TID feature will be around.  It wasn't supported before, so keep it
like that for now.

Now we should be as ease when everything is protected by a mutex that we
always take anyway.

One side effect: we can finally remove one ramblock_recv_bitmap_test() in
mark_postcopy_blocktime_begin(), which was pretty weird and which also
includes a weird (but maybe necessary.. but maybe not?) operation to inject
a blocktime entry then quickly erase it..  When we're with the mutex, and
when we make sure it's invoked after checking the receive bitmap, it's not
needed anymore.  Instead, we assert.

As another side effect, this paves way for removing all atomic ops in all
the mem accesses in blocktime layer.

Note that we need a stub for mark_postcopy_blocktime_begin() for Windows
builds.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h    |  2 +-
 migration/postcopy-ram.h |  2 ++
 migration/migration.c    | 25 +++++++++++-------
 migration/postcopy-ram.c | 56 +++++++++++++++++++++-------------------
 migration/trace-events   |  2 +-
 5 files changed, 48 insertions(+), 39 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 739289de93..01329bf824 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -546,7 +546,7 @@ void migrate_send_rp_shut(MigrationIncomingState *mis,
 void migrate_send_rp_pong(MigrationIncomingState *mis,
                           uint32_t value);
 int migrate_send_rp_req_pages(MigrationIncomingState *mis, RAMBlock *rb,
-                              ram_addr_t start, uint64_t haddr);
+                              ram_addr_t start, uint64_t haddr, uint32_t tid);
 int migrate_send_rp_message_req_pages(MigrationIncomingState *mis,
                                       RAMBlock *rb, ram_addr_t start);
 void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index a6df1b2811..3852141d7e 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -196,5 +196,7 @@ void postcopy_preempt_new_channel(MigrationIncomingState *mis, QEMUFile *file);
 void postcopy_preempt_setup(MigrationState *s);
 int postcopy_preempt_establish_channel(MigrationState *s);
 bool postcopy_is_paused(MigrationStatus status);
+void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
+                                   RAMBlock *rb);
 
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 923400f801..10c216d25d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -576,22 +576,27 @@ int migrate_send_rp_message_req_pages(MigrationIncomingState *mis,
 }
 
 int migrate_send_rp_req_pages(MigrationIncomingState *mis,
-                              RAMBlock *rb, ram_addr_t start, uint64_t haddr)
+                              RAMBlock *rb, ram_addr_t start, uint64_t haddr,
+                              uint32_t tid)
 {
     void *aligned = (void *)(uintptr_t)ROUND_DOWN(haddr, qemu_ram_pagesize(rb));
     bool received = false;
 
     WITH_QEMU_LOCK_GUARD(&mis->page_request_mutex) {
         received = ramblock_recv_bitmap_test_byte_offset(rb, start);
-        if (!received && !g_tree_lookup(mis->page_requested, aligned)) {
-            /*
-             * The page has not been received, and it's not yet in the page
-             * request list.  Queue it.  Set the value of element to 1, so that
-             * things like g_tree_lookup() will return TRUE (1) when found.
-             */
-            g_tree_insert(mis->page_requested, aligned, (gpointer)1);
-            qatomic_inc(&mis->page_requested_count);
-            trace_postcopy_page_req_add(aligned, mis->page_requested_count);
+        if (!received) {
+            if (!g_tree_lookup(mis->page_requested, aligned)) {
+                /*
+                 * The page has not been received, and it's not yet in the
+                 * page request list.  Queue it.  Set the value of element
+                 * to 1, so that things like g_tree_lookup() will return
+                 * TRUE (1) when found.
+                 */
+                g_tree_insert(mis->page_requested, aligned, (gpointer)1);
+                qatomic_inc(&mis->page_requested_count);
+                trace_postcopy_page_req_add(aligned, mis->page_requested_count);
+            }
+            mark_postcopy_blocktime_begin(haddr, tid, rb);
         }
     }
 
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 75fd310fb2..32fa06dabd 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -752,8 +752,12 @@ int postcopy_wake_shared(struct PostCopyFD *pcfd,
                        pagesize);
 }
 
+/*
+ * NOTE: @tid is only used when postcopy-blocktime feature is enabled, and
+ * also optional: when zero is provided, the fault accounting will be ignored.
+ */
 static int postcopy_request_page(MigrationIncomingState *mis, RAMBlock *rb,
-                                 ram_addr_t start, uint64_t haddr)
+                                 ram_addr_t start, uint64_t haddr, uint32_t tid)
 {
     void *aligned = (void *)(uintptr_t)ROUND_DOWN(haddr, qemu_ram_pagesize(rb));
 
@@ -772,7 +776,7 @@ static int postcopy_request_page(MigrationIncomingState *mis, RAMBlock *rb,
         return received ? 0 : postcopy_place_page_zero(mis, aligned, rb);
     }
 
-    return migrate_send_rp_req_pages(mis, rb, start, haddr);
+    return migrate_send_rp_req_pages(mis, rb, start, haddr, tid);
 }
 
 /*
@@ -793,7 +797,8 @@ int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
                                         qemu_ram_get_idstr(rb), rb_offset);
         return postcopy_wake_shared(pcfd, client_addr, rb);
     }
-    postcopy_request_page(mis, rb, aligned_rbo, client_addr);
+    /* TODO: support blocktime tracking */
+    postcopy_request_page(mis, rb, aligned_rbo, client_addr, 0);
     return 0;
 }
 
@@ -819,17 +824,17 @@ static uint32_t get_low_time_offset(PostcopyBlocktimeContext *dc)
 }
 
 /*
- * This function is being called when pagefault occurs. It
- * tracks down vCPU blocking time.
+ * This function is being called when pagefault occurs. It tracks down vCPU
+ * blocking time.  It's protected by @page_request_mutex.
  *
  * @addr: faulted host virtual address
  * @ptid: faulted process thread id
  * @rb: ramblock appropriate to addr
  */
-static void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
-                                          RAMBlock *rb)
+void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
+                                   RAMBlock *rb)
 {
-    int cpu, already_received;
+    int cpu;
     MigrationIncomingState *mis = migration_incoming_get_current();
     PostcopyBlocktimeContext *dc = mis->blocktime_ctx;
     uint32_t low_time_offset;
@@ -852,24 +857,19 @@ static void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
     qatomic_xchg(&dc->vcpu_addr[cpu], addr);
 
     /*
-     * check it here, not at the beginning of the function,
-     * due to, check could occur early than bitmap_set in
-     * qemu_ufd_copy_ioctl
+     * The caller should only inject a blocktime entry when the page is
+     * yet missing.
      */
-    already_received = ramblock_recv_bitmap_test(rb, (void *)addr);
-    if (already_received) {
-        qatomic_xchg(&dc->vcpu_addr[cpu], 0);
-        qatomic_xchg(&dc->page_fault_vcpu_time[cpu], 0);
-        qatomic_dec(&dc->smp_cpus_down);
-    }
+    assert(!ramblock_recv_bitmap_test(rb, (void *)addr));
+
     trace_mark_postcopy_blocktime_begin(addr, dc, dc->page_fault_vcpu_time[cpu],
-                                        cpu, already_received);
+                                        cpu);
 }
 
 /*
- *  This function just provide calculated blocktime per cpu and trace it.
- *  Total blocktime is calculated in mark_postcopy_blocktime_end.
- *
+ * This function just provide calculated blocktime per cpu and trace it.
+ * Total blocktime is calculated in mark_postcopy_blocktime_end.  It's
+ * protected by @page_request_mutex.
  *
  * Assume we have 3 CPU
  *
@@ -1068,17 +1068,14 @@ static void *postcopy_ram_fault_thread(void *opaque)
                                                 qemu_ram_get_idstr(rb),
                                                 rb_offset,
                                                 msg.arg.pagefault.feat.ptid);
-            mark_postcopy_blocktime_begin(
-                    (uintptr_t)(msg.arg.pagefault.address),
-                                msg.arg.pagefault.feat.ptid, rb);
-
 retry:
             /*
              * Send the request to the source - we want to request one
              * of our host page sizes (which is >= TPS)
              */
             ret = postcopy_request_page(mis, rb, rb_offset,
-                                        msg.arg.pagefault.address);
+                                        msg.arg.pagefault.address,
+                                        msg.arg.pagefault.feat.ptid);
             if (ret) {
                 /* May be network failure, try to wait for recovery */
                 postcopy_pause_fault_thread(mis);
@@ -1299,8 +1296,8 @@ static int qemu_ufd_copy_ioctl(MigrationIncomingState *mis, void *host_addr,
                 qemu_cond_signal(&mis->page_request_cond);
             }
         }
-        qemu_mutex_unlock(&mis->page_request_mutex);
         mark_postcopy_blocktime_end((uintptr_t)host_addr);
+        qemu_mutex_unlock(&mis->page_request_mutex);
     }
     return ret;
 }
@@ -1430,6 +1427,11 @@ int postcopy_wake_shared(struct PostCopyFD *pcfd,
 {
     g_assert_not_reached();
 }
+
+void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
+                                   RAMBlock *rb)
+{
+}
 #endif
 
 /* ------------------------------------------------------------------------- */
diff --git a/migration/trace-events b/migration/trace-events
index dcd8fe9a0c..917f521e88 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -285,7 +285,7 @@ postcopy_nhp_range(const char *ramblock, void *host_addr, size_t offset, size_t
 postcopy_place_page(void *host_addr) "host=%p"
 postcopy_place_page_zero(void *host_addr) "host=%p"
 postcopy_ram_enable_notify(void) ""
-mark_postcopy_blocktime_begin(uint64_t addr, void *dd, uint32_t time, int cpu, int received) "addr: 0x%" PRIx64 ", dd: %p, time: %u, cpu: %d, already_received: %d"
+mark_postcopy_blocktime_begin(uint64_t addr, void *dd, uint32_t time, int cpu) "addr: 0x%" PRIx64 ", dd: %p, time: %u, cpu: %d"
 mark_postcopy_blocktime_end(uint64_t addr, void *dd, uint32_t time, int affected_cpu) "addr: 0x%" PRIx64 ", dd: %p, time: %u, affected_cpu: %d"
 postcopy_pause_fault_thread(void) ""
 postcopy_pause_fault_thread_continued(void) ""
-- 
2.49.0


