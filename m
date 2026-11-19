Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71E86070D1F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=bjiTp6Xx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU4EX-0001z5-KK; Thu, 19 Nov 2026 10:39:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xU4EV-0001yO-8F
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 10:39:31 -0500
Received: from mr-2003l-snip6-11.eps.apple.com ([2a01:b747:3000:202::79]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xU4ET-0003U9-5C
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 10:39:30 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-6 (Postfix) with ESMTPS id
 7057718002D7; Thu, 19 Nov 2026 15:39:23 +0000 (UTC)
X-ICL-RepId: 01a1f476-6882-7feb-a405-e2f936f7791a
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1795102765; x=1826638765;
 bh=oJaPLHcKFcRMzCllyeqWW+q7CRub4apWzsGFIJxHNCk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=bjiTp6Xx46ShnUqxDPwbWeK3jETMXbiazqdsV+zeqhwvZTvub2bC8dJMH/TLQoHsBwVBbsWdjFffGXjOy8C2mrwvHsMdmRUbuDxEfNBuAW6kBAtq3hSomSmf69EUmstTRijjZO4vMY/oGuUGzpHDxZkMD5hNoDll/ZECD4YC5meCyD16sLbEqrVcale4JHjKvQI0ef7a7242hMcjYqosWPrMxdiup/mJ38Z++kzUFzU5TwKzMUUeBKMF0NuAElpqTCOk9SVXtcIf+jS+YHeVeXLCx3gJxx7EIV3NVG+3+Cuh/XWfw7hjUSZxb1CAjywQB8Gy3VI4nFo2fz6jTkUipg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.200.36])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-6 (Postfix) with ESMTPSA id
 D196818001BA; Thu, 19 Nov 2026 15:39:21 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH] whpx: i386: only do partition reset when exposed
Date: Thu, 19 Nov 2026 16:39:18 +0100
Message-ID: <20261119153918.87662-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA2MiBTYWx0ZWRfXwTWDdlH9BGTu
 nbzgBLM81XrtwGpUkkCO8nDyXod+Mq0lAFek/oRrz5pSv/Xr2DVd8dPHJeGLmnF+wuMDPxXI4jb
 37NPf/Mb0t+0H3u8x2z1mJN9y+zTzt4RSWKZ9yu5IssoTibnDeuaRVsuqxYKd1q9wlTDwjeL8fl
 WjbVn0AaL8KjY4bdmvpAFakwcTGSnU3pFKfl1n/ig3+KOOfmOoXUFicEc6SozIvvnWApzymbPbR
 FpEVkdc8KbxSwqlZ7kEchkAtPeRpt2vGDZnQ3BGz3QNER99xd37A0FxqCuRr8F/Pdjgiu213mrl
 5z0p/OOEsfr3p/Wb63ZQZEp+y8daYhqmEwnoctqWN+6X+MTnTwvugUIzONIARQ=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA2MiBTYWx0ZWRfX0tVRt4INfQTv
 1gI7wpvh6U6TDMhWZlvc7v08KvaC+C1uAFohhkdnkoM5q1dDeoFPpF4UtOKEQyyeivXRC1h1Kdn
 vqg+qlkqJBnGn2LUMbux8udPrGWPJZs=
X-Proofpoint-GUID: v1cjd5kTUs9xW2bhaulMUXeWDP2sQETk
X-Proofpoint-ORIG-GUID: v1cjd5kTUs9xW2bhaulMUXeWDP2sQETk
X-Authority-Info-Out: v=2.4 cv=UYXE26SN c=1 sm=1 tr=0 ts=6aff182b
 cx=c_apl:c_pps:t_out a=9mRn2PO/+PIrVdEbaIuMPg==:117
 a=9mRn2PO/+PIrVdEbaIuMPg==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=fajnDIswKVxD1YtQT70F:22 a=D0kUTowvKtqSzddxsic5:22 a=p0WdMEafAAAA:8
 a=kaUFCjADoj9KmkSp3kIA:9
X-JNJ: AAAAAAABEek+O6j2xExYLv8ZMsZMI9QjdTGfGOz6wzJlVCjgR7aproluYiyQIlHmIqx3M2
 h9CZ6au9wiKkepvyGlCwjCrD4UhfCHLx7XjYmSDiZSUiSGSAQ0VBldKdR3UOsDjmFslYMz
 kpwTdjP3afpCxqRypu9M1hC7ZCiJrNcj5UDxvkdw55dPk536BILb+p5Bm9UB/bXkJbFQ7B
 Uxb83gW2T8yEMGuPeYIEZEgNI7X2GTJXi3zrHZC9MUou2WdLlP+AUvlS95EotUhkyLt040
 Io+B8kInaY8UKr1rDW5dc3ZaO/dHMlHJfXuu3WPyVNTKS+vsNd3hXrWGL2hwvaz/q7yZi1
 +yRLVmb3mmufcBms1HKJaxj11hJhsBH+5Su0Oap802ejUQDaAj/eyq/UkoDhy7BJOjoWg7
 fMLB+qXJhDYj7Q+xySJ4+c03wOl4CujBH34D9q1ywluCu+UtokMJAUGFfx68BKGp28kUve
 j8g3/YUPN991mYsC7BORPgq0vW/RLK+QGpecatTQhH9B4znIwScYQVG3uqQIT4DYxtxHuG
 83JyI0bNKug3Vn22zeDnWXae7IMK1BcnYQVxRrKHtB6o0pydYjiDXB7hrLaA/9PvOE/lfz
 WS8cl0oq6CxnOfwH4Mgk47WgQvhcgVLD147D6AOVn5KbW5vdBB0YNYZOl1bf8M7QqDFsMI
 7GZMKyewu7Mq00/LMcq02LmmweuhcGLOSUPXwZ+TgRXNMdVIZz6usElv1ZLLGKsfgDFWmz
 SFc8eVP2Q3bbC/TuRLLfLjiISrgNP/7m+zoq7fE67PXdK9Yb6CxRDQP1cXCu2hgP9gWnlP
 0FDsD9JtEAqqBshRburwzi8WEUp0gP/kLqZjBqwOTp/GqkYHetH3j4qhD9/m67mnE2r6Yt
 Dnlm48d5C6EJnpyP+Bgen+2dqoMIXdo4NTYDi3Nk4wdV2F1CzUzNSbwZ4KvEIEXPXg+wHE
 evCcAtoiMs2vCb2UKE53yWBR+qIwjHkxLaQfQmhy2tEZsDvAOK/pnT18V3cW/SAmCTU16C
 /63jknkTlk8Ep6ZLsN4Cas78zqJElOIi0EtaFgyjgnLeKlIgsiE83osv1i0uzp5fjfxoZw
 avu8FVV6lJa7iSMtGWZrwFQYOCCL628nPbM+lpXwf+UF9v648NWJHPekdo9tqOlEIq8dtM
 rif/0YE7zQFh6LGsRdFSjR26eT7cIfsWh5QPW/sdKZyqoyB0E3oA==
Received-SPF: pass client-ip=2a01:b747:3000:202::79;
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4908
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


