Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A75C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 10:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqUdi-00064V-DW; Fri, 07 Mar 2025 05:09:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqUdd-00063q-AQ
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 05:09:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqUdb-0007gR-Q8
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 05:09:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741342141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uETNzP6ohsKIIAhKXKWs9ACT40YqsmGNOB97aTOHvog=;
 b=TqKSfDeAumePZjF2x82pYbUjxTeRj7MvDi45s6aoaYy6m8DQf6KER/A9HJ/Z6wsr2sgflF
 OyoZ1/Xbz72Ny0WS15jW37X5BfyacZVQ7S8pIzqHpWOy0F8HkzamD35yNdyu5FWITNJA7J
 ouk/TQccooJ2dwVL7aLZQuw7h2Cd7wg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-5cCLQUqsMcS2nxnZ3b72TA-1; Fri,
 07 Mar 2025 05:08:56 -0500
X-MC-Unique: 5cCLQUqsMcS2nxnZ3b72TA-1
X-Mimecast-MFC-AGG-ID: 5cCLQUqsMcS2nxnZ3b72TA_1741342135
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2F8B180034D; Fri,  7 Mar 2025 10:08:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1ACFA1800373; Fri,  7 Mar 2025 10:08:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9ED4221E66C2; Fri, 07 Mar 2025 11:08:46 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Philippe =?utf-8?Q?Mat?=
 =?utf-8?Q?hieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,  Thomas
 Huth <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 09/57] docs/qapi-domain: add QAPI xref roles
In-Reply-To: <20250305034610.960147-10-jsnow@redhat.com> (John Snow's message
 of "Tue, 4 Mar 2025 22:45:18 -0500")
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-10-jsnow@redhat.com>
Date: Fri, 07 Mar 2025 11:08:46 +0100
Message-ID: <87ldthnoep.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

> Add domain-specific cross-reference syntax. As of this commit, that
> means new :qapi:mod:`block-core` and :qapi:any:`block-core` referencing
> syntax.
>
> :mod: will only find modules, but :any: will find anything registered to
> the QAPI domain. (In forthcoming commits, this means commands, events,
> enums, etc.)

I understand :any: will find any QAPI schema definitions.  Does it find
modules, too?

How could roles narrower than "definition" be useful?

I'm asking because naming rules preclude naming collisions among
definitions:

* Events are ALL_CAPS

* Commands are lower-case-with-dashes, except some older ones use
  underscores (pragma command-name-exceptions).

* Types are CamelCase.  Note that "C" is not considered a camel.

Fine print: these are the rules for stems, i.e. the name without RFQDN
or 'x-' prefixes, if any.

If :any: finds modules, then commands and modules could collide.
Nothing else can.

> Creating the cross-references is powered by the QAPIXRefRole class;
> resolving them is handled by QAPIDomain.resolve_xref().
>
> QAPIXrefRole is copied almost verbatim from Sphinx's own
> PyXrefRole. PyXrefRole (and QAPIXrefRole) adds two features over the
> base class:
>
> (1) Creating a cross-reference with e.g. :py:class:`~class.name`
> instructs sphinx to omit the fully qualified parts of the resolved name
> from the actual link text. This may be useful in the future if we add
> namespaces to QAPI documentation, e.g. :qapi:cmd:`~qsd.blockdev-backup`
> could link to the QSD-specific documentation for blockdev-backup while
> omitting that prefix from the link text.
>
> (2) Prefixing the link target with a "." changes the search behavior to
> prefer locally-scoped items first.
>
> I think both of these are worth keeping to help manage future namespace
> issues between QEMU, QSD and QGA; but it's possible it's extraneous. It
> may possibly be worth keeping just to keep feature parity with Sphinx's
> other domains; e.g. "principle of least surprise". Dunno.

I generally avoid features without uses.  But I trust your judgement
here: you decide.

> Signed-off-by: John Snow <jsnow@redhat.com>


