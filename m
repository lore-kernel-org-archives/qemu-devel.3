Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C900EC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 20:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdbLp-0004PS-6W; Thu, 30 Jan 2025 15:41:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tdbLn-0004PF-Dt
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 15:41:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tdbLl-0007I3-3z
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 15:41:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738269679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2saI/Cowd2D4IGnvTMHMg06wW/kJnwf/cDxD7d2Uzts=;
 b=CYJc1RnpSgf/I2vJSuBXsCuCg6z0/W3qpmdZTDKSb8tCx7agrGwzrvdGBE4MDc5dafgFTQ
 12ix9Z8MOZPCRGUZPM5fYtg79QGQbHndTmU2qXnbasPGyw5cKM01nVF9cDt57Guk1vBqMc
 4kvI1M8QKme5t7RfzfFbLZaTv/p+pVc=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-bFBod0OXOAuMGMPhoFhhYQ-1; Thu, 30 Jan 2025 15:41:17 -0500
X-MC-Unique: bFBod0OXOAuMGMPhoFhhYQ-1
X-Mimecast-MFC-AGG-ID: bFBod0OXOAuMGMPhoFhhYQ
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-84f1e734545so11539839f.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 12:41:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738269677; x=1738874477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2saI/Cowd2D4IGnvTMHMg06wW/kJnwf/cDxD7d2Uzts=;
 b=K8o/5pWWq+zGBoYwm6+nQaiWV6ykNgXXG8jYIDNycMkeGfeGaXLFVv6HC53N6C55MG
 amNxXFENsbSMSqVyONsPclnGzqYT03hA7QpbKn0OCCsr3sGk8b+hLGJ/Tvk+bZu7FHW9
 6guHHosQUFDwg13q+g0I4rIjZH0ouxUxV5+jBqjBuB/dcBCTVWpQ6IyPYSQ0tR2Tyorv
 6/jEC9SIDnn8XXH9YXjGbsqJ6E0U+4sQDqS6dqq9TJTEK8jWGp/FB887hjXNLGiYzDj4
 GOJjjK4QTkEC0uY2OH7MhnS4XF7DXR1NTK+VJAzLvTnmt0HLpFqeIzfFXfgslwgDpO5+
 aqtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmb7FLX91XQRM1Xs3Mdv2cBjO3v+r4RzqBDm8maz9vBflkvzrJo1Rzqb5KfiaBsKOv1WlcISp2cQJY@nongnu.org
X-Gm-Message-State: AOJu0YxmFiNYLq+LmNauEjzktHszbqPitjgER88paL4n/u36renevuHE
 iWz9Ed6NTbLgXPOcAU2FYeDbjju7iJPya5MmJFL3WHiDfqUZCnOHZyYSJbTWJEJvoRMC5GZlOZm
 /Ey5bMqzhXkgKRDs8OfQl7dVg2kykL54j0uWvVBx9Ig3EkGRxXmWY
X-Gm-Gg: ASbGncuPDUmLKCTWoVqJrYoxTvpNMNvzB8qKrv8OfJOcRw6cbTodFZ6cpdacowcVZL9
 8+MYNbs04fg9foEyTilPL98HPJqAQaju5WK4+oi0exWH9F6JRGCF5jq5QNkZDovGrJ4kEsakEJA
 d4KpBSwM4eOdAUXi56psYZlPQdO4JIA09DjoSo3Rl0IgOdTDjpsWzNO58JxJGeNcTgf8ktxCrsM
 cwV57NsN+e4L9ZOpfko2v5FM9wVWybFOdzK0S3JGpmGhPhW7NU2hTJwliky89MF2LOWsTNF36gM
 k0d8Ex1w
X-Received: by 2002:a05:6602:610b:b0:84a:51e2:6642 with SMTP id
 ca18e2360f4ac-85411111856mr267185339f.2.1738269677004; 
 Thu, 30 Jan 2025 12:41:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG22DBcJ1q5aR8ujC0XwvnSEHLpw5PlJqbzGB9MNjzVV8J9q+2PG3oDw/KSpTATH9qMbpflHw==
X-Received: by 2002:a05:6602:610b:b0:84a:51e2:6642 with SMTP id
 ca18e2360f4ac-85411111856mr267184639f.2.1738269676548; 
 Thu, 30 Jan 2025 12:41:16 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-854a18434ddsm52223839f.47.2025.01.30.12.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 12:41:16 -0800 (PST)
Date: Thu, 30 Jan 2025 13:41:13 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 5/5] vfio/igd: handle x-igd-opregion in
 vfio_probe_igd_config_quirk()
Message-ID: <20250130134113.5d60442f.alex.williamson@redhat.com>
In-Reply-To: <377fd72e-6bff-45f4-a9db-413f3565fd75@gmail.com>
References: <20250124191245.12464-1-tomitamoeko@gmail.com>
 <20250124191245.12464-6-tomitamoeko@gmail.com>
 <20250124141342.255a79d3.alex.williamson@redhat.com>
 <7cd85e39-88e6-497d-b0b0-41a0a0ece0fb@gmail.com>
 <377fd72e-6bff-45f4-a9db-413f3565fd75@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
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

On Fri, 31 Jan 2025 02:33:03 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> On 1/25/25 15:42, Tomita Moeko wrote:
> > On 1/25/25 05:13, Alex Williamson wrote:  
> >> On Sat, 25 Jan 2025 03:12:45 +0800
> >> Tomita Moeko <tomitamoeko@gmail.com> wrote:
> >>  
> >>> Both enable opregion option (x-igd-opregion) and legacy mode require
> >>> setting up OpRegion copy for IGD devices. Move x-igd-opregion handler
> >>> in vfio_realize() to vfio_probe_igd_config_quirk() to elimate duplicate
> >>> code. Finally we moved all the IGD-related code into igd.c.
> >>>
> >>> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> >>> ---
> >>>  hw/vfio/igd.c        | 143 +++++++++++++++++++++++++++++++++----------
> >>>  hw/vfio/pci-quirks.c |  50 ---------------
> >>>  hw/vfio/pci.c        |  25 --------
> >>>  hw/vfio/pci.h        |   4 --
> >>>  4 files changed, 110 insertions(+), 112 deletions(-)
> >>>
> >>> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> >>> index 6e06dd774a..015beacf5f 100644
> >>> --- a/hw/vfio/igd.c
> >>> +++ b/hw/vfio/igd.c
> >>> @@ -106,6 +106,7 @@ static int igd_gen(VFIOPCIDevice *vdev)
> >>>      return -1;
> >>>  }
> >>>  
> >>> +#define IGD_ASLS 0xfc /* ASL Storage Register */
> >>>  #define IGD_GMCH 0x50 /* Graphics Control Register */
> >>>  #define IGD_BDSM 0x5c /* Base Data of Stolen Memory */
> >>>  #define IGD_BDSM_GEN11 0xc0 /* Base Data of Stolen Memory of gen 11 and later */
> >>> @@ -138,6 +139,55 @@ static uint64_t igd_stolen_memory_size(int gen, uint32_t gmch)
> >>>      return 0;
> >>>  }
> >>>  
> >>> +/*
> >>> + * The OpRegion includes the Video BIOS Table, which seems important for
> >>> + * telling the driver what sort of outputs it has.  Without this, the device
> >>> + * may work in the guest, but we may not get output.  This also requires BIOS
> >>> + * support to reserve and populate a section of guest memory sufficient for
> >>> + * the table and to write the base address of that memory to the ASLS register
> >>> + * of the IGD device.
> >>> + */
> >>> +static bool vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
> >>> +                                       struct vfio_region_info *info,
> >>> +                                       Error **errp)
> >>> +{
> >>> +    int ret;
> >>> +
> >>> +    vdev->igd_opregion = g_malloc0(info->size);
> >>> +    ret = pread(vdev->vbasedev.fd, vdev->igd_opregion,
> >>> +                info->size, info->offset);
> >>> +    if (ret != info->size) {
> >>> +        error_setg(errp, "failed to read IGD OpRegion");
> >>> +        g_free(vdev->igd_opregion);
> >>> +        vdev->igd_opregion = NULL;
> >>> +        return false;
> >>> +    }
> >>> +
> >>> +    /*
> >>> +     * Provide fw_cfg with a copy of the OpRegion which the VM firmware is to
> >>> +     * allocate 32bit reserved memory for, copy these contents into, and write
> >>> +     * the reserved memory base address to the device ASLS register at 0xFC.
> >>> +     * Alignment of this reserved region seems flexible, but using a 4k page
> >>> +     * alignment seems to work well.  This interface assumes a single IGD
> >>> +     * device, which may be at VM address 00:02.0 in legacy mode or another
> >>> +     * address in UPT mode.
> >>> +     *
> >>> +     * NB, there may be future use cases discovered where the VM should have
> >>> +     * direct interaction with the host OpRegion, in which case the write to
> >>> +     * the ASLS register would trigger MemoryRegion setup to enable that.
> >>> +     */
> >>> +    fw_cfg_add_file(fw_cfg_find(), "etc/igd-opregion",
> >>> +                    vdev->igd_opregion, info->size);
> >>> +
> >>> +    trace_vfio_pci_igd_opregion_enabled(vdev->vbasedev.name);
> >>> +
> >>> +    pci_set_long(vdev->pdev.config + IGD_ASLS, 0);
> >>> +    pci_set_long(vdev->pdev.wmask + IGD_ASLS, ~0);
> >>> +    pci_set_long(vdev->emulated_config_bits + IGD_ASLS, ~0);
> >>> +
> >>> +    return true;
> >>> +}
> >>> +
> >>>  /*
> >>>   * The rather short list of registers that we copy from the host devices.
> >>>   * The LPC/ISA bridge values are definitely needed to support the vBIOS, the
> >>> @@ -339,29 +389,83 @@ void vfio_probe_igd_bar0_quirk(VFIOPCIDevice *vdev, int nr)
> >>>      QLIST_INSERT_HEAD(&vdev->bars[nr].quirks, bdsm_quirk, next);
> >>>  }
> >>>  
> >>> +static bool vfio_igd_try_enable_opregion(VFIOPCIDevice *vdev, Error **errp)
> >>> +{
> >>> +    g_autofree struct vfio_region_info *opregion = NULL;
> >>> +    int ret;
> >>> +
> >>> +    /*
> >>> +     * Hotplugging is not supprted for both opregion access and legacy mode.
> >>> +     * For legacy mode, we also need to mark the ROM failed.
> >>> +     */  
> >>
> >> The explanation was a little better in the removed comment.
> >>  
> >>> +    if (vdev->pdev.qdev.hotplugged) {
> >>> +        vdev->rom_read_failed = true;
> >>> +        error_setg(errp,
> >>> +                   "IGD OpRegion is not supported on hotplugged device");  
> >>
> >> As was the error log.
> >>  
> >>> +        return false;
> >>> +    }
> >>> +
> >>> +    ret = vfio_get_dev_region_info(&vdev->vbasedev,
> >>> +                    VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
> >>> +                    VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION, &opregion);
> >>> +    if (ret) {
> >>> +        error_setg_errno(errp, -ret,
> >>> +                         "device does not supports IGD OpRegion feature");
> >>> +        return false;
> >>> +    }
> >>> +
> >>> +    if (!vfio_pci_igd_opregion_init(vdev, opregion, errp)) {
> >>> +        return false;
> >>> +    }
> >>> +
> >>> +    return true;
> >>> +}
> >>> +
> >>>  bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
> >>> -                                 Error **errp G_GNUC_UNUSED)
> >>> +                                 Error **errp)
> >>>  {
> >>>      g_autofree struct vfio_region_info *rom = NULL;
> >>> -    g_autofree struct vfio_region_info *opregion = NULL;
> >>>      g_autofree struct vfio_region_info *host = NULL;
> >>>      g_autofree struct vfio_region_info *lpc = NULL;
> >>> +    PCIBus *bus;
> >>>      PCIDevice *lpc_bridge;
> >>>      int ret, gen;
> >>> +    bool legacy_mode, enable_opregion;
> >>>      uint64_t gms_size;
> >>>      uint64_t *bdsm_size;
> >>>      uint32_t gmch;
> >>>      Error *err = NULL;
> >>>  
> >>> +    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
> >>> +        !vfio_is_vga(vdev)) {
> >>> +        return true;
> >>> +    }
> >>> +
> >>>      /*
> >>>       * This must be an Intel VGA device at address 00:02.0 for us to even
> >>>       * consider enabling legacy mode.  The vBIOS has dependencies on the
> >>>       * PCI bus address.
> >>>       */
> >>> -    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_INTEL, PCI_ANY_ID) ||
> >>> -        !vfio_is_vga(vdev) ||
> >>> -        &vdev->pdev != pci_find_device(pci_device_root_bus(&vdev->pdev),
> >>> -                                       0, PCI_DEVFN(0x2, 0))) {
> >>> +    bus = pci_device_root_bus(&vdev->pdev);
> >>> +    legacy_mode = (&vdev->pdev == pci_find_device(bus, 0, PCI_DEVFN(0x2, 0)));
> >>> +    enable_opregion = (vdev->features & VFIO_FEATURE_ENABLE_IGD_OPREGION);
> >>> +
> >>> +    if (!enable_opregion && !legacy_mode) {
> >>> +        return true;
> >>> +    }
> >>> +
> >>> +    if (!vfio_igd_try_enable_opregion(vdev, &err)) {
> >>> +        if (enable_opregion) {
> >>> +            error_propagate(errp, err);
> >>> +            return false;
> >>> +        } else if (legacy_mode) {
> >>> +            error_append_hint(&err, "IGD legacy mode disabled\n");
> >>> +            error_report_err(err);
> >>> +            return true;
> >>> +        }
> >>> +    }
> >>> +
> >>> +    if (!legacy_mode) {
> >>>          return true;
> >>>      }
> >>>  
> >>> @@ -404,30 +508,10 @@ bool vfio_probe_igd_config_quirk(VFIOPCIDevice *vdev,
> >>>          return true;
> >>>      }
> >>>  
> >>> -    /*
> >>> -     * Ignore the hotplug corner case, mark the ROM failed, we can't
> >>> -     * create the devices we need for legacy mode in the hotplug scenario.
> >>> -     */
> >>> -    if (vdev->pdev.qdev.hotplugged) {
> >>> -        error_report("IGD device %s hotplugged, ROM disabled, "
> >>> -                     "legacy mode disabled", vdev->vbasedev.name);
> >>> -        vdev->rom_read_failed = true;
> >>> -        return true;
> >>> -    }
> >>> -
> >>>      /*
> >>>       * Check whether we have all the vfio device specific regions to
> >>>       * support legacy mode (added in Linux v4.6).  If not, bail.
> >>>       */
> >>> And we're disassociating opregion setup from this useful comment.  
> >>
> >> What are we actually accomplishing here?  What specific code
> >> duplication is eliminated?  
> > 
> > This patch is designed for moving the opregion quirk in vfio_realize()
> > to igd.c, for better isolation of the igd-specific code. Legacy mode
> > also need to initialize opregion as x-igd-opregion=on option. These
> > code are almost the same, except legacy mode continues on error, while
> > x-igd-opregion fails.
> > 
> > I am going to clearify that in the commit message of v3.
> >   
> >> Why is it important to move all this code to igd.c?  
> 
> x-igd-opreqion quirk is currently located in pci-quirks.c, which is not
> controlled by CONFIG_VFIO_IGD, moving it to igd.c prevents building
> that unnecessary code in certain binaries, for example, non x86 builds. 
> 
> >> It's really difficult to untangle this refactor, I think it could be
> >> done more iteratively, if it's really even beneficial.  Thanks,
> >>
> >> Alex  
> > 
> > Agreed. Actually I'd like to totally remove the "legacy mode" and "UPT
> > mode" concept in future, my proposal is:
> > * Emulate and initialize ASLS and BDSM register unconditionally. These
> >   registers holds HPA, keeping the old value to guest is not a good
> >   idea
> > * Make the host bridge and LPC bridge ID quirks optional like OpRegion.
> >   Recent Linux kernel and Windows driver seems not relying on it. This
> >   enables IGD passthrough on Q35 machines, but probably without UEFI
> >   GOP or VBIOS support, as it is observed they require specific LPC
> >   bridge DID to work.
> > * Remove the requirement of IGD device class being VGA controller, this
> >   was previous discussed in my kernel change [1]
> > * Update the document
> > 
> > It would time consuming to implement all them, coding is not difficult,
> > but I have to verify my change on diffrent platforms. And they are out
> > of this patchset's scope I think. I personally perfers doing it in a
> > future patchset.
> > 
> > [1] https://lore.kernel.org/all/20250123163416.7653-1-tomitamoeko@gmail.com/
> > 
> > Thanks,
> > Moeko  
> 
> Please let me know if you have any thoughts or suggestions, in case
> you missed the previous mail.

TBH, I'm surprised there's so much interest in direct assignment of
igd.  I'd be curious in your motivation, if you can share it.

Regardless, it's nice to see it updated for newer hardware and I don't
mind the goal of isolating the code so it can be disabled on other
archs, so long as we can do so in small, logical steps that are easy to
follow.

At this point, the idea of legacy vs UPT might only exist in QEMU.
There are going to be some challenges to avoid breaking existing VM
command lines if the host and LPC bridge quirks become optional.  There
are a couple x-igd- options that we're free to break as they've always
been experimental, but the implicit LPC bridge and host bridge quirks
need to be considered carefully.  The fact that "legacy" mode has never
previously worked on q35 could mean that we can tie those quirks to a
new experimental option that's off by default and only enabled for
440fx machine types.

I'm glad you included the documentation update in your list, it's
clearly out of date, as is some of my knowledge regarding guest driver
requirements.  I hope we can make some progress on uefi support as well,
as that's essentially a requirement for newer guests.  If we can't get
the code upstream into edk2, maybe we can at least document steps for
others to create images.  Thanks,

Alex


