Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6E54CD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 18:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ7mx-0000E7-Hh; Thu, 21 May 2026 14:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQ7mu-0000Av-9h
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:06:28 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQ7mr-00022g-9B
 for qemu-devel@nongnu.org; Thu, 21 May 2026 14:06:27 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7dca4debedaso6647034a34.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 11:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779386784; x=1779991584; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Lb0OvF7hQ6PiNdrSYpxR44n5ZueReZ1PaD49+fWM2z8=;
 b=PyZRAxawEq+n7Vd0+TpDcqPjLu4LIqZpM16ncWtlB7Z7dhj7sTW9/jK0Qb+duh73UV
 wzA0bgDg7O3I26maeo92HoVq9k8r5/gsVyJsUIc0ikWvxiXDZJqQV56mhSoe2BMZfxIy
 K7jjlukYYGu05ShO8YB/lr86ug86MHCaTJxUuqrpxpus4pJ3mMk7K3HFKO+drviuoDb9
 JQ6PD9vzLrAqlw4U2foJg8+0xMg0hXGlXI3GrHdwhJEyvwKZ+ppKnYDprFgA4t588N8+
 vj3x1dpkucWEpM7RFa3ueRGh+0wF+INUU+j2tHviFB/Qa7lL7YhOoqCpdUOeHtrE8kuB
 jxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386784; x=1779991584;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Lb0OvF7hQ6PiNdrSYpxR44n5ZueReZ1PaD49+fWM2z8=;
 b=CcuC5MZEf18x/3SwqAYbqMWwSDJdgcdBG2/gAwshivi01bOO61hi+fAWWPG3zHCsOH
 efYGG7w+RYorveqwhI8/8HyPCZiw8QyEl3Xpzxt/I9EKJeVPylhQSxOvUD5Eq2ut3c3K
 whU+Ce/xQ+vhBxbcyZHoXK+NLmCIjbU+3VUj8/zbtbJgYakcQYhH1Ql0FOmrrdCaS9Ke
 6BAPnO1mSFKVbO0yawP7yCiOXvzs8Oqf7WFN3vIzMvF417FG8JXkBiYWVoM3T1zde8Nx
 i8fAjsESe8WjQN/zrOkxwNm0TXZ1EAVjBa8HN6RjX38OgYaocg2i7qfM8AXbunzaU97J
 bdBw==
X-Gm-Message-State: AOJu0YzMcKUTNFKPyk2GnUf6r5+I2u4o5V22qD6lLAMwSyoSzHW/fBgV
 nNLN8tMOy4W/Zl+wQxUTalrQpYZnzDvHxTA1oQEfx4N6EUTE/6VpObMW
X-Gm-Gg: Acq92OHoteAAXaWThQfTcpNT3HCOZoWRd7WSjRImf10XqLKHhBydENCKgaKNGV1FY1+
 FRXElIJp44flws+5r6rnCclXRr9LYMzOCyfpuqOFr4BGpw5NuQWbmERNHCYsV8OEbChrHJ/pZW8
 BApnJ952wC+bt1U6AMc6OG7SgKFSb+nQmJZxCqv6NM0oe6OXYVn78V2YT2tUf22Det2eTi5Jccp
 5OHf656GfLfIlwNRBS9XF1Sao4w8596vS+8IeTHiul38dWSBFOJRmYza48e7e/BZS5MdfgJote3
 sUeC7BAoLvrXleWklN+q5lNDvf1ucSz3C46eLjGcvIGmrvwgFuHVzBAmS+fNEjUETljSaFbP3Dr
 Saz7r9ctWvhgw4gKdHksHoLOmZ6bzDW2mRic6ZSP7dPQTLcfh1SvzbMfib4beDi6wvSmNZArRih
 KedGp4TDRQuqDH/a6zgY8rj1o3Jl5h/S6toKL92InxdAkU3ns5TE1OwuVLgUfWq5AgHza9c+VUi
 QBa6NlBFqDpJYDdRi7kob8bMeNIrQsJrvVQJsGCpEob1STBfHypt18QDVMYSMSQ3m9r
X-Received: by 2002:a05:6830:6d17:b0:7de:427d:34ba with SMTP id
 46e09a7af769-7e5feed1e60mr148409a34.19.1779386783947; 
 Thu, 21 May 2026 11:06:23 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e5f6ee286fsm903089a34.25.2026.05.21.11.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:06:23 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 21 May 2026 12:06:00 -0600
Subject: [PATCH v13 07/22] target/mips: add Octeon ZUC COP2 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-mips-octeon-missing-insns-v2-v13-7-5a4cb8ec9cd3@gmail.com>
References: <20260521-mips-octeon-missing-insns-v2-v13-0-5a4cb8ec9cd3@gmail.com>
In-Reply-To: <20260521-mips-octeon-missing-insns-v2-v13-0-5a4cb8ec9cd3@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32b.google.com
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

Add the Octeon ZUC START and MORE helper operations and model the shared
state window used by the hardware interface. This covers the keystream
and MAC engine state, including the save-and-restore view that overlaps
the HSH/SHA3 bank.

Shared-window writes also update the SHA512/SHA3 backing state so guests
can switch between engines without stale register contents.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v8 -> v9:
  - Split ZUC selector operations into their own COP2 helper patch.
  - Replace generic selector dispatch with per-operation ZUC helpers.
  - Use helper-local selector constants for shared-window position logic.
  - Add matching helper.h declarations with the helper implementation.

Changes v5 -> v6:
  - Use the manual-aligned HSH_DATW field and shared HSH window helper
    names introduced by the COP2 crypto core patch.

Changes v1 -> v2:
  - Add shared-window selector predicates and assert on unreachable ZUC
    selector switches.  (suggested by Philippe Mathieu-Daudé)
  - Preserve aliased HSH/SHA3/SHA512 backing state during ZUC
    shared-window writes.
  - Add selector dispatch updates in octeon_translate.c after moving
    COP2 decode out of translate.c.  (suggested by Philippe
    Mathieu-Daudé)
---
 target/mips/helper.h            |   2 +
 target/mips/tcg/octeon_crypto.c | 369 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 371 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index d1ec75eaff..353832748c 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -70,6 +70,8 @@ DEF_HELPER_2(octeon_cp2_mt_sha3_xordat15, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_sha3_xordat16, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_sha3_xordat17, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_sha3_startop, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_zuc_start, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_zuc_more, void, env, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index b3b88ce018..28a9fca013 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -264,6 +264,375 @@ static void octeon_sha3_permute(MIPSOcteonCryptoState *crypto)
     }
 }
 
+static inline uint32_t octeon_crypto_hi32(uint64_t value)
+{
+    return value >> 32;
+}
+
+static inline uint32_t octeon_crypto_lo32(uint64_t value)
+{
+    return value;
+}
+
+static inline uint64_t octeon_crypto_pack32(uint32_t hi, uint32_t lo)
+{
+    return ((uint64_t)hi << 32) | lo;
+}
+
+static const uint8_t octeon_zuc_s0[256] = {
+    0x3e, 0x72, 0x5b, 0x47, 0xca, 0xe0, 0x00, 0x33,
+    0x04, 0xd1, 0x54, 0x98, 0x09, 0xb9, 0x6d, 0xcb,
+    0x7b, 0x1b, 0xf9, 0x32, 0xaf, 0x9d, 0x6a, 0xa5,
+    0xb8, 0x2d, 0xfc, 0x1d, 0x08, 0x53, 0x03, 0x90,
+    0x4d, 0x4e, 0x84, 0x99, 0xe4, 0xce, 0xd9, 0x91,
+    0xdd, 0xb6, 0x85, 0x48, 0x8b, 0x29, 0x6e, 0xac,
+    0xcd, 0xc1, 0xf8, 0x1e, 0x73, 0x43, 0x69, 0xc6,
+    0xb5, 0xbd, 0xfd, 0x39, 0x63, 0x20, 0xd4, 0x38,
+    0x76, 0x7d, 0xb2, 0xa7, 0xcf, 0xed, 0x57, 0xc5,
+    0xf3, 0x2c, 0xbb, 0x14, 0x21, 0x06, 0x55, 0x9b,
+    0xe3, 0xef, 0x5e, 0x31, 0x4f, 0x7f, 0x5a, 0xa4,
+    0x0d, 0x82, 0x51, 0x49, 0x5f, 0xba, 0x58, 0x1c,
+    0x4a, 0x16, 0xd5, 0x17, 0xa8, 0x92, 0x24, 0x1f,
+    0x8c, 0xff, 0xd8, 0xae, 0x2e, 0x01, 0xd3, 0xad,
+    0x3b, 0x4b, 0xda, 0x46, 0xeb, 0xc9, 0xde, 0x9a,
+    0x8f, 0x87, 0xd7, 0x3a, 0x80, 0x6f, 0x2f, 0xc8,
+    0xb1, 0xb4, 0x37, 0xf7, 0x0a, 0x22, 0x13, 0x28,
+    0x7c, 0xcc, 0x3c, 0x89, 0xc7, 0xc3, 0x96, 0x56,
+    0x07, 0xbf, 0x7e, 0xf0, 0x0b, 0x2b, 0x97, 0x52,
+    0x35, 0x41, 0x79, 0x61, 0xa6, 0x4c, 0x10, 0xfe,
+    0xbc, 0x26, 0x95, 0x88, 0x8a, 0xb0, 0xa3, 0xfb,
+    0xc0, 0x18, 0x94, 0xf2, 0xe1, 0xe5, 0xe9, 0x5d,
+    0xd0, 0xdc, 0x11, 0x66, 0x64, 0x5c, 0xec, 0x59,
+    0x42, 0x75, 0x12, 0xf5, 0x74, 0x9c, 0xaa, 0x23,
+    0x0e, 0x86, 0xab, 0xbe, 0x2a, 0x02, 0xe7, 0x67,
+    0xe6, 0x44, 0xa2, 0x6c, 0xc2, 0x93, 0x9f, 0xf1,
+    0xf6, 0xfa, 0x36, 0xd2, 0x50, 0x68, 0x9e, 0x62,
+    0x71, 0x15, 0x3d, 0xd6, 0x40, 0xc4, 0xe2, 0x0f,
+    0x8e, 0x83, 0x77, 0x6b, 0x25, 0x05, 0x3f, 0x0c,
+    0x30, 0xea, 0x70, 0xb7, 0xa1, 0xe8, 0xa9, 0x65,
+    0x8d, 0x27, 0x1a, 0xdb, 0x81, 0xb3, 0xa0, 0xf4,
+    0x45, 0x7a, 0x19, 0xdf, 0xee, 0x78, 0x34, 0x60,
+};
+
+static const uint8_t octeon_zuc_s1[256] = {
+    0x55, 0xc2, 0x63, 0x71, 0x3b, 0xc8, 0x47, 0x86,
+    0x9f, 0x3c, 0xda, 0x5b, 0x29, 0xaa, 0xfd, 0x77,
+    0x8c, 0xc5, 0x94, 0x0c, 0xa6, 0x1a, 0x13, 0x00,
+    0xe3, 0xa8, 0x16, 0x72, 0x40, 0xf9, 0xf8, 0x42,
+    0x44, 0x26, 0x68, 0x96, 0x81, 0xd9, 0x45, 0x3e,
+    0x10, 0x76, 0xc6, 0xa7, 0x8b, 0x39, 0x43, 0xe1,
+    0x3a, 0xb5, 0x56, 0x2a, 0xc0, 0x6d, 0xb3, 0x05,
+    0x22, 0x66, 0xbf, 0xdc, 0x0b, 0xfa, 0x62, 0x48,
+    0xdd, 0x20, 0x11, 0x06, 0x36, 0xc9, 0xc1, 0xcf,
+    0xf6, 0x27, 0x52, 0xbb, 0x69, 0xf5, 0xd4, 0x87,
+    0x7f, 0x84, 0x4c, 0xd2, 0x9c, 0x57, 0xa4, 0xbc,
+    0x4f, 0x9a, 0xdf, 0xfe, 0xd6, 0x8d, 0x7a, 0xeb,
+    0x2b, 0x53, 0xd8, 0x5c, 0xa1, 0x14, 0x17, 0xfb,
+    0x23, 0xd5, 0x7d, 0x30, 0x67, 0x73, 0x08, 0x09,
+    0xee, 0xb7, 0x70, 0x3f, 0x61, 0xb2, 0x19, 0x8e,
+    0x4e, 0xe5, 0x4b, 0x93, 0x8f, 0x5d, 0xdb, 0xa9,
+    0xad, 0xf1, 0xae, 0x2e, 0xcb, 0x0d, 0xfc, 0xf4,
+    0x2d, 0x46, 0x6e, 0x1d, 0x97, 0xe8, 0xd1, 0xe9,
+    0x4d, 0x37, 0xa5, 0x75, 0x5e, 0x83, 0x9e, 0xab,
+    0x82, 0x9d, 0xb9, 0x1c, 0xe0, 0xcd, 0x49, 0x89,
+    0x01, 0xb6, 0xbd, 0x58, 0x24, 0xa2, 0x5f, 0x38,
+    0x78, 0x99, 0x15, 0x90, 0x50, 0xb8, 0x95, 0xe4,
+    0xd0, 0x91, 0xc7, 0xce, 0xed, 0x0f, 0xb4, 0x6f,
+    0xa0, 0xcc, 0xf0, 0x02, 0x4a, 0x79, 0xc3, 0xde,
+    0xa3, 0xef, 0xea, 0x51, 0xe6, 0x6b, 0x18, 0xec,
+    0x1b, 0x2c, 0x80, 0xf7, 0x74, 0xe7, 0xff, 0x21,
+    0x5a, 0x6a, 0x54, 0x1e, 0x41, 0x31, 0x92, 0x35,
+    0xc4, 0x33, 0x07, 0x0a, 0xba, 0x7e, 0x0e, 0x34,
+    0x88, 0xb1, 0x98, 0x7c, 0xf3, 0x3d, 0x60, 0x6c,
+    0x7b, 0xca, 0xd3, 0x1f, 0x32, 0x65, 0x04, 0x28,
+    0x64, 0xbe, 0x85, 0x9b, 0x2f, 0x59, 0x8a, 0xd7,
+    0xb0, 0x25, 0xac, 0xaf, 0x12, 0x03, 0xe2, 0xf2,
+};
+
+static inline uint32_t octeon_zuc_addm(uint32_t a, uint32_t b)
+{
+    uint32_t c = a + b;
+
+    c = (c & 0x7fffffffU) + (c >> 31);
+    return c ? c : 0x7fffffffU;
+}
+
+static inline uint32_t octeon_zuc_mul_by_pow2(uint32_t v, unsigned int shift)
+{
+    return ((v << shift) | (v >> (31 - shift))) & 0x7fffffffU;
+}
+
+static inline uint32_t octeon_zuc_make_u32(uint8_t a, uint8_t b,
+                                           uint8_t c, uint8_t d)
+{
+    return ((uint32_t)a << 24) | ((uint32_t)b << 16) |
+           ((uint32_t)c << 8) | d;
+}
+
+static inline uint64_t octeon_zuc_pack_pair(uint32_t hi, uint32_t lo)
+{
+    return ((uint64_t)hi << 32) | lo;
+}
+
+static uint32_t octeon_zuc_lfsr(const MIPSOcteonCryptoState *crypto,
+                                unsigned int index)
+{
+    uint64_t pair = crypto->hsh_dat[index / 2];
+
+    return index & 1 ? octeon_crypto_lo32(pair) : octeon_crypto_hi32(pair);
+}
+
+static void octeon_zuc_set_lfsr(MIPSOcteonCryptoState *crypto,
+                                unsigned int index, uint32_t value)
+{
+    uint32_t hi = octeon_crypto_hi32(crypto->hsh_dat[index / 2]);
+    uint32_t lo = octeon_crypto_lo32(crypto->hsh_dat[index / 2]);
+
+    value &= 0x7fffffffU;
+    if (index & 1) {
+        lo = value;
+    } else {
+        hi = value;
+    }
+    crypto->hsh_dat[index / 2] = octeon_zuc_pack_pair(hi, lo);
+}
+
+static uint32_t octeon_zuc_fsm(const MIPSOcteonCryptoState *crypto,
+                               unsigned int index)
+{
+    uint64_t pair = crypto->hsh_dat[8];
+
+    return index ? octeon_crypto_lo32(pair) : octeon_crypto_hi32(pair);
+}
+
+static void octeon_zuc_set_fsm(MIPSOcteonCryptoState *crypto,
+                               unsigned int index, uint32_t value)
+{
+    uint32_t hi = octeon_crypto_hi32(crypto->hsh_dat[8]);
+    uint32_t lo = octeon_crypto_lo32(crypto->hsh_dat[8]);
+
+    if (index) {
+        lo = value;
+        crypto->hsh_iv[2] = value;
+    } else {
+        hi = value;
+        crypto->hsh_iv[1] = value;
+    }
+    crypto->hsh_dat[8] = octeon_zuc_pack_pair(hi, lo);
+}
+
+static uint32_t octeon_zuc_window(const MIPSOcteonCryptoState *crypto,
+                                  unsigned int index)
+{
+    switch (index) {
+    case 0:
+        return octeon_crypto_hi32(crypto->hsh_dat[9]);
+    case 1:
+        return octeon_crypto_lo32(crypto->hsh_dat[9]);
+    case 2:
+        return crypto->hsh_dat[10];
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void octeon_zuc_set_window(MIPSOcteonCryptoState *crypto,
+                                  unsigned int index, uint32_t value)
+{
+    switch (index) {
+    case 0:
+        crypto->hsh_dat[9] =
+            octeon_zuc_pack_pair(value, octeon_crypto_lo32(crypto->hsh_dat[9]));
+        crypto->hsh_iv[0] = crypto->hsh_dat[9];
+        return;
+    case 1:
+        crypto->hsh_dat[9] =
+            octeon_zuc_pack_pair(octeon_crypto_hi32(crypto->hsh_dat[9]), value);
+        crypto->hsh_iv[0] = crypto->hsh_dat[9];
+        return;
+    case 2:
+        crypto->hsh_dat[10] = value;
+        return;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static uint32_t octeon_zuc_tresult(const MIPSOcteonCryptoState *crypto)
+{
+    return crypto->hsh_dat[11];
+}
+
+static void octeon_zuc_set_tresult(MIPSOcteonCryptoState *crypto,
+                                   uint32_t value)
+{
+    crypto->hsh_dat[11] = value;
+    crypto->hsh_iv[3] = value;
+}
+
+static void octeon_zuc_bit_reorganization(const MIPSOcteonCryptoState *crypto,
+                                          uint32_t x[4])
+{
+    x[0] = ((octeon_zuc_lfsr(crypto, 15) & 0x7fff8000U) << 1) |
+           (octeon_zuc_lfsr(crypto, 14) & 0xffffU);
+    x[1] = ((octeon_zuc_lfsr(crypto, 11) & 0xffffU) << 16) |
+           (octeon_zuc_lfsr(crypto, 9) >> 15);
+    x[2] = ((octeon_zuc_lfsr(crypto, 7) & 0xffffU) << 16) |
+           (octeon_zuc_lfsr(crypto, 5) >> 15);
+    x[3] = ((octeon_zuc_lfsr(crypto, 2) & 0xffffU) << 16) |
+           (octeon_zuc_lfsr(crypto, 0) >> 15);
+}
+
+static inline uint32_t octeon_zuc_l1(uint32_t x)
+{
+    return x ^ rol32(x, 2) ^ rol32(x, 10) ^
+           rol32(x, 18) ^ rol32(x, 24);
+}
+
+static inline uint32_t octeon_zuc_l2(uint32_t x)
+{
+    return x ^ rol32(x, 8) ^ rol32(x, 14) ^
+           rol32(x, 22) ^ rol32(x, 30);
+}
+
+static uint32_t octeon_zuc_f(MIPSOcteonCryptoState *crypto, const uint32_t x[4])
+{
+    uint32_t fsm0 = octeon_zuc_fsm(crypto, 0);
+    uint32_t fsm1 = octeon_zuc_fsm(crypto, 1);
+    uint32_t w = (x[0] ^ fsm0) + fsm1;
+    uint32_t w1 = fsm0 + x[1];
+    uint32_t w2 = fsm1 ^ x[2];
+    uint32_t u = octeon_zuc_l1((w1 << 16) | (w2 >> 16));
+    uint32_t v = octeon_zuc_l2((w2 << 16) | (w1 >> 16));
+
+    octeon_zuc_set_fsm(crypto, 0,
+                       octeon_zuc_make_u32(octeon_zuc_s0[u >> 24],
+                                           octeon_zuc_s1[(uint8_t)(u >> 16)],
+                                           octeon_zuc_s0[(uint8_t)(u >> 8)],
+                                           octeon_zuc_s1[(uint8_t)u]));
+    octeon_zuc_set_fsm(crypto, 1,
+                       octeon_zuc_make_u32(octeon_zuc_s0[v >> 24],
+                                           octeon_zuc_s1[(uint8_t)(v >> 16)],
+                                           octeon_zuc_s0[(uint8_t)(v >> 8)],
+                                           octeon_zuc_s1[(uint8_t)v]));
+    return w;
+}
+
+static void octeon_zuc_lfsr_step(MIPSOcteonCryptoState *crypto,
+                                 bool init_mode, uint32_t u)
+{
+    uint32_t lfsr[16];
+    uint32_t f;
+
+    for (int i = 0; i < 16; i++) {
+        lfsr[i] = octeon_zuc_lfsr(crypto, i);
+    }
+
+    f = lfsr[0];
+    f = octeon_zuc_addm(f, octeon_zuc_mul_by_pow2(lfsr[0], 8));
+    f = octeon_zuc_addm(f, octeon_zuc_mul_by_pow2(lfsr[4], 20));
+    f = octeon_zuc_addm(f, octeon_zuc_mul_by_pow2(lfsr[10], 21));
+    f = octeon_zuc_addm(f, octeon_zuc_mul_by_pow2(lfsr[13], 17));
+    f = octeon_zuc_addm(f, octeon_zuc_mul_by_pow2(lfsr[15], 15));
+    if (init_mode) {
+        f = octeon_zuc_addm(f, u);
+    }
+
+    for (int i = 0; i < 15; i++) {
+        octeon_zuc_set_lfsr(crypto, i, lfsr[i + 1]);
+    }
+    octeon_zuc_set_lfsr(crypto, 15, f);
+}
+
+static uint32_t octeon_zuc_generate_word(MIPSOcteonCryptoState *crypto)
+{
+    uint32_t x[4];
+    uint32_t z;
+
+    octeon_zuc_bit_reorganization(crypto, x);
+    z = octeon_zuc_f(crypto, x) ^ x[3];
+    octeon_zuc_lfsr_step(crypto, false, 0);
+    return z;
+}
+
+static void octeon_zuc_fill_window(MIPSOcteonCryptoState *crypto)
+{
+    octeon_zuc_set_window(crypto, 0, octeon_zuc_generate_word(crypto));
+    octeon_zuc_set_window(crypto, 1, octeon_zuc_generate_word(crypto));
+    octeon_zuc_set_window(crypto, 2, octeon_zuc_generate_word(crypto));
+}
+
+static inline uint32_t
+octeon_zuc_window_word(const MIPSOcteonCryptoState *crypto, unsigned int bit)
+{
+    if (bit == 0) {
+        return octeon_zuc_window(crypto, 0);
+    }
+    if (bit < 32) {
+        return (octeon_zuc_window(crypto, 0) << bit) |
+               (octeon_zuc_window(crypto, 1) >> (32 - bit));
+    }
+    if (bit == 32) {
+        return octeon_zuc_window(crypto, 1);
+    }
+    return (octeon_zuc_window(crypto, 1) << (bit - 32)) |
+           (octeon_zuc_window(crypto, 2) >> (64 - bit));
+}
+
+static void octeon_zuc_advance_window(MIPSOcteonCryptoState *crypto)
+{
+    octeon_zuc_set_window(crypto, 0, octeon_zuc_window(crypto, 2));
+    octeon_zuc_set_window(crypto, 1, octeon_zuc_generate_word(crypto));
+    octeon_zuc_set_window(crypto, 2, octeon_zuc_generate_word(crypto));
+}
+
+static void octeon_zuc_start(MIPSOcteonCryptoState *crypto, uint64_t data)
+{
+    uint32_t x[4];
+
+    for (int i = 0; i < 14; i++) {
+        octeon_zuc_set_lfsr(crypto, i, octeon_zuc_lfsr(crypto, i));
+    }
+    octeon_zuc_set_lfsr(crypto, 14, data >> 32);
+    octeon_zuc_set_lfsr(crypto, 15, data);
+    octeon_zuc_set_fsm(crypto, 0, 0);
+    octeon_zuc_set_fsm(crypto, 1, 0);
+    octeon_zuc_set_tresult(crypto, 0);
+
+    for (int i = 0; i < 32; i++) {
+        octeon_zuc_bit_reorganization(crypto, x);
+        octeon_zuc_lfsr_step(crypto, true, octeon_zuc_f(crypto, x) >> 1);
+    }
+
+    octeon_zuc_bit_reorganization(crypto, x);
+    (void)octeon_zuc_f(crypto, x);
+    octeon_zuc_lfsr_step(crypto, false, 0);
+    octeon_zuc_fill_window(crypto);
+}
+
+static void octeon_zuc_more(MIPSOcteonCryptoState *crypto, uint64_t data)
+{
+    uint32_t t = octeon_zuc_tresult(crypto);
+
+    for (unsigned int bit = 0; bit < 64; bit++) {
+        if ((data >> (63 - bit)) & 1) {
+            t ^= octeon_zuc_window_word(crypto, bit);
+        }
+    }
+    octeon_zuc_set_tresult(crypto, t);
+    octeon_zuc_advance_window(crypto);
+}
+
+void helper_octeon_cp2_mt_zuc_start(CPUMIPSState *env, uint64_t value)
+{
+    octeon_zuc_start(&env->octeon_crypto, value);
+}
+
+void helper_octeon_cp2_mt_zuc_more(CPUMIPSState *env, uint64_t value)
+{
+    octeon_zuc_more(&env->octeon_crypto, value);
+}
+
 uint64_t helper_octeon_cp2_mf_crc_iv_reflect(CPUMIPSState *env)
 {
     return octeon_crc_reflect32_by_byte(env->octeon_crypto.crc_iv);

-- 
2.54.0


