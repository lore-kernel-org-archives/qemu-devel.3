Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F30C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 15:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpqix-0005m8-4M; Wed, 05 Mar 2025 10:31:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpqip-0005kZ-LG
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:31:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpqim-0001K6-UN
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:31:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741188703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dciFjaAMuyZ3yVjs17sfN0lSXgqQlYpJzYVQeSAeMJs=;
 b=gNNFMqxJEQL/x1V0I3mp1ghpNnGV+FcnS4p9ltlfq3UKq9VQdze00ka0D0zAGjOkYDoNjv
 0Il8RQJNvGrN/UmTEoojpjBzmLX7SSymWQMmGawI19PFWQMk4RucBIoJJ/z0MdiXaxor5j
 i6boltR7C/ER/aYrX4tJHntGIAqfoF8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-QIDn7DiKOtqqIkKJyiNmvA-1; Wed, 05 Mar 2025 10:31:41 -0500
X-MC-Unique: QIDn7DiKOtqqIkKJyiNmvA-1
X-Mimecast-MFC-AGG-ID: QIDn7DiKOtqqIkKJyiNmvA_1741188700
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ff4b130bb2so1705274a91.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 07:31:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741188700; x=1741793500;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dciFjaAMuyZ3yVjs17sfN0lSXgqQlYpJzYVQeSAeMJs=;
 b=TF04wzeNmLiI4f8+RkitjVH5cAzVYqx0qDR2v4+O49Dx5I1ZIsrTP8TG6y48faoyKe
 JNH3b11DKPVgyMvhSleHhp1ylmXOInncYaF+3R/KUZV40QFwCXXLejjsMz0Rt6DFNYVy
 /TCxZdOVrIktxP3GdY2ZGft2asLXXQKSWcpoDdIaYPwB4bjsnx9HaIb5aIa1K/yk4xi+
 tK4HYIeanh48delGkJm04fSxNeaORdIr3zO1D3chrg8IAwnODZvbz4EjZ4a5X1N4Iaig
 iSC4T3hM7MegjC/1VO/H0B2DhCmR/Biwxk1B+gvw9C1sV7v1m2pON1W4ghUZDcNMeC7l
 pTvA==
X-Gm-Message-State: AOJu0Yxz0ilNfcjUNBn8EOHa2I4K+rwiwCWgfsIppkjxrTm4P1/Wax71
 1qoBR8QAyGaurzXtEp28bPV/hZuBV8GZp8lpWSslkTRMc/H1fXBLh1J8OAntw+9hQ/7hGk28r8m
 +Ru5exbzZq1eft4wW1q6NfSeyhnSknlJV+r7eV08sD/pGXgTzMDKOzDrrMPuaH9RdzXip1PiBOT
 4JRUXEAh7ziTyClOQWV87y7cZ+Cd4=
X-Gm-Gg: ASbGncvoFvvLbpPYeE83gIS1atGdbRFmYkMZqzOFYZKJjIiEI8qPwazUflHpUrqwW02
 oPdsVDO+3XArJDTGSWSJ9qnf+COMJ7wAl7E/ORI9FuGohr5btcum0d78DuzGax1qemFjjy1jPUe
 1nh2o/9phVBLHYwz4xoldzLLWPy3Za
X-Received: by 2002:a17:90b:4990:b0:2f2:ab09:c256 with SMTP id
 98e67ed59e1d1-2ff4981f5f1mr6603751a91.33.1741188700401; 
 Wed, 05 Mar 2025 07:31:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKQYPWFzIQ8c4PJNMdtE1Z7Gd0gnsHnxmoLx4oV8SksfvCdE6fnohymiIBfmCe4OMaD/DmuvsgBPgjl/yJ8hs=
X-Received: by 2002:a17:90b:4990:b0:2f2:ab09:c256 with SMTP id
 98e67ed59e1d1-2ff4981f5f1mr6603706a91.33.1741188700081; Wed, 05 Mar 2025
 07:31:40 -0800 (PST)
MIME-Version: 1.0
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-3-jsnow@redhat.com>
 <87frjsoutb.fsf@pond.sub.org>
In-Reply-To: <87frjsoutb.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 5 Mar 2025 10:31:27 -0500
X-Gm-Features: AQ5f1JptjVAq8KpmpmsTPwL0EvczXotXK6315HJ7dZD-Gfx-W5Ndb-w3JA5vNek
Message-ID: <CAFn=p-aKxZ1iQDCWOjY54KsvyKFxns288yCbbFumkMRAGywRDA@mail.gmail.com>
Subject: Re: [PATCH 02/57] qapi: shush pylint up
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f4ae6e062f9a1582"
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

--000000000000f4ae6e062f9a1582
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025, 1:28=E2=80=AFAM Markus Armbruster <armbru@redhat.com> =
wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Shhhhh!
> >
> > This patch is RFC quality, I wasn't in the mood to actually solve
> > problems so much as I was in the mood to continue working on the Sphinx
> > rework. Plus, I don't think the code I am patching has hit origin/maste=
r
> > yet ...
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/backend.py |  2 ++
> >  scripts/qapi/main.py    | 10 ++++------
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/scripts/qapi/backend.py b/scripts/qapi/backend.py
> > index 14e60aa67af..49ae6ecdd33 100644
> > --- a/scripts/qapi/backend.py
> > +++ b/scripts/qapi/backend.py
> > @@ -13,6 +13,7 @@
> >
> >
> >  class QAPIBackend(ABC):
> > +    # pylint: disable=3Dtoo-few-public-methods
> >
> >      @abstractmethod
> >      def generate(self,
> > @@ -36,6 +37,7 @@ def generate(self,
> >
> >
> >  class QAPICBackend(QAPIBackend):
> > +    # pylint: disable=3Dtoo-few-public-methods
> >
> >      def generate(self,
> >                   schema: QAPISchema,
>
> I didn't bother to ask for these in my review.  Do they get us to the
> point where we can enable automatic pylint?
>

Yes.


> > diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
> > index ff42b43cd68..01155373bd0 100644
> > --- a/scripts/qapi/main.py
> > +++ b/scripts/qapi/main.py
> > @@ -31,15 +31,14 @@ def create_backend(path: str) -> QAPIBackend:
> >
> >      module_path, dot, class_name =3D path.rpartition('.')
> >      if not dot:
> > -        print(f"argument of -B must be of the form MODULE.CLASS",
> > +        print("argument of -B must be of the form MODULE.CLASS",
>
> This one's already in "[PULL v2 0/5] QAPI patches patches for
> 2025-02-26".  No worries.
>

Got it. I'll repull your tags.


> >                file=3Dsys.stderr)
> >          sys.exit(1)
> >
> >      try:
> >          mod =3D import_module(module_path)
> >      except Exception as ex:
> > -        print(f"unable to import '{module_path}': {ex}",
> file=3Dsys.stderr)
> > -        sys.exit(1)
> > +        raise QAPIError(f"unable to import '{module_path}': {ex}") fro=
m
> ex
> >
> >      try:
> >          klass =3D getattr(mod, class_name)
> > @@ -51,9 +50,8 @@ def create_backend(path: str) -> QAPIBackend:
> >      try:
> >          backend =3D klass()
> >      except Exception as ex:
> > -        print(f"backend '{path}' cannot be instantiated: {ex}",
> > -              file=3Dsys.stderr)
> > -        sys.exit(1)
> > +        raise QAPIError(
> > +            f"backend '{path}' cannot be instantiated: {ex}") from ex
> >
> >      if not isinstance(backend, QAPIBackend):
> >          print(f"backend '{path}' must be an instance of QAPIBackend",
>
> Missed in my review: the caller catches QAPIError, and returns non-zero
> exit code on catch.  The caller's caller passes the exit code to
> sys.exit().  Leaving the sys.exit() to the callers is cleaner.
>
> However, you convert only two out of five error paths from sys.exit() to
> raise.  All or nothing, please.
>

"RFC Quality" ;)

You got it, I'll be consistent in approach here. My initial goal was only
to get the linters clean for this series.


> Maybe split the patch into a "# pylint:" and a "raise QAPIError" part?
>

Sure.

>

--000000000000f4ae6e062f9a1582
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Mar 5, 2025, 1:28=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">John Snow &l=
t;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Shhhhh!<br>
&gt;<br>
&gt; This patch is RFC quality, I wasn&#39;t in the mood to actually solve<=
br>
&gt; problems so much as I was in the mood to continue working on the Sphin=
x<br>
&gt; rework. Plus, I don&#39;t think the code I am patching has hit origin/=
master<br>
&gt; yet ...<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 scripts/qapi/backend.py |=C2=A0 2 ++<br>
&gt;=C2=A0 scripts/qapi/main.py=C2=A0 =C2=A0 | 10 ++++------<br>
&gt;=C2=A0 2 files changed, 6 insertions(+), 6 deletions(-)<br>
&gt;<br>
&gt; diff --git a/scripts/qapi/backend.py b/scripts/qapi/backend.py<br>
&gt; index 14e60aa67af..49ae6ecdd33 100644<br>
&gt; --- a/scripts/qapi/backend.py<br>
&gt; +++ b/scripts/qapi/backend.py<br>
&gt; @@ -13,6 +13,7 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt;=C2=A0 class QAPIBackend(ABC):<br>
&gt; +=C2=A0 =C2=A0 # pylint: disable=3Dtoo-few-public-methods<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 @abstractmethod<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def generate(self,<br>
&gt; @@ -36,6 +37,7 @@ def generate(self,<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt;=C2=A0 class QAPICBackend(QAPIBackend):<br>
&gt; +=C2=A0 =C2=A0 # pylint: disable=3Dtoo-few-public-methods<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def generate(self,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sc=
hema: QAPISchema,<br>
<br>
I didn&#39;t bother to ask for these in my review.=C2=A0 Do they get us to =
the<br>
point where we can enable automatic pylint?<br></blockquote></div></div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">Yes.</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">
<br>
&gt; diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py<br>
&gt; index ff42b43cd68..01155373bd0 100644<br>
&gt; --- a/scripts/qapi/main.py<br>
&gt; +++ b/scripts/qapi/main.py<br>
&gt; @@ -31,15 +31,14 @@ def create_backend(path: str) -&gt; QAPIBackend:<b=
r>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 module_path, dot, class_name =3D path.rpartition(&=
#39;.&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if not dot:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(f&quot;argument of -B must be of th=
e form MODULE.CLASS&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;argument of -B must be of the=
 form MODULE.CLASS&quot;,<br>
<br>
This one&#39;s already in &quot;[PULL v2 0/5] QAPI patches patches for<br>
2025-02-26&quot;.=C2=A0 No worries.<br></blockquote></div></div><div dir=3D=
"auto"><br></div><div dir=3D"auto">Got it. I&#39;ll repull your tags.</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gma=
il_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 file=3Dsys.stde=
rr)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(1)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 try:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mod =3D import_module(module_path)<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 except Exception as ex:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(f&quot;unable to import &#39;{modul=
e_path}&#39;: {ex}&quot;, file=3Dsys.stderr)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(1)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise QAPIError(f&quot;unable to import &=
#39;{module_path}&#39;: {ex}&quot;) from ex<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 try:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 klass =3D getattr(mod, class_name)<b=
r>
&gt; @@ -51,9 +50,8 @@ def create_backend(path: str) -&gt; QAPIBackend:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 try:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 backend =3D klass()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 except Exception as ex:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(f&quot;backend &#39;{path}&#39; can=
not be instantiated: {ex}&quot;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 file=3Dsys.stderr)<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(1)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise QAPIError(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 f&quot;backend &#39;{path}&=
#39; cannot be instantiated: {ex}&quot;) from ex<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 if not isinstance(backend, QAPIBackend):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(f&quot;backend &#39;{path}&#39=
; must be an instance of QAPIBackend&quot;,<br>
<br>
Missed in my review: the caller catches QAPIError, and returns non-zero<br>
exit code on catch.=C2=A0 The caller&#39;s caller passes the exit code to<b=
r>
sys.exit().=C2=A0 Leaving the sys.exit() to the callers is cleaner.<br>
<br>
However, you convert only two out of five error paths from sys.exit() to<br=
>
raise.=C2=A0 All or nothing, please.<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">&quot;RFC Quality&quot; ;)</div><div =
dir=3D"auto"><br></div><div dir=3D"auto">You got it, I&#39;ll be consistent=
 in approach here. My initial goal was only to get the linters clean for th=
is series.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D=
"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Maybe split the patch into a &quot;# pylint:&quot; and a &quot;raise QAPIEr=
ror&quot; part?<br></blockquote></div></div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">Sure.</div><div dir=3D"auto"><div class=3D"gmail_quote gmail=
_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000f4ae6e062f9a1582--


