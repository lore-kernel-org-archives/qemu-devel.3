Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBAAC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 16:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Ziu-0001K8-4v; Thu, 02 May 2024 12:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2Zic-0000wm-Mc
 for qemu-devel@nongnu.org; Thu, 02 May 2024 12:55:43 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2ZiZ-0005vo-J0
 for qemu-devel@nongnu.org; Thu, 02 May 2024 12:55:38 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6f0aeee172dso1528844b3a.1
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 09:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714668934; x=1715273734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yEdMLu3Ijs29bOc2sbKAHOskO1hQNx6lqTdpxrxbtzI=;
 b=u5caEhtO6eV//YXuIQyeqLevrhBIxCnclRJ5Sox1G8yp1xZwcp4Z/UtNDrLowVygPB
 j+snj21CxJmR3/u40J2vk1VsK3q/0RkoNja9vyYTt0TUYPpToYiV9o0up9Z14ItPOqDI
 hNGAIqXdfR5/bx1aMuftq59awiOXt2iAi7f/5glbMzKfnMI3+ntQma6bTtFsXfwQEquC
 SpeQG3a/vCJG1mPoVOmwTNXk6+/jMEW1Tz82jgWzjWfjenNzePlBRGaE/f4imdcEeufl
 RFfP7o2I46uy7dUzQForWwem84VCEtFQkBgexeMdusfwb3pCr4EnvivKF93xOva0C1na
 JKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714668934; x=1715273734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yEdMLu3Ijs29bOc2sbKAHOskO1hQNx6lqTdpxrxbtzI=;
 b=shzsV5H5Mf90RpUYPtlR+9YenDP5Fevs/7Mbjzyp6o6efIID92sbYTnCluwTpgjFmf
 S443ZphspXs7aOuN8w0Pg/7IDY9gRBZidk2D3Wi9V/KfR4vFNxeIeHt8YLf6ABFzSD4N
 oOeKkuNDzYqO9sM4D0vaH6YyeZqHf3Nn8IgP/c4qGxCEH53bU93ub02xgxPjerFNQdir
 9Qpc7OkxbqeNVkW7EDecjv6vlQZziw6k1tBPMltmFLkS8UXzY9UPBU79defg4qlbEOXj
 cgviJV1a+zfY85yiYGibmkGkvd1mmo1KbCtlBocGBk3Xdn6pCrdnKubQi7ZJsVI/loKo
 M93g==
X-Gm-Message-State: AOJu0YxMzvv0U+lM38biSnw+pG3uMzsbwUKs6akyoMO8dYkRvIXFzwc5
 q8rfMIdb8hkZ3j6O7WtnldC6rOtwRI9TPZXLfqYF+YcB2ML/uhCnVjGFd18LiGk/eHgqNMYL8Sx
 V
X-Google-Smtp-Source: AGHT+IFGKj4c0Ucmzt08e3Mk+n9Iq2YZUrxhPi6+Y+Qley+PRWzdd7i4QeNyso/80U/CmRZBMxOaXg==
X-Received: by 2002:a05:6a00:92a5:b0:6f3:8468:8bb with SMTP id
 jw37-20020a056a0092a500b006f3846808bbmr390342pfb.17.1714668933080; 
 Thu, 02 May 2024 09:55:33 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 j13-20020aa783cd000000b006eb058b2703sm1464598pfn.187.2024.05.02.09.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 09:55:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 4/7] target/sparc: Fix FMUL8x16A{U,L}
Date: Thu,  2 May 2024 09:55:25 -0700
Message-Id: <20240502165528.244004-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502165528.244004-1-richard.henderson@linaro.org>
References: <20240502165528.244004-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

These instructions have f32 inputs, which changes the decode
of the register numbers.  While we're fixing things, use a
common helper for both insns, extracting the 16-bit scalar
in tcg beforehand.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h     |  3 +--
 target/sparc/translate.c  | 38 +++++++++++++++++++++++++++----
 target/sparc/vis_helper.c | 47 +++++++++++----------------------------
 3 files changed, 48 insertions(+), 40 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index 27dc604cac..9cde2b69a5 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -96,8 +96,7 @@ DEF_HELPER_FLAGS_2(fqtox, TCG_CALL_NO_WG, s64, env, i128)
 
 DEF_HELPER_FLAGS_2(fpmerge, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmul8x16, TCG_CALL_NO_RWG_SE, i64, i32, i64)
-DEF_HELPER_FLAGS_2(fmul8x16al, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(fmul8x16au, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(fmul8x16a, TCG_CALL_NO_RWG_SE, i64, i32, s32)
 DEF_HELPER_FLAGS_2(fmul8sux16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmul8ulx16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmuld8sux16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index c4adc148d2..a8ada6934a 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -45,6 +45,7 @@
 # define gen_helper_clear_softint(E, S)         qemu_build_not_reached()
 # define gen_helper_done(E)                     qemu_build_not_reached()
 # define gen_helper_flushw(E)                   qemu_build_not_reached()
+# define gen_helper_fmul8x16a(D, S1, S2)        qemu_build_not_reached()
 # define gen_helper_rdccr(D, E)                 qemu_build_not_reached()
 # define gen_helper_rdcwp(D, E)                 qemu_build_not_reached()
 # define gen_helper_restored(E)                 qemu_build_not_reached()
@@ -72,8 +73,6 @@
 # define gen_helper_fexpand              ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fmul8sux16           ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fmul8ulx16           ({ qemu_build_not_reached(); NULL; })
-# define gen_helper_fmul8x16al           ({ qemu_build_not_reached(); NULL; })
-# define gen_helper_fmul8x16au           ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fmul8x16             ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fmuld8sux16          ({ qemu_build_not_reached(); NULL; })
 # define gen_helper_fmuld8ulx16          ({ qemu_build_not_reached(); NULL; })
@@ -719,6 +718,18 @@ static void gen_op_bshuffle(TCGv_i64 dst, TCGv_i64 src1, TCGv_i64 src2)
 #endif
 }
 
+static void gen_op_fmul8x16al(TCGv_i64 dst, TCGv_i32 src1, TCGv_i32 src2)
+{
+    tcg_gen_ext16s_i32(src2, src2);
+    gen_helper_fmul8x16a(dst, src1, src2);
+}
+
+static void gen_op_fmul8x16au(TCGv_i64 dst, TCGv_i32 src1, TCGv_i32 src2)
+{
+    tcg_gen_sari_i32(src2, src2, 16);
+    gen_helper_fmul8x16a(dst, src1, src2);
+}
+
 static void finishing_insn(DisasContext *dc)
 {
     /*
@@ -4583,6 +4594,27 @@ TRANS(FSUBs, ALL, do_env_fff, a, gen_helper_fsubs)
 TRANS(FMULs, ALL, do_env_fff, a, gen_helper_fmuls)
 TRANS(FDIVs, ALL, do_env_fff, a, gen_helper_fdivs)
 
+static bool do_dff(DisasContext *dc, arg_r_r_r *a,
+                   void (*func)(TCGv_i64, TCGv_i32, TCGv_i32))
+{
+    TCGv_i64 dst;
+    TCGv_i32 src1, src2;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    dst = gen_dest_fpr_D(dc, a->rd);
+    src1 = gen_load_fpr_F(dc, a->rs1);
+    src2 = gen_load_fpr_F(dc, a->rs2);
+    func(dst, src1, src2);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FMUL8x16AU, VIS1, do_dff, a, gen_op_fmul8x16au)
+TRANS(FMUL8x16AL, VIS1, do_dff, a, gen_op_fmul8x16al)
+
 static bool do_dfd(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i64, TCGv_i32, TCGv_i64))
 {
@@ -4620,8 +4652,6 @@ static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
     return advance_pc(dc);
 }
 
-TRANS(FMUL8x16AU, VIS1, do_ddd, a, gen_helper_fmul8x16au)
-TRANS(FMUL8x16AL, VIS1, do_ddd, a, gen_helper_fmul8x16al)
 TRANS(FMUL8SUx16, VIS1, do_ddd, a, gen_helper_fmul8sux16)
 TRANS(FMUL8ULx16, VIS1, do_ddd, a, gen_helper_fmul8ulx16)
 TRANS(FMULD8SUx16, VIS1, do_ddd, a, gen_helper_fmuld8sux16)
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index 7728ffe9c6..ff2f43c23f 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -119,44 +119,23 @@ uint64_t helper_fmul8x16(uint32_t src1, uint64_t src2)
     return d.ll;
 }
 
-uint64_t helper_fmul8x16al(uint64_t src1, uint64_t src2)
+uint64_t helper_fmul8x16a(uint32_t src1, int32_t src2)
 {
-    VIS64 s, d;
+    VIS32 s;
+    VIS64 d;
     uint32_t tmp;
 
-    s.ll = src1;
-    d.ll = src2;
+    s.l = src1;
+    d.ll = 0;
 
-#define PMUL(r)                                                 \
-    tmp = (int32_t)d.VIS_SW64(1) * (int32_t)s.VIS_B64(r);       \
-    if ((tmp & 0xff) > 0x7f) {                                  \
-        tmp += 0x100;                                           \
-    }                                                           \
-    d.VIS_W64(r) = tmp >> 8;
-
-    PMUL(0);
-    PMUL(1);
-    PMUL(2);
-    PMUL(3);
-#undef PMUL
-
-    return d.ll;
-}
-
-uint64_t helper_fmul8x16au(uint64_t src1, uint64_t src2)
-{
-    VIS64 s, d;
-    uint32_t tmp;
-
-    s.ll = src1;
-    d.ll = src2;
-
-#define PMUL(r)                                                 \
-    tmp = (int32_t)d.VIS_SW64(0) * (int32_t)s.VIS_B64(r);       \
-    if ((tmp & 0xff) > 0x7f) {                                  \
-        tmp += 0x100;                                           \
-    }                                                           \
-    d.VIS_W64(r) = tmp >> 8;
+#define PMUL(r)                                \
+    do {                                       \
+        tmp = src2 * (int32_t)s.VIS_B32(r);    \
+        if ((tmp & 0xff) > 0x7f) {             \
+            tmp += 0x100;                      \
+        }                                      \
+        d.VIS_W64(r) = tmp >> 8;               \
+    } while (0)
 
     PMUL(0);
     PMUL(1);
-- 
2.34.1


