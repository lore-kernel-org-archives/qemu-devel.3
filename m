Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413B1C61CE7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 12:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPKPr-0008HW-UB; Wed, 11 Jun 2025 08:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uPKPp-0008GO-0E
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:18:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uPKPh-0007bB-4H
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 08:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749644316;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zZSdbNeeun/D3AOo2VIU282r8Vag0AFvMKttLfsQ7vo=;
 b=fSNf7qiiocgyjNHEphPS7KkbzlpAYQT2HYVL39qT0wqRx09layiyIwSTk8nKv5Hv6yKA8F
 Ilr9OrnSiJJanVwQY8ks5V0z3ZhY/P6CqIWyl3sX3DQMpBcb/T4PHN8FRp1eJVOdTmIAmI
 R35+q+ZUiAsA348c7QtKWfg5ynWqwc4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-R2gLRcKqNCCwwKriLzZr1w-1; Wed, 11 Jun 2025 08:18:35 -0400
X-MC-Unique: R2gLRcKqNCCwwKriLzZr1w-1
X-Mimecast-MFC-AGG-ID: R2gLRcKqNCCwwKriLzZr1w_1749644314
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-440667e7f92so45148765e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 05:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749644314; x=1750249114;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zZSdbNeeun/D3AOo2VIU282r8Vag0AFvMKttLfsQ7vo=;
 b=os+qZ0Z1xouvkbJuvPAwidXs7Y0xmFOkkyIM7Ib6nwB1bHPUWZd3jFgEmdswXC8eeV
 sJ1wL5I26p7JdMIQp0aNJXtG5EzxZG1iTST/bW4RCLwQzG1TQYPQsG15vMDbRGk1DRNB
 0cSeqgNPNiURyFWhgU3pSIOrjqpzTdS8VAi4dyG32S33G6rTDupu+b8C6SLPzmLI9QB/
 PaodrAOGldJ1x+KeK+hD5T3yBcTRrSfbKjHMVpgdl2jASS5d6h7JmFtjHNT/SFzZyZ7n
 38BwM7iEnNQ5rWuC7ZPp367DXqGeS6lnCDrB0QVgv9kgxMA3nvflPT6RaQ5gEe0ScRV5
 zreQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhhtpaAVn41PVi+nlzUG5jbWT9x5i8vHhn/z8qRIhjQFijgFWD5rEQM1FNozW620F1SIF8ipH3XgZL@nongnu.org
X-Gm-Message-State: AOJu0YxLLtNVQPFEXd341zx8bZW1sp5e3eG4KN0xQCrjdIyFsp+GVnYO
 KUQCen/f5nvyXqBXu6MW5BZRfrULtA6W9jcin7TZfOvf6Vo8QeXKKCR1eZEC3h+OsYAVsV4iH7i
 wNoCpwf4znNhsdk+gBXCH6Yq85Nt/sCgs24NZYA9ZYYzdkZ3QnaooWd6P
X-Gm-Gg: ASbGncsqMT9Qn+pUdKUemZy6tsBfIhw4Tjjw2O0wflpa8P10xLV+D+OS0zZVw6mTJJ8
 6bHsaP5ZgISNpnQu/Cirx7QMtgme8ohGvnTyLDubb5ZFZJNS3c/NVBJlBIgVVF0PZdkJm9R3ufh
 pNHdToXAEEPKy7vYMoRqZsh9pyMZACjqX5Bhs8mtMirKXCmHKvZhwojH6wQ9CghtBF5x/z2icKD
 py7GPzdBd9v8CUopYwojDKAmuQBq+nCMuF53pLiXZFRoQ98DIwnVD0shO/1zbHyG8qe011PBfGg
 ur4acC5SRyhVpj62K6a6zNOr3dIyxW+42mNOh6zubVpfw5OSuOT1p2sH0MdEHF+dybFG8w==
X-Received: by 2002:a05:6000:1b8a:b0:3a5:2ddf:c934 with SMTP id
 ffacd0b85a97d-3a55881dbb9mr1737213f8f.30.1749644313752; 
 Wed, 11 Jun 2025 05:18:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMx6TH9CHW/sQ7KK5+Pzjt+BNKladyFWPFpfgr+tKnOYsW5uwjkGc8lJBfMN0eDxRc8OxIOA==
X-Received: by 2002:a05:6000:1b8a:b0:3a5:2ddf:c934 with SMTP id
 ffacd0b85a97d-3a55881dbb9mr1737177f8f.30.1749644313223; 
 Wed, 11 Jun 2025 05:18:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53229ddebsm15293387f8f.17.2025.06.11.05.18.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 05:18:32 -0700 (PDT)
Message-ID: <a2f97bcb-4986-421d-937f-1b571b790a8e@redhat.com>
Date: Wed, 11 Jun 2025 14:18:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/25] hw/pci-host/gpex-acpi: Split host bridge OSC and
 DSM generation
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, imammedo@redhat.com, gustavo.romero@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com,
 pbonzini@redhat.com, philmd@linaro.org, alex.bennee@linaro.org
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-6-eric.auger@redhat.com>
 <20250530110227.00003341@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250530110227.00003341@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi Jonathan,

On 5/30/25 12:02 PM, Jonathan Cameron wrote:
> On Tue, 27 May 2025 09:40:07 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> acpi_dsdt_add_pci_osc() name is confusing as it gives the impression
>> it appends the _OSC method but in fact it also appends the _DSM method
>> for the host bridge. Let's split the function into two separate ones
>> and let them return the method Aml pointer instead. This matches the
>> way it is done on x86 (build_q35_osc_method). In a subsequent patch
>> we will replace the gpex method by the q35 implementation that will
>> become shared between ARM and x86.
>>
>> acpi_dsdt_add_host_bridge_methods is a new top helper that generates
>> both the _OSC and _DSM methods.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
> Makes complete sense. I've had local equivalent of this on the CXL
> tree for a while as without it we don't register the _DSM for the
> CXL path (and we should).  However, can you modify it a little to
> make that easier for me?  Basically make sure the _DSM is registered
> for the CXL path as well.
>
> One other comment inline.
>
>
>> ---
>>  hw/pci-host/gpex-acpi.c | 31 +++++++++++++++++++++----------
>>  1 file changed, 21 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
>> index f34b7cf25e..1aa2d12026 100644
>> --- a/hw/pci-host/gpex-acpi.c
>> +++ b/hw/pci-host/gpex-acpi.c
>> @@ -50,13 +50,10 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq,
>>      }
>>  }
>>  
>> -static void acpi_dsdt_add_pci_osc(Aml *dev, bool enable_native_pcie_hotplug)
>> +static Aml *build_host_bridge_osc(bool enable_native_pcie_hotplug)
>>  {
>> -    Aml *method, *UUID, *ifctx, *ifctx1, *elsectx, *buf;
>> +    Aml *method, *UUID, *ifctx, *ifctx1, *elsectx;
>>  
>> -    /* Declare an _OSC (OS Control Handoff) method */
>> -    aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
>> -    aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
>>      method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
>>      aml_append(method,
>>          aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
>> @@ -103,9 +100,13 @@ static void acpi_dsdt_add_pci_osc(Aml *dev, bool enable_native_pcie_hotplug)
>>                                 aml_name("CDW1")));
>>      aml_append(elsectx, aml_return(aml_arg(3)));
>>      aml_append(method, elsectx);
>> -    aml_append(dev, method);
>> +    return method;
>> +}
>>  
>> -    method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
>> +static Aml *build_host_bridge_dsm(void)
>> +{
>> +    Aml *method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
>> +    Aml *UUID, *ifctx, *ifctx1, *buf;
>>  
>>      /* PCI Firmware Specification 3.0
>>       * 4.6.1. _DSM for PCI Express Slot Information
>> @@ -124,7 +125,17 @@ static void acpi_dsdt_add_pci_osc(Aml *dev, bool enable_native_pcie_hotplug)
>>      byte_list[0] = 0;
>>      buf = aml_buffer(1, byte_list);
>>      aml_append(method, aml_return(buf));
>> -    aml_append(dev, method);
>> +    return method;
>> +}
>> +
>> +static void acpi_dsdt_add_host_bridge_methods(Aml *dev,
>> +                                              bool enable_native_pcie_hotplug)
>> +{
>> +    aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
>> +    aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
> These two declarations seem to be very much part of the _OSC build though not
> within the the method.  I 'think' you get left with them later with no users.
> So move them into the osc build here and they will naturally go away when
> you move to the generic code.
>
> They end up unused in the DSDT at the end of the series.

Done

Thanks

Eric
>
> I ran a quick GPEX + pxb-pcie test and we do get the odd mix that the OSC for
> the GPEX say no native hotplug but the OSC for the PXB allows it.
>
>> +    /* Declare an _OSC (OS Control Handoff) method */
>> +    aml_append(dev, build_host_bridge_osc(enable_native_pcie_hotplug));
>> +    aml_append(dev, build_host_bridge_dsm());
>>  }
>>  
>>  void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>> @@ -193,7 +204,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>>              if (is_cxl) {
>>                  build_cxl_osc_method(dev);
>>              } else {
>> -                acpi_dsdt_add_pci_osc(dev, true);
>> +                acpi_dsdt_add_host_bridge_methods(dev, true);
> Can you either drop the use of the wrapper for the DSM part here and call
> it unconditionally (for cxl and PCIe cases) or add an extra call to
> aml_append(dev, build_host_bridge_dsm()) for the is_cxl path?
>
>>              }
>>  
>>              aml_append(scope, dev);
>> @@ -268,7 +279,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>>      }
>>      aml_append(dev, aml_name_decl("_CRS", rbuf));
>>  
>> -    acpi_dsdt_add_pci_osc(dev, true);
>> +    acpi_dsdt_add_host_bridge_methods(dev, true);
>>  
>>      Aml *dev_res0 = aml_device("%s", "RES0");
>>      aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));


