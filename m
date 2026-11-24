Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8554B606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WjxYusom
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVoGy-0000dS-HO; Tue, 24 Nov 2026 06:01:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1xVoGs-0000b1-OD; Tue, 24 Nov 2026 06:01:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1xVoGr-0001nQ-B3; Tue, 24 Nov 2026 06:01:10 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO34mSh1217045; Tue, 24 Nov 2026 11:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=l0RhbgFHsIwk7pa0o
 dYwFETL+hVI+as5nBj/oO1oIzA=; b=WjxYusomUnqKrOWYltLUSVyNfcR2gRycH
 InvMVkqfcA+GfQGFqAIYp3H1NzIAstzQfbrwMxr/X5WtpBCYT+qEZcnovefWdsS3
 ayQ5zibnXQnUdw0EU7B8+9a2lkuHuUEJqBtNh1He/hMGnDV7ZTPRSWggqAEydQo7
 GSLsc2Q2SpMvFEfB6NI8hYCXi0fwoTyaVy42h2Bb4WxPo0D9QYEU1FNiwm3SA6WI
 xF19jnfRBuFNqgom3/gOtKO6gpsyOTcx2EAaE7TLb52rkJSMVUCipci4jONr2pUa
 mcIrS12eZaDjgJVHDAOqOW0rpacl31dgpC2neAxiR691aelN+eGbQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gv6ygn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 24 Nov 2026 11:01:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO8keLZ021923; Tue, 24 Nov 2026 11:01:07 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3pmk2a2q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Nov 2026 11:01:07 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AOB154a20054632
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Nov 2026 11:01:06 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9816B58073;
 Tue, 24 Nov 2026 11:01:05 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E89975806F;
 Tue, 24 Nov 2026 11:01:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.26.151])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 24 Nov 2026 11:01:00 +0000 (GMT)
From: Anushree Mathur <anushree.mathur@linux.ibm.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Amit Machhiwal <amachhiw@linux.ibm.com>,
 Miles Glenn <milesg@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>, misanjum@linux.ibm.com,
 Chinmay Rath <rathc@linux.ibm.com>, Utkarsh Verma <uverma@linux.ibm.com>
Subject: [PATCH v3 4/4] MAINTAINERS: add pseries hotplug and caps functional
 tests
Date: Tue, 24 Nov 2026 16:30:30 +0530
Message-ID: <20261124110030.30097-5-anushree.mathur@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124110030.30097-1-anushree.mathur@linux.ibm.com>
References: <20261124110030.30097-1-anushree.mathur@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b056e74 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=bn2WUZ9vv0E_uyWmk7oA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0MSBTYWx0ZWRfXxTsAGEB4CNi1
 ze2atKTZt8uD/vwxR29wC5elmQaSRrhY70ESyY6qZrj+/sEBEGNrOkQkW3e52mZjSd50jqmUvhQ
 vBSIC79Oms81Mzq5msP2xbn/yIgWWsk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0MSBTYWx0ZWRfX8JP61TeDZX0B
 0MsyMObejSnJZkBmR+lGVBwt1/B+X9cIQfQUTYqphD4x1TLvW4RzW8lfX6v6tEuiekuHw4eZXKo
 tlINpygGYPIb/noGdLJ1+WsRpdcmMRGJsPQi0tcM4yXQYue1gDwHPYO88j2NRxfmiD6De+LMcwx
 Vvss78LM/F6rs/gnDbPvCQ0YKYfj5dnOS2EFn1Aoxz08654WEUePQQLQhmtffcYZRDxq6STvNL/
 3FYuNp5W0ocvOaV0AON5WyfnklkvCb97ASKGAAEXPumxFhVtDsgv18JFj9JVabA5q3GDOX1CjLW
 sy7nGugKL/8hHtzvf+kV9fc8M4Ov1OjUcefu+5UU8mRRXZ11OmJv7aOXimySyAovGUFKNLDA2bG
 0YK+4VxN7Ao21tu1R3UMSb+eZDoLu8b5PZE0BDJzDsxcyVkVb0hJpKCgsF/AG1kvRgOXYkFNj5d
 7hYb3yad/AuSpYeeB1A==
X-Proofpoint-ORIG-GUID: xy70aKI5YeE1X38-TqrLnXni4P2M5Eo-
X-Proofpoint-GUID: 5OLBg5HPIYSNy7J3x6IKo-n1slY6yGiF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240041
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=anushree.mathur@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Add entries for the three new pseries functional tests introduced in
the preceding commits:
  - tests/functional/ppc64/test_hotplug_blk.py
  - tests/functional/ppc64/test_hotplug_cpu.py
  - tests/functional/ppc64/test_pseries_caps.py

All of them belong under the sPAPR (pseries) section.

Signed-off-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
---
v3: no changes.

 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 15942aaba3..8456c5fbec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1705,6 +1705,9 @@ F: tests/qtest/libqos/rtas*
 F: tests/functional/ppc64/test_pseries.py
 F: tests/functional/ppc64/test_hv.py
 F: tests/functional/ppc64/test_tuxrun.py
+F: tests/functional/ppc64/test_hotplug_blk.py
+F: tests/functional/ppc64/test_hotplug_cpu.py
+F: tests/functional/ppc64/test_pseries_caps.py
 
 PowerNV (Non-Virtualized)
 M: Nicholas Piggin <npiggin@gmail.com>
-- 
2.55.0


