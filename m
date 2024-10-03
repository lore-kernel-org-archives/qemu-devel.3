Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EDECF8571
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 09:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swHmk-0002l0-OM; Thu, 03 Oct 2024 05:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1swHmb-0002ee-CB
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 05:06:01 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1swHm2-00048D-Uw
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 05:05:56 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2e0a74ce880so655343a91.2
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 02:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1727946259; x=1728551059;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MwoKLbjiWk5W2MOxtv+/pJ1HZ7kuDq+4CZj2XYWI1CE=;
 b=ALx+b0ndFOe1/vcB+kYFNgTeiBBPf/qJICUR4xisXkJnd1pTz6oKdFm8I+6qY2Mii6
 +dTkeTEXgue/nxBYOx0DxC2WRTa4POtoeeGW1tX8Q3tqX5YcIm+iUpdAO3FKmjGfSDpr
 cGNBQbJFWW2SA0TIxB3wRKSDa0/DgcZwxabvckZT1OqmSctAX/pK6dXjUyI0aPSBqmN5
 jgR8+C7Q5U+IIUnMFAQuAl5k9tizaId2wbeM2pLRQ+kDaZfq9E9VcSzAuz0DmpDSTgos
 wt9Z5FT901lkRjeaA0CsoPH0D0Q68NdgDa5N5741xzxVqW2sF8PCga77dz6Qz39A2LyN
 uOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727946259; x=1728551059;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MwoKLbjiWk5W2MOxtv+/pJ1HZ7kuDq+4CZj2XYWI1CE=;
 b=CNk6aCeW6Xl5bnzfIk5nQ5Mtd7L1aCR5szx/Iveq6jYRlmWKVDw1qr+1q/4xVE9V/W
 qqCpsSBge8RW13dS9U5gInrvTMN5Ah+yWJVbklfoFjOaXGzKTa0FJWjbdlYfyBwKrDXt
 wL8Irrw1s0GSlM99iLO70jeRdQLB8deQA4SY+hHpy9MANP/v7oKoGFuXDDT3dUiaQ3CU
 XobCsoGg62UwL1ixncW6xRPO5f9E25L+E9S5x5FaX6liGmjhYI1WQcmYWDLxjWwt/X48
 z7Gvc+PBVnZ93Gdqqtfn2+3pBsXDxaD9IhGUFtI4lieLPOMtC4qfkYUL4oOD9/hAlgfM
 nY9A==
X-Gm-Message-State: AOJu0YyxI05equZB0z9Okcd4LhziUjyHix+1jGpqcm8J8EBlFarsItW4
 hTMpQH2XOvWV/RH9ytOqrxfq6x1bIeROm8Z/3o9wj2bd2v56m65zc7npixr5HDYVCG+SOWfYoeo
 FidbPtUDrA02aPSFmz9dG8Ve049zBveNlh3HwJPJ1gHKPc6Vh
X-Google-Smtp-Source: AGHT+IGzfRDiCREnIh1eVZNS0aIXd6paZQTQGY3XjjAmlRtRLFiVsWAGuXzK4cECVmkwMNk2pUU5hPz+r1kSe3MYbbk=
X-Received: by 2002:a17:90a:be10:b0:2e0:7b2b:f76 with SMTP id
 98e67ed59e1d1-2e18468cc49mr8127290a91.19.1727945758413; Thu, 03 Oct 2024
 01:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <871q16fq9c.fsf@draig.linaro.org>
 <CANCZdfoU4stiEDJKOUEpU-ek_tOBHe0rBH3G9S2Wymc8jHKzCQ@mail.gmail.com>
In-Reply-To: <CANCZdfoU4stiEDJKOUEpU-ek_tOBHe0rBH3G9S2Wymc8jHKzCQ@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 3 Oct 2024 02:55:47 -0600
Message-ID: <CANCZdfpWN+nYGLBtMb5xdpFW+=iGZ473UhknLN0vW6PyHSQScQ@mail.gmail.com>
Subject: Re: Rust BoF and maintainer minutes and planning the roadmap to Rust
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 pkg-qemu-devel@lists.alioth.debian.org, 
 Michael Tokarev <mjt@tls.msk.ru>, ncopa@alpinelinux.org, bofh@freebsd.org, 
 emulation@freebsd.org, virtualization@gentoo.org, dilfridge@gentoo.org, 
 hi@alyssa.is, edolstra+nixpkgs@gmail.com, brad@comstyle.com, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, dvzrv@archlinux.org,
 anatol.pomozov@gmail.com, Miroslav Rezanina <mrezanin@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001f2eb306238eb936"
Received-SPF: none client-ip=2607:f8b0:4864:20::102f;
 envelope-from=wlosh@bsdimp.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, HTML_MESSAGE=0.001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

--0000000000001f2eb306238eb936
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 2:53=E2=80=AFAM Warner Losh <imp@bsdimp.com> wrote:

>
>
> On Thu, Sep 26, 2024 at 8:24=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@lin=
aro.org>
> wrote:
>
>> One output from this discussion should be a clear statement that we are
>> going forward with this work and the road map. A rough roadmap might
>> look like:
>>
>>   - 9.2   --enable-rust is available and developers can build with it.
>>           rust devices have -x-device or -rust-device CLI flags for
>>           runtime selection.
>>
>>   - 10.x  rust devices feature complete and migration compatible, enable=
d
>>           by default when rust compiler detected. No CLI selection
>>           required as legacy portions won't be built. Any partial
>>           conversions should be behind --enable-prototype-rust configure
>>           flag.
>>
>>   - 11.x  distros have enough infrastructure to build on supported
>>           platforms. Rust becomes a mandatory dependency, old C versions
>>           of converted code removed from build.
>>
>>   - xx.y  QEMU becomes a pure native rust program and all C is expunged.
>>           We may never get to this point.
>>
>> We should publish the intention and the road map prominently although it
>> was unclear if a blog post would be the best place vs expanding a
>> section in the developers manual. Perhaps both make sense with a blog
>> post for the statement of intent and rough timeline and the developer
>> manual being expanded with any new rules and standards to follow?
>>
>
> FreeBSD is Tier 1 in rust only for amd64 (x86_64). It's Tier 2 for i386
> (which
> admittedly is going away) and Tier 3 for everything else.
>

oops, I should have said it's Tier 2 with hosts for amd64, Tier 2 w/o hosts
and
tier 3 for aarch64 (and everything else). In FreeBSD, amd64 and aarch64 are
tier 1 supported platforms and I got those confused. It is an important
difference
and later in my email I refer to it, so I thought a correction was in order=
.


> There was some concern about the missing gaps in the support matrix
>> especially as we support a number of "legacy" TCG backends. While *-user
>> support is more insulated from the effects of rust conversions due to
>> its relatively low set of dependencies it will still be a problem if we
>> convert the core CPU QOM classes to rust.
>>
>
> Indeed. I have great concerns here, though we've already dropped
> 32-bit host support for bsd-user. The status of aarch64 support and rumor=
ed
> difficulty getting that rust support upgraded give me pause for concern
> because it's a FreeBSD Tier 1 platform. While it basically works, the lac=
k
> of
> commitment by the Rust community is troubling. Even more troubling becaus=
e
> rust still uses the old FreeBSD 11 compat syscalls, despite upgraded
> being available for years at this point (though maybe this info has chang=
ed
> in the last month or two, the years long delay in moving off the interfac=
es
> that the FreeBSD project obsoleted about 8 years ago is troubling on its
> own).
> Much of the resistance I'm told (I'm not a big rust person, so I have to
> reply
> on others) has been in the rust team because they don't have enough
> familiarity
> with FreeBSD to make any kind of decision so even properly solved issues
> linger in the official upstream. The FreeBSD project critically depends o=
n
> bsd-user for its release process, though that dependency so far has been
> only on x86 and aarch64, both of which work almost all the time, even if
> they aren't Tier 1 rust platforms.
>
> For -system use, this could limit where qemu runs, though to be honest
> the only platform I know has users that might be affected running -system
> might be RISCV.
>
> There's similar issues with other BSDs, but I've heard even less reliable
> information
> about them, so I'll just leave it at that.
>
> So a strawman timeline of 2 years strikes me as unrealistically agressive
> for it to be an absolute requirement given the slow rate of change I've
> seen
> with upstream rust WRT FreeBSD. At the very least, it would put qemu on
> non-x86/non-aarch64 platforms at risk. While not a huge audience, there a=
re
> some users there. The Tier 2 status for Rust at best for FreeBSD is also =
a
> bit worrying for elimination of all C or a big reliance on rust in the
> core that
> can't realistically be avoided. I'm not sure this should gate the start o=
f
> the rust
> experiment, but I raise it now so as that experiment progresses towards
> production
> people think to talk to me or others in the FreeBSD community as they
> progress.
>
> Warner
>

--0000000000001f2eb306238eb936
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 3, 2024 at 2:53=E2=80=AFA=
M Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.com</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Thu, Sep 26, 2024 at 8:24=E2=80=AFAM Alex =
Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org" target=3D"_blank"=
>alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">One output from this discussion should be a clear st=
atement that we are<br>
going forward with this work and the road map. A rough roadmap might<br>
look like:<br>
<br>
=C2=A0 - 9.2=C2=A0 =C2=A0--enable-rust is available and developers can buil=
d with it.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rust devices have -x-device or -rust-dev=
ice CLI flags for<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runtime selection.<br>
<br>
=C2=A0 - 10.x=C2=A0 rust devices feature complete and migration compatible,=
 enabled<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 by default when rust compiler detected. =
No CLI selection<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 required as legacy portions won&#39;t be=
 built. Any partial<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 conversions should be behind --enable-pr=
ototype-rust configure<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flag.<br>
<br>
=C2=A0 - 11.x=C2=A0 distros have enough infrastructure to build on supporte=
d<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 platforms. Rust becomes a mandatory depe=
ndency, old C versions<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 of converted code removed from build.<br=
>
<br>
=C2=A0 - xx.y=C2=A0 QEMU becomes a pure native rust program and all C is ex=
punged.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 We may never get to this point.<br>
<br>
We should publish the intention and the road map prominently although it<br=
>
was unclear if a blog post would be the best place vs expanding a<br>
section in the developers manual. Perhaps both make sense with a blog<br>
post for the statement of intent and rough timeline and the developer<br>
manual being expanded with any new rules and standards to follow?<br></bloc=
kquote><div><br></div><div>FreeBSD is Tier 1 in rust only for amd64 (x86_64=
). It&#39;s Tier 2 for i386 (which</div><div>admittedly is going away) and =
Tier 3 for everything else.</div></div></div></blockquote><div><br></div><d=
iv>oops, I should have said it&#39;s Tier 2 with hosts for amd64, Tier 2 w/=
o hosts and</div><div>tier 3 for aarch64 (and everything else). In FreeBSD,=
 amd64 and aarch64 are</div><div>tier 1 supported=C2=A0platforms and I got =
those confused. It is an important difference</div><div>and later in my ema=
il I refer to it, so I thought a correction was in order.</div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><di=
v class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">T=
here was some concern about the missing gaps in the support matrix<br>
especially as we support a number of &quot;legacy&quot; TCG backends. While=
 *-user<br>
support is more insulated from the effects of rust conversions due to<br>
its relatively low set of dependencies it will still be a problem if we<br>
convert the core CPU QOM classes to rust.<br></blockquote><div><br></div><d=
iv>Indeed. I have great concerns here, though we&#39;ve already dropped</di=
v><div>32-bit host support for bsd-user. The status of aarch64 support and =
rumored</div><div>difficulty getting that rust support upgraded give me pau=
se for concern</div><div>because it&#39;s a FreeBSD Tier 1 platform. While =
it basically works, the lack of</div><div>commitment by the Rust community =
is troubling. Even more troubling because</div><div>rust still uses the old=
 FreeBSD 11 compat syscalls, despite upgraded</div><div>being available for=
 years at this point (though maybe this info has changed</div><div>in the l=
ast month or two, the years long delay in moving off the interfaces</div><d=
iv>that the FreeBSD project obsoleted about 8 years ago is troubling on its=
 own).</div><div>Much of the resistance I&#39;m told (I&#39;m not a big rus=
t person, so I have to reply</div><div>on others) has been in the rust team=
 because they don&#39;t have enough familiarity</div><div>with FreeBSD to m=
ake any kind of decision so even properly solved issues</div><div>linger in=
 the official upstream. The FreeBSD project critically depends on</div><div=
>bsd-user for its release process, though that dependency so far has been</=
div><div>only on x86 and aarch64, both of which work almost all the time, e=
ven if</div><div>they aren&#39;t Tier 1 rust platforms.</div><div><br></div=
><div>For -system use, this could limit where qemu runs, though to be hones=
t</div><div>the only platform I know has users that might be affected runni=
ng -system</div><div>might be RISCV.=C2=A0</div><div><br></div><div>There&#=
39;s similar issues with other BSDs, but I&#39;ve heard even less reliable =
information</div><div>about them, so I&#39;ll just leave it at that.</div><=
div><br></div><div>So a strawman timeline of 2 years strikes me as unrealis=
tically agressive</div><div>for it to be an absolute requirement given the =
slow rate of change I&#39;ve seen</div><div>with upstream rust WRT FreeBSD.=
 At the very least, it would put qemu on</div><div>non-x86/non-aarch64 plat=
forms at risk. While not a huge audience, there are</div><div>some users th=
ere. The Tier 2 status for Rust at best for FreeBSD is also a</div><div>bit=
 worrying for elimination of all C or a big reliance on rust in the core th=
at</div><div>can&#39;t realistically be avoided. I&#39;m not sure this shou=
ld gate the start of the rust</div><div>experiment, but I raise it now so a=
s that experiment progresses towards production</div><div>people think to t=
alk to me or others in the FreeBSD community as they progress.</div><div><b=
r></div><div>Warner</div></div></div>
</blockquote></div></div>

--0000000000001f2eb306238eb936--

