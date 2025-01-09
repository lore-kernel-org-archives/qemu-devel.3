Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE9BE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVwJI-00021C-Cc; Thu, 09 Jan 2025 12:27:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tVwJG-0001uh-U4
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:27:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tVwJE-0001ik-K1
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:27:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736443623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SW50s2y04DDmhqBMbY/KZoSk0VX/N86OI7P53cZZgR0=;
 b=fZtCfmm1yfZre1I1CyOy5Ef5LPn1BwS+K2TG0OuKQxzUCV799M9DnhaIbpOy04b+f1TRE4
 yTulg9sriM8FmWMLZQbM4T16k73aUXH0u8Y1bVYKzL/7N8WhluGGqKqnENrCqLAnuz+S3s
 XQu3Upy0zUfjCk131iQ/Xtd6RIbaGxE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-aNEHyK5aNHCMGAxIk2mq-Q-1; Thu, 09 Jan 2025 12:26:59 -0500
X-MC-Unique: aNEHyK5aNHCMGAxIk2mq-Q-1
X-Mimecast-MFC-AGG-ID: aNEHyK5aNHCMGAxIk2mq-Q
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ef35de8901so2041652a91.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:26:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736443618; x=1737048418;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SW50s2y04DDmhqBMbY/KZoSk0VX/N86OI7P53cZZgR0=;
 b=BlTTIddQHTClAmrz1ENHWwnGJ/USBKAHfvgyO0ZddoZvFv8NYyUVtcO53nWs8K3/OK
 0fT3CF3edH0WmTqX2ZtAvcSJwKxb0EeUY1LIXtBdA3b/Sal1g7GWDvCRJDm/J/Hc/Dov
 vmQfE9nyoY7GUJ6/4UXIeAyD51EwmAYUwboPSEcmNfZKSbBwFzAgQQjuwsVM9g08FjyK
 iYrsdBwB4jn9Vyra9TAVl7Jq1/jVngKNjCpxyHOgZgMq7pIHOubJbqpmPsg6op85sQGu
 jpbneNjjWew5rHvS3nh4j+nO0yF6Sp+T1oOCrHEHuhj6r3NM7i2X9CM9cOz7/lg9CWK5
 HwCw==
X-Gm-Message-State: AOJu0Ywjd5/EsAtEzOq+bXi5HfVWO33IL+rxp/UYBXEEMloM/Hg4gzgc
 bSA5MPdT69FOn2i5wGLh6k1rkbvosTXBEoUyfX5JiHsNWFHHkth2Qy61YIyNB5yd/HIsIya6f8i
 1e7gOiC6nYikwQv5qmdxvJkqCRWLJnTtQaAgjfWMz6b/5ds8TUpXHt8N3fin9FWPY+24jU4LTns
 DOV8heMK06cU8AdaS/e+3nRDEwxsUtXqOy7kI=
X-Gm-Gg: ASbGnctLUy70yaeQVWMflndc/c636CUXBM4NRyVJCQ28JCoiDy/Ok0deldq6XowAm66
 eJLhR6gbjguBDOP1P5ALXJRQ1pcscE5WDzqgM/hvyO+/d+W48SLjWo3VozRmKhFoWkiQdNA==
X-Received: by 2002:a17:90b:534b:b0:2f1:2fa5:1924 with SMTP id
 98e67ed59e1d1-2f548f44ea9mr9507641a91.26.1736443616230; 
 Thu, 09 Jan 2025 09:26:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWtXIQ86mp+utUBMLdsEBbtCeTwXHnCZI7nyC2AbTIpjLVE1RSlo4vKxiFNatV88UY3zUyAI5v6dtujlMsVPU=
X-Received: by 2002:a17:90b:534b:b0:2f1:2fa5:1924 with SMTP id
 98e67ed59e1d1-2f548f44ea9mr9507601a91.26.1736443615685; Thu, 09 Jan 2025
 09:26:55 -0800 (PST)
MIME-Version: 1.0
References: <20241213021827.2956769-1-jsnow@redhat.com>
 <87ikrfkg6y.fsf@pond.sub.org>
 <CAFn=p-YynNgOTb7-rzJeF69hG_3c1ojosHAOsnc-CW-a_SYrUA@mail.gmail.com>
 <87sepsqkcd.fsf@pond.sub.org>
In-Reply-To: <87sepsqkcd.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 9 Jan 2025 12:26:43 -0500
X-Gm-Features: AbW1kvYpIPtWkWz5Xnfk9youjoHtsAu8aHkuYSguJ-i3EhIPvzsGIsHp7fFtFuk
Message-ID: <CAFn=p-ZGstCO9vLjuJmYavuZn7gqeUf0HUNhUqGP8HZivaZdmg@mail.gmail.com>
Subject: Re: [PATCH 00/23] docs: add basic sphinx-domain rST generator to
 qapidoc
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000e2c3c7062b4948f6"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--000000000000e2c3c7062b4948f6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025, 6:48=E2=80=AFAM Markus Armbruster <armbru@redhat.com> =
wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > On Thu, Dec 19, 2024 at 7:31=E2=80=AFAM Markus Armbruster <armbru@redha=
t.com>
> wrote:
> >
> >> John Snow <jsnow@redhat.com> writes:
> >>
> >> > based-on:
> >> https://patchew.org/QEMU/20241213011307.2942030-1-jsnow@redhat.com/
> >> >
> >> > Hi!
> >> >
> >> > This series is a very, very barebones implementation for the new QAP=
I
> >> > doc generator. It does not have many features that I presented on at
> KVM
> >> > Forum; the point of this patch set is instead to present a stripped
> down
> >> > basis for ongoing work so we can discuss on-list with full context o=
f
> >> > the code available to do so.
> >> >
> >> > The documentation this series generates is *not suitable* for
> replacing
> >> > the current document generator, it has a few glaring omissions - on
> >> > purpose - those features have been factored out intentionally so the=
y
> >> > can be reviewed with fuller context and more careful review.
> >> >
> >> > What this series does:
> >> >
> >> > - Adds the new "Transmogrifier" rST generator to qapidoc.py, which
> >> >   generates an in-memory rST document using qapi-domain directives.
> >> > - Adds a test document that showcases this new transmogrifier.
> >>
> >> Note to other reviewers: transmogrifier output is
> >> docs/manual/qapi/index.html.
> >>
> >> > What this series very notably does not do (yet):
> >> >
> >> > - "ifcond" data for anything other than top-level entities is not
> >> >   considered or rendered. This means "if" statements for features an=
d
> >> >   members are entirely absent.
> >> >
> >> > - The inliner is not present at all. This series renders only
> >> >   documentation exactly as it is exists in the source files.
> >>
> >> This item is not even a regression.
> >>
> >
> > No; but the version of this series as sent also does not add "The membe=
rs
> > of ..." stubs, which would be a regression.
>
> Right.
>
> >                                             I didn't necessarily intend
> for
> > this to be merged as-is; more of a "part one, with additional tricky
> > elements that require more careful thought isolated into separate patch=
es
> > for later".
> >
> > where "later" means "in v2" or "as a follow-up series as we stage thing=
s
> in
> > a development branch before final submission for inclusion to
> > origin/master" or whatever the actual mechanism is. I don't have a stro=
ng
> > vision there, really; I just wanted to nail down the basics out in the
> open
> > even if that was just between you (Markus) and I and we have a
> gentleman's
> > agreement that it looks tentatively OK.
>
> Got it.
>
> >> > - *branches* are themselves not considered at all; they're skipped
> >> >    entirely for now. They will be included alongside the inliner in
> >> >    either a subsequent series or a followup to this series.
> >> >
> >> > - Undocumented members and return statements are not autogenerated.
> >>
> >> The current doc generator auto-generates missing member documentation
> >> ("Not documented").  It doesn't auto-generate missing returns
> >> documentation.  I explored auto-generating them, but shelved my work t=
o
> >> not interfere with yours.
> >>
> >> > - Pseudofeatures (Things like allow-oob) are not generated as
> documented
> >> >   features.
> >>
> >> What exactly are "pseudofeatures"?
> >>
> >
> > What I've named things like allow-oob that aren't features, but ought t=
o
> be
> > documented. We may well decide to promote them to real-deal special
> > features, or maybe not. My work-in-progress branch currently just adds
> > "dummy" features to document them. We can discuss this later alongside
> the
> > patch that implements this.
>
> I agree this is a digression, so feel free to ignore the remainder of my
> reply for now.
>
> We have two kinds of flags in the QAPI schema language: features and ad
> hoc flags.  The ad hoc flags are 'boxed' (commands and events), 'gen',
> 'success-response', 'allow-oob', 'allow-preconfig', 'coroutine'
> (commands only).
>
> The flags sort into three buckets:
>
> 1. Code generation directives that do not affect the external interface,
> and thus should not be visible in introspection: 'boxed', 'gen',
> 'coroutine'.
>
> 2. Flags that are visible at the external interface, but don't affect
> code generation beyond making them visible in introspection: the
> non-special features.
>
> 3. Code generation directives that affect the external interface, and
> thus are (or should be) visible in introspection.
>
> 3a. The special features: are visible.
>
> 3b. 'allow-oob': is visible, but differently, because it predates
> special features.
>
> 3c. 'allow-preconfig': not visible.
>
> 3d. 'success-response': not visible, because we use it for QGA only,
> which doesn't provide introspection.
>
> Bucket 3 could use cleanup.
>

Yep. We can get into it on the pseudofeatures patch. Your analysis here
matches my understanding.


> [...]
>
>

--000000000000e2c3c7062b4948f6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 9, 2025, 6:48=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">John Snow &l=
t;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; On Thu, Dec 19, 2024 at 7:31=E2=80=AFAM Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com" target=3D"_blank" rel=3D"noreferrer">armbru@r=
edhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank=
" rel=3D"noreferrer">jsnow@redhat.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; based-on:<br>
&gt;&gt; <a href=3D"https://patchew.org/QEMU/20241213011307.2942030-1-jsnow=
@redhat.com/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://patch=
ew.org/QEMU/20241213011307.2942030-1-jsnow@redhat.com/</a><br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Hi!<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; This series is a very, very barebones implementation for the =
new QAPI<br>
&gt;&gt; &gt; doc generator. It does not have many features that I presente=
d on at KVM<br>
&gt;&gt; &gt; Forum; the point of this patch set is instead to present a st=
ripped down<br>
&gt;&gt; &gt; basis for ongoing work so we can discuss on-list with full co=
ntext of<br>
&gt;&gt; &gt; the code available to do so.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; The documentation this series generates is *not suitable* for=
 replacing<br>
&gt;&gt; &gt; the current document generator, it has a few glaring omission=
s - on<br>
&gt;&gt; &gt; purpose - those features have been factored out intentionally=
 so they<br>
&gt;&gt; &gt; can be reviewed with fuller context and more careful review.<=
br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; What this series does:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; - Adds the new &quot;Transmogrifier&quot; rST generator to qa=
pidoc.py, which<br>
&gt;&gt; &gt;=C2=A0 =C2=A0generates an in-memory rST document using qapi-do=
main directives.<br>
&gt;&gt; &gt; - Adds a test document that showcases this new transmogrifier=
.<br>
&gt;&gt;<br>
&gt;&gt; Note to other reviewers: transmogrifier output is<br>
&gt;&gt; docs/manual/qapi/index.html.<br>
&gt;&gt;<br>
&gt;&gt; &gt; What this series very notably does not do (yet):<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; - &quot;ifcond&quot; data for anything other than top-level e=
ntities is not<br>
&gt;&gt; &gt;=C2=A0 =C2=A0considered or rendered. This means &quot;if&quot;=
 statements for features and<br>
&gt;&gt; &gt;=C2=A0 =C2=A0members are entirely absent.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; - The inliner is not present at all. This series renders only=
<br>
&gt;&gt; &gt;=C2=A0 =C2=A0documentation exactly as it is exists in the sour=
ce files.<br>
&gt;&gt;<br>
&gt;&gt; This item is not even a regression.<br>
&gt;&gt;<br>
&gt;<br>
&gt; No; but the version of this series as sent also does not add &quot;The=
 members<br>
&gt; of ...&quot; stubs, which would be a regression.<br>
<br>
Right.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0I didn&#39;t necessarily intend for<br>
&gt; this to be merged as-is; more of a &quot;part one, with additional tri=
cky<br>
&gt; elements that require more careful thought isolated into separate patc=
hes<br>
&gt; for later&quot;.<br>
&gt;<br>
&gt; where &quot;later&quot; means &quot;in v2&quot; or &quot;as a follow-u=
p series as we stage things in<br>
&gt; a development branch before final submission for inclusion to<br>
&gt; origin/master&quot; or whatever the actual mechanism is. I don&#39;t h=
ave a strong<br>
&gt; vision there, really; I just wanted to nail down the basics out in the=
 open<br>
&gt; even if that was just between you (Markus) and I and we have a gentlem=
an&#39;s<br>
&gt; agreement that it looks tentatively OK.<br>
<br>
Got it.<br>
<br>
&gt;&gt; &gt; - *branches* are themselves not considered at all; they&#39;r=
e skipped<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 entirely for now. They will be included alongsid=
e the inliner in<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 either a subsequent series or a followup to this=
 series.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; - Undocumented members and return statements are not autogene=
rated.<br>
&gt;&gt;<br>
&gt;&gt; The current doc generator auto-generates missing member documentat=
ion<br>
&gt;&gt; (&quot;Not documented&quot;).=C2=A0 It doesn&#39;t auto-generate m=
issing returns<br>
&gt;&gt; documentation.=C2=A0 I explored auto-generating them, but shelved =
my work to<br>
&gt;&gt; not interfere with yours.<br>
&gt;&gt;<br>
&gt;&gt; &gt; - Pseudofeatures (Things like allow-oob) are not generated as=
 documented<br>
&gt;&gt; &gt;=C2=A0 =C2=A0features.<br>
&gt;&gt;<br>
&gt;&gt; What exactly are &quot;pseudofeatures&quot;?<br>
&gt;&gt;<br>
&gt;<br>
&gt; What I&#39;ve named things like allow-oob that aren&#39;t features, bu=
t ought to be<br>
&gt; documented. We may well decide to promote them to real-deal special<br=
>
&gt; features, or maybe not. My work-in-progress branch currently just adds=
<br>
&gt; &quot;dummy&quot; features to document them. We can discuss this later=
 alongside the<br>
&gt; patch that implements this.<br>
<br>
I agree this is a digression, so feel free to ignore the remainder of my<br=
>
reply for now.<br>
<br>
We have two kinds of flags in the QAPI schema language: features and ad<br>
hoc flags.=C2=A0 The ad hoc flags are &#39;boxed&#39; (commands and events)=
, &#39;gen&#39;,<br>
&#39;success-response&#39;, &#39;allow-oob&#39;, &#39;allow-preconfig&#39;,=
 &#39;coroutine&#39;<br>
(commands only).<br>
<br>
The flags sort into three buckets:<br>
<br>
1. Code generation directives that do not affect the external interface,<br=
>
and thus should not be visible in introspection: &#39;boxed&#39;, &#39;gen&=
#39;,<br>
&#39;coroutine&#39;.<br>
<br>
2. Flags that are visible at the external interface, but don&#39;t affect<b=
r>
code generation beyond making them visible in introspection: the<br>
non-special features.<br>
<br>
3. Code generation directives that affect the external interface, and<br>
thus are (or should be) visible in introspection.<br>
<br>
3a. The special features: are visible.<br>
<br>
3b. &#39;allow-oob&#39;: is visible, but differently, because it predates<b=
r>
special features.<br>
<br>
3c. &#39;allow-preconfig&#39;: not visible.<br>
<br>
3d. &#39;success-response&#39;: not visible, because we use it for QGA only=
,<br>
which doesn&#39;t provide introspection.<br>
<br>
Bucket 3 could use cleanup.<br></blockquote></div></div><div dir=3D"auto"><=
br></div><div dir=3D"auto">Yep. We can get into it on the pseudofeatures pa=
tch. Your analysis here matches my understanding.</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container">=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
[...]<br>
<br>
</blockquote></div></div></div>

--000000000000e2c3c7062b4948f6--


