Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E532C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 19:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOhvy-0006Ov-R6; Mon, 09 Jun 2025 15:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOhvx-0006Ol-L5
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:13:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOhvv-0000rR-2v
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749496402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kHz1ZiVNimjWbliZpLfjT529aWX8tmRyFQob+Z/E9kw=;
 b=eZoOhj0ScPzVhlQIjPECwLHKtSVpw3HQ3cb/B+1ggqN7NQaBvlKMaIkHohsAa3cEe1H4a0
 KvKtNwikgZSl58UlGAG6iVk5yJ1doKmROJMGNDvQdi+v7MOA7E3NgHfDLOEAuAtPwTXlXs
 Q/Rq9YqcuSbunHJPTsFx4/47W0U0CcE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-pFKHgP0SOjm1Uf1IBZGYBg-1; Mon, 09 Jun 2025 15:13:21 -0400
X-MC-Unique: pFKHgP0SOjm1Uf1IBZGYBg-1
X-Mimecast-MFC-AGG-ID: pFKHgP0SOjm1Uf1IBZGYBg_1749496401
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6fac71417c2so77106606d6.0
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 12:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749496400; x=1750101200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kHz1ZiVNimjWbliZpLfjT529aWX8tmRyFQob+Z/E9kw=;
 b=F8CXga9Nxz8J9NHF4MckktmqaMmSbgRnEruJX9mqnndd/2Anlj1rGvA+U0wOH2O4+N
 upX5JojZzZhyd07Noixod8CZ9/vV+bsKr9admcge2hHfyiP2FghxiXfs4UA8xRu7foy/
 EcF13dCt0lav+b2HWBF0i/QhcTozALLBGsLYflNHlz+yBKVQFglb8xl9AWnXSQsnZVUe
 SmN4B5OXIKtG2XbQsDspFV/4h2RmuvrUtd2auMKthSrOq4l1PSXBIoLh2H9ax7agoRaa
 VUmgDKonbdJMMuRIli+6I5w1JBZZb/dZEqb/1PmqHWCsBvtLtrZU4jTnC407cmQqifbG
 CfWA==
X-Gm-Message-State: AOJu0Yzl5p+lt9vY9Fjf3HRGYIC8KC70bE/cI51W0DYLPgasQ7/Eg07Y
 l/5PBXN5YNCx/07nDqmeJ976EIW9fL0m/ejSegiDlV5YtaD1ix18o9Mb8x+KJ1yzqjJIPnhGGBj
 aIt1lkOvcfYmXTJyLUgyFAOOwj1an2I5/ZfSnnrv0KrOnpj9U2me40+hVv0ofekbsm6Ty8BAZWp
 w9myEKU1SJ4RRYV2Pwjr+VVxaR0JRpVHn0gcgFeQ==
X-Gm-Gg: ASbGnctY0H2vVd4ODuM6LWEMtzl9MPTOie+uq/3TfESeR6kRIk3Z15qSb8DQQt9lku+
 YqyXczVO4Uzu/Fue526gjGG0arh1Xdofg+q5RUlJtbRYuoFGNGjHb54yJI5A9evCSwrVWbHNt5P
 7u9lbXStZYKRXdTvf6QgLSRNpEzho/YULLz2u49Ia5T0iLRVjJD6fNm4owYAFBDk3op+VtUPE6k
 waCSjR+7chm90NC688uVnRzlwWxhVGHaN4tSjbpczQPkbkWJFAUUvgje9m/UgTDZy4tuKbZ5JuQ
 wkBo1cLUTZ9rBA==
X-Received: by 2002:ad4:4529:0:b0:6fa:ac51:bbda with SMTP id
 6a1803df08f44-6fb08f63facmr163691436d6.26.1749496399357; 
 Mon, 09 Jun 2025 12:13:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiYOyA7VSNhTO72Ney1P5YTsJPhjlbBSxYrRMih3UJ2vlhIqxPwQJhLECGWllAlICrTYTjxA==
X-Received: by 2002:ad4:4529:0:b0:6fa:ac51:bbda with SMTP id
 6a1803df08f44-6fb08f63facmr163691026d6.26.1749496398741; 
 Mon, 09 Jun 2025 12:13:18 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09b1cc24sm55178856d6.72.2025.06.09.12.13.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 12:13:18 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>,
 Juraj Marcin <jmarcin@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 12/13] migration/postcopy: Optimize blocktime fault
 tracking with hashtable
Date: Mon,  9 Jun 2025 15:12:58 -0400
Message-ID: <20250609191259.9053-13-peterx@redhat.com>
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

Currently, the postcopy blocktime feature maintains vCPU fault information
using an array (vcpu_addr[]).  It has two issues.

Issue 1: Performance Concern
============================

The old algorithm was almost OK and fast on inserts, except that the lookup
is slow and won't scale if there are a lot of vCPUs: when a page is copied
during postcopy, mark_postcopy_blocktime_end() will walk the whole array
trying to find which vCPUs are blocked by the address.  So it needs
constant O(N) walk for each page resolution.

Alexey (the author of postcopy blocktime) mentioned the perf issue and how
to optimize it in a piece of comment in the page resolution path.  The
comment was (interestingly..) not complete, but it's relatively clear what
he wanted to say about this perf issue.

Issue 2: Wrong Accounting on re-entrancies
==========================================

People might think that each vCPU should only and always get one fault at a
time, so that when the blocktime layer captured one fault on one vCPU, we
should never see another fault message on this vCPU.

It's almost correct, except in some extreme rare cases.

Case 1: it's possible the fault thread processes the userfaultfd messages
too fast so it can see >1 messages on one vCPU before the previous one was
resolved.

Case 2: it's theoretically also possible one vCPU can get even more than
one message on the same fault address if a fault is retried by the
kernel (e.g., handle_userfault() got interrupted before page resolution).

As this info might be important, instead of using commit message, I put
more details into the code as comment, when introducing an array
maintaining concurrent faults on one vCPU.  Please refer to the comments
for details on both cases, especially case 1 which can be tricky.

Case 1 sounds rare, but it can be easily reproduced locally for me when we
run blocktime together with the migration-test on the vanilla postcopy.

New Design
==========

This patch should do almost what Alexey mentioned, but slightly
differently: instead of having an array to maintain vCPU fault addresses,
for each of the fault message we push a message into a hash, indexed by the
fault address.

With the hash, it can replace the old two structs: both the vcpu_addr[]
array, and also the array to store the start time of the fault.  However
due to above we need one more counter array to account concurrent faults on
the same vCPU - that should even be needed in the old code, it's just that
the old code was buggy and it will blindly overwrite an existing
entry.. now we'll start to really track everything.

The hash structure might be more efficient than tree to maintain such
addr->(cpu, fault_time) information, so that the insert() and lookup()
paths should ideally both be ~O(1).  After all, we do not need to sort.

Here we need to do one remove() though after the lookup().  It could be
slow but only if many vCPUs faulted exactly on the same address (so when
the list of cpu entries is long), which should be unlikely. Even with that,
it's still a worst case O(N) (consider 400 vCPUs faulted on the same
address and how likely is it..) rather than a constant O(N) complexity.

When at it, touch up the tracepoints to make them slightly more useful.
One tracepoint is added when walking all the fault entries.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 259 ++++++++++++++++++++++++++++++++-------
 migration/trace-events   |   5 +-
 2 files changed, 216 insertions(+), 48 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index f222239c7a..fe0c2ce225 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -112,14 +112,69 @@ void postcopy_thread_create(MigrationIncomingState *mis,
 
 /* All the time records are in unit of microseconds (us) */
 typedef struct PostcopyBlocktimeContext {
-    /* time when page fault initiated per vCPU */
-    uint64_t *vcpu_blocktime_start;
     /* blocktime per vCPU */
     uint64_t *vcpu_blocktime_total;
     /* count of faults per vCPU */
     uint64_t *vcpu_faults_count;
-    /* page address per vCPU */
-    uintptr_t *vcpu_addr;
+    /*
+     * count of currently blocked faults per vCPU.
+     *
+     * NOTE: Normally there should only be one fault in-progress per vCPU
+     * thread, so logically it _seems_ vcpu_faults_count[] for any vCPU
+     * should be either zero or one.  However, there can be reasons we see
+     * >1 faults on the same vCPU thread.
+     *
+     * CASE (1): since the process to resolve faults (ioctl(UFFDIO_COPY),
+     * for example) is done before taking the mutex that protects the
+     * blocktime context, it can happen that we read more than one faulted
+     * addresses per vCPU.
+     *
+     * One example when we can see >1 faulted addresses for one vCPU:
+     *
+     *  vcpu1 thread       fault thread         resolve thread
+     *  ============       ============         ==============
+     *
+     *  faulted on addr1
+     *                     read uffd msg (addr1)
+     *                     MUTEX_LOCK
+     *                     add entry (cpu1, addr1)
+     *                     MUTEX_UNLOCK
+     *                     request remote fault (addr1)
+     *                                          resolve fault (addr1)
+     *  addr1 resolved, continue..
+     *  faulted on addr2
+     *                     read uffd msg (addr2)
+     *                     MUTEX_LOCK
+     *                     add entry (cpu1, addr2) <--------------- [A]
+     *                     MUTEX_UNLOCK
+     *                                          MUTEX_LOCK
+     *                                          remove entry (cpu1, addr1)
+     *                                          MUTEX_UNLOCK
+     *
+     * In above case, we may see (cpu1, addr1) and (cpu1, addr2) entries to
+     * appear together at [A], when it gets the lock before the resolve
+     * thread.  Use this counter to maintain such case, and only when it
+     * reaches zero we know the vCPU is not blocked anymore.
+     *
+     * CASE (2): theoretically (the author admit to not have verified
+     * this..), one vCPU thread can also generate more than one userfaultfd
+     * message on the same address. It can happen e.g. for whatever reason
+     * the fault got retried before a resolution arrives. In that extremely
+     * rare case, we could also see two (cpu1, addr1) entries.
+     *
+     * In all cases, be prepared with such re-entrancies with this array.
+     *
+     * Using uint8_t should be far enough for now.  For example, when
+     * there're only one resolve thread (postcopy ram listening thread),
+     * the max (concurrent fault entries) should be two.
+     */
+    uint8_t *vcpu_faults_current;
+    /*
+     * The hash that contains addr1->[(cpu1,ts1),(cpu2,ts2) ...] mappings.
+     * Each of the entry is a tuple of (CPU index, fault timestamp) showing
+     * that a fault was requested.
+     */
+    GHashTable *vcpu_addr_hash;
     /* total blocktime when all vCPUs are stopped */
     uint64_t total_blocktime;
     /* point in time when last page fault was initiated */
@@ -145,13 +200,38 @@ typedef struct PostcopyBlocktimeContext {
     Notifier exit_notifier;
 } PostcopyBlocktimeContext;
 
+typedef struct {
+    /* The time the fault was triggered */
+    uint64_t fault_time;
+    /* The vCPU index that was blocked */
+    int cpu;
+} BlocktimeVCPUEntry;
+
+/* Alloc an entry to record a vCPU fault */
+static BlocktimeVCPUEntry *
+blocktime_vcpu_entry_alloc(int cpu, uint64_t fault_time)
+{
+    BlocktimeVCPUEntry *entry = g_new(BlocktimeVCPUEntry, 1);
+
+    entry->fault_time = fault_time;
+    entry->cpu = cpu;
+
+    return entry;
+}
+
+/* Free a @GList of @BlocktimeVCPUEntry */
+static void blocktime_vcpu_list_free(gpointer data)
+{
+    g_list_free_full(data, g_free);
+}
+
 static void destroy_blocktime_context(struct PostcopyBlocktimeContext *ctx)
 {
     g_hash_table_destroy(ctx->tid_to_vcpu_hash);
-    g_free(ctx->vcpu_blocktime_start);
+    g_hash_table_destroy(ctx->vcpu_addr_hash);
     g_free(ctx->vcpu_blocktime_total);
     g_free(ctx->vcpu_faults_count);
-    g_free(ctx->vcpu_addr);
+    g_free(ctx->vcpu_faults_current);
     g_free(ctx);
 }
 
@@ -198,12 +278,22 @@ static struct PostcopyBlocktimeContext *blocktime_context_new(void)
     unsigned int smp_cpus = ms->smp.cpus;
     PostcopyBlocktimeContext *ctx = g_new0(PostcopyBlocktimeContext, 1);
 
-    ctx->vcpu_blocktime_start = g_new0(uint64_t, smp_cpus);
     ctx->vcpu_blocktime_total = g_new0(uint64_t, smp_cpus);
     ctx->vcpu_faults_count = g_new0(uint64_t, smp_cpus);
-    ctx->vcpu_addr = g_new0(uintptr_t, smp_cpus);
+    ctx->vcpu_faults_current = g_new0(uint8_t, smp_cpus);
     ctx->tid_to_vcpu_hash = blocktime_init_tid_to_vcpu_hash();
 
+    /*
+     * The key (host virtual addresses) will always be gpointer-sized on
+     * either 32bits or 64bits systems, so it'll fit as a direct key.
+     *
+     * The value will be a list of BlocktimeVCPUEntry entries.
+     */
+    ctx->vcpu_addr_hash = g_hash_table_new_full(g_direct_hash,
+                                                g_direct_equal,
+                                                NULL,
+                                                blocktime_vcpu_list_free);
+
     ctx->exit_notifier.notify = migration_exit_cb;
     qemu_add_exit_notifier(&ctx->exit_notifier);
 
@@ -892,6 +982,39 @@ static uint64_t get_current_us(void)
     return (uint64_t)qemu_clock_get_us(QEMU_CLOCK_REALTIME);
 }
 
+/* Inject an (cpu, fault_time) entry into the database, using addr as key */
+static void blocktime_fault_inject(PostcopyBlocktimeContext *ctx,
+                                   uintptr_t addr, int cpu, uint64_t time)
+{
+    BlocktimeVCPUEntry *entry = blocktime_vcpu_entry_alloc(cpu, time);
+    GHashTable *table = ctx->vcpu_addr_hash;
+    gpointer key = (gpointer)addr;
+    GList *head, *list;
+    gboolean result;
+
+    head = g_hash_table_lookup(table, key);
+    if (head) {
+        /*
+         * If existed, steal the @head for list operation rather than
+         * freeing it, making sure steal succeeded.
+         */
+        result = g_hash_table_steal(table, key);
+        assert(result == TRUE);
+    }
+
+    /*
+     * Now the key is guaranteed to be absent.  Two cases:
+     *
+     * (1) There's no existing entry, list contains the only one. Insert.
+     * (2) There're existing entries, after stealing we own it, prepend the
+     *     result and re-insert.
+     */
+    list = g_list_prepend(head, entry);
+    g_hash_table_insert(table, key, list);
+
+    trace_postcopy_blocktime_begin(addr, time, cpu, !!head);
+}
+
 /*
  * This function is being called when pagefault occurs. It tracks down vCPU
  * blocking time.  It's protected by @page_request_mutex.
@@ -911,30 +1034,74 @@ void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
     if (!dc || ptid == 0) {
         return;
     }
+
+    /*
+     * The caller should only inject a blocktime entry when the page is
+     * yet missing.
+     */
+    assert(!ramblock_recv_bitmap_test(rb, (void *)addr));
+
+    current_us = get_current_us();
     cpu = blocktime_get_vcpu(dc, ptid);
-    if (cpu < 0) {
+
+    if (cpu >= 0) {
+        /* How many faults on this vCPU in total? */
+        dc->vcpu_faults_count[cpu]++;
+
+        /*
+         * Account how many concurrent faults on this vCPU we trapped.  See
+         * comments above vcpu_faults_current[] on why it can be more than one.
+         */
+        if (dc->vcpu_faults_current[cpu]++ == 0) {
+            dc->smp_cpus_down++;
+            /*
+             * We use last_begin to cover (1) the 1st fault on this specific
+             * vCPU, but meanwhile (2) the last vCPU that got blocked.  It's
+             * only used to calculate system-wide blocktime.
+             */
+            dc->last_begin = current_us;
+        }
+
+        /* Making sure it won't overflow - it really should never! */
+        assert(dc->vcpu_faults_current[cpu] <= 255);
+    } else {
+        /* We do not support non-vCPU thread tracking yet */
         dc->non_vcpu_faults++;
         return;
     }
 
-    current_us = get_current_us();
-    if (dc->vcpu_addr[cpu] == 0) {
-        dc->smp_cpus_down++;
-    }
+    blocktime_fault_inject(dc, addr, cpu, current_us);
+}
 
-    dc->last_begin = current_us;
-    dc->vcpu_blocktime_start[cpu] = current_us;
-    dc->vcpu_addr[cpu] = addr;
-    dc->vcpu_faults_count[cpu]++;
+typedef struct {
+    PostcopyBlocktimeContext *ctx;
+    uint64_t current_us;
+    int affected_cpus;
+} BlockTimeVCPUIter;
+
+static void blocktime_cpu_list_iter_fn(gpointer data, gpointer user_data)
+{
+    BlockTimeVCPUIter *iter = user_data;
+    PostcopyBlocktimeContext *ctx = iter->ctx;
+    BlocktimeVCPUEntry *entry = data;
+    int cpu = entry->cpu;
 
     /*
-     * The caller should only inject a blocktime entry when the page is
-     * yet missing.
+     * Time should never go back.. so when the fault is resolved it must be
+     * later than when it was faulted.
      */
-    assert(!ramblock_recv_bitmap_test(rb, (void *)addr));
+    assert(iter->current_us >= entry->fault_time);
+
+    /*
+     * If we resolved all pending faults on one vCPU due to this page
+     * resolution, take a note.
+     */
+    if (--ctx->vcpu_faults_current[cpu] == 0) {
+        ctx->vcpu_blocktime_total[cpu] += iter->current_us - entry->fault_time;
+        iter->affected_cpus += 1;
+    }
 
-    trace_mark_postcopy_blocktime_begin(addr, dc->vcpu_blocktime_start[cpu],
-                                        cpu);
+    trace_postcopy_blocktime_end_one(cpu, ctx->vcpu_faults_current[cpu]);
 }
 
 /*
@@ -970,43 +1137,43 @@ static void mark_postcopy_blocktime_end(uintptr_t addr)
     PostcopyBlocktimeContext *dc = mis->blocktime_ctx;
     MachineState *ms = MACHINE(qdev_get_machine());
     unsigned int smp_cpus = ms->smp.cpus;
-    int i, affected_cpu = 0;
-    uint64_t read_vcpu_time, current_us;
+    BlockTimeVCPUIter iter = {
+        .current_us = get_current_us(),
+        .affected_cpus = 0,
+        .ctx = dc,
+    };
+    gpointer key = (gpointer)addr;
+    GHashTable *table;
+    GList *list;
 
     if (!dc) {
         return;
     }
 
-    current_us = get_current_us();
-    /* lookup cpu, to clear it,
-     * that algorithm looks straightforward, but it's not
-     * optimal, more optimal algorithm is keeping tree or hash
-     * where key is address value is a list of  */
-    for (i = 0; i < smp_cpus; i++) {
-        uint64_t vcpu_blocktime = 0;
-
-        read_vcpu_time = dc->vcpu_blocktime_start[i];
-        if (dc->vcpu_addr[i] != addr || read_vcpu_time == 0) {
-            continue;
-        }
-        dc->vcpu_addr[i] = 0;
-        vcpu_blocktime = current_us - read_vcpu_time;
-        affected_cpu += 1;
-        /* continue cycle, due to one page could affect several vCPUs */
-        dc->vcpu_blocktime_total[i] += vcpu_blocktime;
+    table = dc->vcpu_addr_hash;
+    /* the address wasn't tracked at all? */
+    list = g_hash_table_lookup(table, key);
+    if (!list) {
+        return;
     }
 
+    /*
+     * Loop over the set of vCPUs that got blocked on this addr, do the
+     * blocktime accounting.  After that, remove the whole list.
+     */
+    g_list_foreach(list, blocktime_cpu_list_iter_fn, &iter);
+    g_hash_table_remove(table, key);
+
     /*
      * If all vCPUs used to be down, and copying this page would free some
      * vCPUs, then the system-level blocktime ends here.
      */
-    if (dc->smp_cpus_down == smp_cpus && affected_cpu) {
-        dc->total_blocktime += current_us - dc->last_begin;
+    if (dc->smp_cpus_down == smp_cpus && iter.affected_cpus) {
+        dc->total_blocktime += iter.current_us - dc->last_begin;
     }
-    dc->smp_cpus_down -= affected_cpu;
+    dc->smp_cpus_down -= iter.affected_cpus;
 
-    trace_mark_postcopy_blocktime_end(addr, dc->total_blocktime,
-                                      affected_cpu);
+    trace_postcopy_blocktime_end(addr, iter.current_us, iter.affected_cpus);
 }
 
 static void postcopy_pause_fault_thread(MigrationIncomingState *mis)
diff --git a/migration/trace-events b/migration/trace-events
index 9c1f3b7044..a36a78f01a 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -285,8 +285,6 @@ postcopy_nhp_range(const char *ramblock, void *host_addr, size_t offset, size_t
 postcopy_place_page(void *host_addr) "host=%p"
 postcopy_place_page_zero(void *host_addr) "host=%p"
 postcopy_ram_enable_notify(void) ""
-mark_postcopy_blocktime_begin(uint64_t addr, uint64_t time, int cpu) "addr: 0x%" PRIx64 ", time: %" PRIu64 ", cpu: %d"
-mark_postcopy_blocktime_end(uint64_t addr, uint64_t time, int affected_cpu) "addr: 0x%" PRIx64 ", time: %" PRIu64 ", affected_cpus: %d"
 postcopy_pause_fault_thread(void) ""
 postcopy_pause_fault_thread_continued(void) ""
 postcopy_pause_fast_load(void) ""
@@ -311,6 +309,9 @@ postcopy_preempt_new_channel(void) ""
 postcopy_preempt_thread_entry(void) ""
 postcopy_preempt_thread_exit(void) ""
 postcopy_blocktime_tid_cpu_map(int cpu, uint32_t tid) "cpu: %d, tid: %u"
+postcopy_blocktime_begin(uint64_t addr, uint64_t time, int cpu, bool exists) "addr: 0x%" PRIx64 ", time: %" PRIu64 ", cpu: %d, exist: %d"
+postcopy_blocktime_end(uint64_t addr, uint64_t time, int affected_cpu) "addr: 0x%" PRIx64 ", time: %" PRIu64 ", affected_cpus: %d"
+postcopy_blocktime_end_one(int cpu, uint8_t left_faults) "cpu: %d, left_faults: %" PRIu8
 
 # exec.c
 migration_exec_outgoing(const char *cmd) "cmd=%s"
-- 
2.49.0


