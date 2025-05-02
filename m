Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87C6C3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 18:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAv0w-0008CS-T6; Fri, 02 May 2025 14:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uAv0v-0008A5-EX
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:21:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uAv0t-0001TI-Ca
 for qemu-devel@nongnu.org; Fri, 02 May 2025 14:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746210090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/RmPeSW+7le8nHKn0KsI9GV7UpivmhOM9DYqwi/JrHo=;
 b=LhzWcqRw3sH9+4f+0azDF8iu3ObJmDl32JUlhFT8yxpJENCwnfTGyF/AmaDna9+UP36/Wh
 kg5zkwCUBC+T2NRQ5I4pIrsOZYUzMIdUr8GDv24mMMKdhnvnrM0ci/mWv4MhmoRHo5Ltnm
 6LvGixxnEpzk6DekpGD3EhBmyapYh/c=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-JlvM3IvyPg6UeK8q6G_lEQ-1; Fri, 02 May 2025 14:21:29 -0400
X-MC-Unique: JlvM3IvyPg6UeK8q6G_lEQ-1
X-Mimecast-MFC-AGG-ID: JlvM3IvyPg6UeK8q6G_lEQ_1746210089
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4766afee192so80633961cf.0
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 11:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746210089; x=1746814889;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/RmPeSW+7le8nHKn0KsI9GV7UpivmhOM9DYqwi/JrHo=;
 b=Hn2xlPh5NtRha5PJb6122qawVJDg4z/gVlC9DPV76dI6tFp5NMQh1nbkYkPWwokEEo
 fNUD210SYuVr909SJe1a8ipGm/GIMg5DUQpbImXOppVTkdVJh4aPujgBE7gEKghruAUf
 dtFtHohMhLYWGr7G76y5u7SbLkkrZhWG09IkT3H5GF/N3k7umnFFp6EGRJmnKNHqQX4Y
 NzfEwN+YcL5AwFzceDbyPRdgkCeSUaI4zSduloPKHLtI9T01nozffRxA4vSt+CTcgHA1
 D2oXJTON3oX4ejfA4SNuuj6q3wHR9dEdZlB+CkhstgRbOAlsykabdydLpDeCHzp92evH
 9xOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXj2mYOixAEGgAEMGD+rowGgNf0nLla8bUVqoC3UrobBCP/NpO9QJHc+fJoJ2N/KPIwuF4NchJlM+r8@nongnu.org
X-Gm-Message-State: AOJu0YxxMWOGdwwitX9Y5eFXTxAABujh3ytFpvXT3+cSuBopfoa31+6q
 UfxZlT/mHibStyu8R+B2p8xRg8yVmvw4/GCYVdOAioIC8uhc6mgvJQ8x9Boa2W6/CrIIlAB5zpx
 Ey1pOMGw0jMJavOnQyBipT6am0ogoWtPMgK2lZjKNbNl9yg9B3cvM
X-Gm-Gg: ASbGncsyZpmBQcLFM59kwNhyWfcVSAHd2e4sndL20uDhfb1Ec2OMAWAlavuuvvPlS6E
 Sfw/XTreJY1k04nHkqtD85Z9PQKEZ5opEJhRbyAGI8DtVytnTc3vS7lfDr+XF1JwoHzmeofOj2r
 QwIRuGZEZbPmWOnZDSafj6ukdMJopjxyq2yLkP69fQSGFeDCUX+R8tlTp4Kq72SJotVXhv7NE/5
 RO95Nx1x08u/gz6ZdpSTbeBkoqN4dU3DvfZcxkhEB2HVXAn1CAzFIkrvK3VdKfN1ZQ34UEXnJev
 NQjXP9P+kYEY
X-Received: by 2002:ac8:6f1b:0:b0:474:fee1:7915 with SMTP id
 d75a77b69052e-48c31c17c0cmr66004451cf.31.1746210089141; 
 Fri, 02 May 2025 11:21:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1rxNHWuCL01I7+9dR+Xevz8xwwRZMvXD2AoEsvIvqG3bhpJwD6lE77eBDrTyA2FDFUf93Ng==
X-Received: by 2002:ac8:6f1b:0:b0:474:fee1:7915 with SMTP id
 d75a77b69052e-48c31c17c0cmr66004031cf.31.1746210088817; 
 Fri, 02 May 2025 11:21:28 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-48b966d8b1asm20941761cf.31.2025.05.02.11.21.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 May 2025 11:21:28 -0700 (PDT)
Message-ID: <49fad744-e9fd-4914-ae37-fc12d1da55c6@redhat.com>
Date: Fri, 2 May 2025 14:20:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] hw/arm/virt: Add an SMMU_IO_LEN macro
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, peter.maydell@linaro.org, jgg@nvidia.com,
 nicolinc@nvidia.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250502102707.110516-1-shameerali.kolothum.thodi@huawei.com>
 <20250502102707.110516-5-shameerali.kolothum.thodi@huawei.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <20250502102707.110516-5-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
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



On 5/2/25 6:27 AM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
> 
> This is useful as the subsequent support for new SMMUv3 dev will also
> use the same.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   hw/arm/virt.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 464e84ae67..e178282d71 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -147,6 +147,9 @@ static void arm_virt_compat_set(MachineClass *mc)
>   #define LEGACY_RAMLIMIT_GB 255
>   #define LEGACY_RAMLIMIT_BYTES (LEGACY_RAMLIMIT_GB * GiB)
>   
> +/* MMIO region size for SMMUv3 */
> +#define SMMU_IO_LEN 0x20000
> +
>   /* Addresses and sizes of our components.
>    * 0..128MB is space for a flash device so we can run bootrom code such as UEFI.
>    * 128MB..256MB is used for miscellaneous device I/O.
> @@ -178,7 +181,7 @@ static const MemMapEntry base_memmap[] = {
>       [VIRT_FW_CFG] =             { 0x09020000, 0x00000018 },
>       [VIRT_GPIO] =               { 0x09030000, 0x00001000 },
>       [VIRT_UART1] =              { 0x09040000, 0x00001000 },
> -    [VIRT_SMMU] =               { 0x09050000, 0x00020000 },
> +    [VIRT_SMMU] =               { 0x09050000, SMMU_IO_LEN },
>       [VIRT_PCDIMM_ACPI] =        { 0x09070000, MEMORY_HOTPLUG_IO_LEN },
>       [VIRT_ACPI_GED] =           { 0x09080000, ACPI_GED_EVT_SEL_LEN },
>       [VIRT_NVDIMM_ACPI] =        { 0x09090000, NVDIMM_ACPI_IO_LEN},
> @@ -1453,7 +1456,6 @@ static void create_smmu(const VirtMachineState *vms,
>       int irq =  vms->irqmap[VIRT_SMMU];
>       int i;
>       hwaddr base = vms->memmap[VIRT_SMMU].base;
> -    hwaddr size = vms->memmap[VIRT_SMMU].size;
>       DeviceState *dev;
>   
>       if (vms->iommu != VIRT_IOMMU_SMMUV3 || !vms->iommu_phandle) {
> @@ -1473,7 +1475,7 @@ static void create_smmu(const VirtMachineState *vms,
>           sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
>                              qdev_get_gpio_in(vms->gic, irq + i));
>       }
> -    create_smmuv3_dt_bindings(vms, base, size, irq);
> +    create_smmuv3_dt_bindings(vms, base, SMMU_IO_LEN, irq);
>   }
>   
>   static void create_virtio_iommu_dt_bindings(VirtMachineState *vms)

Reviewed-by: Donald Dutile <ddutile@redhat.com>


