Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B544CA100C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 18:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk6RE-0006Mm-AB; Fri, 30 Aug 2024 14:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sk6RC-0006MG-3W
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 14:33:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sk6R8-0000fc-0y
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 14:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725042807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wWL8wwbc/ToTNjsa6egkPGLfmYjcUGxF4bYkrx6xB34=;
 b=H0JiORZ64FNsBlipRVvmPSZnG9F+bfLH3u9eoYKA6H0xPPyW92hPVRILkOh3r0tCeWQPRN
 c/bJI5nTOOifKJeJV8KCdhbM/g0kbxlSFK9t3I1WdrNS2x1N/M8PHyT5aqCBJpy3AfQ9YT
 9wG3BsFF/5oaOc4RuWqixiFTX50XfHw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-7MnBoV9hPgCGGmjH9ti1jw-1; Fri, 30 Aug 2024 14:33:25 -0400
X-MC-Unique: 7MnBoV9hPgCGGmjH9ti1jw-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2d3ce4f35c1so1937196a91.1
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 11:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725042804; x=1725647604;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wWL8wwbc/ToTNjsa6egkPGLfmYjcUGxF4bYkrx6xB34=;
 b=Ff44fv0oqcAEXGed4jBrjeI9nT2Ul6oSeLLY0OG4nLc6rOn+Ts3nEsa2tPpEznIvR1
 zdJXPWrZOkLrh7yAmuLAf9PFqRIiHr0vp4Z5c9NfAJC+m5mAJjbz/8MZ5pbj6V/rXDvg
 BTwv6wwNzmAh79EG4VX491yN4e+rFTZhOHuDUBeKRMkU/AFfF7hZUH4WwWPOUxjK99Wp
 +cGhHjU7h9TXv4yQFxSwc8vBonmjnCi6rQyNRLfM8vsq9qquVefdPRgJExNfcl8RajkI
 nKZfEtAOu5lVCHs6zdscdkOdjnAwGCh3l67aqL5aZQfmZz2mjcA/GVwRy1h/vYBJa7Vc
 jisg==
X-Gm-Message-State: AOJu0YzhCMBsothJ2RM3i/G90nN8HIWpPMUG1FKdBtbOvCivtIzXFYCH
 FBADvKnTO1jQe2PHw8ZR3ihtQAK5tbUFgTdHnBIPpExj+JVJuLT8PXr1fzNuXTes5td1JlYNqt+
 QJaAAzocZcP/mHr1upGWt7paFgletCheTjzWj2AKHilX9cyLX3Q1vv2+UolFVnpaGf3LscXN6XG
 KkFY4Sb2w/eqgP+fGru7tn5D/OqE8=
X-Received: by 2002:a17:90a:b00a:b0:2cb:5dbb:d394 with SMTP id
 98e67ed59e1d1-2d856a2ea26mr10207753a91.4.1725042804020; 
 Fri, 30 Aug 2024 11:33:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgWKfO3PFTu/2GQ5fD0DH5SrXYZxyKUT6zCaY+LY6PCj4/XN806irVCE+D7b57VnclGXubRxL+SNS9OC7ZtQI=
X-Received: by 2002:a17:90a:b00a:b0:2cb:5dbb:d394 with SMTP id
 98e67ed59e1d1-2d856a2ea26mr10207704a91.4.1725042803554; Fri, 30 Aug 2024
 11:33:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240820002318.1380276-1-jsnow@redhat.com>
 <20240820002318.1380276-3-jsnow@redhat.com>
 <87ikvicln3.fsf@pond.sub.org>
In-Reply-To: <87ikvicln3.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 30 Aug 2024 14:33:12 -0400
Message-ID: <CAFn=p-Y2sBXQPpA7-qL6q9yZa36WuyPeuFsveFiYn0UhubT+Pg@mail.gmail.com>
Subject: Re: [PATCH 2/8] python/qapi: change "FIXME" to "TODO"
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Beraldo Leal <bleal@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000008762050620ead3cb"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

--0000000000008762050620ead3cb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 7:09=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > qemu.git/python/setup.cfg disallows checking in any code with "XXX",
> > "FIXME" or "TODO" in the comments. Soften the restriction to only
> > prohibit "FIXME", and change the two occurrences of "FIXME" in qapi to
> > read "TODO" instead.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> I don't like forbidding FIXME comments.  It's as futile as forbidding
> known bugs.  All it can accomplish is making people use other, and
> likely less clear ways to document them.
>
> Perhaps projects exist that use FIXME comments only for known bugs in
> uncommitted code.  To me, that feels *nuts*.  I commit all kinds of crap
> in my tree.  I don't need silly "make check" failures while I develop,
> the non-silly ones cause enough friction already.
>
> In fact, we're quite happy to use FIXME comments even in merged code:
>
>     $ git-grep FIXME | wc -l
>     494
>
> I can't see why python/ should be different.
>
> > ---
> >  python/setup.cfg         | 5 +++++
> >  scripts/qapi/commands.py | 2 +-
> >  scripts/qapi/events.py   | 2 +-
> >  3 files changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/python/setup.cfg b/python/setup.cfg
> > index 3b4e2cc5501..72b58c98c99 100644
> > --- a/python/setup.cfg
> > +++ b/python/setup.cfg
> > @@ -169,6 +169,11 @@ ignore-signatures=3Dyes
> >  # TODO: Remove after we opt in to Pylint 2.8.3. See commit msg.
> >  min-similarity-lines=3D6
> >
> > +[pylint.miscellaneous]
> > +
> > +# forbid FIXME/XXX comments, allow TODO.
> > +notes=3DFIXME,
> > +      XXX,
> >
> >  [isort]
> >  force_grid_wrap=3D4
> > diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
> > index 79951a841f5..cffed6cd3ba 100644
> > --- a/scripts/qapi/commands.py
> > +++ b/scripts/qapi/commands.py
> > @@ -385,7 +385,7 @@ def visit_command(self,
> >                        coroutine: bool) -> None:
> >          if not gen:
> >              return
> > -        # FIXME: If T is a user-defined type, the user is responsible
> > +        # TODO: If T is a user-defined type, the user is responsible
> >          # for making this work, i.e. to make T's condition the
> >          # conjunction of the T-returning commands' conditions.  If T
> >          # is a built-in type, this isn't possible: the
> > diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
> > index d1f639981a9..36dc0c50c78 100644
> > --- a/scripts/qapi/events.py
> > +++ b/scripts/qapi/events.py
> > @@ -84,7 +84,7 @@ def gen_event_send(name: str,
> >                     boxed: bool,
> >                     event_enum_name: str,
> >                     event_emit: str) -> str:
> > -    # FIXME: Our declaration of local variables (and of 'errp' in the
> > +    # TODO: Our declaration of local variables (and of 'errp' in the
> >      # parameter list) can collide with exploded members of the event's
> >      # data type passed in as parameters.  If this collision ever hits =
in
> >      # practice, we can rename our local variables with a leading _
> prefix,
>
> Starting a comment with TODO tells me there's work to do.
>
> Starting it with FIXME tells me there's a bug to fix.  That's more
> specific.  Replacing FIXME by TODO loses information.
>

meh. I do use the "prohibit fixme" personally because I've the memory of a
goldfish and I like setting up bombs for myself when I run tests, but
willing to cede if it gets me what I want otherwise. I could be coerced to
using "XXX" as my WIP testing bomb. Or maybe literally just adding "WIP" as
a new bomb. Is that a fair trade?

There are likely other standards differences between the two subtrees,
potentially things like documentation string length and so on -- I invite
you to take a look at the setup.cfg file and tweak things to your liking
and run "make check-minreqs" to see what barks, if anything.

After you run that command, you can type "source .dev-venv/bin/activate.sh"
(or .fish or whatever) and then "pylint --generate-rcfile | less" to get a
sample config and see all of the buttons, knobs and levers you could pull.
You can leave the environment when you're done with "deactivate".

Mentioning this only because there have been times in the past that my
formatting hasn't been to your liking, but there are avenues to
programmatically enforce it to make my qapi patches nicer for your tastes
in the future.

--js

--0000000000008762050620ead3cb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 30, 2024 at 7:09=E2=80=AF=
AM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank">jsn=
ow@redhat.com</a>&gt; writes:<br>
<br>
&gt; qemu.git/python/setup.cfg disallows checking in any code with &quot;XX=
X&quot;,<br>
&gt; &quot;FIXME&quot; or &quot;TODO&quot; in the comments. Soften the rest=
riction to only<br>
&gt; prohibit &quot;FIXME&quot;, and change the two occurrences of &quot;FI=
XME&quot; in qapi to<br>
&gt; read &quot;TODO&quot; instead.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
I don&#39;t like forbidding FIXME comments.=C2=A0 It&#39;s as futile as for=
bidding<br>
known bugs.=C2=A0 All it can accomplish is making people use other, and<br>
likely less clear ways to document them.<br>
<br>
Perhaps projects exist that use FIXME comments only for known bugs in<br>
uncommitted code.=C2=A0 To me, that feels *nuts*.=C2=A0 I commit all kinds =
of crap<br>
in my tree.=C2=A0 I don&#39;t need silly &quot;make check&quot; failures wh=
ile I develop,<br>
the non-silly ones cause enough friction already.<br>
<br>
In fact, we&#39;re quite happy to use FIXME comments even in merged code:<b=
r>
<br>
=C2=A0 =C2=A0 $ git-grep FIXME | wc -l<br>
=C2=A0 =C2=A0 494<br>
<br>
I can&#39;t see why python/ should be different.<br>
<br>
&gt; ---<br>
&gt;=C2=A0 python/setup.cfg=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 5 +++++<br>
&gt;=C2=A0 scripts/qapi/commands.py | 2 +-<br>
&gt;=C2=A0 scripts/qapi/events.py=C2=A0 =C2=A0| 2 +-<br>
&gt;=C2=A0 3 files changed, 7 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/python/setup.cfg b/python/setup.cfg<br>
&gt; index 3b4e2cc5501..72b58c98c99 100644<br>
&gt; --- a/python/setup.cfg<br>
&gt; +++ b/python/setup.cfg<br>
&gt; @@ -169,6 +169,11 @@ ignore-signatures=3Dyes<br>
&gt;=C2=A0 # TODO: Remove after we opt in to Pylint 2.8.3. See commit msg.<=
br>
&gt;=C2=A0 min-similarity-lines=3D6<br>
&gt;=C2=A0 <br>
&gt; +[pylint.miscellaneous]<br>
&gt; +<br>
&gt; +# forbid FIXME/XXX comments, allow TODO.<br>
&gt; +notes=3DFIXME,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 XXX,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 [isort]<br>
&gt;=C2=A0 force_grid_wrap=3D4<br>
&gt; diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py<br>
&gt; index 79951a841f5..cffed6cd3ba 100644<br>
&gt; --- a/scripts/qapi/commands.py<br>
&gt; +++ b/scripts/qapi/commands.py<br>
&gt; @@ -385,7 +385,7 @@ def visit_command(self,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 coroutine: bool) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not gen:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 # FIXME: If T is a user-defined type, the=
 user is responsible<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # TODO: If T is a user-defined type, the =
user is responsible<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # for making this work, i.e. to make=
 T&#39;s condition the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # conjunction of the T-returning com=
mands&#39; conditions.=C2=A0 If T<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # is a built-in type, this isn&#39;t=
 possible: the<br>
&gt; diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py<br>
&gt; index d1f639981a9..36dc0c50c78 100644<br>
&gt; --- a/scripts/qapi/events.py<br>
&gt; +++ b/scripts/qapi/events.py<br>
&gt; @@ -84,7 +84,7 @@ def gen_event_send(name: str,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0boxed: bool,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0event_enum_name: str,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0event_emit: str) -&gt; str:<br>
&gt; -=C2=A0 =C2=A0 # FIXME: Our declaration of local variables (and of &#3=
9;errp&#39; in the<br>
&gt; +=C2=A0 =C2=A0 # TODO: Our declaration of local variables (and of &#39=
;errp&#39; in the<br>
&gt;=C2=A0 =C2=A0 =C2=A0 # parameter list) can collide with exploded member=
s of the event&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0 # data type passed in as parameters.=C2=A0 If this=
 collision ever hits in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 # practice, we can rename our local variables with=
 a leading _ prefix,<br>
<br>
Starting a comment with TODO tells me there&#39;s work to do.<br>
<br>
Starting it with FIXME tells me there&#39;s a bug to fix.=C2=A0 That&#39;s =
more<br>
specific.=C2=A0 Replacing FIXME by TODO loses information.<br></blockquote>=
<div><br></div><div>meh. I do use the &quot;prohibit fixme&quot; personally=
 because I&#39;ve the memory of a goldfish and I like setting up bombs for =
myself when I run tests, but willing to cede if it gets me what I want othe=
rwise. I could be coerced to using &quot;XXX&quot; as my WIP testing bomb. =
Or maybe literally just adding &quot;WIP&quot; as a new bomb. Is that a fai=
r trade?<br></div><div><br></div><div>There are likely other standards diff=
erences between the two subtrees, potentially things like documentation str=
ing length and so on -- I invite you to take a look at the setup.cfg file a=
nd tweak things to your liking and run &quot;make check-minreqs&quot; to se=
e what barks, if anything.</div><div><br></div><div>After you run that comm=
and, you can type &quot;source .dev-venv/bin/activate.sh&quot; (or .fish or=
 whatever) and then &quot;pylint --generate-rcfile | less&quot; to get a sa=
mple config and see all of the buttons, knobs and levers you could pull. Yo=
u can leave the environment when you&#39;re done with &quot;deactivate&quot=
;.<br></div><div><br></div><div>Mentioning this only because there have bee=
n times in the past that my formatting hasn&#39;t been to your liking, but =
there are avenues to programmatically enforce it to make my qapi patches ni=
cer for your tastes in the future.</div><div><br></div><div>--js<br></div><=
/div></div>

--0000000000008762050620ead3cb--


