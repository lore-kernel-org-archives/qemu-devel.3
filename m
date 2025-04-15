Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D3EC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 15:29:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4iE4-0005h1-4H; Tue, 15 Apr 2025 11:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4iE0-0005aD-Tl
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 11:29:24 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4iDz-0005q0-0i
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 11:29:24 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cfb6e9031so52943465e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 08:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744730961; x=1745335761; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WYetXbzoaXlV7aDMGl1Rx0xf5JZeD9u37MZPLhR4Hdg=;
 b=AEnOHNQt3OqtZ1wDlikNN1RasJ/pRdNwJ55SmDRQC0wWbblt7oj9bmJ/zy80kQ72qw
 PWgesJjL1JJUDMJd6WcrgPmtXyu2+8GV8j35g4w560QB3tFfFXfOuEkfDcTTxd6TlOek
 Nl/KHxivRRh+unSCFHy4GDruYk7zl0XQwODgwGM9BfDRCaUtp8WSvAQa3tYpKtXCqsAO
 rLPRomYa475Tu98p7aWbkFuy9Kw7nUrhyaH1yZgXArkUwdZH7st3ELRwCzO8CUO1g4vM
 CkFzarYIXkzvNRSDlSGWsn50jAaVYgyLkHseUa//zUANEidvu515EBFpPxjk1inO/wKJ
 5sEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744730961; x=1745335761;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WYetXbzoaXlV7aDMGl1Rx0xf5JZeD9u37MZPLhR4Hdg=;
 b=lMzgz1GVj1i3hDTOoblUkk1BpnJHDnD3FCaduRzOGBFWXu375kxCdt83XlQnOo4jIP
 41MvPCI7M7X1qgno/5wcW//H95KxRIqJXqPq5BAo1xmASUjMeoCU6GsWne9/yMZlWZh/
 R4h7uBAqBzC1i0mRcOEyJrVG7OEVJ3nA4cjTNdTRBaUd5XF0ivQExVlFWGzApYDZv1PW
 4XO9cuZpq7jn16cGPpUpCE8tMZ5PnLhvy9/1ZV2cqyXVIA9Ppb/o2IgjXFHyYWWqEXor
 lbLhx5WqHnNtigWa4o7jYZm9WMb8PZkk/ljlMJOu1nfs7VIT5BrxKTG1ktJVmpGPxjWg
 WSxA==
X-Gm-Message-State: AOJu0Yzsfufh/h/Ou2Bbg2kHA8js9gRCBu3X/CPhakC0hVbtk8JI8SGq
 SCU+a6y+IzKqWlQiTN8E5ohaa/kWNhZK4LT1qgDMrtVryLlFuav7x5a5XqGjckM=
X-Gm-Gg: ASbGncu6pZCyE3FxokyW+InQB0OIAooZdjH2MW/pj2vMeBpFNWPDF+EFM31XL1naXo3
 gpKFFQ3Ub+L3XMr4sCR8N9sdWw+5ZttGj4n3kkM5o0xQFRRh8BqPMmflbhY/8K5klY5ib0JvgQJ
 bMu0diJTQrCS4sJ+kkCNWP9F4I83m1jNUd8/Yj9CTB0rBjEcko/tfe/zxTztvMyGrZZbvx7SifH
 xjpPZRB7Vp839vKGPZi6c6qKo5eGYQBOZqFVQ5bF8kCnZod5RJ7o1+HcQMelvh6rcAMbHmdYROf
 fgAxzIKN9c45zubLSLJGOxFaa6Hl4Ur9Wo/QztFJJNCOEtBOTYcXxaD0twmbbcUoy0tOe0QD1it
 htVBda/PVUT8=
X-Google-Smtp-Source: AGHT+IHLCPwrC+8wQ43LrKWo0OqWkxqUMkr6zWgIwkz+RXdQ+jALchFeIf/6cP/FAJ0FLD+4mcVZEw==
X-Received: by 2002:a05:600c:4f43:b0:439:9a40:aa0b with SMTP id
 5b1f17b1804b1-43f3a9aa7b5mr100336345e9.25.1744730960787; 
 Tue, 15 Apr 2025 08:29:20 -0700 (PDT)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f235a5ec3sm213300945e9.39.2025.04.15.08.29.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 08:29:20 -0700 (PDT)
Message-ID: <6d771164-bac1-4d99-8e05-0bf65a3351ca@linaro.org>
Date: Tue, 15 Apr 2025 17:29:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 PATCH 05/13] acpi: Send the GPE event of suspend and
 wakeup for x86
To: Annie Li <annie.li@oracle.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, dave@treblig.org, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, wangyanan55@huawei.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, slp@redhat.com,
 eblake@redhat.com, armbru@redhat.com, miguel.luis@oracle.com,
 Gustavo Romero <gustavo.romero@linaro.org>
References: <20250411201912.2872-1-annie.li@oracle.com>
 <20250411204133.2955-1-annie.li@oracle.com> <87cydeepp8.fsf@draig.linaro.org>
 <5a567f2d-31d4-442c-b68c-ed85491d77d4@oracle.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <5a567f2d-31d4-442c-b68c-ed85491d77d4@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Hi Annie,

On 15/4/25 03:24, Annie Li wrote:
> 
> On 4/14/2025 11:18 AM, Alex Bennée wrote:
>> Annie Li <annie.li@oracle.com> writes:
>>
>>> The GPE event is triggered to notify x86 guest to suppend
>>> itself. The function acpi_send_sleep_event will also
>>> trigger GED events on HW-reduced systems where ACPI GED
>>> sleep event is supported.
>>>
>>> Signed-off-by: Annie Li <annie.li@oracle.com>
>>> ---
>>>   hw/acpi/core.c                       | 10 ++++++++++
>>>   include/hw/acpi/acpi.h               |  1 +
>>>   include/hw/acpi/acpi_dev_interface.h |  1 +
>>>   3 files changed, 12 insertions(+)
>>>
>>> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
>>> index 58f8964e13..00a9d226f0 100644
>>> --- a/hw/acpi/core.c
>>> +++ b/hw/acpi/core.c
>>> @@ -359,6 +359,16 @@ int acpi_get_slic_oem(AcpiSlicOem *oem)
>>>       return -1;
>>>   }
>>> +void acpi_send_sleep_event(void)
>>> +{
>>> +    Object *obj = object_resolve_path_type("", TYPE_ACPI_DEVICE_IF,
>>> NULL);
>> Is it a fair assumption there will only ever be one QOM object that
>> provides the TYPE_ACPI_DEVICE_IF interface on a system?
> 
> I supposed it was, but I might be wrong(seeing some classes have the 
> same interface). Please correct me if I've missed something, thank you!

     /**
      * object_resolve_path_type:
      * @path: the path to resolve
      * @typename: the type to look for.
      * @ambiguous: (out) (optional): location to store whether the
      *             lookup failed because it was ambiguous, or %NULL.
      *             Set to %false on success.

Since you use ambiguous=NULL, your code will only set %obj if there
is exactly ONE device implementing the ACPI_DEVICE interface created.

So far IIUC nothing forbids creating multiple ones, so if you expect
only one, you should add code to handle the "2 or more" case. Or at
least add a comment.

Regards,

Phil.

>>> +
>>> +    if (obj) {
>>> +        /* Send sleep event */
>>> +        acpi_send_event(DEVICE(obj), ACPI_SLEEP_STATUS);
>>> +    }
>>> +}
>>> +
>>>   static void acpi_notify_wakeup(Notifier *notifier, void *data)
>>>   {
>>>       ACPIREGS *ar = container_of(notifier, ACPIREGS, wakeup);
>>> diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
>>> index d1a4fa2af8..64d3ff78ed 100644
>>> --- a/include/hw/acpi/acpi.h
>>> +++ b/include/hw/acpi/acpi.h
>>> @@ -184,6 +184,7 @@ uint32_t acpi_gpe_ioport_readb(ACPIREGS *ar, 
>>> uint32_t addr);
>>>   void acpi_send_gpe_event(ACPIREGS *ar, qemu_irq irq,
>>>                            AcpiEventStatusBits status);
>>> +void acpi_send_sleep_event(void);
>>>   void acpi_update_sci(ACPIREGS *acpi_regs, qemu_irq irq);
>>> diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/ 
>>> acpi_dev_interface.h
>>> index 68d9d15f50..1cb050cd3a 100644
>>> --- a/include/hw/acpi/acpi_dev_interface.h
>>> +++ b/include/hw/acpi/acpi_dev_interface.h
>>> @@ -13,6 +13,7 @@ typedef enum {
>>>       ACPI_NVDIMM_HOTPLUG_STATUS = 16,
>>>       ACPI_VMGENID_CHANGE_STATUS = 32,
>>>       ACPI_POWER_DOWN_STATUS = 64,
>>> +    ACPI_SLEEP_STATUS = 128,
>>>   } AcpiEventStatusBits;
>>>   #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"


