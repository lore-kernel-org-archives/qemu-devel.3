Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99317C3600B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 16:57:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx7aI-00005j-K5; Tue, 25 Mar 2025 12:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tx7aF-00005W-5u
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 12:56:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tx7aB-0005Qd-A3
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 12:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742921813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hTiTSZV3wpDPsSRNLYlg+WX5QLGjj3mNYp68WN32RAQ=;
 b=fLma7SBOth6zo/l8b2kR8qhbmZ3WlsJ11sSY0yW28BsCl+9WewWamC+lZ/Ck5ubW1Hampj
 y5F1x6HMw2cUJSWalM6WWrUtIlCKComFNeif6Z2OcGhh5ygvPoStEpI/B0XDERG8To86tf
 rRPK4X9h0/YgW4SL/B45JQJksbDGkEA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-Rq_N1DvnOECE52KQLkNW9g-1; Tue, 25 Mar 2025 12:56:51 -0400
X-MC-Unique: Rq_N1DvnOECE52KQLkNW9g-1
X-Mimecast-MFC-AGG-ID: Rq_N1DvnOECE52KQLkNW9g_1742921810
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ff5296726fso16461998a91.0
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 09:56:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742921810; x=1743526610;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hTiTSZV3wpDPsSRNLYlg+WX5QLGjj3mNYp68WN32RAQ=;
 b=dx+TpAgkYMPSGX4xc1aEEdQeRDEAEiqqp2NfkRLU9OwoQcgh6TsZXKTi0GifOiUmfV
 WMST+nCLDn/1IyQ4HLi8HfsB9N8XrI1U/BeknlYUXUs5bFm7dqReAhcMu0zFSU8ZekAq
 kzeUok92bXWvi1Nkknqw6z7ip/HIQ0xh3bKqcpRucz42njoJAuoeytFY6ve+X8S+Pwe0
 0CZQq5KL3UuRZdfJyeBQl/8gYgQTVZG5za5G7Zd9dE3ptOYZlyNZzvSRD117EotVQRHo
 UGTNUUX8bjTYWwDlXqEud0iB3gMY0eoIdwZFpSVALIyiVqZBATL/R5xnUwBsj7kcndOc
 /FDQ==
X-Gm-Message-State: AOJu0YyieKLfIwx5M9lx41l8mSGO0G1ARMyKWWi0VnVMczLgY2CcN4pu
 mq0bg/NMDiLlv6odYgkqc37XNDoGM0nmFl2CSuGRsjyNrVJS20k1uQPDxvAtB3DtSRXVmLo7ZhO
 g9450EaMI8if2BQdlByacU1yW90aIhVRLWQzVhohSIQr4B0mJAZ+spwTmAf3qb/OJdyVnas9sX4
 yHFVot3sghtIGcbLO3lzHlAqHq4bc=
X-Gm-Gg: ASbGncuF5kAhE5phKCehG+M0vZXA/Ci8XU+Stx0akZUHtS73KsUlV+pMELbuPNMt/eG
 R5QgN38NNcUrh0fmb5yOgpxDlqklerqPntnVNqkj2hvBKeakZ9OmJ7ZqvdUwJBRq8+HoKAw5ZtM
 QOKsWFRw501MitBDw2V9Cgal19L2PD
X-Received: by 2002:a17:90b:1848:b0:2ea:bf1c:1e3a with SMTP id
 98e67ed59e1d1-3030fe9e646mr34086671a91.12.1742921810260; 
 Tue, 25 Mar 2025 09:56:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWEudnCl6VC9cp4+5oDzz2yL02RcGc5JR2lnx/THykKYxzp2jSMRN4FSmbSS67IkMHJwe/CVv4nQo4BLGYtXc=
X-Received: by 2002:a17:90b:1848:b0:2ea:bf1c:1e3a with SMTP id
 98e67ed59e1d1-3030fe9e646mr34086622a91.12.1742921809743; Tue, 25 Mar 2025
 09:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250321222347.299121-1-jsnow@redhat.com>
 <20250321222347.299121-5-jsnow@redhat.com>
 <87jz8dpmwa.fsf@pond.sub.org>
In-Reply-To: <87jz8dpmwa.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 25 Mar 2025 12:56:37 -0400
X-Gm-Features: AQ5f1JrD4XXoM8wymACY7ZwmiPvUrpBSf4MOdrC2qmw5xvGe1FjN1EwLnao3qL0
Message-ID: <CAFn=p-brXaJZBxUsJAQGsPvOF7MovAWfH3bdMMHQYCrkJWQVeA@mail.gmail.com>
Subject: Re: [PATCH 4/5] python: add qapi static analysis tests
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000576a6c06312d9b40"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

--000000000000576a6c06312d9b40
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 3:53=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Update the python tests to also check qapi. No idea why I didn't do thi=
s
> > before. I guess I was counting on moving it under python/ and then just
> > forgot after that was NACKed. Oops, this turns out to be really easy.
> >
> > flake8, isort and mypy use the tool configuration from the existing
> > python directory (in setup.cfg). pylint continues to use the special
> > configuration located in scripts/qapi/ - that configuration is more
> > permissive. If we wish to unify the two configurations, that's a
> > separate series and a discussion for a later date.
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
> > of setuptools. That's unrelated to this patch and I'll address it
> > separately and soon. Thank you for your patience, --mgmt)
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> Let's mention this is a step towards having "make check" run the static
> analysis we want developers to run, but we're not there, yet.
>

It both is and isn't. That we can now check qapi and the qapi sphinx
extensions from the same place as we do linting for python/ is sufficient
justification in and of itself, regardless of how we improve and integrate
this testing later on.


>
> > ---
> >  python/setup.cfg            |  1 +
> >  python/tests/minreqs.txt    | 21 +++++++++++++++++++++
> >  python/tests/qapi-flake8.sh |  4 ++++
> >  python/tests/qapi-isort.sh  |  6 ++++++
> >  python/tests/qapi-mypy.sh   |  2 ++
> >  python/tests/qapi-pylint.sh |  6 ++++++
> >  scripts/qapi/pylintrc       |  1 +
> >  7 files changed, 41 insertions(+)
> >  create mode 100755 python/tests/qapi-flake8.sh
> >  create mode 100755 python/tests/qapi-isort.sh
> >  create mode 100755 python/tests/qapi-mypy.sh
> >  create mode 100755 python/tests/qapi-pylint.sh
> >
> > diff --git a/python/setup.cfg b/python/setup.cfg
> > index cf5af7e6641..84d8a1fd30d 100644
> > --- a/python/setup.cfg
> > +++ b/python/setup.cfg
> > @@ -47,6 +47,7 @@ devel =3D
> >      urwid >=3D 2.1.2
> >      urwid-readline >=3D 0.13
> >      Pygments >=3D 2.9.0
> > +    sphinx >=3D 3.4.3
> >
> >  # Provides qom-fuse functionality
> >  fuse =3D
> > diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt
> > index 19c0f5e4c50..94928936d44 100644
> > --- a/python/tests/minreqs.txt
> > +++ b/python/tests/minreqs.txt
> > @@ -11,6 +11,9 @@
> >  # When adding new dependencies, pin the very oldest non-yanked version
> >  # on PyPI that allows the test suite to pass.
> >
> > +# Dependencies for qapidoc/qapi_domain et al
> > +sphinx=3D=3D3.4.3
> > +
> >  # Dependencies for the TUI addon (Required for successful linting)
> >  urwid=3D=3D2.1.2
> >  urwid-readline=3D=3D0.13
> > @@ -49,3 +52,21 @@ platformdirs=3D=3D2.2.0
> >  toml=3D=3D0.10.0
> >  tomlkit=3D=3D0.10.1
> >  wrapt=3D=3D1.14.0
> > +
> > +# Transitive sphinx dependencies
> > +Jinja2=3D=3D2.7
> > +MarkupSafe=3D=3D1.1.0
> > +alabaster=3D=3D0.7.1
> > +babel=3D=3D1.3
> > +docutils=3D=3D0.12
> > +imagesize=3D=3D0.5.0
> > +packaging=3D=3D14.0
> > +pytz=3D=3D2011b0
> > +requests=3D=3D2.5.0
> > +snowballstemmer=3D=3D1.1
> > +sphinxcontrib-applehelp=3D=3D1.0.0
> > +sphinxcontrib-devhelp=3D=3D1.0.0
> > +sphinxcontrib-htmlhelp=3D=3D1.0.0
> > +sphinxcontrib-jsmath=3D=3D1.0.0
> > +sphinxcontrib-qthelp=3D=3D1.0.0
> > +sphinxcontrib-serializinghtml=3D=3D1.0.0
>
> This wasn't there when I last saw this patch.  The previous patch also
> updates this file.  How did you decide which updates go where?  Or is
> this an accident?
>

The previous patch pins dependencies that already existed, but we neglected
to pin in this file. It's fixing an existing oversight.

This patch adds a bunch of new pinned dependencies for Sphinx, which we
need for type-checking Sphinx extensions.


>
> > diff --git a/python/tests/qapi-flake8.sh b/python/tests/qapi-flake8.sh
> > new file mode 100755
> > index 00000000000..7b5983d64a9
> > --- /dev/null
> > +++ b/python/tests/qapi-flake8.sh
> > @@ -0,0 +1,4 @@
> > +#!/bin/sh -e
> > +python3 -m flake8 ../scripts/qapi/ \
> > +        ../docs/sphinx/qapidoc.py \
> > +        ../docs/sphinx/qapi_domain.py
>
> Not linting docs/sphinx/qapidoc_legacy.py.  This is intentional (see its
> initial commit message).  Since we plan to drop it soon, there's no real
> need for a comment here, but mentioning it in the commit message
> wouldn't hurt.
>

Alright.


>
> > diff --git a/python/tests/qapi-isort.sh b/python/tests/qapi-isort.sh
> > new file mode 100755
> > index 00000000000..f31f12d3425
> > --- /dev/null
> > +++ b/python/tests/qapi-isort.sh
> > @@ -0,0 +1,6 @@
> > +#!/bin/sh -e
> > +python3 -m isort --sp . -c ../scripts/qapi/
> > +# Force isort to recognize "compat" as a local module and not
> third-party
> > +python3 -m isort --sp . -c -p compat -p qapidoc_legacy \
> > +        ../docs/sphinx/qapi_domain.py \
> > +        ../docs/sphinx/qapidoc.py
>
> Comment on flake8 applies.
>
> > diff --git a/python/tests/qapi-mypy.sh b/python/tests/qapi-mypy.sh
> > new file mode 100755
> > index 00000000000..377b29b873b
> > --- /dev/null
> > +++ b/python/tests/qapi-mypy.sh
> > @@ -0,0 +1,2 @@
> > +#!/bin/sh -e
> > +python3 -m mypy ../scripts/qapi
>
> Not type-checking docs/sphinx/qapi_domain.py and docs/sphinx/qapidoc.py?
> Impractical due to us targeting an isanely wide Sphinx version range?
>

Yes.


>
> > diff --git a/python/tests/qapi-pylint.sh b/python/tests/qapi-pylint.sh
> > new file mode 100755
> > index 00000000000..f4bb7a5a795
> > --- /dev/null
> > +++ b/python/tests/qapi-pylint.sh
> > @@ -0,0 +1,6 @@
> > +#!/bin/sh -e
> > +SETUPTOOLS_USE_DISTUTILS=3Dstdlib python3 -m pylint \
> > +                                --rcfile=3D../scripts/qapi/pylintrc \
> > +                                ../scripts/qapi/ \
> > +                                ../docs/sphinx/qapidoc.py \
> > +                                ../docs/sphinx/qapi_domain.py
>
> Comment on flake8 applies.
>
> > diff --git a/scripts/qapi/pylintrc b/scripts/qapi/pylintrc
> > index d24eece7411..e16283ada3d 100644
> > --- a/scripts/qapi/pylintrc
> > +++ b/scripts/qapi/pylintrc
> > @@ -19,6 +19,7 @@ disable=3Dconsider-using-f-string,
> >          too-many-instance-attributes,
> >          too-many-positional-arguments,
> >          too-many-statements,
> > +        unknown-option-value,
> >          useless-option-value,
> >
> >  [REPORTS]
>
> This wasn't there when I last saw this patch.  PATCH 1 also updates this
> file.  How did you decide which updates go where?  Or is this an
> accident?


I didn't add the Sphinx extensions last time you saw this series, so that's
new. This winds up being needed to tolerate the "too many positional
arguments" option which only applies to newer pylint versions - older
versions will complain about the option being unrecognized. In order to
continue allowing a wide version of pylint versions, we need this option.

--000000000000576a6c06312d9b40
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 25,=
 2025 at 3:53=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
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
&gt; python directory (in setup.cfg). pylint continues to use the special<b=
r>
&gt; configuration located in scripts/qapi/ - that configuration is more<br=
>
&gt; permissive. If we wish to unify the two configurations, that&#39;s a<b=
r>
&gt; separate series and a discussion for a later date.<br>
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
&gt; of setuptools. That&#39;s unrelated to this patch and I&#39;ll address=
 it<br>
&gt; separately and soon. Thank you for your patience, --mgmt)<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
Let&#39;s mention this is a step towards having &quot;make check&quot; run =
the static<br>
analysis we want developers to run, but we&#39;re not there, yet.<br></bloc=
kquote><div><br></div><div>It both is and isn&#39;t. That we can now check =
qapi and the qapi sphinx extensions from the same place as we do linting fo=
r python/ is sufficient justification in and of itself, regardless of how w=
e improve and integrate this testing later on.</div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; ---<br>
&gt;=C2=A0 python/setup.cfg=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 1 +<br>
&gt;=C2=A0 python/tests/minreqs.txt=C2=A0 =C2=A0 | 21 +++++++++++++++++++++=
<br>
&gt;=C2=A0 python/tests/qapi-flake8.sh |=C2=A0 4 ++++<br>
&gt;=C2=A0 python/tests/qapi-isort.sh=C2=A0 |=C2=A0 6 ++++++<br>
&gt;=C2=A0 python/tests/qapi-mypy.sh=C2=A0 =C2=A0|=C2=A0 2 ++<br>
&gt;=C2=A0 python/tests/qapi-pylint.sh |=C2=A0 6 ++++++<br>
&gt;=C2=A0 scripts/qapi/pylintrc=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
&gt;=C2=A0 7 files changed, 41 insertions(+)<br>
&gt;=C2=A0 create mode 100755 python/tests/qapi-flake8.sh<br>
&gt;=C2=A0 create mode 100755 python/tests/qapi-isort.sh<br>
&gt;=C2=A0 create mode 100755 python/tests/qapi-mypy.sh<br>
&gt;=C2=A0 create mode 100755 python/tests/qapi-pylint.sh<br>
&gt;<br>
&gt; diff --git a/python/setup.cfg b/python/setup.cfg<br>
&gt; index cf5af7e6641..84d8a1fd30d 100644<br>
&gt; --- a/python/setup.cfg<br>
&gt; +++ b/python/setup.cfg<br>
&gt; @@ -47,6 +47,7 @@ devel =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 urwid &gt;=3D 2.1.2<br>
&gt;=C2=A0 =C2=A0 =C2=A0 urwid-readline &gt;=3D 0.13<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Pygments &gt;=3D 2.9.0<br>
&gt; +=C2=A0 =C2=A0 sphinx &gt;=3D 3.4.3<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 # Provides qom-fuse functionality<br>
&gt;=C2=A0 fuse =3D<br>
&gt; diff --git a/python/tests/minreqs.txt b/python/tests/minreqs.txt<br>
&gt; index 19c0f5e4c50..94928936d44 100644<br>
&gt; --- a/python/tests/minreqs.txt<br>
&gt; +++ b/python/tests/minreqs.txt<br>
&gt; @@ -11,6 +11,9 @@<br>
&gt;=C2=A0 # When adding new dependencies, pin the very oldest non-yanked v=
ersion<br>
&gt;=C2=A0 # on PyPI that allows the test suite to pass.<br>
&gt;=C2=A0 <br>
&gt; +# Dependencies for qapidoc/qapi_domain et al<br>
&gt; +sphinx=3D=3D3.4.3<br>
&gt; +<br>
&gt;=C2=A0 # Dependencies for the TUI addon (Required for successful lintin=
g)<br>
&gt;=C2=A0 urwid=3D=3D2.1.2<br>
&gt;=C2=A0 urwid-readline=3D=3D0.13<br>
&gt; @@ -49,3 +52,21 @@ platformdirs=3D=3D2.2.0<br>
&gt;=C2=A0 toml=3D=3D0.10.0<br>
&gt;=C2=A0 tomlkit=3D=3D0.10.1<br>
&gt;=C2=A0 wrapt=3D=3D1.14.0<br>
&gt; +<br>
&gt; +# Transitive sphinx dependencies<br>
&gt; +Jinja2=3D=3D2.7<br>
&gt; +MarkupSafe=3D=3D1.1.0<br>
&gt; +alabaster=3D=3D0.7.1<br>
&gt; +babel=3D=3D1.3<br>
&gt; +docutils=3D=3D0.12<br>
&gt; +imagesize=3D=3D0.5.0<br>
&gt; +packaging=3D=3D14.0<br>
&gt; +pytz=3D=3D2011b0<br>
&gt; +requests=3D=3D2.5.0<br>
&gt; +snowballstemmer=3D=3D1.1<br>
&gt; +sphinxcontrib-applehelp=3D=3D1.0.0<br>
&gt; +sphinxcontrib-devhelp=3D=3D1.0.0<br>
&gt; +sphinxcontrib-htmlhelp=3D=3D1.0.0<br>
&gt; +sphinxcontrib-jsmath=3D=3D1.0.0<br>
&gt; +sphinxcontrib-qthelp=3D=3D1.0.0<br>
&gt; +sphinxcontrib-serializinghtml=3D=3D1.0.0<br>
<br>
This wasn&#39;t there when I last saw this patch.=C2=A0 The previous patch =
also<br>
updates this file.=C2=A0 How did you decide which updates go where?=C2=A0 O=
r is<br>
this an accident?<br></blockquote><div><br></div><div>The previous patch pi=
ns dependencies that already existed, but we neglected to pin in this file.=
 It&#39;s fixing an existing oversight.</div><div><br></div><div>This patch=
 adds a bunch of new pinned dependencies for Sphinx, which we need for type=
-checking Sphinx extensions.</div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
<br>
&gt; diff --git a/python/tests/qapi-flake8.sh b/python/tests/qapi-flake8.sh=
<br>
&gt; new file mode 100755<br>
&gt; index 00000000000..7b5983d64a9<br>
&gt; --- /dev/null<br>
&gt; +++ b/python/tests/qapi-flake8.sh<br>
&gt; @@ -0,0 +1,4 @@<br>
&gt; +#!/bin/sh -e<br>
&gt; +python3 -m flake8 ../scripts/qapi/ \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ../docs/sphinx/qapidoc.py \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ../docs/sphinx/qapi_domain.py<br>
<br>
Not linting docs/sphinx/qapidoc_legacy.py.=C2=A0 This is intentional (see i=
ts<br>
initial commit message).=C2=A0 Since we plan to drop it soon, there&#39;s n=
o real<br>
need for a comment here, but mentioning it in the commit message<br>
wouldn&#39;t hurt.<br></blockquote><div><br></div><div>Alright.</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; diff --git a/python/tests/qapi-isort.sh b/python/tests/qapi-isort.sh<b=
r>
&gt; new file mode 100755<br>
&gt; index 00000000000..f31f12d3425<br>
&gt; --- /dev/null<br>
&gt; +++ b/python/tests/qapi-isort.sh<br>
&gt; @@ -0,0 +1,6 @@<br>
&gt; +#!/bin/sh -e<br>
&gt; +python3 -m isort --sp . -c ../scripts/qapi/<br>
&gt; +# Force isort to recognize &quot;compat&quot; as a local module and n=
ot third-party<br>
&gt; +python3 -m isort --sp . -c -p compat -p qapidoc_legacy \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ../docs/sphinx/qapi_domain.py \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ../docs/sphinx/qapidoc.py<br>
<br>
Comment on flake8 applies.<br>
<br>
&gt; diff --git a/python/tests/qapi-mypy.sh b/python/tests/qapi-mypy.sh<br>
&gt; new file mode 100755<br>
&gt; index 00000000000..377b29b873b<br>
&gt; --- /dev/null<br>
&gt; +++ b/python/tests/qapi-mypy.sh<br>
&gt; @@ -0,0 +1,2 @@<br>
&gt; +#!/bin/sh -e<br>
&gt; +python3 -m mypy ../scripts/qapi<br>
<br>
Not type-checking docs/sphinx/qapi_domain.py and docs/sphinx/qapidoc.py?<br=
>
Impractical due to us targeting an isanely wide Sphinx version range?<br></=
blockquote><div><br></div><div>Yes.</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
&gt; diff --git a/python/tests/qapi-pylint.sh b/python/tests/qapi-pylint.sh=
<br>
&gt; new file mode 100755<br>
&gt; index 00000000000..f4bb7a5a795<br>
&gt; --- /dev/null<br>
&gt; +++ b/python/tests/qapi-pylint.sh<br>
&gt; @@ -0,0 +1,6 @@<br>
&gt; +#!/bin/sh -e<br>
&gt; +SETUPTOOLS_USE_DISTUTILS=3Dstdlib python3 -m pylint \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 --rcfile=3D../scripts/qapi/pylin=
trc \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ../scripts/qapi/ \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ../docs/sphinx/qapidoc.py \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ../docs/sphinx/qapi_domain.py<br=
>
<br>
Comment on flake8 applies.<br>
<br>
&gt; diff --git a/scripts/qapi/pylintrc b/scripts/qapi/pylintrc<br>
&gt; index d24eece7411..e16283ada3d 100644<br>
&gt; --- a/scripts/qapi/pylintrc<br>
&gt; +++ b/scripts/qapi/pylintrc<br>
&gt; @@ -19,6 +19,7 @@ disable=3Dconsider-using-f-string,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 too-many-instance-attributes,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 too-many-positional-arguments,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 too-many-statements,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unknown-option-value,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 useless-option-value,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 [REPORTS]<br>
<br>
This wasn&#39;t there when I last saw this patch.=C2=A0 PATCH 1 also update=
s this<br>
file.=C2=A0 How did you decide which updates go where?=C2=A0 Or is this an<=
br>
accident?</blockquote><div><br></div><div>I didn&#39;t add the Sphinx exten=
sions last time you saw this series, so that&#39;s new. This winds up being=
 needed to tolerate the &quot;too many positional arguments&quot; option wh=
ich only applies to newer pylint versions - older versions will complain ab=
out the option being unrecognized. In order to continue allowing a wide ver=
sion of pylint versions, we need this option. <br></div></div></div>

--000000000000576a6c06312d9b40--


