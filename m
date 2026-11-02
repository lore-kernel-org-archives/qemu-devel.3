Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E201606A327
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TMX4vs0Y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNqVQ-0004T8-M8; Mon, 02 Nov 2026 06:47:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xNqVJ-0004HB-IH
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 06:47:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xNqVH-0005FQ-9e
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 06:47:09 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29EIVD2720124; Mon, 2 Nov 2026 11:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3DtlP9
 vDNVux5aVC9fSfI/r+XEy7e7DHTHl6962Dgpw=; b=TMX4vs0YhTqh/9HaYhd6NF
 RGPSvI/EE7/QbkPa85lLn/U7aMUMZ+P0f50Pw2utemHdmf+m60ZmKde1uxFX1tNw
 YbP/dThbvUFt+PdTCT9X4f2oQn7l+rdWbc/0CoYK+GMwvcKBx5B1iDc6iYdykpEJ
 TrwTUUWEtLdX3EDswyJ0t1N8qJjYPPheraYEFeRd5AHqCEuDfgcjgphjMYkJTtKu
 +rath3GgONbcS5R9X5nt1HyIFuVEhLSywkWLPSkIQg163HPtgLHQvF+QLbDSSRrK
 /7cGTfgOagwIoxdRszmBtr7Ir9ez+OZuiq3kRkZpjyQbrXpcMyBpe1kt4+uIr6dw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7u3882q-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 11:46:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29K0Rf703065; Mon, 2 Nov 2026 11:46:57 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hntnpwr5c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 11:46:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A2BkrfQ32178778
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Nov 2026 11:46:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8BF3C20043;
 Mon,  2 Nov 2026 11:46:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3762E20040;
 Mon,  2 Nov 2026 11:46:49 +0000 (GMT)
Received: from Mac.com (unknown [9.43.40.115])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  2 Nov 2026 11:46:48 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Saif Abrar <saif.abrar@linux.vnet.ibm.com>,
 Saif Abrar <saif.abrar@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Caleb Schlossin <calebs@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>
Subject: [PULL 7/9] pnv/phb5: Set link speed and width in the DLP training
 control register
Date: Mon,  2 Nov 2026 17:15:55 +0530
Message-ID: <20261102114558.62509-8-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261102114558.62509-1-harshpb@linux.ibm.com>
References: <20261102114558.62509-1-harshpb@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Zsp4uN7G c=1 sm=1 tr=0 ts=6ae87832 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=aow-egSQAAAA:8 a=20KFwNOVAAAA:8
 a=-b7IsxyX4n235a3dhHEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-ORIG-GUID: d_hkwVKtBgwb0ghGl0Yp1VNa0QC9RXrp
X-Proofpoint-GUID: d_hkwVKtBgwb0ghGl0Yp1VNa0QC9RXrp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0NiBTYWx0ZWRfX9RTDo7tosKgR
 vCScwItuhkXRq1/EbDltLtcpe5sLcDj1q9+jO7sFHRT/ZMFdqk2ix7xqY4tCZa3vHoeFwEYAKEZ
 XgQ2rPwsN32VboNhE++Yj47rNfb8q6wMt5ThIcBoViTkwVgjdxRnnXQw+2NwTngrwePsk9WUEmk
 HromcV5eJxCyhZ6GmLsNV209YcMiBEZsrhrLcjl6Z3pEU5RbzTP394HN9HENwxpkoZLefleb3PX
 ghDPUpWM2dfH6kA97oiyO0G6qyJCFMtVuxvA/ylow5K+RFAaBfAYkCdEAe9X7nr0olviDdYhR3j
 K5NqTRs4/xQMZX8iZsswN3Hyf2uBG+GACmUQjPCtoGb8GEmztvHlcur2O/qr0SuiJGjlo/g1Uxi
 KPUuPurbvStIeJ32P6QsKTuDHP5Uz/gZGNV0kCeZvniBUZZgkJegDXD0MrOpLVwlPLve5kKtAw/
 5UnHcfBWPMJKO0vXy8g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0NiBTYWx0ZWRfX5L73unAlDG7z
 RLKa66pCi+YSYLSworgwD0ZA6oictg27Qg4qZ02V03YnE0HvmDaIDi76GX5DLNFZFC4saLIxscN
 yQvGIIcOrs22AFWMlc3i/pV5G+fBjM4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020046
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

Get the current link-status from PCIE macro.
Extract link-speed and link-width from the link-status
and set in the DLP training control (PCIE_DLP_TCR) register.

Signed-off-by: Saif Abrar <saif.abrar@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20261029171047.3862430-8-saif.abrar@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/pci-host/pnv_phb4.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 8658b0e5b6..4a49461f4e 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -521,7 +521,7 @@ static uint32_t is_link_active(PnvPHB4 *phb)
     PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
     uint32_t exp_offset = get_exp_offset(pdev);
 
-    return (be16_to_cpu(pnv_phb4_rc_config_read(phb,
+    return (be32_to_cpu(pnv_phb4_rc_config_read(phb,
                         exp_offset + PCI_EXP_LNKSTA, 4)) &
                         PCI_EXP_LNKSTA_DLLLA);
 }
@@ -860,6 +860,7 @@ uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
     PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
     uint32_t exp_base = get_exp_offset(pdev);
     uint64_t val;
+    uint32_t v, lnkstatus;
 
     if ((off & 0xfffc) == PHB_CONFIG_DATA) {
         if (size > 4) {
@@ -926,10 +927,27 @@ uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
         val |= PHB_PCIE_SCR_PLW_X16; /* RO bit */
         break;
 
-    /* Link training always appears trained */
     case PHB_PCIE_DLP_TRAIN_CTL:
-        /* TODO: Do something sensible with speed ? */
+        /* Get the current link-status from PCIE */
+        lnkstatus = be32_to_cpu(pnv_phb4_rc_config_read(phb,
+                                exp_base + PCI_EXP_LNKSTA, 4));
+
+        /* Extract link-speed from the link-status */
+        v = lnkstatus & PCI_EXP_LNKSTA_CLS;
+
+        /* Link training always appears trained */
         val |= PHB_PCIE_DLP_INBAND_PRESENCE | PHB_PCIE_DLP_TL_LINKACT;
+
+        /* Set the current link-speed at the LINK_SPEED position */
+        val = SETFIELD(PHB_PCIE_DLP_LINK_SPEED, val, v);
+
+        /*
+         * Extract link-width from the link-status,
+         * after shifting the required bitfields.
+         */
+        v = (lnkstatus & PCI_EXP_LNKSTA_NLW) >> PCI_EXP_LNKSTA_NLW_SHIFT;
+        /* Set the current link-width at the LINK_WIDTH position */
+        val = SETFIELD(PHB_PCIE_DLP_LINK_WIDTH, val, v);
         return val;
 
     /*
@@ -952,7 +970,7 @@ uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
          * convert the value back to host format.
          * Clear the Presence-status active low bit.
          */
-        if (be16_to_cpu(pnv_phb4_rc_config_read(phb, exp_base + PCI_EXP_SLTSTA,
+        if (be32_to_cpu(pnv_phb4_rc_config_read(phb, exp_base + PCI_EXP_SLTSTA,
                                                 4))
                     & PCI_EXP_SLTSTA_PDS) {
             val &= ~PHB_PCIE_HPSTAT_PRESENCE;
-- 
2.52.0


