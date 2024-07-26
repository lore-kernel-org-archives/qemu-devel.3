Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778D1C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 17:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXOTK-00061F-4v; Fri, 26 Jul 2024 13:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sXOTH-0005yf-Nz
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 13:11:12 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sXOTF-000857-LW
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 13:11:11 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1fd640a6454so9084305ad.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 10:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722013868; x=1722618668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Erz6ehpdJXQDZ8sLftaC+CoQQUJE9QOzFeYy2GFkg5A=;
 b=jSbQHHr5dq2Qz/UFB+v87jYGUphEGFdnC62mrWqbzqvlTbXbHbY6ZTsTMiFxVudsze
 zXh6krMtx9e+Ry1kP8TIPSxYB2KdWUlso49eztIVjbGSkAkzLkdRrgGnqrcM6/hJdXNX
 Ve1T6gIlMkAKFguaRiBAtWpenGh7TmNrBarrqJb3tP9WKKB4oFuVaLTNzhHrf2Q7ap9f
 hgnYq/zzhG22c1P7xUhBQbTNOXeEoIJjiKaRWqgNHO70WWiS95LdAXZ6BHDPh0Zqg5DA
 5vG6M+kx2CT09akJ7eYJ7IEdrs7Vb5aW9RoEkO1gvvwDZT7JtDxXMBHGPJtmQ+PRgYXT
 n7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722013868; x=1722618668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Erz6ehpdJXQDZ8sLftaC+CoQQUJE9QOzFeYy2GFkg5A=;
 b=IY0qDQd/4F6HxkgVVfrqkqoMiCTyxU5DtfiD1tXlHiMb4XJNavELHRwbEznnJYLOIL
 76hCYS8cPd+aSqZib72NUwuTiujqVOh7q2WEOSLZZbkT+TF3dhJz9mHnWs58qaL5wamk
 gEo+XF5uekUNSgOg/YAmX/kL90TKl0TQcMMUkEjz6xW44578v4CGPRaB74od4ew3HEey
 8nnlZEu/WPsCqhqu0y213ci008quLebWEUgdjjvHtcowqgzGqsu9NUbwZxVZPBKKrYcB
 cgkl8F5Ec4vr/2u2mk6fxA20HmCwe8rdTGY56zH9PqW2Sq71Rmi9ZfgHDvuTxZDuYLYQ
 /pkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGqG8BUBS0Y3qm3pEJ2Jbb3VX9vcplP49uUBLeLu2QbT7662NJChElwRBMwHjDL4fHZsjkYkPeiHbmCVFfixRmFH3i9bI=
X-Gm-Message-State: AOJu0YzTe8Z1OCYelh/gBJmmQW8UwT1vo0FafjXeDEWP/KHXO8nF4+dl
 DHQI7ZWaDO4iReoKtWwq/AAm1r+EQHySM7zgKNspJFUuKE3DjzuemzgulA==
X-Google-Smtp-Source: AGHT+IGNXqVq+IvJeTGZ/Qg0NUoYQD2Dtld3n+V9nfsRGJrgPcCbnjZ8vx0DBeH0pSdTxYFAK87tjw==
X-Received: by 2002:a17:902:e5cd:b0:1fb:8e00:e5e8 with SMTP id
 d9443c01a7336-1ff04808a05mr3474775ad.10.1722013867966; 
 Fri, 26 Jul 2024 10:11:07 -0700 (PDT)
Received: from valdaarhun.localnet ([223.233.82.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7ee3f5csm35097275ad.123.2024.07.26.10.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jul 2024 10:11:07 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Sahil Siddiq <sahilcdq@proton.me>
Subject: Re: [RFC v2 0/3] Add packed virtqueue to shadow virtqueue
Date: Fri, 26 Jul 2024 22:41:03 +0530
Message-ID: <7801595.EvYhyI6sBW@valdaarhun>
In-Reply-To: <CAJaqyWdZeohNn3BpD=Od9F9JekayYnXR-RBOn6OX_Oq4uYq5MQ@mail.gmail.com>
References: <20240726095822.104017-1-sahilcdq@proton.me>
 <CAJaqyWdZeohNn3BpD=Od9F9JekayYnXR-RBOn6OX_Oq4uYq5MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=icegambit91@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Friday, July 26, 2024 7:10:24=E2=80=AFPM GMT+5:30 Eugenio Perez Martin w=
rote:
> On Fri, Jul 26, 2024 at 11:58=E2=80=AFAM Sahil Siddiq <icegambit91@gmail.=
com> wrote:
> > [...]
> > Q1.
> > In virtio_ring.h [2], new aliases with memory alignment enforcement
> > such as "vring_desc_t" have been created. I am not sure if this
> > is required for the packed vq descriptor ring (vring_packed_desc)
> > as well. I don't see a type alias that enforces memory alignment
> > for "vring_packed_desc" in the linux kernel. I haven't used any
> > alias either.
>=20
> The alignment is required to be 16 for the descriptor ring and 4 for
> the device and driver ares by the standard [1]. In QEMU, this is
> solved by calling mmap, which always returns page-aligned addresses.

Ok, I understand this now.

> > Q2.
> > I see that parts of the "vhost-vdpa" implementation is based on
> > the assumption that SVQ uses the split vq format. For example,
> > "vhost_vdpa_svq_map_rings" [3], calls "vhost_svq_device_area_size"
> > which is specific to split vqs. The "vhost_vring_addr" [4] struct
> > is also specific to split vqs.
> >=20
> > My idea is to have a generic "vhost_vring_addr" structure that
> > wraps around split and packed vq specific structures, rather
> > than using them directly in if-else conditions wherever the
> > vhost-vdpa functions require their usage. However, this will
> > involve checking their impact in several other places where this
> > struct is currently being used (eg.: "vhost-user", "vhost-backend",
> > "libvhost-user").
>=20
> Ok I've just found this is under-documented actually :).
>=20
> As you mention, vhost-user is already using this same struct for
> packed vqs [2], just translating the driver area from the avail vring
> and the device area from the used vring. So the best option is to
> stick with that, unless I'm missing something.
>=20
>=20
> [1] https://docs.oasis-open.org/virtio/virtio/v1.3/virtio-v1.3.html
> [2]
> https://github.com/DPDK/dpdk/blob/82c47f005b9a0a1e3a649664b7713443d18abe4=
3/
> lib/vhost/vhost_user.c#L841C1-L841C25

Sorry, I am a little confused here. I was referring to QEMU's vhost-user
implementation here.

Based on what I have understood, "vhost_vring_addr" is only being used
for split vqs in QEMU's vhost-user and in other places too. The implementat=
ion
does not take into account packed vqs.

I was going through DPDK's source. In DPDK's implementation of vhost-user [=
1],
the same struct (vhost_virtqueue) is being used for split vqs and packed vq=
s. This
is possible since "vhost_virtqueue" [2] uses a union to wrap around the spl=
it and
packed versions of the vq.

> > My idea is to have a generic "vhost_vring_addr" structure that
> > wraps around split and packed vq specific structures, rather
> > than using them directly in if-else conditions wherever the
> > vhost-vdpa functions require their usage. However, this will
> > involve checking their impact in several other places where this
> > struct is currently being used (eg.: "vhost-user", "vhost-backend",
> > "libvhost-user").

I was referring to something similar by this. The current "vhost_vring_addr"
can be renamed to "vhost_vring_addr_split" for example, and a new struct
"vhost_vring_addr" can wrap around this and "vhost_vring_addr_packed"
using a union.

I liked the idea of using three unions for each member in the virtqueue for=
mat
instead of having one union for the whole format. I didn't think of this. I=
 think
by having three unions the "vhost_svq_get_vring_addr" [3] function won't ha=
ve
to be split into two new functions to handle split and packed formats separ=
ately.
I am not sure if this is what you were referring to.

Thanks,
Sahil

[1] https://github.com/DPDK/dpdk/blob/82c47f005b9a0a1e3a649664b7713443d18ab=
e43/lib/vhost/vhost_user.c#L861
[2] https://github.com/DPDK/dpdk/blob/82c47f005b9a0a1e3a649664b7713443d18ab=
e43/lib/vhost/vhost.h#L275
[3] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost-shad=
ow-virtqueue.c#L595



