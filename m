Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B34606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 03:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nuEr30SY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNj8d-00022e-0u; Sun, 01 Nov 2026 22:55:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xNj8Y-00021M-KC; Sun, 01 Nov 2026 22:55:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xNj8W-0003Gq-M9; Sun, 01 Nov 2026 22:55:10 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A20ieFp1467410; Mon, 2 Nov 2026 03:55:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+I9IXf
 apI9v9YdK6k/c3mk77lveHLBPtw0Uhyc76whU=; b=nuEr30SYfLDGhGbSbxPYQ+
 7Cs8AT0Vd9ihC0zFGKXqS4Ppy/XFv7lLjtfXV5Ay1KTf0OpGYqbmiAaXYrVvNsKw
 7HBbqI3uFy7TH7a6aNd/7jAusBBXXt6+z16yRoqauA27HjSdO+tQ9n4hdoC9JtFr
 /+hSMFF/5TT4owA6EZsS6kf2I5Tdv8x82xfxpfkX0fcE9jmjBRXTCWCADWktV7tb
 SD8w+yjTnl6oOKEjN/3LdalmbTJg6Sh+rtpy9E/VBM7YNNdcb85MRceV6s797tu8
 WdZVMZdSrswItT9edQS9NcsB4VMooZDW7KJi/oa/7i+ZKbsgqtQ6E3gtVgCOfV1Q
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn826ehap-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 03:55:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A20KCPW034910; Mon, 2 Nov 2026 03:55:02 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnunjv10e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 03:55:02 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A23t0Tu63701358
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Nov 2026 03:55:01 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA24658056;
 Mon,  2 Nov 2026 03:55:00 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F81658052;
 Mon,  2 Nov 2026 03:54:54 +0000 (GMT)
Received: from li-bd0dea4c-2912-11b2-a85c-e84940f94d2e.ibmuc.com (unknown
 [9.43.104.91]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  2 Nov 2026 03:54:53 +0000 (GMT)
From: uverma@linux.ibm.com
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, jishnuvw@linux.ibm.com, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, jsnow@redhat.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com, odaki@rsg.ci.i.u-tokyo.ac.jp,
 aleksandr.mikhalitsyn@futurfusion.io,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Utkarsh Verma <uverma@linux.ibm.com>
Subject: [PATCH v7 01/10] tests/qtest: Enforce zero for the "un-fired" msix
 message value
Date: Mon,  2 Nov 2026 09:22:57 +0530
Message-ID: <20261102035306.2291147-2-uverma@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102035306.2291147-1-uverma@linux.ibm.com>
References: <20261102035306.2291147-1-uverma@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: m3u9wGxDTVqrfhhdtICKQgCqtNGy9Do-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAxNCBTYWx0ZWRfX1t3+6eU8qTFq
 eD9au9pDrmDElIVUK5q1WkRH+SYeUnSu+7Wg64ZJh3H+7SrzMcc1Q1tZoelv49d4bolUsyao5lT
 I+0q4Oq73cNVm0EeXOdDjACFKcsakRpQdO1zRJDudTFGoB7ZJdfn+e4D6BSgNrSuIsKD+fcUaDl
 /5ip9jUYKl1jKIa/UjXWUGyRTx4UwHiz0d8/MFxdMqgRU353ITDlzRvZNHauzIoQEwxR4mPRMn/
 qIIsYqgX1OSnSe+xFMb9OCZint0iwU8OWQpAF67yHblD6SpjDm3Rd8DjGY8cTO1krS8LSSZ65T3
 SBK+JdTOCHwgvPztYA0KjMsT8ucXNJu1K0vT+CfKbdAJE1tV1Sicgnc5aoUmW5w7IgXTmyAfG5J
 UjlupsRNUwGNvdjyDMQ63dt2AnQdvEpmasjRApd7tZgCwnwxUeJ9o2mjrzic+9807mXNGgLUYEw
 Q1ggT6bWQiCSKubeWZA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAxNCBTYWx0ZWRfXz9rn2bhMlteA
 xW9OJNfGQnuxcs18PjlzdAJl+QK6Ht1jbmW7llzUL1laL4qRcZ7ZHprjQfePSQtJAL6hrt2uQsD
 JQGqmg14erjGOOhesJiWH3hhYLeqVUk=
X-Proofpoint-GUID: D0fFiq8Ty8_P-0Ll72w8FX-946YXnVOK
X-Authority-Analysis: v=2.4 cv=EsJHPicA c=1 sm=1 tr=0 ts=6ae80997 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=pGLkceISAAAA:8
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=cluJ50jZ9R0NNln75_EA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020014
Received-SPF: pass client-ip=148.163.156.1; envelope-from=uverma@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

virtio-pci detects an unmasked msix interrupt has fired by looking
for the data payload value at the target address. If a value of zero
is enforced for the memory value when an interrupt has not fired,
then an assertion can be added to catch the case where something
changed the memory to an unexpected value.

This catches an endian conversion bug in the message value when
running these tests on a big endian target. Previously the test
just times out waiting for interrupt, after this it fails nicely.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Jishnu Warrier <jishnuvw@linux.ibm.com>
Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
---
 tests/qtest/libqos/virtio-pci-modern.c |  9 +++++----
 tests/qtest/libqos/virtio-pci.c        | 20 ++++++++++++--------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/tests/qtest/libqos/virtio-pci-modern.c b/tests/qtest/libqos/virtio-pci-modern.c
index 4e67fcbd5d..f31b3be656 100644
--- a/tests/qtest/libqos/virtio-pci-modern.c
+++ b/tests/qtest/libqos/virtio-pci-modern.c
@@ -137,12 +137,13 @@ static bool get_msix_status(QVirtioPCIDevice *dev, uint32_t msix_entry,
     }
 
     data = qtest_readl(dev->pdev->bus->qts, msix_addr);
-    if (data == msix_data) {
-        qtest_writel(dev->pdev->bus->qts, msix_addr, 0);
-        return true;
-    } else {
+    if (data == 0) {
         return false;
     }
+    /* got a message, ensure it matches expected value then clear it. */
+    g_assert_cmphex(data, ==, msix_data);
+    qtest_writel(dev->pdev->bus->qts, msix_addr, 0);
+    return true;
 }
 
 static bool get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
diff --git a/tests/qtest/libqos/virtio-pci.c b/tests/qtest/libqos/virtio-pci.c
index 002bf8b8c2..102e45b524 100644
--- a/tests/qtest/libqos/virtio-pci.c
+++ b/tests/qtest/libqos/virtio-pci.c
@@ -132,12 +132,13 @@ static bool qvirtio_pci_get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
             return qpci_msix_pending(dev->pdev, vqpci->msix_entry);
         } else {
             data = qtest_readl(dev->pdev->bus->qts, vqpci->msix_addr);
-            if (data == vqpci->msix_data) {
-                qtest_writel(dev->pdev->bus->qts, vqpci->msix_addr, 0);
-                return true;
-            } else {
+            if (data == 0) {
                 return false;
             }
+            /* got a message, ensure it matches expected value then clear it. */
+            g_assert_cmphex(data, ==, vqpci->msix_data);
+            qtest_writel(dev->pdev->bus->qts, vqpci->msix_addr, 0);
+            return true;
         }
     } else {
         return qpci_io_readb(dev->pdev, dev->bar, VIRTIO_PCI_ISR) & 1;
@@ -156,12 +157,13 @@ static bool qvirtio_pci_get_config_isr_status(QVirtioDevice *d)
             return qpci_msix_pending(dev->pdev, dev->config_msix_entry);
         } else {
             data = qtest_readl(dev->pdev->bus->qts, dev->config_msix_addr);
-            if (data == dev->config_msix_data) {
-                qtest_writel(dev->pdev->bus->qts, dev->config_msix_addr, 0);
-                return true;
-            } else {
+            if (data == 0) {
                 return false;
             }
+            /* got a message, ensure it matches expected value then clear it. */
+            g_assert_cmphex(data, ==, dev->config_msix_data);
+            qtest_writel(dev->pdev->bus->qts, dev->config_msix_addr, 0);
+            return true;
         }
     } else {
         return qpci_io_readb(dev->pdev, dev->bar, VIRTIO_PCI_ISR) & 2;
@@ -323,6 +325,7 @@ void qvirtqueue_pci_msix_setup(QVirtioPCIDevice *d, QVirtQueuePCI *vqpci,
     vqpci->msix_entry = entry;
 
     vqpci->msix_addr = guest_alloc(alloc, 4);
+    qtest_memset(d->pdev->bus->qts, vqpci->msix_addr, 0, 4);
     qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
                    off + PCI_MSIX_ENTRY_LOWER_ADDR, vqpci->msix_addr & ~0UL);
     qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
@@ -355,6 +358,7 @@ void qvirtio_pci_set_msix_configuration_vector(QVirtioPCIDevice *d,
 
     d->config_msix_data = 0x12345678;
     d->config_msix_addr = guest_alloc(alloc, 4);
+    qtest_memset(d->pdev->bus->qts, d->config_msix_addr, 0, 4);
 
     qpci_io_writel(d->pdev, d->pdev->msix_table_bar,
                    off + PCI_MSIX_ENTRY_LOWER_ADDR, d->config_msix_addr & ~0UL);
-- 
2.55.0


