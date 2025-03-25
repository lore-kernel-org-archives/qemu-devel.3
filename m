Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4432CC36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 17:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx8D5-00009t-FF; Tue, 25 Mar 2025 13:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tx8Cu-00008t-G6
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 13:37:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tx8Cq-0001xs-LJ
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 13:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742924211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Nystu0w3N8pTN1cdjfW8t6zrh/awpAQQVRVK6VKQoXc=;
 b=LySxEnJrsi+2fWvWNz4r/E+aqRlFoJpgNP6ye9DujOOx0IiI7llRQTSBngauSO5QkSY81l
 0WvrCMoR6MEaQ/iG4yEgbY9Gb/RULcpI5ChYjUOEAB5Dn3wChARtPwjZw8jzytaljhd3Om
 ojLRqtvukecJn68tXV1IRxZFzmmZ0n8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-hlZ2h6uCNySyXrkCX4BHBQ-1; Tue, 25 Mar 2025 13:36:49 -0400
X-MC-Unique: hlZ2h6uCNySyXrkCX4BHBQ-1
X-Mimecast-MFC-AGG-ID: hlZ2h6uCNySyXrkCX4BHBQ_1742924208
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ff8a2c7912so97991a91.1
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 10:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742924208; x=1743529008;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nystu0w3N8pTN1cdjfW8t6zrh/awpAQQVRVK6VKQoXc=;
 b=azNi9znrNvX4mMfsjdhxIVpop3dFu1SQxBD10VAYdFb5hwrdu49y3zUNkXTe/DZ6KY
 U8EahH3LmUUkFlMJdGLEpWqlILFOO/GUVzUJ1RhgdiZGbQl5B0tPb/OPc7+Lm48U6YN9
 FHMsOrs3IVKkJeBW8SwwliVz3fpcy+GTZX2EyUwL0bm8d1O55S3LOS4hudjnkbfkI0Qi
 p98EAl7K2C8jNZYxA2H4fQkvbx3uWKMCIYIVHIYDPodAveTCSGSQkJWpQ52R2J2jOWkg
 8jS4mTqfvrj+CGVeCEDEMl444FsoH+9/m5x4RrO/0AWXIrEKGP+a19Y0auJIeEQEeYoi
 GcVA==
X-Gm-Message-State: AOJu0YyQhUqrNZ+T8EVo0cBGPYUP9eA7LgC6FFgiQr4JCgBJJnjwxGnW
 +FTffTMxYpJaWpCf4rRBBQUSzPgJjAmIP4FCHHN6LzHvDGDp5mPr0WVyNwtdmooISBN2txKZDFx
 wdAeooTlRibYyVJJS0mP+VyWksD2H1fWhKBbdnZod0hENZPdcqqhBZXbs0Wqrp9ftMWArsVbZx/
 c7mcS7I5Qb0WJG1Ao4+X78luV4QKc=
X-Gm-Gg: ASbGnctHJrPItlrwQD5UxdDCEaMX7iFNz3w3Ogye1asvsIjrtf6fi6PSEwWmODfmfKJ
 t+Sk4Toam+h0kJbR3doPuNdNi2hjaXI3e1i+QzenUaHl2LcDSa4piFLfcj+XbrRwtkUpY4prwMl
 8/NohaxIctINAJshGsNUmoWZiRXhn3
X-Received: by 2002:a17:90b:2dc7:b0:2ff:4a8d:74f9 with SMTP id
 98e67ed59e1d1-3037890df74mr852597a91.10.1742924208032; 
 Tue, 25 Mar 2025 10:36:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeOkP8GUl8hu2KC8v8bjhkygYRKmvKqSiY6y7EnmRbyCI83fRcRBoRLI4lYtF4CLcTPJUucbpUY3aqJbptmN8=
X-Received: by 2002:a17:90b:2dc7:b0:2ff:4a8d:74f9 with SMTP id
 98e67ed59e1d1-3037890df74mr852560a91.10.1742924207535; Tue, 25 Mar 2025
 10:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250321222347.299121-1-jsnow@redhat.com>
 <20250321222347.299121-6-jsnow@redhat.com>
 <871pulpmbs.fsf@pond.sub.org>
In-Reply-To: <871pulpmbs.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 25 Mar 2025 13:36:36 -0400
X-Gm-Features: AQ5f1JpX0GkdK48V4XCP_N2kFDRTHAJQM0Xv7OiGWIlsMhxQ2tCUWK7e4ZQAsOY
Message-ID: <CAFn=p-ZMphLO291fDEfSC6M0k6gRerGJb1XzDUdCjYgmS-f7YA@mail.gmail.com>
Subject: Re: [PATCH 5/5] qapi: delete un-needed python static analysis configs
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000042cef606312e2a11"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

--00000000000042cef606312e2a11
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 4:05=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > The pylint config is being left in place because the settings differ
> > enough from the python/ directory settings that we need a chit-chat on
> > how to merge them O:-)
> >
> > Everything else can go.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/.flake8    | 3 ---
> >  scripts/qapi/.isort.cfg | 7 -------
> >  scripts/qapi/mypy.ini   | 4 ----
> >  3 files changed, 14 deletions(-)
> >  delete mode 100644 scripts/qapi/.flake8
> >  delete mode 100644 scripts/qapi/.isort.cfg
> >  delete mode 100644 scripts/qapi/mypy.ini
> >
> > diff --git a/scripts/qapi/.flake8 b/scripts/qapi/.flake8
> > deleted file mode 100644
> > index a873ff67309..00000000000
> > --- a/scripts/qapi/.flake8
> > +++ /dev/null
> > @@ -1,3 +0,0 @@
> > -[flake8]
> > -# Prefer pylint's bare-except checks to flake8's
> > -extend-ignore =3D E722
>
> python/setup.cfg has:
>
>    [flake8]
>    # Prefer pylint's bare-except checks to flake8's
>    extend-ignore =3D E722
>    exclude =3D __pycache__,
>
> Good.
>
> > diff --git a/scripts/qapi/.isort.cfg b/scripts/qapi/.isort.cfg
> > deleted file mode 100644
> > index 643caa1fbd6..00000000000
> > --- a/scripts/qapi/.isort.cfg
> > +++ /dev/null
> > @@ -1,7 +0,0 @@
> > -[settings]
> > -force_grid_wrap=3D4
> > -force_sort_within_sections=3DTrue
> > -include_trailing_comma=3DTrue
> > -line_length=3D72
> > -lines_after_imports=3D2
> > -multi_line_output=3D3
>
> python/setup.cfg has:
>
>    [isort]
>    force_grid_wrap=3D4
>    force_sort_within_sections=3DTrue
>    include_trailing_comma=3DTrue
>    line_length=3D72
>    lines_after_imports=3D2
>    multi_line_output=3D3
>
> Good.
>
> > diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
> > deleted file mode 100644
> > index 8109470a031..00000000000
> > --- a/scripts/qapi/mypy.ini
> > +++ /dev/null
> > @@ -1,4 +0,0 @@
> > -[mypy]
> > -strict =3D True
> > -disallow_untyped_calls =3D False
> > -python_version =3D 3.8
>
> python/setup.cfg has:
>
>    [mypy]
>    strict =3D True
>    python_version =3D 3.8
>    warn_unused_configs =3D True
>    namespace_packages =3D True
>    warn_unused_ignores =3D False
>
> Also a bunch of [mypy-FOO] sections that don't apply here.
>
> You explained the differences in review of a prior iteration.  Recap:
>
> } warn_unused_configs: Catches config values that aren't actually
> recognized
> } or used. Was helpful once upon a time when re-arranging the Python
> } directory to behave like a package to ensure that the conf files were
> } working correctly.
>
> Could this be culled now?
>

Maybe!


>
> Hmm, according to mypy(1), strict implies warn-unused-configs.
>
> The question does not block this patch.
>

Send me a patch to drop it O:-)


>
> } namespace_packages: Needed for the python/ directory structure (nested
> } packages under a namespace, "qemu"). Doesn't impact scripts/qapi at all=
.
> } Read up on PEP420 if you are curious. Details in commit message, see
> below
> } if you're still curious.
>
> mypy(1) makes me suspect this is the default.  If that's true across the
> versions we care for, this could be culled.
>
> Also does not block this patch.
>

It definitely wasn't once upon a time. It may still not be true on the
oldest mypy we currently support. We don't have a clear policy for what
versions of python libraries we need to support - this is a muddy, gray
area. So far I just try to avoid breaking support on older versions
needlessly, but I don't have an upgrade policy.

If we want to integrate this directly into make check, we'll likely need to
formalize this policy.


>
> } warn_unused_ignores: Needed once upon a time for cross-version mypy
> support
> } where some versions would warn in some cases and others would not. Addi=
ng
> } an ignore would effectively just invert which versions complained.
> Probably
> } still needed, but it's hard to measure.
>
> Harmless enough.
>
> } python_version: Changes mypy behavior regardless of the invoking python
> } interpreter to check the file as if it were to be executed by Python
> 3.8. I
> } actually want to remove this value from setup.cfg but haven't yet. I
> } removed it from the python-qemu-qmp repo and never added it for qapi.
> } Removing it is actually probably correct as it will catch errors specif=
ic
> } to various python versions we support, but there are some nits to iron
> out
> } in my neck of the woods. This is a case where scripts/qapi/ is stricter
> } than python/ :)
> } (Not reasonable to solve for this series.)
>
> Also present in the deleted file, so no change.
>
> } lack of disallow_untyped_calls =3D False: I think this might be a remna=
nt
> } from when we gradually typed qapi; it's evidently no longer needed sinc=
e
> } qapi still checks fine without this affordance. The default under stric=
t
> is
> } True.
>
> Fair enough.
>
> Let's mention the differences in the commit message.  Here's my try:
>
>     Since the previous commit, python/setup.cfg applies to scripts/qapi/
>     as well.  Configuration files in scripts/qapi/ override
>     python/setup.cfg.
>
>     scripts/qapi/.flake8 and scripts/qapi/.isort.cfg actually match
>     python/setup.cfg exactly, and can go.
>
>     The differences between scripts/qapi/mypy.ini and python/setup.cfg
>     are harmless: [list the differences, explain why they're harmless as
>     long as you can keep it brief, and if not, fall back to "trust me"].
>     So scripts/qapi/mypy.ini can go, too.
>
>     The pylint config is being left in place because the settings differ
>     enough from the python/ directory settings that we need a chit-chat o=
n
>     how to merge them O:-)
>
> With something like that
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>

okey-dokey, let me integrate this feedback and I'll re-send, but I'm going
to wait until we hash everything else out - you had some questions on other
bits in this series.

--00000000000042cef606312e2a11
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 25,=
 2025 at 4:05=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; The pylint config is being left in place because the settings differ<b=
r>
&gt; enough from the python/ directory settings that we need a chit-chat on=
<br>
&gt; how to merge them O:-)<br>
&gt;<br>
&gt; Everything else can go.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 scripts/qapi/.flake8=C2=A0 =C2=A0 | 3 ---<br>
&gt;=C2=A0 scripts/qapi/.isort.cfg | 7 -------<br>
&gt;=C2=A0 scripts/qapi/mypy.ini=C2=A0 =C2=A0| 4 ----<br>
&gt;=C2=A0 3 files changed, 14 deletions(-)<br>
&gt;=C2=A0 delete mode 100644 scripts/qapi/.flake8<br>
&gt;=C2=A0 delete mode 100644 scripts/qapi/.isort.cfg<br>
&gt;=C2=A0 delete mode 100644 scripts/qapi/mypy.ini<br>
&gt;<br>
&gt; diff --git a/scripts/qapi/.flake8 b/scripts/qapi/.flake8<br>
&gt; deleted file mode 100644<br>
&gt; index a873ff67309..00000000000<br>
&gt; --- a/scripts/qapi/.flake8<br>
&gt; +++ /dev/null<br>
&gt; @@ -1,3 +0,0 @@<br>
&gt; -[flake8]<br>
&gt; -# Prefer pylint&#39;s bare-except checks to flake8&#39;s<br>
&gt; -extend-ignore =3D E722<br>
<br>
python/setup.cfg has:<br>
<br>
=C2=A0 =C2=A0[flake8]<br>
=C2=A0 =C2=A0# Prefer pylint&#39;s bare-except checks to flake8&#39;s<br>
=C2=A0 =C2=A0extend-ignore =3D E722<br>
=C2=A0 =C2=A0exclude =3D __pycache__,<br>
<br>
Good.<br>
<br>
&gt; diff --git a/scripts/qapi/.isort.cfg b/scripts/qapi/.isort.cfg<br>
&gt; deleted file mode 100644<br>
&gt; index 643caa1fbd6..00000000000<br>
&gt; --- a/scripts/qapi/.isort.cfg<br>
&gt; +++ /dev/null<br>
&gt; @@ -1,7 +0,0 @@<br>
&gt; -[settings]<br>
&gt; -force_grid_wrap=3D4<br>
&gt; -force_sort_within_sections=3DTrue<br>
&gt; -include_trailing_comma=3DTrue<br>
&gt; -line_length=3D72<br>
&gt; -lines_after_imports=3D2<br>
&gt; -multi_line_output=3D3<br>
<br>
python/setup.cfg has:<br>
<br>
=C2=A0 =C2=A0[isort]<br>
=C2=A0 =C2=A0force_grid_wrap=3D4<br>
=C2=A0 =C2=A0force_sort_within_sections=3DTrue<br>
=C2=A0 =C2=A0include_trailing_comma=3DTrue<br>
=C2=A0 =C2=A0line_length=3D72<br>
=C2=A0 =C2=A0lines_after_imports=3D2<br>
=C2=A0 =C2=A0multi_line_output=3D3<br>
<br>
Good.<br>
<br>
&gt; diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini<br>
&gt; deleted file mode 100644<br>
&gt; index 8109470a031..00000000000<br>
&gt; --- a/scripts/qapi/mypy.ini<br>
&gt; +++ /dev/null<br>
&gt; @@ -1,4 +0,0 @@<br>
&gt; -[mypy]<br>
&gt; -strict =3D True<br>
&gt; -disallow_untyped_calls =3D False<br>
&gt; -python_version =3D 3.8<br>
<br>
python/setup.cfg has:<br>
<br>
=C2=A0 =C2=A0[mypy]<br>
=C2=A0 =C2=A0strict =3D True<br>
=C2=A0 =C2=A0python_version =3D 3.8<br>
=C2=A0 =C2=A0warn_unused_configs =3D True<br>
=C2=A0 =C2=A0namespace_packages =3D True<br>
=C2=A0 =C2=A0warn_unused_ignores =3D False<br>
<br>
Also a bunch of [mypy-FOO] sections that don&#39;t apply here.<br>
<br>
You explained the differences in review of a prior iteration.=C2=A0 Recap:<=
br>
<br>
} warn_unused_configs: Catches config values that aren&#39;t actually recog=
nized<br>
} or used. Was helpful once upon a time when re-arranging the Python<br>
} directory to behave like a package to ensure that the conf files were<br>
} working correctly.<br>
<br>
Could this be culled now?<br></blockquote><div><br></div><div>Maybe!</div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Hmm, according to mypy(1), strict implies warn-unused-configs.<br>
<br>
The question does not block this patch.<br></blockquote><div><br></div><div=
>Send me a patch to drop it O:-)</div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
<br>
} namespace_packages: Needed for the python/ directory structure (nested<br=
>
} packages under a namespace, &quot;qemu&quot;). Doesn&#39;t impact scripts=
/qapi at all.<br>
} Read up on PEP420 if you are curious. Details in commit message, see belo=
w<br>
} if you&#39;re still curious.<br>
<br>
mypy(1) makes me suspect this is the default.=C2=A0 If that&#39;s true acro=
ss the<br>
versions we care for, this could be culled.<br>
<br>
Also does not block this patch.<br></blockquote><div><br></div><div>It defi=
nitely wasn&#39;t once upon a time. It may still not be true on the oldest =
mypy we currently support. We don&#39;t have a clear policy for what versio=
ns of python libraries we need to support - this is a muddy, gray area. So =
far I just try to avoid breaking support on older versions needlessly, but =
I don&#39;t have an upgrade policy.</div><div><br></div><div>If we want to =
integrate this directly into make check, we&#39;ll likely need to formalize=
 this policy.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
} warn_unused_ignores: Needed once upon a time for cross-version mypy suppo=
rt<br>
} where some versions would warn in some cases and others would not. Adding=
<br>
} an ignore would effectively just invert which versions complained. Probab=
ly<br>
} still needed, but it&#39;s hard to measure.<br>
<br>
Harmless enough.<br>
<br>
} python_version: Changes mypy behavior regardless of the invoking python<b=
r>
} interpreter to check the file as if it were to be executed by Python 3.8.=
 I<br>
} actually want to remove this value from setup.cfg but haven&#39;t yet. I<=
br>
} removed it from the python-qemu-qmp repo and never added it for qapi.<br>
} Removing it is actually probably correct as it will catch errors specific=
<br>
} to various python versions we support, but there are some nits to iron ou=
t<br>
} in my neck of the woods. This is a case where scripts/qapi/ is stricter<b=
r>
} than python/ :)<br>
} (Not reasonable to solve for this series.)<br>
<br>
Also present in the deleted file, so no change.<br>
<br>
} lack of disallow_untyped_calls =3D False: I think this might be a remnant=
<br>
} from when we gradually typed qapi; it&#39;s evidently no longer needed si=
nce<br>
} qapi still checks fine without this affordance. The default under strict =
is<br>
} True.<br>
<br>
Fair enough.<br>
<br>
Let&#39;s mention the differences in the commit message.=C2=A0 Here&#39;s m=
y try:<br>
<br>
=C2=A0 =C2=A0 Since the previous commit, python/setup.cfg applies to script=
s/qapi/<br>
=C2=A0 =C2=A0 as well.=C2=A0 Configuration files in scripts/qapi/ override<=
br>
=C2=A0 =C2=A0 python/setup.cfg.<br>
<br>
=C2=A0 =C2=A0 scripts/qapi/.flake8 and scripts/qapi/.isort.cfg actually mat=
ch<br>
=C2=A0 =C2=A0 python/setup.cfg exactly, and can go.<br>
<br>
=C2=A0 =C2=A0 The differences between scripts/qapi/mypy.ini and python/setu=
p.cfg<br>
=C2=A0 =C2=A0 are harmless: [list the differences, explain why they&#39;re =
harmless as<br>
=C2=A0 =C2=A0 long as you can keep it brief, and if not, fall back to &quot=
;trust me&quot;].<br>
=C2=A0 =C2=A0 So scripts/qapi/mypy.ini can go, too.<br>
<br>
=C2=A0 =C2=A0 The pylint config is being left in place because the settings=
 differ<br>
=C2=A0 =C2=A0 enough from the python/ directory settings that we need a chi=
t-chat on<br>
=C2=A0 =C2=A0 how to merge them O:-)<br>
<br>
With something like that<br>
Reviewed-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" tar=
get=3D"_blank">armbru@redhat.com</a>&gt;<br></blockquote><div><br></div><di=
v>okey-dokey, let me integrate this feedback and I&#39;ll re-send, but I&#3=
9;m going to wait until we hash everything else out - you had some question=
s on other bits in this series.</div><div>=C2=A0</div></div></div>

--00000000000042cef606312e2a11--


