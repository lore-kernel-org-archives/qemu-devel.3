Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D67BC021A0
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 02:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tilNw-0004Rd-IM; Thu, 13 Feb 2025 21:24:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tilNt-0004RF-Gu
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 21:24:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tilNr-0008PD-Rq
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 21:24:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739499888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wfMNsQOirfeeK8d6OAbiJWrNzoRQSMyo0LtZU3GIisw=;
 b=esBDu7SYvRB4KlZnkRjNZVqaMCxR2AUOcIiWaVnA7RLkHE1QZGGhO6dIw0q2btCLZ6eP6d
 dUkTVb1aKHA98YizfFfQyudCn25+mDqeY/xx4B7FMd34asWclOpKAnKb5KzYKL4XRzF0Rf
 ZZ+6utcC8UF0OfuabXjoDa6mEe0SQKg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-IpzgBT0RMSmYv38G6agufQ-1; Thu, 13 Feb 2025 21:24:45 -0500
X-MC-Unique: IpzgBT0RMSmYv38G6agufQ-1
X-Mimecast-MFC-AGG-ID: IpzgBT0RMSmYv38G6agufQ_1739499885
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ab77e03f2c0so155965266b.3
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 18:24:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739499884; x=1740104684;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wfMNsQOirfeeK8d6OAbiJWrNzoRQSMyo0LtZU3GIisw=;
 b=Rxgygog6faaJFKWK7GR5begh4Qexn0GmwKKJw4m7yTKbIBob30WZhRGxXug2P/jaPK
 v0kL7vihdM6zPm74p4v4auZtrx/ymWVLfQbin20WcE994epcdAazcSbqjtbWM6FEtCcF
 91lZQ56dh2Vsgq2oaAectyMUtwhE8KECkMhKzrCYidxpGeP7ik6uC3U8iuLlwd0QODqm
 XLBwcfvXSVNR0O+bIHv/pJtmFLeCJnZAY05oSnl4J9haQjyymDowtu19uFQwWJzpKsPX
 U3oKC9PO3+Z3L3oWWssHn2DcFewbAPA7/AAo7R5JlHYTFROhopOcP21sbN0lhmLXIdwr
 hxBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRdP8R5Mm68KH6BwGtUPlnu0rlbdWL5Y7hOhlc3BXxkNP7EWQYnijSirplQyQhZ+DuZR0bAGKRFUGt@nongnu.org
X-Gm-Message-State: AOJu0Yw5iwpsx263gbYCW4SYNv6FUUH7X7mzcLcqkHk/EWoIcw2soY7u
 xQpg+TkRKZZeUQ+Ii/da8MsM6e+y1rMatm0tzan49EumjSpJPQYRx1jylVEV18lVqZi8qrLCXiX
 hsZuQ5f9lb8TGTlaxhD0Ycg5MaXe6lrL1xRCDYo6txhUZFmK73k9HT7TvMb/ZxvZPXtuxcAHAGa
 J5aAqKN6TzDZYaaBtNLMrHIaXBQDM=
X-Gm-Gg: ASbGncuzTl1JDlKAwgaIT+rhSAbG7uZlsXt2B1kUICoWMnjwXEPr2p8KnjrrRe1VSiE
 b/DyQtswIwhd+T1ATgWavI2irbWKtp5sLyIgS1BW04OzBKNkwzi+16Nq4QKiYmp4=
X-Received: by 2002:a17:907:7285:b0:ab7:9bea:4e04 with SMTP id
 a640c23a62f3a-ab7f33a3b2emr920057966b.15.1739499884549; 
 Thu, 13 Feb 2025 18:24:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzstluxwzRv147YHjc69e6NAwoeOELKdCIHfbUQ1UBfqRnjwRQdoPzEvW32+ICR23WkXSysu6gJgO7Y9U4kAE=
X-Received: by 2002:a17:907:7285:b0:ab7:9bea:4e04 with SMTP id
 a640c23a62f3a-ab7f33a3b2emr920056366b.15.1739499884158; Thu, 13 Feb 2025
 18:24:44 -0800 (PST)
MIME-Version: 1.0
References: <20250212164923.1971538-1-kshk@linux.ibm.com>
 <CAJaqyWeHB_+ATn3cvtVrpiFp4NjNLoKpPP1ijs4C7eyRL7gpKQ@mail.gmail.com>
In-Reply-To: <CAJaqyWeHB_+ATn3cvtVrpiFp4NjNLoKpPP1ijs4C7eyRL7gpKQ@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 14 Feb 2025 10:24:07 +0800
X-Gm-Features: AWEUYZmh8iDM239Zu9p1kJcmkoAMzLas5F0vusBla0Y5fAiI5AdCTj_oSWyPhRc
Message-ID: <CAPpAL=w-0kgngVYiep2+K_WEGnuv1T_mTFTUbz9JPmH93HHzBg@mail.gmail.com>
Subject: Re: [PATCH v2] vdpa: Fix endian bugs in shadow virtqueue
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: mst@redhat.com, sgarzare@redhat.com, 
 Eugenio Perez Martin <eperezma@redhat.com>, mjrosato@linux.ibm.com,
 qemu-devel@nongnu.org, 
 Sahil <icegambit91@gmail.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

I tested this patch with vdpa's regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Thu, Feb 13, 2025 at 2:51=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, Feb 12, 2025 at 5:49=E2=80=AFPM Konstantin Shkolnyy <kshk@linux.i=
bm.com> wrote:
> >
> > VDPA didn't work on a big-endian machine due to missing/incorrect
> > CPU<->LE data format conversions.
> >
>
> Fixes: 10857ec0ad ("vhost: Add VhostShadowVirtqueue")
>
> > Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> Thanks!
>
> > ---
> > Changes in v2: Change desc_next[] from LE format to "CPU".
> >
> >  hw/virtio/vhost-shadow-virtqueue.c | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
> >
> > diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shado=
w-virtqueue.c
> > index 37aca8b431..4af0d7c669 100644
> > --- a/hw/virtio/vhost-shadow-virtqueue.c
> > +++ b/hw/virtio/vhost-shadow-virtqueue.c
> > @@ -165,10 +165,10 @@ static bool vhost_svq_vring_write_descs(VhostShad=
owVirtqueue *svq, hwaddr *sg,
> >          descs[i].len =3D cpu_to_le32(iovec[n].iov_len);
> >
> >          last =3D i;
> > -        i =3D cpu_to_le16(svq->desc_next[i]);
> > +        i =3D svq->desc_next[i];
> >      }
> >
> > -    svq->free_head =3D le16_to_cpu(svq->desc_next[last]);
> > +    svq->free_head =3D svq->desc_next[last];
> >      return true;
> >  }
> >
> > @@ -228,10 +228,12 @@ static void vhost_svq_kick(VhostShadowVirtqueue *=
svq)
> >      smp_mb();
> >
> >      if (virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
> > -        uint16_t avail_event =3D *(uint16_t *)(&svq->vring.used->ring[=
svq->vring.num]);
> > +        uint16_t avail_event =3D le16_to_cpu(
> > +                *(uint16_t *)(&svq->vring.used->ring[svq->vring.num]))=
;
> >          needs_kick =3D vring_need_event(avail_event, svq->shadow_avail=
_idx, svq->shadow_avail_idx - 1);
> >      } else {
> > -        needs_kick =3D !(svq->vring.used->flags & VRING_USED_F_NO_NOTI=
FY);
> > +        needs_kick =3D
> > +                !(svq->vring.used->flags & cpu_to_le16(VRING_USED_F_NO=
_NOTIFY));
> >      }
> >
> >      if (!needs_kick) {
> > @@ -365,7 +367,7 @@ static bool vhost_svq_more_used(VhostShadowVirtqueu=
e *svq)
> >          return true;
> >      }
> >
> > -    svq->shadow_used_idx =3D cpu_to_le16(*(volatile uint16_t *)used_id=
x);
> > +    svq->shadow_used_idx =3D le16_to_cpu(*(volatile uint16_t *)used_id=
x);
> >
> >      return svq->last_used_idx !=3D svq->shadow_used_idx;
> >  }
> > @@ -383,7 +385,7 @@ static bool vhost_svq_enable_notification(VhostShad=
owVirtqueue *svq)
> >  {
> >      if (virtio_vdev_has_feature(svq->vdev, VIRTIO_RING_F_EVENT_IDX)) {
> >          uint16_t *used_event =3D (uint16_t *)&svq->vring.avail->ring[s=
vq->vring.num];
> > -        *used_event =3D svq->shadow_used_idx;
> > +        *used_event =3D cpu_to_le16(svq->shadow_used_idx);
> >      } else {
> >          svq->vring.avail->flags &=3D ~cpu_to_le16(VRING_AVAIL_F_NO_INT=
ERRUPT);
> >      }
> > @@ -408,7 +410,7 @@ static uint16_t vhost_svq_last_desc_of_chain(const =
VhostShadowVirtqueue *svq,
> >                                               uint16_t num, uint16_t i)
> >  {
> >      for (uint16_t j =3D 0; j < (num - 1); ++j) {
> > -        i =3D le16_to_cpu(svq->desc_next[i]);
> > +        i =3D svq->desc_next[i];
> >      }
> >
> >      return i;
> > @@ -683,7 +685,7 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, Vir=
tIODevice *vdev,
> >      svq->desc_state =3D g_new0(SVQDescState, svq->vring.num);
> >      svq->desc_next =3D g_new0(uint16_t, svq->vring.num);
> >      for (unsigned i =3D 0; i < svq->vring.num - 1; i++) {
> > -        svq->desc_next[i] =3D cpu_to_le16(i + 1);
> > +        svq->desc_next[i] =3D i + 1;
> >      }
> >  }
> >
> > --
> > 2.34.1
> >
>
>


