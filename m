Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F199C88E53
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:46:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aEc-0001e8-Do; Sat, 12 Sep 2026 22:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aEO-000131-EN
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:46:12 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aEM-0002n6-KD
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:46:12 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d8fb334ddcso11422935ad.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267569; x=1789872369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eysdNGY8su9IzJx7Iy5RkAcMAQQg3WuPCXfMPq7SlmY=;
 b=gZ5yX5xM81TuxQlWyM2CpUSQYHFRvZnHvyxMmITWZQOOjKX1w1+A4YAe+9MBnuKwqn
 FPWmW+EPgaBDoEupHIsEjZila5C9qOHh+D5kZ16j6+dX8jGRPuI+ddU99qEd3wGtuX7I
 7IFQYYYHpdW6oEJ2PRbt3lG6B8AfhXaDakTaDhfZO3Yu0yyGDNTziiQZsGlJwmiRuRTY
 wUn0wzQ30+kf6bxTLuMrTDOi2xCIEm19kcQPEIgdN3L+lMd5EUyMKSLAzmYjEqFUshfF
 q0wrtzqPNsuFZhwy7nI8+nSVAwlqWQ3ZVaGm4xlM6ang5C2AuIrhgu0mUyveeubIIuPH
 Q6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267569; x=1789872369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=eysdNGY8su9IzJx7Iy5RkAcMAQQg3WuPCXfMPq7SlmY=;
 b=osQ76eFlVChVj1O+NT7tPhMRlMH4BN/ljZXjYW+/8CMGRbkNpUkbeAYVlDV2Z2zT9b
 PLOUoOgv0w8sK4HK0DXsJLa+6odha+v7UNu2xO4U6peYWYLyAVsT9ZleJlobVgAGNkhH
 Ofubtr8Yc7EfOV4sKner6HQluVFpiaGIpcjFbliFceiyt6DgAnoJbuOtRF4YD869I3ty
 YjyWv2ryqgMNDiyYuGW1d09eGk8kC6Ozzed06LqMJXhClW9KVDo1zqIWw8SczAuT4oBl
 VjBW23ei6vqmM07o0Ln9Teox841onWCHaiR3yrDzxPgJzyIJ1WB9BZgN7QUkNEjOcHa6
 4ajA==
X-Gm-Message-State: AFuF++lJowXWEN+crPBM/lG+RhM+C6K6O/6QvkR+GGkJMXQ7FENYpZfY
 tKHriixmgV2AWS0TSXE7aZA1wguQclN4V+PJoyTitySK+g5aRRzVjZ7hkHt5GtMvOFQJGXDSqyJ
 6mCn5+bo=
X-Gm-Gg: AYBFou1Zb98OnkQf1MEJ3Fn3C60spVs0I9+YRdSEWMCCPEWcytvD3DR5jlWXNvmm6qH
 Dqz/4sGSs1ZxYuSGeKXGNs+ATva1DY/M2vm5qUXcgNRgEPvMWdka9DAdI9WZZT1pb2Iu3Q0RpIs
 bPxobnRzl65MD3bmfloowrJacjzKMU6Sjc8pZaXirWC2viCw5+JEUzxshURvAQdd2khhLjatcvS
 ZzuPguUEGSr110r2vhzSyvuGD9q95LJZwgzxpeRay+2aV7tQJOjTm0zBk6NgzFOanSjgtfE581k
 txxdKUYum6DFvrCr5MgNOa7PQROccsWVTAYC2Ep+cw8IC+twLDUX4/R+tKtW3BMPsiP0xyWgE+m
 gaZIW8MFl8jdxpJPexL6H9l4iCuGRUqqVV+ZOTWXxJAZEhjuo414rbS4imYPMSKIkVkC+w4Fe4S
 fuA0ebpRO0KC63nLD4RuhI83qDeFnK4mZ1TUeFTjIU7ykUSWrCZjfWHWZPjWaEPpa+4h4CrslLS
 /iW22o=
X-Received: by 2002:a17:902:cf4b:b0:2d6:fee6:65ae with SMTP id
 d9443c01a7336-2dd2a1c9c3bmr209262035ad.4.1789267569067; 
 Sat, 12 Sep 2026 19:46:09 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba7a9bb56sm17811679eec.31.2026.09.12.19.46.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:46:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 82/86] tcg: Use unsigned for flags for bswap and revbit
 operations
Date: Sat, 12 Sep 2026 16:38:33 -1000
Message-ID: <20260913023837.741866-83-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h | 8 ++++----
 tcg/tcg-op.c                | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 95bb5fd795c..ee26d4c9d54 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -133,7 +133,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 /* 32 bit ops */
 
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
+void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, unsigned flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -158,13 +158,13 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
-void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
+void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
+void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
+void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
 
 /* Replicate a value of size @vece from @in to all the lanes in @out */
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 10c2149c835..b1b29de74ac 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1454,7 +1454,7 @@ static void gen_bitswap_i64(TCGv_i64 ret, TCGv_i64 arg, uint64_t mask)
  * With TCG_BSWAP_IZ, x == zero, else undefined.
  * With TCG_BSWAP_OZ, y == zero, with TCG_BSWAP_OS y == sign, else undefined.
  */
-void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags)
+void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, unsigned flags)
 {
     /* Only one extension flag may be present. */
     tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
@@ -1655,7 +1655,7 @@ void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg)
  * With TCG_BSWAP_IZ, x == zero, else undefined.
  * With TCG_BSWAP_OZ, y == zero, with TCG_BSWAP_OS y == sign, else undefined.
  */
-void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
+void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags)
 {
     /* Only one extension flag may be present. */
     tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
@@ -1698,7 +1698,7 @@ void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
  * With TCG_BSWAP_IZ, x == zero, else undefined.
  * With TCG_BSWAP_OZ, y == zero, with TCG_BSWAP_OS y == sign, else undefined.
  */
-void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
+void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags)
 {
     /* Only one extension flag may be present. */
     tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
@@ -1765,7 +1765,7 @@ void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg)
     tcg_gen_rotli_i64(ret, arg, 32);
 }
 
-void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
+void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags)
 {
     /* Only one extension flag may be present. */
     tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
-- 
2.53.0


