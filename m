Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B54C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 10:10:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twekt-0000ML-KL; Mon, 24 Mar 2025 06:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1tweks-0000M9-4z
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:10:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1twekp-0005QG-22
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742810997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7MXG48POaE2HhRYyJdhbvKKICJsFU5Ity7F7zf/mjPg=;
 b=TrcmOIfgFOQRtFpEJup5e+kshEfliyHBAN5uYCjGvVwlnb/axq2hiJTG0yyqtjo6XYXgcV
 iHXB4uBgcN9NyJoQz1zBq1fCNEAHyk1JE5FDbuuWHaA7YxnyBI8BYnrjYCHwDyTn8Bb2Io
 36F3jnQhGbgW2Rh/prsMqMFApEHgq9o=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-qCfJmc_VPySHkNVL0Gpm6Q-1; Mon, 24 Mar 2025 06:09:53 -0400
X-MC-Unique: qCfJmc_VPySHkNVL0Gpm6Q-1
X-Mimecast-MFC-AGG-ID: qCfJmc_VPySHkNVL0Gpm6Q_1742810993
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c3c8f8ab79so596166485a.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 03:09:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742810993; x=1743415793;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7MXG48POaE2HhRYyJdhbvKKICJsFU5Ity7F7zf/mjPg=;
 b=L5Ha+Dbo5h/DYPru+s1aCVm7Q73ipudP8zJAp1+r5ye629yJ3oxeydgQXq8m53c3F+
 UG79EGCKZowlTzbZ+fp1HnhMo7cnCA8Sh7LGuNvy6UNnwP4M8Wp6S4al67awTvlGub2s
 A8zZhq1pg3I88XVhUbnN/9JFl4U9GvDJARdhZ9BMQ/FnvazfUVbGiMcIWht6Qz+fxT2o
 LMWj4FM1yMKA11tLifjqbZxreQVo8dymwOfjDeunxSpTmjVQXQR43gY4k0MbNgKA4p5C
 4jZOBt3555bRCGI8enZqtS2vrKUf8x6wEnyqvUMZpxsCY2dH2nSrKKghL5Wpxwjfh5Ll
 BqTg==
X-Gm-Message-State: AOJu0YxzTMd/HDGyoLi3MTg29LOOrtEcue0Htfzn2qld7MaMUomnAqhQ
 tM013R9+r32OK8Mv4QaJMalsuDUbgUpPehZQxgbcDdXW05xhAt2CbE7xFBmhpBQooesRxfFz61A
 kSBxVbXRZgiqoJG1YJIYj56WpOlMgQnSP8XxoYZC6w6qjhMkN3P7ndlGy5p6TlKTlQ7r+YQxxbZ
 57kqYHdJnwDcxfkhrYZBtn2zeSS323MZp3onDqgg==
X-Gm-Gg: ASbGncvXbx2xczRPhQQJkekCkL3CnaaRyf0vNPehyKCVAVC65sAr6bUGvijMqrXhDyI
 SS0DD4dN7XEVAfUOQc0g91T3DU7mdaP850T+JdlvYGLDB2p2Z3eW/JN+wwjgnSR3ov0IBOnBxQo
 H9dWztT1UAWg/RoES39CHiGexN80itDg==
X-Received: by 2002:a05:620a:284c:b0:7c3:cd78:df43 with SMTP id
 af79cd13be357-7c5ba2058b8mr1870810285a.58.1742810992792; 
 Mon, 24 Mar 2025 03:09:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ+MPzwavpc6LHCOScO7XXhYjNX5dKtZFjHjvEyA1BrgIeUi3K5UY/3q/uec8lYQaxfGjFOI1mrVkNXvYsxB8=
X-Received: by 2002:a05:620a:284c:b0:7c3:cd78:df43 with SMTP id
 af79cd13be357-7c5ba2058b8mr1870807285a.58.1742810992385; Mon, 24 Mar 2025
 03:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250324081922.359369-1-yuq825@gmail.com>
 <20250324081922.359369-3-yuq825@gmail.com>
In-Reply-To: <20250324081922.359369-3-yuq825@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 24 Mar 2025 14:09:40 +0400
X-Gm-Features: AQ5f1JpAh2TPSS-qgzNkcXGfeCkniidjRyEIcSQhAptSMI1khMTlF7y3njyQDRA
Message-ID: <CAMxuvazW2TEFm-6GMZiNO25JuSKxAupa2N=fPR9n_6ibTadCHg@mail.gmail.com>
Subject: Re: [PATCH 2/6] ui/egl: require EGL_EXT_image_dma_buf_import_modifiers
To: yuq825@gmail.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi

On Mon, Mar 24, 2025 at 12:19=E2=80=AFPM <yuq825@gmail.com> wrote:
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
> index 72a1405782..45b1b0b700 100644
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
>      attrs[i++] =3D qemu_dmabuf_get_stride(dmabuf)[0];
>      attrs[i++] =3D EGL_DMA_BUF_PLANE0_OFFSET_EXT;
>      attrs[i++] =3D 0;
> -#ifdef EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT

We should check for that define during meson.build when gbm.found(),
to avoid potential later build errors.

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


