Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3224AE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 12:22:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWDzE-0007Ob-WA; Fri, 10 Jan 2025 07:19:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tWDyz-00075G-Mz
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:19:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tWDyw-0004G3-Iu
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:19:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736511556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cCgMZayUsrb8Ns2WsyZCOoDDAz1vk1Jb6jGXxNE5j4s=;
 b=PAFLexU5C0t4DnhNKHM7eqlzTdlkmDCwvGX/PbD+R1Ax39BpyzKGsFVwxRXvwpkYQJwlad
 DnTuWu8gAmGHvEz6pBxrLn7hyZrqwx3Y71em2EIFy5Uhx4/gE2aQp8YvzZIvS1GrFRuJku
 qs/wDxlvcWqhKxRVfOIUMVw5FgzCBfE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-RZ0wu29xNNmU4Ql_Z27TFA-1; Fri,
 10 Jan 2025 07:19:07 -0500
X-MC-Unique: RZ0wu29xNNmU4Ql_Z27TFA-1
X-Mimecast-MFC-AGG-ID: RZ0wu29xNNmU4Ql_Z27TFA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECD451956050; Fri, 10 Jan 2025 12:19:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.101])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 777C030001BE; Fri, 10 Jan 2025 12:19:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2F34221E6924; Fri, 10 Jan 2025 13:19:03 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 11/23] docs/qapidoc: add preamble() method
In-Reply-To: <CAFn=p-bum9NvZNEYRKCD6Wh_GucSmT33YT9aEqK80u+2d7cUQQ@mail.gmail.com>
 (John Snow's message of "Thu, 9 Jan 2025 13:04:39 -0500")
References: <20241213021827.2956769-1-jsnow@redhat.com>
 <20241213021827.2956769-12-jsnow@redhat.com>
 <87h66y30gn.fsf@pond.sub.org>
 <CAFn=p-ZAXSMyO3cWw=CXG1Hbd06ToQeUsgO4FsfNqDEvaZRujg@mail.gmail.com>
 <87sepss2bv.fsf@pond.sub.org>
 <CAFn=p-bum9NvZNEYRKCD6Wh_GucSmT33YT9aEqK80u+2d7cUQQ@mail.gmail.com>
Date: Fri, 10 Jan 2025 13:19:03 +0100
Message-ID: <87v7um2760.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

John Snow <jsnow@redhat.com> writes:

> On Thu, Jan 9, 2025, 5:34=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > On Fri, Dec 20, 2024 at 9:15=E2=80=AFAM Markus Armbruster <armbru@redh=
at.com> wrote:
>> >
>> >> John Snow <jsnow@redhat.com> writes:
>> >>
>> >> > This method adds the options/preamble to each definition block. Not=
ably,
>> >> > :since: and :ifcond: are added, as are any "special features" such =
as
>> >> > :deprecated: and :unstable:.
>> >> >
>> >> > Signed-off-by: John Snow <jsnow@redhat.com>
>> >> > ---
>> >> >  docs/sphinx/qapidoc.py | 33 ++++++++++++++++++++++++++++++++-
>> >> >  1 file changed, 32 insertions(+), 1 deletion(-)
>> >> >
>> >> > diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
>> >> > index 6f8f69077b1..85c7ce94564 100644
>> >> > --- a/docs/sphinx/qapidoc.py
>> >> > +++ b/docs/sphinx/qapidoc.py
>> >> > @@ -38,7 +38,7 @@
>> >> >  from qapi.error import QAPIError, QAPISemError
>> >> >  from qapi.gen import QAPISchemaVisitor
>> >> >  from qapi.parser import QAPIDoc
>> >> > -from qapi.schema import QAPISchema
>> >> > +from qapi.schema import QAPISchema, QAPISchemaEntity
>> >> >  from qapi.source import QAPISourceInfo
>> >> >
>> >> >  from sphinx import addnodes
>> >> > @@ -125,6 +125,37 @@ def ensure_blank_line(self) -> None:
>> >> >              # +2: correct for zero/one index, then increment by on=
e.
>> >> >              self.add_line_raw("", fname, line + 2)
>> >> >
>> >> > +    # Transmogrification helpers
>> >> > +
>> >> > +    def preamble(self, ent: QAPISchemaEntity) -> None:
>> >> > +        """
>> >> > +        Generate option lines for qapi entity directives.
>> >> > +        """
>> >> > +        if ent.doc and ent.doc.since:
>> >> > +            assert ent.doc.since.tag =3D=3D QAPIDoc.Tag.SINCE
>> >> > +            # Generated from the entity's docblock; info location =
is exact.
>> >> > +            self.add_line(f":since: {ent.doc.since.text}", ent.doc=
.since.info)
>> >> > +
>> >> > +        if ent.ifcond.is_present():
>> >> > +            doc =3D ent.ifcond.docgen()
>> >> > +            # Generated from entity definition; info location is a=
pproximate.
>> >> > +            self.add_line(f":ifcond: {doc}", ent.info)
>> >> > +
>> >> > +        # Hoist special features such as :deprecated: and :unstabl=
e:
>> >> > +        # into the options block for the entity. If, in the future=
, new
>> >> > +        # special features are added, qapi-domain will chirp about
>> >> > +        # unrecognized options and fail.
>> >> > +        for feat in ent.features:
>> >> > +            if feat.is_special():
>> >> > +                # We don't expect special features to have an ifco=
nd property.
>> >> > +                # (Hello, intrepid developer in the future who cha=
nged that!)
>> >> > +                # ((With luck, you are not me.))
>> >> > +                assert not feat.ifcond.is_present()
>> >>
>> >> Nope :)
>> >>
>> >> The attempt to add a conditional special feature now fails with
>> >>
>> >>     Sphinx parallel build error:
>> >>     AssertionError
>> >>
>> >> If you want to outlaw conditional special features, reject them clean=
ly
>> >> in schema.py, document the restriction in docs/devel/qapi-code-gen.rs=
t,
>> >> and explain why in the commit message.  Recommend a separate commit, =
to
>> >> make it stand out in git-log.
>> >
>> > Do you advocate this? I wasn't sure what it *meant* for a special feat=
ure
>> > to be conditional; I couldn't conceive of what it meant to have an ifc=
ond
>> > for "deprecated" or "unstable", for instance. It sounds like it isn't =
well
>> > defined, but we happen to not expressly forbid it.
>>
>> Semantics are clear enough to me.
>>
>> "Conditional special feature" combines "conditional feature" (which is a
>> special case of conditional thing) with special feature (which is a
>> special case of feature).
>>
>> The QAPI schema language supports compile-time conditionals for certain
>> things.  Generated code behaves as if the thing didn't exist unless its
>> condition is true.
>>
>> QAPI schema features are strings exposed to clients in introspection.
>>
>> Combine the two: a conditional feature is exposed if and only if its
>> condition is true.
>>
>> Existing uses: dynamic-auto-read-only if CONFIG_POSIX, fdset if
>> CONFIG_BLKIO_VHOST_VDPA_FD.
>>
>> A special feature is a feature that has special meaning to the
>> generator, i.e. we generate different code in places when it's present.
>>
>> Combine: we enable different code for a conditional special feature only
>> when its condition is true.
>>
>> No existing uses so far.
>>
>> Implementation is straightforward, too.
>>
>
> Mechanically, it's well defined... but that isn't my concern.
>
> What I asked you was: "what would it mean for deprecated to be conditiona=
l?"
>
> Without understanding that, I have no chance to design a system that
> handles that information accordingly for the documentation.

Special feature deprecated means the use of the thing that has it is
deprecated with this particular qemu-system-FOO.

Why "this particular"?  Because it wasn't deprecated in some prior
version of QEMU.  Features (special or not) are always, always about the
specific qemu-system-FOO binary you're talking to via QMP.

Conditionals are compile-time schema configuration.  Either the
condition is true or not at compile time.  If it's true, the thing that
has it is there, else it isn't.

Now combine the two.  If the condition of special feature 'deprecate' is
true, the thing that has it is deprecated with this particular
qemu-system-FOO.  Else it isn't.

>> Any code we generate for a conditional thing is guarded by #if
>> ... #endif.
>>
>> For features, we generate suitable data into qapi-introspect.c.
>>
>> For special features, we generate a little additional code here and
>> there; look for .is_special() to find it.
>>
>> Bug: this additional code lacks #if ... #endif.  Simple oversight,
>> should be easy enough to fix.
>>
>> > I guard against it here because, similarly, I have no idea how to hand=
le
>> > the case where it's true.
>> >
>> > I didn't realize we technically allow it, though ... would you like me=
 to
>> > move to expressly forbid it in the parser? (Failing that, I have no id=
ea
>> > how to display this information otherwise, so I'd need you to sketch
>> > something out for me; so my inclination is to forbid it as you suggest.
>> > Future developers can always lift the restriction once they have some
>> > use-case in mind and a plan for how to display that information.)
>>
>> I think we should first make a reasonable effort at figuring out how to
>> handle conditional special features.  If we fail, we can add the
>> restriction instead.
>
> I don't think I agree; I don't think it's worth spending time defining a
> feature we don't use in our minds to then design around a hypothetical
> future use.
>
> Easier to admit we don't use it and save defining the semantics for the
> future developer who stumbles across a reason for needing it.

Semantics of "apply conditional to feature" don't need defining, because
they are simply the same as "apply conditional to any other thing."
When you have a definition for the general case that works for all the
special cases, then outlawing one special case *increases* complexity.
That's why I'm reluctant.

I figure your actual problem more concrete than "what does it even
mean?", namely how to present conditionals in generated documentation.
In that context, features *may* differ from any other thing!

Aside: the (mostly generated) QMP introspection is about this particular
qemu-system-FOO, like all of QMP, whereas the (mostly generated) QMP
documentation is about any qemu-system-FOO that could be built from this
particular working tree.  May lead to doc generation problems that have
no match elsewhere.

>> How do you handle features in general, and special features in
>> particular?
>>
>
> Features: they go in the :feat: field list.
> Special features: they go in the :feat: field list, and also receive a
> special option flag to the directive to allow for special rendering of the
> "signature bar" (the header line for a given entity definition in the
> rendered documentation.)
>
> e.g.
>
> @deprecated will generate two things:
>
> 1) the definition block will get a :deprecated: option, which enables the
> html renderer to (potentially) do special things like color the entry
> differently, add a "warning pip"/eyecatch, etc. It's scoped to the whole
> definition.
>
> 2) A :feat deprecated: line which is added to the features "field list" as
> per normal for features.
>
>
>> How do you handle conditionals in general?
>>
>
> In this series, I don't!
>
> ...except for top-level conditionals, which are currently passed as-is as
> an argument to the :ifcond: directive option. The format of that argument
> and what the HTML renderer actually does with it is currently TBD.
>
> (In current prototypes I just print the conditional string in the signatu=
re
> bar.)
>
>
>> How do you combine feature and conditional?
>>
>
> Notably TBD. Unhandled both in this series as-is *and* in my larger WIP.

How do you combine definition and conditional?  You answered that right
above: largely TBD.

How do you combine enum value / object type member / command argument /
event argument and conditional?  Also answered right above: not yet.

What does that mean for the doc generator code?  Does it simply ignore
conditionals there?

>> How could you combine special feature and conditonal?
>>
>
> Bewilderingly uncertain.
>
> Mechanically, it *could* be handled the same way :ifcond: directive optio=
ns
> are.
>
> e.g.
>
> ```
> .. qapi:command:: x-beware-of-the-leopard
>    :deprecated: {ifcond stuff here}
>    :unstable: {ifcond stuff here}
>
>    lorem ipsum dolor sit amet
>
>    :feat deprecated: blah blah (if: ...)
>    :feat unstable: blah blah (if: ...)
> ```
>
> Semantically and in the rendered output, I have absolutely no clue
> whatsoever; and doubt I could figure it out without a use case in front of
> me to design around ... so I'd prefer to put up a traffic barrier for now.
>
> i.o.w. the design issue arises specifically because special features are
> semanticaly special and are "hoisted" to be block-level in the
> transmogrified rST doc, and so syntax needs to be designed, implemented a=
nd
> tested if they are to be conditional.

You choose to make them special in the documentation.  They haven't been
special there so far.  I'm not telling you not to, I'm just pointing out
this is a problem we elect to have :)

> Yet, we have no such cases to facilitate the design, implementation and
> testing.
>
> So, I'd like to prohibit until such time as we have such a case.

I believe what you need isn't so much an explanation of semantics, it's
use cases.  And that's fair!

Let me offer two.

1. Imagine we're trying to develop something big & complex enough to
   make keeping it out of tree until done impractical.  We feel even an
   in-tree branch would be impractical.  Instead, we commit it to
   master, default off, configure --enable-complex-thing to get it.  Not
   exactly something we do all the time, but not outlandish, either.

   Further imagine that the big & complex thing will involve some new
   QMP commands replacing existing ones.  As usual, we want to mark the
   ones being replaced deprecated, so we can remove them after a grace
   period.

   But simply deprecating them in the schema would be premature!  The
   big & complex thing may fail, and if it does, we rip it out.  If it
   succeeds, we enable it unconditionally.

   We can express what we're doing by making feature deprecated
   conditional on CONFIG_COMPLEX_THING, which is defined by
   --enable-complex-thing.

   That way, the complex thing doesn't affect the QMP interface unless
   we enable it.  Good.  And if we enable it, we do get the deprecation,
   and can test management applications cope with it.

2. Imagine we turned allow-preconfig into a special feature.  Further
   imagine some whole-stack feature requires a certain command to have
   allow-preconfig, and you got tasked with implementing it.  Which you
   duly did, to everybody's satisfaction.  It is now days to the
   release, rc4 has sailed, and some dude comes out of the woodwork to
   report the command crashes in preconfig state.  Weird!  It worked
   *fine* in your meticulous testing.  After some back and forth, you
   discover that the reporter builds with --enable-exotic-crap, which
   you didn't test, because you weren't even aware it exists.  You
   enable it, and now the command crashes for you, too.  Fixing this
   after rc4 is out of the question, too much churn.  You could,
   however, make feature allow-preconfig conditional on not
   CONFIG_EXOTIC_CRAP.

>> [...]


