Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A16B6C677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 09:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPHWp-0003L5-BF; Wed, 11 Jun 2025 05:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uPHWk-0003KP-Ml
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 05:13:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uPHWi-0008DY-Bf
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 05:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749633221;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NXYfBMXXrdWQCyOd3hAGS6hxjfGiHUcvxYM5pAvvxEw=;
 b=WCwZP5J/+rUE7+2EquUrK0sm7FChLJCX50dCknPFVRq4Cax4xsH2ZUZlcHo86aHDrLLMgl
 uMSEv6fB0FobtnmUc9RtViQI8GTLHDPwiUsZReUAuxb8dUh7CmgrwtJSlLmj/GZv+HkYO9
 +SzZyd6j2uUXULLuRjLQ90EwqtLkfzU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-4u_M1H5xPmCiOuhKT3zwGg-1; Wed, 11 Jun 2025 05:13:39 -0400
X-MC-Unique: 4u_M1H5xPmCiOuhKT3zwGg-1
X-Mimecast-MFC-AGG-ID: 4u_M1H5xPmCiOuhKT3zwGg_1749633219
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4eeed54c2so4187963f8f.3
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 02:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749633218; x=1750238018;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NXYfBMXXrdWQCyOd3hAGS6hxjfGiHUcvxYM5pAvvxEw=;
 b=iEA+8Ga6u09xPzqh7MHlpQybcOgK3Dz8t+daKHe8W+HTCNwAp/JCCulo5buiH7ynUt
 XwAKhJigKpNpeTjkD/U9rb7Sg5ZLT0zvpammHsxW5xO75WyN66ckeAPNSqB8GgG5FW9m
 3zG5P+IzJ/xIrSPJn3FkEmEciAuJu0rdG9EKB+weyE70mhKJCn5j/VEnpmC8lr490dM8
 qi/sea86Wg7iWCyS1XTZeT+j+q2HHiUY0RY7Gi561rR0yjawycFmoHCAEBotSH1BE2lO
 X1tYojQ2x25XfLfzRLhzD7i7sxS5RZoFe7kzD/NKVaGDp0uC4RMhTDqUxJMj5vC8nR/t
 7+ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0zkzBHtBPEH7ASdUzaFq0H0L26z2223YtDKzX1Vns7LrzrSsKx7/78hXGLsdVnQ3Fmub3y+1KAaKd@nongnu.org
X-Gm-Message-State: AOJu0YwKfz5tojQElFwBEsNHT7jzBJq80UHECmZvLFfQ0yzXjssV51oL
 wELQZIS2tNxLsKezshe+OEXhWRP2KobvpyBbnxr3KJQLvsAImihSR0rp57lL8Rx1paudDhALMEj
 bYJv/W1WDlc7NPzvPVKyQ1SCDB0l4dblXyp65ZWRc1sacMqTurGgtEaXO
X-Gm-Gg: ASbGncvlbiBIbHagDsMk2siCJeaJNUEZ4Xm+FrJDERuwj6v270GhpIm1CQ9lITrWE0q
 RE+/hsH5Q5eWBh4PLVlYtBK8zZrH0Jdn377sSuZXCbr5bpXU8MxXU9I+ZefFCD4YPd10hfHUzb4
 VF7Ty3Qp8ix83XNMpRXlNbxkMzo0wRsAh2uW9fcnMrLBR8MFbz9gRD7r+iilb99es231xRzIt1x
 GTbQlXTsCInrU0fZnxuJniDxbGIH5MRCeU2skgNU5LifT4NG7qWxweXWBiel4y2ree/5RnKTBUp
 cyW3FWEs7y0DGXKZHKgNQDK/pYZeoIq/URgLCJYfGBxeX/v2w82B0dzfgv++UfS2f4ILqA==
X-Received: by 2002:a05:6000:26ca:b0:3a4:d994:be4b with SMTP id
 ffacd0b85a97d-3a558a9a08amr1806676f8f.1.1749633218431; 
 Wed, 11 Jun 2025 02:13:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsFMBk2rGPpFa8pdRsEoskdmmEtFxAqrrh4er+pyx3u55xwrDhA6DB2jkHKoqZ3grd4vIHEA==
X-Received: by 2002:a05:6000:26ca:b0:3a4:d994:be4b with SMTP id
 ffacd0b85a97d-3a558a9a08amr1806628f8f.1.1749633217956; 
 Wed, 11 Jun 2025 02:13:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a532131df6sm14436568f8f.0.2025.06.11.02.13.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 02:13:36 -0700 (PDT)
Message-ID: <e1b7e7c3-fa13-46f8-8a61-4767ff9f7c89@redhat.com>
Date: Wed, 11 Jun 2025 11:13:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/25] hw/pci-host/gpex-acpi: Propagate hotplug type
 info from virt machine downto gpex
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, imammedo@redhat.com, gustavo.romero@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com,
 pbonzini@redhat.com, philmd@linaro.org, alex.bennee@linaro.org
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-7-eric.auger@redhat.com>
 <20250530111413.00003c66@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250530111413.00003c66@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Jonathan,

On 5/30/25 12:14 PM, Jonathan Cameron wrote:
> On Tue, 27 May 2025 09:40:08 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> Propagate the type of pci hotplug mode downto the gpex
>> acpi code. In case machine acpi_pcihp is unset we configure
>> pci native hotplug on pci0. For expander bridges we keep
>> legacy pci native hotplug, as done on x86 q35.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>  include/hw/pci-host/gpex.h | 1 +
>>  hw/arm/virt-acpi-build.c   | 1 +
>>  hw/pci-host/gpex-acpi.c    | 3 ++-
>>  3 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
>> index 84471533af..feaf827474 100644
>> --- a/include/hw/pci-host/gpex.h
>> +++ b/include/hw/pci-host/gpex.h
>> @@ -45,6 +45,7 @@ struct GPEXConfig {
>>      MemMapEntry pio;
>>      int         irq;
>>      PCIBus      *bus;
>> +    bool        pci_native_hotplug;
>>  };
>>  
>>  typedef struct GPEXIrq GPEXIrq;
>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>> index 7e8e0f0298..be5e00a56e 100644
>> --- a/hw/arm/virt-acpi-build.c
>> +++ b/hw/arm/virt-acpi-build.c
>> @@ -129,6 +129,7 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
>>          .ecam   = memmap[ecam_id],
>>          .irq    = irq,
>>          .bus    = vms->bus,
>> +        .pci_native_hotplug = !vms->acpi_pcihp,
>>      };
>>  
>>      if (vms->highmem_mmio) {
>> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
>> index 1aa2d12026..f1ab30f3d5 100644
>> --- a/hw/pci-host/gpex-acpi.c
>> +++ b/hw/pci-host/gpex-acpi.c
>> @@ -204,6 +204,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>>              if (is_cxl) {
>>                  build_cxl_osc_method(dev);
>>              } else {
>> +                /* pxb bridges do not have ACPI PCI Hot-plug enabled */
>>                  acpi_dsdt_add_host_bridge_methods(dev, true);
> This is awkward but explains why my CXL cases weren't causing trouble.
> A mixed config is counter to the recommendation in the PCI firmware spec
>
> "It is recommended that a machine with multiple host bridge devices should
> report the same capabilities for all host bridges of the same type and also
> negotiate control of the features described in the Control Field in the
> same way for all host bridges of the same type"

Thank for pointing to this spec excerpt.

Maybe the nuance relates to "host bridges of the same type", ie. gpex
versus pxb?
refering to Igor's following reply i will leave it as is. This is
inherited from existing x86 code in
hw/i386/acpi-build.c build_dsdt():

                /* Expander bridges do not have ACPI PCI Hot-plug enabled */
                aml_append(dev, build_q35_osc_method(true));

Eric
>
> I guess if any OS isn't coping with the mix then they can request native
> hotplug.
>
>
>
>>              }
>>  
>> @@ -279,7 +280,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>>      }
>>      aml_append(dev, aml_name_decl("_CRS", rbuf));
>>  
>> -    acpi_dsdt_add_host_bridge_methods(dev, true);
>> +    acpi_dsdt_add_host_bridge_methods(dev, cfg->pci_native_hotplug);
>>  
>>      Aml *dev_res0 = aml_device("%s", "RES0");
>>      aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));


