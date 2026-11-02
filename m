Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF287606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 03:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Q203uzk4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNj9n-0003LK-1a; Sun, 01 Nov 2026 22:56:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xNj9f-00037a-Ik; Sun, 01 Nov 2026 22:56:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xNj9d-0003SJ-1q; Sun, 01 Nov 2026 22:56:19 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A20j6qM1488512; Mon, 2 Nov 2026 03:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=IQ/56O5uoiUX/D7dB
 ULyowz6tyJJdgL52u2zVAMk5LM=; b=Q203uzk4dEEY7dG7uYZfIg2/QDZdDGFEi
 f10w8oH8UxHZMLa7CsEK5WGb8t0nRSW7k14fkeivOds9kuHoatnKGriPKKqDphzG
 jVTIeWiPbCUvoEcB4Ik5KEnksJ+YYG8K0R8/XQDh7p68KT0jJIxmYbHi3MGNYJ+I
 WSEI7Kf6+wSo/lHPY0JoJYp8tt4cuLS38VIDpLqILNVLj16Nd215eJ5JKqUaTPcY
 egpldXYhRFjLaNnPAXK7nWFnmkcNFzdYPLsauHBng9wx2wjaHL4fUFk6TcPNyN5y
 p7fLLq9JvaQeqgo4ywbPhrSxdb9yxUrvKimvYLiDE3Tzvds2UUu/Q==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7yrpf4w-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 03:56:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A20KORv3119755; Mon, 2 Nov 2026 03:56:10 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hnvvfkvk4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 03:56:10 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A23u9Vn30278292
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Nov 2026 03:56:09 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EEF5358056;
 Mon,  2 Nov 2026 03:56:08 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B455B5805A;
 Mon,  2 Nov 2026 03:56:02 +0000 (GMT)
Received: from li-bd0dea4c-2912-11b2-a85c-e84940f94d2e.ibmuc.com (unknown
 [9.43.104.91]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  2 Nov 2026 03:56:02 +0000 (GMT)
From: uverma@linux.ibm.com
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, jishnuvw@linux.ibm.com, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, jsnow@redhat.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com, odaki@rsg.ci.i.u-tokyo.ac.jp,
 aleksandr.mikhalitsyn@futurfusion.io,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Utkarsh Verma <uverma@linux.ibm.com>
Subject: [PATCH v7 10/10] qtest/libqos/pci: Factor msix entry helpers into pci
 common code
Date: Mon,  2 Nov 2026 09:23:06 +0530
Message-ID: <20261102035306.2291147-11-uverma@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102035306.2291147-1-uverma@linux.ibm.com>
References: <20261102035306.2291147-1-uverma@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Mcr5KJ/f c=1 sm=1 tr=0 ts=6ae809dc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8 a=z4glEzOvAAAA:8 a=VnNF1IyMAAAA:8
 a=P218vikjN2MXQ0MQqnQA:9 a=92dS5hN0c3Q7EetK7xW5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAxNCBTYWx0ZWRfXwMM5nYZCnr3g
 6hFSnBW2WCQI0fOlLioUuFCEgWuiq5bx4CHxcH6AoNm3Ww28BTjhiPUau54bZ3XSGcKie8elW52
 pfLwpWpVPIcYDKO3BYxbR5E+PqRSHnA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAxNCBTYWx0ZWRfX/L1h6VPkhZbV
 qJXt1U5OZHmEloRpc/lF2MF069Sl5aBTTpowBiqLVRsQgvtucULqWw7jWf2MQj+Uf6QVG2TsJYk
 ttBN7QY8EtBKOYXowU7pYz7gPIykG2MbBbCKpiswZ/ebKeMGnl+hhQreqCgRvey5RS/lA0Nik6v
 61qKRZDsffiHsibYfVipUj3sa1AYus9DiAHOrXb4e30rseJmbmQzRHJgVQI//hMOmFfwDHgRuAa
 Sxir1xhf821G0WlGd010bH1R9dL5Fk2EkkCmi8KPGJB4qKW56ivsRXa64614BpW7qI0qzpktjGB
 gAyNOARWjArrDbMCz3txaRE17Hyg7MqoRhaJzbW+SLdgs2B46LAzrAnx+taPiPOii+DLxZSf48f
 YJhksC/Q5oikyD/6IUaw09FUjE3tn6Ul4evbpOPvE/TmP5koQQaKNbKbh2dHBsPzHUINIVZwy2r
 ec/ZZm6P6iILQXuCeNw==
X-Proofpoint-GUID: WQwl7O-blV2PUrs8PZmaHxsdEz7qsX0x
X-Proofpoint-ORIG-GUID: RFFPZHYwJFDjp-zC64N4JGS0kCq9PjpN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020014
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

Setting msix entry address and data and masking is moved into
common code helpers from virtio tests.

For now that remains the only user, but there are changes under
development to enable msix vectors for msix, e1000e, and xhci
tests, which can make use of them.

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Jishnu Warrier <jishnuvw@linux.ibm.com>
Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
---
 tests/qtest/libqos/pci.c        | 49 +++++++++++++++++++++++++++++++++
 tests/qtest/libqos/pci.h        |  3 ++
 tests/qtest/libqos/virtio-pci.c | 48 ++++----------------------------
 3 files changed, 57 insertions(+), 43 deletions(-)

diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
index 41f9673022..253c5df3e4 100644
--- a/tests/qtest/libqos/pci.c
+++ b/tests/qtest/libqos/pci.c
@@ -339,6 +339,24 @@ void qpci_msix_disable(QPCIDevice *dev)
     dev->msix_pba_off = 0;
 }
 
+void qpci_msix_set_entry(QPCIDevice *dev, uint16_t entry,
+                         uint64_t guest_addr, uint32_t data)
+{
+    uint64_t vector_off = dev->msix_table_off + entry * PCI_MSIX_ENTRY_SIZE;
+
+    g_assert(dev->msix_enabled);
+    g_assert_cmpint(entry, <, qpci_msix_table_size(dev));
+
+    qpci_io_writel(dev, dev->msix_table_bar,
+                   vector_off + PCI_MSIX_ENTRY_LOWER_ADDR, guest_addr & ~0UL);
+    qpci_io_writel(dev, dev->msix_table_bar,
+                   vector_off + PCI_MSIX_ENTRY_UPPER_ADDR,
+                   (guest_addr >> 32) & ~0UL);
+
+    qpci_io_writel(dev, dev->msix_table_bar,
+                   vector_off + PCI_MSIX_ENTRY_DATA, data);
+}
+
 bool qpci_msix_pending(QPCIDevice *dev, uint16_t entry)
 {
     uint32_t pba_entry;
@@ -346,6 +364,8 @@ bool qpci_msix_pending(QPCIDevice *dev, uint16_t entry)
     uint64_t  off = (entry / 32) * PCI_MSIX_ENTRY_SIZE / 4;
 
     g_assert(dev->msix_enabled);
+    g_assert_cmpint(entry, <, qpci_msix_table_size(dev));
+
     pba_entry = qpci_io_readl(dev, dev->msix_pba_bar, dev->msix_pba_off + off);
     return (pba_entry & (1 << bit_n)) != 0;
 }
@@ -357,6 +377,8 @@ bool qpci_msix_masked(QPCIDevice *dev, uint16_t entry)
     uint64_t vector_off = dev->msix_table_off + entry * PCI_MSIX_ENTRY_SIZE;
 
     g_assert(dev->msix_enabled);
+    g_assert_cmpint(entry, <, qpci_msix_table_size(dev));
+
     addr = qpci_find_capability(dev, PCI_CAP_ID_MSIX, 0);
     g_assert_cmphex(addr, !=, 0);
     val = qpci_config_readw(dev, addr + PCI_MSIX_FLAGS);
@@ -370,6 +392,33 @@ bool qpci_msix_masked(QPCIDevice *dev, uint16_t entry)
     }
 }
 
+void qpci_msix_set_masked(QPCIDevice *dev, uint16_t entry, bool masked)
+{
+    uint8_t addr;
+    uint16_t val;
+    uint64_t vector_off = dev->msix_table_off + entry * PCI_MSIX_ENTRY_SIZE;
+
+    g_assert(dev->msix_enabled);
+    g_assert_cmpint(entry, <, qpci_msix_table_size(dev));
+
+    addr = qpci_find_capability(dev, PCI_CAP_ID_MSIX, 0);
+    g_assert_cmphex(addr, !=, 0);
+    val = qpci_config_readw(dev, addr + PCI_MSIX_FLAGS);
+    g_assert(!(val & PCI_MSIX_FLAGS_MASKALL));
+
+    val = qpci_io_readl(dev, dev->msix_table_bar,
+                         vector_off + PCI_MSIX_ENTRY_VECTOR_CTRL);
+    if (masked && !(val & PCI_MSIX_ENTRY_CTRL_MASKBIT)) {
+        qpci_io_writel(dev, dev->msix_table_bar,
+                      vector_off + PCI_MSIX_ENTRY_VECTOR_CTRL,
+                      val | PCI_MSIX_ENTRY_CTRL_MASKBIT);
+    } else if (!masked && (val & PCI_MSIX_ENTRY_CTRL_MASKBIT)) {
+        qpci_io_writel(dev, dev->msix_table_bar,
+                      vector_off + PCI_MSIX_ENTRY_VECTOR_CTRL,
+                      val & ~PCI_MSIX_ENTRY_CTRL_MASKBIT);
+    }
+}
+
 /**
  * qpci_msix_test_interrupt - test whether MSI-X interrupt has been raised
  * @dev: PCI device
diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
index 2fcddd19a8..986cc53c3a 100644
--- a/tests/qtest/libqos/pci.h
+++ b/tests/qtest/libqos/pci.h
@@ -97,8 +97,11 @@ void qpci_device_enable(QPCIDevice *dev);
 uint8_t qpci_find_capability(QPCIDevice *dev, uint8_t id, uint8_t start_addr);
 void qpci_msix_enable(QPCIDevice *dev);
 void qpci_msix_disable(QPCIDevice *dev);
+void qpci_msix_set_entry(QPCIDevice *dev, uint16_t entry,
+                         uint64_t guest_addr, uint32_t data);
 bool qpci_msix_pending(QPCIDevice *dev, uint16_t entry);
 bool qpci_msix_masked(QPCIDevice *dev, uint16_t entry);
+void qpci_msix_set_masked(QPCIDevice *dev, uint16_t entry, bool masked);
 bool qpci_msix_test_interrupt(QPCIDevice *dev, uint16_t msix_entry,
                               uint64_t msix_addr, uint32_t msix_data);
 uint16_t qpci_msix_table_size(QPCIDevice *dev);
diff --git a/tests/qtest/libqos/virtio-pci.c b/tests/qtest/libqos/virtio-pci.c
index ea8114e243..16e0220920 100644
--- a/tests/qtest/libqos/virtio-pci.c
+++ b/tests/qtest/libqos/virtio-pci.c
@@ -290,66 +290,28 @@ void qvirtio_pci_device_disable(QVirtioPCIDevice *d)
 void qvirtqueue_pci_msix_setup(QVirtioPCIDevice *d, QVirtQueuePCI *vqpci,
                                         QGuestAllocator *alloc, uint16_t entry)
 {
-    uint32_t control;
-    uint64_t off;
-
     g_assert(d->pdev->msix_enabled);
-    off = d->pdev->msix_table_off + (entry * 16);
-
-    g_assert_cmpint(entry, >=, 0);
-    g_assert_cmpint(entry, <, qpci_msix_table_size(d->pdev));
     vqpci->msix_entry = entry;
-
     vqpci->msix_addr = guest_alloc(alloc, 4);
     qtest_memset(d->pdev->bus->qts, vqpci->msix_addr, 0, 4);
-    qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
-                   off + PCI_MSIX_ENTRY_LOWER_ADDR, vqpci->msix_addr & ~0UL);
-    qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
-                   off + PCI_MSIX_ENTRY_UPPER_ADDR,
-                   (vqpci->msix_addr >> 32) & ~0UL);
-    qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
-                   off + PCI_MSIX_ENTRY_DATA, vqpci->msix_data);
-
-    control = qpci_io_readl(d->pdev, d->pdev->msix_table_bar,
-                            off + PCI_MSIX_ENTRY_VECTOR_CTRL);
-    qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
-                   off + PCI_MSIX_ENTRY_VECTOR_CTRL,
-                   control & ~PCI_MSIX_ENTRY_CTRL_MASKBIT);
 
+    qpci_msix_set_entry(d->pdev, entry, vqpci->msix_addr, vqpci->msix_data);
+    qpci_msix_set_masked(d->pdev, entry, false);
     d->msix_ops->set_queue_vector(d, vqpci->vq.index, entry);
 }
 
 void qvirtio_pci_set_msix_configuration_vector(QVirtioPCIDevice *d,
                                         QGuestAllocator *alloc, uint16_t entry)
 {
-    uint32_t control;
-    uint64_t off;
-
     g_assert(d->pdev->msix_enabled);
-    off = d->pdev->msix_table_off + (entry * 16);
-
-    g_assert_cmpint(entry, >=, 0);
-    g_assert_cmpint(entry, <, qpci_msix_table_size(d->pdev));
     d->config_msix_entry = entry;
-
     d->config_msix_data = 0x12345678;
     d->config_msix_addr = guest_alloc(alloc, 4);
     qtest_memset(d->pdev->bus->qts, d->config_msix_addr, 0, 4);
 
-    qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
-                   off + PCI_MSIX_ENTRY_LOWER_ADDR, d->config_msix_addr & ~0UL);
-    qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
-                   off + PCI_MSIX_ENTRY_UPPER_ADDR,
-                   (d->config_msix_addr >> 32) & ~0UL);
-    qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
-                   off + PCI_MSIX_ENTRY_DATA, d->config_msix_data);
-
-    control = qpci_io_readl(d->pdev, d->pdev->msix_table_bar,
-                            off + PCI_MSIX_ENTRY_VECTOR_CTRL);
-    qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
-                   off + PCI_MSIX_ENTRY_VECTOR_CTRL,
-                   control & ~PCI_MSIX_ENTRY_CTRL_MASKBIT);
-
+    qpci_msix_set_entry(d->pdev, entry, d->config_msix_addr,
+                                        d->config_msix_data);
+    qpci_msix_set_masked(d->pdev, entry, false);
     d->msix_ops->set_config_vector(d, entry);
 }
 
-- 
2.55.0


