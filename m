Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB66C3DA49
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2024 17:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sY7q7-0005JR-4S; Sun, 28 Jul 2024 13:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sY7q5-0005It-05
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 13:37:45 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sY7q3-0004ay-3Y
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 13:37:44 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-70d2b27c115so2030583b3a.2
 for <qemu-devel@nongnu.org>; Sun, 28 Jul 2024 10:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722188261; x=1722793061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7MlQahyTvyZQQXf2R5abhiy6+o/8vz4leVPw+uIZ6H4=;
 b=YhkOeO0EDKYFEy0YYZ0ONrP5pOf36e47Ac2bzvdoHFkdL2GdHy6cp24ZnGQgzI4CKP
 2U++kmQdbd+dwkLBb/f2VRZNRgYVnXF3hb+ltW8NLzuo5EkFgfmbW44PYoeBRM4M9tlE
 gbYrD3r6xvZrJ+gDCfG///l8/xY248dGmDlrASGrmrZYD0VSYukEDHkduJ5JCweqFKZU
 YAsM5pgyS/eV+cM5NrQ0S2kK07wjZnOhaLJhHQuSUwLHuyqqcIKJm7/gUlYSgaWN+Ma9
 XczfAemeLZRDX/UvhIT6PK6Sttt+qgZV2HWhiFGkpUGca+6X6gm9t2EsiZNCyAiomK4C
 tfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722188261; x=1722793061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7MlQahyTvyZQQXf2R5abhiy6+o/8vz4leVPw+uIZ6H4=;
 b=Dirn6HpgDnA8lfBbwbEtAcXABNvtl1IPhKWnyTchSye8NGcYvXSwlbLZcQKxRRqr7I
 Krx5so5rQMPbYMCWj7HvP2Sw2WUSU2l7JI23us3ww2+d91Ek4rcXkUagYsmvrgFdmsAe
 8YuLn8BlsqnvAF2Q7q5vja9p7gfx9l7nJS1VE/i3VkOue2+BolFLTJJLDaaP9JGCGSg5
 rWsOc2njtDJowLq1OJdv+IytWgYqNgHO/oGlv2zl1gh7P6MO6psnlLBj/Wc+/tOWSKp3
 9fmM+ttZFM0OaqIopnOnswXIWQUC+dWbmYmNnhVhCFa6dO2/HEBhLebedkwUTyJSN3ay
 tjpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFbHBIPN+a2UmvCzobRWSvwP61I6zB2c7CbAUQWI0ViJwoXkHsI3MXvu6EMLoz2Zd5TIXUxo5/u0Duh8Mtd3HmHzkDvI0=
X-Gm-Message-State: AOJu0Ywk3Mn8/OPOffl9N1DbAqVerCCDSNYBCEqh7tmmK4wWXBDCKoIs
 dPZ5E+gpLGiFT8w9hFZ2l0bloC5BeAfED82FAqs55i4LuDQzfBup
X-Google-Smtp-Source: AGHT+IEmF7vJlFpoa8uBPrfxSneSXYXUOS1l8XfaUwDRaEccVCPALyBSGjd8VGz7+adVKXrx94zmDA==
X-Received: by 2002:a05:6a00:2e87:b0:70d:323f:d0c6 with SMTP id
 d2e1a72fcca58-70eced9a5fbmr7250066b3a.24.1722188261323; 
 Sun, 28 Jul 2024 10:37:41 -0700 (PDT)
Received: from valdaarhun.localnet ([223.233.82.159])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead6e0c5esm5584716b3a.20.2024.07.28.10.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jul 2024 10:37:40 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Sahil Siddiq <sahilcdq@proton.me>
Subject: Re: [RFC v2 1/3] vhost: Introduce packed vq and add buffer elements
Date: Sun, 28 Jul 2024 23:07:37 +0530
Message-ID: <2957475.e9J7NaK4W3@valdaarhun>
In-Reply-To: <CAJaqyWdkbPd-zjbtn2JE9B-p6wx5f-sK1Ziv6bTqwSosLMpZfA@mail.gmail.com>
References: <20240726095822.104017-1-sahilcdq@proton.me>
 <20240726095822.104017-2-sahilcdq@proton.me>
 <CAJaqyWdkbPd-zjbtn2JE9B-p6wx5f-sK1Ziv6bTqwSosLMpZfA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=icegambit91@gmail.com; helo=mail-pf1-x433.google.com
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

On Friday, July 26, 2024 7:18:28=E2=80=AFPM GMT+5:30 Eugenio Perez Martin w=
rote:
> On Fri, Jul 26, 2024 at 11:58=E2=80=AFAM Sahil Siddiq <icegambit91@gmail.=
com> wrote:
> > This is the first patch in a series to add support for packed
> > virtqueues in vhost_shadow_virtqueue. This patch implements the
> > insertion of available buffers in the descriptor area. It takes
> > into account descriptor chains, but does not consider indirect
> > descriptors.
> >=20
> > Signed-off-by: Sahil Siddiq <sahilcdq@proton.me>
> > ---
> > Changes v1 -> v2:
> > * Split commit from RFC v1 into two commits.
> > * vhost-shadow-virtqueue.c
> >=20
> >   (vhost_svq_add_packed):
> >   - Merge with "vhost_svq_vring_write_descs_packed()"
> >   - Remove "num =3D=3D 0" check
> > =20
> >  hw/virtio/vhost-shadow-virtqueue.c | 93 +++++++++++++++++++++++++++++-
> >  1 file changed, 92 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/virtio/vhost-shadow-virtqueue.c
> > b/hw/virtio/vhost-shadow-virtqueue.c index fc5f408f77..c7b7e0c477 100644
> > --- a/hw/virtio/vhost-shadow-virtqueue.c
> > +++ b/hw/virtio/vhost-shadow-virtqueue.c
> > @@ -217,6 +217,91 @@ static bool vhost_svq_add_split(VhostShadowVirtque=
ue *svq,=20
> >      return true;
> > =20
> >  }
> >=20
> > +static bool vhost_svq_add_packed(VhostShadowVirtqueue *svq,
> > +                                const struct iovec *out_sg, size_t out=
_num,
> > +                                const struct iovec *in_sg, size_t in_n=
um,
> > +                                unsigned *head)
> > +{
> > +    bool ok;
> > +    uint16_t head_flags =3D 0;
> > +    g_autofree hwaddr *sgs =3D g_new(hwaddr, out_num + in_num);
> > +
> > +    *head =3D svq->vring_packed.next_avail_idx;
> > +
> > +    /* We need some descriptors here */
> > +    if (unlikely(!out_num && !in_num)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "Guest provided element with no descriptors");
> > +        return false;
> > +    }
> > +
> > +    uint16_t id, curr, i;
> > +    unsigned n;
> > +    struct vring_packed_desc *descs =3D svq->vring_packed.vring.desc;
> > +
> > +    i =3D *head;
> > +    id =3D svq->free_head;
> > +    curr =3D id;
> > +
> > +    size_t num =3D out_num + in_num;
> > +
> > +    ok =3D vhost_svq_translate_addr(svq, sgs, out_sg, out_num);
> > +    if (unlikely(!ok)) {
> > +        return false;
> > +    }
> > +
> > +    ok =3D vhost_svq_translate_addr(svq, sgs + out_num, in_sg, in_num);
> > +    if (unlikely(!ok)) {
> > +        return false;
> > +    }
> > +
>=20
> (sorry I missed this from the RFC v1) I think all of the above should
> be in the caller, isn't it? It is duplicated with split.

I don't think this will be straightforward. While they perform the same log=
ical
step in both cases, their implementation is a little different. For example=
, the
"sgs" pointer is created a little differently in both cases. The parameters=
 to
"vhost_svq_translate_addr" is also a little different. I think if they are =
moved to
the caller, they will be in both "svq->is_packed" branches (in "vhost_svq_a=
dd").

> Also, declarations should be at the beginning of blocks per QEMU
> coding style [1].

Sorry, I missed this. I'll rectify this.

Thanks,
Sahil



