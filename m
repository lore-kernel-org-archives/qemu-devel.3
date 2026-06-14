Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF1DCD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:16:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqCK-0006XQ-My; Sun, 14 Jun 2026 15:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCA-00065h-KZ
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqC8-0002Ht-NX
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pCyO86h5epZnCTJ4MCbMU1ZI7owfykpa/8SOyuRyK2c=;
 b=TxyE+BGOciKbta5FYEwnkcyIvOFBzY878WVX5Q2vKGxblvGT+OstrephePuFwkkzkJBVrd
 bg2DQM4zLP+KaXOFPsTK6eTkHdI//Q7VOYdR/mJG33mTAjzLkBRHKHu0Zj2srrsWi/1Mjb
 wKXeX2D2d2h2A6XADH1rl79mOC7/NsU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-DwZH6vqRNHO9IdMNnNaH7A-1; Sun, 14 Jun 2026 15:08:28 -0400
X-MC-Unique: DwZH6vqRNHO9IdMNnNaH7A-1
X-Mimecast-MFC-AGG-ID: DwZH6vqRNHO9IdMNnNaH7A_1781464108
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490b9cd54f3so14818835e9.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464107; x=1782068907; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pCyO86h5epZnCTJ4MCbMU1ZI7owfykpa/8SOyuRyK2c=;
 b=oIdAsJt5ua0Fp73DfPSS6UdkZP8GGjOLnpgskrv2gSXIAPKcUkjvXMB8tJgY7Od54l
 w8EodZE/o9vh9Zh55BEbLuRg5NiBcazYlOHu3h52vWuL5AzUYWKgKUUjtlQFdsDPVE2x
 XAr6Vobq5n6+9vjLAoKfZfBEWQsdJTAnFtfrCbzj6Id/xQKlHceQbWAjHB87Ju9l8RAH
 SOdfEj1ZL2HzaNKFjvJzN1jjeHuwvsTzFwCCN3WNYQ9293TypGNt9gU+HPjkcAmgNtKm
 aaO+/P7UicpRhfo0wezEygRyLqLnAF/aGwuH5jD8EwKkPrcjF385YBvupwp0YnGlpPnm
 hRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464107; x=1782068907;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pCyO86h5epZnCTJ4MCbMU1ZI7owfykpa/8SOyuRyK2c=;
 b=EZJpsyGP7DMrHh4O+5b9p8UdDPejfsco7uQg3T8Idxx7TmFOqp2hH5VHOm/LrLFbxD
 JP4KF/Y+Jrvi7lB+wXFrPFLGDY/VzHCtfmXv2XKSUf0DstUHBDU8vkT9kwjY1lxJv9ju
 onzZlwSs2sjDA5I4KVDTuwXboxyRdGNsPRDFIC0FTCf+lDtN817icmUIT1gtYkhey5F5
 wARpJaITGDzMwg5Z2xoJUV+ebFH7Q1s2VulpdoTmHhH2BXOjyftAPMAkPxt7mSSds/VP
 NHJVL0xS3rpE7tDLdRX4uojlOFCZQRnTT98xoeJDZKDeX5keuVUvNDUENYbWo8mo/Cq/
 OSew==
X-Gm-Message-State: AOJu0YwV7kJD6GvE8spONjrfUXM6HIYAQBHQdo/h7hxQhZug6oVjt8TB
 CHiQWbzqEB4MV4koZ/fxmb7mD9yfkAY3ABrsZhmjn35WYnd53CsWDqZ0ymvwcE/jXco/mAQ14ne
 DTEOXleKzPhjwBQj7Jhb+Gfc6+TbAtVIXpINFhgReLyuC6wcNiW438+qJzPWJoElZEDSww23tAv
 xLg1sAs3nQXLiWlxuE1K0Un3AbMz1eKfHmdQ==
X-Gm-Gg: Acq92OEXEPHGOPfZoAV3q2tl35DLrgQ86nI/LZOfgxRdF1M1Q+Gv8EnrDj9mZly5/oL
 ri7qenYlUj4DUOZ1x4+Tq+9eLpI4oKw+HRruWCzh/VRW7eTPV34HA+K5JeKenABJYsoCpz5r6yO
 8BdBiI1t5XI2Om4F1FCt34RRbOR4vclMH9ICKfxx50BamoE/SaUCfC4s26zxr0+e2QVbf+dCHyw
 rDNQpmDnnRWDmxgp8/pNOH4MsD+yMGlcQpdjr7FdoqQ5HvI2J9g26x6wp3lQXuPxZF1I/7NR0bx
 tJfmXCAQfZT80wZ8tgoh8uHKYiAU+PCdMZX3CQBHe6JSaangF4fJj5CPuclyFdEN6WGDa32E3+p
 7DVaIJ7DQziD2KvvChP09oE55PDDFaAbFBUmZeKDK1Zo=
X-Received: by 2002:a05:600c:1906:b0:492:1edf:9fbc with SMTP id
 5b1f17b1804b1-492200516f3mr93037775e9.1.1781464107427; 
 Sun, 14 Jun 2026 12:08:27 -0700 (PDT)
X-Received: by 2002:a05:600c:1906:b0:492:1edf:9fbc with SMTP id
 5b1f17b1804b1-492200516f3mr93037315e9.1.1781464106758; 
 Sun, 14 Jun 2026 12:08:26 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922032ae56sm179875015e9.7.2026.06.14.12.08.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:08:26 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:08:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 qemu-stable@nongnu.org, David Hoppenbrouwers <qemu@demindiro.com>,
 Sairaj Kodilkar <sarunkod@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 063/106] amd_iommu: Follow root pointer before page walk and
 use 1-based levels
Message-ID: <786550e2d38a92e90c13eb9d57e3a72d7ab38d51.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

DTE[Mode] and PTE NextLevel encode page table levels as 1-based values, but
fetch_pte() currently uses a 0-based level counter, making the logic
harder to follow and requiring conversions between DTE mode and level.

Switch the page table walk logic to use 1-based level accounting in
fetch_pte() and the relevant macro helpers. To further simplify the page
walking loop, split the root page table access from the walk i.e. rework
fetch_pte() to follow the DTE Page Table Root Pointer and retrieve the top
level pagetable entry before entering the loop, then iterate only over the
PDE/PTE entries.

The reworked algorithm fixes a page walk bug where the page size was
calculated for the next level before checking if the current PTE was already
a leaf/hugepage. That caused hugepage mappings to be reported as 4K pages,
leading to performance degradation and failures in some setups.

Fixes: a74bb3110a5b ("amd_iommu: Add helpers to walk AMD v1 Page Table format")
Cc: qemu-stable@nongnu.org
Reported-by: David Hoppenbrouwers <qemu@demindiro.com>
Reviewed-By: David Hoppenbrouwers <qemu@demindiro.com>
Reviewed-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260330212817.992673-2-alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 134 ++++++++++++++++++++++++++++++--------------
 hw/i386/amd_iommu.h |  11 ++--
 2 files changed, 98 insertions(+), 47 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 5d6a405263..bc083d0073 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -648,6 +648,52 @@ static uint64_t large_pte_page_size(uint64_t pte)
     return PTE_LARGE_PAGE_SIZE(pte);
 }
 
+/*
+ * Validate DTE fields and extract permissions and top level data required to
+ * initiate the page table walk.
+ *
+ * On success, returns 0 and stores:
+ *   - top_level: highest page-table level encoded in DTE[Mode]
+ *   - dte_perms: effective permissions from the DTE
+ *
+ * On failure, returns -AMDVI_FR_PT_ROOT_INV. This includes cases where:
+ *   - DTE permissions disallow read AND write
+ *   - DTE[Mode] is invalid for translation
+ *   - IOVA exceeds the address width supported by DTE[Mode]
+ * In all such cases a page walk must be aborted.
+ */
+static uint64_t amdvi_get_top_pt_level_and_perms(hwaddr address, uint64_t dte,
+                                                 uint8_t *top_level,
+                                                 IOMMUAccessFlags *dte_perms)
+{
+    *dte_perms = amdvi_get_perms(dte);
+    if (*dte_perms == IOMMU_NONE) {
+        return -AMDVI_FR_PT_ROOT_INV;
+    }
+
+    /* Verifying a valid mode is encoded in DTE */
+    *top_level = get_pte_translation_mode(dte);
+
+    /*
+     * Page Table Root pointer is only valid for GPA->SPA translation on
+     * supported modes.
+     */
+    if (*top_level == 0 || *top_level > 6) {
+        return -AMDVI_FR_PT_ROOT_INV;
+    }
+
+    /*
+     * If IOVA is larger than the max supported by the highest pgtable level,
+     * there is nothing to do.
+     */
+    if (address > PT_LEVEL_MAX_ADDR(*top_level)) {
+        /* IOVA too large for the current DTE */
+        return -AMDVI_FR_PT_ROOT_INV;
+    }
+
+    return 0;
+}
+
 /*
  * Helper function to fetch a PTE using AMD v1 pgtable format.
  * On successful page walk, returns 0 and pte parameter points to a valid PTE.
@@ -662,40 +708,49 @@ static uint64_t large_pte_page_size(uint64_t pte)
 static uint64_t fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
                           uint64_t *pte, hwaddr *page_size)
 {
-    IOMMUAccessFlags perms = amdvi_get_perms(dte);
-
-    uint8_t level, mode;
     uint64_t pte_addr;
+    uint8_t pt_level, next_pt_level;
+    IOMMUAccessFlags perms;
+    int ret;
 
-    *pte = dte;
     *page_size = 0;
 
-    if (perms == IOMMU_NONE) {
+    /*
+     * Verify the DTE is properly configured before page walk, and extract
+     * top pagetable level and permissions.
+     */
+    ret = amdvi_get_top_pt_level_and_perms(address, dte, &pt_level, &perms);
+    if (ret < 0) {
+        return ret;
+    }
+
+    /*
+     * Retrieve the top pagetable entry by following the DTE Page Table Root
+     * Pointer and indexing the top level table using the IOVA from the request.
+     */
+    pte_addr = NEXT_PTE_ADDR(dte, pt_level, address);
+    *pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as->devfn);
+
+    if (*pte == (uint64_t)-1) {
+        /*
+         * A returned PTE of -1 here indicates a failure to read the top level
+         * page table from guest memory. A page walk is not possible and page
+         * size must be returned as 0.
+         */
         return -AMDVI_FR_PT_ROOT_INV;
     }
 
     /*
-     * The Linux kernel driver initializes the default mode to 3, corresponding
-     * to a 39-bit GPA space, where each entry in the pagetable translates to a
-     * 1GB (2^30) page size.
+     * Calculate page size for the top level page table entry.
+     * This ensures correct results for a single level Page Table setup.
      */
-    level = mode = get_pte_translation_mode(dte);
-    assert(mode > 0 && mode < 7);
+    *page_size = PTE_LEVEL_PAGE_SIZE(pt_level);
 
     /*
-     * If IOVA is larger than the max supported by the current pgtable level,
-     * there is nothing to do.
+     * The root page table entry and its level have been determined. Begin the
+     * page walk.
      */
-    if (address > PT_LEVEL_MAX_ADDR(mode - 1)) {
-        /* IOVA too large for the current DTE */
-        return -AMDVI_FR_PT_ROOT_INV;
-    }
-
-    do {
-        level -= 1;
-
-        /* Update the page_size */
-        *page_size = PTE_LEVEL_PAGE_SIZE(level);
+    while (pt_level > 0) {
 
         /* Permission bits are ANDed at every level, including the DTE */
         perms &= amdvi_get_perms(*pte);
@@ -708,37 +763,34 @@ static uint64_t fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte,
             return 0;
         }
 
+        next_pt_level = PTE_NEXT_LEVEL(*pte);
+
         /* Large or Leaf PTE found */
-        if (PTE_NEXT_LEVEL(*pte) == 7 || PTE_NEXT_LEVEL(*pte) == 0) {
+        if (next_pt_level == 0 || next_pt_level == 7) {
             /* Leaf PTE found */
             break;
         }
 
+        pt_level = next_pt_level;
+
         /*
-         * Index the pgtable using the IOVA bits corresponding to current level
-         * and walk down to the lower level.
+         * The current entry is a Page Directory Entry. Descend to the lower
+         * page table level encoded in current pte, and index the new table
+         * using the appropriate IOVA bits to retrieve the new entry.
          */
-        pte_addr = NEXT_PTE_ADDR(*pte, level, address);
+        *page_size = PTE_LEVEL_PAGE_SIZE(pt_level);
+
+        pte_addr = NEXT_PTE_ADDR(*pte, pt_level, address);
         *pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as->devfn);
 
         if (*pte == (uint64_t)-1) {
-            /*
-             * A returned PTE of -1 indicates a failure to read the page table
-             * entry from guest memory.
-             */
-            if (level == mode - 1) {
-                /* Failure to retrieve the Page Table from Root Pointer */
-                *page_size = 0;
-                return -AMDVI_FR_PT_ROOT_INV;
-            } else {
-                /* Failure to read PTE. Page walk skips a page_size chunk */
-                return -AMDVI_FR_PT_ENTRY_INV;
-            }
+            /* Failure to read PTE. Page walk skips a page_size chunk */
+            return -AMDVI_FR_PT_ENTRY_INV;
         }
-    } while (level > 0);
+    }
+
+    assert(PTE_NEXT_LEVEL(*pte) == 0 || PTE_NEXT_LEVEL(*pte) == 7);
 
-    assert(PTE_NEXT_LEVEL(*pte) == 0 || PTE_NEXT_LEVEL(*pte) == 7 ||
-           level == 0);
     /*
      * Page walk ends when Next Level field on PTE shows that either a leaf PTE
      * or a series of large PTEs have been reached. In the latter case, even if
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 302ccca512..7af3c742b7 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -186,17 +186,16 @@
 
 #define IOMMU_PTE_PRESENT(pte)          ((pte) & AMDVI_PTE_PR)
 
-/* Using level=0 for leaf PTE at 4K page size */
-#define PT_LEVEL_SHIFT(level)           (12 + ((level) * 9))
+/* Using level=1 for leaf PTE at 4K page size */
+#define PT_LEVEL_SHIFT(level)           (12 + (((level) - 1) * 9))
 
 /* Return IOVA bit group used to index the Page Table at specific level */
 #define PT_LEVEL_INDEX(level, iova)     (((iova) >> PT_LEVEL_SHIFT(level)) & \
                                         GENMASK64(8, 0))
 
-/* Return the max address for a specified level i.e. max_oaddr */
-#define PT_LEVEL_MAX_ADDR(x)    (((x) < 5) ? \
-                                ((1ULL << PT_LEVEL_SHIFT((x + 1))) - 1) : \
-                                (~(0ULL)))
+/* Return the maximum output address for a specified page table level */
+#define PT_LEVEL_MAX_ADDR(level)    (((level) > 5) ? (~(0ULL)) : \
+                                    ((1ULL << PT_LEVEL_SHIFT((level) + 1)) - 1))
 
 /* Extract the NextLevel field from PTE/PDE */
 #define PTE_NEXT_LEVEL(pte)     (((pte) & AMDVI_PTE_NEXT_LEVEL_MASK) >> 9)
-- 
MST


