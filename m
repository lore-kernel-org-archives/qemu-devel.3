Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6EDC0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 07:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1te8O6-0001y2-FZ; Sat, 01 Feb 2025 02:57:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1te8O4-0001xR-5e
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 02:57:56 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1te8O0-0005Mw-Ud
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 02:57:55 -0500
Received: by mail-pj1-x1044.google.com with SMTP id
 98e67ed59e1d1-2f42992f608so3804775a91.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 23:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738396671; x=1739001471; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iKOTWGQ0ILr4H4q6qyqX1jjs4pev1D5ZmES7b3DwGNo=;
 b=Z3gwQ8q68NDH+Hce/2Q2/yGP5QDgNEzHw/7ebT0Z1hC0d5bSdRjDmX8eyA4I9dPlVK
 tWYlgOomf6EMN5dIuz6f4wErBeMaJG8xHnfLCzhJmTEntM/GJrz/7is3sLaDVatJyHHH
 sQpoo+bGLg5zBI21Z4Y1qg2Uw1keryK/Db5P3JBRgoaculN7EIVu5dNrLiroPwOUxml3
 R7GS4Q1n7C0KWipmszzoKLTxbO8hWm88OkhiNXsLYQlz6JlsEhJM2XTHE7tC5JzpRRje
 u8e+QIE+3Mta1I5bc+RQvVtqLA5f7mLgHxS94Wpm5NrACl2uMh+pL/UpQnHnykOWzr4h
 08tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738396671; x=1739001471;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iKOTWGQ0ILr4H4q6qyqX1jjs4pev1D5ZmES7b3DwGNo=;
 b=gx437fbHGSkqF0YM7WnYU1Ia/dTugW0mYLf8ZvJDKi8MIw0kU1WyXwUdnAU4QIRaBg
 58HCT2F/saWlIWFdT6t/uMTSwtsiizzGtMeWZ7S8N3n3mvCGJKUXLC89lrS18C3eRvp1
 L5hFHg7cgY+26xaZxbNEFWBJP/DhMRv5U46MA6flRvSkYdFru2XH9K32HED7680hJpXN
 aePH+RujpTYVTKOmHOY/PL9qqkWtoa4HJ+StCyn3cfW+5zYC8+N59nhTguDdT3McTNTm
 kJWsY3e87IQW/uJklvV99gbhHURQ/CfCq6qlIB/Jki3XIyzGBPKCEmDMBc2G6xTKGcVE
 EOjQ==
X-Gm-Message-State: AOJu0YxEd0EpVewWv8N4IYhTCko6m0yZPTRa8cp2KmHm/dw/SBJWFfro
 uwk20edNAN0pIo9naEVpfKE4vxAthBCiE09zV4UDPNRzXrNR31y64ibWGtFhGA==
X-Gm-Gg: ASbGncvd+2TgzMpsYurZDci3cq+vOIs7Btg0vAAbAmYdrnLdNARUavRKR6gMAc6ETKn
 iAnqYk3M4Q6uw4nvfZXrh9LTLVaVuh5LnFVBiIX3iYupTAM5BdzAsTF+ojw34V3/fymG+F0Bms5
 HuO11gpqJTKngGFOLN5t/6P3lptTxwtOUHk7WN97Rm7TVA5VfPGO73obpcCxKHKv/uVmRG/7YmF
 EgAPTLGs+bVPPgoig5SkTIQYfoQ+w9Jdy+Aefgm92A3Yl7d8hxXq0dujZk6q3lrpNCPqtp80IKn
 DajuY/LLKzfL66qdA8QumA==
X-Google-Smtp-Source: AGHT+IGqu1g7KfqVz2HAchC0jDWpPDtx9IW92IdiuwiHSGy5sKXIuOiMaZECeBASCThxkf7YK+T55Q==
X-Received: by 2002:a17:90b:2dc7:b0:2ee:4b8f:a5b1 with SMTP id
 98e67ed59e1d1-2f83ac73aadmr21230733a91.24.1738396671181; 
 Fri, 31 Jan 2025 23:57:51 -0800 (PST)
Received: from [192.168.0.163] ([116.232.67.252])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f83bd0cf6dsm7949032a91.29.2025.01.31.23.57.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2025 23:57:50 -0800 (PST)
Message-ID: <e667442b-dd10-4881-b1a4-7c493b2e6d3c@gmail.com>
Date: Sat, 1 Feb 2025 15:57:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] vfio/igd: handle x-igd-opregion in
 vfio_probe_igd_config_quirk()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250124191245.12464-1-tomitamoeko@gmail.com>
 <20250124191245.12464-6-tomitamoeko@gmail.com>
 <20250124141342.255a79d3.alex.williamson@redhat.com>
 <7cd85e39-88e6-497d-b0b0-41a0a0ece0fb@gmail.com>
 <377fd72e-6bff-45f4-a9db-413f3565fd75@gmail.com>
 <20250130134113.5d60442f.alex.williamson@redhat.com>
 <6cbfd37a-ce7d-4be0-ac7d-81cb7c805933@redhat.com>
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <6cbfd37a-ce7d-4be0-ac7d-81cb7c805933@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pj1-x1044.google.com
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

On 1/31/25 18:15, Cédric Le Goater wrote:
> On 1/30/25 21:41, Alex Williamson wrote:
>> On Fri, 31 Jan 2025 02:33:03 +0800
>> Tomita Moeko <tomitamoeko@gmail.com> wrote:
>>
>>> On 1/25/25 15:42, Tomita Moeko wrote:
>>>> On 1/25/25 05:13, Alex Williamson wrote:
>>>>> On Sat, 25 Jan 2025 03:12:45 +0800
>>>>> Tomita Moeko <tomitamoeko@gmail.com> wrote:
>>>>>  
>>>>>> Both enable opregion option (x-igd-opregion) and legacy mode require
>>>>>> setting up OpRegion copy for IGD devices. Move x-igd-opregion handler
>>>>>> in vfio_realize() to vfio_probe_igd_config_quirk() to elimate duplicate
>>>>>> code. Finally we moved all the IGD-related code into igd.c.
>>>>>>
>>>>>> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
>>>>>> ---
>>>>>>   hw/vfio/igd.c        | 143 +++++++++++++++++++++++++++++++++----------
>>>>>>   hw/vfio/pci-quirks.c |  50 ---------------
>>>>>>   hw/vfio/pci.c        |  25 --------
>>>>>>   hw/vfio/pci.h        |   4 --
>>>>>>   4 files changed, 110 insertions(+), 112 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
>>>>>> index 6e06dd774a..015beacf5f 100644
>>>>>> --- a/hw/vfio/igd.c
>>>>>> +++ b/hw/vfio/igd.c
>>>>>> @@ -106,6 +106,7 @@ static int igd_gen(VFIOPCIDevice *vdev)
>>>>>>       return -1;
>>>>>>   }
>>>>>>   +#define IGD_ASLS 0xfc /* ASL Storage Register */
>>>>>>   #define IGD_GMCH 0x50 /* Graphics Control Register */
>>>>>>   #define IGD_BDSM 0x5c /* Base Data of Stolen Memory */
>>>>>>   #define IGD_BDSM_GEN11 0xc0 /* Base Data of Stolen Memory of gen 11 and later */
>>>>>> @@ -138,6 +139,55 @@ static uint64_t igd_stolen_memory_size(int gen, uint32_t gmch)
>>>>>>       return 0;
>>>>>>   }
>>>>>>   +/*
>>>>>> + * The OpRegion includes the Video BIOS Table, which seems important for
>>>>>> + * telling the driver what sort of outputs it has.  Without this, the device
>>>>>> + * may work in the guest, but we may not get output.  This also requires BIOS
>>>>>> + * support to reserve and populate a section of guest memory sufficient for
>>>>>> + * the table and to write the base address of that memory to the ASLS register
>>>>>> + * of the IGD device.
>>>>>> + */
>>>>>> +static bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
>>>>>> +                                       struct vfio_region_info *info,
>>>>>> +                                       Error **errp)
>>>>>> +{
>>>>>> +    int ret;
>>>>>> +
>>>>>> +    vdev->igd_opregion = g_malloc0(info->size);
>>>>>> +    ret = pread(vdev->vbasedev.fd, vdev->igd_opregion,
>>>>>> +                info->size, info->offset);
>>>>>> +    if (ret != info->size) {
>>>>>> +        error_setg(errp, "failed to read IGD OpRegion");
>>>>>> +        g_free(vdev->igd_opregion);
>>>>>> +        vdev->igd_opregion = NULL;
>>>>>> +        return false;
>>>>>> +    }
>>>>>> +
>>>>>> +    /*
>>>>>> +     * Provide fw_cfg with a copy of the OpRegion which the VM firmware is to
>>>>>> +     * allocate 32bit reserved memory for, copy these contents into, and write
>>>>>> +     * the reserved memory base address to the device ASLS register at 0xFC.
>>>>>> +     * Alignment of this reserved region seems flexible, but using a 4k page
>>>>>> +     * alignment seems to work well.  This interface assumes a single IGD
>>>>>> +     * device, which may be at VM address 00:02.0 in legacy mode or another
>>>>>> +     * address in UPT mode.
>>>>>> +     *
>>>>>> +     * NB, there may be future use cases discovered where the VM should have
>>>>>> +     * direct interaction with the host OpRegion, in which case the write to
>>>>>> +     * the ASLS register would trigger MemoryRegion setup to enable that.
>>>>>> +     */
>>>>>> +    fw_cfg_add_file(fw_cfg_find(), "etc/igd-opregion",
>>>>>> +                    vdev->igd_opregion, info->size);
>>>>>> +
>>>>>> +    trace_vfio_pci_igd_opregion_enabled(vdev->vbasedev.name);
>>>>>> +
>>>>>> +    pci_set_long(vdev->pdev.config + IGD_ASLS, 0);
>>>>>> +    pci_set_long(vdev->pdev.wmask + IGD_ASLS, ~0);
>>>>>> +    pci_set_long(vdev->emulated_config_bits + IGD_ASLS, ~0);
>>>>>> +
>>>>>> +    return true;
>>>>>> +}
>>>>>> +
>>>>>>   /*
>>>>>>    * The rather short list of registers that we copy from the host devices.
>>>>>>    * The LPC/ISA bridge values are definitely needed to support the vBIOS, the
>>>>>> @@ -339,29 +389,83 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>>>>>>       QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, bdsm_quirk, next);
>>>>>>   }
>>>>>>   +static bool vfio_igd_try_enable_opregion(VFIOPCIDevice *vdev, Error **errp)
>>>>>> +{
>>>>>> +    g_autofree struct vfio_region_info *opregion = NULL;
>>>>>> +    int ret;
>>>>>> +
>>>>>> +    /*
>>>>>> +     * Hotplugging is not supprted for both opregion access and legacy mode.
>>>>>> +     * For legacy mode, we also need to mark the ROM failed.
>>>>>> +     */
>>>>>
>>>>> The explanation was a little better in the removed comment.
>>>>>  
>>>>>> +    if (vdev->pdev.qdev.hotplugged) {
>>>>>> +        vdev->rom_read_failed = true;
>>>>>> +        error_setg(errp,
>>>>>> +                   "IGD OpRegion is not supported on hotplugged device");
>>>>>
>>>>> As was the error log.
>>>>>  
>>>>>> +        return false;
>>>>>> +    }
>>>>>> +
>>>>>> +    ret = vfio_get_dev_region_info(&vdev->vbasedev,
>>>>>> +                    VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
>>>>>> +                    VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, &opregion);
>>>>>> +    if (ret) {
>>>>>> +        error_setg_errno(errp, -ret,
>>>>>> +                         "device does not supports IGD OpRegion feature");
>>>>>> +        return false;
>>>>>> +    }
>>>>>> +
>>>>>> +    if (!vfio_pci_igd_opregion_init(vdev, opregion, errp)) {
>>>>>> +        return false;
>>>>>> +    }
>>>>>> +
>>>>>> +    return true;
>>>>>> +}
>>>>>> +
>>>>>>   bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
>>>>>> -                                 Error **errp G_GNUC_UNUSED)
>>>>>> +                                 Error **errp)
>>>>>>   {
>>>>>>       g_autofree struct vfio_region_info *rom = NULL;
>>>>>> -    g_autofree struct vfio_region_info *opregion = NULL;
>>>>>>       g_autofree struct vfio_region_info *host = NULL;
>>>>>>       g_autofree struct vfio_region_info *lpc = NULL;
>>>>>> +    PCIBus *bus;
>>>>>>       PCIDevice *lpc_bridge;
>>>>>>       int ret, gen;
>>>>>> +    bool legacy_mode, enable_opregion;
>>>>>>       uint64_t gms_size;
>>>>>>       uint64_t *bdsm_size;
>>>>>>       uint32_t gmch;
>>>>>>       Error *err = NULL;
>>>>>>   +    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
>>>>>> +        !vfio_is_vga(vdev)) {
>>>>>> +        return true;
>>>>>> +    }
>>>>>> +
>>>>>>       /*
>>>>>>        * This must be an Intel VGA device at address 00:02.0 for us to even
>>>>>>        * consider enabling legacy mode.  The vBIOS has dependencies on the
>>>>>>        * PCI bus address.
>>>>>>        */
>>>>>> -    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
>>>>>> -        !vfio_is_vga(vdev) ||
>>>>>> -        &vdev->pdev != pci_find_device(pci_device_root_bus(&vdev->pdev),
>>>>>> -                                       0, PCI_DEVFN(0x2, 0))) {
>>>>>> +    bus = pci_device_root_bus(&vdev->pdev);
>>>>>> +    legacy_mode = (&vdev->pdev == pci_find_device(bus, 0, PCI_DEVFN(0x2, 0)));
>>>>>> +    enable_opregion = (vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION);
>>>>>> +
>>>>>> +    if (!enable_opregion && !legacy_mode) {
>>>>>> +        return true;
>>>>>> +    }
>>>>>> +
>>>>>> +    if (!vfio_igd_try_enable_opregion(vdev, &err)) {
>>>>>> +        if (enable_opregion) {
>>>>>> +            error_propagate(errp, err);
>>>>>> +            return false;
>>>>>> +        } else if (legacy_mode) {
>>>>>> +            error_append_hint(&err, "IGD legacy mode disabled\n");
>>>>>> +            error_report_err(err);
>>>>>> +            return true;
>>>>>> +        }
>>>>>> +    }
>>>>>> +
>>>>>> +    if (!legacy_mode) {
>>>>>>           return true;
>>>>>>       }
>>>>>>   @@ -404,30 +508,10 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
>>>>>>           return true;
>>>>>>       }
>>>>>>   -    /*
>>>>>> -     * Ignore the hotplug corner case, mark the ROM failed, we can't
>>>>>> -     * create the devices we need for legacy mode in the hotplug scenario.
>>>>>> -     */
>>>>>> -    if (vdev->pdev.qdev.hotplugged) {
>>>>>> -        error_report("IGD device %s hotplugged, ROM disabled, "
>>>>>> -                     "legacy mode disabled", vdev->vbasedev.name);
>>>>>> -        vdev->rom_read_failed = true;
>>>>>> -        return true;
>>>>>> -    }
>>>>>> -
>>>>>>       /*
>>>>>>        * Check whether we have all the vfio device specific regions to
>>>>>>        * support legacy mode (added in Linux v4.6).  If not, bail.
>>>>>>        */
>>>>>> And we're disassociating opregion setup from this useful comment.
>>>>>
>>>>> What are we actually accomplishing here?  What specific code
>>>>> duplication is eliminated?
>>>>
>>>> This patch is designed for moving the opregion quirk in vfio_realize()
>>>> to igd.c, for better isolation of the igd-specific code. Legacy mode
>>>> also need to initialize opregion as x-igd-opregion=on option. These
>>>> code are almost the same, except legacy mode continues on error, while
>>>> x-igd-opregion fails.
>>>>
>>>> I am going to clearify that in the commit message of v3.
>>>>   
>>>>> Why is it important to move all this code to igd.c?
>>>
>>> x-igd-opreqion quirk is currently located in pci-quirks.c, which is not
>>> controlled by CONFIG_VFIO_IGD, moving it to igd.c prevents building
>>> that unnecessary code in certain binaries, for example, non x86 builds.
>>>
>>>>> It's really difficult to untangle this refactor, I think it could be
>>>>> done more iteratively, if it's really even beneficial.  Thanks,
>>>>>
>>>>> Alex
>>>>
>>>> Agreed. Actually I'd like to totally remove the "legacy mode" and "UPT
>>>> mode" concept in future, my proposal is:
>>>> * Emulate and initialize ASLS and BDSM register unconditionally. These
>>>>    registers holds HPA, keeping the old value to guest is not a good
>>>>    idea
>>>> * Make the host bridge and LPC bridge ID quirks optional like OpRegion.
>>>>    Recent Linux kernel and Windows driver seems not relying on it. This
>>>>    enables IGD passthrough on Q35 machines, but probably without UEFI
>>>>    GOP or VBIOS support, as it is observed they require specific LPC
>>>>    bridge DID to work.
>>>> * Remove the requirement of IGD device class being VGA controller, this
>>>>    was previous discussed in my kernel change [1]
>>>> * Update the document
>>>>
>>>> It would time consuming to implement all them, coding is not difficult,
>>>> but I have to verify my change on diffrent platforms. And they are out
>>>> of this patchset's scope I think. I personally perfers doing it in a
>>>> future patchset.
>>>>
>>>> [1] https://lore.kernel.org/all/20250123163416.7653-1-tomitamoeko@gmail.com/
>>>>
>>>> Thanks,
>>>> Moeko
>>>
>>> Please let me know if you have any thoughts or suggestions, in case
>>> you missed the previous mail.
>>
>> TBH, I'm surprised there's so much interest in direct assignment of
>> igd.  I'd be curious in your motivation, if you can share it.
>>
>> Regardless, it's nice to see it updated for newer hardware and I don't
>> mind the goal of isolating the code so it can be disabled on other
>> archs, so long as we can do so in small, logical steps that are easy to
>> follow.
>>
>> At this point, the idea of legacy vs UPT might only exist in QEMU.
>> There are going to be some challenges to avoid breaking existing VM
>> command lines if the host and LPC bridge quirks become optional.  There
>> are a couple x-igd- options that we're free to break as they've always
>> been experimental, but the implicit LPC bridge and host bridge quirks
>> need to be considered carefully.  The fact that "legacy" mode has never
>> previously worked on q35 could mean that we can tie those quirks to a
>> new experimental option that's off by default and only enabled for
>> 440fx machine types.
>>
>> I'm glad you included the documentation update in your list, it's
>> clearly out of date, as is some of my knowledge regarding guest driver
>> requirements.  
> 
> Could we please have an update of docs/igd-assign.txt too ?
> 
> As some point, we should consolidate all VFIO documentation under
> one section. That's another topic.
> 
>> I hope we can make some progress on uefi support as well,
>> as that's essentially a requirement for newer guests.  If we can't get
>> the code upstream into edk2, maybe we can at least document steps for
>> others to create images.  Thanks,
>>
> 
> So, I am bit lot here, forgive my ignorance.
> 
> I am seeing issues (a black screen and nothing else to report) with :
> 
>   00:02.0 VGA compatible controller: Intel Corporation AlderLake-S GT1 (rev 0c)
> 
> using uefi, seabios, pc or q35 does not change the result.
> 
> 
> However, it works fine with a uefi q35 machine using :
> 
>   00:02.0 VGA compatible controller: Intel Corporation Alder Lake-N [UHD Graphics]
> 
> How can I dig into the first issue ?
> 

If you are running a linux guest, `dmesg | grep i915` in guest is
always a good start. Adding `drm_debug` to kernel cmdline logs more
details. I mainly uses `drm_debug=0x6` for igd passthrough (Enable
Driver and KMS logging).

https://docs.kernel.org/gpu/drm-internals.html

> Also, if we know that there are platform requirements for IGD assignment to work, we
> should try to verify that they are met when the machine boots.

Well noted.
 
> Thanks,
> 
> C.
> 
> 


