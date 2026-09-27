Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B699FC98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:11:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAksp-0001lA-W1; Sun, 27 Sep 2026 05:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrJ-00026x-8y
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:07:49 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrH-0008Fa-99
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:07:44 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39b2ad83dc6so1442580a91.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790500061; x=1791104861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Zz2ZYDhFh1/+MTpRAJxkmZ5x0WPyVxB0ucW71kVadow=;
 b=JXDeeWZOXvKfbV5+F2Xwt2r8cq3JMV9Pr+dEI5j3UuH8rdDm019XnKR4yCt2+1Sr/B
 uFiN57YFFZG49PYXOz0hWkM5sSbwKldGvh38338KcQtruLckFgYw8QbXKMkUp6EtwMaF
 sRLAH0vZ0qT2uNhZ3J/n4OYjMX6xbtSBHDNhxPJ1FT76giD+6bOf9Ygm9BRuna3k/ezy
 CyAZzEWzHIOpD4unJxtRhyzPvPfQa0S842FZ8fjyn+cE/Wi6ID5T+5tTt4jPdvxYE4j0
 P23MRyiTwfR2PlmGrz35uKWKzMF/VL3nM0gf1hBWC4rZNwAPgYvuveo8moar2zlzX79l
 7DHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790500061; x=1791104861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Zz2ZYDhFh1/+MTpRAJxkmZ5x0WPyVxB0ucW71kVadow=;
 b=w2kw8Ec3/elXu6Y5i28D0YhTzVKmH8+1bMt/R4ppmdMtbkymkqJJ29nI3C2BVHRyG/
 VnqlSL0RJdAkkOnp1VI9MvZDjCs9OBETAacw8bRkTi40otzeXvHRw7JSnhtgQGHy+1S9
 SV/H8Kq3vd6f68V3Rrdq5bEvm0/ZZ3z9v3dPJg59hzF1+BBldDaiGsCdB3aISy+H47fj
 s5ERr8LZyUJ2NY4hLMfTySenED+/XPjJvwwqwnObkZbvGm8c5AHQjLo1VQ8yiTNX6+oz
 PsZwX1Ei5gxV+vljT1k72u/BPFJs+1z+CqQcsI7FZ113prLTBH2o8KHuhAY4tiQ1t1Cy
 KRHQ==
X-Gm-Message-State: AFq9FYKrF+cfRYWYPTXmjPJG7V4DEmjLJltbzbmxLDFFb0dLjk2r65rb
 o9vIJxgEVhsT1avNrn2tJLez0T0c/8hh5m/22Kgjw7Fj22Weu4kruicp0b3U8dQZWjRKVAqFmQZ
 p99Y8
X-Gm-Gg: AYBFou3ipwr5X4IOghIs8xIVwjQC6kELTLhEUV+pxNbNM/CxSMb308lq5AoL2Pgd2LV
 zn/Jr2U2TRA4P1KhbToeLDIdg6fgQIUv4Eijl3C3rb9D0IRFNYExEQe0wW+tGbAvjo/rLNHKPvB
 tjZn34GmHBYi6XDccvMIlhKR6GDstRJwZUtP4Yst/vlUQl7a+oOBI88H/aaXOQd6np+fmsVsftn
 btDejQxBTBx5PWz75lGSZsz9ClW9Dhhm9dwx8ZASP0VYYCqNU1cab/BNleaKHECQnrhv+JrEY2Y
 h6vUvL8L/K1S3Dww/SncmnlkBZ6NvOh0jh79eFSVFqcCSM2ky+iZ8oGJrE3x/F599H34dQ7pn8V
 KCrGFBciLAyDoRmtzFt5lPXC+oI7imppfiaVNkvU4xmUWqG38wiwFt9Q5eGBB5BdoXQmNIQfKL3
 XJGMeWlefdcnx+BZiy0ArE2S1UBYScflyOhUDCNqnVv4qgdvE2c/i0lsCY5snDwy+ik4fzCmDjB
 ETsQuBVYduV18AT22GHhwjypoAkfg==
X-Received: by 2002:a17:90b:1c92:b0:39e:6c68:c77d with SMTP id
 98e67ed59e1d1-3a098e0515cmr9335860a91.51.1790500060727; 
 Sun, 27 Sep 2026 02:07:40 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e7036e3bsm7144984a91.13.2026.09.27.02.07.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:07:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 081/101] tcg: Generic expansion of tcg_gen_sub2_*
Date: Sun, 27 Sep 2026 01:59:51 -0700
Message-ID: <20260927090011.10724-82-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  4 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 64 +++++++++++-------------------------
 3 files changed, 20 insertions(+), 49 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 0a1ff0c5b19..267ef111ae3 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -132,8 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
-                      TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -158,8 +156,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
-                      TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index e9f0b971a2b..14bdabb2f15 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -63,6 +63,7 @@ DEF3(smax, TCGV, TCGV, TCGV)
 DEF3(smin, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
+DEF6(sub2, TCGV, TCGV, TCGV, TCGV, TCGV, TCGV)
 DEF3(subfi, TCGV, TINT, TCGV)
 DEF3(umax, TCGV, TCGV, TCGV)
 DEF3(umin, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 0f478e65861..7b8e158c2e4 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1103,6 +1103,25 @@ void tcg_gen_subi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     tcg_gen_addi(type, dst, src1, -src2);
 }
 
+void tcg_gen_sub2(TCGType type, TCGTemp *rl, TCGTemp *rh, TCGTemp *al,
+                     TCGTemp *ah, TCGTemp *bl, TCGTemp *bh)
+{
+    g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(type);
+
+    if (tcg_op_supported(INDEX_op_subbi, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_subbo, type, t0, al, bl);
+        tcg_gen_op_ttt(INDEX_op_subbi, type, rh, ah, bh);
+    } else {
+        g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(type);
+
+        tcg_gen_sub(type, t0, al, bl);
+        tcg_gen_setcond(type, TCG_COND_LTU, t1, al, bl);
+        tcg_gen_sub(type, rh, ah, bh);
+        tcg_gen_sub(type, rh, rh, t1);
+    }
+    tcg_gen_mov(type, rl, t0);
+}
+
 void tcg_gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
 {
     if (src1 == 0) {
@@ -1167,28 +1186,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
-                      TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
-{
-    if (tcg_op_supported(INDEX_op_subbi, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_subbo, t0, al, bl);
-        tcg_gen_op3_i32(INDEX_op_subbi, rh, ah, bh);
-        tcg_gen_mov_i32(rl, t0);
-        tcg_temp_free_i32(t0);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-        tcg_gen_sub_i32(t0, al, bl);
-        tcg_gen_setcond_i32(TCG_COND_LTU, t1, al, bl);
-        tcg_gen_sub_i32(rh, ah, bh);
-        tcg_gen_sub_i32(rh, rh, t1);
-        tcg_gen_mov_i32(rl, t0);
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-    }
-}
-
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I32, 0)) {
@@ -1696,29 +1693,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b)
     }
 }
 
-void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
-                      TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
-{
-    if (tcg_op_supported(INDEX_op_subbi, TCG_TYPE_REG, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-
-        tcg_gen_op3_i64(INDEX_op_subbo, t0, al, bl);
-        tcg_gen_op3_i64(INDEX_op_subbi, rh, ah, bh);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_sub_i64(t0, al, bl);
-        tcg_gen_setcond_i64(TCG_COND_LTU, t1, al, bl);
-        tcg_gen_sub_i64(rh, ah, bh);
-        tcg_gen_sub_i64(rh, rh, t1);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I64, 0)) {
-- 
2.53.0


