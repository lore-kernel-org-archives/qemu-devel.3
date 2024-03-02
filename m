Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4973C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 05:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgHjS-0002PA-KB; Sat, 02 Mar 2024 00:16:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjP-0002OY-Sf
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:19 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgHjF-0007Tf-Dv
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 00:16:19 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5d4d15ec7c5so2468217a12.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 21:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709356568; x=1709961368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yuH2zSAfuVjEDd5KC+vHgGixxVmZT968m1jduIgoS7U=;
 b=gJpZw2xjnhj9UY+zUCLa/oyYcwLaV5U8rTy+NwZBgERZfdlSMgolvi5ciFc62Ktfp0
 qGXMKIofHS87fVTI4GT+PjrCbTgo9ruBKJtzxupmgwmHJLF9MpOrhooK0lJ0mHrFnhnU
 +n4xWJZ/+nKNop4jEOhK/Dmqckv0z+3oqUODK66/h2/L/4nQFWHO2r9Bk3uIcHA79Ixj
 qIl/KHa6xGzVOxRfpgRkk3KXnh1EZqByJPHMVoufWBZGHQTXUMVH2Wh/onv34NqLpSXv
 iiuMj2HhAM8DaumQpDaYYHSNAIErD7UQOkdoaQ2e1Ah6g3eHifQsUlJNckuJTs/Owl7u
 9wkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709356568; x=1709961368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yuH2zSAfuVjEDd5KC+vHgGixxVmZT968m1jduIgoS7U=;
 b=bnhar1u3C/J/euj3BAYf7GmFhbvzaQE9POJ8XrxTIMmDpgqHM65SbPoUVXFwx/+7sx
 j1zlYr0ffnWJw+P/DWlpOR3754EnOS+p/2V6TIKZtBcnzKTzokhDImpP7dmWNJTq7BK5
 yh+ScVG4H954HBB83v01h2fBsdIQnuesbkyoIXCbbFc37+s5a4GCyQYo26EwctoXwE9i
 rVCagqtIWDs/kCr9uDEXOZ/kNBABcedsZiPtKVn4IEZH5pT92wqyaHfWVIArWp1/vFMm
 kKU3au1OCQpdSjykMlCGWNOqeMySCnNTLuN9g8IoszcRY1Bo7y5sKAiQf9Hf/z6/Qa6m
 z+UA==
X-Gm-Message-State: AOJu0Yx8T3dLe4vFjk7gsPkpon73QGKmvaEqKbMX5bSx9Y2/6xNHCC+K
 a0NtZEAZAEo3L8EkxAGfW+4aacp7oZXpgqZVVEiNFYDsXxoHpKle5WAjdnElommK2mqEsQLpUfK
 D
X-Google-Smtp-Source: AGHT+IFhVIKuapr3NfT4CMJ3U+vJEjHyb7f6vHC2VhRiO5mD5u0YwGyC0XIdIuHELubeiNqmw19rdQ==
X-Received: by 2002:a05:6a20:d818:b0:1a1:3d87:422d with SMTP id
 iv24-20020a056a20d81800b001a13d87422dmr3689365pzb.45.1709356567741; 
 Fri, 01 Mar 2024 21:16:07 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a17090a458800b0029af67d4fd0sm4034901pjg.44.2024.03.01.21.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 21:16:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 02/41] target/sparc: Fix FEXPAND
Date: Fri,  1 Mar 2024 19:15:22 -1000
Message-Id: <20240302051601.53649-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302051601.53649-1-richard.henderson@linaro.org>
References: <20240302051601.53649-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This is a 2-operand instruction, not 3-operand.
Worse, we took the source from the wrong operand.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h     |  2 +-
 target/sparc/translate.c  | 20 +++++++++++++++++++-
 target/sparc/vis_helper.c |  6 +++---
 target/sparc/insns.decode |  2 +-
 4 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index e55fad5b8c..ef21ef49ef 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -99,7 +99,7 @@ DEF_HELPER_FLAGS_2(fmul8sux16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmul8ulx16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmuld8sux16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmuld8ulx16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(fexpand, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_1(fexpand, TCG_CALL_NO_RWG_SE, i64, i32)
 DEF_HELPER_FLAGS_3(pdist, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fpack16, TCG_CALL_NO_RWG_SE, i32, i64, i64)
 DEF_HELPER_FLAGS_3(fpack32, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 692ce0b010..5016664869 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4314,6 +4314,25 @@ TRANS(FSQRTd, ALL, do_env_dd, a, gen_helper_fsqrtd)
 TRANS(FxTOd, 64, do_env_dd, a, gen_helper_fxtod)
 TRANS(FdTOx, 64, do_env_dd, a, gen_helper_fdtox)
 
+static bool do_df(DisasContext *dc, arg_r_r *a,
+                  void (*func)(TCGv_i64, TCGv_i32))
+{
+    TCGv_i64 dst;
+    TCGv_i32 src;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    dst = tcg_temp_new_i64();
+    src = gen_load_fpr_F(dc, a->rs);
+    func(dst, src);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FEXPAND, VIS1, do_df, a, gen_helper_fexpand)
+
 static bool do_env_df(DisasContext *dc, arg_r_r *a,
                       void (*func)(TCGv_i64, TCGv_env, TCGv_i32))
 {
@@ -4545,7 +4564,6 @@ TRANS(FMUL8ULx16, VIS1, do_ddd, a, gen_helper_fmul8ulx16)
 TRANS(FMULD8SUx16, VIS1, do_ddd, a, gen_helper_fmuld8sux16)
 TRANS(FMULD8ULx16, VIS1, do_ddd, a, gen_helper_fmuld8ulx16)
 TRANS(FPMERGE, VIS1, do_ddd, a, gen_helper_fpmerge)
-TRANS(FEXPAND, VIS1, do_ddd, a, gen_helper_fexpand)
 
 TRANS(FPADD16, VIS1, do_ddd, a, tcg_gen_vec_add16_i64)
 TRANS(FPADD32, VIS1, do_ddd, a, tcg_gen_vec_add32_i64)
diff --git a/target/sparc/vis_helper.c b/target/sparc/vis_helper.c
index 7763b16c24..db2e6dd6c1 100644
--- a/target/sparc/vis_helper.c
+++ b/target/sparc/vis_helper.c
@@ -260,13 +260,13 @@ uint64_t helper_fmuld8ulx16(uint64_t src1, uint64_t src2)
     return d.ll;
 }
 
-uint64_t helper_fexpand(uint64_t src1, uint64_t src2)
+uint64_t helper_fexpand(uint32_t src2)
 {
     VIS32 s;
     VIS64 d;
 
-    s.l = (uint32_t)src1;
-    d.ll = src2;
+    s.l = src2;
+    d.ll = 0;
     d.VIS_W64(0) = s.VIS_B32(0) << 4;
     d.VIS_W64(1) = s.VIS_B32(1) << 4;
     d.VIS_W64(2) = s.VIS_B32(2) << 4;
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 2d26404cb2..e2d8a07dc4 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -352,7 +352,7 @@ FCMPEq      10 000 cc:2 110101 rs1:5  0 0101 0111 rs2:5
     FALIGNDATAg 10 ..... 110110 ..... 0 0100 1000 .....    @r_r_r
     FPMERGE     10 ..... 110110 ..... 0 0100 1011 .....    @r_r_r
     BSHUFFLE    10 ..... 110110 ..... 0 0100 1100 .....    @r_r_r
-    FEXPAND     10 ..... 110110 ..... 0 0100 1101 .....    @r_r_r
+    FEXPAND     10 ..... 110110 00000 0 0100 1101 .....    @r_r2
 
     FSRCd       10 ..... 110110 ..... 0 0111 0100 00000    @r_r1  # FSRC1d
     FSRCs       10 ..... 110110 ..... 0 0111 0101 00000    @r_r1  # FSRC1s
-- 
2.34.1


