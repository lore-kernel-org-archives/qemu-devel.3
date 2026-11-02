Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FF1606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 03:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ffPu/yIZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNj91-0002KZ-UD; Sun, 01 Nov 2026 22:55:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xNj90-0002Jy-JM; Sun, 01 Nov 2026 22:55:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xNj8y-0003MC-8v; Sun, 01 Nov 2026 22:55:38 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A20iEXn1413187; Mon, 2 Nov 2026 03:55:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=KoPMJOkitG00vluQL
 2Blz7e06uCOQsRk3cU1UAwfmgw=; b=ffPu/yIZ65gcodGDTa2wJQoFRoAwQ5yCs
 kIJcjt4DvH8WoRdRnE84X+2NHBypkHJRQkSMWolO4yEMhjqHArImv8naNoviGYuX
 BKKo6J6mvvMAtlDfzgrNRKg9yxiK8uVbnoUoQgVTT8vhCaffFq9j92kf7j2rGUMa
 8M85QqSaSGn4Ml21q8MMkpITu2mUcf9fojzEewXerlbJGPgsYEZwbOWWS1ZVWjKr
 qIqc43fyLSlNI8JRqnLlrWwz7Pw47YSujeW09S2g5YiQasseM3SaNwDfs+j9umNy
 iD05I4Nku28U6RZ4tiIoYIW9byW4nGKkDKmrS/1gkNObufDrqh4Ng==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn5rheqkf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 03:55:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A20Z792132771; Mon, 2 Nov 2026 03:55:30 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnu1vc42h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 03:55:30 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A23tTEt36962858
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Nov 2026 03:55:29 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E6BE58062;
 Mon,  2 Nov 2026 03:55:29 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A3EE5805E;
 Mon,  2 Nov 2026 03:55:23 +0000 (GMT)
Received: from li-bd0dea4c-2912-11b2-a85c-e84940f94d2e.ibmuc.com (unknown
 [9.43.104.91]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  2 Nov 2026 03:55:22 +0000 (GMT)
From: uverma@linux.ibm.com
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, jishnuvw@linux.ibm.com, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, jsnow@redhat.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com, odaki@rsg.ci.i.u-tokyo.ac.jp,
 aleksandr.mikhalitsyn@futurfusion.io, Utkarsh Verma <uverma@linux.ibm.com>
Subject: [PATCH v7 05/10] tests/qtest: Enable spapr dma with linear iommu
Date: Mon,  2 Nov 2026 09:23:01 +0530
Message-ID: <20261102035306.2291147-6-uverma@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102035306.2291147-1-uverma@linux.ibm.com>
References: <20261102035306.2291147-1-uverma@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: zZ1pAG5QKHlAnU6vvxqDed--zGz9EcHe
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAxNCBTYWx0ZWRfXy4dJC2y5+gNV
 JLVDJh/fSzMjnnwVZRJSzpxHO+NKlc293SdQzlP1R6CU08Eo8KkyCcZsBbMZnCWlqFjNTrX+5ql
 C3DeB/2rqi0LoO7Wued4ezb2PyUNoww=
X-Authority-Analysis: v=2.4 cv=LokHWXdc c=1 sm=1 tr=0 ts=6ae809b3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=kv1UZCw-93OWFuL9ec8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAxNCBTYWx0ZWRfX5SjRIsMJ0H5z
 VlCRshlmOO75n3llrEJ/Y+vfQo1AZ48sMUUaxD0J8k/WtTkXA45VMUltVpKGbzz2Lpg5JCKoyDY
 CTOlCmt7M8k+JmkQ3KT0GDitKneRWJwAIFQTNmp0qemOfkLycS6Zfv5a8sdBo0CblLKtJqkxch4
 6ACDhE6STN7yPVWIZtWRm1FlMBihk20A0BJWQ73e/3IdiW18BuP4OHABGkAhNvN8QzPTyNxDcmG
 b201McHRF0ir1mEcAVurVX5zSLeJfFi+1M/AKpRgbdA9ikh79jHSjYybSXGx85+rWlAs3qL/YxW
 yXAAZJKu8KdLC5ddMoym+dRTshE7Q/gdYXSJ991Ko69v5ZB/5AoFWJMwTBHaRqvMRA+poDCahPK
 FEJZEmfzeoTAteB4R4jLibW2lKm7R/jlmbJ1KADftg3xOvPqNjRTm0Bv8VIqxVVBBAlKvcvzrbG
 VvBbBSpnxcyRA2rYuwQ==
X-Proofpoint-GUID: RLzLbE9Svgrlz7smWzHYdT1dp8yQqT79
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020014
Received-SPF: pass client-ip=148.163.158.5; envelope-from=uverma@linux.ibm.com;
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

From: Nicholas Piggin <npiggin@gmail.com>

qtests spapr dma was broken because the iommu was not set up.

spapr requires hypercalls to set up the iommu (TCE tables), but
there is no support for that or a side-channel to the iommu in
qtests at the moment, so add a quick workaround in QEMU to have
the spapr iommu provide a linear map to memory when running
qtests.

The buggy msix checks can all be removed since the tests all work
now.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Jishnu Warrier <jishnuvw@linux.ibm.com>
Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
---
 hw/ppc/spapr_iommu.c                 | 10 +++++++++-
 tests/qtest/e1000e-test.c            | 21 ---------------------
 tests/qtest/igb-test.c               | 21 ---------------------
 tests/qtest/libqos/generic-pcihost.c |  1 -
 tests/qtest/libqos/pci-pc.c          |  3 ---
 tests/qtest/libqos/pci-spapr.c       |  7 ++++---
 tests/qtest/libqos/pci.c             | 14 --------------
 tests/qtest/libqos/pci.h             |  4 ----
 tests/qtest/nvme-test.c              |  4 ----
 tests/qtest/vhost-user-blk-test.c    |  6 ------
 tests/qtest/virtio-blk-test.c        | 12 ------------
 11 files changed, 13 insertions(+), 90 deletions(-)

diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index e6264b0785..5470602ef1 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -22,6 +22,8 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "system/kvm.h"
+#include "system/qtest.h"
+#include "exec/target_page.h"
 #include "kvm_ppc.h"
 #include "migration/vmstate.h"
 #include "system/dma.h"
@@ -125,7 +127,13 @@ static IOMMUTLBEntry spapr_tce_translate_iommu(IOMMUMemoryRegion *iommu,
         .perm = IOMMU_NONE,
     };
 
-    if ((addr >> tcet->page_shift) < tcet->nb_table) {
+    if (qtest_enabled()) {
+        /* spapr qtests does not set up the IOMMU, shortcut a linear map */
+        ret.iova = addr & TARGET_PAGE_MASK;
+        ret.translated_addr = addr & TARGET_PAGE_MASK;
+        ret.addr_mask = ~TARGET_PAGE_MASK;
+        ret.perm = IOMMU_RW;
+    } else if ((addr >> tcet->page_shift) < tcet->nb_table) {
         /* Check if we are in bound */
         hwaddr page_mask = IOMMU_PAGE_MASK(tcet->page_shift);
 
diff --git a/tests/qtest/e1000e-test.c b/tests/qtest/e1000e-test.c
index de9738fdb7..8300bf5a5b 100644
--- a/tests/qtest/e1000e-test.c
+++ b/tests/qtest/e1000e-test.c
@@ -139,13 +139,6 @@ static void test_e1000e_tx(void *obj, void *data, QGuestAllocator * alloc)
 {
     QE1000E_PCI *e1000e = obj;
     QE1000E *d = &e1000e->e1000e;
-    QOSGraphObject *e_object = obj;
-    QPCIDevice *dev = e_object->get_driver(e_object, "pci-device");
-
-    /* FIXME: add spapr support */
-    if (qpci_check_buggy_msi(dev)) {
-        return;
-    }
 
     e1000e_send_verify(d, data, alloc);
 }
@@ -154,13 +147,6 @@ static void test_e1000e_rx(void *obj, void *data, QGuestAllocator * alloc)
 {
     QE1000E_PCI *e1000e = obj;
     QE1000E *d = &e1000e->e1000e;
-    QOSGraphObject *e_object = obj;
-    QPCIDevice *dev = e_object->get_driver(e_object, "pci-device");
-
-    /* FIXME: add spapr support */
-    if (qpci_check_buggy_msi(dev)) {
-        return;
-    }
 
     e1000e_receive_verify(d, data, alloc);
 }
@@ -173,13 +159,6 @@ static void test_e1000e_multiple_transfers(void *obj, void *data,
 
     QE1000E_PCI *e1000e = obj;
     QE1000E *d = &e1000e->e1000e;
-    QOSGraphObject *e_object = obj;
-    QPCIDevice *dev = e_object->get_driver(e_object, "pci-device");
-
-    /* FIXME: add spapr support */
-    if (qpci_check_buggy_msi(dev)) {
-        return;
-    }
 
     for (i = 0; i < iterations; i++) {
         e1000e_send_verify(d, data, alloc);
diff --git a/tests/qtest/igb-test.c b/tests/qtest/igb-test.c
index 3d397ea697..1b3b5aa6c7 100644
--- a/tests/qtest/igb-test.c
+++ b/tests/qtest/igb-test.c
@@ -142,13 +142,6 @@ static void test_igb_tx(void *obj, void *data, QGuestAllocator * alloc)
 {
     QE1000E_PCI *e1000e = obj;
     QE1000E *d = &e1000e->e1000e;
-    QOSGraphObject *e_object = obj;
-    QPCIDevice *dev = e_object->get_driver(e_object, "pci-device");
-
-    /* FIXME: add spapr support */
-    if (qpci_check_buggy_msi(dev)) {
-        return;
-    }
 
     igb_send_verify(d, data, alloc);
 }
@@ -157,13 +150,6 @@ static void test_igb_rx(void *obj, void *data, QGuestAllocator * alloc)
 {
     QE1000E_PCI *e1000e = obj;
     QE1000E *d = &e1000e->e1000e;
-    QOSGraphObject *e_object = obj;
-    QPCIDevice *dev = e_object->get_driver(e_object, "pci-device");
-
-    /* FIXME: add spapr support */
-    if (qpci_check_buggy_msi(dev)) {
-        return;
-    }
 
     igb_receive_verify(d, data, alloc);
 }
@@ -176,13 +162,6 @@ static void test_igb_multiple_transfers(void *obj, void *data,
 
     QE1000E_PCI *e1000e = obj;
     QE1000E *d = &e1000e->e1000e;
-    QOSGraphObject *e_object = obj;
-    QPCIDevice *dev = e_object->get_driver(e_object, "pci-device");
-
-    /* FIXME: add spapr support */
-    if (qpci_check_buggy_msi(dev)) {
-        return;
-    }
 
     for (i = 0; i < iterations; i++) {
         igb_send_verify(d, data, alloc);
diff --git a/tests/qtest/libqos/generic-pcihost.c b/tests/qtest/libqos/generic-pcihost.c
index b77617524c..93cc3b8561 100644
--- a/tests/qtest/libqos/generic-pcihost.c
+++ b/tests/qtest/libqos/generic-pcihost.c
@@ -182,7 +182,6 @@ void qpci_init_generic(QGenericPCIBus *qpci, QTestState *qts,
 
     qpci->gpex_pio_base = 0x3eff0000;
     qpci->bus.not_hotpluggable = !hotpluggable;
-    qpci->bus.has_buggy_msi = false;
 
     qpci->bus.pio_readb = qpci_generic_pio_readb;
     qpci->bus.pio_readw = qpci_generic_pio_readw;
diff --git a/tests/qtest/libqos/pci-pc.c b/tests/qtest/libqos/pci-pc.c
index 147009f4f4..8b79d858bd 100644
--- a/tests/qtest/libqos/pci-pc.c
+++ b/tests/qtest/libqos/pci-pc.c
@@ -124,9 +124,6 @@ void qpci_init_pc(QPCIBusPC *qpci, QTestState *qts, QGuestAllocator *alloc)
 {
     assert(qts);
 
-    /* tests can use pci-bus */
-    qpci->bus.has_buggy_msi = false;
-
     qpci->bus.pio_readb = qpci_pc_pio_readb;
     qpci->bus.pio_readw = qpci_pc_pio_readw;
     qpci->bus.pio_readl = qpci_pc_pio_readl;
diff --git a/tests/qtest/libqos/pci-spapr.c b/tests/qtest/libqos/pci-spapr.c
index 3723cbb38d..b58cc1b59f 100644
--- a/tests/qtest/libqos/pci-spapr.c
+++ b/tests/qtest/libqos/pci-spapr.c
@@ -20,6 +20,10 @@
  * PCI devices are always little-endian
  * SPAPR by default is big-endian
  * so PCI accessors need to swap data endianness
+ *
+ * The spapr iommu model has a qtest_enabled() check that short-cuts
+ * the TCE table and provides a linear map for DMA, since qtests does
+ * not have a way to make hcalls to set up the TCE table.
  */
 
 static uint8_t qpci_spapr_pio_readb(QPCIBus *bus, uint32_t addr)
@@ -155,9 +159,6 @@ void qpci_init_spapr(QPCIBusSPAPR *qpci, QTestState *qts,
 {
     assert(qts);
 
-    /* tests cannot use spapr, needs to be fixed first */
-    qpci->bus.has_buggy_msi = true;
-
     qpci->alloc = alloc;
 
     qpci->bus.pio_readb = qpci_spapr_pio_readb;
diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
index f6db133f6a..e9233c81e9 100644
--- a/tests/qtest/libqos/pci.c
+++ b/tests/qtest/libqos/pci.c
@@ -53,20 +53,6 @@ void qpci_device_foreach(QPCIBus *bus, int vendor_id, int device_id,
     }
 }
 
-bool qpci_has_buggy_msi(QPCIDevice *dev)
-{
-    return dev->bus->has_buggy_msi;
-}
-
-bool qpci_check_buggy_msi(QPCIDevice *dev)
-{
-    if (qpci_has_buggy_msi(dev)) {
-        g_test_skip("Skipping due to incomplete support for MSI");
-        return true;
-    }
-    return false;
-}
-
 static void qpci_device_set(QPCIDevice *dev, QPCIBus *bus, int devfn)
 {
     g_assert(dev);
diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
index d51bf240ee..c3a0f85fef 100644
--- a/tests/qtest/libqos/pci.h
+++ b/tests/qtest/libqos/pci.h
@@ -51,7 +51,6 @@ struct QPCIBus {
     QTestState *qts;
     uint64_t pio_alloc_ptr, pio_limit;
     uint64_t mmio_alloc_ptr, mmio_limit;
-    bool has_buggy_msi; /* TRUE for spapr, FALSE for pci */
     bool not_hotpluggable; /* TRUE if devices cannot be hotplugged */
 
 };
@@ -83,9 +82,6 @@ QPCIDevice *qpci_device_find(QPCIBus *bus, int devfn);
 void qpci_device_init(QPCIDevice *dev, QPCIBus *bus, QPCIAddress *addr);
 int qpci_secondary_buses_init(QPCIBus *bus);
 
-bool qpci_has_buggy_msi(QPCIDevice *dev);
-bool qpci_check_buggy_msi(QPCIDevice *dev);
-
 void qpci_device_enable(QPCIDevice *dev);
 uint8_t qpci_find_capability(QPCIDevice *dev, uint8_t id, uint8_t start_addr);
 void qpci_msix_enable(QPCIDevice *dev);
diff --git a/tests/qtest/nvme-test.c b/tests/qtest/nvme-test.c
index edf982a111..09972b50ff 100644
--- a/tests/qtest/nvme-test.c
+++ b/tests/qtest/nvme-test.c
@@ -493,10 +493,6 @@ static void test_migrate(void *obj, void *data, QGuestAllocator *alloc)
         { 333, false }
     };
 
-    if (qpci_check_buggy_msi(pdev)) {
-        return;
-    }
-
     /* create temporary dir and prepare unix socket path for migration */
     tmpfs = g_dir_make_tmp("nvme-test-XXXXXX", &err);
     if (!tmpfs) {
diff --git a/tests/qtest/vhost-user-blk-test.c b/tests/qtest/vhost-user-blk-test.c
index ea90d41232..3e71fdb9d7 100644
--- a/tests/qtest/vhost-user-blk-test.c
+++ b/tests/qtest/vhost-user-blk-test.c
@@ -554,14 +554,8 @@ static void idx(void *obj, void *u_data, QGuestAllocator *t_alloc)
     uint32_t desc_idx;
     uint8_t status;
     char *data;
-    QOSGraphObject *blk_object = obj;
-    QPCIDevice *pci_dev = blk_object->get_driver(blk_object, "pci-device");
     QTestState *qts = global_qtest;
 
-    if (qpci_check_buggy_msi(pci_dev)) {
-        return;
-    }
-
     qpci_msix_enable(pdev->pdev);
     qvirtio_pci_set_msix_configuration_vector(pdev, t_alloc, 0);
 
diff --git a/tests/qtest/virtio-blk-test.c b/tests/qtest/virtio-blk-test.c
index 722bd0711f..a7e864ee81 100644
--- a/tests/qtest/virtio-blk-test.c
+++ b/tests/qtest/virtio-blk-test.c
@@ -476,14 +476,8 @@ static void msix(void *obj, void *u_data, QGuestAllocator *t_alloc)
     uint32_t free_head;
     uint8_t status;
     char *data;
-    QOSGraphObject *blk_object = obj;
-    QPCIDevice *pci_dev = blk_object->get_driver(blk_object, "pci-device");
     QTestState *qts = global_qtest;
 
-    if (qpci_check_buggy_msi(pci_dev)) {
-        return;
-    }
-
     qpci_msix_enable(pdev->pdev);
     qvirtio_pci_set_msix_configuration_vector(pdev, t_alloc, 0);
 
@@ -586,14 +580,8 @@ static void idx(void *obj, void *u_data, QGuestAllocator *t_alloc)
     uint32_t desc_idx;
     uint8_t status;
     char *data;
-    QOSGraphObject *blk_object = obj;
-    QPCIDevice *pci_dev = blk_object->get_driver(blk_object, "pci-device");
     QTestState *qts = global_qtest;
 
-    if (qpci_check_buggy_msi(pci_dev)) {
-        return;
-    }
-
     qpci_msix_enable(pdev->pdev);
     qvirtio_pci_set_msix_configuration_vector(pdev, t_alloc, 0);
 
-- 
2.55.0


