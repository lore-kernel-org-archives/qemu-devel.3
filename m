Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062E8C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggid-0007Ck-M1; Mon, 06 Jul 2026 06:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiM-00072o-Vl
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:15 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggiJ-0003IC-H1
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:14 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-493d3135f62so9044695e9.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334290; x=1783939090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z1Ec+hZy59GhYS7kA26UogIk7K23KCMqUXQL63N8QK4=;
 b=nKujKFHIbdPHWeJGeqvPY68IDfWx7OqFlALJpT/sYvJOiyku/Mx6UrBURO+oOreJsG
 oL3fot4+RRo+EBYDGCMMepz2tO10M5YjXQSEQWM2Bzu1OgPAghxObSUQW3ZMEYcDkIiH
 uj0WNagPfYUhLsBeLw25X+IiRh3M1V4MDsKdHvrd2Ko4TBX5EYIVH86ZVJrJ2V8sX5W5
 nNBtWEw1ZQkmQCopeZMkCKABNeYfLGFHr2MZs1+Xs500nvClKncJKpkWn2nOMbljBxKk
 wU5yxtnCE8nuvelEdOHdea2ExVqB1oS3OBAOY9mRDvj1/DhGW0066bUxG2/QQ5z6UsI1
 Am5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334290; x=1783939090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Z1Ec+hZy59GhYS7kA26UogIk7K23KCMqUXQL63N8QK4=;
 b=CjkykdNt/LSEiq2L5WC7/uHhN5DcVCeNYB1TFAnpo12Y/0mVSem8xNw1clfmwewD1S
 hZzOwE4PHA+VgYTwHPmoc3BX0Azc+FiOItHmi0xA+3hNqVAiIGJn0n1Q72M5qwlC9N28
 cFmvIA1j1gVN/+Hk662vfVaMZD7xb0O07nCn/tjOgEPSDpdxosorK0XMBFmem4KamLhw
 UA1VZbXzA3wis95RQDg3wv1bfLH3/GJnvaxojj3VsJOvCIy4X5X3D62lyBs8Aoz2aAmg
 9inbmLgQOe+++TaDznZMBDO1yUHLKsFZiyX5MyWMqzWHiQJzXSnqRfGxhqRuRHzgsXUK
 4xFA==
X-Gm-Message-State: AOJu0YzXaK+HkXzXepodW42XvvqF356Y4e/JPmKIfj9bGbqWxq+R7sgV
 0Pz6i4I+6Cvz+dQMaW2V+UJKGTpxBi6ssuOuLcosIgjucDUXm2iKFg3FFpnDvmJxZdgZVDFmfpU
 JJJ3bBhhT5A==
X-Gm-Gg: AfdE7clle2FEs95antyvYpSgPQlZSCRgwouGQS4+Qc8ji81Ur8uDs/BLERhfaCQQafb
 zd6Rde+ZIdaRqyvxC3FP4qIUNi3jj4N3emKj6jM+lU75dW7FE/umKc0NABTUS+2rAzNRiqfOu0k
 cPl1FYBnePKNo3NDjGIU7pfnmH9DRUwho15JYvHeS0zveryOiqRCLM3l/BtUyTbbqz+ULgyGmnz
 HmvZmfaDtg3Eec98BPbkaneuMqzQkLc4cXT1V/HJ8csdLpO+75gPN31SaICcAKpNGzI4SBmCaJw
 sTuS3r2qCVSc818HJhhFq+Ceoh0x1DKlGCxhB5PWvbwnH/uavIEN06CBk3Zcu4z10cY+knb5MVf
 Wvse0y+HFWIndHOjiiiVbk0UAe8BhOoDwTGdgymhiRDL7iCexytjzUT1A6WPQc0RUJS3LVPsU7L
 03cz8P4tkFw4DVx2YPhNZ85IT3MlZKrnVpv3XBHU96YLHIlHNKCIuL/3z2V3RHvKB57dmHaORmP
 BgDgVpQ0nlUPbAvK7/HAfVl/RUsMnhn
X-Received: by 2002:a05:600c:6992:b0:493:bfea:2780 with SMTP id
 5b1f17b1804b1-493d11db39cmr113125515e9.9.1783334289753; 
 Mon, 06 Jul 2026 03:38:09 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.38.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:38:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/49] target/arm: implements SEV/SEVL for all modes
Date: Mon,  6 Jul 2026 11:37:18 +0100
Message-ID: <20260706103752.320511-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alex Bennée <alex.bennee@linaro.org>

Remove the restrictions that make this a M-profile only operation and
enable the instructions for all Arm profiles.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260624103049.884930-6-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a32.decode      |  5 ++---
 target/arm/tcg/a64.decode      |  5 ++---
 target/arm/tcg/op_helper.c     |  4 +---
 target/arm/tcg/t16.decode      |  4 +---
 target/arm/tcg/t32.decode      |  4 +---
 target/arm/tcg/translate-a64.c | 17 +++++++++++++++++
 target/arm/tcg/translate.c     | 20 +++++++++++++++++---
 target/arm/tcg/translate.h     | 18 ++++++++++++++++++
 8 files changed, 59 insertions(+), 18 deletions(-)

diff --git a/target/arm/tcg/a32.decode b/target/arm/tcg/a32.decode
index f2ca480949..547aa2b149 100644
--- a/target/arm/tcg/a32.decode
+++ b/target/arm/tcg/a32.decode
@@ -192,9 +192,8 @@ SMULTT           .... 0001 0110 .... 0000 .... 1110 ....      @rd0mn
       WFE        ---- 0011 0010 0000 1111 ---- 0000 0010
       WFI        ---- 0011 0010 0000 1111 ---- 0000 0011
 
-      # TODO: Implement SEV, SEVL; may help SMP performance.
-      # SEV      ---- 0011 0010 0000 1111 ---- 0000 0100
-      # SEVL     ---- 0011 0010 0000 1111 ---- 0000 0101
+      SEV        ---- 0011 0010 0000 1111 ---- 0000 0100
+      SEVL       ---- 0011 0010 0000 1111 ---- 0000 0101
 
       ESB        ---- 0011 0010 0000 1111 ---- 0001 0000
     ]
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 5b6f156d08..b5de5d5a02 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -250,9 +250,8 @@ ERETA           1101011 0100 11111 00001 m:1 11111 11111 &reta  # ERETAA, ERETAB
     YIELD       1101 0101 0000 0011 0010 0000 001 11111
     WFE         1101 0101 0000 0011 0010 0000 010 11111
     WFI         1101 0101 0000 0011 0010 0000 011 11111
-    # We implement WFE to never block, so our SEV/SEVL are NOPs
-    # SEV       1101 0101 0000 0011 0010 0000 100 11111
-    # SEVL      1101 0101 0000 0011 0010 0000 101 11111
+    SEV         1101 0101 0000 0011 0010 0000 100 11111
+    SEVL        1101 0101 0000 0011 0010 0000 101 11111
     # Our DGL is a NOP because we don't merge memory accesses anyway.
     # DGL       1101 0101 0000 0011 0010 0000 110 11111
     XPACLRI     1101 0101 0000 0011 0010 0000 111 11111
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index 9f9ea39be5..d15062e155 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -477,9 +477,7 @@ void HELPER(sev)(CPUARMState *env)
     CPUState *cs = env_cpu(env);
     CPU_FOREACH(cs) {
         ARMCPU *target_cpu = ARM_CPU(cs);
-        if (arm_feature(&target_cpu->env, ARM_FEATURE_M)) {
-            target_cpu->env.event_register = true;
-        }
+        target_cpu->env.event_register = true;
         if (!qemu_cpu_is_self(cs)) {
             qemu_cpu_kick(cs);
         }
diff --git a/target/arm/tcg/t16.decode b/target/arm/tcg/t16.decode
index 778fbf1627..9a8f89538a 100644
--- a/target/arm/tcg/t16.decode
+++ b/target/arm/tcg/t16.decode
@@ -228,10 +228,8 @@ REVSH           1011 1010 11 ... ...            @rdm
     WFE         1011 1111 0010 0000
     WFI         1011 1111 0011 0000
 
-    # M-profile SEV is implemented.
-    # TODO: Implement SEV for other profiles, and SEVL for all profiles; may help SMP performance.
     SEV         1011 1111 0100 0000
-    # SEVL      1011 1111 0101 0000
+    SEVL        1011 1111 0101 0000
 
     # The canonical nop has the second nibble as 0000, but the whole of the
     # rest of the space is a reserved hint, behaves as nop.
diff --git a/target/arm/tcg/t32.decode b/target/arm/tcg/t32.decode
index 49b8d0037e..8ae277fe11 100644
--- a/target/arm/tcg/t32.decode
+++ b/target/arm/tcg/t32.decode
@@ -369,10 +369,8 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
         WFE      1111 0011 1010 1111 1000 0000 0000 0010
         WFI      1111 0011 1010 1111 1000 0000 0000 0011
 
-        # M-profile SEV is implemented.
-        # TODO: Implement SEV for other profiles, and SEVL for all profiles; may help SMP performance.
         SEV      1111 0011 1010 1111 1000 0000 0000 0100
-        # SEVL   1111 0011 1010 1111 1000 0000 0000 0101
+        SEVL     1111 0011 1010 1111 1000 0000 0000 0101
 
         ESB      1111 0011 1010 1111 1000 0000 0001 0000
       ]
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 2821c84843..ce2b88d3c9 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2142,6 +2142,23 @@ static bool trans_WFI(DisasContext *s, arg_WFI *a)
     return true;
 }
 
+static bool trans_SEV(DisasContext *s, arg_SEV *a)
+{
+    /*
+     * SEV is a NOP for user-mode emulation.
+     */
+#ifndef CONFIG_USER_ONLY
+    gen_helper_sev(tcg_env);
+#endif
+    return true;
+}
+
+static bool trans_SEVL(DisasContext *s, arg_SEV *a)
+{
+    gen_event_reg();
+    return true;
+}
+
 static bool trans_WFE(DisasContext *s, arg_WFI *a)
 {
     /*
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index c744b16345..9079458a29 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -3246,17 +3246,31 @@ static bool trans_YIELD(DisasContext *s, arg_YIELD *a)
 static bool trans_SEV(DisasContext *s, arg_SEV *a)
 {
     /*
-     * Currently SEV is a NOP for non-M-profile and in user-mode emulation.
-     * For system-mode M-profile, it sets the event register.
+     * SEV is a NOP for user-mode emulation. For v6T2 and earlier
+     * non-M-profile cores this encoding is a NOP hint.
      */
 #ifndef CONFIG_USER_ONLY
-    if (arm_dc_feature(s, ARM_FEATURE_M)) {
+    if (arm_dc_feature(s, ARM_FEATURE_M) ||
+        arm_dc_feature(s, ARM_FEATURE_V7)) {
         gen_helper_sev(tcg_env);
     }
 #endif
     return true;
 }
 
+static bool trans_SEVL(DisasContext *s, arg_SEV *a)
+{
+    /*
+     * SEVL only exists for v8A; for M-profile and v7A and earlier
+     * this encoding is an unallocated must-NOP hint.
+     */
+    if (!arm_dc_feature(s, ARM_FEATURE_M) &&
+        arm_dc_feature(s, ARM_FEATURE_V8)) {
+        gen_event_reg();
+    }
+    return true;
+}
+
 static bool trans_WFE(DisasContext *s, arg_WFE *a)
 {
     /*
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 462d4c1c74..83b413ee36 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -860,6 +860,24 @@ static inline void gen_restore_rmode(TCGv_i32 old, TCGv_ptr fpst)
     gen_helper_set_rmode(old, old, fpst);
 }
 
+/*
+ * Event Register signalling.
+ *
+ * A bunch of activities trigger events, we just need to latch on to
+ * true. The event eventually gets consumed by WFE/WFET.
+ *
+ * user-mode treats these as NOPs.
+ */
+
+static inline void gen_event_reg(void)
+{
+#ifndef CONFIG_USER_ONLY
+    TCGv_i32 set_event = tcg_constant_i32(1);
+    QEMU_BUILD_BUG_ON(sizeof_field(CPUARMState, event_register) != 1);
+    tcg_gen_st8_i32(set_event, tcg_env, offsetof(CPUARMState, event_register));
+#endif
+}
+
 /*
  * Helpers for implementing sets of trans_* functions.
  * Defer the implementation of NAME to FUNC, with optional extra arguments.
-- 
2.43.0


