Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8A1606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ltazQKft
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU0Nb-0004P1-5o; Thu, 19 Nov 2026 06:32:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xU0NZ-0004OV-V1
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:32:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xU0NY-0000Gi-BP
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:32:37 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJAuJoX3945490
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=b7N9KZlGZBxrCzh0q
 BVCI+Gn3Ck/SV09nWb3ULMj0wY=; b=ltazQKftfGUVQDCsnqaCKB0+OY+BMCnZF
 ouIetgRfdp3JTpkSRfmc+caeZvrL39z+fpGK9YRLTNuT07RRBUL0JeKLqo2QdhDJ
 fp15hmmYZHcwVwizGl7VqWLzmSCg/u2V1JIKUm0c269owi+aXTn25ahlI70Uoq9O
 zyzBwL3dg88O9NOWytfZgkxbJ/3+0a9p5YwIFyfajpTSyXuHHiJPcwhz8Ebnb8+W
 gOtMITR4Uk2GzGVZze4nn1fYGSlR7FnLO5UigZim7dfV1h3FbloJokJwBsBGZLns
 9vjAgOihgKdHci/RduE54/ow4qtL+8xopeT8sHsG8xblloxmNr6uQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105t8myc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:32:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJBK4hC2866258
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:32:33 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hy2bvq7q7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:32:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AJBWTXZ46268828
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Nov 2026 11:32:29 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D9C52004D;
 Thu, 19 Nov 2026 11:32:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 61A5020040;
 Thu, 19 Nov 2026 11:32:28 +0000 (GMT)
Received: from Mac.com (unknown [9.43.71.183])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Nov 2026 11:32:28 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Gautam Menghani <gautam@linux.ibm.com>
Subject: [PULL 6/6] MAINTAINERS: Change XIVE status to Maintained,
 adding self as co-maintainer
Date: Thu, 19 Nov 2026 17:02:14 +0530
Message-ID: <20261119113207.79328-14-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261119113207.79328-8-harshpb@linux.ibm.com>
References: <20261119113207.79328-8-harshpb@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IouL47/g c=1 sm=1 tr=0 ts=6afede52 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=4VVcHpUFlTeZ-k0x__MA:9
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: H3qBDqncCbuP6kGstDLOs0kz7vpVfX22
X-Proofpoint-GUID: H3qBDqncCbuP6kGstDLOs0kz7vpVfX22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0NSBTYWx0ZWRfX7SSMBUBcGisb
 exs+Sn8H9sj9Sh18SXlhSXfmLxqh0T6/NaPdS/EPdM1LX61Lvr6bTDfxmjKt4d1xMbViCjbdhcj
 t50RmLziu3LmA4ob0oWK2o4NpJJ/GIUTzbCyG4x0gTykwU3G/b71lK+b7IBuOLYMkdjzx9xcR4z
 Rfio1GgT/ocXflBaQEYO9Hbm3eJJopJjhP0lZH7yoOBXkJFAR9CC6d2RPL7rk2Lc5nDUE+kbS2E
 NpK6J4Y7rk0IcUFxKYPI+p3z0s1gMI+IVrcM1HAMfrR1QkeikEv2vlFPdR7yYKnh1a0qm2+RMaF
 DT8GuRDpCG680T2erYCVhv9Eb8o2B6y6tv10O1ot4RrTSbpj9cHrm+qGcGZCbsev3ShMJMmQwXP
 Jv0ha+gOd5+mtQdxFdPB267MXYqOUJI9tR6+pkBKMF7zNhjo2rLVW0nlwQCMAPy518HKJ9izLRN
 41veJDYJCxOwZerYn2Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0NSBTYWx0ZWRfX+caLjYMzmb0n
 Q1LJtq4eIIXi8VGSEMhFwNDMiqIbX4oq1rq3O7oxeIykMoHdprUVUFLz4a+rrgn+6W/mloUqjBc
 52VEN0qaN9lIDorv9l/xjJVCymBOVyE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190045
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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

From: Gautam Menghani <gautam@linux.ibm.com>

Add self as XIVE co-maintainer and also update XIVE's status to 'Maintained'
to reflect the actual status.

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20261112074640.219753-1-gautam@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 05fe7d9fab..3a9b4d34a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3079,9 +3079,9 @@ F: tests/qtest/fw_cfg-test.c
 
 XIVE
 M: Glenn Miles <milesg@linux.ibm.com>
-R: Gautam Menghani <gautam@linux.ibm.com>
+M: Gautam Menghani <gautam@linux.ibm.com>
 L: qemu-ppc@nongnu.org
-S: Odd Fixes
+S: Maintained
 F: hw/*/*xive*
 F: include/hw/*/*xive*
 F: tests/qtest/*xive*
-- 
2.52.0


