Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00B2606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qdbLqG3p
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQW1Y-0003uK-Br; Mon, 09 Nov 2026 15:31:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bwalk@linux.ibm.com>)
 id 1xQSuD-0005Qw-TC
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 12:11:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bwalk@linux.ibm.com>)
 id 1xQSu6-0004Bm-1K
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 12:11:39 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9G7fxf3699530; Mon, 9 Nov 2026 17:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=pI7pEaRnvSkjBGt1p
 9lgpcvHiGr40MWVZZnrFp3u5r8=; b=qdbLqG3pJ1UzndBixIBiuPPByEF2hbkKr
 VOl8f/Nfgdvc3Gal4kKJC0bCxz1SNoFo16s7XvCOAruBl6qfJvKoAtBiSnbHmq09
 ciFqGn/98pdpZNdn8DP6TD2JUzPl4F31hAAh99F4MAXQCn9WxJLZkmBISKUmLna5
 pxLlMMDlLFMHenkRmvUT6lguu7nx3nmN6GeRtlH8z1IP0pxoKlbWvba5+PSfJxmk
 sR4MqOWatOOIyvQN7vEEBJqDKpAikWV4bViFYoBDoOYds5N3Sj06AtoGAShv6x23
 j6D+4Zd7FVrGXxlFzivbsOMWf+OGXX+PK0L+t7J7gBxoflF+nB/Tg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug5ykqb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 17:11:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9GmkUT037093; Mon, 9 Nov 2026 17:11:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfak1v1j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 17:11:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A9HBOTm44302804
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Nov 2026 17:11:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 276F120040;
 Mon,  9 Nov 2026 17:11:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0234E20043;
 Mon,  9 Nov 2026 17:11:24 +0000 (GMT)
Received: from a46lp03.lnxne.boe (unknown [9.87.84.240])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Nov 2026 17:11:23 +0000 (GMT)
From: Bjoern Walk <bwalk@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Steffen Eiden <seiden@linux.ibm.com>,
 Andreas Grapentin <gra@linux.ibm.com>,
 Bjoern Walk <bwalk@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org (open list:Overall KVM CPUs)
Subject: [RFC Patch 8/8] kvm: Explicitly include ARM-specific KVM UAPI headers
Date: Mon,  9 Nov 2026 18:10:34 +0100
Message-ID: <20261109171036.3806884-9-bwalk@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109171036.3806884-1-bwalk@linux.ibm.com>
References: <20261109171036.3806884-1-bwalk@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HElMnLBjmoCAmlrRjGSKhYkZWxreR1hD
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af1fec1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=A9XcaiOTLx8PdFny5PcA:9
X-Proofpoint-GUID: HElMnLBjmoCAmlrRjGSKhYkZWxreR1hD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA2NiBTYWx0ZWRfX5aBowhed7v85
 Uj0VA6JZem5T34gQpER1QokNmUNeHm6AO81Vmo7llNpQ9cQeTu5XiEggsgba8MXRr+PJ0aK8gwP
 nima0LcXCz2WdqI/tEKFpArb8iyTnwr46YxC9Nclufqva82/Gq9yoy0bjUWW44kgpn3fCHvxFsM
 b5eR+Wk3SmDjphUV8t1l0SOageCpGgvqPL8DuYkNAKlXoPKKShNsI9RSItbZFwYIrXTyI92QmvW
 aRjhmVDJExLmT/z9g8qB8DeNyaQSjjCtGXKFAC1pTg5Xi4tscnCVGOUcfcukt7g2LvIPcsvDM4U
 5t3xK0iZk5IM4qwn0PhW8GkYFcUvVGjOVrPdPiOb+uz+AFnfMrvtGXBMq99EWlqmEohHqanwSEW
 tjj3B2MGrvvFndYBvGNYsgqWOzfsHnNUdaGVymSvKnxFQb54XrXfsV+wG0S08nm2K8ImuxWhSTY
 Re/jdJ4WxlrtZ+XBn6Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA2NiBTYWx0ZWRfX4ZZa5WR2bEh9
 FQzNVsn2vRYP5OJqQbTTkuXKPvj8nSTqrAaUo2hzznxkpXGm0+LCPDYFugpa6Vi1n5OqTC6ZJVH
 zh2s4luV2Os3o1/gC9ndol1vAP48clY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090066
Received-SPF: pass client-ip=148.163.156.1; envelope-from=bwalk@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

When compiling target-specific code for TARGET_AARCH64, explicitly
include the ARM-specific KVM UAPI headers in linux-headers/asm-arm64.
This allows other platforms to build KVM-enabled qemu-system-arm64.

Signed-off-by: Bjoern Walk <bwalk@linux.ibm.com>
---
 include/system/kvm.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index 51f360cd..a78ebd5e 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -24,7 +24,11 @@
 
 #ifdef COMPILING_PER_TARGET
 # ifdef CONFIG_KVM
-#  include <asm/kvm.h>
+#  ifdef TARGET_AARCH64
+#    include <asm-arm64/kvm.h>
+#  else
+#    include <asm/kvm.h>
+#  endif
 #  include <linux/kvm.h>
 #  define CONFIG_KVM_IS_POSSIBLE
 # endif
-- 
2.56.0


