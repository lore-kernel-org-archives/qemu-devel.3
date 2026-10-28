Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14630606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 05:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AJvEKy8+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLw5h-0003TV-R7; Wed, 28 Oct 2026 01:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xLw5g-0003TH-TO
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 01:20:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xLw5f-0005xa-4I
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 01:20:48 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69S4jQaW230722; Wed, 28 Oct 2026 05:20:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=uYis7eIR7PdW4+cJi
 d1+1FXoQITNNMIg8fv82vSjCHg=; b=AJvEKy8+jSXNUgZUEfRsMErLGcI/54kib
 HaJqMFrlQ98EgQcU2F+6xRCEIBgUYm6k1cGq840XH0B7HuMogefu2BtgtrIR6KH3
 aTE9/decuLIYLNnS/1WxRg9lRVT7UYnOWxW44vYP7E2DMLVXx44n7/BPleYJAECV
 /S0p+OPmgIe8GKnYk7Jt9Enprciv4ClpUTuSmBpi25Ta8KPtaRAjBjWyNbwdab3b
 xv/FwJb0z5U/Ya9eX4/yXpnJFCS74f0nLvEIMtuN26/WRpQzGVJLGSTjn4I2c9yb
 rRdAdngpnT8Jj8lQYnSQlM5T3g+uhS4hHSAwgBwHf9VwMJWP+cnqg==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgj3mb71w-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 28 Oct 2026 05:20:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69S4YwVw1081706; Wed, 28 Oct 2026 05:20:45 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh8gh5yqg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Oct 2026 05:20:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69S5Kfe039190904
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Oct 2026 05:20:41 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA49E20043;
 Wed, 28 Oct 2026 05:20:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6926020040;
 Wed, 28 Oct 2026 05:20:40 +0000 (GMT)
Received: from dhcp-9-123-3-122.bl1-in.ibm.com (unknown [9.123.3.122])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 28 Oct 2026 05:20:40 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Aniket Sahu <asahu1x@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>
Subject: [PULL 3/6] tests/functional/ppc64: extend ppc64 powernv net device
 tests
Date: Wed, 28 Oct 2026 10:50:21 +0530
Message-ID: <20261028052024.38377-4-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261028052024.38377-1-harshpb@linux.ibm.com>
References: <20261028052024.38377-1-harshpb@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAyMCBTYWx0ZWRfX6COkSm5rOTe4
 6jESCDTYQUYQkXZTkjXcKQM0Dfd2e+9vB7hf5gLo/xOWA7VGcpgRqN25kzeYrGbBRFlajFelxij
 mS9QMXW2AJa/QQ1NA4NLq9x1YTn9gro=
X-Proofpoint-ORIG-GUID: Fkr7sOBsZDcwNr2udFsExOa5KDs_vocR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAyMCBTYWx0ZWRfX6n/vLQ5oAgJD
 n+i1EH/9YujypOlAzFHdS5mzvI8VAHw8fh4pYZoAj7PiOmG3QPKjQCtLSvkqXpfhmhCoU203yht
 jDgqAMPxQ09h79LZrWI/3xyHHki7o/+J3+V921v1XHv8vRHhm6vGpNQAMLEP1u3gLF8p0XCqDJ/
 z6133KiUi2oO8HmY202IAG2WSrT/81ycpNA3ZjP+vgtNk88i/k6RhpMxaDLDFIusO7F0oelXXiA
 A8USFyadKtQF01AK8QQy4L3B5/N1t59IHaieXBkxRswNJexOUkKj3pMbAZNFix7t3SWAtp9Jr2/
 ogUsXmX77gpIJZOq9pvIfizyKppSFqvhIzjVnPEpH5dsnIqV3PwMqKroBzpXzkUvmxoE5VXP/Fp
 coNo16I+qm3BWdiOq1Vo6CFbed3ZT7ztjc3ic2w1+BJzWkOZuwaj6mszB/7MMf9sRQvaJqwpGGX
 lG3VJqYwWCYujbeGn3g==
X-Authority-Analysis: v=2.4 cv=G7uJgNk5 c=1 sm=1 tr=0 ts=6ae1862e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=qvQqbTaxai10iMa-vdEA:9
X-Proofpoint-GUID: Fkr7sOBsZDcwNr2udFsExOa5KDs_vocR
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

Added console checks as the probe log lines will appear before the
S14Silence-console init scripts.

Signed-off-by: Aniket Sahu <asahu1x@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260921081010.31778-3-asahu1x@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 tests/functional/ppc64/test_powernv.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/functional/ppc64/test_powernv.py b/tests/functional/ppc64/test_powernv.py
index f3e05e4d38..200fd2c894 100755
--- a/tests/functional/ppc64/test_powernv.py
+++ b/tests/functional/ppc64/test_powernv.py
@@ -201,9 +201,12 @@ def do_test_ppc64_powernv(self, proc):
 
         self.wait_for_console_pattern("CPU: " + proc + " generation processor")
         self.wait_for_console_pattern("INIT: Starting kernel at ")
+        # NVMe, e1000e, and xHCI are probed synchronously by the kernel
+        # during PCI enumeration, after OPAL hands off to Linux.
+        self.wait_for_console_pattern("nvme nvme0")
+        self.wait_for_console_pattern("e1000e")
+        self.wait_for_console_pattern("xhci_hcd")
         self.wait_for_console_pattern("Run /sbin/init as init process")
-        # Device detection output driven by udev probing is sometimes cut off
-        # from console output, suspect S14silence-console init script.
 
     def test_ppc64_powernv_external_dtb(self):
         self.set_machine('powernv11')
-- 
2.52.0


