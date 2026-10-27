Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86420606A320
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 16:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dYeqInpP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLjeS-0006Mm-B1; Tue, 27 Oct 2026 12:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1xLjeD-0005ua-6t; Tue, 27 Oct 2026 12:03:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1xLjeB-0006WP-6S; Tue, 27 Oct 2026 12:03:36 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69REEMvY2897949; Tue, 27 Oct 2026 16:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=BC29k94C5UrnNBMKD
 OSY00GgTjFt1lGdSZItl0INNJU=; b=dYeqInpPITpt6K6UUwywARsoTK08+4f9Q
 ciAPuFhgdGWvX2uHTKX9H4HHoVzKRVtUWXcfnp89wHMNiIxgFOfPoq/HHK6+Vdjd
 2BrPIreTZC6OzCifeqjdCJp/POyMlI6yZw7fmsONBcKt2SHujlGlmEjQDP2y5OJx
 CykNDpMP05qUT2/o1gaG9+h3OCGVIyJXXX/hMAs3YBVkbyu7/cVMYMnGHqSoK20i
 /Sxpay8Jcy7+cXl3kskjMuGXIcvdebiJXYMyBWBubq/1sTmieELqtyNA3PAHjydY
 1pa+AWdBgpIqub6e+KLQa4q+dhRJjS9xnX7VChzZOK444IK0OyXIA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgm640f3y-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2026 16:03:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RDoPkr4190093; Tue, 27 Oct 2026 16:03:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hjtnn95gv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2026 16:03:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69RG3R8f27591014
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Oct 2026 16:03:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7908E2006E;
 Tue, 27 Oct 2026 16:03:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E3DB2004F;
 Tue, 27 Oct 2026 16:03:24 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.ibm.com (unknown [9.124.222.107])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Oct 2026 16:03:23 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sbhat@linux.ibm.com,
 mahesh@linux.ibm.com, sourabhjain@linux.ibm.com, adityag@linux.ibm.com,
 npiggin@gmail.com, harshpb@linux.ibm.com, alex@shazbot.org, clg@redhat.com
Cc: amachhiw@linux.ibm.com, hbathini@linux.ibm.com, shivangu@linux.ibm.com,
 anushree.mathur@linux.ibm.com
Subject: [PATCH v2 2/2] ppc/spapr: Disable VFIO BAR mmap during EEH PE reset
Date: Tue, 27 Oct 2026 21:32:58 +0530
Message-ID: <20261027160258.48207-3-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261027160258.48207-1-nnmlinux@linux.ibm.com>
References: <20261027160258.48207-1-nnmlinux@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA2MiBTYWx0ZWRfXz9fvhNOqoBgF
 KClgNTlEx7dyQJ2U8HHO6XPMc8laRC+6RYonGvBsTwMk5EenaktsSzejXZv5njUDxgnuulFew39
 aLwNheepgcEf8W8dQXlyax74jSwooHU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MiBTYWx0ZWRfXwUMTv1E3skZ5
 xjjO/j8rBI6SjwlrpRpz/F2J54Y5sSiqTcGaUKzpdt2nCUnar1LrDr7QamRneIZjxhixhE10SE1
 N+QZGH54tUNpCYOroeo4xQ+CuTsaj6oLfD6/6YZFCpL4oVFQ56a7RdxuH0jE2+VArW13vGA73pW
 v09WfG4ljn2wo/1XqWe6vAnrj471b2WNGAFzYVULi7W5vTkXtO/lo4VRxiLFqEY8lul+HdkMvQS
 t2fx3tISMWOjc+YWQ36lZvbM+f1tcG+wcKpfaIh9R4f2092lkjIxTjx6jv2kfwiha9o8PYu9btd
 Qcchmm2s4xTxRgeBrja8sqEEOhQ4nLpsPqo12hOX+6tgWTEF8bz0DZImUn7wXHAWmflg3aSeIje
 pmQkczPZnG6r6jgUqX8BI0Hs+S/M58sm6zqJ6RK3pr7t+FjZ1qyxlHo61HE8Tkb6QurcOp58SfE
 yl9Uy72GgUo6Jw/ah9Q==
X-Proofpoint-ORIG-GUID: wSS5pVzTKTEJS0b4sMVA5lfW_dpf3d6B
X-Authority-Analysis: v=2.4 cv=Uu32pOwB c=1 sm=1 tr=0 ts=6ae0cb55 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=uZnQy3njFTQj27rYP58A:9
X-Proofpoint-GUID: lHbXY93NWVxFeWCzm9_S9ZIcH04cj1bZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270062
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Direct mmap-backed BAR accesses are not reliable while the PE is
undergoing EEH reset.  Temporarily disable the mmap-backed BAR
subregions so accesses fall back to the VFIO region read/write path
during the reset window.

After VFIO_EEH_PE_CONFIGURE succeeds, restore normal VFIO mmap
behavior.

To keep VFIOPCIDevice internals encapsulated and avoid direct
manipulation of vdev->intx.mmap_timer and vdev->bars[] from
hw/ppc/spapr_pci_vfio.c, introduce two VFIO PCI helpers in
hw/vfio/pci.c:

 - vfio_pci_eeh_pre_reset(): cancels any pending INTx mmap re-enable
   timer and disables BAR mmaps across all BAR regions.

 - vfio_pci_eeh_post_configure(): restores normal VFIO mmap policy.
   If INTx is still pending, the INTx mmap timer is re-armed so mmap
   remains disabled until the quiet period completes; otherwise,
   BAR mmaps are immediately re-enabled.

The pSeries EEH handlers in hw/ppc/spapr_pci_vfio.c call
vfio_pci_eeh_pre_reset() during the pre-reset device preparation
(after MSI-X teardown) and call vfio_pci_eeh_post_configure() only
after VFIO_EEH_PE_CONFIGURE succeeds.  On configure failure, BAR mmaps
remain disabled.  RTAS_SLOT_RESET_DEACTIVATE does not invoke either
helper.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 hw/ppc/spapr_pci_vfio.c | 60 ++++++++++++++++++++++++++++++++++++++---
 hw/vfio/pci.c           | 32 ++++++++++++++++++++++
 hw/vfio/pci.h           |  2 ++
 3 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
index 1fa8847031..ab78489fa5 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -254,8 +254,8 @@ int spapr_phb_vfio_eeh_get_state(SpaprPhbState *sphb, int *state)
  * leaving the shadow intact.
  */
 static void spapr_phb_vfio_eeh_prepare_dev(PCIBus *bus,
-                                            PCIDevice *pdev,
-                                            void *opaque)
+                                           PCIDevice *pdev,
+                                           void *opaque)
 {
     uint16_t flags;
 
@@ -263,13 +263,27 @@ static void spapr_phb_vfio_eeh_prepare_dev(PCIBus *bus,
         return;
     }
 
+    /*
+     * Disable MSI-X through the VFIO config-write path so the
+     * active interrupt routes are released while preserving the
+     * pSeries RTAS-managed MSI-X software shadow.
+     */
     if (msix_enabled(pdev)) {
-        flags = pci_get_word(pdev->config + pdev->msix_cap + PCI_MSIX_FLAGS);
+        flags = pci_get_word(pdev->config +
+                             pdev->msix_cap + PCI_MSIX_FLAGS);
+
         flags &= ~PCI_MSIX_FLAGS_ENABLE;
+
         pci_host_config_write_common(pdev,
                                      pdev->msix_cap + PCI_MSIX_FLAGS,
-                                     pci_config_size(pdev), flags, 2);
+                                     pci_config_size(pdev),
+                                     flags, 2);
     }
+
+    /*
+     * This must be the final preparation step before the PE reset.
+     */
+    vfio_pci_eeh_pre_reset(pdev);
 }
 
 static void spapr_phb_vfio_eeh_prepare_bus(PCIBus *bus, void *opaque)
@@ -286,6 +300,37 @@ static void spapr_phb_vfio_eeh_pre_reset(SpaprPhbState *sphb)
     pci_for_each_bus(phb->bus, spapr_phb_vfio_eeh_prepare_bus, NULL);
 }
 
+/*
+ * Restore normal VFIO mmap policy for a single VFIO PCI device after a
+ * successful EEH PE configure.  Called only on the configure success path;
+ * on failure mmaps remain disabled until the next hot/fundamental reset
+ * attempt.
+ */
+static void spapr_phb_vfio_eeh_post_configure_dev(PCIBus *bus,
+                                                  PCIDevice *pdev,
+                                                  void *opaque)
+{
+    if (!object_dynamic_cast(OBJECT(pdev), TYPE_VFIO_PCI_DEVICE)) {
+        return;
+    }
+
+    vfio_pci_eeh_post_configure(pdev);
+}
+
+static void spapr_phb_vfio_eeh_post_configure_bus(PCIBus *bus, void *opaque)
+{
+    pci_for_each_device_under_bus(bus,
+                                  spapr_phb_vfio_eeh_post_configure_dev,
+                                  NULL);
+}
+
+static void spapr_phb_vfio_eeh_post_configure(SpaprPhbState *sphb)
+{
+    PCIHostState *phb = PCI_HOST_BRIDGE(sphb);
+
+    pci_for_each_bus(phb->bus, spapr_phb_vfio_eeh_post_configure_bus, NULL);
+}
+
 int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option)
 {
     uint32_t op;
@@ -293,6 +338,11 @@ int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option)
 
     switch (option) {
     case RTAS_SLOT_RESET_DEACTIVATE:
+        /*
+         * Deactivate does not perform a full PE reset; BAR mmaps were already
+         * disabled by the preceding HOT or FUNDAMENTAL reset call and must not
+         * be re-enabled here.
+         */
         op = VFIO_EEH_PE_RESET_DEACTIVATE;
         break;
     case RTAS_SLOT_RESET_HOT:
@@ -324,6 +374,8 @@ int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb)
         return RTAS_OUT_PARAM_ERROR;
     }
 
+    spapr_phb_vfio_eeh_post_configure(sphb);
+
     return RTAS_OUT_SUCCESS;
 }
 
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 428ab2f069..931df22add 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1949,6 +1949,38 @@ static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled)
     }
 }
 
+/*
+ * Prevent a pending INTx mmap timer from restoring BAR mmap while
+ * the PE is undergoing EEH reset.  Keep BAR accesses on the VFIO
+ * region read/write path until PE configuration completes.
+ */
+void vfio_pci_eeh_pre_reset(PCIDevice *pdev)
+{
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
+
+    if (vdev->intx.mmap_timer) {
+        timer_del(vdev->intx.mmap_timer);
+    }
+
+    vfio_mmap_set_enabled(vdev, false);
+}
+
+void vfio_pci_eeh_post_configure(PCIDevice *pdev)
+{
+    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
+
+    if (vdev->interrupt == VFIO_INT_INTx && vdev->intx.pending) {
+        if (vdev->intx.mmap_timer && vdev->intx.mmap_timeout) {
+            timer_mod(vdev->intx.mmap_timer,
+                      qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
+                      vdev->intx.mmap_timeout);
+        }
+        return;
+    }
+
+    vfio_mmap_set_enabled(vdev, true);
+}
+
 static void vfio_bar_prepare(VFIOPCIDevice *vdev, int nr)
 {
     VFIOBAR *bar = &vdev->bars[nr];
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index c9ab949870..63fa378fbc 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -266,6 +266,8 @@ struct vfio_pci_hot_reset_info;
 
 void vfio_pci_pre_reset(VFIOPCIDevice *vdev);
 void vfio_pci_post_reset(VFIOPCIDevice *vdev);
+void vfio_pci_eeh_pre_reset(PCIDevice *pdev);
+void vfio_pci_eeh_post_configure(PCIDevice *pdev);
 bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name);
 int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
                                     struct vfio_pci_hot_reset_info **info_p);
-- 
2.54.0


