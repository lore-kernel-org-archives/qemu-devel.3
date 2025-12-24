Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F42E7491E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 07:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYJhl-0000U5-Fa; Wed, 24 Dec 2025 02:54:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.egctzbjxysmv9g6=15gibdr0d3y2=ng1aebhpkvknav@em483429.getutm.app>)
 id 1vYJhj-0000Sl-KL
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 02:54:43 -0500
Received: from a2i327.smtp2go.com ([103.47.205.71])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bT.egctzbjxysmv9g6=15gibdr0d3y2=ng1aebhpkvknav@em483429.getutm.app>)
 id 1vYJhh-00063Z-FZ
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 02:54:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=smtpservice.net; s=mad0l0.a1-4.dyn; x=1766563766; h=Feedback-ID:
 X-Smtpcorp-Track:To:Subject:Message-ID:Date:From:Reply-To:Sender:
 List-Unsubscribe:List-Unsubscribe-Post;
 bh=40ugZrEUOsosypzcYRD7qH5Td/SyeEolAqFDB1b3N54=; b=pa4C4REk8G09vZ2WP/g1GhmmYo
 1PitpUvydKXavTstz/QqDAPcgO2b9/JOT4PYYu2sA47e4lw0LSJjVBIySdW6LfLfteWv1V33IoOQh
 vgKOvBVc9XZLNHrNJjHIFO6Y9VO0KJYVOlU6GssNSfZ6oKwwgvXsR8ruSn127zgeSzuA2hy/G5S9e
 lq3D0k+hYVua8tdswk/zGBtaTirXVACJSNrU/w9Tcg8/x7vE7n+mREyc64qGDITL8VfAUd7x/yLr2
 HM2cYSd5eAd/HC+D+Nb5COCTl4sx9Zv5B0BRUV5l+qJ9lidBNgetr5DxNotnK9C3eVsXHjWpBPaFV
 YRpC92VA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=getutm.app;
 i=@getutm.app; q=dns/txt; s=s483429; t=1766562866; h=from : subject :
 to : message-id : date;
 bh=40ugZrEUOsosypzcYRD7qH5Td/SyeEolAqFDB1b3N54=;
 b=kaOvkhOjN/NnFXwhQQGzFGzcvReNmRhmyTdKDNVyVJGnmWbqJ2t/BACLLCXjthGG/OvHY
 QyPtsYVdO9SHA4G/PnGSWDvJ2HrOe1lkPvbBaIBplx47cDrtUryjgQlPtRCEfaXrlIzplyS
 tEzLIAKVaaZJyG6ijcXk80KAjNjt/PakrfX0aMHwfkgXfPQ0b9Kom0gQ4Jo1MyhCEJ9at4C
 k3oIT3RlgTYVZsgW5o4svV6RP6ps0XCEu1tioE4aACiio+xeVnG3fLm6vkdMyQSvuKQ63Ie
 mmTXHd2IhtWFr1EEknHJtoMR32ANqFPOh1QSF16sh7FPxu6zQVSpWLrf87vQ==
Received: from [10.143.42.182] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <j@getutm.app>) id 1vYJhQ-pH9RpN-UF
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 07:54:24 +0000
Received: from [10.159.238.187] (helo=mail-ed1-f42.google.com)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
 (Exim 4.98.1-S2G) (envelope-from <j@getutm.app>)
 id 1vYJhQ-FnQW0hPwUOh-iMGK for qemu-devel@nongnu.org;
 Wed, 24 Dec 2025 07:54:24 +0000
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-64b4b35c812so7771403a12.0
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 23:54:24 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWwPigw8+eZl/CXQWNmud28OFap3OJ0YV9kkc1/ki6ElymI0Jbt937xE8ujM5ec6SLp4Cefg3PweWJy@nongnu.org
X-Gm-Message-State: AOJu0YyYmbYKAaMRhrdkoUKWIPLHiS5T8qX8TYIIZnQZX3I4GHj8tBQH
 nu/AliMv6VlHjfayEhuXx9mYb5sC2iWEmoBMipllG5SyZhzKpM98CjEkgRyhi1mOky5tVmRrXqe
 e/TOzcKm/7IpJg55i9h4eOaJMiEuB23c=
X-Google-Smtp-Source: AGHT+IGLzW1f+RqTFbrNcidE971ytRdazn8OGxC/gH5tCc4IJcCdvUIDiVoXW2aPDt//uJouWVy3V8XaTjKIrQldGoE=
X-Received: by 2002:a17:907:3fa5:b0:b75:7b39:90c9 with SMTP id
 a640c23a62f3a-b803718390fmr1936982466b.51.1766562863702; Tue, 23 Dec 2025
 23:54:23 -0800 (PST)
MIME-Version: 1.0
References: <20251203040754.94487-1-j@getutm.app>
 <20251203040754.94487-2-j@getutm.app>
 <3a401334-700f-4b11-b006-a93470d38a66@rsg.ci.i.u-tokyo.ac.jp>
 <CA+E+eSBOEzzb-aO2B_yWtJeoK4QGvjf=pB555+GGE2U0OH=vbw@mail.gmail.com>
 <f246dcbd-2a13-46e8-97cb-d6959d8115dc@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <f246dcbd-2a13-46e8-97cb-d6959d8115dc@rsg.ci.i.u-tokyo.ac.jp>
From: Joelle van Dyne <j@getutm.app>
Date: Tue, 23 Dec 2025 23:54:12 -0800
X-Gmail-Original-Message-ID: <CA+E+eSCJ8y8RnGe99kFVSLbex_jE71z74+pF4aom-LMbjXgzPQ@mail.gmail.com>
X-Gm-Features: AQt7F2q8oT7K5mIuqGsLveeUprrHioA7jZABA7fbailnLPgQ1wbeiZYkITNcUmU
Message-ID: <CA+E+eSCJ8y8RnGe99kFVSLbex_jE71z74+pF4aom-LMbjXgzPQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/7] egl-helpers: store handle to native device
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Smtpcorp-Track: irsebDCauBOT.2lrrWV0Itpiz._Qj5CgdLSmv
Feedback-ID: 483429m:483429abrvJvs:483429sWxEtmuJYa
X-Report-Abuse: Please forward a copy of this message, including all headers, 
 to <abuse-report@smtp2go.com>
Received-SPF: pass client-ip=103.47.205.71;
 envelope-from=bT.egctzbjxysmv9g6=15gibdr0d3y2=ng1aebhpkvknav@em483429.getutm.app;
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

On Tue, Dec 23, 2025 at 10:23=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2025/12/20 1:11, Joelle van Dyne wrote:
> > On Wed, Dec 3, 2025 at 10:31=E2=80=AFPM Akihiko Odaki
> > <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> >>
> >> On 2025/12/03 13:07, Joelle van Dyne wrote:
> >>> Make way for other platforms by making the variable more general. Als=
o we
> >>> will be using the device in the future so let's save the pointer in t=
he
> >>> global instead of just a boolean flag.
> >>>
> >>> Signed-off-by: Joelle van Dyne <j@getutm.app>
> >>> ---
> >>>    include/ui/egl-helpers.h      | 2 +-
> >>>    hw/display/virtio-gpu-virgl.c | 2 +-
> >>>    ui/egl-helpers.c              | 4 ++--
> >>>    3 files changed, 4 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
> >>> index acf993fcf5..c239d32317 100644
> >>> --- a/include/ui/egl-helpers.h
> >>> +++ b/include/ui/egl-helpers.h
> >>> @@ -12,7 +12,7 @@
> >>>    extern EGLDisplay *qemu_egl_display;
> >>>    extern EGLConfig qemu_egl_config;
> >>>    extern DisplayGLMode qemu_egl_mode;
> >>> -extern bool qemu_egl_angle_d3d;
> >>> +extern void *qemu_egl_angle_native_device;
> >>
> >> I guess ANGLE will not be relevant for Metal and leaving it will be
> >> misleading.
> > What is your suggestion? This is just to remove "D3D" from the
> > variable name. If you want to remove "ANGLE" from the variable name as
> > well, it may be misleading because this variable is only used with an
> > ANGLE EGL backend.
> Looking the usage of the variable in your tree, I realized this variable
> may not be necessary for this at all.
>
> There are two use cases:
>
> 1. To determine if VIRGL_RENDERER_NATIVE_SHARE_TEXTURE needs to be set.
> 2. To pass the device used by ANGLE to Cocoa.
>
> Regarding 1, virglrenderer can simply pass MTLTexture whenever the EGL
> context is backed with Metal and Venus is in use.
>
> Although your code is modeled after the code dealing with Direct3D
> handles, the functionality of your code is quite a different from it.
>
> Direct3D handles are used to "share" texture with other processes in a
> zero-copy manner. It is an optional hint; dbus can fall back to use
> OpenGL textures if they are missing, and the other displays just don't ca=
re.
>
> On the other hand, MTLTexture plays an essential role in your scenario.
> There are no corresponding OpenGL texture so no fallback happens.
That's a good point, but there's two uses of MTLTexture: one as a
direct parallel to D3D handles (vrend allocate a texture backed by
MTLTexture; returns it in info_ext along with a tex_id) and one
returned as part of the new API
(virgl_renderer_create_handle_for_scanout) which does not have an
associated tex_id.

>
> The difference shows that the VIRGL_RENDERER_NATIVE_SHARE_TEXTURE flag
> is useful when dealing with Direct3D handles but not with MTLTexture.
> The absence of flag tells virglrenderer that we do not need Direct3D
> handle (because the dbus display is not used), and allows it to skip
> some code to convert OpenGL textures to Direct3D handles).
>
> On the other hand, not passing MTLTexture in your scenario does not make
> sense because it prevents the scanout at all. virglrenderer does not
> have any code that can be skipped when the flag is absent. virglrenderer
> can simply pass MTLTexture in your scenario.
>
> 2 implicitly lets ANGLE choose a device, but this can be suboptimal.
> Ideally, Cocoa should instead choose a device because it knows what
> device displays the window. Cocoa should pass the device it chose to ANGL=
E.
>
> To demonstrate the point, I updated my tree to use ANGLE's Metal
> renderer for OpenGL and to pass the device from Cocoa to ANGLE:
> https://github.com/akihikodaki/v/commit/8f191a7d2c225fa601c22a783c24c81a3=
fda47fa
>
> By the way, I had to make a few modifications to ANGLE, Epoxy, and
> virglrenderer to fix glitches when hosting glmark2 and Firefox on GNOME.
> You can also find them with the above URL if you are interested.
Thank you, we picked up a couple of your changes in the UTM branch
already. Do you have plans to upstream those changes? And also, what
are your plans for upstreaming the Cocoa GL backend changes for QEMU?

>
> Regards,
> Akihiko Odaki

