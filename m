Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC19606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 00:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=xhvIeAH4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQDSC-0005pf-0K; Sun, 08 Nov 2026 19:41:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQDRy-0005l9-RC
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 19:41:30 -0500
Received: from ci-2003f-snip6-11.eps.apple.com ([2a01:b747:3005:200::3f]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQDRt-0006NE-KM
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 19:41:29 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPS id
 1A44318007F0; Mon, 09 Nov 2026 00:41:20 +0000 (UTC)
X-ICL-RepId: 01a1bdc0-a37f-7f8d-92f0-1303a107de64
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQtMHVUDRQtBF0AGTVIPDx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQFBfHA4YWRtAFV0RUBlWCV4VFx5BTUUID0YZEFYBWFZdBU0aXBhZDxwTUFZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1MFkMfUg9bE00ZUQFSRVQCGRVaCQpXAEALTgJcB1ICQA1JA1UZUwdICUAeXANGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794184882; x=1825720882;
 bh=7v5/qjKPPsvJnKcJsHDM3Cow7bRzPFGsWtpRPVq+Y+8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=xhvIeAH4017D4BLXgVPZMZHnh3DqN8NNfyXSNOLYgq9BVvAb8/hNZI5QgI3c+sdvCUlDSU2qDhd0DCNcNeXbKthHkJsjvapAAkDd4/MmAXJQRr/Yw1tOCjhYR3XG1xnNbzD0V9yW8euBIHEjDTSi2SB6KxXlzsDcV+WzvW6e9rs2hCKMkNhC9oe90wkZ528M9I192rsMnSIpsnsgzbJSS0/zxsZy8wSM7mqD0/3XsH0OuEeHWz+lZvKj7WI/G1EMEcUTkVr7OwI2gY1VO5fGRjkIyVvf0kAYtETMqW+bCEqv0puLdv5SieeDJH/1WwU+9C3ksMZBUFpozX5gYsOQNw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPSA id
 0FDF318000B6; Mon, 09 Nov 2026 00:41:20 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-arm@nongnu.org
Subject: [PULL 13/13] whpx: i386: also save debug registers
Date: Sun,  8 Nov 2026 17:41:08 -0700
Message-ID: <20261109004108.85808-14-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109004108.85808-1-mohamed@unpredictable.fr>
References: <20261109004108.85808-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: q9BjVoRJYHkvYjIW3vEBJvAC8X8CegmG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAwMSBTYWx0ZWRfX7AKFkMBGnFdB
 /dZgwuleAfzWxlnj5i/QvTHo3D5nyrnGRY+0IvvvSJ8t5WbZFvuK4Vtq/tlMeoCJ1xr/z7f+hHI
 z+pP/Z3M6b/qQQ4mJJLQD9vN8opYVcR51bcdzXlek4P7X4cQmefYC9f9gjX6qaxIvlnPjO22x9a
 qIimecLRh6QoaId8w1Xf4VbsDNkOv27WiSUdC9dBJXvkKivWCFworBjiS0zfS3jz7s6OzrN7R54
 Jrlbv/05UsGoEpxB3JNaHZmt5BAq0lo+FhW1cDWzg5hbD3OKajkFegU4tUIMx8B7tdms/0DNK2j
 qygo4MZdEZNxwxsOA3vWxLVx/D45M5jwH86MyVxqQENmKk8cgm/IhtpoDT8x98=
X-Authority-Info-Out: v=2.4 cv=X5Zf6WTe c=1 sm=1 tr=0 ts=6af116b1
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=3nrfYwkK1g5-NatN6WYA:9
X-Proofpoint-ORIG-GUID: q9BjVoRJYHkvYjIW3vEBJvAC8X8CegmG
X-JNJ: AAAAAAABtbKoyoNVKFYc5R0GBIL96dVVNNuVacyWUjDpS9lzy2qPpfYjrorlhdPyHA7b/T
 dUfSdbELueZHb5YHsQjZUgHfVWlA1qpvf5LH51Nd4Qa429L3Ym/3LTVU2SThGf2PlqrQSF
 QmcTIaxZ9w6AAZLanva1JYb1OrbdHdOG+teu3U41OsFFjvsLOmbrqUxXMeO4OzwSLj38/k
 XTe1cPUiZ0z27x9FEgAzSSPiadJebBn+dU1p7zY57J8c5rIeDJBReRZkf8/cvc1ayTzJNx
 bt5aPQ8ZwKSGok6VFskHC3iizHASUKt4CfRXOYVOwt0iOn4l31nD8t0Y1Zzcih/+702jM6
 RKB3n5RAzuufULpYnXFqi0R/tG7gNPo+NaYq7jnQDGaPOsiBGHea9jhnAgn1W6EfNWnbuT
 HA7Na9DLqxfSKQozIVmhZbykJDE4aqZFhDMBVicvxOoeHhS8SELQWkIyw5m/NHVvqI1w2S
 qQC+wDNnuXd3hO90A90HyZ4GMdSDdd21V10ady1eoPQxL4d9jJ4/iFQ95GyltlRccWDhsw
 1lCezqHuCOPWEL/y3IkNMcZz8jhJm3UArNUzgOKWQAwsqbCM9xa1SjgflJog+0s6sUck+B
 FAnlG/ZfABec2Mhgw5rRnewcAl19dnIAl2kQoNlrvYGFkD5TOAM5CVb4LeTESfFhQ1ARgm
 XH5h139ZlgZ1sA3Om73LcyLjJjlLPMiEWPXwDSy42aO7fglENs6L2n2STCZSJaPSjNFQfL
 pMNoR/HSzKmH5pFzo8I5tbTNDoqNWTA5yJELBqe0rSv53yw4iVVoLCZO2j
Received-SPF: pass client-ip=2a01:b747:3005:200::3f;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 43 +++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 19a552c456..8e2b7eaa24 100644
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


