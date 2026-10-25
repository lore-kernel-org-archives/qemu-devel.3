Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47E5606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=UwGj5Umm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsWT-0006en-RT; Sun, 25 Oct 2026 03:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWF-0006HO-Vi
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:52 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWE-0003jM-9U
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:51 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48e0d1c095dso1227146f8f.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912789; x=1793517589; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SGqiIr1rKDobwLQf+1gsBNCgl46aslmMOeFX2SakoqU=;
 b=UwGj5Ummjc5ZeJHu2Z7AHF/8dEcdVuS3WoslwMAlKbjQKWHgJSQh6sihlBgDffRPkM
 htHhx3HdcUkjFIJq8LB3SWEMwIBw2gfFMREJ5w0OCctmgmv2Po7CrfPKAwVgBPRsPMCT
 IGffgQGaAzX9Nwk2MsMn9Sx9KMP6Z95s3YWtqWTsEnn0oHpmgYoORc3qRwFRRuUrwDUS
 wC5QvOydGqU9Hbhk7c7wFc3XbzDcDM52zd7EKUxHB+u3xFtSPdNBsAfm3R7md5d9Wk29
 sU0K+2BYiAYFSUFKSZtOkyx5TOxuB7hr8edApk0cJZcsGssv/7bIEtdMD0/XeZeUSc1m
 c/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912789; x=1793517589;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SGqiIr1rKDobwLQf+1gsBNCgl46aslmMOeFX2SakoqU=;
 b=c/SjHgZcCVVX6iiKDF/5HgmPDf8IFAIwa/SKgki6Y7v+8y5Gzmb4KqoML4Sfh+ksZ+
 pDmY/PW19dYctCQ34HGKgcrmHM+ZdjTor+C1aG4OpGlYiRMMD3afqrcihb2TnEuw4AVq
 XYWhA5OBtTqc/8/KdbGM/P53OkcoNkl/0hMGMq2VKk+8s41qoa4FiyGI+3FPC0HpERo4
 FDZ8SMIDK+qD10rB8ESXsQoL7FmIL/qGNcC2v/7gUCK8LWbwoPaDLGiXh8AjktF84XIR
 ZfUVCbLjMF76hrkqsyq0Q0Pgu7Fyd8BAjsESM6E41G4OTUHe+KM2RDdSW8p3X96jCPwZ
 sRxA==
X-Gm-Message-State: AFq9FYLVhIfIXYwE+fKsMl53Gdv3IqOhbMbgotnK7WHdQDssY9R58FVM
 kcPC68sVg37hBQ414y3zmMrVdRaSz590zTf4o46qzffXM6w6KJQX3K7sPwfOrCYSWtatcrcSnla
 zNbPibVc=
X-Gm-Gg: AYBFou0Cn65+NidWCAtC0cIQXRV/8qXNdVaNXzw1lifE4/Sl7SF+nx2H++Wd6upL3QW
 bOy7LLxQfu+XVBLVo+xaafC84pD2WHsDj3/1oTXRl+0YRGX5tay95XaFdtcO0JNe4mleCo9d26Y
 yJCeOsRipq9lqc8H/6IJmQKJ6xvlhkDNYdc/sMyeVkUcz4/ujTctUHLj4x5bFmdlP6GqUm2+VGK
 8GMHG4I1ijDN1BgqajqWt0zROGkkR3Bnnvh+7cVa/v/dzmLdS3cAvrNmr/fgRhwaVFkj3mFWxcs
 7uWTElnMh68poOzZ+0MtCjSciA0xdKEwQXGNi2rurNGedoKI0uISXRO9XjPKKumzMhhfrsgMSbq
 Ur2mMHxjN1me5KScoM03+kKNq6k6JUZm8H+U9w7k4P7cprLHzQB8mYka6udtZRT7xkxkt2lna0c
 2vFEFdkpO8rG7hOtKangLqRC7cPDvb06im85CQz6kh9d1AMMzD4IT874SWXFOUSGJCEr6oUa47r
 e0mjJmkm0UPsvXioL7+DAPlmxLLQUtZayQR5wLRFbzbXlIiY80LVwzBDA==
X-Received: by 2002:a05:6000:481b:b0:48e:2f55:8c4a with SMTP id
 ffacd0b85a97d-48e3eb46bafmr6284912f8f.4.1792912788787; 
 Sun, 25 Oct 2026 00:19:48 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 027/100] tcg: Generic expansion of tcg_gen_ori_*
Date: Sun, 25 Oct 2026 08:18:02 +0100
Message-ID: <20261025071915.1123867-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42e.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 35 +++++++++++------------------------
 3 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 1108d185e8..dc5c7f7cb2 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -210,7 +209,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index f7e7f4d2a1..f7a7dc69c9 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -11,6 +11,7 @@ DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
+DEF3(ori, TCGV, TCGV, TINT)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF3(shl, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 34e1e736be..668c946c03 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -438,6 +438,17 @@ void tcg_gen_or(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_or, type, dst, src1, src2);
 }
 
+void tcg_gen_ori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    if (src2 == -1) {
+        tcg_gen_movi(type, dst, -1);
+    } else if (src2 == 0) {
+        tcg_gen_mov(type, dst, src1);
+    } else {
+        tcg_gen_or(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 void tcg_gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
@@ -509,18 +520,6 @@ void tcg_gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 
 /* 32 bit ops */
 
-void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    /* Some cases can be optimized here.  */
-    if (arg2 == -1) {
-        tcg_gen_movi_i32(ret, -1);
-    } else if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else {
-        tcg_gen_or_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* Some cases can be optimized here.  */
@@ -1487,18 +1486,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    /* Some cases can be optimized here.  */
-    if (arg2 == -1) {
-        tcg_gen_movi_i64(ret, -1);
-    } else if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else {
-        tcg_gen_or_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     /* Some cases can be optimized here.  */
-- 
2.53.0


