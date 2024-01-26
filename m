Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A9EC47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 18:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTQja-0004Cj-B3; Fri, 26 Jan 2024 13:15:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rTQjZ-0004CA-3b
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 13:15:21 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rTQjX-0003Cj-1L
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 13:15:20 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-55cdaa96f34so4002068a12.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 10:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706292917; x=1706897717; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x3S6LGqmN3/Hdq0tTkndwwFg0TPtSGW8ne+zuzvcfcw=;
 b=ENNkBo/8aaTN4SYdWTwuWtcalyyvB7T4BKmjUBmEJ/rHeVU9AflCJq7ZO2wF0IlbfK
 yyeSiGSawe975lS8+xDkEkPb9aGKoecybJ+lNTXylkJGnsLyI1UG1PvNZ/jZE6LDBsbv
 FKA87pmgJ1l53goAZnaiMNOM3PUKB5ToxQCr6ntqovcevittBz5+pi+2NyKLVJHLdv7n
 hH02FMi+hpWkImVyR8PcTuuq2ARAmPpI0UDvRMQnHRyNuMaoTjyQdWspd4R0bmmvnsCN
 WSexFwhNTrgCyA54mykiEV9wqFu4TvsBBp2QsuqBj1hcgDjYKZ84I9Pn2VpV6CKMqu2Y
 57wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706292917; x=1706897717;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x3S6LGqmN3/Hdq0tTkndwwFg0TPtSGW8ne+zuzvcfcw=;
 b=jOPAB0brhudBF2BZ/Wmq/TXrfxKrFhylwUVYakvNr5k7VCKOjS8E29Y3vC3t1n+igu
 1erbZZ8Nt0OGjCn4FUFhtETvliS/OVJBll8j/5yu6DPtsAwL7Iac2lIYR37gPHGiNkaA
 RT091WuF9yZHfCBVSTxaXuvxVWmq9O+SJsUgtzZD+peQvD65xsOzHLN1WWVUoDlCAHda
 j25vgL1IOeXs4sV5FUm0/gHh4ohFFQGLzCA36asYBwrZiPLGfGCuHB8MhWGRoAxXrivE
 LadnXqc6FizACATPghMMzONhFDQOTvbDwTGAothw5LghqXkW0dWL+NnMSC7Xt8mq0vvl
 EHNA==
X-Gm-Message-State: AOJu0Yz5ieaZ8U73T1HA9LxGKc1QWpRNJsPV6Cr0RcL7pFHppeXfBCo5
 zTE0fm+fZ++yi6mnf0sW1YsfSe5Y/RSHVUN7/Zqhi8woNhcw1D0ZqwyyfNpf3mZ3MkzI1uGKqC4
 jyvmK0dTq4hocvL7EklBJPHZrlLJ2cNbsLneOZOSUptUfKeW9uZH9lA==
X-Google-Smtp-Source: AGHT+IEnKhO1AllaEGQL0me6b8J0XOyAy0aWLo9crQjUnk+PfYlenW2LgMJOpcC7NAzljW61z+wuLMw8sWmG9gx55QM=
X-Received: by 2002:a50:eac6:0:b0:55c:c7f5:4ce3 with SMTP id
 u6-20020a50eac6000000b0055cc7f54ce3mr331927edp.5.1706292917139; Fri, 26 Jan
 2024 10:15:17 -0800 (PST)
MIME-Version: 1.0
References: <cover.1706279540.git.manos.pitsidianakis@linaro.org>
 <c123808b760f4d8d743c4fd4a04e730005ff673e.1706279540.git.manos.pitsidianakis@linaro.org>
 <87h6j0q853.fsf@draig.linaro.org>
In-Reply-To: <87h6j0q853.fsf@draig.linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 26 Jan 2024 20:15:00 +0200
Message-ID: <CAAjaMXb53Ko9thNdmxQLzg7ByXJVmgzw45q4JF6SFanC2PXSqg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] virtio-gpu.c: add resource_destroy class method
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x533.google.com
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

On Fri, 26 Jan 2024 at 20:09, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
>
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
> >  hw/display/virtio-gpu.c        | 19 ++++++++++++++++---
> >  include/hw/virtio/virtio-gpu.h |  2 ++
> >  2 files changed, 18 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > index 2b73ae585b..96420ba74f 100644
> > --- a/hw/display/virtio-gpu.c
> > +++ b/hw/display/virtio-gpu.c
> > @@ -401,8 +401,9 @@ static void virtio_gpu_disable_scanout(VirtIOGPU *g=
, int scanout_id)
> >      scanout->height =3D 0;
> >  }
> >
> > -static void virtio_gpu_resource_destroy(VirtIOGPU *g,
> > -                                        struct virtio_gpu_simple_resou=
rce *res)
> > +static int32_t
> > +virtio_gpu_resource_destroy(VirtIOGPU *g,
> > +                            struct virtio_gpu_simple_resource *res)
> >  {
> >      int i;
> >
> > @@ -419,6 +420,8 @@ static void virtio_gpu_resource_destroy(VirtIOGPU *=
g,
> >      QTAILQ_REMOVE(&g->reslist, res, next);
> >      g->hostmem -=3D res->hostmem;
> >      g_free(res);
> > +
> > +    return 0;
> >  }
> >
> >  static void virtio_gpu_resource_unref(VirtIOGPU *g,
> > @@ -1488,11 +1491,20 @@ static void virtio_gpu_device_unrealize(DeviceS=
tate *qdev)
> >  static void virtio_gpu_reset_bh(void *opaque)
> >  {
> >      VirtIOGPU *g =3D VIRTIO_GPU(opaque);
> > +    VirtIOGPUClass *vgc =3D VIRTIO_GPU_GET_CLASS(g);
> >      struct virtio_gpu_simple_resource *res, *tmp;
> > +    int32_t result, resource_id;
> >      int i =3D 0;
> >
> >      QTAILQ_FOREACH_SAFE(res, &g->reslist, next, tmp) {
> > -        virtio_gpu_resource_destroy(g, res);
> > +        resource_id =3D res->resource_id;
> > +        result =3D vgc->resource_destroy(g, res);
> > +        if (result) {
> > +            error_report("%s: %s resource_destroy"
> > +                         "for resource_id =3D %d failed with return va=
lue =3D %d;",
> > +                         __func__, object_get_typename(OBJECT(g)), res=
ource_id,
> > +                         result);
> > +        }
> >      }
> >
> >      for (i =3D 0; i < g->parent_obj.conf.max_outputs; i++) {
> > @@ -1632,6 +1644,7 @@ static void virtio_gpu_class_init(ObjectClass *kl=
ass, void *data)
> >      vgc->handle_ctrl =3D virtio_gpu_handle_ctrl;
> >      vgc->process_cmd =3D virtio_gpu_simple_process_cmd;
> >      vgc->update_cursor_data =3D virtio_gpu_update_cursor_data;
> > +    vgc->resource_destroy =3D virtio_gpu_resource_destroy;
> >      vgbc->gl_flushed =3D virtio_gpu_handle_gl_flushed;
> >
> >      vdc->realize =3D virtio_gpu_device_realize;
> > diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-=
gpu.h
> > index 584ba2ed73..5683354236 100644
> > --- a/include/hw/virtio/virtio-gpu.h
> > +++ b/include/hw/virtio/virtio-gpu.h
> > @@ -219,6 +219,8 @@ struct VirtIOGPUClass {
> >      void (*update_cursor_data)(VirtIOGPU *g,
> >                                 struct virtio_gpu_scanout *s,
> >                                 uint32_t resource_id);
> > +    int32_t (*resource_destroy)(VirtIOGPU *g,
> > +                                struct virtio_gpu_simple_resource
> >      *res);
>
> What range of errors to you expect to have here? Otherwise you might as
> well return a bool for success/fail.


Rutabaga can return EINVAL or ESRCH.



> >  };
> >
> >  struct VirtIOGPUGL {
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro

