Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C89CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNE0-00070K-Fv; Tue, 19 May 2026 12:23:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDz-0006z4-1B
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:23:19 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDw-0000qZ-7i
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:23:18 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-69d42abd04cso1019611eaf.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207795; x=1779812595; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fFjHOeiMjObCF6UYUem3JfrqODv07eCgyys7BgfWqXc=;
 b=gidjRYyNCOKG+KQoSBoG8i7Ve3DTIfy7bWmrkHSYZSD2RqJ3maSUz/oalIbpH/uEEa
 uvxW7+fk3O6MJoDtmvMWPQuyoBY1GSEy4s8aQaEFLkpOgA+6liE4Pl44Hc4aYUS94n0T
 dBYRduwVd8phMCnmZUbNHBEYejJNXZjwBN5cbks6ghLJ+TT+1Ess/OGnMjAOBJ+U8mcR
 vnzNTy1N7siyp3iEH7r+YubJif4YJ8xnrOY8raFe+cfc9lfzBD5binkIyiyOwOoLCIzJ
 J8bVGZnti3EgcBxLbFx0I4JgjidNxswmv1I8Iis+K1KLT7y7Cq+Mq31kiCxk0WtrowcU
 5N0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207795; x=1779812595;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fFjHOeiMjObCF6UYUem3JfrqODv07eCgyys7BgfWqXc=;
 b=f/P4AKJYd2lsnqRxJlCA4/PyWg48nV07G75VnjZ+Ws9AtkdDTMHK70Ro95+4HW1YyW
 FX8AG6vApj1ROsKjRVdyqz4th2lIzVEESnHPJquTrV7uffXneAMhMK/6SpZf5YYg9QKN
 4bw8BQNuvQ4UdL/com+EhqWcbGpgqMnHE1ic+xIwwP1WTLVX1GbCMvVOcZVL6KdwZfH8
 6qa5p8xgSgm54Coun0d59eSjTOs4SlRNCJL+u8iF/nt7+YpERzmrMBUlCEtg+tgT9kZ5
 67pb5hTHRDW6Q6C8yKYMYGDpmDfgoKfD2X6M6yRnSv9ND9lYhVhmdzHNxS8k6CfZOF/C
 R7ew==
X-Gm-Message-State: AOJu0Yzjylwdw3qxOtxkvCPrrYGu9peYC5O04LJjacTyTH14ORjhngwm
 Rpn5o5EyLWtwBPcHAG1eM+Aisw/bBWDBmhV31RO/i0uC/D7kJ3oTaVDm
X-Gm-Gg: Acq92OHyjwBGu8CCpCSSd/oY3FnDJgHQseZwEmhpItMEC6uBhIUZ8zPyKMxb4gDm7ep
 0k6W0h3AWX8cCsAaUToVyCzsJrc5sz1KtEcmg3KZnT6xfz1KaEc02rT0xSSB3oTIcDhsIuYxXC1
 IKhJ5qxpuJzfkscdzW44sC/K6k6yzTysn3SyWPpUQjYmy9XJqiTBWg/YSqv5TtUjprOjI/2Yj68
 3ZplY9gkkDEX2CO6Ax87USad3IgZRJ6LpWeK3vLhaWZycSKcvgdDYX3rAgLevxnis/L148D6Rkz
 4Y9CE0/CcOsZ1ew2/pJRDvN8KcTtQ+ZvXklCGWgENn8Igji2RgFlnLUOY7BNy8ajlZhTPk2xqa4
 BZa30TkDNJ0EricziPJOjXfDtQV2FcZqqj8cOjjiXRBkrKBjyAoghrNXyXI093lza5fxQzexNbb
 5kHrPNcz3E3DXqC7pA25KUIEdYWWiCWQLHlInRDQHUeAeyAOPgT35ueGhRinzR4qKIY7LMsaFjs
 jmMpCOp+pM7JIlP9xpViqrPHUQ2hlevDR/rvWFjyRj4pqfECCLSzI9rtEuNPirfvJQ8
X-Received: by 2002:a05:6820:627:b0:694:8d83:a344 with SMTP id
 006d021491bc7-69c942d9c84mr12701845eaf.16.1779207794943; 
 Tue, 19 May 2026 09:23:14 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a95762ceasm7056296fac.13.2026.05.19.09.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:23:14 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 10:22:41 -0600
Subject: [PATCH v9 39/40] tests/tcg/mips: cover Octeon COP2, QMAC and CvmCount
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v9-39-d7dd735ecddd@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oo1-xc2e.google.com
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

Extend the Octeon linux-user smoke test with AES key and key-length
DMTC2/DMFC2 readback checks, QMAC/QMACS fixed-point accumulator checks,
and an RDHWR $31 monotonicity check.

The COP2 readback cases exercise the explicit COP2 decodetree entries
and direct TCG register-transfer paths introduced by the decode split.
The QMAC and CvmCount cases keep the fixed-point accumulator and RDHWR
paths covered by the same Octeon smoke binary.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v8 -> v9:
  - Combine the v8 COP2 selector readback and QMAC/CvmCount test patches.
  - Fix the commit message to refer to RDHWR $31.

Changes v7 -> v8:
  - Split AES COP2 selector readback coverage out of the COP2 crypto core
    patch.

Changes v5 -> v6:
  - Add QMAC/QMACS and CvmCount smoke coverage.
---
 tests/tcg/mips/user/isa/octeon/octeon-insns.c | 128 ++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
index 9153e37e9e..1dbdd9f52a 100644
--- a/tests/tcg/mips/user/isa/octeon/octeon-insns.c
+++ b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
@@ -129,6 +129,59 @@ static uint64_t octeon_vmm0(uint64_t mpl0, uint64_t p0,
     return rd;
 }
 
+static uint64_t octeon_qmac_lo(uint64_t rs, uint64_t rt, uint64_t lo)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        "mtlo %[lo]\n\t"
+        "mthi $0\n\t"
+        ".word 0x710904d2\n\t" /* qmac.03 $8, $9 */
+        "mflo %[rd]\n\t"
+        : [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt), [lo] "r" (lo)
+        : "$8", "$9");
+
+    return rd;
+}
+
+static uint64_t octeon_qmacs_state(uint64_t rs, uint64_t rt, uint64_t lo)
+{
+    uint64_t hi, rd;
+
+    asm volatile(
+        "move $8, %[rs]\n\t"
+        "move $9, %[rt]\n\t"
+        "mtlo %[lo]\n\t"
+        "mthi $0\n\t"
+        ".word 0x71090012\n\t" /* qmacs.00 $8, $9 */
+        "mfhi %[hi]\n\t"
+        "mflo %[rd]\n\t"
+        : [hi] "=r" (hi), [rd] "=r" (rd)
+        : [rs] "r" (rs), [rt] "r" (rt), [lo] "r" (lo)
+        : "$8", "$9");
+
+    return ((hi & 1) << 32) | (rd & 0xffffffff);
+}
+
+static uint64_t octeon_rdhwr31_non_decreasing(void)
+{
+    uint64_t first, second;
+
+    asm volatile(
+        ".word 0x7c08f83b\n\t" /* rdhwr $8, $31 */
+        ".word 0x7c09f83b\n\t" /* rdhwr $9, $31 */
+        "move %[first], $8\n\t"
+        "move %[second], $9\n\t"
+        : [first] "=r" (first), [second] "=r" (second)
+        :
+        : "$8", "$9");
+
+    return second >= first;
+}
+
 static uint64_t octeon_vmm0_zeroes_mpl1(void)
 {
     uint64_t rd;
@@ -186,6 +239,70 @@ static uint64_t octeon_mtp0_zeroes_p1(void)
     return rd;
 }
 
+static uint64_t octeon_cop2_key0_readback(uint64_t value)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[value]\n\t"
+        ".word 0x48a80104\n\t" /* dmtc2 $8, AES_KEY0 selector */
+        ".word 0x482a0104\n\t" /* dmfc2 $10, AES_KEY0 selector */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [value] "r" (value)
+        : "$8", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_cop2_key2_readback(uint64_t value)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[value]\n\t"
+        ".word 0x48a80106\n\t" /* dmtc2 $8, AES_KEY2 selector */
+        ".word 0x482a0106\n\t" /* dmfc2 $10, AES_KEY2 selector */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [value] "r" (value)
+        : "$8", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_cop2_key3_readback(uint64_t value)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[value]\n\t"
+        ".word 0x48a80107\n\t" /* dmtc2 $8, AES_KEY3 selector */
+        ".word 0x482a0107\n\t" /* dmfc2 $10, AES_KEY3 selector */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [value] "r" (value)
+        : "$8", "$10");
+
+    return rd;
+}
+
+static uint64_t octeon_cop2_keylength_readback(uint64_t value)
+{
+    uint64_t rd;
+
+    asm volatile(
+        "move $8, %[value]\n\t"
+        ".word 0x48a80110\n\t" /* dmtc2 $8, AES_KEYLENGTH selector */
+        ".word 0x482a0110\n\t" /* dmfc2 $10, AES_KEYLENGTH selector */
+        "move %[rd], $10\n\t"
+        : [rd] "=r" (rd)
+        : [value] "r" (value)
+        : "$8", "$10");
+
+    return rd;
+}
+
 int main(void)
 {
     assert(octeon_baddu(0x123, 0x0f0) == 0x13);
@@ -195,10 +312,21 @@ int main(void)
     assert(octeon_seq(0xabc, 0xdef) == 0);
     assert(octeon_sne(0xabc, 0xabc) == 0);
     assert(octeon_sne(0xabc, 0xdef) == 1);
+    assert(octeon_qmac_lo(0x0003000000000000ULL, 2, 1) == 13);
+    assert(octeon_qmacs_state(1, 1, 0x7ffffffe) == 0x17fffffffULL);
+    assert(octeon_qmacs_state(0x8000, 0x8000, 0) == 0x17fffffffULL);
+    assert(octeon_rdhwr31_non_decreasing());
     assert(octeon_vmulu(5, 7, 11) == 46);
     assert(octeon_vmm0(5, 13, 7, 11) == 59);
     assert(octeon_vmm0_zeroes_mpl1() == 0);
     assert(octeon_mtp0_zeroes_p1() == 0);
+    assert(octeon_cop2_key0_readback(0x1122334455667788ULL) ==
+           0x1122334455667788ULL);
+    assert(octeon_cop2_key2_readback(0x8877665544332211ULL) ==
+           0x8877665544332211ULL);
+    assert(octeon_cop2_key3_readback(0x0102030405060708ULL) ==
+           0x0102030405060708ULL);
+    assert(octeon_cop2_keylength_readback(0xa5) == 0xa5);
 
     return 0;
 }

-- 
2.54.0


