Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AD8C3DA7F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 16:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sadpI-0002fr-A8; Sun, 04 Aug 2024 12:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sadp0-0002eI-Ut
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 12:11:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sadox-0001nI-Uk
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 12:11:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722787858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o93WBA3jHeImCBM87jdRdnJ1qW/xL/Oa4NWz5waBgJc=;
 b=CL9sHWtarA5L50X9IpmdcynlYosujiM8Sdueyr6nBLtwHv7H9S7gEjf4tyQJBQqUMCFMQx
 UCb7bwhx1I4XHVR4baJ3xQ3gd/q94SXzBrf+fqIPCIR87FJPB9/ghKzeIFxJhavQ+y0WEc
 Di3iFH4QLpJMYeHfHyjxRJzVJxb3vAo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-Rx2hCwExPZG9muSP3-G6bw-1; Sun, 04 Aug 2024 12:10:56 -0400
X-MC-Unique: Rx2hCwExPZG9muSP3-G6bw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6b798c6b850so17577116d6.0
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 09:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722787856; x=1723392656;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o93WBA3jHeImCBM87jdRdnJ1qW/xL/Oa4NWz5waBgJc=;
 b=Kivjg9lrCmYwZ8CppjPQWoxHFXAIaEH35OvnZs0Z+98Uq0CQQ0jwHNDlEzLwCmQJi6
 zGJAyAl+G8EhBxh7b94vN6+M1m6Zx43N7TfFmgejK2JlROJDLPpZJmFdS6ujiVT2F5Xk
 lVfhguzsU1TLhU6ZEWoPlL2szArLd6jhbX/WtwQs4T5Rb6u25nbU3lvaie1To0bTgqtT
 P4vn6wmcSd4r+NuHyx5b2qoWy9UfyWv1gSsIOoCCBXo30sXg3lhzzWNcw793rORQV1kE
 HUYKgXolEwtoN3QAWqtLLE07dCdeiYIFXH+AP7TRJBwv5WKYz/pcMwZcs23YZbY/Zz9P
 kIkw==
X-Gm-Message-State: AOJu0YxXSMTfWAxCDVdn0j+Ypy2ZmsIzd3wN17DittHDkwMsbbotJFP/
 WSWokksUaHb6HzuSq3gRa6OB+zMjKq4gOgMolP/2xFXG+I1BV/oGJEvqoutMmY+ij6IeksuIqh7
 CHsLya+S3QXoIj7Mq1yzLQNzZ6xkk1B6J5WmWiY+bhvx07A+XIRur
X-Received: by 2002:ac8:5a82:0:b0:44f:d899:148c with SMTP id
 d75a77b69052e-4518919e11fmr74408821cf.0.1722787855723; 
 Sun, 04 Aug 2024 09:10:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWrB6FJeFSTzXfJlvzgPcP1Zw+xuKOB4MO6Qannw9iwwPnExY19/aCQNx8cAQqgmn7BJFtVw==
X-Received: by 2002:ac8:5a82:0:b0:44f:d899:148c with SMTP id
 d75a77b69052e-4518919e11fmr74408521cf.0.1722787855194; 
 Sun, 04 Aug 2024 09:10:55 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4518a6ef2f0sm23063221cf.57.2024.08.04.09.10.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Aug 2024 09:10:54 -0700 (PDT)
Date: Sun, 4 Aug 2024 12:10:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 00/11] Live update: cpr-exec
Message-ID: <Zq-oDMMYTktnQUIA@x1n>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <Zpk7Mf2c7LiNV2xC@x1n>
 <4f6200fa-c052-4295-b71a-c6deca11db9f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f6200fa-c052-4295-b71a-c6deca11db9f@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sat, Jul 20, 2024 at 05:26:07PM -0400, Steven Sistare wrote:
> On 7/18/2024 11:56 AM, Peter Xu wrote:
> > Steve,
> > 
> > On Sun, Jun 30, 2024 at 12:40:23PM -0700, Steve Sistare wrote:
> > > What?
> > 
> > Thanks for trying out with the cpr-transfer series.  I saw that that series
> > missed most of the cc list here, so I'm attaching the link here:
> > 
> > https://lore.kernel.org/r/1719776648-435073-1-git-send-email-steven.sistare@oracle.com
> > 
> > I think most of my previous questions for exec() solution still are there,
> > I'll try to summarize them all in this reply as much as I can.
> > 
> > > 
> > > This patch series adds the live migration cpr-exec mode, which allows
> > > the user to update QEMU with minimal guest pause time, by preserving
> > > guest RAM in place, albeit with new virtual addresses in new QEMU, and
> > > by preserving device file descriptors.
> > > 
> > > The new user-visible interfaces are:
> > >    * cpr-exec (MigMode migration parameter)
> > >    * cpr-exec-command (migration parameter)
> > 
> > I really, really hope we can avoid this..
> > 
> > It's super cumbersome to pass in a qemu cmdline in a qemu migration
> > parameter.. if we can do that with generic live migration ways, I hope we
> > stick with the clean approach.
> 
> This is no different than live migration, requiring a management agent to
> launch target qemu with all the arguments use to start source QEMU.  Now that
> same agent will send the arguments via cpr-exec-command.

It's still a bit different.

There we append "-incoming defer" only, which makes sense because we're
instructing a QEMU to take an incoming stream to load.  Now we append the
complete qemu cmdline within the QEMU itself, that was booted with exactly
the same cmdline.. :-( I would at least start to ask why we need to pass
the same thing twice..

Not saying that this is no-go, but really looks unpretty to me from this
part.. especially if a cleaner solution seems possible.

> 
> > >    * anon-alloc (command-line option for -machine)
> > 
> > Igor questioned this, and I second his opinion..  We can leave the
> > discussion there for this one.
> 
> Continued on the other thread.
> 
> > > The user sets the mode parameter before invoking the migrate command.
> > > In this mode, the user issues the migrate command to old QEMU, which
> > > stops the VM and saves state to the migration channels.  Old QEMU then
> > > exec's new QEMU, replacing the original process while retaining its PID.
> > > The user specifies the command to exec new QEMU in the migration parameter
> > > cpr-exec-command.  The command must pass all old QEMU arguments to new
> > > QEMU, plus the -incoming option.  Execution resumes in new QEMU.
> > > 
> > > Memory-backend objects must have the share=on attribute, but
> > > memory-backend-epc is not supported.  The VM must be started
> > > with the '-machine anon-alloc=memfd' option, which allows anonymous
> > > memory to be transferred in place to the new process.
> > > 
> > > Why?
> > > 
> > > This mode has less impact on the guest than any other method of updating
> > > in place.
> > 
> > So I wonder whether there's comparison between exec() and transfer mode
> > that you recently proposed.
> 
> Not yet, but I will measure it.

Thanks.

> 
> > I'm asking because exec() (besides all the rest of things that I dislike on
> > it in this approach..) should be simply slower, logically, due to the
> > serialized operation to (1) tearing down the old mm, (2) reload the new
> > ELF, then (3) runs through the QEMU init process.
> > 
> > If with a generic migration solution, the dest QEMU can start running (2+3)
> > concurrently without even need to run (1).
> > 
> > In this whole process, I doubt (2) could be relatively fast, (3) I donno,
> > maybe it could be slow but I never measured; Paolo may have good idea as I
> > know he used to work on qboot.
> 
> We'll see, but in any case these take < 100 msec, which is a wonderfully short

I doubt whether it keeps <100ms when the VM is large.  Note that I think we
should cover the case where the user does 4k mapping for a large guest.

So I agree that 4k mapping over e.g. 1T without hugetlb may not be the
ideal case, but the question is I suspect there're indeed serious users
using QEMU like that, and if we have most exactly a parallel solution that
does cover this case, it is definitely preferrable to consider the other
from this POV, simply because there's nothing to lose there..

> pause time unless your customer is doing high speed stock trading.  If cpr-transfer
> is faster still, that's gravy, but cpr-exec is still great.
> 
> > For (1), I also doubt in your test cases it's fast, but it may not always
> > be fast.  Consider the guest has a huge TBs of shared mem, even if the
> > memory will be completely shared between src/dst QEMUs, the pgtable won't!
> > It means if the TBs are mapped in PAGE_SIZE tearing down the src QEMU
> > pgtable alone can even take time, and that will be accounted in step (1)
> > and further in exec() request.
> 
> Yes, there is an O(n) effect here, but it is a fast O(n) when the memory is
> backed by huge pages.  In UEK, we make it faster still by unmapping in parallel
> with multiple threads.  I don't have the data handy but can share after running
> some experiments.  Regardless, this time is negligible for small and medium
> size guests, which form the majority of instances in a cloud.

Possible.  It's just that it sounds like a good idea to avoid having the
downtime taking any pgtable tearing down into account here for the old mm,
irrelevant of how much time it'll take.  It's just that I suspect some use
case can take fair amount of time.

So I think this is "one point less" for exec() solution, while the issue
can be big or small on its own.  What matters is IMHO where exec() is
superior so that we'd like to pay for this.  I'll try to stop saying "let's
try to avoid using exec() as it sounds risky", but we still need to compare
with solid pros and cons.

> 
> > All these fuss will be avoided if you use a generic live migration model
> > like cpr-transfer you proposed.  That's also cleaner.
> > 
> > > The pause time is much lower, because devices need not be torn
> > > down and recreated, DMA does not need to be drained and quiesced, and minimal
> > > state is copied to new QEMU.  Further, there are no constraints on the guest.
> > > By contrast, cpr-reboot mode requires the guest to support S3 suspend-to-ram,
> > > and suspending plus resuming vfio devices adds multiple seconds to the
> > > guest pause time.  Lastly, there is no loss of connectivity to the guest,
> > > because chardev descriptors remain open and connected.
> > 
> > Again, I raised the question on why this would matter, as after all mgmt
> > app will need to coop with reconnections due to the fact they'll need to
> > support a generic live migration, in which case reconnection is a must.
> > 
> > So far it doesn't sound like a performance critical path, for example, to
> > do the mgmt reconnects on the ports.  So this might be an optimization that
> > most mgmt apps may not care much?
> 
> Perhaps.  I view the chardev preservation as nice to have, but not essential.
> It does not appear in this series, other than in docs.  It's easy to implement
> given the CPR foundation.  I suggest we continue this discussion when I post
> the chardev series, so we can focus on the core functionality.

It's just that it can affect our decision on choosing the way to go.

For example, do we have someone from Libvirt or any mgmt layer can help
justify this point?

As I said, I thought most facilities for reconnection should be ready, but
I could miss important facts in mgmt layers..

> 
> > > These benefits all derive from the core design principle of this mode,
> > > which is preserving open descriptors.  This approach is very general and
> > > can be used to support a wide variety of devices that do not have hardware
> > > support for live migration, including but not limited to: vfio, chardev,
> > > vhost, vdpa, and iommufd.  Some devices need new kernel software interfaces
> > > to allow a descriptor to be used in a process that did not originally open it.
> > 
> > Yes, I still think this is a great idea.  It just can also be built on top
> > of something else than exec().
> > 
> > > 
> > > In a containerized QEMU environment, cpr-exec reuses an existing QEMU
> > > container and its assigned resources.  By contrast, consider a design in
> > > which a new container is created on the same host as the target of the
> > > CPR operation.  Resources must be reserved for the new container, while
> > > the old container still reserves resources until the operation completes.
> > 
> > Note that if we need to share RAM anyway, the resources consumption should
> > be minimal, as mem should IMHO be the major concern (except CPU, but CPU
> > isn't a concern in this scenario) in container world and here the shared
> > guest mem shouldn't be accounted to the dest container.  So IMHO it's about
> > the metadata QEMU/KVM needs to do the hypervisor work, it seems to me, and
> > that should be relatively small.
> > 
> > In that case I don't yet see it a huge improvement, if the dest container
> > is cheap to initiate.
> 
> It's about reserving memory and CPUs, and transferring those reservations from
> the old instance to the new, and fiddling with the OS mechanisms that enforce
> reservations and limits.  The devil is in the details, and with the exec model,
> the management agent can ignore all of that.
> 
> You don't see it as a huge improvement because you don't need to write the
> management code.  I do!

Heh, possibly true.

Could I ask what management code you're working on?  Why that management
code doesn't need to already work out these problems with reconnections
(like pre-CPR ways of live upgrade)?

> 
> Both modes are valid and useful - exec in container, or launch a new container.
> I have volunteered to implement the cpr-transfer mode for the latter, a mode
> I do not use.  Please don't reward me by dropping the mode I care about :)
> Both modes can co-exist.  The presence of the cpr-exec specific code in qemu
> will not hinder future live migration development.

I'm trying to remove some of my "prejudices" on exec() :).  Hopefully that
proved more or less that I simply wanted to be fair on making a design
decision.  I don't think I have a strong opinion, but it looks to me not
ideal to merge two solutions if both modes share the use case.

Or if you think both modes should service different purpose, we might
consider both, but that needs to be justified - IOW, we shouldn't merge
anything that will never be used.

Thanks,

> 
> > > Avoiding over commitment requires extra work in the management layer.
> > 
> > So it would be nice to know what needs to be overcommitted here.  I confess
> > I don't know much on containerized VMs, so maybe the page cache can be a
> > problem even if shared.  But I hope we can spell that out.  Logically IIUC
> > memcg shouldn't account those page cache if preallocated, because memcg
> > accounting should be done at folio allocations, at least, where the page
> > cache should miss first (so not this case..).
> > 
> > > This is one reason why a cloud provider may prefer cpr-exec.  A second reason
> > > is that the container may include agents with their own connections to the
> > > outside world, and such connections remain intact if the container is reused.
> > > 
> > > How?
> 
> chardev preservation.  The qemu socket chardevs to these agents are preserved,
> and the agent connections to the outside world do not change, so no one sees
> any interruption of traffic.
> 
> > > All memory that is mapped by the guest is preserved in place.  Indeed,
> > > it must be, because it may be the target of DMA requests, which are not
> > > quiesced during cpr-exec.  All such memory must be mmap'able in new QEMU.
> > > This is easy for named memory-backend objects, as long as they are mapped
> > > shared, because they are visible in the file system in both old and new QEMU.
> > > Anonymous memory must be allocated using memfd_create rather than MAP_ANON,
> > > so the memfd's can be sent to new QEMU.  Pages that were locked in memory
> > > for DMA in old QEMU remain locked in new QEMU, because the descriptor of
> > > the device that locked them remains open.
> > > 
> > > cpr-exec preserves descriptors across exec by clearing the CLOEXEC flag,
> > > and by sending the unique name and value of each descriptor to new QEMU
> > > via CPR state.
> > > 
> > > For device descriptors, new QEMU reuses the descriptor when creating the
> > > device, rather than opening it again.  The same holds for chardevs.  For
> > > memfd descriptors, new QEMU mmap's the preserved memfd when a ramblock
> > > is created.
> > > 
> > > CPR state cannot be sent over the normal migration channel, because devices
> > > and backends are created prior to reading the channel, so this mode sends
> > > CPR state over a second migration channel that is not visible to the user.
> > > New QEMU reads the second channel prior to creating devices or backends.
> > 
> > Oh, maybe this is the reason that cpr-transfer will need a separate uri..
> 
> Indeed.
> 
> - Steve
> 

-- 
Peter Xu


