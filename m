Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F552606A68C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FGEQ+acn;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=KUmTBIqb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW984-00042M-R0; Wed, 25 Nov 2026 04:17:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1xW981-000429-U4
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 04:17:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1xW97z-0006JE-U2
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 04:17:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795598240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6tqDs6rF7FSr66fjtjB5mAGZUDroqwcHMAv3w030J9s=;
 b=FGEQ+acnp2T5lTMkKBs9sf2RSmbzdB9+Fgj964biQgR4XgGIvtx03b4ewI04/h83/z5Ysr
 lHX3JJ2tX3dpCR/U4gDW0DBQTFbVr83ZQQutKK6rZ6QJesfL9P1NgR5BOVQoGaK6H6iQ0b
 4X7/+ZAPiOzAFuDuGNYlMH28j38KWJg=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-GA7N2IaiPr6iHimCiXzHyQ-1; Wed, 25 Nov 2026 09:17:16 +0000
X-MC-Unique: GA7N2IaiPr6iHimCiXzHyQ-1
X-Mimecast-MFC-AGG-ID: GA7N2IaiPr6iHimCiXzHyQ_1795598236
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-67d98b79858so9047590d50.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 01:17:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795598236; cv=none;
 d=google.com; s=arc-20260327;
 b=rLZOf9WbGvewM0dcFjMH2QUFeHLN6NMan9IP7uLAiMGvybUbP9Gm9WNA9UVaPj1Rkj
 6pnPTqXo4vl+CQxC52iG86euzKsGAeAMGXkqeVNEKh6oboE5mV7UwIbA9lU22teWzP+L
 DnRXY+qtEqdGjCHW3UUQafnuwJYBGfKBwj4fKg8aIq12U9Bq0auYUdo4rSGFn8552oZf
 b2msc6ndyTc2vnUzEy32tYFsGm/OGnSCPdZ5Wv/Io1Y4MITQwHuxp5oKeFhZFsMRSDYR
 ifkKnVCY3P64tKN0ym9y2itz9AzvqcXZjBo0Ve3Hh4ZGaWJ8+ikzFD8+z6jL3hGRQpsy
 /93w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6tqDs6rF7FSr66fjtjB5mAGZUDroqwcHMAv3w030J9s=;
 fh=wKMLPd6lxQk/4NTdLwtjpir6AUjAkRIWurF4AmBS6L4=;
 b=lAN5lkJrTtAWhqngn6m7HBImxafKXgi8/8PZftHoy7S2K6Hf0gpIgEDRD1lodDRTLm
 aKCY53yASh/aI8u3xqe6QkaY1rxn4qj3bJInJZndvzcHOgHQQR8HeRFz19RMeRGG3Xo+
 xbve5+zsH9lVdoP3plPsD6wSpyfEPiEi4aP2cWHq/fPSdlForf8az9Clx3cPoNEqoUqV
 3yN4wc+H7PmGFu39IfswuquddaQQwjarbfrz555Xm/f5r/iQJDSIRkgh4LDNas/gp7aL
 C9M+Fp9Sx9I1FGSkQgMR0Q+qds3Lq+Cyuiz8TiePJ9asCt72CNNxusOCvZ65K3gUOS6N
 xzvQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795598236; x=1796203036; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6tqDs6rF7FSr66fjtjB5mAGZUDroqwcHMAv3w030J9s=;
 b=KUmTBIqbbU00gSHIVp/oacNfDM5Pgbs98oQUG6uWv9MbTzMIhiFQvfDINjZ7g0lBfQ
 otuqA05/ulUgKYCx9s2YBkQ3Iok82ZSIuPZVXrnGOrhxsmV12bOLNzaa1JwgjMthAAdb
 Nczg4KnzPCjBvpx3VVWbQfFFWdklhYr61HVUU0juPCRZAlINMUdDnGHQSgyO5GTYiLYW
 MuV6ncO9i1Su7VGQzcrNAVrBTU95wwqO09STDj1O/vejRoa1o3gwJbwfUrokqPKFCFsz
 EuPqN/Fpzhl/1+163w0XkHcRt7sB0gemSjpGy3bXBy0u1dsZ3DMi7/X7hdAlJr6Fm0uS
 vLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795598236; x=1796203036;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6tqDs6rF7FSr66fjtjB5mAGZUDroqwcHMAv3w030J9s=;
 b=wnaOaJvbHB/PxnmN4Lj7GoWdTjAdP3rrS7UgSaKCiqMn5tID3DTc/w4eB8QIN6Yqhl
 9zYiTIYgHDTqbJtVqrPDBLmFUb9XbJzYDptDSrhXm/899v/tQ6gv9J1BXO/zWBwUh4BV
 UFF9kU1QZQFfWI6nzmMJBbUxoHWHXHuYBY4zpfHlo+I0ZJWS2bbhnaWExgJ0tf98TPUL
 dfEM5mWuIBX2tWJMvaZTAaR+IdUwbloP5iTQ0X3Nng2caIHcFeucTm+4XwacIONMLGNq
 Kpka2+pez0pQBIZQpTIbZIsVy7BnDL36HjQIyR2zUWV87oVgX7zTAMJlmHT7jEULDEH8
 4BhA==
X-Forwarded-Encrypted: i=1;
 AL+hErE7KTf98VJzXsHPuG5ZGTEJoXDqqj+YcDKk1tR2cWAL/IwUdAJaZ5zAlDee+gft1gZoO53bXxr3b8UI@nongnu.org
X-Gm-Message-State: APuU4Z8Mo/L7QWUII7SV878i4oNyrUD6weqWRVdXGsSkt5Zh8XTKjMur
 gvY3p+UNWWF9sNkgopCd11KLaMLhTJ5YyRIh1gxjDqKsYDmMVYPP5Zk3d1poNvvOyN9LbVhAh39
 H7u1Erj6YBk9KlV/q/l+7qUJsl9IV3ALy8vxoD3GXw8UwYxeazLP3mVSAY2FAF9+DtKA+ckIREy
 BUcCOt41GAlT5VPFfZToWjyZjAaEH7KmM=
X-Gm-Gg: AZFdTZdCXbIj9+D7pSisaT9Ydkm8jdWSabcGaRK0eTpK+Jzl8qpNdGeuTmFk/f5HHNz
 yqvMWdN1lxfV9I7YrfsgE2hD6gg5fBxmSP/iZghHErAh1G54UrQ6GdSzl/ZqiBVnlPGxk/uVESn
 b6ZGayORF1QczV/pbXrUdvCteMKn2ipvlfb8fZ8GSW3SB0/NRBzYmW5qRiByvHyNE3dDqROT1de
 1AxYppP+k4qt6bhg/d352pcAXAf/DodkFC/F0SxTHs4VXnAuUpQDeB95Sk=
X-Received: by 2002:a05:690e:1386:b0:67d:c05f:a36e with SMTP id
 956f58d0204a3-67df43f5faamr8158359d50.17.1795598235993; 
 Wed, 25 Nov 2026 01:17:15 -0800 (PST)
X-Received: by 2002:a05:690e:1386:b0:67d:c05f:a36e with SMTP id
 956f58d0204a3-67df43f5faamr8158351d50.17.1795598235595; Wed, 25 Nov 2026
 01:17:15 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123231319.377104-1-connorkite@gmail.com>
 <e271405f-b7fe-48fa-bca2-964945c38994@oss.qualcomm.com>
 <awakcwEP6eYCeb-A@sgarzare-redhat>
In-Reply-To: <awakcwEP6eYCeb-A@sgarzare-redhat>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 25 Nov 2026 10:16:38 +0100
X-Gm-Features: Aa3M54oz4XJNDJBcv4pFiyvoxyXt-4d7cQq_VKu9DHALBlJANz1wCh_M9mktYgk
Message-ID: <CAJaqyWcUpP2c-B70OLeWyBpkZjVPsN3Vm5iyAUVeZG=DaR6+Hw@mail.gmail.com>
Subject: Re: [PATCH] hw/virtio/vhost-shadow-virtqueue: clear ndescs after use
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Connor Kite <connorkite@gmail.com>, qemu-devel@nongnu.org, 
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 25, 2026 at 10:05=E2=80=AFAM Stefano Garzarella <sgarzare@redha=
t.com> wrote:
>
> On Tue, Nov 24, 2026 at 08:41:04AM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > Hi Connor,
> >
> > On 24/11/26 00:13, Connor Kite wrote:
> > > When a shadow virtqueue detaches the buffer associated with a used el=
ement,
> > > it adds the descriptor chain to the head of the free-elements list. H=
owever,
> > > this currently happens after svq->desc_state[last_used].ndescs is set=
 to 0
> > > in vhost_svq_get_buf, introducing a bug.  Only the first element in t=
he used
> > > descriptor chain is added back into the free-elements list, with subs=
equent
> > > elements being potentially orphaned.
> >
> > Not really added to the 'head of the free-elements list', but the forme=
r
> > chain tail to free_head, then makes id the new head. Suggested reword:
> >
> >   vhost_svq_detach_buf() uses the head descriptor's ndescs to find the
> >   last descriptor of the chain and reinsert the whole chain into the
> >   free list. vhost_svq_get_buf() currently clears ndescs before calling
> >   it, so multi-descriptor buffers are recycled as single descriptors an=
d
> >   the remaining descriptors are orphaned.
> >
> > >
> > > Zero out ndescs only after the buffer is detached.
> > >
> >
> > Cc: qemu-stable@nongnu.org
> > Fixes: 86f5f2546f03 ("vhost: use SVQ element ndescs instead of opaque d=
ata
> > for desc validation")
>
> yeah, I was going to suggest to cc stable and add a fixes tag too.
>
> >
> > (Please check this is the correct commit introducing the
> > zero-before-detach behavior).
>
> IMO we should use
>
> Fixes: 7291b1a5f8b0 ("vhost: factor out the detach buf logic in SVQ")
>
> @Eugenio can you check this?
>

Right, that's the one that reordered the operations and introduced the
issue, thanks for finding it!

> Thanks,
> Stefano
>
> >
> > > Signed-off-by: Connor Kite <connorkite@gmail.com>
> > > ---
> > >   hw/virtio/vhost-shadow-virtqueue.c | 4 +++-
> > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-sha=
dow-virtqueue.c
> > > index 462c86dc1e..1afd3edf87 100644
> > > --- a/hw/virtio/vhost-shadow-virtqueue.c
> > > +++ b/hw/virtio/vhost-shadow-virtqueue.c
> > > @@ -604,6 +604,7 @@ static VirtQueueElement *vhost_svq_get_buf(VhostS=
hadowVirtqueue *svq,
> > >                                              uint32_t *len)
> > >   {
> > >       uint16_t last_used;
> > > +    VirtQueueElement *detached_buf;
> > >       if (!vhost_svq_more_used(svq)) {
> > >           return NULL;
> > > @@ -637,9 +638,10 @@ static VirtQueueElement *vhost_svq_get_buf(Vhost=
ShadowVirtqueue *svq,
> > >           return NULL;
> > >       }
> > > +    detached_buf =3D vhost_svq_detach_buf(svq, last_used);
> > >       svq->num_free +=3D svq->desc_state[last_used].ndescs;
> > >       svq->desc_state[last_used].ndescs =3D 0;
> > > -    return vhost_svq_detach_buf(svq, last_used);
> > > +    return detached_buf;
> > >   }
> >
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> >
>


