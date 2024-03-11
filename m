Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC71C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 08:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjb6G-0005fM-BX; Mon, 11 Mar 2024 04:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rjb6E-0005f3-Ql
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 04:33:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rjb6D-0001md-19
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 04:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710146011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wtE00elLCzH+oXA1K7N9iL0Y24iYZz2S7A2ySjdrwXc=;
 b=f4Zuh83n50YvRg54MNHbtcJfIOu/tXbXo3fkOPUixFILVbpfO7cXaTYPcUQIH22a9fuZB4
 H9euuHSnamXtzeMktyIuuEfjWLs0sHHomvtqJKBny7SaKDPjqYOigfX7cweIP9x22uY9AJ
 E/g3nJJbf5GKBVuSTKW0JTJWgJcWt5k=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-Ldw48Q74M_CVxWR_Ky_45Q-1; Mon, 11 Mar 2024 04:33:30 -0400
X-MC-Unique: Ldw48Q74M_CVxWR_Ky_45Q-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-dbf216080f5so4503259276.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 01:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710146009; x=1710750809;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wtE00elLCzH+oXA1K7N9iL0Y24iYZz2S7A2ySjdrwXc=;
 b=lVrcT1V6PQFw0nAnJe+Qu3kgJV2p7hiwLdrUZcBX6WWnl0oATF7B2xoTaXKz8i2joq
 NF0YPs49VzkXQsGadB7HyugpOyy4UK+rUh/emH3f8yULG+07YoXitvfyU0mfqZKlSDos
 gmMzm8FjixFFmBoebmHJsoswds4cS8cFIRRfN2Tl1heG1M8Bik4SG52s+Znrtiag4gWa
 50sxRslNBC6R4Bs4JJK9wWY5LIkXAj4iFAQf3d+/5vPZVW6YaChasByTYIXJ/SJXcbpI
 UKv2NwbEYo3wBzVI0TuaImCB9C71/aQXCI7IVs1JlT0Byx7iNU7R1580Iomzxl1JWY43
 YT+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCULY8c5VgJWWXVS1+lkODzVcM46z1mZYsbFisYCHkqlVtCgvHMdfYa8wyowTbua39HQnajTB0blgqmU8atxZa7VLs7FF7o=
X-Gm-Message-State: AOJu0YwB1ZS2E0VVbEyC/1lfue7NA5d8ZHdmSjGKWV3OYqjOKRTXeEru
 9D71R3jW8PkPbQfBenChXsehL4wCnC/tFQkuv79mGIdfRMgsquLUMtV69cLvt1SP1cWtqByRgSH
 oECGQvT8Qtr5i6ZkldDuWw/dFk18mVlOd3rcvBPpWltEaZ0op1EtU1m2ut5WyUN+BYaMr2I+fyy
 Ue6GsFoud8uGUierE/2zbqXEHepC0=
X-Received: by 2002:a5b:f90:0:b0:dcd:551f:1e2 with SMTP id
 q16-20020a5b0f90000000b00dcd551f01e2mr3422308ybh.34.1710146009698; 
 Mon, 11 Mar 2024 01:33:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKwk0ENHTsjvedPpXnjcFk+vaZO70nfYR86vQJPs4P/Bd+Nk1O3/f+wGiQl1fGGsSuiZvEnTRmH4XNy+mYALQ=
X-Received: by 2002:a5b:f90:0:b0:dcd:551f:1e2 with SMTP id
 q16-20020a5b0f90000000b00dcd551f01e2mr3422299ybh.34.1710146009413; 
 Mon, 11 Mar 2024 01:33:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240102111432.36817-1-schalla@marvell.com>
 <20240219044352-mutt-send-email-mst@kernel.org>
 <DS0PR18MB5368BA5DBD8D8CDDE1A68573A0512@DS0PR18MB5368.namprd18.prod.outlook.com>
 <DS0PR18MB536881ACD91AFC00D2E24744A0562@DS0PR18MB5368.namprd18.prod.outlook.com>
 <DS0PR18MB53681809B96E8745691192A1A0272@DS0PR18MB5368.namprd18.prod.outlook.com>
In-Reply-To: <DS0PR18MB53681809B96E8745691192A1A0272@DS0PR18MB5368.namprd18.prod.outlook.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 11 Mar 2024 09:32:53 +0100
Message-ID: <CAJaqyWd0xRS9wqcb1pTqBb4it+DkiHZr3zGiwC3nh27taJ_4FQ@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH] vhost_net: add NOTIFICATION_DATA and IN_ORDER
 feature bits to vdpa_feature_bits
To: Srujana Challa <schalla@marvell.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Vamsi Krishna Attunuru <vattunuru@marvell.com>,
 Jerin Jacob <jerinj@marvell.com>, 
 Jason Wang <jasowang@redhat.com>, Jonah Palmer <jonah.palmer@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.945,
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

On Fri, Mar 8, 2024 at 2:39=E2=80=AFPM Srujana Challa <schalla@marvell.com>=
 wrote:
>
> Hi Michael,
>
> VIRTIO_F_NOTIFICATION_DATA needs to be exposed to make Marvell's device w=
orks
> with Qemu. Any other better ways to expose VIRTIO_F_NOTIFICATION_DATA fea=
ture
> bit for vhost vdpa use case?
>

Hi!

Jonah Palmer is working on implementing notification_data [1]. He's
implementing it on emulated devices first but the resulting QEMU
should be able to enable it for vdpa devices too. Would it be possible
for you to review it, and /or test the series against your devices?
And checking that everything works on emulated devices too?

Thanks!

[1] https://lists.nongnu.org/archive/html/qemu-devel/2024-03/msg00755.html

> Thanks,
> Srujana.
>
> > Subject: RE: [EXT] Re: [PATCH] vhost_net: add NOTIFICATION_DATA and
> > IN_ORDER feature bits to vdpa_feature_bits
> >
> > Ping.
> >
> > > Subject: RE: [EXT] Re: [PATCH] vhost_net: add NOTIFICATION_DATA and
> > > IN_ORDER feature bits to vdpa_feature_bits
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Monday, February 19, 2024 3:15 PM
> > > > To: Srujana Challa <schalla@marvell.com>
> > > > Cc: qemu-devel@nongnu.org; Vamsi Krishna Attunuru
> > > > <vattunuru@marvell.com>; Jerin Jacob <jerinj@marvell.com>; Jason
> > > > Wang <jasowang@redhat.com>
> > > > Subject: [EXT] Re: [PATCH] vhost_net: add NOTIFICATION_DATA and
> > > > IN_ORDER feature bits to vdpa_feature_bits
> > > >
> > > > External Email
> > > >
> > > > -------------------------------------------------------------------=
-
> > > > -- On Tue, Jan 02, 2024 at 04:44:32PM +0530, Srujana Challa wrote:
> > > > > Enables VIRTIO_F_NOTIFICATION_DATA and VIRTIO_F_IN_ORDER
> > feature
> > > > bits
> > > > > for vhost vdpa backend. Also adds code to consider all feature
> > > > > bits supported by vhost net client type for feature negotiation,
> > > > > so that vhost backend device supported features can be negotiated=
 with
> > guest.
> > > > >
> > > > > Signed-off-by: Srujana Challa <schalla@marvell.com>
> > > > > ---
> > > > >  hw/net/vhost_net.c | 10 ++++++++++
> > > > >  net/vhost-vdpa.c   |  2 ++
> > > > >  2 files changed, 12 insertions(+)
> > > > >
> > > > > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c index
> > > > > e8e1661646..65ae8bcece 100644
> > > > > --- a/hw/net/vhost_net.c
> > > > > +++ b/hw/net/vhost_net.c
> > > > > @@ -117,6 +117,16 @@ static const int
> > > > > *vhost_net_get_feature_bits(struct vhost_net *net)
> > > > >
> > > > >  uint64_t vhost_net_get_features(struct vhost_net *net, uint64_t
> > > > > features)  {
> > > > > +    const int *bit =3D vhost_net_get_feature_bits(net);
> > > > > +
> > > > > +    /*
> > > > > +     * Consider all feature bits for feature negotiation with vh=
ost backend,
> > > > > +     * so that all backend device supported features can be nego=
tiated.
> > > > > +     */
> > > > > +    while (*bit !=3D VHOST_INVALID_FEATURE_BIT) {
> > > > > +        features |=3D (1ULL << *bit);
> > > > > +        bit++;
> > > > > +    }
> > > > >      return vhost_get_features(&net->dev,
> > vhost_net_get_feature_bits(net),
> > > > >              features);
> > > > >  }
> > > >
> > > > I don't think we should do this part. With vdpa QEMU is in control
> > > > of which features are exposed and that is intentional since feature=
s
> > > > are often tied to other behaviour.
> > >
> > > Vdpa Qemu can negotiate all the features which vdpa backend device
> > > supports with the guest right?
> > > Guest drivers (it could be userspace or kernel drivers) will negotiat=
e
> > > their own features, so that frontend supported features will get the
> > > precedence.
> > >
> > > >
> > > > > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c index
> > > > > 3726ee5d67..51334fcfe2 100644
> > > > > --- a/net/vhost-vdpa.c
> > > > > +++ b/net/vhost-vdpa.c
> > > > > @@ -57,7 +57,9 @@ typedef struct VhostVDPAState {
> > > > >   */
> > > > >  const int vdpa_feature_bits[] =3D {
> > > > >      VIRTIO_F_ANY_LAYOUT,
> > > > > +    VIRTIO_F_IN_ORDER,
> > > > >      VIRTIO_F_IOMMU_PLATFORM,
> > > > > +    VIRTIO_F_NOTIFICATION_DATA,
> > > > >      VIRTIO_F_NOTIFY_ON_EMPTY,
> > > > >      VIRTIO_F_RING_PACKED,
> > > > >      VIRTIO_F_RING_RESET,
> > > > > --
> > > > > 2.25.1
>
>


