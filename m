Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B1DE77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 07:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVnJD-0002e4-Nw; Thu, 09 Jan 2025 02:50:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tVnJC-0002dM-Dx
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 02:50:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tVnJA-0003Dz-UD
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 02:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736409024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZypQmlz2ory7ZCmy4SunTV+beb9wFPETlsl+aDLaZyc=;
 b=AYB02ftE+7DYxpB5xsuWKylxNxLv/mOUEYhHplc91s2CZs4c0x5+CpPVq1/iL/ayugAU9u
 wpKbMzSJiUhMSnA3zT3nAFcsxjNM0tr4sQB82G9lVCmoYF/UYev2eBp3JBbcrUldoDZlkm
 XGM2+MYqdE67UXpqPNUzI+OUNRwAXQ8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-mNNDE4iUNEqNcafjq3x9NA-1; Thu,
 09 Jan 2025 02:50:20 -0500
X-MC-Unique: mNNDE4iUNEqNcafjq3x9NA-1
X-Mimecast-MFC-AGG-ID: mNNDE4iUNEqNcafjq3x9NA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 90C86195605A; Thu,  9 Jan 2025 07:50:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.101])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17B5619560AA; Thu,  9 Jan 2025 07:50:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 07DF721E6924; Thu, 09 Jan 2025 08:50:12 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 03/23] docs/qapidoc: remove example section support
In-Reply-To: <CAFn=p-a-VVvU32C7qXqEpGDcj9ypKx1fqoJsiurUq9Upkt3xKg@mail.gmail.com>
 (John Snow's message of "Wed, 18 Dec 2024 10:15:56 -0500")
References: <20241213021827.2956769-1-jsnow@redhat.com>
 <20241213021827.2956769-4-jsnow@redhat.com>
 <871py5tbve.fsf@pond.sub.org>
 <CAFn=p-a-VVvU32C7qXqEpGDcj9ypKx1fqoJsiurUq9Upkt3xKg@mail.gmail.com>
Date: Thu, 09 Jan 2025 08:50:12 +0100
Message-ID: <87zfk0toi3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

> On Wed, Dec 18, 2024, 7:27=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > Since 3c5f6114 we no longer actually generate Example sections, so this
>>
>> Suggest s/generate/support/
>>
>
> I meant to say: because the parser doesn't support them, it no longer
> creates such section objects, so there's no need to handle them.

"Since commit 3c5f6114d9f (qapi: remove "Example" doc section), Example
sections no longer exist, so ..."?

>> > support in qapidoc is now dead code.
>>
>> Oversight, I guess.
>>
>
> O:-)
>
>
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>


