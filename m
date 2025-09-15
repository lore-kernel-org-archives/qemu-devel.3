Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0970FCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 20:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyG1c-0004EN-1V; Mon, 15 Sep 2025 16:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uyG1Z-0004Dm-63
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 16:42:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uyG1J-0002h3-GA
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 16:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757968907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V8LKlf38HxkrKTj4X+ok7G5k/e/Dw5NwpMGHhctI0h8=;
 b=JPP4H/rAkSO70tMum8llBNLR3FOSS8BNVS6WQ2dcfSrJTwKk4TJSawnPC/ZTRAvA83ERzW
 EDxrHoTFXb9WF+/6CEPLjDRLtzC56FaS0tqoHco4Nv2EV2uo1w/YZg1TGLJXj8wC99bXPL
 4KJpaQGsPY4wUlA05iFD9iK6LWWsYdc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-owEX1DTdOX-_7bHDXLSolQ-1; Mon, 15 Sep 2025 16:41:43 -0400
X-MC-Unique: owEX1DTdOX-_7bHDXLSolQ-1
X-Mimecast-MFC-AGG-ID: owEX1DTdOX-_7bHDXLSolQ_1757968903
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-70d7c7e972eso90783696d6.3
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 13:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757968903; x=1758573703;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V8LKlf38HxkrKTj4X+ok7G5k/e/Dw5NwpMGHhctI0h8=;
 b=WJJMY3ZStoFNsOS56dAvTaBpA2qM0V+w4QslValFacQD0PJ0hJIxGpz52B3C62Oapa
 lJrERSUOeOSp3/xsUeA9pAnideJ/4/gCdGnAYdR0wa3iYXQ4qQ5O6tK1UcRra/JgNzd2
 D8Bm7+BwizVV8ge4ZU9sK2uEZPEGTZpRV1xsLcmKVGSFhiLkCh9ypJuUzMw/osWBXXBJ
 zxG8ptZ2ACXZtmfpdRTY2nSj+XnEdp6rAgn/05IqfIg8Pgi4P0Q8LLpatI3Pxh0wDPw/
 rS/D6sjf8w6RMwgb9IH4LUo3YfJ2tQ7YKkyIC3cNW9maWJxTaekFeuJjvtg0jPsj/jxM
 743w==
X-Gm-Message-State: AOJu0Yyr3jEpq9n0/yJTUOSd8Q4WG5Zv6VNEYIYbmYC5ufGRwdxmsFuo
 kSy1HWXH6Vndb4NH6p02LhBbHqLB5NIJQ2mnJR6AkMBCZSGHsvSLXU6f/ubfkxNlDqu7SD+BJQ5
 B0PZ+SvbNhvPSTkGdd/JbWLbX3OLyp6umJLqln7oaf6KGnEVqnchAs49N
X-Gm-Gg: ASbGncsVUYMcr/l+Ab2TI+LgwMkueIIhTfl8/9KptehUmegxG5i+5ok797XH8SNurlN
 c4bzmEwu539IqFj78TGhCHrd8OT+QoSdfdbrqepQ0B1FSvIoyF1GrTGZ86BK4vEbePHWzEyeRfP
 tGkPieSZKv5rP8k56YY2YInfGjO4aSTod/+4kOeLgAjO6FmUd0F+FagDLRcuRtqJJmbuzpDsGKR
 y81HH1P0dilZKhTAE1SbFblmfaqKcCDy6THSRQbIp1eGFez21fxcaebd4YNuUraz1ALcWiwv+qc
 ybdMMihsAyDoatacuvL0+u8ryTL9E8po
X-Received: by 2002:a05:6214:1bc7:b0:743:d937:f27c with SMTP id
 6a1803df08f44-767bd2866e6mr165138726d6.29.1757968902982; 
 Mon, 15 Sep 2025 13:41:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxqZVN9gi1K7IvV+ENIANOI5C+Hae+SRhbHU14dde8RXz9D8iXuQllIKaSbfeew6dF8ZzvOg==
X-Received: by 2002:a05:6214:1bc7:b0:743:d937:f27c with SMTP id
 6a1803df08f44-767bd2866e6mr165138476d6.29.1757968902464; 
 Mon, 15 Sep 2025 13:41:42 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-763bee7c80dsm81961036d6.52.2025.09.15.13.41.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 13:41:41 -0700 (PDT)
Date: Mon, 15 Sep 2025 16:41:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 2/3] io/tls: Make qio_channel_tls_bye() always
 synchronous
Message-ID: <aMh59RW2nPEEuF0a@x1.local>
References: <20250911212355.1943494-1-peterx@redhat.com>
 <20250911212355.1943494-3-peterx@redhat.com>
 <aMQDuFI2hQQ8clAF@redhat.com> <aMQ-E8BkvQq6Pisx@x1.local>
 <aMhdoWKdY_lxghVu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aMhdoWKdY_lxghVu@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 15, 2025 at 07:40:33PM +0100, Daniel P. Berrangé wrote:
> On Fri, Sep 12, 2025 at 11:36:51AM -0400, Peter Xu wrote:
> > On Fri, Sep 12, 2025 at 12:27:52PM +0100, Daniel P. Berrangé wrote:
> > > On Thu, Sep 11, 2025 at 05:23:54PM -0400, Peter Xu wrote:
> > > > No issue I hit, the change is only from code observation when I am looking
> > > > at a TLS premature termination issue.
> > > > 
> > > > qio_channel_tls_bye() API needs to be synchronous.  When it's not, the
> > > > previous impl will attach an asynchronous task retrying but only until when
> > > > the channel gets the relevant GIO event. It may be problematic, because the
> > > > caller of qio_channel_tls_bye() may have invoked channel close() before
> > > > that, leading to premature termination of the TLS session.
> > > > 
> > > > Remove the asynchronous handling, instead retry it immediately.  Currently,
> > > > the only two possible cases that may lead to async task is either INTERRUPT
> > > > or EAGAIN.  It should be suffice to spin retry as of now, until a solid
> > > > proof showing that a more complicated retry logic is needed.
> > > > 
> > > > With that, we can remove the whole async model for the bye task.
> > > > 
> > > > When at it, making the function return bool, which looks like a common
> > > > pattern in QEMU when errp is used.
> > > > 
> > > > Side note on the tracepoints: previously the tracepoint bye_complete()
> > > > isn't used.  Start to use it in this patch.  bye_pending() and bye_cancel()
> > > > can be dropped now.  Adding bye_retry() instead.
> > > > 
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >  include/io/channel-tls.h |  5 ++-
> > > >  io/channel-tls.c         | 86 +++++-----------------------------------
> > > >  io/trace-events          |  3 +-
> > > >  3 files changed, 15 insertions(+), 79 deletions(-)
> > > > 
> 
> > > > diff --git a/io/channel-tls.c b/io/channel-tls.c
> > > > index 5a2c8188ce..8510a187a8 100644
> > > > --- a/io/channel-tls.c
> > > > +++ b/io/channel-tls.c
> > > > @@ -253,84 +253,25 @@ void qio_channel_tls_handshake(QIOChannelTLS *ioc,
> > > >      qio_channel_tls_handshake_task(ioc, task, context);
> > > >  }
> > > >  
> > > > -static gboolean qio_channel_tls_bye_io(QIOChannel *ioc, GIOCondition condition,
> > > > -                                       gpointer user_data);
> > > > -
> > > > -static void qio_channel_tls_bye_task(QIOChannelTLS *ioc, QIOTask *task,
> > > > -                                     GMainContext *context)
> > > > +bool qio_channel_tls_bye(QIOChannelTLS *ioc, Error **errp)
> > > >  {
> > > > -    GIOCondition condition;
> > > > -    QIOChannelTLSData *data;
> > > >      int status;
> > > > -    Error *err = NULL;
> > > >  
> > > > -    status = qcrypto_tls_session_bye(ioc->session, &err);
> > > > +    trace_qio_channel_tls_bye_start(ioc);
> > > > +retry:
> > > > +    status = qcrypto_tls_session_bye(ioc->session, errp);
> > > >  
> > > >      if (status < 0) {
> > > >          trace_qio_channel_tls_bye_fail(ioc);
> > > 
> > > snip
> > > 
> > > > +        return false;
> > > > +    } else if (status != QCRYPTO_TLS_BYE_COMPLETE) {
> > > > +        /* BYE event must be synchronous, retry immediately */
> > > > +        trace_qio_channel_tls_bye_retry(ioc, status);
> > > > +        goto retry;
> > > >      }
> > > 
> > > We cannot do this. If the gnutls_bye() API needs to perform
> > > socket I/O, and so when we're running over a non-blocking
> > > socket we must expect EAGAIN. With this handling, QEMU will
> > > busy loop burning 100% CPU when the socket is not ready.
> > 
> > Right.  That was the plan when drafting this, the hope is spinning will
> > almost not happen, and even if it happens it'll finish soon (migration is
> > completing, it means network mustn't be so bad), unless the network is
> > stuck exactly at when we send the bye().
> 
> Don't forget that the machine can be running 5 migrations
> of different VMs concurrently, and so may not be as quick
> to finish sending traffic as we expect. Since QEMU's mig
> protocol is essentially undirectional, I wonder if the
> send buffer could still be full of VMstate data waiting
> to be sent ? Perhaps its fine, but I don't like relying
> on luck, or hard-to-prove scenarios.

Very rare conditional spinning is, IMHO, totally OK.  I wished all our
problems are as simple as cpu spinning.. then it's super straightforward to
debug when hit, and also benign.  We can add whatever smart tech after that.

I would just guess even if with this patch goes in, we will never observe
it considering the write buffer shouldn't be more than tens of MBs..

Said that..

> 
> > > A second point is that from a QIOChannel POV, we need to
> > > ensure that all APIs can be used in a non-blocking scenario.
> > > This is why in the QIOChannelSocket impl connect/listen APIs
> > > we provide both _sync and _async variants of the APIs, or
> > > in the QIOChannelTLS impl, the handshake API is always
> > > async with a callback to be invokved on completion.
> > 
> > I agree.  The issue is if so, migration code needs to be always be prepared
> > with a possible async op even if in 99.9999% cases it won't happen... we
> > need to complicate the multifd logic a lot for this, but the gain is
> > little..
> > 
> > This series still used patch 1 to fix the problem (rather than do real BYE
> > on preempt channels, for example) only because it's the easiest, after all
> > it's still a contract in tls channel impl to allow premature termination
> > for explicit shutdown()s on the host.
> > 
> > If we want to do 100% graceful shutdowns, we'll need to apply this to all
> > channels, and the async-possible model can definitely add more complexity
> > more than multifd.  I hope it won't be necessary.. but just to mention it.
> 
> Even if the migration code is relying on non-blocking sockets
> for most of its work, at the time we're ready to invoke "bye",
> perhaps the migration code could simply call
> 
>  qio_channel_set_blocking(ioc, true)
> 
> to switch the socket over to blocking mode.

... I think this is a good idea and should solve the problem indeed.  I
hope there's no loophole that it could still trigger the async path.

I'll respin with that, thanks!

-- 
Peter Xu


