Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D94606A320
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=cPpajoO/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPzbm-0005XN-8r; Sun, 08 Nov 2026 04:54:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xPzbS-0005TW-2V
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 04:54:22 -0500
Received: from st-2004h-snip6-7.eps.apple.com ([2a01:b747:3001:201::4e]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xPzbQ-00061K-G2
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 04:54:21 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 3F6C918001A4; Sun, 08 Nov 2026 09:54:18 +0000 (UTC)
X-ICL-RepId: 01a1ba94-85bd-7951-9aa7-6b18ccb1ade4
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQtIBUMGWgReC0wHQwJZEhVdRV4CXwpfFV04RgNHGVcUUBtHDFUHV15fChMLU1ZHHkkKVgleCEYRWxRWQ1EZEgJaRQVNXw5eHwQXRhlVBEceXVZAGRkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4YWRtAFV0RUBlWCV4VFx5BTVoCVk0FSgNfAVoDQAFIClgDWwFeDkgLXARGA0QUFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLRhMZThtXTVoNQBlYBm0UVhVSBFk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794131659; x=1825667659;
 bh=HQf0TzrDLzAsn93+AHhIDicyMKzXLCj79qsA4L0ue0k=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=cPpajoO/FHe658PfCTtTS8dM7VWGXtYeuKfXezmnWJQIDJL3WmF07X/IL5D5+wG2FJOGlVSSSXclS54H5Ck0VP6haoaJiaCS+tnn5DgvRkChiOexDxJ3j3LYMiKC3OeufhDNx3OKV97N4Ec10jBefbPNZptNTcoLoa2SNuy4AKvaGBPTZ7HyJpRCE9D77W9uQ1RYkgbfXn5tsD6VzicHxrF7fZm0+cRezkSQHT6ipOcLJRUszTZ3/fSbKthvbwK4e0YUD0eThIkfRrhSH24EUJTVmPvwyJhLUrsJKQn3sYQex6jFJtSaeQi8H3xIYW1hQPEPr7+3NLGzR4wrsM0CPw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 0960B18000CB; Sun, 08 Nov 2026 09:54:16 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 13/13] whpx: i386: also save debug registers
Date: Sun,  8 Nov 2026 02:54:03 -0700
Message-ID: <20261108095403.70813-14-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261108095403.70813-1-mohamed@unpredictable.fr>
References: <20261108095403.70813-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: fIZig3DwwmqliSiQWWPblc25xJa-3Yvo
X-Authority-Info-Out: v=2.4 cv=IaKKmGqa c=1 sm=1 tr=0 ts=6af046ca
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=3nrfYwkK1g5-NatN6WYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDAzOSBTYWx0ZWRfX6KZsA7fG9ffl
 3WyGyG3I6GF4pRRsMurWPhewufLvgkXEnKNz4hc0FHc2e7OMUhXuc+ypLn5x2fY++NaTcVY+swf
 PwbgmUiCsQC1+bfLtVGk/sFkuK3bEXJd6f7Z0qql/0iAso1e+417lO2GOt8T7NLkAOL+QGEHcyU
 NXh4iw/pyl0Ck8KUBDTVEW9ppYGzNLFamQp/XWf/SFgDLe9kfVTA/YtyMK9ws66QW1eKz9SU3R7
 p2m94rOBd5jVr6YMrYa11xQ85OHU9oTBMfQ419O/PDhFFdXSVoA3iqH7V88V3XBG4DgOd4JbfQ7
 ZMG8wSRPHHSupLAk42yqKh57VwrydUmhpnq06Y93WDGNWza4p5rxxByW5R4I5o=
X-Proofpoint-GUID: fIZig3DwwmqliSiQWWPblc25xJa-3Yvo
X-JNJ: AAAAAAABoR+c4vsn8j3DnTxz3hrkr+809dv1V/DcsrICZCQP6VkPmix9BtpFYqxQG75jCH
 vKHyypYumqXBrk4vpZ5N37bKFhmBBmsEA01AIatI70qjXNLdKXIwb7XanST8h/sU73/kA1
 GgFuxP7yesRxlHSLhHphJ2eJCLlVuTnqqa5lJCml9IpYpLV2Q/a1xhs+mHgnGZ7XFm9K/H
 4R76dTH+CWVWxMStwwL7g4qrYEW/K/1Cy+Vy9VwItgLib8WFM5rhZrDqw1lkOdBDYtD4h6
 /D+IAMbI1Dx9Tkmp3ZBa5qjcBeRDL4/sMQir9x+n9PHiw1IL5KAImrLnULZaCJ4Qwqb+nT
 5DIToPFtQrb4OIZVV/d+ANPLyr2SBWwuoHDX5nVZ7CWeY61ci9UXkFmX+TfQIrraXj7w+M
 aHnM1hwiWHnEi7JsuuBFnX1AO80f6E6VJBM4p333bD5d6FkZLAmv56I/jxrhTG+tbo4dUm
 6r/1pjJ0Bg+eX2yaL5cBGgLnF6iUF6eSMb2XWxr/Pk6k6trfOGm7fhklYPZCAfb8FGO1Ol
 cqvv60mukx6mpJgcajNqUaGRxtE6wPxfq+v5vvk9q9nS93hYBVm3mM7GnBmFuzaEMkzNCB
 Egcjs1bgDmXHsCcJxeE60ufXl5urd6tQvKhwQJOEFATzUn6nApD5osBjz3zVPRFc3i7nvJ
 ypyUHZwCiBBCpPXRd9d+5tFJcioFaq+B67tMWa/yGziNDA4f2bv3M1C2dbasXV479ZtbIY
 CIhTr8JiHh77NAvyvDrlsY0SO1F5enOKHc/sdz+wUwl6Q0Wpd3Y1ENr41bn5lsIcDgZU7Q
Received-SPF: pass client-ip=2a01:b747:3001:201::4e;
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 43 +++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 7a41ab1542..4bde9724c6 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -101,16 +101,6 @@ static const WHV_REGISTER_NAME whpx_register_names[] = {
     WHvX64RegisterCr3,
     WHvX64RegisterCr4,
 
-    /* X64 Debug Registers */
-    /*
-     * WHvX64RegisterDr0,
-     * WHvX64RegisterDr1,
-     * WHvX64RegisterDr2,
-     * WHvX64RegisterDr3,
-     * WHvX64RegisterDr6,
-     * WHvX64RegisterDr7,
-     */
-
     /* X64 MSRs */
     WHvX64RegisterEfer,
 #ifdef TARGET_X86_64
@@ -126,7 +116,12 @@ static const WHV_REGISTER_NAME whpx_register_names[] = {
     WHvX64RegisterCstar,
     WHvX64RegisterSfmask,
 #endif
-
+    WHvX64RegisterDr0,
+    WHvX64RegisterDr1,
+    WHvX64RegisterDr2,
+    WHvX64RegisterDr3,
+    WHvX64RegisterDr6,
+    WHvX64RegisterDr7
     /* Interrupt / Event Registers */
     /*
      * WHvRegisterPendingInterruption,
@@ -686,6 +681,19 @@ void whpx_set_registers(CPUState *cpu, WHPXStateLevel level)
         vcxt.values[idx++].Reg64 = env->fmask;
 #endif
 
+        assert(whpx_register_names[idx] == WHvX64RegisterDr0);
+        vcxt.values[idx++].Reg64 = env->dr[0];
+        assert(whpx_register_names[idx] == WHvX64RegisterDr1);
+        vcxt.values[idx++].Reg64 = env->dr[1];
+        assert(whpx_register_names[idx] == WHvX64RegisterDr2);
+        vcxt.values[idx++].Reg64 = env->dr[2];
+        assert(whpx_register_names[idx] == WHvX64RegisterDr3);
+        vcxt.values[idx++].Reg64 = env->dr[3];
+        assert(whpx_register_names[idx] == WHvX64RegisterDr6);
+        vcxt.values[idx++].Reg64 = env->dr[6];
+        assert(whpx_register_names[idx] == WHvX64RegisterDr7);
+        vcxt.values[idx++].Reg64 = env->dr[7];
+
         /* Interrupt / Event Registers - Skipped */
 
         assert(idx == RTL_NUMBER_OF(whpx_register_names));
@@ -1070,6 +1078,19 @@ void whpx_get_registers(CPUState *cpu, WHPXStateLevel level)
     env->fmask = vcxt.values[idx++].Reg64;
 #endif
 
+    assert(whpx_register_names[idx] == WHvX64RegisterDr0);
+    env->dr[0] = vcxt.values[idx++].Reg64;
+    assert(whpx_register_names[idx] == WHvX64RegisterDr1);
+    env->dr[1] = vcxt.values[idx++].Reg64;
+    assert(whpx_register_names[idx] == WHvX64RegisterDr2);
+    env->dr[2] = vcxt.values[idx++].Reg64;
+    assert(whpx_register_names[idx] == WHvX64RegisterDr3);
+    env->dr[3] = vcxt.values[idx++].Reg64;
+    assert(whpx_register_names[idx] == WHvX64RegisterDr6);
+    env->dr[6] = vcxt.values[idx++].Reg64;
+    assert(whpx_register_names[idx] == WHvX64RegisterDr7);
+    env->dr[7] = vcxt.values[idx++].Reg64;
+
     /* Interrupt / Event Registers - Skipped */
 
     assert(idx == RTL_NUMBER_OF(whpx_register_names));
-- 
2.54.0 (Apple Git-157)


