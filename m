Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493E7606A327
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=K3mIaR7P
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWEdV-0006tK-C1; Wed, 25 Nov 2026 10:10:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xWEdT-0006sA-Fj
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 10:10:15 -0500
Received: from mr-2006k-snip6-11.eps.apple.com ([2a01:b747:3000:204::6f]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xWEdK-0007UX-Se
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 10:10:15 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-3 (Postfix) with ESMTPS id
 9B98D180303D; Wed, 25 Nov 2026 15:09:58 +0000 (UTC)
X-ICL-RepId: 01a21341-a38e-7a4d-a0f0-4b664e8129ae
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1795619400; x=1827155400;
 bh=X6jg18f5GP38JGGPQJL6ffL4CoCWo7xBXlWCJyL+E1M=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=K3mIaR7P1IkkS6qZuFflxAU0hk86zxcviHbjE/uHuCy+AnVRzjS1HcxwQeAAQedOqSeAoGspIeVWpumEE5GCZTw5fa/BRaOBFzjchSojrBSK6qcdjf/aG2+6qgzNiAt/afJHPsk6wZ6bXbX88XgwfYnTW6vj15XmJmKOoI/FHin7RX1hnDWTqXhiuMp2hkLA417s95cHtY6zIm4rk/r83icPtqw3eD12nz2dG5inVKeVmsqrA9xtx8N8N0b6onfS4MhBkyWv6XhSjHO7iUI19sBEyMNnSlTxclPGQStzsbtVB8+LEZcLldz9NllIRyOxE/C4EX+gYjM0MMyT6YaFBw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-3 (Postfix) with ESMTPSA id
 297FF180050E; Wed, 25 Nov 2026 15:09:57 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH 1/2] whpx: i386: only do partition reset when exposed
Date: Wed, 25 Nov 2026 16:09:51 +0100
Message-ID: <20261125150952.48332-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261125150952.48332-1-mohamed@unpredictable.fr>
References: <20261125150952.48332-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ECyMYWFs0WSgdZ42uhcz6KMBi9_oBVMc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA2MCBTYWx0ZWRfX0KerkmiFwoQf
 hI7Wmiklc+hrplV3pFQa/h3Gae/6kfqi9BgVy1b8+9UjDPmFkARsy5xlbJyeoKQ9yyLr9yKHAxA
 3xJivwhLDJ/kDlqY7MvsZnZvaa/HA9p22w36xbK9oCaf0KS/zNAqlT3o51hBpSU2PTxjAudsEfZ
 RADiafSGfjzum3XvZdQm3vE8jirsW6Idlpbd6coUYqG10AW+HNmLvm/ZAZJ0ZjPq7M+kzbMtYL+
 e6huGYJ4tKxdYuE3mOVVzdSLKdnmQ3hWeGKA/QOEtGRjFSSOZNTvVaaVUe10K05J1SihIf0C8ol
 ch0WU4PD6SUOfA+i3iIcXX4l238zdGo4hkr2slsFwzgzC3cbeXJXvrmQGicy08=
X-Authority-Info-Out: v=2.4 cv=V4boQuni c=1 sm=1 tr=0 ts=6b06fa46
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=HxOO8S7qDNDRVQTpMkN7:22 a=y_sQRuLYfanAyLy2Fkar:22
 a=p0WdMEafAAAA:8 a=kaUFCjADoj9KmkSp3kIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA2MCBTYWx0ZWRfX1F4ntnbkvpWq
 WjcV1UgAOxPEmgNXsGRxcyeSg/kI2hTnzbZQGj1tyTG3nS0E3v0Mh/f9xz5lHdTI1gkcN8O7Hd8
 ohZQuuLiRcbFN2RzVVd706AEI8u4X7U=
X-Proofpoint-ORIG-GUID: ECyMYWFs0WSgdZ42uhcz6KMBi9_oBVMc
X-JNJ: AAAAAAABNAcqpAokyZ6GvpyAXAyEoelvx/zLlkMsNVBU5EjAS1ISacjMAfatYTZIi+skKM
 HZOrCJ4356sxMdNev6s00YRpgNiIAGn2pBFsTjC22H383MXn5eNs7dRHp4D2/0jmSLSjcX
 4rBWgi8K9mmw0I90mLS14yufgd1PI8kVWL8oaxnLikq41tzPWwhz+7LxHlBJ8cC8Cfnqc5
 N2Eo3chLtR9zsDvv4QquObtPQ71hkRPNC0bLiFglK4VUI9D2fCOljFrcBugwDiECKsnQCk
 OM0H7I7IvYbiwr/bAVPyIOPGsixVCWfZwTE63benAyKYShF3JQYS6oY3+ST+hTnALbDybm
 pYg3tcuZLHw3D5gugFI6nkP/gY2Km4gBIh5OuaiZTboqBnLpuKmbIF+yWcA+U05AE4SX6k
 rxAEznW0ByhuQEbpJqaTS6/O/viVXrbgIakCcMxI+lrhX+atCtn4SmuukdVxGeJckd+6DK
 h1r/WUn9fFPUakNzRcsLr88vfJwz1IbutRG6570f75Y44fpmflQL9GlBBbWYUxfTkfGY1a
 DxnEoVmV/UrY09KWYNNJaaa2xNTua4YX4eY1nCW0QMa6e7+0fO0iQtEurQjwg+/hZYB0Ir
 j93V7IW6oMi4WCYBFheuCPTd7lLg1Q16P1f2V4espVZzq2RtvPN07oOPWE2Yavrcliqh6f
 Ch+Rglj54JW172A2icOfptVxSJEKUjZR5xSSDKD7UTQiFwjYWWvPf3PCiMXxlWNf
Received-SPF: pass client-ip=2a01:b747:3000:204::6f;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

WHvResetPartition is not exposed before Windows 11 and
Windows Server 2025.

It is also not exposed on Server 2022, which passes the
legacy OS check otherwise.

As such, gate it behind availabilty of WHvResetPartition.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4908
Fixes: 6275714a ("target/i386/whpx: handle processor reset”)
Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index df1c772eb3..6c6af6c4d5 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -530,7 +530,8 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
     assert(cpu_is_stopped(cpu) || qemu_cpu_is_self(cpu));
 
     /* Assumes that cpu_synchronize_all_post_reset() runs cpu 0 first. */
-    if (level == WHPX_LEVEL_RESET_STATE && cpu->cpu_index == 0) {
+    if (whp_dispatch.WHvResetPartition &&
+        level == WHPX_LEVEL_RESET_STATE && cpu->cpu_index == 0) {
         hr = whp_dispatch.WHvResetPartition(whpx->partition);
         if (FAILED(hr)) {
             error_report("WHPX: Failed to reset partition, hr=%08lx", hr);
-- 
2.54.0 (Apple Git-157)


