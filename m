Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EFA6C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pJa-00011u-ND; Wed, 16 Sep 2026 09:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJR-00010m-Oe
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:34 -0400
Received: from mail-oa2-x10.google.com ([2607:f8b0:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJP-0000Hw-TC
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:04:33 -0400
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-466cc9ab667so1086312fac.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563871; x=1790168671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FlMvX3IjryhcBHzyGAGHQdOIUrI/shuBuxQsakqwvo4=;
 b=pIOVkvPvyNZA1azGYEni4U4YyvKSi8dub2WxiYgMCWTspnrmy90NbQgHXn15peX9Vm
 j0p8i6ei8DfWrAJv8+6t2Iia/FSOLuRBm0+mUws1VHoiXTpb7RamLpiGZYnImRZdMMWu
 wEtDNIR35RjHYG12f2SKQLBbvznl8l8srn9RH7eBk9F+eh+BQyqAcUhHLrh0HmuY2WHI
 jzHvWEy59nFWRLoRBVtE2rg0GcI2Vquf0FaS/92FhTTTFAJx0XSorHQ26S4sjm95zt+z
 jtcGGvzhNTED1I/pOYNI3l9CalbH6oRB7JMtxMFn6J1RpSjGKOyZVmmavfMtE1dsF9Tu
 EF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563871; x=1790168671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FlMvX3IjryhcBHzyGAGHQdOIUrI/shuBuxQsakqwvo4=;
 b=e/Cce58ekMGm5xAnOgDWBikO0wLq4+8J94QfSTM2t6KQhNotR4h4dboDnDv+5aG90g
 P9VSH7BO91kB6GcAEFq9X/mMW35cM3vakm4a9HMsDVwX1Abjnd82A9ZEuhU47wSN6OMC
 gQbe5GQ0qCNMId7puPAjvJQ1HAH1g/RQdYsD9IHUMrdt2MC+HckbpzNTzLoUMuOaSQhE
 mViDtbjU51nCDDUYzKyzu/EfknxeZpuC5FIoct1IioKrr6Yk1OF7/hMHG68cCZ3OONbd
 qLZpYx0pnUKYJQjaE7d1XaIpoxycWcaepfn9DQS16gV47tSsTn6QhLcuMaJem4YK87MP
 ZFIA==
X-Gm-Message-State: AFuF++kDc0O3mieBsAdNc61ebr2qFKUZAVpJrJBjaIWgO1FORJ2WePo0
 24vmafNVLPNBmH03nTta+FMWeLQliS65YL/p17h9qJF75yjbNlM5GjmwVwhOdVc0WAD0Y1Rzzhw
 ANdaDkTY=
X-Gm-Gg: AYBFou1neupJZFSxEOhtF0z3sSK5XMcqVvZJSR66RSTSEKeK0r2rgUIAO+fvGonJycl
 Nq4xz0s+pfYXCFWxY23vJCEsLcWMMQC/VKfGjPcsLuUhYN0QlPgt28Cb7/T0vBji8blqjMsPXev
 vgO1HRsuLesf4DvmVj4KQZr8n7mR16r11YyLZZVc1kI/rh8voD6DttR5c2YbctJwXYM8r4Vt4un
 RO1wslIWsYzU7SyciQvQsfnTOhhxcScr5Ip4d9/qS4MNol4eKgLBEDHSQUuAdkJ9VGyrU8/umlA
 m0/yk3MES6PnvmdjGeD+laIHqvo3L2re5D/nzyz2+cqNYnlY845YX4aTmOuI1j5m7tLl+4u9AZd
 aoUFynoEQBy6IcF5pOfiquOunEPgeEPeBYu8SvdaMRYbTKkpVdRM7y0ybmA4vFWolyd9+UNxb7G
 wTzl8N96c5H8W0LQEroBvIJd4HcFJT5D41SjcSKmFd618+DxF1AH9+hqj/D3fZ71ErqjWi7Ud16
 zNBU7A=
X-Received: by 2002:a05:6820:812:b0:6b1:9944:552b with SMTP id
 006d021491bc7-6c7d1fd96e1mr2529264eaf.19.1789563870356; 
 Wed, 16 Sep 2026 06:04:30 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.04.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:04:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/92] tcg: Generic expansion of tcg_gen_addi_*
Date: Wed, 16 Sep 2026 03:02:45 -1000
Message-ID: <20260916130409.3382710-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:30::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa2-x10.google.com
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


