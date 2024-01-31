Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A373EC47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 04:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV2YB-0008I1-9D; Tue, 30 Jan 2024 23:50:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rV2Y9-0008Hs-VD
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 23:50:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rV2Y7-0002JF-9a
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 23:50:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706676609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DiBn9JeZDXt2vVhdfkxS9I+ChSvM4LwvHCajmFJdUtk=;
 b=G6r/wo3Qak0yvqWVjwxC7X7jJuodkPE1x9bktaThHJYSZLUDDbro2OQcfcqGdz96TAewNv
 S19xRT4FaSmjobBkrOQ74NYVU9hkm0roJippPDll/R4niUhOh61OD1erkpNBISa17SNZ2O
 jMG/rPfh3qwwdEWV5IQw8R90WkjECIw=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-a7tQqjHuNcO6bRqA4MWifA-1; Tue, 30 Jan 2024 23:50:07 -0500
X-MC-Unique: a7tQqjHuNcO6bRqA4MWifA-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6df7a596168so219459b3a.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 20:50:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706676606; x=1707281406;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DiBn9JeZDXt2vVhdfkxS9I+ChSvM4LwvHCajmFJdUtk=;
 b=NB91XQMSNiz2Vwer0KH8PDsJWXnXIUK7WjZVgjf1dc/pfKmNey73HhRI5xKoPpe2+W
 WXr9hKk9Maz9stiON5nngoLOIPa/I8tlhk2R1JOo5BFvmPprhZbEEggaL8AKscaegxgt
 4PtA+6Yb8D5xzg7dAsEG3wHB6eAb/ORMPbq4p1qse8B6E8mff9MrQ3iuYUgGPJXvVOUl
 MowLwSX0SEGIXW3mszoUmS9Am4mwQ8ZZ3zIes1KkZT+kVrTraZQrkAl45oIJhoSjlZwr
 rO3TVFLLk6x6BzEZWbV1bEd716J8DCYLSFEvkk9n6h0/GNM2DE098SZh0LN93u6Znxux
 OneQ==
X-Gm-Message-State: AOJu0YxkQYG/m1ZK+L4fCqD8dKhiAg1Rr/63xIBCDtpmbzING7KcAMuy
 qjzhDZVazhLjPjoMfzxMm+6QXvGaBEzFl1dMSv/bKFmaq7B327nwuzFO0VRDD7zkeyyN1pNF6cm
 kWGX0vBfPevcI3DIcSlEn0kjJpXXQOmcyjuSTZ3rdKbwYC/+msJnE0JU5klwsyaI=
X-Received: by 2002:aa7:9851:0:b0:6dd:c64c:10be with SMTP id
 n17-20020aa79851000000b006ddc64c10bemr793300pfq.0.1706676606291; 
 Tue, 30 Jan 2024 20:50:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbLxfYi8zpubQ0YG+woIdWK3aeIKtd1eVZkHak49RNrNyP4oM7hQGdJbqtgsp2RUEHS0KNoQ==
X-Received: by 2002:aa7:9851:0:b0:6dd:c64c:10be with SMTP id
 n17-20020aa79851000000b006ddc64c10bemr793286pfq.0.1706676605812; 
 Tue, 30 Jan 2024 20:50:05 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 u26-20020aa7849a000000b006dd880c72d6sm8811216pfn.37.2024.01.30.20.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 20:50:05 -0800 (PST)
Date: Wed, 31 Jan 2024 12:49:59 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 05/17] migration/multifd: Wait for multifd channels
 creation before proceeding
Message-ID: <ZbnRd7g-fJJ4p4xc@x1n>
References: <20240125162528.7552-1-avihaih@nvidia.com>
 <20240125162528.7552-6-avihaih@nvidia.com> <87cytkdx7z.fsf@suse.de>
 <a54d5dec-6103-4e10-b732-2156573c4ad8@nvidia.com>
 <87v87abj8a.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v87abj8a.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Jan 30, 2024 at 06:32:21PM -0300, Fabiano Rosas wrote:
> Avihai Horon <avihaih@nvidia.com> writes:
> 
> > On 29/01/2024 16:34, Fabiano Rosas wrote:
> >> External email: Use caution opening links or attachments
> >>
> >>
> >> Avihai Horon <avihaih@nvidia.com> writes:
> >>
> >>> Currently, multifd channels are created asynchronously without waiting
> >>> for their creation -- migration simply proceeds and may wait in
> >>> multifd_send_sync_main(), which is called by ram_save_setup(). This
> >>> hides in it some race conditions which can cause an unexpected behavior
> >>> if some channels creation fail.
> >>>
> >>> For example, the following scenario of multifd migration with two
> >>> channels, where the first channel creation fails, will end in a
> >>> segmentation fault (time advances from top to bottom):
> >> Is this reproducible? Or just observable at least.
> >
> > Yes, though I had to engineer it a bit:
> > 1. Run migration with two multifd channels and fail creation of the two 
> > channels (e.g., by changing the address they are connecting to).
> > 2. Add sleep(3) in multifd_send_sync_main() before we loop through the 
> > channels and check p->quit.
> > 3. Add sleep(5) only for the second multifd channel connect thread so 
> > its connection is delayed and runs last.
> 
> Ok, well, that's something at least. I'll try to reproduce it so we can
> keep track of it.
> 
> >> I acknowledge the situation you describe, but with multifd there's
> >> usually an issue in cleanup paths. Let's make sure we flushed those out
> >> before adding this new semaphore.
> >
> > Indeed, I was not keen on adding yet another semaphore either.
> > I think there are multiple bugs here, some of them overlap and some don't.
> > There is also your and Peter's previous work that I was not aware of to 
> > fix those and to clean up the code.
> >
> > Maybe we can take it one step at a time, pushing your series first, 
> > cleaning the code and fixing some bugs.
> > Then we can see what bugs are left (if any) and fix them. It might even 
> > be easier to fix after the cleanups.
> >
> >> This is similar to an issue Peter was addressing where we missed calling
> >> multifd_send_termiante_threads() in the multifd_channel_connect() path:
> >>
> >> patch 4 in this
> >> https://lore.kernel.org/r/20231022201211.452861-1-peterx@redhat.com
> >
> > What issue are you referring here? Can you elaborate?
> 
> Oh, I just realised that series doesn't address any particular bug. But
> my point is that including a call to multifd_send_terminate_threads() at
> new_send_channel_cleanup might be all that's needed because that has
> code to cause the channels and the migration thread to end.

It seems so to me.

One other issue is I hope we can get rid of p->quit before adding more code
to operate on it.

I'll see whether I can respin that series this week soon.  I'll consider
dropping the last ones, but pick the initial ones that may already help.  I
just noticed patch 2 is already merged with Avihai's similar patch;
obviously I completely forgot that series..

> 
> > The main issue I am trying to fix in my patch is that we don't wait for 
> > all multifd channels to be created/error out before tearing down
> > multifd resources in mulitfd_save_cleanup().
> 
> Ok, let me take a step back and ask why is this not solved by
> multifd_save_cleanup() -> qemu_thread_join()? I see you moved
> p->running=true to *after* the thread creation in patch 4. That will
> always leave a gap where p->running == false but the thread is already
> running.

The whole threading in multifd currently is just IMHO a mess.  We keep
creating threads but never cared on how that goes, and how to sync with the
threads.

I do have plan to track every TID that migration creates (including the
ones of qio tasks, maybe?), then we can always manage the threads, and
making sure all the threads will be freed when migrate_fd_cleanup()
finishes, by join()ing each of them.  I suppose we may also need things
like pthread_cancel(), consider when any thread got blocked somewhere but
the admin invoked a "migrate-cancel" request.

With any dangling thread being there, we always face weird risks: either
some migration code will be scheduled even after migration failed (like
this one), or it could be worse if that thread only got scheduled until the
2nd migration started after the 1st one cancelled - we need to be prepared
to see some extra threads running, having no idea where did they come from,
and those bugs will be hard to debug.

I haven't yet started looking into that, it'll be good if anyone would like
to explore that direction for a full resolution on multifd threadings.

> 
> >
> >>> Thread           | Code execution
> >>> ------------------------------------------------------------------------
> >>> Multifd 1        |
> >>>                   | multifd_new_send_channel_async (errors and quits)
> >>>                   |   multifd_new_send_channel_cleanup
> >>>                   |
> >>> Migration thread |
> >>>                   | qemu_savevm_state_setup
> >>>                   |   ram_save_setup
> >>>                   |     multifd_send_sync_main
> >>>                   |     (detects Multifd 1 error and quits)
> >>>                   | [...]
> >>>                   | migration_iteration_finish
> >>>                   |   migrate_fd_cleanup_schedule
> >>>                   |
> >>> Main thread      |
> >>>                   | migrate_fd_cleanup
> >>>                   |   multifd_save_cleanup (destroys Multifd 2 resources)
> >>>                   |
> >>> Multifd 2        |
> >>>                   | multifd_new_send_channel_async
> >>>                   | (accesses destroyed resources, segfault)
> >>>
> >>> In another scenario, migration can hang indefinitely:
> >>> 1. Main migration thread reaches multifd_send_sync_main() and waits on
> >>>     the semaphores.
> >>> 2. Then, all multifd channels creation fails, so they post the
> >>>     semaphores and quit.
> >>> 3. Main migration channel will not identify the error, proceed to send
> >>>     pages and will hang.
> >>>
> >>> Fix it by waiting for all multifd channels to be created before
> >>> proceeding with migration.
> >>>
> >>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> >>> ---
> >>>   migration/multifd.h   |  3 +++
> >>>   migration/migration.c |  1 +
> >>>   migration/multifd.c   | 34 +++++++++++++++++++++++++++++++---
> >>>   migration/ram.c       |  7 +++++++
> >>>   4 files changed, 42 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/migration/multifd.h b/migration/multifd.h
> >>> index 35d11f103c..87a64e0a87 100644
> >>> --- a/migration/multifd.h
> >>> +++ b/migration/multifd.h
> >>> @@ -23,6 +23,7 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
> >>>   void multifd_recv_sync_main(void);
> >>>   int multifd_send_sync_main(void);
> >>>   int multifd_queue_page(RAMBlock *block, ram_addr_t offset);
> >>> +int multifd_send_channels_created(void);
> >>>
> >>>   /* Multifd Compression flags */
> >>>   #define MULTIFD_FLAG_SYNC (1 << 0)
> >>> @@ -86,6 +87,8 @@ typedef struct {
> >>>       /* multifd flags for sending ram */
> >>>       int write_flags;
> >>>
> >>> +    /* Syncs channel creation and migration thread */
> >>> +    QemuSemaphore create_sem;
> >>>       /* sem where to wait for more work */
> >>>       QemuSemaphore sem;
> >>>       /* syncs main thread and channels */
> >>> diff --git a/migration/migration.c b/migration/migration.c
> >>> index 9c769a1ecd..d81d96eaa5 100644
> >>> --- a/migration/migration.c
> >>> +++ b/migration/migration.c
> >>> @@ -3621,6 +3621,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
> >>>           error_report_err(local_err);
> >>>           migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
> >>>                             MIGRATION_STATUS_FAILED);
> >>> +        multifd_send_channels_created();
> >>>           migrate_fd_cleanup(s);
> >>>           return;
> >>>       }
> >>> diff --git a/migration/multifd.c b/migration/multifd.c
> >>> index 564e911b6c..f0c216f4f9 100644
> >>> --- a/migration/multifd.c
> >>> +++ b/migration/multifd.c
> >>> @@ -538,6 +538,7 @@ void multifd_save_cleanup(void)
> >>>           multifd_send_channel_destroy(p->c);
> >>>           p->c = NULL;
> >>>           qemu_mutex_destroy(&p->mutex);
> >>> +        qemu_sem_destroy(&p->create_sem);
> >>>           qemu_sem_destroy(&p->sem);
> >>>           qemu_sem_destroy(&p->sem_sync);
> >>>           g_free(p->name);
> >>> @@ -766,6 +767,29 @@ out:
> >>>       return NULL;
> >>>   }
> >>>
> >>> +int multifd_send_channels_created(void)
> >>> +{
> >>> +    int ret = 0;
> >>> +
> >>> +    if (!migrate_multifd()) {
> >>> +        return 0;
> >>> +    }
> >>> +
> >>> +    for (int i = 0; i < migrate_multifd_channels(); i++) {
> >>> +        MultiFDSendParams *p = &multifd_send_state->params[i];
> >>> +
> >>> +        qemu_sem_wait(&p->create_sem);
> >>> +        WITH_QEMU_LOCK_GUARD(&p->mutex) {
> >>> +            if (p->quit) {
> >>> +                error_report("%s: channel %d has already quit", __func__, i);
> >>> +                ret = -1;
> >>> +            }
> >>> +        }
> >> There are races here when a channel fails at
> >> multifd_send_initial_packet(). If p->quit can be set after post to
> >> create_sem, then this function could always return true and we'd run
> >> into a broken channel. Possibly even the same bug you're trying to fix.
> >>
> >> I think that's one of the reasons we have channels_ready.
> >
> > I am not sure exactly what bug you are describing here, can you elaborate?
> >
> 
> This looks like it could be a preexisting issue actually, but in the
> current code, what stops the multifd channel from running ahead is
> p->sem. Except that the channel does some work at
> multifd_send_initial_packet() before checking p->sem and that work could
> fail.
> 
> This means that right after checking for p->quit above, the multifd
> thread could already be exiting due to an error and
> multifd_send_channels_created() would miss it. So there's still a chance
> that this function effectively behaves just like the previous code.
> 
> Thread           | Code execution
> ------------------------------------------------------------------------
> Migration        |
>                  | ram_save_setup()
>                  |   multifd_send_channels_created()
>                  |     qemu_sem_wait(&p->create_sem);
> Main             |
>                  | multifd_channel_connect()
>                  |   qemu_thread_create()
>                  |   qemu_sem_post(&p->create_sem)
> Multifd 1        |
>                  | multifd_send_initial_packet() *errors*
>                  | goto out
>                  | multifd_send_terminate_threads()
> Migration        |
>                  | still at multifd_send_channels_created
>                  |     qemu_mutex_lock(&p->mutex);
>                  |     p->quit == false      <--- !!!
>                  |     qemu_mutex_unlock(&p->mutex);
>                  | return true from multifd_send_channels_created()
> 
> From here onwards, it's the same as not having checked
> multifd_send_channels_created() at all. One way this could go is:
> 
>                  | runs unimpeded until multifd_send_sync_main()
>                  | multifd_send_pages()
>                  | *misses the exiting flag*
>                  | qemu_sem_wait(&multifd_send_state->channels_ready);
> Multifd 1        |
>                  | still at multifd_send_terminate_threads
>                  |   qemu_mutex_lock(&p->mutex);
>                  |   p->quit = true;
>                  |   qemu_mutex_unlock(&p->mutex);
>                  | qemu_sem_post(&p->sem_sync);
>                  | qemu_sem_post(&multifd_send_state->channels_ready);
> Migration        |
>                  | qemu_mutex_lock(&p->mutex);
>                  | p->quit == true;  <--- correct now
>                  | qemu_mutex_unlock(&p->mutex);
>                  | return -1;
>                  | *all good again*
> 
> It seems that in order to avoid this kind of race we'd need the
> synchronization point to be at the multifd thread instead. But then,
> that's what channels_ready does.
> 
> >>
> >>> +    }
> >>> +
> >>> +    return ret;
> >>> +}
> >>> +
> >>>   static bool multifd_channel_connect(MultiFDSendParams *p,
> >>>                                       QIOChannel *ioc,
> >>>                                       Error **errp);
> >>> @@ -794,6 +818,7 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
> >>>       p->quit = true;
> >>>       qemu_sem_post(&multifd_send_state->channels_ready);
> >>>       qemu_sem_post(&p->sem_sync);
> >>> +    qemu_sem_post(&p->create_sem);
> >>>       error_free(err);
> >>>   }
> >>>
> >>> @@ -857,6 +882,7 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
> >>>       qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
> >>>                          QEMU_THREAD_JOINABLE);
> >>>       p->running = true;
> >>> +    qemu_sem_post(&p->create_sem);
> >>>       return true;
> >>>   }
> >>>
> >>> @@ -864,15 +890,16 @@ static void multifd_new_send_channel_cleanup(MultiFDSendParams *p,
> >>>                                                QIOChannel *ioc, Error *err)
> >>>   {
> >>>        migrate_set_error(migrate_get_current(), err);
> >>> -     /* Error happen, we need to tell who pay attention to me */
> >>> -     qemu_sem_post(&multifd_send_state->channels_ready);
> >>> -     qemu_sem_post(&p->sem_sync);
> >>>        /*
> >>> +      * Error happen, we need to tell who pay attention to me.
> >>>         * Although multifd_send_thread is not created, but main migration
> >>>         * thread need to judge whether it is running, so we need to mark
> >>>         * its status.
> >>>         */
> >>>        p->quit = true;
> >>> +     qemu_sem_post(&multifd_send_state->channels_ready);
> >>> +     qemu_sem_post(&p->sem_sync);
> >>> +     qemu_sem_post(&p->create_sem);
> >> Do we still need channels_ready and sem_sync here? The migration thread
> >> shouldn't have gone past create_sem at this point.
> >
> > I think you are right, we can drop channels_ready and sem_sync here.
> >
> >>
> >>>        object_unref(OBJECT(ioc));
> >>>        error_free(err);
> >>>   }
> >>> @@ -921,6 +948,7 @@ int multifd_save_setup(Error **errp)
> >>>           MultiFDSendParams *p = &multifd_send_state->params[i];
> >>>
> >>>           qemu_mutex_init(&p->mutex);
> >>> +        qemu_sem_init(&p->create_sem, 0);
> >>>           qemu_sem_init(&p->sem, 0);
> >>>           qemu_sem_init(&p->sem_sync, 0);
> >>>           p->quit = false;
> >>> diff --git a/migration/ram.c b/migration/ram.c
> >>> index c0cdcccb75..b3e864a22b 100644
> >>> --- a/migration/ram.c
> >>> +++ b/migration/ram.c
> >>> @@ -2937,6 +2937,13 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
> >>>       RAMBlock *block;
> >>>       int ret;
> >>>
> >>> +    bql_unlock();
> >>> +    ret = multifd_send_channels_created();
> >>> +    bql_lock();
> >>> +    if (ret < 0) {
> >>> +        return ret;
> >>> +    }
> >>> +
> >>>       if (compress_threads_save_setup()) {
> >>>           return -1;
> >>>       }
> 

-- 
Peter Xu


