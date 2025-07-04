Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02B5C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjFA-0002kY-9t; Fri, 04 Jul 2025 12:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEv-0001dz-Br
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:17 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEt-0006fK-En
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:17 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a6cd1a6fecso1019437f8f.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646374; x=1752251174; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pFx3Bzsm/oquSMPjOL8P8XvZX4RqsR8Y3KjwyX8yMKs=;
 b=Bye71TkG+G+VIej8hPYVWZS6yYofD6OYzB7c0CR6gZqVw3PEHqA76cE2ZuFVXH9ZS2
 IVszfTQ4wS6ZBKZhMAnZjEBoX8ILY8Fz6wco6JKYA+E71nDQHvDbUukrzZEUcgs6/0vF
 kcsJ0GUDwU50XoYol8ooqOAsqqJ+R9ri2nxsd+E++RkQU6HPovfRyWPCUEPsciQ7LfOU
 010qPlfg8xc9OTV+KZ/4D9ZBd9tDygx0Ned+6IzGBFph6i6MqJNAGy/jAYCnghSlwrTt
 l3ZKLDU1uPqi6T7mYoTCdU2EZqmOl/b+vgbQ9G1fBJEKUqv3VtEpGLRnVwMJxMhPd8Rp
 UvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646374; x=1752251174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pFx3Bzsm/oquSMPjOL8P8XvZX4RqsR8Y3KjwyX8yMKs=;
 b=poJ3wuMzpM7NzJVskV0yJXT1v24ZY0qGdrc8jAZ4MgdLApREgWL2AOSyKvFx4gIxN3
 bn0VSpl+ZVIWc5kvwBI724PEtF0JTuU2jj/1UqmqK8vZRh6PtY185a4zNRI7NeqeQwHH
 DTcTSm5AjtrmZjk8V+IQwGhUo4HqBAhKRp0mzNjFPmZbsVVEEyEAK37+ZPmnELFpJstL
 5/JLaN2J5icQFTttcfBrbHlkjepNfKjOK9aTR8AETKsDCrKDedbZvX4S3gEofJpanlRQ
 kM9tVaz4oRDYpTYSXh3b6TVfj9t5yUXFL+yM6RYktQQ0S1gO54pg7UFm5QowE80ZsINy
 Rb8A==
X-Gm-Message-State: AOJu0YyQV0/biGGmKTk7YRwxUZmIN9hz+YIda9J5LRvGDs5XoINO91KH
 Qr66ld0FozTA92HthpnLox/QqItWaLxrvcCTk0ZRgldIGvo4TYpAX9gu75OXvao8WfR05NXsMRs
 pMtqv
X-Gm-Gg: ASbGnctbL4py1sMiJhh2kAJzNdkR7/lFDRijjj8cme+hdrToRw6X3IqW9G0FO46eA2O
 UiJtlS/tnrxpMBgr9Z5dH+wmWaixZRsJ05z3220sjdtBCcym9WbuAzugMjln/tQkzcxylH/+5p2
 0d6YS+OMus+/OsJZoYp/fKBv3TMRuwQL8UujSWy9EtpuTFqV5ixdwySuQ93+GpQKUEaLBrYMsCW
 vid72tIEt/0RPa3nDo9nAyhmgFuqxux94cY6u3wip1ZX8t8GPBYoGb04Kc7yluaMcqubz9dDOCM
 5V146lW+IGvh5VFKzG/cfXu6oE37ovDUrz1C19uuLKRTV0LcfPQ98hgc467i/A0qWZnj
X-Google-Smtp-Source: AGHT+IF2sW+8Pz73lDwX82vpLdp4Bvpyh1M607vc5h/4IFVstV2ZURCZIVsolCLg35hiYS2rCe0fxQ==
X-Received: by 2002:a05:6000:2085:b0:3a4:ee51:8144 with SMTP id
 ffacd0b85a97d-3b4964f8a44mr2895715f8f.13.1751646373937; 
 Fri, 04 Jul 2025 09:26:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 074/119] target/arm: Implement SME2 ZIP, UZP (four registers)
Date: Fri,  4 Jul 2025 17:24:14 +0100
Message-ID: <20250704162501.249138-75-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-63-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sme.h    | 12 ++++++
 target/arm/tcg/sme.decode      | 11 ++++++
 target/arm/tcg/sme_helper.c    | 68 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c | 39 +++++++++++++++++++
 4 files changed, 130 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 893b23aa3bc..7e21f1095a2 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -254,3 +254,15 @@ DEF_HELPER_FLAGS_3(sme2_uunpk2_sd, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_uunpk4_bh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_uunpk4_hs, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_uunpk4_sd, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sme2_zip4_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_zip4_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_zip4_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_zip4_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_zip4_q, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sme2_uzp4_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uzp4_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uzp4_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uzp4_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uzp4_q, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 38c210cd4f0..81783b4705c 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -723,6 +723,7 @@ SUB_aaz_d       11000001 111 000010 .. 111 ...00 11 ...     @az_4x4_o3
 
 ### SME2 Multi-vector SVE Constructive Unary
 
+&zz_e           zd zn esz
 &zz_n           zd zn n
 @zz_1x2         ........ ... ..... ...... ..... zd:5        \
                 &zz_n n=1 zn=%zn_ax2
@@ -800,3 +801,13 @@ SUNPK_4sd       11000001 111 10101 111000 ....0 ...00       @zz_4x2_n1
 UUNPK_4bh       11000001 011 10101 111000 ....0 ...01       @zz_4x2_n1
 UUNPK_4hs       11000001 101 10101 111000 ....0 ...01       @zz_4x2_n1
 UUNPK_4sd       11000001 111 10101 111000 ....0 ...01       @zz_4x2_n1
+
+ZIP_4           11000001 esz:2 1 10110 111000 ...00 ... 00   \
+                &zz_e zd=%zd_ax4 zn=%zn_ax4
+ZIP_4           11000001 001     10111 111000 ...00 ... 00   \
+                &zz_e esz=4 zd=%zd_ax4 zn=%zn_ax4
+
+UZP_4           11000001 esz:2 1 10110 111000 ...00 ... 10   \
+                &zz_e zd=%zd_ax4 zn=%zn_ax4
+UZP_4           11000001 001     10111 111000 ...00 ... 10   \
+                &zz_e esz=4 zd=%zd_ax4 zn=%zn_ax4
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index ee4596e066e..4a05fff5fe2 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1812,3 +1812,71 @@ void HELPER(sme2_ucvtf)(void *vd, void *vs, float_status *fpst, uint32_t desc)
         d[i] = uint32_to_float32(s[i], fpst);
     }
 }
+
+#define ZIP4(NAME, TYPE, H)                                     \
+void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
+{                                                               \
+    ARMVectorReg scratch[4];                                    \
+    size_t oprsz = simd_oprsz(desc);                            \
+    size_t quads = oprsz / (sizeof(TYPE) * 4);                  \
+    TYPE *s0, *s1, *s2, *s3;                                    \
+    if (vs == vd) {                                             \
+        vs = memcpy(scratch, vs, sizeof(scratch));              \
+    }                                                           \
+    s0 = vs;                                                    \
+    s1 = vs + sizeof(ARMVectorReg);                             \
+    s2 = vs + 2 * sizeof(ARMVectorReg);                         \
+    s3 = vs + 3 * sizeof(ARMVectorReg);                         \
+    for (size_t r = 0; r < 4; ++r) {                            \
+        TYPE *d = vd + r * sizeof(ARMVectorReg);                \
+        size_t base = r * quads;                                \
+        for (size_t q = 0; q < quads; ++q) {                    \
+            d[H(4 * q + 0)] = s0[base + H(q)];                  \
+            d[H(4 * q + 1)] = s1[base + H(q)];                  \
+            d[H(4 * q + 2)] = s2[base + H(q)];                  \
+            d[H(4 * q + 3)] = s3[base + H(q)];                  \
+        }                                                       \
+    }                                                           \
+}
+
+ZIP4(sme2_zip4_b, uint8_t, H1)
+ZIP4(sme2_zip4_h, uint16_t, H2)
+ZIP4(sme2_zip4_s, uint32_t, H4)
+ZIP4(sme2_zip4_d, uint64_t, )
+ZIP4(sme2_zip4_q, Int128, )
+
+#undef ZIP4
+
+#define UZP4(NAME, TYPE, H)                                     \
+void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
+{                                                               \
+    ARMVectorReg scratch[4];                                    \
+    size_t oprsz = simd_oprsz(desc);                            \
+    size_t quads = oprsz / (sizeof(TYPE) * 4);                  \
+    TYPE *d0, *d1, *d2, *d3;                                    \
+    if (vs == vd) {                                             \
+        vs = memcpy(scratch, vs, sizeof(scratch));              \
+    }                                                           \
+    d0 = vd;                                                    \
+    d1 = vd + sizeof(ARMVectorReg);                             \
+    d2 = vd + 2 * sizeof(ARMVectorReg);                         \
+    d3 = vd + 3 * sizeof(ARMVectorReg);                         \
+    for (size_t r = 0; r < 4; ++r) {                            \
+        TYPE *s = vs + r * sizeof(ARMVectorReg);                \
+        size_t base = r * quads;                                \
+        for (size_t q = 0; q < quads; ++q) {                    \
+            d0[base + H(q)] = s[H(4 * q + 0)];                  \
+            d1[base + H(q)] = s[H(4 * q + 1)];                  \
+            d2[base + H(q)] = s[H(4 * q + 2)];                  \
+            d3[base + H(q)] = s[H(4 * q + 3)];                  \
+        }                                                       \
+    }                                                           \
+}
+
+UZP4(sme2_uzp4_b, uint8_t, H1)
+UZP4(sme2_uzp4_h, uint16_t, H2)
+UZP4(sme2_uzp4_s, uint32_t, H4)
+UZP4(sme2_uzp4_d, uint64_t, )
+UZP4(sme2_uzp4_q, Int128, )
+
+#undef UZP4
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index b45e68750d9..de9545ee6d9 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1435,3 +1435,42 @@ TRANS_FEAT(UUNPK_2sd, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uunpk2_sd)
 TRANS_FEAT(UUNPK_4bh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uunpk4_bh)
 TRANS_FEAT(UUNPK_4hs, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uunpk4_hs)
 TRANS_FEAT(UUNPK_4sd, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uunpk4_sd)
+
+static bool do_zipuzp_4(DisasContext *s, arg_zz_e *a,
+                        gen_helper_gvec_2 * const fn[5])
+{
+    int bytes_per_op = 4 << a->esz;
+
+    /* Both MO_64 and MO_128 can fail the size test. */
+    if (s->max_svl < bytes_per_op) {
+        unallocated_encoding(s);
+    } else if (sme_sm_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        if (svl < bytes_per_op) {
+            unallocated_encoding(s);
+        } else {
+            tcg_gen_gvec_2_ool(vec_full_reg_offset(s, a->zd),
+                               vec_full_reg_offset(s, a->zn),
+                               svl, svl, 0, fn[a->esz]);
+        }
+    }
+    return true;
+}
+
+static gen_helper_gvec_2 * const zip4_fns[] = {
+    gen_helper_sme2_zip4_b,
+    gen_helper_sme2_zip4_h,
+    gen_helper_sme2_zip4_s,
+    gen_helper_sme2_zip4_d,
+    gen_helper_sme2_zip4_q,
+};
+TRANS_FEAT(ZIP_4, aa64_sme2, do_zipuzp_4, a, zip4_fns)
+
+static gen_helper_gvec_2 * const uzp4_fns[] = {
+    gen_helper_sme2_uzp4_b,
+    gen_helper_sme2_uzp4_h,
+    gen_helper_sme2_uzp4_s,
+    gen_helper_sme2_uzp4_d,
+    gen_helper_sme2_uzp4_q,
+};
+TRANS_FEAT(UZP_4, aa64_sme2, do_zipuzp_4, a, uzp4_fns)
-- 
2.43.0


