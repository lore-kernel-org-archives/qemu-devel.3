Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65E8C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 18:06:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTQZg-0006Dn-RQ; Fri, 26 Jan 2024 13:05:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rTQZc-0006Bb-0n
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 13:05:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rTQZZ-0000r4-1A
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 13:05:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706292299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kMrslG5j5QHplQBk27RtOh9cymH80feak23grIoDvgk=;
 b=HJ6vzl8xX0CS4+Hx99t8xL8Z5ZCo2Ew6cgEUgAkeuL74G3T+WX6++9g4A2GtL7vQ8d1RFY
 aNug4JBFatM6jK/bUJS+et145iP0nqX5HI05jtkiUfUYrPSaGivPdMyTcSBkFFQ9EOc4Z6
 +XMNPlJZWtSqd6lzPSQ31bKrXmOTNjY=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-RfGmawDSPa28ciPgPwKUqw-1; Fri, 26 Jan 2024 13:04:54 -0500
X-MC-Unique: RfGmawDSPa28ciPgPwKUqw-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-5997417c351so642394eaf.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 10:04:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706292293; x=1706897093;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kMrslG5j5QHplQBk27RtOh9cymH80feak23grIoDvgk=;
 b=VGKU22M53AUeb30G4juetz6xWxKOMD3LpyWdif/sWnu3HtyrJtGFCeysp7WIFYn+GC
 upZeVMUZ5Ez21+2cJbhWORanlI1CIFZZG/wpcd+eVpn3BR65h07R8TS3dFNtm71RUAjQ
 M1h9O/I97fe977m7AYqaOK2BDLSJgHAIhpf82VkRWyxLUv0Sm3hV4TdraL6Wbb3wbf9d
 DD/dBGfGNItvLGyyXR/9JMMSX7sTkW5pkievRZYbJv2lgHyEdR4eowNpVjC62JfEiR0O
 noA0uhn0yRjxzXWPWkAYONRJvuWjgISNeX5H+81mMol4PhCbKLT46/1jcCt2/f9MRlI4
 JJ3w==
X-Gm-Message-State: AOJu0YxwFBT5lSA37lCc1oeEy1CWLPs6qlvPdripR9GpGFvYI6+51KVd
 Uq+c+ObjQuJoCwD5QxmZcl3GPbzAg8SdOSvq01c41vhRdwU8sUHe19SvMJAzuVFHXQZ14QJs9Ac
 IvQw+fQEAIaM7PKed3NegDtpT58pQHuaPJ7VG7JG84NKCjaItZIgK6LpdTCm6UVKYN9tZhkGru6
 T+HKj7LAAHbQrW1j6KfH5OhHCMomU=
X-Received: by 2002:a05:6358:224b:b0:176:aab7:ed19 with SMTP id
 i11-20020a056358224b00b00176aab7ed19mr94414rwc.64.1706292293293; 
 Fri, 26 Jan 2024 10:04:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwpffqInESmaOdIMleGG7gTo3a5U+09FwDyZYAO488yZ+7Z7XKGcY5+vnjp6ETQCb6wCoko1m5pxS8opxvNZE=
X-Received: by 2002:a05:6358:224b:b0:176:aab7:ed19 with SMTP id
 i11-20020a056358224b00b00176aab7ed19mr94396rwc.64.1706292292889; Fri, 26 Jan
 2024 10:04:52 -0800 (PST)
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
In-Reply-To: <SN4PR13MB5727A733210FBF7A3B72DDE886792@SN4PR13MB5727.namprd13.prod.outlook.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 26 Jan 2024 19:04:16 +0100
Message-ID: <CAJaqyWdx+33QrtCkMDAMG=1au7jKCgw4bcmgC+zgEcXaeW=Fbg@mail.gmail.com>
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
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.313,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jan 26, 2024 at 9:59=E2=80=AFAM Wentao Jia <wentao.jia@nephogine.co=
m> wrote:
>
> Hi, Eugenio
>
> Thanks for you comments, Our team has made new change about the patch,
> these features in hw/virtio/virtio.h:DEFINE_VIRTIO_COMMON_FEATURES,
> they are turned off by default , and can be turned on from at qemu comman=
d line
> Do you have comments about this patch?
>

If the commandline is set to =3Don on an emulated device, we're back at
square one: The guest will try to use these features in the emulator
device and the kick or the descriptors exchange will fail.

Maybe we can propose their implementation in the emulated devices on
Google Summer of Code? Would you be interested in mentoring this? I
can help with it for sure.

On the other hand I'm not sure about the benefits of notification_data
for emulated devices or even vhost-kernel. My understanding is that
the data written cannot be passed with the eventfd, so QEMU should
fully vmexit to the iowrite (which probably is slower in the event of
a lot of notifications). Unless we can transmit the avail idx, the
device must read the avail ring anyway.

So the question for MST / Jason is, Is this enough justification to
maybe fail the initialization of virtio-net-pci devices with backends
different than vhost-user of vdpa if notification_data=3Don? Should this
be backed by profiled data?

In my opinion the emulated device should implement it and be =3Doff by
default, just for testing the driver implementation. But maybe it can
be done on top after the early failure?

Thanks!

> Best Regards
> Wentao Jia
>
>
> VIRTIO_F_IN_ORDER and VIRTIO_F_NOTIFICATION_DATA feature are important fe=
ature
> for dpdk vdpa packets transmitting performance, add these features at vho=
st-user
> front-end to negotiation with backend.
>
> In this patch, these features are turned off by default, turn on the feat=
ures at
> qemu command line.
> ... notification_data=3Don,in_order=3Don ...
>
> Signed-off-by: Wentao Jia <wentao.jia@corigine.com>
> Signed-off-by: Xinying Yu <xinying.yu@corigine.com>
> Signed-off-by: Kyle Xu <zhenbing.xu@corigine.com>
> Reviewed-by:   Shujing Dong <shujing.dong@corigine.com>
> Reviewed-by:   Rick Zhong <zhaoyong.zhong@corigine.com>
> ---
>  hw/core/machine.c          | 2 ++
>  hw/net/vhost_net.c         | 2 ++
>  include/hw/virtio/virtio.h | 6 +++++-
>  3 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index fb5afdcae4..40489c23a6 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -40,6 +40,7 @@ GlobalProperty hw_compat_8_1[] =3D {
>      { "ramfb", "x-migrate", "off" },
>      { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" },
>      { "igb", "x-pcie-flr-init", "off" },
> +    { "virtio-device", "notification_data", "off"},
>  };
>  const size_t hw_compat_8_1_len =3D G_N_ELEMENTS(hw_compat_8_1);
>
> @@ -65,6 +66,7 @@ GlobalProperty hw_compat_7_1[] =3D {
>      { "virtio-rng-pci", "vectors", "0" },
>      { "virtio-rng-pci-transitional", "vectors", "0" },
>      { "virtio-rng-pci-non-transitional", "vectors", "0" },
> +    { "virtio-device", "in_order", "off"},
>  };
>  const size_t hw_compat_7_1_len =3D G_N_ELEMENTS(hw_compat_7_1);
>
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index e8e1661646..211ca859a6 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -76,6 +76,8 @@ static const int user_feature_bits[] =3D {
>      VIRTIO_F_IOMMU_PLATFORM,
>      VIRTIO_F_RING_PACKED,
>      VIRTIO_F_RING_RESET,
> +    VIRTIO_F_IN_ORDER,
> +    VIRTIO_F_NOTIFICATION_DATA,
>      VIRTIO_NET_F_RSS,
>      VIRTIO_NET_F_HASH_REPORT,
>      VIRTIO_NET_F_GUEST_USO4,
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index c8f72850bc..e6aa10f01b 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -368,7 +368,11 @@ typedef struct VirtIORNGConf VirtIORNGConf;
>      DEFINE_PROP_BIT64("packed", _state, _field, \
>                        VIRTIO_F_RING_PACKED, false), \
>      DEFINE_PROP_BIT64("queue_reset", _state, _field, \
> -                      VIRTIO_F_RING_RESET, true)
> +                      VIRTIO_F_RING_RESET, true), \
> +    DEFINE_PROP_BIT64("in_order", _state, _field, \
> +                      VIRTIO_F_IN_ORDER, false), \
> +    DEFINE_PROP_BIT64("notification_data", _state, _field, \
> +                      VIRTIO_F_NOTIFICATION_DATA, false)
>
>  hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
>  bool virtio_queue_enabled_legacy(VirtIODevice *vdev, int n);
> --
> 2.31.1
>
> -----Original Message-----
> From: Rick Zhong <zhaoyong.zhong@nephogine.com>
> Sent: Friday, January 19, 2024 6:39 PM
> To: Eugenio Perez Martin <eperezma@redhat.com>; Wentao Jia <wentao.jia@ne=
phogine.com>
> Cc: qemu-devel@nongnu.org; mst@redhat.com; Jason Wang <jasowang@redhat.co=
m>; Peter Xu <peterx@redhat.com>; Guo Zhi <qtxuning1999@sjtu.edu.cn>
> Subject: =E5=9B=9E=E5=A4=8D: FW: [PATCH] vhost-user: add VIRTIO_F_IN_ORDE=
R and VIRTIO_F_NOTIFICATION_DATA feature
>
> Hi Eugenio,
>
> Thanks for your comments. Very helpful. Wentao and I will discuss and get=
 back to you later.
>
> Also welcome for any comments from other guys.
>
> Best Regards,
> Rick Zhong
>
> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Eugenio Perez Martin <eperezma@redhat.com>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2024=E5=B9=B41=E6=9C=8819=E6=97=A5 =
18:26
> =E6=94=B6=E4=BB=B6=E4=BA=BA: Wentao Jia <wentao.jia@nephogine.com>
> =E6=8A=84=E9=80=81: qemu-devel@nongnu.org; mst@redhat.com; Rick Zhong <zh=
aoyong.zhong@nephogine.com>; Jason Wang <jasowang@redhat.com>; Peter Xu <pe=
terx@redhat.com>; Guo Zhi <qtxuning1999@sjtu.edu.cn>
> =E4=B8=BB=E9=A2=98: Re: FW: [PATCH] vhost-user: add VIRTIO_F_IN_ORDER and=
 VIRTIO_F_NOTIFICATION_DATA feature
>
> On Fri, Jan 19, 2024 at 7:42=E2=80=AFAM Wentao Jia <wentao.jia@nephogine.=
com> wrote:
> >
> >
> > VIRTIO_F_IN_ORDER and VIRTIO_F_NOTIFICATION_DATA feature are important
> > feature for dpdk vdpa packets transmitting performance, add the 2
> > features at vhost-user front-end to negotiation with backend.
> >
> > Signed-off-by: Kyle Xu <zhenbing.xu@corigine.com>
> > Signed-off-by: Wentao Jia <wentao.jia@corigine.com>
> > Reviewed-by:   Xinying Yu <xinying.yu@corigine.com>
> > Reviewed-by:   Shujing Dong <shujing.dong@corigine.com>
> > Reviewed-by:   Rick Zhong <zhaoyong.zhong@corigine.com>
> > ---
> >  hw/core/machine.c   | 2 ++
> >  hw/net/vhost_net.c  | 2 ++
> >  hw/net/virtio-net.c | 4 ++++
> >  3 files changed, 8 insertions(+)
> >
> > diff --git a/hw/core/machine.c b/hw/core/machine.c index
> > fb5afdcae4..e620f5e7d0 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -40,6 +40,7 @@ GlobalProperty hw_compat_8_1[] =3D {
> >      { "ramfb", "x-migrate", "off" },
> >      { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" },
> >      { "igb", "x-pcie-flr-init", "off" },
> > +    { TYPE_VIRTIO_NET, "notification_data", "off"},
> >  };
>
> Assuming the default "true" in
> hw/net/virtio-net.c:virtio_net_properties is valid, this needs to be appe=
nded to the array of the QEMU version that introduced the property in the v=
irtio_net_properties array, not the one that imported the macro from the ke=
rnel. This allows QEMU to know that old versions have these features disabl=
ed although the default set in hw/net/virtio-net.c:virtio_net_properties is=
 true when migrating from / to these versions.
>
> You can check that this is added properly by migrating from / to a previo=
us version of QEMU, with the combinations of true and false.
>
> You have an example in [1] with blk devices multiqueue. CCing Peter Xu as=
 he knows more than me about this.
>
> This is very easy to miss when adding new features. Somebody who knows pe=
rl should add a test in checkpath.pl similar to the warning "added, moved o=
r deleted file(s), does MAINTAINERS need updating?" when virtio properties =
are modified :).
>
> >  const size_t hw_compat_8_1_len =3D G_N_ELEMENTS(hw_compat_8_1);
> >
> > @@ -65,6 +66,7 @@ GlobalProperty hw_compat_7_1[] =3D {
> >      { "virtio-rng-pci", "vectors", "0" },
> >      { "virtio-rng-pci-transitional", "vectors", "0" },
> >      { "virtio-rng-pci-non-transitional", "vectors", "0" },
> > +    { TYPE_VIRTIO_NET, "in_order", "off"},
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
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c index
> > 7a2846fa1c..dc0a028934 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -3949,6 +3949,10 @@ static Property virtio_net_properties[] =3D {
> >                        VIRTIO_NET_F_GUEST_USO6, true),
> >      DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
> >                        VIRTIO_NET_F_HOST_USO, true),
> > +    DEFINE_PROP_BIT64("in_order", VirtIONet, host_features,
> > +                      VIRTIO_F_IN_ORDER, true),
> > +    DEFINE_PROP_BIT64("notification_data", VirtIONet, host_features,
> > +                      VIRTIO_F_NOTIFICATION_DATA, true),
>
> This default=3Dtrue is wrong, and makes emulated devices show these featu=
res as available when they're not. You can test it by running qemu with the=
 parameters:
>
> -netdev tap,id=3Dhostnet0,vhost=3Doff -device virtio-net-pci,netdev=3Dhos=
tnet0,...
>
> The emulated device must support both features before making them tunnabl=
es.
>
> On the other hand, all kinds of virtio devices can use in_order and notif=
ication_data, so they should be in include/hw/virtio/virtio.h:DEFINE_VIRTIO=
_COMMON_FEATURES. But not all of them benefit from in_order. One example of=
 this is virtio-blk. It is usual that requests are completed out of order b=
y the backend device, so my impression is that in_order will hurt its perfo=
rmance.
> I've never profiled it though, so I may be wrong :).
>
> Long story short: Maybe in_order should be false by default, and enabled =
just in virtio-net?
>
> You can see previous attempts of implementing this feature in qemu in [2]=
. CCing Guo too, as I don't know if he plans to continue this work soon.
>
> Please let me know if you need any help with these!
>
> Thanks!
>
> [1] https://www.qemu.org/docs/master/devel/migration/compatibility.html#h=
ow-backwards-compatibility-works
> [2] https://lists.gnu.org/archive/html/qemu-devel/2022-08/msg02772.html
>
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >
> > --
> >
>


