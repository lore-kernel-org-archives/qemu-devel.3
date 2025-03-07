Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCE7C28B2E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 21:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqfBB-0004cK-Ry; Fri, 07 Mar 2025 16:24:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqfB4-0004c0-LA
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:24:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqfB2-0005nV-K7
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741382654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=McPlHEJT0h7BCTLV2ejcyRqa1beMI/Ovl9MEhWOYbGQ=;
 b=RIHh0oCiC8Wk675uD4vL0N2oETupbclHVrO+l6q1GSse9YsCzoStwaUzOBYfOQz0r9zt2Q
 Lt9aYbAWRpgOHc20HvgidbtjTLItQiIC24NnI5M7u3VBGXXAXk7kfZl72SDhF7YiaGn1wT
 AA21uBMBcBeEhNFbDhwbhnniQ0h+unE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-a9iNkJXsM2mcjhFzqsubPw-1; Fri, 07 Mar 2025 16:24:11 -0500
X-MC-Unique: a9iNkJXsM2mcjhFzqsubPw-1
X-Mimecast-MFC-AGG-ID: a9iNkJXsM2mcjhFzqsubPw_1741382651
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ff8119b436so1738906a91.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 13:24:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741382651; x=1741987451;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=McPlHEJT0h7BCTLV2ejcyRqa1beMI/Ovl9MEhWOYbGQ=;
 b=EZVrEZwz+Ojhul3eUgFq+jN4WhbU0V1P/xH5VElSFHVdv/KyqR25NOJWXN0LNogvDF
 4W2roos67U+s0TJcf2ErCvvCwFOlxtU79sGEr6xzM+vYkdqJdH9qHCtFGrhUNE2d8VyZ
 hXaItL41udvXRMzUNF1XEKL9XD4pXYry47qtNK5B9QKHBwy0E+/hDCuHijqBCjAgCMyt
 +xoRIO1JpnjKqpDtTlZzj/y7L/OjHoWCohm1zmCGLqyV17lHaiIMDTDAs85iU9/J7LCi
 H9ts8Q4d56XooMh9Ta1An38j4w6inKMG82GDkGzI27vPVgrZ5XXt/K2EoRfhSjW6ATFx
 PZbg==
X-Gm-Message-State: AOJu0YyPZrwvhM2zt2OBw9m+xgV2NnIREhpesWL/LBqIxRUKNbbk0+hg
 6VsAOXXhvaDIk5HaIiTdIn+HtFL3ljPW8jt08aR8FCoRjXIZ2aFP62ui88mTSjS/ZLu2BKu4nB1
 5B9OUsOWZ7AvCjHVZsaNSdUdSfVx4S6dIOZL6uYaoejbplXZZYPLFfVzkRWHU06H2tUutpmikmS
 Dkne4470AVYnj9LqwSSG9cg47BcBg=
X-Gm-Gg: ASbGnctb4HqyRH94LgCOV/4DbH+EJMRI2vFyBwpsnLArKnRR+tqiFaNH79f0OJH+DA+
 ZiMnG+fg2ivB6Ka8a0cginorKBbKwOBb/ePWGdjHVMEmqcTptbdO93yGfQMFEBVEASi2ncg==
X-Received: by 2002:a17:90b:3812:b0:2ef:114d:7bf8 with SMTP id
 98e67ed59e1d1-2ff7ce7277cmr7118477a91.6.1741382650631; 
 Fri, 07 Mar 2025 13:24:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9O4nPI4ac9f2px50HMVEtGl/+TygArkqFYdhezGt2IMuHjHSkC51UH1HRcWs172cVgp423QR6g5jwjC16J6Q=
X-Received: by 2002:a17:90b:3812:b0:2ef:114d:7bf8 with SMTP id
 98e67ed59e1d1-2ff7ce7277cmr7118459a91.6.1741382650280; Fri, 07 Mar 2025
 13:24:10 -0800 (PST)
MIME-Version: 1.0
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-10-jsnow@redhat.com>
 <87ldthnoep.fsf@pond.sub.org>
In-Reply-To: <87ldthnoep.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 7 Mar 2025 16:23:57 -0500
X-Gm-Features: AQ5f1Jre-t0j64Kzk87TUM8VZnVPO0X2EzmDHJnO5L9k05YgdEEOGEHWRXjk4K0
Message-ID: <CAFn=p-Z-qkzjic+hJcSMNr0FxB2j2qQX-TxJkEU=W9yr6bM+3Q@mail.gmail.com>
Subject: Re: [PATCH 09/57] docs/qapi-domain: add QAPI xref roles
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000049dc10062fc73e1a"
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

--00000000000049dc10062fc73e1a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 5:09=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Add domain-specific cross-reference syntax. As of this commit, that
> > means new :qapi:mod:`block-core` and :qapi:any:`block-core` referencing
> > syntax.
> >
> > :mod: will only find modules, but :any: will find anything registered t=
o
> > the QAPI domain. (In forthcoming commits, this means commands, events,
> > enums, etc.)
>
> I understand :any: will find any QAPI schema definitions.  Does it find
> modules, too?
>

`block-core` and :any:`block-core` will find modules, yes. So will
:qapi:mod:`block-core` and :qapi:any:`block-core`.


>
> How could roles narrower than "definition" be useful?
>

At the very least, :qapi:type:`foo` - which omits commands, events, and
modules -- is useful for the role to apply to field lists, since those
things can never possibly be anything other than a data type. The parser
may protect for this, but the QAPI domain also doesn't bother allowing any
such mishaps either.


> I'm asking because naming rules preclude naming collisions among
> definitions:
>
> * Events are ALL_CAPS
>
> * Commands are lower-case-with-dashes, except some older ones use
>   underscores (pragma command-name-exceptions).
>
> * Types are CamelCase.  Note that "C" is not considered a camel.
>
> Fine print: these are the rules for stems, i.e. the name without RFQDN
> or 'x-' prefixes, if any.
>
> If :any: finds modules, then commands and modules could collide.
> Nothing else can.
>

Right, the narrow roles might not be that useful in practice, but they also
cost virtually nothing codewise. I will admit to just copying the Python
domain. I almost feel as if they're interesting to leave in if only to
serve as documentation for how one could narrow the xref roles, but ...
yeah, I admit it's a bit superfluous.


>
> > Creating the cross-references is powered by the QAPIXRefRole class;
> > resolving them is handled by QAPIDomain.resolve_xref().
> >
> > QAPIXrefRole is copied almost verbatim from Sphinx's own
> > PyXrefRole. PyXrefRole (and QAPIXrefRole) adds two features over the
> > base class:
> >
> > (1) Creating a cross-reference with e.g. :py:class:`~class.name`
> > instructs sphinx to omit the fully qualified parts of the resolved name
> > from the actual link text. This may be useful in the future if we add
> > namespaces to QAPI documentation, e.g. :qapi:cmd:`~qsd.blockdev-backup`
> > could link to the QSD-specific documentation for blockdev-backup while
> > omitting that prefix from the link text.
> >
> > (2) Prefixing the link target with a "." changes the search behavior to
> > prefer locally-scoped items first.
> >
> > I think both of these are worth keeping to help manage future namespace
> > issues between QEMU, QSD and QGA; but it's possible it's extraneous. It
> > may possibly be worth keeping just to keep feature parity with Sphinx's
> > other domains; e.g. "principle of least surprise". Dunno.
>
> I generally avoid features without uses.  But I trust your judgement
> here: you decide.
>

Generally, I felt it was easiest to "go with the flow". I am actually
halfway through adding namespace support (surprise...!) and I will
re-evaluate how useful these syntax features are when I'm done.

(I don't know if I will include that feature in the respin for this series
or not, it might be a just-after-freeze thing.)


>
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
>

--00000000000049dc10062fc73e1a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 7, =
2025 at 5:09=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redh=
at.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" =
target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Add domain-specific cross-reference syntax. As of this commit, that<br=
>
&gt; means new :qapi:mod:`block-core` and :qapi:any:`block-core` referencin=
g<br>
&gt; syntax.<br>
&gt;<br>
&gt; :mod: will only find modules, but :any: will find anything registered =
to<br>
&gt; the QAPI domain. (In forthcoming commits, this means commands, events,=
<br>
&gt; enums, etc.)<br>
<br>
I understand :any: will find any QAPI schema definitions.=C2=A0 Does it fin=
d<br>
modules, too?<br></blockquote><div><br></div><div>`block-core` and :any:`bl=
ock-core` will find modules, yes. So will :qapi:mod:`block-core` and :qapi:=
any:`block-core`.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
<br>
How could roles narrower than &quot;definition&quot; be useful?<br></blockq=
uote><div><br></div><div>At the very least, :qapi:type:`foo` - which omits =
commands, events, and modules -- is useful for the role to apply to field l=
ists, since those things can never possibly be anything other than a data t=
ype. The parser may protect for this, but the QAPI domain also doesn&#39;t =
bother allowing any such mishaps either.</div><div><br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
<br>
I&#39;m asking because naming rules preclude naming collisions among<br>
definitions:<br>
<br>
* Events are ALL_CAPS<br>
<br>
* Commands are lower-case-with-dashes, except some older ones use<br>
=C2=A0 underscores (pragma command-name-exceptions).<br>
<br>
* Types are CamelCase.=C2=A0 Note that &quot;C&quot; is not considered a ca=
mel.<br>
<br>
Fine print: these are the rules for stems, i.e. the name without RFQDN<br>
or &#39;x-&#39; prefixes, if any.<br>
<br>
If :any: finds modules, then commands and modules could collide.<br>
Nothing else can.<br></blockquote><div><br></div><div>Right, the narrow rol=
es might not be that useful in practice, but they also cost virtually nothi=
ng codewise. I will admit to just copying the Python domain. I almost feel =
as if they&#39;re interesting to leave in if only to serve as documentation=
 for how one could narrow the xref roles, but ... yeah, I admit it&#39;s a =
bit superfluous.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
<br>
&gt; Creating the cross-references is powered by the QAPIXRefRole class;<br=
>
&gt; resolving them is handled by QAPIDomain.resolve_xref().<br>
&gt;<br>
&gt; QAPIXrefRole is copied almost verbatim from Sphinx&#39;s own<br>
&gt; PyXrefRole. PyXrefRole (and QAPIXrefRole) adds two features over the<b=
r>
&gt; base class:<br>
&gt;<br>
&gt; (1) Creating a cross-reference with e.g. :py:class:`~<a href=3D"http:/=
/class.name" rel=3D"noreferrer" target=3D"_blank">class.name</a>`<br>
&gt; instructs sphinx to omit the fully qualified parts of the resolved nam=
e<br>
&gt; from the actual link text. This may be useful in the future if we add<=
br>
&gt; namespaces to QAPI documentation, e.g. :qapi:cmd:`~qsd.blockdev-backup=
`<br>
&gt; could link to the QSD-specific documentation for blockdev-backup while=
<br>
&gt; omitting that prefix from the link text.<br>
&gt;<br>
&gt; (2) Prefixing the link target with a &quot;.&quot; changes the search =
behavior to<br>
&gt; prefer locally-scoped items first.<br>
&gt;<br>
&gt; I think both of these are worth keeping to help manage future namespac=
e<br>
&gt; issues between QEMU, QSD and QGA; but it&#39;s possible it&#39;s extra=
neous. It<br>
&gt; may possibly be worth keeping just to keep feature parity with Sphinx&=
#39;s<br>
&gt; other domains; e.g. &quot;principle of least surprise&quot;. Dunno.<br=
>
<br>
I generally avoid features without uses.=C2=A0 But I trust your judgement<b=
r>
here: you decide.<br></blockquote><div><br></div><div>Generally, I felt it =
was easiest to &quot;go with the flow&quot;. I am actually halfway through =
adding namespace support (surprise...!) and I will re-evaluate how useful t=
hese syntax features are when I&#39;m done.</div><div><br></div><div>(I don=
&#39;t know if I will include that feature in the respin for this series or=
 not, it might be a just-after-freeze thing.)</div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
</blockquote></div></div>

--00000000000049dc10062fc73e1a--


