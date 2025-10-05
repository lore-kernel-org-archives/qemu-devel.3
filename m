Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE755CAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UGZ-0006cD-MJ; Sun, 05 Oct 2025 15:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFt-0004pr-7s
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFm-0006fg-Pl
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=one5aMpcdf5KTSY+OWTqXXbQYegt1IKrQftjUhBs24c=;
 b=cILT/p6zxaFRJEK3sHK/6KK/S8LuhGN9pum9Lescfcd7sGTmQcqr/hZjvE2nGchV4NVcme
 5GNR5jNISfSF8NwS6q719Cs38NRH4lODYACQFubcB5+pmMM7QIWcE17xzPI6oaxBoeQogC
 nngI1ovAvoWWn4opTDFO6rUnlW64V40=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-fX1WZsKlPuKnKk6qqJoZwQ-1; Sun, 05 Oct 2025 15:18:38 -0400
X-MC-Unique: fX1WZsKlPuKnKk6qqJoZwQ-1
X-Mimecast-MFC-AGG-ID: fX1WZsKlPuKnKk6qqJoZwQ_1759691918
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3efe4fcc9ccso2224259f8f.3
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:18:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691917; x=1760296717;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=one5aMpcdf5KTSY+OWTqXXbQYegt1IKrQftjUhBs24c=;
 b=TljJYrypd/xMPqjsfmMSperaPncd+d63EPD9b1jt7lB48SmNrr1bdoWA7ZI0l+D62S
 ubSe8dxPcZBIvbVUuh+voxvFK8ngom3Mb/8pwFq3dl/5YR25yDgBHWjDQNbA8j0o53F2
 Yx7WqFjGAe4g6fZBrJZVs6ezein/Hziid3znerGo65JnTXqrlf1nXAsqFiNeA3XpktZb
 ISPVWfxDCN/9u9jNj1Dbg6LBkY4KXwR51b0ojdgIF40h2gMDgV0VT0nSeNyCWtZBMvWT
 k8i8DwN1wHxWME0oNBq8t5lmZLzVa17BttOGGw4bmr3P0oLcKD+iR2lBerwdhKoI8yzu
 TMtg==
X-Gm-Message-State: AOJu0Yz1cJ33mZmOEJc7LWPnmsUGxdPQ/i8fvpbBjZaB6Kg+mKVZnEqZ
 7iHJJ1WxInADuKwuqlJRR95FfE+lLxyPZaCSXt7k4DzZFYB9SWq4VGk6lBLhh4Sem0hCeypIzdN
 JUZlowMyBpqBxtE7jhQfLU38aMLW0quimE63qbvt48I+N+6Kn5CivDtqrxDtV1SoM02n3xYGZoa
 onBVr/J12OkrHlNz5tuYIoDNY8y6SS/OZDEw==
X-Gm-Gg: ASbGncuZwmrUS65HXM6BlhAMZ2cNU8DKgmrgmKI1RVkJtw+JJfZV1FFzLEFfd6fJTa9
 QIc7hYqGXx3x21k72A0Hnk+LbtGD2SxnsNUOjKfd93CdHFcYO5OThxoYHflQfK2BuuK8eDlOLZK
 S/2LIyYXC/63JQ/c6Uy3wBOoTyXjJ+ywRg6Cwm5qsbF4SX58JNV3U0xcRuR9u8PyzHvlsTOOMQ8
 vshvUWTD2tDJZroZmVtBAw1HWwUkKyhfzWzSKpmygdtoIGwfBHEet/2eXxh02eGYKTvbkX/hHyA
 IlHXSxl+AZFmFbyphYgWsUYMeJzEARnPcUTPcvU=
X-Received: by 2002:a05:6000:2212:b0:3ee:d165:2edd with SMTP id
 ffacd0b85a97d-4256713fe43mr6044597f8f.28.1759691917180; 
 Sun, 05 Oct 2025 12:18:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkbOrqWzWRnSQdIrcyW1mKsZwgVAOUEjk2e6LxwteV+8/Qn/cT39ijeAp3jRGIdUUtuCuftg==
X-Received: by 2002:a05:6000:2212:b0:3ee:d165:2edd with SMTP id
 ffacd0b85a97d-4256713fe43mr6044576f8f.28.1759691916606; 
 Sun, 05 Oct 2025 12:18:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f4abcsm17354316f8f.53.2025.10.05.12.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:18:36 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:18:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 69/75] amd_iommu: Refactor amdvi_page_walk() to use common
 code for page walk
Message-ID: <ab8b7c78c265106dd53453bc7b8afa26203a4180.1759691708.git.mst@redhat.com>
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

Simplify amdvi_page_walk() by making it call the fetch_pte() helper that is
already in use by the shadow page synchronization code. Ensures all code
uses the same page table walking algorithm.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250919213515.917111-21-alejandro.j.jimenez@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.c | 77 ++++++++++++++++-----------------------------
 1 file changed, 27 insertions(+), 50 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 1bda2a8ac3..b6851784fb 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -513,24 +513,6 @@ static inline uint8_t get_pte_translation_mode(uint64_t pte)
     return (pte >> AMDVI_DEV_MODE_RSHIFT) & AMDVI_DEV_MODE_MASK;
 }
 
-static inline uint64_t pte_override_page_mask(uint64_t pte)
-{
-    uint8_t page_mask = 13;
-    uint64_t addr = (pte & AMDVI_DEV_PT_ROOT_MASK) >> 12;
-    /* find the first zero bit */
-    while (addr & 1) {
-        page_mask++;
-        addr = addr >> 1;
-    }
-
-    return ~((1ULL << page_mask) - 1);
-}
-
-static inline uint64_t pte_get_page_mask(uint64_t oldlevel)
-{
-    return ~((1UL << ((oldlevel * 9) + 3)) - 1);
-}
-
 static inline uint64_t amdvi_get_pte_entry(AMDVIState *s, uint64_t pte_addr,
                                           uint16_t devid)
 {
@@ -1718,11 +1700,13 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
                             IOMMUTLBEntry *ret, unsigned perms,
                             hwaddr addr)
 {
-    unsigned level, present, pte_perms, oldlevel;
-    uint64_t pte = dte[0], pte_addr, page_mask;
+    hwaddr page_mask, pagesize = 0;
+    uint8_t mode;
+    uint64_t pte;
+    int fetch_ret;
 
     /* make sure the DTE has TV = 1 */
-    if (!(pte & AMDVI_DEV_TRANSLATION_VALID)) {
+    if (!(dte[0] & AMDVI_DEV_TRANSLATION_VALID)) {
         /*
          * A DTE with V=1, TV=0 does not have a valid Page Table Root Pointer.
          * An IOMMU processing a request that requires a table walk terminates
@@ -1733,42 +1717,35 @@ static void amdvi_page_walk(AMDVIAddressSpace *as, uint64_t *dte,
         return;
     }
 
-    level = get_pte_translation_mode(pte);
-    if (level >= 7) {
-        trace_amdvi_mode_invalid(level, addr);
+    mode = get_pte_translation_mode(dte[0]);
+    if (mode >= 7) {
+        trace_amdvi_mode_invalid(mode, addr);
         return;
     }
-    if (level == 0) {
+    if (mode == 0) {
         goto no_remap;
     }
 
-    /* we are at the leaf page table or page table encodes a huge page */
-    do {
-        pte_perms = amdvi_get_perms(pte);
-        present = pte & 1;
-        if (!present || perms != (perms & pte_perms)) {
-            amdvi_page_fault(as->iommu_state, as->devfn, addr, perms);
-            trace_amdvi_page_fault(addr);
-            return;
-        }
-        /* go to the next lower level */
-        pte_addr = pte & AMDVI_DEV_PT_ROOT_MASK;
-        /* add offset and load pte */
-        pte_addr += ((addr >> (3 + 9 * level)) & 0x1FF) << 3;
-        pte = amdvi_get_pte_entry(as->iommu_state, pte_addr, as->devfn);
-        if (!pte) {
-            return;
-        }
-        oldlevel = level;
-        level = get_pte_translation_mode(pte);
-    } while (level > 0 && level < 7);
+    /* Attempt to fetch the PTE to determine if a valid mapping exists */
+    fetch_ret = fetch_pte(as, addr, dte[0], &pte, &pagesize);
 
-    if (level == 0x7) {
-        page_mask = pte_override_page_mask(pte);
-    } else {
-        page_mask = pte_get_page_mask(oldlevel);
+    /*
+     * If walking the page table results in an error of any type, returns an
+     * empty PTE i.e. no mapping, or the permissions do not match, return since
+     * there is no translation available.
+     */
+    if (fetch_ret < 0 || !IOMMU_PTE_PRESENT(pte) ||
+        perms != (perms & amdvi_get_perms(pte))) {
+
+        amdvi_page_fault(as->iommu_state, as->devfn, addr, perms);
+        trace_amdvi_page_fault(addr);
+        return;
     }
 
+    /* A valid PTE and page size has been retrieved */
+    assert(pagesize);
+    page_mask = ~(pagesize - 1);
+
     /* get access permissions from pte */
     ret->iova = addr & page_mask;
     ret->translated_addr = (pte & AMDVI_DEV_PT_ROOT_MASK) & page_mask;
@@ -1780,7 +1757,7 @@ no_remap:
     ret->iova = addr & AMDVI_PAGE_MASK_4K;
     ret->translated_addr = addr & AMDVI_PAGE_MASK_4K;
     ret->addr_mask = ~AMDVI_PAGE_MASK_4K;
-    ret->perm = amdvi_get_perms(pte);
+    ret->perm = amdvi_get_perms(dte[0]);
 }
 
 static void amdvi_do_translate(AMDVIAddressSpace *as, hwaddr addr,
-- 
MST


