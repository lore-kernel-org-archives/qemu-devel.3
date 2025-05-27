Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2566DC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 07:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJoZr-0006sC-1n; Tue, 27 May 2025 03:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uJoZm-0006rn-Bs
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:18:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uJoZj-0004Af-Lg
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748330287;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gDy/gofwFrrzpb5FO/vS3uZ0iat7hmZTU13qoq05MOY=;
 b=Ccj7M47vgFKUhRk7JEX2w7DS/u6q7b1L6UFx59acyZuc8csFshihhiS9bUHrNdwgVp4SDX
 nrxtiHfbQlbqmTNBl5ge8V3myQOsN31MQHzKR1jdKjXcHdcK8PQnmUR1PXYvdoRMAMqQGj
 8ktueVCROGToVGqveXnVbdXRBOhBk04=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-DWIYSw8wPi-SkOf34xG7Dw-1; Tue, 27 May 2025 03:18:05 -0400
X-MC-Unique: DWIYSw8wPi-SkOf34xG7Dw-1
X-Mimecast-MFC-AGG-ID: DWIYSw8wPi-SkOf34xG7Dw_1748330284
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-442ffaa7dbeso22111605e9.3
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 00:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748330284; x=1748935084;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gDy/gofwFrrzpb5FO/vS3uZ0iat7hmZTU13qoq05MOY=;
 b=ZP1EnNwTrDZJZqXJPATFdL+1p12+/s+22yG22emJLfQE9asZ98ptTW6rqfPSEqsZWP
 frSsyPaTyTuufl2Li4F5QDPBzzL7aeOKLhSOI55hmFkrdsvMGF0mOK9qeFO3XIfkAVAB
 jNUOHlBxadeL5wQ2+3DxLiGUVwGZjAvj2gWpK/cZJ+LBmHKRikKd+vtoBAM2bwiCI7Qk
 8dfaPMBb6+uc0O7RywT8PeFsQUcH0NH5IJGcUPzD+xbHrZf3wV/Gzh3/qQnBMvDISeHR
 O1i38VXjEX6Y99ZGr+ps5Dm8YQIEZRFO3PqCgXj4zTZuLaBrCQpXHcUjUuoeb/vOm3wB
 Fwcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9faw7szUHnIjzAZDwYqc1RWOD5SsiqzbWtaOHrlU6lCz7s+pcuwm4cGea83AciVSlM33KXluADgLS@nongnu.org
X-Gm-Message-State: AOJu0YzPK1kqqdiqeFF1NqfzJ9aXiFeBSvqUVanHJYsPaG948yKgbuEN
 GKBoEM1BkhY6jyFFR/xkvNxQnETTx9ANgBBynJXtifMQ7CEaD0fbR+AoSNF8q/Zq/2MXVMgDb8C
 BApUZiZECPrV8KoqreLww8aM1oJbJvLvDbrizgaRlwWfXRu/Q/PyC4qPR
X-Gm-Gg: ASbGncvSPGtIJVFaJXMkVNHQtS83kCRmQeTzDMLhzfP8In2aiM8QOQ+muuRztSh2AkM
 jqwBvx0YY5ygI9h8v5EUyin9FQp0VpnhNaR2NpdXy3NHUeXV+hRm5JU6WMcWj0VV+3v9i7ZEr7/
 Bkh9ySqmdbnsk2Gqs7XS3frGG+n4WLTryNwxsiDnE1UjDER09gs1pVwioncmq7qQ4+5rnW6/vRC
 lzX+1IePMaQaowVYQRh/OH1yIgJJ3DE1cjcJJR9nqhRA8KMQpbjLxIk1g3iC44/6bHlGrd7Dex3
 O5YZS+agvqKWYPSoHT38FlXGjrgV+FWMyEb916tX64gVZ+mryZez9DAu2AQ=
X-Received: by 2002:a05:600c:a13:b0:43d:160:cd9e with SMTP id
 5b1f17b1804b1-44c91fbb448mr110264885e9.17.1748330283685; 
 Tue, 27 May 2025 00:18:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe6kRbRTSlj7lgyBZAfnkHMs0eGPLLTebUWI2ZKl5edN8lIVgQa6M0+WgIFYsFhTzu6FQxZA==
X-Received: by 2002:a05:600c:a13:b0:43d:160:cd9e with SMTP id
 5b1f17b1804b1-44c91fbb448mr110264545e9.17.1748330283246; 
 Tue, 27 May 2025 00:18:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f1ef0aadsm258887455e9.12.2025.05.27.00.18.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 00:18:02 -0700 (PDT)
Message-ID: <51fd4295-cf41-4b39-b678-692a558f0967@redhat.com>
Date: Tue, 27 May 2025 09:18:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/22] hw/i386/acpi-build: Move aml_pci_edsm to a generic
 place
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org
References: <20250514170431.2786231-1-eric.auger@redhat.com>
 <20250514170431.2786231-15-eric.auger@redhat.com>
 <ad7c7b84-9f12-4767-a349-df47c489c726@linaro.org>
 <2f1d15ea-82fe-4633-9791-ef9a3721b87d@redhat.com>
 <95bff50a-4da9-4abe-b596-95c64ab85231@linaro.org>
 <55ef40d6-f940-4e53-b591-2a1df5f5b5e1@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <55ef40d6-f940-4e53-b591-2a1df5f5b5e1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
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



On 5/21/25 10:19 PM, Gustavo Romero wrote:
> Hi Eric,
>
> On 5/21/25 13:24, Gustavo Romero wrote:
>> Hi Eric,
>>
>> On 5/21/25 12:56, Eric Auger wrote:
>>> Hi Gustavo,
>>>
>>> On 5/21/25 5:26 PM, Gustavo Romero wrote:
>>>> Hi Eric,
>>>>
>>>> On 5/14/25 14:01, Eric Auger wrote:
>>>>> Move aml_pci_edsm to pcihp since we want to reuse that for
>>>>> ARM and acpi-index support.
>>>>>
>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>> ---
>>>>>    include/hw/acpi/pcihp.h |  2 ++
>>>>>    hw/acpi/pcihp.c         | 53
>>>>> +++++++++++++++++++++++++++++++++++++++++
>>>>>    hw/i386/acpi-build.c    | 53
>>>>> -----------------------------------------
>>>>>    3 files changed, 55 insertions(+), 53 deletions(-)
>>>>>
>>>>> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
>>>>> index 4d820b4baf..bc31dbff39 100644
>>>>> --- a/include/hw/acpi/pcihp.h
>>>>> +++ b/include/hw/acpi/pcihp.h
>>>>> @@ -82,6 +82,8 @@ bool build_append_notification_callback(Aml
>>>>> *parent_scope, const PCIBus *bus);
>>>>>      void build_append_pci_bus_devices(Aml *parent_scope, PCIBus
>>>>> *bus);
>>>>>    +Aml *aml_pci_edsm(void);
>>>>> +
>>>>>    /* Called on reset */
>>>>>    void acpi_pcihp_reset(AcpiPciHpState *s);
>>>>>    diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
>>>>> index d800371ddc..57fe8938b1 100644
>>>>> --- a/hw/acpi/pcihp.c
>>>>> +++ b/hw/acpi/pcihp.c
>>>>> @@ -937,6 +937,59 @@ void build_append_pci_bus_devices(Aml
>>>>> *parent_scope, PCIBus *bus)
>>>>>        }
>>>>>    }
>>>>>    +Aml *aml_pci_edsm(void)
>>>>> +{
>>>>> +    Aml *method, *ifctx;
>>>>> +    Aml *zero = aml_int(0);
>>>>> +    Aml *func = aml_arg(2);
>>>>> +    Aml *ret = aml_local(0);
>>>>> +    Aml *aidx = aml_local(1);
>>>>> +    Aml *params = aml_arg(4);
>>>>> +
>>>>> +    method = aml_method("EDSM", 5, AML_SERIALIZED);
>>>>> +
>>>>> +    /* get supported functions */
>>>>> +    ifctx = aml_if(aml_equal(func, zero));
>>>>> +    {
>>>>> +        /* 1: have supported functions */
>>>>> +        /* 7: support for function 7 */
>>>>> +        const uint8_t caps = 1 | BIT(7);
>>>>> +        build_append_pci_dsm_func0_common(ifctx, ret);
>>>>> +        aml_append(ifctx, aml_store(aml_int(caps), aml_index(ret,
>>>>> zero)));
>>>>> +        aml_append(ifctx, aml_return(ret));
>>>>> +    }
>>>>> +    aml_append(method, ifctx);
>>>>> +
>>>>> +    /* handle specific functions requests */
>>>>> +    /*
>>>>> +     * PCI Firmware Specification 3.1
>>>>> +     * 4.6.7. _DSM for Naming a PCI or PCI Express Device Under
>>>>> +     *        Operating Systems
>>>>> +     */
>>>>> +    ifctx = aml_if(aml_equal(func, aml_int(7)));
>>>>> +    {
>>>>> +       Aml *pkg = aml_package(2);
>>>>> +       aml_append(pkg, zero);
>>>>> +       /* optional, if not impl. should return null string */
>>>>> +       aml_append(pkg, aml_string("%s", ""));
>>>>> +       aml_append(ifctx, aml_store(pkg, ret));
>>>>> +
>>>>> +       /*
>>>>> +        * IASL is fine when initializing Package with computational
>>>>> data,
>>>>> +        * however it makes guest unhappy /it fails to process such
>>>>> AML/.
>>>>> +        * So use runtime assignment to set acpi-index after
>>>>> initializer
>>>>> +        * to make OSPM happy.
>>>>> +        */
>>>>> +       aml_append(ifctx,
>>>>> +           aml_store(aml_derefof(aml_index(params, aml_int(0))),
>>>>> aidx));
>>>>> +       aml_append(ifctx, aml_store(aidx, aml_index(ret, zero)));
>>>>> +       aml_append(ifctx, aml_return(ret));
>>>>> +    }
>>>>> +    aml_append(method, ifctx);
>>>>> +
>>>>> +    return method;
>>>>> +}
>>>>> +
>>>>>    const VMStateDescription vmstate_acpi_pcihp_pci_status = {
>>>>>        .name = "acpi_pcihp_pci_status",
>>>>>        .version_id = 1,
>>>>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>>>>> index bcfba2ccb3..385e75d061 100644
>>>>> --- a/hw/i386/acpi-build.c
>>>>> +++ b/hw/i386/acpi-build.c
>>>>> @@ -322,59 +322,6 @@ build_facs(GArray *table_data)
>>>>>        g_array_append_vals(table_data, reserved, 40); /* Reserved */
>>>>>    }
>>>>>    -static Aml *aml_pci_edsm(void)
>>>>> -{
>>>>> -    Aml *method, *ifctx;
>>>>> -    Aml *zero = aml_int(0);
>>>>> -    Aml *func = aml_arg(2);
>>>>> -    Aml *ret = aml_local(0);
>>>>> -    Aml *aidx = aml_local(1);
>>>>> -    Aml *params = aml_arg(4);
>>>>> -
>>>>> -    method = aml_method("EDSM", 5, AML_SERIALIZED);
>>>>> -
>>>>> -    /* get supported functions */
>>>>> -    ifctx = aml_if(aml_equal(func, zero));
>>>>> -    {
>>>>> -        /* 1: have supported functions */
>>>>> -        /* 7: support for function 7 */
>>>>> -        const uint8_t caps = 1 | BIT(7);
>>>>> -        build_append_pci_dsm_func0_common(ifctx, ret);
>>>>> -        aml_append(ifctx, aml_store(aml_int(caps), aml_index(ret,
>>>>> zero)));
>>>>> -        aml_append(ifctx, aml_return(ret));
>>>>> -    }
>>>>> -    aml_append(method, ifctx);
>>>>> -
>>>>> -    /* handle specific functions requests */
>>>>> -    /*
>>>>> -     * PCI Firmware Specification 3.1
>>>>> -     * 4.6.7. _DSM for Naming a PCI or PCI Express Device Under
>>>>> -     *        Operating Systems
>>>>> -     */
>>>>> -    ifctx = aml_if(aml_equal(func, aml_int(7)));
>>>>> -    {
>>>>> -       Aml *pkg = aml_package(2);
>>>>> -       aml_append(pkg, zero);
>>>>> -       /* optional, if not impl. should return null string */
>>>>> -       aml_append(pkg, aml_string("%s", ""));
>>>>> -       aml_append(ifctx, aml_store(pkg, ret));
>>>>> -
>>>>> -       /*
>>>>> -        * IASL is fine when initializing Package with computational
>>>>> data,
>>>>> -        * however it makes guest unhappy /it fails to process such
>>>>> AML/.
>>>>> -        * So use runtime assignment to set acpi-index after
>>>>> initializer
>>>>> -        * to make OSPM happy.
>>>>> -        */
>>>>> -       aml_append(ifctx,
>>>>> -           aml_store(aml_derefof(aml_index(params, aml_int(0))),
>>>>> aidx));
>>>>> -       aml_append(ifctx, aml_store(aidx, aml_index(ret, zero)));
>>>>> -       aml_append(ifctx, aml_return(ret));
>>>>> -    }
>>>>> -    aml_append(method, ifctx);
>>>>> -
>>>>> -    return method;
>>>>> -}
>>>>> -
>>>>>    /*
>>>>>     * build_prt - Define interrupt routing rules
>>>>>     *
>>>>
>>>> EDSM is not called from anywhere. _DSM method actually calls the PDSM,
>>>> already defined
>>>> in pcihp.c and generated by aml_pci_pdsm(). build_acpi_pci_hotplug(),
>>>> which calls
>>>> aml_pci_pdsm(), properly creates the PDSM method. Then in
>>>> build_append_pcihp_slots()
>>>> the a _DSM is defined per slot and inside it there is a call to PDSM,
>>>> so I understand
>>>> we should actually stick to the PDSM in pcihp.c instead of EDSM.
>>>
>>> I see build_append_pci_bus_devices -> aml_pci_static_endpoint_dsm
>>> adds a _DSM method which eventually calls EDSM.
>>
>> Yes, but I meant in the final generated ACPI AML code.
>>
>>
>>> aml_pci_device_dsm builds another _DSM implementation which calls PDSM.
>>>
>>> As we use build_append_pci_bus_devices and we are likely to have a _DSM
>>> implementation that calls EDSM method, I think we shall have it in the
>>> aml. What do I miss?
>>
>> Maybe some condition in build_append_pci_bus_devices() of:
>>
>>          if (pdev->acpi_index &&
>>              !object_property_get_bool(OBJECT(pdev), "hotpluggable",
>>                                        &error_abort)) { ... }
>>
>>
>> is not met?
>>
>> Does your _DSM method in the machine's ACPI has a call to EDSM? I don't
>> see it. In my case it's the PDSM that is being called:
>>
>> gromero@xps13:/tmp$ grep -n PDSM dsdt.dsl
>> 1910:        Method (PDSM, 5, Serialized)
>> 2047:                    Return (PDSM (Arg0, Arg1, Arg2, Arg3, Local0))
>> gromero@xps13:/tmp$ grep -n EDSM dsdt.dsl
>> 1959:        Method (EDSM, 5, Serialized)
>> gromero@xps13:/tmp$
>>
>> I also confirmed that PDSM is what is being used by reverting this
>> patch and
>> dropping the aml_append(pci0_scope, aml_pci_edsm()); in 15/22.
>>
>> But also, why shouldn't we use the PDSM defined already in pcihp.c?
>> This is
>> indeed crafted for the acpi-pcihp-hotplug device as I understand it.
>
> Sorry, I see now, the EDSM is actually only for static endpoint PCI
> devices,
> i.e. non-hotpluggable, I see. So PDSM and EDSM serve different
> purposes, although
> similar.
>
> So, my point in the end is (and the one that confused me too) that
> EDSM can be
> present even if it will never be used by any static device, working
> pretty much
> like an ACPI deadcode. Could we avoid this? For instance, just emit
> EDSM if
> a _DSM that relies on it is emitted, like:

I see your point and it's true that for some PCIe configs the code can
be there while not used. However it looks it is done the same way on x86
and I would tend to be not more popish than the pope ;-)

Maybe this can be a patch sent afterwards that would also address the
x86 case then.
>
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index e87846a1fa..4d6dd3dd96 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -905,8 +905,9 @@ void build_append_pcihp_slots(Aml *parent_scope,
> PCIBus *bus)
>      aml_append(parent_scope, notify_method);
>  }
>  
> -void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus)
> +bool build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus)
>  {
> +    bool has_dsm = false;
>      int devfn;
>      Aml *dev;
>  
> @@ -929,11 +930,14 @@ void build_append_pci_bus_devices(Aml
> *parent_scope, PCIBus *bus)
>              !object_property_get_bool(OBJECT(pdev), "hotpluggable",
>                                        &error_abort)) {
>              aml_append(dev, aml_pci_static_endpoint_dsm(pdev));
> +            has_dsm = true;
>          }
>  
>          /* device descriptor has been composed, add it into parent
> context */
>          aml_append(parent_scope, dev);
>      }
> +
> +    return has_dsm;
>  }
>  
>  Aml *aml_pci_edsm(void)
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 05a754d368..e4788c03ed 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -844,15 +844,22 @@ build_dsdt(GArray *table_data, BIOSLinker
> *linker, VirtMachineState *vms)
>      if (vms->acpi_pcihp) {
>          Aml *pci0_scope = aml_scope("\\_SB.PCI0");
>  
> -        aml_append(pci0_scope, aml_pci_edsm());
>          build_acpi_pci_hotplug(dsdt, AML_SYSTEM_MEMORY,
>                                 memmap[VIRT_ACPI_PCIHP].base);
>          build_append_pcihp_resources(pci0_scope,
>                                       memmap[VIRT_ACPI_PCIHP].base,
>                                       memmap[VIRT_ACPI_PCIHP].size);
>  
> -        /* Scan all PCI buses. Generate tables to support hotplug. */
> -        build_append_pci_bus_devices(pci0_scope, vms->bus);
> +        /*
> +         * Scan all PCI buses and devices. Generate tables to support
> static
> +         * endpoint devices and hotplug.
> +         */
> +        /* Generate tables for static endpoints. */
> +        if (build_append_pci_bus_devices(pci0_scope, vms->bus)) {
> +            /* Has a _DSM method that requires a EDSM method. */
> +            aml_append(pci0_scope, aml_pci_edsm());
> +        }
> +        /* Generate tables for PCI buses/slots/ */
>          if (object_property_find(OBJECT(vms->bus),
> ACPI_PCIHP_PROP_BSEL)) {
>              build_append_pcihp_slots(pci0_scope, vms->bus);
>          }
> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> index bda5ea24b5..25cc39f4ab 100644
> --- a/include/hw/acpi/pcihp.h
> +++ b/include/hw/acpi/pcihp.h
> @@ -82,7 +82,7 @@ void build_append_pcihp_resources(Aml *table,
>                                    uint64_t io_addr, uint64_t io_len);
>  bool build_append_notification_callback(Aml *parent_scope, const
> PCIBus *bus);
>  
> -void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus);
> +bool build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus);
>  
>  Aml *aml_pci_edsm(void);
>
>
> Another question that I have is: could you please share a QEMU command
> line option
> that generates a static endpoint PCI device that matches the criteria
> for the emission
> of the _DSM method accordingly to build_append_pci_bus_devices()?
You can instantiate a virtio-net-pci device on pci.0 and with acpi-index
set.

-device
virtio-net-pci,bus=pcie.0,netdev=nic0,mac=6a:f5:10:b1:3d:d2,acpi-index=12

In that case EDSM is being called:

        Device (S08)
        {
            Name (_ADR, 0x00010000)  // _ADR: Address
            Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
            {
                Local0 = Package (0x01)
                    {
                        0x0C
                    }
                Return (EDSM (Arg0, Arg1, Arg2, Arg3, Local0))
            }
        }

Putting it on a root port will let the EDSM unused.

Cheers

Eric


>
>
> Cheers,
> Gustavo
>


