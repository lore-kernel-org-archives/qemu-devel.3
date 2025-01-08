Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1249DE7719A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 14:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVXA1-0006xr-UU; Wed, 08 Jan 2025 09:35:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <craig.blackmore@embecosm.com>)
 id 1tVXA0-0006ws-00
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 09:35:52 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <craig.blackmore@embecosm.com>)
 id 1tVX9w-0006bY-RZ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 09:35:51 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4368a293339so137402755e9.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 06:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1736346947; x=1736951747; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0iGYqWP4PTuAkDwFXJhbVYiarmXqHTjD9rai41KZ6hc=;
 b=NxKqoP3+g5/2K9ppV8ac6UGTPENkXrZ+tjZGWwqsRTErpShH7krIkPFy8uxhI49ZRt
 2jcsiRVOn2D6S4HOIeff+MRnmOOqHI0yvmTn+2ge0ZkEpYotDaieo9jzgrLl6LswmE/n
 xUJKJnxzIx8Mo/XD0T146l3j1NoT0kpu5zkRL84aStp/2lVEH1GH5Tz6nhk4eNQ+IJC9
 AXkbyr2fVBNlevNurlWVrp4DPc6mM1Z2qyJmFuKyOyG1KyTqPUPFS1+lrGbkgH9qmeLI
 rDWfOK4MTHSpOldJM5lfaSKYzSvVibir1Dpo/Nldn8YdWJ6XVpolxpRy032rUhqqwxYz
 kQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736346947; x=1736951747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0iGYqWP4PTuAkDwFXJhbVYiarmXqHTjD9rai41KZ6hc=;
 b=kXUkSS4isEYJWX8H/O2mCVMqrHFreSNnZf7lqAUj3MUdyg3ddZE2u9BxiNK4E50i2Y
 h0f2WcAxyryv5NlVecKnkCxxzkDRJykrBQ6dY1oPhMe2nuF/3ZNNWqFXlpRttkzF9f7p
 93ZaqWZFz/1HYV3GCnngkgwzlisZT9nuc5FJTXJimfvsnUIcKvzIesSCIJop6jpY1lMt
 PzpORy6fkrvHevjOaw6pFwJAh5yX6Z+ghS4GiJaj+Ba2CDMLZGvUeMPmNYDwF+lrhYHC
 5w4w/miqnlhPUQwQVmHKa1W0MoWYh2KADI4KH+cUwCUbkGaci+NAN2+NtFyMNtExG22Q
 6YeQ==
X-Gm-Message-State: AOJu0YxqQ17q/6/Rs/uqzUHfT9wHWo8z2JJwn2F7yXZR3BoNM9KX9UYh
 3Nv9RIhoDY4pj8T6gYVa+IWmwuddS8/XFLfrhoJe6obe5C5MHr6ZhxBYzJmbk8bC9us6guxF5rS
 fIHM=
X-Gm-Gg: ASbGncujCo4OsGbkDfstiLAGwnSU1rP1QQ4QH5vam5uMhN2QxQO0iQ5MlJ+Zs6dg5kW
 IaMy0JMZbtnV9VuFF/9tIjkNITHvtfWytTT1O9SqtfceLq2/gdnQ8w2rxIKBL05dz8L56zfxN69
 LjbvhoMW+c4tGg4vzdN6BDSvEA8RNx4277dCL2EsNVyCsJk0HpJ0lm0oxoE2yi0QDDoeIENu5qQ
 GFtclKl5FJfsl0teiVvX2dAKQdXRp9p70yoX22UVqLk0ZTyZTqDPl03pMqFObowJnpbT4p5PmKs
 8VTu5puejfQMqubUaIYFEpdxOnP8JsOQD8gHk2jkof6bRvMq
X-Google-Smtp-Source: AGHT+IGDOmM17MJxokkC3gYZDwQHtjdaq7/FLE+3tzvnsVbRRpvPXHEM7W/oISw5UL/aHhZlu8EVQQ==
X-Received: by 2002:a05:6000:1a89:b0:385:fc8c:24b6 with SMTP id
 ffacd0b85a97d-38a8730b2femr2595175f8f.27.1736346946672; 
 Wed, 08 Jan 2025 06:35:46 -0800 (PST)
Received: from dorian..
 (sals-04-b2-v4wan-167965-cust660.vm36.cable.virginm.net. [80.3.10.149])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8330d4sm52450316f8f.29.2025.01.08.06.35.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 06:35:46 -0800 (PST)
From: Craig Blackmore <craig.blackmore@embecosm.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Craig Blackmore <craig.blackmore@embecosm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>, Paolo Savini <paolo.savini@embecosm.com>
Subject: [PATCH v8 1/1] target/riscv: rvv: Use wider accesses for unit stride
 load/store
Date: Wed,  8 Jan 2025 14:35:23 +0000
Message-ID: <20250108143523.153010-2-craig.blackmore@embecosm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250108143523.153010-1-craig.blackmore@embecosm.com>
References: <20250108143523.153010-1-craig.blackmore@embecosm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=craig.blackmore@embecosm.com; helo=mail-wm1-x32c.google.com
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

Use atomic load/store functions to access multiple elements from host.

Co-authored-by: Paolo Savini <paolo.savini@embecosm.com>

Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
Signed-off-by: Craig Blackmore <craig.blackmore@embecosm.com>
---
 target/riscv/vector_helper.c | 90 ++++++++++++++++++++++++++++++++----
 1 file changed, 82 insertions(+), 8 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index a85dd1d200..c0cb5c0ee1 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -206,30 +206,104 @@ vext_continus_ldst_tlb(CPURISCVState *env, vext_ldst_elem_fn_tlb *ldst_tlb,
     }
 }
 
+#if !HOST_BIG_ENDIAN
+/* Atomic operations for load/store */
+
+#define GEN_VEXT_LDST_ATOMIC_HOST(SIZE, TYPE)                             \
+static inline QEMU_ALWAYS_INLINE void                                     \
+vext_ldst_atom_##SIZE##_host(void *vd, uint32_t byte_offset, TYPE *host,  \
+                             bool is_load)                                \
+{                                                                         \
+    TYPE *vd_ptr = (TYPE *) (vd + byte_offset);                           \
+    if (is_load) {                                                        \
+        *vd_ptr = qatomic_read__nocheck(host);                            \
+    } else {                                                              \
+        qatomic_set__nocheck(host, *vd_ptr);                              \
+    }                                                                     \
+}                                                                         \
+
+GEN_VEXT_LDST_ATOMIC_HOST(2, uint16_t)
+GEN_VEXT_LDST_ATOMIC_HOST(4, uint32_t)
+#ifdef CONFIG_ATOMIC64
+GEN_VEXT_LDST_ATOMIC_HOST(8, uint64_t)
+#endif
+
+static inline QEMU_ALWAYS_INLINE void
+vext_ldst_atom_16_host(void *vd, uint32_t byte_offset, Int128 *host,
+                       bool is_load)
+{
+    Int128 *vd_ptr = (Int128 *) (vd + byte_offset);
+    if (is_load) {
+        *vd_ptr = atomic16_read_ro(host);
+    } else {
+        atomic16_set(host, *vd_ptr);
+    }
+}
+#endif
+
 static inline QEMU_ALWAYS_INLINE void
 vext_continus_ldst_host(CPURISCVState *env, vext_ldst_elem_fn_host *ldst_host,
                         void *vd, uint32_t evl, uint32_t reg_start, void *host,
-                        uint32_t esz, bool is_load)
+                        uint32_t esz, bool is_load, uint32_t log2_esz)
 {
 #if HOST_BIG_ENDIAN
     for (; reg_start < evl; reg_start++, host += esz) {
         ldst_host(vd, reg_start, host);
     }
 #else
-    if (esz == 1) {
-        uint32_t byte_offset = reg_start * esz;
-        uint32_t size = (evl - reg_start) * esz;
+    uint32_t size = (evl - reg_start) * esz;
+    uint32_t test = (uintptr_t) host;
 
+    /* Misaligned load/stores do not require any atomicity */
+    if (esz == 1 || unlikely(test % esz != 0)) {
+        uint32_t byte_offset = reg_start * esz;
         if (is_load) {
             memcpy(vd + byte_offset, host, size);
         } else {
             memcpy(host, vd + byte_offset, size);
         }
-    } else {
-        for (; reg_start < evl; reg_start++, host += esz) {
-            ldst_host(vd, reg_start, host);
+        return;
+    }
+
+    /*
+     * At this point esz > 1 and host is aligned to at least esz, so the ldst
+     * can be completed in atomic chunks of at least esz.
+     */
+
+    /* Test that both alignment and size are multiples of the atomic width. */
+    test |= size;
+
+    /*
+     * If !HAVE_ATOMIC128_RO, then atomic16_set may be implemented with a
+     * 16-byte compare and store loop, which is expensive, so prefer two 8-byte
+     * stores in this case.
+     */
+    if (HAVE_ATOMIC128_RO && (is_load || HAVE_ATOMIC128_RW)
+        && (test % 16 == 0)) {
+        for (; reg_start < evl; reg_start += 16 >> log2_esz, host += 16) {
+            vext_ldst_atom_16_host(vd, reg_start * esz, host, is_load);
+        }
+        return;
+    }
+    if (test % 8 == 0) {
+        for (; reg_start < evl; reg_start += 8 >> log2_esz, host += 8) {
+            vext_ldst_atom_8_host(vd, reg_start * esz, host, is_load);
+        }
+        return;
+    }
+    if (test % 4 == 0) {
+        for (; reg_start < evl; reg_start += 4 >> log2_esz, host += 4) {
+            vext_ldst_atom_4_host(vd, reg_start * esz, host, is_load);
         }
+        return;
+    }
+    if (test % 2 == 0) {
+        for (; reg_start < evl; reg_start += 2 >> log2_esz, host += 2) {
+            vext_ldst_atom_2_host(vd, reg_start * esz, host, is_load);
+        }
+        return;
     }
+    g_assert_not_reached();
 #endif
 }
 
@@ -343,7 +417,7 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, target_ulong addr,
     if (flags == 0) {
         if (nf == 1) {
             vext_continus_ldst_host(env, ldst_host, vd, evl, env->vstart, host,
-                                    esz, is_load);
+                                    esz, is_load, log2_esz);
         } else {
             for (i = env->vstart; i < evl; ++i) {
                 k = 0;
-- 
2.43.0


