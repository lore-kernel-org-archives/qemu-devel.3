Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5467710FCACC
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 19:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8183-0006by-F2; Wed, 01 Apr 2026 15:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w817o-0006Tb-VJ
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 15:21:14 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w817j-0002yX-6I
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 15:21:10 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-35c2fe0d90fso38322a91.1
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 12:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775071265; x=1775676065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zw7oDmqglvqKl8+MyBKQqhDwyqmly7OMJWrGEtetrjU=;
 b=m7UAQW6sJt3RijQfpmMgKZGEqdfP/KxnA/uY7R4JWnZucAPV8/im4qVzDpRvuyQe3g
 Wz0BBz4ym5+BrDDYwcoQ7PygYeK2iLehAN2Mfmjv9WV+nWHytK1WfpGPD68GEx5mYIzW
 0ctnRaH/JKo1atB2F/5ALJWGv2ntH5t1+r36IBwnq788cgO5tipi5EN9fU5+1P8ziois
 HfuQ7yQLMk8NeJRKzu4V3YtVn5xGlsFlbZVdAYzDC0IhKfLDxbjjMJazxrUIlGxmVLyV
 mdqV3Sy94WpO47JuE4t1DcFnmc6wFfbu0605dA6SQeTIxqdmzm1awKjTNpre9E2f3I/P
 uOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775071265; x=1775676065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zw7oDmqglvqKl8+MyBKQqhDwyqmly7OMJWrGEtetrjU=;
 b=j5AkHSAecZxZLLMHzd2/J/F/p7+3XFPUOo1Rg6L55ydlCaHA72r9Jem7UXLagEm2Ph
 e4VXA3LhgnxmbJ8a1tmjCgEZxY/VV3W984Inxy9h1uKFU2UjJU03UNiAM9/loqHeHtGX
 K0tZxwGYCYgk+ws2dwuMyJZVXCGJiFz7xwaHnAsOvk+mZtfCjBAOHDM4+IPaOUW5uLdt
 qQV38xQKUaKaVEVcAQBbQ0T7lmrhe02aXLUEsvCKJlBeZ6ZbFOBXxrxGsm+iMpyuEpyV
 jlCVr/jHthBlHPg2LAjfgbbDOxYFqBoFBA+M7HTKYS4BQb74yedz3o/IAozAn4orxIGs
 AinQ==
X-Gm-Message-State: AOJu0YyiOtv+LgfFMDKoGZWySBDOpepFX3lEzrLQ6G8XNRqv79M7zqkN
 WFVhDR9NaC2nKqHxKih669uh3Uo0S3tA+OiMnCNGl/jwUVW6QJfbooM78xyOMl8gVlOFpnwXnau
 zEqSJbVKpsg==
X-Gm-Gg: ATEYQzyMHA02BE+z6P/IYcMZ1rIowXaseu0MCd9pkPHAp8lIht4yrtzpzEMrOlSbo4p
 6yJGJK12RU2bNs5QFVPiv9ZDIQybOAB8adceRgWoArp1O2QrtpSAmpEqch24YKIjyi53Y1IZN0H
 UkowmYQBKpn8Kj+5RuG8kGpFXJ9wkDB9Uw7jEYej2UdezpW4XwVVz0Ktlriwt1AMPRWb7Dwqutk
 KxPIIIa3ieeaIIKCVePgbz15X6kGXgFakz2E6jwPMDnfh49ls4oXdWgudvJXWN8dLGIk7VzsaVN
 C9eM0bmrsiaoI/LCa+ZksfjWupNRfPWuFn4ympDot+qxQusSekN7NAICynOjmIMfyXlBwP6zkPU
 A5yCrkqKSjE+G9eJyw3a0hs9xBSBM5SKVS0YG1IUrqnEsL8crbd60DMV7YToa6smkwFjmDpwLKH
 ZVDvtKKCHO5vxscqAurYqS8uGRJvpEHwDWbSLAmh07WaUj7YirNf2Ci+B+utFAjNgv7P+4CmL3P
 coW
X-Received: by 2002:a17:90b:1dc7:b0:35c:30a8:32a with SMTP id
 98e67ed59e1d1-35dd4024f2emr497386a91.9.1775071265443; 
 Wed, 01 Apr 2026 12:21:05 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbe41b11fsm5633113a91.0.2026.04.01.12.21.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 12:21:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 jim.macarthur@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 01/12] include/tcg/tcg-op: extract memory operations to
 tcg-op-mem.h
Date: Wed,  1 Apr 2026 12:20:46 -0700
Message-ID: <20260401192057.1182724-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260401192057.1182724-1-pierrick.bouvier@linaro.org>
References: <20260401192057.1182724-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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


