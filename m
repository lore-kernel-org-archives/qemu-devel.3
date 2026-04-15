Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B55F419A5
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 13:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD0Ja-0007Iu-I5; Wed, 15 Apr 2026 09:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wD0JU-0007IY-C8
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:29:52 -0400
Received: from pv-2002h-snip4-11.eps.apple.com ([57.103.64.211]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wD0JP-0004BX-2t
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:29:51 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPS id
 EBF591800110; Wed, 15 Apr 2026 13:29:44 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgDTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRNEwVSB11NVg1HD1geXBQXCEVDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FRgNHGVcUUBtHDFUHV15fChMAXg8PTAtIAVsHXwNFCEsBVAVdHEUBQARVGloDXVQXWwxaDlYwTBZDH1IPWxNNGVEBUkVUAgdYRxRHDg8TTAtHAlo0Vh9UGVoD
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776259785; x=1778851785;
 bh=F81UdZQWjj8nDESDY+/oOdQdqEVHjVU39h+0Q6TTuPw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=R35vGqGbKtL41YvhaQEv5o3KS1lsMnYJa58KhfsQZp8f2zkBBd3plh3sZzFuf5O5BS4EfW+wBpA8B76RJYEJ4KmvYwvcQDlORmjOLIyjusMfP7H+2vOwmer8XO+TcBnOBVjJzOfqoth5YRkLhkd19N0cpkpvVs2xtnyi9FxwNl3veVSVgkWMhCuChkrO+AEHv+I1m82isbmJxh6DLKI4jxJyC6Ap665QeknEe6Y6g6VyOiVN7XZQdj1C6b64yNwRPeIGYvO6/mG23+ydaNW4qh3a78OVXlRdq7ZGUZ2DM84toXD9mYMJ3U8xVRMct1LnbXbBL7HxzSQbE+02YkrIEQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPSA id
 A30151800551; Wed, 15 Apr 2026 13:29:43 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v2 10/10] whpx: i386: set WHvX64RegisterInitialApicId
Date: Wed, 15 Apr 2026 15:29:26 +0200
Message-ID: <20260415132926.58878-11-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260415132926.58878-1-mohamed@unpredictable.fr>
References: <20260415132926.58878-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: yCr-saWD2LhDN74YXwqO_l61eqwGHhq-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDEyNSBTYWx0ZWRfXxRreJfa3vgtp
 LMKlYrQ6NnjmEeRK2f91uDTp8Q6kkt2h8GN3gJfn/tPDsn3rwv2G1dylgUgLPlmgOPsQqY7FE3/
 hwCFzCke0Kk9kUlexz7CLuxz8jH93MI8ZhMMPwYnK+ldlwLbG8Ev8tAARxO32lbW58ligGT5wWq
 mLi0mPO/P2lJkpZVud5rOh5Si+aDpy0vbWoz7zXqvlihf/Fci+Rhi2clsBZfiNnMgPWrhRbcEI8
 934QoBvgg0Q6TmEPQAjpXXQSSgUsPr3Rg6dqdviMMivUc5jDU12ADzLUC2KY7FPjGbRA0aKTVD+
 TaRiYVa5BVqVpZteFfNOB5RMrDMM5QvXM07RfXgwDYaqexIxnQZbVQrah+FHlI=
X-Proofpoint-GUID: yCr-saWD2LhDN74YXwqO_l61eqwGHhq-
X-Authority-Info-Out: v=2.4 cv=DohbOW/+ c=1 sm=1 tr=0 ts=69df92c9
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=DsSKBDvzyVHF_5agjq4A:9
Received-SPF: pass client-ip=57.103.64.211;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Keep Hyper-V aware of the initial APIC ID chosen.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 9442c240b8..62fb9b5fc1 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2398,6 +2398,11 @@ int whpx_init_vcpu(CPUState *cpu)
         goto error;
     }
 
+    if (!whpx_irqchip_in_kernel()) {
+        WHV_REGISTER_VALUE apic_id = {.Reg64 = x86_cpu->apic_state->initial_apic_id};
+        whpx_set_reg(cpu, WHvX64RegisterInitialApicId, apic_id);
+    }
+
     /*
      * vcpu's TSC frequency is either specified by user, or use the value
      * provided by Hyper-V if the former is not present. In the latter case, we
-- 
2.50.1 (Apple Git-155)


