Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51BAC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 07:57:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE2Z7-00047J-EE; Mon, 03 Jun 2024 03:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sE2Z5-00046u-M2
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 03:57:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sE2Yt-000226-ED
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 03:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717401418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HI8rBTa8fLFhWagPDs89Oyv56t5/7/OToI5osZ9vWrY=;
 b=Ueg0tkO7r/Oz4EYRGrPKw6Rddg00SOAXjJrVrH51KEPPjEyakj4mAgf+/81DTh6MMoConU
 5x1AO0Hbqe/vJxA8g1nvg+Wo8VoJ/Xf/6O3jim2/Sy2B/IA0wkZMUotL0VcG8BuD+hkEzp
 Nj+gEUmw1ku/QxCVpS/+0kCy2IvbWVs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-nbpsgC6kMJ-oipJotwnSuQ-1; Mon, 03 Jun 2024 03:56:56 -0400
X-MC-Unique: nbpsgC6kMJ-oipJotwnSuQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4212abb4720so20721095e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 00:56:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717401412; x=1718006212;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HI8rBTa8fLFhWagPDs89Oyv56t5/7/OToI5osZ9vWrY=;
 b=ZoOtrgaK3jjR78WlwqoLsfENc7GHQ2rPp+YV7/mTql7bVkCZ61l+Edg7sW+xRDmP9x
 UX61nq9NpQw3aAsSlAVt9WKSghLtQclMd+AMFBC1+sGH4Eozuno1MpIsrjvFy2qtAIUW
 CMNgVNh+8Los70ppwBaxzeOjr5qj+QFF7wrh12cohhNkhASh9urLPuKGRLfpQtLxSpKV
 YpOOIJqjFbvesAlKPPuDpIZrEjUcsF8AFWIRfQWugjE/hdoYBbATySbRPsjiS4Gh12sk
 P9v01pa9VsFjhTg+upjYDo/LtAFCNTsmd9Rk1KDVVyvu2xbMG7E1952AsfPlKSic4+be
 znew==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7U7SDKV42M528eRL6NkiWg+hJlmNw2zn5K64ob0SdCIBv+7njR9L/qChEXr+35wM7v9boURNIaQSkOk8jPxVRWHkUtFU=
X-Gm-Message-State: AOJu0Yz4bDYh7GJYV4QaH5jNwtfqgJOQyWgrTsZcDseagEGDeCweY06G
 mXXCbElVepmldlYjcPG0qRLzso0qSrfJr5bLdUMuKuC1axVSw5mNmqP9DLHwoKzRJRxPuECnyX2
 TE/L+vcmWsv/8w/p6wmMuvtZI9+pwjjGvAGwkqayq27Ewko4fpnDT
X-Received: by 2002:a05:600c:19cc:b0:41f:f957:96ac with SMTP id
 5b1f17b1804b1-4212e04a57dmr77739715e9.13.1717401412630; 
 Mon, 03 Jun 2024 00:56:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3zim4reQa3bMdTRrrshR+Wrstfkvxtg2QnEU2YbGVXSbWafaJSnV0xcwavNzXx2m0y1HKsA==
X-Received: by 2002:a05:600c:19cc:b0:41f:f957:96ac with SMTP id
 5b1f17b1804b1-4212e04a57dmr77739515e9.13.1717401412212; 
 Mon, 03 Jun 2024 00:56:52 -0700 (PDT)
Received: from [10.43.3.102] (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04c9d78sm7975848f8f.27.2024.06.03.00.56.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 00:56:51 -0700 (PDT)
Message-ID: <d32e3ea3-32fb-4893-a950-91e60c9778d2@redhat.com>
Date: Mon, 3 Jun 2024 09:56:51 +0200
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
From: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
Content-Language: en-US
In-Reply-To: <08ff19ed-9d1b-4fa3-8a40-3fe10d1f9bfa@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mprivozn@redhat.com;
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

On 6/2/24 08:26, Akihiko Odaki wrote:
> On 2024/06/01 0:46, Philippe Mathieu-Daudé wrote:
>> On 31/5/24 17:10, Michal Privoznik wrote:
>>> The unspoken premise of qemu_madvise() is that errno is set on
>>> error. And it is mostly the case except for posix_madvise() which
>>> is documented to return either zero (on success) or a positive
>>> error number. This means, we must set errno ourselves. And while
>>> at it, make the function return a negative value on error, just
>>> like other error paths do.
>>>
>>> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
>>> ---
>>>   util/osdep.c | 14 +++++++++++++-
>>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/util/osdep.c b/util/osdep.c
>>> index e996c4744a..1345238a5c 100644
>>> --- a/util/osdep.c
>>> +++ b/util/osdep.c
>>> @@ -57,7 +57,19 @@ int qemu_madvise(void *addr, size_t len, int advice)
>>>   #if defined(CONFIG_MADVISE)
>>>       return madvise(addr, len, advice);
>>>   #elif defined(CONFIG_POSIX_MADVISE)
>>> -    return posix_madvise(addr, len, advice);
>>> +    /*
>>> +     * On Darwin posix_madvise() has the same return semantics as
>>> +     * plain madvise, i.e. errno is set and -1 is returned. Otherwise,
>>> +     * a positive error number is returned.
>>> +     */
>>
>> Alternative is to guard with #ifdef CONFIG_DARWIN ... #else ... #endif
>> which might be clearer.
>>
>> Although this approach seems reasonable, so:
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> We should use plain madvise() if posix_madvise() is broken. In fact,
> QEMU detects the availability of plain madvise() and use it instead of
> posix_madvise() on my MacBook.
> 
> Perhaps it may be better to stop defining CONFIG_POSIX_MADVISE on Darwin
> to ensure we never use the broken implementation.
> 

Well, doesn't Darwin have madvise() in the first place?

https://opensource.apple.com/source/xnu/xnu-7195.81.3/bsd/man/man2/madvise.2.auto.html

I thought that's the reason for posix_madvise() to behave the same as madvise() there.

Michal


