Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE6F6CD37AD
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMtG-0002gW-L1; Fri, 08 May 2026 11:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMt1-0002c4-1g
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:08 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMsz-0001cb-Ae
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:06 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-415b23dd6e5so918896fac.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778253183; x=1778857983; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=acW6Nu5e0alWeYzWlHZOT86DgcJ3U9no+Ysusur8uwI=;
 b=UQ61OB4Xmcc07vWlR79wUnmFqDjhrwMVn8bnVPgZT+1d+A+OJro4qUBlGH8ByJF3Ko
 8A6kC5lNkSY9CrQQCZjOZ189iBozPGwDUpB7gLmNLxJpi8lFRemUECYgt7EfZTHH+HQY
 MreaHv/k5flGdemLMyGvz13zboA23y8s34HIcxOvilEd+XQ7yxuJFfZDj1yjB7I662p9
 t/ReFSFiK+e9vDD742c98WXi8AYILhx31psmh8f6H3L/IP7VpwLMrfs4Z+s3iN++KICa
 Lm4NAQrCpPdhCuKbjUaDOvaWcyAN56aPuuiVRgW8ABT094Y2zgU37o0LFWRIRXG3N3qv
 m3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253183; x=1778857983;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=acW6Nu5e0alWeYzWlHZOT86DgcJ3U9no+Ysusur8uwI=;
 b=R7+5///vAscfxb217abYk7daWGRxqBjG9yiXz8KCLLizXKwenP90ViJDBbqFwpP2jr
 jIWxrwsVWdz5LQuK5fZCr9KFk60wQZYv+LBfPRKIhQf0xANo1Mg/rjf7ZxHmV5NHLUVm
 A/fMYcyx0sTjTBwP18MvmQgZgzA1QLi9FrdZi7GuuDIH4kl17AnhiI3w7cILu5wOw1hm
 4Cd6bk1RbJMundnhcsHFvDw7qscxYoNjaKZV1o13GsU4wkRs6Q6+uBBCTOJHcgRl+GaY
 QwnnN3q0PJWIg01l/3w+Pys5fsTD12WzdNRvO4qRUAoOmAEkfcy7FIQMj6W/GAVCF+Bw
 yPfA==
X-Gm-Message-State: AOJu0YzBSiOXcCtNmTCPoBYBYjv3H2j+Pm14m1gCn1qmiq12d3CeQiq5
 qEQ1/GaQThKkdT7g1bixUAzA1pKpCRP4awDZXdknR9cRxgY8/2BaFqCkbzhtVA==
X-Gm-Gg: AeBDieveCRt3mYrYEpNCWIRBmIq4BoYuKHafCvDtyB98j6JzOeTWbQL5gEXdIeEmSiY
 apxcIBwMnJK6tktH1f1xRIaUbUMzUn89ohospjafzngiw4UNZmyP7y8VCy+tURgojtPQrQ2FFwt
 Yn3MKPBMimJkb/fo7ZwNBUn4M88A3A4CYCUttjsRv1Vn51Mf/fhkNlbj8EJ3PruC0F+byzw8KAY
 NGKLGYus24Ioc2/hWsxtuJaBOj1vhJxqN0qdM1DNIoH1x4GRBCwHeXMpFw24/RcKoSGXXqH4mfo
 CrAtyXgIbh3BVcA7DQT+2Ht63/bcyTFvEujP1uc5SxF2Ac/2rn7yA5E3/jQltakAdJfHbzciPlw
 gEFr+/HhnkMOqjzbmISQmQUiHYwHPQvgaqBO5m4swSGFffK2Ik0TXcbUEpjzToaFaV5HR7U2top
 oGOMjW3CW5JPO86AQAPH+2HjrL7JpU0bKJ+8NEjFyR957ZYZ6RjL3SggFgpAOTb7QIHXOISyRiJ
 nVUt8nPs3shw1kY0u/yiUe6Rh7gsq0PflTmFQ3dbzEqcg31vRO9tqeU/Ckqv8dFRoHTIJ+71Oyq
 gvu47fp47XBD62gHlKezKLn3x8ZWptXXi1UW3uAuggQqxInNkqLxH8oC8kgdvglrKonWaQRqpqF
 TGmwE4w==
X-Received: by 2002:a05:6871:230d:b0:424:6bf4:314e with SMTP id
 586e51a60fabf-434f64f0e4emr7998427fac.18.1778253182982; 
 Fri, 08 May 2026 08:13:02 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (71-218-113-237.hlrn.qwest.net. [71.218.113.237])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43557109b7dsm1897904fac.5.2026.05.08.08.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:13:02 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 08 May 2026 09:12:05 -0600
Subject: [PATCH v3 05/32] target/mips: split Octeon SEQ/SNE decode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260508-mips-octeon-missing-insns-v2-v3-5-bcbec96357d9@gmail.com>
References: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
In-Reply-To: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x2a.google.com
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


