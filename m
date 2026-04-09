Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E38E98FAA
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 03:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAgPj-0000hY-Mu; Wed, 08 Apr 2026 23:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wAgPi-0000gQ-4n
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 23:50:42 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wAgPg-0003tM-DN
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 23:50:41 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c6e2355739dso197756a12.2
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 20:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775706639; x=1776311439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kcgoIr708tkn1serDSc8foai5KtjEdBhFQtOKk6QjDo=;
 b=Hhepclhr4MQKnRd+yhPqCFhg2j4WNQQgOYE4H0BeGYkCoTLESTpnXxCxP0NV2gGD4F
 9JR5oHpRVYR22C4ACf83q9wyya8B+AGgWBPttAuA7dwQ1Z0sluCKGW18bXI8p4Asn6UX
 zqmcZFC4I3uqrgeYjOSeXuPLa7dqfYLQ8FcUSzJ+uu4nUDo1pwMR889Vm6AhrQ3hI1SL
 T/8tTBIYyGADxkKP9aQ0Q07ZLBJ6TnjA2V6Zl3CrZlADtUtw5XgZw0oPjElXuvqQzkRx
 u+QHMIar4/mrTCBHQSmREIL+fBwf6ed+5KzUXsu6SLjRVxuHrdOEQDzZAnd+zXj/IUmH
 TNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775706639; x=1776311439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kcgoIr708tkn1serDSc8foai5KtjEdBhFQtOKk6QjDo=;
 b=Eu4R4ANj0HvCdcX1qfh/J1UJqpLPLg2p0QtgFxYFFOaBpSvOHXnUoJAGxiKNmBhSE6
 7v4YUxqnWR+dzLwxiVAG967at3/25W94qUK/s+AIURtRyXNBzJ+TiGBOhF1hgvIIxBNu
 OAjPiLY+vlWKYx19nE31hBjqwabZe+5HSvPKjv4iTZex47E5LaFPTxkRRBDCB93xdneU
 G3pn3xpL8OU5HY5eA27EDoAgjZA/lRAjh+S8xSCdQRi8uSgugOegmTP6v45t4m8Me21x
 +lNuswW+YIgBTv+WpaPNjNSN5zmTEra/yJS26PEWhNWxOHttvCVvyg/Qj5x2i1TJnzPj
 xggQ==
X-Gm-Message-State: AOJu0YwZAa1lAxdaIQERcZ156ZVNzJtYzAgF/yjwPa8VTiBT1uepMPbQ
 G0b5X2wDiMFXHsslD+NH1+5+3Utz5XxSo7i2mw39KNgThwbYTpUnGjZrXfbXhFem3sweeFRYZli
 IdZ0pc4w=
X-Gm-Gg: AeBDiesvIhOxKd8Df03DX4tQPt9ieodQ8vKwnUHdcFphS1R3BiT1xX3qOeTobfBrMk0
 P/cUREEXdM7OxLdv6iTJIN15/celFPs/YefQ43nLOARzGzINsnvKPq3fnJgalXdeHr1+4VIx0/w
 24j7mqP4B+fUvDBjsorAyQeW1edAHFs3KQ83gPp9TLsJE0SzJ4YRk/fmYwNmqFynybaFF930uPN
 acRrqn6eEsm/pDDH81MzRqidmO3J3do20VofMv415xRoqjgsHB58Sv5+Jaqwwl/yONt9wZ1Ko94
 te8BBTXU8XvBTnpwg1Q1G/ZWj2ucaGB2kYjT4MRu9D4sUxwUPDMH8Vm2GF2B327g7t+oCEblFTG
 rYnYDcI58xxftLp2/m/661PLtpiZC2yC0DSOz8hORfrnLwMAOVkOzxIxCw0GjBMnKzMI0SvV1e5
 jjK6sIvgb6wrgvKGlLq/a/PhNcdb39ewyKIl5vREQHMXLYKMzsgiKM0dtx
X-Received: by 2002:a17:902:ccc9:b0:2b2:539b:d2b1 with SMTP id
 d9443c01a7336-2b2816cfd51mr247559615ad.16.1775706638838; 
 Wed, 08 Apr 2026 20:50:38 -0700 (PDT)
Received: from stoup.. (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2745c480dsm277830605ad.0.2026.04.08.20.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 20:50:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org
Subject: [PATCH v2 5/7] target/arm: Recognize linux faux BPKT
Date: Thu,  9 Apr 2026 13:50:13 +1000
Message-ID: <20260409035015.132370-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260409035015.132370-1-richard.henderson@linaro.org>
References: <20260409035015.132370-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

It is easier to recognize the insn from decodetree than it
is from cpu_loop.  In particular, there is a BE32 bug in
how we rebuild thumb2 insns in get_user_code_u32.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/arm/cpu_loop.c  | 28 ----------------------------
 target/arm/tcg/translate.c | 17 +++++++++++++++++
 target/arm/tcg/a32.decode  |  5 ++++-
 target/arm/tcg/t16.decode  |  1 +
 target/arm/tcg/t32.decode  |  5 ++++-
 5 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
index 86f13ad83a..4f7c5dab9c 100644
--- a/linux-user/arm/cpu_loop.c
+++ b/linux-user/arm/cpu_loop.c
@@ -194,24 +194,6 @@ do_kernel_trap(CPUARMState *env)
     return 0;
 }
 
-static bool insn_is_linux_bkpt(uint32_t opcode, bool is_thumb)
-{
-    /*
-     * Return true if this insn is one of the three magic UDF insns
-     * which the kernel treats as breakpoint insns.
-     */
-    if (!is_thumb) {
-        return (opcode & 0x0fffffff) == 0x07f001f0;
-    } else {
-        /*
-         * Note that we get the two halves of the 32-bit T32 insn
-         * in the opposite order to the value the kernel uses in
-         * its undef_hook struct.
-         */
-        return ((opcode & 0xffff) == 0xde01) || (opcode == 0xa000f7f0);
-    }
-}
-
 static bool emulate_arm_fpa11(CPUARMState *env, uint32_t opcode)
 {
     TaskState *ts = get_task_state(env_cpu(env));
@@ -291,16 +273,6 @@ void cpu_loop(CPUARMState *env)
                 /* FIXME - what to do if get_user() fails? */
                 get_user_code_u32(opcode, env->regs[15], env);
 
-                /*
-                 * The Linux kernel treats some UDF patterns specially
-                 * to use as breakpoints (instead of the architectural
-                 * bkpt insn). These should trigger a SIGTRAP rather
-                 * than SIGILL.
-                 */
-                if (insn_is_linux_bkpt(opcode, env->thumb)) {
-                    goto excp_debug;
-                }
-
                 if (!env->thumb && emulate_arm_fpa11(env, opcode)) {
                     break;
                 }
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index ec21e33a06..0447be0907 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -4508,6 +4508,23 @@ static bool trans_BFCI(DisasContext *s, arg_BFCI *a)
     return true;
 }
 
+static bool trans_LINUX_BKPT(DisasContext *s, arg_LINUX_BKPT *a)
+{
+#ifdef CONFIG_USER_ONLY
+# ifdef CONFIG_LINUX
+    /*
+     * The Linux kernel recognizes 3 UDF patterns as breakpoints.
+     * Recognizing these during translate is much less error prone
+     * than deferring to cpu_loop.
+     */
+    gen_exception_bkpt_insn(s, 0);
+    return true;
+# endif
+#endif
+    /* Fall through to UDF. */
+    return false;
+}
+
 static bool trans_UDF(DisasContext *s, arg_UDF *a)
 {
     unallocated_encoding(s);
diff --git a/target/arm/tcg/a32.decode b/target/arm/tcg/a32.decode
index f2ca480949..c7e8e9803e 100644
--- a/target/arm/tcg/a32.decode
+++ b/target/arm/tcg/a32.decode
@@ -425,7 +425,10 @@ BFCI             ---- 0111 110 msb:5 rd:4 lsb:5 001 rn:4      &bfi
 
 # While we could get UDEF by not including this, add the pattern for
 # documentation and to conflict with any other typos in this file.
-UDF              1110 0111 1111 ---- ---- ---- 1111 ----
+{
+  LINUX_BKPT     1110 0111 1111 0000 0000 0001 1111 0000
+  UDF            1110 0111 1111 ---- ---- ---- 1111 ----
+}
 
 # Parallel addition and subtraction
 
diff --git a/target/arm/tcg/t16.decode b/target/arm/tcg/t16.decode
index 778fbf1627..836e929684 100644
--- a/target/arm/tcg/t16.decode
+++ b/target/arm/tcg/t16.decode
@@ -263,6 +263,7 @@ LDM_t16         1011 110 ......... \
 %imm8_0x2       0:s8 !function=times_2
 
 {
+  LINUX_BKPT    1101 1110 0000 0001
   UDF           1101 1110 ---- ----
   SVC           1101 1111 imm:8                 &i
   B_cond_thumb  1101 cond:4 ........            &ci imm=%imm8_0x2
diff --git a/target/arm/tcg/t32.decode b/target/arm/tcg/t32.decode
index 49b8d0037e..05217da8b3 100644
--- a/target/arm/tcg/t32.decode
+++ b/target/arm/tcg/t32.decode
@@ -418,7 +418,10 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
     SMC          1111 0111 1111 imm:4 1000 0000 0000 0000     &i
     HVC          1111 0111 1110 ....  1000 .... .... ....     \
                  &i imm=%imm16_16_0
-    UDF          1111 0111 1111 ----  1010 ---- ---- ----
+    {
+      LINUX_BKPT 1111 0111 1111 0000  1010 0000 0000 0000
+      UDF        1111 0111 1111 ----  1010 ---- ---- ----
+    }
   ]
   B_cond_thumb   1111 0. cond:4 ...... 10.0 ............      &ci imm=%imm21
 }
-- 
2.43.0


