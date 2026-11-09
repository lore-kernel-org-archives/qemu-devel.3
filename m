Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33A8606A320
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 00:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=tJGG+8A3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQDS1-0005nL-P2; Sun, 08 Nov 2026 19:41:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQDRt-0005iU-Ue
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 19:41:26 -0500
Received: from ci-2003a-snip6-1.eps.apple.com ([2a01:b747:3005:200::4]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQDRq-0006Lr-Oo
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 19:41:25 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPS id
 4C06C18001C2; Mon, 09 Nov 2026 00:41:16 +0000 (UTC)
X-ICL-RepId: 01a1bdc0-90ba-78db-bf3c-291e7c9ee0be
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQtMHVUDRQtBF0AGTVIPDx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQFBfHA4YWRtAFV0RUBlWCV4VFx5BTUUID0YZEFYBWFZdBU0aXBhZDxwTUFZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1MFkMfUg9bE00ZUQFSRVQCGRVaCQpXAEALTgJcB1ICQA1JA1UZUwdICUAeWxoGXRhYFVYJdx5cAEsdVwRUH1MSVR0dC0VVEgRACFZQVB5BBFYVbAlYBlMZVw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794184877; x=1825720877;
 bh=dQy5MNZQGFpf+JnlbA5uYVTF4e5j4IrxugNiuk+SCcI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=tJGG+8A3mm+7mxn4iyWaKrnzVxltqleDcNaKtuRqmSxy1f8YSc+hYysgHp6unDdZpuCAQZtP0Bsr6qUAHrSmWfmVOLOFr9QFQyCf2ZKCj0Wg6pzUVfgUyhKUmnKNQu3JKlcYZ5a4a/0+heL0nDPkQ2NvKtxl0+oB/Z6DLvU+K04JfyTYIxG1Ft5vzTUrrv4kf/G3EaqH3H7S4Mx44jqzjH9AfOeMG2VhWxIp3+4d1kNgPOy+WrEY//2XEAiCjft7205cuqdasWahlr3ekb1KorimAKcKJN2KTosdLGbUIySkEqgElDRc1q2NIZccBCFOMDxO2eR7MH9Q9HxaREFkxA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPSA id
 472A61800159; Mon, 09 Nov 2026 00:41:15 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-arm@nongnu.org
Subject: [PULL 05/13] whpx: i386: save/restore xss
Date: Sun,  8 Nov 2026 17:41:00 -0700
Message-ID: <20261109004108.85808-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109004108.85808-1-mohamed@unpredictable.fr>
References: <20261109004108.85808-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAwMSBTYWx0ZWRfX9UkNWO1W0bLk
 4XnuhfnOFpLAQq3Rr7wmeRsUYy3URykn/V8EP4Vz0VRexm+SuUoXwIusaw2mIhJOAuIuS5G3tLc
 DZn+Q20i0kz69iMI9Mdmhc0FjN33H7UV/vgEl17gscyuYkqm1xFYTVGfLsBTQIGtHDqxFPmeceO
 3xgFNWnMIEsJFzhw3IunWDqSpG49Jue9Ma8KCqoVzPl5mliW8B9JjoudbFGIsev+FzuVMX4qWBM
 889l0VodW9+t8Bq8IewqkFEjNqBcRwk/r8gcCSDfHK6dCXgVzfqZ1UFG9lgRprEjikFNzJT5asF
 8+UbnUU1KgrgU6BpaDLNtWEXLj8PSayVULbZDo1HrlldpVtsvbUJ6MDrVS/9Yc=
X-Proofpoint-ORIG-GUID: XT-yEaqVTsTyOCX9mCKifqKgqQ3xiMI9
X-Proofpoint-GUID: XT-yEaqVTsTyOCX9mCKifqKgqQ3xiMI9
X-Authority-Info-Out: v=2.4 cv=CLcnnBrD c=1 sm=1 tr=0 ts=6af116ac
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=vvjR5Bv0Qg6bciTORDEA:9
X-JNJ: AAAAAAABxxpKmpdtWPw07cWv8s8Sl8qJ+cgL9hca4dCVdaiTGPja/sqL0kCRELU8dD1iX6
 mFBlheZlVB+QsHeYaALLomq3sTk6GS2HBuV5JSuMBTKPW6RgWtud5JXY1ojZzDPF7fLq8/
 hAiDPbz42XvtzGYuptUJhlawIWgKv7o5tSjz3paJbOs/3vUTW+mbxsqfKrxlBniE0tlU38
 ihwQqlcdbaX5AGvzO7eshVjEgVO6as+c7wbbA2v+ZLGuDj1jrkOqqEBFlcRfhZlWecHJOZ
 hPdlpLuGZsApNcQk5JstltWJYctz8BQCqj5vFGXv7Bk3J3ZVLN9O5TgE1H8nEvctgGyLhx
 UXZ2N3tFz2Q6Z5i+wm8h8/2bBi35uWKjl20Bow4qkJQbjXfQcKTeFDfdM5+emdSa/yYxoV
 msoDZsdfm8KO2vJgwcO6Et3rTkoNn8gnwsn7ZyzOrZkXwi4Z3+ek0t0n4C1qtNK/gWnr5v
 EOUaC5DzNJNW6zdncWtothVMURH4N5h8nT756mS1ORN0EKS/w1FJolqzGkHnW65bQUAubL
 +nm9XGQ0h6ECEvzgmDZmKdGqOMrBBMRNJ3cmCc2R3ex/No6zKi3viN+T8hNbMtteLBjNmL
 wiVQcAO6Lmo+W7mwlkveGV77kfBaeq9Omg+gFv5YLz8o4ib465b1SGA30HRxauXo/bGrlp
 djDdheXOSJlx5IynkYgG3o87F2CYz/KnJyI7iDwA2GMVo6EmCVIb7pnquzcGeNTdYYTy+J
 qA2wDw9PMLYG+2pKtGH2apK/1siD5aMV28WB+yDuGWueR4eiM=
Received-SPF: pass client-ip=2a01:b747:3005:200::4;
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

More work on VM save/restore

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index f5f5c3b462..a72382c7dd 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -346,6 +346,8 @@ static void whpx_set_xcrs(CPUState *cpu)
     struct whpx_state *whpx = &whpx_global;
     WHV_REGISTER_VALUE xcr0;
     WHV_REGISTER_NAME xcr0_name = WHvX64RegisterXCr0;
+    WHV_REGISTER_VALUE xss;
+    WHV_REGISTER_NAME xss_name = WHvX64RegisterXss;
 
     if (!whpx_has_xsave()) {
         return;
@@ -358,6 +360,17 @@ static void whpx_set_xcrs(CPUState *cpu)
     if (FAILED(hr)) {
         error_report("WHPX: Failed to set register xcr0, hr=%08lx", hr);
     }
+
+    if (!whpx_has_xsaves()) {
+        return;
+    }
+
+    xss.Reg64 = cpu_env(cpu)->xss;
+    hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
+        whpx->partition, cpu->cpu_index, &xss_name, 1, &xss);
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to set register xss, hr=%08lx", hr);
+    }
 }
 
 static int whpx_set_tsc(CPUState *cpu)
@@ -691,6 +704,8 @@ static void whpx_get_xcrs(CPUState *cpu)
     struct whpx_state *whpx = &whpx_global;
     WHV_REGISTER_VALUE xcr0;
     WHV_REGISTER_NAME xcr0_name = WHvX64RegisterXCr0;
+    WHV_REGISTER_VALUE xss;
+    WHV_REGISTER_NAME xss_name = WHvX64RegisterXss;
 
     if (!whpx_has_xsave()) {
         return;
@@ -705,6 +720,19 @@ static void whpx_get_xcrs(CPUState *cpu)
     }
 
     cpu_env(cpu)->xcr0 = xcr0.Reg64;
+
+    if (!whpx_has_xsaves()) {
+        return;
+    }
+
+    hr = whp_dispatch.WHvGetVirtualProcessorRegisters(
+        whpx->partition, cpu->cpu_index, &xss_name, 1, &xss);
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to get register xss, hr=%08lx", hr);
+        return;
+    }
+
+    cpu_env(cpu)->xss = xss.Reg64;
 }
 
 static void whpx_get_registers_for_vmexit(CPUState *cpu, WHPXStateLevel level)
-- 
2.54.0 (Apple Git-157)


