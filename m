Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59166606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w7P0a5II
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVPEI-0007kP-79; Mon, 23 Nov 2026 03:16:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nagendranjairam52@gmail.com>)
 id 1xVPED-0007ig-EG
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 03:16:45 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nagendranjairam52@gmail.com>)
 id 1xVPEB-0000DF-JK
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 03:16:45 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-8b4cd576f2aso21387617b3.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 00:16:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795421802; cv=none;
 d=google.com; s=arc-20260327;
 b=liUbtBjunJWY9FQx+wqL4qbjbEnuy8w/a8gsI9mA02hdtKEATOctb74Xhj9pKG5YY3
 +z28YvC1t9W0VOWDeAWF4Ewws5d1axT9Lu0zXCVrLn7suz1i8pFOF6lGkf3qpjyQK3fF
 K9gfnw0KHPrlQlirNTKoPPoYTALpcFw1wcCS65TDfLCe0wgAdiR7xv1FB2+brB+3jBC9
 hJOeLTqwOgHL/IUrhe9UnfQmQJbVNhQBmsvPTtCdBsWptYt0irRIjj3PH93nNjYh2wDA
 G+qdb1kyfS+1qdkgnZr0Cqg1e8Cg6t1JG612bJfx0hD2XH6Y8IskocdLrX68E3sDmg1k
 Wfag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gUsh37zv8H8b1mNf1j9zSiZIWwYFvskqxdvPHTzxmfk=;
 fh=8QWttMrzmuARFy/U3fonnqfvTPeb6E70uxILEnYTbgA=;
 b=RSM2MXfScfMYQVrVHqqSG/wvQMdE96kUKj+SDgtKvWw02r0n72zXBjeq+2eRbF2znn
 SSRpdX2k0QhbUF7zlDY1qHWeSy0YvfwPoRIvJ0PePE65rL8Ra16h/qYSBIUWlhpMoMte
 a02Tqy61GcY05v+YQH9qPL2dIBQGz2CFqp7UQABiBqhlYmhdtBtMKhNsjM7tWvW2qVRx
 roHqTc/wf92J0sq//WRRQuCwGvRKQfwJfXrliP1e7GA/10F8RGTqq3Cc53tbpW7TrDQY
 wYNSlJn+LnxBum7dmve9tOM0n8r/tll8iG4sb/FShvDu7asDLpkQ0kh522GMJRl3o79w
 2ALw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795421802; x=1796026602; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gUsh37zv8H8b1mNf1j9zSiZIWwYFvskqxdvPHTzxmfk=;
 b=w7P0a5IIKVMGBsNSU62UnyK38dVF8t5NUXN0kMNg25wqMMcPW77Y0XXwG0hKNnwxhk
 mnbWPAteEzXn4uhCxycp13V5Ppn4AM8B68QVHa+jUowmaHwhfyU10ZsQJ5P5u2IkzS5z
 wXWU50A0bhCqPRYZKyUO8QZ8RihNhIaUGU0pztgA7JJ1gE6U+sBHmmrUYi/z2ulbh8ax
 n4GtTaPOY9OrEcoxu+I6XcNfrOQsWKAZptreb7jQ5Fj3KEZPiLG8gn9+q1M9x/HU57Hh
 opeAfNkR5U0v5eV8pAgz3diyGtDscOEYc21vn3U4GNRz6Y+VTKls/jLDyhUpxsydL2Ko
 9sFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795421802; x=1796026602;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gUsh37zv8H8b1mNf1j9zSiZIWwYFvskqxdvPHTzxmfk=;
 b=dN7Wp2RKNFe7apP3R//pny0Lr7HLGqmCtCOtW5WA4vcy/rfO7ojK4ALqvnwbH/vpT6
 OVxmxZKjkjQIw3+be5oTpRf796BMWihEX8WHot+n5YM/sOQwmq7EkB4yKsmv5C4NMe87
 6YshSqd7yV2L4bkzrhGhdidzxi1K8Zv+HB1jD2GsvR9aYArtWvBGrJOmpjKGdFrZYPzy
 UTM8NOXCM/fqb1qwsEC/mSm1SmuymFUSRhs00VIS2y0yOEG9IbOtFDhObqtZUgmUldYN
 Bg9kQWldCp5nXiAN1yr7FdhwxWBg0nBQqR0oKKymH1uaNQ49Wc2D85aTQ5VPRjRkkgoD
 0Mnw==
X-Gm-Message-State: APuU4Z+2SV3T4bH3tAFtu6fmDPTYca3xF+CijRA5s9z2omaOPRV4i0ze
 XSNjPLJnM2NPzpbFYv8zPcxBFU9hmzLAq76Mh6Hnu0yjTsirrHIonPsQx06T3YGPq8Ucs+kNVVx
 MXxRY+OLRfDNP9cGesP+W7kfM/tZnkNI=
X-Gm-Gg: AZFdTZcRACsT9wTpNe6Npv8X2Mwo8IlYddjos94wC9sCq3safQqcz/AOXPSre94aw7c
 JQG2vu18mRng3F6KwMgmHuEizDvCScykP06G7BB3YFYVDDxVt3yoyZ21ogqhWm725asE2PG+cxo
 7U4S030V4IuWVJHS5DtWOT+62AqT6GFIe5Ymuj3XYTZ++AYRGnmyv1IP6qZhXCo1LitmGxB0No2
 Ey6t2uNsIKgAWYoPl7ZtUqvk6IhBoIoRJENnw2GQpBc99mE/EhNRkANPk9AS2lbZYMW+IHCgjoc
 6XNdFFfCP0HR8rQQHoOhJnTGR0Htb0f0tzWLs7UZs3n12PwHbieeYRnHhV7z5258aIZpICzqXOA
 7ja52HUwAa586e3kSTY7ZS5mxbXXuzn9jwxaZrB75U2QtoD+8in7KhEVGIFsDVhBpjKpJjgVJWQ
 ==
X-Received: by 2002:a05:690c:290:b0:8b5:6c1:e363 with SMTP id
 00721157ae682-8b52031c307mr36056637b3.9.1795421801956; Mon, 23 Nov 2026
 00:16:41 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261112184949.1042-1-nagendranjairam52@gmail.com>
 <87ik1r673b.fsf@draig.linaro.org>
 <CAEAkEp7jbv=uZS61Yd6V-zfNr6cp-MjgHBStC08ft3qROfE2bA@mail.gmail.com>
 <87cxrz5ylw.fsf@draig.linaro.org>
In-Reply-To: <87cxrz5ylw.fsf@draig.linaro.org>
From: Nagendran Jairam <nagendranjairam52@gmail.com>
Date: Mon, 23 Nov 2026 13:46:30 +0530
X-Gm-Features: Aa3M54oJ7TYAbmyW7Fnjnmoob39_Li7tMTN6R75RnowEXGbSsk095gj8ZY6fkos
Message-ID: <CAEAkEp51T7DH1LEsvvnsf6rKYXQx7b-hC-HmDt9BRxezXJLekw@mail.gmail.com>
Subject: Re: [PATCH v3] hw/core/loader.c: Add Extended Tektronix HEX file
 support
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 philmd@linaro.org, daan.j.demeyer@gmail.com, peter.maydell@linaro.org, 
 Alistair <alistair@alistair23.me>
Content-Type: multipart/alternative; boundary="000000000000ba49de0660ed366a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=nagendranjairam52@gmail.com; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000ba49de0660ed366a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026, 20:39 Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote=
:

> Nagendran Jairam <nagendranjairam52@gmail.com> writes:
>
> > On Fri, Nov 20, 2026, 17:35 Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
> >
> >  Nagendran K <nagendranjairam52@gmail.com> writes:
> >
> >  > Add support for loading Extended Tektronix HEX files through the
> >  > generic loader.
> >  >
> >  > The loader parses Extended Tektronix records, validates their
> >  > checksums, and loads the data at the addresses specified in the file=
.
> >  >
> >  > This allows Extended Tektronix files to be loaded directly without
> >  > manual conversion to another supported format.
> >  >
> >  > Tested by loading an Extended Tektronix file containing a simple UAR=
T
> >  > application on the RealView EB machine. The application executed
> >  > successfully and produced the expected UART output.
> >  >
> >  > Signed-off-by: Nagendran K <nagendranjairam52@gmail.com>
> >
> >  Ok before you send another version you should consider:
> >
> >    - split whitespace and comment updates into their own patches
> >    - include a test case for the loader to show its use
> >    - verify the whole series applies and builds cleanly on upstream's
> master branch
> >
> >  And the cover letter for the series should also include what changes
> >  you've made between each iteration. You can also include a summary of
> >  updates under the --- in the commit messages.
> >
> >  --
> >  Alex Benn=C3=A9e
> >  Virtualisation Tech Lead @ Linaro
> >
> >    Ok sure, but where do I upload cover letter and testcase means the
> baremetal build through which I tested or just overall summary
> > of how did I test?
>
> The cover letter is part of a multi-patch series, there is tooling you
> can use to help prepare a series:
>
>
> https://www.qemu.org/docs/master/devel/submitting-a-patch.html#submitting=
-your-patches
>
> For the testcase you can either publish a binary asset somewhere and
> write a functional test:
>
>   https://www.qemu.org/docs/master/devel/testing/functional.html
>
> Or work out how to build one of the tcg tests and package it up as a hex
> file and add a run to test it.
>
> >      Nagendran

--=20
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

       Sure Alex , I will check all these and let you know

>

--000000000000ba49de0660ed366a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Nov 20, 2026, 20:39 Alex=
 Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@lina=
ro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Nagendran Jai=
ram &lt;<a href=3D"mailto:nagendranjairam52@gmail.com" target=3D"_blank" re=
l=3D"noreferrer">nagendranjairam52@gmail.com</a>&gt; writes:<br>
<br>
&gt; On Fri, Nov 20, 2026, 17:35 Alex Benn=C3=A9e &lt;<a href=3D"mailto:ale=
x.bennee@linaro.org" target=3D"_blank" rel=3D"noreferrer">alex.bennee@linar=
o.org</a>&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 Nagendran K &lt;<a href=3D"mailto:nagendranjairam52@gmail.com" t=
arget=3D"_blank" rel=3D"noreferrer">nagendranjairam52@gmail.com</a>&gt; wri=
tes:<br>
&gt;<br>
&gt;=C2=A0 &gt; Add support for loading Extended Tektronix HEX files throug=
h the<br>
&gt;=C2=A0 &gt; generic loader.<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; The loader parses Extended Tektronix records, validates the=
ir<br>
&gt;=C2=A0 &gt; checksums, and loads the data at the addresses specified in=
 the file.<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; This allows Extended Tektronix files to be loaded directly =
without<br>
&gt;=C2=A0 &gt; manual conversion to another supported format.<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; Tested by loading an Extended Tektronix file containing a s=
imple UART<br>
&gt;=C2=A0 &gt; application on the RealView EB machine. The application exe=
cuted<br>
&gt;=C2=A0 &gt; successfully and produced the expected UART output.<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; Signed-off-by: Nagendran K &lt;<a href=3D"mailto:nagendranj=
airam52@gmail.com" target=3D"_blank" rel=3D"noreferrer">nagendranjairam52@g=
mail.com</a>&gt;<br>
&gt;<br>
&gt;=C2=A0 Ok before you send another version you should consider:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 - split whitespace and comment updates into their own pat=
ches<br>
&gt;=C2=A0 =C2=A0 - include a test case for the loader to show its use<br>
&gt;=C2=A0 =C2=A0 - verify the whole series applies and builds cleanly on u=
pstream&#39;s master branch<br>
&gt;<br>
&gt;=C2=A0 And the cover letter for the series should also include what cha=
nges<br>
&gt;=C2=A0 you&#39;ve made between each iteration. You can also include a s=
ummary of<br>
&gt;=C2=A0 updates under the --- in the commit messages.<br>
&gt;<br>
&gt;=C2=A0 -- <br>
&gt;=C2=A0 Alex Benn=C3=A9e<br>
&gt;=C2=A0 Virtualisation Tech Lead @ Linaro<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 Ok sure, but where do I upload cover letter and testcase =
means the baremetal build through which I tested or just overall summary<br=
>
&gt; of how did I test?<br>
<br>
The cover letter is part of a multi-patch series, there is tooling you<br>
can use to help prepare a series:<br>
<br>
=C2=A0 <a href=3D"https://www.qemu.org/docs/master/devel/submitting-a-patch=
.html#submitting-your-patches" rel=3D"noreferrer noreferrer" target=3D"_bla=
nk">https://www.qemu.org/docs/master/devel/submitting-a-patch.html#submitti=
ng-your-patches</a><br>
<br>
For the testcase you can either publish a binary asset somewhere and<br>
write a functional test:<br>
<br>
=C2=A0 <a href=3D"https://www.qemu.org/docs/master/devel/testing/functional=
.html" rel=3D"noreferrer noreferrer" target=3D"_blank">https://www.qemu.org=
/docs/master/devel/testing/functional.html</a><br>
<br>
Or work out how to build one of the tcg tests and package it up as a hex<br=
>
file and add a run to test it.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Nagendran</blockquote></div></div><div dir=3D"auto=
"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br></blockquote></div></div><div dir=3D"a=
uto">=C2=A0 =C2=A0</div><div dir=3D"auto">=C2=A0 =C2=A0 =C2=A0 =C2=A0Sure A=
lex , I will check all these and let you know</div><div dir=3D"auto"><div c=
lass=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000ba49de0660ed366a--

