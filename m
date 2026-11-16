Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7F3606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XF9/+bPq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3Ar-0006G1-LJ; Mon, 16 Nov 2026 15:19:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xT3Ap-0006Fr-V1
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 15:19:31 -0500
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xT3Ao-0004DB-23
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 15:19:31 -0500
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-380b40319bdso1110284eec.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 12:19:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794860368; cv=none;
 d=google.com; s=arc-20260327;
 b=sQqJkCBDjolfp/4CvV99ylXkXk5YfOd1tCj7guhPNOwz7C0QA/SxcIyHNU0FB6jIS6
 ZJpYgOVhozGW4OcDPkbh331M8RXtcEkyr4cYJfl9U8fYtKoc6grsXvCUhAYGHLfG1r/c
 KgIUX+3rCumTzu1iVze+QKb1j7DYOEM5t5IhXnBwBNvSRs9cSFTZxbuiIDH/Qsxd8DzX
 8rb3/ft6btlsBrZipbfzpUewyp5uqcSsMNtiO9ZEFPC8yfdaCZYrYMjAYofJ2IdXx7Td
 obCJrhGy4ToiiGXhc8Xu1LS17Xa03p9EqJYcpKiURLgveVvxzI8lLwEcV6sWqbBiTiDz
 p28Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xk2vSNy9hzH6XCJvO2a0XqVRNmknTcd/MBMAIBgYG10=;
 fh=sYMn2eU1EYAi1NaTTza7tnTQV1rnmVt4rjWpHCtmuVU=;
 b=kCjz1jRK63+LDNC0dVc5qsI0awyNbiJdijOgSXvhvJMNRBsWlXCe2vzR4zABvqfabE
 fiXQ6Kgw5teFUNsFIcvH144rcYQw6ZE0ygS5SNBPX4paPV/YRXGcr3lj9pR+Z7NmF7Wn
 JTNLggLzzYWtIpVyc84hHjTsQCNSbgtK8//KsR44N6CamRUw6DUzAy65B5LQKhjKSw3n
 nmMUyOhLji3zb/643s4g6EdwZOPYWVe7R2J+MvohS18q73C/lUKvYvEdgOaFdMRhRD+v
 /vRQVBFokbrEO3oUdqJ5MTrLFqLOtuwhKoC1mJQZR3jrp+lBaFdBsPFk3Axbv2xHJpPu
 Vnsw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794860368; x=1795465168; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xk2vSNy9hzH6XCJvO2a0XqVRNmknTcd/MBMAIBgYG10=;
 b=XF9/+bPqSss1cZPeyDhM5sjKXX2cJqd9yzp+ISzY43b6IxZLdVzJEl8wTU5ri6SuLs
 NButBzG0Cg5tRwoEXgk9na4G8+nztT72w1mVib00Q3ErxUcMuq1+vxF8DHJ8JoVZVEvf
 axH7ycHQCGYUe79TBoIG0QOXTtP7VeBsPIukb5M6P/wIBf2D7WVjH8nRIt0BbZo09y4I
 86ELv0ACYVmEvawOGWvkfsGP4U56KntgYZbRQZkZSXX9/rTFDZhm7jsXoB289iDL/lhm
 SLnS8azaLaxXcn1Lt2xI9AcE4B+PjjrUyrV9vLRobrY8ulf/0cV0+fMamhVMj1WowJPm
 3ulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794860368; x=1795465168;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xk2vSNy9hzH6XCJvO2a0XqVRNmknTcd/MBMAIBgYG10=;
 b=UdmbcsT7SxuYSIPnW+sZck558S9w8+XmABdXI7d2i3IvKcA5yt8CY5GnPfmKjFA/nT
 4+BEiM7OIaBfItsOJbMSpB7LW3caajqJejbcSBK9JWtCDxZcK9q62AKO2Fr+yOREAOU1
 YF03CIjLVOJJ6fuxDCH1llCVPSxzEe+USHc8tvrNvTx2ozPBPtetkOzZR1ya7H6o+zh+
 tvPwlQp7hU4yYqbVDOPyOIak1SaCcTE0vZC0Qs3GSHto4aCM7JjdjShGWonMQF8QVgCp
 Wh9JA2MqoKnM8TVYzEhSSb89HZVulmvAYm0TisYmpu8ctgY3YwzQ9RpNvb+K4K65VP3b
 ldCQ==
X-Gm-Message-State: APuU4Z+yi6X1WcjnipZxlwwbaiepifyZu1sK977DFfnj0iueUv9AZENk
 +tpexniGjbKYy1duU2D/0s6/BIhXzmRd+9/Kth9XP3V0ROXICSLJCCWVYjSPuo7/z4TjqY7Wcv7
 NykKnVNGflsYiypayuP7K2JE8+U1rF+w=
X-Gm-Gg: AZFdTZeGTjCeDJTQLV05bozCTKZaJF18nMzPFUJgukkIZ8x5ciXcp/sk4cMDM+JBSPb
 cF2dIym1ORt13Xe9C2SF7krpABtc2R2nhX8e0BvlFcIXinrg9iAdsfzULvM/ofwj61MvA8phaMp
 45kiXFXRKiiInO3Rfb7lordazyH4cCGzOnvt1EnuUmNhyaMRG0kzvaiky7Zfvalhlack9INMOp3
 kbNiwEntzZe0YI3D4C73eDE3bpj1c664W9uLyc884UTzrdd8w2oknysi0T+6APhj07LWkEVgPND
 Nr0b8RQ2KoWgji+mhzeauuE0ZP4br2LwVYFYpXPEsyb0VM2+7fGahv/pD0RyP/m8WLjJr1xxj93
 MJ+rZpKv99eHpUBD/iRBsxH2cOcV8q6yL99U8bJqIfbC1jgpxTg+Sn6ODBK6h2iJpfm+aWXrXRL
 QQEbgpP8ryQrPA+A==
X-Received: by 2002:a05:693c:864b:10b0:35e:f4ac:5f8e with SMTP id
 5a478bee46e88-37960384530mr11512599eec.0.1794860368235; Mon, 16 Nov 2026
 12:19:28 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAPSUqz14daiP8DvLBzcMwBzmpCmMe9B25Q2CFO6s8joCnfW-_Q@mail.gmail.com>
In-Reply-To: <CAPSUqz14daiP8DvLBzcMwBzmpCmMe9B25Q2CFO6s8joCnfW-_Q@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 17 Nov 2026 00:19:15 +0400
X-Gm-Features: Aa3M54oZ2bBvPa9cwWYmhXe0ldDVGjVZWU_X8_fwDgyK8gNsRyM28Ut7AcOuLEE
Message-ID: <CAJ+F1CL4prP0P6g305J1ATXHq1bUKamLZfwEdmWiTv33QrAPyQ@mail.gmail.com>
Subject: Re: [PATCH] virtio-gpu: run scanout reset cleanup on the main loop
 thread
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, meng ou <oumeng086@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1336;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1336.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Akihiko

On Mon, Oct 26, 2026 at 4:58=E2=80=AFPM meng ou <oumeng086@gmail.com> wrote=
:
>
> virtio-gpu: run scanout reset cleanup on the main loop thread
>
> virtio_gpu_gl_reset() executes in the context of the thread that wrote th=
e
> device reset register, i.e. a TCG vCPU thread.  It calls
> virtio_gpu_virgl_reset_scanout() -> egl_scanout_disable() ->
> egl_fb_destroy() -> glDeleteFramebuffers(), which requires the display EG=
L
> context to be current on that thread.  It is not:
>
>   #01 egl_fb_destroy                ui/egl-helpers.c
>   #02 egl_scanout_disable           ui/egl-headless.c
>   #04 virtio_gpu_virgl_reset_scanout
>   #05 virtio_gpu_gl_reset           hw/display/virtio-gpu-gl.c
>   #11 do_st_mmio_leN                accel/tcg/cputlb.c
>
> Hosts whose GL implementation dereferences the missing context crash.  Th=
is
> was reproduced on Android/aarch64 with both zink and llvmpipe, which make=
s
> it a threading bug rather than a driver bug.
>
> Defer the cleanup to the main loop: add a VirtIOGPUClass reset_scanout
> callback, invoke it from the existing virtio_gpu_reset_bh() before
> reset_finished is signalled, and reduce virtio_gpu_gl_reset() to setting
> renderer_state to RS_RESET.
>
> Signed-off-by: oumeng <q15817976513@163.com>

This look related to your fixes
https://patchew.org/QEMU/20260908-gpu-v3-0-25332a85f909@rsg.ci.i.u-tokyo.ac=
.jp/
can you take a look?

thanks

> ---
>  hw/display/virtio-gpu-gl.c     | 13 ++++++++++++-
>  hw/display/virtio-gpu.c        |  5 +++++
>  include/hw/virtio/virtio-gpu.h |  1 +
>  3 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/hw/display/virtio-gpu-gl.c b/hw/display/virtio-gpu-gl.c
> index 2b7a41c..9a93fdf 100644
> --- a/hw/display/virtio-gpu-gl.c
> +++ b/hw/display/virtio-gpu-gl.c
> @@ -99,7 +99,8 @@ static void virtio_gpu_gl_reset(VirtIODevice *vdev)
>       * thread, and when the renderer is unblocked.
>       */
>      if (gl->renderer_state =3D=3D RS_INITED) {
> -        virtio_gpu_virgl_reset_scanout(g);
> +        /* scanout cleanup is deferred to virtio_gpu_reset_bh() which ru=
ns
> +         * on the main loop thread (reset_scanout class callback). */
>          gl->renderer_state =3D RS_RESET;
>      }
>  }
> @@ -209,6 +210,15 @@ static void
> virtio_gpu_gl_device_unrealize(DeviceState *qdev)
>       */
>  }
>
> +static void virtio_gpu_gl_reset_scanout(VirtIOGPU *g)
> +{
> +    VirtIOGPUGL *gl =3D VIRTIO_GPU_GL(g);
> +
> +    if (gl->renderer_state =3D=3D RS_INITED) {
> +        virtio_gpu_virgl_reset_scanout(g);
> +    }
> +}
> +
>  static void virtio_gpu_gl_class_init(ObjectClass *klass, const void *dat=
a)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -222,6 +232,7 @@ static void virtio_gpu_gl_class_init(ObjectClass
> *klass, const void *data)
>      vgc->update_cursor_data =3D virtio_gpu_gl_update_cursor_data;
>
>      vgc->resource_destroy =3D virtio_gpu_virgl_resource_destroy;
> +    vgc->reset_scanout =3D virtio_gpu_gl_reset_scanout;
>      vdc->realize =3D virtio_gpu_gl_device_realize;
>      vdc->unrealize =3D virtio_gpu_gl_device_unrealize;
>      vdc->reset =3D virtio_gpu_gl_reset;
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 5d43ffb..4a2789f 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1841,6 +1841,11 @@ static void virtio_gpu_reset_bh(void *opaque)
>          qemu_console_set_surface(g->parent_obj.scanout[i].con, NULL);
>      }
>
> +    /* scanout/GL cleanup must run here, on the main loop thread */
> +    if (vgc->reset_scanout) {
> +        vgc->reset_scanout(g);
> +    }
> +
>      g->reset_finished =3D true;
>      qemu_cond_signal(&g->reset_cond);
>  }
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
> index 631dfc6..91072b0 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -234,6 +234,7 @@ struct VirtIOGPUClass {
>      void (*resource_destroy)(VirtIOGPU *g,
>                               struct virtio_gpu_simple_resource *res,
>                               Error **errp);
> +    void (*reset_scanout)(VirtIOGPU *g);
>  };
>
>  struct virtio_gpu_virgl_context_fence {
> --
> 2.53.0
>


--=20
Marc-Andr=C3=A9 Lureau

