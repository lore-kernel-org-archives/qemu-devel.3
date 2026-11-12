Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC63460A3831
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JTbuUst0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRXwd-00012D-7g; Thu, 12 Nov 2026 11:46:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1xRXwY-0000p1-Ie; Thu, 12 Nov 2026 11:46:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1xRXwW-0008Oz-VU; Thu, 12 Nov 2026 11:46:34 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACFiE5Q246875; Thu, 12 Nov 2026 16:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=vdletRs9l8p0diLWJra+Unm+T9hDUpwt37e2QXGZs
 Xc=; b=JTbuUst07QtBYtEMFPFpk5vpNDo9s4l9yws6SAhraGMUioaASSZGZPDzi
 QUO8HxoQMNYgqbO/TalFIYYc82tV5scVg99sNHEJLVGES0sLUPF3SRutqVws3d8O
 nu3okFjig3waBY0kBNkIqsq+P0vzhH237SsDNSTLyPnory/rkX9/eRQuU5e6kgFE
 EQVHgzOQq8S44iLdwrFoFBPJi2jzHqEMz8enb1/eriTD0Uf7wPg4OgWsEQV34I8Q
 s3yDADUNegHTDu/BCyMv5xmr7xocx5HRpFEu06EMD5ujAftMuJ7Tkb4JTR5fEoil
 b/c3WDqW8BykUwJgf27Xr2Zj0NIPw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumv79t7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 12 Nov 2026 16:46:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACFc3SJ863557; Thu, 12 Nov 2026 16:46:27 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hwegf8mdw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Nov 2026 16:46:27 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6ACGkNLA47841716
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Nov 2026 16:46:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1A84E2004B;
 Thu, 12 Nov 2026 16:46:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 468FF20043;
 Thu, 12 Nov 2026 16:46:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.17.46])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Nov 2026 16:46:21 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>
Subject: [PATCH 0/2] MAINTAINERS: PPC/sPAPR maintenance updates
Date: Thu, 12 Nov 2026 22:16:15 +0530
Message-ID: <20261112164617.85849-1-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA2NiBTYWx0ZWRfX0iLzv3qEfb8L
 N2ZQRnmfMf3b1CvaCXfBgFSEAB0AbDTVfeMFhtN7D5kUCU9mYipZN8G5feylhj+W73l3MFrZlW8
 y64Uotm9P8brNumkM1Z3wd/an9eUDEc=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af5ed64 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VN0z8MIy2WJPKx8koVsA:9
X-Proofpoint-GUID: _NZrh2X1MdH0JXBCZRRWwi-xEx6AmbHI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA2NiBTYWx0ZWRfX68HyZrc5+mB2
 fT7438RxlvBTps3RaoRMXkYoZoYRyaxOI1biwicpEXQ/52MiWEl4KGau7Wy/ygidOpw4sttjS35
 nbUwefl5Juzqida826K5ehNAAK6GrtWBhFuV09KYzrFRo8EcD34QTM/BmADu7DToePgqDiIJkXA
 z0Q9lGQD0POGJDSmZCxLUR4LJNKBDh/2uT20fQ000baaZDzPU/r6nO51rjchQGZnxBwC7cBbFRx
 GYGL06UGKAFjrc+gLzm2e7w50i3TeM144JnlAyexz1OTy5x6qPdJHz/8PI5u8JJyOzySmgZdYGg
 7wIUx6cWz1DpXZXf2LaVahAT9s4EUSfsg9JTOgmpG9bsprAytNXulYkrZx7MLDkdhDNGgnW37E/
 uinY+LBZkSHa6ep9e97BoeVD5n4geJAf9EdKX2uHwjMbylfHUqOjMt10dYesNyUK5slOVJp8gHE
 uKit/s+ziF12rhr0RiQ==
X-Proofpoint-ORIG-GUID: KU_ZwekCtxC4c9EME9TY697hKitUw8TY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120066
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series updates the MAINTAINERS file for two PPC-related subsections:

- PPC KVM CPUs: add myself as Maintainer and update status from
  "Odd Fixes" to "Maintained".
- sPAPR: update status from "Odd Fixes" to "Maintained" to reflect
  active maintenance by the existing maintainers.

Amit Machhiwal (2):
  MAINTAINERS: Step up as maintainer for PPC KVM CPUs
  MAINTAINERS: update sPAPR status to Maintained

 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)


base-commit: 29760efaf96bbe5928f8111881eddbf5ac06439e
-- 
2.54.0 (Apple Git-157)


