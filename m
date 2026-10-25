Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE92606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mbuSd6iM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsfC-00043Y-90; Sun, 25 Oct 2026 03:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsd6-0008Uv-Bn
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:27:01 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsd4-0004c1-HC
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:26:56 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so1826595e9.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913213; x=1793518013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dpIHCsMnTsT8vfjeSz3vGDZBhur+BxE1zsoXnlah59o=;
 b=mbuSd6iMIcH4wwpWWmGIxr9g04wWW/3zbvFk4H+IuUOwQiakhGbezEu7wTA7NCNoUa
 Lg/gZT4fKgJrZT4qqwe/T4LYSXAQnjIAfQLQId6upneSqSYsKrhTRAHyiJ/ouLUVbPrJ
 wg8zvbe13x4HgOv65SF4mi3wI70OsFwkQmoxLBrOdYt4ZjS2bnu1EpykTPrkMRB0XnPs
 /MLoRPfRMJvLnZJJwcl5PLCWcPZKVfX9aNQIxkKaMWeghNuB2ow1MjAauLCHve3nSc7j
 YzanpL3gDTH7Q4ZFtNEU4Yg2vgJJZmQi/topQYA6I9biU6YqZjBfmRGc+t+4qAdsr0W3
 YdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913213; x=1793518013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dpIHCsMnTsT8vfjeSz3vGDZBhur+BxE1zsoXnlah59o=;
 b=zOvBm/cE2nWPuOEMuiEcqqEATupzO/tCLsn4g2YtXv8XxFFCMvOSNWAP+jEd+lBRwX
 Uz8Dz0a6cYR6S6PxyIKmwxL7kiSYApuRQRnHxR42PvMaigFvy5ZFyDj+ftDTis4FyUEY
 VCPT4FbAmuk8lg8kdkBwjvRtlJ+p6ceCBskC8HB1hWDv7bTW2d840XCUauJlJ7CI2WKx
 USm5/HZzEPVZj9v9F8OHkBkie4OQYGl+hY2pLIh65pL9skrP3JGBMbBPvNGc7IiSKMAv
 +TM504L6fb2oKHELqxJHVqxiG8j2lLg3EJfOZuATRGZjERQkvxl5KzRzyNYwQq8Qylbb
 ZnRw==
X-Gm-Message-State: AFq9FYLsORclNxZJPzjxAUErRAbq4FgYiPRB/VcW3e0XMSkwvzaIG10b
 jtam/Xb0vml7jwAYhikbPZ6qf2X7XpA2/b7VKY4U7rrDiOJ6d5qUULCmIhC6WAi+4iGqcmt3NjE
 1YPkEymE=
X-Gm-Gg: AYBFou0mwmAD1JNnSCt6LPZMMOnV8oYDdtkR1hswewNIBcJVVJfqGL/3GuFlBkrmsHM
 SGq+zS4kOxkYr2Y3uDeGXue2KopToU1f1sfJhUOQpoKzD/npdH2PBuQuloK42/uIbVxbQ5Q/hTv
 OY8iYyJOKBRsf3LzQzFojbcM/V3XDhU09IyBb7KKjDJ6JOkh3sc0hnlaeOWmk9o4qBgFcSjpCjQ
 weUyNABbegiXz4KphIdRI1wq0bCTKjuxAG9ddWxo8VGtZmF54e6WC/ofCtkQ9aw2NtawL+xARdk
 AQZlHCmS4qBB+DKz80/wPssLO2arcsI18FwBkHB3mWzHCkC4ZTjOb9lYfqVE6OCi4L9BNwtzVMh
 3F5gFmuX+SvcacmpLsOw81wwFMvj0Zu42ywi9S5JNH3Y1TrfPmVrDnq3OEWqOTNxBMRVplfZ2S8
 R9KgP35TLxtvfEGsh7HlRZiUw4iKYmE173U3IYH1WFZvhQ8sjP2ZYrQJyz/lRm+VKo+eBHV8SnQ
 c9s3KEYupOKGy2TVvAnUIe8Ca3gLlbRdtjX9gbf313XPQGh9ofFEaEvMYU=
X-Received: by 2002:a05:600c:4e8b:b0:4a2:180a:3417 with SMTP id
 5b1f17b1804b1-4a35ad01256mr64065905e9.1.1792913213207; 
 Sun, 25 Oct 2026 00:26:53 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359fc1207sm82923745e9.1.2026.10.25.00.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:26:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 092/100] tcg: Generic expansion of tcg_gen_st_*
Date: Sun, 25 Oct 2026 08:19:07 +0100
Message-ID: <20261025071915.1123867-93-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  | 20 +-------------------
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 21 ++++++++++-----------
 3 files changed, 12 insertions(+), 30 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index d0d508ced6..469b925fe0 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -142,7 +142,6 @@ void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
 void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
@@ -166,7 +165,6 @@ void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* Size changing operations.  */
 
@@ -352,24 +350,11 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
 
 /* Host pointer ops */
 
-#if UINTPTR_MAX == UINT32_MAX
-# define PTR  i32
-# define NAT  TCGv_i32
-#else
-# define PTR  i64
-# define NAT  TCGv_i64
-#endif
-
 TCGv_ptr tcg_constant_ptr_int(intptr_t x);
 #define tcg_constant_ptr(X)  tcg_constant_ptr_int((intptr_t)(X))
 
 QEMU_ARG_NONNULL void tcg_gen_ld_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o);
-
-static inline void tcg_gen_st_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
-{
-    glue(tcg_gen_st_, PTR)((NAT)r, a, o);
-}
-
+QEMU_ARG_NONNULL void tcg_gen_st_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o);
 QEMU_ARG_NONNULL void tcg_gen_discard_ptr(TCGv_ptr a);
 QEMU_ARG_NONNULL void tcg_gen_add_ptr(TCGv_ptr r, TCGv_ptr a, TCGv_ptr b);
 QEMU_ARG_NONNULL void tcg_gen_addi_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t b);
@@ -382,7 +367,4 @@ QEMU_ARG_NONNULL void tcg_gen_trunc_i64_ptr(TCGv_ptr r, TCGv_i64 a);
 QEMU_ARG_NONNULL void tcg_gen_extu_ptr_i64(TCGv_i64 r, TCGv_ptr a);
 QEMU_ARG_NONNULL void tcg_gen_trunc_ptr_i32(TCGv_i32 r, TCGv_ptr a);
 
-#undef PTR
-#undef NAT
-
 #endif /* TCG_TCG_OP_COMMON_H */
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 98a07a70f0..514967f91d 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -70,6 +70,7 @@ DEF3(shr, TCGV, TCGV, TCGV)
 DEF3(shri, TCGV, TCGV, TINT)
 DEF3(smax, TCGV, TCGV, TCGV)
 DEF3(smin, TCGV, TCGV, TCGV)
+DEF3(st, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF6(sub2, TCGV, TCGV, TCGV, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c8b42cc74c..ea0d281902 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1252,6 +1252,11 @@ void tcg_gen_smin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_st(TCGType type, TCGTemp *val, TCGTemp *base, tcg_target_long ofs)
+{
+    tcg_gen_op_tti(INDEX_op_st, type, val, base, ofs);
+}
+
 void tcg_gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -1413,12 +1418,6 @@ void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i32(INDEX_op_st16, arg1, arg2, offset);
 }
 
-void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_st, arg1, arg2, offset);
-}
-
-
 /* 64-bit ops */
 
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
@@ -1446,11 +1445,6 @@ void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st32, arg1, arg2, offset);
 }
 
-void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
-}
-
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_sextract_i64(ret, arg, 0, 32);
@@ -1853,6 +1847,11 @@ void tcg_gen_ld_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
     tcg_gen_ld(TCG_TYPE_PTR, tcgv_ptr_temp(r), tcgv_ptr_temp(a), o);
 }
 
+void tcg_gen_st_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
+{
+    tcg_gen_st(TCG_TYPE_PTR, tcgv_ptr_temp(r), tcgv_ptr_temp(a), o);
+}
+
 void tcg_gen_trunc_i64_ptr(TCGv_ptr r, TCGv_i64 a)
 {
     tcg_gen_mov(TCG_TYPE_PTR, tcgv_ptr_temp(r), tcgv_i64_temp(a));
-- 
2.53.0


