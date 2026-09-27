Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE40FC98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkpY-0008Fn-Du; Sun, 27 Sep 2026 05:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkoI-0005Yf-3d
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:38 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkoG-0007iV-CP
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:37 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39b2ad83dc6so1441870a91.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499875; x=1791104675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H8T41gabBwsFE/qCroIgcfDi4e/REwzGERsP1YK8lCg=;
 b=jc+3Tm2i7g95fcccAf1JdAeDM+p4lhIrkalh3LKPId4wezsT8y4R7nmzway7iASXQC
 9MwnQRzOhLCYAAFRIiWJAejWYd+1gjh841yIVMAclU2sYRXn7hRoZVzrAWYtEyrDLJ/s
 2os3XY0hmgxwhgAL966wuisrn4uG3MSiW/hfIlE6q5AGS2LELcgej9B9tDPZe+Xv/A7P
 YftIM9Ut0l4emh4xNGCDyahL0sqCA5FUfohUrQNVmSFs4fUrTiQJzn84vt70e9Xp2Ffh
 1ahhdr1aiTjLRfB05IPkIHo6vaXof5fYA6zBd5Xz6oeUscf0hmsPdIn6tN8ObRnv2VtF
 +nDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499875; x=1791104675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=H8T41gabBwsFE/qCroIgcfDi4e/REwzGERsP1YK8lCg=;
 b=GNRZoxqP9NFiINI3W2HSAbj0eU1uNdPXDjpXxL0mDH/q2l0wg6oga/sEIy4IeeZt9h
 58gUz4DnDlyjoMJzf7j/UJG8SjmMEvh/MuE93PECVYUl7CiE0qpm/htyiCRNLlRBzyMV
 3tYIpOFOtDNkRhRXILr0RTh7q019ULN+tXF+A324X/I3qoOzD4rLUj/IKTEbuRlXtGDh
 0nu76EhMlczgcv1NzMA9kE29zhDXfDvUdSXALP31QUHnbm/DL1IuQ9oo9BfS2Dw330Tv
 clJEmVEJMdxxNgxVX1/SFGbv9TedqJiWN30lAoA7SzoHh1sixqrbYXl0GpM9RAC8MGIi
 qafw==
X-Gm-Message-State: AFq9FYLDy++cdcugpawjmV+8CwnvGwGt8iCdNjRSvwr24Pxe3pLkVLCG
 nin6i8XiQWFgb2FRkS6hFBQPCvKDIRrqc9xuopFeQhDIUEfUIXGqctTKTyG/ow5wwv/laUlRnJP
 FqVTn
X-Gm-Gg: AYBFou2nf7xybO3I7OnMHH+F2npnykDZqdN+dBY3EutwZq5L35ypyeQtEU5K1/8xvkN
 BOek+cBrZfzPaXYggjFZuaqoRACaysGOeXUK5f40A31Olkw55IjwTvL0H/utVNpVoQ6ixkNbrxf
 35xQPRjWfXd4XeJL4UAgaxacY1EOVBo3ib8rKAfmq9SwhvIEWur3tBxgZTUaFglevaphKMiWmKh
 umRKNVeDj1VJufuCSJVKGzviAE3j/KVtWfGAT5LqHYCJrHdbWBj4Rdschp477kovmNcI/5wFqbL
 Tx/pp/A6o0FPd2Wq5TlMscXSK3mBLlwm5534KV7uAfDwvpVvqomEmXInYpv4Ng0OTd+aKmj2RLW
 aYKFD8ln2j8Enoa/thhQc/8Bk5iZeibFevGyMGDNkZ91FvazMsGHDH5Gdon/oIa6dkkZhTV16i/
 oCDwiFbuwcHgofbuk2Q2KuMLxNesFcBefBFpJpuTP/V6f/o4FctEiQnJrCmuRU8/zfCVTD+rAp6
 4C6/iG1aS+++L+VAW0gTG3/RPEg6xCRQgYujrzf
X-Received: by 2002:a17:90b:3c87:b0:39e:4c7e:f040 with SMTP id
 98e67ed59e1d1-3a098b9e6f8mr8286741a91.29.1790499874668; 
 Sun, 27 Sep 2026 02:04:34 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.04.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:04:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 076/101] tcg: Generic expansion of tcg_gen_ussub_*
Date: Sun, 27 Sep 2026 01:59:46 -0700
Message-ID: <20260927090011.10724-77-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 29 +++++++++--------------------
 3 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 91acfefb1a1..040bdbd24a0 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,7 +146,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 
@@ -184,7 +183,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_ussub_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 19c6347fa7d..82dfc90009c 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -63,5 +63,6 @@ DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
 DEF3(umax, TCGV, TCGV, TCGV)
 DEF3(umin, TCGV, TCGV, TCGV)
+DEF3(ussub, TCGV, TCGV, TCGV)
 DEF3(xor, TCGV, TCGV, TCGV)
 DEF3(xori, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 67145b43d12..a1c1bfc8912 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1085,6 +1085,15 @@ void tcg_gen_umin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_ussub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+
+    tcg_gen_sub(type, tmp, src1, src2);
+    tcg_gen_movcond(type, TCG_COND_LTU, dst, src1, src2,
+                    tcg_constant_internal(type, 0), tmp);
+}
+
 void tcg_gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_xor, type, dst, src1, src2);
@@ -1382,16 +1391,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_ussub_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
-{
-    TCGv_i32 t = tcg_temp_ebb_new_i32();
-    TCGv_i32 z = tcg_constant_i32(0);
-
-    tcg_gen_sub_i32(t, a, b);
-    tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, z, t);
-    tcg_temp_free_i32(t);
-}
-
 void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i32(INDEX_op_ld8u, ret, arg2, offset);
@@ -1876,16 +1875,6 @@ void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_temp_free_i64(t2);
 }
 
-void tcg_gen_ussub_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
-{
-    TCGv_i64 t = tcg_temp_ebb_new_i64();
-    TCGv_i64 z = tcg_constant_i64(0);
-
-    tcg_gen_sub_i64(t, a, b);
-    tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, z, t);
-    tcg_temp_free_i64(t);
-}
-
 /* Size changing operations.  */
 
 void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
-- 
2.53.0


