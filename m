Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F177C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 16:40:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rywhH-0006ko-Jq; Mon, 22 Apr 2024 12:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rywhB-0006kR-79
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 12:39:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rywh8-0007rk-4R
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 12:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713803943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4EeAcg7r9X8ql6sKVUlN2OoIHX7pzbShKcrDBtcF9bs=;
 b=BziRMbuq1I/sCaoI2KcptBgJNYBuZ4Rfu1qf8YzOaXT52HVJP3VWhIvZ0yRzmuj/xFzrUa
 aaTsuGr/uEbrUs++uJxlSfApgsHNYUIa3lGWm2XymQXavAnra34q+MVbAjmUa8lGlJV9LU
 aZtfjV9OYYhT6q8klrQAihYpX18PDW8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-POvoQ5TNPSKJhuPN8qO6nQ-1; Mon, 22 Apr 2024 12:39:02 -0400
X-MC-Unique: POvoQ5TNPSKJhuPN8qO6nQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2a4a2cace80so5221167a91.3
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 09:39:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713803941; x=1714408741;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4EeAcg7r9X8ql6sKVUlN2OoIHX7pzbShKcrDBtcF9bs=;
 b=Y15DY5l87WzsFhMWKEsSZ51SOWnUvxhSoZofxxATfoHvPrczp0YkGOnCOSoYywMdLH
 BXYa9Hg+rOp254t1YwJYH7doWPuZing77PNqoDEBT3+XVHpO7XQZqbIhfcWdRAZo0yAm
 b/6GpkLb67x7G7ZYUMStR8eyFySJs943TlDxRWnyINvvQwgl+Aw/xrX9y38Bb5ArYAE9
 fro5LlG8Ns1iI312TDim5Q42J/UKWIGna8LXEY4dxlFXFDe8dwqCbQ4BTcm0P8EhVqra
 BY8O/r8rK7Yczi1+Rlicb3M3eIqrM+hT+pRYCt7cRxOVy0rsQBXjy+OYttva+OD7IciF
 iz2Q==
X-Gm-Message-State: AOJu0YxlmDN03Om9ArY6cWV8LcS50NsSAKCDBP/HXS4BgPppuWejx9N5
 +oWUpfME8UPgEUHXA3iu4t7vPiUymRpIdKYCgYY1KikzxHEst34X0e/JhTVmH+T5rK3UacdAj9Y
 BTwoeJfBjuFlvalhQfkwpKRRNxPUYcCOl5H1Ps+tkjBne1/juhgFzuJR7O3ozD74/66OPckO2W/
 xuVjk+F+uiCCcx8E2Ec+B0PbkgVmQ=
X-Received: by 2002:a17:90a:4089:b0:2ab:b842:9870 with SMTP id
 l9-20020a17090a408900b002abb8429870mr8245467pjg.4.1713803940706; 
 Mon, 22 Apr 2024 09:39:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF14Pl243vYxGzofWGkr/q0KkPrBO6M+OqYNS8QgPbRUBNBXLQSR7pB4VdMwLmwOVmimbTZZsPLhDvPkpyJAJk=
X-Received: by 2002:a17:90a:4089:b0:2ab:b842:9870 with SMTP id
 l9-20020a17090a408900b002abb8429870mr8245424pjg.4.1713803940144; Mon, 22 Apr
 2024 09:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240419043820.178731-1-jsnow@redhat.com>
 <87msppl8c8.fsf@pond.sub.org>
 <CAFn=p-YaP+qg8C9iQUHkk_03gqnuhA0Ps6pcUeZuCiiScSTVpQ@mail.gmail.com>
 <87wmopg3ez.fsf@pond.sub.org>
In-Reply-To: <87wmopg3ez.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 22 Apr 2024 12:38:47 -0400
Message-ID: <CAFn=p-bXLbn1o1f+jsFUP502yak0r4yNvAYjTz4MMXShygQQ7g@mail.gmail.com>
Subject: Re: [PATCH 00/27] Add qapi-domain Sphinx extension
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Apr 22, 2024 at 5:20=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> John Snow <jsnow@redhat.com> writes:
>
> > On Fri, Apr 19, 2024, 10:45=E2=80=AFAM Markus Armbruster <armbru@redhat=
.com> wrote:
> >
> >> John Snow <jsnow@redhat.com> writes:
> >>
> >> > This series adds a new qapi-domain extension for Sphinx, which adds =
a
> >> > series of custom directives for documenting QAPI definitions.
> >> >
> >> > GitLab CI: https://gitlab.com/jsnow/qemu/-/pipelines/1259566476
> >> >
> >> > (Link to a demo HTML page at the end of this cover letter, but I wan=
t
> >> > you to read the cover letter first to explain what you're seeing.)
> >> >
> >> > This adds a new QAPI Index page, cross-references for QMP commands,
> >> > events, and data types, and improves the aesthetics of the QAPI/QMP
> >> > documentation.
> >>
> >> Cross-references alone will be a *massive* improvement!  I'm sure
> >> readers will appreciate better looks and an index, too.
> >>
> >> > This series adds only the new ReST syntax, *not* the autogenerator. =
The
> >> > ReST syntax used in this series is, in general, not intended for any=
one
> >> > to actually write by hand. This mimics how Sphinx's own autodoc
> >> > extension generates Python domain directives, which are then re-pars=
ed
> >> > to produce the final result.
> >> >
> >> > I have prototyped such a generator, but it isn't ready for inclusion
> >> > yet. (Rest assured: error context reporting is preserved down to the
> >> > line, even in generated ReST. There is no loss in usability for this
> >> > approach. It will likely either supplant qapidoc.py or heavily alter
> >> > it.) The generator requires only extremely minor changes to
> >> > scripts/qapi/parser.py to preserve nested indentation and provide mo=
re
> >> > accurate line information. It is less invasive than you may
> >> > fear. Relying on a secondary ReST parse phase eliminates much of the
> >> > complexity of qapidoc.py. Sleep soundly.
> >>
> >> I'm a Sphinx noob.  Let me paraphrase you to make sure I understand.
> >>
> >> You proprose to generate formatted documentation in two steps:
> >>
> >> =E2=80=A2 First, the QAPI generator generates .rst from the QAPI schem=
a.  The
> >>   generated .rst makes use of a custom directives.
> >>
> >
> > Yes, but this .rst file is built in-memory and never makes it to disk, =
like
> > Sphinx's autodoc for Python.
>
> Makes sense.
>
> > (We can add a debug knob to log it or save it out to disk if needed.)
>
> Likely useful at least occasionally.

Yep, python's autodoc has such a knob to use the debugging log for
this. I just want to point out that avoiding the intermediate file
on-disk is actually the mechanism by which I can preserve source
lines, so this is how it's gotta be.

I build an intermediate doc in-memory with source filenames and source
lines along with the modified doc block content so that ReST errors
can be tracked back directly to the QAPI json files. If we saved to
disk and parsed that, it'd obliterate that information.

>
> >> =E2=80=A2 Second, Sphinx turns the .rst into formatted documentation. =
 A Sphinx
> >>   qapi-domain extension implements the custom directives
> >
> > Yes.
> >
> >
> >> This mirrors how Sphinx works for Python docs.  Which is its original
> >> use case.
> >>
> >> Your series demonstrates the second step, with test input you wrote
> >> manually.
> >>
> >> You have code for the first step, but you'd prefer to show it later.
> >
> > Right, it's not fully finished, although I have events, commands, and
> > objects working. Unions, Alternates and Events need work.
> >
> >
> >> Fair?
> >
> > Bingo!
>
> Thanks!
>
> >> > The purpose of sending this series in its current form is largely to
> >> > solicit feedback on general aesthetics, layout, and features. Sphinx=
 is
> >> > a wily beast, and feedback at this stage will dictate how and where
> >> > certain features are implemented.
> >>
> >> I'd appreciate help with that.  Opinions?
> >
> >
> >> > A goal for this syntax (and the generator) is to fully in-line all
> >> > command/event/object members, inherited or local, boxed or not, bran=
ched
> >> > or not. This should provide a boon to using these docs as a referenc=
e,
> >> > because users will not have to grep around the page looking for vari=
ous
> >> > types, branches, or inherited members. Any arguments types will be
> >> > hyperlinked to their definition, further aiding usability. Commands =
can
> >> > be hotlinked from anywhere else in the manual, and will provide a
> >> > complete reference directly on the first screenful of information.
> >>
> >> Let me elaborate a bit here.
> >>
> >> A command's arguments can be specified inline, like so:
> >>
> >>     { 'command': 'job-cancel', 'data': { 'id': 'str' } }
> >>
> >> The arguments are then documented right with the command.
> >>
> >> But they can also be specified by referencing an object type, like so:
> >>
> >>     { 'command': 'block-dirty-bitmap-remove',
> >>       'data': 'BlockDirtyBitmap' }
> >>
> >> Reasons for doing it this way:
> >>
> >> =E2=80=A2 Several commands take the same arguments, and you don't want=
 to repeat
> >>   yourself.
> >>
> >> =E2=80=A2 You want generated C take a single struct argument ('boxed':=
 true).
> >>
> >> =E2=80=A2 The arguments are a union (which requires 'boxed': true).
> >>
> >> Drawback: the arguments are then documented elsewhere.  Not nice.
> >>
> >> Bug: the generated documentation fails to point there.
> >>
> >> You're proposing to inline the argument documentation, so it appears
> >> right with the command.
> >>
> >> An event's data is just like a command's argument.
> >>
> >> A command's return value can only specified by referencing a type.  Sa=
me
> >> doc usability issue.
> >>
> >> Similarly, a union type's base can specified inline or by referencing =
a
> >> struct type, and a union's branches must be specified by referencing a
> >> struct type.  Same doc usability issue.
> >>
> >> At least, the generated documentation does point to the referenced
> >> types.
> >>
> >
> > Right. My proposal is to recursively inline referenced bases for the
> > top-level members so that this manual is useful as a user reference,
> > without worrying about the actual QAPI structure.
> >
> > Return types will just be hotlinked.
>
> The argument for inlining the arguments equally applies to results:
> "users will not have to grep around the page".
>
> 102 out of 236 commands return something, usually some object type or an
> array of some object type.  Most of these types are used for exactly one
> command's return and nothing else.
>
> Regardless, it's fine to explore inlining just for arguments.  If we can
> make that work, extending it to return results shouldn't be too hard.

Yeah. Future work, if we want it. Otherwise, I think it's not *too*
bad to hotlink to the return arg type; but if that's info that you
want to "hide" from the user API, I get it - we can work on squanching
that in too. (For a follow-up though, please.)

>
> >> > (Okay, maybe two screenfuls for commands with a ton of
> >> > arguments... There's only so much I can do!)
> >>
> >> *cough* blockdev-add *cough*
> >
> >
> >> > This RFC series includes a "sandbox" .rst document that showcases th=
e
> >> > features of this domain by writing QAPI directives by hand; this
> >> > document will be removed from the series before final inclusion. It'=
s
> >> > here to serve as a convenient test-bed for y'all to give feedback.
> >> >
> >> > All that said, here's the sandbox document fully rendered:
> >> > https://jsnow.gitlab.io/qemu/qapi/index.html
> >> >
> >> > And here's the new QAPI index page created by that sandbox document:
> >> > https://jsnow.gitlab.io/qemu/qapi-index.html
> >> >
> >> > Known issues / points of interest:
> >> >
> >> > - The formatting upsets checkpatch. The default line length for the
> >> >   "black" formatting tool is a little long. I'll fix it next spin.
> >> >
> >> > - I did my best to preserve cross-version compatibility, but some
> >> >   problems have crept in here and there. This series may require
> >> >   Sphinx>=3D 4.0, like the dbus extension. Notably, the Ubuntu build=
 fails
> >> >   on Gitlab CI currently. The next version will text against more Sp=
hinx
> >> >   versions more rigorously. Sphinx version 5.3.0 and above should wo=
rk
> >> >   perfectly.
> >> >
> >> > - There's a bug in Sphinx itself that may manifest in your testing,
> >> >   concerning reported error locations. There's a patch in this serie=
s
> >> >   that fixes it, but it's later in the series. If you run into the b=
ug
> >> >   while testing with this series, try applying that patch first.
> >> >
> >> > - QAPI 'namespaces' aren't yet handled. i.e., there's nothing to
> >> >   distinguish entities between QMP, QGA and QSD yet. That feature wi=
ll
> >> >   be added to a future version of this patchset (Likely when the
> >> >   generator is ready for inclusion: without it, references will clas=
h
> >> >   and the index will gripe about duplicated entries.)
> >>
> >> qemu-storage-daemon's QMP is a proper subset of qemu-system-FOO's.
> >> Regardless, each of them has its own, independent reference manual.
> >> That's defensible.
> >>
> >> But the way we build them can complicate matters.  For instance, when =
I
> >> tried to elide types not used for QMP from the reference manuals, I go=
t
> >> defeated by Sphinx caching.
> >
> > I haven't tried yet, but I believe it should be possible to "tag" each
> > referenced QAPI object and mark it as "visited". Each namespaced defini=
tion
> > would be tagged separately.
> >
> > (i.e. qemu.block-core.blockdev-backup and qsd.block-core.blockdev-backu=
p
> > would be two distinct entities.)
> >
> > Then, the renderer could ignore/squelch untagged entities. (I think.)
> >
> > Maybe some work to do to un-index unvisited entities.
> >
> > Or we can go the other route and bake this info into the schema and squ=
elch
> > stuff earlier. We can add this feature later. I am still not sure why y=
our
> > prototype for this ran into cache issues, but I am convinced it should =
be
> > fixable by making namespaced entities distinct.
>
> From (hazy) memory: when full QMP and storage daemon QMP both include a
> sub-module for its types, but full QMP uses more of its types than
> storage daemon QMP does, the storage daemon manual elides more of its
> types than the QMP manual does.  However, sphinx-build's caching uses
> whatever got built first for *both* manuals.  When we happen to build
> the full QMP manual first, we end up with extra types in the storage
> daemon manual.  When we happen to build the storage daemon manual first,
> the full manual is missing types.

Weird. I still don't understand where that info is getting cached, to
be honest ...

>
> > We could perhaps bake the namespace into the qapidoc directive, e.g.:
> >
> >  .. qapi:autodoc:: schema.json
> >    :namespace: QSD
> >
> > (And the default adds no namespace.)
>
> Is it worth it?  How useful is the separate QEMU Storage Daemon QMP
> Reference Manual?  It's an exact duplicate of selected chapters of the
> QEMU QMP Reference Manual...  Could we instead document "QMP, but only
> these chapters"?

I dunno. That's up to you and Kevin, I think? For now, I'm just
following "What we've got" but with cross-referencing and indexing
improvements. Those improvements require distinguishing QMP and QSD
somehow. Adding simple namespace support seems like the most flexible
*and* dead simple way to do it. Other improvements can come later if
desired, I think.

If you need help adding Sphinx features to make it happen, you know
where I live.

>
> Diversion: can we come up with a better way of subsetting the full QAPI
> schema for the storage daemon?

Out of scope for me I'm afraid, but clue me in to the discussion
if/when you have it.

>
> We currently subset by having storage-daemon/qapi/qapi-schema.json a
> subset of the submodules qapi/qapi-schema.json includes.  The code
> generated for the entire schema differs (basically qapi-init-commands.c,
> qapi-emit-events.[ch], and qapi-introspect.c).  The code generated for
> the submodules should be identical (modulo unused array types, but
> that's harmless detail).  So we ignore the code generated for the
> storage daemon's submodules.

Ah, so you are debating a type of pragma or other meta-include that
just fishes out specific definitions? That could work, I think - I'm
not sure how the QAPI Schema end would look, but the Sphinx domain
could provide a meta-directive for adding a QSD support tag to
specific entities or some such thing, and the single QMP reference
could advertise a qemu-storage-daemon support flag.

Or something - I'm not really privy to the big picture when it comes
to how we want to handle QMP modularization and differentiation
between different binaries.

>
> End of diversion.
>
> >> > - Per-member features and ifcond are not yet accounted for; though
> >> >   definition-scoped features and ifconds are. Please feel free to
> >> >   suggest how you'd like to see those represented.
> >> >
> >> > - Inlining all members means there is some ambiguity on what to do w=
ith
> >> >   doc block sections on inlined entities; features and members have =
an
> >> >   obvious home - body, since, and misc sections are not as obvious o=
n
> >> >   how to handle. This will feature more prominently in the generator
> >> >   series.
> >>
> >> Yes, this is a real problem.
> >>
> >> The member documentation gets written in the context of the type.  It
> >> may make sense only in that context.  Inlining copies it into a
> >> different context.
> >>
> >> Features may need to combine.  Say a command's arguments are a union
> >> type, and several branches of the union both contain deprecated member=
s.
> >> These branch types all document feature @deprecated.  Simply inlining
> >> their feature documentation results in feature @deprecated documented
> >> several times.  Ugh.  Combining them would be better.  But how?  Do we
> >> need to rethink how we document features?
> >
> > To be honest, I figured I'd plow ahead and then find the counter-exampl=
es
> > programmatically and decide what to do once I had my pile of edge cases=
.
> >
> > It might involve rewriting docs in some places, but I think the usabili=
ty
> > win is completely worth the hassle.
> >
> > It's possible there might be some rework needed to maximize cogency of =
the
> > generated docs, but I think prioritizing a user-facing reference for QM=
P is
> > the objectively correct end goal and I'm more than happy to work backwa=
rds
> > from that desired state.
>
> I'm not disputing the idea that documenting the arguments right with the
> command is good.  I'm merely pointing out obstacles to pulling that off.
>
> Adjusting existing documentation is only half the battle.  The other
> half is making sure documentation stays adjusted.  We may have to come
> up with new documentation rules, and ways to enforce them.

For the sake of argument, let's say we forbid everything except
arg/features from definitions destined to be used as base/inherited
types. This would be very easy to enforce at the qapidoc level where
the doc inlining is performed by yelping when the base type contains
additional documentation sections.

Now, in the real world, maybe sometimes those sections are useful and
we don't want to get rid of them, esp. because they may contain useful
documentation that we don't want to duplicate in the source files.

My plan is to just forbid them at first and enumerate the cases where
they occur, then decide which ones are better off being moved
elsewhere or explicitly tolerated. The generator's tolerance can be
adjusted accordingly and we can formulate a rule for exactly how doc
blocks are combined and merged. I think it won't be a problem to
enforce it programmatically.

I'll get back to you on how often and precisely where these cases
occur so you can take a look and see how you feel.

>
> >> > - Some features could be implemented in either the QAPI domain synta=
x
> >> >   *or* the generator, or some combination of both. Depending on
> >> >   aesthetic feedback, this may influence where those features should=
 be
> >> >   implemented.
> >> >
> >> > - The formatting and aesthetics of branches are a little up in the a=
ir,
> >> >   see the qapi:union patch for more details.
> >> >
> >> > - It's late, maybe other things. Happy Friday!
> >> >
> >> > Hope you like it!
> >>
> >> Looks promising!
> >
> > Fingers crossed. This has bothered me about QEMU for years.
>
> Thanks!
>


