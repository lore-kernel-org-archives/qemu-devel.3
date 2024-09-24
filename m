Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 130C3CF9C6F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 12:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st4iR-0002nP-E5; Tue, 24 Sep 2024 08:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1st4iP-0002hJ-LZ
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 08:32:25 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1st4iN-0004Sz-Fn
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 08:32:25 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2f8ca33ef19so26519761fa.2
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 05:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727181141; x=1727785941; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GyRKw9qtbFiiitlNZMMOTwG0z8GW4JOzDpGvDMyvWiI=;
 b=WhvFTy0M9sdSV+F74LF6c8BcapRvg4w+SqtWOrsswW9NPglnMX3m9fZtq7DAp75gaT
 c57le4dLAS06ux0NgCMiJY9LQVV62MA/U6nzt5aOvjqC/G2IhH/TXXjfVRuXniYmSovo
 3vY8B3xMYtifoMCkBGWKVeNA0QW5Al0+lOqXos7AyahYH+RY6/EpUzb4xcxESse3WRjH
 mgSoxMz3jjxsiFDBfoCpVVihFj5Nc2WsbV/OftQRFt1juW/ziRGc3/DXxGe3RwGjv+IG
 B948K0dqCsLuo0yJDBBxoN6eJMSkXzR5w2e3P1zLNiZ/NxVZMvLiolp63jCPFnbmoUd+
 1AkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727181141; x=1727785941;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GyRKw9qtbFiiitlNZMMOTwG0z8GW4JOzDpGvDMyvWiI=;
 b=anjntO5obwmbQfqfui0yloal20NkPrSTaXwlsYeAIySXr4ZLQj8jiMGIIOntN5B9N4
 Ql9XDsfBEjVGhFiqdRRel3sTA4Gf0EUooeTXLMoZAoFO1xzlBx/vfGGp2q7HRB/kMSwz
 yT2hkwVjpAJuZqPndGQvTUna5qcbv5IE1F70ZHNhEgqQ16MMm5rsx7pIBn6RZd5ztj4l
 rmCua/m81m68veNWwSUNzZRD49CA38laia/9JQ6riVLBVYKgb8+EB4qwQzyUg+wGGAe2
 AhPpejencIdSyHMV5Y0/gAPvSbA6MEBNE9N3bNMrvt+n96IUxyQsO37EP6dTXDjPuT4/
 1Lhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSJ1HdEgCKEzpNl9QFFnsdc1ZX4xnT3osgvUeyI4+wZNKXRkH3jnWxMt1ACpLub6GcFMzAl8Wqg4bP@nongnu.org
X-Gm-Message-State: AOJu0YxwU4xvleutj/w8qJTAS+QOH6eRlO4Oo2asGlUjEq5MammQ7y1L
 VzCgrPYl/0K9IZtceyoL7eyM9D2hf/XUtAzvVI+tP3lFkaXPnae4HJTN9kJJPVHoQQYh3fNu8gw
 XqNiCpuSvgUt4T821zBXAEL6y5Q7OsEzwL5CyHw==
X-Google-Smtp-Source: AGHT+IH7lyPF2LdCsDkake6J/K8hp6pJdd40tPZtKXa6rYUJkS7RdcfNSTYmoHT9kDCLD+qiP1iWYgJFuT3gjDhmpSM=
X-Received: by 2002:a2e:96c8:0:b0:2f3:c384:71ee with SMTP id
 38308e7fff4ca-2f7cb358d5amr77860411fa.33.1727181140913; Tue, 24 Sep 2024
 05:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240923-feature-build-info-cli-v2-1-66b3462f16a1@linaro.org>
 <ZvGbRWSPPLJDx7BX@redhat.com> <ka5ia.wqlrej2ef9q@linaro.org>
 <ZvJ8JblXVH-kJGi1@redhat.com>
 <CAAjaMXZ8q0is2-7-kjyBs=YsBc03=0R2XcYiR-fp05=bcerD6Q@mail.gmail.com>
 <87setpcl9p.fsf@draig.linaro.org> <ZvKrqCR5L21-6k54@redhat.com>
In-Reply-To: <ZvKrqCR5L21-6k54@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Tue, 24 Sep 2024 15:32:10 +0300
Message-ID: <CAAjaMXYX5f5_Q6WezmteM77dSqTHZOdCB7LdZYY6Tj9PtKkSCw@mail.gmail.com>
Subject: Re: [PATCH v2] Add -build-info and -build-info-json CLI arguments
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "open list:ARM SMMU <qemu-arm@nongnu.org>, " <qemu-devel@nongnu.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000005e15bb0622dcb21f"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--0000000000005e15bb0622dcb21f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Daniel,

On Tue, Sep 24, 2024, 3:08 PM Daniel P. Berrang=C3=A9 <berrange@redhat.com>
wrote:

> On Tue, Sep 24, 2024 at 01:02:26PM +0100, Alex Benn=C3=A9e wrote:
> > Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
> >
> > > Hello Daniel,
> > >
> > > On Tue, 24 Sept 2024 at 11:45, Daniel P. Berrang=C3=A9 <berrange@redh=
at.com>
> wrote:
> > >>
> > >> On Mon, Sep 23, 2024 at 10:09:32PM +0300, Manos Pitsidianakis wrote:
> > >> > Hello Daniel,
> > >> >
> > >> > On Mon, 23 Sep 2024 19:45, "Daniel P. Berrang=C3=A9" <
> berrange@redhat.com> wrote:
> > >> > > On Mon, Sep 23, 2024 at 09:05:24AM +0300, Manos Pitsidianakis
> wrote:
> > <snip>
> > >> > > ie, look a query-audiodevs to discover what audio baxckends are
> > >> > > built-in, don't look for CONFIG_XXX settings related to audio.
> > >> > > If there are gaps in information we can query from QMP, we shoul=
d
> > >> > > aim to close those gaps.
> > >> > >
> > >> > > IOW, I don't think we should expose this build info info in eith=
er
> > >> > > human readable or machine readable format.
> > >> >
> > >> > QAPI/QMP is not the perspective of this patch, this is for people
> who use
> > >> > custom-built (i.e. not from a distro) binaries and want to be able
> to
> > >> > identify how it was built. Launching a binary to query stuff is
> > >> > unnecessarily complex for this task, and the info is not generally
> > >> > interesting to the API consumers as you said.
> > >>
> > >> Launching QEMU to talk QMP is our defined public API for querying
> > >> anything about the capabilities of QEMU. We're worked hard to get
> > >> away from providing ad-hoc ways to query QEMU from the command
> > >> line and going back to that is not desirable. It may be slightly
> > >> more complicated, but not by very much.
> > >
> > > Again, this is not a "capabilities discovery" API. It lists the
> > > build-time configuration of the binary. Perhaps we can expose it in a
> > > different way so that people don't end up confused?
> >
> > I think the problem is however much we might say it's not a capabilitie=
s
> > discovery API it's very existence encourages users to use it as one.
> >
> > What about a script:
> >
> >   qemu-get-build-info </path/to/qemu>
> >
> > which would launch the binary and query it over QMP? Would that work?
>
> If this is purely a debugging aid, we could make use of ELF notes to
> just stick the config-host.h content into the binary. This has precedent
> in systemd package notes (https://github.com/systemd/package-notes) and
> is more clearly *NOT* an end user CLI option, nor a public API in QMP.
>
> Querying is then
>
>     objdump -j .note.qemu-config-h -s /usrbin/qemu-system-x86_64
>

That's actually a way better solution! I will attempt it for the next
revision.

Manos

>

--0000000000005e15bb0622dcb21f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hello Daniel,<br><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 24, 2024, 3:08 PM Daniel P. B=
errang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
On Tue, Sep 24, 2024 at 01:02:26PM +0100, Alex Benn=C3=A9e wrote:<br>
&gt; Manos Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidianakis@linaro.o=
rg" target=3D"_blank" rel=3D"noreferrer">manos.pitsidianakis@linaro.org</a>=
&gt; writes:<br>
&gt; <br>
&gt; &gt; Hello Daniel,<br>
&gt; &gt;<br>
&gt; &gt; On Tue, 24 Sept 2024 at 11:45, Daniel P. Berrang=C3=A9 &lt;<a hre=
f=3D"mailto:berrange@redhat.com" target=3D"_blank" rel=3D"noreferrer">berra=
nge@redhat.com</a>&gt; wrote:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On Mon, Sep 23, 2024 at 10:09:32PM +0300, Manos Pitsidianakis=
 wrote:<br>
&gt; &gt;&gt; &gt; Hello Daniel,<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; On Mon, 23 Sep 2024 19:45, &quot;Daniel P. Berrang=C3=A9=
&quot; &lt;<a href=3D"mailto:berrange@redhat.com" target=3D"_blank" rel=3D"=
noreferrer">berrange@redhat.com</a>&gt; wrote:<br>
&gt; &gt;&gt; &gt; &gt; On Mon, Sep 23, 2024 at 09:05:24AM +0300, Manos Pit=
sidianakis wrote:<br>
&gt; &lt;snip&gt;<br>
&gt; &gt;&gt; &gt; &gt; ie, look a query-audiodevs to discover what audio b=
axckends are<br>
&gt; &gt;&gt; &gt; &gt; built-in, don&#39;t look for CONFIG_XXX settings re=
lated to audio.<br>
&gt; &gt;&gt; &gt; &gt; If there are gaps in information we can query from =
QMP, we should<br>
&gt; &gt;&gt; &gt; &gt; aim to close those gaps.<br>
&gt; &gt;&gt; &gt; &gt;<br>
&gt; &gt;&gt; &gt; &gt; IOW, I don&#39;t think we should expose this build =
info info in either<br>
&gt; &gt;&gt; &gt; &gt; human readable or machine readable format.<br>
&gt; &gt;&gt; &gt;<br>
&gt; &gt;&gt; &gt; QAPI/QMP is not the perspective of this patch, this is f=
or people who use<br>
&gt; &gt;&gt; &gt; custom-built (i.e. not from a distro) binaries and want =
to be able to<br>
&gt; &gt;&gt; &gt; identify how it was built. Launching a binary to query s=
tuff is<br>
&gt; &gt;&gt; &gt; unnecessarily complex for this task, and the info is not=
 generally<br>
&gt; &gt;&gt; &gt; interesting to the API consumers as you said.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Launching QEMU to talk QMP is our defined public API for quer=
ying<br>
&gt; &gt;&gt; anything about the capabilities of QEMU. We&#39;re worked har=
d to get<br>
&gt; &gt;&gt; away from providing ad-hoc ways to query QEMU from the comman=
d<br>
&gt; &gt;&gt; line and going back to that is not desirable. It may be sligh=
tly<br>
&gt; &gt;&gt; more complicated, but not by very much.<br>
&gt; &gt;<br>
&gt; &gt; Again, this is not a &quot;capabilities discovery&quot; API. It l=
ists the<br>
&gt; &gt; build-time configuration of the binary. Perhaps we can expose it =
in a<br>
&gt; &gt; different way so that people don&#39;t end up confused?<br>
&gt; <br>
&gt; I think the problem is however much we might say it&#39;s not a capabi=
lities<br>
&gt; discovery API it&#39;s very existence encourages users to use it as on=
e.<br>
&gt; <br>
&gt; What about a script:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0qemu-get-build-info &lt;/path/to/qemu&gt;<br>
&gt; <br>
&gt; which would launch the binary and query it over QMP? Would that work?<=
br>
<br>
If this is purely a debugging aid, we could make use of ELF notes to<br>
just stick the config-host.h content into the binary. This has precedent<br=
>
in systemd package notes (<a href=3D"https://github.com/systemd/package-not=
es" rel=3D"noreferrer noreferrer" target=3D"_blank">https://github.com/syst=
emd/package-notes</a>) and<br>
is more clearly *NOT* an end user CLI option, nor a public API in QMP.<br>
<br>
Querying is then<br>
<br>
=C2=A0 =C2=A0 objdump -j .note.qemu-config-h -s /usrbin/qemu-system-x86_64<=
br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">T=
hat&#39;s actually a way better solution! I will attempt it for the next re=
vision.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Manos=C2=A0</div=
><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
</blockquote></div></div></div>

--0000000000005e15bb0622dcb21f--

