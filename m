Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D3A6EB7ECD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 10:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxjkR-0007CK-3J; Wed, 04 Mar 2026 05:46:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vxjkN-0007Br-Fo
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 05:46:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vxjkJ-0000RZ-JC
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 05:46:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772621185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kF/Pfe93qFheXxScWzkYvuR/QJ/ghvYjrv4iPNDY740=;
 b=aDRbxN4Ps3+KcJxBTfdgoVK73Qtysp0ThaHT9AOhF8E2UJypv2mTLNXYbjxfrsSb4L+m4S
 /NiwAlgYcJDIYxENWL0qpOklEH81+G5V9tAHqq6iDpNOfEg6xQ2R8BsLHeXRzBflD9gHRL
 k1LR+VvkaC2IXtOFKDmRePLX53SnNeY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-yxmy-_FvPBStON61ajSJjw-1; Wed,
 04 Mar 2026 05:46:23 -0500
X-MC-Unique: yxmy-_FvPBStON61ajSJjw-1
X-Mimecast-MFC-AGG-ID: yxmy-_FvPBStON61ajSJjw_1772621182
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD1A31956048
 for <qemu-devel@nongnu.org>; Wed,  4 Mar 2026 10:46:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.30])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BA13180035F
 for <qemu-devel@nongnu.org>; Wed,  4 Mar 2026 10:46:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 060A021E692F; Wed, 04 Mar 2026 11:46:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: QAPIDoc Total Section Ordering
In-Reply-To: <CAFn=p-bNbEwV+1ijfs=+_bCVfexjvN9WRNZwL13Qas+i_HmUBQ@mail.gmail.com>
 (John Snow's message of "Tue, 3 Mar 2026 12:52:42 -0500")
References: <CAFn=p-bNbEwV+1ijfs=+_bCVfexjvN9WRNZwL13Qas+i_HmUBQ@mail.gmail.com>
Date: Wed, 04 Mar 2026 11:46:19 +0100
Message-ID: <87ldg7kh38.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_PASS=-0.001,
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

> Hi, let's recap...
>
> In general, it would be nice to have a strict inter-section ordering
> for a few reasons:
>
> (1) It makes it easier to add generated sections such as return
> values, undocumented members, or undocumented features/flags (such as
> Out-of-band execution), because there is a clear and obvious place
> where we should insert the generated doc. We have a few spots in the
> code now where we have a bespoke algorithm to find the correct
> insertion point, and it would be nice to consolidate this logic.
>
> (2) It makes the inliner easier, because merging two doc sections is
> more obvious when there is a normal order that must be adhered to;
> fields that are absent in one or the other docs list do not cause
> problems or complex edge cases.
>
> (3) It allows us to design around a unified look and layout in the
> HTML generator, which increases visual cohesion and yadda yadda yadda.
> In particular, each "group" of doc types is laid out in a block where
> having multiple fields of the same type be non-contiguous greatly
> increases visual clutter. i.e. all arguments should be contiguous, all
> features should be contiguous, etc. I have in the past referred to
> these groupings of doc section types as "doc regions".
>
> For these reasons, I'd like to nail down the order once and for all,
> and clarify a few things.
>
> The order I think you prefer is something like this:
>
> (1) Introduction ("Plain text", currently) - Always the first section,
> always precisely one section. (But may be multiple paragraphs housed
> within that single section.)
> (2) Arguments/members/values/alternatives
> (3) Return(s)
> (4) Error(s)
> (5) Feature(s)
> (6) Details ("Plain text", currently - generally used for clarifying
> detail, examples, and other information.)

  (7) Since

> Before I go any further, is this order "roughly correct" to you?

Yes!

> ...
>
> We previously discussed prohibiting "plain text" from appearing
> anywhere except in (1) or (6). From memory, the summary of that
> discussion is:
>
> Me: Prohibiting plaintext from appearing between 2-5 makes inlining
> easier, and improves HTML output by preventing plaintext paragraphs
> from interrupting the "tabular" output used to render metadata fields.
>
> You: Although it is not often utilized, we may want the freedom/power
> to use plaintext paragraphs to add addendums/notes attached to
> specific sections, i.e. adding a "Note:" to the tail of the arguments
> section specifically.
>
> I recall we debated this particular restriction quite a few times and
> at length; does this summary sound roughly accurate as far as you
> remember?

It does.

What breaks right now if you prohibit untagged sections between (2) to
(5)?


