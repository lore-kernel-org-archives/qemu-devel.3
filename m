Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5E3CAC59B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyaay-0007pI-4p; Tue, 16 Sep 2025 14:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uyaav-0007nd-AS
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:40:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uyaat-0005zR-Ar
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758047995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cXfIdys3lphGw4K/13BaPVw1yfiAPP2uG8GiLofMl/I=;
 b=iMfOEwkVgVjE8SVcmJ2YOfuL6w6Vv4yAVhVEral0y9emCzr0lBnB1yuhJ8GiBB/qJl7Zs7
 2qApv/7+dUk8H+Z+q+hqXADKBt4SHO9zyi3hx12i4CQaFzPGedHzF/+BHNhKcrMQb4g6nD
 uwQvouUj6gfkGKNbsvX6mnHRHuXWK+M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-8-5IBdIONx64ZG6eCcHLWw-1; Tue, 16 Sep 2025 14:39:54 -0400
X-MC-Unique: 8-5IBdIONx64ZG6eCcHLWw-1
X-Mimecast-MFC-AGG-ID: 8-5IBdIONx64ZG6eCcHLWw_1758047993
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45de13167aaso52530585e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:39:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758047993; x=1758652793;
 h=content-transfer-encoding:in-reply-to:autocrypt:cc:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cXfIdys3lphGw4K/13BaPVw1yfiAPP2uG8GiLofMl/I=;
 b=KUmgPGN0leoi6aenS+LUzcBcIQ81fSTd41ahVabRHTvDaS3ym1/6ayUpEdU6ipfPtn
 dCNwI3IAdK+rVsE3FbIoxizstOFSSrZeXc4wpie6oxuEknHDDeoOhWhm4oX1RwS2BWuA
 sn0kEMwLtQzbN62cwnKlFkWOd1GhhdPR88FCIMjh6ggoi/BZJEW+rpZiI1SOL/ZN29O1
 Lu5FnpN4MYCMLNgFZqwlh5wiZeMOo74mVa7d3tBm8QRulkyXujU7OkhJMbqOUfvqNhPa
 DDqMHwVBBkTJJ3i0pfF9BQ8uc9hwJn3ZcyBcFFxFGKoQBdoDdVjtjwfAMYCZAiB9cSF6
 ReNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWn3VEgP1Buo8E9pT3pAl3LhohM1vprfljZq9xxgQiqjJrDjIErTUCCONUMM3h6qSBMqCP0tF80Ra6l@nongnu.org
X-Gm-Message-State: AOJu0YwW0lkNFabpYWehu3dNJlcPagrC9xjWvTvxca+fojGIsOTR2qFv
 Ofuop77HF506DwyCFkges+gEwzK8fAJsGc0N5v3sbOfSBmTyrl38dVRj6zAtC77XTfSIShr5h7F
 r5622mpsqbFehfHFnbVetG43h1mi3OZct0A9OVjaZcbG3ui/MK8SRqifE
X-Gm-Gg: ASbGncvXbLV9/1oJM7oNP/Sqm0aCOGGledKwwoLptr/vY+mVAWZo3hY0QP16wkyd118
 t1XI1ovuO7UQj9cbopLhZs1qtHJ3oPBM60mOIefykMcWudinBIVZ5Bb+DjVnGZCrsDAHGkO4EIE
 aDDXRonI0PySh3lkNTq1uk/bSgoH3GohPwgiIyD7WvZY/QLy75+sdDva/pPiDhQQ07Fqr9X9elw
 O9XTPVkqZjcxudn+w8ZP9bE/6r6oUqZMBTRvndpswLi/ScZfGLX9ee4hKuIKDW2Lfn71GuE8J8d
 potsNjAhYkOjF7CMhf4rnPdiCTgzP64mLSLAlfyZ+vicNCvFHyYQudhlGfXhrmfzHTy3KHHnoSx
 PuSmu2g==
X-Received: by 2002:a05:600c:c178:b0:45d:e54b:fa29 with SMTP id
 5b1f17b1804b1-45f211c8cd3mr164711665e9.14.1758047992867; 
 Tue, 16 Sep 2025 11:39:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHu8tz9+Z4aUrNZa1GjVloA2UnVgOMBvAkB4qqLcWIl+X1tWyquNVwhZISkG3jyWXGVzkkTTA==
X-Received: by 2002:a05:600c:c178:b0:45d:e54b:fa29 with SMTP id
 5b1f17b1804b1-45f211c8cd3mr164711535e9.14.1758047992482; 
 Tue, 16 Sep 2025 11:39:52 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-218.pools.arcor-ip.net.
 [47.64.113.218]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46136daf992sm5547925e9.1.2025.09.16.11.39.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Sep 2025 11:39:52 -0700 (PDT)
Message-ID: <855b4ed1-556e-41e7-84b2-9233e9823128@redhat.com>
Date: Tue, 16 Sep 2025 20:39:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/x86_64: Accept a few locked pages in
 test_memlock.py
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250915185509.340022-1-richard.henderson@linaro.org>
 <a6108491-9e0e-45df-9448-45de99e373a0@linaro.org>
 <8865c3ad-341a-446e-ba29-e4c9f6bab514@redhat.com>
 <8ebea8ef-42b9-4e8a-b0dd-9e0bb3bccdef@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Cc: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <8ebea8ef-42b9-4e8a-b0dd-9e0bb3bccdef@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 16/09/2025 18.55, Richard Henderson wrote:
> On 9/15/25 22:18, Thomas Huth wrote:
>> On 16/09/2025 03.38, Richard Henderson wrote:
>>> On 9/15/25 11:55, Richard Henderson wrote:
>>>> Startup of libgcrypt locks a small pool of pages -- by default 16k.
>>>> Testing for zero locked pages is isn't correct, while testing for
>>>> 32k is a decent compromise.
>>>>
>>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>> ---
>>>>   tests/functional/x86_64/test_memlock.py | 3 ++-
>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tests/functional/x86_64/test_memlock.py b/tests/functional/ 
>>>> x86_64/ test_memlock.py
>>>> index 2b515ff979..81bce80b0c 100755
>>>> --- a/tests/functional/x86_64/test_memlock.py
>>>> +++ b/tests/functional/x86_64/test_memlock.py
>>>> @@ -37,7 +37,8 @@ def test_memlock_off(self):
>>>>           status = self.get_process_status_values(self.vm.get_pid())
>>>> -        self.assertTrue(status['VmLck'] == 0)
>>>> +        # libgcrypt may mlock a few pages
>>>> +        self.assertTrue(status['VmLck'] < 32)
>>>>       def test_memlock_on(self):
>>>>           self.common_vm_setup_with_memlock('on')
>>>
>>> I wonder if I should have chosen 64k, which might be one 64k page...
>>
>> It's a x86 test, so we should not have to worry about 64k pages there, I 
>> hope?
> 
> Fair enough, though it does beg the question of why it's an x86-specific 
> test.  Don't all host architectures support memory locking?

I guess you need at least a target machine that runs a firmware by default, 
since this test does not download any assets...?

  Thomas


