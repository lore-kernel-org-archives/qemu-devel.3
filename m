Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E09C47DDF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 12:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVWej-0004P7-PX; Thu, 01 Feb 2024 07:59:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rVWea-0004KV-IR
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 07:58:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rVWeU-0008Ew-PS
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 07:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706792325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9rb3s2tKUnRq3UoX3bYY+IDwr4UlkuwbF86foLjpioQ=;
 b=AewDKHkHFiqANu+Bk7P5DW0YMnSYm+xA2ALtDtLl93qh5dzjw32/ikIZC1On/DycxkmnK1
 8Vg8iURMAnyOCvrBXlqgRHquJNOWK7XmJHiqCT2l9dYanKFch9sqAMkoHWEedk9lG/TXJ4
 6P30rXhanZ71IYHtsHp8tJCk7IrVw+o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-K0GwHxwUPfqeueDDA4-V9A-1; Thu, 01 Feb 2024 07:58:43 -0500
X-MC-Unique: K0GwHxwUPfqeueDDA4-V9A-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-40fba0c4fbbso3871725e9.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 04:58:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706792322; x=1707397122;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9rb3s2tKUnRq3UoX3bYY+IDwr4UlkuwbF86foLjpioQ=;
 b=uLz7/6fYbeFeRI4CfyXqkMkHv3UItbErdtEka/2FW/lGC8zxsQdCIy5PparQ4rsuCL
 sbNvIzGyA/d/8Ff9eLtGJsVDeT0coqSYxOmq2Emw2oFCtS5rGNA/04BhEMlesy9KYwj4
 QQHxTWQvfaGU5ei4y//8udJ4mBRI1UhOLb2ImpA0sl7ZXTO5uGASqzqgDScTyz8/bZba
 0ZftYfRa0HNF0osJomtqQ0aYd/EE9o7vlxafQCt7qBfY9MQLVusQxGRFxzC7VHLbXx0N
 2qNNmSOTX09yJFxvNFR/TGyxfCKL7QuAvepRZFlQszxG+0Gq04/w+FdtCwYmit6TzwTs
 n1kQ==
X-Gm-Message-State: AOJu0YyID3Jh2aI7JO2AMtlWGl4UFQspde32oIMJX1PLHFY6xUG8EfRL
 U2Yve+oJGK1zvDm6zJVdgCR30F/gjiPLD+Xw/i0nFoWZhVjCBskjKyL+oVyUC1mcSPnLmhaQeT6
 8A2+H0dnyIR0SXHAxbmwQqX56EtgHWa8TrlKnu3m5qYBdJWyQRKc8
X-Received: by 2002:a5d:55cb:0:b0:33b:1624:f15d with SMTP id
 i11-20020a5d55cb000000b0033b1624f15dmr1093985wrw.25.1706792322518; 
 Thu, 01 Feb 2024 04:58:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmgX75hULVdBACc4FVRKpQrALfxFgiFurHNAOK7fdFXKugAPNEl0wahxdvA7wlXb7Z8j0oqw==
X-Received: by 2002:a5d:55cb:0:b0:33b:1624:f15d with SMTP id
 i11-20020a5d55cb000000b0033b1624f15dmr1093969wrw.25.1706792322169; 
 Thu, 01 Feb 2024 04:58:42 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUaRo+VVj9XyP1KJ1YbChMBB/nL25s/jYYEK++KR6xi6cxLQqLI8Yh+BAztCWkymdTAUVNMPuQCr6IFkxPlu9mSfyGgTOCbrzOOzYPrqQHNdO9HVolAAmouqIwGpHMb+8DWTe+p7i+2t7Ks0WGIiU5Ml6EyAtWECOj5dXE+cs1xycZA63wIsaWq44A78+1siuVtuUsVlThW614tZxMOgMRSTD1diidZhfdaZUAEtBDnoyuIFU6YFc0SaSPRzchobA==
Received: from redhat.com ([2.52.129.159]) by smtp.gmail.com with ESMTPSA id
 o16-20020a5d4750000000b0033b13922263sm1735375wrs.60.2024.02.01.04.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 04:58:41 -0800 (PST)
Date: Thu, 1 Feb 2024 07:58:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wentao Jia <wentao.jia@nephogine.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>,
 Rick Zhong <zhaoyong.zhong@nephogine.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Jason Wang <jasowang@redhat.com>, Peter Xu <peterx@redhat.com>,
 Guo Zhi <qtxuning1999@sjtu.edu.cn>, Xinying Yu <xinying.yu@nephogine.com>
Subject: Re: FW: [PATCH] vhost-user: add VIRTIO_F_IN_ORDER and
 VIRTIO_F_NOTIFICATION_DATA feature
Message-ID: <20240201075513-mutt-send-email-mst@kernel.org>
References: <CACGkMEu6X2L-eawwsy_pE1mVVDU7V=Qe_51YrK16W-kKu4BGxA@mail.gmail.com>
 <SN4PR13MB572738F10FAE449DDBD735D686732@SN4PR13MB5727.namprd13.prod.outlook.com>
 <CACGkMEtHQHmhBAF6WguUSHr+iFMmOjvTshqpGzkvE=QtkgVVPA@mail.gmail.com>
 <SN4PR13MB5727AF7CB6E6CF563B618F1386732@SN4PR13MB5727.namprd13.prod.outlook.com>
 <SN4PR13MB5727D5A7AD34F7169E2A236F86702@SN4PR13MB5727.namprd13.prod.outlook.com>
 <CAJaqyWc2P6iHrG9dR2X9YC=P7dw4=Y2RwRkr5H81hkj6ej_5hA@mail.gmail.com>
 <DM6PR13MB3988D0E01FE275F72E53397295702@DM6PR13MB3988.namprd13.prod.outlook.com>
 <SN4PR13MB5727A733210FBF7A3B72DDE886792@SN4PR13MB5727.namprd13.prod.outlook.com>
 <CAJaqyWdx+33QrtCkMDAMG=1au7jKCgw4bcmgC+zgEcXaeW=Fbg@mail.gmail.com>
 <SN4PR13MB5727E433825757E3E326EB9F86432@SN4PR13MB5727.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN4PR13MB5727E433825757E3E326EB9F86432@SN4PR13MB5727.namprd13.prod.outlook.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 01, 2024 at 10:47:56AM +0000, Wentao Jia wrote:
> Hi, Eugenio
> 
> Thanks for you comments
> 
> It is a dilemma, our team mainly work on smartNIC vDPA, features
> implementation in the QEMU emulated devices is a certain workload for
> us.

In this case the implementation is mostly trivial I have no idea
why argue about it - just do it.

Implementing it in software will make it possible to e.g. test
the driver without the device. Which is of value even to yourself.
IOW - tough, you want a feature in please make it consumable
by implementing a software fallback.





> I have a proposal, clear these features except vhost, it will not affect emulated devices, do you agree the change?
> 
> partial codes for clear these features
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 7a2846fa1c..f4cf8b74da 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -822,6 +822,8 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
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
> Cc: Rick Zhong <zhaoyong.zhong@nephogine.com>; qemu-devel@nongnu.org; mst@redhat.com; Jason Wang <jasowang@redhat.com>; Peter Xu <peterx@redhat.com>; Guo Zhi <qtxuning1999@sjtu.edu.cn>; Xinying Yu <xinying.yu@nephogine.com>
> Subject: Re: FW: [PATCH] vhost-user: add VIRTIO_F_IN_ORDER and VIRTIO_F_NOTIFICATION_DATA feature
> 
> On Fri, Jan 26, 2024 at 9:59 AM Wentao Jia <wentao.jia@nephogine.com> wrote:
> >
> > Hi, Eugenio
> >
> > Thanks for you comments, Our team has made new change about the patch, 
> > these features in hw/virtio/virtio.h:DEFINE_VIRTIO_COMMON_FEATURES,
> > they are turned off by default , and can be turned on from at qemu 
> > command line Do you have comments about this patch?
> >
> 
> If the commandline is set to =on on an emulated device, we're back at square one: The guest will try to use these features in the emulator device and the kick or the descriptors exchange will fail.
> 
> Maybe we can propose their implementation in the emulated devices on Google Summer of Code? Would you be interested in mentoring this? I can help with it for sure.
> 
> On the other hand I'm not sure about the benefits of notification_data for emulated devices or even vhost-kernel. My understanding is that the data written cannot be passed with the eventfd, so QEMU should fully vmexit to the iowrite (which probably is slower in the event of a lot of notifications). Unless we can transmit the avail idx, the device must read the avail ring anyway.
> 
> So the question for MST / Jason is, Is this enough justification to maybe fail the initialization of virtio-net-pci devices with backends different than vhost-user of vdpa if notification_data=on? Should this be backed by profiled data?
> 
> In my opinion the emulated device should implement it and be =off by default, just for testing the driver implementation. But maybe it can be done on top after the early failure?
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
> > ... notification_data=on,in_order=on ...
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
> > @@ -40,6 +40,7 @@ GlobalProperty hw_compat_8_1[] = {
> >      { "ramfb", "x-migrate", "off" },
> >      { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" },
> >      { "igb", "x-pcie-flr-init", "off" },
> > +    { "virtio-device", "notification_data", "off"},
> >  };
> >  const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
> >
> > @@ -65,6 +66,7 @@ GlobalProperty hw_compat_7_1[] = {
> >      { "virtio-rng-pci", "vectors", "0" },
> >      { "virtio-rng-pci-transitional", "vectors", "0" },
> >      { "virtio-rng-pci-non-transitional", "vectors", "0" },
> > +    { "virtio-device", "in_order", "off"},
> >  };
> >  const size_t hw_compat_7_1_len = G_N_ELEMENTS(hw_compat_7_1);
> >
> > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c index 
> > e8e1661646..211ca859a6 100644
> > --- a/hw/net/vhost_net.c
> > +++ b/hw/net/vhost_net.c
> > @@ -76,6 +76,8 @@ static const int user_feature_bits[] = {
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
> > Subject: 回复: FW: [PATCH] vhost-user: add VIRTIO_F_IN_ORDER and 
> > VIRTIO_F_NOTIFICATION_DATA feature
> >
> > Hi Eugenio,
> >
> > Thanks for your comments. Very helpful. Wentao and I will discuss and get back to you later.
> >
> > Also welcome for any comments from other guys.
> >
> > Best Regards,
> > Rick Zhong
> >
> > -----邮件原件-----
> > 发件人: Eugenio Perez Martin <eperezma@redhat.com>
> > 发送时间: 2024年1月19日 18:26
> > 收件人: Wentao Jia <wentao.jia@nephogine.com>
> > 抄送: qemu-devel@nongnu.org; mst@redhat.com; Rick Zhong 
> > <zhaoyong.zhong@nephogine.com>; Jason Wang <jasowang@redhat.com>; 
> > Peter Xu <peterx@redhat.com>; Guo Zhi <qtxuning1999@sjtu.edu.cn>
> > 主题: Re: FW: [PATCH] vhost-user: add VIRTIO_F_IN_ORDER and 
> > VIRTIO_F_NOTIFICATION_DATA feature
> >
> > On Fri, Jan 19, 2024 at 7:42 AM Wentao Jia <wentao.jia@nephogine.com> wrote:
> > >
> > >
> > > VIRTIO_F_IN_ORDER and VIRTIO_F_NOTIFICATION_DATA feature are 
> > > important feature for dpdk vdpa packets transmitting performance, 
> > > add the 2 features at vhost-user front-end to negotiation with backend.
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
> > > @@ -40,6 +40,7 @@ GlobalProperty hw_compat_8_1[] = {
> > >      { "ramfb", "x-migrate", "off" },
> > >      { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" },
> > >      { "igb", "x-pcie-flr-init", "off" },
> > > +    { TYPE_VIRTIO_NET, "notification_data", "off"},
> > >  };
> >
> > Assuming the default "true" in
> > hw/net/virtio-net.c:virtio_net_properties is valid, this needs to be appended to the array of the QEMU version that introduced the property in the virtio_net_properties array, not the one that imported the macro from the kernel. This allows QEMU to know that old versions have these features disabled although the default set in hw/net/virtio-net.c:virtio_net_properties is true when migrating from / to these versions.
> >
> > You can check that this is added properly by migrating from / to a previous version of QEMU, with the combinations of true and false.
> >
> > You have an example in [1] with blk devices multiqueue. CCing Peter Xu as he knows more than me about this.
> >
> > This is very easy to miss when adding new features. Somebody who knows perl should add a test in checkpath.pl similar to the warning "added, moved or deleted file(s), does MAINTAINERS need updating?" when virtio properties are modified :).
> >
> > >  const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
> > >
> > > @@ -65,6 +66,7 @@ GlobalProperty hw_compat_7_1[] = {
> > >      { "virtio-rng-pci", "vectors", "0" },
> > >      { "virtio-rng-pci-transitional", "vectors", "0" },
> > >      { "virtio-rng-pci-non-transitional", "vectors", "0" },
> > > +    { TYPE_VIRTIO_NET, "in_order", "off"},
> > >  };
> > >  const size_t hw_compat_7_1_len = G_N_ELEMENTS(hw_compat_7_1);
> > >
> > > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c index
> > > e8e1661646..211ca859a6 100644
> > > --- a/hw/net/vhost_net.c
> > > +++ b/hw/net/vhost_net.c
> > > @@ -76,6 +76,8 @@ static const int user_feature_bits[] = {
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
> > > @@ -3949,6 +3949,10 @@ static Property virtio_net_properties[] = {
> > >                        VIRTIO_NET_F_GUEST_USO6, true),
> > >      DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
> > >                        VIRTIO_NET_F_HOST_USO, true),
> > > +    DEFINE_PROP_BIT64("in_order", VirtIONet, host_features,
> > > +                      VIRTIO_F_IN_ORDER, true),
> > > +    DEFINE_PROP_BIT64("notification_data", VirtIONet, host_features,
> > > +                      VIRTIO_F_NOTIFICATION_DATA, true),
> >
> > This default=true is wrong, and makes emulated devices show these features as available when they're not. You can test it by running qemu with the parameters:
> >
> > -netdev tap,id=hostnet0,vhost=off -device virtio-net-pci,netdev=hostnet0,...
> >
> > The emulated device must support both features before making them tunnables.
> >
> > On the other hand, all kinds of virtio devices can use in_order and notification_data, so they should be in include/hw/virtio/virtio.h:DEFINE_VIRTIO_COMMON_FEATURES. But not all of them benefit from in_order. One example of this is virtio-blk. It is usual that requests are completed out of order by the backend device, so my impression is that in_order will hurt its performance.
> > I've never profiled it though, so I may be wrong :).
> >
> > Long story short: Maybe in_order should be false by default, and enabled just in virtio-net?
> >
> > You can see previous attempts of implementing this feature in qemu in [2]. CCing Guo too, as I don't know if he plans to continue this work soon.
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


