Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA8CD1BDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84Ym-0007n6-0m; Mon, 04 Nov 2024 16:24:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Yk-0007mj-Ox
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:24:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Yj-0006uo-4I
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:24:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730755464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jn4WUkhWFsTn3Zafq3qOV5CM6ns6biTKh9xhZYCuQz4=;
 b=i05mk24TJQCSI0N6BdCQWM1WNJkWmhoOpjhkuJ+Vtd4EAsWBPeYx0JPR9laZ5754INqvqh
 bWjTlULnIiJ9rkgZpJlSeXhM/3MaQ1XJJEz8/WfP+4ljmJQnbVXLTqaYM5YJWPaKEojIpo
 C/CgkuRppzlDAYs1x/yxTPZPjzAtT2w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-dDGCEKz5Nnqk4Z_q3_Stqg-1; Mon, 04 Nov 2024 16:24:23 -0500
X-MC-Unique: dDGCEKz5Nnqk4Z_q3_Stqg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315544642eso34533135e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:24:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730755461; x=1731360261;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jn4WUkhWFsTn3Zafq3qOV5CM6ns6biTKh9xhZYCuQz4=;
 b=Akt6nKecfS/q8jsEw1pk+JZ62oBlU7/5/se1JwEKoP4GFIRb93NJ7/iwWDqMTVJXCP
 ZPBSoDwdVoUadXsuqQhouccsipR37gbSgrG8dIwZ/SLATfB66XZy21DIoC4lNGkPjg67
 M5/1jMDCdXhI444eQnhbLXpubUQnyN5b8Ly8FFxw2OMYa+R7clAFz7ArvqdQ6SgJoVBi
 VFDJkekrNnZ+5cuU8NqEeATJqH3Iyh07UzjBnjXu9RtVTI7qWKIdpFUJXfRKD0IO+eTK
 5gzxm05u4Qk0quAzRVN8e6uUjE6DOi0ghz3BNXdQp7yif6vGcLOcAhAVblXfRkQwk8Nt
 G5ZA==
X-Gm-Message-State: AOJu0YxBwSB6zr2S5LmDr0osODGYPBiK9de+d3zMozqicGnbnFoZQ1Nj
 G7nDKc8oZwZmYqpACy4R/xDTfnq7fr5TtK5FtyaaC76wpLOAJQ9tH7Ats0GRa2jmPSzyJknrdID
 GMWYb4tXGndr1nlMJ+sY41LvMPWPw6cRr9TXq5RLEEeAvOLwazqkqUpbWbPJMC+n7n2o1KiWXrt
 Fn16QH6NMwFalI7CKZdCPgBByV1E9rew==
X-Received: by 2002:a5d:6da9:0:b0:37d:5035:451 with SMTP id
 ffacd0b85a97d-381be7ad026mr15004845f8f.10.1730755461409; 
 Mon, 04 Nov 2024 13:24:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbGHe3QCslXUSewGBjhPHi7RP/RCi4LBKvKPnk5ppUjtXtGFtd/s65EVVYH6GMUJIkmUAffw==
X-Received: by 2002:a5d:6da9:0:b0:37d:5035:451 with SMTP id
 ffacd0b85a97d-381be7ad026mr15004825f8f.10.1730755460938; 
 Mon, 04 Nov 2024 13:24:20 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd947a9fsm199069825e9.22.2024.11.04.13.24.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:24:20 -0800 (PST)
Date: Mon, 4 Nov 2024 16:24:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, Jason Wang <jasowang@redhat.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 43/65] intel_iommu: Introduce property "stale-tm" to control
 Transient Mapping (TM) field
Message-ID: <6ce12bd29777d41afef859652eaa62b5c964d3f7.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

VT-d spec removed Transient Mapping (TM) field from second-level page-tables
and treat the field as Reserved(0) since revision 3.2.

Changing the field as reserved(0) will break backward compatibility, so
introduce a property "stale-tm" to allow user to control the setting.

Use pc_compat_9_1 to handle the compatibility for machines before 9.2 which
allow guest to set the field. Starting from 9.2, this field is reserved(0)
by default to match spec. Of course, user can force it on command line.

This doesn't impact function of vIOMMU as there was no logic to emulate
Transient Mapping.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Message-Id: <20241028022514.806657-1-zhenzhong.duan@intel.com>
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu_internal.h | 12 ++++++------
 include/hw/i386/intel_iommu.h  |  3 +++
 hw/i386/intel_iommu.c          |  7 ++++---
 hw/i386/pc.c                   |  1 +
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 13d5d129ae..2f9bc0147d 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -412,8 +412,8 @@ typedef union VTDInvDesc VTDInvDesc;
 /* Rsvd field masks for spte */
 #define VTD_SPTE_SNP 0x800ULL
 
-#define VTD_SPTE_PAGE_L1_RSVD_MASK(aw, dt_supported) \
-        dt_supported ? \
+#define VTD_SPTE_PAGE_L1_RSVD_MASK(aw, stale_tm) \
+        stale_tm ? \
         (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
         (0x800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
 #define VTD_SPTE_PAGE_L2_RSVD_MASK(aw) \
@@ -423,12 +423,12 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_SPTE_PAGE_L4_RSVD_MASK(aw) \
         (0x880ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
 
-#define VTD_SPTE_LPAGE_L2_RSVD_MASK(aw, dt_supported) \
-        dt_supported ? \
+#define VTD_SPTE_LPAGE_L2_RSVD_MASK(aw, stale_tm) \
+        stale_tm ? \
         (0x1ff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
         (0x1ff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
-#define VTD_SPTE_LPAGE_L3_RSVD_MASK(aw, dt_supported) \
-        dt_supported ? \
+#define VTD_SPTE_LPAGE_L3_RSVD_MASK(aw, stale_tm) \
+        stale_tm ? \
         (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
         (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
 
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 1eb05c29fc..d372cd396b 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -306,6 +306,9 @@ struct IntelIOMMUState {
     bool dma_translation;           /* Whether DMA translation supported */
     bool pasid;                     /* Whether to support PASID */
 
+    /* Transient Mapping, Reserved(0) since VTD spec revision 3.2 */
+    bool stale_tm;
+
     /*
      * Protects IOMMU states in general.  Currently it protects the
      * per-IOMMU IOTLB cache, and context entry cache in VTDAddressSpace.
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 08fe218935..8612d0917b 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3372,6 +3372,7 @@ static Property vtd_properties[] = {
     DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
     DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
     DEFINE_PROP_BOOL("dma-translation", IntelIOMMUState, dma_translation, true),
+    DEFINE_PROP_BOOL("stale-tm", IntelIOMMUState, stale_tm, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -4138,15 +4139,15 @@ static void vtd_init(IntelIOMMUState *s)
      */
     vtd_spte_rsvd[0] = ~0ULL;
     vtd_spte_rsvd[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits,
-                                                  x86_iommu->dt_supported);
+                                        x86_iommu->dt_supported && s->stale_tm);
     vtd_spte_rsvd[2] = VTD_SPTE_PAGE_L2_RSVD_MASK(s->aw_bits);
     vtd_spte_rsvd[3] = VTD_SPTE_PAGE_L3_RSVD_MASK(s->aw_bits);
     vtd_spte_rsvd[4] = VTD_SPTE_PAGE_L4_RSVD_MASK(s->aw_bits);
 
     vtd_spte_rsvd_large[2] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits,
-                                                    x86_iommu->dt_supported);
+                                        x86_iommu->dt_supported && s->stale_tm);
     vtd_spte_rsvd_large[3] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits,
-                                                    x86_iommu->dt_supported);
+                                        x86_iommu->dt_supported && s->stale_tm);
 
     if (s->scalable_mode || s->snoop_control) {
         vtd_spte_rsvd[1] &= ~VTD_SPTE_SNP;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2047633e4c..830614d930 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -82,6 +82,7 @@
 GlobalProperty pc_compat_9_1[] = {
     { "ICH9-LPC", "x-smi-swsmi-timer", "off" },
     { "ICH9-LPC", "x-smi-periodic-timer", "off" },
+    { TYPE_INTEL_IOMMU_DEVICE, "stale-tm", "on" },
 };
 const size_t pc_compat_9_1_len = G_N_ELEMENTS(pc_compat_9_1);
 
-- 
MST


