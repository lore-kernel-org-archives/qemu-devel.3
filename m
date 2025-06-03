Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B169FC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 08:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMMvc-0001Ft-RP; Tue, 03 Jun 2025 04:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1uMMva-0001Fl-Hv
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:23:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1uMMvY-000732-LY
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748938998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xMDzDp9N8Wt/HmgFpnGdGFHoAIwgUKScUOd1KeZVzFE=;
 b=bPf/7V+b3m+moYkb4Ma7I/VIq6hb5RkIbyU4z/SzY9qOc/xTOn1GSO0vDA4mSe/TFBE1ig
 Sy7qH/NHDJ0WG6Yq5JTEQqc4pbDXMTcoYwDfOP/wiZW6ulxPoT58w9QSyExJ8czZp4i9jA
 pcowxz/8LNmhAC7SXOfd8bcYWNTKmmQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-YTIC8aBnOLi-l5haeXbHTQ-1; Tue, 03 Jun 2025 04:22:07 -0400
X-MC-Unique: YTIC8aBnOLi-l5haeXbHTQ-1
X-Mimecast-MFC-AGG-ID: YTIC8aBnOLi-l5haeXbHTQ_1748938926
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4a43ae0dcf7so98321631cf.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 01:22:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748938926; x=1749543726;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xMDzDp9N8Wt/HmgFpnGdGFHoAIwgUKScUOd1KeZVzFE=;
 b=AVsbbjXDcyVVOdwb00G0hRJeueXwuc8w7sqApgcKNDvS/bzp+6RX7NFKEr048Avf98
 sO/JhU7HLH37+6Mn++rVGuZzJesST2qv92X4Py1ddx/byKeXVcY84N4hSBWlqj42JWFa
 uFPyFVzQYeyutt/xf2qz2UT9tNj2XqCQ3fUy92lyk+wLUhkkAxAg/rqWMh5X4YcIXfzi
 Gs+IcTFXaxrSBy/EMt5hMJ1RrIBnhSyEgBRzwcIyBGv3AkYV+JjaF+y7ztsD4iozIuXJ
 yF51bUK53FGLSfQoAxn5njQLo+tVGGHX0OQviA2z7x1NOuR89l9JSoGUvyYhZRV9j7U2
 5Dvw==
X-Gm-Message-State: AOJu0YzEALBdr/vvCiOlqhuYsfx0dlx48kectW9vFvyxRDXeVdIxP9Gj
 Ax+Owlwt2a+EihZfeC3ZbnVL1dUkKiea9o0TuTOfrgIUcgX2TMXzd+W26T/evdpG/uzwNj5MIHE
 7SDR3kQN4wr9PonVQuy0fkZB5uAXbCcKdvGolAi0HR0ZtugoyORd+dQaGnxbbMbh9n9XKL9+zeW
 c+3/cEekFruONdlZKF07WETvwcWYZbr2Y=
X-Gm-Gg: ASbGnctkRMXKSf4ZQXlZNhoQXKkQTJ2nAVhdnP5l75zP5Gnzq9yctjmiA87i9BRb7hm
 PlTqVBZw/mhe4oXdDF5oDcOUVQ+XT/+P9KqAK/8bhqOAYvkCXcSyMSwEq6b2fLSWNgjJdo50Mkr
 +8BagOaPj87H74CKi2kHAAdgMAyA==
X-Received: by 2002:a05:622a:4a16:b0:4a4:4c26:7032 with SMTP id
 d75a77b69052e-4a44c267871mr213258261cf.2.1748938926253; 
 Tue, 03 Jun 2025 01:22:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHViwqNSlflmipVIMonjBI+PnVVv3ymdLk5m1SwIBaBRR5vX2aLyoV9a/nq7g6bOYbW6Z/4EQxbp+bwwn2zGaE=
X-Received: by 2002:a05:622a:4a16:b0:4a4:4c26:7032 with SMTP id
 d75a77b69052e-4a44c267871mr213258031cf.2.1748938925908; Tue, 03 Jun 2025
 01:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250601045245.36778-1-weifeng.liu.z@gmail.com>
In-Reply-To: <20250601045245.36778-1-weifeng.liu.z@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 3 Jun 2025 12:21:53 +0400
X-Gm-Features: AX0GCFvRndKXco6_mMv9DiboxNe7aQHQzgtxRpxAgM8EWW3zcOb3HOnmc4twt2Q
Message-ID: <CAMxuvawauUMWVZz1Nh=pKqHnYYwjy8rW3MD_N=6pTWUhbijctg@mail.gmail.com>
Subject: Re: [PATCH 0/2] ui/gtk: Add keep-aspect-ratio and scale option
To: Weifeng Liu <weifeng.liu.z@gmail.com>
Cc: qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
 "Kim, Dongwon" <dongwon.kim@intel.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000069b8d10636a69315"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--00000000000069b8d10636a69315
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 1, 2025 at 8:53=E2=80=AFAM Weifeng Liu <weifeng.liu.z@gmail.com=
> wrote:

> Add these options to give users more control over behaviors in gtk
> display backend:
>
> - keep-aspect-ratio: when set to true, if the aspect ratio of host
>   window differs from that of guest frame-buffer, padding will be added
>   to the host window to preserve the aspect ratio of guest frame-buffer.
>
> - scale: allow user to set a preferred scale factor, which would be
>   helpful for users running on a hi-dpi desktop to achieve pixel to
>   pixel display.
>
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com>
> Cc: "Kim, Dongwon" <dongwon.kim@intel.com>
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Tested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> Best regards,
> Weifeng
>
> Weifeng Liu (2):
>   ui/gtk: Add keep-aspect-ratio option
>   ui/gtk: Add scale option
>
>  include/ui/gtk.h |  2 ++
>  qapi/ui.json     | 15 +++++++++----
>  ui/gtk.c         | 58 ++++++++++++++++++++++++++++++++----------------
>  3 files changed, 52 insertions(+), 23 deletions(-)
>
> --
> 2.49.0
>
>

--00000000000069b8d10636a69315
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Jun 1, =
2025 at 8:53=E2=80=AFAM Weifeng Liu &lt;<a href=3D"mailto:weifeng.liu.z@gma=
il.com">weifeng.liu.z@gmail.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Add these options to give users more contr=
ol over behaviors in gtk<br>
display backend:<br>
<br>
- keep-aspect-ratio: when set to true, if the aspect ratio of host<br>
=C2=A0 window differs from that of guest frame-buffer, padding will be adde=
d<br>
=C2=A0 to the host window to preserve the aspect ratio of guest frame-buffe=
r.<br>
<br>
- scale: allow user to set a preferred scale factor, which would be<br>
=C2=A0 helpful for users running on a hi-dpi desktop to achieve pixel to<br=
>
=C2=A0 pixel display.<br>
<br>
Cc: BALATON Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.hu" target=3D"_bla=
nk">balaton@eik.bme.hu</a>&gt;<br>
Cc: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=3D"_blank=
">kraxel@redhat.com</a>&gt;<br>
Cc: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.co=
m" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
Cc: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@gmail.com=
" target=3D"_blank">marcandre.lureau@gmail.com</a>&gt;<br>
Cc: &quot;Kim, Dongwon&quot; &lt;<a href=3D"mailto:dongwon.kim@intel.com" t=
arget=3D"_blank">dongwon.kim@intel.com</a>&gt;<br>
Cc: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org" target=
=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
Cc: Dmitry Osipenko &lt;<a href=3D"mailto:dmitry.osipenko@collabora.com" ta=
rget=3D"_blank">dmitry.osipenko@collabora.com</a>&gt;<br></blockquote><div>=
<br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:ma=
rcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div>Te=
sted-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redh=
at.com">marcandre.lureau@redhat.com</a>&gt;=C2=A0</div><div><br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
<br>
Best regards,<br>
Weifeng<br>
<br>
Weifeng Liu (2):<br>
=C2=A0 ui/gtk: Add keep-aspect-ratio option<br>
=C2=A0 ui/gtk: Add scale option<br>
<br>
=C2=A0include/ui/gtk.h |=C2=A0 2 ++<br>
=C2=A0qapi/ui.json=C2=A0 =C2=A0 =C2=A0| 15 +++++++++----<br>
=C2=A0ui/gtk.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 58 ++++++++++++++++++++++=
++++++++++----------------<br>
=C2=A03 files changed, 52 insertions(+), 23 deletions(-)<br>
<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div></div>

--00000000000069b8d10636a69315--


