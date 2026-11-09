Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E79606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nG50QOMa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQW1Y-0003uH-8F; Mon, 09 Nov 2026 15:31:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bwalk@linux.ibm.com>)
 id 1xQSu8-0005Q4-C9
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 12:11:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bwalk@linux.ibm.com>)
 id 1xQSu3-0004BI-As
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 12:11:35 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9G7fxd3699530; Mon, 9 Nov 2026 17:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=NI2Db3myZYr7jIHmb
 plPAw5O6X6RHNVh7C0sZqH6V50=; b=nG50QOMa4xNiweKFsAez70q88Xrs1UbHf
 x7ixwcwAjW6sLkQ+qb5TpcP/a20N8uSRbno4ILzopxVdJKD8ob9T3np6w066z0wR
 swXbtOwPTymdaAe4YGnielcymAb6b8QKDRbdCzA00osYRJtF5Nq4JHp/liDZqQUN
 2xqTuW8jnsZudZLKWOqKyttWefxC3ymHgWiL5DCH1QARWV7x1Gma327cFvPhsEll
 EQdsjr83hgBjp0popby7AN94gcL+Tj43PR0JY8rUx2FwtX7BD0vQeZsdtxMtGBJR
 f22qxDQgWi1OIP+PB4hKkgxcOE03b8oVygZspOzlriJE9PCMHnmnQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug5ykps-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 17:11:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9Gracu125959; Mon, 9 Nov 2026 17:11:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htepvt0p0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 17:11:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A9HBL8u30343446
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Nov 2026 17:11:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DA31320040;
 Mon,  9 Nov 2026 17:11:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B568520043;
 Mon,  9 Nov 2026 17:11:21 +0000 (GMT)
Received: from a46lp03.lnxne.boe (unknown [9.87.84.240])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Nov 2026 17:11:21 +0000 (GMT)
From: Bjoern Walk <bwalk@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Steffen Eiden <seiden@linux.ibm.com>,
 Andreas Grapentin <gra@linux.ibm.com>,
 Bjoern Walk <bwalk@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org (open list:Overall KVM CPUs)
Subject: [RFC Patch 2/8] kvm: Add header dependency in system/kvm.h explicitly
Date: Mon,  9 Nov 2026 18:10:28 +0100
Message-ID: <20261109171036.3806884-3-bwalk@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109171036.3806884-1-bwalk@linux.ibm.com>
References: <20261109171036.3806884-1-bwalk@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lZWsd8FnaAJInD91ztHrMwJQoyS5EhMQ
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af1febe cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=3h06E-DNddMlzqC8fRkA:9
 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: lZWsd8FnaAJInD91ztHrMwJQoyS5EhMQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA2NiBTYWx0ZWRfXyDtJtHg7aJpC
 82g0/+emDa+7JShgnTE1EASFcrnqpuUMc9jJdRpKFv2lXVFaHkZSsklT1zklses+iR5pLmk5gdF
 D59PtSnBN2EpbwMWBkNLyZ426ktEwW9CHbIRGN8iSbpag8lo/ud7C4go1xzUr+HMadXJPnj8pN9
 Fftx9b7btDvJHyaiAfz9bpYAjz+Mr22QwJEbx6L4sDQl21JZoA53zPN8WYOnrsqYVWcwl6q5YXC
 O+qvHgE9Va9qGXjHwxFKCdTLkkTk2/b4uUDesGB1yItEFX97N+N6tlhjyblRXE/Db18HR+jQH21
 qSbUFhYpXtP7UlCnd8BnGNuoqfhK5GPdMva5fhoTdwTXoTTkodk6xdfwR++q5Py7g2f1Fl65xUy
 WbV1cFGpirq8llCO3MuzLP4CjpWp9lasxRq2n1+PVZQiwHguHHgAzrAs4xiA3PkB0UQ1ptNh9qd
 up76mfoReWyy/hz8+gA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA2NiBTYWx0ZWRfX7jHVtdaDUddd
 f1e1iMyUWTe4MI6DGG+Rl8mnRWJ23s5FiDzeYxx5VxM/TlDmyJL+X13suzctHnHDG5f5iP/YXmA
 9wchwnm19wrUytK8vMavfEhQ3hQ9a8c=
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

The target-specific code in system/kvm.h requires definitions from
hw/core/cpu.h (technichally exec/vaddr.h for `vaddr` and qemu/queue.h
for QTAILQ_ENTRY).

Add the dependency explicitly to avoid headaches with unknown type names
later on.

Signed-off-by: Bjoern Walk <bwalk@linux.ibm.com>
---
 include/system/kvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/system/kvm.h b/include/system/kvm.h
index 26d55cc6..5d7c0f98 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -222,6 +222,7 @@ void kvm_irqchip_change_notify(void);
 
 #ifdef COMPILING_PER_TARGET
 #include "cpu.h"
+#include "hw/core/cpu.h"
 
 /**
  * kvm_update_guest_debug(): ensure KVM debug structures updated
-- 
2.56.0


