Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC854C4829F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 06:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra9Dn-0000MC-HD; Wed, 14 Feb 2024 01:58:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ra9Dl-0000Lw-DV
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 01:58:17 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ra9Dj-0005vZ-Oa
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 01:58:17 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a3d484a58f6so29809666b.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 22:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707893894; x=1708498694; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3TGxlVSnXdE3Z8EQcfcL0AyJBFbksB4NiCVh+ku2kRc=;
 b=k9j53APo4Sdpf18nhrGEHiXS+bPGahpe+ewyvpTS5ewI/l5VOswhjLTUoR46gU/ZR5
 ljl9VnRIZLH87cdinFsH383RYpdhnRT31J2eXnqjYfjRyCMpKfHvM9b/bohqEyl1xlqx
 /RxeWdFlidJGVmYGYlG5QUGGcCd8KI9JFjFzqdKx2GdWWCXG4HuBrqDXixyAn30yefso
 fvNJDMlWikzOSpDuIFTxUI7CGx03r2cXvXrvEjtfx1uuilaJz3TfTRkXv1Fsc9G/2zaH
 78PWEa56V7g0MIPL42ypVw4H3KU2wJ0ZeO18EXliY0bfYfXYnI2GsaOjMWDIcVywKYWU
 TxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707893894; x=1708498694;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3TGxlVSnXdE3Z8EQcfcL0AyJBFbksB4NiCVh+ku2kRc=;
 b=f9uLFQzdgHSbJSl4284IJ01oH8IC8XmXKA9XUtaHZ+f00ufwEctkpzwo+8Rink6+ly
 /FC1DLd++bfalugWNLQIN6QhOlRUm4HK0Y62uKlhvXBG3oeD89NIOEPtnI7OLuJYGy3w
 mzAwII1F/uS5PhJfVaR+lCpisCmS6pSVDgmRHlet+r0C8GaRVljs1yiMLxAczg9AKn3r
 i/zL8INzZpKkf7azbu0WAI8QdP5gyxiy7Rl9gPrc5mgAr9X/rTXtOGzLcKZxj6VLqTSP
 3OyJVr119nnsdDdyxraWdXedt1CxOLvyruZuq4VCbhdUjkFhtb5KbSQ9RtiCrg/tfvFK
 8UAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhoKI2uDYxnrkkqFpx+bV2N+8ZJnbro8i+gaEpTS7pCiVpDHykWLxGUxA3AwdjMKB7qGSP9oXXlQ/RQVbbReJMJy9o1Kg=
X-Gm-Message-State: AOJu0YznZq2u4cqEGG8dDEb4Zqe6F65cQC5Q4QZwmr6VMA9NvzrJrcfV
 4rK85A8NIuscnFxjEWrPEfiA3MLoY9DSDI9oNY3YFXfoFl4I5f4ZeiFxyXBhlNM=
X-Google-Smtp-Source: AGHT+IFx/48kIRY+VCY3vSlxmN08+9ZmB82AYcL4de3UD1JwEqkhs27GtmZCV4pf5EAZs17jpQSCSg==
X-Received: by 2002:a17:906:f1c1:b0:a3d:482f:3fc4 with SMTP id
 gx1-20020a170906f1c100b00a3d482f3fc4mr474615ejb.70.1707893893936; 
 Tue, 13 Feb 2024 22:58:13 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXuTQTXNRycCn/2ir9P8ZV147ie2WnBrKndNsjRI15+Pxj1yclss4SEbIbqq8cWEnbE1+9FfKC5EID23i1YmOHkphY7z0sqDd56PhQp0cnSbw4o09SVMwUqkkmvGsbylwcxkknw4n1jkSouhT7HE0ScYFsKZ3DyMqam2OkF9CQ0et20iXQ4HtSoPuymfPJ6+9FtF1PG8qikNxgyPad5diKjes1dSr1h0XtlkYFy7ysL9yjW3wgQSi15+mJPieVyUA1h9119lufKa6GPZ4FD3OPPzvIs4fjTRLPJ5hl+5NaRAC3kpFX4laY=
Received: from [192.168.69.100] (mau49-h01-176-184-41-88.dsl.sta.abo.bbox.fr.
 [176.184.41.88]) by smtp.gmail.com with ESMTPSA id
 ld15-20020a170906f94f00b00a3d5d8ff745sm13645ejb.144.2024.02.13.22.58.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 22:58:13 -0800 (PST)
Message-ID: <17f737fa-5a2d-4465-9f53-7ef11b6287e4@linaro.org>
Date: Wed, 14 Feb 2024 07:58:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] hw/i386/acpi: Declare pc_madt_cpu_entry() in
 'acpi-common.h'
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-trivial@nongnu.org
References: <20240213120153.90930-1-philmd@linaro.org>
 <20240213120153.90930-5-philmd@linaro.org>
 <35DAA6EC-1C6D-4F36-A595-A7F720D63C20@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <35DAA6EC-1C6D-4F36-A595-A7F720D63C20@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 13/2/24 19:57, Bernhard Beschow wrote:
> 
> 
> Am 13. Februar 2024 12:01:49 UTC schrieb "Philippe Mathieu-Daudé" <philmd@linaro.org>:
>> Since pc_madt_cpu_entry() is only used by:
>> - hw/i386/acpi-build.c   // single call
>> - hw/i386/acpi-common.c  // definition
>> there is no need to expose it outside of hw/i386/.
>> Declare it in "acpi-common.h".
>> acpi-build.c doesn't need "hw/i386/pc.h" anymore.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> hw/i386/acpi-common.h | 3 +++
>> include/hw/i386/pc.h  | 4 ----
>> hw/i386/acpi-common.c | 1 -
>> 3 files changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/i386/acpi-common.h b/hw/i386/acpi-common.h
>> index b3c56ee014..e305aaac15 100644
>> --- a/hw/i386/acpi-common.h
>> +++ b/hw/i386/acpi-common.h
>> @@ -1,12 +1,15 @@
>> #ifndef HW_I386_ACPI_COMMON_H
>> #define HW_I386_ACPI_COMMON_H
>>
>> +#include "hw/boards.h"
>> #include "hw/acpi/bios-linker-loader.h"
>> #include "hw/i386/x86.h"
>>
>> /* Default IOAPIC ID */
>> #define ACPI_BUILD_IOAPIC_ID 0x0
>>
>> +void pc_madt_cpu_entry(int uid, const CPUArchIdList *apic_ids,
> 
> Since the function is apparently not pc but rather x86-specific: Does it make sense to rename the function as well, e.g. to x86_madt_cpu_entry()?

I don't know much about ACPI tables. Is it?
Ani, can you confirm and do you mind posting a cleanup patch on top? :)

Regards,

Phil.

