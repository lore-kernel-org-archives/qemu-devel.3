Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE92C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 08:59:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCE8p-00086V-2t; Tue, 06 May 2025 04:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uCE8n-00085y-77
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:59:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uCE8k-00088U-Mg
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746521941;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3oLmxjICOleaJ4ZZlmRaK63Vr6TElbfPLkAnWp0P9/Q=;
 b=JHmh7tNNdvKOP7WUCyTUTe7PCjeLCKB5lYfOvHRx2WH45itvl8F4FV4ATknn5zQ65RZKNd
 EEFunbblKATKgnXOwE4EOjpqw73gIAdkSGrYDw03YDXe2KYdgRkeQUSdcsNhsjmHo8GQpb
 F13XO+1QP6EWGQGK8HTRJ82rCDZd2AQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-pRZzkV9LOYuMEXTqLVqF8A-1; Tue, 06 May 2025 04:59:00 -0400
X-MC-Unique: pRZzkV9LOYuMEXTqLVqF8A-1
X-Mimecast-MFC-AGG-ID: pRZzkV9LOYuMEXTqLVqF8A_1746521939
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3912a0439afso1512394f8f.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 01:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746521938; x=1747126738;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3oLmxjICOleaJ4ZZlmRaK63Vr6TElbfPLkAnWp0P9/Q=;
 b=lHRL9TlQUx6FkkJxo1nC0XAQ8SQdItLCAKJDyAuHIofytlkZnE6AKfzN/HUeaM2Xm0
 Nk8DF9gQyaGOe1WrEyMtU4g/vv4SFMf7DuQDSH5uNmJUHhw3us0N4zAhb9buUAcHWMPz
 UlUSQWGvNMKmGWnIoSeMtQwWbzqFOYanEA99vatsWUf5eSzjKe5pkyZi0hcWuqscu5W8
 3KM2VwrLVk91S5vSac+uQGuBZy/uQffBK/EWQ1yv49Jz8S65uScMmQklLWDCIRjhB1me
 GqCo9l9od+t4ChKWw3YlFU49ImBCOmUzEzf9tLpR9Z8bGTM50dVs01Ei17S9H3+MAmsJ
 BQvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDFqWjFdt3M9FmqHAj8ta4RBV/85WBtPjcAyyx6AvPfqWWk4es/chjehCM2WCaeZj9/xwTW6BM7Wwr@nongnu.org
X-Gm-Message-State: AOJu0YySJfEmWZhETH724eTVMPYfwKH685nAzRLKtWxgvEVYRa+C96bD
 C9ZB0jLGRSUHBe9nrO1osvWRqOn6hBNQ8KZX07dGzsHkO7G1xDZaimenjcYGAx9mgRIsPi4FeTz
 O4iklfOsAQ9Lm116SYaUptg9t3bu5GjwO9xVgQ8N8Lof3jAgnsHX8SurD/BKo
X-Gm-Gg: ASbGncuhLDy9rc2GuIdsfXmL6q9u1z30aUdc0ELpCqQbxXY/JHj+oyDTQfgscq2BWLx
 kZ+M39jFjuTJgYfrwmb6lbcNalLPKUnv1reyySBgvDLHWIYDaFCrRm9pbxbuBY9m1iVT7iIimmt
 7TMzUpXWoFABQ0MrjmCiYjrZ/Qfms85KDX30CC5EaZlBeayX2v0dXXwuI8l8vKERZHi8ou7wz/u
 poLae3zwQj/XjhHRojHzQ+BIqI1YzgKSXHyGqjIMyygauJ+vXA2XvJ4wC+Us2u20BN8LW4zhvXF
 uL7LbTP4yOM/JjjJzj4TlFZVYW4ACxDy1/GoN1Mbvev8aLUc2k//hN3Flv0=
X-Received: by 2002:a05:6000:4383:b0:391:22e2:cd21 with SMTP id
 ffacd0b85a97d-3a0ac1ff33amr1623929f8f.36.1746521938121; 
 Tue, 06 May 2025 01:58:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0X7cA8inR5GsNgTdqOs1F1czfzBT1PMZxfct4egn2rqLfLXmZK36Na9z0wLq3N1yBKsgBaQ==
X-Received: by 2002:a05:6000:4383:b0:391:22e2:cd21 with SMTP id
 ffacd0b85a97d-3a0ac1ff33amr1623906f8f.36.1746521937682; 
 Tue, 06 May 2025 01:58:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae7caasm13161033f8f.54.2025.05.06.01.58.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 01:58:56 -0700 (PDT)
Message-ID: <4941224c-75cc-488a-9107-74c6f7f89560@redhat.com>
Date: Tue, 6 May 2025 10:58:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/acpi/pcihp: Fix typo in function name
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-trivial@nongnu.org, philmd@linaro.org
References: <20250504215639.54860-10-gustavo.romero@linaro.org>
 <b0faa0cf-8c68-4385-923c-e761b6582cc0@redhat.com>
 <6523849b-b44c-4176-ba5f-78a606621eb6@linaro.org>
 <c66f47ae-ccb9-47b2-9bbe-fb1386958e6f@redhat.com>
 <5b507a45-133d-4340-b677-e8fc49bfbfd8@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <5b507a45-133d-4340-b677-e8fc49bfbfd8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Gustavo,

On 5/6/25 2:26 AM, Gustavo Romero wrote:
> Hi Eric,
>
> On 5/5/25 11:19, Eric Auger wrote:
>> Hi Gustavo,
>>
>> On 5/5/25 2:29 PM, Gustavo Romero wrote:
>>> Hi Eric,
>>>
>>> On 5/5/25 04:13, Eric Auger wrote:
>>>>
>>>>
>>>> On 5/4/25 11:56 PM, Gustavo Romero wrote:
>>>>> Fix typo in QEMU's ACPI PCI hotplug API function name that checks
>>>>> whether a given bus is hotplug-capable.
>>>>>
>>>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>>>>
>>>> For awareness, there is a similar typo in pci-port.
>>>> see
>>>> https://lore.kernel.org/all/20250428102628.378046-2-eric.auger@redhat.com/
>>>>
>>>>
>>>
>>> hmm it's unfortunate that I was about to publish a series to exactly
>>> enable the APCI PCI hotplug on ARM. Next time I should try to sync
>>> better
>>> with Red Hat folks on the work fronts...
>> Sorry to hear that. That's always a frustrating situation :-(
>
> Yes...
>
>
>>> I've skimmed through your RFC and it seems to be doing mostly of what I
>>> was doing for my series, so I'll reviewed it formally today, it should
>>> be quick.
>> I guess we may need to add some additional qtests for hotplug (just as
>> they have on x86). Maybe we can collaborate on this or you already have
>> some stuff under work.
>
> Sure, the new test I'm baking is the one I've used in the smoke test.
> I'll
> contribute it on top of your series so.
sure
>
> For the x86 "parity", which tests you're thinking of to add for arm64?

I found
https://lore.kernel.org/all/20200918084111.15339-1-ani@anisinha.ca/#r

so in tests/qtest/bios-tables-test.c
tests featuring various values of
acpi-root-pci-hotplug/acpi-pci-hotplug-with-bridge-support

Cheers

Eric
>
>
> Cheers,
> Gustavo
>


