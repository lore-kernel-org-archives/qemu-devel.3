Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AD1C47DDF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 09:30:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVTOV-0004Rk-7t; Thu, 01 Feb 2024 04:30:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVTOS-0004R9-Dw
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 04:30:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVTOP-0000J2-Bf
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 04:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706779796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=otzPFcdkaAnX2rA/Qaal3RvF8eiyzEkJcbQrmqd7SGQ=;
 b=hMSDhAKDiJz4JU7UntaeLz7MXT+OJXQtQfe33FO7gbMlPojF2gfwDnlOcfQY8TtljvOkxp
 rzYdcHMWov3mPWg6cibzWfBySMKQOzz9I23sY0oxEjQ4i2WpVZ7Y3px5RDQKjlvTj4yJzS
 hKtColPRT7rUt66uRKdDPA4FpUDeuZw=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-gUv0th9mPjeuN3NnoT0Khg-1; Thu, 01 Feb 2024 04:29:53 -0500
X-MC-Unique: gUv0th9mPjeuN3NnoT0Khg-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3be75cab163so173215b6e.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 01:29:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706779792; x=1707384592;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=otzPFcdkaAnX2rA/Qaal3RvF8eiyzEkJcbQrmqd7SGQ=;
 b=JfDgpU4qu92yrC7cOBWs1K28QRzrdkMg3DqRUUndX8qoAZQNN7BeZXmQ22UxBm3Ioz
 zSXa23/941UUG0iE/EJItcp/OwTueVDHaNR3JB39wgmLJGlcnbOJ09SLIyxiQucTwIfy
 O7Hl3BAfg2CHcYJVKPcuEQnpcTY+Ry322bhKmUOASwo5iIB0Thvbg46Cf9UAishGV61m
 U8r781bzCLgjAd5H7eyxv9g87PDTIwcjDyz6/w8UCKQA/UiTpjiEoLByiUl7AJxP5rBw
 mPk9GDcA/yxgd7Y5Z+knimj9gTZxZM9KAmsst+n9e5xRdlCPQRlci3Jvc01PV8UneXtC
 zOAQ==
X-Gm-Message-State: AOJu0YwKMpr6UJFnkJQAFcHmlLuUdGgQXe3L9vkeEu5xqVOItZ4Xt3BT
 Ru2QnPSzeWavct7jC9SpIcgtVG5xH8i89FbLio+r3fmOFllGZagLp5ZqOJJ7SzS2lJ+xG9KMh0v
 X8M/sOVyhqt+Txg7VVyWrGwADaNug0UXoZcvQG7RG6fAwfAuXTHLT
X-Received: by 2002:a05:6870:d14d:b0:218:ee9c:11b6 with SMTP id
 f13-20020a056870d14d00b00218ee9c11b6mr980954oac.3.1706779792610; 
 Thu, 01 Feb 2024 01:29:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoemhZ2WwCU+5HGLrT3Tmh2PTJjb3NdfP46ofqoGNSDLFH5dL0dbY69Ep2Irt+a5IEGbcFnQ==
X-Received: by 2002:a05:6870:d14d:b0:218:ee9c:11b6 with SMTP id
 f13-20020a056870d14d00b00218ee9c11b6mr980930oac.3.1706779792198; 
 Thu, 01 Feb 2024 01:29:52 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWY9mQBOhF74un+IeGGVpK88P/5fUEyxFQnvVMqRAeedhDds51H73W5zMrv9tWmKSaJNwJxUU25vWuxt7KigZzEGdIXmgsW1y93q4BiSgWYh4QZFT/+/EzUYaES+RPr7vydNz0CWoiUJCOdif8QqeV759ChpkIOfmjY+yx1/eAGS6rWTAIxz/OOUvvrhjc/eYIJu0aR4yWSC97jz/yE+l4=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 z24-20020a631918000000b005d68962e1a7sm11998706pgl.24.2024.02.01.01.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 01:29:51 -0800 (PST)
Date: Thu, 1 Feb 2024 17:28:32 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Bryan Zhang <bryan.zhang@bytedance.com>,
 Prasad Pandit <ppandit@redhat.com>, Yuan Liu <yuan1.liu@intel.com>,
 Avihai Horon <avihaih@nvidia.com>, Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH 03/14] migration/multifd: Drop MultiFDSendParams.quit,
 cleanup error paths
Message-ID: <ZbtkQLnPJDmXK912@x1n>
References: <20240131103111.306523-1-peterx@redhat.com>
 <20240131103111.306523-4-peterx@redhat.com>
 <87zfwlk0gr.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zfwlk0gr.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Jan 31, 2024 at 12:05:08PM -0300, Fabiano Rosas wrote:
> peterx@redhat.com writes:
> 
> > From: Peter Xu <peterx@redhat.com>
> >
> > Multifd send side has two fields to indicate error quits:
> >
> >   - MultiFDSendParams.quit
> >   - &multifd_send_state->exiting
> >
> > Merge them into the global one.  The replacement is done by changing all
> > p->quit checks into the global var check.  The global check doesn't need
> > any lock.
> >
> > A few more things done on top of this altogether:
> >
> >   - multifd_send_terminate_threads()
> >
> >     Moving the xchg() of &multifd_send_state->exiting upper, so as to cover
> >     the tracepoint, migrate_set_error() and migrate_set_state().
> 
> Good.
> 
> >
> >   - multifd_send_sync_main()
> >
> >     In the 2nd loop, add one more check over the global var to make sure we
> >     don't keep the looping if QEMU already decided to quit.
> 
> Yes, also because we don't necessarily enter at multifd_send_page()
> every time.
> 
> >
> >   - multifd_tls_outgoing_handshake()
> >
> >     Use multifd_send_terminate_threads() to set the error state.  That has
> >     a benefit of updating MigrationState.error to that error too, so we can
> >     persist that 1st error we hit in that specific channel.
> 
> Makes sense.
> 
> >
> >   - multifd_new_send_channel_async()
> >
> >     Take similar approach like above, drop the migrate_set_error() because
> >     multifd_send_terminate_threads() already covers that.  Unwrap the helper
> >     multifd_new_send_channel_cleanup() along the way; not really needed.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/multifd.h |  2 --
> >  migration/multifd.c | 85 ++++++++++++++++++---------------------------
> >  2 files changed, 33 insertions(+), 54 deletions(-)
> >
> > diff --git a/migration/multifd.h b/migration/multifd.h
> > index 35d11f103c..7c040cb85a 100644
> > --- a/migration/multifd.h
> > +++ b/migration/multifd.h
> > @@ -95,8 +95,6 @@ typedef struct {
> >      QemuMutex mutex;
> >      /* is this channel thread running */
> >      bool running;
> > -    /* should this thread finish */
> > -    bool quit;
> >      /* multifd flags for each packet */
> >      uint32_t flags;
> >      /* global number of generated multifd packets */
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index b8d2c96533..2c98023d67 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -372,6 +372,11 @@ struct {
> >      MultiFDMethods *ops;
> >  } *multifd_send_state;
> >  
> > +static bool multifd_send_should_exit(void)
> > +{
> > +    return qatomic_read(&multifd_send_state->exiting);
> > +}
> > +
> >  /*
> >   * The migration thread can wait on either of the two semaphores.  This
> >   * function can be used to kick the main thread out of waiting on either of
> > @@ -409,7 +414,7 @@ static int multifd_send_pages(void)
> >      MultiFDSendParams *p = NULL; /* make happy gcc */
> >      MultiFDPages_t *pages = multifd_send_state->pages;
> >  
> > -    if (qatomic_read(&multifd_send_state->exiting)) {
> > +    if (multifd_send_should_exit()) {
> >          return -1;
> >      }
> >  
> > @@ -421,14 +426,11 @@ static int multifd_send_pages(void)
> >       */
> >      next_channel %= migrate_multifd_channels();
> >      for (i = next_channel;; i = (i + 1) % migrate_multifd_channels()) {
> > -        p = &multifd_send_state->params[i];
> > -
> > -        qemu_mutex_lock(&p->mutex);
> > -        if (p->quit) {
> > -            error_report("%s: channel %d has already quit!", __func__, i);
> > -            qemu_mutex_unlock(&p->mutex);
> > +        if (multifd_send_should_exit()) {
> >              return -1;
> >          }
> > +        p = &multifd_send_state->params[i];
> > +        qemu_mutex_lock(&p->mutex);
> >          if (!p->pending_job) {
> >              p->pending_job++;
> >              next_channel = (i + 1) % migrate_multifd_channels();
> 
> Hm, I'm not sure it's correct to check 'exiting' outside of the
> lock. While it is an atomic operation, it is not atomic in relation to
> pending_job...
> 
> ... looking closer, it seems that we can do what you suggest because
> p->pending_job is not touched by the multifd_send_thread in case of
> error, which means this function will indeed miss the 'exiting' flag,
> but pending_job > 0 means it will loop to the next channel and _then_ it
> will see the 'exiting' flag.

It could still be the last channel we iterate, then IIUC we can still try
to assign a job to a thread even if a concurrent error is set there.

However IMHO it's okay; the error in the sender thread should ultimately
set migrate_set_error() and the main thread should detect that in the
migration loop, then we'll still quit.  The extra queued job shouldn't
matter, IMHO.

> 
> > @@ -483,6 +485,16 @@ static void multifd_send_terminate_threads(Error *err)
> >  {
> >      int i;
> >  
> > +    /*
> > +     * We don't want to exit each threads twice.  Depending on where
> > +     * we get the error, or if there are two independent errors in two
> > +     * threads at the same time, we can end calling this function
> > +     * twice.
> > +     */
> > +    if (qatomic_xchg(&multifd_send_state->exiting, 1)) {
> > +        return;
> > +    }
> > +
> >      trace_multifd_send_terminate_threads(err != NULL);
> >  
> >      if (err) {
> > @@ -497,26 +509,13 @@ static void multifd_send_terminate_threads(Error *err)
> >          }
> >      }
> >  
> > -    /*
> > -     * We don't want to exit each threads twice.  Depending on where
> > -     * we get the error, or if there are two independent errors in two
> > -     * threads at the same time, we can end calling this function
> > -     * twice.
> > -     */
> > -    if (qatomic_xchg(&multifd_send_state->exiting, 1)) {
> > -        return;
> > -    }
> > -
> >      for (i = 0; i < migrate_multifd_channels(); i++) {
> >          MultiFDSendParams *p = &multifd_send_state->params[i];
> >  
> > -        qemu_mutex_lock(&p->mutex);
> > -        p->quit = true;
> 
> Now that you removed this, we decoupled kicking the threads from setting
> the exit/error, so this function could be split in two.
> 
> We could set the exiting flag at the places the error occurred (multifd
> threads, thread creation, etc) and "terminate the threads" at
> multifd_save_cleanup(). That second part we already do actually:
> 
> void multifd_save_cleanup(void) {
> ...
>     multifd_send_terminate_threads(NULL);
>                                    ^see?
>     for (i = 0; i < migrate_multifd_channels(); i++) {
>         MultiFDSendParams *p = &multifd_send_state->params[i];
> 
>         if (p->running) {
>             qemu_thread_join(&p->thread);
>         }
>     }
> ...
> }
> 
> I think there's no reason anymore for the channels to kick each
> other. They would all be waiting at p->sem and multifd_send_cleanup()
> would kick + join them.

Sounds good here.

I'll attach one patch like this, feel free to have an early look:

=====

From f9a3d63d5cca0068daaea4c72392803f4b29dcb5 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Thu, 1 Feb 2024 17:01:54 +0800
Subject: [PATCH] migration/multifd: Split multifd_send_terminate_threads()

Split multifd_send_terminate_threads() into two functions:

  - multifd_send_set_error(): used when an error happened on the sender
    side, set error and quit state only

  - multifd_send_terminate_threads(): used only by the main thread to kick
    all multifd send threads out of sleep, for the last recycling.

Use multifd_send_set_error() in the three old call sites where only the
error will be set.

Use multifd_send_terminate_threads() in the last one where the main thread
will kick the multifd threads at last in multifd_save_cleanup().

Both helpers will need to set quitting=1.

Suggested-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c    | 27 ++++++++++++++++++---------
 migration/trace-events |  2 +-
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index c71e74b101..95dc29c8c7 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -536,10 +536,9 @@ int multifd_queue_page(RAMBlock *block, ram_addr_t offset)
     return 1;
 }
 
-static void multifd_send_terminate_threads(Error *err)
+/* Multifd send side hit an error; remember it and prepare to quit */
+static void multifd_send_set_error(Error *err)
 {
-    int i;
-
     /*
      * We don't want to exit each threads twice.  Depending on where
      * we get the error, or if there are two independent errors in two
@@ -550,8 +549,6 @@ static void multifd_send_terminate_threads(Error *err)
         return;
     }
 
-    trace_multifd_send_terminate_threads(err != NULL);
-
     if (err) {
         MigrationState *s = migrate_get_current();
         migrate_set_error(s, err);
@@ -563,7 +560,19 @@ static void multifd_send_terminate_threads(Error *err)
                               MIGRATION_STATUS_FAILED);
         }
     }
+}
+
+static void multifd_send_terminate_threads(void)
+{
+    int i;
+
+    trace_multifd_send_terminate_threads();
 
+    /*
+     * Tell everyone we're quitting.  No xchg() needed here; we simply
+     * always set it.
+     */
+    qatomic_set(&multifd_send_state->exiting, 1);
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
@@ -586,7 +595,7 @@ void multifd_save_cleanup(void)
     if (!migrate_multifd()) {
         return;
     }
-    multifd_send_terminate_threads(NULL);
+    multifd_send_terminate_threads();
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
@@ -778,7 +787,7 @@ out:
     if (ret) {
         assert(local_err);
         trace_multifd_send_error(p->id);
-        multifd_send_terminate_threads(local_err);
+        multifd_send_set_error(local_err);
         multifd_send_kick_main(p);
         error_free(local_err);
     }
@@ -814,7 +823,7 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
 
     trace_multifd_tls_outgoing_handshake_error(ioc, error_get_pretty(err));
 
-    multifd_send_terminate_threads(err);
+    multifd_send_set_error(err);
     multifd_send_kick_main(p);
     error_free(err);
 }
@@ -896,7 +905,7 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
     }
 
     trace_multifd_new_send_channel_async_error(p->id, local_err);
-    multifd_send_terminate_threads(local_err);
+    multifd_send_set_error(local_err);
     multifd_send_kick_main(p);
     object_unref(OBJECT(ioc));
     error_free(local_err);
diff --git a/migration/trace-events b/migration/trace-events
index de4a743c8a..298ad2b0dd 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -141,7 +141,7 @@ multifd_send_error(uint8_t id) "channel %u"
 multifd_send_sync_main(long packet_num) "packet num %ld"
 multifd_send_sync_main_signal(uint8_t id) "channel %u"
 multifd_send_sync_main_wait(uint8_t id) "channel %u"
-multifd_send_terminate_threads(bool error) "error %d"
+multifd_send_terminate_threads(void) ""
 multifd_send_thread_end(uint8_t id, uint64_t packets, uint64_t normal_pages) "channel %u packets %" PRIu64 " normal pages %"  PRIu64
 multifd_send_thread_start(uint8_t id) "%u"
 multifd_tls_outgoing_handshake_start(void *ioc, void *tioc, const char *hostname) "ioc=%p tioc=%p hostname=%s"
-- 
2.43.0


-- 
Peter Xu


