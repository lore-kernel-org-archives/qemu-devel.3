Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC7FC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 14:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7c8X-000290-Ac; Thu, 16 May 2024 10:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s7c8P-00027K-EK
 for qemu-devel@nongnu.org; Thu, 16 May 2024 10:31:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s7c8E-0006Yz-34
 for qemu-devel@nongnu.org; Thu, 16 May 2024 10:31:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715869852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HMOrMd5eLON6neBV6JnxbfqD5+KH8iQmyMs5YjrbM4s=;
 b=RaVrb7ZJ5WQi4A+ojsP5xNKCSOix7Re4yNTYM/nL8EuOQL3jvMCvSobHtyGxCKmmGyLZVE
 FXhkdeJQb6MOPJjPH/TaMEDylnu18KXlfXiiJjvodEkKOBEZTRAWDpYPnVgyQMQJP5MN/W
 1nrYtBJlU/vyLNJNL6beGDOTkw/cYMw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-Bi0pdiL0MdKqhs-_VQGHIA-1; Thu, 16 May 2024 10:30:47 -0400
X-MC-Unique: Bi0pdiL0MdKqhs-_VQGHIA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-351c67dbc8dso1863097f8f.2
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 07:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715869847; x=1716474647;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HMOrMd5eLON6neBV6JnxbfqD5+KH8iQmyMs5YjrbM4s=;
 b=xUeD7bVhikw13gK2fRdZ/seBtnSYD8I0agDyA2IWH65tMBAvr2hMhRR/ty2e2RCvmP
 +4ZdYaVE2a0BCFWIrGjcqZhTJfuni+xNMXGe91hQFA/uYDbuPx+ijXq9OEi3WKSJJUbk
 6kckkf4JVRiBKWVUNnkArwIGopAoHhppLG9TfhiDwLT/bfCyK3EP6fUQAWe81r5Fj7kq
 20FipT+GrJV4nZYBrCY/Nfc0Oqrk3SoGZqpOJCczRV8Zr0yNDZ2yHaQMCYnNY5mupdNZ
 w75Ko6fDZPV1y8MPB6UMYp+IC8vjk7LLONneIOAbrhNjtEzcBkxG9iVLjbhApdIkpnXX
 IjMQ==
X-Gm-Message-State: AOJu0Ywu4QsfDl1Ss2hd9gfRHzwyAWs6518/WS0PoidQgyNOs9Lb9wNj
 60JtIso+IAQqq6AsGWrZ/bZ4an9VRc+vipz941RcJMVR9eSUiHbXqxBKPj6TTw48k+XG/5Ct5lG
 NUbxLRWa0x22Pg0J5GFa4zzH5HK/B5duReuM4ZkQD6Hnkdf9BQqvsxUPfL+RJsddgJvmLER+kDx
 09AmOdcJ30zlnP27seSV94DlmUaVA=
X-Received: by 2002:a05:6000:551:b0:34b:b0ac:c63c with SMTP id
 ffacd0b85a97d-3504aa66a14mr12721844f8f.66.1715869846733; 
 Thu, 16 May 2024 07:30:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyCOk9QCf9U0HvZdTZInmZreKK4KAtn1K8Vzr3aFORUSZxG7mQCRO3+vHqWCY3UccWT+7zq+6xgnTnyu7Crp8=
X-Received: by 2002:a05:6000:551:b0:34b:b0ac:c63c with SMTP id
 ffacd0b85a97d-3504aa66a14mr12721800f8f.66.1715869846287; Thu, 16 May 2024
 07:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240514215740.940155-1-jsnow@redhat.com>
 <20240514215740.940155-6-jsnow@redhat.com>
 <87a5kqpaaw.fsf@pond.sub.org>
In-Reply-To: <87a5kqpaaw.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 16 May 2024 10:30:32 -0400
Message-ID: <CAFn=p-abjRbSvcHPSUorp80SZaf5Xwi89WtvhebXK_SRw3Cg4w@mail.gmail.com>
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
Content-Type: multipart/alternative; boundary="000000000000ab50e3061893143b"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

--000000000000ab50e3061893143b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024, 1:58=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Instead of using the info object for the doc block as a whole, update
> > the info pointer for each call to ensure_untagged_section when the
> > existing section is otherwise empty. This way, Sphinx error information
> > will match precisely to where the text actually starts.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  scripts/qapi/parser.py | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> > index 8cdd5334ec6..41b9319e5cb 100644
> > --- a/scripts/qapi/parser.py
> > +++ b/scripts/qapi/parser.py
> > @@ -662,8 +662,13 @@ def end(self) -> None:
> >
> >      def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
> >          if self.all_sections and not self.all_sections[-1].tag:
> > -            # extend current section
> > -            self.all_sections[-1].text +=3D '\n'
>
> Before, we always append a newline.
>
> > +            section =3D self.all_sections[-1]
> > +            # Section is empty so far; update info to start *here*.
> > +            if not section.text:
> > +                section.info =3D info
> > +            else:
> > +                # extend current section
> > +                self.all_sections[-1].text +=3D '\n'
>
> Afterwards, we append it only when the section already has some text.
>
> The commit message claims the patch only adjusts section.info.  That's a
> lie :)
>

Well. It wasn't intentional, so it wasn't a lie... it was just wrong :)


> I believe the change makes no difference because .end() strips leading
> and trailing newline.
>
> >              return
> >          # start new section
> >          section =3D self.Section(info)
>
> You could fix the commit message, but I think backing out the
> no-difference change is easier.  The appended patch works in my testing.
>
> Next one.  Your patch changes the meaning of section.info.  Here's its
> initialization:
>
>     class Section:
>         # pylint: disable=3Dtoo-few-public-methods
>         def __init__(self, info: QAPISourceInfo,
>                      tag: Optional[str] =3D None):
> --->        # section source info, i.e. where it begins
>             self.info =3D info
>             # section tag, if any ('Returns', '@name', ...)
>             self.tag =3D tag
>             # section text without tag
>             self.text =3D ''
>
> The comment is now wrong.  Calls for a thorough review of .info's uses.
>

Hmm... Did I really change its meaning? I guess it's debatable what "where
it begins" means. Does the tagless section start...

## <-- Here?
# Hello! <-- Or here?
##

I assert the *section* starts wherever the first line of text it contains
starts. Nothing else makes any sense.

There is value in recording where the doc block starts, but that's not a
task for the *section* info.

I don't think I understand your feedback.


> The alternative to changing .info's meaning is to add another member
> with the meaning you need.  Then we have to review .info's uses to find
> out which ones to switch to the new one.


> Left for later.
>
>
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index 8cdd5334ec..abeae1ca77 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -663,7 +663,10 @@ def end(self) -> None:
>      def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
>          if self.all_sections and not self.all_sections[-1].tag:
>              # extend current section
> -            self.all_sections[-1].text +=3D '\n'
> +            section =3D self.all_sections[-1]
> +            if not section.text:
> +                section.info =3D info
> +            section.text +=3D '\n'
>              return
>          # start new section
>          section =3D self.Section(info)
>
>

--000000000000ab50e3061893143b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, May 16, 2024, 1:58=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">John Snow &lt;<a href=3D"mailto:js=
now@redhat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&g=
t; writes:<br>
<br>
&gt; Instead of using the info object for the doc block as a whole, update<=
br>
&gt; the info pointer for each call to ensure_untagged_section when the<br>
&gt; existing section is otherwise empty. This way, Sphinx error informatio=
n<br>
&gt; will match precisely to where the text actually starts.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 scripts/qapi/parser.py | 9 +++++++--<br>
&gt;=C2=A0 1 file changed, 7 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py<br>
&gt; index 8cdd5334ec6..41b9319e5cb 100644<br>
&gt; --- a/scripts/qapi/parser.py<br>
&gt; +++ b/scripts/qapi/parser.py<br>
&gt; @@ -662,8 +662,13 @@ def end(self) -&gt; None:<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def ensure_untagged_section(self, info: QAPISource=
Info) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.all_sections and not self.al=
l_sections[-1].tag:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # extend current section<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.all_sections[-1].text =
+=3D &#39;\n&#39;<br>
<br>
Before, we always append a newline.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 section =3D self.all_sectio=
ns[-1]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Section is empty so far; =
update info to start *here*.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not section.text:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"ht=
tp://section.info" rel=3D"noreferrer noreferrer" target=3D"_blank">section.=
info</a> =3D info<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # extend curr=
ent section<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.all_sect=
ions[-1].text +=3D &#39;\n&#39;<br>
<br>
Afterwards, we append it only when the section already has some text.<br>
<br>
The commit message claims the patch only adjusts <a href=3D"http://section.=
info" rel=3D"noreferrer noreferrer" target=3D"_blank">section.info</a>.=C2=
=A0 That&#39;s a<br>
lie :)<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">Well. It wasn&#39;t intentional, so it wasn&#39;t a lie... it was jus=
t wrong :)</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D=
"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">
<br>
I believe the change makes no difference because .end() strips leading<br>
and trailing newline.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # start new section<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 section =3D self.Section(info)<br>
<br>
You could fix the commit message, but I think backing out the<br>
no-difference change is easier.=C2=A0 The appended patch works in my testin=
g.<br>
<br>
Next one.=C2=A0 Your patch changes the meaning of <a href=3D"http://section=
.info" rel=3D"noreferrer noreferrer" target=3D"_blank">section.info</a>.=C2=
=A0 Here&#39;s its<br>
initialization:<br>
<br>
=C2=A0 =C2=A0 class Section:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # pylint: disable=3Dtoo-few-public-methods<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 def __init__(self, info: QAPISourceInfo,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0tag: Optional[str] =3D None):<br>
---&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 # section source info, i.e. where it beg=
ins<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://self.info" rel=
=3D"noreferrer noreferrer" target=3D"_blank">self.info</a> =3D info<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # section tag, if any (&#39;Retur=
ns&#39;, &#39;@name&#39;, ...)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.tag =3D tag<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # section text without tag<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.text =3D &#39;&#39;<br>
<br>
The comment is now wrong.=C2=A0 Calls for a thorough review of .info&#39;s =
uses.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Hmm... Did I really change its meaning? I guess it&#39;s debatable wha=
t &quot;where it begins&quot; means. Does the tagless section start...</div=
><div dir=3D"auto"><br></div><div dir=3D"auto">## &lt;-- Here?</div><div di=
r=3D"auto"># Hello! &lt;-- Or here?</div><div dir=3D"auto">##</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">I assert the *section* starts whereve=
r the first line of text it contains starts. Nothing else makes any sense.<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">There is value in record=
ing where the doc block starts, but that&#39;s not a task for the *section*=
 info.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I don&#39;t think=
 I understand your feedback.</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
The alternative to changing .info&#39;s meaning is to add another member<br=
>
with the meaning you need.=C2=A0 Then we have to review .info&#39;s uses to=
 find<br>
out which ones to switch to the new one.</blockquote></div></div><div dir=
=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Left for later.<br>
<br>
<br>
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py<br>
index 8cdd5334ec..abeae1ca77 100644<br>
--- a/scripts/qapi/parser.py<br>
+++ b/scripts/qapi/parser.py<br>
@@ -663,7 +663,10 @@ def end(self) -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0def ensure_untagged_section(self, info: QAPISourceInfo)=
 -&gt; None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.all_sections and not self.all_sec=
tions[-1].tag:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# extend current section<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.all_sections[-1].text +=3D =
&#39;\n&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 section =3D self.all_sections[-1=
]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not section.text:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://=
section.info" rel=3D"noreferrer noreferrer" target=3D"_blank">section.info<=
/a> =3D info<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 section.text +=3D &#39;\n&#39;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# start new section<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0section =3D self.Section(info)<br>
<br>
</blockquote></div></div></div>

--000000000000ab50e3061893143b--


