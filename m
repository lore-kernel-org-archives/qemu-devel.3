Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F86C48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 08:43:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd4f3-0004Bk-0X; Thu, 22 Feb 2024 03:42:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rd4ew-00047S-SP
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 03:42:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rd4et-0003j8-TQ
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 03:42:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708591342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XsZ91pRNDs34evTQY9bnQYS/S4Z27OMkdawWuWAV/Og=;
 b=I0M4C+yEb9JrdKyIHyVy2NcORAq3YeaQAzJhUI1ceAbpGME9qGjPL3czFKA6m/t7UPMWm7
 rtcb9RraipE+B6QjMIcUOv4BmY1PlmNjuLS9fGjrLnA/MiOl2hBs9Bwi7dQOcc8KmY24s4
 g/fYpp+RpX10CpryNvp+BE0bmKhWW/w=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-lG-yq9giPAa90Fiaati9hQ-1; Thu, 22 Feb 2024 03:42:20 -0500
X-MC-Unique: lG-yq9giPAa90Fiaati9hQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a3ee38c40baso208726866b.0
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 00:42:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708591339; x=1709196139;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XsZ91pRNDs34evTQY9bnQYS/S4Z27OMkdawWuWAV/Og=;
 b=xHU7kVNIl7s8NsmAFQWZGgrpCkTf/EzfIHEYl3eQmzeUohDCFcPt/JWWFhtTeMkPYl
 rI7OEbuF07e1ruSGQHvgiBvNryTWiq2sSPePlsCkJL1CYJI1d2rPjpkfdLaHkxQWjlR4
 jkXMQZ2gs/A7iyHJw9OR+GeAfgx1Ecf0hikcC0XaYQVTrMTfrN1mhwcJgRU1t7KJlJ/3
 e/7GP6jKOQPXZ3phFflGJZKi8/LMr4MSdN3bGB4D0OkSvvempLbvBZa1HIF4Gv9lwCbK
 ENKB4jZgejjXieIGZc7NoLiqa1iJCiDT2OEb9nos3W6qvgx5k9krANQ3/3i0LcMpPOfn
 Hvhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeZDKqa8JxD/HZVkMV5eK3HJCBqBXDPLAVkJtYaP+OSI26MtAeL8ZvoNQix/LeT3yNpxPJlMccVNbW2RYx9X8DkISX5r0=
X-Gm-Message-State: AOJu0YwxuCO5JA61e7M5+Nzx1U6yixQoFtIDzgcbxgLsp2fNMtE7MVML
 tBkKlZufuCJjlbeEKzYtRbRgOiW3uxIXf9WapnqzpwoSYyjsrCFMjAKVx0GAeuStqe1Dh9GlFoj
 LWkUxZ/uOHcRskmagH8cxJ3L1M3dCOhNLSJYGJQEfGNtKDTxZJ5A3
X-Received: by 2002:a17:906:c457:b0:a3d:ed30:11c8 with SMTP id
 ck23-20020a170906c45700b00a3ded3011c8mr11912050ejb.15.1708591339727; 
 Thu, 22 Feb 2024 00:42:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmNUGRYb0JWkxjekPDiyL4inDxY9LLm7UUHGzRWt9pgLSfc8/rbkfEluH0SJPxamV/Pu5ebQ==
X-Received: by 2002:a17:906:c457:b0:a3d:ed30:11c8 with SMTP id
 ck23-20020a170906c45700b00a3ded3011c8mr11912040ejb.15.1708591339395; 
 Thu, 22 Feb 2024 00:42:19 -0800 (PST)
Received: from [192.168.52.107] ([37.84.174.18])
 by smtp.gmail.com with ESMTPSA id
 u4-20020a1709063b8400b00a3d4dc76454sm5709713ejf.159.2024.02.22.00.42.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 00:42:19 -0800 (PST)
Message-ID: <ced49047-6749-4abe-96fa-06b22099ada9@redhat.com>
Date: Thu, 22 Feb 2024 09:42:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/intc/Kconfig: Fix GIC settings when using
 "--without-default-devices"
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
References: <20240221110059.152665-1-thuth@redhat.com>
 <a1f44a85-b13e-4ab8-aea6-94200637c836@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <a1f44a85-b13e-4ab8-aea6-94200637c836@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 22/02/2024 08.57, Philippe Mathieu-Daudé wrote:
> On 21/2/24 12:00, Thomas Huth wrote:
>> When using "--without-default-devices", the ARM_GICV3_TCG and ARM_GIC_KVM
>> settings currently get disabled, though the arm virt machine is only of
>> very limited use in that case. This also causes the migration-test to
>> fail in such builds. Let's make sure that we always keep the GIC switches
>> enabled in the --without-default-devices builds, too.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   hw/intc/Kconfig | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
>> index 97d550b06b..2b5b2d2301 100644
>> --- a/hw/intc/Kconfig
>> +++ b/hw/intc/Kconfig
>> @@ -12,10 +12,6 @@ config IOAPIC
>>       bool
>>       select I8259
>> -config ARM_GIC
>> -    bool
>> -    select MSI_NONBROKEN
>> -
>>   config OPENPIC
>>       bool
>>       select MSI_NONBROKEN
>> @@ -25,14 +21,18 @@ config APIC
>>       select MSI_NONBROKEN
>>       select I8259
>> +config ARM_GIC
>> +    bool
>> +    select ARM_GICV3_TCG if TCG
>> +    select ARM_GIC_KVM if KVM
> 
> This is odd, we usually 'select' dependencies.

We could also move the two select lines into the VIRT Kconfig switch in 
hw/arm/ ... would that look better?

>> +    select MSI_NONBROKEN
>> +
>>   config ARM_GICV3_TCG
>>       bool
>> -    default y
> 
> Don't we want instead:
> 
>         default y if TCG

No, that won't fix the issue, since such statements will also be set to "no" 
if you run configure --without-default-devices.

  Thomas


