Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A94DCC79F9F
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 04:59:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x34xx-0003zl-4P; Sun, 06 Sep 2026 00:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1x34xq-0003zM-H2
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 00:58:49 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1x34xo-0004nM-E4
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 00:58:46 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5b4aa47bc97so1825317e87.2
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 21:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788670722; x=1789275522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lYfVkceP5S1HVyUvDod78U74pYKuDJC+6hEWu0Cwf2U=;
 b=j6Ytu7nkXr6pfeWOP4EKNQj47KI9S/IiP2Zit3kqzS9TyBTnM30RYoGJww0dG+vnvf
 4AoKgYbMh+QUBU3eDOL1ypsiHj+AU9jIoLEvkUWPWF2XglOwsa/RVt3FtuScQlL+PLch
 8X5f2/fxH+rLdpA9SZtXKIUuoS3rvJo1KfIgu6JAzNI4DN5AIxp2tgYAS4XDqq/mId+X
 Lr/0+/vgA+K6rvb7MZ+NuK9exgW85H1TaISVcY6IIkMwY4Sgm211omlI9zCBUvF74EWe
 0senuw/4ex7T/Uo3r6JFEZAkcYVSQs7S9Yyd7RsQPVj1cmHIYbtF/l4NNiYA1maUPH9l
 VGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788670722; x=1789275522;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lYfVkceP5S1HVyUvDod78U74pYKuDJC+6hEWu0Cwf2U=;
 b=KA8wO0xwaXxztud31QAtaBqZKogTqfR2DxwYp09BveDgr9o/5QKNxfJQICwlNyw1KF
 kIDRRHhvr6UXucjk/8wW90b2ckc/HhsgHpTbaD03svAtmwjGy+JJeUuexyU1JX1gX14B
 IOVaWvKgZdXXUXD0EUpVaZ5WK5Zz/Q6q5aFAQHixh53LWvxGk8VTimVrHSWsT+DwPtT9
 XyAYXyPKrO0F5qfHEl2jDl33k8NK9QLfdALKAUdJUK4boIL+meTnW33K/aIs9uKFol3j
 SOrNGcwF/++z1AGFQQCYJrrCSGO+YDb2Kom2CEv+21VKyuqbgMtQf2WC6q/1bbI1SpCC
 DAgA==
X-Gm-Message-State: AFuF++kE6ePSfhe/f2VP/gtv8xEN4V07xhQKE2UANzUuCB8qNTKm4r5X
 2qfcGqmK6cyBut4QUA3KLQRQu1X704HO4PP6DY017BnXdwOiyS94nLxZKUDLQ4ja
X-Gm-Gg: AYBFou1bEcOSh5NA3GMkyxa8uJuXYZ+YRlA/NH6G+aDYA76ZnB9M0OT4P9ZGL7W4A7m
 Sz43D1AeT7LBZdNZ6jXMsNc2+3uqrMOXNVCGZtUrMCHk2X04xLzG3dyjB2VSuJwi4eP9thdT53c
 5BrzF03+hdbC0FoIiySYS5cKF7NDzorVch4+KtCEDgIh/ASDrXuVBGrpDq3fOAoFWTI/Zgzbj76
 2z6XJWHh36rfPlE4efXVD6/CGtRocbNJyy0SKH4YYwCtAcOu0JvYwz9xkfKfSPWnaNa31NLmChN
 sC+myFFRUEXK3L4uGaZ/OLSmNbRylKkcUlHBVwE/fdAYL3NJS5kNHvcEgMRnlfjl+UzqO8dItqD
 xA+q3VNWsUuU5yDvVmd9iJOlnuGJl3gTpC72Cx5Aa56FFSHSypaHvxF7pxfSP5vZLtlsoJaWBjV
 SXYY+JqDKDyzDhTBpgZHLppEO/+CyZ1xZV6x8g+NO72nDwPksqvhU1moc+XGISAu3bSIZDdvYY7
 afwjzkEVYdwrUk=
X-Received: by 2002:a05:6512:39d0:b0:5b6:183c:5c9d with SMTP id
 2adb3069b0e04-5b6183c5e63mr2256542e87.59.1788670722148; 
 Sat, 05 Sep 2026 21:58:42 -0700 (PDT)
Received: from kali ([82.162.57.219]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b6166ed098sm1443315e87.22.2026.09.05.21.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 21:58:41 -0700 (PDT)
From: Andrey Polivoda <apolivodaa433@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2] target/i386: ignore VEX.L when emitting VROUNDSS, VROUNDSD,
 VMOVSS and VMOVSD
Date: Sun,  6 Sep 2026 14:58:36 +1000
Message-ID: <20260906045836.1077269-1-apolivodaa433@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=apolivodaa433@gmail.com; helo=mail-lf1-x12e.google.com
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

According to both Volume 2 of Intel 64 and IA-32 Architectures Software
Developer's Manual and Volume 4 of AMD64 Architecture Programmer's Manual,
VEX.L is a "don't care" bit for `VROUNDSS`, `VROUNDSD`, `VMOVSS`, `VMOVSD`.

Currently, QEMU handles VEX.L with these instructions differently:
- In the VMOVSS and VMOVSD case, VEX.L allows to select the register size
  (XMM or YMM), leading to differences between QEMU and the real hardware.
- In `gen_VROUNDSS()` and `gen_VROUNDSD()`, there is an assert which checks
  that `s->vex_l` is not set. When either instruction is encountered with VEX.L
  bit set, the QEMU process crashes with an assertion failure.

These behaviors deviate from real hardware, and in VROUNDSS/VROUNDSD case,
it also allows unprivileged guest userspace to crash the QEMU process itself.

This patch fixes this by removing the incorrect asserts and ensuring
that instructions with a `X86_SIZE_ss/sd` operand are always executed
with 128-bit size to match the behavior of the real Intel and AMD hardware.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Fixes: 790684776861 ("target/i386: reimplement 0x0f 0x3a, add AVX")
Signed-off-by: Andrey Polivoda <apolivodaa433@gmail.com>
---
Hardware tested:
Intel Core i3-6100
Intel Xeon Platinum 8370C (GitHub Codespaces 2-core instance)
AMD EPYC 7763 (GitHub Codespaces 4-core instance)

 target/i386/tcg/decode-new.c.inc | 12 ++++++++++--
 target/i386/tcg/emit.c.inc       |  2 --
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 459452b04e..f069f3d739 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2203,8 +2203,16 @@ static bool decode_op_size(DisasContext *s, X86OpEntry *e, X86OpSize size, MemOp
         }
         /* fall through */
     case X86_SIZE_ps: /* SSE/AVX packed single precision */
-    case X86_SIZE_pd: /* SSE/AVX packed double precision */
-        *ot = s->vex_l ? MO_256 : MO_128;
+    case X86_SIZE_pd: { /* SSE/AVX packed double precision */
+            /*
+             * Force 128-bit size for some VEX.LIG scalar instructions
+             * (VROUNDSS, VROUNDSD, VMOVSS, VMOVSD)
+             */
+            bool is_scalar = (e->s0 == X86_SIZE_ss || e->s0 == X86_SIZE_sd ||
+                              e->s1 == X86_SIZE_ss || e->s1 == X86_SIZE_sd ||
+                              e->s2 == X86_SIZE_ss || e->s2 == X86_SIZE_sd);
+            *ot = (s->vex_l && !is_scalar) ? MO_256 : MO_128;
+        }
         return true;
 
     case X86_SIZE_xh: /* SSE/AVX packed half register */
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index c83ab80940..7e0d439f6d 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -4642,14 +4642,12 @@ static void gen_VPHMINPOSUW(DisasContext *s, X86DecodedInsn *decode)
 static void gen_VROUNDSD(DisasContext *s, X86DecodedInsn *decode)
 {
     TCGv_i32 imm = tcg_constant8u_i32(decode->immediate);
-    assert(!s->vex_l);
     gen_helper_roundsd_xmm(tcg_env, OP_PTR0, OP_PTR1, OP_PTR2, imm);
 }
 
 static void gen_VROUNDSS(DisasContext *s, X86DecodedInsn *decode)
 {
     TCGv_i32 imm = tcg_constant8u_i32(decode->immediate);
-    assert(!s->vex_l);
     gen_helper_roundss_xmm(tcg_env, OP_PTR0, OP_PTR1, OP_PTR2, imm);
 }
 
-- 
2.53.0


