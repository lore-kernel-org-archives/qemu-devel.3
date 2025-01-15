Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6B0C02185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7p4-0006Oi-Pi; Wed, 15 Jan 2025 13:08:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7p0-0006OA-UK
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:08:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7oz-0006WY-5h
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:08:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BA+AAiUYSVdwa0YScwU4cx7B/C7WfTspevhXkrQeIKc=;
 b=WTnNpIvIOc8+aQki81AdsdEdZKw5Y5tUaBahLBtLS2U+/zjilNj0h0zf9OqZeaDDT+WPoj
 2sMIhzJ7hAkRq5a2UWjPiMR2APZtQ2kjy+QZW0C7IJsOaqeVLz7N4UYyoThoVUiIfOt1W8
 VqpWBkC+o9LigJOerkyJqHTUZIBtrmE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-PVMmn7k0PsOtgECQyvRMTw-1; Wed, 15 Jan 2025 13:08:50 -0500
X-MC-Unique: PVMmn7k0PsOtgECQyvRMTw-1
X-Mimecast-MFC-AGG-ID: PVMmn7k0PsOtgECQyvRMTw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-436723db6c4so47624185e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:08:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964527; x=1737569327;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BA+AAiUYSVdwa0YScwU4cx7B/C7WfTspevhXkrQeIKc=;
 b=jpio+Ug6EvyTzyMDyRx8BS4igacFDBg+05YBE15GgzZdHU8JP306Qm+mBgEgQ0qTyh
 bpnaHR8V9oTZ5NFx1Nfb6CSMFQfJ/xvvBLw3rEcOILKceit3hNJkX6o+u/wMdZmfTvko
 ocwYeMMLzE2Y1/RnPfOl54IJb+v2z3Q25btDDg4yziZTY56tJkaMUmtL+JaIkYaCa99P
 0OAm2VQgok0EpBKNjQv+E0J04Ww6/5SYiumTBO1VzGmIScwkbRsxkdUFyk2oVTDcZD0k
 4dRtpGsZYue8MSfzlTupG9T4PHtuksP4vYn+87UKsJI7Re0gdYINoQ2XiVzPc0GGIRMr
 AX5w==
X-Gm-Message-State: AOJu0Yw30RzN7NwEXrCiL84KZRXe7KqAjRvMkp9bCpVwDfgqRY6g7LTU
 mH7nOqx8TCg4bZTLERWgcTDEcsNsuzDhs3N/xFmFkuYtcbgs2XRTPJmG19yQ4aCWwcIbbZnm3ij
 /9UZq0P8bRtDEjNf6RYqJsgtDkuu0raj4m+ovnlk7QxgLjgzBJzDPFkK8VoecXYaLrxJXDj41cd
 2WNq+QmtW3m2WO4FrHqnKfll/EmpX0Tg==
X-Gm-Gg: ASbGncto84OqFqMpGrdyKaXEzk0kiZ7XU8mR/be1ZUVxtuJjzRYHWFiQVgyQxtkzPGa
 TIjH/L1r4kcMm5dIELtMF3i5F/7ULtttUmMJJwFzqwXQL79iR58k9tS8eJrDbBA/r3yogd2g3a4
 gui/58MvG8KgKkHVYE7NIPe2kicsgacUQ+TP3xbIJBAo2/HUttODV3MEg/Zx+tE1PUhO+2p6IM+
 M3aTh7XyMqumPX1bSoAV6umrXiJvnMIv9FrK1I63MqF7k4kLVn1
X-Received: by 2002:a05:600c:3ba0:b0:434:a802:43d with SMTP id
 5b1f17b1804b1-436e27170c7mr248548195e9.27.1736964527411; 
 Wed, 15 Jan 2025 10:08:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGi/RGdHLBf5LDbvhVDMM/MOlTqSeNTzFMKzF9AvI/GEK715h4l13UDc/Xmkd3tleUOgpw3Ig==
X-Received: by 2002:a05:600c:3ba0:b0:434:a802:43d with SMTP id
 5b1f17b1804b1-436e27170c7mr248547855e9.27.1736964526923; 
 Wed, 15 Jan 2025 10:08:46 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74e3b97sm30941335e9.32.2025.01.15.10.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:08:46 -0800 (PST)
Date: Wed, 15 Jan 2025 13:08:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yu Zhang <yu.c.zhang@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 06/48] intel_iommu: Use the latest fault reasons defined by spec
Message-ID: <a84e37af36ca89880395bf999873f1a477bf6fa7.1736964488.git.mst@redhat.com>
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

From: Yu Zhang <yu.c.zhang@linux.intel.com>

Spec revision 3.0 or above defines more detailed fault reasons for
scalable mode. So introduce them into emulation code, see spec
section 7.1.2 for details.

Note spec revision has no relation with VERSION register, Guest
kernel should not use that register to judge what features are
supported. Instead cap/ecap bits should be checked.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20241212083757.605022-2-zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu_internal.h |  9 ++++++++-
 hw/i386/intel_iommu.c          | 25 ++++++++++++++++---------
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 4323fc5d6d..a987023692 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -311,7 +311,14 @@ typedef enum VTDFaultReason {
                                   * request while disabled */
     VTD_FR_IR_SID_ERR = 0x26,   /* Invalid Source-ID */
 
-    VTD_FR_PASID_TABLE_INV = 0x58,  /*Invalid PASID table entry */
+    /* PASID directory entry access failure */
+    VTD_FR_PASID_DIR_ACCESS_ERR = 0x50,
+    /* The Present(P) field of pasid directory entry is 0 */
+    VTD_FR_PASID_DIR_ENTRY_P = 0x51,
+    VTD_FR_PASID_TABLE_ACCESS_ERR = 0x58, /* PASID table entry access failure */
+    /* The Present(P) field of pasid table entry is 0 */
+    VTD_FR_PASID_ENTRY_P = 0x59,
+    VTD_FR_PASID_TABLE_ENTRY_INV = 0x5b,  /*Invalid PASID table entry */
 
     /* Output address in the interrupt address range for scalable mode */
     VTD_FR_SM_INTERRUPT_ADDR = 0x87,
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index a8c275f9ce..0ab1676d5f 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -796,7 +796,7 @@ static int vtd_get_pdire_from_pdir_table(dma_addr_t pasid_dir_base,
     addr = pasid_dir_base + index * entry_size;
     if (dma_memory_read(&address_space_memory, addr,
                         pdire, entry_size, MEMTXATTRS_UNSPECIFIED)) {
-        return -VTD_FR_PASID_TABLE_INV;
+        return -VTD_FR_PASID_DIR_ACCESS_ERR;
     }
 
     pdire->val = le64_to_cpu(pdire->val);
@@ -814,6 +814,7 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
                                           dma_addr_t addr,
                                           VTDPASIDEntry *pe)
 {
+    uint8_t pgtt;
     uint32_t index;
     dma_addr_t entry_size;
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
@@ -823,7 +824,7 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
     addr = addr + index * entry_size;
     if (dma_memory_read(&address_space_memory, addr,
                         pe, entry_size, MEMTXATTRS_UNSPECIFIED)) {
-        return -VTD_FR_PASID_TABLE_INV;
+        return -VTD_FR_PASID_TABLE_ACCESS_ERR;
     }
     for (size_t i = 0; i < ARRAY_SIZE(pe->val); i++) {
         pe->val[i] = le64_to_cpu(pe->val[i]);
@@ -831,11 +832,13 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
 
     /* Do translation type check */
     if (!vtd_pe_type_check(x86_iommu, pe)) {
-        return -VTD_FR_PASID_TABLE_INV;
+        return -VTD_FR_PASID_TABLE_ENTRY_INV;
     }
 
-    if (!vtd_is_level_supported(s, VTD_PE_GET_LEVEL(pe))) {
-        return -VTD_FR_PASID_TABLE_INV;
+    pgtt = VTD_PE_GET_TYPE(pe);
+    if (pgtt == VTD_SM_PASID_ENTRY_SLT &&
+        !vtd_is_level_supported(s, VTD_PE_GET_LEVEL(pe))) {
+            return -VTD_FR_PASID_TABLE_ENTRY_INV;
     }
 
     return 0;
@@ -876,7 +879,7 @@ static int vtd_get_pe_from_pasid_table(IntelIOMMUState *s,
     }
 
     if (!vtd_pdire_present(&pdire)) {
-        return -VTD_FR_PASID_TABLE_INV;
+        return -VTD_FR_PASID_DIR_ENTRY_P;
     }
 
     ret = vtd_get_pe_from_pdire(s, pasid, &pdire, pe);
@@ -885,7 +888,7 @@ static int vtd_get_pe_from_pasid_table(IntelIOMMUState *s,
     }
 
     if (!vtd_pe_present(pe)) {
-        return -VTD_FR_PASID_TABLE_INV;
+        return -VTD_FR_PASID_ENTRY_P;
     }
 
     return 0;
@@ -938,7 +941,7 @@ static int vtd_ce_get_pasid_fpd(IntelIOMMUState *s,
     }
 
     if (!vtd_pdire_present(&pdire)) {
-        return -VTD_FR_PASID_TABLE_INV;
+        return -VTD_FR_PASID_DIR_ENTRY_P;
     }
 
     /*
@@ -1795,7 +1798,11 @@ static const bool vtd_qualified_faults[] = {
     [VTD_FR_ROOT_ENTRY_RSVD] = false,
     [VTD_FR_PAGING_ENTRY_RSVD] = true,
     [VTD_FR_CONTEXT_ENTRY_TT] = true,
-    [VTD_FR_PASID_TABLE_INV] = false,
+    [VTD_FR_PASID_DIR_ACCESS_ERR] = false,
+    [VTD_FR_PASID_DIR_ENTRY_P] = true,
+    [VTD_FR_PASID_TABLE_ACCESS_ERR] = false,
+    [VTD_FR_PASID_ENTRY_P] = true,
+    [VTD_FR_PASID_TABLE_ENTRY_INV] = true,
     [VTD_FR_SM_INTERRUPT_ADDR] = true,
     [VTD_FR_MAX] = false,
 };
-- 
MST


