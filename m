Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F50EC47DDF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 12:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVVmn-00068x-3v; Thu, 01 Feb 2024 07:03:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rVVmV-00065J-0A
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 07:03:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rVVmI-0004nm-4k
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 07:02:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706788950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=odcahu30JQWnu2zc4TTv97TmBYB9Pwc/ptfXXtmvFC0=;
 b=WqvHcTwBQE3YJMsYEPlYM6hAdw3k7Ixcd+eZRz7KGIu0rfFRNfdQu53NtspZQj6/GqHsHt
 8jOYDDeJNMkOzlVsPxbl0RIfx6J7NrPWYFw6WlA0Cyxbq0t0tFP/O5fpJqhq91p9LabbWb
 /PvUxWJUr1UoH3z/DFv/TSc8L6xuua8=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-KkE3EGbEOR-qUbgN7y834A-1; Thu, 01 Feb 2024 07:02:28 -0500
X-MC-Unique: KkE3EGbEOR-qUbgN7y834A-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-dc6cd10fd94so1453289276.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 04:02:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706788948; x=1707393748;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=odcahu30JQWnu2zc4TTv97TmBYB9Pwc/ptfXXtmvFC0=;
 b=buYO7kTTR1ZpHdls45+yPyMgT4NbAw78Yaa+dI+pR67vUoxyL9o/k57LA9tqS6U41B
 i7JGp42NS12tzsLP5mbF2BciOpKlkv/gVID9ekPAcjUZJ4d/5PR3R7epoEjjric3Tn0w
 BsO+O3o+L/sgk6NQYrw3xNeYroKO1TKagckaROESkz4paHq1LxuQtE6DCGhtVas+PuIt
 Mk4s9v/k0TZxVQUEeImcWGuiAA0h6Qu1/2p+v0OZUNdDL6H5wMPJU7QwpHKdzqmysFBo
 D/7SdvMH6IrHG0o8NdPshtRZ4XZno6v4frfd2vqKZEa5zrGnUhapoOsF3L9yh0RMw16h
 TvYw==
X-Gm-Message-State: AOJu0Yx3V0ypGWnuPrZp1HGy8DLqtMyiasTLp7W+98umaX3JvN504nnj
 JtZcaJ6NrF4YR09TAEKKCZByP8ul49aD0YdauGyTGS5yb6nBhrBhYGJ/I4TXdA0gHqgEKfZD0YE
 xTqS6zSYVcE5NLTzuWMNXudDuGMw39vL8zgkTjGAt/1r5YTCDTVwseDQPAKXeyOq+dO1ZdKhT7S
 FyZn+OzQ7m28yN+bKuFzfc54hqUbs=
X-Received: by 2002:a25:bcd0:0:b0:dc2:1ccd:e711 with SMTP id
 l16-20020a25bcd0000000b00dc21ccde711mr4351211ybm.21.1706788946843; 
 Thu, 01 Feb 2024 04:02:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvHA0opBruKxspzhASE0AGIM0SGUVmLUrsRYbOCV/FfC+kpGLoS1J8l+/ZJTVSP8hb4v7TvWKfKOiB2O7b5nc=
X-Received: by 2002:a25:bcd0:0:b0:dc2:1ccd:e711 with SMTP id
 l16-20020a25bcd0000000b00dc21ccde711mr4351097ybm.21.1706788945009; Thu, 01
 Feb 2024 04:02:25 -0800 (PST)
MIME-Version: 1.0
References: <SN4PR13MB5727A538887598415C5A37D28681A@SN4PR13MB5727.namprd13.prod.outlook.com>
 <SN4PR13MB5727D7B4E7CC91345135A5058661A@SN4PR13MB5727.namprd13.prod.outlook.com>
 <CACGkMEvwanHfheCMo-gDjzx1DrX51AMtoaYJ9PcE0yYmZdA+Uw@mail.gmail.com>
 <SN4PR13MB5727A90B141E383127F1E25D8661A@SN4PR13MB5727.namprd13.prod.outlook.com>
 <SN4PR13MB572773EF8D25A2E2C5AE48608661A@SN4PR13MB5727.namprd13.prod.outlook.com>
 <SN4PR13MB57274870E6BBFC76749E8D96866F2@SN4PR13MB5727.namprd13.prod.outlook.com>
 <CACGkMEu6X2L-eawwsy_pE1mVVDU7V=Qe_51YrK16W-kKu4BGxA@mail.gmail.com>
 <SN4PR13MB572738F10FAE449DDBD735D686732@SN4PR13MB5727.namprd13.prod.outlook.com>
 <CACGkMEtHQHmhBAF6WguUSHr+iFMmOjvTshqpGzkvE=QtkgVVPA@mail.gmail.com>
 <SN4PR13MB5727AF7CB6E6CF563B618F1386732@SN4PR13MB5727.namprd13.prod.outlook.com>
 <SN4PR13MB5727D5A7AD34F7169E2A236F86702@SN4PR13MB5727.namprd13.prod.outlook.com>
 <CAJaqyWc2P6iHrG9dR2X9YC=P7dw4=Y2RwRkr5H81hkj6ej_5hA@mail.gmail.com>
 <DM6PR13MB3988D0E01FE275F72E53397295702@DM6PR13MB3988.namprd13.prod.outlook.com>
 <SN4PR13MB5727A733210FBF7A3B72DDE886792@SN4PR13MB5727.namprd13.prod.outlook.com>
 <CAJaqyWdx+33QrtCkMDAMG=1au7jKCgw4bcmgC+zgEcXaeW=Fbg@mail.gmail.com>
 <SN4PR13MB5727E433825757E3E326EB9F86432@SN4PR13MB5727.namprd13.prod.outlook.com>
In-Reply-To: <SN4PR13MB5727E433825757E3E326EB9F86432@SN4PR13MB5727.namprd13.prod.outlook.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 1 Feb 2024 13:01:48 +0100
Message-ID: <CAJaqyWfE8RV0w5U33r127RpS5ZfVeYcqmBX827uhrYMp8DTE4A@mail.gmail.com>
Subject: Re: FW: [PATCH] vhost-user: add VIRTIO_F_IN_ORDER and
 VIRTIO_F_NOTIFICATION_DATA feature
To: Wentao Jia <wentao.jia@nephogine.com>
Cc: Rick Zhong <zhaoyong.zhong@nephogine.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Guo Zhi <qtxuning1999@sjtu.edu.cn>, 
 Xinying Yu <xinying.yu@nephogine.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
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

On Thu, Feb 1, 2024 at 11:48=E2=80=AFAM Wentao Jia <wentao.jia@nephogine.co=
m> wrote:
>
> Hi, Eugenio
>
> Thanks for you comments
>
> It is a dilemma, our team mainly work on smartNIC vDPA, features implemen=
tation in the QEMU emulated devices is a certain workload for us.

That's understandable.

> I have a proposal, clear these features except vhost, it will not affect =
emulated devices, do you agree the change?
>

I'm not sure. Personally I think the best is to set them off by
default and raise an error if they are on and there is no vhost
backend, so QEMU knows the reason why the guest does not see the
feature flags. But maybe a warning is enough.

MST, Jason, what do you think?

> partial codes for clear these features
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 7a2846fa1c..f4cf8b74da 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -822,6 +822,8 @@ static uint64_t virtio_net_get_features(VirtIODevice =
*vdev, uint64_t features,
>      }
>
>      if (!get_vhost_net(nc->peer)) {
> +        virtio_clear_feature(&features, VIRTIO_F_IN_ORDER);
> +        virtio_clear_feature(&features, VIRTIO_F_NOTIFICATION_DATA);
>          return features;
>      }
>
> Best Regards
> Wentao Jia
>
> -----Original Message-----
> From: Eugenio Perez Martin <eperezma@redhat.com>
> Sent: Saturday, January 27, 2024 2:04 AM
> To: Wentao Jia <wentao.jia@nephogine.com>
> Cc: Rick Zhong <zhaoyong.zhong@nephogine.com>; qemu-devel@nongnu.org; mst=
@redhat.com; Jason Wang <jasowang@redhat.com>; Peter Xu <peterx@redhat.com>=
; Guo Zhi <qtxuning1999@sjtu.edu.cn>; Xinying Yu <xinying.yu@nephogine.com>
> Subject: Re: FW: [PATCH] vhost-user: add VIRTIO_F_IN_ORDER and VIRTIO_F_N=
OTIFICATION_DATA feature
>
> On Fri, Jan 26, 2024 at 9:59=E2=80=AFAM Wentao Jia <wentao.jia@nephogine.=
com> wrote:
> >
> > Hi, Eugenio
> >
> > Thanks for you comments, Our team has made new change about the patch,
> > these features in hw/virtio/virtio.h:DEFINE_VIRTIO_COMMON_FEATURES,
> > they are turned off by default , and can be turned on from at qemu
> > command line Do you have comments about this patch?
> >
>
> If the commandline is set to =3Don on an emulated device, we're back at s=
quare one: The guest will try to use these features in the emulator device =
and the kick or the descriptors exchange will fail.
>
> Maybe we can propose their implementation in the emulated devices on Goog=
le Summer of Code? Would you be interested in mentoring this? I can help wi=
th it for sure.
>
> On the other hand I'm not sure about the benefits of notification_data fo=
r emulated devices or even vhost-kernel. My understanding is that the data =
written cannot be passed with the eventfd, so QEMU should fully vmexit to t=
he iowrite (which probably is slower in the event of a lot of notifications=
). Unless we can transmit the avail idx, the device must read the avail rin=
g anyway.
>
> So the question for MST / Jason is, Is this enough justification to maybe=
 fail the initialization of virtio-net-pci devices with backends different =
than vhost-user of vdpa if notification_data=3Don? Should this be backed by=
 profiled data?
>
> In my opinion the emulated device should implement it and be =3Doff by de=
fault, just for testing the driver implementation. But maybe it can be done=
 on top after the early failure?
>
> Thanks!
>
> > Best Regards
> > Wentao Jia
> >
> >
> > VIRTIO_F_IN_ORDER and VIRTIO_F_NOTIFICATION_DATA feature are important
> > feature for dpdk vdpa packets transmitting performance, add these
> > features at vhost-user front-end to negotiation with backend.
> >
> > In this patch, these features are turned off by default, turn on the
> > features at qemu command line.
> > ... notification_data=3Don,in_order=3Don ...
> >
> > Signed-off-by: Wentao Jia <wentao.jia@corigine.com>
> > Signed-off-by: Xinying Yu <xinying.yu@corigine.com>
> > Signed-off-by: Kyle Xu <zhenbing.xu@corigine.com>
> > Reviewed-by:   Shujing Dong <shujing.dong@corigine.com>
> > Reviewed-by:   Rick Zhong <zhaoyong.zhong@corigine.com>
> > ---
> >  hw/core/machine.c          | 2 ++
> >  hw/net/vhost_net.c         | 2 ++
> >  include/hw/virtio/virtio.h | 6 +++++-
> >  3 files changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/core/machine.c b/hw/core/machine.c index
> > fb5afdcae4..40489c23a6 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -40,6 +40,7 @@ GlobalProperty hw_compat_8_1[] =3D {
> >      { "ramfb", "x-migrate", "off" },
> >      { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" },
> >      { "igb", "x-pcie-flr-init", "off" },
> > +    { "virtio-device", "notification_data", "off"},
> >  };
> >  const size_t hw_compat_8_1_len =3D G_N_ELEMENTS(hw_compat_8_1);
> >
> > @@ -65,6 +66,7 @@ GlobalProperty hw_compat_7_1[] =3D {
> >      { "virtio-rng-pci", "vectors", "0" },
> >      { "virtio-rng-pci-transitional", "vectors", "0" },
> >      { "virtio-rng-pci-non-transitional", "vectors", "0" },
> > +    { "virtio-device", "in_order", "off"},
> >  };
> >  const size_t hw_compat_7_1_len =3D G_N_ELEMENTS(hw_compat_7_1);
> >
> > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c index
> > e8e1661646..211ca859a6 100644
> > --- a/hw/net/vhost_net.c
> > +++ b/hw/net/vhost_net.c
> > @@ -76,6 +76,8 @@ static const int user_feature_bits[] =3D {
> >      VIRTIO_F_IOMMU_PLATFORM,
> >      VIRTIO_F_RING_PACKED,
> >      VIRTIO_F_RING_RESET,
> > +    VIRTIO_F_IN_ORDER,
> > +    VIRTIO_F_NOTIFICATION_DATA,
> >      VIRTIO_NET_F_RSS,
> >      VIRTIO_NET_F_HASH_REPORT,
> >      VIRTIO_NET_F_GUEST_USO4,
> > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > index c8f72850bc..e6aa10f01b 100644
> > --- a/include/hw/virtio/virtio.h
> > +++ b/include/hw/virtio/virtio.h
> > @@ -368,7 +368,11 @@ typedef struct VirtIORNGConf VirtIORNGConf;
> >      DEFINE_PROP_BIT64("packed", _state, _field, \
> >                        VIRTIO_F_RING_PACKED, false), \
> >      DEFINE_PROP_BIT64("queue_reset", _state, _field, \
> > -                      VIRTIO_F_RING_RESET, true)
> > +                      VIRTIO_F_RING_RESET, true), \
> > +    DEFINE_PROP_BIT64("in_order", _state, _field, \
> > +                      VIRTIO_F_IN_ORDER, false), \
> > +    DEFINE_PROP_BIT64("notification_data", _state, _field, \
> > +                      VIRTIO_F_NOTIFICATION_DATA, false)
> >
> >  hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);  bool
> > virtio_queue_enabled_legacy(VirtIODevice *vdev, int n);
> > --
> > 2.31.1
> >
> > -----Original Message-----
> > From: Rick Zhong <zhaoyong.zhong@nephogine.com>
> > Sent: Friday, January 19, 2024 6:39 PM
> > To: Eugenio Perez Martin <eperezma@redhat.com>; Wentao Jia
> > <wentao.jia@nephogine.com>
> > Cc: qemu-devel@nongnu.org; mst@redhat.com; Jason Wang
> > <jasowang@redhat.com>; Peter Xu <peterx@redhat.com>; Guo Zhi
> > <qtxuning1999@sjtu.edu.cn>
> > Subject: =E5=9B=9E=E5=A4=8D: FW: [PATCH] vhost-user: add VIRTIO_F_IN_OR=
DER and
> > VIRTIO_F_NOTIFICATION_DATA feature
> >
> > Hi Eugenio,
> >
> > Thanks for your comments. Very helpful. Wentao and I will discuss and g=
et back to you later.
> >
> > Also welcome for any comments from other guys.
> >
> > Best Regards,
> > Rick Zhong
> >
> > -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Eugenio Perez Martin <eperezma@redhat.com>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2024=E5=B9=B41=E6=9C=8819=E6=97=
=A5 18:26
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: Wentao Jia <wentao.jia@nephogine.com>
> > =E6=8A=84=E9=80=81: qemu-devel@nongnu.org; mst@redhat.com; Rick Zhong
> > <zhaoyong.zhong@nephogine.com>; Jason Wang <jasowang@redhat.com>;
> > Peter Xu <peterx@redhat.com>; Guo Zhi <qtxuning1999@sjtu.edu.cn>
> > =E4=B8=BB=E9=A2=98: Re: FW: [PATCH] vhost-user: add VIRTIO_F_IN_ORDER a=
nd
> > VIRTIO_F_NOTIFICATION_DATA feature
> >
> > On Fri, Jan 19, 2024 at 7:42=E2=80=AFAM Wentao Jia <wentao.jia@nephogin=
e.com> wrote:
> > >
> > >
> > > VIRTIO_F_IN_ORDER and VIRTIO_F_NOTIFICATION_DATA feature are
> > > important feature for dpdk vdpa packets transmitting performance,
> > > add the 2 features at vhost-user front-end to negotiation with backen=
d.
> > >
> > > Signed-off-by: Kyle Xu <zhenbing.xu@corigine.com>
> > > Signed-off-by: Wentao Jia <wentao.jia@corigine.com>
> > > Reviewed-by:   Xinying Yu <xinying.yu@corigine.com>
> > > Reviewed-by:   Shujing Dong <shujing.dong@corigine.com>
> > > Reviewed-by:   Rick Zhong <zhaoyong.zhong@corigine.com>
> > > ---
> > >  hw/core/machine.c   | 2 ++
> > >  hw/net/vhost_net.c  | 2 ++
> > >  hw/net/virtio-net.c | 4 ++++
> > >  3 files changed, 8 insertions(+)
> > >
> > > diff --git a/hw/core/machine.c b/hw/core/machine.c index
> > > fb5afdcae4..e620f5e7d0 100644
> > > --- a/hw/core/machine.c
> > > +++ b/hw/core/machine.c
> > > @@ -40,6 +40,7 @@ GlobalProperty hw_compat_8_1[] =3D {
> > >      { "ramfb", "x-migrate", "off" },
> > >      { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" },
> > >      { "igb", "x-pcie-flr-init", "off" },
> > > +    { TYPE_VIRTIO_NET, "notification_data", "off"},
> > >  };
> >
> > Assuming the default "true" in
> > hw/net/virtio-net.c:virtio_net_properties is valid, this needs to be ap=
pended to the array of the QEMU version that introduced the property in the=
 virtio_net_properties array, not the one that imported the macro from the =
kernel. This allows QEMU to know that old versions have these features disa=
bled although the default set in hw/net/virtio-net.c:virtio_net_properties =
is true when migrating from / to these versions.
> >
> > You can check that this is added properly by migrating from / to a prev=
ious version of QEMU, with the combinations of true and false.
> >
> > You have an example in [1] with blk devices multiqueue. CCing Peter Xu =
as he knows more than me about this.
> >
> > This is very easy to miss when adding new features. Somebody who knows =
perl should add a test in checkpath.pl similar to the warning "added, moved=
 or deleted file(s), does MAINTAINERS need updating?" when virtio propertie=
s are modified :).
> >
> > >  const size_t hw_compat_8_1_len =3D G_N_ELEMENTS(hw_compat_8_1);
> > >
> > > @@ -65,6 +66,7 @@ GlobalProperty hw_compat_7_1[] =3D {
> > >      { "virtio-rng-pci", "vectors", "0" },
> > >      { "virtio-rng-pci-transitional", "vectors", "0" },
> > >      { "virtio-rng-pci-non-transitional", "vectors", "0" },
> > > +    { TYPE_VIRTIO_NET, "in_order", "off"},
> > >  };
> > >  const size_t hw_compat_7_1_len =3D G_N_ELEMENTS(hw_compat_7_1);
> > >
> > > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c index
> > > e8e1661646..211ca859a6 100644
> > > --- a/hw/net/vhost_net.c
> > > +++ b/hw/net/vhost_net.c
> > > @@ -76,6 +76,8 @@ static const int user_feature_bits[] =3D {
> > >      VIRTIO_F_IOMMU_PLATFORM,
> > >      VIRTIO_F_RING_PACKED,
> > >      VIRTIO_F_RING_RESET,
> > > +    VIRTIO_F_IN_ORDER,
> > > +    VIRTIO_F_NOTIFICATION_DATA,
> > >      VIRTIO_NET_F_RSS,
> > >      VIRTIO_NET_F_HASH_REPORT,
> > >      VIRTIO_NET_F_GUEST_USO4,
> > > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c index
> > > 7a2846fa1c..dc0a028934 100644
> > > --- a/hw/net/virtio-net.c
> > > +++ b/hw/net/virtio-net.c
> > > @@ -3949,6 +3949,10 @@ static Property virtio_net_properties[] =3D {
> > >                        VIRTIO_NET_F_GUEST_USO6, true),
> > >      DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
> > >                        VIRTIO_NET_F_HOST_USO, true),
> > > +    DEFINE_PROP_BIT64("in_order", VirtIONet, host_features,
> > > +                      VIRTIO_F_IN_ORDER, true),
> > > +    DEFINE_PROP_BIT64("notification_data", VirtIONet, host_features,
> > > +                      VIRTIO_F_NOTIFICATION_DATA, true),
> >
> > This default=3Dtrue is wrong, and makes emulated devices show these fea=
tures as available when they're not. You can test it by running qemu with t=
he parameters:
> >
> > -netdev tap,id=3Dhostnet0,vhost=3Doff -device virtio-net-pci,netdev=3Dh=
ostnet0,...
> >
> > The emulated device must support both features before making them tunna=
bles.
> >
> > On the other hand, all kinds of virtio devices can use in_order and not=
ification_data, so they should be in include/hw/virtio/virtio.h:DEFINE_VIRT=
IO_COMMON_FEATURES. But not all of them benefit from in_order. One example =
of this is virtio-blk. It is usual that requests are completed out of order=
 by the backend device, so my impression is that in_order will hurt its per=
formance.
> > I've never profiled it though, so I may be wrong :).
> >
> > Long story short: Maybe in_order should be false by default, and enable=
d just in virtio-net?
> >
> > You can see previous attempts of implementing this feature in qemu in [=
2]. CCing Guo too, as I don't know if he plans to continue this work soon.
> >
> > Please let me know if you need any help with these!
> >
> > Thanks!
> >
> > [1]
> > https://www.qemu.org/docs/master/devel/migration/compatibility.html#ho
> > w-backwards-compatibility-works [2]
> > https://lists.gnu.org/archive/html/qemu-devel/2022-08/msg02772.html
> >
> > >      DEFINE_PROP_END_OF_LIST(),
> > >  };
> > >
> > > --
> > >
> >
>


