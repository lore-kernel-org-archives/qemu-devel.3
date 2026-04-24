Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62E3FED3C3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 12:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGFzX-0004it-W8; Fri, 24 Apr 2026 08:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wGFzV-0004ij-RH
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 08:50:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wGFzU-0005ie-2l
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 08:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777035037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1mq4sHshCqBAlZJwGMlczxv6eprNBC2Y5bjdVsccY+w=;
 b=BBb+cOznFli2H9ynXGwRhppwybZpsM5LMCT5eC++SgEyarsc6AnelBawp+GT5Bj3PG00IS
 05qbix9Xc61f/101KMjkclbn7asEzYrPtBviDBQFu7xsnXEpG8m7gZkVpX/3mqRUjkRcwW
 5kPjY0rVxSm1pBKUZPsB+oAjeiVdIcg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-fZSPBJFkPPCY5m6kZxFJdg-1; Fri,
 24 Apr 2026 08:50:28 -0400
X-MC-Unique: fZSPBJFkPPCY5m6kZxFJdg-1
X-Mimecast-MFC-AGG-ID: fZSPBJFkPPCY5m6kZxFJdg_1777035026
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0497319560B4; Fri, 24 Apr 2026 12:50:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.30])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4664F180047F; Fri, 24 Apr 2026 12:50:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D132321E6A28; Fri, 24 Apr 2026 14:50:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Igor Mammedov <imammedo@redhat.com>,  Mauro
 Carvalho Chehab <mchehab+huawei@kernel.org>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Ani Sinha
 <anisinha@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 00/12] qapi: add formal "intro" section
In-Reply-To: <20260423220022.2180059-1-jsnow@redhat.com> (John Snow's message
 of "Thu, 23 Apr 2026 18:00:09 -0400")
References: <20260423220022.2180059-1-jsnow@redhat.com>
Date: Fri, 24 Apr 2026 14:50:22 +0200
Message-ID: <87mrysr08h.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

> Hiya, this is a series that explores a potential syntax for a
> designated "Intro" section. Markus knows why I want this, but for
> everyone else: a designated "Introduction" section is useful for the
> desired "inliner" feature for the new QAPI doc system. Commits explain
> a bit more. This is prep work and doesn't really change anything
> tangibly except source code syntax for the QAPI docs.

Let me elaborate a bit.

1. Why "intro"?

Generated documentation often refers to types like this:

    Command announce-self (Since: 4.0)

       Trigger generation of broadcast RARP frames to update network
       switches.  This can be useful when network bonds fail-over the
       active slave.

       Arguments:
          * The members of "AnnounceParameters".

       Example::

          -> { "execute": "announce-self",
               "arguments": {
                   "initial": 50, "max": 550, "rounds": 10, "step": 50,
                   "interfaces": ["vn2", "vn3"], "id": "bob" } }
          <- { "return": {} }

The arguments are hidden behind link "AnnounceParameters".  Following
leads to:

    Object AnnounceParameters (Since: 4.0)

       Parameters for self-announce timers

       Members:
          * initial ("int") -- Initial delay (in ms) before sending
            the first GARP/RARP announcement

          * max ("int") -- Maximum delay (in ms) between GARP/RARP
            announcement packets

          * rounds ("int") -- Number of self-announcement attempts

          * step ("int") -- Delay increase (in ms) after each self-
            announcement attempt

          * interfaces ("[string]", *optional*) -- An optional list of
            interface names, which restricts the announcement to the
            listed interfaces.  (Since 4.1)

          * id ("string", *optional*) -- A name to be used to identify
            an instance of announce-timers and to allow it to modified
            later.  Not for use as part of the migration parameters.
            (Since 4.1)

This is bad UX.  Especially when you have to chase multiple links.

John's doc inliner inlines AnnounceParameters documentation into
announce-self documentation.

However, we don't want to inline "Parameters for self-announce timers".

Definitions typically start with a short description of the thing being
defined.  John calls this "intro".  We don't want to inline these.

Syntactically, a doc comment begins with optional plain paragraphs.
These end when something else begins: argument or member description,
tagged section such as "Returns:", ...

Most of the time, these initial paragraphs are exactly the "intro".  But
not always.

Even without the inliner, we often need to know where "intro" ends.  In
the example above, "Arguments:" is auto-generated right after the
"intro", and for that, the generator needs to know where "intro" ends.

In his "qapi: enforce section ordering" series, John proposed syntax to
explicitly end "intro": a line "Details:".  He had to add it to roughly
one in 25 definition docs.

I fear adding "Details:" when needed is easily forgotten when it's so
rarely needed.  And I don't even trust myself to catch it patch review.
So we looked for clearer syntax.

This series implements one: instead of letting intro end when something
else starts, use indentation like we do for descriptions and tagged
sections.

Let's have a look at the current doc source for announce-self:

    ##
    # @announce-self:
    #
    # Trigger generation of broadcast RARP frames to update network
    # switches.  This can be useful when network bonds fail-over the
    # active slave.
    #
    # TODO: This line is a hack to separate the example from the body
    #
    # .. qmp-example::
    #
    #     -> { "execute": "announce-self",
    #          "arguments": {
    #              "initial": 50, "max": 550, "rounds": 10, "step": 50,
    #              "interfaces": ["vn2", "vn3"], "id": "bob" } }
    #     <- { "return": {} }
    #
    # Since: 4.0
    ##

"Intro" ends when something else starts, namely the TODO: section.  We
need this hack so the doc generator inserts the "Arguments:" part where
we want it.

John's "qapi: enforce section ordering" series replaces the TODO hack
with a "Details:" line.

In new syntax, this instead becomes:

    ##
    # @announce-self: Trigger generation of broadcast RARP frames to
    #     update network switches.  This can be useful when network bonds
    #     fail-over the active slave.
    #
    # .. qmp-example::
    #
    #     -> { "execute": "announce-self",
    #          "arguments": {
    #              "initial": 50, "max": 550, "rounds": 10, "step": 50,
    #              "interfaces": ["vn2", "vn3"], "id": "bob" } }
    #     <- { "return": {} }
    #
    # Since: 4.0
    ##

Now "intro" is indented, and its end is obvious.  Mistakes seem
unlikely.

We could instead do:

    ##
    # @announce-self:
    #     Trigger generation of broadcast RARP frames to update network
    #     switches.  This can be useful when network bonds fail-over the
    #     active slave.
    #
    # .. qmp-example::
    #
    #     -> { "execute": "announce-self",
    #          "arguments": {
    #              "initial": 50, "max": 550, "rounds": 10, "step": 50,
    #              "interfaces": ["vn2", "vn3"], "id": "bob" } }
    #     <- { "return": {} }
    #
    # Since: 4.0
    ##

I think I like this a bit better.

> It is designed so that this conversion can happen incrementally with
> no actual difference to the rendered manuals, so each QAPI module can
> be converted one at a time for easier review and merging in an
> arbitrary order.

Why not wholesale conversion?  As long as generated output stays the
same.  It does in this series, except for harmless line breaks.

> This series demonstrates conversion of just four modules; if I'm given
> a thumbs up, I will convert the rest of QAPI, one module (or
> maintainer stanza) per patch like how I handled adding
> cross-references.


