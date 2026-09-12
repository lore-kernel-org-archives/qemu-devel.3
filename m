Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F56FC88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L1q-0005PI-0H; Sat, 12 Sep 2026 06:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1i-0005CR-30
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:32:06 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1g-0007NH-9s
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:32:05 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-86908cbc011so2663788b3a.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209122; x=1789813922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Y5XccNSRdreC+3wxRKkSOjiOGbDaHajtidU+Ahton3w=;
 b=fQTtTywVSJ3M0uHMNRJ+qlLtsdomi14zZm9eZh6e580AcFUqG3maIFOHqRfKOUMHSl
 hIA813vkBQujSeQSuMDYms+mXQhblUEyreBoXMC+tFgk1UE6sCO6X89TkHDeaMdDsbHt
 gj0gjlIzpO6cxJCxFW482prS9Xo+3oVlvSORue0PWMlhWwtcuv04n7+C6nwC/TrXupHU
 FByBJwFF+fENrkqZg9rdEjF/R9uzpOUyqHbqbk/aBJrJRhxHxj8Ne38zOZ1dyY479yO+
 elkb0DtilJP38v3j23OlvdNGIX8kg2ETdM8VLNob1tiur1PAzHMmCQVHZV/Sfo9lIuJT
 3xkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209122; x=1789813922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Y5XccNSRdreC+3wxRKkSOjiOGbDaHajtidU+Ahton3w=;
 b=S7zC4YKQwyuQLxPCOOsZXujloqVA5j6y0yxmc8Y9eeQUElvydbiSrS+a27EzDRDKto
 5EdpOrxntqW0qsrWPyH0Qze4uQVPeeUb3OT9soF7nfJSPes0SDqa/YgNdFof3IWQ4/3k
 5Mi7wLdP1UQxxGUiIQIpT1qM086QTFu0v1DZS0O1/EX7Qe0OX+6hyfjVG9a82UR3R9r5
 KhFHX0x2OV7SidAoNn4VwS7DvOikT4cTTF+OkBlSNd4R3TMauBDtOOHakzOB8hXkIzph
 kaTTvg3mAWrQANoUQygTKV6lgo0y9kPGebVR87M2brdsPsSY1vozEBaeQ9cwXWd6NwDD
 8v/A==
X-Gm-Message-State: AFuF++kKlR7CG1xRa020C7iNUWXuHEVmwQ1RdRemPrDC4JBTfxp3Hg43
 eOFBT2YueARMEVntwZdCwHk9FGv7e7pl+MknoN7CtBefxiIu6l4GR7z8zyStx0yzla285jG/1ol
 2MOQorwE=
X-Gm-Gg: AYBFou0Zf28pVX00xW2qQY8l/vD1gv4Mmzrr/JraXIhr26s+NwFpQo+BGPfDhs5/J7E
 /gSkM7Q44oWMYpDo9T8wY8UL1pArpmWFAprd4pH7sUBZ15MIxnpD+stJ18yySszxRmNIvj2UYid
 9Zal2tvVpsMmDrA2yIzG0dPF9HyiHtAuQaupIsOJ2Ni/jejkZHaClIu2sUjxn/rUuNZOm9fcqF0
 7b5nkmXvAwRmuVZZWhh0nQiv0tIcPMGCJn17jK3A519HUdr/uixEGMbb1D2oLNq4LPgR6jw53XH
 KzOyFQ1bmZYw38ZFQXz/DlpU0wjr/rqx8y1GWU2mxEX/OgX7/tlhpljpcr/YZZdgGBoO06qAanT
 PUn0tth1iYNie+2XM38vFzBnKlLGWpBY/nPp2C2uEM0bbRMsjSmKqZMFtHm6aAXOyNmK41etV4G
 IFu/jzGN7Y6hOcIfSWSimiuz2ecdqWn37WyfLZcKNZ1F2kGWZDI0oeZ5zNmnx6ojOOTbSKQfAuC
 Dqr70s=
X-Received: by 2002:a05:6a20:1590:b0:3d3:ae50:97cb with SMTP id
 adf61e73a8af0-3daed84ecc8mr16403967637.24.1789209122523; 
 Sat, 12 Sep 2026 03:32:02 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.32.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:32:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 36/82] tcg: Generic expansion of tcg_gen_orc_*
Date: Sat, 12 Sep 2026 00:30:40 -1000
Message-ID: <20260912103126.598030-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
 tcg/tcg-op.c                  | 37 ++++++++++++-----------------------
 3 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index b48e85f0b9c..831502dd994 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -121,7 +121,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
@@ -195,7 +194,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 055e98672d6..bad7f4753c1 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -25,6 +25,7 @@ DEF_RRR(mul)
 DEF_RRR(nand)
 DEF_RRR(nor)
 DEF_RRR(or)
+DEF_RRR(orc)
 DEF_RRR(rem)
 DEF_RRR(remu)
 DEF_RRR(sar)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 87fb5fb5f51..233ecdc5b98 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -534,6 +534,19 @@ static void gen_ori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_orc(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_orc, type, 0)) {
+        gen_op_ttt(INDEX_op_orc, type, dst, src1, src2);
+    } else {
+        TCGTemp *tmp = tcg_temp_new_internal(type, TEMP_EBB);
+
+        gen_not(type, tmp, src2);
+        gen_or(type, dst, src1, tmp);
+        tcg_temp_free_internal(tmp);
+    }
+}
+
 static void gen_rem(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_rems, type, 0)) {
@@ -753,18 +766,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_orc, ret, arg1, arg2);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_not_i32(t0, arg2);
-        tcg_gen_or_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
-    }
-}
-
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I32, 0)) {
@@ -1770,18 +1771,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_orc, ret, arg1, arg2);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_not_i64(t0, arg2);
-        tcg_gen_or_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
-    }
-}
-
 void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
-- 
2.53.0


