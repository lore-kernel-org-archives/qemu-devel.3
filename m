Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65390C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 15:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tma45-0000Cd-DE; Mon, 24 Feb 2025 10:08:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tma43-0000CD-FH
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 10:08:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tma41-00032q-FN
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 10:08:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740409686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4cpMGNTUHDBG970Jy1ljdlUq49cvWb/GAoc6Lko+Pq4=;
 b=YO5oK18WPdU92GT5REOsTs54AxBJkRqqbnqf/CtHYvPnbQOPKPpHOjcBCP6dmmR9Yu1iJx
 HAM3qrCqqoFvYrj22sY2kKNohc+8t4yZ2K8BMbEbOUYl3HveQH+vmIVnEDoYlb6GEDRH2i
 42zHbpLSekcR6qlg6sB/AJJr6zIS3gk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-ymLbEP86P0amq1vcrXtf3g-1; Mon, 24 Feb 2025 10:08:02 -0500
X-MC-Unique: ymLbEP86P0amq1vcrXtf3g-1
X-Mimecast-MFC-AGG-ID: ymLbEP86P0amq1vcrXtf3g_1740409681
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2f2a9f056a8so9762303a91.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 07:08:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740409681; x=1741014481;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4cpMGNTUHDBG970Jy1ljdlUq49cvWb/GAoc6Lko+Pq4=;
 b=rvTzjUm9PQOd7nvoYAk88EEqHpAm7KQcXpAr3M0ZOFagDAS+kVg9FlOVMc/r2pGVmQ
 NTUKUUQFhUX73isgrExo5pFckkvnv8IfJZf6idN5AGKL7bH81/WWW7IVxAQbNX5hcqC7
 1kcHfEjH8FSbEwsh3J6qMv+MhM4u9VLLKkg2ngGjfRSKa5LAjvovLqYBVN0BfwMnx4Df
 i37X90mi8tvER1XmgM1G8pkrgtqA2JyFiUCT/IzTauhChzasE2IgoB+3HWD0siFMDdAR
 d3LWLr6bqmj4sPHG+AGcAZxa7trjuNICd4rgJFF7LfaEYYUQYheoWbSTXdvuv0itaQtJ
 IgxA==
X-Gm-Message-State: AOJu0YwxmWtWaZdLBYrJABP4OCbNrl8ILbIYytmhDQi5jy6mNJO9O2vJ
 vgoU4UWOG5oPeOhaTaJ0D3w6Gv9Ew3gJch5eyzhii0MYHau/hYGc1S/NkOwDkYPlISpPeb8BRvV
 J4XfRFPHyUJoyxtA4zevqwMPEFgvVwAPOmoVw5XSUA6HOaKT/PvE9v+HL0Igsz7pe+XFyudiigd
 o7PAuGMArGnK62YQ1BKierpRjx7ZY=
X-Gm-Gg: ASbGncu3Znl7PlhQ1FuI/qn5eVPVuTP+laO4S/Nzxv/P5LqnvOh/vLLLQGbDUuRfANb
 Z71abHyRyr3BtszzvYTrFYBIbbJaz38OQbh8bEHEyEreM/QZw+9HPeCl8/vrZZGj7MyA7H7cukW
 pODWtDQXlHOk7FDJEmpIZA8B1B/yR0
X-Received: by 2002:a17:90b:3b82:b0:2ee:d96a:5816 with SMTP id
 98e67ed59e1d1-2fce789ba20mr24099301a91.10.1740409681078; 
 Mon, 24 Feb 2025 07:08:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvc03Dz//FNWtDIkdS2pKa7xzS1+9SmI98ioZvQ9ElX2VlSPdi2A0Rg2eBeiqOZeBiuGz+JTh9V7wG+Ei6PAk=
X-Received: by 2002:a17:90b:3b82:b0:2ee:d96a:5816 with SMTP id
 98e67ed59e1d1-2fce789ba20mr24099276a91.10.1740409680787; Mon, 24 Feb 2025
 07:08:00 -0800 (PST)
MIME-Version: 1.0
References: <20250224033741.222749-1-jsnow@redhat.com>
 <20250224033741.222749-3-jsnow@redhat.com>
 <87o6yrfrjc.fsf@pond.sub.org>
In-Reply-To: <87o6yrfrjc.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 24 Feb 2025 10:07:49 -0500
X-Gm-Features: AWEUYZnbTvNwn8x8nwtvL1lwL37dHBJ3hssu7rnVIdvFHsIBr1e0gwXYcOJULuM
Message-ID: <CAFn=p-Y-jr289LnWULq60Fj=+dA2=CHhRQ7wQD-NZGwKUk3tLQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] python: add qapi static analysis tests
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c9a596062ee4b4a1"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000c9a596062ee4b4a1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 7:36=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Update the python tests to also check qapi. No idea why I didn't do thi=
s
> > before. I guess I was counting on moving it under python/ and then just
> > forgot after that was NACKed. Oops, this turns out to be really easy.
> >
> > flake8, isort and mypy use the tool configuration from the existing
> > python directory. pylint continues to use the special configuration
> > located in scripts/qapi/ - that configuration is more permissive. If we
> > wish to unify the two configurations, that's a separate series and a
> > discussion for a later date.
> >
> > As a result of this patch, one would be able to run any of the followin=
g
> > tests locally from the qemu.git/python directory and have it cover the
> > scripts/qapi/ module as well. All of the following options run the
> > python tests, static analysis tests, and linter checks; but with
> > different combinations of dependencies and interpreters.
> >
> > - "make check-minreqs" Run tests specifically under our oldest supporte=
d
> >   Python and our oldest supported dependencies. This is the test that
> >   runs on GitLab as "check-python-minreqs". This helps ensure we do not
> >   regress support on older platforms accidentally.
> >
> > - "make check-tox" Runs the tests under the newest supported
> >   dependencies, but under each supported version of Python in turn. At
> >   time of writing, this is Python 3.8 to 3.13 inclusive. This test help=
s
> >   catch bleeding-edge problems before they become problems for develope=
r
> >   workstations. This is the GitLab test "check-python-tox" and is an
> >   optionally run, may-fail test due to the unpredictable nature of new
> >   dependencies being released into the ecosystem that may cause
> >   regressions.
> >
> > - "make check-dev" Runs the tests under the newest supported
> >   dependencies using whatever version of Python the user happens to hav=
e
> >   installed. This is a quick convenience check that does not map to any
> >   particular GitLab test.
> >
> > (Note! check-dev may be busted on Fedora 41 and bleeding edge versions
>
> It is for me.
>
> > of setuptools. That's unrelated to this patch and I'll address it
> > separately and soon. Thank you for your patience, --mgmt)
>
> Which of these tests, if any, run in "make check"?  In CI?
>

Under "make check", the top-level test in qemu.git, none. I swear on my
future grave I am trying to fix that, but there are barriers to it. Adding
make check support means installing testing dependencies in the configure
venv, which means a slower ./configure invocation. I am trying to figure
out how to minimize this penalty for cases where we either do not want to,
or can't, run the python tests. It's a long story, we can talk about it
later.

In CI, the "check-minreqs" test will run by default as a must-pass test
under the job "check python minreqs".

"check-tox" is an optional job in the CI pipeline that is allowed to fail
as a warning, due to the nature of this test checking bleeding edge
dependencies.

All three local invocations run the exact same tests (literally "make
check" in the python dir), just under different combinations of
dependencies and python versions. "check-minreqs" is more or less the
"canonical" one that *must* succeed, but as a Python maintainer I do my
best to enforce "check-tox" as well, though it does lag behind.

So, this isn't a perfect solution yet but it's certainly much better than
carrying around ad-hoc linter shell scripts and attempting to manage the
dependencies yourself. At least we all have access to the same invocations.


>
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
>

--000000000000c9a596062ee4b4a1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 24,=
 2025 at 7:36=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Update the python tests to also check qapi. No idea why I didn&#39;t d=
o this<br>
&gt; before. I guess I was counting on moving it under python/ and then jus=
t<br>
&gt; forgot after that was NACKed. Oops, this turns out to be really easy.<=
br>
&gt;<br>
&gt; flake8, isort and mypy use the tool configuration from the existing<br=
>
&gt; python directory. pylint continues to use the special configuration<br=
>
&gt; located in scripts/qapi/ - that configuration is more permissive. If w=
e<br>
&gt; wish to unify the two configurations, that&#39;s a separate series and=
 a<br>
&gt; discussion for a later date.<br>
&gt;<br>
&gt; As a result of this patch, one would be able to run any of the followi=
ng<br>
&gt; tests locally from the qemu.git/python directory and have it cover the=
<br>
&gt; scripts/qapi/ module as well. All of the following options run the<br>
&gt; python tests, static analysis tests, and linter checks; but with<br>
&gt; different combinations of dependencies and interpreters.<br>
&gt;<br>
&gt; - &quot;make check-minreqs&quot; Run tests specifically under our olde=
st supported<br>
&gt;=C2=A0 =C2=A0Python and our oldest supported dependencies. This is the =
test that<br>
&gt;=C2=A0 =C2=A0runs on GitLab as &quot;check-python-minreqs&quot;. This h=
elps ensure we do not<br>
&gt;=C2=A0 =C2=A0regress support on older platforms accidentally.<br>
&gt;<br>
&gt; - &quot;make check-tox&quot; Runs the tests under the newest supported=
<br>
&gt;=C2=A0 =C2=A0dependencies, but under each supported version of Python i=
n turn. At<br>
&gt;=C2=A0 =C2=A0time of writing, this is Python 3.8 to 3.13 inclusive. Thi=
s test helps<br>
&gt;=C2=A0 =C2=A0catch bleeding-edge problems before they become problems f=
or developer<br>
&gt;=C2=A0 =C2=A0workstations. This is the GitLab test &quot;check-python-t=
ox&quot; and is an<br>
&gt;=C2=A0 =C2=A0optionally run, may-fail test due to the unpredictable nat=
ure of new<br>
&gt;=C2=A0 =C2=A0dependencies being released into the ecosystem that may ca=
use<br>
&gt;=C2=A0 =C2=A0regressions.<br>
&gt;<br>
&gt; - &quot;make check-dev&quot; Runs the tests under the newest supported=
<br>
&gt;=C2=A0 =C2=A0dependencies using whatever version of Python the user hap=
pens to have<br>
&gt;=C2=A0 =C2=A0installed. This is a quick convenience check that does not=
 map to any<br>
&gt;=C2=A0 =C2=A0particular GitLab test.<br>
&gt;<br>
&gt; (Note! check-dev may be busted on Fedora 41 and bleeding edge versions=
<br>
<br>
It is for me.<br>
<br>
&gt; of setuptools. That&#39;s unrelated to this patch and I&#39;ll address=
 it<br>
&gt; separately and soon. Thank you for your patience, --mgmt)<br>
<br>
Which of these tests, if any, run in &quot;make check&quot;?=C2=A0 In CI?<b=
r></blockquote><div><br></div><div>Under &quot;make check&quot;, the top-le=
vel test in qemu.git, none. I swear on my future grave I am trying to fix t=
hat, but there are barriers to it. Adding make check support means installi=
ng testing dependencies in the configure venv, which means a slower ./confi=
gure invocation. I am trying to figure out how to minimize this penalty for=
 cases where we either do not want to, or can&#39;t, run the python tests. =
It&#39;s a long story, we can talk about it later.</div><div><br></div><div=
>In CI, the &quot;check-minreqs&quot; test will run by default as a must-pa=
ss test under the job &quot;check python minreqs&quot;.</div><div><br></div=
><div>&quot;check-tox&quot; is an optional job in the CI pipeline that is a=
llowed to fail as a warning, due to the nature of this test checking bleedi=
ng edge dependencies.</div><div><br></div><div>All three local invocations =
run the exact same tests (literally &quot;make check&quot; in the python di=
r), just under different combinations of dependencies and python versions. =
&quot;check-minreqs&quot; is more or less the &quot;canonical&quot; one tha=
t *must* succeed, but as a Python maintainer I do my best to enforce &quot;=
check-tox&quot; as well, though it does lag behind.</div><div><br></div><di=
v>So, this isn&#39;t a perfect solution yet but it&#39;s certainly much bet=
ter than carrying around ad-hoc linter shell scripts and attempting to mana=
ge the dependencies yourself. At least we all have access to the same invoc=
ations.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
</blockquote></div></div>

--000000000000c9a596062ee4b4a1--


