Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEE8CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYhI-0001ME-C6; Wed, 20 May 2026 00:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYh7-0001JT-9l
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:38:09 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYh5-0003vl-7D
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:38:09 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-48270f099d5so3684503b6e.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251885; x=1779856685; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2uBLn0JCmn2AkoHIwn3pnP2U3MrZBB6n6jOVTTEKZR8=;
 b=fHweyYYcDZ7bIW8Qiu9ucliXOe2OgQ/uB6t/fnZLIQ1Ailv2QRerm0970lHjrZ6wLN
 TFlBlw+y2an8f+E7A2FFkjoEbLwe8PS0hAkAfQG99b91zQxrSGG0AXiVmwZ8b1N3kG32
 ttRMUI1OsKBxj/l6/HriHZU3UYPz4/GgMS4Z4jencdcbKk8LUJ6jiJnTgLagsbdbYdR7
 zE5iP40tW9W/IgY0nfauu/nhFGhhX2F72kyp1v0ML5fDr2fDr85JreX08Ofy4yba+w7d
 84UxCTzjh/HPzGim+mdBo0FH3BSaCSGTGS93TmoWcuAnjeNt2IULIoXt5A5wuINYRLXi
 DQ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251885; x=1779856685;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2uBLn0JCmn2AkoHIwn3pnP2U3MrZBB6n6jOVTTEKZR8=;
 b=ho1LmZLI/Lt3voCqbkkChI3P2Z5v+Y9f0kSvYXra1SvIp7znzMQj5L5B9beeFouNhA
 qGMVHF3Tc6J7zA7KJ2dBbTfivVkUBk6YOrVku5GqAWOZNmKCGxFAQbjyQOMRzFJUkkYd
 QFI8lLI7TPrJsiWP8IZNLnbrijhgxBMqNBFkxWHerupXb1s2zHb2GtzOoaJEBxju070t
 /rk7GwMSa8oSZPrE+uy1n1zx9K3jntXj6HGylnepjBsodj9D6Vy9V9ZXyd2K7hXMFzFW
 t5D/nqjHSU4hk+awHKQglKCxk5Di3Jk14wSShDjqJmpwFqeHSWMiCjtipkaWvLAQqoMc
 E4Tw==
X-Gm-Message-State: AOJu0YykRp0JI/e2AYrehxm3n6rOFbvBtr9OJtg8Je8Q9FEPTP+vwrqH
 4msBJGv511wUBqxlHQuTIk1R02YgEXRvIpIvbA2fEk39TUIZ0J/pv7+zswDWBgs/
X-Gm-Gg: Acq92OG9YDyu4VckTud7CJ0TRefS/85Kfu2353rNHcywThEtB1bpOFtCkbLMt4AnaVf
 P2cZlRQUxJ9TLhrfRh4HLvtRilcU9LlWO6+p4W9jDPKjjxby/fR8U6sJUuKh98w9xGcnwknyWMH
 gUMK2H4BcLFyMybatM2NG+cYPOZDa+cHSdeDQeApFBK+g8QJNoWGO8i83XsniU80EF/HJE2EFMP
 LazTHhkLpVyYy3ALfHBCbx1S0M5PmTBH/V+TTvMV5JOjkOPe+6wXOqsm2z46RurBFy7zIKniUTo
 Vhyy4d2jYM7pQOizBzlbwEmau/x+BD/LSzNR+3ev3wHjpJiV3iGPcrjSf0SILJedOdXNLGwdNNr
 m+s+2XZhaHKCbpur9D+O4T8e5/RQ4LdV2LPnG1elsr1/sdsfKt9JftlS5qk76XZpqrINkRjPX/d
 0g+ydmyv//56z4yTFmx+hqalukKf3H8OCBNojhRjKzqqxSg83/IqIgiQFpVYGUDXuCev7MLbVIZ
 LMdl8OIgT+J5qajIL7QPnfQ9945o9fFh9g44olX5lmmedpBAesKwEeEj/Y0KSAm+NWE
X-Received: by 2002:a05:6808:518f:b0:463:c56f:a45b with SMTP id
 5614622812f47-482e5725b71mr13886206b6e.28.1779251885139; 
 Tue, 19 May 2026 21:38:05 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:38:04 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:37:37 -0600
Subject: [PATCH v10 43/45] target/mips: add Octeon CvmCount RDHWR support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-43-306f9edfe15b@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22e.google.com
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
index 42766ed0d2..392722ca86 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -319,6 +319,7 @@ DEF_HELPER_1(rdhwr_ccres, tl, env)
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


