Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0A5606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uPZEpgkT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsa3-0007XQ-5b; Sun, 25 Oct 2026 03:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZq-0006gU-EH
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:37 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZn-00048f-HK
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:34 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a2d6d01ecbso7637835e9.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913009; x=1793517809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hXRSH0RDDbBsl0pK+kAEWu1B7P5/4HD6kBtGLr7fyPg=;
 b=uPZEpgkTh4ZBlV9b92/2rKvZGK7KiRYVhJqCfKoVTF7JEdLZOFKgICw9brMA0YMWRb
 Fatb/qy2lrvRaNXP0se/Okf2og5PvDMAYSf7vUOzZrYoChkNOvnyPMX9kEthJymzrZM9
 mPNNpWRKKjtrWxa5V9kb7p64MTM4iZbr0ptIYobRFUmshGht8oHhXcPi+if/MGZ218U7
 qQP+HPdzHqcjqedEyov/4StnYZpDH+pjXVZimA5AlGT9jDin+EZCJrvH/si8qzbTwN/z
 NaF0xUf9p1GVZVjyv2bq+efFP/rgTVUyU9GMlpskIK27GajWEHlQX7g9IyB7C0yMDSoH
 F9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913009; x=1793517809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hXRSH0RDDbBsl0pK+kAEWu1B7P5/4HD6kBtGLr7fyPg=;
 b=EABOhur5qFnXifXxKiOsuPOJZ1l7Pv6Fyg5oV+6uD4I5qMBkgEMPkWTEwJBD7Ts91g
 jTLk+zBARbnrU3qcxgCyWUtJZpXnkimvC79YqFflUSb/zQUPecZ+XYFTh0K2zK+bRtqN
 c31QfRfGCVlzoU4XLrRoc+cxL6733HpfHZFY+1n7GoWHEV4p8RPgdqaDoQkjXuHUjBcS
 xh1EsWC6+6uyPweCmNhZKc4k5/1F2ezg/MC15M/WBjJXKlJGdZRxytr+RNAnchKhsBN9
 BoFlf4gyXktb0XsCTc18UqZXCmnxEiEPELMUI4UByiwuXaXycHbjgzBSEiz+X06MiWjH
 3O/Q==
X-Gm-Message-State: AFq9FYKmvweUEIUwfkYn4reKkRQ527FoduQORS0FcnURE6IJShj8mkUw
 OZaiZ2TBXQJk2pfLYpjzwn/wAAunW3ju832fYzLJIikl8QTHWujq66Rx7O1xs7fOuc+pgPjOAC0
 FV1S1VcM=
X-Gm-Gg: AYBFou24ZqJwlyXcwd7T9CPZVovOiaX/LnIpc9xyW0Y/4/2kLNQfSp6wBcwgW6bi5cc
 hx0No1ILW1CdvIwp2Niyyw4CAoiOxbLa6Qw2pTaVi0/QAbvI7gqu4YEnlB5HnU8019/VWtt2aaL
 TV41hDz/wS4bpm94UUknE45489OzpTjU/Gcxv+Z3UvZzvy0sU2XHRtJHgBBQOw0jVfgAMc+GUKT
 cKXxWosP39svyJAXOp8/cjtRMxnIGODTUe4JCDD5Oqoa7fq4+ci9JRJQgiJkZvvYia5TTxxYK0Q
 RsMQpB+d9cQrxggFksT8xr4vV90Fm4H3BQkXSoYsQ0U+dLglp2nuVwSzD4oaZSOfDwjl0CloelT
 YSR9UtZL6exSd9JOpggEGN9UJcDlXRHL8GdH0KaWsv+wCC2VkF7fSg/y3yTy9kV1ERxGML3gYdf
 kLD2QhB0e3Kx5DkqmnDqLnM/NSlsi1gsEhQIrtIQhOjnKLbPk9DB5W+8EgUKaUzmrUMUeT2LFEm
 9JSXiaMhrY676FgL0SugQoKbJPsnMITIuS+5uuj2N157WVrYGWC1MMKcGs=
X-Received: by 2002:a05:600c:34c9:b0:4a1:f625:2108 with SMTP id
 5b1f17b1804b1-4a35acebc28mr57312495e9.33.1792913009285; 
 Sun, 25 Oct 2026 00:23:29 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 069/100] tcg: Generic expansion of tcg_gen_ext_*
Date: Sun, 25 Oct 2026 08:18:44 +0100
Message-ID: <20261025071915.1123867-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move from tcg-op-ldst.c and compute the width of the
extract instead of using a switch.

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op-ldst.c            | 54 ------------------------------------
 tcg/tcg-op.c                 | 13 +++++++++
 4 files changed, 14 insertions(+), 56 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 3af56710cb..911b94f9c4 100644
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
index 6208a51f53..f9812c1f88 100644
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
index 22211ccb45..031c5ce926 100644
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
index 3c34f503e7..11676eff30 100644
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
@@ -599,6 +601,17 @@ void tcg_gen_eqv(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
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


