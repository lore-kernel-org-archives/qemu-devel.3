Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FE0CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNDy-0006yw-Ud; Tue, 19 May 2026 12:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDx-0006y7-G9
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:23:17 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDv-0000qT-2v
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:23:17 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7e36bb16a92so2267408a34.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207794; x=1779812594; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZZOjTyR1gKYk3Ul3oxhSb/iRoco7UWLLdf42XLNv3PU=;
 b=Q4Fn86J8vw0fWR8ttQJIVUwfVfzvIqCw+ueG2uxsaZORv9JuNSQjbz1lx3okmX8oLs
 oiiy36H8xWQisNu7T2v+yESlHpzFQZTCdcbkUZfVdaqPiToo7Jh81jt9LzTKPRxYTg36
 4ZnrMUzfMubmLZaL/i1qEnYts/wdBom7o3MECbRsxsypUx+7AfWgAeZXk2blLaZ5Drld
 Vqk4tiViifTv6AEIS9o952K/IOoYG7XrwLEXzpRd0o35pUUWvKH8cVLk43dD2TdLBhOg
 dM/BB2Lo8ZI/MVBJVB+eEXOr317+JKHRFTYDKIOHXZPphSuYMLijlSIMH1AaR079qqt0
 Tkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207794; x=1779812594;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZZOjTyR1gKYk3Ul3oxhSb/iRoco7UWLLdf42XLNv3PU=;
 b=geTL668dkYgmkbyOoF5KRGdSp3QukqpsgvpIuA8QMbFkjPkLIzRzi4szHtWTgwp4KI
 D1WjTnirgMZecimV+gAzvEOVU4FeT9YiH/phv/QfZ3sEhXH9EugR+9551BMS4FkhYHER
 WDMkvutNuBLy8nUbsRRGiWqy0REPeB7RPHa1VNPFHGISrLukZF1J5sFULuYiFCgXBEX2
 ic03+TxkLJVbyO6Hvt7ETzuld+7ZXiMUnX1FKEJnKB5QXXQDpdh/3MOBieAM9PSICtas
 ix5OY48tSyIEvpreE9B6x+wGxq32Eqx2JkiC6UDdeEmaHKRJBzcJbkwH0kHkANxu+5uT
 9iPg==
X-Gm-Message-State: AOJu0YyO3Zv/8AJV7ji5QWnk+nEVuXlIMULO6RrEFloCEwPhUU0oIXW/
 fx7fWPK7Ts0XJqAhAbZb7+d7llKT8jbJnT4IP1CJaBUbBJ4RCeaiL/g+
X-Gm-Gg: Acq92OFqB38wap2h0mzCW4JMrlVtxXreKvTOOW7gKvGFQbCAS7yWdUoWLNCpmFe2QPh
 t7TJCpgwCCD8JQPey7k56HXuHl4aJpU6CJAuFejSPNbZS6aka/FgE4nKnx8edI6RAZP3kUllDAj
 NX+7TVvdMPQhV18CdKFJB4FaZPocLHbK/6MmHKEDBWPGrkumG54sBkyRpJYBD7BQftJ9q4tURP5
 9BUunecnZ+ZmZDxp47QK4+KtbmiNUCV8rJtCPpwnAr7ij0/pkK7mNK906c7OGsbkWALfdmt4dAR
 tyxGg09L3qxXCk+uO0Gog50B7gnwfnN47pCBY95xHElet72b5WTARztCX3lwociM0Im7TDrjsjh
 BWLMcz9g+XxxWN2p9zwg4USiK6SMD1qm685UwEa/H5A0X3P3vYwMknMRhZ8wmcGQJ5UJHZIFTKr
 NvU/DYcSPL45q4qi3zjBQtyGH70OX1YiMDoj669Mj4ozE4R90PqzvUr37gqHUthznbm0CWFK2jY
 4DKj7IgClSLg+Q0wubNNgqIzPzP/vjMG9GGfK3tTLJh6EtG4vTXtVvWn/6g5JYBcnFK
X-Received: by 2002:a05:6820:8c8:b0:695:a610:eccb with SMTP id
 006d021491bc7-69c942d9966mr11629291eaf.20.1779207793710; 
 Tue, 19 May 2026 09:23:13 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a95762ceasm7056296fac.13.2026.05.19.09.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:23:13 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 10:22:40 -0600
Subject: [PATCH v9 38/40] target/mips: add Octeon CvmCount RDHWR support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v9-38-d7dd735ecddd@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v9-0-d7dd735ecddd@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Octeon exposes CvmCount through RDHWR register 31. Add the Octeon-only
decode path, enable the corresponding HWREna bit for linux-user, and use
an unsigned mask when checking HWREna so bit 31 is handled safely.

For user-mode emulation, return host ticks as a monotonic counter source
suitable for existing Octeon userspace code. In system mode, fall back to
the existing CP0 Count value.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v5 -> v6:
  - New patch.
---
 target/mips/cpu.c           |  1 +
 target/mips/helper.h        |  1 +
 target/mips/tcg/op_helper.c | 13 ++++++++++++-
 target/mips/tcg/translate.c | 11 +++++++++++
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index a2b9f6634f..fe757ef03c 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -322,6 +322,7 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
     env->CP0_HWREna |= 0x0000000F;
     if (env->insn_flags & INSN_OCTEON) {
         env->CP0_HWREna |= 0x40000000u;
+        env->CP0_HWREna |= 0x80000000u;
     }
     if (env->CP0_Config1 & (1 << CP0C1_FP)) {
         env->CP0_Status |= (1 << CP0St_CU1);
diff --git a/target/mips/helper.h b/target/mips/helper.h
index fd57ebbf00..63c5245950 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -317,6 +317,7 @@ DEF_HELPER_1(rdhwr_ccres, tl, env)
 DEF_HELPER_1(rdhwr_performance, tl, env)
 DEF_HELPER_1(rdhwr_xnp, tl, env)
 DEF_HELPER_1(rdhwr_chord, tl, env)
+DEF_HELPER_1(rdhwr_cvmcount, tl, env)
 DEF_HELPER_2(pmon, void, env, int)
 DEF_HELPER_1(wait, void, env)
 
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index 3e586e3049..df1b5c3734 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -25,6 +25,7 @@
 #include "exec/memop.h"
 #include "fpu_helper.h"
 #include "qemu/crc32c.h"
+#include "qemu/timer.h"
 #include <zlib.h>
 
 static inline target_ulong bitswap(target_ulong v)
@@ -209,7 +210,7 @@ target_ulong helper_yield(CPUMIPSState *env, target_ulong arg)
 
 static inline void check_hwrena(CPUMIPSState *env, int reg, uintptr_t pc)
 {
-    if ((env->hflags & MIPS_HFLAG_CP0) || (env->CP0_HWREna & (1 << reg))) {
+    if ((env->hflags & MIPS_HFLAG_CP0) || (env->CP0_HWREna & (1u << reg))) {
         return;
     }
     do_raise_exception(env, EXCP_RI, pc);
@@ -261,6 +262,16 @@ target_ulong helper_rdhwr_chord(CPUMIPSState *env)
     return env->octeon_crypto.chord;
 }
 
+target_ulong helper_rdhwr_cvmcount(CPUMIPSState *env)
+{
+    check_hwrena(env, 31, GETPC());
+#ifdef CONFIG_USER_ONLY
+    return cpu_get_host_ticks();
+#else
+    return (uint32_t)cpu_mips_get_count(env);
+#endif
+}
+
 void helper_pmon(CPUMIPSState *env, int function)
 {
     function /= 2;
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 1f44932882..e3467d1525 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -10933,6 +10933,17 @@ void gen_rdhwr(DisasContext *ctx, int rt, int rd, int sel)
         gen_helper_rdhwr_chord(t0, tcg_env);
         gen_store_gpr(t0, rt);
         break;
+    case 31:
+        if (!(ctx->insn_flags & INSN_OCTEON)) {
+            gen_reserved_instruction(ctx);
+            break;
+        }
+        translator_io_start(&ctx->base);
+        gen_helper_rdhwr_cvmcount(t0, tcg_env);
+        gen_store_gpr(t0, rt);
+        gen_save_pc(ctx->base.pc_next + 4);
+        ctx->base.is_jmp = DISAS_EXIT;
+        break;
     default:            /* Invalid */
         MIPS_INVAL("rdhwr");
         gen_reserved_instruction(ctx);

-- 
2.54.0


