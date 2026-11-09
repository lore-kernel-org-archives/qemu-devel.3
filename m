Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFA0606A325
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NxpCWySI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQW1V-0003n1-7z; Mon, 09 Nov 2026 15:31:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bwalk@linux.ibm.com>)
 id 1xQSu8-0005Q5-CG
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 12:11:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bwalk@linux.ibm.com>)
 id 1xQSu3-0004Be-Aw
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 12:11:35 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9DEgVu3699559; Mon, 9 Nov 2026 17:11:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Molzj9KIBFkG9jsFP
 42RKm1hz4YK4zayoy08bL2uPo0=; b=NxpCWySIIlrsjLJAN/McXa/lwL/nElble
 /MHTyhiCnpJOdJWMBP6y2l++63YTyOO4FEIqGSNhEaG0L1QU9qkTfjOE3/0zZ2Eh
 +sWckJ+8N7uFPDFtaUoJUSMxllVBc6Z/6SRfs4amrFekaZUyCPdJQmtkURgFD4H4
 3ogPsjS28m4sd057pDyDdrOfCaGJQ5CdpzhPEaZ3vAFZNCBiorFWcPJc1FX2QZ3F
 EzFuApbt0QnGASa2uldOgwGSe29lvMDOM0yOPZ4S0Usdr//qGFtvO7ussbnHoFJN
 nTaR5LRVlRKwKkjmmev92lX2iD5ttwHQ42ixqV3+SJBObuOb4EsXA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug5ykq5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 17:11:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9Gq4aB079625; Mon, 9 Nov 2026 17:11:27 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hteaq225q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 17:11:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A9HBNUD44564814
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Nov 2026 17:11:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E3E4D20040;
 Mon,  9 Nov 2026 17:11:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BF7102004B;
 Mon,  9 Nov 2026 17:11:23 +0000 (GMT)
Received: from a46lp03.lnxne.boe (unknown [9.87.84.240])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Nov 2026 17:11:23 +0000 (GMT)
From: Bjoern Walk <bwalk@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Steffen Eiden <seiden@linux.ibm.com>,
 Andreas Grapentin <gra@linux.ibm.com>,
 Bjoern Walk <bwalk@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org (open list:Overall KVM CPUs)
Subject: [RFC Patch 7/8] kvm: Adjust system/kvm.h for updated KVM kernel
 headers
Date: Mon,  9 Nov 2026 18:10:33 +0100
Message-ID: <20261109171036.3806884-8-bwalk@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109171036.3806884-1-bwalk@linux.ibm.com>
References: <20261109171036.3806884-1-bwalk@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mP6pKWoY_GauKBsNVWh_nUYzSaIVIDy1
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af1fec0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=uaUpoLaAEw-MedtIiS0A:9
X-Proofpoint-GUID: mP6pKWoY_GauKBsNVWh_nUYzSaIVIDy1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA2NiBTYWx0ZWRfX/EV9vu8qJL+W
 P8wqIJj380+6jq2+A95Li9tPrXs65DdVa4EiTVEGE7p5FnmkfevCQYxOfH1op10dBwET0jIE73K
 EZu4KRL9AKhSP8jYdGuioPEqfI9g5v6Ss0vn2kk5UXsuUKkGtj7G2TiA0wm+iBuwz6xcIwK7P3s
 FJFOc1WjlG1+nXgU+ag7AmI7739OjFe35OX6rroJwuLsPUQP44Pi7P+OMNmAtT9RYdKxN3dJrjV
 rk0Uc4ikeaR0rzTHILJ9MQgqWVPZdQawxGo3FVgM7UqlSvhPB+3qeyf/rm1eQYO9XKcIbcF5M+U
 zjUDYSmRBOsdX6pkELY3o79OzlEqq71DfKiZIneyAOiaI0NRXo/ufF7AtCHJV+EtTVvBKwAxvaN
 JsABx5uZwsRlQxbiHy6N40nh3y0uFPGM9CniO/0CI8lSScbklta5VWIE6X0gYy23UzUwHc5Zt58
 GI2IiH4y/3RsAEF0nwQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA2NiBTYWx0ZWRfX1cjAs5hXW9vO
 4ycwtNMUHBstNJNyqcRyeuOpKjFqoGLat5ta0VwZlULn9EDtFZPppveCmw5jWzR0iCv+1tHCkPE
 ZPO0xU1qxZ0rs4aI3a8Y+jJ7f6QT/zY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1011 adultscore=0
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

For the per-target code path which needs architecture-specific
definitions, include <asm/kvm.h>.

For the common code path, declare structs that <linux/kvm.h> consumes
from <asm/kvm.h> as empty and poison all identifiers that are size
dependent. This should allow common files to consume "system/kvm.h" with
a guarantee that there is no size inconsistency.

Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Bjoern Walk <bwalk@linux.ibm.com>
---
 include/system/kvm.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index 84c2efe9..51f360cd 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -24,12 +24,20 @@
 
 #ifdef COMPILING_PER_TARGET
 # ifdef CONFIG_KVM
+#  include <asm/kvm.h>
 #  include <linux/kvm.h>
 #  define CONFIG_KVM_IS_POSSIBLE
 # endif
 #else
 # define CONFIG_KVM_IS_POSSIBLE
+  struct kvm_debug_exit_arch {};
+  struct kvm_sync_regs {};
+  struct kvm_guest_debug_arch {};
 # include <linux/kvm.h>
+# pragma GCC poison kvm_debug_exit_arch
+# pragma GCC poison kvm_sync_regs
+# pragma GCC poison kvm_guest_debug_arch
+# pragma GCC poison kvm_guest_debug
 #endif
 
 #ifdef CONFIG_KVM_IS_POSSIBLE
-- 
2.56.0


