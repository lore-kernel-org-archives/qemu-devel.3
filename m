Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74459CD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkgd-0007OY-Cs; Wed, 20 May 2026 13:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkgM-0007Ff-Ki
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:26:12 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkgK-0004NJ-Gr
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:26:10 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48fe26a177cso38963365e9.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297967; x=1779902767; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xXzCopTSmSQWKIgzAKEm3uSJ5DjZpN+QCvZ2us+CYFc=;
 b=AJ2qzkYkxwZ9Baig3WTkXeum5Bof4RwhvugbOnX3RSi1jsZ2mzuVb2ZWAnzUx/YoqW
 rIFnDQxV/iViEqxXzg2qyJ3pk/yhCCny8imHYa6CTGArvKlGDWrjx2FnColET1SIB9kN
 NLz/GpozjCnk+KqfH5pMK7MbOC9NeOseG1MXnJcMhvZD0ewOlUH2KuJyO25fmkLuZcnv
 g+Ps68vQqJ8p+ZuPZRvrmfCU/JyoUYj6mU+bwY9ADU5fKUa9VI7XF+ksD9Qy2fnWfqj6
 n+J0bYnKmy10ZbkjU30GpPEYwulKp414dglakcehIPZvEUoPxG/K96dxvqT289gmvJqP
 /eTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297967; x=1779902767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xXzCopTSmSQWKIgzAKEm3uSJ5DjZpN+QCvZ2us+CYFc=;
 b=Ia7T1/+UyoERnYPkYfKpYCq3aNhkeaQg27at7I6lfEvprBrVPrqvK1vLIsmws5sS4U
 SrBuEOPhXbv4o44mjf3EUo92lYR4MRkzA9QH3ffeCzuTppzJ8erEvUtqH/+tEzdofqmv
 u/g4ZFKHn6ZGMELQ+W3iHj8kFdCRifQRKvquL6qdpDBjjbowAK3rUM6vnlyrcP417S99
 wZgBbnR5YJWirgfJNN303g7vVmt8kFNhnNAuQpzeuK5UxeqoFtwet6ev8ZfmavoTHTzU
 6ZoLIG3xAbyMptajPov9VDWCGCZ47ixgqrcQc+6jQLeViMMmcVD5acyQa6lzzQ6eeplj
 vNPQ==
X-Gm-Message-State: AOJu0Yzeq4Xr4PTzdzkIXG7khTkMPJpNlAEE1KItQXyJN0l5QN8Y3M6t
 JmgSvIw4HQBbD6gj83JSI+2pBOrzQe+3+f1/Yp9xvK1WW1ikKASuK7aAoTkW7+++v6uWPkVAdDG
 tLThPNeQ=
X-Gm-Gg: Acq92OGLTmZgQYibpE7YD/kp0XIkMM1m8Jcc2u0ouNXFnUNDnPiUeKNiCXy+mVwDISG
 HdJpPTpk1D5S57dy1SoKMMP77LHdTD7KPJsl+fAxq6PDQAUd3XreUfXmO5Sp1RBj4pM9pYRfTCM
 L5Hc2kTYJO2oU/bDQspE2gJjLK1azEcV1OiP0bR3yOs8LvgizLfZw9BCLf3eY33FGhVQVdurOzt
 QAi44yDutsV4WZdcic5HFBZ7F/chawBBkSZvz2+J1RXwYuXf010XargEKq38VUsigLRbufQy7Fb
 feWoQfX2r6rWXYDF+BW+ChuXxxD8j9EdqmAgd51x4/F+gZeCRzqSMPUfyV1UZ91wSdM2Dz85i5n
 U/nCZG9JC+2CAtz9JkOniPi7wtjqyh83pOY9Nu6yku0ypqX399figYFkftxiadOqIWb1bKbLSpk
 goSvm4SRSTqxKu/HeLFdhFlGIYOdNl5laTQ3w4BVccQttEZQVqxekgw2liavcRR6gyZ+Q88gzc
X-Received: by 2002:a05:600c:3e1b:b0:48a:6fd4:d3d4 with SMTP id
 5b1f17b1804b1-48fe6626c48mr340766155e9.29.1779297966605; 
 Wed, 20 May 2026 10:26:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d52c8bsm7019815e9.8.2026.05.20.10.26.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 10:26:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v12 23/24] target/mips: add Octeon QMAC instructions
Date: Wed, 20 May 2026 19:23:11 +0200
Message-ID: <20260520172313.23777-24-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520172313.23777-1-philmd@linaro.org>
References: <20260520172313.23777-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

From: James Hilliard <james.hilliard1@gmail.com>

QMAC.0x and QMACS.0x multiply the selected signed Q15 halfword lane from
rs by rt<15:0> and accumulate the Q31 product into the Octeon HI/LO
accumulator state.

QMAC updates the full 64-bit HI/LO accumulator. QMACS saturates the
32-bit Q31 result in LO and keeps HI<0> as the sticky saturation flag.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[PMD: Add min32/max32 in trans_QMACS()]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/octeon.decode      |  4 ++
 target/mips/tcg/octeon_translate.c | 62 ++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 4d0ad058347..2d02b4e0bc3 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -28,6 +28,8 @@ BBIT         11 set:1 . 10 rs:5 ..... offset:s16 p=%bbit_p
 # SEQI rt, rs, immediate
 # SNE rd, rs, rt
 # SNEI rt, rs, immediate
+# QMAC.0x rs, rt
+# QMACS.0x rs, rt
 
 @r3          ...... rs:5 rt:5 rd:5 ..... ......
 &cmpi        rs rt imm
@@ -43,6 +45,8 @@ SEQ          011100 ..... ..... ..... 00000 101010 @r3
 SNE          011100 ..... ..... ..... 00000 101011 @r3
 SEQI         011100 rs:5 rt:5 imm:s10 101110 &cmpi
 SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
+QMACS        011100 rs:5 rt:5 00000 000 lane:2 010010
+QMAC         011100 rs:5 rt:5 00000 100 lane:2 010010
 
 &r2          rs rt
 @r2          ...... rs:5 rt:5 ..... ..... ...... &r2
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 7ec942fa347..90bd68cbf25 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -355,3 +355,65 @@ static bool trans_V3MULU(DisasContext *ctx, arg_V3MULU *a)
     gen_store_gpr(tmp, a->rd);
     return true;
 }
+
+static bool trans_QMAC(DisasContext *ctx, arg_QMAC *a)
+{
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+
+    gen_load_gpr(t0, a->rt);
+    gen_load_gpr(t1, a->rs);
+
+    /* t0 = rt<0> * rs<lane> * 2 */
+    tcg_gen_ext16s_i64(t0, t0);
+    tcg_gen_sextract_i64(t1, t1, a->lane * 16, 16);
+    tcg_gen_mul_i64(t0, t0, t1);
+    tcg_gen_add_i64(t0, t0, t0);
+
+    /* Saturate -0x8000 * -0x8000 * 2 = 0x80000000 -> 0x7fffffff */
+    tcg_gen_smin_i64(t0, t0, tcg_constant_i64(INT32_MAX));
+
+    /* HI:LO += t0 */
+    tcg_gen_concat32_i64(t1, cpu_LO[0], cpu_HI[0]);
+    tcg_gen_add_i64(t0, t0, t1);
+    tcg_gen_sextract_i64(cpu_LO[0], t0, 0, 32);
+    tcg_gen_sextract_i64(cpu_HI[0], t0, 32, 32);
+    return true;
+}
+
+static bool trans_QMACS(DisasContext *ctx, arg_QMACS *a)
+{
+    TCGv_i64 min32 = tcg_constant_i64(INT32_MIN);
+    TCGv_i64 max32 = tcg_constant_i64(INT32_MAX);
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+
+    gen_load_gpr(t0, a->rt);
+    gen_load_gpr(t1, a->rs);
+
+    /* t0 = rt<0> * rs<lane> * 2 */
+    tcg_gen_ext16s_i64(t0, t0);
+    tcg_gen_sextract_i64(t1, t1, a->lane * 16, 16);
+    tcg_gen_mul_i64(t0, t0, t1);
+    tcg_gen_add_i64(t0, t0, t0);
+
+    /*
+     * Saturate -0x8000 * -0x8000 * 2 = 0x80000000 -> 0x7fffffff.
+     * Accumulate overflow in HI[0].
+     */
+    tcg_gen_smin_i64(t1, t0, max32);
+    tcg_gen_setcond_i64(TCG_COND_NE, t0, t0, t1);
+    tcg_gen_or_i64(cpu_HI[0], cpu_HI[0], t0);
+
+    /*
+     * LO = sat32(LO + t0)
+     * Accumulate overflow in HI[0].
+     */
+    tcg_gen_ext32s_i64(t0, cpu_LO[0]);
+    tcg_gen_add_i64(t0, t0, t1);
+    tcg_gen_smin_i64(cpu_LO[0], t0, max32);
+    tcg_gen_smax_i64(cpu_LO[0], cpu_LO[0], min32);
+    tcg_gen_setcond_i64(TCG_COND_NE, t0, t0, cpu_LO[0]);
+    tcg_gen_or_i64(cpu_HI[0], cpu_HI[0], t0);
+    return true;
+}
-- 
2.53.0


