Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A39D216AD
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iNR-0006qK-7F; Tue, 15 Oct 2024 10:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iNP-0006j4-Kl
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:18:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iNN-0003Md-4U
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729001896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uMlGxvuqqTKvo8B9uMsBh6B0P4vJgLW7Q8WNp9kDf/8=;
 b=P/BPeCD1mAIcg+dM1Ddg8YuaacIwM/McfM3XfKCDgMfcUEi07WFmnpGhegh6nDH0lrrbPA
 KJHU5EuF5DZVaW7QVprRtyldsnUWkbNoQyAbNKWh/Ztn6yHzhj15Jm8lVohDe5qu3yGZf7
 obGdZHxelf3IUwXkI+5b87xQIKoJfvM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-G_lDkpIQOn6GTaB16GUZbQ-1; Tue, 15 Oct 2024 10:18:15 -0400
X-MC-Unique: G_lDkpIQOn6GTaB16GUZbQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43125f45783so17024745e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729001893; x=1729606693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uMlGxvuqqTKvo8B9uMsBh6B0P4vJgLW7Q8WNp9kDf/8=;
 b=taljZpAJUVhH6BMvsT0/Ewp4k/KSJJCxJ+omiX+s/SEUWwi8Bw40k6qRhtG2pGHywP
 z48WkdW0uR22OjbmBUzzgZ1r6M0uy3jDBsuES8ftzJ78jckY3zs2DbCFYphAxQ6/TThS
 yau8XcCGI6nhW2+Qi1TameTqspZ/guqc6NqVOvAa3VoByIv3RPMVndZDl+ZfWciuDq9P
 1yNly2JlWjVMwnFVAQYG38qiCwRyjQaLTvgVGqa5eDqR2Tlu5A6e+o7nuT3Cgqpxe2P5
 iXFY4RqsLmQJApb4apTGHlF1Xyo+HhlyQbRYHaV45JD4x26ME3Z2qKgc8h7GomWBx0VM
 OAJw==
X-Gm-Message-State: AOJu0YzE60SXW4h0WZO/C2IOVSfVrO6tNxcvoRN1OUN5upufVdRfNHhV
 e7iMZXbjdt29MWACdKTVpgu/qVdYo0qfiR2oHTYWb5OMJ9t2U28JGI7oE0LPgO6uV50Yt0/qdNU
 1iP7BwI8g8xylNrCfa/IVqTvD7h33gRVaeIDElsUhXej4C0Ki+e4k11CASXaOUiYdq4PbnwaiAk
 tBPwKhn9rJvOfVg4yyTf6cnG6mHv6c1AYrqtKCpyU=
X-Received: by 2002:a05:600c:5126:b0:42c:b63e:fe8f with SMTP id
 5b1f17b1804b1-431255dd131mr113696225e9.13.1729001893163; 
 Tue, 15 Oct 2024 07:18:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsVD++RHxBWaR42Dg0jsf4EXuQSDy+BC+9nTwq+JbRyg9LkcDVJo7NA++fIwuRAt1jk5CIzQ==
X-Received: by 2002:a05:600c:5126:b0:42c:b63e:fe8f with SMTP id
 5b1f17b1804b1-431255dd131mr113695865e9.13.1729001892598; 
 Tue, 15 Oct 2024 07:18:12 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f569ef4sm19452335e9.18.2024.10.15.07.18.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:18:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, qemu-stable <qemu-stable@nongnu.org>,
 Zhiyi Guo <zhguo@redhat.com>, David Hildenbrand <david@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PULL 17/25] KVM: Dynamic sized kvm memslots array
Date: Tue, 15 Oct 2024 16:17:03 +0200
Message-ID: <20241015141711.528342-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015141711.528342-1-pbonzini@redhat.com>
References: <20241015141711.528342-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

Zhiyi reported an infinite loop issue in VFIO use case.  The cause of that
was a separate discussion, however during that I found a regression of
dirty sync slowness when profiling.

Each KVMMemoryListerner maintains an array of kvm memslots.  Currently it's
statically allocated to be the max supported by the kernel.  However after
Linux commit 4fc096a99e ("KVM: Raise the maximum number of user memslots"),
the max supported memslots reported now grows to some number large enough
so that it may not be wise to always statically allocate with the max
reported.

What's worse, QEMU kvm code still walks all the allocated memslots entries
to do any form of lookups.  It can drastically slow down all memslot
operations because each of such loop can run over 32K times on the new
kernels.

Fix this issue by making the memslots to be allocated dynamically.

Here the initial size was set to 16 because it should cover the basic VM
usages, so that the hope is the majority VM use case may not even need to
grow at all (e.g. if one starts a VM with ./qemu-system-x86_64 by default
it'll consume 9 memslots), however not too large to waste memory.

There can also be even better way to address this, but so far this is the
simplest and should be already better even than before we grow the max
supported memslots.  For example, in the case of above issue when VFIO was
attached on a 32GB system, there are only ~10 memslots used.  So it could
be good enough as of now.

In the above VFIO context, measurement shows that the precopy dirty sync
shrinked from ~86ms to ~3ms after this patch applied.  It should also apply
to any KVM enabled VM even without VFIO.

NOTE: we don't have a FIXES tag for this patch because there's no real
commit that regressed this in QEMU. Such behavior existed for a long time,
but only start to be a problem when the kernel reports very large
nr_slots_max value.  However that's pretty common now (the kernel change
was merged in 2021) so we attached cc:stable because we'll want this change
to be backported to stable branches.

Cc: qemu-stable <qemu-stable@nongnu.org>
Reported-by: Zhiyi Guo <zhguo@redhat.com>
Tested-by: Zhiyi Guo <zhguo@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240917163835.194664-2-peterx@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/kvm_int.h |  1 +
 accel/kvm/kvm-all.c      | 87 +++++++++++++++++++++++++++++++++-------
 accel/kvm/trace-events   |  1 +
 3 files changed, 74 insertions(+), 15 deletions(-)

diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 17483ff53bd..2304537b93c 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -46,6 +46,7 @@ typedef struct KVMMemoryListener {
     MemoryListener listener;
     KVMSlot *slots;
     unsigned int nr_used_slots;
+    unsigned int nr_slots_allocated;
     int as_id;
     QSIMPLEQ_HEAD(, KVMMemoryUpdate) transaction_add;
     QSIMPLEQ_HEAD(, KVMMemoryUpdate) transaction_del;
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 905fb844e46..f84413b7954 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -69,6 +69,9 @@
 #define KVM_GUESTDBG_BLOCKIRQ 0
 #endif
 
+/* Default num of memslots to be allocated when VM starts */
+#define  KVM_MEMSLOTS_NR_ALLOC_DEFAULT                      16
+
 struct KVMParkedVcpu {
     unsigned long vcpu_id;
     int kvm_fd;
@@ -165,6 +168,57 @@ void kvm_resample_fd_notify(int gsi)
     }
 }
 
+/**
+ * kvm_slots_grow(): Grow the slots[] array in the KVMMemoryListener
+ *
+ * @kml: The KVMMemoryListener* to grow the slots[] array
+ * @nr_slots_new: The new size of slots[] array
+ *
+ * Returns: True if the array grows larger, false otherwise.
+ */
+static bool kvm_slots_grow(KVMMemoryListener *kml, unsigned int nr_slots_new)
+{
+    unsigned int i, cur = kml->nr_slots_allocated;
+    KVMSlot *slots;
+
+    if (nr_slots_new > kvm_state->nr_slots) {
+        nr_slots_new = kvm_state->nr_slots;
+    }
+
+    if (cur >= nr_slots_new) {
+        /* Big enough, no need to grow, or we reached max */
+        return false;
+    }
+
+    if (cur == 0) {
+        slots = g_new0(KVMSlot, nr_slots_new);
+    } else {
+        assert(kml->slots);
+        slots = g_renew(KVMSlot, kml->slots, nr_slots_new);
+        /*
+         * g_renew() doesn't initialize extended buffers, however kvm
+         * memslots require fields to be zero-initialized. E.g. pointers,
+         * memory_size field, etc.
+         */
+        memset(&slots[cur], 0x0, sizeof(slots[0]) * (nr_slots_new - cur));
+    }
+
+    for (i = cur; i < nr_slots_new; i++) {
+        slots[i].slot = i;
+    }
+
+    kml->slots = slots;
+    kml->nr_slots_allocated = nr_slots_new;
+    trace_kvm_slots_grow(cur, nr_slots_new);
+
+    return true;
+}
+
+static bool kvm_slots_double(KVMMemoryListener *kml)
+{
+    return kvm_slots_grow(kml, kml->nr_slots_allocated * 2);
+}
+
 unsigned int kvm_get_max_memslots(void)
 {
     KVMState *s = KVM_STATE(current_accel());
@@ -193,15 +247,26 @@ unsigned int kvm_get_free_memslots(void)
 /* Called with KVMMemoryListener.slots_lock held */
 static KVMSlot *kvm_get_free_slot(KVMMemoryListener *kml)
 {
-    KVMState *s = kvm_state;
+    unsigned int n;
     int i;
 
-    for (i = 0; i < s->nr_slots; i++) {
+    for (i = 0; i < kml->nr_slots_allocated; i++) {
         if (kml->slots[i].memory_size == 0) {
             return &kml->slots[i];
         }
     }
 
+    /*
+     * If no free slots, try to grow first by doubling.  Cache the old size
+     * here to avoid another round of search: if the grow succeeded, it
+     * means slots[] now must have the existing "n" slots occupied,
+     * followed by one or more free slots starting from slots[n].
+     */
+    n = kml->nr_slots_allocated;
+    if (kvm_slots_double(kml)) {
+        return &kml->slots[n];
+    }
+
     return NULL;
 }
 
@@ -222,10 +287,9 @@ static KVMSlot *kvm_lookup_matching_slot(KVMMemoryListener *kml,
                                          hwaddr start_addr,
                                          hwaddr size)
 {
-    KVMState *s = kvm_state;
     int i;
 
-    for (i = 0; i < s->nr_slots; i++) {
+    for (i = 0; i < kml->nr_slots_allocated; i++) {
         KVMSlot *mem = &kml->slots[i];
 
         if (start_addr == mem->start_addr && size == mem->memory_size) {
@@ -267,7 +331,7 @@ int kvm_physical_memory_addr_from_host(KVMState *s, void *ram,
     int i, ret = 0;
 
     kvm_slots_lock();
-    for (i = 0; i < s->nr_slots; i++) {
+    for (i = 0; i < kml->nr_slots_allocated; i++) {
         KVMSlot *mem = &kml->slots[i];
 
         if (ram >= mem->ram && ram < mem->ram + mem->memory_size) {
@@ -1071,7 +1135,7 @@ static int kvm_physical_log_clear(KVMMemoryListener *kml,
 
     kvm_slots_lock();
 
-    for (i = 0; i < s->nr_slots; i++) {
+    for (i = 0; i < kml->nr_slots_allocated; i++) {
         mem = &kml->slots[i];
         /* Discard slots that are empty or do not overlap the section */
         if (!mem->memory_size ||
@@ -1715,12 +1779,8 @@ static void kvm_log_sync_global(MemoryListener *l, bool last_stage)
     /* Flush all kernel dirty addresses into KVMSlot dirty bitmap */
     kvm_dirty_ring_flush();
 
-    /*
-     * TODO: make this faster when nr_slots is big while there are
-     * only a few used slots (small VMs).
-     */
     kvm_slots_lock();
-    for (i = 0; i < s->nr_slots; i++) {
+    for (i = 0; i < kml->nr_slots_allocated; i++) {
         mem = &kml->slots[i];
         if (mem->memory_size && mem->flags & KVM_MEM_LOG_DIRTY_PAGES) {
             kvm_slot_sync_dirty_pages(mem);
@@ -1835,12 +1895,9 @@ void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
 {
     int i;
 
-    kml->slots = g_new0(KVMSlot, s->nr_slots);
     kml->as_id = as_id;
 
-    for (i = 0; i < s->nr_slots; i++) {
-        kml->slots[i].slot = i;
-    }
+    kvm_slots_grow(kml, KVM_MEMSLOTS_NR_ALLOC_DEFAULT);
 
     QSIMPLEQ_INIT(&kml->transaction_add);
     QSIMPLEQ_INIT(&kml->transaction_del);
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index 82c65fd2ab8..e43d18a8692 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -36,3 +36,4 @@ kvm_io_window_exit(void) ""
 kvm_run_exit_system_event(int cpu_index, uint32_t event_type) "cpu_index %d, system_even_type %"PRIu32
 kvm_convert_memory(uint64_t start, uint64_t size, const char *msg) "start 0x%" PRIx64 " size 0x%" PRIx64 " %s"
 kvm_memory_fault(uint64_t start, uint64_t size, uint64_t flags) "start 0x%" PRIx64 " size 0x%" PRIx64 " flags 0x%" PRIx64
+kvm_slots_grow(unsigned int old, unsigned int new) "%u -> %u"
-- 
2.46.2


