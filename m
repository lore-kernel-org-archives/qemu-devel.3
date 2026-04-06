Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEE8F46C47
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 15:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9lVX-0002vR-M9; Mon, 06 Apr 2026 11:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9lVR-0002sb-Jd
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:04:49 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9lVN-0003qD-UL
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:04:49 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2aae146b604so25298885ad.3
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 08:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775487884; x=1776092684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zw7oDmqglvqKl8+MyBKQqhDwyqmly7OMJWrGEtetrjU=;
 b=tqUrgkHBZuTsqJQcqHZen7PvqDcYm1LoRTMz3N/qUGpNn/lKJ2EEmSlR1zoH0ew6+j
 EbeaYRImehgb3pxqu2pvFrHq+06SUXmYh280QUEAniTh2EU/G6wR2Qcf01doWWdtIZD+
 PlmEanRyvFI9ArZC98X/jQqi4lwzDLz8d1xkTJbZVT+/UwYD1rTjPt+VYXbS4m/Mfeje
 yPdZBSEOCpdmiTD6YRhJuRLrAqefe+ztKX+02KkyCGW8H0v9j4/qm0s7+Ir51IsP8wzg
 25ID0nTelQWVkeixLavdJlYIBbP36B/cz9IUKAQbfa0bsBMvi5uLd42dZS/xid25GPAi
 Rpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775487884; x=1776092684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zw7oDmqglvqKl8+MyBKQqhDwyqmly7OMJWrGEtetrjU=;
 b=dTUfmVD1bp254k5ejr4jpwmDJhBeV2oT0KxUjqziwJz63IXcPNQ57xWKmkXhSTkCzp
 us1RJykSQ29ojlbwYKU9YcJ88eGZAaXFsum2WMj+RsNaeYmnpY6KsENqlcF4ZrjTonjk
 ioQckCHlLJVDYAYdgqDX2xiJX6mq9SnH7qSxz1UrmhqIte8P6zN+sAUmbgL/i6WAQV0e
 jsTkMwxhbqOV8E0w47pBHO6LaHHIMKpFUmgwGTMai/8QM4pdBlJ+ta/yhqAqPK0jMt0i
 UM996IhYZEI/xC+v2MRxMbyvr4nKPXKUoUsLgNdp+gh9gkt8mncFgjSq5aX2+NejNXUQ
 oNag==
X-Gm-Message-State: AOJu0YzOnKtmI+mO3pY35x+kAQ66VBZ9JrGcs2qmOUNHlm40dNTaJeV3
 SjPAroY7DeRZ6LJ6iZ1ogQpFyPJKT+wpR4ak6WVzHUeUdmGBDtMQ4L0hmu0SvHZXLzNTjO1blri
 /iOEU9ZH1zg==
X-Gm-Gg: AeBDiesqLBUBFldWSoZ0O1yiLxtkdp7TpdA+hBYj4OGUUXNdlQ5AKvlIYC/qattEG4D
 wqlNAGummo187yzYFm6ewdR+dxqfe8XqxYczxhkBfAOX25TsC8TUV8FkrT4rnvrJmxpIs4CQxj2
 urtg3eNCl2OSG5/IxfvxfDOLNcQ9ZBE2J0DyVsPWnK76XJf078GrQXqLjo4CF6Dn2eGI4drwXJj
 elDoJX3KLLtcZ4MngTXXxmW4bg1Xxqzt8dpE+Wz1yZ2wmTGI3S5NrXM8LmMXtpVO/2D4yfW2z7C
 NYjTEkQk4fstvC21omosw17mHMVdHKwoZG68e5ehop3Bo8hE/nAZQCQf6bfcC/cJCNpCx+qAeg5
 MCjhmd45yrukPFRVAPLAu3TE/XAZQ/WdsQ2CIy6KW0iyfYxD0XqbwZgJjBUcKKiySlU6e6HoCg9
 Gs1+2CnOTO7sn76IZyyVurVxuWKmSPhwANPj2GK4qH8Q19wcy+bvVK35/eyUFrffjE9kmAx6wdG
 s0+
X-Received: by 2002:a17:902:e546:b0:2b0:5b4e:370c with SMTP id
 d9443c01a7336-2b281931aa5mr135094955ad.32.1775487884060; 
 Mon, 06 Apr 2026 08:04:44 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b274979d72sm137770075ad.51.2026.04.06.08.04.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 08:04:43 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, philmd@linaro.org,
 jim.macarthur@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 01/14] include/tcg/tcg-op: extract memory operations to
 tcg-op-mem.h
Date: Mon,  6 Apr 2026 08:04:21 -0700
Message-ID: <20260406150434.407201-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406150434.407201-1-pierrick.bouvier@linaro.org>
References: <20260406150434.407201-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This new header defines a new type for target virtual address,
independent from TCGv and is parameterized by a new define
TCG_ADDRESS_BITS (name was suggested by Paolo instead of
TARGET_ADDRESS_BITS).

By default, tcg-op.h include set this define to TARGET_LONG_BITS, but
it's also possible to include only tcg-op-common.h and tcg-op-mem.h and
set TCG_ADDRESS_BITS manually, which is what next commits will do.

We preserve existing MIT license when extracting this new header.

Implemented from:
https://lore.kernel.org/qemu-devel/a68321f0-3d54-4909-864c-9793cda05b2a@linaro.org/

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/tcg/tcg-op-mem.h | 126 +++++++++++++++++++++++++++++++++++++++
 include/tcg/tcg-op.h     | 100 +------------------------------
 2 files changed, 129 insertions(+), 97 deletions(-)
 create mode 100644 include/tcg/tcg-op-mem.h

diff --git a/include/tcg/tcg-op-mem.h b/include/tcg/tcg-op-mem.h
new file mode 100644
index 00000000000..36931d1dd57
--- /dev/null
+++ b/include/tcg/tcg-op-mem.h
@@ -0,0 +1,126 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Target dependent memory related functions.
+ *
+ * Copyright (c) 2008 Fabrice Bellard
+ */
+
+#ifndef TCG_TCG_OP_MEM_H
+#define TCG_TCG_OP_MEM_H
+
+#ifndef TCG_ADDRESS_BITS
+#error TCG_ADDRESS_BITS must be defined
+#endif
+
+#if TCG_ADDRESS_BITS == 32
+typedef TCGv_i32 TCGv_va;
+#define TCG_TYPE_VA TCG_TYPE_I32
+#define tcgv_va_temp tcgv_i32_temp
+#define tcgv_va_temp_new tcg_temp_new_i32
+#elif TCG_ADDRESS_BITS == 64
+typedef TCGv_i64 TCGv_va;
+#define TCG_TYPE_VA TCG_TYPE_I64
+#define tcgv_va_temp tcgv_i64_temp
+#define tcgv_va_temp_new tcg_temp_new_i64
+#else
+#error
+#endif
+
+static inline void
+tcg_gen_qemu_ld_i32(TCGv_i32 v, TCGv_va a, TCGArg i, MemOp m)
+{
+    tcg_gen_qemu_ld_i32_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
+}
+
+static inline void
+tcg_gen_qemu_st_i32(TCGv_i32 v, TCGv_va a, TCGArg i, MemOp m)
+{
+    tcg_gen_qemu_st_i32_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
+}
+
+static inline void
+tcg_gen_qemu_ld_i64(TCGv_i64 v, TCGv_va a, TCGArg i, MemOp m)
+{
+    tcg_gen_qemu_ld_i64_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
+}
+
+static inline void
+tcg_gen_qemu_st_i64(TCGv_i64 v, TCGv_va a, TCGArg i, MemOp m)
+{
+    tcg_gen_qemu_st_i64_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
+}
+
+static inline void
+tcg_gen_qemu_ld_i128(TCGv_i128 v, TCGv_va a, TCGArg i, MemOp m)
+{
+    tcg_gen_qemu_ld_i128_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
+}
+
+static inline void
+tcg_gen_qemu_st_i128(TCGv_i128 v, TCGv_va a, TCGArg i, MemOp m)
+{
+    tcg_gen_qemu_st_i128_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
+}
+
+#define DEF_ATOMIC2(N, S)                                               \
+    static inline void N##_##S(TCGv_##S r, TCGv_va a, TCGv_##S v,       \
+                               TCGArg i, MemOp m)                       \
+    { N##_##S##_chk(r, tcgv_va_temp(a), v, i, m, TCG_TYPE_VA); }
+
+#define DEF_ATOMIC3(N, S)                                               \
+    static inline void N##_##S(TCGv_##S r, TCGv_va a, TCGv_##S o,       \
+                               TCGv_##S n, TCGArg i, MemOp m)           \
+    { N##_##S##_chk(r, tcgv_va_temp(a), o, n, i, m, TCG_TYPE_VA); }
+
+DEF_ATOMIC3(tcg_gen_atomic_cmpxchg, i32)
+DEF_ATOMIC3(tcg_gen_atomic_cmpxchg, i64)
+DEF_ATOMIC3(tcg_gen_atomic_cmpxchg, i128)
+
+DEF_ATOMIC3(tcg_gen_nonatomic_cmpxchg, i32)
+DEF_ATOMIC3(tcg_gen_nonatomic_cmpxchg, i64)
+DEF_ATOMIC3(tcg_gen_nonatomic_cmpxchg, i128)
+
+DEF_ATOMIC2(tcg_gen_atomic_xchg, i32)
+DEF_ATOMIC2(tcg_gen_atomic_xchg, i64)
+DEF_ATOMIC2(tcg_gen_atomic_xchg, i128)
+
+DEF_ATOMIC2(tcg_gen_atomic_fetch_add, i32)
+DEF_ATOMIC2(tcg_gen_atomic_fetch_add, i64)
+DEF_ATOMIC2(tcg_gen_atomic_fetch_and, i32)
+DEF_ATOMIC2(tcg_gen_atomic_fetch_and, i64)
+DEF_ATOMIC2(tcg_gen_atomic_fetch_and, i128)
+DEF_ATOMIC2(tcg_gen_atomic_fetch_or, i32)
+DEF_ATOMIC2(tcg_gen_atomic_fetch_or, i64)
+DEF_ATOMIC2(tcg_gen_atomic_fetch_or, i128)
+DEF_ATOMIC2(tcg_gen_atomic_fetch_xor, i32)
+DEF_ATOMIC2(tcg_gen_atomic_fetch_xor, i64)
+DEF_ATOMIC2(tcg_gen_atomic_fetch_smin, i32)
+DEF_ATOMIC2(tcg_gen_atomic_fetch_smin, i64)
+DEF_ATOMIC2(tcg_gen_atomic_fetch_umin, i32)
+DEF_ATOMIC2(tcg_gen_atomic_fetch_umin, i64)
+DEF_ATOMIC2(tcg_gen_atomic_fetch_smax, i32)
+DEF_ATOMIC2(tcg_gen_atomic_fetch_smax, i64)
+DEF_ATOMIC2(tcg_gen_atomic_fetch_umax, i32)
+DEF_ATOMIC2(tcg_gen_atomic_fetch_umax, i64)
+
+DEF_ATOMIC2(tcg_gen_atomic_add_fetch, i32)
+DEF_ATOMIC2(tcg_gen_atomic_add_fetch, i64)
+DEF_ATOMIC2(tcg_gen_atomic_and_fetch, i32)
+DEF_ATOMIC2(tcg_gen_atomic_and_fetch, i64)
+DEF_ATOMIC2(tcg_gen_atomic_or_fetch, i32)
+DEF_ATOMIC2(tcg_gen_atomic_or_fetch, i64)
+DEF_ATOMIC2(tcg_gen_atomic_xor_fetch, i32)
+DEF_ATOMIC2(tcg_gen_atomic_xor_fetch, i64)
+DEF_ATOMIC2(tcg_gen_atomic_smin_fetch, i32)
+DEF_ATOMIC2(tcg_gen_atomic_smin_fetch, i64)
+DEF_ATOMIC2(tcg_gen_atomic_umin_fetch, i32)
+DEF_ATOMIC2(tcg_gen_atomic_umin_fetch, i64)
+DEF_ATOMIC2(tcg_gen_atomic_smax_fetch, i32)
+DEF_ATOMIC2(tcg_gen_atomic_smax_fetch, i64)
+DEF_ATOMIC2(tcg_gen_atomic_umax_fetch, i32)
+DEF_ATOMIC2(tcg_gen_atomic_umax_fetch, i64)
+
+#undef DEF_ATOMIC2
+#undef DEF_ATOMIC3
+
+#endif /* TCG_TCG_OP_MEM_H */
diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 7024be938e6..96a5af1a298 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -16,6 +16,9 @@
 #error must include QEMU headers
 #endif
 
+#define TCG_ADDRESS_BITS TARGET_LONG_BITS
+#include "tcg/tcg-op-mem.h"
+
 #if TARGET_LONG_BITS == 32
 # define TCG_TYPE_TL  TCG_TYPE_I32
 #elif TARGET_LONG_BITS == 64
@@ -46,103 +49,6 @@ typedef TCGv_i64 TCGv;
 #error Unhandled TARGET_LONG_BITS value
 #endif
 
-static inline void
-tcg_gen_qemu_ld_i32(TCGv_i32 v, TCGv a, TCGArg i, MemOp m)
-{
-    tcg_gen_qemu_ld_i32_chk(v, tcgv_tl_temp(a), i, m, TCG_TYPE_TL);
-}
-
-static inline void
-tcg_gen_qemu_st_i32(TCGv_i32 v, TCGv a, TCGArg i, MemOp m)
-{
-    tcg_gen_qemu_st_i32_chk(v, tcgv_tl_temp(a), i, m, TCG_TYPE_TL);
-}
-
-static inline void
-tcg_gen_qemu_ld_i64(TCGv_i64 v, TCGv a, TCGArg i, MemOp m)
-{
-    tcg_gen_qemu_ld_i64_chk(v, tcgv_tl_temp(a), i, m, TCG_TYPE_TL);
-}
-
-static inline void
-tcg_gen_qemu_st_i64(TCGv_i64 v, TCGv a, TCGArg i, MemOp m)
-{
-    tcg_gen_qemu_st_i64_chk(v, tcgv_tl_temp(a), i, m, TCG_TYPE_TL);
-}
-
-static inline void
-tcg_gen_qemu_ld_i128(TCGv_i128 v, TCGv a, TCGArg i, MemOp m)
-{
-    tcg_gen_qemu_ld_i128_chk(v, tcgv_tl_temp(a), i, m, TCG_TYPE_TL);
-}
-
-static inline void
-tcg_gen_qemu_st_i128(TCGv_i128 v, TCGv a, TCGArg i, MemOp m)
-{
-    tcg_gen_qemu_st_i128_chk(v, tcgv_tl_temp(a), i, m, TCG_TYPE_TL);
-}
-
-#define DEF_ATOMIC2(N, S)                                               \
-    static inline void N##_##S(TCGv_##S r, TCGv a, TCGv_##S v,          \
-                               TCGArg i, MemOp m)                       \
-    { N##_##S##_chk(r, tcgv_tl_temp(a), v, i, m, TCG_TYPE_TL); }
-
-#define DEF_ATOMIC3(N, S)                                               \
-    static inline void N##_##S(TCGv_##S r, TCGv a, TCGv_##S o,          \
-                               TCGv_##S n, TCGArg i, MemOp m)           \
-    { N##_##S##_chk(r, tcgv_tl_temp(a), o, n, i, m, TCG_TYPE_TL); }
-
-DEF_ATOMIC3(tcg_gen_atomic_cmpxchg, i32)
-DEF_ATOMIC3(tcg_gen_atomic_cmpxchg, i64)
-DEF_ATOMIC3(tcg_gen_atomic_cmpxchg, i128)
-
-DEF_ATOMIC3(tcg_gen_nonatomic_cmpxchg, i32)
-DEF_ATOMIC3(tcg_gen_nonatomic_cmpxchg, i64)
-DEF_ATOMIC3(tcg_gen_nonatomic_cmpxchg, i128)
-
-DEF_ATOMIC2(tcg_gen_atomic_xchg, i32)
-DEF_ATOMIC2(tcg_gen_atomic_xchg, i64)
-DEF_ATOMIC2(tcg_gen_atomic_xchg, i128)
-
-DEF_ATOMIC2(tcg_gen_atomic_fetch_add, i32)
-DEF_ATOMIC2(tcg_gen_atomic_fetch_add, i64)
-DEF_ATOMIC2(tcg_gen_atomic_fetch_and, i32)
-DEF_ATOMIC2(tcg_gen_atomic_fetch_and, i64)
-DEF_ATOMIC2(tcg_gen_atomic_fetch_and, i128)
-DEF_ATOMIC2(tcg_gen_atomic_fetch_or, i32)
-DEF_ATOMIC2(tcg_gen_atomic_fetch_or, i64)
-DEF_ATOMIC2(tcg_gen_atomic_fetch_or, i128)
-DEF_ATOMIC2(tcg_gen_atomic_fetch_xor, i32)
-DEF_ATOMIC2(tcg_gen_atomic_fetch_xor, i64)
-DEF_ATOMIC2(tcg_gen_atomic_fetch_smin, i32)
-DEF_ATOMIC2(tcg_gen_atomic_fetch_smin, i64)
-DEF_ATOMIC2(tcg_gen_atomic_fetch_umin, i32)
-DEF_ATOMIC2(tcg_gen_atomic_fetch_umin, i64)
-DEF_ATOMIC2(tcg_gen_atomic_fetch_smax, i32)
-DEF_ATOMIC2(tcg_gen_atomic_fetch_smax, i64)
-DEF_ATOMIC2(tcg_gen_atomic_fetch_umax, i32)
-DEF_ATOMIC2(tcg_gen_atomic_fetch_umax, i64)
-
-DEF_ATOMIC2(tcg_gen_atomic_add_fetch, i32)
-DEF_ATOMIC2(tcg_gen_atomic_add_fetch, i64)
-DEF_ATOMIC2(tcg_gen_atomic_and_fetch, i32)
-DEF_ATOMIC2(tcg_gen_atomic_and_fetch, i64)
-DEF_ATOMIC2(tcg_gen_atomic_or_fetch, i32)
-DEF_ATOMIC2(tcg_gen_atomic_or_fetch, i64)
-DEF_ATOMIC2(tcg_gen_atomic_xor_fetch, i32)
-DEF_ATOMIC2(tcg_gen_atomic_xor_fetch, i64)
-DEF_ATOMIC2(tcg_gen_atomic_smin_fetch, i32)
-DEF_ATOMIC2(tcg_gen_atomic_smin_fetch, i64)
-DEF_ATOMIC2(tcg_gen_atomic_umin_fetch, i32)
-DEF_ATOMIC2(tcg_gen_atomic_umin_fetch, i64)
-DEF_ATOMIC2(tcg_gen_atomic_smax_fetch, i32)
-DEF_ATOMIC2(tcg_gen_atomic_smax_fetch, i64)
-DEF_ATOMIC2(tcg_gen_atomic_umax_fetch, i32)
-DEF_ATOMIC2(tcg_gen_atomic_umax_fetch, i64)
-
-#undef DEF_ATOMIC2
-#undef DEF_ATOMIC3
-
 #if TARGET_LONG_BITS == 64
 #define tcg_gen_movi_tl tcg_gen_movi_i64
 #define tcg_gen_mov_tl tcg_gen_mov_i64
-- 
2.47.3


