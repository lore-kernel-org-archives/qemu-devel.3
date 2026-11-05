Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B673606D81E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=XcupY7/8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP1As-00071U-Do; Thu, 05 Nov 2026 12:22:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xP1Aq-000711-2C
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 12:22:52 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xP1Ao-0007f7-6j
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 12:22:51 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso16545005e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 09:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1793899369; x=1794504169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EYt+15N7RdAMA+87ng4d1zSnQ/H+Wpfw30wRPffeHZU=;
 b=XcupY7/81hHghKtxp13Ntc+rnkp9OHy/zXVnWkERh8s6sV0PZCgqcKI8GBwzBf2usF
 Cj5RPjAQd5bnfJGJqOlb/4JKz1VIE8zcjW1Wf7usKLXHXxA5PK3YxJNK4qz9g0nDU6jW
 HfN4ouSmXvbfBezCfw1gsHZrB+dkH+fyJt7dfjigNUyWU5z58nIMdhbxm8EFoi8iQIcl
 mcwY4RI7UY6XEUmDDDfc0IXWantR6UlgSFeJC7ip2vqP5ZzVeymSR6qNelLyhHbDeB+R
 sHNzfYOJutKUct6bvigaH8zHKJ/S6UI0dLHA2jxpwYLGZte8EXHDFOefwinCnsYicroC
 1SqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793899369; x=1794504169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EYt+15N7RdAMA+87ng4d1zSnQ/H+Wpfw30wRPffeHZU=;
 b=RZlbnwK6tJtJtA7oGRrAWMY9uh2jEVohSzQumbFJ2o88s5eY244tsGrvLt1nhK1gnU
 /u1eN3wRGrzZl84EFGMcLTraV2MRoPPIeHnyWk6oQ5HBO++Hj+UTTGzgU+iI7AOQGeJ7
 AP6Dtzaff29Z9YKnXZtF6ZfROlpBJ2Tk1aBHAYmmUYpeu1Acp+Fy+Y0rm1q2/GVEYp3E
 r+cFdVlmUwRvnEwD6zG+Ns7Ne9SJTKvUXs+TENqtx/iSohW+hSNq7Q4ipVE/2H8azPs2
 06OPjrhnSCw3GPaa2HqvFLO1jTx3yAuTJBSYyByDDRtdt4CZjGHPpvi8FNnDjFsS86Fs
 AJQw==
X-Gm-Message-State: APuU4Z8eqMXCuq+vhLGushtEls7qMz2rwojZB6iZ4AUOSVrBX1Us8CTY
 JMRVBijMOqF8Xlom6gqo7T2frjrWqpYUiqc0lm/IsRD3ufkSoEbrgq6Ru1tZcbkaGhNCVRjvTHF
 MtSm+
X-Gm-Gg: AYBFou2WC5SwvzHPO9+1db45AouYTNwSn8+B9P4x8ZUbiRjx7A2eKTjUbD43Y61OzEE
 dcMcLSG9zsqq5LZiBnxRpqIcrvYGGGTbpaTr/B00Coczwjvr0qoxv452ybiColvCnAVU7+nYmn7
 xBiZZgkn9aGR4Sa8V9rk5MLmUsHybeo2aFBBOyIfzmGBt81hD/kqtSzjdtKsgtNGcyJ/4KqDccd
 ZlC07FczXRw1+VrSupKLx40JOf+lSfIGjjc4eAITCPHIcBNDP/oJR1okgFhlYw5zuvfv62suHAo
 lfeFkgwQ5ISZxelmOd/iUxiuAL83aLWVvHuGELDRnzg19vTAYstI/sMyWcvszq1Yl7aEWnvzXwV
 PU4ZOOzp1rfOXEvtbaTmLpgDD94QXmwNRKLT/06Jv+J02IIC853GWSxxgt2BEfFzzt57HNxydBy
 961Dm1eCk/wv8wrGWeifMXDSbiLcsJODNZKFze74wYRZYp+TAtR7Urv149noZ7iTOJH1Y00uyE/
 AiZEWWO4Ygd6GQm3ucCSSaJqyHi8jGCvy1g6g88p7nfN32YMpy1XaUmjx65tg8eQ8nQLdptoTMu
 lIoAGH+cad9l7aPbJC/x7glbO6FlnWRCrV0a9BYkBeOWjjM=
X-Received: by 2002:a05:600c:1f94:b0:4a8:f2ad:a9e5 with SMTP id
 5b1f17b1804b1-4ac1548f591mr431967065e9.3.1793899368725; 
 Thu, 05 Nov 2026 09:22:48 -0800 (PST)
Received: from athena.sw.ru ([2a06:5b06:b600:300:3848:9c8a:8cf7:6236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56e2ae72dsm130632255e9.3.2026.11.05.09.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 09:22:48 -0800 (PST)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Philippe Mathieu-Daude <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, "Denis V. Lunev" <den@virtuozzo.com>
Subject: [PATCH v2 1/6] memory: publish a dispatch tree only once it is
 complete
Date: Thu,  5 Nov 2026 18:22:39 +0100
Message-ID: <20261105172244.2804598-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911142345.3999518-1-den@openvz.org>
References: <20260911142345.3999518-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=den@openvz.org; helo=mail-wm1-x331.google.com
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

generate_memory_topology() assigns view->dispatch and then fills the tree
through it, because flatview_add_to_dispatch() reaches the dispatch back
through the view. Nothing can observe the half-built tree today, since
the view is not published to an address space until the render returns,
but the ordering is there to trip over the moment anything builds a tree
for a view which is already visible.

Pass the dispatch down instead of routing it through the view, and store
it into the view once it is built. Extract the build into
flatview_build_dispatch() while doing so, since that is the natural unit
to publish.

CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Peter Xu <peterx@redhat.com>
CC: Philippe Mathieu-Daude <philmd@oss.qualcomm.com>
CC: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Denis V. Lunev <den@virtuozzo.com>
---
 system/memory-internal.h |  4 +++-
 system/memory.c          | 27 +++++++++++++++++++--------
 system/physmem.c         | 16 ++++++++--------
 3 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/system/memory-internal.h b/system/memory-internal.h
index b2b9b5b0c5..d06c136744 100644
--- a/system/memory-internal.h
+++ b/system/memory-internal.h
@@ -32,7 +32,9 @@ void flatview_unref(FlatView *view);
 
 extern const MemoryRegionOps unassigned_mem_ops;
 
-void flatview_add_to_dispatch(FlatView *fv, MemoryRegionSection *section);
+void flatview_build_dispatch(FlatView *fv);
+void flatview_add_to_dispatch(FlatView *fv, AddressSpaceDispatch *d,
+                              MemoryRegionSection *section);
 AddressSpaceDispatch *address_space_dispatch_new(FlatView *fv);
 void address_space_dispatch_compact(AddressSpaceDispatch *d);
 void address_space_dispatch_free(AddressSpaceDispatch *d);
diff --git a/system/memory.c b/system/memory.c
index 56c5dd6c8a..33bd97c9a3 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -745,10 +745,27 @@ static MemoryRegion *memory_region_get_flatview_root(MemoryRegion *mr)
     return NULL;
 }
 
+void flatview_build_dispatch(FlatView *view)
+{
+    AddressSpaceDispatch *d;
+    int i;
+
+    assert(!view->dispatch);
+
+    d = address_space_dispatch_new(view);
+    for (i = 0; i < view->nr; i++) {
+        MemoryRegionSection mrs =
+            section_from_flat_range(&view->ranges[i], view);
+        flatview_add_to_dispatch(view, d, &mrs);
+    }
+    address_space_dispatch_compact(d);
+
+    qatomic_rcu_set(&view->dispatch, d);
+}
+
 /* Render a memory topology into a list of disjoint absolute ranges. */
 static FlatView *generate_memory_topology(MemoryRegion *mr)
 {
-    int i;
     FlatView *view;
 
     view = flatview_new(mr);
@@ -760,13 +777,7 @@ static FlatView *generate_memory_topology(MemoryRegion *mr)
     }
     flatview_simplify(view);
 
-    view->dispatch = address_space_dispatch_new(view);
-    for (i = 0; i < view->nr; i++) {
-        MemoryRegionSection mrs =
-            section_from_flat_range(&view->ranges[i], view);
-        flatview_add_to_dispatch(view, &mrs);
-    }
-    address_space_dispatch_compact(view->dispatch);
+    flatview_build_dispatch(view);
     g_hash_table_replace(flat_views, mr, view);
 
     return view;
diff --git a/system/physmem.c b/system/physmem.c
index a7300bb9d9..2cfdb1e6b4 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1350,9 +1350,9 @@ static void phys_sections_free(PhysPageMap *map)
     g_free(map->nodes);
 }
 
-static void register_subpage(FlatView *fv, MemoryRegionSection *section)
+static void register_subpage(FlatView *fv, AddressSpaceDispatch *d,
+                             MemoryRegionSection *section)
 {
-    AddressSpaceDispatch *d = flatview_to_dispatch(fv);
     subpage_t *subpage;
     hwaddr base = section->offset_within_address_space
         & TARGET_PAGE_MASK;
@@ -1381,10 +1381,9 @@ static void register_subpage(FlatView *fv, MemoryRegionSection *section)
 }
 
 
-static void register_multipage(FlatView *fv,
+static void register_multipage(FlatView *fv, AddressSpaceDispatch *d,
                                MemoryRegionSection *section)
 {
-    AddressSpaceDispatch *d = flatview_to_dispatch(fv);
     hwaddr start_addr = section->offset_within_address_space;
     uint16_t section_index = phys_section_add(&d->map, section);
     uint64_t num_pages = int128_get64(int128_rshift(section->size,
@@ -1401,7 +1400,8 @@ static void register_multipage(FlatView *fv,
  *
  * where s stands for subpage and P for page.
  */
-void flatview_add_to_dispatch(FlatView *fv, MemoryRegionSection *section)
+void flatview_add_to_dispatch(FlatView *fv, AddressSpaceDispatch *d,
+                              MemoryRegionSection *section)
 {
     MemoryRegionSection remain = *section;
     Int128 page_size = int128_make64(TARGET_PAGE_SIZE);
@@ -1413,7 +1413,7 @@ void flatview_add_to_dispatch(FlatView *fv, MemoryRegionSection *section)
 
         MemoryRegionSection now = remain;
         now.size = int128_min(int128_make64(left), now.size);
-        register_subpage(fv, &now);
+        register_subpage(fv, d, &now);
         if (int128_eq(remain.size, now.size)) {
             return;
         }
@@ -1426,7 +1426,7 @@ void flatview_add_to_dispatch(FlatView *fv, MemoryRegionSection *section)
     if (int128_ge(remain.size, page_size)) {
         MemoryRegionSection now = remain;
         now.size = int128_and(now.size, int128_neg(page_size));
-        register_multipage(fv, &now);
+        register_multipage(fv, d, &now);
         if (int128_eq(remain.size, now.size)) {
             return;
         }
@@ -1436,7 +1436,7 @@ void flatview_add_to_dispatch(FlatView *fv, MemoryRegionSection *section)
     }
 
     /* register last subpage */
-    register_subpage(fv, &remain);
+    register_subpage(fv, d, &remain);
 }
 
 void qemu_flush_coalesced_mmio_buffer(void)
-- 
2.53.0


