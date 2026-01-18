Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F94C9830C
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:10:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhaxi-0001NV-D2; Sun, 18 Jan 2026 17:09:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhaxc-0000iT-Jc
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:09:28 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhaxZ-0001ed-5J
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:09:27 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2a09d981507so26997055ad.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768774164; x=1769378964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lL29N2VWw0Lqbbdj3QFDL4vdVxUWKQ/hHfpVJMWA/Kc=;
 b=BQ11A+3ONkl3bSMagckColZPkRC+xO9HQTLCEy+wXsgB/EtoBVohvSTJ22lFZiju+x
 9Gmi/eheOeM0eRO7+F3Qz3LMYdOFOY1tUPMPsfE5+XUIgUfl/NmbtfvEEDS+9b4ko2P3
 CNeVQLdPAALm9TGHFv9aTyUCYE6BTalp/7y3o1n/ftCfIS4486kvK/cOq92TAD+NPoHg
 gkz7vDmF56bEyqXmRwZTrY8VuMKMKR4xKxUfKazBSxrHF4Q03CqyCeeO4Eu6z8UOna+g
 yhGRJxc3GNvhPjmLGVknllR5mKJBKOeFv9YDESIPpiUceVbidFkR069ZvYJ6zqRu5fAW
 4tPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768774164; x=1769378964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lL29N2VWw0Lqbbdj3QFDL4vdVxUWKQ/hHfpVJMWA/Kc=;
 b=V/d8ist4A1NZ/U74OdoEfj3M6fRW4cNJLI54SmaGpdkc/+FlpPmVKgkvXNYd8Zrtva
 Z9Pfs8X6+iV/usqkpXeFGnqT54exrh+VP1brJU7XGV5e5ZbBgfLdawhTyifM6mH82HQF
 J06cb7J0TyvIrPC/b9uwNU5LdT7r9HUpF8mADL+yyW/CJOElQVtDrDeH6QN2T+0SMsH5
 hcmaHh0K5EvjF8hVWS0EEQp5KtMWuUlX0JcRF/xuvdgCEukeQp9dS6RjgdmKCHiROkRb
 lHt0rfpj4nV46o/c90q48t/e8sr4bHAkzxf6T9+2nXe1prwfydu/58pbQh+y/i44az1O
 Om1g==
X-Gm-Message-State: AOJu0YygfAtQ3tk6+6R2TZRdsRtkOYUJdhcIoOHJcX/hp99SeL2ynpgl
 XvpRTSdZro4ulKj7tLXhq8/XFCmlA3R+wnwbQGcZF9HkYwkPYTd7frWj6dI03AVNFaZA0ouqi1V
 xsSrNARKOkg==
X-Gm-Gg: AY/fxX60ipwBKSm1x0exLTgGLupnlKlBp357tF8Fs6cit2ZL8PBET7w2pijLDH55jI/
 NEwR8ke7Z3CMB2gdVETjZUlJAy5qdD96uX6JTp6sGqnoC23QjsGIG5tbKpLFlLXpGgsMiPh3u8t
 Dlf4MuQMwvA9jbXBajn66LOjuVFtN3EzUE6xNqFRQc7xNoFuIoQKdpHNIaFfhr11cEW9I4lErsA
 5KJ3QNflGul4mN+bO/zBKf8wLLFUJQjWAJVMQYCxXOKfuFG+AVFjTXqWJJNLrozc2UXH0c0z1ea
 oKKhLRT7ravEn64UoaeICybUJCi9410JQqlCkdyA5DNbvFtBjCmUieGIxtGSFx8L0fjUq5C04tm
 P100uG0qT1E3Z5jEaTbKnJoyhMZN2DZdSfvuEMFlibRmc/8c/6hcQ+JzrNyUCCNhLmIlVSBb/2n
 jFCnl4CRRvLh8l2efQYw==
X-Received: by 2002:a17:903:8c7:b0:298:45e5:54a4 with SMTP id
 d9443c01a7336-2a7175460acmr90325415ad.1.1768774163478; 
 Sun, 18 Jan 2026 14:09:23 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190ab921sm73298205ad.8.2026.01.18.14.09.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:09:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 51/54] util: Remove stats64
Date: Mon, 19 Jan 2026 09:04:11 +1100
Message-ID: <20260118220414.8177-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


