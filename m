Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CF5606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fcK/hl9k;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=OWwWfiXA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJtFa-0005kQ-Br; Thu, 22 Oct 2026 09:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xJtFP-0005gY-I9
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:54:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xJtFN-00068P-Gj
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792677256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PbQVL3ouVRj7XRF4QSHu1X0K+eYA9AG+RNkc9GOj/Gg=;
 b=fcK/hl9kSFqDejgf5/T2tKs6c8b7aO5M3OYnAgqItt+C1C6kMxYIfHIDVFzokm7cZrdCRu
 TO114fDw075M4MiowwBm6e6f6WgHwUbCYmIroJ9M9f2tjVjqXAzveqrldr6YNoo+uxwS8d
 pH+u3Ny1Mqvj/TlhBRhShuPRusIaiYo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-KyFwP3ZqMQmzgsAZ7G5nDw-1; Thu, 22 Oct 2026 09:54:15 -0400
X-MC-Unique: KyFwP3ZqMQmzgsAZ7G5nDw-1
X-Mimecast-MFC-AGG-ID: KyFwP3ZqMQmzgsAZ7G5nDw_1792677254
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48c4445512dso1734287f8f.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 06:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792677254; x=1793282054; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PbQVL3ouVRj7XRF4QSHu1X0K+eYA9AG+RNkc9GOj/Gg=;
 b=OWwWfiXA3LjDBgrHfMWmEheLfRBCrC89PxkHY96hKPuprIPXh8gZWjAuZN88KIVU3v
 ipbqXCzDEZ+fBNtYmbTt7BK5bssYr7Bd0kHGLCp7P7TW2WhHAJ5c8B3SLeuLkdSgfN89
 XIEqxdqjbw5K9xuS1mwo6rZHTzJaKq88Semi36K/zAc5wRMPTQYHympgWuWN01xmhpZ+
 ybBZ/MAPYiYom7YhrWSIHXnmyXu7dHbUouK91B7rVdewkPGCoLIApTPzj3HePtGQlt0N
 qhKpw1f4bEWbRd1t1z0dkWPTXFO2Q1XqbY1u7adcC67lC4O9siULpxjaRr0GRYd+DpXV
 Hzlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792677254; x=1793282054;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PbQVL3ouVRj7XRF4QSHu1X0K+eYA9AG+RNkc9GOj/Gg=;
 b=t/LOsDniHpWKuk2dlA5ya32czjioqP/4k4hHFB+jHbcrzMxidk4053Abd8PLJuk9ED
 aj7vPy2Jx79BKRpETqnlQE8C3aUYzNRt9jWPPFg/OrD+5FQyZ14+OxLaykxta8oaU3k+
 fnOsly4M55QHd7ElzWU+t5Gba0QhE3Pkn+up9jRcp1oboMZv0FfPxXHrQP3+hnE9UM7h
 iraVfzPugIJ6WVqCpFJtwotFgU+dWgVT9xqZ1w71KDZraOb3K2DKaoz+qx9Fin8ntb7o
 NI1ZIQH6PXuj20/gbsIYBKMVZ9ncVaYinv2uBJKCiVW52nlFC9/1gbAsJpOc9OqbWpfz
 yRhg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwkl5JxK5atxEl6/euIstxF3i3DBOUTfSyuoqwjPlMNVdbODLmjRJ+e0xnGbZ5NWruajKT3sh/2Cmjh@nongnu.org
X-Gm-Message-State: AFq9FYLcSmQ7QgGS0UCNnnIKAo8cYxQHeg26WvwID82V4ZipWU8KnhcT
 YUFRYlso+xq/8gajhhKztcmf0Jj/+XondLCFNUD8xvB6feYcPvqpUd7evAM9K+GBCeZvTm1kFzD
 RRCmJGtNja4HLmlRHPwu5fmvC5MyrFkDWqplvM0C7KzFBMAsDzJnYc5fj
X-Gm-Gg: AYBFou016m8mnupG73r9jEmTSqKgVdkalxetSQPIHDPeFwFI0m8q09LudYF3fn03eW2
 oCuH0TOleZ8n7EzSA/VKE6s5pPNN3ws6EqaNWTMkzE4/1ERcvxnYd8YW4ejzeMOtbRYzQzKo0CX
 JakjwbAu7MC6iZWmhdgcX/B9YEY1f08S2NxByYRDuTAO8yUK3TWFSAjwXWI2vZiPdoPKna2S1y6
 nRk8YyCVFsIbJQMkVoEQUp+dGKQnWvg1/SOW0r9j8u/bWKKObUhbaHFbUnR27O8lbxjuW+X/jqs
 PeB0ZhdGx04jnThaaOttUTJCLv9v/ijRabciuKmXX06jEaJDDLLq4Oe+uPAdnApNpbSTJoHZ8za
 mT3IOuWpzhA+HqYgQD+ho8bjas/I6I5Ip5Q==
X-Received: by 2002:a05:6000:4811:b0:48a:eeb7:5e5c with SMTP id
 ffacd0b85a97d-48e26495a36mr11246504f8f.32.1792677253825; 
 Thu, 22 Oct 2026 06:54:13 -0700 (PDT)
X-Received: by 2002:a05:6000:4811:b0:48a:eeb7:5e5c with SMTP id
 ffacd0b85a97d-48e26495a36mr11246470f8f.32.1792677253417; 
 Thu, 22 Oct 2026 06:54:13 -0700 (PDT)
Received: from [192.168.192.3] (p4fdeb9e7.dip0.t-ipconnect.de.
 [79.222.185.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2581efd9sm12129147f8f.18.2026.10.22.06.54.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 06:54:12 -0700 (PDT)
Message-ID: <54688df7-7b2e-4208-9184-ae3660d92ab9@redhat.com>
Date: Thu, 22 Oct 2026 15:54:11 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] qapi/common: Clarify what IoOperationType is for
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20261019182028.45305-1-hreitz@redhat.com>
 <20261019182028.45305-2-hreitz@redhat.com> <8733u0ud4q.fsf@pond.sub.org>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <8733u0ud4q.fsf@pond.sub.org>
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 20.10.26 07:58, Markus Armbruster wrote:
> Hanna Czenczek <hreitz@redhat.com> writes:
>
>> The documentation for this type is a bit sparse right now, and
>> specifically does not explain why it is limited to read/write only;
>> "I/O operation type" could well imply this should distinguish a much
>> broader range of operations like flushes, discards, etc., but it does
>> not.
>>
>> Make a note why that is, which is that these types reflect the block
>> device on-error policy settings that we have, which are rerror for read
>> and werror for write.
>>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>>   qapi/common.json | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/qapi/common.json b/qapi/common.json
>> index 1352e664b23..880eb87a9cb 100644
>> --- a/qapi/common.json
>> +++ b/qapi/common.json
>> @@ -9,7 +9,10 @@
>>   
>>   ##
>>   # @IoOperationType:
>> -#     An enumeration of the I/O operation types
>> +#     An enumeration of the I/O operation types, limited to the block
>> +#     device on-error policy settings we have (rerror and werror).
>> +#     For reference, the corresponding error policy values are set in
>> +#     `BlockdevOnError`.
>>   #
>>   # @read: read operation
>>   #
> I believe I get what you mean only because I read the cover letter
> first.
>
> My first attempt
>
>      I/O operation types that may have a block device on-error policy.
>
> is still confusing, because we use "block device" both for frontends and
> backends.  I believe "block device on-error policy" refers to the qdev
> properties "rerror" and "werror" certain block frontends / device models
> have (virtio-blk-device, scsi-hd, scsi-cd, usb-storage).  Possible
> clarification:
>
>      These are the properties "rerror" and "werror" certain block device
>      models have.
>
> And then maybe
>
>      @read: read operation, corresponding to property "rerror"
>
>      @write: write operation, corresponding to property "werror"

Sure, thanks!

Unless you stop me ( :) ), I’ll keep the reference in, in addition.

Hanna


