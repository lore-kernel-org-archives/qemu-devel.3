Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2BAC4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 11:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXfl5-0007lw-Pl; Wed, 07 Feb 2024 06:06:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rXfl4-0007lR-Hn
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 06:06:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rXfl2-0000v0-BW
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 06:06:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707303983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=onzvHqehOeLH37FhLwUIVlg1QeGLite3zjQAkveZCTM=;
 b=St1gxe96ukzeAAu4WNzL8OdOr3OgKBPo/Xh3RoiFVr0rkG/dwp45JJegQTO0s5qdUv1EFM
 XfYLK8hvBY3AcWTpG2pp6APrrBFyt7b8wgNW5tQU/xTglMGMhDzCRKuvhjo83XrO9nny3V
 XUasMo1GInt+O1L4JcyIb3ryztTyfEw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-To5tPv36OE-sQM_zu5iuhQ-1; Wed, 07 Feb 2024 06:06:22 -0500
X-MC-Unique: To5tPv36OE-sQM_zu5iuhQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a3120029877so164298766b.1
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 03:06:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707303980; x=1707908780;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=onzvHqehOeLH37FhLwUIVlg1QeGLite3zjQAkveZCTM=;
 b=cKky/iq20PMAHuZAtHoq5cmWc15Q3qE52Xkzpz/OTmm6T7EEWc0qxHqvWeTW8dFAR0
 3zOyHiU4sShvR7GYfLZs04Vf+IrsditmJOS3WMKrrX9mgD/i7FfsQEHfUnn/sv4ZtlQv
 uMb8GhGanYpTk+hqCS6jgFtdO1h8l++TgZwVonYZ0gp1x40lt4VYnP8phj5QAEIMJBgr
 uZVk5azbwH0QXY204veCMic+xJIPSX7GUjP/LITHGZC9zPXxgz0N0NupU1zgrLfACbkq
 C71kiQADi/khznb1P/p2SGDuVZ/RWaDSOSVFAtk71jvnAfivWDnTPdSMLLfl66wXnwhw
 JF+w==
X-Gm-Message-State: AOJu0YwkwZaCXAxYFAtp+6sH16UcpwFAERYJ/dSzDv3sKTW495bmsPXy
 6uPKiHgYLW8o295JFqpWnJrmZNVx0HnHbttp1Qm3ddQiTkHoZQtZGLG/AI6ne8AzF1BFkHM+to1
 Gwd6Dk20lBGyhQiQhKpSgOEAmm9jlAXnF2/aoIvc25OZDXc4kEdbj
X-Received: by 2002:a17:907:7e96:b0:a38:929d:b70b with SMTP id
 qb22-20020a1709077e9600b00a38929db70bmr483500ejc.22.1707303980655; 
 Wed, 07 Feb 2024 03:06:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgbfGP9YiznB4zybd2GypY3Ssm5gXz7L6Cu8pdjHMZNpFa2Jx7Zrhq6bHpGqHgaPjEq1LLVg==
X-Received: by 2002:a17:907:7e96:b0:a38:929d:b70b with SMTP id
 qb22-20020a1709077e9600b00a38929db70bmr483478ejc.22.1707303980294; 
 Wed, 07 Feb 2024 03:06:20 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVdPmpYh8/Nj1LNiUM7ugl0zE0eIN8IoNhZgPbU+YeVpD5P0QxsJ9fmHU4axvSPLXARiU1TWVP0rc8pbcWGkjd173mFRz71mtV50iZvsReMUrJkbPx/iPjWFZJnb1MEvdE76TmOT0vnIuuTa/UqAhj28OrLjDJ6FfbRBK3SkArq7PvkL0s=
Received: from sgarzare-redhat (host-87-12-25-87.business.telecomitalia.it.
 [87.12.25.87]) by smtp.gmail.com with ESMTPSA id
 st10-20020a170907c08a00b00a380b14c127sm641305ejc.42.2024.02.07.03.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 03:06:19 -0800 (PST)
Date: Wed, 7 Feb 2024 12:06:15 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>, qemu-block@nongnu.org, 
 mst@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: Re: [PATCH] vdpa-dev: Fix initialisation order to restore VDUSE
 compatibility
Message-ID: <lybxibwylp76bcapqwohmamtt2zv26woavafnvfzz6jurpiymd@yfxrpxrumw6v>
References: <20240202132521.32714-1-kwolf@redhat.com>
 <CAJaqyWfMETO=C6oBj2VVo+CZ=kNe-aJSYja0WpLDLbFQV5sTnA@mail.gmail.com>
 <ZcDnXpE_IGkSVzTu@redhat.com>
 <CAJaqyWenrGrE2Bjqw+TUy=WoMV56=4dY4rz5waN=rfrk7iAR2Q@mail.gmail.com>
 <ZcNZDgopo3WBhsyk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZcNZDgopo3WBhsyk@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Feb 07, 2024 at 11:18:54AM +0100, Kevin Wolf wrote:
>Am 06.02.2024 um 17:44 hat Eugenio Perez Martin geschrieben:
>> On Mon, Feb 5, 2024 at 2:49 PM Kevin Wolf <kwolf@redhat.com> wrote:
>> >
>> > Am 05.02.2024 um 13:22 hat Eugenio Perez Martin geschrieben:
>> > > On Fri, Feb 2, 2024 at 2:25 PM Kevin Wolf <kwolf@redhat.com> wrote:
>> > > >
>> > > > VDUSE requires that virtqueues are first enabled before the DRIVER_OK
>> > > > status flag is set; with the current API of the kernel module, it is
>> > > > impossible to enable the opposite order in our block export code because
>> > > > userspace is not notified when a virtqueue is enabled.
>> > > >
>> > > > This requirement also mathces the normal initialisation order as done by
>> > > > the generic vhost code in QEMU. However, commit 6c482547 accidentally
>> > > > changed the order for vdpa-dev and broke access to VDUSE devices with
>> > > > this.
>> > > >
>> > > > This changes vdpa-dev to use the normal order again and use the standard
>> > > > vhost callback .vhost_set_vring_enable for this. VDUSE devices can be
>> > > > used with vdpa-dev again after this fix.
>> > > >
>> > > > Cc: qemu-stable@nongnu.org
>> > > > Fixes: 6c4825476a4351530bcac17abab72295b75ffe98
>> > > > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> > > > ---
>> > > >  hw/virtio/vdpa-dev.c   |  5 +----
>> > > >  hw/virtio/vhost-vdpa.c | 17 +++++++++++++++++
>> > > >  2 files changed, 18 insertions(+), 4 deletions(-)
>> > > >
>> > > > diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
>> > > > index eb9ecea83b..13e87f06f6 100644
>> > > > --- a/hw/virtio/vdpa-dev.c
>> > > > +++ b/hw/virtio/vdpa-dev.c
>> > > > @@ -253,14 +253,11 @@ static int vhost_vdpa_device_start(VirtIODevice *vdev, Error **errp)
>> > > >
>> > > >      s->dev.acked_features = vdev->guest_features;
>> > > >
>> > > > -    ret = vhost_dev_start(&s->dev, vdev, false);
>> > > > +    ret = vhost_dev_start(&s->dev, vdev, true);
>> > > >      if (ret < 0) {
>> > > >          error_setg_errno(errp, -ret, "Error starting vhost");
>> > > >          goto err_guest_notifiers;
>> > > >      }
>> > > > -    for (i = 0; i < s->dev.nvqs; ++i) {
>> > > > -        vhost_vdpa_set_vring_ready(&s->vdpa, i);
>> > > > -    }
>> > > >      s->started = true;
>> > > >
>> > > >      /*
>> > > > diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>> > > > index 3a43beb312..c4574d56c5 100644
>> > > > --- a/hw/virtio/vhost-vdpa.c
>> > > > +++ b/hw/virtio/vhost-vdpa.c
>> > > > @@ -904,6 +904,22 @@ int vhost_vdpa_set_vring_ready(struct vhost_vdpa *v, unsigned idx)
>> > > >      return r;
>> > > >  }
>> > > >
>> > > > +static int vhost_vdpa_set_vring_enable(struct vhost_dev *dev, int enable)
>> > > > +{
>> > > > +    struct vhost_vdpa *v = dev->opaque;
>> > > > +    unsigned int i;
>> > > > +    int ret;
>> > > > +
>> > > > +    for (i = 0; i < dev->nvqs; ++i) {
>> > > > +        ret = vhost_vdpa_set_vring_ready(v, i);
>> > > > +        if (ret < 0) {
>> > > > +            return ret;
>> > > > +        }
>> > > > +    }
>> > > > +
>> > > > +    return 0;
>> > > > +}
>> > > > +
>> > > >  static int vhost_vdpa_set_config_call(struct vhost_dev *dev,
>> > > >                                         int fd)
>> > > >  {
>> > > > @@ -1524,6 +1540,7 @@ const VhostOps vdpa_ops = {
>> > > >          .vhost_set_features = vhost_vdpa_set_features,
>> > > >          .vhost_reset_device = vhost_vdpa_reset_device,
>> > > >          .vhost_get_vq_index = vhost_vdpa_get_vq_index,
>> > > > +        .vhost_set_vring_enable = vhost_vdpa_set_vring_enable,
>> > > >          .vhost_get_config  = vhost_vdpa_get_config,
>> > > >          .vhost_set_config = vhost_vdpa_set_config,
>> > > >          .vhost_requires_shm_log = NULL,
>> > >
>> > > vhost-vdpa net enables CVQ before dataplane ones to configure all the
>> > > device in the destination of a live migration. To go back again to
>> > > this callback would cause the device to enable the dataplane before
>> > > virtqueues are configured again.
>> >
>> > Not that it makes a difference, but I don't think it would actually be
>> > going back. Even before your commit 6c482547, we were not making use of
>> > the generic callback but just called the function in a slightly
>> > different place (but less different than after commit 6c482547).
>> >
>> > But anyway... Why don't the other vhost backend need the same for
>> > vhost-net then? Do they just not support live migration?
>>
>> They don't support control virtqueue. More specifically, control
>> virtqueue is handled directly in QEMU.
>
>So the network device already has to special case vdpa instead of using
>the same code for all vhost backends? :-/
>
>> > I don't know the code well enough to say where the problem is, but if
>> > vhost-vdpa networking code relies on the usual vhost operations not
>> > being implemented and bypasses VhostOps to replace it, that sounds like
>> > a design problem to me.
>>
>> I don't follow this. What vhost operation is expected not to be implemented?
>
>You were concerned about implementing .vhost_set_vring_enable in
>vdpa_ops like my patch does. So it seems that the networking code
>requires that it is not implemented?
>
>On the other hand, for vhost-vdpa, the callback seems to be called in
>exactly the right place where virtqueues need to be enabled, like for
>other vhost devices.
>
>> > Maybe VhostOps needs a new operation to enable
>> > just a single virtqueue that can be used by the networking code instead?
>> >
>> > > How does VDUSE userspace knows how many queues should enable? Can't
>> > > the kernel perform the necessary actions after DRIVER_OK, like
>> > > configuring the kick etc?
>> >
>> > Not sure if I understand the question. The vdpa kernel interface always
>> > enables individual queues, so the VDUSE userspace will enable whatever
>> > queues it was asked to enable. The only restriction is that the queues
>> > need to be enabled before setting DRIVER_OK.
>> >
>> > The interface that enables all virtqueues at once seems to be just
>> > .vhost_set_vring_enable in QEMU.
>>
>> It enables all virtqueues of the same vhost device in QEMU, but QEMU
>> creates one vhost_dev per each vhost-net virtqueue pair and another
>> one for CVQ. This goes back to the time where mq vhost-kernel net
>> devices were implemented by mergin many tap devices. net/vhost-vdpa.c
>> only enables the last one, which corresponds to CVQ, and then enables
>> the rest once all messages have been received.
>
>So it's less about the granularity of .vhost_set_vring_enable, which
>would just be right, but about the order in which it is called for the
>different vhost_devs?
>
>Can we influence the order in another way than just not implementing the
>callback at all? I think net specific weirdness should be contained in
>the net implementation and not affect generic vdpa code.
>
>> On the other hand, .vhost_set_vring_enable is also used for queue
>> reset (vhost_net_virtqueue_reset and vhost_net_virtqueue_restart). In
>> other words, it is called after the set DRIVER_OK. I guess it is fine
>> for VDUSE as long as it does not offer vring reset capabilities, but
>> future wise should we start going in that direction?
>
>I don't actually know VDUSE very well, but that would probably make
>sense.
>
>Though for the moment, I just tried to simply attach a VDUSE device and
>failed, so I'm just trying to fix the regression from your commit.
>
>> But kernels without VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK should be
>> supported, right. Maybe we can add vhost_vdpa_set_vring_enable and
>> call vhost_dev_start with vrings parameters conditional to the feature
>> flag? That way the caller can enable it later or just enable all the
>> rings altogether.
>
>Which specific caller do you mean here?
>
>For vdpa-dev, I don't see any problem with just passing vrings=true
>unconditionally. That is clearly the least problematic order even if
>another order may in theory be allowed by the spec.
>
>For vhost_net, I don't know. As far as I am concerned, there is no
>reason to change its call and it could continue to pass vrings=false.
>
>So vhost_dev_start() seems entirely unproblematic.
>
>The only part that changes for net is that vhost_set_vring_enable() now
>does something where it didn't do anything before. If that is a problem
>for vdpa based network code, maybe we can just special case vdpa there
>to not call vhost_ops->vhost_set_vring_enable? (Despite its name, it's a
>network specific function; it should probably be called something like
>vhost_net_set_vring_enable.)
>
>With something like the below, net shouldn't see any difference any
>more, right? (Happy to add a comment before it if you write it for me.)

+1 for this.
I proposed something similar, but I prefer your early return which is 
clearer:
https://lore.kernel.org/qemu-devel/xlk2pspyo4gwguxopm6k534nzjei5y3m6zbh2l6dagmuwpamtk@dtkgca6yppce/

Thanks,
Stefano

>
>Kevin
>
>diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
>index e8e1661646..fb6d13bd69 100644
>--- a/hw/net/vhost_net.c
>+++ b/hw/net/vhost_net.c
>@@ -543,6 +543,10 @@ int vhost_set_vring_enable(NetClientState *nc, int enable)
>
>     nc->vring_enable = enable;
>
>+    if (nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
>+        return 0;
>+    }
>+
>     if (vhost_ops && vhost_ops->vhost_set_vring_enable) {
>         return vhost_ops->vhost_set_vring_enable(&net->dev, enable);
>     }
>


