Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD3AC021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 22:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkW2p-0003x9-V8; Tue, 18 Feb 2025 17:26:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tkW2o-0003wd-7z
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 17:26:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tkW2m-00028x-3B
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 17:26:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739917579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=157YmXAP8wRXLkn0IndGYu8w1mZgbGkhfBQpDXZjrTs=;
 b=E1Pilw9b6GX0TXXgSV7/sM0I3RCyW7IrYtUF2qgCoC50LVFCwQ7C7UX6ukLiDPzRK1v7b6
 XsIn4ovZKlYEtsNcVuYfN891AODA8ELolXTiwXREAY6y2icWznjw3ESqROSyx9jUs+U7Vq
 hScnd25uTj/TclFPEbEUVZs8Dd6chjY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-fhHJ9w2eMhSGlUXjETbz8w-1; Tue, 18 Feb 2025 17:26:16 -0500
X-MC-Unique: fhHJ9w2eMhSGlUXjETbz8w-1
X-Mimecast-MFC-AGG-ID: fhHJ9w2eMhSGlUXjETbz8w_1739917575
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2fc1c3b3dc7so11019256a91.2
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 14:26:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739917575; x=1740522375;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=157YmXAP8wRXLkn0IndGYu8w1mZgbGkhfBQpDXZjrTs=;
 b=pG6E8pCwEYG+8S7/VzT+ElAkXtyEIekUnG32Cpky/V5Bx6mKepfCxLqb9YdGt2gHwy
 L5EOjMBwytUfeucxifrv0d5jKZuV5UzvVFt7hk8tCBZ4k4E42pZFeoZVJSpgQxBu9Elk
 nFBSO6SIhZHWIoR5m6yMgIzqWd8yMhWIqmddwkWRaW+UWTE1QnCXtK5E7m1Tpnnsytn/
 FOXBXdH4NCryVsc+LRFq+EJMClYXdnP9QcGZGqDsXU1C6G+7jwrBJQt9iXCX+qAZ1Y6q
 hvchxcF77oqv2cJF+ghbaxc16UmSqHv+oOnDJx395tAci1KyFpkXmtIcvHbI7aeVsIHX
 v0qg==
X-Gm-Message-State: AOJu0YypsVQDRP1sS5GXqUfkFHORCTOr2J3Kz7NuGo2sQT1z4F6vWAtT
 Ssaa8JVMo9GgevbCsfbSaMflfBVRuxD9j8a+qRyqt2MJoBsrGl48BuUZ654T7vFuNpKfw5E6rb9
 MSOYv8NiPHGDpZAZT+rgZJ0fukUjZwuNGTwZe7n/Ns7hteZGebQ2BbdgsLN0a0p8xlw6+AWEzxt
 caB8GXEfXrwUMhoqYX1Hc46I5D58E=
X-Gm-Gg: ASbGncuOrr3MZAi2aPnl7D675S/HU0EZ9Ry4j1w9HrFr+whxQpaT6OBeMWsV2jUOVYu
 j7wzeKZsvbGnP03ydqhWpIBi13f1z6m7wVISn2XpurGs+K3HNqFNtotCAm1itT+nicTOqm6lhUo
 KXE1p7qBTgbBUfFzYYrA==
X-Received: by 2002:a17:90b:4c8a:b0:2f1:2fa5:1924 with SMTP id
 98e67ed59e1d1-2fcb5a9d304mr1466748a91.26.1739917575047; 
 Tue, 18 Feb 2025 14:26:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFio0sz/wGDZMh4ZT88dgRYTPYRhaxPmfLDEUZFznwWSI/nU9K2Oe95d1H2HFJoq6VdkuDT2OJ+gLvDbHHG23U=
X-Received: by 2002:a17:90b:4c8a:b0:2f1:2fa5:1924 with SMTP id
 98e67ed59e1d1-2fcb5a9d304mr1466730a91.26.1739917574750; Tue, 18 Feb 2025
 14:26:14 -0800 (PST)
MIME-Version: 1.0
References: <20250205231208.1480762-1-jsnow@redhat.com>
 <20250205231208.1480762-30-jsnow@redhat.com>
 <87seocrdk9.fsf@pond.sub.org>
In-Reply-To: <87seocrdk9.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 18 Feb 2025 17:26:02 -0500
X-Gm-Features: AWEUYZneqy08xcVzA6oKs8R0i9py20I0oCoiuzB39xDwYtXm5KFn9KYrxrUYqac
Message-ID: <CAFn=p-a8=+BZfUjiaQpXU7UbH7_oV5WNdumHqbD8kauf3YqKVQ@mail.gmail.com>
Subject: Re: [PATCH 29/42] qapi: Add "Details:" disambiguation marker
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 Fabiano Rosas <farosas@suse.de>, Zhao Liu <zhao1.liu@intel.com>, 
 Lukas Straub <lukasstraub2@web.de>, Eduardo Habkost <eduardo@habkost.net>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000fb5984062e722013"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
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

--000000000000fb5984062e722013
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 6:55=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This clarifies sections that are mistaken by the parser as "intro"
> > sections to be "details" sections instead.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  qapi/machine.json      | 2 ++
> >  qapi/migration.json    | 4 ++++
> >  qapi/qom.json          | 4 ++++
> >  qapi/yank.json         | 2 ++
> >  scripts/qapi/parser.py | 8 ++++++++
> >  5 files changed, 20 insertions(+)
>
> Missing updates for the new syntax
>
> * Documentation: docs/devel/qapi-code-gen.rst
>

> * Positive test case(s): tests/qapi-schema/doc-good.json
>
> * Maybe a negative test case for _tag_check() failure
>
>
Understood; I wasn't entirely sure if this concept would fly, so I saved
the polish and you got an RFC quality patch. Forgive me, please! If you
think this approach is fine, I will certainly do all the things you
outlined above.


> [...]
>
> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> > index c5d2b950a82..5890a13b5ba 100644
> > --- a/scripts/qapi/parser.py
> > +++ b/scripts/qapi/parser.py
> > @@ -544,6 +544,14 @@ def _tag_check(what: str) -> None:
> >                          raise QAPIParseError(
> >                              self, 'feature descriptions expected')
> >                      have_tagged =3D True
> > +                elif line =3D=3D 'Details:':
> > +                    _tag_check("Details")
>
> This one.
>

ACK


>
> > +                    self.accept(False)
> > +                    line =3D self.get_doc_line()
> > +                    while line =3D=3D '':
> > +                        self.accept(False)
> > +                        line =3D self.get_doc_line()
> > +                    have_tagged =3D True
> >                  elif match :=3D self._match_at_name_colon(line):
> >                      # description
> >                      if have_tagged:
>
>

--000000000000fb5984062e722013
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 17,=
 2025 at 6:55=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; This clarifies sections that are mistaken by the parser as &quot;intro=
&quot;<br>
&gt; sections to be &quot;details&quot; sections instead.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qapi/machine.json=C2=A0 =C2=A0 =C2=A0 | 2 ++<br>
&gt;=C2=A0 qapi/migration.json=C2=A0 =C2=A0 | 4 ++++<br>
&gt;=C2=A0 qapi/qom.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 4 ++++<br>
&gt;=C2=A0 qapi/yank.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 ++<br>
&gt;=C2=A0 scripts/qapi/parser.py | 8 ++++++++<br>
&gt;=C2=A0 5 files changed, 20 insertions(+)<br>
<br>
Missing updates for the new syntax<br>
<br>
* Documentation: docs/devel/qapi-code-gen.rst<br></blockquote><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
<br>
* Positive test case(s): tests/qapi-schema/doc-good.json<br>
<br>
* Maybe a negative test case for _tag_check() failure<br>
<br></blockquote><div><br></div><div>Understood; I wasn&#39;t entirely sure=
 if this concept would fly, so I saved the polish and you got an RFC qualit=
y patch. Forgive me, please! If you think this approach is fine, I will cer=
tainly do all the things you outlined above.</div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
[...]<br>
<br>
&gt; diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py<br>
&gt; index c5d2b950a82..5890a13b5ba 100644<br>
&gt; --- a/scripts/qapi/parser.py<br>
&gt; +++ b/scripts/qapi/parser.py<br>
&gt; @@ -544,6 +544,14 @@ def _tag_check(what: str) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 raise QAPIParseError(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self, &#39;feature descriptions expected=
&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 have_tagged =3D True<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif line =3D=
=3D &#39;Details:&#39;:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 _tag_check(&quot;Details&quot;)<br>
<br>
This one.<br></blockquote><div><br></div><div>ACK</div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 self.accept(False)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 line =3D self.get_doc_line()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 while line =3D=3D &#39;&#39;:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 self.accept(False)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 line =3D self.get_doc_line()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 have_tagged =3D True<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif mat=
ch :=3D self._match_at_name_colon(line):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 # description<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if have_tagged:<br>
<br>
</blockquote></div></div>

--000000000000fb5984062e722013--


