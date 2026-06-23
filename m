Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2BA9CDB466
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 00:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbpT8-00073m-8X; Mon, 22 Jun 2026 20:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wbpT6-000734-B8
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 20:58:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1wbpT3-0000G8-5N
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 20:58:24 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MEKErA1791739; Tue, 23 Jun 2026 00:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=XreeUoytPfkpnSmXyfXbAmA4vbdBi
 6fuS4JA3Mq5uyY=; b=h5CACUJI1CS5yqn5GBptYjhBBlgkAABrMt8sc160WEAKd
 gihmor/I7fsEsG49UjoTJ3zQD9bAIpmzM+7iFJAYcsX7pN7MhA7wW/QUdhWXWq5W
 6spiikaZtyUhh3mLk58xVSMueCr4bqkUBSWCfsjGY4aVYr9jPe13cTtyZHsLQjgi
 +LgXoU28v4l0cG1vaLU2zTLTWeictUNTGOnqtT11/0wsx1Ll+Rlj54sUnK+ZkPhr
 7WdOY1t7GYYIa6Ymx2tv4E+EyQTkWXKQzEyqdO+0NbfaVW1obe+Uo0IMhrd+nxrK
 5cDlGQxoEDts4IXRXZ2PNkKPGNdpHtlhFR+SSAVKQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewke5jwjf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 00:58:15 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 65N0w88X019658; Tue, 23 Jun 2026 00:58:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4ewhabf3t7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 00:58:14 +0000 (GMT)
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65N0wE2d020136;
 Tue, 23 Jun 2026 00:58:14 GMT
Received: from alaljime-e5-test-20240903-1847.osdevelopmeniad.oraclevcn.com
 (alaljime-e5-test-20240903-1847.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.250.206])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4ewhabf3sw-1; Tue, 23 Jun 2026 00:58:14 +0000 (GMT)
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, mst@redhat.com, sarunkod@amd.com,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 alejandro.j.jimenez@oracle.com
Subject: [PATCH 0/2] amd_iommu: Fix Coverity issues from 11.1 pull request
Date: Tue, 23 Jun 2026 00:58:11 +0000
Message-ID: <20260623005813.984238-1-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 malwarescore=0 mlxlogscore=653 adultscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2606230005
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAwNSBTYWx0ZWRfX21nZSYLwQmTX
 +7mUsofXR4goMsVOd5oZUcumE2VlNFdmJoSa9yRLUSwHfOoXfbZbMbFk1UKo2WGT3jThS09l2MT
 6nhKHlaLgTauLDMaYrVe1we8b6UK3wVJD0/A9vIfZNxwBnZyx89h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAwNSBTYWx0ZWRfX/NOcZ9yexLgy
 udeykVgiZluyFSNeVYBK8fXMcQ2NfCX/dMPbYbCBkX7WFiRKkL6X/EtQMdDO6N3s2qw1N64JHpl
 D9XIZbnJHvSykGAv8ONpnA5skdFmztuD2yYBmHNaQAWjpmdOd8pZxYrSsbnCfV3e9bVaYyxhpHz
 fSA+qGOSnAwjDwuwq453UFMolhb45ZRcEINPkVSlsFXCnw8rTzWhSZIWbmXA+ahluu5pQA535GA
 MChEMVqNjpOCMSnBV7HHCauSiOEObWZqmkhlMnFPlhR0uw4wD0shpR12y89bHOIAwHhTxHvJXwG
 r6YEKodqrjWXFndgdzG1NnAaTQLdQ8aO0TurHqXts5geIhOQosLv2/WWsJAxNlLSDFI0jc/fB/X
 cBGplAv1/m8cbOXFB/UyQ7HJqIwkXFxVEjrPxHP8DWQZ65mxOmUWIro25KAt0CPGZm3slcdqd3/
 nn8SjOgcwoSBczpMY8w==
X-Authority-Analysis: v=2.4 cv=U/+iy+ru c=1 sm=1 tr=0 ts=6a39da27 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=BbWnIvWU4SKvxoNSRo0A:9
X-Proofpoint-GUID: FvowwKaD1AoF02Av9KH0tKQ0KOUljEQ-
X-Proofpoint-ORIG-GUID: FvowwKaD1AoF02Av9KH0tKQ0KOUljEQ-
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Address two Coverity issues reported during scan/review of changes included in
the recent pull request:
https://lore.kernel.org/all/cover.1781463125.git.mst@redhat.com/

- Fix return types of page walk helpers so they return int type status values.
- Fully initialize a local X86IOMMUIrq structure used when building MSI messages
in the XT enabled case, avoiding later use of an uninitialized field.

A larger fix for the bitfield and host endianness correctness issue Peter
Maydell pointed out will be sent separately.

Thank you,

Alejandro

Alejandro Jimenez (2):
  amd_iommu: Return int from page walk status helpers
  amd_iommu: Fully initialize XT interrupt message state

 hw/i386/amd_iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)


base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
-- 
2.47.3


