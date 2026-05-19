Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7283CCD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 16:25:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNDy-0006yZ-Bx; Tue, 19 May 2026 12:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDw-0006wy-1l
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:23:16 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPNDt-0000pO-17
 for qemu-devel@nongnu.org; Tue, 19 May 2026 12:23:15 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-43ad01fe217so562989fac.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 09:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207791; x=1779812591; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=P43OeS+Jwti9OHWJ6qw8iECWDcTXObWIJzmUrcqQOrg=;
 b=TNWG1V6gs3bmIDk5fHZutz4IsIRQQCbRWMe2/MgsUoJIJr+8b85FR7TsdzcVCQ1EFB
 qMeavpbhUr9qu7yAGHfSMCFF9N5SzL7WeXDlvTYWqMrNH0milf5tsi019VfghdVj2rYJ
 qkMlPF6gogsk3oI48yoN2zAqt/CNCFlJnjpS7u9wjsuUiCxvGRYZg2R0Unw1VaDqCrdf
 uAP+VXrTpsNWQf8tn1rsZDawO9lMCGRxnNJ0TOCm2tSSeRIs8YwI5R53aBd7VKFUYcoP
 gMrSJUN6sl7TcQBxW+bI+mwmHEInACpzi9UPJ2xbdSbOHKV26ilqEmTZiKz5gMb5x/Ye
 YraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207791; x=1779812591;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=P43OeS+Jwti9OHWJ6qw8iECWDcTXObWIJzmUrcqQOrg=;
 b=c/owS4lDXHJlLH5aVSDLKu6CxvJTG0HyzpWYNQ7OC4Qc2Pqwc7JzBS9oOPC9EbmJoe
 2qnZ01EtypB0gXaqBRAyZKgK+8yo3W7JadTFTbju0a+SytffxWL3m+2dbdS6xvwcyqNM
 b0f7yu5JEpxrzd1MKQWfmFLEKbs0J1S6CYXPjR8+ehWHSazzjtjay7DE+XoqRK9o6RrS
 Ktwu90lmPpJXFv7btrQoR8LiYXKGSEob6D0cFCnAvV4cC6MDs1Cu5raPAQLs5CRV9U5H
 u4vTVFB1IapgT+kSPvaGQ7jPdMBhoEzsHdDV7dJxSiAvnl49YPeRZzGQqGe4A8j7OLzs
 NHFQ==
X-Gm-Message-State: AOJu0YyNAgzjwZJFH611CgN6sPHn6/glzZKlUOzmE4oX4BANZfevkLK2
 AbyqVEC1hyQ9VPtQ5Te4IwQdBAFC1WM6e+Es/hMJ/PspzZ3g1euY1kAs
X-Gm-Gg: Acq92OEJ5jJJXvd8P4dg3F7DwQj4ExEFxpB83vtBSo9eubQIrJsaHUlVhc5qz5gJjnW
 VOlyjPbUhuC/aWJ9vP0TBCvVmMlfwaS01fSHr4aWCG7MeldY1g3gfjohZn3NPWm2wdx/tWFMtYZ
 vU4Kf6VvZMecxhAbQFkDksP91CpC4wTE65bpMYf6C8jUoi/LPrXC2QgHNTvlB6Zh/WEZKPtVsne
 MTv5m/QdSm0cq5OZmB9SyxYZ0KIkTG2pgIt8CPFGHmfs9bl+FYfAsaOT3sxg5IzuC7sDTbwdfjX
 0KcYPQw8kVwautUxkwIZCJWHuCOocH2bO4YgPlzNWQMr9nywR675gxwFrb5TBrZf0e+yF8MFJlf
 QFtKVGHr+m8gVxbDFeK37hFpgG1N2O9niX5QgyAszCR5/6hQc8k0gYFoYE5XgZmHZGIYASiwAZW
 Dmz+O7+s8jtbwvo49PO6l6Ly3rYgScH4hfOq92J2lbIC01zAfDqDZefMoA3IeWex7F2N1GnT3qw
 xOL1omwVMEbFlN0+Ih6cH3AfTsI35O8rRjVB35rE63OxnHDUppMFx9hCqkaKR1ujYVw
X-Received: by 2002:a05:6871:6616:b0:423:9228:7d37 with SMTP id
 586e51a60fabf-43a2da1bf68mr12215638fac.16.1779207790502; 
 Tue, 19 May 2026 09:23:10 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a95762ceasm7056296fac.13.2026.05.19.09.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:23:09 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 10:22:37 -0600
Subject: [PATCH v9 35/40] target/mips: add Octeon HSH COP2 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v9-35-d7dd735ecddd@gmail.com>
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
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x36.google.com
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

Add helper support for the Octeon HSH hash selectors. This includes the
base HSH data/IV windows, MD5, SHA1, SHA256, and SHA512 transform paths,
and the shared HSH/SHA512 register-window readback and write operations.

The SHA512 path shares the wide HSH register bank with SHA3, SNOW3G, and
ZUC. Keep the mode tracking centralized so later explicit DMFC2/DMTC2
selector decode can route aliased register accesses through these helpers
when side effects or active-engine views are required.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v8 -> v9:
  - Split HSH/SHA helpers into their own COP2 helper patch.
  - Replace generic selector dispatch with per-operation HSH helpers.
  - Keep shared-window readback and write helpers grouped with HSH.
  - Add matching helper.h declarations with the helper implementation.
---
 target/mips/helper.h            |  53 ++++
 target/mips/tcg/octeon_crypto.c | 570 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 623 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 23c712cfb7..6d6ceaea08 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -28,6 +28,30 @@ DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
 /* Octeon COP2 selector operation helpers. */
 DEF_HELPER_1(octeon_cp2_mf_crc_iv_reflect, i64, env)
 DEF_HELPER_1(octeon_cp2_mf_sha3_dat24, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_datw0, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_datw1, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_datw2, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_datw3, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_datw4, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_datw5, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_datw6, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_datw7, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_datw8, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_datw9, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_datw10, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_datw11, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_datw12, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_datw13, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_datw14, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_datw15, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_ivw0, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_ivw1, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_ivw2, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_ivw3, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_ivw4, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_ivw5, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_ivw6, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_hsh_ivw7, i64, env)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_iv_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_byte, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_half, void, env, i64)
@@ -83,6 +107,35 @@ DEF_HELPER_2(octeon_cp2_mt_des3_dec, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_camellia_fl, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_camellia_flinv, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_camellia_round, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_startsha_compat, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_datw0, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_datw1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_datw2, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_datw3, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_datw4, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_datw5, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_datw6, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_datw7, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_datw8, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_datw9, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_datw10, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_datw11, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_datw12, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_datw13, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_datw14, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_datw15, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_ivw0, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_ivw1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_ivw2, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_ivw3, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_ivw4, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_ivw5, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_ivw6, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_ivw7, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_startmd5, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_startsha256, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_startsha, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_startsha512, void, env, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index d26dd2924d..6282226cfc 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -136,6 +136,367 @@ static void octeon_gfm_mul_reflect(MIPSOcteonCryptoState *crypto, uint64_t data)
                           crypto->gfm_poly, crypto->gfm_reflect_resinp);
     crypto->gfm_reflect_xor0 = 0;
 }
+static inline void octeon_hsh_load_reg_words_be(uint64_t reg,
+                                                 uint32_t *hi, uint32_t *lo)
+{
+    uint8_t buf[8];
+
+    stq_be_p(buf, reg);
+    *hi = ldl_be_p(buf);
+    *lo = ldl_be_p(buf + 4);
+}
+
+static inline void octeon_hsh_load_reg_words_le(uint64_t reg,
+                                                 uint32_t *lo0, uint32_t *lo1)
+{
+    uint8_t buf[8];
+
+    stq_be_p(buf, reg);
+    *lo0 = ldl_le_p(buf);
+    *lo1 = ldl_le_p(buf + 4);
+}
+
+static inline uint64_t octeon_hsh_store_reg_words_be(uint32_t hi, uint32_t lo)
+{
+    uint8_t buf[8];
+
+    stl_be_p(buf, hi);
+    stl_be_p(buf + 4, lo);
+    return ldq_be_p(buf);
+}
+
+static inline uint64_t octeon_hsh_store_reg_words_le(uint32_t lo0,
+                                                      uint32_t lo1)
+{
+    uint8_t buf[8];
+
+    stl_le_p(buf, lo0);
+    stl_le_p(buf + 4, lo1);
+    return ldq_be_p(buf);
+}
+
+static void octeon_md5_transform(MIPSOcteonCryptoState *crypto)
+{
+    static const uint32_t k[64] = {
+        0xd76aa478U, 0xe8c7b756U, 0x242070dbU, 0xc1bdceeeU,
+        0xf57c0fafU, 0x4787c62aU, 0xa8304613U, 0xfd469501U,
+        0x698098d8U, 0x8b44f7afU, 0xffff5bb1U, 0x895cd7beU,
+        0x6b901122U, 0xfd987193U, 0xa679438eU, 0x49b40821U,
+        0xf61e2562U, 0xc040b340U, 0x265e5a51U, 0xe9b6c7aaU,
+        0xd62f105dU, 0x02441453U, 0xd8a1e681U, 0xe7d3fbc8U,
+        0x21e1cde6U, 0xc33707d6U, 0xf4d50d87U, 0x455a14edU,
+        0xa9e3e905U, 0xfcefa3f8U, 0x676f02d9U, 0x8d2a4c8aU,
+        0xfffa3942U, 0x8771f681U, 0x6d9d6122U, 0xfde5380cU,
+        0xa4beea44U, 0x4bdecfa9U, 0xf6bb4b60U, 0xbebfbc70U,
+        0x289b7ec6U, 0xeaa127faU, 0xd4ef3085U, 0x04881d05U,
+        0xd9d4d039U, 0xe6db99e5U, 0x1fa27cf8U, 0xc4ac5665U,
+        0xf4292244U, 0x432aff97U, 0xab9423a7U, 0xfc93a039U,
+        0x655b59c3U, 0x8f0ccc92U, 0xffeff47dU, 0x85845dd1U,
+        0x6fa87e4fU, 0xfe2ce6e0U, 0xa3014314U, 0x4e0811a1U,
+        0xf7537e82U, 0xbd3af235U, 0x2ad7d2bbU, 0xeb86d391U,
+    };
+    static const uint8_t s[64] = {
+        7, 12, 17, 22, 7, 12, 17, 22, 7, 12, 17, 22, 7, 12, 17, 22,
+        5, 9, 14, 20, 5, 9, 14, 20, 5, 9, 14, 20, 5, 9, 14, 20,
+        4, 11, 16, 23, 4, 11, 16, 23, 4, 11, 16, 23, 4, 11, 16, 23,
+        6, 10, 15, 21, 6, 10, 15, 21, 6, 10, 15, 21, 6, 10, 15, 21,
+    };
+    uint8_t block_bytes[64];
+    uint32_t m[16];
+    uint32_t a, b, c, d;
+    uint32_t aa, bb, cc, dd;
+    int i;
+
+    for (i = 0; i < 8; i++) {
+        stq_be_p(block_bytes + (i * 8), crypto->hsh_dat[i]);
+        m[i * 2] = ldl_le_p(block_bytes + (i * 8));
+        m[i * 2 + 1] = ldl_le_p(block_bytes + (i * 8) + 4);
+    }
+
+    octeon_hsh_load_reg_words_le(crypto->hsh_iv[0], &a, &b);
+    octeon_hsh_load_reg_words_le(crypto->hsh_iv[1], &c, &d);
+    aa = a;
+    bb = b;
+    cc = c;
+    dd = d;
+
+    for (i = 0; i < 64; i++) {
+        uint32_t f, g, tmp;
+
+        if (i < 16) {
+            f = (b & c) | ((~b) & d);
+            g = i;
+        } else if (i < 32) {
+            f = (d & b) | ((~d) & c);
+            g = (5 * i + 1) & 0xf;
+        } else if (i < 48) {
+            f = b ^ c ^ d;
+            g = (3 * i + 5) & 0xf;
+        } else {
+            f = c ^ (b | (~d));
+            g = (7 * i) & 0xf;
+        }
+
+        tmp = d;
+        d = c;
+        c = b;
+        b = b + rol32(a + f + k[i] + m[g], s[i]);
+        a = tmp;
+    }
+
+    a += aa;
+    b += bb;
+    c += cc;
+    d += dd;
+    crypto->hsh_iv[0] = octeon_hsh_store_reg_words_le(a, b);
+    crypto->hsh_iv[1] = octeon_hsh_store_reg_words_le(c, d);
+}
+
+static void octeon_sha1_transform(MIPSOcteonCryptoState *crypto)
+{
+    uint32_t w[80];
+    uint32_t a, b, c, d, e;
+    int i;
+
+    for (i = 0; i < 8; i++) {
+        octeon_hsh_load_reg_words_be(crypto->hsh_dat[i],
+                                      &w[i * 2], &w[i * 2 + 1]);
+    }
+    for (i = 16; i < 80; i++) {
+        w[i] = rol32(w[i - 3] ^ w[i - 8] ^ w[i - 14] ^ w[i - 16], 1);
+    }
+
+    octeon_hsh_load_reg_words_be(crypto->hsh_iv[0], &a, &b);
+    octeon_hsh_load_reg_words_be(crypto->hsh_iv[1], &c, &d);
+    e = crypto->hsh_iv[2] >> 32;
+
+    for (i = 0; i < 80; i++) {
+        uint32_t f, k, temp;
+
+        if (i < 20) {
+            f = (b & c) | ((~b) & d);
+            k = 0x5a827999;
+        } else if (i < 40) {
+            f = b ^ c ^ d;
+            k = 0x6ed9eba1;
+        } else if (i < 60) {
+            f = (b & c) | (b & d) | (c & d);
+            k = 0x8f1bbcdc;
+        } else {
+            f = b ^ c ^ d;
+            k = 0xca62c1d6;
+        }
+
+        temp = rol32(a, 5) + f + e + k + w[i];
+        e = d;
+        d = c;
+        c = rol32(b, 30);
+        b = a;
+        a = temp;
+    }
+
+    octeon_hsh_load_reg_words_be(crypto->hsh_iv[0], &w[0], &w[1]);
+    octeon_hsh_load_reg_words_be(crypto->hsh_iv[1], &w[2], &w[3]);
+    w[4] = crypto->hsh_iv[2] >> 32;
+    w[0] += a;
+    w[1] += b;
+    w[2] += c;
+    w[3] += d;
+    w[4] += e;
+    crypto->hsh_iv[0] = octeon_hsh_store_reg_words_be(w[0], w[1]);
+    crypto->hsh_iv[1] = octeon_hsh_store_reg_words_be(w[2], w[3]);
+    crypto->hsh_iv[2] = (uint64_t)w[4] << 32;
+}
+
+static void octeon_sha256_transform(MIPSOcteonCryptoState *crypto)
+{
+    static const uint32_t k[64] = {
+        0x428a2f98U, 0x71374491U, 0xb5c0fbcfU, 0xe9b5dba5U,
+        0x3956c25bU, 0x59f111f1U, 0x923f82a4U, 0xab1c5ed5U,
+        0xd807aa98U, 0x12835b01U, 0x243185beU, 0x550c7dc3U,
+        0x72be5d74U, 0x80deb1feU, 0x9bdc06a7U, 0xc19bf174U,
+        0xe49b69c1U, 0xefbe4786U, 0x0fc19dc6U, 0x240ca1ccU,
+        0x2de92c6fU, 0x4a7484aaU, 0x5cb0a9dcU, 0x76f988daU,
+        0x983e5152U, 0xa831c66dU, 0xb00327c8U, 0xbf597fc7U,
+        0xc6e00bf3U, 0xd5a79147U, 0x06ca6351U, 0x14292967U,
+        0x27b70a85U, 0x2e1b2138U, 0x4d2c6dfcU, 0x53380d13U,
+        0x650a7354U, 0x766a0abbU, 0x81c2c92eU, 0x92722c85U,
+        0xa2bfe8a1U, 0xa81a664bU, 0xc24b8b70U, 0xc76c51a3U,
+        0xd192e819U, 0xd6990624U, 0xf40e3585U, 0x106aa070U,
+        0x19a4c116U, 0x1e376c08U, 0x2748774cU, 0x34b0bcb5U,
+        0x391c0cb3U, 0x4ed8aa4aU, 0x5b9cca4fU, 0x682e6ff3U,
+        0x748f82eeU, 0x78a5636fU, 0x84c87814U, 0x8cc70208U,
+        0x90befffaU, 0xa4506cebU, 0xbef9a3f7U, 0xc67178f2U,
+    };
+    uint32_t w[64];
+    uint32_t a, b, c, d, e, f, g, h;
+    uint32_t orig[8];
+    int i;
+
+    for (i = 0; i < 8; i++) {
+        octeon_hsh_load_reg_words_be(crypto->hsh_dat[i],
+                                      &w[i * 2], &w[i * 2 + 1]);
+    }
+    for (i = 16; i < 64; i++) {
+        uint32_t s0 = ror32(w[i - 15], 7) ^
+                      ror32(w[i - 15], 18) ^
+                      (w[i - 15] >> 3);
+        uint32_t s1 = ror32(w[i - 2], 17) ^
+                      ror32(w[i - 2], 19) ^
+                      (w[i - 2] >> 10);
+        w[i] = w[i - 16] + s0 + w[i - 7] + s1;
+    }
+
+    for (i = 0; i < 4; i++) {
+        octeon_hsh_load_reg_words_be(crypto->hsh_iv[i],
+                                      &orig[i * 2], &orig[i * 2 + 1]);
+    }
+    a = orig[0];
+    b = orig[1];
+    c = orig[2];
+    d = orig[3];
+    e = orig[4];
+    f = orig[5];
+    g = orig[6];
+    h = orig[7];
+
+    for (i = 0; i < 64; i++) {
+        uint32_t s1 = ror32(e, 6) ^
+                      ror32(e, 11) ^
+                      ror32(e, 25);
+        uint32_t ch = (e & f) ^ ((~e) & g);
+        uint32_t temp1 = h + s1 + ch + k[i] + w[i];
+        uint32_t s0 = ror32(a, 2) ^
+                      ror32(a, 13) ^
+                      ror32(a, 22);
+        uint32_t maj = (a & b) ^ (a & c) ^ (b & c);
+        uint32_t temp2 = s0 + maj;
+
+        h = g;
+        g = f;
+        f = e;
+        e = d + temp1;
+        d = c;
+        c = b;
+        b = a;
+        a = temp1 + temp2;
+    }
+
+    orig[0] += a;
+    orig[1] += b;
+    orig[2] += c;
+    orig[3] += d;
+    orig[4] += e;
+    orig[5] += f;
+    orig[6] += g;
+    orig[7] += h;
+    for (i = 0; i < 4; i++) {
+        crypto->hsh_iv[i] =
+            octeon_hsh_store_reg_words_be(orig[i * 2], orig[i * 2 + 1]);
+    }
+}
+
+static void octeon_sha512_transform(MIPSOcteonCryptoState *crypto)
+{
+    static const uint64_t k[80] = {
+        0x428a2f98d728ae22ULL, 0x7137449123ef65cdULL,
+        0xb5c0fbcfec4d3b2fULL, 0xe9b5dba58189dbbcULL,
+        0x3956c25bf348b538ULL, 0x59f111f1b605d019ULL,
+        0x923f82a4af194f9bULL, 0xab1c5ed5da6d8118ULL,
+        0xd807aa98a3030242ULL, 0x12835b0145706fbeULL,
+        0x243185be4ee4b28cULL, 0x550c7dc3d5ffb4e2ULL,
+        0x72be5d74f27b896fULL, 0x80deb1fe3b1696b1ULL,
+        0x9bdc06a725c71235ULL, 0xc19bf174cf692694ULL,
+        0xe49b69c19ef14ad2ULL, 0xefbe4786384f25e3ULL,
+        0x0fc19dc68b8cd5b5ULL, 0x240ca1cc77ac9c65ULL,
+        0x2de92c6f592b0275ULL, 0x4a7484aa6ea6e483ULL,
+        0x5cb0a9dcbd41fbd4ULL, 0x76f988da831153b5ULL,
+        0x983e5152ee66dfabULL, 0xa831c66d2db43210ULL,
+        0xb00327c898fb213fULL, 0xbf597fc7beef0ee4ULL,
+        0xc6e00bf33da88fc2ULL, 0xd5a79147930aa725ULL,
+        0x06ca6351e003826fULL, 0x142929670a0e6e70ULL,
+        0x27b70a8546d22ffcULL, 0x2e1b21385c26c926ULL,
+        0x4d2c6dfc5ac42aedULL, 0x53380d139d95b3dfULL,
+        0x650a73548baf63deULL, 0x766a0abb3c77b2a8ULL,
+        0x81c2c92e47edaee6ULL, 0x92722c851482353bULL,
+        0xa2bfe8a14cf10364ULL, 0xa81a664bbc423001ULL,
+        0xc24b8b70d0f89791ULL, 0xc76c51a30654be30ULL,
+        0xd192e819d6ef5218ULL, 0xd69906245565a910ULL,
+        0xf40e35855771202aULL, 0x106aa07032bbd1b8ULL,
+        0x19a4c116b8d2d0c8ULL, 0x1e376c085141ab53ULL,
+        0x2748774cdf8eeb99ULL, 0x34b0bcb5e19b48a8ULL,
+        0x391c0cb3c5c95a63ULL, 0x4ed8aa4ae3418acbULL,
+        0x5b9cca4f7763e373ULL, 0x682e6ff3d6b2b8a3ULL,
+        0x748f82ee5defb2fcULL, 0x78a5636f43172f60ULL,
+        0x84c87814a1f0ab72ULL, 0x8cc702081a6439ecULL,
+        0x90befffa23631e28ULL, 0xa4506cebde82bde9ULL,
+        0xbef9a3f7b2c67915ULL, 0xc67178f2e372532bULL,
+        0xca273eceea26619cULL, 0xd186b8c721c0c207ULL,
+        0xeada7dd6cde0eb1eULL, 0xf57d4f7fee6ed178ULL,
+        0x06f067aa72176fbaULL, 0x0a637dc5a2c898a6ULL,
+        0x113f9804bef90daeULL, 0x1b710b35131c471bULL,
+        0x28db77f523047d84ULL, 0x32caab7b40c72493ULL,
+        0x3c9ebe0a15c9bebcULL, 0x431d67c49c100d4cULL,
+        0x4cc5d4becb3e42b6ULL, 0x597f299cfc657e2aULL,
+        0x5fcb6fab3ad6faecULL, 0x6c44198c4a475817ULL,
+    };
+    uint64_t w[80];
+    uint64_t a, b, c, d, e, f, g, h;
+    int i;
+
+    for (i = 0; i < 16; i++) {
+        w[i] = crypto->hsh_datw[i];
+    }
+    for (i = 16; i < 80; i++) {
+        uint64_t s0 = ror64(w[i - 15], 1) ^
+                      ror64(w[i - 15], 8) ^
+                      (w[i - 15] >> 7);
+        uint64_t s1 = ror64(w[i - 2], 19) ^
+                      ror64(w[i - 2], 61) ^
+                      (w[i - 2] >> 6);
+        w[i] = w[i - 16] + s0 + w[i - 7] + s1;
+    }
+
+    a = crypto->hsh_ivw[0];
+    b = crypto->hsh_ivw[1];
+    c = crypto->hsh_ivw[2];
+    d = crypto->hsh_ivw[3];
+    e = crypto->hsh_ivw[4];
+    f = crypto->hsh_ivw[5];
+    g = crypto->hsh_ivw[6];
+    h = crypto->hsh_ivw[7];
+
+    for (i = 0; i < 80; i++) {
+        uint64_t s0 = ror64(a, 28) ^
+                      ror64(a, 34) ^
+                      ror64(a, 39);
+        uint64_t s1 = ror64(e, 14) ^
+                      ror64(e, 18) ^
+                      ror64(e, 41);
+        uint64_t ch = (e & f) ^ ((~e) & g);
+        uint64_t maj = (a & b) ^ (a & c) ^ (b & c);
+        uint64_t temp1 = h + s1 + ch + k[i] + w[i];
+        uint64_t temp2 = s0 + maj;
+
+        h = g;
+        g = f;
+        f = e;
+        e = d + temp1;
+        d = c;
+        c = b;
+        b = a;
+        a = temp1 + temp2;
+    }
+
+    crypto->hsh_ivw[0] += a;
+    crypto->hsh_ivw[1] += b;
+    crypto->hsh_ivw[2] += c;
+    crypto->hsh_ivw[3] += d;
+    crypto->hsh_ivw[4] += e;
+    crypto->hsh_ivw[5] += f;
+    crypto->hsh_ivw[6] += g;
+    crypto->hsh_ivw[7] += h;
+}
 static const uint64_t octeon_sha3_round_constants[24] = {
     0x0000000000000001ULL, 0x0000000000008082ULL,
     0x800000000000808aULL, 0x8000000080008000ULL,
@@ -1533,6 +1894,116 @@ static void octeon_gfm_mul(const uint64_t x[2], const uint64_t y[2],
     out[0] = zh;
     out[1] = zl;
 }
+static uint64_t octeon_hsh_mf_window(MIPSOcteonCryptoState *crypto,
+                                     uint32_t sel)
+{
+    if (crypto->shared_mode == OCTEON_SHARED_MODE_ZUC &&
+        octeon_zuc_is_shared_dmfc2_sel(sel)) {
+        if (sel >= OCTEON_HSH_DATW(0) &&
+            sel <= OCTEON_HSH_DATW(7)) {
+            unsigned int idx = sel - OCTEON_HSH_DATW(0);
+
+            return octeon_zuc_pack_pair(crypto->zuc_lfsr[idx * 2],
+                                        crypto->zuc_lfsr[idx * 2 + 1]);
+        }
+        switch (sel) {
+        case OCTEON_HSH_DATW(8):
+            return octeon_zuc_pack_pair(crypto->zuc_fsm[0],
+                                        crypto->zuc_fsm[1]);
+        case OCTEON_HSH_DATW(9):
+        case OCTEON_HSH_IVW(0):
+            return octeon_zuc_pack_pair(crypto->zuc_window[0],
+                                        crypto->zuc_window[1]);
+        case OCTEON_HSH_DATW(10):
+            return crypto->zuc_window[2];
+        case OCTEON_HSH_DATW(11):
+        case OCTEON_HSH_IVW(3):
+            return crypto->zuc_tresult;
+        case OCTEON_HSH_DATW(15):
+        case OCTEON_SHA3_DAT24_SEL:
+            return 0;
+        case OCTEON_HSH_IVW(1):
+            return crypto->zuc_fsm[0];
+        case OCTEON_HSH_IVW(2):
+            return crypto->zuc_fsm[1];
+        default:
+            g_assert_not_reached();
+        }
+    }
+
+    if (crypto->shared_mode == OCTEON_SHARED_MODE_SNOW3G) {
+        if (sel >= OCTEON_SNOW3G_LFSR(0) &&
+            sel <= OCTEON_SNOW3G_LFSR(7)) {
+            unsigned int idx = sel - OCTEON_SNOW3G_LFSR(0);
+
+            return ((uint64_t)crypto->snow3g_lfsr[idx * 2] << 32) |
+                   crypto->snow3g_lfsr[idx * 2 + 1];
+        }
+        switch (sel) {
+        case OCTEON_SNOW3G_RESULT_SEL:
+            return crypto->snow3g_result;
+        case OCTEON_SNOW3G_FSM(0):
+        case OCTEON_SNOW3G_FSM(1):
+        case OCTEON_SNOW3G_FSM(2):
+            return crypto->snow3g_fsm[sel - OCTEON_SNOW3G_FSM(0)];
+        default:
+            break;
+        }
+    }
+
+    if (crypto->shared_mode == OCTEON_SHARED_MODE_SHA3 &&
+        octeon_sha3_is_dat_sel(sel)) {
+        int sha3_pos = octeon_sha3_dat_pos_from_sel(sel);
+
+        return octeon_sha3_lane_to_reg(crypto->sha3_state[sha3_pos]);
+    }
+
+    if (sel >= OCTEON_HSH_DATW(0) &&
+        sel <= OCTEON_HSH_DATW(15)) {
+        return crypto->hsh_datw[sel - OCTEON_HSH_DATW(0)];
+    }
+    return crypto->hsh_ivw[sel - OCTEON_HSH_IVW(0)];
+}
+
+#define OCTEON_HSH_MF_DATW(N) \
+uint64_t helper_octeon_cp2_mf_hsh_datw ## N(CPUMIPSState *env) \
+{ \
+    return octeon_hsh_mf_window(&env->octeon_crypto, \
+                                OCTEON_HSH_DATW(N)); \
+}
+OCTEON_HSH_MF_DATW(0)
+OCTEON_HSH_MF_DATW(1)
+OCTEON_HSH_MF_DATW(2)
+OCTEON_HSH_MF_DATW(3)
+OCTEON_HSH_MF_DATW(4)
+OCTEON_HSH_MF_DATW(5)
+OCTEON_HSH_MF_DATW(6)
+OCTEON_HSH_MF_DATW(7)
+OCTEON_HSH_MF_DATW(8)
+OCTEON_HSH_MF_DATW(9)
+OCTEON_HSH_MF_DATW(10)
+OCTEON_HSH_MF_DATW(11)
+OCTEON_HSH_MF_DATW(12)
+OCTEON_HSH_MF_DATW(13)
+OCTEON_HSH_MF_DATW(14)
+OCTEON_HSH_MF_DATW(15)
+#undef OCTEON_HSH_MF_DATW
+
+#define OCTEON_HSH_MF_IVW(N) \
+uint64_t helper_octeon_cp2_mf_hsh_ivw ## N(CPUMIPSState *env) \
+{ \
+    return octeon_hsh_mf_window(&env->octeon_crypto, \
+                                OCTEON_HSH_IVW(N)); \
+}
+OCTEON_HSH_MF_IVW(0)
+OCTEON_HSH_MF_IVW(1)
+OCTEON_HSH_MF_IVW(2)
+OCTEON_HSH_MF_IVW(3)
+OCTEON_HSH_MF_IVW(4)
+OCTEON_HSH_MF_IVW(5)
+OCTEON_HSH_MF_IVW(6)
+OCTEON_HSH_MF_IVW(7)
+#undef OCTEON_HSH_MF_IVW
 uint64_t helper_octeon_cp2_mf_sha3_dat24(CPUMIPSState *env)
 {
     MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
@@ -1591,6 +2062,105 @@ static bool octeon_zuc_store_shared(MIPSOcteonCryptoState *crypto,
         g_assert_not_reached();
     }
 }
+static void octeon_hsh_mt_datw(MIPSOcteonCryptoState *crypto,
+                               unsigned int index, uint64_t value)
+{
+    uint32_t sel = OCTEON_HSH_DATW(index);
+
+    if (octeon_zuc_store_shared(crypto, sel, value)) {
+        return;
+    }
+    if (index == 15) {
+        crypto->hsh_datw[15] = value;
+        octeon_set_shared_mode(crypto, OCTEON_SHARED_MODE_SHA512);
+        octeon_sha512_transform(crypto);
+    } else {
+        octeon_store_shared_hsh_window(crypto, sel, value);
+    }
+}
+
+static void octeon_hsh_mt_ivw(MIPSOcteonCryptoState *crypto,
+                              unsigned int index, uint64_t value)
+{
+    uint32_t sel = OCTEON_HSH_IVW(index);
+
+    if (!octeon_zuc_store_shared(crypto, sel, value)) {
+        octeon_store_shared_hsh_window(crypto, sel, value);
+    }
+}
+
+#define OCTEON_HSH_MT_DATW(N) \
+void helper_octeon_cp2_mt_hsh_datw ## N(CPUMIPSState *env, uint64_t value) \
+{ \
+    octeon_hsh_mt_datw(&env->octeon_crypto, N, value); \
+}
+OCTEON_HSH_MT_DATW(0)
+OCTEON_HSH_MT_DATW(1)
+OCTEON_HSH_MT_DATW(2)
+OCTEON_HSH_MT_DATW(3)
+OCTEON_HSH_MT_DATW(4)
+OCTEON_HSH_MT_DATW(5)
+OCTEON_HSH_MT_DATW(6)
+OCTEON_HSH_MT_DATW(7)
+OCTEON_HSH_MT_DATW(8)
+OCTEON_HSH_MT_DATW(9)
+OCTEON_HSH_MT_DATW(10)
+OCTEON_HSH_MT_DATW(11)
+OCTEON_HSH_MT_DATW(12)
+OCTEON_HSH_MT_DATW(13)
+OCTEON_HSH_MT_DATW(14)
+OCTEON_HSH_MT_DATW(15)
+#undef OCTEON_HSH_MT_DATW
+
+#define OCTEON_HSH_MT_IVW(N) \
+void helper_octeon_cp2_mt_hsh_ivw ## N(CPUMIPSState *env, uint64_t value) \
+{ \
+    octeon_hsh_mt_ivw(&env->octeon_crypto, N, value); \
+}
+OCTEON_HSH_MT_IVW(0)
+OCTEON_HSH_MT_IVW(1)
+OCTEON_HSH_MT_IVW(2)
+OCTEON_HSH_MT_IVW(3)
+OCTEON_HSH_MT_IVW(4)
+OCTEON_HSH_MT_IVW(5)
+OCTEON_HSH_MT_IVW(6)
+OCTEON_HSH_MT_IVW(7)
+#undef OCTEON_HSH_MT_IVW
+
+void helper_octeon_cp2_mt_hsh_startsha_compat(CPUMIPSState *env,
+                                              uint64_t value)
+{
+    env->octeon_crypto.hsh_dat[7] = value;
+    octeon_sha1_transform(&env->octeon_crypto);
+}
+
+void helper_octeon_cp2_mt_hsh_startmd5(CPUMIPSState *env, uint64_t value)
+{
+    env->octeon_crypto.hsh_dat[7] = value;
+    octeon_md5_transform(&env->octeon_crypto);
+}
+
+void helper_octeon_cp2_mt_hsh_startsha256(CPUMIPSState *env, uint64_t value)
+{
+    env->octeon_crypto.hsh_dat[7] = value;
+    octeon_sha256_transform(&env->octeon_crypto);
+}
+
+void helper_octeon_cp2_mt_hsh_startsha(CPUMIPSState *env, uint64_t value)
+{
+    env->octeon_crypto.hsh_dat[7] = value;
+    octeon_sha1_transform(&env->octeon_crypto);
+}
+
+void helper_octeon_cp2_mt_hsh_startsha512(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->hsh_datw[15] = value;
+    octeon_set_shared_mode(crypto, OCTEON_SHARED_MODE_SHA512);
+    octeon_sha512_transform(crypto);
+}
+
 static void octeon_sha3_mt_dat(MIPSOcteonCryptoState *crypto,
                                uint32_t sel, uint64_t value)
 {

-- 
2.54.0


