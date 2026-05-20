Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDDBCD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmZn-0007GC-B4; Wed, 20 May 2026 15:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmZl-00076e-B1
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:27:29 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmZj-0002oz-Fk
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:27:29 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so31363085e9.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779305245; x=1779910045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9R3PcGs2tio7rexPxzO2gvjQ7k62qZs4S+2+VV+xBjs=;
 b=ua1vM2OQh8hkB++vg0ID42CPYTaSDJdzP4NswnMLAIKQErwmqfILF17PSaGqEzbhkp
 Ui2Ts7StaAe24bUwrM7L2nKAxi67ql2gcphFCjq1LLNXR6dYbR1xCdgq+qK28/XW8VYm
 gb144i/bVGwSGDSuTEVBx1j46kLdb1IkrLzGrAB5xRXW7Kr55h8+QfnMufguq0kSzn90
 RhmGr9kIXVCTRhZQ7T4imJ6MpjY4wp8qA4deph4VBwC3N72oJR2fqgU1I2H/PVyPowpA
 39dGlszSZOVbcp+PzU++w2EGK6u965wcV5hfo6iX9kd6cXWId7FDqaod7W0J8ZhApX3e
 DAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305245; x=1779910045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9R3PcGs2tio7rexPxzO2gvjQ7k62qZs4S+2+VV+xBjs=;
 b=Jt3ti2/rwSZgKkRBYcgacY7oGWIkod/FKY8OjPYtn3ncOpv17o+Kkm3VhtcoLEwhbL
 DeaJVm7ct4ZaBbDhvqtKdmbsEnE32XUZdsp29B9TyFkaEiDbDVA8VcFvRUefhN2QbWuj
 n5wZXgGRjHLiOcneNNzDUZCYwxku4O24/TsMjqUD2/r5Opel0ewLbgARUrfLtS0rx/7t
 JTYxod2jmXR/gnnPiWg+zm/U1Ja92YziGduQ0sX7LhUDiVxMxcqX+KJknDMAb4f9HboK
 1Dwg7cacRt7N76OTPiQMKeSORmvcMEA1PXo1eo15HgIMNgVAk90QUfVPXEUC0U1kxzpj
 ajUg==
X-Gm-Message-State: AOJu0YzNmlUbz/nGX4qhaQA59Axl5rDmZl9FFSPAwlO9whRYhfbcH6So
 BTUvquTfvRawW/YQ/JztopZOCa2Jb/v3HcKTHmPjoqzDOLd62pGPGvKu0rQbk6nUAVhvTSMGhuQ
 niMo5T1w=
X-Gm-Gg: Acq92OF9+Du45E/E9ytDXV/JmckxgqI8cHeFZ4qHVddAcMnvHP1q6P+/i3HF2LkFrdq
 dAvdV1za34m3jiIpi6tw1rgBNHNBeBq5uqVMqYxL+NW63O9YUNHihPAFG5BdCH2mLzJ+EcvkvJP
 SXj5Ga7whfM4QEFZdfHwkCIYxnWA1j8po/1fTogUGONKwAHVd0l0epi3oCIlDBpbHBlRVp8dKjF
 Z4xqD4h1apk7MPGTivDH9rojl6aQhFnZ7iFj0of0ljSyChAypPy9Pq1eieOTLEl40m63JUKZ2Jv
 /ZBykgi1YT4JL3jgnvQHwtaBh3QW/F4P03ZrSxVBDTtUNOwkp2xlxmUHOD2ezCtZZEhlBAJzaXZ
 JFW9zSlpmmCvSgZu2cx+LmADz+9WElMUkYur996BFrv30wHR0hdTloXt6KClOTJ8rDMC9EQGP06
 /hG9CoqXY9V2I9kZBHZWNmK3dYZ/yomaZH+i6BD+xTmpzDz4c8lVX71AIVZjcwDyM5YhPiCJ6V
X-Received: by 2002:a05:600c:1f8f:b0:490:2153:2c3d with SMTP id
 5b1f17b1804b1-49021532e9cmr108687525e9.20.1779305245231; 
 Wed, 20 May 2026 12:27:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe60fc0sm162264355e9.21.2026.05.20.12.27.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 12:27:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/33] target/mips: add Octeon QMAC instructions
Date: Wed, 20 May 2026 21:23:37 +0200
Message-ID: <20260520192338.40036-33-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520192338.40036-1-philmd@linaro.org>
References: <20260520192338.40036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
Message-Id: <20260520172313.23777-24-philmd@linaro.org>
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


