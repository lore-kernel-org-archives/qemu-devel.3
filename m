Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51011CFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 11:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxmD5-0005Hh-2P; Mon, 07 Oct 2024 07:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sxmCz-0005Gk-6N
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:47:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sxmCx-0004at-HP
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728301642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uTNKHSBeE16BG+Rg+MBcBkvebP1koDw5n8zsVRQxr7A=;
 b=aj+KE2QIb2OG8pZexlqxDwtVWG1NXy20spaQKujv5qQV2JZ+omZQVvBGLOfj230VAR4SOi
 Lil1anDc2ye3Ku5XjMo4GDezcZTsNSzZbRNjk7vdhqEjOg+Nz7QP8d/UGqDf5MyBSt67Jb
 pg+la/dVNMGM0htjmDz9QWiPjtGbVrQ=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-WRon3JMKNgGstuRBp8wCRw-1; Mon, 07 Oct 2024 07:47:21 -0400
X-MC-Unique: WRon3JMKNgGstuRBp8wCRw-1
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-4a3a80afe99so1218190137.2
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 04:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728301641; x=1728906441;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uTNKHSBeE16BG+Rg+MBcBkvebP1koDw5n8zsVRQxr7A=;
 b=eygc2S2tjrq/jbpyw4cXKjtYYbXtFqelewxbRzoQT/sAij2HFosHqYeqrjDmoamn8X
 gTPJhEP42/hoJ0ulJzIyyPdPgd9HLXE+t+rGWqFDpCo0hEjsmsmv1Rlt59P8s27DYGwa
 IahWNbUDDlWjVTY1jZLvS72e/DgXOVmg4diPDqxW2FS/rebwcKwcpF/PwXahsl2sYv0w
 2EHhk58FbevEHImAe6hrSLSxEK+hn1JCIvvgR/7uthSkYGVTyHf4MoLkKacgflDYiggy
 5XmRfY571FZg/EpIE1vOuTvYywr8wJVJkEXwauSBIDy43lvsWCX2/R1QxnmImc431/qS
 sFlw==
X-Gm-Message-State: AOJu0Ywyer6VCTVVCxDscZlnV+wiUexmOw4Nwl24R0kyiMRNn8gkLoFY
 aaFy2rFuKJlUi1eY9BBo5GPPTCUVtrrRCsOpHVlTnm6Lga71L65lBHF2yOe4n7FOsudz4XjmQK3
 HLgKVKAHEjRtmOs7pwBcXyX8aHfkjyU0iNPnsvqW34OydqVnHq5K11eLmWaofI5QQ4Jtvzn7h2j
 Y7+6mbh81APUMAfECS5vOk2XifXd0=
X-Received: by 2002:a05:6102:509f:b0:4a3:c3cf:42b1 with SMTP id
 ada2fe7eead31-4a4058efbd0mr5611912137.26.1728301640691; 
 Mon, 07 Oct 2024 04:47:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFVpv2mYnYzdpMWQbIW6kKw/5DHAVZ9t5wTsUjvEHJDEKV2aGQr2wax97mCabQujxZIB9w1XxB3I/p/05uMps=
X-Received: by 2002:a05:6102:509f:b0:4a3:c3cf:42b1 with SMTP id
 ada2fe7eead31-4a4058efbd0mr5611888137.26.1728301640312; Mon, 07 Oct 2024
 04:47:20 -0700 (PDT)
MIME-Version: 1.0
References: <20241003112244.3340697-1-marcandre.lureau@redhat.com>
 <20241003112244.3340697-13-marcandre.lureau@redhat.com>
 <24a91b5d-89a3-4338-874c-78aaf22b93ac@daynix.com>
In-Reply-To: <24a91b5d-89a3-4338-874c-78aaf22b93ac@daynix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 7 Oct 2024 15:47:08 +0400
Message-ID: <CAMxuvay2B_hwZ4eyqp_cRGe5XH1wWkHbVPDEOgBjScKAE7uosA@mail.gmail.com>
Subject: Re: [PATCH 12/16] ui/surface: allocate shared memory on !win32
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

On Sat, Oct 5, 2024 at 12:59=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2024/10/03 20:22, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Use qemu_memfd_alloc() to allocate the display surface memory, which
> > will fallback on tmpfile/mmap() on systems without memfd, and allow to
> > share the display with other processes.
> >
> > This is similar to how display memory is allocated on win32 since commi=
t
> > 09b4c198 ("console/win32: allocate shareable display surface").
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   include/ui/surface.h |  8 ++++++++
> >   ui/console.c         | 30 ++++++++++++++++++++++++++++--
> >   2 files changed, 36 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/ui/surface.h b/include/ui/surface.h
> > index 345b19169d..dacf12ffe2 100644
> > --- a/include/ui/surface.h
> > +++ b/include/ui/surface.h
> > @@ -23,6 +23,10 @@ typedef struct DisplaySurface {
> >       GLenum gltype;
> >       GLuint texture;
> >   #endif
> > +#ifndef WIN32
> > +    int shmfd;
> > +    uint32_t shmfd_offset;
> > +#endif
> >   #ifdef WIN32
> >       HANDLE handle;
>
> What about defining a new struct that contains either of shmfd or
> handle? We can then have a unified set of functions that uses the struct
> to allocate/free a shared pixman image and to set one to DisplaySurface.

Well, that structure is pretty much DisplaySurface. I am not sure if
it's valuable to introduce another abstraction.

>
> >       uint32_t handle_offset;
> > @@ -37,6 +41,10 @@ DisplaySurface *qemu_create_displaysurface_from(int =
width, int height,
> >   DisplaySurface *qemu_create_displaysurface_pixman(pixman_image_t *ima=
ge);
> >   DisplaySurface *qemu_create_placeholder_surface(int w, int h,
> >                                                   const char *msg);
> > +#ifndef WIN32
> > +void qemu_displaysurface_set_shmfd(DisplaySurface *surface,
> > +                                   int shmfd, uint32_t offset);
> > +#endif
> >   #ifdef WIN32
> >   void qemu_displaysurface_win32_set_handle(DisplaySurface *surface,
> >                                             HANDLE h, uint32_t offset);
> > diff --git a/ui/console.c b/ui/console.c
> > index fdd76c2be4..56f2462c3d 100644
> > --- a/ui/console.c
> > +++ b/ui/console.c
> > @@ -37,6 +37,7 @@
> >   #include "trace.h"
> >   #include "exec/memory.h"
> >   #include "qom/object.h"
> > +#include "qemu/memfd.h"
> >
> >   #include "console-priv.h"
> >
> > @@ -452,6 +453,17 @@ qemu_graphic_console_init(Object *obj)
> >   {
> >   }
> >
> > +#ifndef WIN32
> > +void qemu_displaysurface_set_shmfd(DisplaySurface *surface,
> > +                                   int shmfd, uint32_t offset)
> > +{
> > +    assert(surface->shmfd =3D=3D -1);
> > +
> > +    surface->shmfd =3D shmfd;
> > +    surface->shmfd_offset =3D offset;
> > +}
> > +#endif
> > +
> >   #ifdef WIN32
> >   void qemu_displaysurface_win32_set_handle(DisplaySurface *surface,
> >                                             HANDLE h, uint32_t offset)
> > @@ -469,12 +481,16 @@ DisplaySurface *qemu_create_displaysurface(int wi=
dth, int height)
> >       void *bits =3D NULL;
> >   #ifdef WIN32
> >       HANDLE handle =3D NULL;
> > +#else
> > +    int shmfd =3D -1;
> >   #endif
> >
> >       trace_displaysurface_create(width, height);
> >
> >   #ifdef WIN32
> >       bits =3D qemu_win32_map_alloc(width * height * 4, &handle, &error=
_abort);
> > +#else
> > +    bits =3D qemu_memfd_alloc("displaysurface", width * height * 4, 0,=
 &shmfd, &error_abort);
> >   #endif
> >
> >       surface =3D qemu_create_displaysurface_from(
> > @@ -486,9 +502,13 @@ DisplaySurface *qemu_create_displaysurface(int wid=
th, int height)
> >
> >   #ifdef WIN32
> >       qemu_displaysurface_win32_set_handle(surface, handle, 0);
> > -    pixman_image_set_destroy_function(surface->image,
> > -                                      qemu_pixman_shared_image_destroy=
, handle);
> > +    void *data =3D handle;
> > +#else
> > +    qemu_displaysurface_set_shmfd(surface, shmfd, 0);
> > +    void *data =3D GINT_TO_POINTER(shmfd);
> >   #endif
> > +    pixman_image_set_destroy_function(surface->image, qemu_pixman_shar=
ed_image_destroy, data);
> > +
> >       return surface;
> >   }
> >
> > @@ -499,6 +519,9 @@ DisplaySurface *qemu_create_displaysurface_from(int=
 width, int height,
> >       DisplaySurface *surface =3D g_new0(DisplaySurface, 1);
> >
> >       trace_displaysurface_create_from(surface, width, height, format);
> > +#ifndef WIN32
> > +    surface->shmfd =3D -1;
> > +#endif
> >       surface->image =3D pixman_image_create_bits(format,
> >                                                 width, height,
> >                                                 (void *)data, linesize)=
;
> > @@ -512,6 +535,9 @@ DisplaySurface *qemu_create_displaysurface_pixman(p=
ixman_image_t *image)
> >       DisplaySurface *surface =3D g_new0(DisplaySurface, 1);
> >
> >       trace_displaysurface_create_pixman(surface);
> > +#ifndef WIN32
> > +    surface->shmfd =3D -1;
> > +#endif
> >       surface->image =3D pixman_image_ref(image);
> >
> >       return surface;
>


