Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4CAEE49BD
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 15:08:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soOn7-0003ig-Ph; Wed, 11 Sep 2024 10:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOhk-00078a-Ib
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:52:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1soOha-0007Dt-Sd
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 10:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726066332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bY3kFhk2MQOhFrrXbGMngbSdwByo8f4uY8jy3ERVqew=;
 b=cZOl26mRMJ/eJnI/OdKQr8YFGRU5qnjDxfcT+ogVKaP8n49g7KY87qHCPmX1xUdZg/qZoq
 VB8Gx1bLhFl+p9sDGumKJIKmNkyd3QRi25OH7t0crXllFyWV11ZsMWjwpPOE80iDTFDPUH
 jG58bJvR4W5yoJk61kKdEm9S9dvVuBY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-0xm-B_Y7OL--D-ct_F0bXg-1; Wed, 11 Sep 2024 09:51:54 -0400
X-MC-Unique: 0xm-B_Y7OL--D-ct_F0bXg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5c3c256e2a3so5362058a12.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 06:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726062712; x=1726667512;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bY3kFhk2MQOhFrrXbGMngbSdwByo8f4uY8jy3ERVqew=;
 b=LV4wkkVSb0zFluHNAqdsKi+C20owZuNSPTNQ1lOwXzxIIoW5kwuziqf5bePiK7j2Kq
 5GgzQZr4zQxqqa4d6HSayU5DWWb0l8x15lVW1CvBDw4VZHrBv1ZI2OrIh1CZlLDkc3Q7
 EICB+PzkrLt0LN0H9ggOo4zgVX50sfZddV1KHXQkXdkF2vNG8kG2PMM74sP3SU5Nwyum
 26Uye73rt50oEXxdYdKlfJ9oY+mxfMKyBaKa05s6JtDfnr7+9WpiGMuDifPCZdQIZP0g
 sZldntAq431+uDy8+EMvvmbBpOFMxdL817fyHPoqns22958EPmltWF+L4gAEmu1puCsS
 zhQA==
X-Gm-Message-State: AOJu0Yxi5QIl4oHEYG4SYqUBCRopbPgbqADNUlCjVDSvjNkwn3kzSzcy
 Nm7ssSuFdO7finMvAI6TEhvs3ck4R5o2RiGokLDQhDpizwnt50nL5hzh5+mOoJHG39lh1nXvuTY
 2MAJTcqU1eWOcz5M38mZv8GDLAs79/98chx5q3IitlHiNTJdzDyjoho/u+HE3txKwb+K/dUPqwN
 djPBW7UYROUSAiDwBJjHmKwT2dKgS1KQ==
X-Received: by 2002:a17:906:d54b:b0:a8c:d6a3:d03a with SMTP id
 a640c23a62f3a-a8ffab18781mr379087666b.21.1726062712056; 
 Wed, 11 Sep 2024 06:51:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdUTOIul3p3RXD60SbSrV4T0ZNZ8f38tSJB3JJikoRHl9kx7775iRWvtWUySz6TnMaK7nc1Q==
X-Received: by 2002:a17:906:d54b:b0:a8c:d6a3:d03a with SMTP id
 a640c23a62f3a-a8ffab18781mr379083266b.21.1726062711359; 
 Wed, 11 Sep 2024 06:51:51 -0700 (PDT)
Received: from redhat.com ([2.55.9.133]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d258354d1sm620068366b.13.2024.09.11.06.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 06:51:50 -0700 (PDT)
Date: Wed, 11 Sep 2024 09:51:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 08/18] intel_iommu: Fix invalidation descriptor type field
Message-ID: <663168943d3db6d9b51d3dfa0998848a6e6eda71.1726062663.git.mst@redhat.com>
References: <cover.1726062663.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1726062663.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

According to spec, invalidation descriptor type is 7bits which is
concatenation of bits[11:9] and bits[3:0] of invalidation descriptor.

Currently we only pick bits[3:0] as the invalidation type and treat
bits[11:9] as reserved zero. This is not a problem for now as bits[11:9]
is zero for all current invalidation types. But it will break if newer
type occupies bits[11:9].

Fix it by taking bits[11:9] into type and make reserved bits check accurate.

Suggested-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
Message-Id: <20240814071321.2621384-2-zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu_internal.h | 11 ++++++-----
 hw/i386/intel_iommu.c          |  2 +-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 5f32c36943..13d5d129ae 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -356,7 +356,8 @@ union VTDInvDesc {
 typedef union VTDInvDesc VTDInvDesc;
 
 /* Masks for struct VTDInvDesc */
-#define VTD_INV_DESC_TYPE               0xf
+#define VTD_INV_DESC_TYPE(val)          ((((val) >> 5) & 0x70ULL) | \
+                                         ((val) & 0xfULL))
 #define VTD_INV_DESC_CC                 0x1 /* Context-cache Invalidate Desc */
 #define VTD_INV_DESC_IOTLB              0x2
 #define VTD_INV_DESC_DEVICE             0x3
@@ -372,7 +373,7 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_WAIT_IF            (1ULL << 4)
 #define VTD_INV_DESC_WAIT_FN            (1ULL << 6)
 #define VTD_INV_DESC_WAIT_DATA_SHIFT    32
-#define VTD_INV_DESC_WAIT_RSVD_LO       0Xffffff80ULL
+#define VTD_INV_DESC_WAIT_RSVD_LO       0Xfffff180ULL
 #define VTD_INV_DESC_WAIT_RSVD_HI       3ULL
 
 /* Masks for Context-cache Invalidation Descriptor */
@@ -383,7 +384,7 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_CC_DID(val)        (((val) >> 16) & VTD_DOMAIN_ID_MASK)
 #define VTD_INV_DESC_CC_SID(val)        (((val) >> 32) & 0xffffUL)
 #define VTD_INV_DESC_CC_FM(val)         (((val) >> 48) & 3UL)
-#define VTD_INV_DESC_CC_RSVD            0xfffc00000000ffc0ULL
+#define VTD_INV_DESC_CC_RSVD            0xfffc00000000f1c0ULL
 
 /* Masks for IOTLB Invalidate Descriptor */
 #define VTD_INV_DESC_IOTLB_G            (3ULL << 4)
@@ -393,7 +394,7 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_IOTLB_DID(val)     (((val) >> 16) & VTD_DOMAIN_ID_MASK)
 #define VTD_INV_DESC_IOTLB_ADDR(val)    ((val) & ~0xfffULL)
 #define VTD_INV_DESC_IOTLB_AM(val)      ((val) & 0x3fULL)
-#define VTD_INV_DESC_IOTLB_RSVD_LO      0xffffffff0000ff00ULL
+#define VTD_INV_DESC_IOTLB_RSVD_LO      0xffffffff0000f100ULL
 #define VTD_INV_DESC_IOTLB_RSVD_HI      0xf80ULL
 #define VTD_INV_DESC_IOTLB_PASID_PASID  (2ULL << 4)
 #define VTD_INV_DESC_IOTLB_PASID_PAGE   (3ULL << 4)
@@ -406,7 +407,7 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_DEVICE_IOTLB_SIZE(val) ((val) & 0x1)
 #define VTD_INV_DESC_DEVICE_IOTLB_SID(val) (((val) >> 32) & 0xFFFFULL)
 #define VTD_INV_DESC_DEVICE_IOTLB_RSVD_HI 0xffeULL
-#define VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO 0xffff0000ffe0fff8
+#define VTD_INV_DESC_DEVICE_IOTLB_RSVD_LO 0xffff0000ffe0f1f0
 
 /* Rsvd field masks for spte */
 #define VTD_SPTE_SNP 0x800ULL
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 16d2885fcc..68cb72a481 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2744,7 +2744,7 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
         return false;
     }
 
-    desc_type = inv_desc.lo & VTD_INV_DESC_TYPE;
+    desc_type = VTD_INV_DESC_TYPE(inv_desc.lo);
     /* FIXME: should update at first or at last? */
     s->iq_last_desc_type = desc_type;
 
-- 
MST


