Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A7FC25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 10:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE4bq-00023t-8Y; Mon, 03 Jun 2024 06:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sE4bp-00021x-62
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 06:08:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sE4bi-0000Q3-RC
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 06:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717409282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qKt8+azl0czDTJNaaNa0Pi2LKwkg0subZtFTaLbzJOw=;
 b=b5mIqLc3GQtaRcT1N3QJXWDpfctuXHkW3dTx5wX3ZtfMD2kGYusCYa8CU2UVqnVRD/DM4s
 oNuZSn6Gr3i7EB/l894YBNt5dnKdqHPGbMouaOeatjWoYtISBRzDjJydlwZSSWf1wTP2TH
 7AH0C9O74zDqs92yOz0l4djZ7E8zMMo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-YPjqGKFqMaaE_ka1oLk5Hw-1; Mon, 03 Jun 2024 06:08:01 -0400
X-MC-Unique: YPjqGKFqMaaE_ka1oLk5Hw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-35dca4922a4so2216692f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 03:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717409279; x=1718014079;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qKt8+azl0czDTJNaaNa0Pi2LKwkg0subZtFTaLbzJOw=;
 b=WqaWM70l8BvjfTc88Y79XqNFq3YFI8VBvj89nxtixdXN+m936unTdH+Ah5nA8dqlHY
 VWlaysayjnS9hzOhnObf1CiyrgccsKPssniPzTDP42WBpQKtPkiwurvJFyt+2+nMyuNd
 BGFUzXXXt/FUsokxPB+040DDnkIAo9LJVMDi+mvGMHt5Q/HPICjjyA2z9G27eBqTBvD4
 cLjtM6OQFBCx5PEv7o0ZW1q1HZeaoCJ/89JqJ7wQqEBt5AeR+JpEWYcUfiVjIjzQuekB
 ME4AbG2w4ooxUZuv8kc20yDrO2OBhwDk2U6svD/9GQqNaewZlwxrw1/mgZfZ6/G+ciqw
 xbbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhauyCOuzWWKJXaHGSMyXIrpBFQ31uNnSVyjlpnp+gqpm+x0stWwHcj81qx7TU3QGi1aDgA5HZn1AElbDGRWAFb0mVezo=
X-Gm-Message-State: AOJu0YwedxuCyigrih3vuFlBgMnTQpX2UAjV2lmR9Wo3WNR3lh08DVUK
 fvgwJ25uz4CRkbHvNUD4s4gMAdUD59XH0Y9w6o/7U+ChmUueC/8Wy5br3Wx43qTx9jnh/8eWio2
 Tuv0u/rs0OYKXvHfwCJVBsArwYQx7/7C/FuAU3RKy9eNRaHmuXaA482nNU+tn
X-Received: by 2002:adf:f1c3:0:b0:34f:8f7c:8fe2 with SMTP id
 ffacd0b85a97d-35dc7e2cbabmr10044858f8f.10.1717409279464; 
 Mon, 03 Jun 2024 03:07:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZbVrXOTPrF2d4l87jWzqcxWn/CvuOat+0cFVEQyeTbrQ9Fbe5goKaoB5CHvBNKSnsnEergQ==
X-Received: by 2002:adf:f1c3:0:b0:34f:8f7c:8fe2 with SMTP id
 ffacd0b85a97d-35dc7e2cbabmr10044823f8f.10.1717409278922; 
 Mon, 03 Jun 2024 03:07:58 -0700 (PDT)
Received: from [10.43.3.102] (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b83d4e2sm113037535e9.2.2024.06.03.03.07.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 03:07:58 -0700 (PDT)
Message-ID: <78f8d06f-9dee-4944-8635-af2316c84a33@redhat.com>
Date: Mon, 3 Jun 2024 12:07:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] osdep: Make qemu_madvise() to set errno in all
 cases
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>
References: <cover.1717168113.git.mprivozn@redhat.com>
 <393c7b26302cb445f1a086a2c80b1d718c31a071.1717168113.git.mprivozn@redhat.com>
 <4b146ec6-bec2-4191-8c95-fc30d8307ef6@linaro.org>
 <08ff19ed-9d1b-4fa3-8a40-3fe10d1f9bfa@daynix.com>
 <d32e3ea3-32fb-4893-a950-91e60c9778d2@redhat.com>
 <22e6b199-a23f-4b5d-ad80-86e82a232c8c@daynix.com>
From: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
Content-Language: en-US
In-Reply-To: <22e6b199-a23f-4b5d-ad80-86e82a232c8c@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/3/24 10:50, Akihiko Odaki wrote:
> On 2024/06/03 16:56, Michal Prívozník wrote:
>> On 6/2/24 08:26, Akihiko Odaki wrote:
>>> On 2024/06/01 0:46, Philippe Mathieu-Daudé wrote:
>>>> On 31/5/24 17:10, Michal Privoznik wrote:
>>>>> The unspoken premise of qemu_madvise() is that errno is set on
>>>>> error. And it is mostly the case except for posix_madvise() which
>>>>> is documented to return either zero (on success) or a positive
>>>>> error number. This means, we must set errno ourselves. And while
>>>>> at it, make the function return a negative value on error, just
>>>>> like other error paths do.
>>>>>
>>>>> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
>>>>> ---
>>>>>    util/osdep.c | 14 +++++++++++++-
>>>>>    1 file changed, 13 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/util/osdep.c b/util/osdep.c
>>>>> index e996c4744a..1345238a5c 100644
>>>>> --- a/util/osdep.c
>>>>> +++ b/util/osdep.c
>>>>> @@ -57,7 +57,19 @@ int qemu_madvise(void *addr, size_t len, int
>>>>> advice)
>>>>>    #if defined(CONFIG_MADVISE)
>>>>>        return madvise(addr, len, advice);
>>>>>    #elif defined(CONFIG_POSIX_MADVISE)
>>>>> -    return posix_madvise(addr, len, advice);
>>>>> +    /*
>>>>> +     * On Darwin posix_madvise() has the same return semantics as
>>>>> +     * plain madvise, i.e. errno is set and -1 is returned.
>>>>> Otherwise,
>>>>> +     * a positive error number is returned.
>>>>> +     */
>>>>
>>>> Alternative is to guard with #ifdef CONFIG_DARWIN ... #else ... #endif
>>>> which might be clearer.
>>>>
>>>> Although this approach seems reasonable, so:
>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>
>>> We should use plain madvise() if posix_madvise() is broken. In fact,
>>> QEMU detects the availability of plain madvise() and use it instead of
>>> posix_madvise() on my MacBook.
>>>
>>> Perhaps it may be better to stop defining CONFIG_POSIX_MADVISE on Darwin
>>> to ensure we never use the broken implementation.
>>>
>>
>> Well, doesn't Darwin have madvise() in the first place?
>>
>> https://opensource.apple.com/source/xnu/xnu-7195.81.3/bsd/man/man2/madvise.2.auto.html
>>
>> I thought that's the reason for posix_madvise() to behave the same as
>> madvise() there.
> 
> It does have madvise() and QEMU on my MacBook uses it instead of
> posix_madvise().
> 

I don't have a Mac myself, but I ran some tests on my colleague's Mac
and yes, posix_madvise() is basically just an alias to madvise(). No
dispute there.

> The behavior of posix_madvise() is probably just a bug (and perhaps it
> is too late for them to fix).
> 

So what does this mean for this patch? Should I resend with the change
you're suggesting or this is good as is? I mean, posix_madvise() is not
going to be used on Mac anyways.

Michal


