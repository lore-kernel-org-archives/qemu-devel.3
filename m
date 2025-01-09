Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B391CE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 10:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVptf-0002Ke-GA; Thu, 09 Jan 2025 05:36:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tVptV-0002K0-4b
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 05:36:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tVptT-0005FI-P3
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 05:36:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736418960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jai8jvUDA1gIzaSIcxh6F5HonR30p3ctLIBQLS6kYAs=;
 b=NNmXxjhYUYmgYpnNB2m+QIyTa0/x289ni73lNnJFgKfNSTO8aEdHbGuvXoCzn6wzDumcSG
 zsvgu1894I8iQNimE4jqFrqLDutEF4PhVYP9Bm355BqtVmlmnmPKfWTn0Z/HKf5O8ymT2t
 33rFRnLclAxvR9nI99nMV1OYBPFXP54=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-lJs8w9XnMbCs3hAKMyDnCA-1; Thu,
 09 Jan 2025 05:35:57 -0500
X-MC-Unique: lJs8w9XnMbCs3hAKMyDnCA-1
X-Mimecast-MFC-AGG-ID: lJs8w9XnMbCs3hAKMyDnCA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5819F1955DCB; Thu,  9 Jan 2025 10:35:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.101])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C1EFC19560AB; Thu,  9 Jan 2025 10:35:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 881CB21E6924; Thu, 09 Jan 2025 11:35:53 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 17/23] docs/qapidoc: record current documented entity in
 transmogrifier
In-Reply-To: <CAFn=p-Y4AwYfgCVAWJ-tTCjnr0dwJ6EOnF4aNYXdd5VPTr__DQ@mail.gmail.com>
 (John Snow's message of "Wed, 8 Jan 2025 16:11:24 -0500")
References: <20241213021827.2956769-1-jsnow@redhat.com>
 <20241213021827.2956769-18-jsnow@redhat.com>
 <878qsa302b.fsf@pond.sub.org>
 <CAFn=p-Y4AwYfgCVAWJ-tTCjnr0dwJ6EOnF4aNYXdd5VPTr__DQ@mail.gmail.com>
Date: Thu, 09 Jan 2025 11:35:53 +0100
Message-ID: <87o70gs29i.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> On Fri, Dec 20, 2024 at 9:23=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > Keep a record of which entity we're working on documenting for the
>> > purposes of being able to change certain generative features
>> > conditionally and create stronger assertions.
>> >
>> > If you find yourself asking: "Wait, but where does the current entity
>> > actually get recorded?!", you're right! That part comes with the
>> > visit_entity() implementation, which gets added later.
>>
>> That's fine, except your title promises "record current documented
>> entity".  Perhaps "Prepare to record entity being transmogrified".
>>
>
> Sometimes, I think I exist in a time and space that doesn't actually exis=
t;
> a hallucination of multiple timelines that might exist only in my own
> consciousness. I'd be worried if I wasn't an ardent solipsist.

I'm glad I haven't caused you worry!  Perhaps I should try this
solipsism thing myself some day.

[...]


