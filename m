Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF51C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 21:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trklQ-000071-6u; Mon, 10 Mar 2025 17:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trklO-00006N-1i
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 17:34:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trklM-0001WG-3q
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 17:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741642454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dIAe7DAjUF7MlFUMhllXlNnSaQLD9yELqnoEd2ylTek=;
 b=PR3/FRcfdQK3fFAmcaay8ss9evL+Q3CBRq5Dg32bsn7uzv56CqBSdI8AFg8ZfDMmiQTHpW
 meEV7j1W8e8XXJjAN3ojZVv8UNPvsJAHq1dV+JsnV+i1BP5oAS+BE/Hb0JYdNMVJ3XMXto
 Hr1ZFJkxc6IOGkXqwlkqs8xMmlQJMuc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-kMbXPHmPMRWdg3Ey-V9pcg-1; Mon, 10 Mar 2025 17:34:12 -0400
X-MC-Unique: kMbXPHmPMRWdg3Ey-V9pcg-1
X-Mimecast-MFC-AGG-ID: kMbXPHmPMRWdg3Ey-V9pcg_1741642451
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ff52e1c56fso13722423a91.2
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 14:34:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741642451; x=1742247251;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dIAe7DAjUF7MlFUMhllXlNnSaQLD9yELqnoEd2ylTek=;
 b=Xbp4Ri4xlTyFLVTQVt5pGnsVAYjgZ3qPwS9oMLcX1mifYsOyxJWL/75O1KQtMwPJZ2
 tIVuG6UMEhRWrgPJAGZq/nAjOLALlly2R5rAJDKgsKAdImvXrDmp7rXrg3ZRmsAZarOG
 Z9PA0wK2X5Dwf/Cz/zkqHUdEs01vNd/6Ce+fSru+bWHRESSBVqcsUKpwQgWDaPUYeQmA
 oApTQ0/GJQPrVncr2UDljoJB/qPk1K+pS69bQ5USYgAlmc9y0Oij4hcelmrxgZkfgkq8
 5vY0Sk3vYKqwfJwCG3JYFX3pwNqjJb2TlO/Bj6u+cO0eq0ajw32ekzHi2UiObp1THLk6
 zT/A==
X-Gm-Message-State: AOJu0YxuKr+HsnftE20ga7ocrm1NYG7tEAJBpiKFwkh+Eg494dYszdB1
 pOmgOpC3CwdN8LMlSv850ZVCNbSuY0puXRfwKBLTMmCsThSI2bXi6KxeaH7ATLKHNlre2Qx9OXA
 ZrZnMdeNmuo3ejZcR+13LVVVa00akIY9JZxh2qho8Sokv8yLikz30kzFy5drNhUYcCykXOeg5RU
 CDH2tjJgXMvXN9ZM9s/FyiarvO5LA=
X-Gm-Gg: ASbGncvuU+uGvL65lgx3nf/l3l8KekWITrgWgK2FnEuDTgeDYX34Wt9umXeks/fYVKg
 NbNqOySfsqkvD3bHhwRJ8sja2NxI4uLLMakWNvHHzTNH44cyjfv9GLqaZxqnAJFyFi+MvsG/Keg
 mu0JV7VCGoqBL8/PRyjQKjTtwJoa3h
X-Received: by 2002:a17:90b:2f8f:b0:2ea:7cd5:4ad6 with SMTP id
 98e67ed59e1d1-2ff7cf4dde5mr20635397a91.32.1741642451328; 
 Mon, 10 Mar 2025 14:34:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgPR6/Y75NN+yTpaw1dqH8KDK5urPfQkW7ipUcpl81B/hIWl/G9Dhq7Y232ZLdODr/y8vgha5qME2cKs4cg1Q=
X-Received: by 2002:a17:90b:2f8f:b0:2ea:7cd5:4ad6 with SMTP id
 98e67ed59e1d1-2ff7cf4dde5mr20635380a91.32.1741642451008; Mon, 10 Mar 2025
 14:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250309083550.5155-1-jsnow@redhat.com>
 <20250309083550.5155-62-jsnow@redhat.com>
 <878qpdykjs.fsf@pond.sub.org>
In-Reply-To: <878qpdykjs.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 10 Mar 2025 17:33:58 -0400
X-Gm-Features: AQ5f1Jo0q4TT87pC2tE_JCHwehBtuczD9vbZ5VNqFaY2Aaa0K1WAwRyP21Pl0y0
Message-ID: <CAFn=p-Ztdt=-hWJX5OCub7-E4idNrv1QjBSSaO2+R7eH3zYihA@mail.gmail.com>
Subject: Re: [PATCH v2 61/62] docs: enable qapidoc transmogrifier for QEMU QMP
 Reference
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000009e59b5063003bb5c"
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

--0000000000009e59b5063003bb5c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 5:13=E2=80=AFPM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > We are not enabling the transmogrifier for QSD or QGA yet because we
> > don't (yet) have a way to create separate indices, and all of the
> > definitions will bleed together, which isn't so nice.
> >
> > For now, QMP is better than nothing at all!
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/interop/qemu-qmp-ref.rst | 1 +
> >  qapi/qapi-schema.json         | 2 ++
> >  2 files changed, 3 insertions(+)
> >
> > diff --git a/docs/interop/qemu-qmp-ref.rst
> b/docs/interop/qemu-qmp-ref.rst
> > index f94614a0b2f..e95eeac45e2 100644
> > --- a/docs/interop/qemu-qmp-ref.rst
> > +++ b/docs/interop/qemu-qmp-ref.rst
> > @@ -7,3 +7,4 @@ QEMU QMP Reference Manual
> >     :depth: 3
> >
> >  .. qapi-doc:: qapi/qapi-schema.json
> > +   :transmogrify:
> > diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> > index 2877aff73d0..4475e81cc3e 100644
> > --- a/qapi/qapi-schema.json
> > +++ b/qapi/qapi-schema.json
> > @@ -5,6 +5,8 @@
> >  #
> >  # This document describes all commands currently supported by QMP.
> >  #
> > +# For locating a particular item, please see the `qapi-index`.
> > +#
>
> ```qapi-index``` becomes a link in HTML.  The link takes me to an index
> page.  Two observations:
>
> * The index page appears not to be linked from the navigation thingie on
>   the left.  Searching for "QAPI Index" there doesn't find it, either.
>

We'll have to find a way to add it, and where. I don't actually know how
right away. We can discuss this on the namespace patches.


>
> * The index is structured into sections titled Alternates, Commands |
>   Enums, Events, Modules, Objects, A, ... Z.  As I scrolled down
>   quickly, the transition from Objects to A confused me briefly: I
>   didn't immediately understand that A, ... Z contains the union of
>   everything above sorted into letter buckets.
>

Yes, it's weird. I don't have a lot of control over how the index is laid
out, but felt that it was very useful to have both by type (especially to
see commands and events all in one place) and a "classic" alphabetical
reference.

I don't think I can make any meaningful adjustments to this before rc0, I
apologize. Let's revisit soon on the namespace patches, because each
namespace will need its own index and it's a good time to discuss how to
lay them out.


>
> >  # Most of the time their usage is exactly the same as in the user
> >  # Monitor, this means that any other document which also describe
> >  # commands (the manpage, QEMU's manual, etc) can and should be
>
>

--0000000000009e59b5063003bb5c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Mar 9, =
2025 at 5:13=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:armbru@redh=
at.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" =
target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; We are not enabling the transmogrifier for QSD or QGA yet because we<b=
r>
&gt; don&#39;t (yet) have a way to create separate indices, and all of the<=
br>
&gt; definitions will bleed together, which isn&#39;t so nice.<br>
&gt;<br>
&gt; For now, QMP is better than nothing at all!<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/interop/qemu-qmp-ref.rst | 1 +<br>
&gt;=C2=A0 qapi/qapi-schema.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 ++<br=
>
&gt;=C2=A0 2 files changed, 3 insertions(+)<br>
&gt;<br>
&gt; diff --git a/docs/interop/qemu-qmp-ref.rst b/docs/interop/qemu-qmp-ref=
.rst<br>
&gt; index f94614a0b2f..e95eeac45e2 100644<br>
&gt; --- a/docs/interop/qemu-qmp-ref.rst<br>
&gt; +++ b/docs/interop/qemu-qmp-ref.rst<br>
&gt; @@ -7,3 +7,4 @@ QEMU QMP Reference Manual<br>
&gt;=C2=A0 =C2=A0 =C2=A0:depth: 3<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 .. qapi-doc:: qapi/qapi-schema.json<br>
&gt; +=C2=A0 =C2=A0:transmogrify:<br>
&gt; diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json<br>
&gt; index 2877aff73d0..4475e81cc3e 100644<br>
&gt; --- a/qapi/qapi-schema.json<br>
&gt; +++ b/qapi/qapi-schema.json<br>
&gt; @@ -5,6 +5,8 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # This document describes all commands currently supported by QM=
P.<br>
&gt;=C2=A0 #<br>
&gt; +# For locating a particular item, please see the `qapi-index`.<br>
&gt; +#<br>
<br>
```qapi-index``` becomes a link in HTML.=C2=A0 The link takes me to an inde=
x<br>
page.=C2=A0 Two observations:<br>
<br>
* The index page appears not to be linked from the navigation thingie on<br=
>
=C2=A0 the left.=C2=A0 Searching for &quot;QAPI Index&quot; there doesn&#39=
;t find it, either.<br></blockquote><div><br></div><div>We&#39;ll have to f=
ind a way to add it, and where. I don&#39;t actually know how right away. W=
e can discuss this on the namespace patches.</div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
<br>
* The index is structured into sections titled Alternates, Commands |<br>
=C2=A0 Enums, Events, Modules, Objects, A, ... Z.=C2=A0 As I scrolled down<=
br>
=C2=A0 quickly, the transition from Objects to A confused me briefly: I<br>
=C2=A0 didn&#39;t immediately understand that A, ... Z contains the union o=
f<br>
=C2=A0 everything above sorted into letter buckets.<br></blockquote><div><b=
r></div><div>Yes, it&#39;s weird. I don&#39;t have a lot of control over ho=
w the index is laid out, but felt that it was very useful to have both by t=
ype (especially to see commands and events all in one place) and a &quot;cl=
assic&quot; alphabetical reference.</div><div><br></div><div>I don&#39;t th=
ink I can make any meaningful adjustments to this before rc0, I apologize. =
Let&#39;s revisit soon on the namespace patches, because each namespace wil=
l need its own index and it&#39;s a good time to discuss how to lay them ou=
t.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 # Most of the time their usage is exactly the same as in the use=
r<br>
&gt;=C2=A0 # Monitor, this means that any other document which also describ=
e<br>
&gt;=C2=A0 # commands (the manpage, QEMU&#39;s manual, etc) can and should =
be<br>
<br>
</blockquote></div></div>

--0000000000009e59b5063003bb5c--


