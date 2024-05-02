Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD7FC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 16:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Zit-0001I7-Nn; Thu, 02 May 2024 12:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2Zic-0000vm-CV
 for qemu-devel@nongnu.org; Thu, 02 May 2024 12:55:43 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s2ZiZ-0005vP-29
 for qemu-devel@nongnu.org; Thu, 02 May 2024 12:55:38 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6f44390e328so498976b3a.2
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 09:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714668931; x=1715273731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8A5wkA/c/fe0SRhmGznAw+eONAU2pb4TUE7cdCXudPo=;
 b=v3+ZK/54YG6Jd5vJrBduSHUysIFBOk5xhJ/K+gchCqmbxsFOzxAnw296WazM72Qnkw
 pNhGYwFtj/fF/r+/O9IjHsKs6/3xsPqLdoye23Z0mzBORkP8hufaHu4S4UVu7y+DhRLl
 LLgXzRHQqY6cyZULTK6XZ6TdyFL7gWFIHzh92gmI0D1XgXworMOCB/U1OSYJKZDYTdd3
 KyoVFJhzStyVlFV0Z+xEKC+JugUvAihaeilCrnCsH5u1tp7wxwnZ3JxXTQkyAf8pyHYz
 8lNq5yZC62YqI0KHLE7gFeQ4aXsiOZ9wImHyLnN6KqwtXRRdEy0NEf2WTVDpGLAq/SuH
 8cdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714668931; x=1715273731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8A5wkA/c/fe0SRhmGznAw+eONAU2pb4TUE7cdCXudPo=;
 b=Gbnp+/bTiloy2aJF3wPLDIhZjhRF4KPojkwbsRylsByPBCfWEtcfCWc1wxyGa6p5IZ
 prZIWgXlV0+RXLgr9nnnd82seF/4jwaSDzuuMYDTQyfx42op5rFgMoRN8rjddB58Ak8I
 B4iSHQyAyxfkmclZOnOmvEBuyS9tL/gBSnEONZpkzrYqaeKeeg95oF5gzioy2JsAx+ol
 Ifdt2IpNTu7U2vuBO3anJl1LKr/xv0f3L4Frgue90hFmMUAgKFAVKsJuB9gFj9YFGrUo
 nGMDXmcKIrfuLe656pwV8Bv2Ou4v/d0q0ab6/6MP5n1+NEFikfYI6YLleHE7/04N1knD
 Uy6g==
X-Gm-Message-State: AOJu0Yx5COxFPVhvrM2QpCXTU4KqHQyFT10o2JCrEV0+A00AMHtXP7yq
 3DJElghrZYjhrwLph65bq++iOO0kbBXgWJaAhzuvWdJvGiTdXHZLi/GsVMdyHIG4eOvg0O5s40j
 s
X-Google-Smtp-Source: AGHT+IFTIH80yQSjLPgCJ3vMo1peDKypMpAAZgYbwM+rH7x25UD/hb0RvFSSvmBl1OGLWliBGiWv2w==
X-Received: by 2002:a05:6a00:9a5:b0:6ed:cd4c:cc1a with SMTP id
 u37-20020a056a0009a500b006edcd4ccc1amr134583pfg.8.1714668931460; 
 Thu, 02 May 2024 09:55:31 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 j13-20020aa783cd000000b006eb058b2703sm1464598pfn.187.2024.05.02.09.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 09:55:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 2/7] target/sparc: Fix FEXPAND
Date: Thu,  2 May 2024 09:55:23 -0700
Message-Id: <20240502165528.244004-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502165528.244004-1-richard.henderson@linaro.org>
References: <20240502165528.244004-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

This is a 2-operand instruction, not 3-operand.
Worse, we took the source from the wrong operand.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/helper.h     |  2 +-
 target/sparc/insns.decode |  2 +-
 target/sparc/translate.c  | 20 +++++++++++++++++++-
 target/sparc/vis_helper.c |  6 +++---
 4 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index b8087d0d2b..57ab755ffd 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -102,7 +102,7 @@ DEF_HELPER_FLAGS_2(fmul8sux16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmul8ulx16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmuld8sux16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fmuld8ulx16, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(fexpand, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_1(fexpand, TCG_CALL_NO_RWG_SE, i64, i32)
 DEF_HELPER_FLAGS_3(pdist, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
 DEF_HELPER_FLAGS_2(fpack16, TCG_CALL_NO_RWG_SE, i32, i64, i64)
 DEF_HELPER_FLAGS_3(fpack32, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
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
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 571b3e3f03..dfcfe855a1 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4358,6 +4358,25 @@ TRANS(FSQRTd, ALL, do_env_dd, a, gen_helper_fsqrtd)
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
@@ -4589,7 +4608,6 @@ TRANS(FMUL8ULx16, VIS1, do_ddd, a, gen_helper_fmul8ulx16)
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
-- 
2.34.1


