Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D41C61DC6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 12:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzZ4V-0003Oj-9W; Thu, 27 Aug 2026 08:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzZ4U-0003NK-1I
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 08:19:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzZ4R-0001wp-FO
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 08:19:05 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RCBpnX2844329
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 12:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JFMi+7JgzSwnena1a0hVGa3E8hg37BBeOFX9IfXXcYE=; b=Sa4TC7Ubwp47chGs
 uWG8O/Yn9L3lBy1o6rnGucZKcYJB0jZ1BHYaay4j9GUnxsCG3tSxJTyrfpuj1RBz
 OYpuqs7w5Pd+Mp/NGUnG8txUD4hXUJNxxi5WPfbbestnPr0KZQlj1pdcnKAFdjFc
 mlrcERl2QlwnRgEi6FuTIsEvVLoG0RPcXY1+aTNnGbl7yuAsvKYYdFfrBfytKEvu
 ga5+FQjVO2s/FC2964a3vqzu4+DGUkThV3ZaBIHCuK83YoSbpEwWGg0xKlyYWP5q
 C6B/u0YqJrEvhcI+bXVLXjIXrEeZRlM4PrK7Q5UzCYMvw073abzag0DWv5VJg+8v
 uJZ+ew==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gaa3bjf1h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 12:19:01 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c01ff996dso20257881cf.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 05:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787833141; x=1788437941; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JFMi+7JgzSwnena1a0hVGa3E8hg37BBeOFX9IfXXcYE=;
 b=hwljxNU9fRFnU+kMyJmKfIjyc9KRIz172OemSt6L9myUiFeCzgmF4p1zKjtOq3V9UM
 O+kPpvwFM3WgzUC/LnSmQWwfsMJNUGamu0men6iVDm9VYkK+/iQqpN/M1/zpJO1LkHp7
 IRzzoIC8RP1BzoDtBM873IyAIGz5B998Ys9Xk62Z8MmBlDu24nf5vsiLcme49kkMpu/n
 ig/+aesDVedeAxawHz7WJNl2E0bVpHHQ1v3Vegdm99Ux5wfactIBet8vF/KApY/6vy+W
 uurOeTRbhq8DLjOZP0wjbcplLNOiIxWVOrZ673t0newhFJRJXhUtw1cBJFuBB7os7T/o
 EqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787833141; x=1788437941;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JFMi+7JgzSwnena1a0hVGa3E8hg37BBeOFX9IfXXcYE=;
 b=XZXG/WhpKsMoO+oD1u74kHZabN7vLtRDClCaqPcIyrne/s58g7R1NATuGJF3Ixey3S
 f9J1Yq0M26OXsa0+HPH5XIcgJtBcJvH+4rLpvFVWqJrduUHbPp2svotvUJvVwxPhrhdB
 8Ib7aMeBQ8cih5oIN0Gcalroydr/pXVb3PSAOh5n+41Rg/JvVy/KwHcJxg3uC96DgYhY
 GPGiKvKy0Pi3yRGWvEZGFKQSjujkW6lQqdxG3XIClqH3uSlPCkYgw0BZV/buUIgTCZMA
 xn5xlQoql7vAEhI77X9dopJT3yuRvl4ZT84jKnV7iZfxWhAV9kAI/HHPmjmUiEHEU6tp
 ORIQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoBsQWLpyaibbwHeVr73DFm7xseqEae63JBzTOK+EUDXpKvO4KmC6j4mVejn4mqjIrTuSFuJV1V+1Ui@nongnu.org
X-Gm-Message-State: AFuF++nLa604LM5cGdug0MnX0fCXoc14QW4CfQfiSdQOYGQDlqPcljq6
 ++C/2y/fLFB31hymFK60ODl7V0TrcCPedTeWIe/dBUFjksMLV+mlfLd85lXIhKJdlK8gPXsV6A3
 xR4Mm6MyPNKkpFkyfkSvGCZx5x9VJ94r+dGUtPjGE8xWtzzvCuitf6XV21Q==
X-Gm-Gg: AR+sD12+eRtVHj8nyYoJmu+Pjl7YP+o8rXCaPqqJMCtCSLHa7EYZAWJ3rpVxcMwSXiJ
 JTjqdCq6m2Z6BFlPW5pg+NsWcVq/HBKvTPLxcp1uxwU1YlDbeyPW+P+akDQ9JKTbZVj3CgiuH3l
 3rFX2HQ/ZLWFdUKLLzn53WycxUJw0Glzi0Q+uvi9yGIM4/20W8cXx7pvU49duRtGA9biAEa0b/y
 hqySBaKZ/Ev6eIziIpNHtuY7gmkCam5sJClbb/a+71Au6UIzhOHPQfW2GBMZkb/E/Wb8tUkcdJj
 kc5Q2dK7Pgl5fdUArkr/t4U12W1+eRq52pD3gujS9ieKPXCrKWFqnWMdjb45lrtsLC7UHXD0vR5
 aoiIwVq9tJC9tqixe+9/s6TXjxrTFbVz5op5b
X-Received: by 2002:a05:622a:110f:b0:519:8998:661b with SMTP id
 d75a77b69052e-52e423226edmr142746041cf.20.1787833140800; 
 Thu, 27 Aug 2026 05:19:00 -0700 (PDT)
X-Received: by 2002:a05:622a:110f:b0:519:8998:661b with SMTP id
 d75a77b69052e-52e423226edmr142745051cf.20.1787833140149; 
 Thu, 27 Aug 2026 05:19:00 -0700 (PDT)
Received: from [192.168.68.100] ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52fa1767dd1sm17423981cf.18.2026.08.27.05.18.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 05:18:59 -0700 (PDT)
Message-ID: <a862af6d-2aba-4d02-b59b-13f7c9ab63f1@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 09:18:55 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/16] hw/riscv/atlantis: Extract an Atlantis SoC device
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
 <20260826221154.54577-7-joel@jms.id.au>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260826221154.54577-7-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEwMSBTYWx0ZWRfX/54v8PoYdkC+
 osDJEje2UJmUtnYVF98XWucZACPEkhxGlPlP1ahVmFmH+k8NM/ZXSsdalxBAzKmzujUkPFZqcs7
 VaUiXNeICHaIM0sH29JPjnIz07H15oQxHD6cQ3XyAOCagtO8xKxlt73L3gEua4kJnizWOAs0WUL
 Ck1EMERDIQfGw1cFqMif1CUq/r6CZY9uPe07sxUCWOg7A1LQYe4uEe8d/vhU0wxcOfPtuyHacmO
 sb18Jy1TkyCUAnY7H+j0buLOTwKprvPL5Oi+hUhk8p4VOz/9xDtJMouMP1OmMvuMoX6XZaIJuyz
 B4HckNjaLk+a9dSW2hXsu3NSAaoWIJbroIidCN6YMNnVShyFlOiKXLscr7HgyVSxo2qYhnw5Yzf
 vv77sev27jNzpIoeGOo4Cllh4Peu7ALeoTvtnxQ/3E94YiiNU23Li84bonES6rX24Zg8ReHeSnX
 PIphAGmk8pZnsYnpZ8w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEwMSBTYWx0ZWRfX8sKhwM8ytbG/
 KbhUGHr1L9hfHyO2CrwoU62pl9qFvoBessS5fBfwRHSiYMpAOpm0HcC1Jp5fWr593d2zo6kR8X9
 QCjo5NeVe0ipyIVZ/1j7TDNUjTlwHek=
X-Proofpoint-ORIG-GUID: rfqQDQWVuygpfH7E2y0JX5AMD1pG8ACx
X-Proofpoint-GUID: rfqQDQWVuygpfH7E2y0JX5AMD1pG8ACx
X-Authority-Analysis: v=2.4 cv=KbfidwYD c=1 sm=1 tr=0 ts=6a902b35 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=_f1kACbcqhFVB4uvHaMA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270101
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
> Introduce TYPE_TT_ATLANTIS_SOC and move the hart array, AIA, ACLINT,
> boot ROM, UART and I2C controllers into the new TTAtlantisSoCState. The
> machine keeps ownership of RAM, device tree generation, firmware
> loading, and the board-level I2C slaves.
> 
> This makes it easier to compose the SoC into a more complex machine in
> the future.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   include/hw/riscv/tt_atlantis.h |  21 ++++-
>   hw/riscv/tt_atlantis.c         | 144 +++++++++++++++++++++++----------
>   2 files changed, 119 insertions(+), 46 deletions(-)
> 
> diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
> index 9ca98bfb8478..5d4e4d133bd9 100644
> --- a/include/hw/riscv/tt_atlantis.h
> +++ b/include/hw/riscv/tt_atlantis.h
> @@ -19,14 +19,16 @@
>   #define TYPE_TT_ATLANTIS_MACHINE MACHINE_TYPE_NAME("tt-atlantis")
>   OBJECT_DECLARE_SIMPLE_TYPE(TTAtlantisState, TT_ATLANTIS_MACHINE)
>   
> +#define TYPE_TT_ATLANTIS_SOC "tt-atlantis-soc"
> +OBJECT_DECLARE_SIMPLE_TYPE(TTAtlantisSoCState, TT_ATLANTIS_SOC)
> +
>   #define TT_ATL_NUM_I2C 5
>   
> -struct TTAtlantisState {
> +struct TTAtlantisSoCState {
>       /*< private >*/
> -    MachineState parent;
> +    DeviceState parent;
>   
>       /*< public >*/
> -    Notifier machine_done;
>       const MemMapEntry *memmap;
>   
>       MemoryRegion *memory;
> @@ -39,6 +41,19 @@ struct TTAtlantisState {
>       DesignWareI2CState i2c[TT_ATL_NUM_I2C];
>       UnimplementedDeviceState uart1;
>       MemoryRegion bootrom;
> +
> +    uint32_t num_harts;
> +    char *cpu_type;
> +};
> +
> +struct TTAtlantisState {
> +    /*< private >*/
> +    MachineState parent;
> +
> +    /*< public >*/
> +    Notifier machine_done;
> +
> +    TTAtlantisSoCState soc;
>   };
>   
>   enum {
> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> index b80bdf54c40b..d2b29ff1a477 100644
> --- a/hw/riscv/tt_atlantis.c
> +++ b/hw/riscv/tt_atlantis.c
> @@ -7,6 +7,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qapi/error.h"
>   #include "qemu/cutils.h"
>   #include "qemu/error-report.h"
>   #include "qemu/guest-random.h"
> @@ -14,6 +15,7 @@
>   
>   #include "hw/core/boards.h"
>   #include "hw/core/loader.h"
> +#include "hw/core/qdev-properties.h"
>   #include "hw/core/sysbus.h"
>   
>   #include "target/riscv/cpu.h"
> @@ -67,7 +69,7 @@ static const MemMapEntry tt_atlantis_memmap[] = {
>       [TT_ATL_DDR_HI] =          { 0x100000000,  0x1000000000 },
>   };
>   
> -static I2CBus *i2c_get_bus(TTAtlantisState *s, unsigned busnr)
> +static I2CBus *i2c_get_bus(TTAtlantisSoCState *s, unsigned busnr)
>   {
>       assert(busnr < TT_ATL_NUM_I2C);
>   
> @@ -80,7 +82,7 @@ static uint32_t next_phandle(void)
>       return fdt_phandle++;
>   }
>   
> -static void create_fdt_memory(void *fdt, TTAtlantisState *s)
> +static void create_fdt_memory(void *fdt, TTAtlantisSoCState *s)
>   {
>       hwaddr ram_size = memory_region_size(s->dram);
>       hwaddr size_lo = ram_size;
> @@ -104,7 +106,7 @@ static void create_fdt_memory(void *fdt, TTAtlantisState *s)
>       }
>   }
>   
> -static void create_fdt_aclint(void *fdt, TTAtlantisState *s,
> +static void create_fdt_aclint(void *fdt, TTAtlantisSoCState *s,
>                                 uint32_t *intc_phandles)
>   {
>       g_autofree char *name = NULL;
> @@ -206,7 +208,7 @@ static void create_fdt_one_aplic(void *fdt,
>       qemu_fdt_setprop_cell(fdt, name, "phandle", aplic_phandle);
>   }
>   
> -static void create_fdt_pmu(void *fdt, TTAtlantisState *s)
> +static void create_fdt_pmu(void *fdt, TTAtlantisSoCState *s)
>   {
>       char pmu_name[] = "/pmu";
>       RISCVCPU *hart = &s->cpus.harts[0];
> @@ -216,7 +218,7 @@ static void create_fdt_pmu(void *fdt, TTAtlantisState *s)
>       riscv_pmu_generate_fdt_node(fdt, hart->pmu_avail_ctrs, pmu_name);
>   }
>   
> -static void create_fdt_cpu(void *fdt, TTAtlantisState *s,
> +static void create_fdt_cpu(void *fdt, TTAtlantisSoCState *s,
>                              uint32_t aplic_s_phandle,
>                              uint32_t imsic_s_phandle)
>   {
> @@ -313,7 +315,7 @@ static void create_fdt_i2c(void *fdt, const MemMapEntry *mem, uint32_t irq,
>       qemu_fdt_setprop_cell(fdt, name, "#size-cells", 0);
>   }
>   
> -static void create_fdt_i2c_device(void *fdt, TTAtlantisState *s, int bus,
> +static void create_fdt_i2c_device(void *fdt, TTAtlantisSoCState *s, int bus,
>                                     const char *compat, int addr)
>   {
>       hwaddr base = s->memmap[TT_ATL_I2C0 + bus].base;
> @@ -325,7 +327,7 @@ static void create_fdt_i2c_device(void *fdt, TTAtlantisState *s, int bus,
>       qemu_fdt_setprop_cell(fdt, name, "reg", addr);
>   }
>   
> -static void finalize_fdt(void *fdt, TTAtlantisState *s)
> +static void finalize_fdt(void *fdt, TTAtlantisSoCState *s)
>   {
>       uint32_t aplic_s_phandle = next_phandle();
>       uint32_t imsic_s_phandle = next_phandle();
> @@ -359,9 +361,9 @@ static void finalize_fdt(void *fdt, TTAtlantisState *s)
>       create_fdt_i2c_device(fdt, s, 4, "ti,tmp105", 0x48);
>   }
>   
> -static void create_fdt(TTAtlantisState *s)
> +static void create_fdt(TTAtlantisState *ams)
>   {
> -    MachineState *ms = MACHINE(s);
> +    MachineState *ms = MACHINE(ams);
>       int fdt_size = 0;
>   
>       ms->fdt = create_board_device_tree("Tenstorrent Atlantis RISC-V Machine",
> @@ -373,12 +375,12 @@ static void create_fdt(TTAtlantisState *s)
>   
>       qemu_fdt_add_subnode(ms->fdt, "/aliases");
>   
> -    create_fdt_pmu(ms->fdt, s);
> +    create_fdt_pmu(ms->fdt, &ams->soc);
>   }
>   
> -static void load_fdt(TTAtlantisState *s)
> +static void load_fdt(TTAtlantisState *ams)
>   {
> -    MachineState *ms = MACHINE(s);
> +    MachineState *ms = MACHINE(ams);
>       char **node_path;
>       Error *err = NULL;
>       int fdt_size = 0;
> @@ -404,7 +406,7 @@ static void load_fdt(TTAtlantisState *s)
>           g_strfreev(node_path);
>       }
>   
> -    create_fdt_memory(ms->fdt, s);
> +    create_fdt_memory(ms->fdt, &ams->soc);
>   }
>   
>   static void mmio_map_unimplemented(MemoryRegion *memory, SysBusDevice *dev,
> @@ -418,10 +420,11 @@ static void mmio_map_unimplemented(MemoryRegion *memory, SysBusDevice *dev,
>                                           sysbus_mmio_get_region(dev, 0), -1000);
>   }
>   
> -static void tt_atlantis_machine_done(Notifier *notifier, void *data)
> +static void tt_atlantis_machine_done(Notifier *n, void *data)
>   {
> -    TTAtlantisState *s = container_of(notifier, TTAtlantisState, machine_done);
> -    MachineState *machine = MACHINE(s);
> +    TTAtlantisState *ams = container_of(n, TTAtlantisState, machine_done);
> +    TTAtlantisSoCState *s = &ams->soc;
> +    MachineState *machine = MACHINE(ams);
>       hwaddr start_addr = s->memmap[TT_ATL_DDR_LO].base;
>       hwaddr mem_size;
>       target_ulong firmware_end_addr, kernel_start_addr;
> @@ -479,23 +482,39 @@ static void tt_atlantis_machine_done(Notifier *notifier, void *data)
>                                 fdt_load_addr);
>   }
>   
> -static void tt_atlantis_machine_init(MachineState *machine)
> +static void tt_atlantis_soc_init(Object *obj)
>   {
> -    TTAtlantisState *s = TT_ATLANTIS_MACHINE(machine);
> +    TTAtlantisSoCState *s = TT_ATLANTIS_SOC(obj);
> +
> +    object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY);
> +
> +    object_initialize_child(obj, "uart1", &s->uart1,
> +                            TYPE_UNIMPLEMENTED_DEVICE);
>   
> +    for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
> +        object_initialize_child(obj, "i2c[*]", &s->i2c[i],
> +                                TYPE_DESIGNWARE_I2C);
> +    }
> +}
> +
> +static void tt_atlantis_soc_realize(DeviceState *dev, Error **errp)
> +{
> +    TTAtlantisSoCState *s = TT_ATLANTIS_SOC(dev);
>       ram_addr_t lo_ram_size, ram_size;
> -    int hart_count = machine->smp.cpus;
> +    int hart_count = s->num_harts;
>   
>       s->memory = get_system_memory();
>   
> -    s->dram = machine->ram;
> +    if (!s->dram) {
> +        error_setg(errp, "'dram' link is not set");
> +        return;
> +    }
>       ram_size = memory_region_size(s->dram);
>   
>       s->memmap = tt_atlantis_memmap;
>   
> -    object_initialize_child(OBJECT(machine), "soc", &s->cpus,
> -                            TYPE_RISCV_HART_ARRAY);
> -    object_property_set_str(OBJECT(&s->cpus), "cpu-type", machine->cpu_type,
> +    /* CPUs */
> +    object_property_set_str(OBJECT(&s->cpus), "cpu-type", s->cpu_type,
>                               &error_abort);
>       object_property_set_int(OBJECT(&s->cpus), "hartid-base", 0,
>                               &error_abort);
> @@ -504,7 +523,9 @@ static void tt_atlantis_machine_init(MachineState *machine)
>       object_property_set_int(OBJECT(&s->cpus), "resetvec",
>                               s->memmap[TT_ATL_BOOTROM].base,
>                               &error_abort);
> -    sysbus_realize(SYS_BUS_DEVICE(&s->cpus), &error_fatal);
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpus), errp)) {
> +        return;
> +    }
>   
>       s->irqchip = riscv_create_aia(s->memory,
>                                     true, TT_IMSIC_GUESTS,
> @@ -534,26 +555,27 @@ static void tt_atlantis_machine_init(MachineState *machine)
>        * up to 64GB. The low address is an alias of the first 2GB of that RAM.
>        */
>       if (ram_size > s->memmap[TT_ATL_DDR_HI].size) {
> -        char *sz = size_to_str(s->memmap[TT_ATL_DDR_HI].size);
> -        error_report("RAM size is too large, maximum is %s", sz);
> -        g_free(sz);
> -        exit(EXIT_FAILURE);
> +        g_autofree char *sz = size_to_str(s->memmap[TT_ATL_DDR_HI].size);
> +        error_setg(errp, "RAM size is too large, maximum is %s", sz);
> +        return;
>       }
>   
> -    memory_region_init_alias(&s->ram_hi, OBJECT(machine), "ram.high", s->dram,
> +    memory_region_init_alias(&s->ram_hi, OBJECT(s), "ram.high", s->dram,
>                                0, ram_size);
>       memory_region_add_subregion(s->memory,
>                                   s->memmap[TT_ATL_DDR_HI].base, &s->ram_hi);
>   
>       lo_ram_size = MIN(ram_size, s->memmap[TT_ATL_DDR_LO].size);
> -    memory_region_init_alias(&s->ram_lo, OBJECT(machine), "ram.low", s->dram,
> +    memory_region_init_alias(&s->ram_lo, OBJECT(s), "ram.low", s->dram,
>                                0, lo_ram_size);
>       memory_region_add_subregion(s->memory,
>                                   s->memmap[TT_ATL_DDR_LO].base, &s->ram_lo);
>   
>       /* Boot ROM */
> -    memory_region_init_rom(&s->bootrom, NULL, "tt-atlantis.bootrom",
> -                           s->memmap[TT_ATL_BOOTROM].size, &error_fatal);
> +    if (!memory_region_init_rom(&s->bootrom, OBJECT(s), "tt-atlantis.bootrom",
> +                                s->memmap[TT_ATL_BOOTROM].size, errp)) {
> +        return;
> +    }
>       memory_region_add_subregion(s->memory, s->memmap[TT_ATL_BOOTROM].base,
>                                   &s->bootrom);
>   
> @@ -570,26 +592,56 @@ static void tt_atlantis_machine_init(MachineState *machine)
>        * Create an unimplemented device region so writes don't fault
>        * and reads return zero, which keeps Linux happy.
>        */
> -    object_initialize_child(OBJECT(s), "uart1", &s->uart1,
> -                            TYPE_UNIMPLEMENTED_DEVICE);
>       mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->uart1),
>                              "tt-atlantis.uart1", s->memmap[TT_ATL_UART1].base,
>                              s->memmap[TT_ATL_UART1].size);
>   
>       /* I2C */
>       for (int i = 0; i < TT_ATL_NUM_I2C; i++) {
> -        SysBusDevice *sbd;
> +        SysBusDevice *sbd = SYS_BUS_DEVICE(&s->i2c[i]);
>   
> -        object_initialize_child(OBJECT(s), "i2c[*]", &s->i2c[i],
> -                                TYPE_DESIGNWARE_I2C);
> -        sbd = SYS_BUS_DEVICE(&s->i2c[i]);
> -        sysbus_realize(sbd, &error_fatal);
> +        if (!sysbus_realize(sbd, errp)) {
> +            return;
> +        }
>           memory_region_add_subregion(s->memory,
>                                       s->memmap[TT_ATL_I2C0 + i].base,
>                                       sysbus_mmio_get_region(sbd, 0));
>           sysbus_connect_irq(sbd, 0,
>                              qdev_get_gpio_in(s->irqchip, TT_ATL_I2C0_IRQ + i));
>       }
> +}
> +
> +static const Property tt_atlantis_soc_props[] = {
> +    DEFINE_PROP_STRING("cpu-type", TTAtlantisSoCState, cpu_type),
> +    DEFINE_PROP_UINT32("num-harts", TTAtlantisSoCState, num_harts, 8),
> +    DEFINE_PROP_LINK("dram", TTAtlantisSoCState, dram,
> +                     TYPE_MEMORY_REGION, MemoryRegion *),
> +};
> +
> +static void tt_atlantis_soc_class_init(ObjectClass *oc, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +
> +    dc->realize = tt_atlantis_soc_realize;
> +    device_class_set_props(dc, tt_atlantis_soc_props);
> +    /* The SoC can only be instantiated from the machine */
> +    dc->user_creatable = false;
> +}
> +
> +static void tt_atlantis_machine_init(MachineState *machine)
> +{
> +    TTAtlantisState *ams = TT_ATLANTIS_MACHINE(machine);
> +    TTAtlantisSoCState *s = &ams->soc;
> +
> +    object_initialize_child(OBJECT(machine), "soc", &ams->soc,
> +                            TYPE_TT_ATLANTIS_SOC);
> +    object_property_set_str(OBJECT(&ams->soc), "cpu-type", machine->cpu_type,
> +                            &error_abort);
> +    object_property_set_int(OBJECT(&ams->soc), "num-harts", machine->smp.cpus,
> +                            &error_abort);
> +    object_property_set_link(OBJECT(&ams->soc), "dram", OBJECT(machine->ram),
> +                             &error_abort);
> +    qdev_realize(DEVICE(&ams->soc), NULL, &error_fatal);
>   
>       /* I2C peripherals: qemu specific */
>       i2c_slave_create_simple(i2c_get_bus(s, 0), "ds1338", 0x6f);
> @@ -597,13 +649,13 @@ static void tt_atlantis_machine_init(MachineState *machine)
>   
>       /* Load or create device tree */
>       if (machine->dtb) {
> -        load_fdt(s);
> +        load_fdt(ams);
>       } else {
> -        create_fdt(s);
> +        create_fdt(ams);
>       }
>   
> -    s->machine_done.notify = tt_atlantis_machine_done;
> -    qemu_add_machine_init_done_notifier(&s->machine_done);
> +    ams->machine_done.notify = tt_atlantis_machine_done;
> +    qemu_add_machine_init_done_notifier(&ams->machine_done);
>   }
>   
>   static void tt_atlantis_machine_class_init(ObjectClass *oc, const void *data)
> @@ -623,6 +675,12 @@ static void tt_atlantis_machine_class_init(ObjectClass *oc, const void *data)
>   
>   static const TypeInfo tt_atlantis_types[] = {
>       {
> +        .name       = TYPE_TT_ATLANTIS_SOC,
> +        .parent     = TYPE_DEVICE,
> +        .instance_size = sizeof(TTAtlantisSoCState),
> +        .instance_init = tt_atlantis_soc_init,
> +        .class_init = tt_atlantis_soc_class_init,
> +    }, {
>           .name       = MACHINE_TYPE_NAME("tt-atlantis"),
>           .parent     = TYPE_MACHINE,
>           .class_init = tt_atlantis_machine_class_init,


