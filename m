Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4494DC3DA49
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2024 13:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sY49j-0003DX-Be; Sun, 28 Jul 2024 09:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sY49d-0003CE-8o
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 09:41:41 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sY49b-0003Qr-Is
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 09:41:41 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-70cec4aa1e4so1626575b3a.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jul 2024 06:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722174097; x=1722778897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kYw9NpI3grwEpKjoOfNA+8xPHPhDoXPkwUUOboD9A/4=;
 b=H2uMTQM2w4bgRpGwN2i8lF0rE2npeOvucUoOVqN+s4CN5Kmji9yV5YRFRm1AHBF8od
 fXwYoSbwQmbcAF3lTyWDQ3ueDdEPlwl49NLu/fU99tpcimoE9CcXGpoIHdhUyZvVpwY1
 DYtaLfxjiCC0QN0qNg1GWs8fcYVmzLDaNSH9iZCk+265j0IwFmaPyJ2i6QDQa0OaBI/N
 jdDI6JigiwlinDPSCXlGaGscBoboGNbWdYYAEAEPhFI7PRpkIGjPByma5Qd8U2QnGZPY
 mm5M48c8lEQCocsNDXoHvuNRNOcAIjxaaxBANyzJir8fKv5KCc74O38JQxiAqRQJRg8b
 HDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722174097; x=1722778897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kYw9NpI3grwEpKjoOfNA+8xPHPhDoXPkwUUOboD9A/4=;
 b=ZUKVFjVALqEHJhWNekmHaMJwegZnW2O91vDll6xl4dxqHxf6NQqD+pvPeQPkhELZcl
 gzby1ha+QEaFZloixhTq9s+71W3ojc84Fkz45Lu/1UWNJXM7oN/dwOi+7iXlSIKIqaky
 00u3hYpNW6xxnSTANMSjGVUHZdzbZROBpjOL+BSSgNK+Zk06XA4dN5r6+1+4rQCd2bcr
 GYxVVEWYPhvzWCP4LcmXLwWNR0hvwHQ8dVmbjKjfFUv3+Uqcm64NkYJ5zHmU1fV3ymD1
 d4v5pefnzAO1tvTGfDBXSfSJZOHh8cbZatQtkDrQHJsoEa8ENHQxz36ZYdxYsmvhhOK6
 2+5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMW5AkzEjjjLyOb0b4Ty5YfyeLCBXCgiKCrqB8hXHb0p+8IM2E6/SVH6PXWzvy7at//ARBus0+/RkJlD+vyNzuDvKicpY=
X-Gm-Message-State: AOJu0YwkRADIhIElsey5bKOT9iyOeXLZebDG/+a+lg+4BA6NZSNFqNWu
 mXUxhxn5erwXQaty8EBkbeXkC/aLHrgPUphPYjMKAWjkzeV4NOiN
X-Google-Smtp-Source: AGHT+IHQERbf6+R6cHUaRXPh3CMiQ9zYwslke8dJZ2k/EVd87Iwq4Kdb/G4xlMiEn+31nyL4gbvqyQ==
X-Received: by 2002:a05:6a00:4f96:b0:70d:33b3:2d7f with SMTP id
 d2e1a72fcca58-70ecedb22dbmr5777811b3a.26.1722174096987; 
 Sun, 28 Jul 2024 06:41:36 -0700 (PDT)
Received: from valdaarhun.localnet ([223.233.82.46])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a9f8369027sm4887318a12.38.2024.07.28.06.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jul 2024 06:41:36 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Sahil Siddiq <sahilcdq@proton.me>
Subject: Re: [RFC v2 3/3] vhost: Allocate memory for packed vring.
Date: Sun, 28 Jul 2024 19:11:32 +0530
Message-ID: <2751519.mvXUDI8C0e@valdaarhun>
In-Reply-To: <CAJaqyWeNBw=xqmFLPx40VuRGuAW9ntYcAUVXK0GKHzdxTTBoVQ@mail.gmail.com>
References: <20240726095822.104017-1-sahilcdq@proton.me>
 <20240726095822.104017-4-sahilcdq@proton.me>
 <CAJaqyWeNBw=xqmFLPx40VuRGuAW9ntYcAUVXK0GKHzdxTTBoVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=icegambit91@gmail.com; helo=mail-pf1-x432.google.com
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

On Friday, July 26, 2024 7:58:49=E2=80=AFPM GMT+5:30 Eugenio Perez Martin w=
rote:
> On Fri, Jul 26, 2024 at 11:59=E2=80=AFAM Sahil Siddiq <icegambit91@gmail.=
com> wrote:
> > [...]
> > @@ -759,19 +780,34 @@ void vhost_svq_start(VhostShadowVirtqueue *svq,
> > VirtIODevice *vdev,>=20
> >      svq->vq =3D vq;
> >      svq->iova_tree =3D iova_tree;
> >=20
> > -    svq->vring.num =3D virtio_queue_get_num(vdev,
> > virtio_get_queue_index(vq)); -    svq->num_free =3D svq->vring.num;
> > -    svq->vring.desc =3D mmap(NULL, vhost_svq_driver_area_size(svq),
> > -                           PROT_READ | PROT_WRITE, MAP_SHARED |
> > MAP_ANONYMOUS, -                           -1, 0);
> > -    desc_size =3D sizeof(vring_desc_t) * svq->vring.num;
> > -    svq->vring.avail =3D (void *)((char *)svq->vring.desc + desc_size);
> > -    svq->vring.used =3D mmap(NULL, vhost_svq_device_area_size(svq),
> > -                           PROT_READ | PROT_WRITE, MAP_SHARED |
> > MAP_ANONYMOUS, -                           -1, 0);
> > -    svq->desc_state =3D g_new0(SVQDescState, svq->vring.num);
> > -    svq->desc_next =3D g_new0(uint16_t, svq->vring.num);
> > -    for (unsigned i =3D 0; i < svq->vring.num - 1; i++) {
> > +    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_RING_PACKED)) {
> > +        svq->is_packed =3D true;
> > +        svq->vring_packed.vring.num =3D virtio_queue_get_num(vdev,
> > virtio_get_queue_index(vq)); +        svq->num_free =3D
> > svq->vring_packed.vring.num;
> > +        svq->vring_packed.vring.desc =3D mmap(NULL,
> > vhost_svq_memory_packed(svq), +                                        =
 =20
> >  PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, +                 =
 =20
> >                         -1, 0);
> > +        desc_size =3D sizeof(struct vring_packed_desc) * svq->vring.nu=
m;
> > +        svq->vring_packed.vring.driver =3D (void *)((char
> > *)svq->vring_packed.vring.desc + desc_size);

> (Expanding on the cover letter comment) Here the driver area is
> aligned properly too as each descriptor is 16 bytes length, and
> required alignment for the driver area is 4 bytes by VirtIO standard.

Ok, this makes sense now.

> > +        svq->vring_packed.vring.device =3D (void *)((char *)svq-
>vring_packed.vring.driver +
> > +                                     sizeof(struct vring_packed_desc_e=
vent)); +    } else {
> > +        svq->is_packed =3D false;
> > +        svq->vring.num =3D virtio_queue_get_num(vdev, virtio_get_queue=
_index(vq));
> > +        svq->num_free =3D svq->vring.num;
>=20
> Nitpicks,
>=20
> The variables is_packed and num_free can be merged out of the if/else
> to reduce code duplication.
>=20
> Also it is clearer to me to assign svq->is_packed =3D
> virtio_vdev_has_feature(...) and then check the variable in the if.
> But other parts of QEMU do as you do here so I don't have a strong
> opinion.

I think your suggestion will reduce code duplication. I'll change this.

> > [...]
> > @@ -146,10 +149,13 @@ size_t vhost_svq_poll(VhostShadowVirtqueue *svq, =
size_t num);
> >=20
> >  void vhost_svq_set_svq_kick_fd(VhostShadowVirtqueue *svq, int svq_kick=
_fd);
> >  void vhost_svq_set_svq_call_fd(VhostShadowVirtqueue *svq, int call_fd);
> > -void vhost_svq_get_vring_addr(const VhostShadowVirtqueue *svq,
> > -                              struct vhost_vring_addr *addr);
> > +void vhost_svq_get_vring_addr_split(const VhostShadowVirtqueue *svq,
> > +                                    struct vhost_vring_addr *addr);
> > +void vhost_svq_get_vring_addr_packed(const VhostShadowVirtqueue *svq,
> > +                                     struct vhost_vring_addr *addr);
> >=20
> >  size_t vhost_svq_driver_area_size(const VhostShadowVirtqueue *svq);
> >  size_t vhost_svq_device_area_size(const VhostShadowVirtqueue *svq);
> >=20
> > +size_t vhost_svq_memory_packed(const VhostShadowVirtqueue *svq);
>=20
> Ok now I get the question on the cover letter better,
>=20
> It is ok to reuse the already present functions, no need to create new
> ones to export in this header.

I think "vhost_svq_memory_packed" will be required while the others can be
removed.

Thanks,
Sahil



