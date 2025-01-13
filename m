Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 445A8C02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 19:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXPsB-0007TL-6T; Mon, 13 Jan 2025 14:13:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tXPs8-0007Su-Ef
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:13:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tXPs6-0002Co-Lt
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:13:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736795588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QMJvCrgu0xyZTKBIm0RZI26EF6nFVdw3UYvxvvK/c0g=;
 b=dzSKJaQUEr9mqI+wVwWO5oYHSfcCUQL5/N30Abso6m6sXCpm8DW76tpv3nPpXV4aSVAw98
 8lfrL85vE0raj9U3RFqUG1gmiH3lMZdV6Mtqi7NjRO0jVr3LeqMx0R/NCqOMSggjR6mR72
 fRtzBBQj28d+shI6qJV7bJAG9PEEIUI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-p8Om_tqrOquhWN49r8oxVg-1; Mon, 13 Jan 2025 14:13:06 -0500
X-MC-Unique: p8Om_tqrOquhWN49r8oxVg-1
X-Mimecast-MFC-AGG-ID: p8Om_tqrOquhWN49r8oxVg
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ef35de8901so8031140a91.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 11:13:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736795585; x=1737400385;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QMJvCrgu0xyZTKBIm0RZI26EF6nFVdw3UYvxvvK/c0g=;
 b=lTxWhS+sGMs4uuF0sDh0vdYJtvjbSAIoy/nWNO4MbmN6DzVPIUIupPgEadBzfSKtnd
 6KOWMph6klU95I8epmulydvYyOvQjriJKmOsIhIVIYYar/RGkxY8TtbJjJx8yXybeB1a
 PYQ9VgXfOQPad5S4Ck4xXWKzkWv1z1huZlm2M9E+142NKu6oqppOjtr4GjaEx9MWYQi5
 bmDYO7vJN0SfheL3v5V+3uS07U9jZbaBo3Mb2SbUJ+C0CsSHZ7xM/BDDqZPf5gQRZpSO
 WKsXd7shCxLddI2Ryhewfe7yimseJXiZJ8xk2DHLA5p/o69sCbOdqZcehUlEC5dOyFfH
 N5iQ==
X-Gm-Message-State: AOJu0YwFAAJI2rN/ZU3sPjj8UHDFV0AYis00Xp4eNqXOb6YP3tPrtfgk
 YbqnBV2dAxCXBQWVmqmMt/ruS+wFZViinIQEw3NMMA7pC76fYz6aZg0wVPSD/Wds8PaqX0g8dNP
 rTunVjlT18cPjKFKfYuPMiUkYjhhBJjGhdEi8f1vTZGLBnezne+ojboxpBMkDqkI2f/WLxfPYmG
 pZh7XarvJ1I1aBJV42ivD99smuUJM=
X-Gm-Gg: ASbGncs/5DkOOurWfLI7Oh52dDSmSPVzYVGnu7uARa9UN9el8aFbafxlSzdFLUb1JzY
 oZS4gYaaQpLbL5COiXg3GLLwoD7C8LMGi7F8uLd5N4smM+d/czcyHyyKtDiWJltkbh1RCRQ==
X-Received: by 2002:a17:90b:534b:b0:2f1:2fa5:1924 with SMTP id
 98e67ed59e1d1-2f548f44ea9mr26639978a91.26.1736795585395; 
 Mon, 13 Jan 2025 11:13:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwus/FqUIoQnWNE5ggMuQjfr4OHpIsZ0qreOW18L1QbSv+VE+CB0T6gyoRYuMEKSCTtu3FYvPwPXgDvcX0meA=
X-Received: by 2002:a17:90b:534b:b0:2f1:2fa5:1924 with SMTP id
 98e67ed59e1d1-2f548f44ea9mr26639949a91.26.1736795584976; Mon, 13 Jan 2025
 11:13:04 -0800 (PST)
MIME-Version: 1.0
References: <20241213021827.2956769-1-jsnow@redhat.com>
 <20241213021827.2956769-2-jsnow@redhat.com>
 <877c7zdb1h.fsf@pond.sub.org>
In-Reply-To: <877c7zdb1h.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 13 Jan 2025 14:12:53 -0500
X-Gm-Features: AbW1kvbwW-Vd2H-1kUPfLEailZugazM2inebWeeKMbk9JObfE3YGjd7e7AjoSW0
Message-ID: <CAFn=p-bYFhOh1iuij_AXAZ3s3k5FY8cVwAMiQ-FNCn8Du-kduA@mail.gmail.com>
Subject: Re: [PATCH 01/23] docs/qapidoc: support header-less freeform sections
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000e3f17e062b9b3bd3"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.019,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

--000000000000e3f17e062b9b3bd3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 8:15=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > The code as written can't handle if a header isn't found, because `node=
`
> > will be uninitialized.
>
> Yes, we initialize @node only if we have a heading.
>
> Made me wonder what happens when we don't.  So I deleted the =3D from the
> "# =3D Subsection" line in doc-good.json, and got:
>
>     Exception occurred:
>       File "/work/armbru/qemu/docs/sphinx/qapidoc.py", line 425, in
> freeform
>         self._parse_text_into_node(text, node)
>                                          ^^^^
>     UnboundLocalError: cannot access local variable 'node' where it is no=
t
> associated with a value
>
> So you're fixing a crash bug, but that's perhaps less than clear from
> the commit message.
>
> >                        If we don't have a section title, create a
> > generic block to insert text into instead.
> >
> > This patch removes a lingering pylint warning in the QAPIDoc
> implementation
>
> Can you show me the warning?  My pylint doesn't...
>
> > that prevents getting a clean baseline to use for forthcoming
> > additions.
> >
> > I am not attempting to *fully* clean up the existing QAPIDoc
> > implementation in pylint because I intend to delete it anyway; this
> > patch merely accomplishes a baseline under a specific pylint
> > configuration:
> >
> > PYTHONPATH=3D../../scripts/ pylint --disable=3Dfixme,too-many-lines,\
> >     consider-using-f-string,missing-docstring,unused-argument,\
> >     too-many-arguments,too-many-positional-arguments,\
> >     too-many-public-methods \
> >     qapidoc.py
>
> What version of pylint?  Mine chokes on too-many-positional-arguments.
>

3.3.1 here; if yours doesn't have that warning, there's no need to disable
it. just remove that flag from the CLI.

(I promise I do want to get this rigorously checked and automated, I'm
sorry it's taken so long to achieve.)


>
> > This at least ensures there aren't regressions outside of these general
> > warnings in the new qapidoc.py code to be committed.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/qapidoc.py | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> > index 5f96b46270b..5a4d7388b29 100644
> > --- a/docs/sphinx/qapidoc.py
> > +++ b/docs/sphinx/qapidoc.py
> > @@ -421,6 +421,8 @@ def freeform(self, doc):
> >              node =3D self._start_new_heading(heading, len(leader))
> >              if text =3D=3D '':
> >                  return
> > +        else:
> > +            node =3D nodes.container()
> >
> >          self._parse_text_into_node(text, node)
> >          self._cur_doc =3D None
>
> Plausible enough (and I acked a similar fix previously, commit
> 2664f3176a8), but I'm a Sphinx ignoramus :)
>
>

--000000000000e3f17e062b9b3bd3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Dec 16,=
 2024 at 8:15=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; The code as written can&#39;t handle if a header isn&#39;t found, beca=
use `node`<br>
&gt; will be uninitialized.<br>
<br>
Yes, we initialize @node only if we have a heading.<br>
<br>
Made me wonder what happens when we don&#39;t.=C2=A0 So I deleted the =3D f=
rom the<br>
&quot;# =3D Subsection&quot; line in doc-good.json, and got:<br>
<br>
=C2=A0 =C2=A0 Exception occurred:<br>
=C2=A0 =C2=A0 =C2=A0 File &quot;/work/armbru/qemu/docs/sphinx/qapidoc.py&qu=
ot;, line 425, in freeform<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._parse_text_into_node(text, node)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^^=
^^<br>
=C2=A0 =C2=A0 UnboundLocalError: cannot access local variable &#39;node&#39=
; where it is not associated with a value<br>
<br>
So you&#39;re fixing a crash bug, but that&#39;s perhaps less than clear fr=
om<br>
the commit message.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 If we don&#39;t have a section title, create a<br>
&gt; generic block to insert text into instead.<br>
&gt;<br>
&gt; This patch removes a lingering pylint warning in the QAPIDoc implement=
ation<br>
<br>
Can you show me the warning?=C2=A0 My pylint doesn&#39;t...<br>
<br>
&gt; that prevents getting a clean baseline to use for forthcoming<br>
&gt; additions.<br>
&gt;<br>
&gt; I am not attempting to *fully* clean up the existing QAPIDoc<br>
&gt; implementation in pylint because I intend to delete it anyway; this<br=
>
&gt; patch merely accomplishes a baseline under a specific pylint<br>
&gt; configuration:<br>
&gt;<br>
&gt; PYTHONPATH=3D../../scripts/ pylint --disable=3Dfixme,too-many-lines,\<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0consider-using-f-string,missing-docstring,unused-ar=
gument,\<br>
&gt;=C2=A0 =C2=A0 =C2=A0too-many-arguments,too-many-positional-arguments,\<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0too-many-public-methods \<br>
&gt;=C2=A0 =C2=A0 =C2=A0qapidoc.py<br>
<br>
What version of pylint?=C2=A0 Mine chokes on too-many-positional-arguments.=
<br></blockquote><div><br></div><div>3.3.1 here; if yours doesn&#39;t have =
that warning, there&#39;s no need to disable it. just remove that flag from=
 the CLI.</div><div><br></div><div>(I promise I do want to get this rigorou=
sly checked and automated, I&#39;m sorry it&#39;s taken so long to achieve.=
)<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
<br>
&gt; This at least ensures there aren&#39;t regressions outside of these ge=
neral<br>
&gt; warnings in the new qapidoc.py code to be committed.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/sphinx/qapidoc.py | 2 ++<br>
&gt;=C2=A0 1 file changed, 2 insertions(+)<br>
&gt;<br>
&gt; diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py<br>
&gt; index 5f96b46270b..5a4d7388b29 100644<br>
&gt; --- a/docs/sphinx/qapidoc.py<br>
&gt; +++ b/docs/sphinx/qapidoc.py<br>
&gt; @@ -421,6 +421,8 @@ def freeform(self, doc):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 node =3D self._start_n=
ew_heading(heading, len(leader))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if text =3D=3D &#39;&#=
39;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 node =3D nodes.container()<=
br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._parse_text_into_node(text, nod=
e)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._cur_doc =3D None<br>
<br>
Plausible enough (and I acked a similar fix previously, commit<br>
2664f3176a8), but I&#39;m a Sphinx ignoramus :)<br>
<br>
</blockquote></div></div>

--000000000000e3f17e062b9b3bd3--


