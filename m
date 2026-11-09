Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20290606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WIykUi+0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQW1L-0003ei-Fm; Mon, 09 Nov 2026 15:31:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bwalk@linux.ibm.com>)
 id 1xQSu8-0005Q3-BX
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 12:11:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bwalk@linux.ibm.com>)
 id 1xQSu3-0004BR-As
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 12:11:34 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9FhBv63508194; Mon, 9 Nov 2026 17:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=ytbRofTAdPhcEbfL6
 4CGQU9cciM3vpGbXgz31D590eI=; b=WIykUi+0sXiXSNBEtj59PVaXW4j/yZqEm
 jZFnIFPfzhgpPY5NQvFIqQzDqZABthsF57MTH3HTW1eVOHUso7vYq+yxe1AlTM0/
 2MaPU+Y7j42yFhWX3HXTBMsTGIz/e0toOp1iUFUIgBt1y+RO0T1b9zNcoEjwx9ln
 QVm2RvqTJ8C0KbHPCOzMyK/BZcQeGKQgwFigXdxRnUoOL5ZmMTG08mBIrr4VzEet
 rWxXDl6rJEeNnSJ/7t+r/I9BimjmBe1QLJzac/ZpBHc7Vh7+W5eMQ4tmHptynYQL
 6pychaR+r+JdgLR12BAlzBMlmE5DgPjy7y9M1dkxl4T4rrpoNthgA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumuq1qw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 17:11:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9GnMXe079597; Mon, 9 Nov 2026 17:11:26 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hteaq225k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 17:11:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A9HBNrV44564810
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Nov 2026 17:11:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4675320040;
 Mon,  9 Nov 2026 17:11:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1FC472004D;
 Mon,  9 Nov 2026 17:11:23 +0000 (GMT)
Received: from a46lp03.lnxne.boe (unknown [9.87.84.240])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Nov 2026 17:11:23 +0000 (GMT)
From: Bjoern Walk <bwalk@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Steffen Eiden <seiden@linux.ibm.com>,
 Andreas Grapentin <gra@linux.ibm.com>, Bjoern Walk <bwalk@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC Patch 5/8] scripts/update-linux-headers: Vendor hwcap.h and
 ptrace.h for arm64
Date: Mon,  9 Nov 2026 18:10:31 +0100
Message-ID: <20261109171036.3806884-6-bwalk@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109171036.3806884-1-bwalk@linux.ibm.com>
References: <20261109171036.3806884-1-bwalk@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA2NiBTYWx0ZWRfX4DyxRkcPhCTs
 mdipLwvKQYCZQ0dE66D5yMItU1ULQ9ipbOWRXX258OZZTJr4Izvc5DQda6mtdMaiGSdnlTgDl9U
 M/kmSLY+ZIJ+EFH6tZYF4bl1WbyPu0w=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af1febf cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=pBhn0m9D8_np3olQrd0A:9
X-Proofpoint-GUID: hfwd4ClpAFA85JUOiK0GwTGuR4oZg6In
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA2NiBTYWx0ZWRfX3EGfk54+b4li
 PROti6KCN7qySSt6OiU/hS91wWKT2UsaF9RgVLzO6KTo7M5I/VTaTqyc9GjNP+o+VbQaj69YoBr
 sDWqpvxOzOXxR9WbJ7ylVOur58HZrPKxd0e9NKt2xe6xisrEKfsWC3LCeeAnEEk1WR6P4MEewKZ
 IMkqiH3lAtE63t83D/ZBKDUb/R9SE6Mx4ViUqqR1ATuRIRVOt1ydzTWq19B+aRugDRbO0/Kbbqf
 zLWAIR74KQNRsOun9vuMxmsw+5+VPQgxvYU7C2sFWFTZ9Ma2H83bK0VYZ18N2zvv9IITJWdn0uq
 S2qxtMOgPnuovpYsMJpm86vLaPEcfPvl8YdTiD4YCagrhaId0K4KpsyyfRT9snf105YU2bXFbRq
 MTzoS4VO0Hjcmct/6++E7/ISa78jLem66xkeSGcYKwjx/6iYtYATsFoyx+7dqP5Y9UVzKhUeFQG
 zmmzXoK+vE8PkKGP6uw==
X-Proofpoint-ORIG-GUID: hfwd4ClpAFA85JUOiK0GwTGuR4oZg6In
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090066
Received-SPF: pass client-ip=148.163.158.5; envelope-from=bwalk@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 09 Nov 2026 15:31:04 -0500
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

Both files are transient dependencies on ARM included in <asm/kvm.h> and
might not be available on other platforms.

Signed-off-by: Bjoern Walk <bwalk@linux.ibm.com>
---
 scripts/update-linux-headers.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index cd8b5035..fa5f1ecf 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -173,6 +173,8 @@ EOF
         cp_asm "$hdrdir/include/asm/unistd_64.h" "$output/linux-headers/asm-s390/"
     fi
     if [ $arch = arm64 ]; then
+        cp_asm "$hdrdir/include/asm/hwcap.h" "$output/linux-headers/asm-arm64/"
+        cp_asm "$hdrdir/include/asm/ptrace.h" "$output/linux-headers/asm-arm64/"
         cp_asm "$hdrdir/include/asm/sve_context.h" "$output/linux-headers/asm-arm64/"
         cp_asm "$hdrdir/include/asm/unistd_64.h" "$output/linux-headers/asm-arm64/"
     fi
-- 
2.56.0


