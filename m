Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D36CE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 15:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNDA6-0007Es-Go; Mon, 16 Dec 2024 10:37:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNDA4-0007Cd-OM
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 10:37:32 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNDA2-0002YM-Pb
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 10:37:32 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso45406825e9.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 07:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734363449; x=1734968249; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sVTey5Y1PcilUqBH9Ys9BheJhbJ9dW/ypOdzhXS9/Gw=;
 b=B+7jbPP+LsLhl/G/oK2o+/f1lS2x0obqmtkikXNw1duKI1bqUZX2ql4ePFW4wtkiCa
 xIEl/3zPII9tfAGEfzZP9cz+J8LkEBDmAoiWuulMhSJFz8T8Q92CvcWJIYB/CtMDCOue
 FZb/EdYsze0DJeYqYYEcAAzN16OS4rvi7nSRWSrfDMSVo9phqqOli9McFAck3ATdxWZj
 Bo5FAgt6tlpJtfQiPP1Ms+EQ7xrm/fzmODR74YIih3dOxU/3FN3tlG+QCqWTr5aViDog
 k6lomRt62W6gC6zxkbj4jaKQtiBHhnMMTpdJjUYeUkxam7wHyGDmpFlfi2Als8QdyDfL
 cZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734363449; x=1734968249;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sVTey5Y1PcilUqBH9Ys9BheJhbJ9dW/ypOdzhXS9/Gw=;
 b=ZDGTEEgnOWDRDmmynZpkKV2Ujxq6kmXiSQv1AhiB2nRAfUqV3kqpJx8dqUGSHT3Yxz
 ffQl1OquyjE9eLuP1j4N73wSz+rZEGBI8Ldv6ZZ7jARSNCXUB/gPt0i78pQznolC7k4A
 fyy66dy3v4oj9K0kXcK8HFScWzk3h2udQgkw/creO4eZonjss+GRwOC6slcSXSaUBAZ3
 Mx8P7NUH55pBc5JkTrP7xAKVwNhlOcKx1imaHJ2I6GBoxUEBT6u3t0ehGIUwDOWRzX4b
 XBVZk84pzUGfRnQLbnWD6RTdePvjceWQ8H68la1nhki3q819vZN5Nw54fH3/b3fP8goM
 eWzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhzBtgjfm9k7SXFu4jDfkX62hHSZ3GvOr8AQs5y/MOm5RMTeVdW+9ChmP7/AJJDvCcw4zWYPOaPpmt@nongnu.org
X-Gm-Message-State: AOJu0Yx77jJJefxmy9sJgTrBOgdsYGpWMFCfnw8NsRbxSeot54kxepyy
 1pH2QFFQRVRItH7BPqrFxOR+xITQGVWg51df87p1fUw47Uz3BsFdLhWvk2qw9ps=
X-Gm-Gg: ASbGncviZJFCmXd548wKacPeg/mtpgR4VGY1bdRX6bV3D0Z2GW8brmSwE8MtcDbyvY0
 nZuUqRI3utwFq3YBeuTrpj+J57SjFWBHUY8Qetc3M8WtgoPfJsQInDnIDOeHz9cVivtEIt8uO1c
 pRxogT90+ve50DrrY69oDwaBKG9sQbXygtX0fuDaiR0cImqCW1EPxdIGBjfsYGi+FfxONhQfrLC
 GY8HD82h4FvLCjbX9oAvAUsqj19EroGgKky+UMn98hCuL5uS3ZrmPnWUh/RZbnhL5zxjkbc
X-Google-Smtp-Source: AGHT+IE8VzkM1umgjbhPJ4ykRy+H/Hbp13Oos6SbDuL+k8Wsb2qdw3LlrYNvDOxs/l6qlbrwVMzLLw==
X-Received: by 2002:a05:600c:a011:b0:434:ffb2:f9df with SMTP id
 5b1f17b1804b1-4362aa40bbcmr121919135e9.17.1734363448675; 
 Mon, 16 Dec 2024 07:37:28 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436257178e3sm144517925e9.41.2024.12.16.07.37.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2024 07:37:28 -0800 (PST)
Message-ID: <7e07ef1e-4fa5-40d7-85f9-d7a199901b4f@linaro.org>
Date: Mon, 16 Dec 2024 16:37:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] s390x/pci: add support for guests that request
 direct mapping
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, schnelle@linux.ibm.com, thuth@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 clegoate@redhat.com, qemu-devel@nongnu.org
References: <20241213225440.571382-1-mjrosato@linux.ibm.com>
 <20241213225440.571382-2-mjrosato@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241213225440.571382-2-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Matthew,

On 13/12/24 23:54, Matthew Rosato wrote:
> When receiving a guest mpcifc(4) or mpcifc(6) instruction without the T
> bit set, treat this as a request to perform direct mapping instead of
> address translation.  In order to facilitate this, pin the entirety of
> guest memory into the host iommu.
> 
> Subsequent guest DMA operations are all expected to be of the format
> guest_phys+sdma, allowing them to be used as lookup into the host
> iommu table.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>   hw/s390x/s390-pci-bus.c         | 34 +++++++++++++++++++++++++++++++--
>   hw/s390x/s390-pci-inst.c        | 13 +++++++++++--
>   hw/s390x/s390-virtio-ccw.c      |  5 +++++
>   include/hw/s390x/s390-pci-bus.h |  4 ++++
>   4 files changed, 52 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
> index 40b2567aa7..95dbe0c984 100644
> --- a/hw/s390x/s390-pci-bus.c
> +++ b/hw/s390x/s390-pci-bus.c
> @@ -18,6 +18,7 @@
>   #include "hw/s390x/s390-pci-inst.h"
>   #include "hw/s390x/s390-pci-kvm.h"
>   #include "hw/s390x/s390-pci-vfio.h"
> +#include "hw/boards.h"
>   #include "hw/pci/pci_bus.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/pci/pci_bridge.h"
> @@ -720,16 +721,43 @@ void s390_pci_iommu_enable(S390PCIIOMMU *iommu)
>                                TYPE_S390_IOMMU_MEMORY_REGION, OBJECT(&iommu->mr),
>                                name, iommu->pal + 1);
>       iommu->enabled = true;
> +    iommu->direct_map = false;
>       memory_region_add_subregion(&iommu->mr, 0, MEMORY_REGION(&iommu->iommu_mr));
>       g_free(name);
>   }
>   
> +void s390_pci_iommu_dm_enable(S390PCIIOMMU *iommu)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +
> +    /*
> +     * For direct-mapping we must map the entire guest address space.  Rather
> +     * than using an iommu, create a memory region alias that maps GPA X to
> +     * iova X + SDMA.  VFIO will handle pinning via its memory listener.
> +     */
> +    g_autofree char *name = g_strdup_printf("iommu-dm-s390-%04x",
> +                                            iommu->pbdev->uid);
> +    memory_region_init_alias(&iommu->dm_mr, OBJECT(&iommu->mr), name, ms->ram,
> +                             0, ms->ram_size);

Is it a good idea to take the whole machine ram-size here?
Could it be better to pass it as qdev property?

> +    iommu->enabled = true;
> +    iommu->direct_map = true;
> +    memory_region_add_subregion(&iommu->mr, iommu->pbdev->zpci_fn.sdma,
> +                                &iommu->dm_mr);
> +}
> +
>   void s390_pci_iommu_disable(S390PCIIOMMU *iommu)
>   {
>       iommu->enabled = false;
>       g_hash_table_remove_all(iommu->iotlb);
> -    memory_region_del_subregion(&iommu->mr, MEMORY_REGION(&iommu->iommu_mr));
> -    object_unparent(OBJECT(&iommu->iommu_mr));
> +    if (iommu->direct_map) {
> +        memory_region_del_subregion(&iommu->mr, &iommu->dm_mr);
> +        iommu->direct_map = false;
> +        object_unparent(OBJECT(&iommu->dm_mr));
> +    } else {
> +        memory_region_del_subregion(&iommu->mr,
> +                                    MEMORY_REGION(&iommu->iommu_mr));
> +        object_unparent(OBJECT(&iommu->iommu_mr));
> +    }
>   }
>   
>   static void s390_pci_iommu_free(S390pciState *s, PCIBus *bus, int32_t devfn)
> @@ -1488,6 +1516,8 @@ static Property s390_pci_device_properties[] = {
>       DEFINE_PROP_BOOL("interpret", S390PCIBusDevice, interp, true),
>       DEFINE_PROP_BOOL("forwarding-assist", S390PCIBusDevice, forwarding_assist,
>                        true),
> +    DEFINE_PROP_BOOL("relaxed-translation", S390PCIBusDevice, rtr_allowed,
> +                     true),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index 41655082da..bb6f83b0c9 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -16,6 +16,7 @@
>   #include "exec/memory.h"
>   #include "qemu/error-report.h"
>   #include "sysemu/hw_accel.h"
> +#include "hw/boards.h"
>   #include "hw/pci/pci_device.h"
>   #include "hw/s390x/s390-pci-inst.h"
>   #include "hw/s390x/s390-pci-bus.h"
> @@ -1008,17 +1009,25 @@ static int reg_ioat(CPUS390XState *env, S390PCIBusDevice *pbdev, ZpciFib fib,
>       }
>   
>       /* currently we only support designation type 1 with translation */
> -    if (!(dt == ZPCI_IOTA_RTTO && t)) {
> +    if (t && !(dt == ZPCI_IOTA_RTTO)) {
>           error_report("unsupported ioat dt %d t %d", dt, t);
>           s390_program_interrupt(env, PGM_OPERAND, ra);
>           return -EINVAL;
> +    } else if (!t && !pbdev->rtr_allowed) {
> +        error_report("relaxed translation not allowed");
> +        s390_program_interrupt(env, PGM_OPERAND, ra);
> +        return -EINVAL;
>       }
>   
>       iommu->pba = pba;
>       iommu->pal = pal;
>       iommu->g_iota = g_iota;
>   
> -    s390_pci_iommu_enable(iommu);
> +    if (t) {
> +        s390_pci_iommu_enable(iommu);
> +    } else {
> +        s390_pci_iommu_dm_enable(iommu);
> +    }
>   
>       return 0;
>   }
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 67ae34aead..0334467371 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -865,8 +865,13 @@ static void ccw_machine_9_2_instance_options(MachineState *machine)
>   
>   static void ccw_machine_9_2_class_options(MachineClass *mc)
>   {
> +    static GlobalProperty compat[] = {
> +        { TYPE_S390_PCI_DEVICE, "relaxed-translation", "off", },
> +    };
> +
>       ccw_machine_10_0_class_options(mc);
>       compat_props_add(mc->compat_props, hw_compat_9_2, hw_compat_9_2_len);
> +    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
>   }
>   DEFINE_CCW_MACHINE(9, 2);
>   
> diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
> index 2c43ea123f..27732247cf 100644
> --- a/include/hw/s390x/s390-pci-bus.h
> +++ b/include/hw/s390x/s390-pci-bus.h
> @@ -277,7 +277,9 @@ struct S390PCIIOMMU {
>       AddressSpace as;
>       MemoryRegion mr;
>       IOMMUMemoryRegion iommu_mr;
> +    MemoryRegion dm_mr;
>       bool enabled;
> +    bool direct_map;
>       uint64_t g_iota;
>       uint64_t pba;
>       uint64_t pal;
> @@ -362,6 +364,7 @@ struct S390PCIBusDevice {
>       bool interp;
>       bool forwarding_assist;
>       bool aif;
> +    bool rtr_allowed;
>       QTAILQ_ENTRY(S390PCIBusDevice) link;
>   };
>   
> @@ -389,6 +392,7 @@ int pci_chsc_sei_nt2_have_event(void);
>   void s390_pci_sclp_configure(SCCB *sccb);
>   void s390_pci_sclp_deconfigure(SCCB *sccb);
>   void s390_pci_iommu_enable(S390PCIIOMMU *iommu);
> +void s390_pci_iommu_dm_enable(S390PCIIOMMU *iommu);
>   void s390_pci_iommu_disable(S390PCIIOMMU *iommu);
>   void s390_pci_generate_error_event(uint16_t pec, uint32_t fh, uint32_t fid,
>                                      uint64_t faddr, uint32_t e);


