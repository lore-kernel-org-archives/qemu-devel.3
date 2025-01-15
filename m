Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2122EC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:19:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7qv-0008Su-Ih; Wed, 15 Jan 2025 13:10:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7pi-0006gx-Tg
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:09:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7ph-0006f7-2P
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:09:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M8anF+JBkvRI7NWpt9ZB3PcYSjQ6xOt/WhSnYtqwjRU=;
 b=OvAn2wW44+CHehlPz0U4kQYqbC7NPAHhsNdKOPQHTM7J3IL+ljr2ELGewo5niBr9y7uDbm
 VnrFBVLbtBTPR/mMl5myRrF5MMa+NXWxFck3thIwErPSIr25AtFS3HJqwoxnTR0Xiszwir
 2vWlP7gb9teY86jdDgoTpU4dtYpyJ58=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-Gfv0CHGyP96LbOmgPawzIA-1; Wed, 15 Jan 2025 13:09:32 -0500
X-MC-Unique: Gfv0CHGyP96LbOmgPawzIA-1
X-Mimecast-MFC-AGG-ID: Gfv0CHGyP96LbOmgPawzIA
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-385dcae001fso50847f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:09:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964571; x=1737569371;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M8anF+JBkvRI7NWpt9ZB3PcYSjQ6xOt/WhSnYtqwjRU=;
 b=jA2VtaSNalM2MHC7gm1GEHZtIJVL5ZQWkE06GHWdzzePVsOhSXLHaNUPvTaEY3oKFT
 R1pskmKBbc+7Yary2ynqvDmGuts7CF8++DxWTHlHTexAZnYrzlzv/XWOFni9MUokxsh5
 hwXkAOLS6dM7Iu3OaWH6aGJr8sP6/JpKNrcKfnl+yCNEXmHbpzMj/5S7UeYCxMF/8M5Q
 yEcIgkDA5zbE+0MRVWdTNsq155gFcWhGTNuJ+CJ5935lZq+Ovx9tL9XXiBHaDXbsn5QQ
 wBVt6FPkxvWiQWA7jC1hM1meofUI10NbpSh9lP7QUltJTPaztO3cs4bg3J0PNACnN8hl
 1rKQ==
X-Gm-Message-State: AOJu0YzTmawXA1VOAdEgAhNJRoieaWf+a99t66IzEtvl0U/v7IdU/rFE
 tDFujmApudH+Ffon09sngoI78We8oJn8PpzMeomOxr4Rj16jqBe4SzJRVlsPCElmDfwkmAdg7fQ
 kOJ321wRYndIuyNvXF5Fm18RJIz4DpEozQB2Jz/fKSZt8BYjSXIsgN0cNN5D9KZbkxqBXeCNFxj
 WwFqALb4EjhfZaUo+qu6+ADTaB76kDfQ==
X-Gm-Gg: ASbGncuGjofmA86FhL5Tv3nJN931F46oNT3BlqpPFtEpr7XITLfLwKu7t7ufkBce5kj
 /7juKqzj9jl/WpPB2H6o4xTW4EgJmxgMMDgW0nl9JQLUylYNdazI46rbOBjSZl8T+NibEuccxKH
 NR3GyUqMHnfSh01ILgZ0tyWt9E8FvZVc90fu4FopdPk94jAfsXU/f+DFc2FYTWqPJbA8vo2cZji
 Tfu18+UzcbMq78E67YKtXB/ha/JO2hIwCvmwuZbvdmuFSdbpHjZ
X-Received: by 2002:a05:6000:719:b0:385:e879:45cc with SMTP id
 ffacd0b85a97d-38a873045d9mr22945671f8f.19.1736964571023; 
 Wed, 15 Jan 2025 10:09:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHovRL8dIO/+V4asAAqk6tHDbt90Ce9O2yWR/y35xnfF1N287i34IvK9i/2DCbNDB58NazpfA==
X-Received: by 2002:a05:6000:719:b0:385:e879:45cc with SMTP id
 ffacd0b85a97d-38a873045d9mr22945645f8f.19.1736964570594; 
 Wed, 15 Jan 2025 10:09:30 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c73e370fsm32124105e9.0.2025.01.15.10.09.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:09:29 -0800 (PST)
Date: Wed, 15 Jan 2025 13:09:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, Jason Wang <jasowang@redhat.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 19/48] intel_iommu: piotlb invalidation should notify unmap
Message-ID: <1ab93575bdcb2972c99a174a957b598f7457a899.1736964488.git.mst@redhat.com>
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

This is used by some emulated devices which caches address
translation result. When piotlb invalidation issued in guest,
those caches should be refreshed.

There is already a similar implementation in iotlb invalidation.
So update vtd_iotlb_page_invalidate_notify() to make it work
also for piotlb invalidation.

For device that does not implement ATS capability or disable
it but still caches the translation result, it is better to
implement ATS cap or enable it if there is need to cache the
translation result.

Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
Message-Id: <20241212083757.605022-15-zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 43 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 5634a37a74..7d4b99523d 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2450,8 +2450,13 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
     }
 }
 
+/*
+ * There is no pasid field in iotlb invalidation descriptor, so PCI_NO_PASID
+ * is passed as parameter. Piotlb invalidation supports pasid, pasid in its
+ * descriptor is passed which should not be PCI_NO_PASID.
+ */
 static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
-                                           uint16_t domain_id, hwaddr addr,
+                                             uint16_t domain_id, hwaddr addr,
                                              uint8_t am, uint32_t pasid)
 {
     VTDAddressSpace *vtd_as;
@@ -2460,19 +2465,37 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
     hwaddr size = (1 << am) * VTD_PAGE_SIZE;
 
     QLIST_FOREACH(vtd_as, &(s->vtd_as_with_notifiers), next) {
-        if (pasid != PCI_NO_PASID && pasid != vtd_as->pasid) {
-            continue;
-        }
         ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
                                        vtd_as->devfn, &ce);
         if (!ret && domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
+            uint32_t rid2pasid = PCI_NO_PASID;
+
+            if (s->root_scalable) {
+                rid2pasid = VTD_CE_GET_RID2PASID(&ce);
+            }
+
+            /*
+             * In legacy mode, vtd_as->pasid == pasid is always true.
+             * In scalable mode, for vtd address space backing a PCI
+             * device without pasid, needs to compare pasid with
+             * rid2pasid of this device.
+             */
+            if (!(vtd_as->pasid == pasid ||
+                  (vtd_as->pasid == PCI_NO_PASID && pasid == rid2pasid))) {
+                continue;
+            }
+
             if (vtd_as_has_map_notifier(vtd_as)) {
                 /*
-                 * As long as we have MAP notifications registered in
-                 * any of our IOMMU notifiers, we need to sync the
-                 * shadow page table.
+                 * When stage-1 translation is off, as long as we have MAP
+                 * notifications registered in any of our IOMMU notifiers,
+                 * we need to sync the shadow page table. Otherwise VFIO
+                 * device attaches to nested page table instead of shadow
+                 * page table, so no need to sync.
                  */
-                vtd_sync_shadow_page_table_range(vtd_as, &ce, addr, size);
+                if (!s->flts || !s->root_scalable) {
+                    vtd_sync_shadow_page_table_range(vtd_as, &ce, addr, size);
+                }
             } else {
                 /*
                  * For UNMAP-only notifiers, we don't need to walk the
@@ -2960,7 +2983,7 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
                 continue;
             }
 
-            if (!s->flts) {
+            if (!s->flts || !vtd_as_has_map_notifier(vtd_as)) {
                 vtd_address_space_sync(vtd_as);
             }
         }
@@ -2981,6 +3004,8 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
     g_hash_table_foreach_remove(s->iotlb,
                                 vtd_hash_remove_by_page_piotlb, &info);
     vtd_iommu_unlock(s);
+
+    vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am, pasid);
 }
 
 static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
-- 
MST


