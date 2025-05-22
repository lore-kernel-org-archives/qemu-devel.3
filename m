Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9F4C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 19:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIBJE-0002iw-Td; Thu, 22 May 2025 15:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uIBJB-0002i8-Vl
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:10:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uIBJ9-0007II-3d
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747941021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7jrCVBNIMsxlyvEWtUS8CwjTNirrbtIxIjRxS5h//O4=;
 b=f8DgugOZueEkKyFqhwCwxjar0euWG9wjkf0VkI5Gdxk0+ZvMa6Stpr0AcC5lSnH+aQYNm3
 V8uwNHkqNgh21m0Y2nB9xkyLcg3pp4L+A8JC3nKTf0XkgvYisLMdodIthFKN6r6GpPNKdt
 DiyYoWo3yAo3StBtIpGJWu7Q+/FZ3ZI=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-XVo6jvVJMZeFmZUTY6GwJg-1; Thu, 22 May 2025 15:10:19 -0400
X-MC-Unique: XVo6jvVJMZeFmZUTY6GwJg-1
X-Mimecast-MFC-AGG-ID: XVo6jvVJMZeFmZUTY6GwJg_1747941019
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-231dfb7315eso41106915ad.1
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 12:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747941018; x=1748545818;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7jrCVBNIMsxlyvEWtUS8CwjTNirrbtIxIjRxS5h//O4=;
 b=r07aMsDjhqUUQL9V2qgxjoelUJDkGqHWq5X6K4nbN02MoEqJaIeykpWlHoX2EuMtpN
 UqWUQV+1MgNrUGgjrC0hZxjzP48ry3rKUK+9wM/jK0KOui3SOwX4qfa6QmNtTtFcp/6B
 0IGGlTt6H+R27U+yCyBCWyrEKI8IfIJ3UAWcjlnzix1NC9//1+IkTJujKb8/bCnc1/1s
 s5VlvuNYxCBiSAjCIJUgycbNx4LXqN4051vgAjVM9+Cg3WMZHy9ZUVwCqRhhhHQng1Tu
 v8hRxO78sken0p4Gi7Q/b8xkll94Vo/GQXrNe5WMdJVOWh5DZ1UNdeYh1d2H/GrvX2/L
 Kw4A==
X-Gm-Message-State: AOJu0YwSAK8+melJew4GZwvGt68OcbMrHtZYBi80NkMWE5xhdhKWmgU5
 D5zm997DQ2L8byuPp933WHbDfUVq1u75ivEO+aI32jlL9zwcRv8t0bRqcHTXqMJ7iMijFlw6Hjl
 Fvxp0NeQryhDVo3htVMfPaTL7Cs1YFX2i/mUtShfELcDRlH7LkLA5pKUqaFIARLNJLidJ+0E63k
 Asr0x5QnvTftq92rzV0Wj52K9UM+RrlSo=
X-Gm-Gg: ASbGncsAlwOFC/aYCCU0Y5nJPpO8A1fmgpTD7Q+1i7A7HwSqbZtcSGYW2Ueh7SxBDhW
 0QVTBDFrKSZBjqr/LPfy3s1YDM613OKRGxPOH94HM5bKt759avDX38bx15uYBSmOWosIagrhLEW
 EZAZlNsrH+rGddJcU3UEyAoIzz
X-Received: by 2002:a17:903:4b2b:b0:223:f9a4:3f99 with SMTP id
 d9443c01a7336-233f23c5f97mr2168595ad.29.1747941018704; 
 Thu, 22 May 2025 12:10:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1UzYnR5db1NYBaiEsNjkJno06sN5V3LsqShVMV1fnumY8Hg3Xf+6ZlDnmQ0o5GSx5bZPxZSHu+ydMvMb+ovU=
X-Received: by 2002:a17:903:4b2b:b0:223:f9a4:3f99 with SMTP id
 d9443c01a7336-233f23c5f97mr2168155ad.29.1747941018371; Thu, 22 May 2025
 12:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250519182153.3835722-1-jsnow@redhat.com>
 <20250519182153.3835722-3-jsnow@redhat.com>
 <875xhvd8zh.fsf@pond.sub.org>
In-Reply-To: <875xhvd8zh.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 22 May 2025 15:10:05 -0400
X-Gm-Features: AX0GCFt6IjzYhpMWMo1PyURxrAEJDRNO2M-fHSozQcD3aRJFEdJ4HrJneuQWi38
Message-ID: <CAFn=p-ZaG3F_aBOoMEk2x8X9nCUFjL=CkjMAynUbwyAaJHNSwA@mail.gmail.com>
Subject: Re: [PATCH 2/8] python: update pylint ignores
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Hanna Reitz <hreitz@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, qemu-block@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org, 
 Maksim Davydov <davydov-max@yandex-team.ru>, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007d2d180635be3b94"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--0000000000007d2d180635be3b94
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 3:42=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > The next patch will synchronize the qemu.qmp library with the external,
> > standalone version. That synchronization will require a few extra
> > ignores for pylint, so do that now.
>
> Just one, unless I'm cross-eyed again.
>

Nope. changed the commit message. Just doing things in weird orders as is
my usual...


>
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  python/setup.cfg | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/python/setup.cfg b/python/setup.cfg
> > index d7f5dc7bafe..02cc076eaea 100644
> > --- a/python/setup.cfg
> > +++ b/python/setup.cfg
> > @@ -140,11 +140,12 @@ ignore_missing_imports =3D True
> >  # --disable=3DW".
> >  disable=3Dconsider-using-f-string,
> >          consider-using-with,
> > +        no-member,  # mypy also handles this better.
> >          too-many-arguments,
> > -        too-many-positional-arguments,
> >          too-many-function-args,  # mypy handles this with less false
> positives.
> >          too-many-instance-attributes,
> > -        no-member,  # mypy also handles this better.
> > +        too-many-positional-arguments,
>
> Up to here, just a reorder, which I appreciate.
>
> > +        unknown-option-value,
>
> This is the new one.
>
> >
> >  [pylint.basic]
> >  # Good variable names which should always be accepted, separated by a
> comma.
>
>

--0000000000007d2d180635be3b94
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 20,=
 2025 at 3:42=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; The next patch will synchronize the qemu.qmp library with the external=
,<br>
&gt; standalone version. That synchronization will require a few extra<br>
&gt; ignores for pylint, so do that now.<br>
<br>
Just one, unless I&#39;m cross-eyed again.<br></blockquote><div><br></div><=
div>Nope. changed the commit message. Just doing things in weird orders as =
is my usual...</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 python/setup.cfg | 5 +++--<br>
&gt;=C2=A0 1 file changed, 3 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/python/setup.cfg b/python/setup.cfg<br>
&gt; index d7f5dc7bafe..02cc076eaea 100644<br>
&gt; --- a/python/setup.cfg<br>
&gt; +++ b/python/setup.cfg<br>
&gt; @@ -140,11 +140,12 @@ ignore_missing_imports =3D True<br>
&gt;=C2=A0 # --disable=3DW&quot;.<br>
&gt;=C2=A0 disable=3Dconsider-using-f-string,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 consider-using-with,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 no-member,=C2=A0 # mypy also handles this=
 better.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 too-many-arguments,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 too-many-positional-arguments,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 too-many-function-args,=C2=A0 # mypy=
 handles this with less false positives.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 too-many-instance-attributes,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 no-member,=C2=A0 # mypy also handles this=
 better.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 too-many-positional-arguments,<br>
<br>
Up to here, just a reorder, which I appreciate.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unknown-option-value,<br>
<br>
This is the new one.<br>
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 [pylint.basic]<br>
&gt;=C2=A0 # Good variable names which should always be accepted, separated=
 by a comma.<br>
<br>
</blockquote></div></div>

--0000000000007d2d180635be3b94--


