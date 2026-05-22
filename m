Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81615CD4F5B
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 05:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQIJE-0002bJ-Ri; Fri, 22 May 2026 01:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQIJD-0002Za-DJ
 for qemu-devel@nongnu.org; Fri, 22 May 2026 01:20:31 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQIJB-00022x-I7
 for qemu-devel@nongnu.org; Fri, 22 May 2026 01:20:31 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-4854d5cc708so266423b6e.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 22:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779427228; x=1780032028; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1/wDEtjpU6/JQCX42z91k/04b23uAyh66zeRkKaauFU=;
 b=Lfj8j9nK8YTPg5dw0vmYfcPLfsuGSjidlNJcGVY1insTd6Dle5dW9z40VzCc+sQOnU
 20gYBggzAbH408msbY9VIFdBn0S+lfQmIW3Sm5LK2hSwGfva1ZZv1ZZi70kda+yQ9RfQ
 g+XBicWgwUTc7Z1cggHA9Dp70U46NTkN4aUfdHn21Pho3/dyK8AweoaGZhQTXtrh6CCZ
 gJNZU/kgRNoP5Tnk1VYkinf63sZjxLhccRwOR/e3YjWHHPKFUJxaHsDhkpn57TgeZnkZ
 +hWbOInJRBgraoBlN8NYTUUmHnfekLuvoieNBUCBS5hIHmWACa3Gj4Vp9lbiPGIRNLgF
 T+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779427228; x=1780032028;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1/wDEtjpU6/JQCX42z91k/04b23uAyh66zeRkKaauFU=;
 b=SgVXF9tAubEw8Z1rH+xwpPgF3vDJ/QjvHzzhJP9D2CTFUUVVsWVPTZFxbP6d4djldK
 S2VqZ4aG4uGdRYG2iBy5+rKmZWfYJBF1NoCoRMhBUi7SZAefG7f0X/aecbBCLdEfpOu7
 c9VpGgcohYv9xYztMNSlW202pXIRwHOtKUGpW7PtV3saJ/vwseYXy0Gy2VZvKCIJ8nfe
 rTgXTHyPSA7xCqrwoIG7powkXsSTQlQXfYikyp6W8xweoNRjPrYLRdYT3t4Dd8gCSnR6
 QF+SoMnqgH60HLxq9qTLVy7PJnJunzShKnTd0ICBAaj98aMBiRt6UNqoVYOZMp+j+kIH
 KDmw==
X-Gm-Message-State: AOJu0YxNS2DvS7y6FR/ggV7NCiobmIfpPuxQhgukwOu2HGKWhxpJLApq
 gMcm+PDhT+EkZ5NclX/Lroxk1G7Bvw0VNRnPozjd4ErFvuKfBb8vT6t1
X-Gm-Gg: Acq92OELYeq4y8dpRx1r1xXkbsrj3IJ/nJZZvNuSnN4iMh4ygTj/ICMuwoIfbMPdHNd
 ewQzfhuCKvy8nc8vJPZ3zobKgVOr1SVX5OVK9Al60spu2FoikRuWAcyCaPOpK0x/f2mzRlbYH0g
 Y6jLn6m5p5cDcrwk5JQHXx9QrczBvGUzwQyU4R5KrOP+zdIZL6W69Vajqz+V4SksB/bipo+b9wC
 yHdt5pPIxuiIm27qYhh9oNsZml/vfKl8buoMSg9EHdysKzi6cw34CwOsnY+cRxwXgxFfsNEVGgY
 Yd/T285gO06fqKRt4X2SiAJSMPe9cEbmXD2tvSi9U5mnjtC8VLhDl2vUlIslXhCnMjQjkAc5egP
 fgp0FIQbrNkM53UTEpzYlc525lQ/Xrynu3QJ3kpj7EQ4n8d1U3o877CX0F6WJmVuZnXdSv8qFoX
 UpoWOrTupT/cJ9gfb0B/7rki3kAEE7DRZVaKVL7zATnObZnE48beehC9TMEt2MhaVpTGbGMlEAy
 mBJeb68u3IE16wAt7QvUpheFXqmScLNd/pkHeFkSNsMM3E0JBTg/S4zTcKpfOpFWXtRHYfiNORT
 oDpNxNe2A4c/SA==
X-Received: by 2002:a05:6808:1b10:b0:482:6b96:5ad0 with SMTP id
 5614622812f47-4854a3f730cmr1132095b6e.26.1779427228224; 
 Thu, 21 May 2026 22:20:28 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4855476ab77sm59690b6e.17.2026.05.21.22.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 22:20:27 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 21 May 2026 23:19:54 -0600
Subject: [PATCH v14 12/22] target/mips: add Octeon Camellia COP2 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-mips-octeon-missing-insns-v2-v14-12-fbf08e164830@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x229.google.com
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

Add helper support for the Octeon Camellia ROUND, FL, and FLINV
selectors. The engine reuses the AES RESINP bank, and guest-managed key
schedules drive the Camellia F-function and FL layers through these COP2
operations.

Implement the Camellia F-function and FL layers directly from RFC 3713.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v8 -> v9:
  - Split Camellia operation selectors into their own COP2 helper patch.
  - Replace generic selector dispatch with per-operation Camellia helpers.
  - Add matching helper.h declarations with the helper implementation.

Changes v5 -> v6:
  - Use RESINP wording for the Camellia shared selector aliases.

Changes v1 -> v2:
  - Drop the Octeon prefix from generic Camellia helper routines.
    (suggested by Philippe Mathieu-Daudé)
  - Add selector dispatch updates in octeon_translate.c after moving
    COP2 decode out of translate.c.  (suggested by Philippe
    Mathieu-Daudé)
---
 target/mips/helper.h            |   3 +
 target/mips/tcg/octeon_crypto.c | 126 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 129 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 444eeeb3ec..fbf8250932 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -88,6 +88,9 @@ DEF_HELPER_2(octeon_cp2_mt_des3_enc, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_kas_enc, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_des3_dec_cbc, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_des3_dec, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_camellia_fl, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_camellia_flinv, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_camellia_round, void, env, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index 893f55d1e5..5bb21098fc 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -1614,6 +1614,132 @@ void helper_octeon_cp2_mt_des3_dec(CPUMIPSState *env, uint64_t value)
     octeon_3des_crypt_common(&env->octeon_crypto, value, false, false);
 }
 
+static const uint8_t camellia_sbox1[256] = {
+    112, 130,  44, 236, 179,  39, 192, 229, 228, 133,  87,  53, 234,  12,
+    174,  65,  35, 239, 107, 147,  69,  25, 165,  33, 237,  14,  79,  78,
+     29, 101, 146, 189, 134, 184, 175, 143, 124, 235,  31, 206,  62,  48,
+    220,  95,  94, 197,  11,  26, 166, 225,  57, 202, 213,  71,  93,  61,
+    217,   1,  90, 214,  81,  86, 108,  77, 139,  13, 154, 102, 251, 204,
+    176,  45, 116,  18,  43,  32, 240, 177, 132, 153, 223,  76, 203, 194,
+     52, 126, 118,   5, 109, 183, 169,  49, 209,  23,   4, 215,  20,  88,
+     58,  97, 222,  27,  17,  28,  50,  15, 156,  22,  83,  24, 242,  34,
+    254,  68, 207, 178, 195, 181, 122, 145,  36,   8, 232, 168,  96, 252,
+    105,  80, 170, 208, 160, 125, 161, 137,  98, 151,  84,  91,  30, 149,
+    224, 255, 100, 210,  16, 196,   0,  72, 163, 247, 117, 219, 138,   3,
+    230, 218,   9,  63, 221, 148, 135,  92, 131,   2, 205,  74, 144,  51,
+    115, 103, 246, 243, 157, 127, 191, 226,  82, 155, 216,  38, 200,  55,
+    198,  59, 129, 150, 111,  75,  19, 190,  99,  46, 233, 121, 167, 140,
+    159, 110, 188, 142,  41, 245, 249, 182,  47, 253, 180,  89, 120, 152,
+      6, 106, 231,  70, 113, 186, 212,  37, 171,  66, 136, 162, 141, 250,
+    114,   7, 185,  85, 248, 238, 172,  10,  54,  73,  42, 104,  60,  56,
+    241, 164,  64,  40, 211, 123, 187, 201,  67, 193,  21, 227, 173, 244,
+    119, 199, 128, 158,
+};
+
+static inline uint8_t camellia_rotl8(uint8_t v, unsigned int shift)
+{
+    return (v << shift) | (v >> (8 - shift));
+}
+
+static inline uint8_t camellia_sbox2(uint8_t x)
+{
+    return camellia_rotl8(camellia_sbox1[x], 1);
+}
+
+static inline uint8_t camellia_sbox3(uint8_t x)
+{
+    return camellia_rotl8(camellia_sbox1[x], 7);
+}
+
+static inline uint8_t camellia_sbox4(uint8_t x)
+{
+    return camellia_sbox1[camellia_rotl8(x, 1)];
+}
+
+static uint64_t camellia_f(uint64_t input, uint64_t key)
+{
+    uint64_t x = input ^ key;
+    uint8_t t1 = camellia_sbox1[x >> 56];
+    uint8_t t2 = camellia_sbox2((x >> 48) & 0xff);
+    uint8_t t3 = camellia_sbox3((x >> 40) & 0xff);
+    uint8_t t4 = camellia_sbox4((x >> 32) & 0xff);
+    uint8_t t5 = camellia_sbox2((x >> 24) & 0xff);
+    uint8_t t6 = camellia_sbox3((x >> 16) & 0xff);
+    uint8_t t7 = camellia_sbox4((x >> 8) & 0xff);
+    uint8_t t8 = camellia_sbox1[x & 0xff];
+    uint8_t y1 = t1 ^ t3 ^ t4 ^ t6 ^ t7 ^ t8;
+    uint8_t y2 = t1 ^ t2 ^ t4 ^ t5 ^ t7 ^ t8;
+    uint8_t y3 = t1 ^ t2 ^ t3 ^ t5 ^ t6 ^ t8;
+    uint8_t y4 = t2 ^ t3 ^ t4 ^ t5 ^ t6 ^ t7;
+    uint8_t y5 = t1 ^ t2 ^ t6 ^ t7 ^ t8;
+    uint8_t y6 = t2 ^ t3 ^ t5 ^ t7 ^ t8;
+    uint8_t y7 = t3 ^ t4 ^ t5 ^ t6 ^ t8;
+    uint8_t y8 = t1 ^ t4 ^ t5 ^ t6 ^ t7;
+
+    return ((uint64_t)y1 << 56) | ((uint64_t)y2 << 48) |
+           ((uint64_t)y3 << 40) | ((uint64_t)y4 << 32) |
+           ((uint64_t)y5 << 24) | ((uint64_t)y6 << 16) |
+           ((uint64_t)y7 << 8) | y8;
+}
+
+static uint64_t camellia_fl(uint64_t input, uint64_t key)
+{
+    uint32_t x1 = input >> 32;
+    uint32_t x2 = input;
+    uint32_t k1 = key >> 32;
+    uint32_t k2 = key;
+
+    x2 ^= rol32(x1 & k1, 1);
+    x1 ^= x2 | k2;
+    return ((uint64_t)x1 << 32) | x2;
+}
+
+static uint64_t camellia_flinv(uint64_t input, uint64_t key)
+{
+    uint32_t y1 = input >> 32;
+    uint32_t y2 = input;
+    uint32_t k1 = key >> 32;
+    uint32_t k2 = key;
+
+    y1 ^= y2 | k2;
+    y2 ^= rol32(y1 & k1, 1);
+    return ((uint64_t)y1 << 32) | y2;
+}
+
+static void octeon_camellia_round(MIPSOcteonCryptoState *crypto, uint64_t key)
+{
+    uint64_t left = crypto->aes_resinp[0];
+    uint64_t right = crypto->aes_resinp[1];
+
+    crypto->aes_resinp[0] = right ^ camellia_f(left, key);
+    crypto->aes_resinp[1] = left;
+}
+
+static void octeon_camellia_fl_layer(MIPSOcteonCryptoState *crypto,
+                                     uint64_t key, bool inverse)
+{
+    uint64_t state = crypto->aes_resinp[inverse ? 1 : 0];
+
+    crypto->aes_resinp[inverse ? 1 : 0] = inverse ?
+        camellia_flinv(state, key) :
+        camellia_fl(state, key);
+}
+
+void helper_octeon_cp2_mt_camellia_fl(CPUMIPSState *env, uint64_t value)
+{
+    octeon_camellia_fl_layer(&env->octeon_crypto, value, false);
+}
+
+void helper_octeon_cp2_mt_camellia_flinv(CPUMIPSState *env, uint64_t value)
+{
+    octeon_camellia_fl_layer(&env->octeon_crypto, value, true);
+}
+
+void helper_octeon_cp2_mt_camellia_round(CPUMIPSState *env, uint64_t value)
+{
+    octeon_camellia_round(&env->octeon_crypto, value);
+}
+
 void helper_octeon_cp2_mt_snow3g_start(CPUMIPSState *env, uint64_t value)
 {
     octeon_snow3g_start(&env->octeon_crypto, value);

-- 
2.54.0


