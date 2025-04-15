Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8436C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 17:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4kCx-0007cD-0k; Tue, 15 Apr 2025 13:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u4kCw-0007aP-7v
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 13:36:26 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u4kCt-0001Il-1C
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 13:36:25 -0400
Received: by mail-pj1-x1041.google.com with SMTP id
 98e67ed59e1d1-2ff784dc055so5886434a91.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 10:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744738581; x=1745343381; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6GqxFwj0tUW8Vk3vM6aKYHAMIOXlr0Y9lcgVV8FNXas=;
 b=e34N3BbtWe1/uJZz8ik57vBphvIrjsfxfslwPak4xqWnYU7Ra0WN5+whegQSnhDav9
 /U2yv/m9qAoeCsNoFRUgJqJib7JgOY0/PjnuEPl3bpCn4f6HO6g8DW6yqA7Ta2O3mmTa
 CM1kWVLErHMFuwj2yEz57NRkEDU+mZaIdxOi/c33PoWtFIq92I4aXxHYifAnBexEicVW
 RcPMrYbURomCoEnnc1S6GHuirXy9LXnwoaWQHKdN4PVt0PbqYuMO+4XoQxdhjV8YTcdk
 yNDpO8vTUF9v7iLC8bfP7yeJlrQyt7otYMiRF0DWoPmi00bzHNUyXSDMDv8LGgFsr1Vr
 WKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744738581; x=1745343381;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6GqxFwj0tUW8Vk3vM6aKYHAMIOXlr0Y9lcgVV8FNXas=;
 b=hJu57vX/s5C+aYhzYESxyiqXN51dNRpQapkhZn+RgltpLMoVM0+LSpfvKnyxXSS91O
 GnUAxU8BWYF3LUXWBYhZBlOi5upjRy99iHJaadj8k6TZBu5MqhvNjHy4R4TZUIt100lu
 lqZYcTT5BQ9P9AbFF9Gchty2yj8tRI25BxZdgrGGykGUSYcT9If83Nm31hMzz85UZmFK
 Xc+UQp8Q8j1OzDUf0EvGoCvFtdulHzlj+SAIbi3B0NgSl8kPxjuhloVGbrVZuP7vP+l2
 LIA1UbhS786hEe/JHEde5AqnKmDyA6xyGUNhxe+wDF49SKKm6e2vJUZx5OokUKg/OX6F
 eafg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdQMbwUJnyA+4SIK/S8FG027Dx/ce4OtlGnU5Jaoqoa0bXMT7llDHKTa27RTW84DSlnULMqzqCcDNS@nongnu.org
X-Gm-Message-State: AOJu0YxcDJD65flskzsb9/xwK7ha0NqOPmpI9LNsz5DPy9/A0v1nnWWv
 gMOCAKnbS1Ojz3SUXIH+TA3/TA7f5WB0QnNKROcgiRHzTUAaXEA=
X-Gm-Gg: ASbGnctrA0xhMj9LWBzYBsItju0lYG+lNapLqrRFbJfKhY4Klyjv3xPH5CL/XYLm01p
 U9Zdhpj5Xqu90k4gVoPNOtMle4vaa9kI67jDuXCV8ZWFMOWm/r1WCJU4+GzOBvMAHZVC5e1Zw0N
 lLgwp7s1UoIAkr++ddIssp6YzZGH4ueulTyPLRYTQNxm2LahO1dteF2GdOHdAfS2nYhEBjiQPIR
 ACiD3Cw5VCvrabG1gUYLYMy4MsGvFDYibNlxSGh6sHriVyjiYKEaASaa2M8vDdnj5elJ14LN1dd
 RDK55gNNss56WnApJYrUg3A/Nm87BaAWDkqUtERbx3dYxmM=
X-Google-Smtp-Source: AGHT+IHXpgLkIVpF+GID4ExASySGBgOlfXyxbNDemXnBGp63pcEHS2HJf7Popg+hlHZDq4J+f1309Q==
X-Received: by 2002:a17:90b:562e:b0:2ff:692b:b15 with SMTP id
 98e67ed59e1d1-308237f41aemr29890354a91.33.1744738581096; 
 Tue, 15 Apr 2025 10:36:21 -0700 (PDT)
Received: from [192.168.0.113] ([139.227.89.108])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306dd12b5eesm13648860a91.29.2025.04.15.10.36.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 10:36:20 -0700 (PDT)
Message-ID: <e529bf00-bd58-4151-9bce-dad74c88fa6d@gmail.com>
Date: Wed, 16 Apr 2025 01:36:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/igd: Check host PCI address when probing
To: Alex Williamson <alex.williamson@redhat.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Corvin_K=C3=B6hne?= <c.koehne@beckhoff.com>
References: <20250325172239.27926-1-tomitamoeko@gmail.com>
 <20250409111801.4c97022f.alex.williamson@redhat.com>
 <046a2961-23b1-4ef2-8673-9b9deedbbbdf@redhat.com>
 <3e9743ab-bf81-4d92-8ea0-e01ac58a234b@gmail.com>
 <20250414160530.5d86aaf2.alex.williamson@redhat.com>
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <20250414160530.5d86aaf2.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pj1-x1041.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 4/15/25 06:05, Alex Williamson wrote:
> On Mon, 14 Apr 2025 01:23:56 +0800
> Tomita Moeko <tomitamoeko@gmail.com> wrote:
> 
>> On 4/10/25 15:34, Cédric Le Goater wrote:
>>> + Corvin
>>>
>>> On 4/9/25 19:18, Alex Williamson wrote:  
>>>> On Wed, 26 Mar 2025 01:22:39 +0800
>>>> Tomita Moeko <tomitamoeko@gmail.com> wrote:
>>>>  
>>>>> So far, all Intel VGA adapters, including discrete GPUs like A770 and
>>>>> B580, were treated as IGD devices. While this had no functional impact,
>>>>> a error about "unsupported IGD device" will be printed when passthrough
>>>>> Intel discrete GPUs.
>>>>>
>>>>> Since IGD devices must be at "0000:00:02.0", let's check the host PCI
>>>>> address when probing.
>>>>>
>>>>> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
>>>>> ---
>>>>>   hw/vfio/igd.c | 23 +++++++++--------------
>>>>>   1 file changed, 9 insertions(+), 14 deletions(-)
>>>>>
>>>>> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
>>>>> index 265fffc2aa..ff250017b0 100644
>>>>> --- a/hw/vfio/igd.c
>>>>> +++ b/hw/vfio/igd.c
>>>>> @@ -53,6 +53,13 @@
>>>>>    * headless setup is desired, the OpRegion gets in the way of that.
>>>>>    */
>>>>>   +static bool vfio_is_igd(VFIOPCIDevice *vdev)
>>>>> +{
>>>>> +    return vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) &&
>>>>> +           vfio_is_vga(vdev) &&
>>>>> +           vfio_pci_host_match(&vdev->host, "0000:00:02.0");
>>>>> +}  
>>>>
>>>> vfio-pci devices can also be specified via sysfsdev= rather than host=,
>>>> so at a minimum I think we'd need to test against vdev->vbasedev.name,
>>>> as other callers of vfio_pci_host_match do.  For example building a
>>>> local PCIHostDeviceAddress and comparing it to name.  This is also not
>>>> foolproof though if we start taking advantage of devices passed by fd.
>>>>
>>>> Could we instead rely PCIe capabilities?  A discrete GPU should
>>>> identify as either an endpoint or legacy endpoint and IGD should
>>>> identify as a root complex integrated endpoint, or maybe older versions
>>>> would lack the PCIe capability altogether.  
>>>
>>> Maintaining a list of PCI IDs for Intel GPU devices as Corvin was
>>> proposing in [1] is not a viable solution ?
>>>
>>> Thanks,
>>>
>>> C.
>>>
>>> [1] https://lore.kernel.org/qemu-devel/20250206121341.118337-1-corvin.koehne@gmail.com/  
>>
>> I checked Intel doc, probably maintaining an device ID list is the only
>> possible way. But given that intel is moving to xe driver, generation
>> becomes unclear, I'd like to propose a list with quirk flags for igd.
>>
>> static const struct igd_device igd_devices[] = {
>>     INTEL_SNB_IDS(IGD_DEVICE, OPREGION_QUIRK | BDSM_QUIRK),
>>     INTEL_TGL_IDS(IGD_DEVICE, OPREGION_QUIRK | BDSM64_QUIRK),
>> }
>>
>> Matching in the list is more time consuming than current switch-case,
>> it's better to have a new field to cache it.
>>
>> I will go with Corvin's first 2 patches with reordering suggested by
>> Cornelia.
> 
> If I recall the discussion correctly, Corvin's series was mapping device
> IDs to generation, where I had the concern that it creates ongoing
> overhead to sync with the i915 driver to create new mappings.  There
> was a suggestion that newer hardware has a register that reports the
> generation, so maybe we only need to manage creating the mapping table
> up to the point we can rely on getting the generation information from
> hardware (with the massive caveat that Intel could drop that generation
> register in the future, or maybe already has).
> 
> The above table however suggests yet another use case of the table, a
> mapping of quirks to specific devices.  It seems this once again
> introduces the maintenance issue.  Why would it not be sufficient to
> determine the quirks based on the generation alone?  Thanks,
> 
> Alex

The generation register also exists on discrete GPUs. In the new xe
driver [1], the Battlemage discrete GPU shares the same logic reading
GMD_ID_DISPLAY register. The driver itself uses is_dgfx bit mapped to
device id. In QEMU, we need to know whether the device is a supported
IGD device first before applying the IGD-specific quirk, especially
for legacy mode.

The most feasible way is to check if kernel exposes VFIO_REGION_SUBTYPE_
INTEL_IGD_OPREGION on that device I think, as only IGD has OpRegion.

i915 driver [2] and Arrow Lake datasheet [3] shows that Intel has
removed the BDSM register by making the DSM range part of BAR2 since
Meteor Lake and onwards. QEMU only need to quirk on the register for
IGD devices until Raptor Lake, meaning that the device list is fixed
for now.

By the way, for legacy mode, I think we should only support it until
Gen 9, as Intel only provide VBIOS or CSM support until that generation,
and seabios cannot handle 64 bit BDSM register. I'm also wondering if
VGA really works on newer generations.

Maybe we can continue with current igd_gen, but implement a logic like:
    if (!intel graphics)
        return;
    if (!has VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION)
        return;
    setup_opregion();  // make x-igd-opregion automatically enabled?
    if (gen <= 9)
        setup_legacy_mode();
    if (gen >= 6 && gen <=9)
        setup_32bit_bdsm():
    else if (gen >= 9 && gen <= 12)
        setup_64bit_bdsm();
    // ...
    // optional quirks like lpc bridge id

A table can also be used to precisely track all the gen 6-12 devices.

[1] https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/xe/xe_pci.c#L630
[2] https://github.com/torvalds/linux/blob/69b8923f5003664e3ffef102e73333edfa2abdcf/drivers/gpu/drm/i915/gem/i915_gem_stolen.c#L918
[3] https://edc.intel.com/content/www/us/en/design/publications/core-ultra-p200s-series-processors-cfg-mem-registers/d2-f0-processor-graphics-registers/

Thanks,
Moeko

Attached a config space dump of Intel A770 discrete GPU for reference

03:00.0 VGA compatible controller: Intel Corporation DG2 [Arc A770] (rev 08) (prog-if 00 [VGA controller])
	Subsystem: Intel Corporation Device 1020
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 64 bytes
	Interrupt: pin ? routed to IRQ 181
	IOMMU group: 19
	Region 0: Memory at 81000000 (64-bit, non-prefetchable) [size=16M]
	Region 2: Memory at 6000000000 (64-bit, prefetchable) [size=16G]
	Expansion ROM at 82000000 [disabled] [size=2M]
	Capabilities: [40] Vendor Specific Information: Len=0c <?>
	Capabilities: [70] Express (v2) Endpoint, IntMsgNum 0
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0W TEE-IO-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s, Width x1
			TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range B, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp+ 10BitTagReq+ OBFF Not Supported, ExtFmt+ EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
			 AtomicOpsCtl: ReqEn-
			 IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
			 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
		LnkCap2: Supported Link Speeds: 2.5GT/s, Crosslink- Retimer- 2Retimers- DRS-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [ac] MSI: Enable+ Count=1/1 Maskable+ 64bit+
		Address: 00000000fee008b8  Data: 0000
		Masking: 00000000  Pending: 00000000
	Capabilities: [d0] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Alternative Routing-ID Interpretation (ARI)
		ARICap:	MFVC- ACS-, Next Function: 0
		ARICtl:	MFVC- ACS-, Function Group: 0
	Capabilities: [420 v1] Physical Resizable BAR
		BAR 2: current size: 16GB, supported: 256MB 512MB 1GB 2GB 4GB 8GB 16GB
	Capabilities: [400 v1] Latency Tolerance Reporting
		Max snoop latency: 15728640ns
		Max no snoop latency: 15728640ns
	Kernel driver in use: i915
	Kernel modules: i915, xe
00: 86 80 a0 56 07 00 10 00 08 00 00 03 10 00 00 00
10: 04 00 00 81 00 00 00 00 0c 00 00 00 60 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 20 10
30: 00 00 00 82 40 00 00 00 00 00 00 00 ff 00 00 00
40: 09 70 0c 01 03 00 00 00 00 00 00 00 00 00 00 00
50: c0 f5 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 10 ac 02 00 20 80 00 10 10 09 08 00 11 0c 40 00
80: 00 00 11 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 12 08 13 00 00 04 00 00 02 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 05 d0 81 01
b0: b8 08 e0 fe 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 01 00 03 48 08 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 47 01 c0 ff 03 00 00 00 00 00 00 00 00 00 00 00


