Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F7E5C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 16:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCMFk-00026H-VL; Wed, 29 May 2024 12:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCMFO-000208-Ta
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:33:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCMF9-00081a-Uo
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717000419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q83Ax70Y6mL6GdzmZMznygmN4/ad+En2XXA86ctM0yA=;
 b=BExXl5MssnCKCnYrj98jIvA01S9oJBUbMxqzBtGyYRLc2pXvWougC5vd0OxzIT/qrlaIUI
 4lIjNw63NxOyiLbYjnQzsCiJ+C5AbDC0/LHJYVHHqA6Qxw0+0jVsAbu95F1G5Izq6sRqnO
 mCTiLVuVKTatsosMxSw54rPHKbVGGEE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-rO0lUHVdOYKHbg07ZuBCcA-1; Wed, 29 May 2024 12:33:38 -0400
X-MC-Unique: rO0lUHVdOYKHbg07ZuBCcA-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-43fd537e6a6so2558711cf.0
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 09:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717000416; x=1717605216;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q83Ax70Y6mL6GdzmZMznygmN4/ad+En2XXA86ctM0yA=;
 b=EICs5pQ9mPl+KMeKEqLZXkLRshUZ1ryRZ5D611eQIyM37kerg3mqhmFDyjKUfpoucL
 8le6qXv7lmoPbria2u5fMneIGli84NaFc12Xavg4js/DmELcF2broXg77P6qB2qU1Lev
 Pc/QoM2ITuE+TwWz9bXc+98oe+eJWrICAuzCsQMRD+7v9brVHFLjn5553Ekrgpo/TPSf
 f+l2jYiskO3hiaWhGwHgr9z/0K9XsxVxP4awhuAPXIL5q7/7NUwnXS6juWbJaKmCtLwB
 qqlI/ctNk+2TXCvLomRsKvqcKLYRwi8A/L5BopDDv+ET1oGi4NjGl8lS9/aAPKewJNuE
 V22Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLzPtka6dVuIXfSrAJXKZbBimjmzFCpOTLISZAEE45wT/9WxxNargou1FOKQK5ObpGlYOljMRRVpCbVFjj8iS0UQASJco=
X-Gm-Message-State: AOJu0Yww1WTtofftv5PZoH/xA1U4rmGe81Q7u1Mkc/qC48iYwuaQvH0+
 X8tKrRvy+CKPzV3MgYfPkSY8M2IvvJDY3VmyQMXphrit4llJfk9Ox4ZrrmZI0bGs7xylx/rYaCw
 puna6DIe1cAb0EzmBDi5hcekF0dzDdP0MA+UUuHBxdqvzu3hat6B9
X-Received: by 2002:a05:620a:46a0:b0:793:17f:18ae with SMTP id
 af79cd13be357-794ab110986mr2014051385a.3.1717000415992; 
 Wed, 29 May 2024 09:33:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqRAnaLgkCWeq3t/B7pVYdlNTNS2ZP5xz8Yi0+67QiRBmq1zwFtzgQMe/NfXtu/qOUseQ/1w==
X-Received: by 2002:a05:620a:46a0:b0:793:17f:18ae with SMTP id
 af79cd13be357-794ab110986mr2014044985a.3.1717000415211; 
 Wed, 29 May 2024 09:33:35 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794c87c3b06sm216804185a.73.2024.05.29.09.33.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 09:33:34 -0700 (PDT)
Date: Wed, 29 May 2024 12:33:31 -0400
From: Peter Xu <peterx@redhat.com>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Yu Zhang <yu.zhang@ionos.com>, Michael Galaxy <mgalaxy@akamai.com>,
 Jinpu Wang <jinpu.wang@ionos.com>, Elmar Gerdes <elmar.gerdes@ionos.com>,
 zhengchuan <zhengchuan@huawei.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Prasanna Kumar Kalever <prasanna4324@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Song Gao <gaosong@loongson.cn>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pannengyuan <pannengyuan@huawei.com>,
 Xiexiangyou <xiexiangyou@huawei.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
Message-ID: <ZldY21xVExtiMddB@x1n>
References: <ZjpWmG2aUJLkYxJm@x1n>
 <13ce4f9e-1e7c-24a9-0dc9-c40962979663@huawei.com>
 <ZjzaIAMgUHV8zdNz@x1n>
 <CAHEcVy48Mcup3d3FgYh_oPtV-M9CZBVr4G_9jyg2K+8Esi0WGA@mail.gmail.com>
 <04769507-ac37-495d-a797-e05084d73e64@akamai.com>
 <CAHEcVy4d7uJENZ1hRx2FBzbw22qN4Qm0TwtxvM5DLw3s81Zp_g@mail.gmail.com>
 <Zk0c51D1Oo6NdIxR@x1n>
 <2308a8b894244123b638038e40a33990@huawei.com>
 <ZlX-Swq4Hi-0iHeh@x1n>
 <7bf81ccee4bd4b0e81e3893ef43502a8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7bf81ccee4bd4b0e81e3893ef43502a8@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Lei,

On Wed, May 29, 2024 at 02:43:46AM +0000, Gonglei (Arei) wrote:
> For rdma programming, the current mainstream implementation is to use
> rdma_cm to establish a connection, and then use verbs to transmit data.
> rdma_cm and ibverbs create two FDs respectively. The two FDs have
> different responsibilities. rdma_cm fd is used to notify connection
> establishment events, and verbs fd is used to notify new CQEs. When
> poll/epoll monitoring is directly performed on the rdma_cm fd, only a
> pollin event can be monitored, which means that an rdma_cm event
> occurs. When the verbs fd is directly polled/epolled, only the pollin
> event can be listened, which indicates that a new CQE is generated.
>
> Rsocket is a sub-module attached to the rdma_cm library and provides
> rdma calls that are completely similar to socket interfaces. However,
> this library returns only the rdma_cm fd for listening to link
> setup-related events and does not expose the verbs fd (readable and
> writable events for listening to data). Only the rpoll interface provided
> by the RSocket can be used to listen to related events. However, QEMU
> uses the ppoll interface to listen to the rdma_cm fd (gotten by raccept
> API).  And cannot listen to the verbs fd event. Only some hacking methods
> can be used to address this problem.  Do you guys have any ideas? Thanks.

I saw that you mentioned this elsewhere:

> Right. But the question is QEMU do not use rpoll but gilb's ppoll. :(

So what I'm thinking may not make much sense, as I mentioned I don't think
I know rdma at all.. and my idea also has involvement on coroutine stuff
which I also don't know well. But just in case it shed some light in some
form.

IIUC we do iochannel blockings with this no matter for read/write:

        if (len == QIO_CHANNEL_ERR_BLOCK) {
            if (qemu_in_coroutine()) {
                qio_channel_yield(ioc, G_IO_XXX);
            } else {
                qio_channel_wait(ioc, G_IO_XXX);
            }
            continue;
        }

One thing I'm wondering is whether we can provide a new feature bit for
qiochannel, e.g., QIO_CHANNEL_FEATURE_POLL, so that the iochannel can
define its own poll routine rather than using the default when possible.

I think it may not work if it's in a coroutine, as I guess that'll block
other fds from being waked up.  Hence it should look like this:

        if (len == QIO_CHANNEL_ERR_BLOCK) {
            if (qemu_in_coroutine()) {
                qio_channel_yield(ioc, G_IO_XXX);
            } else if (qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_POLL)) {
                qio_channel_poll(ioc, G_IO_XXX);
            } else {
                qio_channel_wait(ioc, G_IO_XXX);
            }
            continue;
        }

Maybe we even want to forbid such channel to be used in coroutine already,
as when QIO_CHANNEL_FEATURE_POLL set it may mean that this iochannel simply
won't work with poll() like in rdma's use case.

Then rdma iochannel can implement qio_channel_poll() using rpoll().

There's one other dependent issue here in that I _think_ the migration recv
side is still in a coroutine.. so we may need to move that into a thread
first.  IIRC we don't yet have a major blocker to do that, but I didn't
further check either.  I've put that issue aside just to see whether this
may or may not make sense.

Thanks,

-- 
Peter Xu


