Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D6DC10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 05:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4wau-0004gN-OZ; Thu, 09 May 2024 01:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s4wat-0004cn-OD
 for qemu-devel@nongnu.org; Thu, 09 May 2024 01:45:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1s4war-0005Wt-5T
 for qemu-devel@nongnu.org; Thu, 09 May 2024 01:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715233523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=guoIyTbvFqR5EdmLiTzMNjl1gDSdmINI11R9uVP3CIE=;
 b=ObDg29qNPpLAPxn8BFveB9+3p5YL5SOAosH+xq2YpP/ouUYOnUhrcLvarwHP5d4hfZFJmC
 te0bzTHRlhNeHSoXDoO3byVifO4w2zB/00D9DsdKhsmEADnQhtTox5aH8PQkLXt2iTfpyb
 I4PCZ7hxXqvbqipvqe2nf7LZrc22euM=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-e94oJzsnMLCRzDPQ6q9tEQ-1; Thu, 09 May 2024 01:45:22 -0400
X-MC-Unique: e94oJzsnMLCRzDPQ6q9tEQ-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-61d21cf3d3bso9089487b3.3
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 22:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715233521; x=1715838321;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=guoIyTbvFqR5EdmLiTzMNjl1gDSdmINI11R9uVP3CIE=;
 b=ub+vcWrOA2Gvp+e8H+Pd1JRSaPmLjp47bzuv+QP/3kEgpBVTeWitizBky7TR4qM/+a
 YjwE+hmvhxFoFsmtRZAhSd34nOP8P561o3aydyM15JortCkToCeTeaNlw2OL3QF3L3NO
 oSJX8zwnb4/stUvo02algnvyUlMfYfjuO9djdGPzAzAvAi2+GLD2DatCwHqXKRQ/pD9p
 7fD1pbL9GQFB2XIa89Lj1O1EO9G3xSCqVr5yezR9ZcJpkoeJ8zHE/LPVa3fbq0zfsyhR
 FOYr8dxHAx0T7F9tUgQePKJc/GTEtyy0DF8CQUjXLD1hy7ix7YLt/ZIIuP/5vT9YL00t
 4G1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/KCxXW4NEDLV+T44hLvh0Uj+y7zWOqbcJl1vfWAy+cIkLyOm6jL5wRfQBH0KwiFaRZwvD1k0H2XshSRT3er41DjccVv4=
X-Gm-Message-State: AOJu0YziDoZlF0lQh/PcpQ0JItfpFZ5y24YWcD6H8bICqk705VxdcMj5
 NwbDDKoqtIU9srdCH6ZevVcFG0d/k8Q/sTKBSx6v5VIibfo8z5iAPNzG8q6g2NcpzaKlwHdB+qi
 FshlSq3YSIV32cTBIVt/ng6d9PtWt7Kw9n2qVLNG2AvMkXKPhC3pwM4EE4S7T78L7SjbTPAio0W
 mnglZyF5FzjRLQk00HwH9PoSOtW0Q=
X-Received: by 2002:a25:804:0:b0:de0:e383:3c17 with SMTP id
 3f1490d57ef6-debb9db37c3mr4568018276.34.1715233521410; 
 Wed, 08 May 2024 22:45:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwfM9PDxwuXF+fZiN/VSXofGwJNK8EpmP13JYOY9Mlc8qb42xEPC7Ef35EOL7Y+6n/mXiZ7IytOSYo9GWhsnc=
X-Received: by 2002:a25:804:0:b0:de0:e383:3c17 with SMTP id
 3f1490d57ef6-debb9db37c3mr4568006276.34.1715233521044; Wed, 08 May 2024
 22:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240422014041.5706-2-wafer@jaguarmicro.com>
 <CAJaqyWcgMFJL8y7wXwFZa6dny34WKDRH+tuEaCdP8oFN4Qf5fQ@mail.gmail.com>
 <20240508141920-mutt-send-email-mst@kernel.org>
 <PUZPR06MB47138D7EAFA0BB70931D4832A2E62@PUZPR06MB4713.apcprd06.prod.outlook.com>
In-Reply-To: <PUZPR06MB47138D7EAFA0BB70931D4832A2E62@PUZPR06MB4713.apcprd06.prod.outlook.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 9 May 2024 07:44:45 +0200
Message-ID: <CAJaqyWeoFr=kupOZmOpAH2qu3mSZSntrYY3F0ty8wFCvpa3okA@mail.gmail.com>
Subject: Re: [PATCH] hw/virtio: Fix obtain the buffer id from the last
 descriptor
To: Wafer <wafer@jaguarmicro.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Angus Chen <angus.chen@jaguarmicro.com>, Lei Yang <leiyang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.582,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, May 9, 2024 at 4:20=E2=80=AFAM Wafer <wafer@jaguarmicro.com> wrote:
>
>
>
> On Thu, May, 2024 at 2:21=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com> =
wrote:
> >
> > On Wed, May 08, 2024 at 02:56:11PM +0200, Eugenio Perez Martin wrote:
> > > On Mon, Apr 22, 2024 at 3:41=E2=80=AFAM Wafer <wafer@jaguarmicro.com>=
 wrote:
> > > >
> > > > The virtio-1.3 specification
> > > > <https://docs.oasis-open.org/virtio/virtio/v1.3/virtio-v1.3.html> w=
rites:
> > > > 2.8.6 Next Flag: Descriptor Chaining
> > > >       Buffer ID is included in the last descriptor in the list.
> > > >
> > > > If the feature (_F_INDIRECT_DESC) has been negotiated, install only
> > > > one descriptor in the virtqueue.
> > > > Therefor the buffer id should be obtained from the first descriptor=
.
> > > >
> > > > In descriptor chaining scenarios, the buffer id should be obtained
> > > > from the last descriptor.
> > > >
> > >
> > > This is actually trickier. While it is true the standard mandates it,
> > > both linux virtio_ring driver and QEMU trusts the ID will be the firs=
t
> > > descriptor of the chain. Does merging this change in QEMU without
> > > merging the corresponding one in the linux kernel break things? Or am
> > > I missing something?
> > >
>
> The linux virtio_ring driver set the buffer id into all the descriptors o=
f the chain.
>

Ok now after reading the driver code again I see how I missed that.
Sorry for the noise!

> So Bad things can't happen, with this patch, the Linux VirtIO driver can =
work properly.
>
> I have tested it.
>
> > > If it breaks I guess this requires more thinking. I didn't check DPDK=
,
> > > neither as driver nor as vhost-user device.
> > >
> > > Thanks!
> >
> > I think that if the driver is out of spec we should for starters fix it=
 ASAP.
>
> The linux driver is within spec.
>
> >
> > > > Fixes: 86044b24e8 ("virtio: basic packed virtqueue support")
> > > >
> > > > Signed-off-by: Wafer <wafer@jaguarmicro.com>
> > > > ---
> > > >  hw/virtio/virtio.c | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c index
> > > > 871674f9be..f65d4b4161 100644
> > > > --- a/hw/virtio/virtio.c
> > > > +++ b/hw/virtio/virtio.c
> > > > @@ -1739,6 +1739,11 @@ static void *virtqueue_packed_pop(VirtQueue
> > *vq, size_t sz)
> > > >              goto err_undo_map;
> > > >          }
> > > >
> > > > +        if (desc_cache !=3D &indirect_desc_cache) {
> > > > +            /* Buffer ID is included in the last descriptor in the=
 list. */
> > > > +            id =3D desc.id;
> > > > +        }
> > > > +
> > > >          rc =3D virtqueue_packed_read_next_desc(vq, &desc, desc_cac=
he, max,
> > &i,
> > > >                                               desc_cache =3D=3D
> > > >                                               &indirect_desc_cache)=
;
> > > > --
> > > > 2.27.0
> > > >
>


