Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC87C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhRX-0006rz-WD; Fri, 04 Jul 2025 10:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhM0-0004Mg-TE
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:32 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhLu-000827-Aa
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:28 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-73a44512c8aso341107a34.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639121; x=1752243921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N7XOMMIFTSKQBGT6FbweY3+4jI14Ld7/hjKCxCVbLuQ=;
 b=ep53hufMun/kH/IlXixNfsSUTfp2vRoPdAntH9L5T+lSfGIUv1SXfPzW+6hJM3USyB
 ySzsVPnGXDPdfBnXEgz752JJEU+/tvFiK54m62a6XsL3/4boeL698OlIfwgRDWjMJYzz
 6YBqpJ3zSiFNxrCLmRbrT7bnuSwS6WG6lIkCFBOcc0nmj7MnXSBmkio5bJbFDpFvsKqM
 w7wEtdyfapBy1xaqLsAcM6XQ32xpnbikgTNo2S28iamSQ+bwhkRmLSDpKeDA7A7fWWK0
 kKKxTXOWNnRfiuGHfI0AXBNpbdZHa+dvo0LDYJjAMIS8SFlucpkqpvREOrsWXd/I3qJw
 kWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639121; x=1752243921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N7XOMMIFTSKQBGT6FbweY3+4jI14Ld7/hjKCxCVbLuQ=;
 b=xPPHDbNZu7/FAdfS8U/ytiXRRU/4MpVr/oZt988XEsnAoFS27ix9vSeQCdN60g5h6w
 91PSKRMDEMoSYZ6anH0/poh7MEYwJnJVd8wgmvSuZteskmf+KbWAArDQaG7FtmF2/V2g
 Zpo2O2j6YU6WHBzCXuTsajH89dKu+NqlmkLqVKmbZ++z8JgfuR85VLIIhboiEUov7Y7p
 7jM6HsbmJYnnsZNwdSiONIoLs75K/VHgarZun37TkyrFsJ/SpyNWmJCkhwnfSJxI9dwh
 F6gLyRgAiTmy3VRrbSpIamA8ZknHsinMU7HvdrEubupFf4ZIBC7z4w5djpR7yA/PF1E+
 Ttyg==
X-Gm-Message-State: AOJu0YwNGKPbwGPmJh54g7jWMdYahn2wBhsD6RrYReGCqpZ7kIxHHyDf
 UHNOEko95pAyyGa2BtntHbjpkmtYqQnn6TgNxLkZAmPIU2O3LIO/80Cq820lMWNymur1SG7PD0r
 wIb2XJkM=
X-Gm-Gg: ASbGncu4nmpx+uJApS78EiO8+ISnQ6F9XHf1R9XH2y5G/5jiTp2uLQ43AAIU7LZ8AjE
 JXM9hzTZ8BefdAGHbLdNKtw1HzWY6zJ38ByLYz2ilIfHMWNxQWORWgeK/yi3N308pURpI+dJtUQ
 SXP78YFci+uYfVZEybOlX69QtEpueyAXZ0rE8CrSVovhfcr3FN0GRlu3j9f3pZNiak0MRUdqNYX
 nHrAV5Vah/Kl4LrW/2s4IuEKgks8LE56+KK779kjpouJlUOYLKWdZE9oIf+KhjfP3ZR0CAEwBPK
 SQs/XHux7gKsmKkXMPm8UMSkA//mJHI1wQSdHt9EazHvrGQD99XtubN7YYYfm66N8zRjs9JXRnC
 dy3GS2h/ub5q1C7R664GRsiN/PIDmBuTOftQf2w+ehcyF0AGNco85tPUF/t4=
X-Google-Smtp-Source: AGHT+IELCeY8hxKWUV2rT7NKOJkAHaG1zUmi5s8PhdJ03FkHU9FDRA0hbMNxJRtgQugal2DNECahjg==
X-Received: by 2002:a05:6830:4889:b0:73a:96e5:19cd with SMTP id
 46e09a7af769-73ca48d5d17mr1677357a34.10.1751639120683; 
 Fri, 04 Jul 2025 07:25:20 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac5eesm310233eaf.29.2025.07.04.07.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:25:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 062/108] target/arm: Implement SME2 ZIP,
 UZP (four registers)
Date: Fri,  4 Jul 2025 08:20:25 -0600
Message-ID: <20250704142112.1018902-63-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme.h    | 12 ++++++
 target/arm/tcg/sme_helper.c    | 68 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c | 39 +++++++++++++++++++
 target/arm/tcg/sme.decode      | 11 ++++++
 4 files changed, 130 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 893b23aa3b..7e21f1095a 100644
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
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index ee4596e066..4a05fff5fe 100644
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
index b45e68750d..de9545ee6d 100644
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
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 38c210cd4f..81783b4705 100644
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
-- 
2.43.0


