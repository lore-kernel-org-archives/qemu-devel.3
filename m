Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED51D730A3
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 05:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8XEL-0004Gg-GL; Fri, 03 Apr 2026 01:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8XEK-0004GB-1r
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 01:38:04 -0400
Received: from qs-2001e-snip4-11.eps.apple.com ([57.103.87.53]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w8XEI-0008A0-IV
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 01:38:03 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 591AB1800166; Fri, 03 Apr 2026 05:37:59 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1775194682; x=1777786682;
 bh=dugTy6Mycl0V8PO55M7zjkrIKW6irE2gkRf+Eg5CDxE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=b6FkrQ+MGNS00psbzv6dkJNhqNlbauLqeJlVmBS/6RcLNxAcJQ2V95zfakUZfvI/qPNZfSfjr+neuCoSLhdf+9NTaW7FyEK6ZMVt0S2sc3ad53SkY4CxkCI0Uu/l6nqjeXkHu11kuynZ+47HKrU9trRpklHFHzCg5jtIKig7rsRzZ+vFqT15zFgOGojy8D5JQfwegrntG+lhGCpvQZs6fiRDXQLd5MIRvvDuLG/wAeE9B2mvyGomnUWBGJDGuLmzTuVv6JWhBnQUBoitZx24hlljXLtN14W0pdLri5nezZLDmKVt6vsMV41DcsPHt1XD+hIJ3/SK4HwRMwWdPIo8/w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 8538B180010B; Fri, 03 Apr 2026 05:37:57 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v4 5/7] whpx: i386: enable x2apic by default for user-mode
 LAPIC
Date: Fri,  3 Apr 2026 07:37:46 +0200
Message-ID: <20260403053748.78831-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260403053748.78831-1-mohamed@unpredictable.fr>
References: <20260403053748.78831-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7mYZBaI-UcnubZcK2YtylfbQ2Cb4x6Fl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAzMDA0NyBTYWx0ZWRfX2bNuLO9et11c
 UTQa2XX2OuK4y+7AuEfoTaN3QeU2VVn+l8OQQD+jKQ2irtbMlDo2nOGAQ79EsmduP7WH0EmlW2n
 h/aVZ/q/Z1PZJlg3vlrFe/B86nNRLC1QfiQuIajz8E6PXEznnBQZq28fBKcAvXH9+hrDrvhRy7Z
 fLpEyz5DxvGv23L25oscxkPiYWNCKVfMjSMb8b8vElr8iB+awsvi834t3OV7sEqIcqiA9g8OX92
 T47HP9SZB0sOp+2Z86fw6OPZOSi1Yy6C6G3vGXR4vkDUdJFInZTtJcJgtgnmGPpcpSQH7WaSSUt
 hIE+TB8RHJMJ8aO5XdtLjDAPRWTVUfpKXjeC03+YPPciSffFe+cUwnJ5XvoUVo=
X-Proofpoint-GUID: 7mYZBaI-UcnubZcK2YtylfbQ2Cb4x6Fl
X-Authority-Info-Out: v=2.4 cv=VqAuwu2n c=1 sm=1 tr=0 ts=69cf5238
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=uAk9FrDoCeqUxh5yT_MA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-03_01,2026-04-02_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2604030047
Received-SPF: pass client-ip=57.103.87.53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 0908dfd134..66f263558f 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2281,11 +2281,18 @@ error:
     return ret;
 }
 
+static PropValue whpx_default_props[] = {
+    { "x2apic", "on" },
+    { NULL, NULL },
+};
+
+
 void whpx_cpu_instance_init(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
 
     host_cpu_instance_init(cpu);
+    x86_cpu_apply_props(cpu, whpx_default_props);
 }
 
 /*
-- 
2.50.1 (Apple Git-155)


