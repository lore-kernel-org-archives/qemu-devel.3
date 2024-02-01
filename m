Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0245C4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 19:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVcgW-0001u2-QJ; Thu, 01 Feb 2024 14:25:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rVcgW-0001to-6y
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 14:25:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rVcgU-0001ph-Qt
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 14:25:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706815513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1pymmuAcrkj7CRqmIcYx/9SdQjZc3Gb30MeSUSMaiPQ=;
 b=hpCaNl4rGr7AJU6WwemgX+jn12zewl764xLoEzOhSD4Le4xoM08LcITLYC/wned9pl+K4Y
 WuxG1l1KcFiELMARU5jsfP2uZxliIbtk8KaY6wz6oIP/9QKi7tSMDYpSg1GV1GUjBl/85A
 lhwL+WzYorHL5tDKghcTeSpU26qz3aM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-uV2CZR5TP1uRK-ktbViTjQ-1; Thu, 01 Feb 2024 14:25:10 -0500
X-MC-Unique: uV2CZR5TP1uRK-ktbViTjQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a36650b64d4so72267266b.3
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 11:25:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706815509; x=1707420309;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1pymmuAcrkj7CRqmIcYx/9SdQjZc3Gb30MeSUSMaiPQ=;
 b=i8X4Z9xzCkpdRBOsLL27R2kYQzP25MdUH/kWDgsv4Iw8h43BnoQe8xXeEltdhUgLCh
 z9HeSfCA2I1MvLKs6OOOm1AUwBWwHZhsRz24TUmkw+pSFIxN1Ay6gafB5BlTXIrY3yi/
 WuroZAlnTyurvelPaj8AKS4Gh/Tq29DoE3SpNykVoQ/ngfUDnmQxiaLYKQkuEilseO5n
 qaa2Nnjw64MoqL5s9AIF/xQTyM/XN8WVVFzgvHBIEn+jBZ3f/3aXQYmcX7CqshPZpkcy
 wg04jMddvrsTVDmnMel+YQlN9M6AcRICE8UbhI9mQSqF5ji7hVMuw0Ruh7b/CBHyAEM5
 EGUA==
X-Gm-Message-State: AOJu0YyQ5hLYapCJsTijKprdgFNUn/VL7R74nvkKSDzvlFZ4Vdh+TwtU
 +aayhzLKVgjwKK68asFgdaxiaRsQEm9OZ2UqmslNdN9TIvsMhU+8fmtzQsDsvT9EFOuLXNqtsGQ
 w30lrsvCLaiP6bPHrGQXyqRgYJ0vwLNl8X2lMdy1F8LzWRnUUGDD7
X-Received: by 2002:a17:906:3bdb:b0:a28:c5dc:4802 with SMTP id
 v27-20020a1709063bdb00b00a28c5dc4802mr4600710ejf.31.1706815508935; 
 Thu, 01 Feb 2024 11:25:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6mU5bLWLPaoiHY6a1Z/VJEWXe/Rp2M/XCgTT8dFkVwkCm3oK4vJe/eYcOyOc7uS57VSvpFA==
X-Received: by 2002:a17:906:3bdb:b0:a28:c5dc:4802 with SMTP id
 v27-20020a1709063bdb00b00a28c5dc4802mr4600701ejf.31.1706815508641; 
 Thu, 01 Feb 2024 11:25:08 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWDKtx2yEGol9iksyeD4rN7sF2AgGmI+vrqyzlst0hksZRZt8hIeCCr5dEeResg5grj6m2XiWcs46z+qPcQP44qQrb6MIMCriFW9bqGW1b/S47AiM9Lr0uMqP9afHPIzl2vzcoQU4xC6AIpV5a30dbfBtAe1h/K7JhTNa6uaMT+0r8=
Received: from [192.168.0.9] (ip-109-43-177-196.web.vodafone.de.
 [109.43.177.196]) by smtp.gmail.com with ESMTPSA id
 u17-20020a17090657d100b00a36c6ddf0e4sm84833ejr.144.2024.02.01.11.25.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Feb 2024 11:25:08 -0800 (PST)
Message-ID: <bffd1672-c084-4177-8a5a-51e0dbcf38be@redhat.com>
Date: Thu, 1 Feb 2024 20:25:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ide: Add the possibility to disable the CompactFlash
 device in the build
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Miroslav Rezanina <mrezanin@redhat.com>
References: <20240201082916.20857-1-thuth@redhat.com>
 <alpine.LMD.2.03.2402011326360.16176@eik.bme.hu>
 <13ab647c-df89-49ab-8f76-8ce57d519aab@redhat.com>
 <alpine.LMD.2.03.2402011352080.16176@eik.bme.hu>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <alpine.LMD.2.03.2402011352080.16176@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 01/02/2024 13.54, BALATON Zoltan wrote:
> On Thu, 1 Feb 2024, Thomas Huth wrote:
>> On 01/02/2024 13.39, BALATON Zoltan wrote:
>>> On Thu, 1 Feb 2024, Thomas Huth wrote:
>>>> For distros like downstream RHEL, it would be helpful to allow to disable
>>>> the CompactFlash device. For making this possible, we need a separate
>>>> Kconfig switch for this device, and the code should reside in a separate
>>>> file.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> ---
>>>> hw/ide/qdev-ide.h  | 41 ++++++++++++++++++++++++++++++++
>>>> hw/ide/cf.c        | 58 ++++++++++++++++++++++++++++++++++++++++++++++
>>>> hw/ide/qdev.c      | 51 ++--------------------------------------
>>>> hw/ide/Kconfig     |  4 ++++
>>>> hw/ide/meson.build |  1 +
>>>> 5 files changed, 106 insertions(+), 49 deletions(-)
>>>> create mode 100644 hw/ide/qdev-ide.h
>>>> create mode 100644 hw/ide/cf.c
>>>>
>>>> diff --git a/hw/ide/qdev-ide.h b/hw/ide/qdev-ide.h
>>>> new file mode 100644
>>>> index 0000000000..3dd977466c
>>>> --- /dev/null
>>>> +++ b/hw/ide/qdev-ide.h
>>>
>>> This may be unrelated to this patch but we already have 
>>> include/hw/ide/internal.h which may be a place these should go in but 
>>> that header is in inlcude because some files outside hw/ide include it. 
>>> I've found three places that include ide/internal.h: hw/arm/sbsa-ref.c, 
>>> hw/i386/pc.c and hw/misc/macio.h. Only macio is really needing internal 
>>> IDE parts the other two just uses some functions so macio is probably the 
>>> reason this wasn't cleaned up yet. In any case, maybe this could go in 
>>> include/hw/ide/internal.h to avoid introducing a new header or somehow 
>>> make this a local header where non-public parts of hw/ide/internal.h 
>>> could be moved in the future. Such as rename include/hw/ide/internal.h to 
>>> ide.h and name this one internal.h maybe?
>>
>> I don't like headers that much that just collect a lot of only slightly 
>> related things. That only causes problems again when you have to 
>> unentangle the stuff one day. So what's wrong with having a dedicated 
>> header for the stuff in hw/ide/qdev.c ?
> 
> Maybe that it's not obvious from the name that it belongs to qdev.c as the 
> names are not the same.

I didn't want to just name the header "qdev.h" since that could easily be 
confused in #include statements...
IMHO qdev.c is already a very bad idea for a file name here... maybe 
something like ide-dev.c and ide-dev.h would be better?

> Also some of the qdev stuff that should be in this 
> header are in include/hw/ide/internal.h so these will still be split 
> arbitrarily.

Oh, well, it seems to be a mess already... hw/ide/pci.h includes the 
internal.h header and thus opens the internal definitions to all PCI-based 
IDE devices :-/

If we can agree on a better name for qdev-ide.h, I can try to clean that 
mess up a little bit...

  Thomas


