Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C2D606A32E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=L4AgJ4PP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIpR1-00059S-HO; Mon, 19 Oct 2026 11:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oelghoul@linux.ibm.com>)
 id 1xIpQw-000593-8v; Mon, 19 Oct 2026 11:37:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oelghoul@linux.ibm.com>)
 id 1xIpQs-0004uV-PR; Mon, 19 Oct 2026 11:37:53 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JEElEE4015180; Mon, 19 Oct 2026 15:37:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=3+XGRcJe/oeVl43Gv1FbUgMkahmod8g5y8FaH/hNQ
 Pk=; b=L4AgJ4PP47AkFaVwSfZfQqO6H0rGBKRiDISyiXbMMrNmXqanmuI/KvYKP
 IkjYOzJwOJgKtG3t+EcEAJWH0uoGRroH8m++oOlzvfUyLuhi3rIE2jMB697dNxBp
 gm+h2PRmLFcprIPdMnBiRmqdIa/z6o5D8Zsz/ozNYhouMejJQocL81MM2SnNOYf1
 NppZ6wRJzS990moEjWyCVnl2yANRr/uYYHXCfuYkcnklRHK3dim//enaB0JzcUiE
 ZfqQwjEefCMbEeZPRqpUnrzE/2DPjS92fs3sJ8ZsPn3mdBCrz321HNLYJvkfs0Je
 9zjbuSHdrKH1o20F10d+l+WUb+JNw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0r7m340-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 15:37:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JEJoRB020234; Mon, 19 Oct 2026 15:37:46 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hckqvee40-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 15:37:46 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69JFbhBj21627404
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Oct 2026 15:37:44 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA04A58055;
 Mon, 19 Oct 2026 15:37:43 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CED8B58065;
 Mon, 19 Oct 2026 15:37:42 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.242.107])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 19 Oct 2026 15:37:42 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, cam@linux.ibm.com,
 farman@linux.ibm.com, qemu-stable@nongnu.org
Subject: [PATCH v2] s390x/pci: re-fetch DMA slot shadow count from VFIO upon
 IOMMU disable
Date: Mon, 19 Oct 2026 11:37:29 -0400
Message-ID: <20261019153729.40823-1-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA2MCBTYWx0ZWRfX4FRP9e6Af9C/
 hQh3AvaXfwQf0wEjc//u3zw21jHMPbxK0INFDTam8Is5fSHKgY2tRG5AoNtVSu1GiNJCFx9oj9M
 0x9ahILQCX6Hjk/NBSq+1uwCSeGaDYo=
X-Authority-Analysis: v=2.4 cv=PrUG/AM3 c=1 sm=1 tr=0 ts=6ad6394b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=DP0TDp8FZMFJ59EArGYA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA2MCBTYWx0ZWRfX/06ovu9SEHKc
 EPSQA06rkt+CXc2+h2kaO41cVVB6dfJbK/saX4+ZGzeWhxH0viAHwjoJ593rtsguGWb8oM4js3O
 dxysOOI+9q33HSGCYl7RKhOgcq++AHx84UBrZFtb+P/zr3uam4fAx3d4pXCgS/3azoi1m3sB6cI
 HzU/WlTgX36VgpdYr6LafjKkPr/qjp0jS5PZHhXDeADkh6SYCFPeYcYUSUA54ONzPU0Rvow2zOW
 NpBBU2px/jE3n6AUHFkDllJzq7OBppy/OhNX6TtAeUjM0wUq13saN5Q1AOrKHgUhOc0yFN6FC5p
 qumH5oMVgqUo2C4c2WErjdNvjoYM8f/nsqNomwRvYtYrxtLzS6I2bv2piSmZXstg5Sp8yE6Dq1P
 MZquyV+evmFcuxnMG2CYLGiqcSCOWXxEdrn7EnwWQu1EoQzV1W2Sjy8PBda1IRW/dFYUh2TldOd
 WGE6iRrTXJI9CGJrxcQ==
X-Proofpoint-GUID: MMUM8aT1bjfDwEyU1fy6_2vEGmUEKkty
X-Proofpoint-ORIG-GUID: MMUM8aT1bjfDwEyU1fy6_2vEGmUEKkty
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190060
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=oelghoul@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

s390_pci_iommu_disable() destroys the I/O TLB and unpins the host's
mappings, but it doesn't reset the available DMA slot counter back to
the VFIO-advertised limit. This is problematic when an IOMMU is disabled
and re-enabled while reusing the container (e.g. during a guest reboot),
which may cause the RPCIT path to fail with DMA slot exhaustion errors,
manifesting as unexplained ENOMEMs in the guest.

Fix it by refactoring s390_pci_update_dma_avail() to take a pointer to
S390PCIBusDevice instead of the plain file descriptor. Call it in
s390_pci_iommu_disable() after the host mappings have been unpinned.

Further print a warning if the VFIO-advertised counter doesn't match the
in-use shadow counter, to reduce the likelihood of introducing new
similar DMA accounting bugs in the future.

Cc: qemu-stable@nongnu.org
Fixes: 37fa32de7073 ("s390x/pci: Honor DMA limits set by vfio")
Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
---
v1 -> v2: rebase on latest master, ensure that the device is a vfio-pci
device before calling vfio-specific code.
---
 hw/s390x/s390-pci-bus.c          | 21 +++++++++++++++++++++
 hw/s390x/s390-pci-vfio-stubs.c   |  2 +-
 hw/s390x/s390-pci-vfio.c         | 18 ++++++++++++------
 include/hw/s390x/s390-pci-vfio.h |  2 +-
 4 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 2724b27ec2..9938191c4d 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -825,6 +825,8 @@ void s390_pci_iommu_direct_map_enable(S390PCIBusDevice *pbdev)
 void s390_pci_iommu_disable(S390PCIBusDevice *pbdev)
 {
     S390PCIIOMMU *iommu = pbdev->iommu;
+    unsigned int dma_avail;
+
     pbdev->iommu_enabled = false;
     g_hash_table_remove_all(pbdev->iotlb);
     if (pbdev->dm_mr) {
@@ -837,6 +839,25 @@ void s390_pci_iommu_disable(S390PCIBusDevice *pbdev)
                                     MEMORY_REGION(&pbdev->iommu_mr));
         object_unparent(OBJECT(&pbdev->iommu_mr));
     }
+
+    /*
+     * update shadow counter from vfio after having unpinned all host mappings.
+     * if this value mismatches our previous shadow count, then we likely have
+     * DMA remapping, unmapping, or accounting bugs
+     */
+    if (object_dynamic_cast(OBJECT(pbdev->pdev), "vfio-pci")) {
+        if (s390_pci_update_dma_avail(pbdev, &dma_avail)) {
+            if (pbdev->max_dma_limit != dma_avail) {
+                warn_report("DMA limit %u from vfio != %" PRIu64 " shadowed",
+                            dma_avail, pbdev->max_dma_limit);
+                pbdev->max_dma_limit = dma_avail;
+            }
+
+            if (pbdev->dma_limit) {
+                pbdev->dma_limit->avail = dma_avail;
+            }
+        }
+    }
 }
 
 static void s390_pci_iommu_free(S390pciState *s, PCIBus *bus, int32_t devfn)
diff --git a/hw/s390x/s390-pci-vfio-stubs.c b/hw/s390x/s390-pci-vfio-stubs.c
index 9fc84ca135..5e0782ac0e 100644
--- a/hw/s390x/s390-pci-vfio-stubs.c
+++ b/hw/s390x/s390-pci-vfio-stubs.c
@@ -7,7 +7,7 @@
 #include "qemu/osdep.h"
 #include "hw/s390x/s390-pci-vfio.h"
 
-bool s390_pci_update_dma_avail(int fd, unsigned int *avail)
+bool s390_pci_update_dma_avail(S390PCIBusDevice *pbdev, unsigned int *avail)
 {
     return false;
 }
diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index e65e2be473..f9a454ef7d 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -30,13 +30,23 @@
  * limiting DMA requests, false otherwise.  The current available count read
  * from vfio is returned in avail.
  */
-bool s390_pci_update_dma_avail(int fd, unsigned int *avail)
+bool s390_pci_update_dma_avail(S390PCIBusDevice *pbdev, unsigned int *avail)
 {
+    VFIOPCIDevice *vpdev;
     uint32_t argsz = sizeof(struct vfio_iommu_type1_info);
     g_autofree struct vfio_iommu_type1_info *info = g_malloc0(argsz);
+    int fd;
 
+    assert(pbdev);
     assert(avail);
 
+    vpdev = VFIO_PCI_DEVICE(pbdev->pdev);
+    if (!vpdev->vbasedev.group || !vpdev->vbasedev.group->container) {
+        return false;
+    }
+
+    fd = vpdev->vbasedev.group->container->fd;
+
     /*
      * If the specified argsz is not large enough to contain all capabilities
      * it will be updated upon return from the ioctl.  Retry until we have
@@ -69,16 +79,12 @@ S390PCIDMACount *s390_pci_start_dma_count(S390pciState *s,
 
     assert(vpdev);
 
-    if (!vpdev->vbasedev.group) {
+    if (!s390_pci_update_dma_avail(pbdev, &avail)) {
         return NULL;
     }
 
     id = vpdev->vbasedev.group->container->fd;
 
-    if (!s390_pci_update_dma_avail(id, &avail)) {
-        return NULL;
-    }
-
     QTAILQ_FOREACH(cnt, &s->zpci_dma_limit, link) {
         if (cnt->id  == id) {
             cnt->users++;
diff --git a/include/hw/s390x/s390-pci-vfio.h b/include/hw/s390x/s390-pci-vfio.h
index c7886b63ea..25d9e74f94 100644
--- a/include/hw/s390x/s390-pci-vfio.h
+++ b/include/hw/s390x/s390-pci-vfio.h
@@ -14,7 +14,7 @@
 
 #include "hw/s390x/s390-pci-bus.h"
 
-bool s390_pci_update_dma_avail(int fd, unsigned int *avail);
+bool s390_pci_update_dma_avail(S390PCIBusDevice *pbdev, unsigned int *avail);
 S390PCIDMACount *s390_pci_start_dma_count(S390pciState *s,
                                           S390PCIBusDevice *pbdev);
 void s390_pci_end_dma_count(S390pciState *s, S390PCIDMACount *cnt);
-- 
2.56.0


