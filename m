Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B819CC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 15:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJEaj-0002D6-GB; Mon, 17 Jun 2024 11:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sJEah-0002CX-O8
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 11:48:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sJEae-0002kj-An
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 11:48:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718639295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x4ufsN8crQz07H88B0NacQ/krJzFTFnI8oUwbY3f2xc=;
 b=ImxoDENe5/x46p+ftH9sz/OyACuEswhG/q4P5u36hASDv0YLf5o+EHkMBIrL+Ab9bfrDGp
 sIyudnzu6VXD/BeRwFzogVvA7GJ4lDzfSK3MscMP1VJ/w2+Vq311m8xdfBtsGxZQC7sc7/
 60FdwhL0wJgBKOOwIWVWIawFnB2wemc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-nYCxyhtKPwWvm1LK6EXjfw-1; Mon, 17 Jun 2024 11:48:12 -0400
X-MC-Unique: nYCxyhtKPwWvm1LK6EXjfw-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1f66f2e4cc7so59819375ad.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 08:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718639291; x=1719244091;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x4ufsN8crQz07H88B0NacQ/krJzFTFnI8oUwbY3f2xc=;
 b=pzgNe7Xv4g9IuAW/sv+GSU5xfcXcPpedLqf5lTLuCQwwgFWF4mui6dZEenqwzvmnpH
 UoI7dZthXI8URq2/UmtiFSuTv3ibkLEUbPr21q0q120Y6jYyCqI+LqmrU5mSxbU3LwT4
 XiMgGvTsWPq6m7KMtiHoSF2Wnbud8kjMnuEcNw8jvDKhWGznSoU/KlhL+xFZfvpp2M/e
 QgQ72ony/Otv8tGR4qfChdx1+wfEa3IJgpRfgyXzkhni71Yw0uCrEjkCmSMSQqvzdvw5
 6a5ZZYXSYplVSvm97055w5ttyh5r5qt5Urgvk6xGymFgMbVLq2leCWwfcszT1ck1HJ5n
 KPSQ==
X-Gm-Message-State: AOJu0Yzy1hbRCmxJbIB3lVZC3Q0338sDAU+y80yk4A2CEO2g29YXLHvI
 jnj9yQK/cyuTHaRoSrne/CiY7M7MOY9laxQreU8e9BQf13FkuNWr+Ty33aG6NPZLJrc2uGqV1Wv
 bgYJ+rPzMjZ4Flbl0jdY/UnoUGuUDI7hKj3hB4WC1NWPEVGOkhIvZcR7ITvxr+6YqsfzUTDeS/y
 sAyG/CfOfQI5LilnKtm4KNLYNYPLU=
X-Received: by 2002:a17:902:d508:b0:1f8:55dd:3c44 with SMTP id
 d9443c01a7336-1f8629ff06fmr155823135ad.61.1718639290561; 
 Mon, 17 Jun 2024 08:48:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjgXnGQR9Q7IXXf92qRPorXSRdCdcjXIW4s3gElvWETJJbJ0zmKy4odBIE5Id2pnFRNSx5psApZ1CBdmCv8ME=
X-Received: by 2002:a17:902:d508:b0:1f8:55dd:3c44 with SMTP id
 d9443c01a7336-1f8629ff06fmr155822695ad.61.1718639290142; Mon, 17 Jun 2024
 08:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240514215740.940155-1-jsnow@redhat.com>
 <20240514215740.940155-8-jsnow@redhat.com>
 <87wmnunuu5.fsf@pond.sub.org>
 <CAFn=p-YiwRnbTeghGA5GMAuP3JNUmvFxqamLrzkTgj_mss5UNg@mail.gmail.com>
 <87y1789a02.fsf@pond.sub.org>
In-Reply-To: <87y1789a02.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 17 Jun 2024 11:47:57 -0400
Message-ID: <CAFn=p-bqJNLOZEbGJetMcYBVWoopeWaJBCkG2LpSQNbCYZX+EQ@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="00000000000062e764061b17e4e8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

--00000000000062e764061b17e4e8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 10:46=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om>
wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > On Thu, May 16, 2024, 2:18=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com>
> wrote:
> >
> >> John Snow <jsnow@redhat.com> writes:
> >>
> >> > When iterating all_sections, this is helpful to be able to distingui=
sh
> >> > "members" from "features"; the only other way to do so is to
> >> > cross-reference these sections against QAPIDoc.args or
> QAPIDoc.features,
> >> > but if the desired end goal for QAPIDoc is to remove everything exce=
pt
> >> > all_sections, we need *something* accessible to distinguish them.
> >> >
> >> > To keep types simple, add this semantic parameter to the base Sectio=
n
> >> > and not just ArgSection; we can use this to filter out paragraphs an=
d
> >> > tagged sections, too.
> >> >
> >> > Signed-off-by: John Snow <jsnow@redhat.com>
> >> > ---
> >> >  scripts/qapi/parser.py | 25 ++++++++++++++++---------
> >> >  1 file changed, 16 insertions(+), 9 deletions(-)
> >> >
> >> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> >> > index 161768b8b96..cf4cbca1c1f 100644
> >> > --- a/scripts/qapi/parser.py
> >> > +++ b/scripts/qapi/parser.py
> >> > @@ -613,21 +613,27 @@ class QAPIDoc:
> >> >
> >> >      class Section:
> >> >          # pylint: disable=3Dtoo-few-public-methods
> >> > -        def __init__(self, info: QAPISourceInfo,
> >> > -                     tag: Optional[str] =3D None):
> >> > +        def __init__(
> >> > +            self,
> >> > +            info: QAPISourceInfo,
> >> > +            tag: Optional[str] =3D None,
> >> > +            kind: str =3D 'paragraph',
> >> > +        ):
> >> >              # section source info, i.e. where it begins
> >> >              self.info =3D info
> >> >              # section tag, if any ('Returns', '@name', ...)
> >> >              self.tag =3D tag
> >> >              # section text without tag
> >> >              self.text =3D ''
> >> > +            # section type - {paragraph, feature, member, tagged}
> >> > +            self.kind =3D kind
> >>
> >> Hmm.  .kind is almost redundant with .tag.
> >>
> >
> > Almost, yes. But the crucial bit is members/features as you notice.
> That's
> > the real necessity here that saves a lot of code when relying on *only*
> > all_sections.
> >
> > (If you want to remove the other fields leaving only all_sections behin=
d,
> > this is strictly necessary.)
> >
> >
> >> Untagged section:    .kind is 'paragraph', .tag is None
> >>
> >> Member description:  .kind is 'member', .tag matches @NAME
> >>
> >> Feature description: .kind is 'feature', .tag matches @NAME
> >
> >
> >> Tagged section:      .kind is 'tagged', .tag matches
> >>                           r'Returns|Errors|Since|Notes?|Examples?|TODO=
'
> >>
> >> .kind can directly be derived from .tag except for member and feature
> >> descriptions.  And you want to tell these two apart in a straightforwa=
rd
> >> manner in later patches, as you explain in your commit message.
> >>
> >> If .kind is 'member' or 'feature', then self must be an ArgSection.
> >> Worth a comment?  An assertion?
> >>
> >
> > No real need. The classes don't differ much in practice so there's not
> much
> > benefit, and asserting it won't help the static typer out anyway becaus=
e
> it
> > can't remember the inference from string->type anyway.
> >
> > If you wanted to be FANCY, we could use string literal typing on the
> field
> > and restrict valid values per-class, but that's so needless not even I'=
m
> > tempted by it.
> >
> >
> >> Some time back, I considered changing .tag for member and feature
> >> descriptions to suitable strings, like your 'member' and 'feature', an=
d
> >> move the member / feature name into ArgSection.  I didn't, because the
> >> benefit wasn't worth the churn at the time.  Perhaps it's worth it now=
.
> >> Would it result in simpler code than your solution?
> >>
> >
> > Not considerably, I think. Would just be shuffling around which field
> names
> > I touch and where/when.
>
> The way .tag works irks me.  I might explore the change I proposed just
> to see whether I hate the result less.  On top of your work, to not
> annoy you without need.
>

OK, knock yourself out :)


>
> > It might actually just add some lines where I have to assert isinstance
> to
> > do type narrowing in the generator.
> >
> >> Terminology nit: the section you call 'paragraph' isn't actually a
> >> paragraph: it could be several paragraphs.  Best to call it 'untagged'=
,
> >> as in .ensure_untagged_section().
> >>
> >
> > Oh, I hate when you make a good point. I was avoiding the term because
> I'm
> > removing Notes and Examples, and we have plans to eliminate Since ... t=
he
> > tagged sections are almost going away entirely, leaving just TODO, whic=
h
> we
> > ignore.
> >
> > Uhm, can I name it paragraphs? :) or open to other suggestions, incl.
> > untagged if that's still your preference.
>
> 'untagged' is more consistent with existing names and comments:
> .ensure_untagged_section(), "additional (non-argument) sections,
> possibly tagged", ...
>
> When all tags but 'TODO' are gone, the concept "tagged vs. untagged
> section" ceases to make sense, I guess.  We can tweak the names and
> comments accordingly then.
>

How do I name this when it comes to intro and outro sections?
"intro-untagged", "outro-untagged"? I still think "paragraphs" makes more
sense, unfortunately, ...

I realize "untagged" is more consistent with what we have currently, but
that's just not really where I'm trying to go with this stuff.

Seeing as naming things is the hardest unsolved problem in computer
science, got some concrete suggestions?

--js


>
> >
> >> >
> >> >          def append_line(self, line: str) -> None:
> >> >              self.text +=3D line + '\n'
> >> >
> >> >      class ArgSection(Section):
> >> > -        def __init__(self, info: QAPISourceInfo, tag: str):
> >> > -            super().__init__(info, tag)
> >> > +        def __init__(self, info: QAPISourceInfo, tag: str, kind:
> str):
> >> > +            super().__init__(info, tag, kind)
> >> >              self.member: Optional['QAPISchemaMember'] =3D None
> >> >
> >> >          def connect(self, member: 'QAPISchemaMember') -> None:
> >>
> >> [...]
> >>
> >>
>
>

--00000000000062e764061b17e4e8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 13, 2024 at 10:46=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; On Thu, May 16, 2024, 2:18=E2=80=AFAM Markus Armbruster &lt;<a href=3D=
"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt; wrot=
e:<br>
&gt;<br>
&gt;&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank=
">jsnow@redhat.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; When iterating all_sections, this is helpful to be able to di=
stinguish<br>
&gt;&gt; &gt; &quot;members&quot; from &quot;features&quot;; the only other=
 way to do so is to<br>
&gt;&gt; &gt; cross-reference these sections against QAPIDoc.args or QAPIDo=
c.features,<br>
&gt;&gt; &gt; but if the desired end goal for QAPIDoc is to remove everythi=
ng except<br>
&gt;&gt; &gt; all_sections, we need *something* accessible to distinguish t=
hem.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; To keep types simple, add this semantic parameter to the base=
 Section<br>
&gt;&gt; &gt; and not just ArgSection; we can use this to filter out paragr=
aphs and<br>
&gt;&gt; &gt; tagged sections, too.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.c=
om" target=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 scripts/qapi/parser.py | 25 ++++++++++++++++---------<b=
r>
&gt;&gt; &gt;=C2=A0 1 file changed, 16 insertions(+), 9 deletions(-)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py<=
br>
&gt;&gt; &gt; index 161768b8b96..cf4cbca1c1f 100644<br>
&gt;&gt; &gt; --- a/scripts/qapi/parser.py<br>
&gt;&gt; &gt; +++ b/scripts/qapi/parser.py<br>
&gt;&gt; &gt; @@ -613,21 +613,27 @@ class QAPIDoc:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 class Section:<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # pylint: disable=3Dtoo-few=
-public-methods<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 def __init__(self, info: QAPISou=
rceInfo,<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0tag: Optional[str] =3D None):<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 def __init__(<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info: QAPISourceIn=
fo,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tag: Optional[str]=
 =3D None,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kind: str =3D &#39=
;paragraph&#39;,<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ):<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # section sou=
rce info, i.e. where it begins<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"ht=
tp://self.info" rel=3D"noreferrer" target=3D"_blank">self.info</a> =3D info=
<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # section tag=
, if any (&#39;Returns&#39;, &#39;@name&#39;, ...)<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.tag =3D =
tag<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # section tex=
t without tag<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.text =3D=
 &#39;&#39;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # section type - {=
paragraph, feature, member, tagged}<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.kind =3D kind=
<br>
&gt;&gt;<br>
&gt;&gt; Hmm.=C2=A0 .kind is almost redundant with .tag.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Almost, yes. But the crucial bit is members/features as you notice. Th=
at&#39;s<br>
&gt; the real necessity here that saves a lot of code when relying on *only=
*<br>
&gt; all_sections.<br>
&gt;<br>
&gt; (If you want to remove the other fields leaving only all_sections behi=
nd,<br>
&gt; this is strictly necessary.)<br>
&gt;<br>
&gt;<br>
&gt;&gt; Untagged section:=C2=A0 =C2=A0 .kind is &#39;paragraph&#39;, .tag =
is None<br>
&gt;&gt;<br>
&gt;&gt; Member description:=C2=A0 .kind is &#39;member&#39;, .tag matches =
@NAME<br>
&gt;&gt;<br>
&gt;&gt; Feature description: .kind is &#39;feature&#39;, .tag matches @NAM=
E<br>
&gt;<br>
&gt;<br>
&gt;&gt; Tagged section:=C2=A0 =C2=A0 =C2=A0 .kind is &#39;tagged&#39;, .ta=
g matches<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r&#39;Returns|Errors|Since|Notes?|Examples?|=
TODO&#39;<br>
&gt;&gt;<br>
&gt;&gt; .kind can directly be derived from .tag except for member and feat=
ure<br>
&gt;&gt; descriptions.=C2=A0 And you want to tell these two apart in a stra=
ightforward<br>
&gt;&gt; manner in later patches, as you explain in your commit message.<br=
>
&gt;&gt;<br>
&gt;&gt; If .kind is &#39;member&#39; or &#39;feature&#39;, then self must =
be an ArgSection.<br>
&gt;&gt; Worth a comment?=C2=A0 An assertion?<br>
&gt;&gt;<br>
&gt;<br>
&gt; No real need. The classes don&#39;t differ much in practice so there&#=
39;s not much<br>
&gt; benefit, and asserting it won&#39;t help the static typer out anyway b=
ecause it<br>
&gt; can&#39;t remember the inference from string-&gt;type anyway.<br>
&gt;<br>
&gt; If you wanted to be FANCY, we could use string literal typing on the f=
ield<br>
&gt; and restrict valid values per-class, but that&#39;s so needless not ev=
en I&#39;m<br>
&gt; tempted by it.<br>
&gt;<br>
&gt;<br>
&gt;&gt; Some time back, I considered changing .tag for member and feature<=
br>
&gt;&gt; descriptions to suitable strings, like your &#39;member&#39; and &=
#39;feature&#39;, and<br>
&gt;&gt; move the member / feature name into ArgSection.=C2=A0 I didn&#39;t=
, because the<br>
&gt;&gt; benefit wasn&#39;t worth the churn at the time.=C2=A0 Perhaps it&#=
39;s worth it now.<br>
&gt;&gt; Would it result in simpler code than your solution?<br>
&gt;&gt;<br>
&gt;<br>
&gt; Not considerably, I think. Would just be shuffling around which field =
names<br>
&gt; I touch and where/when.<br>
<br>
The way .tag works irks me.=C2=A0 I might explore the change I proposed jus=
t<br>
to see whether I hate the result less.=C2=A0 On top of your work, to not<br=
>
annoy you without need.<br></blockquote><div><br></div><div>OK, knock yours=
elf out :)<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
<br>
&gt; It might actually just add some lines where I have to assert isinstanc=
e to<br>
&gt; do type narrowing in the generator.<br>
&gt;<br>
&gt;&gt; Terminology nit: the section you call &#39;paragraph&#39; isn&#39;=
t actually a<br>
&gt;&gt; paragraph: it could be several paragraphs.=C2=A0 Best to call it &=
#39;untagged&#39;,<br>
&gt;&gt; as in .ensure_untagged_section().<br>
&gt;&gt;<br>
&gt;<br>
&gt; Oh, I hate when you make a good point. I was avoiding the term because=
 I&#39;m<br>
&gt; removing Notes and Examples, and we have plans to eliminate Since ... =
the<br>
&gt; tagged sections are almost going away entirely, leaving just TODO, whi=
ch we<br>
&gt; ignore.<br>
&gt;<br>
&gt; Uhm, can I name it paragraphs? :) or open to other suggestions, incl.<=
br>
&gt; untagged if that&#39;s still your preference.<br>
<br>
&#39;untagged&#39; is more consistent with existing names and comments:<br>
.ensure_untagged_section(), &quot;additional (non-argument) sections,<br>
possibly tagged&quot;, ...<br>
<br>
When all tags but &#39;TODO&#39; are gone, the concept &quot;tagged vs. unt=
agged<br>
section&quot; ceases to make sense, I guess.=C2=A0 We can tweak the names a=
nd<br>
comments accordingly then.<br></blockquote><div><br></div><div>How do I nam=
e this when it comes to intro and outro sections? &quot;intro-untagged&quot=
;, &quot;outro-untagged&quot;? I still think &quot;paragraphs&quot; makes m=
ore sense, unfortunately, ...<br></div><div><br></div><div>I realize &quot;=
untagged&quot; is more consistent with what we have currently, but that&#39=
;s just not really where I&#39;m trying to go with this stuff.</div><div><b=
r></div><div>Seeing as naming things is the hardest unsolved problem in com=
puter science, got some concrete suggestions?<br></div><div><br></div><div>=
--js<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
<br>
&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 def append_line(self, line:=
 str) -&gt; None:<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.text +=
=3D line + &#39;\n&#39;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 class ArgSection(Section):<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 def __init__(self, info: QAPISou=
rceInfo, tag: str):<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 super().__init__(i=
nfo, tag)<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 def __init__(self, info: QAPISou=
rceInfo, tag: str, kind: str):<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 super().__init__(i=
nfo, tag, kind)<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.member: =
Optional[&#39;QAPISchemaMember&#39;] =3D None<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 def connect(self, member: &=
#39;QAPISchemaMember&#39;) -&gt; None:<br>
&gt;&gt;<br>
&gt;&gt; [...]<br>
&gt;&gt;<br>
&gt;&gt;<br>
<br>
</blockquote></div></div>

--00000000000062e764061b17e4e8--


