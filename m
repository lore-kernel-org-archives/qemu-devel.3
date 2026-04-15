Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A98FF419BA
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 13:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD0JO-0007Hm-LC; Wed, 15 Apr 2026 09:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wD0JN-0007Hb-JT
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:29:45 -0400
Received: from pv-2002j-snip4-4.eps.apple.com ([57.103.64.145]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wD0JM-0004Aj-3p
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:29:45 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPS id
 1F3201800353; Wed, 15 Apr 2026 13:29:42 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgDTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRNEwVSB11NVg1HD1geXBQXCEVDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FRgNHGVcUUBtHDFUHV15fChMAXg8PTAtIAVsHXwNFCEsBVAVdHEUBQARVGlIfHVYQUgBSD3IFVwhBCFMCUQRYGl8IGQ1AThkMSh1SVlEFSgxcAGgPXR1YEV0=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776259782; x=1778851782;
 bh=kpBw22HzgNS+Vaq94Nw+0ZpPf3ziuI9cSWguL5NEX24=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=L6s1f+SVPlhJOiit+OzKs2vDoMOmJSMcxISGANs6OvV5VWkRf/vCsEIe9vHr0CJjpURs/Idv25n9A6cW61vpf4DroBQJzJhECe/2qIwulNrPQIsluOi5wKE9rNNueK3VLdOyay427+L41LeYDAulHTrErdFGrHJRHHMAl5LLVAKb5fR4DmEB9s6hNaz2qxBWTFzeHUxKKgqeAn1Tgp8waQjECZfVwb7H3Rq1+vMIP/UTKJkZoS5Xjbv5qnojdP7liD7CtjzMVntUGGLAzP9ls5hrFKdNTMkEHtyeWHhbC4OfrJFfwnsY1QWKZCYmvb92jrBFGF3KIb95mqRKrve3DQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPSA id
 D3BBF1800103; Wed, 15 Apr 2026 13:29:40 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v2 08/10] whpx: i386: one more CPUID
Date: Wed, 15 Apr 2026 15:29:24 +0200
Message-ID: <20260415132926.58878-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260415132926.58878-1-mohamed@unpredictable.fr>
References: <20260415132926.58878-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDEyNSBTYWx0ZWRfX3exoC3nWHdW+
 NCNtVSdBc0rBJDXrOBwHs+OFvtvAGtV7IFxeoPEcQ6PKBYly+g3SJESR/VDYcC+cYoprEdItI8q
 Y5P4DGkBdixz+basmtFyU/cyf511SoDoJm6qhn1nGD5Wcth0/ME1ZzJ9Xp6DDKsclyAWHguDcyc
 SYKxu0Qe9D1v7urIuNsflYMiQ91Tb1sxolV7/Q5OL2gtD16ruS5v2HlofVxSGM9ooPL4XSHgrTj
 a9qud5wqmbDNR9f+Uu8NsF6LZ7TKpAMdY53uakNg/cRNWTzxvG7/2ysARAfBQ6kfDuJicssNYj7
 nlJJrSPYyLZskbEDiuABbRCrUDF29QgSoYZfuQZHqI41KzTkWBwoCZ/8X75RL4=
X-Proofpoint-ORIG-GUID: KVL-c25TH60ZT2-P4avGchm8j5J3bksE
X-Authority-Info-Out: v=2.4 cv=d4/4CBjE c=1 sm=1 tr=0 ts=69df92c6
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zJD0qBlfmizEQV4F3ZsA:9
X-Proofpoint-GUID: KVL-c25TH60ZT2-P4avGchm8j5J3bksE
Received-SPF: pass client-ip=57.103.64.145;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Trap cpuid_0xb as it has x2APIC topology information.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 0b89fe093f..9442c240b8 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2527,7 +2527,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     WHV_PROCESSOR_FEATURES_BANKS processor_features;
     WHV_PROCESSOR_PERFMON_FEATURES perfmon_features;
 
-    UINT32 cpuidExitList[] = {0x0, 0x1, 0x6, 0x7, 0x14, 0x24, 0x29, 0x1E,
+    UINT32 cpuidExitList[] = {0x0, 0x1, 0x6, 0x7, 0xb, 0x14, 0x24, 0x29, 0x1E,
         0x40000000, 0x40000001, 0x40000010, 0x80000000, 0x80000001,
         0x80000002, 0x80000003, 0x80000004, 0x80000007, 0x80000008,
         0x8000000A, 0x80000021, 0x80000022, 0xC0000000, 0xC0000001};
-- 
2.50.1 (Apple Git-155)


