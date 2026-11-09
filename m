Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8319F606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=YTATMwcd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQPSr-0004eI-Jh; Mon, 09 Nov 2026 08:31:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQPSY-0004d1-Ss
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 08:30:58 -0500
Received: from st-2001b-snip6-3.eps.apple.com ([2a01:b747:3001:206::17]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQPST-0004Yq-6l
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 08:30:54 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-10 (Postfix) with ESMTPS id
 768CA1801356; Mon, 09 Nov 2026 13:30:42 +0000 (UTC)
X-ICL-RepId: 01a1c081-014b-76bc-8536-f723b27e3540
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQtIBUMGWgReC0wHQwJZEhVdRV4CXwpfFV04RgNHGVcUUBtHDFUHV15fChMLU1ZHHkkKVgleCEYRWxRWQ1EZEgJaRQdNXw5eHwQXRhlVBEceXVZAGRkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4YWRtAFV0RUBlWCV4VFx5BTVoCVk0FSgNfAVoDQABJAF4HWAdeDkELWBpdHx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQE4ZDEodUlZRBUoMXABoD10dWBFd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794231044; x=1825767044;
 bh=bTKVivCfk0zPNIlppSC60Pkf3PjbfcopsoBtzEoeVMA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=YTATMwcdJk0Fz0cqnaIA3eHba0p/Z9oDRcnE8EsmPcnBSWRGSUea6YH5gyzI4/3Y6Mv+c4I+2PLrBwFiHVJpXcaP4WS9RHPKUz7v8B4j0Em61hblaAWQFQspfH3BGZozy50ijTDpz4powzWL3dLFP7PTLA2/W14fVtyFUC85HHdRdmkD2Gt1akrKmFi1MKFpHYYh/HPhh9R78pwL4Xn/b74/GwDUXjKjny0pNge4JDXhemhUVoI5KTLuglAeYP/qfUIz8krIAjFCEVfV0nwUn5EMqVJJ0Yx3lCG6g0jTJPJinX6+KSjyT70p23v4EZ1kb+SRf+5CT5wEFQslQvyY0Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-10 (Postfix) with ESMTPSA id
 6B3F2180137F; Mon, 09 Nov 2026 13:30:41 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Kostas Chatzikokolakis <kostas@chatzi.org>
Subject: [PULL 5/7] whpx: i386: forward the dynamic EBX of CPUID[0xD]
 sub-leaves 0 and 1, not 1 and 2
Date: Mon,  9 Nov 2026 06:30:33 -0700
Message-ID: <20261109133035.7985-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109133035.7985-1-mohamed@unpredictable.fr>
References: <20261109133035.7985-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1MyBTYWx0ZWRfX/8ZOgpmcqnTz
 cTMvd0/U2m5r5HkqgzKSrxwhe+mJekRz0SeHI+nWiMv8ZV96nfKEDfpS51tIZgFEhvbRcqw0ljK
 FGwHnUt74xPJqziC/34fkFezMrqmlwp51LeRuQHkgYjacUdXzodYuuHuh6O3AEgVyGEfBc+ySzm
 CX4dlUJkC4LBs5e1D1Yydfp0Kisle5BLvGurLzVOkS4g2v8psDru9Zdt4ry0DUBQ20G39QhMuON
 X42PzJGt66TSv6/LRGN3NM9rlB4AEII85ROPJNXfEojmKXt2V0yoHqcgWfitbL9xsk1W3gVqmPV
 bKO2gOvenMJDf/vvM/gZr4gOwHE0fy7vAIk8WtG5Ghi79F9zXIj+3oSPu1ZQ3g=
X-Authority-Info-Out: v=2.4 cv=Is4Tsb/g c=1 sm=1 tr=0 ts=6af1cb03
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=DGLFwGUCAAAA:8 a=RSavJFEQRcchf7d-p6oA:9 a=4cWXuvdlNTBkoNYRywza:22
X-Proofpoint-GUID: Q6uOTvBMpJ4Sx6unMCk4LB7-z0P_-tl7
X-Proofpoint-ORIG-GUID: Q6uOTvBMpJ4Sx6unMCk4LB7-z0P_-tl7
X-JNJ: AAAAAAAB3aN4D7KBIiAmnhgFjN4eo4CK+aJ3XMFREjngm5Emaxt26Hgz/qaa4/cSX4xJMm
 kOF5XCy16a6VAcm0ZcjOaQd+5a/avvKimYp5l7IKcz8iKLnDbdvkvpWxxPpaXoJ4yIX2vL
 KGv2zZccyltiYOJIDe4Nz1YVSHN9XntjJUHFlZqNjvNY3AZYkGcCg5ujWvDxmGGGswTp6F
 XHsczKhZH7dBc3tgM9bfKUP+jZn4o2w2tLrhDAFyR2MRnPamcx3Db4cxO/rrSNkqqo+g1k
 nlpTH1KrERp/wMwTkF3ZK7Fhd333/ow+kFZBMQqoYpjWe/pVtYbko3AHfQemBM5F7/BxOS
 AhJdB3IHYnKNaqAkMH20XC0NN54yDljzeuoDoNG2SQ1m9f43fhEz2gi9PFG7iY3/PXgI+f
 pr2Q5H4XsRpbRsry69fbgl4nYO6RYnWKV9YjV6gHgHz/0h08vD+Axj2q4vbAsgMGxFe6Mr
 r/31b8Z+q9JILhqnRaEJ17L25EcYsSAmiBLXcRd48HRE+JpJUEFzOvaXsadaXxnbBlI69M
 C58LyNb/Zrxr130agAhnjoSHNlRUn55Pjv1lYIB9nDozw72GtAYYiYL7C9NLi3okFnAmig
 xVmbePA0IB/cXs5bC5MjG0pPdHGCMDB5tZhPO8D1axE3Ud2MpL7Zo+I85oXDcXGgmjV2vR
 a28riSyOZFvPBZFV2dqA3yEmldn5IkZaVG4w905IiWSwxhXy6IGV0apIkIIYo7D+/XayR+
 MALTAO8AmHLyJXN8c82oYjQ7mrPj0xi5qvYgW9OWwmQdejog==
Received-SPF: pass client-ip=2a01:b747:3001:206::17;
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
index 366de31273..e14fce74d6 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2706,10 +2706,14 @@ int whpx_vcpu_run(CPUState *cpu)
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


