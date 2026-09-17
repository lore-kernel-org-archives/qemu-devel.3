Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95DDC982D1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73lV-0004Zy-Ib; Thu, 17 Sep 2026 00:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k9-0003DH-Ju
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:07 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k3-0006oI-JB
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:05 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc1cebad4aeso258436a12.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619334; x=1790224134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zViLnWWimhUqqQWRcEtwFvMmvTWE+xmDjdpS/VswBpI=;
 b=hMLK/oCFmTix/Z8hR7gm74KPYSib2hRO6IUkQUnhJ7T6VWW+tr5F7mbcjoTU8wyd5F
 rEziES4Qx+OrdUXjX4vTItQ5AQC5EKe+4EVyQTJ827BL21KIE2ZVD02tIaEnb5VvdprY
 XeI78qrC/vQ9TpgeveJ3Pfh8DfsLu/khx+PyktfdrvQ+ua7ypKOCPitLbW/IfyFn1reE
 eCrX2r9/sbzVI2Izsp1ULI4mmDwM+qUbexkKeGgP5sWjIj3lDBUI0IUY+dVID1u0q414
 5Z1KGI874a7xF/QXnOth6D1tQtQrF2hPExVeA2tmEUJ3cKHL9bRFugxQYNl8HBedWTro
 I2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619334; x=1790224134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zViLnWWimhUqqQWRcEtwFvMmvTWE+xmDjdpS/VswBpI=;
 b=zzvWWL76Rp44fV5sj349WLDFO/dtHKwAZVrefx2Yt0beSTUiPKsPfTfucYAuIPvmIN
 d8w3GDgn54VWoRxM57vqAmZvrGU3QeaBoQaI9xDuN2nE1FzNOI4vcz5eaBNKgCsCI0kh
 N68uQUJciCZqjGEKU2wq/9oLK0kCw6kcjL66/seBItwolXKFVffsiviYBG7YLCR/vGiL
 l9YOOhd6oexLWF4gl8O+x1AdEsuNMqH42ycLGb7uifY0lzTwomSvkHI+suTRT4NMpHYq
 AjtXfOA+rUoJQplm8I8ew4K1ipm9FUB7xXxoVLYDAlVXhUz/dfJVH7iGvdquMkcHbQGt
 sJ3w==
X-Gm-Message-State: AFuF++kVabTlS4Kxosr5sgi/P7w7sRXt2C6pvqlYsIg95mqfQW9iTnXb
 JHTdSdhrWPdDid0EzhUsa7mHcFEBZzzX4gwlcjSRzKowbdiKG3oeJcTmFtUqmCFY5wSzRUJ5sPU
 wmvtbE8c=
X-Gm-Gg: AYBFou0WZKOkhtIjh233ut/Nzxnhv1xOq4uDBnWBzMkhnMaWS/wyu/pcQ4vt/hGuTTu
 6USl6D5B3el/ZiRw97l3DpWdAxsSROqjq9TNMC3mTgrxYj3TbvOzgvwQRgMVxySarLZdgVtbVve
 80HDMsudbNpbTzAfi56J02n4JZWfbPwRFA7uKwfZfVf1wQwluaWgtcKMN/qjETxKTf4AT8yvD+2
 vRu1ou0idb9SWGzXLFEnvLxvOsPqH5I4taIXt3APLcJflI/KXKUwooebaBpzpJ7PNMkQm1L0ind
 cbZZKb+D/DUnUZJyC2cMXQE7VJCenYeI5WvtPy1dhbUBB8JDeKfPmG3Wz8SrhGjPYo6K4pGtu0K
 E2+XnfJCDi4t1/VCn5xhIX74IwGDmFDrLWiPS+RK4uPnPpYrxKAFY06vZ4zQLa//LflpX1zzI42
 7KtowAqCVDASjtdNsJOpYUdl/tpknjeN2xzTejGNYCfTvFZG5lKKggY7Yi3GWv97Cpc2h/dv+td
 /FagsUiwSPWhombUg==
X-Received: by 2002:a17:90b:3b51:b0:39d:f95d:bd08 with SMTP id
 98e67ed59e1d1-39e1e47ac09mr14971616a91.14.1789619333500; 
 Wed, 16 Sep 2026 21:28:53 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.28.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:28:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 025/101] tcg: Generic expansion of tcg_gen_shli_*
Date: Wed, 16 Sep 2026 18:27:07 -1000
Message-ID: <20260917042823.542588-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 tcg/tcg-op.c                 | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index f45e5961a22..14f8dce347e 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -126,7 +126,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
-void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -217,7 +216,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
-void tcg_gen_shli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index b318ddd74e2..b98e5bd80e9 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -11,6 +11,7 @@ DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(shl, TCGV, TCGV, TCGV)
+DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 2d0e2c4b34a..1546fc3c094 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -458,6 +458,16 @@ static void gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
 }
 
+static void gen_shli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    tcg_debug_assert(src2 >= 0 && src2 < tcg_type_size(type) * 8);
+    if (src2 == 0) {
+        gen_mov(type, dst, src1);
+    } else {
+        gen_shl(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 static void gen_shr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_shr, type, dst, src1, src2);
@@ -554,16 +564,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else {
-        tcg_gen_shl_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1583,16 +1583,6 @@ void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     }
 }
 
-void tcg_gen_shli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else {
-        tcg_gen_shl_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-- 
2.53.0


