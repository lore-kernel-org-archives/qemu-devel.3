Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA39C48297
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 03:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXYRf-0008JX-7f; Tue, 06 Feb 2024 22:17:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rXYRd-0008J4-7O
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 22:17:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rXYRa-00068v-Ar
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 22:17:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707275868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+MyVM6e3skz+aOnUg/RRvZJqnNMp7BfkRW9DUx/5z0E=;
 b=O5TE7OTdvIcGD/YrpNo3MzwgN5+QaZhXJTknObUKrgSldiQvYlaao2WsV/Q5QGBI/SCh1Y
 7yYNdHsHgulxsFibAAbNvMpEhueR5ES3bkeunvuGJnCZ50Qf4+d83CL77klfpQHiDFeo5C
 rsBIqAeXZ8JZjtT87mnuxQz9J3GNfEQ=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-PQMCxmjdMK6ed24PYIvTNw-1; Tue, 06 Feb 2024 22:17:46 -0500
X-MC-Unique: PQMCxmjdMK6ed24PYIvTNw-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-59a6d6c51c4so179322eaf.2
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 19:17:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707275866; x=1707880666;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+MyVM6e3skz+aOnUg/RRvZJqnNMp7BfkRW9DUx/5z0E=;
 b=N4rHX/V3U4JFsLSUrZPUpjOSAkUXHtcMmCUKMJtWMHIPMDkcZxjrnHx14gLh53C5DT
 dLpqlr5wjVCk16RqCCHbOTgcQVVpSv0TFVBWMbNwzA4G8F13B8aYGPKOtu2ew4Txntzh
 Agr2u33FcYAo5DBC2qpEugx/4nN2lPxnYkTFTqvfsaZWUcy/1LB37FjGtUUf4b5G3EI4
 x/A3IYpAJu6J4yjBqkV1Bs2z+kCnu0qSBDGK5KWmWO6nSSXzETuo2k7GBNlM5rvaUS3M
 QHdBxWPkaR253QWzLx6KRpf6Ts0DdSresTc3GmM6/iKiSxIi2FFRIpYuNvMU14NNX12m
 VEiQ==
X-Gm-Message-State: AOJu0YxOK2e3zS6A88qrxN6T8iaHAX8j+Q4MdItRbOP5yM3C+BE6+9mp
 GrK/c0lc2pfloI+bUSIvfa6jckwhnvR6BqHs48XWLGXChLhOUnmyRx3oFn1TE7IIP0bhzlY6mwL
 JKVu4KenSZa6SG48IxYte2dFp/OLLU61hZ2EPh4UaHK7JrwIrYxrOLU5k65EU5jzxhe/+bPPlcx
 MwZReUZLcrVdeKXD+5PtVhNDJy984=
X-Received: by 2002:a05:6358:7f02:b0:178:951b:d1a6 with SMTP id
 p2-20020a0563587f0200b00178951bd1a6mr1674265rwn.25.1707275865768; 
 Tue, 06 Feb 2024 19:17:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyx7k2nqWJ7QPi8FUZ9rJF6U5p1gYyffbpvAU0RW90ynTJH7Hc6kU0J9Z/Cp0ck3dbAIkJI5U9yd4IM6CqavI=
X-Received: by 2002:a05:6358:7f02:b0:178:951b:d1a6 with SMTP id
 p2-20020a0563587f0200b00178951bd1a6mr1674252rwn.25.1707275865480; Tue, 06 Feb
 2024 19:17:45 -0800 (PST)
MIME-Version: 1.0
References: <20240202132521.32714-1-kwolf@redhat.com>
 <zmopxf5zt6m36nfujntn72idlinm7qmx23wjvwiazmq4b75lsa@a2omit34pjif>
 <CACGkMEvLpg+nPgHsE_6stFM1OGXbHpuE=j7XLwt_YxpxhWJgZw@mail.gmail.com>
 <nvk6n7ln3ryga2ww4a6evbprauptzcn7uz34ar3uecbxjfre2z@msikqqpuk2vh>
In-Reply-To: <nvk6n7ln3ryga2ww4a6evbprauptzcn7uz34ar3uecbxjfre2z@msikqqpuk2vh>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 7 Feb 2024 11:17:34 +0800
Message-ID: <CACGkMEtODf_NGGa-XbyDMM7=z6CsCkazV9A-4z8W7oCOnu-Ybg@mail.gmail.com>
Subject: Re: Re: [PATCH] vdpa-dev: Fix initialisation order to restore VDUSE
 compatibility
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 qemu-block@nongnu.org, mst@redhat.com, qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org, Cindy Lu <lulu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, Feb 6, 2024 at 4:31=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> On Tue, Feb 06, 2024 at 10:47:40AM +0800, Jason Wang wrote:
> >On Mon, Feb 5, 2024 at 6:51=E2=80=AFPM Stefano Garzarella <sgarzare@redh=
at.com> wrote:
> >>
> >> On Fri, Feb 02, 2024 at 02:25:21PM +0100, Kevin Wolf wrote:
> >> >VDUSE requires that virtqueues are first enabled before the DRIVER_OK
> >> >status flag is set; with the current API of the kernel module, it is
> >> >impossible to enable the opposite order in our block export code beca=
use
> >> >userspace is not notified when a virtqueue is enabled.
> >
> >Did this mean virtio-blk will enable a virtqueue after DRIVER_OK?
>
> It's not specific to virtio-blk, but to the generic vdpa device we have
> in QEMU (i.e. vhost-vdpa-device). Yep, after commit
> 6c4825476a4351530bcac17abab72295b75ffe98, virtqueues are enabled after
> DRIVER_OK.

Right.

>
> >Sepc is not clear about this and that's why we introduce
> >VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK.
>
> Ah, I didn't know about this new feature. So after commit
> 6c4825476a4351530bcac17abab72295b75ffe98 the vhost-vdpa-device is not
> complying with the specification, right?

Kind of, but as stated, it's just because spec is unclear about the
behaviour. There's a chance that spec will explicitly support it in
the future.

>
> >
> >>
> >> Yeah, IMHO the VDUSE protocol is missing a VDUSE_SET_VQ_READY message,
> >
> >I think you meant when VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is
> >negotiated.
>
> At this point yes. But if VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is not
> negotiated, should we return an error in vhost-vdpa kernel module if
> VHOST_VDPA_SET_VRING_ENABLE is called when DRIVER_OK is already set?

I'm not sure if this can break some setups or not. It might be better
to leave it as is?

Without VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK, we don't know if
parent support vq_ready after driver_ok.
With VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK, we know parent support
vq_ready after driver_ok.

>
> >If this is truth, it seems a little more complicated, for
> >example the get_backend_features needs to be forward to the userspace?
>
> I'm not understanding, don't we already have VHOST_GET_BACKEND_FEATURES
> for this? Or do you mean userspace on the VDUSE side?

Yes, since in this case the parent is in the userspace, there's no way
for VDUSE to know if user space supports vq_ready after driver_ok or
not.

As you may have noticed, we don't have a message for vq_ready which
implies that vq_ready after driver_ok can't be supported.

>
> >This seems suboptimal to implement this in the spec first and then we
> >can leverage the features. Or we can have another parameter for the
> >ioctl that creates the vduse device.
>
> I got a little lost, though in vhost-user, the device can always expect
> a vring_enable/disable, so I thought it was not complicated in VDUSE.

Yes, the problem is assuming we have a message for vq_ready, there
could be  a "legacy" userspace that doesn't support that.  So in that
case, VDUSE needs to know if the userspace parent can support that or
not.

>
> >
> >> I'll start another thread about that, but in the meantime I agree that
> >> we should fix QEMU since we need to work properly with old kernels as
> >> well.
> >>
> >> >
> >> >This requirement also mathces the normal initialisation order as done=
 by
> >> >the generic vhost code in QEMU. However, commit 6c482547 accidentally
> >> >changed the order for vdpa-dev and broke access to VDUSE devices with
> >> >this.
> >> >
> >> >This changes vdpa-dev to use the normal order again and use the stand=
ard
> >> >vhost callback .vhost_set_vring_enable for this. VDUSE devices can be
> >> >used with vdpa-dev again after this fix.
> >>
> >> I like this approach and the patch LGTM, but I'm a bit worried about
> >> this function in hw/net/vhost_net.c:
> >>
> >>      int vhost_set_vring_enable(NetClientState *nc, int enable)
> >>      {
> >>          VHostNetState *net =3D get_vhost_net(nc);
> >>          const VhostOps *vhost_ops =3D net->dev.vhost_ops;
> >>
> >>          nc->vring_enable =3D enable;
> >>
> >>          if (vhost_ops && vhost_ops->vhost_set_vring_enable) {
> >>              return vhost_ops->vhost_set_vring_enable(&net->dev, enabl=
e);
> >>          }
> >>
> >>          return 0;
> >>      }
> >>
> >> @Eugenio, @Jason, should we change some things there if vhost-vdpa
> >> implements the vhost_set_vring_enable callback?
> >
> >Eugenio may know more, I remember we need to enable cvq first for
> >shadow virtqueue to restore some states.
> >
> >>
> >> Do you remember why we didn't implement it from the beginning?
> >
> >It seems the vrings parameter is introduced after vhost-vdpa is
> >implemented.
>
> Sorry, I mean why we didn't implement the vhost_set_vring_enable
> callback for vhost-vdpa from the beginning.

Adding Cindy who writes those codes for more thoughts.

Thanks

>
> Thanks,
> Stefano
>


