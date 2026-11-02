Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7129606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WEiYhDj9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNqV8-0003yh-BO; Mon, 02 Nov 2026 06:46:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xNqV6-0003vn-PY
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 06:46:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xNqV4-0005Eh-Qm
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 06:46:56 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29EeAD1334736; Mon, 2 Nov 2026 11:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=vtZusW7KQspgu7F2M
 uxLQxJ8uFSAMcaIT0aEsXhn8RY=; b=WEiYhDj9ruo/qa3FCRoojew5dqX+vsLRt
 ndTqVrytmL3x3zk/bZNNkqVYCpGTX3nOYfqYGpDH1RwAdsNGPXQOfEFzDHY/mc0s
 YgmWCUfnMHtzTcMl7v2+WoWZsoUUV5AhuriS6nyV1hdNL9PVCUy7oyZMocvPNkXq
 BbpCgvRj83rmJ2KU43IB/xtqj+aQEWiXp7rE7uMfahALKV+eJKKazjxGOZmykAgf
 Kjqy0lofNfq0XcRp0pbDcS+AGQSskDBuKeZ5TDoDBIXLCI1Q3Zeat1EbKzCXF8nz
 M+v8qtOxTkGB0z/sOJCnx4nPPtwgzkwVGIlVt1cVxgWXkitz3AN5w==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn6rd08g4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 11:46:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29KAnO3711683; Mon, 2 Nov 2026 11:46:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hnvvfne20-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 11:46:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A2Bkmcn45941086
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Nov 2026 11:46:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F84F2004B;
 Mon,  2 Nov 2026 11:46:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6308E20040;
 Mon,  2 Nov 2026 11:46:44 +0000 (GMT)
Received: from Mac.com (unknown [9.43.40.115])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  2 Nov 2026 11:46:43 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Saif Abrar <saif.abrar@linux.vnet.ibm.com>,
 Saif Abrar <saif.abrar@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Caleb Schlossin <calebs@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>
Subject: [PULL 6/9] pnv/phb5: Set link-active status in HPSTAT and LMR
 registers
Date: Mon,  2 Nov 2026 17:15:54 +0530
Message-ID: <20261102114558.62509-7-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261102114558.62509-1-harshpb@linux.ibm.com>
References: <20261102114558.62509-1-harshpb@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DCzCk5py6-r9ELLmhTTLEjUTW0R_a5ru
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0NiBTYWx0ZWRfXx7S5Q2H8sbar
 byqPwrysrJqhkYbUW+f2GvUviRXVK3lD5ewkJTkIEFX+AznROJ7UdIwL4eYY2A1+zwW+y1XNke2
 kElRUUMa9fXwvr4FYLVepfxfc/Y/PLI5oWUG//pGd3uh9IZaQKlG7MxmrLcX6IPPe02c/Hb0hop
 vET5Z/qlIaqdvQf0P0XNI2xIb68qYoE9jyGcdxFFI0VMiQdjoyV2IK69K/MIKqXve7lUiol5Lws
 B/LV7g37Oq4WeIu/dZv00+bPlWv4rwOvtTryTztMF/yHWXlQneeaA2eOEY3kGZFAW7ib6SJqk/Q
 UPUGweNBT1DF67sJlSZMBdceWtSnIC0QBHdj/mHjq3hpIzahePm+moXLY0akS/zB8pHF8HfzMHS
 SNFUm/AMlvyoJe+r7dXUoLxAeFboXxdy9BHbteMAmxPA7fp8wHdIoZyvVAGmj6tbJwc62pTi2Bv
 LbIN4w/GL0o9iGDYGWw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0NiBTYWx0ZWRfXw/2hgsXs5p6X
 RK/SuHgRu76I1SUcrSza0npw43YtN/lEH3+CEhEfhiSet3ONB/TTiXZbBR2EqF5eoE2vgxDkK97
 M+BWe8R11mtYPUldlQyEEdd7qfFVBro=
X-Authority-Analysis: v=2.4 cv=QK391QLL c=1 sm=1 tr=0 ts=6ae8782d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=SX2aUA2rIF85faSKF8YA:9
X-Proofpoint-ORIG-GUID: DCzCk5py6-r9ELLmhTTLEjUTW0R_a5ru
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020046
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Link: https://lore.kernel.org/qemu-devel/20261029171047.3862430-7-saif.abrar@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/pci-host/pnv_phb4.c | 61 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 5aa63f00fa..8658b0e5b6 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -511,6 +511,21 @@ uint32_t get_exp_offset(PCIDevice *pdev)
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
@@ -688,6 +703,11 @@ void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
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
@@ -835,6 +855,10 @@ void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
 uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
 {
     PnvPHB4 *phb = PNV_PHB4(opaque);
+    /* Get the PCI-E capability offset from the root-port */
+    PCIHostState *pci = PCI_HOST_BRIDGE(phb->phb_base);
+    PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
+    uint32_t exp_base = get_exp_offset(pdev);
     uint64_t val;
 
     if ((off & 0xfffc) == PHB_CONFIG_DATA) {
@@ -908,8 +932,38 @@ uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
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
 
@@ -917,6 +971,11 @@ uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
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


