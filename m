Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7835DC982C3
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pNg-0007NW-Jk; Wed, 16 Sep 2026 09:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNO-0006mD-Bn
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:40 -0400
Received: from mail-oo2-x2b.google.com ([2607:f8b0:4864:31::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNI-0001S0-GR
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:36 -0400
Received: by mail-oo2-x2b.google.com with SMTP id
 006d021491bc7-6bcc0c495efso568787eaf.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564110; x=1790168910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FtY+bgVSFFzjKOkjI2Q5lnBb7z/iX/hr0z1edTE2pa0=;
 b=vtSo5koVN9DPjo6nl0w61p4p+H2xB+CV+51uIJPPNrDmoXHenPqrD4jNJ0Kyq2a/iG
 yMn0ryRajIj8cTsUtcgqBC8V8DVA1x8a8UcyU8+sBB/451AXiR0PPhgVXcyHGF6R9KBh
 sdz2ad2T4tqtMQO8tjMRwK5Uvz57R6QNp8HW4bMA9lwg3xXvFUtQKad0Zl8DwCp0Vio6
 XENhcOfuDsxvLawnykfoW6izZFZIfe8FSzvubU1WiBJ1Dl8akersny7+zmmu0wf2xsRy
 eTfCp/yN8PbaiKX9d1raXT7xHT/jXbC5Dh79aX8F0tK0ZG0TmLSNLpR64eFgb0HUfLpq
 gGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564110; x=1790168910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FtY+bgVSFFzjKOkjI2Q5lnBb7z/iX/hr0z1edTE2pa0=;
 b=SvHkIXpET3Pi3d3C69Kv1EdKFQ0O3R1bCE9iG3YY2tlfc+SHTHUGLR1HEVOO5iZgDx
 VyZH43LzNxqsOG1aLwitjHFk923ypqG8MCPMSVs+vjCo6TUq6/UM77cd2S4jHAZzja1N
 xObWz8VbX0MsUaK564EnhknSYXzwG73cEHszCsKU51ZP//39RE7ghwAma7ZT00cgsh2n
 p7wg6OyLw7SfZY1DQpe2FVdlWYyIBA3BiDAE8uAfRjXXOMK3Kgajrv44YYrcwGUVsqBh
 eHiHA86CySvGsSfWRRsRCG+VNo3iDI5AmeQjKOHK0uR0hf78HltQFn1rJbA6IiE06Ap0
 BxPw==
X-Gm-Message-State: AFuF++mxto7EjlriDTospIKGNhOisb5+FU/LGZ8ZxR8zzaHoBvLIxHwh
 hNkMuAK+1BX01UYwsr/XzrCgH+b7yEJ56ffGmVlch97MMwskHs0GBsTYRlpnu/3pYEtOaabaJjt
 oT9eD+nw=
X-Gm-Gg: AYBFou32pshPB08qGj3JV87XTzDNwClD2m/UvnHUTCNUB8qFZ+uxAR/RiXzFZ+3kEqj
 dZnh6she/y9cispLYyFzGKihGzAeIV97P2SjWfTAm9Km0leex0ey9q7TU7b/J9GGhV924A9HZBN
 jP1ZlJY0phIQm56BI6cmiDfKETZ/+UvFoXJPa3rDnEUjr9HoRLlSATBArrXgV8058MOKhydet3W
 VAF4Suvexnh45lEUnh9UadnJpW0ipFKEknLrtJeuROoh0D5WdNHWjai7QpAX5Y9Acq4/XuAZIuL
 s6eHbz6bTVRC0IBBhtpwc8d6pwhIJ+MsDZPw0K6Mm0H3n9yQoEa8pTXxjjM5rj2TYkOMhXeQwww
 sbf6u/w5TMErKcp5QVoGMWv5RKZ5lp0pg06swcaWhqYFHaDE91SKWeBZ31fG/XLgpIywbsZILj3
 fJolrXXKogx+jIJa9sBEfsRvOk903OReEPxj4sJtnm809lWFK4Hvpgq5MR9Z6wXmHKIN1kee/ck
 +ml7tQ=
X-Received: by 2002:a4a:ee0c:0:b0:6b7:8415:d78b with SMTP id
 006d021491bc7-6c7d3206a47mr2632915eaf.54.1789564109854; 
 Wed, 16 Sep 2026 06:08:29 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 56/92] tcg: Generic expansion of tcg_gen_ctzi_*
Date: Wed, 16 Sep 2026 03:03:31 -1000
Message-ID: <20260916130409.3382710-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x2b.google.com
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
 tcg/tcg-op.c                 | 46 ++++++++++--------------------------
 3 files changed, 13 insertions(+), 36 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 1f31253263e..96a8ba3026e 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -129,7 +129,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -186,7 +185,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 47627a343d3..9968ca9516f 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -11,6 +11,7 @@ DEF3(clz, TCGV, TCGV, TCGV)
 DEF3(clzi, TCGV, TCGV, TINT)
 DEF2(ctpop, TCGV, TCGV)
 DEF3(ctz, TCGV, TCGV, TCGV)
+DEF3(ctzi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 0f617a3099d..00f6e7983e8 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -547,6 +547,7 @@ static void gen_ctpop(TCGType type, TCGTemp *dst, TCGTemp *src)
 static void gen_ctz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     TCGTemp *t1, *t2;
+    int width = tcg_type_size(type) * 8;
 
     if (tcg_op_supported(INDEX_op_ctz, type, 0)) {
         gen_op_ttt(INDEX_op_ctz, type, dst, src1, src2);
@@ -556,10 +557,14 @@ static void gen_ctz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
         t1 = tcg_temp_new_internal(type, TEMP_EBB);
         gen_addi(type, t1, src1, -1);
         gen_andc(type, t1, t1, src1);
+        if (src2->kind == TEMP_CONST && src2->val == width) {
+            /* No fixup required. */
+            gen_ctpop(type, dst, t1);
+            tcg_temp_free_internal(t1);
+            return;
+        }
         gen_ctpop(type, t1, t1);
     } else if (tcg_op_supported(INDEX_op_clz, type, 0)) {
-        int width = tcg_type_size(type) * 8;
-
         t1 = tcg_temp_new_internal(type, TEMP_EBB);
         gen_neg(type, t1, src1);
         gen_and(type, t1, t1, src1);
@@ -592,6 +597,11 @@ static void gen_ctz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_temp_free_internal(t1);
 }
 
+static void gen_ctzi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    gen_ctz(type, dst, src1, tcg_constant_internal(type, src2));
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -924,22 +934,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    if (arg2 == 32
-        && !tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I32, 0)
-        && tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_REG, 0)) {
-        /* This equivalence has the advantage of not requiring a fixup.  */
-        TCGv_i32 t = tcg_temp_ebb_new_i32();
-        tcg_gen_subi_i32(t, arg1, 1);
-        tcg_gen_andc_i32(t, t, arg1);
-        tcg_gen_ctpop_i32(ret, t);
-        tcg_temp_free_i32(t);
-    } else {
-        tcg_gen_ctz_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_REG, 0)) {
@@ -1785,22 +1779,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    if (arg2 == 64
-        && !tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I64, 0)
-        && tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
-        /* This equivalence has the advantage of not requiring a fixup.  */
-        TCGv_i64 t = tcg_temp_ebb_new_i64();
-        tcg_gen_subi_i64(t, arg1, 1);
-        tcg_gen_andc_i64(t, t, arg1);
-        tcg_gen_ctpop_i64(ret, t);
-        tcg_temp_free_i64(t);
-    } else {
-        tcg_gen_ctz_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
-- 
2.53.0


