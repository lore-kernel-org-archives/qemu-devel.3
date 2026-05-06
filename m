Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BAB3FF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcsb-0004Vg-4w; Wed, 06 May 2026 10:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcsE-0003hd-7p
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:05:14 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcsC-0001bx-2c
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:05:13 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43d73422431so6095287f8f.2
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076309; x=1778681109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UMTtObmWf9r4iW1RVL81w+CpGum6ZcXVBlqRYE3xnws=;
 b=WX+2TPMk6dnWd3cYlHVnyhLWqvOHJREX8lFC1IN/vE7fR0H70e+SxfvTTk2ZVgmW3D
 a7p69oKbIBfpgfzZM0Bu9dH3IUG8abxev3/dxJSqa91v4iCCW7gswz+x/HsHYxpAZgM0
 RTtaoz67wtbMJTOAE/yXJf36RtM7NDUw3QfIERK0H7wxyESFOVukpmB0/FgKB/9zcvR2
 tf9QEBFPiaudbjyZaREnvfTh48mRqquqm3xekZE8uWOJx9ShLgS+FPOZtQCebg5E092T
 +AGibvUbfqW2Qwoa3Vr1XjB0jVeMQr/o2XzZXWZ3Rdep4fdq4LrooY/2vL6M0N9WI+WV
 j8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076309; x=1778681109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UMTtObmWf9r4iW1RVL81w+CpGum6ZcXVBlqRYE3xnws=;
 b=jVXj/+szUYeL7q0Pdk9lrkd45aLAecdw2kkGNpriV9TUIMfDdMYHqlN5eDlqdi7UK2
 cAtEFq0dv0ONnmHH4ho/d4vksfEUWM3MZVQhnyd0UOrHvkVbXkXpZzdVXQJybeAm2/DN
 GAxV0V3nofZgTUzuF1KG1F7xO0m9TIAoegJX3Rxuigt+y1FMN9EzdUi6ePNLYQMOIi2M
 sQGsV6jym4ouS70xVQ59/fAIVoxdXi+kxPiFdjBaOYjjEYveNOaa6eDLdvg+IQosVEzt
 clDnv2WU2LBVj1rTxNbR7JkWPA26Ec99UuBvrcVU7sBAN9j1d9LHkRkQkh488wNnqiCY
 nvZQ==
X-Gm-Message-State: AOJu0YyAVXOrWhsdjskB3vnh40n/bLN7P713ya8U9sN0O6jJO398k7X4
 Uys/GRwUeaQLyTwXmEyWLm7G2OgUrGTpt1bLC2T9r+z78IUo2xJ1m70RLo6U/Oz6kr5C7k4Eqkp
 Ju3v/vOQ=
X-Gm-Gg: AeBDietoh9FQ1sHEs9y7LOU1dyA5V0MEAjChf6mCPgFKiKhMcuEY91BosDLCx0FBoMh
 Cs7uEQQLDIsPF5nVw0iSDyORA41vJE+TooOBcR2wZ+HcCh6X0OuA57uYU+NMpEopxzQWqX4yFf7
 bdsKY+hi1gum80LltdJ/PvX/zGadeE61B+L2k/07FEdjJXTGSekTYNbT5XfL3mbj3CaP3Im72Dd
 rNDAIarjyejn9AtSSgMribrb8ARHll09mXqRGgZpa95ixypLPzlTr1dp/nNg9hKcY86G36iq4xD
 /yVnQoWIhSe0y8mIdj1+PNOyb9rFzeeLooron9lp/nKuAFTImd98JbhmXZxDtT8CvUWwC/Jj05m
 bVUbwNkwOaBPCB9XfFuLhCx6EwkkEoot7krUVlXWMxQ5M56/lADOMTObI4JHR3PV5sQSIPO52xr
 QBgFOuWKbURAYWqyM5hFbJweqFjNoObqMBlrObHaLnwRHFOLNaJ0OkFGmdlDWzUWmO1XUmkYxe2
 bTW05LvvdE=
X-Received: by 2002:a05:6000:2386:b0:43d:6fb7:fedb with SMTP id
 ffacd0b85a97d-4515d99ddf3mr6133468f8f.36.1778076308521; 
 Wed, 06 May 2026 07:05:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055f2203csm12943555f8f.37.2026.05.06.07.05.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:05:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 074/110] target/mips: Inline cpu_ld/st_mmuidx_ra() calls in
 Atomic LD/ST helpers
Date: Wed,  6 May 2026 15:54:46 +0200
Message-ID: <20260506135524.20617-75-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260417042620.35329-3-philmd@linaro.org>
---
 target/mips/tcg/ldst_helper.c | 26 +++++++++++++++-----------
 target/mips/tcg/translate.c   |  2 +-
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/target/mips/tcg/ldst_helper.c b/target/mips/tcg/ldst_helper.c
index b36b12d87d6..1b25466b496 100644
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
index ee6199875cf..fff6390f5d4 100644
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


