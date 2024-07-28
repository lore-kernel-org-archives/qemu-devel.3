Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC41C3DA64
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2024 16:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sY6zT-0004eZ-EQ; Sun, 28 Jul 2024 12:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sY6zS-0004e1-1m
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 12:43:22 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sY6zQ-0003rW-37
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 12:43:21 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2cb674b48ccso1429726a91.2
 for <qemu-devel@nongnu.org>; Sun, 28 Jul 2024 09:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722184997; x=1722789797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UkotFGFcMUZuK5MzwYVJRL4ggb9lf16YyyN29NBeDyk=;
 b=kC5JyC6X15M+YLruWJ/nMZMW7vxGWr4ohoJQjAcIeTDsNOxb6sVh78cHSJeZpUh0oq
 qPLOtoxSoHax/RbFpOd8S1kEIkBuk0QwJtvAeU455tDuW70yg2HP2o77e8YCz/gxxwaM
 eNR0gEDFR/eQojJmAeeKN5GXuUqwCe1OM82+x1guUkSl3MhxkGKVqs/qPI6GD/4UiqWf
 nID30YJSqBiQF04Wp3UAT7wvR5wJspjsMOcWJbMqq4jF4QLPzolpwopGQGOQUzMdG764
 WZkFVTn1qBqqc7LRBk73jt4bik5DFYfc/ElB3Ojn4DRsZ5x4nDkW4oYodgRZaDGJtdSv
 h0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722184997; x=1722789797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UkotFGFcMUZuK5MzwYVJRL4ggb9lf16YyyN29NBeDyk=;
 b=tlIPSW7kYxJC4TgQQvLNhTkXgL65eL2jmLkyRLliCoeMsTEVuJAFnM8vWwRIfMAS9L
 3M0Dc0SrFpIRXNBoZiCV7fGEOt1A1oiLfnuPGNZcJT5WrH2AFvk6goa1Cm8Qo79uWXNb
 lzBam4MxRsb9CQ9gqifLMtWNqvmMYpIwDbc9a1A0K+maoA9m311EJOEShX7deo+yc4ig
 jc+W/6wPgwsUVfMxIw9emMOZSXERN2t0s/PeNeLkp2aRrUQAMRiQBtPg+uEtB4n65+02
 DdQI8JsiP++H5xYgoiiMRmXuC5s1nDBbgMZoSh0FWnVXp2dTvPa88YCKoGx5PBuUYYVa
 aSFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2KBSDJxk78Y2fEZXiVMm4unZdSzBXQOe4AsblB+YdywzpTOYLLjG9Krvkoi5Aw89WePlzPyVdPFnH9j3qWGhe9nfTls8=
X-Gm-Message-State: AOJu0YwCX1940qLCVpv4h5DF1W4Xmwdih1iWZ4Mxrhv2r8ZovNBlyybU
 yUabaDZF7bB/VfXPdFBlRGQknVENCW+XJDaZYKYRECzyI9M7AXdL
X-Google-Smtp-Source: AGHT+IHeGJi9aowCEk70GvFq8RVwgAtVI3VjNrPANNP4IuzxVo614sE45MymXYOmxtNW5C9o1GrZZA==
X-Received: by 2002:a17:90b:4f4c:b0:2c8:e888:26a2 with SMTP id
 98e67ed59e1d1-2cf7e1c171bmr3833784a91.13.1722184997283; 
 Sun, 28 Jul 2024 09:43:17 -0700 (PDT)
Received: from valdaarhun.localnet ([223.233.82.159])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c5578dsm6830382a91.2.2024.07.28.09.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jul 2024 09:43:16 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Sahil Siddiq <sahilcdq@proton.me>
Subject: Re: [RFC v2 0/3] Add packed virtqueue to shadow virtqueue
Date: Sun, 28 Jul 2024 22:12:58 +0530
Message-ID: <2343990.ElGaqSPkdT@valdaarhun>
In-Reply-To: <CAJaqyWdrOpeVOoK-VZYvcK809s9Gg5Dx_L76Mj03_omOtn4UrQ@mail.gmail.com>
References: <20240726095822.104017-1-sahilcdq@proton.me>
 <7801595.EvYhyI6sBW@valdaarhun>
 <CAJaqyWdrOpeVOoK-VZYvcK809s9Gg5Dx_L76Mj03_omOtn4UrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=icegambit91@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Friday, July 26, 2024 11:55:14=E2=80=AFPM GMT+5:30 Eugenio Perez Martin =
wrote:
> On Fri, Jul 26, 2024 at 7:11=E2=80=AFPM Sahil <icegambit91@gmail.com> wro=
te:
> > [...]
> > > > Q2.
> > > > I see that parts of the "vhost-vdpa" implementation is based on
> > > > the assumption that SVQ uses the split vq format. For example,
> > > > "vhost_vdpa_svq_map_rings" [3], calls "vhost_svq_device_area_size"
> > > > which is specific to split vqs. The "vhost_vring_addr" [4] struct
> > > > is also specific to split vqs.
> > > >=20
> > > > My idea is to have a generic "vhost_vring_addr" structure that
> > > > wraps around split and packed vq specific structures, rather
> > > > than using them directly in if-else conditions wherever the
> > > > vhost-vdpa functions require their usage. However, this will
> > > > involve checking their impact in several other places where this
> > > > struct is currently being used (eg.: "vhost-user", "vhost-backend",
> > > > "libvhost-user").
> > >=20
> > > Ok I've just found this is under-documented actually :).
> > >=20
> > > As you mention, vhost-user is already using this same struct for
> > > packed vqs [2], just translating the driver area from the avail vring
> > > and the device area from the used vring. So the best option is to
> > > stick with that, unless I'm missing something.
> > >=20
> > >=20
> > > [1] https://docs.oasis-open.org/virtio/virtio/v1.3/virtio-v1.3.html
> > > [2]
> > > https://github.com/DPDK/dpdk/blob/82c47f005b9a0a1e3a649664b7713443d18=
abe
> > > 43/
> > > lib/vhost/vhost_user.c#L841C1-L841C25
> >=20
> > Sorry, I am a little confused here. I was referring to QEMU's vhost-user
> > implementation here.
> >=20
> > Based on what I have understood, "vhost_vring_addr" is only being used
> > for split vqs in QEMU's vhost-user and in other places too. The
> > implementation does not take into account packed vqs.
> >=20
> > I was going through DPDK's source. In DPDK's implementation of vhost-us=
er
> > [1], the same struct (vhost_virtqueue) is being used for split vqs and
> > packed vqs. This is possible since "vhost_virtqueue" [2] uses a union to
> > wrap around the split and packed versions of the vq.
>=20
> Ok, now I get you better. Let me start again from a different angle :).
>=20
> vhost_vring_addr is already part of the API that QEMU uses between
> itself and vhost devices, all vhost-kernel, vhost-user and vhost-vdpa.
> To make non-backward compatible changes to it is impossible, as it
> involves changes in all of these elements.
>=20
> QEMU and DPDK, using vhost-user, already send and receive packed
> virtqueues addresses using the current structure layout. QEMU's
> hw/virtio/vhost.c:vhost_virtqueue_set_addr already sets vq->desc,
> vq->avail and vq->user, which has the values of the desc, driver and
> device. In that sense, I recommend not to modify it.
>=20
> On the other hand, DPDK's vhost_virtqueue is not the same struct as
> vhost_vring_addr. It is internal to DPDK so it can be modified. We
> need to do something similar for the SVQ, yes.
>=20
> To do that union trick piece by piece in VhostShadowVirtqueue is
> possible, but it requires modifying all the usages of the current
> vring. I think it is easier for us to follow the kernel's
> virtio_ring.c model, as it is a driver too, and create a vring_packed.
> We can create an anonymous union and suffix all members with a _packed
> so we don't need to modify current split usage.
>=20
> Let me know what you think.

Thank you for the detailed explanation. This makes sense to me now.
Since the three *_addr members (not counting log_guest_addr) in
"vhost_vring_addr" simply store addresses, a union is not required
here and these members can be reused in the case of packed format
as well.

> > > > My idea is to have a generic "vhost_vring_addr" structure that
> > > > wraps around split and packed vq specific structures, rather
> > > > than using them directly in if-else conditions wherever the
> > > > vhost-vdpa functions require their usage. However, this will
> > > > involve checking their impact in several other places where this
> > > > struct is currently being used (eg.: "vhost-user", "vhost-backend",
> > > > "libvhost-user").
> >=20
> > I was referring to something similar by this. The current
> > "vhost_vring_addr" can be renamed to "vhost_vring_addr_split" for
> > example, and a new struct "vhost_vring_addr" can wrap around this and
> > "vhost_vring_addr_packed" using a union.
> >=20
> > I liked the idea of using three unions for each member in the virtqueue
> > format instead of having one union for the whole format. I didn't think
> > of this. I think by having three unions the "vhost_svq_get_vring_addr"
> > [3] function won't have to be split into two new functions to handle
> > split and packed formats separately. I am not sure if this is what you
> > were referring to.
>=20
> But you need the if/else anyway, as the members are not vring_desc_t
> but vring_packed_desc, and same with vring_avail_t and vring_used_t
> with struct vring_packed_desc_event. Or am I missing something?

I was referring to having a union for each member in "vhost_vring_addr".
But based on your explanation above I don't think this would be required
either.

Thanks,
Sahil





