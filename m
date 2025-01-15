Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E021C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7pX-0006bD-P0; Wed, 15 Jan 2025 13:09:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7pK-0006Rl-5y
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:09:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7pI-0006Yb-Lt
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:09:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yUynNl6G6n93MWB/hyqu1Gtvpusp5dtT/74ynqqHtUo=;
 b=F5DKYqjVyCYvijqMsYKai7xiZDJ2D49IiMmthMpI8BQd5EhJ7Gdz7fyhNOIFUw3A1WpP0C
 qitO7TblGONZHVSRXuN2sS+mPx1RuspI5zHgOD/sAY3/GyoER3Fvf38DIu0gSsi+XbNC6h
 hUD5JV59EEeAjNNDsTIUM77vna5oAb8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-elZhT-bhP2KefnbKFZhA0g-1; Wed, 15 Jan 2025 13:09:09 -0500
X-MC-Unique: elZhT-bhP2KefnbKFZhA0g-1
X-Mimecast-MFC-AGG-ID: elZhT-bhP2KefnbKFZhA0g
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-386333ea577so38950f8f.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:09:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964547; x=1737569347;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yUynNl6G6n93MWB/hyqu1Gtvpusp5dtT/74ynqqHtUo=;
 b=RCwbCa4uT4NveddeZWieNHoeGtd7C6wYKSzcBUgshBqEuSkqAq7rgTT4zXKum4T56y
 HkFaF4GkuZs4A57mNf56oVB9LzuPzFOrMALKNwGZIMyaQyPI//9v/dE/qNAmJqeLRgv2
 Gq360/5cT37swXCOftFZWt0+5idlNc1L4igpYGkXLZcmHhZbpOyKwM1duxNKJ0u42naG
 A76djWoIzWwVgRiq9MD0qL+AIf2lKHKNj8Zp/Pz1RuKVomqfGWZQ31yhBzNfW8Ko3Qfk
 k03dhSiQtQtAZhWiq89LMp3ALuYsrOa2+eXG0g4CIt6JUugmyIE6XTBuaO6Qzzq4hr1C
 X+BQ==
X-Gm-Message-State: AOJu0Yy25Kr++h6A2RmZrFj053N2/oJZQZm1cHcbathx8AWHYL/hCF1L
 9lKe40FNE/pgtagzGaNaplFeV4XnViLHnJCYLn/M5zqHh1mMaMmeALh8wSTDCwRu6rW+b08if2M
 p/f3ueEKuYQl74B604MvQXgXGWhlpBNCtupiSRdkoIdUfTx502kBLAuaH+rMYTk9kgotU28MHDV
 BnWdhio5Xi1mxPk2Bq//HxWeugzMM5hQ==
X-Gm-Gg: ASbGncsMAZnIXPcgGLjt5ib4of3a8FL6iEa+dJus7hMvL9CnJ83Ab1crgZTkS2T1X3X
 tv2PkzW2gx13wVyfMfUdYO4wo4IlQ/1ahYsbBP65BbheZjEGVL/YHmqaw/rhp+l7jpLw/ATqNbT
 fMjQXoNum+P9MKlgsPhe1XAxCppBO4Ol4kTGj5rqSYg2zhDvml857Yelo0YlNdx/BjYzht0VrCA
 uMFRyLDT2le64sihLG4Y/Cs1PP+V16n08oOVyh3aqYjlhGVDAT6
X-Received: by 2002:a05:6000:18a3:b0:385:e1eb:a7af with SMTP id
 ffacd0b85a97d-38a873152c0mr32361717f8f.48.1736964547444; 
 Wed, 15 Jan 2025 10:09:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFI91oLDp0iaiN+0oUY8sFZ5Kux1uu+iOHQuUsla5sCW7g6aZUTWd+StvMOz+tqzBbYvsAZJw==
X-Received: by 2002:a05:6000:18a3:b0:385:e1eb:a7af with SMTP id
 ffacd0b85a97d-38a873152c0mr32361683f8f.48.1736964547033; 
 Wed, 15 Jan 2025 10:09:07 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d012sm18213801f8f.8.2025.01.15.10.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:09:06 -0800 (PST)
Date: Wed, 15 Jan 2025 13:09:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 12/48] intel_iommu: Check if the input address is canonical
Message-ID: <305e469b7188e5f1a896c40853d84fa158ee6ba4.1736964488.git.mst@redhat.com>
References: <cover.1736964487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1736964487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Stage-1 translation must fail if the address to translate is
not canonical.

Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Message-Id: <20241212083757.605022-8-zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu_internal.h |  1 +
 hw/i386/intel_iommu.c          | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 86d3354198..3e7365dfff 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -326,6 +326,7 @@ typedef enum VTDFaultReason {
     /* Non-zero reserved field in present first-stage paging entry */
     VTD_FR_FS_PAGING_ENTRY_RSVD = 0x72,
     VTD_FR_PASID_ENTRY_FSPTPTR_INV = 0x73, /* Invalid FSPTPTR in PASID entry */
+    VTD_FR_FS_NON_CANONICAL = 0x80, /* SNG.1 : Address for FS not canonical.*/
     VTD_FR_FS_PAGING_ENTRY_US = 0x81,      /* Privilege violation */
     VTD_FR_SM_WRITE = 0x85,                /* No write permission */
 
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index bd6de71c02..3959fe44c7 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1824,6 +1824,7 @@ static const bool vtd_qualified_faults[] = {
     [VTD_FR_FS_PAGING_ENTRY_P] = true,
     [VTD_FR_FS_PAGING_ENTRY_RSVD] = true,
     [VTD_FR_PASID_ENTRY_FSPTPTR_INV] = true,
+    [VTD_FR_FS_NON_CANONICAL] = true,
     [VTD_FR_FS_PAGING_ENTRY_US] = true,
     [VTD_FR_SM_WRITE] = true,
     [VTD_FR_SM_INTERRUPT_ADDR] = true,
@@ -1930,6 +1931,22 @@ static inline bool vtd_flpte_present(uint64_t flpte)
     return !!(flpte & VTD_FL_P);
 }
 
+/* Return true if IOVA is canonical, otherwise false. */
+static bool vtd_iova_fl_check_canonical(IntelIOMMUState *s, uint64_t iova,
+                                        VTDContextEntry *ce, uint32_t pasid)
+{
+    uint64_t iova_limit = vtd_iova_limit(s, ce, s->aw_bits, pasid);
+    uint64_t upper_bits_mask = ~(iova_limit - 1);
+    uint64_t upper_bits = iova & upper_bits_mask;
+    bool msb = ((iova & (iova_limit >> 1)) != 0);
+
+    if (msb) {
+        return upper_bits == upper_bits_mask;
+    } else {
+        return !upper_bits;
+    }
+}
+
 /*
  * Given the @iova, get relevant @flptep. @flpte_level will be the last level
  * of the translation, can be used for deciding the size of large page.
@@ -1945,6 +1962,12 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
     uint32_t offset;
     uint64_t flpte;
 
+    if (!vtd_iova_fl_check_canonical(s, iova, ce, pasid)) {
+        error_report_once("%s: detected non canonical IOVA (iova=0x%" PRIx64 ","
+                          "pasid=0x%" PRIx32 ")", __func__, iova, pasid);
+        return -VTD_FR_FS_NON_CANONICAL;
+    }
+
     while (true) {
         offset = vtd_iova_level_offset(iova, level);
         flpte = vtd_get_pte(addr, offset);
-- 
MST


