Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1318D606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rdLYMNpw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTeg-00065R-UU; Thu, 29 Oct 2026 13:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1xMTee-00064W-Fg; Thu, 29 Oct 2026 13:11:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1xMTea-0007xS-La; Thu, 29 Oct 2026 13:11:08 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGEAsU461170; Thu, 29 Oct 2026 17:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=gWMKEo
 2j8omAivPwsvvwaPly6OVa8jzwCSS2mvByMlM=; b=rdLYMNpw2fP2WKb913onY0
 E5+fcV69tUrEtzT+BB/Gps/9kHIi8ICp5NCLKCc6+ZdUSTFhCJsRgMzhvDsFkb//
 SY4miYGTNC76RmGER/RN4pcIVYTMKSkmgc78uKVMmp2SyKLmeg3bfOCNX4VuntVN
 nsXMJ4UXAvZkSXd4KWF5+Y8TvgahapjaxgS6J3J8k497j2bo3kiV8HJ5Vsjd02b7
 QiLHBs8vO5nkfZ2o5IG1vxIXkCSjZu+x61dQ7My4vI7U5RqfBHWbEKuNZ8+m8Dbu
 slaM4HUViBR1wLbU+b0u/Dx1XLL9kotcrVY8NY0Xh0xhh7CdM2IO59xZc+n9hRHA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmd7bnea-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:11:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGJv193329847; Thu, 29 Oct 2026 17:10:59 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hm8qp8ep5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:10:59 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69THAAUZ24904414
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Oct 2026 17:10:10 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 41E7A58045;
 Thu, 29 Oct 2026 17:10:58 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A785E58050;
 Thu, 29 Oct 2026 17:10:56 +0000 (GMT)
Received: from gfwr526.rchland.ibm.com (unknown [9.10.239.119])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Oct 2026 17:10:56 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, milesg@linux.ibm.com,
 jishnuvw@linux.ibm.com, adityag@linux.ibm.com, amachhiw@linux.ibm.com
Subject: [PATCH v7 RESEND 2/9] pnv/phb5: Add reset logic to PHB5
Date: Thu, 29 Oct 2026 12:10:40 -0500
Message-ID: <20261029171047.3862430-3-saif.abrar@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261029171047.3862430-1-saif.abrar@linux.ibm.com>
References: <20261029171047.3862430-1-saif.abrar@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ZYOIpcVA c=1 sm=1 tr=0 ts=6ae37e24 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=20KFwNOVAAAA:8 a=7NgIpF3WJFelaHDZircA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2NSBTYWx0ZWRfX0g8VXvkAhbE9
 zCT3edF/G5WstlMPl5eG/FiBCnHXSXdEgh40ruMWWvsCJOWWvxEIu/R1gDqHefuyDD8xYbl2jGI
 ErMarorD1BJj1cd9Z0miC1aq6/0VDu+0del1FRlGoHe9AzLwNlDvl/42erFaGnb9+ei1mKlIkDA
 5o54B4OxxSqHwlTRCpGw9rPeveCVRoUklZywaYDyarXIGJzhNORJbwTr5NxoNHjm4oaAbJJ1ZaM
 NNQmnRr2ZSd4JInOxYD53Gz6CYpQOsdomE/9Ut1kqVm4k9PU1ibWmnkcZV5Vmj3wtQjyZeiRU9C
 +is5JVSvY/Lol3L7pe3aVxDKJ4SC+I2mbb0al4PMvuVGD7sLf9nh9fLL2HRKSypDBLWxnJ0cNMk
 tLVJRJ3KA/Lf7//kpx8ILmGK/a6wiLmO+ogjNjm+WTPa601/mW9h2pWluGJCwUKJa6pwwA/48RA
 RMJVqxB9CD0DZEUdFGQ==
X-Proofpoint-GUID: ZxzNVLBFZ0oFN5g6x7qN48igAOzKCzrJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2NSBTYWx0ZWRfXzKIJtUtz+5I+
 pbxUvM5io7exnwZCdyTft7vMGNjIT2dWuaM0Yx6ELFbp6Rj3UXDAsyUGIoHJ+ZIE8ozVDDY4/kx
 0tAHVvptzAaasjoOjeyqnnMKXT/OGH4=
X-Proofpoint-ORIG-GUID: 1hRo9SXHKl2XwxbwFThf7_tuSpHFMUZj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290065
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=saif.abrar@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a method to be invoked on QEMU reset.
Also add CFG and PBL core-blocks reset logic using
appropriate bits of PHB_PCIE_CRESET register.

Tested by reading the reset value of a register.

Signed-off-by: Saif Abrar <saif.abrar@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
---
 hw/pci-host/pnv_phb.c               |  20 +++---
 hw/pci-host/pnv_phb4.c              |  58 +++++++++++++++-
 hw/pci-host/pnv_phb4_pec.c          |   2 +-
 hw/pci-host/pnv_phb5.c              | 103 ++++++++++++++++++++++++++++
 hw/pci-host/pnv_phb5_pec.c          |   1 +
 hw/ppc/pnv.c                        |   1 +
 include/hw/pci-host/pnv_phb4.h      |  14 +---
 include/hw/pci-host/pnv_phb4_regs.h |  11 ++-
 include/hw/pci-host/pnv_phb5.h      |  44 ++++++++++++
 tests/qtest/pnv-phb-test.c          |  33 ++++++++-
 10 files changed, 257 insertions(+), 30 deletions(-)
 create mode 100644 include/hw/pci-host/pnv_phb5.h

diff --git a/hw/pci-host/pnv_phb.c b/hw/pci-host/pnv_phb.c
index 0b556d1bf5..75f8b2a549 100644
--- a/hw/pci-host/pnv_phb.c
+++ b/hw/pci-host/pnv_phb.c
@@ -14,6 +14,7 @@
 #include "hw/pci-host/pnv_phb.h"
 #include "hw/pci-host/pnv_phb3.h"
 #include "hw/pci-host/pnv_phb4.h"
+#include "hw/pci-host/pnv_phb5.h"
 #include "hw/ppc/pnv.h"
 #include "hw/core/qdev-properties.h"
 #include "qom/object.h"
@@ -210,7 +211,6 @@ static void pnv_phb_root_port_reset_hold(Object *obj, ResetType type)
     PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(obj);
     PnvPHBRootPort *phb_rp = PNV_PHB_ROOT_PORT(obj);
     PCIDevice *d = PCI_DEVICE(obj);
-    uint8_t *conf = d->config;
 
     if (rpc->parent_phases.hold) {
         rpc->parent_phases.hold(obj, type);
@@ -221,17 +221,13 @@ static void pnv_phb_root_port_reset_hold(Object *obj, ResetType type)
     }
 
     /* PHB4 and later requires these extra reset steps */
-    pci_byte_test_and_set_mask(conf + PCI_IO_BASE,
-                               PCI_IO_RANGE_MASK & 0xff);
-    pci_byte_test_and_clear_mask(conf + PCI_IO_LIMIT,
-                                 PCI_IO_RANGE_MASK & 0xff);
-    pci_set_word(conf + PCI_MEMORY_BASE, 0);
-    pci_set_word(conf + PCI_MEMORY_LIMIT, 0xfff0);
-    pci_set_word(conf + PCI_PREF_MEMORY_BASE, 0x1);
-    pci_set_word(conf + PCI_PREF_MEMORY_LIMIT, 0xfff1);
-    pci_set_long(conf + PCI_PREF_BASE_UPPER32, 0x1); /* Hack */
-    pci_set_long(conf + PCI_PREF_LIMIT_UPPER32, 0xffffffff);
-    pci_config_set_interrupt_pin(conf, 0);
+    pnv_phb4_cfg_core_reset(d);
+
+    if (phb_rp->version == 4) {
+        return;
+    }
+
+    pnv_phb5_cfg_core_reset(d);
 }
 
 static void pnv_phb_root_port_realize(DeviceState *dev, Error **errp)
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index ac09a0b034..12a5834f61 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -1,7 +1,7 @@
 /*
  * QEMU PowerPC PowerNV (POWER9) PHB4 model
  *
- * Copyright (c) 2018-2020, IBM Corporation.
+ * Copyright (c) 2018-2026, IBM Corporation.
  *
  * This code is licensed under the GPL version 2 or later. See the
  * COPYING file in the top-level directory.
@@ -22,6 +22,7 @@
 #include "hw/core/qdev-properties.h"
 #include "qom/object.h"
 #include "trace.h"
+#include "system/reset.h"
 
 #define phb_error(phb, fmt, ...)                                        \
     qemu_log_mask(LOG_GUEST_ERROR, "phb4[%d:%d]: " fmt "\n",            \
@@ -503,6 +504,37 @@ static void pnv_phb4_update_xsrc(PnvPHB4 *phb)
     }
 }
 
+void pnv_phb4_cfg_core_reset(PCIDevice *d)
+{
+    uint8_t *conf = d->config;
+
+    pci_byte_test_and_set_mask(conf + PCI_IO_BASE,
+                               PCI_IO_RANGE_MASK & 0xff);
+    pci_byte_test_and_clear_mask(conf + PCI_IO_LIMIT,
+                                 PCI_IO_RANGE_MASK & 0xff);
+    pci_set_word(conf + PCI_MEMORY_BASE, 0);
+    pci_set_word(conf + PCI_MEMORY_LIMIT, 0xfff0);
+    pci_set_word(conf + PCI_PREF_MEMORY_BASE, 0x1);
+    pci_set_word(conf + PCI_PREF_MEMORY_LIMIT, 0xfff1);
+    pci_set_long(conf + PCI_PREF_BASE_UPPER32, 0x1); /* Hack */
+    pci_set_long(conf + PCI_PREF_LIMIT_UPPER32, 0xffffffff);
+    pci_config_set_interrupt_pin(conf, 0);
+}
+
+static void pnv_phb4_pbl_core_reset(PnvPHB4 *phb)
+{
+    /* Zero all PBL registers initially */
+    for (int i = PHB_PBL_CONTROL ; i <= PHB_PBL_ERR1_STATUS_MASK ; i += 8) {
+        phb->regs[i >> 3] = 0x0;
+    }
+
+    /* Set PHB4 specific register values */
+    phb->regs[PHB_PBL_CONTROL       >> 3] = 0xC00000000000000;
+    phb->regs[PHB_PBL_TIMEOUT_CTRL  >> 3] = 0x2020000000000000;
+    phb->regs[PHB_PBL_NPTAG_ENABLE  >> 3] = 0xFF00000000000000;
+    phb->regs[PHB_PBL_SYS_LINK_INIT >> 3] = 0x80088B4642470000;
+}
+
 static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
                                unsigned size)
 {
@@ -621,6 +653,18 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
         pnv_phb4_update_xsrc(phb);
         break;
 
+    /* Reset core blocks */
+    case PHB_PCIE_CRESET:
+        if (val & PHB_PCIE_CRESET_CFG_CORE) {
+            PCIHostState *pci = PCI_HOST_BRIDGE(phb->phb_base);
+
+            pnv_phb4_cfg_core_reset(pci_find_device(pci->bus, 0, 0));
+        }
+        if (val & PHB_PCIE_CRESET_PBL) {
+            pnv_phb4_pbl_core_reset(phb);
+        }
+        break;
+
     /* Silent simple writes */
     case PHB_ASN_CMPM:
     case PHB_CONFIG_ADDRESS:
@@ -1546,6 +1590,13 @@ static PCIIOMMUOps pnv_phb4_iommu_ops = {
     .get_address_space = pnv_phb4_dma_iommu,
 };
 
+static void pnv_phb4_reset(Object *obj, ResetType type)
+{
+    PnvPHB4 *phb = PNV_PHB4(obj);
+
+    pnv_phb4_pbl_core_reset(phb);
+}
+
 static void pnv_phb4_instance_init(Object *obj)
 {
     PnvPHB4 *phb = PNV_PHB4(obj);
@@ -1622,6 +1673,8 @@ static void pnv_phb4_realize(DeviceState *dev, Error **errp)
     phb->qirqs = qemu_allocate_irqs(xive_source_set_irq, xsrc, xsrc->nr_irqs);
 
     pnv_phb4_xscom_realize(phb);
+
+    qemu_register_resettable(OBJECT(dev));
 }
 
 /*
@@ -1715,12 +1768,15 @@ static void pnv_phb4_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     XiveNotifierClass *xfc = XIVE_NOTIFIER_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     dc->realize         = pnv_phb4_realize;
     device_class_set_props(dc, pnv_phb4_properties);
     dc->user_creatable  = false;
 
     xfc->notify         = pnv_phb4_xive_notify;
+
+    rc->phases.enter = pnv_phb4_reset;
 }
 
 static const TypeInfo pnv_phb4_type_info = {
diff --git a/hw/pci-host/pnv_phb4_pec.c b/hw/pci-host/pnv_phb4_pec.c
index ee5cdc3e45..8f9eab8fff 100644
--- a/hw/pci-host/pnv_phb4_pec.c
+++ b/hw/pci-host/pnv_phb4_pec.c
@@ -13,6 +13,7 @@
 #include "hw/ppc/fdt.h"
 #include "hw/pci-host/pnv_phb4_regs.h"
 #include "hw/pci-host/pnv_phb4.h"
+#include "hw/pci-host/pnv_phb5.h"
 #include "hw/ppc/pnv_xscom.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_bus.h"
@@ -20,7 +21,6 @@
 #include "hw/ppc/pnv_chip.h"
 #include "hw/core/qdev-properties.h"
 #include "system/system.h"
-
 #include <libfdt.h>
 
 #define phb_pec_error(pec, fmt, ...)                                    \
diff --git a/hw/pci-host/pnv_phb5.c b/hw/pci-host/pnv_phb5.c
index c3f2e16ce6..decfd2ba68 100644
--- a/hw/pci-host/pnv_phb5.c
+++ b/hw/pci-host/pnv_phb5.c
@@ -7,12 +7,115 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/bswap.h"
+#include "qapi/visitor.h"
+#include "qapi/error.h"
+#include "target/ppc/cpu.h"
+#include "hw/pci-host/pnv_phb4_regs.h"
 #include "hw/pci-host/pnv_phb4.h"
+#include "hw/pci-host/pnv_phb5.h"
+#include "hw/pci/pcie_host.h"
+#include "hw/pci/pcie_port.h"
+#include "hw/ppc/pnv.h"
+#include "hw/ppc/pnv_xscom.h"
+#include "hw/core/irq.h"
+#include "hw/core/qdev-properties.h"
+#include "qom/object.h"
+#include "trace.h"
+#include "system/reset.h"
+
+/*
+ * Get the PCI-E capability offset from the root-port
+ */
+static uint32_t get_exp_offset(PCIDevice *pdev)
+{
+    PCIERootPortClass *rpc = PCIE_ROOT_PORT_GET_CLASS(pdev);
+
+    return rpc->exp_offset;
+}
+
+void pnv_phb5_cfg_core_reset(PCIDevice *d)
+{
+    uint8_t *conf = d->config;
+    uint32_t exp_offset = get_exp_offset(d);
+
+    pci_set_word(conf + PCI_COMMAND, PCI_COMMAND_SERR);
+    pci_set_word(conf + PCI_STATUS, PCI_STATUS_CAP_LIST);
+    pci_set_long(conf + PCI_CLASS_REVISION, 0x06040000);
+    pci_set_long(conf + PCI_CACHE_LINE_SIZE, BIT(16));
+    pci_set_word(conf + PCI_MEMORY_BASE, BIT(4));
+    pci_set_word(conf + PCI_PREF_MEMORY_BASE, BIT(0) | BIT(4));
+    pci_set_word(conf + PCI_PREF_MEMORY_LIMIT, PCI_PREF_RANGE_TYPE_64);
+    pci_set_long(conf + PCI_CAPABILITY_LIST, BIT(6));
+    pci_set_word(conf + PCI_BRIDGE_CONTROL, PCI_BRIDGE_CTL_SERR);
+    pci_set_long(conf + PCI_BRIDGE_CONTROL + PCI_PM_PMC, 0xC8034801);
+
+    pci_set_long(conf + exp_offset, 0x420010);
+    pci_set_long(conf + exp_offset + PCI_EXP_DEVCAP,  0x8022);
+    pci_set_long(conf + exp_offset + PCI_EXP_DEVCTL, PCI_EXP_DEVCTL_EXT_TAG
+                                              | PCI_EXP_DEVCTL_PAYLOAD_512B);
+    pci_set_long(conf + exp_offset + PCI_EXP_LNKCAP, PCI_EXP_LNKCAP_LBNC
+                 | PCI_EXP_LNKCAP_DLLLARC | BIT(8) | PCI_EXP_LNKCAP_SLS_32_0GB);
+    pci_set_word(conf + exp_offset + PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_RCB);
+    pci_set_long(conf + exp_offset + PCI_EXP_SLTCTL,
+                                                   PCI_EXP_SLTCTL_ASPL_DISABLE);
+    pci_set_long(conf + exp_offset + PCI_EXP_DEVCAP2, BIT(16)
+                  | PCI_EXP_DEVCAP2_ARI | PCI_EXP_DEVCAP2_COMP_TMOUT_DIS | 0xF);
+    pci_set_long(conf + exp_offset + PCI_EXP_DEVCTL2, PCI_EXP_DEVCTL2_ARI);
+    pci_set_long(conf + exp_offset + PCI_EXP_LNKCAP2, BIT(23)
+                       | PCI_EXP_LNKCAP2_SLS_32_0GB
+                       | PCI_EXP_LNKCAP2_SLS_16_0GB | PCI_EXP_LNKCAP2_SLS_8_0GB
+                       | PCI_EXP_LNKCAP2_SLS_5_0GB | PCI_EXP_LNKCAP2_SLS_2_5GB);
+    pci_set_long(conf + PHB_AER_ECAP, PCI_EXT_CAP(0x1, 0x1, 0x148));
+    pci_set_long(conf + PHB_SEC_ECAP, (0x1A0 << 20) | BIT(16)
+                                                       | PCI_EXT_CAP_ID_SECPCI);
+    pci_set_long(conf + PHB_LMR_ECAP, 0x1E810027);
+    /* LMR - Margining Lane Control / Status Register # 2 to 16 */
+    for (int i = PHB_LMR_CTLSTA_2 ; i <= PHB_LMR_CTLSTA_16 ; i += 4) {
+        pci_set_long(conf + i, 0x9C38);
+    }
+
+    pci_set_long(conf + PHB_DLF_ECAP, 0x1F410025);
+    pci_set_long(conf + PHB_DLF_CAP,  0x80000001);
+    pci_set_long(conf + P16_ECAP, 0x22410026);
+    pci_set_long(conf + P32_ECAP, 0x1002A);
+    pci_set_long(conf + P32_CAP,  0x103);
+}
+
+static void pnv_phb5_pbl_core_reset(PnvPHB4 *phb)
+{
+    /* Zero all PBL registers initially */
+    for (int i = PHB_PBL_CONTROL ; i <= PHB_PBL_ERR1_STATUS_MASK ; i += 8) {
+        phb->regs[i >> 3] = 0x0;
+    }
+
+    /* Set PHB5 specific register values */
+    phb->regs[PHB_PBL_CONTROL       >> 3] = 0xC009000000000000;
+    phb->regs[PHB_PBL_TIMEOUT_CTRL  >> 3] = 0x2020000000000000;
+    phb->regs[PHB_PBL_NPTAG_ENABLE  >> 3] = 0xFFFFFFFF00000000;
+    phb->regs[PHB_PBL_SYS_LINK_INIT >> 3] = 0x80088B4642473000;
+}
+
+static void pnv_phb5_reset(Object *obj, ResetType type)
+{
+    PnvPHB4 *phb = PNV_PHB4(obj);
+
+    pnv_phb5_pbl_core_reset(phb);
+}
+
+static void pnv_phb5_class_init(ObjectClass *klass, const void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.enter = pnv_phb5_reset;
+}
 
 static const TypeInfo pnv_phb5_type_info = {
     .name          = TYPE_PNV_PHB5,
     .parent        = TYPE_PNV_PHB4,
     .instance_size = sizeof(PnvPHB4),
+    .class_init    = pnv_phb5_class_init
 };
 
 static void pnv_phb5_register_types(void)
diff --git a/hw/pci-host/pnv_phb5_pec.c b/hw/pci-host/pnv_phb5_pec.c
index 488ccbfb12..f30d8b772c 100644
--- a/hw/pci-host/pnv_phb5_pec.c
+++ b/hw/pci-host/pnv_phb5_pec.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/pci-host/pnv_phb4.h"
+#include "hw/pci-host/pnv_phb5.h"
 #include "hw/ppc/pnv_xscom.h"
 
 #define XPEC_PCI_CPLT_OFFSET                        0x1000000ULL
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index f0413639f9..f9478545ff 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -49,6 +49,7 @@
 #include "hw/pci-host/pnv_phb.h"
 #include "hw/pci-host/pnv_phb3.h"
 #include "hw/pci-host/pnv_phb4.h"
+#include "hw/pci-host/pnv_phb5.h"
 
 #include "hw/ppc/xics.h"
 #include "hw/core/qdev-properties.h"
diff --git a/include/hw/pci-host/pnv_phb4.h b/include/hw/pci-host/pnv_phb4.h
index de996e718b..0d558f0c55 100644
--- a/include/hw/pci-host/pnv_phb4.h
+++ b/include/hw/pci-host/pnv_phb4.h
@@ -160,6 +160,7 @@ void pnv_phb4_pic_print_info(PnvPHB4 *phb, GString *buf);
 int pnv_phb4_pec_get_phb_id(PnvPhb4PecState *pec, int stack_index);
 PnvPhb4PecState *pnv_pec_add_phb(PnvChip *chip, PnvPHB *phb, Error **errp);
 void pnv_phb4_bus_init(DeviceState *dev, PnvPHB4 *phb);
+void pnv_phb4_cfg_core_reset(PCIDevice *d);
 extern const MemoryRegionOps pnv_phb4_xscom_ops;
 
 /*
@@ -214,18 +215,5 @@ struct PnvPhb4PecClass {
     const uint32_t *num_phbs;
 };
 
-/*
- * POWER10 definitions
- */
-
-#define TYPE_PNV_PHB5 "pnv-phb5"
-#define PNV_PHB5(obj) \
-    OBJECT_CHECK(PnvPhb4, (obj), TYPE_PNV_PHB5)
-
-#define PNV_PHB5_VERSION           0x000000a500000002ull
-
-#define TYPE_PNV_PHB5_PEC "pnv-phb5-pec"
-#define PNV_PHB5_PEC(obj) \
-    OBJECT_CHECK(PnvPhb4PecState, (obj), TYPE_PNV_PHB5_PEC)
 
 #endif /* PCI_HOST_PNV_PHB4_H */
diff --git a/include/hw/pci-host/pnv_phb4_regs.h b/include/hw/pci-host/pnv_phb4_regs.h
index bea96f4d91..d756b6bb4f 100644
--- a/include/hw/pci-host/pnv_phb4_regs.h
+++ b/include/hw/pci-host/pnv_phb4_regs.h
@@ -343,6 +343,15 @@
 #define PHB_RC_CONFIG_BASE                      0x1000
 #define   PHB_RC_CONFIG_SIZE                    0x800
 
+#define PHB_AER_ECAP                            0x100
+#define PHB_AER_CAPCTRL                         0x118
+#define PHB_SEC_ECAP                            0x148
+#define PHB_LMR_ECAP                            0x1A0
+#define PHB_LMR_CTLSTA_2                        0x1AC
+#define PHB_LMR_CTLSTA_16                       0x1E4
+#define PHB_DLF_ECAP                            0x1E8
+#define PHB_DLF_CAP                             0x1EC
+
 /* PHB4 REGB registers */
 
 /* PBL core */
@@ -368,7 +377,7 @@
 #define PHB_PCIE_SCR                    0x1A00
 #define   PHB_PCIE_SCR_SLOT_CAP         PPC_BIT(15)
 #define   PHB_PCIE_SCR_MAXLINKSPEED     PPC_BITMASK(32, 35)
-
+#define PHB_PCIE_BNR                    0x1A08
 
 #define PHB_PCIE_CRESET                 0x1A10
 #define   PHB_PCIE_CRESET_CFG_CORE      PPC_BIT(0)
diff --git a/include/hw/pci-host/pnv_phb5.h b/include/hw/pci-host/pnv_phb5.h
new file mode 100644
index 0000000000..a1d0b4d2b0
--- /dev/null
+++ b/include/hw/pci-host/pnv_phb5.h
@@ -0,0 +1,44 @@
+/*
+ * QEMU PowerPC PowerNV (POWER10) PHB5 model
+ *
+ * Copyright (c) 2018-2026, IBM Corporation.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef PCI_HOST_PNV_PHB5_H
+#define PCI_HOST_PNV_PHB5_H
+
+#include "hw/pci-host/pnv_phb.h"
+#include "hw/pci/pci_bus.h"
+#include "hw/ppc/pnv.h"
+#include "hw/ppc/pnv_nest_pervasive.h"
+#include "hw/ppc/xive.h"
+#include "qom/object.h"
+
+void pnv_phb5_cfg_core_reset(PCIDevice *d);
+
+/*
+ * POWER10 definitions
+ */
+
+#define TYPE_PNV_PHB5 "pnv-phb5"
+#define PNV_PHB5(obj) \
+    OBJECT_CHECK(PnvPHB4, (obj), TYPE_PNV_PHB5)
+
+#define PNV_PHB5_VERSION           0x000000a500000002ull
+
+#define TYPE_PNV_PHB5_PEC "pnv-phb5-pec"
+#define PNV_PHB5_PEC(obj) \
+    OBJECT_CHECK(PnvPhb4PecState, (obj), TYPE_PNV_PHB5_PEC)
+
+/* New registers in PHB5 from PHB4 */
+#define P16_ECAP                                0x1F4
+#define P32_ECAP                                0x224
+#define P32_CAP                                 0x228
+
+#define PHB_PCIE_PHY_RXEQ_STAT_G3_00_03         0x1B40
+#define PHB_PCIE_PHY_RXEQ_STAT_G5_12_15         0x1B98
+
+
+#endif /* PCI_HOST_PNV_PHB5_H */
diff --git a/tests/qtest/pnv-phb-test.c b/tests/qtest/pnv-phb-test.c
index b4d75a1229..762046338b 100644
--- a/tests/qtest/pnv-phb-test.c
+++ b/tests/qtest/pnv-phb-test.c
@@ -16,7 +16,10 @@
 #define PHB3_PBCQ_SPCI_ASB_ADDR      0x0
 #define PHB3_PBCQ_SPCI_ASB_DATA      0x2
 
-#define PHB4_XSCOM              0x40084800ull
+#define PHB5_XSCOM              0x40084800ull
+
+/* Index of PNV_CHIP_POWER10 in pnv_chips[] within "pnv-xscom.h" */
+#define PNV_P10_CHIP_INDEX      2
 
 /* SCOM to PCBA address conversion */
 #define SCOM_TO_PCBA(scom, addr) (((scom) >> 3) + (addr))
@@ -36,6 +39,29 @@ static uint64_t pnv_phb_xscom_read(QTestState *qts, const PnvChip *chip,
                                                               indirect_data)));
 }
 
+#define PHB5_XSCOM_READ(a) pnv_phb_xscom_read(qts, \
+                                   &pnv_chips[PNV_P10_CHIP_INDEX], PHB5_XSCOM, \
+                                   PHB_SCOM_HV_IND_ADDR, PHB_SCOM_HV_IND_DATA, \
+                                   PPC_BIT(0) | (a))
+
+/* Assert that 'PHB PBL Control' register has correct reset value */
+static void phb5_reset_test(QTestState *qts)
+{
+    g_assert_cmpuint(PHB5_XSCOM_READ(PHB_PBL_CONTROL), ==, 0xC009000000000000);
+}
+
+static void phb5_tests(void)
+{
+    QTestState *qts = NULL;
+
+    qts = qtest_initf("-machine powernv10 -accel tcg");
+
+    /* Check reset value of a register */
+    phb5_reset_test(qts);
+
+    qtest_quit(qts);
+}
+
 /* Assert that 'PHB - Version Register' bits[24:31] are as expected */
 static void phb_version_test(const void *data)
 {
@@ -59,7 +85,7 @@ static void phb_version_test(const void *data)
         expected_ver = 0xA4;
     } else if ((chip->chip_type == PNV_CHIP_POWER10) ||
                (chip->chip_type == PNV_CHIP_POWER11)) {
-        phb_xscom = PHB4_XSCOM;
+        phb_xscom = PHB5_XSCOM;
         indirect_addr = PHB_SCOM_HV_IND_ADDR;
         indirect_data = PHB_SCOM_HV_IND_DATA;
         reg_phb_version |= PPC_BIT(0);
@@ -95,5 +121,8 @@ int main(int argc, char **argv)
     /* PHB[345] tests */
     add_phbX_version_test();
 
+    /* PHB5 specific tests */
+    qtest_add_func("phb5", phb5_tests);
+
     return g_test_run();
 }
-- 
2.52.0


