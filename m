Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A747AC2A06C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Jan 2026 04:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcFk6-0008Ns-SA; Sat, 03 Jan 2026 23:29:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.rovviyq6pz1g1f1=32ia1ppqr1uz=w8ie89iensqfxh@em483429.getutm.app>)
 id 1vcFk4-0008NX-Vg
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 23:29:25 -0500
Received: from a4i726.smtp2go.com ([158.120.82.214])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.rovviyq6pz1g1f1=32ia1ppqr1uz=w8ie89iensqfxh@em483429.getutm.app>)
 id 1vcFk2-0005YA-Ll
 for qemu-devel@nongnu.org; Sat, 03 Jan 2026 23:29:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1767500957; h=from : subject :
 to : message-id : date;
 bh=/rUimfa1xQoEAYqhDVurRCWnLUc5Hbd6RchhYLxX8K4=;
 b=KxGfwh4KTTDSoCwNv/EJ2iecxGsCbSnVNPAlLrmBi+uCujd2WEnXSuWA+7OhhrhUulDxm
 6clF5yLt+z5e2YqDNgl1raWDVb+iEZN3NrvXgYle+PG2CEWOR24dFj53UJrwIz0rI5fZMza
 m5y9xpZE0fkc+l6FCkh39cpgO33srk7BvDm/LQWkXmMUO3jLFFPmExisco9x1qrqNkDf7Gk
 Q4v8Wd9r8zIeP7h6wRuPa8ZXV7n13p1pEOSGxXGCDVi4D8Yuxm8Qso1Z3qhPVtd1LPhWN+N
 MPFOdIZ0yezO6ab3EexEdQLLo3MlSLa+UTUJFB3otsV3b1zLwnsRi4pAcUbg==
Received: from [10.159.238.187] (helo=mail-ej1-f49.google.com)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
 (Exim 4.98.1-S2G) (envelope-from <j@getutm.app>)
 id 1vcFi1-FnQW0hPkmAW-LCTX for qemu-devel@nongnu.org;
 Sun, 04 Jan 2026 04:27:17 +0000
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-b7ffa421f1bso147757666b.0
 for <qemu-devel@nongnu.org>; Sat, 03 Jan 2026 20:27:16 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUYFSMiEGWjTBGVv587/QRguY/OJtNEGSVtophPGVJ172vaW4WjbKxfYEVFIWQ4NpkbcbJIyFxT/itO@nongnu.org
X-Gm-Message-State: AOJu0Yxlt4U82hEe4Tp3h5HEIswpBOZAb3mydfgafpfAUDU7bVCYsQ/i
 d2A0v68QO/nE+7DFXeIxI1bIToz55tUwL2wz9cAVzd+7vT8C+uCstLFdsttTySpKEWxU+O0GxcT
 h3qPpGFragIShqkNP9YUR3seuns74iaM=
X-Google-Smtp-Source: AGHT+IH+kt+jvZSbBV+0F8TmRqgvB2VcTaluVz9IP9t8YbtdlJiSWH15clsMc4nBc/TFFAqWqndyuQZ6hXup9+H+CNE=
X-Received: by 2002:a17:906:318e:b0:b76:3d56:f666 with SMTP id
 a640c23a62f3a-b83e275d4c4mr271615466b.26.1767500835051; Sat, 03 Jan 2026
 20:27:15 -0800 (PST)
MIME-Version: 1.0
References: <20251203040754.94487-1-j@getutm.app>
 <20251203040754.94487-2-j@getutm.app>
 <3a401334-700f-4b11-b006-a93470d38a66@rsg.ci.i.u-tokyo.ac.jp>
 <CA+E+eSBOEzzb-aO2B_yWtJeoK4QGvjf=pB555+GGE2U0OH=vbw@mail.gmail.com>
 <f246dcbd-2a13-46e8-97cb-d6959d8115dc@rsg.ci.i.u-tokyo.ac.jp>
 <CA+E+eSCJ8y8RnGe99kFVSLbex_jE71z74+pF4aom-LMbjXgzPQ@mail.gmail.com>
 <a4e9815c-8641-4250-9bf4-ec13fa49e1ee@rsg.ci.i.u-tokyo.ac.jp>
 <CA+E+eSAKYCui8huYrZ=0Vw5pKQHXoGJjRPYb1Pr6ozSezXyUgA@mail.gmail.com>
 <bfa37bf0-78bf-47be-9c67-af2a7911fc30@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <bfa37bf0-78bf-47be-9c67-af2a7911fc30@rsg.ci.i.u-tokyo.ac.jp>
From: Joelle van Dyne <j@getutm.app>
Date: Sat, 3 Jan 2026 20:27:04 -0800
X-Gmail-Original-Message-ID: <CA+E+eSBDppoSFaYDJWw82aHcm1U2iYtzOckD=jagBV11+7-wtg@mail.gmail.com>
X-Gm-Features: AQt7F2pIFoskh_NLsvRJcQWv8_iaLa1fH0i1bD0caBciIcdnKQ69l6HydaSA8zg
Message-ID: <CA+E+eSBDppoSFaYDJWw82aHcm1U2iYtzOckD=jagBV11+7-wtg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/7] egl-helpers: store handle to native device
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 483429m:483429abrvJvs:483429sWxEtmuJYa
X-smtpcorp-track: 9sdxlaJRpy8g.Er-67y69jT2h.nA7ssArLyp7
Received-SPF: pass client-ip=158.120.82.214;
 envelope-from=bounce.rovviyq6pz1g1f1=32ia1ppqr1uz=w8ie89iensqfxh@em483429.getutm.app;
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

On Sat, Jan 3, 2026 at 7:35=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/01/04 7:24, Joelle van Dyne wrote:
> > On Wed, Dec 24, 2025 at 12:22=E2=80=AFAM Akihiko Odaki
> > <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> >>
> >> On 2025/12/24 16:54, Joelle van Dyne wrote:
> >>> On Tue, Dec 23, 2025 at 10:23=E2=80=AFPM Akihiko Odaki
> >>> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> >>>>
> >>>> On 2025/12/20 1:11, Joelle van Dyne wrote:
> >>>>> On Wed, Dec 3, 2025 at 10:31=E2=80=AFPM Akihiko Odaki
> >>>>> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> >>>>>>
> >>>>>> On 2025/12/03 13:07, Joelle van Dyne wrote:
> >>>>>>> Make way for other platforms by making the variable more general.=
 Also we
> >>>>>>> will be using the device in the future so let's save the pointer =
in the
> >>>>>>> global instead of just a boolean flag.
> >>>>>>>
> >>>>>>> Signed-off-by: Joelle van Dyne <j@getutm.app>
> >>>>>>> ---
> >>>>>>>      include/ui/egl-helpers.h      | 2 +-
> >>>>>>>      hw/display/virtio-gpu-virgl.c | 2 +-
> >>>>>>>      ui/egl-helpers.c              | 4 ++--
> >>>>>>>      3 files changed, 4 insertions(+), 4 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
> >>>>>>> index acf993fcf5..c239d32317 100644
> >>>>>>> --- a/include/ui/egl-helpers.h
> >>>>>>> +++ b/include/ui/egl-helpers.h
> >>>>>>> @@ -12,7 +12,7 @@
> >>>>>>>      extern EGLDisplay *qemu_egl_display;
> >>>>>>>      extern EGLConfig qemu_egl_config;
> >>>>>>>      extern DisplayGLMode qemu_egl_mode;
> >>>>>>> -extern bool qemu_egl_angle_d3d;
> >>>>>>> +extern void *qemu_egl_angle_native_device;
> >>>>>>
> >>>>>> I guess ANGLE will not be relevant for Metal and leaving it will b=
e
> >>>>>> misleading.
> >>>>> What is your suggestion? This is just to remove "D3D" from the
> >>>>> variable name. If you want to remove "ANGLE" from the variable name=
 as
> >>>>> well, it may be misleading because this variable is only used with =
an
> >>>>> ANGLE EGL backend.
> >>>> Looking the usage of the variable in your tree, I realized this vari=
able
> >>>> may not be necessary for this at all.
> >>>>
> >>>> There are two use cases:
> >>>>
> >>>> 1. To determine if VIRGL_RENDERER_NATIVE_SHARE_TEXTURE needs to be s=
et.
> >>>> 2. To pass the device used by ANGLE to Cocoa.
> >>>>
> >>>> Regarding 1, virglrenderer can simply pass MTLTexture whenever the E=
GL
> >>>> context is backed with Metal and Venus is in use.
> >>>>
> >>>> Although your code is modeled after the code dealing with Direct3D
> >>>> handles, the functionality of your code is quite a different from it=
.
> >>>>
> >>>> Direct3D handles are used to "share" texture with other processes in=
 a
> >>>> zero-copy manner. It is an optional hint; dbus can fall back to use
> >>>> OpenGL textures if they are missing, and the other displays just don=
't care.
> >>>>
> >>>> On the other hand, MTLTexture plays an essential role in your scenar=
io.
> >>>> There are no corresponding OpenGL texture so no fallback happens.
> >>> That's a good point, but there's two uses of MTLTexture: one as a
> >>> direct parallel to D3D handles (vrend allocate a texture backed by
> >>> MTLTexture; returns it in info_ext along with a tex_id) and one
> >>> returned as part of the new API
> >>> (virgl_renderer_create_handle_for_scanout) which does not have an
> >>> associated tex_id.
> >>
> >> Thanks for clarification. I think the point I mentioned below still
> >> holds; virglrenderer does not have any code that can be skipped for
> >> MTLTexture with the absence of VIRGL_RENDERER_NATIVE_SHARE_TEXTURE.
> > We support the same "hint" use case in vrend for MTLTexture. So,
> > without that flag set, there will be no attempt to allocate a
> > MTLTexture. This works regardless if Venus is used or not. However, in
> > the Venus use case, the hint does not matter at all because as long as
> > the new API virgl_renderer_create_handle_for_scanout is used, a
> > MTLTexture is returned. In this sense, I think it makes sense to
> > rename *D3D* to *NATIVE*.
>
> MTLTexture is always allocated; If virglrenderer doesn't, ANGLE does
> that internally. There should be no practical difference whether
> MTLTexture is exposed to QEMU or not.
The difference is that if virglrenderer creates it and exposes it to
QEMU, then the UI can use a faster blit path. When the flag is set,
virglrenderer creates the MTLTexture, passes it to ANGLE, and holds a
reference for QEMU to retrieve. When the flag is not set, there is no
way of getting the MTLTexture from ANGLE.

>
> So I think the only thing matters here is code complexity. MTLTexture
> should be exposed to QEMU if it makes the code simpler. If it
> complicates the code, it shouldn't be done. No flag is needed either way.
>
> Regards,
> Akihiko Odaki

