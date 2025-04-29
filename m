Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F8BC369CB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 07:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9fq7-0002ly-6E; Tue, 29 Apr 2025 03:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1u9fq4-0002h5-VD
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 03:57:13 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1u9fq3-0001i4-1k
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 03:57:12 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-47ae894e9b7so126197471cf.3
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 00:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745913429; x=1746518229; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1d9ARNGCWUyYFaldzJ6MkvlROsfVdZxOlnwHjJwXpdw=;
 b=hW7UP6s3AQDiFrt6GXYX1VaCb42YMN9PZM7A2XgUJuBGm0VZitfowYHJa7sYe9whMl
 r4GewT3f2UfGEmxnkELpOe/bbTbtWqooT//xMhuf8xkoKho1KtxFjxoJtlbcO7/UfMpy
 es0B9ekl3N0gk/BoaM/SpCpB6SNgrV+iYyyZqoyqhBm/5ayNlSRebG5WHVfs0mm+qEl6
 ngVmgAbAojcfGosNCjwMdy4Nzj2OVNztCsszQvFBJYMP/jNWAz71AohKXH64ErXRMKNe
 het7LXwKRPp5IcoKiukeYtCPWBVyybzgsTOoYvowtRWBr1LWatyC9pC+YLv5NdO2V/g0
 zcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745913429; x=1746518229;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1d9ARNGCWUyYFaldzJ6MkvlROsfVdZxOlnwHjJwXpdw=;
 b=fl6T81nX0Pz+9JWgmlfP2izMO/o6d6KEm4n5nRh4f0nVeOL0zsIm4v5+YXp7+rFK33
 4HYEd5Y4vtMrF9j9PgzuI2/g7wHZC43OoeUC1hpc57UQXKeiO8ULUQ5f9dfA28lpBDo0
 sQgwnxIQESHsQXqbF+W/5XEWPZUHqrymA6LRWYXJ5SMyct8rc6KugmZJ1/rCLVym5yn8
 90x1hm5qYvzkxoB6DNmRwIc8XH0k/T8AqGfmDoVrcLaEby1EZbFojyjb+Tw3QQcasZV1
 HrYcKuG125lYOGVF45ngBZJ5+u3ji1KwuYxFFNpAuCbqweFXkqRSbTXcjmo9Ii4N1ejh
 1klA==
X-Gm-Message-State: AOJu0Ywu1EKEFyNq1deq/VBPppAOzQwlNC0r9dvi/vagsHmYVL9yMlI0
 D3XPYu8Z+0IqPV48TdAXX0HOI5SsEBepwHRujVPbZ6m9fPIsSxeIzftmX3FD/iePGTqsfyUNVJg
 jQE/zyK6EVvFxCBIgzP/hS6+0Jmw=
X-Gm-Gg: ASbGncttNfb1B4o/4F7Riz622iqi1sK3j4yJxrADBE1pQHdvIzTI14+ny6djkKbGU80
 TdqgJfi3s9CWYdLu948HHwOqkdV5hYMQFbcWztdxwp8u5IFrQ6rJ7Zjwup8k5iwMHbvA+qJAc6z
 h7nxyABVXSuJVN7j+HTi2nWxn6JOLc18RpdJOdPuGlowDelHoNiciyIA0=
X-Google-Smtp-Source: AGHT+IE1QCCp0r53vXZm9dT5WBeIS2TQbvOHBs4LAgLapKkSiRJymIFdYDMxA+3qvsT5f3DN+eOD3C5CdtHMGhCNbgQ=
X-Received: by 2002:ac8:5d0f:0:b0:476:8e88:6632 with SMTP id
 d75a77b69052e-48131de4b4bmr161656791cf.29.1745913429064; Tue, 29 Apr 2025
 00:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250429060952.59508-1-vivek.kasireddy@intel.com>
 <20250429060952.59508-6-vivek.kasireddy@intel.com>
In-Reply-To: <20250429060952.59508-6-vivek.kasireddy@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 29 Apr 2025 11:56:56 +0400
X-Gm-Features: ATxdqUHlxW-SSu_x9X0RuX8rt3VNdFu9VG2vlHeBaH252V6nWO6dv4lyvVB8cD8
Message-ID: <CAJ+F1CKxjHW773h1HaVH4o4SD2uWL=xnCBWutWN50FwxR-whGA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] ui/spice: Create a new texture with linear layout
 when gl=on is enabled
To: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x833.google.com
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

On Tue, Apr 29, 2025 at 10:13=E2=80=AFAM Vivek Kasireddy
<vivek.kasireddy@intel.com> wrote:
>
> Since most encoders/decoders (invoked by Spice) may not work with
> tiled memory associated with a texture, we need to create another
> texture that has linear memory layout and use that instead.
>
> Note that, there does not seem to be a direct way to indicate to the
> GL implementation that a texture's backing memory needs to be linear.
> Instead, we have to do it in a roundabout way where we need to first
> create a tiled texture and import that as a memory object to create
> a new texture that has a linear memory layout.
>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Frediano Ziglio <freddy77@gmail.com>
> Cc: Dongwon Kim <dongwon.kim@intel.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>  ui/spice-display.c | 63 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 62 insertions(+), 1 deletion(-)
>
> diff --git a/ui/spice-display.c b/ui/spice-display.c
> index 2c4daa0707..047d453a0b 100644
> --- a/ui/spice-display.c
> +++ b/ui/spice-display.c
> @@ -26,6 +26,7 @@
>  #include "ui/console.h"
>  #include "trace.h"
>
> +#include "standard-headers/drm/drm_fourcc.h"
>  #include "ui/spice-display.h"
>
>  bool spice_opengl;
> @@ -890,11 +891,65 @@ static void spice_gl_update(DisplayChangeListener *=
dcl,
>      ssd->gl_updates++;
>  }
>
> +static bool spice_gl_replace_fd_texture(SimpleSpiceDisplay *ssd,
> +                                        EGLint *stride, EGLint *fourcc,
> +                                        EGLuint64KHR *modifier,
> +                                        int *fd)
> +{
> +    GLuint texture =3D 0;
> +
> +    if (!remote_client) {
> +        return true;
> +    }
> +
> +    if (surface_format(ssd->ds) =3D=3D PIXMAN_r5g6b5) {
> +        return true;
> +    }

Please explain why this particular format is handled differently with a com=
ment.

> +
> +    if (*modifier =3D=3D DRM_FORMAT_MOD_LINEAR) {
> +        return true;
> +    }
> +
> +    /*
> +     * We really want to ensure that the memory layout of the texture
> +     * is linear; otherwise, the encoder's output may show corruption.
> +     */
> +    surface_gl_create_texture_from_fd(ssd->ds, *fd, &texture);
> +
> +    /*
> +     * A successful return after glImportMemoryFdEXT() means that
> +     * the ownership of fd has been passed to GL. In other words,
> +     * the fd we got above should not be used anymore.
> +     */
> +    if (texture > 0) {
> +        *fd =3D egl_get_fd_for_texture(texture,
> +                                     stride, fourcc,
> +                                     NULL);
> +        if (*fd < 0) {
> +            glDeleteTextures(1, &texture);
> +            *fd =3D egl_get_fd_for_texture(ssd->ds->texture,
> +                                         stride, fourcc,
> +                                         NULL);
> +            if (*fd < 0) {
> +                surface_gl_destroy_texture(ssd->gls, ssd->ds);
> +                warn_report("spice: no texture available to display");
> +                return false;
> +            }
> +        } else {
> +            surface_gl_destroy_texture(ssd->gls, ssd->ds);
> +            ssd->ds->texture =3D texture;
> +        }
> +    }

If it failed, it does nothing and continues?


> +    return true;
> +}
> +
>  static void spice_gl_switch(DisplayChangeListener *dcl,
>                              struct DisplaySurface *new_surface)
>  {
>      SimpleSpiceDisplay *ssd =3D container_of(dcl, SimpleSpiceDisplay, dc=
l);
>      EGLint stride, fourcc;
> +    EGLuint64KHR modifier;
> +    bool ret;
>      int fd;
>
>      if (ssd->ds) {
> @@ -905,12 +960,18 @@ static void spice_gl_switch(DisplayChangeListener *=
dcl,
>          surface_gl_create_texture(ssd->gls, ssd->ds);
>          fd =3D egl_get_fd_for_texture(ssd->ds->texture,
>                                      &stride, &fourcc,
> -                                    NULL);
> +                                    &modifier);
>          if (fd < 0) {
>              surface_gl_destroy_texture(ssd->gls, ssd->ds);
>              return;
>          }
>
> +        ret =3D spice_gl_replace_fd_texture(ssd, &stride, &fourcc, &modi=
fier, &fd);
> +        if (!ret) {
> +            surface_gl_destroy_texture(ssd->gls, ssd->ds);
> +            return;
> +        }
> +
>          trace_qemu_spice_gl_surface(ssd->qxl.id,
>                                      surface_width(ssd->ds),
>                                      surface_height(ssd->ds),
> --
> 2.49.0
>
>


--
Marc-Andr=C3=A9 Lureau

