Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D966D7879C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdJT-00010b-J6; Fri, 19 Dec 2025 11:26:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.7seeznroe9afik2=govm03c0ocew=up44ekbbue5gx3@em483429.getutm.app>)
 id 1vWdJN-0000z7-NQ
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:26:39 -0500
Received: from a2i327.smtp2go.com ([103.47.205.71])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.7seeznroe9afik2=govm03c0ocew=up44ekbbue5gx3@em483429.getutm.app>)
 id 1vWdJK-00077c-BB
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:26:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=smtpservice.net; s=mad0l0.a1-4.dyn; x=1766162480; h=Feedback-ID:
 X-Smtpcorp-Track:To:Subject:Message-ID:Date:From:Reply-To:Sender:
 List-Unsubscribe:List-Unsubscribe-Post;
 bh=0iAgP76114TWP1wJsjnkaGa+MOAmMzE8OSgdVnces4c=; b=JdE6ERlrKaFs6p4J9LIRRLcAgW
 n36UQgAz4wsBo+/000Q2C1DzUmlqGEe6Wwiu5smNMRFbds0hte9YnwYazw2a5lvuCb1yjaTS46goW
 Um4mLil2RjEPXf6y5A7E354dIbEOHN9x8R/bbKkV/R2++AUWf0aElAId44PxULgBhHFFIbYT24RAY
 xZ/a2tB2/a0JNnGLL2nrRzYPgfYaQGTaxkiheGCi7tousMO14jQGgQv9p8anzb0f1d7LYx6jdV79d
 r42zerGGeXWrWpozZw4PU8ve6+aBcpQgow9zO8iH/21iH+0X/qAdG0WhAKDgpf9HDstUE9UPCu61B
 Wu66vCcg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1766161580; h=from : subject :
 to : message-id : date;
 bh=0iAgP76114TWP1wJsjnkaGa+MOAmMzE8OSgdVnces4c=;
 b=eCnFGb1hPRveIrcIlvly60lVlbjlWeL5rdstYX8cPVqAbhQ/Em987JVCpWEuwW+HmLU9j
 EqsPVXMDofZdtm6i6YagbKOhz2vR6g3qW68A0b51KsZpRJ16u26BR4ObDR10p9iA1vzODYB
 oiOd1j7y0BC+jG/CQ6f1qtsnhUoD2qPyGVankyKUWCPbgjq8IeiAqryW34Ca9s7OIzf48Cp
 Vnz0m02bxgrbwr3qFM40G9cWlGbFCXo1eDuiy0ywc+p877vipAS6PVcm73VTtECvOO/EXUG
 97xWATnUrERJt138O0BsroM6kb7MKDYBzNQDvbTZ+L7ItM2/Fl6wrLvFcekA==
Received: from [10.45.56.87] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <j@getutm.app>) id 1vWdJ5-pH9PgS-Ar
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 16:26:19 +0000
Received: from [10.159.238.187] (helo=mail-ej1-f49.google.com)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
 (Exim 4.98.1-S2G) (envelope-from <j@getutm.app>)
 id 1vWdJ4-FnQW0hPwths-ekOo for qemu-devel@nongnu.org;
 Fri, 19 Dec 2025 16:26:18 +0000
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-b735487129fso348263566b.0
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:26:17 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVSD7BdhDuoC5nJFj4z5VfxRQtjsCVvhd7CvgX9JC7Y5Ce5/ZibeDZKPxExroJqHtgoF2MOfji0EGJe@nongnu.org
X-Gm-Message-State: AOJu0YxDsvntwmkunH4OPxqhN1VCFs/X00+x+VJAtjtDgiPe5QIOktfU
 gfreEwMELwSqj97Li6O/MmIE0gO47wMvruj8XNtU0tHv8nxiz0+tfvTqSgYNH/7N0MuDfCGusQy
 S/U0gbs4/opLbAAMHXIzJoRf9LsJuYkI=
X-Google-Smtp-Source: AGHT+IF3JZWo3RE4eNBFaW1jH0SR0xI87x9xN+DugaAPcss7oXjS3RDOzopRJMn9oj3LyBgBiGBqZcnIPqg5n+tkMd8=
X-Received: by 2002:a17:906:eecb:b0:b80:b7f:aa27 with SMTP id
 a640c23a62f3a-b803722e390mr326369966b.63.1766161576791; Fri, 19 Dec 2025
 08:26:16 -0800 (PST)
MIME-Version: 1.0
References: <20251203040754.94487-1-j@getutm.app>
 <20251203040754.94487-5-j@getutm.app>
 <32a0ad66-5c42-4d98-8c5d-0a601e31b76a@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <32a0ad66-5c42-4d98-8c5d-0a601e31b76a@rsg.ci.i.u-tokyo.ac.jp>
From: Joelle van Dyne <j@getutm.app>
Date: Fri, 19 Dec 2025 08:26:05 -0800
X-Gmail-Original-Message-ID: <CA+E+eSDgi-5sJmMk8=PWYOXdoJSAXURUD35y+2sHxJWWH0GtWA@mail.gmail.com>
X-Gm-Features: AQt7F2qNv6cmZsb-w6dJwW6dFKfm2V0EqzERSSlwA5RBbmsoIl0J08f1UWEvtGg
Message-ID: <CA+E+eSDgi-5sJmMk8=PWYOXdoJSAXURUD35y+2sHxJWWH0GtWA@mail.gmail.com>
Subject: Re: [PATCH RFC 4/7] virtio-gpu-virgl: update virglrenderer defines
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Smtpcorp-Track: Ht1ZrVHXmk1y.CCNR2kL9ROOe.uEWmVwOFykg
Feedback-ID: 483429m:483429abrvJvs:483429sZ9a1YeZfx
X-Report-Abuse: Please forward a copy of this message, including all headers, 
 to <abuse-report@smtp2go.com>
Received-SPF: pass client-ip=103.47.205.71;
 envelope-from=bT.7seeznroe9afik2=govm03c0ocew=up44ekbbue5gx3@em483429.getutm.app;
 helo=a2i327.smtp2go.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Wed, Dec 3, 2025 at 11:13=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2025/12/03 13:07, Joelle van Dyne wrote:
> > In order to support additional native texture types, we need to update =
the
> > defines in virglrenderer. The changes are backwards compatible and so
> > builds should work with either the new version or the old version.
> >
> > Signed-off-by: Joelle van Dyne <j@getutm.app>
> > ---
> >   hw/display/virtio-gpu-virgl.c | 28 +++++++++++++++++++++++++---
> >   1 file changed, 25 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virg=
l.c
> > index d0e6ad4b17..36c670f988 100644
> > --- a/hw/display/virtio-gpu-virgl.c
> > +++ b/hw/display/virtio-gpu-virgl.c
> > @@ -24,6 +24,8 @@
> >
> >   #include <virglrenderer.h>
> >
> > +#define SUPPORTED_VIRGL_INFO_EXT_VERSION (1)
>
> This naming is a bit confusing because version 0 is also supported.
>
> > +
> >   struct virtio_gpu_virgl_resource {
> >       struct virtio_gpu_simple_resource base;
> >       MemoryRegion *mr;
> > @@ -441,12 +443,30 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
> >           memset(&ext, 0, sizeof(ext));
> >           ret =3D virgl_renderer_resource_get_info_ext(ss.resource_id, =
&ext);
> >           info =3D ext.base;
> > +        /* fallback to older version */
> >           native =3D (ScanoutTextureNative){
> >               .type =3D ext.d3d_tex2d ? SCANOUT_TEXTURE_NATIVE_TYPE_D3D=
 :
> >                                       SCANOUT_TEXTURE_NATIVE_TYPE_NONE,
> >               .u.d3d_tex2d =3D ext.d3d_tex2d,
> >           };
> > -#else
> > +#if VIRGL_RENDERER_RESOURCE_INFO_EXT_VERSION >=3D SUPPORTED_VIRGL_INFO=
_EXT_VERSION
> > +        if (ext.version >=3D VIRGL_RENDERER_RESOURCE_INFO_EXT_VERSION)=
 {
> > +            switch (ext.native_type) {
> > +            case VIRGL_NATIVE_HANDLE_NONE:
> > +            case VIRGL_NATIVE_HANDLE_D3D_TEX2D: {
> > +                /* already handled above */
> > +                break;
> > +            }
> > +            default: {
> > +                qemu_log_mask(LOG_GUEST_ERROR,
> > +                            "%s: unsupported native texture type %d\n"=
,
> > +                            __func__, ext.native_type);
>
> It is not an error condition; the d3d_tex2d field is an optional hint
> that allows zero-copy inter-process sharing and the tex_id field is used
> if it is missing or inter-process sharing is unnecessary. It should be
> fine to dismiss the native handle unless the semantic changes.
When VIRGL_RENDERER_RESOURCE_INFO_EXT_VERSION >=3D 1, the semantic
changed to always have a ext.native_type. In case of missing
d3d_tex2d, ext.native_type will be VIRGL_NATIVE_HANDLE_NONE. The
default case is if virglrenderer introduces a new native type that is
unknown at the time QEMU is built. This is why the struct version is
bumped.

>
> Regards,
> Akihiko Odaki
>
> > +                break;
> > +            }
> > +            }
> > +        }
> > +#endif
> > +#else /* VIRGL_VERSION_MAJOR < 1 */
> >           memset(&info, 0, sizeof(info));
> >           ret =3D virgl_renderer_resource_get_info(ss.resource_id, &inf=
o);
> >   #endif
> > @@ -1169,11 +1189,13 @@ int virtio_gpu_virgl_init(VirtIOGPU *g)
> >           virtio_gpu_3d_cbs.get_egl_display =3D virgl_get_egl_display;
> >       }
> >   #endif
> > -#ifdef VIRGL_RENDERER_D3D11_SHARE_TEXTURE
> >       if (qemu_egl_angle_native_device) {
> > +#if defined(VIRGL_RENDERER_NATIVE_SHARE_TEXTURE)
> > +        flags |=3D VIRGL_RENDERER_NATIVE_SHARE_TEXTURE;
> > +#elif defined(VIRGL_RENDERER_D3D11_SHARE_TEXTURE) && defined(WIN32)
> >           flags |=3D VIRGL_RENDERER_D3D11_SHARE_TEXTURE;
> > -    }
> >   #endif
> > +    }
> >   #if VIRGL_VERSION_MAJOR >=3D 1
> >       if (virtio_gpu_venus_enabled(g->parent_obj.conf)) {
> >           flags |=3D VIRGL_RENDERER_VENUS | VIRGL_RENDERER_RENDER_SERVE=
R;
>

