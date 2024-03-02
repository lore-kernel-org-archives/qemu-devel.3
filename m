Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BFFC54798
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHjR-0002P7-Kd; Sat, 02 Mar 2024 00:16:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjN-0002Lh-33
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:17 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjK-0007UM-Gq
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:16 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6e58a984ea1so2075844b3a.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356573; x=1709961373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nn5GDQ2edJRZsgPi611vkmSc2f1OhhpZtbh88+pU1qY=;
 b=SCdTC3XQBiG9/tCT8Hpcv2/kPyMptaY3gd/f2eUXTFZHXmdKfaQoaxDrjuiA/tDqhv
 gaQ0MVmVg25rDdSI4tyqrcEljLuHAE0zTG51UiVFVap3yIJaLX7muRYcStjM6CPzSIE8
 vPIFYoucYoDC8s1127wnQY549f0dZtgfjnqGnArOhD0S7ZRYdW3DScKgb7O6XjW7TZKy
 SpcwwdRFigGMXAP+jQSwKsKnxdtPfntGWBfvktTUHo9bQ9SdeqHPup31iY6lFfijfN9W
 kMSu6P5+ffvoTeolUHNbw0Bl6B2K2iv4f0w+brH6ZQMHIxaN+th6DX7lrTkNbiEFoua0
 Eeqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356573; x=1709961373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nn5GDQ2edJRZsgPi611vkmSc2f1OhhpZtbh88+pU1qY=;
 b=MgR/PGkHCvh3zzWArmH2cJ3lM4r17F4XA/T+w5rtxHz0uS7Z5e2TRSbY4IsOh8xWiT
 9aTp3mCzCp4ATAABNH6ye+BLTFfd823SHEozl4Pex0SwhTtjxNQSZGqqxRMeU4suo6nd
 w5TMvd8thzqwoVddIRO2XzPdMFBgXoxUxG0/rkUXt8wew9CmMa+nsswJLqQr4BWsYcdX
 dYJBUBIyblKmFEjKBHGwXjfMpi58fE38WKxWDv8E2F98tyoXQPv4X1QXsrnXVqxhNd0k
 UxN3CpZJhrSZj3kaN5x3xkBYFUnExM6gWCwmV5459/wHYrx75DkyHhsqXnNEcZ3kjyBo
 gfxQ==
X-Gm-Message-State: AOJu0YznZlpcElgnlxbHM2mTpcsp0De/ccygsxfNZI0qXUly8F6I5GQi
 rCJFin2gAivJEmi9aYVXoGsdwCVuJaXIeHO898OZn2b185Ks/xaDuKEhQHNQ1hI6yKBeZKQQ/Vi
 n
X-Google-Smtp-Source: AGHT+IHwGoYOzUVV/Yohj9QG22j+m+PE4JVMv9KjPML9K9qmFMkrdAgsEgvaVMu8JSrTy8Q8QpB1oA==
X-Received: by 2002:a05:6a21:78a7:b0:1a1:3fd9:e531 with SMTP id
 bf39-20020a056a2178a700b001a13fd9e531mr2659872pzc.4.1709356573277; 
 Fri, 01 Mar 2024 21:16:13 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 05/41] target/sparc: Fix FMULD8*X16
Date: Fri,  1 Mar 2024 19:15:25 -1000
Message-Id: <20240302051601.53649-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Not only do these instructions have f32 inputs, they also do not
perform rounding.  Since these are relatively simple, implement
them properly inline.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h     |  2 --
 target/sparc/translate.c  | 48 +++++++++++++++++++++++++++++++++++----
 target/sparc/vis_helper.c | 46 -------------------------------------
 3 files changed, 44 insertions(+), 52 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 9e0b8b463e..39ea8f9baf 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -96,8 +96,6 @@ DEF_HELPER_FLAGS_2(fmul8x16, TCG_CALL_NO_RWG_SE, i64, i32, i64)
 DEF_HELPER_FLAGS_2(fmul8x16a, TCG_CALL_NO_RWG_SE, i64, i32, s32)
 DEF_HELPER_FLAGS_2(fmul8sux16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmul8ulx16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(fmuld8sux16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(fmuld8ulx16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_1(fexpand, TCG_CALL_NO_RWG_SE, i64, i32)
 DEF_HELPER_FLAGS_3(pdist, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fpack16, TCG_CALL_NO_RWG_SE, i32, i64, i64)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 598cfcf0ac..edb97bc64e 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -74,8 +74,6 @@
 # define gen_helper_fmul8sux16           ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fmul8ulx16           ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fmul8x16             ({ qemu_build_not_reached(); NULL; })
-# define gen_helper_fmuld8sux16          ({ qemu_build_not_reached(); NULL; })
-# define gen_helper_fmuld8ulx16          ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fpmerge              ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fqtox                ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fstox                ({ qemu_build_not_reached(); NULL; })
@@ -730,6 +728,48 @@ static void gen_op_fmul8x16au(TCGv_i64 dst, TCGv_i32 src1, TCGv_i32 src2)
     gen_helper_fmul8x16a(dst, src1, src2);
 }
 
+static void gen_op_fmuld8ulx16(TCGv_i64 dst, TCGv_i32 src1, TCGv_i32 src2)
+{
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    TCGv_i32 t2 = tcg_temp_new_i32();
+
+    tcg_gen_ext8u_i32(t0, src1);
+    tcg_gen_ext16s_i32(t1, src2);
+    tcg_gen_mul_i32(t0, t0, t1);
+
+    tcg_gen_extract_i32(t1, src1, 16, 8);
+    tcg_gen_sextract_i32(t2, src2, 16, 16);
+    tcg_gen_mul_i32(t1, t1, t2);
+
+    tcg_gen_concat_i32_i64(dst, t0, t1);
+}
+
+static void gen_op_fmuld8sux16(TCGv_i64 dst, TCGv_i32 src1, TCGv_i32 src2)
+{
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    TCGv_i32 t2 = tcg_temp_new_i32();
+
+    /*
+     * The insn description talks about extracting the upper 8 bits
+     * of the signed 16-bit input rs1, performing the multiply, then
+     * shifting left by 8 bits.  Instead, zap the lower 8 bits of
+     * the rs1 input, which avoids the need for two shifts.
+     */
+    tcg_gen_ext16s_i32(t0, src1);
+    tcg_gen_andi_i32(t0, t0, ~0xff);
+    tcg_gen_ext16s_i32(t1, src2);
+    tcg_gen_mul_i32(t0, t0, t1);
+
+    tcg_gen_sextract_i32(t1, src1, 16, 16);
+    tcg_gen_andi_i32(t1, t1, ~0xff);
+    tcg_gen_sextract_i32(t2, src2, 16, 16);
+    tcg_gen_mul_i32(t1, t1, t2);
+
+    tcg_gen_concat_i32_i64(dst, t0, t1);
+}
+
 static void finishing_insn(DisasContext *dc)
 {
     /*
@@ -4570,6 +4610,8 @@ static bool do_dff(DisasContext *dc, arg_r_r_r *a,
 
 TRANS(FMUL8x16AU, VIS1, do_dff, a, gen_op_fmul8x16au)
 TRANS(FMUL8x16AL, VIS1, do_dff, a, gen_op_fmul8x16al)
+TRANS(FMULD8SUx16, VIS1, do_dff, a, gen_op_fmuld8sux16)
+TRANS(FMULD8ULx16, VIS1, do_dff, a, gen_op_fmuld8ulx16)
 
 static bool do_dfd(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i64, TCGv_i32, TCGv_i64))
@@ -4610,8 +4652,6 @@ static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
 
 TRANS(FMUL8SUx16, VIS1, do_ddd, a, gen_helper_fmul8sux16)
 TRANS(FMUL8ULx16, VIS1, do_ddd, a, gen_helper_fmul8ulx16)
-TRANS(FMULD8SUx16, VIS1, do_ddd, a, gen_helper_fmuld8sux16)
-TRANS(FMULD8ULx16, VIS1, do_ddd, a, gen_helper_fmuld8ulx16)
 TRANS(FPMERGE, VIS1, do_ddd, a, gen_helper_fpmerge)
 
 TRANS(FPADD16, VIS1, do_ddd, a, tcg_gen_vec_add16_i64)
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index 5c7f5536bc..eb1c4e47e9 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -192,52 +192,6 @@ uint64_t helper_fmul8ulx16(uint64_t src1, uint64_t src2)
     return d.ll;
 }
 
-uint64_t helper_fmuld8sux16(uint64_t src1, uint64_t src2)
-{
-    VIS64 s, d;
-    uint32_t tmp;
-
-    s.ll = src1;
-    d.ll = src2;
-
-#define PMUL(r)                                                         \
-    tmp = (int32_t)d.VIS_SW64(r) * ((int32_t)s.VIS_SW64(r) >> 8);       \
-    if ((tmp & 0xff) > 0x7f) {                                          \
-        tmp += 0x100;                                                   \
-    }                                                                   \
-    d.VIS_L64(r) = tmp;
-
-    /* Reverse calculation order to handle overlap */
-    PMUL(1);
-    PMUL(0);
-#undef PMUL
-
-    return d.ll;
-}
-
-uint64_t helper_fmuld8ulx16(uint64_t src1, uint64_t src2)
-{
-    VIS64 s, d;
-    uint32_t tmp;
-
-    s.ll = src1;
-    d.ll = src2;
-
-#define PMUL(r)                                                         \
-    tmp = (int32_t)d.VIS_SW64(r) * ((uint32_t)s.VIS_B64(r * 2));        \
-    if ((tmp & 0xff) > 0x7f) {                                          \
-        tmp += 0x100;                                                   \
-    }                                                                   \
-    d.VIS_L64(r) = tmp;
-
-    /* Reverse calculation order to handle overlap */
-    PMUL(1);
-    PMUL(0);
-#undef PMUL
-
-    return d.ll;
-}
-
 uint64_t helper_fexpand(uint32_t src2)
 {
     VIS32 s;
-- 
2.34.1


