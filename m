Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A61C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 20:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txXJQ-00074X-9Q; Wed, 26 Mar 2025 16:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1txXJN-00073M-A6
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 16:25:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1txXJD-0004A8-UW
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 16:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743020704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=URxPeiaR9Ad6+9RXiA1ibjiqS86ghyo6FmyhsK+/ESQ=;
 b=ht4re0zRwPkJIcQgoN395hXPozV249aLmp5Jhf0E3EWo6V1lCbcq/sFnLhZRxJlrSNG0Ar
 XIZUClY1lkCf+uJef06SzKrIEJ96tijBFdgbIE3Tp8KlaqUtmCtBqnI4ODW1NjVtqiuhhF
 Y9xsDr6+L/v0RDLVFqoUZYIYc5BGoiY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-e_Icd4eTNNedqcbuJD7MsQ-1; Wed, 26 Mar 2025 16:25:02 -0400
X-MC-Unique: e_Icd4eTNNedqcbuJD7MsQ-1
X-Mimecast-MFC-AGG-ID: e_Icd4eTNNedqcbuJD7MsQ_1743020702
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ff799be8f5so301852a91.1
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 13:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743020701; x=1743625501;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=URxPeiaR9Ad6+9RXiA1ibjiqS86ghyo6FmyhsK+/ESQ=;
 b=q51EBsQZQBhuqJFUqsolQZhTwAOavRLKOrlGmda39OJPgso7lPJW2lbZO8c2TaWisH
 VC9260I7+F741rFik+DzuSRTRUj6OOEE1x6MCQTAaVErEoRbmS17uu0bV2yECnPSjpHF
 g2l9rVN5RtdgR/UGoI6aot9RXk3EFdEGZa0H2B0cAiP/ZPopu2GCOQQvg4Kp7ymlDGdd
 K3pcCP69IH3FR7jhTCKccviw39iiEjWF9Ww0naYPO4I+/uFjvGJV5opIXcMI5NscXARj
 OOdlCkTkn603UWqIKF6rEekYgo7DSJ6ZaLVTGvlv0wM7XaBg65J7UJbK0Vsd5gp/HVi0
 7THg==
X-Gm-Message-State: AOJu0YyaPgRSUg9HPAtdQ/s1LTG8fM52xMdbquiRBEpgSrfnB2iKahQl
 7NMViXl/pO0CcZdMG1uD9I2ivk03tTorVjozmJEl4NvdI6B7FTUbun/ooxyZwpS656N0R7YG90T
 AY1rzpQZk/xP93dYj2WWVLH7OAxsMc9Km85W2m+kZdUfvevgUd0at/TR4tG/cBhcszpvSwycD70
 fpI+n9ULD7WYy4oYkfzI3lipTyU00=
X-Gm-Gg: ASbGncto6The++H9FaBQOc42zTPYZITtH3ITTG1gbwCH4eYQ+Txe3KRFB3lTF2ASmyW
 KHNqQ/sr+4aTg943Dr7KRJV4ME+Iy2ZKyJrHMv3VbFEcUA8bpPNeonZmrYRtlU6fE5a3z/IEebR
 riwKgPXaOODlDQ+Uxtym3hJHmOTgzl
X-Received: by 2002:a17:90b:2e8d:b0:2fe:a545:4c84 with SMTP id
 98e67ed59e1d1-303a91871d4mr1407996a91.34.1743020701376; 
 Wed, 26 Mar 2025 13:25:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZJNfmSjDQykFlcYnZwrQS7yNBgY6cnaNWv3dfpkx5OT4ODPbycCzmIjZoLWv+RpH0XzwjbZHYAcAClw9Ekk8=
X-Received: by 2002:a17:90b:2e8d:b0:2fe:a545:4c84 with SMTP id
 98e67ed59e1d1-303a91871d4mr1407972a91.34.1743020700882; Wed, 26 Mar 2025
 13:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250321222347.299121-1-jsnow@redhat.com>
 <20250321222347.299121-6-jsnow@redhat.com>
 <871pulpmbs.fsf@pond.sub.org>
 <CAFn=p-ZMphLO291fDEfSC6M0k6gRerGJb1XzDUdCjYgmS-f7YA@mail.gmail.com>
 <87a598dzul.fsf@pond.sub.org>
In-Reply-To: <87a598dzul.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 26 Mar 2025 16:24:48 -0400
X-Gm-Features: AQ5f1JrGSGL2MIF--tnv9mav0TSVtg-v0m2MQvFlD4opYBzzDEJitwJdhTHpX5o
Message-ID: <CAFn=p-Y5z==de7nNX4jHk7Tf40rAfdLvdQpeg1tfwk9vaetsag@mail.gmail.com>
Subject: Re: [PATCH 5/5] qapi: delete un-needed python static analysis configs
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000b6755a063144a19f"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

--000000000000b6755a063144a19f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 3:18=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > On Tue, Mar 25, 2025 at 4:05=E2=80=AFAM Markus Armbruster <armbru@redha=
t.com>
> wrote:
> >
> >> John Snow <jsnow@redhat.com> writes:
> >>
> >> > The pylint config is being left in place because the settings differ
> >> > enough from the python/ directory settings that we need a chit-chat =
on
> >> > how to merge them O:-)
> >> >
> >> > Everything else can go.
> >> >
> >> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> [...]
>
> >> > diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
> >> > deleted file mode 100644
> >> > index 8109470a031..00000000000
> >> > --- a/scripts/qapi/mypy.ini
> >> > +++ /dev/null
> >> > @@ -1,4 +0,0 @@
> >> > -[mypy]
> >> > -strict =3D True
> >> > -disallow_untyped_calls =3D False
> >> > -python_version =3D 3.8
> >>
> >> python/setup.cfg has:
> >>
> >>    [mypy]
> >>    strict =3D True
> >>    python_version =3D 3.8
> >>    warn_unused_configs =3D True
> >>    namespace_packages =3D True
> >>    warn_unused_ignores =3D False
> >>
> >> Also a bunch of [mypy-FOO] sections that don't apply here.
> >>
> >> You explained the differences in review of a prior iteration.  Recap:
> >>
> >> } warn_unused_configs: Catches config values that aren't actually
> recognized
> >> } or used. Was helpful once upon a time when re-arranging the Python
> >> } directory to behave like a package to ensure that the conf files wer=
e
> >> } working correctly.
> >>
> >> Could this be culled now?
> >>
> >
> > Maybe!
> >
> >
> >>
> >> Hmm, according to mypy(1), strict implies warn-unused-configs.
> >>
> >> The question does not block this patch.
> >>
> >
> > Send me a patch to drop it O:-)
>
> Done:
>
>     [PATCH] python: Drop redundant warn_unused_configs =3D True
>     Message-ID: <20250326071203.238931-1-armbru@redhat.com>
>

yay :)


>
> >> } namespace_packages: Needed for the python/ directory structure (nest=
ed
> >> } packages under a namespace, "qemu"). Doesn't impact scripts/qapi at
> all.
> >> } Read up on PEP420 if you are curious. Details in commit message, see
> below
> >> } if you're still curious.
> >>
> >> mypy(1) makes me suspect this is the default.  If that's true across t=
he
> >> versions we care for, this could be culled.
> >>
> >> Also does not block this patch.
> >>
> >
> > It definitely wasn't once upon a time. It may still not be true on the
> > oldest mypy we currently support. We don't have a clear policy for what
> > versions of python libraries we need to support - this is a muddy, gray
> > area. So far I just try to avoid breaking support on older versions
> > needlessly, but I don't have an upgrade policy.
>
> So what is the oldest mypy we currently support?  Unknown, best effort
> to fix any breakage we see?  Wouldn't quite match my dictionary's
> definition of "support"...
>

from python/setup.cfg; mypy >=3D 1.4.0
from python/tests/minreqs.txt; mypy=3D=3D1.4.0

This version is used for the minreqs test so I can be assured that we
haven't broken anything for the old pythons and the old type checkers. I
guarantee this version *will* work. I also guarantee the latest version
will work. I don't necessarily guarantee everything in between, but I make
my best effort.


>
> > If we want to integrate this directly into make check, we'll likely nee=
d
> to
> > formalize this policy.
>
> My gut feeling: supporting old mypy isn't worth much (if any) trouble.
>

Very extremely likely true! If people are fine with "you need PyPI and and
internet connection to run linter tests *at all*" we could move to the
latest version(s) (as supported per-python interpreter, at least) and be
done with it.

As I recall, some folks (Kevin Wolf?) had some requirements that they be
able to run iotests and so forth outside of configure, which makes this
kind of thing harder.

The tests grew out of ad-hoc scripts that had to work with whatever you
happened to have installed, though, and so it still supports a wide range
of linter versions for that reason. If I had my way, I'd stipulate we only
ever use a specific version that I pin quite close to the current bleeding
edge and then just periodically update the pin as needed for new features
or bugfixes or compatibility for shifting python interpreter support
windows.

If you want to discuss this and tackle it next release, I'm open to it,
I've just lost a *lot* of appetite for making new package version
requirement edicts in and around the build/doc/test system.


>
> >> } warn_unused_ignores: Needed once upon a time for cross-version mypy
> support
> >> } where some versions would warn in some cases and others would not.
> Adding
> >> } an ignore would effectively just invert which versions complained.
> Probably
> >> } still needed, but it's hard to measure.
> >>
> >> Harmless enough.
> >>
> >> } python_version: Changes mypy behavior regardless of the invoking
> python
> >> } interpreter to check the file as if it were to be executed by Python
> 3.8. I
> >> } actually want to remove this value from setup.cfg but haven't yet. I
> >> } removed it from the python-qemu-qmp repo and never added it for qapi=
.
> >> } Removing it is actually probably correct as it will catch errors
> specific
> >> } to various python versions we support, but there are some nits to
> iron out
> >> } in my neck of the woods. This is a case where scripts/qapi/ is
> stricter
> >> } than python/ :)
> >> } (Not reasonable to solve for this series.)
> >>
> >> Also present in the deleted file, so no change.
> >>
> >> } lack of disallow_untyped_calls =3D False: I think this might be a
> remnant
> >> } from when we gradually typed qapi; it's evidently no longer needed
> since
> >> } qapi still checks fine without this affordance. The default under
> strict is
> >> } True.
> >>
> >> Fair enough.
> >>
> >> Let's mention the differences in the commit message.  Here's my try:
> >>
> >>     Since the previous commit, python/setup.cfg applies to scripts/qap=
i/
> >>     as well.  Configuration files in scripts/qapi/ override
> >>     python/setup.cfg.
> >>
> >>     scripts/qapi/.flake8 and scripts/qapi/.isort.cfg actually match
> >>     python/setup.cfg exactly, and can go.
> >>
> >>     The differences between scripts/qapi/mypy.ini and python/setup.cfg
> >>     are harmless: [list the differences, explain why they're harmless =
as
> >>     long as you can keep it brief, and if not, fall back to "trust me"=
].
> >>     So scripts/qapi/mypy.ini can go, too.
> >>
> >>     The pylint config is being left in place because the settings diff=
er
> >>     enough from the python/ directory settings that we need a chit-cha=
t
> on
> >>     how to merge them O:-)
> >>
> >> With something like that
> >> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> >>
> >
> > okey-dokey, let me integrate this feedback and I'll re-send, but I'm
> going
> > to wait until we hash everything else out - you had some questions on
> other
> > bits in this series.
>
> Thanks!
>
>

--000000000000b6755a063144a19f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 26,=
 2025 at 3:18=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; On Tue, Mar 25, 2025 at 4:05=E2=80=AFAM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt; w=
rote:<br>
&gt;<br>
&gt;&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank=
">jsnow@redhat.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; The pylint config is being left in place because the settings=
 differ<br>
&gt;&gt; &gt; enough from the python/ directory settings that we need a chi=
t-chat on<br>
&gt;&gt; &gt; how to merge them O:-)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Everything else can go.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.c=
om" target=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
[...]<br>
<br>
&gt;&gt; &gt; diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini<br=
>
&gt;&gt; &gt; deleted file mode 100644<br>
&gt;&gt; &gt; index 8109470a031..00000000000<br>
&gt;&gt; &gt; --- a/scripts/qapi/mypy.ini<br>
&gt;&gt; &gt; +++ /dev/null<br>
&gt;&gt; &gt; @@ -1,4 +0,0 @@<br>
&gt;&gt; &gt; -[mypy]<br>
&gt;&gt; &gt; -strict =3D True<br>
&gt;&gt; &gt; -disallow_untyped_calls =3D False<br>
&gt;&gt; &gt; -python_version =3D 3.8<br>
&gt;&gt;<br>
&gt;&gt; python/setup.cfg has:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 [mypy]<br>
&gt;&gt;=C2=A0 =C2=A0 strict =3D True<br>
&gt;&gt;=C2=A0 =C2=A0 python_version =3D 3.8<br>
&gt;&gt;=C2=A0 =C2=A0 warn_unused_configs =3D True<br>
&gt;&gt;=C2=A0 =C2=A0 namespace_packages =3D True<br>
&gt;&gt;=C2=A0 =C2=A0 warn_unused_ignores =3D False<br>
&gt;&gt;<br>
&gt;&gt; Also a bunch of [mypy-FOO] sections that don&#39;t apply here.<br>
&gt;&gt;<br>
&gt;&gt; You explained the differences in review of a prior iteration.=C2=
=A0 Recap:<br>
&gt;&gt;<br>
&gt;&gt; } warn_unused_configs: Catches config values that aren&#39;t actua=
lly recognized<br>
&gt;&gt; } or used. Was helpful once upon a time when re-arranging the Pyth=
on<br>
&gt;&gt; } directory to behave like a package to ensure that the conf files=
 were<br>
&gt;&gt; } working correctly.<br>
&gt;&gt;<br>
&gt;&gt; Could this be culled now?<br>
&gt;&gt;<br>
&gt;<br>
&gt; Maybe!<br>
&gt;<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; Hmm, according to mypy(1), strict implies warn-unused-configs.<br>
&gt;&gt;<br>
&gt;&gt; The question does not block this patch.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Send me a patch to drop it O:-)<br>
<br>
Done:<br>
<br>
=C2=A0 =C2=A0 [PATCH] python: Drop redundant warn_unused_configs =3D True<b=
r>
=C2=A0 =C2=A0 Message-ID: &lt;<a href=3D"mailto:20250326071203.238931-1-arm=
bru@redhat.com" target=3D"_blank">20250326071203.238931-1-armbru@redhat.com=
</a>&gt;<br></blockquote><div><br></div><div>yay :)</div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;&gt; } namespace_packages: Needed for the python/ directory structure (=
nested<br>
&gt;&gt; } packages under a namespace, &quot;qemu&quot;). Doesn&#39;t impac=
t scripts/qapi at all.<br>
&gt;&gt; } Read up on PEP420 if you are curious. Details in commit message,=
 see below<br>
&gt;&gt; } if you&#39;re still curious.<br>
&gt;&gt;<br>
&gt;&gt; mypy(1) makes me suspect this is the default.=C2=A0 If that&#39;s =
true across the<br>
&gt;&gt; versions we care for, this could be culled.<br>
&gt;&gt;<br>
&gt;&gt; Also does not block this patch.<br>
&gt;&gt;<br>
&gt;<br>
&gt; It definitely wasn&#39;t once upon a time. It may still not be true on=
 the<br>
&gt; oldest mypy we currently support. We don&#39;t have a clear policy for=
 what<br>
&gt; versions of python libraries we need to support - this is a muddy, gra=
y<br>
&gt; area. So far I just try to avoid breaking support on older versions<br=
>
&gt; needlessly, but I don&#39;t have an upgrade policy.<br>
<br>
So what is the oldest mypy we currently support?=C2=A0 Unknown, best effort=
<br>
to fix any breakage we see?=C2=A0 Wouldn&#39;t quite match my dictionary&#3=
9;s<br>
definition of &quot;support&quot;...<br></blockquote><div><br></div><div>fr=
om python/setup.cfg; mypy &gt;=3D 1.4.0</div><div>from python/tests/minreqs=
.txt; mypy=3D=3D1.4.0</div><div><br></div><div>This version is used for the=
 minreqs test so I can be assured that we haven&#39;t broken anything for t=
he old pythons and the old type checkers. I guarantee this version *will* w=
ork. I also guarantee the latest version will work. I don&#39;t necessarily=
 guarantee everything in between, but I make my best effort.</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; If we want to integrate this directly into make check, we&#39;ll likel=
y need to<br>
&gt; formalize this policy.<br>
<br>
My gut feeling: supporting old mypy isn&#39;t worth much (if any) trouble.<=
br></blockquote><div><br></div><div>Very extremely likely true! If people a=
re fine with &quot;you need PyPI and and internet connection to run linter =
tests *at all*&quot; we could move to the latest version(s) (as supported p=
er-python interpreter, at least) and be done with it.</div><div><br></div><=
div>As I recall, some folks (Kevin Wolf?) had some requirements that they b=
e able to run iotests and so forth outside of configure, which makes this k=
ind of thing harder.</div><div><br></div><div>The tests grew out of ad-hoc =
scripts that had to work with whatever you happened to have installed, thou=
gh, and so it still supports a wide range of linter versions for that reaso=
n. If I had my way, I&#39;d stipulate we only ever use a specific version t=
hat I pin quite close to the current bleeding edge and then just periodical=
ly update the pin as needed for new features or bugfixes or compatibility f=
or shifting python interpreter support windows.</div><div><br></div><div>If=
 you want to discuss this and tackle it next release, I&#39;m open to it, I=
&#39;ve just lost a *lot* of appetite for making new package version requir=
ement edicts in and around the build/doc/test system.</div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;&gt; } warn_unused_ignores: Needed once upon a time for cross-version m=
ypy support<br>
&gt;&gt; } where some versions would warn in some cases and others would no=
t. Adding<br>
&gt;&gt; } an ignore would effectively just invert which versions complaine=
d. Probably<br>
&gt;&gt; } still needed, but it&#39;s hard to measure.<br>
&gt;&gt;<br>
&gt;&gt; Harmless enough.<br>
&gt;&gt;<br>
&gt;&gt; } python_version: Changes mypy behavior regardless of the invoking=
 python<br>
&gt;&gt; } interpreter to check the file as if it were to be executed by Py=
thon 3.8. I<br>
&gt;&gt; } actually want to remove this value from setup.cfg but haven&#39;=
t yet. I<br>
&gt;&gt; } removed it from the python-qemu-qmp repo and never added it for =
qapi.<br>
&gt;&gt; } Removing it is actually probably correct as it will catch errors=
 specific<br>
&gt;&gt; } to various python versions we support, but there are some nits t=
o iron out<br>
&gt;&gt; } in my neck of the woods. This is a case where scripts/qapi/ is s=
tricter<br>
&gt;&gt; } than python/ :)<br>
&gt;&gt; } (Not reasonable to solve for this series.)<br>
&gt;&gt;<br>
&gt;&gt; Also present in the deleted file, so no change.<br>
&gt;&gt;<br>
&gt;&gt; } lack of disallow_untyped_calls =3D False: I think this might be =
a remnant<br>
&gt;&gt; } from when we gradually typed qapi; it&#39;s evidently no longer =
needed since<br>
&gt;&gt; } qapi still checks fine without this affordance. The default unde=
r strict is<br>
&gt;&gt; } True.<br>
&gt;&gt;<br>
&gt;&gt; Fair enough.<br>
&gt;&gt;<br>
&gt;&gt; Let&#39;s mention the differences in the commit message.=C2=A0 Her=
e&#39;s my try:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0Since the previous commit, python/setup.cfg app=
lies to scripts/qapi/<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0as well.=C2=A0 Configuration files in scripts/q=
api/ override<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0python/setup.cfg.<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0scripts/qapi/.flake8 and scripts/qapi/.isort.cf=
g actually match<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0python/setup.cfg exactly, and can go.<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0The differences between scripts/qapi/mypy.ini a=
nd python/setup.cfg<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0are harmless: [list the differences, explain wh=
y they&#39;re harmless as<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0long as you can keep it brief, and if not, fall=
 back to &quot;trust me&quot;].<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0So scripts/qapi/mypy.ini can go, too.<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0The pylint config is being left in place becaus=
e the settings differ<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0enough from the python/ directory settings that=
 we need a chit-chat on<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0how to merge them O:-)<br>
&gt;&gt;<br>
&gt;&gt; With something like that<br>
&gt;&gt; Reviewed-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat=
.com" target=3D"_blank">armbru@redhat.com</a>&gt;<br>
&gt;&gt;<br>
&gt;<br>
&gt; okey-dokey, let me integrate this feedback and I&#39;ll re-send, but I=
&#39;m going<br>
&gt; to wait until we hash everything else out - you had some questions on =
other<br>
&gt; bits in this series.<br>
<br>
Thanks!<br>
<br>
</blockquote></div></div>

--000000000000b6755a063144a19f--


