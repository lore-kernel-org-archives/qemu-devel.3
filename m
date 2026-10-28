Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD12F606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 05:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qol/xymq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLw5h-0003TU-JY; Wed, 28 Oct 2026 01:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xLw5f-0003So-87
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 01:20:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xLw5d-0005xQ-CT
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 01:20:46 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69S4iSXa227513; Wed, 28 Oct 2026 05:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=D1/YwJHlDNTJ2pE7K
 kQIpoYw1iMuo2P0j9LV7Yrkfso=; b=qol/xymqWheqXnUPZyWv5mZ3ZGyweVZ50
 dZlmS/hoHIg9slk5QYJmzR5/vA5RFRdGePXzEtwrvJnQd611DsY8ClqW2QeqjIiX
 uzU/8FpGCIAOV55QPS721Vailm6L9eLYgsgWAHI8UcA+abLoc81GbqC5ifbLM/9W
 yOhGg/a/zWkfQ9h0D+6+ojE9V5m9bsfXCeFRoQahfT+UHQLQjWFeyLTot/GfEwp+
 YYzVAy7hLBCJ2TuoOA4A81VqFBklBty5/Q+X4xAUv0aJicGZMjQhKDC6GVQ6fFS5
 t2T1lbED/8CRdBmDJ9Ys7Go/X+z899PRaUurzFa2AIUlcj11Wgt+Q==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgj3mb71u-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 28 Oct 2026 05:20:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69S4YtL44039839; Wed, 28 Oct 2026 05:20:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hk010j6mw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Oct 2026 05:20:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69S5KeeF49414432
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Oct 2026 05:20:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 169DB20043;
 Wed, 28 Oct 2026 05:20:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F321520040;
 Wed, 28 Oct 2026 05:20:38 +0000 (GMT)
Received: from dhcp-9-123-3-122.bl1-in.ibm.com (unknown [9.123.3.122])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 28 Oct 2026 05:20:38 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Aniket Sahu <asahu1x@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: [PULL 2/6] tests/functional/ppc64: extend pseries migration tests
Date: Wed, 28 Oct 2026 10:50:20 +0530
Message-ID: <20261028052024.38377-3-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261028052024.38377-1-harshpb@linux.ibm.com>
References: <20261028052024.38377-1-harshpb@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAyMCBTYWx0ZWRfX4P0kfzDWsV5F
 Vw9pQDlB8h5Pg3S8SxcsJNcoicMaF59yVPIyqBpIJaBeg2/gatr302rFZmcyuFOf1bu4+XCvPpk
 i9tJpUedN+JcVT/Thm43BnbSA670m1g=
X-Proofpoint-ORIG-GUID: eVcut14nzdQex_xO723Gb3yi_f3T3Aht
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAyMCBTYWx0ZWRfX0UXa2cfKfnqb
 Jrqpl568v6fy6l+ZqPm8g77JmtCNVukQGSsbjHmptWiEYxZljd1IfJ+whn8ngH9IdF/x3kCUSJg
 AXfo2N+v8P9rbiloc65AOBJzXMyy3QliJKtmVHTX3fbYZCa8g4QdH3KuXYqBY6YD1vGDrkoNC2X
 V53nMI0WImr8BCCz5TrTDrgmqSjjdWnS4Jlukz7Pr/U8Wx5030WrBNpMaPXgANzvRJxi6EdF5lh
 4BlbkhJDKhdecJ1E5LbDP2kDSDBUIZMrK4xMjcZgxVMzGqwZ12w5SdH8zWhPVYnG4K1iHMR0QCV
 ZfEC1mJoNLmg3vi3VEiirbxSKW1BifWVcOzp5rtdVgcfCu1AP0sXZajLcLHGMC1IC4zpkYO/WLB
 zgybtMjGlLztMEcBLCjXMJ23ARAD8TovpE6Wrqs7qsGcyecqMscPcqO66TxN9+BQQSZfu/EqAOl
 R80e5Cqt7cHbcMssF8A==
X-Authority-Analysis: v=2.4 cv=G7uJgNk5 c=1 sm=1 tr=0 ts=6ae1862c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=nntn5sUTz_BbCZulGUMA:9 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: eVcut14nzdQex_xO723Gb3yi_f3T3Aht
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280020
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Aniket Sahu <asahu1x@linux.ibm.com>

The existing test_migration.py exercises all three migration transport
paths (TCP, UNIX, exec) but only against the mac99 machine type.
A regression in pseries-specific vmstate save/restore handlers would
not be caught by migrating a mac99 guest.

Switch the UNIX socket and exec (socat) migration tests from mac99 to
pseries so that these transport paths are exercised against the pseries
vmstate.  The TCP test is left on mac99 since pseries TCP migration is
already covered by test_ppc64_linux_migration in test_pseries.py.

Signed-off-by: Aniket Sahu <asahu1x@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260921081010.31778-2-asahu1x@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 tests/functional/ppc64/test_migration.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/functional/ppc64/test_migration.py b/tests/functional/ppc64/test_migration.py
index 7d49ee175b..e1d51551b8 100755
--- a/tests/functional/ppc64/test_migration.py
+++ b/tests/functional/ppc64/test_migration.py
@@ -15,11 +15,11 @@ def test_migration_with_tcp_localhost(self):
         self.migration_with_tcp_localhost()
 
     def test_migration_with_unix(self):
-        self.set_machine('mac99')
+        self.set_machine('pseries')
         self.migration_with_unix()
 
     def test_migration_with_exec(self):
-        self.set_machine('mac99')
+        self.set_machine('pseries')
         self.migration_with_exec()
 
 
-- 
2.52.0


