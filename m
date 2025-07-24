Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF75C83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 07:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueqP5-0001gv-8G; Thu, 24 Jul 2025 03:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ueqP2-0001f1-RY
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 03:30:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ueqOy-0001gj-8O
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 03:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753342201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c5T3mHBa2Yg68PItwNXTMDBy+KX15nUF6DzKxKFryWo=;
 b=eSqIT/9f23W0PusrtMSz7V+3DVDQ0J9xwpN8KVYf6Opy1fvZ3uL6HKXqE5F5nLMIbkCLPA
 4NTUy04nbXRJWP2ZGqSvXNt55Z2bDx1xp8dx8nAS5aOnSNq0sx6EW+PyHTIJWlPoaMRHAI
 1u4c/evqjefOHDOhr7gk8+oUroPA+gw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-H8R7fwIxMrScQhBhOI9XFQ-1; Thu,
 24 Jul 2025 03:29:59 -0400
X-MC-Unique: H8R7fwIxMrScQhBhOI9XFQ-1
X-Mimecast-MFC-AGG-ID: H8R7fwIxMrScQhBhOI9XFQ_1753342198
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C0B11800447; Thu, 24 Jul 2025 07:29:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96E4B1800286; Thu, 24 Jul 2025 07:29:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 033B121E6A27; Thu, 24 Jul 2025 09:29:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 1/1] docs/qapi-domain: Improve QAPI indices
In-Reply-To: <20250523180809.41211-2-jsnow@redhat.com> (John Snow's message of
 "Fri, 23 May 2025 14:08:09 -0400")
References: <20250523180809.41211-1-jsnow@redhat.com>
 <20250523180809.41211-2-jsnow@redhat.com>
Date: Thu, 24 Jul 2025 09:29:54 +0200
Message-ID: <87qzy6qc5p.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.377,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

I refreshed my memory on this.  It's been a while.  Instead of replying
to your replies long after you wrote them, I'm going to write up my
thoughts in one place.


= General observations =

* We have three QAPI-generated manuals: QEMU QMP Reference Manual, QEMU
  Storage Daemon QMP Reference Manual, QEMU Guest Agent Protocol
  Reference.

* We generate an index for each manual: qapi-qmp-index.html,
  qapi-qst-index.html, qapi-qga-index.html.

* The doc generator does not link to these indexes by itself.  Instead,
  each manual links to its index in its introduction section.  This
  makes the index really easy to miss.  Even if you're aware, jumping to
  the index is bothersome once this lone link is out of sight.  Until
  that changes, the practical value of improvements to the index is in
  doubt.  Doesn't mean improvements should not be made, only that they
  better be cheap.

* You're proposing to additionally generate a "main" QAPI index
  qapi-index.html for everything documented in any QAPI-generated
  manual.  Not linked from anywhere.

* Modules let developers structure the schema and the generated code.
  They are not a thing at the QMP interface.  Letting such internals
  bleed into QMP documentation is *wrong*.  The excuse for doing it
  anyway is that the module tree is close to the section tree in
  practice, and we can use the modules (which are readily available in
  the doc generator) as an approximation for sections (which we don't
  have there at this time).


= Indexes before the patch =

An index page starts with links

    Alternates | Commands | Enums | Events | Modules | Objects | A | B | C | D | E | F | G | H | I | J | K | L | M | N | O | P | Q | R | S | T | U | V | W | X | Y | Z 

Then we have flat lists of the alternates, commands, enums, events,
modules, objects, entities starting with "A" or "a", ..., "Z" or "z".
Each list is alphabetically sorted.

The links at the top take you to the heading of the respective list.

The list entries link to entity documentation, except for "Modules",
which link to the beginning of the doc generated for a QAPI module.
The entries under "A", ..., "Z" have a (meta-type) suffix.

Every entity is listed twice, once under its meta-type (Alternates,
Commands, Enums, Events, Objects), and once under its first letter.


= Indexes after the patch =

An index page starts with links

    By module | By type | A | B | C | D | E | F | G | H | I | J | K | L | M | N | O | P | Q | R | S | T | U | V | W | X | Y | Z

Then a two level list module / entity name (meta-type) linking to the
entity's doc.  Link "By module" takes you to its heading.

Then a two level list meta-type / entity name linking to the entity's
doc.  Link "By type" takes you to its heading.  This replaces the flat
lists Alternates, Commands, Enums, Events, Objects.

In both two level lists the outer level is collapsible.

Then flat lists "A", ..., "Z" as before.

Flat list "Modules" is gone.

The links at the top take you to the heading of the respective list.

Every entity is listed twice, once under its meta-type under "By type",
and once under its first letter.

The lists are now sorted case-insensitively.


= Critique =

Here's the one question that matters: what are readers trying to do when
they use the index page?

Assuming they find the index page in the first place (see "lone link"
under "General observations" above), but that issue is out of scope
here.

I believe readers use the index to jump to the doc for X, where X is
something they encountered in the QMP interface.

I don't think they'll use the index to jump to the doc of an Y they
encounter in documentation, because that Y will be a link.

X obviously includes commands and events.

I doubt it includes types.  Type names are not a thing in the QMP
interface.  You run into them only in documentation, but again, they are
links there.

We should make looking up a command / event as easy and quick as we can.

Let's examine how users can navigate to the index entry that takes them
to the command / event doc.

Before the patch:

1. Find the index page somehow (out of scope here).

2. Click on Commands / Events.  For commands, can instead visually skip
   over the alternates (which is just a few lines) to Commands.

3. Visually scan an alphabetically sorted list of ~250 commands (almost
   seven screen-fulls for me) or ~50 events (a bit over one).

Alternatively:

2. Click on the letter the command / event starts with.

3. Visually scan an alphabetically sorted list of up to ~200 entries
   (five screen-fulls for me).

Alternatively:

2. Have the browser search the index page for the name.

Alternatively:

1. Screw the index, search the entire manual (single page) for the name.

After the patch:

1. Same.

2. Click on "By type".  If you can somehow divine that's where the
   commands / events hide.

3. For commands, visually skip over the alternates (which is just a few
   lines) to Command (could also collapse Alternate, but why bother).

   For events, either scroll down a lot looking for the events, or
   search for "event" (for me, that jumps right back to the top of the
   page to show me the first event under "By modules").  Could also
   collapse Alternate, Command, and Enum, but most likely just give up
   and try an alternative.

4. As before, visually scan an alphabetically sorted list of ~250
   commands (almost seven screen-fulls for me) or ~50 events (a bit over
   one).

The alternatives are unaffected by the patch.

I'm afraid the patch makes the index harder to use.

Minor quibbles:

* The "type" in "By type" is wrong.  It's by QAPI meta-type, which is
  not the same as QAPI type.  Casual readers will likely not be familiar
  with the term "meta-type".  Calling the thing type risks confusion
  nevertheless.

* The Modules sub-index before the patch is useless.  The navigation bar
  on the left is much, much easier to use.  It also shows the *actual*
  section structure, not an approximation.

* The "By Modules" index after the patch is debatable.

* I can't see a use for the "main" QAPI index.


= Recommendations =

* Consider dropping types from the index entirely.  This would make
  navigating to commands and events via first letter links *much*
  easier.  No need for Commands and Events lists, the "A", ..., "Z"
  suffice.

* Else, keep an obvious, one click path from top of index page to
  commands and to events.

  However, the list of commands is too long to quickly scan visually.
  Consider breaking it up by first letter.

* Keep the switch to case-insensitive sorting.

* Definitely drop the Modules sub-index.  I don't care for the "By
  modules" thing, either.  The navigation bar on the left does that job
  better.

* Drop the "main" QAPI index.

* Out of scope for this patch: a manual's index page should be easy to
  reach from anywhere in the manual.


Thoughts?


