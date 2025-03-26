Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D14C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 10:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txORf-0005fR-VS; Wed, 26 Mar 2025 06:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1txORX-0005ev-KO
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 06:57:07 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1txORV-00007R-SX
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 06:57:07 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-47664364628so8210951cf.1
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 03:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742986625; x=1743591425; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VwyiHCaJrQ4Q9LMvwEc9EK8HZFr2eRGGkOP5KB/fbvg=;
 b=RU54p+NIj+EavU5Q1GFChjnDgE+cDjZuTq9AA6mvhqAFOuQsbmNY9lZiwt0uwLyMyx
 EvdOYjVMXU9AfCbOBp2jlktgoQB/biPqYlTgmIlLiwvxP+WqGKsgqr6Q2WoKONqGXWAx
 P/6x32tRYFWC6pSWTf6UTybtrSyACqcHw5IJwLcaRX+5u942ga/yUBbadshCKo2V1Izf
 5K7F4RY7LXXiSv9T66hlWLoIMBfycUdWoCIUy34RhPJQTQ6ieRvwKrH8OMwpk+tooEdA
 QKXkX6GkLxVao9DZdH/B31XB6UQU92X6d/XjRAuquNg37m8Gl6/vV/r/eInVyA1xJ7iI
 YgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742986625; x=1743591425;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VwyiHCaJrQ4Q9LMvwEc9EK8HZFr2eRGGkOP5KB/fbvg=;
 b=Iaj4azalH9Yq/alfL2km6fWW1WpkHcdmP0CWI6fxOkoFeZfztpoBp2JrIEk9AEJGrI
 q/IPHJEWJpWM3C6IRk9l/adnJgrY2oLor65NJFRMpE3UU0y6FabshUBRIz1/9wqJJWNw
 J5eivNrv9mxBZU3gg6Tozo8DWOLTkdhFOs0mUV2Sub+ueFL8/2gZdceQr5Gz/MC47CIR
 J+wVAgM5NYU9+ARFThsefByiER531x7EDxkNiWKSPOZyAfzAqZjyTwcRGSf/wS17Z18F
 gLLlkT26iDUf5ho/RTsCj8By6hPxXfehOA2gwil3GntRIgG9+Lb7yoFW+E1JylsUO0E5
 ATRA==
X-Gm-Message-State: AOJu0YykB6R7RRQZPPRcYEG3E9O8I9tYdvY+61X088GZLhBhTjfw10Fm
 lQoUvsy9cpsx31N8wFpXOuGy5GVOhIfJqMli5WmzbBjQXpdk9JQlY0wOvcc23mJP+nmfivZopIa
 S65QaIKgDd5a3Yw27pzOi1DZD7C4=
X-Gm-Gg: ASbGncusk+9uRo9ON634/57ra7azxev9ySZuDgcKIv4P9Wxmp0qJP94vlNzMgrYbIcq
 +yG48FHDCuwksvNTELdKY5O1oSzrggPpuZBR2VXHmsE1kHn+Sn6PYXVuC6UQn8xZuCCH+zQ4ZRu
 C8ZLHlTQ4RyZ7PXVvNmVkimM2DBG7F/K61P7SVuEN+Suy4rBgvgd9rXPKo0PE=
X-Google-Smtp-Source: AGHT+IH3OiTJi1LcmHR+oZzWBb0Hc+pXgNdAYKrzBmDLc6/yBqf6BfTRx3VEgkIO6kU8outTB9mwTEaDnixuULLWnpw=
X-Received: by 2002:a05:622a:2615:b0:476:9763:2fd3 with SMTP id
 d75a77b69052e-4775f313c5emr51624721cf.14.1742986624687; Wed, 26 Mar 2025
 03:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250326093418.397269-1-yuq825@gmail.com>
 <20250326093418.397269-3-yuq825@gmail.com>
In-Reply-To: <20250326093418.397269-3-yuq825@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 26 Mar 2025 14:56:50 +0400
X-Gm-Features: AQ5f1JphaNy3NRmDQGLwi9M0a-H_9e69fHTfY698VcTRqIExElzj-YT6tBrqL0I
Message-ID: <CAJ+F1CJEMpdgKtTvNdp-iHA4ghb29GFfT91VaTJ3KSv1iy+qzA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] ui/egl: require
 EGL_EXT_image_dma_buf_import_modifiers
To: yuq825@gmail.com
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
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

On Wed, Mar 26, 2025 at 1:34=E2=80=AFPM <yuq825@gmail.com> wrote:
>
> From: Qiang Yu <yuq825@gmail.com>
>
> It's used already, just check it explicitly.
>
> Signed-off-by: Qiang Yu <yuq825@gmail.com>
> ---
>  ui/egl-helpers.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
> index d194d004b7..432863d702 100644
> --- a/ui/egl-helpers.c
> +++ b/ui/egl-helpers.c
> @@ -257,6 +257,11 @@ int egl_rendernode_init(const char *rendernode, Disp=
layGLMode mode)
>          error_report("egl: EGL_MESA_image_dma_buf_export not supported")=
;
>          goto err;
>      }
> +    if (!epoxy_has_egl_extension(qemu_egl_display,
> +                                 "EGL_EXT_image_dma_buf_import_modifiers=
")) {
> +        error_report("egl: EGL_EXT_image_dma_buf_import_modifiers not su=
pported");
> +        goto err;
> +    }
>
>      qemu_egl_rn_ctx =3D qemu_egl_init_ctx();
>      if (!qemu_egl_rn_ctx) {
> @@ -308,7 +313,7 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf)
>      EGLImageKHR image =3D EGL_NO_IMAGE_KHR;
>      EGLint attrs[64];
>      int i =3D 0;
> -    uint64_t modifier;
> +    uint64_t modifier =3D qemu_dmabuf_get_modifier(dmabuf);
>      uint32_t texture =3D qemu_dmabuf_get_texture(dmabuf);
>
>      if (texture !=3D 0) {
> @@ -328,15 +333,12 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf)
>      attrs[i++] =3D qemu_dmabuf_get_strides(dmabuf, NULL)[0];
>      attrs[i++] =3D EGL_DMA_BUF_PLANE0_OFFSET_EXT;
>      attrs[i++] =3D 0;
> -#ifdef EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT

Maybe we should have in meson.build:
  if gbm.found()
    cc.has_header_symbol('epoxy/egl.h',
'EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT', dependencies: opengl, required:
true)
  endif


anyway,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> -    modifier =3D qemu_dmabuf_get_modifier(dmabuf);
>      if (modifier) {
>          attrs[i++] =3D EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT;
>          attrs[i++] =3D (modifier >>  0) & 0xffffffff;
>          attrs[i++] =3D EGL_DMA_BUF_PLANE0_MODIFIER_HI_EXT;
>          attrs[i++] =3D (modifier >> 32) & 0xffffffff;
>      }
> -#endif
>      attrs[i++] =3D EGL_NONE;
>
>      image =3D eglCreateImageKHR(qemu_egl_display,
> --
> 2.43.0
>


--=20
Marc-Andr=C3=A9 Lureau

