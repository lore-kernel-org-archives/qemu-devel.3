Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910EFCD379F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 16:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slWeQ-0008Cr-Ur; Tue, 03 Sep 2024 12:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1slWeO-00085b-Um
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:45:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1slWeM-0007sk-6z
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725381898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KLJcHTnXJ1ugOMdq3bD1pTgOLaS0/GgGScMK8qljXZ4=;
 b=NkWrmmkytX6bQ496EgM9nwNbfI8kz2vx5FpJrbdaFZ3WCouJlJ2pfwQGXuuTcG8rk+HGMZ
 I3bYaKDDJyyM0sanDNnFnBgzI4OVX/Mok/XD50cWL5G8qEkz/rqT0TFwSBwe89TzG7qhDH
 skrVVjkYRh+uCPLTwE1CMAl5W7zomPM=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-E5yjVQj8NRCoENL9Tgawxg-1; Tue, 03 Sep 2024 12:44:57 -0400
X-MC-Unique: E5yjVQj8NRCoENL9Tgawxg-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2052918b64cso34463305ad.1
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725381896; x=1725986696;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KLJcHTnXJ1ugOMdq3bD1pTgOLaS0/GgGScMK8qljXZ4=;
 b=Mha06iUUrZUu/zXh1XmysjKNG5UjcWYUGZ9FM3qldaPxP6kLHPIxnOIdSK2iTEVvO5
 /C6r4LMTCck0KU4UHxnGmN/H2sl9kN1fKZedfaIwOwjMH1LxrFX1lMiofKreDwlWI6zB
 MwkA03W+Bg3ZeHGam7YHzRmtNRMBKdweqPiYo7Q4cnnqaT6sGhKA16UbVsAGWRfuE6JN
 qALi/j0ocIcs5KEypkGTqevHJUdfPlstHirqZ86ypLO9Dsk+XmTzQZrZ9cuIlJ9rlw7a
 xYu7AkjYo39v1lyDLVRQvIr5BN/hioLdgpldSBjGaPY4N4YedobaGfrWyZq4YtnAOrss
 nKOg==
X-Gm-Message-State: AOJu0Yxv0gS4SUHesNBBgj3fvp61Cf7X33OaOzaKSp69GnSyY3UWXRGc
 dU3UivFfesUSXPZzsxneGnwGsujrc5p/5vNvzrUc7vy7dc3Xokvx9t575MxpB0lMgrp3dVutgeG
 lgY7RuWKynk6vw/FVqTTzUrOrbMoQ8KW96O8+0ta0PvUYJzOfnqgz4QISsM3gW1pFGXmv3aaZmF
 4GaHOiOfJcYijo57R7hUGnzDKBXYY=
X-Received: by 2002:a17:902:e849:b0:205:894b:b5b0 with SMTP id
 d9443c01a7336-20699af231bmr31000625ad.33.1725381895896; 
 Tue, 03 Sep 2024 09:44:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUY5XLWd9Zi2IqZT26JRB69iAtUdEhLFwwUhPXgvOvyP6OBPRN8wQW4qgb2RvGCgiWxoMaT/AnQxaZ/j5TT6c=
X-Received: by 2002:a17:902:e849:b0:205:894b:b5b0 with SMTP id
 d9443c01a7336-20699af231bmr31000295ad.33.1725381895499; Tue, 03 Sep 2024
 09:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240820002318.1380276-1-jsnow@redhat.com>
 <20240820002318.1380276-3-jsnow@redhat.com>
 <87ikvicln3.fsf@pond.sub.org>
 <CAFn=p-Y2sBXQPpA7-qL6q9yZa36WuyPeuFsveFiYn0UhubT+Pg@mail.gmail.com>
 <87v7zh8c2h.fsf@pond.sub.org>
In-Reply-To: <87v7zh8c2h.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 3 Sep 2024 12:44:42 -0400
Message-ID: <CAFn=p-bMUg6BpUcWzq9RwWnQmH6wAxJxTx9H9+QS6KJg2ey2+g@mail.gmail.com>
Subject: Re: [PATCH 2/8] python/qapi: change "FIXME" to "TODO"
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Beraldo Leal <bleal@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000fbcdd8062139c65d"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000fbcdd8062139c65d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 31, 2024, 2:02=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > On Fri, Aug 30, 2024 at 7:09=E2=80=AFAM Markus Armbruster <armbru@redha=
t.com>
> wrote:
> >
> >> John Snow <jsnow@redhat.com> writes:
> >>
> >> > qemu.git/python/setup.cfg disallows checking in any code with "XXX",
> >> > "FIXME" or "TODO" in the comments. Soften the restriction to only
> >> > prohibit "FIXME", and change the two occurrences of "FIXME" in qapi =
to
> >> > read "TODO" instead.
> >> >
> >> > Signed-off-by: John Snow <jsnow@redhat.com>
> >>
> >> I don't like forbidding FIXME comments.  It's as futile as forbidding
> >> known bugs.  All it can accomplish is making people use other, and
> >> likely less clear ways to document them.
> >>
> >> Perhaps projects exist that use FIXME comments only for known bugs in
> >> uncommitted code.  To me, that feels *nuts*.  I commit all kinds of cr=
ap
> >> in my tree.  I don't need silly "make check" failures while I develop,
> >> the non-silly ones cause enough friction already.
> >>
> >> In fact, we're quite happy to use FIXME comments even in merged code:
> >>
> >>     $ git-grep FIXME | wc -l
> >>     494
> >>
> >> I can't see why python/ should be different.
> >>
> >> > ---
> >> >  python/setup.cfg         | 5 +++++
> >> >  scripts/qapi/commands.py | 2 +-
> >> >  scripts/qapi/events.py   | 2 +-
> >> >  3 files changed, 7 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/python/setup.cfg b/python/setup.cfg
> >> > index 3b4e2cc5501..72b58c98c99 100644
> >> > --- a/python/setup.cfg
> >> > +++ b/python/setup.cfg
> >> > @@ -169,6 +169,11 @@ ignore-signatures=3Dyes
> >> >  # TODO: Remove after we opt in to Pylint 2.8.3. See commit msg.
> >> >  min-similarity-lines=3D6
> >> >
> >> > +[pylint.miscellaneous]
> >> > +
> >> > +# forbid FIXME/XXX comments, allow TODO.
> >> > +notes=3DFIXME,
> >> > +      XXX,
> >> >
> >> >  [isort]
> >> >  force_grid_wrap=3D4
> >> > diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
> >> > index 79951a841f5..cffed6cd3ba 100644
> >> > --- a/scripts/qapi/commands.py
> >> > +++ b/scripts/qapi/commands.py
> >> > @@ -385,7 +385,7 @@ def visit_command(self,
> >> >                        coroutine: bool) -> None:
> >> >          if not gen:
> >> >              return
> >> > -        # FIXME: If T is a user-defined type, the user is responsib=
le
> >> > +        # TODO: If T is a user-defined type, the user is responsibl=
e
> >> >          # for making this work, i.e. to make T's condition the
> >> >          # conjunction of the T-returning commands' conditions.  If =
T
> >> >          # is a built-in type, this isn't possible: the
> >> > diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
> >> > index d1f639981a9..36dc0c50c78 100644
> >> > --- a/scripts/qapi/events.py
> >> > +++ b/scripts/qapi/events.py
> >> > @@ -84,7 +84,7 @@ def gen_event_send(name: str,
> >> >                     boxed: bool,
> >> >                     event_enum_name: str,
> >> >                     event_emit: str) -> str:
> >> > -    # FIXME: Our declaration of local variables (and of 'errp' in t=
he
> >> > +    # TODO: Our declaration of local variables (and of 'errp' in th=
e
> >> >      # parameter list) can collide with exploded members of the
> event's
> >> >      # data type passed in as parameters.  If this collision ever
> hits in
> >> >      # practice, we can rename our local variables with a leading
> prefix,
> >>
> >> Starting a comment with TODO tells me there's work to do.
> >>
> >> Starting it with FIXME tells me there's a bug to fix.  That's more
> >> specific.  Replacing FIXME by TODO loses information.
> >
> > meh. I do use the "prohibit fixme" personally because I've the memory o=
f
> a
> > goldfish and I like setting up bombs for myself when I run tests, but
> > willing to cede if it gets me what I want otherwise. I could be coerced
> to
> > using "XXX" as my WIP testing bomb. Or maybe literally just adding "WIP=
"
> as
> > a new bomb. Is that a fair trade?
>
> I understand you'd like to have some kind of stylized comment that
> automated testing will reject, to serve as a "do not post before
> resolving this issue" reminder.  Fair?
>

Yep, that's it exactly.


> If yes, whatever floats your boat and doesn't interfere with existing
> practice.
>
>     $ git-grep -w FIXME | wc -l
>     493
>     $ git-grep -w TODO | wc -l
>     1249
>     $ git-grep -w XXX | wc -l
>     78288
>     $ git-grep -w WIP
>     Binary file pc-bios/skiboot.lid matches
>

"WIP" it is. I'll adjust the conf and nix this patch.


> > There are likely other standards differences between the two subtrees,
> > potentially things like documentation string length and so on -- I invi=
te
> > you to take a look at the setup.cfg file and tweak things to your likin=
g
> > and run "make check-minreqs" to see what barks, if anything.
> >
> > After you run that command, you can type "source
> .dev-venv/bin/activate.sh"
> > (or .fish or whatever) and then "pylint --generate-rcfile | less" to ge=
t
> a
> > sample config and see all of the buttons, knobs and levers you could
> pull.
> > You can leave the environment when you're done with "deactivate".
> >
> > Mentioning this only because there have been times in the past that my
> > formatting hasn't been to your liking, but there are avenues to
> > programmatically enforce it to make my qapi patches nicer for your tast=
es
> > in the future.
>
> Thanks!
>

No problem! I know our tastes don't always match but I figure if we can
agree on a config file, it'll make things nicer for the both of us in the
future.

We can discuss at KVM Forum too any of the little nits or preferences you'd
like to see automated and enforced to unify the Python style we use in
tree. I'd also like to discuss the usage of black formatting to automate
away the formatting guesswork. It'd be a lot of churn, but it would
drastically simplify things. (e.g. "make autoformat" in the python dir,
plus we can look into emacs/vim/vscode config for the repo)

I'll handle the config/maintenance/tooling but you can let me know your
preferences.

(This series should be a good example of which things I have configured for
python/ that we didn't tackle for qapi. It isn't very much. Some things you
prefer may now be *unhandled*, I think docstring length being confined to
72(?) or less might be one of them, I don't recall others at the moment.)

--000000000000fbcdd8062139c65d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Sat, Aug 31, 2024, 2:02=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:js=
now@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&g=
t; writes:<br>
<br>
&gt; On Fri, Aug 30, 2024 at 7:09=E2=80=AFAM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank" rel=3D"noreferrer">armbru@r=
edhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank=
" rel=3D"noreferrer">jsnow@redhat.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; qemu.git/python/setup.cfg disallows checking in any code with=
 &quot;XXX&quot;,<br>
&gt;&gt; &gt; &quot;FIXME&quot; or &quot;TODO&quot; in the comments. Soften=
 the restriction to only<br>
&gt;&gt; &gt; prohibit &quot;FIXME&quot;, and change the two occurrences of=
 &quot;FIXME&quot; in qapi to<br>
&gt;&gt; &gt; read &quot;TODO&quot; instead.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.c=
om" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; I don&#39;t like forbidding FIXME comments.=C2=A0 It&#39;s as futi=
le as forbidding<br>
&gt;&gt; known bugs.=C2=A0 All it can accomplish is making people use other=
, and<br>
&gt;&gt; likely less clear ways to document them.<br>
&gt;&gt;<br>
&gt;&gt; Perhaps projects exist that use FIXME comments only for known bugs=
 in<br>
&gt;&gt; uncommitted code.=C2=A0 To me, that feels *nuts*.=C2=A0 I commit a=
ll kinds of crap<br>
&gt;&gt; in my tree.=C2=A0 I don&#39;t need silly &quot;make check&quot; fa=
ilures while I develop,<br>
&gt;&gt; the non-silly ones cause enough friction already.<br>
&gt;&gt;<br>
&gt;&gt; In fact, we&#39;re quite happy to use FIXME comments even in merge=
d code:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0$ git-grep FIXME | wc -l<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0494<br>
&gt;&gt;<br>
&gt;&gt; I can&#39;t see why python/ should be different.<br>
&gt;&gt;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 python/setup.cfg=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 5 +=
++++<br>
&gt;&gt; &gt;=C2=A0 scripts/qapi/commands.py | 2 +-<br>
&gt;&gt; &gt;=C2=A0 scripts/qapi/events.py=C2=A0 =C2=A0| 2 +-<br>
&gt;&gt; &gt;=C2=A0 3 files changed, 7 insertions(+), 2 deletions(-)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/python/setup.cfg b/python/setup.cfg<br>
&gt;&gt; &gt; index 3b4e2cc5501..72b58c98c99 100644<br>
&gt;&gt; &gt; --- a/python/setup.cfg<br>
&gt;&gt; &gt; +++ b/python/setup.cfg<br>
&gt;&gt; &gt; @@ -169,6 +169,11 @@ ignore-signatures=3Dyes<br>
&gt;&gt; &gt;=C2=A0 # TODO: Remove after we opt in to Pylint 2.8.3. See com=
mit msg.<br>
&gt;&gt; &gt;=C2=A0 min-similarity-lines=3D6<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; +[pylint.miscellaneous]<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +# forbid FIXME/XXX comments, allow TODO.<br>
&gt;&gt; &gt; +notes=3DFIXME,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 XXX,<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 [isort]<br>
&gt;&gt; &gt;=C2=A0 force_grid_wrap=3D4<br>
&gt;&gt; &gt; diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands=
.py<br>
&gt;&gt; &gt; index 79951a841f5..cffed6cd3ba 100644<br>
&gt;&gt; &gt; --- a/scripts/qapi/commands.py<br>
&gt;&gt; &gt; +++ b/scripts/qapi/commands.py<br>
&gt;&gt; &gt; @@ -385,7 +385,7 @@ def visit_command(self,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 coroutine: bool) -&gt; None:<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not gen:<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 # FIXME: If T is a user-defined =
type, the user is responsible<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # TODO: If T is a user-defined t=
ype, the user is responsible<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # for making this work, i.e=
. to make T&#39;s condition the<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # conjunction of the T-retu=
rning commands&#39; conditions.=C2=A0 If T<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # is a built-in type, this =
isn&#39;t possible: the<br>
&gt;&gt; &gt; diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py<=
br>
&gt;&gt; &gt; index d1f639981a9..36dc0c50c78 100644<br>
&gt;&gt; &gt; --- a/scripts/qapi/events.py<br>
&gt;&gt; &gt; +++ b/scripts/qapi/events.py<br>
&gt;&gt; &gt; @@ -84,7 +84,7 @@ def gen_event_send(name: str,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0boxed: bool,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0event_enum_name: str,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0event_emit: str) -&gt; str:<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 # FIXME: Our declaration of local variables (a=
nd of &#39;errp&#39; in the<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 # TODO: Our declaration of local variables (an=
d of &#39;errp&#39; in the<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 # parameter list) can collide with explod=
ed members of the event&#39;s<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 # data type passed in as parameters.=C2=
=A0 If this collision ever hits in<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 # practice, we can rename our local varia=
bles with a leading prefix,<br>
&gt;&gt;<br>
&gt;&gt; Starting a comment with TODO tells me there&#39;s work to do.<br>
&gt;&gt;<br>
&gt;&gt; Starting it with FIXME tells me there&#39;s a bug to fix.=C2=A0 Th=
at&#39;s more<br>
&gt;&gt; specific.=C2=A0 Replacing FIXME by TODO loses information.<br>
&gt;<br>
&gt; meh. I do use the &quot;prohibit fixme&quot; personally because I&#39;=
ve the memory of a<br>
&gt; goldfish and I like setting up bombs for myself when I run tests, but<=
br>
&gt; willing to cede if it gets me what I want otherwise. I could be coerce=
d to<br>
&gt; using &quot;XXX&quot; as my WIP testing bomb. Or maybe literally just =
adding &quot;WIP&quot; as<br>
&gt; a new bomb. Is that a fair trade?<br>
<br>
I understand you&#39;d like to have some kind of stylized comment that<br>
automated testing will reject, to serve as a &quot;do not post before<br>
resolving this issue&quot; reminder.=C2=A0 Fair?<br></blockquote></div></di=
v><div dir=3D"auto"><br></div><div dir=3D"auto">Yep, that&#39;s it exactly.=
=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gma=
il_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">
<br>
If yes, whatever floats your boat and doesn&#39;t interfere with existing<b=
r>
practice.<br>
<br>
=C2=A0 =C2=A0 $ git-grep -w FIXME | wc -l<br>
=C2=A0 =C2=A0 493<br>
=C2=A0 =C2=A0 $ git-grep -w TODO | wc -l<br>
=C2=A0 =C2=A0 1249<br>
=C2=A0 =C2=A0 $ git-grep -w XXX | wc -l<br>
=C2=A0 =C2=A0 78288<br>
=C2=A0 =C2=A0 $ git-grep -w WIP<br>
=C2=A0 =C2=A0 Binary file pc-bios/skiboot.lid matches<br></blockquote></div=
></div><div dir=3D"auto"><br></div><div dir=3D"auto">&quot;WIP&quot; it is.=
 I&#39;ll adjust the conf and nix this patch.</div><div dir=3D"auto"><br></=
div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">
<br>
&gt; There are likely other standards differences between the two subtrees,=
<br>
&gt; potentially things like documentation string length and so on -- I inv=
ite<br>
&gt; you to take a look at the setup.cfg file and tweak things to your liki=
ng<br>
&gt; and run &quot;make check-minreqs&quot; to see what barks, if anything.=
<br>
&gt;<br>
&gt; After you run that command, you can type &quot;source .dev-venv/bin/ac=
tivate.sh&quot;<br>
&gt; (or .fish or whatever) and then &quot;pylint --generate-rcfile | less&=
quot; to get a<br>
&gt; sample config and see all of the buttons, knobs and levers you could p=
ull.<br>
&gt; You can leave the environment when you&#39;re done with &quot;deactiva=
te&quot;.<br>
&gt;<br>
&gt; Mentioning this only because there have been times in the past that my=
<br>
&gt; formatting hasn&#39;t been to your liking, but there are avenues to<br=
>
&gt; programmatically enforce it to make my qapi patches nicer for your tas=
tes<br>
&gt; in the future.<br>
<br>
Thanks!<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D=
"auto">No problem! I know our tastes don&#39;t always match but I figure if=
 we can agree on a config file, it&#39;ll make things nicer for the both of=
 us in the future.</div><div dir=3D"auto"><br></div><div dir=3D"auto">We ca=
n discuss at KVM Forum too any of the little nits or preferences you&#39;d =
like to see automated and enforced to unify the Python style we use in tree=
. I&#39;d also like to discuss the usage of black formatting to automate aw=
ay the formatting guesswork. It&#39;d be a lot of churn, but it would drast=
ically simplify things. (e.g. &quot;make autoformat&quot; in the python dir=
, plus we can look into emacs/vim/vscode config for the repo)</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">I&#39;ll handle the config/maintenanc=
e/tooling but you can let me know your preferences.</div><div dir=3D"auto">=
<br></div><div dir=3D"auto">(This series should be a good example of which =
things I have configured for python/ that we didn&#39;t tackle for qapi. It=
 isn&#39;t very much. Some things you prefer may now be *unhandled*, I thin=
k docstring length being confined to 72(?) or less might be one of them, I =
don&#39;t recall others at the moment.)</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000fbcdd8062139c65d--


