Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB55C36008
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 16:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txTf5-0006oY-KM; Wed, 26 Mar 2025 12:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1txTf0-0006nY-2r
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 12:31:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1txTet-0005CQ-7V
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 12:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743006672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fanBI/jGxE/xm5Q4Kq/W+bFXaFjEeHlvPmsgYTaSOYw=;
 b=ZyC2KwQRC6SYVS23bsFxn4qKJGUSQ1LQlCv6GsHBfyb7lLE7E4oFnKgxxKbPO++JL0CNHC
 Sn88Urpqqinhy/i4dEfeILpcCUC/ZKc0ev6hAMYPB+0VFGlJl+A9KAr7ApdIE7ouN7MP4Q
 Peayd9e1Qi397zHkUxaX9jkyWHnwCkk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-1CblcuX_P-O6PoZsph_jGA-1; Wed, 26 Mar 2025 12:31:09 -0400
X-MC-Unique: 1CblcuX_P-O6PoZsph_jGA-1
X-Mimecast-MFC-AGG-ID: 1CblcuX_P-O6PoZsph_jGA_1743006668
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ff8340d547so13051799a91.2
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 09:31:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743006668; x=1743611468;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fanBI/jGxE/xm5Q4Kq/W+bFXaFjEeHlvPmsgYTaSOYw=;
 b=eW9Sd37jmy/mJp4rHKogcTCoOprmupQa3kZeujMRq0jgbqKOT0DKWufinVc9TdP+ok
 IewsqoDmiO5u9dkhLmuYfglynlmcYMJar2oiDCKj16c8c5F22WuttdSyl0c4VxJMLSDh
 DSplCBg5hCJ1R7P/o8wLt3jd0MCZZwTGZFtJFkkBSofK/ncFbNBSDZ8exxU/pkOebK8g
 2Z+xsyqdKZwhu9iwiyb/FYWlWIYMXHcsbGvHxOZ0M9O+yBpUUvvx8ESNgY61sXQzPkXk
 GWOPakYvJuUJSawmYPV7NLD1keBvDsZ8bFTpELpq9+k+9IfViT85AizDK8duyNKFIeJH
 aEog==
X-Gm-Message-State: AOJu0Yz/lqCtMO/JIIIuKliHiALXnD51eRhEXHtjyhMxles1a6wERX+g
 hV6ToXwZzVzgwHPtDfgDfyGLG99KEHx9VNFxd/EGErnFQK6PI5RulkeXplsXGVBPXrVoZ0q6uKA
 tIECENeIa9imSZilEn2WQf90J5rzISC88XArenXC8u1bo/EsyMQ0HHkflU+LyMeUqbhr3kRQVZK
 zbcGjW2VS50r3lFHVM7R0rNPqhKy4=
X-Gm-Gg: ASbGncvAGFZ1W9hLy44Ik+n22/neE8OTPZkYuBkTi6w2uq038eOa2Ro/se/oyG8rRP6
 qHvVZ9qv0qEbScB8TnReTeZGlzsnjNRIR7OQ5rWO7koN9EeTKrUbW9mSmDy8fxGNJUWUJjONP4n
 YIvVL1Elv7OKuu8HfWNnweRMa90ReR
X-Received: by 2002:a17:90a:c888:b0:2f9:9ddd:689b with SMTP id
 98e67ed59e1d1-303a8d81f5amr309156a91.22.1743006667986; 
 Wed, 26 Mar 2025 09:31:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExOAUdDweRZQWeHW85jHjOHfVDS4cqMg/mz6+Q5nwYveNwo43mr8oApp2wld86Nm+MSjkKELdl83WX9vkktvs=
X-Received: by 2002:a17:90a:c888:b0:2f9:9ddd:689b with SMTP id
 98e67ed59e1d1-303a8d81f5amr309125a91.22.1743006667530; Wed, 26 Mar 2025
 09:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250322010857.309490-1-jsnow@redhat.com>
 <20250322010857.309490-3-jsnow@redhat.com>
 <87cye5mopz.fsf@pond.sub.org>
 <CAFn=p-ZDmOTDWie6tCKyOGFj3R4wm9N_4r+J9VWzGYKKoF7sbw@mail.gmail.com>
In-Reply-To: <CAFn=p-ZDmOTDWie6tCKyOGFj3R4wm9N_4r+J9VWzGYKKoF7sbw@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 26 Mar 2025 12:30:56 -0400
X-Gm-Features: AQ5f1Jpem31eAoJisz8TPaL7lS9Ke_rN2X0c2Q1XNqxY5A7bEoEuCr1C89eXHvY
Message-ID: <CAFn=p-ZrR+xxfKGSEBusGgwbXOha7_FM_bhrtTN+HM2OKN6Vig@mail.gmail.com>
Subject: Re: [PATCH 2/4] docs, qapi: generate undocumented return sections
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Peter Xu <peterx@redhat.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Lukas Straub <lukasstraub2@web.de>, 
 Fabiano Rosas <farosas@suse.de>, Eduardo Habkost <eduardo@habkost.net>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-trivial@nongnu.org, 
 Jason Wang <jasowang@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Yanan Wang <wangyanan55@huawei.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, 
 Zhenwei Pi <pizhenwei@bytedance.com>, Mads Ynddal <mads@ynddal.dk>, 
 Gerd Hoffmann <kraxel@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Eric Blake <eblake@redhat.com>, Jiri Pirko <jiri@resnulli.us>
Content-Type: multipart/alternative; boundary="00000000000042829b0631415d44"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--00000000000042829b0631415d44
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 1:47=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:

>
>
> On Tue, Mar 25, 2025 at 5:41=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com>
> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > This patch changes the qapidoc transmogrifier to generate Return value
>> > documentation for any command that has a return value but hasn't
>> > explicitly documented that return value.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>>
>> [...]
>>
>> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
>> > index 949d9e8bff7..8c382a049af 100644
>> > --- a/scripts/qapi/parser.py
>> > +++ b/scripts/qapi/parser.py
>> > @@ -815,6 +815,17 @@ def connect_feature(self, feature:
>> 'QAPISchemaFeature') -> None:
>> >                                 % feature.name)
>> >          self.features[feature.name].connect(feature)
>> >
>> > +    def ensure_returns(self, info: QAPISourceInfo) -> None:
>> > +        if not any(s.kind =3D=3D QAPIDoc.Kind.RETURNS for s in
>> self.all_sections):
>> > +
>> > +            # Stub "Returns" section for undocumented returns value.
>> > +            # Insert stub after the last non-PLAIN section.
>>
>> Can you explain why that's where it should go?
>>
>
> ... No.
>
> (Joking...)
>
> I'm open to better positions if you can define them, admittedly I just
> picked a place that's likely to be at the end of the info field list
> sections. (Reminder: "info field list" means the sections that are
> converted directly into the two-column layout section of the rendered doc=
s.)
>
>
>>
>> Should we tighten section order some more?
>>
>
> I wouldn't mind, but I believe this needs to be a change that you direct.
> From memory, I believe my preferred "enforced order" is something like th=
is:
>
> 1. Intro paragraph(s)
> 2. Members
> 3. Features
> 4. Errors
> 5. Returns
> 6. Detail paragraph(s)
>
> ...Give or take some re-ordering between features/errors/returns as
> appropriate, I don't actually really care about the order there so much a=
s
> I care about the fact that plain paragraphs do not appear between the
> members-features-errors-returns "region". The rest can be your preference=
.
>
> (Since and TODO can go wherever, from the perspective of the
> transmogrifier, I do not care about them since I do not render them in th=
e
> document flow.)
>

With the insertions fixed to not duplicate/triplicate things, I notice
these (unintentional) changes:

- x-debug-block-dirty-bitmap-sha256 moves returns from above errors to belo=
w
- blockdev-snapshot-delete-internal-sync ditto
- query-xen-replication-status ditto
- query-colo-status ditto
- query-balloon ditto
- query-hv-balloon-status-report ditto
- query-yank -- this one actually moves it from above what would be details
to below -- this creates a new ambiguous case as we discussed on call
earlier today.
- add-fd goes from above errors to below errors again.



>
>
>>
>> > +            for sect in reversed(self.all_sections):
>> > +                if sect.kind !=3D QAPIDoc.Kind.PLAIN:
>> > +                    stub =3D QAPIDoc.Section(info, QAPIDoc.Kind.RETUR=
NS)
>> > +                    idx =3D self.all_sections.index(sect) + 1
>> > +                    self.all_sections.insert(idx, stub)
>> > +
>> >      def check_expr(self, expr: QAPIExpression) -> None:
>> >          if 'command' in expr:
>> >              if self.returns and 'returns' not in expr:
>> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
>> > index cbe3b5aa91e..3abddea3525 100644
>> > --- a/scripts/qapi/schema.py
>> > +++ b/scripts/qapi/schema.py
>> > @@ -1062,6 +1062,9 @@ def connect_doc(self, doc: Optional[QAPIDoc] =3D
>> None) -> None:
>> >              if self.arg_type and self.arg_type.is_implicit():
>> >                  self.arg_type.connect_doc(doc)
>> >
>> > +            if self.ret_type and self.info:
>> > +                doc.ensure_returns(self.info)
>> > +
>> >      def visit(self, visitor: QAPISchemaVisitor) -> None:
>> >          super().visit(visitor)
>> >          visitor.visit_command(
>>
>>

--00000000000042829b0631415d44
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 25,=
 2025 at 1:47=E2=80=AFPM John Snow &lt;<a href=3D"mailto:jsnow@redhat.com">=
jsnow@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 25, 2025=
 at 5:41=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.c=
om" target=3D"_blank">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsno=
w@redhat.com" target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; This patch changes the qapidoc transmogrifier to generate Return value=
<br>
&gt; documentation for any command that has a return value but hasn&#39;t<b=
r>
&gt; explicitly documented that return value.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
[...]<br>
<br>
&gt; diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py<br>
&gt; index 949d9e8bff7..8c382a049af 100644<br>
&gt; --- a/scripts/qapi/parser.py<br>
&gt; +++ b/scripts/qapi/parser.py<br>
&gt; @@ -815,6 +815,17 @@ def connect_feature(self, feature: &#39;QAPISchem=
aFeature&#39;) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0% <a href=3D"http://feature=
.name" rel=3D"noreferrer" target=3D"_blank">feature.name</a>)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.features[<a href=3D"http://feat=
ure.name" rel=3D"noreferrer" target=3D"_blank">feature.name</a>].connect(fe=
ature)<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 def ensure_returns(self, info: QAPISourceInfo) -&gt; No=
ne:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not any(s.kind =3D=3D QAPIDoc.Kind.RET=
URNS for s in self.all_sections):<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Stub &quot;Returns&quot; =
section for undocumented returns value.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Insert stub after the las=
t non-PLAIN section.<br>
<br>
Can you explain why that&#39;s where it should go?<br></blockquote><div><br=
></div><div>... No.</div><div><br></div><div>(Joking...)</div><div><br></di=
v><div>I&#39;m open to better positions if you can define them, admittedly =
I just picked a place that&#39;s likely to be at the end of the info field =
list sections. (Reminder: &quot;info field list&quot; means the sections th=
at are converted directly into the two-column layout section of the rendere=
d docs.)</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
<br>
Should we tighten section order some more?<br></blockquote><div><br></div><=
div>I wouldn&#39;t mind, but I believe this needs to be a change that you d=
irect. From memory, I believe my preferred &quot;enforced order&quot; is so=
mething like this:</div><div><br></div><div>1. Intro paragraph(s)<br></div>=
<div>2. Members</div><div>3. Features</div><div>4. Errors</div><div>5. Retu=
rns</div><div>6. Detail paragraph(s)</div><div><br></div><div>...Give or ta=
ke some re-ordering between features/errors/returns as appropriate, I don&#=
39;t actually really care about the order there so much as I care about the=
 fact that plain paragraphs do not appear between the members-features-erro=
rs-returns &quot;region&quot;. The rest can be your preference.</div><div><=
br></div><div>(Since and TODO can go wherever, from the perspective of the=
=20
transmogrifier, I do not care about them since I do not render them in=20
the document flow.)</div></div></div></blockquote><div><br></div><div>With =
the insertions fixed to not duplicate/triplicate things, I notice these (un=
intentional) changes:</div><div><br></div><div>- x-debug-block-dirty-bitmap=
-sha256 moves returns from above errors to below</div><div>- blockdev-snaps=
hot-delete-internal-sync ditto</div><div>- query-xen-replication-status dit=
to</div><div>- query-colo-status ditto</div><div>- query-balloon ditto</div=
><div>- query-hv-balloon-status-report ditto</div><div>- query-yank -- this=
 one actually moves it from above what would be details to below -- this cr=
eates a new ambiguous case as we discussed on call earlier today.<br>- add-=
fd goes from above errors to below errors again.<br><br></div><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div=
 class=3D"gmail_quote"><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for sect in reversed(self.a=
ll_sections):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if sect.kind =
!=3D QAPIDoc.Kind.PLAIN:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 stub =3D QAPIDoc.Section(info, QAPIDoc.Kind.RETURNS)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 idx =3D self.all_sections.index(sect) + 1<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 self.all_sections.insert(idx, stub)<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def check_expr(self, expr: QAPIExpression) -&gt; N=
one:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if &#39;command&#39; in expr:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.returns and &#=
39;returns&#39; not in expr:<br>
&gt; diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py<br>
&gt; index cbe3b5aa91e..3abddea3525 100644<br>
&gt; --- a/scripts/qapi/schema.py<br>
&gt; +++ b/scripts/qapi/schema.py<br>
&gt; @@ -1062,6 +1062,9 @@ def connect_doc(self, doc: Optional[QAPIDoc] =3D=
 None) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.arg_type and s=
elf.arg_type.is_implicit():<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.arg=
_type.connect_doc(doc)<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.ret_type and <a hre=
f=3D"http://self.info" rel=3D"noreferrer" target=3D"_blank">self.info</a>:<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 doc.ensure_re=
turns(<a href=3D"http://self.info" rel=3D"noreferrer" target=3D"_blank">sel=
f.info</a>)<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def visit(self, visitor: QAPISchemaVisitor) -&gt; =
None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 super().visit(visitor)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 visitor.visit_command(<br>
<br>
</blockquote></div></div>
</blockquote></div></div>

--00000000000042829b0631415d44--


