Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BCC606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 09:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=Bd9t+crp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPzd0-0006T2-Cq; Sun, 08 Nov 2026 04:55:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xPzbP-0005Sm-Sq
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 04:54:19 -0500
Received: from st-2004a-snip6-5.eps.apple.com ([2a01:b747:3001:201::6]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xPzbO-00060I-F4
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 04:54:19 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 38E2E18000BD; Sun, 08 Nov 2026 09:54:14 +0000 (UTC)
X-ICL-RepId: 01a1ba94-79c8-7b62-a89b-088799203eaf
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQtIBUMGWgReC0wHQwJZEhVdRV4CXwpfFV04RgNHGVcUUBtHDFUHV15fChMLU1ZHHkkKVgleCEYRWxRWQ1EZEgJaRQVNXw5eHwQXRhlVBEceXVZAGRkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4YWRtAFV0RUBlWCV4VFx5BTVoCVk0FSgNfAVoDQAFIClgDWwFeDkgLXARGA0AUFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLRhMZThtXTVoNQBlYBm0UVhVSBFk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794131657; x=1825667657;
 bh=93j8GFn2aIN5NvK8Y1HIzwXcuknIx3xv/zkmLcn737g=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Bd9t+crpMPA8yuxFcxqELciBM5ldjQfe82vl1LbAyfwAlP/iW0xe3uHLwce2eyc+evQ+iD6PmO+5FE2jbiebvZd4GzPIT4o6zYxAnfRh0fFSCFrELzld/S1W6Sz1Dy4yeO1UvrrSE4bfqJ5NWXdpzRO9h6otMxuHiVVMfnuCallgkrW3VO8Il+Wy3/vAXj+AKJkygLiBCRIYNNmqJFuKRdw0NS6G4K4Q1uC0TwW4+YQmyFIBxDn5aLTDlXk1VYn35IDnzptyQLtYNPvHVfIhHHPThznjgHT2AHcj/lG+M+1lV69S0L4KXi/xXkMrVZF/FZ7SApjtwz9Hn+0d+CPuJg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 BB7C718001A4; Sun, 08 Nov 2026 09:54:13 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 09/13] target/arm/whpx: handle processor reset
Date: Sun,  8 Nov 2026 02:53:59 -0700
Message-ID: <20261108095403.70813-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261108095403.70813-1-mohamed@unpredictable.fr>
References: <20261108095403.70813-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Zn6bl-RxyLvFymU4LsrV4YRVzAu14g7m
X-Authority-Info-Out: v=2.4 cv=K60v3iWI c=1 sm=1 tr=0 ts=6af046c8
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=loPyruWHUH_f1C729x8A:9
X-Proofpoint-ORIG-GUID: Zn6bl-RxyLvFymU4LsrV4YRVzAu14g7m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDAzOSBTYWx0ZWRfX3MOk0sJt/4o8
 Fat1qizeLrIs8IpcyDF8cCGzgakeRTZtJwRSbsnv/wJy8o91Tz3KY3CaxZUk9AmeQHsqq6xbFDE
 NmW04t/Uakol5wim/skQIj3k6RaiuGzIjSOnd0lXW5qlQAUA+Hp2tSwXZL86z4/vcwtabEqUgsW
 UTQfg8FZ6iVUak9Y2S7aPa15kZ9864gkx/qaV7nPfTC+WTlUI4qhM4JwXpu4JuVubOpbKjeRU4r
 8+nJFoXnMm867ZBvlL+J56l12g3V3nUzTvw0nKYe0Lc+Vgz5IIHWy3Tt2N734S5yz4yh05kRTHE
 oF9Ot/Q9Wvm9KxFxk3EB5yPbKHFHXHIORdX4lW6bepyt2XwdT60BlvaVGp8nbs=
X-JNJ: AAAAAAAB3/2PySQ5LpzXSkDt9Rx19MNSkHTAXZe9kq78WHGCvVfaKgpKOAYUtv5HjuA/wY
 183+iUIkHHKKa2ud8JsL9loXnj6qG+ijQPFidCzeK9uGFGjZSo44uc7rtpOsxaXa+BY1q2
 cJP0WNMC1Sa57zjou5oRGP5Ey9j/tUUbx/RSo9byxT62R4BZcDGHxHumZwU7t/Rd7L3Evi
 MA9awvoY+S7r7vpPJryoJCHGWO5X/Rtk3++aMOEhD6kJrQK2MIzwAUMSF/NKs5I6j+CFgn
 2ur0Tk9nBDYfw05RhsBY5f/G6+PkOUOow1iEMG+G0HumM8NYBwfIzPrxqsFYZ3cPycEmpj
 VRDe1JYge2JpdxYTposcsQOG0urclQw5IqS4U1JptvCaiJoTllAvsUGh5okRYSKj9q5WOp
 7RSMwFmS2SlFSE3DhTBVjbY2xAVbhsvLJ1rHGvgTImcqmnXSoesVaCLW2KtuCJNc+rOpl+
 BEqbZ8ZSBpV1xKjRobNTAMpepET4I4ID+XgLvlu1yWg40sLtfH6y0wQUJ6Wy/renDLTHob
 pz3o2EUYKuRNiL1EMDD16hgv8o+LUBDmKK6TNFhfFD4rBdDhaa51oqVn00Gb6SfWYfH0UE
 VtgpoHxf3xQ5ZyOsRf3JO+gAVg5/1tyWpbmNSt2bqbunpbd9RnG8VOI4As1QCouXQbIuVK
 psh9YYYrJoCadIgry/5hvC9S1c1vGgqVzzN0h9Bz8k1vy7dE9ErZgXnxYFrvZDHqEHjBg2
 FSBU1oHRJk6mCVQmPlIxtP
Received-SPF: pass client-ip=2a01:b747:3001:201::6;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move WHvResetPartition to where it's effective on multi-core configurations.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/whpx/whpx-all.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 46f0b9524e..150a6326d7 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -471,8 +471,6 @@ int whpx_vcpu_run(CPUState *cpu)
             if (arm_cpu->power_state != PSCI_OFF) {
                 whpx_psci_cpu_off(arm_cpu);
             }
-            /* Partition-wide reset, to reset state for reboots to succeed. */
-            whp_dispatch.WHvResetPartition(whpx->partition);
             bql_unlock();
             break;
         case WHvRunVpExitReasonNone:
@@ -573,6 +571,14 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
 
     assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
 
+    /* Assumes that cpu_synchronize_all_post_reset() runs cpu 0 first. */
+    if (level == WHPX_LEVEL_RESET_STATE && cpu->cpu_index == 0) {
+        hr = whp_dispatch.WHvResetPartition(whpx->partition);
+        if (FAILED(hr)) {
+            error_report("WHPX: Failed to reset partition, hr=%08lx", hr);
+        }
+    }
+
     for (i = 0; i < ARRAY_SIZE(whpx_reg_match); i++) {
         val.Reg64 = *(uint64_t *)((char *)env + whpx_reg_match[i].offset);
         whpx_set_reg(cpu, whpx_reg_match[i].reg, val);
-- 
2.54.0 (Apple Git-157)


