Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50101606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WGafyVGq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQW1U-0003m3-GH; Mon, 09 Nov 2026 15:31:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bwalk@linux.ibm.com>)
 id 1xQSu8-0005Q2-Ar
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 12:11:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bwalk@linux.ibm.com>)
 id 1xQSu2-0004BE-AT
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 12:11:32 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9FujbL3699925
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 17:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=V/owMkZWcjkZ++uk2
 8pfA5Abux7CjpGVFNhaLquhmOA=; b=WGafyVGqkF12TP3qg41kG1DUq+lkj7mgh
 w4eA9KL16EzLBvq+kSAsZ9mE81rySxH17eluBbBC709MoftbfB9yg9HN+448onEC
 znB6sHpCmrySz2jzJ8mz6BbD1VF4y1wf9T4cJsvzCnRHnkMtBSzVaas3TM1zEf0h
 w+VmlJcPEXs+diXW/Qw8jQr425U+fDFOzp0lNAWa7X2rYOC9k00OqsAfctaE7c54
 bzeNbUJtsnapSIH5bF9eKbmscLcZlA2FKw0/TpomCFT+7RstUx0LuAP1FBFaP+yO
 VB8ZtPFYr72qfyXfGgcFNY6uuCDX0n2JOqaqE3BAzuzHkWaGorquQ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug5ykpn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 17:11:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9GkHFL131381
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 17:11:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hth0y1gu5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 17:11:25 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A9HBLi030671218
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Nov 2026 17:11:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A3F7D20040;
 Mon,  9 Nov 2026 17:11:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 834ED2004B;
 Mon,  9 Nov 2026 17:11:21 +0000 (GMT)
Received: from a46lp03.lnxne.boe (unknown [9.87.84.240])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Nov 2026 17:11:21 +0000 (GMT)
From: Bjoern Walk <bwalk@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Steffen Eiden <seiden@linux.ibm.com>,
 Andreas Grapentin <gra@linux.ibm.com>, Bjoern Walk <bwalk@linux.ibm.com>
Subject: [RFC Patch 1/8] hw/hyperv: Move hyperv.c to specific_ss
Date: Mon,  9 Nov 2026 18:10:27 +0100
Message-ID: <20261109171036.3806884-2-bwalk@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109171036.3806884-1-bwalk@linux.ibm.com>
References: <20261109171036.3806884-1-bwalk@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iOgNEOH9M0ixvn4iUOcs1-ENl-HtENXe
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af1febe cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=C6nCOvwwYtsPTfVKCqEA:9
X-Proofpoint-GUID: iOgNEOH9M0ixvn4iUOcs1-ENl-HtENXe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA2NiBTYWx0ZWRfXxYiv7wy0F33d
 oYUOU7FnUXajh3EeE7Lt5VbydSUzVqsej2QCQ//PnTZlM8jlQickF7qeC9xXyBkAelQkUWti3Y1
 TTe+8zhH1oaYJ2Hm0DeLdJiLCoxB9p6b8seuBlo2CqK9PXJhDWI64/gJWG3bEP+jDgYBHD3leFo
 xffQyXcwNW5a6EqF6zcZfz35r2/qIiB9cA7QIr55sNgaNZ8wKWK+Cd9Lxm/Tu2QxkpmEyKAnSyj
 Gs8+rOypEOIpFcxiE9m+0Rv8n8+qh991rBfX/+cYriBxdcAThN5VmT02i0N2/0Lq+mNGI1+Os0r
 0ZYO4S8pQ4GbJZvujLGmvXN1zLLRCOyOFeygoqmgafQJAjC518s4N7X4sn2KEF4cdO4YGL9BBhC
 AO6SNXIY3UVVmLgLyEZlba9jGNtbnusSGim3Y6hRi2rHr4kKcnrBndz3dhNiAkic6jmUQ1ix+jP
 jf2ERHC1GvqGgjyLIqw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA2NiBTYWx0ZWRfXwgM/EnDLGcnR
 1uvQcrkfkxp2/BJp4aLZjYexHXOVhZih2/MDRLOGDbQQxFE4GxCzHdgS0QXew4vD/er1fBugXa6
 0BqawnBwcXesBfQj3s6Rxk1Bzeujwys=
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

hyperv_set_event_flag_handler() uses a symbol
(KVM_HYPERV_EVENTFD_DEASSIGN) from the architecture-specific KVM UAPI
header file and therefore is target-dependent code.

Move this file to the target-dependent sourceset specific_ss.

Signed-off-by: Bjoern Walk <bwalk@linux.ibm.com>
---
 hw/hyperv/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hyperv/meson.build b/hw/hyperv/meson.build
index d1cf781f..ef5a596c 100644
--- a/hw/hyperv/meson.build
+++ b/hw/hyperv/meson.build
@@ -1,4 +1,4 @@
-system_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
+specific_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'))
 system_ss.add(when: 'CONFIG_HYPERV_TESTDEV', if_true: files('hyperv_testdev.c'))
 system_ss.add(when: 'CONFIG_VMBUS', if_true: files('vmbus.c'))
 system_ss.add(when: 'CONFIG_SYNDBG', if_true: files('syndbg.c'))
-- 
2.56.0


