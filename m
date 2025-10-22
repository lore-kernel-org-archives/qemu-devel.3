Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62440CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 07:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBTip-0005Gn-4v; Wed, 22 Oct 2025 03:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vBTii-0005GF-TN
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 03:57:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vBTid-0000h2-EU
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 03:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761119831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kW1IgEGrQIJL20HTg7bpcKFW51tX0blKUmPWdI7y6Pg=;
 b=BISBcoXW/FcEcw9NRwA1MUgMaO2QjH9uycNWw1YyVPDvRaUqnT3gak98nehs2Shbi1qIW8
 WnywBW42+qsq51wRihV8WRuALI/e/WgMgm5uxr4Sl2htkvvvZuUfEvrmzWghIwi4tikG7z
 4SA9DTEVnHhSGWmzjToc8SNWG8ROMVs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-0LBDj8PwNJivmHD4p_fguA-1; Wed, 22 Oct 2025 03:57:09 -0400
X-MC-Unique: 0LBDj8PwNJivmHD4p_fguA-1
X-Mimecast-MFC-AGG-ID: 0LBDj8PwNJivmHD4p_fguA_1761119829
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-32eb864fe90so1941152a91.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 00:57:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761119828; x=1761724628;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kW1IgEGrQIJL20HTg7bpcKFW51tX0blKUmPWdI7y6Pg=;
 b=xGP3SYaVXS7ZgJskB4SS9YgmnxRRg972rwScCI5JyqvlP2BP2uFF374TKqer9XALzO
 kMNG64GPXcUlQJ5FCco30HOye/W+3yGb07hJepSUd7mLiTQeLU+9NZKdX+b3WeC6k7Se
 RbHbtpmd7OdhhWhw4xQ/mO8Yiib9JWZVCjMBqv9MPfgezoorxWWBO+gpToAQbWElAK7i
 kxPa/Y02AsEXydti+zUBLsEobKqOs1d7mBINZuNWpjytVlfm2C1oaTcxTFbEv5oXZLr+
 BfNQbScXqywh5shUEl4eKA4icljlaI6NxXGKSpovmH2N4tORi4dw0O1UuPqsCXNkFkmJ
 IpJg==
X-Gm-Message-State: AOJu0Yw6vNm0hwagOOzDjKwU7z340PAeWPrMizDDIrhMPobyxH8LO29+
 Xlxo/Bj8beG9PZ0xLUugvtrXhnVH1D5biNFw43OD8xMMsJ7iFnLjwnbNc94LQX6WqqKaXlYr5Xh
 bkpmRnEevOc+OUAyOioTO8QnWjIq2yOPpFy6p1D0EQh1PFgEkGq30y53LvHdg7VDR5og8jY852y
 ryrl4F8T9eLttW0n+wKK8PwAB4qea6PnQIq5vTTYNbnqFI
X-Gm-Gg: ASbGncuer0nI3nw+kmlBKHkZ/vlZvlSHJUaz0Cp3DGsLda5yzTSQ/lprsRBc2Ze09DM
 B7xL5HWwuDx8Qht2FdJjimEttERV7J1ibdJeNobJLtFU2nEj4HkVxcWaoitFVPtEDQxXLqKLSZO
 fU+8eQNBN9pR0MIj/YaZNe8HSSZaTPSBvHqhE4mBFEyH1wprCQ9/hRBzIs2ajHpEbKE1iBOY1CO
 UJEH9xXUxhj1to=
X-Received: by 2002:a17:90b:2789:b0:32b:cb05:849a with SMTP id
 98e67ed59e1d1-33bcf8fe212mr23374302a91.29.1761119828075; 
 Wed, 22 Oct 2025 00:57:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFKV8oo2gU//Mh2F5hYdrL9oCzXSwequ4IQHqIdtC+tnOBB24KgtunuBsPZpdvMSt5zVCqSNULUXyM2HK0mM0=
X-Received: by 2002:a17:90b:2789:b0:32b:cb05:849a with SMTP id
 98e67ed59e1d1-33bcf8fe212mr23374275a91.29.1761119827649; Wed, 22 Oct 2025
 00:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
 <20251022075352.66756-1-philmd@linaro.org>
In-Reply-To: <20251022075352.66756-1-philmd@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 22 Oct 2025 11:56:56 +0400
X-Gm-Features: AS18NWAJ6r_fcXYHFvblscaKfMhZe5NrNv17SQn25j7T27OdTsA-7OMwnktHDjs
Message-ID: <CAMxuvay98ZcuNqLynzbyq1nv2kgTbqf5GyV=Rzbgfo=3XTY+DA@mail.gmail.com>
Subject: Re: [PATCH v2 43/42] audio: Remove pointless local variables
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Thomas Huth <huth@tuxfamily.org>
Content-Type: multipart/alternative; boundary="000000000000bbfa4e0641baa9d2"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--000000000000bbfa4e0641baa9d2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 11:54=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philm=
d@linaro.org>
wrote:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  audio/ossaudio.c | 12 ++----------
>  audio/sdlaudio.c | 12 ++----------
>  2 files changed, 4 insertions(+), 20 deletions(-)
>
> diff --git a/audio/ossaudio.c b/audio/ossaudio.c
> index ab8791bece9..86c4805675e 100644
> --- a/audio/ossaudio.c
> +++ b/audio/ossaudio.c
> @@ -493,10 +493,8 @@ static int oss_init_out(HWVoiceOut *hw, struct
> audsettings *as,
>  {
>      OSSVoiceOut *oss =3D (OSSVoiceOut *) hw;
>      struct oss_params req, obt;
> -    int endianness;
>      int err;
>      int fd;
> -    AudioFormat effective_fmt;
>      struct audsettings obt_as;
>      Audiodev *dev =3D drv_opaque;
>      AudiodevOssOptions *oopts =3D &dev->u.oss;
> @@ -511,7 +509,7 @@ static int oss_init_out(HWVoiceOut *hw, struct
> audsettings *as,
>          return -1;
>      }
>
> -    err =3D oss_to_audfmt (obt.fmt, &effective_fmt, &endianness);
> +    err =3D oss_to_audfmt(obt.fmt, &obt_as.fmt, &obt_as.endianness);
>      if (err) {
>          oss_anal_close (&fd);
>          return -1;
> @@ -519,8 +517,6 @@ static int oss_init_out(HWVoiceOut *hw, struct
> audsettings *as,
>
>      obt_as.freq =3D obt.freq;
>      obt_as.nchannels =3D obt.nchannels;
> -    obt_as.fmt =3D effective_fmt;
> -    obt_as.endianness =3D endianness;
>
>      audio_pcm_init_info (&hw->info, &obt_as);
>      oss->nfrags =3D obt.nfrags;
> @@ -628,10 +624,8 @@ static int oss_init_in(HWVoiceIn *hw, struct
> audsettings *as, void *drv_opaque)
>  {
>      OSSVoiceIn *oss =3D (OSSVoiceIn *) hw;
>      struct oss_params req, obt;
> -    int endianness;
>      int err;
>      int fd;
> -    AudioFormat effective_fmt;
>      struct audsettings obt_as;
>      Audiodev *dev =3D drv_opaque;
>
> @@ -644,7 +638,7 @@ static int oss_init_in(HWVoiceIn *hw, struct
> audsettings *as, void *drv_opaque)
>          return -1;
>      }
>
> -    err =3D oss_to_audfmt (obt.fmt, &effective_fmt, &endianness);
> +    err =3D oss_to_audfmt(obt.fmt, &obt_as.fmt, &obt_as.endianness);
>      if (err) {
>          oss_anal_close (&fd);
>          return -1;
> @@ -652,8 +646,6 @@ static int oss_init_in(HWVoiceIn *hw, struct
> audsettings *as, void *drv_opaque)
>
>      obt_as.freq =3D obt.freq;
>      obt_as.nchannels =3D obt.nchannels;
> -    obt_as.fmt =3D effective_fmt;
> -    obt_as.endianness =3D endianness;
>
>      audio_pcm_init_info (&hw->info, &obt_as);
>      oss->nfrags =3D obt.nfrags;
> diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c
> index a7a9652d29d..707110973ac 100644
> --- a/audio/sdlaudio.c
> +++ b/audio/sdlaudio.c
> @@ -338,9 +338,7 @@ static int sdl_init_out(HWVoiceOut *hw, struct
> audsettings *as,
>  {
>      SDLVoiceOut *sdl =3D (SDLVoiceOut *)hw;
>      SDL_AudioSpec req, obt;
> -    int endianness;
>      int err;
> -    AudioFormat effective_fmt;
>      Audiodev *dev =3D drv_opaque;
>      AudiodevSdlPerDirectionOptions *spdo =3D dev->u.sdl.out;
>      struct audsettings obt_as;
> @@ -360,7 +358,7 @@ static int sdl_init_out(HWVoiceOut *hw, struct
> audsettings *as,
>          return -1;
>      }
>
> -    err =3D sdl_to_audfmt(obt.format, &effective_fmt, &endianness);
> +    err =3D sdl_to_audfmt(obt.format, &obt_as.fmt, &obt_as.endianness);
>      if (err) {
>          sdl_close_out(sdl);
>          return -1;
> @@ -368,8 +366,6 @@ static int sdl_init_out(HWVoiceOut *hw, struct
> audsettings *as,
>
>      obt_as.freq =3D obt.freq;
>      obt_as.nchannels =3D obt.channels;
> -    obt_as.fmt =3D effective_fmt;
> -    obt_as.endianness =3D endianness;
>
>      audio_pcm_init_info (&hw->info, &obt_as);
>      hw->samples =3D (spdo->has_buffer_count ? spdo->buffer_count : 4) *
> @@ -398,9 +394,7 @@ static int sdl_init_in(HWVoiceIn *hw, audsettings *as=
,
> void *drv_opaque)
>  {
>      SDLVoiceIn *sdl =3D (SDLVoiceIn *)hw;
>      SDL_AudioSpec req, obt;
> -    int endianness;
>      int err;
> -    AudioFormat effective_fmt;
>      Audiodev *dev =3D drv_opaque;
>      AudiodevSdlPerDirectionOptions *spdo =3D dev->u.sdl.in;
>      struct audsettings obt_as;
> @@ -420,7 +414,7 @@ static int sdl_init_in(HWVoiceIn *hw, audsettings *as=
,
> void *drv_opaque)
>          return -1;
>      }
>
> -    err =3D sdl_to_audfmt(obt.format, &effective_fmt, &endianness);
> +    err =3D sdl_to_audfmt(obt.format, &obt_as.fmt, &obt_as.endianness);
>      if (err) {
>          sdl_close_in(sdl);
>          return -1;
> @@ -428,8 +422,6 @@ static int sdl_init_in(HWVoiceIn *hw, audsettings *as=
,
> void *drv_opaque)
>
>      obt_as.freq =3D obt.freq;
>      obt_as.nchannels =3D obt.channels;
> -    obt_as.fmt =3D effective_fmt;
> -    obt_as.endianness =3D endianness;
>
>      audio_pcm_init_info(&hw->info, &obt_as);
>      hw->samples =3D (spdo->has_buffer_count ? spdo->buffer_count : 4) *
> --
> 2.51.0
>
>

--000000000000bbfa4e0641baa9d2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Oct 22,=
 2025 at 11:54=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto=
:philmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">Signed-off-by: Philippe Mathieu-Daud=
=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org" target=3D"_blank">philmd@li=
naro.org</a>&gt;<br></blockquote><div><br></div><div>Reviewed-by: Marc-Andr=
=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.=
lureau@redhat.com</a>&gt;</div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
---<br>
=C2=A0audio/ossaudio.c | 12 ++----------<br>
=C2=A0audio/sdlaudio.c | 12 ++----------<br>
=C2=A02 files changed, 4 insertions(+), 20 deletions(-)<br>
<br>
diff --git a/audio/ossaudio.c b/audio/ossaudio.c<br>
index ab8791bece9..86c4805675e 100644<br>
--- a/audio/ossaudio.c<br>
+++ b/audio/ossaudio.c<br>
@@ -493,10 +493,8 @@ static int oss_init_out(HWVoiceOut *hw, struct audsett=
ings *as,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0OSSVoiceOut *oss =3D (OSSVoiceOut *) hw;<br>
=C2=A0 =C2=A0 =C2=A0struct oss_params req, obt;<br>
-=C2=A0 =C2=A0 int endianness;<br>
=C2=A0 =C2=A0 =C2=A0int err;<br>
=C2=A0 =C2=A0 =C2=A0int fd;<br>
-=C2=A0 =C2=A0 AudioFormat effective_fmt;<br>
=C2=A0 =C2=A0 =C2=A0struct audsettings obt_as;<br>
=C2=A0 =C2=A0 =C2=A0Audiodev *dev =3D drv_opaque;<br>
=C2=A0 =C2=A0 =C2=A0AudiodevOssOptions *oopts =3D &amp;dev-&gt;u.oss;<br>
@@ -511,7 +509,7 @@ static int oss_init_out(HWVoiceOut *hw, struct audsetti=
ngs *as,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 err =3D oss_to_audfmt (obt.fmt, &amp;effective_fmt, &amp;end=
ianness);<br>
+=C2=A0 =C2=A0 err =3D oss_to_audfmt(obt.fmt, &amp;obt_as.fmt, &amp;obt_as.=
endianness);<br>
=C2=A0 =C2=A0 =C2=A0if (err) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0oss_anal_close (&amp;fd);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
@@ -519,8 +517,6 @@ static int oss_init_out(HWVoiceOut *hw, struct audsetti=
ngs *as,<br>
<br>
=C2=A0 =C2=A0 =C2=A0obt_as.freq =3D obt.freq;<br>
=C2=A0 =C2=A0 =C2=A0obt_as.nchannels =3D obt.nchannels;<br>
-=C2=A0 =C2=A0 obt_as.fmt =3D effective_fmt;<br>
-=C2=A0 =C2=A0 obt_as.endianness =3D endianness;<br>
<br>
=C2=A0 =C2=A0 =C2=A0audio_pcm_init_info (&amp;hw-&gt;info, &amp;obt_as);<br=
>
=C2=A0 =C2=A0 =C2=A0oss-&gt;nfrags =3D obt.nfrags;<br>
@@ -628,10 +624,8 @@ static int oss_init_in(HWVoiceIn *hw, struct audsettin=
gs *as, void *drv_opaque)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0OSSVoiceIn *oss =3D (OSSVoiceIn *) hw;<br>
=C2=A0 =C2=A0 =C2=A0struct oss_params req, obt;<br>
-=C2=A0 =C2=A0 int endianness;<br>
=C2=A0 =C2=A0 =C2=A0int err;<br>
=C2=A0 =C2=A0 =C2=A0int fd;<br>
-=C2=A0 =C2=A0 AudioFormat effective_fmt;<br>
=C2=A0 =C2=A0 =C2=A0struct audsettings obt_as;<br>
=C2=A0 =C2=A0 =C2=A0Audiodev *dev =3D drv_opaque;<br>
<br>
@@ -644,7 +638,7 @@ static int oss_init_in(HWVoiceIn *hw, struct audsetting=
s *as, void *drv_opaque)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 err =3D oss_to_audfmt (obt.fmt, &amp;effective_fmt, &amp;end=
ianness);<br>
+=C2=A0 =C2=A0 err =3D oss_to_audfmt(obt.fmt, &amp;obt_as.fmt, &amp;obt_as.=
endianness);<br>
=C2=A0 =C2=A0 =C2=A0if (err) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0oss_anal_close (&amp;fd);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
@@ -652,8 +646,6 @@ static int oss_init_in(HWVoiceIn *hw, struct audsetting=
s *as, void *drv_opaque)<br>
<br>
=C2=A0 =C2=A0 =C2=A0obt_as.freq =3D obt.freq;<br>
=C2=A0 =C2=A0 =C2=A0obt_as.nchannels =3D obt.nchannels;<br>
-=C2=A0 =C2=A0 obt_as.fmt =3D effective_fmt;<br>
-=C2=A0 =C2=A0 obt_as.endianness =3D endianness;<br>
<br>
=C2=A0 =C2=A0 =C2=A0audio_pcm_init_info (&amp;hw-&gt;info, &amp;obt_as);<br=
>
=C2=A0 =C2=A0 =C2=A0oss-&gt;nfrags =3D obt.nfrags;<br>
diff --git a/audio/sdlaudio.c b/audio/sdlaudio.c<br>
index a7a9652d29d..707110973ac 100644<br>
--- a/audio/sdlaudio.c<br>
+++ b/audio/sdlaudio.c<br>
@@ -338,9 +338,7 @@ static int sdl_init_out(HWVoiceOut *hw, struct audsetti=
ngs *as,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0SDLVoiceOut *sdl =3D (SDLVoiceOut *)hw;<br>
=C2=A0 =C2=A0 =C2=A0SDL_AudioSpec req, obt;<br>
-=C2=A0 =C2=A0 int endianness;<br>
=C2=A0 =C2=A0 =C2=A0int err;<br>
-=C2=A0 =C2=A0 AudioFormat effective_fmt;<br>
=C2=A0 =C2=A0 =C2=A0Audiodev *dev =3D drv_opaque;<br>
=C2=A0 =C2=A0 =C2=A0AudiodevSdlPerDirectionOptions *spdo =3D dev-&gt;u.sdl.=
out;<br>
=C2=A0 =C2=A0 =C2=A0struct audsettings obt_as;<br>
@@ -360,7 +358,7 @@ static int sdl_init_out(HWVoiceOut *hw, struct audsetti=
ngs *as,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 err =3D sdl_to_audfmt(obt.format, &amp;effective_fmt, &amp;e=
ndianness);<br>
+=C2=A0 =C2=A0 err =3D sdl_to_audfmt(obt.format, &amp;obt_as.fmt, &amp;obt_=
as.endianness);<br>
=C2=A0 =C2=A0 =C2=A0if (err) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sdl_close_out(sdl);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
@@ -368,8 +366,6 @@ static int sdl_init_out(HWVoiceOut *hw, struct audsetti=
ngs *as,<br>
<br>
=C2=A0 =C2=A0 =C2=A0obt_as.freq =3D obt.freq;<br>
=C2=A0 =C2=A0 =C2=A0obt_as.nchannels =3D obt.channels;<br>
-=C2=A0 =C2=A0 obt_as.fmt =3D effective_fmt;<br>
-=C2=A0 =C2=A0 obt_as.endianness =3D endianness;<br>
<br>
=C2=A0 =C2=A0 =C2=A0audio_pcm_init_info (&amp;hw-&gt;info, &amp;obt_as);<br=
>
=C2=A0 =C2=A0 =C2=A0hw-&gt;samples =3D (spdo-&gt;has_buffer_count ? spdo-&g=
t;buffer_count : 4) *<br>
@@ -398,9 +394,7 @@ static int sdl_init_in(HWVoiceIn *hw, audsettings *as, =
void *drv_opaque)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0SDLVoiceIn *sdl =3D (SDLVoiceIn *)hw;<br>
=C2=A0 =C2=A0 =C2=A0SDL_AudioSpec req, obt;<br>
-=C2=A0 =C2=A0 int endianness;<br>
=C2=A0 =C2=A0 =C2=A0int err;<br>
-=C2=A0 =C2=A0 AudioFormat effective_fmt;<br>
=C2=A0 =C2=A0 =C2=A0Audiodev *dev =3D drv_opaque;<br>
=C2=A0 =C2=A0 =C2=A0AudiodevSdlPerDirectionOptions *spdo =3D dev-&gt;<a hre=
f=3D"http://u.sdl.in" rel=3D"noreferrer" target=3D"_blank">u.sdl.in</a>;<br=
>
=C2=A0 =C2=A0 =C2=A0struct audsettings obt_as;<br>
@@ -420,7 +414,7 @@ static int sdl_init_in(HWVoiceIn *hw, audsettings *as, =
void *drv_opaque)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 err =3D sdl_to_audfmt(obt.format, &amp;effective_fmt, &amp;e=
ndianness);<br>
+=C2=A0 =C2=A0 err =3D sdl_to_audfmt(obt.format, &amp;obt_as.fmt, &amp;obt_=
as.endianness);<br>
=C2=A0 =C2=A0 =C2=A0if (err) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sdl_close_in(sdl);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
@@ -428,8 +422,6 @@ static int sdl_init_in(HWVoiceIn *hw, audsettings *as, =
void *drv_opaque)<br>
<br>
=C2=A0 =C2=A0 =C2=A0obt_as.freq =3D obt.freq;<br>
=C2=A0 =C2=A0 =C2=A0obt_as.nchannels =3D obt.channels;<br>
-=C2=A0 =C2=A0 obt_as.fmt =3D effective_fmt;<br>
-=C2=A0 =C2=A0 obt_as.endianness =3D endianness;<br>
<br>
=C2=A0 =C2=A0 =C2=A0audio_pcm_init_info(&amp;hw-&gt;info, &amp;obt_as);<br>
=C2=A0 =C2=A0 =C2=A0hw-&gt;samples =3D (spdo-&gt;has_buffer_count ? spdo-&g=
t;buffer_count : 4) *<br>
-- <br>
2.51.0<br>
<br>
</blockquote></div></div>

--000000000000bbfa4e0641baa9d2--


