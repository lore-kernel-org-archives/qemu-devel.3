Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1455A606A327
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ekxBLvtq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRZ4F-0000zD-La; Thu, 12 Nov 2026 12:58:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1xRZ4C-0000yS-UQ; Thu, 12 Nov 2026 12:58:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1xRZ4A-0003al-Lf; Thu, 12 Nov 2026 12:58:32 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACFiNqM441816; Thu, 12 Nov 2026 17:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=HXvcDqFstBXeJeAusBGHw6970gofBJZ8cpe53TuiW
 H4=; b=ekxBLvtq8QfvR87uHv37A6pYPG2QpQFjNYxfmtqWyMBtp48Zd9XBINy9w
 3WV695lqKLQ8CDEnw56F0lBWvm9DWDki1kycbu/oA9BkBEhM+bV92XYcYlHb/W8U
 iigjR9esMtML2W5Zztf4Yo/m2/r0ZyLt/x7Ka5UbfajWKjJnEUk0vME9tdkmCEkS
 NVXHp5Gl/QnORZ8IWpSvgVi3yEzMEyoTHNLE4iN+uLzLaAmpCUUNhDcLLOHYWZmp
 bieJU5os2UVK99/lDH9+MG+CSsEmAm0y5ppgK96thLgVXcixzTBgA4l9zT/6wbi+
 8+2UElMex/tNY36Ozpd5rOZRNqJrg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug6gvx2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 12 Nov 2026 17:58:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACFcLU3863686; Thu, 12 Nov 2026 17:58:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hwegf8vv0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Nov 2026 17:58:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6ACHwMO352560152
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Nov 2026 17:58:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E3B720065;
 Thu, 12 Nov 2026 17:58:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5C2CB2004F;
 Thu, 12 Nov 2026 17:58:19 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.66.64.95]) by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Nov 2026 17:58:18 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Miles Glenn <milesg@linux.ibm.com>
Subject: [PATCH] MAINTAINERS: Mark PowerNV as Maintained
Date: Thu, 12 Nov 2026 23:28:15 +0530
Message-ID: <20261112175815.2260569-1-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: rjCpSW0Y--MKN4aUUMH__9dsc5xocCcX
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af5fe43 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=m_SZ6Kus21JLo_oL4g4A:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: SIpLQUdy88iYBk-qa81oqtJ9Pewes6g5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA3MCBTYWx0ZWRfXwVty9fRdkv5Z
 CakBSrhDR65VWBE1DRJpL5Lqo8AXS7Ph55uAcVLzr+wqV3yfHonNO/h5x5bGbmWBdcD4hrFcgLG
 biuGJGIbgFAWw5kj6ew2OQIPn4ifYfAE5p5pCGdEgMyfp0QGfw5YpQBh9CHcCHFMr7+FkO4Jjft
 vGelqTOGiCSHXVqKpS5S2aDwBU+vtPqmbdQbd0VpBPEqGTXfAVYgj2tgGrBkDU0CHZWVOiaf0yR
 WUz5sTJ0vBZEOqkWoDpdK4JgbtOnpaMaCoYc+vEU8eZkTrcTsyLC95HFl8ydD6OccM2LYJA8xf/
 piWGLH+WSoA5mh6YEvFwn4oD+VmLCw6JzFRO/2ttqav1B80psg6E5juRr4TIPvOcW0HTks9mFMX
 tS5VAcQ9QvQ0jhdrBwibbidMehsCuxdvcsFKPxrfZ2vcqqUtipm4alYFltPyE/Fwawxblw77SKV
 Dta+nbs12f21PxNMavg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA3MCBTYWx0ZWRfX/NB5iQdd0bWa
 oXu8uLkT2yynYig/04X8MapDQcLibtbCp/cgMbMuzRNZFKRGaonPHVsNxUxXDhRbiqlrZaKbc1b
 Ex5qf8D5LPtXEV5fmRzRxx+eaxO0m4Y=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120070
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
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

Change the status of PowerNV to Maintained, to reflect it is actively
maintained

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fa0c6d0c9bc5..7bf67c2e6d9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1711,7 +1711,7 @@ M: Aditya Gupta <adityag@linux.ibm.com>
 R: Glenn Miles <milesg@linux.ibm.com>
 R: Harsh Prateek Bora <harshpb@linux.ibm.com>
 L: qemu-ppc@nongnu.org
-S: Odd Fixes
+S: Maintained
 F: docs/system/ppc/powernv.rst
 F: hw/ppc/pnv*
 F: hw/intc/pnv*
-- 
2.56.0


