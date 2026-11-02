Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456B3606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 03:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fiRWAefa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNj8k-000259-Rv; Sun, 01 Nov 2026 22:55:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xNj8d-00023H-9a; Sun, 01 Nov 2026 22:55:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xNj8b-0003IP-7p; Sun, 01 Nov 2026 22:55:14 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A20iIw41413207; Mon, 2 Nov 2026 03:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=aXp679
 GK+WSDqA+QdNt+0ojszIGgJ0yMyz9o6qzwwIk=; b=fiRWAefaL24Xi6DuncPR7O
 je1j+0POma6qEQsZIMJwJEm+63bG9zqnOko+EJFkuhehhfkW6/cxDaG2U4+728Ph
 Y2JkD1VLsHUFMZQdZ0x/mtmHl+H9kbodL04Rb3R/6sucmYGS3FUzmYBVHZqMhR72
 sfFvUXJvkigAu5K9fpsx8urqMgBDWtss7Cu92zBL1QFftqFCpttlYRcoRZ4Npdof
 j7oqLGv6K8i6wJzRwTk6sbmQzECfUiMbdZNWM8AfsgL0ow4PF2nj7fcIe5Xl0nyX
 exOw076mCe3VlK17AS5/7nE/i3JtNnXBOAVDh0K4HqJEeTC4QtW3HIBC0/m3EEwg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn5rheqj5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 03:55:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A20KHDU034958; Mon, 2 Nov 2026 03:55:08 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnunjv10r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 03:55:08 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A23t7bd33554704
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Nov 2026 03:55:07 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9FDDD58052;
 Mon,  2 Nov 2026 03:55:07 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA6C05805E;
 Mon,  2 Nov 2026 03:55:01 +0000 (GMT)
Received: from li-bd0dea4c-2912-11b2-a85c-e84940f94d2e.ibmuc.com (unknown
 [9.43.104.91]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  2 Nov 2026 03:55:01 +0000 (GMT)
From: uverma@linux.ibm.com
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, jishnuvw@linux.ibm.com, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, jsnow@redhat.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com, odaki@rsg.ci.i.u-tokyo.ac.jp,
 aleksandr.mikhalitsyn@futurfusion.io,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Utkarsh Verma <uverma@linux.ibm.com>
Subject: [PATCH v7 02/10] tests/qtest: Fix virtio msix message endianness
Date: Mon,  2 Nov 2026 09:22:58 +0530
Message-ID: <20261102035306.2291147-3-uverma@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102035306.2291147-1-uverma@linux.ibm.com>
References: <20261102035306.2291147-1-uverma@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: H9dqpr-46v2f67FBtdhAJMj2GdrekzRy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAxNCBTYWx0ZWRfX7D8c8NULW1N7
 mKSWA2+tkYNzmw0033hQkp3ODViNNlnmV+d2QAuOv63uNKGcjHG6cBPAQ/9LvLMYYacWfJksOmK
 UFpLd6WV3LAP5cCtqR7JE90Hlj/5zj4=
X-Authority-Analysis: v=2.4 cv=LokHWXdc c=1 sm=1 tr=0 ts=6ae8099d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=pGLkceISAAAA:8
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=Oifax1jXoojvXuSGEc8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAxNCBTYWx0ZWRfX0nROdtmN3GZD
 2D2gXsQ3zR6D7S0wb9CetwPEB1hwqGCdo0/SaSYLB1eo3otZBYbRxaAxIOv6pbyO/l4XonyTNIG
 rxvQsVMRqXRrt6gUfQfgMDlEs0Z9LXydFgLVw4pPQBWf59VXj1gLekbPuuP3O3AT111cbRbHydV
 VVguXzesylJK8GyX2pL3fsxcp0A/sqdbztkDlDKm2mIfLZ9CDjiGv2Rj8vl8NVO3VQANCBpGMPR
 wkjk/CnfcXi5TChD1qSpHua2fKQBG5j9oWUQvTQBS9PTXuxLl25sktQspyNkxLykrxhgdRky7Cm
 zplTZ/zTCyvbQmPaVnI06QObXaILUOKIpj7ZO78a0rMc/KfpZGWbDUXA/lkKYVt0UH8wDmH5Z6Z
 W6LWnC5AuGCoFxo6TNuhjKvrBIGL50Ca1A3XeXz7Z4XT//gMhGYAs2bm25fYPJtRKAjTWk1e/7q
 04jPt3HW7H6hxTnCf2w==
X-Proofpoint-GUID: 0Y7DUm8YEAQL_0WUftjBbLo50CMvbPdE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
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

msix messages are written to memory in little-endian order, so they
should not be byteswapped depending on target endianness, but read
as le and converted to host endian by the qtest.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Jishnu Warrier <jishnuvw@linux.ibm.com>
Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
---
 tests/qtest/libqos/virtio-pci-modern.c | 4 +++-
 tests/qtest/libqos/virtio-pci.c        | 8 ++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/libqos/virtio-pci-modern.c b/tests/qtest/libqos/virtio-pci-modern.c
index f31b3be656..097b548f95 100644
--- a/tests/qtest/libqos/virtio-pci-modern.c
+++ b/tests/qtest/libqos/virtio-pci-modern.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 #include "standard-headers/linux/pci_regs.h"
 #include "standard-headers/linux/virtio_pci.h"
 #include "standard-headers/linux/virtio_config.h"
@@ -136,7 +137,8 @@ static bool get_msix_status(QVirtioPCIDevice *dev, uint32_t msix_entry,
         return qpci_msix_pending(dev->pdev, msix_entry);
     }
 
-    data = qtest_readl(dev->pdev->bus->qts, msix_addr);
+    qtest_memread(dev->pdev->bus->qts, msix_addr, &data, sizeof(data));
+    data = le32_to_cpu(data);
     if (data == 0) {
         return false;
     }
diff --git a/tests/qtest/libqos/virtio-pci.c b/tests/qtest/libqos/virtio-pci.c
index 102e45b524..d2b978d4b1 100644
--- a/tests/qtest/libqos/virtio-pci.c
+++ b/tests/qtest/libqos/virtio-pci.c
@@ -131,7 +131,9 @@ static bool qvirtio_pci_get_queue_isr_status(QVirtioDevice *d, QVirtQueue *vq)
             /* No ISR checking should be done if masked, but read anyway */
             return qpci_msix_pending(dev->pdev, vqpci->msix_entry);
         } else {
-            data = qtest_readl(dev->pdev->bus->qts, vqpci->msix_addr);
+            qtest_memread(dev->pdev->bus->qts, vqpci->msix_addr,
+                          &data, sizeof(data));
+            data = le32_to_cpu(data);
             if (data == 0) {
                 return false;
             }
@@ -156,7 +158,9 @@ static bool qvirtio_pci_get_config_isr_status(QVirtioDevice *d)
             /* No ISR checking should be done if masked, but read anyway */
             return qpci_msix_pending(dev->pdev, dev->config_msix_entry);
         } else {
-            data = qtest_readl(dev->pdev->bus->qts, dev->config_msix_addr);
+            qtest_memread(dev->pdev->bus->qts, dev->config_msix_addr,
+                          &data, sizeof(data));
+            data = le32_to_cpu(data);
             if (data == 0) {
                 return false;
             }
-- 
2.55.0


