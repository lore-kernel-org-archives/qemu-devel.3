Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED064C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY7s3-0005kb-4s; Wed, 15 Jan 2025 13:12:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7pV-0006cx-75
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:09:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tY7pT-0006cO-IH
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:09:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736964563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yUuOMI9pfBriuw1YERiIKw5x8dB/u/FGXCgcdZJucXc=;
 b=JnSLgxo9FOoDVnMXeD+jlOrQGUDjlg7P4ZMChVFo1N+UX6I3zvltKrIqfJcvzl0MmNMz6s
 enXjAyymgVum2MwbwPyvRR8ke4PKOoKHBA41xN0Sw19mbIY7zJpLaqLpitzl0U/pMXGHng
 H8W9rYrEGL9cLKAjcnTzWeGh1jmNyv8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-gfFyaFlKPgCbUcoPmMp7Kw-1; Wed, 15 Jan 2025 13:09:15 -0500
X-MC-Unique: gfFyaFlKPgCbUcoPmMp7Kw-1
X-Mimecast-MFC-AGG-ID: gfFyaFlKPgCbUcoPmMp7Kw
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-436289a570eso32469415e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:09:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736964554; x=1737569354;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yUuOMI9pfBriuw1YERiIKw5x8dB/u/FGXCgcdZJucXc=;
 b=kevC4j0yh3e2zp1O+bo0X2oeQqvcchy9cVpt3XdBNIyzSIn8xqN7pkdin2IO1jOcxb
 KyfowI9PeWVFaaIWTddk1rxB7uqsLnxBpFcpigIk4ttUTU9bg3ZvEafPYix/i9NSmfB9
 fQ4aDNI06p9Ai4uWb9rAYiUojZQL5tGBx9VMs0O1AUDf8vuIp+c/4ciSPGYa5FgoKg0t
 wvTsgwo5CC4TtncAC8f4cS9u1nju7ZL4k4fbq1KCVEKa5RqA32wiWhHsxbHgBtZe9mE4
 m+ys2GtvSloX0JF7IPBteEjMF6KGWg96SpKqCU3FWQscoFjZ6+2P2kP8gsLE8SUnSDKD
 MfSQ==
X-Gm-Message-State: AOJu0Yw51C6jODsv10IxFM5Z51zIQKjt7tZsQTEi+OCkG3AOmTZKlPsH
 DgdE39qWuG67TfP3imrTx/kB/USP7l501fyW/vYbkkTiw6d8IuEV3fUyG1JDrko51K2XadmwOu1
 uzFp17fZp12uLGze1bvcFsvEv68XJdcusyfXTlIOsTLFyet3mVcv8CthmEoBMuCqaM0/2HZwgA2
 aUoNuXXKDS5gSuSPhddWrhmrvKgruXKg==
X-Gm-Gg: ASbGncux5kqQO9bJuIkN2TpqIgKtu176AaCyTuyNtlZgh1iCYNXv4MldQXNBDPD2TPT
 SwhYae923iXpZbwShZc8Ae0FTBqhT3TFx5QlreSfVcR+Wbt2qsHeZJCgKIdKpwhMS5Z1menqHTg
 +dOfaAT3aBHcsN1Zxdr1Wm4N+QpWjbVnAAD/nMlmRdhkkZae2+41/5IjpRyfRn1VU4Fbivkoj06
 hf7omVzsyCRZu7vF7WizgwYeSiEUYC0VRW3pLLVqWUlthr01C1V
X-Received: by 2002:a05:600c:1d03:b0:434:a781:f5d9 with SMTP id
 5b1f17b1804b1-436e2697b32mr267376865e9.11.1736964554100; 
 Wed, 15 Jan 2025 10:09:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIneviXe17E+o3PnIig6VgM4OSau0R4EuAn4Q68ISo5oYe0VQd0Zlj4WjPCyDIeDVJQrnMZQ==
X-Received: by 2002:a05:600c:1d03:b0:434:a781:f5d9 with SMTP id
 5b1f17b1804b1-436e2697b32mr267376405e9.11.1736964553624; 
 Wed, 15 Jan 2025 10:09:13 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74c57ebsm30955795e9.20.2025.01.15.10.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:09:13 -0800 (PST)
Date: Wed, 15 Jan 2025 13:09:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 14/48] intel_iommu: Set accessed and dirty bits during stage-1
 translation
Message-ID: <65c4f0999991f6321d6a369fa56c81c57c5b87ad.1736964488.git.mst@redhat.com>
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

From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>

Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20241212083757.605022-10-zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu_internal.h |  3 +++
 hw/i386/intel_iommu.c          | 25 ++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 3e7365dfff..22dd3faf0c 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -332,6 +332,7 @@ typedef enum VTDFaultReason {
 
     /* Output address in the interrupt address range for scalable mode */
     VTD_FR_SM_INTERRUPT_ADDR = 0x87,
+    VTD_FR_FS_BIT_UPDATE_FAILED = 0x91, /* SFS.10 */
     VTD_FR_MAX,                 /* Guard */
 } VTDFaultReason;
 
@@ -564,6 +565,8 @@ typedef struct VTDRootEntry VTDRootEntry;
 #define VTD_FL_P                    1ULL
 #define VTD_FL_RW                   (1ULL << 1)
 #define VTD_FL_US                   (1ULL << 2)
+#define VTD_FL_A                    (1ULL << 5)
+#define VTD_FL_D                    (1ULL << 6)
 
 /* Second Level Page Translation Pointer*/
 #define VTD_SM_PASID_ENTRY_SLPTPTR     (~0xfffULL)
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index d53ce01e82..0aeb0dbde9 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1806,6 +1806,7 @@ static const bool vtd_qualified_faults[] = {
     [VTD_FR_FS_PAGING_ENTRY_US] = true,
     [VTD_FR_SM_WRITE] = true,
     [VTD_FR_SM_INTERRUPT_ADDR] = true,
+    [VTD_FR_FS_BIT_UPDATE_FAILED] = true,
     [VTD_FR_MAX] = false,
 };
 
@@ -1925,6 +1926,20 @@ static bool vtd_iova_fl_check_canonical(IntelIOMMUState *s, uint64_t iova,
     }
 }
 
+static MemTxResult vtd_set_flag_in_pte(dma_addr_t base_addr, uint32_t index,
+                                       uint64_t pte, uint64_t flag)
+{
+    if (pte & flag) {
+        return MEMTX_OK;
+    }
+    pte |= flag;
+    pte = cpu_to_le64(pte);
+    return dma_memory_write(&address_space_memory,
+                            base_addr + index * sizeof(pte),
+                            &pte, sizeof(pte),
+                            MEMTXATTRS_UNSPECIFIED);
+}
+
 /*
  * Given the @iova, get relevant @flptep. @flpte_level will be the last level
  * of the translation, can be used for deciding the size of large page.
@@ -1938,7 +1953,7 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
     dma_addr_t addr = vtd_get_iova_pgtbl_base(s, ce, pasid);
     uint32_t level = vtd_get_iova_level(s, ce, pasid);
     uint32_t offset;
-    uint64_t flpte;
+    uint64_t flpte, flag_ad = VTD_FL_A;
 
     if (!vtd_iova_fl_check_canonical(s, iova, ce, pasid)) {
         error_report_once("%s: detected non canonical IOVA (iova=0x%" PRIx64 ","
@@ -1985,6 +2000,14 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
             return -VTD_FR_FS_PAGING_ENTRY_RSVD;
         }
 
+        if (vtd_is_last_pte(flpte, level) && is_write) {
+            flag_ad |= VTD_FL_D;
+        }
+
+        if (vtd_set_flag_in_pte(addr, offset, flpte, flag_ad) != MEMTX_OK) {
+            return -VTD_FR_FS_BIT_UPDATE_FAILED;
+        }
+
         if (vtd_is_last_pte(flpte, level)) {
             *flptep = flpte;
             *flpte_level = level;
-- 
MST


