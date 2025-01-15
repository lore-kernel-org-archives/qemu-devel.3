Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDE6C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7rH-0001mX-6f; Wed, 15 Jan 2025 13:11:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7pd-0006fA-IJ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:09:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7pb-0006eo-0t
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:09:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pePF8TiH1z30WiKUCjNM/Py5GVlpH/ceDZaRk5X9E4s=;
 b=K0Btoq5F/iANPJfIphZebXZNBD0Fq75IKgXPT5y6e7m35CUEWwqsKwjdiZGAPV9julw97M
 XoNDDAAz3JEpLklfQX3oHYRlpDzz1CpObl/vUAYHXia+pGnu5lDdmvR/kzz95rJZ07CiWD
 ceoXwmnlhqFIIL2MRsjP1HFOOUWamGw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-rRoAdMyGNS6EaCAKKOl3Tw-1; Wed, 15 Jan 2025 13:09:29 -0500
X-MC-Unique: rRoAdMyGNS6EaCAKKOl3Tw-1
X-Mimecast-MFC-AGG-ID: rRoAdMyGNS6EaCAKKOl3Tw
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-436328fcfeeso55951985e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:09:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964567; x=1737569367;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pePF8TiH1z30WiKUCjNM/Py5GVlpH/ceDZaRk5X9E4s=;
 b=wxJhXlGgQSwB/bNMivnRbE1kWKudeUvSZeN0U/wADgRkQQOAmrfGZ87ZKkqB9ejciT
 1Li0plGbUHA9lvQPGZ6oY0/qKd8eoXzTMdb1uXa8S6uKKjsmDciwZIxwQvNzhBIPmbYz
 p/WmK7R2UzV0mBgrYziwPuspEzgAkT7+QCQ5BjJmyw4ptR4xgCzJujnWOfwTIw4sWgbZ
 tXMd5OevMYQGlLjU1NO0gTaaz2+vE6hKg2s9wX/VNPm5+gumo0LKGUaskyzK68bpmz83
 mNRFe68jVLGuH0bpEAM3DN8sK83MOh+ZHYAImcB1CX5vEjvDeEzGxUTxOGHt/FlBMRJN
 tIhQ==
X-Gm-Message-State: AOJu0YynJvkPMr9iCU35i2oqHZQSajELQ0f7RVTiOw5vi1OXoe4qIIZS
 ynUN9hSeCO8l7IWDpuNHww+jfxCwY+E7BegMLoeq8eWFZSqqKahFRS0AO43IYaXL00TN4x7oWG8
 xd30gZxnUPqPtokTqF2prIU8F+P1gbl+uf/mOg6cCRrrU2P9iuv7PSZGHDtAGj346OerpwOuryS
 YRX/0zFUgq68c9hC7v1656zOc/f91Hsw==
X-Gm-Gg: ASbGncs310XbACvORbcAZQKofmhj2flaaZwVRab3sNi/PyU8mtLepkXY1OXFr9xECuP
 +Y3eRk0eK2JrWqc++9zPxeeNUkKuHPpbLky2q0REaCv53ry4gUbU+mh1mWC1bJBbsy588kTM/Jh
 svFjDJpOIFt7892vyInzaZU7ev3jpFdLzhj88dP8UXWvHBN5SAxf3f27acjQW+KqiBlxoZu6pLW
 bauyGsLZXIzjepejyjbwuk/7fWemz2yqTYVpa49QMaGzbFmxyuZ
X-Received: by 2002:a05:600c:4f47:b0:431:5632:448b with SMTP id
 5b1f17b1804b1-436e26e23f8mr237581105e9.25.1736964567611; 
 Wed, 15 Jan 2025 10:09:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGz1v6SRg9xAJi7VaJBfwK8A+M3bU6M0EI6TJnxHyI0EVp2VDPVBdEhbpLx5v8ss8phu19Qw==
X-Received: by 2002:a05:600c:4f47:b0:431:5632:448b with SMTP id
 5b1f17b1804b1-436e26e23f8mr237580775e9.25.1736964567153; 
 Wed, 15 Jan 2025 10:09:27 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e383965sm18559474f8f.31.2025.01.15.10.09.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:09:26 -0800 (PST)
Date: Wed, 15 Jan 2025 13:09:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 18/48] intel_iommu: Add support for PASID-based device IOTLB
 invalidation
Message-ID: <dd8200503e230a4e32f930f5a57556b04651c16f.1736964488.git.mst@redhat.com>
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

From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>

Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20241212083757.605022-14-zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu_internal.h | 11 ++++++++
 hw/i386/intel_iommu.c          | 50 ++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 5e4e563e62..2c977aa7da 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -385,6 +385,7 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_WAIT               0x5 /* Invalidation Wait Descriptor */
 #define VTD_INV_DESC_PIOTLB             0x6 /* PASID-IOTLB Invalidate Desc */
 #define VTD_INV_DESC_PC                 0x7 /* PASID-cache Invalidate Desc */
+#define VTD_INV_DESC_DEV_PIOTLB         0x8 /* PASID-based-DIOTLB inv_desc*/
 #define VTD_INV_DESC_NONE               0   /* Not an Invalidate Descriptor */
 
 /* Masks for Invalidation Wait Descriptor*/
@@ -426,6 +427,16 @@ typedef union VTDInvDesc VTDInvDesc;
 /* Masks for Interrupt Entry Invalidate Descriptor */
 #define VTD_INV_DESC_IEC_RSVD           0xffff000007fff1e0ULL
 
+/* Masks for PASID based Device IOTLB Invalidate Descriptor */
+#define VTD_INV_DESC_PASID_DEVICE_IOTLB_ADDR(val) ((val) & \
+                                                   0xfffffffffffff000ULL)
+#define VTD_INV_DESC_PASID_DEVICE_IOTLB_SIZE(val) ((val >> 11) & 0x1)
+#define VTD_INV_DESC_PASID_DEVICE_IOTLB_GLOBAL(val) ((val) & 0x1)
+#define VTD_INV_DESC_PASID_DEVICE_IOTLB_SID(val) (((val) >> 16) & 0xffffULL)
+#define VTD_INV_DESC_PASID_DEVICE_IOTLB_PASID(val) ((val >> 32) & 0xfffffULL)
+#define VTD_INV_DESC_PASID_DEVICE_IOTLB_RSVD_VAL0 0xfff000000000f000ULL
+#define VTD_INV_DESC_PASID_DEVICE_IOTLB_RSVD_VAL1 0x7feULL
+
 /* Rsvd field masks for spte */
 #define VTD_SPTE_SNP 0x800ULL
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 9aa807593e..5634a37a74 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3075,6 +3075,49 @@ static void do_invalidate_device_tlb(VTDAddressSpace *vtd_dev_as,
     memory_region_notify_iommu(&vtd_dev_as->iommu, 0, event);
 }
 
+static bool vtd_process_device_piotlb_desc(IntelIOMMUState *s,
+                                           VTDInvDesc *inv_desc)
+{
+    uint16_t sid;
+    VTDAddressSpace *vtd_dev_as;
+    bool size;
+    bool global;
+    hwaddr addr;
+    uint32_t pasid;
+    uint64_t mask[4] = {VTD_INV_DESC_PASID_DEVICE_IOTLB_RSVD_VAL0,
+                        VTD_INV_DESC_PASID_DEVICE_IOTLB_RSVD_VAL1,
+                        VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
+
+    if (!vtd_inv_desc_reserved_check(s, inv_desc, mask, true,
+                                     __func__, "device piotlb inv")) {
+        return false;
+    }
+
+    global = VTD_INV_DESC_PASID_DEVICE_IOTLB_GLOBAL(inv_desc->hi);
+    size = VTD_INV_DESC_PASID_DEVICE_IOTLB_SIZE(inv_desc->hi);
+    addr = VTD_INV_DESC_PASID_DEVICE_IOTLB_ADDR(inv_desc->hi);
+    sid = VTD_INV_DESC_PASID_DEVICE_IOTLB_SID(inv_desc->lo);
+    if (global) {
+        QLIST_FOREACH(vtd_dev_as, &s->vtd_as_with_notifiers, next) {
+            if ((vtd_dev_as->pasid != PCI_NO_PASID) &&
+                (PCI_BUILD_BDF(pci_bus_num(vtd_dev_as->bus),
+                                           vtd_dev_as->devfn) == sid)) {
+                do_invalidate_device_tlb(vtd_dev_as, size, addr);
+            }
+        }
+    } else {
+        pasid = VTD_INV_DESC_PASID_DEVICE_IOTLB_PASID(inv_desc->lo);
+        vtd_dev_as = vtd_get_as_by_sid_and_pasid(s, sid, pasid);
+        if (!vtd_dev_as) {
+            return true;
+        }
+
+        do_invalidate_device_tlb(vtd_dev_as, size, addr);
+    }
+
+    return true;
+}
+
 static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
                                           VTDInvDesc *inv_desc)
 {
@@ -3161,6 +3204,13 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
         }
         break;
 
+    case VTD_INV_DESC_DEV_PIOTLB:
+        trace_vtd_inv_desc("device-piotlb", inv_desc.hi, inv_desc.lo);
+        if (!vtd_process_device_piotlb_desc(s, &inv_desc)) {
+            return false;
+        }
+        break;
+
     case VTD_INV_DESC_DEVICE:
         trace_vtd_inv_desc("device", inv_desc.hi, inv_desc.lo);
         if (!vtd_process_device_iotlb_desc(s, &inv_desc)) {
-- 
MST


