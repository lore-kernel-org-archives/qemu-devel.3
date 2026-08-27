Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73E8C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 11:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzY2K-0001vP-7W; Thu, 27 Aug 2026 07:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzY2I-0001uJ-21
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 07:12:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzY2G-0006J9-EU
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 07:12:45 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R9H72A3654639
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 11:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0gCuD8MuNcJ8ftoYOhrc0WbrfXFy5ash2mwbgEmutM0=; b=FJzWFmMewQ9vyP1O
 ScSqSHCpe5C7c5hCgnFRNz6gnxdJ8XhhmvjfkULIBTeUiv2ynWeeiOn8+0eGTR86
 MxC/W/FYWK5RNNnm0I5UDUYf1vx6ra2GHhv5OMQrqjxasUfikYDtaqjt3ii4EcV+
 CVWNiF1c0zFFYt+S1dD+W1xOBkKVl6Oi5cRq+ygUNOaSIsAQNTdDzcxQINBnkBA0
 NLurf9hWMXZ8FJ7BDqkRfsUBrdzOboASPjBvMWCqwJWlGqFP7L5H+JEYPfm8o+WK
 /Ez5+3nOkx/WfoTA3M7KfywUlYf6+Iv+qm6KDxoq7Opi0SfPYkiSQTTfWBJxXUkQ
 xxacrg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga075cmpc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 11:12:43 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e52306621so59737285a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 04:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787829162; x=1788433962; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0gCuD8MuNcJ8ftoYOhrc0WbrfXFy5ash2mwbgEmutM0=;
 b=f6EYmwhYG+OgxMP/MdcWMx9dHM4VV5AgtZKEDRPMTjpmSNJzQenjoH5N0/Xj3FXb4V
 HvVdku8wN/mLWoOC2wDc8FFAX+1fvzzvow67DzOo2cucCVtmpV3yJKImsyrF4bm+Wxxs
 mjFz8+qbbQKUNP20M+lN2V1qcyz3Xc5kxnIQoUzJVAmyqbvIHlGq5uHvb5AubRdGhuEx
 XPfplXDaemLaeBSTRRkUx3MXxCzVaFmVejgGEsNIjzaLO7tb9IrvAqS/UHW9AU2frH0W
 8CW7q149sIun7Gn6V7rRgg75NaiTsadfixvzpC2dlTRhQFUKEq3i8Ts07rgcXnBrqP1r
 lydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787829162; x=1788433962;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0gCuD8MuNcJ8ftoYOhrc0WbrfXFy5ash2mwbgEmutM0=;
 b=af6xnG/NpeBxwpP9+RNKFD+y6fcoGeNlcJSzbs1TV7h6GbaOwnQ8TDLEyn61VnGvf7
 PKrrji2vzQuBZANh+k3kz/HBHAhIlYDWr6n+n5dgLCEXPSGAr8CfTsgPBIMrsP8Bhz62
 ujwQV/M1/kP9igJM573WbHOKv1Z+57geO6h316HIEnl4x+zDPBNg0zT399cxPobxt63k
 yF9NMOHDhX6rWkrIfhHCBcRaCAZ1ATr2P1kohqyMP2cFc7SXtKVqDhhgx/zKs43EM56X
 /vzkgAElFQeUhqNpTd5PHouooh3zAb6rSW54h8vIH7X33e1+J7e4Kzqh7GAuqJG8KH0P
 Xh7Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqBVI1hnN6/vOsiHr6MhiG2q1piYzmU1btR28A5fl5DhzS0z1YZsY6FXwe1UJ8IVT1TdHIW/YwqAJU8@nongnu.org
X-Gm-Message-State: AFuF++nAfpj7oxkIm4aL1nLNZlFDKyjdbVq7ewWaHfj7GqE0azEpFv3E
 yOB+m3JdbLf67JeLrt9d2rsVzt3j+sSIUwMzPEvQDdFSdnRdb2pTH1yYF816RIWwFRpaQFkPuuU
 ayRZgfCBHSOJUn/v5VAxiARu5cfAx5f7d44na6O30PGknmO1Fd3pBqvAmqA==
X-Gm-Gg: AR+sD12IS8tbd/pDgIXaQn6N/O0x6zZprTEPdGK2nujFjcgLZpDAMKtHrRiv6CRsomX
 sF1oeJZQLW0NuIH4gYgLBggM5NxwfSLW20FCybyCCrAIVfCLepoGhFBHnShI8Xv4hBj57HD6UCC
 QhY6UTxwZ/SKG9TwdfKE74jTwC1eUicRHg2p1hocp/pc4/zLPwzuMJheh0QwzJ6MoORS225s4JA
 VEwTPZic2lxO014HeEhx4nf9iLBu+zXQjbay+qScbpjYFv98uG903VwKXibaXzUUG/Yn6IwUwOr
 D23HTMxV3wgdEVhcvJ+z6Im0qyo5vJZsFXifS9OwyHWoa6KggXrWSG4TTg+9FACk72i8C2ZaKmg
 feAQPJWX4ByUPdV/kzRExrd6FwZl4h6QrjIAr
X-Received: by 2002:a05:620a:72d1:20b0:936:883d:89c6 with SMTP id
 af79cd13be357-937803e01c9mr1110550285a.28.1787829162464; 
 Thu, 27 Aug 2026 04:12:42 -0700 (PDT)
X-Received: by 2002:a05:620a:72d1:20b0:936:883d:89c6 with SMTP id
 af79cd13be357-937803e01c9mr1110543685a.28.1787829161772; 
 Thu, 27 Aug 2026 04:12:41 -0700 (PDT)
Received: from [192.168.68.100] ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9377e6a2711sm417521385a.44.2026.08.27.04.12.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 04:12:41 -0700 (PDT)
Message-ID: <4216ded5-74a7-4423-b2e8-67db7eb0e9cc@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 08:12:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/16] hw/riscv/atlantis: Make UART unimp region a SoC
 device
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
 <20260826220528.54516-8-joel@jms.id.au>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260826220528.54516-8-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: L_E2wiJtbFWZoaYiQwMkf1U4ohH8Pqyp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA5MyBTYWx0ZWRfX23E1CfR/03f+
 yejLZFcHDS93kjKev53OEdFhDPurg54VipN7pQ72p3zAe0TZ4D1rw99BBjpQGrq+L9s9sE8AB+p
 fGIG5lEEt8YsJIGuwwvI4ghk/KI+D7Nzx+12qMseUTs4ak2HrC3zx+xfAUujsvNA/8GTtty4AcI
 uZzCyLDgz5v3NQ7m/dTAveNoPHIlJuW6Ocq2taJFw2TVJva6Ipjp+67An/+rS/lAbrUu7hC94Nt
 Vyi0hm96EEhseqiMHi1Mr1bkeUldOUGr0fFGvu+Pg/kxupf65flDtr8jd81geFYHDGrsRGSvNw2
 9NALYfOX256MCv7pjZMXNadelV2tQDNnpeR0A4mn1GA/Sy3HZ/eKI0dX0mIp/uupHVrQJR1U3VP
 1MW20RkENT8GvvzDkWXZy6tnhMQJgydK3pqPN3WcGhRuF8zYvw9QU+/FuCDedsSeMZOr/vn0dst
 mBWK7EUWByoVjBEH/0A==
X-Proofpoint-GUID: L_E2wiJtbFWZoaYiQwMkf1U4ohH8Pqyp
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA5MyBTYWx0ZWRfX/K9QCZTlFmew
 coCSIlIA6ThJCY42e/CxCbVa/0G3//EiFHWGF8u0K3mtIl1uSGincANTLTTxTv964+P6l2y58Ok
 dnGwWq7QJ/qbM+MQMaRqjdQ+QPe0l5I=
X-Authority-Analysis: v=2.4 cv=RPiD2Yi+ c=1 sm=1 tr=0 ts=6a901bab cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=kK6T1W4fREMqliNZTYoA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270093
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 8/26/2026 7:05 PM, Joel Stanley wrote:
> Make the unimplemented region covering the remainder of the console
> UART's register space a SoC child device, mapped using a helper. This
> makes it easier to map it into the SoC's memory container along with
> the other devices in the future.
> 
> While here, rename the region from uart0 to uart1. The uart0 name was
> a leftover from an earlier revision that used a different device for
> the console.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   include/hw/riscv/tt_atlantis.h |  2 ++
>   hw/riscv/tt_atlantis.c         | 19 ++++++++++++++++---
>   2 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/riscv/tt_atlantis.h b/include/hw/riscv/tt_atlantis.h
> index 7f7d4a5a5905..c9308aa57017 100644
> --- a/include/hw/riscv/tt_atlantis.h
> +++ b/include/hw/riscv/tt_atlantis.h
> @@ -13,6 +13,7 @@
>   #include "hw/core/sysbus.h"
>   #include "hw/i2c/designware_i2c.h"
>   #include "hw/intc/riscv_imsic.h"
> +#include "hw/misc/unimp.h"
>   #include "hw/riscv/riscv_hart.h"
>   
>   #define TYPE_TT_ATLANTIS_MACHINE MACHINE_TYPE_NAME("tt-atlantis")
> @@ -31,6 +32,7 @@ struct TTAtlantisState {
>       RISCVHartArrayState soc;
>       DeviceState *irqchip;
>       DesignWareI2CState i2c[TT_ATL_NUM_I2C];
> +    UnimplementedDeviceState uart1;
>   
>       int fdt_size;
>   };
> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> index 3f183db5c302..acfd0d31b368 100644
> --- a/hw/riscv/tt_atlantis.c
> +++ b/hw/riscv/tt_atlantis.c
> @@ -409,6 +409,17 @@ static void load_fdt(TTAtlantisState *s)
>       create_fdt_memory(s);
>   }
>   
> +static void mmio_map_unimplemented(MemoryRegion *memory, SysBusDevice *dev,
> +                                   const char *name, hwaddr addr, uint64_t size)
> +{
> +    qdev_prop_set_string(DEVICE(dev), "name", name);
> +    qdev_prop_set_uint64(DEVICE(dev), "size", size);
> +    sysbus_realize(dev, &error_abort);
> +
> +    memory_region_add_subregion_overlap(memory, addr,
> +                                        sysbus_mmio_get_region(dev, 0), -1000);
> +}
> +
>   static void tt_atlantis_machine_done(Notifier *notifier, void *data)
>   {
>       TTAtlantisState *s = container_of(notifier, TTAtlantisState, machine_done);
> @@ -560,9 +571,11 @@ static void tt_atlantis_machine_init(MachineState *machine)
>        * Create an unimplemented device region so writes don't fault
>        * and reads return zero, which keeps Linux happy.
>        */
> -    create_unimplemented_device("tt-atlantis.uart0",
> -                                s->memmap[TT_ATL_UART1].base,
> -                                s->memmap[TT_ATL_UART1].size);
> +    object_initialize_child(OBJECT(s), "uart1", &s->uart1,
> +                            TYPE_UNIMPLEMENTED_DEVICE);
> +    mmio_map_unimplemented(system_memory, SYS_BUS_DEVICE(&s->uart1),
> +                           "tt-atlantis.uart1", s->memmap[TT_ATL_UART1].base,
> +                           s->memmap[TT_ATL_UART1].size);
>   
>       /* I2C */
>       for (int i = 0; i < TT_ATL_NUM_I2C; i++) {


