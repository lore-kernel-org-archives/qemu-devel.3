Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA599606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 03:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=grspioeo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNj9A-0002SL-H3; Sun, 01 Nov 2026 22:55:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xNj98-0002Q4-6c; Sun, 01 Nov 2026 22:55:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xNj96-0003NP-9e; Sun, 01 Nov 2026 22:55:45 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A20iLPh1467125; Mon, 2 Nov 2026 03:55:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=2R3rzjY5gF9Lj0vxo
 YveHloOqYr0Skq30ZFVjOHSrwQ=; b=grspioeoO3yp+laD11YTDNsuLChptKv/E
 BfTkI3izeEb7VaZr9aR2duPZcwEeLtUwCyndFd+evv5AXogTYxQQHWrvdTsICXTz
 ja0BSLhyryMdj4MPgEMDjpdh4GmdwfAp+vpTHsWZVkBR/KKioBwBnM/4SQmbiHnO
 xkklOI+Urt4IG7Hyel1FIkV8/xrvTGRgREdWJ+QjS0WhMx0go3Egwm+p3vOzrtZJ
 4Cg7ijL2Jk3FDHiwv40JhlRLE34vU6pXX4hAkaGbj+7GiNKQO5hzwtOlJYg+i2V+
 /SK5hAWY5d1p+WsCjMXXsqcWWZGW5FsQarXmOp8f5EmSLkW2sS8zw==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn826ehcd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 03:55:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A20K8Ao148915; Mon, 2 Nov 2026 03:55:38 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hnwbxusgc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 03:55:38 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A23tbkG22675978
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Nov 2026 03:55:37 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9EA505805E;
 Mon,  2 Nov 2026 03:55:37 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B9FB58062;
 Mon,  2 Nov 2026 03:55:30 +0000 (GMT)
Received: from li-bd0dea4c-2912-11b2-a85c-e84940f94d2e.ibmuc.com (unknown
 [9.43.104.91]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  2 Nov 2026 03:55:29 +0000 (GMT)
From: uverma@linux.ibm.com
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, jishnuvw@linux.ibm.com, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, jsnow@redhat.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com, odaki@rsg.ci.i.u-tokyo.ac.jp,
 aleksandr.mikhalitsyn@futurfusion.io,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Utkarsh Verma <uverma@linux.ibm.com>
Subject: [PATCH v7 06/10] tests/qtest/ahci: unmap pci bar before reusing device
Date: Mon,  2 Nov 2026 09:23:02 +0530
Message-ID: <20261102035306.2291147-7-uverma@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102035306.2291147-1-uverma@linux.ibm.com>
References: <20261102035306.2291147-1-uverma@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 5pRwD2qAd5GOYKOOR0E9KBksG6Ar0v7W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAxNCBTYWx0ZWRfX8m4XMWG40zJC
 dVF7S3vt9LEqxCFlGyGqNve18RURzsPPxFPZoUaMbCFxpN06bpxvEqgf7BrzxUoFCW1kM6yFRiH
 5z8BxVk3nu6vJBWRWPKqCd1xLWs7udakWwltADlcNmJGU7UxCclg6vx0bBfO8TAUVkaYFhprqnY
 BOdJh8d2wEbpzNuluLCLfEmO+g3/7a0QKyJVCdqXND2fAxCDkKFaqKef3MM8B0x2xNLWGHRr4ve
 z1tdnCoCEwAoXlZAE0PQLGheg5HB6lzag0sPI8jPUEJPYy6mfzuBaB9eGpxreXoTQ+CpM83Cj9e
 NcolBRzrQs5XJL+UvvBReTphg4ysFU5AeKry4tP9L2OqsEgrTg4KmSjE8hRxIhwt2dFT7pwurDG
 B31ZSyLL91svpa3UffjB6w4pN0gA1Gyaym91KVVQyqAdKINn4pr63NmwINGlsnrC065Bsae0ebh
 TrXDZxoUwkn/tZE7Svg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAxNCBTYWx0ZWRfXx49q3cfyyIU1
 gbTn+hFhAfmfXu3YZZFwDDJcfQ+IPONI8AYua5LwC5imwRd1dh17XebRrMP3/VWHX/q5wbHbf2E
 fwK4O5MuSM9Ed5rSMz21u18s64ihL3o=
X-Proofpoint-GUID: ImvFCXVH3zoycyVLNZlEh0PLUx1OvTdz
X-Authority-Analysis: v=2.4 cv=EsJHPicA c=1 sm=1 tr=0 ts=6ae809bb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=z4glEzOvAAAA:8
 a=VnNF1IyMAAAA:8 a=vef69Nw4dH7SYshA8_MA:9 a=92dS5hN0c3Q7EetK7xW5:22
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

ahci-test double-maps the hba bar in the pending_callback test.
Unmap it first, to keep iomaps balanced.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Jishnu Warrier <jishnuvw@linux.ibm.com>
Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
---
 tests/qtest/ahci-test.c   |  6 ++++++
 tests/qtest/libqos/ahci.c | 11 +++++++++++
 tests/qtest/libqos/ahci.h |  2 ++
 3 files changed, 19 insertions(+)

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index c49aa61862..043a916fdd 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -85,6 +85,8 @@ static void verify_state(AHCIQState *ahci, uint64_t hba_old)
     uint64_t hba_base;
     AHCICommandHeader cmd;
 
+    g_assert_cmphex(ahci->hba_bar.addr, ==, hba_old);
+
     ahci_fingerprint = qpci_config_readl(ahci->dev, PCI_VENDOR_ID);
     g_assert_cmphex(ahci_fingerprint, ==, ahci->fingerprint);
 
@@ -198,6 +200,7 @@ static void ahci_shutdown(AHCIQState *ahci)
 {
     QOSState *qs = ahci->parent;
 
+    ahci_pci_disable(ahci);
     ahci_clean_mem(ahci);
     free_ahci_device(ahci->dev);
     g_free(ahci);
@@ -1457,7 +1460,9 @@ static void test_reset(void)
                                CMD_READ_DMA_EXT,
                                CMD_WRITE_DMA_EXT);
         ahci_set(ahci, AHCI_GHC, AHCI_GHC_HR);
+        stop_ahci_device(ahci);
         ahci_clean_mem(ahci);
+        start_ahci_device(ahci);
     }
 
     ahci_shutdown(ahci);
@@ -1523,6 +1528,7 @@ static void test_reset_pending_callback(void)
     sleep(1);
 
     /* Start again. */
+    stop_ahci_device(ahci);
     ahci_clean_mem(ahci);
     ahci_pci_enable(ahci);
     ahci_hba_enable(ahci);
diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index 50b63239c2..a709558aac 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -206,6 +206,11 @@ void ahci_pci_enable(AHCIQState *ahci)
 
 }
 
+void ahci_pci_disable(AHCIQState *ahci)
+{
+    stop_ahci_device(ahci);
+}
+
 /**
  * Map BAR5/ABAR, and engage the PCI device.
  */
@@ -218,6 +223,12 @@ void start_ahci_device(AHCIQState *ahci)
     qpci_device_enable(ahci->dev);
 }
 
+void stop_ahci_device(AHCIQState *ahci)
+{
+    /* Unmap AHCI's ABAR */
+    qpci_iounmap(ahci->dev, ahci->hba_bar);
+}
+
 /**
  * Test and initialize the AHCI's HBA memory areas.
  * Initialize and start any ports with devices attached.
diff --git a/tests/qtest/libqos/ahci.h b/tests/qtest/libqos/ahci.h
index 6d861c79ee..f098c91b47 100644
--- a/tests/qtest/libqos/ahci.h
+++ b/tests/qtest/libqos/ahci.h
@@ -580,7 +580,9 @@ void ahci_clean_mem(AHCIQState *ahci);
 QPCIDevice *get_ahci_device(QTestState *qts, uint32_t *fingerprint);
 void free_ahci_device(QPCIDevice *dev);
 void ahci_pci_enable(AHCIQState *ahci);
+void ahci_pci_disable(AHCIQState *ahci);
 void start_ahci_device(AHCIQState *ahci);
+void stop_ahci_device(AHCIQState *ahci);
 void ahci_hba_enable(AHCIQState *ahci);
 
 /* Port Management */
-- 
2.55.0


