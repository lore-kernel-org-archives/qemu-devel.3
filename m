Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5821C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 14:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7cNS-0000Xj-3J; Thu, 16 May 2024 10:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s7cNP-0000X2-S4
 for qemu-devel@nongnu.org; Thu, 16 May 2024 10:46:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s7cNN-0002ke-2C
 for qemu-devel@nongnu.org; Thu, 16 May 2024 10:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715870791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XXzBL+CS8oJjrx6AvNCAE5vimryYbt3z5xcOjxLMPI0=;
 b=fPlM4I+flyRnLekQWJ0QPmh0IkcpjXYu4CfUt3Zb4ifAQdhdS2kNs5BKgvwZMiFMhC/wuC
 bwprAL2PMWsAdt5y1WqIpAJtVb50jkHZRPwkmcjVbEzyBf836oc7nPTKTkN9fxUWNBEvb5
 wshsorzbtsC3c8EmrzK/GCBggW/IlQA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-kkVW8BnmNJy5fD_xUUYu_A-1; Thu, 16 May 2024 10:46:30 -0400
X-MC-Unique: kkVW8BnmNJy5fD_xUUYu_A-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-349cafdc8f0so3539833f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 07:46:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715870789; x=1716475589;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XXzBL+CS8oJjrx6AvNCAE5vimryYbt3z5xcOjxLMPI0=;
 b=NrMf9/m0V1uftsZLyB5uPKt0XKy4i5Tv6lbCYaiva7N4Zo4NCTd7tJtGMD1amjClyd
 ugQ36tl/mJHazyX0FR54gHV8Fty7Va9O9Jr/VsZGxqwkCPi39MqGEi1R8I5fQ8lXtKDC
 sLyEv4VpTE9QMl3ThTAn9v3A2OlTh8eeUixqEfbZpoC3JUj1aKtZMBcubCRip1xlxLh4
 AJAbvVWbuwwv7JLd8Q2SF+GLzILBaNWPDFQQOF4LFbyG7/EU5wrXixsLvgsMS6YBVmJA
 koonknVPkW4EyZkpttlfpSetx99DfCU8swqmlq/Jmzqgzce9tNQIVeFo+4459u2s6RPe
 /pSQ==
X-Gm-Message-State: AOJu0Yxnt9gwVlwXouJh2xS4zsFKTgWzqWovRwTWYrg77rRXTwy+fVcV
 UluSZFnlz1VlNr48ZDBA83Ha18gr3SfyAwWb4IcO/H40k4EySMpnzvrGXDkbYpiPmyKs6ysbYfl
 he6vTC0lGhI3I/RBkFkaNqRew0AV030cX2Smbf7dPkdZu2dyKArs50HeTSgvE38F4CcVkQ9S1gN
 c6UpiJsd6yf7IeeuRNLphrHiugKDY=
X-Received: by 2002:adf:e8c1:0:b0:351:daf5:e28b with SMTP id
 ffacd0b85a97d-351daf5e375mr1721589f8f.23.1715870788971; 
 Thu, 16 May 2024 07:46:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIXRGYjdRJbXKH2xpxXe2e6pzCyF5wsxZmmqcoPw6n5wY3nMMKQuKCVuEEehw0Gw0wH4FzgKpI9Jj3qVkDE5g=
X-Received: by 2002:adf:e8c1:0:b0:351:daf5:e28b with SMTP id
 ffacd0b85a97d-351daf5e375mr1721547f8f.23.1715870788628; Thu, 16 May 2024
 07:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240514215740.940155-1-jsnow@redhat.com>
 <20240514215740.940155-8-jsnow@redhat.com>
 <87wmnunuu5.fsf@pond.sub.org>
In-Reply-To: <87wmnunuu5.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 16 May 2024 10:46:15 -0400
Message-ID: <CAFn=p-YiwRnbTeghGA5GMAuP3JNUmvFxqamLrzkTgj_mss5UNg@mail.gmail.com>
Subject: Re: [PATCH 07/20] qapi/parser: add semantic 'kind' parameter to
 QAPIDoc.Section
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, 
 Ani Sinha <anisinha@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Kevin Wolf <kwolf@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Mads Ynddal <mads@ynddal.dk>, 
 Jason Wang <jasowang@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Victor Toso de Carvalho <victortoso@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, Lukas Straub <lukasstraub2@web.de>, 
 Yanan Wang <wangyanan55@huawei.com>, Hanna Reitz <hreitz@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000d64e0f0618934c9d"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
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

--000000000000d64e0f0618934c9d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024, 2:18=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > When iterating all_sections, this is helpful to be able to distinguish
> > "members" from "features"; the only other way to do so is to
> > cross-reference these sections against QAPIDoc.args or QAPIDoc.features=
,
> > but if the desired end goal for QAPIDoc is to remove everything except
> > all_sections, we need *something* accessible to distinguish them.
> >
> > To keep types simple, add this semantic parameter to the base Section
> > and not just ArgSection; we can use this to filter out paragraphs and
> > tagged sections, too.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/parser.py | 25 ++++++++++++++++---------
> >  1 file changed, 16 insertions(+), 9 deletions(-)
> >
> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> > index 161768b8b96..cf4cbca1c1f 100644
> > --- a/scripts/qapi/parser.py
> > +++ b/scripts/qapi/parser.py
> > @@ -613,21 +613,27 @@ class QAPIDoc:
> >
> >      class Section:
> >          # pylint: disable=3Dtoo-few-public-methods
> > -        def __init__(self, info: QAPISourceInfo,
> > -                     tag: Optional[str] =3D None):
> > +        def __init__(
> > +            self,
> > +            info: QAPISourceInfo,
> > +            tag: Optional[str] =3D None,
> > +            kind: str =3D 'paragraph',
> > +        ):
> >              # section source info, i.e. where it begins
> >              self.info =3D info
> >              # section tag, if any ('Returns', '@name', ...)
> >              self.tag =3D tag
> >              # section text without tag
> >              self.text =3D ''
> > +            # section type - {paragraph, feature, member, tagged}
> > +            self.kind =3D kind
>
> Hmm.  .kind is almost redundant with .tag.
>

Almost, yes. But the crucial bit is members/features as you notice. That's
the real necessity here that saves a lot of code when relying on *only*
all_sections.

(If you want to remove the other fields leaving only all_sections behind,
this is strictly necessary.)


> Untagged section:    .kind is 'paragraph', .tag is None
>
> Member description:  .kind is 'member', .tag matches @NAME
>
> Feature description: .kind is 'feature', .tag matches @NAME


> Tagged section:      .kind is 'tagged', .tag matches
>                           r'Returns|Errors|Since|Notes?|Examples?|TODO'
>
> .kind can directly be derived from .tag except for member and feature
> descriptions.  And you want to tell these two apart in a straightforward
> manner in later patches, as you explain in your commit message.
>
> If .kind is 'member' or 'feature', then self must be an ArgSection.
> Worth a comment?  An assertion?
>

No real need. The classes don't differ much in practice so there's not much
benefit, and asserting it won't help the static typer out anyway because it
can't remember the inference from string->type anyway.

If you wanted to be FANCY, we could use string literal typing on the field
and restrict valid values per-class, but that's so needless not even I'm
tempted by it.


> Some time back, I considered changing .tag for member and feature
> descriptions to suitable strings, like your 'member' and 'feature', and
> move the member / feature name into ArgSection.  I didn't, because the
> benefit wasn't worth the churn at the time.  Perhaps it's worth it now.
> Would it result in simpler code than your solution?
>

Not considerably, I think. Would just be shuffling around which field names
I touch and where/when.

It might actually just add some lines where I have to assert isinstance to
do type narrowing in the generator.


> Terminology nit: the section you call 'paragraph' isn't actually a
> paragraph: it could be several paragraphs.  Best to call it 'untagged',
> as in .ensure_untagged_section().
>

Oh, I hate when you make a good point. I was avoiding the term because I'm
removing Notes and Examples, and we have plans to eliminate Since ... the
tagged sections are almost going away entirely, leaving just TODO, which we
ignore.

Uhm, can I name it paragraphs? :) or open to other suggestions, incl.
untagged if that's still your preference.


> >
> >          def append_line(self, line: str) -> None:
> >              self.text +=3D line + '\n'
> >
> >      class ArgSection(Section):
> > -        def __init__(self, info: QAPISourceInfo, tag: str):
> > -            super().__init__(info, tag)
> > +        def __init__(self, info: QAPISourceInfo, tag: str, kind: str):
> > +            super().__init__(info, tag, kind)
> >              self.member: Optional['QAPISchemaMember'] =3D None
> >
> >          def connect(self, member: 'QAPISchemaMember') -> None:
>
> [...]
>
>

--000000000000d64e0f0618934c9d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, May 16, 2024, 2:18=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:js=
now@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&g=
t; writes:<br>
<br>
&gt; When iterating all_sections, this is helpful to be able to distinguish=
<br>
&gt; &quot;members&quot; from &quot;features&quot;; the only other way to d=
o so is to<br>
&gt; cross-reference these sections against QAPIDoc.args or QAPIDoc.feature=
s,<br>
&gt; but if the desired end goal for QAPIDoc is to remove everything except=
<br>
&gt; all_sections, we need *something* accessible to distinguish them.<br>
&gt;<br>
&gt; To keep types simple, add this semantic parameter to the base Section<=
br>
&gt; and not just ArgSection; we can use this to filter out paragraphs and<=
br>
&gt; tagged sections, too.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 scripts/qapi/parser.py | 25 ++++++++++++++++---------<br>
&gt;=C2=A0 1 file changed, 16 insertions(+), 9 deletions(-)<br>
&gt;<br>
&gt; diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py<br>
&gt; index 161768b8b96..cf4cbca1c1f 100644<br>
&gt; --- a/scripts/qapi/parser.py<br>
&gt; +++ b/scripts/qapi/parser.py<br>
&gt; @@ -613,21 +613,27 @@ class QAPIDoc:<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 class Section:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # pylint: disable=3Dtoo-few-public-m=
ethods<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 def __init__(self, info: QAPISourceInfo,<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0tag: Optional[str] =3D None):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 def __init__(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info: QAPISourceInfo,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tag: Optional[str] =3D None=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kind: str =3D &#39;paragrap=
h&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # section source info,=
 i.e. where it begins<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://self=
.info" rel=3D"noreferrer noreferrer" target=3D"_blank">self.info</a> =3D in=
fo<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # section tag, if any =
(&#39;Returns&#39;, &#39;@name&#39;, ...)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.tag =3D tag<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # section text without=
 tag<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.text =3D &#39;&#3=
9;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # section type - {paragraph=
, feature, member, tagged}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.kind =3D kind<br>
<br>
Hmm.=C2=A0 .kind is almost redundant with .tag.<br></blockquote></div></div=
><div dir=3D"auto"><br></div><div dir=3D"auto">Almost, yes. But the crucial=
 bit is members/features as you notice. That&#39;s the real necessity here =
that saves a lot of code when relying on *only* all_sections.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">(If you want to remove the other fiel=
ds leaving only all_sections behind, this is strictly necessary.)</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">
<br>
Untagged section:=C2=A0 =C2=A0 .kind is &#39;paragraph&#39;, .tag is None<b=
r>
<br>
Member description:=C2=A0 .kind is &#39;member&#39;, .tag matches @NAME<br>
<br>
Feature description: .kind is &#39;feature&#39;, .tag matches @NAME</blockq=
uote></div></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">
<br>
Tagged section:=C2=A0 =C2=A0 =C2=A0 .kind is &#39;tagged&#39;, .tag matches=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 r&#39;Returns|Errors|Since|Notes?|Examples?|TODO&#39;<br>
<br>
.kind can directly be derived from .tag except for member and feature<br>
descriptions.=C2=A0 And you want to tell these two apart in a straightforwa=
rd<br>
manner in later patches, as you explain in your commit message.<br>
<br>
If .kind is &#39;member&#39; or &#39;feature&#39;, then self must be an Arg=
Section.<br>
Worth a comment?=C2=A0 An assertion?<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">No real need. The classes don&#39;t d=
iffer much in practice so there&#39;s not much benefit, and asserting it wo=
n&#39;t help the static typer out anyway because it can&#39;t remember the =
inference from string-&gt;type anyway.=C2=A0</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">If you wanted to be FANCY, we could use string literal=
 typing on the field and restrict valid values per-class, but that&#39;s so=
 needless not even I&#39;m tempted by it.</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>
<br>
Some time back, I considered changing .tag for member and feature<br>
descriptions to suitable strings, like your &#39;member&#39; and &#39;featu=
re&#39;, and<br>
move the member / feature name into ArgSection.=C2=A0 I didn&#39;t, because=
 the<br>
benefit wasn&#39;t worth the churn at the time.=C2=A0 Perhaps it&#39;s wort=
h it now.<br>
Would it result in simpler code than your solution?<br></blockquote></div><=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">Not considerably, I thin=
k. Would just be shuffling around which field names I touch and where/when.=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">It might actually just =
add some lines where I have to assert isinstance to do type narrowing in th=
e generator.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Terminology nit: the section you call &#39;paragraph&#39; isn&#39;t actuall=
y a<br>
paragraph: it could be several paragraphs.=C2=A0 Best to call it &#39;untag=
ged&#39;,<br>
as in .ensure_untagged_section().<br></blockquote></div></div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">Oh, I hate when you make a good point. I w=
as avoiding the term because I&#39;m removing Notes and Examples, and we ha=
ve plans to eliminate Since ... the tagged sections are almost going away e=
ntirely, leaving just TODO, which we ignore.</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">Uhm, can I name it paragraphs? :) or open to other sug=
gestions, incl. untagged if that&#39;s still your preference.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 def append_line(self, line: str) -&g=
t; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.text +=3D line + =
&#39;\n&#39;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 class ArgSection(Section):<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 def __init__(self, info: QAPISourceInfo, =
tag: str):<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 super().__init__(info, tag)=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 def __init__(self, info: QAPISourceInfo, =
tag: str, kind: str):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 super().__init__(info, tag,=
 kind)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.member: Optional[=
&#39;QAPISchemaMember&#39;] =3D None<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 def connect(self, member: &#39;QAPIS=
chemaMember&#39;) -&gt; None:<br>
<br>
[...]<br>
<br>
</blockquote></div></div></div>

--000000000000d64e0f0618934c9d--


