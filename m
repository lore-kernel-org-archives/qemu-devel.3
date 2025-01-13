Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9B5C02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 20:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXRRT-00014L-Tz; Mon, 13 Jan 2025 15:53:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tXRRN-000142-QF
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 15:53:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tXRRK-000117-4K
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 15:53:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736801616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MdILqk0urfcJtFxuaQbblVQH9tYpsUL0AFo6miF2zDI=;
 b=G45RAFD7ePDzLiAwWTkNiKZ7Z3WmZjRVNqFx5MftKyEXFrlyaG3ms6YDt7Et30J/u05Sk7
 4SEh91M1LDf9yNgG4hJoi8faNBnUm5meRv13hzFXELv3nI94996TOAtH5lRpomEGv4TR2F
 XAFMChbrEUnLpzTW/lE202u7q1BgXX8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-1c9iEI3WOVecxTEucnGZyw-1; Mon, 13 Jan 2025 15:53:33 -0500
X-MC-Unique: 1c9iEI3WOVecxTEucnGZyw-1
X-Mimecast-MFC-AGG-ID: 1c9iEI3WOVecxTEucnGZyw
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2efa0eb9cfeso8358961a91.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 12:53:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736801611; x=1737406411;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MdILqk0urfcJtFxuaQbblVQH9tYpsUL0AFo6miF2zDI=;
 b=rYMVL9XHFZSymiR2hVGSiArU5Z6T2Qb58zpKoM32JKT1OSxIeurpXLYLtNJe7s3xh7
 Bz8y5Ia+xaZOPDzxZL7sfTodjkywOJpzYx6a7kbf9LNarenPBYnP4L1Epht0wWJB3LMI
 IQtigjgirL1iALd/mfJftva/i9SrO0BRa+RKDws1VRLTkR+2BCztSfF7qtJQpTraCGzC
 AnsspFW52ZgDyyORLeA1h5RE46K0iessnbNNajIsrO1SWf/Wb9h83K7u415F6Oc/tozT
 WYhCCpwwfCxxBT5ZMyWJUDGbSuZWhBo5b3m4GrKKfWioVFOpznYyecO5dqY54yIh5qeh
 CUpA==
X-Gm-Message-State: AOJu0Yykbtm7YN38D8a2LlQl80xtgN7OVS8KWsFv5WDOYrHh9UzxSGnf
 OaTQMg3zRSlTYa3qdjz2Lx8u39rRk3HBv68ExMOwFyaTARIM8/PSLjEEY90Tfcj4UfcEY5zbWAO
 FTmvtkpNmispqpr7zoAx1lwHbapYrTSMtSo3pLzGcdYcwUHFSmmW3G/0BKiF915cmkL7VM9HQJM
 617h8zeylrZmbO2DOwVdNcHIXUy5Im1J6faBY=
X-Gm-Gg: ASbGncsgw8h8HKsoaYteU+xzLxRsDxBAAPqk0P0tHiaGwVxR6BgCzvr8hxnoLfnAesl
 GVAIXgMXP0VJDEi6rYnsxXz5SJnAvLOSBQqwtGEtxuoOjvFYdMrEnJOCLnqZZuSFtMvI1ng==
X-Received: by 2002:a17:90b:4a4c:b0:2f2:a90e:74ef with SMTP id
 98e67ed59e1d1-2f5543d2e5fmr28209700a91.1.1736801611473; 
 Mon, 13 Jan 2025 12:53:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFR5KMczDZ6DU52MuXaOj4cIRpcNHuJjqVhfpQ9BUG9eiXrQBlD3vKn/BZJFrRBj6vUJTqRzAqbmIsyLbZxg9M=
X-Received: by 2002:a17:90b:4a4c:b0:2f2:a90e:74ef with SMTP id
 98e67ed59e1d1-2f5543d2e5fmr28209652a91.1.1736801610826; Mon, 13 Jan 2025
 12:53:30 -0800 (PST)
MIME-Version: 1.0
References: <20241213021827.2956769-1-jsnow@redhat.com>
 <20241213021827.2956769-12-jsnow@redhat.com>
 <87h66y30gn.fsf@pond.sub.org>
 <CAFn=p-ZAXSMyO3cWw=CXG1Hbd06ToQeUsgO4FsfNqDEvaZRujg@mail.gmail.com>
 <87sepss2bv.fsf@pond.sub.org>
 <CAFn=p-bum9NvZNEYRKCD6Wh_GucSmT33YT9aEqK80u+2d7cUQQ@mail.gmail.com>
 <87v7um2760.fsf@pond.sub.org>
In-Reply-To: <87v7um2760.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 13 Jan 2025 15:53:19 -0500
X-Gm-Features: AbW1kva-yuGAyS9GBryv9S4_ugtsaO1oVZX7NVqJp_ZQXaQpW25lT8gIMlgsRBU
Message-ID: <CAFn=p-Z2xsGO6MHzHiVMF9tTPSrtFytwdhbY=ipJpY8VUGYZ0w@mail.gmail.com>
Subject: Re: [PATCH 11/23] docs/qapidoc: add preamble() method
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="0000000000000f279f062b9ca3a5"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.019,
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

--0000000000000f279f062b9ca3a5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 7:19=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > On Thu, Jan 9, 2025, 5:34=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om>
> wrote:
> >
> >> John Snow <jsnow@redhat.com> writes:
> >>
> >> > On Fri, Dec 20, 2024 at 9:15=E2=80=AFAM Markus Armbruster <armbru@re=
dhat.com>
> wrote:
> >> >
> >> >> John Snow <jsnow@redhat.com> writes:
> >> >>
> >> >> > This method adds the options/preamble to each definition block.
> Notably,
> >> >> > :since: and :ifcond: are added, as are any "special features" suc=
h
> as
> >> >> > :deprecated: and :unstable:.
> >> >> >
> >> >> > Signed-off-by: John Snow <jsnow@redhat.com>
> >> >> > ---
> >> >> >  docs/sphinx/qapidoc.py | 33 ++++++++++++++++++++++++++++++++-
> >> >> >  1 file changed, 32 insertions(+), 1 deletion(-)
> >> >> >
> >> >> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> >> >> > index 6f8f69077b1..85c7ce94564 100644
> >> >> > --- a/docs/sphinx/qapidoc.py
> >> >> > +++ b/docs/sphinx/qapidoc.py
> >> >> > @@ -38,7 +38,7 @@
> >> >> >  from qapi.error import QAPIError, QAPISemError
> >> >> >  from qapi.gen import QAPISchemaVisitor
> >> >> >  from qapi.parser import QAPIDoc
> >> >> > -from qapi.schema import QAPISchema
> >> >> > +from qapi.schema import QAPISchema, QAPISchemaEntity
> >> >> >  from qapi.source import QAPISourceInfo
> >> >> >
> >> >> >  from sphinx import addnodes
> >> >> > @@ -125,6 +125,37 @@ def ensure_blank_line(self) -> None:
> >> >> >              # +2: correct for zero/one index, then increment by
> one.
> >> >> >              self.add_line_raw("", fname, line + 2)
> >> >> >
> >> >> > +    # Transmogrification helpers
> >> >> > +
> >> >> > +    def preamble(self, ent: QAPISchemaEntity) -> None:
> >> >> > +        """
> >> >> > +        Generate option lines for qapi entity directives.
> >> >> > +        """
> >> >> > +        if ent.doc and ent.doc.since:
> >> >> > +            assert ent.doc.since.tag =3D=3D QAPIDoc.Tag.SINCE
> >> >> > +            # Generated from the entity's docblock; info locatio=
n
> is exact.
> >> >> > +            self.add_line(f":since: {ent.doc.since.text}",
> ent.doc.since.info)
> >> >> > +
> >> >> > +        if ent.ifcond.is_present():
> >> >> > +            doc =3D ent.ifcond.docgen()
> >> >> > +            # Generated from entity definition; info location is
> approximate.
> >> >> > +            self.add_line(f":ifcond: {doc}", ent.info)
> >> >> > +
> >> >> > +        # Hoist special features such as :deprecated: and
> :unstable:
> >> >> > +        # into the options block for the entity. If, in the
> future, new
> >> >> > +        # special features are added, qapi-domain will chirp abo=
ut
> >> >> > +        # unrecognized options and fail.
> >> >> > +        for feat in ent.features:
> >> >> > +            if feat.is_special():
> >> >> > +                # We don't expect special features to have an
> ifcond property.
> >> >> > +                # (Hello, intrepid developer in the future who
> changed that!)
> >> >> > +                # ((With luck, you are not me.))
> >> >> > +                assert not feat.ifcond.is_present()
> >> >>
> >> >> Nope :)
> >> >>
> >> >> The attempt to add a conditional special feature now fails with
> >> >>
> >> >>     Sphinx parallel build error:
> >> >>     AssertionError
> >> >>
> >> >> If you want to outlaw conditional special features, reject them
> cleanly
> >> >> in schema.py, document the restriction in
> docs/devel/qapi-code-gen.rst,
> >> >> and explain why in the commit message.  Recommend a separate commit=
,
> to
> >> >> make it stand out in git-log.
> >> >
> >> > Do you advocate this? I wasn't sure what it *meant* for a special
> feature
> >> > to be conditional; I couldn't conceive of what it meant to have an
> ifcond
> >> > for "deprecated" or "unstable", for instance. It sounds like it isn'=
t
> well
> >> > defined, but we happen to not expressly forbid it.
> >>
> >> Semantics are clear enough to me.
> >>
> >> "Conditional special feature" combines "conditional feature" (which is=
 a
> >> special case of conditional thing) with special feature (which is a
> >> special case of feature).
> >>
> >> The QAPI schema language supports compile-time conditionals for certai=
n
> >> things.  Generated code behaves as if the thing didn't exist unless it=
s
> >> condition is true.
> >>
> >> QAPI schema features are strings exposed to clients in introspection.
> >>
> >> Combine the two: a conditional feature is exposed if and only if its
> >> condition is true.
> >>
> >> Existing uses: dynamic-auto-read-only if CONFIG_POSIX, fdset if
> >> CONFIG_BLKIO_VHOST_VDPA_FD.
> >>
> >> A special feature is a feature that has special meaning to the
> >> generator, i.e. we generate different code in places when it's present=
.
> >>
> >> Combine: we enable different code for a conditional special feature on=
ly
> >> when its condition is true.
> >>
> >> No existing uses so far.
> >>
> >> Implementation is straightforward, too.
> >>
> >
> > Mechanically, it's well defined... but that isn't my concern.
> >
> > What I asked you was: "what would it mean for deprecated to be
> conditional?"
> >
> > Without understanding that, I have no chance to design a system that
> > handles that information accordingly for the documentation.
>
> Special feature deprecated means the use of the thing that has it is
> deprecated with this particular qemu-system-FOO.
>
> Why "this particular"?  Because it wasn't deprecated in some prior
> version of QEMU.  Features (special or not) are always, always about the
> specific qemu-system-FOO binary you're talking to via QMP.
>
> Conditionals are compile-time schema configuration.  Either the
> condition is true or not at compile time.  If it's true, the thing that
> has it is there, else it isn't.
>
> Now combine the two.  If the condition of special feature 'deprecate' is
> true, the thing that has it is deprecated with this particular
> qemu-system-FOO.  Else it isn't.
>
> >> Any code we generate for a conditional thing is guarded by #if
> >> ... #endif.
> >>
> >> For features, we generate suitable data into qapi-introspect.c.
> >>
> >> For special features, we generate a little additional code here and
> >> there; look for .is_special() to find it.
> >>
> >> Bug: this additional code lacks #if ... #endif.  Simple oversight,
> >> should be easy enough to fix.
> >>
> >> > I guard against it here because, similarly, I have no idea how to
> handle
> >> > the case where it's true.
> >> >
> >> > I didn't realize we technically allow it, though ... would you like
> me to
> >> > move to expressly forbid it in the parser? (Failing that, I have no
> idea
> >> > how to display this information otherwise, so I'd need you to sketch
> >> > something out for me; so my inclination is to forbid it as you
> suggest.
> >> > Future developers can always lift the restriction once they have som=
e
> >> > use-case in mind and a plan for how to display that information.)
> >>
> >> I think we should first make a reasonable effort at figuring out how t=
o
> >> handle conditional special features.  If we fail, we can add the
> >> restriction instead.
> >
> > I don't think I agree; I don't think it's worth spending time defining =
a
> > feature we don't use in our minds to then design around a hypothetical
> > future use.
> >
> > Easier to admit we don't use it and save defining the semantics for the
> > future developer who stumbles across a reason for needing it.
>
> Semantics of "apply conditional to feature" don't need defining, because
> they are simply the same as "apply conditional to any other thing."
> When you have a definition for the general case that works for all the
> special cases, then outlawing one special case *increases* complexity.
> That's why I'm reluctant.
>
> I figure your actual problem more concrete than "what does it even
> mean?", namely how to present conditionals in generated documentation.
> In that context, features *may* differ from any other thing!
>
> Aside: the (mostly generated) QMP introspection is about this particular
> qemu-system-FOO, like all of QMP, whereas the (mostly generated) QMP
> documentation is about any qemu-system-FOO that could be built from this
> particular working tree.  May lead to doc generation problems that have
> no match elsewhere.
>
> >> How do you handle features in general, and special features in
> >> particular?
> >>
> >
> > Features: they go in the :feat: field list.
> > Special features: they go in the :feat: field list, and also receive a
> > special option flag to the directive to allow for special rendering of
> the
> > "signature bar" (the header line for a given entity definition in the
> > rendered documentation.)
> >
> > e.g.
> >
> > @deprecated will generate two things:
> >
> > 1) the definition block will get a :deprecated: option, which enables t=
he
> > html renderer to (potentially) do special things like color the entry
> > differently, add a "warning pip"/eyecatch, etc. It's scoped to the whol=
e
> > definition.
> >
> > 2) A :feat deprecated: line which is added to the features "field list"
> as
> > per normal for features.
> >
> >
> >> How do you handle conditionals in general?
> >>
> >
> > In this series, I don't!
> >
> > ...except for top-level conditionals, which are currently passed as-is =
as
> > an argument to the :ifcond: directive option. The format of that argume=
nt
> > and what the HTML renderer actually does with it is currently TBD.
> >
> > (In current prototypes I just print the conditional string in the
> signature
> > bar.)
> >
> >
> >> How do you combine feature and conditional?
> >>
> >
> > Notably TBD. Unhandled both in this series as-is *and* in my larger WIP=
.
>
> How do you combine definition and conditional?  You answered that right
> above: largely TBD.
>
> How do you combine enum value / object type member / command argument /
> event argument and conditional?  Also answered right above: not yet.
>
> What does that mean for the doc generator code?  Does it simply ignore
> conditionals there?
>
> >> How could you combine special feature and conditonal?
> >>
> >
> > Bewilderingly uncertain.
> >
> > Mechanically, it *could* be handled the same way :ifcond: directive
> options
> > are.
> >
> > e.g.
> >
> > ```
> > .. qapi:command:: x-beware-of-the-leopard
> >    :deprecated: {ifcond stuff here}
> >    :unstable: {ifcond stuff here}
> >
> >    lorem ipsum dolor sit amet
> >
> >    :feat deprecated: blah blah (if: ...)
> >    :feat unstable: blah blah (if: ...)
> > ```
> >
> > Semantically and in the rendered output, I have absolutely no clue
> > whatsoever; and doubt I could figure it out without a use case in front
> of
> > me to design around ... so I'd prefer to put up a traffic barrier for
> now.
> >
> > i.o.w. the design issue arises specifically because special features ar=
e
> > semanticaly special and are "hoisted" to be block-level in the
> > transmogrified rST doc, and so syntax needs to be designed, implemented
> and
> > tested if they are to be conditional.
>
> You choose to make them special in the documentation.  They haven't been
> special there so far.  I'm not telling you not to, I'm just pointing out
> this is a problem we elect to have :)
>
> > Yet, we have no such cases to facilitate the design, implementation and
> > testing.
> >
> > So, I'd like to prohibit until such time as we have such a case.
>
> I believe what you need isn't so much an explanation of semantics, it's
> use cases.  And that's fair!
>
> Let me offer two.
>
> 1. Imagine we're trying to develop something big & complex enough to
>    make keeping it out of tree until done impractical.  We feel even an
>    in-tree branch would be impractical.  Instead, we commit it to
>    master, default off, configure --enable-complex-thing to get it.  Not
>    exactly something we do all the time, but not outlandish, either.
>
>    Further imagine that the big & complex thing will involve some new
>    QMP commands replacing existing ones.  As usual, we want to mark the
>    ones being replaced deprecated, so we can remove them after a grace
>    period.
>
>    But simply deprecating them in the schema would be premature!  The
>    big & complex thing may fail, and if it does, we rip it out.  If it
>    succeeds, we enable it unconditionally.
>
>    We can express what we're doing by making feature deprecated
>    conditional on CONFIG_COMPLEX_THING, which is defined by
>    --enable-complex-thing.
>
>    That way, the complex thing doesn't affect the QMP interface unless
>    we enable it.  Good.  And if we enable it, we do get the deprecation,
>    and can test management applications cope with it.
>
> 2. Imagine we turned allow-preconfig into a special feature.  Further
>    imagine some whole-stack feature requires a certain command to have
>    allow-preconfig, and you got tasked with implementing it.  Which you
>    duly did, to everybody's satisfaction.  It is now days to the
>    release, rc4 has sailed, and some dude comes out of the woodwork to
>    report the command crashes in preconfig state.  Weird!  It worked
>    *fine* in your meticulous testing.  After some back and forth, you
>    discover that the reporter builds with --enable-exotic-crap, which
>    you didn't test, because you weren't even aware it exists.  You
>    enable it, and now the command crashes for you, too.  Fixing this
>    after rc4 is out of the question, too much churn.  You could,
>    however, make feature allow-preconfig conditional on not
>    CONFIG_EXOTIC_CRAP.
>
> >> [...]
>
>
Hm, alright. I think I'll just stub out conditionals with a TODO and circle
back to how I'll handle them; I need to do a pass on ifcond handling in
general, so I guess I'll get to it then. I still think it's a little weird,
but you don't, and you're the QAPI guy ;)

--js

--0000000000000f279f062b9ca3a5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 10,=
 2025 at 7:19=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; On Thu, Jan 9, 2025, 5:34=E2=80=AFAM Markus Armbruster &lt;<a href=3D"=
mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt; wrote=
:<br>
&gt;<br>
&gt;&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank=
">jsnow@redhat.com</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt; On Fri, Dec 20, 2024 at 9:15=E2=80=AFAM Markus Armbruster &lt=
;<a href=3D"mailto:armbru@redhat.com" target=3D"_blank">armbru@redhat.com</=
a>&gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" target=
=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; &gt; This method adds the options/preamble to each defini=
tion block. Notably,<br>
&gt;&gt; &gt;&gt; &gt; :since: and :ifcond: are added, as are any &quot;spe=
cial features&quot; such as<br>
&gt;&gt; &gt;&gt; &gt; :deprecated: and :unstable:.<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow=
@redhat.com" target=3D"_blank">jsnow@redhat.com</a>&gt;<br>
&gt;&gt; &gt;&gt; &gt; ---<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 docs/sphinx/qapidoc.py | 33 ++++++++++++++++++=
++++++++++++++-<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 1 file changed, 32 insertions(+), 1 deletion(-=
)<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qa=
pidoc.py<br>
&gt;&gt; &gt;&gt; &gt; index 6f8f69077b1..85c7ce94564 100644<br>
&gt;&gt; &gt;&gt; &gt; --- a/docs/sphinx/qapidoc.py<br>
&gt;&gt; &gt;&gt; &gt; +++ b/docs/sphinx/qapidoc.py<br>
&gt;&gt; &gt;&gt; &gt; @@ -38,7 +38,7 @@<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 from qapi.error import QAPIError, QAPISemError=
<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 from qapi.gen import QAPISchemaVisitor<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 from qapi.parser import QAPIDoc<br>
&gt;&gt; &gt;&gt; &gt; -from qapi.schema import QAPISchema<br>
&gt;&gt; &gt;&gt; &gt; +from qapi.schema import QAPISchema, QAPISchemaEntit=
y<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 from qapi.source import QAPISourceInfo<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 from sphinx import addnodes<br>
&gt;&gt; &gt;&gt; &gt; @@ -125,6 +125,37 @@ def ensure_blank_line(self) -&g=
t; None:<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # +2=
: correct for zero/one index, then increment by one.<br>
&gt;&gt; &gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self=
.add_line_raw(&quot;&quot;, fname, line + 2)<br>
&gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 # Transmogrification helpers<br>
&gt;&gt; &gt;&gt; &gt; +<br>
&gt;&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 def preamble(self, ent: QAPISchemaEnt=
ity) -&gt; None:<br>
&gt;&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 Generate option lines f=
or qapi entity directives.<br>
&gt;&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt;&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ent.doc and ent.doc.=
since:<br>
&gt;&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert en=
t.doc.since.tag =3D=3D QAPIDoc.Tag.SINCE<br>
&gt;&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Generat=
ed from the entity&#39;s docblock; info location is exact.<br>
&gt;&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_=
line(f&quot;:since: {ent.doc.since.text}&quot;, <a href=3D"http://ent.doc.s=
ince.info" rel=3D"noreferrer" target=3D"_blank">ent.doc.since.info</a>)<br>
&gt;&gt; &gt;&gt; &gt; +<br>
&gt;&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ent.ifcond.is_presen=
t():<br>
&gt;&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 doc =3D e=
nt.ifcond.docgen()<br>
&gt;&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Generat=
ed from entity definition; info location is approximate.<br>
&gt;&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.add_=
line(f&quot;:ifcond: {doc}&quot;, <a href=3D"http://ent.info" rel=3D"norefe=
rrer" target=3D"_blank">ent.info</a>)<br>
&gt;&gt; &gt;&gt; &gt; +<br>
&gt;&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Hoist special feature=
s such as :deprecated: and :unstable:<br>
&gt;&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # into the options bloc=
k for the entity. If, in the future, new<br>
&gt;&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # special features are =
added, qapi-domain will chirp about<br>
&gt;&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # unrecognized options =
and fail.<br>
&gt;&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for feat in ent.feature=
s:<br>
&gt;&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if feat.i=
s_special():<br>
&gt;&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 # We don&#39;t expect special features to have an ifcond property.<b=
r>
&gt;&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 # (Hello, intrepid developer in the future who changed that!)<br>
&gt;&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 # ((With luck, you are not me.))<br>
&gt;&gt; &gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 assert not feat.ifcond.is_present()<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; Nope :)<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; The attempt to add a conditional special feature now fail=
s with<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0Sphinx parallel build error:<br>
&gt;&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0AssertionError<br>
&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; If you want to outlaw conditional special features, rejec=
t them cleanly<br>
&gt;&gt; &gt;&gt; in schema.py, document the restriction in docs/devel/qapi=
-code-gen.rst,<br>
&gt;&gt; &gt;&gt; and explain why in the commit message.=C2=A0 Recommend a =
separate commit, to<br>
&gt;&gt; &gt;&gt; make it stand out in git-log.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Do you advocate this? I wasn&#39;t sure what it *meant* for a=
 special feature<br>
&gt;&gt; &gt; to be conditional; I couldn&#39;t conceive of what it meant t=
o have an ifcond<br>
&gt;&gt; &gt; for &quot;deprecated&quot; or &quot;unstable&quot;, for insta=
nce. It sounds like it isn&#39;t well<br>
&gt;&gt; &gt; defined, but we happen to not expressly forbid it.<br>
&gt;&gt;<br>
&gt;&gt; Semantics are clear enough to me.<br>
&gt;&gt;<br>
&gt;&gt; &quot;Conditional special feature&quot; combines &quot;conditional=
 feature&quot; (which is a<br>
&gt;&gt; special case of conditional thing) with special feature (which is =
a<br>
&gt;&gt; special case of feature).<br>
&gt;&gt;<br>
&gt;&gt; The QAPI schema language supports compile-time conditionals for ce=
rtain<br>
&gt;&gt; things.=C2=A0 Generated code behaves as if the thing didn&#39;t ex=
ist unless its<br>
&gt;&gt; condition is true.<br>
&gt;&gt;<br>
&gt;&gt; QAPI schema features are strings exposed to clients in introspecti=
on.<br>
&gt;&gt;<br>
&gt;&gt; Combine the two: a conditional feature is exposed if and only if i=
ts<br>
&gt;&gt; condition is true.<br>
&gt;&gt;<br>
&gt;&gt; Existing uses: dynamic-auto-read-only if CONFIG_POSIX, fdset if<br=
>
&gt;&gt; CONFIG_BLKIO_VHOST_VDPA_FD.<br>
&gt;&gt;<br>
&gt;&gt; A special feature is a feature that has special meaning to the<br>
&gt;&gt; generator, i.e. we generate different code in places when it&#39;s=
 present.<br>
&gt;&gt;<br>
&gt;&gt; Combine: we enable different code for a conditional special featur=
e only<br>
&gt;&gt; when its condition is true.<br>
&gt;&gt;<br>
&gt;&gt; No existing uses so far.<br>
&gt;&gt;<br>
&gt;&gt; Implementation is straightforward, too.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Mechanically, it&#39;s well defined... but that isn&#39;t my concern.<=
br>
&gt;<br>
&gt; What I asked you was: &quot;what would it mean for deprecated to be co=
nditional?&quot;<br>
&gt;<br>
&gt; Without understanding that, I have no chance to design a system that<b=
r>
&gt; handles that information accordingly for the documentation.<br>
<br>
Special feature deprecated means the use of the thing that has it is<br>
deprecated with this particular qemu-system-FOO.<br>
<br>
Why &quot;this particular&quot;?=C2=A0 Because it wasn&#39;t deprecated in =
some prior<br>
version of QEMU.=C2=A0 Features (special or not) are always, always about t=
he<br>
specific qemu-system-FOO binary you&#39;re talking to via QMP.<br>
<br>
Conditionals are compile-time schema configuration.=C2=A0 Either the<br>
condition is true or not at compile time.=C2=A0 If it&#39;s true, the thing=
 that<br>
has it is there, else it isn&#39;t.<br>
<br>
Now combine the two.=C2=A0 If the condition of special feature &#39;depreca=
te&#39; is<br>
true, the thing that has it is deprecated with this particular<br>
qemu-system-FOO.=C2=A0 Else it isn&#39;t.<br>
<br>
&gt;&gt; Any code we generate for a conditional thing is guarded by #if<br>
&gt;&gt; ... #endif.<br>
&gt;&gt;<br>
&gt;&gt; For features, we generate suitable data into qapi-introspect.c.<br=
>
&gt;&gt;<br>
&gt;&gt; For special features, we generate a little additional code here an=
d<br>
&gt;&gt; there; look for .is_special() to find it.<br>
&gt;&gt;<br>
&gt;&gt; Bug: this additional code lacks #if ... #endif.=C2=A0 Simple overs=
ight,<br>
&gt;&gt; should be easy enough to fix.<br>
&gt;&gt;<br>
&gt;&gt; &gt; I guard against it here because, similarly, I have no idea ho=
w to handle<br>
&gt;&gt; &gt; the case where it&#39;s true.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I didn&#39;t realize we technically allow it, though ... woul=
d you like me to<br>
&gt;&gt; &gt; move to expressly forbid it in the parser? (Failing that, I h=
ave no idea<br>
&gt;&gt; &gt; how to display this information otherwise, so I&#39;d need yo=
u to sketch<br>
&gt;&gt; &gt; something out for me; so my inclination is to forbid it as yo=
u suggest.<br>
&gt;&gt; &gt; Future developers can always lift the restriction once they h=
ave some<br>
&gt;&gt; &gt; use-case in mind and a plan for how to display that informati=
on.)<br>
&gt;&gt;<br>
&gt;&gt; I think we should first make a reasonable effort at figuring out h=
ow to<br>
&gt;&gt; handle conditional special features.=C2=A0 If we fail, we can add =
the<br>
&gt;&gt; restriction instead.<br>
&gt;<br>
&gt; I don&#39;t think I agree; I don&#39;t think it&#39;s worth spending t=
ime defining a<br>
&gt; feature we don&#39;t use in our minds to then design around a hypothet=
ical<br>
&gt; future use.<br>
&gt;<br>
&gt; Easier to admit we don&#39;t use it and save defining the semantics fo=
r the<br>
&gt; future developer who stumbles across a reason for needing it.<br>
<br>
Semantics of &quot;apply conditional to feature&quot; don&#39;t need defini=
ng, because<br>
they are simply the same as &quot;apply conditional to any other thing.&quo=
t;<br>
When you have a definition for the general case that works for all the<br>
special cases, then outlawing one special case *increases* complexity.<br>
That&#39;s why I&#39;m reluctant.<br>
<br>
I figure your actual problem more concrete than &quot;what does it even<br>
mean?&quot;, namely how to present conditionals in generated documentation.=
<br>
In that context, features *may* differ from any other thing!<br>
<br>
Aside: the (mostly generated) QMP introspection is about this particular<br=
>
qemu-system-FOO, like all of QMP, whereas the (mostly generated) QMP<br>
documentation is about any qemu-system-FOO that could be built from this<br=
>
particular working tree.=C2=A0 May lead to doc generation problems that hav=
e<br>
no match elsewhere.<br>
<br>
&gt;&gt; How do you handle features in general, and special features in<br>
&gt;&gt; particular?<br>
&gt;&gt;<br>
&gt;<br>
&gt; Features: they go in the :feat: field list.<br>
&gt; Special features: they go in the :feat: field list, and also receive a=
<br>
&gt; special option flag to the directive to allow for special rendering of=
 the<br>
&gt; &quot;signature bar&quot; (the header line for a given entity definiti=
on in the<br>
&gt; rendered documentation.)<br>
&gt;<br>
&gt; e.g.<br>
&gt;<br>
&gt; @deprecated will generate two things:<br>
&gt;<br>
&gt; 1) the definition block will get a :deprecated: option, which enables =
the<br>
&gt; html renderer to (potentially) do special things like color the entry<=
br>
&gt; differently, add a &quot;warning pip&quot;/eyecatch, etc. It&#39;s sco=
ped to the whole<br>
&gt; definition.<br>
&gt;<br>
&gt; 2) A :feat deprecated: line which is added to the features &quot;field=
 list&quot; as<br>
&gt; per normal for features.<br>
&gt;<br>
&gt;<br>
&gt;&gt; How do you handle conditionals in general?<br>
&gt;&gt;<br>
&gt;<br>
&gt; In this series, I don&#39;t!<br>
&gt;<br>
&gt; ...except for top-level conditionals, which are currently passed as-is=
 as<br>
&gt; an argument to the :ifcond: directive option. The format of that argum=
ent<br>
&gt; and what the HTML renderer actually does with it is currently TBD.<br>
&gt;<br>
&gt; (In current prototypes I just print the conditional string in the sign=
ature<br>
&gt; bar.)<br>
&gt;<br>
&gt;<br>
&gt;&gt; How do you combine feature and conditional?<br>
&gt;&gt;<br>
&gt;<br>
&gt; Notably TBD. Unhandled both in this series as-is *and* in my larger WI=
P.<br>
<br>
How do you combine definition and conditional?=C2=A0 You answered that righ=
t<br>
above: largely TBD.<br>
<br>
How do you combine enum value / object type member / command argument /<br>
event argument and conditional?=C2=A0 Also answered right above: not yet.<b=
r>
<br>
What does that mean for the doc generator code?=C2=A0 Does it simply ignore=
<br>
conditionals there?<br>
<br>
&gt;&gt; How could you combine special feature and conditonal?<br>
&gt;&gt;<br>
&gt;<br>
&gt; Bewilderingly uncertain.<br>
&gt;<br>
&gt; Mechanically, it *could* be handled the same way :ifcond: directive op=
tions<br>
&gt; are.<br>
&gt;<br>
&gt; e.g.<br>
&gt;<br>
&gt; ```<br>
&gt; .. qapi:command:: x-beware-of-the-leopard<br>
&gt;=C2=A0 =C2=A0 :deprecated: {ifcond stuff here}<br>
&gt;=C2=A0 =C2=A0 :unstable: {ifcond stuff here}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 lorem ipsum dolor sit amet<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 :feat deprecated: blah blah (if: ...)<br>
&gt;=C2=A0 =C2=A0 :feat unstable: blah blah (if: ...)<br>
&gt; ```<br>
&gt;<br>
&gt; Semantically and in the rendered output, I have absolutely no clue<br>
&gt; whatsoever; and doubt I could figure it out without a use case in fron=
t of<br>
&gt; me to design around ... so I&#39;d prefer to put up a traffic barrier =
for now.<br>
&gt;<br>
&gt; i.o.w. the design issue arises specifically because special features a=
re<br>
&gt; semanticaly special and are &quot;hoisted&quot; to be block-level in t=
he<br>
&gt; transmogrified rST doc, and so syntax needs to be designed, implemente=
d and<br>
&gt; tested if they are to be conditional.<br>
<br>
You choose to make them special in the documentation.=C2=A0 They haven&#39;=
t been<br>
special there so far.=C2=A0 I&#39;m not telling you not to, I&#39;m just po=
inting out<br>
this is a problem we elect to have :)<br>
<br>
&gt; Yet, we have no such cases to facilitate the design, implementation an=
d<br>
&gt; testing.<br>
&gt;<br>
&gt; So, I&#39;d like to prohibit until such time as we have such a case.<b=
r>
<br>
I believe what you need isn&#39;t so much an explanation of semantics, it&#=
39;s<br>
use cases.=C2=A0 And that&#39;s fair!<br>
<br>
Let me offer two.<br>
<br>
1. Imagine we&#39;re trying to develop something big &amp; complex enough t=
o<br>
=C2=A0 =C2=A0make keeping it out of tree until done impractical.=C2=A0 We f=
eel even an<br>
=C2=A0 =C2=A0in-tree branch would be impractical.=C2=A0 Instead, we commit =
it to<br>
=C2=A0 =C2=A0master, default off, configure --enable-complex-thing to get i=
t.=C2=A0 Not<br>
=C2=A0 =C2=A0exactly something we do all the time, but not outlandish, eith=
er.<br>
<br>
=C2=A0 =C2=A0Further imagine that the big &amp; complex thing will involve =
some new<br>
=C2=A0 =C2=A0QMP commands replacing existing ones.=C2=A0 As usual, we want =
to mark the<br>
=C2=A0 =C2=A0ones being replaced deprecated, so we can remove them after a =
grace<br>
=C2=A0 =C2=A0period.<br>
<br>
=C2=A0 =C2=A0But simply deprecating them in the schema would be premature!=
=C2=A0 The<br>
=C2=A0 =C2=A0big &amp; complex thing may fail, and if it does, we rip it ou=
t.=C2=A0 If it<br>
=C2=A0 =C2=A0succeeds, we enable it unconditionally.<br>
<br>
=C2=A0 =C2=A0We can express what we&#39;re doing by making feature deprecat=
ed<br>
=C2=A0 =C2=A0conditional on CONFIG_COMPLEX_THING, which is defined by<br>
=C2=A0 =C2=A0--enable-complex-thing.<br>
<br>
=C2=A0 =C2=A0That way, the complex thing doesn&#39;t affect the QMP interfa=
ce unless<br>
=C2=A0 =C2=A0we enable it.=C2=A0 Good.=C2=A0 And if we enable it, we do get=
 the deprecation,<br>
=C2=A0 =C2=A0and can test management applications cope with it.<br>
<br>
2. Imagine we turned allow-preconfig into a special feature.=C2=A0 Further<=
br>
=C2=A0 =C2=A0imagine some whole-stack feature requires a certain command to=
 have<br>
=C2=A0 =C2=A0allow-preconfig, and you got tasked with implementing it.=C2=
=A0 Which you<br>
=C2=A0 =C2=A0duly did, to everybody&#39;s satisfaction.=C2=A0 It is now day=
s to the<br>
=C2=A0 =C2=A0release, rc4 has sailed, and some dude comes out of the woodwo=
rk to<br>
=C2=A0 =C2=A0report the command crashes in preconfig state.=C2=A0 Weird!=C2=
=A0 It worked<br>
=C2=A0 =C2=A0*fine* in your meticulous testing.=C2=A0 After some back and f=
orth, you<br>
=C2=A0 =C2=A0discover that the reporter builds with --enable-exotic-crap, w=
hich<br>
=C2=A0 =C2=A0you didn&#39;t test, because you weren&#39;t even aware it exi=
sts.=C2=A0 You<br>
=C2=A0 =C2=A0enable it, and now the command crashes for you, too.=C2=A0 Fix=
ing this<br>
=C2=A0 =C2=A0after rc4 is out of the question, too much churn.=C2=A0 You co=
uld,<br>
=C2=A0 =C2=A0however, make feature allow-preconfig conditional on not<br>
=C2=A0 =C2=A0CONFIG_EXOTIC_CRAP.<br>
<br>
&gt;&gt; [...]<br>
<br></blockquote><div><br></div><div>Hm, alright. I think I&#39;ll just stu=
b out conditionals with a TODO and circle back to how I&#39;ll handle them;=
 I need to do a pass on ifcond handling in general, so I guess I&#39;ll get=
 to it then. I still think it&#39;s a little weird, but you don&#39;t, and =
you&#39;re the QAPI guy ;)</div><div><br></div><div>--js<br></div></div></d=
iv>

--0000000000000f279f062b9ca3a5--


