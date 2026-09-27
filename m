Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88E8C9833F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:08:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkoM-0005hm-Tl; Sun, 27 Sep 2026 05:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAknm-0004RC-M7
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:10 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAknj-0007bt-JQ
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:06 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2d747eefae4so4870725ad.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499837; x=1791104637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/fRsuCYOhiDTmw2YSIOULc/tv6mzhQBnCxtnkHRZ96A=;
 b=V/y8ZVpyiWDCvz1BzZ4xbexXM+IpBL3qkaiegM9LL9NGB4Fwb48Z4e4MESq9AtLNV3
 6/u5pYu77u0oNDIA6P+nnu0nx3L88GSp02M0OI/gtzsLNz+Lz+Y8wSPVXeSxWIlGQ0zp
 nkKpoZcAcz4+v9C5agmEZOlf3/ts42Ja6XZ9AgKSBSefok+euHdG5aQOCFsmG2xV+G7m
 hAHXe7f54zrRzitZtEkXBKIkgT97mN/1431U97Rnd3tF6P2GnKbJ7MX/qyzEkH5iuj3x
 5wIg19rv2f80fl1rDHaSnnJ9aynylnHdSDptUi+XpzSplL7l3+gNGHica6LJO8bMvM0t
 MynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499837; x=1791104637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/fRsuCYOhiDTmw2YSIOULc/tv6mzhQBnCxtnkHRZ96A=;
 b=0mxeVR2JE8fUsZLOFo/p9Ugav8xQ+5X0WVWBdqtY/2I949ZIIJayoeEKdV+R99wooL
 t4kaoWN8xvy3Jwoi1YvpaL4iGgVfU7rEn6vzPuw5T140RYcCddv0/yQj6Sq6dfYjPTub
 9BrK7LeX3qOifGiXyd8f1GJHaE9ta+XjRTtHCr8bUcOt76kJKMpvjSXD42JM1AQS+9hU
 pN90apRqjG2CeJDkB4ExvgdSt0dPkI8gOcWZIArEcSyBcFGxxloCV4t6ic61WJLc+ARy
 0KRDPnl1CBKP8KsDVAs9pSEjgn5lSapw+0Km6gr+PRtmKxDH05h+oKk+ZpDCjn05DIAN
 PUFQ==
X-Gm-Message-State: AFq9FYJDdWnSAPWmbEeXuoL+Aimaf/DQ+CTMKflbgxV+TYI3jCpKpgXD
 KEPs60P2prQsfwYDskhEgZzD654zJvIUVrGI7qv21cGSeo4z3FNrO/K53QRbPD9JvwJnQUTpk8L
 yajqu
X-Gm-Gg: AYBFou2n70igGnd0DlUbXC7cV1p1HC5tjPVzUQxyMACPkzQofJy8lddFDgetmIMqY2J
 7AFg6woeb5ygaio4+yGI1hGhpbYuv7RyOz6LA31vBueODqdqWtmirXM3w6KohTg8WbTsmrr/Yvh
 WtklEy6TEFGeDz4RXEEcjYMJo2xFgj/lTV2+3CA6Hy52AlxmzGRN/gGdUvZmPGagBrRDh7WCM89
 LOCIr+oGDw+3zo3UsrMlPLfKhckweFK4TWAqr7AgL+QwpYc3LVND6ek2oko1RJC60bPtpmh3v6l
 fiedd0XVVCWREBlG3bZzYwtZNKlgukMdhqsOEb9XRium46LZZrTy0EQWlx99KVwHi8e7udX6+lS
 XL4pYp3tiK4ZGbXzLRj2a76yojJXq5nTttEcjJZImNEOD1+jKiASncrFpdzyHbR+pySKkI9i+Pg
 ZIMp5PNiuPiesEuXysGaG7Lv909L72I7v1OdkfH+aoOpWmTPt5Lkw7TWLjN1Kbr1/xgnJtopm06
 r5XeY3I6//T7IEletQuAM2S0ZwJ6vhtD1nUJ0X6
X-Received: by 2002:a17:90b:2645:b0:3a0:c85a:ee12 with SMTP id
 98e67ed59e1d1-3a0c85aeef6mr2869753a91.41.1790499836635; 
 Sun, 27 Sep 2026 02:03:56 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:03:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 043/101] tcg: Generic expansion of tcg_gen_brcond_*
Date: Sun, 27 Sep 2026 01:59:13 -0700
Message-ID: <20260927090011.10724-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
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
 include/tcg/tcg-op-common.h  |  5 ++--
 include/tcg/tcg.h            |  1 +
 tcg/tcg-internal.h           |  3 +++
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 44 ++++++++++++++++++------------------
 5 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index fadbcbbcde2..e1dcd18bf0d 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -98,6 +98,8 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1, T2);
 #define DEF3(NAME, T1, T2, T3) \
     QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1, T2, T3);
+#define DEF4(NAME, T1, T2, T3, T4) \
+    QEMU_ARG_NONNULL void glue(glue(tcg_gen_,NAME),TExt)(T1, T2, T3, T4);
 
 #define TCGV  glue(TCGv,TExt)
 #define TExt  _i32
@@ -120,6 +122,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 #undef DEF1
 #undef DEF2
 #undef DEF3
+#undef DEF4
 
 /* 32 bit ops */
 
@@ -143,7 +146,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_brcond_i32(TCGCond cond, TCGv_i32 arg1, TCGv_i32 arg2, TCGLabel *);
 void tcg_gen_brcondi_i32(TCGCond cond, TCGv_i32 arg1, int32_t arg2, TCGLabel *);
 void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
                          TCGv_i32 arg1, TCGv_i32 arg2);
@@ -216,7 +218,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_brcond_i64(TCGCond cond, TCGv_i64 arg1, TCGv_i64 arg2, TCGLabel *);
 void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TCGLabel *);
 void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
                          TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 16ac528340a..077a1b37021 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -97,6 +97,7 @@ struct TCGLabelUse {
 };
 
 typedef struct TCGLabel TCGLabel;
+typedef struct TCGLabel *TCGLabelPtr;
 struct TCGLabel {
     bool present;
     bool has_value;
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 6b65228241e..cd481dfd27f 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -150,6 +150,8 @@ bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg_target_ulong imm);
     QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2);
 #define DEF3(NAME, T1, T2, T3) \
     QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2, T3);
+#define DEF4(NAME, T1, T2, T3, T4) \
+    QEMU_ARG_NONNULL void glue(tcg_gen_,NAME)(TCGType, T1, T2, T3, T4);
 
 #define TCGV  TCGTemp *
 #define TINT  int64_t
@@ -162,5 +164,6 @@ bool tcg_op_imm_match(TCGOpcode op, TCGType type, tcg_target_ulong imm);
 #undef DEF1
 #undef DEF2
 #undef DEF3
+#undef DEF4
 
 #endif /* TCG_INTERNAL_H */
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index fa33d41e3df..10ed0438fd5 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -6,6 +6,7 @@ DEF3(addi, TCGV, TCGV, TINT)
 DEF3(and, TCGV, TCGV, TCGV)
 DEF3(andi, TCGV, TCGV, TINT)
 DEF3(andc, TCGV, TCGV, TCGV)
+DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index aeac3480754..9a22791be0d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -307,10 +307,17 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
     void glue(glue(tcg_gen_,NAME),TExt)(T1 a, T2 b, T3 c)               \
     { tcg_gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b), glue(C_,T3)(c)); }
 
+#define DEF4(NAME, T1, T2, T3, T4)                                      \
+    void glue(glue(tcg_gen_,NAME),TExt)(T1 a, T2 b, T3 c, T4 d)         \
+    { tcg_gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b),              \
+                     glue(C_,T3)(c), glue(C_,T4)(d)); }
+
 #define C_TCGv_i32      tcgv_i32_temp
 #define C_TCGv_i64      tcgv_i64_temp
 #define C_int32_t
 #define C_int64_t
+#define C_TCGCond
+#define C_TCGLabelPtr
 
 #define TCGV  glue(TCGv,TExt)
 #define TExt  _i32
@@ -338,10 +345,13 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef C_TCGv_i64
 #undef C_int32_t
 #undef C_int64_t
+#undef C_TCGCond
+#undef C_TCGLabelPtr
 
 #undef DEF1
 #undef DEF2
 #undef DEF3
+#undef DEF4
 
 /*
  * Generic expansions for templated operations.
@@ -404,6 +414,18 @@ void tcg_gen_andc(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_brcond(TCGType type, TCGCond cond, TCGTemp *src1,
+                    TCGTemp *src2, TCGLabel *l)
+{
+    if (cond == TCG_COND_ALWAYS) {
+        tcg_gen_br(l);
+    } else if (cond != TCG_COND_NEVER) {
+        TCGOp *op = tcg_gen_op_ttii(INDEX_op_brcond, type,
+                                    src1, src2, cond, label_arg(l));
+        add_as_label_use(l, op);
+    }
+}
+
 void tcg_gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -663,17 +685,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_brcond_i32(TCGCond cond, TCGv_i32 arg1, TCGv_i32 arg2, TCGLabel *l)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_br(l);
-    } else if (cond != TCG_COND_NEVER) {
-        TCGOp *op = tcg_gen_op4ii_i32(INDEX_op_brcond,
-                                      arg1, arg2, cond, label_arg(l));
-        add_as_label_use(l, op);
-    }
-}
-
 void tcg_gen_brcondi_i32(TCGCond cond, TCGv_i32 arg1, int32_t arg2, TCGLabel *l)
 {
     if (cond == TCG_COND_ALWAYS) {
@@ -1473,17 +1484,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_brcond_i64(TCGCond cond, TCGv_i64 arg1, TCGv_i64 arg2, TCGLabel *l)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_br(l);
-    } else if (cond != TCG_COND_NEVER) {
-        TCGOp *op = tcg_gen_op4ii_i64(INDEX_op_brcond, arg1, arg2, cond,
-                                      label_arg(l));
-        add_as_label_use(l, op);
-    }
-}
-
 void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TCGLabel *l)
 {
     tcg_gen_brcond_i64(cond, arg1, tcg_constant_i64(arg2), l);
-- 
2.53.0


