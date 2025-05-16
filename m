Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9A8C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 14:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFwEG-0005Fm-7J; Fri, 16 May 2025 10:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conte.souleymane@gmail.com>)
 id 1uFwE8-0005AD-Q7
 for qemu-devel@nongnu.org; Fri, 16 May 2025 10:39:56 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <conte.souleymane@gmail.com>)
 id 1uFwE6-0001Gr-G5
 for qemu-devel@nongnu.org; Fri, 16 May 2025 10:39:56 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-70b51b9de1fso22625057b3.1
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 07:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747406393; x=1748011193; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1xcBQVLJ9XDsGG6g4Ybniir5oS/MOg1nwm2vP5dR4KU=;
 b=BHI4Y9ffYj5NhOfEiA/bVpU5aveJvYFvHI1i46ncfRxnjwO8Ew9YY7Dk8Ci/1gIvZO
 c6pbzyl+dcJ600SUy26vQVZJf6F/031M2DBwa99bU/wEV4zYjWm8FJJ2J+IFFsHe2HOF
 JRnBZerhiRWKrGUvghaJA5Ojhp90v4J8/+X0Ub/UNluWqkoGgbpkh0+5siekPjfrdB00
 4t9R9Ap+R4GajW79rZ78l0tneFeklOqs901wqdtbIK6nOmj3xvf+z18nnKralxh8nlAx
 gxbYrEqFEvicVnQF2MQBQRiwyynIopR8/VW4x1XujtqIDtWP/yQxG+NHwIKgG53kNhg9
 LTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747406393; x=1748011193;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1xcBQVLJ9XDsGG6g4Ybniir5oS/MOg1nwm2vP5dR4KU=;
 b=YERDUVrU7zaROf1yE6kMp4Ln4yDiU/ZOA8HRl0L3dNPqhoGNgJml/Mf0c1hfIEfIgZ
 nYr2R0Qsgmk4r4h/lShT2XGiN7wDSokHm62KxyiNHnamJPyMKnnbjKJHCqwzYjh7BOwc
 NcU5kWuKEBeidxxhVeuzLHYwlWTI1/s1V3dHeBCuRJQdeOxFi6GhX64XVtOZnN1yaJfZ
 ZR8N+pHjXr0FF9E9GkGLe3iBtN3LC3LB3qII/hV8i3/ZJWq5mC1wXU07N0F27HM4tbVA
 1+AL2v5y4yUvLK4yhLzX+e575NeghmOHoOeWjS9XkCKzuCvNbr8W+McnTbDxbB8mFarf
 Ovnw==
X-Gm-Message-State: AOJu0YzQCTsMX1qKJ0bIGmL8R+FjdOCGVRpK7kD+ub2JI5CUpkH8xXpZ
 0q/utwHJJlOlR8MMdyArCUjrx/ahs3pllwZ4/iAK3Q3NjRM7Pvl+OfnzL6n3oWDGPuywmixCeq+
 VgDDJqi8t2D2sNatiTRD8ijvRZxNG84s=
X-Gm-Gg: ASbGnctm3Hs7yOxisngtaSRw6ww7X9KtGeYWIWHUDv6HAb2hLXVTWsz/NMp/prj+LkE
 SsSwOO77+Ybxl2NXhim6AXD7EB1XrYJi7rWHjwW545inx0b6sKWcZ4fh0RzjbU4JrzYAJT9FP0L
 3cSyqRGWxobNPm9wUUE/PKRNUu6rNJ8LIfkqy3woh3ylIzFsksAd8fOzI+ZPlgcQ0ckw==
X-Google-Smtp-Source: AGHT+IHcLdXIz1bcGyH/4aBz2nR95GMEg40oZHil3COAf9+c8UPzEzekOMLTPkayB1pphTVwDddfojV6b6vRvJBYoGM=
X-Received: by 2002:a05:690c:2789:b0:6fb:9b8c:4b50 with SMTP id
 00721157ae682-70caaf7470amr42210557b3.13.1747406392659; Fri, 16 May 2025
 07:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250515102400.36151-1-conte.souleymane@gmail.com>
 <zox7vj235b67jxv6fklzre6ebeqbft3sujqjuh5it2cng2culj@a63jddoleon5>
In-Reply-To: <zox7vj235b67jxv6fklzre6ebeqbft3sujqjuh5it2cng2culj@a63jddoleon5>
From: =?UTF-8?Q?souleymane_cont=C3=A9?= <conte.souleymane@gmail.com>
Date: Fri, 16 May 2025 16:39:41 +0200
X-Gm-Features: AX0GCFsdiIZKgpfLU-IPvKP7Vp5uJPTQ8qfjvkiyuv04FhPLgQknLcmZKUvyF34
Message-ID: <CAOw3OrGCtG3a-hLbb6b2LYqKo9uwPmaR0gQZ-RYBqF9sTk2MBw@mail.gmail.com>
Subject: Re: [PATCH] docs/interop: convert text files to restructuredText
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, peter.maydell@linaro.org
Content-Type: multipart/alternative; boundary="000000000000501f3f063541c126"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=conte.souleymane@gmail.com; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000501f3f063541c126
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
Thanks a lot for your review and helpful suggestions.

I will address the following points in v2:
- Fix the typo: "Each entry look" =E2=86=92 "Each entry looks"
- Improve the layout for the LUKS section in the visual diagram
- Check whether nested tables are possible in reStructuredText
- Update "qemu" to "QEMU" for consistency, where appropriate

I'll prepare and send a v2 shortly.

Souleymane Conte

Le jeu. 15 mai 2025 =C3=A0 21:54, Eric Blake <eblake@redhat.com> a =C3=A9cr=
it :

> On Thu, May 15, 2025 at 10:24:00AM +0000, conte.souleymane@gmail.com
> wrote:
> > From: Souleymane Conte <conte.souleymane@gmail.com>
> >
> > buglink: https://gitlab.com/qemu-project/qemu/-/issues/527
> >
> > Signed-off-by: Souleymane Conte <conte.souleymane@gmail.com>
> > ---
> >  docs/interop/index.rst                |   1 +
> >  docs/interop/{qcow2.txt =3D> qcow2.rst} | 210 +++++++++++++++---------=
--
> >  2 files changed, 123 insertions(+), 88 deletions(-)
> >  rename docs/interop/{qcow2.txt =3D> qcow2.rst} (89%)
> >
>
> As long as we're touching this file,...
>
> > +Feature name table
> > +------------------
> >
> >  The feature name table is an optional header extension that contains
> the name
> >  for features used by the image. It can be used by applications that
> don't know
> > @@ -288,7 +300,7 @@ the respective feature (e.g. because the feature wa=
s
> introduced only later) to
> >  display a useful error message.
> >
> >  The number of entries in the feature name table is determined by the
> length of
> > -the header extension data. Each entry look like this:
> > +the header extension data. Each entry look like this::
>
> s/look/looks/
>
> > @@ -377,35 +392,40 @@ Logically the layout looks like
> >
> >    +-----------------------------+
> >    | QCow2 header                |
> > +  +-----------------------------+
> >    | QCow2 header extension X    |
> > +  +-----------------------------+
> >    | QCow2 header extension FDE  |
> > +  +-----------------------------+
> >    | QCow2 header extension ...  |
> > +  +-----------------------------+
> >    | QCow2 header extension Z    |
> >    +-----------------------------+
> > +  | ...                         |
> > +  +-----------------------------+
> > +  | ...                         |
> > +  +-----------------------------+
> >    | ....other QCow2 tables....  |
> > -  .                             .
> > -  .                             .
> >    +-----------------------------+
> > -  | +-------------------------+ |
> > -  | | LUKS partition header   | |
> > -  | +-------------------------+ |
> > -  | | LUKS key material 1     | |
> > -  | +-------------------------+ |
> > -  | | LUKS key material 2     | |
> > -  | +-------------------------+ |
> > -  | | LUKS key material ...   | |
> > -  | +-------------------------+ |
> > -  | | LUKS key material 8     | |
> > -  | +-------------------------+ |
> > +  | LUKS partition header       |
> > +  +-----------------------------+
> > +  | LUKS key material 1         |
> > +  +-----------------------------+
>
> Is there no way to nest a table in .rst?
>
> > +Host cluster management
> > +-----------------------
> >
> >  qcow2 manages the allocation of host clusters by maintaining a
> reference count
> >  for each host cluster. A refcount of 0 means that the cluster is free,
> 1 means
> > @@ -453,14 +474,15 @@ Although a large enough refcount table can reserv=
e
> clusters past 64 PB
> >  large), note that some qcow2 metadata such as L1/L2 tables must point
> >  to clusters prior to that point.
> >
> > -Note: qemu has an implementation limit of 8 MB as the maximum refcount
> > -table size.  With a 2 MB cluster size and a default refcount_order of
> > -4, it is unable to reference host resources beyond 2 EB (61 bits); in
> > -the worst case, with a 512 cluster size and refcount_order of 6, it is
> > -unable to access beyond 32 GB (35 bits).
> > +.. note::
> > +    qemu has an implementation limit of 8 MB as the maximum refcount
>
> Should we be changing s/qemu/QEMU/ while editing this file?
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.
> Virtualization:  qemu.org | libguestfs.org
>
>

--000000000000501f3f063541c126
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br>Thanks a lot for your review and helpful suggestion=
s.<br><br>I will address the following points in v2:<br>- Fix the typo: &qu=
ot;Each entry look&quot; =E2=86=92 &quot;Each entry looks&quot;<br>- Improv=
e the layout for the LUKS section in the visual diagram<br>- Check whether =
nested tables are possible in reStructuredText<br>- Update &quot;qemu&quot;=
 to &quot;QEMU&quot; for consistency, where appropriate<br><br>I&#39;ll pre=
pare and send a v2 shortly.<br><br>Souleymane Conte<br></div><br><div class=
=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr=
">Le=C2=A0jeu. 15 mai 2025 =C3=A0=C2=A021:54, Eric Blake &lt;<a href=3D"mai=
lto:eblake@redhat.com">eblake@redhat.com</a>&gt; a =C3=A9crit=C2=A0:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">On Thu, May 15, 2025 a=
t 10:24:00AM +0000, <a href=3D"mailto:conte.souleymane@gmail.com" target=3D=
"_blank">conte.souleymane@gmail.com</a> wrote:<br>
&gt; From: Souleymane Conte &lt;<a href=3D"mailto:conte.souleymane@gmail.co=
m" target=3D"_blank">conte.souleymane@gmail.com</a>&gt;<br>
&gt; <br>
&gt; buglink: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/527"=
 rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/=
-/issues/527</a><br>
&gt; <br>
&gt; Signed-off-by: Souleymane Conte &lt;<a href=3D"mailto:conte.souleymane=
@gmail.com" target=3D"_blank">conte.souleymane@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/interop/index.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 docs/interop/{qcow2.txt =3D&gt; qcow2.rst} | 210 +++++++++++++++=
-----------<br>
&gt;=C2=A0 2 files changed, 123 insertions(+), 88 deletions(-)<br>
&gt;=C2=A0 rename docs/interop/{qcow2.txt =3D&gt; qcow2.rst} (89%)<br>
&gt;<br>
<br>
As long as we&#39;re touching this file,...<br>
<br>
&gt; +Feature name table<br>
&gt; +------------------<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 The feature name table is an optional header extension that cont=
ains the name<br>
&gt;=C2=A0 for features used by the image. It can be used by applications t=
hat don&#39;t know<br>
&gt; @@ -288,7 +300,7 @@ the respective feature (e.g. because the feature w=
as introduced only later) to<br>
&gt;=C2=A0 display a useful error message.<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 The number of entries in the feature name table is determined by=
 the length of<br>
&gt; -the header extension data. Each entry look like this:<br>
&gt; +the header extension data. Each entry look like this::<br>
<br>
s/look/looks/<br>
<br>
&gt; @@ -377,35 +392,40 @@ Logically the layout looks like<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 +-----------------------------+<br>
&gt;=C2=A0 =C2=A0 | QCow2 header=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |<br>
&gt; +=C2=A0 +-----------------------------+<br>
&gt;=C2=A0 =C2=A0 | QCow2 header extension X=C2=A0 =C2=A0 |<br>
&gt; +=C2=A0 +-----------------------------+<br>
&gt;=C2=A0 =C2=A0 | QCow2 header extension FDE=C2=A0 |<br>
&gt; +=C2=A0 +-----------------------------+<br>
&gt;=C2=A0 =C2=A0 | QCow2 header extension ...=C2=A0 |<br>
&gt; +=C2=A0 +-----------------------------+<br>
&gt;=C2=A0 =C2=A0 | QCow2 header extension Z=C2=A0 =C2=A0 |<br>
&gt;=C2=A0 =C2=A0 +-----------------------------+<br>
&gt; +=C2=A0 | ...=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt; +=C2=A0 +-----------------------------+<br>
&gt; +=C2=A0 | ...=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt; +=C2=A0 +-----------------------------+<br>
&gt;=C2=A0 =C2=A0 | ....other QCow2 tables....=C2=A0 |<br>
&gt; -=C2=A0 .=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.<br>
&gt; -=C2=A0 .=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.<br>
&gt;=C2=A0 =C2=A0 +-----------------------------+<br>
&gt; -=C2=A0 | +-------------------------+ |<br>
&gt; -=C2=A0 | | LUKS partition header=C2=A0 =C2=A0| |<br>
&gt; -=C2=A0 | +-------------------------+ |<br>
&gt; -=C2=A0 | | LUKS key material 1=C2=A0 =C2=A0 =C2=A0| |<br>
&gt; -=C2=A0 | +-------------------------+ |<br>
&gt; -=C2=A0 | | LUKS key material 2=C2=A0 =C2=A0 =C2=A0| |<br>
&gt; -=C2=A0 | +-------------------------+ |<br>
&gt; -=C2=A0 | | LUKS key material ...=C2=A0 =C2=A0| |<br>
&gt; -=C2=A0 | +-------------------------+ |<br>
&gt; -=C2=A0 | | LUKS key material 8=C2=A0 =C2=A0 =C2=A0| |<br>
&gt; -=C2=A0 | +-------------------------+ |<br>
&gt; +=C2=A0 | LUKS partition header=C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt; +=C2=A0 +-----------------------------+<br>
&gt; +=C2=A0 | LUKS key material 1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt; +=C2=A0 +-----------------------------+<br>
<br>
Is there no way to nest a table in .rst?<br>
<br>
&gt; +Host cluster management<br>
&gt; +-----------------------<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 qcow2 manages the allocation of host clusters by maintaining a r=
eference count<br>
&gt;=C2=A0 for each host cluster. A refcount of 0 means that the cluster is=
 free, 1 means<br>
&gt; @@ -453,14 +474,15 @@ Although a large enough refcount table can reser=
ve clusters past 64 PB<br>
&gt;=C2=A0 large), note that some qcow2 metadata such as L1/L2 tables must =
point<br>
&gt;=C2=A0 to clusters prior to that point.<br>
&gt;=C2=A0 <br>
&gt; -Note: qemu has an implementation limit of 8 MB as the maximum refcoun=
t<br>
&gt; -table size.=C2=A0 With a 2 MB cluster size and a default refcount_ord=
er of<br>
&gt; -4, it is unable to reference host resources beyond 2 EB (61 bits); in=
<br>
&gt; -the worst case, with a 512 cluster size and refcount_order of 6, it i=
s<br>
&gt; -unable to access beyond 32 GB (35 bits).<br>
&gt; +.. note::<br>
&gt; +=C2=A0 =C2=A0 qemu has an implementation limit of 8 MB as the maximum=
 refcount<br>
<br>
Should we be changing s/qemu/QEMU/ while editing this file?<br>
<br>
-- <br>
Eric Blake, Principal Software Engineer<br>
Red Hat, Inc.<br>
Virtualization:=C2=A0 <a href=3D"http://qemu.org" rel=3D"noreferrer" target=
=3D"_blank">qemu.org</a> | <a href=3D"http://libguestfs.org" rel=3D"norefer=
rer" target=3D"_blank">libguestfs.org</a><br>
<br>
</blockquote></div>

--000000000000501f3f063541c126--

