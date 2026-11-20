Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E795C60A2603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=r596hy7o
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xULPA-00006G-Vt; Fri, 20 Nov 2026 04:59:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1xULP8-0008RV-7h; Fri, 20 Nov 2026 04:59:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asahu1x@linux.ibm.com>)
 id 1xULP6-0007ep-HJ; Fri, 20 Nov 2026 04:59:37 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK7uhjC2650135; Fri, 20 Nov 2026 09:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=YbtXK/BHwuepci7Jp
 zaZKfGJdN8fu9vH1hwBiSKhBWY=; b=r596hy7ogPwJBuzyYmkxK1R1dTzIXaToB
 VzRhm45mUk+izIV9DyqHGALQDrckXRlUQmvJ0XT01JVNlKAZqxSs5VQYyQUPbJla
 6Qb7e9Deq8qkprDOGiWc3m5OknwI3Iem6m+sQNPgjxIC889v+ic2I9rHzv9gpgbc
 Lae9AW2lJm/bK4ys9r2pjXvreRxIfKiQEMdYougiWfrFcuLGKLxg7onXueMHicJ/
 CJe1owD+BMZXgJkPK4ZLOYZxjWtf/iZ2Xb4vqmyZwM6vxnSzrYq5WIaxsjnjQK36
 OZm9Y8+cxs1gO8EI78biY0hWgYprsKvniGIiYyaFWoSGeMYaovgvA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105nqjv9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 20 Nov 2026 09:59:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK84nrT145260; Fri, 20 Nov 2026 09:59:33 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j23dwd0qm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Nov 2026 09:59:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AK9xTwQ44433680
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Nov 2026 09:59:29 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F088420040;
 Fri, 20 Nov 2026 09:59:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AFFC52004B;
 Fri, 20 Nov 2026 09:59:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.22.205])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Nov 2026 09:59:24 +0000 (GMT)
From: Aniket Sahu <asahu1x@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, peterx@redhat.com, farosas@suse.de, npiggin@gmail.com,
 adityag@linux.ibm.com, milesg@linux.ibm.com, harshpb@linux.ibm.com,
 rathc@linux.ibm.com, anushree.mathur@linux.ibm.com,
 misanjum@linux.ibm.com, gautam@linux.ibm.com, thuth@redhat.com,
 amachhiw@linux.ibm.com, asahu1x@linux.ibm.com
Subject: [PATCH 5/5] tests/functional/ppc64: increase timeout for hypervisor
 tests
Date: Fri, 20 Nov 2026 15:28:58 +0530
Message-ID: <20261120095854.35941-12-asahu1x@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261120095854.35941-7-asahu1x@linux.ibm.com>
References: <20261120095854.35941-7-asahu1x@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAzOSBTYWx0ZWRfX/5SN9ylGCb4W
 tSP5hqFZhnJQgU0B09isvCRcxXco34hO0f4FUkl/2wkcalcn0gFkPZVbDJ9MsG2olAGXn2p4Ahc
 HgK/G0352R9va/GPv8+nV/ffkyHxZKUf4JitL7zYNxmIwks0aIsO8u+3kRHO3WA98lUeO9g+Y8i
 oeXQsCnpwEL5aDXeOE/pQtekiC/T8YgMzNdRN9QArJE9iBTyTpyvSOeuARp5bRWD3UwcqZVYkio
 Wf3d0jL1UuUFZy29hYX3M2btUgeQkm69OwPUZ7L1IfMs38m6iYvViP/eR6OSSYu41IK+JhbKPsH
 DkynbyZXRBTd0K/V5VvNPQmQq0x6DJGO2ikQkTrbwGml66rsX9VnqxBKOKnVZMimtmlNUzUszoR
 ytMejI8Ref0eQp+mMEogU2KaEmhhA79eNj2hibkh//k68+xi4a0htEkFmf3kxQ46F8JhGnGZJvT
 RGkN9rVW0/yEHcWFskw==
X-Authority-Analysis: v=2.4 cv=HN9WhYtv c=1 sm=1 tr=0 ts=6b001a06 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=Qo1iHMT5jg0a-ZBhkSAA:9
X-Proofpoint-GUID: YSbhuoPaj5BLWq4Q118kTimQdXO-e4h9
X-Proofpoint-ORIG-GUID: YcQa95se5escc6uZnFUhX36BYbh1199I
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAzOSBTYWx0ZWRfX1lCkLvWWhoTp
 cvvak8X3WapaLvGe0KkcZuTnUZGhbXCVY4y9WZyYQZen0Eddg0fg8JF11murLtlJum/pK8fpVxO
 rgMQhubLySETAtIKzjrl4oOFBDMd7V0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200039
Received-SPF: pass client-ip=148.163.156.1; envelope-from=asahu1x@linux.ibm.com;
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

Increase the timeout for test_hv.py from 1000 to 6000 seconds.

The test now takes much longer due to:
- Retrying apk update up to 5 times
- More comprehensive testing with additional debug logging

Signed-off-by: Misbah Anjum N <misanjum@linux.ibm.com>
Signed-off-by: Aniket Sahu <asahu1x@linux.ibm.com>
---
 tests/functional/ppc64/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/functional/ppc64/meson.build b/tests/functional/ppc64/meson.build
index cb3c745624..d908786426 100644
--- a/tests/functional/ppc64/meson.build
+++ b/tests/functional/ppc64/meson.build
@@ -2,7 +2,7 @@
 
 test_ppc64_timeouts = {
   'fadump' : 480,
-  'hv' : 1000,
+  'hv' : 6000,
   'mac99' : 120,
   'openbsd' : 240,
   'powernv' : 480,
-- 
2.52.0


