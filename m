Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69050CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPf34-0006K0-Cm; Wed, 20 May 2026 07:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf22-0003zX-B9
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:24:10 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf1w-0002yT-G2
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:24:08 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-bd373f83042so979914666b.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 04:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779276242; x=1779881042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RzVrX3+IqFTGVGRzZuphthGb6ztiIAMNQ+4ei3zT1o0=;
 b=tdzvf2xem/G2uvtiSXP9GV3KEnwJTQSbbre/nxaB578EhBVzxNgX0elccsaGNO/VbD
 A2R+p5tniUJm5vqcOiXBnquDi3oIS1Kg+UJKtUmLpo45ogl1IY5TlQl33L9so8EJ4sP1
 FB8Lsg9yCkiWPEGGbsvNLU6DojZv7ZK368WToouOrWvkV4XAFS0PWrFtEQzRHxOkqP9u
 OG0ouQt5aA/nv5vr1UAZcuQ4E9Bm7SvH8pDezaqaECWaqmMtoGUXYQDsITpwwbg/h7Zc
 UZMM/DhCR/hraEuPVM6MZakEsz3ZT2OcB6BVAsZr9Kdtcfuko6AmLL2VF9aPQ07oUYtQ
 ll9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779276242; x=1779881042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RzVrX3+IqFTGVGRzZuphthGb6ztiIAMNQ+4ei3zT1o0=;
 b=Dwf9nM1j4ERs/OhrbYI8HLIhmyiocPxN18GOmAlACmtR95G36mwyxlczRj9E6w9A7m
 a0CCY3J8iIGOuzoIVjqM34U2jDI35pRa+ClsQN4DYu7uFbeL4s1JkbsgOBKp7T5eiu05
 hn+QnHdYcqfNJ5rnRq0/lAAue0aLhtr8Uirp1DeYkTJOqz7hjsPKasqvkG2z0l8itag+
 edaBWpWTpZozHV3WBpWrFq4AN3zmxtzJm52FDiXx7z81cuQ4MXmiyC1tBpr5q+88h0Ay
 Sd+skb4DnnPPQPQDlwFfjscGH1KzaMhf/FHDjuANgilj03KP5ggN39CK3Dc0x/VYH0A4
 qP9w==
X-Gm-Message-State: AOJu0Yy/yrR8C+lUcI8i1uulGkPK79U4w+NHydarOVlk7GPoOMHRJMWl
 bfJQIXWl1Q0XXI25QFQ5I1gSuKctHlGScZb9mcP6Hde9lpPqULqeeZGJxqrnt47QDyb9ujuAKbK
 kyjval08=
X-Gm-Gg: Acq92OH4QnsDrRlrCO8SXiwFxlHZ9Oz4Dsj3MVFmCJ2n22uyuNLlQhoRtKWYSJVNogL
 4j1fOkwOaO0rV6fvmf7VnlyJ0GKiAQm1Mvd8/cWcTa7DPk0yu1Gnr4SZ1zvGf9D5UITkRNv4qzz
 o7yDO2Od0CckiP3hTQzRrIS286y6kCfAGCovhPg8s71EhzDAbl44vcdQGYSNmTvj1XfL0IVnMvf
 i2NdgbDRNi3rbnJpXE9cvDYAazom8o7ZanW7l9LPppTbgwf+yXa2pnE+gSZuYrTr3etvPwaCbiG
 jfhb63LpzKEN5BzEjHes8gzHkHFdHMviNhpLVwPFlbNRxCV5jDxDL89AoOwIkuKrSI4LhG3IGLp
 k02jwMgxl1kWl4XWWD1tl87AlTTviVqg7Pem0EslzXjRsqt9OcprDm3JV7QwstXXApr2lTQAw/a
 qAS6x7M7xDnIhdQVqS3qbyTi1ug3zjTNKuQGaQD6mlqYxgDfnXb0Qi8MDIdnpfRc3hRRQ6IClBR
 92Mr01HfCVggH5u
X-Received: by 2002:a05:600c:1d0e:b0:48e:635a:18d9 with SMTP id
 5b1f17b1804b1-48fe60da96bmr354284145e9.15.1779272437949; 
 Wed, 20 May 2026 03:20:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe57944c1sm423923235e9.7.2026.05.20.03.20.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 03:20:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v11 20/24] target/mips: add Octeon VMULU instruction
Date: Wed, 20 May 2026 12:18:01 +0200
Message-ID: <20260520101807.9971-21-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520101807.9971-1-philmd@linaro.org>
References: <20260520101807.9971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

VMULU multiplies the active Octeon multiplier state by rs, adds rt and
queued partial products, returns the low result, and advances P[0]/P[1]
with carry limbs.

Expand the two-limb accumulator operation inline with TCG so the result
and partial-product state stay visible to the optimizer.

Add a mips64/mips64el linux-user TCG smoke test for representative
Octeon multiplier instruction paths.
Include hardware-backed regression coverage for MTP0 P1 zeroing.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/octeon.decode                 |  2 +
 target/mips/tcg/octeon_translate.c            | 35 +++++++++++++
 tests/tcg/mips/user/isa/octeon/octeon-insns.c | 49 +++++++++++++++++++
 3 files changed, 86 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index bb0a9f1d99a..36ced0bb333 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -55,6 +55,8 @@ MTP0         011100 ..... ..... 00000 00000 001001 @r2
 MTP1         011100 ..... ..... 00000 00000 001010 @r2
 MTP2         011100 ..... ..... 00000 00000 001011 @r2
 
+VMULU        011100 ..... ..... ..... 00000 001111 @r3
+
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
 SAA          011100 ..... ..... 00000 00000 011000 @saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 36d268e09c4..7b00bc994b1 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -265,3 +265,38 @@ static bool trans_mtp(DisasContext *ctx, arg_r2 *a, unsigned int index)
 TRANS(MTP0, trans_mtp, 0);
 TRANS(MTP1, trans_mtp, 1);
 TRANS(MTP2, trans_mtp, 2);
+
+static bool trans_VMULU(DisasContext *ctx, arg_VMULU *a)
+{
+    TCGv_i64 x[3], y[3], z[3];
+    TCGv_i64 tmp = tcg_temp_new_i64();
+    TCGv_i64 zero = tcg_constant_i64(0);
+
+    z[0] = y[0] = tcg_temp_new_i64();
+    z[1] = y[1] = tcg_temp_new_i64();
+    z[2] = y[2] = tcg_temp_new_i64();
+    x[0] = tcg_temp_new_i64();
+    x[1] = tcg_temp_new_i64();
+    x[2] = zero;
+
+    /* Z = rs * (mpl1 : mpl0) + rt */
+    gen_load_gpr(tmp, a->rs);
+    gen_load_gpr(y[0], a->rt);
+    tcg_gen_mulu2_i64(x[0], x[1], tmp, oct_mpl[0]);
+    tcg_gen_mulu2_i64(y[1], y[2], tmp, oct_mpl[1]);
+    tcg_gen_addN_i64(3, z, y, x);
+
+    /* X == (0 : p1 : p0) */
+    x[0] = oct_p[0];
+    x[1] = oct_p[1];
+
+    /* Y == (p1 : p0 : tmp) */
+    y[0] = tmp;
+    y[1] = oct_p[0];
+    y[2] = oct_p[1];
+
+    /* (p1 : p0 : rd) = Z + (0 : p1 : p0) */
+    tcg_gen_addN_i64(3, y, z, x);
+    gen_store_gpr(tmp, a->rd);
+    return true;
+}
diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
index 3c3802ebfee..4647e47f371 100644
--- a/tests/tcg/mips/user/isa/octeon/octeon-insns.c
+++ b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
@@ -86,6 +86,53 @@ static uint64_t octeon_sne(uint64_t rs, uint64_t rt)
     return rd;
 }
 
+static uint64_t octeon_vmulu(uint64_t mpl0, uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[mpl0]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x71090008\n\t" /* mtm0 $8, $9 */
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x7109500f\n\t" /* vmulu $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [mpl0] "r" (mpl0), [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_mtp0_zeroes_p1(void)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[mpl0]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x71090008\n\t" /* mtm0 $8, $9 */
+        "move $8, %[p1]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x7109000a\n\t" /* mtp1 $8, $9 */
+        "move $8, $0\n\t"
+        "move $9, $0\n\t"
+        ".word 0x71090009\n\t" /* mtp0 $8, $9 */
+        "move $8, $0\n\t"
+        "move $9, $0\n\t"
+        ".word 0x7109500f\n\t" /* vmulu $10, $8, $9 */
+        "move $8, $0\n\t"
+        "move $9, $0\n\t"
+        ".word 0x7109500f\n\t" /* vmulu $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [mpl0] "r" (0ULL), [p1] "r" (1ULL)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
 int main(void)
 {
     assert(octeon_baddu(0x123, 0x0f0) == 0x13);
@@ -95,6 +142,8 @@ int main(void)
     assert(octeon_seq(0xabc, 0xdef) == 0);
     assert(octeon_sne(0xabc, 0xabc) == 0);
     assert(octeon_sne(0xabc, 0xdef) == 1);
+    assert(octeon_vmulu(5, 7, 11) == 46);
+    assert(octeon_mtp0_zeroes_p1() == 0);
 
     return 0;
 }
-- 
2.53.0


