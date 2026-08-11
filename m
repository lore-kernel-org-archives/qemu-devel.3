Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD49C5AD7B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 06:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtfz3-0003AM-AV; Tue, 11 Aug 2026 02:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wtfyt-00038W-VT
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:29:01 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wtfyr-00017c-7W
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 02:28:58 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-52d5bfa4bafso131761cf.3
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 23:28:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786429736; cv=none;
 d=google.com; s=arc-20260327;
 b=Q8Lfhzfmzod6KKB2xUfExQ1BDc3Dl5SyZXOStWs4d8Mg6ZydMa3Ourw4c65aafGGpT
 sLx/5eu9ESHA6tXQ8DVTepIhkoN+vFk66KpEjQOCHus+6uF1DyjEoXGaJxv6+eelVzIZ
 ECUg/7OPDZodcQRlM/+ZsMEXZ6kpHtbAFUm/UbfAvJyF1tbWYJ1MeD/yCLOFMlGSoGlI
 +ePohYMUoSL1kDaMMPIlPhJ48dYCRvCCSaR44xMEPZWNkrKJQl2r2PjciN9Nnp5N0Igv
 tpd1yreeJXDCr9q6wwxD2qoZWdRIYahch3Cb1MNLGsqxjVH3PezBCDLdEaFFZc0rmlTZ
 MjOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=q55nAj0wvf6AevCEGFeSNE9kkBxxi2Gq440bDilNO00=;
 fh=KDk387A1+PRrP73gRLCRtBl8PbehjOWW2KJG+BrFQO4=;
 b=p9Yb7g52u0genmV4G4LdTVY7k+iDuUh9n56HWyGh6jgSEmk/IgO7c56mrzs8Z+Z/QP
 TSV3rD0UTbCrVqrVt31sxcFptBwDOAZLYyrg4yPdhz3aI8v1l4VKwvvnd5s3e17tewVl
 hS+12ZvZV32yfTGpgYr4mzt8Yr7AtZUuZ1ooVz1XQmckLpbHZgvlEI5R4prvEi21OEsV
 erylVoOHKxUlj20Z3czceAZggeitEJQSzD5uKaMY2vWMfwV+K+8KGIUzEVMAjVEL28Fr
 DWPBqpXZIXBVVvkf72ifMHS2zFmMImX6Y6ta69Z3qpvGvjUZd5OBcOooH58lNpEfKFe6
 A0HA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786429736; x=1787034536; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=q55nAj0wvf6AevCEGFeSNE9kkBxxi2Gq440bDilNO00=;
 b=JldNG42UEMmGSJ6L2Wqtxq7eXI8m1Np0TO+DxA0hQifDwDVq5dUgEHi2ulctshb1sq
 +03JC0BFvo0PN0RJnCKrOHjkcVU4EPn3CIyBuODQ2mmhFN4SzRWZTMPLiAmIhaFlF2pQ
 CO2crz9tUkGnVLZCD8kJtBpn3CLNBvGspgqlJh1wO12BBusgAJbO1Gp2sBA6rXXeLK5I
 aBdVhbYyldH2q9mWMxAhTahLYSWu4DwtMz/jI7ZxY1+ZhT+KUXzHgJN8SsnJVLn3N35y
 fJk6MINrUBcyOdXFboxmZpyIr+3EPURje/tS6Za5O242IncfDaNronUiOig4Hf4x7C08
 0jMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786429736; x=1787034536;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q55nAj0wvf6AevCEGFeSNE9kkBxxi2Gq440bDilNO00=;
 b=tIQxPX7JSkMnOOWGMBgOPb8v41qyBSA+6U6VsoBCiof24uIzMF+arUmKicgqvQaQrT
 SCi7sUUZFiMUna0EDNukmwbDkoWafxzNcmWML/xERhDzha4YmA4/aOA6DBGdmw9FHieT
 vs8lAfd/wbXDqlEzl1Xv4/XtRQQ39jwmwhGZpcAwT942kmqaZgirRcw2eg63pOChSwrZ
 P0YEcvlv1hKvijuzVAJ9GO71iXiQEG6573db8meULUek1Abc+NMF21OHpkLxv61oahQm
 3GDP6Y7MbtQxcBtrBEnCSM6QfcDxwH8KrRZ3GZiy9iinmCRkjfzbOJp7IweeQSeTryUx
 0bNQ==
X-Gm-Message-State: AOJu0Yz08q/rnNQgRad4CtfgT4SOuCtqc520va56EjJX8pTA2Rr9o4Aa
 PMRsF5Om9e99rb9uLfj+xE7wM4UL9dnEV6OFqw7MI7FFx09iUnqbW3soYOVKU0fUFFzoFdVlTkL
 qSBIZakgyoZ+V4SLohOXn7JpkZoAYoJc=
X-Gm-Gg: AR+sD11O8aN1HCGnIQoOcbscUWXrHa7IHKxfVshkdTI0TtVTx5CkE8vqNGMQiI65fr6
 ucL9vxiWc6EFKKFdBntYW2BvIk2yWIvYNVO33r/YDxN0Osr8+qvwgYclXZhLnmphMw/6UmF/fJM
 5Ke7ajENCzlmwBzhPHExYdPeT1pIjWUCUBXSYVetq1rsUOXH2sqeMeYXzwjwKitqTTCocOrB3uJ
 WqwTRp8Jp7zJL7psYw6KrPvi0RgL5wBRNrvAJITRTaLaDFrepeL0NWGNZNeApLoOVFFg0j50xsn
 qKWXONrVAmyzVkpb6+tfBielcHUjpRzroxxt/qMg5pUUxhO3e9sbHkBjCAQYKebp8Dtr3+b4BDG
 IIHw=
X-Received: by 2002:ac8:5cc1:0:b0:51c:2068:a9f8 with SMTP id
 d75a77b69052e-52d5849587emr8908861cf.5.1786429736098; Mon, 10 Aug 2026
 23:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-14-6b97c439eb28@gmail.com>
 <20260728205728.GL371693@fedora>
In-Reply-To: <20260728205728.GL371693@fedora>
From: Connor Kite <connorkite@gmail.com>
Date: Mon, 10 Aug 2026 23:28:45 -0700
X-Gm-Features: AUfX_mzDej6OfzJGyINW_W_w6Z7pGsHtQUxPBWQtT9pRtZeJZNjLDViu7ukeDnU
Message-ID: <CA+spn3qnRrEYLzMS+MRPg0c1UYisp68fFXp-GQzs_chKSr6XeA@mail.gmail.com>
Subject: Re: [PATCH RFC 14/15] hw/virtio/vhost-user: handle data movement with
 shadow vqs
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Milan Zamazal <mzamazal@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=connorkite@gmail.com; helo=mail-qt1-x830.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jul 28, 2026 at 1:57=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> > +
> > +    for (int i =3D 0; i < elem->out_num; i++) {
> > +        needle.translated_addr =3D elem->out_addr[i];
> > +        needle.size =3D elem->out_sg[i].iov_len - 1;
> > +        map =3D vhost_iova_tree_find_gpa(svq->iova_tree, &needle);
>
> Mapping failure must be handled.
>

Got it!  This will be fixed.

> > +        offset =3D needle.translated_addr - map->translated_addr;
> > +        iova_base =3D (void *)(map->iova + offset);
> > +
> > +        elem->out_sg[i].iov_base =3D iova_base;
> > +        memcpy(iova_base, elem->out_sg[i].iov_base, needle.size + 1);
>
> iova_base is an iova, not QEMU memory (HVA). Memcpy cannot be used with
> IOVAs. The address of the mapped shared memory is needed as the
> destination instead.
>

This is a relic of how the IOVA space was originally really just the
hva of the shared
memory.   However, as you noted, that wasn't great for security.  Now that =
those
address spaces are separate, the call is adjusted.

> > +    }
> > +
> > +    for (int i =3D 0; i < elem->in_num; i++) {
> > +        needle.translated_addr =3D elem->in_addr[i];
> > +        needle.size =3D elem->in_sg[i].iov_len - 1;
> > +        map =3D vhost_iova_tree_find_gpa(svq->iova_tree, &needle);
>
> Mapping failure must be handled.
>

Fixed as above!

> > +        offset =3D needle.translated_addr - map->translated_addr;
> > +        iova_base =3D (void *)(map->iova + offset);
> > +
> > +        elem->in_sg[i].iov_base =3D iova_base;
> > +        memcpy(iova_base, elem->in_sg[i].iov_base, needle.size + 1);
>
> No memcpy is necessary before vhost_svq_add() since this is data that
> will be read from the device upon I/O completion.
>

Copy! It is removed.

> > +    }
>
> elem->out_sg[] and elem->in_sg[] are modified in this function. Have we
> lost the original I/O buffer memory address from the guest virtqueue?
> This is a problem because they will be needed when completing the
> request.
>

I don't believe they were lost.  I had complimentary operations on elem
in the two handlers.  However, my thought that these needed to be adjusted
was incorrect, so address fields in elem are no longer modified in either
handler.

...

> >
> > +    if (u->user->memory_isolation) {
> > +        if (!u->svqs_allocated) {
> > +            return 0;
> > +        }
>
> Is the idea that this returns silently when called before
> vhost_user_dev_start()? State make code harder to understand. It would
> be cleaner to set up the vring addresses without relying on
> svqs_allocated. What is the reason for deferring the vring address
> setup to vhost_user_dev_start()?
>

The current implementation follows a similar order of operations as
vhost-vdpa, in which vhost_svq_start is called by vhost_dev_start.
vhost_svq_start is where vrings get assigned their locations, so there
is no valid address to send before then.

As we discussed offline, this could potentially be fixed by calling
vhost_svq_start when the mem table is being set, though this
complexity among others is a good reason to move implementation
of the isolation mode up to vhost.

...

> >
> > +static bool vhost_user_svqs_start(struct vhost_dev *dev)
> > +{
> > +    struct vhost_user *u =3D dev->opaque;
> > +    uint64_t vring_base =3D u->iso_memory.vring_base_addr;
> > +    u->svqs_allocated =3D true;
>
> Where is this field cleared to false on reset?
>

Nowhere originally, but I have added it in vhost_user_svqs_stop.

> > +
> > +    for (int i =3D 0; i < u->shadow_vqs->len; i++) {
> > +        VirtQueue *vq =3D virtio_get_queue(dev->vdev, dev->vq_index + =
i);
> > +        VhostShadowVirtqueue *svq =3D g_ptr_array_index(u->shadow_vqs,=
 i);
> > +        svq->base_addr =3D (hwaddr *) vring_base;
>
> Does this support multiple virtqueues, it looks like they will all use
> the same base_addr?
>

It does!  vring_base is incremented after the assignment is made
for each svq.  Having said that, I don't think this works with virtio-net
where the device is implemented as multiple vhost-devs.  Since
multiple vhost-devs would need to share the iso memory, I will need
to adjust the vring assignment accordingly.

> > +        vhost_svq_start(svq, dev->vdev, vq, u->iso_iova_tree);
> > +
> > +        struct vhost_vring_addr addr =3D {
> > +            .index =3D dev->vq_index + i,
> > +            .desc_user_addr =3D vring_base,
> > +            .avail_user_addr =3D vring_base + sizeof(vring_desc_t) *
> > +                svq->vring.num,
> > +            .used_user_addr =3D vring_base + vhost_svq_driver_area_siz=
e(svq)
> > +        };
> > +
> > +        vhost_user_set_vring_addr(dev, &addr);
>
> Also mentioned above in vhost_user_set_vring_addr():
>
> Sending a vhost-user message here is strange since that should already
> be done by vhost.c:vhost_virtqueue_start() ->
> vhost_user_set_vring_addr().
>

Same response as above.

