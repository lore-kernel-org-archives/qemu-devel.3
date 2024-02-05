Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0ED8C4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 14:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWzuM-0001eE-3q; Mon, 05 Feb 2024 09:25:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rWzuJ-0001Xu-Hi
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 09:25:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rWzuG-0003v2-DV
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 09:25:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707143106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZWTIK5KAygvgdY13aOV1C3dNPuYdd9HjyH67iwQWfqY=;
 b=CnI238L6KHo2TPY81Eet0XU6laGmWmV7F5j62p5noKy6LLJfgOGlMllg1jHryLGk9rJ31z
 J6gJE1mihg47mji7VGyy4/iH8a/74R2oAf3YNKGB3F6D8PUlzD03FJxiNG6EBNh72s70ps
 0NZI7kilVJ+W4plGC0k0I4Tte8x3u4o=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-YewDnY4dOdKesMN6BsHByQ-1; Mon, 05 Feb 2024 09:25:05 -0500
X-MC-Unique: YewDnY4dOdKesMN6BsHByQ-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-59a95f8618dso672597eaf.1
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 06:25:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707143104; x=1707747904;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZWTIK5KAygvgdY13aOV1C3dNPuYdd9HjyH67iwQWfqY=;
 b=Y1HTbzK2qwEIJYkevt/fp3QzxYGterz7jBes7rx4Yq8oIBUC+ytTmOe/5Mg6aKZWJ6
 7MX+YOCCi+yuoEJtZF6HohMIC3EkLoPZ05YND7b0cUK50HRqjh66CJmKBs5CfZIG7G11
 +hqu4BXzeF2wPZQ2wDv070wyVvOqKh10OjzXt6JvWF5JRkQXZJqdLi/migE3YeWkKBkk
 PHbyrQ8PdLpF5zML+aWROwR+02uA5Q+aK2UEJL+vOKOR+ciLvhBZtnBSzKChlD0nQX6l
 wY5MAgo6ZF0U3jrDXLLU7cTfe+1+QZrawNlgCOsDV5erU6fdnoI8dRPxm2iw/wBLWOt4
 iG3g==
X-Gm-Message-State: AOJu0YyuRML/j2teFwjM+5k/mClSvzkmZ+8tSX/SNlDxG7icojkCO3x9
 osLxxstbT4Fdf6t+xyUKdahP+xwOnICYz2rLtixAlE9yyNpGD5gOsabBYyAjxEH7eA7TXf9OKZK
 0H2f9fCMHBg+LCbSfaaINgvE8bhKrAg2d1TJxgnr/i2H6a37TvR+A
X-Received: by 2002:a05:6359:4125:b0:178:9f1d:65ea with SMTP id
 kh37-20020a056359412500b001789f1d65eamr15444468rwc.1.1707143104508; 
 Mon, 05 Feb 2024 06:25:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRvFNa0k9vn/HwFrYAU6hPN5WzduLnI6P8pjStUP3L7slmxf9ZuaKQPnetgPpbNMrEBHAVgQ==
X-Received: by 2002:a05:6359:4125:b0:178:9f1d:65ea with SMTP id
 kh37-20020a056359412500b001789f1d65eamr15444455rwc.1.1707143104147; 
 Mon, 05 Feb 2024 06:25:04 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVGkJbcJFvMHx0XtQAb91Kc1+fIct5PBXHUkSFQO6cAJupSn/M150qBBld3bcbAl2XNX+UIMiN6L9GIHsrl844bbwBFJlVkyXM/C0Vj6ZK6zbXROwIMdOcS2S4+D+XQftC+2lQEocFw9bg49xGWxAskQfjv87k+NtYWFEqWU9Xs+EhbPkpXyDYaa+l+wc6i0wRuxNskSQ7uE593Tavl6dA=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 o23-20020a639217000000b005dc1281f21fsm3432050pgd.2.2024.02.05.06.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 06:25:03 -0800 (PST)
Date: Mon, 5 Feb 2024 22:24:55 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Hao Xiang <hao.xiang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>,
 Avihai Horon <avihaih@nvidia.com>, Yuan Liu <yuan1.liu@intel.com>,
 Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2 23/23] migration/multifd: Optimize sender side to be
 lockless
Message-ID: <ZcDvt7ASULc-Xb_A@x1n>
References: <20240202102857.110210-1-peterx@redhat.com>
 <20240202102857.110210-24-peterx@redhat.com>
 <87wmrmft4f.fsf@suse.de> <ZcBloXUWBORVraiu@x1n>
 <87cytb57dx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87cytb57dx.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Feb 05, 2024 at 11:10:34AM -0300, Fabiano Rosas wrote:
> > (maybe I can repost this single patch in-place to avoid another round of
> >  mail bombs..)
> 
> Sure.

I've got the final version attached here.  Feel free to have a look, thanks.

====
From 6ba337320430feae4ce9d3d906ea19f68430642d Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Fri, 2 Feb 2024 18:28:57 +0800
Subject: [PATCH] migration/multifd: Optimize sender side to be lockless

When reviewing my attempt to refactor send_prepare(), Fabiano suggested we
try out with dropping the mutex in multifd code [1].

I thought about that before but I never tried to change the code.  Now
maybe it's time to give it a stab.  This only optimizes the sender side.

The trick here is multifd has a clear provider/consumer model, that the
migration main thread publishes requests (either pending_job/pending_sync),
while the multifd sender threads are consumers.  Here we don't have a lot
of complicated data sharing, and the jobs can logically be submitted
lockless.

Arm the code with atomic weapons.  Two things worth mentioning:

  - For multifd_send_pages(): we can use qatomic_load_acquire() when trying
  to find a free channel, but that's expensive if we attach one ACQUIRE per
  channel.  Instead, keep the qatomic_read() on reading the pending_job
  flag as we do already, meanwhile use one smp_mb_acquire() after the loop
  to guarantee the memory ordering.

  - For pending_sync: it doesn't have any extra data required since now
  p->flags are never touched, it should be safe to not use memory barrier.
  That's different from pending_job.

Provide rich comments for all the lockless operations to state how they are
paired.  With that, we can remove the mutex.

[1] https://lore.kernel.org/r/87o7d1jlu5.fsf@suse.de

Suggested-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240202102857.110210-24-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.h |  2 --
 migration/multifd.c | 51 +++++++++++++++++++++++----------------------
 2 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index 98876ff94a..78a2317263 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -91,8 +91,6 @@ typedef struct {
     /* syncs main thread and channels */
     QemuSemaphore sem_sync;
 
-    /* this mutex protects the following parameters */
-    QemuMutex mutex;
     /* is this channel thread running */
     bool running;
     /* multifd flags for each packet */
diff --git a/migration/multifd.c b/migration/multifd.c
index b317d57d61..fbdb129088 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -501,19 +501,19 @@ static bool multifd_send_pages(void)
         }
     }
 
-    qemu_mutex_lock(&p->mutex);
-    assert(!p->pages->num);
-    assert(!p->pages->block);
     /*
-     * Double check on pending_job==false with the lock.  In the future if
-     * we can have >1 requester thread, we can replace this with a "goto
-     * retry", but that is for later.
+     * Make sure we read p->pending_job before all the rest.  Pairs with
+     * qatomic_store_release() in multifd_send_thread().
      */
-    assert(qatomic_read(&p->pending_job) == false);
-    qatomic_set(&p->pending_job, true);
+    smp_mb_acquire();
+    assert(!p->pages->num);
     multifd_send_state->pages = p->pages;
     p->pages = pages;
-    qemu_mutex_unlock(&p->mutex);
+    /*
+     * Making sure p->pages is setup before marking pending_job=true. Pairs
+     * with the qatomic_load_acquire() in multifd_send_thread().
+     */
+    qatomic_store_release(&p->pending_job, true);
     qemu_sem_post(&p->sem);
 
     return true;
@@ -648,7 +648,6 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
     }
     multifd_send_channel_destroy(p->c);
     p->c = NULL;
-    qemu_mutex_destroy(&p->mutex);
     qemu_sem_destroy(&p->sem);
     qemu_sem_destroy(&p->sem_sync);
     g_free(p->name);
@@ -742,14 +741,12 @@ int multifd_send_sync_main(void)
 
         trace_multifd_send_sync_main_signal(p->id);
 
-        qemu_mutex_lock(&p->mutex);
         /*
          * We should be the only user so far, so not possible to be set by
          * others concurrently.
          */
         assert(qatomic_read(&p->pending_sync) == false);
         qatomic_set(&p->pending_sync, true);
-        qemu_mutex_unlock(&p->mutex);
         qemu_sem_post(&p->sem);
     }
     for (i = 0; i < migrate_multifd_channels(); i++) {
@@ -796,9 +793,12 @@ static void *multifd_send_thread(void *opaque)
         if (multifd_send_should_exit()) {
             break;
         }
-        qemu_mutex_lock(&p->mutex);
 
-        if (qatomic_read(&p->pending_job)) {
+        /*
+         * Read pending_job flag before p->pages.  Pairs with the
+         * qatomic_store_release() in multifd_send_pages().
+         */
+        if (qatomic_load_acquire(&p->pending_job)) {
             MultiFDPages_t *pages = p->pages;
 
             p->iovs_num = 0;
@@ -806,14 +806,12 @@ static void *multifd_send_thread(void *opaque)
 
             ret = multifd_send_state->ops->send_prepare(p, &local_err);
             if (ret != 0) {
-                qemu_mutex_unlock(&p->mutex);
                 break;
             }
 
             ret = qio_channel_writev_full_all(p->c, p->iov, p->iovs_num, NULL,
                                               0, p->write_flags, &local_err);
             if (ret != 0) {
-                qemu_mutex_unlock(&p->mutex);
                 break;
             }
 
@@ -822,24 +820,31 @@ static void *multifd_send_thread(void *opaque)
 
             multifd_pages_reset(p->pages);
             p->next_packet_size = 0;
-            qatomic_set(&p->pending_job, false);
-            qemu_mutex_unlock(&p->mutex);
+
+            /*
+             * Making sure p->pages is published before saying "we're
+             * free".  Pairs with the smp_mb_acquire() in
+             * multifd_send_pages().
+             */
+            qatomic_store_release(&p->pending_job, false);
         } else {
-            /* If not a normal job, must be a sync request */
+            /*
+             * If not a normal job, must be a sync request.  Note that
+             * pending_sync is a standalone flag (unlike pending_job), so
+             * it doesn't require explicit memory barriers.
+             */
             assert(qatomic_read(&p->pending_sync));
             p->flags = MULTIFD_FLAG_SYNC;
             multifd_send_fill_packet(p);
             ret = qio_channel_write_all(p->c, (void *)p->packet,
                                         p->packet_len, &local_err);
             if (ret != 0) {
-                qemu_mutex_unlock(&p->mutex);
                 break;
             }
             /* p->next_packet_size will always be zero for a SYNC packet */
             stat64_add(&mig_stats.multifd_bytes, p->packet_len);
             p->flags = 0;
             qatomic_set(&p->pending_sync, false);
-            qemu_mutex_unlock(&p->mutex);
             qemu_sem_post(&p->sem_sync);
         }
     }
@@ -853,10 +858,7 @@ out:
         error_free(local_err);
     }
 
-    qemu_mutex_lock(&p->mutex);
     p->running = false;
-    qemu_mutex_unlock(&p->mutex);
-
     rcu_unregister_thread();
     migration_threads_remove(thread);
     trace_multifd_send_thread_end(p->id, p->packets_sent, p->total_normal_pages);
@@ -998,7 +1000,6 @@ int multifd_send_setup(Error **errp)
     for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
-        qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem, 0);
         qemu_sem_init(&p->sem_sync, 0);
         p->id = i;
-- 
2.43.0


-- 
Peter Xu


