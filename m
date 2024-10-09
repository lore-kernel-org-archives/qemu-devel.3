Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3255ACED611
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 23:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syfnv-0006pY-N4; Wed, 09 Oct 2024 19:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1syfnr-0006nf-N2
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:09:11 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1syfnp-0000i7-9P
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 19:09:10 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2e221a7e7baso274151a91.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 16:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728515348; x=1729120148;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IvdoegZ6AwTbZGebnJ5OefWg6Yz9UTpv5gPPyIUdjh8=;
 b=yyP//fRLyMwqT5iI6wSu1M6Wo5Eb9QdfE3kGs6cotu9i5hlNmPVInHO9s7vj+bTfZe
 YoEfDul5cq/HXOlkWWjZ7AoICcXcBKFNtrSb0XMiEGMblNokZjgxWdatxUX/YlGOyAZM
 DlbYIn+OP1r1NmKB+hPJb2TgFgX7sXp91B6RhR5/BgbLgrR+WUZr8YvaJGzDh8lkgYNh
 TAEtVwXrMcvCRrdW3wURdfLrw4E60n5abWZatF2ydLeFJ9QFBh6ND23HgJKsjSTQb0Ws
 TAutGAhTSG899gfJTFHDXewaCpO7FdOm5K8laKqmY8YxKHxc+ymNDRiZwRZQUXqFP8Md
 +AXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728515348; x=1729120148;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IvdoegZ6AwTbZGebnJ5OefWg6Yz9UTpv5gPPyIUdjh8=;
 b=Av5lThVgB4VwMkb3hUweHCAorjAGi2pk+ZDKHdUYqeiQ1dghzKLOZrTgqeaKbdWf1e
 Gjs9TW3/7oQWRG2bHpJIn15f6kzsLeUvEUTwb0N36YvzZKmY4mkkZ+WxUcaK0+u/WONV
 fy13EvWoZL6O7vqL6uDLap93ISJ3QWUi76DOR26Thkks7PV9tjTA6UmqSjyx/GtYr5ka
 zjw/ubLv8OjbIAtn5BIp+vgENkelMbXZ07bh4X+cI/H5rtDfnvUr+o4TuaM25YLKmlEP
 gckMSyubaPM5aX5EOYa71mEjcdI80t2bs+CTve/LO9vckXYDq9Rdyd6DqBGLB7499riR
 3ZAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkQFUcw1YIYQYO/aKfFm51ZevSM3NqKXHYDSDq84TweHKzjGcwvlN7jMa//LBDS835AbNL/XsxV6sn@nongnu.org
X-Gm-Message-State: AOJu0Yw17fGGATRiRyE1Scg+O14z0w/gOxbre4cBEMGWFjdCCsRs8U8m
 t/YauWAKH8ksIY+53v/F1lZneRLH2CI4CZ8k/riMDQ/zjApPRpn542aEeDqUHkQ=
X-Google-Smtp-Source: AGHT+IFM5dewSyuLQZRh1cyyivbPcufR3D+JNCo8h9++Lc+MovvRsJbrf9BvhDZqgNzAXH/9tr/zEg==
X-Received: by 2002:a17:90b:4f85:b0:2c9:5a85:f8dd with SMTP id
 98e67ed59e1d1-2e2a236bbd1mr4795438a91.18.1728515347812; 
 Wed, 09 Oct 2024 16:09:07 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2a55f9855sm2271902a91.2.2024.10.09.16.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 16:09:07 -0700 (PDT)
From: Atish Patra <atishp@rivosinc.com>
Date: Wed, 09 Oct 2024 16:09:02 -0700
Subject: [PATCH RFC 04/10] target/riscv: Use uint64 instead of uint as key
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-pmu_event_machine-v1-4-dcbd7a60e3ba@rivosinc.com>
References: <20241009-pmu_event_machine-v1-0-dcbd7a60e3ba@rivosinc.com>
In-Reply-To: <20241009-pmu_event_machine-v1-0-dcbd7a60e3ba@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alexei.filippov@syntacore.com, Atish Patra <atishp@rivosinc.com>, 
 palmer@dabbelt.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 bin.meng@windriver.com, dbarboza@ventanamicro.com, alistair.francis@wdc.com
X-Mailer: b4 0.15-dev-13183
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=atishp@rivosinc.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The event ID can be a upto 56 bit value when sscofpmf is implemented.
Change the event to counter hashtable to store the keys as 64 bit value
instead of uint.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/pmu.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
index 21377518f4e0..2531d4f1a9c1 100644
--- a/target/riscv/pmu.c
+++ b/target/riscv/pmu.c
@@ -265,14 +265,14 @@ static void riscv_pmu_cycle_update_priv(CPURISCVState *env,
     counter_arr[env->priv] += delta;
 }
 
-static bool riscv_pmu_htable_lookup(RISCVCPU *cpu, uint32_t key,
+static bool riscv_pmu_htable_lookup(RISCVCPU *cpu, uint64_t key,
                                     uint32_t *value)
 {
     GHashTable *table = cpu->pmu_event_ctr_map;
     gpointer val_ptr;
 
     pthread_rwlock_rdlock(&cpu->pmu_map_lock);
-    gpointer val_ptr = g_hash_table_lookup(table, GUINT_TO_POINTER(key));
+    val_ptr = g_hash_table_lookup(table, &key);
     if (!val_ptr) {
         pthread_rwlock_unlock(&cpu->pmu_map_lock);
         return false;
@@ -378,9 +378,10 @@ static int64_t pmu_icount_ticks_to_ns(int64_t value)
 int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
                                uint32_t ctr_idx)
 {
-    uint32_t event_idx;
+    uint64_t event_idx;
     RISCVCPU *cpu = env_archcpu(env);
     uint32_t mapped_ctr_idx;
+    gint64 *eid_ptr;
 
     if (!riscv_pmu_counter_valid(cpu, ctr_idx) || !cpu->pmu_event_ctr_map) {
         return -1;
@@ -415,8 +416,10 @@ int riscv_pmu_update_event_map(CPURISCVState *env, uint64_t value,
         /* We don't support any raw events right now */
         return -1;
     }
+    eid_ptr = g_new(gint64, 1);
+    *eid_ptr = event_idx;
     pthread_rwlock_wrlock(&cpu->pmu_map_lock);
-    g_hash_table_insert(cpu->pmu_event_ctr_map, GUINT_TO_POINTER(event_idx),
+    g_hash_table_insert(cpu->pmu_event_ctr_map, eid_ptr,
                         GUINT_TO_POINTER(ctr_idx));
     pthread_rwlock_unlock(&cpu->pmu_map_lock);
 
@@ -597,7 +600,8 @@ void riscv_pmu_init(RISCVCPU *cpu, Error **errp)
         return;
     }
 
-    cpu->pmu_event_ctr_map = g_hash_table_new(g_direct_hash, g_direct_equal);
+    cpu->pmu_event_ctr_map = g_hash_table_new_full(g_int64_hash, g_int64_equal,
+                                                   g_free, NULL);
     if (!cpu->pmu_event_ctr_map) {
         error_setg(errp, "Unable to allocate PMU event hash table");
         return;

-- 
2.34.1


