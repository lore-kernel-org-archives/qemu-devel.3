Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B178C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 19:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIBMe-0005QC-Qt; Thu, 22 May 2025 15:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uIBMd-0005PW-0r
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:13:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uIBMa-0007rE-RG
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747941235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HSSnnoEK2d+vdgFQbD5XNON7KKR4YZRVpFajvpeRFFM=;
 b=KaqexmfFMqjmnqoonH8UmOXm4bKw7iY+vaaCq7vl8j03rpV1JqURH8ztGY9G+5S3/uhXda
 x/5Km9L8uayKKzE6pTuThymK9rJP7DR/OiFnWcCNvXuNKEGyTZ8/JxY5DPcoXTCwwHdfux
 Yr38Gf1FfaHFKP13cUYNUzwS55Bu7gM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-5G5tz32QMFymqmMIAN809w-1; Thu, 22 May 2025 15:13:54 -0400
X-MC-Unique: 5G5tz32QMFymqmMIAN809w-1
X-Mimecast-MFC-AGG-ID: 5G5tz32QMFymqmMIAN809w_1747941233
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-231e76f6eafso57905025ad.0
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 12:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747941233; x=1748546033;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HSSnnoEK2d+vdgFQbD5XNON7KKR4YZRVpFajvpeRFFM=;
 b=drNBui686DxDnd+NqOOpWAcckJcWyVRnDLgrMVR4PMwKWB46vUrvu+tiANk3pwuRKT
 0XBMtGB5jrL+0MykpGU7cys3+UAcd8ROLwI4ZVGgxv+KQFPafEiTBorJHGr35lFF8HsR
 S70ANWXEvcPPcUVlJvR2a1BEkr60DHcm30H/y37Sy2/5RTnBun5CsB+l4lPMVSEu4319
 epmew0ncuWrD9wLYWbzTvBxC8XjJPuKzNsTwmCioDplyuyJyBr7tCi6j2shSP7fmj8B4
 elR48Izu5Qrq0MWx1oeF3eeDgF+F0MmzWtlUABUuDQhlVaZIfEB+AoKALJ8hEeLrFOfS
 vkUQ==
X-Gm-Message-State: AOJu0Yzwv3GQqqthO7VB0Dsw+aIF3hexsqVAipWUm51XvAw5e1WmLml3
 m050GCjyAX9vbm1lSyJqv7cWUAmX+AU0LUurBOgGcqLJ/fxodqt1Zs8LlSlhFa/5Vt8FKz2MWKZ
 MzqhXxlOJ/jhissDKqYBjOyD8DPHieNk1iiFfbVShLKQbY0V3+eQSf2IVxfKZIXJBPd3M6eQ/Kf
 j392k85Fm6innCBYf5FDkB7OW0NDppwl4=
X-Gm-Gg: ASbGncsnmKFRfOCCXhPLn7jBEtzDqH4d1ui/zfpDXyEMHk3FhCaT/F1LnbyNg4rtRyI
 Us5pxS/5YdJbGS07y2YXEXFTM/rfD2Q8metZMjJIlhteFjJDwhT4PyMD+FqQ0uz/m54Yy6CcoIZ
 q4SNZKSmX7Ieo/K/x8fXRo3DM+
X-Received: by 2002:a17:902:f551:b0:227:eb61:34b8 with SMTP id
 d9443c01a7336-231de31b3e6mr374006815ad.25.1747941233051; 
 Thu, 22 May 2025 12:13:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYgXmi1Jtqf68xRCZo1FeaIysHc2TICFE2Sh78xVzHAbM/Pnw2Te2JHy4qK2DZKsns8N4x+ngM/YqYzulkKyA=
X-Received: by 2002:a17:902:f551:b0:227:eb61:34b8 with SMTP id
 d9443c01a7336-231de31b3e6mr374006555ad.25.1747941232747; Thu, 22 May 2025
 12:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250519182153.3835722-1-jsnow@redhat.com>
 <20250519182153.3835722-6-jsnow@redhat.com>
 <87r00jaaso.fsf@pond.sub.org>
In-Reply-To: <87r00jaaso.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 22 May 2025 15:13:40 -0400
X-Gm-Features: AX0GCFsxPYV6IherBtyKwNjC8zyT-T273S-VqY808FMMfnkktY9Afhx0sSkaob4
Message-ID: <CAFn=p-Zo5urERRMzLWpa9mQCsv8Sa5ujmO1OkVRrr2TRRMWLEA@mail.gmail.com>
Subject: Re: [PATCH 5/8] python: convert remaining deprecated type hints for
 3.9+
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
Content-Type: multipart/alternative; boundary="0000000000004448530635be4832"
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

--0000000000004448530635be4832
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 5:31=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > In this patch, we don't have a builtin type to use for a type hint, but
> > we do have collections.abc and other standard library types. Replace
> > deprecated type hints with their standard library equivalents:
> >
> > typing.Awaitable      =3D> collections.abc.Awaitable
> > typing.AbstractSet    =3D> collections.abc.AbstractSet
> > typing.AsyncIterator  =3D> collections.abc.AsyncIterator
> > typing.Callable       =3D> collections.abc.Callable
> > typing.Coroutine      =3D> collections.abc.Coroutine
> > typing.Deque          =3D> collections.deque
> > typing.Generator      =3D> collections.abc.Generator
> > typing.Iterable       =3D> collections.abc.Iterable
> > typing.Iterator       =3D> collections.abc.Iterator
> > typing.Mapping        =3D> collections.abc.Mapping
> > typing.Match          =3D> re.Match
> > typing.MutableMapping =3D> collections.abc.MutableMapping
> > typing.Sequence       =3D> collections.abc.Sequence
> > typing.ValuesView     =3D> collections.abc.ValuesView
> >
> > The primary benefit of this is, of course, that the standard type can
> > now be used directly as the type hint. In general, this means far fewer
> > imports from `typing`. The reason we *have* to do this is because the
> > old type hints have been deprecated and will be dropped from a Python
> > release in the future, so I am just getting ahead of it before it cause=
s
> > a problem.
> >
> > (Granted, yes, in practice this just means we're usually importing from
> > collections.abc instead of typing, but... ah well. What are you gonna
> > do.)
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> I'd expect to catch mistakes in the manual parts.  I gave scripts/qapi/
> an eye-over anyway, and it looks good to me.
>
> Acked-by: Markus Armbruster <armbru@redhat.com>
>
> Typing imports left at the end of the series:
>
>     *
>     Any
>     BinaryIO
>     Generic
>     IO
>     Literal
>     NamedTuple
>     NewType
>     NoReturn
>     Optional
>     Protocol
>     TYPE_CHECKING
>     TextIO
>     TypeVar
>     Union
>     cast
>

Yep, all of these are good. Except the *.


>
> The * are in scripts/codeconverter/.  You might want to double-check
> nothing deprecated hides behind the *.
>

Yep. Meant to, forgot. O:-) Thanks for the callout.


>
> The others are all still good, I presume.


Yep! I double-checked the list and none of the remaining ones here are
deprecated.

--js

--0000000000004448530635be4832
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 20,=
 2025 at 5:31=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; In this patch, we don&#39;t have a builtin type to use for a type hint=
, but<br>
&gt; we do have collections.abc and other standard library types. Replace<b=
r>
&gt; deprecated type hints with their standard library equivalents:<br>
&gt;<br>
&gt; typing.Awaitable=C2=A0 =C2=A0 =C2=A0 =3D&gt; collections.abc.Awaitable=
<br>
&gt; typing.AbstractSet=C2=A0 =C2=A0 =3D&gt; collections.abc.AbstractSet<br=
>
&gt; typing.AsyncIterator=C2=A0 =3D&gt; collections.abc.AsyncIterator<br>
&gt; typing.Callable=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D&gt; collections.abc.Call=
able<br>
&gt; typing.Coroutine=C2=A0 =C2=A0 =C2=A0 =3D&gt; collections.abc.Coroutine=
<br>
&gt; typing.Deque=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D&gt; collections.deq=
ue<br>
&gt; typing.Generator=C2=A0 =C2=A0 =C2=A0 =3D&gt; collections.abc.Generator=
<br>
&gt; typing.Iterable=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D&gt; collections.abc.Iter=
able<br>
&gt; typing.Iterator=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D&gt; collections.abc.Iter=
ator<br>
&gt; typing.Mapping=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D&gt; collections.abc.Mapp=
ing<br>
&gt; typing.Match=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D&gt; re.Match<br>
&gt; typing.MutableMapping =3D&gt; collections.abc.MutableMapping<br>
&gt; typing.Sequence=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D&gt; collections.abc.Sequ=
ence<br>
&gt; typing.ValuesView=C2=A0 =C2=A0 =C2=A0=3D&gt; collections.abc.ValuesVie=
w<br>
&gt;<br>
&gt; The primary benefit of this is, of course, that the standard type can<=
br>
&gt; now be used directly as the type hint. In general, this means far fewe=
r<br>
&gt; imports from `typing`. The reason we *have* to do this is because the<=
br>
&gt; old type hints have been deprecated and will be dropped from a Python<=
br>
&gt; release in the future, so I am just getting ahead of it before it caus=
es<br>
&gt; a problem.<br>
&gt;<br>
&gt; (Granted, yes, in practice this just means we&#39;re usually importing=
 from<br>
&gt; collections.abc instead of typing, but... ah well. What are you gonna<=
br>
&gt; do.)<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
I&#39;d expect to catch mistakes in the manual parts.=C2=A0 I gave scripts/=
qapi/<br>
an eye-over anyway, and it looks good to me.<br>
<br>
Acked-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" target=
=3D"_blank">armbru@redhat.com</a>&gt;<br>
<br>
Typing imports left at the end of the series:<br>
<br>
=C2=A0 =C2=A0 *<br>
=C2=A0 =C2=A0 Any<br>
=C2=A0 =C2=A0 BinaryIO<br>
=C2=A0 =C2=A0 Generic<br>
=C2=A0 =C2=A0 IO<br>
=C2=A0 =C2=A0 Literal<br>
=C2=A0 =C2=A0 NamedTuple<br>
=C2=A0 =C2=A0 NewType<br>
=C2=A0 =C2=A0 NoReturn<br>
=C2=A0 =C2=A0 Optional<br>
=C2=A0 =C2=A0 Protocol<br>
=C2=A0 =C2=A0 TYPE_CHECKING<br>
=C2=A0 =C2=A0 TextIO<br>
=C2=A0 =C2=A0 TypeVar<br>
=C2=A0 =C2=A0 Union<br>
=C2=A0 =C2=A0 cast<br></blockquote><div><br></div><div>Yep, all of these ar=
e good. Except the *.</div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
<br>
The * are in scripts/codeconverter/.=C2=A0 You might want to double-check<b=
r>
nothing deprecated hides behind the *.<br></blockquote><div><br></div><div>=
Yep. Meant to, forgot. O:-) Thanks for the callout.</div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
The others are all still good, I presume.</blockquote><div><br></div><div>Y=
ep! I double-checked the list and none of the remaining ones here are depre=
cated.</div><div><br></div><div>--js <br></div></div></div>

--0000000000004448530635be4832--


