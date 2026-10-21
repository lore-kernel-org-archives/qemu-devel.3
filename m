Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EFF606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yr4F6PL5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXGD-0005Rm-NI; Wed, 21 Oct 2026 10:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDQ-0001au-El
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:52 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDM-0002AC-MT
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:52 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a2001dd4e7so6792165e9.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592560; x=1793197360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ihIvVg6nZj6/NmPi+zgmZb9yJbKJGbDcDRomFwcbQnM=;
 b=yr4F6PL5LDqp8Rlrk1aqQNEQotgMU6XPRtFLqU2h5kucz/tZ9CgN7SqLNS0/wtmFtH
 Re4ui3uffQESdCvSnT0ACdokG5FmXkd8shNI9Z6OpR9dmOEU2+CXa+iCHwPsDGX1rIjR
 rap0R+pmZLK824PlmOUAIkeFBWBwgQ0PR8pS1mvnXr1C8YaZbYU5THSLE2RvY9uJIJBc
 EFOXKxP3ZydZGV7B6xejNdOd8trNOy/7JOVeRbTuxW49gkmjj/cs7G3fN9GfOLkuUKUD
 i1kco7Rg26np+hRlOvkYx8PYfJD8tyDFy6eYWC2LGdi2HKHLY88LYzzNEaIGJ8Px0CeF
 Ugmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592560; x=1793197360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ihIvVg6nZj6/NmPi+zgmZb9yJbKJGbDcDRomFwcbQnM=;
 b=hwu5L9zRUMhmGtJS4K2USHeZKsTuksaJFiY6M9FlEqiYmR8sb717M58cznaO0uwLYd
 prBvuIM05SauOt7mAW4N51DHniLUw8dfYMN9oJcJwQL/rMGWkUzpEss5IJGh54ejZ4Pz
 uLDNMlymqEYBRXCTaXzmEPzCqUiam+gp05MI5kBArpUKQH0w1syApLFvqb/xcblhN4Rs
 6mFVH4kmfeYNVcfx5a0kuJGXbZzdlzgn0xjUvqqa/aOIW5F7IuABqw/GdIz+5Ne1H9qU
 BCe7ORBYeZi8qf7UUxrMbWk07GYBVnrW8KOEffHA5qWoUaEqZKz3KBTbdSf47wUXXlMG
 S0kw==
X-Gm-Message-State: AFq9FYKT672XxfFoFXD9WgAkwjcQhQxexhHP6R7JtNglxXiAI9i8rdQW
 UnmsYaBJHwuyO9jzY0IB5AC8cfb8auv/y04osQUrGGOB1p+61dAOh/rFl2vkOgQPnIzU6aq7Ksl
 6XRsQNiQ=
X-Gm-Gg: AYBFou3pt4zqGbFTJYplPIiuRT8jk8R7/diHoLt9UjIn0wJkRP95sO7z2+O5qnm/OTJ
 enfkxAGW4/P8DoD+BHIAy3IkyQXYWmhdHFOw7WJEFZPsC9XXVfr95CrUH1mZzT7wiW7avvMj774
 tp33Am3xmEMY0f7vp4dDx7oZuI7cggs5peSTA3tFQzyu6ko9Fo5mOfYEA8VBW3nsFqM/7ddEc2C
 Pj335JytbzEU5i4If+4xafQntKdJvY7fNN7jdERhQtjQ/v//uYC8YOcN/0H8u+r77iO8i+YbU70
 qot/1i9qgLw3JshGoPu+B8zD2+eIiPa4WyPsPvR9iWooU8unDItRcOmsTcIyW6NyUGn6NSFI8Mu
 PJoSjWkbMle0UyFeten79KW4daXFOGvPYWYRhh2hM7EzXCMVg3kY0JHoc1bjRutKCH4EUMlBDVy
 p9fHtvoBFfAKyWWPrptNWJSK/Jb/TATzhWSImGIcR1Ps+2MnrnpPgbSaIzNAkEl2dH1h6lSFSHK
 77eI6Q8VuaMbWjDaAml4Bi6r7EpjA5oMXtoW/e8qgSKTtfea28ZFpYNhOTMRPjDcN3ZnrZ4tYOe
 rxywSfzs2I67ZUfcw2wp3pa1QQw=
X-Received: by 2002:a05:600c:3d92:b0:4a1:e5ad:33b0 with SMTP id
 5b1f17b1804b1-4a1fdaf75a5mr48297895e9.8.1792592559861; 
 Wed, 21 Oct 2026 07:22:39 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 060/100] tcg: Generic expansion of tcg_gen_rotli_*
Date: Wed, 21 Oct 2026 16:16:12 +0200
Message-ID: <20261021141652.363109-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 39 ++++++++++++++----------------------
 3 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 2d434ec8b5..d20ac150e4 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -129,7 +129,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
                          unsigned int ofs, unsigned int len);
 void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
@@ -181,7 +180,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
                          unsigned int ofs, unsigned int len);
 void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 88a8001601..9b88373ff2 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -35,6 +35,7 @@ DEF3(orc, TCGV, TCGV, TCGV)
 DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(rotl, TCGV, TCGV, TCGV)
+DEF3(rotli, TCGV, TCGV, TINT)
 DEF3(rotr, TCGV, TCGV, TCGV)
 DEF3(rotri, TCGV, TCGV, TINT)
 DEF3(sar, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 0e294a2966..536095683f 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -764,6 +764,21 @@ void tcg_gen_rotl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_rotli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    int width = tcg_type_bits(type);
+
+    tcg_debug_assert(src2 >= 0 && src2 < width);
+    if (src2 == 0) {
+        tcg_gen_mov(type, dst, src1);
+    } else if (tcg_op_supported(INDEX_op_rotl, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_rotl, type, dst, src1,
+                       tcg_constant_internal(type, src2));
+    } else {
+        tcg_gen_rotri(type, dst, src1, width - src2);
+    }
+}
+
 void tcg_gen_rotr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_rotr, type, 0)) {
@@ -904,18 +919,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, tcg_constant_i32(arg2));
-    } else {
-        tcg_gen_rotri_i32(ret, arg1, -arg2 & 31);
-    }
-}
-
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
                          unsigned int ofs, unsigned int len)
 {
@@ -1678,18 +1681,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, tcg_constant_i64(arg2));
-    } else {
-        tcg_gen_rotri_i64(ret, arg1, -arg2 & 63);
-    }
-}
-
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
                          unsigned int ofs, unsigned int len)
 {
-- 
2.53.0


