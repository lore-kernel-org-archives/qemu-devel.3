Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC58C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 08:07:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqpDX-0003gx-4R; Sat, 08 Mar 2025 03:07:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqpDU-0003gj-RI
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 03:07:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqpDS-0005bH-RK
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 03:07:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741421246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rGvlsq/aGkCnWEkINVQDV3B0t7CFKG3eGI/GUsINMI4=;
 b=NuR5DxxjKSlveUwX/o35qk4DeehegcMbNLZXOdZ7l7ndeumB9s5oItIkJ3m5SXcAw3sJdE
 j442mQNHQJcSDy3EU2L08JqaLU+NitXbzEPSRMrzdeOBfkf8Ry3hY1h3OO/q+NrtMlFyjl
 LxkkdUTLXvXNlJa+lAdzoOkp/TWHWH4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-uiRmB9bsMVuV1UIprn-xNA-1; Sat, 08 Mar 2025 03:07:22 -0500
X-MC-Unique: uiRmB9bsMVuV1UIprn-xNA-1
X-Mimecast-MFC-AGG-ID: uiRmB9bsMVuV1UIprn-xNA_1741421241
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2fec3e38c2dso7368353a91.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 00:07:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741421241; x=1742026041;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rGvlsq/aGkCnWEkINVQDV3B0t7CFKG3eGI/GUsINMI4=;
 b=OduPFMKOgZWnv69gjMyCRKobKmoZy6OALEfj6G8UXkX6pes4mvXgZo+oaxQlPAlxxs
 Ta9RcCQ9zZWUdboG8ynUf8Kk8mGNN+NCD3QLsxcNB8tTxxL8XlAk6RHQDbsBURaif10r
 /we/jVSse8Bi+dz0ccx9EzdX7x3RmrK7lWeKaifvhX+E8z04xDgBPaxCkOrrHzvEq3IX
 1niAAB/DA8t8cosa3/sWUaUlrxmUoQNzbhNeh1YxLD7HjSmkE9UdVMjN/K1LQ8FQG7dv
 jxzzP7flvVW37iG9ZHx59BENLCCPn1v8wbYJPG5d+vkZl83ckg19ZyWKgrWJ+Pk6v4gB
 gsuw==
X-Gm-Message-State: AOJu0YxYzEAIct2+5kD+Keyf8Neyax7GCLJs0QkijhbW6dPyoGzMd/YV
 fvGSNVU+Npbj4V7QQ2i1CXI1IJuJEAxHgSPokKBthLU3ihCmdXECzy8mBWNqQ15b7QDpDTEBZIg
 cPAMOdUAr/1LFxRaDEVY+1wnx3sHdojtv6arJHLogZVziTE4p2cJI5FGGBekb9Q2z4y9MXmxqJ/
 a2rF+YGmvduRS6QJi2tr3VTuO/xDI=
X-Gm-Gg: ASbGnct6uY0DZQA3EPYNVodEeKi5Z5XIyCs9tJ8dmMTjiuJVqCEIXtIVaQoqltzKlD9
 kjf6SnWf6xenfKC+DxVm6MZzQ3upaGFWa8VI0QjBR+cqpvpzINjEHylRN+qEZP5zpQioC8A==
X-Received: by 2002:a17:90b:35cd:b0:2ff:6608:78cd with SMTP id
 98e67ed59e1d1-2ff7ce632a3mr11060045a91.9.1741421241374; 
 Sat, 08 Mar 2025 00:07:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHE5KsnTSZgaxOxrGTkLm7G9NCNeMiEQ+CryjqSfabjNkgzjfwytDNuLQcS6dJKn2ZZRdKShiXkNd1USyuI5bQ=
X-Received: by 2002:a17:90b:35cd:b0:2ff:6608:78cd with SMTP id
 98e67ed59e1d1-2ff7ce632a3mr11060028a91.9.1741421241120; Sat, 08 Mar 2025
 00:07:21 -0800 (PST)
MIME-Version: 1.0
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-50-jsnow@redhat.com>
 <871pv9jaeh.fsf@pond.sub.org>
In-Reply-To: <871pv9jaeh.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Sat, 8 Mar 2025 03:07:09 -0500
X-Gm-Features: AQ5f1JpC4IuswSQMO7XIkdBc3NugjKkCvjMdY5-_yyFmeof7aecrYE7tHkcvd6k
Message-ID: <CAFn=p-a6PO8g6jsYewN0jicStR60=awmgUL+aJX9U9CHPidqRQ@mail.gmail.com>
Subject: Re: [PATCH 49/57] docs/qapidoc: add visit_member() method
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007b55ce062fd03a8f"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000007b55ce062fd03a8f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 7:25=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This method is used for generating the "members" of a wide variety of
> > things, including structs, unions, enums, alternates, etc. The field
> > name it uses to do so is dependent on the type of entity the "member"
> > belongs to.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/qapidoc.py | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> > index 6458790fe55..ed0269af27d 100644
> > --- a/docs/sphinx/qapidoc.py
> > +++ b/docs/sphinx/qapidoc.py
> > @@ -78,6 +78,16 @@
> >
> >
> >  class Transmogrifier:
> > +    # Field names used for different entity types:
> > +    field_types =3D {
> > +        "enum": "value",
> > +        "struct": "memb",
> > +        "union": "memb",
> > +        "event": "memb",
> > +        "command": "arg",
> > +        "alternate": "choice",
> > +    }
> > +
> >      def __init__(self) -> None:
> >          self._curr_ent: Optional[QAPISchemaDefinition] =3D None
> >          self._result =3D StringList()
> > @@ -88,6 +98,10 @@ def entity(self) -> QAPISchemaDefinition:
> >          assert self._curr_ent is not None
> >          return self._curr_ent
> >
> > +    @property
> > +    def member_field_type(self) -> str:
> > +        return self.field_types[self.entity.meta]
> > +
> >      # General-purpose rST generation functions
> >
> >      def get_indent(self) -> str:
> > @@ -202,6 +216,19 @@ def visit_paragraph(self, section: QAPIDoc.Section=
)
> -> None:
> >          self.add_lines(section.text, section.info)
> >          self.ensure_blank_line()
> >
> > +    def visit_member(self, section: QAPIDoc.ArgSection) -> None:
> > +        # TODO: ifcond for members
>
> Similar issues elsewhere are marked FIXME.
>
> Worth mentioning in the commit message?
>

Will change, and yes.


>
>
> > +        # TODO?: features for members (documented at entity-level,
> > +        # but sometimes defined per-member. Should we add such
> > +        # information to member descriptions when we can?)
>
> I guess the '?' in 'TODO?' is there because you're not sure there's
> anything to be done about member features.  But you phrased the TODO as
> a question.  That makes the uncertainty obvious enough, doesn't it?
> Suggest to delete the '?' so a grep for 'TODO:' isn't deceived.  Best to
> grep just for 'TODO', of course.
>

Obie-kaybie.


>
> > +        assert section.text and section.member
> > +        self.generate_field(
> > +            self.member_field_type,
> > +            section.member,
> > +            section.text,
> > +            section.info,
> > +        )
> > +
> >      def visit_feature(self, section: QAPIDoc.ArgSection) -> None:
> >          # FIXME - ifcond for features is not handled at all yet!
> >          # Proposal: decorate the right-hand column with some graphical
>
>

--0000000000007b55ce062fd03a8f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 7, =
2025 at 7:25=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redh=
at.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" =
target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; This method is used for generating the &quot;members&quot; of a wide v=
ariety of<br>
&gt; things, including structs, unions, enums, alternates, etc. The field<b=
r>
&gt; name it uses to do so is dependent on the type of entity the &quot;mem=
ber&quot;<br>
&gt; belongs to.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/sphinx/qapidoc.py | 27 +++++++++++++++++++++++++++<br>
&gt;=C2=A0 1 file changed, 27 insertions(+)<br>
&gt;<br>
&gt; diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py<br>
&gt; index 6458790fe55..ed0269af27d 100644<br>
&gt; --- a/docs/sphinx/qapidoc.py<br>
&gt; +++ b/docs/sphinx/qapidoc.py<br>
&gt; @@ -78,6 +78,16 @@<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 <br>
&gt;=C2=A0 class Transmogrifier:<br>
&gt; +=C2=A0 =C2=A0 # Field names used for different entity types:<br>
&gt; +=C2=A0 =C2=A0 field_types =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;enum&quot;: &quot;value&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;struct&quot;: &quot;memb&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;union&quot;: &quot;memb&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;event&quot;: &quot;memb&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;command&quot;: &quot;arg&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;alternate&quot;: &quot;choice&quot;=
,<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def __init__(self) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._curr_ent: Optional[QAPISchemaD=
efinition] =3D None<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._result =3D StringList()<br>
&gt; @@ -88,6 +98,10 @@ def entity(self) -&gt; QAPISchemaDefinition:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert self._curr_ent is not None<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return self._curr_ent<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 @property<br>
&gt; +=C2=A0 =C2=A0 def member_field_type(self) -&gt; str:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.field_types[self.entity.meta]=
<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 # General-purpose rST generation functions<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 def get_indent(self) -&gt; str:<br>
&gt; @@ -202,6 +216,19 @@ def visit_paragraph(self, section: QAPIDoc.Sectio=
n) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_lines(section.text, <a href=
=3D"http://section.info" rel=3D"noreferrer" target=3D"_blank">section.info<=
/a>)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.ensure_blank_line()<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 def visit_member(self, section: QAPIDoc.ArgSection) -&g=
t; None:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # TODO: ifcond for members<br>
<br>
Similar issues elsewhere are marked FIXME.<br>
<br>
Worth mentioning in the commit message?<br></blockquote><div><br></div><div=
>Will change, and yes.</div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # TODO?: features for members (documented=
 at entity-level,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # but sometimes defined per-member. Shoul=
d we add such<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # information to member descriptions when=
 we can?)<br>
<br>
I guess the &#39;?&#39; in &#39;TODO?&#39; is there because you&#39;re not =
sure there&#39;s<br>
anything to be done about member features.=C2=A0 But you phrased the TODO a=
s<br>
a question.=C2=A0 That makes the uncertainty obvious enough, doesn&#39;t it=
?<br>
Suggest to delete the &#39;?&#39; so a grep for &#39;TODO:&#39; isn&#39;t d=
eceived.=C2=A0 Best to<br>
grep just for &#39;TODO&#39;, of course.<br></blockquote><div><br></div><di=
v>Obie-kaybie.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert section.text and section.member<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.generate_field(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.member_field_type,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 section.member,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 section.text,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://section.i=
nfo" rel=3D"noreferrer" target=3D"_blank">section.info</a>,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 def visit_feature(self, section: QAPIDoc.ArgSectio=
n) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # FIXME - ifcond for features is not=
 handled at all yet!<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Proposal: decorate the right-hand =
column with some graphical<br>
<br>
</blockquote></div></div>

--0000000000007b55ce062fd03a8f--


