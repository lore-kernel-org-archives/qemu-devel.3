Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AF5606A337
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=r1fL042i
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP1Av-00072P-3Z; Thu, 05 Nov 2026 12:22:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xP1At-00071w-33
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 12:22:55 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xP1Aq-0007fQ-Fl
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 12:22:54 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so16672845e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 09:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1793899371; x=1794504171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uehzfmfzduQGno49/ozsjuBIXoQFr96ddf/zS6pyLoc=;
 b=r1fL042iHMAwdGM24JE65WEO2hLdK+JXjcTDqsFuGToyMm+xoORqBiW68OtdReNaBO
 uuS0cOrC5EPHHgdOEA2nJ4hHMkJXw86808jZrxgQ2DIMexGtfbwi6EKwA4E/CxkO6P6O
 MDxkL7LzmvSrGKMkuVXr558iXMwFwWiPQX1Jiz7MMlLHd1tRDA+GQmdY2YIN97owhJ/O
 PIvd7eqL0aXBVS0MByEwwfYYfzHuHewZrubuHkaToYYlYsUW0zowEkwQo6m/x4O6C2SP
 G9wPXnyp/79i6qegu1JmawB5SpAbsYm8uJiab/2/ivz9baNZRGcOvi3uXt9dbJMaiqDg
 smeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793899371; x=1794504171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uehzfmfzduQGno49/ozsjuBIXoQFr96ddf/zS6pyLoc=;
 b=0gfmmsANSXUrzp+p8Eae+acz4Wksbfhx6WLiD5V8/h5VsJ9+oxNjDUxoZpBFnufufo
 1VvRa26aRcU5U/0N6ktQgxI0FL6Ip5lwIcJ4SqmyGEMPUljKLSaysNCx07DuhT4odxdG
 GlBbTXbtr6BpMb/MNiwwR1/LoGwsZiCpjdGS5Q2IeGbgwe7EPIFM0f+Iyx/vgocSxCeI
 P864kru61mpBDOIcMVg2QyVs8egBH0RsjOpETm8QO0LhlWov4Ir9cVjy8Gnfa3QxdAF5
 kn7Fy+X06NHgg3jjvjUzb+amlfbUccBcKRw+37CtMCBrJepcN5WOpt5AAJmNa11KYu2h
 /jsQ==
X-Gm-Message-State: APuU4Z9D9iP4nLasNtmM4FX8oDjyT0EGdX7o8LmUlkaPonKurePQaatj
 aSH56Vx2SidjcOMyOwL9AGhe+bnaKYr3e008PMlqdj2EzOH8Hfx96H51zkY0fNBxDP6Z0dKilPd
 HAj1z
X-Gm-Gg: AYBFou2iKYdOPF4bP4W7iU3QHSl9YpyyAQRzyb6lebRP0SUh/z9I2BaQZYGp12LVVoo
 +M+X6uMkDbYFDj+oyGoIfePOgujLMGe5Bg+VkXiTCs3hv5mW7OgHsXszPl80TyJIGytFuFKRhzr
 P3vgi4/2IVCEs/gWCTINBGvTWhcYXfBsor/ew6SczqDsL88nQd15++4Bt5LJg9hBoXvduiTQcdM
 sUw/hUuI8QtnIBwfielYJbQ5Q0ihn5R3Jtf593DpR3/B+1zbORDDJmjHK6LnoIrLW3IxsBoNRgz
 hI4cvUrlp9bc6R/E7Lt1Iua64J9fxfsowDhGTziNeFI7YSbTWdrDcy+YhnMlDPXcEuTJR95SEpX
 3R0zD4uwGYxyeoWdVfPa3qBDM7J+85RwbwYsJvIyGmrs9ppBQ1pn0KMVbSlWAQbcpHS1pKcqCvz
 8fGfbt1hrGVG9+AX5t/kXZW0CH+i1CHyyx0hfxXxajYcHFqaPFvoNV8YdIKmYB11bWsY7VqUmKo
 hz93/XJufGrOeI55RrmhMssEoI7QS/Pi1ihL1nOnP0XoFjP9tM+wIeK1vvq2kCwmmM4mzURZBHe
 0FTSvPsMYvPgOL1jGjFW5aMPqA==
X-Received: by 2002:a05:600c:5249:b0:4a7:7f3f:6f8e with SMTP id
 5b1f17b1804b1-4ac1228b5bfmr438277005e9.0.1793899370968; 
 Thu, 05 Nov 2026 09:22:50 -0800 (PST)
Received: from athena.sw.ru ([2a06:5b06:b600:300:3848:9c8a:8cf7:6236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56e2ae72dsm130632255e9.3.2026.11.05.09.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 09:22:50 -0800 (PST)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Philippe Mathieu-Daude <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, "Denis V. Lunev" <den@virtuozzo.com>
Subject: [PATCH v2 3/6] memory: stop building dispatch trees before the
 machine runs
Date: Thu,  5 Nov 2026 18:22:41 +0100
Message-ID: <20261105172244.2804598-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911142345.3999518-1-den@openvz.org>
References: <20260911142345.3999518-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=den@openvz.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Denis V. Lunev <den@openvz.org>

Regenerating a flatview spends most of its time building the radix tree
used to translate addresses through it, not rendering the view. Nothing
translates through a tree until a vCPU runs, and by then the topology has
been rebuilt hundreds of times: once per device that claims a region
while the machine is created, and once more per device that moves a BAR
or a window while an incoming vmstate stream is read. Nearly all of those
trees are discarded unbuilt upon.

Do not build them until a vCPU can run. A view rendered before that keeps
a flat array of the sections the render already produced, and a lookup
binary searches it. vm_prepare_start() builds a tree for every view still
in use, which is the last point at which nothing has run yet.

The array answers the question the tree does except for one caller: a
lookup which asks for the page a subpage container stands for, rather
than the range covering the address, still needs the tree and builds it.
That is the softmmu TLB fill and the iotlb entry lookup.

Building asserts the BQL, because two builders racing on one view would
leak a tree. That holds every caller which can reach a view without one
to running while the guest does, and by then no view an address space
still publishes is missing its tree: a reader which picked one up during
the window keeps it afterwards, and a view superseded meanwhile never
gets a tree at all. Before a vCPU runs, the paths which translate without
the BQL either do not run or ask for a range rather than a page.

A load which follows a run reopens the window, so a snapshot restore gets
the same treatment as an incoming migration; vm_prepare_start() closes it
again. Postcopy needs no exception, because it starts the guest through
the same path.

A tree is now published once it is complete rather than while it is being
filled, so a reader finds the tree or the array, never a half-built tree.
io_mem_unassigned loses its static so the array can carry the same
unassigned section the tree does.

CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Peter Xu <peterx@redhat.com>
CC: Philippe Mathieu-Daude <philmd@oss.qualcomm.com>
CC: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Denis V. Lunev <den@virtuozzo.com>
---
 include/system/memory.h  | 19 ++++++++
 migration/savevm.c       | 10 +++++
 system/memory-internal.h |  2 +
 system/memory.c          | 96 +++++++++++++++++++++++++++++++++++++++-
 system/physmem.c         | 41 +++++++++++++++--
 system/runstate.c        |  3 ++
 system/trace-events      |  1 +
 7 files changed, 167 insertions(+), 5 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 027ca81bd2..d620bee90e 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -940,6 +940,13 @@ struct FlatView {
     unsigned nr;
     unsigned nr_allocated;
     struct AddressSpaceDispatch *dispatch;
+    /*
+     * Stands in for @dispatch, one entry per range plus an unassigned entry
+     * at index 0. Built instead of the tree while dispatch building is
+     * deferred, and then kept for the life of the view, because a reader may
+     * still hold a pointer into it.
+     */
+    MemoryRegionSection *sections;
     MemoryRegion *root;
 };
 
@@ -2334,6 +2341,18 @@ void memory_region_transaction_begin(void);
  */
 void memory_region_transaction_commit(void);
 
+/**
+ * flatview_dispatch_defer_begin: Stop building dispatch trees
+ *
+ * For a window in which the topology is rebuilt repeatedly and translated
+ * through rarely, such as loading a migration stream. A view rendered in
+ * the window answers lookups from its range array instead, and gets its
+ * tree once the window closes. Must be closed with
+ * flatview_dispatch_defer_end() before the guest runs again.
+ */
+void flatview_dispatch_defer_begin(void);
+void flatview_dispatch_defer_end(void);
+
 /**
  * memory_listener_register: register callbacks to be called when memory
  *                           sections are mapped or unmapped into an address
diff --git a/migration/savevm.c b/migration/savevm.c
index fe94ba96e4..ac48db7754 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3147,7 +3147,17 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
 
     cpu_synchronize_all_pre_loadvm();
 
+    /*
+     * A load which follows a run, such as a snapshot, starts with the window
+     * already closed. Reopen it: the guest is stopped for the whole load, and
+     * vm_prepare_start() closes it again before anything runs.
+     */
+    flatview_dispatch_defer_begin();
+
     ret = qemu_loadvm_state_main(f, mis, errp);
+
+    flatview_dispatch_defer_end();
+
     qemu_event_set(&mis->main_thread_load_event);
 
     trace_qemu_loadvm_state_post_main(ret);
diff --git a/system/memory-internal.h b/system/memory-internal.h
index d81881ba54..3d9f92185d 100644
--- a/system/memory-internal.h
+++ b/system/memory-internal.h
@@ -20,8 +20,10 @@ FlatView *address_space_get_flatview(const AddressSpace *as);
 void flatview_unref(FlatView *view);
 
 extern const MemoryRegionOps unassigned_mem_ops;
+extern MemoryRegion io_mem_unassigned;
 
 void flatview_build_dispatch(FlatView *fv);
+MemoryRegionSection *flatview_lookup_section(FlatView *fv, hwaddr addr);
 void flatview_add_to_dispatch(FlatView *fv, AddressSpaceDispatch *d,
                               MemoryRegionSection *section);
 AddressSpaceDispatch *address_space_dispatch_new(FlatView *fv);
diff --git a/system/memory.c b/system/memory.c
index 33bd97c9a3..d04130f695 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -301,6 +301,7 @@ static void flatview_destroy(FlatView *view)
     for (i = 0; i < view->nr; i++) {
         memory_region_unref(view->ranges[i].mr);
     }
+    g_free(view->sections);
     g_free(view->ranges);
     memory_region_unref(view->root);
     g_free(view);
@@ -745,11 +746,54 @@ static MemoryRegion *memory_region_get_flatview_root(MemoryRegion *mr)
     return NULL;
 }
 
+static bool flatview_dispatch_deferred = true;
+
+static void flatview_build_sections(FlatView *view)
+{
+    unsigned i;
+    MemoryRegionSection *sections;
+
+    assert(!view->sections);
+
+    sections = g_new(MemoryRegionSection, view->nr + 1);
+    sections[0] = (MemoryRegionSection) {
+        .fv = view,
+        .mr = &io_mem_unassigned,
+        .size = int128_2_64(),
+    };
+    for (i = 0; i < view->nr; i++) {
+        sections[i + 1] = section_from_flat_range(&view->ranges[i], view);
+    }
+
+    qatomic_rcu_set(&view->sections, sections);
+}
+
+static FlatRange *flatview_lookup(FlatView *view, AddrRange addr);
+
+/* Called from RCU critical section */
+MemoryRegionSection *flatview_lookup_section(FlatView *view, hwaddr addr)
+{
+    MemoryRegionSection *sections = qatomic_rcu_read(&view->sections);
+    FlatRange *fr;
+
+    fr = flatview_lookup(view, addrrange_make(int128_make64(addr),
+                                              int128_one()));
+
+    return fr ? &sections[fr - view->ranges + 1] : &sections[0];
+}
+
 void flatview_build_dispatch(FlatView *view)
 {
     AddressSpaceDispatch *d;
     int i;
 
+    /*
+     * Two builders racing on one view would leak a tree, and the BQL is
+     * what keeps them apart. Every caller which can reach a view without
+     * one runs only while the guest does, by which point no view an
+     * address space still publishes is missing its tree.
+     */
+    assert(bql_locked());
     assert(!view->dispatch);
 
     d = address_space_dispatch_new(view);
@@ -777,12 +821,60 @@ static FlatView *generate_memory_topology(MemoryRegion *mr)
     }
     flatview_simplify(view);
 
-    flatview_build_dispatch(view);
+    if (flatview_dispatch_deferred) {
+        flatview_build_sections(view);
+    } else {
+        flatview_build_dispatch(view);
+    }
     g_hash_table_replace(flat_views, mr, view);
 
     return view;
 }
 
+/*
+ * Machine creation and a vmstate load both rebuild the same views many times
+ * over and translate through almost none of them, so the dispatch tree waits
+ * until a vCPU can run. A view rendered meanwhile answers from its range
+ * array, which the render already produced. Idempotent, because the windows
+ * nest: an incoming migration loads a stream inside the one creation opened.
+ */
+void flatview_dispatch_defer_begin(void)
+{
+    assert(bql_locked());
+    flatview_dispatch_deferred = true;
+}
+
+void flatview_dispatch_defer_end(void)
+{
+    unsigned n_views = 0, n_ranges = 0;
+    GHashTableIter iter;
+    gpointer value;
+
+    assert(bql_locked());
+
+    if (!flatview_dispatch_deferred) {
+        return;
+    }
+    flatview_dispatch_deferred = false;
+
+    if (!flat_views) {
+        return;
+    }
+
+    g_hash_table_iter_init(&iter, flat_views);
+    while (g_hash_table_iter_next(&iter, NULL, &value)) {
+        FlatView *view = value;
+
+        if (!view->dispatch) {
+            flatview_build_dispatch(view);
+            n_views++;
+            n_ranges += view->nr;
+        }
+    }
+
+    trace_flatview_dispatch_drain(n_views, n_ranges);
+}
+
 static void address_space_add_del_ioeventfds(AddressSpace *as,
                                              MemoryRegionIoeventfd *fds_new,
                                              unsigned fds_new_nb,
@@ -3426,7 +3518,7 @@ static void mtree_print_flatview(gpointer key, gpointer value,
     }
 
 #if !defined(CONFIG_USER_ONLY)
-    if (fvi->dispatch_tree && view->root) {
+    if (fvi->dispatch_tree && view->root && view->dispatch) {
         mtree_print_dispatch(view->dispatch, view->root);
     }
 #endif
diff --git a/system/physmem.c b/system/physmem.c
index 6f11e31799..6611327213 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -101,7 +101,7 @@ static MemoryRegion *system_io;
 AddressSpace address_space_io;
 AddressSpace address_space_memory;
 
-static MemoryRegion io_mem_unassigned;
+MemoryRegion io_mem_unassigned;
 
 typedef struct PhysPageEntry PhysPageEntry;
 
@@ -359,6 +359,41 @@ static MemoryRegionSection *address_space_lookup_region(AddressSpaceDispatch *d,
     return section;
 }
 
+static AddressSpaceDispatch *flatview_dispatch(FlatView *fv)
+{
+    AddressSpaceDispatch *d = qatomic_rcu_read(&fv->dispatch);
+
+    if (unlikely(!d)) {
+        flatview_build_dispatch(fv);
+        d = fv->dispatch;
+    }
+
+    return d;
+}
+
+/*
+ * Called from RCU critical section.
+ *
+ * A view rendered while dispatch building is deferred has no tree yet, and
+ * its range array answers the same question directly. Only a caller which
+ * wants the page a subpage container stands for, rather than the range
+ * covering the address, has to pay for the tree.
+ */
+static MemoryRegionSection *flatview_lookup_region(FlatView *fv, hwaddr addr,
+                                                   bool resolve_subpage)
+{
+    AddressSpaceDispatch *d = qatomic_rcu_read(&fv->dispatch);
+
+    if (unlikely(!d)) {
+        if (resolve_subpage) {
+            return flatview_lookup_section(fv, addr);
+        }
+        d = flatview_dispatch(fv);
+    }
+
+    return address_space_lookup_region(d, addr, resolve_subpage);
+}
+
 /* Called from RCU critical section */
 static MemoryRegionSection *
 address_space_translate_internal(FlatView *fv, hwaddr addr, hwaddr *xlat,
@@ -368,7 +403,7 @@ address_space_translate_internal(FlatView *fv, hwaddr addr, hwaddr *xlat,
     MemoryRegion *mr;
     Int128 diff;
 
-    section = address_space_lookup_region(fv->dispatch, addr, resolve_subpage);
+    section = flatview_lookup_region(fv, addr, resolve_subpage);
     /* Compute offset within MemoryRegionSection */
     addr -= section->offset_within_address_space;
 
@@ -744,7 +779,7 @@ translate_fail:
      */
     assert((orig_addr & ~TARGET_PAGE_MASK) == 0);
     *xlat = orig_addr;
-    return &fv->dispatch->map.sections[PHYS_SECTION_UNASSIGNED];
+    return &flatview_dispatch(fv)->map.sections[PHYS_SECTION_UNASSIGNED];
 }
 
 #endif /* CONFIG_TCG */
diff --git a/system/runstate.c b/system/runstate.c
index 56bfc5b07d..bae8ce9a96 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -59,6 +59,7 @@
 #include "system/replay.h"
 #include "system/reset.h"
 #include "system/runstate.h"
+#include "system/memory.h"
 #include "system/runstate-action.h"
 #include "system/confidential-guest-support.h"
 #include "system/system.h"
@@ -508,6 +509,8 @@ int vm_prepare_start(bool step_pending)
         return -1;
     }
 
+    flatview_dispatch_defer_end();
+
     /*
      * WHPX accelerator needs to know whether we are going to step
      * any CPUs, before starting the first one.
diff --git a/system/trace-events b/system/trace-events
index 38ad0be8a9..3542b6b2c4 100644
--- a/system/trace-events
+++ b/system/trace-events
@@ -26,6 +26,7 @@ flatview_destroy(void *view, void *root) "%p (root %p)"
 flatview_destroy_rcu(void *view, void *root) "%p (root %p)"
 global_dirty_changed(unsigned int bitmask) "bitmask 0x%"PRIx32
 memory_region_finalize(const char* name) "mr %s"
+flatview_dispatch_drain(unsigned n_fv, unsigned n_ranges) "flatviews %u ranges %u"
 
 # physmem.c
 address_space_map(void *as, uint64_t addr, uint64_t len, bool is_write, uint32_t attrs) "as:%p addr 0x%"PRIx64":%"PRIx64" write:%d attrs:0x%x"
-- 
2.53.0


