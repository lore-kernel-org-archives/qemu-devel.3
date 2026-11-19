Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8187606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S2WfhxuU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU0Nb-0004P4-PH; Thu, 19 Nov 2026 06:32:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xU0NY-0004Nu-8t
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:32:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xU0NW-0000GG-9Z
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:32:36 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJAuZEW2314853
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:32:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=yi0rU7ejQw+IC6Bct
 3hTKph0/iLgNRDLLksJKtRyqqc=; b=S2WfhxuUHp1fs8FXTA+MsB9BCIkPYoxBi
 K4MbUxAM7se43sU4c6s98HLHDWMJJBi40gUC7bxNQoJmrWp9dJqSzXWXijiDQvuq
 JSo339sTqukysyZM8cOGXEUiugI4YoC4b2e093OPopEZHotLs8H/sYyfPfVwGLxg
 w8qRaRoqu6pWUyWgZQ5LImrMIAJvdxJyQIyI2ZtW1HBWUylkMaAs7KyxOPeEv1zF
 Mf3gX2jsTD29YPTIp0NaABCCZWoL+fsPLr3kt9CgjFnSQNsIpT3RQOVgK8K267KS
 3s1WKn7VuQWnxnL0gmc0dKV9O5Tbuzs/I4IBwMAdVgwBv8uQGX1gQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105rrm4a-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:32:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJBK6UR2866295
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:32:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hy2bvq7q5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:32:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AJBWSKC55312756
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Nov 2026 11:32:28 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 03AEF2004D;
 Thu, 19 Nov 2026 11:32:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EBACF20040;
 Thu, 19 Nov 2026 11:32:26 +0000 (GMT)
Received: from Mac.com (unknown [9.43.71.183])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Nov 2026 11:32:26 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Aditya Gupta <adityag@linux.ibm.com>
Subject: [PULL 5/6] MAINTAINERS: Mark PowerNV as Maintained
Date: Thu, 19 Nov 2026 17:02:13 +0530
Message-ID: <20261119113207.79328-13-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261119113207.79328-8-harshpb@linux.ibm.com>
References: <20261119113207.79328-8-harshpb@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9osDJti8QnAG_aKwv7-HKRoEwwDvrLC_
X-Authority-Analysis: v=2.4 cv=e8uT2qp/ c=1 sm=1 tr=0 ts=6afede50 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=07iWv__Ekr5bW8habdcA:9
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0NSBTYWx0ZWRfX54fJqBLT23NE
 OfRF8C2GK0gDGVfsa1ovVYoszvAcKdo63gkm8t9jmHwj3c9OBpc2gLN/fh7G6mpfsPEVFwhuVpg
 hLcXKrlDaOuH9n3uYGHx/pJanQ4D/uY=
X-Proofpoint-ORIG-GUID: 9osDJti8QnAG_aKwv7-HKRoEwwDvrLC_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0NSBTYWx0ZWRfXyBPc6k4pkCzM
 nJbb1iEOTXb3ElWwo1hqq5G572y382e4Nr+ia0vxfz/V2xBjuGcF02O9hTpJG327RXrB7/aWTsn
 ZFfPoJh7+edQe+TMwMYg+8NRkgvYfbuiFWk7YC9pIP90ttSaJwrKfxq4p9OE6BsLclawTDPNZMP
 DV9St76TJzgHmMGmymPNny3boy2dlYfTyhWJaQERR4rfIKRhNTrPFQ54C3bR4uKr2EtII7vbG2+
 PCIZnRpJH1Q+YGkXpHAMCAaOhV/FAzhFGJHJ/zjQoBEYSoY7q9TmNVmuLBdZdOGGuRHbAGak0eV
 d3alxteCpKYaqPkqoVuaBDdAw6LXHlfrHrsiHuVkbit6NHGQR6LiL76Pp+uySeJg8hh1w1ymmH6
 3ap+Lstb1xoHpyQTgMpF3T2t1EfBdHUIL2MZgMe4ewiqvNMk22VUEx7GyWfAPe+5LtmGCmMT5ok
 t3dyLy/BqBqDGmWJ4SQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
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

From: Aditya Gupta <adityag@linux.ibm.com>

Change the status of PowerNV to Maintained, to reflect it is actively
maintained

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20261112175815.2260569-1-adityag@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 08d6f76e31..05fe7d9fab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1712,7 +1712,7 @@ M: Aditya Gupta <adityag@linux.ibm.com>
 R: Glenn Miles <milesg@linux.ibm.com>
 R: Harsh Prateek Bora <harshpb@linux.ibm.com>
 L: qemu-ppc@nongnu.org
-S: Odd Fixes
+S: Maintained
 F: docs/system/ppc/powernv.rst
 F: hw/ppc/pnv*
 F: hw/intc/pnv*
-- 
2.52.0


