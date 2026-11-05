Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9178D606D80D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=dHur9WB1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP1At-00072H-Kb; Thu, 05 Nov 2026 12:22:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xP1Ar-00071F-Cn
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 12:22:53 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xP1Ap-0007fE-Ga
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 12:22:53 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so19834465e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 09:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1793899370; x=1794504170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dzZwjtWtl+zWULlTkru7d/yNcdgN/qdh62zOKr27Tn0=;
 b=dHur9WB1URS67b+zx2fSEDjfKrGo2T4OFxZLgpD0hOFxxH7/TAsoYWKKlO25MW9GEd
 cK0iXzs1ipWFOALz15cO2Ul7jEv2BjpqJe7s1xMvo7gt6yhvz04LQltxbR6mvW+kkjWy
 CJ0BtsnxvlVijxJS3fmqFAmb4P2+AV0GxYdTz63RlxOt6AqEpjThWdeSonyq3vgDZ1VC
 +D/WNgiuhsh0ti2bsa8yl8ytKXlivKTH1hwwfQqYoNEvqQkKA9GGleqbIYaS+AzSPpyJ
 QDnyFBUikaTR/ulwahXvJGYHNQQiwEqqS+dtLt7y0QzO9mCXSXWtzWVjpbf9ImcM5JTE
 jW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793899370; x=1794504170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dzZwjtWtl+zWULlTkru7d/yNcdgN/qdh62zOKr27Tn0=;
 b=AICah8uU/exv46bR50EfAt/bnAb/Dyx9cL8NFZB8QwQ1hLVxfpG7GH3LgB1GEaO4mm
 dWDhWV8xJJPeYbv0BrVzlrfhwLsch6CfvUKNwetmyz85pVLzUgcaA6QGQdQbUST6m9ee
 7eHjj2EMR9Q570muw2YCVG6mJQbaHZcxFczpIbLNGtEdlROiqkAJvgZ+Y88T8TQOSqht
 cibOUAbQUGmQ27q2j/bXX4Rqa/1OogzEWvSbU4lwNQVnljudcspBgS2xRTHvx0oCfMjt
 fRhJEKZMA44hSHGEAmMWtRoIBuywds1CE+2XJ4JRLhuIsy4PsM7UG++b2AO2F/Ic1m53
 drjQ==
X-Gm-Message-State: APuU4Z+/I4fDDMUH1fcfw0I9LQPR77nxIYlqegli3AUN7pyzdz4UVKxw
 9/EnTA2WWqftU6ygyDSC3ChzVgkrxiHhn3jwpfiQ7nCkP8l2C7t1vY8gVNhYtVINmBQm1iQQplR
 /yh11
X-Gm-Gg: AYBFou1K3D/Y9Xb3/ROjXwNUaOECpSc3Eh5ZEera7gKX77yEn7muTeddYrrOw6fJ6oT
 R2EVfYChVfMhpzZHbgaQfhlDe96WLzXkk9hHLSyCJcAl9Xmiq1eRSniH5N1LXcoR4R+2mm7IXY6
 Fchh6R9F8ZqsOiE/d3PJHvu5YvBmdwlsOWD/ezbEuo5LsltFuP2fFBBwnTsTUhB6qSrXp0M26Ps
 iADAQTgK+GkFK9wh0TT+fGyaDS/d2EeZaQgiLlcH4G2zTVd3AlW69HzmOJzU4ZoK3JiL5HnKnHs
 1R2RnbRMpmEttQPn2kzJd7BtNiMN4R4iuQqxwjew6cg7yJX2BX2XIu63JGvH6/vT4UxBcfO1d8v
 jq7IJ8pdEUQgeHiFSmRKCHd3SUWByRm9FAATLk39MjaMhngcBKA4Fc6nDa147P8lsTXX3+vrecO
 JFDMY0YVOIs9YO9RqFTxFCjaG3OgCOVWTEFjyByYeg3ZifM+cG7bipkpBZB5wVz76SR0W+4FYwx
 gPjrImpPcoRtiSwsVF8j9ugkpzJXy68ZLWEC1FIuNJ/SZ/V4CHbza3POgy3zHAWLmyVh8DvV8Tj
 7SMjOX/0RU2y2259+neY1CLuhUk=
X-Received: by 2002:a05:600c:524b:b0:4b2:612d:908c with SMTP id
 5b1f17b1804b1-4b2612d90d4mr208229695e9.34.1793899369830; 
 Thu, 05 Nov 2026 09:22:49 -0800 (PST)
Received: from athena.sw.ru ([2a06:5b06:b600:300:3848:9c8a:8cf7:6236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56e2ae72dsm130632255e9.3.2026.11.05.09.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 09:22:49 -0800 (PST)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Philippe Mathieu-Daude <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, "Denis V. Lunev" <den@virtuozzo.com>
Subject: [PATCH v2 2/6] physmem: pass the FlatView to
 address_space_translate_internal
Date: Thu,  5 Nov 2026 18:22:40 +0100
Message-ID: <20261105172244.2804598-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911142345.3999518-1-den@openvz.org>
References: <20260911142345.3999518-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=den@openvz.org; helo=mail-wm1-x32b.google.com
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

address_space_translate_internal() takes the dispatch, so every caller
resolves the view to its tree first and the tree is the only structure a
lookup can go through. Take the view instead and let the lookup reach the
tree, so that a view which answers some other way is expressible.

No functional change: every caller already had the view, or an address
space to take it from.

CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Peter Xu <peterx@redhat.com>
CC: Philippe Mathieu-Daude <philmd@oss.qualcomm.com>
CC: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Denis V. Lunev <den@virtuozzo.com>
---
 system/memory-internal.h | 11 -----------
 system/physmem.c         | 25 ++++++++++++-------------
 2 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/system/memory-internal.h b/system/memory-internal.h
index d06c136744..d81881ba54 100644
--- a/system/memory-internal.h
+++ b/system/memory-internal.h
@@ -16,17 +16,6 @@
 
 void machine_memory_init(void);
 
-static inline AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv)
-{
-    return fv->dispatch;
-}
-
-static inline
-AddressSpaceDispatch *address_space_to_dispatch(const AddressSpace *as)
-{
-    return flatview_to_dispatch(address_space_to_flatview(as));
-}
-
 FlatView *address_space_get_flatview(const AddressSpace *as);
 void flatview_unref(FlatView *view);
 
diff --git a/system/physmem.c b/system/physmem.c
index 2cfdb1e6b4..6f11e31799 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -361,14 +361,14 @@ static MemoryRegionSection *address_space_lookup_region(AddressSpaceDispatch *d,
 
 /* Called from RCU critical section */
 static MemoryRegionSection *
-address_space_translate_internal(AddressSpaceDispatch *d, hwaddr addr, hwaddr *xlat,
+address_space_translate_internal(FlatView *fv, hwaddr addr, hwaddr *xlat,
                                  hwaddr *plen, bool resolve_subpage)
 {
     MemoryRegionSection *section;
     MemoryRegion *mr;
     Int128 diff;
 
-    section = address_space_lookup_region(d, addr, resolve_subpage);
+    section = address_space_lookup_region(fv->dispatch, addr, resolve_subpage);
     /* Compute offset within MemoryRegionSection */
     addr -= section->offset_within_address_space;
 
@@ -453,7 +453,7 @@ static MemoryRegionSection address_space_translate_iommu(IOMMUMemoryRegion *iomm
         *target_as = iotlb.target_as;
 
         section = address_space_translate_internal(
-                address_space_to_dispatch(iotlb.target_as), addr, xlat,
+                address_space_to_flatview(iotlb.target_as), addr, xlat,
                 plen_out, is_mmio);
 
         iommu_mr = memory_region_get_iommu(section->mr);
@@ -506,9 +506,8 @@ static MemoryRegionSection flatview_do_translate(FlatView *fv,
         plen_out = &plen;
     }
 
-    section = address_space_translate_internal(
-            flatview_to_dispatch(fv), addr, xlat,
-            plen_out, is_mmio);
+    section = address_space_translate_internal(fv, addr, xlat,
+                                               plen_out, is_mmio);
 
     iommu_mr = memory_region_get_iommu(section->mr);
     if (unlikely(iommu_mr)) {
@@ -691,10 +690,11 @@ address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr orig_addr,
     IOMMUTLBEntry iotlb;
     int iommu_idx;
     hwaddr addr = orig_addr;
-    AddressSpaceDispatch *d = address_space_to_dispatch(cpu->cpu_ases[asidx].as);
+    FlatView *fv = address_space_to_flatview(cpu->cpu_ases[asidx].as);
 
     for (;;) {
-        section = address_space_translate_internal(d, addr, &addr, plen, false);
+        section = address_space_translate_internal(fv, addr, &addr, plen,
+                                                   false);
 
         iommu_mr = memory_region_get_iommu(section->mr);
         if (!iommu_mr) {
@@ -726,7 +726,7 @@ address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr orig_addr,
             goto translate_fail;
         }
 
-        d = flatview_to_dispatch(address_space_to_flatview(iotlb.target_as));
+        fv = address_space_to_flatview(iotlb.target_as);
     }
 
     assert(!memory_region_is_iommu(section->mr));
@@ -744,7 +744,7 @@ translate_fail:
      */
     assert((orig_addr & ~TARGET_PAGE_MASK) == 0);
     *xlat = orig_addr;
-    return &d->map.sections[PHYS_SECTION_UNASSIGNED];
+    return &fv->dispatch->map.sections[PHYS_SECTION_UNASSIGNED];
 }
 
 #endif /* CONFIG_TCG */
@@ -3886,7 +3886,6 @@ int64_t address_space_cache_init(MemoryRegionCache *cache,
                                  hwaddr len,
                                  bool is_write)
 {
-    AddressSpaceDispatch *d;
     hwaddr l;
     MemoryRegion *mr;
     Int128 diff;
@@ -3895,8 +3894,8 @@ int64_t address_space_cache_init(MemoryRegionCache *cache,
 
     l = len;
     cache->fv = address_space_get_flatview(as);
-    d = flatview_to_dispatch(cache->fv);
-    cache->mrs = *address_space_translate_internal(d, addr, &cache->xlat, &l, true);
+    cache->mrs = *address_space_translate_internal(cache->fv, addr,
+                                                   &cache->xlat, &l, true);
 
     /*
      * cache->xlat is now relative to cache->mrs.mr, not to the section itself.
-- 
2.53.0


