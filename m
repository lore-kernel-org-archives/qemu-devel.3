Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1E2C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 07:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trXKg-0000YB-QR; Mon, 10 Mar 2025 03:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trXKf-0000Xt-EQ
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 03:13:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trXKc-0000an-QA
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 03:13:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741590822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oxqUIYMEjfki7U7OpiopxE8FGjfXASEON6EqhmFmD5s=;
 b=McQOcRdvre/CVXNxSO99+yK840TM3hJF9kP1Pb+6j/2zRAjmvle7edkWcLLfYO0N6j0/e5
 hWy5bcV3uMhjZnKv58+Vy5zWf3cMhCbD/Er93UYIkepv8dMVse/dspZq8DKvs/uFpo7LB7
 WtmLlA4ZR5TZxhQkm2yCJUPbDM56j+k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-rYbgSkBEOOKZ-HJzBaq77g-1; Mon, 10 Mar 2025 03:13:37 -0400
X-MC-Unique: rYbgSkBEOOKZ-HJzBaq77g-1
X-Mimecast-MFC-AGG-ID: rYbgSkBEOOKZ-HJzBaq77g_1741590817
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4394040fea1so18009625e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 00:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741590817; x=1742195617;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oxqUIYMEjfki7U7OpiopxE8FGjfXASEON6EqhmFmD5s=;
 b=q0jgDeU/pHqkwVKPfFELeQZyUXpKzSlenYaj87w29Q514sEcBpuEQvk05KbtQ7W5yx
 NnyX6M3QYNAD3563qKzOEwedl3QQp/kuDLZMiYjLXa+qS4F3qLitYMVnHgiTZXnJT5As
 OxiOtMm9/QI3mBE5hoGIqkibKsgbHRHeQZBmOh3etbqRELcv8DubdZUklxf3wYO9a0O6
 WdoKQm4SpjiQG4L4LEbfeBdiXU6fqrj36M3x812ODJnQl9bwvg9yGFsmygatzI1k64DQ
 lW/eik4lE1GXHLZiBFNd1p80pFrb22+xu3xycETeMj8SfY5YDDw3pS4o8he7Ik1QVhjJ
 GxqA==
X-Gm-Message-State: AOJu0YwiMT8vvC/ndRiVDsh/mxJksoEqILHJzwDzMKFEAWWMNW6Yo45b
 ioItO+x9BntZTNczoQANatUk1hRz+n2BUsdNLwVQ+ambhkHqmiajp4gR5WGF3fgjkiDJ61p0E95
 C6VGqc+CFhg4cNRhFpfdTXzZAupDWR/Tj/SKv4EHzP+3LUmi/HlAG
X-Gm-Gg: ASbGncvcCKRDnBHFXoUuivs8PWHYmAgEs51lAm7jVIbkn39WUADO8qoXGKl71eYTy4j
 zLdbQjm4yHmCkMWAAcyyzzRpsvB5WdkzC1+KLdsxqA/rzaYeIuUoejDvGoERqza2b5A2ZZuvx1D
 z92p/m8LTR7Z8MmRlL6+iXaqgn+m7YmKeEQfM3sKDOLfxUc0zKD9lE+zw2sZ2KH3tfDTJp7WPqG
 18RBbcA1YyUYG+UfIdoDAa5bwHIu6z0cZ3hIqxqVJDDcoCAv8DrKW5OqWw9Hz9XnKyivZDiBFLR
 HEWWV6vbDAYjXgMBl62Ia1gHwLaEU2wmgl886CUZhDWKrWoVdSQ1qg==
X-Received: by 2002:a05:600c:4fc4:b0:439:9737:675b with SMTP id
 5b1f17b1804b1-43ce4ad688cmr49293655e9.7.1741590816627; 
 Mon, 10 Mar 2025 00:13:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHloDx6OVMwYrMaOCLqXa1cGXMJrR+lsGIEVQsAQXBWi3cdGa8/KN416hGQRl9QBqBxyQTbKg==
X-Received: by 2002:a05:600c:4fc4:b0:439:9737:675b with SMTP id
 5b1f17b1804b1-43ce4ad688cmr49293565e9.7.1741590816217; 
 Mon, 10 Mar 2025 00:13:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c0e222dsm13989963f8f.72.2025.03.10.00.13.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 00:13:34 -0700 (PDT)
Message-ID: <f394edb5-f8f0-4b5f-ab5f-e40c1e8c9f78@redhat.com>
Date: Mon, 10 Mar 2025 08:13:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] vfio/igd: Decouple common quirks from legacy mode
To: Tomita Moeko <tomitamoeko@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Corvin_K=C3=B6hne?=
 <corvin.koehne@gmail.com>
References: <20250306180131.32970-1-tomitamoeko@gmail.com>
 <20250306180131.32970-8-tomitamoeko@gmail.com>
 <20250306154920.0e1936eb.alex.williamson@redhat.com>
 <46b7c8ff-06b3-4e01-a00d-1a388a0bf6a3@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <46b7c8ff-06b3-4e01-a00d-1a388a0bf6a3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Tomita,

On 3/7/25 19:37, Tomita Moeko wrote:
> On 2025/3/7 6:49, Alex Williamson wrote:
>> On Fri,  7 Mar 2025 02:01:27 +0800
>> Tomita Moeko <tomitamoeko@gmail.com> wrote:
>>
>>> So far, IGD-specific quirks all require enabling legacy mode, which is
>>> toggled by assigning IGD to 00:02.0. However, some quirks, like the BDSM
>>> and GGC register quirks, should be applied to all supported IGD devices.
>>> A new config option, x-igd-legacy-mode=[on|off|auto], is introduced to
>>> control the legacy mode only quirks. The default value is "auto", which
>>> keeps current behavior that enables legacy mode implicitly and continues
>>> on error when all following conditions are met.
>>> * Machine type is i440fx
>>> * IGD device is at guest BDF 00:02.0
>>>
>>> If any one of the conditions above is not met, the default behavior is
>>> equivalent to "off", QEMU will fail immediately if any error occurs.
>>>
>>> Users can also use "on" to force enabling legacy mode. It checks if all
>>> the conditions above are met and set up legacy mode. QEMU will also fail
>>> immediately on error in this case.
>>>
>>> Additionally, the hotplug check in legacy mode is removed as hotplugging
>>> IGD device is never supported, and it will be checked when enabling the
>>> OpRegion quirk.
>>>
>>> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
>>> ---
>>>   hw/vfio/igd.c | 127 +++++++++++++++++++++++++++++---------------------
>>>   hw/vfio/pci.c |   2 +
>>>   hw/vfio/pci.h |   1 +
>>>   3 files changed, 77 insertions(+), 53 deletions(-)
>>>
>>> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
>>> index f5e19f1241..ac096e2eb5 100644
>>> --- a/hw/vfio/igd.c
>>> +++ b/hw/vfio/igd.c
>>> @@ -15,6 +15,7 @@
>>>   #include "qemu/error-report.h"
>>>   #include "qapi/error.h"
>>>   #include "qapi/qmp/qerror.h"
>>> +#include "hw/boards.h"
>>>   #include "hw/hw.h"
>>>   #include "hw/nvram/fw_cfg.h"
>>>   #include "pci.h"
>>> @@ -432,9 +433,7 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>>>        * bus address.
>>>        */
>>>       if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
>>> -        !vfio_is_vga(vdev) || nr != 0 ||
>>> -        &vdev->pdev != pci_find_device(pci_device_root_bus(&vdev->pdev),
>>> -                                       0, PCI_DEVFN(0x2, 0))) {
>>> +        !vfio_is_vga(vdev) || nr != 0) {
>>>           return;
>>>       }
>>>   
>>> @@ -482,14 +481,13 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>>>       QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, bdsm_quirk, next);
>>>   }
>>>   
>>> -bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
>>> -                                 Error **errp G_GNUC_UNUSED)
>>> +bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>>>   {
>>> -    g_autofree struct vfio_region_info *rom = NULL;
>>>       int ret, gen;
>>>       uint64_t gms_size;
>>>       uint64_t *bdsm_size;
>>>       uint32_t gmch;
>>> +    bool legacy_mode_enabled = false;
>>>       Error *err = NULL;
>>>   
>>>       /*
>>> @@ -498,9 +496,7 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
>>>        * PCI bus address.
>>>        */
>>>       if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
>>> -        !vfio_is_vga(vdev) ||
>>> -        &vdev->pdev != pci_find_device(pci_device_root_bus(&vdev->pdev),
>>> -                                       0, PCI_DEVFN(0x2, 0))) {
>>> +        !vfio_is_vga(vdev)) {
>>>           return true;
>>>       }
>>>   
>>> @@ -516,56 +512,67 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
>>>           return true;
>>>       }
>>>   
>>> -    /*
>>> -     * Most of what we're doing here is to enable the ROM to run, so if
>>> -     * there's no ROM, there's no point in setting up this quirk.
>>> -     * NB. We only seem to get BIOS ROMs, so a UEFI VM would need CSM support.
>>> -     */
>>> -    ret = vfio_get_region_info(&vdev->vbasedev,
>>> -                               VFIO_PCI_ROM_REGION_INDEX, &rom);
>>> -    if ((ret || !rom->size) && !vdev->pdev.romfile) {
>>> -        error_report("IGD device %s has no ROM, legacy mode disabled",
>>> -                     vdev->vbasedev.name);
>>> -        return true;
>>> -    }
>>> -
>>> -    /*
>>> -     * Ignore the hotplug corner case, mark the ROM failed, we can't
>>> -     * create the devices we need for legacy mode in the hotplug scenario.
>>> -     */
>>> -    if (vdev->pdev.qdev.hotplugged) {
>>> -        error_report("IGD device %s hotplugged, ROM disabled, "
>>> -                     "legacy mode disabled", vdev->vbasedev.name);
>>> -        vdev->rom_read_failed = true;
>>> -        return true;
>>> -    }
>>> -
>>>       gmch = vfio_pci_read_config(&vdev->pdev, IGD_GMCH, 4);
>>>   
>>>       /*
>>> -     * If IGD VGA Disable is clear (expected) and VGA is not already enabled,
>>> -     * try to enable it.  Probably shouldn't be using legacy mode without VGA,
>>> -     * but also no point in us enabling VGA if disabled in hardware.
>>> +     * For backward compatibilty, enable legacy mode when
>>> +     * - Machine type is i440fx (pc_piix)
>>> +     * - IGD device is at guest BDF 00:02.0
>>> +     * - Not manually disabled by x-igd-legacy-mode=off
>>>        */
>>> -    if (!(gmch & 0x2) && !vdev->vga && !vfio_populate_vga(vdev, &err)) {
>>> -        error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>>> -        error_report("IGD device %s failed to enable VGA access, "
>>> -                     "legacy mode disabled", vdev->vbasedev.name);
>>> -        return true;
>>> -    }
>>> +    if ((vdev->igd_legacy_mode != ON_OFF_AUTO_OFF) &&
>>> +        !strcmp(MACHINE_GET_CLASS(qdev_get_machine())->family, "pc_piix") &&
>>> +        (&vdev->pdev == pci_find_device(pci_device_root_bus(&vdev->pdev),
>>> +        0, PCI_DEVFN(0x2, 0)))) {
>>> +        /*
>>> +         * IGD legacy mode requires:
>>> +         * - VBIOS in ROM BAR or file
>>> +         * - VGA IO/MMIO ranges are claimed by IGD
>>> +         * - OpRegion
>>> +         * - Same LPC bridge and Host bridge VID/DID/SVID/SSID as host
>>> +         */
>>> +        g_autofree struct vfio_region_info *rom = NULL;
>>> +
>>> +        legacy_mode_enabled = true;
>>> +        warn_report("IGD legacy mode enabled, "
>>> +                    "use x-igd-legacy-mode=off to disable it if unwanted.");
>>
>> info_report() maybe?  These aren't great choices for a user, get a
>> warning for using the intended mode or silence that warning by
>> requiring experimental options that taint the VM relative to libvirt.
> 
> Got it. If possible, please help change this to info_report when
> applying.

done.


> 
>> Also, why do we list all the requirements then only test a few of them
>> before declaring we're using legacy mode?  It seems like the above
>> should be moved to the end of this branch.
> 
> Having i440fx machine type and BDF 00:02.0 are the must-have condition
> for considering enabling legacy mode, while others are the requirements
> for legacy mode itself. In this verison, legacy mode is equivalent to
>      romfile=oprom.bin,x-vga=on,x-igd-opregion=on,x-igd-lpc=on
> 
> BDF being 00:02.0 is a requirement of VBIOS, and hacking the LPC DID
> currently only works on i440fx. Though for Q35, we can overwrite the
> existing ICH9 LPC DID to make IGD driver happy, it won't break ACPI PM
> in recent guest kernel, and maybe later making it an option for Q35,
> its still too risky to make it an implicit default. That's why I prefer
> to check the must-have condtions first, then check other requirements
> when setting up them.
> 
> Setting the `legacy_mode_enabled` flag here is for error handling, as
> we have to keep the old "continue on error" behavior for legacy mode.

A ducomentation update is welcome ! Could you do that before hard-freeze ?

Thanks,

C.






>> Given the pending release deadline, maybe these aren't blockers, but
>> let's follow-up with something that assumes the user wants something
>> other than what they're doing.  Thanks,
>>
>> Alex
>>
> 
> Sure.
> 
> Moeko
>   
>>> +
>>> +        /*
>>> +         * Most of what we're doing here is to enable the ROM to run, so if
>>> +         * there's no ROM, there's no point in setting up this quirk.
>>> +         * NB. We only seem to get BIOS ROMs, so UEFI VM would need CSM support.
>>> +         */
>>> +        ret = vfio_get_region_info(&vdev->vbasedev,
>>> +                                   VFIO_PCI_ROM_REGION_INDEX, &rom);
>>> +        if ((ret || !rom->size) && !vdev->pdev.romfile) {
>>> +            error_setg(&err, "Device has no ROM");
>>> +            goto error;
>>> +        }
>>>   
>>> -    /* Setup OpRegion access */
>>> -    if (!vfio_pci_igd_setup_opregion(vdev, &err)) {
>>> -        error_append_hint(&err, "IGD legacy mode disabled\n");
>>> -        error_report_err(err);
>>> -        return true;
>>> -    }
>>> +        /*
>>> +         * If IGD VGA Disable is clear (expected) and VGA is not already
>>> +         * enabled, try to enable it. Probably shouldn't be using legacy mode
>>> +         * without VGA, but also no point in us enabling VGA if disabled in
>>> +         * hardware.
>>> +         */
>>> +        if (!(gmch & 0x2) && !vdev->vga && !vfio_populate_vga(vdev, &err)) {
>>> +            error_setg(&err, "Unable to enable VGA access");
>>> +            goto error;
>>> +        }
>>>   
>>> -    /* Setup LPC bridge / Host bridge PCI IDs */
>>> -    if (!vfio_pci_igd_setup_lpc_bridge(vdev, &err)) {
>>> -        error_append_hint(&err, "IGD legacy mode disabled\n");
>>> -        error_report_err(err);
>>> -        return true;
>>> +        /* Setup OpRegion access */
>>> +        if (!vfio_pci_igd_setup_opregion(vdev, &err)) {
>>> +            goto error;
>>> +        }
>>> +
>>> +        /* Setup LPC bridge / Host bridge PCI IDs */
>>> +        if (!vfio_pci_igd_setup_lpc_bridge(vdev, &err)) {
>>> +            goto error;
>>> +        }
>>> +    } else if (vdev->igd_legacy_mode == ON_OFF_AUTO_ON) {
>>> +        error_setg(&err,
>>> +                   "Machine is not i440fx or assigned BDF is not 00:02.0");
>>> +        goto error;
>>>       }
>>>   
>>>       /*
>>> @@ -627,4 +634,18 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
>>>       trace_vfio_pci_igd_bdsm_enabled(vdev->vbasedev.name, (gms_size / MiB));
>>>   
>>>       return true;
>>> +
>>> +error:
>>> +    /*
>>> +     * When legacy mode is implicity enabled, continue on error,
>>> +     * to keep compatibility
>>> +     */
>>> +    if (legacy_mode_enabled && (vdev->igd_legacy_mode == ON_OFF_AUTO_AUTO)) {
>>> +        error_report_err(err);
>>> +        error_report("IGD legacy mode disabled");
>>> +        return true;
>>> +    }
>>> +
>>> +    error_propagate(errp, err);
>>> +    return false;
>>>   }
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index a58d555934..d5ff8c1ea8 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -3363,6 +3363,8 @@ static const Property vfio_pci_dev_properties[] = {
>>>                       VFIO_FEATURE_ENABLE_REQ_BIT, true),
>>>       DEFINE_PROP_BIT("x-igd-opregion", VFIOPCIDevice, features,
>>>                       VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
>>> +    DEFINE_PROP_ON_OFF_AUTO("x-igd-legacy-mode", VFIOPCIDevice,
>>> +                            igd_legacy_mode, ON_OFF_AUTO_AUTO),
>>>       DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
>>>                               vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
>>>       DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
>>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>>> index 2e81f9eb19..aa67ceb346 100644
>>> --- a/hw/vfio/pci.h
>>> +++ b/hw/vfio/pci.h
>>> @@ -158,6 +158,7 @@ struct VFIOPCIDevice {
>>>       uint32_t display_xres;
>>>       uint32_t display_yres;
>>>       int32_t bootindex;
>>> +    OnOffAuto igd_legacy_mode;
>>>       uint32_t igd_gms;
>>>       OffAutoPCIBAR msix_relo;
>>>       uint8_t pm_cap;
>>
> 


