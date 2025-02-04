Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31F2C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 18:25:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfNbU-0003st-Aa; Tue, 04 Feb 2025 13:24:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfNbS-0003sA-CS
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 13:24:54 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfNbP-0002cD-Kb
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 13:24:54 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38dae70f5d9so524133f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 10:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738693490; x=1739298290; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PuoMbFTQ2eHa6eRLB3+BZbU6oebJ1wBzjsF+hO3gTOE=;
 b=Qdr+ycaSIWZmHcurO8NdCP2BiatazzRFJ8tC5IyscPOimFdkhWyvxI18Lm/N3R3Xpj
 NNULOmO/bQNEu7zxOOYuiK6XFQyfogwcHR7tcAaDg5GjaCpyW/7GZ7T5zLSBmkSo40fm
 +PAF/6OiLIetBkbzA/RDl9yu1hZgjx1THF4i5mKGgarBajrXN66j6lE0eSrGov2Z4JO0
 FtSvlYLw0+Kh1eOgq3n/ZN4raFgce1MTw4Ml9lC+9iQV7RO8/nEiuheEK1P0bm+ktjVn
 1KptgLgf7FsC3gynL0q7fD/mTgGYkpGDqzbp9wWwAsl0gjGOWu2IAzqc5+dzNRqqmdj6
 CoJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738693490; x=1739298290;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PuoMbFTQ2eHa6eRLB3+BZbU6oebJ1wBzjsF+hO3gTOE=;
 b=aUM23Y7jEj72UQOduKbJxmGOmI+HIfuVu+cFtj5kT/lCh12Yk0HU/I58ROmhrEwNmc
 QShYj7eNMP+hnHJSRFH19ZBMuxTb+Chkakuph+owbbIi4JEZigwWZ9aDeDarYIIxNVFQ
 cWAROZSQ1eYp1N0A54NYyTvfJZxdadqUYDMVY9Y/4QEg9izUVZTovnemsUnmPBaQ8qFk
 StZDVA41WbF+PV+yBHrPD2RDv3gFiwVH/rRGpocNLDmxmqp1Wh6yrnlTZiCWPxkA13hr
 xwr1se+P9ekTJ+k9MOfCwfYs7suMDT1aVFNSNZt18coZkggFnDjSqxDQPY+ksRchQyCA
 MNGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAi4rXvN+v+wafblzCCITkpLBYsgcGqq50vlLdR/aRE6PpymsQ0BFa3Bx3woDXOsiHTQ4ZBTPtezdm@nongnu.org
X-Gm-Message-State: AOJu0YxtJ4aaefOejLrfcO+10rRw3uLKzzv501ZLHBYSaRz2e+QtNqLg
 J5LgAYo9/SqOSI4GLBVQ4Mrh/SA3SYm2KXB9Y8r2nrABUJyZeS/iGKpUnpmYw+I=
X-Gm-Gg: ASbGncuZ4liZ7TN4WGcXx9EKE6dK35HFh1HbMaGOy/zGCahItDQR+XN4+NMcGUrbUT/
 PkcGTjbi9IfelOBSYEj4ZwIuHkjbTGQXIaxLGlUSEBUFtvFhsNnh7i5Qz4nAu/3SIrynxSS4bZ3
 sTyrXBK3E+7j5WxaOjryQbAr7O+1opJpy7TdtH6Wk4rqqxXkKco/JmKSIVaOoHjkiDJ+Kc0M4H8
 3N5aDXYHJC3sYXnseWC66+PLTIySm/71XGuWvHtLi8OLtY+2jRUUR4Q3m6+JZ87SNc8NWNOjO06
 OH9F3rr9w8tyY9R8Aer5Wl+NdATurs17yHooqJILuYnkB4gOSnUAJX5Moe4=
X-Google-Smtp-Source: AGHT+IGMKxGxDb/j2qbXnf5PRic+yXPG6iOs9rrEp1hnBxzboe35Md0uQzE6zPChU2pZB855fBG0XA==
X-Received: by 2002:a05:6000:381:b0:38d:b114:4be4 with SMTP id
 ffacd0b85a97d-38db1144c2cmr1350067f8f.47.1738693489808; 
 Tue, 04 Feb 2025 10:24:49 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1016easm16503884f8f.24.2025.02.04.10.24.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 10:24:49 -0800 (PST)
Message-ID: <ef83d303-e891-495c-ba1d-d95129fdbf25@linaro.org>
Date: Tue, 4 Feb 2025 19:24:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] hw/boards: Rename no_sdcard -> auto_create_sdcard
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
References: <20250204180746.58357-1-philmd@linaro.org>
 <20250204180746.58357-4-philmd@linaro.org>
 <31346ebc-aa7d-45f2-b840-6dc3450983c6@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <31346ebc-aa7d-45f2-b840-6dc3450983c6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 4/2/25 19:19, Thomas Huth wrote:
> On 04/02/2025 19.07, Philippe Mathieu-Daudé wrote:
>> Invert the 'no_sdcard' logic, renaming it as the more explicit
>> "auto_create_sdcard". Machines are supposed to create a SD Card
>> drive when this flag is set. In many cases it doesn't make much
>> sense (as boards don't expose SD Card host controller), but this
>> is patch only aims to expose that nonsense; so no logical change
>> intended (mechanical patch using gsed).
>>
>> Most of the changes are:
>>
>>    -    mc->no_sdcard = ON_OFF_AUTO_OFF;
>>    +    mc->auto_create_sdcard = true;
>>
>> Except in
>>   . hw/core/null-machine.c
>>   . hw/arm/xilinx_zynq.c
>>   . hw/s390x/s390-virtio-ccw.c
>> where the disabled option is manually removed (since default):
> ...
>> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
>> index dc80181ea43..2d626a96b9b 100644
>> --- a/hw/arm/xilinx_zynq.c
>> +++ b/hw/arm/xilinx_zynq.c
>> @@ -463,11 +463,10 @@ static void zynq_machine_class_init(ObjectClass 
>> *oc, void *data)
>>       mc->desc = "Xilinx Zynq Platform Baseboard for Cortex-A9";
>>       mc->init = zynq_init;
>>       mc->max_cpus = ZYNQ_MAX_CPUS;
>> -    mc->no_sdcard = ON_OFF_AUTO_ON;
>>       mc->ignore_memory_transaction_failures = true;
>>       mc->valid_cpu_types = valid_cpu_types;
>>       mc->default_ram_id = "zynq.ext_ram";
>> -    mc->no_sdcard = ON_OFF_AUTO_OFF;
>> +    mc->auto_create_sdcard = true;
> 
> That's now wrong, too ... it should get removed (as you say in the patch 
> description).

Thanks, mis-rebase I presume :/

