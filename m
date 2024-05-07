Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCBB7C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 14:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Lt3-0003GD-Lh; Tue, 07 May 2024 10:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4Lsj-0003BJ-Oj
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:33:30 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s4LsZ-0001MB-S1
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:33:24 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1e83a2a4f2cso15629175ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 07:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715092393; x=1715697193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mlyxowCfDvQ4k38rhsOdlKnMfFj+X+kXRTg8aR1HewM=;
 b=UkLxQY9s1PjinGJz+oaOQTfEjQVPaanZTgLcyy+aS3re8JlQlKSv+0EhGxJG7xlKGd
 C9fZZ8NVzB/ORXL07U+lq037s11/P4EmwwO1X/8jM6Uq1ZaZ/uSGK/fGs/B7JObhCqJY
 snH6iAE6Q53Thr+iYXBUDwmkormGesEZvyBYH0eQyI9hZoRb0tLqoyfFNzu3nUhHkF0G
 uAp9mMF/aOD63XUIXBMoVVgqhwc0JxER9Y16OMujFXctGO0p+ucwr7nH2lTu7gls1/wr
 wR5hQgVHtYsKKkF+img7C4om2HqxfcfX5dx4+OMQmnTAzOjLxqoowLsYqkqVhHHqAy9K
 H44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715092393; x=1715697193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mlyxowCfDvQ4k38rhsOdlKnMfFj+X+kXRTg8aR1HewM=;
 b=ohSKkoEL/Y6D5UE2iLoXxodmCxvKFdBvdevSwUoR+zYLHzRzlDYjW6qlOIEi7QfMat
 HxW85YmJ2VL+v+G//mmwqZxBfrfFQiMZFXKm/igP+G6/CHc1chT8zFQ1uZxB2Xe4TkKk
 P6szdce7E3YmgTjHp3uSVfETi5PqnYW1yoRrATtNgXuLHBoxSyCgUXlnLs+EmKvo1WjQ
 E/om4uPKOxDPHX24kdW94nPab8AWxuWICmDkaQ+DiK5WSetQhCumvVmb+aFfYttju3/N
 YCSDUz181sRJGGmqDcGUTl7W3qEHzXSwPCY3HSPA8cjK1hvFM/3jP9evEQK/g9CPZxHE
 0rdw==
X-Gm-Message-State: AOJu0Yz+eWp+RSp5fU4r+R9zOJGq3DdSIQLbF0OKcsT2aMVXk29eN5Q0
 Tg7Sib0WxzykXeN+P2zeTZNs8U/6JqW1rVzj5DIboNCs+DB6widI+DjMXCwZGusqQp73jSyu2qu
 v
X-Google-Smtp-Source: AGHT+IEK/E6uv3D8Y7iAidoTKGPLxa4jNkOTWPLMk8YK4knC2HDazq9xGzQUz7atJWTqdckc+spFEQ==
X-Received: by 2002:a17:902:dacb:b0:1eb:527e:a8ad with SMTP id
 q11-20020a170902dacb00b001eb527ea8admr18694179plx.51.1715092393410; 
 Tue, 07 May 2024 07:33:13 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a170902780300b001ed2d84c1cbsm8690097pll.193.2024.05.07.07.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 07:33:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 3/9] tcg/i386: Optimize setcond of TST{EQ,NE} with 0xffffffff
Date: Tue,  7 May 2024 07:33:03 -0700
Message-Id: <20240507143309.5528-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507143309.5528-1-richard.henderson@linaro.org>
References: <20240507143309.5528-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This may be treated as a 32-bit EQ/NE comparison against 0,
which is in turn treated as a LTU/GEU comparison against 1.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 6837c519b0..59235b4f38 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1658,6 +1658,7 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
                             TCGArg dest, TCGArg arg1, TCGArg arg2,
                             int const_arg2, bool neg)
 {
+    int cmp_rexw = rexw;
     bool inv = false;
     bool cleared;
     int jcc;
@@ -1674,6 +1675,18 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
         }
         break;
 
+    case TCG_COND_TSTNE:
+        inv = true;
+        /* fall through */
+    case TCG_COND_TSTEQ:
+        /* If arg2 is -1, convert to LTU/GEU vs 1. */
+        if (const_arg2 && arg2 == 0xffffffffu) {
+            arg2 = 1;
+            cmp_rexw = 0;
+            goto do_ltu;
+        }
+        break;
+
     case TCG_COND_LEU:
         inv = true;
         /* fall through */
@@ -1697,7 +1710,7 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
          * We can then use NEG or INC to produce the desired result.
          * This is always smaller than the SETCC expansion.
          */
-        tcg_out_cmp(s, TCG_COND_LTU, arg1, arg2, const_arg2, rexw);
+        tcg_out_cmp(s, TCG_COND_LTU, arg1, arg2, const_arg2, cmp_rexw);
 
         /* X - X - C = -C = (C ? -1 : 0) */
         tgen_arithr(s, ARITH_SBB + (neg ? rexw : 0), dest, dest);
@@ -1744,7 +1757,7 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
         cleared = true;
     }
 
-    jcc = tcg_out_cmp(s, cond, arg1, arg2, const_arg2, rexw);
+    jcc = tcg_out_cmp(s, cond, arg1, arg2, const_arg2, cmp_rexw);
     tcg_out_modrm(s, OPC_SETCC | jcc, 0, dest);
 
     if (!cleared) {
-- 
2.34.1


