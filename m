Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE501CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UFh-0003jm-0z; Sun, 05 Oct 2025 15:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFS-0002a3-Qo
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFQ-0006cU-HM
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QUvenOCO68kLl2GvX+LSUfN8U9FY9cK3kWYV0GrRBjw=;
 b=UVH3git7/ueaFJVbkIXGFFlrcoQ7TtZ30WdwsT/g3/jNS3YIp2yUFa54OmsWrf4vCXJXSV
 Vty33tsZKt7J4piySwc/FHJo1K7SzkEsawrpD6LXr7Sm28KfHlth/9qd7ohsaxfAYNrWDm
 hE4jxFDG5qqmV+IwNZ3FVsX6TEEHcto=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-FulVQ9JCNhqSn2Rr01hjMA-1; Sun, 05 Oct 2025 15:18:13 -0400
X-MC-Unique: FulVQ9JCNhqSn2Rr01hjMA-1
X-Mimecast-MFC-AGG-ID: FulVQ9JCNhqSn2Rr01hjMA_1759691892
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3ee10a24246so2032873f8f.3
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691888; x=1760296688;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QUvenOCO68kLl2GvX+LSUfN8U9FY9cK3kWYV0GrRBjw=;
 b=FJAUZ4/D9+VALfdanCluUbIVi29dZe8z46u20Y1469IdfgmZBo00IeW+LCO/x/c789
 OiWLSzCsyriDNMpb0kjJA4Sy+M2sUw+upCZo+feqa/Dk7gsZWI5Q57BOYcDdb+P2cLVz
 FeXghZOYXuajJzhKb6b1pwdoq9+PQtPLSuiyhh7LkJ4duhuKU04zg8edGRPCJcYxDYj5
 ybKAJAfiZkyfB4LdZ1UbSaoVtv9fpWrDmasAOFAfoZ0wX1+9mfaFDhulv5DTIqeGn0a/
 mJlzjFnB3MnIZvtxhZDcBTW5St30/uwFP7SlHLQ7tIz4ycJyetLVT/OQq7ESkijFud5u
 OoFw==
X-Gm-Message-State: AOJu0YzkWR7+QRvqmXBNYr1JHgzfh5Oi3qTTWRfl3KMiC9fsTwkp+xvV
 UAiE1v9RXmuQ13J18RvQTr3jejX2Rf/FzcpYxixCbCFn5HAia2O9No8QD6/BN6VNwrmMwieUf4A
 W+Q+T9jaPXs0Imci6opGRfp5cysFe31rT+DiVF0daHGAmvZpDhvfVazvgiz2gHHcOubmpioJ3VY
 NaR7J4DdgVjIvReP5PLrHdQhRFQZXF038LQA==
X-Gm-Gg: ASbGnct+wvEOeqokzXuAMCefuQsBysft8adLwhYYsMENxLNcfHGa1dOjEJqjqo768jI
 sBDWGlYcQMqp2kcgKVLFbq0pI3UHGOztc+f0wwVjIZANFmH3YDmVIf5oHKtsu+kD6qCogaR5sZC
 9Cx3TXRd+1l/J6Cx/PCg5DqH6YP3RFHS3dLbcIa55jc0fvEIDVzuYwgjsLAJ79xW0JtYSdtIwfz
 6cR6+6ZWeOZMuHROCatlXCurg0el8f7S0oxH3T4eC6HCvZhfBEFy9GgpIaRTzP0d4n4/0GzzWob
 o8QrHiCK3+r/fcnFFlg35pVc0WiqJkjzbHL6fks=
X-Received: by 2002:a05:6000:2401:b0:3ea:e0fd:28e8 with SMTP id
 ffacd0b85a97d-4256719e9c6mr5919195f8f.32.1759691888227; 
 Sun, 05 Oct 2025 12:18:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtPM52Nj0JoCGtTCSnIYRGdunYIGeK2hexqu9nVPxW031A7jShUqMCt4B1cRrLU3+3LCgzRw==
X-Received: by 2002:a05:6000:2401:b0:3ea:e0fd:28e8 with SMTP id
 ffacd0b85a97d-4256719e9c6mr5919177f8f.32.1759691887605; 
 Sun, 05 Oct 2025 12:18:07 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f02a8sm17682605f8f.39.2025.10.05.12.18.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:18:07 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:18:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 56/75] amd_iommu: Add helpers to walk AMD v1 Page Table format
Message-ID: <39789107398c5c554efe0ff3726b3b3671dfb376.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

The current amdvi_page_walk() is designed to be called by the replay()
method. Rather than drastically altering it, introduce helpers to fetch
guest PTEs that will be used by a page walker implementation.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250919213515.917111-8-alejandro.j.jimenez@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.h |  40 ++++++++++++++
 hw/i386/amd_iommu.c | 123 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 163 insertions(+)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index c1170a8202..9f833b297d 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -178,6 +178,46 @@
 #define AMDVI_GATS_MODE                 (2ULL <<  12)
 #define AMDVI_HATS_MODE                 (2ULL <<  10)
 
+/* Page Table format */
+
+#define AMDVI_PTE_PR                    (1ULL << 0)
+#define AMDVI_PTE_NEXT_LEVEL_MASK       GENMASK64(11, 9)
+
+#define IOMMU_PTE_PRESENT(pte)          ((pte) & AMDVI_PTE_PR)
+
+/* Using level=0 for leaf PTE at 4K page size */
+#define PT_LEVEL_SHIFT(level)           (12 + ((level) * 9))
+
+/* Return IOVA bit group used to index the Page Table at specific level */
+#define PT_LEVEL_INDEX(level, iova)     (((iova) >> PT_LEVEL_SHIFT(level)) & \
+                                        GENMASK64(8, 0))
+
+/* Return the max address for a specified level i.e. max_oaddr */
+#define PT_LEVEL_MAX_ADDR(x)    (((x) < 5) ? \
+                                ((1ULL << PT_LEVEL_SHIFT((x + 1))) - 1) : \
+                                (~(0ULL)))
+
+/* Extract the NextLevel field from PTE/PDE */
+#define PTE_NEXT_LEVEL(pte)     (((pte) & AMDVI_PTE_NEXT_LEVEL_MASK) >> 9)
+
+/* Take page table level and return default pagetable size for level */
+#define PTE_LEVEL_PAGE_SIZE(level)      (1ULL << (PT_LEVEL_SHIFT(level)))
+
+/*
+ * Return address of lower level page table encoded in PTE and specified by
+ * current level and corresponding IOVA bit group at such level.
+ */
+#define NEXT_PTE_ADDR(pte, level, iova) (((pte) & AMDVI_DEV_PT_ROOT_MASK) + \
+                                        (PT_LEVEL_INDEX(level, iova) * 8))
+
+/*
+ * Take a PTE value with mode=0x07 and return the page size it encodes.
+ */
+#define PTE_LARGE_PAGE_SIZE(pte)    (1ULL << (1 + cto64(((pte) | 0xfffULL))))
+
+/* Return number of PTEs to use for a given page size (expected power of 2) */
+#define PAGE_SIZE_PTE_COUNT(pgsz)       (1ULL << ((ctz64(pgsz) - 12) % 9))
+
 /* IOTLB */
 #define AMDVI_IOTLB_MAX_SIZE 1024
 #define AMDVI_DEVID_SHIFT    36
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 29ed3f0ef2..c25981ff93 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -87,6 +87,8 @@ typedef enum AMDVIFaultReason {
     AMDVI_FR_DTE_RTR_ERR = 1,   /* Failure to retrieve DTE */
     AMDVI_FR_DTE_V,             /* DTE[V] = 0 */
     AMDVI_FR_DTE_TV,            /* DTE[TV] = 0 */
+    AMDVI_FR_PT_ROOT_INV,       /* Page Table Root ptr invalid */
+    AMDVI_FR_PT_ENTRY_INV,      /* Failure to read PTE from guest memory */
 } AMDVIFaultReason;
 
 uint64_t amdvi_extended_feature_register(AMDVIState *s)
@@ -558,6 +560,127 @@ static int amdvi_as_to_dte(AMDVIAddressSpace *as, uint64_t *dte)
     return 0;
 }
 
+/*
+ * For a PTE encoding a large page, return the page size it encodes as described
+ * by the AMD IOMMU Specification Table 14: Example Page Size Encodings.
+ * No need to adjust the value of the PTE to point to the first PTE in the large
+ * page since the encoding guarantees all "base" PTEs in the large page are the
+ * same.
+ */
+static uint64_t large_pte_page_size(uint64_t pte)
+{
+    assert(PTE_NEXT_LEVEL(pte) == 7);
+
+    /* Determine size of the large/contiguous page encoded in the PTE */
+    return PTE_LARGE_PAGE_SIZE(pte);
+}
+
+/*
+ * Helper function to fetch a PTE using AMD v1 pgtable format.
+ * On successful page walk, returns 0 and pte parameter points to a valid PTE.
+ * On failure, returns:
+ * -AMDVI_FR_PT_ROOT_INV: A page walk is not possible due to conditions like DTE
+ *      with invalid permissions, Page Table Root can not be read from DTE, or a
+ *      larger IOVA than supported by page table level encoded in DTE[Mode].
+ * -AMDVI_FR_PT_ENTRY_INV: A PTE could not be read from guest memory during a
+ *      page table walk. This means that the DTE has valid data, but one of the
+ *      lower level entries in the Page Table could not be read.
+ */
+static int __attribute__((unused))
+fetch_pte(AMDVIAddressSpace *as, hwaddr address, uint64_t dte, uint64_t *pte,
+          hwaddr *page_size)
+{
+    IOMMUAccessFlags perms = amdvi_get_perms(dte);
+
+    uint8_t level, mode;
+    uint64_t pte_addr;
+
+    *pte = dte;
+    *page_size = 0;
+
+    if (perms == IOMMU_NONE) {
+        return -AMDVI_FR_PT_ROOT_INV;
+    }
+
+    /*
+     * The Linux kernel driver initializes the default mode to 3, corresponding
+     * to a 39-bit GPA space, where each entry in the pagetable translates to a
+     * 1GB (2^30) page size.
+     */
+    level = mode = get_pte_translation_mode(dte);
+    assert(mode > 0 && mode < 7);
+
+    /*
+     * If IOVA is larger than the max supported by the current pgtable level,
+     * there is nothing to do.
+     */
+    if (address > PT_LEVEL_MAX_ADDR(mode - 1)) {
+        /* IOVA too large for the current DTE */
+        return -AMDVI_FR_PT_ROOT_INV;
+    }
+
+    do {
+        level -= 1;
+
+        /* Update the page_size */
+        *page_size = PTE_LEVEL_PAGE_SIZE(level);
+
+        /* Permission bits are ANDed at every level, including the DTE */
+        perms &= amdvi_get_perms(*pte);
+        if (perms == IOMMU_NONE) {
+            return 0;
+        }
+
+        /* Not Present */
+        if (!IOMMU_PTE_PRESENT(*pte)) {
+            return 0;
+        }
+
+        /* Large or Leaf PTE found */
+        if (PTE_NEXT_LEVEL(*pte) == 7 || PTE_NEXT_LEVEL(*pte) == 0) {
+            /* Leaf PTE found */
+            break;
+        }
+
+        /*
+         * Index the pgtable using the IOVA bits corresponding to current level
+         * and walk down to the lower level.
+         */
+        pte_addr = NEXT_PTE_ADDR(*pte, level, address);
+        *pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as->devfn);
+
+        if (*pte == (uint64_t)-1) {
+            /*
+             * A returned PTE of -1 indicates a failure to read the page table
+             * entry from guest memory.
+             */
+            if (level == mode - 1) {
+                /* Failure to retrieve the Page Table from Root Pointer */
+                *page_size = 0;
+                return -AMDVI_FR_PT_ROOT_INV;
+            } else {
+                /* Failure to read PTE. Page walk skips a page_size chunk */
+                return -AMDVI_FR_PT_ENTRY_INV;
+            }
+        }
+    } while (level > 0);
+
+    assert(PTE_NEXT_LEVEL(*pte) == 0 || PTE_NEXT_LEVEL(*pte) == 7 ||
+           level == 0);
+    /*
+     * Page walk ends when Next Level field on PTE shows that either a leaf PTE
+     * or a series of large PTEs have been reached. In the latter case, even if
+     * the range starts in the middle of a contiguous page, the returned PTE
+     * must be the first PTE of the series.
+     */
+    if (PTE_NEXT_LEVEL(*pte) == 7) {
+        /* Update page_size with the large PTE page size */
+        *page_size = large_pte_page_size(*pte);
+    }
+
+    return 0;
+}
+
 /* log error without aborting since linux seems to be using reserved bits */
 static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
 {
-- 
MST


