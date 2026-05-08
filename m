Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742F1CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMuE-0004Kn-2c; Fri, 08 May 2026 11:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMtJ-0002hm-RQ
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:26 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMtH-0001lr-RB
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:25 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-409de4132b5so1295181fac.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778253202; x=1778858002; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eDUH6gVsEU3s3PR28lsUEIRSGTJ5z86zTutL+l73o/w=;
 b=Hg6YkWW51poSu72/uNtHk4KQV8qQK9+GUnxxszxOBY0BKCSb+tP+Fz4DYfWuzpL10R
 HcvogRqPbCROjSeYRBs6K6DKvKfq9H8mmyvbSbh4YZRzY2HM7j6hoptmiVmhv90KLb4Z
 VOhJeP1JDbItGr1p6onOt8NqyHGlY2flMsWfuFlU/W3lMXaAuLl3o8w9qlKc85CCvKh7
 5GyGVvJ/yFe0eGrt24OLBRkDowDVrKLNxBZrn8UyfTzmpotPryd0S67AQmLfRdr5OTI9
 AbJhNb2ifDpwNt1YQSmbi4aKbIGo7P+fkBAlBUFtGeUr96XcnmTfmQMxo18RdgiaVbzd
 gMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253202; x=1778858002;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eDUH6gVsEU3s3PR28lsUEIRSGTJ5z86zTutL+l73o/w=;
 b=QoRBxSX7QMFqLUm32u+hqj7/2s2vhV+ChiNP9R4u6Ecy8zHWdTvS/Zd+vBK0Mr8Gmv
 XRoOiVXrnZGH+4B1elLFmzesyq3ybs5kBAJVIVf8WyvDWYjaahivJLXzvvBv8J0oJF4/
 ZKSnHPr0Z5fIS0VHJsWZpAu05aBvRUXNXbhNu9Fesjxdsv6R/+LPe0QbP11HScR8Y8ON
 ed+nP0UgF6BB+Ad2MXKAmK+taSSXgjhlQqG371tFKxL8OTdBz8Qpp7MdHoYOMlvgP6yg
 o2Wq8sRg3bpKl/nIYM6o5AD/FS9JaFx6Iq5tN+nOvb6CWRWsqs4JAQiwoAJ3uekFmSr2
 Sm1Q==
X-Gm-Message-State: AOJu0YwzHbVYqOcgitgkxZidQxKZEL/EkAQv+fQ/1+DMFQw2bTbeR3nb
 CH29Ginu7NiGzY9JRKXbylMbFMmJGhne9RcTNJsA1O5TLZod5hN37nG61U/RJQ==
X-Gm-Gg: AeBDietiyFHJB4ZdRf2DJzKom27Tjuts4kOdc7gWOrgS5Oq874pdu12yiyL7sHppCS1
 1tCkq1gBHlbdtUjcuosrCajTtu1KYEnly8seiig6kaZnumBItKkdFX/p8gEGSxNcet7GaP6iZu9
 +9zwu+0WollA0uG9jQxwYscO1GO7QId/eYPvJJLZk+bmMv/c4tbRo+nJXJcPwt7VMbv1v8MxZJy
 o1ReGUxPZh4oERZPqr0rRaeu7Au1DqvhFp30N8xUXestdebkZ3M1mObl4msbG8FImca5M71p3hP
 xaUuEXJ0PHbPnZXIbvP/jZGanESEIdX/NubJDAXNaY2HthxsVa8e84eW+cmoYYE6HXsjNiK8ldD
 J/1BI/GAxhKuciqmlpWvonFqcKlID/qAVUahzEDpcRBxLrD4j56EbIMdPeL7CHRiKN+RuQwel+R
 6ciTe4JMmj8B/GfpC9G53cTNLTY0qq55gnQI3qCZRmMaPaHCazLHp2HfdNqSsQsthw21B61vOWb
 3oEIHyP/atgtunXm0kUmTu5X/j+C3T7qiVjxjrVIQPEDLVsWynUnYVfX4Jl7jAgFxhsQ0RUCI02
 fS/P+e4jn6Tv9gQ3RLZENihbsfLO8slk6Yho44Xd9aWZ2J0bRauwB56izd0oAi1VETPhLZU=
X-Received: by 2002:a05:6870:249b:b0:42c:111b:73fe with SMTP id
 586e51a60fabf-434f64e9244mr8165809fac.18.1778253202497; 
 Fri, 08 May 2026 08:13:22 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (71-218-113-237.hlrn.qwest.net. [71.218.113.237])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43557109b7dsm1897904fac.5.2026.05.08.08.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:13:22 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 08 May 2026 09:12:25 -0600
Subject: [PATCH v3 25/32] target/mips: add Octeon LA* atomic instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260508-mips-octeon-missing-insns-v2-v3-25-bcbec96357d9@gmail.com>
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

Implement the Octeon LA* read-modify-write atomic instruction family:
LAI/LAID, LAD/LADD, LAA/LAAD, LAS/LASD, LAC/LACD, and LAW/LAWD.

These operations are architecturally distinct from SAA/SAAD and are used
by existing Octeon user-mode code for atomic counters, bit operations,
and exchange-style updates.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v1 -> v2:
  - Keep LA* atomics naturally aligned per Octeon L2 transaction
    semantics.
  - Use explicit i64 TCG ops in the LA* translator paths.  (suggested by
    Philippe Mathieu-Daudé)

Changes v2 -> v3:
  - Drop redundant TARGET_LONG_BITS guards from doubleword atomic paths.
    (suggested by Richard Henderson)
  - Group LA* translator wrappers by argument shape instead of adding one
    wrapper per instruction.  (suggested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      |  17 ++++++
 target/mips/tcg/octeon_translate.c | 118 +++++++++++++++++++++++++++++++++++++
 2 files changed, 135 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 54ca92a654..6f4102044f 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -59,6 +59,23 @@ V3MULU       011100 ..... ..... ..... 00000 010001 @r3
 SAA          011100 ..... ..... 00000 00000 011000 @saa
 SAAD         011100 ..... ..... 00000 00000 011001 @saa
 
+&la          base rd
+&laa         base add rd
+@la          ...... base:5 ..... rd:5 ........... &la
+@laa         ...... base:5 add:5 rd:5 ........... &laa
+LAI          011100 ..... 00000 ..... 00010 011111 @la
+LAID         011100 ..... 00000 ..... 00011 011111 @la
+LAD          011100 ..... 00000 ..... 00110 011111 @la
+LADD         011100 ..... 00000 ..... 00111 011111 @la
+LAA          011100 ..... ..... ..... 10010 011111 @laa
+LAAD         011100 ..... ..... ..... 10011 011111 @laa
+LAS          011100 ..... 00000 ..... 01010 011111 @la
+LASD         011100 ..... 00000 ..... 01011 011111 @la
+LAC          011100 ..... 00000 ..... 01110 011111 @la
+LACD         011100 ..... 00000 ..... 01111 011111 @la
+LAW          011100 ..... ..... ..... 10110 011111 @laa
+LAWD         011100 ..... ..... ..... 10111 011111 @laa
+
 &zcb         base
 ZCB          011100 base:5 00000 00000 11100 011111 &zcb
 ZCBT         011100 base:5 00000 00000 11101 011111 &zcb
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index fe1ddeb973..cdaa926389 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -189,6 +189,112 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
     return true;
 }
 
+static bool trans_la_common(DisasContext *ctx, int base, int add_reg, int rd,
+                            int64_t imm, bool dw)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+
+    gen_base_offset_addr(ctx, addr, base, 0);
+
+    if (dw) {
+        TCGv_i64 value = tcg_temp_new_i64();
+        TCGv_i64 old = tcg_temp_new_i64();
+        MemOp amo = mo_endian(ctx) | MO_UQ | MO_ALIGN;
+
+        if (add_reg >= 0) {
+            gen_load_gpr(value, add_reg);
+        } else {
+            tcg_gen_movi_i64(value, imm);
+        }
+
+        tcg_gen_atomic_fetch_add_i64(old, addr, value, ctx->mem_idx, amo);
+        gen_store_gpr(old, rd);
+    } else {
+        TCGv_i64 old = tcg_temp_new_i64();
+        TCGv_i32 value32 = tcg_temp_new_i32();
+        TCGv_i32 old32 = tcg_temp_new_i32();
+        MemOp amo = mo_endian(ctx) | MO_UL | MO_ALIGN;
+
+        if (add_reg < 0) {
+            tcg_gen_movi_i32(value32, imm);
+        } else {
+            TCGv_i64 value = tcg_temp_new_i64();
+
+            gen_load_gpr(value, add_reg);
+            tcg_gen_extrl_i64_i32(value32, value);
+        }
+
+        tcg_gen_atomic_fetch_add_i32(old32, addr, value32, ctx->mem_idx, amo);
+        tcg_gen_ext_i32_i64(old, old32);
+        gen_store_gpr(old, rd);
+    }
+
+    return true;
+}
+
+static bool trans_law_common(DisasContext *ctx, int base, int add_reg, int rd,
+                             int64_t imm, bool dw)
+{
+    TCGv_i64 addr = tcg_temp_new_i64();
+
+    gen_base_offset_addr(ctx, addr, base, 0);
+
+    if (dw) {
+        TCGv_i64 value = tcg_temp_new_i64();
+        TCGv_i64 old = tcg_temp_new_i64();
+        MemOp amo = mo_endian(ctx) | MO_UQ | MO_ALIGN;
+
+        if (add_reg >= 0) {
+            gen_load_gpr(value, add_reg);
+        } else {
+            tcg_gen_movi_i64(value, imm);
+        }
+
+        tcg_gen_atomic_xchg_i64(old, addr, value, ctx->mem_idx, amo);
+        gen_store_gpr(old, rd);
+    } else {
+        TCGv_i64 old = tcg_temp_new_i64();
+        TCGv_i32 value32 = tcg_temp_new_i32();
+        TCGv_i32 old32 = tcg_temp_new_i32();
+        MemOp amo = mo_endian(ctx) | MO_UL | MO_ALIGN;
+
+        if (add_reg >= 0) {
+            TCGv_i64 value = tcg_temp_new_i64();
+
+            gen_load_gpr(value, add_reg);
+            tcg_gen_extrl_i64_i32(value32, value);
+        } else {
+            tcg_gen_movi_i32(value32, imm);
+        }
+
+        tcg_gen_atomic_xchg_i32(old32, addr, value32, ctx->mem_idx, amo);
+        tcg_gen_ext_i32_i64(old, old32);
+        gen_store_gpr(old, rd);
+    }
+
+    return true;
+}
+
+static bool do_lai(DisasContext *ctx, arg_la *a, int64_t imm, bool dw)
+{
+    return trans_la_common(ctx, a->base, -1, a->rd, imm, dw);
+}
+
+static bool do_laa(DisasContext *ctx, arg_laa *a, bool dw)
+{
+    return trans_la_common(ctx, a->base, a->add, a->rd, 0, dw);
+}
+
+static bool do_las(DisasContext *ctx, arg_la *a, int64_t imm, bool dw)
+{
+    return trans_law_common(ctx, a->base, -1, a->rd, imm, dw);
+}
+
+static bool do_law(DisasContext *ctx, arg_laa *a, bool dw)
+{
+    return trans_law_common(ctx, a->base, a->add, a->rd, 0, dw);
+}
+
 static bool trans_ZCB(DisasContext *ctx, arg_zcb *a)
 {
     TCGv_i64 addr = tcg_temp_new_i64();
@@ -299,6 +405,18 @@ static bool trans_vmul(DisasContext *ctx, arg_decode_ext_octeon1 *a,
 
 TRANS(SAA,  trans_saa, MO_UL);
 TRANS(SAAD, trans_saa, MO_UQ);
+TRANS(LAI,  do_lai, 1, false);
+TRANS(LAID, do_lai, 1, true);
+TRANS(LAD,  do_lai, -1, false);
+TRANS(LADD, do_lai, -1, true);
+TRANS(LAA,  do_laa, false);
+TRANS(LAAD, do_laa, true);
+TRANS(LAS,  do_las, -1, false);
+TRANS(LASD, do_las, -1, true);
+TRANS(LAC,  do_las, 0, false);
+TRANS(LACD, do_las, 0, true);
+TRANS(LAW,  do_law, false);
+TRANS(LAWD, do_law, true);
 TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);

-- 
2.54.0


