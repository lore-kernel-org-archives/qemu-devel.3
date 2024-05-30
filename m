Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF3EC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 19:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sClN5-00075w-IF; Thu, 30 May 2024 15:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sClN3-00075e-Hj
 for qemu-devel@nongnu.org; Thu, 30 May 2024 15:23:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sClMx-000298-C5
 for qemu-devel@nongnu.org; Thu, 30 May 2024 15:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717097001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DzIvQrz6ghTjS+lx3+Dn1MsJHxDgTbao57AwFB7olSk=;
 b=NZ7GUh8/+fhoWe0+kTkwPeFvxOAN5T8c4Jy+UK/CVcb7cgjJnuwBsSMGLDnanHmg/ENtcR
 CTJN7MC5J6KSXGXAnYNcbtDmuVhmMk1iYU5RzWWqPSfLYe8fKTMtX3mtn0b8I3hFjVZvB2
 F0nSDQOuehtHOXH9SM+dhGKIYEx9FJ0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-g9aqbRQHO9CuV8Bjw2lOOw-1; Thu, 30 May 2024 15:23:19 -0400
X-MC-Unique: g9aqbRQHO9CuV8Bjw2lOOw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6ad5ebfaa68so4996386d6.0
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 12:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717096998; x=1717701798;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DzIvQrz6ghTjS+lx3+Dn1MsJHxDgTbao57AwFB7olSk=;
 b=hj/6CPQfC6umKR+YDMbf/zH7uHILjDiyR+Q5JdO9u+g3Jwx51zA5XvhAfwNo3Mudiu
 4y5dE+03QcY6wxTetK392llzXI0dyDRmpQu0PBqzgpaA4yGzN53EkiSG0+Pylq1lEYpS
 scAovyPvq5GApaNPRx/Vb1KFoWbtqJzUdo3nB+YQNEPSTlrgjvdThnHfQEYzheWHl7Ni
 YxPZXUK++4BN1mJSNXG0H2LkbOXewfnh1MW0KAz9QS4hh2BBhOh54krjX3tC5ZIWf88I
 B9mF+mynumn5jz9XqoOQh40TMzcYQ7qbiF1JYQ5CCGqMxCcEgyrgZnywhrPLvCNrZnDJ
 chyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNhYsiIJPpxZF/yWPHok7CeAXlNVmHv3xFY3FzHqpfDYjKRmESbtxS14scv0ayFfVvm8xJLP8tgCIUjWFKTVBJeJpNF28=
X-Gm-Message-State: AOJu0Yzy/uCzOu/i+JywvibaUWF6k33KdRBsGyOiV33osgMMkQJJ2NYQ
 eVSqI2ABQ9m0V0Jbgw5ANSsBXD8EK6IC5A1oVoB1cRwjeYOJttr0HUsZF8k2TTE/mh5qf9n2CDu
 ef4uJS9ptI/fa8w3ozBWuWcnLEqv9tjys0hdUk3Szo2OFNKJ5Q9+QfhNROJDE
X-Received: by 2002:a05:6214:21c1:b0:6ab:8df8:b90e with SMTP id
 6a1803df08f44-6ae8f352fbbmr456996d6.0.1717096997067; 
 Thu, 30 May 2024 12:23:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGff1ecuwacZR1zKkSS7d8wgIO4w+xnQ43tRjIaaGGauziZsMLNcB9Hmfw7Fdv5cysdYKaNyA==
X-Received: by 2002:a05:6214:21c1:b0:6ab:8df8:b90e with SMTP id
 6a1803df08f44-6ae8f352fbbmr456526d6.0.1717096996024; 
 Thu, 30 May 2024 12:23:16 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ae4a750501sm1084156d6.64.2024.05.30.12.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 12:23:15 -0700 (PDT)
Date: Thu, 30 May 2024 15:23:13 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Fabiano Rosas <farosas@suse.de>,
	QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: [PATCH V1 00/26] Live update: cpr-exec
Message-ID: <ZljSIRdIGTiDRWwH@x1n>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <cf8e13ae-cac6-4a8a-82a2-92b63a32b7b8@oracle.com>
 <87ed9wjey7.fsf@suse.de>
 <CADLect=ODs+-JrT4xOJazVveCtYPyDOCMsfK=2hcR-EJAdWDAw@mail.gmail.com>
 <be4cdd8d-4328-46d4-9b28-3a074d504180@oracle.com>
 <ZlTG18jRhp7oQTCQ@x1n>
 <102b10d6-034f-453a-8f06-97e8d5869364@oracle.com>
 <ZlYJgHJwiVkGA7nG@x1n>
 <2fffde4a-de58-4b41-8fcc-c082693d5387@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2fffde4a-de58-4b41-8fcc-c082693d5387@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, May 30, 2024 at 01:17:05PM -0400, Steven Sistare wrote:
> On 5/28/2024 12:42 PM, Peter Xu wrote:
> > On Tue, May 28, 2024 at 11:10:27AM -0400, Steven Sistare wrote:
> > > On 5/27/2024 1:45 PM, Peter Xu wrote:
> > > > On Tue, May 21, 2024 at 07:46:12AM -0400, Steven Sistare wrote:
> > > > > I understand, thanks.  If I can help with any of your todo list,
> > > > > just ask - steve
> > > > 
> > > > Thanks for offering the help, Steve.  Started looking at this today, then I
> > > > found that I miss something high-level.  Let me ask here, and let me
> > > > apologize already for starting to throw multiple questions..
> > > > 
> > > > IIUC the whole idea of this patchset is to allow efficient QEMU upgrade, in
> > > > this case not host kernel but QEMU-only, and/or upper.
> > > > 
> > > > Is there any justification on why the complexity is needed here?  It looks
> > > > to me this one is more involved than cpr-reboot, so I'm thinking how much
> > > > we can get from the complexity, and whether it's worthwhile.  1000+ LOC is
> > > > the min support, and if we even expect more to come, that's really
> > > > important, IMHO.
> > > > 
> > > > For example, what's the major motivation of this whole work?  Is that more
> > > > on performance, or is it more for supporting the special devices like VFIO
> > > > which we used to not support, or something else?  I can't find them in
> > > > whatever cover letter I can find, including this one.
> > > > 
> > > > Firstly, regarding performance, IMHO it'll be always nice to share even
> > > > some very fundamental downtime measurement comparisons using the new exec
> > > > mode v.s. the old migration ways to upgrade QEMU binary.  Do you perhaps
> > > > have some number on hand when you started working on this feature years
> > > > ago?  Or maybe some old links on the list would help too, as I didn't
> > > > follow this work since the start.
> > > > 
> > > > On VFIO, IIUC you started out this project without VFIO migration being
> > > > there.  Now we have VFIO migration so not sure how much it would work for
> > > > the upgrade use case. Even with current VFIO migration, we may not want to
> > > > migrate device states for a local upgrade I suppose, as that can be a lot
> > > > depending on the type of device assigned.  However it'll be nice to discuss
> > > > this too if this is the major purpose of the series.
> > > > 
> > > > I think one other challenge on QEMU upgrade with VFIO devices is that the
> > > > dest QEMU won't be able to open the VFIO device when the src QEMU is still
> > > > using it as the owner.  IIUC this is a similar condition where QEMU wants
> > > > to have proper ownership transfer of a shared block device, and AFAIR right
> > > > now we resolved that issue using some form of file lock on the image file.
> > > > In this case it won't easily apply to a VFIO dev fd, but maybe we still
> > > > have other approaches, not sure whether you investigated any.  E.g. could
> > > > the VFIO handle be passed over using unix scm rights?  I think this might
> > > > remove one dependency of using exec which can cause quite some difference
> > > > v.s. a generic migration (from which regard, cpr-reboot is still a pretty
> > > > generic migration).
> > > > 
> > > > You also mentioned vhost/tap, is that also a major goal of this series in
> > > > the follow up patchsets?  Is this a problem only because this solution will
> > > > do exec?  Can it work if either the exec()ed qemu or dst qemu create the
> > > > vhost/tap fds when boot?
> > > > 
> > > > Meanwhile, could you elaborate a bit on the implication on chardevs?  From
> > > > what I read in the doc update it looks like a major part of work in the
> > > > future, but I don't yet understand the issue..  Is it also relevant to the
> > > > exec() approach?
> > > > 
> > > > In all cases, some of such discussion would be really appreciated.  And if
> > > > you used to consider other approaches to solve this problem it'll be great
> > > > to mention how you chose this way.  Considering this work contains too many
> > > > things, it'll be nice if such discussion can start with the fundamentals,
> > > > e.g. on why exec() is a must.
> > > 
> > > The main goal of cpr-exec is providing a fast and reliable way to update
> > > qemu. cpr-reboot is not fast enough or general enough.  It requires the
> > > guest to support suspend and resume for all devices, and that takes seconds.
> > > If one actually reboots the host, that adds more seconds, depending on
> > > system services.  cpr-exec takes 0.1 secs, and works every time, unlike
> > > like migration which can fail to converge on a busy system.  Live migration
> > > also consumes more system and network resources.
> > 
> > Right, but note that when I was thinking of a comparison between cpr-exec
> > v.s. normal migration, I didn't mean a "normal live migration".  I think
> > it's more of the case whether exec() can be avoided.  I had a feeling that
> > this exec() will cause a major part of work elsewhere but maybe I am wrong
> > as I didn't see the whole branch.
> 
> The only parts of this work that are specific to exec are these patches
> and the qemu_clear_cloexec() calls in cpr.c.
>   vl: helper to request re-exec
>   migration: precreate vmstate for exec
> 
> The rest would be the same if some other mechanism were used to start
> new qemu.   Additional code would be needed for the new mechanism, such
> as SCM_RIGHTS sends.

Please see my other reply; I feel like there's chance to avoid more, but I
don't think we finished discussion on the e.g. vga ram implications, or the
vfio-pci fd reuse. So we can keep the discussion there.

> 
> > AFAIU, "cpr-exec takes 0.1 secs" is a conditional result.  I think it at
> > least should be relevant to what devices are attached to the VM, right?
> > 
> > E.g., I observed at least two things that can drastically enlarge the
> > blackout window:
> > 
> >    1) vcpu save/load sometimes can take ridiculously long time, even if 99%
> >    of them are fine.  I still didn't spend time looking at this issue, but
> >    the outlier (of a single cpu save/load, while I don't remember whether
> >    it's save or load, both will contribute to the downtime anyway) can cause
> >    100+ms already for that single vcpu.  It'll already get more than 0.1sec.
> > 
> >    2) virtio device loads can be sometimes very slow due to virtqueue
> >    manipulations.  We used to have developers working in this area,
> >    e.g. this thread:
> > 
> >    https://lore.kernel.org/r/20230317081904.24389-1-xuchuangxclwt@bytedance.com
> > 
> >    I don't yet have time to further look.  Since you mentioned vhost I was
> >    wondering whether you hit similar issues, and if not why yet.  IIRC it
> >    was only during VM loads so dest QEMU only.  Again that'll contribute to
> >    the overall downtime too and that can also be 100ms or more, but that may
> >    depend on VM memory topology and device setup.
> 
> 100 ms is not a promise, it is an order-of-magnitude characterization. A typical
> result.
> 
> > When we compare the solutions, we definitely don't need to make it "live":
> 
> Agreed.  The key metric is guest blackout time.  In fact, the 100 ms I quote
> is blackout time, not elapsed time, though the latter is not much longer.

Here I think what would be interesting is how exec() could help reduce the
blackout time comparing to invoking another qemu.

The major device states save/load look like to be a shared contribution.
Then ram sharing is also a shared attribute that can be leveraged without
exec() approach.

FDs passover is indeed another good point on reducing blackout window
(including your vfio vaddr update work), but that also doesn't seem like
relevant to exec().

> 
> > it could be a migration starting with VM paused already, skipping all dirty
> > tracking just like cpr-reboot, but in this case it's can be a relatively
> > normal migration, so that we still invoke the new qemu binary and load that
> > on the fly, perhaps taking the fds via scm rights.  Then compare these two
> > solutions with/without exec().  Note that I'm not requesting for such data;
> > it's not fair if that takes a lot of work already first to implement such
> > idea, but what I wanted to say is that it might be interesting to first
> > analyze what caused the downtime, and whether that can be logically
> > resolved too without exec(); hence the below question on "why exec()" in
> > the first place, as I still feel like that's somewhere we should avoid
> > unless extremely necessary..
> 
> Exec is not a key requirement, but it works well.  Please give it fair
> consideration.

Right, I think I'm still trying to understand what it can bring.  Even
though I must confess personally I definitely prefer anything but it.. So
maybe I'll be convinced at some point, so far just not fully yet.

> 
> > > cpr-exec seamlessly preserves client connections by preserving chardevs,
> > > and overall provides a much nicer user experience.
> > 
> > I see.  However this is a common issue to migration, am I right?  I mean,
> > if we have some chardevs on src host, then we migrate the VM from src to
> > dst, then a reconnect will be needed anyway.  It looks to me that as long
> > as the old live migration is supported, there's already a solution and apps
> > are ok with reconnecting to the new ports.
> 
> Apps may be OK with it, but I offer a better experience.
> To be clear, chardev preservation is a nice feature that is easy to implement
> with the cpr-exec framework, but is not the primary motivation for my
> work.

E.g., libvirt used to have a connection to a chardev backend, with legacy
code it will need a reconnect?  Now libvirt can avoid that reconnect
operation.  Is that the case?

The issue is I still don't see why it's a major benefit if libvirt already
supports the reconnections; it can be another story if it didn't.  I don't
think chardev usages should be sensitive to performance / reconnects
either?

Meanwhile, do we need to modify all chardev call sites to support them one
by one?  please bare with me if there can be silly questions, I'm not
familiar with that area.

> 
> > From that POV, I am curious
> > whether this can be seen as a (kind of separate) work besides the cpr-exec,
> > however perhaps only a new feature only be valid for cpr-exec?
> 
> You need much of the cpr-exec (or cpr-scm) framework to support it:
> a mechanism to preserve the open descriptor, and precreate vmstate to
> identify the descriptor for new qemu.

Let's see how you think about it when you read the vfio commit on the
pre-opened device.  I feel like it's a pretty good idea to provide such a
generic interface so that fds are more flexibly managed in QEMU.

I'd be more than glad if libvirt can manage all the fds, so that the
pre-create approach isn't required, maybe?  That's a major tricky part that
I feel nervous in this series besides exec() itself.  I'm not sure whether
that can also extend to chardevs too, but there'll be similar question on
whether it'll be worthwhile to avoid the reconnection if major effort is
needed.

> 
> > Meanwhile, is there some elaborations on what would be the major change of
> > nicer user experience with the new solution?
> > 
> > > 
> > > chardev's are preserved by keeping their fd open across the exec, and
> > > remembering the value of the fd in precreate vmstate so that new qemu
> > > can associate the fd with the chardev rather than opening a new one.
> > > 
> > > The approach of preserving open file descriptors is very general and applicable
> > > to all kinds of devices, regardless of whether they support live migration
> > > in hardware.  Device fd's are preserved using the same mechanism as for
> > > chardevs.
> > > 
> > > Devices that support live migration in hardware do not like to live migrate
> > > in place to the same node.  It is not what they are designed for, and some
> > > implementations will flat out fail because the source and target interfaces
> > > are the same.
> > > 
> > > For vhost/tap, sometimes the management layer opens the dev and passes an
> > > fd to qemu, and sometimes qemu opens the dev.  The upcoming vhost/tap support
> > > allows both.  For the case where qemu opens the dev, the fd is preserved
> > > using the same mechanism as for chardevs.
> > > 
> > > The fundamental requirements of this work are:
> > >    - precreate vmstate
> > >    - preserve open file descriptors
> > > 
> > > Direct exec from old to new qemu is not a hard requirement.
> > 
> > Great to know..
> > 
> > > However, it is simple, with few complications, and works with Oracle's
> > > cloud containers, so it is the method I am most interested in finishing
> > > first.
> > > 
> > > I believe everything could also be made to work by using SCM_RIGHTS to
> > > send fd's to a new qemu process that is started by some external means.
> > > It would be requested with MIG_MODE_CPR_SCM (or some better name), and
> > > would co-exist with MIG_MODE_CPR_EXEC.
> > 
> > That sounds like a better thing to me, so that live migration framework is
> > not changed as drastic.  I just still feel like exec() is too powerful, and
> > evil can reside, just like black magic in the fairy tales; magicians try to
> > avoid using it unless extremely necessary.
> 
> Fork is scarier; it preserves almost everything, with a few exceptions.
> Exec destroys almost everything, with a few exceptions.

Hmm this is a very interesting angle to see the syscalls, thanks.  And
OTOH.. I'm definitely not suggesting fork()..

> Please give it a chance.  The theorized cpr-scm would no doubt be useful
> for some cloud vendors, but so is cpr-exec.  cpr-scm is intellectually
> interesting to me, and I might work on it at some point, but cpr-exec is
> what I need for our cloud.

I kind of understand, and as an individual that I worked with you on
multiple series I have my own personal feelings. You're definitely one of
the good developers I've been working with, if not fall into great
category.  It's all about the hat, not the red one..

CPR was floating around for too long, and part of that was because there
weren't enough people reviewing, which I'd blame QEMU if that's a "person"
alone, and a person can "die" if he/she does too many wrong things.

However from a company's pov, that's the trade-off for upstreaming-first
approach, and company needs to make a decision irrelevant of community
behavior, I guess. While when a company decided to go further without
upstreaming there's the risk of "tech debt".

Please keep convicing that cpr-exec is the best.  I don't think we have a
conclusion yet.

> 
> > I think the next step for my review is to understand what is implied with
> > exec().  I'll wait for you to push your tree somewhere so maybe I can read
> > that and understand better.  A base commit would work too if you can share
> > so I can apply the series, as it doesn't seem to apply to master now.
> 
> Try these tracepoints:
> -trace enable=qemu_anon_memfd_alloc
> -trace enable=ram_block_create
> -trace enable='*factory*'
> -trace enable='vmstate_*register'
> 
> I sent this to Peter already, but for others benefit, this series applies to
> commit 5da72194df36535d77.

Yes, thanks.

-- 
Peter Xu


