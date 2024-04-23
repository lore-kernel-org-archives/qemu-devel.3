Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC0EC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 18:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzKwo-00082l-B5; Tue, 23 Apr 2024 14:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rzKwn-00082Q-Gk
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 14:32:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rzKwj-0006EC-Lv
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 14:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713897168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UxLXuKs6wGKRbgVBkDu7d8BLgs93e1uhnCEHpws/eK0=;
 b=WUfok3Bhjout384VKj4ZxWdFIIY8XK/9qiiigWEHvEubejd3jiou2qxncF7b/m2z5mryH5
 ShLDIkBezLsLVH5kCE8cBOwDPNkD/dXIvTkpNu3c8fQv3R/H9MjcO6hY6xGP+bghdX6UJ6
 SOs7GDd8MQ2obe6GpVMQlPCmExzFC40=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-1ygaD9uMMEyC2I-pxyL_pQ-1; Tue, 23 Apr 2024 14:32:46 -0400
X-MC-Unique: 1ygaD9uMMEyC2I-pxyL_pQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2a2dbaacff8so6789530a91.2
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 11:32:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713897164; x=1714501964;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UxLXuKs6wGKRbgVBkDu7d8BLgs93e1uhnCEHpws/eK0=;
 b=dDmEd1RPrvdBYB1BxyA88mBRbICXs3MDlF5fj3IBom5tvn299MLv3GidyDmat9mRJ6
 UXaTzcIPuZFWCnzABT6Qpyd/jEduWjQQIz51CEWBS+bCfUNsjBoWxdmeJaUuP3I6I65M
 TUeKfhhqp4VbQI4xfe2vT/AxhupD5+ggHeVYfzX2w9PC0t2LPALSPjRXVaD9cpq/wz+1
 XYqnLceNHcnYrpv2+IxsZcLxlrtqSJrvyWE6G923A64UR2+4X3vwKr7HuMG94u6uCqcx
 eEmIXkh+2IL0uXJAX9ZsQS1GenTQ2F13+pGcT/Z+OvOh3yyGeUe+bMGXUcSTwZtAepRx
 5IFQ==
X-Gm-Message-State: AOJu0Yxdpja3ZnUJJD//xbQI6omtNOrpn89I3ZoL+RBkHIgDPL4lQUIn
 FF+yAdFqfIfTt5Od7uEEzjdRACf1aI5hsP81RAh+UghO1tKMBbtTPeRadFEBdiU6rGN9oZUFs0v
 3b0xeEixIhuijv73xpBLwbbmjdk8rTdjbB0MEa7cVsiVES3iusTiYz0UtBZukme+Bia3HFSS14r
 SDdaaj+OQtlE95NsjpSxVM9okfx9DnQ9/AwHI=
X-Received: by 2002:a17:90a:f40e:b0:2a7:b6ee:2ed0 with SMTP id
 ch14-20020a17090af40e00b002a7b6ee2ed0mr230224pjb.7.1713897164435; 
 Tue, 23 Apr 2024 11:32:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuU+oxMJslBPt8x7IvEMPbq5Di8hC23+x8lsE3MaOVUWU9jDAx8XrSdOdb0PFyxz9gccwitU2VRXeSnrAt0DE=
X-Received: by 2002:a17:90a:f40e:b0:2a7:b6ee:2ed0 with SMTP id
 ch14-20020a17090af40e00b002a7b6ee2ed0mr230201pjb.7.1713897164049; Tue, 23 Apr
 2024 11:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240419043820.178731-1-jsnow@redhat.com>
 <87msppl8c8.fsf@pond.sub.org>
 <CAFn=p-YaP+qg8C9iQUHkk_03gqnuhA0Ps6pcUeZuCiiScSTVpQ@mail.gmail.com>
 <87wmopg3ez.fsf@pond.sub.org>
 <CAFn=p-bXLbn1o1f+jsFUP502yak0r4yNvAYjTz4MMXShygQQ7g@mail.gmail.com>
 <CAFn=p-YUceA2kx7OQJPxThRi5_w-V-N7YJY57T4paapcvBRUvw@mail.gmail.com>
 <877cgoa5a0.fsf@pond.sub.org>
In-Reply-To: <877cgoa5a0.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 23 Apr 2024 14:32:31 -0400
Message-ID: <CAFn=p-bE053tRvnC0791duhh64-7cC_in5Y_qTmamXQaoLyWew@mail.gmail.com>
Subject: Re: [PATCH 00/27] Add qapi-domain Sphinx extension
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a52ecc0616c7c7cc"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--000000000000a52ecc0616c7c7cc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024, 3:48=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > On Mon, Apr 22, 2024 at 12:38=E2=80=AFPM John Snow <jsnow@redhat.com> w=
rote:
> >>
> >> On Mon, Apr 22, 2024 at 5:20=E2=80=AFAM Markus Armbruster <armbru@redh=
at.com>
> wrote:
> >> >
> >> > John Snow <jsnow@redhat.com> writes:
> >> >
> >> > > On Fri, Apr 19, 2024, 10:45=E2=80=AFAM Markus Armbruster <armbru@r=
edhat.com>
> wrote:
> >> > >
> >> > >> John Snow <jsnow@redhat.com> writes:
> >> > >>
> >> > >> > This series adds a new qapi-domain extension for Sphinx, which
> adds a
> >> > >> > series of custom directives for documenting QAPI definitions.
>
> [...]
>
> >> > >> > Known issues / points of interest:
>
> [...]
>
> >> > >> > - Inlining all members means there is some ambiguity on what to
> do with
> >> > >> >   doc block sections on inlined entities; features and members
> have an
> >> > >> >   obvious home - body, since, and misc sections are not as
> obvious on
> >> > >> >   how to handle. This will feature more prominently in the
> generator
> >> > >> >   series.
> >> > >>
> >> > >> Yes, this is a real problem.
> >> > >>
> >> > >> The member documentation gets written in the context of the type.
> It
> >> > >> may make sense only in that context.  Inlining copies it into a
> >> > >> different context.
> >> > >>
> >> > >> Features may need to combine.  Say a command's arguments are a
> union
> >> > >> type, and several branches of the union both contain deprecated
> members.
> >> > >> These branch types all document feature @deprecated.  Simply
> inlining
> >> > >> their feature documentation results in feature @deprecated
> documented
> >> > >> several times.  Ugh.  Combining them would be better.  But how?
> Do we
> >> > >> need to rethink how we document features?
> >> > >
> >> > > To be honest, I figured I'd plow ahead and then find the
> counter-examples
> >> > > programmatically and decide what to do once I had my pile of edge
> cases.
> >> > >
> >> > > It might involve rewriting docs in some places, but I think the
> usability
> >> > > win is completely worth the hassle.
> >> > >
> >> > > It's possible there might be some rework needed to maximize cogenc=
y
> of the
> >> > > generated docs, but I think prioritizing a user-facing reference
> for QMP is
> >> > > the objectively correct end goal and I'm more than happy to work
> backwards
> >> > > from that desired state.
> >> >
> >> > I'm not disputing the idea that documenting the arguments right with
> the
> >> > command is good.  I'm merely pointing out obstacles to pulling that
> off.
> >> >
> >> > Adjusting existing documentation is only half the battle.  The other
> >> > half is making sure documentation stays adjusted.  We may have to co=
me
> >> > up with new documentation rules, and ways to enforce them.
> >>
> >> For the sake of argument, let's say we forbid everything except
> >> arg/features from definitions destined to be used as base/inherited
> >> types. This would be very easy to enforce at the qapidoc level where
> >> the doc inlining is performed by yelping when the base type contains
> >> additional documentation sections.
> >>
> >> Now, in the real world, maybe sometimes those sections are useful and
> >> we don't want to get rid of them, esp. because they may contain useful
> >> documentation that we don't want to duplicate in the source files.
> >>
> >> My plan is to just forbid them at first and enumerate the cases where
> >> they occur, then decide which ones are better off being moved
> >> elsewhere or explicitly tolerated. The generator's tolerance can be
> >> adjusted accordingly and we can formulate a rule for exactly how doc
> >> blocks are combined and merged. I think it won't be a problem to
> >> enforce it programmatically.
> >>
> >> I'll get back to you on how often and precisely where these cases
> >> occur so you can take a look and see how you feel.
> >>
> >
> > For a warmup, let's look at every unique instance of non-empty
> > paragraph text on an object that is used as a base anywhere:
> >
> > Warning: AudiodevPerDirectionOptions - inlined paragraph
> > Warning: BlockdevOptionsCurlBase - inlined paragraph
> > Warning: BlockdevOptionsGenericCOWFormat - inlined paragraph
> > Warning: BlockdevOptionsGenericFormat - inlined paragraph
> > Warning: BlockExportOptionsNbdBase - inlined paragraph
> > Warning: BlockNodeInfo - inlined paragraph
> > Warning: ChardevCommon - inlined paragraph
> > Warning: CpuInstanceProperties - inlined paragraph
> > Warning: CryptodevBackendProperties - inlined paragraph
> > Warning: EventLoopBaseProperties - inlined paragraph
> > Warning: MemoryBackendProperties - inlined paragraph
> > Warning: NetfilterProperties - inlined paragraph
> > Warning: QCryptoBlockAmendOptionsLUKS - inlined paragraph
> > Warning: QCryptoBlockCreateOptionsLUKS - inlined paragraph
> > Warning: QCryptoBlockInfoBase - inlined paragraph
> > Warning: QCryptoBlockOptionsBase - inlined paragraph
> > Warning: QCryptoBlockOptionsLUKS - inlined paragraph
> > Warning: RngProperties - inlined paragraph
> > Warning: SecretCommonProperties - inlined paragraph
> > Warning: SpiceBasicInfo - inlined paragraph
> > Warning: TlsCredsProperties - inlined paragraph
> > Warning: VncBasicInfo - inlined paragraph
> >
> > There's 22 instances.
> >
> > Let's look at what they say:
> >
> > AudiodevPerDirectionOptions: "General audio backend options that are
> > used for both playback and recording."
> > BlockdevOptionsCurlBase: "Driver specific block device options shared
> > by all protocols supported by the curl backend."
> > BlockdevOptionsGenericCOWFormat: "Driver specific block device options
> > for image format that have no option besides their data source and an
> > optional backing file."
> > BlockdevOptionsGenericFormat: "Driver specific block device options
> > for image format that have no option besides their data source."
> > BlockExportOptionsNbdBase: "An NBD block export (common options shared
> > between nbd-server-add and the NBD branch of block-export-add)."
> > BlockNodeInfo: "Information about a QEMU image file"
> > ChardevCommon: "Configuration shared across all chardev backends"
> >
> > CpuInstanceProperties:
> > "List of properties to be used for hotplugging a CPU instance, it
> > should be passed by management with device_add command when a CPU is
> > being hotplugged.
> >
> > Which members are optional and which mandatory depends on the
> > architecture and board.
> >
> > For s390x see :ref:`cpu-topology-s390x`.
> >
> > The ids other than the node-id specify the position of the CPU
> > within the CPU topology (as defined by the machine property "smp",
> > thus see also type @SMPConfiguration)"
> >
> > CryptodevBackendProperties: "Properties for cryptodev-backend and
> > cryptodev-backend-builtin objects."
> > EventLoopBaseProperties: "Common properties for event loops"
> > MemoryBackendProperties: "Properties for objects of classes derived
> > from memory-backend."
> > NetfilterProperties: "Properties for objects of classes derived from
> netfilter."
> > QCryptoBlockAmendOptionsLUKS: "This struct defines the update
> > parameters that activate/de-activate set of keyslots"
> > QCryptoBlockCreateOptionsLUKS: "The options that apply to LUKS
> > encryption format initialization"
> > QCryptoBlockInfoBase: "The common information that applies to all full
> > disk encryption formats"
> > QCryptoBlockOptionsBase: "The common options that apply to all full
> > disk encryption formats"
> > QCryptoBlockOptionsLUKS: "The options that apply to LUKS encryption
> format"
> > RngProperties: "Properties for objects of classes derived from rng."
> > SecretCommonProperties: "Properties for objects of classes derived
> > from secret-common."
> > SpiceBasicInfo: "The basic information for SPICE network connection"
> > TlsCredsProperties: "Properties for objects of classes derived from
> tls-creds."
> > VncBasicInfo: "The basic information for vnc network connection"
> >
> > ... Alright. So like 98% of the time, it's functionally useless
> > information for the end-user. The only thing that looks mildly
> > interesting is CpuInstanceProperties and *maybe*
> > QCryptoBlockAmendOptionsLUKS.
> >
> > I propose we add a new section to QAPI doc blocks that gets ignored
> > from rendered documentation, like "Comment:" -- to keep any info that
> > might be mildly relevant to a developer that explains the *factoring*
> > of the object, but won't be exposed in user-facing documents.
>
> Two existing ways to add comments that don't go into generated
> documentation:
>
> 1. Write a non-doc comment.
>
>    ##
>    # This is a doc comment.
>    ##
>
>    #
>    # This isn't.
>    #
>
> 2. TODO sections in a doc comment.
>
> Not sure we need more ways, but if we do, we'll create them.
>

Yeah. we could just delete them. Just offering a section in case you don't
want to lose a mandate that every entity should be documented.

I don't have strong feelings beyond "I think we don't need to inline these,
but we should make it obvious when we do or do not."

If you want to just pull out these paragraphs to be comments before/after
the doc block or just delete them, I don't have strong feelings.


> > On the occasion we DO want to inline documentation paragraphs, we can
> > leave them in and have the doc generator inline them. There's probably
> > very few cases where we actually want this.
> >
> > Let's take a look at any tagged sections now, excluding "Since":
> >
> > Warning: BackupCommon - inlined tag section Note
> > Warning: CpuInstanceProperties - inlined, tag section Note
> > Warning: MemoryBackendProperties - inlined tag section Note
> >
> > Not very many! Just three.
> >
> > BackupCommon:
> >
> > Note: @on-source-error and @on-target-error only affect background
> >     I/O.  If an error occurs during a guest write request, the
> >     device's rerror/werror actions will be used.
> >
> > BackupCommon is used as a base for DriveBackup and BlockdevBackup. In
> > this case, this note probably does belong on both. It should be
> > inlined and included.
> >
> > CpuInstanceProperties:
> >
> > Note: management should be prepared to pass through additional
> >     properties with device_add.
> >
> > This is only used as a base with no other addon args for
> > NumaCpuOptions, in turn only used for an argument. This is probably
> > right to pass through, too. (Though I admit I don't really know what
> > it means... we can discuss the doc *quality* another day.)
>
> Oh boy, don't get me started!
>

:)


> > MemoryBackendProperties:
> >
> > Note: prealloc=3Dtrue and reserve=3Dfalse cannot be set at the same
> >     time.  With reserve=3Dtrue, the behavior depends on the operating
> >     system: for example, Linux will not reserve swap space for
> >     shared file mappings -- "not applicable". In contrast,
> >     reserve=3Dfalse will bail out if it cannot be configured
> >     accordingly.
> >
> > This is used in MemoryBackendFileProperties,
> > MemoryBackendMemfdProperties, and MemoryBackendEpcProperties. None are
> > commands. I think the note here should also be inlined into each
> > object.
> >
> > So, I think that:
> >
> > - Most naked paragraphs are usually useless to the end-user, and we
> > should put them behind a Comment section to prevent them from being
> > inlined.
>
> We may want to delete them instead.
>

Sure, yeah. You're the maintainer, so your call.

(1) New comment section
(2) Pulled out as a non-doc-block comment
(3) Just deleted.


> > - Any *other* paragraph or section should be included in the
> > descendent. We'll just review with that eye going forward.
>
> But where exactly does it go?
>

"Into the HTML. Any other questions?"

;)


> The question applies not just to tagged sections such as "Note:", but to
> argument, member, and feature descriptions, too.


> Our current answer for argument / member descriptions is "right after
> the body section".  Works because we permit only the body section before
> argument / member descriptions .  Pretty arbitrary restriction, though.
>
> Fine print: can be a bit more complicated for unions, but let's ignore
> that here.
>
> I guess our current answer for feature descriptions is something like
> "right after argument / member descriptions if they exist, else right
> after the body section".
>
> What could our answer be for other sections?
>

Inherited members: Injected *before* the member section *when already
present*. i.e., members are source order, ancestor-to-descendent.

Features are the same. The system does not care if they are duplicated.

The only ambiguity arises when the final descendent does not *have* member
or feature sections.

Current prototype's hack: if we leave the doc sections and members/features
remain undocumented, they are appended to the end of the block.

I do agree this isn't ideal. We had a call off-list earlier today where you
suggested the idea of a section or token that would mark the location for
such things to be inlined in the event that there was no obvious place
otherwise. I don't have a better idea; and it would make this action
explicit rather than implicit. It would only be needed in very few doc
blocks and it would be possible to write a very, very detailed error
message in the circumstances where this was missed.

i.e. a simple section that's just simply:

Inherited-Members: ...

or

Inherited-Features: ...

would do perfectly well.

Example error message: 'QAPI definition foo has inherited
<features/members> [from QAPI <meta-type> bar] but no local
<features/members> section in its documentation block. Please annotate
where they should be included in generated documentation by including the
line "Inherited-<Features/Members>: ..." in the doc block.'

(With a pointer to the source file and line where the doc block starts.)

If this line is erroneously *included* in a doc block that doesn't need it,
we can also emit a (fatal) warning urging its removal and an auditing of
the rendered HTML output.

That leaves other sections. We also spoke about the possibility of
eliminating "notes" and "examples" in exchange for explicit ReST/sphinx
syntax. I think that's probably a good idea overall, because it increases
flexibility in how we can annotate examples and remove more custom qapidoc
parsing code.

So, let's assume the only thing left would be "where do we inline inherited
paragraphs?"

How about this:

If we inherit from an object that *has* such paragraphs, then the
descendent needs to mark the spot for its inclusion.

Copying from the above ideas for members/features, how about:

Inherited-paragraphs: ...

The docgen uses this as the splice point. If the splice point is absent and
there are no paragraphs to splice in, there's no problem. If there are, we
can emit a very detailed warning that explains exactly what went wrong and
how to fix it. Similarly, if the splice point is indicated but absent, we
can warn and urge its removal alongside an audit of the generated
documentation.

This way, the feature is self-documenting and self-correcting. It will
catch regressions written before the feature existed and give guidance on
how to fix it. It will catch the large majority of rebase and refactoring
mistakes.

It adds a little complexity to the QAPIDoc parser, but not very much.

(And in fact, with the removal of Notes and Examples, it may indeed be
possible to refactor the parser to be drastically simpler. Alongside using
all_sections, once qapidoc.py is rewritten/replaced, even more drastic
simplifications are possible.)


> In my experience, the people writing the doc comments rarely check how
> they come out in generated documentation.
>
> The closer the doc comments are to the generated documentation, the
> higher the chance it comes out as intended.
>
> The more complex the inlining gets, the higher the chance of mishaps.
>
> If cases of complex inlining are rare, we could sidestep complex
> inlining by inlining manually.
>
> If that's undesirable or impractical, we could require explicit
> instructions where the inlined material should go.
>
> I'm merely thinking aloud; these are certainly not requests, just ideas,
> and possibly bad ones.
>
> > - Since: ... we'll talk about later this week.
>
> Yes.
>

Also discussed on call, but I'm leaving this alone for right now.

Current prototype: inherited "since" sections are ignored but emit a
non-fatal warning. We can audit these cases and decide if that's an
acceptable shortcoming while we work on something more robust, or if it
needs addressing before merge.

(Or if we just issue manual source corrections in the interim before your
proposed changes to generate such info are merged.)

OK.

So: I quite like the idea of inherited placeholders if and only if they are
required, and would like to proceed with prototyping this mechanism. Are
you OK with me proceeding to prototype this?

(It's okay to have reservations and we may still change our mind, but I
want a tentative ACK before I embark on this as it is categorically more
disruptive than any of the changes I've made thus far. i.e. does it
*conceptually* work for you?)

--js

--000000000000a52ecc0616c7c7cc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, Apr 23, 2024, 3:48=E2=80=AFAM Markus Armbruste=
r &lt;<a href=3D"mailto:armbru@redhat.com" target=3D"_blank" rel=3D"norefer=
rer">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" rel=3D"noreferrer nore=
ferrer" target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; On Mon, Apr 22, 2024 at 12:38=E2=80=AFPM John Snow &lt;<a href=3D"mail=
to:jsnow@redhat.com" rel=3D"noreferrer noreferrer" target=3D"_blank">jsnow@=
redhat.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Mon, Apr 22, 2024 at 5:20=E2=80=AFAM Markus Armbruster &lt;<a h=
ref=3D"mailto:armbru@redhat.com" rel=3D"noreferrer noreferrer" target=3D"_b=
lank">armbru@redhat.com</a>&gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" rel=3D"nore=
ferrer noreferrer" target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; &gt; On Fri, Apr 19, 2024, 10:45=E2=80=AFAM Markus Armbruster=
 &lt;<a href=3D"mailto:armbru@redhat.com" rel=3D"noreferrer noreferrer" tar=
get=3D"_blank">armbru@redhat.com</a>&gt; wrote:<br>
&gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt;&gt; John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" re=
l=3D"noreferrer noreferrer" target=3D"_blank">jsnow@redhat.com</a>&gt; writ=
es:<br>
&gt;&gt; &gt; &gt;&gt;<br>
&gt;&gt; &gt; &gt;&gt; &gt; This series adds a new qapi-domain extension fo=
r Sphinx, which adds a<br>
&gt;&gt; &gt; &gt;&gt; &gt; series of custom directives for documenting QAP=
I definitions.<br>
<br>
[...]<br>
<br>
&gt;&gt; &gt; &gt;&gt; &gt; Known issues / points of interest:<br>
<br>
[...]<br>
<br>
&gt;&gt; &gt; &gt;&gt; &gt; - Inlining all members means there is some ambi=
guity on what to do with<br>
&gt;&gt; &gt; &gt;&gt; &gt;=C2=A0 =C2=A0doc block sections on inlined entit=
ies; features and members have an<br>
&gt;&gt; &gt; &gt;&gt; &gt;=C2=A0 =C2=A0obvious home - body, since, and mis=
c sections are not as obvious on<br>
&gt;&gt; &gt; &gt;&gt; &gt;=C2=A0 =C2=A0how to handle. This will feature mo=
re prominently in the generator<br>
&gt;&gt; &gt; &gt;&gt; &gt;=C2=A0 =C2=A0series.<br>
&gt;&gt; &gt; &gt;&gt;<br>
&gt;&gt; &gt; &gt;&gt; Yes, this is a real problem.<br>
&gt;&gt; &gt; &gt;&gt;<br>
&gt;&gt; &gt; &gt;&gt; The member documentation gets written in the context=
 of the type.=C2=A0 It<br>
&gt;&gt; &gt; &gt;&gt; may make sense only in that context.=C2=A0 Inlining =
copies it into a<br>
&gt;&gt; &gt; &gt;&gt; different context.<br>
&gt;&gt; &gt; &gt;&gt;<br>
&gt;&gt; &gt; &gt;&gt; Features may need to combine.=C2=A0 Say a command&#3=
9;s arguments are a union<br>
&gt;&gt; &gt; &gt;&gt; type, and several branches of the union both contain=
 deprecated members.<br>
&gt;&gt; &gt; &gt;&gt; These branch types all document feature @deprecated.=
=C2=A0 Simply inlining<br>
&gt;&gt; &gt; &gt;&gt; their feature documentation results in feature @depr=
ecated documented<br>
&gt;&gt; &gt; &gt;&gt; several times.=C2=A0 Ugh.=C2=A0 Combining them would=
 be better.=C2=A0 But how?=C2=A0 Do we<br>
&gt;&gt; &gt; &gt;&gt; need to rethink how we document features?<br>
&gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt; To be honest, I figured I&#39;d plow ahead and then find=
 the counter-examples<br>
&gt;&gt; &gt; &gt; programmatically and decide what to do once I had my pil=
e of edge cases.<br>
&gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt; It might involve rewriting docs in some places, but I th=
ink the usability<br>
&gt;&gt; &gt; &gt; win is completely worth the hassle.<br>
&gt;&gt; &gt; &gt;<br>
&gt;&gt; &gt; &gt; It&#39;s possible there might be some rework needed to m=
aximize cogency of the<br>
&gt;&gt; &gt; &gt; generated docs, but I think prioritizing a user-facing r=
eference for QMP is<br>
&gt;&gt; &gt; &gt; the objectively correct end goal and I&#39;m more than h=
appy to work backwards<br>
&gt;&gt; &gt; &gt; from that desired state.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I&#39;m not disputing the idea that documenting the arguments=
 right with the<br>
&gt;&gt; &gt; command is good.=C2=A0 I&#39;m merely pointing out obstacles =
to pulling that off.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Adjusting existing documentation is only half the battle.=C2=
=A0 The other<br>
&gt;&gt; &gt; half is making sure documentation stays adjusted.=C2=A0 We ma=
y have to come<br>
&gt;&gt; &gt; up with new documentation rules, and ways to enforce them.<br=
>
&gt;&gt;<br>
&gt;&gt; For the sake of argument, let&#39;s say we forbid everything excep=
t<br>
&gt;&gt; arg/features from definitions destined to be used as base/inherite=
d<br>
&gt;&gt; types. This would be very easy to enforce at the qapidoc level whe=
re<br>
&gt;&gt; the doc inlining is performed by yelping when the base type contai=
ns<br>
&gt;&gt; additional documentation sections.<br>
&gt;&gt;<br>
&gt;&gt; Now, in the real world, maybe sometimes those sections are useful =
and<br>
&gt;&gt; we don&#39;t want to get rid of them, esp. because they may contai=
n useful<br>
&gt;&gt; documentation that we don&#39;t want to duplicate in the source fi=
les.<br>
&gt;&gt;<br>
&gt;&gt; My plan is to just forbid them at first and enumerate the cases wh=
ere<br>
&gt;&gt; they occur, then decide which ones are better off being moved<br>
&gt;&gt; elsewhere or explicitly tolerated. The generator&#39;s tolerance c=
an be<br>
&gt;&gt; adjusted accordingly and we can formulate a rule for exactly how d=
oc<br>
&gt;&gt; blocks are combined and merged. I think it won&#39;t be a problem =
to<br>
&gt;&gt; enforce it programmatically.<br>
&gt;&gt;<br>
&gt;&gt; I&#39;ll get back to you on how often and precisely where these ca=
ses<br>
&gt;&gt; occur so you can take a look and see how you feel.<br>
&gt;&gt;<br>
&gt;<br>
&gt; For a warmup, let&#39;s look at every unique instance of non-empty<br>
&gt; paragraph text on an object that is used as a base anywhere:<br>
&gt;<br>
&gt; Warning: AudiodevPerDirectionOptions - inlined paragraph<br>
&gt; Warning: BlockdevOptionsCurlBase - inlined paragraph<br>
&gt; Warning: BlockdevOptionsGenericCOWFormat - inlined paragraph<br>
&gt; Warning: BlockdevOptionsGenericFormat - inlined paragraph<br>
&gt; Warning: BlockExportOptionsNbdBase - inlined paragraph<br>
&gt; Warning: BlockNodeInfo - inlined paragraph<br>
&gt; Warning: ChardevCommon - inlined paragraph<br>
&gt; Warning: CpuInstanceProperties - inlined paragraph<br>
&gt; Warning: CryptodevBackendProperties - inlined paragraph<br>
&gt; Warning: EventLoopBaseProperties - inlined paragraph<br>
&gt; Warning: MemoryBackendProperties - inlined paragraph<br>
&gt; Warning: NetfilterProperties - inlined paragraph<br>
&gt; Warning: QCryptoBlockAmendOptionsLUKS - inlined paragraph<br>
&gt; Warning: QCryptoBlockCreateOptionsLUKS - inlined paragraph<br>
&gt; Warning: QCryptoBlockInfoBase - inlined paragraph<br>
&gt; Warning: QCryptoBlockOptionsBase - inlined paragraph<br>
&gt; Warning: QCryptoBlockOptionsLUKS - inlined paragraph<br>
&gt; Warning: RngProperties - inlined paragraph<br>
&gt; Warning: SecretCommonProperties - inlined paragraph<br>
&gt; Warning: SpiceBasicInfo - inlined paragraph<br>
&gt; Warning: TlsCredsProperties - inlined paragraph<br>
&gt; Warning: VncBasicInfo - inlined paragraph<br>
&gt;<br>
&gt; There&#39;s 22 instances.<br>
&gt;<br>
&gt; Let&#39;s look at what they say:<br>
&gt;<br>
&gt; AudiodevPerDirectionOptions: &quot;General audio backend options that =
are<br>
&gt; used for both playback and recording.&quot;<br>
&gt; BlockdevOptionsCurlBase: &quot;Driver specific block device options sh=
ared<br>
&gt; by all protocols supported by the curl backend.&quot;<br>
&gt; BlockdevOptionsGenericCOWFormat: &quot;Driver specific block device op=
tions<br>
&gt; for image format that have no option besides their data source and an<=
br>
&gt; optional backing file.&quot;<br>
&gt; BlockdevOptionsGenericFormat: &quot;Driver specific block device optio=
ns<br>
&gt; for image format that have no option besides their data source.&quot;<=
br>
&gt; BlockExportOptionsNbdBase: &quot;An NBD block export (common options s=
hared<br>
&gt; between nbd-server-add and the NBD branch of block-export-add).&quot;<=
br>
&gt; BlockNodeInfo: &quot;Information about a QEMU image file&quot;<br>
&gt; ChardevCommon: &quot;Configuration shared across all chardev backends&=
quot;<br>
&gt;<br>
&gt; CpuInstanceProperties:<br>
&gt; &quot;List of properties to be used for hotplugging a CPU instance, it=
<br>
&gt; should be passed by management with device_add command when a CPU is<b=
r>
&gt; being hotplugged.<br>
&gt;<br>
&gt; Which members are optional and which mandatory depends on the<br>
&gt; architecture and board.<br>
&gt;<br>
&gt; For s390x see :ref:`cpu-topology-s390x`.<br>
&gt;<br>
&gt; The ids other than the node-id specify the position of the CPU<br>
&gt; within the CPU topology (as defined by the machine property &quot;smp&=
quot;,<br>
&gt; thus see also type @SMPConfiguration)&quot;<br>
&gt;<br>
&gt; CryptodevBackendProperties: &quot;Properties for cryptodev-backend and=
<br>
&gt; cryptodev-backend-builtin objects.&quot;<br>
&gt; EventLoopBaseProperties: &quot;Common properties for event loops&quot;=
<br>
&gt; MemoryBackendProperties: &quot;Properties for objects of classes deriv=
ed<br>
&gt; from memory-backend.&quot;<br>
&gt; NetfilterProperties: &quot;Properties for objects of classes derived f=
rom netfilter.&quot;<br>
&gt; QCryptoBlockAmendOptionsLUKS: &quot;This struct defines the update<br>
&gt; parameters that activate/de-activate set of keyslots&quot;<br>
&gt; QCryptoBlockCreateOptionsLUKS: &quot;The options that apply to LUKS<br=
>
&gt; encryption format initialization&quot;<br>
&gt; QCryptoBlockInfoBase: &quot;The common information that applies to all=
 full<br>
&gt; disk encryption formats&quot;<br>
&gt; QCryptoBlockOptionsBase: &quot;The common options that apply to all fu=
ll<br>
&gt; disk encryption formats&quot;<br>
&gt; QCryptoBlockOptionsLUKS: &quot;The options that apply to LUKS encrypti=
on format&quot;<br>
&gt; RngProperties: &quot;Properties for objects of classes derived from rn=
g.&quot;<br>
&gt; SecretCommonProperties: &quot;Properties for objects of classes derive=
d<br>
&gt; from secret-common.&quot;<br>
&gt; SpiceBasicInfo: &quot;The basic information for SPICE network connecti=
on&quot;<br>
&gt; TlsCredsProperties: &quot;Properties for objects of classes derived fr=
om tls-creds.&quot;<br>
&gt; VncBasicInfo: &quot;The basic information for vnc network connection&q=
uot;<br>
&gt;<br>
&gt; ... Alright. So like 98% of the time, it&#39;s functionally useless<br=
>
&gt; information for the end-user. The only thing that looks mildly<br>
&gt; interesting is CpuInstanceProperties and *maybe*<br>
&gt; QCryptoBlockAmendOptionsLUKS.<br>
&gt;<br>
&gt; I propose we add a new section to QAPI doc blocks that gets ignored<br=
>
&gt; from rendered documentation, like &quot;Comment:&quot; -- to keep any =
info that<br>
&gt; might be mildly relevant to a developer that explains the *factoring*<=
br>
&gt; of the object, but won&#39;t be exposed in user-facing documents.<br>
<br>
Two existing ways to add comments that don&#39;t go into generated<br>
documentation:<br>
<br>
1. Write a non-doc comment.<br>
<br>
=C2=A0 =C2=A0##<br>
=C2=A0 =C2=A0# This is a doc comment.<br>
=C2=A0 =C2=A0##<br>
<br>
=C2=A0 =C2=A0#<br>
=C2=A0 =C2=A0# This isn&#39;t.<br>
=C2=A0 =C2=A0#<br>
<br>
2. TODO sections in a doc comment.<br>
<br>
Not sure we need more ways, but if we do, we&#39;ll create them.<br></block=
quote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yeah. we co=
uld just delete them. Just offering a section in case you don&#39;t want to=
 lose a mandate that every entity should be documented.</div><div dir=3D"au=
to"><br></div><div dir=3D"auto">I don&#39;t have strong feelings beyond &qu=
ot;I think we don&#39;t need to inline these, but we should make it obvious=
 when we do or do not.&quot;</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">If you want to just pull out these paragraphs to be comments before/af=
ter the doc block or just delete them, I don&#39;t have strong feelings.</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">
<br>
&gt; On the occasion we DO want to inline documentation paragraphs, we can<=
br>
&gt; leave them in and have the doc generator inline them. There&#39;s prob=
ably<br>
&gt; very few cases where we actually want this.<br>
&gt;<br>
&gt; Let&#39;s take a look at any tagged sections now, excluding &quot;Sinc=
e&quot;:<br>
&gt;<br>
&gt; Warning: BackupCommon - inlined tag section Note<br>
&gt; Warning: CpuInstanceProperties - inlined, tag section Note<br>
&gt; Warning: MemoryBackendProperties - inlined tag section Note<br>
&gt;<br>
&gt; Not very many! Just three.<br>
&gt;<br>
&gt; BackupCommon:<br>
&gt;<br>
&gt; Note: @on-source-error and @on-target-error only affect background<br>
&gt;=C2=A0 =C2=A0 =C2=A0I/O.=C2=A0 If an error occurs during a guest write =
request, the<br>
&gt;=C2=A0 =C2=A0 =C2=A0device&#39;s rerror/werror actions will be used.<br=
>
&gt;<br>
&gt; BackupCommon is used as a base for DriveBackup and BlockdevBackup. In<=
br>
&gt; this case, this note probably does belong on both. It should be<br>
&gt; inlined and included.<br>
&gt;<br>
&gt; CpuInstanceProperties:<br>
&gt;<br>
&gt; Note: management should be prepared to pass through additional<br>
&gt;=C2=A0 =C2=A0 =C2=A0properties with device_add.<br>
&gt;<br>
&gt; This is only used as a base with no other addon args for<br>
&gt; NumaCpuOptions, in turn only used for an argument. This is probably<br=
>
&gt; right to pass through, too. (Though I admit I don&#39;t really know wh=
at<br>
&gt; it means... we can discuss the doc *quality* another day.)<br>
<br>
Oh boy, don&#39;t get me started!<br></blockquote></div></div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">:)</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; MemoryBackendProperties:<br>
&gt;<br>
&gt; Note: prealloc=3Dtrue and reserve=3Dfalse cannot be set at the same<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0time.=C2=A0 With reserve=3Dtrue, the behavior depen=
ds on the operating<br>
&gt;=C2=A0 =C2=A0 =C2=A0system: for example, Linux will not reserve swap sp=
ace for<br>
&gt;=C2=A0 =C2=A0 =C2=A0shared file mappings -- &quot;not applicable&quot;.=
 In contrast,<br>
&gt;=C2=A0 =C2=A0 =C2=A0reserve=3Dfalse will bail out if it cannot be confi=
gured<br>
&gt;=C2=A0 =C2=A0 =C2=A0accordingly.<br>
&gt;<br>
&gt; This is used in MemoryBackendFileProperties,<br>
&gt; MemoryBackendMemfdProperties, and MemoryBackendEpcProperties. None are=
<br>
&gt; commands. I think the note here should also be inlined into each<br>
&gt; object.<br>
&gt;<br>
&gt; So, I think that:<br>
&gt;<br>
&gt; - Most naked paragraphs are usually useless to the end-user, and we<br=
>
&gt; should put them behind a Comment section to prevent them from being<br=
>
&gt; inlined.<br>
<br>
We may want to delete them instead.<br></blockquote></div></div><div dir=3D=
"auto"><br></div><div dir=3D"auto">Sure, yeah. You&#39;re the maintainer, s=
o your call.</div><div dir=3D"auto"><br></div><div dir=3D"auto">(1) New com=
ment section</div><div dir=3D"auto">(2) Pulled out as a non-doc-block comme=
nt</div><div dir=3D"auto">(3) Just deleted.</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
<br>
&gt; - Any *other* paragraph or section should be included in the<br>
&gt; descendent. We&#39;ll just review with that eye going forward.<br>
<br>
But where exactly does it go?<br></blockquote></div></div><div dir=3D"auto"=
><br></div><div dir=3D"auto">&quot;Into the HTML. Any other questions?&quot=
;</div><div dir=3D"auto"><br></div><div dir=3D"auto">;)</div><div dir=3D"au=
to"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">
<br>
The question applies not just to tagged sections such as &quot;Note:&quot;,=
 but to<br>
argument, member, and feature descriptions, too.</blockquote></div></div><d=
iv dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Our current answer for argument / member descriptions is &quot;right after<=
br>
the body section&quot;.=C2=A0 Works because we permit only the body section=
 before<br>
argument / member descriptions .=C2=A0 Pretty arbitrary restriction, though=
.<br>
<br>
Fine print: can be a bit more complicated for unions, but let&#39;s ignore<=
br>
that here.<br>
<br>
I guess our current answer for feature descriptions is something like<br>
&quot;right after argument / member descriptions if they exist, else right<=
br>
after the body section&quot;.<br>
<br>
What could our answer be for other sections?<br></blockquote></div></div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">Inherited members: Injected *be=
fore* the member section *when already present*. i.e., members are source o=
rder, ancestor-to-descendent.</div><div dir=3D"auto"><br></div><div dir=3D"=
auto">Features are the same. The system does not care if they are duplicate=
d.</div><div dir=3D"auto"><br></div><div dir=3D"auto">The only ambiguity ar=
ises when the final descendent does not *have* member or feature sections.<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">Current prototype&#39;s =
hack: if we leave the doc sections and members/features remain undocumented=
, they are appended to the end of the block.</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">I do agree this isn&#39;t ideal. We had a call off-lis=
t earlier today where you suggested the idea of a section or token that wou=
ld mark the location for such things to be inlined in the event that there =
was no obvious place otherwise. I don&#39;t have a better idea; and it woul=
d make this action explicit rather than implicit. It would only be needed i=
n very few doc blocks and it would be possible to write a very, very detail=
ed error message in the circumstances where this was missed.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">i.e. a simple section that&#39;s just=
 simply:</div><div dir=3D"auto"><br></div><div dir=3D"auto">Inherited-Membe=
rs: ...</div><div dir=3D"auto"><br></div><div dir=3D"auto">or</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Inherited-Features: ...</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">would do perfectly well.</div><div di=
r=3D"auto"><br></div><div dir=3D"auto">Example error message: &#39;QAPI def=
inition foo has inherited &lt;features/members&gt; [from QAPI &lt;meta-type=
&gt; bar] but no local &lt;features/members&gt; section in its documentatio=
n block. Please annotate where they should be included in generated documen=
tation by including the line &quot;Inherited-&lt;Features/Members&gt;: ...&=
quot; in the doc block.&#39;</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">(With a pointer to the source file and line where the doc block starts=
.)</div><div dir=3D"auto"><br></div><div dir=3D"auto">If this line is erron=
eously *included* in a doc block that doesn&#39;t need it, we can also emit=
 a (fatal) warning urging its removal and an auditing of the rendered HTML =
output.</div><div dir=3D"auto"><br></div><div dir=3D"auto">That leaves othe=
r sections. We also spoke about the possibility of eliminating &quot;notes&=
quot; and &quot;examples&quot; in exchange for explicit ReST/sphinx syntax.=
 I think that&#39;s probably a good idea overall, because it increases flex=
ibility in how we can annotate examples and remove more custom qapidoc pars=
ing code.</div><div dir=3D"auto"><br></div><div dir=3D"auto">So, let&#39;s =
assume the only thing left would be &quot;where do we inline inherited para=
graphs?&quot;</div><div dir=3D"auto"><br></div><div dir=3D"auto">How about =
this:</div><div dir=3D"auto"><br></div><div dir=3D"auto">If we inherit from=
 an object that *has* such paragraphs, then the descendent needs to mark th=
e spot for its inclusion.</div><div dir=3D"auto"><br></div><div dir=3D"auto=
">Copying from the above ideas for members/features, how about:</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto">Inherited-paragraphs: ...</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">The docgen uses this as the splic=
e point. If the splice point is absent and there are no paragraphs to splic=
e in, there&#39;s no problem. If there are, we can emit a very detailed war=
ning that explains exactly what went wrong and how to fix it. Similarly, if=
 the splice point is indicated but absent, we can warn and urge its removal=
 alongside an audit of the generated documentation.</div><div dir=3D"auto">=
<br></div><div dir=3D"auto">This way, the feature is self-documenting and s=
elf-correcting. It will catch regressions written before the feature existe=
d and give guidance on how to fix it. It will catch the large majority of r=
ebase and refactoring mistakes.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">It adds a little complexity to the QAPIDoc parser, but not very m=
uch.</div><div dir=3D"auto"><br></div><div dir=3D"auto">(And in fact, with =
the removal of Notes and Examples, it may indeed be possible to refactor th=
e parser to be drastically simpler. Alongside using all_sections, once qapi=
doc.py is rewritten/replaced, even more drastic simplifications are possibl=
e.)</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_=
quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">
<br>
In my experience, the people writing the doc comments rarely check how<br>
they come out in generated documentation.<br>
<br>
The closer the doc comments are to the generated documentation, the<br>
higher the chance it comes out as intended.<br>
<br>
The more complex the inlining gets, the higher the chance of mishaps.<br>
<br>
If cases of complex inlining are rare, we could sidestep complex<br>
inlining by inlining manually.<br>
<br>
If that&#39;s undesirable or impractical, we could require explicit<br>
instructions where the inlined material should go.<br>
<br>
I&#39;m merely thinking aloud; these are certainly not requests, just ideas=
,<br>
and possibly bad ones.<br>
<br>
&gt; - Since: ... we&#39;ll talk about later this week.<br>
<br>
Yes.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"au=
to">Also discussed on call, but I&#39;m leaving this alone for right now.</=
div><div dir=3D"auto"><br></div><div dir=3D"auto">Current prototype: inheri=
ted &quot;since&quot; sections are ignored but emit a non-fatal warning. We=
 can audit these cases and decide if that&#39;s an acceptable shortcoming w=
hile we work on something more robust, or if it needs addressing before mer=
ge.</div><div dir=3D"auto"><br></div><div dir=3D"auto">(Or if we just issue=
 manual source corrections in the interim before your proposed changes to g=
enerate such info are merged.)</div><div dir=3D"auto"><br></div><div dir=3D=
"auto">OK.</div><div dir=3D"auto"><br></div><div dir=3D"auto">So: I quite l=
ike the idea of inherited placeholders if and only if they are required, an=
d would like to proceed with prototyping this mechanism. Are you OK with me=
 proceeding to prototype this?</div><div dir=3D"auto"><br></div><div dir=3D=
"auto">(It&#39;s okay to have reservations and we may still change our mind=
, but I want a tentative ACK before I embark on this as it is categorically=
 more disruptive than any of the changes I&#39;ve made thus far. i.e. does =
it *conceptually* work for you?)</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">--js</div></div>

--000000000000a52ecc0616c7c7cc--


