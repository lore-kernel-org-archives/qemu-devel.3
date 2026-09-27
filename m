Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25578C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkoH-0005TV-O6; Sun, 27 Sep 2026 05:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAknm-0004R7-IV
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:09 -0400
Received: from mail-pj2-x0d.google.com ([2607:f8b0:4864:39::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkni-0007c5-Tp
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:05 -0400
Received: by mail-pj2-x0d.google.com with SMTP id
 98e67ed59e1d1-3a0bcdf41a3so1025004a91.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499841; x=1791104641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=chhJeGZUKhzcxKwWK3dnVNwuTHEY2jN8FeBp2zvCvIo=;
 b=ucWPbb/FJWDDKXdx+TVTH4dWcr/7IYGtrLjUL7soHwvN1j38l15HLg/aZgyx8C1/dm
 PKwRrbFS612XCcAKeZ02n3d2/dZ6Nil0j2glhoouTv4lBFFKG6xTCnsi23hUhqDYPZ3Q
 6h6uYf2eUJ+IKExDoZHv8hHMX7e34x+t8AkeapFSHuAm7G5nq/Vlg6uBC8QHtfvzV0Pe
 iSaKHVVG+3Ko0ib71Fu0kkRD/4cFvk4RdrW4kdwSuJxs5h7ydwGkQ7cVRcPOI8WfnoMN
 G1Cyz/OktIZ8vLYTCqHpdlRZNzLGDSjJ/N7pPC91186KdgMurjfcCJERP0ufpxC2P1ET
 nmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499841; x=1791104641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=chhJeGZUKhzcxKwWK3dnVNwuTHEY2jN8FeBp2zvCvIo=;
 b=eSfewGvnVIwy4wvdQxIddO/TVHD/yyaHTAQhO9USjEitxbDq207UQJf2PLsr5Wbemi
 mpiL4uriCY5xPE+Lkr8ENgHkbNCj92eFpGvNb+LUiP5FpF9whfBcBt21kbfvt648hJ1D
 4aN7dafzMpn2796QeO4WpCeq2EPZTcJ64i5Imcjy2W4LrmEUNUG10BGSiUl5lIb/Gu0B
 wxSb3LF8B2ELaqznIc1B94o2W9VLYNmUDc/K9mhHIcJiAqD2loQpqmPU0+nJYDtG5W4u
 +KZ+LX3bjDdF52QYpOsGsTcquF6h2DlqrQbS6VZstGiu15fVYb6+DYBeEzLYiUTBJJIi
 2rNA==
X-Gm-Message-State: AFq9FYIFeFG0rQgquTN/H3JPMRzdjU6e6rJLKq8Q3i+ShoGSK9qTldqi
 rDk7YlLeSZKMgV7LQCZKLTr/sbMRvLgILbgyGmLPMdefq4iP2I/oCTYc0klgH+AFJnKHbFds+bc
 ijanQ
X-Gm-Gg: AYBFou3Oge6ltPSL0StdSXDpkXmj504NkgSGeccc7NOmoukF2c0abdEnMw0ns0K2tRX
 mnOtDPcwst9VxBZyE7n1S7fUmxoBTU7MwZFu2dwKj0CafSfnrQZALDaMXDBT5bVDCEAJ7eaDH/s
 KD6d/E9NE4WxMTrw93zTimJBQLd/saW4WgiPbaBNWtx91sHAMx2uPakG6GZE50V7gwzBG4OlO2F
 hQnLBUqpu8HenUqkc3VpegTBV3uAREcLJ7OVe/wmenaxFRT1F/Fb8wYgqy3pnuPWz11psqgQF/z
 99c8kqdNZq94BDx3MeeW6Y7LL8suTMLNbudhrd4W9CTQsV1c+8qi90xpvj+OknT9YqAzpll6Y0Y
 mPq2QXjlV+JcC6dR1SYFjcNmidUGu3vjrrTEnfnLJF+WtlGQuXxoG7cLEy74Zr4TXR2xjimayCo
 iGXOa/Ekosq6oUkclQ2Ok/+THGj/lCV2Ajboja7s7sxQoUz96lmfN8/GfacpF/9jyyaTRKCviAx
 0MlVToyAKQKmmovxR1ltSySIRdkCQ==
X-Received: by 2002:a17:90b:540f:b0:39e:4c80:f67e with SMTP id
 98e67ed59e1d1-3a098980913mr8434076a91.29.1790499840977; 
 Sun, 27 Sep 2026 02:04:00 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:03:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 046/101] tcg: Generic expansion of tcg_gen_setcondi_*
Date: Sun, 27 Sep 2026 01:59:16 -0700
Message-ID: <20260927090011.10724-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0d.google.com
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
 include/tcg/tcg-op-common.h  |  4 ----
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 18 ++++++------------
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 66b72a498e1..54c2528b3aa 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,8 +146,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
-                          TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
                             TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
@@ -215,8 +213,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
-                          TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
                             TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 4934f117bbe..92a35e83f81 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -28,6 +28,7 @@ DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF4(setcond, TCGCond, TCGV, TCGV, TCGV)
+DEF4(setcondi, TCGCond, TCGV, TCGV, TINT)
 DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index f8ded81ed84..069926ce3cb 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -635,6 +635,12 @@ void tcg_gen_setcond(TCGType type, TCGCond cond, TCGTemp *dst,
     }
 }
 
+void tcg_gen_setcondi(TCGType type, TCGCond cond, TCGTemp *dst,
+                      TCGTemp *src1, int64_t src2)
+{
+    tcg_gen_setcond(type, cond, dst, src1, tcg_constant_internal(type, src2));
+}
+
 void tcg_gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
@@ -703,12 +709,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
-                          TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_gen_setcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
-}
-
 void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
                             TCGv_i32 arg1, TCGv_i32 arg2)
 {
@@ -1481,12 +1481,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
-                          TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_gen_setcond_i64(cond, ret, arg1, tcg_constant_i64(arg2));
-}
-
 void tcg_gen_negsetcondi_i64(TCGCond cond, TCGv_i64 ret,
                              TCGv_i64 arg1, int64_t arg2)
 {
-- 
2.53.0


