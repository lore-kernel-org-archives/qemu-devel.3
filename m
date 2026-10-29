Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE60606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LtiR/WX3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTfB-0006QE-TG; Thu, 29 Oct 2026 13:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1xMTf3-0006Fv-DT; Thu, 29 Oct 2026 13:11:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1xMTf1-00080o-L2; Thu, 29 Oct 2026 13:11:33 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGEJam409744; Thu, 29 Oct 2026 17:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=GdDbDJ
 OlqMU7cfw55LUH8uYjfsx38RR7txjDsJxEhJ4=; b=LtiR/WX3AuD7jNlQjridQM
 uF9Xhv2fbA+shIhMuA948Trk1mEl1ggaShd/V9DKsnz/XGd3RnydeLrD6ywhqp4k
 sicNGDJhnNRyyrSTgTTTszNX8vIvDkH26wpxspnEoc8gf7db+t+6jjTrlvipx44j
 KFBHdQx2btyL7T84i5ihvGG4uC8bXo60VdhTKAkDdT6VJo8jobabZpBGGCmhrh/T
 qBpa5VK0cFCjgDAuK8Mqayek3UxgqNWYrG/zIHs2c6PHZcfDFdBBib4MVxKvS6bz
 59HaBF2w76raPAsE1kfgXAdoH2V9e66sP34YNxO71VB7Tuq7NOolqp/WvNz9I85A
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgj3mkt79-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:11:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGJnLT3392662; Thu, 29 Oct 2026 17:11:07 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hm69e167j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:11:07 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69THB6cE30016194
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Oct 2026 17:11:06 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 87A8058052;
 Thu, 29 Oct 2026 17:11:06 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0BF3858050;
 Thu, 29 Oct 2026 17:11:05 +0000 (GMT)
Received: from gfwr526.rchland.ibm.com (unknown [9.10.239.119])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Oct 2026 17:11:04 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, milesg@linux.ibm.com,
 jishnuvw@linux.ibm.com, adityag@linux.ibm.com, amachhiw@linux.ibm.com
Subject: [PATCH v7 RESEND 7/9] pnv/phb5: Set link speed and width in the DLP
 training control register
Date: Thu, 29 Oct 2026 12:10:45 -0500
Message-ID: <20261029171047.3862430-8-saif.abrar@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261029171047.3862430-1-saif.abrar@linux.ibm.com>
References: <20261029171047.3862430-1-saif.abrar@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2NSBTYWx0ZWRfXxbVEUTja0AuJ
 cOuOdExoIqRn+p9DgAuOEABbwLICJLJTo7GGZg2pMu3t6hKZfBv6Wk6UVoVAOkmUvFiAXlgy+vy
 5iZn+nvHGgBAJVBzUyNvhFihWEC1B9g=
X-Proofpoint-ORIG-GUID: nyHq7zUoUZ9bG3fTdBYSbo4Wgk9SMXak
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2NSBTYWx0ZWRfX4dzWC2+PXQPL
 3mHldgleJVT8D08Vr6QpmdlVnQS5Nl++9o0v/4MNyC7ys39uKMk8zsTjkcGlemsX2KeiV3uEmiM
 FCHu5/ZIL4M0oNlvyd2v/lUqrccEgM+5AiAWIm3wd4x3uu771ixIitJU+yhqVOTSLasfl3EEAeU
 joop/vVGcLV0k+d9awy+rq0sqPYZFgF/VxRJ3Ss5plPpivF2oN+NaOfCu/B0QBtxAOY+JkhBgUL
 P6YcAiB/9hBPfcX/bbPyaYr0zW0zDtC9KSHJ5t5ACJjWhm2U2BekXnDfPqVU+2iwuANx16cNi4h
 I2bqDUSG2UhdSzN6AO8korqyRUYeLvuddxlUX75/sggNq+ZJYpr2t4NqmUS2MQgcpjt6Zi89aCn
 ER8tzVFIkhIyZOABleG472Sxz/9iwA==
X-Authority-Analysis: v=2.4 cv=G7uJgNk5 c=1 sm=1 tr=0 ts=6ae37e2c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=20KFwNOVAAAA:8 a=-b7IsxyX4n235a3dhHEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-GUID: TAHnAFp7FU1upeUPKYIqGXS6-hNCfqQb
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

Get the current link-status from PCIE macro.
Extract link-speed and link-width from the link-status
and set in the DLP training control (PCIE_DLP_TCR) register.

Signed-off-by: Saif Abrar <saif.abrar@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
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


