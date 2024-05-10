Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1DEC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 08:40:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5LnG-0002q8-Gq; Fri, 10 May 2024 04:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s5LnB-0002ph-Rk
 for qemu-devel@nongnu.org; Fri, 10 May 2024 04:39:50 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s5Ln9-0007Yy-Pw
 for qemu-devel@nongnu.org; Fri, 10 May 2024 04:39:49 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-439656c1b50so10104771cf.1
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 01:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715330386; x=1715935186; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a0O2PtFKXZKpS0ISTd42smkMO7Y9S/coq1lXDRczB4Y=;
 b=cSYr+ybDerhsDGfE4duokyWzwevHP4rRfBnNnMgssCerYx26+L7Re8JSxiFLIqUTC+
 OWwtlxtNtnGBups229QW7G8pQkMU8j142StmW9A+b7tB9pZ5RcbokALN/KBf+9omEUmT
 7kQ5Gjekne/lngcn/uJxvgCpnujaif7aHoBalHEoMjPa+g7xL5DpJoTcwKjNXA9txHxG
 Sxm6R6/sDE7aDIx3ALgQtm8xuoTxdNVONJzpYQ7eSwxBcK+7+JINSM5ZTRJLszxrqJiP
 aJvCPjmjtG9/8KEogUK0lqXsriwwjgpzNAkAEtxspBHWOIs7VLe4JXoc6POGsanC6lD1
 Cl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715330386; x=1715935186;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a0O2PtFKXZKpS0ISTd42smkMO7Y9S/coq1lXDRczB4Y=;
 b=URoor5hagvQX1w1fRHVC+L0camqoQH0ABqyeD6JdDMONLCWk9hLMZSUHmWQbHfRfAK
 Grq2JZAhrdW+lWQ8OFDNrBN/weJBWx6B4m95fSPpfMAXh+deubB1Z1K2E+SkWB99BOHi
 7xbdGPzDulW48PIDheYEYdQHgU3YBJkFawaV7VXJd0bfnGzOEGU62jPUm2KOK32BA08g
 N6/kQZsuuhYmsoLDsB4OEpqb92UMz1iGPvBYWhLU7VY5Oz/bneoTFYn+qOlJZfbo1oZQ
 ZhC+x2fU5DrfY8W7cZwCk2uPOjspr3Sc+uizv9G8OZYOPhhi6bG2a0F3nEx8Cw5CAv+d
 NGIA==
X-Gm-Message-State: AOJu0YwIUKvrlFk/pGFy6imLjAM5cGetjC++S3cD1E4+tVF7ABQjdrv8
 UsDrejmbOj06bESPU/3f0iLwk7SNr9iXsh7wvcm2rKgvRuHlR4OKC0CTwfOwLyKBvZ67Bmf8OIL
 apv1neb65W1PVQoEE81fEqsw3tpyedQJI
X-Google-Smtp-Source: AGHT+IEaPOfOAWmNqlTqcRmf22Y99J2515gCwzHEcUPxhW1Heb39nvkfEsTN3wifQF9CozAoIHsYS540qmUOjeS5u2Y=
X-Received: by 2002:a05:622a:c4:b0:43a:f80c:6923 with SMTP id
 d75a77b69052e-43dfdae2c1fmr16991661cf.36.1715330386172; Fri, 10 May 2024
 01:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240507111920.1594897-1-marcandre.lureau@redhat.com>
 <20240507111920.1594897-4-marcandre.lureau@redhat.com> <ZjqILU7qxlTGN4OD@x1n>
In-Reply-To: <ZjqILU7qxlTGN4OD@x1n>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 10 May 2024 12:39:34 +0400
Message-ID: <CAJ+F1CJjNnHoX=LvSsh5M_fiZg-n5K=KEgPRh+2gAjRij4Oq-w@mail.gmail.com>
Subject: Re: [PATCH 3/4] virtio-gpu: use a VMState variant for the scanout
 field
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Sebastian Ott <sebott@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Eduardo Habkost <eduardo@habkost.net>, Fiona Ebner <f.ebner@proxmox.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, peter.maydell@linaro.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Wed, May 8, 2024 at 12:01=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, May 07, 2024 at 03:19:19PM +0400, marcandre.lureau@redhat.com wro=
te:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Depending on the version, use v1 or v2 of the scanout VM state.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/display/virtio-gpu.c | 22 +++++++++++++++++-----
> >  1 file changed, 17 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > index ae831b6b3e..4fd72caf3f 100644
> > --- a/hw/display/virtio-gpu.c
> > +++ b/hw/display/virtio-gpu.c
> > @@ -1191,17 +1191,29 @@ static const VMStateDescription vmstate_virtio_=
gpu_scanout =3D {
> >      },
> >  };
> >
> > +static bool vmstate_before_v2(void *opaque, int version)
> > +{
> > +    return version <=3D 1;
> > +}
> > +
> >  static const VMStateDescription vmstate_virtio_gpu_scanouts =3D {
> >      .name =3D "virtio-gpu-scanouts",
> > -    .version_id =3D 1,
> > +    .version_id =3D 2,
> > +    .minimum_version_id =3D 1,
> >      .fields =3D (const VMStateField[]) {
> >          VMSTATE_INT32(parent_obj.enable, struct VirtIOGPU),
> >          VMSTATE_UINT32_EQUAL(parent_obj.conf.max_outputs,
> >                               struct VirtIOGPU, NULL),
> > -        VMSTATE_STRUCT_VARRAY_UINT32(parent_obj.scanout, struct VirtIO=
GPU,
> > -                                     parent_obj.conf.max_outputs, 1,
> > -                                     vmstate_virtio_gpu_scanout,
> > -                                     struct virtio_gpu_scanout),
> > +        VMSTATE_VSTRUCT_TEST_VARRAY_UINT32(parent_obj.scanout, struct =
VirtIOGPU,
> > +                                           vmstate_before_v2,
> > +                                           parent_obj.conf.max_outputs=
, 1,
> > +                                           vmstate_virtio_gpu_scanout,
> > +                                           struct virtio_gpu_scanout, =
1),
> > +        VMSTATE_VSTRUCT_TEST_VARRAY_UINT32(parent_obj.scanout, struct =
VirtIOGPU,
> > +                                           NULL,
> > +                                           parent_obj.conf.max_outputs=
, 2,
> > +                                           vmstate_virtio_gpu_scanout,
> > +                                           struct virtio_gpu_scanout, =
2),
>
> Personally I really wished struct_version_id never existed..  After these
> years we only have 1 user of it (hw/ipmi/isa_ipmi_kcs.c), and we need to
> keep that working.  I'm wondering whether there's way we can avoid adding
> one more user, and even more complicated..
>
> I think I get the reasoning behind "we define the same thing twice", but
> this is really tricky and definitely needs rich documents, meanwhiel all =
of
> these seem to rely on so many small details: one set .field_exists
> properly, one leaving it to NULL; also the two versionings used here for
> both parent vmsd, and the struct, and for each entry we need to set
> different versions to different fields..
>
> Would it work if we only make the new fields under control with
> vmstate_before_v2()?  IOW, making all below with
> .field_exists=3Dvmstate_before_v2, so skip below when machine type is old=
?

The existing VMSTATE_STRUCT_VARRAY_UINT32 would always use the latest
vmstate_virtio_gpu_scanout version_id (2 in master).

The "struct_version_id" solution allows setting the
vmstate_virtio_gpu_scanout version_id to 1 if the parent struct
(vmstate_virtio_gpu_scanouts) is 1, and 2 if the parent is 2.

Since we don't have per VMSD version information on the wire, nested
struct versioning is quite limited and cumbersome. I am not sure it
can be changed without breaking the stream format, and whether it's
worthwhile.


>
>          VMSTATE_UINT32_V(fb.format, struct virtio_gpu_scanout, 2),
>          VMSTATE_UINT32_V(fb.bytes_pp, struct virtio_gpu_scanout, 2),
>          VMSTATE_UINT32_V(fb.width, struct virtio_gpu_scanout, 2),
>          VMSTATE_UINT32_V(fb.height, struct virtio_gpu_scanout, 2),
>          VMSTATE_UINT32_V(fb.stride, struct virtio_gpu_scanout, 2),
>          VMSTATE_UINT32_V(fb.offset, struct virtio_gpu_scanout, 2),
>
> Thanks,
>
> --
> Peter Xu
>
>


--
Marc-Andr=C3=A9 Lureau

