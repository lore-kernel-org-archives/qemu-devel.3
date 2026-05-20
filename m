Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A5ACD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmYb-00022M-5P; Wed, 20 May 2026 15:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmY2-0001Kp-F0
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:25:46 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmXx-0002JL-DC
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:25:40 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49021532ebdso21601805e9.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779305135; x=1779909935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VDRhwYEqmpDSzo+v5sp6b2yZnyF/Vt7EldX72tuF8f8=;
 b=ViQEAlsDxe0mgEWCCgQcG05lbcT5tDD52pP/+pp9AyobZ5pEYVscwJ2SbchVei/KWT
 e1l3Y5CsSIKG9agvmvFGIZsXVj5Ak8P+l+Q+Z/TnrzTwErVin2SHEsYWG2tSk3BMabLl
 ILW2R1Ovfwns1Yd2qdhdkt95WgpB4vxq+YP60IvkZuyl5Q/ZAhFsBYLDUUKhpyY4cjc1
 Ba9LVYE8cGmxGUA1sn5A4HG+DU/prhXePV+3UHIqMd+oBZycsdBwybJMEs+4lfIDiMic
 W99GmmuluqP+WgSXDC47rYC2R73f8PaQ0UsVJ+SAre1vF00yt8ujYe5BDJj6CKxIomlU
 4eGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305135; x=1779909935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VDRhwYEqmpDSzo+v5sp6b2yZnyF/Vt7EldX72tuF8f8=;
 b=ftu691tOzvBOx/odpRNriPyE1060T1Dg6tiTtjx16wa1BXSbAz3X4mtw3nta8sdsw4
 ahkcdL0GsXxU5OakJC6pai7sokr6/It/xsc2wakPQGXHI/+IGt3LpUgCRrwRbW5f/ArM
 nw9p2tnrPvi+XsQm8abYpG3bkUOKmZL3BYfPinXqvDmtt5xfonPe74WpS9CTtkRHFL8d
 k2pzcnL0ErcKFcQkWMOz58ePC/KaTMva7ZSsnM4cEBK9B6Xa8zb6wWLZa5lMGw3NM1yk
 qd3C9FopXBW67EhrwRvzkRsnA6krZVAkrBUVQiRRPf9RLj+AQbDaf1Rp4RwfwgiU1AJ8
 SLzQ==
X-Gm-Message-State: AOJu0YxAg8KeSRAMbwLRy0WK5P1cQEvlWMDpB16TNE6BHQnXfq3NEs/B
 gqJ8j0EgbN9/4YTYEFiC1jbkZEtjUaaqm6ilydwzdNCu9MokR/lHo1cVts6nr9SOTKLaIKfZ5V8
 U0j+ak98=
X-Gm-Gg: Acq92OF/K+wJtLTH4JZjUAQbUngrpE5OS8bsO310iVRW2z0pjCFpcqe5Wa1+1X6PxaM
 bEdX64YL3Ntxt6XKfDT/fH7705kclUh7UPXRIkvRnpYL7YkOZFNKsmX4Nfsk6vT3d17DYqgYMnC
 OZ/GPNeipFd1C359cWl2N1Vz7noRfE1RhGVIqg8ws+3Py2ZND+COnyZv09IhUNghg2/6ScaLNlR
 e3HiS9JHNN6WsVtvJYoDYtNk9xeQe3A+bpzzSH9LN9dv4HIw5GDQ+4plUrjt6/zAgF1hLWTKm46
 gvG3sTRUJfF/EGZkCsxqdDEscavd+jz+ZvJfAdCz7stXzzMG87RSD4pg3w4EoRLPxNJdoQlTgvk
 ra7K8UnF3aM3aQ06MhgyDt90yCC57OOdtOMgYcf/kKQJpAObvaZ1U2qqrWVsaM+vxttvLdBsi1u
 SY7OMozuQOYxy96u9CrixxtAGCrH7WZJfwYaARZrEYM4g9hEZmf+k0y3g99pjlPmphVmYWBtKE
X-Received: by 2002:a05:600c:8b67:b0:489:1d74:56d with SMTP id
 5b1f17b1804b1-48fe6325a52mr453794695e9.29.1779305135074; 
 Wed, 20 May 2026 12:25:35 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d34fd4sm13669685e9.2.2026.05.20.12.25.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 12:25:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/33] target/mips: split Octeon SEQ/SNE decode
Date: Wed, 20 May 2026 21:23:21 +0200
Message-ID: <20260520192338.40036-17-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520192338.40036-1-philmd@linaro.org>
References: <20260520192338.40036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Decode the equality and inequality forms as explicit SEQ/SNE
instructions rather than using shared generated SEQNE entries.

The explicit decoder names match the architectural mnemonics, which
makes the translator entry points and trace/debug output easier to
correlate with the instruction set.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[PMD: Split SEQNE (this patch) vs SEQNEI]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20260520172313.23777-9-philmd@linaro.org>
---
 target/mips/tcg/octeon.decode                 |  3 +-
 target/mips/tcg/octeon_translate.c            | 25 +++++++------
 tests/tcg/mips/user/isa/octeon/octeon-insns.c | 36 +++++++++++++++++++
 3 files changed, 52 insertions(+), 12 deletions(-)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 102a05860df..2c54901f77e 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -38,7 +38,8 @@ DMUL         011100 ..... ..... ..... 00000 000011 @r3
 EXTS         011100 ..... ..... ..... ..... 11101 . @bitfield
 CINS         011100 ..... ..... ..... ..... 11001 . @bitfield
 POP          011100 rs:5 00000 rd:5 00000 10110 dw:1
-SEQNE        011100 rs:5 rt:5 rd:5 00000 10101 ne:1
+SEQ          011100 ..... ..... ..... 00000 101010 @r3
+SNE          011100 ..... ..... ..... 00000 101011 @r3
 SEQNEI       011100 rs:5 rt:5 imm:s10 10111 ne:1
 
 &lx          base index rd
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index b7531653e58..dfbb55e3fc3 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -106,29 +106,32 @@ static bool trans_POP(DisasContext *ctx, arg_POP *a)
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
 
+static bool trans_SEQ(DisasContext *ctx, arg_SEQ *a)
+{
+    return do_seq_sne(ctx, a, TCG_COND_EQ);
+}
+
+static bool trans_SNE(DisasContext *ctx, arg_SNE *a)
+{
+    return do_seq_sne(ctx, a, TCG_COND_NE);
+}
+
 static bool trans_SEQNEI(DisasContext *ctx, arg_SEQNEI *a)
 {
     TCGv_i64 t0;
diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
index f406726fc11..3c3802ebfee 100644
--- a/tests/tcg/mips/user/isa/octeon/octeon-insns.c
+++ b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
@@ -54,11 +54,47 @@ static uint64_t octeon_dpop(uint64_t rs)
     return rd;
 }
 
+static uint64_t octeon_seq(uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x7109502a\n\t" /* seq $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_sne(uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x7109502b\n\t" /* sne $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
 int main(void)
 {
     assert(octeon_baddu(0x123, 0x0f0) == 0x13);
     assert(octeon_dmul(0x12345678, 0x10) == 0x123456780);
     assert(octeon_dpop(0xf0f0f0f0f0f0f0f0ULL) == 32);
+    assert(octeon_seq(0xabc, 0xabc) == 1);
+    assert(octeon_seq(0xabc, 0xdef) == 0);
+    assert(octeon_sne(0xabc, 0xabc) == 0);
+    assert(octeon_sne(0xabc, 0xdef) == 1);
 
     return 0;
 }
-- 
2.53.0


