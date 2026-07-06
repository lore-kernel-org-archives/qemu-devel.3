Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB04C44502
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggiz-000848-OI; Mon, 06 Jul 2026 06:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggix-0007uk-4I
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:51 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggis-0003ZG-BO
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:50 -0400
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-493b691cb44so19843355e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334325; x=1783939125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+HGGi78nOgcc1s1Jm/jQsAwrzyDeNhseqGOufhXnQzs=;
 b=DSaH9pHN3oIg3AW+6fOEsfFrx0zRCF/IN/As4xWeCF9ws5ExR0JKHcXtrILrF0RAwL
 u5pPsQVSBOIE3bxrfjLrX6xge+GMFk2t3WHxuzl/sqk1NCj0dWHZ/nQ87naHpI83JQ80
 hmrLFbvf52f18fB///8oyQXirAjvYI3zEY2kGncTJH1QigMT7tWMsUEM3jsilpwGboym
 PGS0a3DKA8KmfkCsDmyaNb04mkm72tK1863mVOiyfSh6sqKvvQfPNn3icgnbK305L2hC
 kDkZKi306IpQTQ7aZ6T62nP+VtKR4gKNNu32NsAA84I7tU+uRkQLyj1fz5nNjc48Jz2D
 yd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334325; x=1783939125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+HGGi78nOgcc1s1Jm/jQsAwrzyDeNhseqGOufhXnQzs=;
 b=s963js0WPwUGneXcrJw7lup23Ucf617TiitmeFR0I81cZFrS8bPyvc9JJ/gYUKYZuV
 6eknTYjX/y0F7MyoQRcfTWcZmDExfFgD946MIvCLDfUMKxBDyfYDDMUyaIx+g+maW9sw
 peP34hc4H2nTrMD3wctr7ATwSAaBqN7L7RbI48I3lYy9gpND4vzxWurJTCge7eslqPEJ
 J9MCPaOgKd4A9IL51KOMa/4U0mO/VRDWwKLtLmKbQaqtNDHXfWGHi2mQf4W4oawyGpMd
 hh67S9YbND6zO+iJoBobq/91bFbMEamkHCBcv6AXoiVFdMxMP4PL6xo7AGG4wiYAEv8F
 4GOA==
X-Gm-Message-State: AOJu0Ywjsch/yry6T68Cez0D+scgIDLsChbnznXdlkN+jEGDp2EP4dEI
 BZC8czTB3tuV1kZ6zWgrd0LalA2TXJie5b5dKDJnULSHyvSSOIdc7dcErItSvp1ktoUBdwHuGsW
 mLNuKF7e7Q9h4
X-Gm-Gg: AfdE7ckFmAfBK9DjteQP546rv8c+Fh8MPFPpK9kXrKTRr/bx32ccUIjCwnCRW24Ogud
 dKm+QD6h4+8xoR9mIAgISrXhlxnF32n1lwx/MKNK3/ZqG5zLzIq5yde5n4+TvilRFxvLy81BGs2
 SSWHBOjpYUzz8BL1eRhlbAioWlrm3Kv3DRtD0s37DDDmTHfcfn2j9KyZp+/X09oai3aCUo6ZN4Q
 jcfXjST6c1ZwsJuW27kacnHf0pS3aermUIwbMEDaZf0w2nd6ydiwrtivlVre6K2hL0qaESLYiC0
 NMD9u/88sMcZhMj9+Gz6ADy/oDzyfD9877FXjOsv3wmvfmFy7ueC/Mi9EVbxUrFKYpDWT/iiQRt
 y0XhAQ56CgSgxUGWGIjH1prySk1PL9Wf+CLBvFFAJs1EW137+YkI1iIg792U6FbQ1HHiXUbXyVh
 UgnyOK02OuG3m3Quy5bW0FCpuwV8DqsW3msTDq1ddiF1SKlRV73tCmLwa8XVYvWEGpTUfgWS5gw
 CJY0XYDAKu3AkDl+FjB7V9uzg8huYhs
X-Received: by 2002:a05:600c:198d:b0:493:bb6b:5bb5 with SMTP id
 5b1f17b1804b1-493d11db4c1mr113865365e9.13.1783334324794; 
 Mon, 06 Jul 2026 03:38:44 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 48/49] target/arm: Report correct syndrome to AArch32 EL2 for
 trapped Neon/VFP insns
Date: Mon,  6 Jul 2026 11:37:51 +0100
Message-ID: <20260706103752.320511-49-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When an AArch32 Neon or VFP insn is trapped to AArch64 EL2, bits
[19:0] of the syndrome in ESR_EL2 are RES0.  However, when it is
trapped to AArch32 EL2, the HSR syndrome information defines some
extra fields:
 [5] : TA
 [3:0] : coproc

where the TA bit is 1 for a trapped Neon insn and 0 for a trapped
VFP insn, and the coproc field is 0b1010 when TA is 0, and 0 when
TA is 1.

We attempted to address this in commit fa33eead ("target/arm: Add
coproc parameter to syn_fp_access_trap"), but got it wrong: we
thought the RES0 condition was "is v8A" rather than "is EL2 AArch32",
and we made all insns be TA=0 coproc = 0b1010 rather than only the
VFP ones.  Correct the condition we use to decide the coproc and TA
fields.  We set these fields unconditionally; later on in
arm_cpu_do_interrupt_aarch64() we will squash them to zero if we are
taking the exception to AArch64.

NB: there is some disagreement between different revisions of the
Arm ARM about the exact handling of 'coproc':
 * the v8A Arm ARM text says coproc is 0b1010 when TA is 1
 * the v8A Arm ARM pseudocode in AArch32_CheckFPAdvSIMDTrap()
   sets coproc to 0b1010 when TA is 0
 * the v7A Arm ARM text says coproc is 0b1010 when TA is 0
 * the v7A Arm ARM pseudocode sets coproc to 0b1010 when TA is 0

The v7A Arm ARM pseudocode also disagrees with the v7A text, v8A text
and v8A pseudocode in only setting TA to 1 for traps caused by
HCPTR.TASE; the others set Ta for all trapped AdvSIMD insns
(i.e. including traps caused by HCPTR.TCP10).

We assume that the v8A pseudocode is incorrect about coproc (as it is
the odd one out) and that the v7A pseudocode is incorrect about when
TA is set (again, as it is the odd one out).

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/1153
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260702184019.3431139-4-peter.maydell@linaro.org
---
 target/arm/tcg/translate-vfp.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index 7474973952..6e944a0322 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -216,19 +216,20 @@ static void gen_update_fp_context(DisasContext *s)
  * whether VFP is enabled via FPEXC.EN: this should be true for FMXR/FMRX
  * accesses to FPSID, FPEXC, MVFR0, MVFR1, MVFR2, and false for all other insns.
  */
-static bool vfp_access_check_a(DisasContext *s, bool ignore_vfp_enabled)
+static bool vfp_access_check_a(DisasContext *s, bool ignore_vfp_enabled,
+                               bool is_neon)
 {
     if (s->fp_excp_el) {
         /*
-         * The full syndrome is only used for HSR when HCPTR traps:
-         * For v8, when TA==0, coproc is RES0.
-         * For v7, any use of a Floating-point instruction or access
-         * to a Floating-point Extension register that is trapped to
-         * Hyp mode because of a trap configured in the HCPTR sets
-         * this field to 0xA.
+         * The full syndrome is only used for HSR when HCPTR traps.
+         * When trapping to AArch64, the TA and coproc fields are RES0
+         * (we will squash them in arm_cpu_do_interrupt_aarch64()).
+         * When trapping to AArch32:
+         *  - for VFP insns, TA=0 and coproc = 0b1010
+         *  - for Neon insns, TA=1 and coproc = 0
          */
-        int coproc = arm_dc_feature(s, ARM_FEATURE_V8) ? 0 : 0xa;
-        uint32_t syn = syn_a32_fp_access_trap(1, 0xe, 0, coproc);
+        int coproc = is_neon ? 0 : 0xa;
+        uint32_t syn = syn_a32_fp_access_trap(1, 0xe, is_neon, coproc);
 
         gen_exception_insn_el(s, 0, EXCP_UDEF, syn, s->fp_excp_el);
         return false;
@@ -299,7 +300,7 @@ bool vfp_access_check(DisasContext *s)
     if (arm_dc_feature(s, ARM_FEATURE_M)) {
         return vfp_access_check_m(s, false);
     } else {
-        return vfp_access_check_a(s, false);
+        return vfp_access_check_a(s, false, false);
     }
 }
 
@@ -311,7 +312,11 @@ bool vfp_access_check(DisasContext *s)
  */
 bool neon_access_check(DisasContext *s)
 {
-    return vfp_access_check(s);
+    if (arm_dc_feature(s, ARM_FEATURE_M)) {
+        return vfp_access_check_m(s, false);
+    } else {
+        return vfp_access_check_a(s, false, true);
+    }
 }
 
 static bool trans_VSEL(DisasContext *s, arg_VSEL *a)
@@ -822,7 +827,7 @@ static bool trans_VMSR_VMRS(DisasContext *s, arg_VMSR_VMRS *a)
      * Call vfp_access_check_a() directly, because we need to tell
      * it to ignore FPEXC.EN for some register accesses.
      */
-    if (!vfp_access_check_a(s, ignore_vfp_enabled)) {
+    if (!vfp_access_check_a(s, ignore_vfp_enabled, false)) {
         return true;
     }
 
-- 
2.43.0


