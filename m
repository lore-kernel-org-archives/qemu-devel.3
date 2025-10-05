Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9C7CCA472
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UFB-0000t5-3o; Sun, 05 Oct 2025 15:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEl-000090-48
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UEj-0006Wt-Ak
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u2jYeKWljJsB48uGOgCkPK+8PjN3Wtr/wWTKXDzpU98=;
 b=Mla1nz9Htn7fF5UmdFoAEjnW7WMJSXIaGxAgI+m4TblhdC5NCgbPYDkTJDnh8WxCXpq+3n
 KrNvubmGBTkWV/ZBNAs8ZE00O5JfuxM2XauIFg6Qo8FXABGjUlvgP0hPo5YFII3OT8BL4R
 ytAqrKo65dOVbCJFK+IhB6k1Qr5S0eM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-GsVZPDbvMeGZcOGS7Ldcpw-1; Sun, 05 Oct 2025 15:17:33 -0400
X-MC-Unique: GsVZPDbvMeGZcOGS7Ldcpw-1
X-Mimecast-MFC-AGG-ID: GsVZPDbvMeGZcOGS7Ldcpw_1759691852
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3f030846a41so2461426f8f.2
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691852; x=1760296652;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u2jYeKWljJsB48uGOgCkPK+8PjN3Wtr/wWTKXDzpU98=;
 b=tN/zNiARdwB+nUfvr3HDFSJtqvSxunZq/joq2HblvAEOf7Nd6TSsuTatQwkhaElA2f
 GCJeQSO0f7Lz1y+teK2HGUWhEw1xiK3Z0L8e9WgcbPql6kiOZ/gdSR4cGdT0XaIN6aQs
 yCwm7USOEKTjIVJCK00Evp37qv7Jd+4NbmW6pHWe/XtkRc9hiWjBO0TAdKdBiDaa2EGA
 9QqEVvqVhsjdzgacDiy8iXI6vgK+qdkFPpx5aoBpCbgB10TiO7uHSNt4QZ8AO5z/InkW
 4N+dIqkXh1nStznvwBvon9yWH0Q/EWQHSdGEJx250VkDr7g8Xfx50GAch0sFMNwlAi1Z
 e3fA==
X-Gm-Message-State: AOJu0YzUTrKpUIf/9VHECzk0ORuO7/A8IqMQFTCxMQt6vMqxWjwR3R4H
 Hy8H6yDCFnn9Q/rGuXE/rbwYgS4oItgd1Zd3HuPJBGDff0Jq1n730XHu7VAfiVRWiruYGb4SuFS
 XwuvlDhUmxC1OXe8xAHEUaYvAAoE3RdR37Y2KmHajYfSCU14GrPeq9mn54TckdrksQ1slRrWSLH
 UrJ6u9tvEB2Fps0xp4WaW31JBtEoR6JhldJw==
X-Gm-Gg: ASbGncsnWFSlAt9Ghs04jiR20p436saywMdqxtjVrsbTg2UZAp8Ie2C6JE7rH8s+6RA
 NfY7alB35Nq4Lv1Ctki1DbBvAyg7ke6WRquFihbcAOlecKTm1BADDXc7c+kef3muOPNmM1PnxRA
 aRVb9w1QfP6nJiXLHmMVBqea9FJiqMMPdppZr5O+O+3EO03LclWCc+q10R19/jQp3jFg3hXvgpk
 tBt4Nn7DejTMEgpIdmrZvQt0yRhlS09TElOvp6qSdSEI9jV2S84kL75U56pySJ4P3Hc09wlZMcV
 LsCG6xI5pQhGX+KfYlmqEewM7lIfV7b40cM1MRY=
X-Received: by 2002:a05:600c:354f:b0:45b:868e:7f7f with SMTP id
 5b1f17b1804b1-46e711640e1mr80744855e9.17.1759691851886; 
 Sun, 05 Oct 2025 12:17:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuTQKS+MaJPeSfqQqdkX41c2QDNE+YwNQJeMbK9ztQlLBQiNCSMn+pImwr9wOwWYLX2aVhaA==
X-Received: by 2002:a05:600c:354f:b0:45b:868e:7f7f with SMTP id
 5b1f17b1804b1-46e711640e1mr80744605e9.17.1759691851398; 
 Sun, 05 Oct 2025 12:17:31 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e675c67f7sm96952125e9.2.2025.10.05.12.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:17:30 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:17:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 39/75] intel_iommu: Declare PRI constants and structures
Message-ID: <fadc6b0402b6e3edc941b638dfca11789d07d730.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250901111630.1018573-4-clement.mathieu--drif@eviden.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu_internal.h | 49 ++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 360e937989..04a8d4c769 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -190,6 +190,7 @@
 #define VTD_ECAP_EIM                (1ULL << 4)
 #define VTD_ECAP_PT                 (1ULL << 6)
 #define VTD_ECAP_SC                 (1ULL << 7)
+#define VTD_ECAP_PRS                (1ULL << 29)
 #define VTD_ECAP_MHMV               (15ULL << 20)
 #define VTD_ECAP_SRS                (1ULL << 31)
 #define VTD_ECAP_PSS                (7ULL << 35) /* limit: MemTxAttrs::pid */
@@ -376,6 +377,18 @@ union VTDInvDesc {
 };
 typedef union VTDInvDesc VTDInvDesc;
 
+/* Page Request Descriptor */
+union VTDPRDesc {
+    struct {
+        uint64_t lo;
+        uint64_t hi;
+    };
+    struct {
+        uint64_t val[4];
+    };
+};
+typedef union VTDPRDesc VTDPRDesc;
+
 /* Masks for struct VTDInvDesc */
 #define VTD_INV_DESC_ALL_ONE            -1ULL
 #define VTD_INV_DESC_TYPE(val)          ((((val) >> 5) & 0x70ULL) | \
@@ -389,6 +402,7 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_PIOTLB             0x6 /* PASID-IOTLB Invalidate Desc */
 #define VTD_INV_DESC_PC                 0x7 /* PASID-cache Invalidate Desc */
 #define VTD_INV_DESC_DEV_PIOTLB         0x8 /* PASID-based-DIOTLB inv_desc*/
+#define VTD_INV_DESC_PGRESP             0x9 /* Page Group Response Desc */
 #define VTD_INV_DESC_NONE               0   /* Not an Invalidate Descriptor */
 
 /* Masks for Invalidation Wait Descriptor*/
@@ -440,6 +454,15 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_PASID_DEVICE_IOTLB_RSVD_VAL0 0xfff000000000f000ULL
 #define VTD_INV_DESC_PASID_DEVICE_IOTLB_RSVD_VAL1 0x7feULL
 
+/* Mask for Page Group Response Descriptor */
+#define VTD_INV_DESC_PGRESP_RSVD_HI             0xfffffffffffff003ULL
+#define VTD_INV_DESC_PGRESP_RSVD_LO             0xfff00000000001e0ULL
+#define VTD_INV_DESC_PGRESP_PP(val)             (((val) >> 4) & 0x1ULL)
+#define VTD_INV_DESC_PGRESP_RC(val)             (((val) >> 12) & 0xfULL)
+#define VTD_INV_DESC_PGRESP_RID(val)            (((val) >> 16) & 0xffffULL)
+#define VTD_INV_DESC_PGRESP_PASID(val)          (((val) >> 32) & 0xfffffULL)
+#define VTD_INV_DESC_PGRESP_PRGI(val)           (((val) >> 3) & 0x1ffULL)
+
 /* Rsvd field masks for spte */
 #define VTD_SPTE_SNP 0x800ULL
 
@@ -491,6 +514,31 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_PIOTLB_RSVD_VAL0     0xfff000000000f1c0ULL
 #define VTD_INV_DESC_PIOTLB_RSVD_VAL1     0xf80ULL
 
+/* Page Request Descriptor */
+/* For the low 64-bit of 128-bit */
+#define VTD_PRD_TYPE            (1ULL)
+#define VTD_PRD_PP(val)         (((val) & 1ULL) << 8)
+#define VTD_PRD_RID(val)        (((val) & 0xffffULL) << 16)
+#define VTD_PRD_PASID(val)      (((val) & 0xfffffULL) << 32)
+#define VTD_PRD_EXR(val)        (((val) & 1ULL) << 52)
+#define VTD_PRD_PMR(val)        (((val) & 1ULL) << 53)
+/* For the high 64-bit of 128-bit */
+#define VTD_PRD_RDR(val)        ((val) & 1ULL)
+#define VTD_PRD_WRR(val)        (((val) & 1ULL) << 1)
+#define VTD_PRD_LPIG(val)       (((val) & 1ULL) << 2)
+#define VTD_PRD_PRGI(val)       (((val) & 0x1ffULL) << 3)
+#define VTD_PRD_ADDR(val)       ((val) & 0xfffffffffffff000ULL)
+
+/* Page Request Queue constants */
+#define VTD_PQA_ENTRY_SIZE      32 /* Size of an entry in bytes */
+/* Page Request Queue masks */
+#define VTD_PQA_ADDR            0xfffffffffffff000ULL /* PR queue address */
+#define VTD_PQA_SIZE            0x7ULL /* PR queue size */
+#define VTD_PR_STATUS_PPR       1UL /* Pending page request */
+#define VTD_PR_STATUS_PRO       2UL /* Page request overflow */
+#define VTD_PR_PECTL_IP         0x40000000UL /* PR control interrup pending */
+#define VTD_PR_PECTL_IM         0x80000000UL /* PR control interrup mask */
+
 /* Information about page-selective IOTLB invalidate */
 struct VTDIOTLBPageInvInfo {
     uint16_t domain_id;
@@ -550,6 +598,7 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_SM_CONTEXT_ENTRY_RID2PASID_MASK 0xfffff
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
 #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
+#define VTD_SM_CONTEXT_ENTRY_PRE            0x10ULL
 
 /* PASID Table Related Definitions */
 #define VTD_PASID_DIR_BASE_ADDR_MASK  (~0xfffULL)
-- 
MST


