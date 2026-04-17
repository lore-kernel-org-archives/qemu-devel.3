Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E32EF8E4A7
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 04:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDamy-0005zg-2k; Fri, 17 Apr 2026 00:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDamw-0005zT-53
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 00:26:42 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDamt-0006NO-4W
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 00:26:40 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43cff5dafc3so135011f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 21:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776399997; x=1777004797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gw9TjGxlM4a7z2UtfxxhY5WNWrcHe6UnFE+Ln152chE=;
 b=PDidk0qwY7N4R/NMy5Z1UWAdFvt0oPjlvuDOMYEjIltIbF1QeWIyCmtdCGsQ2TeDZ+
 RVCut3Rdk0VUI/sija+7euXEQX4l56YEN4zE72E6Y+BMOf9iqBRNYCUrZEvPq2e97PZb
 JtKhbPQCM8wUbr+FiVHHBs07aEMqFzyDZTNJ9w8VyZyBbWDcoQzRdxDD5XRbCgGGwYB9
 2QahSPTG7LEHc2wTMWzTZxjLh/jIy5eB5gpnx4zTa2PUSHe64ZgT+m0QgtLQVAiEd5/F
 KCmdaKvlPBXFz535vBtOFKklT4AxnOkQyIwZb+XXiIzvYy+vLNRTM1p/7vp/ETcSdNkW
 Q0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776399997; x=1777004797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Gw9TjGxlM4a7z2UtfxxhY5WNWrcHe6UnFE+Ln152chE=;
 b=fzII5nsl0YnTtAi88mnv7Ihvgg5jc4P8YPkbMG47s5ANf4ZUW1SLqbCHxE2yVHqWP5
 EqWpuAPQ9IaY8N6rxUwRNThAOJ8WGMfHySu4HD6UIHtVMIal7OPQ2TCRX2Qv7Yi7EWgP
 JwYPnD0sDc9Idji4mgnY0hf9IKTfrxlB8yw5+GX6lANOXf2+PNwdP4RWW2lwcPnXLQ7m
 nP6V0E4diKogcKGmpGZjU99ldNleSUPPLKi1/7YiMimcPCWH7EeLhVMk3fIz/HSzWWfK
 P0bKBxB9NU+2JshteUY5Q3U6+xX3U5emmhxVW591N2lFUIchHY6r7fFbrC0HX6TrY0v/
 d6zg==
X-Gm-Message-State: AOJu0YwOKkFyebfe1wlNQ3X9fzOEM0kXXsjv9OiDmFCSeoiFWEkuXtuV
 9EFcOGHYcldXI65aOpQu0nHnng60chrTY3th4QQTQB1keRWMjAoLSERr48in4Ed6Ntwd6xki76J
 AKDAZ/O0=
X-Gm-Gg: AeBDiet60CL5xsvG1xlOdJj/D2kVB1GRQrVPsrRy/9e80uM8z3RNBfDUxSLeTRVP3tt
 f2yAFLwWCa/JEBzPGmeFIPwGUKIIN9NKoZQiKDdTZzDxoJmrD2KN+9XbkgFrMJ655mTsuXY41+n
 q0yJvMLVyHZluHBqhC5l6ph1xEKCovyJhiTZxcTWZboir0u3vZEa1iX2rLmLlkkL0n1enTsKYWY
 VERw5823Cv0NbpKNYK5DaCS2bNRfHRokQ5VbUHBa161QVe4m/Iv0I0ff5q/D18N8uL+qe8RN9Pw
 eic1VtudHvc57vdCGla5eIkBI06tvEN+Bupu66IqLpfYcV3l4Sipk+AYBUnfCoFUfiunF1u2J+T
 MrOiyBKxEmCPIDJoP8YMN4PK/D7I5G4v+mZG5RqeeOdvm04KY11rTKs6OTWUm9PrV0b7OxHb40k
 U1OV2Ks4VDi8i0jVEwtth6aySDkweiki3rNcvII/ASlT3QtHgKg7vFxqEvx7fEdf+aiXGLaO4Di
 +6ClDdGCoeTAzlxNum2fg==
X-Received: by 2002:a05:6000:2284:b0:43d:7377:8772 with SMTP id
 ffacd0b85a97d-43fe3e25982mr1537120f8f.46.1776399997326; 
 Thu, 16 Apr 2026 21:26:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm1146400f8f.34.2026.04.16.21.26.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Apr 2026 21:26:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 2/4] target/mips: Inline cpu_ld/st_mmuidx_ra() calls in
 Atomic LD/ST helpers
Date: Fri, 17 Apr 2026 06:26:17 +0200
Message-ID: <20260417042620.35329-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417042620.35329-1-philmd@linaro.org>
References: <20260417042620.35329-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Have callers set MO_ALIGN in the MemOp bits.

Perform the access first, filling the TLB in the process.
If the tlb cannot be filled, access is not permitted, and
an exception is raised. Thus remove the now unnecessary
do_raise_exception() call.

Since the TLB is filled, use probe_access() to get CP0_LLAddr.

Move env->CP0_LLAddr and env->lladdr assignments so we
don't update them when an alignment fault occurs.

Since we have a handy MemOpIdx, replace the legacy
cpu_ld*_mmuidx_ra() calls by cpu_ld*_mmu() equivalent.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/ldst_helper.c | 26 +++++++++++++++-----------
 target/mips/tcg/translate.c   |  2 +-
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/target/mips/tcg/ldst_helper.c b/target/mips/tcg/ldst_helper.c
index b725c6d0333..4d67392369a 100644
--- a/target/mips/tcg/ldst_helper.c
+++ b/target/mips/tcg/ldst_helper.c
@@ -28,23 +28,27 @@
 #include "internal.h"
 
 #ifndef CONFIG_USER_ONLY
+#include "accel/tcg/probe.h"
+#include "exec/tlb-flags.h"
 
 #define HELPER_LD_ATOMIC(name, insn, almask, do_cast)                         \
 target_ulong helper_##name(CPUMIPSState *env, target_ulong arg,               \
                            uint32_t memop_idx)                                \
 {                                                                             \
-    MemOpIdx oi = memop_idx; \
-    unsigned mem_idx = get_mmuidx(oi); \
-    if (arg & almask) {                                                       \
-        if (!(env->hflags & MIPS_HFLAG_DM)) {                                 \
-            env->CP0_BadVAddr = arg;                                          \
-        }                                                                     \
-        do_raise_exception(env, EXCP_AdEL, GETPC());                          \
-    }                                                                         \
-    env->CP0_LLAddr = cpu_mips_translate_address(env, arg, MMU_DATA_LOAD,     \
-                                                 GETPC());                    \
+    MemOpIdx oi = memop_idx;                                                  \
+    unsigned mem_idx = get_mmuidx(oi);                                        \
+    unsigned size = memop_size(get_memop(oi));                                \
+    uintptr_t ra = GETPC();                                                   \
+    CPUTLBEntryFull *full;                                                    \
+    void *host_unused;                                                        \
+    int flags;                                                                \
+                                                                              \
+    env->llval = do_cast cpu_##insn##_mmu(env, arg, oi, ra);                  \
+    flags = probe_access_full(env, arg, size, MMU_DATA_LOAD, mem_idx,         \
+                              true, &host_unused, &full, ra);                 \
+    assert(!(flags & TLB_INVALID_MASK));                                      \
+    env->CP0_LLAddr = full->phys_addr;                                        \
     env->lladdr = arg;                                                        \
-    env->llval = do_cast cpu_##insn##_mmuidx_ra(env, arg, mem_idx, GETPC());  \
     return env->llval;                                                        \
 }
 HELPER_LD_ATOMIC(ll, ldl, 0x3, (target_long)(int32_t))
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 839bfe18bab..4889bd1e518 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -1936,7 +1936,7 @@ static inline void op_ld_##insn(TCGv ret, TCGv arg1, int mem_idx_ignored,  \
 static inline void op_ld_##insn(TCGv ret, TCGv arg1, int mem_idx,          \
                                 DisasContext *ctx)                         \
 {                                                                          \
-    MemOpIdx oi = make_memop_idx(memop, mem_idx);                          \
+    MemOpIdx oi = make_memop_idx(memop | MO_ALIGN, mem_idx);               \
     gen_helper_##insn(ret, tcg_env, arg1, tcg_constant_i32(oi));           \
 }
 #endif
-- 
2.53.0


