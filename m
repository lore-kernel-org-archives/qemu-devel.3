Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DBA606A322
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=e7U4Olir
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLdjI-0000SQ-Mm; Tue, 27 Oct 2026 05:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1xLdjF-0000OX-OG; Tue, 27 Oct 2026 05:44:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1xLdjC-0001OZ-LB; Tue, 27 Oct 2026 05:44:25 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R5j5lM1625224; Tue, 27 Oct 2026 09:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=IMsQIZRB09BJdo5zU
 bLTP9MvWwJwwlvZSD08cWVfBr8=; b=e7U4OlirnVETnKlmV0jR20X+ndG/skrQS
 jHuFkgg99n2g02UPtz8sYUzIbg903NJRW5hGlsV4iapApWCXzePiuAC0xP+TKpYK
 tU+R9+88mP+NG3i06oRxzqyKk7GwoGbpjBHl/9atQ/gLGumH0SNdigRi/L4hXcan
 5hPLnu17ojWRK9/ehKhzo6xnuiQ2qSNQSfclxyYFRXuM8JllH5Ho/k0VyuHKGJ5h
 3ODoqEwESUwdyCBsSLFIQcUU58wjeQf76h57+5BxegdtzhD1g3ZieezG1GT51ntT
 UZwkTOYYEP+JeEz/RsFOt2EMBD/MHEmr8dXmwEDq9dSMD5dxkp8gg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgm63xqek-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2026 09:44:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R5YxUD2510929; Tue, 27 Oct 2026 09:44:15 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hh97gsx7x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2026 09:44:15 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69R9iEUH13238788
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Oct 2026 09:44:14 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ACD8358056;
 Tue, 27 Oct 2026 09:44:14 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B4B9458052;
 Tue, 27 Oct 2026 09:44:13 +0000 (GMT)
Received: from gfwr526.rchland.ibm.com (unknown [9.10.239.119])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Oct 2026 09:44:13 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, milesg@linux.ibm.com,
 jishnuvw@linux.ibm.com, adityag@linux.ibm.com, amachhiw@linux.ibm.com
Subject: [PATCH v7 3/9] pnv/phb5: Implement sticky reset logic in PHB5
Date: Tue, 27 Oct 2026 04:43:44 -0500
Message-ID: <20261027094350.3645085-4-saif.abrar@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261027094350.3645085-1-saif.abrar@linux.ibm.com>
References: <20261027094350.3645085-1-saif.abrar@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAzOCBTYWx0ZWRfX3KtMxUokmCNi
 MkCErvcxBcVeOrayQOt4EV7w4m+aiTUXpoWzl5yLejWDFFtGEbdC0UKvkeKh0AKNEsf0ocV5j/s
 i3jAaPV8A5ssnrm/tPmYMq4CAhm1aNI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAzOCBTYWx0ZWRfX0+n1xRqHxJev
 R6NYUWclHtptX+aUpt4/isrkngSN331hhHddxn1fRQkcxwD8OuOAhZXotprBx/VF19ud1+dOwOC
 uhibbToVP3kA6d9maBPNXMTZH/GATdxn1cIdPK2OAywpZHOZ2qGRxDu3AqvgFMG+NdLPWV1PhMd
 4KqqQ9HMj+feT4F2kNKEw1qc/+0do+mtl8zwVm1jJxUGao0+5K83AdBFgefttx4Y8BeI6OYW7WA
 ceUvFe/xJJOIFa0lkS2BqWNeVCu5UQwbFc58ciFpTxE/VxzH6CS6VKI60YplDpknWVA+x89YbzU
 yPq6F0JuZa1ukXgsS4JL87TrzlZpLdsRxg3TAprpiMF9lAR1y6dgW/3wB4AW40MKO4XNAH5cIpR
 LmkTu0FtVQ90Pgz8RbKjtwl/P+5irzYAeSAiySQc3XdwaY3qJHBbwZGcEAIg6q264nXMhV7pZJV
 jYooz0RmqpWM7r9jbxg==
X-Proofpoint-ORIG-GUID: YcC36FFYxbvM2pZEzFeu5mjZgOurPbuw
X-Authority-Analysis: v=2.4 cv=Uu32pOwB c=1 sm=1 tr=0 ts=6ae07270 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=_OqsxZwj8_jexw0pSn4A:9
X-Proofpoint-GUID: QPzq8BrKtAMNqqfsPAhrs6MhSkx6EQfL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270038
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=saif.abrar@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Sticky bits retain their values on reset and are not overwritten with
the reset value.
Added sticky reset logic for all required registers,
i.e. CFG core, PBL core, PHB error registers, PCIE stack registers and
REGB error registers.

Tested by writing all 1's to the reg PHB_PBL_ERR_INJECT.
This will set the bits in the reg PHB_PBL_ERR_STATUS.
Reset the PBL core by setting PHB_PCIE_CRESET_PBL in reg PHB_PCIE_CRESET.
Verify that the sticky bits in the PHB_PBL_ERR_STATUS reg are still set.

Signed-off-by: Saif Abrar <saif.abrar@linux.ibm.com>
Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
---
 hw/pci-host/pnv_phb4.c              | 114 +++++++++++++++++++++++++++-
 hw/pci-host/pnv_phb5.c              |  19 +++--
 include/hw/pci-host/pnv_phb4.h      |  17 +++++
 include/hw/pci-host/pnv_phb4_regs.h |  13 +++-
 include/hw/pci-host/pnv_phb5.h      |   7 +-
 tests/qtest/pnv-phb-test.c          |  41 ++++++++++
 6 files changed, 196 insertions(+), 15 deletions(-)

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 5aea5409a3..e675caee01 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -500,9 +500,17 @@ static void pnv_phb4_update_xsrc(PnvPHB4 *phb)
     }
 }
 
+uint32_t get_exp_offset(PCIDevice *pdev)
+{
+    PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(pdev);
+
+    return rpc->exp_offset;
+}
+
 void pnv_phb4_cfg_core_reset(PCIDevice *d)
 {
     uint8_t *conf = d->config;
+    uint32_t exp_offset = get_exp_offset(d);
 
     pci_byte_test_and_set_mask(conf + PCI_IO_BASE,
                                PCI_IO_RANGE_MASK & 0xff);
@@ -515,14 +523,51 @@ void pnv_phb4_cfg_core_reset(PCIDevice *d)
     pci_set_long(conf + PCI_PREF_BASE_UPPER32, 0x1); /* Hack */
     pci_set_long(conf + PCI_PREF_LIMIT_UPPER32, 0xffffffff);
     pci_config_set_interrupt_pin(conf, 0);
+
+    /* Sticky reset */
+    RC_CONFIG_STICKY_RESET(exp_offset + PCI_EXP_LNKCTL2,
+                                          PCI_EXP_LNKCTL2_TLS_16_0GT, 0xFEFFBF);
+    RC_CONFIG_STICKY_RESET(PHB_AER_UERR,      0,    0x1FF030);
+    RC_CONFIG_STICKY_RESET(PHB_AER_UERR_MASK, 0,    0x1FF030);
+    RC_CONFIG_STICKY_RESET(PHB_AER_CERR,      0,    0x11C1);
+    RC_CONFIG_STICKY_RESET(PHB_AER_ECAP + PCI_ERR_CAP, (PCI_ERR_CAP_ECRC_CHKC
+                                               | PCI_ERR_CAP_ECRC_GENC), 0x15F);
+    RC_CONFIG_STICKY_RESET(PHB_AER_HLOG_1,    0,    0xFFFFFFFF);
+    RC_CONFIG_STICKY_RESET(PHB_AER_HLOG_2,    0,    0xFFFFFFFF);
+    RC_CONFIG_STICKY_RESET(PHB_AER_HLOG_3,    0,    0xFFFFFFFF);
+    RC_CONFIG_STICKY_RESET(PHB_AER_HLOG_4,    0,    0xFFFFFFFF);
+    RC_CONFIG_STICKY_RESET(PHB_AER_RERR,      0,    0x7F);
+    RC_CONFIG_STICKY_RESET(PHB_AER_ESID,      0,    0xFFFFFFFF);
+    RC_CONFIG_STICKY_RESET(PHB_DLF_STAT,      0,    0x807FFFFF);
 }
 
+/* Apply sticky-mask to the reset-value and write to the reg-address */
+#define STICKY_RST(addr, rst_val, sticky_mask) (phb->regs[addr >> 3] = \
+            ((phb->regs[addr >> 3] & sticky_mask) | (rst_val & ~sticky_mask)))
+
 static void pnv_phb4_pbl_core_reset(PnvPHB4 *phb)
 {
-    /* Zero all PBL registers initially */
+    /*
+     * Zero all PBL registers initially,
+     * with sticky reset of certain registers.
+     */
     for (int i = PHB_PBL_CONTROL ; i <= PHB_PBL_ERR1_STATUS_MASK ; i += 8) {
-        phb->regs[i >> 3] = 0x0;
+        switch (i) {
+        case PHB_PBL_ERR_STATUS:
+            break;
+        case PHB_PBL_ERR1_STATUS:
+        case PHB_PBL_ERR_LOG_0:
+        case PHB_PBL_ERR_LOG_1:
+        case PHB_PBL_ERR_STATUS_MASK:
+        case PHB_PBL_ERR1_STATUS_MASK:
+            STICKY_RST(i, 0, PPC_BITMASK(0, 63));
+            break;
+        default:
+            phb->regs[i >> 3] = 0x0;
+        }
     }
+    STICKY_RST(PHB_PBL_ERR_STATUS, 0, \
+            (PPC_BITMASK(0, 9) | PPC_BITMASK(12, 63)));
 
     /* Set PHB4 specific register values */
     phb->regs[PHB_PBL_CONTROL       >> 3] = 0xC00000000000000;
@@ -656,6 +701,17 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
         }
         break;
 
+    /*
+     * Writing bits to a 1 in this register will inject the error corresponding
+     * to the bit that is written. The bits will automatically clear to 0 after
+     * the error is injected. The corresponding bit in the Error Status Reg
+     * should also be set automatically when the error occurs.
+     */
+    case PHB_PBL_ERR_INJECT:
+        phb->regs[PHB_PBL_ERR_STATUS >> 3] = phb->regs[off >> 3];
+        phb->regs[off >> 3] = 0;
+        break;
+
     /* Silent simple writes */
     case PHB_ASN_CMPM:
     case PHB_CONFIG_ADDRESS:
@@ -1576,11 +1632,65 @@ static PCIIOMMUOps pnv_phb4_iommu_ops = {
     .get_address_space = pnv_phb4_dma_iommu,
 };
 
+static void pnv_phb4_err_reg_reset(PnvPHB4 *phb)
+{
+    STICKY_RST(PHB_ERR_STATUS,       0, PPC_BITMASK(0, 33));
+    STICKY_RST(PHB_ERR1_STATUS,      0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_ERR_STATUS_MASK,  0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_ERR1_STATUS_MASK, 0, PPC_BITMASK(0, 63));
+
+    STICKY_RST(PHB_TXE_ERR_STATUS,       0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_TXE_ERR1_STATUS,      0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_TXE_ERR_STATUS_MASK,  0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_TXE_ERR1_STATUS_MASK, 0, PPC_BITMASK(0, 63));
+
+    STICKY_RST(PHB_RXE_ARB_ERR_STATUS,       0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_RXE_ARB_ERR1_STATUS,      0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_RXE_ARB_ERR_LOG_0,        0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_RXE_ARB_ERR_LOG_1,        0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_RXE_ARB_ERR_STATUS_MASK,  0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_RXE_ARB_ERR1_STATUS_MASK, 0, PPC_BITMASK(0, 63));
+
+    STICKY_RST(PHB_RXE_MRG_ERR_STATUS,       0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_RXE_MRG_ERR1_STATUS,      0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_RXE_MRG_ERR_STATUS_MASK,  0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_RXE_MRG_ERR1_STATUS_MASK, 0, PPC_BITMASK(0, 63));
+
+    STICKY_RST(PHB_RXE_TCE_ERR_STATUS,       0, PPC_BITMASK(0, 35));
+    STICKY_RST(PHB_RXE_TCE_ERR1_STATUS,      0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_RXE_TCE_ERR_LOG_0,        0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_RXE_TCE_ERR_LOG_1,        0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_RXE_TCE_ERR_STATUS_MASK,  0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_RXE_TCE_ERR1_STATUS_MASK, 0, PPC_BITMASK(0, 63));
+}
+
+static void pnv_phb4_pcie_stack_reg_reset(PnvPHB4 *phb)
+{
+    STICKY_RST(PHB_PCIE_CRESET, 0xE000000000000000, \
+                        (PHB_PCIE_CRESET_PERST_N | PHB_PCIE_CRESET_REFCLK_N));
+    STICKY_RST(PHB_PCIE_DLP_ERRLOG1,             0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_PCIE_DLP_ERRLOG2,             0, PPC_BITMASK(0, 31));
+    STICKY_RST(PHB_PCIE_DLP_ERR_STATUS,          0, PPC_BITMASK(0, 15));
+}
+
+static void pnv_phb4_regb_err_reg_reset(PnvPHB4 *phb)
+{
+    STICKY_RST(PHB_REGB_ERR_STATUS,       0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_REGB_ERR1_STATUS,      0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_REGB_ERR_LOG_0,        0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_REGB_ERR_LOG_1,        0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_REGB_ERR_STATUS_MASK,  0, PPC_BITMASK(0, 63));
+    STICKY_RST(PHB_REGB_ERR1_STATUS_MASK, 0, PPC_BITMASK(0, 63));
+}
+
 static void pnv_phb4_reset(Object *obj, ResetType type)
 {
     PnvPHB4 *phb = PNV_PHB4(obj);
 
     pnv_phb4_pbl_core_reset(phb);
+    pnv_phb4_err_reg_reset(phb);
+    pnv_phb4_pcie_stack_reg_reset(phb);
+    pnv_phb4_regb_err_reg_reset(phb);
 }
 
 static void pnv_phb4_instance_init(Object *obj)
diff --git a/hw/pci-host/pnv_phb5.c b/hw/pci-host/pnv_phb5.c
index decfd2ba68..4906a82c6f 100644
--- a/hw/pci-host/pnv_phb5.c
+++ b/hw/pci-host/pnv_phb5.c
@@ -25,16 +25,6 @@
 #include "trace.h"
 #include "system/reset.h"
 
-/*
- * Get the PCI-E capability offset from the root-port
- */
-static uint32_t get_exp_offset(PCIDevice *pdev)
-{
-    PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(pdev);
-
-    return rpc->exp_offset;
-}
-
 void pnv_phb5_cfg_core_reset(PCIDevice *d)
 {
     uint8_t *conf = d->config;
@@ -81,6 +71,15 @@ void pnv_phb5_cfg_core_reset(PCIDevice *d)
     pci_set_long(conf + P16_ECAP, 0x22410026);
     pci_set_long(conf + P32_ECAP, 0x1002A);
     pci_set_long(conf + P32_CAP,  0x103);
+
+    /* Sticky reset */
+    RC_CONFIG_STICKY_RESET(exp_offset + PCI_EXP_LNKCTL2,
+                                          PCI_EXP_LNKCTL2_TLS_32_0GT, 0xFEFFBF);
+    RC_CONFIG_STICKY_RESET(P16_STAT,          0,    0x1F);
+    RC_CONFIG_STICKY_RESET(P16_LDPM,          0,    0xFFFF);
+    RC_CONFIG_STICKY_RESET(P16_FRDPM,         0,    0xFFFF);
+    RC_CONFIG_STICKY_RESET(P16_SRDPM,         0,    0xFFFF);
+    RC_CONFIG_STICKY_RESET(P32_CTL,           0,    0x3);
 }
 
 static void pnv_phb5_pbl_core_reset(PnvPHB4 *phb)
diff --git a/include/hw/pci-host/pnv_phb4.h b/include/hw/pci-host/pnv_phb4.h
index 0d558f0c55..95ba26db53 100644
--- a/include/hw/pci-host/pnv_phb4.h
+++ b/include/hw/pci-host/pnv_phb4.h
@@ -215,5 +215,22 @@ struct PnvPhb4PecClass {
     const uint32_t *num_phbs;
 };
 
+/*
+ * Get the PCI-E capability offset from the root-port
+ */
+uint32_t get_exp_offset(PCIDevice *pdev);
+
+/*
+ * Apply sticky-mask 's' to the reset-value 'v' and write to the address 'a'.
+ * RC-config space values and masks are LE.
+ * Method pnv_phb4_rc_config_read() returns BE, hence convert to LE.
+ * Compute new value in LE domain.
+ * New value computation using sticky-mask is in LE.
+ * Convert the computed value from LE to BE before writing back.
+ */
+#define RC_CONFIG_STICKY_RESET(a, v, s) \
+    (pci_set_word(conf + (a), be16_to_cpu( \
+                     (be16_to_cpu(pci_get_word(conf + (a))) & (s)) | \
+                     ((v) & ~(s)))))
 
 #endif /* PCI_HOST_PNV_PHB4_H */
diff --git a/include/hw/pci-host/pnv_phb4_regs.h b/include/hw/pci-host/pnv_phb4_regs.h
index d756b6bb4f..59329068d3 100644
--- a/include/hw/pci-host/pnv_phb4_regs.h
+++ b/include/hw/pci-host/pnv_phb4_regs.h
@@ -344,13 +344,23 @@
 #define   PHB_RC_CONFIG_SIZE                    0x800
 
 #define PHB_AER_ECAP                            0x100
+#define PHB_AER_UERR                            0x104
+#define PHB_AER_UERR_MASK                       0x108
+#define PHB_AER_CERR                            0x110
 #define PHB_AER_CAPCTRL                         0x118
+#define PHB_AER_HLOG_1                          0x11C
+#define PHB_AER_HLOG_2                          0x120
+#define PHB_AER_HLOG_3                          0x124
+#define PHB_AER_HLOG_4                          0x128
+#define PHB_AER_RERR                            0x130
+#define PHB_AER_ESID                            0x134
 #define PHB_SEC_ECAP                            0x148
 #define PHB_LMR_ECAP                            0x1A0
 #define PHB_LMR_CTLSTA_2                        0x1AC
 #define PHB_LMR_CTLSTA_16                       0x1E4
 #define PHB_DLF_ECAP                            0x1E8
 #define PHB_DLF_CAP                             0x1EC
+#define PHB_DLF_STAT                            0x1F0
 
 /* PHB4 REGB registers */
 
@@ -385,8 +395,7 @@
 #define   PHB_PCIE_CRESET_PBL           PPC_BIT(2)
 #define   PHB_PCIE_CRESET_PERST_N       PPC_BIT(3)
 #define   PHB_PCIE_CRESET_PIPE_N        PPC_BIT(4)
-
-
+#define   PHB_PCIE_CRESET_REFCLK_N      PPC_BIT(8)
 #define PHB_PCIE_HOTPLUG_STATUS         0x1A20
 #define   PHB_PCIE_HPSTAT_PRESENCE      PPC_BIT(10)
 
diff --git a/include/hw/pci-host/pnv_phb5.h b/include/hw/pci-host/pnv_phb5.h
index a1d0b4d2b0..d76846068a 100644
--- a/include/hw/pci-host/pnv_phb5.h
+++ b/include/hw/pci-host/pnv_phb5.h
@@ -34,9 +34,14 @@ void pnv_phb5_cfg_core_reset(PCIDevice *d);
 
 /* New registers in PHB5 from PHB4 */
 #define P16_ECAP                                0x1F4
+#define P16_STAT                                0x200
+#define P16_LDPM                                0x204
+#define P16_FRDPM                               0x208
+#define P16_SRDPM                               0x20C
 #define P32_ECAP                                0x224
 #define P32_CAP                                 0x228
-
+#define P32_CTL                                 0x22C
+#define P32_STAT                                0x230
 #define PHB_PCIE_PHY_RXEQ_STAT_G3_00_03         0x1B40
 #define PHB_PCIE_PHY_RXEQ_STAT_G5_12_15         0x1B98
 
diff --git a/tests/qtest/pnv-phb-test.c b/tests/qtest/pnv-phb-test.c
index 762046338b..7ceb08aff4 100644
--- a/tests/qtest/pnv-phb-test.c
+++ b/tests/qtest/pnv-phb-test.c
@@ -24,6 +24,19 @@
 /* SCOM to PCBA address conversion */
 #define SCOM_TO_PCBA(scom, addr) (((scom) >> 3) + (addr))
 
+/*
+ * Indirect XSCOM write:
+ * - Write 'Indirect Address Register' with register-offset to write.
+ * - Write 'Indirect Data Register' with the value.
+ */
+static void pnv_phb_xscom_write(QTestState *qts, const PnvChip *chip,
+        uint64_t scom, uint32_t indirect_addr, uint32_t indirect_data,
+        uint64_t reg, uint64_t val)
+{
+    qtest_writeq(qts, pnv_xscom_addr(chip, (scom >> 3) + indirect_addr), reg);
+    qtest_writeq(qts, pnv_xscom_addr(chip, (scom >> 3) + indirect_data), val);
+}
+
 /*
  * Indirect XSCOM read::
  * - Write 'Indirect Address Register' with register-offset to read.
@@ -39,6 +52,11 @@ static uint64_t pnv_phb_xscom_read(QTestState *qts, const PnvChip *chip,
                                                               indirect_data)));
 }
 
+#define PHB5_XSCOM_WRITE(a, v) pnv_phb_xscom_write(qts, \
+                                   &pnv_chips[PNV_P10_CHIP_INDEX], PHB5_XSCOM, \
+                                   PHB_SCOM_HV_IND_ADDR, PHB_SCOM_HV_IND_DATA, \
+                                   PPC_BIT(0) | (a), (v))
+
 #define PHB5_XSCOM_READ(a) pnv_phb_xscom_read(qts, \
                                    &pnv_chips[PNV_P10_CHIP_INDEX], PHB5_XSCOM, \
                                    PHB_SCOM_HV_IND_ADDR, PHB_SCOM_HV_IND_DATA, \
@@ -50,6 +68,26 @@ static void phb5_reset_test(QTestState *qts)
     g_assert_cmpuint(PHB5_XSCOM_READ(PHB_PBL_CONTROL), ==, 0xC009000000000000);
 }
 
+/* Check sticky-reset */
+static void phb5_sticky_rst_test(QTestState *qts)
+{
+    uint64_t val;
+
+    /*
+     * Sticky reset test of PHB_PBL_ERR_STATUS.
+     *
+     * Write all 1's to reg PHB_PBL_ERR_INJECT.
+     * Updated value will be copied to reg PHB_PBL_ERR_STATUS.
+     *
+     * Reset PBL core by setting PHB_PCIE_CRESET_PBL in reg PHB_PCIE_CRESET.
+     * Verify the sticky bits are still set.
+     */
+    PHB5_XSCOM_WRITE(PHB_PBL_ERR_INJECT, PPC_BITMASK(0, 63));
+    PHB5_XSCOM_WRITE(PHB_PCIE_CRESET, PHB_PCIE_CRESET_PBL); /*Reset*/
+    val = PHB5_XSCOM_READ(PHB_PBL_ERR_STATUS);
+    g_assert_cmpuint(val, ==, (PPC_BITMASK(0, 9) | PPC_BITMASK(12, 63)));
+}
+
 static void phb5_tests(void)
 {
     QTestState *qts = NULL;
@@ -59,6 +97,9 @@ static void phb5_tests(void)
     /* Check reset value of a register */
     phb5_reset_test(qts);
 
+    /* Check sticky reset of a register */
+    phb5_sticky_rst_test(qts);
+
     qtest_quit(qts);
 }
 
-- 
2.52.0


