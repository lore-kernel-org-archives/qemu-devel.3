Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6AAC982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73kG-0003HR-Iw; Thu, 17 Sep 2026 00:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k3-0003Bm-Pb
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:00 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73jn-0006nA-E0
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:28:45 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc433d52421so216567a12.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619321; x=1790224121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FlMvX3IjryhcBHzyGAGHQdOIUrI/shuBuxQsakqwvo4=;
 b=CJCMBJ5fU12bPKZkxuE2jCHYtpdNm29bVTtzkOzPWNj7VkuCkoMaeA5rz6jmN9ZewE
 jkeD9nZKYvwW0N3905Fcgcrhp1eSiKnWna4zKbmmHv3YD+wrwdOjo5nT/SyIgw2w8vvb
 /cCTFGUIxlcJXeeLGXcP7oy7u88dXh72TQ3gepilzF2OW5k1Bgl7DmysSAUsQHQU+zYa
 VFI37V8XjxoVYg1xfsUka02tyMjTZX6NAplcuF91xcLF0//L+6M+e0xsOQdgOx8cfPVH
 4/h2FmpmyOEdhsjiuICieuFWNGgO1+gSoG/izgY1hLLM6Mb/miOp61JScRXK0CLvYZgv
 +otw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619321; x=1790224121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FlMvX3IjryhcBHzyGAGHQdOIUrI/shuBuxQsakqwvo4=;
 b=HxGFyPvm1lODEgCk9aQjW9CTF3/BR+hHHhuy8EVfCVnty+GDLJbx2ezJmFujRm0MoB
 SBRYqa+EdybxTh6388h4Yz9s2R0+BqpTu5yZDozAXzhkH0VKbaV3/OqLOWUJF/VcXQ9O
 T+jBnhe0YcN821hXjU3SD7dRs/TKLfGeAaAa7hpA3qlUAIVqEa/Dz/55hr5PjPiWMQw6
 GFAP0xVTGHFHDMYcAyLWAOBQ15Df3UE31a9HXBjlol5u864+SKOWi8avscICM7rim51g
 IB6cj2QMcdF6AyGZula7hu9f3bBmcLxyGpq0kpjAp3OudZ5gxRPpxXEiUp92/A4bpoZq
 Xrmg==
X-Gm-Message-State: AFuF++lrqEQQVrLY6QcD3vLuajPjlKj8Dohg7OdWFz3bpWyg83NROY47
 j+dnyqrgMC39YibvFrHQEIJ7w2dtuMIV4Get5izccqgpadSy7kGHZS/BVJ2hHL2L4PYELU8Y38t
 sYVsLvWA=
X-Gm-Gg: AYBFou1Cln6RBMjlUR57Xr//bkbBF1MTU+rhoChqNF9ORT0GHuO23SgCitN0yU0qypg
 DZImrWVPdkJ6bRinWsH8YM1kvMZpE0LFCNLhASW9aFUGp/g+i4TDSDBY7hfSfb9kB4Bt4rHs3Fq
 e3dcml9D/Xe1hvAk3SQElzn9/9B/qBTwJiaDnXWNTd4W3NQ7Xk2bPJ9zVTSD6GAASK7iRD75Yx5
 zKklt7Ww54bUNY39CxZTMuCtSEIJcWaU46tgWDfGIRyNPBQRwed+ITavvAKv4tOHunjiNBMFhve
 owEZz3UEGb8jD7m0l2J8D/STFcOEHJpc+3v5whIsWA5BFxGtqHCle/Bi9xrBGTAhXJ5/Ubwpvza
 67pL36FYsILnR0ohQBH+/wVTqKJZHld9Q5mRzwAxaAabcFnhWyUc7LEbAHZfGOWKMQktpaECPgj
 yO8/8DLKEbdfNQvO8epBe34TQbzV11utz+1Z6SgNhlJlygQ1a9RsS03k3/AzW85FvmfvstS0ogp
 qSKrxc=
X-Received: by 2002:a05:6300:6697:b0:3be:b0b3:3962 with SMTP id
 adf61e73a8af0-3dd5f44a0camr14217934637.9.1789619320849; 
 Wed, 16 Sep 2026 21:28:40 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.28.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:28:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 013/101] tcg: Generic expansion of tcg_gen_addi_*
Date: Wed, 16 Sep 2026 18:26:55 -1000
Message-ID: <20260917042823.542588-14-richard.henderson@linaro.org>
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
 tcg/tcg-op.c                 | 29 +++++++++--------------------
 3 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index f1dfa4011b0..7e6e17b2316 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2);
 void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -226,7 +225,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2);
 void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index deb3484fc60..31982e2dc6e 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: MIT */
 
 DEF3(add, TCGV, TCGV, TCGV)
+DEF3(addi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 9846cb13331..6a5081cf74e 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -402,6 +402,15 @@ static void gen_add(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_add, type, dst, src1, src2);
 }
 
+static void gen_addi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    if (src2 == 0) {
+        gen_mov(type, dst, src1);
+    } else {
+        gen_add(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -421,16 +430,6 @@ static void gen_movi(TCGType type, TCGTemp *dst, int64_t src)
 
 /* 32 bit ops */
 
-void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    /* some cases can be optimized here */
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else {
-        tcg_gen_add_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_sub_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     tcg_gen_op3_i32(INDEX_op_sub, ret, arg1, arg2);
@@ -1568,16 +1567,6 @@ void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_gen_op3_i64(INDEX_op_mul, ret, arg1, arg2);
 }
 
-void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    /* some cases can be optimized here */
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else {
-        tcg_gen_add_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2)
 {
     if (arg1 == 0) {
-- 
2.53.0


