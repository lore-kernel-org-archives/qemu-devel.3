Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D481ECD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPf8I-00063u-Ly; Wed, 20 May 2026 07:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf7y-0005ib-Bh
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:30:20 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf7u-0004mc-Vu
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:30:17 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so56218465e9.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 04:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779276613; x=1779881413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ue5uZ4vIh0+aNYybTiW3+rO1WQzqrnSqYcaxeLZNSTk=;
 b=aGe9xCwQkZLjvEH7mkzaALe6zFL8XBhuMnf/DFXuIMp4t/PrsBg+tuyN4B7hfYouFd
 gRqi5RvGG1C/tj3EIJ4xN4CAT82c3ryFNzhTYiCVhrocLo0tf/jqWlvCvyPzIs8Xyu8w
 hZgveyNh2KOkgjkln8Zd4aFzJnGcIryPKh8qm2lOc9q1fQ1YusjRfKwTweAXt9lgrLUJ
 imcxQqYP81vwwxO1myFRNL4SKc06ZpNHjSE25dPzlXzCijjshq7sqog8ljn7Cy9ajCvr
 1tCd3zXYPIAB4eBM+amLTSZQRBz1OZeKhkI+yUEbklNor4bdkUiGmVAECNAegjwZaviS
 xNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779276613; x=1779881413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ue5uZ4vIh0+aNYybTiW3+rO1WQzqrnSqYcaxeLZNSTk=;
 b=nGTjtYX7Ja26HgZRx7ek4yZOAgzQhLCE8p4yoicGwFaHKtqsSw4EM4hn0g708ghPQK
 aUVRQ0qjRK2h+q3Eu8pUALzLE6m5cXaNmHlS2xo23Y4oJG8OEzikxvaNppijOcjywmaI
 k/1QTdCOTiKEK0gNZPDVZtJDyiVgcYGsS8r+7w9k8WFXY6VEzAdiezjwJfWOOmrHk4Aj
 u8mbR0pa1UXyO4OyFKwAwinPF+vIK+n9F5Ol0mm1tsydc/ieBhIIjN2qtjxGpL6BOvht
 txirAJglyNJbZ62zY9GDOdsfIAVExCkODJFesx01EdKmVY310oy5E70uty2q6TD3c0WH
 8omw==
X-Gm-Message-State: AOJu0Yy9Gso8ZOVLxpNv9uMzsX7h4msyV/Y9TQHtEiEDp1qZfYLLqzvp
 Watrqyp0uvBh8g/z9mC9hd+kAuoSx4jL6EwBntdAKmkPSjIiI747YVkJz5IOy2F0osfBwQnB6f1
 vqvwEmi0=
X-Gm-Gg: Acq92OF0X0ZEkaljlmsNYouzGzFUeUBAR7dRFnp5sovBiPwWxDi+uFbQBULA6XZL6C0
 4fM49KGlKSI98BFdWK7NSinYUBDstdJCljNotqbAFnf3OPk1ZgBHuHL79OSc7tTG8G4uEt8fKKg
 LMhhGWBR8FLvWebxhJrvyb25HfGmyE59X8yQ5TGCdAy79Ml7oM7wnoGsJp8bmwXf4xZ+HBmtnK2
 XSV/fHfjf7tPVTSNe5JL6emL2aMiohVV6z8RA33SkoGqOq0P/UHPzOQPJ6F+qMJRuOIh4R9dP3l
 YyQxGfy4EFzchodozP5BxvqWJT1qUIRCGNB0N1jdn+N+gmpyjcaOP2/PzZ+GvMgOnwpY9U/StoE
 iEcBbJygM7me4bJEPO9rIkUX3nHaG4kVv84LhpR43oLbwt5R9ptozRg86G47ywKBY/dvSyw/yWC
 JUMwlTLXNRYFED4oXPUMifpZoGJYTIVp0dd7wqXsMeFzFDnIo4gPPx8yCX2aWfc8hElCN23rnft
 3Q7wx6uIufJYxPF
X-Received: by 2002:a05:600c:8905:b0:48e:5d91:cffb with SMTP id
 5b1f17b1804b1-48fe60e7d6emr300681585e9.10.1779272445131; 
 Wed, 20 May 2026 03:20:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe58c04sm129624985e9.20.2026.05.20.03.20.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 03:20:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v11 21/24] target/mips: add Octeon VMM0 instruction
Date: Wed, 20 May 2026 12:18:02 +0200
Message-ID: <20260520101807.9971-22-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520101807.9971-1-philmd@linaro.org>
References: <20260520101807.9971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

VMM0 multiplies MPL[0] by rs, adds rt and the queued P[0] partial
product, returns the low result, and feeds that result back into MPL[0].
It sets MPL[1] to zero and clears partial products.

Include hardware-backed regression coverage for VMM0 MPL1 zeroing.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/octeon.decode                 |  1 +
 target/mips/tcg/octeon_translate.c            | 16 ++++++
 tests/tcg/mips/user/isa/octeon/octeon-insns.c | 55 +++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 36ced0bb333..f9c32e1dee1 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -56,6 +56,7 @@ MTP1         011100 ..... ..... 00000 00000 001010 @r2
 MTP2         011100 ..... ..... 00000 00000 001011 @r2
 
 VMULU        011100 ..... ..... ..... 00000 001111 @r3
+VMM0         011100 ..... ..... ..... 00000 010000 @r3
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 7b00bc994b1..e51d3e6cf78 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -300,3 +300,19 @@ static bool trans_VMULU(DisasContext *ctx, arg_VMULU *a)
     gen_store_gpr(tmp, a->rd);
     return true;
 }
+
+static bool trans_VMM0(DisasContext *ctx, arg_VMM0 *a)
+{
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    gen_load_gpr(tmp, a->rs);
+    tcg_gen_mul_i64(oct_mpl[0], oct_mpl[0], tmp);
+    gen_load_gpr(tmp, a->rt);
+    tcg_gen_add_i64(oct_mpl[0], oct_mpl[0], tmp);
+    tcg_gen_add_i64(oct_mpl[0], oct_mpl[0], oct_p[0]);
+    gen_store_gpr(oct_mpl[0], a->rd);
+
+    tcg_gen_movi_i64(oct_mpl[1], 0);
+    octeon_zero_partial_product_state();
+    return true;
+}
diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
index 4647e47f371..9153e37e9e0 100644
--- a/tests/tcg/mips/user/isa/octeon/octeon-insns.c
+++ b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
@@ -105,6 +105,59 @@ static uint64_t octeon_vmulu(uint64_t mpl0, uint64_t rs, uint64_t rt)
     return rd;
 }
 
+static uint64_t octeon_vmm0(uint64_t mpl0, uint64_t p0,
+                            uint64_t rs, uint64_t rt)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[mpl0]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x71090008\n\t" /* mtm0 $8, $9 */
+        "move $8, %[p0]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x71090009\n\t" /* mtp0 $8, $9 */
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        ".word 0x71095010\n\t" /* vmm0 $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [mpl0] "r" (mpl0), [p0] "r" (p0),
+          [rs] "r" (rs), [rt] "r" (rt)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_vmm0_zeroes_mpl1(void)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[mpl0]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x71090008\n\t" /* mtm0 $8, $9 */
+        "move $8, %[mpl1]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x7109000c\n\t" /* mtm1 $8, $9 */
+        "move $8, %[vmm0_rs]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x71095010\n\t" /* vmm0 $10, $8, $9 */
+        "move $8, %[vmulu_rs]\n\t"
+        "move $9, $0\n\t"
+        ".word 0x7109500f\n\t" /* vmulu $10, $8, $9 */
+        "move $8, $0\n\t"
+        "move $9, $0\n\t"
+        ".word 0x7109500f\n\t" /* vmulu $10, $8, $9 */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [mpl0] "r" (1ULL), [mpl1] "r" (1ULL),
+          [vmm0_rs] "r" (2ULL), [vmulu_rs] "r" (1ULL)
+        : "$8", "$9", "$10");
+
+    return rd;
+}
+
 static uint64_t octeon_mtp0_zeroes_p1(void)
 {
     uint64_t rd;
@@ -143,6 +196,8 @@ int main(void)
     assert(octeon_sne(0xabc, 0xabc) == 0);
     assert(octeon_sne(0xabc, 0xdef) == 1);
     assert(octeon_vmulu(5, 7, 11) == 46);
+    assert(octeon_vmm0(5, 13, 7, 11) == 59);
+    assert(octeon_vmm0_zeroes_mpl1() == 0);
     assert(octeon_mtp0_zeroes_p1() == 0);
 
     return 0;
-- 
2.53.0


