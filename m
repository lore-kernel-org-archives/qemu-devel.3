Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABAB11258BE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 20:40:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0QLa-0006an-Mc; Wed, 11 Mar 2026 16:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1w0QLZ-0006ZZ-Ax
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 16:40:01 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1w0QLT-0002Ca-3j
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 16:39:59 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62BHHC4t3180830; Wed, 11 Mar 2026 20:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=CA5v9vLZjiT0ayZywSYRAfmwaRrr+
 A6UqbcoO6pMm2A=; b=UHgjTm9Qvi6tq50EZCih4L8KGsDqgO3tGvSOZISJgi0l5
 vSsBuVxjjGBRHUic28gI1C/oxMvTMb9jpZ/iHwZBqRYoj24rXIFuDvcLIn0oDNi3
 1Ckk3RMX4YJAMeydenYXj1DRE/YEE2v65nAVFBqlrX650/ZAyzBPcqMfXaM972rR
 iZ/x2Wcx628P1QlE2v0+be+6L+ed/PRfDOwA4VIbTJ7PGFQtfIJJZLGYKn6XDewa
 uJPc4+MiTOwRVjpEVjQnczcryOrVV/2/4OuhXWZdIpuUjlka+ZAUW06r2+EkAU5/
 HVUI0AbA0L6nIFQmzMXAfQqrRWKB+XpdjQ9Gx/1WQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cu4hcs8kg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Mar 2026 20:39:45 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62BIi7Z5014868; Wed, 11 Mar 2026 20:39:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4crafgakxk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Mar 2026 20:39:44 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62BKdiEb019039;
 Wed, 11 Mar 2026 20:39:44 GMT
Received: from alaljime-e5-test-20240903-1847.osdevelopmeniad.oraclevcn.com
 (alaljime-e5-test-20240903-1847.allregionaliads.osdevelopmeniad.oraclevcn.com
 [100.100.250.206])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4crafgakx4-1; Wed, 11 Mar 2026 20:39:44 +0000
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
To: qemu-devel@nongnu.org
Cc: sarunkod@amd.com, qemu@demindiro.com, mst@redhat.com,
 clement.mathieu--drif@eviden.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 boris.ostrovsky@oracle.com, alejandro.j.jimenez@oracle.com
Subject: [PATCH 0/2] amd_iommu: Fix page size reporting on hugepage mappings
Date: Wed, 11 Mar 2026 20:39:41 +0000
Message-ID: <20260311203943.2309841-1-alejandro.j.jimenez@oracle.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 phishscore=0
 mlxscore=0 spamscore=0 mlxlogscore=605 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603110175
X-Authority-Analysis: v=2.4 cv=T62BjvKQ c=1 sm=1 tr=0 ts=69b1d311 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=VwQbUJbxAAAA:8 a=RWxpEp7VAAAA:8
 a=cCOlWOJK-HxKuZH9cR0A:9 a=3unh6Pbajv6CBnL1DxgC:22 cc=ntf awl=host:12271
X-Proofpoint-GUID: hDzf93w9ptDOn7ZbEPvFsgtebqFUlBAB
X-Proofpoint-ORIG-GUID: hDzf93w9ptDOn7ZbEPvFsgtebqFUlBAB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDE3NSBTYWx0ZWRfXx/+ywt1MCTRq
 U9t3CGNaCyrYPS5KL8X+dBpu/XBluuueCet8hF4ISos3qtJZ4YiKH24GquQrtZ5RevlxNSrFkRa
 oGzKMBui9O+zqIyTyxgyFulYJ6AHfVHU9omEYp6tlQplidv7QD4c2P5M4lFiISRHTlckSaYqXx/
 suD1gjc8L3yL0+VK1iiU1RK63UQ0quPPNqqOGAvnXTja88gGLvQ5DyJ1VvvWCMEgDs919DRFgPt
 zGNudYT5ul/vpwsQAWhnhJ+IcZ9H/7dKomD4tzBbxS25153h3CCZ1Ia8iYHGCUBXQbwfW/nt1RG
 7wwdlQPuIOfxgJSqCzhagyYVaStzj/r+xYGpz1DSJ46JUvBO/2yddI2GX69aponFkC30bCWCTYa
 l/uw/7SpIMf2qHGDkHjpLnrLW0+h8a2r4bEW4usTbPtmT1YfdB9SiS4ubqNZKfhL2OxIaZkL3UB
 5qnAvUOhzCLBwV9BogINiJzMQwodN2H/VHTEcP3o=
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

An issue in the page walking code where hugepage mappings were reported as
4K pages in certain configurations was reported by David Hoppenbrouwers in:
https://lore.kernel.org/qemu-devel/20260225145831.28275-1-qemu@demindiro.com/

While the change proposed in that thread fixes that specific bug, there are
opportunities to simplify the algorithm by using a 1-based level accounting
(matching DTE[Mode] and PTE NextLevel semantics).

The second change enforces a rule from the AMD-Vi specification which
requires that NextLevel must be strictly lower than the current level to
guarantee that the page walk eventually completes.

These changes make the page walk logic easier to follow, keep page size
tracking aligned with the current page table level, and prevent invalid
guest tables from causing page walk loops.

For stable: Please pick both patches together, PATCH 2 can be squashed into
PATCH 1 for ease of backporting.

Thank you David and Sairaj for the detailed reporting/analysis of the
original issue and the proposed fixes.

Alejandro

Alejandro Jimenez (2):
  amd_iommu: Follow root pointer before page walk and use 1-based levels
  amd_iommu: Reject non-decreasing NextLevel in fetch_pte()

 hw/i386/amd_iommu.c | 136 +++++++++++++++++++++++++++++++-------------
 hw/i386/amd_iommu.h |  11 ++--
 2 files changed, 101 insertions(+), 46 deletions(-)


base-commit: 1fd5ff9d76d23ab23a68419cbc76d5ee33e8b455
-- 
2.47.3


