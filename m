Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB46606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=b8vaawK3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMiuN-00063u-Ou; Fri, 30 Oct 2026 05:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMiuM-00063W-TF
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 05:28:22 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMiuL-00009i-8M
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 05:28:22 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a2069b9710so3928595e9.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 02:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793352498; x=1793957298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FLpyhs9nr9cbGrghJFcrxZpDoOQ8Kt7PObKXulWTOjY=;
 b=b8vaawK313qI82U09kid0qAVZLVvKgMUASKsONGtBeQW3EvEkC9yxuJ2OzWat0B9YB
 znZOJI228Z0LE91NTZaBZzxm3Nvp26BWnegPrA8WV60KMvAJnFYvJ73hjU95fgSkZrTu
 t+ZUy6PeR4ixJWTh4QkZE0geYnPcrg88MhWMIQfugSHfV+RSgOZNCOkhiVT4m+V/BZGU
 EA65gqB4yLVuUoovAXKnArG4od4V+23+GcC2JrzpoAOoytJt7EjFoWsA5S4YfS2zPLPT
 NeWHqqmO66VSc8/QrFB/LECc/s5NIdhnAgZbeUsE2cU7jjb1JV3/c7poWUS9AoJSGtab
 utjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793352498; x=1793957298;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FLpyhs9nr9cbGrghJFcrxZpDoOQ8Kt7PObKXulWTOjY=;
 b=K0l/f3bC7Ii4wAPC7f2V6quQOkxgOkVJ1mueRuzu4HXPNbjcY/CKSTjgdzu9R9MEFj
 5taBOrCgKS9OfGTnCk0OVxC9wPdPC7MLJDxj34VoRstYspgqYnoRVyYX+mulLagilNHl
 29KPsZyIAKnNYUf81/C6b4Ro/CgnfL3obWLcIOQMpR6YjBDMIECxZJ59JA+NXLBY9Kdu
 EDotsAlsQZwBUzDab1LAQyFHjRAP4NHJx+EdycDUeOqtg37RraZt/m2MYF4PLp7ROj2a
 GS7iCanz+mZhjJuCvm6CKUz+O+ejHmo3INZVnMGTXQDw/1MfwdxBDjlX0/XJLvbY0mZK
 kGgw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxIuUtbvk2Fj+dD/maEfV1O41LZNUjiDuR4GsMb6M89ij3e3Rt6lwnZPnRSkI4quAmy+y+xDQ5NzER9@nongnu.org
X-Gm-Message-State: AFq9FYL7robAgLlR0KD8jl7pRim1v2XohFSd+tIRk8HJoJMqc/yXV3cL
 i/iQfKiEd5PdHDaUt/NloaQWN422phgZknnrP8nv+PR4sMIY8MhjcnDW0mBjI8SFU0kji1ZawYN
 dAD/JJZA=
X-Gm-Gg: AYBFou0MD2oZMvc3ctPAULNFSTjKKB2DkqJYXXDZjAOo+a2Ts3IRV9+pmR6ar3mzN1s
 cm0W1KHGJ7AO8K9OyINtScMfGuI8oB5jEH3uwhTpTU/t6cUToQbQuSnomgEAyFhF9zGX6f6bHCB
 32/Zao78n0qLO+T4msSZ3TALnPWVZKc4lJK5vioda+80CqlIHnlJQ+ryre4ULY0gfcscEVi5TcG
 QSgf263QOLAVuQghF/y+8lVOe9OvbYcD+xE7nC4XTAyNX9b5+9SKDHGSQB1O2/cOqwsXmCAuSfQ
 A8lJWarcHBXijDNPoQNRXVeD2CyoML0+Wzpa3Dl/RCVQ4dMgoK3o54SJejtGk+X4Ax8q38VoFyw
 L8Xx78KJoT39qHnyE21nlJAjEb+Z82pbeXvwDhewFo+t2mr9Z/qU41DGZf7JpZFxTfxy5ZexXCP
 xyL2mhYIee4So4juUwADSdHM34KfAMrw5ZUpLl7uhRR2AEfoxspkdQlCKqUteBr+Lygfr7fvezC
 7859TxkqjreQm/uwCdWyyCThlSBTDyfCXfm3Rdi1CzogQCJ8r7YANyE0XpyrQWSb3jaBSqXQZNg
 CoVEHQjC0DLXWsvMbUAaRwxgdF89vlv+KSsk2lCK+EEb5rhkrSqc/WKgaQDK72WRkeclHpZ1VM+
 SKik3kG9m2mWjFQJZJzVxt+uxxar8OYFnGA==
X-Received: by 2002:a05:600c:a45:b0:4a1:da58:1ee with SMTP id
 5b1f17b1804b1-4ac1932b43amr34103275e9.31.1793352497891; 
 Fri, 30 Oct 2026 02:28:17 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b7246fsm2280772f8f.19.2026.10.30.02.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 02:28:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Get HVC UNDEF cases for Secure mode right
Date: Fri, 30 Oct 2026 09:28:15 +0000
Message-ID: <20261030092815.573973-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

In the pre_hvc helper, we have a "bool secure = false" and a FIXME
comment that we should use the actual Secure state. This is a
signpost to the fact that we're not getting the UNDEF cases right.
Specifically, we get most of them correct but are missing the ones
related to Secure state:

 * For A64: HVC must UNDEF at EL1 if EL2 is not enabled in the
   current Security state

 * For v8 A32/T32, HVC must UNDEF in Secure state, if EL2 is not
   enabled in the current Security state

 * For v7, HVC must UNDEF in Secure state

The v7 requirement is identical to the v8 A32/T32 one, since
there is no Secure EL2 in v7.

This fixes a bug where HVC should have UNDEFed but instead trapped
when in Secure state with Secure EL2 disabled.  The bug is unlikely
to affect real-world code, because only test code puts itself in a
situation where HVC should UNDEF and then executes HVC and requires
it to UNDEF.

This was noticed by Coverity, because the "if (secure && ...)"
check was dead code.

CID: 1689834
Cc: qemu-stable@nongnu.org
Fixes: 35979d71c401 ("target-arm: A64: Emulate the HVC insn")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/op_helper.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 6a673e5ae6e..3d3c850a198 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -1295,8 +1295,6 @@ void HELPER(pre_hvc)(CPUARMState *env)
 {
     ARMCPU *cpu = env_archcpu(env);
     int cur_el = arm_current_el(env);
-    /* FIXME: Use actual secure state.  */
-    bool secure = false;
     bool undef;
 
     if (arm_is_psci_call(cpu, EXCP_HVC)) {
@@ -1306,6 +1304,8 @@ void HELPER(pre_hvc)(CPUARMState *env)
         return;
     }
 
+    /* Note that we have already UNDEFed HVC from EL0 at translation time */
+
     if (!arm_feature(env, ARM_FEATURE_EL2)) {
         /* If EL2 doesn't exist, HVC always UNDEFs */
         undef = true;
@@ -1316,12 +1316,19 @@ void HELPER(pre_hvc)(CPUARMState *env)
         undef = env->cp15.hcr_el2 & HCR_HCD;
     }
 
-    /* In ARMv7 and ARMv8/AArch32, HVC is undef in secure state.
-     * For ARMv8/AArch64, HVC is allowed in EL3.
-     * Note that we've already trapped HVC from EL0 at translation
-     * time.
+    /*
+     * In ARMv7 and ARMv8/AArch32, HVC is undef in Secure state if
+     * EL2 is not enabled in the current security state (which is
+     * always for Secure in v7, as Secure EL2 doesn't exist there).
+     *
+     * For ARMv8/AArch64, HVC is undef at EL1 if EL2 is not enabled in
+     * the current security state.
+     *
+     * Because we've already dealt with "EL2 not implemented" above,
+     * arm_is_el2_enabled() is effectively always true here in NonSecure,
+     * and we don't need to explicitly also check for secure/non-secure.
      */
-    if (secure && (!is_a64(env) || cur_el == 1)) {
+    if (!arm_is_el2_enabled(env) && (!is_a64(env) || cur_el == 1)) {
         undef = true;
     }
 
-- 
2.43.0


