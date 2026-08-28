Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC27EC61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 15:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzyhH-0005uR-2k; Fri, 28 Aug 2026 11:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzyhF-0005u0-Dp
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:40:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzyhD-000259-Gc
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 11:40:49 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SDl6MT038609
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Y7IkztzI0Yd9AnwaWt8p15ACchUCpTg+OpsoiXY8pNA=; b=G5frsTP4Wx+bl3sY
 BCUTYXUHdch+Kr/EiGfWKHCkyZme9eFkXz48RLj9mZCJPHo5GZD06gvOgECZqEjA
 JRUWPukX699kKO5VLKj4TgkFjX4gBcXPsdsRGhmC6j2hPrWvgcyxeQJ+3rQ8QDh+
 AphI/kdM2gGGv7WQAQ8V0J7GIFZBCqxC+QiZ3xmOMP1CCnx+q/z219cVC4Z4FQfo
 nfjvjuXXcIHrSAXcP7kVwvW6QWaYKk4Bc17Dc9nurr/76rCjM1LOM1HRMnO0xGv6
 gJF0QBI1tYwedVPu3CQh7QJ994nKrzk4+XHlB/dVPstI+SYg4Zx+IFyjUHYGZaED
 zH9Caw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb8afh76a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:40:45 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9390126581fso100388185a.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 08:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787931644; x=1788536444; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y7IkztzI0Yd9AnwaWt8p15ACchUCpTg+OpsoiXY8pNA=;
 b=UA3J+fWhLUtA8Igy0m1lsmPw686b9hNuU2DGca8iC2BdikluSF5p5Wn8QIAUW+0EZr
 QjI7hlIAvihaZvdPlG1dm+uwIuLm464bbiH8GROab6Yuwzt9+7aNSKey+1G373XIPEE7
 xOFs5b0qWjMPqO5DsFcd49olV6dwQM7yWKbKU2PVX22OBKwPTIo7F+Qg3U/6gYP33UsP
 BBPPTp1f445n/2/JBZOHUAY7F6fM3622UoZEyAEXPO5fp7p+iEpyVpq9IlDENcWZk3Yy
 lVA3DPgSUaQyYepjR/WNgUpJ+89sDgv3aOZegyFUbioPjl7pcSOW9s06/o33xxh2NylS
 zEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787931644; x=1788536444;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y7IkztzI0Yd9AnwaWt8p15ACchUCpTg+OpsoiXY8pNA=;
 b=BJ1dFUoISJc4hG3h29qPfQ1gnL0zTj/Rq7MRH55l5G756+lwdakzaWTEE/+fHqTxW4
 WExxc9R2cBm8t40gSxaC4zXU7prc5a8DWgGXW9MpDuZFULQumLwxUOsr30WTwz//6wUN
 aUrUP8rIHHQDWplki8D0GMuJlgt5i/SeBQY3ssXhlW88IL7mVjRIi5aYnXRGUk+ouK4u
 CK7BfdtO27YaVY1fbMHpESocABL9ZW5kvwGDH/i4nRkULAaKZtpY90QPyEGm4sDYSm/k
 9GqcUyVAeULaDCnXndcHAtVLKthRmD1DkMWtL1mV4XFmOWCre3jMf9+UPec5r4CZ2XCe
 d7AQ==
X-Gm-Message-State: AFuF++kgBkBUhQxpwGXlNip9vzcUPqxg3NeQr+QwXW5LGJkGQCzweX6l
 jpayvIom+418MI+6G76cLpxp+I1BTqwSpR6kmHWrJN4StHIs5jmxBgelc1Q+Zyx7au3aVEoPYgj
 +9bKomWNhfTHT0IXSLx+D6xS14al1h5ddg8TVwG7z/ilat4you4ve+c1bWA==
X-Gm-Gg: AR+sD12xclNMMEtzUnegObgQK+CXefYHri7LP9Bx5oP35mLFKIXkiTsWxYccM+jI7ZL
 4FGi1bCYZk3vuLVbwfAC8ijR0zr44D63oNJ59nooDdzl1uF8MJOouJqBoFwU1AHeNqD6pR+WN1i
 pjaUcsdWfy4ADTaVYvD+Kr5plH/+2PRsCBtsbLO16x54F0tgEb8ZaEJyEotdAX+9f5zeK6t/x5t
 mibENwB8VhuQarobdCLKu75IgGRM0359QuJDudkszVGaGSXsD48ycGMe2CvNgUlpi4dW9KMYcKE
 jY+a82vVTiaPOqvUS+DrfeLUCFLhRPlclZVhzivzJsk1fycMnVFy2kD7uiEqFN90CleG6nWzajD
 mNH8boMAibOSOcO1w4o9jlJPE33WcjyfGY4D/
X-Received: by 2002:a05:620a:8003:b0:936:cd74:4f45 with SMTP id
 af79cd13be357-9391391b3f0mr842015185a.37.1787931643837; 
 Fri, 28 Aug 2026 08:40:43 -0700 (PDT)
X-Received: by 2002:a05:620a:8003:b0:936:cd74:4f45 with SMTP id
 af79cd13be357-9391391b3f0mr842002385a.37.1787931642931; 
 Fri, 28 Aug 2026 08:40:42 -0700 (PDT)
Received: from [192.168.68.100] ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939173f2758sm163089285a.37.2026.08.28.08.40.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 08:40:42 -0700 (PDT)
Message-ID: <8274e2f5-38a5-4aee-842d-c1408a166f51@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 12:40:38 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/14] hw/riscv/fdt-common, virt.c: add
 riscv_create_fdt_socket_aclint()
To: Chao Liu <chao.liu@processmission.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260827222608.329788-1-daniel.barboza@oss.qualcomm.com>
 <20260827222608.329788-9-daniel.barboza@oss.qualcomm.com>
 <apEGhbfBmPgZrT8r@ChaodeMacBook-Pro.local>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <apEGhbfBmPgZrT8r@ChaodeMacBook-Pro.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9WP2sUMVyDBaIv00u9puu0M23WuyP-sT
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEzNiBTYWx0ZWRfX4u4ZEExtbeCy
 8Qg1HXYy+NCH7M9eKzDFw2r4AI20JYU/lDCfHfR7NPzA23avlVPrLxOofJt6aWaRoZDG+SDhTnm
 jEZpAlGinmE3JZhwgvECJ7+NajnVx2U=
X-Authority-Analysis: v=2.4 cv=IPoyzAvG c=1 sm=1 tr=0 ts=6a91abfd cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=9N5s0NaVz43VL8GnKO4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEzNiBTYWx0ZWRfX6IXgPmF2vbfU
 ZqUAQGpnUVW7ooG0CtAOdPdyQ04Sp2rcLy/txXGNY2mAtksO3vsYIQphhAB111v3iFHMyKpHO+F
 C/edUPcaODfE5ZIgp80EnjIxF23apr4KBeW5/+e0QorDFA4goM1cQcmrpOYdbWDFz63/YWy+1VI
 AQMoU3g+8hj/ojvJubDbcLL7YuD6Yf+X18FVF96oVO3WwaHApAEWU4tdKAVeFwv9VkbmLf7cf9u
 1J+cTr5TZRIbY9d6LHJbseIzZHFlovueHiGfUOR0RyocEpuitB8c613ukMd0hfMcGbv4z+ZtBE9
 u2i/3xg3eoWEWRZB8w6yayrJsKPJP/qQ81qSwX1LEChVgTezmZeG/CMQCzVafJL0YtxQh2WH127
 hZVwuvx0BvkYymvT1kG06enwLeSEfqbRGrTWb6uERtrUy97Aw9WHwhOrIQe6Kn7TqSbTdtBfy5E
 HQmr58L9h86xIf2aCng==
X-Proofpoint-ORIG-GUID: 9WP2sUMVyDBaIv00u9puu0M23WuyP-sT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280136
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



On 8/28/2026 1:13 AM, Chao Liu wrote:
> On Thu, Aug 27, 2026 at 07:26:01PM +0800, Daniel Henrique Barboza wrote:
>> Yet another FDT that we want to move to a helper to avoid copy/pasting
>> code to other boards that will use a mtimer.  In particular the future
>> 'riscv-server-ref' board.
>>
>> No FDT changes made.
>>
>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   hw/riscv/fdt-common.c         |  96 ++++++++++++++++++++++++++++++++
>>   hw/riscv/virt.c               | 101 ++++------------------------------
>>   include/hw/riscv/fdt-common.h |  11 ++++
>>   3 files changed, 119 insertions(+), 89 deletions(-)
>>
>> diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
>> index d815c5adff..76a783709d 100644
>> --- a/hw/riscv/fdt-common.c
>> +++ b/hw/riscv/fdt-common.c
>> @@ -16,6 +16,7 @@
>>   #include "target/riscv/cpu_bits.h"
>>   #include "hw/riscv/riscv-iommu-bits.h"
>>   #include "hw/riscv/iommu.h"
>> +#include "hw/intc/riscv_aclint.h"
>>   #include "hw/intc/riscv_imsic.h"
>>   #include "hw/pci/pci.h"
>>   #include "hw/pci/pcie_host.h"
>> @@ -702,3 +703,98 @@ void riscv_create_fdt_socket_aplic(void *fdt, APLICFdtProps *props,
>>   
>>       aplic_phandles[props->socket] = aplic_s_phandle;
>>   }
>> +
>> +void riscv_create_fdt_socket_aclint(void *fdt, ACLINTFdtProps *props,
>> +                                    uint32_t *intc_phandles)
>> +{
>> +    uint32_t aclint_cells_size = props->num_harts * sizeof(uint32_t) * 2;
>> +    g_autofree uint32_t *aclint_mswi_cells = NULL;
>> +    g_autofree uint32_t *aclint_sswi_cells = NULL;
>> +    g_autofree uint32_t *aclint_mtimer_cells = NULL;
>> +    hwaddr addr, size;
>> +    char *name;
>> +    int cpu;
>> +
>> +    aclint_mswi_cells = g_new0(uint32_t, props->num_harts * 2);
>> +    aclint_mtimer_cells = g_new0(uint32_t, props->num_harts * 2);
>> +    aclint_sswi_cells = g_new0(uint32_t, props->num_harts * 2);
>> +
>> +    for (cpu = 0; cpu < props->num_harts; cpu++) {
>> +        aclint_mswi_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
>> +        aclint_mswi_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_M_SOFT);
>> +        aclint_mtimer_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
>> +        aclint_mtimer_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_M_TIMER);
>> +        aclint_sswi_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
>> +        aclint_sswi_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_S_SOFT);
>> +    }
>> +
>> +    if (props->aia_type != AIA_TYPE_APLIC_IMSIC) {
>> +        addr = props->clint->base + (props->clint->size * props->socket);
>> +        name = g_strdup_printf("/soc/mswi@%"HWADDR_PRIx, addr);
>> +
>> +        qemu_fdt_add_subnode(fdt, name);
>> +        qemu_fdt_setprop_string(fdt, name, "compatible", "riscv,aclint-mswi");
>> +        qemu_fdt_setprop_sized_cells(fdt, name, "reg",
>> +                                     2, addr, 2, RISCV_ACLINT_SWI_SIZE);
>> +        qemu_fdt_setprop(fdt, name, "interrupts-extended",
>> +                         aclint_mswi_cells, aclint_cells_size);
>> +        qemu_fdt_setprop(fdt, name, "interrupt-controller", NULL, 0);
>> +        qemu_fdt_setprop_cell(fdt, name, "#interrupt-cells", 0);
>> +
>> +        if (props->numa_enabled) {
>> +            qemu_fdt_setprop_cell(fdt, name, "numa-node-id", props->socket);
>> +        }
>> +
>> +        g_free(name);
>> +    }
>> +
>> +    if (props->aia_type == AIA_TYPE_APLIC_IMSIC) {
>> +        addr = props->clint->base +
>> +               (RISCV_ACLINT_DEFAULT_MTIMER_SIZE * props->socket);
>> +        size = RISCV_ACLINT_DEFAULT_MTIMER_SIZE;
>> +    } else {
>> +        addr = props->clint->base + RISCV_ACLINT_SWI_SIZE +
>> +               (props->clint->size * props->socket);
>> +        size = props->clint->size - RISCV_ACLINT_SWI_SIZE;
>> +    }
>> +
>> +    name = g_strdup_printf("/soc/mtimer@%"HWADDR_PRIx, addr);
>> +    qemu_fdt_add_subnode(fdt, name);
>> +    qemu_fdt_setprop_string(fdt, name, "compatible",
>> +                            "riscv,aclint-mtimer");
>> +    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
>> +        2, addr,
> Should be:
> 	   2, addr + RISCV_ACLINT_DEFAULT_MTIME,
> 
> I found an MTIMER FDT issue in the virt machine FDT.
> 
> Command:
> 
> ```
>    timeout 30s ./build/qemu-system-riscv64 \
>      -machine virt,aia=aplic-imsic,aia-guests=5,aclint=on,dumpdtb=/tmp/virt.dtb \
>      -smp 2 -display none -nodefaults
> 
>    dtc -I dtb -O dts /tmp/virt.dtb | grep -A4 mtimer@
> ```
> 
> The generated FDT contains:
> 
>                  mtimer@2000000 {
>                          interrupts-extended = <0x04 0x07 0x02 0x07>;
>                          reg = <0x00 0x2000000 0x00 0x08 0x00 0x2000000 0x00 0x7ff8>;
>                          compatible = "riscv,aclint-mtimer";
>                  };
> 
> without this patches:
> 
>                    mtimer@2000000 {
>                            interrupts-extended = <0x04 0x07 0x02 0x07>;
>                            reg = <0x00 0x2007ff8 0x00 0x08 0x00 0x2000000 0x00 0x7ff8>;
>                            compatible = "riscv,aclint-mtimer";
>                    };
> 
> The first address should be 0x20007ff8.

That was intentional and I forgot to document it in the commit msg. The
"No FDT changes made" I said doesn't apply here. My bad!

If you use 'dtc' in the current 'virt' DT you'll get warnings:

dtc -I dtb -O dts virt.dtb > virt.dts

<stdout>: Warning (simple_bus_reg): /soc/mtimer@2000000: simple-bus unit address format error, expected "2007ff8"
<stdout>: Warning (simple_bus_reg): /soc/mtimer@2008000: simple-bus unit address format error, expected "200fff8"


This happens because the unit address in the node name doesn't match the
first address in 'reg'.  For mtimer@2000000, "reg" must be reg = <0x00 0x2000000 (...)>.
For mtimer@2008000, reg = <0x00 2008000 (...)> and so on.


Now, does this change break aclint in 'virt'?  Because in that case we'll
just keep the "dtc" warning and live with it.  Aside from the existing tests
we have in QEMU I didn't do a deep dive in aclint.


Thanks,
Daniel

> 
>> +        2, size - RISCV_ACLINT_DEFAULT_MTIME,
>> +        2, addr + RISCV_ACLINT_DEFAULT_MTIMECMP,
>> +        2, RISCV_ACLINT_DEFAULT_MTIME);
> 
> [...]
> 
>> +    qemu_fdt_setprop(fdt, name, "interrupts-extended",
>> -    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
>> -        2, addr + RISCV_ACLINT_DEFAULT_MTIME,
> I think this is the original code that was moved here.
> 
> Thanks,
> Chao
>> -        2, size - RISCV_ACLINT_DEFAULT_MTIME,
>> -        2, addr + RISCV_ACLINT_DEFAULT_MTIMECMP,
>> -        2, RISCV_ACLINT_DEFAULT_MTIME);
> 


