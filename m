Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E884C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:27:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSI2-0001fQ-1m; Mon, 14 Jul 2025 19:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSH3-000613-Me
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:08:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSH1-0005bm-01
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MOHStGMxU1OhGbAb8/Tgd5Xkkc+adSNHryY5YcQQ/VU=;
 b=MBmIE1HLqHUdBlRqQeODXgvrYiXFc6+32uT2xfwJ8Ds2G9rLatMLSwt3ghJNTECTpn0/Is
 q892U/sYBnMQp+XbnIDYO3OggROpgVtMluhdjLauynWOVLkMwcXJflpWaUHfQTuFHZ9f9c
 ZGdxkk1PjOKLYaBJFvSNNfx6LIBICPs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-5EUp6dpaP_uKbUOBNXcSFQ-1; Mon, 14 Jul 2025 19:07:49 -0400
X-MC-Unique: 5EUp6dpaP_uKbUOBNXcSFQ-1
X-Mimecast-MFC-AGG-ID: 5EUp6dpaP_uKbUOBNXcSFQ_1752534468
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45359bfe631so29217785e9.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:07:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534468; x=1753139268;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MOHStGMxU1OhGbAb8/Tgd5Xkkc+adSNHryY5YcQQ/VU=;
 b=BovObFTY8knJcX1F7fnfw5OJMROz9ulnXufh2gTKqrm3SkFaYkqj55+k/vk7U5QaF/
 uXtsHowowCZ+17wASIXPWTjh69BsVzTnGdYvLyfLgpunPPMsAH2XCPfEK7Xa7qf13d8D
 52sp4L9EFFRGh88Unm3bQNYMuGVLJsb9efEzCOWQgKrNcBRCDpMwH/6S1/0b3MwnnqMT
 dqeYJiGigvwHZH9c13w4GBxYA5Qp1KlIdG/9mYIlJI5nT01x4w+Myoz6YxHM+f6HNmR/
 Q+RyWRIbE834aN4D5jU4ZeSUfqQB5UncPchUMAQwr+me7+v4MhZk2JNLUqQuUxOB//m0
 tZow==
X-Gm-Message-State: AOJu0YzF3PanBi9ePSMIoMEr1S9frZztcZ5CeowshFxSJdpieYIihcSR
 LESYe4T7MI/25qCS/A1DnaQR1FwOFP9jv6gokUdW6kAH0z6rhHnOB6JzlZk9tuDt7RBsKnUvgTZ
 5+KGgFuuoxmyTvdCh8jdaighKeL/wxTvxd4N9DW3JL7P9CF7+CEn9XjPGiys9wgjVX1A7NNDMcJ
 o88xcGyVt4zXAEEFrb9BXU7JGO5N/giWZE+w==
X-Gm-Gg: ASbGncuV5nEK2UHVbPjd/1ScBD9mUdfagztsFPIPVH0KVj3hm7ouQjHKh4DlAzmOsZy
 5hopoZfdpueYerhSItg+6278VvWpn4Y0gMi0dliLYQ/vM/VVOnxFvgtvlZlj496lm9X/YhcBE6w
 pXTdWKhjFbh5XokV08saotct9LKP9TqmthD1+QSVQ6oEMhkNBAb2aOs19pVKyQ/DsyY2OsVBW2e
 lgK3bikvOyJKrd7h5GEu0bdumajph+GgK6t29RycJQX39X2lB3ZUc6SID6++K9zd3oMaMYi0KGI
 cZJvMgHdrb20GRXNGxPQGnlFTCs6Qt3Y
X-Received: by 2002:a05:600c:4693:b0:456:496:2100 with SMTP id
 5b1f17b1804b1-456049621efmr97626945e9.31.1752534467737; 
 Mon, 14 Jul 2025 16:07:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXnSYpUdGR5XXR0qOkhLIh7FZghoxo7vTTlQfUrbgtPTAIFdT+2ahq+4TlkVGoIhKgfWI/tA==
X-Received: by 2002:a05:600c:4693:b0:456:496:2100 with SMTP id
 5b1f17b1804b1-456049621efmr97626725e9.31.1752534467324; 
 Mon, 14 Jul 2025 16:07:47 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc217esm13158702f8f.28.2025.07.14.16.07.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:07:46 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:07:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 36/97] intel_iommu: Return page walk level even when the
 translation fails
Message-ID: <4ecafbaec7c52c4d4ce88315766b9ad0be063a7c.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>

We will use this information in vtd_do_iommu_translate to populate the
IOMMUTLBEntry and indicate the correct page mask. This prevents ATS
devices from sending many useless translation requests when a megapage
or gigapage is not present.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
Message-Id: <20250628180226.133285-9-clement.mathieu--drif@eviden.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 234c452849..bff307b9bc 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1987,9 +1987,9 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
                              uint32_t pasid)
 {
     dma_addr_t addr = vtd_get_iova_pgtbl_base(s, ce, pasid);
-    uint32_t level = vtd_get_iova_level(s, ce, pasid);
     uint32_t offset;
     uint64_t flpte, flag_ad = VTD_FL_A;
+    *flpte_level = vtd_get_iova_level(s, ce, pasid);
 
     if (!vtd_iova_fl_check_canonical(s, iova, ce, pasid)) {
         error_report_once("%s: detected non canonical IOVA (iova=0x%" PRIx64 ","
@@ -1998,11 +1998,11 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
     }
 
     while (true) {
-        offset = vtd_iova_level_offset(iova, level);
+        offset = vtd_iova_level_offset(iova, *flpte_level);
         flpte = vtd_get_pte(addr, offset);
 
         if (flpte == (uint64_t)-1) {
-            if (level == vtd_get_iova_level(s, ce, pasid)) {
+            if (*flpte_level == vtd_get_iova_level(s, ce, pasid)) {
                 /* Invalid programming of pasid-entry */
                 return -VTD_FR_PASID_ENTRY_FSPTPTR_INV;
             } else {
@@ -2028,15 +2028,15 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
         if (is_write && !(flpte & VTD_FL_RW)) {
             return -VTD_FR_SM_WRITE;
         }
-        if (vtd_flpte_nonzero_rsvd(flpte, level)) {
+        if (vtd_flpte_nonzero_rsvd(flpte, *flpte_level)) {
             error_report_once("%s: detected flpte reserved non-zero "
                               "iova=0x%" PRIx64 ", level=0x%" PRIx32
                               "flpte=0x%" PRIx64 ", pasid=0x%" PRIX32 ")",
-                              __func__, iova, level, flpte, pasid);
+                              __func__, iova, *flpte_level, flpte, pasid);
             return -VTD_FR_FS_PAGING_ENTRY_RSVD;
         }
 
-        if (vtd_is_last_pte(flpte, level) && is_write) {
+        if (vtd_is_last_pte(flpte, *flpte_level) && is_write) {
             flag_ad |= VTD_FL_D;
         }
 
@@ -2044,14 +2044,13 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
             return -VTD_FR_FS_BIT_UPDATE_FAILED;
         }
 
-        if (vtd_is_last_pte(flpte, level)) {
+        if (vtd_is_last_pte(flpte, *flpte_level)) {
             *flptep = flpte;
-            *flpte_level = level;
             return 0;
         }
 
         addr = vtd_get_pte_addr(flpte, aw_bits);
-        level--;
+        (*flpte_level)--;
     }
 }
 
-- 
MST


