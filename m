Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF7FC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pJu-0001JO-PW; Wed, 16 Sep 2026 09:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJo-00019A-MZ
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:57 -0400
Received: from mail-oo2-x2b.google.com ([2607:f8b0:4864:31::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJm-0000RF-Sr
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:56 -0400
Received: by mail-oo2-x2b.google.com with SMTP id
 006d021491bc7-6beed321ad9so621191eaf.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563894; x=1790168694; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gn2BVo8XsZoWSxJt8C4JLF74Lt5/vzi0qWbrkJFiwyQ=;
 b=V7AfblQfRDFq9jQvYLQNdqexzR7+ML+j0MU35PjJSp+aaT8b/1DAiMMyGGolSnhlF7
 AVsdqFkTTcISwbtx4pRfu2Ijfv/foBupp6aI9lLERX7SU/fGCptL7RJ+sxw1HrRjv4ng
 fggt4tBNMRPplzVyphRpSrYgE5TFmmYh216x7P8T80+vOT9lVqmQFxYvZfw5rf/h+Ed+
 8c7DxL7wOwuatbZSZTEU6l69U1UmItFKo10Czb1R8BklBZdL8/N+hEfit/7YoNCl9Ji1
 JvSy9qEJwG+Ypcz6CXeezW9SS8bZS0HFg5ugsmmol3SBQsZjgSC+TH8o37Errii6k1oG
 tqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563894; x=1790168694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gn2BVo8XsZoWSxJt8C4JLF74Lt5/vzi0qWbrkJFiwyQ=;
 b=QHdmA98O7gRLZXK4ruILgCkqMI8XwpCWJVylHH3EHDuGAucW6gBQhc+9EkM7WxR7X8
 42zrSQYqZ0QMRk7fMFvnftt7i9PirSPb/XGWOIONd+UxOQFuhZtBVyGC7BiqcAX9GqyN
 EIjz5PHh7iXB4aNGVWQ962m9SDYsFHyX6AHSaoNfVx2X/dhIhe+ycaFbqIIIwOX0uKfF
 hOlSQWAj/W476hKgo4gj6mxigPiArtoxoZBLtWLWxZJyC2VG3zdaci24fThrbl37meFz
 MYeVnu6DYUyVoeEMJKqMkECWEikBJdF9YquSYpT6cSBnLbyShEvGbnzHi8sA66NmDEOZ
 W7NQ==
X-Gm-Message-State: AFuF++kkpN63oUcSt1+xnc9WdLGr99VVpUCaIt/GfEXR7ESpHqCEMEkE
 F6+MCrVUoOVjdR95r8/fZcRzdYrwvX6gKB4ViFrCmWoOG7CRigSS2SZdN164vOWKanukhNLNsoY
 mWGyGK8c=
X-Gm-Gg: AYBFou13vTZ2tMprmYslJzqntlkMr1ZnL/Pjby64eZ10h5Ck1xhKxBve2E5E0QJ889M
 iJj7TBNP2fwarXTlZcPA+Q3P5XMFMAAUic7L2yvxgrW+K899yo7vaOcTP+0uuGpp2wbDi5HNvYq
 5g2fAozeLOi4zEbDVFEF7qE6XzxWMPIEwuhvPdnjT4TbxeooPtpOCfCaxClJf28OwmHuJLyRVSC
 31co6M11uLJMQ8EpeN6QnBt2rQY3qg0IpeZmdX0KxWT74DIc0rIE3yMX6XJDz81+fNgaicQX89/
 YhdFV+Gqx2lCvhmK7rLyQzd2aYouRovk1teITAWEw3LM6J5jqPkEK8uFiVMvNLTz6tGm8OSsYy0
 97p4vPGVih8ZCM7dCs8oGVro20W8GgsRXe0UaYwqPa38UqYC8nH1bXY4rf4uXFo3CHshpYaj0Nm
 3liqW3wKxTkFG4wHDHi6uLTPQbqMW3yzMILrbMRSPBbGWIhIE8b7J8MwtLi1OlfOVF4vpjls94j
 8vZpNU=
X-Received: by 2002:a05:6820:820:b0:6b7:46fa:16a7 with SMTP id
 006d021491bc7-6c7d4cf4cd5mr2324095eaf.60.1789563893582; 
 Wed, 16 Sep 2026 06:04:53 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.04.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:04:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 24/92] tcg: Generic expansion of tcg_gen_sari_*
Date: Wed, 16 Sep 2026 03:02:59 -1000
Message-ID: <20260916130409.3382710-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index e8ed65d8c15..60c74688b8e 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -126,7 +126,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
-void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -215,7 +214,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
-void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index b95e51a07dc..bfd2cd4b9c8 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -10,6 +10,7 @@ DEF3(mul, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
+DEF3(sari, TCGV, TCGV, TINT)
 DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 99b56361558..aabccf49a81 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -453,6 +453,16 @@ static void gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
 }
 
+static void gen_sari(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    tcg_debug_assert(src2 >= 0 && src2 < tcg_type_size(type) * 8);
+    if (src2 == 0) {
+        gen_mov(type, dst, src1);
+    } else {
+        gen_sar(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 static void gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
@@ -574,16 +584,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else {
-        tcg_gen_sar_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_brcond_i32(TCGCond cond, TCGv_i32 arg1, TCGv_i32 arg2, TCGLabel *l)
 {
     if (cond == TCG_COND_ALWAYS) {
@@ -1583,16 +1583,6 @@ void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     }
 }
 
-void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else {
-        tcg_gen_sar_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_brcond_i64(TCGCond cond, TCGv_i64 arg1, TCGv_i64 arg2, TCGLabel *l)
 {
     if (cond == TCG_COND_ALWAYS) {
-- 
2.53.0


