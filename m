Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9208E606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=U9KK1aDv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU0NZ-0004OF-O3; Thu, 19 Nov 2026 06:32:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xU0NX-0004NI-EY
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:32:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xU0NV-0000G9-Sf
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:32:35 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJAuLDr3945589
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:32:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Q9gwTWu90K++wXQPk
 oFcvN/obe3G/nXvF/3SAuxCI4M=; b=U9KK1aDvzRpyKQd5EJ5Wg4XSlpOt8iiDp
 4K/PI1m2Nlq9//oJZwyF2AR8epj7Gc5xp5XHTqDaKUhJCaUwsMdOEX4QJCKDnJXg
 xV9ANCRWyRU1WilhxN1qsZQIIQ9Ncet5KTRvDfPRS6O1is2JXAxKTw9LGZ8tGgEX
 pKtg8mdcGQCLCJbCTv0ShU6TsJYrveIj6wvdaTrPQ3c/myCe5TrRZKYTxKtByKSt
 E0JXxkakpMiufD3wZPdvt51ywUBC2RSdJR4H7JEYoYUBg14rSSwLkGRXJ/AVCFh9
 ULCI/fHQv8qMsB758k73Yh6ACk3Hh+Coc40YhYQLKW7SLuqge2r1g==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105t8my7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:32:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJB5Avm760829
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:32:31 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1hd6v095-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:32:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AJBWQN849349100
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Nov 2026 11:32:26 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9194D2004D;
 Thu, 19 Nov 2026 11:32:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC90420040;
 Thu, 19 Nov 2026 11:32:25 +0000 (GMT)
Received: from Mac.com (unknown [9.43.71.183])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Nov 2026 11:32:25 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: [PULL 4/6] MAINTAINERS: update sPAPR status to Maintained
Date: Thu, 19 Nov 2026 17:02:12 +0530
Message-ID: <20261119113207.79328-12-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261119113207.79328-8-harshpb@linux.ibm.com>
References: <20261119113207.79328-8-harshpb@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IouL47/g c=1 sm=1 tr=0 ts=6afede50 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=ycZxRjB8Pew_20M1M_IA:9
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: tSoq7FMWb9hkLEkCUXdT4_64yneEamZB
X-Proofpoint-GUID: tSoq7FMWb9hkLEkCUXdT4_64yneEamZB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0NSBTYWx0ZWRfX5M4GjzCFSAzq
 xVBsLhjci3IWJPrfLi7DSdoKQ87+OVDFrwtmCioS9wwl7Sf87kzjgR7GR85/MrUDhKU2ALGUHkF
 yIG6k+gEmK5JLfE79IghI/A56bQVXCFqqbmC0L+Nti3drbQcnWcmaznr/JGvvZ+zUH3q/XYujLO
 9ylx5y3khyqKVPNnAgecL+FqaDgWHEEdF2Pj5ZoEb3a9rPpV3ZedKICxB6BMkoRfLtTqayhFuLH
 nKRUsjAkgF6cwpxAKj0t9z98IlgVYMAjc8fYNGeFqpG6P4qOsN2OnD4H2smvM2SQ0ujYBqooNyI
 rn3KUzvZu55y9YHgCQ12dwI7xrCQxxQ9C7RTURb8njHLYj0w6cEXPQan6zVFGuBTXv7QWYzpjqB
 NrNlGoXXecqjm8JqBi5wOqao0sP3bRt9GpdaDANLN3JPBypT1ALGzG5PLpd2W8QIutQq6ECD+DI
 6IVUyuoc6+4SkeuLOfg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0NSBTYWx0ZWRfX00Rkudb4WxMh
 iyIQWa84MernRZEsJfgi1SwKuZ7bVvfLQ+SHtlftOVVxxl4zJDQ7nhGIsUwVxN2tJIV+cY/4NN1
 Lt8U+rQkvMu+dJ4Jv/4S7yaXYy13wsM=
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

From: Amit Machhiwal <amachhiw@linux.ibm.com>

Change the status of the sPAPR subsection from "Odd Fixes" to
"Maintained" to reflect active maintenance.

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20261112164617.85849-3-amachhiw@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0492190107..08d6f76e31 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1687,7 +1687,7 @@ M: Nicholas Piggin <npiggin@gmail.com>
 M: Harsh Prateek Bora <harshpb@linux.ibm.com>
 R: Amit Machhiwal <amachhiw@linux.ibm.com>
 L: qemu-ppc@nongnu.org
-S: Odd Fixes
+S: Maintained
 F: hw/*/spapr*
 F: include/hw/*/spapr*
 F: hw/*/xics*
-- 
2.52.0


