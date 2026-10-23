Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0B9606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MRoE0nR1;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=tiZZox8F
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGLJ-0002Tf-QN; Fri, 23 Oct 2026 10:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xKGLD-0002TB-Cc
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:33:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xKGLB-0000Cl-GN
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792766032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C0y6eQe48lbRc/t5GAI2UELlG4T4DoxqBmDw65V0D9Y=;
 b=MRoE0nR17Nlq/Zj9QTz+rA7Te5eipJl3O5k/z93nMx74Ynyinp00f0kUnJ55JTo019uMIZ
 EJH81+GBi9cxxPaDcGP4989/RE4Cu4DVcdu0aCWFoRyY7GaIn3CErdjeZBby80JrQR8UMY
 bp7SNsyaXaAg2EQbQdaznuprjdIRyws=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-0PHY0cedNX2O7B3WFZYmUw-1; Fri, 23 Oct 2026 10:33:49 -0400
X-MC-Unique: 0PHY0cedNX2O7B3WFZYmUw-1
X-Mimecast-MFC-AGG-ID: 0PHY0cedNX2O7B3WFZYmUw_1792766028
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48e1291432aso626259f8f.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792766028; x=1793370828; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=C0y6eQe48lbRc/t5GAI2UELlG4T4DoxqBmDw65V0D9Y=;
 b=tiZZox8FyeEJAcvGoQADi0UGimdgzYkifNe5YHGvt2/KHRm4KW9QD0yftGyZQf5xp7
 bBx152FHSreEWiT8H9breB/SmsSBFY7HAuyNGErRc8bzlLpMPg30gfJWtZIvvrEXBced
 /jmca/4YVp+DfqQX+ga6K/tyIWUTZ+1yvuK4kooJfE7s+hmQoU2yjEr5Sb07n6pM8+Gg
 E2U/wyoqINmXS95LnO9MGPc4o7h0sP72boXNzojRg5Mtg/pQW0Or8eVrsjqzCLA8dlIK
 Dt03fvXjGYNFqxzLu9+CKbN1WGvkUFfhPR1qtZD2vtfKa6IC4mW15v7fpZ77gnl0bAFM
 4T6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792766028; x=1793370828;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C0y6eQe48lbRc/t5GAI2UELlG4T4DoxqBmDw65V0D9Y=;
 b=sPQfORT0uYEkEiy5c8x4pUHHzukUTOh64FoxiMN4nRQJJRP/uQtfnp5vJ6UAtNScAv
 h102Nbhhb0j6jLWr/I8HoAnqxpw9ElOoEtlB1bIylcXTr1PB9o5wwW/fbKld52YSreoO
 5kTy/yvwg7IaSWbhnTru0OIJpuwFM0x5Iy+FVRaRCGnBr7rt1boY6mL+Rsjsc35r3ADL
 Xe8Fap3/jJlP4yE867HsB/Hfq8nkwKvD7jCAlJ6SNz6eceYwlBuTuoeKmBRcUvqpdFR7
 TRgqqf4fnFcQkv2MHvTKF4w/0q7Db3zG829D27zxWPXlxSrJoVYIRi7eXz6f0ctCE2Ux
 bK2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwaxJU1azzeFWxlQW8wyrMdNur2p91aoeSNFzWw3t7qOjXgKfR92D8uC3k4QZa0+3Nzykp0Xxggky0S@nongnu.org
X-Gm-Message-State: AFq9FYJf0/bbnQEYOFJrBZRgGmeBwFTewrKNhxcjcKaZ+iHtFneA0nzq
 Jj4Bb08MqKGdZ5nbB1ufkvZriOX6E/ZUI5JiUadlK0vbqd3y/BzD0gvgxI45FlHhQ5Aq+b9pvhz
 Xlo5dNL5+BkSPzmfa1Nj7r7pPX8bJgHMXbQQplWgxlrxPAEW3wrTCwiMj
X-Gm-Gg: AYBFou2aYVQ/YA4vxkWwchmd7bhx8+gkQSbE9l2sJZediPwsjhOh8Fplqo4wWXPvmCs
 9ad262rycVHqntX9Tq2X3IzTpfZ404ZDjUwjkUZMVRmU4HDXBH39gyzmYNRF0QiKtKvnqpHt7DS
 04cHn8wgkoISskySeu5hDMnM/V6j5rPDFziYqnDkIhOmF4jycL9DhThcu2nFDgibFh4qHjUKA7B
 MExIfArTun/Px2+hxnZlDIcKPbeGYmHm1+gQcech6qmlmJuJp+oZLgywWi7fGEvbUpkJ83vg/S2
 PjizjHMg5K3+bAbpGDZik0IIkwH1bQ9uuIYl/+HVQFOZe0rbzjwMU5oJ7u2y0wjScRzjA776Gyq
 aufkohEh9o2tOLleO/LGjlUdZl6ZAVjO9oQ==
X-Received: by 2002:a05:600c:1391:b0:4a1:e250:b191 with SMTP id
 5b1f17b1804b1-4a211f0e0d5mr42594955e9.17.1792766027907; 
 Fri, 23 Oct 2026 07:33:47 -0700 (PDT)
X-Received: by 2002:a05:600c:1391:b0:4a1:e250:b191 with SMTP id
 5b1f17b1804b1-4a211f0e0d5mr42594455e9.17.1792766027383; 
 Fri, 23 Oct 2026 07:33:47 -0700 (PDT)
Received: from [192.168.192.3] (p4fdeb9e7.dip0.t-ipconnect.de.
 [79.222.185.231]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a29cd9d232sm9812745e9.4.2026.10.23.07.33.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 07:33:46 -0700 (PDT)
Message-ID: <44691c04-0bd0-48de-afc5-56f2cddd5662@redhat.com>
Date: Fri, 23 Oct 2026 16:33:45 +0200
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
 <65193d93-2fcc-4a39-8e54-d16022855bbf@redhat.com>
 <87pkx1gczk.fsf@pond.sub.org>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <87pkx1gczk.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 23.10.26 08:14, Markus Armbruster wrote:
> Hanna Czenczek <hreitz@redhat.com> writes:
>
>> On 20.10.26 08:49, Markus Armbruster wrote:
>>> Hanna Czenczek <hreitz@redhat.com> writes:
>>>
>>>> This event will be emitted when a disk operation takes longer than a
>>>> pre-defined threshold (as set on the block device).
>>>>
>>>> Note that the description refers to the "delay-report-ns" and
>>>> "delay-stop-ns" block device properties, which are not yet available.
>>>> A future commit in this series will add them.
>>>>
>>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>>>> ---
>>>>    qapi/block.json | 37 +++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 37 insertions(+)
>>>>
>>>> diff --git a/qapi/block.json b/qapi/block.json
>>>> index 8f4a71733c1..5f9f5c28050 100644
>>>> --- a/qapi/block.json
>>>> +++ b/qapi/block.json
>>>> @@ -649,3 +649,40 @@
>>>>    ##
>>>>    { 'enum': 'IoAccountingOperation',
>>>>      'data': [ 'read', 'write', 'flush', 'zone-append', 'unmap' ] }
>>>> +
>>>> +##
>>>> +# @BLOCK_IO_DELAY:
>>>> +#
>>>> +# Emitted when a disk operation takes longer than the pre-defined
>>>> +# threshold (as set via the "delay-report-ns" / "delay-stop-ns"
>>>> +# properties on the block device).
>>> As in PATCH 01, "block device" could be confusing, because we use the
>>> term both for frontends and backends.  I believe "delay-report-ns" and
>>> "delay-stop-ns" are the qdev properties every block device model will
>>> have [PATCH 11].
>> Sure. So… “block device model”, or “on -device”?
> For PATCH 01, I suggested additional text that makes the meaning
> obvious:
>
>      These are the properties "rerror" and "werror" certain block device
>      models have.
>
> Here, you have something similar already.  I think "on the block device
> model" would do.  Or maybe "the block device model's ``delay-report-ns``
> / ``delay-report-ns`` properties".

Great, thanks.

>>>> +#
>>>> +# Note that delays deliberately incurred by throttling do count
>>>> +# towards the operation duration.
>>>> +#
>>> Please use the revised syntax for introductions, like you did in PATCH
>>> 01:
>>>
>>>      # @name: introduction, best to keep it brief, but you may continue it
>>>      #     like this if necessary.  If your text need to refer to
>>>      #     arguments, it's almost certainly not brief introduction
>>>      #     anymore.
>>>      #
>>>      # Additional text can go here for now.
>>>
>>> I apologize for the inconvenience.  We need this to eliminate certain
>>> syntactic ambiguities that plagued the doc generator.  We'll need it
>>> some more for the doc inliner.
>> Sure!
>>
>>>> +# @qom-path: path to the block device object in the QOM tree
>>>> +#
>>>> +# @operation: I/O operation
>>>> +#
>>>> +# @latency-ns: Ongoing duration of the operation (in nanoseconds)
>>>> +#
>>>> +# @action: Action that has been taken ("report" for "delay-report-ns"
>>>> +#     or "stop" for "delay-stop-ns").  A "stop" action means the VM
>>>> +#     will be stopped with the "io-hang" `RunState`, which does not
>>>> +#     drain the block devices attached to the VM, because draining
>>>> +#     would be counterproductive in case of a hanging I/O request.
>>> This feels less than clear.  What exactly happens?  My best guess:
>>>
>>> * When an operation takes longer than delay-report-ns, BLOCK_IO_DELAY is
>>>     emitted with "action": "report" (but only once for this operation).
>>>
>>> * When an operation takes longer than delay-stop-ns, the guest is
>>>     stopped (run state becomes io-hang), and BLOCK_IO_DELAY is emitted
>>>     with "action": "stop".
>>>
>>>     Say we continue the guest.  Can the even be triggered again for this
>>>     operation?
>> No, because latency starts when the request begins, and the event (and action) happen only when that threshold is crossed.
> So it can be triggered once for @delay-report-ns, and once for
> @delay-stop-ns.  Correct?

Yes, correct.

> In sane usage, @delay-report-ns < @delay-stop-ns.  Correct?

Well, uh, I suppose. The opposite could be imagined, but if someone 
wants that, that might rather indicate they would really want an array 
of thresholds rather than a single one, so… As long as we just have a 
single reporting threshold, `@delay-report-ns < @delay-stop-ns` is the 
sane usage, yes.

>> I can try to be more clear.
>>
>>> The three possible values are ignore, report, and stop.  You cover
>>> report and stop.  Can ignore happen?
>> No, it cannot. (Also by definition of `ignore` meaning to… ignore something. So an event cannot carry this.)
> Try mentioning this.  If the text feels worse then, don't.

Sure!

Hanna

>>> We should use ``literal`` markup for literal values.
>> Sure.
>>
>> Hanna
>>
>>>> +#
>>>> +# @offset: Request offset in the guest disk (in bytes), if available
>>>> +#
>>>> +# @bytes: Request length
>>>> +#
>>>> +# Since: 11.2
>>>> +##
>>>> +{ 'event': 'BLOCK_IO_DELAY',
>>>> +  'data': {
>>>> +      'qom-path': 'str',
>>>> +      'operation': 'IoAccountingOperation',
>>>> +      'latency-ns': 'uint64',
>>>> +      'action': 'BlockErrorAction',
>>>> +      '*offset': 'uint64',
>>>> +      'bytes': 'uint64' } }


