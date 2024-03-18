Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757ACC54E69
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 09:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm8tk-0000vu-9H; Mon, 18 Mar 2024 05:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rm8tZ-0000rA-AT
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 05:03:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rm8tV-00037h-QH
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 05:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710752574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9tOgKpmHkyfWytKd+Q8ncCWaAwK28lg30+Gi433Srq4=;
 b=O4nVHPRc7VORwmWgcEW/LVoCZEGJZ5Tg4nfecQWmMug3jQi6qaMZKB4FCgB7nPcN85uS+L
 glw6CRdO65XS3QG9F1ZXGAIjZzcgGDH/ihtjN/spMr0rntu5eQxGGsewH+PxdqYttyoQ6i
 Tjk6so3dkUwdf2R6UelYmOlLemc/ccA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-nouBcWwtM1GNjQqiww1PQg-1; Mon, 18 Mar 2024 05:02:50 -0400
X-MC-Unique: nouBcWwtM1GNjQqiww1PQg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-41401f598cfso11527755e9.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 02:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710752570; x=1711357370;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9tOgKpmHkyfWytKd+Q8ncCWaAwK28lg30+Gi433Srq4=;
 b=sFqEPsdInVEJK1rd01fU188287/WQoJoLDOPZwDxwFJWHc+fYKq3uFkZZFuwb6qUt7
 Y+QpxbfkSjDnUPWrWoZBMgJaA+0C/iFegnt3Q7mKwqN9wurEx8YNT3e2dtJeHjq+T7kj
 vvhJJjnUHQQaJnRaUN9PAkwrCU+sU2BQw6KMpgEmOEN4Vtu+cD0+6ejKiWMR0wCbTFzJ
 RzVWYor3Y+I9DSAhou1jiUTfGH/4XhRqUELNxyJz4CkZstL0W243BCyf/M4u82YG5Q97
 s7vr1odZoDGGk1Yh7T+MMj2HrFotFE6teDggW7FORRt6B6GxRToiAUJFabL0Pnxvsg/m
 W1FA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwIjRqfKLOFqRFdl162sEkElnTjaIlbWEhoJLquatJYZNfeeCJXpBNmcwzaLy1Ostlsi5ibWJDBp/s90FqpCre+ZFzVxM=
X-Gm-Message-State: AOJu0Yzw6u7dtxO1ohVLams6WkYM7vH4DAcQjJ/aSX3O3y3S964cUqOI
 8cLyd7HMcNsdeASz0G9PKIYK1hua6TY6UmckSUJ4ESam265f76cczMsrSfD5I/Bi1PX3gBIv/LJ
 +AcQeQQJtyprF1zy0ech4nFe8LMaPbUrhleEdWvo+Vaqv4PyOrg7X
X-Received: by 2002:a05:600c:444e:b0:414:9d1:d67b with SMTP id
 v14-20020a05600c444e00b0041409d1d67bmr2871629wmn.36.1710752569701; 
 Mon, 18 Mar 2024 02:02:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSEb/YmOkOOTAkkXnTXH814g9+VQh0geknBxT+wnlBH5GsYqn4o5TNXoHNPsfoUohZBAB7aA==
X-Received: by 2002:a05:600c:444e:b0:414:9d1:d67b with SMTP id
 v14-20020a05600c444e00b0041409d1d67bmr2871605wmn.36.1710752569138; 
 Mon, 18 Mar 2024 02:02:49 -0700 (PDT)
Received: from redhat.com ([2.52.5.113]) by smtp.gmail.com with ESMTPSA id
 p10-20020a05600c1d8a00b004145cecb7bcsm151190wms.45.2024.03.18.02.02.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 02:02:48 -0700 (PDT)
Date: Mon, 18 Mar 2024 05:02:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 sgarzare@redhat.com, eperezma@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: Re: [PATCH for-9.0 v3] vdpa-dev: Fix initialisation order to restore
 VDUSE compatibility
Message-ID: <20240318050212-mutt-send-email-mst@kernel.org>
References: <20240315155949.86066-1-kwolf@redhat.com>
 <CACGkMEvuu4rkgZr7sBFwXztZLHdamBKML++6cvA+GDKyGDGibA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvuu4rkgZr7sBFwXztZLHdamBKML++6cvA+GDKyGDGibA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.316,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Mar 18, 2024 at 12:31:26PM +0800, Jason Wang wrote:
> On Fri, Mar 15, 2024 at 11:59 PM Kevin Wolf <kwolf@redhat.com> wrote:
> >
> > VDUSE requires that virtqueues are first enabled before the DRIVER_OK
> > status flag is set; with the current API of the kernel module, it is
> > impossible to enable the opposite order in our block export code because
> > userspace is not notified when a virtqueue is enabled.
> >
> > This requirement also mathces the normal initialisation order as done by
> > the generic vhost code in QEMU. However, commit 6c482547 accidentally
> > changed the order for vdpa-dev and broke access to VDUSE devices with
> > this.
> >
> > This changes vdpa-dev to use the normal order again and use the standard
> > vhost callback .vhost_set_vring_enable for this. VDUSE devices can be
> > used with vdpa-dev again after this fix.
> >
> > vhost_net intentionally avoided enabling the vrings for vdpa and does
> > this manually later while it does enable them for other vhost backends.
> > Reflect this in the vhost_net code and return early for vdpa, so that
> > the behaviour doesn't change for this device.
> >
> > Cc: qemu-stable@nongnu.org
> > Fixes: 6c4825476a4351530bcac17abab72295b75ffe98
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> > v2:
> > - Actually make use of the @enable parameter
> > - Change vhost_net to preserve the current behaviour
> >
> > v3:
> > - Updated trace point [Stefano]
> > - Fixed typo in comment [Stefano]
> >
> >  hw/net/vhost_net.c     | 10 ++++++++++
> >  hw/virtio/vdpa-dev.c   |  5 +----
> >  hw/virtio/vhost-vdpa.c | 29 ++++++++++++++++++++++++++---
> >  hw/virtio/vhost.c      |  8 +++++++-
> >  hw/virtio/trace-events |  2 +-
> >  5 files changed, 45 insertions(+), 9 deletions(-)
> >
> > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> > index e8e1661646..fd1a93701a 100644
> > --- a/hw/net/vhost_net.c
> > +++ b/hw/net/vhost_net.c
> > @@ -541,6 +541,16 @@ int vhost_set_vring_enable(NetClientState *nc, int enable)
> >      VHostNetState *net = get_vhost_net(nc);
> >      const VhostOps *vhost_ops = net->dev.vhost_ops;
> >
> > +    /*
> > +     * vhost-vdpa network devices need to enable dataplane virtqueues after
> > +     * DRIVER_OK, so they can recover device state before starting dataplane.
> > +     * Because of that, we don't enable virtqueues here and leave it to
> > +     * net/vhost-vdpa.c.
> > +     */
> > +    if (nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
> > +        return 0;
> > +    }
> 
> I think we need some inputs from Eugenio, this is only needed for
> shadow virtqueue during live migration but not other cases.
> 
> Thanks


Yes I think we had a backend flag for this, right? Eugenio can you
comment please?


