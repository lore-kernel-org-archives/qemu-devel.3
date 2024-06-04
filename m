Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22574C27C50
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQTp-0002Y8-Bq; Tue, 04 Jun 2024 05:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQTj-0002Xo-Ur
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:29:16 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQTi-0007O1-74
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:29:15 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42134bb9735so29500865e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717493350; x=1718098150; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hJd5YyeV3u5psbeSkLNnDhgAg2SP9glHgUhOad+G5iE=;
 b=AGq68y658PtCbJCRcTfHiWnRHl9FePqFDcX5frgUiSCx19Z1OBKTIxyzrM+x+ti2F8
 mX8tgsfbdYzUAxFcZW1SR6iXdq/Lx6K9ZscAPqfRgvwUZ+5BSRsOkwLTnrMOi91e4Hio
 NHW8BVS5JyDE/uNZd0u/nzW2lyH1N5XiLF02n4IH5+xlBnIZHvm9Pd8usNDQePhSPM+Z
 vK9iggLMz/c70G4NtW3DahNjc8U07QKo++tUkOpkG3PMGBgv84W6x0FaF3sTXxx4ZFbw
 nDd20P4GPTiAQ7yewHoVbDMxA9XNsVnW+pULlbkFgy5ggkhIx7OD+UPXnCcelM5RFOAJ
 dw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717493350; x=1718098150;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hJd5YyeV3u5psbeSkLNnDhgAg2SP9glHgUhOad+G5iE=;
 b=gRcUFsBeMeaSOWq5suCHlcDezROwIZCnmcDnj01cDxSQI3UNQCXqiJI6hg1vdg/ceV
 IMRxrqdQwNSdKcrMhs2ekOM9YFI4IIsTPQqhbo2JftVq5HixuE/IOPDF+mwIVWUShPS1
 eAT6S06xC0rDOoNTVduZ5HTquPrfzKs1R7SpmQ8h5/7WIT/MQJY0hQ2cbGvcqtN1U6/W
 9xapwJjN8IOwifX5hfTVeGxOs6n6PsGBbkVY2tzXnexEnCAhtCQw35lxozTibM+V9FCu
 SnLlSRxLSV3pfKnTV4YbjrMfHekz11Q/dWMktQngHboOwNC08jptPvEFH5o5ObB25yZD
 cNnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS5yi6qCdBWXvYMieywkrODnQiAkwU00sKnvG1Gpk8eHGtTvML80O03VQMIJJ5tlZF+hBTz0ISO/HnA6RlaudIShh19v8=
X-Gm-Message-State: AOJu0YwqTwy499W1WoEQ/mPKAmbvRqVHGOMcqJiMoG5zQv8Qh7hL9mbm
 kVerZgpSXAV3cZS/T1Q/D1M6GL2FpaIiPG7OX598laGPwXxGZWuzHR1fWjfW0f4=
X-Google-Smtp-Source: AGHT+IEx0pz4MS9ahBK3OcE6wVNiY+CBUbXVhmjzm3tu+zulvjHwLjVA7BcNDe2Zuu3ezl8zig0ZPw==
X-Received: by 2002:a05:600c:3c98:b0:41f:3ee0:a302 with SMTP id
 5b1f17b1804b1-4212e0ae746mr100832485e9.30.1717493350486; 
 Tue, 04 Jun 2024 02:29:10 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212705692csm177083875e9.10.2024.06.04.02.29.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 02:29:09 -0700 (PDT)
Message-ID: <b3567da2-78c7-49b4-a149-075484d0c004@linaro.org>
Date: Tue, 4 Jun 2024 11:29:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0?] docs: i386: pc: Update maximum CPU numbers for
 PC Q35
To: Zhao Liu <zhao1.liu@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>
References: <20240412085358.731560-1-zhao1.liu@linux.intel.com>
 <305d659b-d4d6-4681-bdad-cd869e552333@linaro.org>
 <20240602092857-mutt-send-email-mst@kernel.org>
 <77840065-1ad4-42bc-a19c-181ac7d63cf1@linaro.org>
 <Zl7WKKN9wGmlVwnX@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Zl7WKKN9wGmlVwnX@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 4/6/24 10:54, Zhao Liu wrote:
> On Mon, Jun 03, 2024 at 07:31:47PM +0200, Philippe Mathieu-Daudé wrote:
>> Date: Mon, 3 Jun 2024 19:31:47 +0200
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Subject: Re: [PATCH-for-9.0?] docs: i386: pc: Update maximum CPU numbers
>>   for PC Q35
>>
>> Hi Michael,
>>
>> On 2/6/24 15:30, Michael S. Tsirkin wrote:
>>> On Fri, Apr 12, 2024 at 11:57:35AM +0200, Philippe Mathieu-Daudé wrote:
>>>> Hi Zhao,
>>>>
>>>> On 12/4/24 10:53, Zhao Liu wrote:
>>>>> From: Zhao Liu <zhao1.liu@intel.com>
>>>>>
>>>>> Commit e4e98c7eebfa ("pc: q35: Bump max_cpus to 4096 vcpus") increases
>>>>> the supported CPUs for PC Q35 machine.
>>>>>
>>>>> Update maximum CPU numbers for PC Q35 in the document.
>>>>>
>>>>> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
>>>>> ---
>>>>>     docs/system/target-i386-desc.rst.inc | 2 +-
>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/docs/system/target-i386-desc.rst.inc b/docs/system/target-i386-desc.rst.inc
>>>>> index 5ebbcda9db4c..319e540573d3 100644
>>>>> --- a/docs/system/target-i386-desc.rst.inc
>>>>> +++ b/docs/system/target-i386-desc.rst.inc
>>>>> @@ -36,7 +36,7 @@ The QEMU PC System emulator simulates the following peripherals:
>>>>>     -  PCI UHCI, OHCI, EHCI or XHCI USB controller and a virtual USB-1.1
>>>>>        hub.
>>>>> -SMP is supported with up to 255 CPUs.
>>>>> +SMP is supported with up to 255 CPUs (and 4096 CPUs for PC Q35 machine).
>>>>
>>>> This comment is not accurate since a while, IIUC:
>>>>
>>>> Up to q35-2.7: 255
>>>> q35-2.8: 288
>>>> q35-8.0+: 1024
>>>> q35-9.0: 4096
>>>
>>>
>>> What are you saying here, Philippe? I don't think compat
>>> machine types matter enough to bother with more detail.
>>
>> My point is I find this description confusing w.r.t. how QEMU behaves:
>>
>> $ qemu-system-i386 -M pc-q35-2.8 -smp 666
>> qemu-system-i386: Invalid SMP CPUs 666. The max CPUs supported by machine
>> 'pc-q35-2.8' is 288
>>
>> $ qemu-system-i386 -M pc-q35-8.0 -smp 666
>> qemu-system-i386: Invalid SMP CPUs 666. The max CPUs supported by machine
>> 'pc-q35-8.0' is 288
>>
>> $ qemu-system-i386 -M pc-q35-9.0 -smp 666
>> Unexpected error in apic_common_set_id() at ../hw/intc/apic_common.c:447:
>> qemu-system-i386: APIC ID 255 requires x2APIC feature in CPU
>> Abort trap: 6
> 
> For tcg, it needs to set x2apic=on in -cpu.

Thanks for clarifying. Using error_append_hint() is certainly
better than aborting or asking on the mailing list (from user
perspective) ;)

Regards,

Phil.

