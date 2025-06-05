Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC7DC5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 08:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN6GP-0005sB-7R; Thu, 05 Jun 2025 04:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uN6FD-0005DA-Ti
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:46:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uN6FB-0001tH-Oi
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749113196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xpL1tbyyEMa/OHUZVbCrkNH8WOEif6TKtLXkzJ0fdD0=;
 b=SJpesTqoJJbjVIWYJr1zTYKEKntDBoza4o0vt8P24F7lExY90kV6U+WuY2CijrxPIQDjxu
 /x+mC9VdZtHDK8WDBWnJXHxrJ+qQ3VYpyWfGNi+8FjOJff8Upquz8Q60cOlUhWMcOUEey2
 Ue0jE+r4YCP0wmPYdxloIhyVI71dS8s=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-TcB_m9c5O8CcRsrm2gTBbw-1; Thu,
 05 Jun 2025 04:46:31 -0400
X-MC-Unique: TcB_m9c5O8CcRsrm2gTBbw-1
X-Mimecast-MFC-AGG-ID: TcB_m9c5O8CcRsrm2gTBbw_1749113191
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F296319560AA; Thu,  5 Jun 2025 08:46:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63F2A1954B33; Thu,  5 Jun 2025 08:46:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BEBF821E6768; Thu, 05 Jun 2025 10:46:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: John Snow <jsnow@redhat.com>,  qemu-devel@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/1] docs/qapi-domain: Improve QAPI indices
In-Reply-To: <aD2IBR5FTFCSrV8x@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 2 Jun 2025 12:16:21 +0100")
References: <20250523180809.41211-1-jsnow@redhat.com>
 <20250523180809.41211-2-jsnow@redhat.com>
 <aD2IBR5FTFCSrV8x@redhat.com>
Date: Thu, 05 Jun 2025 10:46:27 +0200
Message-ID: <875xhalgnw.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, May 23, 2025 at 02:08:09PM -0400, John Snow wrote:
>> This patch changes the "by type" categorization in favor of using
>> sub-categories of a literal "By type" category instead. A new "By
>> module" categorization is also added that follows a similar pattern.
>
> I'm not much of a fan of this. IMHO unless you are looking at the
> module(s) for the subsystem you are the maintainer of, the split
> of definitions across modules comes across as somewhat arbitrary
> and unpredictable.

We have two parallel structures: QAPI modules and reST sections.

QAPI modules are for developers working on the QAPI schema[1].

reST sections are for readers of the documentation generated from the
QAPI schema.

We intentionally refrained from tying the two together more than
necessary.

The generated documentation is in an order defined by the include
directives.  To get the order you want, you may have to juggle include
directives, and maybe even split up modules.  If this ever gets too
bothersome, we'll provide some other way to order things[2].

You can then add any section structure you want.  You could even start a
section in the middle of one module, and end it in the middle of a later
module.  That would be silly, of course.  My point is: the section
structure need not mirror the module structure.

What does this mean for structuring the generated documentation's index?
If we want to structure it, we should use section structure, not module
structure.

> Looking at this from the POV of a consumer of QMP, our entrypoint
> to research is either a command name or an event name.
>
> The data type names of enums/alternates/objects are an internal
> QEMU detail that's not part of the public API.

Good observation.  I'd expect readers will want to use the index to look
up the names present in the external interface (commands and events).
Once they found them, they'll likely need to look up types mentioned
there, but they'll want to do so by following links, not going back to
the index.

> If we consider the index currently:
>
>   Alternates | Commands | Enums | Events | Modules | Objects | A | .... |=
 Z
>
> The A ... Z bits link to a mix of all type names, which is a bit
> overwhealming.
>
> At the same time the page is twice as big as it needs to be
> as the same info is repeated under the A-Z index and the
> other per-type indexes.
>
> I think what would help would be to make the index dynamic
>
> eg
>
>   A | B | C | D | E | ... | X | Y | Z
>
>   [ ] Show internal types=20
>
> The A-Z index would default to showing commands and events.
> Selecting the "Types" checkbox would toggle display of the
> alternate/enum/object names, which could be done via having
> a CSS class on each index entry, and javascript which just
> toggles 'display: none' / 'display: block' CSS property on
> the elements with the given class.

Hiding types by default makes sense to me.  How exactly to do that is up
to the developer.  Even something as simple & stupid as a link to an
alternate index page could work.

>                                    I'm not convinced we need
> the modules in the index.

Me neither.  See my argument above.

>> Alphabetical sorting has been improved and will sort in a case
>> insensitive manner for all categories, now.
>
> This is trivial and nice and could be a standalone fix ?

Yes, please :)

>> Lastly, the "main" QAPI Index (qapi-index.html) is altered to index
>> *everything* from all namespaces, adding disambiguation where necessary
>> to do so.
>
> This looks a bit wierd having the same types and modules repeated
> multiple times.

I'm not sure such an index is useful.

> With regards,
> Daniel


[1] Why are modules useful for developers?

The QAPI schema used to be monolithic: one input file
(qapi-schema.json), one output file of each kind (qapi-commands.c,
qapi-events.c, qapi-introspect.c, qapi-types.c, qapi-visit.c, ...).

A single input file is unwiedly, and defeats the MAINTAINERS file.  So
we added support for splitting it up into modules (commit a719a27c824
"qapi: Add a primitive to include other files from a QAPI schema file",
May 2014), and over several years moved *everything* from
qapi-schema.json to submodules it includes.

A single output file per kind eventually took us to "touch the QAPI
schema, recompile the world".  So I changed it to generate one output
file per module for the kinds where that makes sense (commit 252dc3105fc
"qapi: Generate separate .h, .c for each module", Feb 2018).


[2] If the order within a module makes the generated documentation hard
to read, it'll probably make the source file hard to read, too.  So fix
that.


