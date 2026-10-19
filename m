Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB77606A31D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Xjq/G9+b
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIqCo-0002iT-Lx; Mon, 19 Oct 2026 12:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1xIqCM-0002Fl-J2; Mon, 19 Oct 2026 12:26:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1xIqCC-0001Ue-8a; Mon, 19 Oct 2026 12:26:49 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFil7k008615; Mon, 19 Oct 2026 16:26:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=UOMd9CVNx6dvNjr9h
 prNeFYyPSEZBOznzi8OH53vv+g=; b=Xjq/G9+bkQg+4ANwBr9jm7QyLDGBZaABN
 C8wjzZCAV2xCDJfzWcIIMDU590p+Unyd+zyVfjAv93zka/pjXAswgELE2rC2Edbu
 oTqrpnjF3UIDF+gPtjziH605qExUUZwFgegmrlRp5OUZqBU/RTbeUEG4zT3NUw0m
 uBgCqQ4r2/akT9g2xqOSKM7FncaCJbeqy3T/TXJ5keLJ3+lwIl9S+iScnHszwiwD
 YEUFLezGBTn7poqYLvEmi+oHHbUjFBGnuC43xNa/AdVxeQimlhEPXYT/JYgMSVn5
 /1h4G2TyYBGRhji12cfHszoF6yjbqUoK8pamzseuJ2zmLDzUPiFCA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0r7mbfq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 16:26:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFZ54Y171070; Mon, 19 Oct 2026 16:26:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hcp1ye7ux-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 16:26:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69JGQPEJ27066650
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Oct 2026 16:26:27 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A7D6F2004D;
 Mon, 19 Oct 2026 16:26:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D11A720040;
 Mon, 19 Oct 2026 16:26:21 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.ibm.com (unknown [9.124.217.62])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 19 Oct 2026 16:26:21 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Sourabh Bhat <sbhat@linux.ibm.com>, anushree.mathur@linux.vnet.ibm.com,
 clg@redhat.com, Sourabh Jain <sourabhjain@linux.ibm.com>,
 adityag@linux.ibm.com, nikhilks@linux.ibm.com
Cc: pierrick.bouvier@oss.qualcomm.com, rathc@linux.ibm.com,
 Nicholas Piggin <npiggin@gmail.com>, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, hbathini@linux.ibm.com, shivangu@linux.ibm.com
Subject: [PATCH v6 5/6] ppc/spapr: Split VFIO EEH support from general VFIO
 code
Date: Mon, 19 Oct 2026 21:55:39 +0530
Message-ID: <20261019162541.68440-6-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261019162541.68440-1-nnmlinux@linux.ibm.com>
References: <20261019162541.68440-1-nnmlinux@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA2NCBTYWx0ZWRfX4a1zIXZfCkOp
 g+6sVuqvOksXTWNSDJSnw5wYxErJ7APItR3vOTVpQWzKuYOHJkZCUT1AELJbjhHQjdPdel94PWU
 SbLgcYLugfe+/R/pPBNxBUEaSWef0+o=
X-Authority-Analysis: v=2.4 cv=PrUG/AM3 c=1 sm=1 tr=0 ts=6ad644bc cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=mDV3o1hIAAAA:8 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8
 a=Ny_MO5XXa0bEUqU1V1wA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA2NCBTYWx0ZWRfXygQnFWSct1PG
 LVJLwnm9k7UckWlNBnYKSMr1tF0vfbMFqxG1/6AAvPS7ghEWSFXIMyhhBnNeVahdzAsSpWJZdmw
 eWzoOqCmLU5xfvn0kxdk6XB4IroO17N7uP0UwH3ozkgXFGWbgR+FL6aktoaH9XTklb2frt1mPbA
 SBZHhv80gRFIz71/z1lAZ75Iuoe7OEpnt14KKAOzSSnaq0ZoQtByHpFdqm2/imqt4U4y2ju1PWs
 VBAeU+XmRbRJSbRAIt5zRkGZKG5zyLYdxAZ/X+6jmfeT/vT2U+BdbGv6o/lR1Ykv6o24LPHGi4y
 iYQFsgv3ZFvcMiKUfYk+7nVpkugR2rhoEDRpboUmnfUea7x4SCx1ovmgMdhCvCrVaT3u+JMP9HC
 AhONkr9gwgGuRaKYD+Gejb2JR3ZqjOadtguTIVKOIIdLSyl7sW/ckNR8B1Fs+lNJbBVA2N1it3K
 OOWRw2WAaQQOpnT+apw==
X-Proofpoint-GUID: HENDOjCoUoFmWrcvtK-0xCvXpSWmsjYy
X-Proofpoint-ORIG-GUID: l7WaUijpcYvvhvc6_oPoKM_FQbr2VNut
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190064
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move all EEH and error-injection functions from spapr_pci_vfio.c into
a dedicated hw/ppc/spapr_eeh.c.  spapr_eeh.c is compiled only
when CONFIG_VFIO_PCI is enabled.

spapr_pci_vfio.c is retained as a stub-only file compiled on Linux
when CONFIG_VFIO_PCI is not available, providing the non-functional
fallback implementations needed for Linux/pseries builds that do not
include VFIO PCI.

meson.build: replace the single spapr_pci_vfio.c entry with an
if_true/if_false pair keyed on CONFIG_VFIO_PCI:
  CONFIG_VFIO_PCI=y  -> spapr_eeh.c       (real implementation)
  CONFIG_VFIO_PCI=n  -> stubs/spapr_pci_vfio-stubs.c  (stubs)

No functional change to the EEH state machine.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 include/hw/pci-host/spapr.h  |  56 +---
 include/hw/ppc/spapr_vfio.h  |  31 ++
 hw/ppc/spapr_eeh.c           | 577 +++++++++++++++++++++++++++++++++
 hw/ppc/spapr_pci.c           |   1 +
 hw/ppc/spapr_pci_vfio.c      | 597 +----------------------------------
 stubs/spapr_phb_vfio-stubs.c |  62 ++++
 hw/ppc/Kconfig               |   2 +-
 hw/ppc/meson.build           |   1 +
 stubs/meson.build            |   1 +
 9 files changed, 676 insertions(+), 652 deletions(-)
 create mode 100644 include/hw/ppc/spapr_vfio.h
 create mode 100644 hw/ppc/spapr_eeh.c
 create mode 100644 stubs/spapr_phb_vfio-stubs.c

diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 492f66e1ef..d2bc90a3d2 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -116,61 +116,7 @@ void spapr_phb_remove_pci_device_cb(DeviceState *dev);
 int spapr_pci_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
                           void *fdt, int *fdt_start_offset, Error **errp);
 
-/* VFIO EEH hooks */
-#ifdef CONFIG_LINUX
-bool spapr_phb_eeh_available(SpaprPhbState *sphb);
-int spapr_phb_vfio_eeh_set_option(SpaprPhbState *sphb,
-                                  unsigned int addr, int option);
-int spapr_phb_vfio_eeh_get_state(SpaprPhbState *sphb, int *state);
-int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option);
-int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb);
-void spapr_phb_vfio_reset(DeviceState *qdev);
-int spapr_phb_vfio_errinjct(SpaprPhbState *sphb, uint32_t type,
-                            uint32_t func, uint64_t addr, uint64_t mask);
-int spapr_phb_vfio_translate_errinjct_addr(SpaprPhbState *sphb,
-                                           uint32_t config_addr,
-                                           uint64_t guest_addr,
-                                           uint64_t *host_pci_bus_addr);
-#else
-static inline bool spapr_phb_eeh_available(SpaprPhbState *sphb)
-{
-    return false;
-}
-static inline int spapr_phb_vfio_eeh_set_option(SpaprPhbState *sphb,
-                                                unsigned int addr, int option)
-{
-    return RTAS_OUT_HW_ERROR;
-}
-static inline int spapr_phb_vfio_eeh_get_state(SpaprPhbState *sphb,
-                                               int *state)
-{
-    return RTAS_OUT_HW_ERROR;
-}
-static inline int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option)
-{
-    return RTAS_OUT_HW_ERROR;
-}
-static inline int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb)
-{
-    return RTAS_OUT_HW_ERROR;
-}
-static inline void spapr_phb_vfio_reset(DeviceState *qdev)
-{
-}
-static inline int spapr_phb_vfio_errinjct(SpaprPhbState *sphb, uint32_t type,
-                                          uint32_t func, uint64_t addr,
-                                          uint64_t mask)
-{
-    return RTAS_OUT_NOT_SUPPORTED;
-}
-static inline int spapr_phb_vfio_translate_errinjct_addr(SpaprPhbState *sphb,
-                                                         uint32_t config_addr,
-                                                         uint64_t guest_addr,
-                                                         uint64_t *host_addr)
-{
-    return -ENOTSUP;
-}
-#endif
+/* VFIO EEH hooks - see hw/ppc/spapr_vfio.h for declarations */
 
 void spapr_phb_dma_reset(SpaprPhbState *sphb);
 
diff --git a/include/hw/ppc/spapr_vfio.h b/include/hw/ppc/spapr_vfio.h
new file mode 100644
index 0000000000..5aabb262f2
--- /dev/null
+++ b/include/hw/ppc/spapr_vfio.h
@@ -0,0 +1,31 @@
+/*
+ * sPAPR VFIO EEH Header
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_PPC_SPAPR_VFIO_H
+#define HW_PPC_SPAPR_VFIO_H
+
+/*
+ * Forward declarations to avoid pulling in full spapr headers
+ * This allows stubs and other files to compile without libfdt dependencies
+ */
+typedef struct SpaprPhbState SpaprPhbState;
+typedef struct DeviceState DeviceState;
+
+/* VFIO EEH function declarations */
+bool spapr_phb_eeh_available(SpaprPhbState *sphb);
+int spapr_phb_vfio_eeh_set_option(SpaprPhbState *sphb,
+                                  unsigned int addr, int option);
+int spapr_phb_vfio_eeh_get_state(SpaprPhbState *sphb, int *state);
+int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option);
+int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb);
+void spapr_phb_vfio_reset(DeviceState *qdev);
+void spapr_phb_vfio_eeh_reenable(SpaprPhbState *sphb);
+int spapr_phb_vfio_errinjct(SpaprPhbState *sphb, uint32_t type,
+                            uint32_t func, uint64_t addr, uint64_t mask);
+int spapr_phb_vfio_translate_errinjct_addr(SpaprPhbState *sphb,
+                                           uint32_t config_addr,
+                                           uint64_t guest_addr,
+                                           uint64_t *host_pci_bus_addr);
+#endif /* HW_PPC_SPAPR_VFIO_H */
diff --git a/hw/ppc/spapr_eeh.c b/hw/ppc/spapr_eeh.c
new file mode 100644
index 0000000000..41c509728a
--- /dev/null
+++ b/hw/ppc/spapr_eeh.c
@@ -0,0 +1,577 @@
+/*
+ * QEMU sPAPR PCI host for VFIO
+ *
+ * Copyright (c) 2011-2014 Alexey Kardashevskiy, IBM Corporation.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License,
+ *  or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include <sys/ioctl.h>
+#include <linux/vfio.h>
+#include "hw/ppc/spapr.h"
+#include "hw/pci-host/spapr.h"
+#include "hw/pci/msix.h"
+#include "hw/pci/pci_device.h"
+#include "hw/vfio/vfio-container-legacy.h"
+#include "qemu/error-report.h"
+#include "hw/vfio/pci.h"
+#include "hw/ppc/spapr_vfio.h"
+
+/*
+ * Interfaces for IBM EEH (Enhanced Error Handling)
+ */
+static bool vfio_eeh_container_ok(VFIOLegacyContainer *container)
+{
+    /*
+     * As of 2016-03-04 (linux-4.5) the host kernel EEH/VFIO
+     * implementation is broken if there are multiple groups in a
+     * container.  The hardware works in units of Partitionable
+     * Endpoints (== IOMMU groups) and the EEH operations naively
+     * iterate across all groups in the container, without any logic
+     * to make sure the groups have their state synchronized.  For
+     * certain operations (ENABLE) that might be ok, until an error
+     * occurs, but for others (GET_STATE) it's clearly broken.
+     */
+
+    /*
+     * XXX Once fixed kernels exist, test for them here
+     */
+
+    if (QLIST_EMPTY(&container->group_list)) {
+        return false;
+    }
+
+    if (QLIST_NEXT(QLIST_FIRST(&container->group_list), container_next)) {
+        return false;
+    }
+
+    return true;
+}
+
+static int vfio_eeh_container_op(VFIOLegacyContainer *container, uint32_t op)
+{
+    struct vfio_eeh_pe_op pe_op = {
+        .argsz = sizeof(pe_op),
+        .op = op,
+    };
+    int ret;
+
+    if (!vfio_eeh_container_ok(container)) {
+        error_report("vfio/eeh: EEH_PE_OP 0x%x: "
+                     "kernel requires a container with exactly one group", op);
+        return -EPERM;
+    }
+
+    ret = ioctl(container->fd, VFIO_EEH_PE_OP, &pe_op);
+    if (ret < 0) {
+        error_report("vfio/eeh: EEH_PE_OP 0x%x failed: %m", op);
+        return -errno;
+    }
+
+    return ret;
+}
+
+static VFIOLegacyContainer *vfio_eeh_as_container(AddressSpace *as)
+{
+    VFIOAddressSpace *space = vfio_address_space_get(as);
+    VFIOContainer *bcontainer = NULL;
+
+    if (QLIST_EMPTY(&space->containers)) {
+        /* No containers to act on */
+        goto out;
+    }
+
+    bcontainer = QLIST_FIRST(&space->containers);
+
+    if (QLIST_NEXT(bcontainer, next)) {
+        /*
+         * We don't yet have logic to synchronize EEH state across
+         * multiple containers
+         */
+        bcontainer = NULL;
+        goto out;
+    }
+
+out:
+    vfio_address_space_put(space);
+    return VFIO_IOMMU_LEGACY(bcontainer);
+}
+
+static bool vfio_eeh_as_ok(AddressSpace *as)
+{
+    VFIOLegacyContainer *container = vfio_eeh_as_container(as);
+
+    return (container != NULL) && vfio_eeh_container_ok(container);
+}
+
+static int vfio_eeh_as_op(AddressSpace *as, uint32_t op)
+{
+    VFIOLegacyContainer *container = vfio_eeh_as_container(as);
+
+    if (!container) {
+        return -ENODEV;
+    }
+    return vfio_eeh_container_op(container, op);
+}
+
+bool spapr_phb_eeh_available(SpaprPhbState *sphb)
+{
+    return vfio_eeh_as_ok(&sphb->iommu_as);
+}
+
+void spapr_phb_vfio_eeh_reenable(SpaprPhbState *sphb)
+{
+    vfio_eeh_as_op(&sphb->iommu_as, VFIO_EEH_PE_ENABLE);
+}
+
+static void spapr_eeh_pci_find_device(PCIBus *bus, PCIDevice *pdev,
+                                      void *opaque)
+{
+    bool *found = opaque;
+
+    if (object_dynamic_cast(OBJECT(pdev), "vfio-pci")) {
+        *found = true;
+    }
+}
+
+int spapr_phb_vfio_eeh_set_option(SpaprPhbState *sphb,
+                                  unsigned int addr, int option)
+{
+    uint32_t op;
+    int ret;
+
+    switch (option) {
+    case RTAS_EEH_DISABLE:
+        op = VFIO_EEH_PE_DISABLE;
+        break;
+    case RTAS_EEH_ENABLE: {
+        PCIHostState *phb;
+        bool found = false;
+
+        /*
+         * The EEH functionality is enabled per sphb level instead of
+         * per PCI device. We have already identified this specific sphb
+         * based on buid passed as argument to ibm,set-eeh-option rtas
+         * call. Now we just need to check the validity of the PCI
+         * pass-through devices (vfio-pci) under this sphb bus.
+         * We have already validated that all the devices under this sphb
+         * are from same iommu group (within same PE) before coming here.
+         *
+         * Prior to linux commit 98ba956f6a389 ("powerpc/pseries/eeh:
+         * Rework device EEH PE determination") kernel would call
+         * eeh-set-option for each device in the PE using the device's
+         * config_address as the argument rather than the PE address.
+         * Hence if we check validity of supplied config_addr whether
+         * it matches to this PHB will cause issues with older kernel
+         * versions v5.9 and older. If we return an error from
+         * eeh-set-option when the argument isn't a valid PE address
+         * then older kernels (v5.9 and older) will interpret that as
+         * EEH not being supported.
+         */
+        phb = PCI_HOST_BRIDGE(sphb);
+        pci_for_each_device(phb->bus, (addr >> 16) & 0xFF,
+                            spapr_eeh_pci_find_device, &found);
+
+        if (!found) {
+            return RTAS_OUT_PARAM_ERROR;
+        }
+
+        op = VFIO_EEH_PE_ENABLE;
+        break;
+    }
+    case RTAS_EEH_THAW_IO:
+        op = VFIO_EEH_PE_UNFREEZE_IO;
+        break;
+    case RTAS_EEH_THAW_DMA:
+        op = VFIO_EEH_PE_UNFREEZE_DMA;
+        break;
+    default:
+        return RTAS_OUT_PARAM_ERROR;
+    }
+
+    ret = vfio_eeh_as_op(&sphb->iommu_as, op);
+    if (ret < 0) {
+        return RTAS_OUT_HW_ERROR;
+    }
+
+    return RTAS_OUT_SUCCESS;
+}
+
+int spapr_phb_vfio_eeh_get_state(SpaprPhbState *sphb, int *state)
+{
+    int ret;
+
+    ret = vfio_eeh_as_op(&sphb->iommu_as, VFIO_EEH_PE_GET_STATE);
+    if (ret < 0) {
+        return RTAS_OUT_PARAM_ERROR;
+    }
+
+    *state = ret;
+    return RTAS_OUT_SUCCESS;
+}
+
+static void spapr_phb_vfio_eeh_clear_dev_msix(PCIBus *bus,
+                                              PCIDevice *pdev,
+                                              void *opaque)
+{
+    /* Check if the device is VFIO PCI device */
+    if (!object_dynamic_cast(OBJECT(pdev), "vfio-pci")) {
+        return;
+    }
+
+    /*
+     * The MSIx table will be cleaned out by reset. We need
+     * disable it so that it can be reenabled properly. Also,
+     * the cached MSIx table should be cleared as it's not
+     * reflecting the contents in hardware.
+     */
+    if (msix_enabled(pdev)) {
+        uint16_t flags;
+
+        flags = pci_host_config_read_common(pdev,
+                                            pdev->msix_cap + PCI_MSIX_FLAGS,
+                                            pci_config_size(pdev), 2);
+        flags &= ~PCI_MSIX_FLAGS_ENABLE;
+        pci_host_config_write_common(pdev,
+                                     pdev->msix_cap + PCI_MSIX_FLAGS,
+                                     pci_config_size(pdev), flags, 2);
+    }
+
+    msix_reset(pdev);
+}
+
+static void spapr_phb_vfio_eeh_clear_bus_msix(PCIBus *bus, void *opaque)
+{
+       pci_for_each_device_under_bus(bus, spapr_phb_vfio_eeh_clear_dev_msix,
+                                     NULL);
+}
+
+static void spapr_phb_vfio_eeh_pre_reset(SpaprPhbState *sphb)
+{
+       PCIHostState *phb = PCI_HOST_BRIDGE(sphb);
+
+       pci_for_each_bus(phb->bus, spapr_phb_vfio_eeh_clear_bus_msix, NULL);
+}
+
+int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option)
+{
+    uint32_t op;
+    int ret;
+
+    switch (option) {
+    case RTAS_SLOT_RESET_DEACTIVATE:
+        op = VFIO_EEH_PE_RESET_DEACTIVATE;
+        break;
+    case RTAS_SLOT_RESET_HOT:
+        spapr_phb_vfio_eeh_pre_reset(sphb);
+        op = VFIO_EEH_PE_RESET_HOT;
+        break;
+    case RTAS_SLOT_RESET_FUNDAMENTAL:
+        spapr_phb_vfio_eeh_pre_reset(sphb);
+        op = VFIO_EEH_PE_RESET_FUNDAMENTAL;
+        break;
+    default:
+        return RTAS_OUT_PARAM_ERROR;
+    }
+
+    ret = vfio_eeh_as_op(&sphb->iommu_as, op);
+    if (ret < 0) {
+        return RTAS_OUT_HW_ERROR;
+    }
+
+    return RTAS_OUT_SUCCESS;
+}
+
+int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb)
+{
+    int ret;
+
+    ret = vfio_eeh_as_op(&sphb->iommu_as, VFIO_EEH_PE_CONFIGURE);
+    if (ret < 0) {
+        return RTAS_OUT_PARAM_ERROR;
+    }
+
+    return RTAS_OUT_SUCCESS;
+}
+
+typedef struct SpaprVFIOErrinjctBarMatch {
+    uint64_t guest_addr;
+
+    PCIDevice *pdev;
+    VFIOPCIDevice *vdev;
+    int bar;
+
+    uint64_t guest_bar_start;
+    uint64_t bar_size;
+    uint64_t offset;
+} SpaprVFIOErrinjctBarMatch;
+
+static VFIOPCIDevice *spapr_vfio_errinjct_pci_to_vfio(PCIDevice *pdev)
+{
+    if (!object_dynamic_cast(OBJECT(pdev), TYPE_VFIO_PCI)) {
+        return NULL;
+    }
+
+    return container_of(pdev, VFIOPCIDevice, parent_obj);
+}
+
+static void spapr_vfio_errinjct_find_bar_cb(PCIBus *bus,
+                                            PCIDevice *pdev,
+                                            void *opaque)
+{
+    SpaprVFIOErrinjctBarMatch *ctx = opaque;
+    VFIOPCIDevice *vdev;
+    int bar;
+
+    if (ctx->pdev) {
+        return;
+    }
+
+    vdev = spapr_vfio_errinjct_pci_to_vfio(pdev);
+    if (!vdev) {
+        return;
+    }
+
+    for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+        pcibus_t guest_bar_start;
+        uint64_t bar_size;
+        uint64_t offset;
+
+        bar_size = vdev->bars[bar].region.size;
+        if (!bar_size) {
+            continue;
+        }
+
+        guest_bar_start = pci_get_bar_addr(pdev, bar);
+        if (guest_bar_start == PCI_BAR_UNMAPPED) {
+            continue;
+        }
+
+        if (ctx->guest_addr < guest_bar_start ||
+            ctx->guest_addr - guest_bar_start >= bar_size) {
+            if (vdev->bars[bar].mem64) {
+                bar++;
+            }
+            continue;
+        }
+
+        offset = ctx->guest_addr - guest_bar_start;
+
+        ctx->pdev = pdev;
+        ctx->vdev = vdev;
+        ctx->bar = bar;
+        ctx->guest_bar_start = guest_bar_start;
+        ctx->bar_size = bar_size;
+        ctx->offset = offset;
+
+        return;
+    }
+}
+
+static int spapr_vfio_errinjct_get_host_bar(VFIOPCIDevice *vdev,
+                                            int bar,
+                                            uint64_t *host_bar_start)
+{
+    g_autofree char *path = NULL;
+    g_autofree char *contents = NULL;
+    char *line;
+    char *saveptr = NULL;
+    unsigned long long start;
+    unsigned long long end;
+    unsigned long long flags;
+    int i;
+
+    if (!vdev || !host_bar_start || bar < 0 || bar >= PCI_STD_NUM_BARS) {
+        return -EINVAL;
+    }
+
+    /*
+     * Read the host Linux sysfs resource file for the BAR.  Do not use a
+     * VFIO PCI config-space read because that may return the
+     * guest-programmed BAR value rather than the host resource address.
+     */
+    path = g_strdup_printf("/sys/bus/pci/devices/%04x:%02x:%02x.%u/resource",
+                           vdev->host.domain,
+                           vdev->host.bus,
+                           vdev->host.slot,
+                           vdev->host.function);
+
+    if (!g_file_get_contents(path, &contents, NULL, NULL)) {
+        error_report("vfio/eeh errinjct: failed to read %s", path);
+        return -ENOENT;
+    }
+
+    line = strtok_r(contents, "\n", &saveptr);
+
+    for (i = 0; line; i++, line = strtok_r(NULL, "\n", &saveptr)) {
+        if (i != bar) {
+            continue;
+        }
+
+        if (sscanf(line, "%llx %llx %llx", &start, &end, &flags) != 3) {
+            error_report("vfio/eeh errinjct: malformed %s BAR%d",
+                         path, bar);
+            return -EINVAL;
+        }
+
+        if (!start || end < start) {
+            error_report("vfio/eeh errinjct: invalid host resource BAR%d "
+                         "start=0x%llx end=0x%llx flags=0x%llx",
+                         bar, start, end, flags);
+            return -EINVAL;
+        }
+
+        *host_bar_start = start;
+        return 0;
+    }
+
+    return -EINVAL;
+}
+
+int spapr_phb_vfio_translate_errinjct_addr(SpaprPhbState *sphb,
+                                           uint32_t config_addr,
+                                           uint64_t guest_addr,
+                                           uint64_t *host_pci_bus_addr)
+{
+    PCIHostState *phb;
+    SpaprVFIOErrinjctBarMatch ctx = {
+        .guest_addr = guest_addr,
+        .pdev       = NULL,
+        .vdev       = NULL,
+        .bar        = -1,
+    };
+    uint64_t host_bar_start;
+    int rc;
+
+    if (!sphb || !host_pci_bus_addr) {
+        return -EINVAL;
+    }
+
+    phb = PCI_HOST_BRIDGE(sphb);
+
+    /*
+     * BUID has already selected @sphb before this helper is called.
+     * config_addr is retained for logging/debug only.  Do not rely on it
+     * to find the target device; some RTAS IOA buffers may not carry a
+     * valid guest BDF-style config address.  Scan VFIO BARs under this
+     * PHB and match guest_addr against the guest BAR layout instead.
+     */
+    pci_for_each_device_under_bus(phb->bus,
+                                  spapr_vfio_errinjct_find_bar_cb,
+                                  &ctx);
+
+    if (!ctx.pdev) {
+        error_report("vfio/eeh errinjct: guest addr 0x%" PRIx64
+                     " not within any VFIO BAR under BUID=0x%016" PRIx64
+                     " config_addr=0x%08x",
+                     guest_addr, sphb->buid, config_addr);
+        return -ENODEV;
+    }
+
+    rc = spapr_vfio_errinjct_get_host_bar(ctx.vdev, ctx.bar, &host_bar_start);
+    if (rc) {
+        error_report("vfio/eeh errinjct: failed to get host BAR%d for "
+                     "dev=%s BUID=0x%016" PRIx64 " config_addr=0x%08x rc=%d",
+                     ctx.bar, ctx.pdev->name, sphb->buid, config_addr, rc);
+        return rc;
+    }
+
+    if (host_bar_start == ctx.guest_bar_start) {
+        error_report("vfio/eeh errinjct: refusing guest BAR as host BAR: "
+                     "dev=%s BAR%d guest_bar=0x%" PRIx64
+                     " host_bar=0x%" PRIx64,
+                     ctx.pdev->name, ctx.bar,
+                     ctx.guest_bar_start, host_bar_start);
+        return -EOPNOTSUPP;
+    }
+
+    *host_pci_bus_addr = host_bar_start + ctx.offset;
+    return 0;
+}
+
+static int spapr_vfio_errinjct_rtas_type_to_vfio(uint32_t rtas_type)
+{
+    switch (rtas_type) {
+    case RTAS_ERR_TYPE_IOA_BUS_ERROR:
+        return EEH_ERR_TYPE_32;
+    case RTAS_ERR_TYPE_IOA_BUS_ERROR_64:
+        return EEH_ERR_TYPE_64;
+    default:
+        return -1;
+    }
+}
+
+static bool spapr_vfio_errinjct_func_valid(uint32_t func)
+{
+    return func <= EEH_ERR_FUNC_MAX;
+}
+
+int spapr_phb_vfio_errinjct(SpaprPhbState *sphb, uint32_t type,
+                            uint32_t func, uint64_t addr, uint64_t mask)
+{
+    VFIOLegacyContainer *container;
+    struct vfio_eeh_pe_op op = {
+        .op   = VFIO_EEH_PE_INJECT_ERR,
+        .argsz = sizeof(op),
+    };
+    int vfio_type;
+
+    if (!sphb) {
+        return RTAS_OUT_PARAM_ERROR;
+    }
+
+    if (!spapr_vfio_errinjct_func_valid(func)) {
+        return RTAS_OUT_PARAM_ERROR;
+    }
+
+    vfio_type = spapr_vfio_errinjct_rtas_type_to_vfio(type);
+    if (vfio_type < 0) {
+        return RTAS_OUT_NOT_SUPPORTED;
+    }
+
+    container = vfio_eeh_as_container(&sphb->iommu_as);
+    if (!container) {
+        error_report("vfio/eeh errinjct: no VFIO EEH container for PHB");
+        return RTAS_OUT_NOT_SUPPORTED;
+    }
+
+    /* Enforce exactly one group per container check matching other EEH ops */
+    if (!vfio_eeh_container_ok(container)) {
+        error_report("vfio: requires a container with exactly one group");
+        return RTAS_OUT_HW_ERROR;
+    }
+
+    op.err.type = vfio_type;
+    op.err.func = func;
+    op.err.addr = addr;
+    op.err.mask = mask;
+
+    if (ioctl(container->fd, VFIO_EEH_PE_OP, &op) < 0) {
+        error_report("vfio/eeh errinjct: VFIO_EEH_PE_OP failed: %s",
+                     strerror(errno));
+        switch (errno) {
+        case EINVAL:
+            return RTAS_OUT_PARAM_ERROR;
+        case ENOTTY:
+        case EOPNOTSUPP:
+            return RTAS_OUT_NOT_SUPPORTED;
+        default:
+            return RTAS_OUT_HW_ERROR;
+        }
+    }
+
+    return RTAS_OUT_SUCCESS;
+}
+
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index ec9f6284c7..2c85d8595d 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -33,6 +33,7 @@
 #include "hw/pci/msix.h"
 #include "hw/pci/pci_host.h"
 #include "hw/ppc/spapr.h"
+#include "hw/ppc/spapr_vfio.h"
 #include "hw/pci-host/spapr.h"
 #include <libfdt.h>
 #include "trace.h"
diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
index fe89fb4ca3..e6ecc3f1ee 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -22,120 +22,12 @@
 #include <linux/vfio.h>
 #include "hw/ppc/spapr.h"
 #include "hw/pci-host/spapr.h"
+#include "hw/ppc/spapr_vfio.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci_device.h"
 #include "hw/vfio/vfio-container-legacy.h"
 #include "qemu/error-report.h"
 #include "hw/vfio/pci.h"
-#include CONFIG_DEVICES /* CONFIG_VFIO_PCI */
-
-/*
- * Interfaces for IBM EEH (Enhanced Error Handling)
- */
-#ifdef CONFIG_VFIO_PCI
-static bool vfio_eeh_container_ok(VFIOLegacyContainer *container)
-{
-    /*
-     * As of 2016-03-04 (linux-4.5) the host kernel EEH/VFIO
-     * implementation is broken if there are multiple groups in a
-     * container.  The hardware works in units of Partitionable
-     * Endpoints (== IOMMU groups) and the EEH operations naively
-     * iterate across all groups in the container, without any logic
-     * to make sure the groups have their state synchronized.  For
-     * certain operations (ENABLE) that might be ok, until an error
-     * occurs, but for others (GET_STATE) it's clearly broken.
-     */
-
-    /*
-     * XXX Once fixed kernels exist, test for them here
-     */
-
-    if (QLIST_EMPTY(&container->group_list)) {
-        return false;
-    }
-
-    if (QLIST_NEXT(QLIST_FIRST(&container->group_list), container_next)) {
-        return false;
-    }
-
-    return true;
-}
-
-static int vfio_eeh_container_op(VFIOLegacyContainer *container, uint32_t op)
-{
-    struct vfio_eeh_pe_op pe_op = {
-        .argsz = sizeof(pe_op),
-        .op = op,
-    };
-    int ret;
-
-    if (!vfio_eeh_container_ok(container)) {
-        error_report("vfio/eeh: EEH_PE_OP 0x%x: "
-                     "kernel requires a container with exactly one group", op);
-        return -EPERM;
-    }
-
-    ret = ioctl(container->fd, VFIO_EEH_PE_OP, &pe_op);
-    if (ret < 0) {
-        error_report("vfio/eeh: EEH_PE_OP 0x%x failed: %m", op);
-        return -errno;
-    }
-
-    return ret;
-}
-
-static VFIOLegacyContainer *vfio_eeh_as_container(AddressSpace *as)
-{
-    VFIOAddressSpace *space = vfio_address_space_get(as);
-    VFIOContainer *bcontainer = NULL;
-
-    if (QLIST_EMPTY(&space->containers)) {
-        /* No containers to act on */
-        goto out;
-    }
-
-    bcontainer = QLIST_FIRST(&space->containers);
-
-    if (QLIST_NEXT(bcontainer, next)) {
-        /*
-         * We don't yet have logic to synchronize EEH state across
-         * multiple containers
-         */
-        bcontainer = NULL;
-        goto out;
-    }
-
-out:
-    vfio_address_space_put(space);
-    return VFIO_IOMMU_LEGACY(bcontainer);
-}
-
-static bool vfio_eeh_as_ok(AddressSpace *as)
-{
-    VFIOLegacyContainer *container = vfio_eeh_as_container(as);
-
-    return (container != NULL) && vfio_eeh_container_ok(container);
-}
-
-static int vfio_eeh_as_op(AddressSpace *as, uint32_t op)
-{
-    VFIOLegacyContainer *container = vfio_eeh_as_container(as);
-
-    if (!container) {
-        return -ENODEV;
-    }
-    return vfio_eeh_container_op(container, op);
-}
-
-bool spapr_phb_eeh_available(SpaprPhbState *sphb)
-{
-    return vfio_eeh_as_ok(&sphb->iommu_as);
-}
-
-static void spapr_phb_vfio_eeh_reenable(SpaprPhbState *sphb)
-{
-    vfio_eeh_as_op(&sphb->iommu_as, VFIO_EEH_PE_ENABLE);
-}
 
 void spapr_phb_vfio_reset(DeviceState *qdev)
 {
@@ -147,490 +39,3 @@ void spapr_phb_vfio_reset(DeviceState *qdev)
      */
     spapr_phb_vfio_eeh_reenable(SPAPR_PCI_HOST_BRIDGE(qdev));
 }
-
-static void spapr_eeh_pci_find_device(PCIBus *bus, PCIDevice *pdev,
-                                      void *opaque)
-{
-    bool *found = opaque;
-
-    if (object_dynamic_cast(OBJECT(pdev), "vfio-pci")) {
-        *found = true;
-    }
-}
-
-int spapr_phb_vfio_eeh_set_option(SpaprPhbState *sphb,
-                                  unsigned int addr, int option)
-{
-    uint32_t op;
-    int ret;
-
-    switch (option) {
-    case RTAS_EEH_DISABLE:
-        op = VFIO_EEH_PE_DISABLE;
-        break;
-    case RTAS_EEH_ENABLE: {
-        PCIHostState *phb;
-        bool found = false;
-
-        /*
-         * The EEH functionality is enabled per sphb level instead of
-         * per PCI device. We have already identified this specific sphb
-         * based on buid passed as argument to ibm,set-eeh-option rtas
-         * call. Now we just need to check the validity of the PCI
-         * pass-through devices (vfio-pci) under this sphb bus.
-         * We have already validated that all the devices under this sphb
-         * are from same iommu group (within same PE) before coming here.
-         *
-         * Prior to linux commit 98ba956f6a389 ("powerpc/pseries/eeh:
-         * Rework device EEH PE determination") kernel would call
-         * eeh-set-option for each device in the PE using the device's
-         * config_address as the argument rather than the PE address.
-         * Hence if we check validity of supplied config_addr whether
-         * it matches to this PHB will cause issues with older kernel
-         * versions v5.9 and older. If we return an error from
-         * eeh-set-option when the argument isn't a valid PE address
-         * then older kernels (v5.9 and older) will interpret that as
-         * EEH not being supported.
-         */
-        phb = PCI_HOST_BRIDGE(sphb);
-        pci_for_each_device(phb->bus, (addr >> 16) & 0xFF,
-                            spapr_eeh_pci_find_device, &found);
-
-        if (!found) {
-            return RTAS_OUT_PARAM_ERROR;
-        }
-
-        op = VFIO_EEH_PE_ENABLE;
-        break;
-    }
-    case RTAS_EEH_THAW_IO:
-        op = VFIO_EEH_PE_UNFREEZE_IO;
-        break;
-    case RTAS_EEH_THAW_DMA:
-        op = VFIO_EEH_PE_UNFREEZE_DMA;
-        break;
-    default:
-        return RTAS_OUT_PARAM_ERROR;
-    }
-
-    ret = vfio_eeh_as_op(&sphb->iommu_as, op);
-    if (ret < 0) {
-        return RTAS_OUT_HW_ERROR;
-    }
-
-    return RTAS_OUT_SUCCESS;
-}
-
-int spapr_phb_vfio_eeh_get_state(SpaprPhbState *sphb, int *state)
-{
-    int ret;
-
-    ret = vfio_eeh_as_op(&sphb->iommu_as, VFIO_EEH_PE_GET_STATE);
-    if (ret < 0) {
-        return RTAS_OUT_PARAM_ERROR;
-    }
-
-    *state = ret;
-    return RTAS_OUT_SUCCESS;
-}
-
-static void spapr_phb_vfio_eeh_clear_dev_msix(PCIBus *bus,
-                                              PCIDevice *pdev,
-                                              void *opaque)
-{
-    /* Check if the device is VFIO PCI device */
-    if (!object_dynamic_cast(OBJECT(pdev), "vfio-pci")) {
-        return;
-    }
-
-    /*
-     * The MSIx table will be cleaned out by reset. We need
-     * disable it so that it can be reenabled properly. Also,
-     * the cached MSIx table should be cleared as it's not
-     * reflecting the contents in hardware.
-     */
-    if (msix_enabled(pdev)) {
-        uint16_t flags;
-
-        flags = pci_host_config_read_common(pdev,
-                                            pdev->msix_cap + PCI_MSIX_FLAGS,
-                                            pci_config_size(pdev), 2);
-        flags &= ~PCI_MSIX_FLAGS_ENABLE;
-        pci_host_config_write_common(pdev,
-                                     pdev->msix_cap + PCI_MSIX_FLAGS,
-                                     pci_config_size(pdev), flags, 2);
-    }
-
-    msix_reset(pdev);
-}
-
-static void spapr_phb_vfio_eeh_clear_bus_msix(PCIBus *bus, void *opaque)
-{
-       pci_for_each_device_under_bus(bus, spapr_phb_vfio_eeh_clear_dev_msix,
-                                     NULL);
-}
-
-static void spapr_phb_vfio_eeh_pre_reset(SpaprPhbState *sphb)
-{
-       PCIHostState *phb = PCI_HOST_BRIDGE(sphb);
-
-       pci_for_each_bus(phb->bus, spapr_phb_vfio_eeh_clear_bus_msix, NULL);
-}
-
-int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option)
-{
-    uint32_t op;
-    int ret;
-
-    switch (option) {
-    case RTAS_SLOT_RESET_DEACTIVATE:
-        op = VFIO_EEH_PE_RESET_DEACTIVATE;
-        break;
-    case RTAS_SLOT_RESET_HOT:
-        spapr_phb_vfio_eeh_pre_reset(sphb);
-        op = VFIO_EEH_PE_RESET_HOT;
-        break;
-    case RTAS_SLOT_RESET_FUNDAMENTAL:
-        spapr_phb_vfio_eeh_pre_reset(sphb);
-        op = VFIO_EEH_PE_RESET_FUNDAMENTAL;
-        break;
-    default:
-        return RTAS_OUT_PARAM_ERROR;
-    }
-
-    ret = vfio_eeh_as_op(&sphb->iommu_as, op);
-    if (ret < 0) {
-        return RTAS_OUT_HW_ERROR;
-    }
-
-    return RTAS_OUT_SUCCESS;
-}
-
-int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb)
-{
-    int ret;
-
-    ret = vfio_eeh_as_op(&sphb->iommu_as, VFIO_EEH_PE_CONFIGURE);
-    if (ret < 0) {
-        return RTAS_OUT_PARAM_ERROR;
-    }
-
-    return RTAS_OUT_SUCCESS;
-}
-
-typedef struct SpaprVFIOErrinjctBarMatch {
-    uint64_t guest_addr;
-
-    PCIDevice *pdev;
-    VFIOPCIDevice *vdev;
-    int bar;
-
-    uint64_t guest_bar_start;
-    uint64_t bar_size;
-    uint64_t offset;
-} SpaprVFIOErrinjctBarMatch;
-
-static VFIOPCIDevice *spapr_vfio_errinjct_pci_to_vfio(PCIDevice *pdev)
-{
-    if (!object_dynamic_cast(OBJECT(pdev), TYPE_VFIO_PCI)) {
-        return NULL;
-    }
-
-    return container_of(pdev, VFIOPCIDevice, parent_obj);
-}
-
-static void spapr_vfio_errinjct_find_bar_cb(PCIBus *bus,
-                                            PCIDevice *pdev,
-                                            void *opaque)
-{
-    SpaprVFIOErrinjctBarMatch *ctx = opaque;
-    VFIOPCIDevice *vdev;
-    int bar;
-
-    if (ctx->pdev) {
-        return;
-    }
-
-    vdev = spapr_vfio_errinjct_pci_to_vfio(pdev);
-    if (!vdev) {
-        return;
-    }
-
-    for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
-        pcibus_t guest_bar_start;
-        uint64_t bar_size;
-        uint64_t offset;
-
-        bar_size = vdev->bars[bar].region.size;
-        if (!bar_size) {
-            continue;
-        }
-
-        guest_bar_start = pci_get_bar_addr(pdev, bar);
-        if (guest_bar_start == PCI_BAR_UNMAPPED) {
-            continue;
-        }
-
-        if (ctx->guest_addr < guest_bar_start ||
-            ctx->guest_addr - guest_bar_start >= bar_size) {
-            if (vdev->bars[bar].mem64) {
-                bar++;
-            }
-            continue;
-        }
-
-        offset = ctx->guest_addr - guest_bar_start;
-
-        ctx->pdev = pdev;
-        ctx->vdev = vdev;
-        ctx->bar = bar;
-        ctx->guest_bar_start = guest_bar_start;
-        ctx->bar_size = bar_size;
-        ctx->offset = offset;
-
-        return;
-    }
-}
-
-static int spapr_vfio_errinjct_get_host_bar(VFIOPCIDevice *vdev,
-                                            int bar,
-                                            uint64_t *host_bar_start)
-{
-    g_autofree char *path = NULL;
-    g_autofree char *contents = NULL;
-    char *line;
-    char *saveptr = NULL;
-    unsigned long long start;
-    unsigned long long end;
-    unsigned long long flags;
-    int i;
-
-    if (!vdev || !host_bar_start || bar < 0 || bar >= PCI_STD_NUM_BARS) {
-        return -EINVAL;
-    }
-
-    /*
-     * Read the host Linux sysfs resource file for the BAR.  Do not use a
-     * VFIO PCI config-space read because that may return the
-     * guest-programmed BAR value rather than the host resource address.
-     */
-    path = g_strdup_printf("/sys/bus/pci/devices/%04x:%02x:%02x.%u/resource",
-                           vdev->host.domain,
-                           vdev->host.bus,
-                           vdev->host.slot,
-                           vdev->host.function);
-
-    if (!g_file_get_contents(path, &contents, NULL, NULL)) {
-        error_report("vfio/eeh errinjct: failed to read %s", path);
-        return -ENOENT;
-    }
-
-    line = strtok_r(contents, "\n", &saveptr);
-
-    for (i = 0; line; i++, line = strtok_r(NULL, "\n", &saveptr)) {
-        if (i != bar) {
-            continue;
-        }
-
-        if (sscanf(line, "%llx %llx %llx", &start, &end, &flags) != 3) {
-            error_report("vfio/eeh errinjct: malformed %s BAR%d",
-                         path, bar);
-            return -EINVAL;
-        }
-
-        if (!start || end < start) {
-            error_report("vfio/eeh errinjct: invalid host resource BAR%d "
-                         "start=0x%llx end=0x%llx flags=0x%llx",
-                         bar, start, end, flags);
-            return -EINVAL;
-        }
-
-        *host_bar_start = start;
-        return 0;
-    }
-
-    return -EINVAL;
-}
-
-int spapr_phb_vfio_translate_errinjct_addr(SpaprPhbState *sphb,
-                                           uint32_t config_addr,
-                                           uint64_t guest_addr,
-                                           uint64_t *host_pci_bus_addr)
-{
-    PCIHostState *phb;
-    SpaprVFIOErrinjctBarMatch ctx = {
-        .guest_addr = guest_addr,
-        .pdev       = NULL,
-        .vdev       = NULL,
-        .bar        = -1,
-    };
-    uint64_t host_bar_start;
-    int rc;
-
-    if (!sphb || !host_pci_bus_addr) {
-        return -EINVAL;
-    }
-
-    phb = PCI_HOST_BRIDGE(sphb);
-
-    /*
-     * BUID has already selected @sphb before this helper is called.
-     * config_addr is retained for logging/debug only.  Do not rely on it
-     * to find the target device; some RTAS IOA buffers may not carry a
-     * valid guest BDF-style config address.  Scan VFIO BARs under this
-     * PHB and match guest_addr against the guest BAR layout instead.
-     */
-    pci_for_each_device_under_bus(phb->bus,
-                                  spapr_vfio_errinjct_find_bar_cb,
-                                  &ctx);
-
-    if (!ctx.pdev) {
-        error_report("vfio/eeh errinjct: guest addr 0x%" PRIx64
-                     " not within any VFIO BAR under BUID=0x%016" PRIx64
-                     " config_addr=0x%08x",
-                     guest_addr, sphb->buid, config_addr);
-        return -ENODEV;
-    }
-
-    rc = spapr_vfio_errinjct_get_host_bar(ctx.vdev, ctx.bar, &host_bar_start);
-    if (rc) {
-        error_report("vfio/eeh errinjct: failed to get host BAR%d for "
-                     "dev=%s BUID=0x%016" PRIx64 " config_addr=0x%08x rc=%d",
-                     ctx.bar, ctx.pdev->name, sphb->buid, config_addr, rc);
-        return rc;
-    }
-
-    if (host_bar_start == ctx.guest_bar_start) {
-        error_report("vfio/eeh errinjct: refusing guest BAR as host BAR: "
-                     "dev=%s BAR%d guest_bar=0x%" PRIx64
-                     " host_bar=0x%" PRIx64,
-                     ctx.pdev->name, ctx.bar,
-                     ctx.guest_bar_start, host_bar_start);
-        return -EOPNOTSUPP;
-    }
-
-    *host_pci_bus_addr = host_bar_start + ctx.offset;
-    return 0;
-}
-
-static int spapr_vfio_errinjct_rtas_type_to_vfio(uint32_t rtas_type)
-{
-    switch (rtas_type) {
-    case RTAS_ERR_TYPE_IOA_BUS_ERROR:
-        return EEH_ERR_TYPE_32;
-    case RTAS_ERR_TYPE_IOA_BUS_ERROR_64:
-        return EEH_ERR_TYPE_64;
-    default:
-        return -1;
-    }
-}
-
-static bool spapr_vfio_errinjct_func_valid(uint32_t func)
-{
-    return func <= EEH_ERR_FUNC_MAX;
-}
-
-int spapr_phb_vfio_errinjct(SpaprPhbState *sphb, uint32_t type,
-                            uint32_t func, uint64_t addr, uint64_t mask)
-{
-    VFIOLegacyContainer *container;
-    struct vfio_eeh_pe_op op = {
-        .op   = VFIO_EEH_PE_INJECT_ERR,
-        .argsz = sizeof(op),
-    };
-    int vfio_type;
-
-    if (!sphb) {
-        return RTAS_OUT_PARAM_ERROR;
-    }
-
-    if (!spapr_vfio_errinjct_func_valid(func)) {
-        return RTAS_OUT_PARAM_ERROR;
-    }
-
-    vfio_type = spapr_vfio_errinjct_rtas_type_to_vfio(type);
-    if (vfio_type < 0) {
-        return RTAS_OUT_NOT_SUPPORTED;
-    }
-
-    container = vfio_eeh_as_container(&sphb->iommu_as);
-    if (!container) {
-        error_report("vfio/eeh errinjct: no VFIO EEH container for PHB");
-        return RTAS_OUT_NOT_SUPPORTED;
-    }
-
-    /* Enforce exactly one group per container check matching other EEH ops */
-    if (!vfio_eeh_container_ok(container)) {
-        error_report("vfio: requires a container with exactly one group");
-        return RTAS_OUT_HW_ERROR;
-    }
-
-    op.err.type = vfio_type;
-    op.err.func = func;
-    op.err.addr = addr;
-    op.err.mask = mask;
-
-    if (ioctl(container->fd, VFIO_EEH_PE_OP, &op) < 0) {
-        error_report("vfio/eeh errinjct: VFIO_EEH_PE_OP failed: %s",
-                     strerror(errno));
-        switch (errno) {
-        case EINVAL:
-            return RTAS_OUT_PARAM_ERROR;
-        case ENOTTY:
-        case EOPNOTSUPP:
-            return RTAS_OUT_NOT_SUPPORTED;
-        default:
-            return RTAS_OUT_HW_ERROR;
-        }
-    }
-
-    return RTAS_OUT_SUCCESS;
-}
-
-#else
-
-bool spapr_phb_eeh_available(SpaprPhbState *sphb)
-{
-    return false;
-}
-
-void spapr_phb_vfio_reset(DeviceState *qdev)
-{
-}
-
-int spapr_phb_vfio_eeh_set_option(SpaprPhbState *sphb,
-                                  unsigned int addr, int option)
-{
-    return RTAS_OUT_NOT_SUPPORTED;
-}
-
-int spapr_phb_vfio_eeh_get_state(SpaprPhbState *sphb, int *state)
-{
-    return RTAS_OUT_NOT_SUPPORTED;
-}
-
-int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option)
-{
-    return RTAS_OUT_NOT_SUPPORTED;
-}
-
-int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb)
-{
-    return RTAS_OUT_NOT_SUPPORTED;
-}
-
-int spapr_phb_vfio_errinjct(SpaprPhbState *sphb, uint32_t type,
-                            uint32_t func, uint64_t addr, uint64_t mask)
-{
-    return RTAS_OUT_NOT_SUPPORTED;
-}
-
-int spapr_phb_vfio_translate_errinjct_addr(SpaprPhbState *sphb,
-                                           uint32_t config_addr,
-                                           uint64_t guest_addr,
-                                           uint64_t *host_pci_bus_addr)
-{
-    return -ENOTSUP;
-}
-
-#endif /* CONFIG_VFIO_PCI */
diff --git a/stubs/spapr_phb_vfio-stubs.c b/stubs/spapr_phb_vfio-stubs.c
new file mode 100644
index 0000000000..4d86d9000e
--- /dev/null
+++ b/stubs/spapr_phb_vfio-stubs.c
@@ -0,0 +1,62 @@
+/*
+ * Stubs for sPAPR PCI VFIO EEH
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/ppc/spapr_vfio.h"
+
+/* RTAS return codes */
+#define RTAS_OUT_NOT_SUPPORTED          (-3)
+
+
+bool spapr_phb_eeh_available(SpaprPhbState *sphb)
+{
+    return false;
+}
+
+int spapr_phb_vfio_eeh_set_option(SpaprPhbState *sphb,
+                                  unsigned int addr, int option)
+{
+    return RTAS_OUT_NOT_SUPPORTED;
+}
+
+int spapr_phb_vfio_eeh_get_state(SpaprPhbState *sphb, int *state)
+{
+    return RTAS_OUT_NOT_SUPPORTED;
+}
+
+int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option)
+{
+    return RTAS_OUT_NOT_SUPPORTED;
+}
+
+int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb)
+{
+    return RTAS_OUT_NOT_SUPPORTED;
+}
+
+void spapr_phb_vfio_reset(DeviceState *qdev)
+{
+}
+
+void spapr_phb_vfio_eeh_reenable(SpaprPhbState *sphb)
+{
+}
+
+int spapr_phb_vfio_errinjct(SpaprPhbState *sphb, uint32_t type,
+                            uint32_t func, uint64_t addr, uint64_t mask)
+{
+    return RTAS_OUT_NOT_SUPPORTED;
+}
+
+int spapr_phb_vfio_translate_errinjct_addr(SpaprPhbState *sphb,
+                                           uint32_t config_addr,
+                                           uint64_t guest_addr,
+                                           uint64_t *host_pci_bus_addr)
+{
+    return -ENOTSUP;
+}
+
+
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 347dcce690..3714d708d9 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -6,7 +6,7 @@ config PSERIES
     imply PCI_DEVICES
     imply TEST_DEVICES
     imply VIRTIO_VGA
-    imply VFIO_PCI if LINUX   # needed by spapr_pci_vfio.c
+    imply VFIO_PCI if LINUX   # needed by spapr_pci_vfio.c and spapr_eeh.c
     select NVDIMM
     select DIMM
     select PCI
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index 37aa535db2..4e03973440 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -36,6 +36,7 @@ ppc_ss.add(when: 'CONFIG_SPAPR_RNG', if_true: files('spapr_rng.c'))
 if host_os == 'linux'
   ppc_ss.add(when: 'CONFIG_PSERIES', if_true: files(
     'spapr_pci_vfio.c',
+    'spapr_eeh.c',
   ))
 endif
 
diff --git a/stubs/meson.build b/stubs/meson.build
index dcb67ce529..122f1f85b3 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -101,6 +101,7 @@ if have_system
     stub_ss.add(files('hmp-cmds-hw-s390x.c'))
     stub_ss.add(files('hmp-cmds-target-i386.c'))
   endif
+  stub_ss.add(files('spapr_phb_vfio-stubs.c'))
 endif
 
 if have_system or have_user
-- 
2.51.1


