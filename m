Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C30C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7qo-0008BP-Qy; Wed, 15 Jan 2025 13:10:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7ps-0006zz-Ma
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:09:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7pr-0006gM-3t
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:09:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ETnhhwJ4AroiA4dDpka4gKiY7LenBhWoiTYTB5Wyngk=;
 b=XH6j248wY8hUmWLYjDz8AhhKFQwQUTgY+5IDupFeyLiqY3HW5/VXkfGbZKb4UKj8y+ufEk
 WqcvfymIYh6YCITmquaDg0fl0VVkYGly4C8O6A7N95W3i1N8PjA0KyXR0UhFHOQebNfoNY
 m/DzOzpOGS8PNbwqTqXJtYp3Lpj/sGA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-DPch8Q0-O0KZYBurOtnO7g-1; Wed, 15 Jan 2025 13:09:44 -0500
X-MC-Unique: DPch8Q0-O0KZYBurOtnO7g-1
X-Mimecast-MFC-AGG-ID: DPch8Q0-O0KZYBurOtnO7g
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-386333ea577so39088f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:09:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964583; x=1737569383;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ETnhhwJ4AroiA4dDpka4gKiY7LenBhWoiTYTB5Wyngk=;
 b=efoP+TLuKvb9AAmjv/JYM7wQCN4AQnwub9GD8Fv0MuZ17jCybT8Lmg+2VTk//kAfwo
 DdWuVFNgGMvBCbm3hAazVbPq3wAK1pu4moXns3xcfCZcC55J23dEwmaRNlUhDDGEww8P
 mf8VartF1heb3sR6Vfnnw7OIVuYDUYDpWgCJEoSks4l1MeTvzYzGg+osF00zaVvHBdB4
 2aPafVlVsRXubvL8N1jV6EQTbVyJWyn42rX0IGK2YPw767rFeQ0adY8aY5HiSd9jxyFq
 VBkOnlGKX3o8LCcc7LcFZNr2rg3EPNhtnvzCjjmUMEps0Ww5VMMi4vod59saGsBwHeWl
 Htuw==
X-Gm-Message-State: AOJu0Yx7P5+K31TAkXn4bw4bNQ89/gvk4bdluUDQDLacGNjGhzR8i3eH
 OW/j9xuYftG/vpayDaejZt6u5A5NNmgaU42S+90higb4DkWiL/sfmGr16r2+uh2TlznRuARt2vu
 nH/DJk9UU60/gbfO5OGELIY6Q5UB4/VI8Y3MdeicURlh9N407yPYHkK2WveHT7n5DuO0RC9Z8xx
 uUM2rMhZ4uec5k0yoNeS2UjPawv+5Rog==
X-Gm-Gg: ASbGncu/rzNmK1fFlEOcH99hGAWrOBftvCChv+PTx3xFoOGKMe4Wa2WDCM7a65ILKMK
 II0cqUiNGVqd8iQ3fYPU3AjSjA/+qCSzftxA1bhjbyUawkT6C/K/mVs4t3wdFAipvILQNV6hU6G
 ZV2msRWUR2fkO39hEF3SJDFU07ByHFxG52rOYibj1zrtmr/DhEmxfxVESivCPbmNbzL9SNX+dS4
 f9emgHx79L7fCpGZv/nOU4hdCQPC4G14wYlAnuoujtc+5UxbCxu
X-Received: by 2002:adf:a108:0:b0:38a:88ac:ed10 with SMTP id
 ffacd0b85a97d-38a88acedf9mr22371451f8f.25.1736964583237; 
 Wed, 15 Jan 2025 10:09:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvEpBYCLwLSaI0pWIX/41ba8W5NS9zsXJ3fcnlLOa/9SCF30PmW2rUDzr2AUVT4IZCXVjhJg==
X-Received: by 2002:adf:a108:0:b0:38a:88ac:ed10 with SMTP id
 ffacd0b85a97d-38a88acedf9mr22371416f8f.25.1736964582780; 
 Wed, 15 Jan 2025 10:09:42 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74c475csm32200845e9.20.2025.01.15.10.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:09:42 -0800 (PST)
Date: Wed, 15 Jan 2025 13:09:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 23/48] intel_iommu: Introduce a property x-flts for stage-1
 translation
Message-ID: <aa68a9fbdb81c47c2a48a3199559df470c3d9eba.1736964488.git.mst@redhat.com>
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

Intel VT-d 3.0 introduces scalable mode, and it has a bunch of capabilities
related to scalable mode translation, thus there are multiple combinations.

This vIOMMU implementation wants to simplify it with a new property "x-flts".
When turned on in scalable mode, stage-1 translation is supported. When turned
on in legacy mode, throw out error.

With stage-1 translation support exposed to user, also accurate the pasid entry
check in vtd_pe_type_check().

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
Message-Id: <20241212083757.605022-19-zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu_internal.h |  2 ++
 hw/i386/intel_iommu.c          | 28 +++++++++++++++++++---------
 2 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 2c977aa7da..e8b211e8b0 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -195,6 +195,7 @@
 #define VTD_ECAP_PASID              (1ULL << 40)
 #define VTD_ECAP_SMTS               (1ULL << 43)
 #define VTD_ECAP_SLTS               (1ULL << 46)
+#define VTD_ECAP_FLTS               (1ULL << 47)
 
 /* CAP_REG */
 /* (offset >> 4) << 24 */
@@ -211,6 +212,7 @@
 #define VTD_CAP_SLLPS               ((1ULL << 34) | (1ULL << 35))
 #define VTD_CAP_DRAIN_WRITE         (1ULL << 54)
 #define VTD_CAP_DRAIN_READ          (1ULL << 55)
+#define VTD_CAP_FS1GP               (1ULL << 56)
 #define VTD_CAP_DRAIN               (VTD_CAP_DRAIN_READ | VTD_CAP_DRAIN_WRITE)
 #define VTD_CAP_CM                  (1ULL << 7)
 #define VTD_PASID_ID_SHIFT          20
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 7d4b99523d..0111186f7a 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -803,16 +803,18 @@ static inline bool vtd_is_fl_level_supported(IntelIOMMUState *s, uint32_t level)
 }
 
 /* Return true if check passed, otherwise false */
-static inline bool vtd_pe_type_check(X86IOMMUState *x86_iommu,
-                                     VTDPASIDEntry *pe)
+static inline bool vtd_pe_type_check(IntelIOMMUState *s, VTDPASIDEntry *pe)
 {
     switch (VTD_PE_GET_TYPE(pe)) {
-    case VTD_SM_PASID_ENTRY_SLT:
-        return true;
-    case VTD_SM_PASID_ENTRY_PT:
-        return x86_iommu->pt_supported;
     case VTD_SM_PASID_ENTRY_FLT:
+        return !!(s->ecap & VTD_ECAP_FLTS);
+    case VTD_SM_PASID_ENTRY_SLT:
+        return !!(s->ecap & VTD_ECAP_SLTS);
     case VTD_SM_PASID_ENTRY_NESTED:
+        /* Not support NESTED page table type yet */
+        return false;
+    case VTD_SM_PASID_ENTRY_PT:
+        return !!(s->ecap & VTD_ECAP_PT);
     default:
         /* Unknown type */
         return false;
@@ -861,7 +863,6 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
     uint8_t pgtt;
     uint32_t index;
     dma_addr_t entry_size;
-    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
 
     index = VTD_PASID_TABLE_INDEX(pasid);
     entry_size = VTD_PASID_ENTRY_SIZE;
@@ -875,7 +876,7 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
     }
 
     /* Do translation type check */
-    if (!vtd_pe_type_check(x86_iommu, pe)) {
+    if (!vtd_pe_type_check(s, pe)) {
         return -VTD_FR_PASID_TABLE_ENTRY_INV;
     }
 
@@ -3827,6 +3828,7 @@ static const Property vtd_properties[] = {
                       VTD_HOST_ADDRESS_WIDTH),
     DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
     DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
+    DEFINE_PROP_BOOL("x-flts", IntelIOMMUState, flts, FALSE),
     DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, false),
     DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
     DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
@@ -4557,7 +4559,10 @@ static void vtd_cap_init(IntelIOMMUState *s)
     }
 
     /* TODO: read cap/ecap from host to decide which cap to be exposed. */
-    if (s->scalable_mode) {
+    if (s->flts) {
+        s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_FLTS;
+        s->cap |= VTD_CAP_FS1GP;
+    } else if (s->scalable_mode) {
         s->ecap |= VTD_ECAP_SMTS | VTD_ECAP_SRS | VTD_ECAP_SLTS;
     }
 
@@ -4736,6 +4741,11 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
         }
     }
 
+    if (!s->scalable_mode && s->flts) {
+        error_setg(errp, "x-flts is only available in scalable mode");
+        return false;
+    }
+
     if (!s->flts && s->aw_bits != VTD_HOST_AW_39BIT &&
         s->aw_bits != VTD_HOST_AW_48BIT) {
         error_setg(errp, "%s: supported values for aw-bits are: %d, %d",
-- 
MST


