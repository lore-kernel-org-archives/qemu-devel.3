Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B696C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 16:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxrA9-0003nU-IF; Fri, 19 Apr 2024 12:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxr9n-0003ku-JB
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:32:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxr9h-0006Se-Oc
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 12:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713544324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gW2Aj3EkAeLPhAU4Sj2nrmNc048XAISkp0dIiXBRW/0=;
 b=Ei9zdUzOdzVB+yUK9/6BgAe9KjjWeTBq+GE4SXjD+s3spwcz/wu//kykbXj3JIoNEfcUD/
 hyg3u7f9ryBnjZwY5/ad+BEsyo74sInTkzs3NKtMNvYW5pliDgAVskbG+kbZZDX0FSFS1u
 Msh//xzhmYkjaGfpzz3AphZc9wL47dA=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-oHXve9hCO06JjxmEH4l6Cw-1; Fri, 19 Apr 2024 12:32:02 -0400
X-MC-Unique: oHXve9hCO06JjxmEH4l6Cw-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1e8f68d0a67so5881935ad.0
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 09:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713544321; x=1714149121;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gW2Aj3EkAeLPhAU4Sj2nrmNc048XAISkp0dIiXBRW/0=;
 b=VPZ1YtfTbw3YMdaLZsDDmNQzSIkLr/5cTgaChID6H18KHOuk6abAakRtsSAM0CyAvJ
 7DV/r+0q4RdqvPB8lcsTIyyShAaWw2TFx1CD2QPK/SXF/SNfOhXRTjKCxSxnNef1TMjZ
 kgWy8qDlMRmNL6Z+D7yIuosEUlO54Y4DZlSxbVfKmSSqUhtdnDf5OXxZbdn6Jj7Upar1
 sBxSRHkBPRZyXlR5CMyI4lPPzgV16ZmLP0FuewjroIcWtSmkBQdo+D5R9Sf+HRyWkx+u
 NMr0jfGDEn1neyBJ/7uHB9SuDGVwGrBuHf4I5zKKLskoTIcthW9M1ZGSEtecgOgUCEqw
 mtrw==
X-Gm-Message-State: AOJu0YzDbGlMxbZNWyb3sqmBKrZ78W9gaVwARer43ggolFAQieLuAQMy
 vc6+kl5jgvwNKewlq/3KquVOoLJgmYF3+4+L1rcPV9e+RwECQYPt3wpEa7WEaevrN9MIbRWdOTQ
 chc9tTwgdAXNiT6I35iNxl7uJ+gvhiu9VIIi6MYZZute0eeo3l1dp5dmsxrl5XXMxeY5BMjYsYn
 yiud76BtSoRZpBCqmNIMpdWnU24Sk=
X-Received: by 2002:a17:902:f7d6:b0:1e4:4045:481b with SMTP id
 h22-20020a170902f7d600b001e44045481bmr2256181plw.29.1713544321389; 
 Fri, 19 Apr 2024 09:32:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/j3g6c7GEI5BCfwco3VO5BqH2dmKq2F5EU8zo/f8xL306TSca1eajtJv7t4ijMO7n9wxbCui3NVim+dWijYY=
X-Received: by 2002:a17:902:f7d6:b0:1e4:4045:481b with SMTP id
 h22-20020a170902f7d600b001e44045481bmr2256162plw.29.1713544320939; Fri, 19
 Apr 2024 09:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240419043820.178731-1-jsnow@redhat.com>
 <87msppl8c8.fsf@pond.sub.org>
In-Reply-To: <87msppl8c8.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 19 Apr 2024 12:31:48 -0400
Message-ID: <CAFn=p-YaP+qg8C9iQUHkk_03gqnuhA0Ps6pcUeZuCiiScSTVpQ@mail.gmail.com>
Subject: Re: [PATCH 00/27] Add qapi-domain Sphinx extension
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008ea648061675a0e9"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.313,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
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

--0000000000008ea648061675a0e9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024, 10:45=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > This series adds a new qapi-domain extension for Sphinx, which adds a
> > series of custom directives for documenting QAPI definitions.
> >
> > GitLab CI: https://gitlab.com/jsnow/qemu/-/pipelines/1259566476
> >
> > (Link to a demo HTML page at the end of this cover letter, but I want
> > you to read the cover letter first to explain what you're seeing.)
> >
> > This adds a new QAPI Index page, cross-references for QMP commands,
> > events, and data types, and improves the aesthetics of the QAPI/QMP
> > documentation.
>
> Cross-references alone will be a *massive* improvement!  I'm sure
> readers will appreciate better looks and an index, too.
>
> > This series adds only the new ReST syntax, *not* the autogenerator. The
> > ReST syntax used in this series is, in general, not intended for anyone
> > to actually write by hand. This mimics how Sphinx's own autodoc
> > extension generates Python domain directives, which are then re-parsed
> > to produce the final result.
> >
> > I have prototyped such a generator, but it isn't ready for inclusion
> > yet. (Rest assured: error context reporting is preserved down to the
> > line, even in generated ReST. There is no loss in usability for this
> > approach. It will likely either supplant qapidoc.py or heavily alter
> > it.) The generator requires only extremely minor changes to
> > scripts/qapi/parser.py to preserve nested indentation and provide more
> > accurate line information. It is less invasive than you may
> > fear. Relying on a secondary ReST parse phase eliminates much of the
> > complexity of qapidoc.py. Sleep soundly.
>
> I'm a Sphinx noob.  Let me paraphrase you to make sure I understand.
>
> You proprose to generate formatted documentation in two steps:
>
> =E2=80=A2 First, the QAPI generator generates .rst from the QAPI schema. =
 The
>   generated .rst makes use of a custom directives.
>

Yes, but this .rst file is built in-memory and never makes it to disk, like
Sphinx's autodoc for Python.

(We can add a debug knob to log it or save it out to disk if needed.)


> =E2=80=A2 Second, Sphinx turns the .rst into formatted documentation.  A =
Sphinx
>   qapi-domain extension implements the custom directives
>

Yes.


> This mirrors how Sphinx works for Python docs.  Which is its original
> use case.
>
> Your series demonstrates the second step, with test input you wrote
> manually.
>
> You have code for the first step, but you'd prefer to show it later.
>

Right, it's not fully finished, although I have events, commands, and
objects working. Unions, Alternates and Events need work.


> Fair?
>

Bingo!


> > The purpose of sending this series in its current form is largely to
> > solicit feedback on general aesthetics, layout, and features. Sphinx is
> > a wily beast, and feedback at this stage will dictate how and where
> > certain features are implemented.
>
> I'd appreciate help with that.  Opinions?


> > A goal for this syntax (and the generator) is to fully in-line all
> > command/event/object members, inherited or local, boxed or not, branche=
d
> > or not. This should provide a boon to using these docs as a reference,
> > because users will not have to grep around the page looking for various
> > types, branches, or inherited members. Any arguments types will be
> > hyperlinked to their definition, further aiding usability. Commands can
> > be hotlinked from anywhere else in the manual, and will provide a
> > complete reference directly on the first screenful of information.
>
> Let me elaborate a bit here.
>
> A command's arguments can be specified inline, like so:
>
>     { 'command': 'job-cancel', 'data': { 'id': 'str' } }
>
> The arguments are then documented right with the command.
>
> But they can also be specified by referencing an object type, like so:
>
>     { 'command': 'block-dirty-bitmap-remove',
>       'data': 'BlockDirtyBitmap' }
>
> Reasons for doing it this way:
>
> =E2=80=A2 Several commands take the same arguments, and you don't want to=
 repeat
>   yourself.
>
> =E2=80=A2 You want generated C take a single struct argument ('boxed': tr=
ue).
>
> =E2=80=A2 The arguments are a union (which requires 'boxed': true).
>
> Drawback: the arguments are then documented elsewhere.  Not nice.
>
> Bug: the generated documentation fails to point there.
>
> You're proposing to inline the argument documentation, so it appears
> right with the command.
>
> An event's data is just like a command's argument.
>
> A command's return value can only specified by referencing a type.  Same
> doc usability issue.
>
> Similarly, a union type's base can specified inline or by referencing a
> struct type, and a union's branches must be specified by referencing a
> struct type.  Same doc usability issue.
>
> At least, the generated documentation does point to the referenced
> types.
>

Right. My proposal is to recursively inline referenced bases for the
top-level members so that this manual is useful as a user reference,
without worrying about the actual QAPI structure.

Return types will just be hotlinked.


> > (Okay, maybe two screenfuls for commands with a ton of
> > arguments... There's only so much I can do!)
>
> *cough* blockdev-add *cough*


> > This RFC series includes a "sandbox" .rst document that showcases the
> > features of this domain by writing QAPI directives by hand; this
> > document will be removed from the series before final inclusion. It's
> > here to serve as a convenient test-bed for y'all to give feedback.
> >
> > All that said, here's the sandbox document fully rendered:
> > https://jsnow.gitlab.io/qemu/qapi/index.html
> >
> > And here's the new QAPI index page created by that sandbox document:
> > https://jsnow.gitlab.io/qemu/qapi-index.html
> >
> > Known issues / points of interest:
> >
> > - The formatting upsets checkpatch. The default line length for the
> >   "black" formatting tool is a little long. I'll fix it next spin.
> >
> > - I did my best to preserve cross-version compatibility, but some
> >   problems have crept in here and there. This series may require
> >   Sphinx>=3D 4.0, like the dbus extension. Notably, the Ubuntu build fa=
ils
> >   on Gitlab CI currently. The next version will text against more Sphin=
x
> >   versions more rigorously. Sphinx version 5.3.0 and above should work
> >   perfectly.
> >
> > - There's a bug in Sphinx itself that may manifest in your testing,
> >   concerning reported error locations. There's a patch in this series
> >   that fixes it, but it's later in the series. If you run into the bug
> >   while testing with this series, try applying that patch first.
> >
> > - QAPI 'namespaces' aren't yet handled. i.e., there's nothing to
> >   distinguish entities between QMP, QGA and QSD yet. That feature will
> >   be added to a future version of this patchset (Likely when the
> >   generator is ready for inclusion: without it, references will clash
> >   and the index will gripe about duplicated entries.)
>
> qemu-storage-daemon's QMP is a proper subset of qemu-system-FOO's.
> Regardless, each of them has its own, independent reference manual.
> That's defensible.
>
> But the way we build them can complicate matters.  For instance, when I
> tried to elide types not used for QMP from the reference manuals, I got
> defeated by Sphinx caching.
>

I haven't tried yet, but I believe it should be possible to "tag" each
referenced QAPI object and mark it as "visited". Each namespaced definition
would be tagged separately.

(i.e. qemu.block-core.blockdev-backup and qsd.block-core.blockdev-backup
would be two distinct entities.)

Then, the renderer could ignore/squelch untagged entities. (I think.)

Maybe some work to do to un-index unvisited entities.

Or we can go the other route and bake this info into the schema and squelch
stuff earlier. We can add this feature later. I am still not sure why your
prototype for this ran into cache issues, but I am convinced it should be
fixable by making namespaced entities distinct.

We could perhaps bake the namespace into the qapidoc directive, e.g.:

 .. qapi:autodoc:: schema.json
   :namespace: QSD

(And the default adds no namespace.)


> > - Per-member features and ifcond are not yet accounted for; though
> >   definition-scoped features and ifconds are. Please feel free to
> >   suggest how you'd like to see those represented.
> >
> > - Inlining all members means there is some ambiguity on what to do with
> >   doc block sections on inlined entities; features and members have an
> >   obvious home - body, since, and misc sections are not as obvious on
> >   how to handle. This will feature more prominently in the generator
> >   series.
>
> Yes, this is a real problem.
>
> The member documentation gets written in the context of the type.  It
> may make sense only in that context.  Inlining copies it into a
> different context.


> Features may need to combine.  Say a command's arguments are a union
> type, and several branches of the union both contain deprecated members.
> These branch types all document feature @deprecated.  Simply inlining
> their feature documentation results in feature @deprecated documented
> several times.  Ugh.  Combining them would be better.  But how?  Do we
> need to rethink how we document features?
>

To be honest, I figured I'd plow ahead and then find the counter-examples
programmatically and decide what to do once I had my pile of edge cases.

It might involve rewriting docs in some places, but I think the usability
win is completely worth the hassle.

It's possible there might be some rework needed to maximize cogency of the
generated docs, but I think prioritizing a user-facing reference for QMP is
the objectively correct end goal and I'm more than happy to work backwards
from that desired state.


> > - Some features could be implemented in either the QAPI domain syntax
> >   *or* the generator, or some combination of both. Depending on
> >   aesthetic feedback, this may influence where those features should be
> >   implemented.
> >
> > - The formatting and aesthetics of branches are a little up in the air,
> >   see the qapi:union patch for more details.
> >
> > - It's late, maybe other things. Happy Friday!
> >
> > Hope you like it!
>
> Looks promising!
>

Fingers crossed. This has bothered me about QEMU for years.

--js

>

--0000000000008ea648061675a0e9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"auto"><div><br><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Apr 19, 2024, 10:45=E2=80=AFA=
M Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" rel=3D"norefer=
rer" target=3D"_blank">armbru@redhat.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" rel=
=3D"noreferrer noreferrer" target=3D"_blank">jsnow@redhat.com</a>&gt; write=
s:<br>
<br>
&gt; This series adds a new qapi-domain extension for Sphinx, which adds a<=
br>
&gt; series of custom directives for documenting QAPI definitions.<br>
&gt;<br>
&gt; GitLab CI: <a href=3D"https://gitlab.com/jsnow/qemu/-/pipelines/125956=
6476" rel=3D"noreferrer noreferrer noreferrer" target=3D"_blank">https://gi=
tlab.com/jsnow/qemu/-/pipelines/1259566476</a><br>
&gt;<br>
&gt; (Link to a demo HTML page at the end of this cover letter, but I want<=
br>
&gt; you to read the cover letter first to explain what you&#39;re seeing.)=
<br>
&gt;<br>
&gt; This adds a new QAPI Index page, cross-references for QMP commands,<br=
>
&gt; events, and data types, and improves the aesthetics of the QAPI/QMP<br=
>
&gt; documentation.<br>
<br>
Cross-references alone will be a *massive* improvement!=C2=A0 I&#39;m sure<=
br>
readers will appreciate better looks and an index, too.<br>
<br>
&gt; This series adds only the new ReST syntax, *not* the autogenerator. Th=
e<br>
&gt; ReST syntax used in this series is, in general, not intended for anyon=
e<br>
&gt; to actually write by hand. This mimics how Sphinx&#39;s own autodoc<br=
>
&gt; extension generates Python domain directives, which are then re-parsed=
<br>
&gt; to produce the final result.<br>
&gt;<br>
&gt; I have prototyped such a generator, but it isn&#39;t ready for inclusi=
on<br>
&gt; yet. (Rest assured: error context reporting is preserved down to the<b=
r>
&gt; line, even in generated ReST. There is no loss in usability for this<b=
r>
&gt; approach. It will likely either supplant qapidoc.py or heavily alter<b=
r>
&gt; it.) The generator requires only extremely minor changes to<br>
&gt; scripts/qapi/parser.py to preserve nested indentation and provide more=
<br>
&gt; accurate line information. It is less invasive than you may<br>
&gt; fear. Relying on a secondary ReST parse phase eliminates much of the<b=
r>
&gt; complexity of qapidoc.py. Sleep soundly.<br>
<br>
I&#39;m a Sphinx noob.=C2=A0 Let me paraphrase you to make sure I understan=
d.<br>
<br>
You proprose to generate formatted documentation in two steps:<br>
<br>
=E2=80=A2 First, the QAPI generator generates .rst from the QAPI schema.=C2=
=A0 The<br>
=C2=A0 generated .rst makes use of a custom directives.<br></blockquote></d=
iv></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yes, but this .rst f=
ile is built in-memory and never makes it to disk, like Sphinx&#39;s autodo=
c for Python.</div><div dir=3D"auto"><br></div><div dir=3D"auto">(We can ad=
d a debug knob to log it or save it out to disk if needed.)</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
<br>
=E2=80=A2 Second, Sphinx turns the .rst into formatted documentation.=C2=A0=
 A Sphinx<br>
=C2=A0 qapi-domain extension implements the custom directives<br></blockquo=
te></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yes.</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">
<br>
This mirrors how Sphinx works for Python docs.=C2=A0 Which is its original<=
br>
use case.<br>
<br>
Your series demonstrates the second step, with test input you wrote<br>
manually.<br>
<br>
You have code for the first step, but you&#39;d prefer to show it later.<br=
></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Rig=
ht, it&#39;s not fully finished, although I have events, commands, and obje=
cts working. Unions, Alternates and Events need work.</div><div dir=3D"auto=
"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<br>
Fair?<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Bingo!=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div c=
lass=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; The purpose of sending this series in its current form is largely to<b=
r>
&gt; solicit feedback on general aesthetics, layout, and features. Sphinx i=
s<br>
&gt; a wily beast, and feedback at this stage will dictate how and where<br=
>
&gt; certain features are implemented.<br>
<br>
I&#39;d appreciate help with that.=C2=A0 Opinions?</blockquote></div></div>=
<div dir=3D"auto"></div><div dir=3D"auto"><div class=3D"gmail_quote"><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">
<br>
&gt; A goal for this syntax (and the generator) is to fully in-line all<br>
&gt; command/event/object members, inherited or local, boxed or not, branch=
ed<br>
&gt; or not. This should provide a boon to using these docs as a reference,=
<br>
&gt; because users will not have to grep around the page looking for variou=
s<br>
&gt; types, branches, or inherited members. Any arguments types will be<br>
&gt; hyperlinked to their definition, further aiding usability. Commands ca=
n<br>
&gt; be hotlinked from anywhere else in the manual, and will provide a<br>
&gt; complete reference directly on the first screenful of information.<br>
<br>
Let me elaborate a bit here.<br>
<br>
A command&#39;s arguments can be specified inline, like so:<br>
<br>
=C2=A0 =C2=A0 { &#39;command&#39;: &#39;job-cancel&#39;, &#39;data&#39;: { =
&#39;id&#39;: &#39;str&#39; } }<br>
<br>
The arguments are then documented right with the command.<br>
<br>
But they can also be specified by referencing an object type, like so:<br>
<br>
=C2=A0 =C2=A0 { &#39;command&#39;: &#39;block-dirty-bitmap-remove&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 &#39;data&#39;: &#39;BlockDirtyBitmap&#39; }<br>
<br>
Reasons for doing it this way:<br>
<br>
=E2=80=A2 Several commands take the same arguments, and you don&#39;t want =
to repeat<br>
=C2=A0 yourself.<br>
<br>
=E2=80=A2 You want generated C take a single struct argument (&#39;boxed&#3=
9;: true).<br>
<br>
=E2=80=A2 The arguments are a union (which requires &#39;boxed&#39;: true).=
<br>
<br>
Drawback: the arguments are then documented elsewhere.=C2=A0 Not nice.<br>
<br>
Bug: the generated documentation fails to point there.<br>
<br>
You&#39;re proposing to inline the argument documentation, so it appears<br=
>
right with the command.<br>
<br>
An event&#39;s data is just like a command&#39;s argument.<br>
<br>
A command&#39;s return value can only specified by referencing a type.=C2=
=A0 Same<br>
doc usability issue.<br>
<br>
Similarly, a union type&#39;s base can specified inline or by referencing a=
<br>
struct type, and a union&#39;s branches must be specified by referencing a<=
br>
struct type.=C2=A0 Same doc usability issue.<br>
<br>
At least, the generated documentation does point to the referenced<br>
types.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">Right. My proposal is to recursively inline referenced bases for the =
top-level members so that this manual is useful as a user reference, withou=
t worrying about the actual QAPI structure.</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">Return types will just be hotlinked.</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">
<br>
&gt; (Okay, maybe two screenfuls for commands with a ton of<br>
&gt; arguments... There&#39;s only so much I can do!)<br>
<br>
*cough* blockdev-add *cough*</blockquote></div></div><div dir=3D"auto"><div=
 class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; This RFC series includes a &quot;sandbox&quot; .rst document that show=
cases the<br>
&gt; features of this domain by writing QAPI directives by hand; this<br>
&gt; document will be removed from the series before final inclusion. It&#3=
9;s<br>
&gt; here to serve as a convenient test-bed for y&#39;all to give feedback.=
<br>
&gt;<br>
&gt; All that said, here&#39;s the sandbox document fully rendered:<br>
&gt; <a href=3D"https://jsnow.gitlab.io/qemu/qapi/index.html" rel=3D"norefe=
rrer noreferrer noreferrer" target=3D"_blank">https://jsnow.gitlab.io/qemu/=
qapi/index.html</a><br>
&gt;<br>
&gt; And here&#39;s the new QAPI index page created by that sandbox documen=
t:<br>
&gt; <a href=3D"https://jsnow.gitlab.io/qemu/qapi-index.html" rel=3D"norefe=
rrer noreferrer noreferrer" target=3D"_blank">https://jsnow.gitlab.io/qemu/=
qapi-index.html</a><br>
&gt;<br>
&gt; Known issues / points of interest:<br>
&gt;<br>
&gt; - The formatting upsets checkpatch. The default line length for the<br=
>
&gt;=C2=A0 =C2=A0&quot;black&quot; formatting tool is a little long. I&#39;=
ll fix it next spin.<br>
&gt;<br>
&gt; - I did my best to preserve cross-version compatibility, but some<br>
&gt;=C2=A0 =C2=A0problems have crept in here and there. This series may req=
uire<br>
&gt;=C2=A0 =C2=A0Sphinx&gt;=3D 4.0, like the dbus extension. Notably, the U=
buntu build fails<br>
&gt;=C2=A0 =C2=A0on Gitlab CI currently. The next version will text against=
 more Sphinx<br>
&gt;=C2=A0 =C2=A0versions more rigorously. Sphinx version 5.3.0 and above s=
hould work<br>
&gt;=C2=A0 =C2=A0perfectly.<br>
&gt;<br>
&gt; - There&#39;s a bug in Sphinx itself that may manifest in your testing=
,<br>
&gt;=C2=A0 =C2=A0concerning reported error locations. There&#39;s a patch i=
n this series<br>
&gt;=C2=A0 =C2=A0that fixes it, but it&#39;s later in the series. If you ru=
n into the bug<br>
&gt;=C2=A0 =C2=A0while testing with this series, try applying that patch fi=
rst.<br>
&gt;<br>
&gt; - QAPI &#39;namespaces&#39; aren&#39;t yet handled. i.e., there&#39;s =
nothing to<br>
&gt;=C2=A0 =C2=A0distinguish entities between QMP, QGA and QSD yet. That fe=
ature will<br>
&gt;=C2=A0 =C2=A0be added to a future version of this patchset (Likely when=
 the<br>
&gt;=C2=A0 =C2=A0generator is ready for inclusion: without it, references w=
ill clash<br>
&gt;=C2=A0 =C2=A0and the index will gripe about duplicated entries.)<br>
<br>
qemu-storage-daemon&#39;s QMP is a proper subset of qemu-system-FOO&#39;s.<=
br>
Regardless, each of them has its own, independent reference manual.<br>
That&#39;s defensible.<br>
<br>
But the way we build them can complicate matters.=C2=A0 For instance, when =
I<br>
tried to elide types not used for QMP from the reference manuals, I got<br>
defeated by Sphinx caching.<br></blockquote></div></div><div dir=3D"auto"><=
br></div><div dir=3D"auto">I haven&#39;t tried yet, but I believe it should=
 be possible to &quot;tag&quot; each referenced QAPI object and mark it as =
&quot;visited&quot;. Each namespaced definition would be tagged separately.=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">(i.e. qemu.block-core.b=
lockdev-backup and qsd.block-core.blockdev-backup would be two distinct ent=
ities.)</div><div dir=3D"auto"><br></div><div dir=3D"auto">Then, the render=
er could ignore/squelch untagged entities. (I think.)</div><div dir=3D"auto=
"><br></div><div dir=3D"auto">Maybe some work to do to un-index unvisited e=
ntities.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Or we can go th=
e other route and bake this info into the schema and squelch stuff earlier.=
 We can add this feature later. I am still not sure why your prototype for =
this ran into cache issues, but I am convinced it should be fixable by maki=
ng namespaced entities distinct.</div><div dir=3D"auto"><br></div><div>We c=
ould perhaps bake the namespace into the qapidoc directive, e.g.:</div><div=
><br></div><div>=C2=A0.. qapi:autodoc:: schema.json</div><div>=C2=A0=C2=A0 =
:namespace: QSD<br></div><div dir=3D"auto"><br></div><div>(And the default =
adds no namespace.)</div><div><br></div><div dir=3D"auto"><div class=3D"gma=
il_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; - Per-member features and ifcond are not yet accounted for; though<br>
&gt;=C2=A0 =C2=A0definition-scoped features and ifconds are. Please feel fr=
ee to<br>
&gt;=C2=A0 =C2=A0suggest how you&#39;d like to see those represented.<br>
&gt;<br>
&gt; - Inlining all members means there is some ambiguity on what to do wit=
h<br>
&gt;=C2=A0 =C2=A0doc block sections on inlined entities; features and membe=
rs have an<br>
&gt;=C2=A0 =C2=A0obvious home - body, since, and misc sections are not as o=
bvious on<br>
&gt;=C2=A0 =C2=A0how to handle. This will feature more prominently in the g=
enerator<br>
&gt;=C2=A0 =C2=A0series.<br>
<br>
Yes, this is a real problem.<br>
<br>
The member documentation gets written in the context of the type.=C2=A0 It<=
br>
may make sense only in that context.=C2=A0 Inlining copies it into a<br>
different context.</blockquote></div></div><div dir=3D"auto"><div class=3D"=
gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">
<br>
Features may need to combine.=C2=A0 Say a command&#39;s arguments are a uni=
on<br>
type, and several branches of the union both contain deprecated members.<br=
>
These branch types all document feature @deprecated.=C2=A0 Simply inlining<=
br>
their feature documentation results in feature @deprecated documented<br>
several times.=C2=A0 Ugh.=C2=A0 Combining them would be better.=C2=A0 But h=
ow?=C2=A0 Do we<br>
need to rethink how we document features?<br></blockquote></div></div><div =
dir=3D"auto"><br></div><div dir=3D"auto">To be honest, I figured I&#39;d pl=
ow ahead and then find the counter-examples programmatically and decide wha=
t to do once I had my pile of edge cases.</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">It might involve rewriting docs in some places, but I thi=
nk the usability win is completely worth the hassle.</div><div dir=3D"auto"=
><br></div><div dir=3D"auto">It&#39;s possible there might be some rework n=
eeded to maximize cogency of the generated docs, but I think prioritizing a=
 user-facing reference for QMP is the objectively correct end goal and I&#3=
9;m more than happy to work backwards from that desired state.</div><div di=
r=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">
<br>
&gt; - Some features could be implemented in either the QAPI domain syntax<=
br>
&gt;=C2=A0 =C2=A0*or* the generator, or some combination of both. Depending=
 on<br>
&gt;=C2=A0 =C2=A0aesthetic feedback, this may influence where those feature=
s should be<br>
&gt;=C2=A0 =C2=A0implemented.<br>
&gt;<br>
&gt; - The formatting and aesthetics of branches are a little up in the air=
,<br>
&gt;=C2=A0 =C2=A0see the qapi:union patch for more details.<br>
&gt;<br>
&gt; - It&#39;s late, maybe other things. Happy Friday!<br>
&gt;<br>
&gt; Hope you like it!<br>
<br>
Looks promising!<br></blockquote></div></div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Fingers crossed. This has bothered me about QEMU for years.=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">--js</div><div dir=3D"a=
uto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>
</div>

--0000000000008ea648061675a0e9--


