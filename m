Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841F1C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 15:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7chX-0002FL-R5; Thu, 16 May 2024 11:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s7chM-0002C6-FT
 for qemu-devel@nongnu.org; Thu, 16 May 2024 11:07:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s7chK-0000JE-1S
 for qemu-devel@nongnu.org; Thu, 16 May 2024 11:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715872028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zb7NUAjzmp8xidHQ8QBCDWrEUZjnzdWpi9oloryxP64=;
 b=DS97wBdHxoDUtEuXIy5PR5dJRx5ck06y8QCeZLOxQ4bXS2gIyO1cAt0mdg1MpbhSrhcB3M
 vAe0/Jr/h5KHyTZYDUd15nzDhILxrWWrEhGtaz0VxyZS45xDW6lK4Sd/hlw1uuarN+ACpp
 C3GdksJHpEIAcqN0r0yFDE9NeANf3qs=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-vREKiVZ9NDuKGg12wwLXYw-1; Thu, 16 May 2024 11:07:06 -0400
X-MC-Unique: vREKiVZ9NDuKGg12wwLXYw-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2b3717c5decso7155075a91.2
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 08:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715872024; x=1716476824;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zb7NUAjzmp8xidHQ8QBCDWrEUZjnzdWpi9oloryxP64=;
 b=PsdORoDRVHbL7rPTARmtYdYMUkWalWEAVHnLke0k6RjUVUtmpL4kSBrYIgfRMgWNLJ
 ojv9f8TN2DkiZtTZIFly1WhkuQZZRMe/3NwP33eKeemZXLYDJ//aiLSbUt+Ki3Xjw60m
 KVPHvEUeK6e+lIsivbyY6s0kROCEkw3251Qswi+GX9HADs8JaT0EZHPug6xFLHM3c6JK
 5l/w5hdhy/fIL7hQvwzh3Nzsb1XGbC8YJiTN9xIXGIAnS9wyXC+F8CShbcJvQ3o6UyXv
 myFziDqIN6ySGgkHCM59J859QVFnNjax7c27fEaVlxZahlp0OVLKU4/JWuKmq2sLdrft
 /Prg==
X-Gm-Message-State: AOJu0Yxls9Xzhvj5476GBbdL6wJ8iHYv5+zRt5Xghjw/qy1vt5ousVp+
 uzGJwss1AHoXBfDoRzmkw5NOUruiWUVb6VivfvaRrhpUXNyYyk3/K4WGiWNyWGx1xcSHEBzAfRv
 S/iv6Pt7IcphYYR6d81b1C5zxXBuja6KYuJsFOCMxLdV7GoYn1GbN9hZBCQqHC0V9h/F8PwYiMr
 DE3C8dNCtuvi9xPAWFrreOtdOYFX2dwO7xsns=
X-Received: by 2002:a17:90a:296:b0:2b3:463d:992b with SMTP id
 98e67ed59e1d1-2b6ccef6431mr16936827a91.42.1715872023765; 
 Thu, 16 May 2024 08:07:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5r0Cso4UPRMv2OYq1lt+lWYSpR1tG88Ke8nGMSJWR8FvZRMq8J33+UyLQhevzkm0jtWQzw2dJQ3d+NE5KPmQ=
X-Received: by 2002:a17:90a:296:b0:2b3:463d:992b with SMTP id
 98e67ed59e1d1-2b6ccef6431mr16936757a91.42.1715872022975; Thu, 16 May 2024
 08:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240514215740.940155-1-jsnow@redhat.com>
 <20240514215740.940155-9-jsnow@redhat.com>
 <87a5kqnlr1.fsf@pond.sub.org>
In-Reply-To: <87a5kqnlr1.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 16 May 2024 11:06:50 -0400
Message-ID: <CAFn=p-Zx56Hbx+4Tn6DSOm7YAO72PTVouj0TbLJObFCc6At3zg@mail.gmail.com>
Subject: Re: [PATCH 08/20] qapi/parser: differentiate intro and outro
 paragraphs
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
Content-Type: multipart/alternative; boundary="00000000000069005606189396fd"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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

--00000000000069005606189396fd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024, 5:34=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Add a semantic tag to paragraphs that appear *before* tagged
> > sections/members/features and those that appear after. This will contro=
l
> > how they are inlined when doc sections are merged and flattened.
>
> This future use is not obvious to me now.  I guess the effective way to
> help me see it is actual patches, which will come in due time.
>

Head recursion and tail recursion, respectively :)

* intro
* inherited intro
* members [ancestor-descendent]
* features [ancestor-descendent]
* inherited outro
* outro

Child gets the first and final words. Inherited stuff goes in the sandwich
fillings.

It feels like a simple rule that's easy to internalize. As a bonus, you can
explain it by analogy to Americans as a burger, which is the only metaphor
we understand.


> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/parser.py | 22 +++++++++++++++++-----
> >  1 file changed, 17 insertions(+), 5 deletions(-)
> >
> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> > index cf4cbca1c1f..b1794f71e12 100644
> > --- a/scripts/qapi/parser.py
> > +++ b/scripts/qapi/parser.py
> > @@ -503,6 +503,10 @@ def get_doc(self) -> 'QAPIDoc':
> >              self.accept(False)
> >              line =3D self.get_doc_line()
> >              no_more_args =3D False
> > +            # Paragraphs before members/features/tagged are "intro"
> paragraphs.
> > +            # Any appearing subsequently are "outro" paragraphs.
> > +            # This is only semantic metadata for the doc generator.
>
> Not sure about the last sentence.  Isn't it true for almost everything
> around here?
>

I guess I was trying to say "There's no real difference between the two
mechanically, it's purely based on where it appears in the doc block, which
offers only a heuristic for its semantic value- introductory statements or
additional detail."

In my mind: the other "kind" values have some more mechanical difference to
them, but intro/outro don't.


> Also, long line.
>
> > +            intro =3D True
> >
> >              while line is not None:
> >                  # Blank lines
> > @@ -532,6 +536,7 @@ def get_doc(self) -> 'QAPIDoc':
> >                          raise QAPIParseError(
> >                              self, 'feature descriptions expected')
> >                      no_more_args =3D True
> > +                    intro =3D False
>
> After feature descriptions.
>
> >                  elif match :=3D self._match_at_name_colon(line):
> >                      # description
> >                      if no_more_args:
> > @@ -547,6 +552,7 @@ def get_doc(self) -> 'QAPIDoc':
> >                              doc.append_line(text)
> >                          line =3D self.get_doc_indented(doc)
> >                      no_more_args =3D True
> > +                    intro =3D False
>
> Or after member descriptions.
>
> >                  elif match :=3D re.match(
> >                          r'(Returns|Errors|Since|Notes?|Examples?|TODO)=
:
> *',
> >                          line):
> > @@ -557,13 +563,14 @@ def get_doc(self) -> 'QAPIDoc':
> >                          doc.append_line(text)
> >                      line =3D self.get_doc_indented(doc)
> >                      no_more_args =3D True
> > +                    intro =3D False
>
> Or after the first tagged section.
>
> Okay, it does what it says on the tin.
>
> >                  elif line.startswith('=3D'):
> >                      raise QAPIParseError(
> >                          self,
> >                          "unexpected '=3D' markup in definition
> documentation")
> >                  else:
> >                      # tag-less paragraph
> > -                    doc.ensure_untagged_section(self.info)
> > +                    doc.ensure_untagged_section(self.info, intro)
> >                      doc.append_line(line)
> >                      line =3D self.get_doc_paragraph(doc)
> >          else:
> > @@ -617,7 +624,7 @@ def __init__(
> >              self,
> >              info: QAPISourceInfo,
> >              tag: Optional[str] =3D None,
> > -            kind: str =3D 'paragraph',
> > +            kind: str =3D 'intro-paragraph',
>
> The question "why is this optional?" crossed my mind when reviewing the
> previous patch.  I left it unasked, because I felt challenging the
> overlap between @kind and @tag was more useful.  However, the new
> default value 'intro-paragraph' feels more arbitrary to me than the old
> one 'paragraph', and that makes the question pop right back into my
> mind.
>

Just "don't break API" habit, nothing more. I can make it mandatory.


> Unless I'm mistaken, all calls but one @tag and @kind.  Making that one
> pass it too feels simpler to me.
>
> Moot if we fuse @tag and @kind, of course.


> >          ):
> >              # section source info, i.e. where it begins
> >              self.info =3D info
> > @@ -625,7 +632,7 @@ def __init__(
> >              self.tag =3D tag
> >              # section text without tag
> >              self.text =3D ''
> > -            # section type - {paragraph, feature, member, tagged}
> > +            # section type - {<intro|outro>-paragraph, feature, member=
,
> tagged}
>
> Long line.


Oops, default for black is longer. Forgot to enable the "I still use email
patches as part of my penance" setting


> >              self.kind =3D kind
> >
> >          def append_line(self, line: str) -> None:
> > @@ -666,7 +673,11 @@ def end(self) -> None:
> >                  raise QAPISemError(
> >                      section.info, "text required after '%s:'" %
> section.tag)
> >
> > -    def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
> > +    def ensure_untagged_section(
> > +        self,
> > +        info: QAPISourceInfo,
> > +        intro: bool =3D True,
>
> Two callers, one passes @info, one doesn't.  Passing it always might be
> simpler.
>

Okeydokey.


> > +    ) -> None:
> >          if self.all_sections and not self.all_sections[-1].tag:
> >              section =3D self.all_sections[-1]
> >              # Section is empty so far; update info to start *here*.
> > @@ -677,7 +688,8 @@ def ensure_untagged_section(self, info:
> QAPISourceInfo) -> None:
> >                  self.all_sections[-1].text +=3D '\n'
> >              return
> >          # start new section
> > -        section =3D self.Section(info)
> > +        kind =3D ("intro" if intro else "outro") + "-paragraph"
> > +        section =3D self.Section(info, kind=3Dkind)
> >          self.sections.append(section)
> >          self.all_sections.append(section)
>
>

--00000000000069005606189396fd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, May 16, 2024, 5:34=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:js=
now@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&g=
t; writes:<br>
<br>
&gt; Add a semantic tag to paragraphs that appear *before* tagged<br>
&gt; sections/members/features and those that appear after. This will contr=
ol<br>
&gt; how they are inlined when doc sections are merged and flattened.<br>
<br>
This future use is not obvious to me now.=C2=A0 I guess the effective way t=
o<br>
help me see it is actual patches, which will come in due time.<br></blockqu=
ote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Head recursio=
n and tail recursion, respectively :)</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">* intro</div><div dir=3D"auto">* inherited intro</div><div di=
r=3D"auto">* members [ancestor-descendent]</div><div dir=3D"auto">* feature=
s [ancestor-descendent]</div><div dir=3D"auto">* inherited outro</div><div =
dir=3D"auto">* outro</div><div dir=3D"auto"><br></div><div dir=3D"auto">Chi=
ld gets the first and final words. Inherited stuff goes in the sandwich fil=
lings.</div><div dir=3D"auto"><br></div><div dir=3D"auto">It feels like a s=
imple rule that&#39;s easy to internalize. As a bonus, you can explain it b=
y analogy to Americans as a burger, which is the only metaphor we understan=
d.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_q=
uote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">
<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 scripts/qapi/parser.py | 22 +++++++++++++++++-----<br>
&gt;=C2=A0 1 file changed, 17 insertions(+), 5 deletions(-)<br>
&gt;<br>
&gt; diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py<br>
&gt; index cf4cbca1c1f..b1794f71e12 100644<br>
&gt; --- a/scripts/qapi/parser.py<br>
&gt; +++ b/scripts/qapi/parser.py<br>
&gt; @@ -503,6 +503,10 @@ def get_doc(self) -&gt; &#39;QAPIDoc&#39;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.accept(False)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 line =3D self.get_doc_=
line()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 no_more_args =3D False=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Paragraphs before members=
/features/tagged are &quot;intro&quot; paragraphs.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Any appearing subsequentl=
y are &quot;outro&quot; paragraphs.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # This is only semantic met=
adata for the doc generator.<br>
<br>
Not sure about the last sentence.=C2=A0 Isn&#39;t it true for almost everyt=
hing<br>
around here?<br></blockquote></div></div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">I guess I was trying to say &quot;There&#39;s no real differenc=
e between the two mechanically, it&#39;s purely based on where it appears i=
n the doc block, which offers only a heuristic for its semantic value- intr=
oductory statements or additional detail.&quot;</div><div dir=3D"auto"><br>=
</div><div dir=3D"auto">In my mind: the other &quot;kind&quot; values have =
some more mechanical difference to them, but intro/outro don&#39;t.</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">
<br>
Also, long line.=C2=A0 <br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 intro =3D True<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while line is not None=
:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Blank =
lines<br>
&gt; @@ -532,6 +536,7 @@ def get_doc(self) -&gt; &#39;QAPIDoc&#39;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 raise QAPIParseError(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self, &#39;feature descriptions expected=
&#39;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 no_more_args =3D True<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 intro =3D False<br>
<br>
After feature descriptions.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif mat=
ch :=3D self._match_at_name_colon(line):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 # description<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if no_more_args:<br>
&gt; @@ -547,6 +552,7 @@ def get_doc(self) -&gt; &#39;QAPIDoc&#39;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 doc.append_line(text)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 line =3D self.get_doc_indented(doc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 no_more_args =3D True<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 intro =3D False<br>
<br>
Or after member descriptions.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif mat=
ch :=3D re.match(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 r&#39;(Returns|Errors|Since|Notes?|Examples?|TODO): *&=
#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 line):<br>
&gt; @@ -557,13 +563,14 @@ def get_doc(self) -&gt; &#39;QAPIDoc&#39;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 doc.append_line(text)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 line =3D self.get_doc_indented(doc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 no_more_args =3D True<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 intro =3D False<br>
<br>
Or after the first tagged section.<br>
<br>
Okay, it does what it says on the tin.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif lin=
e.startswith(&#39;=3D&#39;):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 raise QAPIParseError(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 self,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &quot;unexpected &#39;=3D&#39; markup in definition do=
cumentation&quot;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 # tag-less paragraph<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 doc.ensure_untagged_section(<a href=3D"http://self.info" rel=3D"noreferrer=
 noreferrer" target=3D"_blank">self.info</a>)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 doc.ensure_untagged_section(<a href=3D"http://self.info" rel=3D"noreferrer=
 noreferrer" target=3D"_blank">self.info</a>, intro)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 doc.append_line(line)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 line =3D self.get_doc_paragraph(doc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; @@ -617,7 +624,7 @@ def __init__(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info: QAPISourceInfo,<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tag: Optional[str] =3D=
 None,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kind: str =3D &#39;paragrap=
h&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kind: str =3D &#39;intro-pa=
ragraph&#39;,<br>
<br>
The question &quot;why is this optional?&quot; crossed my mind when reviewi=
ng the<br>
previous patch.=C2=A0 I left it unasked, because I felt challenging the<br>
overlap between @kind and @tag was more useful.=C2=A0 However, the new<br>
default value &#39;intro-paragraph&#39; feels more arbitrary to me than the=
 old<br>
one &#39;paragraph&#39;, and that makes the question pop right back into my=
<br>
mind.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Just &quot;don&#39;t break API&quot; habit, nothing more. I can make i=
t mandatory.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Unless I&#39;m mistaken, all calls but one @tag and @kind.=C2=A0 Making tha=
t one<br>
pass it too feels simpler to me.<br>
<br>
Moot if we fuse @tag and @kind, of course.</blockquote></div></div><div dir=
=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ):<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # section source info,=
 i.e. where it begins<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://self=
.info" rel=3D"noreferrer noreferrer" target=3D"_blank">self.info</a> =3D in=
fo<br>
&gt; @@ -625,7 +632,7 @@ def __init__(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.tag =3D tag<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # section text without=
 tag<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.text =3D &#39;&#3=
9;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # section type - {paragraph=
, feature, member, tagged}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # section type - {&lt;intro=
|outro&gt;-paragraph, feature, member, tagged}<br>
<br>
Long line.</blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">Oops, default for black is longer. Forgot to enable the &quot;I still=
 use email patches as part of my penance&quot; setting</div><div dir=3D"aut=
o"></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_=
quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.kind =3D kind<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 def append_line(self, line: str) -&g=
t; None:<br>
&gt; @@ -666,7 +673,11 @@ def end(self) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise QA=
PISemError(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 <a href=3D"http://section.info" rel=3D"noreferrer noreferrer" target=
=3D"_blank">section.info</a>, &quot;text required after &#39;%s:&#39;&quot;=
 % section.tag)<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 def ensure_untagged_section(self, info: QAPISourceInfo)=
 -&gt; None:<br>
&gt; +=C2=A0 =C2=A0 def ensure_untagged_section(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 info: QAPISourceInfo,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 intro: bool =3D True,<br>
<br>
Two callers, one passes @info, one doesn&#39;t.=C2=A0 Passing it always mig=
ht be<br>
simpler.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Okeydokey.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><di=
v class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 ) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.all_sections and not self.al=
l_sections[-1].tag:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 section =3D self.all_s=
ections[-1]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Section is empty so =
far; update info to start *here*.<br>
&gt; @@ -677,7 +688,8 @@ def ensure_untagged_section(self, info: QAPISource=
Info) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.all=
_sections[-1].text +=3D &#39;\n&#39;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # start new section<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 section =3D self.Section(info)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 kind =3D (&quot;intro&quot; if intro else=
 &quot;outro&quot;) + &quot;-paragraph&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 section =3D self.Section(info, kind=3Dkin=
d)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.sections.append(section)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.all_sections.append(section)<br=
>
<br>
</blockquote></div></div></div>

--00000000000069005606189396fd--


