Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C277CC2A060
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Jan 2026 22:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcAXL-0003Yq-P9; Sat, 03 Jan 2026 17:55:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.gpwo1uyu3wozmq1=w3wyb7l2b50z=adc5ird6nuu8qn@em483429.getutm.app>)
 id 1vcAXJ-0003Y4-TW
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 17:55:53 -0500
Received: from a4i726.smtp2go.com ([158.120.82.214])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.gpwo1uyu3wozmq1=w3wyb7l2b50z=adc5ird6nuu8qn@em483429.getutm.app>)
 id 1vcAXI-0005e8-27
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 17:55:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1767480937; h=from : subject :
 to : message-id : date;
 bh=PSBE8UnMi8iSLJVRxqW3DM+YCUZ9Rp8vxd9aOZ4b1Dc=;
 b=Y2a+lMKVsohGwdX3rUrq+hjemNiSGOeJyWt6V0fxAtvVBy1rh9MiTLPrBqts0WKNN7Kvk
 tRpCmAnj/+6MkFkAEP9HPsTNP0KZlXz57rCFkZn6JCexOD7aDmk3ypf8YYm4RM2kGAnWyt7
 +w4m2vADaldliOTX+Hr1ilaIafAa2x2bS1upOX4x7w845YKZX2EWbqqV+rK6CNzD5lDyMHi
 68P9IwnvuumfVaKXb3ryzq2Rv27c789F2UD0XiuykHoX+fnXVOv/W1OlejaqMkmpTQXYcb4
 7Pvd2jI3lz/4GQ63yEJ8rlN7bj4HCKQgT92hD2MFlExZNhAL1iN0qGh3qGHA==
Received: from [10.159.238.187] (helo=mail-ej1-f44.google.com)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
 (Exim 4.98.1-S2G) (envelope-from <j@getutm.app>)
 id 1vcAX1-FnQW0hQ0kNL-H3tV for qemu-devel@nongnu.org;
 Sat, 03 Jan 2026 22:55:35 +0000
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-b72b495aa81so2177919966b.2
 for <qemu-devel@nongnu.org>; Sat, 03 Jan 2026 14:55:34 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUBvQQWOJicmsO5mKmcB4kESq0Ax+u4w/FUbel4e+j5Inye8pVt5v0cm+zEiK1rcvVQVo9tul36hdFz@nongnu.org
X-Gm-Message-State: AOJu0YwiNsScAtY1rs1B9atNjwf2/02G6zcom/WwQFTbLQx0xgWhxQP5
 rGRZ1EdBplCRHArPi5iiKLiUpr2qKkFjpzsoPxC1aMJbAhEFYcSE0j9vCDa3NOfFy99FKk+phic
 YXeT7Np+ZqzOhz4S4IAG0yCXGKBDh+is=
X-Google-Smtp-Source: AGHT+IF+wy9V0GPjAZgseoYPt24v1rJ+69qfoHNOFI030mwnjZH7VOxdhvpRf5fiHZBKXwKhCBHDSc7f2Hgox5f8exw=
X-Received: by 2002:a17:907:3e18:b0:b79:ff8c:d9a6 with SMTP id
 a640c23a62f3a-b80371d69f4mr4887720966b.33.1767480934221; Sat, 03 Jan 2026
 14:55:34 -0800 (PST)
MIME-Version: 1.0
References: <20251219183853.4426-1-j@getutm.app>
 <20251219183853.4426-5-j@getutm.app>
 <3164e33e-b6d7-4002-8a99-7b0319cffbab@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <3164e33e-b6d7-4002-8a99-7b0319cffbab@rsg.ci.i.u-tokyo.ac.jp>
From: Joelle van Dyne <j@getutm.app>
Date: Sat, 3 Jan 2026 14:55:23 -0800
X-Gmail-Original-Message-ID: <CA+E+eSCs9JdUD687Nbt5tzfTDaT278hkgAu_GO=h5CgNy=v+hg@mail.gmail.com>
X-Gm-Features: AQt7F2p6loM_HlX_fbZ4syi-6cii1foxN9UOCRBTR18PO5XsCmuSPk9wdqcOyRg
Message-ID: <CA+E+eSCs9JdUD687Nbt5tzfTDaT278hkgAu_GO=h5CgNy=v+hg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 4/6] virtio-gpu-virgl: support scanout of Metal
 textures
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 483429m:483429abrvJvs:483429sjI5yfcioD
X-smtpcorp-track: C5xQkDMSbE9K.TpT23Ak2BHYR.Xy0VOgBt58S
Received-SPF: pass client-ip=158.120.82.214;
 envelope-from=bounce.gpwo1uyu3wozmq1=w3wyb7l2b50z=adc5ird6nuu8qn@em483429.getutm.app;
 helo=a4i726.smtp2go.com
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

On Tue, Dec 23, 2025 at 11:21=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2025/12/20 3:38, Joelle van Dyne wrote:
> > When supported, virglrenderer will return a MTLTexture handle that can =
be
> > directly used for scanout.
> >
> > Signed-off-by: Joelle van Dyne <j@getutm.app>
> > ---
> >   meson.build                   |  4 ++++
> >   include/ui/console.h          |  2 ++
> >   hw/display/virtio-gpu-virgl.c | 12 +++++++++++-
> >   hw/display/virtio-gpu.c       | 10 ++++++++--
> >   4 files changed, 25 insertions(+), 3 deletions(-)
> >
> > diff --git a/meson.build b/meson.build
> > index d9293294d8e..05bad663764 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -832,6 +832,7 @@ version_res =3D []
> >   coref =3D []
> >   iokit =3D []
> >   pvg =3D not_found
> > +metal =3D not_found
> >   emulator_link_args =3D []
> >   midl =3D not_found
> >   widl =3D not_found
> > @@ -859,6 +860,7 @@ elif host_os =3D=3D 'darwin'
> >     host_dsosuf =3D '.dylib'
> >     pvg =3D dependency('appleframeworks', modules: ['ParavirtualizedGra=
phics', 'Metal'],
> >                      required: get_option('pvg'))
> > +  metal =3D dependency('appleframeworks', modules: 'Metal', required: =
false)
> >   elif host_os =3D=3D 'sunos'
> >     socket =3D [cc.find_library('socket'),
> >               cc.find_library('nsl'),
> > @@ -2591,6 +2593,7 @@ if xen.found()
> >       ('0' + xen_version[2]).substring(-2)
> >     config_host_data.set('CONFIG_XEN_CTRL_INTERFACE_VERSION', xen_ctrl_=
version)
> >   endif
> > +config_host_data.set('CONFIG_METAL', metal.found())
>
> This is unnecessary; CONFIG_DARWIN is sufficient.
>
> >   config_host_data.set('QEMU_VERSION', '"@0@"'.format(meson.project_ver=
sion()))
> >   config_host_data.set('QEMU_VERSION_MAJOR', meson.project_version().sp=
lit('.')[0])
> >   config_host_data.set('QEMU_VERSION_MINOR', meson.project_version().sp=
lit('.')[1])
> > @@ -4874,6 +4877,7 @@ summary(summary_info, bool_yn: true, section: 'Cr=
ypto')
> >   summary_info =3D {}
> >   if host_os =3D=3D 'darwin'
> >     summary_info +=3D {'Cocoa support':           cocoa}
> > +  summary_info +=3D {'Metal support':           metal}
>
> This printing is extraneous. All versions of Darwin QEMU supports have
> Metal.
>
> >   endif
> >   summary_info +=3D {'D-Bus display':     dbus_display}
> >   summary_info +=3D {'SDL support':       sdl}
> > diff --git a/include/ui/console.h b/include/ui/console.h
> > index 25e45295d44..a45b524c575 100644
> > --- a/include/ui/console.h
> > +++ b/include/ui/console.h
> > @@ -134,12 +134,14 @@ struct QemuConsoleClass {
> >   typedef enum ScanoutTextureNativeType {
> >       SCANOUT_TEXTURE_NATIVE_TYPE_NONE,
> >       SCANOUT_TEXTURE_NATIVE_TYPE_D3D,
> > +    SCANOUT_TEXTURE_NATIVE_TYPE_METAL,
> >   } ScanoutTextureNativeType;
> >
> >   typedef struct ScanoutTextureNative {
> >       ScanoutTextureNativeType type;
> >       union {
> >           void *d3d_tex2d;
> > +        void *metal_texture;
> >       } u;
> >   } ScanoutTextureNative;
> >
> > diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virg=
l.c
> > index 9fcc01b6f46..b3e83046643 100644
> > --- a/hw/display/virtio-gpu-virgl.c
> > +++ b/hw/display/virtio-gpu-virgl.c
> > @@ -438,6 +438,13 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
> >   #if VIRGL_RENDERER_RESOURCE_INFO_EXT_VERSION >=3D NATIVE_HANDLE_SUPPO=
RT_VERSION
> >           if (ext.version >=3D VIRGL_RENDERER_RESOURCE_INFO_EXT_VERSION=
) {
> >               switch (ext.native_type) {
> > +#ifdef CONFIG_METAL
> > +            case VIRGL_NATIVE_HANDLE_METAL_TEXTURE: {
> > +                native.type =3D SCANOUT_TEXTURE_NATIVE_TYPE_METAL;
> > +                native.u.metal_texture =3D ext.native_handle;
> > +                break;
> > +            }
> > +#endif
> >               case VIRGL_NATIVE_HANDLE_NONE:
> >               case VIRGL_NATIVE_HANDLE_D3D_TEX2D: {
> >                   /* already handled above */
> > @@ -1184,7 +1191,10 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
> >       }
> >   #if VIRGL_VERSION_MAJOR >=3D 1
> >       if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
> > -        flags |=3D VIRGL_RENDERER_VENUS | VIRGL_RENDERER_RENDER_SERVER=
;
> > +        flags |=3D VIRGL_RENDERER_VENUS;
> > +#ifndef CONFIG_METAL /* Metal does not support render server */
> > +        flags |=3D VIRGL_RENDERER_RENDER_SERVER;
> > +#endif
> >       }
> >   #endif
> >
> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > index 43e88a4daff..38010c0fcc2 100644
> > --- a/hw/display/virtio-gpu.c
> > +++ b/hw/display/virtio-gpu.c
> > @@ -1483,12 +1483,18 @@ void virtio_gpu_device_realize(DeviceState *qde=
v, Error **errp)
> >   {
> >       VirtIODevice *vdev =3D VIRTIO_DEVICE(qdev);
> >       VirtIOGPU *g =3D VIRTIO_GPU(qdev);
> > +    bool have_ext_memory;
> >
> >       if (virtio_gpu_blob_enabled(g->parent_obj.conf)) {
> > +#ifdef CONFIG_METAL
> > +        have_ext_memory =3D true;
> > +#else
> > +        have_ext_memory =3D virtio_gpu_have_udmabuf();
> > +#endif
> >           if (!virtio_gpu_rutabaga_enabled(g->parent_obj.conf) &&
> >               !virtio_gpu_virgl_enabled(g->parent_obj.conf) &&
> > -            !virtio_gpu_have_udmabuf()) {
> > -            error_setg(errp, "need rutabaga or udmabuf for blob resour=
ces");
> > +            !have_ext_memory) {
> > +            error_setg(errp, "need rutabaga or ext memory for blob res=
ources");
>
> This change is extraneous. It allows creating blob resources with
> virtio-gpu (not virtio-gpu-gl) on macOS, which shouldn't happen.
virtio_gpu_gl_device_realize() calls virtio_gpu_device_realize() at
the end so it will have to pass this check. Would this be better?

#ifdef CONFIG_METAL
have_ext_memory =3D virtio_gpu_venus_enabled(g->parent_obj.conf);
#else
have_ext_memory =3D virtio_gpu_have_udmabuf();
#endif

>
> Regards,
> Akihiko Odaki

