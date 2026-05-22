Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5571ECD5BAF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 05:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQIJZ-0003T0-45; Fri, 22 May 2026 01:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQIJQ-0002zk-0T
 for qemu-devel@nongnu.org; Fri, 22 May 2026 01:20:45 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQIJO-0002Im-0u
 for qemu-devel@nongnu.org; Fri, 22 May 2026 01:20:43 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4824176bbbeso2391312b6e.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 22:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779427241; x=1780032041; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mu+lYa+gqNWB2nD7pgrIYlNv9/RobAyR2gn9reCR67g=;
 b=CwhJKrwmPTytv99bCtTKw4RalpBETRQlyj8z9vzi5LdJoPFL5LmMmT0MosmRKd3tJn
 YCWNKC0c4bPjJygqykytG0P5y+0/mctJqdlPflB4uO+n8+EWLHtogmPaJvelG9dPjZIA
 ySgI3hBxmr/tsJQnZWHCplkjybJ2WsZNzHsk+CX2ZlLspUZx9nX9h8ubK14rVQD+R28p
 KxtRr7Kcj6gfv4KY4r66gM0eaR0VjG249mZUGPZLnk4BnMjrKhxEdsN1qh4RBm7C4Xid
 znZtG0CBU0raDbOFIkDT53RosPZ7H5u7DAxUJZ0Rp4BRU5/CI3oDG6f47zN1VKXiByJq
 L+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779427241; x=1780032041;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mu+lYa+gqNWB2nD7pgrIYlNv9/RobAyR2gn9reCR67g=;
 b=Sr7uyigIMGJWTOOPXw8C4X8+1hpXCtw3TxAWoIx6cUnpBwW7xFRaeDFhGj2jJweFXC
 ClXyWnNzRhdsBZeK4n3bXSC4s1ZakTzxYrmvHyG/eCMuM1lB+1iInd0TgJpu8OsJTzn/
 f4X6DmOwBjNl1AEWBUvrEMVtorL2PZRF6O3v9M9iRw+PJ/dJbtF9fNB8psMfdlGbOAco
 cttvMPuS/Q/bLoA7blZVQ48ilGlRuuI+pjPiH2Ls70DGnU0g72xmZh7wcXX8UYEkWnpW
 OwXjbAhG+c6+5PAFecat80qXn5BFpofberh2vbYT4GKd+/m5ObzqUeflrvUPj4JAKY4h
 p7lg==
X-Gm-Message-State: AOJu0Yw1X7rxDVtIhGxc9F7yBCO6VAuDNyqckwPs9PpDOmI1lCJLL0lI
 gdHxwooZaP16oCFG08bVVCQ2eLiheuHpwyDTZsePfv/TBnASNQd2E05p
X-Gm-Gg: Acq92OGyCUFoNa5GfKnCzYU6b0bxP9tLa2K3g0opGCib5UOv/fu9RSgoKsy5C6kP/EK
 ZKqvA2eJTl/2UKLnpmign0bPz0Vc7rhspkbLy42gAqSB0FGVgvecRhKT0PUHeXUNl3JCQk9bIEU
 hT5ya/Zc91U/p/4fyh2DHWOGI7IIcLvtgZ1T2epyMxztYYorIPhf1RDbwvwcjQWRQbazT4MI3It
 le0Ti28PvE4+Fe1Q9gYNXZ9unDBcalnIXJa2Plv68ibHZYJ0R1jZA4GOs8tntqLOBrslJSZ4BUg
 OwHdx5qkkjlqmkYHSHY92xmoVUutdwuuq9rEKQlKp8oOE5LKzQ9+AL3OBjQQamG3PMEvtLRHjXC
 mPL9lhvVUmQcXEeHlg8tbpTG0IxeQNf64290MBTljPekDjJaf14P6aB3jZL1o3sNjqSS20e3G0V
 /8lA0tfoQ71d5UkDXSsM8NLM0eWOkjXYKWkondOTptTT+WJcdG0YP7jP3gsvjlcaQD4Hf1ZIqK8
 E/+TqfGG2BEiq36kQuUvz/0R8BVPX66lmVv3Soe9oAvBiwoIduY8S+x7FoU3M/+vgBCGBOQYdy8
 A3o=
X-Received: by 2002:a05:6808:c1fb:b0:480:4024:3bb with SMTP id
 5614622812f47-4854a29a2cbmr1525309b6e.24.1779427240998; 
 Thu, 21 May 2026 22:20:40 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4855476ab77sm59690b6e.17.2026.05.21.22.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 22:20:40 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 21 May 2026 23:20:04 -0600
Subject: [PATCH v14 22/22] tests/tcg/mips: cover Octeon QMAC instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-mips-octeon-missing-insns-v2-v14-22-fbf08e164830@gmail.com>
References: <20260521-mips-octeon-missing-insns-v2-v14-0-fbf08e164830@gmail.com>
In-Reply-To: <20260521-mips-octeon-missing-insns-v2-v14-0-fbf08e164830@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x230.google.com
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

Add smoke coverage for Octeon QMAC and QMACS fixed-point accumulator
instruction paths.

The coverage exercises normal accumulation, saturating accumulation, and
the sticky saturation flag.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v12 -> v13:
  - Add QMAC/QMACS smoke coverage.
---
 tests/tcg/mips/user/isa/octeon/octeon-insns.c | 40 +++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tests/tcg/mips/user/isa/octeon/octeon-insns.c b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
index 6480c8532a..6fffc82010 100644
--- a/tests/tcg/mips/user/isa/octeon/octeon-insns.c
+++ b/tests/tcg/mips/user/isa/octeon/octeon-insns.c
@@ -129,6 +129,43 @@ static uint64_t octeon_vmm0(uint64_t mpl0, uint64_t p0,
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
 static uint64_t octeon_vmm0_zeroes_mpl1(void)
 {
     uint64_t rd;
@@ -355,6 +392,9 @@ int main(void)
     assert(octeon_seq(0xabc, 0xdef) == 0);
     assert(octeon_sne(0xabc, 0xabc) == 0);
     assert(octeon_sne(0xabc, 0xdef) == 1);
+    assert(octeon_qmac_lo(0x0003000000000000ULL, 2, 1) == 13);
+    assert(octeon_qmacs_state(1, 1, 0x7ffffffe) == 0x17fffffffULL);
+    assert(octeon_qmacs_state(0x8000, 0x8000, 0) == 0x17fffffffULL);
     assert(octeon_vmulu(5, 7, 11) == 46);
     assert(octeon_vmm0(5, 13, 7, 11) == 59);
     assert(octeon_vmm0_zeroes_mpl1() == 0);

-- 
2.54.0


