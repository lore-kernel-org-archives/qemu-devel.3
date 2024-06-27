Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5612C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 14:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMqY6-0003ei-AL; Thu, 27 Jun 2024 10:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sMqY3-0003dF-Jl
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:56:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sMqXz-0007eJ-Om
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719500187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hKb+OWGffCQM6vmS9ZCViWqQ+SCHRTt52pbtk6BvoW8=;
 b=MNoW3FelLgz9J6Su8waQkliNqF1y/LsrniXT3MRm4Y6egtSKgCQGUH5/ZDuuiZwoOIfqtv
 46d1pQ5chGpCTQ1TgW42l1ayv5IV7hYR0Y4UALYZNHAvU6A17E+U47gHXINnPkSE5aZqEG
 YQW8Qu1vZ6Z2xzaswjqhUytYgzGA7vQ=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-6uXWZ1lvPLqR-BodMIkkAQ-1; Thu, 27 Jun 2024 10:56:24 -0400
X-MC-Unique: 6uXWZ1lvPLqR-BodMIkkAQ-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3d1ca308617so1548244b6e.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 07:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719500183; x=1720104983;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hKb+OWGffCQM6vmS9ZCViWqQ+SCHRTt52pbtk6BvoW8=;
 b=Z0OsCwveCFymrn8TaIVQzwCHitA07cBRi8sExE4eoA2Yvq2AQq5AAI1ulSGmUeuUX5
 wK5YUhHV/h409+LzaLNBYAvrlwWzOUTv6m0xQ9yIo8gsUxSTdTDAB316UaLrwtdQ4J2g
 ilEo69xj9oI8Kw7Y9t1uWpa2IwTSsUfQT/T07YVzeJsDJSlVu13wHX06sg4dAt7nnA8W
 TO96Pbfc/CqBZY0PvDY4KO09BtHf8tcBP3qj2KRJf6XZ5g5FWly1azvFJSdIHdVcq1Kq
 bxeL6eV0MmwtY22wI9RvwbyQe5ofm3RIJ4s9/s7tHYxiWfE5E7fzbycb0VutZTzmcOZM
 Cxdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+iFGUG+MJusYTf6YD1Gf2aOTXrrjkv8+YgU2wz3zBeepcTgaiz8Mgq29hAPKXXbdllMfOcHQ9zkXe56euQ5gz+iR4cas=
X-Gm-Message-State: AOJu0YzclmA7G0bktOWZN8yE+S9Xh6Yho5+cB55UGQgfwlJsMqDja2tv
 eSbUchZLLX2r4wGpOS4WTO5baRbTekOmKnHPshsH8HMhd8GcnPWKCrtKoTdIP59kRD/64wrTEab
 ENh+n+o2FWIJX3bAiSPuAg4Tc3usJzwxditq1KCTPn1kH7NYhZ6sO
X-Received: by 2002:a05:6808:219a:b0:3d2:3e31:6cf3 with SMTP id
 5614622812f47-3d53eaa4068mr17418718b6e.0.1719500181921; 
 Thu, 27 Jun 2024 07:56:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGj5NSL+o/O2ojg0s6yJnobphdKxsHZNosf3SxuYh229LypwNzB9QDttNU/3nBOtorQ9OAkzg==
X-Received: by 2002:a05:6808:219a:b0:3d2:3e31:6cf3 with SMTP id
 5614622812f47-3d53eaa4068mr17418653b6e.0.1719500180319; 
 Thu, 27 Jun 2024 07:56:20 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44641e0b5cdsm6454661cf.18.2024.06.27.07.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 07:56:19 -0700 (PDT)
Date: Thu, 27 Jun 2024 10:56:17 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v1 00/13] =?utf-8?Q?Multifd_?= =?utf-8?B?8J+UgA==?=
 device state transfer support with VFIO consumer
Message-ID: <Zn19kaeFiYuwwc4B@x1n>
References: <cover.1718717584.git.maciej.szmigiero@oracle.com>
 <ZniFH14DT6ycjbrL@x1n>
 <b0dc8bc4-742b-474b-a4c4-4e190fd6af37@maciej.szmigiero.name>
 <Znr9mOo_t0DkkLbD@x1n>
 <9e85016e-ac72-4207-8e69-8cba054cefb7@maciej.szmigiero.name>
 <Znt0FQHJEtGxcLxj@x1n>
 <2066bb2e-ccb3-45b8-aaf7-c39303e7f993@maciej.szmigiero.name>
 <ZnxAZDcjlZ5oerq-@x1n>
 <73630858-3b65-4fc5-8f5f-a1f494c5c111@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <73630858-3b65-4fc5-8f5f-a1f494c5c111@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 27, 2024 at 11:14:28AM +0200, Maciej S. Szmigiero wrote:
> On 26.06.2024 18:23, Peter Xu wrote:
> > On Wed, Jun 26, 2024 at 05:47:34PM +0200, Maciej S. Szmigiero wrote:
> > > On 26.06.2024 03:51, Peter Xu wrote:
> > > > On Wed, Jun 26, 2024 at 12:44:29AM +0200, Maciej S. Szmigiero wrote:
> > > > > On 25.06.2024 19:25, Peter Xu wrote:
> > > > > > On Mon, Jun 24, 2024 at 09:51:18PM +0200, Maciej S. Szmigiero wrote:
> > > > > > > Hi Peter,
> > > > > > 
> > > > > > Hi, Maciej,
> > > > > > 
> > > > > > > 
> > > > > > > On 23.06.2024 22:27, Peter Xu wrote:
> > > > > > > > On Tue, Jun 18, 2024 at 06:12:18PM +0200, Maciej S. Szmigiero wrote:
> > > > > > > > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > > > > > > > 
> > > > > > > > > This is an updated v1 patch series of the RFC (v0) series located here:
> > > > > > > > > https://lore.kernel.org/qemu-devel/cover.1713269378.git.maciej.szmigiero@oracle.com/
> > > > > > > > 
> > > > > > > > OK I took some hours thinking about this today, and here's some high level
> > > > > > > > comments for this series.  I'll start with which are more relevant to what
> > > > > > > > Fabiano has already suggested in the other thread, then I'll add some more.
> > > > > > > > 
> > > > > > > > https://lore.kernel.org/r/20240620212111.29319-1-farosas@suse.de
> > > > > > > 
> > > > > > > That's a long list, thanks for these comments.
> > > > > > > 
> > > > > > > I have responded to them inline below.
> > > > > > > 
> (..)
> > > > > > > > 4. Risk of OOM on unlimited VFIO buffering
> > > > > > > > ==========================================
> > > > > > > > 
> > > > > > > > This follows with above bullet, but my pure question to ask here is how
> > > > > > > > does VFIO guarantees no OOM condition by buffering VFIO state?
> > > > > > > > 
> > > > > > > > I mean, currently your proposal used vfio_load_bufs_thread() as a separate
> > > > > > > > thread to only load the vfio states until sequential data is received,
> > > > > > > > however is there an upper limit of how much buffering it could do?  IOW:
> > > > > > > > 
> > > > > > > > vfio_load_state_buffer():
> > > > > > > > 
> > > > > > > >       if (packet->idx >= migration->load_bufs->len) {
> > > > > > > >           g_array_set_size(migration->load_bufs, packet->idx + 1);
> > > > > > > >       }
> > > > > > > > 
> > > > > > > >       lb = &g_array_index(migration->load_bufs, typeof(*lb), packet->idx);
> > > > > > > >       ...
> > > > > > > >       lb->data = g_memdup2(&packet->data, data_size - sizeof(*packet));
> > > > > > > >       lb->len = data_size - sizeof(*packet);
> > > > > > > >       lb->is_present = true;
> > > > > > > > 
> > > > > > > > What if garray keeps growing with lb->data allocated, which triggers the
> > > > > > > > memcg limit of the process (if QEMU is in such process)?  Or just deplete
> > > > > > > > host memory and causing OOM kill.
> > > > > > > > 
> > > > > > > > I think we may need to find a way to throttle max memory usage of such
> > > > > > > > buffering.
> > > > > > > > 
> > > > > > > > So far this will be more of a problem indeed if this will be done during
> > > > > > > > VFIO iteration phases, but I still hope a solution can work with both
> > > > > > > > iteration phase and the switchover phase, even if you only do that in
> > > > > > > > switchover phase
> > > > > > > 
> > > > > > > Unfortunately, this issue will be hard to fix since the source can
> > > > > > > legitimately send the very first buffer (chunk) of data as the last one
> > > > > > > (at the very end of the transmission).
> > > > > > > 
> > > > > > > In this case, the target will need to buffer nearly the whole data.
> > > > > > > 
> > > > > > > We can't stop the receive on any channel, either, since the next missing
> > > > > > > buffer can arrive at that channel.
> > > > > > > 
> > > > > > > However, I don't think purposely DoSing the target QEMU is a realistic
> > > > > > > security concern in the typical live migration scenario.
> > > > > > > 
> > > > > > > I mean the source can easily force the target QEMU to exit just by
> > > > > > > feeding it wrong migration data.
> > > > > > > 
> > > > > > > In case someone really wants to protect against the impact of
> > > > > > > theoretically unbounded QEMU memory allocations during live migration
> > > > > > > on the rest of the system they can put the target QEMU process
> > > > > > > (temporally) into a memory-limited cgroup.
> > > > > > 
> > > > > > Note that I'm not worrying about DoS of a malicious src QEMU, and I'm
> > > > > > exactly talking about the generic case where QEMU (either src or dest, in
> > > > > > that case normally both) is put into the memcg and if QEMU uses too much
> > > > > > memory it'll literally get killed even if no DoS issue at all.
> > > > > > 
> > > > > > In short, we hopefully will have a design that will always work with QEMU
> > > > > > running in a container, without 0.5% chance dest qemu being killed, if you
> > > > > > see what I meant.
> > > > > > 
> > > > > > The upper bound of VFIO buffering will be needed so the admin can add that
> > > > > > on top of the memcg limit and as long as QEMU keeps its words it'll always
> > > > > > work without sudden death.
> > > > > > 
> > > > > > I think I have some idea about resolving this problem.  That idea can
> > > > > > further complicate the protocol a little bit.  But before that let's see
> > > > > > whether we can reach an initial consensus on this matter first, on whether
> > > > > > this is a sane request.  In short, we'll need to start to have a
> > > > > > configurable size to say how much VFIO can buffer, maybe per-device, or
> > > > > > globally.  Then based on that we need to have some logic guarantee that
> > > > > > over-mem won't happen, also without heavily affecting concurrency (e.g.,
> > > > > > single thread is definitely safe and without caching, but it can be
> > > > > > slower).
> > > > > 
> > > > > Here, I think I can add a per-device limit parameter on the number of
> > > > > buffers received out-of-order or waiting to be loaded into the device -
> > > > > with a reasonable default.
> > > > 
> > > > Yes that should work.
> > > > 
> > > > I don't even expect people would change that, but this might be the
> > > > information people will need to know before putting it into a container if
> > > > it's larger than how qemu dynamically consumes memories here and there.
> > > > I'd expect it is still small enough so nobody will notice it (maybe a few
> > > > tens of MBs? but just wildly guessing, where tens of MBs could fall into
> > > > the "noise" memory allocation window of a VM).
> > > 
> > > The single buffer size is 8 MiB so I think the safe default should be
> > > allowing 2 times the number of multifd channels.
> > > 
> > > With 5 multifd channels that's 10 buffers * 8 MiB = 80 MiB worst
> > > case buffering per device.
> > > 
> > > But this will need to be determined experimentally once such parameter
> > > is added to be sure it's enough.
> > 
> > Yes you may want to test it with a new logic to be able to throttle sending
> > on src qemu (because otherwise when dest qemu is very unlucky its buffer is
> > full but still the initial index chunk is missing), then making sure it's
> > relatively small but hopefully still keep the flow running as much as
> > possible.
> > 
> > > 
> > > > > 
> > > > > (..)
> > > > > > > > 5. Worker thread model
> > > > > > > > ======================
> > > > > > > > 
> > > > > > > > I'm so far not happy with what this proposal suggests on creating the
> > > > > > > > threads, also the two new hooks mostly just to create these threads..
> > > > > > > 
> > > > > > > That VFIO .save_live_complete_precopy_begin handler crates a new
> > > > > > > per-device thread is an implementation detail for this particular
> > > > > > > driver.
> > > > > > > 
> > > > > > > The whole idea behind this and save_live_complete_precopy_end hook was
> > > > > > > that details how the particular device driver does its own async saving
> > > > > > > is abstracted away from the migration core.
> > > > > > > 
> > > > > > > The device then can do what's best / most efficient for it to do.
> > > > > > 
> > > > > > Yes, and what I was thinking is whether it does it in form of "enqueue a
> > > > > > task to migration worker threads", rather than "creating its own threads in
> > > > > > the device hooks, and managing those threads alone".
> > > > > > 
> > > > > > It's all about whether such threading can be reused by non-VFIO devices.
> > > > > > They can't be reused if VFIO is in charge here, and it will make migration
> > > > > > less generic.
> > > > > > 
> > > > > > My current opinion is they can and should be re-usable. Consider if someone
> > > > > > starts to teach multifd carry non-vfio data (e.g. a generic VMSD), then we
> > > > > > can enqueue a task, do e.g. ioctl(KVM_GET_REGS) in those threads (rather
> > > > > > than VFIO read()).
> > > > > 
> > > > > Theoretically, it's obviously possible to wrap every operation in a request
> > > > > to some thread pool.
> > > > > 
> > > > > 
> > > > > But that would bring a lot of complexity, since instead of performing these
> > > > > operation directly now the requester will need to:
> > > > > 1) Prepare some "Operation" structure with the parameters of the requested
> > > > > operation (task).
> > > > > In your case this could be QEMU_OP_GET_VCPU_REGS operation using
> > > > > "OperationGetVCPURegs" struct containing vCPU number parameter = 1.
> > > > 
> > > > Why such complexity is needed?
> > > 
> > > I just gave an example how implementing running a individual task like
> > > "ioctl(KVM_GET_REGS)" (that you suggested above) in such thread pool would
> > > look like.
> > > > Can it be as simple as func(opaque) to be queued, then here
> > > > func==vfio_save_complete_precopy_async_thread, opaque=VFIODevice*?
> > > 
> > > That would be possible, although in both implementations of:
> > > 1) adding a new thread pool type and wrapping device reading thread
> > > creation around such pool, OR:
> > > 2) a direct qemu_thread_create() call.
> > > the number of threads actually created would be the same.
> > 
> > Again, it's not about the number of threads that I worry.
> > 
> > If you create one thread but hard to manage it's the same.
> > 
> > OTOH if it's a common model I think it's fine if you create 16 or 32,
> > especially if when most of them are either idle or doing block IOs, then
> > they'll be put to sleep anyway.  That's not a concern at all.
> > 
> > > 
> > > That's unless someone sets the multifd channel count below the number
> > > of VFIO devices - but one might argue that's not really a configuration
> > > where good performance is expected anyway.
> > > 
> > > > > 
> > > > > 2) Submit this operation to the thread pool and wait for it to complete,
> > > > 
> > > > VFIO doesn't need to have its own code waiting.  If this pool is for
> > > > migration purpose in general, qemu migration framework will need to wait at
> > > > some point for all jobs to finish before moving on.  Perhaps it should be
> > > > at the end of the non-iterative session.
> > > 
> > > So essentially, instead of calling save_live_complete_precopy_end handlers
> > > from the migration code you would like to hard-code its current VFIO
> > > implementation of calling vfio_save_complete_precopy_async_thread_thread_terminate().
> > > 
> > > Only it wouldn't be then called VFIO precopy async thread terminate but some
> > > generic device state async precopy thread terminate function.
> > 
> > I don't understand what did you mean by "hard code".
> 
> "Hard code" wasn't maybe the best expression here.
> 
> I meant the move of the functionality that's provided by
> vfio_save_complete_precopy_async_thread_thread_terminate() in this patch set
> to the common migration code.

I see.  That function only does a thread_join() so far.

So can I understand it as below [1] should work for us, and it'll be clean
too (with nothing to hard-code)?

The time to join() the worker threads can be even later, until
migrate_fd_cleanup() on sender side.  You may have a better idea on when
would be the best place to do it when start working on it.

> 
> > What I was saying is if we target the worker thread pool to be used for
> > "concurrently dump vmstates", then it'll make sense to make sure all the
> > jobs there were flushed after qemu dumps all non-iterables (because this
> > should be the last step of the switchover).
> > 
> > I expect it looks like this:
> > 
> >    while (pool->active_threads) {
> >        qemu_sem_wait(&pool->job_done);
> >    }

[1]

> > 
> > > 
> > > > > 
> > > > > 3) Thread pool needs to check whether it has any free threads in the pool
> > > > > available to perform this operation.
> > > > > 
> > > > > If not, and the count of threads that are CPU-bound (~aren't sleeping on
> > > > > some I/O operation) is less than the number of logical CPUs in the system
> > > > > the thread pool needs to spawn a new thread since there's some CPU capacity
> > > > > available,
> > > > 
> > > > For this one it can follow what thread-pool.c is doing, and the upper bound
> > > > of n-threads can start from simple, e.g. min(n_channels_multifd, 8)?
> > > 
> > > It needs to be min(n_channels_multifd, n_device_state_devices), because
> > > with 9 such devices and 9 multifd channels we need at least 9 threads.
> > > 
> > > > > 
> > > > > 4) The operation needs to be dispatched to the actual execution thread,
> > > > > 
> > > > > 5) The execution thread needs to figure out which operation it needs to
> > > > > actually do, fetch the necessary parameters from the proper "Operation"
> > > > > structure, maybe take the necessary locks, before it can actually perform
> > > > > the requested operation,
> > > > > 
> > > > > 6) The execution thread needs to serialize (write) the operation result
> > > > > back into some "OperationResult" structure, like "OperationGetVCPURegsResult",
> > > > 
> > > > I think in this simplest case, the thread should simply run fn(opaque), in
> > > > which it should start to call multifd_queue_device_state() and queue
> > > > multifd jobs from the worker thread instead of the vfio dedicated threads.
> > > > I don't yet expect much to change in your code from that regard inside what
> > > > vfio_save_complete_precopy_async_thread() used to do.
> > > > 
> > > > > 
> > > > > 7) The execution thread needs to submit this result back to the requester,
> > > > > 
> > > > > 8) The thread pool needs to decide whether to keep this (now idle) execution
> > > > > thread in the pool as a reserve thread or terminate it immediately,
> > > > > 
> > > > > 9) The requester needs to be resumed somehow (returned from wait) now that
> > > > > the operation it requested is complete,
> > > > > 
> > > > > 10) The requester needs the fetch the operation results from the proper
> > > > > "OperationResult" structure and decode them accordingly.
> > > > > 
> > > > > 
> > > > > As you can see, that's *a lot* of extra code that needs to be maintained
> > > > > for just a single operation type.
> > > > 
> > > > I don't yet know why you designed it so complicated, but if I missed
> > > > something above please let me know.
> > > 
> > > I explained above that's how running your example of "ioctl(KVM_GET_REGS)"
> > > in such thread pool would look like.
> > > (It wasn't a proposal to be actually implemented to be clear)
> > > 
> > > > > 
> > > > > > > 
> > > > > > > > I know I suggested that.. but that's comparing to what I read in the even
> > > > > > > > earlier version, and sorry I wasn't able to suggest something better at
> > > > > > > > that time because I simply thought less.
> > > > > > > > 
> > > > > > > > As I mentioned in the other reply elsewhere, I think we should firstly have
> > > > > > > > these threads ready to take data at the start of migration, so that it'll
> > > > > > > > work when someone wants to add vfio iteration support.  Then the jobs
> > > > > > > > (mostly what vfio_save_complete_precopy_async_thread() does now) can be
> > > > > > > > enqueued into the thread pools.
> > > > > > > 
> > > > > > > I'm not sure that we can get way with using fewer threads than devices
> > > > > > > as these devices might not support AIO reads from their migration file
> > > > > > > descriptor.
> > > > > > 
> > > > > > It doesn't need to use AIO reads - I'll be happy if the thread model can be
> > > > > > generic, VFIO can still enqueue a task that does blocking reads.
> > > > > > 
> > > > > > It can take a lot of time, but it's fine: others who like to enqueue too
> > > > > > and see all threads busy, they should simply block there and waiting for
> > > > > > the worker threads to be freed again.  It's the same when there's no
> > > > > > migration worker threads as it means the read() will block the main
> > > > > > migration thread.
> > > > > 
> > > > > Oh no, waiting for another device blocking read to complete before
> > > > > scheduling another device blocking read is surely going to negatively
> > > > > impact the performance.
> > > > 
> > > > There can be e.g. 8 worker threads.  If you want you can make sure the
> > > > worker threads are at least more than vfio threads.  Then it will guarantee
> > > > vfio will dump / save() one device per thread concurrently.
> > > 
> > > Yes, I wrote this requirement above as
> > > n_threads = min(n_channels_multifd, n_device_state_devices).
> > > 
> > > > > 
> > > > > For best performance we need to maximize parallelism - that means
> > > > > reading (and loading) all the VFIO devices present in parallel.
> > > > > 
> > > > > The whole point of having per-device threads is for the whole operation
> > > > > to be I/O bound but never CPU bound on a reasonably fast machine - and
> > > > > especially not number-of-threads-in-pool bound.
> > > > > 
> > > > > > Now we can have multiple worker threads doing things concurrently if
> > > > > > possible (some of them may not, especially when BQL will be required, but
> > > > > > that's a separate thing, and many device save()s may not need BQL, and when
> > > > > > it needs we can take it in the enqueued tasks).
> > > > > > 
> > > > > > > 
> > > > > > > mlx5 devices, for example, seems to support only poll()ed / non-blocking
> > > > > > > reads at best - with unknown performance in comparison with issuing
> > > > > > > blocking reads from dedicated threads.
> > > > > > > 
> > > > > > > On the other hand, handling a single device from multiple threads in
> > > > > > > parallel is generally not possible due to difficulty of establishing in
> > > > > > > which order the buffers were read.
> > > > > > > 
> > > > > > > And if we need a per-VFIO device thread anyway then using a thread pool
> > > > > > > doesn't help much - but brings extra complexity.
> > > > > > > 
> > > > > > > In terms of starting the loading thread earlier to load also VM live
> > > > > > > phase data it looks like a small change to the code so it shouldn't be
> > > > > > > a problem.
> > > > > > 
> > > > > > That's good to know.  Please still consider a generic thread model and see
> > > > > > what that would also work for your VFIO use case.
> > > > > > 
> > > > > > If you see what thread-pool.c did right now is it'll dynamically create
> > > > > > threads on the fly.  I think that's something we can do too but just apply
> > > > > > an upper limit to the thread numbers.
> > > > > 
> > > > > We have an upper limit on the count of saving threads already - it's the
> > > > > count of VFIO devices in the VM.
> > > > > 
> > > > > The API in util/thread-pool.c is very basic and basically only allows
> > > > > submitting either AIO operations or generic function call operation
> > > > > but still within some AioContext.
> > > > 
> > > > What I'm saying is a thread pool _without_ aio.  I think it might be called
> > > > ThreadPoolRaw and let ThreadPool depend on it, but I didn't further check yet.
> > > 
> > > So it's not using an existing thread pool implementation from util/thread-pool.c
> > > but essentially creating a new one - with probably some code commonality
> > > with the existing AIO one.
> > > 
> > > That's possible but since util/thread-pool.c AFAIK isn't owned by the
> > > migration subsystem such new implementation will probably need also review by
> > > other QEMU maintainers.
> > 
> > Yes, that's how we normally should do it.  Obviously you still want to push
> > that in 9.1, so if you want you can create that pool implementation under
> > migration/, and we can try to move it over as a future rework, having block
> > people review that later.
> 
> I think that with this thread pool introduction we'll unfortunately almost certainly
> need to target this patch set at 9.2, since these overall changes (and Fabiano
> patches too) will need good testing, might uncover some performance regressions
> (for example related to the number of buffers limit or Fabiano multifd changes),
> bring some review comments from other people, etc.
> 
> In addition to that, we are in the middle of holiday season and a lot of people
> aren't available - like Fabiano said he will be available only in a few weeks.

Right, that's unfortunate.  Let's see, but still I really hope we can also
get some feedback from Fabiano before it lands, even with that we have
chance for 9.1 but it's just challenging, it's the same condition I
mentioned since the 1st email.  And before Fabiano's back (he's the active
maintainer for this release), I'm personally happy if you can propose
something that can land earlier in this release partly.  E.g., if you want
we can at least upstream Fabiano's idea first, or some more on top.

For that, also feel to have a look at my comment today:

https://lore.kernel.org/r/Zn15y693g0AkDbYD@x1n

Feel free to comment there too.  There's a tiny uncertainty there so far on
specifying "max size for a device state" if do what I suggested, as multifd
setup will need to allocate an enum buffer suitable for both ram + device.
But I think that's not an issue and you'll tackle that properly when
working on it.  It's more about whether you agree on what I said as a
general concept.

> 
> > > 
> > > > > 
> > > > > There's almost none of the operation execution logic I described above -
> > > > > all of these would need to be written and maintained.
> > > > > 
> > > > > > > 
> > > > > > > > It's better to create the thread pool owned by migration, rather than
> > > > > > > > threads owned by VFIO, because it also paves way for non-VFIO device state
> > > > > > > > save()s, as I mentioned also above on the multifd packet header.  Maybe we
> > > > > > > > can have a flag in the packet header saying "this is device xxx's state,
> > > > > > > > just load it".
> > > > > > > 
> > > > > > > I think the same could be done by simply implementing these hooks in other
> > > > > > > device types than VFIO, right?
> > > > > > > 
> > > > > > > And if we notice that these implementations share a bit of code then we
> > > > > > > can think about making a common helper library out of this code.
> > > > > > > 
> > > > > > > After, all that's just an implementation detail that does not impact
> > > > > > > the underlying bit stream protocol.
> > > > > > 
> > > > > > You're correct.
> > > > > > 
> > > > > > However, it still affects a few things.
> > > > > > 
> > > > > > Firstly, it may mean that we may not even need those two extra vmstate
> > > > > > hooks: the enqueue can happen already with save_state() if the migration
> > > > > > worker model exists.
> > > > > > 
> > > > > > So instead of this:
> > > > > > 
> > > > > >            vfio_save_state():
> > > > > >            if (migration->multifd_transfer) {
> > > > > >                    /* Emit dummy NOP data */
> > > > > >                    qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> > > > > >                    return;
> > > > > >            }
> > > > > > 
> > > > > > We can already do:
> > > > > > 
> > > > > >            if (migration->multifd_transfer) {
> > > > > >                    // enqueue task to load state for this vfio device
> > > > > >                    ...
> > > > > >                    return;
> > > > > >            }
> > > > > > 
> > > > > > IMHO it'll be much cleaner in VFIO code, and much cleaner too for migration
> > > > > > code.
> > > > > 
> > > > > The save_state hook is executed too late - only after all iterable
> > > > > hooks have already transferred all their data.
> > > > > 
> > > > > We want to start saving this device state as early as possible to not
> > > > > have to wait for any other device to transfer its data first.
> > > > > 
> > > > > That's why the code introduces save_live_complete_precopy_begin hook
> > > > > that's guaranteed to be the very first hook called during switchover
> > > > > phase device state saving.
> > > > 
> > > > I think I mis-typed.. What I wanted to say is vfio_save_complete_precopy(),
> > > > not vfio_save_state().
> > > > 
> > > > There will be one challenge though where RAM is also an iterable, so RAM's
> > > > save_live_complete_precopy() can delay VFIO's, even if it simply only need
> > > > to enqueue a job.
> > > > 
> > > > Two solutions I can think of:
> > > > 
> > > >     (1) Provide a separate hook, e.g. save_live_complete_precopy_async(),
> > > >     when save_live_complete_precopy_async(opaque) is provided, instead of
> > > >     calling save_live_complete_precopy(), we inject that job into the worker
> > > >     threads.  In that case we can loop over *_precopy_async() before all the
> > > >     rest *_precopy() calls.
> > > 
> > > That's basically the approach the current patch set is using, just not using
> > > pool worker threads (yet).
> > > 
> > > Only the hook was renamed from save_live_complete_precopy_async to
> > > save_live_complete_precopy_begin upon your comment on RFC requesting that.
> > > 
> > > >     (2) Make RAM's save_live_complete_precopy() also does similar enqueue
> > > >     when multifd enabled, so RAM will be saved in the worker thread too.
> > > > 
> > > > However (2) can have other issues to work out.  Do you think (1) is still
> > > > doable?
> > > > 
> > > 
> > > Yes, I think (1) is the correct way to do it.
> > 
> > I don't think "correct" is the correct word to put it.. it's really a
> > matter of whether you want to push this earlier in-tree.
> > 
> > The 2nd proposal will be more than correct to me, IMHO.  That'll be really
> > helpful too also to VFIO when RAM can be saved concurrently, then it means
> > these things can be done all concurrently:
> > 
> >    - VFIO, one thread per one device
> >    - RAM, one thread
> >    - non-iterables
> > 
> > Otherwise 2+3 needs to be serialized.
> > 
> > If you're looking for downtime optimizations that may also relevant, afaiu.
> 
> Having RAM sent in parallel with non-iterables would make sense to me,
> but I am not 100% sure this is a safe thing to do - after all, currently
> non-iterables can rely on the whole RAM being already transferred.
> 
> Currently, it seems that only RAM, VFIO, block-dirty-bitmap and some
> s390x + ppc specific stuff implements .save_live_complete_precopy hooks.
> 
> While I am not really concerned about s390x and ppc we'd need to make
> sure that any data transferred via these hooks is transferred asynchronously,
> to not delay starting the VFIO transmission.
> 
> Anyway, that's probably not for this patch set, since if we start widening
> its scope beyond the basic device state transfer framework + VFIO we risk
> missing 9.2 too.

IMHO targetting that in 9.1 was simply too optimistic.  Next time if you
want to make sure it'll be in (or at least showing that is the goal), you
should really start early to spin with non-rfc series, rather than waiting.
Maybe that'll make the chance higher.

This series, as the 1st one to introduce (1) device state migrations on
multifd, and (2) async vmstate transfers, just can be involved as I
mentioned, because we may want to do this first and do it right, paving way
for others.

> 
> > And that's also one of the major points why I want to convince you not to
> > use a separate vfio thread, because AFAICT we simply have other users.
> > 
> > > 
> > > > > 
> > > > > > Another (possibly personal) reason is, I will not dare to touch VFIO code
> > > > > > too much to do such a refactoring later.  I simply don't have the VFIO
> > > > > > devices around and I won't be able to test.  So comparing to other things,
> > > > > > I hope VFIO stuff can land more stable than others because I am not
> > > > > > confident at least myself to clean it.
> > > > > 
> > > > > That's a fair request, will keep this on mind.
> > > > > 
> > > > > > I simply also don't like random threads floating around, considering that
> > > > > > how we already have slightly a mess with migration on other reasons (we can
> > > > > > still have random TLS threads floating around, I think... and they can
> > > > > > cause very hard to debug issues). I feel shaky to maintain it when any
> > > > > > device can also start to create whatever threads they can during migration.
> > > > > 
> > > > > The threads themselves aren't very expensive as long as their number
> > > > > is kept within reasonable bounds.
> > > > > 
> > > > > 4 additional threads (present only during active migration operation)
> > > > > with 4 VFIO devices is really not a lot.
> > > > 
> > > > It's not about number, it's about management, and when something crashed at
> > > > some unwanted point, then we may want to know what happened to those
> > > > threads and how to recycle them.
> > > 
> > > I guess if you are more comfortable with maintaining code written in such
> > > way then that's some argument for it too.
> > 
> > It's not about my flavour of maintenance.
> > 
> > We used to work on issues where we see a dangling thread operate on
> > migration objects even if it was created in the _previous_ migration,
> > cancelled and retried.  And the thread doesn't know that.  It was kind of
> > leaked and it causes issues hard to debug.
> > 
> > VFIO can cause similar thing if it can create some threads that migration
> > developers may overlook and not easy to manage.  Then it'll be the same
> > challenge when a vfio thread dangled for some reason and it'll just make
> > things harder to debug when issue happens.
> > 
> > I want to make sure if ever possible migration framework manages threads on
> > its own, so no thread will be fiddling around without being noticed.
> > 
> > Not to mention as I mentioned previously, that "having some async model to
> > dump vmstate" isn't something special to VFIO, it can easily be extended to
> > either RAM, or other normal VMSDs if we can tackle other issues here and
> > there.  The general request is the same.  It'll be a chaos if vfio starts
> > to create its own threads, then vDPA and others.  It is much saner to make
> > it a generic model to me.
> 
> I more or less know now how the v2 of this patch set needs to look like
> (at least architecturally).
> 
> Will try to prepare something in the coming weeks.

Thanks.

-- 
Peter Xu


