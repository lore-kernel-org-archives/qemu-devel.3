Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88729CF9C59
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 16:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srgle-00044S-Lr; Fri, 20 Sep 2024 12:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srgld-000437-2L
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 12:46:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srgla-0000ti-Pe
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 12:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726850755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=du3soqcUea/NVhbdUTSxvPRNKzDEwYb8T33zWNbIdkM=;
 b=SZlmnnQx+sC/W0uDSCzG2mrOq7tgkKI0QDrnY8Bd5PpzeKy578rVfHL9mGQXB5r6g8wnP1
 cnQJUSaKQ37V5Bmt8P7NaQLCh3rNyqv+toSusIBLpjh9fc6g20mqgWDmoni96nW9ZM1UXW
 6H0Nutgwt+1X99P65u1+7MD6OKfHaJY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-1wp0hQRcPz-JJ74UKmwMYA-1; Fri, 20 Sep 2024 12:45:54 -0400
X-MC-Unique: 1wp0hQRcPz-JJ74UKmwMYA-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7a9a85e4a85so485808385a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2024 09:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726850754; x=1727455554;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=du3soqcUea/NVhbdUTSxvPRNKzDEwYb8T33zWNbIdkM=;
 b=DWrIrWJ1TUC1kASNzDFijA3ndh/s5jbHaIMT6F8gv/O7YTT1Atf1ZJNW2bCUEJnjh9
 ghIqZn2msYL3cnYq7r1l3x+uL+bTWLDt4NuAHbpz01y6FbzhYr528Yi2Ce4DMlDRnjnM
 NQfQj6AQgBkIOJh2jHfNrUFt7ToIwNlAkw5qbiex7OR5YSF2XozqcOOAi5CsGjQ7vq0O
 zwRxqgWZLalJ3HCf0FHekjbqgAcHDFPzUvJ/nKqTS8dI0zhjxkEDCrKa/evkko8FrWHp
 zRYc2p0jPiaeqC1+v5ANiPDyo5ECBpfj8v5b0acahI1xmAa8jmO5HdZLA+DUPKyT1xBy
 vjSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn2j+af6ZiTyxRywTb5SLsrlCb951jct6TfjjVjqqFT4vpF4dH+0/WNU7+/BK6zkdU0d64LYqdWxUx@nongnu.org
X-Gm-Message-State: AOJu0YxkuzuVcFG5Dhh/iIzbrA10FAViP6fgOXi88rBXi+QaTAfMMYul
 /5d9bmDEnYXlsqKJPb+I2pN9q+HUDLluRfbvhP4VyMs2If8sHHW6Ev7EUp3WYC/OmVzEQp4O+nj
 xuBlXCZ+CF3NnmNVI+/xmsWf29hZ33Kwc5OTRIattyUgXCeUZSKLg
X-Received: by 2002:a05:620a:258d:b0:7a9:bf92:45ba with SMTP id
 af79cd13be357-7acb7ff6791mr525593285a.0.1726850754152; 
 Fri, 20 Sep 2024 09:45:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq19CSCLzbiK7VNfoLyrMYxOnVY9xWjzoseZX/zhNI3M8oY4RMoBWYQOiPgZeVijSB0oqqsA==
X-Received: by 2002:a05:620a:258d:b0:7a9:bf92:45ba with SMTP id
 af79cd13be357-7acb7ff6791mr525587885a.0.1726850753528; 
 Fri, 20 Sep 2024 09:45:53 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7acb08dae51sm197992285a.122.2024.09.20.09.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 09:45:52 -0700 (PDT)
Date: Fri, 20 Sep 2024 12:45:50 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 08/17] migration: Add load_finish handler and
 associated functions
Message-ID: <Zu2mvrKOvmD1WtvD@x1n>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <1a7599896decdbae61cee385739dc0badc9b4364.1724701542.git.maciej.szmigiero@oracle.com>
 <Zt9UjvvbeUZQlGNY@x1n>
 <d245c8b6-b765-42e1-a5ec-bdb46494cec4@maciej.szmigiero.name>
 <ZuyTjQJujZo6tw9p@x1n>
 <bbed8165-de5c-4ebe-a6cc-ff33f9ea363a@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bbed8165-de5c-4ebe-a6cc-ff33f9ea363a@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 20, 2024 at 05:23:08PM +0200, Maciej S. Szmigiero wrote:
> On 19.09.2024 23:11, Peter Xu wrote:
> > On Thu, Sep 19, 2024 at 09:49:10PM +0200, Maciej S. Szmigiero wrote:
> > > On 9.09.2024 22:03, Peter Xu wrote:
> > > > On Tue, Aug 27, 2024 at 07:54:27PM +0200, Maciej S. Szmigiero wrote:
> > > > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > > > 
> > > > > load_finish SaveVMHandler allows migration code to poll whether
> > > > > a device-specific asynchronous device state loading operation had finished.
> > > > > 
> > > > > In order to avoid calling this handler needlessly the device is supposed
> > > > > to notify the migration code of its possible readiness via a call to
> > > > > qemu_loadvm_load_finish_ready_broadcast() while holding
> > > > > qemu_loadvm_load_finish_ready_lock.
> > > > > 
> > > > > Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> > > > > ---
> > > > >    include/migration/register.h | 21 +++++++++++++++
> > > > >    migration/migration.c        |  6 +++++
> > > > >    migration/migration.h        |  3 +++
> > > > >    migration/savevm.c           | 52 ++++++++++++++++++++++++++++++++++++
> > > > >    migration/savevm.h           |  4 +++
> > > > >    5 files changed, 86 insertions(+)
> > > > > 
> > > > > diff --git a/include/migration/register.h b/include/migration/register.h
> > > > > index 4a578f140713..44d8cf5192ae 100644
> > > > > --- a/include/migration/register.h
> > > > > +++ b/include/migration/register.h
> > > > > @@ -278,6 +278,27 @@ typedef struct SaveVMHandlers {
> > > > >        int (*load_state_buffer)(void *opaque, char *data, size_t data_size,
> > > > >                                 Error **errp);
> > > > > +    /**
> > > > > +     * @load_finish
> > > > > +     *
> > > > > +     * Poll whether all asynchronous device state loading had finished.
> > > > > +     * Not called on the load failure path.
> > > > > +     *
> > > > > +     * Called while holding the qemu_loadvm_load_finish_ready_lock.
> > > > > +     *
> > > > > +     * If this method signals "not ready" then it might not be called
> > > > > +     * again until qemu_loadvm_load_finish_ready_broadcast() is invoked
> > > > > +     * while holding qemu_loadvm_load_finish_ready_lock.
> > > > 
> > > > [1]
> > > > 
> > > > > +     *
> > > > > +     * @opaque: data pointer passed to register_savevm_live()
> > > > > +     * @is_finished: whether the loading had finished (output parameter)
> > > > > +     * @errp: pointer to Error*, to store an error if it happens.
> > > > > +     *
> > > > > +     * Returns zero to indicate success and negative for error
> > > > > +     * It's not an error that the loading still hasn't finished.
> > > > > +     */
> > > > > +    int (*load_finish)(void *opaque, bool *is_finished, Error **errp);
> > > > 
> > > > The load_finish() semantics is a bit weird, especially above [1] on "only
> > > > allowed to be called once if ..." and also on the locks.
> > > 
> > > The point of this remark is that a driver needs to call
> > > qemu_loadvm_load_finish_ready_broadcast() if it wants for the migration
> > > core to call its load_finish handler again.
> > > 
> > > > It looks to me vfio_load_finish() also does the final load of the device.
> > > > 
> > > > I wonder whether that final load can be done in the threads,
> > > 
> > > Here, the problem is that current VFIO VMState has to be loaded from the main
> > > migration thread as it internally calls QEMU core address space modification
> > > methods which explode if called from another thread(s).
> > 
> > Ahh, I see.  I'm trying to make dest qemu loadvm in a thread too and yield
> > BQL if possible, when that's ready then in your case here IIUC you can
> > simply take BQL in whichever thread that loads it.. but yeah it's not ready
> > at least..
> 
> Yeah, long term we might want to work on making these QEMU core address space
> modification methods somehow callable from multiple threads but that's
> definitely not something for the initial patch set.
> 
> > Would it be possible vfio_save_complete_precopy_async_thread_config_state()
> > be done in VFIO's save_live_complete_precopy() through the main channel
> > somehow?  IOW, does it rely on iterative data to be fetched first from
> > kernel, or completely separate states?
> 
> The device state data needs to be fully loaded first before "activating"
> the device by loading its config state.
> 
> > And just curious: how large is it
> > normally (and I suppose this decides whether it's applicable to be sent via
> > the main channel at all..)?
> 
> Config data is *much* smaller than device state data - as far as I remember
> it was on order of kilobytes.
> 
> > > 
> > > > then after
> > > > everything loaded the device post a semaphore telling the main thread to
> > > > continue.  See e.g.:
> > > > 
> > > >       if (migrate_switchover_ack()) {
> > > >           qemu_loadvm_state_switchover_ack_needed(mis);
> > > >       }
> > > > 
> > > > IIUC, VFIO can register load_complete_ack similarly so it only sem_post()
> > > > when all things are loaded?  We can then get rid of this slightly awkward
> > > > interface.  I had a feeling that things can be simplified (e.g., if the
> > > > thread will take care of loading the final vmstate then the mutex is also
> > > > not needed? etc.).
> > > 
> > > With just a single call to switchover_ack_needed per VFIO device it would
> > > need to do a blocking wait for the device buffers and config state load
> > > to finish, therefore blocking other VFIO devices from potentially loading
> > > their config state if they are ready to begin this operation earlier.
> > 
> > I am not sure I get you here, loading VFIO device states (I mean, the
> > non-iterable part) will need to be done sequentially IIUC due to what you
> > said and should rely on BQL, so I don't know how that could happen
> > concurrently for now.  But I think indeed BQL is a problem.
> Consider that we have two VFIO devices (A and B), with the following order
> of switchover_ack_needed handler calls for them: first A get this call,
> once the call for A finishes then B gets this call.
> 
> Now consider what happens if B had loaded all its buffers (in the loading
> thread) and it is ready for its config load before A finished loading its
> buffers.
> 
> B has to wait idle in this situation (even though it could have been already
> loading its config) since the switchover_ack_needed handler for A won't
> return until A is fully done.

This sounds like a performance concern, and I wonder how much this impacts
the real workload (that you run a test and measure, with/without such
concurrency) when we can save two devices in parallel anyway; I would
expect the real diff is small due to the fact I mentioned that we save >1
VFIO devices concurrently via multifd.

Do you think we can start with a simpler approach?

So what I'm thinking could be very clean is, we just discussed about
MIG_CMD_SWITCHOVER and looks like you also think it's an OK approach.  I
wonder when with it why not we move one step further to have
MIG_CMD_SEND_NON_ITERABE just to mark that "iterable devices all done,
ready to send non-iterable".  It can be controlled by the same migration
property so we only send these two flags in 9.2+ machine types.

Then IIUC VFIO can send config data through main wire (just like most of
other pci devices! which is IMHO a good fit..) and on destination VFIO
holds off loading them until passing the MIG_CMD_SEND_NON_ITERABE phase.

Side note: when looking again, I really think we should cleanup some
migration switchover phase functions, e.g. I think
qemu_savevm_state_complete_precopy() parameters are pretty confusing,
especially iterable_only, even if inside it it also have some postcopy
implicit checks, urgh.. but this is not relevant to our discussion, and I
won't draft that before your series land; that can complicate stuff.

> 
> > So IMHO this recv side interface so far is the major pain that I really
> > want to avoid (comparing to the rest) in the series.  Let's see whether we
> > can come up with something better..
> > 
> > One other (probably not pretty..) idea is when waiting here in the main
> > thread it yields BQL, then other threads can take it and load the VFIO
> > final chunk of data.  But I could miss something else.
> > 
> 
> I think temporary dropping BQL deep inside migration code is similar
> to running QEMU event loop deep inside migration code (about which
> people complained in my generic thread pool implementation): it's easy
> to miss some subtle dependency/race somewhere and accidentally cause rare
> hard to debug deadlock.
> 
> That's why I think that it's ultimately probably better to make QEMU core
> address space modification methods thread safe / re-entrant instead.

Right, let's see how you think about above.

Thanks,

-- 
Peter Xu


