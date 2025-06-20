Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E7D0C7115A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 02:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSR8o-0006wb-SD; Thu, 19 Jun 2025 22:06:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zzyiwei@gmail.com>)
 id 1uSR8m-0006w2-Ez; Thu, 19 Jun 2025 22:06:04 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zzyiwei@gmail.com>)
 id 1uSR8k-0002oD-Q2; Thu, 19 Jun 2025 22:06:04 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-60707b740a6so2011716a12.0; 
 Thu, 19 Jun 2025 19:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750385159; x=1750989959; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3AKCssFe0oB1ZPoR5cqhMAfELhtLZVGbImjnMdl24E4=;
 b=lcV+qVubyn0NSw+n7Djit2J/DpUujAhlOxhjCpTLpxlrkUXZ0CufaPM07fflglOIfR
 PA8Efvi6x24uIbb190pcoDw3GH4Z1NSTD1k+PUbw7x8N/ULtBQudZzJwZQskzKHOy3B9
 K+IlPs7ELfflcIFVDgHTzgxb0mde8HBNEqYAcfIGmy7q32xfLhmgYgRq8UuXxr1+6B9q
 p4orwCYPF0nxFVlfPj+Uf4DT+PhX1YqjuUVJ4PMfedgxzCXzUw5WagigNSogeolZGP0Q
 vWQ9AQUhlJWx4fbhV6Wbdsmy5NL0gcYPGfXty2tHbmpKPiNvgZ8eykTUT2wrnul/ZPEW
 6OWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750385159; x=1750989959;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3AKCssFe0oB1ZPoR5cqhMAfELhtLZVGbImjnMdl24E4=;
 b=oKA6zvLlktcg2otwFXyp2Hsw/L9L0Vdv0K+qv+I0hJfhd0021k+U46Ow1RSNOWCA0R
 7jHRCaqbs1e2Jat1Wi1lIRY+ETXSm8KT22fCzyS+XpekVpY/V/wNeG5AMBwpcbGJ+nLm
 gwq+tcJM+CWUtsRK7NHhUp0fjdla82M5sKwHRgbn/95g3/TxGTXyRX7w/aQajScGI4MN
 BFvTnMIpo7qEhOnDo6VB2+M0e0A2dx9JVogbDJ6U6gZ2T9QnMvFU11vm8bXz1xCmRTl+
 4bI93KBb4ay4ekamUSiCcey67Eq+2oW0qyczF/9y2mrzVchkqMab2MBO3bAzL/vz+Bi0
 WaKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAiX+ASGBNHW3sX0LuwIBD3XtvxiazI+Rrr3wChxmE4F6hmDDBrK+wis4Qll33Av6pGtfikQQ4fMzALA==@nongnu.org
X-Gm-Message-State: AOJu0YxTM+OoFfXNtWB8qZITlcjfjq/tRyULEB9KrGpxpJL9BF63EWDE
 pnspS+tFyuuzB4JEX+AI6OwQpIpK2+V7UR+6EcESSA/p9C/SWwqliI0EcfhEhkr4w9BSjda3F9n
 Bj5cPjGiZASvGgnQBmuKBp4V2tR+Zwnw=
X-Gm-Gg: ASbGncuFe106XwQawk/r4YGK4TYS3cumab1LqapIf3blq9h4VZHb+nfR+090vFeNSnF
 w/XhvKaXvcllS+11nqnei3viMUHLlG6UCx3zDVAR7oYyklLrhW+wOdKq0JbPEo3o6GRjs+ZdABe
 8OnujF1omvfmCfQTvQAa8nFzez1P4JvpgU+vO6RteU+OGx1s6C8c4gxlDdHyFsOi83vgFNWbuC1
 Vsr
X-Google-Smtp-Source: AGHT+IFoPEwdHfr34k09dTwdjbrNY4GjjGiP8cbczySnqlN3cqrbAPdKfHLP7pWtBVlo32AOPxusZZMO+AM8oIMXeGs=
X-Received: by 2002:a05:6402:5207:b0:601:31e6:698d with SMTP id
 4fb4d7f45d1cf-60a1d18e136mr720966a12.23.1750385158953; Thu, 19 Jun 2025
 19:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250605162651.2614401-1-alex.bennee@linaro.org>
 <20250605162651.2614401-13-alex.bennee@linaro.org>
 <d504e5de-cb7f-4eda-a046-9edef5d23749@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <d504e5de-cb7f-4eda-a046-9edef5d23749@rsg.ci.i.u-tokyo.ac.jp>
From: Yiwei Zhang <zzyiwei@gmail.com>
Date: Thu, 19 Jun 2025 19:07:39 -0700
X-Gm-Features: Ac12FXzPZHAVjmvzYDJbwDKIuTO2T-jtcyw217o3Qb2ExQDbWtxRZ_LI7t3dI1I
Message-ID: <CAJ+hS_jUtitaeqYYxHN6q9ijqBu=Zyviid+EJc2sJ1yQLRxSDQ@mail.gmail.com>
Subject: Re: [PULL 12/17] virtio-gpu: support context init multiple timeline
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=zzyiwei@gmail.com; helo=mail-ed1-x52c.google.com
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

On Sun, Jun 8, 2025 at 1:24=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2025/06/06 1:26, Alex Benn=C3=A9e wrote:
> > From: Yiwei Zhang <zzyiwei@gmail.com>
> >
> > Venus and later native contexts have their own fence context along with
> > multiple timelines within. Fences wtih VIRTIO_GPU_FLAG_INFO_RING_IDX in
> > the flags must be dispatched to be created on the target context. Fence
> > signaling also has to be handled on the specific timeline within that
> > target context.
> >
> > Before this change, venus fencing is completely broken if the host
> > driver doesn't support implicit fencing with external memory objects.
> > Frames can go backwards along with random artifacts on screen if the
> > host driver doesn't attach an implicit fence to the render target. The
> > symptom could be hidden by certain guest wsi backend that waits on a
> > venus native VkFence object for the actual payload with limited present
> > modes or under special configs. e.g. x11 mailbox or xwayland.
> >
> > After this change, everything related to venus fencing starts making
> > sense. Confirmed this via guest and host side perfetto tracing.
> >
> > Cc: qemu-stable@nongnu.org
> > Fixes: 94d0ea1c1928 ("virtio-gpu: Support Venus context")
>
> I suggest moving this in the front of the patch series to ease backportin=
g.
>
> I also wonder if "[PULL 11/17] ui/gtk-gl-area: Remove extra draw call in
> refresh" requires Cc: qemu-stable@nongnu.org. Fixing -display gtk,gl=3Don
> for Wayland sounds as important as this patch.
>
> Regards,
> Akihiko Odaki

Hi Alex,

+1 for Akihiko's point. I'm also curious when will the venus fix land in-tr=
ee?

Best,
Yiwei

>
> > Signed-off-by: Yiwei Zhang <zzyiwei@gmail.com>
> > Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Message-Id: <20250518152651.334115-1-zzyiwei@gmail.com>
> > [AJB: remove version history from commit message]
> > Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> > Message-ID: <20250603110204.838117-13-alex.bennee@linaro.org>
> >
> > diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virg=
l.c
> > index b4aa8abb96..cea2e12eb9 100644
> > --- a/hw/display/virtio-gpu-virgl.c
> > +++ b/hw/display/virtio-gpu-virgl.c
> > @@ -978,6 +978,15 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
> >       }
> >
> >       trace_virtio_gpu_fence_ctrl(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.t=
ype);
> > +#if VIRGL_VERSION_MAJOR >=3D 1
> > +    if (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX) {
> > +        virgl_renderer_context_create_fence(cmd->cmd_hdr.ctx_id,
> > +                                            VIRGL_RENDERER_FENCE_FLAG_=
MERGEABLE,
> > +                                            cmd->cmd_hdr.ring_idx,
> > +                                            cmd->cmd_hdr.fence_id);
> > +        return;
> > +    }
> > +#endif
> >       virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.t=
ype);
> >   }
> >
> > @@ -991,6 +1000,11 @@ static void virgl_write_fence(void *opaque, uint3=
2_t fence)
> >            * the guest can end up emitting fences out of order
> >            * so we should check all fenced cmds not just the first one.
> >            */
> > +#if VIRGL_VERSION_MAJOR >=3D 1
> > +        if (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX) {
> > +            continue;
> > +        }
> > +#endif
> >           if (cmd->cmd_hdr.fence_id > fence) {
> >               continue;
> >           }
> > @@ -1005,6 +1019,29 @@ static void virgl_write_fence(void *opaque, uint=
32_t fence)
> >       }
> >   }
> >
> > +#if VIRGL_VERSION_MAJOR >=3D 1
> > +static void virgl_write_context_fence(void *opaque, uint32_t ctx_id,
> > +                                      uint32_t ring_idx, uint64_t fenc=
e_id) {
> > +    VirtIOGPU *g =3D opaque;
> > +    struct virtio_gpu_ctrl_command *cmd, *tmp;
> > +
> > +    QTAILQ_FOREACH_SAFE(cmd, &g->fenceq, next, tmp) {
> > +        if (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX &&
> > +            cmd->cmd_hdr.ctx_id =3D=3D ctx_id && cmd->cmd_hdr.ring_idx=
 =3D=3D ring_idx &&
> > +            cmd->cmd_hdr.fence_id <=3D fence_id) {
> > +            trace_virtio_gpu_fence_resp(cmd->cmd_hdr.fence_id);
> > +            virtio_gpu_ctrl_response_nodata(g, cmd, VIRTIO_GPU_RESP_OK=
_NODATA);
> > +            QTAILQ_REMOVE(&g->fenceq, cmd, next);
> > +            g_free(cmd);
> > +            g->inflight--;
> > +            if (virtio_gpu_stats_enabled(g->parent_obj.conf)) {
> > +                trace_virtio_gpu_dec_inflight_fences(g->inflight);
> > +            }
> > +        }
> > +    }
> > +}
> > +#endif
> > +
> >   static virgl_renderer_gl_context
> >   virgl_create_context(void *opaque, int scanout_idx,
> >                        struct virgl_renderer_gl_ctx_param *params)
> > @@ -1039,11 +1076,18 @@ static int virgl_make_context_current(void *opa=
que, int scanout_idx,
> >   }
> >
> >   static struct virgl_renderer_callbacks virtio_gpu_3d_cbs =3D {
> > +#if VIRGL_VERSION_MAJOR >=3D 1
> > +    .version             =3D 3,
> > +#else
> >       .version             =3D 1,
> > +#endif
> >       .write_fence         =3D virgl_write_fence,
> >       .create_gl_context   =3D virgl_create_context,
> >       .destroy_gl_context  =3D virgl_destroy_context,
> >       .make_current        =3D virgl_make_context_current,
> > +#if VIRGL_VERSION_MAJOR >=3D 1
> > +    .write_context_fence =3D virgl_write_context_fence,
> > +#endif
> >   };
> >
> >   static void virtio_gpu_print_stats(void *opaque)
>

