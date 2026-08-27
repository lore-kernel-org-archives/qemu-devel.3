Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE07C61DC6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 11:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzYbL-0002qw-Iv; Thu, 27 Aug 2026 07:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzYbK-0002qY-GH
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 07:48:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzYbI-0002vs-Ni
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 07:48:58 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R9Gmca470809
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 11:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +2q8mqyy7nE8qe/hYW3htXuUCBRyV5gYP1oqhE7pMWU=; b=e8/NDXc807MkAgGf
 g0bu/RqYryifpjienYxQb8Y4MolnFhCPVI/HCrs/iJxDfPTT/4QKOaDSSkYEoNy3
 /r9Ybwo8GSFNdGjSBDZnIBk0xq/+9dIEMaCvCJaqjpOvx6P9MB9DO7TKCyC3D8ny
 HnznD/bhz4Sx86DK8k/ufgzFljNrdl04f7o106EW/fB3zSCrGAwMVnocY9u3iaUd
 DHoR9F6PYeBll8PAzASPOO3lR9hbV58XCi7CbAjCQhS1ISgyXoLR+OF2/EWH2Sz7
 ikvYNj+nX0BrFCTNIoVcqI1UALlGU/sntB8Oj1hGU8hwdQyT3vLRhnRkS0C5U9rC
 J22eGg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga8m5jjq6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 11:48:55 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e538afe65so79184185a.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 04:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787831334; x=1788436134; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+2q8mqyy7nE8qe/hYW3htXuUCBRyV5gYP1oqhE7pMWU=;
 b=SqpEE9vnM4gglnYBv7YbqQ/tfIcB8Lf+0cz0yFljDj6lyvo4e+4jc/xcmh/qIl3jRd
 CH7DYWLACMT0tjg1UmtZK2RVb2kohDr6BbgC6NSx0sSD2SL1FMxoG7O9Qy9y9LTQKSwa
 SwMmYOGaHBUZ1y5Ctev4FwoutXNvKiNIOCKhQx1geLFcc2CvWtpQ2tU/87kVxzn77MAF
 VhVQNf/ZHA0+DMZr1ecMtpg0hrMHpgLXcgYNzHIkpbtd0+uXTcevc1JGJp+S0nUZ6yF6
 GQyFFYmNnHEVdNQPPfZcghSSA9hQwMFoUg9tsZuwDHR22mvsP1ZvHUSOGSOte2dm+Zsu
 9LQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787831334; x=1788436134;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+2q8mqyy7nE8qe/hYW3htXuUCBRyV5gYP1oqhE7pMWU=;
 b=IXhWNygI89dM3FrIjFaqN9yfsTdqaCSELc2tZYFWumbAeCpQwc7I2mwSF/z8wYSame
 lh532gajonYC0KZnD12PxmU0Dqb8lKDsjgBjcueTGAQmpmxl7esXeJdQhiJYNUbQW0Uy
 oHQKeSiAiD76nHN7yLGaWDJy4KjKBNkLcMvrPCKzNKJjrV6ywnWSx3EArToE63pKjsbv
 z7rrpMIpA/HtnXLxg6DfH7P1drTJ7GlffmSclbdH9Q2wCSP50bYYVb8aVO5hGk9fk7zV
 m5SRy+t75lHvoNGiZGQ7wbRza39aYN9XtpfKuKOwWZxRX3V0J23O7ma5B6Qek5vPZ9ov
 9v0Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqFCIfPo1BD0xz6UbC/o/0EbKjbn+yHVAemVUX+LMS5eMHVFpQpS7wZS1Tq1kn4IJZxqhrQDEXMIWL7@nongnu.org
X-Gm-Message-State: AFuF++nkJwb76RzmGLAEeAkuygh4/zyOHGpCRzPUldCCHHa3F8avtqGZ
 Ql6cXJsoQEUPOrR8G72iRbHnY8T4Dlav7RAZ5vOf7pr6ip2lJIflJiJyjng/Cp0O7UfFHtsuTAp
 O+0T0tlgo0NinHICVlxvuzZW3nIVBM6PuE+5MN78VnznoIna0f8E/g955vA==
X-Gm-Gg: AR+sD11AxrB1St/LvWYDE8f8FF00V1o4xLm8C2ZZUdWbatc8Z7Eni/VGZ44GRsSRvai
 09AFg6HsJj0cYXAlc37a/nPKpuuvOLPxRvnekvdWiZDVvCBojidx/APTRiZ0g6/ycxd5UgNYaUa
 B848Sh+4Ajzo7fE8u2aBc6ioqStUG1MFZOi07MRb/OH75+GaJzGWh+y7Kt1C+NhMFOLFT/tFCZa
 F/p8WGxONFjPP6+v1ar7mKjuy4GmEvumwEXzgMclnDNdalrsakVsHF2NR7uureqkJ4IfRPCx/ne
 6hbzxNJp6I06DYu/X6sNvpRr40iC9hgGfn6yQr8z1bh8iyHv/5KHGuD8/6a7QDdKsFSb1Lk6pWs
 ZH0MOWNIZvZWToRFcv7Gj69rF0kr1X6BemSKf
X-Received: by 2002:a05:620a:8ac9:b0:92e:76a1:96cd with SMTP id
 af79cd13be357-93780165715mr1051307685a.13.1787831334269; 
 Thu, 27 Aug 2026 04:48:54 -0700 (PDT)
X-Received: by 2002:a05:620a:8ac9:b0:92e:76a1:96cd with SMTP id
 af79cd13be357-93780165715mr1051304385a.13.1787831333826; 
 Thu, 27 Aug 2026 04:48:53 -0700 (PDT)
Received: from [192.168.68.100] ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9377e615a51sm423061085a.24.2026.08.27.04.48.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 04:48:53 -0700 (PDT)
Message-ID: <4450441d-1afb-41cd-aca8-abd3a1c34b82@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 08:48:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/16] hw/riscv/atlantis: Use local reference for system
 memory
To: Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260826220528.54516-1-joel@jms.id.au>
 <20260826221154.54577-1-joel@jms.id.au>
 <20260826221154.54577-3-joel@jms.id.au>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260826221154.54577-3-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: py2oDqF9qliLaJnFkhyjbj1rz9Xp6R4R
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA5OCBTYWx0ZWRfX/AHPEOE6jFkw
 yDLsG4x/2Tz71DpLrqQ8WaPvLuJ2ml9ThbM+DCgT+wdgCUpbCuiKv549xEQ1dhTEbxmqEZypdIx
 Z66w6jbG2ZJ1UWykc0hL+WcNPQLLPI4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA5OCBTYWx0ZWRfX772714Z/HMZn
 PQoAtpe9q7upkypreQpRNSxKUXDSroxziox8eWDup88t+trU1Cko+xDb9ANWOcqXssNpmTsdx9Q
 NBNE2vdBit59StZRRrB2JSToSWHwYq6P8YCyTsHLJ+AjwTQfaNf1FvKb30rLoSFVca5dDx+YYlm
 iJ2Eyj8IVtJSPQhSnzK9JScJkEFnLVkyFw+HNDRf+bFkk+7cdTi7GKJKL0KekFX3SbjRUNUfBJz
 0h6ZApFL66KYy9k2GKJBwlUvga4HuDbSk5zGF2edTylfo2jRgVgMxaVu8oswQOYe2+4xMoIR+XN
 GZaMeBI2qP+gmXzp6h8dh8LqmxnQW/mm90vd5vN6P3SNlkMN5tdhZmrJyt6uGZ9l7SPU93uMIYu
 dPI8idoASDlAkSbvg/ScvYjD/pmCecKiGPEwmbndxcRmtZhQ9Q+qQ0zor66HwJiTi9iT3Wz6K7n
 eBV43R7DdsIFMM/PWiQ==
X-Proofpoint-GUID: py2oDqF9qliLaJnFkhyjbj1rz9Xp6R4R
X-Authority-Analysis: v=2.4 cv=SomgLvO0 c=1 sm=1 tr=0 ts=6a902427 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=xQOczflb7_0DwEsGZi4A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270098
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 8/26/2026 7:11 PM, Joel Stanley wrote:
> Instead of system_memory, attach devices to TTAtlantisState::memory in
> preparation for the ->memory becoming a container.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   include/hw/riscv/tt_atlantis.h |  1 +
>   hw/riscv/tt_atlantis.c         | 19 ++++++++++---------
>   2 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
> index 642490d21743..a29c67c1cfcf 100644
> --- a/include/hw/riscv/tt_atlantis.h
> +++ b/include/hw/riscv/tt_atlantis.h
> @@ -29,6 +29,7 @@ struct TTAtlantisState {
>       Notifier machine_done;
>       const MemMapEntry *memmap;
>   
> +    MemoryRegion *memory;
>       RISCVHartArrayState cpus;
>       DeviceState *irqchip;
>       DesignWareI2CState i2c[TT_ATL_NUM_I2C];
> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> index c471c7cebf12..1c75fb5d8d57 100644
> --- a/hw/riscv/tt_atlantis.c
> +++ b/hw/riscv/tt_atlantis.c
> @@ -482,13 +482,14 @@ static void tt_atlantis_machine_init(MachineState *machine)
>   {
>       TTAtlantisState *s = TT_ATLANTIS_MACHINE(machine);
>   
> -    MemoryRegion *system_memory = get_system_memory();
>       MemoryRegion *ram_hi = g_new(MemoryRegion, 1);
>       MemoryRegion *ram_lo = g_new(MemoryRegion, 1);
>       MemoryRegion *bootrom = g_new(MemoryRegion, 1);
>       ram_addr_t lo_ram_size;
>       int hart_count = machine->smp.cpus;
>   
> +    s->memory = get_system_memory();
> +
>       s->memmap = tt_atlantis_memmap;
>   
>       object_initialize_child(OBJECT(machine), "soc", &s->cpus,
> @@ -504,7 +505,7 @@ static void tt_atlantis_machine_init(MachineState *machine)
>                               &error_abort);
>       sysbus_realize(SYS_BUS_DEVICE(&s->cpus), &error_fatal);
>   
> -    s->irqchip = riscv_create_aia(system_memory,
> +    s->irqchip = riscv_create_aia(s->memory,
>                                     true, TT_IMSIC_GUESTS,
>                                     TT_IMSIC_STRIDE,
>                                     TT_IMSIC_STRIDE,
> @@ -517,7 +518,7 @@ static void tt_atlantis_machine_init(MachineState *machine)
>                                     TT_IRQCHIP_NUM_MSIS,
>                                     TT_IRQCHIP_NUM_PRIO_BITS);
>   
> -    riscv_aclint_mtimer_create(system_memory,
> +    riscv_aclint_mtimer_create(s->memory,
>               s->memmap[TT_ATL_ACLINT].base,
>               TT_ACLINT_MTIME_SIZE,
>               0, hart_count,
> @@ -540,23 +541,23 @@ static void tt_atlantis_machine_init(MachineState *machine)
>   
>       memory_region_init_alias(ram_hi, OBJECT(machine), "ram.high", machine->ram,
>                                0, machine->ram_size);
> -    memory_region_add_subregion(system_memory,
> +    memory_region_add_subregion(s->memory,
>                                   s->memmap[TT_ATL_DDR_HI].base, ram_hi);
>   
>       lo_ram_size = MIN(machine->ram_size, s->memmap[TT_ATL_DDR_LO].size);
>       memory_region_init_alias(ram_lo, OBJECT(machine), "ram.low", machine->ram,
>                                0, lo_ram_size);
> -    memory_region_add_subregion(system_memory,
> +    memory_region_add_subregion(s->memory,
>                                   s->memmap[TT_ATL_DDR_LO].base, ram_lo);
>   
>       /* Boot ROM */
>       memory_region_init_rom(bootrom, NULL, "tt-atlantis.bootrom",
>                              s->memmap[TT_ATL_BOOTROM].size, &error_fatal);
> -    memory_region_add_subregion(system_memory, s->memmap[TT_ATL_BOOTROM].base,
> +    memory_region_add_subregion(s->memory, s->memmap[TT_ATL_BOOTROM].base,
>                                   bootrom);
>   
>       /* UART1, the soc console (UART0 is for the boot microcontroller) */
> -    serial_mm_init(system_memory, s->memmap[TT_ATL_UART1].base, 2,
> +    serial_mm_init(s->memory, s->memmap[TT_ATL_UART1].base, 2,
>                      qdev_get_gpio_in(s->irqchip, TT_ATL_UART1_IRQ),
>                      115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
>       /*
> @@ -570,7 +571,7 @@ static void tt_atlantis_machine_init(MachineState *machine)
>        */
>       object_initialize_child(OBJECT(s), "uart1", &s->uart1,
>                               TYPE_UNIMPLEMENTED_DEVICE);
> -    mmio_map_unimplemented(system_memory, SYS_BUS_DEVICE(&s->uart1),
> +    mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->uart1),
>                              "tt-atlantis.uart1", s->memmap[TT_ATL_UART1].base,
>                              s->memmap[TT_ATL_UART1].size);
>   
> @@ -582,7 +583,7 @@ static void tt_atlantis_machine_init(MachineState *machine)
>                                   TYPE_DESIGNWARE_I2C);
>           sbd = SYS_BUS_DEVICE(&s->i2c[i]);
>           sysbus_realize(sbd, &error_fatal);
> -        memory_region_add_subregion(system_memory,
> +        memory_region_add_subregion(s->memory,
>                                       s->memmap[TT_ATL_I2C0 + i].base,
>                                       sysbus_mmio_get_region(sbd, 0));
>           sysbus_connect_irq(sbd, 0,


