Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB4EF30946
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 12:44:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy83S-0006d4-9E; Thu, 05 Mar 2026 07:43:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vy83G-0006bh-KC
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 07:43:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vy83D-0003eQ-Nf
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 07:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772714612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uxKFRcwb8EvIWQRaqwP/SoZvbEj2I6H5TKqGtI7ECL0=;
 b=SRPGar/ziroMyItdQsrw/QscddvrLevXED5hwunLFPY3vi75+Yzl8jmdpN8AvUzdTgFT/1
 6QKvRev1JFng1aj728lBmt+0mO/IAlD0v8MHFsrUSHZkbE21LUWsfFmqKyZ7lP7TQkbXD0
 Xycq/qnr6OZQoLzOX4LQyvAowGq+8aA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-80CCZtXCNSCTMKd5Gq7GHg-1; Thu,
 05 Mar 2026 07:43:31 -0500
X-MC-Unique: 80CCZtXCNSCTMKd5Gq7GHg-1
X-Mimecast-MFC-AGG-ID: 80CCZtXCNSCTMKd5Gq7GHg_1772714610
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D221419560B2
 for <qemu-devel@nongnu.org>; Thu,  5 Mar 2026 12:43:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C5E91958DC5
 for <qemu-devel@nongnu.org>; Thu,  5 Mar 2026 12:43:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D656821E6A04; Thu, 05 Mar 2026 13:43:27 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: QAPIDoc Total Section Ordering
In-Reply-To: <CAFn=p-Yfo2Hn9DCBGvOnpnOzqKhaZBiqWxSS5AmPi6nO_A=RYg@mail.gmail.com>
 (John Snow's message of "Wed, 4 Mar 2026 11:48:24 -0500")
References: <CAFn=p-bNbEwV+1ijfs=+_bCVfexjvN9WRNZwL13Qas+i_HmUBQ@mail.gmail.com>
 <87ldg7kh38.fsf@pond.sub.org>
 <CAFn=p-Yfo2Hn9DCBGvOnpnOzqKhaZBiqWxSS5AmPi6nO_A=RYg@mail.gmail.com>
Date: Thu, 05 Mar 2026 13:43:27 +0100
Message-ID: <87qzpymopc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622, SPF_HELO_PASS=-0.001,
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

> On Wed, Mar 4, 2026, 5:46=E2=80=AFAM Markus Armbruster <armbru@redhat.com=
> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > Hi, let's recap...
>> >
>> > In general, it would be nice to have a strict inter-section ordering
>> > for a few reasons:
>> >
>> > (1) It makes it easier to add generated sections such as return
>> > values, undocumented members, or undocumented features/flags (such as
>> > Out-of-band execution), because there is a clear and obvious place
>> > where we should insert the generated doc. We have a few spots in the
>> > code now where we have a bespoke algorithm to find the correct
>> > insertion point, and it would be nice to consolidate this logic.
>> >
>> > (2) It makes the inliner easier, because merging two doc sections is
>> > more obvious when there is a normal order that must be adhered to;
>> > fields that are absent in one or the other docs list do not cause
>> > problems or complex edge cases.
>> >
>> > (3) It allows us to design around a unified look and layout in the
>> > HTML generator, which increases visual cohesion and yadda yadda yadda.
>> > In particular, each "group" of doc types is laid out in a block where
>> > having multiple fields of the same type be non-contiguous greatly
>> > increases visual clutter. i.e. all arguments should be contiguous, all
>> > features should be contiguous, etc. I have in the past referred to
>> > these groupings of doc section types as "doc regions".
>> >
>> > For these reasons, I'd like to nail down the order once and for all,
>> > and clarify a few things.
>> >
>> > The order I think you prefer is something like this:
>> >
>> > (1) Introduction ("Plain text", currently) - Always the first section,
>> > always precisely one section. (But may be multiple paragraphs housed
>> > within that single section.)
>> > (2) Arguments/members/values/alternatives
>> > (3) Return(s)
>> > (4) Error(s)
>> > (5) Feature(s)
>> > (6) Details ("Plain text", currently - generally used for clarifying
>> > detail, examples, and other information.)
>>
>>   (7) Since
>>
>
> Ah, right. Because I remove "since" from the flow of the document, I wind
> up caring about it less, but yes. It can be last in the source.
>
>
>> > Before I go any further, is this order "roughly correct" to you?
>>
>> Yes!
>>
>> > ...
>> >
>> > We previously discussed prohibiting "plain text" from appearing
>> > anywhere except in (1) or (6). From memory, the summary of that
>> > discussion is:
>> >
>> > Me: Prohibiting plaintext from appearing between 2-5 makes inlining
>> > easier, and improves HTML output by preventing plaintext paragraphs
>> > from interrupting the "tabular" output used to render metadata fields.
>> >
>> > You: Although it is not often utilized, we may want the freedom/power
>> > to use plaintext paragraphs to add addendums/notes attached to
>> > specific sections, i.e. adding a "Note:" to the tail of the arguments
>> > section specifically.

Let me elaborate.

The sections in question are (2) member descriptions, (3) return, (4)
errors, and (5) feature descriptions.

Member descriptions have one section per member.  They get shown
together as a list.

Feature descriptions are similar.

Errors are in a single section.  By convention it contains a list.

Return contains just a description.  If we even inline return type
documentation, we'll get a list instead.

Each section has an indented body.  Multiple paragraphs there are rare,
but possible.  Much ReST markup just works.  Should be good enough to
document individual things.

My concern is where to put text that spans things.  Say text that
explains how multiple members are related.  Sometimes, explaining it in
just one of the member descriptions is fine.  Sometimes, explaining it
in each of the member descriptions is fine.  Sometimes, we'd really
prefer to explain it in one place after the member descriptions.

We can already put it in (6) details, but that can be rather distant
from the member descriptions.  Thus, my reluctance to lose the means to
put it right after the member descriptions.

I understand that this complicates your job, and splits the table you
generate for (2) ... (5).

Perhaps it could be useful to ponder how we'd want this to look in the
rendered table, then try to work backwards to doc syntax.

>> > I recall we debated this particular restriction quite a few times and
>> > at length; does this summary sound roughly accurate as far as you
>> > remember?
>>
>> It does.
>>
>> What breaks right now if you prohibit untagged sections between (2) to
>> (5)?
>>
>
> Not much. I think we have an interloping plaintext section maybe once or
> twice in the docs currently. In my previous patches, I just removed those
> sections but there was some concern about the ability to annotate e.g.
> arguments sections with a note.

Can you pinpoint the existing interlopers cheaply?

> I haven't actually worked on this feature, but I suggested once we could
> add an "addendum" or "section-note" tag to include these. I don't current=
ly
> have a strong sense of how hard that would or wouldn't be.

Keep in mind that the current doc syntax grew out of lose convention in
multiple steps, where in each step we usually picked minimizing doc
churn over cleaner and more robust syntax.

This also led to a parser that was too hard to maintain.  So I rewrote
it.  It's still unlikable.

I'm not attached to the status quo there.


