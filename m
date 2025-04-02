Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38AB8C28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 10:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzvK1-0005wF-3A; Wed, 02 Apr 2025 06:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzvJs-0005vh-Mn
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 06:27:40 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzvJp-0005P0-OB
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 06:27:40 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-399749152b4so3121232f8f.3
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 03:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743589656; x=1744194456; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IF3d2quCZG8w73mq1ttUDlwNS4ZWM2i7NiZlA8Fefwc=;
 b=P5VcOHij5A8DT0rhKpi702R61Kz2qluaKvueyzs8f55BPgBnFdAws82kfpAVqfhGO0
 GTuBIPfqM568wjgRLiZsJM3KKkQRGTvqN8mS0T5+9Yky/LF7nsQTAwEFHYpLNg9wSjOS
 sBW9RCr0w8B7+uzh+zDgXDywrWHeR2XUZtaH3664uTHjLSmv9atlVeFHGarlOxOfTGsY
 jUpzTqobOt1sVVLc6EUlL0tvlFerY8MntIN2aqTkpLuWQl/erNmPv6SDp3nLNdmFWOYo
 ntKiSPVjE9GFWv/J1O4MgW2Mpls1ftWongZWq/2XWV4nQdpGvVjLHr835gP9rxepzoim
 yc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743589656; x=1744194456;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IF3d2quCZG8w73mq1ttUDlwNS4ZWM2i7NiZlA8Fefwc=;
 b=U2biGOPZ6O3DfTCBlo9gPunpH4QVreIExfoEFb7QKHlDFr91DOLflfx0H5NVToUTFW
 B94AUQcaq+kOx7wsnZL1LxQNrPcsJ+0lOICFMxb2i7qDqo8qzmNuYDLpFFxo9DnsQvYY
 BzKHvlbm5OaCLlh74VZM2A0HFlp9XzHeOqguxP+wZ3AeCg95LjSINPALNBDGmpGFiluk
 TqOElJPKJ+IsUXTrHJ8YwJQIIwxqdYfRQqeaFuEsKXtIw3mTwICAow5KeyD/VrkHeyXU
 aLMeAPKDnfU/et7xA19O84UmeZcILMlKHLe6z49IBXrTPwcvMFwbQWyNMrr3Ulda4ETv
 RbxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtU8wfAMXSdWwAJsPcZ58P08epbWbLGhTFXYeEcwT4bvBQxsq5BoIsBaXHuoIW9NLaQDVIM/LNYzl3@nongnu.org
X-Gm-Message-State: AOJu0YypNutbSE5EKDNbcBuQ8BG4xbL87lJMh6+l09qOVFL0kbCoD97g
 /WXEVGVSCIM5W8yLBrYT7n2fqv8PgCVCSqW0R9FatvhJ4ZS0iaG+M7b9eEeWefQ=
X-Gm-Gg: ASbGnct2fwG9C+wsV/m+88PPWJNJKvGJNzEkqMVHDXgjnukdwePwHZCrBY9yS2hcfJS
 5aLapT/YAlWnyQsp3Hc/IXneAuQm78c5DjlKGrSAGzbg07cp5fFBKx7sUdgW0TPsuVZw+PkOcTq
 mnFNxLWvmHmur4JM74A11S7TmIMpkDN2WziHP69EdIUja6umjCsiQhtP+N5CiDLvWg+oj3jqgjY
 P72gIXWfjNO1cOO6qjox3p/3jWWOrQb9DRPACPgFHCa2JaEUo+U6yuZoCqN3L2qDATLP4v19bUC
 BCWCp7064oAraCEXtOy0b3Y6DAR7GrOJ/bbWz8Llyd6+zFN2LnBE/LG/EPDUg/aQ0B06xPanLwR
 KGE6Ri2peoHJU
X-Google-Smtp-Source: AGHT+IGgDLAgiMpzh5FU7pbGOBiEBVhMEBSuN/VjZXuCtKEk5nIJhuAq3SJehgz2ONWbgnBYvcQTIQ==
X-Received: by 2002:a05:6000:2a83:b0:39c:1257:febb with SMTP id
 ffacd0b85a97d-39c23674c2amr3761647f8f.59.1743589655965; 
 Wed, 02 Apr 2025 03:27:35 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43eb61907f7sm15892135e9.30.2025.04.02.03.27.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 03:27:35 -0700 (PDT)
Message-ID: <ef0f90c8-c87a-4833-a590-6370cd03ea2d@linaro.org>
Date: Wed, 2 Apr 2025 12:27:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 3/5] hw/arm/virt-acpi: Factor its_enabled()
 helper out
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Udo Steinberg <udo@hypervisor.org>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250331221239.87150-1-philmd@linaro.org>
 <20250331221239.87150-4-philmd@linaro.org>
 <80dd971a-2a45-44a5-9454-43257ead30a5@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <80dd971a-2a45-44a5-9454-43257ead30a5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 2/4/25 08:43, Gustavo Romero wrote:
> Hi Phil,
> 
> On 3/31/25 19:12, Philippe Mathieu-Daudé wrote:
>> GIC ITS is checked for the MADT and IORT tables.
>> Factor the checks out to the its_enabled() helper.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/arm/virt-acpi-build.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index 3ac8f8e1786..fdc08b40883 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -208,6 +208,13 @@ static void acpi_dsdt_add_tpm(Aml *scope, 
>> VirtMachineState *vms)
>>   #define ROOT_COMPLEX_ENTRY_SIZE 36
>>   #define IORT_NODE_OFFSET 48
>> +static bool its_enabled(VirtMachineState *vms)
>> +{
>> +    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>> +
>> +    return its_class_name() && !vmc->no_its;
>> +}
>> +
> 
> Isn't its_class_name() always "true"?

The method signature is described as:

  /**
   * its_class_name:
   *
   * Return the ITS class name to use depending on whether
   * KVM acceleration  and KVM CAP_SIGNAL_MSI are supported
   *
   * Returns: class name to use or NULL
   */
  const char *its_class_name(void);

So I'd say no.

Indeed since commit cc5e719e2c8 ("kvm: require KVM_CAP_SIGNAL_MSI")
the single implementation doesn't return NULL anymore.

Paolo, can we update the signature and clean code path?

Anyhow Gustavo, while well noticed, this is pre-exising and unrelated
to the code movement in this patch.

> 
> 
> Cheers,
> Gustavo
> 
>>   /*
>>    * Append an ID mapping entry as described by "Table 4 ID mapping 
>> format" in
>>    * "IO Remapping Table System Software on ARM Platforms", Chapter 3.
>> @@ -670,7 +677,6 @@ static void
>>   build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState 
>> *vms)
>>   {
>>       int i;
>> -    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
>>       const MemMapEntry *memmap = vms->memmap;
>>       AcpiTable table = { .sig = "APIC", .rev = 4, .oem_id = vms->oem_id,
>>                           .oem_table_id = vms->oem_table_id };
>> @@ -741,7 +747,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, 
>> VirtMachineState *vms)
>>                                             
>> memmap[VIRT_HIGH_GIC_REDIST2].size);
>>           }
>> -        if (its_class_name() && !vmc->no_its) {
>> +        if (its_enabled(vms)) {
>>               /*
>>                * ACPI spec, Revision 6.0 Errata A
>>                * (original 6.0 definition has invalid Length)
>> @@ -973,7 +979,7 @@ void virt_acpi_build(VirtMachineState *vms, 
>> AcpiBuildTables *tables)
>>                             vms->oem_table_id);
>>       }
>> -    if (its_class_name() && !vmc->no_its) {
>> +    if (its_enabled(vms)) {
>>           acpi_add_table(table_offsets, tables_blob);
>>           build_iort(tables_blob, tables->linker, vms);
>>       }
> 


