Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3610606A329
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 20:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DD7LCN11;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Tc0XqmY3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWfnY-0006LP-85; Thu, 26 Nov 2026 15:10:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWfnP-0006Eq-Gg
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 15:10:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWfnM-0006vW-D3
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 15:10:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795723814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6sEGYohIWQDttXCksKGw29yCaQ4OEAfm6GeFIPAVwRU=;
 b=DD7LCN11wxmi2zhhSZDFNKFJ9wiJYqHbUTq2zl98gUdkkogv2FvV1Y37TkkPk3AbvJrvfo
 iTH8i3FWmrcwSfMcJgssVRUtmwNtPhkqVwsvfCwpqJSKFih+1U88xFAvVt2rl4c1AM08Kp
 /SuJy6rY8qGN7pEbnY3sqetEeKwNPqM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-8TzZoI4HPN2ozREwph9_qA-1; Thu, 26 Nov 2026 20:10:12 +0000
X-MC-Unique: 8TzZoI4HPN2ozREwph9_qA-1
X-Mimecast-MFC-AGG-ID: 8TzZoI4HPN2ozREwph9_qA_1795723811
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-949b0d3232fso1012050785a.1
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 12:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795723811; x=1796328611; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6sEGYohIWQDttXCksKGw29yCaQ4OEAfm6GeFIPAVwRU=;
 b=Tc0XqmY3ONCtQKCftaTsFdox5e4g644HO3ZTZdetsDFFnxs5j24A3s5M1akJwpwjiU
 XHIQicwvGR38XkG51WshM66oOridS01QeNzJuCfg/PDNUsIsVYOOc09M2RMpywu5JAHH
 +Ku25v3W7RHcdhAvoNeOR5r9rtp1vD91XxU5lZeHbDpZoUMdTw0YGxPKAYEB7rTAgcro
 /RRmP/jCGJHtY62/0v506HlyvjB2F6CNekYDVccwBT7YALD7o3CX/wpmyL//AOLX63OQ
 Hh5WjvJen3ZUpxlfBcpFaDx8T/HJx7Paisu09nr6QVIc1Y5tKyWRVXv3Q5pKbtrAAXEJ
 Zf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795723811; x=1796328611;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6sEGYohIWQDttXCksKGw29yCaQ4OEAfm6GeFIPAVwRU=;
 b=p8UllhFDhSOEkk1/YjV3GmCoHtaKNssHLKfALGU++ol8T+F4HqFfccDyUWF5bhglP2
 Xjx/2o6erzWrmEfWxRLnZI2sOwqNgOUzNu/M0Zhx6Vtv68rlRRmPxTAdzWxBvevVgi34
 pj5RsW+Xfwo8kxX6yMWyyiVm4mbcDxYIkc6Ul8UlOD4FdRwaHoIj+GHgB6dr6ayoJPPS
 7xiW6ir44pMt8+rDKITh/FcCRK/r40Wfmv0uf2tSuX7ykoaK5D8TKiks2PU3hWQBL4Pp
 oKbQMeqGoe/Lqh4S2KA4LfU0oto/AUx1Wr5ZoN1wuJzvKteLchAPgxacbxt7Z8hZ3YH6
 PLTQ==
X-Gm-Message-State: APuU4Z8qPEzLoQCrTX9dWcePMFOOz5ISMhjNmHqT5ylPAPe0QNrnNGK1
 b7x2bLb1BoZFwAe1HKbl+gUHmx1WvYb8bTNkUqrWwrU4lzuwhWE4yETrEUsD/wWEhCha0PxflLe
 uAiGeiH/8JGnExQnb0i0r1GJAmM9+DdGVIQGFDfauLyx8aeXFVHU8HplM
X-Gm-Gg: AZFdTZcfiWx2/AU730CWwIobvZm9PVaE/ZRtTgrgJpLQ9peH+NTN49EOAOiVqQjo4FR
 DZ1BPrXIQK2XACsaFt7sboBqOWnE5oif3Y8rl8oaHUnA5R1iamxvB40hKePzCp3DWCwLttXvb5J
 otsYtARq/5w8RwLR/JMuqjDAf5ny5dpJVgo5JhoR/OmEqP/EERdJ1++jBgTfpAYs8cFpLrInink
 T7jQu7EfSzUx5NzoBRdlK+fSGX0zny4vwCsvSLGzHbVdjUDEf0BiTt5MvtkqJYT2FQ++vI1y47J
 RYJyJbgKvR2PoMCW9AuFZjH2sHg9/Xjbd7HzbjXWny6WnTRdO0sqbQFjCbucg5/foBpX9/orjRU
 m8hlOAAq+LTOc4TUxgERUKAUtSQgJEfUqVuCLjeFO3UAq
X-Received: by 2002:a05:620a:1329:b0:949:8119:6702 with SMTP id
 af79cd13be357-949ba8236e3mr3678457785a.10.1795723811183; 
 Thu, 26 Nov 2026 12:10:11 -0800 (PST)
X-Received: by 2002:a05:620a:1329:b0:949:8119:6702 with SMTP id
 af79cd13be357-949ba8236e3mr3678451385a.10.1795723810637; 
 Thu, 26 Nov 2026 12:10:10 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb3a646fsm1664257685a.22.2026.11.26.12.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 12:10:10 -0800 (PST)
Date: Thu, 26 Nov 2026 15:10:09 -0500
From: Peter Xu <peterx@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Hongyan Xu <getshell@seu.edu.cn>,
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Subject: Re: [PATCH for-12.0 v2] coroutine: Make yield_until_fd_readable()
 detach fd handler always
Message-ID: <awiSIWr8sqVm3_2N@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261123133747.2571462-1-peterx@redhat.com>
 <20261124155932.GA1640366@shajnocz.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261124155932.GA1640366@shajnocz.csb>
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

On Tue, Nov 24, 2026 at 10:59:32AM -0500, Stefan Hajnoczi wrote:
> On Mon, Nov 23, 2026 at 08:37:47AM -0500, Peter Xu wrote:
> > Hongyan reported a possible use-after-free of RDMA migration code:
> > 
> > https://lore.kernel.org/all/20260904033130.276-1-getshell@seu.edu.cn
> > 
> > The issue seems real, while this patch is a proposal to fix it in a simpler
> > way, meanwhile it should be a problem to the yield_until_fd_readable()
> > helper in general, so it should make more sense to be fixed there too.
> > 
> > The problem is about the use of the stack allocated FDYieldUntilData where
> > we must make sure after yield_until_fd_readable() returns it's not used
> > anywhere.  If the coroutine yielded can be entered from outside of this
> > helper (fd_coroutine_enter()), then the aio handler might be installed even
> > after yield_until_fd_readable() returns, and that makes the stack variable
> > accessible by aio codd, even if stack gone.
> > 
> > Fix it by moving the aio handler removal outside the handler.
> > 
> 
> Fixes: 923709896b1b ("migration: poll the cm event for destination qemu")

I'll add.

> 
> But it looks like additional fixes are necessary for commit 923709896b1b:
> 
> 1. ram_load_precopy() -> aio_co_schedule() + qemu_coroutine_yield()
> 
>    rdma_cm_poll_handler() -> qemu_coroutine_enter() hits the "Co-routine
>    was already scheduled" abort in qemu_aio_coroutine_enter() if called
>    before the scheduled coroutine runs.
> 
> 2. qio_channel_yield() asserts when qio_channel_rdma_readv() returns QIO_CHANNEL_ERR_BLOCK
> 
>    There is a code path in qio_channel_rdma_readv() that returns
>    QIO_CHANNEL_ERR_BLOCK, causing qio_channel_yield() to be called. The
>    problem here is that qemu_coroutine_enter() is not allowed at this
>    yield point. You have to use qio_channel_wake_read() to interrupt the
>    read.

Thanks for going beyond this patch.  My plan is to leave rdma + coroutine
issues alone until we remove support of that in the bigger series.  We're
aware serious users of rdma migration and likely they didn't hit them for
years.  Then I assumed it's fine keeping them there for another short while.

After the other series land, all these issues should be gone.

> 
> > Reported-by: Hongyan Xu <getshell@seu.edu.cn>
> > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > Cc: Kevin Wolf <kwolf@redhat.com>
> > Cc: Fabiano Rosas <farosas@suse.de>
> > Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
> > Cc: Hongyan Xu <getshell@seu.edu.cn>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> > v2:
> > - Drop FDYieldUntilData altogether [Kevin]
> > - Drop the comment, doesn't feel as helpful now [myself]
> > ---
> >  util/qemu-coroutine-io.c | 20 +++++---------------
> >  1 file changed, 5 insertions(+), 15 deletions(-)
> > 
> > diff --git a/util/qemu-coroutine-io.c b/util/qemu-coroutine-io.c
> > index 364f4d5abf..720d27d737 100644
> > --- a/util/qemu-coroutine-io.c
> > +++ b/util/qemu-coroutine-io.c
> > @@ -65,28 +65,18 @@ qemu_co_send_recv(int sockfd, void *buf, size_t bytes, bool do_send)
> >      return qemu_co_sendv_recvv(sockfd, &iov, 1, 0, bytes, do_send);
> >  }
> >  
> > -typedef struct {
> > -    AioContext *ctx;
> > -    Coroutine *co;
> > -    int fd;
> > -} FDYieldUntilData;
> > -
> >  static void fd_coroutine_enter(void *opaque)
> >  {
> > -    FDYieldUntilData *data = opaque;
> > -    aio_set_fd_handler(data->ctx, data->fd, NULL, NULL, NULL, NULL, NULL);
> > -    qemu_coroutine_enter(data->co);
> > +    qemu_coroutine_enter((Coroutine *)opaque);
> >  }
> >  
> >  void coroutine_fn yield_until_fd_readable(int fd)
> 
> Please update the doc comment in include/qemu/coroutine.h to say that
> yield_until_fd_readable() may be interrupted by re-entering the
> coroutine early and the function will return immediately. This behavior
> is part of the API.

I'll add a comment.

But just to mention after the bigger series, I'll likely remove this API
too.

Thanks,

> 
> >  {
> > -    FDYieldUntilData data;
> > +    AioContext *ctx = qemu_get_current_aio_context();
> >  
> >      assert(qemu_in_coroutine());
> > -    data.ctx = qemu_get_current_aio_context();
> > -    data.co = qemu_coroutine_self();
> > -    data.fd = fd;
> > -    aio_set_fd_handler(data.ctx, fd, fd_coroutine_enter, NULL, NULL, NULL,
> > -                       &data);
> > +    aio_set_fd_handler(ctx, fd, fd_coroutine_enter, NULL, NULL, NULL,
> > +                       (void *)qemu_coroutine_self());
> >      qemu_coroutine_yield();
> > +    aio_set_fd_handler(ctx, fd, NULL, NULL, NULL, NULL, NULL);
> >  }
> > -- 
> > 2.56.0
> > 
> 

-- 
Peter Xu

