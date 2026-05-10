Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AF4CD37B7
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 20:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMAwd-00050a-64; Sun, 10 May 2026 16:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwb-0004xT-D9
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:09 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwZ-0003xL-PE
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:09 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-48270ea6dd1so168751b6e.3
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778445606; x=1779050406; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D2cIM3QuAOkJy58rFuj+CG7dCFjUPZ5FMDF0rI2s0Po=;
 b=JV9mJ5Si9mCJMBmb6tLX08Qn+BcXDC2xWfEInHwFlWtL1SToTXZkOlHskM241JzmIm
 l9xj4NZQT+K8L0BrhFW5TuFYkFf5JeZutGNXgGurghyoWm5pLJOdB5imFvKIBcvpRD3G
 pYyTaSZ+sz8+ogzA5sUKI5GYliivdTNW0TlTantdla7S68qqtPgUu0tSXu7LfXqYhdGw
 bhljPJKSSfZkgC1e5YfEtZwjJEpyesUJsqEGofuasdNJRxcMGCZ+a+E7t4Ni/6ke8qlL
 4kX5/7bRWG0VTRp3x7/KvP9rTmfh0tgCJ8/fEpNpsdbh23JlbH/N3wNGdXf/+UzssURK
 gN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778445606; x=1779050406;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=D2cIM3QuAOkJy58rFuj+CG7dCFjUPZ5FMDF0rI2s0Po=;
 b=eF43QpfSI/zgf8xociUa+jr8BA7gJKEvHDvH0ux/OFe4QokOOI6RdKUOYyyKuHrI6m
 iHYYpL7NzfRZwepSswjsWEgK/lqDeqHn1xmZLkoolfDJfY5EGvjfmChZRsLSUAMF733P
 qmRfJpokXxZqBQCZNNBpKJ1Wbzgj6LSrgZemLZX1NJ6YZc/xOKmEDBJMHBxWHUpdWT6w
 fqbpEjM80r7mqNAkT31ZBiIdjdX21k1/ufwHAsgy5hAaFHhTZh0bHYDEa+A0STU4P4pz
 oFKUAzC0X18aGhyNdU+UPPTzVqk6Vo7bln1vB4YcTG/q5vXpu2QJAPYqGLKMkafzldJp
 X2Pw==
X-Gm-Message-State: AOJu0YzJWP45N8krSRYg6RGxjLVRISSW6WyHVDljLkT8/QqiYH5kkRF7
 HnDzsnT3HkoXFUpqRJSNaQ5z/pfnRW/NaKo+nDj76iYl3wacPlRr4Jdm
X-Gm-Gg: Acq92OFlgbupSNjR6LeoJL1AJruyJhPNJSMGq5v5f+xOVVqOFTAqYINWj5wXY77VCOT
 OICh1WqtcA//vX3lvmGkG1iaqtowiqHpq6MP3WNEN2NMArFd9pX4gFk1QOygXmb0/tr0bjGzFkZ
 GR0s0dELiqyicCIf8c+quFe3XMV9VTn2ZB3rha865+PkgDKDX8VTRbSd3mTQF8mpdse7JP5kpqF
 USHu1Bbn1CH+uCrkfiRZRR/AhioCZTgBZwrvM+Daag13dGWs4o8r7edjWoLsn+L438tGOT3Vdja
 qqPtseFs2Urg12e1PyJs5LcJYtIPtemB6ZNJSIMDZM/N+rDLhtHQUuaYocdcMk64iquPLeNft/F
 DnwtjMiSXeu1vzsq0QRzUls3rJ8KeEI5vcHkMrxPmaN27bZPk/NO0UWKMbxF9B77/lZPO5LPkrV
 aUQ9hw9BVMEAwn9EVP0CXJA1P3ZdA37B6ufSiQK8STcve570mB0+NuuYtozPP4oFP+vMBZeXuC8
 L8trpA41TBxAI44nh1WDqefM729ksZDILaOyxuWZ4cUcmeQnNwAyw==
X-Received: by 2002:a05:6808:1c0b:b0:479:ec96:f4dc with SMTP id
 5614622812f47-4804223fac8mr13181057b6e.18.1778445606560; 
 Sun, 10 May 2026 13:40:06 -0700 (PDT)
Received: from MacBook-Pro.local ([209.245.15.183])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76935637sm18908207b6e.12.2026.05.10.13.40.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 13:40:06 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 10 May 2026 14:39:35 -0600
Subject: [PATCH v5 05/32] target/mips: split Octeon SEQ/SNE decode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-mips-octeon-missing-insns-v2-v5-5-d5d2668d15ab@gmail.com>
References: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
In-Reply-To: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x232.google.com
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

Decode the equality and inequality forms as explicit SEQ/SNE and
SEQI/SNEI instructions rather than using shared generated SEQNE/SEQNEI
entries.

The explicit decoder names match the architectural mnemonics, which makes
the translator entry points and trace/debug output easier to correlate
with the instruction set.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Split the SEQ/SNE decode cleanup out of the Octeon arithmetic
    instruction patch.  (suggested by Philippe Mathieu-Daudé)

Changes v2 -> v3:
  - Remove the decoded ne field now that the instructions are split.
  - Reuse @r3 for SEQ/SNE and pass the TCG condition into a shared
    translator helper.  (suggested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      |  7 +++--
 target/mips/tcg/octeon_translate.c | 52 ++++++++++++++++++++------------------
 2 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 102a05860d..a2bfd0751d 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -30,6 +30,7 @@ BBIT         11 set:1 . 10 rs:5 ..... offset:s16 p=%bbit_p
 # SNEI rt, rs, immediate
 
 @r3          ...... rs:5 rt:5 rd:5 ..... ......
+&cmpi        rs rt imm
 %bitfield_p  0:1 6:5
 @bitfield    ...... rs:5 rt:5 lenm1:5 ..... ..... . p=%bitfield_p
 
@@ -38,8 +39,10 @@ DMUL         011100 ..... ..... ..... 00000 000011 @r3
 EXTS         011100 ..... ..... ..... ..... 11101 . @bitfield
 CINS         011100 ..... ..... ..... ..... 11001 . @bitfield
 POP          011100 rs:5 00000 rd:5 00000 10110 dw:1
-SEQNE        011100 rs:5 rt:5 rd:5 00000 10101 ne:1
-SEQNEI       011100 rs:5 rt:5 imm:s10 10111 ne:1
+SEQ          011100 ..... ..... ..... 00000 101010 @r3
+SNE          011100 ..... ..... ..... 00000 101011 @r3
+SEQI         011100 rs:5 rt:5 imm:s10 101110 &cmpi
+SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 4dd7626835..e69dd56c8e 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -121,52 +121,54 @@ static bool trans_POP(DisasContext *ctx, arg_POP *a)
     return true;
 }
 
-static bool trans_SEQNE(DisasContext *ctx, arg_SEQNE *a)
+static bool do_seqne(DisasContext *ctx, const arg_decode_ext_octeon1 *a,
+                     TCGCond cond)
 {
     TCGv_i64 t0, t1;
 
-    if (a->rd == 0) {
-        /* nop */
-        return true;
-    }
-
     t0 = tcg_temp_new_i64();
     t1 = tcg_temp_new_i64();
 
     gen_load_gpr(t0, a->rs);
     gen_load_gpr(t1, a->rt);
 
-    if (a->ne) {
-        tcg_gen_setcond_i64(TCG_COND_NE, cpu_gpr[a->rd], t1, t0);
-    } else {
-        tcg_gen_setcond_i64(TCG_COND_EQ, cpu_gpr[a->rd], t1, t0);
-    }
+    tcg_gen_setcond_i64(cond, t0, t1, t0);
+    gen_store_gpr(t0, a->rd);
     return true;
 }
 
-static bool trans_SEQNEI(DisasContext *ctx, arg_SEQNEI *a)
+static bool trans_SEQ(DisasContext *ctx, arg_SEQ *a)
 {
-    TCGv_i64 t0;
+    return do_seqne(ctx, a, TCG_COND_EQ);
+}
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
+static bool trans_SNE(DisasContext *ctx, arg_SNE *a)
+{
+    return do_seqne(ctx, a, TCG_COND_NE);
+}
 
-    t0 = tcg_temp_new_i64();
+static bool do_seqnei(DisasContext *ctx, const arg_cmpi *a, TCGCond cond)
+{
+    TCGv_i64 t0;
 
+    t0 = tcg_temp_new_i64();
     gen_load_gpr(t0, a->rs);
 
-    /* Sign-extend to 64 bit value */
-    target_ulong imm = a->imm;
-    if (a->ne) {
-        tcg_gen_setcondi_i64(TCG_COND_NE, cpu_gpr[a->rt], t0, imm);
-    } else {
-        tcg_gen_setcondi_i64(TCG_COND_EQ, cpu_gpr[a->rt], t0, imm);
-    }
+    tcg_gen_setcondi_i64(cond, t0, t0, a->imm);
+    gen_store_gpr(t0, a->rt);
     return true;
 }
 
+static bool trans_SEQI(DisasContext *ctx, arg_SEQI *a)
+{
+    return do_seqnei(ctx, a, TCG_COND_EQ);
+}
+
+static bool trans_SNEI(DisasContext *ctx, arg_SNEI *a)
+{
+    return do_seqnei(ctx, a, TCG_COND_NE);
+}
+
 static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
 {
     gen_lx(ctx, a->rd, a->base, a->index, mop);

-- 
2.54.0


