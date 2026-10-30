Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9C2606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TAiktBDx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMmP0-0005m8-7A; Fri, 30 Oct 2026 09:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1xMmOs-0005gw-CM; Fri, 30 Oct 2026 09:12:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1xMmOq-0004py-O4; Fri, 30 Oct 2026 09:12:06 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UBIWga2971047; Fri, 30 Oct 2026 13:12:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=y7d2awRDy+GCiUoJJ
 Ez3qcnwt1oZeIdYyMt8rTnIrvo=; b=TAiktBDxPCw7WllQqom4G+nBf4fn3S+kw
 KaSM5FKMgfyNhC3Yu9dgdUqeXrAS/B8p1m8do49MDeyq5KDww9AngwVYfvMpv3Rt
 SVXOmklcKwLLKS7ZZbJ7z90FofegScMhX37CRXuHMZYxoDFWD45sE4mG7VIT8mtJ
 JyM67VlQhUzHxfCpdGcdjST2MvR403ie+H5xqbaiIdlTupwDUr9/kQAv0rNNh/6R
 KLHhBDsVwbwoskUKZ/wNE1zafUbWC0b+uMa7Mzqtpd8u7A6e5/gLRKGJk5GV/h6A
 rF9n0ZnXjqxC3gN0KwRQA9w6am5gOEwT/MWCl7tKj5PmJyl7gZl+A==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hmeay2ud2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 30 Oct 2026 13:12:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UBK3jw494263; Fri, 30 Oct 2026 13:12:01 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hm6pbcj7m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Oct 2026 13:12:01 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69UDC0BU25166438
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Oct 2026 13:12:00 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 743A85805D;
 Fri, 30 Oct 2026 13:12:00 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D81FA58055;
 Fri, 30 Oct 2026 13:11:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.21.33])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 30 Oct 2026 13:11:55 +0000 (GMT)
From: Anushree Mathur <anushree.mathur@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com
Cc: npiggin@gmail.com, amachhiw@linux.ibm.com, clg@redhat.com,
 thuth@redhat.com, adityag@linux.ibm.com, milesg@linux.ibm.com,
 misanjum@linux.ibm.com, Anushree Mathur <anushree.mathur@linux.ibm.com>
Subject: [PATCH 3/3] MAINTAINERS: add pseries CPU hotplug and caps functional
 tests
Date: Fri, 30 Oct 2026 18:40:24 +0530
Message-ID: <20261030131025.32219-4-anushree.mathur@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030131025.32219-1-anushree.mathur@linux.ibm.com>
References: <20261030131025.32219-1-anushree.mathur@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1MCBTYWx0ZWRfX1Xf2mKgU68an
 0ZhioR2WmCuJ9WrFFtgNfORHZNiiOfodNWKOn16oQ4N+yREviJR8mLDw6YQDT68ElqdUyary1xY
 3SLrEgtJS5Xi5yNWTMRSzOY0cLlnrCgrks+lq3U/0ZW50R8VlZQPId3NKFjMPeOUC4n+6VELeBp
 O1MLL7fvr4FRg39qxaSVkvFNMtEylhqIqpmw3liab778mxRTz3IKeT6g2LHeot29Ovem16LcuDH
 yDsbF/WeTrUjZH/DaKl5yjhAsMi78oAv9JS1lE9eWq29hGYk6m040JaLw/yBnrXBbwksiVkLWu1
 1weCCqR0sIn+p8B+Vi0Leryo8qbPsvaZnSx9FFX7xAGztWIo9whNHDlsigJnmO7rg+y6CYeJ1oM
 NyQWqyYTzq4rMcI4OqM0V6CwJmYvszSJ0bs9/Jt5k+veo6zH16ef3fCTS+vb2dS0HM/KY59UllF
 8zhcmIZYXsIZOQQhG1A==
X-Authority-Analysis: v=2.4 cv=WJHqzXsR c=1 sm=1 tr=0 ts=6ae497a3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=wAWy6Tx-qCfImQJ915UA:9
X-Proofpoint-ORIG-GUID: SXu2y4VfOVgWLwp1yK8pjF9-Uwy5I5eV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1MCBTYWx0ZWRfXz8ZOR9blXLWm
 qrueWf3klFC0rXI46WIrdhd/L3YqbHhT9pe7AJZVphdp3c7yDHrjfG9zjWXmr5rL2X1xK1IZUZd
 9XW9ZjY3Rv+JIymGLmqehBP8aLcjSfU=
X-Proofpoint-GUID: 7qU13ce_WHNCpqUQT7nvV8k-nmq4i9Tk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300050
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=anushree.mathur@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Add entries for the two new pseries functional tests introduced in the
preceding commits:
  - tests/functional/ppc64/test_hotplug_cpu.py
  - tests/functional/ppc64/test_pseries_caps.py

Both belong under the sPAPR (pseries) section.

Signed-off-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 70e9fed776..a2187c440f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1702,6 +1702,8 @@ F: tests/qtest/libqos/rtas*
 F: tests/functional/ppc64/test_pseries.py
 F: tests/functional/ppc64/test_hv.py
 F: tests/functional/ppc64/test_tuxrun.py
+F: tests/functional/ppc64/test_hotplug_cpu.py
+F: tests/functional/ppc64/test_pseries_caps.py
 
 PowerNV (Non-Virtualized)
 M: Nicholas Piggin <npiggin@gmail.com>
-- 
2.55.0


