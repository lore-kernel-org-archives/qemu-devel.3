Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E9ECD4F5B
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 05:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQIJI-0002jd-Ab; Fri, 22 May 2026 01:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQIJE-0002bK-UH
 for qemu-devel@nongnu.org; Fri, 22 May 2026 01:20:32 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wQIJC-00024F-Fs
 for qemu-devel@nongnu.org; Fri, 22 May 2026 01:20:32 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-484cf882ce5so4860935b6e.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 22:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779427229; x=1780032029; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PZge12psOd2xaJmayrbXAqUYyk1aMCSXLGKP7oqSpY8=;
 b=SFx1T+x5l5hvL2G441hkbxdBMq1CTA7AHxuhPf++kAbfVTautDPCmi4pDGQVRtaHrk
 plVNssA/nC7fhUhPyQaq9jYeBtIYC8kEKjMmQPhFq5ZPkcLggkJWww93gTjXMk+coa5f
 SCk2Y0oPjvTHytHwMXt0Ap8R0mONBUkt3G1DMr/UbPXov7bsccMm4hb6pjA/d91lmOyH
 gCKrdT04gGVRQ/IijCMSj5/Uh+XgeJbDsFDLJAs/48hOThQ2+cHCuUcP+QVFd/Pl5EGB
 L3mJQ4UpHBM6zlZHJZgqr8aM1TMsRW5hWF/KQg9fJWYlVrhmNZfpT19VU2vz7kTIi78e
 vCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779427229; x=1780032029;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PZge12psOd2xaJmayrbXAqUYyk1aMCSXLGKP7oqSpY8=;
 b=ClxiL5qVPtmFvOb6upWWg10Zk5wuoosDC9N3NzEmgSORquSizN+PDo2AJtEgToKN3o
 j5AZbxrqYOtkKmapDJfIGnl7MZ5ohAC//rgaTZLsi6wNgyNPuAUuctYr62tTmet3MwQX
 GNujQE2xEu3fXUat3mlBMahxvLXB54vLSzotSaDPACxGfvNchOuph/vQ/uQewy8oRM7J
 UT5MBGBQK2kzCMwY6Jj9RMFX0JvoIHwXT0lAIeW/fT+4lDjeS4iFxV41t0eGuKpPWAYu
 MSCNaPT3sGj99d+MDMgRWp3euIDZCJEwAWDgccOGCY9crtnty3e8SPqUdB0qakdNsD59
 xVxA==
X-Gm-Message-State: AOJu0YzMAP1yXERQiMSRtR80JeY5vaA4iD6GZQ9mjGWg3D/+0jq4YO9s
 dK++uRoDzvyuFlDXX5aSvdYXae2WUW/Aq59qPuYe2pphbR47fjL//URH
X-Gm-Gg: Acq92OEXr6uG/Ctsal4ihHVgbX7cSECrYNpQ6P9hA7BCL6tktgy5qY7zaUXoFCGcW/r
 pFnkQbT9PgzgTCoc1zGw95x4mjlXfZVBvV+qknJWlb90P5hLuOzlS3pDlAwQpNUk8rz/aYlhW1v
 5pSzp9/cnCQVmBeF3f/GedYY8jDfHBrbPDxDR1EQA3zCK/0ZroXx7X7h4kgip0CXytocYhLL9vm
 tq8InxXRxVAF92UsYAUgJ7mXitNbPNi/nGrtqvIe7GXMU8r6CfQo0KRxPT2UQ3c0hbJkDbBh8Pf
 qJTdcqqsgTng3SXF6goCBpmi/Ds1LB0H38Fvdi2TzCMG5TJcRnUBwlb8zq/myuRrGUMI/ihfmvE
 RAMawwiZHBnhrNPLsTlxhKb7LNTbiOwgMSFQccU1KHkH2Xr+2EpanAs95h3aYS4u1cuPzkuzImp
 rSjostGpR4WMVNrS12Kxh3Zeul3bfeuqKnvmbYAPNw25MfQRFH1cgmVxdZHhn/kURwuC9HlYwH0
 qnlfESou8CRbSxtigznLmAnK7YWZ6j6MR9JwAHAvPrexRyigZERRSrzj9riww6j7Hwa
X-Received: by 2002:a05:6808:1997:b0:479:ded7:477 with SMTP id
 5614622812f47-4854a24da98mr1340302b6e.40.1779427229331; 
 Thu, 21 May 2026 22:20:29 -0700 (PDT)
Received: from mac.localdomain (184-96-131-78.hlrn.qwest.net. [184.96.131.78])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4855476ab77sm59690b6e.17.2026.05.21.22.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 22:20:29 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 21 May 2026 23:19:55 -0600
Subject: [PATCH v14 13/22] target/mips: add Octeon HSH COP2 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-mips-octeon-missing-insns-v2-v14-13-fbf08e164830@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22f.google.com
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
ZUC. Keep the aliased readback and write paths centralized so selector
decode can route register accesses through these helpers when side
effects are required.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v13 -> v14:
  - Keep HSH narrow DAT/IV state updates in the low 32-bit halves of the
    architectural HSH register bank so paired selector transfers preserve
    the wide shared-window state.

Changes v10 -> v13:
  - Keep the 0x0057 SDK compatibility path as an explicit STARTSHA1
    compatibility helper instead of a generic STARTSHA name.

Changes v9 -> v10:
  - Remove references to shared-mode tracking; aliased state is kept in the
    architectural HSH register banks.

Changes v8 -> v9:
  - Split HSH/SHA helpers into their own COP2 helper patch.
  - Replace generic selector dispatch with per-operation HSH helpers.
  - Keep shared-window readback and write helpers grouped with HSH.
  - Add matching helper.h declarations with the helper implementation.
---
 target/mips/helper.h            |   5 +
 target/mips/tcg/octeon_crypto.c | 375 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 380 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index fbf8250932..d18ade0094 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -91,6 +91,11 @@ DEF_HELPER_2(octeon_cp2_mt_des3_dec, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_camellia_fl, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_camellia_flinv, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_camellia_round, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_startsha1_compat, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_startmd5, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_startsha256, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_startsha, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_hsh_startsha512, void, env, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index 5bb21098fc..3db81d608d 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -151,6 +151,348 @@ static void octeon_gfm_mul64_uia2(const uint64_t x[2], const uint64_t y[2],
     out[1] = revbit64(res);
 }
 
+static inline uint32_t octeon_hsh_get32(const uint64_t *regs,
+                                        unsigned int index)
+{
+    return regs[index];
+}
+
+static inline void octeon_hsh_set32(uint64_t *regs, unsigned int index,
+                                    uint32_t value)
+{
+    regs[index] = (regs[index] & ~(uint64_t)UINT32_MAX) | value;
+}
+
+static inline void octeon_hsh_set_pair(uint64_t *regs, unsigned int index,
+                                       uint64_t value)
+{
+    octeon_hsh_set32(regs, index * 2, value >> 32);
+    octeon_hsh_set32(regs, index * 2 + 1, value);
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
+    uint32_t m[16];
+    uint32_t a, b, c, d;
+    uint32_t aa, bb, cc, dd;
+    int i;
+
+    for (i = 0; i < 16; i++) {
+        m[i] = bswap32(octeon_hsh_get32(crypto->hsh_dat, i));
+    }
+
+    a = bswap32(octeon_hsh_get32(crypto->hsh_iv, 0));
+    b = bswap32(octeon_hsh_get32(crypto->hsh_iv, 1));
+    c = bswap32(octeon_hsh_get32(crypto->hsh_iv, 2));
+    d = bswap32(octeon_hsh_get32(crypto->hsh_iv, 3));
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
+    octeon_hsh_set32(crypto->hsh_iv, 0, bswap32(a));
+    octeon_hsh_set32(crypto->hsh_iv, 1, bswap32(b));
+    octeon_hsh_set32(crypto->hsh_iv, 2, bswap32(c));
+    octeon_hsh_set32(crypto->hsh_iv, 3, bswap32(d));
+}
+
+static void octeon_sha1_transform(MIPSOcteonCryptoState *crypto)
+{
+    uint32_t w[80];
+    uint32_t a, b, c, d, e;
+    uint32_t orig[5];
+    int i;
+
+    for (i = 0; i < 16; i++) {
+        w[i] = octeon_hsh_get32(crypto->hsh_dat, i);
+    }
+    for (i = 16; i < 80; i++) {
+        w[i] = rol32(w[i - 3] ^ w[i - 8] ^ w[i - 14] ^ w[i - 16], 1);
+    }
+
+    for (i = 0; i < 5; i++) {
+        orig[i] = octeon_hsh_get32(crypto->hsh_iv, i);
+    }
+    a = orig[0];
+    b = orig[1];
+    c = orig[2];
+    d = orig[3];
+    e = orig[4];
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
+    orig[0] += a;
+    orig[1] += b;
+    orig[2] += c;
+    orig[3] += d;
+    orig[4] += e;
+    for (i = 0; i < 5; i++) {
+        octeon_hsh_set32(crypto->hsh_iv, i, orig[i]);
+    }
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
+    for (i = 0; i < 16; i++) {
+        w[i] = octeon_hsh_get32(crypto->hsh_dat, i);
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
+    for (i = 0; i < 8; i++) {
+        orig[i] = octeon_hsh_get32(crypto->hsh_iv, i);
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
+    for (i = 0; i < 8; i++) {
+        octeon_hsh_set32(crypto->hsh_iv, i, orig[i]);
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
+        w[i] = crypto->hsh_dat[i];
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
+    a = crypto->hsh_iv[0];
+    b = crypto->hsh_iv[1];
+    c = crypto->hsh_iv[2];
+    d = crypto->hsh_iv[3];
+    e = crypto->hsh_iv[4];
+    f = crypto->hsh_iv[5];
+    g = crypto->hsh_iv[6];
+    h = crypto->hsh_iv[7];
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
+    crypto->hsh_iv[0] += a;
+    crypto->hsh_iv[1] += b;
+    crypto->hsh_iv[2] += c;
+    crypto->hsh_iv[3] += d;
+    crypto->hsh_iv[4] += e;
+    crypto->hsh_iv[5] += f;
+    crypto->hsh_iv[6] += g;
+    crypto->hsh_iv[7] += h;
+}
+
 static const uint64_t octeon_sha3_round_constants[24] = {
     0x0000000000000001ULL, 0x0000000000008082ULL,
     0x800000000000808aULL, 0x8000000080008000ULL,
@@ -1761,6 +2103,39 @@ void helper_octeon_cp2_mt_zuc_more(CPUMIPSState *env, uint64_t value)
     octeon_zuc_more(&env->octeon_crypto, value);
 }
 
+void helper_octeon_cp2_mt_hsh_startsha1_compat(CPUMIPSState *env,
+                                               uint64_t value)
+{
+    octeon_hsh_set_pair(env->octeon_crypto.hsh_dat, 7, value);
+    octeon_sha1_transform(&env->octeon_crypto);
+}
+
+void helper_octeon_cp2_mt_hsh_startmd5(CPUMIPSState *env, uint64_t value)
+{
+    octeon_hsh_set_pair(env->octeon_crypto.hsh_dat, 7, value);
+    octeon_md5_transform(&env->octeon_crypto);
+}
+
+void helper_octeon_cp2_mt_hsh_startsha256(CPUMIPSState *env, uint64_t value)
+{
+    octeon_hsh_set_pair(env->octeon_crypto.hsh_dat, 7, value);
+    octeon_sha256_transform(&env->octeon_crypto);
+}
+
+void helper_octeon_cp2_mt_hsh_startsha(CPUMIPSState *env, uint64_t value)
+{
+    octeon_hsh_set_pair(env->octeon_crypto.hsh_dat, 7, value);
+    octeon_sha1_transform(&env->octeon_crypto);
+}
+
+void helper_octeon_cp2_mt_hsh_startsha512(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->hsh_dat[15] = value;
+    octeon_sha512_transform(crypto);
+}
+
 uint64_t helper_octeon_cp2_mf_crc_iv_reflect(CPUMIPSState *env)
 {
     return octeon_crc_reflect32_by_byte(env->octeon_crypto.crc_iv);

-- 
2.54.0


