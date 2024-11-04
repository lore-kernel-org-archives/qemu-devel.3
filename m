Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BFCD1BDF4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84LD-0004QM-6x; Mon, 04 Nov 2024 16:10:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Kk-0003NE-Nf
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:10:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Kg-0005Zk-T7
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:09:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dzFkROmFdJe52AC5ysZ9LBrP/VNzK7ogDHbPLODaOPM=;
 b=eA64CMmJCQfNxzUer8CjiUOBZ3uN3NJzjTMQyFIICfa3IDppQIrD4MUu6tDFDLNgMUao1T
 wZVXwg0E09r5JhWLJHztFuSM2eYJAnXyEi6qGGZMspqx/DAgcR27YcZtF12oDb+hHDwZus
 2m0AQU6AAbqLOGwxORcX2/mvLPYB5vo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-vxglU6KxOne1YRjEhih7Mw-1; Mon, 04 Nov 2024 16:09:51 -0500
X-MC-Unique: vxglU6KxOne1YRjEhih7Mw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d4922d8c7so2475376f8f.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:09:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754589; x=1731359389;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dzFkROmFdJe52AC5ysZ9LBrP/VNzK7ogDHbPLODaOPM=;
 b=s52hXqU7neo4mS9cmhYY6e3zZFA8Fcqrj7M6DtDHv+gufqfKXO54AAHk0vJSiRD4QQ
 My+omcRELVxJfr1mRJmh80IrUvHWwiiTtv4xxCJjL83AieLSnoWf+0/0vkX6uMuObPY5
 WjfukpAfgouCIOPq/1SEPp3aGk4uIPoJUvYqFZs6SjgX/IzdzyOVM3XBAcC8NAY4+zWq
 xuHW/J8hTtv3vJ70iuJ65BuKxSNAtnG7/roYBgy9dLAUqM7KkKof9Jk4VpD42x+I5syg
 Uj3KpjPK6zqXJGsgFQe5CWe28mGPGviGxOD33KwnwNioJttzpFki3iuM+byoaVpc9jtG
 5a7w==
X-Gm-Message-State: AOJu0Yw25KgjQecEKUSh0zdKvT+zWtly7jhP3q8uhnQxN8e8l9Fesimk
 P5P1oM6XVSmHk8e9xl0sMDJRbufep1caTKCopohP/zTglGF+QQf9czincsCEcbSbFOBy/c0emM/
 zlHwSVRoNIHRS6mgd5RH2OmKkVm92KLxjwWMdYhL9jszVEWYEoNept0lqEqciF+q4OBV1h1A/6M
 ygrcBSrjcfQq4xR2Mz1zX33enCGnBmdw==
X-Received: by 2002:a05:6000:4817:b0:37d:4fe9:b6a4 with SMTP id
 ffacd0b85a97d-381c7ab30a6mr11627752f8f.50.1730754588873; 
 Mon, 04 Nov 2024 13:09:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGE6a+VqcVsRwGLmx5QyvOv9zLiKNfSd7LMWbLEfrC1IWoBqXwZajSOHNqqSb20Jnmc0kpdfA==
X-Received: by 2002:a05:6000:4817:b0:37d:4fe9:b6a4 with SMTP id
 ffacd0b85a97d-381c7ab30a6mr11627733f8f.50.1730754588503; 
 Mon, 04 Nov 2024 13:09:48 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5ab305sm165233995e9.7.2024.11.04.13.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:09:48 -0800 (PST)
Date: Mon, 4 Nov 2024 16:09:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, Jason Wang <jasowang@redhat.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 64/65] intel_iommu: Add missed sanity check for 256-bit
 invalidation queue
Message-ID: <8e761fb61cafa95f4f41acaf8e86fae7e898b555.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

According to VTD spec, a 256-bit descriptor will result in an invalid
descriptor error if submitted in an IQ that is setup to provide hardware
with 128-bit descriptors (IQA_REG.DW=0). Meanwhile, there are old inv desc
types (e.g. iotlb_inv_desc) that can be either 128bits or 256bits. If a
128-bit version of this descriptor is submitted into an IQ that is setup
to provide hardware with 256-bit descriptors will also result in an invalid
descriptor error.

The 2nd will be captured by the tail register update. So we only need to
focus on the 1st.

Because the reserved bit check between different types of invalidation desc
are common, so introduce a common function vtd_inv_desc_reserved_check()
to do all the checks and pass the differences as parameters.

With this change, need to replace error_report_once() call with error_report()
to catch different call sites. This isn't an issue as error_report_once()
here is mainly used to help debug guest error, but it only dumps once in
qemu life cycle and doesn't help much, we need error_report() instead.

Fixes: c0c1d351849b ("intel_iommu: add 256 bits qi_desc support")
Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Message-Id: <20241104125536.1236118-3-zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu_internal.h |  1 +
 hw/i386/intel_iommu.c          | 80 ++++++++++++++++++++++++----------
 2 files changed, 59 insertions(+), 22 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 2f9bc0147d..75ccd501b0 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -356,6 +356,7 @@ union VTDInvDesc {
 typedef union VTDInvDesc VTDInvDesc;
 
 /* Masks for struct VTDInvDesc */
+#define VTD_INV_DESC_ALL_ONE            -1ULL
 #define VTD_INV_DESC_TYPE(val)          ((((val) >> 5) & 0x70ULL) | \
                                          ((val) & 0xfULL))
 #define VTD_INV_DESC_CC                 0x1 /* Context-cache Invalidate Desc */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 1ecfe47963..2fc3866433 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2532,15 +2532,51 @@ static bool vtd_get_inv_desc(IntelIOMMUState *s,
     return true;
 }
 
+static bool vtd_inv_desc_reserved_check(IntelIOMMUState *s,
+                                        VTDInvDesc *inv_desc,
+                                        uint64_t mask[4], bool dw,
+                                        const char *func_name,
+                                        const char *desc_type)
+{
+    if (s->iq_dw) {
+        if (inv_desc->val[0] & mask[0] || inv_desc->val[1] & mask[1] ||
+            inv_desc->val[2] & mask[2] || inv_desc->val[3] & mask[3]) {
+            error_report("%s: invalid %s desc val[3]: 0x%"PRIx64
+                         " val[2]: 0x%"PRIx64" val[1]=0x%"PRIx64
+                         " val[0]=0x%"PRIx64" (reserved nonzero)",
+                         func_name, desc_type, inv_desc->val[3],
+                         inv_desc->val[2], inv_desc->val[1],
+                         inv_desc->val[0]);
+            return false;
+        }
+    } else {
+        if (dw) {
+            error_report("%s: 256-bit %s desc in 128-bit invalidation queue",
+                         func_name, desc_type);
+            return false;
+        }
+
+        if (inv_desc->lo & mask[0] || inv_desc->hi & mask[1]) {
+            error_report("%s: invalid %s desc: hi=%"PRIx64", lo=%"PRIx64
+                         " (reserved nonzero)", func_name, desc_type,
+                         inv_desc->hi, inv_desc->lo);
+            return false;
+        }
+    }
+
+    return true;
+}
+
 static bool vtd_process_wait_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
 {
-    if ((inv_desc->hi & VTD_INV_DESC_WAIT_RSVD_HI) ||
-        (inv_desc->lo & VTD_INV_DESC_WAIT_RSVD_LO)) {
-        error_report_once("%s: invalid wait desc: hi=%"PRIx64", lo=%"PRIx64
-                          " (reserved nonzero)", __func__, inv_desc->hi,
-                          inv_desc->lo);
+    uint64_t mask[4] = {VTD_INV_DESC_WAIT_RSVD_LO, VTD_INV_DESC_WAIT_RSVD_HI,
+                        VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
+
+    if (!vtd_inv_desc_reserved_check(s, inv_desc, mask, false,
+                                     __func__, "wait")) {
         return false;
     }
+
     if (inv_desc->lo & VTD_INV_DESC_WAIT_SW) {
         /* Status Write */
         uint32_t status_data = (uint32_t)(inv_desc->lo >>
@@ -2574,13 +2610,14 @@ static bool vtd_process_context_cache_desc(IntelIOMMUState *s,
                                            VTDInvDesc *inv_desc)
 {
     uint16_t sid, fmask;
+    uint64_t mask[4] = {VTD_INV_DESC_CC_RSVD, VTD_INV_DESC_ALL_ONE,
+                        VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
 
-    if ((inv_desc->lo & VTD_INV_DESC_CC_RSVD) || inv_desc->hi) {
-        error_report_once("%s: invalid cc inv desc: hi=%"PRIx64", lo=%"PRIx64
-                          " (reserved nonzero)", __func__, inv_desc->hi,
-                          inv_desc->lo);
+    if (!vtd_inv_desc_reserved_check(s, inv_desc, mask, false,
+                                     __func__, "cc inv")) {
         return false;
     }
+
     switch (inv_desc->lo & VTD_INV_DESC_CC_G) {
     case VTD_INV_DESC_CC_DOMAIN:
         trace_vtd_inv_desc_cc_domain(
@@ -2610,12 +2647,11 @@ static bool vtd_process_iotlb_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
     uint16_t domain_id;
     uint8_t am;
     hwaddr addr;
+    uint64_t mask[4] = {VTD_INV_DESC_IOTLB_RSVD_LO, VTD_INV_DESC_IOTLB_RSVD_HI,
+                        VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
 
-    if ((inv_desc->lo & VTD_INV_DESC_IOTLB_RSVD_LO) ||
-        (inv_desc->hi & VTD_INV_DESC_IOTLB_RSVD_HI)) {
-        error_report_once("%s: invalid iotlb inv desc: hi=0x%"PRIx64
-                          ", lo=0x%"PRIx64" (reserved bits unzero)",
-                          __func__, inv_desc->hi, inv_desc->lo);
+    if (!vtd_inv_desc_reserved_check(s, inv_desc, mask, false,
+                                     __func__, "iotlb inv")) {
         return false;
     }
 
@@ -2705,19 +2741,19 @@ static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
     hwaddr addr;
     uint16_t sid;
     bool size;
+    uint64_t mask[4] = {VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO,
+                        VTD_INV_DESC_DEVICE_IOTLB_RSVD_HI,
+                        VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
+
+    if (!vtd_inv_desc_reserved_check(s, inv_desc, mask, false,
+                                     __func__, "dev-iotlb inv")) {
+        return false;
+    }
 
     addr = VTD_INV_DESC_DEVICE_IOTLB_ADDR(inv_desc->hi);
     sid = VTD_INV_DESC_DEVICE_IOTLB_SID(inv_desc->lo);
     size = VTD_INV_DESC_DEVICE_IOTLB_SIZE(inv_desc->hi);
 
-    if ((inv_desc->lo & VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO) ||
-        (inv_desc->hi & VTD_INV_DESC_DEVICE_IOTLB_RSVD_HI)) {
-        error_report_once("%s: invalid dev-iotlb inv desc: hi=%"PRIx64
-                          ", lo=%"PRIx64" (reserved nonzero)", __func__,
-                          inv_desc->hi, inv_desc->lo);
-        return false;
-    }
-
     /*
      * Using sid is OK since the guest should have finished the
      * initialization of both the bus and device.
-- 
MST


