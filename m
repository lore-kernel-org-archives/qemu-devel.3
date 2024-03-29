Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 584A0CD11DD
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 10:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq9OO-0003Bi-3Y; Fri, 29 Mar 2024 06:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rq9OM-00039W-EU
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 06:23:22 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rq9OK-0005DS-P6
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 06:23:22 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a4734ae95b3so243771466b.0
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 03:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711707799; x=1712312599; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QvRGWxIoYWPA4KC1nOtZccSOj22WfXQKUeWCwr9CcAM=;
 b=O2cybOdPdsYvXXHu4TyW157P12GzV5eFFKt4eeBAWOs8Em17UTra21hDNRErJByyMr
 ZL1Bp7ByWBVgKsKPHaWzwTaczWbQuKCrDEE7stovplgqY9bVJtZKwrvDSZdkkJIJ9GYg
 Yi1P0ZqVcIeuKqtCPK10gxM0NDbo/RisudSXb3dgHvJmEYW0CbBrRXZzVC9HiuC9y4zm
 h9icrM+JCtv/RNedjXh96hQQHRQ4FuQpPY6Zk5JNEyjRt6SeOBHKls/UQY3KFQhPyubv
 /IvEGMGME7Gqg/KRxO68/chwsR8DPOloAD6sIdbjDSgFyeZGovhMLTtAXfAD+Lp5a3xV
 EjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711707799; x=1712312599;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QvRGWxIoYWPA4KC1nOtZccSOj22WfXQKUeWCwr9CcAM=;
 b=i+0qpFINvY3Q3aCUkdZYyz0xhX5QagnsL828dh30/HIkRN7sRClc5N7htQ49bMv3Nl
 MVDWsZtppi4rjMkH4Te0+27GiG8ZKrqYa2nJz+BXTWSKI7ix8k8TxGDiYgLERQd5Zpc7
 Ul0DKSU2TAXwRAWQoxbFeExpzKlqrcDTJBvavLcdfLDxCayhyVj30T2n2HM+6rRqiDkS
 ip2pqrEZaU69JH8NqKtKzBTIm92BwC5fMiladW8sXmYBhKXLMMvxPxeiqOWsDrCwYB12
 wKkIHnMxuxOUo1lJhu0MrYao8vl7sVGdYk1CnIkx5ZDQllOCBtfXJd8YpXE0KWVjOt98
 NVOw==
X-Gm-Message-State: AOJu0YxBOsKcOlRaow5Q6/EQROi7m+I+QKDaisDZKGa1rJfzAxn/wUki
 r1HW8jb8SDJqnGODDByVlyPcEZWDaheyx5L4QDvVRQBQSAsjFekRCFdqPtdnA4Q=
X-Google-Smtp-Source: AGHT+IEKykYMFB4yOfD5Bb+oTfKqzLhkwLQOT38cufTeCOj/ARkv/rLphGMkH+ejBZNcAvqU5uV/CA==
X-Received: by 2002:a17:906:6981:b0:a4e:2570:ff56 with SMTP id
 i1-20020a170906698100b00a4e2570ff56mr1237049ejr.0.1711707798986; 
 Fri, 29 Mar 2024 03:23:18 -0700 (PDT)
Received: from [192.168.69.100] (uni14-h01-176-184-39-242.dsl.sta.abo.bbox.fr.
 [176.184.39.242]) by smtp.gmail.com with ESMTPSA id
 eb16-20020a170907281000b00a4e0df9e793sm1755345ejc.136.2024.03.29.03.23.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Mar 2024 03:23:18 -0700 (PDT)
Message-ID: <ba3a0226-4aae-4cbb-bf88-c45a5dbdbff7@linaro.org>
Date: Fri, 29 Mar 2024 11:23:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-9.1 09/29] hw/i386/pc: Pass PCMachineState
 argument to acpi_setup()
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org,
 Bernhard Beschow <shentey@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, Ani Sinha <anisinha@redhat.com>
References: <20240328155439.58719-1-philmd@linaro.org>
 <20240328155439.58719-10-philmd@linaro.org>
 <04b9fcde-31f1-dfa8-8c4e-a666d0d873d8@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <04b9fcde-31f1-dfa8-8c4e-a666d0d873d8@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

On 28/3/24 19:45, BALATON Zoltan wrote:
> On Thu, 28 Mar 2024, Philippe Mathieu-Daudé wrote:
>> acpi_setup() caller knows about the machine state, so pass
>> it as argument to avoid a qdev_get_machine() call.
>>
>> We already resolved X86_MACHINE(pcms) as 'x86ms' so use the
>> latter.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> hw/i386/acpi-build.h | 3 ++-
>> hw/i386/acpi-build.c | 5 ++---
>> hw/i386/pc.c         | 2 +-
>> 3 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
>> index 0dce155c8c..31de5bddbd 100644
>> --- a/hw/i386/acpi-build.h
>> +++ b/hw/i386/acpi-build.h
>> @@ -2,6 +2,7 @@
>> #ifndef HW_I386_ACPI_BUILD_H
>> #define HW_I386_ACPI_BUILD_H
>> #include "hw/acpi/acpi-defs.h"
>> +#include "hw/i386/pc.h"
>>
>> extern const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio;
>>
>> @@ -9,7 +10,7 @@ extern const struct AcpiGenericAddress 
>> x86_nvdimm_acpi_dsmio;
>> #define ACPI_PCIHP_SEJ_BASE 0x8
>> #define ACPI_PCIHP_BNMR_BASE 0x10
>>
>> -void acpi_setup(void);
>> +void acpi_setup(PCMachineState *pcms);
> 
> This is changed to PcPciMachineState * in a following patch so can't you 
> already introduce it here to avoid some churn?

Unfortunately not, because we'd need to use:

   PcPciMachineState *ppms = PC_PCI_MACHINE(pcms);

which would trigger an assertion at this point.

> 
> Regards,
> BALATON Zoltan


