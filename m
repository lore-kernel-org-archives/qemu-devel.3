Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDE6C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkpg-0000Cd-5O; Sun, 27 Sep 2026 05:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkoE-0005M7-64
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:35 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkoB-0007hM-M4
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:33 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-39b5b07ec78so1139099a91.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499870; x=1791104670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Eh63sKbaDhrmrkekaT6qtYW/yBXCG+IUR0JZG1FUz6o=;
 b=zgYP+9N5jX2yKH35FTlMoX0qPL2GpUE9UdUrWb3WyoxKLfCmrclEW/Yk24bYuLg1DR
 Zpd0ZBzAstq6sBX5upXl4Of2H1Q40TDn5FekycbUsNu9tPCX604pI3cSF8mxPxBErVnj
 FPxXsWcri08RI5Njz9IgvYKAZTUds/mC3d68efZjxTpStczyCikbuHmAW6miZk1vgWSN
 Q2EELnfBEA4JFs0X49TUCSa8f8hbNEGom6yEm0pJHcLEG7BTgBQgrTA+pmoynoDHBPyv
 d6Ow4NR64eBzqQv3P2YIkUWaL3QoL1acOQ2Rtu6sflaIIFj1SIeBJBREuLdfZwjIWm4P
 CuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499870; x=1791104670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Eh63sKbaDhrmrkekaT6qtYW/yBXCG+IUR0JZG1FUz6o=;
 b=wbV9P67EGcgernpy4SRkBmSQL0k/nHPGMCdzjftTGOKuNWmCxcvzIA+RPj3nTOIAsg
 /MRvK/oot1jNShr0M5qwAZ9aDzq390i3O0yfJa1LOpmLfEnAOZj2jsjLlvXui/snlmWP
 cVaxzvZGKP82pH5HcFguH5E3qya87ewKVwkbk0MOWmMhVriRgEBBHIh+5FcT+eJyFDD2
 PHkW3VGuLbyirg6B0zO7IpBEmwhM9ap28fMaIA+XHiyISRvFeMPYVJ4MGhs9E9ioeQ8p
 lTaBub4EOMpUtehF2Sxp0bZEG5OByk1nU6d9oqumdcipqTy9N5GU4xZ9bJpNhT7gNju/
 WWyg==
X-Gm-Message-State: AFq9FYLtCP51GwMZQkAV11kdMAzauTzAtDFmrLtEmcgE+6UykFnBVWZ5
 sNVJXOXNWwQhcahqj24Sii9/CsQi4syS2x+fnjXhjaM/Ih2QF41XmDa0dlU20K34ZG+XNdC4ckC
 kKbN3
X-Gm-Gg: AYBFou1duskg3wvI6daQ0zBaeH9D/pngCPwyZT2Ys3M51g80DUOTuVuzqrX8agDBwXw
 F2uPIZ58EOhAKa0PFiu7KlMNSQNQ8oKgAYIleBw0z/UQFR0h1m8EBvuBgl6XCd9DBaUQAVd6f1i
 5DtEGDzwsA3f7RN+zZPqU42ZVvB3GT6tj5r+2M71wd0a0Aap7eEzB3xTw9d6+3JWgQkDIYiWslv
 KxHCm5Wm5D9zpjiu0iO5itTlrtMtEbh+g+yxGHvTZwPCa06X1UepvlALCNjJUbZLLXNoLPDA38+
 1M4QYOr3Ae6A5y5BxDRiBkyTBS8It25hmwibKFKdyu/u8wK6K1hcH10XUMu+TKA3qegmISNTtjB
 8q0aUiYC8G2ywiKDqlmtIQI8oKM06tIjRqU+q15g/r18CT8meZmgi3fMIY3huHlHg3tR2lUlPBU
 n1dCmVLp9mON5WGjVtZ/luWpTZ3kevAs3PwIOxO7dlQy+UYBPinYEjqQ8h3zNWQCy58nR4aRadk
 OYa55QbZf4UcF4+hynM7CunNEpv2w==
X-Received: by 2002:a17:90b:51cb:b0:3a0:516d:9f87 with SMTP id
 98e67ed59e1d1-3a0985710a5mr8369075a91.13.1790499870254; 
 Sun, 27 Sep 2026 02:04:30 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:04:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 072/101] tcg: Generic expansion of tcg_gen_smax_*
Date: Sun, 27 Sep 2026 01:59:42 -0700
Message-ID: <20260927090011.10724-73-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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
 tcg/tcg-op.c                 | 27 +++++++++------------------
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 3f463725d68..c7dafd2773d 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,7 +146,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_smax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -188,7 +187,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_smax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ussub_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 14860667283..de3feeabdb6 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -55,6 +55,7 @@ DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
 DEF3(shri, TCGV, TCGV, TINT)
+DEF3(smax, TCGV, TCGV, TCGV)
 DEF3(smin, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 207a62450a1..3deaecc7e0b 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1015,6 +1015,15 @@ void tcg_gen_shri(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+void tcg_gen_smax(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_smax, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_smax, type, dst, src1, src2);
+    } else {
+        tcg_gen_movcond(type, TCG_COND_GT, dst, src1, src2, src1, src2);
+    }
+}
+
 void tcg_gen_smin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_smin, type, 0)) {
@@ -1349,15 +1358,6 @@ void tcg_gen_umin_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
     }
 }
 
-void tcg_gen_smax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
-{
-    if (tcg_op_supported(INDEX_op_smax, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_smax, ret, a, b);
-    } else {
-        tcg_gen_movcond_i32(TCG_COND_LT, ret, a, b, b, a);
-    }
-}
-
 void tcg_gen_umax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
 {
     if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I32, 0)) {
@@ -1880,15 +1880,6 @@ void tcg_gen_umin_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
     }
 }
 
-void tcg_gen_smax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
-{
-    if (tcg_op_supported(INDEX_op_smax, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_smax, ret, a, b);
-    } else {
-        tcg_gen_movcond_i64(TCG_COND_LT, ret, a, b, b, a);
-    }
-}
-
 void tcg_gen_umax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
 {
     if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I64, 0)) {
-- 
2.53.0


