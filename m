Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECDFCD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 21:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrlqx-00010s-JC; Tue, 02 Apr 2024 17:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rrlqv-00010a-Df
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 17:39:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rrlqs-0003oE-5E
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 17:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712093969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zf68qQqVlnYoa/uiN9R4kFVVV+0NZFqHB0Zlz5TcqX0=;
 b=GJjrYjzhSc+mf/1XA5PBGB8zfxL1fl4ErgwAVUr/PnwWcXBaQ5FGYeRxcOn1abfhTnZ3vO
 76xRc0A1WtGIkqXZpA5TsoVAAh1w7oNqz8LuTmrF3d9v3m3lJzgxvROaptaVu0X7p24Mjx
 K9+XCSIsqqaHk99kSfWLd+GdEidetrk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-ux5w3mgbPUGc0fVsEsf7bg-1; Tue, 02 Apr 2024 17:39:28 -0400
X-MC-Unique: ux5w3mgbPUGc0fVsEsf7bg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-699133268a7so2194696d6.1
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 14:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712093967; x=1712698767;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zf68qQqVlnYoa/uiN9R4kFVVV+0NZFqHB0Zlz5TcqX0=;
 b=T/nNVs5Ne+UvW8KfoJsIZmHbS05LM/b6aLx9s4rfCi5x89owfSyMgj7A+r5mPOd7f8
 C2L78JtqC6dV7QfSpmmVOg+uFQfi6EjnlX0ZEw/aeijz0LHqTGuW/mxdy9zg6CrC39BT
 qsF3BI1aZB9hFnt+z9q7MOErPJqMpMmHE9AjoR2MWRgK5fK2p/f1VkmctAnYwHkc7Neb
 R8ICp45mTQHE9EZrqv5KfgKdq2xp7wvzTgmSO2az+M6X3Yfh14cdo68wfpd/3sabfZdX
 hXyJsKwJok2jrhSmukceRDhafTtchE+nztrbA3aeWq7R19YUVnmlXwatyoTN1WpF8tLE
 dMFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvOyvsWp6PZ1unWrapj/iPp5/RVh3NjUJ29jDKYh+Ahd8eknrjcwtS9nMku+W3552xKJFqW6RQedzElAGjD+pviEFBDIE=
X-Gm-Message-State: AOJu0YwTIO5R0A+zEQXHJeoMxrLG2I9rbgJvXM5/kFK9SZd+LCBdO6U1
 YRBvP2Wqbk7h7UF/WT++KHUkvHqDhCj0CJQLqJ/PKVsU74dQw8GsWI0rSQhbwrqSAnAn0AjKude
 11ToXZNYD1X8nHeyLMtXuNa8OYjES6+i5RPxpV0gZAwC50NThEuyv
X-Received: by 2002:ad4:404b:0:b0:699:1907:7676 with SMTP id
 r11-20020ad4404b000000b0069919077676mr2889929qvp.5.1712093967231; 
 Tue, 02 Apr 2024 14:39:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7I3ypovAPYGA1RHX+B735EKDLMyV4x+0PAi1nWCYV0EbyqyUSvLStF4J2niciUamaQDZ7pQ==
X-Received: by 2002:ad4:404b:0:b0:699:1907:7676 with SMTP id
 r11-20020ad4404b000000b0069919077676mr2889904qvp.5.1712093966563; 
 Tue, 02 Apr 2024 14:39:26 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 11-20020a05621420cb00b006986c3f3d21sm5889971qve.116.2024.04.02.14.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 14:39:26 -0700 (PDT)
Date: Tue, 2 Apr 2024 17:39:24 -0400
From: Peter Xu <peterx@redhat.com>
To: "Wang, Lei" <lei4.wang@intel.com>
Cc: "Wang, Wei W" <wei.w.wang@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "farosas@suse.de" <farosas@suse.de>
Subject: Re: [PATCH] migration: Yield coroutine when receiving
 MIG_CMD_POSTCOPY_LISTEN
Message-ID: <Zgx7DI4LXYrR_dk-@x1n>
References: <20240329033205.26087-1-lei4.wang@intel.com>
 <DS0PR11MB6373254218DDBF279B13FD79DC3A2@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZgrdIDGe3aNcRu7o@x1n>
 <ce89cb04-65d0-4f43-ad87-ead6e69c1e09@intel.com>
 <DS0PR11MB6373AE29375A2910057CC313DC3E2@DS0PR11MB6373.namprd11.prod.outlook.com>
 <9aa5d1be-7801-40dd-83fd-f7e041ced249@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9aa5d1be-7801-40dd-83fd-f7e041ced249@intel.com>
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

On Tue, Apr 02, 2024 at 05:28:36PM +0800, Wang, Lei wrote:
> On 4/2/2024 15:25, Wang, Wei W wrote:> On Tuesday, April 2, 2024 2:56 PM, Wang,
> Lei4 wrote:
> >> On 4/2/2024 0:13, Peter Xu wrote:> On Fri, Mar 29, 2024 at 08:54:07AM +0000,
> >> Wang, Wei W wrote:
> >>>> On Friday, March 29, 2024 11:32 AM, Wang, Lei4 wrote:
> >>>>> When using the post-copy preemption feature to perform post-copy
> >>>>> live migration, the below scenario could lead to a deadlock and the
> >>>>> migration will never finish:
> >>>>>
> >>>>>  - Source connect() the preemption channel in postcopy_start().
> >>>>>  - Source and the destination side TCP stack finished the 3-way handshake
> >>>>>    thus the connection is successful.
> >>>>>  - The destination side main thread is handling the loading of the bulk
> >> RAM
> >>>>>    pages thus it doesn't start to handle the pending connection event in the
> >>>>>    event loop. and doesn't post the semaphore
> >> postcopy_qemufile_dst_done for
> >>>>>    the preemption thread.
> >>>>>  - The source side sends non-iterative device states, such as the virtio
> >>>>>    states.
> >>>>>  - The destination main thread starts to receive the virtio states, this
> >>>>>    process may lead to a page fault (e.g., virtio_load()->vring_avail_idx()
> >>>>>    may trigger a page fault since the avail ring page may not be received
> >>>>>    yet).
> >>>
> >>> Ouch.  Yeah I think this part got overlooked when working on the
> >>> preempt channel.
> >>>
> >>>>>  - The page request is sent back to the source side. Source sends the page
> >>>>>    content to the destination side preemption thread.
> >>>>>  - Since the event is not arrived and the semaphore
> >>>>>    postcopy_qemufile_dst_done is not posted, the preemption thread in
> >>>>>    destination side is blocked, and cannot handle receiving the page.
> >>>>>  - The QEMU main load thread on the destination side is stuck at the page
> >>>>>    fault, and cannot yield and handle the connect() event for the
> >>>>>    preemption channel to unblock the preemption thread.
> >>>>>  - The postcopy will stuck there forever since this is a deadlock.
> >>>>>
> >>>>> The key point to reproduce this bug is that the source side is
> >>>>> sending pages at a rate faster than the destination handling,
> >>>>> otherwise, the qemu_get_be64() in
> >>>>> ram_load_precopy() will have a chance to yield since at that time
> >>>>> there are no pending data in the buffer to get. This will make this
> >>>>> bug harder to be reproduced.
> >>>
> >>> How hard would this reproduce?
> >>
> >> We can manually make this easier to reproduce by adding the following code
> >> to make the destination busier to load the pages:
> >>
> >> diff --git a/migration/ram.c b/migration/ram.c index 0ad9fbba48..0b42877e1f
> >> 100644
> >> --- a/migration/ram.c
> >> +++ b/migration/ram.c
> >> @@ -4232,6 +4232,7 @@ static int ram_load_precopy(QEMUFile *f)  {
> >>      MigrationIncomingState *mis = migration_incoming_get_current();
> >>      int flags = 0, ret = 0, invalid_flags = 0, len = 0, i = 0;
> >> +    volatile unsigned long long a;
> >>
> >>      if (!migrate_compress()) {
> >>          invalid_flags |= RAM_SAVE_FLAG_COMPRESS_PAGE; @@ -4347,6
> >> +4348,7 @@ static int ram_load_precopy(QEMUFile *f)
> >>              break;
> >>
> >>          case RAM_SAVE_FLAG_PAGE:
> >> +            for (a = 0; a < 100000000; a++);
> >>              qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
> >>              break;
> >>
> > 
> > Which version of QEMU are you using?
> > I tried with the latest upstream QEMU (e.g. v8.2.0 release, 1600b9f46b1bd), it's
> > always reproducible without any changes (with local migration tests).
> 
> I'm using the latest tip:
> 
> 	6af9d12c88b9720f209912f6e4b01fefe5906d59
> 
> and it cannot be reproduced without the modification.

It does look like there's some mistery in reproducability.  I can't
reproduce it locally with v8.2.0 tag, neither can I reproduce it with the
code above.

I've requested our QE team to involve, but before that I may need help on
any verifications.

> 
> > 
> > 
> >>>
> >>> I'm thinking whether this should be 9.0 material or 9.1.  It's pretty
> >>> late for 9.0 though, but we can still discuss.
> >>>
> >>>>>
> >>>>> Fix this by yielding the load coroutine when receiving
> >>>>> MIG_CMD_POSTCOPY_LISTEN so the main event loop can handle the
> >>>>> connection event before loading the non-iterative devices state to
> >>>>> avoid the deadlock condition.
> >>>>>
> >>>>> Signed-off-by: Lei Wang <lei4.wang@intel.com>
> >>>>
> >>>> This seems to be a regression issue caused by this commit:
> >>>> 737840e2c6ea (migration: Use the number of transferred bytes
> >>>> directly)
> >>>>
> >>>> Adding qemu_fflush back to migration_rate_exceeded() or
> >>>> ram_save_iterate seems to work (might not be a good fix though).
> >>>>
> >>>>> ---
> >>>>>  migration/savevm.c | 5 +++++
> >>>>>  1 file changed, 5 insertions(+)
> >>>>>
> >>>>> diff --git a/migration/savevm.c b/migration/savevm.c index
> >>>>> e386c5267f..8fd4dc92f2 100644
> >>>>> --- a/migration/savevm.c
> >>>>> +++ b/migration/savevm.c
> >>>>> @@ -2445,6 +2445,11 @@ static int
> >> loadvm_process_command(QEMUFile *f)
> >>>>>          return loadvm_postcopy_handle_advise(mis, len);
> >>>>>
> >>>>>      case MIG_CMD_POSTCOPY_LISTEN:
> >>>>> +        if (migrate_postcopy_preempt() && qemu_in_coroutine()) {
> >>>>> +            aio_co_schedule(qemu_get_current_aio_context(),
> >>>>> +                            qemu_coroutine_self());
> >>>>> +            qemu_coroutine_yield();
> >>>>> +        }
> >>>>
> >>>> The above could be moved to loadvm_postcopy_handle_listen().
> >>>
> >>> I'm not 100% sure such thing (no matter here or moved into it, which
> >>> does look cleaner) would work for us.
> >>>
> >>> The problem is I still don't yet see an ordering restricted on top of
> >>> (1)
> >>> accept() happens, and (2) receive LISTEN cmd here.  What happens if
> >>> the
> >>> accept() request is not yet received when reaching LISTEN?  Or is it
> >>> always guaranteed the accept(fd) will always be polled here?
> >>>
> >>> For example, the source QEMU (no matter pre-7.2 or later) will always
> >>> setup the preempt channel asynchrounously, then IIUC it can connect()
> >>> after sending the whole chunk of packed data which should include this
> >>> LISTEN.  I think it means it's not guaranteed this will 100% work, but
> >>> maybe further reduce the possibility of the race.
> >>
> >> I think the following code:
> >>
> >> postcopy_start() ->
> >> 	postcopy_preempt_establish_channel() ->
> >> 		qemu_sem_wait(&s->postcopy_qemufile_src_sem);
> >>
> >> can guarantee that the connect() syscall is successful so the destination side
> >> receives the connect() request before it loads the LISTEN command, otherwise
> >> it won't post the sem:
> >>
> >> postcopy_preempt_send_channel_new() ->
> >> 	postcopy_preempt_send_channel_done() ->
> >>     		qemu_sem_post(&s->postcopy_qemufile_src_sem);
> >>
> > 
> > Yes. But as mentioned in another thread, connect() and accept() are async.
> > So in theory accept() could still come later after the LISTEN command.
> 
> IIUC accept() is the callback and will be triggered by the connect() event.
> 
> The reason accept() is not called in the destination is the main loop doesn't
> get a chance to handle other events (connect()), so if we can guarantee
> connect() is before LISTEN, then when handling the LISTEN cmd, we yield to the
> main loop and the connect() event is there, then we can handle it by calling the
> accept():
> 
> qio_net_listener_channel_func
> 	qio_channel_socket_accept
> 		qemu_accept
> 			accept
> 
> so it seems the case accept() comes alter after LISTEN is in our expectation?

The major thing uncertain to me is "accept() will return with a valid fd"
on dest host is not guaranteed to order against anything.

For example, I won't be surprised if a kernel implementation provides an
async model of "accept()" syscall, so that even if the other side returned
with "connect()", the "accept()" can still fetch nothing if the async model
will need a delay for the new channel to be finally delivered to the
"accept()" thread context.  It just sounds like tricky to rely on such
thing.

What I proposed below shouldn't rely on any kernel details on how accept()
could be implemented, it simply waits for the fd to be created before doing
anything else (including creating the preempt thread and process packed
data).

> 
> > 
> >>>
> >>> One right fix that I can think of is moving the sem_wait(&done) into
> >>> the main thread too, so we wait for the sem _before_ reading the
> >>> packed data, so there's no chance of fault.  However I don't think
> >>> sem_wait() will be smart enough to yield when in a coroutine..  In the
> >>> long term run I think we should really make migration loadvm to do
> >>> work in the thread rather than the main thread.  I think it means we
> >>> have one more example to be listed in this todo so that's preferred..
> >>>
> >>> https://wiki.qemu.org/ToDo/LiveMigration#Create_a_thread_for_migration
> >>> _destination
> >>>
> >>> I attached such draft patch below, but I'm not sure it'll work.  Let
> >>> me know how both of you think about it.
> >>
> >> Sadly it doesn't work, there is an unknown segfault.

Could you paste the stack of the segfault ("(gdb) thread apply all bt")?
Or help to figure out what is wrong?

Since I cannot reproduce myself, I may need your help debugging this.  If
you agree with what I said above and agree on such fix, please also feel
free to go ahead and fix the segfault.

> >>
> >>>
> >>>>
> >>>> Another option is to follow the old way (i.e. pre_7_2) to do
> >>>> postcopy_preempt_setup in migrate_fd_connect. This can save the above
> >>>> overhead of switching to the main thread during the downtime. Seems
> >>>> Peter's previous patch already solved the channel disordering issue. Let's
> >> see Peter and others' opinions.
> >>>
> >>> IIUC we still need that pre_7_2 stuff and keep the postponed connect()
> >>> to make sure the ordering is done properly.  Wei, could you elaborate
> >>> the patch you mentioned?  Maybe I missed some spots.
> >>>
> >>> You raised a good point that this may introduce higher downtime.  Did
> >>> you or Lei tried to measure how large it is?  If that is too high, we
> >>> may need to think another solution, e.g., wait the channel connection
> >>> before vm stop happens.
> >>
> >> Per my very simple test, using post-copy preemption to live migrate an 8G VM:
> >>
> >>     w/o this patch: 121ms in avg in 5 tries
> >>     w/ this patch: 115ms in avg in 5 tries
> >>
> >> So it seems the overhead introduced is not too high (maybe ignorable?).
> > 
> > You could just measure the time for the added qemu_coroutine_yield() part.
> > The time will depend on how many events happen to be there waiting for a dispatch.
> 
> Still less than 1ms (0.05ms).
> 
> Indeed, that may depends on how many events needs to be handled.

That sounds fine as of now.  I think it means if we can come up with a
solid plan this week (without intrusive changes), we still have chance to
land it in 9.0.

Thanks,

-- 
Peter Xu


