Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B42C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 15:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk4PZ-0005aD-KO; Tue, 12 Mar 2024 11:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk4PX-0005Y5-JN
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:51:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk4PV-0003qo-Rb
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710258685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mVQBlnEIG4sQW3Ry856Tq69MU8nMkmIhldFUc1MEIQw=;
 b=d1LW5jZXZXKHPKcJq6t+x2qgW/GjTa1nBu9L/GBQHRKcPZNDVhhPun4JxQH6rMr19hYmtq
 GE8gk9S9NSogGI6ZJaT5CGidFzYk1qhZtHfokAfpcNhoij2yeAmSzBo4uU40i1FUXnFSMP
 lmBf1vBh1hHkkvURw9B57iqo2id1iNA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-l5POM6TUMD-_4mP4Z7P7-g-1; Tue, 12 Mar 2024 11:51:24 -0400
X-MC-Unique: l5POM6TUMD-_4mP4Z7P7-g-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-412eeb789d9so485725e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 08:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710258683; x=1710863483;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mVQBlnEIG4sQW3Ry856Tq69MU8nMkmIhldFUc1MEIQw=;
 b=MfZqMxdDo+p3VAQ3YCHs1NIN33Fz4/5OB1XAukHTrCpSNeh8JsN/IGSJuRQf3/cBt0
 Ops/t0soCkNO3GQ5Azw17mzF+8OPyjIS3+XBaigDw3RMzTvJqexIvk6qXDKyMoAAIdI4
 esyeXnCSnAJ3mrZwJi9Fxw10TW3fbVWf/xDkfR80Zttas84W0MmkffPMc7/t7A127Qa1
 Ina5EsoHBXSOIrSfP+YPyEwBzY0DzKmEntfMDVhmG4lsHoJvuQJX5gbSIyY0uNOGq6q/
 mM+i6P4v+Im8YOBKIlx9DAzAl8SANEJyFWnqnhuSuq5O6PqI/9d5fjhSwukov/YtUM6B
 Cxqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVy9mrGU89quT1FC87p7nDks39hnqO8VTmJ4DUs9npxC9hrF0F5/kGPcdZeYAxrBqa9BkYyd7sLVzv+AtLDMkLFac5lDrc=
X-Gm-Message-State: AOJu0YwC1bPEsoJC1UPBf0nAHZweyyIrpHCvFQ1bX7YFaowBk7xAkKnX
 VKQYcGWjMO/y5W/Ir2wMlDZZ6/9Mxz/9eelKfZOm8XcJKSqTfj5/fzUM1x5rRJP77NW6JflAYEI
 y8DGo7gtulqNYkEFINQskMCEWYtj+XYa6geA6YlZwMlWKGrxEHWXc
X-Received: by 2002:a05:600c:470e:b0:413:2ea4:164b with SMTP id
 v14-20020a05600c470e00b004132ea4164bmr3745765wmo.14.1710258682707; 
 Tue, 12 Mar 2024 08:51:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3VVcj48NpDFVFM+N2nxHRNfNJM1yJA1PufsyMEttjBROwYjI7DHWh4bHmdN/Oaf4fq4C9hw==
X-Received: by 2002:a05:600c:470e:b0:413:2ea4:164b with SMTP id
 v14-20020a05600c470e00b004132ea4164bmr3745744wmo.14.1710258682146; 
 Tue, 12 Mar 2024 08:51:22 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:532c:5ae4:fce6:76e1:fa1a])
 by smtp.gmail.com with ESMTPSA id
 bg13-20020a05600c3c8d00b00412fe0eb806sm19330762wmb.14.2024.03.12.08.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 08:51:21 -0700 (PDT)
Date: Tue, 12 Mar 2024 11:51:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Srujana Challa <schalla@marvell.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Vamsi Krishna Attunuru <vattunuru@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>, Jason Wang <jasowang@redhat.com>,
 Jonah Palmer <jonah.palmer@oracle.com>
Subject: Re: [EXT] Re: [PATCH] vhost_net: add NOTIFICATION_DATA and IN_ORDER
 feature bits to vdpa_feature_bits
Message-ID: <20240312115031-mutt-send-email-mst@kernel.org>
References: <20240102111432.36817-1-schalla@marvell.com>
 <20240219044352-mutt-send-email-mst@kernel.org>
 <DS0PR18MB5368BA5DBD8D8CDDE1A68573A0512@DS0PR18MB5368.namprd18.prod.outlook.com>
 <DS0PR18MB536881ACD91AFC00D2E24744A0562@DS0PR18MB5368.namprd18.prod.outlook.com>
 <DS0PR18MB53681809B96E8745691192A1A0272@DS0PR18MB5368.namprd18.prod.outlook.com>
 <CAJaqyWd0xRS9wqcb1pTqBb4it+DkiHZr3zGiwC3nh27taJ_4FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWd0xRS9wqcb1pTqBb4it+DkiHZr3zGiwC3nh27taJ_4FQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Mar 11, 2024 at 09:32:53AM +0100, Eugenio Perez Martin wrote:
> On Fri, Mar 8, 2024 at 2:39 PM Srujana Challa <schalla@marvell.com> wrote:
> >
> > Hi Michael,
> >
> > VIRTIO_F_NOTIFICATION_DATA needs to be exposed to make Marvell's device works
> > with Qemu. Any other better ways to expose VIRTIO_F_NOTIFICATION_DATA feature
> > bit for vhost vdpa use case?
> >
> 
> Hi!
> 
> Jonah Palmer is working on implementing notification_data [1]. He's
> implementing it on emulated devices first but the resulting QEMU
> should be able to enable it for vdpa devices too. Would it be possible
> for you to review it, and /or test the series against your devices?
> And checking that everything works on emulated devices too?
> 
> Thanks!
> 
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2024-03/msg00755.html

Yes, please do. And if anything is missing in his patches you can post
a patch on top.


> > Thanks,
> > Srujana.
> >
> > > Subject: RE: [EXT] Re: [PATCH] vhost_net: add NOTIFICATION_DATA and
> > > IN_ORDER feature bits to vdpa_feature_bits
> > >
> > > Ping.
> > >
> > > > Subject: RE: [EXT] Re: [PATCH] vhost_net: add NOTIFICATION_DATA and
> > > > IN_ORDER feature bits to vdpa_feature_bits
> > > >
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: Monday, February 19, 2024 3:15 PM
> > > > > To: Srujana Challa <schalla@marvell.com>
> > > > > Cc: qemu-devel@nongnu.org; Vamsi Krishna Attunuru
> > > > > <vattunuru@marvell.com>; Jerin Jacob <jerinj@marvell.com>; Jason
> > > > > Wang <jasowang@redhat.com>
> > > > > Subject: [EXT] Re: [PATCH] vhost_net: add NOTIFICATION_DATA and
> > > > > IN_ORDER feature bits to vdpa_feature_bits
> > > > >
> > > > > External Email
> > > > >
> > > > > --------------------------------------------------------------------
> > > > > -- On Tue, Jan 02, 2024 at 04:44:32PM +0530, Srujana Challa wrote:
> > > > > > Enables VIRTIO_F_NOTIFICATION_DATA and VIRTIO_F_IN_ORDER
> > > feature
> > > > > bits
> > > > > > for vhost vdpa backend. Also adds code to consider all feature
> > > > > > bits supported by vhost net client type for feature negotiation,
> > > > > > so that vhost backend device supported features can be negotiated with
> > > guest.
> > > > > >
> > > > > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > > > > > ---
> > > > > >  hw/net/vhost_net.c | 10 ++++++++++
> > > > > >  net/vhost-vdpa.c   |  2 ++
> > > > > >  2 files changed, 12 insertions(+)
> > > > > >
> > > > > > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c index
> > > > > > e8e1661646..65ae8bcece 100644
> > > > > > --- a/hw/net/vhost_net.c
> > > > > > +++ b/hw/net/vhost_net.c
> > > > > > @@ -117,6 +117,16 @@ static const int
> > > > > > *vhost_net_get_feature_bits(struct vhost_net *net)
> > > > > >
> > > > > >  uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t
> > > > > > features)  {
> > > > > > +    const int *bit = vhost_net_get_feature_bits(net);
> > > > > > +
> > > > > > +    /*
> > > > > > +     * Consider all feature bits for feature negotiation with vhost backend,
> > > > > > +     * so that all backend device supported features can be negotiated.
> > > > > > +     */
> > > > > > +    while (*bit != VHOST_INVALID_FEATURE_BIT) {
> > > > > > +        features |= (1ULL << *bit);
> > > > > > +        bit++;
> > > > > > +    }
> > > > > >      return vhost_get_features(&net->dev,
> > > vhost_net_get_feature_bits(net),
> > > > > >              features);
> > > > > >  }
> > > > >
> > > > > I don't think we should do this part. With vdpa QEMU is in control
> > > > > of which features are exposed and that is intentional since features
> > > > > are often tied to other behaviour.
> > > >
> > > > Vdpa Qemu can negotiate all the features which vdpa backend device
> > > > supports with the guest right?
> > > > Guest drivers (it could be userspace or kernel drivers) will negotiate
> > > > their own features, so that frontend supported features will get the
> > > > precedence.
> > > >
> > > > >
> > > > > > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c index
> > > > > > 3726ee5d67..51334fcfe2 100644
> > > > > > --- a/net/vhost-vdpa.c
> > > > > > +++ b/net/vhost-vdpa.c
> > > > > > @@ -57,7 +57,9 @@ typedef struct VhostVDPAState {
> > > > > >   */
> > > > > >  const int vdpa_feature_bits[] = {
> > > > > >      VIRTIO_F_ANY_LAYOUT,
> > > > > > +    VIRTIO_F_IN_ORDER,
> > > > > >      VIRTIO_F_IOMMU_PLATFORM,
> > > > > > +    VIRTIO_F_NOTIFICATION_DATA,
> > > > > >      VIRTIO_F_NOTIFY_ON_EMPTY,
> > > > > >      VIRTIO_F_RING_PACKED,
> > > > > >      VIRTIO_F_RING_RESET,
> > > > > > --
> > > > > > 2.25.1
> >
> >


