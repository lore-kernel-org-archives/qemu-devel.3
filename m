Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86884C19776
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 08:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnCdD-0008Bp-LE; Wed, 26 Feb 2025 03:19:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnCdA-0008BZ-Bj
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 03:19:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnCd7-0002R8-HL
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 03:19:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740557936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2d4IRHTx1SpckeMZfk5JgTyXXGKjmu+GJKNq1Ijcukc=;
 b=RDVz+OyeT4nYXLiMU4j9H95e8TFaZg14/0E5SDz1uedsFkMHaydsQu8RWLiX6WR9LxUf9K
 KFhHD5MSicigmaBusPt+8VB4rPcxScAb7V/5iDdy971mow2YxHKpX+Hvwiy2/lknJq3Eg9
 /Ne0ZZWMplPYBdtHGuqYu90HKsAGeHA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-Oa1mW0aLOKO7E45L5fJQOw-1; Wed, 26 Feb 2025 03:18:54 -0500
X-MC-Unique: Oa1mW0aLOKO7E45L5fJQOw-1
X-Mimecast-MFC-AGG-ID: Oa1mW0aLOKO7E45L5fJQOw_1740557933
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38f628ff78eso281608f8f.1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 00:18:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740557933; x=1741162733;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2d4IRHTx1SpckeMZfk5JgTyXXGKjmu+GJKNq1Ijcukc=;
 b=s/2EM7z7q4spCstrAGiest9wcYw6SA4DFDvIpKZ1beUUYmKowhHXVnZfe+mYJaDUmG
 TKdV5/pWMj71FoSP7o49Kv4Ibe+tG77h0Sdp3rXrz0FQSVgWZE+/A14HzXThTG/DrEUE
 CFKVq0ggrita6ZD6KMN/7icUyR4p80J8zvnBeDx81+xHAHT86LVUOb8HCtztPuJeGbJO
 ivzqOn4MsEBc4VJ7evgKKkukBm1xaRm6EjFB0jW3Nz6/1uHEWdH9IhKqAjAQqPop4C8C
 gQFx9QBsJFqRPXTwjn+B/ueRHbweWtwbQ5pmCc5Jr6AnqtYZKaghjo4tpfvl8Rak0Gs7
 TygQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUORvYsor5clYaZgLmyS8yheyzvFChKFoLklN0f42Gl7/eBzCURTaCWoL2O/IiSdN5nrP+O0JXKhPme@nongnu.org
X-Gm-Message-State: AOJu0YytjeRxXAFxma4vzDQ8aAEOgxaLPrwpABZruxnZ8TCoGnyqag9E
 QPnbAC9KY7B4amptXhws51fMkUMjXZ6hA39thJtWEaRAOZLMF6MswRDLV58WHUN2SyMD7RRxHIe
 fhdQrBdt0myrWUpx2sO1+2smx64jXmzG1tq3TBFY3efpT4NETYTF6
X-Gm-Gg: ASbGncu/FKX8CU0iwv0gaj9jHjctEFRLX6U8yGiK1iCZL4LTsX4pzhDicTBfwXU9Xqp
 FFNZW2SWW4p/Na2mkfFg9CvZEL1QuO0ln8V0pg0M/mxjLqYiVV3rT7NhwbT1bFcLkg6HsqxQaW+
 THkrhnP98OnpB2lVx8I6hNh+AsZMWYQjV6562jDr8Cu6OX8e5K6dj42JB901/HJ4to9yewsu20H
 bEkaxxLUlfgkiZLNZY/Mwi454R66NqMB8jo/Pd0/giQB/vnL7gkPqx3gye3jqtpu7FOU8cXLbYj
 cS0J+tBLBLOH6kJSRvU2gVxgLCO84RW+Z0CDizAbsQB5TdwJjpse59FHeFk=
X-Received: by 2002:a5d:6c68:0:b0:38d:d222:ee70 with SMTP id
 ffacd0b85a97d-38f6f5151ecmr16065240f8f.20.1740557932970; 
 Wed, 26 Feb 2025 00:18:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFKV7DvELNhk3rMRA9ts06sglyue6zrrs2zGRqivrXwtzExNutOTTI+DbB38SiEmoO1Tqgbg==
X-Received: by 2002:a5d:6c68:0:b0:38d:d222:ee70 with SMTP id
 ffacd0b85a97d-38f6f5151ecmr16065221f8f.20.1740557932575; 
 Wed, 26 Feb 2025 00:18:52 -0800 (PST)
Received: from ?IPV6:2a01:cb19:9004:d500:a732:5611:7f59:8bb3?
 ([2a01:cb19:9004:d500:a732:5611:7f59:8bb3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd86caa8sm4654841f8f.25.2025.02.26.00.18.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 00:18:52 -0800 (PST)
Message-ID: <f17643ad-d2ca-4c6e-8133-82199caa1e9e@redhat.com>
Date: Wed, 26 Feb 2025 09:18:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Update the ppc64 pseries and pnv tests
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20250226065401.197915-1-clg@redhat.com>
 <d61872e1-2eca-4af7-a135-96659ec5fb6e@redhat.com>
 <cb6e9bb4-5eee-4492-abe0-073ecf586267@redhat.com>
 <9500f130-c3b4-44c0-b51a-070429756a36@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <9500f130-c3b4-44c0-b51a-070429756a36@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 2/26/25 09:11, Thomas Huth wrote:
> On 26/02/2025 08.54, Cédric Le Goater wrote:
>> On 2/26/25 08:01, Thomas Huth wrote:
>>> On 26/02/2025 07.54, Cédric Le Goater wrote:
>>>> The tests are using a now archived Fedora29 release. Switch to the
>>>> most recent Fedora41 release.
>>>>
>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>> ---
>>>>   tests/functional/test_ppc64_powernv.py | 6 +++---
>>>>   tests/functional/test_ppc64_pseries.py | 6 +++---
>>>>   2 files changed, 6 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/tests/functional/test_ppc64_powernv.py b/tests/functional/ test_ppc64_powernv.py
>>>> index 685e2178ed78..a9da7905366e 100755
>>>> --- a/tests/functional/test_ppc64_powernv.py
>>>> +++ b/tests/functional/test_ppc64_powernv.py
>>>> @@ -18,9 +18,9 @@ class powernvMachine(LinuxKernelTest):
>>>>       good_message = 'VFS: Cannot open root device'
>>>>       ASSET_KERNEL = Asset(
>>>> -        ('https://archives.fedoraproject.org/pub/archive/fedora-secondary/'
>>>> -         'releases/29/Everything/ppc64le/os/ppc/ppc64/vmlinuz'),
>>>> -        '383c2f5c23bc0d9d32680c3924d3fd7ee25cc5ef97091ac1aa5e1d853422fc5f')
>>>> +        ('https://archives.fedoraproject.org/pub/fedora-secondary/'
>>>> +         'releases/41/Everything/ppc64le/os/ppc/ppc64/vmlinuz'),
>>>> +        'eca627adbe42437cacea169beeb4c3c12a5cfbca1a6b1ba5218d28139d2143c4')
>>>
>>> I think we should rather avoid the very latest and greatest Fedora URLs here... they will be invalid in a couple of months after Fedora 43 has been released. And if we keep switching the test assets all the time, this will make it more difficult to bisect regressions in the future.
>>>
>>>   Thomas
>>>
>>
>> So we should point to the latest archive (fedora38) then ?
> 
> Either that, or simply keep the f29 kernel ... what do we gain by switching to a newer one here? Is it testing more hardware?


Yes. Usually HW support is added gradually to the kernel and
the later one offers better support.

Any how, that's fine, f29 works good enough.

Thanks,

C.




>   Thomas
> 


