Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76974C79F82
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 01:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2fUS-0007NF-3R; Fri, 04 Sep 2026 21:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1x2fUP-0007N1-LC
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 21:46:41 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <apolivodaa433@gmail.com>)
 id 1x2fUN-0007SL-Mo
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 21:46:41 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-3a35920ff96so22669311fa.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 18:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788572797; x=1789177597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wqaArDEHpu3P6vGWvIu84rn1hNiJ9p5Klcpgwt7LGMw=;
 b=K86EzfrCtua7dd4n4HtnWBabL5Pfoi55bfZ0R/XpQj+nPkTI6Iy8jQ4psUVmkKj9uz
 o/jm6U0TV+5i1d96+vWcPyCodeHfnEFfxLgsc8gQFRGHFBJgS2LFbIFh1zFPBwWp9PaH
 9LmOvbHurPBV4meOxI1Y/iqu1gGLOLpwP11C5OS9g8ormwy3HKJhrKgV1KYfcam3I35L
 8sTEzhhFcJrZWA7WpNkI780wPDiyRX0LOvtN8Qo0UtKjRinu0viJIhP5l8X6tI6owLB3
 sJtAVreLhQh5wK+oiSOdL3BRHob+9SkziVhf34lTYcGJkChNJ9ycH9od66+tPN/PbGSy
 g+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788572797; x=1789177597;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wqaArDEHpu3P6vGWvIu84rn1hNiJ9p5Klcpgwt7LGMw=;
 b=h9GHCj5MnaElzbCpKl6T9PO2exaemFe5C/D+W02LApzYBuLZSrmx3cyJhiUdGUkSUS
 lF07pBQ1HiYz35DN+jCXLySxndIW+O93TP7H7zj+rNFICtstzuJuHmufnKxxCi+mM7r6
 LxfQ98DizLosBia9UGt+jLVqPUOxmq/zEGTFrJ55GwHfd1pNxE50WcX5RdvbciElqtyi
 LtQc8o0S6aVN20tM5dEJNrK8L+JLq+fTPmZ0orEmX9Pt2zAI+qdT23jPnhhxU8eGSV6P
 niqmF+825Q3i9s+Nm6p6F2f3PYZKeEjgSssUzthhkWU2d3AVJ8Bykv0D3KClfJOqlyHV
 4e2g==
X-Gm-Message-State: AFuF++kgJGVV9ueUpg3jzeACfZibfITIW+n3KxjVLMi1bWk71wvIsJev
 bR4i2T1PjvuJUkybsJ+6prvTo3/T/gXSTNB2vSYG6Z1xUedj67jc2ymzL/Jyq7DT9b0=
X-Gm-Gg: AYBFou3xh1mjURV5+rhoXa44lyGdS5WvR3fRue7CLp71Zk3KUouZBBGO1tK1cbZP+jQ
 sGHqVSErl84RZ6cQwunvarmrHMaO5wI5J+Bm/ybCxZLLYZa3trZHP3rq2n4M/6RAezjBb3HV3HH
 gq5Rh7BIiwCBStHGefwQ67jXtn03F5WwLqADaV2aTrVOfD3yKZpFZXHeZ0Faggu/LuvGeq2yu9a
 lkonkdSdemI+Sk+PPwoLyD+wY5FItscX9OLmFXvScuAg4zN7GcR9WpbRYTPGDMjPUn1A3yJQip8
 1+im2abGYf6nz7J9VSivbvZF345JglET4tcms2YJsvy1WuNqZjNXUZ+OjjIzm5yCJ0E6/wrpOlE
 CsKu9WRmmnKBiVyZ2KFEwrtNp2h2/sVM7qublwAIYGNeeyEzof3URNjrN0Sp5jXSRJg6oIF5ZVq
 1OXLMBF6RTctgtethacP1NW62AomyYoguDo2aLN9nJapoCplHt8Lr22I77avmW24ef/m8Ub9ocK
 dNBf9cfTqSqMoQ=
X-Received: by 2002:a05:651c:2122:b0:3a1:8dd6:aada with SMTP id
 38308e7fff4ca-3a372cc8d28mr7816721fa.4.1788572796492; 
 Fri, 04 Sep 2026 18:46:36 -0700 (PDT)
Received: from kali ([82.162.57.219]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a37048de3csm11716751fa.2.2026.09.04.18.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 18:46:34 -0700 (PDT)
From: Andrey Polivoda <apolivodaa433@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] target/i386: ignore VEX.L when emitting VROUNDSS and VROUNDSD
Date: Sat,  5 Sep 2026 11:46:29 +1000
Message-ID: <20260905014629.991586-1-apolivodaa433@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=apolivodaa433@gmail.com; helo=mail-lj1-x231.google.com
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
VEX.L is a "don't care" bit for `VROUNDSS` and `VROUNDSD`.

Currently, QEMU has an assertion in `gen_VROUNDSS()` and `gen_VROUNDSD()`,
which checks that `s->vex_l` is not set. When either instruction is encountered
with VEX.L bit set, the QEMU process crashes with an assertion failure.

Not only does this behavior deviate from real hardware, but it also
allows unprivileged guest userspace to crash the QEMU process itself.

This patch fixes this bug by removing the incorrect assertions and ensuring
that `VROUNDSS` and `VROUNDSD` are always executed with 128-bit size to match
the behavior of the real Intel and AMD hardware.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Fixes: 790684776861 ("target/i386: reimplement 0x0f 0x3a, add AVX")
Signed-off-by: Andrey Polivoda <apolivodaa433@gmail.com>
---
Hardware tested:
Intel Core i3-6100
Intel Xeon Platinum 8370C (GitHub Codespaces 2-core instance)
AMD EPYC 7763 (GitHub Codespaces 4-core instance)

 target/i386/tcg/decode-new.c.inc | 8 ++++++--
 target/i386/tcg/emit.c.inc       | 2 --
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 459452b04e..14abc898fb 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2203,8 +2203,12 @@ static bool decode_op_size(DisasContext *s, X86OpEntry *e, X86OpSize size, MemOp
         }
         /* fall through */
     case X86_SIZE_ps: /* SSE/AVX packed single precision */
-    case X86_SIZE_pd: /* SSE/AVX packed double precision */
-        *ot = s->vex_l ? MO_256 : MO_128;
+    case X86_SIZE_pd: { /* SSE/AVX packed double precision */
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


