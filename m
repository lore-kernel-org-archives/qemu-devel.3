Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C6E606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oHAK3IdJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLjeN-00066Q-G5; Tue, 27 Oct 2026 12:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1xLje9-0005uF-7V; Tue, 27 Oct 2026 12:03:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1xLje7-0006WA-CC; Tue, 27 Oct 2026 12:03:32 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69REETRc1519692; Tue, 27 Oct 2026 16:03:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=/5ckX5px3ZS7H5Y/q
 Vm+TjZB7LYAytDQPfc0sTPfNG0=; b=oHAK3IdJFknsUhtO3wttD2myokA9mlU+Z
 vjdCSeST0Kku+PvRSUUEOQhuA1E4MR8BjzdXB5xognAUQUpdwOtHY+7lrzm08NOA
 Ug/M+XHE3CKreoSdwqC4XUkZfeyJFzi0Ak51ejgW/ZYD8gstNSrICIXoZSW2ptpO
 9Cq1vkKv/OwZ8xTh8aw8qnJC2qcFw+90kQGN6BkwbuuG/4BpokskeQS61NmU+RDo
 15DRuM4QBNHqGO5iezJhUjjxxBoeV2PoA6+HwSIyEwgwggLHKHRuOwn5W7YsiNnw
 7mR8pXYEoL5xWILpEFLv3MXGrieOPxHfgmSbsTHwCkYJc5wnNEatg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgk3g083x-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2026 16:03:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RDoSRW4190112; Tue, 27 Oct 2026 16:03:28 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hjtnn95ga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2026 16:03:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69RG3N7S49807818
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Oct 2026 16:03:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 995F02004F;
 Tue, 27 Oct 2026 16:03:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 205452005A;
 Tue, 27 Oct 2026 16:03:20 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.ibm.com (unknown [9.124.222.107])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Oct 2026 16:03:19 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sbhat@linux.ibm.com,
 mahesh@linux.ibm.com, sourabhjain@linux.ibm.com, adityag@linux.ibm.com,
 npiggin@gmail.com, harshpb@linux.ibm.com, alex@shazbot.org, clg@redhat.com
Cc: amachhiw@linux.ibm.com, hbathini@linux.ibm.com, shivangu@linux.ibm.com,
 anushree.mathur@linux.ibm.com
Subject: [PATCH v2 1/2] ppc/spapr: Preserve VFIO MSI-X shadow across EEH reset
Date: Tue, 27 Oct 2026 21:32:57 +0530
Message-ID: <20261027160258.48207-2-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027160258.48207-1-nnmlinux@linux.ibm.com>
References: <20261027160258.48207-1-nnmlinux@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=BOMmP1QG c=1 sm=1 tr=0 ts=6ae0cb51 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=KZPridRbySPfH9r5ge0A:9
X-Proofpoint-ORIG-GUID: W6nuarWNzevJ6lE2daEh21YiHo7XEStU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MiBTYWx0ZWRfX4K95o+Ci4aEk
 uFSVbJRrmzkjpQLVgIShuPvZoSGmMYUrHIoUnqJksVhEQ3yJD59XtjuMKNmXll5ToC069OUFDwi
 Lzim9ODScGyILX0o3+ITc2qbhCMDbWsbdhJu2gczEq6VpaulVNAA3YdFJ9bRacCHnHLWVEZiVOt
 8xQ0OjD90W3x0Yp4UL+OArQCsUnYVTxeC+iGqKjiPpIUQB6AN3T7BOhWgI2BLXKTiV3T7Vo5WRf
 y2GAxve1YqDe5vMhzuLSLxSLSfW2BAzdSBr1zpWGnrjdl633sviQgBOaVQPy7RIUb3yOkNKeUUT
 lIN1pLKHxy2qfqzE7B6ZNjAZl+MjUrOREwQZyt6ewG9FmlSdOYWvm5pIgv7Nbwv0rDno/bmA2li
 BFgVAav+ggQ3k747ld1uzxDXnz4gJtIMvOagDI7KapRZflu1aRzRPdpZCtdDyBIUYnzbeupAOEi
 fOJRGoKiNRlfNty61jQ==
X-Proofpoint-GUID: Cl9EZjXZo05tvRklul9Or-vtAievLqRS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA2MiBTYWx0ZWRfXzB8vv47VBidR
 LQ6uLoPa5hdBvWGH4DNPWcF/MbKUvmWyNlQo97FpjDf3PhHMu3gaZF1SVZbHMEa8D73hTqN9Exr
 G6jLK6I8kggIlqX0HKjJ7pUrpEnYOac=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0
 phishscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270062
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

On pSeries, the MSI-X table shadow in QEMU is not sourced from the
physical device.  It is populated by sPAPR RTAS through the
ibm,change-msi call path:

  ibm,change-msi
    -> spapr_msi_setmsg()
      -> msix_set_message()      /* writes each shadow entry */

EEH recovery does not necessarily cause the guest to re-issue
ibm,change-msi.  The guest VFIO PCI driver restores interrupt delivery
by writing MSI-X Enable = 1 directly via config space.  QEMU then
dispatches through:

  vfio_msix_enable()
    -> vfio_msix_vector_do_use()  /* re-arms KVM irqfd from shadow */

The existing EEH pre-reset helper calls msix_reset() after clearing
MSI-X Enable.  msix_reset() zeroes every shadow entry.  Without the
shadow, vfio_msix_vector_do_use() cannot reconstruct the KVM irqfd
routes and device interrupts do not recover after EEH.

Fix the pre-reset helper:

1. Remove the msix_reset() call.  The shadow must survive the PE reset
   so that interrupt delivery can be restored when the guest re-enables
   MSI-X without repeating ibm,change-msi.

2. Read the MSI-X flags from the cached pdev->config shadow instead of
   calling pci_host_config_read_common().  The PE may already be frozen
   when EEH pre-reset runs; reading from physical config space could
   fault.

3. Rename the helpers from clear_dev_msix / clear_bus_msix to
   prepare_dev / prepare_bus to reflect that they no longer clear any
   state, and fix the pre-existing tab-indented bodies to use spaces
   consistently with the surrounding code.

4. Switch the VFIO device type check from the "vfio-pci" string literal
   to TYPE_VFIO_PCI_DEVICE, matching the convention used by other
   non-VFIO source files that access VFIOPCIDevice (e.g.
   hw/s390x/s390-pci-vfio.c).  Add the corresponding #include for
   hw/vfio/pci.h.

The guest recovery sequence after this fix:

  EEH pre-reset:
    MSI-X Enable -> 0 (pci_host_config_write_common)
      -> vfio_msix_disable()
         -> vfio_msix_vector_release() for each vector
         -> KVM irqfd routes removed
         -> VFIO MSIX_IRQ_INDEX disabled
    shadow entries unchanged

  PE reset + PE configure

  guest slot_reset() / PCI state restore:
    MSI-X Enable -> 1 (config-space write)
      -> vfio_msix_enable()
         -> vfio_msix_vector_do_use() for each vector
         -> shadow entries present -> KVM irqfd routes re-armed
    interrupts recover

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 hw/ppc/spapr_pci_vfio.c | 56 ++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 23 deletions(-)

diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
index a748a0bf4c..1fa8847031 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -25,6 +25,7 @@
 #include "hw/pci/msix.h"
 #include "hw/pci/pci_device.h"
 #include "hw/vfio/vfio-container-legacy.h"
+#include "hw/vfio/pci.h"
 #include "qemu/error-report.h"
 #include CONFIG_DEVICES /* CONFIG_VFIO_PCI */
 
@@ -233,47 +234,56 @@ int spapr_phb_vfio_eeh_get_state(SpaprPhbState *sphb, int *state)
     return RTAS_OUT_SUCCESS;
 }
 
-static void spapr_phb_vfio_eeh_clear_dev_msix(PCIBus *bus,
-                                              PCIDevice *pdev,
-                                              void *opaque)
+/*
+ * Prepare a single VFIO PCI device for an EEH PE hot or fundamental reset.
+ *
+ * On pSeries the MSI-X table shadow is populated by ibm,change-msi via
+ * spapr_msi_setmsg() -> msix_set_message().  EEH recovery does not
+ * necessarily re-issue ibm,change-msi; the guest restores MSI-X Enable
+ * directly, causing QEMU to dispatch through vfio_msix_enable() ->
+ * vfio_msix_vector_do_use(), which re-arms the KVM irqfd routes from the
+ * existing shadow entries.
+ *
+ * Therefore, msix_reset() must NOT be called here.  Calling it would wipe
+ * those shadow entries and prevent interrupt delivery after EEH recovery.
+ *
+ * Instead, clear MSI-X Enable using the cached pdev->config shadow (avoiding
+ * a read from potentially frozen device config space) and write through
+ * pci_host_config_write_common() so that the VFIO config-write handler calls
+ * vfio_msix_disable(), cleanly releasing vectors and KVM irqfd routes while
+ * leaving the shadow intact.
+ */
+static void spapr_phb_vfio_eeh_prepare_dev(PCIBus *bus,
+                                            PCIDevice *pdev,
+                                            void *opaque)
 {
-    /* Check if the device is VFIO PCI device */
-    if (!object_dynamic_cast(OBJECT(pdev), "vfio-pci")) {
+    uint16_t flags;
+
+    if (!object_dynamic_cast(OBJECT(pdev), TYPE_VFIO_PCI_DEVICE)) {
         return;
     }
 
-    /*
-     * The MSIx table will be cleaned out by reset. We need
-     * disable it so that it can be reenabled properly. Also,
-     * the cached MSIx table should be cleared as it's not
-     * reflecting the contents in hardware.
-     */
     if (msix_enabled(pdev)) {
-        uint16_t flags;
-
-        flags = pci_host_config_read_common(pdev,
-                                            pdev->msix_cap + PCI_MSIX_FLAGS,
-                                            pci_config_size(pdev), 2);
+        flags = pci_get_word(pdev->config + pdev->msix_cap + PCI_MSIX_FLAGS);
         flags &= ~PCI_MSIX_FLAGS_ENABLE;
         pci_host_config_write_common(pdev,
                                      pdev->msix_cap + PCI_MSIX_FLAGS,
                                      pci_config_size(pdev), flags, 2);
     }
-
-    msix_reset(pdev);
 }
 
-static void spapr_phb_vfio_eeh_clear_bus_msix(PCIBus *bus, void *opaque)
+static void spapr_phb_vfio_eeh_prepare_bus(PCIBus *bus, void *opaque)
 {
-       pci_for_each_device_under_bus(bus, spapr_phb_vfio_eeh_clear_dev_msix,
-                                     NULL);
+    pci_for_each_device_under_bus(bus,
+                                  spapr_phb_vfio_eeh_prepare_dev,
+                                  NULL);
 }
 
 static void spapr_phb_vfio_eeh_pre_reset(SpaprPhbState *sphb)
 {
-       PCIHostState *phb = PCI_HOST_BRIDGE(sphb);
+    PCIHostState *phb = PCI_HOST_BRIDGE(sphb);
 
-       pci_for_each_bus(phb->bus, spapr_phb_vfio_eeh_clear_bus_msix, NULL);
+    pci_for_each_bus(phb->bus, spapr_phb_vfio_eeh_prepare_bus, NULL);
 }
 
 int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option)
-- 
2.54.0


