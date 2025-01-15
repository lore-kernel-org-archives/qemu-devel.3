Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91F5C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7rJ-0002Gf-Ul; Wed, 15 Jan 2025 13:11:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7pT-0006cm-8k
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:09:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7pR-0006bf-Ic
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:09:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RQVvjCs9hJ4fa3Za7Y4VaNHAdY6GKN1MD2EFSfUnud4=;
 b=H07XI4JHSwEbZCz/dkh63eJbJULUr9OXNSZYxGOYJGmuyd6wZDvZ3FJTOt6X4ieYw6wVXh
 omPi1a5X5+kJ4trYTVmUmGIDqlJx5oKv8Mb9VFSMhS7BzG6ok5AC2CLQXq0mOLu6wtoffY
 1OCGVVsl2c1yudg5Sc4u6SS40ORG9Dw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-DQkn53ULMBKS36Mt3Icifg-1; Wed, 15 Jan 2025 13:09:19 -0500
X-MC-Unique: DQkn53ULMBKS36Mt3Icifg-1
X-Mimecast-MFC-AGG-ID: DQkn53ULMBKS36Mt3Icifg
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4361f371908so47769235e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:09:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964557; x=1737569357;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RQVvjCs9hJ4fa3Za7Y4VaNHAdY6GKN1MD2EFSfUnud4=;
 b=VKtC6UCrBhcJmgz0ozqg8bjObWQiwye7IuNBmf6AQWuVqhCF2R+HooBvoEjO1fOr3/
 XimXQNLBo5+kaxWNHOmAFovWzUpZQFclhTN2sT/2jTyKknVrT0GTZIgvqUCoRnBGzQNj
 f15I72cZvVu4k97t7FDKv6WZ5HVTY/A2I+oGNW7vCRwUnQApqtbTaGCxQEiLW9OB3nRG
 U/2QUNYy/deb/is/oY65QLF+Ec4RHu+xowjG4oJxB4zL+Sk3AVJgsQRgvQRAF954SDZd
 IY7mr1JUf+/1VikeTKvcfnaE8ttWqvc/Omn++r4pg1XrYzhk32fY1YVZ+LrDJDCC87ki
 LC5A==
X-Gm-Message-State: AOJu0Yx4DOv9RlRwXkOZbShND6sT4RA2zUsyv/7oOA8JibKGGYYF5oGG
 DlhszWsHpoOuf8mdxgsCw/DBYbG040TQyblO8lV2kbm+DdoAIQDaBt9Lj18ZYqMLyttqVg39m52
 Gow8Kr5TzVz8+jbcUbr/ttVZmGLzmruRWPcxZVGSsAuVyKIWXj3mRVtYEaKNG+ID0hRDHxWbAYv
 aYlF+OTFs+W231RTI82H1StNgMsHopcA==
X-Gm-Gg: ASbGncvpHmfROMBPc4IiMyldg2Jv4T/fqJvG9x9juQf40xmEODAiQpTK+a/YypKHR1G
 rJwgTG5CUcFs7hxXELsd8g71njz0LjYga45xnBY4LCE+Uzhduxmi14gjBgZmK8N3qvaltxsDfW5
 k/17zqxUYdEDIrBC3RbgtqpN1NNPkFtXAEe7sex9MpspdXqIGtOgEFkRVIx4EsZ06ENEmOv/6Um
 O9FtW3oYwJryw+C5m606IXXDDHB09FuD7BAEV277R2XKJ4f6sYB
X-Received: by 2002:a05:6000:1f81:b0:386:7fe:af8e with SMTP id
 ffacd0b85a97d-38a872fb180mr8610726f8f.12.1736964557508; 
 Wed, 15 Jan 2025 10:09:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQkXfUKapP3mt5/pUn7Ms014kuuuqrdEw7Rmj8ArtLIgH4MGbkffSKeTsrN46emCSF/ib5bA==
X-Received: by 2002:a05:6000:1f81:b0:386:7fe:af8e with SMTP id
 ffacd0b85a97d-38a872fb180mr8610688f8f.12.1736964557069; 
 Wed, 15 Jan 2025 10:09:17 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c753c617sm31445005e9.37.2025.01.15.10.09.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:09:16 -0800 (PST)
Date: Wed, 15 Jan 2025 13:09:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 15/48] intel_iommu: Flush stage-1 cache in iotlb invalidation
Message-ID: <16d4e418e98feeb53f28d17eeffb198fe0fd6f22.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.793,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

According to spec, Page-Selective-within-Domain Invalidation (11b):

1. IOTLB entries caching second-stage mappings (PGTT=010b) or pass-through
(PGTT=100b) mappings associated with the specified domain-id and the
input-address range are invalidated.
2. IOTLB entries caching first-stage (PGTT=001b) or nested (PGTT=011b)
mapping associated with specified domain-id are invalidated.

So per spec definition the Page-Selective-within-Domain Invalidation
needs to flush first stage and nested cached IOTLB entries as well.

We don't support nested yet and pass-through mapping is never cached,
so what in iotlb cache are only first-stage and second-stage mappings.

Add a tag pgtt in VTDIOTLBEntry to mark PGTT type of the mapping and
invalidate entries based on PGTT type.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Message-Id: <20241212083757.605022-11-zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/i386/intel_iommu.h |  1 +
 hw/i386/intel_iommu.c         | 27 +++++++++++++++++++++------
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index f44f3eb63a..a434c2489c 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -155,6 +155,7 @@ struct VTDIOTLBEntry {
     uint64_t pte;
     uint64_t mask;
     uint8_t access_flags;
+    uint8_t pgtt;
 };
 
 /* VT-d Source-ID Qualifier types */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 0aeb0dbde9..95f344eb46 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -305,9 +305,21 @@ static gboolean vtd_hash_remove_by_page(gpointer key, gpointer value,
     VTDIOTLBPageInvInfo *info = (VTDIOTLBPageInvInfo *)user_data;
     uint64_t gfn = (info->addr >> VTD_PAGE_SHIFT_4K) & info->mask;
     uint64_t gfn_tlb = (info->addr & entry->mask) >> VTD_PAGE_SHIFT_4K;
-    return (entry->domain_id == info->domain_id) &&
-            (((entry->gfn & info->mask) == gfn) ||
-             (entry->gfn == gfn_tlb));
+
+    if (entry->domain_id != info->domain_id) {
+        return false;
+    }
+
+    /*
+     * According to spec, IOTLB entries caching first-stage (PGTT=001b) or
+     * nested (PGTT=011b) mapping associated with specified domain-id are
+     * invalidated. Nested isn't supported yet, so only need to check 001b.
+     */
+    if (entry->pgtt == VTD_SM_PASID_ENTRY_FLT) {
+        return true;
+    }
+
+    return (entry->gfn & info->mask) == gfn || entry->gfn == gfn_tlb;
 }
 
 /* Reset all the gen of VTDAddressSpace to zero and set the gen of
@@ -382,7 +394,7 @@ out:
 static void vtd_update_iotlb(IntelIOMMUState *s, uint16_t source_id,
                              uint16_t domain_id, hwaddr addr, uint64_t pte,
                              uint8_t access_flags, uint32_t level,
-                             uint32_t pasid)
+                             uint32_t pasid, uint8_t pgtt)
 {
     VTDIOTLBEntry *entry = g_malloc(sizeof(*entry));
     struct vtd_iotlb_key *key = g_malloc(sizeof(*key));
@@ -400,6 +412,7 @@ static void vtd_update_iotlb(IntelIOMMUState *s, uint16_t source_id,
     entry->access_flags = access_flags;
     entry->mask = vtd_pt_level_page_mask(level);
     entry->pasid = pasid;
+    entry->pgtt = pgtt;
 
     key->gfn = gfn;
     key->sid = source_id;
@@ -2062,7 +2075,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     bool is_fpd_set = false;
     bool reads = true;
     bool writes = true;
-    uint8_t access_flags;
+    uint8_t access_flags, pgtt;
     bool rid2pasid = (pasid == PCI_NO_PASID) && s->root_scalable;
     VTDIOTLBEntry *iotlb_entry;
     uint64_t xlat, size;
@@ -2171,9 +2184,11 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     if (s->flts && s->root_scalable) {
         ret_fr = vtd_iova_to_flpte(s, &ce, addr, is_write, &pte, &level,
                                    &reads, &writes, s->aw_bits, pasid);
+        pgtt = VTD_SM_PASID_ENTRY_FLT;
     } else {
         ret_fr = vtd_iova_to_slpte(s, &ce, addr, is_write, &pte, &level,
                                    &reads, &writes, s->aw_bits, pasid);
+        pgtt = VTD_SM_PASID_ENTRY_SLT;
     }
     if (!ret_fr) {
         xlat = vtd_get_pte_addr(pte, s->aw_bits);
@@ -2207,7 +2222,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     page_mask = vtd_pt_level_page_mask(level);
     access_flags = IOMMU_ACCESS_FLAG(reads, writes);
     vtd_update_iotlb(s, source_id, vtd_get_domain_id(s, &ce, pasid),
-                     addr, pte, access_flags, level, pasid);
+                     addr, pte, access_flags, level, pasid, pgtt);
 out:
     vtd_iommu_unlock(s);
     entry->iova = addr & page_mask;
-- 
MST


