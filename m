Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB37CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 08:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE1ZG-0000k5-GQ; Wed, 29 Oct 2025 04:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vE1ZE-0000gN-Hl
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:30:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vE1Z7-0007DE-Op
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761726596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GiyZ5zS3THrfYjzEmjnHsupN2PGp8ITQ3WPcDKrrhMs=;
 b=NV2YQK3YI0lQpxmNF4brF0AIGbOc9ScqnO97vQMdXGPUfgPYHwhXBBFRs+rl1dgUJTnrpk
 xiwaQfDhMKFMpUuE8b5LBBbr0HaC6T2R9vpRElpzZveqZdcv5u6RFpbWS3Z+klj2rDSa5P
 i4vVD/Qeo6QSD2O1jsR6wm63NAb1Lec=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-464-_QyEZyQgMe67AZ_zrqntlw-1; Wed,
 29 Oct 2025 04:29:52 -0400
X-MC-Unique: _QyEZyQgMe67AZ_zrqntlw-1
X-Mimecast-MFC-AGG-ID: _QyEZyQgMe67AZ_zrqntlw_1761726591
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73CDD1800D80; Wed, 29 Oct 2025 08:29:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C46BB1955F1B; Wed, 29 Oct 2025 08:29:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1FBD221E6A27; Wed, 29 Oct 2025 09:29:48 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org,  eblake@redhat.com
Subject: Re: [PATCH v2 00/33] qapi: docs: width=70 and two spaces between
 sentences
In-Reply-To: <aOy0OtaNT9A48rhQ@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 13 Oct 2025 09:11:38 +0100")
References: <20251011140441.297246-1-vsementsov@yandex-team.ru>
 <aOy0OtaNT9A48rhQ@redhat.com>
Date: Wed, 29 Oct 2025 09:29:48 +0100
Message-ID: <878qgurtz7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Sat, Oct 11, 2025 at 05:04:06PM +0300, Vladimir Sementsov-Ogievskiy wr=
ote:
>> Hi all!
>>=20
>> Let's bring the documentation in line with the requirements. And
>> do check these requirements in QAPI parser.
>
> This implicitly assumes that the requirements are desirable.
>
> This is a large number of patches, showing the requirements are widely
> ignored today. When I look at the changes in the patches my overwhealming
> reaction is that they are not beneficial, which in turn makes me believe
> the requirements should be changed to match the reality of the code,
> rather than the reverse.

A QAPI schema contains four distinct kinds of text:

1. Schema code

2. Example code in comments

3. Doc comments less example code, i.e. prose

4. Non-doc comments

This series touches all four.

"The requirements" refers to docs/devel/qapi-code-gen.rst section
Documentation comments / Documentation markup:

    For legibility, wrap text paragraphs so every line is at most 70
    characters long.

    Separate sentences with two spaces.

I've explained why these rules make sense a number of times, and I'm
happy to explain again if needed.

Note this applies only to doc comments.

I've been enforcing it manually for prose.  Whether it should be
enforced for example code is debatable.  Let's focus on prose.

"Widely ignored" is not true, and I have numbers to back that up.

We have some 20,000 lines of doc comments in the main QAPI schema and
the QGA QAPI schema.  Some 3,000 lines are examples.  That leaves a bit
over 17,000 lines of prose in 48 files.

If I drop the changes to the other three kinds from Vladimir's series,
and add a few more prose changes he missed, I get this diffstat:

 24 files changed, 351 insertions(+), 332 deletions(-)

So, 98% of the prose adheres to the rules.

Half of the files are *spotless*.


