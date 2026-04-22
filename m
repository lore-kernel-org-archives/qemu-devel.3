Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF1FF9B5F3
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 21:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFfLs-0008P6-At; Wed, 22 Apr 2026 17:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLp-0008Ha-Mq
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:17 -0400
Received: from p-east2-cluster1-host3-snip4-10.eps.apple.com ([57.103.76.13]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfLo-0007Pk-2N
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:17 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 7EC581800216; Wed, 22 Apr 2026 21:43:14 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAU1fDl4fBBdGGVUERx5dVkAZGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCC0oCWQVZB14LSgdfGlkHXVQXWwxaDlYwTBZDH1IPWxNNGVEBUkVUAgdYRxRHDg8TTAtHAlo0Vh9UGVoD
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776894195; x=1779486195;
 bh=fd3QXN9cMYXzSjHj8LHzGrAZcLC64tqXdSYCxl9xZqI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=CEHoBpFDLRr50nyEymGArLFSWAtXFNVq2sK7lNxYl6sbH4LjRw1UHN2/c1/N3Z/dAyLkd834FDziOrEDpqER17LxDQ/T264yiyLrO6nKTI0qA2+bWR31IyWboF6wRpz+AKiLvPMfwR28qZcKT727r5MVsc9+TjwrHvgKQZ97th3W+8ip+dm6Skf4yPsXjmk6BhVffn4X/fzMGEypLxaE3ztmE8/IWkvqJatC9dh2GM6uUHGVpdg2fGYV9TtgB/dd3Vj80bzF7iWmsIY5n3Nv4snAaYIx6kA7CH8H5Eybny564s0Al5wwd7sOGoZsc8fiwLPOxY5hgiP8istvq6BNQA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 C47551800230; Wed, 22 Apr 2026 21:43:12 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 24/37] whpx: i386: set WHvX64RegisterInitialApicId
Date: Wed, 22 Apr 2026 23:42:12 +0200
Message-ID: <20260422214225.2242-25-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260422214225.2242-1-mohamed@unpredictable.fr>
References: <20260422214225.2242-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: tj2069GRXdf3nE2mzkcE3bMZ__Y9NP_j
X-Authority-Info-Out: v=2.4 cv=QJVlhwLL c=1 sm=1 tr=0 ts=69e940f3
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=DsSKBDvzyVHF_5agjq4A:9
X-Proofpoint-ORIG-GUID: tj2069GRXdf3nE2mzkcE3bMZ__Y9NP_j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDIxMiBTYWx0ZWRfX18bwYTYbu1uw
 Oz0Z0DVreGWROmOARlXTK3Vr43TUQwMZNO2ztJ/fohf8JfxHkZQhr79Hl+Ps0mjzsmhz5HfoI30
 ts40DpxuAvG+pU7GNuNt64QQhecZy73vm++VuMMps8Zb03lHtndLSyIqyNkZi/w4Dce0LKe3+AW
 464nRfnyZ7u/r6NdH7w0tjLBIO16hoMZY5emscNA5r/mldetfYchMFxXOVrpspFHFarI9XQlgDg
 MMNpsztees6L9xwbivfG2ARZRZxL2tmQjESUOAmsmHGDY57JWD/4d80g0GqAs/KnfHK+P4ujJMo
 R45Ihe1x4k9WJ4hEAPTvilLjuiluOS6eu51LZj6p0UpCBNFJ0yBblo2CoBXQHU=
Received-SPF: pass client-ip=57.103.76.13;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Keep Hyper-V aware of the initial APIC ID chosen.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index f03f5a5115..09ca7b5a53 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2475,6 +2475,11 @@ int whpx_init_vcpu(CPUState *cpu)
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


