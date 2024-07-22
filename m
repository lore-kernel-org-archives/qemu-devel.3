Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02914C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 11:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVrGk-0007YR-Gg; Mon, 22 Jul 2024 07:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sVrGj-0007Ry-4g
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:31:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1sVrGg-0007ee-Lk
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721647909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gyPEZosLEJoPzw9jwU4q2rXpE+iQ8AW2A91E1ZFe2VA=;
 b=EKuW/loMj/gqNkalApre6ckNz3HW1JMLmkZuAvxpNHncvu1XebL011itSK6DIS0nezFpkr
 wicbANWcXMNHl5rIVoMnSe4qoVjTdE5Ovq2d5EIzM30WuNydEobJv+ypAOmVwvkftaxXsZ
 Cw+aqt/tABjJv1grrtLmSbmgW5wkOZs=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-rCT_s_2CN-KFFTSlipA_-Q-1; Mon, 22 Jul 2024 07:31:47 -0400
X-MC-Unique: rCT_s_2CN-KFFTSlipA_-Q-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-65f94703b89so140038117b3.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 04:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721647907; x=1722252707;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gyPEZosLEJoPzw9jwU4q2rXpE+iQ8AW2A91E1ZFe2VA=;
 b=Tfn7PHf07cFy6ym8i5cjjT3frdjVQw09mRa4RTytbDAW0JpItFMzRHLCnam1C+Xycl
 pbXT/UQBjEltxiVesf+3DWmXe4yObFZoRmFpuhSH+0SEi54OSVODNd5W9KEtwJFoEbHa
 SEDPMpMT3QyaP6elCemne+RFUYixp/MEkE2LDWtYkfthKo5Af+0of8psOeYSjxx4uIqu
 b/2h6oVLMY/yGBRPYppFi0292G5RTWCqWrngrUT8QKKZ1fIPriP3EGtTwLASUgrY4dFq
 xSsd5igMjIaaS/zpavvA/cy2opeeBRyddP2emj5DHmT58gr6+rs6jTSbO2NGEwZexay4
 l3gQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk8GdUHxxB6KuEwdJFkAsShOAHODBVUEP6Px1NZpjBsUYwBTx160SdxCYoKkre/87S9oTpAY9LzdPuZEjzqqzA2WGkfXw=
X-Gm-Message-State: AOJu0Ywfqq+xdGPyiOWzW2UsE+02GdaR86vpJNPzyeU7jwYf7NedGmWE
 cNg6VuvYbVQeadmsnf8Fq8vZmkfcw/fmkpI21ZzeKq1liGHSHPEjzQQF6gRxikjrFRnL3gn5OuX
 Z1GDlnFHHVDDFx2r/a5LhomBTx/qJZFctjQ/6nrgc3sus20on8ZXUdKHtiYLoPqROwUq9fer1Ou
 Ls4Lw6h7xMuY2v13pPo/NACGUab1w=
X-Received: by 2002:a05:690c:385:b0:64b:52e8:4ae3 with SMTP id
 00721157ae682-66a634572c5mr112037777b3.3.1721647907183; 
 Mon, 22 Jul 2024 04:31:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQTQYr8zUa+IMGMvfMYbjNUGaKxvIuGajLpSouFkn/6/PO5nx2TymcbwT6V7lNoEbakc2GJnKCtEa3UBrp3gE=
X-Received: by 2002:a05:690c:385:b0:64b:52e8:4ae3 with SMTP id
 00721157ae682-66a634572c5mr112037517b3.3.1721647906931; Mon, 22 Jul 2024
 04:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240710125522.4168043-1-jonah.palmer@oracle.com>
 <20240710125522.4168043-7-jonah.palmer@oracle.com>
 <20240720151557-mutt-send-email-mst@kernel.org>
 <CAJaqyWesMrixZo+duwLqNUq311QpCvFJOWob8nnprYeK47T44g@mail.gmail.com>
In-Reply-To: <CAJaqyWesMrixZo+duwLqNUq311QpCvFJOWob8nnprYeK47T44g@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 22 Jul 2024 13:31:09 +0200
Message-ID: <CAJaqyWdU901wG=b1joD+ZH=sUOLzvwOJAYwCS=9PfWhsATAZkA@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] virtio: Add VIRTIO_F_IN_ORDER property definition
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 raphael@enfabrica.net, 
 kwolf@redhat.com, hreitz@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, 
 fam@euphon.net, stefanha@redhat.com, qemu-block@nongnu.org, 
 schalla@marvell.com, leiyang@redhat.com, virtio-fs@lists.linux.dev, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

On Mon, Jul 22, 2024 at 1:11=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Sat, Jul 20, 2024 at 9:16=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Wed, Jul 10, 2024 at 08:55:19AM -0400, Jonah Palmer wrote:
> > > Extend the virtio device property definitions to include the
> > > VIRTIO_F_IN_ORDER feature.
> > >
> > > The default state of this feature is disabled, allowing it to be
> > > explicitly enabled where it's supported.
> > >
> > > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> >
> >
> > Given release is close, it's likely wise.
> > However, I think we should flip the default in the future
> > release.
> >
>
> Should we post a new version with v9.2 tag enabling it?
>

Sorry, actually I think this needs some more thought. Maybe in_order
hurts the performance of devices that are usually out of order, like
blk. Should we enable only for virtio-net and let each device code
decide?

> > > ---
> > >  include/hw/virtio/virtio.h | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > > index fdc827f82e..d2a1938757 100644
> > > --- a/include/hw/virtio/virtio.h
> > > +++ b/include/hw/virtio/virtio.h
> > > @@ -373,7 +373,9 @@ typedef struct VirtIORNGConf VirtIORNGConf;
> > >      DEFINE_PROP_BIT64("packed", _state, _field, \
> > >                        VIRTIO_F_RING_PACKED, false), \
> > >      DEFINE_PROP_BIT64("queue_reset", _state, _field, \
> > > -                      VIRTIO_F_RING_RESET, true)
> > > +                      VIRTIO_F_RING_RESET, true), \
> > > +    DEFINE_PROP_BIT64("in_order", _state, _field, \
> > > +                      VIRTIO_F_IN_ORDER, false)
> > >
> > >  hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
> > >  bool virtio_queue_enabled_legacy(VirtIODevice *vdev, int n);
> > > --
> > > 2.43.5
> >


