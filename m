Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC304C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73rg-0005lS-FA; Thu, 17 Sep 2026 00:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73r4-00048r-8u
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:36:16 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73r2-0007yT-FW
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:36:13 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc4c08393b0so336077a12.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619771; x=1790224571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0EMgWlSGdn2kbxieErkqcHE7QNb7o5bu+ZeG+Og1EMQ=;
 b=K+3Xr/sd4XBXKhtr8EQkp9k7g13gyS7ZbA5ct9EV8QlZM2TOM1dMTy4/GAktulRPLt
 oEfn9cx3NR+WJtTqjAtaInEr5qDFlRlTbKssIesXoisO2tb6f193BjctH899wF5CHrQq
 1FUmQw+YY/Wi1LJ4S0BELwAYzJaHdhqXBEDXXcBAsVggFyaCU+JQPlAjcoJxsJoHCFSQ
 +jhR0/R/tA92VAbMQIvXyHd2tdbeNH4t2PSEM5vzA+vYxRkI9YJc+FtE53oSZM1TzOFs
 zT/X3/FlEf7XeEBZmUm1AnNJzjpdUBfCU9Fz+9dtboEbx5HPHhPyUGRGL3YHWGKzEhKH
 Y/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619771; x=1790224571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0EMgWlSGdn2kbxieErkqcHE7QNb7o5bu+ZeG+Og1EMQ=;
 b=i3qfHY5R5tvQMV1taHGkrV7jbEkalVdwLmQMtnHC7Zdo2iJI7MTMmlQpMWbJnP2bky
 QYZBzqgX9p2nef8HbLjrn0Han+HjjwPFZFzU5N0vb8kcCkja2dOHLNSY1IimwXF7nSXx
 glUOuwfJzjrLKkmi+ceodJTqk3Flkgx6Uk/mhqwA/6JX9VnvqRLMIN3xPKwlaWu3/dvn
 apui7TpDYKanuyOfnkg/nbbKz0BWT5TwE12C9ZSlENRw9DzIR3QEgqZR93eoSFwNXGvX
 kR1rfpebdfbVllkMzOErUPZOJRCVsQgpzT1pFMQLCSob8aQ4YrPNUbz+cRSUH6NEA800
 Ocqg==
X-Gm-Message-State: AFuF++lsrsTzNW2I6OEY6OCmd6zVzeUjU0NaGDUBRo2swbWW+RmLmVOG
 2HNKja4YKBoveqQGpwab53iPACgQA/oRiVuKs9IBuNiyRQ/lyVHd/FaK7tLduZ6Z+98cthz0hMS
 4/44hDak=
X-Gm-Gg: AYBFou2JR5dQbLc839tc3t51t6JEUsBQBN+PbrXI1C1G6xpxLhI2h3qGuxFd/9mT/1E
 Yqux+5t2RDbYdSplRJqeL+xVyoJG9DgZ1TNsCph63tkF7t1HUiP9fjyzK4HZySXN5tG8naIUq4E
 TepF6sLRLyLnVxnadr0xMHtjL55eKaSQsKYHrICoZAV+A/YmLQX+7f/0wTQQVc8r2cJXOUEdiqL
 uYU8ekf556Vxn/B301cby+r/i+xB3qNiKhUav2oIHxJXf/rWeJMRYEGlj6v9DBuOLnDwl3hK1WL
 WovoPTn2sXQ+vwKwPAbsCCEFYDs42MTh8hOz9Z2rrhGA9S3yMVk/iCv4Y8VTVQXyhY7seId2C/G
 zmNBc+ouOzxSce02p8NtzIHMCapBIRv2AVNPL/+UiDKykKxu3Zk/IcmbXPmQvTWIu+lIhYHwSe+
 Ea/pAwxd53PK1CjM5QQciaMcLrW36I6v9J7l34q/Vr+20o1W4cjE49xxAQhGaQIDH7Vu7bxp8bK
 1zjFeCnESyTAN9bGg==
X-Received: by 2002:a05:6300:614a:b0:3d1:8876:fb1e with SMTP id
 adf61e73a8af0-3dd5f06f373mr13058299637.0.1789619770887; 
 Wed, 16 Sep 2026 21:36:10 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13ee7sm10764267c88.8.2026.09.16.21.36.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:36:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 099/101] tcg: Generic expansion of tcg_gen_dup_*
Date: Wed, 16 Sep 2026 18:28:21 -1000
Message-ID: <20260917042823.542588-100-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  6 ------
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op-gvec.c            | 41 ------------------------------------
 tcg/tcg-op.c                 | 16 ++++++++++++++
 4 files changed, 17 insertions(+), 47 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 604ead6b5ed..26431e71bcd 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -137,9 +137,6 @@ void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 
-/* Replicate a value of size @vece from @in to all the lanes in @out */
-void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
-
 /* 64 bit ops */
 
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
@@ -153,9 +150,6 @@ void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
 
-/* Replicate a value of size @vece from @in to all the lanes in @out */
-void tcg_gen_dup_i64(unsigned vece, TCGv_i64 out, TCGv_i64 in);
-
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 5657636fa2a..4d121470bec 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -22,6 +22,7 @@ DEF4(deposit_z, TCGV, TCGV, unsigned, unsigned)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
+DEF3(dup, unsigned, TCGV, TCGV)
 DEF3(ext, TCGV, TCGV, MemOp)
 DEF2(ext8s, TCGV, TCGV)
 DEF2(ext8u, TCGV, TCGV)
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 27f3807b004..0fec60a5cf3 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -426,47 +426,6 @@ uint64_t (dup_const)(unsigned vece, uint64_t c)
     }
 }
 
-/* Duplicate IN into OUT as per VECE.  */
-void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in)
-{
-    switch (vece) {
-    case MO_8:
-        tcg_gen_ext8u_i32(out, in);
-        tcg_gen_muli_i32(out, out, 0x01010101);
-        break;
-    case MO_16:
-        tcg_gen_deposit_i32(out, in, in, 16, 16);
-        break;
-    case MO_32:
-        tcg_gen_mov_i32(out, in);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
-void tcg_gen_dup_i64(unsigned vece, TCGv_i64 out, TCGv_i64 in)
-{
-    switch (vece) {
-    case MO_8:
-        tcg_gen_ext8u_i64(out, in);
-        tcg_gen_muli_i64(out, out, 0x0101010101010101ull);
-        break;
-    case MO_16:
-        tcg_gen_ext16u_i64(out, in);
-        tcg_gen_muli_i64(out, out, 0x0001000100010001ull);
-        break;
-    case MO_32:
-        tcg_gen_deposit_i64(out, in, in, 32, 32);
-        break;
-    case MO_64:
-        tcg_gen_mov_i64(out, in);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 /* Select a supported vector type for implementing an operation on SIZE
  * bytes.  If OP is 0, assume that the real operation to be performed is
  * required by all backends.  Otherwise, make sure than OP can be performed
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 9317c9ca792..0c27c45021a 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -761,6 +761,22 @@ static void gen_divu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_dup(TCGType type, unsigned vece, TCGTemp *dst, TCGTemp *src)
+{
+    unsigned t_width = tcg_type_size(type) * 8;
+    unsigned e_width = memop_size(vece) * 8;
+
+    tcg_debug_assert(e_width <= t_width);
+    if (t_width == e_width) {
+        gen_mov(type, dst, src);
+    } else if (t_width == e_width * 2) {
+        gen_deposit(type, dst, src, src, e_width, e_width);
+    } else {
+        gen_extract(type, dst, src, 0, e_width);
+        gen_muli(type, dst, dst, ~0ull / MAKE_64BIT_MASK(0, e_width));
+    }
+}
+
 static void gen_eqv(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_eqv, type, 0)) {
-- 
2.53.0


