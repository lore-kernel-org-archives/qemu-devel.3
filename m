Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD91C19F32
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 15:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnJ5u-0000ga-Bx; Wed, 26 Feb 2025 10:13:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tnJ5n-0000fr-4w
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 10:12:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tnJ5j-0007Mp-2n
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 10:12:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740582773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LA0pOXxE0yK04XxCvhTYiH9k6SyKJefiRNSoJmxj0U4=;
 b=DGp7lbxu4Uo5hzhdE3sjSejzsIMIxJhnC4gS250u9mqn20YGLh6WxT9+1AeufT7yM4Mm+Y
 symNPpwilXanisR82WwvoM2Xq73TqoMf4RwsofCdSItD0kVWrCKXNxuS28ScBdM++XUA/z
 pL7fYEdsBPYLx+6kOskeAr+LuB1OSGw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-kHPC7_TKNeOe53nS8veJIw-1; Wed, 26 Feb 2025 10:12:51 -0500
X-MC-Unique: kHPC7_TKNeOe53nS8veJIw-1
X-Mimecast-MFC-AGG-ID: kHPC7_TKNeOe53nS8veJIw_1740582770
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2f81a0d0a18so14835337a91.3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 07:12:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740582770; x=1741187570;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LA0pOXxE0yK04XxCvhTYiH9k6SyKJefiRNSoJmxj0U4=;
 b=KqoAYZmS4qV0Lm0Krq72XI5Q1B0WMChbDGFr6PX7oHXXobNr1bY+IoJDI8ocxh8jBx
 /3Ii1IaMIbzGdSLLFDFbUm/92hv/9CxBzRjglsziRWjH47p3SCAa2cStjW49w/yvCW8W
 moId5Ssd7PTkdbnfN9KYIP11D+WraqNmKcr+arrqWVP9TRCAPS8ASRNeiaKHVymR7tnH
 LzoyTgBB+oShgRbhqRLg6UYaKsf3nvnJ+MmRJi99jjbtvB+4RPj4o026Ot0uFNArEJNG
 zvwkHgUTloQy/4FIk2p5WpnQyiCsUF9dWYhwM89zVRXReH43CkrFjUVHHTG5CnaeZdfq
 Uo5g==
X-Gm-Message-State: AOJu0Yzqh5rBGbxIyStAodqD0HaJ/OHfBLnxQUH9ZOVCVJy3ysw2YPV7
 mQLHZJc+rmfubznZ5v5t1jbKMu8LY+PhGiZax7N29AD8ZLfdUnNso9MouFOlLgU8vt8ivsOd0U6
 nUKFIwyoPG69+ED9Zg38FiJo1UmULVMbuA66yyMSMPRsgIDLZB5K7rYSdOxJmmlQqz8ePwO1ijU
 nvU2nIFT/cotLEaUQTv9ylMKmfBKI=
X-Gm-Gg: ASbGnct2+IaJ4eCqQs9pWv+JmXIPNnePqCHrIuncqScD2QTj2bPP4z3IfPxsKBmuinR
 chsZovH6EVus300hAAG/xW7QbyLTdzmhwiDZjydCZaz0o82AWtOk0e5wWXrx/lUAjH1dz2mFta7
 gnWUGmw+Xy46++jUXPhDBw6qDOilHg
X-Received: by 2002:a17:90b:1f88:b0:2fc:bc04:2092 with SMTP id
 98e67ed59e1d1-2fe68ae29cdmr13839474a91.17.1740582770410; 
 Wed, 26 Feb 2025 07:12:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZzcuPuPKsCrw6Uu/V45rEAhjW++1lU5DyXAgsrwK4+uzCGPvf/Ys/nsk8ihpUb9Vc8eVYDaJaTljjwTFxeFk=
X-Received: by 2002:a17:90b:1f88:b0:2fc:bc04:2092 with SMTP id
 98e67ed59e1d1-2fe68ae29cdmr13839448a91.17.1740582770132; Wed, 26 Feb 2025
 07:12:50 -0800 (PST)
MIME-Version: 1.0
References: <20250224033741.222749-1-jsnow@redhat.com>
 <20250224033741.222749-3-jsnow@redhat.com>
 <87o6yrfrjc.fsf@pond.sub.org>
 <CAFn=p-Y-jr289LnWULq60Fj=+dA2=CHhRQ7wQD-NZGwKUk3tLQ@mail.gmail.com>
 <87cyf52gwd.fsf@pond.sub.org>
In-Reply-To: <87cyf52gwd.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 26 Feb 2025 10:12:38 -0500
X-Gm-Features: AWEUYZlqj9XbI0ehTbno6oTgONQEm0ldhgbJjOz_1lxL7cqH4ONsvFYzzI3vNco
Message-ID: <CAFn=p-aSfw2pgU_TtdpH4t17qsSNU2uco=759w+WYpR5u-NhMw@mail.gmail.com>
Subject: Re: [PATCH 02/10] python: add qapi static analysis tests
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b76339062f0d018c"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000b76339062f0d018c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 4:29=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > On Mon, Feb 24, 2025 at 7:36=E2=80=AFAM Markus Armbruster <armbru@redha=
t.com>
> wrote:
> >
> >> John Snow <jsnow@redhat.com> writes:
> >>
> >> > Update the python tests to also check qapi. No idea why I didn't do
> this
> >> > before. I guess I was counting on moving it under python/ and then
> just
> >> > forgot after that was NACKed. Oops, this turns out to be really easy=
.
> >> >
> >> > flake8, isort and mypy use the tool configuration from the existing
> >> > python directory. pylint continues to use the special configuration
> >> > located in scripts/qapi/ - that configuration is more permissive. If
> we
> >> > wish to unify the two configurations, that's a separate series and a
> >> > discussion for a later date.
> >> >
> >> > As a result of this patch, one would be able to run any of the
> following
> >> > tests locally from the qemu.git/python directory and have it cover t=
he
> >> > scripts/qapi/ module as well. All of the following options run the
> >> > python tests, static analysis tests, and linter checks; but with
> >> > different combinations of dependencies and interpreters.
> >> >
> >> > - "make check-minreqs" Run tests specifically under our oldest
> supported
> >> >   Python and our oldest supported dependencies. This is the test tha=
t
> >> >   runs on GitLab as "check-python-minreqs". This helps ensure we do
> not
> >> >   regress support on older platforms accidentally.
> >> >
> >> > - "make check-tox" Runs the tests under the newest supported
> >> >   dependencies, but under each supported version of Python in turn. =
At
> >> >   time of writing, this is Python 3.8 to 3.13 inclusive. This test
> helps
> >> >   catch bleeding-edge problems before they become problems for
> developer
> >> >   workstations. This is the GitLab test "check-python-tox" and is an
> >> >   optionally run, may-fail test due to the unpredictable nature of n=
ew
> >> >   dependencies being released into the ecosystem that may cause
> >> >   regressions.
> >> >
> >> > - "make check-dev" Runs the tests under the newest supported
> >> >   dependencies using whatever version of Python the user happens to
> have
> >> >   installed. This is a quick convenience check that does not map to
> any
> >> >   particular GitLab test.
> >> >
> >> > (Note! check-dev may be busted on Fedora 41 and bleeding edge versio=
ns
> >>
> >> It is for me.
> >>
> >> > of setuptools. That's unrelated to this patch and I'll address it
> >> > separately and soon. Thank you for your patience, --mgmt)
> >>
> >> Which of these tests, if any, run in "make check"?  In CI?
> >>
> >
> > Under "make check", the top-level test in qemu.git, none. I swear on my
> > future grave
>
> "Not today!"
>
> >              I am trying to fix that,
>
> Also not today.  SCNR!
>
> >                                       but there are barriers to it.
> Adding
> > make check support means installing testing dependencies in the configu=
re
> > venv, which means a slower ./configure invocation. I am trying to figur=
e
> > out how to minimize this penalty for cases where we either do not want
> to,
> > or can't, run the python tests. It's a long story, we can talk about it
> > later.
> >
> > In CI, the "check-minreqs" test will run by default as a must-pass test
> > under the job "check python minreqs".
> >
> > "check-tox" is an optional job in the CI pipeline that is allowed to fa=
il
> > as a warning, due to the nature of this test checking bleeding edge
> > dependencies.
> >
> > All three local invocations run the exact same tests (literally "make
> > check" in the python dir), just under different combinations of
> > dependencies and python versions. "check-minreqs" is more or less the
> > "canonical" one that *must* succeed, but as a Python maintainer I do my
> > best to enforce "check-tox" as well, though it does lag behind.
> >
> > So, this isn't a perfect solution yet but it's certainly much better th=
an
> > carrying around ad-hoc linter shell scripts and attempting to manage th=
e
> > dependencies yourself. At least we all have access to the same
> invocations.
>
> So:
>
> * At some point, we'll integrate whatever we want developers to run into
>   "make check".  Until then:
>
> * Running "make check-dev" is nice and good enough.  CI might find
>   additional problems.  Expected to be rare and no big deal.
>
> * Running "make check-minreqs" locally will get the exact same results
>   as the same test in CI will.  Run if you care.
>
> * "make check-tox" is an early warning system.  Don't run unless you're
>   interested in preventing potential future problems.
>

More or less; though it does test in every supported python interpreter if
you happen to have multiple installed, so it can be a way to catch errors
that exist between minreqs and $current, but it's still generally only a
test that I think you should run if you are touching the Python stuff in a
major way; i.e. if you're sending something that's a PR for *me*, I think
you should run it. If you're just doing a quick fix to qapi that doesn't do
any deep Python trickery, I'd trust either check-minreqs/CI or check-dev to
be sufficient due diligence.

In other words: *any one* of these tests are likely to catch errors due to
incorrect code and is sufficient due diligence; making sure they *all* pass
is more of a job for *me* to catch ecosystem problems across our wide
platform and python version support matrix.

I very often run "check minreqs" and "check tox" and consider that
exhaustive. the dev test is there only as a quick smoke test if you don't
have a battleship of python interpreters installed, but it's busted at the
moment due to fairly recent setuptools changes @_@

--js


>
> Acked-by: Markus Armbruster <armbru@redhat.com>
>
> [...]
>
>

--000000000000b76339062f0d018c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Feb 26,=
 2025 at 4:29=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; On Mon, Feb 24, 2025 at 7:36=E2=80=AFAM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt; w=
rote:<br>
&gt;<br>
&gt;&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank=
">jsnow@redhat.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; Update the python tests to also check qapi. No idea why I did=
n&#39;t do this<br>
&gt;&gt; &gt; before. I guess I was counting on moving it under python/ and=
 then just<br>
&gt;&gt; &gt; forgot after that was NACKed. Oops, this turns out to be real=
ly easy.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; flake8, isort and mypy use the tool configuration from the ex=
isting<br>
&gt;&gt; &gt; python directory. pylint continues to use the special configu=
ration<br>
&gt;&gt; &gt; located in scripts/qapi/ - that configuration is more permiss=
ive. If we<br>
&gt;&gt; &gt; wish to unify the two configurations, that&#39;s a separate s=
eries and a<br>
&gt;&gt; &gt; discussion for a later date.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; As a result of this patch, one would be able to run any of th=
e following<br>
&gt;&gt; &gt; tests locally from the qemu.git/python directory and have it =
cover the<br>
&gt;&gt; &gt; scripts/qapi/ module as well. All of the following options ru=
n the<br>
&gt;&gt; &gt; python tests, static analysis tests, and linter checks; but w=
ith<br>
&gt;&gt; &gt; different combinations of dependencies and interpreters.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; - &quot;make check-minreqs&quot; Run tests specifically under=
 our oldest supported<br>
&gt;&gt; &gt;=C2=A0 =C2=A0Python and our oldest supported dependencies. Thi=
s is the test that<br>
&gt;&gt; &gt;=C2=A0 =C2=A0runs on GitLab as &quot;check-python-minreqs&quot=
;. This helps ensure we do not<br>
&gt;&gt; &gt;=C2=A0 =C2=A0regress support on older platforms accidentally.<=
br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; - &quot;make check-tox&quot; Runs the tests under the newest =
supported<br>
&gt;&gt; &gt;=C2=A0 =C2=A0dependencies, but under each supported version of=
 Python in turn. At<br>
&gt;&gt; &gt;=C2=A0 =C2=A0time of writing, this is Python 3.8 to 3.13 inclu=
sive. This test helps<br>
&gt;&gt; &gt;=C2=A0 =C2=A0catch bleeding-edge problems before they become p=
roblems for developer<br>
&gt;&gt; &gt;=C2=A0 =C2=A0workstations. This is the GitLab test &quot;check=
-python-tox&quot; and is an<br>
&gt;&gt; &gt;=C2=A0 =C2=A0optionally run, may-fail test due to the unpredic=
table nature of new<br>
&gt;&gt; &gt;=C2=A0 =C2=A0dependencies being released into the ecosystem th=
at may cause<br>
&gt;&gt; &gt;=C2=A0 =C2=A0regressions.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; - &quot;make check-dev&quot; Runs the tests under the newest =
supported<br>
&gt;&gt; &gt;=C2=A0 =C2=A0dependencies using whatever version of Python the=
 user happens to have<br>
&gt;&gt; &gt;=C2=A0 =C2=A0installed. This is a quick convenience check that=
 does not map to any<br>
&gt;&gt; &gt;=C2=A0 =C2=A0particular GitLab test.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; (Note! check-dev may be busted on Fedora 41 and bleeding edge=
 versions<br>
&gt;&gt;<br>
&gt;&gt; It is for me.<br>
&gt;&gt;<br>
&gt;&gt; &gt; of setuptools. That&#39;s unrelated to this patch and I&#39;l=
l address it<br>
&gt;&gt; &gt; separately and soon. Thank you for your patience, --mgmt)<br>
&gt;&gt;<br>
&gt;&gt; Which of these tests, if any, run in &quot;make check&quot;?=C2=A0=
 In CI?<br>
&gt;&gt;<br>
&gt;<br>
&gt; Under &quot;make check&quot;, the top-level test in qemu.git, none. I =
swear on my<br>
&gt; future grave<br>
<br>
&quot;Not today!&quot;<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I am trying to fix tha=
t,<br>
<br>
Also not today.=C2=A0 SCNR!<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0but th=
ere are barriers to it. Adding<br>
&gt; make check support means installing testing dependencies in the config=
ure<br>
&gt; venv, which means a slower ./configure invocation. I am trying to figu=
re<br>
&gt; out how to minimize this penalty for cases where we either do not want=
 to,<br>
&gt; or can&#39;t, run the python tests. It&#39;s a long story, we can talk=
 about it<br>
&gt; later.<br>
&gt;<br>
&gt; In CI, the &quot;check-minreqs&quot; test will run by default as a mus=
t-pass test<br>
&gt; under the job &quot;check python minreqs&quot;.<br>
&gt;<br>
&gt; &quot;check-tox&quot; is an optional job in the CI pipeline that is al=
lowed to fail<br>
&gt; as a warning, due to the nature of this test checking bleeding edge<br=
>
&gt; dependencies.<br>
&gt;<br>
&gt; All three local invocations run the exact same tests (literally &quot;=
make<br>
&gt; check&quot; in the python dir), just under different combinations of<b=
r>
&gt; dependencies and python versions. &quot;check-minreqs&quot; is more or=
 less the<br>
&gt; &quot;canonical&quot; one that *must* succeed, but as a Python maintai=
ner I do my<br>
&gt; best to enforce &quot;check-tox&quot; as well, though it does lag behi=
nd.<br>
&gt;<br>
&gt; So, this isn&#39;t a perfect solution yet but it&#39;s certainly much =
better than<br>
&gt; carrying around ad-hoc linter shell scripts and attempting to manage t=
he<br>
&gt; dependencies yourself. At least we all have access to the same invocat=
ions.<br>
<br>
So:<br>
<br>
* At some point, we&#39;ll integrate whatever we want developers to run int=
o<br>
=C2=A0 &quot;make check&quot;.=C2=A0 Until then:<br>
<br>
* Running &quot;make check-dev&quot; is nice and good enough.=C2=A0 CI migh=
t find<br>
=C2=A0 additional problems.=C2=A0 Expected to be rare and no big deal.<br>
<br>
* Running &quot;make check-minreqs&quot; locally will get the exact same re=
sults<br>
=C2=A0 as the same test in CI will.=C2=A0 Run if you care.<br>
<br>
* &quot;make check-tox&quot; is an early warning system.=C2=A0 Don&#39;t ru=
n unless you&#39;re<br>
=C2=A0 interested in preventing potential future problems.<br></blockquote>=
<div><br></div><div>More or less; though it does test in every supported py=
thon interpreter if you happen to have multiple installed, so it can be a w=
ay to catch errors that exist between minreqs and $current, but it&#39;s st=
ill generally only a test that I think you should run if you are touching t=
he Python stuff in a major way; i.e. if you&#39;re sending something that&#=
39;s a PR for *me*, I think you should run it. If you&#39;re just doing a q=
uick fix to qapi that doesn&#39;t do any deep Python trickery, I&#39;d trus=
t either check-minreqs/CI or check-dev to be sufficient due diligence.</div=
><div><br></div><div>In other words: *any one* of these tests are likely to=
 catch errors due to incorrect code and is sufficient due diligence; making=
 sure they *all* pass is more of a job for *me* to catch ecosystem problems=
 across our wide platform and python version support matrix.</div><div><br>=
</div><div>I very often run &quot;check minreqs&quot; and &quot;check tox&q=
uot; and consider that exhaustive. the dev test is there only as a quick sm=
oke test if you don&#39;t have a battleship of python interpreters installe=
d, but it&#39;s busted at the moment due to fairly recent setuptools change=
s <a class=3D"gmail_plusreply" id=3D"plusReplyChip-0">@_@</a></div><div><br=
></div><div>--js</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
<br>
Acked-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" target=
=3D"_blank">armbru@redhat.com</a>&gt;<br>
<br>
[...]<br>
<br>
</blockquote></div></div>

--000000000000b76339062f0d018c--


