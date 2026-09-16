Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDBAC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pKb-0002f0-UR; Wed, 16 Sep 2026 09:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJz-0001bL-JG
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:05:07 -0400
Received: from mail-oi2-x10.google.com ([2607:f8b0:4864:32::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJw-0000VR-Jq
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:05:07 -0400
Received: by mail-oi2-x10.google.com with SMTP id
 5614622812f47-4b37a368895so566879b6e.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563903; x=1790168703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=h9nk6WX+Se3SImUq2L5kQSasAq92EvTsEvSd+cK6v/w=;
 b=RTCwAWJcLhqMLjkus0103/C+UTK4eLsEiTEVbCe/Bmcqfmv0W9iZZ2Z7D8U11CFhhv
 7gpvm0YQpZIyeEXgjVeAsEGq6qWYPUbQ8KaZ8ntHy9dZIrFpkl/zR8QLNo/K+DUkCX/s
 azg3CzoutnMa+/08H2defb+E5Z0MAm8cgMWfQ0RIU6+oPB5H4j2VupneiovUZYBM6UL3
 GGuzsJfD2SUfQBMcveJ7XhbInv+fpo//g1fbh99KumToi2Hqtp6ejac5ZR3BCxL31/Fd
 QR9sc6na+agwiqGNl2xIk70ks71NKwFazCfERw0izCgznpLuHurTVNnVxa86mHMTZph+
 o5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563903; x=1790168703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=h9nk6WX+Se3SImUq2L5kQSasAq92EvTsEvSd+cK6v/w=;
 b=Wo7WotRoQ6x+3/2ZZeqyT4pEE1jD3c9XSyz40KtUdZJD12egWGOCQ+hOfDvegeUVZc
 iG+qZsEcR8494ENjVFnWTApgOyB0yVek9kAB1RVkehE+Zt3jdUGEQTPt+vgQ/CukBYUl
 8Egu7eROXP1IMqz7YksFBuj4gXraC3ZJ+z2QNfN++slJhpadc7nY49nkjvwr4T5z4A51
 ZPmYSUfswR8XdS600RsDj90UF3k7MRnddWTZ1B0Ez1P8MZQY5oPXDeZGDufe3zHTtJAo
 sYMLFyVdzJmi9XPJdaWcasyIeuIxDT3/enAetQ0JlElr6FRMf6XmtaqkpQViU5lwJmMp
 KDmQ==
X-Gm-Message-State: AFuF++m2DAXWeIppga5xJjb+gCLSoiWWtlHmXBpAtHG2WMARYIbTtu2K
 sIl7/NXv+iHW5McwORzODJsB7pGghU5qy8p5A/hY+PFQvwj0v9xZ+VmX5Vp6dTqwC4nlQDkpRYZ
 FZadrDt8=
X-Gm-Gg: AYBFou19AOH9+IqTwBIzuH1o6NAWWo1m7SBxN9iM/bwmD+Xpd2fF+TpxSnQoKN6pNZE
 nMJ7tX58pEGyLal/CLm8oCSDFZvo9441Rnuvi60+gOq/rzD+TWpP0HnL0OFmlu7/KXnofx6pzy7
 hZhsciJRb8WJW4CRoK+HJ2jS/XUtR3ssUVGREm+4Emuam8ezS5gn+uwIk/CqnXFEMNPDIuf80Zz
 KPJXxf1UBukz3kqQWMpYYkpfvEXK9yn5H9R6SzkyKGf3fYYI6P5xxCSIBPjjQvMioV/v4pRJMJW
 dmFWcga6AXWy1gME8nsHnz+Hvkx4E7wxSVDY2i6Gr+/pfK42evuVvsSKlgM9dJ8RK2fUzlMUT1Q
 Hl2CpRXk/A5W/F3ZvZgGhIHWiqEVu/4ulBwmvfhbKU8A07+3x81F/DzhMjCM0G/7HdpBs9/iiP8
 NL3Z+rH2f8yEjNiHL4d4E5dR9w8iK2o7/cgjHoYfbK6O0QZ9fALV43DxegMdRLTqlVKVceEm1Fv
 rx+Rc8=
X-Received: by 2002:a05:6820:198e:b0:6a3:1dc5:3570 with SMTP id
 006d021491bc7-6c7d3af807bmr2457931eaf.31.1789563903119; 
 Wed, 16 Sep 2026 06:05:03 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.05.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:05:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 32/92] tcg: Generic expansion of tcg_gen_rem_*
Date: Wed, 16 Sep 2026 03:03:07 -1000
Message-ID: <20260916130409.3382710-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:32::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi2-x10.google.com
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 62 +++++++++++++-----------------------
 3 files changed, 23 insertions(+), 42 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 2f8a9f48eda..6223d46b199 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -204,7 +203,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 473d472823c..67261d12741 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -14,6 +14,7 @@ DEF2(neg, TCGV, TCGV)
 DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
+DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF3(shl, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index a6b7e68514a..7b6eb9a3fbd 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -534,6 +534,28 @@ static void gen_ori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_rem(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_rems, type, 0)) {
+        gen_op_ttt(INDEX_op_rems, type, dst, src1, src2);
+    } else {
+        TCGTemp *tmp = tcg_temp_new_internal(type, TEMP_EBB);
+
+        if (tcg_op_supported(INDEX_op_divs, type, 0)) {
+            gen_op_ttt(INDEX_op_divs, type, tmp, src1, src2);
+            gen_mul(type, tmp, tmp, src2);
+            gen_sub(type, dst, src1, tmp);
+        } else if (tcg_op_supported(INDEX_op_divs2, type, 0)) {
+            int width = tcg_type_size(type) * 8;
+            gen_sari(type, tmp, src1, width - 1);
+            gen_op_ttttt(INDEX_op_divs2, type, tmp, dst, src1, tmp, src2);
+        } else {
+            g_assert_not_reached();
+        }
+        tcg_temp_free_internal(tmp);
+    }
+}
+
 static void gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
@@ -673,26 +695,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_rems, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_rems, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_divs, t0, arg1, arg2);
-        tcg_gen_mul_i32(t0, t0, arg2);
-        tcg_gen_sub_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
-    } else if (tcg_op_supported(INDEX_op_divs2, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_sari_i32(t0, arg1, 31);
-        tcg_gen_op5_i32(INDEX_op_divs2, t0, ret, arg1, t0, arg2);
-        tcg_temp_free_i32(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I32, 0)) {
@@ -1587,26 +1589,6 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
     }
 }
 
-void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_rems, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_rems, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_op3_i64(INDEX_op_divs, t0, arg1, arg2);
-        tcg_gen_mul_i64(t0, t0, arg2);
-        tcg_gen_sub_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
-    } else if (tcg_op_supported(INDEX_op_divs2, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_sari_i64(t0, arg1, 63);
-        tcg_gen_op5_i64(INDEX_op_divs2, t0, ret, arg1, t0, arg2);
-        tcg_temp_free_i64(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I64, 0)) {
-- 
2.53.0


