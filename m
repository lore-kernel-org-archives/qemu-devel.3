Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6121D606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Hsp1k8dk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsWs-0007Yv-1T; Sun, 25 Oct 2026 03:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWR-0006ZM-EF
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:20:03 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWO-0003l4-Kx
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:20:02 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so16299765e9.3
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912799; x=1793517599; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/JR1UpfJPkMivQhkYbf8CXuWOALp+NWsatecVfyVXb0=;
 b=Hsp1k8dkNx3F8uYIl9ukNIR1QZMojfx8KzyHTYSu0/l+WXjA4AK32GxPoXYh1nxksy
 W+vAwTi7qvjLQoXmOCc9fEIc7E8a4aemRTVxV3372wJtutH/L2Yh2w/EDr6YCpP1hzSh
 yD4AfWZWc8/n3WZUj8jQ0j1hNJAmW/Za1rYiFR457vq6or4epfsLokqt07Fw3jzDBjM7
 WVC2KSJwsOyfj6GiMMqlIgYZ1ab0N6WgI5mOWkaCPQTbb6vORnWljb40tTDrRAaHKg8k
 e1o3a4ri7LV6WFFWX7o8ruUgHFbyCEm1jFm+xw7UKVB4pCTUq76qry4toUSgSar/DWTE
 08oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912799; x=1793517599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/JR1UpfJPkMivQhkYbf8CXuWOALp+NWsatecVfyVXb0=;
 b=kmZdFPB5w4/RQwt3qWsZHprbJkGmIjks5VUQrj6UJP8nhKuLGSz4QlyKfeDdkx8EGL
 EsaD+fQn0/VFFalunzY/QD8hx/c8SLHnui9iHuadeHhmD55JNqlqaXfCHeK4GnSj1Q5Y
 8QvVsD6z7d6d4kTuFiUNRZ7k6locmePQacjPbYjvN17G0Odq9ohYDR4YIakS/EZGISKW
 OX8YFq1Qx/iD0SqkEOB3JuvLelLv5m3ARv0M8xrvV+AZXeyQTJIlEb4/X+Ujc06xe9te
 S5LKOxH8KZARsHt06zHaEpf336wUyGBGNtMV5grGs4/JotAhBCgj68n3ETaeCmqnWmch
 HITw==
X-Gm-Message-State: AFq9FYKtgFYWcEPR85/kUv0g7zWQIUl01bt7GNdKyeflH5kSuZdWxPoY
 Rn2oBbbRiCl+4sIkVRESXYC0YvUl78M4pspWihmFy3QwSDH1viE5iI1xa/AuqUwl0js8XYLtn19
 2QQLdzwY=
X-Gm-Gg: AYBFou2rJi/Wsua0IpR4DW/QvlI+wKHiZA5Nx643Wr9nBWzgoFZQLe8QlGeBe37ImE8
 fIk05kE4WT6E4ejUC5SiJfy9eKeR4PUP0GBh0bGYU/QCNVtT3P/lUqrObOcQcWUPbceRjv6KqcS
 3nKtnMvs6aNoaXc0GcLmj+7U7m5QJy4BJoga7sraupLASMd4OXb//He3KavzUwBycfSiN2u9WLn
 lVdoozebKyTpv/NiuN0fLjD3ZlKLPOx+1nsDX7r6c52iiaFW4ypaxbSkf0mo+iVd41VgHoZBLaB
 eFpWtxV1KBE6bKvCKsO9WAmCOyD1IPsqHi3Z1pzgOOhMRA/9GeG9l4zvLf/8Ixi48UW7ykYbWhV
 rH/cG/CT1x3X0ewYapy5uSGNBCPkaw0vvQJ2c5Z+58Su1ne/KST4foVCtG9mTVRG9Ik92Cj/RA8
 cw3K8ThUDjjP/Qouz7pOoUl0SuNO+U8TyNvS9ahMb8b1mESiYW/qWpRD2+XDyG9FZxACFMjg146
 Cw8LlJHNp5ZgsuG7qRbjCyJXx/L0mC2vxF2urTEDN0rFbVdFlGZl8zcFw==
X-Received: by 2002:a05:600c:5253:b0:4a2:148b:c88c with SMTP id
 5b1f17b1804b1-4a35ac8ba2emr53005985e9.8.1792912799200; 
 Sun, 25 Oct 2026 00:19:59 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 038/100] tcg: Generic expansion of tcg_gen_nand_*
Date: Sun, 25 Oct 2026 08:18:13 +0100
Message-ID: <20261025071915.1123867-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
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
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 4eb35775a0..2d9b0704a0 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -199,7 +198,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 6a4d726b79..fc40bca553 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -14,6 +14,7 @@ DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
 DEF3(muli, TCGV, TCGV, TINT)
+DEF3(nand, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
 DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c38accac75..587fe0d280 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -475,6 +475,16 @@ void tcg_gen_muli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+void tcg_gen_nand(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_nand, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_nand, type, dst, src1, src2);
+    } else {
+        tcg_gen_and(type, dst, src1, src2);
+        tcg_gen_not(type, dst, dst);
+    }
+}
+
 void tcg_gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     tcg_gen_op_tt(INDEX_op_neg, type, dst, src);
@@ -685,16 +695,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_nand, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_nand, ret, arg1, arg2);
-    } else {
-        tcg_gen_and_i32(ret, arg1, arg2);
-        tcg_gen_not_i32(ret, ret);
-    }
-}
-
 void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_nor, TCG_TYPE_I32, 0)) {
@@ -1722,16 +1722,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_nand, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_nand, ret, arg1, arg2);
-    } else {
-        tcg_gen_and_i64(ret, arg1, arg2);
-        tcg_gen_not_i64(ret, ret);
-    }
-}
-
 void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_nor, TCG_TYPE_I64, 0)) {
-- 
2.53.0


