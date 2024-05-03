Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F14DC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 22:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s31DF-0000Ii-DK; Fri, 03 May 2024 18:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s31DC-0000I8-Uk
 for qemu-devel@nongnu.org; Fri, 03 May 2024 18:17:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s31DA-0007TY-W9
 for qemu-devel@nongnu.org; Fri, 03 May 2024 18:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714774619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=di9VvHdEplo4sNxBWVyhq/7CPmtSjfq3bdcNcj0/xZE=;
 b=NVCUeOQm2+RBfFK0neFfLxQSbd4z70R3sxXXRuBJZ41jcZ5OunL+DQEcUpCpvxr+gfog4H
 6Zuwm7dCG3k0caXABZFBYNKuxpLcloGvP+k18EVWS+fuxUkTvj0OTAajxVE3NmQ23nE7mH
 v9vNncKVmcWM7ozgbVl/nO1swehmQ6Y=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-BQV4pTTdPGKD6eDEP8gBWw-1; Fri, 03 May 2024 18:16:56 -0400
X-MC-Unique: BQV4pTTdPGKD6eDEP8gBWw-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2b2c8a007f2so37913a91.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 15:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714774615; x=1715379415;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=di9VvHdEplo4sNxBWVyhq/7CPmtSjfq3bdcNcj0/xZE=;
 b=lYH6+9ZYzlSrizkOCruevoIVSpBm1G3yO5PPARMluriiJXJaFYAnjNQf8OWNVhertq
 prG2kr3ROKrQiuXJ0X51SxE65vbs1vG0RIBwO6EMkEi+FcBuws/DuWn02AayT8dvSL1T
 1OGi/EzwGw5Qv53fZac2wI6w+DXWfEf/Dpjnh5yu6bZ+rURQLx3bRteU3BFwXBTP97Cd
 FhOaiuQN6vz3q7bnNeCiK8XNi3nkYv45K5RXu/PgYTVW1hWPUXrfC8kGSm18Wq/pVtsz
 geMqDteEsxOU+FtnrxotU1nyBNh0xg2fGnNwSYYbEhW0n7zGL47ahCHdLWrUobN21X1Z
 FQ1A==
X-Gm-Message-State: AOJu0Yz2P8mGxT6u4P50c9YJg+WvIWYKRlT9rcf2xH+pK0zr6Bh5fFj+
 mfcF0PAOWiODixpdDHE5onvDLZUpY30QqOAotw0V5MEhN8Tn4IT4msamf9R56cbL9k7ieFXWIbU
 yoHjbzVNKsv4f3IwtSuObjygxejv21C7hf+ARQRVCxQhuKFPKjlEm
X-Received: by 2002:a05:6a20:5654:b0:1ae:3504:c5e with SMTP id
 is20-20020a056a20565400b001ae35040c5emr3615486pzc.4.1714774614703; 
 Fri, 03 May 2024 15:16:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAsUv5nC96DpliB1Q++1T8hnOp5fPeHTsq4tWxlwrRT15qCd381fTrnC/at9TL42sHJ/5lUg==
X-Received: by 2002:a05:6a20:5654:b0:1ae:3504:c5e with SMTP id
 is20-20020a056a20565400b001ae35040c5emr3615443pzc.4.1714774613876; 
 Fri, 03 May 2024 15:16:53 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 w11-20020aa7858b000000b006efd89cea71sm3554423pfn.84.2024.05.03.15.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 15:16:53 -0700 (PDT)
Date: Fri, 3 May 2024 18:16:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH 7/9] monitor: fdset: Match against O_DIRECT
Message-ID: <ZjViUjq2mV-XmH4C@x1n>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-8-farosas@suse.de> <ZjUyta-q8GuTDDjJ@x1n>
 <87seyymw4d.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87seyymw4d.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.483,
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

On Fri, May 03, 2024 at 06:19:30PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Fri, Apr 26, 2024 at 11:20:40AM -0300, Fabiano Rosas wrote:
> >> We're about to enable the use of O_DIRECT in the migration code and
> >> due to the alignment restrictions imposed by filesystems we need to
> >> make sure the flag is only used when doing aligned IO.
> >> 
> >> The migration will do parallel IO to different regions of a file, so
> >> we need to use more than one file descriptor. Those cannot be obtained
> >> by duplicating (dup()) since duplicated file descriptors share the
> >> file status flags, including O_DIRECT. If one migration channel does
> >> unaligned IO while another sets O_DIRECT to do aligned IO, the
> >> filesystem would fail the unaligned operation.
> >> 
> >> The add-fd QMP command along with the fdset code are specifically
> >> designed to allow the user to pass a set of file descriptors with
> >> different access flags into QEMU to be later fetched by code that
> >> needs to alternate between those flags when doing IO.
> >> 
> >> Extend the fdset matching to behave the same with the O_DIRECT flag.
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >>  monitor/fds.c | 7 ++++++-
> >>  1 file changed, 6 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/monitor/fds.c b/monitor/fds.c
> >> index 4ec3b7eea9..62e324fcec 100644
> >> --- a/monitor/fds.c
> >> +++ b/monitor/fds.c
> >> @@ -420,6 +420,11 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags)
> >>          int fd = -1;
> >>          int dup_fd;
> >>          int mon_fd_flags;
> >> +        int mask = O_ACCMODE;
> >> +
> >> +#ifdef O_DIRECT
> >> +        mask |= O_DIRECT;
> >> +#endif
> >>  
> >>          if (mon_fdset->id != fdset_id) {
> >>              continue;
> >> @@ -431,7 +436,7 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags)
> >>                  return -1;
> >>              }
> >>  
> >> -            if ((flags & O_ACCMODE) == (mon_fd_flags & O_ACCMODE)) {
> >> +            if ((flags & mask) == (mon_fd_flags & mask)) {
> >>                  fd = mon_fdset_fd->fd;
> >>                  break;
> >>              }
> >
> > I think I see what you wanted to do, picking out the right fd out of two
> > when qemu_open_old(), which makes sense.
> >
> > However what happens if the mgmt app only passes in 1 fd to the fdset?  The
> > issue is we have a "fallback dup()" plan right after this chunk of code:
> >
> 
> I'm validating the fdset at file_parse_fdset() beforehand. If there's
> anything else than 2 fds then we'll error out:
> 
>     if (nfds != 2) {
>         error_setg(errp, "Outgoing migration needs two fds in the fdset, "
>                    "got %d", nfds);
>         qmp_remove_fd(*id, false, -1, NULL);
>         *id = -1;
>         return false;
>     }
> 
> >         dup_fd = qemu_dup_flags(fd, flags);
> >         if (dup_fd == -1) {
> >             return -1;
> >         }
> >
> >         mon_fdset_fd_dup = g_malloc0(sizeof(*mon_fdset_fd_dup));
> >         mon_fdset_fd_dup->fd = dup_fd;
> >         QLIST_INSERT_HEAD(&mon_fdset->dup_fds, mon_fdset_fd_dup, next);
> >
> > I think it means even if the mgmt app only passes in 1 fd (rather than 2,
> > one with O_DIRECT, one without), QEMU can always successfully call
> > qemu_open_old() twice for each case, even though silently the two FDs will
> > actually impact on each other.  This doesn't look ideal if it's true.
> >
> > But I also must confess I don't really understand this code at all: we
> > dup(), then we try F_SETFL on all the possible flags got passed in.
> > However AFAICT due to the fact that dup()ed FDs will share "struct file" it
> > means mostly all flags will be shared, except close-on-exec.  I don't ever
> > see anything protecting that F_SETFL to only touch close-on-exec, I think
> > it means it'll silently change file status flags for the other fd which we
> > dup()ed from.  Does it mean that we have issue already with such dup() usage?
> 
> I think you're right, but I also think there's a requirement even from
> this code that the fds in the fdset cannot be dup()ed. I don't see it
> enforced anywhere, but maybe that's a consequence of the larger use-case
> for which this feature was introduced.

I think that's the thing we need to figure out for add-fd usages.  The bad
thing is there're too many qemu_open_internal() users... so we can't easily
tell what we're looking for. May need some time reading the code or the
history.. pretty sad.  I hope someone can chim in.

> 
> For our scenario, the open() man page says one can use kcmp() to compare
> the fds and determine if they are a result of dup(). Maybe we should do
> that extra check? We're defining a pretty rigid interface between QEMU
> and the management layer, so not likely to break once it's written. I'm
> also not sure how bad would it be to call syscall() directly from QEMU
> (kcmp has no libc wrapper).

That should be all fine, see:

$ git grep " syscall(" | wc -l
28

And if we want we can also do fcntl(F_GETFL) on both fds later, making sure
they have proper flags (one must have O_DIRECT, one must not).

-- 
Peter Xu


