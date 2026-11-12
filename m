Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B7E606A335
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=P5CycpLa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRXwe-00013A-9I; Thu, 12 Nov 2026 11:46:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1xRXwc-0000yZ-37; Thu, 12 Nov 2026 11:46:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1xRXwa-0000GO-Na; Thu, 12 Nov 2026 11:46:37 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACFiMfR246949; Thu, 12 Nov 2026 16:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=UKO2qrTkZRbuFREeu
 3Iztcap7AYdQ6vTfGk2rM6uKus=; b=P5CycpLa+KWi6x+s4cYHIbugM/4qEvWTe
 vwbcWwlbQstt8oYYRfsnNswwXQ5G0LfM9kvYc0LbZvBDbA1vYscwNbXYP3ZETt+Q
 gAH1W9sIdR9AmRiRfTp88CVClAwI7y2i6yaqRI/B7IN4TsmEGwB3n0OfMV5XcILG
 bKLdX77ALylPsIVYwoDZWkK/Z16w2WRHKdfqIsvzmf0ZG6Sl3cWrpmLcAyL5foPw
 josE8GVg/MdcWxgckjMN9IHXZCa/XCWX6JyVBNhABZy3umNMjSd5sp2YLv3xsnId
 7otcUnkueymS33u2XrKGRectakuwj1e4W3+KSzaKLZWntwN3LBWUg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumv79tn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 12 Nov 2026 16:46:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ACFc5b4898457; Thu, 12 Nov 2026 16:46:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hwd858w78-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Nov 2026 16:46:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6ACGkUe646465504
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Nov 2026 16:46:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 27B0520043;
 Thu, 12 Nov 2026 16:46:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 563B420040;
 Thu, 12 Nov 2026 16:46:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.17.46])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Nov 2026 16:46:28 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>
Subject: [PATCH 2/2] MAINTAINERS: update sPAPR status to Maintained
Date: Thu, 12 Nov 2026 22:16:17 +0530
Message-ID: <20261112164617.85849-3-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261112164617.85849-1-amachhiw@linux.ibm.com>
References: <20261112164617.85849-1-amachhiw@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA2NiBTYWx0ZWRfX6iXvTuhKPSCT
 VvCTL7FQ6/LNW/7z/Xw15J+TilBMe7OKYUinLdcpDRhp99AJGjT1GpxOt5IU1Q5gaQb9r/D5hvb
 eKWRzHwZHZpNSNzaRcg63KJhwUy/4lo=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af5ed6a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8
 a=wNMCQv4Ij_i1BUDQisEA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: Zqo8PcrlhBZmtpYVjH5IxNk_jW9ZVIX4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA2NiBTYWx0ZWRfXx6XjrGCttVCD
 rRKUaONdiphNo87gxHn6nuaIEpYixYU2ZtKRUiHWI71K/jDu3QpqA+HCSWVMksFWC225ChNFPja
 Hy5TUFJvViDy6TzFz+YwOAhcLn6Ei+2Srfmu2cFfA9pzi2nEzkzriorJqcD4LUE8+p22KFuNwsY
 4Oi0bIP+N0TQoym7OiZnEbNZVD0UW7UWE56ZWBQg+0zU3YwRmH1vX1BJUuJ4VupPQDS9kv8jdCT
 96W75cICAdVqX5uywIZPi0P33wPc9w8KauRvueNuJF5tDmf8bGkDYP4Qd3LvR/DXGVhZVtmppgr
 i6L2qF7DYCsvrPNlf50B/2alQYlZzsDbqt9i6aWce8vdLg03pHh62dtS/cQL2fYGasGTm+MZIqV
 fe0lX0RtfPjf/gISxJ5Gf8W7En4YmoPMNtZsmCSKOplU022dyfpspa9xNHuVfgHW8G5C97cblUe
 I3vjSTPsAMT72v92bbA==
X-Proofpoint-ORIG-GUID: tyC-bCjo2Re4MOl9nlPgMddabV0qOd6N
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Change the status of the sPAPR subsection from "Odd Fixes" to
"Maintained" to reflect active maintenance.

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 493be5d85be8..0f6e5fbbe646 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1686,7 +1686,7 @@ M: Nicholas Piggin <npiggin@gmail.com>
 M: Harsh Prateek Bora <harshpb@linux.ibm.com>
 R: Amit Machhiwal <amachhiw@linux.ibm.com>
 L: qemu-ppc@nongnu.org
-S: Odd Fixes
+S: Maintained
 F: hw/*/spapr*
 F: include/hw/*/spapr*
 F: hw/*/xics*
-- 
2.54.0 (Apple Git-157)


