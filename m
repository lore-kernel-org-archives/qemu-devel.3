Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D47CFB440
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 11:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxlgG-0004OU-3x; Mon, 07 Oct 2024 07:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sxlgC-0004OG-Sd
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:13:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sxlgB-0007qK-4F
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728299610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N39HMJKUuubVnSpToBC43TWYRWU8uMjoeLchpJ32A9k=;
 b=hb0zuLkb175e8IdsZPTiW7+LoJB2AkWDgvxyT1z6YcYlDtEUpVvIJrLBDWDcNROgmrq2xt
 ges6ku0UOGbOcHi3/eNaaWc1O3M5Hv56e+DrZ6c2x4miQXjCZRjISFkrDWWHS3iJVTXD0n
 bDeh+Uc+YgeGmIQ+b5iTGzbjajxNdUo=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-RlGhCry5P4KeQlUC-0vjOQ-1; Mon, 07 Oct 2024 07:13:29 -0400
X-MC-Unique: RlGhCry5P4KeQlUC-0vjOQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6cb317cd72eso96742066d6.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 04:13:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728299609; x=1728904409;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N39HMJKUuubVnSpToBC43TWYRWU8uMjoeLchpJ32A9k=;
 b=eZq8tmIYkXPv0REkpyOUBf1cOjmp/ruWRp1lMu6RauXh3dOBH3YoDn7we+huHHaIsG
 VuoE3cDJ2rC8OYR+hewtCSiclihyUYwnFZezXKCtOIMfASZV31HYqeJ2NlMpqCp0dsEl
 s5G2n+e4vOno/0g88XkxAqeljIG6fG6qpDWfJe/MqBXqM5kcMqQDRFm9HM1W3gddroiS
 qaMvrIdC9+xKI/8WaBOBtMvXZxNpZH53ZxU6yP/cSR5uRL5Y8K/SNZ/v5Nfse08Zx2X+
 IdYs5T1nx1a996flsq5ckSUxv+on9e71oWU/4oPaoMjeasfvxwGqUdvVaTa1/oYEbyE9
 IAzw==
X-Gm-Message-State: AOJu0YxRKcWRYbTpFY7ubCsFAEI3ieQpiwHD6qCXcPDNMazp5kmHqYKQ
 6zFS1wmI9vb2O/VEn9MchQEwUK1lXtIbgm6qQocYQzJ44ATpbdpoJ6OumYDMF/XEFdulCEfbsfR
 Wtd3BU4Uza5ZlmRgndwboYEDToufibGTggCvoB+KIE/9oC35FVRtyxQrrA0DyH0DkPhkvg9Ai6m
 YUCCMPew7cqX/2g9HRJEHg+stbMv0=
X-Received: by 2002:a05:6214:5890:b0:6cb:60c8:b698 with SMTP id
 6a1803df08f44-6cb9a30922bmr171037356d6.19.1728299608817; 
 Mon, 07 Oct 2024 04:13:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPWm8CoeB+aGA0AWKvBfnLnASGupErTEQ5Jha2auxzLGberMAN+Eja8RKT9fNXRgsnm2gWYujDfybF1TRT88s=
X-Received: by 2002:a05:6214:5890:b0:6cb:60c8:b698 with SMTP id
 6a1803df08f44-6cb9a30922bmr171036946d6.19.1728299608459; Mon, 07 Oct 2024
 04:13:28 -0700 (PDT)
MIME-Version: 1.0
References: <20241003112244.3340697-1-marcandre.lureau@redhat.com>
 <20241003112244.3340697-10-marcandre.lureau@redhat.com>
 <e02d28c2-d192-49d9-9f83-d45204e63642@daynix.com>
In-Reply-To: <e02d28c2-d192-49d9-9f83-d45204e63642@daynix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 7 Oct 2024 15:13:17 +0400
Message-ID: <CAMxuvawRGtZqZmXAS+KOQr61UJc1vDPjRKcmmAg_MKpDWZAU7w@mail.gmail.com>
Subject: Re: [PATCH 09/16] ui/pixman: generalize shared_image_destroy
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 belmouss@redhat.com, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Sat, Oct 5, 2024 at 12:50=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2024/10/03 20:22, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Learn to free memfd-allocated shared memory.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   include/ui/qemu-pixman.h |  2 +-
> >   hw/display/virtio-gpu.c  |  4 ++--
> >   ui/console.c             |  2 +-
> >   ui/qemu-pixman.c         | 20 ++++++++++++--------
> >   4 files changed, 16 insertions(+), 12 deletions(-)
> >
> > diff --git a/include/ui/qemu-pixman.h b/include/ui/qemu-pixman.h
> > index e3dd72b9e3..a97f56d09a 100644
> > --- a/include/ui/qemu-pixman.h
> > +++ b/include/ui/qemu-pixman.h
> > @@ -97,7 +97,7 @@ void qemu_pixman_glyph_render(pixman_image_t *glyph,
> >
> >   void qemu_pixman_image_unref(pixman_image_t *image);
> >
> > -void qemu_pixman_win32_image_destroy(pixman_image_t *image, void *data=
);
> > +void qemu_pixman_shared_image_destroy(pixman_image_t *image, void *dat=
a);
> >
> >   G_DEFINE_AUTOPTR_CLEANUP_FUNC(pixman_image_t, qemu_pixman_image_unref=
)
> >
> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > index 017a0f170c..77f6e76f23 100644
> > --- a/hw/display/virtio-gpu.c
> > +++ b/hw/display/virtio-gpu.c
> > @@ -298,7 +298,7 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU=
 *g,
> >               bits, c2d.height ? res->hostmem / c2d.height : 0);
> >   #ifdef WIN32
> >           if (res->image) {
> > -            pixman_image_set_destroy_function(res->image, qemu_pixman_=
win32_image_destroy, res->handle);
> > +            pixman_image_set_destroy_function(res->image, qemu_pixman_=
shared_image_destroy, res->handle);
> >           }
> >   #endif
> >       }
> > @@ -1317,7 +1317,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opa=
que, size_t size,
> >               return -EINVAL;
> >           }
> >   #ifdef WIN32
> > -        pixman_image_set_destroy_function(res->image, qemu_pixman_win3=
2_image_destroy, res->handle);
> > +        pixman_image_set_destroy_function(res->image, qemu_pixman_shar=
ed_image_destroy, res->handle);
> >   #endif
> >
> >           res->addrs =3D g_new(uint64_t, res->iov_cnt);
> > diff --git a/ui/console.c b/ui/console.c
> > index 8f416ff0b9..fdd76c2be4 100644
> > --- a/ui/console.c
> > +++ b/ui/console.c
> > @@ -487,7 +487,7 @@ DisplaySurface *qemu_create_displaysurface(int widt=
h, int height)
> >   #ifdef WIN32
> >       qemu_displaysurface_win32_set_handle(surface, handle, 0);
> >       pixman_image_set_destroy_function(surface->image,
> > -                                      qemu_pixman_win32_image_destroy,=
 handle);
> > +                                      qemu_pixman_shared_image_destroy=
, handle);
> >   #endif
> >       return surface;
> >   }
> > diff --git a/ui/qemu-pixman.c b/ui/qemu-pixman.c
> > index 3870e1a215..43050ab7c5 100644
> > --- a/ui/qemu-pixman.c
> > +++ b/ui/qemu-pixman.c
> > @@ -6,6 +6,7 @@
> >   #include "qemu/osdep.h"
> >   #include "qapi/error.h"
> >   #include "ui/console.h"
> > +#include "qemu/memfd.h"
> >   #include "standard-headers/drm/drm_fourcc.h"
> >   #include "trace.h"
> >
> > @@ -269,16 +270,19 @@ void qemu_pixman_glyph_render(pixman_image_t *gly=
ph,
> >   }
> >   #endif /* CONFIG_PIXMAN */
> >
> > -#ifdef WIN32
> >   void
> > -qemu_pixman_win32_image_destroy(pixman_image_t *image, void *data)
> > +qemu_pixman_shared_image_destroy(pixman_image_t *image, void *data)
> >   {
> > +    void *ptr =3D pixman_image_get_data(image);
> > +
> > +#ifndef WIN32
>
> I think it is better to have #ifdef instead of #ifndef. It is a common
> pattern to have #ifdef and #elif defined() for the platform-specific
> code and follow them with #else that implements the generic code. This
> allows supporting multiple platform conditions.

indeed! thanks

>
> > +    int shmfd =3D GPOINTER_TO_INT(data);
> > +    size_t size =3D pixman_image_get_height(image) * pixman_image_get_=
stride(image);
> > +
> > +    qemu_memfd_free(ptr, size, shmfd);
> > +#else
> >       HANDLE handle =3D data;
> >
> > -    qemu_win32_map_free(
> > -        pixman_image_get_data(image),
> > -        handle,
> > -        &error_warn
> > -    );
> > -}
> > +    qemu_win32_map_free(ptr, handle, &error_warn);
> >   #endif
> > +}
>


