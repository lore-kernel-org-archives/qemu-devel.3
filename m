Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3810BC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 14:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuu0e-0007I3-UX; Wed, 19 Mar 2025 10:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1tuu0T-0007GF-J9
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 10:02:55 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1tuu0R-0002D2-54
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 10:02:53 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ac2963dc379so1174855466b.2
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 07:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742392969; x=1742997769; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g++NwTNLYw0tJM1CVQEC3T6E2GWFOEjBYJSUaFvkaEA=;
 b=CLdTupa1OPHSLShdBocqX7NRE3qlSvbX1CS7lkwUcfyZAbQujxlpWbGCvhussJ3H7C
 okU7AAO4TmvQtSG1lXBiJslBOywXbljYdhL7wGW6qOFGjmc8Cyxir/i+JNBbKJakbciS
 KqhlQ/WaGWHNQRTQWhpl2P62mCzFS3h1uPJlru+zIhb+qMxUlK54C9TPLfXcA356CVDl
 EzOSmcfI4jPztusp5PCFFxnysrI2Dt5uDyLsJP/WBEG9x3yUM1lW5Hx1iUMtQI24HwcP
 5Pe/gmRkMKg6aPkxgOmJXf+PBbWJ67RMJj/sdBbAytmvTJ5N0+DEIepEi/DetPq08i8X
 /csQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742392969; x=1742997769;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g++NwTNLYw0tJM1CVQEC3T6E2GWFOEjBYJSUaFvkaEA=;
 b=j6SDdOZNRyVUntNFnBDhzx8ixtQOtFEKTtTtPsQJic5NCrL6KpCkZz/4tbx9EHOWRZ
 97EQb9eaSB77Njseux38GjSPOin4GbwbiOzkNX2UaNjRGUNGPHLeUX9pmEbqXRwjs3n5
 znIPTaZ5xm6P1LYu+exHwj7cONW2tLoLbQbx1meZ7R76QNpWaHrri41oFHLF+sK9QT1Z
 O0+BBtseYGYfD3YpdNSYfQz4bujGQyxrtbOccgNxhfoy4V9pg3QS9NSZg45ZCLGMjBaD
 ADlKiWWODQm19KITxrQB/l1FmITqCLrQ/atewFtZb6+7EW9kkS9QVOaaqMqArG8WsUyD
 eCsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0X1BAtu43lkfuf4bU1DJIu5OaaxoBRnbzs8QmkiPlMTsII++dWXe6iELS2W98ott4JTzLWk6XztYk@nongnu.org
X-Gm-Message-State: AOJu0Ywleum2jbV8s+gcebdDvi/HlKtkJe6FGLm7ego8A7SZYhnlawXy
 U8u4llSoDRex/671JYuurjKeo5CrN6RB0uGPd8fCBM9Fq5Da5xNPdq7WAmAtqXzTjn7cwpexGFc
 O0ecFYaWLpBqayjwPHetEURNrxelbkQ9S
X-Gm-Gg: ASbGnctD6KvN1oLCB8zmMVkvy83tW0pvLCUZkE0latZn1fFmf1xBeDyW/pQ/APx6wEd
 vXmM3YBuQjJkXRuuWKmRNlx0Q94kxjuiE1P0rJHG8A62GEgwexUvw94U0Lhx2XeteywIla0MZg2
 tA0tLW7rdVjHsoVNvGLZbsA1Lq9SvChpb0lpYAjgq2dY5vCynsDQ00IrSykvuO
X-Google-Smtp-Source: AGHT+IGIybd83wcHmZ5wY6zV9p03KeWTRnRRNAaHpBB6U4+kdQlZKRYaWrEMylgQfoneMpqJBmahNodl7h8T8af67Hs=
X-Received: by 2002:a17:906:ee89:b0:abe:f48c:bcd with SMTP id
 a640c23a62f3a-ac3b7f78b4bmr265732866b.50.1742392968760; Wed, 19 Mar 2025
 07:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250319023036.71493-1-tanishdesai37@gmail.com>
 <CAFEAcA80b54NZUxPv_QoXQXakTwEuRvK-hxy==c=-PEB2dB3sg@mail.gmail.com>
 <954c3f61-f338-45e3-9f23-b45cef5c81e2@linaro.org>
In-Reply-To: <954c3f61-f338-45e3-9f23-b45cef5c81e2@linaro.org>
From: Tanish Desai <tanishdesai37@gmail.com>
Date: Wed, 19 Mar 2025 19:32:37 +0530
X-Gm-Features: AQ5f1JoiGAl0jOq3qYXxEJrJJKMo6SVEsCPkf41vddSt2UPXRDcOZcb03tsuJt8
Message-ID: <CAH_Y1jeG4msDoRMrsG+v=3Mx4Lrv_znTM_0FJVMDOean16pRiw@mail.gmail.com>
Subject: Re: [PATCH] Fix duplicate symbol error on MacOS build
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f67b8c0630b279c5"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=tanishdesai37@gmail.com; helo=mail-ej1-x62f.google.com
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

--000000000000f67b8c0630b279c5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It will work for PL011 but there are other devices using the same method
for selecting rust or c++ file like HPET in timer.
You can check this:-
https://github.com/qemu/qemu/blob/master/hw/timer/Kconfig
Wouldn=E2=80=99t it create inconsistencies in code if we change only for PL=
011?

On Wed, 19 Mar 2025 at 7:19=E2=80=AFPM, Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> On 19/3/25 14:44, Peter Maydell wrote:
> > On Wed, 19 Mar 2025 at 12:53, Tanish Desai <tanishdesai37@gmail.com>
> wrote:
> >>
> >> The issue started after commit
> https://github.com/qemu/qemu/commit/59f4d65584bd3372070e2484876436c8d0250=
5e4
> >>
> >> Reproduction:
> >>    1. In the build directory on MacOS (haven't tried on other OS), run=
:
> >>         ../configure --enable-rust --target-list=3Daarch64-softmmu
> >>    2. Then run either:
> >>         ninja -C .
> >>         OR
> >>         make
> >>    3. At the end, you will encounter the error:
> >>         duplicate symbol '_pl011_create' in:
> >>
>  /Users/tanishdesai37/Downloads/qemu-master/build/libcommon.a.p/hw_char_p=
l011.c.o
> >>
>  librust_aarch64_softmmu.a[5](pl011.pl011.390d424367e209af-cgu.1.rcgu.o)
> >>         ld: 1 duplicate symbols
> >>
> >> Root cause:
> >>    Both CONFIG_PL011 and X_PL011_RUST are selected, causing C++ and
> Rust to produce the same object.
> >>    This is due to the commit above where 'select PL011' forces a true
> condition instead of checking if HAVE_RUST is true.
> >>    If HAVE_RUST is true, X_PL011_RUST should be selected instead of
> CONFIG_PL011.
> >>
> >> Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
> >> ---
> >>   hw/vmapple/Kconfig | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
> >> index 2382b297672..01bcbf40e00 100644
> >> --- a/hw/vmapple/Kconfig
> >> +++ b/hw/vmapple/Kconfig
> >> @@ -22,7 +22,8 @@ config VMAPPLE
> >>       select PLATFORM_BUS
> >>       select PCI_EXPRESS
> >>       select PCI_EXPRESS_GENERIC_BRIDGE
> >> -    select PL011 # UART
> >> +    select PL011 if !HAVE_RUST # UART
> >> +    select X_PL011_RUST if HAVE_RUST # UART
> >>       select PL031 # RTC
> >>       select PL061 # GPIO
> >>       select GPIO_PWR
> >
> > Paolo: we seem to have quite a lot of this
> >
> >      select PL011 if !HAVE_RUST # UART
> >      select X_PL011_RUST if HAVE_RUST # UART
> >
> > duplicated for every PL011-using machine. Can we factor this out
> > in Kconfig? e.g.
> >
> > config PL011
> >      select X_PL011_RUST if HAVE_RUST
> >      select PL011_C if !HAVE_RUST
> >
> > (and update hw/char/meson.build to use CONFIG_PL011_C for pl011.c).
> > Then all the machines can go back to plain "select PL011" and
> > don't need to care whether it's the Rust or C version.
> >
> > Or does that not work?
>
> This should work.
>
>

--000000000000f67b8c0630b279c5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><div><div><div dir=3D"auto">It will work for PL011 but there are other=
 devices using the same method for selecting rust or c++ file like HPET in =
timer.</div><div dir=3D"auto">You can check this:-=C2=A0<div><a href=3D"htt=
ps://github.com/qemu/qemu/blob/master/hw/timer/Kconfig" target=3D"_blank">h=
ttps://github.com/qemu/qemu/blob/master/hw/timer/Kconfig</a></div>Wouldn=E2=
=80=99t it create inconsistencies in code if we change only for PL011?</div=
><div dir=3D"auto"><br></div></div></div></div><div><div><div><div><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, 19 Mar 202=
5 at 7:19=E2=80=AFPM, Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:phi=
lmd@linaro.org" target=3D"_blank">philmd@linaro.org</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left-width:1px;border-left-style:solid;padding-left:1ex;border-left-color:=
rgb(204,204,204)">On 19/3/25 14:44, Peter Maydell wrote:<br>
&gt; On Wed, 19 Mar 2025 at 12:53, Tanish Desai &lt;<a href=3D"mailto:tanis=
hdesai37@gmail.com" target=3D"_blank">tanishdesai37@gmail.com</a>&gt; wrote=
:<br>
&gt;&gt;<br>
&gt;&gt; The issue started after commit <a href=3D"https://github.com/qemu/=
qemu/commit/59f4d65584bd3372070e2484876436c8d02505e4" rel=3D"noreferrer" ta=
rget=3D"_blank">https://github.com/qemu/qemu/commit/59f4d65584bd3372070e248=
4876436c8d02505e4</a><br>
&gt;&gt;<br>
&gt;&gt; Reproduction:<br>
&gt;&gt;=C2=A0 =C2=A0 1. In the build directory on MacOS (haven&#39;t tried=
 on other OS), run:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0../configure --enable-rust --targ=
et-list=3Daarch64-softmmu<br>
&gt;&gt;=C2=A0 =C2=A0 2. Then run either:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ninja -C .<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OR<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0make<br>
&gt;&gt;=C2=A0 =C2=A0 3. At the end, you will encounter the error:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0duplicate symbol &#39;_pl011_crea=
te&#39; in:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/Users/tanishdesai3=
7/Downloads/qemu-master/build/libcommon.a.p/hw_char_pl011.c.o<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0librust_aarch64_sof=
tmmu.a[5](pl011.pl011.390d424367e209af-cgu.1.rcgu.o)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ld: 1 duplicate symbols<br>
&gt;&gt;<br>
&gt;&gt; Root cause:<br>
&gt;&gt;=C2=A0 =C2=A0 Both CONFIG_PL011 and X_PL011_RUST are selected, caus=
ing C++ and Rust to produce the same object.<br>
&gt;&gt;=C2=A0 =C2=A0 This is due to the commit above where &#39;select PL0=
11&#39; forces a true condition instead of checking if HAVE_RUST is true.<b=
r>
&gt;&gt;=C2=A0 =C2=A0 If HAVE_RUST is true, X_PL011_RUST should be selected=
 instead of CONFIG_PL011.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Tanish Desai &lt;<a href=3D"mailto:tanishdesai37@gm=
ail.com" target=3D"_blank">tanishdesai37@gmail.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0hw/vmapple/Kconfig | 3 ++-<br>
&gt;&gt;=C2=A0 =C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig<br>
&gt;&gt; index 2382b297672..01bcbf40e00 100644<br>
&gt;&gt; --- a/hw/vmapple/Kconfig<br>
&gt;&gt; +++ b/hw/vmapple/Kconfig<br>
&gt;&gt; @@ -22,7 +22,8 @@ config VMAPPLE<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select PLATFORM_BUS<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select PCI_EXPRESS<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select PCI_EXPRESS_GENERIC_BRIDGE<br>
&gt;&gt; -=C2=A0 =C2=A0 select PL011 # UART<br>
&gt;&gt; +=C2=A0 =C2=A0 select PL011 if !HAVE_RUST # UART<br>
&gt;&gt; +=C2=A0 =C2=A0 select X_PL011_RUST if HAVE_RUST # UART<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select PL031 # RTC<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select PL061 # GPIO<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0select GPIO_PWR<br>
&gt; <br>
&gt; Paolo: we seem to have quite a lot of this<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 select PL011 if !HAVE_RUST # UART<br>
&gt;=C2=A0 =C2=A0 =C2=A0 select X_PL011_RUST if HAVE_RUST # UART<br>
&gt; <br>
&gt; duplicated for every PL011-using machine. Can we factor this out<br>
&gt; in Kconfig? e.g.<br>
&gt; <br>
&gt; config PL011<br>
&gt;=C2=A0 =C2=A0 =C2=A0 select X_PL011_RUST if HAVE_RUST<br>
&gt;=C2=A0 =C2=A0 =C2=A0 select PL011_C if !HAVE_RUST<br>
&gt; <br>
&gt; (and update hw/char/meson.build to use CONFIG_PL011_C for pl011.c).<br=
>
&gt; Then all the machines can go back to plain &quot;select PL011&quot; an=
d<br>
&gt; don&#39;t need to care whether it&#39;s the Rust or C version.<br>
&gt; <br>
&gt; Or does that not work?<br>
<br>
This should work.<br>
<br>
</blockquote></div></div>
</div>
</div>
</div>

--000000000000f67b8c0630b279c5--

