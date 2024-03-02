Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2713FC54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHjO-0002OD-N1; Sat, 02 Mar 2024 00:16:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjN-0002Lf-2c
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:17 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjI-0007Ts-Qb
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:15 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5e152c757a5so1987938a12.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356571; x=1709961371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WAjdnf4F1BQaB8ZETOaZXvMHqeLzkYIxxnKbKFG5YO0=;
 b=v0UNDtWZxKg/5cUFwnQKcTy67Elbhdm7epfeefPAoJsg9m97ESgh7m6XfIXTwtUS2t
 pOtHptszSmGESjXBGxdm1R8wUAT/EZEJ/IZF0Qbb3tMJCewBgdbm01inOIIOvZQ8/3R+
 rOneEw+BPldvOxKfrfRGBL8SPI6Qzd3+9ziaem541CjOTl6F7XE6Iu8Rp2LVqBzGgqaB
 nGZ3BIFrXQcnBI0EWvQmDyOiQyBgmvD7PVLMZFnf/XdNFCiEVwwv6zOetXAvK8/0biz7
 fM+M2sZA5E9IGVG8wxvzoxew5/+XAwTDiN3hec6bMQgL9EVA2Fbzm8s7SVll1WsXlnBe
 ZvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356571; x=1709961371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WAjdnf4F1BQaB8ZETOaZXvMHqeLzkYIxxnKbKFG5YO0=;
 b=wWRqqstp+C9pc9pDHXG4I/ZABWbE1F+2UmMMEZlMwTOoYvbaf0eEz7PfYRX47xAGpR
 CQxC5jfgvqhzQSKSSxLK/rHtCf+1H4NROoRi5BdIALv/ZWo/J7dAJEpOu2rNN+fFPj85
 URnCeawgzeegVfQBWjb15CLIyhVjiIZRZM5+QyHAMxpRSIRHZcgF7g4Nn/zPklt4bETu
 /0Hnxse/9V/dJK907htM3VCtI3u4ZqqRBhVfhzrQ16FrbqUE+NeQQmXAnKM4pPeOPHRq
 kK9L2cvmCp5u9N0nnzG6DnRL5bSOtqz8iYiUW8FckZZEQXTM+7tg96Kq8lVSHoQOCgy5
 ijPQ==
X-Gm-Message-State: AOJu0YzWI4x3NYX5sESZo6H+Oro7d8sQeeWTSKsR/okxV/DH4JeV+OL3
 WIG1OczsLtsF4JrLLoHssZl66b67a5xzIBO0YJdIWddnpRKgc3oVwSY/FoRof513Vnjm7BinQo3
 5
X-Google-Smtp-Source: AGHT+IGfPc8d/PH8TgwIXWYmJA9kZsVYPYyyeEKYIqAN+8Csr6x6sB208BEBljdiyuBR17AeTY83ww==
X-Received: by 2002:a17:90b:b04:b0:29a:c89a:bcdb with SMTP id
 bf4-20020a17090b0b0400b0029ac89abcdbmr2868816pjb.46.1709356571446; 
 Fri, 01 Mar 2024 21:16:11 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 04/41] target/sparc: Fix FMUL8x16A{U,L}
Date: Fri,  1 Mar 2024 19:15:24 -1000
Message-Id: <20240302051601.53649-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

These instructions have f32 inputs, which changes the decode
of the register numbers.  While we're fixing things, use a
common helper for both insns, extracting the 16-bit scalar
in tcg beforehand.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h     |  3 +--
 target/sparc/translate.c  | 38 ++++++++++++++++++++++++++++++----
 target/sparc/vis_helper.c | 43 +++++++++------------------------------
 3 files changed, 45 insertions(+), 39 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index adc1b87319..9e0b8b463e 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -93,8 +93,7 @@ DEF_HELPER_FLAGS_2(fqtox, TCG_CALL_NO_WG, s64, env, i128)
 
 DEF_HELPER_FLAGS_2(fpmerge, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmul8x16, TCG_CALL_NO_RWG_SE, i64, i32, i64)
-DEF_HELPER_FLAGS_2(fmul8x16al, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(fmul8x16au, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_2(fmul8x16a, TCG_CALL_NO_RWG_SE, i64, i32, s32)
 DEF_HELPER_FLAGS_2(fmul8sux16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmul8ulx16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmuld8sux16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 5144fe4ed9..598cfcf0ac 100644
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
@@ -4539,6 +4550,27 @@ TRANS(FSUBs, ALL, do_env_fff, a, gen_helper_fsubs)
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
@@ -4576,8 +4608,6 @@ static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
     return advance_pc(dc);
 }
 
-TRANS(FMUL8x16AU, VIS1, do_ddd, a, gen_helper_fmul8x16au)
-TRANS(FMUL8x16AL, VIS1, do_ddd, a, gen_helper_fmul8x16al)
 TRANS(FMUL8SUx16, VIS1, do_ddd, a, gen_helper_fmul8sux16)
 TRANS(FMUL8ULx16, VIS1, do_ddd, a, gen_helper_fmul8ulx16)
 TRANS(FMULD8SUx16, VIS1, do_ddd, a, gen_helper_fmuld8sux16)
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index 7728ffe9c6..5c7f5536bc 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -119,43 +119,20 @@ uint64_t helper_fmul8x16(uint32_t src1, uint64_t src2)
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
+#define PMUL(r)                                \
+    tmp = src2 * (int32_t)s.VIS_B64(r);        \
+    if ((tmp & 0xff) > 0x7f) {                 \
+        tmp += 0x100;                          \
+    }                                          \
     d.VIS_W64(r) = tmp >> 8;
 
     PMUL(0);
-- 
2.34.1


