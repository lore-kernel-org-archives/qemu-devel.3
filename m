Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7446C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73pH-0005wW-P4; Thu, 17 Sep 2026 00:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nk-0001tH-D7
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:48 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73ni-0007KK-9J
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:47 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-85469a33c9cso467852b3a.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619565; x=1790224365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rByoAPdj/YLr9Vkk1Vbq7+aURylDxEq8clBadcSShJc=;
 b=bkQud4lxzVUkoBzNb/Vx1p8IJUZjtzcRyTcHhmXLifBSyD7oR6gkQXzbFcd+ZZImPA
 pJ6JOyXf2IbYyIjJw7kHnURf3QepKYWWSrQsIL2sX9K1WtXZxIY3Lo5JGhyiGK/12RAl
 1NCWeZNxwg4uM+ytLtIR/ye4GQ6YMvpjoi36o6ytccTlcizA1otFe/TXGqyt9ZjGGh+5
 zwhH+BBgYqGinfTqqpLo5M+cDr773er+V/6s7VsuE4Gvsj50/MRlpYcT+UVq5sg3iBLZ
 YnvFhynEI8+esypkRKiQnm9MvQRJujlkt3yGT9cvnGuJ5+rXkiqHVuYdU5IIv601ro20
 2+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619565; x=1790224365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rByoAPdj/YLr9Vkk1Vbq7+aURylDxEq8clBadcSShJc=;
 b=XCDj+5oNrPlA0FNvLWPXitthPf78+bIPvAEQTJ4ECjmDDoIwR1nWWREUJOO9J6WNCM
 l6V3ck0ydEfV+77nJVqS9kAx+5kQAwbZdUaX9IiLiIDFWJAEK2d548I6KMMkSvofhBAi
 myHwBVW/rHw6iDNYG9WoGaEn7DCHzPY8+HqtHaQYP9DJYNJdb8fQg9Q5w8sw/xnYn97j
 68lZdE4WF+Yx7mXmCLJc0Bax+lpqry8bXFGuzjUNEvLGiWdSwPGiOGS49XxOPX6Xc62Z
 dYW2GgGWcbPfqHi5sxVQ+Q3uCrrRxIlwxMFL9kdT1GWoiAuQSsfDtwM/dN0viVI2djC8
 h1FQ==
X-Gm-Message-State: AFuF++l4HLYL+62XQduVoddG83coCtyBHPqi8vK5mCwcNAXGj7KOi2RJ
 e5nlrTdsc3Gx8S3mOfw+HzPECKAn3PV9R+2B5fj6H+8gdkqzxgHEs1PEITspx6bDlzIlI79PsKM
 COgdToU8=
X-Gm-Gg: AYBFou2iAxgA0Mu4BTsXjlJEbCbVP9TTxdfSepC9k1TlpIYBP9cahRQuRlG6I8wDLoc
 gjPVC9XXFOrBTke4rTeZKaHU9bN6jlPl6wSmPlUM442YLVs7RrYNnTZbZDCoBFeBL186++AEfX1
 q83O8FWsfDhodYV9xGfBdlFN3BFqljezIoX7AgpReDA1DAo+p8flytr0RHlvLsZBc1RG4+JUga9
 bjRo81M1fbRdDNy4T1LC7eWHGOT7O2ETAwo7qynZz2QirnMpQeQCnMqeA0gGNCcrM5pIxBsYYbO
 fAw1/FKb5kFwlbHqh79y/mhmF4JrOkIITW6xD8RLKhEApw1oxkHR2H3EwMDdLeF8ofa5IiXAZ4x
 n4a0oNlc3N7ZSNyK+3C539XyIKOZNdLJuCX8zmxDGL0vtJxrjpvv0RpTygARG+aAVVNs5bCxcSd
 mDXo7Y0KF2uRXKHHs0fbOXe+33rqGlNwJTsdWZMyzE2DrZDiVR6zi6FJGtGyg6k125eI5TCtDFf
 62W9Zk=
X-Received: by 2002:a05:6a20:cf83:b0:3d3:ae50:97c7 with SMTP id
 adf61e73a8af0-3dd5f7ac3damr14389423637.20.1789619564763; 
 Wed, 16 Sep 2026 21:32:44 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 075/101] tcg: Generic expansion of tcg_gen_smax_*
Date: Wed, 16 Sep 2026 18:27:57 -1000
Message-ID: <20260917042823.542588-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 27 +++++++++------------------
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index ada613805fe..997f04ba3a4 100644
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
index 2ccdddc8eeb..a5330ab6a1d 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -54,6 +54,7 @@ DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
 DEF3(shri, TCGV, TCGV, TINT)
+DEF3(smax, TCGV, TCGV, TCGV)
 DEF3(smin, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 75b8536767f..ac513ec93d3 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1118,6 +1118,15 @@ static void gen_shri(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_smax(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_smax, type, 0)) {
+        gen_op_ttt(INDEX_op_smax, type, dst, src1, src2);
+    } else {
+        gen_movcond(type, TCG_COND_GT, dst, src1, src2, src1, src2);
+    }
+}
+
 static void gen_smin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_smin, type, 0)) {
@@ -1452,15 +1461,6 @@ void tcg_gen_umin_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
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
@@ -1983,15 +1983,6 @@ void tcg_gen_umin_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
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


