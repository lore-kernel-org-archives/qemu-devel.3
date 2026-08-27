Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74304C61DC6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 12:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzYsr-0008BE-P8; Thu, 27 Aug 2026 08:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzYso-00088r-Aq
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 08:07:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzYsl-0007X7-KI
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 08:07:01 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RBUgGs3293554
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 12:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 chVUUNfyzkEfYUZ5JdrPDCEEJ15Fy2NZabPZW7LsjXk=; b=nb9WN2f0K49oD9mg
 ObmqivweeK4rBupU5ZAKEZpKWvgPlwSnPYD2aSXFbxt9Vl5MDBhor+LsoL9UZ+Ab
 dqd/X5g44Ig9nLDyGfMm7hJKDmYx+IBU2Gj4WGEiTM80wgXvwSdZSdlJwO43cEv0
 coFiFMNJMubjMXAUHZi2lEqPbq/ZCpamtY0OQTRx398D5RH4cdSwe1RJ7uVvZRhb
 /eK2A9KuLwMKozr6qXeUb/lf1sNU+Zw1K0/kOf4ESxkCbR7nP750gcLToX2y1SjR
 3RlE0nNM1kEukXUWv8An32F/4/qEQOToUJex4ptGNNHsqVW73+TMmsMXlMjySthW
 utcbww==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4game7r481-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 12:06:57 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-90a60102d6eso7086896d6.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 05:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787832417; x=1788437217; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=chVUUNfyzkEfYUZ5JdrPDCEEJ15Fy2NZabPZW7LsjXk=;
 b=SRC1MkxL8O8WSj77/0wMr/seqtWzroq0yiMQ2sQ2JLUeDciLp2IrZEVw9zhx5KPR6d
 S4tbTDZvDAgiRQjJUb3LX/LauvsIDQ5RQ5eY1E5FI2zTDeFsDud72XucEzKCNcRaEWi0
 mAcJzjbU5NqVmVAdPavGJUrRldo+yXO4dbTLYRyxDdh8yFXwG0UtAs8zuU76GEEN1Bap
 0MDufVgRt748HAstiygQMPBwxqiiJ68pO22kg9feDUkJEgW5lzACi4+8Oj/G3pDP/FJs
 GrgExUzppgV+HeDOpEuwMJOGWWu2IcFxrQeGNvlpTqNwOp0FEvX+8TpAKyLaxjWvHCrp
 LZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787832417; x=1788437217;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=chVUUNfyzkEfYUZ5JdrPDCEEJ15Fy2NZabPZW7LsjXk=;
 b=mBvg4GQHk7P+mjnD3h9joe7qvaEy9FYSGlRCi2E9GSaWKAEczAbnrYkh7xyiQVAy5r
 oH27Qtc9X8zAdROb3433092P8bkUwWIWOHO45HwxLUUVFoIJ94V6GJtGlrB2+qy7U8/s
 qeiY3EZgKM1JsbpRzSL0wqvP8Q6bHY8KXCWvjWclTuKzHcwO61xnZT5DOjrYC5wVBLOl
 mUTfxD3pmgAI+GGx2zmPPCXCvfs1nyE12oZ5NSEN4NlFjeYnlNH2ucHBHfXero21WJy4
 0SK0dGY2P45oTV75+ruWtLffyHa83GSQwB/KH9QyP44fuyqfmsip4AwaqQMNp+3fK9dn
 o24g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoJJQKUplxNTJjV85Pfca1xFZMhDOnzaQNy4/YIVDb5aBoHk5FG6ktkagCu7T2McFGkUnfHcmGC1esC@nongnu.org
X-Gm-Message-State: AFuF++nhIZv3tiI4fxDaN1Qb/M74TSy/9FZ27VDvWK0gIsG0GMce/2Ln
 hybRQuxB1+Cx8LDXVWhwNP5OfdzhqCwf6IncrjmE3DkKqdHe6Rsu4GozUBO9hyUzgLppIA3Cbbc
 Xh2cFP3FoI6+R36728c9BR3DVcNBH9S8i3vnG5/KgevGInYXaSDfBoY0L8A==
X-Gm-Gg: AR+sD13tKaBY1T4J00ZW1RIzImfN+MtwL4GbfPQH+CHpKXofxfLEaDOsN0QlMwuEd82
 RNxK2qi/ISoHpAeA5SHfBlFmvRllUiJwyzTtr4HDtRCt1yBWBMVtSMdoCMG8CZtH3epV32M6gQf
 f4tEhDGMDO3YpyBxoYFORmTxSfPmQbTuuvgFb/5jAsiA0FJsm3e9VSyYG3GHY+OSQZLkS6y8+g5
 2eDMtvcdxahvVqWPp4s7M/cUF7E0rdmwsq254A+ZoXjytJtLfOogOHrartm0j39T8AyaYV8Cu8A
 T23L1T1ZB5FxcrpAbbGIj6Nny4IiqB77UzOrjLnrwpkFiAFJaf0joAHkes2YLfuq+MZ09AJNvgg
 MjcsZ0NyeiQRiVr7B4l1lRPoDm9BAYMEM/sCG
X-Received: by 2002:a05:6214:da6:b0:90c:b610:6e81 with SMTP id
 6a1803df08f44-90cc7a093f3mr159197646d6.28.1787832416612; 
 Thu, 27 Aug 2026 05:06:56 -0700 (PDT)
X-Received: by 2002:a05:6214:da6:b0:90c:b610:6e81 with SMTP id
 6a1803df08f44-90cc7a093f3mr159196096d6.28.1787832415796; 
 Thu, 27 Aug 2026 05:06:55 -0700 (PDT)
Received: from [192.168.68.100] ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90cd7416cd1sm15043926d6.47.2026.08.27.05.06.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 05:06:55 -0700 (PDT)
Message-ID: <ea83f521-81df-4e0c-91c2-23923a359959@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 09:06:51 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/16] hw/riscv/atlantis: Make TTAtlantisState own memory
 containers
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
 <20260826221154.54577-5-joel@jms.id.au>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260826221154.54577-5-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEwMSBTYWx0ZWRfX19YFjPby/sGL
 PCHwK4sHf3ri1CfHq15hfVGhwQHfyvo/YKlZuU/Bs5d5CNOgZIcnLYUN+KJlO1NfO080gbTso75
 eR/Ox+QXx/WpKJGpTgTUuyIYIZOq6ehlD+U7AjCZYWVcigkjAPXzojKflS9Mt21RxUphrOq+Rmo
 qS7wlgebxM9DAjoHkprVZSw6YfwwLTWqyu871e2FVlF2bJ69gxx6WuojQr6P4Orq3E4qF4Kej7m
 EJeARVgnAuvOCIqmry69sMc4S5creks2UTDTKeNhU9VgKln0qBdRE9WRcyqLan2wQhXTTLuzOWe
 FKRSZijbh+FDet4U4OA2zQYzyP/fay5RVH+19BArfipdmfDeDNZ2O6peiq2jSsRUrj9cgjTClxe
 g5evlH4lRcA01XQxNbhrFhaLO8vdCD8MhOMDH7RQZVay34tvEeQ9lZmsp6LFVcai8cQ0yOZsJpx
 TYtooH7NUzBVz8B/jBg==
X-Proofpoint-GUID: dj4o8DTXIyvOvYObP7mYlw6AAQrddoHB
X-Authority-Analysis: v=2.4 cv=Yrc/gYYX c=1 sm=1 tr=0 ts=6a902861 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=24ykbZE1W2m3Nl42C18A:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: dj4o8DTXIyvOvYObP7mYlw6AAQrddoHB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEwMSBTYWx0ZWRfX9IQxuCHHsUIb
 hBRhoi+gd/kP+S3qQO7TocUV9evbb4KmwNsfatSCzYn8HJ7jR50UckIZdyQ4+sAmMsVeIUD/XKr
 B9Rr2nmll8hW561oylEqgNl8AlRXpEs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270101
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
> The DRAM hi, DRAM low and bootrom memory containers can be owned by the
> TTAtlantisState.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   include/hw/riscv/tt_atlantis.h |  4 ++++
>   hw/riscv/tt_atlantis.c         | 15 ++++++---------
>   2 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
> index 2ec283d0fd7b..9ca98bfb8478 100644
> --- a/include/hw/riscv/tt_atlantis.h
> +++ b/include/hw/riscv/tt_atlantis.h
> @@ -31,10 +31,14 @@ struct TTAtlantisState {
>   
>       MemoryRegion *memory;
>       MemoryRegion *dram;
> +    MemoryRegion ram_hi;
> +    MemoryRegion ram_lo;
> +
>       RISCVHartArrayState cpus;
>       DeviceState *irqchip;
>       DesignWareI2CState i2c[TT_ATL_NUM_I2C];
>       UnimplementedDeviceState uart1;
> +    MemoryRegion bootrom;
>   };
>   
>   enum {
> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> index 7a9f5872c7c0..b80bdf54c40b 100644
> --- a/hw/riscv/tt_atlantis.c
> +++ b/hw/riscv/tt_atlantis.c
> @@ -483,9 +483,6 @@ static void tt_atlantis_machine_init(MachineState *machine)
>   {
>       TTAtlantisState *s = TT_ATLANTIS_MACHINE(machine);
>   
> -    MemoryRegion *ram_hi = g_new(MemoryRegion, 1);
> -    MemoryRegion *ram_lo = g_new(MemoryRegion, 1);
> -    MemoryRegion *bootrom = g_new(MemoryRegion, 1);
>       ram_addr_t lo_ram_size, ram_size;
>       int hart_count = machine->smp.cpus;
>   
> @@ -543,22 +540,22 @@ static void tt_atlantis_machine_init(MachineState *machine)
>           exit(EXIT_FAILURE);
>       }
>   
> -    memory_region_init_alias(ram_hi, OBJECT(machine), "ram.high", s->dram,
> +    memory_region_init_alias(&s->ram_hi, OBJECT(machine), "ram.high", s->dram,
>                                0, ram_size);
>       memory_region_add_subregion(s->memory,
> -                                s->memmap[TT_ATL_DDR_HI].base, ram_hi);
> +                                s->memmap[TT_ATL_DDR_HI].base, &s->ram_hi);
>   
>       lo_ram_size = MIN(ram_size, s->memmap[TT_ATL_DDR_LO].size);
> -    memory_region_init_alias(ram_lo, OBJECT(machine), "ram.low", s->dram,
> +    memory_region_init_alias(&s->ram_lo, OBJECT(machine), "ram.low", s->dram,
>                                0, lo_ram_size);
>       memory_region_add_subregion(s->memory,
> -                                s->memmap[TT_ATL_DDR_LO].base, ram_lo);
> +                                s->memmap[TT_ATL_DDR_LO].base, &s->ram_lo);
>   
>       /* Boot ROM */
> -    memory_region_init_rom(bootrom, NULL, "tt-atlantis.bootrom",
> +    memory_region_init_rom(&s->bootrom, NULL, "tt-atlantis.bootrom",
>                              s->memmap[TT_ATL_BOOTROM].size, &error_fatal);
>       memory_region_add_subregion(s->memory, s->memmap[TT_ATL_BOOTROM].base,
> -                                bootrom);
> +                                &s->bootrom);
>   
>       /* UART1, the soc console (UART0 is for the boot microcontroller) */
>       serial_mm_init(s->memory, s->memmap[TT_ATL_UART1].base, 2,


