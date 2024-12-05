Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A884E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 20:36:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJIZg-0007CS-Qi; Thu, 05 Dec 2024 15:35:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJIZe-000716-65
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:35:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJIZb-0004qx-IZ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:35:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733430941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PZy9+rDhphLS4wB6yj3ielHuZRgMxt22TwyEygUfDz8=;
 b=QyeXllWTQbwCRfXOc8aO5wioVSLZI+YDU7fiTjexfwIPQlDESh5OLZw4XythKCoSQbgMVO
 XqMpWRHKlnbOcVZPZra8VWTG/rRr0yZw5Y4oZMegYLYI5m9YGvDT3secnG+yc4xlvL0YOY
 HXwC7muVdsMbFN5LxZ6GZ4MJs3A+3Vc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-QFKZJrBIOMacGwjMffZtFw-1; Thu, 05 Dec 2024 15:35:37 -0500
X-MC-Unique: QFKZJrBIOMacGwjMffZtFw-1
X-Mimecast-MFC-AGG-ID: QFKZJrBIOMacGwjMffZtFw
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6d8881bd39fso16962506d6.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 12:35:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733430936; x=1734035736;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PZy9+rDhphLS4wB6yj3ielHuZRgMxt22TwyEygUfDz8=;
 b=q97Tv4hSA0Pc6upqNLr4ePW1vjuEmX4TN5Sbs/3VdDWKzCD3j0YTcRc+V88JCh2Ks7
 ArewKcbueTwwbxtY1ktYir1w70mkKEPFt9hGUHApozQ/wTVylOhWmlwoNZGBbrVgFNzR
 /KZMzAYe/vALTsrV88KH/ZvL+b26t/QBZPSZ1rtWD+9BbWLnAz2Mb8fcWFllnDxzOWkT
 x3GT28mwoD+dAugwbpB6B4EcaQfZqt7ClDJfJbqIX2B/1SjYfOHGwz/VK/w32blK9xG2
 f8w+cvQvpinV2gwnzY03DQY55bPwf8fKlO/ilOhSeoHZyAnfhoErN+Ga6nySQIKUaqyM
 faKg==
X-Gm-Message-State: AOJu0Yy5tCvZPHM6Ylb0uAFNTW+Mts6UqeTHklEvptndagFHflIHNAmy
 truhphFCFcoai2iSMpIRnxO4uxntxvEG2Nk/C3SvZzItiryZSiLdbfHJ6w8qsNgyyOmwYMx8B8c
 4jBp2s54beA3b7SbgDHhRfn9I9Op5zVqRtPbUvsyoaQ0BXptHnxpKdQfR3g9E
X-Gm-Gg: ASbGncsmkqkQpKzCg133DT1DJ5fPqXzMQTXd1exw+5MKxOT2s6q02ndWKDqe31kkOdj
 BOklXKzm/2WS+glgPGEvglTPhx+jDIryLZK7U6aGccmZP/Nz/ocpkl4p7o8pu5Ka9Y9acjEmehX
 gNwxWJ3ctZhc1RCuQwHC8p1zl6LqYmVD0kMqck4MFJ6vIY7flQvW9A958H3096xbktg4gS6bdL9
 yN1MFNBOYiNEOnG/7JTMPUDTK9XgGOJZ0AFIXWZxE4qEctpri13St1oxyess6xLbGLy2Ms3hYOP
 rJZ5Zry5zl8=
X-Received: by 2002:a05:6214:1d0c:b0:6d8:9bbe:392d with SMTP id
 6a1803df08f44-6d8e70f0644mr2942186d6.6.1733430935978; 
 Thu, 05 Dec 2024 12:35:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6zEpVb2Vzbqoy14Sm1pprXAJS+QUHftTGROjMXOzQJdsA0YWNcGm/c5nUBp4bu58efo8nJA==
X-Received: by 2002:a05:6214:1d0c:b0:6d8:9bbe:392d with SMTP id
 6a1803df08f44-6d8e70f0644mr2942036d6.6.1733430935657; 
 Thu, 05 Dec 2024 12:35:35 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da9fded9sm10015646d6.76.2024.12.05.12.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 12:35:34 -0800 (PST)
Date: Thu, 5 Dec 2024 15:35:32 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH 2/2] migration/multifd: Allow to sync with sender threads
 only
Message-ID: <Z1IOlJemNxrhOg3z@x1n>
References: <20241205185303.897010-1-peterx@redhat.com>
 <20241205185303.897010-3-peterx@redhat.com>
 <875xnxj37e.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875xnxj37e.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Dec 05, 2024 at 05:16:05PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Teach multifd_send_sync_main() to sync with threads only.
> >
> > We already have such requests, which is when mapped-ram is enabled with
> > multifd.  In that case, no SYNC messages will be pushed to the stream when
> > multifd syncs the sender threads because there's no destination threads
> > waiting for that.  The whole point of the sync is to make sure all threads
> > flushed their jobs.
> >
> > So fundamentally we have a request to do the sync in different ways:
> >
> >   - Either to sync the threads only,
> >   - Or to sync the threads but also with the destination side
> >
> > Mapped-ram did it already because of the use_packet check in the sync
> > handler of the sender thread.  It works.
> >
> > However it may stop working when e.g. VFIO may start to reuse multifd
> > channels to push device states.  In that case VFIO has similar request on
> > "thread-only sync" however we can't check a flag because such sync request
> > can still come from RAM which needs the on-wire notifications.
> >
> > Paving way for that by allowing the multifd_send_sync_main() to specify
> > what kind of sync the caller needs.  We can use it for mapped-ram already.
> >
> > No functional change intended.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/multifd.h        | 16 +++++++++++++---
> >  migration/multifd-nocomp.c |  8 +++++++-
> >  migration/multifd.c        | 14 ++++++++------
> >  3 files changed, 28 insertions(+), 10 deletions(-)
> >
> > diff --git a/migration/multifd.h b/migration/multifd.h
> > index 50d58c0c9c..6b2f60a917 100644
> > --- a/migration/multifd.h
> > +++ b/migration/multifd.h
> > @@ -19,6 +19,15 @@
> >  typedef struct MultiFDRecvData MultiFDRecvData;
> >  typedef struct MultiFDSendData MultiFDSendData;
> >  
> > +typedef enum {
> > +    /* No sync request */
> > +    MULTIFD_SYNC_NONE = 0,
> > +    /* Sync on the sender threads without pushing messages */
> > +    MULTIFD_SYNC_THREADS,
> > +    /* Sync on the sender threads, meanwhile push "SYNC" message to the wire */
> 
> s/meanwhile//
> 
> > +    MULTIFD_SYNC_THREADS_AND_NOTIFY,
> > +} MultiFDSyncReq;
> 
> I think I'd prefer the local vs. remote terminology I introduced in my
> proposal [1] for cleaning up the multifd_flush_after_each_section() code:

I'm ok with your naming, as long as the comment will explain.

> 
> LOCAL - sync the local threads between themselves
> REMOTE - put a message on the stream for the remote end to perform a
>          sync on their threads.
> 
> Down below you're passing the
> MULTIFD_SYNC_THREADS_AND_NOTIFY into the send thread, but the "sync
> threads" part of this is really done outside the thread, so that part
> doesn't have a meaning inside the thread.
> 
> 1- https://lore.kernel.org/r/875xo8n4ue.fsf@suse.de
> 
> Also, please provide your input there^, it would be nice to unify the
> terminology and reasoning about both changes.

Yes, I'm mostly flushing my inbox in time order unless prioritized, so I'm
getting there today or tomorrow.

> 
> > +
> >  bool multifd_send_setup(void);
> >  void multifd_send_shutdown(void);
> >  void multifd_send_channel_created(void);
> > @@ -28,7 +37,7 @@ void multifd_recv_shutdown(void);
> >  bool multifd_recv_all_channels_created(void);
> >  void multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
> >  void multifd_recv_sync_main(void);
> > -int multifd_send_sync_main(void);
> > +int multifd_send_sync_main(MultiFDSyncReq req);
> >  bool multifd_queue_page(RAMBlock *block, ram_addr_t offset);
> >  bool multifd_recv(void);
> >  MultiFDRecvData *multifd_get_recv_data(void);
> > @@ -143,7 +152,7 @@ typedef struct {
> >      /* multifd flags for each packet */
> >      uint32_t flags;
> >      /*
> > -     * The sender thread has work to do if either of below boolean is set.
> > +     * The sender thread has work to do if either of below field is set.
> >       *
> >       * @pending_job:  a job is pending
> >       * @pending_sync: a sync request is pending
> > @@ -152,7 +161,8 @@ typedef struct {
> >       * cleared by the multifd sender threads.
> >       */
> >      bool pending_job;
> > -    bool pending_sync;
> > +    MultiFDSyncReq pending_sync;
> > +
> >      MultiFDSendData *data;
> >  
> >      /* thread local variables. No locking required */
> > diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
> > index 55191152f9..f64c4c9abd 100644
> > --- a/migration/multifd-nocomp.c
> > +++ b/migration/multifd-nocomp.c
> > @@ -345,6 +345,8 @@ retry:
> >  
> >  int multifd_ram_flush_and_sync(void)
> >  {
> > +    MultiFDSyncReq req;
> > +
> >      if (!migrate_multifd()) {
> >          return 0;
> >      }
> > @@ -356,7 +358,11 @@ int multifd_ram_flush_and_sync(void)
> >          }
> >      }
> >  
> > -    return multifd_send_sync_main();
> > +    /* File migrations only need to sync with threads */
> > +    req = migrate_mapped_ram() ?
> > +        MULTIFD_SYNC_THREADS : MULTIFD_SYNC_THREADS_AND_NOTIFY;
> > +
> > +    return multifd_send_sync_main(req);
> >  }
> >  
> >  bool multifd_send_prepare_common(MultiFDSendParams *p)
> > diff --git a/migration/multifd.c b/migration/multifd.c
> > index 498e71fd10..77645e87a0 100644
> > --- a/migration/multifd.c
> > +++ b/migration/multifd.c
> > @@ -523,7 +523,7 @@ static int multifd_zero_copy_flush(QIOChannel *c)
> >      return ret;
> >  }
> >  
> > -int multifd_send_sync_main(void)
> > +int multifd_send_sync_main(MultiFDSyncReq req)
> >  {
> >      int i;
> >      bool flush_zero_copy;
> > @@ -543,8 +543,8 @@ int multifd_send_sync_main(void)
> >           * We should be the only user so far, so not possible to be set by
> >           * others concurrently.
> >           */
> > -        assert(qatomic_read(&p->pending_sync) == false);
> > -        qatomic_set(&p->pending_sync, true);
> > +        assert(qatomic_read(&p->pending_sync) == MULTIFD_SYNC_NONE);
> > +        qatomic_set(&p->pending_sync, req);
> 
> Hmm, isn't it easier to skip the whole loop if req ==
> MULTIFD_SYNC_THREADS? I don't remember why we kept this loop here for
> mapped-ram.

The "thread-only" version of request (or, in your preferred naming, "local"
sync request) says: "please flush all the works enqueued in sender thread".
Sync is still needed even for mapped-ram to make sure pwrite()s all land.
Also needed for VFIO.

> 
> >          qemu_sem_post(&p->sem);
> >      }
> >      for (i = 0; i < migrate_multifd_channels(); i++) {
> > @@ -635,14 +635,16 @@ static void *multifd_send_thread(void *opaque)
> >               */
> >              qatomic_store_release(&p->pending_job, false);
> >          } else {
> > +            MultiFDSyncReq req = qatomic_read(&p->pending_sync);
> > +
> >              /*
> >               * If not a normal job, must be a sync request.  Note that
> >               * pending_sync is a standalone flag (unlike pending_job), so
> >               * it doesn't require explicit memory barriers.
> >               */
> > -            assert(qatomic_read(&p->pending_sync));
> > +            assert(req != MULTIFD_SYNC_NONE);
> >  
> > -            if (use_packets) {
> > +            if (req == MULTIFD_SYNC_THREADS_AND_NOTIFY) {
> 
> Good, more explicit.
> 
> >                  p->flags = MULTIFD_FLAG_SYNC;
> >                  multifd_send_fill_packet(p);
> >                  ret = qio_channel_write_all(p->c, (void *)p->packet,
> > @@ -654,7 +656,7 @@ static void *multifd_send_thread(void *opaque)
> >                  stat64_add(&mig_stats.multifd_bytes, p->packet_len);
> >              }
> >  
> > -            qatomic_set(&p->pending_sync, false);
> > +            qatomic_set(&p->pending_sync, MULTIFD_SYNC_NONE);
> 
> It's a bit weird that MULTIFD_SYNC_THREADS will never have an use inside
> the thread.

It has; it guarantees that existing queued pending_job is completed.

> Makes me think it should never exist in the first place. But
> then we're back into pending_sync + use_packets... looks like it would
> be less convoluted to skip the loop up there and assert(!use_packets) in
> here.
> 
> Unless I'm missing something...
> 
> >              qemu_sem_post(&p->sem_sync);
> >          }
> >      }
> 

-- 
Peter Xu


