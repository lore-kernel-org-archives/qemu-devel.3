Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75359E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 08:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKvRM-00070w-Lm; Tue, 10 Dec 2024 03:17:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKvRG-0006x0-D9
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 03:17:54 -0500
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKvRE-0000XV-5z
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 03:17:50 -0500
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-85c5316f15cso675577241.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 00:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1733818666; x=1734423466;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eTnOVMRfEikzF5Vj1vn0lvjRxVxUxWA7W6bt29SKfzI=;
 b=Ua9XmlSAYZl5BWLmBxbPjjHbngdQqogn2pTscVehFYAdJYlLZhZLcr9elO2u6jXimv
 ZDB9f8UChXDkuE5m+V1354CtKBkUw8vRZx7Yqc1v19B9pltsinBr52xmQ10db47xBQCr
 d8RWG5Xna54GCNmMUB8K1qPCqR3kni+Cy+TAx5JbWxUGz7oiVTQ73+ee44n3BLIe9+Ab
 PnbQPRnhzoM3H0O1kurfJ5nxi11dL/Q2Wewqx8blNkD9cwNDzGkKUzjHSudUFYo0zZc4
 IzGPwYh5XYMKvzRHn3fhsK++ddS8Xnf6p9N7bJQ1XF0T3X42NPC97Y8XQaVxowWQYEet
 EewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733818666; x=1734423466;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eTnOVMRfEikzF5Vj1vn0lvjRxVxUxWA7W6bt29SKfzI=;
 b=iqw3x6Sm4ywOIZZz1itHVpT9giZRe5+76xaQopc3qWGd3/dIvzpbo5pMDFBSu1u5x3
 9SYv3RiVRgSgVZ/V5+nwdIBRjWTMr/nooisVcRlUTbWGVnuLaQq645Ru6/K14KaEHKhP
 rPE7fmIfxnjy6AEeHb8Ru5jCxcJ3af/bMvQW6LIICVUb/AsMMHeQ9bf+p0wcfUIANtZj
 m+42yz9H/PWuST9ut9Eq19OStbHuzX77SZ8TcQnepqcXewpl8xcYEpgcuyE+TCPuSh8s
 Rp/uT9kDLdr49he7LrwUXYM9nxFG+UQwMqa9VXYkSJP/EDG0CcVj1C1ankAiWB4tOwyK
 7PEw==
X-Gm-Message-State: AOJu0YxElVSJei1h0tvvi9Y/m3CV+y4HTlY5tc4+nd1CAPFYGPon902V
 v/8Oxx73HjI9MRxazefJfc/GbpV6Y5rhV4B/gmbpJM1hxR7SZt5/mfSllbP+l2hikFORxLKcPKr
 dgatugisXjHQH8wjpVIKq+d+Q8e+JuTVRMS1h
X-Gm-Gg: ASbGncuyPyCsTzQLdLDzGYAts+atstUFxIH5kckPFUxuXsMXjnpphRQqxVmeHFSpPhf
 jZ34hhM7NGLJCOv5gfbERMl99nHuglOglwvE=
X-Google-Smtp-Source: AGHT+IFN6SDPHl4zUCqgp4nD6pmCYN1f1uRJSm7Ya6cUaBDR70JAf0fS6dmTkAjq9h/W0U2u/gUGjMcNvKFVqfMgUbo=
X-Received: by 2002:a05:6102:54a5:b0:4b1:1b33:ed2f with SMTP id
 ada2fe7eead31-4b11b33f2f9mr1037706137.1.1733818666361; Tue, 10 Dec 2024
 00:17:46 -0800 (PST)
MIME-Version: 1.0
References: <20241209203629.74436-1-phil@philjordan.eu>
 <20241209203629.74436-4-phil@philjordan.eu>
 <c401b320-b382-4887-82bc-0252dd9f8c98@linaro.org>
In-Reply-To: <c401b320-b382-4887-82bc-0252dd9f8c98@linaro.org>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Tue, 10 Dec 2024 09:17:35 +0100
Message-ID: <CAAibmn0tDOeaCY_ZLsyvtiE5pqJB1PbgdXMcADj45zBaLMg6OA@mail.gmail.com>
Subject: Re: [PATCH 03/11] i386/hvf: Don't send signal to thread when kicking
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000b6c1d10628e61d43"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::929;
 envelope-from=phil@philjordan.eu; helo=mail-ua1-x929.google.com
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

--000000000000b6c1d10628e61d43
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon 9. Dec 2024 at 22:22, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
>
wrote:

> On 9/12/24 21:36, phil@philjordan.eu wrote:
> > From: Phil Dennis-Jordan <phil@philjordan.eu>
> >
> > This seems to be entirely superfluous and is costly enough to show up i=
n
>
> So the pthread_kill(cpu->thread, SIG_IPI) is entirely superfluous?
>

Yes, that is my conclusion after looking at the code and testing without
the signal sending. (I am only talking about HVF/x86 here!)

By my understanding, the HVF vCPU thread is always in one of 3 states:
- running hv_vcpu_run_until (hv_vcpu_interrupt() forces the transition out
of this, even in edge cases)
- waiting in qemu_wait_io_event In the main  hvf_cpu_thread_fn loop
(signalling the condition variable will bring it out of this)
- actively processing a VM exit, I/O request, etc (whatever it=E2=80=99s do=
ing
can=E2=80=99t be interrupted, but it will make progress and check its job q=
ueue on
completion)

So I can=E2=80=99t see any purpose the signal is supposed to be serving. I =
mean,
maybe I=E2=80=99ve missed something important - always happy to be correcte=
d and
learn something new. :-)

I=E2=80=99ll still need to investigate if the arm64 version is also doing t=
his
unnecessarily and whether we can remove the signal handler entirely.


> > profiling. hv_vcpu_interrupt() has been demonstrated to very reliably
> > cause VM exits - even if the target vCPU isn't even running, it will
> > immediately exit on entry.
> >
> > Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
> > ---
> >   target/i386/hvf/hvf.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> > index 3b6ee79fb2..936c31dbdd 100644
> > --- a/target/i386/hvf/hvf.c
> > +++ b/target/i386/hvf/hvf.c
> > @@ -214,7 +214,7 @@ static inline bool
> apic_bus_freq_is_known(CPUX86State *env)
> >
> >   void hvf_kick_vcpu_thread(CPUState *cpu)
> >   {
> > -    cpus_kick_thread(cpu);
> > +    cpu->thread_kicked =3D true;
> >       hv_vcpu_interrupt(&cpu->accel->fd, 1);
> >   }
> >
>
>

--000000000000b6c1d10628e61d43
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Mon 9. Dec 2024 at 22:22, Philippe Mathieu-Daud=C3=A9 &l=
t;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left-width:1px;border-left-style:solid;padding-left:1ex;border-left-c=
olor:rgb(204,204,204)">On 9/12/24 21:36, <a href=3D"mailto:phil@philjordan.=
eu" target=3D"_blank">phil@philjordan.eu</a> wrote:<br>
&gt; From: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjordan.eu" tar=
get=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt; <br>
&gt; This seems to be entirely superfluous and is costly enough to show up =
in<br>
<br>
So the pthread_kill(cpu-&gt;thread, SIG_IPI) is entirely superfluous?<br>
</blockquote><div dir=3D"auto"><br></div><div dir=3D"auto">Yes, that is my =
conclusion after looking at the code and testing without the signal sending=
. (I am only talking about HVF/x86 here!)</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">By my understanding, the HVF vCPU thread is always in one=
 of 3 states:</div><div dir=3D"auto">- running hv_vcpu_run_until (<span sty=
le=3D"font-family:-apple-system,helveticaneue">hv_vcpu_interrupt() forces t=
he transition out of this, even in edge cases)</span></div><div dir=3D"auto=
"><span style=3D"font-family:-apple-system,helveticaneue">- waiting in=C2=
=A0</span><span style=3D"font-family:&quot;gitlab mono&quot;,&quot;jetbrain=
s mono&quot;,menlo,&quot;dejavu sans mono&quot;,&quot;liberation mono&quot;=
,consolas,&quot;ubuntu mono&quot;,&quot;courier new&quot;,&quot;andale mono=
&quot;,&quot;lucida console&quot;,monospace;font-size:13px;white-space:pre;=
color:rgb(58,56,63)">qemu_wait_io_event </span>In the main =C2=A0<span styl=
e=3D"font-family:&quot;gitlab mono&quot;,&quot;jetbrains mono&quot;,menlo,&=
quot;dejavu sans mono&quot;,&quot;liberation mono&quot;,consolas,&quot;ubun=
tu mono&quot;,&quot;courier new&quot;,&quot;andale mono&quot;,&quot;lucida =
console&quot;,monospace;font-size:13px;white-space:pre;float:none;display:i=
nline!important;color:rgb(153,0,0)">hvf_cpu_thread_fn </span>loop (signalli=
ng the condition variable will bring it out of this)</div><div dir=3D"auto"=
>- actively processing a VM exit, I/O request, etc (whatever it=E2=80=99s d=
oing can=E2=80=99t be interrupted, but it will make progress and check its =
job queue on completion)</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>So I can=E2=80=99t see any purpose the signal is supposed to be serving. I=
 mean, maybe I=E2=80=99ve missed something important - always happy to be c=
orrected and learn something new. :-)<br></div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">I=E2=80=99ll still need to investigate if the arm64 versi=
on is also doing this unnecessarily and whether we can remove the signal ha=
ndler entirely.</div><div dir=3D"auto"><br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left=
-style:solid;padding-left:1ex;border-left-color:rgb(204,204,204)"><br>
&gt; profiling. hv_vcpu_interrupt() has been demonstrated to very reliably<=
br>
&gt; cause VM exits - even if the target vCPU isn&#39;t even running, it wi=
ll<br>
&gt; immediately exit on entry.<br>
&gt; <br>
&gt; Signed-off-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjorda=
n.eu" target=3D"_blank">phil@philjordan.eu</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/i386/hvf/hvf.c | 2 +-<br>
&gt;=C2=A0 =C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c<br>
&gt; index 3b6ee79fb2..936c31dbdd 100644<br>
&gt; --- a/target/i386/hvf/hvf.c<br>
&gt; +++ b/target/i386/hvf/hvf.c<br>
&gt; @@ -214,7 +214,7 @@ static inline bool apic_bus_freq_is_known(CPUX86St=
ate *env)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0void hvf_kick_vcpu_thread(CPUState *cpu)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 cpus_kick_thread(cpu);<br>
&gt; +=C2=A0 =C2=A0 cpu-&gt;thread_kicked =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0hv_vcpu_interrupt(&amp;cpu-&gt;accel-&gt;fd,=
 1);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
<br>
</blockquote></div></div>

--000000000000b6c1d10628e61d43--

