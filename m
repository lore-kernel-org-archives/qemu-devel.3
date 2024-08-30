Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF987CA0EFD
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 18:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk6HA-0000wP-EO; Fri, 30 Aug 2024 14:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sk6H9-0000v1-3g
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 14:23:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sk6H5-00080b-JE
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 14:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725042186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mGeEKNBKpGT7iBKMk++VTHAxQTbCVnzIVpkQYlIZ1E8=;
 b=M77NGfMVeGfmbJxflIasnYTWv/SizVOFoqqFtOHqmmzrpIjrtOs3hAJT4xNHQ6ZkTxR+gc
 MTi1MX0mDU2likn+nPmmPJaOg1eRq+Vi34hl8uoYZE4tRQKY4CDwSB7N5gTlYS6FB/7qJE
 z316bO8ljl1m5JdQ4NGjJ94vYoXitWI=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-458-29-5IPwmNnuEefqPGjTdRQ-1; Fri, 30 Aug 2024 14:23:04 -0400
X-MC-Unique: 29-5IPwmNnuEefqPGjTdRQ-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2052d07ff07so8997495ad.2
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 11:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725042183; x=1725646983;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mGeEKNBKpGT7iBKMk++VTHAxQTbCVnzIVpkQYlIZ1E8=;
 b=wa3pchnW+9e9+VAxRpSf+Yr2Jyky7oF/ahXH3I06buFT65zbLh3hW/TIFCOEGuwlkF
 PCcxJ0+0IWpix3LuiwYwGtMTB7difYTi77HIzzq+u0ISuy/n9g0dlGwdKZcWfgCDxO6e
 NodeKP5ykjKbpMoT8u9S9K38V2RUsV9Jp3iWIPjhvB4YWcyDdqpVgKUHPh/1Mm9YFPKr
 9pbFzX0asMXxnydP3ghhN/vUwadxx9w2EO2Oc6GecWXG/XEsq9BBExS6fDxzNM47ZCf0
 5FLz2xcnaPv3W84PdkjYtvhxO8vBG81aBsYgqqT8899zxI1UetyG5DnN6P/OaiOagaFx
 omFQ==
X-Gm-Message-State: AOJu0YyCaQLC9OSz9WE6/vl3MBAlkv9hlB2FiS9YnZgvFbG0bAY2VBNb
 m5OsMD5D1RzfDU8veP+GOyVu24cJdz31zoz3L0RbRBJ46YPsw/UKyGOTn+ArjdICXX6gWCmjHEQ
 z4tB6KnkUKly3Ka/sN8yDBaPUK17kaI5as3CjjxnUCr4MBcEjagYVDJjhJqlWpLPG91NLRlgVKP
 thAwQKvkuLE6FKwdNwRNV92pCZ/O0=
X-Received: by 2002:a17:902:d4c7:b0:205:3ae0:a573 with SMTP id
 d9443c01a7336-2053ae0a890mr16848335ad.25.1725042182928; 
 Fri, 30 Aug 2024 11:23:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOlX9VpWKO1pSaMLbuYFGQXfu9fk8hrOSCk8WUh+O2HxKsqPDHJ4Z8eA4QqZHHM8UbEraRvh69TSAvMPXHWNQ=
X-Received: by 2002:a17:902:d4c7:b0:205:3ae0:a573 with SMTP id
 d9443c01a7336-2053ae0a890mr16848035ad.25.1725042182482; Fri, 30 Aug 2024
 11:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240820002318.1380276-1-jsnow@redhat.com>
 <20240820002318.1380276-8-jsnow@redhat.com>
 <87bk1acl4s.fsf@pond.sub.org>
In-Reply-To: <87bk1acl4s.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 30 Aug 2024 14:22:50 -0400
Message-ID: <CAFn=p-a=ob68-_8fkfFMj2AkVtOgL081j4d385n1qXMsN+ehFQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] python/qapi: move scripts/qapi to python/qemu/qapi
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Beraldo Leal <bleal@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000828eed0620eaaedf"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000828eed0620eaaedf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 7:20=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This is being done for the sake of unifying the linting and static type
> > analysis configurations between scripts/qapi and python/qemu/*.
> >
> > With this change, the qapi module will now be checked by mypy, flake8,
> > pylint, isort etc under all python versions from 3.8 through 3.13 under
> > a variety of different dependency configurations in the GitLab testing
> > pipelines.
> >
> > The tests can be run locally, as always:
> >
> >> cd qemu.git/python
> >> make check-minreqs
> >> make check-tox
> >> make check-dev
> >
> > "check-minreqs" is the must-pass GitLab test.
> > "check-tox" is the optional allowed-to-fail GitLab test.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> I don't understand why we have to keep Python code in its own directory
> just to get it checked.  We wouldn't do that say for Rust code, would
> we?  Anyway, if it's the price of checking, I'll pay[*].
>

Gave Dan a related answer. For you, my explanation is:

- It's nice to have just one configuration for static analysis in just one
place
- It's nice to have that configuration follow python ecosystem norms
- It's nice to use standard python management tools to configure and test
the supported versions of static analysis tools, again kept in one place.
- Just moving the folder costs virtually nothing.
- Moving it here makes it easier for me to test the eventual integration
with make check in one place.
- I like being able to say that anything under `python/` is fiercely
guarded by high standards (and the gitlab pipelines) and everything else is
not. I consider this to be organizationally simple and easy to communicate.
i.e., I find it attractive to say that "python is maintained, scripts are
YMMV." I am *not* willing to maintain everything under `scripts/` with the
same level of effort I apply to `python/`. I think it's important to allow
people to commit low-development-cost scripts ("contrib quality") that they
can run from time to time and not everything needs to be held to a
crystalline perfect standard, but some stuff does.

If I'm being honest, I also just don't want to develop more testing
infrastructure and scaffolding to start picking up scattershot python
modules from elsewhere in the tree. I'd rather bring qapi into the fold and
then continue working on integrating `python/` static analysis tests to the
make check suite instead. I've spent enough time already writing and
carrying around my little ad-hoc static analysis scripts for qapi during
the strict typing conversion, and ensuring static analysis passes with
totally arbitrary versions of whatever tools the user happens to have
installed sounds like a colossal pain. I already have a system set up to do
all of the environment prep work so that it Just Works :tm: and is tested
across a large matrix of tooling versions to ensure it continues to work
both locally (for developer ease) and in the gitlab pipeline (for rigorous
testing) with both forms of test readily accessible in the local developer
environment: I'd deeply appreciate just being able to let that system do
what I designed it to do.

This series is 99% "converge on a static analysis configuration standard"
and 1% "move it into place so it starts being checked regularly." I think
that's worth a simple "git mv", honestly. Do we each lose some control over
our preferred standard of formatting? Yes, but we gain consistency and ease
of testing.

As for rust: I dunno! I imagine there are similar benefits there for
modeling things as standards compliant packages, too. I'm not doing rust
tooling right now, so I can't say.


>
> [...]
>
> > diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py
> > index f3518d29a54..42912c91716 100644
> > --- a/scripts/qapi-gen.py
> > +++ b/scripts/qapi-gen.py
> > @@ -11,9 +11,11 @@
> >  execution environment.
> >  """
> >
> > +import os
> >  import sys
> >
> > -from qapi import main
> > +sys.path.append(os.path.join(os.path.dirname(__file__), '..', 'python'=
))
> > +from qemu.qapi import main
> >
> >  if __name__ =3D=3D '__main__':
> >      sys.exit(main.main())
>
> Suggest to use the opportunity to rename to just qapi-gen (no .py) and
> chmod +x, possibly in a separate patch.
>
> [...]
>
>
> [*] Grudgingly.
>

Why the resistance? Is there some harm I've overlooked? This seems fairly
benign to me.

--000000000000828eed0620eaaedf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 30, 2024 at 7:20=E2=80=AF=
AM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank">jsn=
ow@redhat.com</a>&gt; writes:<br>
<br>
&gt; This is being done for the sake of unifying the linting and static typ=
e<br>
&gt; analysis configurations between scripts/qapi and python/qemu/*.<br>
&gt;<br>
&gt; With this change, the qapi module will now be checked by mypy, flake8,=
<br>
&gt; pylint, isort etc under all python versions from 3.8 through 3.13 unde=
r<br>
&gt; a variety of different dependency configurations in the GitLab testing=
<br>
&gt; pipelines.<br>
&gt;<br>
&gt; The tests can be run locally, as always:<br>
&gt;<br>
&gt;&gt; cd qemu.git/python<br>
&gt;&gt; make check-minreqs<br>
&gt;&gt; make check-tox<br>
&gt;&gt; make check-dev<br>
&gt;<br>
&gt; &quot;check-minreqs&quot; is the must-pass GitLab test.<br>
&gt; &quot;check-tox&quot; is the optional allowed-to-fail GitLab test.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
I don&#39;t understand why we have to keep Python code in its own directory=
<br>
just to get it checked.=C2=A0 We wouldn&#39;t do that say for Rust code, wo=
uld<br>
we?=C2=A0 Anyway, if it&#39;s the price of checking, I&#39;ll pay[*].<br></=
blockquote><div><br></div><div>Gave Dan a related answer. For you, my expla=
nation is:</div><div><br></div><div>- It&#39;s nice to have just one config=
uration for static analysis in just one place</div><div>- It&#39;s nice to =
have that configuration follow python ecosystem norms</div><div>- It&#39;s =
nice to use standard python management tools to configure and test the supp=
orted versions of static analysis tools, again kept in one place.<br></div>=
<div>- Just moving the folder costs virtually nothing.<br></div><div>- Movi=
ng it here makes it easier for me to test the eventual integration with mak=
e check in one place.</div>- I like being able to say that anything under `=
python/` is fiercely guarded by high standards (and the gitlab pipelines) a=
nd everything else is not. I consider this to be organizationally simple an=
d easy to communicate. i.e., I find it attractive to say that &quot;python =
is maintained, scripts are YMMV.&quot; I am *not* willing to maintain every=
thing under `scripts/` with the same level of effort I apply to `python/`. =
I think it&#39;s important to allow people to commit low-development-cost s=
cripts (&quot;contrib quality&quot;) that they can run from time to time an=
d not everything needs to be held to a crystalline perfect standard, but so=
me stuff does.<br></div><div class=3D"gmail_quote"><br></div><div class=3D"=
gmail_quote">If I&#39;m being honest, I also just don&#39;t want to develop=
 more testing infrastructure and scaffolding to start picking up scattersho=
t python modules from elsewhere in the tree. I&#39;d rather bring qapi into=
 the fold and then continue working on integrating `python/` static analysi=
s tests to the make check suite instead. I&#39;ve spent enough time already=
 writing and carrying around my little ad-hoc static analysis scripts for q=
api during the strict typing conversion, and ensuring static analysis passe=
s with totally arbitrary versions of whatever tools the user happens to hav=
e installed sounds like a colossal pain. I already have a system set up to =
do all of the environment prep work so that it Just Works :tm: and is teste=
d across a large matrix of tooling versions to ensure it continues to work =
both locally (for developer ease) and in the gitlab pipeline (for rigorous =
testing) with both forms of test readily accessible in the local developer =
environment: I&#39;d deeply appreciate just being able to let that system d=
o what I designed it to do.</div><div class=3D"gmail_quote"><br></div><div =
class=3D"gmail_quote">This series is 99% &quot;converge on a static analysi=
s configuration standard&quot; and 1% &quot;move it into place so it starts=
 being checked regularly.&quot; I think that&#39;s worth a simple &quot;git=
 mv&quot;, honestly. Do we each lose some control over our preferred standa=
rd of formatting? Yes, but we gain consistency and ease of testing.</div><d=
iv class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">As for rust: =
I dunno! I imagine there are similar benefits there for modeling things as =
standards compliant packages, too. I&#39;m not doing rust tooling right now=
, so I can&#39;t say.</div><div class=3D"gmail_quote"><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
<br>
[...]<br>
<br>
&gt; diff --git a/scripts/qapi-gen.py b/scripts/qapi-gen.py<br>
&gt; index f3518d29a54..42912c91716 100644<br>
&gt; --- a/scripts/qapi-gen.py<br>
&gt; +++ b/scripts/qapi-gen.py<br>
&gt; @@ -11,9 +11,11 @@<br>
&gt;=C2=A0 execution environment.<br>
&gt;=C2=A0 &quot;&quot;&quot;<br>
&gt;=C2=A0 <br>
&gt; +import os<br>
&gt;=C2=A0 import sys<br>
&gt;=C2=A0 <br>
&gt; -from qapi import main<br>
&gt; +sys.path.append(os.path.join(os.path.dirname(__file__), &#39;..&#39;,=
 &#39;python&#39;))<br>
&gt; +from qemu.qapi import main<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 if __name__ =3D=3D &#39;__main__&#39;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 sys.exit(main.main())<br>
<br>
Suggest to use the opportunity to rename to just qapi-gen (no .py) and<br>
chmod +x, possibly in a separate patch.<br>
<br>
[...]<br>
<br>
<br>
[*] Grudgingly.<br></blockquote><div><br></div><div>Why the resistance? Is =
there some harm I&#39;ve overlooked? This seems fairly benign to me.<br></d=
iv></div></div>

--000000000000828eed0620eaaedf--


