Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B07C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 11:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA5kk-0004OR-Oy; Wed, 30 Apr 2025 07:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uA5kj-0004Le-Bp
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 07:37:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uA5kd-00032f-Lm
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 07:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746013037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fD5cYY+Rzc5jEUcKr2IURIlybEgFp8Ncslg+7sx7jHs=;
 b=dNcKO8aGkopJzEan+wJgc8xiokipmwD38TRc/Vf4H1kyuLi2ZmOAngbcbEgzAWRnG7Rp3F
 HXio871r1dZ1FBsc6jgbPjemlfmz8qaO9/R80pUi1jYi8sbGkThpTm8BgG8NW0WbF1sQRK
 PcP++eKbgS6jB3v1LCq5sBTTcEczJnI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-eUpQis0tNp-kY-ga-xuDSg-1; Wed, 30 Apr 2025 07:37:16 -0400
X-MC-Unique: eUpQis0tNp-kY-ga-xuDSg-1
X-Mimecast-MFC-AGG-ID: eUpQis0tNp-kY-ga-xuDSg_1746013035
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3912a0439afso2218211f8f.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 04:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746013035; x=1746617835;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fD5cYY+Rzc5jEUcKr2IURIlybEgFp8Ncslg+7sx7jHs=;
 b=IQt9+ITegA36wrcPxhet+zlBIpw8Va/HOSMVVSh7eAelmxBawiFSXNjzoQr0yq8313
 Z1p2pGl7D4mX/NozLM64gMPu7vd/G3Ae8Gg+/90YaYdmZoM3lG+n2NX3Fvj/xO6NFSId
 2JihAUl6y5IKBjRcWFX7ky9mCTchQ7bloJ9Ym11IrVZ2Dz5RC+UyQdDjJkF5v4vvP8f+
 wsJ+JuJ6MJhcZJZSRAR+xvTBqlzIvvBEQNk9cSZcYVYsqQvR5qmQA4dLgESeRT6UAyhV
 yPkcT1VHJtdekrlIkvCYEZLNuiMuKyXScaOky2CHSXoFtR33HQHa3HFnp2+W1dFbuXvS
 XQgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXatEig7+W3EYyvb9XHA8+VRktjSq+wlSK4H8vkMjioA/ybzvQQDxQGHLdn6Ay9Pb9jvuPgyBVxZZgi@nongnu.org
X-Gm-Message-State: AOJu0YyC3moxLgVyffEwY6l58brg2fhLpkxIxacGpECSV4nJDLgiKpJi
 anvcfZ3I5VfrheDhREmC2BxG4DmkdLMqGiffhE21Gjq8xFm0hRt5FXiDtMZUzJ2Y9v42sv+5pGd
 bGySkDzDCrryMmCRbktYvg266eORMHykN1QM4bgcN5RbDhZVffpMS
X-Gm-Gg: ASbGncsD8WIiH4/p9D6v/WGeubLfkZvHpZUoqbqb8nJYFBd1RkSrIBdEIMlFkdRQMAW
 JTWjF/YhcXk9OaPo52fh41F1xL761OtYIhwNdF12tzUlf9z8yUYkL5hj2LX52nytFUHkaQg8TUb
 G8+Wi8Ri3qXRvNnQ1YI2S4Mh8zi9BGUDOMswmw7OFN/tlfUSCC4DrD5dn/oVyyHF+fC/BZMIuJR
 YKGX9zl7D2CfyrrrHaN22v7aLlDP+A2KJbWjvxmE/22k2ww8+fYtu8DJO7207AqB4pNaIg3qvvB
 MLHcll56Wkpbu16ujW08IbPswvEu8NM2ZEfxr4Oz
X-Received: by 2002:a05:6000:2907:b0:3a0:8465:43 with SMTP id
 ffacd0b85a97d-3a08f7a354dmr2718394f8f.43.1746013035029; 
 Wed, 30 Apr 2025 04:37:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHV+JTbv44vhE55EFKCB7QlWARBUcJECN1SQBnV3cLEp9T52B/0dDhRiYlwnnKWWAHv4+kmbw==
X-Received: by 2002:a05:6000:2907:b0:3a0:8465:43 with SMTP id
 ffacd0b85a97d-3a08f7a354dmr2718375f8f.43.1746013034676; 
 Wed, 30 Apr 2025 04:37:14 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-87.web.vodafone.de. [109.42.49.87])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca4cbcsm16520714f8f.25.2025.04.30.04.37.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 04:37:14 -0700 (PDT)
Message-ID: <1a3b2171-8188-455c-ab97-203d2e726c98@redhat.com>
Date: Wed, 30 Apr 2025 13:37:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest/libqos: Avoid double swapping when using
 modern virtio
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250430073343.526867-1-thuth@redhat.com>
 <c3efa112-5c79-4ead-9a0c-3e27f328cce2@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <c3efa112-5c79-4ead-9a0c-3e27f328cce2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 30/04/2025 10.40, Philippe Mathieu-Daudé wrote:
> On 30/4/25 09:33, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> The logic in the qvirtio_read/write function is rather a headache,
>> involving byte-swapping when the target is big endian, just to
>> maybe involve another byte-swapping  in the qtest_read/write
>> function immediately afterwards (on the QEMU side). Let's do it in
>> a more obvious way here: For virtio 1.0, we know that the values have
>> to be little endian, so let's read/write the bytes in that well known
>> order here.
> 
> Thanks for looking at this!
> 
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   This also decreases our usage of qtest_big_endian() which might (or
>>   might not) get helpful for the universal binary one day...
>>
>>   tests/qtest/libqos/virtio.c | 61 ++++++++++++++++++++++++++-----------
>>   1 file changed, 44 insertions(+), 17 deletions(-)
>>
>> diff --git a/tests/qtest/libqos/virtio.c b/tests/qtest/libqos/virtio.c
>> index 2e7979652fd..078adf3c8dc 100644
>> --- a/tests/qtest/libqos/virtio.c
>> +++ b/tests/qtest/libqos/virtio.c
>> @@ -25,49 +25,76 @@
>>    */
>>   static uint16_t qvirtio_readw(QVirtioDevice *d, QTestState *qts, 
>> uint64_t addr)
>>   {
>> -    uint16_t val = qtest_readw(qts, addr);
>> +    uint8_t buf[2];
>> -    if (d->features & (1ull << VIRTIO_F_VERSION_1) && 
>> qtest_big_endian(qts)) {
>> -        val = bswap16(val);
>> +    if (d->features & (1ull << VIRTIO_F_VERSION_1)) {
>> +        qtest_memread(qts, addr, buf, sizeof(buf));
>> +        return (buf[1] << 8) | buf[0];
>> +    } else {
>> +        return qtest_readw(qts, addr);
>>       }
>> -    return val;
>>   }
> 
> What about using cpu_to_le() API?
> 
> -- >8 --
>   static uint16_t qvirtio_readw(QVirtioDevice *d, QTestState *qts, uint64_t 
> addr)
>   {
> -    uint16_t val = qtest_readw(qts, addr);
> +    uint16_t val;
> 
> -    if (d->features & (1ull << VIRTIO_F_VERSION_1) && qtest_big_endian(qts)) {
> -        val = bswap16(val);
> +    if (d->features & (1ull << VIRTIO_F_VERSION_1)) {
> +        qtest_memread(qts, addr, &val, sizeof(val));
> +        cpu_to_le16s(&val);
> +    } else {
> +        val = qtest_readw(qts, addr);
>       }
> +
>       return val;
>   }

D'oh, not sure how I could have forgotten about these functions, that's much 
nicer indeed! I'll respin my patch with that, thanks for the reminder!

  Thomas


