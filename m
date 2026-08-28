Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B436C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 19:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x02cz-0000hE-Hx; Fri, 28 Aug 2026 15:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x02cy-0000gk-2u
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 15:52:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x02cv-00015e-Vl
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 15:52:39 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SJ7EB93348676
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 19:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ja2wSG3x7zRRlmVAgiQutWvbbULsHGwad0igVq6iAWo=; b=KWWJKDe/+ECU9/qm
 rm00K7q5SUxnxnzHfY4pBmgZ38OEN2N0ZotgWy/EGNz3qCeIeizHULfd+heNeKNN
 HwqG4XbTu58hGrJSdUsVyR79w5v8Lu1Q+Gbt4L/uCif7oJXp8n4cD/eh0DyoJqCI
 9aG2vMoe9IgTpF6J9HfXaQq97LVO0/FYbtjCMhsYR5YL4w1gGNDrIMCALO79DSPZ
 qw6zvsksnm0Pur0hpS5TzALQ8e9dIvGwXd+KipkhgGNxHZz2X2VoRjleO4SsmTEb
 3J+y96nrue2vCoshNzv2u4IjOhFsIB+L0rgjQeN5rm/KvSce7EggQdSY139R7NyZ
 w4QV5g==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb6h02jyr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 19:52:35 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-90cddf4f59eso16049386d6.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 12:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787946755; x=1788551555; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ja2wSG3x7zRRlmVAgiQutWvbbULsHGwad0igVq6iAWo=;
 b=Zpit5Enc7zhFaoVLIUgtxuxPzRTuMrwz3+ORMzE0PchJ7T4ixeDZbSeYy/A02+IfY7
 1E0iYkt6H2rU9zBIMKbDl8Ds1Wtf1jK9Nj6bWGw684izdIDSTg4FQO/c43HKVOQLG3nJ
 kDmZ2/lXRkW4jjH0OjRP23g++mGhPIKx+IGoF2BfNlsA3pWgLGBrA3R0qiOd6KVwRPvu
 +5TrVeJ2n/1Z88Wpi/Rv5wb6VIthc70lEXVxj9uh8FvN5kPKU3yrVFx3HU16Wtz8z3gA
 6ekMgmIO+ikzQ9mzp2atcVCdRzxUaarIqi37qV9TRijR166GRI701N3+IcLfbl7/U619
 wubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787946755; x=1788551555;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ja2wSG3x7zRRlmVAgiQutWvbbULsHGwad0igVq6iAWo=;
 b=jOq9mQaVrMJYBvBCzzDDa+OyrRz7m2Hq5p8VDyuOJds2bF6i2okLyAiVWdid79GkAG
 GrIvcNC7CKfdcDf6gCD4khOnW+TGeQLM+Dn/PpWCj+xBbyGR1Tb0UmFtI9dvF20Z5B4z
 qM5jYoYVWUhr8uPje/a83ycRXry7bLy0jZDAUHHPJXSFrtyz4vO4LMAgZau1s9/zozGj
 weSmEn8blbqVcuyNk+fQJZmpCo7ws8Uil7Qo6VMNZdST7rbsa57HU9pSIUWwNF5MGkTD
 EuUejhSND/2QDsSo3PojDB/aHU5uh6jTTE4hFVkpJHsnhJV089eisVdbXw2hJrWMGZ70
 4KAw==
X-Gm-Message-State: AFuF++nJOOArEIKKMNOorVgNbmHPiPhYonJuoCt/8sbACRqWucQZqEex
 W6HpqAuotaKnGOCO7+Dg/ppZeUI0B3F+SM1a2aJ300O7G8hFp5Mtli5Z1IIegi/1tp7M9g6EMO2
 BYcvYV5LRKm7rXFrKimH5rWHzkeUmkw5XckSZZdjmtZtZmcvi3oYhF23+Kg==
X-Gm-Gg: AR+sD12uDSBS6pLLboxBjI46NMOivG2WuyYXthce5QdG2/082emUdAV6XdjCKmWpdN+
 ljCMyqGQ6lB9YcvgCdDzEqcJbHW7tDTunmQwP5l+UwgLAgrNK5DL2rOVoWag9pT/LQstG0/ep3z
 g8Mr+SlayKw+7ylAOqFCD5JPDffUXbC2mM0u4yf5dkRLgPYHNW9o0LHRt3OS65JYcyzKIyCKYmo
 FHup9qDFSv+iOaMkhITAqMdddv4OTb+l7f+UOzaYcLv0oHe5t8otm9CI09jVkmPkvQjAQ8kU83A
 fuu3RIlUiBS5MwF5fJsVgN/Fvnk4PLi5H9naTFj4kmSMchqPCEfA31vcKMEHJRcKMvoqGuJU89R
 uFS2yiUCl3NOZS8Yh1yS6eGFpFmNceuz1QSeY
X-Received: by 2002:a05:620a:a717:b0:92e:5b45:b572 with SMTP id
 af79cd13be357-939137b8a4bmr960204285a.1.1787946754662; 
 Fri, 28 Aug 2026 12:52:34 -0700 (PDT)
X-Received: by 2002:a05:620a:a717:b0:92e:5b45:b572 with SMTP id
 af79cd13be357-939137b8a4bmr960151085a.1.1787946749308; 
 Fri, 28 Aug 2026 12:52:29 -0700 (PDT)
Received: from [192.168.68.100] ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-939172604f3sm215609585a.21.2026.08.28.12.52.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 12:52:28 -0700 (PDT)
Message-ID: <2f234b84-1d66-4a6a-a745-fd292df2c4a8@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 16:52:24 -0300
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
 <8274e2f5-38a5-4aee-842d-c1408a166f51@oss.qualcomm.com>
 <apHH1upnh8udUUT-@ChaodeMacBook-Pro.local>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <apHH1upnh8udUUT-@ChaodeMacBook-Pro.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wq0pNgFcu5iEkYIBNtIlaMrwU0nTEJhi
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDE3MyBTYWx0ZWRfXy+CI7zyYeQVQ
 HwmAg3hsKGPZWYTHrNzq9kIxVjFAg7qqHeDI5Nterrd6vqoPkSaiBzJ6TWXaf/OU9nk3uvXE+Sn
 rNW4CoXQX3pfI0NHYMWaL7R4dBWAB2E=
X-Authority-Analysis: v=2.4 cv=KPpqylFo c=1 sm=1 tr=0 ts=6a91e703 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=UXIAUNObAAAA:8 a=O76HWA22AAAA:20 a=EUspDBNiAAAA:8 a=7oRXlJWl_yl38FeU86IA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=a1s67YnXd6TbAZZNj1wK:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: wq0pNgFcu5iEkYIBNtIlaMrwU0nTEJhi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDE3MyBTYWx0ZWRfX4k8f4pqRlr65
 Bxl2g1jzSHisX3F3gLZYYyoXLiSBGmKz/dZaPbtYaOT2T2ndGJ6JlMMZFoCuBXTbyI8q/9BwCN7
 AtGX58SQ1mZI8TPzuhPI0t1fi03jeS8k8NZyP4PxKxl3JTmgF5pM4ljAppZhrUOHIMjGrYon+7p
 X18+get0cFfhm9KMoSScc1n7MKR4iFvTzFOr9+A/+fN/yDuvPwx3HazQG5xzAwkbg5hZLjKkXuV
 EHYANMUlkDIKxrKRKgcqMAtiLzN1V5wmQ8qjYp7nZNW3oyJSnrIv5sNV7hjMpUX22IE7iJTVzOB
 7rNgaXWv8GILy22l18c5sAI0qzTwE7Xcygy3omlmOxIM2Ppd630lfIbz845JOzhVAKYpgiax0fs
 iWINQ4n5olNIOiDVqSMZvdAr0zNqK0g71Ex//vR4FmQVnJujH2ohaUpkOQ9BIWgKYIdNRO3D1nA
 arDrbCQzkXYxwqYVakg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_06,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280173
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



On 8/28/2026 4:01 PM, Chao Liu wrote:
> Hi Daniel,
> 
> On Fri, Aug 28, 2026 at 12:40:38PM +0800, Daniel Henrique Barboza wrote:
>>
>>
>> On 8/28/2026 1:13 AM, Chao Liu wrote:
>>> On Thu, Aug 27, 2026 at 07:26:01PM +0800, Daniel Henrique Barboza wrote:
>>>> Yet another FDT that we want to move to a helper to avoid copy/pasting
>>>> code to other boards that will use a mtimer.  In particular the future
>>>> 'riscv-server-ref' board.
>>>>
>>>> No FDT changes made.
>>>>
>>>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>>> ---
>>>>    hw/riscv/fdt-common.c         |  96 ++++++++++++++++++++++++++++++++
>>>>    hw/riscv/virt.c               | 101 ++++------------------------------
>>>>    include/hw/riscv/fdt-common.h |  11 ++++
>>>>    3 files changed, 119 insertions(+), 89 deletions(-)
>>>>
>>>> diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
>>>> index d815c5adff..76a783709d 100644
>>>> --- a/hw/riscv/fdt-common.c
>>>> +++ b/hw/riscv/fdt-common.c
>>>> @@ -16,6 +16,7 @@
>>>>    #include "target/riscv/cpu_bits.h"
>>>>    #include "hw/riscv/riscv-iommu-bits.h"
>>>>    #include "hw/riscv/iommu.h"
>>>> +#include "hw/intc/riscv_aclint.h"
>>>>    #include "hw/intc/riscv_imsic.h"
>>>>    #include "hw/pci/pci.h"
>>>>    #include "hw/pci/pcie_host.h"
>>>> @@ -702,3 +703,98 @@ void riscv_create_fdt_socket_aplic(void *fdt, APLICFdtProps *props,
>>>>        aplic_phandles[props->socket] = aplic_s_phandle;
>>>>    }
>>>> +
>>>> +void riscv_create_fdt_socket_aclint(void *fdt, ACLINTFdtProps *props,
>>>> +                                    uint32_t *intc_phandles)
>>>> +{
>>>> +    uint32_t aclint_cells_size = props->num_harts * sizeof(uint32_t) * 2;
>>>> +    g_autofree uint32_t *aclint_mswi_cells = NULL;
>>>> +    g_autofree uint32_t *aclint_sswi_cells = NULL;
>>>> +    g_autofree uint32_t *aclint_mtimer_cells = NULL;
>>>> +    hwaddr addr, size;
>>>> +    char *name;
>>>> +    int cpu;
>>>> +
>>>> +    aclint_mswi_cells = g_new0(uint32_t, props->num_harts * 2);
>>>> +    aclint_mtimer_cells = g_new0(uint32_t, props->num_harts * 2);
>>>> +    aclint_sswi_cells = g_new0(uint32_t, props->num_harts * 2);
>>>> +
>>>> +    for (cpu = 0; cpu < props->num_harts; cpu++) {
>>>> +        aclint_mswi_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
>>>> +        aclint_mswi_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_M_SOFT);
>>>> +        aclint_mtimer_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
>>>> +        aclint_mtimer_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_M_TIMER);
>>>> +        aclint_sswi_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
>>>> +        aclint_sswi_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_S_SOFT);
>>>> +    }
>>>> +
>>>> +    if (props->aia_type != AIA_TYPE_APLIC_IMSIC) {
>>>> +        addr = props->clint->base + (props->clint->size * props->socket);
>>>> +        name = g_strdup_printf("/soc/mswi@%"HWADDR_PRIx, addr);
>>>> +
>>>> +        qemu_fdt_add_subnode(fdt, name);
>>>> +        qemu_fdt_setprop_string(fdt, name, "compatible", "riscv,aclint-mswi");
>>>> +        qemu_fdt_setprop_sized_cells(fdt, name, "reg",
>>>> +                                     2, addr, 2, RISCV_ACLINT_SWI_SIZE);
>>>> +        qemu_fdt_setprop(fdt, name, "interrupts-extended",
>>>> +                         aclint_mswi_cells, aclint_cells_size);
>>>> +        qemu_fdt_setprop(fdt, name, "interrupt-controller", NULL, 0);
>>>> +        qemu_fdt_setprop_cell(fdt, name, "#interrupt-cells", 0);
>>>> +
>>>> +        if (props->numa_enabled) {
>>>> +            qemu_fdt_setprop_cell(fdt, name, "numa-node-id", props->socket);
>>>> +        }
>>>> +
>>>> +        g_free(name);
>>>> +    }
>>>> +
>>>> +    if (props->aia_type == AIA_TYPE_APLIC_IMSIC) {
>>>> +        addr = props->clint->base +
>>>> +               (RISCV_ACLINT_DEFAULT_MTIMER_SIZE * props->socket);
>>>> +        size = RISCV_ACLINT_DEFAULT_MTIMER_SIZE;
>>>> +    } else {
>>>> +        addr = props->clint->base + RISCV_ACLINT_SWI_SIZE +
>>>> +               (props->clint->size * props->socket);
>>>> +        size = props->clint->size - RISCV_ACLINT_SWI_SIZE;
>>>> +    }
>>>> +
>>>> +    name = g_strdup_printf("/soc/mtimer@%"HWADDR_PRIx, addr);
>>>> +    qemu_fdt_add_subnode(fdt, name);
>>>> +    qemu_fdt_setprop_string(fdt, name, "compatible",
>>>> +                            "riscv,aclint-mtimer");
>>>> +    qemu_fdt_setprop_sized_cells(fdt, name, "reg",
>>>> +        2, addr,
>>> Should be:
>>> 	   2, addr + RISCV_ACLINT_DEFAULT_MTIME,
>>>
>>> I found an MTIMER FDT issue in the virt machine FDT.
>>>
>>> Command:
>>>
>>> ```
>>>     timeout 30s ./build/qemu-system-riscv64 \
>>>       -machine virt,aia=aplic-imsic,aia-guests=5,aclint=on,dumpdtb=/tmp/virt.dtb \
>>>       -smp 2 -display none -nodefaults
>>>
>>>     dtc -I dtb -O dts /tmp/virt.dtb | grep -A4 mtimer@
>>> ```
>>>
>>> The generated FDT contains:
>>>
>>>                   mtimer@2000000 {
>>>                           interrupts-extended = <0x04 0x07 0x02 0x07>;
>>>                           reg = <0x00 0x2000000 0x00 0x08 0x00 0x2000000 0x00 0x7ff8>;
>>>                           compatible = "riscv,aclint-mtimer";
>>>                   };
>>>
>>> without this patches:
>>>
>>>                     mtimer@2000000 {
>>>                             interrupts-extended = <0x04 0x07 0x02 0x07>;
>>>                             reg = <0x00 0x2007ff8 0x00 0x08 0x00 0x2000000 0x00 0x7ff8>;
>>>                             compatible = "riscv,aclint-mtimer";
>>>                     };
>>>
>>> The first address should be 0x20007ff8.
>>
>> That was intentional and I forgot to document it in the commit msg. The
>> "No FDT changes made" I said doesn't apply here. My bad!
> Thanks for clarifying. I also noticed this waring during my previous
> review and testing.
> 
>>
>> If you use 'dtc' in the current 'virt' DT you'll get warnings:
>>
>> dtc -I dtb -O dts virt.dtb > virt.dts
>>
>> <stdout>: Warning (simple_bus_reg): /soc/mtimer@2000000: simple-bus unit address format error, expected "2007ff8"
>> <stdout>: Warning (simple_bus_reg): /soc/mtimer@2008000: simple-bus unit address format error, expected "200fff8"
> Yes, the warning is valid, and I can reproduce it as well.
> 
>>
>>
>> This happens because the unit address in the node name doesn't match the
>> first address in 'reg'.  For mtimer@2000000, "reg" must be reg = <0x00 0x2000000 (...)>.
>> For mtimer@2008000, reg = <0x00 2008000 (...)> and so on.
> I agree that the address in the node name should match the first address
> in `reg`, as described by the Devicetree Spec [1].
> 
> However, I think the value that needs to change is the node name, not
> the first address in `reg`.
> 
> See ACLINT spec, an MITER device has two separate base addr: one for MTIME
> and another for the MTIMECMP registers [2].
> 
> In the current QEMU implement, `addr` is the MTIMECMP base address, while
> the MTIME register is located at:
> 
> 	addr + RISCV_ACLINT_DEFAULT_METIME
> 
> For this example:
> 
> 	MTIMECMP base = 0x2000000
> 	MITIME   base = 0x2007ff8
> 
> So the existing `reg` property correctly describes the two register
> regions:
> 
> 	reg = <0x00 0x2007ff8 0x00 0x08
> 	       0x00 0x2000000 0x00 0x7ff8>
> 
>>
>>
>> Now, does this change break aclint in 'virt'?  Because in that case we'll
>> just keep the "dtc" warning and live with it.  Aside from the existing tests
>> we have in QEMU I didn't do a deep dive in aclint.
> Yes, I think using `addr` here would make the ACLINT description
> incorrect. `addr` is the MTIMECMP base address, while MTIME is located
> at `addr + RISCV_ACLINT_DEFAULT_MTIME`.
> 
> Please keep the first `reg` address as it was:
> 
>        qemu_fdt_setprop_sized_cells(fdt, name, "reg",
> -          2, addr,
> +          2, addr + RISCV_ACLINT_DEFAULT_MTIME,
>             2, size - RISCV_ACLINT_DEFAULT_MTIME,
>             2, addr + RISCV_ACLINT_DEFAULT_MTIMECMP,
>             2, RISCV_ACLINT_DEFAULT_MTIME);
> 
> Since this patch is mainly a code-duplication cleanup, I suggest
> leaving the generated FDT unchanged here. The unit-address fix can be
> sent as a separate follow-up patch:
> 
> - name = g_strdup_printf("/soc/mtimer@%" HWADDR_PRIx, addr);
> + name = g_strdup_printf("/soc/mtimer@%" HWADDR_PRIx,
> +                        addr + RISCV_ACLINT_DEFAULT_MTIME);

Oh, I think I get it.  The correct fix is changing the nodename to use
addr + RISCV_ACLINT_DEFAULT_MTIME.


I'll do as you said in v5. Thanks for clarifying,

Daniel

> 
> --
> 
> LINK:
> 
> [1] Devicetree Specification, Section 2.2.1, "Node Names":
>      https://devicetree-specification.readthedocs.io/en/stable/devicetree-basics.html#node-names
> 
> [2] RISC-V ACLINT Specification, "Machine-level Timer Device (MTIMER)",
>      Section "Register Map":
>      https://github.com/riscvarchive/riscv-aclint/blob/main/riscv-aclint.adoc
> 
> 
> Thanks,
> Chao
>>
>>
>> Thanks,
>> Daniel
>>
>>>
>>>> +        2, size - RISCV_ACLINT_DEFAULT_MTIME,
>>>> +        2, addr + RISCV_ACLINT_DEFAULT_MTIMECMP,
>>>> +        2, RISCV_ACLINT_DEFAULT_MTIME);
>>>
>>> [...]
>>>
>>>> +    qemu_fdt_setprop(fdt, name, "interrupts-extended",
>>>> -    qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg",
>>>> -        2, addr + RISCV_ACLINT_DEFAULT_MTIME,
>>> I think this is the original code that was moved here.
>>>
>>> Thanks,
>>> Chao
>>>> -        2, size - RISCV_ACLINT_DEFAULT_MTIME,
>>>> -        2, addr + RISCV_ACLINT_DEFAULT_MTIMECMP,
>>>> -        2, RISCV_ACLINT_DEFAULT_MTIME);
>>>
>>


