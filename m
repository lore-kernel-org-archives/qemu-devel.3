Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7093FE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 11:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKyPz-0002SN-U2; Tue, 10 Dec 2024 06:28:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKyPy-0002S0-CJ
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 06:28:42 -0500
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKyPw-00049i-2J
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 06:28:42 -0500
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-85c5d4f3d58so545517241.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 03:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1733830118; x=1734434918;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G2upt/6XfG8rRb+ORZkYBYsjF0vMgvUCoDjhiPvvgFI=;
 b=FYH5RRspBX8erai/lwJtS2KXqWICby55SEXN4gZqA09UJw61aaLGEuD/x3zr/07M/z
 ph8ecbeSUowTtd5/L8viFiZHoU+pvLyWmSy1TsOwRUv9snl+Dh6iF03czg0EXwCbpIFl
 BMfcmLEN+6MIfP70f3e9UbTCyBwr5+8esyrTgDZZHJp8mU8E5gLHNb1WRFhd8w5arnjC
 zCxNFf0QodxutOoSBG+Uh/81hMGLFe+5Ly2oitSVxUw6GyMe5J4KcztNOuwF8vDMQ/1y
 6gkL+yh+fcO8R/aHaPcTpPAtyOfhCTRC6vdCH/BmNBripNmADNUGoD70dhh8B9ZxWhZK
 4Tyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733830118; x=1734434918;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G2upt/6XfG8rRb+ORZkYBYsjF0vMgvUCoDjhiPvvgFI=;
 b=T1zidLvkHRofghzZbV/yzviPql6KQ/SOJLvfc0sAAzIy9JdEWuy/w3U/Ih9m5pn20z
 dlBjFiaBDnuNkr/0DhWkWZFJofVUJe+zI+IPRyT+BiRpAFutmvtEKYapYVKW6Uv0goPZ
 HQi/Y0fYFiNxlhvyGYyRaL+f6Jo58bZ4lF5sAVIJiZu3lH5zGdF2on03H4IVsXVf4KvM
 2YCArlgCzP8rqMKNSPQnGxiOI60392Ja6uqsvJgC9X6ovGtokrbrcgacHaB0SDYgM2ZX
 E4ZWKQFcdOD/b4m/rTQGzS9HyWctxCjtY332NDzZNygkiX+riyy6EuWzgNIHsUDOIhkq
 NwhA==
X-Gm-Message-State: AOJu0YzW615K7bADBXqpA8NoLYA2VkhVfazeZPMX/nZ/jsDAfhoHRAh9
 Zj3SO8HDmctAugeEqAK/eikEGk6L4BKcVQjvCLcstgrAIvhpI9Y6Qcxn0JZN/r1zfFD3slwFiTk
 y74JJKYpxLh+FBHyrOAbP03UxVWkdeTlONPE6
X-Gm-Gg: ASbGncu+Qa4fJ0Km5FxPfYVNecHEsFNIVYixkXZOPUx6LTJI9m1CJHyd1Aav2b0dsHn
 SwiaJeWdHFKtQusQIezjRyzVWguM4NBubl6I=
X-Google-Smtp-Source: AGHT+IF5CWsEDxHnvBmWFX3nqQaHx9Kmu59Tjyf8MdGQpzOFPp7S6BekbpVLZ/i+DozVO1k9dXaqIGT3br8MWWTfUl4=
X-Received: by 2002:a05:6102:c04:b0:4af:e61d:e228 with SMTP id
 ada2fe7eead31-4b1160c2a31mr4063814137.6.1733830118625; Tue, 10 Dec 2024
 03:28:38 -0800 (PST)
MIME-Version: 1.0
References: <20241209203629.74436-1-phil@philjordan.eu>
 <20241209203629.74436-10-phil@philjordan.eu>
 <3d0d87b8-d86f-4411-b1dd-7e825ec237e4@linaro.org>
In-Reply-To: <3d0d87b8-d86f-4411-b1dd-7e825ec237e4@linaro.org>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Tue, 10 Dec 2024 12:28:27 +0100
Message-ID: <CAAibmn2ijkbOqy-oD9F_50N4WBHQ77JadenvDfFHtREv_ReUSw@mail.gmail.com>
Subject: Re: [PATCH 09/11] i386/hvf: Print hex pairs for each opcode byte in
 decode error
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000529baa0628e8c8be"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::92e;
 envelope-from=phil@philjordan.eu; helo=mail-ua1-x92e.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--000000000000529baa0628e8c8be
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Dec 2024 at 21:54, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
>
wrote:

> On 9/12/24 21:36, phil@philjordan.eu wrote:
> > From: Phil Dennis-Jordan <phil@philjordan.eu>
> >
> > Printing a sequence of bytes as hex with leading zeroes omitted just
> looks odd.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> >
> > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> > ---
> >   target/i386/hvf/x86_decode.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.=
c
> > index 6c7cfc820f..f8d37f2d53 100644
> > --- a/target/i386/hvf/x86_decode.c
> > +++ b/target/i386/hvf/x86_decode.c
> > @@ -30,7 +30,7 @@ static void decode_invalid(CPUX86State *env, struct
> x86_decode *decode)
> >   {
> >       printf("%llx: failed to decode instruction ", env->eip);
> >       for (int i =3D 0; i < decode->opcode_len; i++) {
> > -        printf("%x ", decode->opcode[i]);
> > +        printf("%02x ", decode->opcode[i]);
> >       }
> >       printf("\n");
>
> Maybe we should use monitor_printf() here?
>

Or perhaps snprintf it into a buffer, then change this=E2=80=A6


> >       VM_PANIC("decoder failed\n");
>
>
=E2=80=A6 to a VM_PANIC_EX() that also writes out the opcode buffer?

--000000000000529baa0628e8c8be
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 9 Dec 2=
024 at 21:54, Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lina=
ro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">On 9/12/24 21:36, <a href=3D"mailto:phil@philjorda=
n.eu" target=3D"_blank">phil@philjordan.eu</a> wrote:<br>
&gt; From: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjordan.eu" tar=
get=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt; <br>
&gt; Printing a sequence of bytes as hex with leading zeroes omitted just l=
ooks odd.<br>
<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linar=
o.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
<br>
&gt; <br>
&gt; Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjorda=
n.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/i386/hvf/x86_decode.c | 2 +-<br>
&gt;=C2=A0 =C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode=
.c<br>
&gt; index 6c7cfc820f..f8d37f2d53 100644<br>
&gt; --- a/target/i386/hvf/x86_decode.c<br>
&gt; +++ b/target/i386/hvf/x86_decode.c<br>
&gt; @@ -30,7 +30,7 @@ static void decode_invalid(CPUX86State *env, struct =
x86_decode *decode)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;%llx: failed to decode instruct=
ion &quot;, env-&gt;eip);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0for (int i =3D 0; i &lt; decode-&gt;opcode_l=
en; i++) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;%x &quot;, decode-&gt;opcode=
[i]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf(&quot;%02x &quot;, decode-&gt;opco=
de[i]);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;\n&quot;);<br>
<br>
Maybe we should use monitor_printf() here?<br></blockquote><div><br></div><=
div>Or perhaps snprintf it into a buffer, then change this=E2=80=A6 <br></d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0VM_PANIC(&quot;decoder failed\n&quot;);<br>
<br></blockquote><div>=C2=A0</div><div>=E2=80=A6 to a VM_PANIC_EX() that al=
so writes out the opcode buffer?<br></div></div></div>

--000000000000529baa0628e8c8be--

