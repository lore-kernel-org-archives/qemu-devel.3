Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B13C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trey2-0004E2-Ck; Mon, 10 Mar 2025 11:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1trexP-0003ux-22
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:22:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1trexK-0000zb-1p
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741620129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8j/0YZ/a8vnpyyHDdlMVmtyKeFiVD69rd9saa+aIlSQ=;
 b=IMPhFoPt4aMs5lBIgGIqgLfm6xyipNedecmrUDKKmusSOdyP2s8jcdQ4qwF3HWhJP+ZcPx
 wdB54g8dnJpkNF196DuXij6qjt58DRYsBTBQ8zW+eUsnJMWTjU3DjpLsYOPbjQ0+oixTag
 We1RehY1Z4mBrLl/wsFXMaoc8AxhCgI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-iSNXSsj3NXqc7_QQd3kQxg-1; Mon, 10 Mar 2025 11:22:07 -0400
X-MC-Unique: iSNXSsj3NXqc7_QQd3kQxg-1
X-Mimecast-MFC-AGG-ID: iSNXSsj3NXqc7_QQd3kQxg_1741620127
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4768f9fea35so24650221cf.2
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 08:22:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741620127; x=1742224927;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8j/0YZ/a8vnpyyHDdlMVmtyKeFiVD69rd9saa+aIlSQ=;
 b=qbqjP3G3SlNwgeH48BgCxZ7IHiRmTWqBvCFMbBatxuLPyv/MCLh6zeHgzpGlcDZ6Fw
 cDMkAbWWe5qO2bv2eL7XBo1CuCpK6ekY2U3Bn7Jh63aX1Fz2pWa7y+9uJ1JxyonjCWoj
 NpwS125XJnlHj2E20HDfKUQjVWX2y6lg1lsr/klQQWE2djF8UGb/Rk3ypuxM5dChh6pm
 iHV0ri34NobVokpKX5/Xl/4X9PzGc6Sa7cSuUbinS6xSNntdL7YvgpCX7+qFw3inN/f2
 0sf1z4Pvv8IyN9ln0LpbK0R1eC9qyrDXyLC9PzkSYYWPYmNzxJo8xA8XE3MYrpJtROua
 Bkew==
X-Gm-Message-State: AOJu0YxJgqffM1/DYwwRKkUYQTqruSw/f4k36A4Or6G2ROLxvTs0n6fp
 eHaOU1QcjCqL4IojDesGMyR5BhT7nkoVRGhYWkuiA+BFKGS7LI0Nxh3a8QT3+ZOHVblMBdbiKaW
 otQDkXp72GnqZc3BcYZWXxxEknvwpYGwBrXMJ/nLcPgEsSHZc/38c
X-Gm-Gg: ASbGncvq0nLq4QQz+mVEvbIZmbWoR9Rd052l+1kMVEV97KrF88CzlXwYcnwr2l8vCMU
 JKzwWbljGPbkAdBs7FgNoYTIG8jQb6jMUPeoORndqx3LHu/LrqMH+iLcyV2ALl/0ZH2vpHdeVuy
 pHdea+fDX1Bm+ZwuNezBTZ2lrfQ0mivZppoBeZ0wD5XKXtvcc0NTV5chmcGMVZz5yTEuA/XsjVU
 uYgcwVgmQ6h2uhz/ncS4evkQm1dD63CBw8aXiGS+RqRAh1rIDfg7ModQREqyzsWcOmw1pcxFzrE
 L0izAqU=
X-Received: by 2002:a05:622a:1441:b0:476:95dd:521c with SMTP id
 d75a77b69052e-47695dd54ddmr17311171cf.45.1741620127039; 
 Mon, 10 Mar 2025 08:22:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLajNJ8AT0SYzVetm61eT9MXSoz6r+ttbQbLkw8rdkXe+qq3daoJ7lxF7Byil/gaKWBw0A/w==
X-Received: by 2002:a05:622a:1441:b0:476:95dd:521c with SMTP id
 d75a77b69052e-47695dd54ddmr17310611cf.45.1741620126505; 
 Mon, 10 Mar 2025 08:22:06 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4766afde61asm31016311cf.10.2025.03.10.08.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 08:22:06 -0700 (PDT)
Date: Mon, 10 Mar 2025 11:22:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH 1/2] migration: Add some documentation for multifd
Message-ID: <Z88DmvrNrW5Q1n7y@x1.local>
References: <20250307134203.29443-1-farosas@suse.de>
 <20250307134203.29443-2-farosas@suse.de>
 <Z8ssc0NETt9KJjTG@x1.local> <87tt84u0d2.fsf@suse.de>
 <Z8tv53G5s9MLYv6f@x1.local> <87o6y9t14g.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o6y9t14g.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Mar 10, 2025 at 11:24:15AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Fri, Mar 07, 2025 at 04:06:17PM -0300, Fabiano Rosas wrote:
> >> > I never tried vsock, would it be used in any use case?
> >> >
> >> 
> >> I don't know, I'm going by what's in the code.
> >> 
> >> > It seems to be introduced by accident in 72a8192e225cea, but I'm not sure.
> >> > Maybe there's something I missed.
> >> 
> >> The code was always had some variation of:
> >> 
> >> static bool transport_supports_multi_channels(SocketAddress *saddr)
> >> {
> >>     return strstart(uri, "tcp:", NULL) || strstart(uri, "unix:", NULL) ||
> >>            strstart(uri, "vsock:", NULL);
> >> }
> >> 
> >> Introduced by b7acd65707 ("migration: allow multifd for socket protocol
> >> only").
> >
> > Looks like a copy-paste error..  I found it, should be 9ba3b2baa1
> > ("migration: add vsock as data channel support").
> >
> > https://lore.kernel.org/all/2bc0e226-ee71-330a-1bcd-bd9d097509bc@huawei.com/
> > https://kvmforum2019.sched.com/event/Tmzh/zero-next-generation-virtualization-platform-for-huawei-cloud-jinsong-liu-zhichao-huang-huawei
> > https://e.huawei.com/sa/material/event/HC/e37b9c4c33e14e869bb1183fab468fed
> >
> 
> Great, thanks for finding those. I'll add it to my little "lore"
> folder. This kind of information is always good to know.
> 
> > So if I read it right.. the VM in this case is inside a container or
> > something, then it talks to an "agent" on a PCIe device which understands
> > virtio-vsock protocol.  So maybe vsock just performs better than other ways
> > to dig that tunnel for the container.
> >
> > In that case, mentioning vsock is at least ok.
> >
> > [...]
> >
> >> >> +After the channels have been put into a wait state by the sync
> >> >> +functions, the client code may continue to transmit additional data by
> >> >> +issuing ``multifd_send()`` once again.
> >> >> +
> >> >> +Note:
> >> >> +
> >> >> +- the RAM migration does, effectively, a global synchronization by
> >> >> +  chaining a call to ``multifd_send_sync_main()`` with the emission of a
> >> >> +  flag on the main migration channel (``RAM_SAVE_FLAG_MULTIFD_FLUSH``)
> >> >
> >> > ... or RAM_SAVE_FLAG_EOS ... depending on the machine type.
> >> >
> >> 
> >> Eh.. big compatibility mess. I rather not mention it.
> >
> > It's not strictly a compatibility mess.  IIUC, it was used to be designed
> > to always work with EOS.  I think at that time Juan was still focused on
> > making it work and not whole perf tunings, but then we found it can be a
> > major perf issue if we flush too soon.  Then if we flush it once per round,
> > it may not always pair with a EOS.  That's why we needed a new message.
> >
> 
> Being fully honest, at the time I got the impression the situation was
> "random person inside RH decided to measure performance of random thing
> and upstream maintainer felt pressure to push a fix".
> 
> Whether that was the case or not, it doesn't matter now, but we can't
> deny that this _has_ generated some headache, just look at how many
> issues arose from the introduction of that flag.

I might be the "random person" here.  I remember I raised this question to
Juan on why we need to flush for each iteration.

I also remember we did perf test, we can redo it.  But we can discuss the
design first.

To me, this is a fairly important question to ask.  Fundamentally, the very
initial question is why do we need periodic flush and sync at all.  It's
because we want to make sure new version of pages to land later than old
versions.

Note that we can achieve that in other ways too. E.g., if we only enqueue a
page to a specific multifd thread (e.g. page_index % n_multifd_threads),
then it'll guarantee the ordering without flush and sync, because new / old
version for the same page will only go via the same channel, which
guarantees ordering of packets in time order naturally.  But that at least
has risk of not being able to fully leverage the bandwidth, e.g., worst
case is the guest has dirty pages that are accidentally always hashed to
the same channel; consider a program keeps dirtying every 32K on a 4K psize
system with 8 channels.  Or something like that.

Not documenting EOS part is ok too from that pov, because it's confusing
too on why we need to flush per EOS.  Per-round is more understandable from
that POV, because we want to make sure new version lands later, and
versioning boost for pages only happen per-round, not per-iteration.

> 
> > But hey, you're writting a doc that helps everyone.  You deserve to decide
> > whether you like to mention it or not on this one. :)
> 
> My rant aside, I really want to avoid any readers having to think too
> much about this flush thing. We're already seeing some confusion when
> discussing it with Prasad in the other thread. The code itself and the
> git log are more reliable to explain the compat situation IMO.
> 
> >
> > IIRC we updated our compat rule so we maintain each machine type for only 6
> > years.  It means the whole per-iteration + EOS stuff can be removed in 3.5
> > years or so - we did that work in July 2022.  So it isn't that important
> > either to mention indeed.
> >
> 
> Yep, that as well.
> 
> >> 
> >> > Maybe we should also add a sentence on the relationship of
> >> > MULTIFD_FLAG_SYNC and RAM_SAVE_FLAG_MULTIFD_FLUSH (or RAM_SAVE_FLAG_EOS ),
> >> > in that they should always be sent together, and only if so would it
> >> > provide ordering of multifd messages and what happens in the main migration
> >> > thread.
> >> >
> >> 
> >> The problem is that RAM_SAVE_FLAGs are a ram.c thing. In theory the need
> >> for RAM_SAVE_FLAG_MULTIFD_FLUSH is just because the RAM migration is
> >> driven by the source machine by the flags that are put on the
> >> stream. IOW, this is a RAM migration design, not a multifd design. The
> >> multifd design is (could be, we decide) that once sync packets are sent,
> >> _something_ must do the following:
> >> 
> >>     for (i = 0; i < thread_count; i++) {
> >>         trace_multifd_recv_sync_main_wait(i);
> >>         qemu_sem_wait(&multifd_recv_state->sem_sync);
> >>     }
> >> 
> >> ... which is already part of multifd_recv_sync_main(), but that just
> >> _happens to be_ called by ram.c when it sees the
> >> RAM_SAVE_FLAG_MULTIFD_FLUSH flag on the stream, that's not a multifd
> >> design requirement. The ram.c code could for instance do the sync when
> >> some QEMU_VM_SECTION_EOS (or whatever it's called) appears.
> >
> > I still think it should be done in RAM code only.  One major goal (if not
> > the only goal..) is it wants to order different versions of pages and
> > that's only what the RAM module is about, not migration in general.
> >
> > From that POV, having a QEMU_VM_* is kind of the wrong layer - they should
> > work for migration in general.
> >
> > Said so, I agree we do violate it from time to time, for example, we have a
> > bunch of subcmds (MIG_CMD_POSTCOPY*) just for postcopy, which is under
> > QEMU_VM_COMMAND.  But IIUC that was either kind of ancient (so we need to
> > stick with them now.. postcopy was there for 10 years) or it needs some
> > ping-pong messages in which case QEMU_VM_COMMAND is the easiest.. IMHO we
> > should still try to stick with the layering if possible.
> 
> All good points, but I was talking of something else:
> 
> I was just throwing an example of how it could be done differently to
> make the point clear that the recv_sync has nothing to do with the ram
> flag, that's just implementation detail. I was thinking specifically
> about the multifd+postcopy work where we might need syncs but there is
> no RAM_FLAGS there.
> 
> We don't actually _need_ to sync with the migration thread on the
> destination like that. The client could send control information in it's
> opaque packet (instead of in the migration thread) or in a completely
> separate channel if it wanted. That sync is also not necessary if there
> is no dependency around the data being transferred (i.e. mapped-ram just
> takes data form the file and writes to guest memory)

Mapped-ram is definitely different.

For sockets, IIUC we do rely on the messages on the multifd channels _and_
the message on the main channel.

So I may not have fully get your points above, but.. See how it more or
less implemented a remote memory barrier kind of thing _with_ the main
channel message:

     main channel    multifd channel 1        multifd channel 2      
     ------------    -----------------        -----------------
                       send page P v1
  +------------------------------------------------------------------+
  |  RAM_SAVE_FLAG_MULTIFD_FLUSH                                     |
  |                    MULTIFD_FLAG_SYNC        MULTIFD_FLAG_SYNC    |
  +------------------------------------------------------------------+
                                                send page P v2

Then v1 and v2 of the page P are ordered.

If without the message on the main channel:

     main channel    multifd channel 1        multifd channel 2      
     ------------    -----------------        -----------------
                       send page P v1
                       MULTIFD_FLAG_SYNC
                                                MULTIFD_FLAG_SYNC
                                                send page P v2

Then I don't see what protects reorder of arrival of messages like:

     main channel    multifd channel 1        multifd channel 2      
     ------------    -----------------        -----------------
                                                MULTIFD_FLAG_SYNC
                                                send page P v2
                       send page P v1
                       MULTIFD_FLAG_SYNC

> 
> To be clear I'm not suggesting we change anything, I'm only trying to
> reflect in the docs some level of separation between multifd.c and ram.c
> (or whatever else) because we've seen that mixing the two makes the
> design less clean. We've already cleared much of the "p->pages" kind of
> issues and the packet definition is more versatile after Maciej's work,
> but I still think the separation should be more strict (hence all the
> "client" talk in this doc).
> 
> (I realise I'm hijacking the documentation thread to talk about high
> level design, my apologies).
> 

-- 
Peter Xu


