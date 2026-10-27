Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC60D606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HOw1ydUj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLdjb-0000ok-Tc; Tue, 27 Oct 2026 05:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1xLdjZ-0000iT-MR; Tue, 27 Oct 2026 05:44:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1xLdjX-0001Rd-97; Tue, 27 Oct 2026 05:44:45 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R5j3rH1528657; Tue, 27 Oct 2026 09:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=XKTckqjRmPVmtiUYU
 tf/v0WPcFLkwS39rEJL7oNWG7M=; b=HOw1ydUjdHyqfsyx8stYCtkWhQm3wZNjq
 SM9yUPmiNJhiDLeeWFeSUahAj+YGscAv1gjV9ZnZXhLxPQrZFK0vhTA6s+ajxrVM
 zFxxu9dYJ8b2IoU6GxSG3Rzl3blpW1putYEP4gTrGQxSFPZgcikxN6q8+HGbdSjU
 CQYRU6/fDSFSNgOBtMhinG3RB6GIu5nNN7BAw/mMsiCpU9q7khLRYbYrs7hsQQgU
 XMgYk0h2DjEt0/TrVPhsJmbeyDQSmjHTT7KJEyd1Hgk9Vz+VTSadtVmXf/nEiot0
 wpakwP33QDDAqbTGNcseo8/XaF+sfigLup9jhYdFnbeE0puhchBjA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmave7re-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2026 09:44:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R5ZFLU3644260; Tue, 27 Oct 2026 09:44:19 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh80jj44f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2026 09:44:19 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69R9iHYF13501064
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Oct 2026 09:44:17 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE62158052;
 Tue, 27 Oct 2026 09:44:17 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF4535805E;
 Tue, 27 Oct 2026 09:44:16 +0000 (GMT)
Received: from gfwr526.rchland.ibm.com (unknown [9.10.239.119])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Oct 2026 09:44:16 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, milesg@linux.ibm.com,
 jishnuvw@linux.ibm.com, adityag@linux.ibm.com, amachhiw@linux.ibm.com
Subject: [PATCH v7 6/9] pnv/phb5: Set link-active status in HPSTAT and LMR
 registers
Date: Tue, 27 Oct 2026 04:43:47 -0500
Message-ID: <20261027094350.3645085-7-saif.abrar@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261027094350.3645085-1-saif.abrar@linux.ibm.com>
References: <20261027094350.3645085-1-saif.abrar@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=P8SvFSAu c=1 sm=1 tr=0 ts=6ae07274 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=SX2aUA2rIF85faSKF8YA:9
X-Proofpoint-GUID: 6D0VC105kpmFruXap1jyhAx_xLg2ojXF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAzOCBTYWx0ZWRfXwqC2Cw+3G6eh
 zOPOTDeyh5BIZnUkYRtmKVH6sbHWv9jzfrWR6vcdhYm0zFmpkxqoJJFEwl8eeTA0ZwwFCAy+UOe
 fA3lqz2Pp+iek7WLH08dxOS02ODhOCg=
X-Proofpoint-ORIG-GUID: DFOFdWu9lOmy6mZq6lyIvL8medxIZltw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAzOCBTYWx0ZWRfX7qcNZOB9YuNI
 XQgk4H+Rkhf88VmEYIft/U9OG6DWD3LqrLLIJUlGeYv8TpNTJ4EKnqlDCIV7y+4P0SOxSP/w/bu
 4XMd2pRN0zI7S9+MVoxCk9czILCgsrMztxGcTIhw3RS+8HDavWfK447sjIpZxrOa18DujKMhw2j
 GkBqdzSFGCHyRsZyJkiuk7A9ZUQ6VHOg9/UcIdG/8n0EuqNiu/kxxkMz3F3oZcP34aC1uDfXHeB
 yp+e+KV8hc7colfVTPfOuIlunenFbqpwzE/PyHL1DPtVx2S5DlXJ7q3dJRJ3ww1m+6unDx9cIgO
 y0UA0TE3B+zyR5C3NuLE2U1ElFQgralV66DAwnMnrJKsKZiAsTLnM4nO+xowzyJLwQlDI9Lct9J
 BalcUkL5b0uaGLu6ag25+tC2SjY2ir+yglQ0e9UMenOvR6BRlwu+7oasRJofr0pptkqmEgMC1Vr
 EWmJZUQoSZYZT0DvAWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270038
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=saif.abrar@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Config-read the link-status register in the PCI-E macro,
Depending on the link-active bit, set the link-active status
in the HOTPLUG_STATUS and LINK_MANAGEMENT registers
Also, clear the Presence-status active low bit in HOTPLUG_STATUS reg
after config-reading the slot-status in the PCI-E macro.

Signed-off-by: Saif Abrar <saif.abrar@linux.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
---
 hw/pci-host/pnv_phb4.c | 61 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 378870268a..014a0a6524 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -507,6 +507,21 @@ uint32_t get_exp_offset(PCIDevice *pdev)
     return rpc->exp_offset;
 }
 
+/*
+ * Config-read the link-status register in the PCI-E macro,
+ * convert to LE and check the link-active bit.
+ */
+static uint32_t is_link_active(PnvPHB4 *phb)
+{
+    PCIHostState *pci = PCI_HOST_BRIDGE(phb->phb_base);
+    PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
+    uint32_t exp_offset = get_exp_offset(pdev);
+
+    return (be16_to_cpu(pnv_phb4_rc_config_read(phb,
+                        exp_offset + PCI_EXP_LNKSTA, 4)) &
+                        PCI_EXP_LNKSTA_DLLLA);
+}
+
 void pnv_phb4_cfg_core_reset(PCIDevice *d)
 {
     uint8_t *conf = d->config;
@@ -679,6 +694,11 @@ void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
         val = 0;
         break;
 
+    case PHB_PCIE_HOTPLUG_STATUS:
+        /* For normal operations, Simspeed diagnostic bit is always zero */
+        val &= PHB_PCIE_HPSTAT_SIMDIAG;
+        break;
+
     /* Read only registers */
     case PHB_CPU_LOADSTORE_STATUS:
     case PHB_ETU_ERR_SUMMARY:
@@ -826,6 +846,10 @@ void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
 uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
 {
     PnvPHB4 *phb = PNV_PHB4(opaque);
+    /* Get the PCI-E capability offset from the root-port */
+    PCIHostState *pci = PCI_HOST_BRIDGE(phb->phb_base);
+    PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
+    uint32_t exp_base = get_exp_offset(pdev);
     uint64_t val;
 
     if ((off & 0xfffc) == PHB_CONFIG_DATA) {
@@ -894,8 +918,38 @@ uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
         val |= PHB_PCIE_DLP_INBAND_PRESENCE | PHB_PCIE_DLP_TL_LINKACT;
         return val;
 
+    /*
+     * Read PCI-E registers and set status for:
+     * - Card present (active low bit 10)
+     * - Link active  (bit 12)
+     */
     case PHB_PCIE_HOTPLUG_STATUS:
-        /* Clear write-only bit */
+        /*
+         * Presence-status bit hpi_present_n is active-low, with reset value 1.
+         * Start by setting this bit to 1, indicating the card is not present.
+         * Then check the PCI-E register and clear the bit if card is present.
+         */
+        val |= PHB_PCIE_HPSTAT_PRESENCE;
+
+        /*
+         * Config-read the PCI-E macro register for slot-status.
+         * Method for config-read converts to BE value.
+         * To check actual bit in the PCI-E register,
+         * convert the value back to host format.
+         * Clear the Presence-status active low bit.
+         */
+        if (be16_to_cpu(pnv_phb4_rc_config_read(phb, exp_base + PCI_EXP_SLTSTA,
+                                                4))
+                    & PCI_EXP_SLTSTA_PDS) {
+            val &= ~PHB_PCIE_HPSTAT_PRESENCE;
+        }
+
+        /* Check if link is active and set the bit */
+        if (is_link_active(phb)) {
+            val |= PHB_PCIE_HPSTAT_LINKACTIVE;
+        }
+
+        /* Clear write-only resample-bit */
         val &= ~PHB_PCIE_HPSTAT_RESAMPLE;
         return val;
 
@@ -903,6 +957,11 @@ uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
     case PHB_PCIE_LMR:
         /* These write-only bits always read as 0 */
         val &= ~(PHB_PCIE_LMR_CHANGELW | PHB_PCIE_LMR_RETRAINLINK);
+
+        /* Check if link is active and set the bit */
+        if (is_link_active(phb)) {
+            val |= PHB_PCIE_LMR_LINKACTIVE;
+        }
         return val;
 
     /* Silent simple reads */
-- 
2.52.0


