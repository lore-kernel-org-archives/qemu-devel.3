Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E04D1CDCE
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 04:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR0Y4-0001gK-1C; Wed, 03 Dec 2025 23:02:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.skibgr3w7icnsr1=in564u920ics=7fh4l9b00jn3ae@em483429.getutm.app>)
 id 1vR0Y0-0001g3-Qy
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 23:02:28 -0500
Received: from a4i956.smtp2go.com ([158.120.83.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.skibgr3w7icnsr1=in564u920ics=7fh4l9b00jn3ae@em483429.getutm.app>)
 id 1vR0Xz-00029o-3I
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 23:02:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1764820933; h=from : subject :
 to : message-id : date;
 bh=duzKVUK9MvRcI+AHe76rdCJwGO8qQSnR6pS0bto5B90=;
 b=AQPMPkJzFi52qBiqCGMUckLogw3rswK3vnw1mj/9lc1U5jmbfF+nUuB5NyF+TPrjXsQx+
 MGJhzfqhAYfIXioSupQg7W2ESJ4SKAQophZX87z5gUwUmGhe1cBM+rYBIpA/kuGy/0oWq4A
 7BIarwc6PKMS27BfSAPHx3LcsYtftYhHB6X2bAivlqOplionYFheTY/yyy32NL7kJdNNEdT
 V9XzXwrq6wJBadR7TnjOFMuMcx6rOQ6st3QY7E74ea3V58ZDZ2JfFIhqwSHznMsI7/HA3FJ
 MZsXX7b3GY2P3urgfA9bRdjQ7+TkonDh5JYhpHnDn7XpLDIO1+HbfGwse/ww==
Received: from [10.159.238.187] (helo=mail-ej1-f47.google.com)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
 (Exim 4.98.1-S2G) (envelope-from <j@getutm.app>)
 id 1vR0Xi-4o5NDgrniin-fswC for qemu-devel@nongnu.org;
 Thu, 04 Dec 2025 04:02:10 +0000
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-b73545723ebso71604666b.1
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 20:02:10 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUTSLb9chb9IdEmW9zJmvS0ohCGH9F/HGUs/he7ZWqQ04GFF+u1z8TyB7yNC0gvEEQw0ZrW35NsUmXF@nongnu.org
X-Gm-Message-State: AOJu0YwZKHPEPUmdrkyafViHTvl2a5DnFQJZe2h/bgYxcunlCMoVgVtm
 kQweQWGhP8uC09jgeCN5qtGnjvimmp3Da8QbovqCJAD57+j+3jIikx1iuCrZF7QrI++VXJsmv/o
 A0ECLg+7f7BDwvRAd07gyJ9WkkfEEhGQ=
X-Google-Smtp-Source: AGHT+IE+Gk0v2+0sGLN7ySB01nsduwB9XDzXkAInXtJODsUhqBK5iLB9l/KunP7Kf1VpU5Bku2sUrNjGRgSIfzk4o9E=
X-Received: by 2002:a17:906:7953:b0:b72:56ad:c9c0 with SMTP id
 a640c23a62f3a-b79dbe8e6f8mr454837866b.17.1764820929484; Wed, 03 Dec 2025
 20:02:09 -0800 (PST)
MIME-Version: 1.0
References: <20251203040754.94487-1-j@getutm.app>
 <20251203040754.94487-3-j@getutm.app>
 <b5e61b9f-3afb-42c4-a185-eaf659a4c11c@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <b5e61b9f-3afb-42c4-a185-eaf659a4c11c@rsg.ci.i.u-tokyo.ac.jp>
From: Joelle van Dyne <j@getutm.app>
Date: Wed, 3 Dec 2025 20:01:58 -0800
X-Gmail-Original-Message-ID: <CA+E+eSBGE7ZkhPngyurL1s-D6NXnFJLU7Yyq8nZtRu8ou+mB0g@mail.gmail.com>
X-Gm-Features: AWmQ_bmqSWbG7k3kfym7jTREL827hPqU_aloWtyPzIKJWecSSzf8m5tME617ljc
Message-ID: <CA+E+eSBGE7ZkhPngyurL1s-D6NXnFJLU7Yyq8nZtRu8ou+mB0g@mail.gmail.com>
Subject: Re: [PATCH RFC 2/7] virtio-gpu-virgl: check page alignment of blob
 mapping
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 483429m:483429abrvJvs:483429sH5VttTvlL
X-smtpcorp-track: CKERFuRDSl3X.uzRq8VZEAPEa.wy2ZfA0Uegx
Received-SPF: pass client-ip=158.120.83.188;
 envelope-from=bounce.skibgr3w7icnsr1=in564u920ics=7fh4l9b00jn3ae@em483429.getutm.app;
 helo=a4i956.smtp2go.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The problem specifically with how Mesa uses it is that
virtgpu_ioctl_map calls the IOCTL DRM_IOCTL_VIRTGPU_MAP which performs
the VIRTIO_GPU_CMD_RESOURCE_MAP_BLOB with an unaligned offset.
virtio_gpu_virgl_map_resource_blob does not error and hv_vm_map
returns silently without doing any maps. Once that makes it to Mesa,
it will try to mmap() and then use the region with vector instructions
that are not supported by HVF because HVF does not emulate
instructions when ISV=3D0 (this was a topic of discussion many times for
other features like TPM emulation).

On Wed, Dec 3, 2025 at 6:56=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2025/12/03 13:07, Joelle van Dyne wrote:
> > Currently if a mapping is not page aligned, it will sliently fail and t=
he
> > guest, assuming it is mapped, will attempt to access the memory and fai=
l.
> > This is particularly an issue on macOS when the host page size is 16KiB=
 and
> > the guest page size is 4KiB.
>
> It should work. If I understand correctly, tcg doesn't care the host
> page size. hvf will not call hv_vm_map() for misaligned regions and that
> causes Data Abort, but it is handled by QEMU to perform memory access. I
> think it needs more debugging.
>
> Regards,
> Akihiko Odaki
>
> >
> > Signed-off-by: Joelle van Dyne <j@getutm.app>
> > ---
> >   hw/display/virtio-gpu-virgl.c | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> >
> > diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virg=
l.c
> > index 20c856c04e..adf02ac22b 100644
> > --- a/hw/display/virtio-gpu-virgl.c
> > +++ b/hw/display/virtio-gpu-virgl.c
> > @@ -116,6 +116,20 @@ virtio_gpu_virgl_map_resource_blob(VirtIOGPU *g,
> >           return ret;
> >       }
> >
> > +    if (!QEMU_IS_ALIGNED((uintptr_t)data, qemu_real_host_page_size()))=
 {
> > +        virgl_renderer_resource_unmap(res->base.resource_id);
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: address %p is not aligned =
to page size\n",
> > +                      __func__, data);
> > +        return -ENOMEM;
> > +    }
> > +
> > +    if (!QEMU_IS_ALIGNED(size, qemu_real_host_page_size())) {
> > +        virgl_renderer_resource_unmap(res->base.resource_id);
> > +        qemu_log_mask(LOG_GUEST_ERROR, "%s: size 0x%llx is not aligned=
 to page size\n",
> > +                      __func__, size);
> > +        return -ENOMEM;
> > +    }
> > +
> >       vmr =3D g_new0(struct virtio_gpu_virgl_hostmem_region, 1);
> >       vmr->g =3D g;
> >
>

