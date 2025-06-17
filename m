Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5106CC71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 16:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYgv-0005km-4X; Tue, 17 Jun 2025 11:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uRYah-0003JP-H7
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:51:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uRYaZ-0007tT-BM
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:51:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750175464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ij8NYSSMenjjSFxZs3giIe9GEqhsx+TmnIkLQvZSTEc=;
 b=MhEMpdLcE35kuyx2+AC7rMRJ/zm60uEPDujKUgVOT7KaFiNMhkjiBSUWCKravEBmKz9URk
 zTNT83QH1KPTkoUIbNg2v6pRJ7KLDCET6u1anc1Lik5VivjVejiBGBdDsXqy8GrTLOLRb9
 573JKi7O9uqvkO7LM82uAh4uTcbVyTI=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-S5zIN99HPvytjfPQXlxQrw-1; Tue, 17 Jun 2025 11:51:03 -0400
X-MC-Unique: S5zIN99HPvytjfPQXlxQrw-1
X-Mimecast-MFC-AGG-ID: S5zIN99HPvytjfPQXlxQrw_1750175462
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-23632fd6248so53666035ad.3
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 08:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750175462; x=1750780262;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ij8NYSSMenjjSFxZs3giIe9GEqhsx+TmnIkLQvZSTEc=;
 b=W6CJzkiLs0OuPYtb+8TM4lHdBgOtZ4kVVfsdxPoShOk+CbrjXZ4SvMVLh1RpdVQNfe
 /GaXQ73sD6Z6mzZiddZfllB/LF/qXW6FWn9AOyFw6cCE/Q2fCDdOkR5ySqzuakCCYWTI
 9BiUdctWHfUGpwgeh8mSpIKQb8bNK0SBcr0B5/SJXOeV7Jvt/Wg4FwYDrVyDIQIAEJQJ
 4/5uHgccuaZGtEGrfd7L2fNPC6vaJUWuDwXqZDHSMhQxBxpTAGSVbkKdRAYV4dYQs8AS
 dmWpjszMgZhkf4oJDNI4uOMKJV0CZYokWDRt17YnJJz46QM6eVo86pFQ/XzA4NxjNPsf
 Myhg==
X-Gm-Message-State: AOJu0Yx7n/cavptfDr8HMZUljVXRq0P80uIWUpUGhbhR/C4uxzMcnhr+
 /A1wev4R2M0s/gEkJiFZREAo3m3bj8qfablrIyRnVTga3V9asUHm9eNSzXy+3NVgQOjzSmixdVQ
 FyUABdttSLT8vXsXGoYHv/iJ6tqLftn8NbbF4SwwP7QGJUpyXJ7+2fK6pYc7pHH7E1/w5+q8A+w
 vngmW+TGItMV9PSwAG18KBzbh+7gl0idw=
X-Gm-Gg: ASbGncu6n2/NeSvh+u17Tdt4X7aFHlmxh4+Y3qJ58PBsfv2XeZRy+iyALFFREM+ODtx
 7UCvMypnaz8LtcQCmINGfk/mFj51voBhwlTzzZTS1saTruvs6UBHOv9/4flYrRLkxdBqUvaHxPk
 bevaNKRnwDVunxpw1I0twx9JA6tldRwQZQcA==
X-Received: by 2002:a17:903:1a6f:b0:235:129e:f649 with SMTP id
 d9443c01a7336-2366b344077mr234754675ad.12.1750175462254; 
 Tue, 17 Jun 2025 08:51:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtTzXh6LlNWKP7ymNNJsvVTpgxfJua3u+aUre0j79huvhr6+srLljvBna6psEyc+evmxsXsSl7A+ab9r1LPwQ=
X-Received: by 2002:a17:903:1a6f:b0:235:129e:f649 with SMTP id
 d9443c01a7336-2366b344077mr234754425ad.12.1750175461898; Tue, 17 Jun 2025
 08:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250605182014.561172-1-jsnow@redhat.com>
 <20250605182014.561172-5-jsnow@redhat.com>
 <87plf2vbhl.fsf@pond.sub.org>
In-Reply-To: <87plf2vbhl.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 17 Jun 2025 11:50:47 -0400
X-Gm-Features: AX0GCFuK4BY6UUwUbbVqmC2AjvOnwzEQ0Iuk22_FaylhZiFsx0kvcKaP6yCg5B8
Message-ID: <CAFn=p-YaD8go58--Tyrxg7XNjEekc=RwSjtMgk15=DoKNNegzQ@mail.gmail.com>
Subject: Re: [PULL v2 4/6] python: add qapi static analysis tests
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000b3a3b80637c67ad4"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000b3a3b80637c67ad4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025, 7:44=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Update the python tests to also check QAPI and the QAPI Sphinx
> > extensions. The docs/sphinx/qapidoc_legacy.py file is not included in
> > these checks, as it is destined for removal soon. mypy is also not
> > called on the QAPI Sphinx extensions, owing to difficulties supporting
> > Sphinx 3.x - 8.x while maintaining static type checking support. mypy
> > *is* called on all of the QAPI tools themselves, though.
> >
> > flake8, isort and mypy use the tool configuration from the existing
> > python directory (in setup.cfg). pylint continues to use the special
> > configuration located in scripts/qapi/ - that configuration is more
> > permissive. If we wish to unify the two configurations, that's a
> > separate series and a discussion for a later date.
> >
> > The list of pylint ignores is also updated, owing again to the wide
> > window of pylint version support: newer versions require pragmas to
> > occasionally silence the "too many positional arguments" warning, but
> > older versions do not have such a warning category and will instead yel=
p
> > about an unrecognized option. Silence that warning, too.
> >
> > As a result of this patch, one would be able to run any of the followin=
g
> > tests locally from the qemu.git/python directory and have it cover the
> > QAPI tooling as well. All of the following options run the python tests=
,
> > static analysis tests, and linter checks; but with different
> > combinations of dependencies and interpreters.
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
>
> Missed this: it's 3.9 since
>
> commit d64db833d6e3cbe9ea5f36342480f920f3675cea
> Author: Thomas Huth <thuth@redhat.com>
> Date:   Fri Apr 25 14:07:10 2025 +0200
>
>     Drop support for Python 3.8
>
>     Python 3.8 went "end of life" in October 2024 and Fedora 42 dropped
>     this version already, so the "python" CI job is currently failing.
>     Thus it's time to drop support for this Python version in QEMU, too.
>
>     While we're at it, also look for "python3.13" in the configure script=
.
>
>     Message-ID: <20250425120710.879518-1-thuth@redhat.com>
>     Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>     Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>     Signed-off-by: Thomas Huth <thuth@redhat.com>
>
> Too late to adjust the commit message.  Is there anything else in need
> of adjustment?
>
> [...]
>

Will handle in my 3.9+ series. Unfortunate merge timing.

Other adjustments are made in that series as well. Unfortunately Akihiko
points out that my conversion to pyproject.toml may not yet be safe given
our platform guarantees, so I may need to re-investigate. :(

--js

>

--000000000000b3a3b80637c67ad4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jun 17, 2025, 7:44=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">John Snow &l=
t;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Update the python tests to also check QAPI and the QAPI Sphinx<br>
&gt; extensions. The docs/sphinx/qapidoc_legacy.py file is not included in<=
br>
&gt; these checks, as it is destined for removal soon. mypy is also not<br>
&gt; called on the QAPI Sphinx extensions, owing to difficulties supporting=
<br>
&gt; Sphinx 3.x - 8.x while maintaining static type checking support. mypy<=
br>
&gt; *is* called on all of the QAPI tools themselves, though.<br>
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
&gt; The list of pylint ignores is also updated, owing again to the wide<br=
>
&gt; window of pylint version support: newer versions require pragmas to<br=
>
&gt; occasionally silence the &quot;too many positional arguments&quot; war=
ning, but<br>
&gt; older versions do not have such a warning category and will instead ye=
lp<br>
&gt; about an unrecognized option. Silence that warning, too.<br>
&gt;<br>
&gt; As a result of this patch, one would be able to run any of the followi=
ng<br>
&gt; tests locally from the qemu.git/python directory and have it cover the=
<br>
&gt; QAPI tooling as well. All of the following options run the python test=
s,<br>
&gt; static analysis tests, and linter checks; but with different<br>
&gt; combinations of dependencies and interpreters.<br>
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
<br>
Missed this: it&#39;s 3.9 since<br>
<br>
commit d64db833d6e3cbe9ea5f36342480f920f3675cea<br>
Author: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com" target=3D"_blan=
k" rel=3D"noreferrer">thuth@redhat.com</a>&gt;<br>
Date:=C2=A0 =C2=A0Fri Apr 25 14:07:10 2025 +0200<br>
<br>
=C2=A0 =C2=A0 Drop support for Python 3.8<br>
<br>
=C2=A0 =C2=A0 Python 3.8 went &quot;end of life&quot; in October 2024 and F=
edora 42 dropped<br>
=C2=A0 =C2=A0 this version already, so the &quot;python&quot; CI job is cur=
rently failing.<br>
=C2=A0 =C2=A0 Thus it&#39;s time to drop support for this Python version in=
 QEMU, too.<br>
<br>
=C2=A0 =C2=A0 While we&#39;re at it, also look for &quot;python3.13&quot; i=
n the configure script.<br>
<br>
=C2=A0 =C2=A0 Message-ID: &lt;<a href=3D"mailto:20250425120710.879518-1-thu=
th@redhat.com" target=3D"_blank" rel=3D"noreferrer">20250425120710.879518-1=
-thuth@redhat.com</a>&gt;<br>
=C2=A0 =C2=A0 Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailt=
o:philmd@linaro.org" target=3D"_blank" rel=3D"noreferrer">philmd@linaro.org=
</a>&gt;<br>
=C2=A0 =C2=A0 Reviewed-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:be=
rrange@redhat.com" target=3D"_blank" rel=3D"noreferrer">berrange@redhat.com=
</a>&gt;<br>
=C2=A0 =C2=A0 Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat=
.com" target=3D"_blank" rel=3D"noreferrer">thuth@redhat.com</a>&gt;<br>
<br>
Too late to adjust the commit message.=C2=A0 Is there anything else in need=
<br>
of adjustment?<br>
<br>
[...]<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Will handle in my 3.9+ series. Unfortunate merge timing.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Other adjustments are made in that se=
ries as well. Unfortunately Akihiko points out that my conversion to pyproj=
ect.toml may not yet be safe given our platform guarantees, so I may need t=
o re-investigate. :(</div><div dir=3D"auto"><br></div><div dir=3D"auto">--j=
s</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000b3a3b80637c67ad4--


