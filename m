Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4BEC7115C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT7zI-0005Ek-Hl; Sat, 21 Jun 2025 19:51:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7zD-0005BQ-IE
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:51:03 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT7zB-0004WP-Iz
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:51:02 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-748f54dfa5fso2121727b3a.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750549860; x=1751154660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rSF+vs+D6gMXb8oC6QBsN2Ev1Yy7SGH5RktYXo0psgc=;
 b=e/qGiEY2SpLL+i8grY7nzg/7jCmPD42FqKYYFCWU1xUj10xF4i7Z7RHm5pD0SyrkBi
 71FmuqNIuVA2W/d0RuN5NpMjbzQ6ZtfGYEFGi0N72d6qCIt/SeROeRjVn7m7yqQJB0yL
 j99Hp9I7LU0vhJ1HAkhINQJkpGBsx13rlzg0ia0kWmnjw5xmtjiDA9TzksfdviFjZu59
 9cNKcw4A4u7CZllY6UetLt1OVgnUTJm3CLegyJi4NllhKx7zs8DHJuNfv5nE/w97KSEX
 g0AAWcekenaei8El2+QkXOPWKnxW/5RJ1bya/s39HHBe5TTDKMsaJ0+KTSFw+5+Nzsji
 86RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750549860; x=1751154660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rSF+vs+D6gMXb8oC6QBsN2Ev1Yy7SGH5RktYXo0psgc=;
 b=es7CI60BEDv+js73nk6jegOFeQucGHtg4RxChgnxmJAZzgrlrf1oJ90YbS8K9+REdT
 HUIMOz6tfUMx0onVjR3+ENODtDzBAgdyMtLsSQ3NIw+jvpvL3ie15mFHoiIpRjZWxId3
 jnv1TteYy2qfyOdLVa2Dp7XzUbYMkrY+HoOQD8N0Ya+21n0Ui+uExb0pVZTjlxoae23Y
 V1GHlOsyi7O7XVSao67cJLDWP75xhCIwgOoGeM7pSViMW9uyAhog3FU0uLQJu1rhOzxf
 9IHLvS3JNOsXm870lh1x88Y2ck5ONU/5emyVRRYEFj5pQ/YtUmTiFOb5Z9cAyOV7pzzN
 27jQ==
X-Gm-Message-State: AOJu0Yy1vWMH/JhB4TfvBJtaBSEHfNlkRy8YegPAU6q0yvjU4USIAB96
 /Ipgo2XR26K3WvDYmG+o5LytBQhBAX5cfFgKKI+76xThaNtScS0jn5Tc/1wSoS4Gh2D60G7R4LY
 nMmkV
X-Gm-Gg: ASbGncvbg4+cr9pAgWteXlbUROduCmyYHzBn44AfVj4H9TuLTQNcPJQmm/zrSElJ1o4
 lkUIJhEtustJUcUgUopPzxKc2A3vHyg/Qiy3Alg0ZxWr4OR/Gtkvc3794CsADzzSr9Kf6H+Amna
 lGdIi2Zls/+jO4ud/zPowbgEvOR0DFo8uSTiTFx2UgJNIlCGcWzqC8JRu4zWREi6o1unb+/4Coi
 OLzf8klgReZqDGRJX4E/S8/8MEldGyt0u+s17Ebxixtc18JZSt/lgzGjBEin9f+qO0u0Z3pUoYG
 +jY89Lcd6zHnI0Aoq7Y+C4/3ZwQF3NwVvdm4Ye2LeAYxeSI99Yxhjord0dRU7AIgS3mJy8PhMzr
 sWyYcX5M9X5BDURiOeNx9
X-Google-Smtp-Source: AGHT+IHxEcno9BtQ+WicJiFQquE8lgpinhTMoNXBSv4lKCcqHPRolsNRLZtSx6nzb5o4Ej1RvURiUw==
X-Received: by 2002:a05:6a00:138e:b0:742:a77b:8c3 with SMTP id
 d2e1a72fcca58-7490d73edcfmr12035045b3a.4.1750549860297; 
 Sat, 21 Jun 2025 16:51:00 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a49ebd0sm5073744b3a.55.2025.06.21.16.50.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:51:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 033/101] target/arm: Pass ZA to helper_sve2_fmlal_zz[zx]w_s
Date: Sat, 21 Jun 2025 16:49:29 -0700
Message-ID: <20250621235037.74091-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Indicate whether to use FPST_FPCR or FPST_ZA via bit 2 of
simd_data(desc).  For SVE, this bit remains zero.
For do_FMLAL_zzzw, this requires no change.
For do_FMLAL_zzxw, move the index up one bit.

Read fz16 directly from env->fpcr.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 2 +-
 target/arm/tcg/vec_helper.c    | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 87b6e4a88e..7f8ca78a91 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7168,7 +7168,7 @@ static bool do_FMLAL_zzxw(DisasContext *s, arg_rrxr_esz *a, bool sub, bool sel)
 {
     return gen_gvec_ptr_zzzz(s, gen_helper_sve2_fmlal_zzxw_s,
                              a->rd, a->rn, a->rm, a->ra,
-                             (a->index << 2) | (sel << 1) | sub, tcg_env);
+                             (a->index << 3) | (sel << 1) | sub, tcg_env);
 }
 
 TRANS_FEAT(FMLALB_zzxw, aa64_sve2, do_FMLAL_zzxw, a, false, false)
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 671777ce52..16ddd35239 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2191,7 +2191,8 @@ void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
     intptr_t i, oprsz = simd_oprsz(desc);
     bool is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
-    float_status *status = &env->vfp.fp_status[FPST_A64];
+    bool za = extract32(desc, SIMD_DATA_SHIFT + 2, 1);
+    float_status *status = &env->vfp.fp_status[za ? FPST_ZA : FPST_A64];
     bool fz16 = env->vfp.fpcr & FPCR_FZ16;
     int negx = 0, negf = 0;
 
@@ -2274,8 +2275,9 @@ void HELPER(sve2_fmlal_zzxw_s)(void *vd, void *vn, void *vm, void *va,
     intptr_t i, j, oprsz = simd_oprsz(desc);
     bool is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
-    intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 2, 3) * sizeof(float16);
-    float_status *status = &env->vfp.fp_status[FPST_A64];
+    bool za = extract32(desc, SIMD_DATA_SHIFT + 2, 1);
+    intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 3, 3) * sizeof(float16);
+    float_status *status = &env->vfp.fp_status[za ? FPST_ZA : FPST_A64];
     bool fz16 = env->vfp.fpcr & FPCR_FZ16;
     int negx = 0, negf = 0;
 
-- 
2.43.0


