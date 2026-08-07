Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713A2C5AC9E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 10:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsIHn-0007T8-Jb; Fri, 07 Aug 2026 06:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsIHl-0007SX-Pn
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 06:58:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wsIHj-0005LN-2Y
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 06:58:45 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6778GNT0493694
 for <qemu-devel@nongnu.org>; Fri, 7 Aug 2026 10:58:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LKeFH7l4roclCRQb+hSYR6sn6kOTyn2aH2mp59hOcYc=; b=Sqd0YNEeRkLBVN6n
 nNlsc01Q/D/DKLhMLGTFwsCyxGhGRuWrodyuvfdleLY55WHOLQ9+MrJjuP6XWxdw
 9RB7Oet6bPXWxHE2NwAN9cmVS9J6yhDlTzx3iwr66NmiOs0LJnSoH9KQ/YSUkbda
 VJQmMO6YkKVWZ4RHJXesGbS+W30SZZlheFM+TmGrR79gQRUXKFrGPZ2K1ndq3YJF
 qQrfS1XVo7E3u7WmUgD/LqhbbSdRzO34b4H7OIut+Z/azJJf3EM5UFeSq03iGiTO
 YlMhSEIBFe+nSevdtZdN94vdnopv1Y8eAmx0F1UOOJZtznWr8ytWJexDaCWgUw4R
 5tVy4w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6rbg1k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 10:58:41 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9309af14fd7so310218485a.1
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2026 03:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786100320; x=1786705120; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LKeFH7l4roclCRQb+hSYR6sn6kOTyn2aH2mp59hOcYc=;
 b=OFu8hqmV5sMQBLD63uAQTYmT5i4fGwHdNQnWYC7rGz8ImLUFzwEWUZuwYpTE4bJijB
 I+x0EYkBc/0bXEvO9g/suguTWUGHT6KadjP+EJ3cHFdw8ZUBg57In1FpBLI8+7pCPakn
 VbOstBZVfm5gNfqXlUEwV7p+kYeES9fQxGxjRVzv28h5D7GK8tnT9FgBU9zIrGJ2t8/8
 Xy5bKl25i1IkNNd32Vldla7aWeK3crIenmn0nzzqTNOEJ8HdO5D3YSuIblSWaLFiNOdP
 i6oOwZA7YoSgWM6xKANnAFz/XZ8MmOnL0Rbgwj2p4ux/BIfMRpDiEgysjn0skWtSoksb
 8EeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786100320; x=1786705120;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LKeFH7l4roclCRQb+hSYR6sn6kOTyn2aH2mp59hOcYc=;
 b=S1iUEZGpt/XsXihBPLHhRf5KEb9z3ssuu91yP1wQwW1Sht/ZQ9DyYtsK8X9fYrwB0f
 8lgUnvJe0RDm/RWSeqlxgOv5+mwiEy7MMcmGE/Ac0epTf1s8E16vkf7cpSTcBHNE+yJ+
 gQ7IH12QRvTD3gUnX5vd5jifKmOiyN5Lx3nWctcBRBqN9uL3I9zfDg3DJpyKZk708wEy
 vN5Q+wi9KMamUvkOYm91mgug52SFqS30XV2alzUMyA67VDJzLf4LB9K/osobRB+YG7YI
 AHu98YWRF7bcAxtHlT1x1XNFQpEEjMZQmR5C+jmv/spWghfJJ4rpPi4+TL/zZ7f3IpO8
 r98Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoIGIytt5qfa4oShxYwjMSjKNPM99PMKZ8va0gxQCQIx5W0NBmBAfDq65suXxOHyozhD+oq+1azlNRD@nongnu.org
X-Gm-Message-State: AOJu0Yy553xWUOdHtsP/NXSizQ1Vr0a/SV3l4A9UuQpdhHDc2o2iEtHf
 G2DalFaK/REHJB1N6qHKBUd86YrDruppx51rMUXpyTWFgbVHr8d3Zah+trpq+Vj+fci2XBSRgfu
 cXJ7IRhmQpWOXbIjPngA/Fog2ZogXt4QwwT2sc9HDGWxeIBagbla1w4tz1Q==
X-Gm-Gg: AR+sD13MmzEilOVtgCBsziRc21/2hZNJUSsLwGIi3bWZXriZIWZ8PMPdHcjIVaHuYMe
 VeZr7FrJNeuWeOcaskS39KNQgFzoCPDxnloeWQzvo6aVC1jUmx7FeOIJFZf0tkldpXTt69KaZiW
 2oloM1lxT7kI9ZWxh0BTOG6blFU20NXYbaBXKSA8qrOSvYDG46+4WpQdcAqOiQPV7Q8YYqstQ44
 yAi7vIHSV7KBXrNVpU+3+HIZyig+xGciKp7DUxJT+DynSJujkAPnnzTTXqaOQmPjpVrLkkzd9ms
 uylYSLsOkP2Tup+ipD5Yp0wqRafxCkUSU9PfAnFgs4c874b3LX93Dp1pd9oyfaHymYXYbJDf/c2
 tV6o25G2koAolf2ZlCfickGFIK5wNlrVGO6IF
X-Received: by 2002:a05:620a:a408:20b0:92e:57ae:3a53 with SMTP id
 af79cd13be357-9364909fbdfmr1795646985a.9.1786100320111; 
 Fri, 07 Aug 2026 03:58:40 -0700 (PDT)
X-Received: by 2002:a05:620a:a408:20b0:92e:57ae:3a53 with SMTP id
 af79cd13be357-9364909fbdfmr1795641985a.9.1786100319326; 
 Fri, 07 Aug 2026 03:58:39 -0700 (PDT)
Received: from [192.168.68.104] ([187.11.154.152])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9366e22c446sm120555785a.30.2026.08.07.03.58.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2026 03:58:38 -0700 (PDT)
Message-ID: <4d207ce9-3f27-478a-a102-000ee257f691@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 07:58:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] hw/riscv: enable SDHCI controllers on K230
To: Xin Xie <xinxie908@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>
References: <20260729105904.272939-1-xinxie908@gmail.com>
 <20260729105904.272939-3-xinxie908@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260729105904.272939-3-xinxie908@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA4NCBTYWx0ZWRfX5hOb7Lw/+XMR
 uO+hnpoErrIskgV1FWYpQFoDpNEsDddmOmeG3QRMhQU/SD2i7uG1qD4iXlLTLEl6xdSYZKnp+Ew
 NdeXmmdXJFfyQPxTq6hfHjmh3OtzVzPq8dSkIAF/36e9cZ097LK8oi1I8i6aD533CEV306Is5wo
 eTXRQH/kc83zMpJ+0+T4QXP4hScjmB1FPv81XwzZuRopk5hcjH22war8VWT9xD6IJ8NX7sEA1qP
 ZPkBEV3Nkv8HQeTnmVZ0/PKYOg0frK9PPA7Bf3UpN4Mp9LGT9DCKIsHi9xZPBjJ4BWHR7xOA9rc
 BhikKfqpR9sLs9y9ys4Nw/0fMc2v1VWgKoANFkoPgMbXZUmaM6iiz+oZqLhPeAvK74lrLAERbzW
 3rgvL74BD+bw3Tm57Y7tZjOWXSF9iS6Dh3dYL++UMn2xWMPA8eTaNKAe8/hQYKsZuwr3zUInYfP
 /ZqiYMuVi8fFnwY2Z8w==
X-Authority-Analysis: v=2.4 cv=HPXz0Itv c=1 sm=1 tr=0 ts=6a75ba61 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=iMfxv9gflPUPBcmW7/Gq5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=8sA-0N0JoZ-HhiopEfAA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: lStL2RNq-tKbKvvEj5iZRVeUO8208zL4
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA4NCBTYWx0ZWRfXxuYNa1p0BeZK
 WtadjZSWExFm8M3t9TJuOgUlfCgPi+rnQT/vAvkl8MN/14XPuNZRVng3K3g66vFMb6/fE6PmxXv
 OHRlWsJP53TOXpJDJCmzeOeMcP4i+qA=
X-Proofpoint-GUID: lStL2RNq-tKbKvvEj5iZRVeUO8208zL4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070084
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 7/29/2026 7:59 AM, Xin Xie wrote:
> Replace the two unimplemented K230 SD controller regions with K230 SDHCI
> devices.  Map them at 0x91580000 and 0x91581000 and connect their
> interrupts to PLIC inputs 142 and 144 respectively.
> 
> Create an SD card on each controller when a corresponding
> -drive if=sd,index=N backend is provided.
> 
> Update the K230 machine documentation to list the controllers as
> supported and remove the instructions that disabled the SDHCI device
> tree nodes before booting Linux.
> 
> Signed-off-by: Xin Xie <xinxie908@gmail.com>
> ---
>   docs/system/riscv/k230.rst |  6 ++----
>   hw/riscv/Kconfig           |  1 +
>   hw/riscv/k230.c            | 34 ++++++++++++++++++++++++++++++----
>   include/hw/riscv/k230.h    |  4 ++++
>   4 files changed, 37 insertions(+), 8 deletions(-)
> 
> diff --git a/docs/system/riscv/k230.rst b/docs/system/riscv/k230.rst
> index cea8202e55..6e8286a0df 100644
> --- a/docs/system/riscv/k230.rst
> +++ b/docs/system/riscv/k230.rst
> @@ -20,6 +20,7 @@ The ``k230`` machine supports the following devices:
>   * Platform-Level Interrupt Controller (PLIC)
>   * 2 K230 Watchdog Timer
>   * 5 UART
> +* 2 SDHCI controllers
>   
>   Boot options
>   ------------
> @@ -100,14 +101,11 @@ Press Enter to stop autoboot. At the U-Boot prompt, run these commands:
>      K230# fdt resize 8192
>      K230# fdt set /chosen linux,initrd-start <0x0 0xa100000>
>      K230# fdt set /chosen linux,initrd-end <0x0 ${INITRD_END}>
> -   K230# fdt set /soc/sdhci0@91580000 status disabled
> -   K230# fdt set /soc/sdhci1@91581000 status disabled
>      K230# bootm 0xc100000 - 0xa000000
>   
>   Use ``setenv`` so ``bootm`` writes the kernel command line into
>   ``/chosen/bootargs``. The ``fdt`` commands select the loaded DTB, add space for
> -edits, describe the initrd range in ``/chosen``, and disable SDHCI nodes because
> -this machine does not emulate those controllers yet. Replace ``${INITRD_END}``
> +edits, and describe the initrd range in ``/chosen``. Replace ``${INITRD_END}``
>   with the host-calculated value above when typing the command. ``cma=0`` avoids
>   the SDK kernel reserving too much of the little-core memory window for initramfs
>   boot.
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index de37c08cae..e4a0616c16 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -162,3 +162,4 @@ config K230
>       select SERIAL_MM
>       select UNIMP
>       select K230_WDT
> +    select K230_SDHCI
> diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
> index 656f28190c..7ea69084ae 100644
> --- a/hw/riscv/k230.c
> +++ b/hw/riscv/k230.c
> @@ -110,6 +110,8 @@ static void k230_soc_init(Object *obj)
>       object_initialize_child(obj, "c908-cpu", cpu0, TYPE_RISCV_HART_ARRAY);
>       object_initialize_child(obj, "k230-wdt0", &s->wdt[0], TYPE_K230_WDT);
>       object_initialize_child(obj, "k230-wdt1", &s->wdt[1], TYPE_K230_WDT);
> +    object_initialize_child(obj, "sdhci0", &s->sdhci[0], TYPE_K230_SDHCI);
> +    object_initialize_child(obj, "sdhci1", &s->sdhci[1], TYPE_K230_SDHCI);
>   
>       qdev_prop_set_uint32(DEVICE(cpu0), "hartid-base", 0);
>       qdev_prop_set_string(DEVICE(cpu0), "cpu-type", TYPE_RISCV_CPU_THEAD_C908);
> @@ -343,11 +345,21 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
>       create_unimplemented_device("usb1", memmap[K230_DEV_USB1].base,
>                                   memmap[K230_DEV_USB1].size);
>   
> -    create_unimplemented_device("sd0", memmap[K230_DEV_SD0].base,
> -                                memmap[K230_DEV_SD0].size);
> +    for (int i = 0; i < 2; i++) {
> +        if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhci[i]), errp)) {
> +            return;
> +        }
> +    }
> +
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci[0]), 0,
> +                    memmap[K230_DEV_SD0].base);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci[0]), 0,
> +                       qdev_get_gpio_in(s->c908_plic, K230_SD0_IRQ));
>   
> -    create_unimplemented_device("sd1", memmap[K230_DEV_SD1].base,
> -                                memmap[K230_DEV_SD1].size);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sdhci[1]), 0,
> +                    memmap[K230_DEV_SD1].base);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci[1]), 0,
> +                       qdev_get_gpio_in(s->c908_plic, K230_SD1_IRQ));
>   
>       create_unimplemented_device("qspi0", memmap[K230_DEV_QSPI0].base,
>                                   memmap[K230_DEV_QSPI0].size);
> @@ -490,6 +502,20 @@ static void k230_machine_init(MachineState *machine)
>                               TYPE_RISCV_K230_SOC);
>       qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
>   
> +    for (int i = 0; i < 2; i++) {
> +        DriveInfo *dinfo = drive_get(IF_SD, 0, i);
> +        DeviceState *card;
> +
> +        if (!dinfo) {
> +            continue;
> +        }
> +
> +        card = qdev_new(TYPE_SD_CARD);
> +        qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
> +                                &error_fatal);
> +        qdev_realize_and_unref(card, s->soc.sdhci[i].bus, &error_fatal);
> +    }

I think this should be done in k230_soc_realize() together with the realize()
step of the other parts of the soc.


LGTM otherwise.  Thanks,

Daniel


> +
>       /* Data Memory */
>       memory_region_add_subregion(sys_mem, memmap[K230_DEV_DDRC].base,
>                                   machine->ram);
> diff --git a/include/hw/riscv/k230.h b/include/hw/riscv/k230.h
> index 592e1c26bf..8e73366e56 100644
> --- a/include/hw/riscv/k230.h
> +++ b/include/hw/riscv/k230.h
> @@ -18,6 +18,7 @@
>   #include "hw/core/boards.h"
>   #include "hw/riscv/riscv_hart.h"
>   #include "hw/watchdog/k230_wdt.h"
> +#include "hw/sd/k230_sdhci.h"
>   
>   #define C908_CPU_HARTID   (0)
>   
> @@ -33,6 +34,7 @@ typedef struct K230SoCState {
>       RISCVHartArrayState c908_cpu; /* Small core */
>   
>       K230WdtState wdt[2];
> +    K230SDHCIState sdhci[2];
>       MemoryRegion sram;
>       MemoryRegion bootrom;
>   
> @@ -129,6 +131,8 @@ enum {
>       K230_UART4_IRQ  = 20,
>       K230_WDT0_IRQ   = 107,
>       K230_WDT1_IRQ   = 108,
> +    K230_SD0_IRQ    = 142,
> +    K230_SD1_IRQ    = 144,
>   };
>   
>   #define K230_UART_COUNT 5


