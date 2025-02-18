Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29B5C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 14:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkP0L-0006Ur-PS; Tue, 18 Feb 2025 09:55:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tkP0H-0006Uc-PJ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 09:55:17 -0500
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tkP0F-00035f-0G
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 09:55:17 -0500
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-4be625c5365so615869137.2
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 06:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1739890512; x=1740495312;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hMiy2UFMzUkGmLu1KGYV/EwwK9kZERQBJ1K+sJAQkfI=;
 b=jChTy/jo9ROWlG0ATcnjv5LYpJvVt9RF346rkIX7PM7jUGylJHT+4XWYlBhVCCSqKo
 DC1nHZ9BM+U35YeJGPYa5BLXfTynb+rCOPNbXhc9CjdNJbk9avX+AJIZY8ov8hcZHJwu
 BeLGDgjS6vYfrCivRJl0Q+naLa3A9YioqBswRqWGkUMMBwX//s24PR2U+tnVvVG1h9oA
 t/ywwJVlCNoLFeOvXWUEbuhfAFws3KgMlQ4JjVUgNHmaGehpNV405jQ1nTLfLij38NDM
 AWGR0F9aDc+QFLlZHZOBYnulMWjiZnJF8V6gJ4q6GogIWR12v0pkaPN0/JptM+ExoYpU
 Cybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739890512; x=1740495312;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hMiy2UFMzUkGmLu1KGYV/EwwK9kZERQBJ1K+sJAQkfI=;
 b=asTsPu0DcbtubIN72zNipEP6YaMRnKAUOl5oQ/PayxiXgrSCYNoThArQVn9h1Z3Q2T
 V8T2T3y/AH7LXw5y1oNGTqfT+VYBDaGSP7QU1J3YRwqbLpSXSz3jfOVSMPBwLISl+8gJ
 xb3A28iliwlx6rrnfdtR+bHv4IjFjYTvDTp1nh1+4JUQvb3nSuqVXZd/1rVLKO6Wqbb6
 UVML6zs5GG2wj5uGfz9jcVgqSqcs2FevSbZ5F6FRoHl7CH/B5T2vsWnEx/uq2LJkhLmR
 M7eChYSopeaUQXYbxKMWy1ICEWbpTqZj8/2eyr4wF3yOS/9StCzIrxoUmh5pnVWYz4Ru
 7A6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXihw5HZ5VPHP7ZWHvH+4sTLUq0EE1VreZCCGJMcN/r5GEP3T6wODMJGq3ID0nCZz7M8yCG8n7rqv+Y@nongnu.org
X-Gm-Message-State: AOJu0Yw57bXa2/+c567yT905Sw6l7HNpG+fxNuaWvhDJ/70cHgOREpAZ
 iby1o5EqLYknxaeI4mM6XfX0lXyGtrq0r2i4Y6Vur40APslaWElV0RzmZL5Urn8v/BJ84fgT6t4
 3QDbirjLpVEw/MiDsg8MkvBFImWrr/0oVYbYl
X-Gm-Gg: ASbGncsH6oc7e5BG6wBMxCPkShSg2j8Ei7/cdadlrZAviFGu5s6w4rzHqPNrTxHkefs
 IAyy0ypR2825djUNbPdaMLp/TgrihpSb0ZmachMArJsZWliGwqE9dVgG57ZXIHTdKrQJOp/aa
X-Google-Smtp-Source: AGHT+IHY2W1hH0I6Bxfo1LXqzilRr/FMyNri5b7qmwD5SuCmFuHtiy8gvGXBODghAr1XWEmsCUc50tdjuJKSOnmEIvQ=
X-Received: by 2002:a05:6102:290a:b0:4b9:bc52:e050 with SMTP id
 ada2fe7eead31-4bd3fc66f5cmr7755967137.2.1739890512608; Tue, 18 Feb 2025
 06:55:12 -0800 (PST)
MIME-Version: 1.0
References: <20250212112958.38023-1-philmd@linaro.org>
 <c33817a1-74d4-47b0-93d3-000cfd6200be@redhat.com>
In-Reply-To: <c33817a1-74d4-47b0-93d3-000cfd6200be@redhat.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Tue, 18 Feb 2025 15:55:01 +0100
X-Gm-Features: AWEUYZnfCrWFV3dXwom-xuAH5qCr6xrkbsdOWtc07P-dBYFaJyqdAUgRjiqqJXs
Message-ID: <CAAibmn2Ohd_-k5LGqo5m1xzLrrs2UYxCT6U_XEKsJYScfCpx6g@mail.gmail.com>
Subject: Re: [PATCH] meson: Display summary of Darwin libraries detected
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000f3d96d062e6bd3dd"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::e29;
 envelope-from=phil@philjordan.eu; helo=mail-vs1-xe29.google.com
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

--000000000000f3d96d062e6bd3dd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Feb 2025 at 19:37, Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 2/12/25 12:29, Philippe Mathieu-Daud=C3=A9 wrote:
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > ---
> >   meson.build | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >
> > diff --git a/meson.build b/meson.build
> > index 18cf9e2913b..10f4c9fd30d 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -4826,6 +4826,13 @@ summary_info +=3D {'libdw':             libdw}
> >   if host_os =3D=3D 'freebsd'
> >     summary_info +=3D {'libinotify-kqueue': inotify}
> >   endif
> > +if host_os =3D=3D 'darwin'
> > +  summary_info +=3D {'Hypervisor support': hvf}
> > +  summary_info +=3D {'CoreFoundation support': coref}
> > +  summary_info +=3D {'IOKit support': iokit}
> > +  summary_info +=3D {'ParavirtualizedGraphics support': pvg}
> > +  summary_info +=3D {'Metal support': metal}
> > +endif
> I think all of these are going to be present anyway, because they're
> mandatory (except IOKit which _is_ going to be there, and HVF which is
> present elsewhere) and there's no version indication for Apple frameworks=
.


Realistically, all of these are always present on supported Darwin versions=
.


> However, adding pvg and metal here makes sense if:
>
> - "config PVG" is added to Kconfig.host with the corresponding
> assignment to host_kconfig
>
> - "depends on PVG" is added to "config MAC_PVG"
>
> - after which, host_os =3D "darwin" is not needed anymore in
> hw/display/meson.build
>
> Also, it's not clear to me if PVG can also work with TCG, and therefore
> the MMIO version can be used on x86 Macs?  If so the 'if cpu =3D
> "aarch64"' in hw/display/meson.build seems wrong.


This bit I can answer.
PVG is not in any way tied to HVF and so can be used with TCG.
HOWEVER
It is not cross-architecture. So, the PVG guest drivers with x86-64 macOS
don't give useful results with the aarch64 macOS host PVG framework. (I
suspect a mismatch in texture memory layout and perhaps some other data
format issues - Apple's GPUs use a "swizzled" memory layout, whereas
Intel/AMD/NVIDIA's do not.)

Additionally, the MMIO variant in particular uses the IOSurfaceMapper APIs
(PGIOSurfaceHostDevice, PGIOSurfaceHostDeviceDescriptor,
usingIOSurfaceMapper) which are only present in the aarch64 version of the
host ParavirtualizedGraphics.framework.

In summary, hw/display/apple-gfx-mmio.m has a hard dependency on aarch64
*host* systems, and both apple-gfx device variants only make sense when
host arch matches guest arch. (Unless you're a developer attempting to find
a workaround to the incompatibility.)

I'm very much not a Meson expert, so this was my best attempt at encoding
these facts in the build system. (And nobody suggested anything better
during review.)


> Either way, the Kconfig file does not need "depends on AARCH64" and it
> should have just
>
>      depends on MAC_PVG
>
> with an "imply" somewhere in hw/arm/Kconfig.
>
> Paolo
>
>
Phil

--000000000000f3d96d062e6bd3dd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 17 Feb =
2025 at 19:37, Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbo=
nzini@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">On 2/12/25 12:29, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt; Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philm=
d@linaro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0meson.build | 7 +++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 7 insertions(+)<br>
&gt; <br>
&gt; diff --git a/meson.build b/meson.build<br>
&gt; index 18cf9e2913b..10f4c9fd30d 100644<br>
&gt; --- a/meson.build<br>
&gt; +++ b/meson.build<br>
&gt; @@ -4826,6 +4826,13 @@ summary_info +=3D {&#39;libdw&#39;:=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0libdw}<br>
&gt;=C2=A0 =C2=A0if host_os =3D=3D &#39;freebsd&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0summary_info +=3D {&#39;libinotify-kqueue&#39;: ino=
tify}<br>
&gt;=C2=A0 =C2=A0endif<br>
&gt; +if host_os =3D=3D &#39;darwin&#39;<br>
&gt; +=C2=A0 summary_info +=3D {&#39;Hypervisor support&#39;: hvf}<br>
&gt; +=C2=A0 summary_info +=3D {&#39;CoreFoundation support&#39;: coref}<br=
>
&gt; +=C2=A0 summary_info +=3D {&#39;IOKit support&#39;: iokit}<br>
&gt; +=C2=A0 summary_info +=3D {&#39;ParavirtualizedGraphics support&#39;: =
pvg}<br>
&gt; +=C2=A0 summary_info +=3D {&#39;Metal support&#39;: metal}<br>
&gt; +endif<br>
I think all of these are going to be present anyway, because they&#39;re <b=
r>
mandatory (except IOKit which _is_ going to be there, and HVF which is <br>
present elsewhere) and there&#39;s no version indication for Apple framewor=
ks.</blockquote><div><br></div><div>Realistically, all of these are always =
present on supported Darwin versions.</div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
However, adding pvg and metal here makes sense if:<br>
<br>
- &quot;config PVG&quot; is added to Kconfig.host with the corresponding <b=
r>
assignment to host_kconfig<br>
<br>
- &quot;depends on PVG&quot; is added to &quot;config MAC_PVG&quot;<br>
<br>
- after which, host_os =3D &quot;darwin&quot; is not needed anymore in <br>
hw/display/meson.build<br>
<br>
Also, it&#39;s not clear to me if PVG can also work with TCG, and therefore=
 <br>
the MMIO version can be used on x86 Macs?=C2=A0 If so the &#39;if cpu =3D <=
br>
&quot;aarch64&quot;&#39; in hw/display/meson.build seems wrong.</blockquote=
><div><br></div><div>This bit I can answer.</div><div>PVG is not in any way=
 tied to HVF and so can be used with TCG. <br></div><div>HOWEVER</div><div>=
It is not cross-architecture. So, the PVG guest drivers with x86-64 macOS d=
on&#39;t give useful results with the aarch64 macOS host PVG framework. (I =
suspect a mismatch in texture memory layout and perhaps some other data for=
mat issues - Apple&#39;s GPUs use a &quot;swizzled&quot; memory layout, whe=
reas Intel/AMD/NVIDIA&#39;s do not.)</div><div><br></div><div>Additionally,=
 the MMIO variant in particular uses the IOSurfaceMapper APIs (PGIOSurfaceH=
ostDevice, PGIOSurfaceHostDeviceDescriptor, usingIOSurfaceMapper) which are=
 only present in the aarch64 version of the host ParavirtualizedGraphics.fr=
amework.</div><div><br></div><div>In summary, hw/display/apple-gfx-mmio.m h=
as a hard dependency on aarch64 *host* systems, and both apple-gfx device v=
ariants only make sense when host arch matches guest arch. (Unless you&#39;=
re a developer attempting to find a workaround to the incompatibility.)</di=
v><div><br></div><div>I&#39;m very much not a Meson expert, so this was my =
best attempt at encoding these facts in the build system. (And nobody sugge=
sted anything better during review.)</div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
Either way, the Kconfig file does not need &quot;depends on AARCH64&quot; a=
nd it <br>
should have just<br>
<br>
=C2=A0 =C2=A0 =C2=A0depends on MAC_PVG<br>
<br>
with an &quot;imply&quot; somewhere in hw/arm/Kconfig.<br>
<br>
Paolo<br>
<br></blockquote><div><br></div><div>Phil <br></div></div></div>

--000000000000f3d96d062e6bd3dd--

