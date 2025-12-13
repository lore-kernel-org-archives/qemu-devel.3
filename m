Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92256D59F53
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Dec 2025 00:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vUDHn-0006g3-G9; Fri, 12 Dec 2025 19:14:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3_a88aQoKCqAMARCMORCOSGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--marcmorcos.bounces.google.com>)
 id 1vUDHl-0006eJ-KD
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 19:14:57 -0500
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3_a88aQoKCqAMARCMORCOSGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--marcmorcos.bounces.google.com>)
 id 1vUDHk-00078g-1V
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 19:14:57 -0500
Received: by mail-pg1-x549.google.com with SMTP id
 41be03b00d2f7-bddf9ce4935so1474914a12.1
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 16:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765584894; x=1766189694; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=cIINZ9mAAnwnFIApNJGoEI7Ff32PcTgxuAaJihLVJeo=;
 b=PygxctaSm8nfv8VxGpdPEYDynnK+v/SRFyGfCYO7QkLEPOOfBH3cn+qtlxMG+9uXpH
 nFcmAZPfCO5VLiNfp59egfmo3qVisLn2XPezZ50fhCPvskH+z+ce/ileyMojmZCUw/5Y
 1kguiCal7wCK+s/BBRceoQxow1V/Pg4BjRLK61fgRrBYVq3yd9fVBbn/paQOYgsrZ6Cy
 uHEqqqQRS7Feg+uYrnsdIso0ca6ay2U+SOXYI6EUyjpLH9aRk8ClEeSXsiSnk2ruylJx
 rLo5l8yFyIpKmZvLgcCXPT3XzLQpNAkkK5Xy3rxUPGDpy8FSrR/MGOXAgVtIHaUcsUCz
 QWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765584894; x=1766189694;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cIINZ9mAAnwnFIApNJGoEI7Ff32PcTgxuAaJihLVJeo=;
 b=f93JYhfTR6XKE6XGYZDfK0p3ZIWR7Z9wyvQgALNEQpEuwKHBFzECzovuyu2cWRNcBh
 bNX7UGV6UUUyHGmvfx3g91QTGjlNg2UMBh5sf+4qBKVntIXga4ACVU/saihOa5H3jygl
 uJ6FveFoH8iWSyon+iIkGVB4pbeNTMttkuyeYRbxhkojBKTQ+MvU4hvbNMdbIYn1unYy
 oEXSRj790yDpLxOyceC2hm1Bt/A6Lc70x9g7Fi/tgiQN/nx8dIOL2hoxlDwjYppSFvcY
 xru7jOLRt+y3wVdQOqkR2budyROT6uHfJ4ITN2k28y7yZ+Ep6E3vn2S2i3jVaPtvTCwS
 Cwuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVa2kjIU0be+WC2cyKlreK8XBMwlfJtiskPwpjkqZRT9E+kcTociII8AX9PzwMv8QY8dqGVzZfoVJ6Y@nongnu.org
X-Gm-Message-State: AOJu0YyJtALcddENP8GWw1BextzFLjdgtNsVVoZqrjhMUT3eY6JDg6t/
 SRDb/pdI/UBcLfwil/INxOkmzxJKSlRfEjwsqqqs/qRfbyJd9d0WA7PEv3tR1hraNQjnn5Pv4Da
 jixODYpEQOiL1/pwQLO454g==
X-Google-Smtp-Source: AGHT+IERTu/TvouPTqzMqN3ZIas79v3Ibpzrcwkdq6SBy47/OiGEzsE9m49kedocAPClataQQ5xVjjJRVwvvkCtI
X-Received: from dlg19.prod.google.com ([2002:a05:7022:793:b0:119:78ff:fe0f])
 (user=marcmorcos job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7023:a85:b0:11a:fec5:d005 with SMTP id
 a92af1059eb24-11f34bde202mr2623159c88.10.1765584893863; 
 Fri, 12 Dec 2025 16:14:53 -0800 (PST)
Date: Sat, 13 Dec 2025 00:14:41 +0000
In-Reply-To: <20251213001443.2041258-1-marcmorcos@google.com>
Mime-Version: 1.0
References: <20251213001443.2041258-1-marcmorcos@google.com>
X-Mailer: git-send-email 2.52.0.239.gd5f0c6e74e-goog
Message-ID: <20251213001443.2041258-3-marcmorcos@google.com>
Subject: [PATCH 2/4] thread-pool: Fix thread race
From: Marc Morcos <marcmorcos@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, 
 kvm@vger.kernel.org, Marc Morcos <marcmorcos@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::549;
 envelope-from=3_a88aQoKCqAMARCMORCOSGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--marcmorcos.bounces.google.com;
 helo=mail-pg1-x549.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Fix a data race occurred between `worker_thread()` writing and
`thread_pool_completion_bh()` reading shared data in `util/thread-pool.c`.

Signed-off-by: Marc Morcos <marcmorcos@google.com>
---
 util/thread-pool.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/util/thread-pool.c b/util/thread-pool.c
index d2ead6b728..1ced3bd371 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -18,6 +18,7 @@
 #include "qemu/defer-call.h"
 #include "qemu/queue.h"
 #include "qemu/thread.h"
+#include "qemu/atomic.h"
 #include "qemu/coroutine.h"
 #include "trace.h"
 #include "block/thread-pool.h"
@@ -39,9 +40,13 @@ struct ThreadPoolElementAio {
     ThreadPoolFunc *func;
     void *arg;
 
-    /* Moving state out of THREAD_QUEUED is protected by lock.  After
-     * that, only the worker thread can write to it.  Reads and writes
-     * of state and ret are ordered with memory barriers.
+    /*
+     * Accessed with atomics.  Moving state out of THREAD_QUEUED is
+     * protected by pool->lock and only the worker thread can move
+     * the state from THREAD_ACTIVE to THREAD_DONE.
+     *
+     * When state is THREAD_DONE, ret must have been written already.
+     * Use acquire/release ordering when reading/writing ret as well.
      */
     enum ThreadState state;
     int ret;
@@ -105,15 +110,14 @@ static void *worker_thread(void *opaque)
 
         req = QTAILQ_FIRST(&pool->request_list);
         QTAILQ_REMOVE(&pool->request_list, req, reqs);
-        req->state = THREAD_ACTIVE;
+        qatomic_set(&req->state, THREAD_ACTIVE);
         qemu_mutex_unlock(&pool->lock);
 
         ret = req->func(req->arg);
 
         req->ret = ret;
-        /* Write ret before state.  */
-        smp_wmb();
-        req->state = THREAD_DONE;
+        /* _release to write ret before state.  */
+        qatomic_store_release(&req->state, THREAD_DONE);
 
         qemu_bh_schedule(pool->completion_bh);
         qemu_mutex_lock(&pool->lock);
@@ -180,7 +184,8 @@ static void thread_pool_completion_bh(void *opaque)
 
 restart:
     QLIST_FOREACH_SAFE(elem, &pool->head, all, next) {
-        if (elem->state != THREAD_DONE) {
+        /* _acquire to read state before ret.  */
+        if (qatomic_load_acquire(&elem->state) != THREAD_DONE) {
             continue;
         }
 
@@ -189,9 +194,6 @@ restart:
         QLIST_REMOVE(elem, all);
 
         if (elem->common.cb) {
-            /* Read state before ret.  */
-            smp_rmb();
-
             /* Schedule ourselves in case elem->common.cb() calls aio_poll() to
              * wait for another request that completed at the same time.
              */
@@ -223,12 +225,12 @@ static void thread_pool_cancel(BlockAIOCB *acb)
     trace_thread_pool_cancel_aio(elem, elem->common.opaque);
 
     QEMU_LOCK_GUARD(&pool->lock);
-    if (elem->state == THREAD_QUEUED) {
+    if (qatomic_read(&elem->state) == THREAD_QUEUED) {
         QTAILQ_REMOVE(&pool->request_list, elem, reqs);
         qemu_bh_schedule(pool->completion_bh);
 
-        elem->state = THREAD_DONE;
-        elem->ret = -ECANCELED;
+        qatomic_set(&elem->ret, -ECANCELED);
+        qatomic_store_release(&elem->state, THREAD_DONE);
     }
 
 }
-- 
2.52.0.239.gd5f0c6e74e-goog


