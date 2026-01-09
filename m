Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D235FD232DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 05:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve56o-0004ay-3y; Fri, 09 Jan 2026 00:32:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56l-0004TY-VV
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:23 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ve56j-0003jM-SY
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 00:32:23 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-34ccdcbe520so1320371a91.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 21:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767936740; x=1768541540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GsjS+Jk8Rj0Zgp7G4n745Kx7rx1uYWelRSzcJlOLJQg=;
 b=XQpfz6RUR873WXSbx2UbxzSzFcalkDiJBSWL3xuzdXJmc3HkDCRX84y6lH/ViiGbsh
 aSh/3lQY2iAucKRC54Kx9EcnXvAZSrodLpU1B+xqG/TCuUofY4M7BWO6SxItmHNnOJ2i
 pAmO5BOJE3keW5MkB2HD5DugQHE9O16+hGbuXf1gn0B2c/UK/WuBk2z5BPRXzZcviDy0
 H+fZtehbtrZI7kzqmeq/pJXonRY/pdMT6Ku9h/pRSB3uMIWX+YU7WFxsaufwrjP84bU3
 g1EMbYq4PR6eXraMYf74JMMV4Q8VnqBPDiclhsjr2baS2IbTU1ILnzUpRuToao91EpPz
 UVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767936740; x=1768541540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GsjS+Jk8Rj0Zgp7G4n745Kx7rx1uYWelRSzcJlOLJQg=;
 b=F+sKFNH7jJba5C0dsI4UVilY4joTWZHkXnp/h4m3mPqxydFWbVxuBZ+V5VbD6wGciH
 UJe+45GqGcwQ4P1B61OqlhLXVjVszxPsz2O2el6fnZ0019xwdrDD9ivykoyGuQE1ORT1
 3OKTdGUI9n4M/h+xiZ6ayP8lWekFsHd82+iGbXfslOpQIasULDrJ7z7m+Uf8sivTUbH5
 G9GsvKR+sKTuVywr4fYP4EH75PKYeTzlbnVH0rg9Jz6LV4+HfpIdnpOObIeLR+9pOrTs
 Isdc244cPhGLCyqjPoaTVr+ZcJZtwLJM9lKSKAEmFFkTG0+4/AQIe9bYI4DPVZn5G1Uq
 DxFQ==
X-Gm-Message-State: AOJu0YwCI5GX1jyn+ds1yq6RNWTPFd3GFpHglpDw9vQU+4dZD72VNf66
 IxIqUGUCmcU/isoRm0PgeviU2i0XiLQTMzXPy04sNg3mgysW8qe/mrO2BUBjWYgH9YyY+zLBt+Q
 pt6ZU
X-Gm-Gg: AY/fxX6whE4PMO2irVTTeKeXztdcieqZ0QKfkh+O0Zt6+uimZvP39fVkIoQY6ULzfTT
 3AKX5Qj6QZirGcEtwftK1ryw89cm7UFHdjrcfhVPQoljN+LIDfBMAjhDiduMtiVgObkQ0yGbhIQ
 3w6goaXlxll+8FXKCuEnYhXHqxBl0O1OwD1uuX2uhq/2WEAi/DeOjIrxw5JnzmGuNjrTn8D3LrZ
 v2Z5ddoUQl7O+KwX34Nj1ZO7Fv3oU0Bd9w53VTGcXFIOBELOsL2l/+XxGnm6ZU3Stl5By0MiEC2
 te+b9gYT565agKD5ZqSltW6QOcfkGoMR4/KBnO7fmfBFwjaYTBWK4K8XY1QQkzbMRKr9dth0fMh
 0VlWUAKrj8sBUnVOQdzsiNjOMyZKEJ0bI+u5NjQVSdn/TyUEy9gjNiSYXh0guTXSqpFWlMlKm/O
 G0pc6b5UjsH53qQYgL6X/VV949ag9nlUWxVMNi/AOZz83X9h6dD/e2jTgxFZNas5tEOipIzjwWO
 A0=
X-Google-Smtp-Source: AGHT+IGgkSqceuMHLLbp1hiJxUX9hIWbYm+s8dp2eTf2+oVICLByGxUopI2+KWH4ZXHDj9qySQ2gAw==
X-Received: by 2002:a17:90b:314c:b0:340:b501:7b83 with SMTP id
 98e67ed59e1d1-34f68c019c2mr7480998a91.10.1767936737782; 
 Thu, 08 Jan 2026 21:32:17 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f5fa93f30sm9260137a91.5.2026.01.08.21.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 21:32:17 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 14/29] include/tcg/tcg-op.h: introduce TARGET_ADDRESS_BITS
Date: Thu,  8 Jan 2026 21:31:43 -0800
Message-ID: <20260109053158.2800705-15-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This define will be used to replace TARGET_LONG_BITS in tcg-op-*
headers. The goal here is to allow a compilation unit to set explicitely
which variant of the arch it's targeting (32 vs 64 bits).

By default, we simple let it defined as TARGET_LONG_BITS, so existing
code does not need to be changed, and we can progressively convert new
files.

target/arm/tcg/* files are cleanly splitted between 32 and 64 bits (with
some TARGET_AARCH64 defines). For other arch, this is a work that will
have to be done before converting them.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/tcg/tcg-op-address-bits.h | 21 +++++++++++++++++++++
 include/tcg/tcg-op-gvec.h         | 11 +++--------
 include/tcg/tcg-op.h              | 22 +++++++---------------
 3 files changed, 31 insertions(+), 23 deletions(-)
 create mode 100644 include/tcg/tcg-op-address-bits.h

diff --git a/include/tcg/tcg-op-address-bits.h b/include/tcg/tcg-op-address-bits.h
new file mode 100644
index 00000000000..71e9de65280
--- /dev/null
+++ b/include/tcg/tcg-op-address-bits.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef TCG_OP_ADDRESS_BITS
+#define TCG_OP_ADDRESS_BITS
+
+#ifdef COMPILING_PER_TARGET
+ #include "exec/target_long.h"
+ #ifndef TARGET_ADDRESS_BITS
+  #define TARGET_ADDRESS_BITS TARGET_LONG_BITS
+ #endif
+#else
+ #ifndef TARGET_ADDRESS_BITS
+  #error TARGET_ADDRESS_BITS must be defined for current file
+ #endif
+#endif /* COMPILING_PER_TARGET */
+
+#if TARGET_ADDRESS_BITS != 32 && TARGET_ADDRESS_BITS != 64
+ #error TARGET_ADDRESS_BITS must be 32 or 64
+#endif
+
+#endif /* TCG_OP_ADDRESS_BITS */
diff --git a/include/tcg/tcg-op-gvec.h b/include/tcg/tcg-op-gvec.h
index b0a81ad4bf4..422a270b694 100644
--- a/include/tcg/tcg-op-gvec.h
+++ b/include/tcg/tcg-op-gvec.h
@@ -8,13 +8,10 @@
 #ifndef TCG_TCG_OP_GVEC_H
 #define TCG_TCG_OP_GVEC_H
 
+#include "tcg/tcg-op-address-bits.h"
 #include "tcg/tcg-op-gvec-common.h"
 
-#ifndef TARGET_LONG_BITS
-#error must include QEMU headers
-#endif
-
-#if TARGET_LONG_BITS == 64
+#if TARGET_ADDRESS_BITS == 64
 #define tcg_gen_gvec_dup_tl  tcg_gen_gvec_dup_i64
 #define tcg_gen_vec_add8_tl  tcg_gen_vec_add8_i64
 #define tcg_gen_vec_sub8_tl  tcg_gen_vec_sub8_i64
@@ -28,7 +25,7 @@
 #define tcg_gen_vec_shl16i_tl tcg_gen_vec_shl16i_i64
 #define tcg_gen_vec_shr16i_tl tcg_gen_vec_shr16i_i64
 #define tcg_gen_vec_sar16i_tl tcg_gen_vec_sar16i_i64
-#elif TARGET_LONG_BITS == 32
+#elif TARGET_ADDRESS_BITS == 32
 #define tcg_gen_gvec_dup_tl  tcg_gen_gvec_dup_i32
 #define tcg_gen_vec_add8_tl  tcg_gen_vec_add8_i32
 #define tcg_gen_vec_sub8_tl  tcg_gen_vec_sub8_i32
@@ -42,8 +39,6 @@
 #define tcg_gen_vec_shl16i_tl tcg_gen_vec_shl16i_i32
 #define tcg_gen_vec_shr16i_tl tcg_gen_vec_shr16i_i32
 #define tcg_gen_vec_sar16i_tl tcg_gen_vec_sar16i_i32
-#else
-# error
 #endif
 
 #endif
diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index bf76749d1c5..9e4e58a2d4b 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -8,20 +8,14 @@
 #ifndef TCG_TCG_OP_H
 #define TCG_TCG_OP_H
 
+#include "tcg/tcg-op-address-bits.h"
 #include "tcg/tcg-op-common.h"
 #include "tcg/insn-start-words.h"
-#include "exec/target_long.h"
 
-#ifndef TARGET_LONG_BITS
-#error must include QEMU headers
-#endif
-
-#if TARGET_LONG_BITS == 32
+#if TARGET_ADDRESS_BITS == 32
 # define TCG_TYPE_TL  TCG_TYPE_I32
-#elif TARGET_LONG_BITS == 64
+#elif TARGET_ADDRESS_BITS == 64
 # define TCG_TYPE_TL  TCG_TYPE_I64
-#else
-# error
 #endif
 
 #if INSN_START_WORDS != 3
@@ -56,22 +50,20 @@ static inline void tcg_gen_insn_start2(uint64_t pc, uint64_t a1,
     tcg_set_insn_start_param(op, 2, a2);
 }
 
-#if TARGET_LONG_BITS == 32
+#if TARGET_ADDRESS_BITS == 32
 typedef TCGv_i32 TCGv;
 #define tcg_temp_new() tcg_temp_new_i32()
 #define tcg_global_mem_new tcg_global_mem_new_i32
 #define tcgv_tl_temp tcgv_i32_temp
 #define tcg_gen_qemu_ld_tl tcg_gen_qemu_ld_i32
 #define tcg_gen_qemu_st_tl tcg_gen_qemu_st_i32
-#elif TARGET_LONG_BITS == 64
+#elif TARGET_ADDRESS_BITS == 64
 typedef TCGv_i64 TCGv;
 #define tcg_temp_new() tcg_temp_new_i64()
 #define tcg_global_mem_new tcg_global_mem_new_i64
 #define tcgv_tl_temp tcgv_i64_temp
 #define tcg_gen_qemu_ld_tl tcg_gen_qemu_ld_i64
 #define tcg_gen_qemu_st_tl tcg_gen_qemu_st_i64
-#else
-#error Unhandled TARGET_LONG_BITS value
 #endif
 
 static inline void
@@ -171,7 +163,7 @@ DEF_ATOMIC2(tcg_gen_atomic_umax_fetch, i64)
 #undef DEF_ATOMIC2
 #undef DEF_ATOMIC3
 
-#if TARGET_LONG_BITS == 64
+#if TARGET_ADDRESS_BITS == 64
 #define tcg_gen_movi_tl tcg_gen_movi_i64
 #define tcg_gen_mov_tl tcg_gen_mov_i64
 #define tcg_gen_ld8u_tl tcg_gen_ld8u_i64
@@ -419,5 +411,5 @@ DEF_ATOMIC2(tcg_gen_atomic_umax_fetch, i64)
         : (qemu_build_not_reached_always(), 0))                    \
      :  (target_long)dup_const(VECE, C))
 
-#endif /* TARGET_LONG_BITS == 64 */
+#endif /* TARGET_ADDRESS_BITS == 64 */
 #endif /* TCG_TCG_OP_H */
-- 
2.47.3


