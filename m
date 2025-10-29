Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9D4CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 09:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE2Aq-0001UP-QB; Wed, 29 Oct 2025 05:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vE2Ao-0001Th-S6
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:08:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vE2Ak-00045c-NK
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:08:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761728928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3L3aeQ5zMgXGcfARs66NS6uaAiHTBvuLvBBFOYmlaFA=;
 b=fneZDZHmCr1fNRt1l9iOZunzyhgsvMBEFu22X9ZmTGx9UdPPPC0jlC8FgEnSqOmRv/d3Gn
 HLZr7GY3AS01W4Cp5nI1lwzHnmosrALGYFgyiKxwmLl57ZgBUklR6ht5fNmc5jwvpjjRh6
 I6X3s4oT99xaAXI1PtfCHXc/4tYDpJ4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-4gUMxvkYP8GSfLOyUBZ5DQ-1; Wed,
 29 Oct 2025 05:08:44 -0400
X-MC-Unique: 4gUMxvkYP8GSfLOyUBZ5DQ-1
X-Mimecast-MFC-AGG-ID: 4gUMxvkYP8GSfLOyUBZ5DQ_1761728924
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AEFC7183452C; Wed, 29 Oct 2025 09:08:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C8DE30001BF; Wed, 29 Oct 2025 09:08:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 983D021E6A27; Wed, 29 Oct 2025 10:08:35 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  eblake@redhat.com
Subject: Re: [PATCH v2 00/33] qapi: docs: width=70 and two spaces between
 sentences
In-Reply-To: <20251011140441.297246-1-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Sat, 11 Oct 2025 17:04:06 +0300")
References: <20251011140441.297246-1-vsementsov@yandex-team.ru>
Date: Wed, 29 Oct 2025 10:08:35 +0100
Message-ID: <87sef2qdm4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> Hi all!
>
> Let's bring the documentation in line with the requirements. And
> do check these requirements in QAPI parser.

Prior art:

    01bed0ff14 qapi: Refill doc comments to conform to conventions
    7270819384 qga/qapi-schema: Refill doc comments to conform to current conventions
    209e64d9ed qapi: Refill doc comments to conform to current conventions

These only touched prose.

Your series also touches examples, is split per source file, and adds
code to enforce the rules automatically.

Automatic enforcement makes a ton of sense.  Should've tried to code it
up long ago.  Much appreciated!  However, it's in the first patch.  It
needs to go last to not break bisection.

I don't think splitting per source file is necessary.

I'd prefer to put aside examples for now and focus on prose, since the
case for prose is much stronger.

Since I already split off the prose changes for my own review purposes,
there's no need for you to do that again.  I'll take care of it.

However, we need to adjust the enforcement code to skip examples.

Examples are marked up with ReST directive qmp-example.  They look like
this:

    # .. qmp-example::
    #
    #     the example
    #         text is
    #     indented

The stupidest solution that could possibly work is to start skipping the
checks at

    # .. qmp-example::

and resume it at the first unindented line.

This is of course a hack: it second-guesses the ReST parser.  I think
it's good enough.

If we in a later step decide reflowing the examples is usful, the hack
goes away.

Would you be willing to take care of that part?


