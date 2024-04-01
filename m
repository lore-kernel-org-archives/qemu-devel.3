Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127F7CD1294
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 18:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrMgo-00014R-QI; Mon, 01 Apr 2024 14:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rrMgm-00013u-SQ
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 14:47:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rrMgk-0006g3-NP
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 14:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711997240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4ra9/cfH+GFzhGOD9mp5d7j3rtQJ4w3a3pl/FH6n3oY=;
 b=GRXtCLDEn+k6+LrLD6K1hCB8Fy3lpN3+atRLKrfcCYMHV9ezdTtDGnKllS9Z7LwkwtghxO
 qejU0WgKgbOqIbLV19NSgOD9AitkMhnbusl3dkZ3r6jp1g3LEPqItHW+QUXqIawkgORAGH
 D1YzbBBHOstah+InAiIgYkAqcf77ifE=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-5NK5t7ISNBKkJoLgAJI-Ww-1; Mon, 01 Apr 2024 14:47:17 -0400
X-MC-Unique: 5NK5t7ISNBKkJoLgAJI-Ww-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-6e6b0efc193so1968743a34.0
 for <qemu-devel@nongnu.org>; Mon, 01 Apr 2024 11:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711997237; x=1712602037;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ra9/cfH+GFzhGOD9mp5d7j3rtQJ4w3a3pl/FH6n3oY=;
 b=bsVy+4ymYdWQ8vLz9h/jyNxiRB9deydxr1L7AvkRFiu6RwDsrrF4ucw+tO/DWLaDUJ
 2t/9iNaT+4yaVfsqkeLLjbhYVz2n0RwM5gF8STtIQkQOm6OgGfWbcNLf+32twXLa+WXK
 1wUIGhc1j3h31MjwalJdS+w958j+5qY1KGe92JRzETX/ZPppT1d0UJH7sOdVaZ9tb4OZ
 lHUEWn00YRb2gMBQ89dPBvsaTDjRL6Vm23FnNUYijnL+Wqm+y3CllzuLtfdm/UUlWvdx
 qk8ga6qnYQH8m+Qh0QvRsyrdx66Nh9MBXYKjgr0u9ouTo2tu91kH0PgxSSJ6XM4NbU1p
 UAfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVd0FyvmNlJ7hHKMyPELIEd8GU24NMzZslLFWTy8ZR+StKIhfyE7WUG+dYDjY8i75gg2qfnCvI+rYugnl1ietje8TK4Ps=
X-Gm-Message-State: AOJu0YzPYkZCKW2oEkF9Gd0OoR/eSBmxW83S4lkfqhJkL9pQuladiqTm
 lpMTSIFqJo2kjXSd5OkMXed/BOP5fBqxc86nfDud7Vyl6yhMOG/VVGbZ396EnaHQka8kr4OXlay
 6xHy+/0Sl3EIoiUOOjE3sA0rJvMkPUN6UDLMl/dbysWSWdB9LHZnm
X-Received: by 2002:a05:6808:1887:b0:3c4:dcaa:c025 with SMTP id
 bi7-20020a056808188700b003c4dcaac025mr8147683oib.1.1711997236785; 
 Mon, 01 Apr 2024 11:47:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJayStyp1sVgdiE4D2uzvge9GScSvRo7h73FrVcUikx7ixnsmnMqtxuTmNH8K/dd7mnrxizA==
X-Received: by 2002:a05:6808:1887:b0:3c4:dcaa:c025 with SMTP id
 bi7-20020a056808188700b003c4dcaac025mr8147661oib.1.1711997236152; 
 Mon, 01 Apr 2024 11:47:16 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 j1-20020a05620a000100b0078bc5612d15sm3101959qki.127.2024.04.01.11.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Apr 2024 11:47:15 -0700 (PDT)
Date: Mon, 1 Apr 2024 14:47:13 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: "Wang, Wei W" <wei.w.wang@intel.com>, "Wang, Lei4" <lei4.wang@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] migration: Yield coroutine when receiving
 MIG_CMD_POSTCOPY_LISTEN
Message-ID: <ZgsBMWjwhzlI9ENc@x1n>
References: <20240329033205.26087-1-lei4.wang@intel.com>
 <DS0PR11MB6373254218DDBF279B13FD79DC3A2@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZgrdIDGe3aNcRu7o@x1n> <87frw5roif.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87frw5roif.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Apr 01, 2024 at 02:17:28PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Fri, Mar 29, 2024 at 08:54:07AM +0000, Wang, Wei W wrote:
> >> On Friday, March 29, 2024 11:32 AM, Wang, Lei4 wrote:
> >> > When using the post-copy preemption feature to perform post-copy live
> >> > migration, the below scenario could lead to a deadlock and the migration will
> >> > never finish:
> >> > 
> >> >  - Source connect() the preemption channel in postcopy_start().
> >> >  - Source and the destination side TCP stack finished the 3-way handshake
> >> >    thus the connection is successful.
> >> >  - The destination side main thread is handling the loading of the bulk RAM
> >> >    pages thus it doesn't start to handle the pending connection event in the
> >> >    event loop. and doesn't post the semaphore postcopy_qemufile_dst_done for
> >> >    the preemption thread.
> >> >  - The source side sends non-iterative device states, such as the virtio
> >> >    states.
> >> >  - The destination main thread starts to receive the virtio states, this
> >> >    process may lead to a page fault (e.g., virtio_load()->vring_avail_idx()
> >> >    may trigger a page fault since the avail ring page may not be received
> >> >    yet).
> >
> > Ouch.  Yeah I think this part got overlooked when working on the preempt
> > channel.
> >
> >> >  - The page request is sent back to the source side. Source sends the page
> >> >    content to the destination side preemption thread.
> >> >  - Since the event is not arrived and the semaphore
> >> >    postcopy_qemufile_dst_done is not posted, the preemption thread in
> >> >    destination side is blocked, and cannot handle receiving the page.
> >> >  - The QEMU main load thread on the destination side is stuck at the page
> >> >    fault, and cannot yield and handle the connect() event for the
> >> >    preemption channel to unblock the preemption thread.
> >> >  - The postcopy will stuck there forever since this is a deadlock.
> >> > 
> >> > The key point to reproduce this bug is that the source side is sending pages at a
> >> > rate faster than the destination handling, otherwise, the qemu_get_be64() in
> >> > ram_load_precopy() will have a chance to yield since at that time there are no
> >> > pending data in the buffer to get. This will make this bug harder to be
> >> > reproduced.
> >
> > How hard would this reproduce?
> >
> > I'm thinking whether this should be 9.0 material or 9.1.  It's pretty late
> > for 9.0 though, but we can still discuss.
> >
> >> > 
> >> > Fix this by yielding the load coroutine when receiving
> >> > MIG_CMD_POSTCOPY_LISTEN so the main event loop can handle the
> >> > connection event before loading the non-iterative devices state to avoid the
> >> > deadlock condition.
> >> > 
> >> > Signed-off-by: Lei Wang <lei4.wang@intel.com>
> >> 
> >> This seems to be a regression issue caused by this commit:
> >> 737840e2c6ea (migration: Use the number of transferred bytes directly)
> >> 
> >> Adding qemu_fflush back to migration_rate_exceeded() or ram_save_iterate
> >> seems to work (might not be a good fix though).
> >> 
> >> > ---
> >> >  migration/savevm.c | 5 +++++
> >> >  1 file changed, 5 insertions(+)
> >> > 
> >> > diff --git a/migration/savevm.c b/migration/savevm.c index
> >> > e386c5267f..8fd4dc92f2 100644
> >> > --- a/migration/savevm.c
> >> > +++ b/migration/savevm.c
> >> > @@ -2445,6 +2445,11 @@ static int loadvm_process_command(QEMUFile *f)
> >> >          return loadvm_postcopy_handle_advise(mis, len);
> >> > 
> >> >      case MIG_CMD_POSTCOPY_LISTEN:
> >> > +        if (migrate_postcopy_preempt() && qemu_in_coroutine()) {
> >> > +            aio_co_schedule(qemu_get_current_aio_context(),
> >> > +                            qemu_coroutine_self());
> >> > +            qemu_coroutine_yield();
> >> > +        }
> >> 
> >> The above could be moved to loadvm_postcopy_handle_listen().
> >
> > I'm not 100% sure such thing (no matter here or moved into it, which does
> > look cleaner) would work for us.
> >
> > The problem is I still don't yet see an ordering restricted on top of (1)
> > accept() happens, and (2) receive LISTEN cmd here.  What happens if the
> > accept() request is not yet received when reaching LISTEN?  Or is it always
> > guaranteed the accept(fd) will always be polled here?
> >
> > For example, the source QEMU (no matter pre-7.2 or later) will always setup
> > the preempt channel asynchrounously, then IIUC it can connect() after
> > sending the whole chunk of packed data which should include this LISTEN.  I
> > think it means it's not guaranteed this will 100% work, but maybe further
> > reduce the possibility of the race.
> >
> > One right fix that I can think of is moving the sem_wait(&done) into the
> > main thread too, so we wait for the sem _before_ reading the packed data,
> > so there's no chance of fault.  However I don't think sem_wait() will be
> > smart enough to yield when in a coroutine..  In the long term run I think
> > we should really make migration loadvm to do work in the thread rather than
> > the main thread.  I think it means we have one more example to be listed in
> > this todo so that's preferred..
> >
> > https://wiki.qemu.org/ToDo/LiveMigration#Create_a_thread_for_migration_destination
> >
> > I attached such draft patch below, but I'm not sure it'll work.  Let me
> > know how both of you think about it.
> >
> >> 
> >> Another option is to follow the old way (i.e. pre_7_2) to do postcopy_preempt_setup
> >> in migrate_fd_connect. This can save the above overhead of switching to the
> >> main thread during the downtime. Seems Peter's previous patch already solved the
> >> channel disordering issue. Let's see Peter and others' opinions.
> >
> > IIUC we still need that pre_7_2 stuff and keep the postponed connect() to
> > make sure the ordering is done properly.  Wei, could you elaborate the
> > patch you mentioned?  Maybe I missed some spots.
> >
> > You raised a good point that this may introduce higher downtime.  Did you
> > or Lei tried to measure how large it is?  If that is too high, we may need
> > to think another solution, e.g., wait the channel connection before vm stop
> > happens.
> >
> > Thanks,
> >
> >> 
> >> >          return loadvm_postcopy_handle_listen(mis);
> >> > 
> >> 
> >> >      case MIG_CMD_POSTCOPY_RUN:
> >> > --
> >> > 2.39.3
> >> 
> >
> > ===8<===
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 696762bc64..bacd1328cf 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -2593,6 +2593,12 @@ static int postcopy_start(MigrationState *ms, Error **errp)
> >      /*
> >       * Make sure the receiver can get incoming pages before we send the rest
> >       * of the state
> > +     *
> > +     * When preempt mode enabled, this must be done after we initiate the
> > +     * preempt channel, as destination QEMU will wait for the channel when
> > +     * processing the LISTEN request.  Currently it may not matter a huge
> > +     * deal if we always create the channel asynchrously with a qio task,
> > +     * but we need to keep this in mind.
> >       */
> >      qemu_savevm_send_postcopy_listen(fb);
> >  
> > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > index eccff499cb..4f26a89ac9 100644
> > --- a/migration/postcopy-ram.c
> > +++ b/migration/postcopy-ram.c
> > @@ -1254,6 +1254,26 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
> >      }
> >  
> >      if (migrate_postcopy_preempt()) {
> > +        /*
> > +         * The preempt channel is established in asynchronous way.  Wait
> > +         * for its completion.
> > +         */
> > +        while (!qemu_sem_timedwait(&mis->postcopy_qemufile_dst_done, 100)) {
> > +            /*
> > +             * Note that to make sure the main thread can still schedule an
> > +             * accept() request we need to proactively yield for the main
> > +             * loop to run for some duration (100ms in this case), which is
> > +             * pretty ugly.
> > +             *
> > +             * TODO: we should do this in a separate thread to load the VM
> > +             * rather than in the main thread, just like the source side.
> > +             */
> > +            if (qemu_in_coroutine()) {
> > +                aio_co_schedule(qemu_get_current_aio_context(),
> > +                                qemu_coroutine_self());
> > +                qemu_coroutine_yield();
> 
> I think the correct way to do this these days is
> aio_co_reschedule_self().

The helper checks old v.s. new contexts, where here we want to pass in the
current context.  Would that be a no-op then?

> 
> Anyway, what we are yielding to here? I see qemu_loadvm_state_main()
> called from a bunch of places, it's not clear to me where will the
> execution resume after yielding. Is that end up going to be
> migration_incoming_process()?

In this specific case it should try to yield to the port listener that is
waiting for the preempt channel, aka, socket_accept_incoming_migration(),
and ultimately it'll kick off this sem, by:

 socket_accept_incoming_migration ->
  migration_ioc_process_incoming  ->
    postcopy_preempt_new_channel

> 
> I don't know much about the postcopy parts, excuse my ignorance.

Not a problem at all, please shoot if there's any questions either here or
elsewhere. You're going to maintain it anyway as part of the migration code
base. :-D

Thanks,

-- 
Peter Xu


