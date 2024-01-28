Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CDDC47258
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 04:45:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTwzy-0004dm-J7; Sat, 27 Jan 2024 23:42:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTwzx-0004de-CD
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:42:25 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTwzv-0004FP-CV
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 23:42:25 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d8a66a2976so16568165ad.2
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 20:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706416942; x=1707021742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qYS/soxWe3h+ML5uFbbfcdAcoE+eOI+G62ajUSGtp3A=;
 b=NV03rp4b5mca3d5+wtx2dlG+sEm8M5fPIhm0xpVxRB2sT0bV1gHbxeS1Kg1HUMamv4
 KmzLSZQ2TSwcN8cPt13X3hpUTAjLJgG5DKMQOlkg/9nIaV7ozNoLmW3PGPWdyU+3shKW
 VoHTbxYISyx6yukFYNynYfpcTpMGkm9Iule9rfdS0bk+X3Hu/TaFH4UqFwWkZESXcUBr
 YbxMfGffC3f6grFvu7qHxbFKXVhDNWuZG4zODVWfQ9fRGv3CGILQX651QOuQyMz5lXKP
 HPFhxD6yI7D5VFbECD64Ond0r9/G0J72KOtq8saRUVsMju7Nbh9Z40M27NDT+ts0mVEZ
 XQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706416942; x=1707021742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qYS/soxWe3h+ML5uFbbfcdAcoE+eOI+G62ajUSGtp3A=;
 b=HB/e4ZDDITxowWQGGaBPmk31/mUOUBJW93Dn5u3nQkug679cjUzAYWatzeIUh1O8iL
 Jxu/OIeAKCM2Ptc+QoXBxZqdi3eWanP+k23/3qHepHvhNT2LIsGD9VLtRneZz0miqYIi
 ryaPRl+Ds6LHAOoxJ1F06PvyBUKVAoScjnfWMyL+uOUYxJzT23DJoYbgiMk6ewVAVCJR
 el4LPtDrdKdHG14RRyEZexLnOccegx0BXDHy8tXDmU07Uct3A3+WBt+HqBD1Z+YDVRVE
 02CYU9XGfAgmedlukWU5Gf10Y0KVy93F0lQsVhjynJa6tLWuyh102S03zfw1qNjhODzD
 pGmg==
X-Gm-Message-State: AOJu0YzF3nPV5rEoQi7JuwpvPXfH2DZr6BXWBsKvyUr9BS+TxdfY8s+Z
 6Oa28IZGQrB9zxJaRVLlfDRHY0PovXnWohVq+2+kF1o1sKN//BmVzwds1rZrLD8mvL3O5zPNxXo
 iUdA=
X-Google-Smtp-Source: AGHT+IEtpG0xYW2IvKMcsCluwn6z8i/pAYdzzp3E1QPXpfLDngjMOcm0qyzKJzji3XignqEFUT3dDw==
X-Received: by 2002:a17:902:e84b:b0:1d8:d71b:8801 with SMTP id
 t11-20020a170902e84b00b001d8d71b8801mr119288plg.54.1706416941824; 
 Sat, 27 Jan 2024 20:42:21 -0800 (PST)
Received: from stoup..
 (ppp121-45-131-89.bri-pow-que-bras31.tpg.internode.on.net. [121.45.131.89])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a17090aaf9800b002906e09e1d1sm5631873pjq.18.2024.01.27.20.42.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 20:42:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 01/33] cpu-exec: simplify jump cache management
Date: Sun, 28 Jan 2024 14:41:41 +1000
Message-Id: <20240128044213.316480-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128044213.316480-1-richard.henderson@linaro.org>
References: <20240128044213.316480-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

Unless I'm missing something egregious, the jmp cache is only every
populated with a valid entry by the same thread that reads the cache.
Therefore, the contents of any valid entry are always consistent and
there is no need for any acquire/release magic.

Indeed ->tb has to be accessed with atomics, because concurrent
invalidations would otherwise cause data races.  But ->pc is only ever
accessed by one thread, and accesses to ->tb and ->pc within tb_lookup
can never race with another tb_lookup.  While the TranslationBlock
(especially the flags) could be modified by a concurrent invalidation,
store-release and load-acquire operations on the cache entry would
not add any additional ordering beyond what you get from performing
the accesses within a single thread.

Because of this, there is really nothing to win in splitting the CF_PCREL
and !CF_PCREL paths.  It is easier to just always use the ->pc field in
the jump cache.

I noticed this while working on splitting commit 8ed558ec0cb
("accel/tcg: Introduce TARGET_TB_PCREL", 2022-10-04) into multiple
pieces, for the sake of finding a more fine-grained bisection
result for https://gitlab.com/qemu-project/qemu/-/issues/2092.
It does not (and does not intend to) fix that issue; therefore
it may make sense to not commit it until the root cause
of issue #2092 is found.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240122153409.351959-1-pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tb-jmp-cache.h |  8 +++--
 accel/tcg/cpu-exec.c     | 66 ++++++++++++++--------------------------
 2 files changed, 28 insertions(+), 46 deletions(-)

diff --git a/accel/tcg/tb-jmp-cache.h b/accel/tcg/tb-jmp-cache.h
index bb424c8a05..4ab8553afc 100644
--- a/accel/tcg/tb-jmp-cache.h
+++ b/accel/tcg/tb-jmp-cache.h
@@ -13,9 +13,11 @@
 #define TB_JMP_CACHE_SIZE (1 << TB_JMP_CACHE_BITS)
 
 /*
- * Accessed in parallel; all accesses to 'tb' must be atomic.
- * For CF_PCREL, accesses to 'pc' must be protected by a
- * load_acquire/store_release to 'tb'.
+ * Invalidated in parallel; all accesses to 'tb' must be atomic.
+ * A valid entry is read/written by a single CPU, therefore there is
+ * no need for qatomic_rcu_read() and pc is always consistent with a
+ * non-NULL value of 'tb'.  Strictly speaking pc is only needed for
+ * CF_PCREL, but it's used always for simplicity.
  */
 struct CPUJumpCache {
     struct rcu_head rcu;
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 67eda9865e..40c268bfa1 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -253,43 +253,29 @@ static inline TranslationBlock *tb_lookup(CPUState *cpu, vaddr pc,
     hash = tb_jmp_cache_hash_func(pc);
     jc = cpu->tb_jmp_cache;
 
-    if (cflags & CF_PCREL) {
-        /* Use acquire to ensure current load of pc from jc. */
-        tb = qatomic_load_acquire(&jc->array[hash].tb);
-
-        if (likely(tb &&
-                   jc->array[hash].pc == pc &&
-                   tb->cs_base == cs_base &&
-                   tb->flags == flags &&
-                   tb_cflags(tb) == cflags)) {
-            return tb;
-        }
-        tb = tb_htable_lookup(cpu, pc, cs_base, flags, cflags);
-        if (tb == NULL) {
-            return NULL;
-        }
-        jc->array[hash].pc = pc;
-        /* Ensure pc is written first. */
-        qatomic_store_release(&jc->array[hash].tb, tb);
-    } else {
-        /* Use rcu_read to ensure current load of pc from *tb. */
-        tb = qatomic_rcu_read(&jc->array[hash].tb);
-
-        if (likely(tb &&
-                   tb->pc == pc &&
-                   tb->cs_base == cs_base &&
-                   tb->flags == flags &&
-                   tb_cflags(tb) == cflags)) {
-            return tb;
-        }
-        tb = tb_htable_lookup(cpu, pc, cs_base, flags, cflags);
-        if (tb == NULL) {
-            return NULL;
-        }
-        /* Use the pc value already stored in tb->pc. */
-        qatomic_set(&jc->array[hash].tb, tb);
+    tb = qatomic_read(&jc->array[hash].tb);
+    if (likely(tb &&
+               jc->array[hash].pc == pc &&
+               tb->cs_base == cs_base &&
+               tb->flags == flags &&
+               tb_cflags(tb) == cflags)) {
+        goto hit;
     }
 
+    tb = tb_htable_lookup(cpu, pc, cs_base, flags, cflags);
+    if (tb == NULL) {
+        return NULL;
+    }
+
+    jc->array[hash].pc = pc;
+    qatomic_set(&jc->array[hash].tb, tb);
+
+hit:
+    /*
+     * As long as tb is not NULL, the contents are consistent.  Therefore,
+     * the virtual PC has to match for non-CF_PCREL translations.
+     */
+    assert((tb_cflags(tb) & CF_PCREL) || tb->pc == pc);
     return tb;
 }
 
@@ -1012,14 +998,8 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
                  */
                 h = tb_jmp_cache_hash_func(pc);
                 jc = cpu->tb_jmp_cache;
-                if (cflags & CF_PCREL) {
-                    jc->array[h].pc = pc;
-                    /* Ensure pc is written first. */
-                    qatomic_store_release(&jc->array[h].tb, tb);
-                } else {
-                    /* Use the pc value already stored in tb->pc. */
-                    qatomic_set(&jc->array[h].tb, tb);
-                }
+                jc->array[h].pc = pc;
+                qatomic_set(&jc->array[h].tb, tb);
             }
 
 #ifndef CONFIG_USER_ONLY
-- 
2.34.1


