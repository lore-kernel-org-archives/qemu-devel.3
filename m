Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F738EA7944
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniAa-0000PH-5r; Wed, 04 Feb 2026 14:04:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniA9-0007BY-3L
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniA7-0007pW-Dt
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ft9lkVidKGvDWSkbSEDf12J/y4bCfw+ORVztPvg4jUA=;
 b=aTm9pgl/dExNZ94M0moSkHUMG6LLhojHERDM1RaqYkGBIE27az2ymzQgMOqPssd5lABCTZ
 14dxUHAjNUagv/KDSv7E7/v1ZoRceKcSbCnjYCCWzWWuT62boXR1/niNhRAJF4NazQDxdV
 8yzjvF5mIEYUEuVdF8gqgDpFf4aWSXY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-rUuqJNpXNYOGNONVnW7IrQ-1; Wed, 04 Feb 2026 14:03:35 -0500
X-MC-Unique: rUuqJNpXNYOGNONVnW7IrQ-1
X-Mimecast-MFC-AGG-ID: rUuqJNpXNYOGNONVnW7IrQ_1770231814
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4806fce5ab1so751745e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231814; x=1770836614; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ft9lkVidKGvDWSkbSEDf12J/y4bCfw+ORVztPvg4jUA=;
 b=UdYmPeVv6XpbSvqb2g5ywA7lDDsl3zin/Pzwxz+Bwbt5YTHxyHIpxOD3VzyIGeGn7b
 EtaQIX8H36g1kZsEzeOwU2OM2pC6UGHwNCczUOJdN/GFb2opW7dMH7KwlBybR/MWp+rQ
 G+JOcjDLGHn8fqkNCARs88qe4xz8tG5Q+oIHOaeTeU/g/9cb7YtBSVMKEO5DYWHwOZ0k
 3fLE5Xn6PatdSJDOBJItktgwm4mtcTN/3NkWxOpfUuQWJDECnPREyHS2yre2XkXf0y1y
 xrNqckZ6hABXDOMYkVL0G/77Y4UVyX6nV2UKmeLKeaMckpJ4eNx1TS3c65Gb0vgSwDh2
 GQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231814; x=1770836614;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ft9lkVidKGvDWSkbSEDf12J/y4bCfw+ORVztPvg4jUA=;
 b=pY4a5LWCg03+YFfQGJlNWPNZy8R1rNLrV3uLxZPEBv/Weu90uFfTl5HhX9yeN4e7ve
 Qocr81PL6t/7ChQv6cKJ0G4yMhykhRBTyfj9ldfs/f04i3ixY16pGD0tZ5DuRbFgNQAs
 /T1ag2+1zfTqR7QZaEI0nrs+p55ZPNjK8dWDprERHuA6j07hF1rydvYhMSqGdz2YHUiG
 qNEbCjT4sp2aIvZBx825yrspJMRJ1f5SBn1zy7yufMUSwbfJzXfr9CUakTMtPeM1KbJg
 iWHeyc22aL6jeQaVZnIl/7fYEZPRlgUIkjZkWewcUVrO3fZ+n/Zccx6CzuohKK+g/aEZ
 Xmgw==
X-Gm-Message-State: AOJu0Yy/QwcLxZ8XHwPEO3ahmxjD/WZ6CZMkv1E/JNFE00yXYHw48b6A
 qxpSYGWxG9Xj1s1hq72MceOcKojEEejT0MbsdySY5ctUAiXwEA+sxH0E9Ix0jE8aathoe1P7wga
 ta4DiU6K/s5S6etdFvUq1+3mGWHltIBGEt8PQQmllmmf08o1ffE9mh9T/dVX6hg3G1FqlHqasZH
 DodTEqT3PyQ3G+sn1/dp/X/jKVa2nfAtosSw==
X-Gm-Gg: AZuq6aK5C8mWbucEexKISQQ3o4VVBdyRV7ckmbteTj7IYvJFpVSrXc0i5kzfwR8VGIc
 DrFb4+4dZ6b7hq4shvjcyIm2Jgyow+BiXxPbOX6yKNQFa8WTZwMqw854WarcVoM/o8Jc21BKHD9
 scSuoTcWAZW1EJ8MIur/QzVYdQ3kFzSJKgmy9Z+8P9c4zaUEWgxxu1zAniwpxFms0EDSXKq7OVB
 fFdOKpD7CY3Vl3GZ7hRFNmTTYAhtPymgGgX1Euja98olj41nMEATluar528tFYHWt6DtO5mCHZp
 jnIKGx25G1Br27HkOVrGnaQyREKum6QCmVBmxe+4vhZTwm+6k8crhjKPqJ3NZpyUPC5Bkl1C/ZF
 D2g4ASRCV6PA/ibrehea2+3cvJ25/CQpqQA==
X-Received: by 2002:a05:600c:3143:b0:477:a978:3a7b with SMTP id
 5b1f17b1804b1-4830e987c76mr61833085e9.22.1770231813582; 
 Wed, 04 Feb 2026 11:03:33 -0800 (PST)
X-Received: by 2002:a05:600c:3143:b0:477:a978:3a7b with SMTP id
 5b1f17b1804b1-4830e987c76mr61832445e9.22.1770231813133; 
 Wed, 04 Feb 2026 11:03:33 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e38ec5sm9088230f8f.14.2026.02.04.11.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:03:32 -0800 (PST)
Date: Wed, 4 Feb 2026 14:03:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 18/51] intel_iommu: Add a CLI option to enable SVM
Message-ID: <e7757cdd660878b5f08bf89cbefb509b8cc2586d.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20251029105137.1097933-8-clement.mathieu--drif@eviden.com>
---
 hw/i386/intel_iommu.c          | 45 ++++++++++++++++++++++++----------
 hw/i386/intel_iommu_internal.h |  6 ++++-
 include/hw/i386/intel_iommu.h  |  1 +
 3 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 77adeed0cc..dd00079a40 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2862,8 +2862,10 @@ static bool vtd_inv_desc_reserved_check(IntelIOMMUState *s,
 
 static bool vtd_process_wait_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
 {
-    uint64_t mask[4] = {VTD_INV_DESC_WAIT_RSVD_LO, VTD_INV_DESC_WAIT_RSVD_HI,
-                        VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
+    uint64_t mask[4] = {
+        VTD_INV_DESC_WAIT_RSVD_LO(s->ecap), VTD_INV_DESC_WAIT_RSVD_HI,
+        VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE
+    };
     bool ret = true;
 
     if (!vtd_inv_desc_reserved_check(s, inv_desc, mask, false,
@@ -4186,6 +4188,7 @@ static const Property vtd_properties[] = {
     DEFINE_PROP_BOOL("x-flts", IntelIOMMUState, fsts, FALSE),
     DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, false),
     DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
+    DEFINE_PROP_BOOL("svm", IntelIOMMUState, svm, false),
     DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
     DEFINE_PROP_BOOL("stale-tm", IntelIOMMUState, stale_tm, false),
     DEFINE_PROP_BOOL("fs1gp", IntelIOMMUState, fs1gp, true),
@@ -5096,6 +5099,10 @@ static void vtd_init(IntelIOMMUState *s)
         vtd_spte_rsvd_large[3] &= ~VTD_SPTE_SNP;
     }
 
+    if (s->svm) {
+        s->ecap |= VTD_ECAP_PRS | VTD_ECAP_PDS | VTD_ECAP_NWFS;
+    }
+
     vtd_reset_caches(s);
 
     /* Define registers with default values and bit semantics */
@@ -5573,6 +5580,29 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
         return false;
     }
 
+    if (s->svm) {
+        if (!x86_iommu->dt_supported) {
+            error_setg(errp, "Need to set device IOTLB for svm");
+            return false;
+        }
+
+        if (!s->fsts) {
+            error_setg(errp, "Need to set flts for svm");
+            return false;
+        }
+
+        if (!x86_iommu->dma_translation) {
+            error_setg(errp, "Need to set dma-translation for svm");
+            return false;
+        }
+
+        if (!s->pasid) {
+            error_setg(errp, "Need to set PASID support for svm");
+            return false;
+        }
+    }
+
+
     return true;
 }
 
@@ -5583,17 +5613,6 @@ static void vtd_realize(DeviceState *dev, Error **errp)
     X86MachineState *x86ms = X86_MACHINE(ms);
     PCIBus *bus = pcms->pcibus;
     IntelIOMMUState *s = INTEL_IOMMU_DEVICE(dev);
-    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
-
-    if (s->pasid && x86_iommu->dt_supported) {
-        /*
-         * PASID-based-Device-TLB Invalidate Descriptor is not
-         * implemented and it requires support from vhost layer which
-         * needs to be implemented in the future.
-         */
-        error_setg(errp, "PASID based device IOTLB is not supported");
-        return;
-    }
 
     if (!vtd_decide_config(s, errp)) {
         return;
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 18d50191d2..11a53aa369 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -194,8 +194,10 @@
 #define VTD_ECAP_PRS                (1ULL << 29)
 #define VTD_ECAP_MHMV               (15ULL << 20)
 #define VTD_ECAP_SRS                (1ULL << 31)
+#define VTD_ECAP_NWFS               (1ULL << 33)
 #define VTD_ECAP_PSS                (7ULL << 35) /* limit: MemTxAttrs::pid */
 #define VTD_ECAP_PASID              (1ULL << 40)
+#define VTD_ECAP_PDS                (1ULL << 42)
 #define VTD_ECAP_SMTS               (1ULL << 43)
 #define VTD_ECAP_SSTS               (1ULL << 46)
 #define VTD_ECAP_FSTS               (1ULL << 47)
@@ -417,7 +419,9 @@ typedef union VTDPRDesc VTDPRDesc;
 #define VTD_INV_DESC_WAIT_IF            (1ULL << 4)
 #define VTD_INV_DESC_WAIT_FN            (1ULL << 6)
 #define VTD_INV_DESC_WAIT_DATA_SHIFT    32
-#define VTD_INV_DESC_WAIT_RSVD_LO       0Xfffff180ULL
+#define VTD_INV_DESC_WAIT_RSVD_LO(ecap) (0Xfffff100ULL | \
+                                        (((ecap) & VTD_ECAP_PDS) \
+                                            ? 0 : (1 << 7)))
 #define VTD_INV_DESC_WAIT_RSVD_HI       3ULL
 
 /* Masks for Context-cache Invalidation Descriptor */
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 6c61fd39c7..d600e5495f 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -275,6 +275,7 @@ struct IntelIOMMUState {
     bool scalable_mode;             /* RO - is Scalable Mode supported? */
     bool fsts;                      /* RO - is first stage translation supported? */
     bool snoop_control;             /* RO - is SNP filed supported? */
+    bool svm;                       /* RO - is SVA/SVM supported? */
 
     dma_addr_t root;                /* Current root table pointer */
     bool root_scalable;             /* Type of root table (scalable or not) */
-- 
MST


