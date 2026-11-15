Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9035606A31D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Nov 2026 07:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=F7HTmVBS;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=rLTATAcH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSV8s-0007Qq-K5; Sun, 15 Nov 2026 02:59:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xSV8q-0007QY-IU
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 02:59:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1xSV8o-0004V9-MP
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 02:59:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794729548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j3/L07sFYLe8CHvpXBZT7zI/PCsK6umfJm3RmyGSPi8=;
 b=F7HTmVBSMhx4ChyDQENMCYB0H+LgXluygG8Jkc6xo9pz0LlL/6/Lk8qMNvA0rgF81b83Sf
 4JgAgMiSymGleGJpJjL6g098hk6ylkkmNkCtfX6RSW1ltrNVtBLi4CqEZSg/VwZurJ+oa9
 QpSeoTRq1MG7Ax11cBjdu5T6PDBCtD8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-7LYcjU_pP4aLV2DCiXTVZw-1; Sun, 15 Nov 2026 02:59:06 -0500
X-MC-Unique: 7LYcjU_pP4aLV2DCiXTVZw-1
X-Mimecast-MFC-AGG-ID: 7LYcjU_pP4aLV2DCiXTVZw_1794729546
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2eaae62796dso21070245ad.0
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 23:59:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794729546; cv=none;
 d=google.com; s=arc-20260327;
 b=ixWIW3Mm9VthK090EsW2gd/AlnWb6MTQtUdpiTVqnlwu3cWmPnEjvhhh6mpxXAH9mQ
 Je1uOUXVDlK2/I33S4MEW19BhdlXIHN3IyDWSQvUrYoZLEFp71u3yZAqYh6ssy7rqWbt
 4s2hyg7gqlPUGIGodR0lPfwDEEC3jJz54s1CSC9lw3LYWMERkqLWhqTRe1jqOJTdr1ca
 r7ToIiVb4R68BCInB6BADrRCfwzNK5wtNPr5z/fylZT2C40OlbkNV3vqjmTzYfkGOuIw
 axpU66+82PxeXmfRBnXN70v4h/k5dFczaN09LHkVHQB1TMBGheBJsVHvYpcpXhCpjyaF
 Bdyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=j3/L07sFYLe8CHvpXBZT7zI/PCsK6umfJm3RmyGSPi8=;
 fh=gZ3dlfh+rX2EgnVIvb4j1QTpzavNZEhrELu3UH6AluI=;
 b=rRp+SDXTGtnsg5eG03zI/7PchX0n6ah2KJfImPRj5sRRwbq1qik2HZReJ2hq4UZmZj
 DZ840h6sW+qN4yqziKQBLgB1FELPMV0wX0/7zjaOiGzAh5OPCCRBkKnTj+Rx1nAYxHfr
 EpNc+cVdaG0T5ibRLvgH/F3g+1wML4Vuh8mpOQP23GOediRGeSIbUu3BNKFUH+rdBfZQ
 +MjzG8ae3+FD8O0gSH0ad4Z/M0En7i/+f03mhKJXiClH27ZUDVaXWdAn/NSEG1QFAbYG
 AqrdLE+xOTWRqPUd6sB0zqil2M+UhuK57xcxii08w2/2dDtvSVWwylPGYICYCt7W7p54
 e7iw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794729546; x=1795334346; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=j3/L07sFYLe8CHvpXBZT7zI/PCsK6umfJm3RmyGSPi8=;
 b=rLTATAcH6+SY1wOs+36bjBmUINTwIhhSLoF45QSbh1414QR1biQrmU2JBts+D7OxWC
 2AT1oEw0B2LPFXjl7NsdRtWn55KtV6ZwdOaXxbFYaxrFaSx3BhhbbELuoou+loUuxOzW
 20yZ36G+DA9h/1nyElHi8MpzY+W8UhUQGZIRX5zfcImhio5fBdt4sNY6hMQKUNrS3ENC
 dOb7xI/HXbf0aWWQk+q/OrPXSKvgU49JwJYCBIHM5dDcv3XibVKn7nM/tWKmEk+3qonm
 WdA4rFjWCp0ZGRtvgFJQq6e/i4dwPYIe3W0xJeYnkPbNkpSDeymlTdRZhg7vi7ut5wSm
 6Y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794729546; x=1795334346;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j3/L07sFYLe8CHvpXBZT7zI/PCsK6umfJm3RmyGSPi8=;
 b=s1nVyrnN/h7c/B/eKn6UF4cgPsJshxVJdRkw/pgB6Eh6LiJlPciu5if0dbW6bOe8Z6
 XFFLEnrIl72t1+42heou/+b+fXbbD3ZAK0nIv5O11ArKB4HmQcXd3agqnLd31hnQJPs7
 KKoxAzhOSfBzRIO7pIdX6hVOsPm8roPtDUmxQ7Zds/Gy3Q98La+A07Kggdv/Sd6bArF7
 wXX2fRuE5S75ouna2tJu3xW84v/kT7n9vP2lYRTQCQ8yS2N5iSpFX9a1k3BBXtOymLjb
 3tqtNpdbcTbKSN6TA4ttwlqWrMMPnhdxZJk1sOjn3mUf02IgGU8ANO6wFVnZcYSJuo9w
 dV0w==
X-Gm-Message-State: APuU4Z//8Dr9p85oGGgVA+6c5kDKTtUkqZTt+/8Mp74OGvIHFbnW4KPj
 /KReh7oOnXWctqObPvSskIAue6bL73E8a9ZxtAwSMbhlvOqv98Z1QkBMmTTST4KAMk2R2cnH+mJ
 fqDNyqCZcRIBe+0qf7IZCKsimgBiVWvcstI7mJDU5J1sAOUM0z3ftlfp0TcRy/eH9Y5Kbdw0ArL
 R1jcmV9zvCFRKzpn/+KWBKiU94atQXLqQ=
X-Gm-Gg: AYBFou32T8zVNMV/WwtpE/PSi84qIjxJ2yhzgPeKUwiBygXYWhM0DyI1Mt0UYYq+X8Z
 5ffG4Tg4TOTj5JsZJiS3vu2/Fwo2RDF56EQtwQtfhde5RNDVSUBjW6YHF9Mn3n2CTVobKDlGedv
 ZQILGKITMpKhGF3R7UZq3QM5z8dO6ZAmX6Jn+aXSlsy2kA0UH3k8ScKIxXEEO3TM06syOWz4tFK
 kwwsrRTp8kL7FpHdTPyYihMhMnOXXwD8L+pyU99bhvhQro/bFJHIaTlQbHsH0PPp/V27+FZPuvu
 vg==
X-Received: by 2002:a17:902:f64e:b0:2ed:f9c:3e57 with SMTP id
 d9443c01a7336-2ee0dd2a2a2mr66433235ad.50.1794729545472; 
 Sat, 14 Nov 2026 23:59:05 -0800 (PST)
X-Received: by 2002:a17:902:f64e:b0:2ed:f9c:3e57 with SMTP id
 d9443c01a7336-2ee0dd2a2a2mr66433015ad.50.1794729544757; Sat, 14 Nov 2026
 23:59:04 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261113-issue-4848-v3-0-98e4fa3e77eb@redhat.com>
 <20261113-issue-4848-v3-4-98e4fa3e77eb@redhat.com>
 <23ed503d-01ed-4ef4-96d2-e31ca00d4bd9@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <23ed503d-01ed-4ef4-96d2-e31ca00d4bd9@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sun, 15 Nov 2026 11:58:52 +0400
X-Gm-Features: AclHuK_vgXOc6adS_vArEIFtvdKm9uqYS-yPJt63hhujQhIe1y4i5rLB1duen98
Message-ID: <CAMxuvaxDU0K_w5kQfm6UnGskM=zs=ie_uUYbVWVhwMko=ypVTg@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] hw/display/vhost-user-gpu: reset scanouts on the
 main loop
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Dmitry R <rdmitry@taktcycles.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Akihiko

On Sat, Nov 14, 2026 at 3:54=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/11/13 9:29, Marc-Andr=C3=A9 Lureau wrote:
> > vhost_user_gpu_reset() runs on the vCPU thread when the guest writes th=
e
> > device status. Installing the placeholder surface there calls the
> > display listener without the EGL context being current, so the D-Bus
> > listener receives a surface without a texture and aborts on the tex_id
> > assertion.
> >
> > Defer the display cleanup to a bottom half, as virtio_gpu_reset() does,
> > and wait for it when reset is triggered from a vCPU thread.
>
> This suffers from the same issue the following patch series addresses:
> https://lore.kernel.org/qemu-devel/20260908-gpu-v3-0-25332a85f909@rsg.ci.=
i.u-tokyo.ac.jp/
> ("[PATCH v3 0/9] virtio-gpu: Do not wait for the main thread during reset=
")

Could you fix vhost-user-gpu in the same series?

Should we review & merge your series before this one?


>
> Regards,
> Akihiko Odaki
>
> >
> > Reported-by: Dmitry R <rdmitry@taktcycles.com>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   hw/display/vhost-user-gpu.c    | 39 +++++++++++++++++++++++++++++++++=
++++--
> >   include/hw/virtio/virtio-gpu.h |  4 ++++
> >   2 files changed, 41 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/display/vhost-user-gpu.c b/hw/display/vhost-user-gpu.c
> > index d3b720d08a73..46e7fc136583 100644
> > --- a/hw/display/vhost-user-gpu.c
> > +++ b/hw/display/vhost-user-gpu.c
> > @@ -18,6 +18,7 @@
> >   #include "chardev/char-fe.h"
> >   #include "qapi/error.h"
> >   #include "migration/blocker.h"
> > +#include "system/cpus.h"
> >   #include "standard-headers/drm/drm_fourcc.h"
> >
> >   typedef enum VhostUserGpuRequest {
> > @@ -635,9 +636,9 @@ vhost_user_gpu_instance_finalize(Object *obj)
> >   }
> >
> >   static void
> > -vhost_user_gpu_reset(VirtIODevice *vdev)
> > +vhost_user_gpu_reset_bh(void *opaque)
> >   {
> > -    VhostUserGPU *g =3D VHOST_USER_GPU(vdev);
> > +    VhostUserGPU *g =3D VHOST_USER_GPU(opaque);
> >       int i;
> >
> >       /* release the scanouts before virtio_gpu_base_reset() drops ds *=
/
> > @@ -653,6 +654,25 @@ vhost_user_gpu_reset(VirtIODevice *vdev)
> >           qemu_console_set_surface(scanout->con, NULL);
> >       }
> >
> > +    g->reset_finished =3D true;
> > +    qemu_cond_signal(&g->reset_cond);
> > +}
> > +
> > +static void
> > +vhost_user_gpu_reset(VirtIODevice *vdev)
> > +{
> > +    VhostUserGPU *g =3D VHOST_USER_GPU(vdev);
> > +
> > +    if (qemu_in_vcpu_thread()) {
> > +        g->reset_finished =3D false;
> > +        qemu_bh_schedule(g->reset_bh);
> > +        while (!g->reset_finished) {
> > +            qemu_cond_wait_bql(&g->reset_cond);
> > +        }
> > +    } else {
> > +        aio_bh_call(g->reset_bh);
> > +    }
> > +
> >       virtio_gpu_base_reset(VIRTIO_GPU_BASE(vdev));
> >
> >       vhost_user_backend_stop(g->vhost);
> > @@ -699,9 +719,23 @@ vhost_user_gpu_device_realize(DeviceState *qdev, E=
rror **errp)
> >           return;
> >       }
> >
> > +    g->reset_bh =3D virtio_bh_io_new_guarded(qdev, vhost_user_gpu_rese=
t_bh, g);
> > +    qemu_cond_init(&g->reset_cond);
> > +
> >       g->vhost_gpu_fd =3D -1;
> >   }
> >
> > +static void
> > +vhost_user_gpu_device_unrealize(DeviceState *qdev)
> > +{
> > +    VhostUserGPU *g =3D VHOST_USER_GPU(qdev);
> > +
> > +    g_clear_pointer(&g->reset_bh, qemu_bh_delete);
> > +    qemu_cond_destroy(&g->reset_cond);
> > +
> > +    virtio_gpu_base_device_unrealize(qdev);
> > +}
> > +
> >   static struct vhost_dev *vhost_user_gpu_get_vhost(VirtIODevice *vdev)
> >   {
> >       VhostUserGPU *g =3D VHOST_USER_GPU(vdev);
> > @@ -722,6 +756,7 @@ vhost_user_gpu_class_init(ObjectClass *klass, const=
 void *data)
> >       vgc->gl_flushed =3D vhost_user_gpu_gl_flushed;
> >
> >       vdc->realize =3D vhost_user_gpu_device_realize;
> > +    vdc->unrealize =3D vhost_user_gpu_device_unrealize;
> >       vdc->reset =3D vhost_user_gpu_reset;
> >       vdc->set_status   =3D vhost_user_gpu_set_status;
> >       vdc->guest_notifier_mask =3D vhost_user_gpu_guest_notifier_mask;
> > diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-=
gpu.h
> > index 631dfc63a4d4..c8cb91032968 100644
> > --- a/include/hw/virtio/virtio-gpu.h
> > +++ b/include/hw/virtio/virtio-gpu.h
> > @@ -276,6 +276,10 @@ struct VhostUserGPU {
> >       CharFrontend vhost_chr;
> >       QemuDmaBuf *dmabuf[VIRTIO_GPU_MAX_SCANOUTS];
> >       bool backend_blocked;
> > +
> > +    QEMUBH *reset_bh;
> > +    QemuCond reset_cond;
> > +    bool reset_finished;
> >   };
> >
> >   #define MAX_SLOTS 4096
> >
>


