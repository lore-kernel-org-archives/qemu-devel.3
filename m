Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFACC02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 13:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiw9l-0003LT-5p; Fri, 14 Feb 2025 08:55:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tiw9j-0003Ku-FW
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 08:54:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tiw9h-00012A-1H
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 08:54:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739541296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vtgDKqTnj7TgUm84IS3tGhkFmZnLj+Dnv7+qZ2lALQI=;
 b=GR5+v18TCqtChHsOKGWIJPAHcvzZqgWuNcFs/vpXT8Na21WyrU1np79SvWyWzxULdU7jan
 b03GHi7mdtsifUPqg6RkxpsCtbw82BtfbZYHRqQvjwlpP6DC5AQZv+hW7n6FTBD3RpUiki
 1MzDIzrVwu/F3QMRL2f5ZhQE0TDRqhA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-IYfdGk6RNNiOBwyzdFhPWw-1; Fri, 14 Feb 2025 08:54:55 -0500
X-MC-Unique: IYfdGk6RNNiOBwyzdFhPWw-1
X-Mimecast-MFC-AGG-ID: IYfdGk6RNNiOBwyzdFhPWw_1739541294
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38de0201961so2167515f8f.2
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 05:54:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739541294; x=1740146094;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vtgDKqTnj7TgUm84IS3tGhkFmZnLj+Dnv7+qZ2lALQI=;
 b=Y4JX+QAnRqmZp0TqR8YOiJTVfBfAWYtG09AA23skYT7aLOQqfyPN6fIewl3cyQAOo7
 wqWAE+poMJKf6FhH1PmTXjC+As1ySAvtBbCKwNqWUJrxgFcowM7Zck2GpkZbWt6ol2bM
 CoEtD4wexaH1a4T4kjlcArjJVZLE1N2Y+XCkwRLkpNbv1x8z5u+j3UXdyles8WL0NTiO
 8pWJd5Y6OcU8YqbN/oNT0NpLPAx79cwxLYf+XltiZX2slF048Kgrvk0B4P+qDZgO97hd
 0jhga5jxrSXfBACaiAXn9u5D0TQYda7LUlq4dNjlSbknvmtRs/ZUi6MCYMukRazYJ7i8
 4gbw==
X-Gm-Message-State: AOJu0YwXbw0gmxAOMiJ18ct/Q5981zNW3dYUEYS5ts8/x8xqnnwghOiw
 iGMXQxi/+RR+bnQAxLwEVfVAsKHJ9XTVziGqABq2Uy87d+6SUfDqZ8aiGGQlOIK1/BkDpEPov4H
 XLFENGW/fti4kvHVbbRrbegeco/6XhGcTAjzSdaLbPPCtI0I3rXN1
X-Gm-Gg: ASbGncteTIuM38Qd3LBVwyoNZPvM3IqifjEr+DIVEZlOeN+6Yip/SGCg3VCXH93iY/1
 5XyOFysqkxpstLPfG4vmoyKNbLMn9LS4MhUgflfp2idyjGL9Xmcpvr06GBRxNaSVQ3rbt3CYpn9
 aQdXfP8SyyAz2F6A8Q0ON2Ra5Lb2t1JKwHEJn6TZVA1cEMh8FGrRQ/+dJcL0wFoJ5HOpIi6P011
 Z2SiaJHZ3HRn3PmWWaeAW3ATVxD8d1XTwG2inH//vyqLq0LNr//0MEAtdSOoOwisACxLs7snq+S
 mG/JFidYEpZwW4+kLKW/foKZkwW0YCiq3UVgY/5kBV4=
X-Received: by 2002:a05:6000:1845:b0:38f:32ac:7e5a with SMTP id
 ffacd0b85a97d-38f32ac8248mr206844f8f.54.1739541293284; 
 Fri, 14 Feb 2025 05:54:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNVwfz+UKi45Hr1IM2nfOQmONn9guzrnDCCtbPZt2199U88hAke1pv+Pj8BEOyDo2I3bd4gw==
X-Received: by 2002:a05:6000:1845:b0:38f:32ac:7e5a with SMTP id
 ffacd0b85a97d-38f32ac8248mr206801f8f.54.1739541292830; 
 Fri, 14 Feb 2025 05:54:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b44a7sm4796135f8f.12.2025.02.14.05.54.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Feb 2025 05:54:52 -0800 (PST)
Message-ID: <c351713e-6e4e-4da4-8c0b-3486b668cd0c@redhat.com>
Date: Fri, 14 Feb 2025 14:54:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio: Add property documentation
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Tony Krowiak <akrowiak@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>,
 tomitamoeko@gmail.com, corvin.koehne@gmail.com
References: <20250213135050.1426258-1-clg@redhat.com>
 <20250213144513.32b3241f.alex.williamson@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250213144513.32b3241f.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 2/13/25 22:45, Alex Williamson wrote:
> On Thu, 13 Feb 2025 14:50:50 +0100
> Cédric Le Goater <clg@redhat.com> wrote:
> 
>> Investigate the git history to uncover when and why the VFIO
>> properties were introduced and update the models. This is mostly
>> targeting vfio-pci device, since vfio-plateform, vfio-ap and vfio-ccw
>> devices are simpler.
>>
>> Organize the vfio-pci properties in topics. It would be great to have
>> a way to do the same for the output.
>>
>> Cc: Tony Krowiak <akrowiak@linux.ibm.com>
>> Cc: Eric Farman <farman@linux.ibm.com>
>> Cc: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>
>>   Changes in v2:
>>
>>   - Fixed version numbers
>>   - Fixed #ifdef in vfio/ccw.c
>>   - Addressed vfio-pci-nohotplug
>>   - Organize the vfio-pci properties in topics
>>
>>   hw/vfio/ap.c       |   9 +++
>>   hw/vfio/ccw.c      |  15 +++++
>>   hw/vfio/pci.c      | 134 +++++++++++++++++++++++++++++++++++++++++++++
>>   hw/vfio/platform.c |  23 ++++++++
>>   4 files changed, 181 insertions(+)
>>
>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>> index 30b08ad375d5ecae886c5000fbaa364799fe76d0..ec1150e5d627fce83a5a6319af471fd0aa45ae9b 100644
>> --- a/hw/vfio/ap.c
>> +++ b/hw/vfio/ap.c
>> @@ -257,6 +257,15 @@ static void vfio_ap_class_init(ObjectClass *klass, void *data)
>>       dc->hotpluggable = true;
>>       device_class_set_legacy_reset(dc, vfio_ap_reset);
>>       dc->bus_type = TYPE_AP_BUS;
>> +
>> +    object_class_property_set_description(klass, /* 3.1 */
>> +                                          "sysfsdev",
>> +                                          "Host sysfs path of assigned device");
>> +#ifdef CONFIG_IOMMUFD
>> +    object_class_property_set_description(klass, /* 9.0 */
>> +                                          "iommufd",
>> +                                          "Set host IOMMUFD backend device ");
>> +#endif
>>   }
>>   
>>   static const TypeInfo vfio_ap_info = {
>> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
>> index 67bc137f9be6d43c5970c6271f3cdbfffd8a32de..242dc39660fcd028722093d637b7b64440649863 100644
>> --- a/hw/vfio/ccw.c
>> +++ b/hw/vfio/ccw.c
>> @@ -717,6 +717,21 @@ static void vfio_ccw_class_init(ObjectClass *klass, void *data)
>>       cdc->handle_halt = vfio_ccw_handle_halt;
>>       cdc->handle_clear = vfio_ccw_handle_clear;
>>       cdc->handle_store = vfio_ccw_handle_store;
>> +
>> +    object_class_property_set_description(klass, /* 2.10 */
>> +                                          "sysfsdev",
>> +                                          "Host sysfs path of assigned device");
>> +    object_class_property_set_description(klass, /* 3.0 */
>> +                                          "force-orb-pfch",
>> +                                          "Force unlimited prefetch");
>> +#ifdef CONFIG_IOMMUFD
>> +    object_class_property_set_description(klass, /* 9.0 */
>> +                                          "iommufd",
>> +                                          "Set host IOMMUFD backend device ");
>> +#endif
>> +    object_class_property_set_description(klass, /* 9.2 */
>> +                                          "loadparm",
>> +                                          "Define which devices that can be used for booting");
>>   }
>>   
>>   static const TypeInfo vfio_ccw_info = {
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 9a55e7b77324babf7295132b08e3ba23b482a291..fbd8cf566b1cfd508ccb0042a395e3b79ba781c0 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3433,6 +3433,133 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
>>       pdc->exit = vfio_exitfn;
>>       pdc->config_read = vfio_pci_read_config;
>>       pdc->config_write = vfio_pci_write_config;
>> +
>> +    object_class_property_set_description(klass, /* 1.3 */
>> +                                          "host",
>> +                                          "Host PCI address [domain:]<bus:slot.function> of assigned device");
>> +    object_class_property_set_description(klass, /* 2.6 */
>> +                                          "sysfsdev",
>> +                                          "Host sysfs path of assigned device");
>> +    /*
>> +     * Display
>> +     */
>> +
>> +    object_class_property_set_description(klass, /* 1.5 */
>> +                                          "x-vga",
>> +                                          "Add support for VGA MMIO and I/O port access");
> 
> "Expose VGA address spaces for device"
> 
>> +    object_class_property_set_description(klass, /* 2.12 */
>> +                                          "display",
>> +                                          "Add display support");
> 
> "Enable display support for device, ex. vGPU"
> 
>> +    object_class_property_set_description(klass, /* 3.2 */
>> +                                          "xres",
>> +                                          "Set X display resolution the vgpu should use");
> 
> Maybe capitalize for consistency, vGPU.
> 
>> +    object_class_property_set_description(klass, /* 3.2 */
>> +                                          "yres",
>> +                                          "Set Y display resolution the vgpu should use");
>> +
>> +    /*
>> +     * IGD
>> +     */
>> +
>> +    object_class_property_set_description(klass, /* 2.7 */
>> +                                          "x-igd-opregion",
>> +                                          "Add IGD OpRegion support for (headless system)");
> 
> [Cc Tomita and Corvin have more recent understanding of IGD options]
> 
> Not necessarily for headless systems, unless others have better
> suggestions, maybe just "Expose host IGD OpRegion table to guest".
> 
>> +    object_class_property_set_description(klass, /* 2.7 (See c4c45e943e51) */
>> +                                          "x-igd-gms",
>> +                                          "Add Intel graphics legacy mode device assignment support. "
>> +                                          "Assign 00:02.0 from the host to 00:02.0 in the VM");
> 
> Not really.  Tomita added a useful comment and commit log in
> 37f05a59e869.  Perhaps:
> 
> "Override DVMT Pre-Allocated value for IGD stolen memory. (32MiB units)"
> 
>> +
>> +    /*
>> +     * NVIDIA
>> +     */
>> +    object_class_property_set_description(klass, /* 2.12 */
>> +                                          "x-no-geforce-quirks",
>> +                                          "Disable GeForce quirks (for NVIDIA Quadro/GRID/Tesla). Improves performance");
>> +    object_class_property_set_description(klass, /* 3.0 */
>> +                                          "x-no-kvm-ioeventfd",
>> +                                          "Disable ioeventfd quirk (NVIDIA)");
>> +    object_class_property_set_description(klass, /* 3.0 */
>> +                                          "x-no-vfio-ioeventfd",
>> +                                          "Enable ioeventfd quirks to be handled by VFIO directly. Improves performance");
> 
> The above two should be under debugging, they're only used by NVIDIA
> quirks but they exist for the purpose of validating behavior with and
> without.  The first disables registering an ioeventfd with KVM and the
> latter disables directly "wiring" it through to vfio.  Maybe
> (respectively):
> 
> "Disable registration of ioeventfds with KVM"
> 
> "Disable linking of KVM ioeventfds to VFIO ioeventfds"
> 
> NB. setting the latter does not improve performance.
> 
>> +    object_class_property_set_description(klass, /* 2.11 */
>> +                                          "x-nv-gpudirect-clique",
>> +                                          "Add NVIDIA GPUDirect Cliques support");
> 
> "Add NVIDIA GPUDirect capability indicating P2P DMA clique for device. (0~15)"
> 
> (maybe this is already specified as a uint4 given the PropertyInfo?)

It's not. I will add range [0-15]
> 
>> +
>> +    /*
>> +     * Migration support
>> +     */
>> +    object_class_property_set_description(klass, /* 5.2 */
>> +                                          "x-pre-copy-dirty-page-tracking",
>> +                                          "Disable dirty pages tracking during iterative phase");
>> +    object_class_property_set_description(klass, /* 9.1 */
>> +                                          "x-device-dirty-page-tracking",
>> +                                          "Disable device dirty page tracking and use container-based dirty page tracking");
> 
> These are really debug as well, right?  They just happen to be
> migration related debug.

I asked Joao and Kirti.

>> +    object_class_property_set_description(klass, /* 5.2, 8.0 non-experimetal */
>> +                                          "enable-migration",
>> +                                          "Enale device migration. Also requires a host VFIO PCI variant "
>> +                                          "driver with migration support enabled");
>> +    object_class_property_set_description(klass, /* 9.1 */
>> +                                          "migration-events",
>> +                                          "Emit VFIO migration QAPI event when a VFIO device changes its migration "
>> +                                          "state. For management applications");
>> +    object_class_property_set_description(klass, /* 9.1 */
>> +                                          "skip-vsc-check",
>> +                                          "Skip config space check for Vendor Specific Capability. Useful for "
>> +                                          "NVIDIA vGPU driver migration");
> 
> The vsc check is really for debug too since it's enabled by default and
> mostly only exists as a visible option for manipulation by the machine
> type.
> 
>> +
>> +    /*
>> +     * debug, tracing
>> +     */
>> +    object_class_property_set_description(klass, /* 2.4 and 2.5 */
>> +                                          "x-no-mmap",
>> +                                          "Disable MMAP for device. Allows to trace MMIO accesses");
>> +    object_class_property_set_description(klass, /* 2.5 */
>> +                                          "x-no-kvm-intx",
>> +                                          "Bypass INTx interrupts. Allows interrupt tracing");
> 
> "Disable direct VFIO->KVM INTx injection. Allows to trace INTx interrupts"
> 
> s/INTx/MSI/
> s/INTx/MSIx/
> 
> for the next.
> 
>> +    object_class_property_set_description(klass, /* 2.5 */
>> +                                          "x-no-kvm-msi",
>> +                                          "Bypass MSI interrupts. Allows interrupt tracing");
>> +    object_class_property_set_description(klass, /* 2.5 */
>> +                                          "x-no-kvm-msix",
>> +                                          "Bypass MSIx interrupts. Allows interrupt tracing");
>> +    object_class_property_set_description(klass, /* 2.5 */
>> +                                          "x-pci-vendor-id",
>> +                                          "Set emulated PCI Vendor ID. Allows testing quirks");
>> +    object_class_property_set_description(klass, /* 2.5 */
>> +                                          "x-pci-device-id",
>> +                                          "Set emulated PCI device ID. Allows testing quirks");
> 
> "Override PCI Vendor ID with provided value"
> 
> s/Vendor/Device/
> 
> There are also "sub" versions of these for subsystem Vendor and Device
> IDs.
> 
> None of these are really for quirks, they're more for making devices
> appear as other devices.  For reasons.
> 
>> +
>> +    /*
>> +     * other
>> +     */
>> +    object_class_property_set_description(klass, /* 8.1 */
>> +                                          "vf-token",
>> +                                          "Add support for VF token among PF and VFs (Linux 5.7+)");
> 
> "Specify UUID VF token.  Required for VF when PF is owned by another VFIO driver"
> 
>> +    object_class_property_set_description(klass, /* 1.3 */
>> +                                          "x-intx-mmap-timeout-ms",
>> +                                          "Timeout value in milliseconds to re-enable BAR mapping when under "
>> +                                          "INTx interrupts. Improves performance");
> 
> Changes performance perhaps.  This should also be under debug.
> 
> "When EOI is not provided by KVM/QEMU, wait time to re-enable device direct access after INTx"
> 
>> +    object_class_property_set_description(klass, /* 2.3 */
>> +                                          "x-req",
>> +                                          "Add device request notification support (Linux 4.0+)");
> 
> Also debug.
> 
> "Disable device request notification support"
> 
>> +    object_class_property_set_description(klass, /* 3.1 */
>> +                                          "x-balloon-allowed",
>> +                                          "Allow devices to opt-in for ballooning");
> 
> Debug.
> 
> "Override allowing ballooning with device. (DANGER)"
> 
>> +    object_class_property_set_description(klass, /* 2.5 */
>> +                                          "x-pci-sub-vendor-id",
>> +                                          "Set emulated PCI Sub-vendor ID");
>> +    object_class_property_set_description(klass, /* 2.5 */
>> +                                          "x-pci-sub-device-id",
>> +                                          "Set emulated PCI Sub-device ID");
> 
> Ah, here they are.  Grouping with non-subsystem would make sense to me.
> 
>> +    object_class_property_set_description(klass, /* 2.12 */
>> +                                          "x-msix-relocation",
>> +                                          "Allow relocating MSI-X MMIO on systems which page size is larger "
>> +                                          "than the PCI spec recommendation. Mostly for sPAPR");
> 
> Yes, we added it because of systems with >4K pages, but there do exist
> devices that do not follow the PCI spec recommendation and place
> non-MSI related registers too close the vector table and pba.
> 
> "Specify MSI-X MMIO relocation to the end of specified existing BAR or
> new BAR to avoid virtualization overhead due to adjacent device
> registers"
> 
>> +#ifdef CONFIG_IOMMUFD
>> +    object_class_property_set_description(klass, /* 9.0 */
>> +                                          "iommufd",
>> +                                          "Set host IOMMUFD backend device ");
>> +#endif
>>   }
>>   
>>   static const TypeInfo vfio_pci_dev_info = {
>> @@ -3461,6 +3588,13 @@ static void vfio_pci_nohotplug_dev_class_init(ObjectClass *klass, void *data)
>>   
>>       device_class_set_props(dc, vfio_pci_dev_nohotplug_properties);
>>       dc->hotpluggable = false;
>> +    object_class_property_set_description(klass, /* 3.1 */
>> +                                          "ramfb",
>> +                                          "Add ramfb support");
> 
> "Enable ramfb to provide pre-boot graphics for devices enabling display option"
> 
>> +    object_class_property_set_description(klass, /* 8.2 */
>> +                                          "x-ramfb-migrate",
>> +                                          "Add ramfb migration support");
> 
> Debug.
> 
> "Override default migration support for ramfb support"
> 
>> +
>>   }
>>   
>>   static const TypeInfo vfio_pci_nohotplug_dev_info = {
>> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
>> index 1070a2113a17edb9ebafb5066e51ee2bc52a767d..8e646e543692221e86b16fecd8bf40316f064a7d 100644
>> --- a/hw/vfio/platform.c
>> +++ b/hw/vfio/platform.c
>> @@ -674,6 +674,29 @@ static void vfio_platform_class_init(ObjectClass *klass, void *data)
>>       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>>       /* Supported by TYPE_VIRT_MACHINE */
>>       dc->user_creatable = true;
>> +
>> +    object_class_property_set_description(klass, /* 2.4 */
>> +                                          "host",
>> +                                          "Host device name of assigned device");
>> +    object_class_property_set_description(klass, /* 2.6 */
>> +                                          "sysfsdev",
>> +                                          "Host sysfs path of assigned device");
>> +    object_class_property_set_description(klass, /* 2.4 and 2.5 */
>> +                                          "x-no-mmap",
>> +                                          "Disable MMAP for device. Allows to trace MMIO accesses");
>> +    object_class_property_set_description(klass, /* 2.4 */
>> +                                          "mmap-timeout-ms",
>> +                                          "Timeout value in milliseconds to re-enable BAR mapping");
> 
> This is essentially the same as the vfio-pci INTx version, only used
> when we don't have a mechanism for EOI.
> 
>> +    object_class_property_set_description(klass, /* 2.4 */
>> +                                          "x-irqfd",
>> +                                          "Use irqfd for IRQ handling");
> 
> Debug.  Allow disabling irqfd support.
> 
> Maybe rather than trying to group debug options together they should
> just be explicitly labeled in the description, ex. "[DEBUG]"

I came to the same conclusion. If the property name or description
is not clear I will add a label (DEBUG, NVIDIA, etc) and order the
properties by QEMU version.

I find the QEMU version in which a property was introduced interesting
to save. It's less tedious then digging with "git log -S".

May be should we introduce documentation for properties like the kernel
has in Documentation/ABI/*/sysfs-* ?

Thanks,

C.



