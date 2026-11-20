Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DB4606A32C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qKrb6hVc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xULOp-0008Bm-Ec; Fri, 20 Nov 2026 04:59:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1xULOn-0008BL-09; Fri, 20 Nov 2026 04:59:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1xULOl-0007cx-FA; Fri, 20 Nov 2026 04:59:16 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK7uK8n2481580; Fri, 20 Nov 2026 09:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=04w5Nz6WoomH41Tej
 Iz/c0vbTQTjTLmRcEwmfKTdRkU=; b=qKrb6hVcJsryPjeCyvn7EQWFslW6x6E/Q
 HrQsm5m9HunArlmby03SZDvupldpGuhCl3dyjOupUP0hjzFTZK4NjpXoGNUIlgZr
 c0AsclGIbPKEizd289ngK3fE9OKihCrw/IhtBYsoODei0hWku8k9Hyeg1kBetazw
 RsVRcxK8EKGdjDV5kpVTSdUjw35BjkZoKUnbLyDu7PSV10VnqWLDCJJgF1XHkiYa
 PMFC/zsnhKEGHmoz4+sTaCd+YVbePM0QCVyelIQfHR1ImndBTff86z2bzFSjesUm
 2oNauYYaDyPB+Yq3INZXquZwPSnRAdI4QDFytP8NisMt913WJi/xQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105x78a8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 20 Nov 2026 09:59:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK7o5kN2242255; Fri, 20 Nov 2026 09:59:13 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1hd722en-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Nov 2026 09:59:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AK9x9tt49545512
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Nov 2026 09:59:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D88E2004B;
 Fri, 20 Nov 2026 09:59:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E1F920043;
 Fri, 20 Nov 2026 09:59:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.22.205])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Nov 2026 09:59:04 +0000 (GMT)
From: Aniket Sahu <asahu1x@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, peterx@redhat.com, farosas@suse.de, npiggin@gmail.com,
 adityag@linux.ibm.com, milesg@linux.ibm.com, harshpb@linux.ibm.com,
 rathc@linux.ibm.com, anushree.mathur@linux.ibm.com,
 misanjum@linux.ibm.com, gautam@linux.ibm.com, thuth@redhat.com,
 amachhiw@linux.ibm.com, asahu1x@linux.ibm.com
Subject: [PATCH 1/5] tests/functional/ppc64: replace deprecated
 datetime.utcnow()
Date: Fri, 20 Nov 2026 15:28:54 +0530
Message-ID: <20261120095854.35941-8-asahu1x@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261120095854.35941-7-asahu1x@linux.ibm.com>
References: <20261120095854.35941-7-asahu1x@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: xcZ3_d4pocwhe8h-jqyR3_irR6yggIUE
X-Proofpoint-GUID: RhufdU0oYY47249XXjcG_poEau4uSy2S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAzOSBTYWx0ZWRfX5nIrfSg26Pj0
 XdAo30IbkfRV1OZ65+T8JiVZubcAVA+raE6mdfo7PAM119R9r2u4wAm3Dp/8h7ZLJvN2GbDk25W
 0ftRLuUpOvwLhcltFq3D4tc78kC7+Szg8OgSxD0TuS6/lIcMEL8jqJZu24AyuXxlcXMs2mwftFM
 IXX7MmxWUD9YlRBAjJD6bVeg/pZ7/SGopNzSY/ENjKzDT/4Z+z0TGobQZE4NdzHsO0yCxQ9nnJ9
 h5qye+l8uwTguS4GrfNZ7cx2DwYPZsKbL/sM7ARe9O4+qfzzqXaVDmxBbG6tkxNUQxxxsxHjKSg
 6evIyRz6IHLcXr/pGeIrqWRZYqn6DHwkOs9QJHuOutz2cXsm9qxyEwvxGShS3pwHIW6iSgdtJQW
 QjZvvvZPvW8P+C1Gf1SY+FYmuQypSwvXMrhB0dvYnKVbwH5/30V8g2wCIt6bJ7aE16Fi+Pt8zrm
 SJb3ziQcObQF3OjKM1w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAzOSBTYWx0ZWRfX3IWgkm3S2IkI
 xWc/WwZPsRFn/0/ZM/RxQrUyflc5J0oy98Jo1c1EoNJyzMOvlnv+rOkcACcylJUvEdi7i4rYj8k
 gO3cpg7EsXqEahN2tYsi97VBzfR2+WQ=
X-Authority-Analysis: v=2.4 cv=K+m3jCWI c=1 sm=1 tr=0 ts=6b0019f2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=1OFjFu4GZXCg9pkfsvQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1011 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200039
Received-SPF: pass client-ip=148.163.158.5; envelope-from=asahu1x@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Replace datetime.utcnow() with datetime.now(timezone.utc) to avoid
deprecation warnings in Python 3.12+.

Also add debug logging when setting the system clock in the L1 guest.

Signed-off-by: Aniket Sahu <asahu1x@linux.ibm.com>
---
 tests/functional/ppc64/test_hv.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/functional/ppc64/test_hv.py b/tests/functional/ppc64/test_hv.py
index beec1dbbea..8a1fca2cb1 100755
--- a/tests/functional/ppc64/test_hv.py
+++ b/tests/functional/ppc64/test_hv.py
@@ -12,7 +12,7 @@
 import os
 import subprocess
 
-from datetime import datetime
+from datetime import datetime, timezone
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern, exec_command
 from qemu_test import skipIfMissingCommands, skipBigDataTest
@@ -74,8 +74,9 @@ def do_start_alpine(self):
         ps1='localhost:~#'
         wait_for_console_pattern(self, 'localhost login:')
         exec_command_and_wait_for_pattern(self, 'root', ps1)
+        self.log.debug("do_start_alpine: logged in, setting system clock")
         # If the time is wrong, SSL certificates can fail.
-        cmd='date -s "' + datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S' + '"')
+        cmd='date -s "' + datetime.now(timezone.utc).strftime('%Y-%m-%d %H:%M:%S' + '"')
         exec_command_and_wait_for_pattern(self, cmd, ps1)
         ps1='alpine:~#'
         exec_command_and_wait_for_pattern(self, 'setup-alpine -qe', ps1)
-- 
2.52.0


