Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F8DC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 14:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpU1a-0000z7-R5; Wed, 27 Mar 2024 10:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rpU1V-0000yc-Qf
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 10:13:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rpU1R-00087S-Kz
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 10:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711548776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=32NsZvkpXH+LKxiQveFHB6foCUWRdIAJhKwT+VEiZGE=;
 b=UPjWCPZ8D3D5L2+YUHiwos/gnQ3cLdsEi87cBRkvD9enkwD5TD9iLjQ+WJNx7awQKMQiHL
 eIB8c8QC+41iyTuVP1293J3w4IPH24Pre16CrfOsYCJdD+LGxq9Nptjky+/odbcHyfZ84L
 /yXpANP/mPGrAZ/k3+0g13WJBdYOUCg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-vOmIQW1aPhW7a5XR5HC74Q-1; Wed, 27 Mar 2024 10:12:54 -0400
X-MC-Unique: vOmIQW1aPhW7a5XR5HC74Q-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-33ed44854ddso3607917f8f.2
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 07:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711548773; x=1712153573;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=32NsZvkpXH+LKxiQveFHB6foCUWRdIAJhKwT+VEiZGE=;
 b=bm2+AYZxuGfl3dGs5wvqi/lRqAzqv1TAdsEROsKWL5Lv4PTinyScGXwb7Z4V+bx08M
 X8OEcKChNk5SktNyaM9qzIFxg2osAGz1VFN5NMy0igCaYyXMQv2yH5Xln6U+qtVWuyJn
 D960I1QHwX1ZXiubT+5QwEq+PaErnWqbmtLNBJEdAM3XPQkLH3NJ2rAPH3ydvsaJlf9U
 DM7XOY+ndaXauMO+WXlJ/CxKcJ2HSKPa30Y0xKXmB92oa8jMru+o91vSoJggv+ds1yE1
 7Mqm0FmwDJgbZ/X3DJyn3UxG6CpSHcm4Y/SE+d1icH0E8ZUxnIcuzkjnBf/6jxQDDgDi
 soNA==
X-Gm-Message-State: AOJu0YxnT0ViZVhifNVTAr9NczVTkD4TrxvumUNbr9bKCp3arGvQ8vwE
 6jPTUZNyGHBNCtaTMSYEgPOOcqFBG6x91soz3E0f7BgQoI+Buvibtn3EFyMbUbCE0sIjZOi84GK
 mZXxvWPkJZDxgP65B5AmySf1IdROPOX/Xe49jHAMt3SHmqfjQjPdz17AOmC2x07qCyR8BKjVQR3
 L3rnw/Wm4zbTZexWiAewFOnlSMFlo=
X-Received: by 2002:a5d:5886:0:b0:33e:beca:65ef with SMTP id
 n6-20020a5d5886000000b0033ebeca65efmr71565wrf.2.1711548772910; 
 Wed, 27 Mar 2024 07:12:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0De9U9jYN+4es6zocRQK21LQIZb5/zvrOtmE6lnYTpcKdoN8FScZLykbGyl9A1ioIe5YMlcBSkYRiXfnBcec=
X-Received: by 2002:a5d:5886:0:b0:33e:beca:65ef with SMTP id
 n6-20020a5d5886000000b0033ebeca65efmr71546wrf.2.1711548772602; Wed, 27 Mar
 2024 07:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240326171009.26696-1-philmd@linaro.org>
 <20240326171009.26696-5-philmd@linaro.org>
 <8cf13d4d-0b1a-487a-8a7c-1aea4cb107c5@redhat.com>
 <5ceb0f8d-ef37-4b34-bcce-f4948d1b73ef@linaro.org>
In-Reply-To: <5ceb0f8d-ef37-4b34-bcce-f4948d1b73ef@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 27 Mar 2024 15:12:40 +0100
Message-ID: <CABgObfZv42tsWP5P7dUb5fntii2Edt66hOAhxbv2RxpRpBmvUg@mail.gmail.com>
Subject: Re: [PATCH-for-9.0? v2 4/4] meson: Enable -Wstatic-in-inline
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009b72840614a50041"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--0000000000009b72840614a50041
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 27 mar 2024, 13:42 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> h=
a
scritto:

> IIUC your comment, you are worried about system headers declaring
> non-static inline functions?
>

No, it's just that the flag (and thus the patch) is not doing what the
commit message says.

Perhaps you could instead add a checkpatch test that catches occurrences of
inline without static.

Paolo


> >
> > For now I'm queuing patches 1-3 only.
> >
> > Paolo
> >
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> >> Message-Id: <20240313184954.42513-5-philmd@linaro.org>
> >> Reviewed-by: Thomas Huth <thuth@redhat.com>
> >> ---
> >>   meson.build | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/meson.build b/meson.build
> >> index c9c3217ba4..f400f7d36c 100644
> >> --- a/meson.build
> >> +++ b/meson.build
> >> @@ -591,6 +591,7 @@ warn_flags =3D [
> >>     '-Wold-style-definition',
> >>     '-Wredundant-decls',
> >>     '-Wshadow=3Dlocal',
> >> +  '-Wstatic-in-inline',
> >>     '-Wstrict-prototypes',
> >>     '-Wtype-limits',
> >>     '-Wundef',
> >
>
>

--0000000000009b72840614a50041
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 27 mar 2024, 13:42 Philippe Mathieu-Daud=C3=A9 =
&lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>&gt; ha scrit=
to:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">IIUC your comment, you are worr=
ied about system headers declaring<br>
non-static inline functions?<br></blockquote></div></div><div dir=3D"auto">=
<br></div><div dir=3D"auto">No, it&#39;s just that the flag (and thus the p=
atch) is not doing what the commit message says.</div><div dir=3D"auto"><br=
></div><div dir=3D"auto">Perhaps you could instead add a checkpatch test th=
at catches occurrences of inline without static.</div><div dir=3D"auto"><br=
></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D=
"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; <br>
&gt; For now I&#39;m queuing patches 1-3 only.<br>
&gt; <br>
&gt; Paolo<br>
&gt; <br>
&gt;&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:p=
hilmd@linaro.org" target=3D"_blank" rel=3D"noreferrer">philmd@linaro.org</a=
>&gt;<br>
&gt;&gt; Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.hende=
rson@linaro.org" target=3D"_blank" rel=3D"noreferrer">richard.henderson@lin=
aro.org</a>&gt;<br>
&gt;&gt; Message-Id: &lt;<a href=3D"mailto:20240313184954.42513-5-philmd@li=
naro.org" target=3D"_blank" rel=3D"noreferrer">20240313184954.42513-5-philm=
d@linaro.org</a>&gt;<br>
&gt;&gt; Reviewed-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">thuth@redhat.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; =C2=A0 meson.build | 1 +<br>
&gt;&gt; =C2=A0 1 file changed, 1 insertion(+)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/meson.build b/meson.build<br>
&gt;&gt; index c9c3217ba4..f400f7d36c 100644<br>
&gt;&gt; --- a/meson.build<br>
&gt;&gt; +++ b/meson.build<br>
&gt;&gt; @@ -591,6 +591,7 @@ warn_flags =3D [<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 &#39;-Wold-style-definition&#39;,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 &#39;-Wredundant-decls&#39;,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 &#39;-Wshadow=3Dlocal&#39;,<br>
&gt;&gt; +=C2=A0 &#39;-Wstatic-in-inline&#39;,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 &#39;-Wstrict-prototypes&#39;,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 &#39;-Wtype-limits&#39;,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 &#39;-Wundef&#39;,<br>
&gt; <br>
<br>
</blockquote></div></div></div>

--0000000000009b72840614a50041--


