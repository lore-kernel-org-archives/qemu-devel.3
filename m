Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44A6F419BC
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 13:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD0JL-0007Fa-GV; Wed, 15 Apr 2026 09:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wD0JJ-0007F0-Fe
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:29:41 -0400
Received: from pv-2002j-snip4-2.eps.apple.com ([57.103.64.143]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wD0JI-00049h-4T
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 09:29:41 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPS id
 037E2180055A; Wed, 15 Apr 2026 13:29:37 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgDTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRNEwVSB11NVg1HD1geXBQXCEVDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FRgNHGVcUUBtHDFUHV15fChMAXg8PTAtIAVsHXwNFCEsBVAVdHEUBQARVGl0fHVYQUgBSD3IFVwhBCFMCUQRYGl8IGQ1AThkMSh1SVlEFSgxcAGgPXR1YEV0=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776259779; x=1778851779;
 bh=aHWbpBbWHa1pDSLj1H1tPnDt0duRVaN6KSal90efVe4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=gbXNdBDEy/BQ13OTONbZzNe385+K1nfInLssVEEtnBpp+vQRuKV7Cyq+IgYLJ7Bxh+7mWEa94kCIkK/3HU9Z54dAqLpY42PcQ2QpuXYKzwvgiAu13uzvspEFKD7mqJ2rwWc5GlrRRXXiZvpW3rRqPMzl+FLXztCT9ekIuOPxEYGm3mqOCx4dBNHkL1JLWjF/1/mboeqBl2otv7g1zIUT2WLKu4qqBYpcQ15ZG/eBpICWDhqVAXPEy+ayJlqOyFh+/eKA2Hk0Af3rTCZRLZosZ1wGYbJ+5dTOTFeW9oTI1wexAGXaBkVg0JbbR+7keC2t+fTKxJZpcukaMjtmOCZPbg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-11 (Postfix) with ESMTPSA id
 A6DE41800547; Wed, 15 Apr 2026 13:29:36 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v2 05/10] whpx: i386: ignore vpassist when kernel-irqchip=off
Date: Wed, 15 Apr 2026 15:29:21 +0200
Message-ID: <20260415132926.58878-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260415132926.58878-1-mohamed@unpredictable.fr>
References: <20260415132926.58878-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=dYqNHHXe c=1 sm=1 tr=0 ts=69df92c2
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=HmN67jXOOwgiugJlUbgA:9
X-Proofpoint-GUID: r2tKh0qUNwGwnxgqaQnQazDxFa9XdKEW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDEyNSBTYWx0ZWRfX18OH1U5ezVmw
 9EGm/77BOwNlTLFFAOG8kai34cMym0YBzSPYrl4FF6lAVfm/4F3t2OVsoKOHyLeh5EfseGG/2/7
 7RESduYi7cWARHPVgoBsZixqwAeaMxizl3Y8trAuPOe0u4bOL6M+FAN63t2qurl0oBMQzHlLSrM
 rJ/gkHDiOxYLZcVVAdjBxU4GFIDe2A7KFJEdvmBsl65Sunvr/CDQonLdufNVeeRXjsNYDVaRfTj
 VNL008K3FF7/6ztprKNUSzjtnzWK9UYlYx4zO39TA/12PzKxwbZkWFYhyPv9Pfp6qEige+ErT7t
 nbdGNLY59a+jBfMXESrWhVB5z0BfZQjx2gwj3oknHESvChrtE0zbPEso6n33Mg=
X-Proofpoint-ORIG-GUID: r2tKh0qUNwGwnxgqaQnQazDxFa9XdKEW
Received-SPF: pass client-ip=57.103.64.143;
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

Linux tries to set vpassist even when none of the enlightenments
using it are available.

So ignore the page it sets.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 6c39168b06..2e6679f40b 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -51,6 +51,7 @@
 #define HYPERV_APIC_BUS_FREQUENCY      (200000000ULL)
 /* for kernel-irqchip=off */
 #define HV_X64_MSR_APIC_FREQUENCY       0x40000023
+#define HV_X64_MSR_VP_ASSIST_PAGE       0x40000073
 
 static bool is_modern_os = true;
 
@@ -2033,6 +2034,18 @@ int whpx_vcpu_run(CPUState *cpu)
                     }
                 }
             }
+
+            /*
+             * Linux tries to use it anyway even when not exposed. 
+             * Ignore the write as the VP assist page is not used.
+             */
+            if (vcpu->exit_ctx.MsrAccess.MsrNumber == HV_X64_MSR_VP_ASSIST_PAGE
+                && vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite
+                && !whpx_irqchip_in_kernel()
+                && whpx->hyperv_enlightenments_enabled) {
+                is_known_msr = 1;
+            }
+
             /*
              * For all unsupported MSR access we:
              *     ignore writes
-- 
2.50.1 (Apple Git-155)


