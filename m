Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBE0C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 09:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJTxB-0007gV-Bk; Mon, 26 May 2025 05:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uJTwk-0007Zq-CU
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:16:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uJTwi-0002A4-5Q
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748250995;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zWQPGw3QlEEL0XhFMkrjuRafcGeI0NPRzn9xf+0xTD8=;
 b=P3FkdadxGNcDSbvPHwmW7bvzAnwLOhXWtPc3sNeDLMd69MGcSuQLEoiH/S+CUndIbY/v/a
 BsESOriBXgcTcZto3f4x00/wdbnBGUfJxcwKd2w6CBauq9nNPTr23tgElKVo4D5gzzwZYF
 jNwK/5eFtGfyoe7OTaAmyALKpi8Wexs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-qY9RvoKgNNi9sXamOIZZKQ-1; Mon, 26 May 2025 05:16:33 -0400
X-MC-Unique: qY9RvoKgNNi9sXamOIZZKQ-1
X-Mimecast-MFC-AGG-ID: qY9RvoKgNNi9sXamOIZZKQ_1748250992
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4d00e44fdso562085f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 02:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748250992; x=1748855792;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zWQPGw3QlEEL0XhFMkrjuRafcGeI0NPRzn9xf+0xTD8=;
 b=MNLplEOSH88C6St9X8LJ/aZkeT3YxnTf5NRkjwvxKFS7UeiqI9jy1qa+QJ+i4JY1ex
 NhC21sCIGwonzMre+6ZtGiVRj2a4CzNc6S7AGiK5f0otYQScN+Owe5wSxBk0h4zdhwSO
 sElFvhPihpnK3uZowsT7E03VveZ+oNQ3SlNWkIv2Bil4Qi+HOYDqUBDo3aN8SsVvfx+A
 XMTop2il7KGU+OSxQr5uXOpOV/BfoKyEw5V52cIcUnXoOaBPPoVo6pgQX6aNXcQtH+xJ
 /cH66WHtTyM7YaENuP4NM3GP9TTOJhM5RnnFfF/Vk0Ve9TWFoeB+mOirIi+A/xJQFoJo
 9l/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdVKCvoQSXRazeUKOKSLRjd48sCdCu/hoTt3KXE8u4B4LebMf5moX6VwTpzUBjBtCE7+bEBMjzLQpD@nongnu.org
X-Gm-Message-State: AOJu0Yx92vBUJrTyjyvK2jPdgrr/p+9z+LL2FHnzzWnMX33r40PE+6JN
 DfwQKDYsT7EFZARiUNbU/qkT9yVdrAuAMw8+lgzRB23Qot09HMc9UnoCpcxkygkWJqgYW3Zw9MQ
 nkCzqP2hv3OJPmVgvmcaPdl+dbAFw2eGxLZeAHZ8LzGgYxVzeNWNMAG1v
X-Gm-Gg: ASbGncs7IGhtoKnA6AK48MzEprU1XHg054tDDc3sujl8/ciMTDdj88w+skGMGU6DVB8
 7oFk94NwPMPiA2enmhpK17mjrb+ox42x/mj46l7lzmdGW20WgBsXW62qEDopyBmuVa+BDgfWk4G
 YLOwHvmFPBuqPxR17L+qQOmVil8c1BGqLHupuAPKFCpUuBKQNIbPcfLtxgT2n18EeZSbnNdERlP
 n4QYPu1rCQsdU8TRaLZEFD3c8Pj+/ZLsjCrNw3WVsHptWToYHoFBRun7am8sfje8xDBcqdGnlV4
 FKCP6Rn3Im4Hkoo+3qtVcLvbKNBcIRKIgBtci/4PpMCp2O0+8pOhRcJPCIo=
X-Received: by 2002:a5d:5848:0:b0:3a4:de27:e00f with SMTP id
 ffacd0b85a97d-3a4de27e06emr555057f8f.7.1748250992036; 
 Mon, 26 May 2025 02:16:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuR37j2DyxEYfXKFV54wEE2HqGNhNuz2wEf2nOkVct5P+H0d3c9WCd1te+0nkGSnOUHnCqKw==
X-Received: by 2002:a5d:5848:0:b0:3a4:de27:e00f with SMTP id
 ffacd0b85a97d-3a4de27e06emr555020f8f.7.1748250991499; 
 Mon, 26 May 2025 02:16:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4d17266d5sm5082921f8f.68.2025.05.26.02.16.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 02:16:29 -0700 (PDT)
Message-ID: <ea5945cc-318b-478f-bf96-294b1bf110d2@redhat.com>
Date: Mon, 26 May 2025 11:16:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/22] hw/pci-host/gpex-acpi: Use
 build_pci_host_bridge_osc_method
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gustavo Romero <gustavo.romero@linaro.org>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, shannon.zhaosl@gmail.com,
 pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org
References: <20250514170431.2786231-1-eric.auger@redhat.com>
 <20250514170431.2786231-9-eric.auger@redhat.com>
 <e1ec0e15-ad26-456b-a8d7-16f683290651@linaro.org>
 <ed823ddc-6faa-42dc-bae5-c765d21c3cca@redhat.com>
 <20250524065230-mutt-send-email-mst@kernel.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250524065230-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Michael, Gustavo,

On 5/24/25 12:54 PM, Michael S. Tsirkin wrote:
> On Wed, May 21, 2025 at 06:12:34PM +0200, Eric Auger wrote:
>> Hi Gustavo,
>>
>> On 5/20/25 4:09 PM, Gustavo Romero wrote:
>>> Hi Eric,
>>>
>>> On 5/14/25 14:00, Eric Auger wrote:
>>>> gpex build_host_bridge_osc() and x86 originated
>>>> build_pci_host_bridge_osc_method() are mostly identical.
>>>>
>>>> In GPEX, SUPP is set to CDW2 but is not further used. CTRL
>>>> is same as Local0.
>>>>
>>>> So let gpex code reuse build_pci_host_bridge_osc_method()
>>>> and remove build_host_bridge_osc().
>>>>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>
>>>> ---
>>>>
>>>> The DSDT diff  is given below:
>>>> diff --git a/dsdt.dsl_before b/dsdt.dsl_after_osc_change
>>>> index 3224a56..fa7558e 100644
>>>> --- a/dsdt.dsl_before
>>>> +++ b/dsdt.dsl_after_osc_change
>>>> @@ -5,13 +5,13 @@
>>>>    *
>>>>    * Disassembling to symbolic ASL+ operators
>>>>    *
>>>> - * Disassembly of dsdt.dat, Mon Apr  7 05:33:06 2025
>>>> + * Disassembly of dsdt.dat, Mon Apr  7 05:37:20 2025
>>>>    *
>>>>    * Original Table Header:
>>>>    *     Signature        "DSDT"
>>>> - *     Length           0x00001A4F (6735)
>>>> + *     Length           0x00001A35 (6709)
>>>>    *     Revision         0x02
>>>> - *     Checksum         0xBF
>>>> + *     Checksum         0xDD
>>>>    *     OEM ID           "BOCHS "
>>>>    *     OEM Table ID     "BXPC    "
>>>>    *     OEM Revision     0x00000001 (1)
>>>> @@ -1849,27 +1849,26 @@ DefinitionBlock ("", "DSDT", 2, "BOCHS ",
>>>> "BXPC    ", 0x00000001)
>>>>                   {
>>>>                       CreateDWordField (Arg3, 0x04, CDW2)
>>>>                       CreateDWordField (Arg3, 0x08, CDW3)
>>>> -                    SUPP = CDW2 /* \_SB_.PCI0._OSC.CDW2 */
>>>> -                    CTRL = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
>>>> -                    CTRL &= 0x1F
>>>> +                    Local0 = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
>>>> +                    Local0 &= 0x1F
>>>>                       If ((Arg1 != One))
>>>>                       {
>>>>                           CDW1 |= 0x08
>>>>                       }
>>>>
>>>> -                    If ((CDW3 != CTRL))
>>>> +                    If ((CDW3 != Local0))
>>>>                       {
>>>>                           CDW1 |= 0x10
>>>>                       }
>>>>
>>>> -                    CDW3 = CTRL /* \_SB_.PCI0.CTRL */
>>>> -                    Return (Arg3)
>>>> +                    CDW3 = Local0
>>>>                   }
>>>>                   Else
>>>>                   {
>>>>                       CDW1 |= 0x04
>>>> -                    Return (Arg3)
>>>>                   }
>>>> +
>>>> +                Return (Arg3)
>>>>               }
>>>>
>>>>               Method (_DSM, 4, NotSerialized)  // _DSM:
>>>> Device-Specific Method
>>> The problem I face with diffs in the commit body is that tools like
>>> b4, which are
>>> based on git am, get very confused on how to handle it. I'm surprised
>>> nobody ever
>>> complained about it. I'm wondering if there is any catch on it,
>>> because I have to
>>> edit commits like this manually, removing the diff, to make it finally
>>> apply to
>>> the series. Anyways, do you mind at least removing the valid diff
>>> header, like:
>>>
>>>> diff --git a/dsdt.dsl_before b/dsdt.dsl_after_osc_change
>>>> index 3224a56..fa7558e 100644
>>>> --- a/dsdt.dsl_before
>>>> +++ b/dsdt.dsl_after_osc_change
>>> from the commit message so it doesn't confuse b4?
>> Thank you for reporting the issue. in tests/qtest/bios-tables-test.c it
>> is written at the top that we shall put the diffs in disasembled ACPI
>> content in the commit msg. I will look for previously landed patches and
>> see whether the current layout can be fixed.
>>
>> Cheers
>>
>> Eric
>
> Eric, to clarify, the diff is supposed to go into commit log,
> not after ---.
> This will make it apply cleanly.
> Also, removing the "index" line as well as date diff at least is a good
> idea: the diff should be clean, not include irrelevant information.
>
> Pls feel free to clarify the text in tests/qtest/bios-tables-test.c

Of thanks. I applied your suggestions.

Eric
>
>
>
>>>
>>>> ---
>>>>   hw/pci-host/gpex-acpi.c | 60 +++--------------------------------------
>>>>   1 file changed, 4 insertions(+), 56 deletions(-)
>>>>
>>>> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
>>>> index f1ab30f3d5..98c9868c3f 100644
>>>> --- a/hw/pci-host/gpex-acpi.c
>>>> +++ b/hw/pci-host/gpex-acpi.c
>>>> @@ -50,60 +50,7 @@ static void acpi_dsdt_add_pci_route_table(Aml
>>>> *dev, uint32_t irq,
>>>>       }
>>>>   }
>>>>   -static Aml *build_host_bridge_osc(bool enable_native_pcie_hotplug)
>>>> -{
>>>> -    Aml *method, *UUID, *ifctx, *ifctx1, *elsectx;
>>>> -
>>>> -    method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
>>>> -    aml_append(method,
>>>> -        aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
>>>> -
>>>> -    /* PCI Firmware Specification 3.0
>>>> -     * 4.5.1. _OSC Interface for PCI Host Bridge Devices
>>>> -     * The _OSC interface for a PCI/PCI-X/PCI Express hierarchy is
>>>> -     * identified by the Universal Unique IDentifier (UUID)
>>>> -     * 33DB4D5B-1FF7-401C-9657-7441C03DD766
>>>> -     */
>>>> -    UUID = aml_touuid("33DB4D5B-1FF7-401C-9657-7441C03DD766");
>>>> -    ifctx = aml_if(aml_equal(aml_arg(0), UUID));
>>>> -    aml_append(ifctx,
>>>> -        aml_create_dword_field(aml_arg(3), aml_int(4), "CDW2"));
>>>> -    aml_append(ifctx,
>>>> -        aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
>>>> -    aml_append(ifctx, aml_store(aml_name("CDW2"), aml_name("SUPP")));
>>>> -    aml_append(ifctx, aml_store(aml_name("CDW3"), aml_name("CTRL")));
>>>> -
>>>> -    /*
>>>> -     * Allow OS control for SHPCHotplug, PME, AER, PCIeCapability,
>>>> -     * and PCIeHotplug depending on enable_native_pcie_hotplug
>>>> -     */
>>>> -    aml_append(ifctx, aml_and(aml_name("CTRL"),
>>>> -               aml_int(0x1E | (enable_native_pcie_hotplug ? 0x1 :
>>>> 0x0)),
>>>> -               aml_name("CTRL")));
>>>> -
>>>> -    ifctx1 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(0x1))));
>>>> -    aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x08),
>>>> -                              aml_name("CDW1")));
>>>> -    aml_append(ifctx, ifctx1);
>>>> -
>>>> -    ifctx1 = aml_if(aml_lnot(aml_equal(aml_name("CDW3"),
>>>> aml_name("CTRL"))));
>>>> -    aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x10),
>>>> -                              aml_name("CDW1")));
>>>> -    aml_append(ifctx, ifctx1);
>>>> -
>>>> -    aml_append(ifctx, aml_store(aml_name("CTRL"), aml_name("CDW3")));
>>>> -    aml_append(ifctx, aml_return(aml_arg(3)));
>>>> -    aml_append(method, ifctx);
>>>> -
>>>> -    elsectx = aml_else();
>>>> -    aml_append(elsectx, aml_or(aml_name("CDW1"), aml_int(4),
>>>> -                               aml_name("CDW1")));
>>>> -    aml_append(elsectx, aml_return(aml_arg(3)));
>>>> -    aml_append(method, elsectx);
>>>> -    return method;
>>>> -}
>>>> -
>>>> -static Aml *build_host_bridge_dsm(void)
>>>> +static Aml *build_pci_host_bridge_dsm_method(void)
>>>>   {
>>>>       Aml *method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
>>>>       Aml *UUID, *ifctx, *ifctx1, *buf;
>>>> @@ -134,8 +81,9 @@ static void acpi_dsdt_add_host_bridge_methods(Aml
>>>> *dev,
>>>>       aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
>>>>       aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
>>>>       /* Declare an _OSC (OS Control Handoff) method */
>>>> -    aml_append(dev, build_host_bridge_osc(enable_native_pcie_hotplug));
>>>> -    aml_append(dev, build_host_bridge_dsm());
>>>> +    aml_append(dev,
>>>> +              
>>>> build_pci_host_bridge_osc_method(enable_native_pcie_hotplug));
>>>> +    aml_append(dev, build_pci_host_bridge_dsm_method());
>>>>   }
>>>>     void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>>> Otherwise:
>>>
>>> Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
>>>
>>>
>>> Cheers,
>>> Gustavo
>>>


