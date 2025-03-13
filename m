Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F03FC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 13:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsj2q-0001Ls-Sq; Thu, 13 Mar 2025 09:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tsj2o-0001LX-Nn
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 09:56:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tsj2m-0004Sj-UC
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 09:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741874174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IDXklaR3EASvvRwzt7OYn1rc0kL4KQT1UBhPNARKwEY=;
 b=YyCapz6pQ4QD2xtSQihAWRcCX6QOjjOabdKsKRIrcSt+BHZxv7i5TEJtI1KCLBmcwkVDff
 TyOILCXc3bO0CbW6xWhgkqJs4FRO3eEKF6YJaXYx0p2g0+Tcux1ppTgGMM1vY9Trg9vRja
 XBDqNG7awb3AaYbcE0b1Ybn13qzJ8Q8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-mfNmSSl4NMWGX9wGlh9KNA-1; Thu, 13 Mar 2025 09:56:13 -0400
X-MC-Unique: mfNmSSl4NMWGX9wGlh9KNA-1
X-Mimecast-MFC-AGG-ID: mfNmSSl4NMWGX9wGlh9KNA_1741874173
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-225ab228a37so14748795ad.2
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 06:56:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741874172; x=1742478972;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IDXklaR3EASvvRwzt7OYn1rc0kL4KQT1UBhPNARKwEY=;
 b=LuPs2HPZ3SRO88njClbfgnh4DlYO0mnvEWQ5FvuYDI7pzOMQX9E8cZ8kwUi8i4jwIV
 ruvb1kxa/CH7iWrWVh54KX1eR69hCHgr5tdkR0oXjOLZEWJE8mxzemp5g0ef9/edYLCo
 Ki1VzfEVePy9CZah0+qeG2ezKOUWQ5OZHy45pxHE22DrML3Dve3Vc21uqnYUROJkJQ6o
 /AkRV/w75qADtUZLTUvOVO4UK2iOa05CSRuQYiBbc+2omCL78KIVhVzGu3RP9HT0Ydii
 dZxbypKmc8t5flrh2ZtDIp3tN/G8dpW6HTjyEgwFNY42Yh+C8EJINkBnh5/nzmIwqE+x
 yh3Q==
X-Gm-Message-State: AOJu0YwOOe8X2/mAoZ6f5RkF1IjWatIsqdBOpWd26AX8wuEQxDMtvbV9
 82vPuD7iva8a6eUDowy8VP5s97E7icyBImQFfK7TrQbn4l2xJbq/OEieVrDJMKBdsOP/rTfTLqy
 3JJy5pwWBxzCsTupUGjY+WC+yLpA8ilqFpuu4w3PGkfNMBR9nJ+gAh9++QZZWiskQHW1sbnrJLa
 ZM60DxHxXdUuS8WYWGR8cGoijoy3gzkHH3dAw=
X-Gm-Gg: ASbGnctX6aecw9bo36NULGz15FJonY1hQ2D84Fflzybo9ezIlLboLbawU+p5xXvqZL+
 Faxd0mlpRlL8ZHPK05qAGnqHbYVoRnz9alerVr1/uO9n3l/S46AB9WUi1G0G7o2rbHyXaloZzAj
 yt+bpAqA6h001+YrTjbyLvVSBMzPDG
X-Received: by 2002:a17:903:1c8:b0:224:6a7:a5b0 with SMTP id
 d9443c01a7336-22592e20143mr169599765ad.2.1741874171993; 
 Thu, 13 Mar 2025 06:56:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdCnc6mUM8QV1ERQJtJKiTb/J6bhtPnK2qKAIk6CpivWEZ9Dri0dJoN3WPF/9z8rKIT+pvbJwk6+vQgZ2f/qo=
X-Received: by 2002:a17:903:1c8:b0:224:6a7:a5b0 with SMTP id
 d9443c01a7336-22592e20143mr169599425ad.2.1741874171598; Thu, 13 Mar 2025
 06:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250313044312.189276-1-jsnow@redhat.com>
 <20250313044312.189276-5-jsnow@redhat.com>
 <87bju5e8o7.fsf@pond.sub.org>
In-Reply-To: <87bju5e8o7.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 13 Mar 2025 09:55:59 -0400
X-Gm-Features: AQ5f1JplqVSCj6ykME4lg3Ssg1IgjPTMHUtJF03PZHe0fOa7YEPT0tgl3G-goVw
Message-ID: <CAFn=p-YzKa_QwGNFQCSGBfHts4ZnoR0c41pkYkVYfVO7jYcDNQ@mail.gmail.com>
Subject: Re: [PATCH 04/11] docs/qapi-domain: add :namespace: override option
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Konstantin Kostiuk <kkostiuk@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, 
 Michael Roth <michael.roth@amd.com>, Kevin Wolf <kwolf@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000003e013e063039af2c"
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

--0000000000003e013e063039af2c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 2:39=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Akin to the :module: override option, the :namespace: options allows yo=
u
> > to forcibly override the contextual namespace associatied with a
> > definition.
> >
> > We don't necessarily actually need this, but I felt compelled to stick
> > close to how the Python domain works that offers context overrides.
> >
> > As of this commit, it is possible to add e.g. ":namespace: QMP" to any
> > QAPI directive to forcibly associate that definition with a given
> > namespace.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/devel/qapi-domain.rst | 2 ++
> >  docs/sphinx/qapi_domain.py | 5 +++--
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/docs/devel/qapi-domain.rst b/docs/devel/qapi-domain.rst
> > index 1475870ca6c..51b283277e1 100644
> > --- a/docs/devel/qapi-domain.rst
> > +++ b/docs/devel/qapi-domain.rst
> > @@ -466,6 +466,8 @@ QAPI standard options
> >
> >  All QAPI directives -- *except* for module -- support these common
> options.
> >
> > +* ``:namespace: name`` -- This option allows you to override the
> > +  namespace association of a given definition.
> >  * ``:module: modname`` -- Borrowed from the Python domain, this option
> allows
> >    you to override the module association of a given definition.
> >  * ``:since: x.y`` -- Allows the documenting of "Since" information,
> which is
> > diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
> > index 48a082d489a..6485c432063 100644
> > --- a/docs/sphinx/qapi_domain.py
> > +++ b/docs/sphinx/qapi_domain.py
> > @@ -294,8 +294,9 @@ class QAPIObject(QAPIDescription):
> >      )
> >      option_spec.update(
> >          {
> > -            # Borrowed from the Python domain:
> > -            "module": directives.unchanged,  # Override contextual
> module name
> > +            # Context overrides:
> > +            "namespace": directives.unchanged,
> > +            "module": directives.unchanged,
> >              # These are QAPI originals:
> >              "since": directives.unchanged,
> >              "ifcond": directives.unchanged,
>
> Did "Borrowed from the Python domain" become wrong(ish) in PATCH 02?
>

:module: is directly borrowed, :namespace: is only spiritually similar.

--0000000000003e013e063039af2c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 13,=
 2025 at 2:39=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Akin to the :module: override option, the :namespace: options allows y=
ou<br>
&gt; to forcibly override the contextual namespace associatied with a<br>
&gt; definition.<br>
&gt;<br>
&gt; We don&#39;t necessarily actually need this, but I felt compelled to s=
tick<br>
&gt; close to how the Python domain works that offers context overrides.<br=
>
&gt;<br>
&gt; As of this commit, it is possible to add e.g. &quot;:namespace: QMP&qu=
ot; to any<br>
&gt; QAPI directive to forcibly associate that definition with a given<br>
&gt; namespace.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/devel/qapi-domain.rst | 2 ++<br>
&gt;=C2=A0 docs/sphinx/qapi_domain.py | 5 +++--<br>
&gt;=C2=A0 2 files changed, 5 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/docs/devel/qapi-domain.rst b/docs/devel/qapi-domain.rst<b=
r>
&gt; index 1475870ca6c..51b283277e1 100644<br>
&gt; --- a/docs/devel/qapi-domain.rst<br>
&gt; +++ b/docs/devel/qapi-domain.rst<br>
&gt; @@ -466,6 +466,8 @@ QAPI standard options<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 All QAPI directives -- *except* for module -- support these comm=
on options.<br>
&gt;=C2=A0 <br>
&gt; +* ``:namespace: name`` -- This option allows you to override the<br>
&gt; +=C2=A0 namespace association of a given definition.<br>
&gt;=C2=A0 * ``:module: modname`` -- Borrowed from the Python domain, this =
option allows<br>
&gt;=C2=A0 =C2=A0 you to override the module association of a given definit=
ion.<br>
&gt;=C2=A0 * ``:since: x.y`` -- Allows the documenting of &quot;Since&quot;=
 information, which is<br>
&gt; diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py<b=
r>
&gt; index 48a082d489a..6485c432063 100644<br>
&gt; --- a/docs/sphinx/qapi_domain.py<br>
&gt; +++ b/docs/sphinx/qapi_domain.py<br>
&gt; @@ -294,8 +294,9 @@ class QAPIObject(QAPIDescription):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 )<br>
&gt;=C2=A0 =C2=A0 =C2=A0 option_spec.update(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Borrowed from the Python =
domain:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;module&quot;: directi=
ves.unchanged,=C2=A0 # Override contextual module name<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Context overrides:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;namespace&quot;: dire=
ctives.unchanged,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;module&quot;: directi=
ves.unchanged,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # These are QAPI origi=
nals:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;since&quot;: dir=
ectives.unchanged,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;ifcond&quot;: di=
rectives.unchanged,<br>
<br>
Did &quot;Borrowed from the Python domain&quot; become wrong(ish) in PATCH =
02?<br></blockquote><div><br></div><div>:module: is directly borrowed, :nam=
espace: is only spiritually similar. <br></div></div></div>

--0000000000003e013e063039af2c--


