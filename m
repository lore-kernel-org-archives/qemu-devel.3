Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C56E606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YcVbwTt6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLdje-0000ux-FM; Tue, 27 Oct 2026 05:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1xLdjb-0000oM-5Y; Tue, 27 Oct 2026 05:44:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1xLdjY-0001Rg-1C; Tue, 27 Oct 2026 05:44:46 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R5ij3b4073420; Tue, 27 Oct 2026 09:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=xogy7i
 VtpXr4bxaUf/1o5XhkHLoRMoq0EZl1rIW5XHg=; b=YcVbwTt6H69zRPWP5aiigC
 El2i6L3+/KAHX5EP+akw9x7vQFIHQLqfp3B27eQeMFjvA7jnhmaT/sjEPBoH9G+Q
 g9mV5eigjTL2FXRdNgzYfHhr0OSc3qPXH00CuD6MhVbabU0ciyvPM08PYcwYm1E3
 AURyRcUoaInHn/KTpG/dDMIP0nTETGzG7hDtn2UBuPVjen6DH98JeLN8n4IlwNo7
 X5vvC2X37WrUx/zRX3MiSIooxInH1XdZNtzaMwm0hzeKxpZ1JHXcS3pjctcBD+R9
 u+wK3t+G1TQqFC8zgVBF/9ljHgW/3lksansZdrmf9zHGpwa7fkuvK0/LZmRtkKoA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmbsxnjd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2026 09:44:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R5Z2l02510951; Tue, 27 Oct 2026 09:44:22 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hh97gsx86-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2026 09:44:22 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69R9iK9M23331428
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Oct 2026 09:44:21 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C910D5805A;
 Tue, 27 Oct 2026 09:44:20 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D23FD58052;
 Tue, 27 Oct 2026 09:44:19 +0000 (GMT)
Received: from gfwr526.rchland.ibm.com (unknown [9.10.239.119])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Oct 2026 09:44:19 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, milesg@linux.ibm.com,
 jishnuvw@linux.ibm.com, adityag@linux.ibm.com, amachhiw@linux.ibm.com
Subject: [PATCH v7 9/9] pnv/phb5: Mask off LSI Source-ID based on number of
 interrupts
Date: Tue, 27 Oct 2026 04:43:50 -0500
Message-ID: <20261027094350.3645085-10-saif.abrar@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261027094350.3645085-1-saif.abrar@linux.ibm.com>
References: <20261027094350.3645085-1-saif.abrar@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAzOCBTYWx0ZWRfX0NFKZi+Ki6fM
 Smp7+3tCz/tV48nJSA/YGBXz2GcOAJd+fvLUcJfa2G277HLaJtAuAt5fVgMa6+Fwuem5ms1CDTI
 fhXcGJLuRCeYhYPd9OhKSBJH9/lLcPKU5esueK7MYYGxnjS0SDKMuIWmVVtjhvnxgu5z8eRrVHh
 XCOej8UgL/uiYlVlliLSG83l2UhgfsRuIfVHjSGo7Z6gbiqv+5r8nJtxnKDLjtf9sdtdGB80Vd0
 ANatSEDopjWBHPoPXL2KcTkvAsFdWeR7dZXtmhAnehGZaCwTNMrceW1wASLQR0sCavxzuEinjTf
 EeDZqndtvDI4CkLLSA30eSDZjLuQ630ESFhzeOlPXOmceRcXstGranHB562ui3jWI4A1xK7Bjji
 S1Ui1fFsQDjlb6GUUOnwV6fPsPTcHb5EyYBu0ZkLEcg/EWM1MBu8fhaJYVbZ9VSdFsAOgEKuiFS
 7MFuC5/ajWcoN1fPMLA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAzOCBTYWx0ZWRfX89dQJxq1iByx
 TNmbX3ftW7AIwlndo74eMI1l54+qXmeEqECGlGfbmm2IMh7SKGtk8y07ZIYkpvrjESFTaXk0lcB
 saZPwwDjwocEOsTxgK40rlqAQV/pKBI=
X-Proofpoint-ORIG-GUID: F3W3pCQc7cOTyCDoLnyZLdTHpUU5PPSr
X-Proofpoint-GUID: TU4gUAy46rNX8eX5mo9fOPCS_VoCHXTE
X-Authority-Analysis: v=2.4 cv=CeKdd7rl c=1 sm=1 tr=0 ts=6ae07277 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kUKHeS9f1dJEPYFD:21 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22
 a=VnNF1IyMAAAA:8 a=aow-egSQAAAA:8 a=-uQQ_z-csOHJncX4BtYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270038
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

Add a method to reset the value of LSI Source-ID.
Mask off LSI source-id based on number of interrupts in the big/small PHB.

Signed-off-by: Saif Abrar <saif.abrar@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
---
 hw/pci-host/pnv_phb4.c         | 12 +++++++++---
 hw/pci-host/pnv_phb5.c         | 17 -----------------
 include/hw/pci-host/pnv_phb5.h | 10 ++++------
 3 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 9983781bd4..6fa9629eb0 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -490,6 +490,7 @@ static void pnv_phb4_update_xsrc(PnvPHB4 *phb)
 
     lsi_base = GETFIELD(PHB_LSI_SRC_ID, phb->regs[PHB_LSI_SOURCE_ID >> 3]);
     lsi_base <<= 3;
+    lsi_base &= (xsrc->nr_irqs - 1);
 
     /* TODO: handle reset values of PHB_LSI_SRC_ID */
     if (!lsi_base) {
@@ -1894,6 +1895,12 @@ static void pnv_phb4_ro_mask_init(PnvPHB4Class *phb4c)
     /* TODO: Add more RO-masks as regs are implemented in the model */
 }
 
+static void pnv_phb4_xsrc_reset(PnvPHB4 *phb)
+{
+    phb->regs[PHB_LSI_SOURCE_ID >> 3] = PPC_BITMASK(4, 12);
+    pnv_phb4_update_xsrc(phb);
+}
+
 static void pnv_phb4_err_reg_reset(PnvPHB4 *phb)
 {
     STICKY_RST(PHB_ERR_STATUS,       0, PPC_BITMASK(0, 33));
@@ -1950,10 +1957,11 @@ static void pnv_phb4_reset(Object *obj, ResetType type)
     PnvPHB4 *phb = PNV_PHB4(obj);
 
     pnv_phb4_pbl_core_reset(phb);
+
+    pnv_phb4_xsrc_reset(phb);
     pnv_phb4_err_reg_reset(phb);
     pnv_phb4_pcie_stack_reg_reset(phb);
     pnv_phb4_regb_err_reg_reset(phb);
-    phb->regs[PHB_PCIE_CRESET >> 3] = 0xE000000000000000;
 }
 
 static void pnv_phb4_instance_init(Object *obj)
@@ -2027,8 +2035,6 @@ void pnv_phb4_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    pnv_phb4_update_xsrc(phb);
-
     phb->qirqs = qemu_allocate_irqs(xive_source_set_irq, xsrc, xsrc->nr_irqs);
 
     pnv_phb4_xscom_realize(phb);
diff --git a/hw/pci-host/pnv_phb5.c b/hw/pci-host/pnv_phb5.c
index b09351f69f..ec6dfbe2b2 100644
--- a/hw/pci-host/pnv_phb5.c
+++ b/hw/pci-host/pnv_phb5.c
@@ -6,24 +6,7 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#include "qemu/osdep.h"
-#include "qemu/log.h"
-#include "qemu/bswap.h"
-#include "qapi/visitor.h"
-#include "qapi/error.h"
-#include "target/ppc/cpu.h"
-#include "hw/pci-host/pnv_phb4_regs.h"
-#include "hw/pci-host/pnv_phb4.h"
 #include "hw/pci-host/pnv_phb5.h"
-#include "hw/pci/pcie_host.h"
-#include "hw/pci/pcie_port.h"
-#include "hw/ppc/pnv.h"
-#include "hw/ppc/pnv_xscom.h"
-#include "hw/core/irq.h"
-#include "hw/core/qdev-properties.h"
-#include "qom/object.h"
-#include "trace.h"
-#include "system/reset.h"
 
 void pnv_phb5_cfg_core_reset(PCIDevice *d)
 {
diff --git a/include/hw/pci-host/pnv_phb5.h b/include/hw/pci-host/pnv_phb5.h
index 4534083fd5..8f1df4892f 100644
--- a/include/hw/pci-host/pnv_phb5.h
+++ b/include/hw/pci-host/pnv_phb5.h
@@ -9,12 +9,10 @@
 #ifndef PCI_HOST_PNV_PHB5_H
 #define PCI_HOST_PNV_PHB5_H
 
-#include "hw/pci-host/pnv_phb.h"
-#include "hw/pci/pci_bus.h"
-#include "hw/ppc/pnv.h"
-#include "hw/ppc/pnv_nest_pervasive.h"
-#include "hw/ppc/xive.h"
-#include "qom/object.h"
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/pci-host/pnv_phb4_regs.h"
+#include "hw/pci-host/pnv_phb4.h"
 
 void pnv_phb5_cfg_core_reset(PCIDevice *d);
 
-- 
2.52.0


