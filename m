Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78FA1D1BDF3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84LA-0004Bg-AQ; Mon, 04 Nov 2024 16:10:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Kl-0003NP-Df
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:10:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84Kj-0005Zr-Fi
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4AlRKat1F80od4VLRCbEIVnX9DYR07SQLQkzHGlAwjw=;
 b=Szwh98Qucabs3GDYu197If3d0ADIjb2iEJH7L0OTKjuOZJagUIwgwKS2aujn+/sK6g4Nvq
 x4mzIFbGk1v2/mqcB7M7xPnZvRGYujxky0UAYTMxOYUkIn76XbRtDuX0e9pk3nIG4siCmP
 oZn9ayEZC+5A9m2xVbDf6yc0lRhc0w4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-i8euMQAzO0iU_Gp24CKnZQ-1; Mon, 04 Nov 2024 16:09:55 -0500
X-MC-Unique: i8euMQAzO0iU_Gp24CKnZQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4316e350d6aso30669475e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:09:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754593; x=1731359393;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4AlRKat1F80od4VLRCbEIVnX9DYR07SQLQkzHGlAwjw=;
 b=YGDrSfRruyVOLYGPxFkc5s4FErovI6amuShaK7LnCOx8uWRmQK76JWozrWm8L0X1Z3
 vgB8FXDLnrt/w2Wgr1ETUyMAljvprlN8eWIptObfuPe7ANYRxor0oMJkc9zdOtveoK3H
 uOEujaQFIRTqUPGKBZWAgykr9H3fTUrzamVDE0FtHUoE5j0wtemn4zZSfKmeUxBmhM/J
 l59RFK4JJpvSudSgk+ILh4SulaGzhL+K+rXqi3ovuudz7WTSQ2NEyi76ujky30WGQYMS
 4upnNJr6LQHo4ychpP5xjzKDAIvMTuQvnTZWYypGLILJl5rmQDpgZS/8LEnbMEyugTpu
 WQ0w==
X-Gm-Message-State: AOJu0YwnG4YySbAIQSvjo8/GrVCxTU8FAoNQkgbgAWfcIK/RTujq7Q7w
 WFMPqWIIowoVviVhVcTLSHyjTmmArxyDBhRE2jUcqDVSb3M5yQWUMBTVbM6HcRz2QzrR4lxhtth
 RO2mWjW5eiApfSbbfT8hvnWoKBSvxa3dpXW1sl8L2eNW8M/dyUbGypR8N4WwOEucoN9kI/t2VPs
 R2ybgOGpQd0i0qxQekqmgN8/yO25SWVg==
X-Received: by 2002:a05:600c:1987:b0:431:6083:cd2a with SMTP id
 5b1f17b1804b1-4328324d6bfmr108120785e9.15.1730754593508; 
 Mon, 04 Nov 2024 13:09:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNOsXJUYASXskn8NL7iu5FmYrdhi5aXsP/fwB3vsuR5TL16WhmtzbfxGua3oZiyRji+5SNNw==
X-Received: by 2002:a05:600c:1987:b0:431:6083:cd2a with SMTP id
 5b1f17b1804b1-4328324d6bfmr108120455e9.15.1730754592921; 
 Mon, 04 Nov 2024 13:09:52 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd910357sm200109155e9.11.2024.11.04.13.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:09:52 -0800 (PST)
Date: Mon, 4 Nov 2024 16:09:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 65/65] intel_iommu: Add missed reserved bit check for IEC
 descriptor
Message-ID: <096d96e7be7071aa805c4e70ef51da0b99b6a8fc.1730754238.git.mst@redhat.com>
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

IEC descriptor is 128-bit invalidation descriptor, must be padded with
128-bits of 0s in the upper bytes to create a 256-bit descriptor when
the invalidation queue is configured for 256-bit descriptors (IQA_REG.DW=1).

Fixes: 02a2cbc872df ("x86-iommu: introduce IEC notifiers")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Message-Id: <20241104125536.1236118-4-zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu_internal.h | 3 +++
 hw/i386/intel_iommu.c          | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 75ccd501b0..4323fc5d6d 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -410,6 +410,9 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_DEVICE_IOTLB_RSVD_HI 0xffeULL
 #define VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO 0xffff0000ffe0f1f0
 
+/* Masks for Interrupt Entry Invalidate Descriptor */
+#define VTD_INV_DESC_IEC_RSVD           0xffff000007fff1e0ULL
+
 /* Rsvd field masks for spte */
 #define VTD_SPTE_SNP 0x800ULL
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 2fc3866433..4c0d1d7d47 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2692,6 +2692,14 @@ static bool vtd_process_iotlb_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
 static bool vtd_process_inv_iec_desc(IntelIOMMUState *s,
                                      VTDInvDesc *inv_desc)
 {
+    uint64_t mask[4] = {VTD_INV_DESC_IEC_RSVD, VTD_INV_DESC_ALL_ONE,
+                        VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
+
+    if (!vtd_inv_desc_reserved_check(s, inv_desc, mask, false,
+                                     __func__, "iec inv")) {
+        return false;
+    }
+
     trace_vtd_inv_desc_iec(inv_desc->iec.granularity,
                            inv_desc->iec.index,
                            inv_desc->iec.index_mask);
-- 
MST


