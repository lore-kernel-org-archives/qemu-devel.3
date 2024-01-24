Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A7BC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 11:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSbpQ-0004jL-VW; Wed, 24 Jan 2024 06:54:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rSbpP-0004jD-Mr
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 06:53:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rSbpL-0004iO-Gn
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 06:53:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706097233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qsu6KZ3pcSvJWQvwU0PQ3+F9BPGtx53e5sMf3QHvd5s=;
 b=eRaQQPHxfelvM8yPkayEJ1YCnKOUwM3T/XaWa8D/sh7VETvVOOetIR/UP6WDySq01EbPUH
 xGQUwN47eJ6/FLzckwH6E3Ti6jHdcmjBowlM7P0a4iPheIejy00pT/eM3SAOT9Ad2vXtBj
 xYXkxg526udNEWhpyqnWXsi168kGZN0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-S5P8M0u7NymGe5ft1w9Yhg-1; Wed, 24 Jan 2024 06:53:51 -0500
X-MC-Unique: S5P8M0u7NymGe5ft1w9Yhg-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7833761135dso747023385a.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 03:53:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706097231; x=1706702031;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qsu6KZ3pcSvJWQvwU0PQ3+F9BPGtx53e5sMf3QHvd5s=;
 b=nPrVRZESGFjBALFFO99MrhDMgF2M98uVqGNQcM7HmoLSN96CK01W7UgprzCumTVS5g
 6pc3EzcsPTPrgx95rPG7vZ4U8dGwhUEfxQ12AlZhxVH4XXfwzEg9JzdtP7LG7yXZxIZ9
 WWHHgPcglLIwg0VmXD8E4WGxwLIvEWEATuXcbBA6J9le0NrGxqSQToXyIhJEgX0cSnlG
 PAEyo/r8hbpSKBUYQxjWtafnfyB0l+2Q2xf+XXwV5QECt0vJIzroNa3Pt5jobNcUQRrE
 zKMOEWl/2cODSpAz7bFEkS81vc1YqfkKCyKyMh/R0RJthmX02o66ExYcxjlDNtWnETAb
 CtPg==
X-Gm-Message-State: AOJu0YyuoW/F7Pss9LZNSDZUY8yjnBGeGbrwXj7V2GE7tF5j1fQAj6/L
 k3XCJxlloI1XjKWzlqnQtkmH2GVsa2IN8tqMGzRB1kybAr6ljjgj9n6h4Td+FXoy2s2Jj+v3zJj
 tWSmHan3arjYAanzjEFRGhMXmFF1XhEN7rgOUlRfPcDPp4J5URiqa
X-Received: by 2002:a05:620a:148e:b0:783:47e2:41ff with SMTP id
 w14-20020a05620a148e00b0078347e241ffmr7556213qkj.43.1706097231461; 
 Wed, 24 Jan 2024 03:53:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUA0MocbUu2JEmgzGgbGUVQ31ShCBmHJpcAtUbids/pAMgTRrR1xERIlpUWmn7/DUkOjJSrw==
X-Received: by 2002:a05:620a:148e:b0:783:47e2:41ff with SMTP id
 w14-20020a05620a148e00b0078347e241ffmr7556203qkj.43.1706097231201; 
 Wed, 24 Jan 2024 03:53:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 t15-20020a05620a034f00b0078397c1fb9esm3437408qkm.102.2024.01.24.03.53.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 03:53:50 -0800 (PST)
Message-ID: <9462383d-3e42-460e-b721-8371d35e29a6@redhat.com>
Date: Wed, 24 Jan 2024 12:53:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/i386/host-cpu: Use iommu phys_bits with VFIO
 assigned devices on Intel h/w
Content-Language: en-US
To: Vivek Kasireddy <vivek.kasireddy@intel.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Dongwon Kim <dongwon.kim@intel.com>,
 Yanghang Liu <yanghliu@redhat.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
References: <20240118192049.1796763-1-vivek.kasireddy@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240118192049.1796763-1-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
>    guests are affected (Cédric)
> - Update the subject to indicate what is done in the patch
> ---
>   target/i386/host-cpu.c | 61 +++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/host-cpu.c b/target/i386/host-cpu.c
> index 92ecb7254b..5c9fcd7dc2 100644
> --- a/target/i386/host-cpu.c
> +++ b/target/i386/host-cpu.c
> @@ -12,6 +12,8 @@
>   #include "host-cpu.h"
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
> +#include "qemu/config-file.h"
> +#include "qemu/option.h"
>   #include "sysemu/sysemu.h"
>   
>   /* Note: Only safe for use on x86(-64) hosts */
> @@ -51,11 +53,58 @@ static void host_cpu_enable_cpu_pm(X86CPU *cpu)
>       env->features[FEAT_1_ECX] |= CPUID_EXT_MONITOR;
>   }
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

nit. This should use a PRIx64 define.

> +            return 0;
> +        }
> +        *iommu_phys_bits = ((iommu_caps >> 16) & 0x3f) + 1;

Please use 0x3fULL and this could be a macro in include/hw/i386/intel_iommu.h

Thanks,

C.



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
>   static uint32_t host_cpu_adjust_phys_bits(X86CPU *cpu)
>   {
>       uint32_t host_phys_bits = host_cpu_phys_bits();
> +    uint32_t iommu_phys_bits = host_iommu_phys_bits();
>       uint32_t phys_bits = cpu->phys_bits;
> -    static bool warned;
> +    static bool warned, warned2;
>   
>       /*
>        * Print a warning if the user set it to a value that's not the
> @@ -78,6 +127,16 @@ static uint32_t host_cpu_adjust_phys_bits(X86CPU *cpu)
>           }
>       }
>   
> +    if (iommu_phys_bits && phys_bits > iommu_phys_bits) {
> +        phys_bits = iommu_phys_bits;
> +        if (!warned2) {
> +            warn_report("Using physical bits (%u)"
> +                        " to prevent VFIO mapping failures",
> +                        iommu_phys_bits);
> +            warned2 = true;
> +        }
> +    }
> +
>       return phys_bits;
>   }
>   


