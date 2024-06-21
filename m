Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BFCC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 21:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKler-00069s-W3; Fri, 21 Jun 2024 17:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sKleq-00069Q-NL
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 17:18:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sKlem-0005Dm-8l
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 17:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719004730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ozw32guPL+3y4/NUoaBxDilGceb6uAFN8PfFC6WsVcU=;
 b=QTiaJlnUQzty+B6u9/EIWn2uQNaR4mEzCVTEGp1OTbKbveLqVJkM7mNFMac0huKCTBxY6f
 80ZKRFD4mQ9hj71jRHkoB+ixshIm6jlk0ABsfnLn/OzxaUo272xOq5EM/WPfOJsBeRHfm5
 VNYeaADUyWEmo8hI8fY206xH2RQZcvw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-AlK-D99UP-KlxpViakwfrA-1; Fri, 21 Jun 2024 17:18:48 -0400
X-MC-Unique: AlK-D99UP-KlxpViakwfrA-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2bffbc8ad81so2369608a91.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 14:18:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719004728; x=1719609528;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ozw32guPL+3y4/NUoaBxDilGceb6uAFN8PfFC6WsVcU=;
 b=I4woywzMamFuDn891MJ9SlZFBdlYCa+2payJR0rdip/1NAD4BYB01yKNVHGU5FNBYj
 ES0lBPPOZUYb3iKhEVSiSAE3qbBz9jKUbO6SBudJIZZMFmbtUBfB6gQKrbWKIDCjL0HU
 0AIQkCVYmMBMp9t2su4q5YzVeCLsqIyKV7i6GMuqWZamHyiYZqCxfpONifxD9XkiamvJ
 FOLTDrXWoqv4y6+UF+UtOYzOGtKgLPh9jfWU/LIg6sFhTpOa2CAMrrhJxQrbhEcv5Gmi
 aOuiTkUzWQktr4oNe6ym06vVS0rrbaReJKpdeZi/dFmCb6HA4jlaVLIJas/yFcqjlXrR
 a0qg==
X-Gm-Message-State: AOJu0YybKTeH5OrQbh+/WcPLdgGOgC1vrG4yJHEDGqr2Qi9rfc5gUBuC
 U6y6AyZxwnY1EpXcU6I8vek2gXDSvjL8oe2E1LsQ3Zt6o6ubuyJ3qC/ZXyxp2YTrwUYSCgy/ZgV
 AyBR1J/BiXk+V7gcVrYrEBAvGhokNdnBbX0AKj+jI4AATvK7d1ziQuJ1K6o+O+ppBIBjxlZDQPZ
 5Z8bqnMcRZtQCFHhJrIkpscwC6cik=
X-Received: by 2002:a17:90a:ce88:b0:2c7:b194:687e with SMTP id
 98e67ed59e1d1-2c7b5dae24bmr9156912a91.42.1719004727764; 
 Fri, 21 Jun 2024 14:18:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNMoQ2tB66Z6ZisrFYPJzXzXiMmjIxP/FaxnqU8nZAhvjdQ8zm1qd7A24rl9c9fbJUhvy6MqhFSbAdOFV8tBM=
X-Received: by 2002:a17:90a:ce88:b0:2c7:b194:687e with SMTP id
 98e67ed59e1d1-2c7b5dae24bmr9156881a91.42.1719004727339; Fri, 21 Jun 2024
 14:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240514215740.940155-1-jsnow@redhat.com>
 <20240514215740.940155-6-jsnow@redhat.com>
 <87a5kqpaaw.fsf@pond.sub.org>
 <CAFn=p-abjRbSvcHPSUorp80SZaf5Xwi89WtvhebXK_SRw3Cg4w@mail.gmail.com>
 <87a5kbcvqm.fsf@pond.sub.org>
In-Reply-To: <87a5kbcvqm.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 21 Jun 2024 17:18:35 -0400
Message-ID: <CAFn=p-bjMz+sC97kRFjb+hnuYm6BTtrYQ6rd7G_5H5g8qmjp+w@mail.gmail.com>
Subject: Re: [PATCH 05/20] qapi/parser: adjust info location for doc body
 section
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
Content-Type: multipart/alternative; boundary="000000000000240a41061b6cfa16"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000240a41061b6cfa16
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 7:58=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > On Thu, May 16, 2024, 1:58=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com>
> wrote:
> >
> >> John Snow <jsnow@redhat.com> writes:
> >>
> >> > Instead of using the info object for the doc block as a whole, updat=
e
> >> > the info pointer for each call to ensure_untagged_section when the
> >> > existing section is otherwise empty. This way, Sphinx error
> information
> >> > will match precisely to where the text actually starts.
> >> >
> >> > Signed-off-by: John Snow <jsnow@redhat.com>
> >> > ---
> >> >  scripts/qapi/parser.py | 9 +++++++--
> >> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> >> > index 8cdd5334ec6..41b9319e5cb 100644
> >> > --- a/scripts/qapi/parser.py
> >> > +++ b/scripts/qapi/parser.py
> >> > @@ -662,8 +662,13 @@ def end(self) -> None:
> >> >
> >> >      def ensure_untagged_section(self, info: QAPISourceInfo) -> None=
:
> >> >          if self.all_sections and not self.all_sections[-1].tag:
> >> > -            # extend current section
> >> > -            self.all_sections[-1].text +=3D '\n'
> >>
> >> Before, we always append a newline.
> >>
> >> > +            section =3D self.all_sections[-1]
> >> > +            # Section is empty so far; update info to start *here*.
> >> > +            if not section.text:
> >> > +                section.info =3D info
> >> > +            else:
> >> > +                # extend current section
> >> > +                self.all_sections[-1].text +=3D '\n'
> >>
> >> Afterwards, we append it only when the section already has some text.
> >>
> >> The commit message claims the patch only adjusts section.info.  That's
> a
> >> lie :)
> >>
> >
> > Well. It wasn't intentional, so it wasn't a lie... it was just wrong :)
> >
> >
> >> I believe the change makes no difference because .end() strips leading
> >> and trailing newline.
> >>
> >> >              return
> >> >          # start new section
> >> >          section =3D self.Section(info)
> >>
> >> You could fix the commit message, but I think backing out the
> >> no-difference change is easier.  The appended patch works in my testin=
g.
> >>
> >> Next one.  Your patch changes the meaning of section.info.  Here's its
> >> initialization:
> >>
> >>     class Section:
> >>         # pylint: disable=3Dtoo-few-public-methods
> >>         def __init__(self, info: QAPISourceInfo,
> >>                      tag: Optional[str] =3D None):
> >> --->        # section source info, i.e. where it begins
> >>             self.info =3D info
> >>             # section tag, if any ('Returns', '@name', ...)
> >>             self.tag =3D tag
> >>             # section text without tag
> >>             self.text =3D ''
> >>
> >> The comment is now wrong.  Calls for a thorough review of .info's uses=
.
> >>
> >
> > Hmm... Did I really change its meaning? I guess it's debatable what
> "where
> > it begins" means. Does the tagless section start...
> >
> > ## <-- Here?
> > # Hello! <-- Or here?
> > ##
> >
> > I assert the *section* starts wherever the first line of text it contai=
ns
> > starts. Nothing else makes any sense.
> >
> > There is value in recording where the doc block starts, but that's not =
a
> > task for the *section* info.
> >
> > I don't think I understand your feedback.
>
> This was before my vacation, and my memory is foggy, ...  I may have
> gotten confused back then.  Let me have a fresh look now.
>
> self.info gets initialized in Section.__init__() to whatever info it
> gets passed.
>
> Your patch makes .ensure_untagged_section() overwrite this Section.info
> when it extends an untagged section that is still empty.  Hmmm.  I'd
> prefer .info to remain constant after initialization.
>

but, we don't have the right info when we initialize the entire QAPIDoc
object, because the section hasn't truly actually started yet, so I don't
think I can actually achieve your preference.


>
> I figure this overwrite can happen only when extenting the body section
> QAPIDoc.__init__() creates.  In that case, it adjusts .info from
> beginning of doc comment to first non-blank line.
>

Yes, that's the intended effect and in practice, the only time it actually
happens.

This patch is necessary for accurate error reporting info, otherwise we get
off-by-ones (or more, maybe). I believe the problem actually affects the
current generator too (I don't see why it wouldn't), but I didn't test that
because I'm trying to replace it.


>
> Thoughts?
>
>
I think this patch is fine?.


> >> The alternative to changing .info's meaning is to add another member
> >> with the meaning you need.  Then we have to review .info's uses to fin=
d
> >> out which ones to switch to the new one.
> >
> >
> >> Left for later.
> >>
> >>
> >> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> >> index 8cdd5334ec..abeae1ca77 100644
> >> --- a/scripts/qapi/parser.py
> >> +++ b/scripts/qapi/parser.py
> >> @@ -663,7 +663,10 @@ def end(self) -> None:
> >>      def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
> >>          if self.all_sections and not self.all_sections[-1].tag:
> >>              # extend current section
> >> -            self.all_sections[-1].text +=3D '\n'
> >> +            section =3D self.all_sections[-1]
> >> +            if not section.text:
> >> +                section.info =3D info
> >> +            section.text +=3D '\n'
> >>              return
> >>          # start new section
> >>          section =3D self.Section(info)
> >>
> >>
>
>

--000000000000240a41061b6cfa16
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, May 27, 2024 at 7:58=E2=80=AF=
AM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat=
.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank">jsn=
ow@redhat.com</a>&gt; writes:<br>
<br>
&gt; On Thu, May 16, 2024, 1:58=E2=80=AFAM Markus Armbruster &lt;<a href=3D=
"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt; wrot=
e:<br>
&gt;<br>
&gt;&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank=
">jsnow@redhat.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; Instead of using the info object for the doc block as a whole=
, update<br>
&gt;&gt; &gt; the info pointer for each call to ensure_untagged_section whe=
n the<br>
&gt;&gt; &gt; existing section is otherwise empty. This way, Sphinx error i=
nformation<br>
&gt;&gt; &gt; will match precisely to where the text actually starts.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.c=
om" target=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 scripts/qapi/parser.py | 9 +++++++--<br>
&gt;&gt; &gt;=C2=A0 1 file changed, 7 insertions(+), 2 deletions(-)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py<=
br>
&gt;&gt; &gt; index 8cdd5334ec6..41b9319e5cb 100644<br>
&gt;&gt; &gt; --- a/scripts/qapi/parser.py<br>
&gt;&gt; &gt; +++ b/scripts/qapi/parser.py<br>
&gt;&gt; &gt; @@ -662,8 +662,13 @@ def end(self) -&gt; None:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 def ensure_untagged_section(self, info: Q=
APISourceInfo) -&gt; None:<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.all_sections and no=
t self.all_sections[-1].tag:<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # extend current s=
ection<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.all_sections[=
-1].text +=3D &#39;\n&#39;<br>
&gt;&gt;<br>
&gt;&gt; Before, we always append a newline.<br>
&gt;&gt;<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 section =3D self.a=
ll_sections[-1]<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Section is empty=
 so far; update info to start *here*.<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not section.tex=
t:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a h=
ref=3D"http://section.info" rel=3D"noreferrer" target=3D"_blank">section.in=
fo</a> =3D info<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # ex=
tend current section<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self=
.all_sections[-1].text +=3D &#39;\n&#39;<br>
&gt;&gt;<br>
&gt;&gt; Afterwards, we append it only when the section already has some te=
xt.<br>
&gt;&gt;<br>
&gt;&gt; The commit message claims the patch only adjusts <a href=3D"http:/=
/section.info" rel=3D"noreferrer" target=3D"_blank">section.info</a>.=C2=A0=
 That&#39;s a<br>
&gt;&gt; lie :)<br>
&gt;&gt;<br>
&gt;<br>
&gt; Well. It wasn&#39;t intentional, so it wasn&#39;t a lie... it was just=
 wrong :)<br>
&gt;<br>
&gt;<br>
&gt;&gt; I believe the change makes no difference because .end() strips lea=
ding<br>
&gt;&gt; and trailing newline.<br>
&gt;&gt;<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # start new section<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 section =3D self.Section(in=
fo)<br>
&gt;&gt;<br>
&gt;&gt; You could fix the commit message, but I think backing out the<br>
&gt;&gt; no-difference change is easier.=C2=A0 The appended patch works in =
my testing.<br>
&gt;&gt;<br>
&gt;&gt; Next one.=C2=A0 Your patch changes the meaning of <a href=3D"http:=
//section.info" rel=3D"noreferrer" target=3D"_blank">section.info</a>.=C2=
=A0 Here&#39;s its<br>
&gt;&gt; initialization:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0class Section:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# pylint: disable=3Dtoo-few-publi=
c-methods<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0def __init__(self, info: QAPISour=
ceInfo,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 tag: Optional[str] =3D None):<br>
&gt;&gt; ---&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 # section source info, i.e. whe=
re it begins<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://s=
elf.info" rel=3D"noreferrer" target=3D"_blank">self.info</a> =3D info<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# section tag, if a=
ny (&#39;Returns&#39;, &#39;@name&#39;, ...)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.tag =3D tag<br=
>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# section text with=
out tag<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.text =3D &#39;=
&#39;<br>
&gt;&gt;<br>
&gt;&gt; The comment is now wrong.=C2=A0 Calls for a thorough review of .in=
fo&#39;s uses.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Hmm... Did I really change its meaning? I guess it&#39;s debatable wha=
t &quot;where<br>
&gt; it begins&quot; means. Does the tagless section start...<br>
&gt;<br>
&gt; ## &lt;-- Here?<br>
&gt; # Hello! &lt;-- Or here?<br>
&gt; ##<br>
&gt;<br>
&gt; I assert the *section* starts wherever the first line of text it conta=
ins<br>
&gt; starts. Nothing else makes any sense.<br>
&gt;<br>
&gt; There is value in recording where the doc block starts, but that&#39;s=
 not a<br>
&gt; task for the *section* info.<br>
&gt;<br>
&gt; I don&#39;t think I understand your feedback.<br>
<br>
This was before my vacation, and my memory is foggy, ...=C2=A0 I may have<b=
r>
gotten confused back then.=C2=A0 Let me have a fresh look now.<br>
<br>
<a href=3D"http://self.info" rel=3D"noreferrer" target=3D"_blank">self.info=
</a> gets initialized in Section.__init__() to whatever info it<br>
gets passed.<br>
<br>
Your patch makes .ensure_untagged_section() overwrite this Section.info<br>
when it extends an untagged section that is still empty.=C2=A0 Hmmm.=C2=A0 =
I&#39;d<br>
prefer .info to remain constant after initialization.<br></blockquote><div>=
<br></div><div>but, we don&#39;t have the right info when we initialize the=
 entire QAPIDoc object, because the section hasn&#39;t truly actually start=
ed yet, so I don&#39;t think I can actually achieve your preference.<br></d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
I figure this overwrite can happen only when extenting the body section<br>
QAPIDoc.__init__() creates.=C2=A0 In that case, it adjusts .info from<br>
beginning of doc comment to first non-blank line.<br></blockquote><div><br>=
</div><div>Yes, that&#39;s the intended effect and in practice, the only ti=
me it actually happens.</div><div><br></div><div>This patch is necessary fo=
r accurate error reporting info, otherwise we get off-by-ones (or more, may=
be). I believe the problem actually affects the current generator too (I do=
n&#39;t see why it wouldn&#39;t), but I didn&#39;t test that because I&#39;=
m trying to replace it.</div><div></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
Thoughts?<br>
<br></blockquote><div><br></div><div>I think this patch is fine?.<br></div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;&gt; The alternative to changing .info&#39;s meaning is to add another =
member<br>
&gt;&gt; with the meaning you need.=C2=A0 Then we have to review .info&#39;=
s uses to find<br>
&gt;&gt; out which ones to switch to the new one.<br>
&gt;<br>
&gt;<br>
&gt;&gt; Left for later.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py<br>
&gt;&gt; index 8cdd5334ec..abeae1ca77 100644<br>
&gt;&gt; --- a/scripts/qapi/parser.py<br>
&gt;&gt; +++ b/scripts/qapi/parser.py<br>
&gt;&gt; @@ -663,7 +663,10 @@ def end(self) -&gt; None:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 def ensure_untagged_section(self, info: QAPISo=
urceInfo) -&gt; None:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.all_sections and not sel=
f.all_sections[-1].tag:<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # extend current s=
ection<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.all_sections[-1].t=
ext +=3D &#39;\n&#39;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 section =3D self.all_se=
ctions[-1]<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not section.text:<br=
>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=
=3D"http://section.info" rel=3D"noreferrer" target=3D"_blank">section.info<=
/a> =3D info<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 section.text +=3D &#39;=
\n&#39;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # start new section<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 section =3D self.Section(info)<b=
r>
&gt;&gt;<br>
&gt;&gt;<br>
<br>
</blockquote></div></div>

--000000000000240a41061b6cfa16--


