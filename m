Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86380606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YbYYZ5PW;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=sd9duLMf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKGPX-0003Co-AK; Fri, 23 Oct 2026 10:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xKGPQ-0003BH-Rf
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:38:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xKGPP-0000ZR-1D
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792766293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4gdgBK1tV3AcHoWYDOzBxPGWS2aYarrMGNGNny8EjMI=;
 b=YbYYZ5PWyjE+Uflt6KQaYz576vw8VRQA/f44GqQPQaNnVtthandRQ+ZI8pqrgdZCm8ZJ72
 /aeXOdPI0X7rnP5gwJp3TC0YFXpsm+fyItrC4sEXSuGjc3qGkHfsK+natKmLvIZPQA9gQ4
 gjq/MmT7BGWc2zyJ+G6i+0vd8z7P36c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-defiAAaKNpaLgCNIwsgYhg-1; Fri, 23 Oct 2026 10:38:12 -0400
X-MC-Unique: defiAAaKNpaLgCNIwsgYhg-1
X-Mimecast-MFC-AGG-ID: defiAAaKNpaLgCNIwsgYhg_1792766291
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48e0389d6f9so578659f8f.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792766291; x=1793371091; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4gdgBK1tV3AcHoWYDOzBxPGWS2aYarrMGNGNny8EjMI=;
 b=sd9duLMftSDpJojEtA8fE6TB0X8fa52olUgyISC+7996lUknr42aIPUX1J9APDChiP
 zXQ9Ap13MPQCpn8WVFJrLEMWkXfpVd2PkKTftCh6U3uqfKZ1BIFEXHPc8IuEZDreCCGc
 A5Sp1t/NnNRt25JKiijVsMXK/uqqtyBgbM6yaNM/D756YpRBL58d8UIVJmokPMnZ0FZt
 l0zAd5TeInhcP/1icfP2hLs0saKxk9j+qQ+i1EaNGMiybzHzheOrFWdd3STbzFQYKf0A
 tJGvwbBVmBhhx2BH1qf1yWYrtMLZjEHeeKNbRwu5ISJhhFAqwNy3Jz/ogj42Dh+EBKJA
 bT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792766291; x=1793371091;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4gdgBK1tV3AcHoWYDOzBxPGWS2aYarrMGNGNny8EjMI=;
 b=wHKDIFgaXhYZzmVYch3tX7Lc8M7T2KpznUILlVxPxS00yoBmuxjIzYunZiXdHnz2kA
 iPLRbqZXGWXYyBWXlrf5SO6adm1jw1i3NLe/hl8Bkr2f3zNZA+Kn/ojiJyduBbH7Vvs+
 XKEET07qdZUUdIMtmXI0jtyAkRcoM7o7pon6oqf/rBObsuBj1MRoYi+E6i5Mfufj28KK
 G4n8hVzIVSkBJ2umApGYXxbASkCoY6nWaOJF63L6ygInVxmJgY5p2/e1W8oW01GPSiGL
 c7D8OeJJvKHiUBHtovrsymRnmFJtjFRH9egUmnzOqg7w/65SuIIioqp1SQo1ocTsRVAE
 RkzQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzxsNegtn1njAPg6jNY3azzFbUzReOuoVrrqxmyjyl/X/fwjmUID57ZJTArOMtJy3unhTOqlZ0w5zHg@nongnu.org
X-Gm-Message-State: AFq9FYJRflppDGVD/XotE2j+HrfBpvzJMW7Hgk+e0zq+FLDFov6ATon7
 xUpOdmtM0NPsDaD4jfVCZ/4vqlNNxwgAqGYmVHm6gC6N4A+MRm+v58oYWskKBPkHEDN7kzIB8qJ
 /2mKJNt/MNnvUV0dIsPvJcV7rEJ3MZQZJkd5FJv5M9pgnRMHV9inNJhBt
X-Gm-Gg: AYBFou18acvNFkAc3d0NuN1KcQ7e4SJ2R+h6B0SRo8DNvG/ClGjzkrTjmiNyNZiLaLw
 o6g4sf9xFZ1CR7QiDKDSgzwwkgJYeTSRcH7jj8hg872LcaM7pLUu586Cz/3yOIvNUlY/ixvAejW
 3XvVfOomMK/tioEzZ2P8uRCyuSrSalAjsw/YN6UpXRnny/hWB6sQlo272D7lAveEjxy0ERlC5SY
 dsWkksL7OKBpDPLrQmbkHBRVe3S3kCKIGhJWp2QA2cJ0VhNy3QUlKZlm7GRnqrReMJ8V24eACon
 qkZ2Fe5G/c7rEWC+/ICUo5y1ZTYPf0AHNk9bGOmrYGndDU6RhUsHdUl8uwb8U9NWIBDgKGW0j6+
 cn3odoeDVwsoLZ6vaqPODiyJx0rMaDaTnxg==
X-Received: by 2002:a5d:5d86:0:b0:48d:f851:ee5f with SMTP id
 ffacd0b85a97d-48e385ab429mr3889079f8f.24.1792766290698; 
 Fri, 23 Oct 2026 07:38:10 -0700 (PDT)
X-Received: by 2002:a5d:5d86:0:b0:48d:f851:ee5f with SMTP id
 ffacd0b85a97d-48e385ab429mr3889041f8f.24.1792766290281; 
 Fri, 23 Oct 2026 07:38:10 -0700 (PDT)
Received: from [192.168.192.3] (p4fdeb9e7.dip0.t-ipconnect.de.
 [79.222.185.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d37ca2asm284592f8f.8.2026.10.23.07.38.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 07:38:09 -0700 (PDT)
Message-ID: <e930ae0d-cf1e-4441-85ab-109db4a57fcf@redhat.com>
Date: Fri, 23 Oct 2026 16:38:08 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/12] qapi/block: Add BLOCK_IO_DONE event
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20261019182028.45305-1-hreitz@redhat.com>
 <20261019182028.45305-8-hreitz@redhat.com> <871p9ksvx5.fsf@pond.sub.org>
 <e89f7bfb-8da2-495d-b9a4-0adf3fe58f80@redhat.com>
 <87ld7pgcsy.fsf@pond.sub.org>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <87ld7pgcsy.fsf@pond.sub.org>
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

On 23.10.26 08:18, Markus Armbruster wrote:
> Hanna Czenczek <hreitz@redhat.com> writes:
>
>> On 20.10.26 08:55, Markus Armbruster wrote:
>>> Hanna Czenczek <hreitz@redhat.com> writes:
>>>
>>>> This event is emitted when an operation completes, for which a
>>>> BLOCK_IO_DELAY event has previously been emitted.
>>>>
>>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>>>> ---
>>>>    qapi/block.json | 33 +++++++++++++++++++++++++++++++++
>>>>    1 file changed, 33 insertions(+)
>>>>
>>>> diff --git a/qapi/block.json b/qapi/block.json
>>>> index 5f9f5c28050..38f293dd32d 100644
>>>> --- a/qapi/block.json
>>>> +++ b/qapi/block.json
>>>> @@ -660,6 +660,9 @@
>>>>    # Note that delays deliberately incurred by throttling do count
>>>>    # towards the operation duration.
>>>>    #
>>>> +# This event will only be emitted once per request and action.  When
>>>> +# the operation does finish, a `BLOCK_IO_DONE` event is emitted.
>>> I think the first sentence answers a question I had on the previous
>>> patch.  Move it there?
>> Sure.
>>
>>>> +#
>>>>    # @qom-path: path to the block device object in the QOM tree
>>>>    #
>>>>    # @operation: I/O operation
>>>> @@ -686,3 +689,33 @@
>>>>          'action': 'BlockErrorAction',
>>>>          '*offset': 'uint64',
>>>>          'bytes': 'uint64' } }
>>>> +
>>>> +##
>>>> +# @BLOCK_IO_DONE:
>>>> +#
>>>> +# Emitted on completion for disk operations that previously emitted a
>>>> +# `BLOCK_IO_DELAY` event.
>>> Can we have multiple operations in flight that previously emitted
>>> BLOCK_IO_DELAY?
>>>
>>> If yes, might a management application need to connect the BLOCK_IO_DONE
>>> back to the BLOCK_IO_DELAY?
>>>
>>> If yes, how could it do that?
>> Well, the combination of device, operation, offset, bytes.
>>
>> Do you think there should be an ID like a u64 counter per BlockBackend?
> I'm not overly particular on how exactly the connection can be made.  If
> the quadruple you suggested always suffices, that's good enough for me.
> Documentation should point it out, though.
>
> Can multiple operations with the same (device, operation, offset, bytes)
> be in flight?

Technically, sure.

Adding an ID is quite ugly, I feel like, which is why I would need your 
input in how it would be least intrusive in QAPI.

(Caveat, at this point: I’m afraid I’ll be quite far from my notebook 
for around four weeks… Thank you for your help so far :))

>>> Please use the revised syntax for introductions:
>>>
>>>      ##
>>>      # @BLOCK_IO_DONE: Emitted on completion for disk operations that
>>>      #     previously emitted a `BLOCK_IO_DELAY` event.
>> Sure.
>>
>>>> +#
>>>> +# @qom-path: path to the block device object in the QOM tree
>>>> +#
>>>> +# @operation: I/O operation
>>>> +#
>>>> +# @latency-ns: Full duration of the operation (in nanoseconds)
>>>> +#
>>>> +# @offset: Request offset in the guest disk (in bytes), if available
>>> Out of curiosity: when could @offset be unavailable?
>> For flushes.
> Uh, what's @bytes then?

0. I found that natural. Any offset value is a valid offset, but a value 
of 0 for bytes sounded good to me.

I now anticipate discomfort with this, so I can make @bytes optional, 
too, yes.

Hanna

>>>> +#
>>>> +# @bytes: Request length
>>>> +#
>>>> +# @failed: If true, this request failed for any reason.  If false, the
>>> Suggest "for some reason".
>> Sure!
>>
>> Hanna
>>
>>>> +#     request succeeded.
>>>> +#
>>>> +# Since: 11.2
>>>> +##
>>>> +{ 'event': 'BLOCK_IO_DONE',
>>>> +  'data': {
>>>> +      'qom-path': 'str',
>>>> +      'operation': 'IoAccountingOperation',
>>>> +      'latency-ns': 'uint64',
>>>> +      '*offset': 'uint64',
>>>> +      'bytes': 'uint64',
>>>> +      'failed': 'bool' } }


