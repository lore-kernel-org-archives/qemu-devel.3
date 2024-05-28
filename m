Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA33C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 16:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBzuZ-0000xA-Jm; Tue, 28 May 2024 12:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBzuV-0000wA-A1
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:42:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBzuS-0005CS-BB
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716914566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ma/y/sZlI5HgoPieZZpBQhNEsQVjramEgi0SD3E5Igc=;
 b=ZA6GBp/4wQNkI3aE8Jya8YWfkJVe+T2G+BN9k+tSxlyBMnHIWVzKbQyK6ZwklEBoaniRBh
 CjfAkOzqUvYJrezUKYTt7fO//Ojr/zY7QOVBwvMgPN2cxGbwcLO5RbHIt17SmhIB77a7UP
 ZHNen3/WSEJplfSdsNi6mVWiTyLvjKg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-8EjmoIcHMCC-LdwwyLszYA-1; Tue, 28 May 2024 12:42:44 -0400
X-MC-Unique: 8EjmoIcHMCC-LdwwyLszYA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6ab92673b06so2888756d6.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 09:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716914564; x=1717519364;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ma/y/sZlI5HgoPieZZpBQhNEsQVjramEgi0SD3E5Igc=;
 b=fStkEkdElu2hu32bQM8XmPEBn3JMK2BLcWqBiEAWYK/fIaL+WxbAXU+iMyK3uqYUY5
 a0x89Ct6tUgeq0nELHepbbZpe/HV0pfEATrBs43O1B7pV1uH7lffLO0uBl9JRLw9pf5u
 Sv3JDBmeY5HrnzAV+I0rKZq/UyVWibzO2+XoAYSQnox2/9uYolFgrlvIureWkFWrh8Sf
 2Bj7T0F5in9NhQBMYSvU4JWny/fDVAx7/B+9Z5GZo+1bZ4MWEwuDph050SfHO1OhvkF5
 GbIvxCU06Na+wVuSnXHWPcql2uGQbzMI2NmE0Pqlu1SaKtJGxF27TwF3wJ8BHEsLAGSM
 uZIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ1N9+27PktIiooe6cIR3D8BzdB+VyUB+CDYbSmA0RXZgZ/WEELUM4MTeXqcNY/bAbwXlT5ezGuimFOIpjUCbnHD8N734=
X-Gm-Message-State: AOJu0Yw7Rx720IZUAgYYCJpmjfj4PDJh7a1euF6XvL20dXidkQcmQz8N
 hScQFK01mERI0Wvi2B+5JuVjbEee2r0N4ZXqbYmbnWgoJEb/mrVdsYrfDQWYcVzYEYDuV/G8l/5
 zPZl9C0WBTTY3dS9drJ8Tlr7xB0AmFvqAOj4RwZe3dAoE+Blk+CiQ
X-Received: by 2002:a05:620a:728c:b0:793:1840:b832 with SMTP id
 af79cd13be357-794ab11267fmr1197763785a.6.1716914563557; 
 Tue, 28 May 2024 09:42:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRpwwZdEdnhWzFAWmA9Mg6qP+al/vJ/4mZgE9jB4spW/dzCaqFQXay+8cTZUbgrhHNHbr4yw==
X-Received: by 2002:a05:620a:728c:b0:793:1840:b832 with SMTP id
 af79cd13be357-794ab11267fmr1197760485a.6.1716914562633; 
 Tue, 28 May 2024 09:42:42 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abcc3070sm392106285a.51.2024.05.28.09.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 09:42:41 -0700 (PDT)
Date: Tue, 28 May 2024 12:42:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Fabiano Rosas <farosas@suse.de>,
	QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: [PATCH V1 00/26] Live update: cpr-exec
Message-ID: <ZlYJgHJwiVkGA7nG@x1n>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <cf8e13ae-cac6-4a8a-82a2-92b63a32b7b8@oracle.com>
 <87ed9wjey7.fsf@suse.de>
 <CADLect=ODs+-JrT4xOJazVveCtYPyDOCMsfK=2hcR-EJAdWDAw@mail.gmail.com>
 <be4cdd8d-4328-46d4-9b28-3a074d504180@oracle.com>
 <ZlTG18jRhp7oQTCQ@x1n>
 <102b10d6-034f-453a-8f06-97e8d5869364@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <102b10d6-034f-453a-8f06-97e8d5869364@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
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

On Tue, May 28, 2024 at 11:10:27AM -0400, Steven Sistare wrote:
> On 5/27/2024 1:45 PM, Peter Xu wrote:
> > On Tue, May 21, 2024 at 07:46:12AM -0400, Steven Sistare wrote:
> > > I understand, thanks.  If I can help with any of your todo list,
> > > just ask - steve
> > 
> > Thanks for offering the help, Steve.  Started looking at this today, then I
> > found that I miss something high-level.  Let me ask here, and let me
> > apologize already for starting to throw multiple questions..
> > 
> > IIUC the whole idea of this patchset is to allow efficient QEMU upgrade, in
> > this case not host kernel but QEMU-only, and/or upper.
> > 
> > Is there any justification on why the complexity is needed here?  It looks
> > to me this one is more involved than cpr-reboot, so I'm thinking how much
> > we can get from the complexity, and whether it's worthwhile.  1000+ LOC is
> > the min support, and if we even expect more to come, that's really
> > important, IMHO.
> > 
> > For example, what's the major motivation of this whole work?  Is that more
> > on performance, or is it more for supporting the special devices like VFIO
> > which we used to not support, or something else?  I can't find them in
> > whatever cover letter I can find, including this one.
> > 
> > Firstly, regarding performance, IMHO it'll be always nice to share even
> > some very fundamental downtime measurement comparisons using the new exec
> > mode v.s. the old migration ways to upgrade QEMU binary.  Do you perhaps
> > have some number on hand when you started working on this feature years
> > ago?  Or maybe some old links on the list would help too, as I didn't
> > follow this work since the start.
> > 
> > On VFIO, IIUC you started out this project without VFIO migration being
> > there.  Now we have VFIO migration so not sure how much it would work for
> > the upgrade use case. Even with current VFIO migration, we may not want to
> > migrate device states for a local upgrade I suppose, as that can be a lot
> > depending on the type of device assigned.  However it'll be nice to discuss
> > this too if this is the major purpose of the series.
> > 
> > I think one other challenge on QEMU upgrade with VFIO devices is that the
> > dest QEMU won't be able to open the VFIO device when the src QEMU is still
> > using it as the owner.  IIUC this is a similar condition where QEMU wants
> > to have proper ownership transfer of a shared block device, and AFAIR right
> > now we resolved that issue using some form of file lock on the image file.
> > In this case it won't easily apply to a VFIO dev fd, but maybe we still
> > have other approaches, not sure whether you investigated any.  E.g. could
> > the VFIO handle be passed over using unix scm rights?  I think this might
> > remove one dependency of using exec which can cause quite some difference
> > v.s. a generic migration (from which regard, cpr-reboot is still a pretty
> > generic migration).
> > 
> > You also mentioned vhost/tap, is that also a major goal of this series in
> > the follow up patchsets?  Is this a problem only because this solution will
> > do exec?  Can it work if either the exec()ed qemu or dst qemu create the
> > vhost/tap fds when boot?
> > 
> > Meanwhile, could you elaborate a bit on the implication on chardevs?  From
> > what I read in the doc update it looks like a major part of work in the
> > future, but I don't yet understand the issue..  Is it also relevant to the
> > exec() approach?
> > 
> > In all cases, some of such discussion would be really appreciated.  And if
> > you used to consider other approaches to solve this problem it'll be great
> > to mention how you chose this way.  Considering this work contains too many
> > things, it'll be nice if such discussion can start with the fundamentals,
> > e.g. on why exec() is a must.
> 
> The main goal of cpr-exec is providing a fast and reliable way to update
> qemu. cpr-reboot is not fast enough or general enough.  It requires the
> guest to support suspend and resume for all devices, and that takes seconds.
> If one actually reboots the host, that adds more seconds, depending on
> system services.  cpr-exec takes 0.1 secs, and works every time, unlike
> like migration which can fail to converge on a busy system.  Live migration
> also consumes more system and network resources.

Right, but note that when I was thinking of a comparison between cpr-exec
v.s. normal migration, I didn't mean a "normal live migration".  I think
it's more of the case whether exec() can be avoided.  I had a feeling that
this exec() will cause a major part of work elsewhere but maybe I am wrong
as I didn't see the whole branch.

AFAIU, "cpr-exec takes 0.1 secs" is a conditional result.  I think it at
least should be relevant to what devices are attached to the VM, right?

E.g., I observed at least two things that can drastically enlarge the
blackout window:

  1) vcpu save/load sometimes can take ridiculously long time, even if 99%
  of them are fine.  I still didn't spend time looking at this issue, but
  the outlier (of a single cpu save/load, while I don't remember whether
  it's save or load, both will contribute to the downtime anyway) can cause
  100+ms already for that single vcpu.  It'll already get more than 0.1sec.

  2) virtio device loads can be sometimes very slow due to virtqueue
  manipulations.  We used to have developers working in this area,
  e.g. this thread:

  https://lore.kernel.org/r/20230317081904.24389-1-xuchuangxclwt@bytedance.com

  I don't yet have time to further look.  Since you mentioned vhost I was
  wondering whether you hit similar issues, and if not why yet.  IIRC it
  was only during VM loads so dest QEMU only.  Again that'll contribute to
  the overall downtime too and that can also be 100ms or more, but that may
  depend on VM memory topology and device setup.

When we compare the solutions, we definitely don't need to make it "live":
it could be a migration starting with VM paused already, skipping all dirty
tracking just like cpr-reboot, but in this case it's can be a relatively
normal migration, so that we still invoke the new qemu binary and load that
on the fly, perhaps taking the fds via scm rights.  Then compare these two
solutions with/without exec().  Note that I'm not requesting for such data;
it's not fair if that takes a lot of work already first to implement such
idea, but what I wanted to say is that it might be interesting to first
analyze what caused the downtime, and whether that can be logically
resolved too without exec(); hence the below question on "why exec()" in
the first place, as I still feel like that's somewhere we should avoid
unless extremely necessary..

> cpr-exec seamlessly preserves client connections by preserving chardevs,
> and overall provides a much nicer user experience.

I see.  However this is a common issue to migration, am I right?  I mean,
if we have some chardevs on src host, then we migrate the VM from src to
dst, then a reconnect will be needed anyway.  It looks to me that as long
as the old live migration is supported, there's already a solution and apps
are ok with reconnecting to the new ports.  From that POV, I am curious
whether this can be seen as a (kind of separate) work besides the cpr-exec,
however perhaps only a new feature only be valid for cpr-exec?

Meanwhile, is there some elaborations on what would be the major change of
nicer user experience with the new solution?

> 
> chardev's are preserved by keeping their fd open across the exec, and
> remembering the value of the fd in precreate vmstate so that new qemu
> can associate the fd with the chardev rather than opening a new one.
> 
> The approach of preserving open file descriptors is very general and applicable
> to all kinds of devices, regardless of whether they support live migration
> in hardware.  Device fd's are preserved using the same mechanism as for
> chardevs.
> 
> Devices that support live migration in hardware do not like to live migrate
> in place to the same node.  It is not what they are designed for, and some
> implementations will flat out fail because the source and target interfaces
> are the same.
> 
> For vhost/tap, sometimes the management layer opens the dev and passes an
> fd to qemu, and sometimes qemu opens the dev.  The upcoming vhost/tap support
> allows both.  For the case where qemu opens the dev, the fd is preserved
> using the same mechanism as for chardevs.
> 
> The fundamental requirements of this work are:
>   - precreate vmstate
>   - preserve open file descriptors
> 
> Direct exec from old to new qemu is not a hard requirement.

Great to know..

> However, it is simple, with few complications, and works with Oracle's
> cloud containers, so it is the method I am most interested in finishing
> first.
> 
> I believe everything could also be made to work by using SCM_RIGHTS to
> send fd's to a new qemu process that is started by some external means.
> It would be requested with MIG_MODE_CPR_SCM (or some better name), and
> would co-exist with MIG_MODE_CPR_EXEC.

That sounds like a better thing to me, so that live migration framework is
not changed as drastic.  I just still feel like exec() is too powerful, and
evil can reside, just like black magic in the fairy tales; magicians try to
avoid using it unless extremely necessary.

I think the next step for my review is to understand what is implied with
exec().  I'll wait for you to push your tree somewhere so maybe I can read
that and understand better.  A base commit would work too if you can share
so I can apply the series, as it doesn't seem to apply to master now.

Thanks,

-- 
Peter Xu


