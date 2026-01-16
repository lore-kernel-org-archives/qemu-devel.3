Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48225D4A5F7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgagg-0005SV-Vq; Thu, 15 Jan 2026 22:39:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgagg-0005RT-9c
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:39:50 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgagd-00009M-Vx
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:39:50 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2a110548cdeso11508655ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534786; x=1769139586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pWKD7qvJhqwZTehtXTMdJknW4/xJt4QHquzuA5hb+vE=;
 b=FyLm3Tj9sHJdUlcnZomeQqsDTzRybT3i42QWRoQYj7+EUi3l9JKumKpqUiCfFLMQ7G
 UXG3z3Y/a60rG9Bx50rRKoMD81kadbCo7CsNUGagJMVxR6idqiVaJpB5AfTVwaRHZx9x
 3heqKeuzTcs/KKNGgGfFZtchoBOQvZrS6Of5Gtmfp9+69Pv8RLZH8qZwgIMU3KXhfuGe
 VTfw91hijgB17zXP9b+TETy9CYr/UO3oKoFq4FeKThxMdVC4OZCamtNLw6ngAa8zPMbP
 zcTFa1lK0LaOPbwPGuZy9eM4kEQfonL9anWRBEM7MaOQkgzXp3jhJe4bqJI9D16tVftQ
 xl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534786; x=1769139586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pWKD7qvJhqwZTehtXTMdJknW4/xJt4QHquzuA5hb+vE=;
 b=E/KrYqgSiyha7Ay5bhk3MR1GcUZlbZR0Ns48XEssy1OiyZwwb41ZtnVXObFB63OPFd
 YiREwyOrctgrNuHggdTIIrBZfVhmMHMXTQFEA9x0/JySNiQc3npSVvQTbJZ8kjbFyrzw
 xfUnHKjZ3sSBiIj7UAjWUhRqJaKSXYi8PFGiz7IJmCPeEI0I45OLny7I6jyiWFMZQKh2
 6PUgqeUMX2Dso375+olahsuqobKpNJD+n+NizANVDsnz5/oSUyeh1dlpUqBwQXNpgaXF
 eHb3hx1KLWpkQOs8GtRW3h28fGC0TscZuMhBRqTFWzcertrYiLp8riMlqLxPd4Eu4ivc
 PTaA==
X-Gm-Message-State: AOJu0Yx9WEHQBpa/AtcmLyHLnC5mDSx0PX2UsfHYaTFEn6uDqWMx0z4e
 h1A9qAlQr304p1Slgf/9xj66nXsmO74YK8msBoo6CXLNHYhGLTaV8Ylwyc1kev7ZFHv5iA/KGoo
 l1q7xCYooww==
X-Gm-Gg: AY/fxX6NiAR0DhXQymWOM96OjIsxdQ3KHp8v7Dax2qXE9ZikgAd7oGfz9LR6vbxh9zs
 Lm9+eMweXBUqEhBxOFQuZTzGgy7cYuKDmL4DTGYSE0DywLrQYbjslEMsXNoWjtiGeiORD0PJKnD
 BNfYSIRvEUJpx1SHwcH/PsxMMQikgnDnivYQX7qYPXziL7f6SrAkrlksf4KadQ6RGowP90wB/aN
 J8D6FTBAzL6XEM5dvYS950GAOBPBLH54SOFuTSmxW1o71Uyvf6rwPSKMSeJkaB/zWGqSxHYe4ta
 SsaEG/gXOHxL/ElrrtMWRqX/chYB4woWcIafSpLc3iq7D8k6K+9WNv/JChENCA3b6hRqrv90GL0
 Nr6bW3he1aKiaxmoSe4goakISJvuhKqr5KTX7x3zPR5djdbJdNa2gmRDAxzXced9D+ajVIyTEZf
 p4RcHDQDoOmJ050mgfsw==
X-Received: by 2002:a17:903:120b:b0:297:cf96:45bd with SMTP id
 d9443c01a7336-2a717537567mr15097245ad.19.1768534786441; 
 Thu, 15 Jan 2026 19:39:46 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190ca9d5sm6527975ad.25.2026.01.15.19.39.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:39:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 55/58] util: Remove stats64
Date: Fri, 16 Jan 2026 14:33:01 +1100
Message-ID: <20260116033305.51162-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

This API is no longer used.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/stats64.h | 199 -----------------------------------------
 util/stats64.c         | 148 ------------------------------
 util/meson.build       |   1 -
 3 files changed, 348 deletions(-)
 delete mode 100644 include/qemu/stats64.h
 delete mode 100644 util/stats64.c

diff --git a/include/qemu/stats64.h b/include/qemu/stats64.h
deleted file mode 100644
index 99b5cb724a..0000000000
--- a/include/qemu/stats64.h
+++ /dev/null
@@ -1,199 +0,0 @@
-/*
- * Atomic operations on 64-bit quantities.
- *
- * Copyright (C) 2017 Red Hat, Inc.
- *
- * Author: Paolo Bonzini <pbonzini@redhat.com>
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- */
-
-#ifndef QEMU_STATS64_H
-#define QEMU_STATS64_H
-
-#include "qemu/atomic.h"
-
-/* This provides atomic operations on 64-bit type, using a reader-writer
- * spinlock on architectures that do not have 64-bit accesses.  Even on
- * those architectures, it tries hard not to take the lock.
- */
-
-typedef struct Stat64 {
-#ifdef CONFIG_ATOMIC64
-    aligned_uint64_t value;
-#else
-    uint32_t low, high;
-    uint32_t lock;
-#endif
-} Stat64;
-
-#ifdef CONFIG_ATOMIC64
-static inline void stat64_init(Stat64 *s, uint64_t value)
-{
-    /* This is not guaranteed to be atomic! */
-    *s = (Stat64) { value };
-}
-
-static inline uint64_t stat64_get(const Stat64 *s)
-{
-    return qatomic_read__nocheck(&s->value);
-}
-
-static inline void stat64_set(Stat64 *s, uint64_t value)
-{
-    qatomic_set__nocheck(&s->value, value);
-}
-
-static inline void stat64_add(Stat64 *s, uint64_t value)
-{
-    qatomic_add(&s->value, value);
-}
-
-static inline void stat64_min(Stat64 *s, uint64_t value)
-{
-    uint64_t orig = qatomic_read__nocheck(&s->value);
-    while (orig > value) {
-        orig = qatomic_cmpxchg__nocheck(&s->value, orig, value);
-    }
-}
-
-static inline void stat64_max(Stat64 *s, uint64_t value)
-{
-    uint64_t orig = qatomic_read__nocheck(&s->value);
-    while (orig < value) {
-        orig = qatomic_cmpxchg__nocheck(&s->value, orig, value);
-    }
-}
-#else
-uint64_t stat64_get(const Stat64 *s);
-void stat64_set(Stat64 *s, uint64_t value);
-bool stat64_min_slow(Stat64 *s, uint64_t value);
-bool stat64_max_slow(Stat64 *s, uint64_t value);
-bool stat64_add32_carry(Stat64 *s, uint32_t low, uint32_t high);
-
-static inline void stat64_init(Stat64 *s, uint64_t value)
-{
-    /* This is not guaranteed to be atomic! */
-    *s = (Stat64) { .low = value, .high = value >> 32, .lock = 0 };
-}
-
-static inline void stat64_add(Stat64 *s, uint64_t value)
-{
-    uint32_t low, high;
-    high = value >> 32;
-    low = (uint32_t) value;
-    if (!low) {
-        if (high) {
-            qatomic_add(&s->high, high);
-        }
-        return;
-    }
-
-    for (;;) {
-        uint32_t orig = s->low;
-        uint32_t result = orig + low;
-        uint32_t old;
-
-        if (result < low || high) {
-            /* If the high part is affected, take the lock.  */
-            if (stat64_add32_carry(s, low, high)) {
-                return;
-            }
-            continue;
-        }
-
-        /* No carry, try with a 32-bit cmpxchg.  The result is independent of
-         * the high 32 bits, so it can race just fine with stat64_add32_carry
-         * and even stat64_get!
-         */
-        old = qatomic_cmpxchg(&s->low, orig, result);
-        if (orig == old) {
-            return;
-        }
-    }
-}
-
-static inline void stat64_min(Stat64 *s, uint64_t value)
-{
-    uint32_t low, high;
-    uint32_t orig_low, orig_high;
-
-    high = value >> 32;
-    low = (uint32_t) value;
-    do {
-        orig_high = qatomic_read(&s->high);
-        if (orig_high < high) {
-            return;
-        }
-
-        if (orig_high == high) {
-            /* High 32 bits are equal.  Read low after high, otherwise we
-             * can get a false positive (e.g. 0x1235,0x0000 changes to
-             * 0x1234,0x8000 and we read it as 0x1234,0x0000). Pairs with
-             * the write barrier in stat64_min_slow.
-             */
-            smp_rmb();
-            orig_low = qatomic_read(&s->low);
-            if (orig_low <= low) {
-                return;
-            }
-
-            /* See if we were lucky and a writer raced against us.  The
-             * barrier is theoretically unnecessary, but if we remove it
-             * we may miss being lucky.
-             */
-            smp_rmb();
-            orig_high = qatomic_read(&s->high);
-            if (orig_high < high) {
-                return;
-            }
-        }
-
-        /* If the value changes in any way, we have to take the lock.  */
-    } while (!stat64_min_slow(s, value));
-}
-
-static inline void stat64_max(Stat64 *s, uint64_t value)
-{
-    uint32_t low, high;
-    uint32_t orig_low, orig_high;
-
-    high = value >> 32;
-    low = (uint32_t) value;
-    do {
-        orig_high = qatomic_read(&s->high);
-        if (orig_high > high) {
-            return;
-        }
-
-        if (orig_high == high) {
-            /* High 32 bits are equal.  Read low after high, otherwise we
-             * can get a false positive (e.g. 0x1234,0x8000 changes to
-             * 0x1235,0x0000 and we read it as 0x1235,0x8000). Pairs with
-             * the write barrier in stat64_max_slow.
-             */
-            smp_rmb();
-            orig_low = qatomic_read(&s->low);
-            if (orig_low >= low) {
-                return;
-            }
-
-            /* See if we were lucky and a writer raced against us.  The
-             * barrier is theoretically unnecessary, but if we remove it
-             * we may miss being lucky.
-             */
-            smp_rmb();
-            orig_high = qatomic_read(&s->high);
-            if (orig_high > high) {
-                return;
-            }
-        }
-
-        /* If the value changes in any way, we have to take the lock.  */
-    } while (!stat64_max_slow(s, value));
-}
-
-#endif
-
-#endif
diff --git a/util/stats64.c b/util/stats64.c
deleted file mode 100644
index 09736014ec..0000000000
--- a/util/stats64.c
+++ /dev/null
@@ -1,148 +0,0 @@
-/*
- * Atomic operations on 64-bit quantities.
- *
- * Copyright (C) 2017 Red Hat, Inc.
- *
- * Author: Paolo Bonzini <pbonzini@redhat.com>
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- */
-
-#include "qemu/osdep.h"
-#include "qemu/atomic.h"
-#include "qemu/stats64.h"
-#include "qemu/processor.h"
-
-#ifndef CONFIG_ATOMIC64
-static inline void stat64_rdlock(Stat64 *s)
-{
-    /* Keep out incoming writers to avoid them starving us. */
-    qatomic_add(&s->lock, 2);
-
-    /* If there is a concurrent writer, wait for it.  */
-    while (qatomic_read(&s->lock) & 1) {
-        cpu_relax();
-    }
-}
-
-static inline void stat64_rdunlock(Stat64 *s)
-{
-    qatomic_sub(&s->lock, 2);
-}
-
-static inline bool stat64_wrtrylock(Stat64 *s)
-{
-    return qatomic_cmpxchg(&s->lock, 0, 1) == 0;
-}
-
-static inline void stat64_wrunlock(Stat64 *s)
-{
-    qatomic_dec(&s->lock);
-}
-
-uint64_t stat64_get(const Stat64 *s)
-{
-    uint32_t high, low;
-
-    stat64_rdlock((Stat64 *)s);
-
-    /* 64-bit writes always take the lock, so we can read in
-     * any order.
-     */
-    high = qatomic_read(&s->high);
-    low = qatomic_read(&s->low);
-    stat64_rdunlock((Stat64 *)s);
-
-    return ((uint64_t)high << 32) | low;
-}
-
-void stat64_set(Stat64 *s, uint64_t val)
-{
-    while (!stat64_wrtrylock(s)) {
-        cpu_relax();
-    }
-
-    qatomic_set(&s->high, val >> 32);
-    qatomic_set(&s->low, val);
-    stat64_wrunlock(s);
-}
-
-bool stat64_add32_carry(Stat64 *s, uint32_t low, uint32_t high)
-{
-    uint32_t old;
-
-    if (!stat64_wrtrylock(s)) {
-        cpu_relax();
-        return false;
-    }
-
-    /* 64-bit reads always take the lock, so they don't care about the
-     * order of our update.  By updating s->low first, we can check
-     * whether we have to carry into s->high.
-     */
-    old = qatomic_fetch_add(&s->low, low);
-    high += (old + low) < old;
-    qatomic_add(&s->high, high);
-    stat64_wrunlock(s);
-    return true;
-}
-
-bool stat64_min_slow(Stat64 *s, uint64_t value)
-{
-    uint32_t high, low;
-    uint64_t orig;
-
-    if (!stat64_wrtrylock(s)) {
-        cpu_relax();
-        return false;
-    }
-
-    high = qatomic_read(&s->high);
-    low = qatomic_read(&s->low);
-
-    orig = ((uint64_t)high << 32) | low;
-    if (value < orig) {
-        /* We have to set low before high, just like stat64_min reads
-         * high before low.  The value may become higher temporarily, but
-         * stat64_get does not notice (it takes the lock) and the only ill
-         * effect on stat64_min is that the slow path may be triggered
-         * unnecessarily.
-         */
-        qatomic_set(&s->low, (uint32_t)value);
-        smp_wmb();
-        qatomic_set(&s->high, value >> 32);
-    }
-    stat64_wrunlock(s);
-    return true;
-}
-
-bool stat64_max_slow(Stat64 *s, uint64_t value)
-{
-    uint32_t high, low;
-    uint64_t orig;
-
-    if (!stat64_wrtrylock(s)) {
-        cpu_relax();
-        return false;
-    }
-
-    high = qatomic_read(&s->high);
-    low = qatomic_read(&s->low);
-
-    orig = ((uint64_t)high << 32) | low;
-    if (value > orig) {
-        /* We have to set low before high, just like stat64_max reads
-         * high before low.  The value may become lower temporarily, but
-         * stat64_get does not notice (it takes the lock) and the only ill
-         * effect on stat64_max is that the slow path may be triggered
-         * unnecessarily.
-         */
-        qatomic_set(&s->low, (uint32_t)value);
-        smp_wmb();
-        qatomic_set(&s->high, value >> 32);
-    }
-    stat64_wrunlock(s);
-    return true;
-}
-#endif
diff --git a/util/meson.build b/util/meson.build
index 35029380a3..d7d6b213f6 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -59,7 +59,6 @@ util_ss.add(files('qht.c'))
 util_ss.add(files('qsp.c'))
 util_ss.add(files('range.c'))
 util_ss.add(files('reserved-region.c'))
-util_ss.add(files('stats64.c'))
 util_ss.add(files('systemd.c'))
 util_ss.add(files('transactions.c'))
 util_ss.add(files('guest-random.c'))
-- 
2.43.0


