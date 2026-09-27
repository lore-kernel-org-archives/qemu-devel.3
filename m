Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D971C98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAknz-0004kk-SY; Sun, 27 Sep 2026 05:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAknm-0004RA-LA
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:10 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAknj-0007c1-Ch
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:06 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc797656e44so467736a12.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499840; x=1791104640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jL0HH1VLbmzFSUfY6xyzUXfyqpGxMsPPgw7CTixdA+8=;
 b=CiOExN6dXATublbWcn7HLBB+elJ24Gi/tPRiWAtEDguBijWhkRjBdLAzxNwFeEQDre
 dyfOiAMZVIYkZA+rB8flp0+TQqgcVMfc0rl3GruDIw4ViEwDYXHjsPYEYa6Kp2xIhq6v
 X5abLYWvST9SPK/4Zslu22OSbe3u1eNH0E/7M26KrfBFfnqQ17VbE6uPQpNuJhhKWnI+
 ugiJTrDrCekm91myWaMp5vfrcpqGwvIGekh95T8sYRJrv0JBFAei3s/C2eXJ25xhuDiO
 JSlCmZw8ux0Y8VLb38yF22xKiinDJWN4E5j9D+hO6g+ktCvQRNrvztcJwvc0j5uCoTMH
 crpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499840; x=1791104640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jL0HH1VLbmzFSUfY6xyzUXfyqpGxMsPPgw7CTixdA+8=;
 b=YWiSpFtBIYLIy/qfWmghAO2MeYKIkF9wOrrA2/XdVIL1QA0oOHZiTANwpggsI10Zm3
 DadXttYPlmqnql53DGzMoKAeBovBTYR9a+K3GGA0xQ4u9SgohGW6DCe7IU819GY47c7a
 PTogP3ahTPDjraZ/mijC7yafzM4iWRE5vxcr5xFWp81+u3QKB4pkCm0MYl4vAVsne21j
 /2DeTiVTVszEBsEPiLmTXM3wa+Ve6yPHOvm8gmxjD0b1EqZMdBaKjraopkGQXMrS7VF4
 x/nCNGzhaBO2SBHprUD+IWuwP31yb5IfIm1mFJfjnceTR4eBOCfHoSPXwq/tdo8dPexn
 b7Pg==
X-Gm-Message-State: AFq9FYL9oGhlkSkCYEsKs2ofAsjm0qC19crWPOiVv2fCjsfQLV46w4kX
 FqwTmBZ9uXIgawB+5AYqEEddDAcgyiu4iRIjKHzxwpYVrUCnapef/FWf5sgTt6s2b7OCNICoNVj
 4dYuo
X-Gm-Gg: AYBFou1fHPsSvlZlhH5zT5cIvHLrQ12/3f6BzrsgvKNFQOGnVIdru9eRQk4TlnHfbgq
 bX48F0c4/QgRpNAdwLQx6cGAq0d3TuU564esWeLClC46wqrTzaRYy1l3hTf77mHDsLbF55cIb44
 jhI/uq4G3mwW1y6hGJQTuM4tLsdAlltzuuwCMdrN3FJWCjlmHQCDV1SvYemJUVYK3DEazM6/BPT
 AkQq0zQqQz/MEvGrvaxpwI6lntU69iPd25oucMKN0mluZOBFu9tKJckOr4Us0pOXPgNM1Esz+Bv
 kopgKMQ88FH0OrV4S6p+pEDkDUvp33r2UhDcPty8bfd9Kc5XhQFo32V9JeRCE8IzJ6ADVS150tB
 x88w2cfy4rF6srRiUxhZZ65u6JqHFTREmosXmeRTszhT5sl3yWl19PDmu2ZCfPA5DF4n9l8Ftnt
 jO0tSbJFBTS8Cbjpn2Q9+2JQOXHqbMy/av3/+LB1tjjn/nNGFvBTcCZHAVi5BzmuNPkxZkr32GI
 ONSnWqVSxkcrakjXDZw9cYY4U1ifQ==
X-Received: by 2002:a17:90b:4aca:b0:3a1:8b70:d46b with SMTP id
 98e67ed59e1d1-3a18b70e64dmr1523976a91.42.1790499839477; 
 Sun, 27 Sep 2026 02:03:59 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:03:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 045/101] tcg: Generic expansion of tcg_gen_setcond_*
Date: Sun, 27 Sep 2026 01:59:15 -0700
Message-ID: <20260927090011.10724-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  4 ----
 tcg/tcg-internal.h           |  6 ++++++
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 36 ++++++++++++------------------------
 4 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 8540c30a58a..66b72a498e1 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,8 +146,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
-                         TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
                           TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
@@ -217,8 +215,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
-                         TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
                           TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index cd481dfd27f..0de8516447f 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -120,6 +120,12 @@ static inline TCGOp *tcg_gen_op_ttii(TCGOpcode opc, TCGType type, TCGTemp *t0,
     return tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1), a2, a3);
 }
 
+static inline void tcg_gen_op_ttti(TCGOpcode opc, TCGType type, TCGTemp *t0,
+                                   TCGTemp *t1, TCGTemp *t2, TCGArg a3)
+{
+    tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1), temp_arg(t2), a3);
+}
+
 static inline void tcg_gen_op_ttttt(TCGOpcode opc, TCGType type,
                                     TCGTemp *t0, TCGTemp *t1, TCGTemp *t2,
                                     TCGTemp *t3, TCGTemp *t4)
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index a863215ffe3..4934f117bbe 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -27,6 +27,7 @@ DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
+DEF4(setcond, TCGCond, TCGV, TCGV, TCGV)
 DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 75d965d40ab..f8ded81ed84 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -623,6 +623,18 @@ void tcg_gen_sari(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+void tcg_gen_setcond(TCGType type, TCGCond cond, TCGTemp *dst,
+                     TCGTemp *src1, TCGTemp *src2)
+{
+    if (cond == TCG_COND_ALWAYS) {
+        tcg_gen_movi(type, dst, 1);
+    } else if (cond == TCG_COND_NEVER) {
+        tcg_gen_movi(type, dst, 0);
+    } else {
+        tcg_gen_op_ttti(INDEX_op_setcond, type, dst, src1, src2, cond);
+    }
+}
+
 void tcg_gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
@@ -691,18 +703,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
-                         TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_movi_i32(ret, 1);
-    } else if (cond == TCG_COND_NEVER) {
-        tcg_gen_movi_i32(ret, 0);
-    } else {
-        tcg_gen_op4i_i32(INDEX_op_setcond, ret, arg1, arg2, cond);
-    }
-}
-
 void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
                           TCGv_i32 arg1, int32_t arg2)
 {
@@ -1481,18 +1481,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
-                         TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_movi_i64(ret, 1);
-    } else if (cond == TCG_COND_NEVER) {
-        tcg_gen_movi_i64(ret, 0);
-    } else {
-        tcg_gen_op4i_i64(INDEX_op_setcond, ret, arg1, arg2, cond);
-    }
-}
-
 void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
                           TCGv_i64 arg1, int64_t arg2)
 {
-- 
2.53.0


