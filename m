Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6E5CD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 05:32:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOqZC-0000ZE-GT; Mon, 18 May 2026 01:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqYJ-0006wd-41
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:30:09 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqYF-0003Yh-IN
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:30:06 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-479f7e75a6bso533277b6e.2
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 22:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779082198; x=1779686998; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qlMag4QSIcF7sGxYMULDpYaOquZcn5Nij7VO3N7z8zs=;
 b=RlyoAjD2nzjwZiLFp/vfDYy/aepXVrhU6gB/kjoQJ+A2fv8vNPGwNdNyxJm4COUlpS
 zh7DFt70ebSWQ/cw3yxFWUi+zJRQMzrziFUzbkYytohGymgbELbV6LabHMM9g3yJq0Fu
 LFOYGAl6ryONvj+I2a+pOkMQwbi3E6BGgZwTVgx2x4DbOJybwVjtcjGI5B7X6ESaUKXz
 Ckt2WsgHgDnVNlnbkBaRmBxYIrY5UROhGHOzLaAoP3JxejWrElgNQ7j6rAlZvrr+BtVb
 Te9EClw/PDNCUeoz6+/46g/BAmzZsH9RjPJvqxIMtyOhN2vxNGOZgbIvuSUvbj9tn1Ab
 qYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779082198; x=1779686998;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qlMag4QSIcF7sGxYMULDpYaOquZcn5Nij7VO3N7z8zs=;
 b=Fif/3NthqY8T0VV3LfzWTK07PNcjbyFBAauLpz6mW2pDXOOnU83l5dS9b5CESe4jMF
 mBUbly1njIF0rlv1H8mZD+OvYMfz4TXWl0SxmBUNUVol14CEY0R2LYVnvv2ilFKlbhUr
 w47FM3WBtZK5Tgx32UZ4j2pwLaUEsnqmTCz2CZjwLcFqxwOY/+hMvEZ2NZHtid7qPSxW
 6xxi1s+bHuSCye96Y1A1bluthePA2W7bs1CXVK4X7rF5y50ThqsmdKTxco2GCYwk+3WJ
 OD/ZOCpusurHlguRSEZcGkLzlhKLLxTMEF5P/av8Utjy0c3bOPr63E2febs8UoR3wmjX
 b4HQ==
X-Gm-Message-State: AOJu0YyqzzHQjoYaxI8Oil16hxsoSxOzeuNg7CKh8MMdU+DJpKvuIPJ2
 KIho0QLxwJOB075g/LrkfdYhPtgzET8A7CA1r9KDK+GKSN9fdymXeevY
X-Gm-Gg: Acq92OGwlU4mHpPkGn1GV5CKHss2X0NMLchvTO3VsxYh0FE+kXNDrgq9/zrn3/8IhhE
 rIaO6QIhIdoF8Q3CfQLiuacUNFAvpSIyW+OKi/erYMEfhAzQX6hORE4yIyGE7VLnUE1D5/uQHZu
 QWpD10dF4KtnDZRL5nSoFl/PCiOtPaF/pWcOcQ2Kwv71jfVPGAEXRDl2IVpvG2RF94i4HFNV8a9
 qdQH9lte2PnBaLuuYZdmi+m9u4T56eFMn1wKcY5/b+p3yL4ILZgsuz0/BsAfl3tSzdCXqw2QXUo
 Kab0yH/xLAQFgMKRTBYhLq+ndD6zvqBW7IKkhtpaWn4aFroQEKBIgPkwsE1IHZONR6FrkEV3U2B
 yZrUsQihR6M72WCbw97DLcFUQa72qjiBctln5IdXevF+ZB9PiJK3bzkyZv3zLHVY2YKNhUeigAp
 6RJUC9nQW0iHWHCNtkI7qDWgJYiwbBNK2PEcQMxkHVS+zuBjbkKngvK/NcxQ6yKIJj/+xXxNXZJ
 scJy9k5xozCEQg1pIDcVqUr17/ik+H6jkCAQNaC08YwQdOBi/xf6cNlEa2w5D7DbmmpRDA6VPMS
 qLm9Pkh8VBMYnwuR
X-Received: by 2002:a05:6808:1526:b0:484:c3f6:de69 with SMTP id
 5614622812f47-484c3f6de7amr3249348b6e.37.1779082198533; 
 Sun, 17 May 2026 22:29:58 -0700 (PDT)
Received: from mac.localdomain (71-218-255-245.hlrn.qwest.net.
 [71.218.255.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-482ee5349a5sm4628357b6e.15.2026.05.17.22.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 22:29:58 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 17 May 2026 23:29:29 -0600
Subject: [PATCH v8 32/35] tests/tcg/mips: cover Octeon COP2 selector readback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-mips-octeon-missing-insns-v2-v8-32-206151ee77ec@gmail.com>
References: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
In-Reply-To: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22d.google.com
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
DMTC2/DMFC2 readback checks. These selectors exercise the explicit COP2
decodetree entries and direct TCG register-transfer paths introduced by
the decode split.

Keep the coverage independent from the functional crypto-vector test so the
in-tree TCG smoke test catches selector routing regressions quickly.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

---
Changes v7 -> v8:
  - Split AES COP2 selector readback coverage out of the COP2 crypto core
    patch.
---
 tests/tcg/mips/user/isa/octeon/octeon-insns.c | 71 +++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
index 9153e37e9e..435ccfa347 100644
--- a/tests/tcg/mips/user/isa/octeon/octeon-insns.c
+++ b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
@@ -186,6 +186,70 @@ static uint64_t octeon_mtp0_zeroes_p1(void)
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
@@ -199,6 +263,13 @@ int main(void)
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


