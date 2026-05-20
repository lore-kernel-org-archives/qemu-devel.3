Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0C0CD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmZT-0005sf-JZ; Wed, 20 May 2026 15:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmZQ-0005cK-Px
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:27:08 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmZO-0002mG-Ha
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:27:08 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso41568135e9.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779305224; x=1779910024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QpeR6VNLYWCMRnGcfiT4PidRz3KwpHi6ihVaa90Wad8=;
 b=jsHRkglYQS59mo69PDKcN7udvh7WQFO/Hkr6yEaEmdw2TsSbUfWVjgvBko/lZdVuS+
 p/hPN1VHOUTNF3wCRE8D/0+b5JqB5MUbjVnUFpqb3f2VQCVpLxISElE2hzrU8L4PYwYQ
 5hbiTtR0hup43N7wDvvcmlNKewl4J93cg9hkQ4p4NxYwh/z+78XUTjkw5S8PDPRf/iJY
 HeJztEZX2csTP7SixIx+5XGpIgRoJC76FuOJ/CxdzHTxOwFIuZAMOa9CVn4cQYj1Ysmi
 sXl+FxtKQh0ZE0K2/38b4QgTNAtgXUjOENyfurcVFlX6TYl9a1HI1XuBwmWdRcLwGZ6s
 tgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305224; x=1779910024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QpeR6VNLYWCMRnGcfiT4PidRz3KwpHi6ihVaa90Wad8=;
 b=eYshMwwjk+75URZolHSr6ih8qGv8LVS00YJZb6Kbvg/S5NXnCe+3I/QZIKCGAlDzFp
 YQxkMKQ3ydYZ1dG83F6KevaKQcgPxIdIp25Jtp6wl48dQM9sZb/ShXZ0jZSZb5cb0voR
 W8vTYq5AW1NI1T8QO/WKiLHEuhz8lJfZjw/sVp9szb5RaxmOdyFeQaqzWbuWXARXjmEp
 ltUA4bIttII62l6QJl1JvOVHf7KvWrXibkl/dCj9Vq8tYuiYlGBTsGfSmVD48m77lVI1
 bzXnmgO5b4+vRMZhOTdX+cVX3KBP6y2GE5Zi3MqSOVMSlJMkwKNXSWTZwDwArhmCrkH7
 7sIQ==
X-Gm-Message-State: AOJu0YzPPaXdkjW/HEbuZMOa0pONXW9FosfCtvzae20uORIs48lrpbkQ
 5Ux5qp/ymMb7BpYOKw+t77lRNnEEpyN4beURVj9+4DO5/pnmPrq2WMp0sbau8NQQHtvh7+LPokw
 DEqmbNUw=
X-Gm-Gg: Acq92OGIcZlRvUm43IqqP8LWMk+6mjvTktT7GdsFsoFB5Pi7Kq2YmFaJRNGfIF2dOXq
 LyRmjXWTTf0OvX38kMRVekF4BLM2R8QGR4bftxTRgAxjvGSx6+los47ng1snWNtSLnDPwQIv7/q
 gUZKTbphrkb+CIokrePTyx6MExxOIScobPBB8Nc/ejo7eGaj3Fgn3kdAp8wMT2OhwBmpU29vH6z
 85gi1Vcz/z4iKpNmkj0a3VS7B2W6vLV15z3s0odoyt0TMEGKB7y9AIjx0maYWw/qh4jZumRjRxt
 19wzysWdKLeBVF6YlY0pUeE3w4UN4yiGBU8GIZ5SeY26zUVC8EhQVzfZrQb7Rj1cJvQNGR5jnNA
 jTRR0NJB2EroAbdR6KQGSHrLSUVIWJLSTtV7/eJj+HKNB0NrkIgmFLKC2TIfvR5Zoh4z003i24I
 szpwSwg0/cx4Xv4MSFIU7+mPQJwS7znMWHoHP1c67x+ArWw4580nAlI8gkhecSlclnv8bkh6eH0
 KvYJmkDxu8=
X-Received: by 2002:a05:600c:6098:b0:48f:d1b8:9ab1 with SMTP id
 5b1f17b1804b1-48fe60ecc51mr438657035e9.9.1779305223902; 
 Wed, 20 May 2026 12:27:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec3b18fsm51610522f8f.11.2026.05.20.12.27.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 12:27:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/33] target/mips: add Octeon VMULU instruction
Date: Wed, 20 May 2026 21:23:34 +0200
Message-ID: <20260520192338.40036-30-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520192338.40036-1-philmd@linaro.org>
References: <20260520192338.40036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
Message-Id: <20260520172313.23777-21-philmd@linaro.org>
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
index 10c7d18ad4f..a21f96b5c2a 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -264,3 +264,38 @@ static bool trans_mtp(DisasContext *ctx, arg_r2 *a, unsigned int index)
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


