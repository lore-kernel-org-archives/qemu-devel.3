Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467E2606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pp2a8+x2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTf8-0006LE-So; Thu, 29 Oct 2026 13:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1xMTf2-0006Fn-A0; Thu, 29 Oct 2026 13:11:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1xMTf0-00080V-JQ; Thu, 29 Oct 2026 13:11:32 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGEIbP409737; Thu, 29 Oct 2026 17:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=kN2z2z
 pwvqfKKyJGFFfzfkGYWKMPBLyflh6HYbvBJc0=; b=pp2a8+x2WXf5ZGiS0vQcqC
 oAn2PKazZGRvJuVTAJH+WZoFuejSSQY4OVJh5hNLttyOwRW6hmTjEPwq5yVV9QtI
 E4PPlWjmrFPWlaWRYE6D8kBd0QV5VZmjT7Bvx/ir71EUFO5xyVcnrOiI1U/7avc6
 qVIv0q3g0Z0UCQkyhYplg3WgEOwEnF7wE/lOzIj1wfSTgJkgDOhrxMEfqlP+pMrQ
 vR66qr/Wd0oz/xkkEETdn9jO/f+xASxHDi0z5WfjAE3JB4wkhgA4Upt1LpdB/cgR
 UV79B6oY6U6sXDFevPIyprq+IPA8WgvhdrWViVA4OVWzgSW1JbhW7pKWLgAKb6OA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgj3mkt7p-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:11:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGJxX12213874; Thu, 29 Oct 2026 17:11:11 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hk010s8wx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:11:11 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69THB9DI49414576
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Oct 2026 17:11:09 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB93D58045;
 Thu, 29 Oct 2026 17:11:09 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4DC2758050;
 Thu, 29 Oct 2026 17:11:08 +0000 (GMT)
Received: from gfwr526.rchland.ibm.com (unknown [9.10.239.119])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Oct 2026 17:11:08 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, milesg@linux.ibm.com,
 jishnuvw@linux.ibm.com, adityag@linux.ibm.com, amachhiw@linux.ibm.com
Subject: [PATCH v7 RESEND 9/9] pnv/phb5: Mask off LSI Source-ID based on
 number of interrupts
Date: Thu, 29 Oct 2026 12:10:47 -0500
Message-ID: <20261029171047.3862430-10-saif.abrar@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261029171047.3862430-1-saif.abrar@linux.ibm.com>
References: <20261029171047.3862430-1-saif.abrar@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2NSBTYWx0ZWRfX7BoGpZTtvJGI
 /BlWD+vIabHgM3olnIg4B+j4bZqUgHGBDBruyI+yK5A6sbW0YFZJh07Xx2vt2NL+ctxyq3eAXC7
 5xn8N/qm4/nsh+jo47Gf7eS+FIJNDIw=
X-Proofpoint-ORIG-GUID: BQx7yECr8GI3dNQmWM9-vZvqCtNuehlA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2NSBTYWx0ZWRfX0rfFpimI1ESw
 FRoh5AcPeUi8FSLdaePb31AN+jMJnUv1zdhOqcaWLdoa6yBj8JFHEfp/qw1RBnX8qLGDhnHvI6r
 ff3xBEjqoiLPAPf1+atDfiz9bG5lqo2lH8FWPm1o2ngQ/vbunpauHPmNmIYju3yGraf5Ewf0jB2
 NSCEX/JR3vd5tNo1e5L3EMt/xkneX37ApIv8NiiebmO/3GDGS2buf6nQvUAP7GqV920D8DMRp30
 he+Id+M38+98wx8axKs7sMcVr9Qt6Pm36uPx1W0VqeWO+NME47npwmZ+s6+p7tImir8Txyny6fR
 q2kqt+4+uTz7W6T1R+pIlWdk0QlvawB5KngLh8tNlrhBohf+2ZT1Kf5q8VJojQ1PintK5vkTJIb
 34rHUr7UWkibWnMlnssHuVCUtr0/vA==
X-Authority-Analysis: v=2.4 cv=G7uJgNk5 c=1 sm=1 tr=0 ts=6ae37e30 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kUKHeS9f1dJEPYFD:21 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22
 a=VnNF1IyMAAAA:8 a=aow-egSQAAAA:8 a=-uQQ_z-csOHJncX4BtYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-GUID: g6saIVi7Gn3a7WrZtTq_4y0xgCgj-5T6
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
index 956d82f551..95318c9d74 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -494,6 +494,7 @@ static void pnv_phb4_update_xsrc(PnvPHB4 *phb)
 
     lsi_base = GETFIELD(PHB_LSI_SRC_ID, phb->regs[PHB_LSI_SOURCE_ID >> 3]);
     lsi_base <<= 3;
+    lsi_base &= (xsrc->nr_irqs - 1);
 
     /* TODO: handle reset values of PHB_LSI_SRC_ID */
     if (!lsi_base) {
@@ -1908,6 +1909,12 @@ static void pnv_phb4_ro_mask_init(PnvPHB4Class *phb4c)
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
@@ -1964,10 +1971,11 @@ static void pnv_phb4_reset(Object *obj, ResetType type)
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
@@ -2041,8 +2049,6 @@ void pnv_phb4_realize(DeviceState *dev, Error **errp)
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


