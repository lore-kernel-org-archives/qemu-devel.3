Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40C6606A336
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 21:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HCGxlmzu;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=OSMlM8rB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUWQj-0008F3-IU; Fri, 20 Nov 2026 16:46:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xUWQf-0008Ef-R6
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 16:45:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xUWQd-0002t1-Hx
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 16:45:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795211153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f2D9cqaLCgO45rZ0Zt/nUL0DbMOFOGw05Ah4vW0wTW4=;
 b=HCGxlmzuKrBAK025r6Mc6+kKbmmup1OBkV/n6ybVQv1cDKJVjCIoRgKrkINt3ImT+FidX8
 xMSWgjoRcuompn9M4m4RzBWX2pDvEXxQL8lbrIDtzVeJRJCU09mXjnSXxEb4SEp0BSfnM7
 Z/aqzOLbmnSFfgYaO4BZyxcOZ5JntKs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-RcRa6crmPICI3lWfMk6yTA-1; Fri, 20 Nov 2026 21:45:51 +0000
X-MC-Unique: RcRa6crmPICI3lWfMk6yTA-1
X-Mimecast-MFC-AGG-ID: RcRa6crmPICI3lWfMk6yTA_1795211151
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-92101559a2bso25297616d6.3
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 13:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795211151; x=1795815951; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=f2D9cqaLCgO45rZ0Zt/nUL0DbMOFOGw05Ah4vW0wTW4=;
 b=OSMlM8rBaUGkhUQA3bZz1f84fcoVr8ME2hfY3C4JQq/n4sPYcH2LPy77ApQWBbdIyf
 MchZneJoyYJD8b3Ue8jSR6Xa70cO8Gsm82rnua3vSL1hLfrSXAkVvkj7zcyuLg7rOGa4
 Rt9EkG3dJzuee6VvqC0mFrGxsFyB93ZSEEdKYaPygddvHOK40RSOT64WTUfDcJnyYjCb
 fGlaFjcKmrifYTPT6D2FAB+0b8VUhvLRXQql3ET5779bzTojeGsDdljZkBOjOT1tNxyK
 FaG64NvAXj04zr7TVnBA5w3sC2D5Mmh01P9MMFbWJEFIkArWgQTiltSa65NwxUhk/YtX
 t6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795211151; x=1795815951;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f2D9cqaLCgO45rZ0Zt/nUL0DbMOFOGw05Ah4vW0wTW4=;
 b=D3xvdJaQxQhDvD7wth46UeEIfXMVbC1qQunVrOuvlnZKbfjtkY4ewpqL5qaNSvmG41
 fRc8l53173bU+5JtnOWQsvPCC/di2llCdLm5NyeRl4bqYC40pDJKgen2iBNkZTvVH7Hn
 omtLgbXabD8NeFfaXpMeb2h3eRVkOZsU0k1acQz4Gc6kiDXKccHxBxEx7MIcobxr2wA6
 msG4gi9CPneQM1673lyJufCvgUIKvNvyDWBfIypJhSl67aOVn3bHcgdHvL2cvYoG34WU
 HN73DbqO6AWTkSY/gaMA6Y9XqQu24PSlyT8wMMqF5xOdB93XDwznOX+VYmwbkAicHgZz
 mpeg==
X-Gm-Message-State: APuU4Z9DZyf79fNXk2rvHSCJ0RIDJbcUfnq32C2e+lOjiXORSnVgi5ox
 7itqCsUi5yeSBdsXiQNlo7nqVo9Xp7D6d9vOGSQvnkTjORmleP656K/xyH3EWks2IZNofowytYH
 vaJB02xMlNB+XMb9A0einhIcG67aseiomEKzBGxQvqmGzznFdVMdiW0DA
X-Gm-Gg: AZFdTZemqYXrwluqRDi7n4yAabONYdFzM/ZwUPckyv9aYbryAembVcAqIYW/xqMyxWf
 9nHoLvqAE9pOfHeVgTTTzHJ77yNDJc0jAaIu8+kWS4hGjEGHMpGSXkg3VbyyIlEV2JSiXh/JbbT
 rhkOzqQLwOLu7vxSmGXkpADtWWhwJLzj10Rx5hKnE3lYR4SXZbBxxv2yTZypqrKvstWgzNzFfys
 /YMYFEjmtATOWhw38EIJYHUdxNRe+qS8m2sQfQE7swToIqIP0kgMEotoL+tshC/KU2SzPU+Rd8e
 mqUa1q5CoV+1jCpVOnnXHvaQcsiOBHkOsUwmR6hH/r6BED+WH6j6Qj8294iZnKAm0JpxPH762y3
 fEyMPcnnoySlHHbEokA6el2/vF6hrXck8eVh16Iky5Z9g
X-Received: by 2002:ad4:5f88:0:b0:921:2e40:8105 with SMTP id
 6a1803df08f44-92134b61ec1mr71563576d6.57.1795211150521; 
 Fri, 20 Nov 2026 13:45:50 -0800 (PST)
X-Received: by 2002:ad4:5f88:0:b0:921:2e40:8105 with SMTP id
 6a1803df08f44-92134b61ec1mr71563236d6.57.1795211149912; 
 Fri, 20 Nov 2026 13:45:49 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134bf848dsm36339696d6.44.2026.11.20.13.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 13:45:49 -0800 (PST)
Date: Fri, 20 Nov 2026 16:45:48 -0500
From: Peter Xu <peterx@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Hongyan Xu <getshell@seu.edu.cn>,
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Subject: Re: [PATCH for-12.0] coroutine: Make yield_until_fd_readable()
 detach fd handler always
Message-ID: <awC_jPC12IiR-yvZ@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261119145311.1144878-1-peterx@redhat.com>
 <20261119222936.GB780462@shajnocz.csb>
 <av-AweS887ZVL9HO@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <20261120170112.GD780462@shajnocz.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261120170112.GD780462@shajnocz.csb>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 12:01:12PM -0500, Stefan Hajnoczi wrote:
> On Thu, Nov 19, 2026 at 06:05:37PM -0500, Peter Xu wrote:
> > On Thu, Nov 19, 2026 at 05:29:36PM -0500, Stefan Hajnoczi wrote:
> > > On Thu, Nov 19, 2026 at 09:53:11AM -0500, Peter Xu wrote:
> > > > Hongyan reported a possible use-after-free of RDMA migration code:
> > > > 
> > > > https://lore.kernel.org/all/20260904033130.276-1-getshell@seu.edu.cn
> > > > 
> > > > The issue seems real, while this patch is a proposal to fix it in a simpler
> > > > way, meanwhile it should be a problem to the yield_until_fd_readable()
> > > > helper in general, so it should make more sense to be fixed there too.
> > > > 
> > > > The problem is about the use of the stack allocated FDYieldUntilData where
> > > > we must make sure after yield_until_fd_readable() returns it's not used
> > > > anywhere.  If the coroutine yielded can be entered from outside of this
> > > > helper (fd_coroutine_enter()), then the aio handler might be installed even
> > > > after yield_until_fd_readable() returns, and that makes the stack variable
> > > > accessible by aio codd, even if stack gone.
> > > > 
> > > > Fix it by moving the aio handler removal outside the handler.
> > > > 
> > > > Reported-by: Hongyan Xu <getshell@seu.edu.cn>
> > > > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > > > Cc: Kevin Wolf <kwolf@redhat.com>
> > > > Cc: Fabiano Rosas <farosas@suse.de>
> > > > Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
> > > > Cc: Hongyan Xu <getshell@seu.edu.cn>
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > > 
> > > > NOTE: I targeted this for 12.0 because the bug was not introduced in 11.2,
> > > > however this seems to be a real bug fix to coroutine in general, I'll leave
> > > > that to maintainers to decide if to pick it for 11.2.
> > > > ---
> > > >  util/qemu-coroutine-io.c | 6 +++++-
> > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/util/qemu-coroutine-io.c b/util/qemu-coroutine-io.c
> > > > index 364f4d5abf..3c0a7feafa 100644
> > > > --- a/util/qemu-coroutine-io.c
> > > > +++ b/util/qemu-coroutine-io.c
> > > > @@ -74,7 +74,6 @@ typedef struct {
> > > >  static void fd_coroutine_enter(void *opaque)
> > > >  {
> > > >      FDYieldUntilData *data = opaque;
> > > > -    aio_set_fd_handler(data->ctx, data->fd, NULL, NULL, NULL, NULL, NULL);
> > > >      qemu_coroutine_enter(data->co);
> > > >  }
> > > >  
> > > > @@ -89,4 +88,9 @@ void coroutine_fn yield_until_fd_readable(int fd)
> > > >      aio_set_fd_handler(data.ctx, fd, fd_coroutine_enter, NULL, NULL, NULL,
> > > >                         &data);
> > > >      qemu_coroutine_yield();
> > > > +    /*
> > > > +     * Always remove the fd handler, no matter the re-entering of this
> > > > +     * coroutine was caused by fd_coroutine_enter() or something else.
> > > > +     */
> > > > +    aio_set_fd_handler(data.ctx, fd, NULL, NULL, NULL, NULL, NULL);
> > > >  }
> > > 
> > > Why would the coroutine be entered?
> > 
> > In case of RDMA, rdma_cm_poll_handler() could receive a disconnect event on
> > another management fd, then it knows the link is down, hence it needs to
> > kickoff this coroutine to quit.  See 923709896b1.
> 
> Commit 923709896b1 is not safe in general. It would be necessary to
> audit all yield points and see how they react to an unexpected coroutine
> re-entry. There could be more bugs related to this.

AFAIU, this is really the only caller. :)

Per my understanding, RDMA migration code was written in a way that it
sololy rely on qemu_rdma_block_for_wrid() to block waiting for completion
events.

> 
> > > Should there be a loop around
> > > qemu_coroutine_yield() - otherwise we fix the invalid stack memory
> > > access but return to the caller without fulfilling the purpose of the
> > > function (waiting for the fd to become readable), which could cause
> > > further bugs?
> > 
> > I feel like these are two separate things.
> > 
> > IMO fixing reset of aio handler should be a pure positive fix, because not
> > fixing it doesn't stop user from re-entering of the coroutine and bypass
> > fd_coroutine_enter().
> > 
> > My understanding is the caller should have full control of this: when the
> > caller requires "fd must be readable", it should always wait until
> > fd_coroutine_enter() returns.  This patch should have no functional
> > difference.
> 
> I don't understand this paragraph because the caller has no way of
> knowing whether fd_coroutine_enter() ran when yield_until_fd_readable()
> returns with this patch applied. How can the caller wait until
> fd_coroutine_enter() returns?

What I meant is, after returning from yield_until_fd_readable(), the caller
can re-check everything again to be tolerant to other events, e.g. poll()
the fd again to re-check if the fd is really readable, then it can go back
and yield again if it wants when not readable. So that the code (depending
on how it was implemented) flows all fine no matter if the fd will be
readable.  Thats, AFAICT, how RDMA migration works.

> 
> > But it seems still legal if the caller is benign and can properly handle
> > the case even if fd is still not readable.  In this case, this patch fixes
> > a real issue.
> > 
> > In case of RDMA migration, only the quit path can cause it to re-enter, so
> > either there is IO or we need to quit.  RDMA code works well with either
> > event, it can even loop back and wait on the fd again, but since quit is
> > the only path kicking this off, it's also not possible even if the caller
> > handles this.
> 
> The caller of yield_until_fd_readable() expects the function return to
> mean the fd is now readable, not that the fd is readable or something
> else happened. At minimum this patch would need to add a comment to
> clarify this and then audit all callers to be sure they can handle those
> semantics correctly.
> 
> It would be better to also add a return value differentiating between
> success and failure (due to interruption) so that callers can propagate
> the interruption (a caller may be several frames into a call stack where
> a parent function will loop on early return, defeating the purpose of
> reentering the coroutine to notify it that the connection on a separate
> fd was dropped, so it must be possible to propagate the interruption up
> the call stack).
> 
> Any part of QEMU could use util/qemu-coroutine-io.c, so even if this
> patch happens to work for RDMA migration, the yield_until_fd_readable()
> API needs a more disciplined approach so that it can be used correctly
> by anyone.

I get the point that this API might be tricky to use, actually I don't
think I'm good enough knowing coroutines to say what is a best API, but so
far it's only used in RDMA migration and over many years no new user came
up.  So maybe it's not a major concern yet.

The other thing just to mention, I actually have code trying to remove RDMA
migration from using coroutine too:

https://lore.kernel.org/qemu-devel/20251022192612.2737648-9-peterx@redhat.com/

After that maybe we can drop this API.  For now, fixing that seems
reasonable if it's trivial, and also because it's not yet confirmed it'll
happen.

Thanks,

-- 
Peter Xu


