Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71122606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QUc+7IHh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTex-0006Bi-Lt; Thu, 29 Oct 2026 13:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1xMTet-0006AD-6k; Thu, 29 Oct 2026 13:11:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1xMTej-0007yv-Ka; Thu, 29 Oct 2026 13:11:22 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGECR4409668; Thu, 29 Oct 2026 17:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3uOULY
 wrxB7QIHTJKSmZv1L/KiXx7qwnlQSv+vdCtDA=; b=QUc+7IHh1BNhPV8J2hgjFy
 zp93s3ZJ+GRoqbbCokigQ6PI+UgKXYwtmBrNhkozlsfIteazM31GgL8+bo/vlNv+
 VZu0bkT1YLrSya1PzK1mZGN+eOgR8Zc/yzlWpEz+QjNgnKrlrUckimDubYxBXsia
 fUOrBJiIOz31Jdb+FNXxqbj2LzQdLhCABTndDQtIQ9J4cxdc4ceuKcE81hgaZbgO
 qW4j0UVDZQb7Pqjjdd4NJ2mXNcoK7hd3DMfXI4InNNPwmkwQ49BOmnVY68UbME82
 kt15u7uU5MwaAmzZFc8S7vGjCCX5zN2uyRh7EnYJUYs6eOJCIPMb023fhLPLAa0Q
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgj3mkt6t-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:11:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGK4C33393195; Thu, 29 Oct 2026 17:11:04 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hm69e1677-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:11:04 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69THB3pk27591196
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Oct 2026 17:11:03 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 45C7358045;
 Thu, 29 Oct 2026 17:11:03 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE0AD58052;
 Thu, 29 Oct 2026 17:11:01 +0000 (GMT)
Received: from gfwr526.rchland.ibm.com (unknown [9.10.239.119])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Oct 2026 17:11:01 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, milesg@linux.ibm.com,
 jishnuvw@linux.ibm.com, adityag@linux.ibm.com, amachhiw@linux.ibm.com
Subject: [PATCH v7 RESEND 5/9] pnv/phb5: Implement write-clear and return 1's
 on unimplemented reg read
Date: Thu, 29 Oct 2026 12:10:43 -0500
Message-ID: <20261029171047.3862430-6-saif.abrar@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261029171047.3862430-1-saif.abrar@linux.ibm.com>
References: <20261029171047.3862430-1-saif.abrar@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2NSBTYWx0ZWRfX3kGXn4GOdRvP
 LU9+xvyTYF5W+IwvDLBmbBDeAu4EN6G9AX0PaC8VhTxzOK6Orb8ul81uQqA/3uQ2C4kfUJJalmr
 qRmDgE7IFezXQ7EkRa2nmDp7qhuSfp8=
X-Proofpoint-ORIG-GUID: Y-NctQjMynob3nEa8qTfI4FTld0NWuYj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2NSBTYWx0ZWRfX7tzJSISSBWXL
 V0LCqNPxILGRdHNk0rhGma/VB2ClYAsccQ8DMqU+eFV6CyXd+9F2MWcrG1w+nMyipHjyAILAsxw
 cLPGVk+wK7Alouyr+Dh6vytW58l1tnuehnbri72Rea9bG9qTOpfYvD3BfFfkUPqpCK9MhGSF+dM
 rrscr+bsolMOfwbSB8B9jEqYwiPSP/YUQN5t7tN6m0raxf+dwJfELNTIZKHAPNxvcGe8Y1e7dz/
 C5+OJHs8EXVodSpKGKRZknRkzRTAwB9eFxWhkQctDcOqGxvvG0WBQAbftDpJlQmNOOZ/OIq+4eA
 iLWVJvDXU+nc6KG3sjoZIKh5eTbzAuMNrqmAfvHbog79EW+xmrgzHVcluPciwnpLmXPL1M5yx5R
 XecIvsRg6fx2ZQwaXMCGVTUzOcAnEQ==
X-Authority-Analysis: v=2.4 cv=G7uJgNk5 c=1 sm=1 tr=0 ts=6ae37e29 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=5RaDrMxcQoNUQC0trd8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-GUID: jmh2cNwxFPeXObvedT59-TXurabHATQh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610190000 definitions=main-2610290065
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=saif.abrar@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>

Implement write-1-to-clear and write-X-to-clear logic.
Update registers with silent simple read and write.
Return all 1's when an unimplemented/reserved register is read.

Test that reading address 0x0 returns all 1's (i.e. -1).

Signed-off-by: Saif Abrar <saif.abrar@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
---
 hw/pci-host/pnv_phb4.c              | 201 ++++++++++++++++++++++------
 hw/pci-host/pnv_phb5.c              | 110 ++++++++++++++-
 include/hw/pci-host/pnv_phb4.h      |   3 +
 include/hw/pci-host/pnv_phb4_regs.h |  14 +-
 include/hw/pci-host/pnv_phb5.h      |  17 ++-
 tests/qtest/pnv-phb-test.c          |  14 +-
 6 files changed, 304 insertions(+), 55 deletions(-)

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 918842abfa..5aa63f00fa 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -1,7 +1,7 @@
 /*
  * QEMU PowerPC PowerNV (POWER9) PHB4 model
  *
- * Copyright (c) 2018-2026, IBM Corporation.
+ * Copyright (c) 2018-2025, IBM Corporation.
  *
  * This code is licensed under the GPL version 2 or later. See the
  * COPYING file in the top-level directory.
@@ -543,6 +543,10 @@ void pnv_phb4_cfg_core_reset(PCIDevice *d)
     RC_CONFIG_STICKY_RESET(PHB_AER_RERR,      0,    0x7F);
     RC_CONFIG_STICKY_RESET(PHB_AER_ESID,      0,    0xFFFFFFFF);
     RC_CONFIG_STICKY_RESET(PHB_DLF_STAT,      0,    0x807FFFFF);
+    RC_CONFIG_STICKY_RESET(P16_STAT,          0,    0x1F);
+    RC_CONFIG_STICKY_RESET(P16_LDPM,          0,    0xFFFF);
+    RC_CONFIG_STICKY_RESET(P16_FRDPM,         0,    0xFFFF);
+    RC_CONFIG_STICKY_RESET(P16_SRDPM,         0,    0xFFFF);
 }
 
 /* Apply sticky-mask to the reset-value and write to the reg-address */
@@ -580,7 +584,7 @@ static void pnv_phb4_pbl_core_reset(PnvPHB4 *phb)
     phb->regs[PHB_PBL_SYS_LINK_INIT >> 3] = 0x80088B4642470000;
 }
 
-static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
+void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
                                unsigned size)
 {
     PnvPHB4 *phb = PNV_PHB4(opaque);
@@ -610,8 +614,41 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
         return;
     }
 
-    /* Handle masking */
+    /* Handle RO, W1C, WxC and masking */
     switch (off) {
+    /* W1C: Write-1-to-Clear registers */
+    case PHB_TXE_ERR_STATUS:
+    case PHB_RXE_ARB_ERR_STATUS:
+    case PHB_RXE_MRG_ERR_STATUS:
+    case PHB_RXE_TCE_ERR_STATUS:
+    case PHB_ERR_STATUS:
+    case PHB_REGB_ERR_STATUS:
+    case PHB_PCIE_DLP_ERRLOG1:
+    case PHB_PCIE_DLP_ERRLOG2:
+    case PHB_PCIE_DLP_ERR_STATUS:
+    case PHB_PBL_ERR_STATUS:
+        phb->regs[off >> 3] &= ~val;
+        return;
+
+    /* WxC: Clear register on any write */
+    case PHB_PBL_ERR1_STATUS:
+    case PHB_PBL_ERR_LOG_0 ... PHB_PBL_ERR_LOG_1:
+    case PHB_REGB_ERR1_STATUS:
+    case PHB_REGB_ERR_LOG_0 ... PHB_REGB_ERR_LOG_1:
+    case PHB_TXE_ERR1_STATUS:
+    case PHB_TXE_ERR_LOG_0 ... PHB_TXE_ERR_LOG_1:
+    case PHB_RXE_ARB_ERR1_STATUS:
+    case PHB_RXE_ARB_ERR_LOG_0 ... PHB_RXE_ARB_ERR_LOG_1:
+    case PHB_RXE_MRG_ERR1_STATUS:
+    case PHB_RXE_MRG_ERR_LOG_0 ... PHB_RXE_MRG_ERR_LOG_1:
+    case PHB_RXE_TCE_ERR1_STATUS:
+    case PHB_RXE_TCE_ERR_LOG_0 ... PHB_RXE_TCE_ERR_LOG_1:
+    case PHB_ERR1_STATUS:
+    case PHB_ERR_LOG_0 ... PHB_ERR_LOG_1:
+        phb->regs[off >> 3] = 0;
+        return;
+
+    /* Write value updated by masks */
     case PHB_LSI_SOURCE_ID:
         val &= PHB_LSI_SRC_ID;
         break;
@@ -650,7 +687,6 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
     case PHB_LEM_WOF:
         val = 0;
         break;
-    /* TODO: More regs ..., maybe create a table with masks... */
 
     /* Read only registers */
     case PHB_CPU_LOADSTORE_STATUS:
@@ -659,6 +695,11 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
     case PHB_PHB4_TCE_CAP:
     case PHB_PHB4_IRQ_CAP:
     case PHB_PHB4_EEH_CAP:
+    case PHB_VERSION:
+    case PHB_DMA_CHAN_STATUS:
+    case PHB_TCE_TAG_STATUS:
+    case PHB_PBL_BUF_STATUS:
+    case PHB_PCIE_BNR:
         return;
     }
 
@@ -681,6 +722,7 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
             pnv_phb4_update_all_msi_regions(phb);
         }
         break;
+
     case PHB_M32_START_ADDR:
     case PHB_M64_UPPER_BITS:
         if (changed) {
@@ -728,32 +770,69 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
         break;
 
     /* Silent simple writes */
-    case PHB_ASN_CMPM:
-    case PHB_CONFIG_ADDRESS:
-    case PHB_IODA_ADDR:
-    case PHB_TCE_KILL:
-    case PHB_TCE_SPEC_CTL:
-    case PHB_PEST_BAR:
-    case PHB_PELTV_BAR:
+
+    /* PHB Fundamental register set A */
+    case PHB_CONFIG_DATA ... PHB_LOCK1:
     case PHB_RTT_BAR:
-    case PHB_LEM_FIR_ACCUM:
-    case PHB_LEM_ERROR_MASK:
-    case PHB_LEM_ACTION0:
-    case PHB_LEM_ACTION1:
-    case PHB_TCE_TAG_ENABLE:
+    case PHB_PELTV_BAR:
+    case PHB_PEST_BAR:
+    case PHB_CRW_BAR ... PHB_ASN_CMPM:
+    case PHB_CAPI_CMPM ... PHB_M64_AOMASK:
+    case PHB_NXLATE_PREFIX ... PHB_DMA_SYNC:
+    case PHB_TCE_KILL ... PHB_IODA_ADDR:
+    case PHB_PAPR_ERR_INJ_CTL ... PHB_PAPR_ERR_INJ_MASK:
     case PHB_INT_NOTIFY_ADDR:
     case PHB_INT_NOTIFY_INDEX:
-    case PHB_DMA_SYNC:
-       break;
+    /* Fundamental register set B */
+    case PHB_AIB_FENCE_CTRL ... PHB_Q_DMA_R:
+    /* FIR & Error registers */
+    case PHB_LEM_FIR_ACCUM:
+    case PHB_LEM_ERROR_MASK:
+    case PHB_LEM_ACTION0 ... PHB_LEM_WOF:
+    case PHB_ERR_INJECT ... PHB_ERR_AIB_FENCE_ENABLE:
+    case PHB_ERR_STATUS_MASK ... PHB_ERR1_STATUS_MASK:
+    case PHB_TXE_ERR_INJECT ... PHB_TXE_ERR_AIB_FENCE_ENABLE:
+    case PHB_TXE_ERR_STATUS_MASK ... PHB_TXE_ERR1_STATUS_MASK:
+    case PHB_RXE_ARB_ERR_INJECT ... PHB_RXE_ARB_ERR_AIB_FENCE_ENABLE:
+    case PHB_RXE_ARB_ERR_STATUS_MASK ... PHB_RXE_ARB_ERR1_STATUS_MASK:
+    case PHB_RXE_MRG_ERR_INJECT ... PHB_RXE_MRG_ERR_AIB_FENCE_ENABLE:
+    case PHB_RXE_MRG_ERR_STATUS_MASK ... PHB_RXE_MRG_ERR1_STATUS_MASK:
+    case PHB_RXE_TCE_ERR_INJECT ... PHB_RXE_TCE_ERR_AIB_FENCE_ENABLE:
+    case PHB_RXE_TCE_ERR_STATUS_MASK ... PHB_RXE_TCE_ERR1_STATUS_MASK:
+    /* Performance monitor & Debug registers */
+    case PHB_TRACE_CONTROL ... PHB_PERFMON_CTR1:
+    /* REGB Registers */
+    /* PBL core */
+    case PHB_PBL_CONTROL:
+    case PHB_PBL_TIMEOUT_CTRL:
+    case PHB_PBL_NPTAG_ENABLE:
+    case PHB_PBL_SYS_LINK_INIT:
+    case PHB_PBL_ERR_INF_ENABLE ... PHB_PBL_ERR_FAT_ENABLE:
+    case PHB_PBL_ERR_STATUS_MASK ... PHB_PBL_ERR1_STATUS_MASK:
+    /* PCI-E stack */
+    case PHB_PCIE_SCR:
+    case PHB_PCIE_DLP_STR ... PHB_PCIE_HOTPLUG_STATUS:
+    case PHB_PCIE_LMR ... PHB_PCIE_DLP_LSR:
+    case PHB_PCIE_DLP_LANEZEROCTL ... PHB_PCIE_DLP_TRCRDDATA:
+    case PHB_PCIE_DLP_ERR_COUNTERS:
+    case PHB_PCIE_DLP_EIC ...   PHB_PCIE_LANE_EQ_CNTL23:
+    case PHB_PCIE_TRACE_CTRL:
+    case PHB_PCIE_MISC_STRAP:
+    /* Error registers */
+    case PHB_REGB_ERR_INJECT:
+    case PHB_REGB_ERR_INF_ENABLE ... PHB_REGB_ERR_FAT_ENABLE:
+    case PHB_REGB_ERR_STATUS_MASK ... PHB_REGB_ERR1_STATUS_MASK:
+        break;
 
     /* Noise on anything else */
     default:
-        qemu_log_mask(LOG_UNIMP, "phb4: reg_write 0x%"PRIx64"=%"PRIx64"\n",
+        qemu_log_mask(LOG_UNIMP,
+                      "phb4: unimplemented reg_write 0x%"PRIx64"=%"PRIx64"\n",
                       off, val);
     }
 }
 
-static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
+uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
 {
     PnvPHB4 *phb = PNV_PHB4(opaque);
     uint64_t val;
@@ -841,36 +920,74 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
         return val;
 
     /* Silent simple reads */
+    /* PHB Fundamental register set A */
     case PHB_LSI_SOURCE_ID:
+    case PHB_DMA_CHAN_STATUS:
     case PHB_CPU_LOADSTORE_STATUS:
-    case PHB_ASN_CMPM:
+    case PHB_CONFIG_DATA ... PHB_LOCK1:
     case PHB_PHB4_CONFIG:
+    case PHB_RTT_BAR:
+    case PHB_PELTV_BAR:
     case PHB_M32_START_ADDR:
-    case PHB_CONFIG_ADDRESS:
-    case PHB_IODA_ADDR:
-    case PHB_RTC_INVALIDATE:
-    case PHB_TCE_KILL:
-    case PHB_TCE_SPEC_CTL:
     case PHB_PEST_BAR:
-    case PHB_PELTV_BAR:
-    case PHB_RTT_BAR:
+    case PHB_CRW_BAR ... PHB_ASN_CMPM:
+    case PHB_CAPI_CMPM:
+    case PHB_M64_AOMASK:
     case PHB_M64_UPPER_BITS:
-    case PHB_CTRLR:
-    case PHB_LEM_FIR_ACCUM:
-    case PHB_LEM_ERROR_MASK:
-    case PHB_LEM_ACTION0:
-    case PHB_LEM_ACTION1:
-    case PHB_TCE_TAG_ENABLE:
+    case PHB_NXLATE_PREFIX:
+    case PHB_RTC_INVALIDATE ... PHB_IODA_ADDR:
+    case PHB_PAPR_ERR_INJ_CTL ... PHB_ETU_ERR_SUMMARY:
     case PHB_INT_NOTIFY_ADDR:
     case PHB_INT_NOTIFY_INDEX:
-    case PHB_Q_DMA_R:
-    case PHB_ETU_ERR_SUMMARY:
-        break;
-
-    /* Noise on anything else */
+    /* Fundamental register set B */
+    case PHB_CTRLR:
+    case PHB_AIB_FENCE_CTRL ... PHB_Q_DMA_R:
+    case PHB_TCE_TAG_STATUS:
+    /* FIR & Error registers */
+    case PHB_LEM_FIR_ACCUM ... PHB_LEM_ERROR_MASK:
+    case PHB_LEM_ACTION0 ... PHB_LEM_WOF:
+    case PHB_ERR_STATUS ... PHB_ERR_AIB_FENCE_ENABLE:
+    case PHB_ERR_LOG_0 ... PHB_ERR1_STATUS_MASK:
+    case PHB_TXE_ERR_STATUS ... PHB_TXE_ERR_AIB_FENCE_ENABLE:
+    case PHB_TXE_ERR_LOG_0 ... PHB_TXE_ERR1_STATUS_MASK:
+    case PHB_RXE_ARB_ERR_STATUS ... PHB_RXE_ARB_ERR_AIB_FENCE_ENABLE:
+    case PHB_RXE_ARB_ERR_LOG_0 ... PHB_RXE_ARB_ERR1_STATUS_MASK:
+    case PHB_RXE_MRG_ERR_STATUS ... PHB_RXE_MRG_ERR_AIB_FENCE_ENABLE:
+    case PHB_RXE_MRG_ERR_LOG_0 ... PHB_RXE_MRG_ERR1_STATUS_MASK:
+    case PHB_RXE_TCE_ERR_STATUS ... PHB_RXE_TCE_ERR_AIB_FENCE_ENABLE:
+    case PHB_RXE_TCE_ERR_LOG_0 ... PHB_RXE_TCE_ERR1_STATUS_MASK:
+    /* Performance monitor & Debug registers */
+    case PHB_TRACE_CONTROL ... PHB_PERFMON_CTR1:
+    /* REGB Registers */
+    /* PBL core */
+    case PHB_PBL_CONTROL:
+    case PHB_PBL_TIMEOUT_CTRL:
+    case PHB_PBL_NPTAG_ENABLE:
+    case PHB_PBL_SYS_LINK_INIT:
+    case PHB_PBL_BUF_STATUS:
+    case PHB_PBL_ERR_STATUS ... PHB_PBL_ERR_INJECT:
+    case PHB_PBL_ERR_INF_ENABLE ... PHB_PBL_ERR_FAT_ENABLE:
+    case PHB_PBL_ERR_LOG_0 ... PHB_PBL_ERR1_STATUS_MASK:
+    /* PCI-E stack */
+    case PHB_PCIE_BNR ... PHB_PCIE_DLP_STR:
+    case PHB_PCIE_DLP_LSR:
+    case PHB_PCIE_DLP_LANEZEROCTL ... PHB_PCIE_DLP_CTL:
+    case PHB_PCIE_DLP_TRCRDDATA:
+    case PHB_PCIE_DLP_ERRLOG1 ... PHB_PCIE_DLP_ERR_COUNTERS:
+    case PHB_PCIE_DLP_EIC ...   PHB_PCIE_LANE_EQ_CNTL23:
+    case PHB_PCIE_TRACE_CTRL:
+    case PHB_PCIE_MISC_STRAP:
+    /* Error registers */
+    case PHB_REGB_ERR_STATUS ... PHB_REGB_ERR_INJECT:
+    case PHB_REGB_ERR_INF_ENABLE ... PHB_REGB_ERR_FAT_ENABLE:
+    case PHB_REGB_ERR_LOG_0 ... PHB_REGB_ERR1_STATUS_MASK:
+        break;
+
+    /* Noise on unimplemented read, return all 1's */
     default:
-        qemu_log_mask(LOG_UNIMP, "phb4: reg_read 0x%"PRIx64"=%"PRIx64"\n",
-                      off, val);
+        qemu_log_mask(LOG_UNIMP, "phb4: unimplemented reg_read 0x%"PRIx64"\n",
+                      off);
+        val = ~0ull;
     }
     return val;
 }
@@ -1812,7 +1929,7 @@ void pnv_phb4_bus_init(DeviceState *dev, PnvPHB4 *phb)
     pci->bus->flags |= PCI_BUS_EXTENDED_CONFIG_SPACE;
 }
 
-static void pnv_phb4_realize(DeviceState *dev, Error **errp)
+void pnv_phb4_realize(DeviceState *dev, Error **errp)
 {
     PnvPHB4 *phb = PNV_PHB4(dev);
     XiveSource *xsrc = &phb->xsrc;
diff --git a/hw/pci-host/pnv_phb5.c b/hw/pci-host/pnv_phb5.c
index 4906a82c6f..b09351f69f 100644
--- a/hw/pci-host/pnv_phb5.c
+++ b/hw/pci-host/pnv_phb5.c
@@ -103,10 +103,117 @@ static void pnv_phb5_reset(Object *obj, ResetType type)
     pnv_phb5_pbl_core_reset(phb);
 }
 
+static uint64_t pnv_phb5_reg_read(void *opaque, hwaddr off, unsigned size)
+{
+    PnvPHB4 *phb = PNV_PHB4(opaque);
+
+    uint64_t val = ~0ull;
+
+    switch (off) {
+    /* Registers removed in PHB5 from PHB4, return all 1's on read */
+    case PHB_CRW_BAR ... PHB_ASN_CMPM:
+    case PHB_PERFMON_CTR2 ... PHB_PERFMON_CTR3:
+    case P16_ECAP ... P16_SRDPM:
+    case PHB_PBL_NBW_CMP_MASK:
+        qemu_log_mask(LOG_GUEST_ERROR, "phb5: read from reserved offset 0x%"
+                      PRIx64"\n", off);
+        return ~0ULL;
+
+    /* New registers in PHB5 from PHB4 */
+    case P16_LDPM_PHB5 ... P16_SRDPM_PHB5:
+    case P32_ECAP ... P32_STAT:
+    case PHB_PCIE_DLP_LANE_PWR:
+    case PHB_PCIE_DLP_RXMGN:
+    case PHB_PCIE_DLP_LZC:
+    case PHB_PCIE_DLP_LEC0 ... PHB_PCIE_DLP_LEC1:
+    case PHB_PCIE_PHY_EQ_CTL:
+    case PHB_PCIE_PHY_RXEQ_STAT_G3_00_03 ... PHB_PCIE_PHY_RXEQ_STAT_G5_12_15:
+        val = phb->regs[off >> 3];
+        break;
+
+    default:
+        val = pnv_phb4_reg_read(opaque, off, size);
+    }
+
+    return val;
+}
+
+static void pnv_phb5_reg_write(void *opaque, hwaddr off, uint64_t val,
+                               unsigned size)
+{
+    PnvPHB4 *phb = PNV_PHB4(opaque);
+
+    switch (off) {
+    /* Registers removed in PHB5 from PHB4 */
+    case PHB_CRW_BAR ... PHB_ASN_CMPM:
+    case PHB_PERFMON_CTR2 ... PHB_PERFMON_CTR3:
+    case P16_ECAP ... P16_SRDPM:
+    case PHB_PBL_NBW_CMP_MASK:
+        qemu_log_mask(LOG_GUEST_ERROR, "phb5: write to reserved offset 0x%"
+                      PRIx64"\n", off);
+        return;
+
+    /* New registers in PHB5 from PHB4 */
+
+    /* W1C: Write-1-to-Clear registers */
+    case P16_STAT_PHB5 ... P16_SRDPM_PHB5:
+        phb->regs[off >> 3] &= ~val;
+        break;
+
+    /* Read only registers */
+    case P16_ECAP_PHB5:
+    case P32_ECAP:
+    case P32_STAT:
+    case PHB_PCIE_PHY_RXEQ_STAT_G3_00_03 ... PHB_PCIE_PHY_RXEQ_STAT_G5_12_15:
+        return;
+
+    /* Simple write */
+    case P32_CTL:
+    case PHB_PCIE_DLP_LANE_PWR:
+    case PHB_PCIE_DLP_RXMGN:
+    case PHB_PCIE_DLP_LZC:
+    case PHB_PCIE_DLP_LEC0 ... PHB_PCIE_DLP_LEC1:
+    case PHB_PCIE_PHY_EQ_CTL:
+        phb->regs[off >> 3] = val;
+        break;
+
+    default:
+        pnv_phb4_reg_write(opaque, off, val, size);
+    }
+}
+
+static const MemoryRegionOps pnv_phb5_reg_ops = {
+    .read = pnv_phb5_reg_read,
+    .write = pnv_phb5_reg_write,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 1,
+    .impl.max_access_size = 8,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void pnv_phb5_realize(DeviceState *dev, Error **errp)
+{
+    PnvPHB4 *phb = PNV_PHB4(dev);
+    char name[32];
+
+    pnv_phb4_realize(dev, errp);
+
+    /* Controller Registers */
+    snprintf(name, sizeof(name), "phb5-%d.%d-regs", phb->chip_id,
+             phb->phb_id);
+    memory_region_init_io(&phb->mr_regs, OBJECT(phb), &pnv_phb5_reg_ops, phb,
+                          name, 0x2000);
+}
+
 static void pnv_phb5_class_init(ObjectClass *klass, const void *data)
 {
+    DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
 
+    dc->realize         = pnv_phb5_realize;
+    dc->user_creatable  = false;
+
     rc->phases.enter = pnv_phb5_reset;
 }
 
@@ -114,7 +221,8 @@ static const TypeInfo pnv_phb5_type_info = {
     .name          = TYPE_PNV_PHB5,
     .parent        = TYPE_PNV_PHB4,
     .instance_size = sizeof(PnvPHB4),
-    .class_init    = pnv_phb5_class_init
+    .class_init    = pnv_phb5_class_init,
+    .class_size    = sizeof(PnvPHB4Class)
 };
 
 static void pnv_phb5_register_types(void)
diff --git a/include/hw/pci-host/pnv_phb4.h b/include/hw/pci-host/pnv_phb4.h
index 567a3e6e95..33e11a3fe8 100644
--- a/include/hw/pci-host/pnv_phb4.h
+++ b/include/hw/pci-host/pnv_phb4.h
@@ -173,6 +173,9 @@ PnvPhb4PecState *pnv_pec_add_phb(PnvChip *chip, PnvPHB *phb, Error **errp);
 void pnv_phb4_bus_init(DeviceState *dev, PnvPHB4 *phb);
 void pnv_phb4_cfg_core_reset(PCIDevice *d);
 extern const MemoryRegionOps pnv_phb4_xscom_ops;
+uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size);
+void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val, unsigned size);
+void pnv_phb4_realize(DeviceState *dev, Error **errp);
 
 /*
  * PHB4 PEC (PCI Express Controller)
diff --git a/include/hw/pci-host/pnv_phb4_regs.h b/include/hw/pci-host/pnv_phb4_regs.h
index d0962c1607..9ad6713d37 100644
--- a/include/hw/pci-host/pnv_phb4_regs.h
+++ b/include/hw/pci-host/pnv_phb4_regs.h
@@ -173,6 +173,7 @@
 #define PHB_PEST_BAR                    0x1a8
 #define   PHB_PEST_BAR_ENABLE           PPC_BIT(0)
 #define   PHB_PEST_BASE_ADDRESS         PPC_BITMASK(8, 51)
+#define PHB_CRW_BAR                     0x1B0
 #define PHB_ASN_CMPM                    0x1C0
 #define   PHB_ASN_CMPM_ENABLE           PPC_BIT(63)
 #define PHB_CAPI_CMPM                   0x1C8
@@ -357,6 +358,11 @@
 #define PHB_AER_RERR                            0x130
 #define PHB_AER_ESID                            0x134
 #define PHB_SEC_ECAP                            0x148
+#define P16_ECAP                                0x174
+#define P16_STAT                                0x180
+#define P16_LDPM                                0x184
+#define P16_FRDPM                               0x188
+#define P16_SRDPM                               0x18C
 #define PHB_LMR_ECAP                            0x1A0
 #define PHB_LMR_CTLSTA_2                        0x1AC
 #define PHB_LMR_CTLSTA_16                       0x1E4
@@ -398,6 +404,7 @@
 #define   PHB_PCIE_CRESET_PERST_N       PPC_BIT(3)
 #define   PHB_PCIE_CRESET_PIPE_N        PPC_BIT(4)
 #define   PHB_PCIE_CRESET_REFCLK_N      PPC_BIT(8)
+#define PHB_PCIE_DLP_STR                0x1A18
 #define PHB_PCIE_HOTPLUG_STATUS         0x1A20
 #define   PHB_PCIE_HPSTAT_SIMDIAG       PPC_BIT(3)
 #define   PHB_PCIE_HPSTAT_RESAMPLE      PPC_BIT(9)
@@ -427,18 +434,20 @@
 #define   PHB_PCIE_DLP_DL_PGRESET       PPC_BIT(22)
 #define   PHB_PCIE_DLP_TRAINING         PPC_BIT(20)
 #define   PHB_PCIE_DLP_INBAND_PRESENCE  PPC_BIT(19)
-
+#define PHB_PCIE_DLP_LSR                0x1A48
+#define PHB_PCIE_DLP_LANEZEROCTL        0x1A70
 #define PHB_PCIE_DLP_CTL                0x1A78
 #define   PHB_PCIE_DLP_CTL_BYPASS_PH2   PPC_BIT(4)
 #define   PHB_PCIE_DLP_CTL_BYPASS_PH3   PPC_BIT(5)
-
 #define PHB_PCIE_DLP_TRWCTL             0x1A80
 #define   PHB_PCIE_DLP_TRWCTL_EN        PPC_BIT(0)
 #define   PHB_PCIE_DLP_TRWCTL_WREN      PPC_BIT(1)
+#define PHB_PCIE_DLP_TRCRDDATA          0x1A88
 #define PHB_PCIE_DLP_ERRLOG1            0x1AA0
 #define PHB_PCIE_DLP_ERRLOG2            0x1AA8
 #define PHB_PCIE_DLP_ERR_STATUS         0x1AB0
 #define PHB_PCIE_DLP_ERR_COUNTERS       0x1AB8
+#define PHB_PCIE_DLP_EIC                0x1AC8
 
 #define PHB_PCIE_LANE_EQ_CNTL0          0x1AD0
 #define PHB_PCIE_LANE_EQ_CNTL1          0x1AD8
@@ -581,5 +590,4 @@
 
 #define IODA3_PEST1_FAIL_ADDR           PPC_BITMASK(3, 63)
 
-
 #endif /* PCI_HOST_PNV_PHB4_REGS_H */
diff --git a/include/hw/pci-host/pnv_phb5.h b/include/hw/pci-host/pnv_phb5.h
index d76846068a..4534083fd5 100644
--- a/include/hw/pci-host/pnv_phb5.h
+++ b/include/hw/pci-host/pnv_phb5.h
@@ -33,17 +33,22 @@ void pnv_phb5_cfg_core_reset(PCIDevice *d);
     OBJECT_CHECK(PnvPhb4PecState, (obj), TYPE_PNV_PHB5_PEC)
 
 /* New registers in PHB5 from PHB4 */
-#define P16_ECAP                                0x1F4
-#define P16_STAT                                0x200
-#define P16_LDPM                                0x204
-#define P16_FRDPM                               0x208
-#define P16_SRDPM                               0x20C
+#define P16_ECAP_PHB5                           0x1F4
+#define P16_STAT_PHB5                           0x200
+#define P16_LDPM_PHB5                           0x204
+#define P16_FRDPM_PHB5                          0x208
+#define P16_SRDPM_PHB5                          0x20C
 #define P32_ECAP                                0x224
 #define P32_CAP                                 0x228
 #define P32_CTL                                 0x22C
 #define P32_STAT                                0x230
+#define PHB_PCIE_DLP_LANE_PWR                   0x1A38
+#define PHB_PCIE_DLP_RXMGN                      0x1A50
+#define PHB_PCIE_DLP_LZC                        0x1A70
+#define PHB_PCIE_DLP_LEC0                       0x1B00
+#define PHB_PCIE_DLP_LEC1                       0x1B08
+#define PHB_PCIE_PHY_EQ_CTL                     0x1B38
 #define PHB_PCIE_PHY_RXEQ_STAT_G3_00_03         0x1B40
 #define PHB_PCIE_PHY_RXEQ_STAT_G5_12_15         0x1B98
 
-
 #endif /* PCI_HOST_PNV_PHB5_H */
diff --git a/tests/qtest/pnv-phb-test.c b/tests/qtest/pnv-phb-test.c
index 7e9127f81e..2f455a6b84 100644
--- a/tests/qtest/pnv-phb-test.c
+++ b/tests/qtest/pnv-phb-test.c
@@ -89,11 +89,10 @@ static void phb5_sticky_rst_test(QTestState *qts)
     g_assert_cmpuint(val, ==, (PPC_BITMASK(24, 27) | PPC_BITMASK(36, 37) |
                      PPC_BITMASK(39, 45) | PPC_BITMASK(47, 48) |
                      PPC_BITMASK(52, 54)));
-
 }
 
 /* Check that write-only bits/regs return 0 when read */
-static void phb4_writeonly_read_test(QTestState *qts)
+static void phb5_writeonly_read_test(QTestState *qts)
 {
     uint64_t val;
 
@@ -144,6 +143,12 @@ static void phb4_writeonly_read_test(QTestState *qts)
     g_assert_cmpuint(val, ==, 0x0);
 }
 
+/* Check that reading an unimplemented address 0x0 returns -1 */
+static void phb5_unimplemented_read_test(QTestState *qts)
+{
+    g_assert_cmpint(PHB5_XSCOM_READ(0x0), ==, -1);
+}
+
 static void phb5_tests(void)
 {
     QTestState *qts = NULL;
@@ -157,7 +162,10 @@ static void phb5_tests(void)
     phb5_sticky_rst_test(qts);
 
     /* Check write-only logic */
-    phb4_writeonly_read_test(qts);
+    phb5_writeonly_read_test(qts);
+
+    /* Check unimplemented register read */
+    phb5_unimplemented_read_test(qts);
 
     qtest_quit(qts);
 }
-- 
2.52.0


