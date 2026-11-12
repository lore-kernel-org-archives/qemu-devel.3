Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E76606A32A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 07:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XxcSXJpM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRPWI-0002Bn-9w; Thu, 12 Nov 2026 02:46:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1xRPWG-0002AF-Es; Thu, 12 Nov 2026 02:46:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1xRPWE-0000HM-OM; Thu, 12 Nov 2026 02:46:52 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC2iC5G2857557; Thu, 12 Nov 2026 07:46:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=Wr9wzpyhqdRx6uvQNIH+lbPHw2f0
 58E9A7p1YWqK1Ac=; b=XxcSXJpM+NGzQdJApZE7c9i5I29J5ITLFNS/hIWepuqY
 J3unQdbe4ODnI4ScgWc63PWXhACGtuexCBuPSJSVy3ZAfKxcdrBDQexJ/0oIpo92
 XgTkMuxCWcSbZYGz6XNG3fzub+nUpO59HYfNGXlPM+3wxQVdg8UdqUFuEwtC3uBM
 ZRf9GbMYs2Ht9vwbUVpZvqNfSKwwHgenTGO0zTB3rcU0glKA8yL+Na6t4PMfBldP
 TQnq8Ryak3ldULhONjZ/oTACfXibt3pS0SLPAHYk1GjuWFMNRPP1FJcNBPFyfEsD
 07T2cQxLz7u4H4pERHemNdsSuaOSSib2D1ZQfcF3Xw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumv56gk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 12 Nov 2026 07:46:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC2Zl0v3145596; Thu, 12 Nov 2026 07:46:47 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hvd51wj88-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Nov 2026 07:46:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AC7khN546465390
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Nov 2026 07:46:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B7CF52004D;
 Thu, 12 Nov 2026 07:46:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5EFE320040;
 Thu, 12 Nov 2026 07:46:42 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibmuc.com (unknown
 [9.39.17.123]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Nov 2026 07:46:42 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: harshpb@linux.ibm.com, milesg@linux.ibm.com
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: [PATCH] MAINTAINERS: Change XIVE status to Maintained,
 adding self as co-maintainer
Date: Thu, 12 Nov 2026 13:16:39 +0530
Message-ID: <20261112074640.219753-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAzMCBTYWx0ZWRfX/yWsZ5vrnI49
 EjqVgSReSS6KKENirY4jV+0jFcTFMu/dQRSRJK46ypom3+fpdM/165+fLg+hBvLFXnJFU3j4KYe
 NUVVsYzBuHIj0mrBEpaOddtdxC1rsdg=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af56ee8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=4VVcHpUFlTeZ-k0x__MA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: RGXYBzPhU9aWJ--Kr669qQjdjOW-4UkK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAzMCBTYWx0ZWRfX7n5ZTfAC0G/b
 3WbA1oQEI8Ood233ZzwV63yNO1DfcFgx+kUSTjN2YzRKwIkU8ndlc/UEDGuoR8QpStxGWuNbd3L
 NROW5cJM0zwW1E5Wf1JBBiaqOM9Q+BLtVLkN8VI0VcOGVtjFDqasws77tOcJdj4OHkvBlVUUuVq
 /wdh/7oQBiFKkfk4cpAeuGfNUu08Co9nbO2YmVKcFHPqxhUyxVvP92hW0uyi6hicE9S2cFwkjzG
 91FK4pWG5xCSFFpgvMR+lRXSYBj7L76IPLdwRvfWZCZUkFriDVICsWgOaopTqrjAB/DK1B2gzhD
 blCIKnUJjrKN+wlf4eQUQLTmdiVrwL4tXcpQ5ogH8yEeQLK8XI0PXQHE0oSm1LbNu0XM3n7ywy3
 sEH6d3VZOKF6bFVYApm9cZ+2MNrxZajKi8FQyGqptwxqAeFi431j669AChnEuElhj+3HyzV/Sy1
 WHJJavKu236zi0IVHSA==
X-Proofpoint-ORIG-GUID: RGXYBzPhU9aWJ--Kr669qQjdjOW-4UkK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120030
Received-SPF: pass client-ip=148.163.158.5; envelope-from=gautam@linux.ibm.com;
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

Add self as XIVE co-maintainer and also update XIVE's status to 'Maintained'
to reflect the actual status.

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fa0c6d0c9b..47c0b6b4ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3078,9 +3078,9 @@ F: tests/qtest/fw_cfg-test.c
 
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
2.56.0


