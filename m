Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B797AC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 21:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s30tS-0003Ht-Jw; Fri, 03 May 2024 17:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s30tR-0003HX-Lm
 for qemu-devel@nongnu.org; Fri, 03 May 2024 17:56:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s30tO-0003uD-OH
 for qemu-devel@nongnu.org; Fri, 03 May 2024 17:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714773393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EZT8c9tbv0nRKXRHM0Dpq+fMayhzDz9lUewdV0yp42k=;
 b=hA652cu1PE78iITrPb68l1aQ51Fgy9TvCq1Q3kvLLjko4B/bAt/a55TUnlyrndFIfpO12x
 1evWqubu19xWGqOwkdDoUwnX66esa8Z5O7Nuc2KZHGQCcMGPT4ul4eaw/UOOmfFZ26ZvGg
 QsE4xY1QNDesPEy1xD17jKa/9IpIZ3o=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-9lcPGMuUNqukelyHjwAVMQ-1; Fri, 03 May 2024 17:56:32 -0400
X-MC-Unique: 9lcPGMuUNqukelyHjwAVMQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2b1373224acso38051a91.2
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 14:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714773391; x=1715378191;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EZT8c9tbv0nRKXRHM0Dpq+fMayhzDz9lUewdV0yp42k=;
 b=ZgXKpRU7o4H7IME6lDMhSLt5qlAUQ5Uwp442gH404+rl0WSyg1MrLQdZULy0OHxLem
 32RY8UVDWgGMLXkEI57rVp9sYuoMIc7QTduxNtbNDuAR+S0GPVeBv4YOGzMOXYeDO3hu
 /EtNkdHAQdojU+wREry7fokeho2HmM5hR2TQP+N6RD3a+94WxDX7oNKLKCje49FeOsMj
 qLaZfyhFZFQe8JDzftalIs+2eQKLQon1GeG/7Ndq29cLH6RtPlWJfRY/r15soXSulZdn
 W4XmjGk261aXbdbd6WSZ7cLAKz0tXIry+pV88lShAC4dz8OvC5h2YGeLVWndQ5DJNkW1
 GBNQ==
X-Gm-Message-State: AOJu0YwF/7By4X+timwdqNT4VufkrwNzzMwDjmUQleKb8O18Vonw7KLu
 Z1e8TvH8UBw81mx4A2lIrdpIf2H3QktswzAmKhpo/XwRIly2Jrq2p57qn9IVw5URDqvB11TUX55
 RIUKxmBGFnOaVJAbK4TqYv0bQkpj5brbGCw9dSPsOL/vUizU6qSk4
X-Received: by 2002:a05:6a00:2f55:b0:6f4:10ab:4c4f with SMTP id
 ff21-20020a056a002f5500b006f410ab4c4fmr3941048pfb.2.1714773390804; 
 Fri, 03 May 2024 14:56:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHj7D2TDuyL0dEo5EQbkRGShhT2jG2ModV/ZLJLyRpTH+M4DA3Hz5mQm4FF5qoAh4lJHv4xtA==
X-Received: by 2002:a05:6a00:2f55:b0:6f4:10ab:4c4f with SMTP id
 ff21-20020a056a002f5500b006f410ab4c4fmr3941025pfb.2.1714773390182; 
 Fri, 03 May 2024 14:56:30 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 s3-20020a056a0008c300b006ecd942161fsm3533851pfu.190.2024.05.03.14.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 14:56:29 -0700 (PDT)
Date: Fri, 3 May 2024 17:56:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH 2/9] migration: Fix file migration with fdset
Message-ID: <ZjVdipRzAJMOAtfI@x1n>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-3-farosas@suse.de> <ZjUPl6XwB3Zt3cKR@x1n>
 <87a5l6oejr.fsf@suse.de> <ZjVRS6yT6n7_wb0V@x1n>
 <87plu2mvl1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87plu2mvl1.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Fri, May 03, 2024 at 06:31:06PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Fri, May 03, 2024 at 04:56:08PM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > On Fri, Apr 26, 2024 at 11:20:35AM -0300, Fabiano Rosas wrote:
> >> >> When the migration using the "file:" URI was implemented, I don't
> >> >> think any of us noticed that if you pass in a file name with the
> >> >> format "/dev/fdset/N", this allows a file descriptor to be passed in
> >> >> to QEMU and that behaves just like the "fd:" URI. So the "file:"
> >> >> support has been added without regard for the fdset part and we got
> >> >> some things wrong.
> >> >> 
> >> >> The first issue is that we should not truncate the migration file if
> >> >> we're allowing an fd + offset. We need to leave the file contents
> >> >> untouched.
> >> >
> >> > I'm wondering whether we can use fallocate() instead on the ranges so that
> >> > we always don't open() with O_TRUNC.  Before that..  could you remind me
> >> > why do we need to truncate in the first place?  I definitely missed
> >> > something else here too.
> >> 
> >> AFAIK, just to avoid any issues if the file is pre-existing. I don't see
> >> the difference between O_TRUNC and fallocate in this case.
> >
> > Then, shall we avoid truncations at all, leaving all the feasibility to
> > user (also errors prone to make)?
> >
> 
> Is this a big deal? I'd rather close that possible gap and avoid the bug
> reports.

No possible of such report if the user uses Libvirt or even more virt
stacks, am I right?  While this is only for whoever uses QEMU directly, and
only if the one forgot to remove a leftover image file?

I'd not worry about those people who use QEMU directly - they aren't the
people we need to care too much about, imho (and I'm definitely one of
them..).  The problem is I feel it an overkill introducing a migration
global var just for this purpose.

No strong opinions, if you feel strongly like so I'm ok with it.  But if
one day if we want to remove FileOutgoingArgs I'll also leave that to you
as a trade-off. :-)

> 
> >> 
> >> >
> >> >> 
> >> >> The second issue is that there's an expectation that QEMU removes the
> >> >> fd after the migration has finished. That's what the "fd:" code
> >> >> does. Otherwise a second migration on the same VM could attempt to
> >> >> provide an fdset with the same name and QEMU would reject it.
> >> >
> >> > Let me check what we do when with "fd:" and when migration completes or
> >> > cancels.
> >> >
> >> > IIUC it's qio_channel_file_close() that does the final cleanup work on
> >> > e.g. to_dst_file, right?  Then there's qemu_close(), and it has:
> >> >
> >> >     /* Close fd that was dup'd from an fdset */
> >> >     fdset_id = monitor_fdset_dup_fd_find(fd);
> >> >     if (fdset_id != -1) {
> >> >         int ret;
> >> >
> >> >         ret = close(fd);
> >> >         if (ret == 0) {
> >> >             monitor_fdset_dup_fd_remove(fd);
> >> >         }
> >> >
> >> >         return ret;
> >> >     }
> >> >
> >> > Shouldn't this done the work already?
> >> 
> >> That removes the mon_fdset_fd_dup->fd, we want to remove the
> >> mon_fdset_fd->fd.
> >
> > What I read so far is when we are removing the dup-fds, we'll do one more
> > thing:
> >
> > monitor_fdset_dup_fd_find_remove():
> >                     if (QLIST_EMPTY(&mon_fdset->dup_fds)) {
> >                         monitor_fdset_cleanup(mon_fdset);
> >                     }
> >
> > It means if we removed all the dup-fds correctly, we should also remove the
> > whole fdset, which includes the ->fds, IIUC.
> >
> 
> Since mon_fdset_fd->removed == false, we hit the runstate_is_running()
> problem. I'm not sure, but probably mon_refcount > 0 as well. So the fd
> would not be removed.
> 
> But I'll retest this on Monday just be sure, it's been a while since I
> wrote some parts of this.

Thanks.  And I hope we can also get some more clues too when you dig out
more out of the whole add-fd API; I hope we don't pile up more complicated
logics on top of a mistery.  I feel like this is the time we figure things
out.

-- 
Peter Xu


