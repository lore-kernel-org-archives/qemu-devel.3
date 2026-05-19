Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03379CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNDi-0006il-Gk; Tue, 19 May 2026 12:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDV-0006cl-7e
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:50 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDR-0000eB-Dt
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:22:48 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-439712b3416so1159022fac.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207761; x=1779812561; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iNGUkUQb5J29ukIe0u9qyTma9foPdK9x44s0U5JWP3E=;
 b=k4IsYIdssMvI8DFE+6UqK0QgD6wvluybwUAZNRe+6yS1Jk1cNPaUOdWO5pcvV/BaOa
 f1rxPiniNVfcLk+UrShYIBTJHwjPBfmH6gZR070/G8FvVPAn27yVzFR87TNRbNLx7Oht
 bFsiLadeeCJr+6vuc3dEAqAqrf3O1ctGu8dEY6ak0PIQq0z8bm8wmClCUDfftJgN6cwL
 cgyiWS/rduLznPH0+BrOlx9s/lZIY2ESGqCgryLN9MZ9SjNBEpoMr9Kxt8YzvVL9CNBl
 0RMnh0nXPxiWQD6r5JHwuNW0Ks4+euapadUmRrwgNofD0wD4XGaR8jIuv3QQ9h7Y2IDE
 AnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207761; x=1779812561;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iNGUkUQb5J29ukIe0u9qyTma9foPdK9x44s0U5JWP3E=;
 b=dZBTGSQ+itRHw0TviAbzgxHKTmjizaMgifNtd3LtthwbabzqSssPBxG7zjQLPtaptC
 95RC4TMMg1zAC5ePmctm6oNFGNlbsOmrbmNIA9Qomtbrpq7vf2BoxRbkGUW4ucro/Q8h
 LbFysOBvw1+pctXv7n58e+3h8/YC/J7dJkNsa0sdEQgu5HlbWlhmxOFxwmMWMaTyIsKE
 d5cTXVwiXL4/TR8EwoAGUjJ8VmMM00CJF1Z3+n6NEvBT2Xy7jiKEpwgIsI4hS141pvIl
 pfB3GzhvwDtBXDocMlOK8NPkWXRnHpqXbzF1hMp2+EUkM/7OR0K1Owt+GZoQqADHnJT1
 aT5Q==
X-Gm-Message-State: AOJu0YyJ5v4jzTZZ2amRt1Jl7ZmdcHbKxOSAhNkiLNA+Se5pO7Uk+vLz
 gUFoV/36FFNsfbUk7wYkaQoRA0O0mv1f+weZASkYwHZSBykUcuU1dYgf
X-Gm-Gg: Acq92OE/Xi0yrsoYkOkVl86WHdrBZQhilFtKCK6aM6wNpUgo+s19tazdB8ycO6YRM5L
 djoKTP9Xoqqi4+RiI55/J0cfAt/P9ufhDn6Y/QO//dTApt1cPTllCo1w6Sq2Qp6FNDM6+Ni61j2
 dml1K3ghQQIaqqFYb/Q1BpboJRaWqISuGLDfH38LmlR73KhaGmQ8wfbAu/d4Z3Os3IOQDk8gJSN
 nJP03AeeIows6N63NXjYoPtMYijCe7kckqmjFKzMioXbbHvJKI0uxYGvdCN2yKEIGam52qDgSi7
 CGNDbfe2Xu0xkOVfVJIZF7/Mbq+vmQ7/epjbsrQjxkw1wEA9apYwuvMJDT3T04nKRDdj+UiKRWP
 JJ5wH5Z8JLygTIRDDHEgSUFs27QIMuvEkg10pKl9/r6Ixw9MquQ0qt82Kw/WvXK82ah+pOKcY72
 wMWcx4Mv0ZHHlx+OO+LFCa/otv3f/NbiS0PEVHTMY9DdYcHEfbr4pIe5opCUSAtnFP/uBD9Qv74
 vBPtYuP+f6X9Kw+i5M5yHmOalxPsD+/jpAUhOlJT2xQH5qlPYWf86+3zMIvGUB+TueK
X-Received: by 2002:a05:6820:f013:b0:696:8325:f7f5 with SMTP id
 006d021491bc7-69c94330876mr11702214eaf.4.1779207761090; 
 Tue, 19 May 2026 09:22:41 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a95762ceasm7056296fac.13.2026.05.19.09.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:22:40 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 10:22:08 -0600
Subject: [PATCH v9 06/40] target/mips: split Octeon SEQ/SNE decode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v9-6-d7dd735ecddd@gmail.com>
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
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x30.google.com
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
index b7531653e5..5497ddfb10 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -106,52 +106,54 @@ static bool trans_POP(DisasContext *ctx, arg_POP *a)
     return true;
 }
 
-static bool trans_SEQNE(DisasContext *ctx, arg_SEQNE *a)
+static bool do_seq_sne(DisasContext *ctx, const arg_decode_ext_octeon1 *a,
+                       TCGCond cond)
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
+    return do_seq_sne(ctx, a, TCG_COND_EQ);
+}
 
-    if (a->rt == 0) {
-        /* nop */
-        return true;
-    }
+static bool trans_SNE(DisasContext *ctx, arg_SNE *a)
+{
+    return do_seq_sne(ctx, a, TCG_COND_NE);
+}
 
-    t0 = tcg_temp_new_i64();
+static bool do_seqi_snei(DisasContext *ctx, const arg_cmpi *a, TCGCond cond)
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
+    return do_seqi_snei(ctx, a, TCG_COND_EQ);
+}
+
+static bool trans_SNEI(DisasContext *ctx, arg_SNEI *a)
+{
+    return do_seqi_snei(ctx, a, TCG_COND_NE);
+}
+
 static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
 {
     gen_lx(ctx, a->rd, a->base, a->index, mop);

-- 
2.54.0


