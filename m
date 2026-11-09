Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45476606A320
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 00:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=vgBpKqHX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQDSK-0005v7-No; Sun, 08 Nov 2026 19:41:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQDRy-0005l6-9l
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 19:41:30 -0500
Received: from ci-2003b-snip6-7.eps.apple.com ([2a01:b747:3005:200::14]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQDRt-0006NF-99
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 19:41:28 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPS id
 2266D18007F3; Mon, 09 Nov 2026 00:41:19 +0000 (UTC)
X-ICL-RepId: 01a1bdc0-9be5-767e-98e9-b9dbb9da6aa6
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQtMHVUDRQtBF0AGTVIPDx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQFBfHA4YWRtAFV0RUBlWCV4VFx5BTUUID0cZEFYBWFZdBU0aXBhZDxwTUFZaDlsERxQXG1wAFxtGAgQjAl8ARQJeCVYBMBcPVk1MFkMfUg9bE00ZUQFSRVQCGRVaCQpXAEALTgJcB1ICQA1JA1UZUwdICUAeXAZGXx9RGV4IUytHHkkKVgleCEYRWxRWQ1EZDFBNAUMICghHA00XXjJTBF8RUBY=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794184880; x=1825720880;
 bh=d9reyV1jCF00VTlpnA3Dp8FbMUhLRSFOmv7Sc4XHdpc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=vgBpKqHXjJPx0B3b7RTPHT2C9V83D5WZ3+/s511ed3g5lD2Qus+igqIpizfwHYS8yMJK80MpmRJ/41AXp8K3iQiPYEByBca+u98RpQojtGGA1VP1pxVacz+eNvlUSsJD4YNcYt14XKuOv5L7ZjwIG6tjobc/dl2JR3PQCCKPFmiNENm0/FjxZDSqfYJCawT2oUZt0ga9xVhSy6mdwJpKwGihAwt6SU1lCRgfn3IAPs7ljMOU0lFeHY03FoY+rCOH/o7qVlKlg15yI4MOBMDHJjXVTjoK92ciuc7kXMj/VelG4YsTFHVcOOHPbqLfUh3MUSJcrKjaJswwE98Fv7B48Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPSA id
 301DE18007F4; Mon, 09 Nov 2026 00:41:18 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-arm@nongnu.org,
 Kostas Chatzikokolakis <kostas@chatzi.org>
Subject: [PULL 10/13] whpx: i386: forward the dynamic EBX of CPUID[0xD]
 sub-leaves 0 and 1, not 1 and 2
Date: Sun,  8 Nov 2026 17:41:05 -0700
Message-ID: <20261109004108.85808-11-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109004108.85808-1-mohamed@unpredictable.fr>
References: <20261109004108.85808-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=D8FK6/Rj c=1 sm=1 tr=0 ts=6af116af
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=DGLFwGUCAAAA:8 a=RSavJFEQRcchf7d-p6oA:9 a=4cWXuvdlNTBkoNYRywza:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAwMSBTYWx0ZWRfX8Ijaer3cba/I
 RQ/7zjoRe4isxYUif0wYufhN3hHAtD7GXqv0AR0ZkcgifDHzUcBSr3hhweghXzCOT6Kz9WjrPZn
 gzQZglFqr06PH3BdeDey34aop+Yvxy4oSf3bF/6k+4BqaZcoC2+DyNiOOHei/6B6cS9Emts5JcZ
 XygSmwKM/A+kVhi/tRffOvqtDuEnv/NQohZXu5Db7QAJEPiIBrYoV0BmDni7Diqh2YGMvM6jtLS
 XSSE8bNGv4Ih0n4JLTyY1oJVgK8KfyGSyu0fWFPH1GYFJAAB8udKxB2VziIQksYCzQubAfTG7/j
 pqCgFrFc2XF+nTcDH+XS3M3LBH5c9cYOB+jSctCqJTKuCqF4T6tYgUMFQFaGHQ=
X-Proofpoint-GUID: e2f9fth2d2SmVF0QSeAxxu8LDJg3gb4G
X-Proofpoint-ORIG-GUID: e2f9fth2d2SmVF0QSeAxxu8LDJg3gb4G
X-JNJ: AAAAAAABm2i0fKYI5uKusLHMnjOsn8y/oVdmY8Z9x+X2tnIY9CjERrAOKwHdWcOC1eTmBq
 oQPNjCr2ztdwTfd4b5pal4a7TtLz0FyNMqJg9Nom/zeKLM2bmjC8SuzfLxKF+Un5x7+eIC
 TxAqbDiJpXaFtsUzHUe93Ms1k9My2rYMy1SPJWT0O8swzPVcRHfjKDKO+pH9Y0mqqLP1ZS
 VdfGV0dNSEh0ThVhGjLFE/oJg10brntUIethKlPmAFtcPAi8XcQ9aeYtDTA/qShw1Tp0S2
 xZ1Xl84C6oRcn5NFV/jTtA+VyNsIoBiZh+k23c19R2CK2h5qOf8IOPBV6ZBJ61gX9EuTUc
 ddKNMd4inXE+Vwp0htVezZYrNa8OeEK2rimBlNRyWnIEpGK/W9Xk1cp1IrX1qyykqH4+Hs
 TjnwvqPDOqlWEn4KameuvLfwDG8+AdcSthXzLZhAhx6ynYALHoJZm0ejXTyZSfu0kS/3+Q
 yKiEIhFE+SBKrYKFOvjykYB9BUktpks0XN5oHDI0L0jdHW/JhXGxLig2tgI0cwj79KDzUY
 lVa2IUNAn0QCbVQKO3BGlgRTaUw1uPLzT0nYTsNh1tCavGv18KIBw0hcqho3zYS1JEjrxu
 wXcLdmUheMsCvzYBFrpay8l73tpzyn05CNLjE9zBEGopP0b3xUkUVk8Hc25EAr3r1nHV8b
 +ZAniTmB4qo/IeZa5RjII5lRuQtJ1+AccksQvk8RcQD+UudJwRuOj0kqmJajpg3h9j9s0e
 1JShDAIs9BHXteomogMy20VQUGRu35BE1Va4CoidSG+YT86uJjYiNSazwLN3oYBPBAdjbl
 8KLpBCnkP87MbSvkra+ubBmX8KG2CJVYIUIftidk3GxbEUiE6VlO
Received-SPF: pass client-ip=2a01:b747:3005:200::14;
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

From: Kostas Chatzikokolakis <kostas@chatzi.org>

CPUID[0xD,0].EBX is the size of the XSAVE area for the guest's current
XCR0, and CPUID[0xD,1].EBX the size for XCR0 | IA32_XSS: those are the
two values that depend on guest state. For sub-leaf 2 and up, EBX is the
component's offset in the standard format, a constant.

whpx_vcpu_run() forwards Hyper-V's DefaultResultRbx for sub-leaves 1 and
2 instead. Sub-leaf 2 is harmless: QEMU's own offset was read from
Hyper-V at vCPU init. Sub-leaf 0 is not: QEMU computes it from
env->xcr0, which WHPX refreshes only in whpx_get_registers(), never on
a CPUID exit, so after the guest's XSETBV the leaf still reports the
size for the reset XCR0, 576 bytes.

A Linux guest on a host without XSAVES takes that as its kernel XSAVE
size, fails the consistency check against the size it computed from the
component offsets, disables XSAVE and panics on the fallback path:

  XSAVE consistency problem: size 832 != kernel_size 576
  WARNING: CPU: 0 PID: 0 at arch/x86/kernel/fpu/xstate.c:638 fpu__init_system_xstate
  x86/fpu: XSAVE disabled
  BUG: kernel NULL pointer dereference, address: 0000000000000010
  RIP: 0010:fpstate_reset+0x1a/0x90
  Kernel panic - not syncing: Attempted to kill the idle task!

Every CPU model with XSAVE is affected there (-cpu max, Haswell,
SandyBridge); models without it (Westmere, Nehalem, qemu64) boot. A host
with XSAVES boots because Linux takes the compacted size from sub-leaf 1,
which is forwarded; sub-leaf 0 is stale there too.

Reproduced on an Intel Core i5-4440 (Haswell) under Windows 11 Home
build 26300 with QEMU 11.1.2 (the code is unchanged on master), guest
Linux 6.18. With this patch the guest enables xstate 0x7 at 832 bytes
and boots with -cpu max. An AMD Ryzen 9 7900X under build 26100, not
affected before, still boots with the patch, enabling 0xe7 (compacted,
2432 bytes).

Fixes: 79b3cb1f0145 ("whpx: i386: introduce proper cpuid support")
Signed-off-by: Kostas Chatzikokolakis <kostas@chatzi.org>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 2a91eabc10..8cfbc5f676 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2734,10 +2734,14 @@ int whpx_vcpu_run(CPUState *cpu)
                 }
             }
 
-            /* CPUID[0xD,{1,2}].EBX are dynamic depending on guest features. */
+            /*
+             * CPUID[0xD,{0,1}].EBX are dynamic: the XSAVE area size for the
+             * guest's current XCR0, resp. XCR0 | IA32_XSS. For sub-leaf >= 2,
+             * EBX is the component's fixed offset, which QEMU already reports.
+             */
             if (vcpu->exit_ctx.CpuidAccess.Rax == 0xd) {
-                if (vcpu->exit_ctx.CpuidAccess.Rcx == 1
-                    || vcpu->exit_ctx.CpuidAccess.Rcx == 2) {
+                if (vcpu->exit_ctx.CpuidAccess.Rcx == 0
+                    || vcpu->exit_ctx.CpuidAccess.Rcx == 1) {
                     reg_values[4].Reg64 = vcpu->exit_ctx.CpuidAccess.DefaultResultRbx;
                 }
             }
-- 
2.54.0 (Apple Git-157)


