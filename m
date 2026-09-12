Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A94C79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:37:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L5d-0003Zk-1X; Sat, 12 Sep 2026 06:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L59-000184-U4
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:40 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L58-0008TD-34
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:39 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea4ae2cso799595a12.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209337; x=1789814137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+HWJJU+aitLdRJLXp09ZhME0eWw/SsaseRmwYa96kb8=;
 b=vyqld51WxceJxOfhaMrxmQkTM7EM3DKyD2CHMsrRMAO7fNCVxRuvIs6SK2BgrmRwd/
 cikEKWjbkyVsO8hk+CiwkhPjyuuxs/RRBNAGbXXYpa1OQbxDMBYvmXOgX85/ss/SM/K0
 DrCklGePINoPuBgGIq/FxjShMMm2ycS8q2pHDOX8nlJB75PlcH/K2ni+5ArhxH6ZPSeK
 h73eDifFGnYQIOkyt1POnfA0W/y/J7ikEOQ+0L0LbnMjAVm/ZhkYAq3nOZAxHfdkpf0n
 2I3Zzlx3lrVQO+4slWo4a76mVkw0Qjq/pgc3GqZBbSUDNPx0G+jeAAW3wnnY5p9YD6A+
 7Nmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209337; x=1789814137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+HWJJU+aitLdRJLXp09ZhME0eWw/SsaseRmwYa96kb8=;
 b=d2u7ur/XZ//pAlaZ5dltFogpT80v3qdjSZ8fyxs6Ss9oPQWbjwmJhi0wEMJeIlkvJL
 d9SoLtSf1RgZrlZU3At3D1fv80EDYnTfikT5AYquLygxCZPrSUQ3HT5LEgTiQSso6T4P
 TMRxyZhFn9iCHQa1lerS/6xnM2J8WopHgqs89JxC6erhLhFrvX0EpzKYDJdMuRdVPuBL
 BPkAQqkRZCAVf4Ebg8JQaTwbh/bCaneMm/UIuBJBelW9K7dvMwxFS3vR31mutiPZKBlw
 EJfeYtozgrEY9wDoXmnfdYNXzuDa1D37axTucGqMidetadTqxwtsOrwNlOqk1a6Gi66Z
 GbEg==
X-Gm-Message-State: AFuF++nFyJ8mfgVoU0ElVE5CuYT/OXGLineTglSNfTjiRZ8+mKiOWvV3
 BjMfSqyxkjAprQH2GqwDuYApn3QGUpbc9OxG+bJb/KYjsyCMGpvOB0MBF4+d52c3aHxtqV6PJCn
 P2D0COrg=
X-Gm-Gg: AYBFou2xcnom0KxYaTWkcwAYy7APNoAZcI2ByWDM5n3uZ58ahtECqR701gmwWSRN+d1
 oiOr2Oi3PvdV6q10keUx4a5FWvmmkNNxv9qb+HlUBvqa1huhj+2/oRgZI5x1dXpZRZYIm8peAIG
 4KTsgMSnc4IL6nro4CcAmTazDOu5kbw8/JEEuq+J6SSMscta5bYmL8GIPhVdRUxpqtnasXHKu+q
 NrRsb17SyufMMiCO7NkIXE9pFxYCsbv9gwV4+1ljZL94tcJ4U+2KBD9v4jOOp+58Cri+/fEHFMN
 xJii79cWhBKHAgj/sf/6PyfR6lRjS2QOGqfpReCTsv9v4uHHNo1+lBbi1rjZ658fXYEIdA+Dl7z
 rSe0y2uKiFyT1ow9JnYzIiGIvijXGALX4+qZYreuh77R8PyAhEKOLcX5972vanLbqyPH2YoOCBp
 AgHQdMCRjxwWDWUbvm8AaONJXyY+vW0LzLZqP83ziYef6O9urfR+mFAQUo6sFnwLWRvQL8rXSZt
 Wml0GE+F2oLqzj37g==
X-Received: by 2002:a05:6a20:5482:b0:3d3:aec2:4dcc with SMTP id
 adf61e73a8af0-3daed3db048mr14749921637.24.1789209336747; 
 Sat, 12 Sep 2026 03:35:36 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 70/82] tcg: Generic expansion of tcg_gen_umin_*
Date: Sat, 12 Sep 2026 00:31:14 -1000
Message-ID: <20260912103126.598030-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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
 include/tcg/tcg-op-common.h   |  2 --
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 27 +++++++++------------------
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index e751e721a84..de0e535cc10 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -166,7 +166,6 @@ void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_umin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_abs_i32(TCGv_i32, TCGv_i32);
@@ -208,7 +207,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_umin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ussub_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_abs_i64(TCGv_i64, TCGv_i64);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 6eb33424581..fb76cb39ec3 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -55,6 +55,7 @@ DEF_RRR(shr)
 DEF_RRR(smax)
 DEF_RRR(smin)
 DEF_RRR(sub)
+DEF_RRR(umin)
 DEF_RRR(xor)
 DEF_RRRUU(deposit)
 DEF_RRUU(deposit_z)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index d72e64e709f..5afc0cca18d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1110,6 +1110,15 @@ static void gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
     }
 }
 
+static void gen_umin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_umin, type, 0)) {
+        gen_op_ttt(INDEX_op_umin, type, dst, src1, src2);
+    } else {
+        gen_movcond(type, TCG_COND_LTU, dst, src1, src2, src1, src2);
+    }
+}
+
 static void gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_xor, type, dst, src1, src2);
@@ -1505,15 +1514,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_umin_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
-{
-    if (tcg_op_supported(INDEX_op_umin, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_umin, ret, a, b);
-    } else {
-        tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, a, b);
-    }
-}
-
 void tcg_gen_umax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
 {
     if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I32, 0)) {
@@ -2027,15 +2027,6 @@ void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_temp_free_i64(t2);
 }
 
-void tcg_gen_umin_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
-{
-    if (tcg_op_supported(INDEX_op_umin, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_umin, ret, a, b);
-    } else {
-        tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, a, b);
-    }
-}
-
 void tcg_gen_umax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
 {
     if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I64, 0)) {
-- 
2.53.0


