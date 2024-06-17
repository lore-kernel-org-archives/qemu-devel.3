Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B70D1C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 16:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJFdD-00080T-IK; Mon, 17 Jun 2024 12:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sJFd3-0007zQ-Ff
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 12:54:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sJFcy-0000ay-5i
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 12:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718643282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u/TnhzlWtA+/Dx69mCGfbGWZSV0Xdk79Wf3VgiiAFPE=;
 b=iBRicp5r2gwHzgDeEUM0XmLWPUtrELD9kWFF4tmYDNfpPGpD+5vcSdsHs+66oFtrn5UgFF
 4PuC9A1vuSHTXjI2coQBvMjyPySKOy8tKSBgVz3L1I8SiyJt072BGqC6vLpUlRzdXnIjmw
 7fk6F+NUOMqIuN1i0sp6lQ6zNuELZcI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-979EcBOyN5u8lP9lhODPDg-1; Mon, 17 Jun 2024 12:54:40 -0400
X-MC-Unique: 979EcBOyN5u8lP9lhODPDg-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1f71d5a85f9so49050875ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 09:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718643279; x=1719248079;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u/TnhzlWtA+/Dx69mCGfbGWZSV0Xdk79Wf3VgiiAFPE=;
 b=iBYsMPhT3xyP689lVas3gz2UA6rjiaY/QaK4gWoJwP4QkgFopp3KYaIO2yJaBX2aZl
 LcghX+1B1OoOOKOkieKkXJeAS/jVuEfC820KYlTTlfLBG806VHHsw2V0/audB0wBD1mT
 APuScvdGGoYRPK9xQFd4rnZ40Ne+1dYoKvz4mqSsWE1PMNjMeOfWRrGbuk0JMwxx5vT0
 yqsMJKXEjyDGru8ceDYkxBQZCWkdYS2HDPdpeOAPPrftk9Mjxq5/+DkHG8DW53Euvibo
 xgDJpvhjqve0aLSF904IFPgdn3yz5XusSSPxFecVYqlDKFWxghDSQf1/LfaHCppxP1GY
 w1NQ==
X-Gm-Message-State: AOJu0YwHdA5ZB2J/QsAJutmoPbxTHrXPnItIX03Bxep1L17nV2ia5TPN
 7P9uA+OhBFX2Iyk3EefKoJxBxhi8OqKXWydRCq7rJEyKQ9qPXezTcVBEHFRDJzvFtBG4ks5sLlx
 qZ1mX+sQWM2JjXlBgM8W1a2kFrZRmJ6YHoqf+4Xwf00biyCYD3kqQjBjwE3ArzVuDeHisfulAtZ
 k3XRCJG12cPidU4mX0dNHWQbHOivs=
X-Received: by 2002:a17:902:e84f:b0:1f7:4021:50b2 with SMTP id
 d9443c01a7336-1f862a0925fmr104400665ad.65.1718643279238; 
 Mon, 17 Jun 2024 09:54:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5mj9EIkfPfTTBPCqBRlwNwN1xxTUB2J4K44GhLbMJgnTblzdiC/7aIRwHsjvUXVToiOM6D9QvN9pjmgy8xhk=
X-Received: by 2002:a17:902:e84f:b0:1f7:4021:50b2 with SMTP id
 d9443c01a7336-1f862a0925fmr104400415ad.65.1718643278703; Mon, 17 Jun 2024
 09:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240514215740.940155-1-jsnow@redhat.com>
 <20240514215740.940155-10-jsnow@redhat.com>
 <87tthv52ja.fsf@pond.sub.org>
In-Reply-To: <87tthv52ja.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 17 Jun 2024 12:54:26 -0400
Message-ID: <CAFn=p-YTa=z5Y5p+S+MN__kEuxf_H36K+=QPNNBdh6wEaZBrkw@mail.gmail.com>
Subject: Re: [PATCH 09/20] qapi/parser: add undocumented stub members to
 all_sections
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
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
 qemu-block@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Victor Toso de Carvalho <victortoso@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, Lukas Straub <lukasstraub2@web.de>, 
 Yanan Wang <wangyanan55@huawei.com>, Hanna Reitz <hreitz@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001f9146061b18d202"
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

--0000000000001f9146061b18d202
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 4:53=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This helps simplify the doc generator if it doesn't have to check for
> > undocumented members.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/parser.py | 20 ++++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)
> >
> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> > index b1794f71e12..3cd8e7ee295 100644
> > --- a/scripts/qapi/parser.py
> > +++ b/scripts/qapi/parser.py
> > @@ -740,8 +740,24 @@ def connect_member(self, member:
> 'QAPISchemaMember') -> None:
> >                  raise QAPISemError(member.info,
> >                                     "%s '%s' lacks documentation"
> >                                     % (member.role, member.name))
> > -            self.args[member.name] =3D QAPIDoc.ArgSection(
> > -                self.info, '@' + member.name, 'member')
> > +
> > +            # Insert stub documentation section for missing member doc=
s.
> > +            section =3D QAPIDoc.ArgSection(
> > +                self.info, f"@{member.name}", "member")
>
> Although I like f-strings in general, I'd pefer to stick to '@' +
> member.name here, because it's simpler.
>

Tomayto, Tomahto. (OK.)


>
> Also, let's not change 'member' to "member".  Existing practice: single
> quotes for string literals unless double quotes avoid escapes.  Except
> English prose (like error messages) is always in double quotes.
>

OK. I realize I'm not consistent in this patch either, but I'll explain
that my using double quotes here is a black-ism that is sneaking in the
more I use it to auto-format my patches :)

Maybe time for a flag day when I move scripts/qapi to python/qemu/qapi ...

(Sorry, this type of stuff is ... invisible to me, and I really do rely on
the linters to make sure I don't do this kind of thing.)


>
> > +            self.args[member.name] =3D section
> > +
> > +            # Determine where to insert stub doc.
>
> If we have some member documentation, the member doc stubs clearly must
> go there.  Inserting them at the end makes sense.
>
> Else we want to put them where the parser would accept real member
> documentation.
>
> "The parser" is .get_doc().  This is what it accepts (I'm prepared to
> explain this in detail if necessary):
>
>     One untagged section
>
>     Member documentation, if any
>
>     Zero ore more tagged or untagged sections
>
>     Feature documentation, if any
>
>     Zero or more tagged or untagged sections
>
> If we there is no member documentation, this is
>
>     One untagged section
>
>     Zero ore more tagged or untagged sections
>
>     Feature documentation, if any
>
>     Zero or more tagged or untagged sections
>
> Note that we cannot have two adjacent untagged sections (we only create
> one if the current section isn't untagged; if it is, we extend it
> instead).  Thus, the second section must be tagged or feature
> documentation.
>
> Therefore, the member doc stubs must go right after the first section.
>
> This is also where qapidoc.py inserts member documentation.
>
> > +            index =3D 0
> > +            for i, sect in enumerate(self.all_sections):
> > +                # insert after these:
> > +                if sect.kind in ('intro-paragraph', 'member'):
> > +                    index =3D i + 1
> > +                # but before these:
> > +                elif sect.kind in ('tagged', 'feature',
> 'outro-paragraph'):
> > +                    index =3D i
> > +                    break
>
> Can you describe what this does in English?  As a specification; simply
> paraphrasing the code is cheating.  I tried, and gave up.
>

It inserts after any intro-paragraph or member section it finds, but before
any tagged, feature, or outro-paragraph it finds.

The loop breaks on the very first instance of tagged/feature/outro, exiting
immediately and leaving the insertion index set to the first occurrence of
such a section, so that the insertion will place the member documentation
prior to that section.

The loop doesn't break when it finds intro-paragraph or members, so it'll
continue to tick upwards until it reaches the end of the list or it finds
something disqualifying.


>
> Above, I derived what I believe we need to do.  It's simple enough: if
> we have member documentation, it starts right after the first (untagged)
> section, and the stub goes to the end of the member documentation.
> Else, the stub goes right after the first section.
>
> Code:
>
>             index =3D 1;
>             while self.all_sections[index].kind =3D=3D 'member':
>                 index +=3D 1
>

Wellp, yeah. That's certainly less code :)

I tossed in your algorithm alongside mine and asserted they were always
equal, and they are, so... yup. I think the only possible concern here is
if there is precisely one and only one section and 1 is beyond EOL, but
that's easy to fix. It apparently doesn't happen in practice, but I can't
presently imagine why it *couldn't* happen.

I'll just write a comment explaining the assumptions that make your algo
work (intro section always guaranteed even if empty; intro sections always
collapse into one section, members must start at i:=3D1 if they exist at al=
l,
members must be contiguous.)


>
> Of course future patches I haven't seen might change the invariants in
> ways that break my simple code.  We'll see.
>
> > +            self.all_sections.insert(index, section)
> > +
> >          self.args[member.name].connect(member)
> >
> >      def connect_feature(self, feature: 'QAPISchemaFeature') -> None:
>
>
Now, for a critique of my own patch: this patch makes it difficult to audit
all of the cases where intro vs outro paragraphs sections may be ambiguous
because we automatically add members sections, so the warning yap I add
later on catches less cases.

It's possible we may want to add a warning yap about paragraph ambiguity
directly to the parser, OR just decide we don't really care and we just
*assume* and that it's fine.

We can discuss this pointedly on a call next time, and I'll come prepared
with examples and line numbers.... Or, if you'd prefer, you can get a
written report so you can take your time reading in silence.

--js

--0000000000001f9146061b18d202
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 14, 2024 at 4:53=E2=80=AF=
AM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank">jsn=
ow@redhat.com</a>&gt; writes:<br>
<br>
&gt; This helps simplify the doc generator if it doesn&#39;t have to check =
for<br>
&gt; undocumented members.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 scripts/qapi/parser.py | 20 ++++++++++++++++++--<br>
&gt;=C2=A0 1 file changed, 18 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py<br>
&gt; index b1794f71e12..3cd8e7ee295 100644<br>
&gt; --- a/scripts/qapi/parser.py<br>
&gt; +++ b/scripts/qapi/parser.py<br>
&gt; @@ -740,8 +740,24 @@ def connect_member(self, member: &#39;QAPISchemaM=
ember&#39;) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise QA=
PISemError(<a href=3D"http://member.info" rel=3D"noreferrer" target=3D"_bla=
nk">member.info</a>,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;%s &#39=
;%s&#39; lacks documentation&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0% (member.rol=
e, <a href=3D"http://member.name" rel=3D"noreferrer" target=3D"_blank">memb=
er.name</a>))<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.args[<a href=3D"http:/=
/member.name" rel=3D"noreferrer" target=3D"_blank">member.name</a>] =3D QAP=
IDoc.ArgSection(<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"ht=
tp://self.info" rel=3D"noreferrer" target=3D"_blank">self.info</a>, &#39;@&=
#39; + <a href=3D"http://member.name" rel=3D"noreferrer" target=3D"_blank">=
member.name</a>, &#39;member&#39;)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Insert stub documentation=
 section for missing member docs.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 section =3D QAPIDoc.ArgSect=
ion(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"ht=
tp://self.info" rel=3D"noreferrer" target=3D"_blank">self.info</a>, f&quot;=
@{<a href=3D"http://member.name" rel=3D"noreferrer" target=3D"_blank">membe=
r.name</a>}&quot;, &quot;member&quot;)<br>
<br>
Although I like f-strings in general, I&#39;d pefer to stick to &#39;@&#39;=
 +<br>
<a href=3D"http://member.name" rel=3D"noreferrer" target=3D"_blank">member.=
name</a> here, because it&#39;s simpler.<br></blockquote><div><br></div><di=
v>Tomayto, Tomahto. (OK.)<br></div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
<br>
Also, let&#39;s not change &#39;member&#39; to &quot;member&quot;.=C2=A0 Ex=
isting practice: single<br>
quotes for string literals unless double quotes avoid escapes.=C2=A0 Except=
<br>
English prose (like error messages) is always in double quotes.<br></blockq=
uote><div><br></div>OK. I realize I&#39;m not consistent in this patch eith=
er, but I&#39;ll explain that my using double quotes here is a black-ism th=
at is sneaking in the more I use it to auto-format my patches :)</div><div =
class=3D"gmail_quote"><br></div><div class=3D"gmail_quote">Maybe time for a=
 flag day when I move scripts/qapi to python/qemu/qapi ...</div><div class=
=3D"gmail_quote"><br></div><div class=3D"gmail_quote">(Sorry, this type of =
stuff is ... invisible to me, and I really do rely on the linters to make s=
ure I don&#39;t do this kind of thing.)<br></div><div class=3D"gmail_quote"=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.args[<a href=3D"http:/=
/member.name" rel=3D"noreferrer" target=3D"_blank">member.name</a>] =3D sec=
tion<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Determine where to insert=
 stub doc.<br>
<br>
If we have some member documentation, the member doc stubs clearly must<br>
go there.=C2=A0 Inserting them at the end makes sense.<br>
<br>
Else we want to put them where the parser would accept real member<br>
documentation.<br>
<br>
&quot;The parser&quot; is .get_doc().=C2=A0 This is what it accepts (I&#39;=
m prepared to<br>
explain this in detail if necessary):<br>
<br>
=C2=A0 =C2=A0 One untagged section<br>
<br>
=C2=A0 =C2=A0 Member documentation, if any<br>
<br>
=C2=A0 =C2=A0 Zero ore more tagged or untagged sections<br>
<br>
=C2=A0 =C2=A0 Feature documentation, if any<br>
<br>
=C2=A0 =C2=A0 Zero or more tagged or untagged sections<br>
<br>
If we there is no member documentation, this is<br>
<br>
=C2=A0 =C2=A0 One untagged section<br>
<br>
=C2=A0 =C2=A0 Zero ore more tagged or untagged sections<br>
<br>
=C2=A0 =C2=A0 Feature documentation, if any<br>
<br>
=C2=A0 =C2=A0 Zero or more tagged or untagged sections<br>
<br>
Note that we cannot have two adjacent untagged sections (we only create<br>
one if the current section isn&#39;t untagged; if it is, we extend it<br>
instead).=C2=A0 Thus, the second section must be tagged or feature<br>
documentation.<br>
<br>
Therefore, the member doc stubs must go right after the first section.<br>
<br>
This is also where qapidoc.py inserts member documentation.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 index =3D 0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for i, sect in enumerate(se=
lf.all_sections):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # insert afte=
r these:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if sect.kind =
in (&#39;intro-paragraph&#39;, &#39;member&#39;):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 index =3D i + 1<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # but before =
these:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif sect.kin=
d in (&#39;tagged&#39;, &#39;feature&#39;, &#39;outro-paragraph&#39;):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 index =3D i<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 break<br>
<br>
Can you describe what this does in English?=C2=A0 As a specification; simpl=
y<br>
paraphrasing the code is cheating.=C2=A0 I tried, and gave up.<br></blockqu=
ote><div><br></div><div>It inserts after any intro-paragraph or member sect=
ion it finds, but before any tagged, feature, or outro-paragraph it finds.<=
/div><div><br></div><div>The loop breaks on the very first instance of tagg=
ed/feature/outro, exiting immediately and leaving the insertion index set t=
o the first occurrence of such a section, so that the insertion will place =
the member documentation prior to that section.</div><div><br></div><div>Th=
e loop doesn&#39;t break when it finds intro-paragraph or members, so it&#3=
9;ll continue to tick upwards until it reaches the end of the list or it fi=
nds something disqualifying.<br></div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
<br>
Above, I derived what I believe we need to do.=C2=A0 It&#39;s simple enough=
: if<br>
we have member documentation, it starts right after the first (untagged)<br=
>
section, and the stub goes to the end of the member documentation.<br>
Else, the stub goes right after the first section.<br>
<br>
Code:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 index =3D 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while self.all_sections[index].ki=
nd =3D=3D &#39;member&#39;:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 index +=3D 1<br></b=
lockquote><div><br></div><div>Wellp, yeah. That&#39;s certainly less code :=
)</div><div><br></div><div>I tossed in your algorithm alongside mine and as=
serted they were always equal, and they are, so... yup. I think the only po=
ssible concern here is if there is precisely one and only one section and 1=
 is beyond EOL, but that&#39;s easy to fix. It apparently doesn&#39;t happe=
n in practice, but I can&#39;t presently imagine why it *couldn&#39;t* happ=
en.</div><div><br></div><div>I&#39;ll just write a comment explaining the a=
ssumptions that make your algo work (intro section always guaranteed even i=
f empty; intro sections always collapse into one section, members must star=
t at i:=3D1 if they exist at all, members must be contiguous.)<br></div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Of course future patches I haven&#39;t seen might change the invariants in<=
br>
ways that break my simple code.=C2=A0 We&#39;ll see.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.all_sections.insert(in=
dex, section)<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.args[<a href=3D"http://member.n=
ame" rel=3D"noreferrer" target=3D"_blank">member.name</a>].connect(member)<=
br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def connect_feature(self, feature: &#39;QAPISchema=
Feature&#39;) -&gt; None:<br>
<br></blockquote><div><br></div><div>Now, for a critique of my own patch: t=
his patch makes it difficult to audit all of the cases where intro vs outro=
 paragraphs sections may be ambiguous because we automatically add members =
sections, so the warning yap I add later on catches less cases.</div><div><=
br></div><div>It&#39;s possible we may want to add a warning yap about para=
graph ambiguity directly to the parser, OR just decide we don&#39;t really =
care and we just *assume* and that it&#39;s fine.</div><div><br></div><div>=
We can discuss this pointedly on a call next time, and I&#39;ll come prepar=
ed with examples and line numbers.... Or, if you&#39;d prefer, you can get =
a written report so you can take your time reading in silence.</div><div><b=
r></div><div>--js<br></div></div></div>

--0000000000001f9146061b18d202--


