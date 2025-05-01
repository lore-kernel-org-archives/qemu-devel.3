Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66D0C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 17:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAXj1-0003Ti-IF; Thu, 01 May 2025 13:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAXix-0003TM-9X
 for qemu-devel@nongnu.org; Thu, 01 May 2025 13:29:27 -0400
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAXiv-0004Ik-9z
 for qemu-devel@nongnu.org; Thu, 01 May 2025 13:29:27 -0400
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3d817bc6eb0so3921115ab.1
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 10:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746120563; x=1746725363; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uHrmqxi8sd8InAMCIwenUyUSTKfoTxUcgLW7uwOrWAQ=;
 b=SWu/1phlM4TIkpkVe5Yic464IhZex63egmUwziZ8TBgT8L/PWGQAkpxcZ0J/AOm7Kr
 VQRwgqt8pAXOHfTOTBhY578bF9EYICcGNkX4mSF1sCpchcmmJXh2ds7be5WNeW7jAHbr
 Ez3dt1OA7uZ8wvPiRKDiHwXpaQmjuqgRGWtZBn0a2sq7j+2gDs82avnm4Ixkq6DxB59m
 qfsXywkjWUXLpxhZ2lPgL5Yaovy1Sk0px4hkK7aslCTuJjQo9BsD4lp2AD4DqkdGzJOj
 jEIVktb3Jzw7M3IduzLsggqDk7WYEBW5XnV9IVVQXid/UzTENNm7C3X6K8nl6QV3HZOD
 maOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746120563; x=1746725363;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uHrmqxi8sd8InAMCIwenUyUSTKfoTxUcgLW7uwOrWAQ=;
 b=sHPdCjbgtqSEHwNQCRsJYZBo794QM5ussLN4sXB3mmRZ39VOAV99GeKdWH/bXX8/ny
 d/ouqLOrpdJYEZUHA8NcFftfXtXW4GfttVEp5YAyz6ImLlLbf4m8utmeLG3eszBdV/sa
 BgnzCNCNWhelq0b0emT1n9P3PUegpkxHnRwHvYsSjSXOxLkHp1NsAZCKFdN2IcA/oJh2
 Xlz0OQnIIF8fK3E2OGcf0rww5TKuPwpX+Ac9kkBOcPQGdxn7k0hCjH2rZP2LRwhxm9vp
 SvecKPggugFAiS3el2iQJ0Tp/V+0/sSILGgs0SfQG7wHyC/aImsi4OZU+QRTFc9xxbVG
 BjAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpl6eZ4ycfB2QPhNo9CYz5z6vrHQJtCFo/JbMe2wF325sMuf7lgyhqYuaAVRJTYE+spaaFeq+KXKGR@nongnu.org
X-Gm-Message-State: AOJu0YzHyLYUzkBV5wNyUd/LkRm+OWYdCpyzzEIc4SzNXaK6WRowX1w3
 7hHGJLbjZyynus4e/kteRkZXn91RzYnGHEwkd2ZrtuahGNL23BXR89+OBa/gMoA=
X-Gm-Gg: ASbGncuwcU8AEBmS0+X1F7OusGPXBEQI3MDgstHkHPhsrwkVE244++/24OFUbjdjjIj
 70zdsyXWEx0j0/Rrbskd9FKvgGfylY1VU4MzJiwEUnpxQb9ee/hYNZ9adYHutWzUOqeHL4U5WHz
 8wQGZZuq7qLJZx3Z5s0W6WiqLB+tnot/wsYoir8My5ODwvwX7a4S89k7eoEhkG3zmBAOlANoTwt
 dLo+ueJtqapkv7FcoRqmUrFIj5ONoXOrrEQUfsLnq2DcZaeCXOwVHWDQqXBh7KY3auPINnU4AFo
 zB/3dgKDnA8JhOefcbL+tDGSUeP9319FCiYJqIitoR1CTuByqdxr1rUKIqCGkYC/fC2vRrLuWTJ
 Zx2xPDKfodpvHf52hKfY=
X-Google-Smtp-Source: AGHT+IFpUAzMl9CmQAiD81iS9Y8wRJuJIjfwv99Y6VJddWv3tpd8XzT53DwX0l0wyWRqhmjYacA53g==
X-Received: by 2002:a05:6e02:1c0b:b0:3d4:337f:121c with SMTP id
 e9e14a558f8ab-3d96f1b2017mr45573075ab.10.1746120563540; 
 Thu, 01 May 2025 10:29:23 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d975eca7b6sm2266665ab.38.2025.05.01.10.29.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 10:29:22 -0700 (PDT)
Message-ID: <24e572c1-7000-40ef-b006-a346a2e39792@linaro.org>
Date: Thu, 1 May 2025 19:29:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/1] Optimizing the print format of the QEMU monitor
 'info mtree'
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Chao Liu <lc00631@tecorigin.com>, pbonzini@redhat.com, peterx@redhat.com, 
 david@redhat.com, armbru@redhat.com, zhangtj@tecorigin.com,
 zqz00548@tecorigin.com, qemu-devel@nongnu.org
References: <cover.1746065388.git.lc00631@tecorigin.com>
 <6d17f9a1-67d9-4a97-ae1d-21a78d2592a4@linaro.org>
 <5d1cef0e-a8b8-77ed-0ad8-ab7c4e15fbdb@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5d1cef0e-a8b8-77ed-0ad8-ab7c4e15fbdb@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-il1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/5/25 15:49, BALATON Zoltan wrote:
> On Thu, 1 May 2025, Philippe Mathieu-Daudé wrote:
>> Hi Chao,
>>
>> On 1/5/25 04:24, Chao Liu wrote:
>>> Hi, all:
>>>
>>> Thanks to BALATON, and David for their reviews.
>>>
>>> In PATCH v6:
>>> 1. Replaced the bool type with enum mtree_node_type to improve code 
>>> readability.
>>> 2. Modified the output to use only one horizontal dash instead of 
>>> two, and
>>>     aligned character printing for a cleaner look.
>>>
>>> like this:
>>>
>>> ```
>>> $ ./qemu-system-aarch64 -S -monitor stdio -M raspi4b
>>> (qemu) info mtree
>>> address-space: memory
>>> `- 0000000000000000-ffffffffffffffff (prio 0, i/o): system
>>>     |- 0000000000000000-000000007fffffff (prio 0, ram): ram
>>> ...
>>>     |- 00000000fe000000-00000000ff7fffff (prio 1, i/o): bcm2835- 
>>> peripherals
>>>     |  |- 00000000fe900000-00000000fe907fff (prio -1000, i/o): 
>>> bcm2835-dbus
>>>     |  |- 00000000fe910000-00000000fe917fff (prio -1000, i/o): 
>>> bcm2835-ave0
>>>     |  |- 00000000fe980000-00000000fe990fff (prio 0, i/o): dwc2
>>>     |  |  |- 00000000fe980000-00000000fe980fff (prio 0, i/o): dwc2-io
>>>     |  |  `- 00000000fe981000-00000000fe990fff (prio 0, i/o): dwc2-fifo
>>>     |  |- 00000000fec00000-00000000fec00fff (prio -1000, i/o): 
>>> bcm2835-v3d
>>>     |  |- 00000000fec11000-00000000fec110ff (prio -1000, i/o): 
>>> bcm2835-clkisp
>>>     |  |- 00000000fee00000-00000000fee000ff (prio -1000, i/o): 
>>> bcm2835-sdramc
>>>     |  `- 00000000fee05000-00000000fee050ff (prio 0, i/o): bcm2835- 
>>> dma-chan15
>>>     |- 00000000ff800000-00000000ff8000ff (prio 0, i/o): bcm2836-control
>>> ...
>>>     |- 00000000ff845600-00000000ff8456ff (prio 0, i/o): gic_cpu
>>>     `- 00000000ff846000-00000000ff847fff (prio 0, i/o): gic_vcpu
>>> ```
>>
>> Could we keep the address ranges aligned? I.e.:
>>
>>>   |--+     00000000fe000000-00000000ff7fffff (prio 1, i/o): 
>> bcm2835-peripherals
>>>   |  |---- 00000000fe900000-00000000fe907fff (prio -1000, i/o): 
>> bcm2835-dbus
>>>   |  |---- 00000000fe910000-00000000fe917fff (prio -1000, i/o): 
>> bcm2835-ave0
>>>   |  |--+  00000000fe980000-00000000fe990fff (prio 0, i/o): dwc2
>>>   |  |  |- 00000000fe980000-00000000fe980fff (prio 0, i/o): dwc2-io
>>>   |  |  `- 00000000fe981000-00000000fe990fff (prio 0, i/o): dwc2-fifo
>>>   |  |---- 00000000fec00000-00000000fec00fff (prio -1000, i/o): 
>>> bcm2835-v3d
>>>   |  |---- 00000000fec11000-00000000fec110ff (prio -1000, i/o): 
>> bcm2835-clkisp
>>>   |  |---- 00000000fee00000-00000000fee000ff (prio -1000, i/o): 
>> bcm2835-sdramc
>>>   |  `---- 00000000fee05000-00000000fee050ff (prio 0, i/o): 
>> bcm2835-dma-chan15
>>>   |------- 00000000ff800000-00000000ff8000ff (prio 0, i/o): bcm2836- 
>>> control
> 
> I don't think that helps. I was OK with just indents and adding graphics 
> does not change that but this would actually make it harder to see what 
> is below what as you'd have to trace back to the beginning of the line 
> and not just look at the right end where it would not be clear where a 
> sub region starts so it't less readable even if it looks more organised. 
> So I'd keep the indent.

Maybe add the '-t' option then, to display as tree, and not disturb
the previous command output.

