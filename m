Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D9FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2024 17:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdCFB-0005GL-2F; Sun, 11 Aug 2024 13:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sdCF9-0005Fl-SU
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 13:20:36 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sdCF8-0006EM-4C
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 13:20:35 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1ff4fa918afso21157485ad.1
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 10:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723396832; x=1724001632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wMbYqnbOieOsgh+FSColOA1P1rYTdb36qN+D9+ax72U=;
 b=C7q2vJfhBo80YWrmxNij9U25LS4mgw8OhoUb2d3cU3FN3dnZ7stXbkXWE16xOo5aoq
 JEJIfQwj2fHpUn1yhIzfX2Wpmeoq/XN4mJtCYS8Lr2TUwkC8YlI+n/Ey0FmOpqRKizCw
 bHIYRiGh8D1Up+4MWwM+87pzCFbyrXInsNEfk/JSQjhnqX5JlVWN5IYJUnQYNU9jEDjZ
 fohVtpK6nmteOWerIgNx16mfGMw25tQeLhOpTWv/HrplfQKirLsSlkmVVc/lqto0jx9U
 KwdQcktn2Xk1u/e7N0lvHts0KwbFsiVkvs4+GNGOqyKQz45RJS9/XQxQ+LDr0EPJi8hp
 DUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723396832; x=1724001632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wMbYqnbOieOsgh+FSColOA1P1rYTdb36qN+D9+ax72U=;
 b=D30SQ36U8rpMnPN7pyNlw/9DKCJa8xgCMmz7rAYkEZ7tSB69v4ZLz5yDf4C+1QVe3C
 kc6GoEgrqnOXKXhjmlOJLXoUao/8usIAWXJRrpLqbOOBHu88/iPC3Angt2LhnF5M4VM0
 RLl2dv+Y4qppmCjLeCGpAH+34zr4HygR07QIvO5zhrW7GJlhy8FyvUUWJKNbTzbQ6Q1C
 ECwponvaCUX/hKd/YWVlnT1axmuVcy7BmJLeAjfkDRA1+7lgJPaIWMduiCKhKxgiawDS
 K68Y1DoiDzqguXSKfPJd8mKX9pb0ixuUi6z/Gj4nLx/2z69mPI0nGbM7UunLFNY+Dybj
 DDrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGVRtZLfLNNd/LWN6Ixk67woj7upxCFNtyp0aTUlhKiKGAYFtJ7eXWeEsfog7nTwBoJKB0JyGiIlzDh09wlW962KWwoIY=
X-Gm-Message-State: AOJu0Yz4fDL6qC3yKWaEhfYcHEXQXdq9jR6KJwkWXeBtw0cAN10otCRl
 ivdMMJ8zPIFQKUwRyEwxARKbwjlcBdRGNIkQ6HUsLX94ajBQCMMYWuGVPw==
X-Google-Smtp-Source: AGHT+IEhHjdzem37eTLybDbdRgEw8CpMewLrxdkVWpNuEHgKXET3Q8SIQYee65Mm8EPyNYVxQE86sw==
X-Received: by 2002:a17:902:e54e:b0:1f9:b9ed:e84e with SMTP id
 d9443c01a7336-200ae5f3127mr67032885ad.58.1723396832192; 
 Sun, 11 Aug 2024 10:20:32 -0700 (PDT)
Received: from valdaarhun.localnet ([223.233.81.106])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-200bba00771sm24776355ad.225.2024.08.11.10.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 10:20:31 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Sahil Siddiq <sahilcdq@proton.me>
Subject: Re: [RFC v3 3/3] vhost: Allocate memory for packed vring
Date: Sun, 11 Aug 2024 22:50:27 +0530
Message-ID: <23656540.6Emhk5qWAg@valdaarhun>
In-Reply-To: <CAJaqyWcrcEJimGqF3_K7YWCobPw00Yx+rcYQH1JXGcKesb5M2w@mail.gmail.com>
References: <20240802112138.46831-1-sahilcdq@proton.me>
 <20240802112138.46831-4-sahilcdq@proton.me>
 <CAJaqyWcrcEJimGqF3_K7YWCobPw00Yx+rcYQH1JXGcKesb5M2w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi,

On Wednesday, August 7, 2024 9:52:10=E2=80=AFPM GMT+5:30 Eugenio Perez Mart=
in wrote:
> On Fri, Aug 2, 2024 at 1:22=E2=80=AFPM Sahil Siddiq <icegambit91@gmail.co=
m> wrote:
> > [...]
> > @@ -726,17 +738,30 @@ void vhost_svq_start(VhostShadowVirtqueue *svq, V=
irtIODevice *vdev,
> >      svq->vring.num =3D virtio_queue_get_num(vdev,
> >      virtio_get_queue_index(vq));
> >      svq->num_free =3D svq->vring.num;
> >=20
> > -    svq->vring.desc =3D mmap(NULL, vhost_svq_driver_area_size(svq),
> > -                           PROT_READ | PROT_WRITE, MAP_SHARED | MAP_AN=
ONYMOUS,
> > -                           -1, 0);
> > -    desc_size =3D sizeof(vring_desc_t) * svq->vring.num;
> > -    svq->vring.avail =3D (void *)((char *)svq->vring.desc + desc_size);
> > -    svq->vring.used =3D mmap(NULL, vhost_svq_device_area_size(svq),
> > -                           PROT_READ | PROT_WRITE, MAP_SHARED | MAP_AN=
ONYMOUS,
> > -                           -1, 0);
> > -    svq->desc_state =3D g_new0(SVQDescState, svq->vring.num);
> > -    svq->desc_next =3D g_new0(uint16_t, svq->vring.num);
> > -    for (unsigned i =3D 0; i < svq->vring.num - 1; i++) {
> > +    svq->is_packed =3D virtio_vdev_has_feature(svq->vdev, VIRTIO_F_RIN=
G_PACKED);
> > +
> > +    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_RING_PACKED)) {
> > +        svq->vring_packed.vring.desc =3D mmap(NULL, vhost_svq_memory_p=
acked(svq),
> > +                                          PROT_READ | PROT_WRITE, MAP_=
SHARED | MAP_ANONYMOUS,
> > +                                          -1, 0);
> > +        desc_size =3D sizeof(struct vring_packed_desc) * svq->vring.nu=
m;
> > +        svq->vring_packed.vring.driver =3D (void *)((char *)svq->vring=
_packed.vring.desc + desc_size);
> > +        svq->vring_packed.vring.device =3D (void *)((char *)svq->vring=
_packed.vring.driver +
> > +                                     sizeof(struct vring_packed_desc_e=
vent));
>
> This is a great start but it will be problematic when you start
> mapping the areas to the vdpa device. The driver area should be read
> only for the device, but it is placed in the same page as a RW one.
>
> More on this later.
>=20
> > +    } else {
> > +        svq->vring.desc =3D mmap(NULL, vhost_svq_driver_area_size(svq),
> > +                               PROT_READ | PROT_WRITE, MAP_SHARED |MAP=
_ANONYMOUS,
> > +                               -1, 0);
> > +        desc_size =3D sizeof(vring_desc_t) * svq->vring.num;
> > +        svq->vring.avail =3D (void *)((char *)svq->vring.desc + desc_s=
ize);
> > +        svq->vring.used =3D mmap(NULL, vhost_svq_device_area_size(svq),
> > +                               PROT_READ | PROT_WRITE, MAP_SHARED |MAP=
_ANONYMOUS,
> > +                               -1, 0);
> > +    }
>=20
> I think it will be beneficial to avoid "if (packed)" conditionals on
> the exposed functions that give information about the memory maps.
> These need to be replicated at
> hw/virtio/vhost-vdpa.c:vhost_vdpa_svq_map_rings.
>=20
> However, the current one depends on the driver area to live in the
> same page as the descriptor area, so it is not suitable for this.

I haven't really understood this.

In split vqs the descriptor, driver and device areas are mapped to RW pages.
In vhost_vdpa.c:vhost_vdpa_svq_map_rings, the regions are mapped with
the appropriate "perm" field that sets the R/W permissions in the DMAMap
object. Is this problematic for the split vq format because the avail ring =
is
anyway mapped to a RW page in "vhost_svq_start"?

=46or packed vqs, the "Driver Event Suppression" data structure should be
read-only for the device. Similar to split vqs, this is mapped to a RW page
in "vhost_svq_start" but it is then mapped to a DMAMap object with read-
only perms in "vhost_vdpa_svq_map_rings".

I am a little confused about where the issue lies.

Thanks,
Sahil



