Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD50606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 08:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=s/WBfdOa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVPEG-0007jz-6Q; Mon, 23 Nov 2026 03:16:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1xVPE9-0007iI-Vr; Mon, 23 Nov 2026 03:16:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1xVPE8-0000Cq-43; Mon, 23 Nov 2026 03:16:41 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AN54n3V982151; Mon, 23 Nov 2026 08:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=lZZifQ2wl+3690oys
 aJ9+tAd9cG/FndrSdFB7QhtuOo=; b=s/WBfdOahPyn2/yI0xWgquxKyBg3Gj03O
 9+PEUL1L6LnE3G1TiqS/paEJqpuiGG3M+ceejQAjjndTjbuFT9MPdojExaMJTEqu
 Lp0GLah/xpgmAjWa2WddOVhaODDxYe7McNbctJtRwO3WujRFThtg054bTE+fVmkG
 b77rNzucpOHivVFBP1grMElLjxMMWVHMe3S8Q4zb9TswjajkflDMqfFUOrLBunHb
 /3SDhybsXLt434igLgKninMhRhd9YNvWBiJybh30jgkws0XzrIkKa7KUWmZj7z8H
 JldMIAiuGetWx31UyKpYzkFENBmxXyYgx9gDKd+qUVK67lGPfeWBA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g325yr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 23 Nov 2026 08:16:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AN54GJG264437; Mon, 23 Nov 2026 08:16:36 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3qufnqsd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Nov 2026 08:16:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AN8GWEJ50200988
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Nov 2026 08:16:32 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 85E6C2004F;
 Mon, 23 Nov 2026 08:16:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B9D020049;
 Mon, 23 Nov 2026 08:16:30 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.bl1-in.ibm.com (unknown [9.123.4.64])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Nov 2026 08:16:29 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sbhat@linux.ibm.com,
 mahesh@linux.ibm.com, sourabhjain@linux.ibm.com, adityag@linux.ibm.com,
 npiggin@gmail.com, harshpb@linux.ibm.com, alex@shazbot.org, clg@redhat.com
Cc: amachhiw@linux.ibm.com, hbathini@linux.ibm.com, shivangu@linux.ibm.com,
 anushree.mathur@linux.ibm.com
Subject: [PATCH v3 2/2] ppc/spapr: Preserve VFIO MSI-X shadow and block BAR
 mmap on EEH reset
Date: Mon, 23 Nov 2026 13:45:49 +0530
Message-ID: <20261123081546.49210-6-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261123081546.49210-4-nnmlinux@linux.ibm.com>
References: <20261123081546.49210-4-nnmlinux@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b03f665 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=YNXdgygh4p_yelnAWyUA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzMiBTYWx0ZWRfXw0wba//HgFKP
 9ndG1tsyrS4PMSe1ZGtxW7CR/+judVJlBJQVngpbbf4tg7aOoC1ipyItZxx8aREnt4ETzFWEXVS
 /Mrt0syApFjv34I4991dgrs3zVHLbwE=
X-Proofpoint-ORIG-GUID: 8lK4mtVDylZFafm1Xs1M5cf-tkKZMAVA
X-Proofpoint-GUID: uR_L2MX6kBRoSXkIjLF3e1m3rcHeXsyv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzMiBTYWx0ZWRfX2jZaL0OkdPR5
 US4MoAzuElutMuwGCsMBXJLZCfKZRVXHi78uzd3/IKng32f8p6F+NiKZoNm8qYNCb26Ev2+s1tj
 Z4S/P2HK/GCsMuDlzvHjXeezQFBrADno2aWwvUNlGkXeo1HUTY5RdnflM8PngU7rzgtSMQOfRQ5
 gAjgltkyqjdIhe16xET97p4ThVy3bDIqOnaWPXZQkFA3Ds1s1na4Cq/vq6KvRubUigxVsBLt/4M
 mM3EMHPD7v94sCUlMA14JEkvlkF35+niFZ4VH5C/V+4QtKqqLSDZMEPN+j3Qz0rYI1ImKcUeOZ1
 AFajizYbYe7kiey1R5QepzoKJHMsWUHFb3xFkfQEoXUT42Vq2Vhc1T9ES221laUEbYD0yKQT7Yt
 WRPV1gieFDccYxJO59w0sDSl22s/l6J4hWg7Eg8mZYklNUPSzrR/k6rXwTRuCFnUN6BMJizMhne
 Rcg8wtlEQmUBPTcla0Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230032
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Prepare VFIO PCI devices before a pSeries EEH hot or fundamental PE
reset without destroying the MSI-X state that the guest needs to
recover interrupts.

The existing path clears MSI-X Enable and then calls msix_reset().  On
pSeries with vfio-no-msix-emulation=true, QEMU keeps the MSI-X messages
used by ibm,change-msi in its software shadow.  The Linux EEH recovery
sequence does not necessarily issue ibm,change-msi again.  Clearing the
shadow with msix_reset() therefore loses the message address/data needed
when MSI-X is enabled again.

Preserve the shadow by removing msix_reset().  Read the MSI-X Message
Control value from QEMU's cached PCI config space, clear only MSI-X
Enable, and write it through pci_host_config_write_common().  This keeps
the normal VFIO MSI-X disable/enable transition while avoiding a config
read from a PE that may still be frozen.

Also block direct BAR mmap access before changing MSI-X state by calling
vfio_pci_mmap_block().  Testing with a VFIO-passed-through BCM5719
showed that restoring direct mmap after VFIO_EEH_PE_CONFIGURE can leave
the device inaccessible again during guest resume, while keeping BAR
access on the VFIO region read/write path allows the Guest-2 EEH
recovery to complete and the device to remain functional.  Blocking
mmap first also prevents a subsequent MSI-X-to-INTx transition from
re-enabling the mmap path through the normal INTx policy.

The generic VFIO helper provides only the persistent mmap-block
mechanism; the decision to use it for EEH remains local to the sPAPR
recovery code.  No post-configure mmap restore is added because the
current testing does not establish a safe point for reusing the direct
BAR mmap after the PE reset.

No guest-visible ABI is changed.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 hw/ppc/spapr_pci_vfio.c | 75 ++++++++++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 24 deletions(-)

diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
index a748a0bf4c..c164a7a6ce 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -32,6 +32,8 @@
  * Interfaces for IBM EEH (Enhanced Error Handling)
  */
 #ifdef CONFIG_VFIO_PCI
+#include "hw/vfio/pci.h"
+
 static bool vfio_eeh_container_ok(VFIOLegacyContainer *container)
 {
     /*
@@ -233,47 +235,72 @@ int spapr_phb_vfio_eeh_get_state(SpaprPhbState *sphb, int *state)
     return RTAS_OUT_SUCCESS;
 }
 
-static void spapr_phb_vfio_eeh_clear_dev_msix(PCIBus *bus,
-                                              PCIDevice *pdev,
-                                              void *opaque)
+static void spapr_phb_vfio_eeh_prepare_dev(PCIBus *bus,
+                                           PCIDevice *pdev,
+                                           void *opaque)
 {
-    /* Check if the device is VFIO PCI device */
+    VFIOPCIDevice *vdev;
+    uint16_t flags;
+
     if (!object_dynamic_cast(OBJECT(pdev), "vfio-pci")) {
         return;
     }
 
+    vdev = VFIO_PCI_DEVICE(pdev);
+
     /*
-     * The MSIx table will be cleaned out by reset. We need
-     * disable it so that it can be reenabled properly. Also,
-     * the cached MSIx table should be cleared as it's not
-     * reflecting the contents in hardware.
+     * Direct BAR mmap access may not be reliable after an EEH PE reset.
+     * Block mmap before changing MSI-X state so any resulting interrupt
+     * mode transition cannot re-enable it, and keep BAR accesses on the
+     * VFIO pread()/pwrite() path after the reset.  This avoids restoring
+     * the direct mmap path at an unproven point in EEH recovery.
      */
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
+    vfio_pci_mmap_block(vdev);
+
+    if (!msix_enabled(pdev)) {
+        return;
     }
 
-    msix_reset(pdev);
+    /*
+     * Disable MSI-X by clearing the Enable bit in the MSI-X Message
+     * Control register.  We use the cached config value to avoid a
+     * config-space read while the PE may still be frozen.
+     *
+     * Writing through pci_host_config_write_common() causes VFIO to:
+     *   - release the active MSI-X vector eventfds,
+     *   - remove the KVM irqchip routes,
+     *   - disable the VFIO MSIX_IRQ_INDEX,
+     * so that the subsequent MSI-X Enable write from the guest driver
+     * is seen as a clean disabled-to-enabled transition and all
+     * vectors are re-armed through vfio_msix_vector_do_use().
+     *
+     * Do NOT call msix_reset() here.  On pSeries, QEMU's MSI-X table
+     * is a software shadow populated by the ibm,change-msi RTAS call.
+     * The EEH recovery sequence does not necessarily re-issue
+     * ibm,change-msi, so the shadow contains the only copy of the
+     * message addresses and data that Linux EEH will restore.
+     * msix_reset() would zero those shadow entries, leaving
+     * vfio_msix_enable() with no vectors to pass to
+     * vfio_msix_vector_do_use() and the device would never recover
+     * interrupts.
+     */
+    flags = pci_get_word(pdev->config + pdev->msix_cap + PCI_MSIX_FLAGS);
+    flags &= ~PCI_MSIX_FLAGS_ENABLE;
+    pci_host_config_write_common(pdev,
+                                 pdev->msix_cap + PCI_MSIX_FLAGS,
+                                 pci_config_size(pdev), flags, 2);
 }
 
-static void spapr_phb_vfio_eeh_clear_bus_msix(PCIBus *bus, void *opaque)
+static void spapr_phb_vfio_eeh_prepare_bus(PCIBus *bus, void *opaque)
 {
-       pci_for_each_device_under_bus(bus, spapr_phb_vfio_eeh_clear_dev_msix,
-                                     NULL);
+    pci_for_each_device_under_bus(bus, spapr_phb_vfio_eeh_prepare_dev, NULL);
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


