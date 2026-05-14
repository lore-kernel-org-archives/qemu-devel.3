Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E24DCD4F3C
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNa2d-0003tT-0r; Thu, 14 May 2026 13:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa17-0000t1-Dp
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:39 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa0z-00049o-Vl
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:35 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-439acb393f7so2603572fac.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778780307; x=1779385107; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/DgnkqXpeeCl1p0em5O1dCAAg3lJW9cV1V2eiIjU6WY=;
 b=Spq4Wpxq6zx3tdJUuT3OOTU06x6Zipj+HPYZi7Qe3RnXXgFhsVuOTq0rd7iEncFEYB
 LcELcN8mazLR+jtj8EFgDhUpx2Wp1cG0cAAIKqsREFf3QDQLZfkOyW+8+yohMrnO4Iwg
 kh+3hsnGCHGrDTvEcjtwDT6jLcIc0Nf4hQuvrt8gUpY172hy95MZUYT5y9ama9MTuttC
 zalKwVQbFpfPoAl9MBAtXgUoc39xj+lOhcM+/sNEmj5Z/Vq/CS7/Y+/H0ZmcNw5ovifn
 uOPOfatvY4thnq77Lcp6uPEx3aPTXamA0r/RJOra63vlROVur8KV5C1DT1VjGcj3jctk
 1ksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778780307; x=1779385107;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/DgnkqXpeeCl1p0em5O1dCAAg3lJW9cV1V2eiIjU6WY=;
 b=I08rKOSuzDBbWBgOEBUPJDkKqw9rqbG8zZ6nSoFDelQ1g992+/X4IjwIW6xpsNo1Bk
 sSUdvISJtfdYBX8lczAWg/OGSaNPGLB4UrDT+8fbPUZU2klrbBZ0sFUmFrFYhG7DjCRl
 kL5xIjOzwjVDub8XKpTt0ORxEnnpXZqsKnoBaLztGNTMpvPSmXAdXr7opR5ZbTmkQnwR
 RZUNDJf3g6SFGdSfJUIkguDhV4MgCGYTnaj5HLA2Nzts0KPcKWZaHis60BfstlB5Jog7
 mjakIj8FCG+dJzMGZd5avLK1vtJj9lDiwuGtrRW7ge7IpY4KgSda65K5Bmkved/k3CmQ
 JzXg==
X-Gm-Message-State: AOJu0Yxm9QcLN2kunw7GJs5h2v2sX4H9aixCrp9I+qwn5jym6lV8M+xM
 Vz5p6QJPXNM6t9HmqrUxgX4pQhD1j0femYu7nmY3p7naD9fTRziWabw3
X-Gm-Gg: Acq92OGbPOObQTPNDPywXzGPezukLh43WQycQIOIrm1vTk1YjvO0aVw+kRtrPuAQzLT
 s/bIuap5kVny+p3AQ9TDHO5drP8ojbu/3CsBs1qugFrYwkm4ZVv8El/Gih08LQz0oR5GZVh7g+U
 3jA6wHGsVsdoCSP2CHBJV3Hit/XFZa661jn4pH+HlOzSSO/6UR81heDAE6zA7EXed8niKOR5hlI
 9zUl5j9QNCqvH4vypE35nB8jc9u90AWlLVKY3750ZqD5EPJJY9c7H5gA8VT5GyqK4uSFCgBdptq
 +vIHFzXczVXEHt9nZ5eQWpzWI0AQyv1eA31FMIZOWnfq09ChmP5NUIi3bsM7fw8IRNCK+pxEzP8
 42W6dLzGPdEmp4OW8gb+wCFkMbhew/p5lxJPvlWCtiE0a4RMo0ipcaatijxEt79A07JpumZyIcJ
 b2boe37rlYS/b4G5j0ZtF2ODG676xkDo5L7GwOz9Pll5huOYQkF+hYaN4zCZQMGMeySXOB1u3Ry
 q9+dmdIxe0j2cqbZS38OarBQqrD99TY1vndCnj6gGBYqnQowcAnnFhy1daCrcktXoD3s/YXS1cX
 1XI=
X-Received: by 2002:a05:6820:1746:b0:694:980c:9609 with SMTP id
 006d021491bc7-69c9436f95cmr246027eaf.36.1778780307283; 
 Thu, 14 May 2026 10:38:27 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b8ccdc74esm1687254eaf.13.2026.05.14.10.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:38:26 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 14 May 2026 11:37:22 -0600
Subject: [PATCH v7 33/35] target/mips: add Octeon CvmCount RDHWR support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-mips-octeon-missing-insns-v2-v7-33-226686be4ce1@gmail.com>
References: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
In-Reply-To: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x34.google.com
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

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 target/mips/cpu.c           |  2 +-
 target/mips/helper.h        |  1 +
 target/mips/tcg/op_helper.c | 13 ++++++++++++-
 target/mips/tcg/translate.c | 11 +++++++++++
 4 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index a2b9f6634f..606a1d838b 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -321,7 +321,7 @@ static void mips_cpu_reset_hold(Object *obj, ResetType type)
      */
     env->CP0_HWREna |= 0x0000000F;
     if (env->insn_flags & INSN_OCTEON) {
-        env->CP0_HWREna |= 0x40000000u;
+        env->CP0_HWREna |= 0xc0000000u;
     }
     if (env->CP0_Config1 & (1 << CP0C1_FP)) {
         env->CP0_Status |= (1 << CP0St_CU1);
diff --git a/target/mips/helper.h b/target/mips/helper.h
index 410a9b8090..d7a0feb673 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -203,6 +203,7 @@ DEF_HELPER_1(rdhwr_ccres, tl, env)
 DEF_HELPER_1(rdhwr_performance, tl, env)
 DEF_HELPER_1(rdhwr_xnp, tl, env)
 DEF_HELPER_1(rdhwr_chord, tl, env)
+DEF_HELPER_1(rdhwr_cvmcount, tl, env)
 DEF_HELPER_2(pmon, void, env, int)
 DEF_HELPER_1(wait, void, env)
 
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index 67854f08df..55ac877506 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -25,6 +25,7 @@
 #include "exec/memop.h"
 #include "fpu_helper.h"
 #include "qemu/crc32c.h"
+#include "qemu/timer.h"
 #include <zlib.h>
 
 static inline target_ulong bitswap(target_ulong v)
@@ -366,7 +367,7 @@ target_ulong helper_yield(CPUMIPSState *env, target_ulong arg)
 
 static inline void check_hwrena(CPUMIPSState *env, int reg, uintptr_t pc)
 {
-    if ((env->hflags & MIPS_HFLAG_CP0) || (env->CP0_HWREna & (1 << reg))) {
+    if ((env->hflags & MIPS_HFLAG_CP0) || (env->CP0_HWREna & (1u << reg))) {
         return;
     }
     do_raise_exception(env, EXCP_RI, pc);
@@ -418,6 +419,16 @@ target_ulong helper_rdhwr_chord(CPUMIPSState *env)
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
index 3e39f3460a..7627a4ffb4 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -10931,6 +10931,17 @@ void gen_rdhwr(DisasContext *ctx, int rt, int rd, int sel)
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


