Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3DDE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 07:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW9Wb-00072y-KT; Fri, 10 Jan 2025 02:33:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tW9WY-00072k-J6
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 02:33:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tW9WU-0002kI-MW
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 02:33:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736494416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZkWXwOBpPj4qDkXhNKrv6QbMZS/qmViJVPz4ah/zlPo=;
 b=KwrB+1iZF+qiXlRm00Mv0eTUKjhRXVr6zHMGtqan54WbVJH1SkQ5dtAVcUd9pRVhgZMGq+
 A9xPAzZ8LTXWGLeXHv/4UWG9NaH2NlUfmJTFbxROvv2dKUqnkNJO2rJdAMrBztj98joa6W
 E/tjrB335FATMWZ/GSIdKN9ZGdjVtOM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-aBA4PTQbP4aS2tLMzLa44Q-1; Fri,
 10 Jan 2025 02:33:34 -0500
X-MC-Unique: aBA4PTQbP4aS2tLMzLa44Q-1
X-Mimecast-MFC-AGG-ID: aBA4PTQbP4aS2tLMzLa44Q
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE7F81956051; Fri, 10 Jan 2025 07:33:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.101])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3983819560AB; Fri, 10 Jan 2025 07:33:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4BB0B21E6924; Fri, 10 Jan 2025 08:33:29 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 04/23] qapi: expand tags to all doc sections
In-Reply-To: <CAFn=p-b51afQQDo7qd_T5EPyunuxGY-N8hjzbim5894JGwTEjA@mail.gmail.com>
 (John Snow's message of "Thu, 9 Jan 2025 13:49:13 -0500")
References: <20241213021827.2956769-1-jsnow@redhat.com>
 <20241213021827.2956769-5-jsnow@redhat.com>
 <87ldwa4hwj.fsf@pond.sub.org>
 <CAFn=p-b51afQQDo7qd_T5EPyunuxGY-N8hjzbim5894JGwTEjA@mail.gmail.com>
Date: Fri, 10 Jan 2025 08:33:29 +0100
Message-ID: <87a5bz6s3a.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

John Snow <jsnow@redhat.com> writes:

> On Fri, Dec 20, 2024, 8:13=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > This patch adds an explicit section tag to all QAPIDoc
>> > sections. Members/Features are now explicitly tagged as such, with the
>> > name now being stored in a dedicated "name" field (which qapidoc.py was
>> > not actually using anyway.)
>> >
>> > WIP: Yeah, the difference between "tagged" and "untagged" sections is
>> > now pretty poorly named, and explicitly giving "untagged" sections an
>> > "UNTAGGED" tag is ... well, worse. but mechanically, this accomplishes
>> > what I need for the series.
>> >
>> > Please suggest better naming conventions, keeping in mind that I
>> > currently have plans for a future patch that splits the "UNTAGGED" tag
>> > into "INTRO" and "DETAILS" tags. But, we still need a meta-name for the
>> > category of sections that are "formerly known as untagged" but cannot =
be
>> > called "freeform" because that name is used for the category of
>> > docblocks that are not attached to an entity (but happens to be
>> > comprised entirely of "formerly known as untagged" sections.)
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>>
>> A free-form doc comment consists of just one untagged section, actually.
>> I don't remember whether anything relies on "just one".
>>
>
> Sure, yes. Sorry, I keep thinking of documentation as containing "any
> number of sections" but keep eliding the fact that our parser
> implementation currently will never actually create multiple adjacent
> "untagged" sections.

Yes, the parsers grows an untagged section until another section starts.
An untagged section can consist of multiple paragraphs, just like tagged
sections.

> I don't even change this anywhere even in my offline WIP, so it's just me
> being over-general.
>
> (I don't think it winds up being relevant or mattering to anything in this
> series or my larger project beyond some word choices.)
>
>> The term "tagged" is rooted in doc comment syntax.
>> docs/devel/qapi-code-gen.rst section "Definition documentation":
>>
>>     Definition documentation starts with a line naming the definition,
>>     followed by an optional overview, a description of each argument (for
>>     commands and events), member (for structs and unions), branch (for
>>     alternates), or value (for enums), a description of each feature (if
>>     any), and finally optional tagged sections.
>>
>> Sadly, this isn't fully accurate anymore.
>>
>>     Descriptions start with '\@name:'.  The description text must be
>>     indented [...]
>>
>>     A tagged section begins with a paragraph that starts with one of the
>>     following words: "Since:", "Returns:", "Errors:", "TODO:".  It ends
>> with
>>     the start of a new section.
>>
>>     The second and subsequent lines of tagged sections must be indented
>>     [...]
>>
>> Nothing about untagged sections.  These are sections that aren't
>> descriptions or tagged.  Example:
>>
>>     # @Returns: Lorem ipsum dolor sit amet, consectetur adipiscing elit,
>>     #     sed do eiusmod tempor incididunt ut labore et dolore magna
>>     #     aliqua.
>>     #
>>     # Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris
>>     # nisi ut aliquip ex ea commodo consequat.
>>     #
>>     # Duis aute irure dolor in reprehenderit in voluptate velit esse
>>     # cillum dolore eu fugiat nulla pariatur.
>>     ##
>>
>> Here, the tagged "Returns" section ends after "aliqua."  Why?  Because
>> "Ut enim" isn't indented.  The untagged section ends after "pariatur."
>>
>> We parse a definition doc comment as a sequence of sections.
>>
>> The first one is the overview.
>>
>> Member / argument descriptions, if any, are next.
>>
>> Then we may have any number of tagged or untagged sections.  If I
>> remember correctly, you'd like to banish them.  Let's pretend they can't
>> exist here.
>>
>
> I think you're referring to my desire to banish "untagged" sections from
> appearing *between* "tagged" sections.

Editing accident, sorry!  You interpreted it correctly.

>                                        Yes, that's still a desire; though=
 I
> make no movement on it in this series as sent to list, and this change is
> entirely unrelated to that desire.
>
> (It's more related to being able to distinguish features from members, and
> later, distinguishing intro/details. This patch still serves a purpose ev=
en
> without the inliner or the complexities it brings, but serves both needs.)
>
> ((Reminder: the reason for this desire is because "tagged sections" are
> rendered in html as a two-column list, and free paragraphs appearing
> between list entries looks bad in the rendered documentation, because it
> means ending the table, starting paragraph(s), then starting a new table.
> If free text is meant to be associated with a specific
> member/feature/section-group, it should be marked up (in SOME way) so that
> the renderer can achieve that grouping visually.
>
> (There will be a standalone patch that implements this restriction and we
> can debate this there, I'm only giving you context here.)))
>
>
>> Then we may have a "Features:" line followed by feature descriptions.
>>
>> Finally, we may have any number of tagged or untagged sections.
>>
>> Each of these sections is represented as an instance of type Section,
>> and the entire definition doc as an instance of type QAPIDoc.
>>
>> Section has a member @tag of type str.
>>
>> For tagged sections, it's the tag, i.e "Since", "Returns", ...  Obvious
>> enough.
>>
>> For overview and other untagged sections, it's None.  Still obvious.
>>
>> For descriptions, it's the name of the thing being described.  Less than
>> obvious.  Note that descriptions are actually instances of ArgSection, a
>> subtype of Section, which prevents confusion with tagged sections.
>>
>
> Note that this patch changes this as well; it becomes "member" or "featur=
e"
> as appropriate and the name is moved into a dedicated name field that
> belongs to the ArgSection class.
>
> (Turns out legacy qapidoc doesn't use this stored name at all anyway, it
> fetches the name via the linked feature/member instead.)
>
>
>> QAPIDoc has the overview in member @body, member / argument descriptions
>> in @args, feature descriptions in @features, and the remaining sections
>> in @sections.
>>
>> I'm in favor of cleaning this up some.
>>
>> I think we can keep the Section name.
>>
>> Moving the name of the thing being described from @tag to @name is good.
>> What value to put into @tag then?  Whatever suits you.
>>
>
> What suits me is "member" and "feature". :)

Okay.

Doesn't entirely clean up the terminology mess.  According to
docs/devel/qapi-code-gen.rst, struct and union types have members,
alternate types have alternatives, enum types have values, commands have
arguments, and events have event-specific data, which is a mouthful, so
we often say arguments.  Using one of them ("member") to refer to the
generalization of them all is suboptimal, but it's no worse than before.

ArgSection is even more general: it's features, too.  Again, no worse
than before.

I'm *not* asking you to clean this up.  I'm just pointing out we could
use fresh naming ideas here.

>> Perhaps we should rename @tag to avoid undue ties to tagged sections.
>> @kind would work for me.
>>
>
> Sold!
>
>
>> Value None for untagged sections is fine with me.  If a string suits you
>> better, that's fine, too.  "untagged", "plain", I don't know, propose
>> something.
>>
>
> For static typing reasons, an explicit tag is preferred to distinguish fr=
om
> it being "optional".
>
> I could cope with any of:
>
> "plain",
> "text",
> "plaintext",
> "paragraphs",
> "unstructured",
> "free"
>
> ... keeping in mind that I do intend to "split" this tag/kind into "intro"
> and "details" later. i.e. this is a temporary tag/kind label.
>
> I think I like "text" the most because it says the least. What about you?

Point, but the other kinds of section are text, too.  "plain"?

>> @body, @args, and so forth aren't exactly great names.  If they truly
>> annoy or confuse you, feel free to propose better ones.
>>
>
> I believe they can be removed entirely once the old qapidoc is sunset,
> leaving only .sections[] behind.
>
> This removes the temptation to pick out sections "out of order".

I've long wanted strict in-order processing, to avoid surprising
reordering of input in the output.

> We only need the list of sections in their source order to generate the
> appropriate rST.
>
> (Note: the inliner actually does need to filter sections somewhat to do i=
ts
> inlining magic, but we'll talk about that later. All you need to know rig=
ht
> now is that my WIP does not utilize any field except .sections[], so the
> others can in fact be dropped as redundant once we make the switch. This
> patch helps enable the paradigm of "everything you need to render a secti=
on
> is contained within the Section object itself" which lends itself well to
> the new transmogrifier, the goal of always processing/rendering in source
> order, and facilitating the mechanics of the inliner.)
>
> ...
>
> In case I got too rambly, my action items for this patch are:
>
> - fix the test (already done)
> - rename tag to kind
> - rename "untagged" to "text", possibly changing it again pending your
> feedback.

Sounds good!


