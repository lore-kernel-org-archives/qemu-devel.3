Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05598CA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 12:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umtWc-000153-ER; Fri, 15 Aug 2025 08:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umtWX-00013q-7D
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 08:27:09 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umtWV-0007XP-DL
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 08:27:08 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-76e39ec6f30so1214958b3a.2
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 05:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755260825; x=1755865625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=53dqTOaIfUhQRIFaZNYuW0Bo9AiUeDNRZ/usdqG/HaQ=;
 b=OjHMXFIRh2S+PJO4hoYxf9ylXKuECXgEiwtrvWJeCtzs8pK5A46F2dxtR1p6YSYFTM
 sqVdXXxzG0Lr+RorgtVMQUuZcUrSC1GDvWnUIMNUp0jrOTJ+OJNiWl4Doe3PtR6UPbn0
 206V5cWuUMQFv2alumBxZWcTReY1uo6jTwgLl4Mdgecy/+IlNtl73myR6A90910tCfNR
 rY3Y7P9WrsIqanhx0Wl7Lm1ZTQUDcnLAUDMdpwNw3rv/q60LnQ8UiPaPrbx36pwyDPzA
 DMENRiUMvWbqILO8tG+jG+rIAArgVyhhjk3D4qEWa+FmjsNdi5bzOHBJir8KhxqTF7t0
 Wrwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755260825; x=1755865625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=53dqTOaIfUhQRIFaZNYuW0Bo9AiUeDNRZ/usdqG/HaQ=;
 b=bDVRhjiCWRQpuxqFvHWx6Jty4/77HNFxQfSIOQp/yUu3dqg9xOJUCj1sPPx1P77WkG
 pdMMiSo7F0LdK4fytTQzLgAGhmJ+UWOND/eNxKpwd9/FNZ3pZLcKhxkpU/XWOnDIszRC
 r46rS9vCmWFMsN8YNoCtV6GQYEyfOlNunrZlo+7RdvocoUN1gtF+hMRclqUxc2i4EKds
 z56lLxSHDxN2/qnPCFl6sAXhgZQU/rXic/jotFXQMrAo6CDqIruHWeMIk0KuNQ3IdCmR
 yzV/JkdbFgCzd8AYr0MP8OfvLBXM6CRHtcqbUv78wrE1i7WfQ9Fdyl6UFofwRqP3+vNO
 hlsg==
X-Gm-Message-State: AOJu0YwK68jrpfxVbI8OJZnLsj5IVwYkHLObDGanrXBgE4+nXDkUWWTX
 xv0JKYyHtfZXpyRjC8D7Ot69lI7kPKlM/jlpKuKfqaK1AVZ92hMLCRGbB1KFkZrAYnC1QEVCUcR
 V+vLpQ+U=
X-Gm-Gg: ASbGncs8yc/2MGYmd6G4wiQQFs3QieFywFYU0xQkQpBhHBrCuh07P+g7h50RHrEmn5p
 fX0mSgAHL6rulTxJgOnj/tzWSebLFcfl2YODSiQDch9C03hJslEVYq7VPHPONB4FWcWaRgLvonk
 ki27EZyxPRFBnSjOngRPbR6+HSzDAch9bqpzSlRokXHnoZE/F050zw6oyX4jTof4hOQVP4FXHtp
 N+bdvkF0Mbl5MieC/8QdRgGL3x64jMiNPl4Q1PusLrosRIjvvprCmPNR5iejJ6SF49BHyBMi3TW
 +iNzoOexWVuSHFEZC+NTykTHMb8frH59Fd8RGDodDVDfgaYv0fml15IyzYdrWqpcawKVQ4eEWXD
 kzTskrN02+wr+A1tzOcymunvpzRsbg1xn9/QIH3fOCI0EzVM=
X-Google-Smtp-Source: AGHT+IE68u2gdVFeLxcX8b7YLZODhCu+uuqY7fuOa0IA4VlKlEViMIWWhe2jBz9Gc4qXfcwp68T89w==
X-Received: by 2002:a05:6a21:6d99:b0:23f:f729:2e60 with SMTP id
 adf61e73a8af0-240d2e9f1cemr3407384637.25.1755260824913; 
 Fri, 15 Aug 2025 05:27:04 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76e45292c86sm1053475b3a.48.2025.08.15.05.27.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 05:27:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/7] qemu/atomic: Add atomic16 primitives for xchg, fetch_and,
 fetch_or
Date: Fri, 15 Aug 2025 22:26:48 +1000
Message-ID: <20250815122653.701782-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250815122653.701782-1-richard.henderson@linaro.org>
References: <20250815122653.701782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/aarch64/host/atomic128-cas.h.inc | 57 +++++++++++
 host/include/generic/host/atomic128-cas.h.inc | 96 +++++++++++++++++++
 2 files changed, 153 insertions(+)

diff --git a/host/include/aarch64/host/atomic128-cas.h.inc b/host/include/aarch64/host/atomic128-cas.h.inc
index 991da4ef54..aec27df182 100644
--- a/host/include/aarch64/host/atomic128-cas.h.inc
+++ b/host/include/aarch64/host/atomic128-cas.h.inc
@@ -38,6 +38,63 @@ static inline Int128 atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new)
     return int128_make128(oldl, oldh);
 }
 
+static inline Int128 atomic16_xchg(Int128 *ptr, Int128 new)
+{
+    uint64_t newl = int128_getlo(new), newh = int128_gethi(new);
+    uint64_t oldl, oldh;
+    uint32_t tmp;
+
+    asm("0: ldaxp %[oldl], %[oldh], %[mem]\n\t"
+        "stlxp %w[tmp], %[newl], %[newh], %[mem]\n\t"
+        "cbnz %w[tmp], 0b"
+        : [mem] "+m"(*ptr), [tmp] "=&r"(tmp),
+          [oldl] "=&r"(oldl), [oldh] "=&r"(oldh)
+        : [newl] "r"(newl), [newh] "r"(newh)
+        : "memory");
+
+    return int128_make128(oldl, oldh);
+}
+
+static inline Int128 atomic16_fetch_and(Int128 *ptr, Int128 new)
+{
+    uint64_t newl = int128_getlo(new), newh = int128_gethi(new);
+    uint64_t oldl, oldh, tmpl, tmph;
+    uint32_t tmp;
+
+    asm("0: ldaxp %[oldl], %[oldh], %[mem]\n\t"
+        "and %[tmpl], %[oldl], %[newl]\n\t"
+        "and %[tmph], %[oldh], %[newh]\n\t"
+        "stlxp %w[tmp], %[tmpl], %[tmph], %[mem]\n\t"
+        "cbnz %w[tmp], 0b"
+        : [mem] "+m"(*ptr), [tmp] "=&r"(tmp),
+          [oldl] "=&r"(oldl), [oldh] "=&r"(oldh)
+        : [newl] "r"(newl), [newh] "r"(newh),
+          [tmpl] "r"(tmpl), [tmph] "r"(tmph)
+        : "memory");
+
+    return int128_make128(oldl, oldh);
+}
+
+static inline Int128 atomic16_fetch_or(Int128 *ptr, Int128 new)
+{
+    uint64_t newl = int128_getlo(new), newh = int128_gethi(new);
+    uint64_t oldl, oldh, tmpl, tmph;
+    uint32_t tmp;
+
+    asm("0: ldaxp %[oldl], %[oldh], %[mem]\n\t"
+        "orr %[tmpl], %[oldl], %[newl]\n\t"
+        "orr %[tmph], %[oldh], %[newh]\n\t"
+        "stlxp %w[tmp], %[tmpl], %[tmph], %[mem]\n\t"
+        "cbnz %w[tmp], 0b"
+        : [mem] "+m"(*ptr), [tmp] "=&r"(tmp),
+          [oldl] "=&r"(oldl), [oldh] "=&r"(oldh)
+        : [newl] "r"(newl), [newh] "r"(newh),
+          [tmpl] "r"(tmpl), [tmph] "r"(tmph)
+        : "memory");
+
+    return int128_make128(oldl, oldh);
+}
+
 # define CONFIG_CMPXCHG128 1
 # define HAVE_CMPXCHG128 1
 #endif
diff --git a/host/include/generic/host/atomic128-cas.h.inc b/host/include/generic/host/atomic128-cas.h.inc
index 6b40cc2271..990162c56f 100644
--- a/host/include/generic/host/atomic128-cas.h.inc
+++ b/host/include/generic/host/atomic128-cas.h.inc
@@ -23,6 +23,51 @@ atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new)
     r.i = qatomic_cmpxchg__nocheck(ptr_align, c.i, n.i);
     return r.s;
 }
+
+/*
+ * Since we're looping anyway, use weak compare and swap.
+ * If the host supports weak, this will eliminate a second loop hidden
+ * within the atomic operation itself; otherwise the weak parameter is
+ * ignored.
+ */
+static inline Int128 ATTRIBUTE_ATOMIC128_OPT
+atomic16_xchg(Int128 *ptr, Int128 new)
+{
+    __int128_t *ptr_align = __builtin_assume_aligned(ptr, 16);
+    Int128 old = *ptr_align;
+
+    while (!__atomic_compare_exchange_n(ptr_align, &old, new, true,
+                                        __ATOMIC_SEQ_CST, 0)) {
+        continue;
+    }
+    return old;
+}
+
+static inline Int128 ATTRIBUTE_ATOMIC128_OPT
+atomic16_fetch_and(Int128 *ptr, Int128 val)
+{
+    __int128_t *ptr_align = __builtin_assume_aligned(ptr, 16);
+    Int128 old = *ptr_align;
+
+    while (!__atomic_compare_exchange_n(ptr_align, &old, old & val, true,
+                                        __ATOMIC_SEQ_CST, 0)) {
+        continue;
+    }
+    return old;
+}
+
+static inline Int128 ATTRIBUTE_ATOMIC128_OPT
+atomic16_fetch_or(Int128 *ptr, Int128 val)
+{
+    __int128_t *ptr_align = __builtin_assume_aligned(ptr, 16);
+    Int128 old = *ptr_align;
+
+    while (!__atomic_compare_exchange_n(ptr_align, &old, old | val, true,
+                                        __ATOMIC_SEQ_CST, 0)) {
+        continue;
+    }
+    return old;
+}
 # define HAVE_CMPXCHG128 1
 #elif defined(CONFIG_CMPXCHG128)
 static inline Int128 ATTRIBUTE_ATOMIC128_OPT
@@ -36,6 +81,57 @@ atomic16_cmpxchg(Int128 *ptr, Int128 cmp, Int128 new)
     r.i = __sync_val_compare_and_swap_16(ptr_align, c.i, n.i);
     return r.s;
 }
+
+static inline Int128 ATTRIBUTE_ATOMIC128_OPT
+atomic16_xchg(Int128 *ptr, Int128 new)
+{
+    Int128Aligned *ptr_align = __builtin_assume_aligned(ptr, 16);
+    Int128Alias o, n;
+
+    n.s = new;
+    o.s = *ptr_align;
+    while (1) {
+        __int128 c = __sync_val_compare_and_swap_16(ptr_align, o.i, n.i);
+        if (c == o.i) {
+            return o.s;
+        }
+        o.i = c;
+    }
+}
+
+static inline Int128 ATTRIBUTE_ATOMIC128_OPT
+atomic16_fetch_and(Int128 *ptr, Int128 val)
+{
+    Int128Aligned *ptr_align = __builtin_assume_aligned(ptr, 16);
+    Int128Alias o, v;
+
+    v.s = val;
+    o.s = *ptr_align;
+    while (1) {
+        __int128 c = __sync_val_compare_and_swap_16(ptr_align, o.i, o.i & v.i);
+        if (c == o.i) {
+            return o.s;
+        }
+        o.i = c;
+    }
+}
+
+static inline Int128 ATTRIBUTE_ATOMIC128_OPT
+atomic16_fetch_or(Int128 *ptr, Int128 val)
+{
+    Int128Aligned *ptr_align = __builtin_assume_aligned(ptr, 16);
+    Int128Alias o, v;
+
+    v.s = val;
+    o.s = *ptr_align;
+    while (1) {
+        __int128 c = __sync_val_compare_and_swap_16(ptr_align, o.i, o.i | v.i);
+        if (c == o.i) {
+            return o.s;
+        }
+        o.i = c;
+    }
+}
 # define HAVE_CMPXCHG128 1
 #else
 /* Fallback definition that must be optimized away, or error.  */
-- 
2.43.0


