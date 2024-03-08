Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACFBC54E58
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 16:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rick5-00033o-OS; Fri, 08 Mar 2024 11:06:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ricjq-0002rr-8J
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 11:06:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ricje-00070h-6m
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 11:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709913972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DFwyI+LafVTgTQ8KuriHEE3YjPXqEA/mpJbW4J1VkE4=;
 b=cVsNcEXkQXUYmgdnjwrAV33x7gv8dzphbIct3QuvQvt7z/y5O50hBl/sC9ETnf7SPDfCjJ
 C3orbqn5afgKlF1P80D7Mf6gYd6UG6qg0a/ijrU/r+EdS3BteVZjNZSyof1N3M242okwTd
 yiZpRJTZJl8EZLIaYGNk/4nXh2oj6DA=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-4OvennTPMGe7VbYSVYFMUA-1; Fri, 08 Mar 2024 11:06:11 -0500
X-MC-Unique: 4OvennTPMGe7VbYSVYFMUA-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3c23270d2b3so806646b6e.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 08:06:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709913970; x=1710518770;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DFwyI+LafVTgTQ8KuriHEE3YjPXqEA/mpJbW4J1VkE4=;
 b=JALUsAGiOKvcix9nTAxgsdStAWtGtK5jJVqcHsgXkH9S6PDkj5G0q9T5UTo5uCVQDN
 gd8x9K4oTZPuuEE/Oz9Ez03WmqFq1PMakCWGSZQylqQ/6qc3LRqLmopAXKptf4yGe52+
 GQJHbX4laB6MoNvibu9zz0stinzB0dq8rasNCHTjtruBFgGpRMXKf21Ug5o3wu/oiNpw
 R3t+iMt511ix7FCcxCYBF0NGlnmlTPLXOMuZ0lAGA4R93LXdBfwzhyWy4O7p30FF14bF
 46LgTRgVAyyGqhLrYcSlQ+ISU9FD2nWzwNCFhwfz7zvuBc1c6IYrg1q1n6RemTAGyb74
 hY+g==
X-Gm-Message-State: AOJu0YyK6MlZOJIUv5MRSMTG98Alo7FXX9ipcnkvSHGJL45/uCSHdkj/
 dwTQEVUSpy48JiKXOhfJejApHNSM09KEg9bIy6NZ0g6AS4B8SKYPSrRYtTtO64owzpmP74zecTM
 4cHFi2t3QG3vEsUeJC8+mBzaYQ39jV8djiiRHb/gdlmuz9+nRJ51B
X-Received: by 2002:a05:6358:5e0a:b0:17b:5e32:6009 with SMTP id
 q10-20020a0563585e0a00b0017b5e326009mr12772074rwn.11.1709913970683; 
 Fri, 08 Mar 2024 08:06:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcpDKl6HtSys+y1pasxzk3HGOpZxEgEVMltep9wNApv1dReQHiq7CxmrB1Pg0+XJLIgiE13Q==
X-Received: by 2002:a05:6358:5e0a:b0:17b:5e32:6009 with SMTP id
 q10-20020a0563585e0a00b0017b5e326009mr12772043rwn.11.1709913970361; 
 Fri, 08 Mar 2024 08:06:10 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-151.web.vodafone.de.
 [109.43.178.151]) by smtp.gmail.com with ESMTPSA id
 k8-20020ac81408000000b0042f0945e558sm3301597qtj.4.2024.03.08.08.06.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 08:06:09 -0800 (PST)
Message-ID: <52e08f6c-7698-4649-9bea-fd537f59fa2f@redhat.com>
Date: Fri, 8 Mar 2024 17:06:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] hw/i386/q35: Wire virtual SMI# lines to ICH9
 chipset
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Anton Johansson <anjo@rev.ng>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
References: <20240226164913.94077-1-philmd@linaro.org>
 <20240226164913.94077-5-philmd@linaro.org> <Zd9iz9aIwM3cOqwt@intel.com>
 <5a42a295-bb1e-49f6-ae1d-94aec1efb61c@redhat.com>
 <6be774d0-6277-4d50-b97b-a0177cad8fd8@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <6be774d0-6277-4d50-b97b-a0177cad8fd8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 08/03/2024 09.08, Philippe Mathieu-Daudé wrote:
> On 7/3/24 20:43, Thomas Huth wrote:
>> On 28/02/2024 17.43, Zhao Liu wrote:
>>> Hi Philippe,
>>>
>>>> +/*
>>>> + * Real ICH9 contains a single SMI output line and doesn't broadcast CPUs.
>>>> + * Virtualized ICH9 allows broadcasting upon negatiation with guest, see
>>>> + * commit 5ce45c7a2b.
>>>> + */
>>>> +enum {
>>>> +    ICH9_VIRT_SMI_BROADCAST,
>>>> +    ICH9_VIRT_SMI_CURRENT,
>>>> +#define ICH9_VIRT_SMI_COUNT 2
>>>> +};
>>>> +
>>>
>>> Just quick look here. Shouldn't ICH9_VIRT_SMI_COUNT be defined outside of
>>> enum {}?
>>
>> Or even better, do it without a #define:
>>
>> enum {
>>      ICH9_VIRT_SMI_BROADCAST,
>>      ICH9_VIRT_SMI_CURRENT,
>>      ICH9_VIRT_SMI_COUNT
> 
> This form isn't recommended as it confuses static analyzers,
> considering ICH9_VIRT_SMI_COUNT as part of the enum.

Never heard of that before. We're using it all over the place, e.g.:

typedef enum {
     THROTTLE_BPS_TOTAL,
     THROTTLE_BPS_READ,
     THROTTLE_BPS_WRITE,
     THROTTLE_OPS_TOTAL,
     THROTTLE_OPS_READ,
     THROTTLE_OPS_WRITE,
     BUCKETS_COUNT,
} BucketType;

... and even in our generated QAPI code, e.g.:

typedef enum QCryptoHashAlgorithm {
     QCRYPTO_HASH_ALG_MD5,
     QCRYPTO_HASH_ALG_SHA1,
     QCRYPTO_HASH_ALG_SHA224,
     QCRYPTO_HASH_ALG_SHA256,
     QCRYPTO_HASH_ALG_SHA384,
     QCRYPTO_HASH_ALG_SHA512,
     QCRYPTO_HASH_ALG_RIPEMD160,
     QCRYPTO_HASH_ALG__MAX,
} QCryptoHashAlgorithm;

Where did you see here a problem with static analyzers?

  Thomas


