Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C574D606A33B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WpaAuUkz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRXwe-00012X-01; Thu, 12 Nov 2026 11:46:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1xRXwa-0000yM-JZ; Thu, 12 Nov 2026 11:46:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1xRXwY-0000G5-Q1; Thu, 12 Nov 2026 11:46:36 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACFi8KD441320; Thu, 12 Nov 2026 16:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=fGn71kND+IRfQKzcF
 ppOqIUT5i5MH0cUsytVDcmhzR4=; b=WpaAuUkzuAcRE28H0Cowd5IFruRXf5eYE
 0k+ZPX25czGTbmdkFkMe+XPG+1TkZt1hmvfx/RBH7s7AuFZxmDuxZicl42Aq3BZY
 lU/7K9aBoZ9319hGmaeVXi298tKJjn9nL9jVD78yYngBFX5aAbdaoWySgK78ODGu
 22F0aXVytPVMPgdurXVf4pFpZ643n12+jqub6dg4BkOGlCItQOhldZe/u/XR+3wi
 mCQscHTwSURJ6ut+Y1BIYZRDOYqdfqT3AxaK/nF39/vkwP+KmsLY1rumVz+mUvR6
 48pTEvYglRG0wRaQUlvfAqpmbM1tQ5i1EkRAd4ib3lne7s//cF7RQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug6gjjm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 12 Nov 2026 16:46:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACFr3uO952873; Thu, 12 Nov 2026 16:46:30 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hvkq0x3mj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Nov 2026 16:46:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6ACGkQW745744558
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Nov 2026 16:46:26 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BB5712004B;
 Thu, 12 Nov 2026 16:46:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E864720043;
 Thu, 12 Nov 2026 16:46:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.17.46])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Nov 2026 16:46:24 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>
Subject: [PATCH 1/2] MAINTAINERS: Step up as maintainer for PPC KVM CPUs
Date: Thu, 12 Nov 2026 22:16:16 +0530
Message-ID: <20261112164617.85849-2-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112164617.85849-1-amachhiw@linux.ibm.com>
References: <20261112164617.85849-1-amachhiw@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: hQhvVMrX0GjFK1OvjIYR2QMxpDyxT7TQ
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af5ed68 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=4VVcHpUFlTeZ-k0x__MA:9
X-Proofpoint-GUID: A_31g0v4v6qefC6mGFHhVUxbq44gNaqW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA2NiBTYWx0ZWRfX/aMaLtK+Uaq+
 kUr8pv93eVQ1nhBq/JyyotryHNh8ps6d54SXrMlt/2TTZtU/sxAKjJjltmJ7DzMXUxkeQ2YYdYr
 I2V5OE+7OoNjHfHM8wscXdB7mfT6uo1ZYj4uZrZHPrFEvlvlo5V1YqgUPpbaXmrgc0xeYn6s5e+
 lxShM6ATFxwj+n6PEkOsn//iCQd0iULD8P/e1cM6Q7MsdQFbHU4CmLApwx0yYhOyoFDJhp5EZGd
 0x/KaeIwl20lz/HUIXQUE1y7J5fEwDFBzDPKIpLXY+6RO4uPYKE5YqijSPbHSqyAbN1JPm+eaNL
 fxndGAYflOijha9tlKyZC4s3do9rxHKHxHiDT5HgodDJOCpbDrQSsqpedvYo/W+d7PKpz0cJZQl
 EG++0t3TE5FTkxBcf8KjgeuRy5QkVwPXUrwryXrWeHHJtm5FL1kaGPkulUE5ud+CFyJzSdEPZNX
 sEm4ztH/A8RoQZ555GQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA2NiBTYWx0ZWRfXy/DwCcgRTAO0
 JTFOopfGqwkHSW16ICqPguVty0UAq3SRtNJYOwnBed0Bsq7I8vwxsh+VLwn7ZMnw7z9tktHuZNW
 MB/R0BHVgdHsYyz5HMKP6Ot7RzwBNk8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120066
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Update entry for PPC KVM CPUs: move from Reviewer (R:) to Maintainer
(M:) and reflect the improved coverage by changing status from
"Odd Fixes" to "Maintained".

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fa0c6d0c9bc5..493be5d85be8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -515,9 +515,9 @@ F: tests/functional/aarch64/test_kvm.py
 
 PPC KVM CPUs
 M: Nicholas Piggin <npiggin@gmail.com>
+M: Amit Machhiwal <amachhiw@linux.ibm.com>
 R: Harsh Prateek Bora <harshpb@linux.ibm.com>
-R: Amit Machhiwal <amachhiw@linux.ibm.com>
-S: Odd Fixes
+S: Maintained
 F: target/ppc/kvm.c
 
 S390 KVM CPUs
-- 
2.54.0 (Apple Git-157)


