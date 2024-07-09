Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF6CC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 13:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRAxx-0002cp-1U; Tue, 09 Jul 2024 09:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sRAxu-0002am-1x
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 09:33:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sRAxh-0008Nl-T2
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 09:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720531972;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hcYNPiAxxZiFlbDUPTi8jag3xNX3lLeMyqZc5BZbBs4=;
 b=ZKzdDxIb0Tp6SOj+SK8la1MX4YqmXxYNRFyyd5LTB9n25196DbCgoPFNBHWpqFqBydxBSu
 Cf+m3ZaL4wC8tflKhloOcI7RhtjDCD7IHw4Li9y0dnNkC1oyMvUuZQYtrioHj5zxwHUm24
 MIhyXEHFhdSLGxtXgGbW0PCevuJcQpk=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-LsseWWTMNSS4BS9kVMghGg-1; Tue, 09 Jul 2024 09:32:50 -0400
X-MC-Unique: LsseWWTMNSS4BS9kVMghGg-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3d8685dd263so5141134b6e.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 06:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720531970; x=1721136770;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hcYNPiAxxZiFlbDUPTi8jag3xNX3lLeMyqZc5BZbBs4=;
 b=jxdooFRPJaIR4XvlNnCincTYpt/cclmn344HLlvzR7Bw2BKTdOAil7GkKpbJFgTWGD
 lPQN7Eph4+THJ7ufhuU/5GgC7keMGFGXIvDaJfVPNy1jjuJqxA1QBjuQ8sHvczlDgeYZ
 dRiJVluEMVATqYW4Bpj4CIyWzCsrMXzU4fQofD43l1REHovWSbCPfP6ZVC8M9xvCe1rv
 xduwO3q3ty9tKJyZCPVCGNBWcjQBDV8zubxfxA2xXpDPXWS4jhmQyDgjATdArYDEawsG
 2vp7wCzvJ5BEHFaQ5R2mYqvMkV646HgnqYZBQc3k2XiWXnbKGBgaBSNXm2ATmi4bADCY
 gVPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWay2FddIMT1jqYeb61ORVtMqfkRjdfL18eDK1w96Lvkm0lzoUOO6fAHI+MdFuoGJS2F0+aDPT3VdX2BNcPqkYsB9P6mHs=
X-Gm-Message-State: AOJu0Yw1Uj8sDGPc/Ywrq+3b0KJQUvwS3Md4c+0d02i1v0OO2NWH98Uz
 VCpR3MZAxIUFdTn9UFMtaqtZEVRJYxN3W5UyG2tLoANhAZ632xZH4gfAggE1SGMGxecdYiFnDpQ
 coPfgBmQ0sViN1occEnUB7eb3T0M7R+6SJ6yBKoj4Ay0T8mkGE0R+
X-Received: by 2002:a05:6808:17a5:b0:3d2:23e0:d7aa with SMTP id
 5614622812f47-3d93bef8b38mr3153317b6e.13.1720531969846; 
 Tue, 09 Jul 2024 06:32:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/LJ8rv1OPW/ob+cCW/EGCVHsn5vcUe4TFlGASFSOMb+8IvbF2eaGIyfDMTQ4CpiMCoZs1xg==
X-Received: by 2002:a05:6808:17a5:b0:3d2:23e0:d7aa with SMTP id
 5614622812f47-3d93bef8b38mr3153287b6e.13.1720531969386; 
 Tue, 09 Jul 2024 06:32:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-447fa56d88csm9767081cf.27.2024.07.09.06.32.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jul 2024 06:32:48 -0700 (PDT)
Message-ID: <d59d2d2a-e6b7-4dde-9be7-56986f3fdf91@redhat.com>
Date: Tue, 9 Jul 2024 15:32:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv1 06/10] hw/arm/virt: Assign vfio-pci devices to
 nested SMMUs
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>, peter.maydell@linaro.org,
 shannon.zhaosl@gmail.com, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, peterx@redhat.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, jgg@nvidia.com,
 shameerali.kolothum.thodi@huawei.com, jasowang@redhat.com,
 Andrea Bolognani <abologna@redhat.com>
References: <cover.1719361174.git.nicolinc@nvidia.com>
 <67c6311756de2a6e827e3dd0563f939dcf334418.1719361174.git.nicolinc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <67c6311756de2a6e827e3dd0563f939dcf334418.1719361174.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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



On 6/26/24 02:28, Nicolin Chen wrote:
> With iommu=nested-smmuv3, there could be multiple nested SMMU instances in
> the vms. A passthrough device must to look up for its iommu handler in its
> sysfs node, and then link to the nested SMMU instance created for the same
> iommu handler. This isn't easy to do.
>
> Add an auto-assign piece after all vSMMU backed pxb buses are created. It
> loops the existing input devices, and sets/replaces their pci bus numbers
> with a newly created pcie-root-port to the pxb bus.
Here again I don't think it is acceptable to create such topology under
the hood. Libvirt shall master the whole PCIe topology.

Eric
>
> Note that this is not an ideal solution to handle hot plug device.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  hw/arm/virt.c         | 110 ++++++++++++++++++++++++++++++++++++++++++
>  include/hw/arm/virt.h |  13 +++++
>  2 files changed, 123 insertions(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index a54332fca8..3610f53304 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -38,6 +38,7 @@
>  #include "hw/arm/primecell.h"
>  #include "hw/arm/virt.h"
>  #include "hw/block/flash.h"
> +#include "hw/vfio/pci.h"
>  #include "hw/vfio/vfio-calxeda-xgmac.h"
>  #include "hw/vfio/vfio-amd-xgbe.h"
>  #include "hw/display/ramfb.h"
> @@ -1491,6 +1492,112 @@ static void create_virtio_iommu_dt_bindings(VirtMachineState *vms)
>                             bdf + 1, vms->iommu_phandle, bdf + 1, 0xffff - bdf);
>  }
>  
> +static char *create_new_pcie_port(VirtNestedSmmu *nested_smmu, Error **errp)
> +{
> +    uint32_t port_nr = nested_smmu->pci_bus->qbus.num_children;
> +    uint32_t chassis_nr = UINT8_MAX - nested_smmu->index;
> +    uint32_t bus_nr = pci_bus_num(nested_smmu->pci_bus);
> +    DeviceState *dev;
> +    char *name_port;
> +
> +    /* Create a root port */
> +    dev = qdev_new("pcie-root-port");
> +    name_port = g_strdup_printf("smmu_bus0x%x_port%d", bus_nr, port_nr);
> +
> +    if (!qdev_set_id(dev, name_port, &error_fatal)) {
> +        /* FIXME retry with a different port num? */
> +        error_setg(errp, "Could not set pcie-root-port ID %s", name_port);
> +        g_free(name_port);
> +        g_free(dev);
> +        return NULL;
> +    }
> +    qdev_prop_set_uint32(dev, "chassis", chassis_nr);
> +    qdev_prop_set_uint32(dev, "slot", port_nr);
> +    qdev_prop_set_uint64(dev, "io-reserve", 0);
> +    qdev_realize_and_unref(dev, BUS(nested_smmu->pci_bus), &error_fatal);
> +    return name_port;
> +}
> +
> +static int assign_nested_smmu(void *opaque, QemuOpts *opts, Error **errp)
> +{
> +    VirtMachineState *vms = (VirtMachineState *)opaque;
> +    const char *sysfsdev = qemu_opt_get(opts, "sysfsdev");
> +    const char *iommufd = qemu_opt_get(opts, "iommufd");
> +    const char *driver = qemu_opt_get(opts, "driver");
> +    const char *host = qemu_opt_get(opts, "host");
> +    const char *bus = qemu_opt_get(opts, "bus");
> +    VirtNestedSmmu *nested_smmu;
> +    char *link_iommu;
> +    char *dir_iommu;
> +    char *smmu_node;
> +    char *name_port;
> +    int ret = 0;
> +
> +    if (!iommufd || !driver) {
> +        return 0;
> +    }
> +    if (!sysfsdev && !host) {
> +        return 0;
> +    }
> +    if (strncmp(driver, TYPE_VFIO_PCI, strlen(TYPE_VFIO_PCI))) {
> +        return 0;
> +    }
> +    /* If the device wants to attach to the default bus, do not reassign it */
> +    if (bus && !strncmp(bus, "pcie.0", strlen(bus))) {
> +        return 0;
> +    }
> +
> +    if (sysfsdev) {
> +        link_iommu = g_strdup_printf("%s/iommu", sysfsdev);
> +    } else {
> +        link_iommu = g_strdup_printf("/sys/bus/pci/devices/%s/iommu", host);
> +    }
> +
> +    dir_iommu = realpath(link_iommu, NULL);
> +    if (!dir_iommu) {
> +        error_setg(errp, "Could not get the real path for iommu link: %s",
> +                   link_iommu);
> +        ret = -EINVAL;
> +        goto free_link;
> +    }
> +
> +    smmu_node = g_path_get_basename(dir_iommu);
> +    if (!smmu_node) {
> +        error_setg(errp, "Could not get SMMU node name for iommu at: %s",
> +                   dir_iommu);
> +        ret = -EINVAL;
> +        goto free_dir;
> +    }
> +
> +    nested_smmu = find_nested_smmu_by_sysfs(vms, smmu_node);
> +    if (!nested_smmu) {
> +        error_setg(errp, "Could not find any detected SMMU matching node: %s",
> +                   smmu_node);
> +        ret = -EINVAL;
> +        goto free_node;
> +    }
> +
> +    name_port = create_new_pcie_port(nested_smmu, errp);
> +    if (!name_port) {
> +        ret = -EBUSY;
> +        goto free_node;
> +    }
> +
> +    qemu_opt_set(opts, "bus", name_port, &error_fatal);
> +    if (bus) {
> +        error_report("overriding PCI bus %s to %s for device %s [%s]",
> +                     bus, name_port, host, sysfsdev);
> +    }
> +
> +free_node:
> +    free(smmu_node);
> +free_dir:
> +    free(dir_iommu);
> +free_link:
> +    free(link_iommu);
> +    return ret;
> +}
> +
>  /*
>   * FIXME this is used to reverse for hotplug devices, yet it could result in a
>   * big waste of PCI bus numbners.
> @@ -1669,6 +1776,9 @@ static void create_pcie(VirtMachineState *vms)
>              qemu_fdt_setprop_cells(ms->fdt, nodename, "iommu-map", 0x0,
>                                     vms->nested_smmu_phandle[i], 0x0, 0x10000);
>          }
> +
> +        qemu_opts_foreach(qemu_find_opts("device"),
> +                          assign_nested_smmu, vms, &error_fatal);
>      } else if (vms->iommu) {
>          vms->iommu_phandle = qemu_fdt_alloc_phandle(ms->fdt);
>  
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 0a3f1ab8b5..dfbc4bba3c 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -246,4 +246,17 @@ find_nested_smmu_by_index(VirtMachineState *vms, int index)
>      return NULL;
>  }
>  
> +static inline VirtNestedSmmu *
> +find_nested_smmu_by_sysfs(VirtMachineState *vms, char *node)
> +{
> +    VirtNestedSmmu *nested_smmu;
> +
> +    QLIST_FOREACH(nested_smmu, &vms->nested_smmu_list, next) {
> +        if (!strncmp(nested_smmu->smmu_node, node, strlen(node))) {
> +            return nested_smmu;
> +        }
> +    }
> +    return NULL;
> +}
> +
>  #endif /* QEMU_ARM_VIRT_H */


