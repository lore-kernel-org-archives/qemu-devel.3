Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25982606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 09:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=e9GE7O2D
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRR6k-0004bn-H3; Thu, 12 Nov 2026 04:28:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xRR6a-0004bC-4W; Thu, 12 Nov 2026 04:28:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xRR6Y-00076H-A8; Thu, 12 Nov 2026 04:28:27 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC2iEou2795609; Thu, 12 Nov 2026 09:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=RJ9FyRZYNMwk6AGkCk65y3t2rB1JDHkNmXSoA5KeN
 TU=; b=e9GE7O2DfTAS8JR8zx4ZgU6Ni1vtyz8Ttjx8MIbshB5vYPCWSlcPWPHV5
 Ejd6Jt3/eNbiQO138IcU/LvoShD/5v1qVBfWQCrUX1xb0fIqnWMKCva/bc3YLm/E
 5Sbl5O3jNb8PTMJ6hfdrsP2vrWCnG4QnVo0jqChbLdr2X1VN3Ie1PDGFpEBhRXaq
 Z5uYUPWlxo4isVegmLUEl5Px8E/AVKvJmTvkYVRIyqRUasO/h192rDYMDaTAn37E
 mb1gVLmj2TQ8yZFWjQf3CIdffaafSmkwb4v4beI6WRd0/TwkKrmwhlXxgQZ+IyAl
 9lX8DF8AgDasYlVgAh2uesR5V8Riw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdkxah8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 12 Nov 2026 09:28:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC87Uap016704; Thu, 12 Nov 2026 09:28:01 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hv33286ay-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Nov 2026 09:28:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AC9Rvc234275742
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Nov 2026 09:27:57 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D0F222004B;
 Thu, 12 Nov 2026 09:27:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D5AC20040;
 Thu, 12 Nov 2026 09:27:56 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.ibm.com (unknown
 [9.111.49.39]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Nov 2026 09:27:56 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH] MAINTAINERS: Mark PPC TCG CPUs as Maintained
Date: Thu, 12 Nov 2026 14:57:50 +0530
Message-ID: <20261112092750.1821470-1-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af586a2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8
 a=FKWBkMMXygv0giUxoRoA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAzNiBTYWx0ZWRfX1myJvFfXb5pE
 cafc53ACoOv9B+NLeX8baXPCWyMLocpk9BO0HiPolqbaGQQtoUKbgTKX9xbStAOS3nCogoQz0BL
 shUP/gjimQ73fUKVWz34uwOuI1ld+4KC6kA74FvvyziJEv57qOVtPwmVQiK5Vc4zptVHilDUpAP
 qk8a6JUCkpdAQPHit1/drpMRbfbRpVdt8mC71etRb8H31Xpc45LTUygLsTGqxwdJM9ot9Y16ceC
 wcCmkhCYa4pHdXWXgZIMKt2EN68jiKep4HAFmVKzJg1NRxsUTsTYf8fXz8aHnm14zXb7soTK821
 3/k2X7BmZOVJQfiQQV7+Jpo3PEFsn80EELc0XG1e963M+mD5u5e8FlZYDXAe9pKAuMnWXv/Ni5n
 nh2Zvlpj4RpMLqMMvez7H9SQgClCFRsYd76gBYZl1KVrB6f58oppxnkArFe3YLf+qKSXt4+TEct
 1ve+w4UP8eh/tWcXotA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAzNiBTYWx0ZWRfX0ItyxrVfu+sP
 apV/8pe/trpW0WoFx8MDdSLdHrf+CEdfbDtbGuKn1mnlw3Hofv5bIVeLI4mlOydqpChSg5ekI79
 rh0AdQA9ZRapzLYIL02BKCdDR/b7xYc=
X-Proofpoint-ORIG-GUID: gqCleZGTk12agAFwfqruB-M5lF--PgOq
X-Proofpoint-GUID: 8RH_pKd9jQFZHfd4OMjJuE3M-5_jryNY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120036
Received-SPF: pass client-ip=148.163.158.5; envelope-from=rathc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Update the status of PowerPC TCG CPUs from "Odd Fixes" to "Maintained"
to reflect their active maintenance.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fa0c6d0c9b..d268243fdb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -348,7 +348,7 @@ M: Nicholas Piggin <npiggin@gmail.com>
 R: Glenn Miles <milesg@linux.ibm.com>
 R: Harsh Prateek Bora <harshpb@linux.ibm.com>
 L: qemu-ppc@nongnu.org
-S: Odd Fixes
+S: Maintained
 F: target/ppc/
 F: hw/ppc/ppc.c
 F: hw/ppc/ppc_booke.c
-- 
2.55.0


