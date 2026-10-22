Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30A3606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gHg5WMFa;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Qu87v8Rh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJv96-0005mN-Rn; Thu, 22 Oct 2026 11:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xJv92-0005kU-Sk
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 11:55:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xJv91-0002U1-2I
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 11:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792684554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MaHH4pxbdNnAgyeh1Vhe7D81MzgJIkPFQi9IeylD1oc=;
 b=gHg5WMFap+QQRDBAkU8ib8hiHde4qL/yZtIAGO6ESDxVBx0GdgJWKi0bfPYej3NqkrBwRJ
 HlrCBE7f6tZ9YncBe/3fN0ZEp0JBOgrJCFCTYpx+4D5xdacSC2iVHcJy+oeoZ+7dehSEFh
 NWP1OwaVROAmH1PffJjjaJWsBscSDJ8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-SN7jBq7ENZa9H23yFz0h9Q-1; Thu, 22 Oct 2026 11:55:51 -0400
X-MC-Unique: SN7jBq7ENZa9H23yFz0h9Q-1
X-Mimecast-MFC-AGG-ID: SN7jBq7ENZa9H23yFz0h9Q_1792684550
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a1fdde384cso12319625e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 08:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792684549; x=1793289349; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MaHH4pxbdNnAgyeh1Vhe7D81MzgJIkPFQi9IeylD1oc=;
 b=Qu87v8RhclPZ2YUnTFIs/ZyL4ZqNlz49tOCYI5+C+4i16QVLHBKdj0ffqGU/xjsYS9
 pkHDq3T/rwuZwD6/Hwbl8LrAy+LI99FUODfPwruhnOLTiP3oBtd9At85jw7bTbvqsDHI
 /+bvJoMZndwA3olGMyRAGJiBtAUqgwLBfhlndZIHtirAN+nvcvMPyT5inLXczzpGmG78
 XW59npa3TJ4gbMYNoybfkZsmBsEZnpjSN6wqV2Grs0/zu7w1i2M4tzUAYjdCtm5x3zqw
 GFAgO/k5/VYFR6So46QvFmGT2Si+fy/yGY/viZyoPjAHv7h/dUe2bhNLZxjjYQxV00zz
 oZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792684549; x=1793289349;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MaHH4pxbdNnAgyeh1Vhe7D81MzgJIkPFQi9IeylD1oc=;
 b=QItkHO1qAZotLTWqAQ2okWUzI4KJT3g3fOrRyevAbXqHW29CPZKOzSe9y4xb+8p8H7
 rHgh3t7d9iqvsE1sgJhcu9/zukjs0S8XuqsifgKkpvCX54hXUKy+GcGkJT5gmmzLiTIO
 rVn2yEhQCrp7If+JJhkGi/YFyJaP1yL0FO0/ip2TZfZCQLwE0AyCpjyqao+vgN0Ya4Vv
 wIjUZh5t4DTi9tG+QL1d1AR5xlUhIQGIccxL5FmLopKZAGEVlLaRp1P1jd1kazgimH0+
 8Uz/jHRURN6lsQsMMyYJVNU64kIexd3Pf6C2p2qE1OLHpp0Qd54Krt+SPcGVf3R48vJU
 eHwg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz47tHWRK60imnIpbKwvNHkmlJkwpN3NTGN3KgflpLhXNIBxsOpaH2qopB73627TiA+EXQrHGpHIbnG@nongnu.org
X-Gm-Message-State: AFq9FYJ0XXPHe4jmfXtIjzzDnFfYQPCFW16k/3FLOpdDK+zIHq3sR1/c
 qwK7VLmstkyPFJ2EOKn4jlL0IOcZAiluxcU0H8o2rqFaXryCSR+5QFASWmivXnm9wO9wjd9yb7k
 trzKvbt6ksUQJPtspJcCiuBpw9hXAv9CJJ2yFWB5qJ90bZkHCD4yOaW6n
X-Gm-Gg: AYBFou33RbJR5JqXuGuDm96ADsWPnouRvJTE+bO2peVPUF2swvMRbdaQX6mHhPT1X59
 2DsFJO9idNeJeTQbGzIAqL23Fb6y8k0HkiKrUhZEPCwdkqMAEyADEgSnPE4owYjOZssGMQvgD+2
 k+Izw+nfQ6TqYBgbrnv2PSvOuAk9omDzjHik1PaTQB9oe9vxr0WQbCYkh1hyCb7uKW3vUZj5zx/
 CDbkqwP/qNa1yrhcuFgOjh73hKzWn9jmBwePYLd2bYNWiZnDc2Xmq0C20+e2b9jHO93658WmBB4
 fh35dHlM1zpyhL2duYuWLAl3A4KLh+ErWJkhr3qisgNgEl49OwMMkRuHT2p/4XGVY0qobyjIyZC
 4SCB0xOSRwK5MqjOe8YU1lQ13FZIENTCnQw==
X-Received: by 2002:a05:600c:c11b:b0:4a1:f736:79f3 with SMTP id
 5b1f17b1804b1-4a1fdd0b261mr97898125e9.5.1792684549346; 
 Thu, 22 Oct 2026 08:55:49 -0700 (PDT)
X-Received: by 2002:a05:600c:c11b:b0:4a1:f736:79f3 with SMTP id
 5b1f17b1804b1-4a1fdd0b261mr97897855e9.5.1792684548974; 
 Thu, 22 Oct 2026 08:55:48 -0700 (PDT)
Received: from [192.168.192.3] (p4fdeb9e7.dip0.t-ipconnect.de.
 [79.222.185.231]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a21029c9b2sm5780515e9.2.2026.10.22.08.55.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 08:55:48 -0700 (PDT)
Message-ID: <65193d93-2fcc-4a39-8e54-d16022855bbf@redhat.com>
Date: Thu, 22 Oct 2026 17:55:47 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] qapi/block: Add BLOCK_IO_DELAY event
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20261019182028.45305-1-hreitz@redhat.com>
 <20261019182028.45305-7-hreitz@redhat.com> <87a4o8sw79.fsf@pond.sub.org>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <87a4o8sw79.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 20.10.26 08:49, Markus Armbruster wrote:
> Hanna Czenczek <hreitz@redhat.com> writes:
>
>> This event will be emitted when a disk operation takes longer than a
>> pre-defined threshold (as set on the block device).
>>
>> Note that the description refers to the "delay-report-ns" and
>> "delay-stop-ns" block device properties, which are not yet available.
>> A future commit in this series will add them.
>>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>>   qapi/block.json | 37 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>
>> diff --git a/qapi/block.json b/qapi/block.json
>> index 8f4a71733c1..5f9f5c28050 100644
>> --- a/qapi/block.json
>> +++ b/qapi/block.json
>> @@ -649,3 +649,40 @@
>>   ##
>>   { 'enum': 'IoAccountingOperation',
>>     'data': [ 'read', 'write', 'flush', 'zone-append', 'unmap' ] }
>> +
>> +##
>> +# @BLOCK_IO_DELAY:
>> +#
>> +# Emitted when a disk operation takes longer than the pre-defined
>> +# threshold (as set via the "delay-report-ns" / "delay-stop-ns"
>> +# properties on the block device).
> As in PATCH 01, "block device" could be confusing, because we use the
> term both for frontends and backends.  I believe "delay-report-ns" and
> "delay-stop-ns" are the qdev properties every block device model will
> have [PATCH 11].

Sure. So… “block device model”, or “on -device”?

>> +#
>> +# Note that delays deliberately incurred by throttling do count
>> +# towards the operation duration.
>> +#
> Please use the revised syntax for introductions, like you did in PATCH
> 01:
>
>     # @name: introduction, best to keep it brief, but you may continue it
>     #     like this if necessary.  If your text need to refer to
>     #     arguments, it's almost certainly not brief introduction
>     #     anymore.
>     #
>     # Additional text can go here for now.
>
> I apologize for the inconvenience.  We need this to eliminate certain
> syntactic ambiguities that plagued the doc generator.  We'll need it
> some more for the doc inliner.

Sure!

>> +# @qom-path: path to the block device object in the QOM tree
>> +#
>> +# @operation: I/O operation
>> +#
>> +# @latency-ns: Ongoing duration of the operation (in nanoseconds)
>> +#
>> +# @action: Action that has been taken ("report" for "delay-report-ns"
>> +#     or "stop" for "delay-stop-ns").  A "stop" action means the VM
>> +#     will be stopped with the "io-hang" `RunState`, which does not
>> +#     drain the block devices attached to the VM, because draining
>> +#     would be counterproductive in case of a hanging I/O request.
> This feels less than clear.  What exactly happens?  My best guess:
>
> * When an operation takes longer than delay-report-ns, BLOCK_IO_DELAY is
>    emitted with "action": "report" (but only once for this operation).
>
> * When an operation takes longer than delay-stop-ns, the guest is
>    stopped (run state becomes io-hang), and BLOCK_IO_DELAY is emitted
>    with "action": "stop".
>
>    Say we continue the guest.  Can the even be triggered again for this
>    operation?

No, because latency starts when the request begins, and the event (and 
action) happen only when that threshold is crossed.

I can try to be more clear.

> The three possible values are ignore, report, and stop.  You cover
> report and stop.  Can ignore happen?

No, it cannot. (Also by definition of `ignore` meaning to… ignore 
something. So an event cannot carry this.)

> We should use ``literal`` markup for literal values.

Sure.

Hanna

>> +#
>> +# @offset: Request offset in the guest disk (in bytes), if available
>> +#
>> +# @bytes: Request length
>> +#
>> +# Since: 11.2
>> +##
>> +{ 'event': 'BLOCK_IO_DELAY',
>> +  'data': {
>> +      'qom-path': 'str',
>> +      'operation': 'IoAccountingOperation',
>> +      'latency-ns': 'uint64',
>> +      'action': 'BlockErrorAction',
>> +      '*offset': 'uint64',
>> +      'bytes': 'uint64' } }


