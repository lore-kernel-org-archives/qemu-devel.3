Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67F0C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegdZ-0007v7-It; Tue, 30 Jun 2026 18:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wegct-00077A-Fs
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:08:19 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wegcp-0005tt-VF
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:08:19 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UKtmqZ1252859; Tue, 30 Jun 2026 22:08:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=645Tf
 vzesUp3Di2aVWeUFo+Xd5Fg6DnwGsMTXCF/Mrs=; b=jpKaHkrqWkgvxGwaeuRvh
 YB+EQz+LUh18E/mwlrl84HyfLNlE5bwbyz5epo4flX9mZeZeSO4IJFajoBy+S4Gj
 UWS3FFEUI9bUW/5Tmm6LchWw8wDDzp1tESXmIZf2l8iKpw6UasW+F7ymjeVMgQk0
 lZzpZICKoeTILQhg3bpi0kWYdmzR9l9fQvQHPZJ3ULvpHSYmvJOJ8wcL4EKwuXJA
 H7daTKCKfGI1/Tw1ex2sDTWipp63zv1mBiK1WYLvepCtwhdf/nhTnNqEFGRGd4Cr
 MoGlz9KqDaimuruXTxSMPShkXHjYPawTehw4ESzItwYGvz/aMJKUn4Qinm1dnl0H
 A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f26p8n6me-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 22:08:09 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 65UM3Zx5034546; Tue, 30 Jun 2026 22:08:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4f3u1w75wt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 22:08:09 +0000 (GMT)
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65UM87gL008507;
 Tue, 30 Jun 2026 22:08:08 GMT
Received: from alaljime-e5-test-20240903-1847.osdevelopmeniad.oraclevcn.com
 (alaljime-e5-test-20240903-1847.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.250.206])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4f3u1w75vm-5; Tue, 30 Jun 2026 22:08:08 +0000 (GMT)
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: mst@redhat.com, qemu-devel@nongnu.org
Cc: sarunkod@amd.com, qemu@demindiro.com, imammedo@redhat.com,
 peter.maydell@linaro.org, philmd@oss.qualcomm.com,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH 4/5] amd_iommu: Decode IRTEs without bitfields
Date: Tue, 30 Jun 2026 22:08:05 +0000
Message-ID: <20260630220806.1758748-5-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630220806.1758748-1-alejandro.j.jimenez@oracle.com>
References: <20260630220806.1758748-1-alejandro.j.jimenez@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=927 suspectscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2606300215
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfXwupzoWUUkgw6
 o4AS7m11xS6SjD4ql2UuUP4BXlEHN5UPtbTh77ERO4l8E8MBt8Z5MQbdJT1oHtJG6TnvSD9YB45
 HNU832PJOu+XVjzuWSlcwypFeArzx3HlebogBfgpSbu0POEMni/R
X-Proofpoint-GUID: kTkTa2l1tr4Cu6vtgC2Jd3UVR6JE9i6Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNSBTYWx0ZWRfX4le8XeNqOPFt
 BxyiF+UM2nZ4V8xFILmHwFfetiqojM6oa3OKa/Sg0WSDN4zJIEJkAqXi4wKGsWIJtdWHfmevaYA
 +rm6XkXscZ4Gej/8vECEVsAanxii1a5s5Odi4gyDxMalHLWbVYEvegZ452l/CdMMo2pi8/IWYha
 oUkU9QOAlTsuAbzMJ9Ww93lLh3B49ZyQPWwpArjvj+ne1NwzX3tqArFw+y6np4oNxh3bwzMd1h0
 kFgPmC6hxEpreGX7lhilfyhty7wt02b0+XymPD4xZyqv1eSjQegKhFYP8B6zc+MfO2q2tbve3ux
 pYlOopRNP3MnQwjdXw5HYwfQ0RjJsuzCNHeVsOkmHU0k/Md+WiP7Yh1VL9QoIzjxTdVANgRYl+v
 PZL6/9uJ5tdCr92fZOqS59rW67nyYZxFtiq0ZHOROk+rfW2Yg+P9wGMQ6z/6Hu/msXgCiJ8xxHS
 4b7CdcFC3dZrS+jSfoiekHRXmQslBfSBJn7wKj18=
X-Proofpoint-ORIG-GUID: kTkTa2l1tr4Cu6vtgC2Jd3UVR6JE9i6Z
X-Authority-Analysis: v=2.4 cv=D5N37PRj c=1 sm=1 tr=0 ts=6a443e49 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=KKAkSRfTAAAA:8 a=yPCof4ZbAAAA:8
 a=iN8GYCbXJNbl4wqCgcoA:9 a=cvBusfyB2V15izCimMoJ:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12313
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Interrupt remapping table entries are data stored in guest memory in
little-endian format. Decoding them with bitfields depends on host bitfield
layout and the value returned from dma_memory_read() is not portable to
big-endian hosts.

Replace the legacy and GA IRTE bitfield definitions with explicit FIELD()
definitions. Convert the guest memory values returned from dma_memory_read()
with le32_to_cpu() or le64_to_cpu(), then extract relevant fields using
FIELD_EX32() or FIELD_EX64() as appropriate to match the IRTE format.

Fixes: b44159fe0078 ("x86_iommu/amd: Add interrupt remap support when VAPIC is not enabled")
Fixes: 135f866e609c ("x86_iommu/amd: Add interrupt remap support when VAPIC is enabled")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/i386/amd_iommu.c | 93 +++++++++++++++++++++++++++++++++------------
 hw/i386/amd_iommu.h | 49 ------------------------
 2 files changed, 69 insertions(+), 73 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 291cb368a9..c7bf21b762 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -89,6 +89,11 @@ typedef struct AMDVIIOTLBKey {
     uint16_t devid;
 } AMDVIIOTLBKey;
 
+typedef struct AMDVIIrteGA {
+    uint64_t ga_lo;
+    uint64_t ga_hi;
+} AMDVIIrteGA;
+
 /* XT IOMMU General Interrupt Control Register layout */
 FIELD(AMDVI_XT_GEN_INTR, DEST_MODE, 2, 1)
 FIELD(AMDVI_XT_GEN_INTR, DEST_LO, 8, 24)
@@ -96,6 +101,37 @@ FIELD(AMDVI_XT_GEN_INTR, VECTOR, 32, 8)
 FIELD(AMDVI_XT_GEN_INTR, DELIVERY_MODE, 40, 1)
 FIELD(AMDVI_XT_GEN_INTR, DEST_HI, 56, 8)
 
+/* Interrupt Remapping Table Fields Formats */
+
+/* Basic 32-bit IRTE layout (GAEn=0) */
+FIELD(AMDVI_IRTE, VALID, 0, 1)
+FIELD(AMDVI_IRTE, SUP_IOPF, 1, 1)
+FIELD(AMDVI_IRTE, INT_TYPE, 2, 3)
+FIELD(AMDVI_IRTE, RQ_EOI, 5, 1)
+FIELD(AMDVI_IRTE, DM, 6, 1)
+FIELD(AMDVI_IRTE, GUEST_MODE, 7, 1)
+FIELD(AMDVI_IRTE, DESTINATION, 8, 8)
+FIELD(AMDVI_IRTE, VECTOR, 16, 8)
+
+/* 128-bit IRTE layout (GAEn=1) */
+FIELD(AMDVI_IRTE_GA_LO, VALID, 0, 1)
+FIELD(AMDVI_IRTE_GA_LO, SUP_IOPF, 1, 1)
+FIELD(AMDVI_IRTE_GA_LO, INT_TYPE, 2, 3)
+FIELD(AMDVI_IRTE_GA_LO, RQ_EOI, 5, 1)
+FIELD(AMDVI_IRTE_GA_LO, DM, 6, 1)
+FIELD(AMDVI_IRTE_GA_LO, GUEST_MODE, 7, 1)
+/*
+ * In the 128-bit IRTE format, XT mode uses IRTE_GA_LOW.Destination[23:0]
+ * together with IRTE_GA_HI.DestinationHi[7:0] to construct a 32-bit x2APIC
+ * destination.
+ * Without XTEn (i.e. when x2APIC support is not enabled), only
+ * IRTE_GA_LOW.Destination[7:0] is used.
+ */
+FIELD(AMDVI_IRTE_GA_LO, DESTINATION, 8, 24)
+
+FIELD(AMDVI_IRTE_GA_HI, VECTOR, 0, 8)
+FIELD(AMDVI_IRTE_GA_HI, DESTINATION_HI, 56, 8)
+
 uint64_t amdvi_extended_feature_register(AMDVIState *s)
 {
     uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
@@ -1983,7 +2019,7 @@ static IOMMUTLBEntry amdvi_translate(IOMMUMemoryRegion *iommu, hwaddr addr,
 }
 
 static int amdvi_get_irte(AMDVIState *s, MSIMessage *origin, uint64_t *dte,
-                          union irte *irte, uint16_t devid)
+                          uint32_t *irte, uint16_t devid)
 {
     uint64_t irte_root, offset;
 
@@ -1998,7 +2034,8 @@ static int amdvi_get_irte(AMDVIState *s, MSIMessage *origin, uint64_t *dte,
         return -AMDVI_IR_GET_IRTE;
     }
 
-    trace_amdvi_ir_irte_val(irte->val);
+    *irte = le32_to_cpu(*irte);
+    trace_amdvi_ir_irte_val(*irte);
 
     return 0;
 }
@@ -2010,8 +2047,9 @@ static int amdvi_int_remap_legacy(AMDVIState *iommu,
                                   X86IOMMUIrq *irq,
                                   uint16_t sid)
 {
+    uint8_t int_type;
+    uint32_t irte;
     int ret;
-    union irte irte;
 
     /* get interrupt remapping table */
     ret = amdvi_get_irte(iommu, origin, dte, &irte, sid);
@@ -2019,32 +2057,33 @@ static int amdvi_int_remap_legacy(AMDVIState *iommu,
         return ret;
     }
 
-    if (!irte.fields.valid) {
+    if (!FIELD_EX32(irte, AMDVI_IRTE, VALID)) {
         trace_amdvi_ir_target_abort("RemapEn is disabled");
         return -AMDVI_IR_TARGET_ABORT;
     }
 
-    if (irte.fields.guest_mode) {
+    if (FIELD_EX32(irte, AMDVI_IRTE, GUEST_MODE)) {
         error_report_once("guest mode is not zero");
         return -AMDVI_IR_ERR;
     }
 
-    if (irte.fields.int_type > AMDVI_IOAPIC_INT_TYPE_ARBITRATED) {
+    int_type = FIELD_EX32(irte, AMDVI_IRTE, INT_TYPE);
+    if (int_type > AMDVI_IOAPIC_INT_TYPE_ARBITRATED) {
         error_report_once("reserved int_type");
         return -AMDVI_IR_ERR;
     }
 
-    irq->delivery_mode = irte.fields.int_type;
-    irq->vector = irte.fields.vector;
-    irq->dest_mode = irte.fields.dm;
-    irq->redir_hint = irte.fields.rq_eoi;
-    irq->dest = irte.fields.destination;
+    irq->delivery_mode = int_type;
+    irq->vector = FIELD_EX32(irte, AMDVI_IRTE, VECTOR);
+    irq->dest_mode = FIELD_EX32(irte, AMDVI_IRTE, DM);
+    irq->redir_hint = FIELD_EX32(irte, AMDVI_IRTE, RQ_EOI);
+    irq->dest = FIELD_EX32(irte, AMDVI_IRTE, DESTINATION);
 
     return 0;
 }
 
 static int amdvi_get_irte_ga(AMDVIState *s, MSIMessage *origin, uint64_t *dte,
-                             struct irte_ga *irte, uint16_t devid)
+                             AMDVIIrteGA *irte, uint16_t devid)
 {
     uint64_t irte_root, offset;
 
@@ -2058,7 +2097,9 @@ static int amdvi_get_irte_ga(AMDVIState *s, MSIMessage *origin, uint64_t *dte,
         return -AMDVI_IR_GET_IRTE;
     }
 
-    trace_amdvi_ir_irte_ga_val(irte->hi.val, irte->lo.val);
+    irte->ga_lo = le64_to_cpu(irte->ga_lo);
+    irte->ga_hi = le64_to_cpu(irte->ga_hi);
+    trace_amdvi_ir_irte_ga_val(irte->ga_hi, irte->ga_lo);
     return 0;
 }
 
@@ -2069,8 +2110,9 @@ static int amdvi_int_remap_ga(AMDVIState *iommu,
                               X86IOMMUIrq *irq,
                               uint16_t sid)
 {
+    AMDVIIrteGA irte;
+    uint8_t int_type;
     int ret;
-    struct irte_ga irte;
 
     /* get interrupt remapping table */
     ret = amdvi_get_irte_ga(iommu, origin, dte, &irte, sid);
@@ -2078,30 +2120,33 @@ static int amdvi_int_remap_ga(AMDVIState *iommu,
         return ret;
     }
 
-    if (!irte.lo.fields_remap.valid) {
+    if (!FIELD_EX64(irte.ga_lo, AMDVI_IRTE_GA_LO, VALID)) {
         trace_amdvi_ir_target_abort("RemapEn is disabled");
         return -AMDVI_IR_TARGET_ABORT;
     }
 
-    if (irte.lo.fields_remap.guest_mode) {
+    if (FIELD_EX64(irte.ga_lo, AMDVI_IRTE_GA_LO, GUEST_MODE)) {
         error_report_once("guest mode is not zero");
         return -AMDVI_IR_ERR;
     }
 
-    if (irte.lo.fields_remap.int_type > AMDVI_IOAPIC_INT_TYPE_ARBITRATED) {
+    int_type = FIELD_EX64(irte.ga_lo, AMDVI_IRTE_GA_LO, INT_TYPE);
+    if (int_type > AMDVI_IOAPIC_INT_TYPE_ARBITRATED) {
         error_report_once("reserved int_type is set");
         return -AMDVI_IR_ERR;
     }
 
-    irq->delivery_mode = irte.lo.fields_remap.int_type;
-    irq->vector = irte.hi.fields.vector;
-    irq->dest_mode = irte.lo.fields_remap.dm;
-    irq->redir_hint = irte.lo.fields_remap.rq_eoi;
+    irq->delivery_mode = int_type;
+    irq->vector = FIELD_EX64(irte.ga_hi, AMDVI_IRTE_GA_HI, VECTOR);
+    irq->dest_mode = FIELD_EX64(irte.ga_lo, AMDVI_IRTE_GA_LO, DM);
+    irq->redir_hint = FIELD_EX64(irte.ga_lo, AMDVI_IRTE_GA_LO, RQ_EOI);
     if (iommu->xten) {
-        irq->dest = irte.lo.fields_remap.destination |
-                    (irte.hi.fields.destination_hi << 24);
+        irq->dest = FIELD_EX64(irte.ga_lo, AMDVI_IRTE_GA_LO, DESTINATION) |
+                    (FIELD_EX64(irte.ga_hi, AMDVI_IRTE_GA_HI, DESTINATION_HI)
+                    << 24);
     } else {
-        irq->dest = irte.lo.fields_remap.destination & 0xff;
+        irq->dest = FIELD_EX64(irte.ga_lo, AMDVI_IRTE_GA_LO, DESTINATION) &
+                    0xff;
     }
 
     return 0;
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index ca4440a4c1..687691ec1c 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -291,55 +291,6 @@
 #define AMDVI_DEV_LINT0_PASS_MASK       (1ULL << 62)
 #define AMDVI_DEV_LINT1_PASS_MASK       (1ULL << 63)
 
-/* Interrupt remapping table fields (Guest VAPIC not enabled) */
-union irte {
-    uint32_t val;
-    struct {
-        uint32_t valid:1,
-                 no_fault:1,
-                 int_type:3,
-                 rq_eoi:1,
-                 dm:1,
-                 guest_mode:1,
-                 destination:8,
-                 vector:8,
-                 rsvd:8;
-    } fields;
-};
-
-/* Interrupt remapping table fields (Guest VAPIC is enabled) */
-union irte_ga_lo {
-  uint64_t val;
-
-  /* For int remapping */
-  struct {
-      uint64_t  valid:1,
-                no_fault:1,
-                /* ------ */
-                int_type:3,
-                rq_eoi:1,
-                dm:1,
-                /* ------ */
-                guest_mode:1,
-                destination:24,
-                rsvd_1:32;
-  } fields_remap;
-};
-
-union irte_ga_hi {
-  uint64_t val;
-  struct {
-      uint64_t  vector:8,
-                rsvd_2:48,
-                destination_hi:8;
-  } fields;
-};
-
-struct irte_ga {
-  union irte_ga_lo lo;
-  union irte_ga_hi hi;
-};
-
 #define TYPE_AMD_IOMMU_DEVICE "amd-iommu"
 OBJECT_DECLARE_SIMPLE_TYPE(AMDVIState, AMD_IOMMU_DEVICE)
 
-- 
2.47.3


