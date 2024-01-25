Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682BBC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 08:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSuwE-0003Yh-UR; Thu, 25 Jan 2024 03:18:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1rSuwA-0003YR-AA
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 03:18:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1rSuw8-0007xH-Bb
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 03:18:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706170690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=468J+ZJSS9UOvexnK9ZKOZ1vE79Q2YFSm1UpPm5fd8E=;
 b=WPsQX+ipJ0saNjTKupIqf93OR6jMHlXGShzJvDrGsLLC3ctSfxfyhOfJFisoHDD0GipC0i
 tbOJKQVXwT12NGOxVnQ2cBDvc75eeH4BmhYOfo9uVYZPOb7WloptuEq+2TSbjapxvvFq7Q
 bZ0Yp9UNf1llnY0v1MzQCv1+f33+ayY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-TaRzId3hMtii5Eg9S3eGnA-1; Thu, 25 Jan 2024 03:18:07 -0500
X-MC-Unique: TaRzId3hMtii5Eg9S3eGnA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6868e22f34fso53842116d6.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 00:18:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706170687; x=1706775487;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=468J+ZJSS9UOvexnK9ZKOZ1vE79Q2YFSm1UpPm5fd8E=;
 b=TdKX61l5uSiaGkQt+FT/rtNIJYdQkCcvNLggvQhydFC9HovyW3GwGAlrq7fWrG7FHV
 jGIxqIaK+heRHJ3tYmbdBVWKik/ep9VDDPDmQiETOzKNAH4nxggO8EmW+JReJ7wgmF2B
 tJpCZWW5PzIgizYV/MLkHBTUBRU+8KxvFk6ZpMEe6fzknuJeGJv5AAvXBppq9S6x3foV
 R3+wN1d3WlixxFUnVUy4cxD+DN0iKIBz0Ud27ueYHD/q6jEJavo7vquUgV9p7cSwyXHF
 h/Ac2eMnoIZwhuCUfnRNPYvQyDsEmcUcB+iCdnqbWhKQyvJzJRP2CPmeXOQIv9bNF817
 tvAQ==
X-Gm-Message-State: AOJu0YyW+P2o4MHxWHlomPRvpN2J7B3v3yYgyJrz7ZEf+lHwpRO4T+Dp
 VGnnKTeBkboQ+grN/jAH39j9+Pd6eOLs62USuF748Bone/uKHBLg5sNP9o+IFj0cyWO4ALaFKOP
 xj8VIbeSPg9cxVT3R2QjaBRzimhCY9sG+YUw+knv5UOe8flWZsZBp
X-Received: by 2002:a05:6214:2622:b0:681:88ea:3699 with SMTP id
 gv2-20020a056214262200b0068188ea3699mr758469qvb.90.1706170687389; 
 Thu, 25 Jan 2024 00:18:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGVH2Scr60+L5YMKykZ2JACi3WGpdD2sj9dj0UClUE+wvxqTjMeDTvt/Hvru6R84yUkrWRMg==
X-Received: by 2002:a05:6214:2622:b0:681:88ea:3699 with SMTP id
 gv2-20020a056214262200b0068188ea3699mr758455qvb.90.1706170687116; 
 Thu, 25 Jan 2024 00:18:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 y20-20020ad445b4000000b006816ffc7113sm5210233qvu.63.2024.01.25.00.18.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jan 2024 00:18:06 -0800 (PST)
Message-ID: <8d85ff1d-fed9-49c9-9fe3-b401e0921533@redhat.com>
Date: Thu, 25 Jan 2024 09:18:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/i386/host-cpu: Use iommu phys_bits with VFIO
 assigned devices on Intel h/w
Content-Language: en-US
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Dongwon Kim <dongwon.kim@intel.com>,
 Yanghang Liu <yanghliu@redhat.com>
References: <20240118192049.1796763-1-vivek.kasireddy@intel.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20240118192049.1796763-1-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Vivek,

On 1/18/24 20:20, Vivek Kasireddy wrote:
> Recent updates in OVMF and Seabios have resulted in MMIO regions
> being placed at the upper end of the physical address space. As a
> result, when a Host device is assigned to the Guest via VFIO, the
> following mapping failures occur when VFIO tries to map the MMIO
> regions of the device:
> VFIO_MAP_DMA failed: Invalid argument
> vfio_dma_map(0x557b2f2736d0, 0x380000000000, 0x1000000, 0x7f98ac400000) = -22 (Invalid argument)
> 
> The above failures are mainly seen on some Intel platforms where
> the physical address width is larger than the Host's IOMMU
> address width. In these cases, VFIO fails to map the MMIO regions
> because the IOVAs would be larger than the IOMMU aperture regions.
> 
> Therefore, one way to solve this problem would be to ensure that
> cpu->phys_bits = <IOMMU phys_bits>
> This can be done by parsing the IOMMU caps value from sysfs and
> extracting the address width and using it to override the
> phys_bits value as shown in this patch.
> 
> Previous attempt at solving this issue in OVMF:
> https://edk2.groups.io/g/devel/topic/102359124
> 
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Cédric Le Goater <clg@redhat.com>
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Dongwon Kim <dongwon.kim@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> Tested-by: Yanghang Liu <yanghliu@redhat.com>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> 
> ---
> v2:
> - Replace the term passthrough with assigned (Laszlo)
> - Update the commit message to note that both OVMF and Seabios
>   guests are affected (Cédric)
> - Update the subject to indicate what is done in the patch
> ---
>  target/i386/host-cpu.c | 61 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
> index 92ecb7254b..5c9fcd7dc2 100644
> --- a/target/i386/host-cpu.c
> +++ b/target/i386/host-cpu.c
> @@ -12,6 +12,8 @@
>  #include "host-cpu.h"
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
> +#include "qemu/config-file.h"
> +#include "qemu/option.h"
>  #include "sysemu/sysemu.h"
>  
>  /* Note: Only safe for use on x86(-64) hosts */
> @@ -51,11 +53,58 @@ static void host_cpu_enable_cpu_pm(X86CPU *cpu)
>      env->features[FEAT_1_ECX] |= CPUID_EXT_MONITOR;
>  }
>  
> +static int intel_iommu_check(void *opaque, QemuOpts *opts, Error **errp)
> +{
> +    g_autofree char *dev_path = NULL, *iommu_path = NULL, *caps = NULL;
> +    const char *driver = qemu_opt_get(opts, "driver");
> +    const char *device = qemu_opt_get(opts, "host");
> +    uint32_t *iommu_phys_bits = opaque;
> +    struct stat st;
> +    uint64_t iommu_caps;
> +
> +    /*
> +     * Check if the user requested VFIO device assignment. We don't have
> +     * to limit phys_bits if there are no valid assigned devices.
> +     */
> +    if (g_strcmp0(driver, "vfio-pci") || !device) {
> +        return 0;
> +    }
> +
> +    dev_path = g_strdup_printf("/sys/bus/pci/devices/%s", device);
> +    if (stat(dev_path, &st) < 0) {
> +        return 0;
> +    }
> +
> +    iommu_path = g_strdup_printf("%s/iommu/intel-iommu/cap", dev_path);
> +    if (stat(iommu_path, &st) < 0) {
> +        return 0;
> +    }
> +
> +    if (g_file_get_contents(iommu_path, &caps, NULL, NULL)) {
> +        if (sscanf(caps, "%lx", &iommu_caps) != 1) {
> +            return 0;
> +        }
> +        *iommu_phys_bits = ((iommu_caps >> 16) & 0x3f) + 1;
> +    }
> +
> +    return 0;
> +}
> +
> +static uint32_t host_iommu_phys_bits(void)
> +{
> +    uint32_t iommu_phys_bits = 0;
> +
> +    qemu_opts_foreach(qemu_find_opts("device"),
> +                      intel_iommu_check, &iommu_phys_bits, NULL);
> +    return iommu_phys_bits;
> +}
> +
>  static uint32_t host_cpu_adjust_phys_bits(X86CPU *cpu)
>  {
>      uint32_t host_phys_bits = host_cpu_phys_bits();
> +    uint32_t iommu_phys_bits = host_iommu_phys_bits();
>      uint32_t phys_bits = cpu->phys_bits;
> -    static bool warned;
> +    static bool warned, warned2;
>  
>      /*
>       * Print a warning if the user set it to a value that's not the
> @@ -78,6 +127,16 @@ static uint32_t host_cpu_adjust_phys_bits(X86CPU *cpu)
>          }
>      }
>  
> +    if (iommu_phys_bits && phys_bits > iommu_phys_bits) {
> +        phys_bits = iommu_phys_bits;
are you allowed to change the host cpu characteristics without taking
care of compats for migration?

I don't know anything about OVMF but why isn't the "cap" not directly
read in the FW stack?

Thanks

Eric
> +        if (!warned2) {
> +            warn_report("Using physical bits (%u)"
> +                        " to prevent VFIO mapping failures",
> +                        iommu_phys_bits);
> +            warned2 = true;
> +        }
> +    }
> +
>      return phys_bits;
>  }
>  


