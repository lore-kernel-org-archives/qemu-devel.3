Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE46606A32C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zUp6PoA8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXGP-0005ke-Ed; Wed, 21 Oct 2026 10:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDU-0001ec-42
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:56 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDO-0002BV-Pf
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:55 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48e0d1da913so700247f8f.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592568; x=1793197368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gGT1l3v2h6cW/bqBv+HDwYvnQNUJnJpHzeHCosnxsiA=;
 b=zUp6PoA8gheVF6arfF0yuDnFevdIYLBRLWyAmMAGHN8Qfb4dTluX2WCskcC7qt3nVX
 T0+ZTvTc4AWsHiAC7O56tQkOYuBWBRx4CwAjUnQD5DRn4qUB4C5sNdY85xoZReOvTl5C
 UlAWwLl3x2A/LdQW9BE3VDsf8oQ3KW8UH1/ByDSAdf30BnmNx265MGEOekc1odnzTPPz
 4fVTdswTVrluNti6UYg8//qUghNe/4gBq5dbcYjja9H+F9IO33cSb5zNuL3dxs5TOClZ
 tqlDq/odjqv25C9oKFB/5jOKPAcoNHYe08ivUzLc4EV09R6LcFq4p5WIHYy+nKA/Ym05
 E0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592568; x=1793197368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gGT1l3v2h6cW/bqBv+HDwYvnQNUJnJpHzeHCosnxsiA=;
 b=tw1PdNsmnhmcrTh1WgdfR5qp8HVORThRURJm72nvhd/IikfjkuKDb3NGwBDdbj86M4
 SkVwYT5iUMdlxMQlrhve8GTlU+WxS+NC5uOSvP2TnenCNDO+VK/0jRLX0SwtnfQWUiL+
 x6kK7HWaEixCztc7qja55vu3od/OkJ8L4mDdQhspI9Adk/HR20jBvfdbAIo5pwUpwBWR
 4o3wiIyeIQbTOOJfpKBGZEEPYCSE1PbSbecAaB/CxZjmxsQlWcXxiDFs2Fp1SWWub2jb
 M5SsZPT73/UK/IY83o+X820NIDzkKqJQVwLchSatw6NWxmvFFKKHgHvTqcC0dA9+gtXR
 tYog==
X-Gm-Message-State: AFq9FYKia8lrv84yOaP6+pT6I9O+unazKgZYw8QXMWC28nD0Q+fIGoas
 mCqdUJIUqwaUYS880sgRpzPzAvIXPQcaSIjE+dXdmn8l1TT/MfeSnxBNrVtcxiwmOIn/hznW4D/
 DJPi4usw=
X-Gm-Gg: AYBFou009PBNNmilpxhQD+bwRF5eUMdcrTZuCeD8whdX6PoPfVsbR7XBXARS6/ffn/5
 Uhg2UL2bzqOM1k8pUJaliGQH5H3JhXfthtluktGPYx8q4mc0xZWg0KYX+J2kIoX9JR2veqGR+uU
 9IxR0sv1Ct4ufQWR0jWMokspRV9PCyJMjC9DSspio7XGQlb8UClQTkuSBE/9VfaZN4K0xkTnls/
 rjUDmJlRPP4Hz/yYAdtTwMrcUJnz+PP2Yb/N7f85xXScJZBKJzE1SrOgC5KzRLAMY+8s/81saqZ
 JNkPONH6UejEdVsQ4DNvSp+pBADHMUeWWfqg1cMLaxYlfYnOSVM/2ncAfyuXtujB1wleKKo8IwR
 8q/WWGC9NVqr0ZndZFlDy50a6NHDf2GM9GYkDOUBPF1HDfh4vVyXOnnc6rfz2XggO3KG8p4596t
 7r2BB/J+pYFx6EG/F2hXnMGmTD+Le4VzqwpzP6UY0ujdpaV7Da9f0oOJ6gJMBV8bQpy5F0VHb8w
 G9t/EbDSe1pauMFX1jGghnJUt/gX64i7GPqk/kUaQW4jT8f15Dpd+BL0rsJwkSryDyyxbGXl1XW
 FfZgjDWj7WM+6Dpee7JYXyhJV+g=
X-Received: by 2002:a05:6000:491a:b0:48d:deb0:f1a7 with SMTP id
 ffacd0b85a97d-48e1e7a833fmr11632929f8f.10.1792592568039; 
 Wed, 21 Oct 2026 07:22:48 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 069/100] tcg: Generic expansion of tcg_gen_ext_*
Date: Wed, 21 Oct 2026 16:16:21 +0200
Message-ID: <20261021141652.363109-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42d.google.com
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


