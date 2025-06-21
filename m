Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8202DC71157
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT82T-0002Mu-MB; Sat, 21 Jun 2025 19:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82H-00022y-9d
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:13 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82D-0004w0-OD
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:11 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-747fc7506d4so2280595b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550048; x=1751154848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vUUCKzZYA1jd1EVdDhV1uqnXtGgdY8nEQ++2V3ghOlc=;
 b=OuAMUc6cBUtk94UJgu4HJONdNaZZ2vYQcNNs7dYGu11birygAizM6yDftsBbNu6rDP
 XH9dJHcHDdCznkuqMNk4VBm9dJklAc3oe9vIo2hld3HPsXT5AMztcHm5cB2b7UydS+jj
 Z5r8KlxPNnLEAOtembuhQ3ReiT1Jy1vfeKwtbWt5BY6yq07llhJJ9OA9t0iW3mA5juVe
 qukES4S5Yy5MhvU7iuLfd8PqzVqLJVxOlYThcYXiIUIeWJKpgGi224dLaDI7/2hcqZMB
 d96V9BuTp8Omfav5LW3I1W/HA83uq7kuyUzsT4E0bhzUZq6VpEbGybE7oUGf/GNv9yj4
 jhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550048; x=1751154848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vUUCKzZYA1jd1EVdDhV1uqnXtGgdY8nEQ++2V3ghOlc=;
 b=wnrr/zcxwmvG2qTz9l5Hk2MPd/qgcQ7YViJpL9A8PmmKm5wvN4b1RpXbbDRNOTKVZD
 DWG0ch4RetAJiN7jk+pL7Ta+3jJq0GI/j/hKZbX9o1Yyxe+9UJHtq28qZCVq5vbVBIh4
 38GBj7oOuS6TluHmYQFymtj9FQbWTw6TZZdQG8BjcSFNCBmT9x+LZvv3575L1IB9+Mh8
 zihIhHJquiO1nFNupGHE8MwghV43OqZR+B4s6NaP+cRcWu+XzObUz19YfOegeSo0g3aK
 GC40btwCTynkHngkyW/QR4XdTgzI1saGWynWplhqMqcXAeOuwKQXMvL+zUK3NFeZiHme
 RKhw==
X-Gm-Message-State: AOJu0YxI6Kpk4ot5UXJ3nlCS8yQ2jof2wiIY7BsQgWtvx1HDemst+9t4
 F6YJ0b+uCWTSAOCZygjQ6WO0kyPDQBEP+Hb5bAzrRmfqUoQaVZ7dB3yXfhf1OfS8a4940W3zjzc
 loDx8uSc=
X-Gm-Gg: ASbGncvYLN+l9OJWO50S7egloQ12clniXl9jL7XcfHmrnb2oxoyjcTnwOQQaM4kVVh+
 6cB/vrR5L/2vQkLAMp0CeefRlOstg9XU9muOf/XppVv8WWNM3u8gqf7ff7tw2rmGoWVqMudzOgy
 XX7zRDcUkHzqVmiMRPtrKzL9BnO2BsfkABmtoMju8ziw9IEnpAQ8LV/PsanFMAHorVYud5PeBpI
 z77m2qIkrTPtsWM7LLjxYl6N6InAvM30/K0oaJc4UMEcTYEDfS67mJzlEzaj042mfNZfUisXR9c
 ybLoWkssPVcI5MCvDDqvdI8y9Xcf2UhuPioctc9hySWT347J9hOyjiI8Iorz1VSRR61wz8UD14A
 YKdL1vRTEjtPtmFyf5jpH
X-Google-Smtp-Source: AGHT+IEXdI6r/gyE8S1G2tk3trB+lS3dTuCLFuS+XsOQ4Ail0LJZ7u3O8xPxR+uKfOiwa87cqqlT4g==
X-Received: by 2002:a05:6a00:3d53:b0:732:2923:b70f with SMTP id
 d2e1a72fcca58-7490da6e841mr10102762b3a.11.1750550047723; 
 Sat, 21 Jun 2025 16:54:07 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b590sm4970051b3a.27.2025.06.21.16.54.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:54:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 044/101] target/arm: Implement SME2 SVDOT, UVDOT, SUVDOT,
 USVDOT
Date: Sat, 21 Jun 2025 16:49:40 -0700
Message-ID: <20250621235037.74091-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme.h    | 11 +++++++++
 target/arm/tcg/sme_helper.c    | 42 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c | 23 +++++++++++++++++++
 target/arm/tcg/sme.decode      | 11 +++++++++
 4 files changed, 87 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 8f5a1b3c90..464877516b 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -180,3 +180,14 @@ DEF_HELPER_FLAGS_6(sme2_fdot_idx_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_6(sme2_fvdot_idx_h, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_4(sme2_svdot_idx_4b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_uvdot_idx_4b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_suvdot_idx_4b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_usvdot_idx_4b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sme2_svdot_idx_4h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_uvdot_idx_4h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sme2_svdot_idx_2h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sme2_uvdot_idx_2h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index ca632b034e..1fb526ac78 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1386,3 +1386,45 @@ DEF_IMOP_16x2_32(umopa2_s, uint16_t, uint16_t)
 
 DEF_IMOPH(sme2, smopa2, s)
 DEF_IMOPH(sme2, umopa2, s)
+
+#define DO_VDOT_IDX(NAME, TYPED, TYPEN, TYPEM, HD, HN) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)            \
+{                                                                         \
+    intptr_t svl = simd_oprsz(desc);                                      \
+    intptr_t elements = svl / sizeof(TYPED);                              \
+    intptr_t eltperseg = 16 / sizeof(TYPED);                              \
+    intptr_t vstride = (svl / 4) * sizeof(ARMVectorReg);                  \
+    intptr_t zstride = sizeof(ARMVectorReg) / sizeof(TYPEN);              \
+    intptr_t nreg = sizeof(TYPED) / sizeof(TYPEN);                        \
+    intptr_t idx = extract32(desc, SIMD_DATA_SHIFT, 2);                   \
+    TYPEN *n = vn;                                                        \
+    TYPEM *m = vm;                                                        \
+    for (intptr_t r = 0; r < nreg; r++) {                                 \
+        TYPED *d = vd + r * vstride;                                      \
+        for (intptr_t seg = 0; seg < elements; seg += eltperseg) {        \
+            intptr_t s = seg + idx;                                       \
+            for (intptr_t e = seg; e < seg + eltperseg; e++) {            \
+                TYPED sum = d[HD(e)];                                     \
+                for (intptr_t i = 0; i < nreg; i++) {                     \
+                    TYPED nn = n[i * zstride + HN(nreg * e + r)];         \
+                    TYPED mm = m[HN(nreg * s + i)];                       \
+                    sum += nn * mm;                                       \
+                }                                                         \
+                d[HD(e)] = sum;                                           \
+            }                                                             \
+        }                                                                 \
+    }                                                                     \
+}
+
+DO_VDOT_IDX(sme2_svdot_idx_4b, int32_t, int8_t, int8_t, H4, H1)
+DO_VDOT_IDX(sme2_uvdot_idx_4b, uint32_t, uint8_t, uint8_t, H4, H1)
+DO_VDOT_IDX(sme2_suvdot_idx_4b, int32_t, int8_t, uint8_t, H4, H1)
+DO_VDOT_IDX(sme2_usvdot_idx_4b, int32_t, uint8_t, int8_t, H4, H1)
+
+DO_VDOT_IDX(sme2_svdot_idx_4h, int64_t, int16_t, int16_t, H8, H2)
+DO_VDOT_IDX(sme2_uvdot_idx_4h, uint64_t, uint16_t, uint16_t, H8, H2)
+
+DO_VDOT_IDX(sme2_svdot_idx_2h, int32_t, int16_t, int16_t, H4, H2)
+DO_VDOT_IDX(sme2_uvdot_idx_2h, uint32_t, uint16_t, uint16_t, H4, H2)
+
+#undef DO_VDOT_IDX
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index ea1aff004c..9cc8b5760b 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -980,3 +980,26 @@ TRANS_FEAT(SDOT_nx_4b, aa64_sme, do_dot_nx, a, gen_helper_gvec_sdot_idx_4b)
 TRANS_FEAT(UDOT_nx_4b, aa64_sme, do_dot_nx, a, gen_helper_gvec_udot_idx_4b)
 TRANS_FEAT(SDOT_nx_4h, aa64_sme2_i16i64, do_dot_nx, a, gen_helper_gvec_sdot_idx_4h)
 TRANS_FEAT(UDOT_nx_4h, aa64_sme2_i16i64, do_dot_nx, a, gen_helper_gvec_udot_idx_4h)
+
+static bool do_vdot_nx(DisasContext *s, arg_azx_n *a, gen_helper_gvec_3 *fn)
+{
+    if (sme_sm_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        fn(get_zarray(s, a->rv, a->off, a->n),
+           vec_full_reg_ptr(s, a->zn),
+           vec_full_reg_ptr(s, a->zm),
+           tcg_constant_i32(simd_desc(svl, svl, a->idx)));
+    }
+    return true;
+}
+
+TRANS_FEAT(SVDOT_nx_2h, aa64_sme, do_vdot_nx, a, gen_helper_sme2_svdot_idx_2h)
+TRANS_FEAT(SVDOT_nx_4b, aa64_sme, do_vdot_nx, a, gen_helper_sme2_svdot_idx_4b)
+TRANS_FEAT(SVDOT_nx_4h, aa64_sme, do_vdot_nx, a, gen_helper_sme2_svdot_idx_4h)
+
+TRANS_FEAT(UVDOT_nx_2h, aa64_sme, do_vdot_nx, a, gen_helper_sme2_uvdot_idx_2h)
+TRANS_FEAT(UVDOT_nx_4b, aa64_sme, do_vdot_nx, a, gen_helper_sme2_uvdot_idx_4b)
+TRANS_FEAT(UVDOT_nx_4h, aa64_sme, do_vdot_nx, a, gen_helper_sme2_uvdot_idx_4h)
+
+TRANS_FEAT(SUVDOT_nx_4b, aa64_sme, do_vdot_nx, a, gen_helper_sme2_suvdot_idx_4b)
+TRANS_FEAT(USVDOT_nx_4b, aa64_sme, do_vdot_nx, a, gen_helper_sme2_usvdot_idx_4b)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 338637decd..4146744a46 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -438,3 +438,14 @@ USDOT_nx        11000001 0101 .... 1 .. 1 .. ...01 01 ...   @azx_4x1_i2_o3
 
 SUDOT_nx        11000001 0101 .... 0 .. 1 .. ....1 11 ...   @azx_2x1_i2_o3
 SUDOT_nx        11000001 0101 .... 1 .. 1 .. ...01 11 ...   @azx_4x1_i2_o3
+
+SVDOT_nx_2h     11000001 0101 .... 0 .. 0 .. ....1 00 ...   @azx_2x1_i2_o3
+SVDOT_nx_4b     11000001 0101 .... 1 .. 0 .. ...01 00 ...   @azx_4x1_i2_o3
+SVDOT_nx_4h     11000001 1101 .... 1 .. 01 . ...00 01 ...   @azx_4x1_i1_o3
+
+UVDOT_nx_2h     11000001 0101 .... 0 .. 0 .. ....1 10 ...   @azx_2x1_i2_o3
+UVDOT_nx_4b     11000001 0101 .... 1 .. 0 .. ...01 10 ...   @azx_4x1_i2_o3
+UVDOT_nx_4h     11000001 1101 .... 1 .. 01 . ...00 11 ...   @azx_4x1_i1_o3
+
+SUVDOT_nx_4b    11000001 0101 .... 1 .. 0 .. ...01 11 ...   @azx_4x1_i2_o3
+USVDOT_nx_4b    11000001 0101 .... 1 .. 0 .. ...01 01 ...   @azx_4x1_i2_o3
-- 
2.43.0


