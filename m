Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9079DC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 12:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOyla-0002YF-53; Wed, 03 Jul 2024 08:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sOylU-0002Xl-A9
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 08:07:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sOylS-0004ht-BK
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 08:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720008428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zVNMzmuXBMUs9dqMhokM9NjUSV+1TJa07XXZk6gqM1w=;
 b=dxHNXZOjLXoDn+qVzhMqwLI1hgkAqhM3ZS8mXan9A7pEoDR99GyRdXbSppivOtDm0W+y6B
 4n7NejI9NWYRWcsmn7JnOHyAahZEdlJGg9VxdWoUU20d+2EKsX/g0Xh3zr4sjPDd6E2r/i
 MNE0EOLZ31boT6UpPZD6UjsYAZJawPk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-KpnsXxnrMumHVa7XjidFaw-1; Wed, 03 Jul 2024 08:06:37 -0400
X-MC-Unique: KpnsXxnrMumHVa7XjidFaw-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2c933e2426cso3465336a91.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 05:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720008396; x=1720613196;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zVNMzmuXBMUs9dqMhokM9NjUSV+1TJa07XXZk6gqM1w=;
 b=s0RAJhupEjnbib3FufpwPSf3mw1XC1ff7cI87NwyBvK7e0PGFOLQgkSw+ZbGhZPaok
 jqgih28fFKp+nN0O0RyMO3CyLG4oc1L84GHD47tr4H0g+haCnWvWX1161/H/5lVqhw4p
 fKQLJqQQJ9dJp7mZSwFJsclHj5BiRSyLUrfwvxvbVGhYJXvG6taHBdtYggYSh5Dk2EcU
 6N5g3GNybEJxlV9gw3HB9PmtldapiOiaabJ1k/XUlhOXxodQTtir4ceBLFNQkJDUEyjP
 G0SFRO+UieAmWXvOHP5AO+6cU5qCy6AXEln3FP6I0U6rV+/4KsEqnO2kiulnitGekSUl
 2Afg==
X-Gm-Message-State: AOJu0YxyCtZUOwWAI95dIS1SbBD60IkT667+8ezBcFhgW6EOFQtUffYL
 sweEY4LTTTmRbiFA7qFobtIl6Ziynw9WTO0yb9CQ5Kmi70YjXnG23lFypvLV4qIMHeVB6mW1KEC
 h608QVNhOsE5SZCEBY7BiAtnn7i1WeaDg0N/DJCFtInKh4GWE+61hGUHOdRw3LI8ax8BOqnR6Na
 GycqjQX6F3p2MUiWGeb8pvJey7gpI=
X-Received: by 2002:a17:90a:e17:b0:2c9:3340:621d with SMTP id
 98e67ed59e1d1-2c93d771efemr7048634a91.37.1720008396055; 
 Wed, 03 Jul 2024 05:06:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVrrGmKg6PIJt3666kwH3SUCmxv7yJZrbBulruyvXEQYKtPvIjJ7dPudPJwzNtlgSfc02lhspoEahTrn5wTlQ=
X-Received: by 2002:a17:90a:e17:b0:2c9:3340:621d with SMTP id
 98e67ed59e1d1-2c93d771efemr7048612a91.37.1720008395436; Wed, 03 Jul 2024
 05:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240702195903.204007-1-jsnow@redhat.com>
 <20240702195903.204007-2-jsnow@redhat.com>
 <e0302039-dade-43a7-8bdb-a96d1df76f38@redhat.com>
In-Reply-To: <e0302039-dade-43a7-8bdb-a96d1df76f38@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 3 Jul 2024 08:06:23 -0400
Message-ID: <CAFn=p-Yqi5umFBPtUYj2EFiRRA2E6VTgDi=TbuwoOSTs+s9OoA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Python: bump minimum sphinx version to 3.4.3
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="0000000000006bd447061c56a90b"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--0000000000006bd447061c56a90b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024, 4:00=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com> wr=
ote:

> On 7/2/24 21:59, John Snow wrote:
> > With RHEL 8 support retired (It's been two years today since RHEL 9
> > came out), our very oldest build platform version of Sphinx is now
> > 3.4.3; and keeping backwards compatibility for versions as old as v1.6
> > when using domain extensions is a lot of work we don't need to do.
>
> Technically that's unrelated: thanks to your venv work, :) builds on
> RHEL 8 / CentOS Stream 8 do not pick the platform Sphinx, because it
> runs under Python 3.6.  Therefore the version included in RHEL 8 does
> not matter for picking the minimum supported Sphinx version.
>

...!

I think I can't mandate 4.x because of RHEL 9 builds though, and offline
requirements.


> > Debian 11: v3.4.3 (QEMU support ends 2024-07-xx)
>
> Nice. :)
>
> > diff --git a/pythondeps.toml b/pythondeps.toml
> > index 9c16602d303..bc656376caa 100644
> > --- a/pythondeps.toml
> > +++ b/pythondeps.toml
> > @@ -23,7 +23,7 @@ meson =3D { accepted =3D ">=3D0.63.0", installed =3D =
"1.2.3",
> canary =3D "meson" }
> >
> >   [docs]
> >   # Please keep the installed versions in sync with docs/requirements.t=
xt
> > -sphinx =3D { accepted =3D ">=3D1.6", installed =3D "5.3.0", canary =3D
> "sphinx-build" }
> > +sphinx =3D { accepted =3D ">=3D3.4.3", installed =3D "5.3.0", canary =
=3D
> "sphinx-build" }
> >   sphinx_rtd_theme =3D { accepted =3D ">=3D0.5", installed =3D "1.1.1" =
}
> >
> >   [avocado]
>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>
> Paolo
>
>

--0000000000006bd447061c56a90b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Jul 3, 2024, 4:00=E2=80=AFAM Paolo Bonzini &lt=
;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">On 7/2/24 21:59, John Snow wrote:<b=
r>
&gt; With RHEL 8 support retired (It&#39;s been two years today since RHEL =
9<br>
&gt; came out), our very oldest build platform version of Sphinx is now<br>
&gt; 3.4.3; and keeping backwards compatibility for versions as old as v1.6=
<br>
&gt; when using domain extensions is a lot of work we don&#39;t need to do.=
<br>
<br>
Technically that&#39;s unrelated: thanks to your venv work, :) builds on <b=
r>
RHEL 8 / CentOS Stream 8 do not pick the platform Sphinx, because it <br>
runs under Python 3.6.=C2=A0 Therefore the version included in RHEL 8 does =
<br>
not matter for picking the minimum supported Sphinx version.<br></blockquot=
e></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">...!</div><div =
dir=3D"auto"><br></div><div dir=3D"auto">I think I can&#39;t mandate 4.x be=
cause of RHEL 9 builds though, and offline requirements.</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">
<br>
&gt; Debian 11: v3.4.3 (QEMU support ends 2024-07-xx)<br>
<br>
Nice. :)<br>
<br>
&gt; diff --git a/pythondeps.toml b/pythondeps.toml<br>
&gt; index 9c16602d303..bc656376caa 100644<br>
&gt; --- a/pythondeps.toml<br>
&gt; +++ b/pythondeps.toml<br>
&gt; @@ -23,7 +23,7 @@ meson =3D { accepted =3D &quot;&gt;=3D0.63.0&quot;, =
installed =3D &quot;1.2.3&quot;, canary =3D &quot;meson&quot; }<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0[docs]<br>
&gt;=C2=A0 =C2=A0# Please keep the installed versions in sync with docs/req=
uirements.txt<br>
&gt; -sphinx =3D { accepted =3D &quot;&gt;=3D1.6&quot;, installed =3D &quot=
;5.3.0&quot;, canary =3D &quot;sphinx-build&quot; }<br>
&gt; +sphinx =3D { accepted =3D &quot;&gt;=3D3.4.3&quot;, installed =3D &qu=
ot;5.3.0&quot;, canary =3D &quot;sphinx-build&quot; }<br>
&gt;=C2=A0 =C2=A0sphinx_rtd_theme =3D { accepted =3D &quot;&gt;=3D0.5&quot;=
, installed =3D &quot;1.1.1&quot; }<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0[avocado]<br>
<br>
Acked-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=
=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
<br>
Paolo<br>
<br>
</blockquote></div></div></div>

--0000000000006bd447061c56a90b--


