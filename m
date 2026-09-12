Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F501C79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L5J-0002Ev-ME; Sat, 12 Sep 2026 06:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4x-0008Tc-07
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:27 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4r-0008LR-3h
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:24 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-cc4902427c1so1483145a12.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209320; x=1789814120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=slUyzfPdrsEA3V/t4oNAiOrzqviJB4jkK8/iIslDjbc=;
 b=Db6Bi2zM1KwNbFnGufalMOmdLbYrD1V6iRaUvMIhDvbits9lUMuizRlbYWL+zLfUhq
 xmHdOjhHyjHQGBOpvCsEStvvdwzcvjGHZj7LNYNalVXilbXTu3V3BRsIgAO/G74QxAse
 8AY3XD9hwoGRmmMT0S0vnxcpTJdLwHMUil+cJW/dqtjqaDFaBunJ9swaRu466ZPhvbdo
 5BBu0jvbR3QucZfgM2c7td6796UUidG9/vQ2/A02pnY2A8ASVVfrkTsWH8Affq1dwPpJ
 1zCnNq3+OEWXsAJcxIwPwxThTnxsJWKoDPEi1ad4ykgWFa28Vi4N1IPdiWJWyT2s+cn6
 FvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209320; x=1789814120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=slUyzfPdrsEA3V/t4oNAiOrzqviJB4jkK8/iIslDjbc=;
 b=gcMRLWAYdYWuN58NNPyW2PQQJZ/YjRGL3lt1o2EDisA4L79ztbE1wzneXqjSLz0nAE
 Pp+xZtXPQNsfsHyIVmwiYfUTKKyYyMFvFDyLlPILEk7GUwnVhCNg33FBUn+8Nr0kgLD0
 I7sjJKujcLgk6Fn+1Z+iiGT7xt+E9ds7rm4NVYEVGGnMvhZsCP8Tj9YIlWhuVe/mIusv
 QKMLmCIzoFfs/lbmxSauPWBr7jhYUMTPdwhZO3GyMlpXDriS/DXwvvCLYt+ObOU13SVS
 +q349uDujc8Uqn9HZG/tpHEznhNPMYsnQDlYmuIunl0vUPWvs0ir3w/kXMtMK9GuqTD6
 CVzQ==
X-Gm-Message-State: AFuF++nLz0R2aKlat5vptDzdmhj4AWeISjsn6a7Zf7fkBicZvzj0NSZ3
 ogT4i6b8v0cpLAoHS+a/czvTSmc9uxjTYx2VgnCJ1ouQ9o1sl3Qe+xxA1nvHPT1MuCx7OBfMBoQ
 2V3u0pA0=
X-Gm-Gg: AYBFou2r68csuwOrOsPIjb4WE35zBGhBuLF59DuRZAWWSmAhH8cWK1hq+yMNpKtV463
 4dQOYHit+7U7/DpzAzezvxKoTqcp1clzyqG6VrHUj/kC97sNZkfFgZ+nL+jsXSmBLdr/6FPSyYn
 iQ/ZuykyBmdT/ONrKs7Jr5K0iur5bHVW1I44RshAMPovJLBAQCfkW9mtK4MOr0MdMV/9ldSiYln
 0oZOclqKU7e7Llyh+WQ/3yZVZZrdzZGeS8p5VhiRgyKqLZY+sCGjsGzwraS0abZwAYuHuNG3nbp
 u4WMjgQ49LqY9ys3J6A8RDtD87ZH5uBAHuuIR4aRsJM5Hni4FucQS224BATt11XgNnD7aSmSVK3
 IbKIecNP+PcaPbr8qPo1Uz2eql7skjISRsJcZYLHmA1ig+WmFUEEwx5h7Ibfvx75SubeWNrJAGI
 N9vcKUGF5vuzkLzafvMT2gGd4N59iV+fSlo6PrZeAMleiQXz2vaxQYpFjAvFawBIhK6KFvIp+C3
 QuItya2hoo+kLYpog==
X-Received: by 2002:a05:6a21:4d92:b0:3db:887:7868 with SMTP id
 adf61e73a8af0-3db08878495mr3736576637.15.1789209319516; 
 Sat, 12 Sep 2026 03:35:19 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 52/82] tcg: Generic expansion of tcg_gen_ctz_*
Date: Sat, 12 Sep 2026 00:30:56 -1000
Message-ID: <20260912103126.598030-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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
 include/tcg/tcg-op-common.h   |   2 -
 include/tcg/tcg-op-def2.h.inc |   1 +
 tcg/tcg-op.c                  | 117 ++++++++++++++--------------------
 3 files changed, 49 insertions(+), 71 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 802d7c8352a..2a860d7a6c2 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -142,7 +142,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -200,7 +199,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 4497f2b6927..d0b1141dc10 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -28,6 +28,7 @@ DEF_RRR(add)
 DEF_RRR(and)
 DEF_RRR(andc)
 DEF_RRR(clz)
+DEF_RRR(ctz)
 DEF_RRR(div)
 DEF_RRR(divu)
 DEF_RRR(eqv)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 2be51a5762a..a33def70cad 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -499,6 +499,54 @@ static void gen_ctpop(TCGType type, TCGTemp *dst, TCGTemp *src)
     }
 }
 
+static void gen_ctz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    TCGTemp *t1, *t2;
+
+    if (tcg_op_supported(INDEX_op_ctz, type, 0)) {
+        gen_op_ttt(INDEX_op_ctz, type, dst, src1, src2);
+        return;
+    }
+    if (tcg_op_supported(INDEX_op_ctpop, type, 0)) {
+        t1 = tcg_temp_new_internal(type, TEMP_EBB);
+        gen_addi(type, t1, src1, -1);
+        gen_andc(type, t1, t1, src1);
+        gen_ctpop(type, t1, t1);
+    } else if (tcg_op_supported(INDEX_op_clz, type, 0)) {
+        int width = tcg_type_size(type) * 8;
+
+        t1 = tcg_temp_new_internal(type, TEMP_EBB);
+        gen_neg(type, t1, src1);
+        gen_and(type, t1, t1, src1);
+        gen_clzi(type, t1, t1, width);
+        gen_xori(type, t1, t1, width - 1);
+    } else if (type == TCG_TYPE_I64) {
+        gen_helper_ctz_i64(temp_tcgv_i64(dst), temp_tcgv_i64(src1),
+                           temp_tcgv_i64(src2));
+        return;
+    } else if (tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I64, 0) ||
+               tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0) ||
+               tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
+        t1 = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
+        t2 = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
+        gen_extu_i32_i64(t1, src1);
+        gen_extu_i32_i64(t2, src2);
+        gen_ctz(TCG_TYPE_I64, t1, t1, t2);
+        gen_extrl_i64_i32(dst, t1);
+        tcg_temp_free_internal(t1);
+        tcg_temp_free_internal(t2);
+        return;
+    } else {
+        gen_helper_ctz_i32(temp_tcgv_i32(dst), temp_tcgv_i32(src1),
+                           temp_tcgv_i32(src2));
+        return;
+    }
+
+    t2 = tcg_constant_internal(type, 0);
+    gen_movcond(type, TCG_COND_EQ, dst, src1, t2, src2, t1);
+    tcg_temp_free_internal(t1);
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -896,46 +944,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    TCGv_i32 z, t;
-
-    if (tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_ctz, ret, arg1, arg2);
-        return;
-    }
-    if (tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t2 = tcg_temp_ebb_new_i64();
-        tcg_gen_extu_i32_i64(t1, arg1);
-        tcg_gen_extu_i32_i64(t2, arg2);
-        tcg_gen_ctz_i64(t1, t1, t2);
-        tcg_gen_extrl_i64_i32(ret, t1);
-        tcg_temp_free_i64(t1);
-        tcg_temp_free_i64(t2);
-        return;
-    }
-    if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_REG, 0)) {
-        t = tcg_temp_ebb_new_i32();
-        tcg_gen_subi_i32(t, arg1, 1);
-        tcg_gen_andc_i32(t, t, arg1);
-        tcg_gen_ctpop_i32(t, t);
-    } else if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_REG, 0)) {
-        t = tcg_temp_ebb_new_i32();
-        tcg_gen_neg_i32(t, arg1);
-        tcg_gen_and_i32(t, t, arg1);
-        tcg_gen_clzi_i32(t, t, 32);
-        tcg_gen_xori_i32(t, t, 31);
-    } else {
-        gen_helper_ctz_i32(ret, arg1, arg2);
-        return;
-    }
-
-    z = tcg_constant_i32(0);
-    tcg_gen_movcond_i32(TCG_COND_EQ, ret, arg1, z, arg2, t);
-    tcg_temp_free_i32(t);
-}
-
 void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     if (arg2 == 32
@@ -1797,35 +1805,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    TCGv_i64 z, t;
-
-    if (tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_ctz, ret, arg1, arg2);
-        return;
-    }
-    if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
-        t = tcg_temp_ebb_new_i64();
-        tcg_gen_subi_i64(t, arg1, 1);
-        tcg_gen_andc_i64(t, t, arg1);
-        tcg_gen_ctpop_i64(t, t);
-    } else if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
-        t = tcg_temp_ebb_new_i64();
-        tcg_gen_neg_i64(t, arg1);
-        tcg_gen_and_i64(t, t, arg1);
-        tcg_gen_clzi_i64(t, t, 64);
-        tcg_gen_xori_i64(t, t, 63);
-    } else {
-        gen_helper_ctz_i64(ret, arg1, arg2);
-        return;
-    }
-
-    z = tcg_constant_i64(0);
-    tcg_gen_movcond_i64(TCG_COND_EQ, ret, arg1, z, arg2, t);
-    tcg_temp_free_i64(t);
-}
-
 void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     if (arg2 == 64
-- 
2.53.0


