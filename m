Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFEDC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:15:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whqSl-00050v-Jp; Thu, 09 Jul 2026 11:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1whqSd-000504-Pi
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 11:14:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1whqSb-0004Yq-HO
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 11:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783610084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VJXGxjFftP2hvdaDSiYqsQcwixNn6xCYSya2BvDjxWI=;
 b=PM5w5p02bJYu3eccYxEmXxOYVoI3Wdr+l80lch58Clbwn88Q+J1SUiVFsrUq7KGiDLC7qp
 OLCMReXBV8Bg26hNmtHPePcEXkg7dp0pzTYmHbn3QOA+mxAPig3ssucGcBD0Yu3cxCyQ2a
 19k7yNzIzFe13nZXwVp3gmVIXuBt6yY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-Txk_6l25O36W97sRPiFd8A-1; Thu, 09 Jul 2026 11:14:40 -0400
X-MC-Unique: Txk_6l25O36W97sRPiFd8A-1
X-Mimecast-MFC-AGG-ID: Txk_6l25O36W97sRPiFd8A_1783610079
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-698a99b6140so2667760a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 08:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783610079; x=1784214879; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VJXGxjFftP2hvdaDSiYqsQcwixNn6xCYSya2BvDjxWI=;
 b=Ow+VKjnN3jXrxSrtDhZRML+9ieiGsHoof6jNFNDZcQkEjBAWphFZiewx7gRYfpOJb3
 /ZJ7z7e76ox2kBRrAAvV85y6VQsHxz80f4w6AH6U3UO8C0u8KTpJvM01qK84gq4fxfIB
 v8hWmTNwYsTP2jC+ONoY4WPMa2HbfUKFKaiuOqK0QeGh8spGoY2X4Xh8K/f3ewX2SWiT
 kOxp53tq7ILfV1XjTWFQuXhZdWiUf3lcyW0fGs+iqcB2aPrNezFdvuPW50hdd+F1fyq/
 wtMOh9LtMvnAlKRaj3+DitlX8nqtdiSB7zh9/AF04UQcBA22qpTpuczj7lLF8wiRC8mx
 w5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783610079; x=1784214879;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VJXGxjFftP2hvdaDSiYqsQcwixNn6xCYSya2BvDjxWI=;
 b=L4pi/uB75FJ1F8jzjKieYlkNdyezhXfGUaud+L1Fhq/H4wfvJkhB344E2kqrJVWnkT
 BXziZXDLMgiFZWFUto66XUkTaNzNTamRHH/8yUGTq6TYk0vNkg7hVce1P2nEJmifcIPo
 ZvgIdL+K1pyaox8XDZ8vS/w8Nw1aYE+y8aBaUVpTKkYSJUKwsbAAyLQ2IhKWZfnPstgD
 7LPjGWFhiJjm1Vn+u8w8MbX5z8a4Linh5acPKq+0Re+zyTUCuVsWjLYNAFX2qTxk4Xmq
 7uFoBHVo+VzOBfzPM17LvrkZgXbeHq4uG/Y1JDXmTVHQLlKhbW5xCZU6lDvdgooNeV1E
 nzUw==
X-Gm-Message-State: AOJu0YzwWuUINwRFlcEg4PWg9ADh2sn0J0OvDUAAtPvWnJopHDqp/4X0
 /IkxdjcwOn3GWPE85w1DU7tBQgImuIaLtgZmzjEEkM4rcfJu5Y/gx8eoowpSJgru9/Ll1xuO4ph
 5v3v/kY45UMSIiHiSZaFtEaJJVMQ03qEs0jwinupPIRe0cpXv/V2mOfWF
X-Gm-Gg: AfdE7cndoyd9GUv4Fyp3srAySQ9lUlE6l5E45JcnkTn1Q/l7IOAixlhh9uke5vcSfLI
 Fvoue/nyNEk0N58gFTMyxOr0xvEil8prlmAZPhWgf70lUgpUkbjOuUEqhJWaVb0dgfa29vbXa0M
 j7pi76CLpHzB9gnb+kip2vITPdYBLsV1b/lkrzh+4wYnD7V5h0mI9bhW+0+ptJj327e+lUZ6t/H
 CRzxhDlz0LL31PvmEOhW2AcVlQ6IkJrhWxDzqSZLQbuC6+QwpKKJZvypZ4ank74H+oN3OWwsACw
 yaZ/NzEWA2UYNXKirtv790m9OI8wSykNW9jEXMwjiIegEQCdbeYYoZh9xRM8mFP1dDvxAJ/3G2A
 kO13obGCirA8n7u2upm0ShWHJ5I6PDaI+
X-Received: by 2002:a05:6402:360b:b0:698:aa8c:c15e with SMTP id
 4fb4d7f45d1cf-69ab449db4cmr3167433a12.25.1783610079314; 
 Thu, 09 Jul 2026 08:14:39 -0700 (PDT)
X-Received: by 2002:a05:6402:360b:b0:698:aa8c:c15e with SMTP id
 4fb4d7f45d1cf-69ab449db4cmr3167414a12.25.1783610078831; 
 Thu, 09 Jul 2026 08:14:38 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69aa6dba523sm4100549a12.0.2026.07.09.08.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 08:14:38 -0700 (PDT)
Date: Thu, 9 Jul 2026 11:14:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Amit Shah <amit@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH] hw/virtio: return NULL from qemu_get_virtqueue_element()
 on invalid state
Message-ID: <20260709111257-mutt-send-email-mst@kernel.org>
References: <20260709100644.1878369-1-lvivier@redhat.com>
 <20260709083651-mutt-send-email-mst@kernel.org>
 <2fe112be-4caf-47cb-b554-57ebaa1d76fd@redhat.com>
 <20260709101334-mutt-send-email-mst@kernel.org>
 <4b070c93-d5e8-4e22-abd0-e28003a3d9ce@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b070c93-d5e8-4e22-abd0-e28003a3d9ce@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jul 09, 2026 at 05:01:04PM +0200, Laurent Vivier wrote:
> On 7/9/26 16:15, Michael S. Tsirkin wrote:
> > On Thu, Jul 09, 2026 at 03:24:31PM +0200, Laurent Vivier wrote:
> > > On 7/9/26 14:40, Michael S. Tsirkin wrote:
> > > > On Thu, Jul 09, 2026 at 12:06:44PM +0200, Laurent Vivier wrote:
> > > > > qemu_get_virtqueue_element() uses assert() to check that the in_num
> > > > > and out_num fields deserialized from the migration stream do not
> > > > > exceed VIRTQUEUE_MAX_SIZE. A crafted migration stream can set these
> > > > > fields to invalid values, hitting the assertion and aborting the
> > > > > destination QEMU process.
> > > > > 
> > > > > Replace the assertions with a bounds check that returns NULL on
> > > > > failure. Update all callers (virtio-serial-bus, virtio-blk,
> > > > > virtio-scsi) to handle the NULL return and fail the migration
> > > > > gracefully.
> > > > > 
> > > > > Cc: qemu-stable@nongnu.org
> > > > > Fixes: 6bdc21c050a2 ("virtio: fix up max size checks")
> > > > > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3802
> > > > > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > > > > ---
> > > > >    hw/block/virtio-blk.c       |  4 ++++
> > > > >    hw/char/virtio-serial-bus.c |  3 +++
> > > > >    hw/scsi/virtio-scsi.c       |  4 ++++
> > > > >    hw/virtio/virtio.c          | 11 ++++-------
> > > > >    4 files changed, 15 insertions(+), 7 deletions(-)
> > > > > 
> > > > > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > > > > index 6b92066aff4c..42c0f2553f18 100644
> > > > > --- a/hw/block/virtio-blk.c
> > > > > +++ b/hw/block/virtio-blk.c
> > > > > @@ -1384,6 +1384,10 @@ static int virtio_blk_load_device(VirtIODevice *vdev, QEMUFile *f,
> > > > >            }
> > > > >            req = qemu_get_virtqueue_element(vdev, f, sizeof(VirtIOBlockReq));
> > > > > +        if (!req) {
> > > > > +            return -EINVAL;
> > > > > +        }
> > > > > +
> > > > >            virtio_blk_init_request(s, virtio_get_queue(vdev, vq_idx), req);
> > > > >            WITH_QEMU_LOCK_GUARD(&s->rq_lock) {
> > > > > diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> > > > > index c1973f0248fc..879df158608a 100644
> > > > > --- a/hw/char/virtio-serial-bus.c
> > > > > +++ b/hw/char/virtio-serial-bus.c
> > > > > @@ -763,6 +763,9 @@ static int fetch_active_ports_list(QEMUFile *f,
> > > > >                port->elem =
> > > > >                    qemu_get_virtqueue_element(vdev, f, sizeof(VirtQueueElement));
> > > > > +            if (!port->elem) {
> > > > > +                return -EINVAL;
> > > > > +            }
> > > > >                /*
> > > > >                 *  Port was throttled on source machine.  Let's
> > > > > diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> > > > > index 6c7376801190..8dd0b88a30c4 100644
> > > > > --- a/hw/scsi/virtio-scsi.c
> > > > > +++ b/hw/scsi/virtio-scsi.c
> > > > > @@ -274,6 +274,10 @@ static void *virtio_scsi_load_request(QEMUFile *f, SCSIRequest *sreq)
> > > > >        assert(n < vs->conf.num_queues);
> > > > 
> > > > 
> > > > I mean just above this we have this assert.
> > > 
> > > Sure, I can fix that too.
> > > 
> > > > 
> > > > 
> > > > If you are really want to be nicer about handling
> > > > malformed input, pls do this systematically, not just
> > > > at random places for no apparent reason.
> > > 
> > > I don't do this randomly for no apparent reason, see
> > > https://gitlab.com/qemu-project/qemu/-/issues/3802
> > 
> > I am not blaming you, sorry if it sounded like it.
> > But this is not coming from any customers (how can it)
> > the fact that someone decided to fuzz our migration
> > stream and triggered a specific assert *is* random and it does not
> > mean we will now go and try to focus on the specific things
> > that triggered in the specific test.
> 
> I agree, but I fix them to avoid to have hundreds of duplicates in the
> future.

whoever reports this in the future  will get exactly the same
response. either fix them all in some reasonably
defined subsystem or we are not bothering.

> And I do as simple as possible to avoid to spend too much time on
> them.
> 
> Thanks,
> Laurent
> 
> > 
> > 
> > > But I'm going to check if I can remove more assert() in the migration path.
> > > 
> > > Thanks,
> > > Laurent
> > > 
> > > > 
> > > > 
> > > > >        req = qemu_get_virtqueue_element(vdev, f,
> > > > >                                         sizeof(VirtIOSCSIReq) + vs->cdb_size);
> > > > > +    if (!req) {
> > > > > +        return NULL;
> > > > > +    }
> > > > > +
> > > > >        virtio_scsi_init_req(s, vs->cmd_vqs[n], req);
> > > > >        if (virtio_scsi_parse_req(req, sizeof(VirtIOSCSICmdReq) + vs->cdb_size,
> > > > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > > > index f4d86a365530..7bccfdde33e7 100644
> > > > > --- a/hw/virtio/virtio.c
> > > > > +++ b/hw/virtio/virtio.c
> > > > > @@ -2167,13 +2167,10 @@ void *qemu_get_virtqueue_element(VirtIODevice *vdev, QEMUFile *f, size_t sz)
> > > > >        qemu_get_buffer(f, (uint8_t *)&data, sizeof(VirtQueueElementOld));
> > > > > -    /* TODO: teach all callers that this can fail, and return failure instead
> > > > > -     * of asserting here.
> > > > > -     * This is just one thing (there are probably more) that must be
> > > > > -     * fixed before we can allow NDEBUG compilation.
> > > > > -     */
> > > > > -    assert(ARRAY_SIZE(data.in_addr) >= data.in_num);
> > > > > -    assert(ARRAY_SIZE(data.out_addr) >= data.out_num);
> > > > > +    if (data.in_num > ARRAY_SIZE(data.in_addr) ||
> > > > > +        data.out_num > ARRAY_SIZE(data.out_addr)) {
> > > > > +        return NULL;
> > > > > +    }
> > > > >        elem = virtqueue_alloc_element(sz, data.out_num, data.in_num);
> > > > >        elem->index = data.index;
> > > > > -- 
> > > > > 2.54.0
> > > > 
> > 


