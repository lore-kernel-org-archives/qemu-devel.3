Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458EB606A31F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hizLTKBu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJy01-0005qD-7k; Thu, 22 Oct 2026 14:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1xJxzq-0005ih-Vu; Thu, 22 Oct 2026 14:58:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1xJxzp-0006J5-8j; Thu, 22 Oct 2026 14:58:38 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIE3Fp747240; Thu, 22 Oct 2026 18:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=11cjQ5MNVoIecvR08hkUE/DBk0coGl1ZLZkhTUBrO
 p0=; b=hizLTKBuMf2yrAcRXRw3iZ7hawJVTp54ADj2sqi1nEx+rjZX0FwLFG4TE
 tALWlCKnoVq0jhM5kuBSDMsy2R0sfBA3mPetKXEisIrNgUrzCV/d2wI3ug2OiX0L
 ZMoFYr3GC0k3zjJFoA74yBdKlPOqLHQfzPYroM2qWVIWlTdQy/MWICXG6dWsFcuQ
 SJkmhKHwSgNn/aHeisZmqCInKYn+v2Q1LOSAZnsuEi5Oy8WMr2nz/hseVLZIQW/w
 muNB+oEeG6446k6/4L7c64tRjbIKq8s9EQ0n/aitf/CQLxnqorNAKsttS2GIePjW
 cwzaM9XN/Wv7rW1KWLOjNAyMLjZ6Q==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5910ar-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 22 Oct 2026 18:58:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MI55Nq921301; Thu, 22 Oct 2026 18:58:32 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hfgck1xnf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Oct 2026 18:58:32 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69MIwVgG51773754
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Oct 2026 18:58:31 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2FCB658056;
 Thu, 22 Oct 2026 18:58:31 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 87CD358052;
 Thu, 22 Oct 2026 18:58:30 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.249.57])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 22 Oct 2026 18:58:30 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: alifm@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
 cohuck@redhat.com, oelghoul@linux.ibm.com, qemu-stable@nongnu.org
Subject: [PATCH v1] s390/pci: Reset device before tearing down IOMMU mappings
Date: Thu, 22 Oct 2026 11:58:29 -0700
Message-ID: <20261022185829.11835-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8-xxnteBIW2m8YErC6iNdh-YoBRW5HqQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA3NCBTYWx0ZWRfX7bHCu+9AGydE
 LIIeV5hlajieMJdUQvtXCjresFVAjMFFEEzRZRq58piqV0366hvmgFbhdU68JofBnCRLY//kVKK
 D4fKPq4xQFjjSd8yVPxhiaOI0PSOGpY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA3NCBTYWx0ZWRfX3cRp6rgNTw7u
 bYAKjdYDoHypmh1pgP0G5Mi56mszP1ezNQGtDGOmE6Li9kd+ykYaQCyN+lCJggZ+ZApN+ghsYg/
 nhNMot2CY2qMf7an3y3tIbtvmPLMbRlVkg+rGa3dRnvnCCRFjBmRAQSLhAuY9S/UA11m0yUo2eQ
 zzSbRFqw2yhioOl+92okZk068JZItVCVSA1tNsbPNlWFNQhXMTQbDHLWg2yuNCI33yEl5cH5Q6f
 sUBkOtUD488mbP0elgMGQbVl8e6t/ird8inoIO7AfQAox6aQPjsdZ40GJQupDZa+ZvQcIbZQZ1q
 EnDSLh9CSmvmlnyiqrhMCr6aOwOHeKimwF/psB2ZA9tnCT/j8DRq7Ti0M2yeieVOrDm3/DkSE/M
 NessNrYzOhs1ywz+RYFj06SCgVZSTP5ZnyIgmu5ku0c/Xj4Dd5541r2rW8Cf9lcEQrbIiSxzxP+
 u+gTjb3nAKviISaGYmA==
X-Proofpoint-ORIG-GUID: 8-xxnteBIW2m8YErC6iNdh-YoBRW5HqQ
X-Authority-Analysis: v=2.4 cv=Ob4NnRTY c=1 sm=1 tr=0 ts=6ada5cd9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=7fL7QKSG5HQNWf0BWnYA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220074
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

In s390_pci_device_reset(), IOMMU mappings are torn down without first
resetting the device. For a PCI passthrough device this opens a window
where the device may issue DMA to addresses that no longer have valid IOMMU
mappings, causing an error (PEC 0x7) for the device on the host.

Fix this by calling pci_device_reset() before tearing down IOMMU mappings
in the default case.  The dedicated ERROR-state case existed to issue
that same reset before falling through, so it can now be removed.

Fixes: 3e5cfba3ca0a ("s390x/pci: introduce S390PCIBusDevice qdev")
Cc: qemu-stable@nongnu.org
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 2724b27ec2..7182d97a33 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1786,22 +1786,8 @@ static void s390_pci_device_reset(DeviceState *dev)
         return;
     case ZPCI_FS_STANDBY:
         break;
-    case ZPCI_FS_ERROR:
-        /*
-         * Attempt a reset to recover the device. A device in ERROR state
-         * can be transitioned to ENABLED or DISABLED state via guest
-         * driven actions.  Since this code path is also executed on
-         * subsystem_reset() and the expected state of a configured device
-         * after subsystem_reset() is to be in a DISABLED state, we need to
-         * transition from ERROR to DISABLED.
-         *
-         * Linux guests drive the state transition from ERROR to DISABLED
-         * via CLP_SET_DISABLE_PCI_FN. So it should be safe to transition
-         * from ERROR to DISABLED state.
-         */
-        pci_device_reset(pbdev->pdev);
-        /* fallthrough */
     default:
+        pci_device_reset(pbdev->pdev);
         pbdev->fh &= ~FH_MASK_ENABLE;
         pbdev->state = ZPCI_FS_DISABLED;
         break;
-- 
2.43.0


