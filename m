Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C8FC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 16:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ridHZ-0004o4-9F; Fri, 08 Mar 2024 11:41:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ridHW-0004nX-Uc
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 11:41:14 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ridHV-0005G0-6z
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 11:41:14 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33e17342ea7so654302f8f.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 08:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709916071; x=1710520871; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jJci/vgVamCE21h5fRixdOtAVjmSBm65EdcznxCWCns=;
 b=QY/Keu7hUYU7OUzWOh/ObKVw6sLqyIPZUHH2oW6249TQt51b1ztdVGCR8b23gEG7ll
 BKilyzyTgJDP+/dmvQxinnVbTRED1OH8RaRb8H1E8tqKxaxrTw7lNUpsy1xTV7uT+/4e
 ZDZr2mJ4MdnWtD12Bc/FV/gZakcCzf9fDokj+Bhcl7/2Uma1PiZjBSjZb2H5lWtEhpB1
 TUVZJU0+mqtAiS7Dof3tB1EItdkyuNN3W6p4Y9BXvuGnCjgsE54UIcSoYpfSWUlznUDo
 NCl3pNFWpSRVxAfSQiUyDQfV4uy7dkjmMmvONOFm2vYFgXG+rdfqJmNa+pg3X6pQshuH
 Kt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709916071; x=1710520871;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jJci/vgVamCE21h5fRixdOtAVjmSBm65EdcznxCWCns=;
 b=dyDEwwyX8mil+TNWFscfzXpfrx5tpNyaAow4BobK/Fm5zf/63mxDjq5xuViPfSe08o
 ydk9YLsmnCZueFqmcwV69TfBw0GNl3LAcQ+P+2gm/k5pKRr6/5e/qpXqCnj7NS8gPeoY
 1KcmX2SZdTTz05fDyCBOuccUicYP+rGF4tfk5yAFXFgknv4USCo73+igP0927kCJG2rF
 GRSZlOOZE3tQiBjWE2GRQfMCDaU9BfxNoHS65+zX0APBP5QHXlLYh7ZptYNSKWfcCZ42
 g+pw6Ux0L2kQVpQLKrt2wwzSIrV4c6BBaT9tk0YlojJNADERGpk/Umn4oJCriVNnEhhH
 6dJQ==
X-Gm-Message-State: AOJu0YwzISdL2KOF4E5TSgELgeghVtnBmvAPdovWtRRQZb2mYXXzrRQW
 MRDGnnwNCPCqwO1UJjoXKbAL3T7+J5AhYeV4vIkNj1SLorT0R1h/cMNJQGBFaEA=
X-Google-Smtp-Source: AGHT+IF+qbz6faN8VJbAtcDGtydbxKF1KM4A/BKRO+i+SAnszDttu+UoOzr7j8il0F6q+69AEpq1Qw==
X-Received: by 2002:a5d:526c:0:b0:33e:7a1e:d603 with SMTP id
 l12-20020a5d526c000000b0033e7a1ed603mr1122222wrc.20.1709916071155; 
 Fri, 08 Mar 2024 08:41:11 -0800 (PST)
Received: from [192.168.69.100] (cvl92-h01-176-184-49-62.dsl.sta.abo.bbox.fr.
 [176.184.49.62]) by smtp.gmail.com with ESMTPSA id
 q16-20020a5d6590000000b0033d56aa4f45sm23364970wru.112.2024.03.08.08.41.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 08:41:10 -0800 (PST)
Message-ID: <5f67fe64-9c63-4f94-8eef-02427a03f55f@linaro.org>
Date: Fri, 8 Mar 2024 17:41:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] hw/i386/q35: Wire virtual SMI# lines to ICH9
 chipset
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
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
 <52e08f6c-7698-4649-9bea-fd537f59fa2f@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <52e08f6c-7698-4649-9bea-fd537f59fa2f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 8/3/24 17:06, Thomas Huth wrote:
> On 08/03/2024 09.08, Philippe Mathieu-Daudé wrote:
>> On 7/3/24 20:43, Thomas Huth wrote:
>>> On 28/02/2024 17.43, Zhao Liu wrote:
>>>> Hi Philippe,
>>>>
>>>>> +/*
>>>>> + * Real ICH9 contains a single SMI output line and doesn't 
>>>>> broadcast CPUs.
>>>>> + * Virtualized ICH9 allows broadcasting upon negatiation with 
>>>>> guest, see
>>>>> + * commit 5ce45c7a2b.
>>>>> + */
>>>>> +enum {
>>>>> +    ICH9_VIRT_SMI_BROADCAST,
>>>>> +    ICH9_VIRT_SMI_CURRENT,
>>>>> +#define ICH9_VIRT_SMI_COUNT 2
>>>>> +};
>>>>> +
>>>>
>>>> Just quick look here. Shouldn't ICH9_VIRT_SMI_COUNT be defined 
>>>> outside of
>>>> enum {}?
>>>
>>> Or even better, do it without a #define:
>>>
>>> enum {
>>>      ICH9_VIRT_SMI_BROADCAST,
>>>      ICH9_VIRT_SMI_CURRENT,
>>>      ICH9_VIRT_SMI_COUNT
>>
>> This form isn't recommended as it confuses static analyzers,
>> considering ICH9_VIRT_SMI_COUNT as part of the enum.
> 
> Never heard of that before. We're using it all over the place, e.g.:
> 
> typedef enum {
>      THROTTLE_BPS_TOTAL,
>      THROTTLE_BPS_READ,
>      THROTTLE_BPS_WRITE,
>      THROTTLE_OPS_TOTAL,
>      THROTTLE_OPS_READ,
>      THROTTLE_OPS_WRITE,
>      BUCKETS_COUNT,
> } BucketType;
> 
> ... and even in our generated QAPI code, e.g.:
> 
> typedef enum QCryptoHashAlgorithm {
>      QCRYPTO_HASH_ALG_MD5,
>      QCRYPTO_HASH_ALG_SHA1,
>      QCRYPTO_HASH_ALG_SHA224,
>      QCRYPTO_HASH_ALG_SHA256,
>      QCRYPTO_HASH_ALG_SHA384,
>      QCRYPTO_HASH_ALG_SHA512,
>      QCRYPTO_HASH_ALG_RIPEMD160,
>      QCRYPTO_HASH_ALG__MAX,
> } QCryptoHashAlgorithm;

We tried to remove it:

https://lore.kernel.org/qemu-devel/20230315112811.22355-4-philmd@linaro.org/

But there is a problem with generated empty enums...
https://lore.kernel.org/qemu-devel/87sfdx9w58.fsf@pond.sub.org/


