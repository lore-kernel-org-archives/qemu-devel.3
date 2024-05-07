Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5766C25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 13:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Ksv-00062Q-Km; Tue, 07 May 2024 09:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1s4Kst-000625-Sa
 for qemu-devel@nongnu.org; Tue, 07 May 2024 09:29:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1s4Ksr-0004CK-LA
 for qemu-devel@nongnu.org; Tue, 07 May 2024 09:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715088566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b5yd4GjL4qX6YlwdPSSjSQ+W9J166p+cC+Yaup/VRpM=;
 b=RL0akS3DONHFvEZpCvBmxbUplniVqDwAHjiqsEuhnsUJvv7oVit5tVnalWuVOuVxuOSui2
 WObhJAqKSxCIjydPq11//2/PrN069094tNkpyaDaPSIugT3XseeJyPAg7VsLSJ90Sv2sLP
 zm2vtC//PN6hmIe76SR8ODYXRkZf6bo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-0E_8-2hQPdSCWxAlQiSq0A-1; Tue, 07 May 2024 09:29:25 -0400
X-MC-Unique: 0E_8-2hQPdSCWxAlQiSq0A-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-558aafe9bf2so2279109a12.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 06:29:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715088564; x=1715693364;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b5yd4GjL4qX6YlwdPSSjSQ+W9J166p+cC+Yaup/VRpM=;
 b=V3WhlOrLCY9I2JS6zvFrhokMjfbVHXG4WPfYYZtnI9xIQFL4EbERHv/Rv3SVxzLeET
 95wb71hPYKg9nqnUrYJaIY9Tt6IuTJxQROqm74y4HXvHcztU5IdBfCMQMmZ9GhAOePNm
 Y6VsdvK6efG/KdCL2vXV04Oj2KqnGSoIRiFrvoA5lq+zqwmTHWFTZjvyMuHWFSqMFRfR
 09spNFpyt+sqohzKE9yw6SFSmOp14njw3Oz1xGyhLKBq3lsL3CKb2xitsFqWFjJyICbo
 MIpCaIQrDAj5dp3AeNEG/MfLtqtelArk554VSVi++KY7mwYlY5aqWoM9mzmyM7tZ2/a2
 mKUw==
X-Gm-Message-State: AOJu0YybfnkPO0YI2UU61j1NQWaNa/o0xYBv4Eu/dTvuepFoHjswIVqc
 lgO2Wd0BMdAfFKiBA6/G70jYns9bcvHCQHNqFCJ+lYh1iADW91vKXzBAuqE5A/kd+NQRuM52MBK
 tz54Zh8w2IOStkMbXefOAqbgKoidP+k5iyUQ9VT88m3Q4c1M9Lj00hLzffu+3zEre08bLJ5bYk5
 258EE1L+U8f+SUaOkU9t2I52QaSTE=
X-Received: by 2002:a50:d55e:0:b0:572:8aab:4415 with SMTP id
 f30-20020a50d55e000000b005728aab4415mr7181302edj.40.1715088564310; 
 Tue, 07 May 2024 06:29:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExQGDSfkyn/y1bcwM66yrKPB2puPyWRn0fQJfAwX6wg/H+WrD7dAzvfx+SksdEF9GMDsAX+kC/bnkZhca1YzU=
X-Received: by 2002:a50:d55e:0:b0:572:8aab:4415 with SMTP id
 f30-20020a50d55e000000b005728aab4415mr7181290edj.40.1715088563968; Tue, 07
 May 2024 06:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240425015342.1033815-1-dongwon.kim@intel.com>
 <20240425015342.1033815-3-dongwon.kim@intel.com>
In-Reply-To: <20240425015342.1033815-3-dongwon.kim@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 7 May 2024 17:29:11 +0400
Message-ID: <CAMxuvayD5v9Dqo-59j_jG3Ys+rfFj-EaerRiTSXjWNAsbfK4pg@mail.gmail.com>
Subject: Re: [PATCH v12 2/6] ui/console: new dmabuf.h and dmabuf.c for
 QemuDmaBuf struct and helpers
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org, berrange@redhat.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 25, 2024 at 5:58=E2=80=AFAM <dongwon.kim@intel.com> wrote:
>
> From: Dongwon Kim <dongwon.kim@intel.com>
>
> New header and source files are added for containing QemuDmaBuf struct
> definition and newly introduced helpers for creating/freeing the struct
> and accessing its data.
>
> v10: Change the license type for both dmabuf.h and dmabuf.c from MIT to
>      GPL to be in line with QEMU's default license
>
> v11: -- Added new helpers, qemu_dmabuf_close for closing dmabuf->fd,
>         qemu_dmabuf_dup_fd for duplicating dmabuf->fd
>         (Daniel P. Berrang=C3=A9 <berrange@redhat.com>)
>
>      -- Let qemu_dmabuf_fee to call qemu_dmabuf_close before freeing
>         the struct to make sure fd is closed.
>         (Daniel P. Berrang=C3=A9 <berrange@redhat.com>)
>
> v12: Not closing fd in qemu_dmabuf_free because there are cases fd
>      should still be available even after the struct is destroyed
>      (e.g. virtio-gpu: res->dmabuf_fd).
>
> Suggested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  include/ui/console.h |  20 +----
>  include/ui/dmabuf.h  |  66 ++++++++++++++
>  ui/dmabuf.c          | 210 +++++++++++++++++++++++++++++++++++++++++++
>  ui/meson.build       |   1 +
>  4 files changed, 278 insertions(+), 19 deletions(-)
>  create mode 100644 include/ui/dmabuf.h
>  create mode 100644 ui/dmabuf.c
>
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 0bc7a00ac0..a208a68b88 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -7,6 +7,7 @@
>  #include "qapi/qapi-types-ui.h"
>  #include "ui/input.h"
>  #include "ui/surface.h"
> +#include "ui/dmabuf.h"
>
>  #define TYPE_QEMU_CONSOLE "qemu-console"
>  OBJECT_DECLARE_TYPE(QemuConsole, QemuConsoleClass, QEMU_CONSOLE)
> @@ -185,25 +186,6 @@ struct QEMUGLParams {
>      int minor_ver;
>  };
>
> -typedef struct QemuDmaBuf {
> -    int       fd;
> -    uint32_t  width;
> -    uint32_t  height;
> -    uint32_t  stride;
> -    uint32_t  fourcc;
> -    uint64_t  modifier;
> -    uint32_t  texture;
> -    uint32_t  x;
> -    uint32_t  y;
> -    uint32_t  backing_width;
> -    uint32_t  backing_height;
> -    bool      y0_top;
> -    void      *sync;
> -    int       fence_fd;
> -    bool      allow_fences;
> -    bool      draw_submitted;
> -} QemuDmaBuf;
> -
>  enum display_scanout {
>      SCANOUT_NONE,
>      SCANOUT_SURFACE,
> diff --git a/include/ui/dmabuf.h b/include/ui/dmabuf.h
> new file mode 100644
> index 0000000000..4198cdf85a
> --- /dev/null
> +++ b/include/ui/dmabuf.h
> @@ -0,0 +1,66 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * QemuDmaBuf struct and helpers used for accessing its data
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef DMABUF_H
> +#define DMABUF_H
> +
> +typedef struct QemuDmaBuf {
> +    int       fd;
> +    uint32_t  width;
> +    uint32_t  height;
> +    uint32_t  stride;
> +    uint32_t  fourcc;
> +    uint64_t  modifier;
> +    uint32_t  texture;
> +    uint32_t  x;
> +    uint32_t  y;
> +    uint32_t  backing_width;
> +    uint32_t  backing_height;
> +    bool      y0_top;
> +    void      *sync;
> +    int       fence_fd;
> +    bool      allow_fences;
> +    bool      draw_submitted;
> +} QemuDmaBuf;
> +
> +QemuDmaBuf *qemu_dmabuf_new(uint32_t width, uint32_t height,
> +                            uint32_t stride, uint32_t x,
> +                            uint32_t y, uint32_t backing_width,
> +                            uint32_t backing_height, uint32_t fourcc,
> +                            uint64_t modifier, int dmabuf_fd,
> +                            bool allow_fences, bool y0_top);
> +void qemu_dmabuf_free(QemuDmaBuf *dmabuf);
> +
> +G_DEFINE_AUTOPTR_CLEANUP_FUNC(QemuDmaBuf, qemu_dmabuf_free);
> +
> +int qemu_dmabuf_get_fd(QemuDmaBuf *dmabuf);
> +int qemu_dmabuf_dup_fd(QemuDmaBuf *dmabuf);
> +void qemu_dmabuf_close(QemuDmaBuf *dmabuf);
> +uint32_t qemu_dmabuf_get_width(QemuDmaBuf *dmabuf);
> +uint32_t qemu_dmabuf_get_height(QemuDmaBuf *dmabuf);
> +uint32_t qemu_dmabuf_get_stride(QemuDmaBuf *dmabuf);
> +uint32_t qemu_dmabuf_get_fourcc(QemuDmaBuf *dmabuf);
> +uint64_t qemu_dmabuf_get_modifier(QemuDmaBuf *dmabuf);
> +uint32_t qemu_dmabuf_get_texture(QemuDmaBuf *dmabuf);
> +uint32_t qemu_dmabuf_get_x(QemuDmaBuf *dmabuf);
> +uint32_t qemu_dmabuf_get_y(QemuDmaBuf *dmabuf);
> +uint32_t qemu_dmabuf_get_backing_width(QemuDmaBuf *dmabuf);
> +uint32_t qemu_dmabuf_get_backing_height(QemuDmaBuf *dmabuf);
> +bool qemu_dmabuf_get_y0_top(QemuDmaBuf *dmabuf);
> +void *qemu_dmabuf_get_sync(QemuDmaBuf *dmabuf);
> +int32_t qemu_dmabuf_get_fence_fd(QemuDmaBuf *dmabuf);
> +bool qemu_dmabuf_get_allow_fences(QemuDmaBuf *dmabuf);
> +bool qemu_dmabuf_get_draw_submitted(QemuDmaBuf *dmabuf);
> +void qemu_dmabuf_set_texture(QemuDmaBuf *dmabuf, uint32_t texture);
> +void qemu_dmabuf_set_fence_fd(QemuDmaBuf *dmabuf, int32_t fence_fd);
> +void qemu_dmabuf_set_sync(QemuDmaBuf *dmabuf, void *sync);
> +void qemu_dmabuf_set_draw_submitted(QemuDmaBuf *dmabuf, bool draw_submit=
ted);
> +void qemu_dmabuf_set_fd(QemuDmaBuf *dmabuf, int32_t fd);
> +
> +#endif
> diff --git a/ui/dmabuf.c b/ui/dmabuf.c
> new file mode 100644
> index 0000000000..e047d5ca26
> --- /dev/null
> +++ b/ui/dmabuf.c
> @@ -0,0 +1,210 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * QemuDmaBuf struct and helpers used for accessing its data
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "ui/dmabuf.h"
> +
> +QemuDmaBuf *qemu_dmabuf_new(uint32_t width, uint32_t height,
> +                            uint32_t stride, uint32_t x,
> +                            uint32_t y, uint32_t backing_width,
> +                            uint32_t backing_height, uint32_t fourcc,
> +                            uint64_t modifier, int32_t dmabuf_fd,
> +                            bool allow_fences, bool y0_top) {
> +    QemuDmaBuf *dmabuf;
> +
> +    dmabuf =3D g_new0(QemuDmaBuf, 1);
> +
> +    dmabuf->width =3D width;
> +    dmabuf->height =3D height;
> +    dmabuf->stride =3D stride;
> +    dmabuf->x =3D x;
> +    dmabuf->y =3D y;
> +    dmabuf->backing_width =3D backing_width;
> +    dmabuf->backing_height =3D backing_height;
> +    dmabuf->fourcc =3D fourcc;
> +    dmabuf->modifier =3D modifier;
> +    dmabuf->fd =3D dmabuf_fd;
> +    dmabuf->allow_fences =3D allow_fences;
> +    dmabuf->y0_top =3D y0_top;
> +    dmabuf->fence_fd =3D -1;
> +
> +    return dmabuf;
> +}
> +
> +void qemu_dmabuf_free(QemuDmaBuf *dmabuf)
> +{
> +    if (dmabuf =3D=3D NULL) {
> +        return;
> +    }
> +
> +    g_free(dmabuf);
> +}
> +
> +int qemu_dmabuf_get_fd(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    return dmabuf->fd;
> +}
> +
> +int qemu_dmabuf_dup_fd(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    if (dmabuf->fd >=3D 0) {
> +        return dup(dmabuf->fd);
> +    } else {
> +        return -1;
> +    }
> +}
> +
> +void qemu_dmabuf_close(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    if (dmabuf->fd >=3D 0) {
> +        close(dmabuf->fd);
> +        dmabuf->fd =3D -1;
> +    }
> +}
> +
> +uint32_t qemu_dmabuf_get_width(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    return dmabuf->width;
> +}
> +
> +uint32_t qemu_dmabuf_get_height(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    return dmabuf->height;
> +}
> +
> +uint32_t qemu_dmabuf_get_stride(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    return dmabuf->stride;
> +}
> +
> +uint32_t qemu_dmabuf_get_fourcc(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    return dmabuf->fourcc;
> +}
> +
> +uint64_t qemu_dmabuf_get_modifier(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    return dmabuf->modifier;
> +}
> +
> +uint32_t qemu_dmabuf_get_texture(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    return dmabuf->texture;
> +}
> +
> +uint32_t qemu_dmabuf_get_x(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    return dmabuf->x;
> +}
> +
> +uint32_t qemu_dmabuf_get_y(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    return dmabuf->y;
> +}
> +
> +uint32_t qemu_dmabuf_get_backing_width(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    return dmabuf->backing_width;
> +}
> +
> +uint32_t qemu_dmabuf_get_backing_height(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    return dmabuf->backing_height;
> +}
> +
> +bool qemu_dmabuf_get_y0_top(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    return dmabuf->y0_top;
> +}
> +
> +void *qemu_dmabuf_get_sync(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    return dmabuf->sync;
> +}
> +
> +int32_t qemu_dmabuf_get_fence_fd(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    return dmabuf->fence_fd;
> +}
> +
> +bool qemu_dmabuf_get_allow_fences(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    return dmabuf->allow_fences;
> +}
> +
> +bool qemu_dmabuf_get_draw_submitted(QemuDmaBuf *dmabuf)
> +{
> +    assert(dmabuf !=3D NULL);
> +
> +    return dmabuf->draw_submitted;
> +}
> +
> +void qemu_dmabuf_set_texture(QemuDmaBuf *dmabuf, uint32_t texture)
> +{
> +    assert(dmabuf !=3D NULL);
> +    dmabuf->texture =3D texture;
> +}
> +
> +void qemu_dmabuf_set_fence_fd(QemuDmaBuf *dmabuf, int32_t fence_fd)
> +{
> +    assert(dmabuf !=3D NULL);
> +    dmabuf->fence_fd =3D fence_fd;
> +}
> +
> +void qemu_dmabuf_set_sync(QemuDmaBuf *dmabuf, void *sync)
> +{
> +    assert(dmabuf !=3D NULL);
> +    dmabuf->sync =3D sync;
> +}
> +
> +void qemu_dmabuf_set_draw_submitted(QemuDmaBuf *dmabuf, bool draw_submit=
ted)
> +{
> +    assert(dmabuf !=3D NULL);
> +    dmabuf->draw_submitted =3D draw_submitted;
> +}
> +
> +void qemu_dmabuf_set_fd(QemuDmaBuf *dmabuf, int32_t fd)
> +{
> +    assert(dmabuf !=3D NULL);
> +    dmabuf->fd =3D fd;
> +}
> diff --git a/ui/meson.build b/ui/meson.build
> index a5ce22a678..5d89986b0e 100644
> --- a/ui/meson.build
> +++ b/ui/meson.build
> @@ -7,6 +7,7 @@ system_ss.add(files(
>    'clipboard.c',
>    'console.c',
>    'cursor.c',
> +  'dmabuf.c',
>    'input-keymap.c',
>    'input-legacy.c',
>    'input-barrier.c',
> --
> 2.34.1
>


