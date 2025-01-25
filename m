Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70989C02182
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 07:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbaov-0008RT-FJ; Sat, 25 Jan 2025 02:43:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tbaot-0008RK-Ss
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 02:43:07 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1tbaor-0002R0-AS
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 02:43:07 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-2166f1e589cso73084655ad.3
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 23:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737790984; x=1738395784; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bam5ztrg2rI7D22Q3DRZwz0DnRVr7XXkMSpXKvFFM9c=;
 b=c1pyE+RrxVeemgAo+h3fVSYmBvR8an8vdPF7DtpR3U2wW0PfQvULMLY+If+TWfZ63H
 BHRorLkd8Az9s1hqo1Hr3EvlwykwcbY9j3FpQ2Ap4DX7Y6grN6DO7LvWdseEosKVBNC+
 SY/skGd7K0sZrF5p6fPoIM4erzb0qqM5Q2D6P7UNg4rdLKwF7N/6eesPDQR82rzIAgTX
 LUkbokEtqGZIJBqybHP+aMp6kCv46FZoCBmwAcywmp9+hMYACsjP6LvYdslCTQgU3UW/
 72mzTm1ig/lP+H5efjXACxq5C0v/aLZxxX41noPbOtcBD3R//u78gKRky0yYwFMozlwh
 nkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737790984; x=1738395784;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bam5ztrg2rI7D22Q3DRZwz0DnRVr7XXkMSpXKvFFM9c=;
 b=LncnIUyl8Qs2KzugEyCvhn4WUeHW7FUwX6gSYYb/Sps4jedFDofZTYFBpOs9tneZ0C
 uKiH0ZfKYvhGlcokLeIqm1WM6D8DMvWtDtOw0ZL6VYI9k6muVouQqRwGYsKvwOXahsh+
 qCglSq6MhN3F1qWUMwTIJb7FqYDJw9YoLyu/yUzYyN7rXvYmgTmHZZQtE8Nlh8zlIaFH
 SGQZwjit1baZY8lnPrf/khtuWZ3ltBJ3W5kSgMrWteW0m4Xyf9HB3g1LDTp+S/xHYuUg
 5JGMI68vkrbjgX2b9gLtpVgayjAzUdDn5q/aB84S9YrlC3osfdncDcsN5ayLulJuB9/8
 3wxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcCRwnzqldsRtZ/fmSmPJFv9zXKjwG1k+4vAUsD0dr6uGEvr71YJ5Y376HPWzmY4SmNMRqSrsEe0nv@nongnu.org
X-Gm-Message-State: AOJu0YwF0+NGoJ2xEV/Y8ICLq1x6BMsJg42JNHLa6lFqYLKHmz88RL7r
 vYFYJ9/0CDfCZImpRYGHj81uDVoeP01brZwJI2yNeXhChLo1v6w=
X-Gm-Gg: ASbGncveCwcpDqgq6MC2pPCLr6HOEVznzcTIhBY7Ch11ABIuX8lT8ZIitoUltn2nGz/
 Hac0w2MCHkd4iKeX/YmWdILZc7UHZtwMnZZVtKRqvBr5/U7sIWDk5nxipwao1EP5UsT39iV/P3y
 zMqaIzTjh2k97jU16i+xIC9MsXb8YT0tw3fteFv0NIlKFgTcf88Qe4Vo6YH38kg0A2apmRC19FN
 mMicWn3AShrBNSbAk3NnsAkNmAyETaDy5aiYPrRwlvsr7fYraVwOkK8XYrd/PuAgRO2GJk/FnKT
 T++bCgHcYg==
X-Google-Smtp-Source: AGHT+IHtyuPD8wiV29g3G9gjHfsa8ekS4jtctVmHwhLnlonZrnTpzTkxvoUaDDXMh/JDjbTbii6Www==
X-Received: by 2002:a17:902:ccc2:b0:216:3e86:1cb9 with SMTP id
 d9443c01a7336-21c357a608dmr476243295ad.50.1737790983502; 
 Fri, 24 Jan 2025 23:43:03 -0800 (PST)
Received: from [192.168.0.163] ([58.37.175.151])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea31cdsm27208495ad.67.2025.01.24.23.43.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 23:43:03 -0800 (PST)
Message-ID: <7cd85e39-88e6-497d-b0b0-41a0a0ece0fb@gmail.com>
Date: Sat, 25 Jan 2025 15:42:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] vfio/igd: handle x-igd-opregion in
 vfio_probe_igd_config_quirk()
To: Alex Williamson <alex.williamson@redhat.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
References: <20250124191245.12464-1-tomitamoeko@gmail.com>
 <20250124191245.12464-6-tomitamoeko@gmail.com>
 <20250124141342.255a79d3.alex.williamson@redhat.com>
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <20250124141342.255a79d3.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x641.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/25/25 05:13, Alex Williamson wrote:
> On Sat, 25 Jan 2025 03:12:45 +0800
> Tomita Moeko <tomitamoeko@gmail.com> wrote:
> 
>> Both enable opregion option (x-igd-opregion) and legacy mode require
>> setting up OpRegion copy for IGD devices. Move x-igd-opregion handler
>> in vfio_realize() to vfio_probe_igd_config_quirk() to elimate duplicate
>> code. Finally we moved all the IGD-related code into igd.c.
>>
>> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
>> ---
>>  hw/vfio/igd.c        | 143 +++++++++++++++++++++++++++++++++----------
>>  hw/vfio/pci-quirks.c |  50 ---------------
>>  hw/vfio/pci.c        |  25 --------
>>  hw/vfio/pci.h        |   4 --
>>  4 files changed, 110 insertions(+), 112 deletions(-)
>>
>> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
>> index 6e06dd774a..015beacf5f 100644
>> --- a/hw/vfio/igd.c
>> +++ b/hw/vfio/igd.c
>> @@ -106,6 +106,7 @@ static int igd_gen(VFIOPCIDevice *vdev)
>>      return -1;
>>  }
>>  
>> +#define IGD_ASLS 0xfc /* ASL Storage Register */
>>  #define IGD_GMCH 0x50 /* Graphics Control Register */
>>  #define IGD_BDSM 0x5c /* Base Data of Stolen Memory */
>>  #define IGD_BDSM_GEN11 0xc0 /* Base Data of Stolen Memory of gen 11 and later */
>> @@ -138,6 +139,55 @@ static uint64_t igd_stolen_memory_size(int gen, uint32_t gmch)
>>      return 0;
>>  }
>>  
>> +/*
>> + * The OpRegion includes the Video BIOS Table, which seems important for
>> + * telling the driver what sort of outputs it has.  Without this, the device
>> + * may work in the guest, but we may not get output.  This also requires BIOS
>> + * support to reserve and populate a section of guest memory sufficient for
>> + * the table and to write the base address of that memory to the ASLS register
>> + * of the IGD device.
>> + */
>> +static bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
>> +                                       struct vfio_region_info *info,
>> +                                       Error **errp)
>> +{
>> +    int ret;
>> +
>> +    vdev->igd_opregion = g_malloc0(info->size);
>> +    ret = pread(vdev->vbasedev.fd, vdev->igd_opregion,
>> +                info->size, info->offset);
>> +    if (ret != info->size) {
>> +        error_setg(errp, "failed to read IGD OpRegion");
>> +        g_free(vdev->igd_opregion);
>> +        vdev->igd_opregion = NULL;
>> +        return false;
>> +    }
>> +
>> +    /*
>> +     * Provide fw_cfg with a copy of the OpRegion which the VM firmware is to
>> +     * allocate 32bit reserved memory for, copy these contents into, and write
>> +     * the reserved memory base address to the device ASLS register at 0xFC.
>> +     * Alignment of this reserved region seems flexible, but using a 4k page
>> +     * alignment seems to work well.  This interface assumes a single IGD
>> +     * device, which may be at VM address 00:02.0 in legacy mode or another
>> +     * address in UPT mode.
>> +     *
>> +     * NB, there may be future use cases discovered where the VM should have
>> +     * direct interaction with the host OpRegion, in which case the write to
>> +     * the ASLS register would trigger MemoryRegion setup to enable that.
>> +     */
>> +    fw_cfg_add_file(fw_cfg_find(), "etc/igd-opregion",
>> +                    vdev->igd_opregion, info->size);
>> +
>> +    trace_vfio_pci_igd_opregion_enabled(vdev->vbasedev.name);
>> +
>> +    pci_set_long(vdev->pdev.config + IGD_ASLS, 0);
>> +    pci_set_long(vdev->pdev.wmask + IGD_ASLS, ~0);
>> +    pci_set_long(vdev->emulated_config_bits + IGD_ASLS, ~0);
>> +
>> +    return true;
>> +}
>> +
>>  /*
>>   * The rather short list of registers that we copy from the host devices.
>>   * The LPC/ISA bridge values are definitely needed to support the vBIOS, the
>> @@ -339,29 +389,83 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>>      QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, bdsm_quirk, next);
>>  }
>>  
>> +static bool vfio_igd_try_enable_opregion(VFIOPCIDevice *vdev, Error **errp)
>> +{
>> +    g_autofree struct vfio_region_info *opregion = NULL;
>> +    int ret;
>> +
>> +    /*
>> +     * Hotplugging is not supprted for both opregion access and legacy mode.
>> +     * For legacy mode, we also need to mark the ROM failed.
>> +     */
> 
> The explanation was a little better in the removed comment.
> 
>> +    if (vdev->pdev.qdev.hotplugged) {
>> +        vdev->rom_read_failed = true;
>> +        error_setg(errp,
>> +                   "IGD OpRegion is not supported on hotplugged device");
> 
> As was the error log.
> 
>> +        return false;
>> +    }
>> +
>> +    ret = vfio_get_dev_region_info(&vdev->vbasedev,
>> +                    VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
>> +                    VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, &opregion);
>> +    if (ret) {
>> +        error_setg_errno(errp, -ret,
>> +                         "device does not supports IGD OpRegion feature");
>> +        return false;
>> +    }
>> +
>> +    if (!vfio_pci_igd_opregion_init(vdev, opregion, errp)) {
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
>> +
>>  bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
>> -                                 Error **errp G_GNUC_UNUSED)
>> +                                 Error **errp)
>>  {
>>      g_autofree struct vfio_region_info *rom = NULL;
>> -    g_autofree struct vfio_region_info *opregion = NULL;
>>      g_autofree struct vfio_region_info *host = NULL;
>>      g_autofree struct vfio_region_info *lpc = NULL;
>> +    PCIBus *bus;
>>      PCIDevice *lpc_bridge;
>>      int ret, gen;
>> +    bool legacy_mode, enable_opregion;
>>      uint64_t gms_size;
>>      uint64_t *bdsm_size;
>>      uint32_t gmch;
>>      Error *err = NULL;
>>  
>> +    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
>> +        !vfio_is_vga(vdev)) {
>> +        return true;
>> +    }
>> +
>>      /*
>>       * This must be an Intel VGA device at address 00:02.0 for us to even
>>       * consider enabling legacy mode.  The vBIOS has dependencies on the
>>       * PCI bus address.
>>       */
>> -    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
>> -        !vfio_is_vga(vdev) ||
>> -        &vdev->pdev != pci_find_device(pci_device_root_bus(&vdev->pdev),
>> -                                       0, PCI_DEVFN(0x2, 0))) {
>> +    bus = pci_device_root_bus(&vdev->pdev);
>> +    legacy_mode = (&vdev->pdev == pci_find_device(bus, 0, PCI_DEVFN(0x2, 0)));
>> +    enable_opregion = (vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION);
>> +
>> +    if (!enable_opregion && !legacy_mode) {
>> +        return true;
>> +    }
>> +
>> +    if (!vfio_igd_try_enable_opregion(vdev, &err)) {
>> +        if (enable_opregion) {
>> +            error_propagate(errp, err);
>> +            return false;
>> +        } else if (legacy_mode) {
>> +            error_append_hint(&err, "IGD legacy mode disabled\n");
>> +            error_report_err(err);
>> +            return true;
>> +        }
>> +    }
>> +
>> +    if (!legacy_mode) {
>>          return true;
>>      }
>>  
>> @@ -404,30 +508,10 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
>>          return true;
>>      }
>>  
>> -    /*
>> -     * Ignore the hotplug corner case, mark the ROM failed, we can't
>> -     * create the devices we need for legacy mode in the hotplug scenario.
>> -     */
>> -    if (vdev->pdev.qdev.hotplugged) {
>> -        error_report("IGD device %s hotplugged, ROM disabled, "
>> -                     "legacy mode disabled", vdev->vbasedev.name);
>> -        vdev->rom_read_failed = true;
>> -        return true;
>> -    }
>> -
>>      /*
>>       * Check whether we have all the vfio device specific regions to
>>       * support legacy mode (added in Linux v4.6).  If not, bail.
>>       */
> > And we're disassociating opregion setup from this useful comment.
> 
> What are we actually accomplishing here?  What specific code
> duplication is eliminated?

This patch is designed for moving the opregion quirk in vfio_realize()
to igd.c, for better isolation of the igd-specific code. Legacy mode
also need to initialize opregion as x-igd-opregion=on option. These
code are almost the same, except legacy mode continues on error, while
x-igd-opregion fails.

I am going to clearify that in the commit message of v3.

> Why is it important to move all this code to igd.c?
> 
> It's really difficult to untangle this refactor, I think it could be
> done more iteratively, if it's really even beneficial.  Thanks,
> 
> Alex

Agreed. Actually I'd like to totally remove the "legacy mode" and "UPT
mode" concept in future, my proposal is:
* Emulate and initialize ASLS and BDSM register unconditionally. These
  registers holds HPA, keeping the old value to guest is not a good
  idea
* Make the host bridge and LPC bridge ID quirks optional like OpRegion.
  Recent Linux kernel and Windows driver seems not relying on it. This
  enables IGD passthrough on Q35 machines, but probably without UEFI
  GOP or VBIOS support, as it is observed they require specific LPC
  bridge DID to work.
* Remove the requirement of IGD device class being VGA controller, this
  was previous discussed in my kernel change [1]
* Update the document

It would time consuming to implement all them, coding is not difficult,
but I have to verify my change on diffrent platforms. And they are out
of this patchset's scope I think. I personally perfers doing it in a
future patchset.

[1] https://lore.kernel.org/all/20250123163416.7653-1-tomitamoeko@gmail.com/

Thanks,
Moeko

>> -    ret = vfio_get_dev_region_info(&vdev->vbasedev,
>> -                        VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
>> -                        VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, &opregion);
>> -    if (ret) {
>> -        error_report("IGD device %s does not support OpRegion access,"
>> -                     "legacy mode disabled", vdev->vbasedev.name);
>> -        return true;
>> -    }
>> -
>>      ret = vfio_get_dev_region_info(&vdev->vbasedev,
>>                          VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
>>                          VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG, &host);
>> @@ -476,13 +560,6 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
>>          return true;
>>      }
>>  
>> -    /* Setup OpRegion access */
>> -    if (!vfio_pci_igd_opregion_init(vdev, opregion, &err)) {
>> -        error_append_hint(&err, "IGD legacy mode disabled\n");
>> -        error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
>> -        return true;
>> -    }
>> -
>>      /*
>>       * Allow user to override dsm size using x-igd-gms option, in multiples of
>>       * 32MiB. This option should only be used when the desired size cannot be
>> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
>> index b8379cb512..f2b37910f0 100644
>> --- a/hw/vfio/pci-quirks.c
>> +++ b/hw/vfio/pci-quirks.c
>> @@ -1114,56 +1114,6 @@ static void vfio_probe_rtl8168_bar2_quirk(VFIOPCIDevice *vdev, int nr)
>>      trace_vfio_quirk_rtl8168_probe(vdev->vbasedev.name);
>>  }
>>  
>> -#define IGD_ASLS 0xfc /* ASL Storage Register */
>> -
>> -/*
>> - * The OpRegion includes the Video BIOS Table, which seems important for
>> - * telling the driver what sort of outputs it has.  Without this, the device
>> - * may work in the guest, but we may not get output.  This also requires BIOS
>> - * support to reserve and populate a section of guest memory sufficient for
>> - * the table and to write the base address of that memory to the ASLS register
>> - * of the IGD device.
>> - */
>> -bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
>> -                                struct vfio_region_info *info, Error **errp)
>> -{
>> -    int ret;
>> -
>> -    vdev->igd_opregion = g_malloc0(info->size);
>> -    ret = pread(vdev->vbasedev.fd, vdev->igd_opregion,
>> -                info->size, info->offset);
>> -    if (ret != info->size) {
>> -        error_setg(errp, "failed to read IGD OpRegion");
>> -        g_free(vdev->igd_opregion);
>> -        vdev->igd_opregion = NULL;
>> -        return false;
>> -    }
>> -
>> -    /*
>> -     * Provide fw_cfg with a copy of the OpRegion which the VM firmware is to
>> -     * allocate 32bit reserved memory for, copy these contents into, and write
>> -     * the reserved memory base address to the device ASLS register at 0xFC.
>> -     * Alignment of this reserved region seems flexible, but using a 4k page
>> -     * alignment seems to work well.  This interface assumes a single IGD
>> -     * device, which may be at VM address 00:02.0 in legacy mode or another
>> -     * address in UPT mode.
>> -     *
>> -     * NB, there may be future use cases discovered where the VM should have
>> -     * direct interaction with the host OpRegion, in which case the write to
>> -     * the ASLS register would trigger MemoryRegion setup to enable that.
>> -     */
>> -    fw_cfg_add_file(fw_cfg_find(), "etc/igd-opregion",
>> -                    vdev->igd_opregion, info->size);
>> -
>> -    trace_vfio_pci_igd_opregion_enabled(vdev->vbasedev.name);
>> -
>> -    pci_set_long(vdev->pdev.config + IGD_ASLS, 0);
>> -    pci_set_long(vdev->pdev.wmask + IGD_ASLS, ~0);
>> -    pci_set_long(vdev->emulated_config_bits + IGD_ASLS, ~0);
>> -
>> -    return true;
>> -}
>> -
>>  /*
>>   * Common quirk probe entry points.
>>   */
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index e624ae56c4..1b90c78c5a 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3136,31 +3136,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>          vfio_bar_quirk_setup(vdev, i);
>>      }
>>  
>> -    if (!vdev->igd_opregion &&
>> -        vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION) {
>> -        g_autofree struct vfio_region_info *opregion = NULL;
>> -
>> -        if (vdev->pdev.qdev.hotplugged) {
>> -            error_setg(errp,
>> -                       "cannot support IGD OpRegion feature on hotplugged "
>> -                       "device");
>> -            goto out_unset_idev;
>> -        }
>> -
>> -        ret = vfio_get_dev_region_info(vbasedev,
>> -                        VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
>> -                        VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, &opregion);
>> -        if (ret) {
>> -            error_setg_errno(errp, -ret,
>> -                             "does not support requested IGD OpRegion feature");
>> -            goto out_unset_idev;
>> -        }
>> -
>> -        if (!vfio_pci_igd_opregion_init(vdev, opregion, errp)) {
>> -            goto out_unset_idev;
>> -        }
>> -    }
>> -
>>      /* QEMU emulates all of MSI & MSIX */
>>      if (pdev->cap_present & QEMU_PCI_CAP_MSIX) {
>>          memset(vdev->emulated_config_bits + pdev->msix_cap, 0xff,
>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>> index 5c64de0270..b9e920a6b4 100644
>> --- a/hw/vfio/pci.h
>> +++ b/hw/vfio/pci.h
>> @@ -229,10 +229,6 @@ int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
>>  
>>  bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp);
>>  
>> -bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
>> -                                struct vfio_region_info *info,
>> -                                Error **errp);
>> -
>>  void vfio_display_reset(VFIOPCIDevice *vdev);
>>  bool vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
>>  void vfio_display_finalize(VFIOPCIDevice *vdev);
> 


