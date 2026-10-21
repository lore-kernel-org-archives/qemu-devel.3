Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF580606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QpRsLsXk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJaSt-0000HR-9T; Wed, 21 Oct 2026 13:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oelghoul@linux.ibm.com>)
 id 1xJaSr-0000Gn-7u; Wed, 21 Oct 2026 13:51:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <oelghoul@linux.ibm.com>)
 id 1xJaSp-0005yv-AU; Wed, 21 Oct 2026 13:51:00 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LFi0Cj1700657; Wed, 21 Oct 2026 17:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=xc3Jv4amcLQ0Dd7a/65HCcyf8ZmkPeK4/PFVyR8d4
 fY=; b=QpRsLsXkBoqB1DEOo0sI/xea6D6Hr4qCXHUotDuP0LgkHha8X533zKLYI
 NcyRuiV9eHmlIoI3QBkhjkmxWpze9iDBFYzGpXNoOPpvFBvQphSLqjiVr3l5Gakz
 HfSVYCog/GiuauBvjtiUk5dFxrurCOqL0s2nL/hvUC6fDEfAwuauWKTYAC3d28YC
 Zo9B4Hy4u66Ov7aV9jPMbcaK3xGlTfPi2xmcWoD5MGld1JHFh33yZEI51X5sQ149
 yPB7kL6M9MbqK2ao2SyU5Z58py0fSL0/pblMuPiwtC0ppoWMs5xfq6VgNMUCOdB7
 Lid2mLnpKCH2hAgGp0214YVF7IeHA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw58tpca-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 21 Oct 2026 17:50:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LHopQ63413130; Wed, 21 Oct 2026 17:50:51 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4he7bs6e1c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Oct 2026 17:50:51 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69LHomoG26280562
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Oct 2026 17:50:48 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 04D9058056;
 Wed, 21 Oct 2026 17:50:48 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E307D5805F;
 Wed, 21 Oct 2026 17:50:46 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.252.137])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 21 Oct 2026 17:50:46 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: mjrosato@linux.ibm.com, alifm@linux.ibm.com, cam@linux.ibm.com,
 farman@linux.ibm.com, qemu-stable@nongnu.org
Subject: [PATCH v1] s390x/pci: reclaim DMA slots upon IOMMU disable
Date: Wed, 21 Oct 2026 13:50:31 -0400
Message-ID: <20261021175031.23840-1-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4yPP_AftCuVHE2Vzv8r3dcT3iDIVk0q7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MCBTYWx0ZWRfX9aBLPQlW7IJW
 i/d7Mk6KPoMOk2Y8rYHfJlOvWClIjNJZjXYHl1L4A0qGy3uSyMXWK1y3rUQG4LnJqPMOeO7acgx
 vEnEO+lqBgQ+sltGbxLrmQoYopVt8kE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MCBTYWx0ZWRfXwBUz1yqqrCEv
 tU1Zy/NKjMH38xCKlzUNagolmaHxVVLXrgXsl2CCgS2jMA9+idSRLALACmsxrFtlD3vW8S22Fza
 Zav2eDMBitAe7ay9FhB9XmQ7BuOPgjYE5eaGufABMuGxIyTXra0lSyCVptzgh3V5MX9wVI2UsoX
 A9REmunpqCI3CA9NGi1lSdiQTRRzZ2Yz5rb0ujXDlE3ptXlXxno3rhkuh1IBtzYuyq8GGySQewE
 nUdwXUg0x2p+jHjqABEEWbvfcROaLIB4biOrxAOeEeOoS29SAf2Y5gM7A+SDW4Cnp9S6izjHSLO
 PvjWLKoCf+PSh+nNZiS7Ke50M35+FiBKYCIDbzUGOvRSEc46rU4E+OuF9U0XsaTJmo2jQV6V/se
 P99eCerq9lqeVEUmzL9Jz/9YfoX1lGAW3nvSsHQxNgGAdf/87clq68cvuQmo2Lfw4bKlKDpQoL3
 SMYQWi67Y46XUjwmGxQ==
X-Proofpoint-ORIG-GUID: 4yPP_AftCuVHE2Vzv8r3dcT3iDIVk0q7
X-Authority-Analysis: v=2.4 cv=Ob4NnRTY c=1 sm=1 tr=0 ts=6ad8fb7c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=69wJf7TsAAAA:8 a=VnNF1IyMAAAA:8
 a=eA_zop4iBRkCFdGO_iEA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210070
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

s390_pci_iommu_disable() destroys the I/O TLB and unpins the host's
mappings, but it doesn't account for reclaiming the freed DMA slots.
This is problematic when an IOMMU is disabled and re-enabled while
reusing the container (e.g. during a guest reboot), which may cause the
RPCIT path to fail with DMA slots exhaustion errors, manifesting as
unexplained ENOMEMs in the guest.

Fix it by reclaiming all the entries in the I/O TLB's hash table before
removing all its entries. The actual DMA slots consumed by the IOMMU are
already relinquished to vfio when the memory subregion is deleted in the
same function.

Cc: qemu-stable@nongnu.org
Fixes: 37fa32de7073 ("s390x/pci: Honor DMA limits set by vfio")
Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 2724b27ec2..cdd75cdfd2 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -826,6 +826,14 @@ void s390_pci_iommu_disable(S390PCIBusDevice *pbdev)
 {
     S390PCIIOMMU *iommu = pbdev->iommu;
     pbdev->iommu_enabled = false;
+    if (pbdev->dma_limit) {
+        /*
+         * Account for all the DMA mappings still in the IOTLB; they will be
+         * returned to vfio when we delete the memory subregion via
+         * memory_region_del_subregion() below.
+         */
+        pbdev->dma_limit->avail += g_hash_table_size(pbdev->iotlb);
+    }
     g_hash_table_remove_all(pbdev->iotlb);
     if (pbdev->dm_mr) {
         memory_region_del_subregion(&iommu->mr, pbdev->dm_mr);
-- 
2.56.0


