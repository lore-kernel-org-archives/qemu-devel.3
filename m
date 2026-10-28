Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCB1606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 22:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=R8131ziZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMCPY-00011x-AG; Wed, 28 Oct 2026 18:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1xMCPV-0000zl-5P; Wed, 28 Oct 2026 18:46:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1xMCPT-0007OK-Hj; Wed, 28 Oct 2026 18:46:20 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SMF4Dx2450987; Wed, 28 Oct 2026 22:46:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=n+IU2xcGUtTkp4jfs47fqI/RtRmhGP5bI1j4XEo37
 Pc=; b=R8131ziZcCSPhMJOVINDL0hiIgRuysID+T17hfiuXTmb8G2lr7FtsdsPQ
 BC+vzlYN83jRxufMr9R99etVF1n+t/NPEKqp+ivF4A0MhHLx1nP6ZQmGyJ8krSeB
 5PfAr2H962Q2Y6j/moQAP80kaVIqswHLVmsA18iHUieD7dIvYJ205vCgd64P1sZP
 11rlhXrKhwW6s1qIGnetXffbUsdEyNBk8YBfc8iS94c4KxRyjBT1udtDymEEvH9M
 eyAfWdSuZ8p8GsAC3vgG8EV4A2N5h9wvkwa3zHJEURZ0HzwRGON0gqHU6nk/2GnL
 dqn+mcVNKuzK92bCTCfHvOlJa5DIA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmd77977-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 28 Oct 2026 22:46:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SMKEgv1022419; Wed, 28 Oct 2026 22:46:14 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hk010nkxa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Oct 2026 22:46:14 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69SMkC4u14942786
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Oct 2026 22:46:13 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C896C5805A;
 Wed, 28 Oct 2026 22:46:12 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 218C758051;
 Wed, 28 Oct 2026 22:46:12 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.241.44])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 28 Oct 2026 22:46:12 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
 cohuck@redhat.com, oelghoul@linux.ibm.com, qemu-stable@nongnu.org
Subject: [PATCH v3 1/2] s390x/pci: Free FMB timer on zPCI device unplug
Date: Wed, 28 Oct 2026 15:46:10 -0700
Message-ID: <20261028224611.240515-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZYOIpcVA c=1 sm=1 tr=0 ts=6ae27b37 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=Tz34pzjBhllYYjUU3tcA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA5MCBTYWx0ZWRfX4IY0mPMgOcLc
 lQOVmsQrfU+vvEJL4eFbAnjgfZafYUGjnsax1686mLI8MpYyoNNLPjFGGKNf9ggCMia6BboS1vJ
 IIiyZzYgoHmglwC0vMg9CPL8m93T4wcM14uRhEl2GBIyndGYKE/KSAfJTf9g/QlKERTTfkIVKwF
 ht5MFOBFgicHspJKPxX0C6esuZm6xOFavSTD4vJrViRu69QR7yaMLAoon2YaraCyQa4opZL/IE+
 4z/3BaLPiFIsmiv15Yr/NEwBjf7gFe80cLzPGn87wX8m5FmGrDaxvYxBDvPptj8SpKjAj/pXEZF
 Tsg+DR5If75VlZuz6XIfHPPj4Kha/d59Mc7lvPLoZ3c2snVlEP5MHZ5LbefdYEaS6OL9TlTkiUW
 K+m4HGT5GcPgJX8dnJfVV6O6j7iyGcWEDD3rghCea9wRqY3Wwn3agJim8ptVnU1t1/He4U9xINO
 eOkZWJ5j/KGifCHJ4nQ==
X-Proofpoint-GUID: viSBB8q0OIn6mrl8vp-1Ia9Uvtz3K5Wu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA5MCBTYWx0ZWRfXxbIIMQrjxqnN
 I4Y2SQI8QDtf7KBffkgwfnuZAHX9uACApiA4piWbltcz9a1etzMtIs6ONc+lPKQMeK6r2UmP7YT
 AyV5l/gERAjK/5ioNpD7cZL18ukFOoo=
X-Proofpoint-ORIG-GUID: viSBB8q0OIn6mrl8vp-1Ia9Uvtz3K5Wu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280090
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On an SCLP deconfigure we don't clean up the FMB timer. If there is a
pending unplug request then we can destroy the S390PCIBusDevice object
without correctly cleaning up the timer. So fmb_update() will then run on
freed memory. Clean up the FMB timer before we destroy the S390PCIBusDevice
object to prevent this use after free.

When FMB was introduced with commit 6e92c70c37 ("s390x/pci: add common
function measurement block") we originally cleaned up the FMB timer in
s390_pcihost_unplug(). This behavior was changed in the re-work done with
commit e0998fe89104 ("s390x/pci: Introduce unplug requests and split unplug
handler").

Fixes: e0998fe89104 ("s390x/pci: Introduce unplug requests and split unplug handler")
Cc: qemu-stable@nongnu.org
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index cdd75cdfd2..32f78a1f21 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1400,6 +1400,7 @@ static void s390_pcihost_unplug(const HotplugHandler *hotplug_dev, DeviceState *
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
         pbdev = S390_PCI_DEVICE(dev);
         pbdev->fid = 0;
+        fmb_timer_free(pbdev);
         QTAILQ_REMOVE(&s->zpci_devs, pbdev, link);
         g_hash_table_remove(s->zpci_table, &pbdev->idx);
         if (pbdev->dma_limit) {
-- 
2.43.0


