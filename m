Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C7C0C47DDB
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 18:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTQng-0007tB-SJ; Fri, 26 Jan 2024 13:19:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rTQnf-0007t2-No
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 13:19:35 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rTQne-0003mF-4n
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 13:19:35 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-55d314c1cb7so1354400a12.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 10:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706293172; x=1706897972; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R3IY3ttkE5lc3vfibS0pzwhUykAA9LkPPA68YRGmFzA=;
 b=BCWvXThhzOz6jzWbk/DThAeAoLkChOvOTjxy5XnEtKWm6VYk7Nl8oQRKDAfUwEHZ53
 3+T7eR9Fro18Us5T0gAPRP1crvUW9xkZv+tj58YtMQp5K/a7gcPJhxqi7FTH2bQc8l0r
 cx0aUsbuC+cCwdBp/PBfgNsAqhUOdl1NTSoFR27OGZn7e21cvsSCv9yQNTXxJzNozHN8
 DgJu/lMWhM63amlpWiD/SQ84f9oV33AZtynaNEMnY0+6ooWsRCxvEzio7/n7l7YeU2DB
 sgmaE12KZCPAN1AgEbY8cEKTNrACBxPfSAyZnmNRLrRnLt/fyHa+xTcbNeJpDptJuPqh
 Lpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706293172; x=1706897972;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R3IY3ttkE5lc3vfibS0pzwhUykAA9LkPPA68YRGmFzA=;
 b=sVcQw1/yf/ssi/zCutGTuz6uq7QN6F9BgNPWUaF3U5SiWusaKVhUbD3i0XmRia/BgI
 Kl0sOWjAuC3p68qGTVZ7LhpxoVLkGqPg1cNuB4nGEJojhuo2dTPqSxlMvhBhqH96riBR
 Jh/6WJj/+irBTOfD6pbGMKtfkH7jhVlIjqPnE96JF8E3GEv1szd3ZX5WyWyvSbgPhNbL
 1H+ETcjHgQ95S7lW9VPmtgcJHPuwpFuLxFsE9s2C18qUzJ7rcXiLzx6jhm1xwecoiN3y
 QknLdE2pGrAp2BQ10/Hq582U9rsgHG0fnBMt+5UssmCjiRYvh+sdse+Weo6eWZ0qA829
 w5kg==
X-Gm-Message-State: AOJu0Yx1gJTF4EYLoRzy7ov3o/vKoAMX74yKtwTjtP0/FP19JeMqxtJl
 7tAluCu4stfK5MKJi3+yYQQheIiWHXZOcA9TEmuSqJPBuW/Vol91R1rTvslybT4ZF7M8+Y5n6NZ
 4P99KhOOdUtdmk4u2LUNTwEkse7T3vdzKFR5lxg==
X-Google-Smtp-Source: AGHT+IH97fO/0jK+zalhYPvian1n1K/smZAjBBjyw6AaCRrwXaHllB8pWEv/+l2XMkM6zwtXnuKilvU58xAczlEjp3U=
X-Received: by 2002:a05:6402:792:b0:55c:d773:95dc with SMTP id
 d18-20020a056402079200b0055cd77395dcmr387009edy.3.1706293172329; Fri, 26 Jan
 2024 10:19:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.1706279540.git.manos.pitsidianakis@linaro.org>
 <c123808b760f4d8d743c4fd4a04e730005ff673e.1706279540.git.manos.pitsidianakis@linaro.org>
 <b99352e9-efd2-42a3-b6de-a87832bb007c@linaro.org>
In-Reply-To: <b99352e9-efd2-42a3-b6de-a87832bb007c@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 26 Jan 2024 20:19:16 +0200
Message-ID: <CAAjaMXaZco6AappQdC+8H9bnipD6A1VCd7b3rrk5h9VHO3qt_g@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] virtio-gpu.c: add resource_destroy class method
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 26 Jan 2024 at 17:22, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi Manos,
>
> On 26/1/24 15:41, Manos Pitsidianakis wrote:
> > When destroying/unrefing resources, devices such as virtio-gpu-rutabaga
> > need to do their own bookkeeping (free rutabaga resources that are
> > associated with the virtio_gpu_simple_resource).
> >
> > This commit adds a class method so that virtio-gpu-rutabaga can overrid=
e
> > it in the next commit.
> >
> > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > ---
> >   hw/display/virtio-gpu.c        | 19 ++++++++++++++++---
> >   include/hw/virtio/virtio-gpu.h |  2 ++
> >   2 files changed, 18 insertions(+), 3 deletions(-)
>
>
> >   static void virtio_gpu_resource_unref(VirtIOGPU *g,
> > @@ -1488,11 +1491,20 @@ static void virtio_gpu_device_unrealize(DeviceS=
tate *qdev)
> >   static void virtio_gpu_reset_bh(void *opaque)
> >   {
> >       VirtIOGPU *g =3D VIRTIO_GPU(opaque);
> > +    VirtIOGPUClass *vgc =3D VIRTIO_GPU_GET_CLASS(g);
> >       struct virtio_gpu_simple_resource *res, *tmp;
> > +    int32_t result, resource_id;
> >       int i =3D 0;
> >
> >       QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
> > -        virtio_gpu_resource_destroy(g, res);
> > +        resource_id =3D res->resource_id;
> > +        result =3D vgc->resource_destroy(g, res);
> > +        if (result) {
> > +            error_report("%s: %s resource_destroy"
> > +                         "for resource_id =3D %d failed with return va=
lue =3D %d;",
>
> '%d' is for 'int', for 'int32_t' you need 'PRId32'.

Thanks,

> But why return that type instead of 'int'?

Because devices might use FFI, and other languages use fixed size
integers. Since rutabaga is the only one doing this right now, I used
their integer width.

> > +                         __func__, object_get_typename(OBJECT(g)), res=
ource_id,
> > +                         result);
> > +        }
> >       }
>
>
> > diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-=
gpu.h
> > index 584ba2ed73..5683354236 100644
> > --- a/include/hw/virtio/virtio-gpu.h
> > +++ b/include/hw/virtio/virtio-gpu.h
> > @@ -219,6 +219,8 @@ struct VirtIOGPUClass {
> >       void (*update_cursor_data)(VirtIOGPU *g,
> >                                  struct virtio_gpu_scanout *s,
> >                                  uint32_t resource_id);
> > +    int32_t (*resource_destroy)(VirtIOGPU *g,
> > +                                struct virtio_gpu_simple_resource *res=
);
> >   };
> >
> >   struct VirtIOGPUGL {
>

