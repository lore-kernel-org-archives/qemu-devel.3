Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1160AC9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkpG-0007j4-Mh; Sun, 27 Sep 2026 05:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkoD-0005KD-3j
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:34 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkoA-0007gg-9i
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:32 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccafb751so1006364a91.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499869; x=1791104669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hLP+TtjTkdi7sz278ozLee5pzfxzJnjdaZIPG+YeIww=;
 b=WPLMlN8VjmbIP6GfY8Ka6XgwDwQX2JZHNO7lPtsTOMvLJD2QJ31e4u4hIGcLplCbR4
 /NPGsOAXc3Q5E8KtabC7zZsalhKJ5V5XfXXBbTuJNhhahnTpv3K9FGdeGFksijbZln2H
 4DwmenHF+WubCSrUvfs0yORcgyglFSV5KN4bxh2zdFb+6ILCUntnjInhIWDlQ6nPUQIW
 90GunZffNdK8cRKmowrfvAgb1ooXHWS5rVhXi1oq1b55OXSMH0MG0aCRPkNfLNVQf5W+
 tFcZDIrDsPBqXrpuiKHsj2eOteqkqRNcmHUR76Du4Vyjq4a+g5H13xuxASyDvpL2cWvY
 tceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499869; x=1791104669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hLP+TtjTkdi7sz278ozLee5pzfxzJnjdaZIPG+YeIww=;
 b=FEsQmAb0qjzJ8mSUgcQ5eUbGCC3aBWCXNvGAE0lzcatE4kJBHUZvD9pk42eewhTLcq
 Sa8b/9BDSTYQ+19CZDOM0sPGrhqD0+0L4fokNj7VpePu79X1yoO6uUZnA1XyqGFBm/GP
 Ep/I6K0a8mRlTylZ+GrMunnt87emWKL2CNX7cIc+oXBoejuRgrMoBrQ6r0hRrimNr1xd
 eB/rLlhpkkowg0e9X6VtoJnhJ8g30Ws9kd9tMRiyofv5Puh+XNI2+7ebpfk620GYiVdO
 RzURJYmFeC1KOUsVrx5CzIsxnx418D+w+r7RYBD6Lz/fPQ1xSHfy5GIfiWLKjVG60ciL
 zDKQ==
X-Gm-Message-State: AFq9FYJVbFUI1Dj1tsrM6/LydPjZQnWXN1g2w1JnJ0mAV5RM/jARdWiL
 og7T561xXQqrmn9JiD/wQCx3gcRLh/5dn+WJUo7AYD8dmH3UeZ1941FtXcj/tVJThpMrPICnA8S
 fCerm
X-Gm-Gg: AYBFou2gbyaVP2MyKsgXHMvNGAsoTfcZdElg0K5Gzv0vNK+Jlt5Lsof2CX5gZtV6sdy
 LdSd+XZgHfTqrjOY2jDlcPXUseCAs7uMmEdUtXSebqmeNdG3rPPJq1IXN5L0tsWZt6J57BGtQUR
 2qRSJ28mNHnKCvUE05UmL587udzdYMjJpoKuL0eMky0Yy/XBtFuf4tPITdYUhekhtOwKfJeX/Lp
 +WnXfNqaq18IhdozuvgqbBXTuHG7jZa0TfJiZacani2e84EuHXXDvHi9qYAlNMROIq08eJkvMTA
 bGBKfktUmXqvfJi/D3B/skJkcrSg0lXwM+ip0HNbaA/NKKPjUlxk+wBSe5QQhFJStggVbigPSpH
 0DrY51vFE+ksgAxT5G7SFiE6O/SOI8aHE1uIstVCXgaMIsljSeH39Yh0vXrRIFIJ97kPuc/Yo82
 YM459qi6Xno+Rpqoujni3oNIDOLfNUdAkTm6KeTPEyqYb7riV8La7OUmSCNb0OEmwjc5jQusNrE
 gvilv6dursquwvDOsBKaTa3xnoAmg==
X-Received: by 2002:a17:90b:2ecb:b0:3a0:f036:5a13 with SMTP id
 98e67ed59e1d1-3a0f0366a44mr1769425a91.30.1790499868574; 
 Sun, 27 Sep 2026 02:04:28 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:04:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 070/101] tcg: Generic expansion of tcg_gen_ext_*
Date: Sun, 27 Sep 2026 01:59:40 -0700
Message-ID: <20260927090011.10724-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
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

Move from tcg-op-ldst.c and compute the width of the
extract instead of using a switch.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op-ldst.c            | 54 ------------------------------------
 tcg/tcg-op.c                 | 13 +++++++++
 4 files changed, 14 insertions(+), 56 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 2878701b105..383cd093863 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -143,7 +143,6 @@ void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -185,7 +184,6 @@ void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_ext_i64(TCGv_i64 ret, TCGv_i64 val, MemOp opc);
 void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 6208a51f536..f9812c1f882 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -19,6 +19,7 @@ DEF4(deposit_z, TCGV, TCGV, unsigned, unsigned)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
+DEF3(ext, TCGV, TCGV, MemOp)
 DEF2(ext8s, TCGV, TCGV)
 DEF2(ext8u, TCGV, TCGV)
 DEF2(ext16s, TCGV, TCGV)
diff --git a/tcg/tcg-op-ldst.c b/tcg/tcg-op-ldst.c
index 22211ccb452..031c5ce926b 100644
--- a/tcg/tcg-op-ldst.c
+++ b/tcg/tcg-op-ldst.c
@@ -760,60 +760,6 @@ void tcg_gen_qemu_st_i128_chk(TCGv_i128 val, TCGTemp *addr, TCGArg idx,
     tcg_gen_qemu_st_i128_int(val, addr, idx, memop);
 }
 
-void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc)
-{
-    switch (opc & MO_SSIZE) {
-    case MO_SB:
-        tcg_gen_ext8s_i32(ret, val);
-        break;
-    case MO_UB:
-        tcg_gen_ext8u_i32(ret, val);
-        break;
-    case MO_SW:
-        tcg_gen_ext16s_i32(ret, val);
-        break;
-    case MO_UW:
-        tcg_gen_ext16u_i32(ret, val);
-        break;
-    case MO_UL:
-    case MO_SL:
-        tcg_gen_mov_i32(ret, val);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
-void tcg_gen_ext_i64(TCGv_i64 ret, TCGv_i64 val, MemOp opc)
-{
-    switch (opc & MO_SSIZE) {
-    case MO_SB:
-        tcg_gen_ext8s_i64(ret, val);
-        break;
-    case MO_UB:
-        tcg_gen_ext8u_i64(ret, val);
-        break;
-    case MO_SW:
-        tcg_gen_ext16s_i64(ret, val);
-        break;
-    case MO_UW:
-        tcg_gen_ext16u_i64(ret, val);
-        break;
-    case MO_SL:
-        tcg_gen_ext32s_i64(ret, val);
-        break;
-    case MO_UL:
-        tcg_gen_ext32u_i64(ret, val);
-        break;
-    case MO_UQ:
-    case MO_SQ:
-        tcg_gen_mov_i64(ret, val);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 typedef void (*gen_atomic_cx_i32)(TCGv_i32, TCGv_env, TCGv_i64,
                                   TCGv_i32, TCGv_i32, TCGv_i32);
 typedef void (*gen_atomic_cx_i64)(TCGv_i64, TCGv_env, TCGv_i64,
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 362eec23f76..96675ef77b0 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -282,6 +282,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #define C_TCGv_i64      tcgv_i64_temp
 #define C_int32_t
 #define C_int64_t
+#define C_MemOp
 #define C_TCGCond
 #define C_TCGLabelPtr
 #define C_unsigned
@@ -312,6 +313,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef C_TCGv_i64
 #undef C_int32_t
 #undef C_int64_t
+#undef C_MemOp
 #undef C_TCGCond
 #undef C_TCGLabelPtr
 #undef C_unsigned
@@ -600,6 +602,17 @@ void tcg_gen_eqv(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_ext(TCGType type, TCGTemp *dst, TCGTemp *src, MemOp mop)
+{
+    unsigned width = memop_size(mop) * 8;
+
+    if (mop & MO_SIGN) {
+        tcg_gen_sextract(type, dst, src, 0, width);
+    } else {
+        tcg_gen_extract(type, dst, src, 0, width);
+    }
+}
+
 void tcg_gen_ext8s(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     tcg_gen_sextract(type, dst, src, 0, 8);
-- 
2.53.0


