Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09721C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 07:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9fYq-0002EH-R4; Tue, 29 Apr 2025 03:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1u9fYb-0002Ag-L8
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 03:39:15 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1u9fYZ-0007Ua-VP
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 03:39:09 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-476a1acf61eso56257461cf.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 00:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745912345; x=1746517145; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ySM/7rWCBahNFmxMgy74iMfxya7/FbXwUrQ61yRJJ5Q=;
 b=EoY7SHdagk2PB3rVKlADE1C80mjlmPTUIKa5/LW1c5NxzCjOd6XMwAQri9Eb5cW8AY
 WuqRjOGbxGLtSHFMg3xZzOQhtyMYIwBMhU3gKdDFItRajN6IEDswWOv1d2hCXNbNAu1H
 GNjXU0hA41CJA0adwlm0gGdRLq9LTActP6uJYuNb4fXIsh1F2HP5RgjRsVosMNsfU2j/
 nBpzL6AayQg9VQM7tiunmwhZH0vI3/d33DRLQ7mt9kdAOQOHM7SbJznrJf+Z/rN3UPdM
 1a55bRJteFtaqEgCf5XvSjZ+/IXfWvdCrfbPJwnyit3S5wD8WOZj+3xDmfjK7OouRRH7
 HAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745912345; x=1746517145;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ySM/7rWCBahNFmxMgy74iMfxya7/FbXwUrQ61yRJJ5Q=;
 b=kTWjozVwAbjnLt7AxujeysEyXvwQ05zDoDrJP4h8jpc3KLJXZsy/W/a7YKOssh2eY3
 g5w2kPOMWir8EjIM2FGgnL78EtnipiU+8ZCreJ8c4NOLaKY8k+OV/8CCj4AMYDJEdw0o
 6dUyGnNFzcfGg6i2YB07BWnQ1SC44FpTCS60zX6taRFXladVcRCgFcrj4a+S3QvYhqQP
 CNuJ0q4eOnEfZs4SQhRYqcXii1owLzyQJ+WkvlagpVt/smoYyChSMtPaOW8tlwJN+J2D
 6IXn9hzeO4ShEdELT/Wis99j762gksL8rKKKaQygodMELQxQGKKEEW4vWDz2PGozZVI9
 oIew==
X-Gm-Message-State: AOJu0Yw1PFFqYC1cbg6vJRjMSkuXtfpnycllNpv6VjzNHovt/7bo/66W
 yUchNCk3Xln1miUwJmMoGXwZ9Epjmr03f4LpU37pbVRpY7zA5B2+Q8/KJNrq9NIPp5dFV6nZgNz
 9nNOgcRrba1cylfvDBDtl1xSxohM5YbnQATk=
X-Gm-Gg: ASbGncuzEdlzm2DUiFlwBfEucgsg8PpRefgv4lWQ25kmx+ITVeW5E5Idb61lLw9I2+v
 ARPOpwJsAliujhi79GddsRkrLKDTslW54VGoCOhxMGb6pfm5+FV0ggLL2/LBLxn49WGXEDncL6T
 gTBKBwYQ6k3Bz48LcwfmENWKPsAjDjyoOtURseo/ZjhOj73l21LL6/ezlYF59vZFdR/Q==
X-Google-Smtp-Source: AGHT+IGHyu4Zp/6BXDqxTWr3ca4qzdf6sPmHC0McPRuSsfw7IaE39fF/R/6QT6ZpYjtE+w4o5p9Rwik7i+zHS5SvifE=
X-Received: by 2002:a05:622a:6089:b0:476:add4:d2b1 with SMTP id
 d75a77b69052e-4886fe5d4e0mr33146021cf.11.1745912345537; Tue, 29 Apr 2025
 00:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250429060952.59508-1-vivek.kasireddy@intel.com>
 <20250429060952.59508-5-vivek.kasireddy@intel.com>
In-Reply-To: <20250429060952.59508-5-vivek.kasireddy@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 29 Apr 2025 11:38:53 +0400
X-Gm-Features: ATxdqUHimzuMYkcudClpNbVkcZ5MqBNzKPXE33Uk3jqS54QxnJy36gw-HDJyVrQ
Message-ID: <CAJ+F1CJEJW_MaBCBc0Ybua8tuaa4oBWLtVVCernz+6LvsfhmGA@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] ui/console-gl: Add a helper to create a texture
 with linear memory layout
To: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Frediano Ziglio <freddy77@gmail.com>, Dongwon Kim <dongwon.kim@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82e.google.com
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

On Tue, Apr 29, 2025 at 10:14=E2=80=AFAM Vivek Kasireddy
<vivek.kasireddy@intel.com> wrote:
>
> There are cases where we do not want the memory layout of a texture to
> be tiled as the component processing the texture would not know how to
> de-tile either via software or hardware. Therefore, ensuring that the
> memory backing the texture has a linear layout is absolutely necessary
> in these situations.
>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: Frediano Ziglio <freddy77@gmail.com>
> Cc: Dongwon Kim <dongwon.kim@intel.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>  include/ui/console.h |  2 ++
>  ui/console-gl.c      | 28 ++++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 46b3128185..fa2dd53e2e 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -422,6 +422,8 @@ bool console_gl_check_format(DisplayChangeListener *d=
cl,
>                               pixman_format_code_t format);
>  void surface_gl_create_texture(QemuGLShader *gls,
>                                 DisplaySurface *surface);
> +void surface_gl_create_texture_from_fd(DisplaySurface *surface,
> +                                       int fd, GLuint *texture);
>  void surface_gl_update_texture(QemuGLShader *gls,
>                                 DisplaySurface *surface,
>                                 int x, int y, int w, int h);
> diff --git a/ui/console-gl.c b/ui/console-gl.c
> index 103b954017..f83012fed4 100644
> --- a/ui/console-gl.c
> +++ b/ui/console-gl.c
> @@ -25,6 +25,7 @@
>   * THE SOFTWARE.
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "ui/console.h"
>  #include "ui/shader.h"
>
> @@ -96,6 +97,33 @@ void surface_gl_create_texture(QemuGLShader *gls,
>      glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
>  }
>
> +void surface_gl_create_texture_from_fd(DisplaySurface *surface,
> +                                       int fd, GLuint *texture)
> +{
> +    unsigned long size =3D surface_stride(surface) * surface_height(surf=
ace);
> +    GLuint mem_obj;
> +
> +    if (!epoxy_has_gl_extension("GL_EXT_memory_object") ||
> +        !epoxy_has_gl_extension("GL_EXT_memory_object_fd")) {
> +        return;
> +    }
> +
> +#ifdef GL_EXT_memory_object_fd
> +    glCreateMemoryObjectsEXT(1, &mem_obj);
> +    glImportMemoryFdEXT(mem_obj, size, GL_HANDLE_TYPE_OPAQUE_FD_EXT, fd)=
;
> +    if (glGetError() !=3D GL_NO_ERROR) {
> +        error_report("spice: cannot import memory object from fd");
> +        return;
> +    }
> +
> +    glGenTextures(1, texture);
> +    glBindTexture(GL_TEXTURE_2D, *texture);
> +    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_TILING_EXT, GL_LINEAR_TILI=
NG_EXT);
> +    glTexStorageMem2DEXT(GL_TEXTURE_2D, 1, GL_RGBA8, surface_width(surfa=
ce),
> +                         surface_height(surface), mem_obj, 0);
> +#endif

I suggest making the function return a "bool" for success. return
*texture > 0 && glGetError() =3D=3D GL_NO_ERROR  for example.

> +}
> +
>  void surface_gl_update_texture(QemuGLShader *gls,
>                                 DisplaySurface *surface,
>                                 int x, int y, int w, int h)
> --
> 2.49.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

