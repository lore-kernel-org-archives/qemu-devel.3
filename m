Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EE3606A337
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 06:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GOHThYp3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLE8e-0005im-Vz; Mon, 26 Oct 2026 02:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xLE8d-0005hu-8N
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 02:24:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xLE8b-00055P-Fv
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 02:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792995891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=92mhBjYA1LDuRae1rTnlIToVflITHf5NEuqr4jj3w+g=;
 b=GOHThYp3LocSu9m1mv4dOL52DqFdcV6JW41xtE47/S1MDPd3Q8Z/L0f8yh2SQWWMiRo+7T
 QQvuyZFWicemtQZXOqiF3hLxQL1+XCdlLZT18ucMHMJQDRKnyFgJbrzFdsUajKOTBzMSl/
 05wCK9de06NKGimNXZgl4w/Ml+HukMg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-MmCNoCjGPRCuYPi7mM1_ow-1; Mon,
 26 Oct 2026 02:24:50 -0400
X-MC-Unique: MmCNoCjGPRCuYPi7mM1_ow-1
X-Mimecast-MFC-AGG-ID: MmCNoCjGPRCuYPi7mM1_ow_1792995889
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 082771800842; Mon, 26 Oct 2026 06:24:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 949D8195607F; Mon, 26 Oct 2026 06:24:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1988F21E6A04; Mon, 26 Oct 2026 07:24:46 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org,  qemu-devel@nongnu.org,  Kevin Wolf
 <kwolf@redhat.com>,  John Snow <jsnow@redhat.com>,  "Denis V . Lunev"
 <den@openvz.org>,  Eric Blake <eblake@redhat.com>,  Stefan Hajnoczi
 <stefanha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 02/12] qapi/block: Add IoAccountingOperation enum
In-Reply-To: <4b4bd465-6e37-4db6-9680-ef346beb1244@redhat.com> (Hanna
 Czenczek's message of "Fri, 23 Oct 2026 16:30:22 +0200")
References: <20261019182028.45305-1-hreitz@redhat.com>
 <20261019182028.45305-3-hreitz@redhat.com>
 <87y0bssyie.fsf@pond.sub.org>
 <a29d0076-15ad-49d8-b1a4-0991a07bcaa4@redhat.com>
 <87v76tgdg3.fsf@pond.sub.org>
 <4b4bd465-6e37-4db6-9680-ef346beb1244@redhat.com>
Date: Mon, 26 Oct 2026 07:24:46 +0100
Message-ID: <87o6ch6ksx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hanna Czenczek <hreitz@redhat.com> writes:

> On 23.10.26 08:04, Markus Armbruster wrote:
>> Hanna Czenczek <hreitz@redhat.com> writes:
>>
>>> On 20.10.26 07:59, Markus Armbruster wrote:
>>>> Hanna Czenczek <hreitz@redhat.com> writes:
>>>>
>>>>> This enum gives more information than IoOperationType (which is used =
for
>>>>> the rerror/werror distinction) to identify operation types for block
>>>>> accounting.
>>>>>
>>>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>>>>> ---
>>>>>    qapi/block.json | 20 ++++++++++++++++++++
>>>>>    1 file changed, 20 insertions(+)
>>>>>
>>>>> diff --git a/qapi/block.json b/qapi/block.json
>>>>> index 0a88d405a26..8f4a71733c1 100644
>>>>> --- a/qapi/block.json
>>>>> +++ b/qapi/block.json
>>>>> @@ -629,3 +629,23 @@
>>>>>                'command': 'str' },
>>>>>      'features': [ 'unstable' ],
>>>>>      'allow-preconfig': true }
>>>>> +
>>>>> +##
>>>>> +# @IoAccountingOperation:
>>>>> +#
>>>>> +# I/O operation types as they are tracked by block accounting.
>>>> Can we have a link to suitable docs on block accounting?
>>>
>>> Which do you have in mind?
>>
>> Hey, I asked first!
>
> :)
>
>> Two ideas to find candidates:
>>
>> 1. How is IoAccountingOperation going to be used?
>>
>>     I can see events BLOCK_IO_DELAY and BLOCK_IO_DONE.  Documentation
>>     there calls it "disk operation" in the event description and "I/O
>>     operation" in the argument description.  Not a peep about
>>     "accounting".  Might "tracked by block accounting" be about
>>     implementation?  Or asked differently: why would the user care about
>>     block accounting here?
>
> Good question, the user presumably indeed won=E2=80=99t care. It is only =
going to be used for those two events, so maybe it makes most sense to merg=
e those three patches (`IoAccountingOperation`, `BLOCK_IO_DELAY`, `BLOCK_IO=
_DONE`), so I can immediately refer to those events instead of accounting.

You could also add the enum without a reference, then add references as
you go.  Not sure whether pointing that out in the enum's commit message
would be advisable.

> (The internal reasoning is that I don=E2=80=99t want this to deviate from=
 the existing accounting too much, so that maybe the accounting code can la=
ter be switched to use the same request boundaries as this series introduce=
s, and then switch its enum over to this QAPI variant. But absolutely not r=
elevant to users, correct.)
>
>> 2. Assuming "block accounting" is actually relevant for the user: what
>>     are the QMP interfaces related to it?
>
> The best is probably the `BlockDeviceStats` keys for the different latenc=
y histograms, which could be a map of this new enum to histograms instead=
=E2=80=A6 But given the above, probably best to just drop this.

Makes sense to me.  Thanks!

[...]


