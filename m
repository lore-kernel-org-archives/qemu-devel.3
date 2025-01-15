Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 988DAC02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7r5-0000YT-LD; Wed, 15 Jan 2025 13:11:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7pV-0006d8-Nv
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:09:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7pU-0006cc-3p
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:09:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9o3c4LwUlk7AnTB7u8f2qn4E+H/wLdxNYk39uQ2dceI=;
 b=c/gcUORUr6TrEhmUTiJudWn5YNDiD1TRsp7InnoQ+SJj6mgI8bjBsfugYYt51MAvjf52Vq
 UrpE8FOOowYGEx87zcaJggo+EUpkFN7/dpOlw71F7vTjUtOUxSX4BipoSIr/cRN9KvM9Fy
 Wv+oWPuqBu+rUfjTSlitonHeo46898s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-nKAgLcyNNKizJwX1h5Y4GQ-1; Wed, 15 Jan 2025 13:09:22 -0500
X-MC-Unique: nKAgLcyNNKizJwX1h5Y4GQ-1
X-Mimecast-MFC-AGG-ID: nKAgLcyNNKizJwX1h5Y4GQ
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4359206e1e4so32469865e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:09:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964561; x=1737569361;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9o3c4LwUlk7AnTB7u8f2qn4E+H/wLdxNYk39uQ2dceI=;
 b=BBawEmDJDkeg6vTVvvOAcatwt1sHvbYFz4IQXo9VSWAzdrfBnn8jF3BvPwFVZiZPB+
 /WpEzsxlX6psSdCd95s9fXgQZ2QaKB9ngZgAde81ktziQFA4rFXSezwN3F0SfHsfoHp5
 mdUYH7fC57iGpVpnZ5BTL98axynhS5Grms8FhmUg7mU6H4ooPSVCv4s4vZHdXXYiVTzU
 ccH6FReOTrr+zzLRXEO4Nrw9GhN4WLYk+YoC72AIdy/U5gbdKGlpNFOWQy7+010L+df0
 0pBctSKlRKzwFF+8dGGifRtOwADFN/w51VdmhX55ZQa8fPobd5ecB/DF+7JzNZm+H6EY
 YbSg==
X-Gm-Message-State: AOJu0YyDxBI1VdwyBeIOD+5iy+hE02l2r/tKbZIKJreOkVFrqfK3DdbK
 V/GG/YWIfgYuFL1jNXcqvKdPpSLHuLpH/c3K6f9AgKXs5Zhl6Cdj6HWOBk2MiRsi4FDz61ea8Lr
 GciPP4htAGXPOBlRlyxVMAy1nHfgaFyjnq5+B2zK4SbGAr6XyzoV8xTUnDyRQb3H+k0FyU++5OE
 mLWKvf93Dbx2a75JjZB5h+I2f4nPaHWw==
X-Gm-Gg: ASbGncsaCwF9S6EYsm/c3Ln2qgZffMrQ0FwvSMTjbsw1yeka6w9+W8qwG9dWFadsLaI
 UTFN1t//WNURgM1WQsWQ0JvyvjBl0oMV+qSyMF6mZooVm/9bT1oxTzayKpxnVsD3QhE/VYGodi1
 pD6LM9ZBEzSDCATUk7KqBR/6omwJlAo4XWKqtXTYHS1T7kL41WMCzKw/jpHvihwkjbCAIJlz/O5
 1mPIIskfhv0iO+GMX+hsOcnGklNr7k7cBxjH1MkJtxR0yrx5AME
X-Received: by 2002:a05:6000:184e:b0:382:46ea:113f with SMTP id
 ffacd0b85a97d-38a872fc1b3mr29158937f8f.10.1736964560808; 
 Wed, 15 Jan 2025 10:09:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHC14EXULmcACxn9ulrF2zCZg2XFIRTLuCExnr1Q4wEzqZlbpCU02ARsB9t+SuZ7Tb/pQOMkw==
X-Received: by 2002:a05:6000:184e:b0:382:46ea:113f with SMTP id
 ffacd0b85a97d-38a872fc1b3mr29158899f8f.10.1736964560342; 
 Wed, 15 Jan 2025 10:09:20 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38c6dbsm18643752f8f.55.2025.01.15.10.09.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:09:19 -0800 (PST)
Date: Wed, 15 Jan 2025 13:09:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 16/48] intel_iommu: Process PASID-based iotlb invalidation
Message-ID: <6ebe6cf2a0663f46f94a69eca5296f608da12f2e.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

PASID-based iotlb (piotlb) is used during walking Intel
VT-d stage-1 page table.

This emulates the stage-1 page table iotlb invalidation requested
by a PASID-based IOTLB Invalidate Descriptor (P_IOTLB).

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Message-Id: <20241212083757.605022-12-zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu_internal.h |  3 +++
 hw/i386/intel_iommu.c          | 43 ++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 22dd3faf0c..5e4e563e62 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -471,6 +471,9 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_PIOTLB_PSI_IN_PASID  (3ULL << 4)
 #define VTD_INV_DESC_PIOTLB_DID(val)      (((val) >> 16) & VTD_DOMAIN_ID_MASK)
 #define VTD_INV_DESC_PIOTLB_PASID(val)    (((val) >> 32) & 0xfffffULL)
+#define VTD_INV_DESC_PIOTLB_AM(val)       ((val) & 0x3fULL)
+#define VTD_INV_DESC_PIOTLB_IH(val)       (((val) >> 6) & 0x1)
+#define VTD_INV_DESC_PIOTLB_ADDR(val)     ((val) & ~0xfffULL)
 #define VTD_INV_DESC_PIOTLB_RSVD_VAL0     0xfff000000000f1c0ULL
 #define VTD_INV_DESC_PIOTLB_RSVD_VAL1     0xf80ULL
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 95f344eb46..c45a486bf8 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -322,6 +322,28 @@ static gboolean vtd_hash_remove_by_page(gpointer key, gpointer value,
     return (entry->gfn & info->mask) == gfn || entry->gfn == gfn_tlb;
 }
 
+static gboolean vtd_hash_remove_by_page_piotlb(gpointer key, gpointer value,
+                                               gpointer user_data)
+{
+    VTDIOTLBEntry *entry = (VTDIOTLBEntry *)value;
+    VTDIOTLBPageInvInfo *info = (VTDIOTLBPageInvInfo *)user_data;
+    uint64_t gfn = (info->addr >> VTD_PAGE_SHIFT_4K) & info->mask;
+    uint64_t gfn_tlb = (info->addr & entry->mask) >> VTD_PAGE_SHIFT_4K;
+
+    /*
+     * According to spec, PASID-based-IOTLB Invalidation in page granularity
+     * doesn't invalidate IOTLB entries caching second-stage (PGTT=010b)
+     * or pass-through (PGTT=100b) mappings. Nested isn't supported yet,
+     * so only need to check first-stage (PGTT=001b) mappings.
+     */
+    if (entry->pgtt != VTD_SM_PASID_ENTRY_FLT) {
+        return false;
+    }
+
+    return entry->domain_id == info->domain_id && entry->pasid == info->pasid &&
+           ((entry->gfn & info->mask) == gfn || entry->gfn == gfn_tlb);
+}
+
 /* Reset all the gen of VTDAddressSpace to zero and set the gen of
  * IntelIOMMUState to 1.  Must be called with IOMMU lock held.
  */
@@ -2937,11 +2959,29 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
     }
 }
 
+static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
+                                       uint32_t pasid, hwaddr addr, uint8_t am)
+{
+    VTDIOTLBPageInvInfo info;
+
+    info.domain_id = domain_id;
+    info.pasid = pasid;
+    info.addr = addr;
+    info.mask = ~((1 << am) - 1);
+
+    vtd_iommu_lock(s);
+    g_hash_table_foreach_remove(s->iotlb,
+                                vtd_hash_remove_by_page_piotlb, &info);
+    vtd_iommu_unlock(s);
+}
+
 static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
                                     VTDInvDesc *inv_desc)
 {
     uint16_t domain_id;
     uint32_t pasid;
+    hwaddr addr;
+    uint8_t am;
     uint64_t mask[4] = {VTD_INV_DESC_PIOTLB_RSVD_VAL0,
                         VTD_INV_DESC_PIOTLB_RSVD_VAL1,
                         VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
@@ -2959,6 +2999,9 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
         break;
 
     case VTD_INV_DESC_PIOTLB_PSI_IN_PASID:
+        am = VTD_INV_DESC_PIOTLB_AM(inv_desc->val[1]);
+        addr = (hwaddr) VTD_INV_DESC_PIOTLB_ADDR(inv_desc->val[1]);
+        vtd_piotlb_page_invalidate(s, domain_id, pasid, addr, am);
         break;
 
     default:
-- 
MST


