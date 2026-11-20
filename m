Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8273D606A326
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 11:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VC8SYPzR;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=HO+LtACf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUMM6-000065-UA; Fri, 20 Nov 2026 06:00:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1xUMM5-00005l-Nd
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 06:00:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1xUMM3-0000qc-Tg
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 06:00:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795172429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uPAId5lZKbw1zDWb3K3gUUhylVwg90AOuquEeBNzZGA=;
 b=VC8SYPzRnEwbq2usQwA6BHwMPT5TI2qjwOJZaRpd+FBNpNQI+NDHu0JiJ7vd4YPKnxXu0+
 cTR4Yu6ejpohjDqeu1jaun/MEaAU9MbU3s+yuDeVlr+0aR54b5VdYaVAP5818T33j4JlYE
 GVHtl1oF8xCZrWAxJK0UfUAJ9U3Kbpg=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-3fGBVfLgOSaBBUwdUexq4A-1; Fri, 20 Nov 2026 11:00:27 +0000
X-MC-Unique: 3fGBVfLgOSaBBUwdUexq4A-1
X-Mimecast-MFC-AGG-ID: 3fGBVfLgOSaBBUwdUexq4A_1795172427
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-677c4ca2265so1394968d50.2
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 03:00:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795172427; cv=none;
 d=google.com; s=arc-20260327;
 b=AOcpScPhmtVn5dYgBoeS7RyUQbxUD7MdrpwZwNcEAAGH1N/1yFI9+JyyVzBpgC0JrW
 5ENynWxJsvN8yumTmAUvUiGqFOfMmws3yrKULopXFBNQ31OcE+1al5TaVacbfBSCBOU7
 DKBQIA8LUQRXqetyhHAFWw4JeJxcj5Pk0VCgP7q8PJ7o/AEoAM6NkR6AL09eBvi3Sg2h
 2hRI+ZO4GhyUkh9A3C4hw2BCyyM/X6TEGo4aKMAe6HLnNxSR8jIqvfgRDJPJhWuvWNw5
 E3de2gYweWWEMJWs0i8xCvQ+Gzg3yUmwsQOUMQWxDk51la4uvmsl9+65NCg4Dq5AxXWm
 Zaww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uPAId5lZKbw1zDWb3K3gUUhylVwg90AOuquEeBNzZGA=;
 fh=xg//tmfYhU4RsZeBdbfJl6ssYnXBM6cRDXSJRvxcV/U=;
 b=fwKApcPVhYgoid5FFFXb/Hoet6aWAaJjP0TtjDkzUM9zz1gyU+Ya0Sb13kQEmOEofl
 rbdN3sQ1aF2F1mOGvDtkGMFDe8A4GNA5Oifog+dh3DOZ1KClX5ToS/WWJ2hI0ZejtJV+
 Rf+1tRMK+NYo5sG48FHmYpOO+7pmSCtfQuEmnuvB4mugDbpEful2f9waf/xEatrKJoY+
 lf03r56hz4OPNc6M/ilnZvsMkX7DVu1rLvcwSU5vK5lYE8F5VNUmVqertl90kWkBrmCT
 gwc5UdzpVeujBX5kR9xDu2Cr8rPJLlK1KB2JYRYXHALBcnqgUQbkE8DI3rgV89Mcxxkz
 L23Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795172427; x=1795777227; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uPAId5lZKbw1zDWb3K3gUUhylVwg90AOuquEeBNzZGA=;
 b=HO+LtACfzo5G74ahgBoh5BPtOSoUXCK62auUXdoVZPn2MPJkma2lnJm+oNuzo858pT
 1oEK/+6PuT4f8CO35DiOTe34Xie+YKnQ00h12fjjI1RX5mUhupNIcO7W+rVaCA7u2hXU
 pIjFPj42dBOdVm02ton+htivCFdfMoQp0qdJiKyWHArUWmu903im2A3R2YLBzK1KX9gK
 A6+E670BvDya7oONVUP8sUfjjTOJzBHXPEjwk3NsSIg2LGgic1lq2yObD5U/hY7pVXFz
 84uJoqlWWWOoNFkDgfJyGi9mQv1BbPdB70Y9AsqXqxYCzpq3tLop1FFdaqK5C1D9MdsD
 SwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795172427; x=1795777227;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uPAId5lZKbw1zDWb3K3gUUhylVwg90AOuquEeBNzZGA=;
 b=HNR/pZrfN5Fn/hlRCSW1b2FS4U4ceggSK0AbV7sx2bdknhTgqglg/Ex0R2SiEuEOSg
 ijdBSUkGchQxHzFcuAn9aOpPPI5YrpOQ4Y2nHDRqVFnPcNI6uR6gLRIvyYtmp3ls+u99
 UChlLiLiYkOxa4c4dH1AE0DuhHVZH2+Oc0kK1X0SqjypD8KalRNaiieHXw4nDlUx9sqN
 rlNUOAjcwhhmpH/TCW3nOWj+9gckgiN+lnXTaZbGceMqHkG3YaLazRe0KeAZBbI9X2mp
 Sxvr5v3t6Yof4ueoFfcQjRaQY2WzFL/N5ipKaYrJyD2BeQe+p8Q/6Z97h+mdZ2ccjT1z
 emOg==
X-Forwarded-Encrypted: i=1;
 AL+hErHk1deN5anbOQxuEg8XnkY1XKhwSwffM9YFrYHT17+RUC0nI/jVKF79feJJnlvg8ppuWfV4KLxFc5iO@nongnu.org
X-Gm-Message-State: APuU4Z+GQCmcEF+iv0OSHend2+UTaK6MxR0s42yLVXq7FjafY/34nMjj
 8+dRSAnbWC2qi3wXfCJXYgoehO0dEh+5RObOe09xSATnR14UNBbKr0yqq0IhNl3rQUQqapWddVc
 sXhyZab8AizMd7tzdANb1bnKOzDdl49l0Qr5RzdLd9bytP/MRweJdF2q1RVs0z4b3jzqXaAruFR
 w9SDROa9GGkhGdF+qM2fXpUAJAiTZqkzA=
X-Gm-Gg: AZFdTZd1l+UlLwMrhs0Ygs/ZkdKwGzS1K2KLNSoCAaf5Dbh58T95Z2xVTOCNMgiraGS
 cTP8HLU0BnrsW61vcFWzmawmigCeo+dujUBHRfVTizRCF7/Iw3A/dIjaOM8dDGEPeV2PJ/ZWBpD
 pgyTHc4ipoTjqXuIrimfuu3o+oSwt888McU+qsnO8uYJVia3mlzBis8dzpKWxvEd7uTC3Uq0VVu
 2B76xMwtD1jxRcZ0dSWswsD8tZmmrt4XIb2sRs93jEarxJ02HrGLtu3GSg=
X-Received: by 2002:a05:690e:1512:b0:67d:eb6d:7451 with SMTP id
 956f58d0204a3-67df4422c68mr933668d50.33.1795172427097; 
 Fri, 20 Nov 2026 03:00:27 -0800 (PST)
X-Received: by 2002:a05:690e:1512:b0:67d:eb6d:7451 with SMTP id
 956f58d0204a3-67df4422c68mr933660d50.33.1795172426439; Fri, 20 Nov 2026
 03:00:26 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104020053.2548-1-lirongqing@baidu.com>
 <c50d636e-a719-4d1c-bb7d-3b2549bd5cfb@tls.msk.ru>
In-Reply-To: <c50d636e-a719-4d1c-bb7d-3b2549bd5cfb@tls.msk.ru>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 20 Nov 2026 11:59:50 +0100
X-Gm-Features: AclHuK8B_vAy7Tqen1jy6StXijD61zLNfZzFI9tZ736yYtD60WcGD0spFZ_oD0U
Message-ID: <CAJaqyWcQJQH-PBLEJb2P33vMsjmPA4itAcwA0Ctn2vDN+pU_vg@mail.gmail.com>
Subject: Re: [PATCH] virtio: Reset free_head on shadow virtqueue start
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: lirongqing <lirongqing@baidu.com>, mst@redhat.com, 
 Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org, 
 QEMU Stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
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

On Fri, Nov 20, 2026 at 9:13=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> On 11/4/26 05:00, lirongqing wrote:
> > From: Li RongQing <lirongqing@baidu.com>
> >
> > free_head tracks the index of the next free descriptor in the SVQ
> > descriptor ring.  It is used by vhost_svq_vring_write_descs() to
> > choose where to place new descriptors, and is updated as descriptors
> > are allocated and recycled.
> >
> > free_head is zero-initialized when the SVQ is created through
> > vhost_svq_new() (g_new0), but it is not reset in vhost_svq_start().
> > The start function already resets the rest of the ring state
> > (shadow_avail_idx, shadow_used_idx, last_used, last_used_idx and
> > num_free), yet free_head is left untouched.
> >
> > Since an SVQ can be stopped and restarted on the same object, for
> > example across vDPA device migration or control virtqueue processing,
> > a stale free_head from the previous run survives into the new one.
> > This causes new descriptors to be written at the wrong position of
> > the SVQ descriptor ring, corrupting it.
> >
> > Reset free_head to 0 in vhost_svq_start() so that descriptor
> > allocation always begins from the head of a fresh ring.
> >
> > Fixes: 100890f7cad5 ("vhost: Shadow virtqueue buffers forwarding")
> > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > ---
> >   hw/virtio/vhost-shadow-virtqueue.c | 1 +
> >   1 file changed, 1 insertion(+)
>
> That smells like a qemu-stable material, is it not?
>

Right, thanks for noticing that!

> Thanks,
>
> /mjt
>
> > diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shado=
w-virtqueue.c
> > index c97bd9f..462c86d 100644
> > --- a/hw/virtio/vhost-shadow-virtqueue.c
> > +++ b/hw/virtio/vhost-shadow-virtqueue.c
> > @@ -857,6 +857,7 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, Vir=
tIODevice *vdev,
> >       svq->shadow_used_idx =3D 0;
> >       memset(&svq->batch_last, 0, sizeof(svq->batch_last));
> >       svq->last_used =3D 0;
> > +    svq->free_head =3D 0;
> >       svq->last_used_idx =3D 0;
> >       svq->vdev =3D vdev;
> >       svq->vq =3D vq;
>
>


