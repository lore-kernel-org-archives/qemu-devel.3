Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE806CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVIC-0005l6-Uz; Mon, 11 May 2026 14:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHq-0004uG-Py
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:29 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHo-0002vf-1v
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:26 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-479d68a9063so1708429b6e.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778523803; x=1779128603; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zujAwh5N4GUQo31k1K/W8TQ2OGgta58CwyapwbEsYUA=;
 b=Yp4mJ3egeAAsxwmbRq2lM9MlR7F13jxaNLBJbW3HjonP/reiTj3qUF3z02hvG5+0NY
 V953rPY9bhI6mNisGqodzSu9hsFQaJTwhI0fOCUyLJ+8YDzJVA4V9zWvJcQ05y4eVDJc
 MM+J0HrTZhX50D4Fce5wHOt6zpRLXTX62h3RMCh2e2OEm3Go+mPS8qaB1fwhnmnQ76rt
 tdBb7LwIvOnmFx1D7kj2eOWfI+XiaXQsVBTEnQTVFMrh4nMlUGYRlHr8m3/zyWrZC0iI
 P56vK8xnMBrntp0jbJddNaMlFMEZMEKkEcwVN++loC8idOcEVIKTCkz2JVxxPIXg90mD
 xv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523803; x=1779128603;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zujAwh5N4GUQo31k1K/W8TQ2OGgta58CwyapwbEsYUA=;
 b=AGyIAv4T/Fzh+leCV7G5RQCM6oB6g+PGEMwURBrXsDaUMsliOyXzBU5TDH4RArt3wo
 hrfpMttQXWBk0Q5ETyW822Uqm/biDimPPSeE+xk0NlsHdN1rRPFTvNkicMCyVXEg9S7y
 HtelvlzHQtd8udyCDNtVk+dCQpAbdTbZYePCXqmCE7SLlLbasvup+sl8dLb6EKIAjwll
 YcU1B4/AauI27tRkq3++u0FfR+wu/tQE+mtE8fvtMqR5tA0/zZQcipeqnGFJn15tVm9c
 rY2vccIIvI7RrhvxdpcK7FTB6cPUM1gz3zb/k8sfeJxhf32CrMQwsWj3xBoa4gQ+qhZI
 ytoA==
X-Gm-Message-State: AOJu0YwHvW+i0k6o9AwT3ZHGJIqj4YG8xGT3zRCvv40wthTOVJhMbgzK
 xjyVqs+eh4o3pH+71S/SFb+uSnvLRJTCJ4EvNbY2kKPCsMffw/6xWEfT
X-Gm-Gg: Acq92OHNKYx5qIdHqjRQF2+xeQLv+A5zZUZQD53Dbe1aksp06tt4HvbbRnJWwPWgxdo
 P9jLjTOiLbNM60xHniky71KKP2xp4fmYQjRYPbOIPJHpBXCY9wtJkEZAZHemTwr9yPL/XEL+EET
 lQrq3kaWacJ/UhyHszhtRCRFAmnXkXNgR5fcvjAyt1zd4sPz2+Zn60ZeXX/fjF6TNj9fwDxPHhr
 xyX20fclzVPESQCRJqw57lMMoAq/xjFlsc2CIGCQH1Oygw/dzlq6NTv+zR6G2VcKGnE55MhUzM3
 Q8UUGAtvRHBUSF+9rHzALhRGZABtMNtc6Co0igdKbd9Ngdo9xHMEEqTNcPL3NZjEFz9eyxWnn1p
 LpnFG+l4kJ7gCoeKTW+dDQQSDtxT1Nf/G18PtXNrEu7NjAEPMGGCU6cH8vZ2xY2o4+skYqnpE1e
 N7BL3jvOIJrHuc/p3mhOv970yzY3JmPFqjNey534Mqe9aiKMr927ECnJaSpf3R7SSIdyWLUA+WM
 wT2/cNosh6P/pVuIeaTDh1jKHBsZz69KjKM7P8hmBjiFgWbwZMZtdDTIfDZFAZMQr/5
X-Received: by 2002:a54:4e95:0:b0:467:2509:c207 with SMTP id
 5614622812f47-4824a6d54a9mr4534021b6e.17.1778523802791; 
 Mon, 11 May 2026 11:23:22 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d90148sm7504871a34.20.2026.05.11.11.23.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:23:22 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 11 May 2026 12:23:04 -0600
Subject: [PATCH v6 33/35] target/mips: add Octeon CvmCount RDHWR support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-mips-octeon-missing-insns-v2-v6-33-5062889c4d3c@gmail.com>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22a.google.com
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
index 9bf9b67202..639ffa77cd 100644
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


