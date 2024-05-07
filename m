Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48EDC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 15:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4McO-0006cT-RP; Tue, 07 May 2024 11:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s4McL-0006c6-1g
 for qemu-devel@nongnu.org; Tue, 07 May 2024 11:20:33 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1s4McJ-0005kI-E7
 for qemu-devel@nongnu.org; Tue, 07 May 2024 11:20:32 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4365c1451d4so22311911cf.2
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 08:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715095229; x=1715700029; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5rPtVYQzTkGXKf1B6h2YgGd/M0eKj05NpjB46351Tcs=;
 b=a1Z3VNYk1U+vSmDHthaHJKoTAWay6Pgo8oxdk91stf24MT3yu7SIC0z5lmEkeViA3w
 9b5rihMC9lugjP7/vefSO+YZqRWdPRus2xkUgffEoZZr6vctn1TmeskCQSdAGH6CL8+t
 Y2APK15ouS6zfnMQkOb+CCZZaXcPtSiYvxPp0Inn15eFySwIz3j7KJc/aocNLqey0Oeh
 lKVaqMlcF/h/G3RPFEqdf6kBfGVP3wcaFOs9ON8mC+HzfakBD6jE6rJC+nSx1aSMh1L8
 x9LzN8D+f0gIr31CnlJGtS9Fq9qd5ftt7qQOukgvjDlsdXr6OXRux+jyeFUe5n+fxbPU
 moZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715095229; x=1715700029;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5rPtVYQzTkGXKf1B6h2YgGd/M0eKj05NpjB46351Tcs=;
 b=K/HFECh6OhaeqgOHuCDLwfn1LBsziXafqA6+lCvE3njHii8PmwSlYKe8nKlyOvcvlP
 PLd4OJY6nWWxmp2ctaBKXJEbdCHekQvgV98RaBSSlIP0XsApGn9XLONS+wuJBeqgOTQ0
 zs661yUVkrJ4RS3DRuaKlQH9jMJLKYdCW1Vnn84KE2K5bOotvW1P6cRENNUPCKUF1CoY
 K21penTElcWbnZQMBjXSXjUTH4I4fZ3Z1hUyNuDN4Lhp8TL/nGuToWx2qsnH3W7+3gSl
 v4mO6omOMt7J7iN4T7moRr/YexDpWKFuUMKVrwb8Tu0izn9rlRMXBw0vFJzqIDHS19Ri
 a3jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk8Wo7B4Sq7YQ/PoamhRifN6BPhypAdL7jjwg0POY4H3u2jzrVcQgnIDBxlkaDRK5++PYw09+zsomVn+lc7gEHeVZUKXo=
X-Gm-Message-State: AOJu0YxnsHJ0GSAKJ0w867zQyecCfxCPC/kDVH9ZT8gXnja62BSKPsaA
 KBQV1AVzxlSMBLAE6ISP/ovR8joebvuqnq37HhOzZ6iDPoHNO+B9wXQ0o7R5Aigp8VKwsgoW4xY
 B2TLrqqFznO2icP1/gDphqkyvACc=
X-Google-Smtp-Source: AGHT+IHZCTZ7pbXYYOb1Y8h1rhZqtW2WjKUoao2DBV1G0S+VdfQxsmhF5aPijvEaUOVt64xkl85bzyaNlVv8AxqQiGM=
X-Received: by 2002:a05:622a:4d87:b0:43c:76a4:dea5 with SMTP id
 d75a77b69052e-43dbee440ddmr200061cf.0.1715095228750; Tue, 07 May 2024
 08:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240504202834.399780-1-dmitry.osipenko@collabora.com>
 <20240504202834.399780-3-dmitry.osipenko@collabora.com>
 <CAJ+F1CLkZjZ5b_wbVYFtr65UFjnxMR236=_=+mUZBYMO73jr6g@mail.gmail.com>
In-Reply-To: <CAJ+F1CLkZjZ5b_wbVYFtr65UFjnxMR236=_=+mUZBYMO73jr6g@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 7 May 2024 19:20:17 +0400
Message-ID: <CAJ+F1C+UfKqoydwgCnfm=J+0sBQwqQFzvR=D7D2q+SSnRdPA6g@mail.gmail.com>
Subject: Re: [PATCH v10 02/10] virtio-gpu: Use pkgconfig version to decide
 which virgl features are available
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>, 
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, 
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, 
 Gurchetan Singh <gurchetansingh@chromium.org>, ernunes@redhat.com, 
 Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, 
 Julia Zhang <julia.zhang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>, 
 Yiwei Zhang <zzyiwei@chromium.org>
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

Hi

On Tue, May 7, 2024 at 7:18=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Sun, May 5, 2024 at 12:29=E2=80=AFAM Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
> >
> > New virglrerenderer features were stabilized with release of v1.0.0.
> > Presence of symbols in virglrenderer.h doesn't guarantee ABI compatibil=
ity
> > with pre-release development versions of libvirglerender. Use virglrend=
erer
> > version to decide reliably which virgl features are available.
> >
> > Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > ---
> >  meson.build | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/meson.build b/meson.build
> > index 5db2dbc12ec7..f4a4d71c1978 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -2286,11 +2286,8 @@ config_host_data.set('CONFIG_PNG', png.found())
> >  config_host_data.set('CONFIG_VNC', vnc.found())
> >  config_host_data.set('CONFIG_VNC_JPEG', jpeg.found())
> >  config_host_data.set('CONFIG_VNC_SASL', sasl.found())
> > -if virgl.found()
> > -  config_host_data.set('HAVE_VIRGL_D3D_INFO_EXT',
> > -                       cc.has_member('struct virgl_renderer_resource_i=
nfo_ext', 'd3d_tex2d',
> > -                                     prefix: '#include <virglrenderer.=
h>',
> > -                                     dependencies: virgl))
> > +if virgl.version().version_compare('>=3D1.0.0')
> > +  config_host_data.set('HAVE_VIRGL_D3D_INFO_EXT', 1)
>
> If it checks for version >=3D1.0, we may as well depend on >=3D1.0.1 imho=
,
> and then simply use VIRGL_CHECK_VERSION in the code.
>

..but we would need a fallback if VIRGL_CHECK_VERSION isn't defined in
that case (which could simply fail).




--=20
Marc-Andr=C3=A9 Lureau

