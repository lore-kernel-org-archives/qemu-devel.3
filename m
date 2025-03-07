Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B00CC28B27
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 20:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqe0a-0007WG-6J; Fri, 07 Mar 2025 15:09:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqe0Y-0007Sj-Od
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 15:09:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tqe0W-0001En-Sj
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 15:09:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741378156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JJZ3yZvQXqqljDbi2MKVK9QP5f8yb2eSoyrlU2x3ZiE=;
 b=Ia/SB/vH5Z9sBfjz54dtA2bAKzDzVNAiNLMmXAF20xeBneRliHeww1AmtdCUtRPxJolp/G
 4ZUo9VNEFLMUqzXAe1wEm78OrtxxHpkhkOlnE5elfyAB2TdjlOuhXZJpC1eCs+shTXEePn
 WPJXJm86J0sRwZi+Mt4NpdrHI+ZEFl8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-Broe5WUtPJivl56XG3NyQw-1; Fri, 07 Mar 2025 15:09:12 -0500
X-MC-Unique: Broe5WUtPJivl56XG3NyQw-1
X-Mimecast-MFC-AGG-ID: Broe5WUtPJivl56XG3NyQw_1741378151
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ff6943febeso3683422a91.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 12:09:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741378151; x=1741982951;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JJZ3yZvQXqqljDbi2MKVK9QP5f8yb2eSoyrlU2x3ZiE=;
 b=LqTIjPZ9Uo5+ybt+8pEB8p1wF80FuLpDpppfZ8YS3TLsvCbSnnm87rsc81vb7ywg6P
 jqVD7VIiIF6RoSfSmjoKyYi3znYtnlauGmXFVBD2xfRgKM6LR5lPpLq0wgE6BNYX3LHs
 0gYHfjaVd+T1p0ri34gPCVimbd1r7HPIkRVEBCL3dLh7SoiWuChhnzrdeGcSDlOnplET
 Gb9eqA1BYU8VqDeE6SsN/oEiR4Xf5RIrql4cTysfpyy4eSTDk9RpTAqaC6q0ahVGB6w2
 ZjudpOaHaAIIiOKXad0g+yFzejhIACTq9O+nRFOBP21lV0/sah7gxp/RG1hVcE0MwBRV
 ag9Q==
X-Gm-Message-State: AOJu0YwbVn1wHhsX0mUGcebywpnsn5w+InHVpiN5U+7DwECHdv/NbWE+
 rb9eF4fcbz5GiQKMpeIcoO0KfvRuFhU7YLrhRM22p1eAv0gFTsah7wwWhHsKdyuRLgqFK1drxn1
 FInRC1Llth9JgVsfCHsPL43fxuCzIcVLoFIRPnoFHELhR1oVUvz7QbGP+294EWaTVzAh39oV0F7
 8XpOfDvvZPmdkdQjmVHUga9C+74ls=
X-Gm-Gg: ASbGncvGbL0I818v0BMGsiqNzJeri0EeRtwDPY54Nm77rkjvqVJvCgXK0PLrwZJIS8E
 58+By5Q6i7hmU/O8z8uDvwKVLy6lR+XRm7pEYC0hhSrdhZNQGQTDvt2Bp7f/HsYksoaMsdA==
X-Received: by 2002:a17:90a:d404:b0:2fa:562c:c1cf with SMTP id
 98e67ed59e1d1-2ffbc1474a2mr1318319a91.1.1741378151410; 
 Fri, 07 Mar 2025 12:09:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSTa+l9Dq31taFa9Dd0ZAiq0pgr6nVJ0etltRGJFtNtLlx4dwX1u0uz7/EPtG1lQ0utwyNqUrqteBJT5+boss=
X-Received: by 2002:a17:90a:d404:b0:2fa:562c:c1cf with SMTP id
 98e67ed59e1d1-2ffbc1474a2mr1318298a91.1.1741378151179; Fri, 07 Mar 2025
 12:09:11 -0800 (PST)
MIME-Version: 1.0
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-5-jsnow@redhat.com>
 <87o6ydtmua.fsf@pond.sub.org>
In-Reply-To: <87o6ydtmua.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 7 Mar 2025 15:08:59 -0500
X-Gm-Features: AQ5f1Jpw-Kwh48t-Q5DD1-l0fhTC2RInTJi-f4XvxxkAY1joiybVpMfXGdEVBtc
Message-ID: <CAFn=p-Z2dVfWZ7=Ukyx1U3wfi9+eP+JrJ75md1P8T7Y3Bj0Cag@mail.gmail.com>
Subject: Re: [PATCH 04/57] docs/sphinx: add compat.py module and nested_parse
 helper
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001f0074062fc63291"
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

--0000000000001f0074062fc63291
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 12:46=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Create a compat module that handles sphinx cross-version compatibility
> > issues. For the inaugural function, add a nested_parse() helper that
> > handles differences in line number tracking for nested directive body
> > parsing.
> >
> > Spoilers: there are more cross-version hacks to come throughout the
> > series.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  docs/sphinx/compat.py | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >  create mode 100644 docs/sphinx/compat.py
> >
> > diff --git a/docs/sphinx/compat.py b/docs/sphinx/compat.py
> > new file mode 100644
> > index 00000000000..792aca10e39
> > --- /dev/null
> > +++ b/docs/sphinx/compat.py
> > @@ -0,0 +1,33 @@
> > +"""
> > +Sphinx cross-version compatibility goop
> > +"""
> > +
> > +from docutils.nodes import Element
> > +
> > +from sphinx.util.docutils import SphinxDirective, switch_source_input
> > +from sphinx.util.nodes import nested_parse_with_titles
> > +
> > +
> > +def nested_parse(directive: SphinxDirective, content_node: Element) ->
> None:
> > +    """
> > +    This helper preserves error parsing context across sphinx versions=
.
> > +    """
> > +
> > +    # necessary so that the child nodes get the right source/line set
> > +    content_node.document =3D directive.state.document
> > +
> > +    try:
> > +        # Modern sphinx (6.2.0+) supports proper offsetting for
> > +        # nested parse error context management
> > +        nested_parse_with_titles(
> > +            directive.state,
> > +            directive.content,
> > +            content_node,
> > +            content_offset=3Ddirective.content_offset,
> > +        )
> > +    except TypeError:
> > +        # No content_offset argument. Fall back to SSI method.
> > +        with switch_source_input(directive.state, directive.content):
> > +            nested_parse_with_titles(
> > +                directive.state, directive.content, content_node
> > +            )
>
> The function wraps around sphinx.util.nodes.nested_parse_with_titles().
> Would calling it nested_parse_with_titles() reduce readers' cognitive
> load at call sites?
>
> Please do not misinterpret my question as a demand.  It's really just a
> question :)
>

Sure, easy change.

--0000000000001f0074062fc63291
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 7, =
2025 at 12:46=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Create a compat module that handles sphinx cross-version compatibility=
<br>
&gt; issues. For the inaugural function, add a nested_parse() helper that<b=
r>
&gt; handles differences in line number tracking for nested directive body<=
br>
&gt; parsing.<br>
&gt;<br>
&gt; Spoilers: there are more cross-version hacks to come throughout the<br=
>
&gt; series.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 docs/sphinx/compat.py | 33 +++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 1 file changed, 33 insertions(+)<br>
&gt;=C2=A0 create mode 100644 docs/sphinx/compat.py<br>
&gt;<br>
&gt; diff --git a/docs/sphinx/compat.py b/docs/sphinx/compat.py<br>
&gt; new file mode 100644<br>
&gt; index 00000000000..792aca10e39<br>
&gt; --- /dev/null<br>
&gt; +++ b/docs/sphinx/compat.py<br>
&gt; @@ -0,0 +1,33 @@<br>
&gt; +&quot;&quot;&quot;<br>
&gt; +Sphinx cross-version compatibility goop<br>
&gt; +&quot;&quot;&quot;<br>
&gt; +<br>
&gt; +from docutils.nodes import Element<br>
&gt; +<br>
&gt; +from sphinx.util.docutils import SphinxDirective, switch_source_input=
<br>
&gt; +from sphinx.util.nodes import nested_parse_with_titles<br>
&gt; +<br>
&gt; +<br>
&gt; +def nested_parse(directive: SphinxDirective, content_node: Element) -=
&gt; None:<br>
&gt; +=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +=C2=A0 =C2=A0 This helper preserves error parsing context across sphi=
nx versions.<br>
&gt; +=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 # necessary so that the child nodes get the right sourc=
e/line set<br>
&gt; +=C2=A0 =C2=A0 content_node.document =3D directive.state.document<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 try:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Modern sphinx (6.2.0+) supports proper =
offsetting for<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # nested parse error context management<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 nested_parse_with_titles(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 directive.state,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 directive.content,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 content_node,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 content_offset=3Ddirective.=
content_offset,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
&gt; +=C2=A0 =C2=A0 except TypeError:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # No content_offset argument. Fall back t=
o SSI method.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 with switch_source_input(directive.state,=
 directive.content):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 nested_parse_with_titles(<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 directive.sta=
te, directive.content, content_node<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
<br>
The function wraps around sphinx.util.nodes.nested_parse_with_titles().<br>
Would calling it nested_parse_with_titles() reduce readers&#39; cognitive<b=
r>
load at call sites?<br>
<br>
Please do not misinterpret my question as a demand.=C2=A0 It&#39;s really j=
ust a<br>
question :)<br></blockquote><div><br></div><div>Sure, easy change.</div></d=
iv></div>

--0000000000001f0074062fc63291--


