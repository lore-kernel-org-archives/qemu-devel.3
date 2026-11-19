Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F59F606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PiVriq0T
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU0NU-0004M6-Lz; Thu, 19 Nov 2026 06:32:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xU0NT-0004Lq-TA
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:32:31 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xU0NS-0000FL-BN
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:32:31 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJAunfn3946020
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=2Twf17W69lnwVJov9
 S5Pcclz9kasYd0UmyQgqNffHt0=; b=PiVriq0T/SJgP3LAepaANYdRX8QvqWIwh
 JS0GW8+jgxDaakzEkoStbqPjbSoiYrTA85ckY4lBxXEj/qMpjrb9VA0c7tp+lA3j
 IQNAblY69I3+JvGvpEom7VCJTI16Bmg6kxxIEPRXRr1k9cMywQV/WDx6JoLBhOCN
 WQjEmiapkTFcS3DLqshsSlAWIrfCAvJOMPzpkv0tl4L4+315rmMe9zOwRWUO71++
 or3Yf2unKMWQ/ir+s4Z2qqFkwQzaoBvN4gQiEigibRd8JO0yFOz2uslIzx9ew2vb
 YpCbM3mL2GQslGcxI2IZM3u3KsZpdPs7LcTkoi8xjlhsydwc2w1RQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105t8my0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:32:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJB5Aph3540687
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:32:27 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j17c4x2fe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:32:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AJBWOhe37486914
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Nov 2026 11:32:24 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C0B02004D;
 Thu, 19 Nov 2026 11:32:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2476320040;
 Thu, 19 Nov 2026 11:32:23 +0000 (GMT)
Received: from Mac.com (unknown [9.43.71.183])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Nov 2026 11:32:22 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>
Subject: [PULL 2/6] MAINTAINERS: Mark PPC TCG CPUs as Maintained
Date: Thu, 19 Nov 2026 17:02:10 +0530
Message-ID: <20261119113207.79328-10-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261119113207.79328-8-harshpb@linux.ibm.com>
References: <20261119113207.79328-8-harshpb@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IouL47/g c=1 sm=1 tr=0 ts=6afede4c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8 a=FKWBkMMXygv0giUxoRoA:9
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: ghQ__pz9vtDMrm4ZeB_qqYqF6P0wFlpR
X-Proofpoint-GUID: ghQ__pz9vtDMrm4ZeB_qqYqF6P0wFlpR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0NSBTYWx0ZWRfX6XSmNHc5Lnyx
 tRxBNs49gsaPJ9qIL7ACgmHxaLmJsrkQ0Ic5BVlNPJRXbeN59bD5fdDCqgHyyZ17kibSorqFIOP
 heLJU2tJJy5e8DyV3SbOQpj/i8eZhyhUIei4fGzvItkV7j+FL3aftDaWQgSLLon5o+HHKizmYmK
 ZyVme4SuJFjJ58mfUbs2b7PYRPA2FrGjSauXjiearfuL+5qJU+QyVLH6G7mbm0AIybdYPzrDUhP
 0DQS73qewF6B3bpswyPOjvjC1mQlrfCsgIrTBoX/8WoWp71dWNn24+CZTIusPuunzYhYTYcbDgi
 u9p9jkeRA5WXki4cVgXbBY9Fca2TU1P1uhYxrgLFgWsdH7fz+Cmzy37CkWSsFreE0s3VGZQiw5O
 jzhp2V6mSuAAGdefLrkoSThHYCQFGSMzIGzyZruXViiLm6lw/o74lg9FVmza3YMIu1eDOIc30DI
 SGflIHbJpomaSrJi+Tw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0NSBTYWx0ZWRfX+4KXblM0z1d4
 5br1qzY8R1Y6nJ9YdNw2q/bXwNDM/WrTk/lbswMHMKWStUv/La6FxK7SqJhxlyG9jHAifPACn+Y
 jJcwApooyhlHdtmI0J3mZ607mqF0hvM=
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

From: Chinmay Rath <rathc@linux.ibm.com>

Update the status of PowerPC TCG CPUs from "Odd Fixes" to "Maintained"
to reflect their active maintenance.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20261112092750.1821470-1-rathc@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 15942aaba3..dcfdecedcf 100644
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
2.52.0


