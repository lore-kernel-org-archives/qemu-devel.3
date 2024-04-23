Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6575CC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 01:57:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rz5Of-0006h6-Hc; Mon, 22 Apr 2024 21:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rz5Oc-0006gb-Id
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 21:56:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rz5OZ-0006fO-1d
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 21:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713837389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OzX0Kn8slNwuCDHVCmMGpeaRY7cBSxVb7xoj9+zxOa8=;
 b=LVgRNSoJqA7tKYHyjRsHFd+f//c2GbX6qIWeMeoBF3si4CvJOtHy3eiEMqvfP6Q1jwGfFj
 fxwcOyfXM3wqEZcbnwXjUkoIbzYsjaM2M7Tcj2J07T7RsPaUHVpSerjAaftP0woJTZWFyl
 1WaDOtwRzdnViUc5OhK2VdXyVwUi340=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-G3-iBekwOiWoaW0uKUcfqA-1; Mon, 22 Apr 2024 21:56:27 -0400
X-MC-Unique: G3-iBekwOiWoaW0uKUcfqA-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5fff61c9444so1564844a12.2
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 18:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713837387; x=1714442187;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OzX0Kn8slNwuCDHVCmMGpeaRY7cBSxVb7xoj9+zxOa8=;
 b=lLL/ezb4ceBEA2Ln27o18/1oXnF3AATDZVaUTDkzJrY7z5p+4OMPG9KoyCKbFhknvN
 nznJjqJa+VEo4gH1WkL+N0CLYUcrFfi74ZGZbnJP4oFndvJAYJ01JTDPPvE0dRdmiXgN
 vp0MUhok5ITDws3QTnhqxzpqNgG+cbXygYFOvQqHR4KPz/nPbRXJicmEHwUfNMQ1vZBv
 MtgQ60Xxmx1DVIFOlxnk93rzXRZUmuD04mdRcPeU+mDBP/wfsX8c17QFUHow8eLP4CJL
 paY7GXVBSh7bpYoyGgiUmJof41HtVnlfAOE711rr4zDsGhgeMH1+ofhmwQGWDsShj5uD
 NVVg==
X-Gm-Message-State: AOJu0YzLDrte9mYlQWCKlNcViiKmRe4IY9TyiTkRbun8wfvFNfYpmYaa
 OrR/VrEzbkSDcF+8NtWGxLvAi5e0tgVQYNhulYNMZTqcs6KRVcbZeeD1FuXAbCo/PSlCy2FrpOK
 OMQNYN4v/NdWIG61Xr+8i6qrkhNdfk67TM4QX0Km5NbUHtxdIhbO9sRy/jFMTTUeKg7thotWVkx
 pLXtIaDshPYMFdva8vSJSPVE5s6A0=
X-Received: by 2002:a05:6a20:918f:b0:1a7:5184:8d14 with SMTP id
 v15-20020a056a20918f00b001a751848d14mr13595445pzd.46.1713837386537; 
 Mon, 22 Apr 2024 18:56:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVHhpt9UxMH0wDrOwC5XLxxc4/UXNY0LxSmnd12/VcBzltW9Kp+uCWp9/3imwQQSc1A0RGklAdZZWuLgAvgSc=
X-Received: by 2002:a05:6a20:918f:b0:1a7:5184:8d14 with SMTP id
 v15-20020a056a20918f00b001a751848d14mr13595422pzd.46.1713837385952; Mon, 22
 Apr 2024 18:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240419043820.178731-1-jsnow@redhat.com>
 <87msppl8c8.fsf@pond.sub.org>
 <CAFn=p-YaP+qg8C9iQUHkk_03gqnuhA0Ps6pcUeZuCiiScSTVpQ@mail.gmail.com>
 <87wmopg3ez.fsf@pond.sub.org>
 <CAFn=p-bXLbn1o1f+jsFUP502yak0r4yNvAYjTz4MMXShygQQ7g@mail.gmail.com>
In-Reply-To: <CAFn=p-bXLbn1o1f+jsFUP502yak0r4yNvAYjTz4MMXShygQQ7g@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 22 Apr 2024 21:56:13 -0400
Message-ID: <CAFn=p-YUceA2kx7OQJPxThRi5_w-V-N7YJY57T4paapcvBRUvw@mail.gmail.com>
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

On Mon, Apr 22, 2024 at 12:38=E2=80=AFPM John Snow <jsnow@redhat.com> wrote=
:
>
> On Mon, Apr 22, 2024 at 5:20=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
> >
> > John Snow <jsnow@redhat.com> writes:
> >
> > > On Fri, Apr 19, 2024, 10:45=E2=80=AFAM Markus Armbruster <armbru@redh=
at.com> wrote:
> > >
> > >> John Snow <jsnow@redhat.com> writes:
> > >>
> > >> > This series adds a new qapi-domain extension for Sphinx, which add=
s a
> > >> > series of custom directives for documenting QAPI definitions.
> > >> >
> > >> > GitLab CI: https://gitlab.com/jsnow/qemu/-/pipelines/1259566476
> > >> >
> > >> > (Link to a demo HTML page at the end of this cover letter, but I w=
ant
> > >> > you to read the cover letter first to explain what you're seeing.)
> > >> >
> > >> > This adds a new QAPI Index page, cross-references for QMP commands=
,
> > >> > events, and data types, and improves the aesthetics of the QAPI/QM=
P
> > >> > documentation.
> > >>
> > >> Cross-references alone will be a *massive* improvement!  I'm sure
> > >> readers will appreciate better looks and an index, too.
> > >>
> > >> > This series adds only the new ReST syntax, *not* the autogenerator=
. The
> > >> > ReST syntax used in this series is, in general, not intended for a=
nyone
> > >> > to actually write by hand. This mimics how Sphinx's own autodoc
> > >> > extension generates Python domain directives, which are then re-pa=
rsed
> > >> > to produce the final result.
> > >> >
> > >> > I have prototyped such a generator, but it isn't ready for inclusi=
on
> > >> > yet. (Rest assured: error context reporting is preserved down to t=
he
> > >> > line, even in generated ReST. There is no loss in usability for th=
is
> > >> > approach. It will likely either supplant qapidoc.py or heavily alt=
er
> > >> > it.) The generator requires only extremely minor changes to
> > >> > scripts/qapi/parser.py to preserve nested indentation and provide =
more
> > >> > accurate line information. It is less invasive than you may
> > >> > fear. Relying on a secondary ReST parse phase eliminates much of t=
he
> > >> > complexity of qapidoc.py. Sleep soundly.
> > >>
> > >> I'm a Sphinx noob.  Let me paraphrase you to make sure I understand.
> > >>
> > >> You proprose to generate formatted documentation in two steps:
> > >>
> > >> =E2=80=A2 First, the QAPI generator generates .rst from the QAPI sch=
ema.  The
> > >>   generated .rst makes use of a custom directives.
> > >>
> > >
> > > Yes, but this .rst file is built in-memory and never makes it to disk=
, like
> > > Sphinx's autodoc for Python.
> >
> > Makes sense.
> >
> > > (We can add a debug knob to log it or save it out to disk if needed.)
> >
> > Likely useful at least occasionally.
>
> Yep, python's autodoc has such a knob to use the debugging log for
> this. I just want to point out that avoiding the intermediate file
> on-disk is actually the mechanism by which I can preserve source
> lines, so this is how it's gotta be.
>
> I build an intermediate doc in-memory with source filenames and source
> lines along with the modified doc block content so that ReST errors
> can be tracked back directly to the QAPI json files. If we saved to
> disk and parsed that, it'd obliterate that information.
>
> >
> > >> =E2=80=A2 Second, Sphinx turns the .rst into formatted documentation=
.  A Sphinx
> > >>   qapi-domain extension implements the custom directives
> > >
> > > Yes.
> > >
> > >
> > >> This mirrors how Sphinx works for Python docs.  Which is its origina=
l
> > >> use case.
> > >>
> > >> Your series demonstrates the second step, with test input you wrote
> > >> manually.
> > >>
> > >> You have code for the first step, but you'd prefer to show it later.
> > >
> > > Right, it's not fully finished, although I have events, commands, and
> > > objects working. Unions, Alternates and Events need work.
> > >
> > >
> > >> Fair?
> > >
> > > Bingo!
> >
> > Thanks!
> >
> > >> > The purpose of sending this series in its current form is largely =
to
> > >> > solicit feedback on general aesthetics, layout, and features. Sphi=
nx is
> > >> > a wily beast, and feedback at this stage will dictate how and wher=
e
> > >> > certain features are implemented.
> > >>
> > >> I'd appreciate help with that.  Opinions?
> > >
> > >
> > >> > A goal for this syntax (and the generator) is to fully in-line all
> > >> > command/event/object members, inherited or local, boxed or not, br=
anched
> > >> > or not. This should provide a boon to using these docs as a refere=
nce,
> > >> > because users will not have to grep around the page looking for va=
rious
> > >> > types, branches, or inherited members. Any arguments types will be
> > >> > hyperlinked to their definition, further aiding usability. Command=
s can
> > >> > be hotlinked from anywhere else in the manual, and will provide a
> > >> > complete reference directly on the first screenful of information.
> > >>
> > >> Let me elaborate a bit here.
> > >>
> > >> A command's arguments can be specified inline, like so:
> > >>
> > >>     { 'command': 'job-cancel', 'data': { 'id': 'str' } }
> > >>
> > >> The arguments are then documented right with the command.
> > >>
> > >> But they can also be specified by referencing an object type, like s=
o:
> > >>
> > >>     { 'command': 'block-dirty-bitmap-remove',
> > >>       'data': 'BlockDirtyBitmap' }
> > >>
> > >> Reasons for doing it this way:
> > >>
> > >> =E2=80=A2 Several commands take the same arguments, and you don't wa=
nt to repeat
> > >>   yourself.
> > >>
> > >> =E2=80=A2 You want generated C take a single struct argument ('boxed=
': true).
> > >>
> > >> =E2=80=A2 The arguments are a union (which requires 'boxed': true).
> > >>
> > >> Drawback: the arguments are then documented elsewhere.  Not nice.
> > >>
> > >> Bug: the generated documentation fails to point there.
> > >>
> > >> You're proposing to inline the argument documentation, so it appears
> > >> right with the command.
> > >>
> > >> An event's data is just like a command's argument.
> > >>
> > >> A command's return value can only specified by referencing a type.  =
Same
> > >> doc usability issue.
> > >>
> > >> Similarly, a union type's base can specified inline or by referencin=
g a
> > >> struct type, and a union's branches must be specified by referencing=
 a
> > >> struct type.  Same doc usability issue.
> > >>
> > >> At least, the generated documentation does point to the referenced
> > >> types.
> > >>
> > >
> > > Right. My proposal is to recursively inline referenced bases for the
> > > top-level members so that this manual is useful as a user reference,
> > > without worrying about the actual QAPI structure.
> > >
> > > Return types will just be hotlinked.
> >
> > The argument for inlining the arguments equally applies to results:
> > "users will not have to grep around the page".
> >
> > 102 out of 236 commands return something, usually some object type or a=
n
> > array of some object type.  Most of these types are used for exactly on=
e
> > command's return and nothing else.
> >
> > Regardless, it's fine to explore inlining just for arguments.  If we ca=
n
> > make that work, extending it to return results shouldn't be too hard.
>
> Yeah. Future work, if we want it. Otherwise, I think it's not *too*
> bad to hotlink to the return arg type; but if that's info that you
> want to "hide" from the user API, I get it - we can work on squanching
> that in too. (For a follow-up though, please.)
>
> >
> > >> > (Okay, maybe two screenfuls for commands with a ton of
> > >> > arguments... There's only so much I can do!)
> > >>
> > >> *cough* blockdev-add *cough*
> > >
> > >
> > >> > This RFC series includes a "sandbox" .rst document that showcases =
the
> > >> > features of this domain by writing QAPI directives by hand; this
> > >> > document will be removed from the series before final inclusion. I=
t's
> > >> > here to serve as a convenient test-bed for y'all to give feedback.
> > >> >
> > >> > All that said, here's the sandbox document fully rendered:
> > >> > https://jsnow.gitlab.io/qemu/qapi/index.html
> > >> >
> > >> > And here's the new QAPI index page created by that sandbox documen=
t:
> > >> > https://jsnow.gitlab.io/qemu/qapi-index.html
> > >> >
> > >> > Known issues / points of interest:
> > >> >
> > >> > - The formatting upsets checkpatch. The default line length for th=
e
> > >> >   "black" formatting tool is a little long. I'll fix it next spin.
> > >> >
> > >> > - I did my best to preserve cross-version compatibility, but some
> > >> >   problems have crept in here and there. This series may require
> > >> >   Sphinx>=3D 4.0, like the dbus extension. Notably, the Ubuntu bui=
ld fails
> > >> >   on Gitlab CI currently. The next version will text against more =
Sphinx
> > >> >   versions more rigorously. Sphinx version 5.3.0 and above should =
work
> > >> >   perfectly.
> > >> >
> > >> > - There's a bug in Sphinx itself that may manifest in your testing=
,
> > >> >   concerning reported error locations. There's a patch in this ser=
ies
> > >> >   that fixes it, but it's later in the series. If you run into the=
 bug
> > >> >   while testing with this series, try applying that patch first.
> > >> >
> > >> > - QAPI 'namespaces' aren't yet handled. i.e., there's nothing to
> > >> >   distinguish entities between QMP, QGA and QSD yet. That feature =
will
> > >> >   be added to a future version of this patchset (Likely when the
> > >> >   generator is ready for inclusion: without it, references will cl=
ash
> > >> >   and the index will gripe about duplicated entries.)
> > >>
> > >> qemu-storage-daemon's QMP is a proper subset of qemu-system-FOO's.
> > >> Regardless, each of them has its own, independent reference manual.
> > >> That's defensible.
> > >>
> > >> But the way we build them can complicate matters.  For instance, whe=
n I
> > >> tried to elide types not used for QMP from the reference manuals, I =
got
> > >> defeated by Sphinx caching.
> > >
> > > I haven't tried yet, but I believe it should be possible to "tag" eac=
h
> > > referenced QAPI object and mark it as "visited". Each namespaced defi=
nition
> > > would be tagged separately.
> > >
> > > (i.e. qemu.block-core.blockdev-backup and qsd.block-core.blockdev-bac=
kup
> > > would be two distinct entities.)
> > >
> > > Then, the renderer could ignore/squelch untagged entities. (I think.)
> > >
> > > Maybe some work to do to un-index unvisited entities.
> > >
> > > Or we can go the other route and bake this info into the schema and s=
quelch
> > > stuff earlier. We can add this feature later. I am still not sure why=
 your
> > > prototype for this ran into cache issues, but I am convinced it shoul=
d be
> > > fixable by making namespaced entities distinct.
> >
> > From (hazy) memory: when full QMP and storage daemon QMP both include a
> > sub-module for its types, but full QMP uses more of its types than
> > storage daemon QMP does, the storage daemon manual elides more of its
> > types than the QMP manual does.  However, sphinx-build's caching uses
> > whatever got built first for *both* manuals.  When we happen to build
> > the full QMP manual first, we end up with extra types in the storage
> > daemon manual.  When we happen to build the storage daemon manual first=
,
> > the full manual is missing types.
>
> Weird. I still don't understand where that info is getting cached, to
> be honest ...
>
> >
> > > We could perhaps bake the namespace into the qapidoc directive, e.g.:
> > >
> > >  .. qapi:autodoc:: schema.json
> > >    :namespace: QSD
> > >
> > > (And the default adds no namespace.)
> >
> > Is it worth it?  How useful is the separate QEMU Storage Daemon QMP
> > Reference Manual?  It's an exact duplicate of selected chapters of the
> > QEMU QMP Reference Manual...  Could we instead document "QMP, but only
> > these chapters"?
>
> I dunno. That's up to you and Kevin, I think? For now, I'm just
> following "What we've got" but with cross-referencing and indexing
> improvements. Those improvements require distinguishing QMP and QSD
> somehow. Adding simple namespace support seems like the most flexible
> *and* dead simple way to do it. Other improvements can come later if
> desired, I think.
>
> If you need help adding Sphinx features to make it happen, you know
> where I live.
>
> >
> > Diversion: can we come up with a better way of subsetting the full QAPI
> > schema for the storage daemon?
>
> Out of scope for me I'm afraid, but clue me in to the discussion
> if/when you have it.
>
> >
> > We currently subset by having storage-daemon/qapi/qapi-schema.json a
> > subset of the submodules qapi/qapi-schema.json includes.  The code
> > generated for the entire schema differs (basically qapi-init-commands.c=
,
> > qapi-emit-events.[ch], and qapi-introspect.c).  The code generated for
> > the submodules should be identical (modulo unused array types, but
> > that's harmless detail).  So we ignore the code generated for the
> > storage daemon's submodules.
>
> Ah, so you are debating a type of pragma or other meta-include that
> just fishes out specific definitions? That could work, I think - I'm
> not sure how the QAPI Schema end would look, but the Sphinx domain
> could provide a meta-directive for adding a QSD support tag to
> specific entities or some such thing, and the single QMP reference
> could advertise a qemu-storage-daemon support flag.
>
> Or something - I'm not really privy to the big picture when it comes
> to how we want to handle QMP modularization and differentiation
> between different binaries.
>
> >
> > End of diversion.
> >
> > >> > - Per-member features and ifcond are not yet accounted for; though
> > >> >   definition-scoped features and ifconds are. Please feel free to
> > >> >   suggest how you'd like to see those represented.
> > >> >
> > >> > - Inlining all members means there is some ambiguity on what to do=
 with
> > >> >   doc block sections on inlined entities; features and members hav=
e an
> > >> >   obvious home - body, since, and misc sections are not as obvious=
 on
> > >> >   how to handle. This will feature more prominently in the generat=
or
> > >> >   series.
> > >>
> > >> Yes, this is a real problem.
> > >>
> > >> The member documentation gets written in the context of the type.  I=
t
> > >> may make sense only in that context.  Inlining copies it into a
> > >> different context.
> > >>
> > >> Features may need to combine.  Say a command's arguments are a union
> > >> type, and several branches of the union both contain deprecated memb=
ers.
> > >> These branch types all document feature @deprecated.  Simply inlinin=
g
> > >> their feature documentation results in feature @deprecated documente=
d
> > >> several times.  Ugh.  Combining them would be better.  But how?  Do =
we
> > >> need to rethink how we document features?
> > >
> > > To be honest, I figured I'd plow ahead and then find the counter-exam=
ples
> > > programmatically and decide what to do once I had my pile of edge cas=
es.
> > >
> > > It might involve rewriting docs in some places, but I think the usabi=
lity
> > > win is completely worth the hassle.
> > >
> > > It's possible there might be some rework needed to maximize cogency o=
f the
> > > generated docs, but I think prioritizing a user-facing reference for =
QMP is
> > > the objectively correct end goal and I'm more than happy to work back=
wards
> > > from that desired state.
> >
> > I'm not disputing the idea that documenting the arguments right with th=
e
> > command is good.  I'm merely pointing out obstacles to pulling that off=
.
> >
> > Adjusting existing documentation is only half the battle.  The other
> > half is making sure documentation stays adjusted.  We may have to come
> > up with new documentation rules, and ways to enforce them.
>
> For the sake of argument, let's say we forbid everything except
> arg/features from definitions destined to be used as base/inherited
> types. This would be very easy to enforce at the qapidoc level where
> the doc inlining is performed by yelping when the base type contains
> additional documentation sections.
>
> Now, in the real world, maybe sometimes those sections are useful and
> we don't want to get rid of them, esp. because they may contain useful
> documentation that we don't want to duplicate in the source files.
>
> My plan is to just forbid them at first and enumerate the cases where
> they occur, then decide which ones are better off being moved
> elsewhere or explicitly tolerated. The generator's tolerance can be
> adjusted accordingly and we can formulate a rule for exactly how doc
> blocks are combined and merged. I think it won't be a problem to
> enforce it programmatically.
>
> I'll get back to you on how often and precisely where these cases
> occur so you can take a look and see how you feel.
>

For a warmup, let's look at every unique instance of non-empty
paragraph text on an object that is used as a base anywhere:

Warning: AudiodevPerDirectionOptions - inlined paragraph
Warning: BlockdevOptionsCurlBase - inlined paragraph
Warning: BlockdevOptionsGenericCOWFormat - inlined paragraph
Warning: BlockdevOptionsGenericFormat - inlined paragraph
Warning: BlockExportOptionsNbdBase - inlined paragraph
Warning: BlockNodeInfo - inlined paragraph
Warning: ChardevCommon - inlined paragraph
Warning: CpuInstanceProperties - inlined paragraph
Warning: CryptodevBackendProperties - inlined paragraph
Warning: EventLoopBaseProperties - inlined paragraph
Warning: MemoryBackendProperties - inlined paragraph
Warning: NetfilterProperties - inlined paragraph
Warning: QCryptoBlockAmendOptionsLUKS - inlined paragraph
Warning: QCryptoBlockCreateOptionsLUKS - inlined paragraph
Warning: QCryptoBlockInfoBase - inlined paragraph
Warning: QCryptoBlockOptionsBase - inlined paragraph
Warning: QCryptoBlockOptionsLUKS - inlined paragraph
Warning: RngProperties - inlined paragraph
Warning: SecretCommonProperties - inlined paragraph
Warning: SpiceBasicInfo - inlined paragraph
Warning: TlsCredsProperties - inlined paragraph
Warning: VncBasicInfo - inlined paragraph

There's 22 instances.

Let's look at what they say:

AudiodevPerDirectionOptions: "General audio backend options that are
used for both playback and recording."
BlockdevOptionsCurlBase: "Driver specific block device options shared
by all protocols supported by the curl backend."
BlockdevOptionsGenericCOWFormat: "Driver specific block device options
for image format that have no option besides their data source and an
optional backing file."
BlockdevOptionsGenericFormat: "Driver specific block device options
for image format that have no option besides their data source."
BlockExportOptionsNbdBase: "An NBD block export (common options shared
between nbd-server-add and the NBD branch of block-export-add)."
BlockNodeInfo: "Information about a QEMU image file"
ChardevCommon: "Configuration shared across all chardev backends"

CpuInstanceProperties:
"List of properties to be used for hotplugging a CPU instance, it
should be passed by management with device_add command when a CPU is
being hotplugged.

Which members are optional and which mandatory depends on the
architecture and board.

For s390x see :ref:`cpu-topology-s390x`.

The ids other than the node-id specify the position of the CPU
within the CPU topology (as defined by the machine property "smp",
thus see also type @SMPConfiguration)"

CryptodevBackendProperties: "Properties for cryptodev-backend and
cryptodev-backend-builtin objects."
EventLoopBaseProperties: "Common properties for event loops"
MemoryBackendProperties: "Properties for objects of classes derived
from memory-backend."
NetfilterProperties: "Properties for objects of classes derived from netfil=
ter."
QCryptoBlockAmendOptionsLUKS: "This struct defines the update
parameters that activate/de-activate set of keyslots"
QCryptoBlockCreateOptionsLUKS: "The options that apply to LUKS
encryption format initialization"
QCryptoBlockInfoBase: "The common information that applies to all full
disk encryption formats"
QCryptoBlockOptionsBase: "The common options that apply to all full
disk encryption formats"
QCryptoBlockOptionsLUKS: "The options that apply to LUKS encryption format"
RngProperties: "Properties for objects of classes derived from rng."
SecretCommonProperties: "Properties for objects of classes derived
from secret-common."
SpiceBasicInfo: "The basic information for SPICE network connection"
TlsCredsProperties: "Properties for objects of classes derived from tls-cre=
ds."
VncBasicInfo: "The basic information for vnc network connection"

... Alright. So like 98% of the time, it's functionally useless
information for the end-user. The only thing that looks mildly
interesting is CpuInstanceProperties and *maybe*
QCryptoBlockAmendOptionsLUKS.

I propose we add a new section to QAPI doc blocks that gets ignored
from rendered documentation, like "Comment:" -- to keep any info that
might be mildly relevant to a developer that explains the *factoring*
of the object, but won't be exposed in user-facing documents.

On the occasion we DO want to inline documentation paragraphs, we can
leave them in and have the doc generator inline them. There's probably
very few cases where we actually want this.

Let's take a look at any tagged sections now, excluding "Since":

Warning: BackupCommon - inlined tag section Note
Warning: CpuInstanceProperties - inlined, tag section Note
Warning: MemoryBackendProperties - inlined tag section Note

Not very many! Just three.

BackupCommon:

Note: @on-source-error and @on-target-error only affect background
    I/O.  If an error occurs during a guest write request, the
    device's rerror/werror actions will be used.

BackupCommon is used as a base for DriveBackup and BlockdevBackup. In
this case, this note probably does belong on both. It should be
inlined and included.

CpuInstanceProperties:

Note: management should be prepared to pass through additional
    properties with device_add.

This is only used as a base with no other addon args for
NumaCpuOptions, in turn only used for an argument. This is probably
right to pass through, too. (Though I admit I don't really know what
it means... we can discuss the doc *quality* another day.)

MemoryBackendProperties:

Note: prealloc=3Dtrue and reserve=3Dfalse cannot be set at the same
    time.  With reserve=3Dtrue, the behavior depends on the operating
    system: for example, Linux will not reserve swap space for
    shared file mappings -- "not applicable". In contrast,
    reserve=3Dfalse will bail out if it cannot be configured
    accordingly.

This is used in MemoryBackendFileProperties,
MemoryBackendMemfdProperties, and MemoryBackendEpcProperties. None are
commands. I think the note here should also be inlined into each
object.

So, I think that:

- Most naked paragraphs are usually useless to the end-user, and we
should put them behind a Comment section to prevent them from being
inlined.
- Any *other* paragraph or section should be included in the
descendent. We'll just review with that eye going forward.
- Since: ... we'll talk about later this week.

--js


