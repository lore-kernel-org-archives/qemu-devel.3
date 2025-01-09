Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EF5E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 07:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVnK2-0003n8-Dg; Thu, 09 Jan 2025 02:51:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tVnK0-0003bc-ML
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 02:51:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tVnJy-0003Gs-RA
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 02:51:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736409073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tjSuT0kY8QNGbOuoFXAnOW4GSaVB62S0qTy26jM0z+E=;
 b=aGP20iQwHPffSPsOiQzVHenkjdAPOsdhx9Uib4EOThDlhIxaXZfUYwIKvW5sQnnTg3dIKq
 dx3xo1jzuJuhd6ww5+hNXQYUXjZucDd4OF+DXCsb0ZSa4+ysp8nC1A2LBKMwwXH5+c3PYZ
 yhjT8v/7CmFBkdWqnSIpuqykfIJyhlg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-07vM2EuHPraX_McdQtG49A-1; Thu,
 09 Jan 2025 02:51:09 -0500
X-MC-Unique: 07vM2EuHPraX_McdQtG49A-1
X-Mimecast-MFC-AGG-ID: 07vM2EuHPraX_McdQtG49A
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0B931955DCD; Thu,  9 Jan 2025 07:51:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.101])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D5AE1954B24; Thu,  9 Jan 2025 07:51:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2CEEE21E6924; Thu, 09 Jan 2025 08:51:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 04/23] qapi: expand tags to all doc sections
In-Reply-To: <CAFn=p-Y3YVCLCtLWH4hfUW=GkuZ1JjrMu9yuCD_WsmeF3x0Gwg@mail.gmail.com>
 (John Snow's message of "Wed, 18 Dec 2024 10:14:22 -0500")
References: <20241213021827.2956769-1-jsnow@redhat.com>
 <20241213021827.2956769-5-jsnow@redhat.com>
 <87y10dtg06.fsf@pond.sub.org>
 <CAFn=p-Y3YVCLCtLWH4hfUW=GkuZ1JjrMu9yuCD_WsmeF3x0Gwg@mail.gmail.com>
Date: Thu, 09 Jan 2025 08:51:05 +0100
Message-ID: <87v7uotogm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

> On Wed, Dec 18, 2024, 5:58=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
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
>> Doesn't pass 'make check' for me.  Diff appended.  It shows the error
>> messages get worse.
>
> Whoops! My per-patch tester wasn't running make check, only linters and
> build testing. I'll fix this, but please keep reviewing in the meantime.
>
> Apologies for the oversight.

No worries :)


