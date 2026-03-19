Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C9C81075270
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 17:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3HAF-0005dE-4f; Thu, 19 Mar 2026 13:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1w3HAD-0005ck-MP
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 13:28:05 -0400
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1w3HAC-0007B9-0E
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 13:28:05 -0400
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-5ffbcfbcecaso516412137.3
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 10:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773941283; x=1774546083; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4nnmHB3nqwGj5UofgUlAJM++PQ8DaK/tC1D4HESzjSQ=;
 b=CisZgd0ceHSWLs2HOXWpGFeQQeuzo0OWChkm3PfmgnXs8gGpVuUnwNLKAwVYHxomFZ
 6X3ZukdReUkvpHvwjTmIKV3Op/csK7nbcl3AWIdY2aZVKz/tnifPz//YjpJmq5Lk6RN6
 J851NzkxgKRDmzC0d5aNJW3yMMyyXLh0Eauzb7R+5yghBxE7QqD+RCrD7Q0Yt1z22fYA
 em6Bdh76MJUvbyFc4KvGTF/RUHlvb/35dkFiQtGm9A83dHUfDVJyYnQUYjee/UYGqFn0
 9QQMJof9pcxdQS6iwkPXawSmW8WyQMWQsPIqfQwbVzHGAv69OIgA++Zfq2ThfSaPSKMJ
 MNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773941283; x=1774546083;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4nnmHB3nqwGj5UofgUlAJM++PQ8DaK/tC1D4HESzjSQ=;
 b=oMD2c/Dvj06KGlAfTzTZuz6041fF8jNQP7EI3QY2OCQV5ZjySYd1kflentCHRIy/ZL
 ouHrMEY9uXMUNKq4X2+QC74XYS/QdDDbKa+Sq43nLB2G3uuNQLRjqWhXo3BfHhUiKjVA
 nSBXYnBiDHjzbxV6NNGALaHcb698jeYh4v+sWcL15Z/amtEmCubnbDRLxjSdr1fCcZtT
 pKBsJUq/d4H0DBhNkTgxggl3ajfQH4Z6hTlBA3YORF4MCC6dQu8xLQMAh8TZrtt1+7QV
 HaGxrqHKLpXlFaGCmIoRvNVi9r+tW+5QYw4JAYBX+YcQKgv4PUMByo+7aqVvlYKl6+oC
 pVEA==
X-Gm-Message-State: AOJu0YzFT+xliv5FZSVXPEayIxtDc4b2Wsl4t+uEh4Y+f5tNl/XQ+bwx
 RPBZ7wWxWNyvbhHr3XpG51jSe031VmsgxlKwIgeEJtt7VaSfNEDUj3DH+qkAZpIYM4A=
X-Gm-Gg: ATEYQzzVqr57fKZjBkMVlpJprFhm6847OdJY4D8w5RdckTk5k3iQdqfXiibOMC0CUQf
 HlZCPX2sQGGKd1I+PKP1csSAoY1reXrEjAofKZXdQuykZ63/1ee7LviBj4TEskkO3dy42o1/6nN
 9FDREs3sCuzun/hRuHRP4qsNnA4PcnAoXdH+kqpKZvX7Ug6/hCcL5C18Be2Q0ZeXW9hF8d5tIiX
 LKp181gXCceKHCvmkPc5qcyw1S6kVtbvb9+R7J8Mb3xTK91nw1z3+sW7FI5Zi2mO57doum1bilD
 QAMKEEMt5+QZCfDgfRwLplHMJfq9z2Utnkuloay1+4C9AVfPuLZEhL1A93RXuvnFKsSXDX7YS+L
 XW/VuuNRC36MB9asn7wWEGAaccj1C/EDIqntxpsE6ycZxj5fbpTz8nmSuk7NkBNTI0zE7sAoyak
 EGfr7oksrJu8dX1wvtTHXX/G71F3zWgJCcXp60
X-Received: by 2002:a05:6102:6a83:b0:5ff:fd17:d74e with SMTP id
 ada2fe7eead31-602aed999c4mr189575137.34.1773941282654; 
 Thu, 19 Mar 2026 10:28:02 -0700 (PDT)
Received: from [192.168.0.103] ([177.146.137.168])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-602af8539b1sm41593137.1.2026.03.19.10.27.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 10:28:02 -0700 (PDT)
Message-ID: <c04a5077-e122-4784-91ad-259055c0f63b@linaro.org>
Date: Thu, 19 Mar 2026 14:27:57 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/7] hw/arm/virt: Add machine option 'mec'
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, richard.henderson@linaro.org, 
 alex.bennee@linaro.org, peter.maydell@linaro.org
References: <20260319022335.22523-1-gustavo.romero@linaro.org>
 <20260319022335.22523-6-gustavo.romero@linaro.org>
 <20260319094642.00007696@huawei.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20260319094642.00007696@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vs1-xe32.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Jonathan,

On 3/19/26 06:46, Jonathan Cameron wrote:
> On Wed, 18 Mar 2026 23:23:33 -0300
> Gustavo Romero <gustavo.romero@linaro.org> wrote:
> 
>> Add new machine option 'mec' that enables and sets the memory used by
>> FEAT_MEC.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> 
> Drive by comments only. I'm curious enough to read the patches
> but no idea if this is how people would like to see this implemented!

Thanks for taking a look at it and for you comments.

In which sense do you mean exactly? Do mind to elaborate a bit more on 
it? If it's about the whole implementation, would it be about not
really encrypting data or something else? Please help me to understand it :)

I'm not sure if you're talking about just this patch or the whole 
FEAT_MEC design.


Cheers,
Gustavo

> Jonathan
> 
>>   static void create_secure_ram(VirtMachineState *vms,
>>                                 MemoryRegion *secure_sysmem,
>>                                 MemoryRegion *secure_tag_sysmem)
>> @@ -2267,6 +2288,8 @@ static void machvirt_init(MachineState *machine)
>>       MemoryRegion *secure_sysmem = NULL;
>>       MemoryRegion *tag_sysmem = NULL;
>>       MemoryRegion *secure_tag_sysmem = NULL;
>> +    MemoryRegion *pseudo_encrypted_page = NULL;
>> +    MemoryRegion *tuple_memory = NULL;
>>       int n, virt_max_cpus;
>>       bool firmware_loaded;
>>       bool aarch64 = true;
>> @@ -2495,6 +2518,28 @@ static void machvirt_init(MachineState *machine)
>>               }
>>           }
>>   
>> +        if (vms->mec) {
>> +            if (tcg_enabled()) {
>> +                if (tuple_memory == NULL) {
>> +                    /* XXX(gromero): Add object_property_find(cpuobj, "tuple-memory", ...) here. */
>> +
>> +                    tuple_memory = g_new(MemoryRegion, 1);
>> +                    memory_region_init(tuple_memory, OBJECT(machine), "mec", UINT64_MAX / 32);
>> +
>> +                    pseudo_encrypted_page = g_new(MemoryRegion, 1);
>> +                    memory_region_init(pseudo_encrypted_page, OBJECT(machine), "mec-page", 4 * 1024 /* 4 KiB */);
>> +                }
>> +
>> +                object_property_set_link(cpuobj, "mec",  OBJECT(tuple_memory), &error_abort);
>> +                object_property_set_link(cpuobj, "mec-page",  OBJECT(pseudo_encrypted_page), &error_abort);
> Trivial but some bonus spaces.
> 
>> +
>> +                } else {
> 
> Indent seems off.
> 
>> +                    /* Check for other accels here. */
>> +                    error_report("MEC requested, but not supported");
>> +                    exit(1);
>> +                }
>> +        }
>> +
>>           qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
>>           object_unref(cpuobj);
>>       }
> 
> 


