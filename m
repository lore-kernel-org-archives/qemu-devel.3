Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5127AC3DA60
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 18:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU9j1-0003tn-7Z; Wed, 17 Jul 2024 14:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sU9iz-0003sG-H0
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 14:50:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sU9ix-0005VJ-4Z
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 14:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721242195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f/TJiVMKEGM+6c4j3xqiHXBOgXk48a2Mb3GTPBayjI4=;
 b=OtKtQmpxL/oi/hc1eDwLq84E3OtSM6xKH/4yleskTKgYW9BWp4+dZJSrUPYvK1t3Di/+gq
 CKq3MD2GeEvnWLReHCYXwZmFMb3/tN+NfkdUDUERUly00Y1Pnw/86ylwVn5rVWJg3Rm9MB
 y/hpSjkuzEC/P9z7mENHgiw7EhKtLWU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-55nxyhS2Nei5zuXWAwGVOA-1; Wed, 17 Jul 2024 14:49:52 -0400
X-MC-Unique: 55nxyhS2Nei5zuXWAwGVOA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6b792d6fe5bso65276d6.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 11:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721242192; x=1721846992;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f/TJiVMKEGM+6c4j3xqiHXBOgXk48a2Mb3GTPBayjI4=;
 b=SQQ8U1QBnX0GFQfr8KQfxCiFr4FtlZUE1Kdk4d3sLTzu8gK5XaTBXunot2KZHk/thr
 1S+DsgVsU73XAfN9yU3itecTBu8sTzWR76MTtiySc779x6y73IXe0oiW2eQNopxaRCVv
 qU+RWzyQlm9BPWl9VPu20kkW4Ua6cis0c291NA15jGFLDwKn6uaG7ktZtCocgLShX/Yn
 8aAVRbGL15NCtd/YpT5pnRbZGt+Su2KES4K8TX6UCQKXz0rVNHPJbf4HjdSxKk+6skDH
 tMWAscRZbssZFhOKgpkyiTOlXpXn34gUJODhXc0nqkrrBZXyuNw8zbIIwyrKaQOTDN0I
 fzVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8HgvkYNLsBP8f7pcFoymNBoAq+LknfePJ6Qe/arh9CmnMWkgWQ3zsyJlcopa5n6OOySH9nT7WXCj4li0hJNcOKMO2fy8=
X-Gm-Message-State: AOJu0Yz0vhdrASzrcfgAZzk+2URpyQXI9A/3fB2Hp+mSyvULcOIiq5ac
 FH/pHiDZxWAzJILUJoxY+gtVz0i8usnOfWgWNDHXkEDhOuV8dI1vldylkCsYrGJT719llJnCcIk
 veL/agS/6R28gSDuqVaJ8LwZhTQw2KLXS0VhmTt1ly98aKAV+F17Z
X-Received: by 2002:a05:620a:294b:b0:79f:726:e2d6 with SMTP id
 af79cd13be357-7a1874ccaeemr171439885a.5.1721242191612; 
 Wed, 17 Jul 2024 11:49:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRwLYD9SFTU0VTBcAA6mUyUmcHW0kJgkSe545rgG8qCNRW24BrO6HEfoxYMoMAVwyQcjWJ5A==
X-Received: by 2002:a05:620a:294b:b0:79f:726:e2d6 with SMTP id
 af79cd13be357-7a1874ccaeemr171438685a.5.1721242191216; 
 Wed, 17 Jul 2024 11:49:51 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44f5b7f1f98sm51728841cf.43.2024.07.17.11.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 11:49:50 -0700 (PDT)
Date: Wed, 17 Jul 2024 14:49:48 -0400
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
Message-ID: <ZpgSTCAGbKwWi_o8@x1n>
References: <ZniFH14DT6ycjbrL@x1n>
 <b0dc8bc4-742b-474b-a4c4-4e190fd6af37@maciej.szmigiero.name>
 <Znr9mOo_t0DkkLbD@x1n>
 <9e85016e-ac72-4207-8e69-8cba054cefb7@maciej.szmigiero.name>
 <Znt0FQHJEtGxcLxj@x1n>
 <2066bb2e-ccb3-45b8-aaf7-c39303e7f993@maciej.szmigiero.name>
 <ZnxAZDcjlZ5oerq-@x1n>
 <73630858-3b65-4fc5-8f5f-a1f494c5c111@maciej.szmigiero.name>
 <Zn19kaeFiYuwwc4B@x1n>
 <35969f33-f6f3-4c34-8b9d-8c1ebac3305e@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <35969f33-f6f3-4c34-8b9d-8c1ebac3305e@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Jul 16, 2024 at 10:10:12PM +0200, Maciej S. Szmigiero wrote:
> On 27.06.2024 16:56, Peter Xu wrote:
> > On Thu, Jun 27, 2024 at 11:14:28AM +0200, Maciej S. Szmigiero wrote:
> > > On 26.06.2024 18:23, Peter Xu wrote:
> > > > On Wed, Jun 26, 2024 at 05:47:34PM +0200, Maciej S. Szmigiero wrote:
> > > > > On 26.06.2024 03:51, Peter Xu wrote:
> > > > > > On Wed, Jun 26, 2024 at 12:44:29AM +0200, Maciej S. Szmigiero wrote:
> > > > > > > On 25.06.2024 19:25, Peter Xu wrote:
> > > > > > > > On Mon, Jun 24, 2024 at 09:51:18PM +0200, Maciej S. Szmigiero wrote:
> > > > > > > > > Hi Peter,
> > > > > > > > 
> > > > > > > > Hi, Maciej,
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > On 23.06.2024 22:27, Peter Xu wrote:
> > > > > > > > > > On Tue, Jun 18, 2024 at 06:12:18PM +0200, Maciej S. Szmigiero wrote:
> > > > > > > > > > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > > > > > > > > > 
> > > > > > > > > > > This is an updated v1 patch series of the RFC (v0) series located here:
> > > > > > > > > > > https://lore.kernel.org/qemu-devel/cover.1713269378.git.maciej.szmigiero@oracle.com/
> > > > > > > > > > 
> > > > > > > > > > OK I took some hours thinking about this today, and here's some high level
> > > > > > > > > > comments for this series.  I'll start with which are more relevant to what
> > > > > > > > > > Fabiano has already suggested in the other thread, then I'll add some more.
> > > > > > > > > > 
> > > > > > > > > > https://lore.kernel.org/r/20240620212111.29319-1-farosas@suse.de
> > > > > > > > > 
> > > > > > > > > That's a long list, thanks for these comments.
> > > > > > > > > 
> > > > > > > > > I have responded to them inline below.
> > > > > > > > > (..)
> > > > > > > 
> > > > > > > 2) Submit this operation to the thread pool and wait for it to complete,
> > > > > > 
> > > > > > VFIO doesn't need to have its own code waiting.  If this pool is for
> > > > > > migration purpose in general, qemu migration framework will need to wait at
> > > > > > some point for all jobs to finish before moving on.  Perhaps it should be
> > > > > > at the end of the non-iterative session.
> > > > > 
> > > > > So essentially, instead of calling save_live_complete_precopy_end handlers
> > > > > from the migration code you would like to hard-code its current VFIO
> > > > > implementation of calling vfio_save_complete_precopy_async_thread_thread_terminate().
> > > > > 
> > > > > Only it wouldn't be then called VFIO precopy async thread terminate but some
> > > > > generic device state async precopy thread terminate function.
> > > > 
> > > > I don't understand what did you mean by "hard code".
> > > 
> > > "Hard code" wasn't maybe the best expression here.
> > > 
> > > I meant the move of the functionality that's provided by
> > > vfio_save_complete_precopy_async_thread_thread_terminate() in this patch set
> > > to the common migration code.
> > 
> > I see.  That function only does a thread_join() so far.
> > 
> > So can I understand it as below [1] should work for us, and it'll be clean
> > too (with nothing to hard-code)?
> 
> It will need some signal to the worker threads pool to terminate before
> waiting for them to finish (as the code in [1] just waits).
> 
> In the case of current vfio_save_complete_precopy_async_thread() implementation,
> this signal isn't necessary as this thread simply terminates when it has read
> all the date it needs from the device.
> 
> In a worker threads pool case there will be some threads waiting for
> jobs to be queued to them and so they will need to be somehow signaled
> to exit.

Right.  We may need something like multifd_send_should_exit() +
MultiFDSendParams.sem.  It'll be nicer if we can generalize that part so
multifd threads can also rebase to that thread model, but maybe I'm asking
too much.

> 
> > The time to join() the worker threads can be even later, until
> > migrate_fd_cleanup() on sender side.  You may have a better idea on when
> > would be the best place to do it when start working on it.
> > 
> > > 
> > > > What I was saying is if we target the worker thread pool to be used for
> > > > "concurrently dump vmstates", then it'll make sense to make sure all the
> > > > jobs there were flushed after qemu dumps all non-iterables (because this
> > > > should be the last step of the switchover).
> > > > 
> > > > I expect it looks like this:
> > > > 
> > > >     while (pool->active_threads) {
> > > >         qemu_sem_wait(&pool->job_done);
> > > >     }
> > 
> > [1]
> > 
> (..)
> > > I think that with this thread pool introduction we'll unfortunately almost certainly
> > > need to target this patch set at 9.2, since these overall changes (and Fabiano
> > > patches too) will need good testing, might uncover some performance regressions
> > > (for example related to the number of buffers limit or Fabiano multifd changes),
> > > bring some review comments from other people, etc.
> > > 
> > > In addition to that, we are in the middle of holiday season and a lot of people
> > > aren't available - like Fabiano said he will be available only in a few weeks.
> > 
> > Right, that's unfortunate.  Let's see, but still I really hope we can also
> > get some feedback from Fabiano before it lands, even with that we have
> > chance for 9.1 but it's just challenging, it's the same condition I
> > mentioned since the 1st email.  And before Fabiano's back (he's the active
> > maintainer for this release), I'm personally happy if you can propose
> > something that can land earlier in this release partly.  E.g., if you want
> > we can at least upstream Fabiano's idea first, or some more on top.
> > 
> > For that, also feel to have a look at my comment today:
> > 
> > https://lore.kernel.org/r/Zn15y693g0AkDbYD@x1n
> > 
> > Feel free to comment there too.  There's a tiny uncertainty there so far on
> > specifying "max size for a device state" if do what I suggested, as multifd
> > setup will need to allocate an enum buffer suitable for both ram + device.
> > But I think that's not an issue and you'll tackle that properly when
> > working on it.  It's more about whether you agree on what I said as a
> > general concept.
> > 
> 
> Since it seems that the discussion on Fabiano's patch set has subsided I think
> I will start by basing my updated patch set on top of his RFC and then if
> Fabiano wants to submit v1/v2 of his patch set then I will rebase mine on top
> of it.
> 
> Otherwise, you can wait until I have a v2 ready and then we can work with that.

Oh I thought you already started modifying his patchset.

In this case, AFAIR Fabiano has plan to rework that RFC series, so maybe
you want to double check with him, and can also wait for his new version if
that's easier, because I do expect there'll be major changes.

Fabiano?

-- 
Peter Xu


