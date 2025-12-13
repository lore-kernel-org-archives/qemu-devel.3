Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C13BD59F52
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Dec 2025 00:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vUDFn-00045a-45; Fri, 12 Dec 2025 19:12:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3gK88aQoKCiML9QBLNQBNRFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--marcmorcos.bounces.google.com>)
 id 1vUDFk-00043L-UX
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 19:12:52 -0500
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3gK88aQoKCiML9QBLNQBNRFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--marcmorcos.bounces.google.com>)
 id 1vUDFj-0006ki-Ag
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 19:12:52 -0500
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-34c314a062aso363333a91.2
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 16:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1765584769; x=1766189569; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=cIINZ9mAAnwnFIApNJGoEI7Ff32PcTgxuAaJihLVJeo=;
 b=gLHOr/9Q0cBqVVVMQKxgHw4f0yR/Bi+XzGrKqAu+ABLYIvMFIlNuKvkTaYxuLOGreU
 t0e8pQAqxh1ne6WzdcrN4Ai9fX9/Aq2Knt/eNhdwbhA8QoQUXxUvr2JCz/DKiwS838vg
 F8xg3BaNXerLoJk1Z/bsvkS0EPbA+Z30kGSk/tb1C9uBqZZ/hbAHxqfWkLze35OvIQ/+
 Hu8THwmWjJqhyrT6KKkW6Bm4aZMux/BifkKQhyunSMkTQJiPgxdxHKrPZhLcRN0UqhUu
 7mUbdsublpnsnzHPcUiySR6mesW5fgmmxsQnPis+N/4FXGCrX47H0UvMd0fwK9Wk8XVY
 u2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765584769; x=1766189569;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cIINZ9mAAnwnFIApNJGoEI7Ff32PcTgxuAaJihLVJeo=;
 b=Se9g20KMMc7tUNm1xkivMmRrxqCCdAMP5Mw4eHm9KENp2NlYnSDX2V7iiGQybtg8Ps
 NYcWyBVW4DL/TTgQ8yjlDfwdBfVHUhvJJB0aEjmLE6HyrK2W1PpQwbyjGdgGsNHjHKyY
 vO0bqRuF747B2MD3KB8GY675ubDPjQjvPCbpko72YrMoajvSQZZJ6nE3Yv5ntU9HSmdV
 uSQ/snhmFJaZTYhryczdvEFyvDdr3PAuI6LFD2VhWlol+hf/qhPbLTYfPZDV/8eCNTsn
 tRjwNGXwd+6VpRF6PKmIkuna9Uo6AK2EVMR+5T6CzYsJdR6Bn/vvifjG3SaXaN8H/9Tm
 90XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTUmcbOXRuRfxheY9ByyVSNSk1jzoJQmoJlp0nFtSUfeIoQPwy4mHPEe3++Egx7uEG2dcdVHHURogL@nongnu.org
X-Gm-Message-State: AOJu0Yym42n8lJFs6tjZJD6jZlyhAlarTYXLWpYniJN7LnH0X0QVOtY5
 K4VsLsE7LWz3/CqWN+j+2cb54g9IgBXwHw1VXm9185s6y1Pt0GsaUQQ3FNBXW5x9wsLatQpwCdy
 DcbSnfWgwkBO8+e4dmkYp3Q==
X-Google-Smtp-Source: AGHT+IEvDGjYAnZwq1k9GfNaflhQiBbW4odebpw+c96Y/GOtuVtYw7zlJj4bIiP9o8Jtpl0PkkekYwITje4OK4QQ
X-Received: from dlbbq12.prod.google.com
 ([2002:a05:7022:670c:b0:11d:fd49:7806])
 (user=marcmorcos job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:a89:b0:119:e56b:957d with SMTP id
 a92af1059eb24-11f34bd9053mr3080352c88.2.1765584768791; 
 Fri, 12 Dec 2025 16:12:48 -0800 (PST)
Date: Sat, 13 Dec 2025 00:12:32 +0000
In-Reply-To: <20251213001234.2039232-1-marcmorcos@google.com>
Mime-Version: 1.0
References: <20251213001234.2039232-1-marcmorcos@google.com>
X-Mailer: git-send-email 2.52.0.239.gd5f0c6e74e-goog
Message-ID: <20251213001234.2039232-3-marcmorcos@google.com>
Subject: [PATCH 2/4] thread-pool: Fix thread race
From: Marc Morcos <marcmorcos@google.com>
To: maintainer_email_from_script@google.com
Cc: cc_list_from_script@google.com, qemu-devel@nongnu.org, 
 Marc Morcos <marcmorcos@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3gK88aQoKCiML9QBLNQBNRFNNFKD.BNLPDLT-CDUDKMNMFMT.NQF@flex--marcmorcos.bounces.google.com;
 helo=mail-pj1-x1049.google.com
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


