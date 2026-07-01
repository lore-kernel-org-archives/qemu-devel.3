Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE7FC43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 03:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1welG6-0005ql-33; Tue, 30 Jun 2026 23:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1welFx-0005in-5V
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:04:58 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1welFt-0002qC-Oe
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 23:04:56 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2c9b1edf2bdso1020785ad.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 20:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782875092; x=1783479892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vRXrShiuVMuf4OcMbWA5wcZpSLQDxfyJIHc+c1cth2E=;
 b=No+/5seMIIWdSFiOMs+kpjVC2OObo8TTg/meIOZ2D8dNKrNXaJSUu+4cHBbiO3W/dQ
 NuyLjleBtlUqRBwKcanV5zhZGrRUW3XI7hDVbN9NEYDPsMoB+J+pi5Oyb9tNs/OIhC2Q
 bnCRgEBgNS5hIbvFp0Fqs6cvg0oOfllETD7E0FPd4+dPPfND5gxcf224c1sDr3+H9Q9v
 mOy4i17edNP84UmfSccrcz3g2LhewupHkzu7ui/+yz14fjHLmpIu6JFoCcOWnR+1ZKBY
 ziicXElGQWpR2P31e0q5jJ/sfvXwZqeXkGCK0L49a3xVbEbiRYbp0hPBJOiGDuooYezI
 NiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782875092; x=1783479892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vRXrShiuVMuf4OcMbWA5wcZpSLQDxfyJIHc+c1cth2E=;
 b=PvukXg8jM/XdwB/OgXEYmPUzWwVZ6AkDSt/uVjkJF9IqrL3H4v2gl4M3jYOCZ1xCJD
 zLvaY0e5E1jNJYZnNm6BJVgQ5533ZUltiT1aj8B1tHU8bzxzh3RsHPb5BGxDhsN/PGlY
 Z2NFkJj3HK6vdw+E8f6fprZa+BAr4dBLX8G2iKIKiKg3w4nzJP/r+C8jsZz4D5lAcJyO
 M6hwu5OpDGy64xJn6vcDnIOv+wc2rt9PmDJb3FeUbXclygveVNXHJh5/wBYnPI162YXu
 qScyDqLyBp+pcUcp2ulwMnuQnOZS1Svr31b1yvZ+OXAiF3D7pfir/kIINQgcVvH1XYlT
 TpYw==
X-Gm-Message-State: AOJu0YxU3lwyByX+FLnwXDh69hWl8oXfCJ5jAzxt9iDW2kYP0KU4t1CQ
 AnEszb6RT/FUIj28FaPZQH0qkGTfQFOPb0gdb/0zfkdClHVNBHnSMGehIshamH1EaDuhIMJeqGC
 ZQqA+
X-Gm-Gg: AfdE7cnVoz71YrZaFJImnnStM8Mb/N1CVxu+Joe42o5WLPdKqO8LCiMiP8EsPSBnvu9
 qa4rPBLSBl9UsMgvpGy8WOpTNHwM1z93oknJOn1MOB3Ph0/sF58YJVFL868i4TeJojCIoqlzKuj
 08vBLuGq0ABR/qZv7ZY1SG2hG/TtemzBolSww69+18d0rO0jE13fR7b0FNGGA5toSYXIwgE+w8p
 Vvq/SidOtrhtkzs1x1zfhL+2HidKvwRlU/pAKC2Et/vXpei0AcX+EdEaGRu3RGltQol+hUMlZzL
 3CPJXV2bjsYzhbH73CX5ZITdN7XL8tjS8OKmEGNQ+GCx8MPKBACknhI+xuG6oz1cA5T2tu/W6pX
 R1/xVSW4a3fdN4vfUR6gV2YqWtaqnU11RmOglEcWf5uFgBeVF7mjynmu9BLIYD74SsMD/YvuKoO
 rrABP6DU/8sB45VqbyuGxX27d8RbBwyqo4l3ZEhGcUMp9p+FHo+w==
X-Received: by 2002:a17:903:41d1:b0:2c9:9927:a060 with SMTP id
 d9443c01a7336-2ca2ed3191emr53264715ad.24.1782875092225; 
 Tue, 30 Jun 2026 20:04:52 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca37c74261sm23758085ad.22.2026.06.30.20.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 20:04:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: shivangu@linux.ibm.com,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH 09/17] target/arm: Split is_wp out of bp_wp_matches
Date: Tue, 30 Jun 2026 20:04:35 -0700
Message-ID: <20260701030443.1382447-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701030443.1382447-1-richard.henderson@linaro.org>
References: <20260701030443.1382447-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

This function is only called twice, once for each of
breakpoint and watchpoint.  Hoist the separate bp/wp
code into the respective callers.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/debug.c | 46 ++++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 29 deletions(-)

diff --git a/target/arm/tcg/debug.c b/target/arm/tcg/debug.c
index ed94b20739..51d6748427 100644
--- a/target/arm/tcg/debug.c
+++ b/target/arm/tcg/debug.c
@@ -252,41 +252,16 @@ static bool linked_bp_matches(ARMCPU *cpu, int lbn)
     return contextidr == (uint32_t)env->cp15.dbgbvr[lbn];
 }
 
-static bool bp_wp_matches(ARMCPU *cpu, int n, bool is_wp)
+static bool bp_wp_matches(ARMCPU *cpu, uint64_t cr, int access_el)
 {
     CPUARMState *env = &cpu->env;
-    uint64_t cr;
     int pac, hmc, ssc, wt, lbn;
     /*
      * Note that for watchpoints the check is against the CPU security
      * state, not the S/NS attribute on the offending data access.
      */
     bool is_secure = arm_is_secure(env);
-    int access_el = arm_current_el(env);
 
-    if (is_wp) {
-        CPUWatchpoint *wp = env->cpu_watchpoint[n];
-
-        if (!wp || !(wp->flags & BP_WATCHPOINT_HIT)) {
-            return false;
-        }
-        cr = env->cp15.dbgwcr[n];
-        if (wp->hitattrs.user) {
-            /*
-             * The LDRT/STRT/LDT/STT "unprivileged access" instructions should
-             * match watchpoints as if they were accesses done at EL0, even if
-             * the CPU is at EL1 or higher.
-             */
-            access_el = 0;
-        }
-    } else {
-        uint64_t pc = is_a64(env) ? env->pc : env->regs[15];
-
-        if (!env->cpu_breakpoint[n] || env->cpu_breakpoint[n]->pc != pc) {
-            return false;
-        }
-        cr = env->cp15.dbgbcr[n];
-    }
     /*
      * The WATCHPOINT_HIT flag guarantees us that the watchpoint is
      * enabled and that the address and access type match; for breakpoints
@@ -366,8 +341,19 @@ static bool check_watchpoints(ARMCPU *cpu)
     }
 
     for (n = 0; n < ARRAY_SIZE(env->cpu_watchpoint); n++) {
-        if (bp_wp_matches(cpu, n, true)) {
-            return true;
+        CPUWatchpoint *wp = env->cpu_watchpoint[n];
+
+        if (wp && (wp->flags & BP_WATCHPOINT_HIT)) {
+            /*
+             * The LDRT/STRT/LDT/STT "unprivileged access" instructions should
+             * match watchpoints as if they were accesses done at EL0, even if
+             * the CPU is at EL1 or higher.
+             */
+            int access_el = wp->hitattrs.user ? 0 : arm_current_el(env);
+
+            if (bp_wp_matches(cpu, env->cp15.dbgwcr[n], access_el)) {
+                return true;
+            }
         }
     }
     return false;
@@ -412,7 +398,9 @@ bool arm_debug_check_breakpoint(CPUState *cs, const CPUBreakpoint *bp)
      */
 
     for (n = 0; n < ARRAY_SIZE(env->cpu_breakpoint); n++) {
-        if (bp_wp_matches(cpu, n, false)) {
+        if (env->cpu_breakpoint[n] &&
+            env->cpu_breakpoint[n]->pc != pc &&
+            bp_wp_matches(cpu, env->cp15.dbgbcr[n], arm_current_el(env))) {
             return true;
         }
     }
-- 
2.43.0


