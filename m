Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9F8CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 10:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE3N8-0001w1-Pl; Wed, 29 Oct 2025 06:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vE3Mz-0001s0-Pg
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:25:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vE3Mv-0006mw-EV
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761733524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T/vXAKtQJ7IzY9oxVKhHK6iX8J7d2pGwoCvf3RtX9Go=;
 b=EGsVUdO8lZ+4L6G0HTa6+WCGAUSJirNcgsP3Uzu734asGHkxxbP+9Fs6SpPqe72WgvpJ8Z
 yEJ8+/X83ISmsPvXZ85XPFI1PFXRfSs/SpqWGRQz97z9MIcTTXM48Ql5H4avbdAZYNZ5nh
 KJeppDV0ORYh2qfXx1yJHsVde2F7Y6k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-SnMzCdlVO7OZNcZH9-Ga8g-1; Wed,
 29 Oct 2025 06:25:20 -0400
X-MC-Unique: SnMzCdlVO7OZNcZH9-Ga8g-1
X-Mimecast-MFC-AGG-ID: SnMzCdlVO7OZNcZH9-Ga8g_1761733519
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C747619541A1; Wed, 29 Oct 2025 10:25:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F0D051955F1B; Wed, 29 Oct 2025 10:25:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 51A1E21E6A27; Wed, 29 Oct 2025 11:25:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, eblake@redhat.com
Subject: Re: [PATCH v2 00/33] qapi: docs: width=70 and two spaces between
 sentences
In-Reply-To: <3f9153b1-ba52-4f30-ac31-3916d9ee2ea5@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 29 Oct 2025 12:28:35 +0300")
References: <20251011140441.297246-1-vsementsov@yandex-team.ru>
 <aOy0OtaNT9A48rhQ@redhat.com> <878qgurtz7.fsf@pond.sub.org>
 <3f9153b1-ba52-4f30-ac31-3916d9ee2ea5@yandex-team.ru>
Date: Wed, 29 Oct 2025 11:25:15 +0100
Message-ID: <877bweqa2c.fsf@pond.sub.org>
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 29.10.25 11:29, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>>> On Sat, Oct 11, 2025 at 05:04:06PM +0300, Vladimir Sementsov-Ogievskiy =
wrote:
>>>> Hi all!
>>>>
>>>> Let's bring the documentation in line with the requirements. And
>>>> do check these requirements in QAPI parser.
>>>
>>> This implicitly assumes that the requirements are desirable.
>>>
>>> This is a large number of patches, showing the requirements are widely
>>> ignored today. When I look at the changes in the patches my overwhealmi=
ng
>>> reaction is that they are not beneficial, which in turn makes me believe
>>> the requirements should be changed to match the reality of the code,
>>> rather than the reverse.
>>
>> A QAPI schema contains four distinct kinds of text:
>>
>> 1. Schema code
>>
>> 2. Example code in comments
>>
>> 3. Doc comments less example code, i.e. prose
>>
>> 4. Non-doc comments
>>
>> This series touches all four.
>
> I'm unsure about [1.]. What do you mean? The series touch only comments.
>
> I now check:
>
>  git diff 37137ae582 HEAD | grep '^[+-][^#+-]'
>
> where 37137ae582 is first commit "qapi: Add documentation format validati=
on"
> for me, and this grep finds nothing..

You're right.  Cross-eyed, I guess %-}

> Assume [4.] is a tiny part.

Yes.

>> "The requirements" refers to docs/devel/qapi-code-gen.rst section
>> Documentation comments / Documentation markup:
>>
>>      For legibility, wrap text paragraphs so every line is at most 70
>>      characters long.
>>
>>      Separate sentences with two spaces.
>>
>> I've explained why these rules make sense a number of times, and I'm
>> happy to explain again if needed.
>>
>> Note this applies only to doc comments.
>>
>> I've been enforcing it manually for prose.  Whether it should be
>> enforced for example code is debatable.  Let's focus on prose.
>>
>> "Widely ignored" is not true, and I have numbers to back that up.
>>
>> We have some 20,000 lines of doc comments in the main QAPI schema and
>> the QGA QAPI schema.  Some 3,000 lines are examples.  That leaves a bit
>> over 17,000 lines of prose in 48 files.
>>
>> If I drop the changes to the other three kinds from Vladimir's series,
>> and add a few more prose changes he missed
>
> Hmm it surprises me.. Does it mean that the check added in patch 01 misses
> some violations?

I found a few more paragraphs to reflow for reasons other than long
lines, a few extra blank lines, a few missing blank lines, and slightly
off indentation in a few places.  None of this I expect your code to
catch.

I found a few errors in your patch, like this one in PATCH 13:

    @@ -620,7 +622,8 @@
     ##
     # @NumaCpuOptions:
     #
    -# Option "-numa cpu" overrides default cpu to node mapping.  It accepts
    +# Option "-numa cpu" overrides default cpu to node mapping.  It
    +#     accepts
     # the same set of cpu properties as returned by
     # `query-hotpluggable-cpus[].props <query-hotpluggable-cpus>`, where
     # node-id could be used to override default node mapping.
    @@ -686,7 +689,8 @@

They made me feel useful ;)

I also found a few single spaces that should be double.  Maybe the code
could be improved to catch them.

>>, I get this diffstat:
>>   24 files changed, 351 insertions(+), 332 deletions(-)
>
> Compare with original diffstat:
>
>  33 files changed, 713 insertions(+), 704 deletions(-)
>
> So obviously, touching up code examples makes the series twice more invas=
ive.
>
> I agree, to at least postpone examples changing. And the series show, tha=
t in many
> cases there are no obvious possibility to satisfy restrictions for exampl=
es.
>
> Hmm, probably, we want another limit for examples? 90 characters? Anyway,=
 not in this
> series.

I figure code in examples should be treated just like "real" code.

Avoiding long prose lines is easy.  When I reflowed the entire QAPI
schema documentation to stay within the limit (commit a937b6aa739), not
a single line break was awkward.

Code is unlike prose: it's often more deeply indented, and it contains
more longer words (identifiers).  Because of that, a long code line can
be less bad than an awkward line break.  Use your judgement.

devel/style.rst thus advises:

    Line width
    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

    Lines should be 80 characters; try not to make them longer.

    Sometimes it is hard to do, especially when dealing with QEMU subsystems
    that use long function or symbol names. If wrapping the line at 80 colu=
mns
    is obviously less readable and more awkward, prefer not to wrap it; bet=
ter
    to have an 85 character line than one which is awkwardly wrapped.

    Even in that case, try not to make lines much longer than 80 characters.
    (The checkpatch script will warn at 100 characters, but this is intended
    as a guard against obviously-overlength lines, not a target.)


