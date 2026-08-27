Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1E8C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzaRE-0000rj-Sk; Thu, 27 Aug 2026 09:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzaRD-0000rJ-0j
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 09:46:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzaRA-0006S0-OB
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 09:46:38 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RD0l5l009742
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 13:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i0imSLtgBXMas12s9HcmNMuFGs6Kjl324WrLMCPMZh0=; b=cOBM9ZIAtv/Ng/RF
 zBpnIZejfD85xfc+yxmlXmZn49tiU4B0iRGsL+Ppxg8FR0ancLFjEjFfUffcTkGN
 1ELIxtTPMPymzEnVXJx1CHTa5dSrFhi4O06abMi0vJQPl2q2aCk7gzSFxM3+cGH7
 3XpYEiq76bNOonEYhwPv+EznmQu6x+OX7o9KI/A+OPPzwNsHUFNQIV7u3BMU5lOm
 wJcqbHO6pBtsEiNFI7rhtk9PVeXzpG+e5p7RFm4cANEG9pHlbeFP7j2//u/y2Dt+
 y1cOasLv9+eT92P0Fh1zsYK+iUAAug5S/AkhhiW3Ke4gZosRFuoqK7yCEUogo+7U
 grS0wg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ganr685hd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 13:46:33 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-936e393061dso175172185a.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 06:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787838393; x=1788443193; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=i0imSLtgBXMas12s9HcmNMuFGs6Kjl324WrLMCPMZh0=;
 b=FH4di/ww2S8ISy6z9Z1t6fLDAg7SfBjFrRN+2/oT6r6VWWEunnmWO5w5jSVIb/Sjgf
 jUjzflQz56qB6JzoeH5pfdFeUEh3Csw9QDZ9KDl3X80trJ4Ma4UeTAsXVUWFDPuUxn8X
 tGpqeomY8bJBIzwZJehrXMFDQTKk9kmk79fD+9dj7kPXn+ngVTbzToxSMbTZP1j1habZ
 6sOCNyY4jdcEvZhd8JzDMTCygp0+NyvscjRsyVF+fVooXqzKkE17Gq0HRY/DeKwNEN8W
 hf1BZbg+PLKbx8afL+91p4u/vIA5ti5CdusmKvmKKH82y6JLDIozxT8pjpRxc9jsJczT
 0IjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787838393; x=1788443193;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i0imSLtgBXMas12s9HcmNMuFGs6Kjl324WrLMCPMZh0=;
 b=plyUhCADCE5NOgIZfOY2SmPdXQidoPBIXalYbP5uf+iquKrpFpuJvqXH49jW/B4+j0
 mmRKrI3UF8G+jiuWxVUxB+9dVgUBSX7bVpabsSLTUFOwGUqEWKHkU9siC6yergLYxjEs
 y3cclSYdqYMqje1R6IAKg7r4nvgBMwzgupsiPHKDuhmsdLqUuFI3Z2uXCapIU1uLQ86v
 DvJ/5MQeq74sWoUyJzZY8fJUlh1t4oOKndN/ySD9m6hN992DfY2EDV2KXnfa1idL9Iow
 ljHw7aB7xyXpBGarUzZXZ3Al+r/7vRTZ5RIM93A8Dgw8LzrdMehYFjtNpjcBnws+DTAx
 PUcw==
X-Gm-Message-State: AFuF++l9nbLpIh3FyQZM9fXQbHjtQVJ+hwD2swTld31v2rmr7hLDxHad
 OLGDvU902QsECD3cLftDtQ1mFll7f9qLOTs0YWHxXIjT0yY4ZlOR4O4hsiNSUaNpsl/0iPJ9r70
 dypHWRwPHcRESErAkIbv0n5MXecMs8+QK4z/bnJz7+ov3JpaSPspc/ZFGeQ==
X-Gm-Gg: AR+sD12JX22YESTQsDlbKv4pkR08Ebj+bR7sFJjgFa1vwji09LzegoUsJ8vswY9sw7n
 cUUmJCeOno4uA1u2n7bRcjyMt8Dy5l2/AiGJSb0p0mHX/lD4t4sFKtJ/lGch/v9aurUae++xNvh
 b8ZaB+NMrufUh/NYEx0OvVVNmqSU+6gulDqJC1zQQ2rCobJXqjDXfER/3rxOGn27OI2X34bACZm
 zUwIKOkGM53K+6E1wJG2JnW2mZmPCm5QWAI7B2ULrgvRtZv+rmjOI478S2LqZmSRAGXZk1O8+X9
 QOVKtUm6ZBALh+J0AFi7VJRjfG6E5fb1T/rFnxLxF5+P7pLObI8BFZQDAyJ89wWpLItSpxKo1vp
 u+gQkd81BqYvM5rxheaNqJDMyIG2ZFKMVSvwP
X-Received: by 2002:ae9:c213:0:b0:936:cda7:554d with SMTP id
 af79cd13be357-9378016fc1dmr1414646585a.14.1787838393126; 
 Thu, 27 Aug 2026 06:46:33 -0700 (PDT)
X-Received: by 2002:ae9:c213:0:b0:936:cda7:554d with SMTP id
 af79cd13be357-9378016fc1dmr1414638985a.14.1787838392455; 
 Thu, 27 Aug 2026 06:46:32 -0700 (PDT)
Received: from [192.168.68.100] ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9377e36879asm449072585a.17.2026.08.27.06.46.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 06:46:31 -0700 (PDT)
Message-ID: <36d95fcc-bd0b-49b5-a6cb-017ab83ef906@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 10:46:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/14] hw/riscv/fdt-common, virt.c: add
 riscv_create_fdt_riscv_iommu_sys()
To: Joel Stanley <joel@jms.id.au>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260826214643.122728-1-daniel.barboza@oss.qualcomm.com>
 <20260826214643.122728-5-daniel.barboza@oss.qualcomm.com>
 <CACPK8Xfizz2EBxq+iyTCRxUCEek-vXaMeCuN1nJACVeSky_g-g@mail.gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CACPK8Xfizz2EBxq+iyTCRxUCEek-vXaMeCuN1nJACVeSky_g-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDExNSBTYWx0ZWRfX5lgiQOiModi8
 sOymipysV+zdI6n98nK/a1PJ2TxnTDd+/82YlwJpFjj68UQ8QiEbLV+ctW7Lxz/WXe/AhvwyUKc
 +zxu20nhCGp+kPidtxdyK6zNb9Nn7/fIaiUU/niybubC1g5T3tkrUM+B1nbwj4I0tQs/nnouck0
 qctKtKFXFDZDJYxOPaCR2iKhd89mhy8oEfqmZAUIJHAvgrMHRZb10FFNMVUhNHdJVYNf8l+HbLU
 /RFBgjcsKYE7DbdkbC5wc3Sny7YXv2Hw81xW6NIKFvArxVvW8NM2+KA7g7mrCVaFI3u9S66YLEc
 AaQEBQ61T8qnhG0rZnyC9J9D8P2suWvehRyL44kgWRGhIorXI6QJeqJGf8DgSjConLhlTzE0iDR
 TM81gftTKXv+I/dWMjET5Xsp2bIBrz5vhV+0bTMq6LF4KN6yohbGxGINcfypQS6VJ9pUxjt+fHm
 OJdjSdVrzFpsc4hId1Q==
X-Authority-Analysis: v=2.4 cv=d5DFDxjE c=1 sm=1 tr=0 ts=6a903fb9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=40UlVwmG8s1rjtrzD7wA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: mHJ1tkhxnEZ3_zKJUiqljIP7RYKuHn9F
X-Proofpoint-ORIG-GUID: mHJ1tkhxnEZ3_zKJUiqljIP7RYKuHn9F
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDExNSBTYWx0ZWRfX0nWISFGiXcLS
 xPq5NWRt6gCkSk7IDjsrU6S+UKTJznOuJtWZGIfiRuuvQ+/SFfFsezDaRxbHnpdX+ltF6s+hBfF
 E1Eb0jeL0MyuKCi/6hcfZ/ifVR2aBaM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270115
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



On 8/27/2026 2:55 AM, Joel Stanley wrote:
> On Thu, 27 Aug 2026 at 07:16, Daniel Henrique Barboza
> <daniel.barboza@oss.qualcomm.com> wrote:
>>   void *riscv_create_board_device_tree(const char *model, const char *compatible,
>>                                        int *fdt_size)
>> @@ -348,3 +350,41 @@ void riscv_create_fdt_syscon(void *fdt, uint32_t *phandle,
>>       qemu_fdt_setprop_cell(fdt, name, "value", poweroff);
>>       g_free(name);
>>   }
>> +
>> +void riscv_create_fdt_riscv_iommu_sys(void *fdt, hwaddr addr, hwaddr size,
>> +                                      uint32_t irq_chip,
>> +                                      uint32_t msi_phandle,
>> +                                      uint32_t *iommu_sys_phandle,
>> +                                      uint32_t iommu_sys_irq)
>> +{
>> +    const char comp[] = "riscv,iommu";
>> +    uint32_t iommu_phandle;
>> +    g_autofree char *iommu_node = NULL;
>> +    uint32_t iommu_irq_map[RISCV_IOMMU_INTR_COUNT] = {
>> +        iommu_sys_irq + RISCV_IOMMU_INTR_CQ,
>> +        iommu_sys_irq + RISCV_IOMMU_INTR_FQ,
>> +        iommu_sys_irq + RISCV_IOMMU_INTR_PM,
>> +        iommu_sys_irq + RISCV_IOMMU_INTR_PQ,
>> +    };
> 
> Any reason to pack them into an array? Seems like they could be part
> of the qemu_fdt_setprop_cells call:
> 
> qemu_fdt_setprop_cells(fdt, iommu_node, "interrupts",
>          iommu_sys_irq + RISCV_IOMMU_INTR_CQ, FDT_IRQ_TYPE_EDGE_LOW,
>          iommu_sys_irq + RISCV_IOMMU_INTR_FQ, FDT_IRQ_TYPE_EDGE_LOW,
>          iommu_sys_irq + RISCV_IOMMU_INTR_PM, FDT_IRQ_TYPE_EDGE_LOW,
>          iommu_sys_irq + RISCV_IOMMU_INTR_PQ, FDT_IRQ_TYPE_EDGE_LOW);

No particular reason.  I'll make the change.

> 
>> +
>> +    iommu_node = g_strdup_printf("/soc/iommu@%"HWADDR_PRIx, addr);
>> +    iommu_phandle = qemu_fdt_alloc_phandle(fdt);
> 
> Ohh, that's neat. Any reason we don't use this for all of phandle
> allocation needs?

So back in the day we were using a fdt_phandle int variable around, incrementing
it and using as phandle for nodes. As you might notice in the boards we still have
a similar pattern going on.

The choice I made with this particular fdt is because I didn't want to pass a
'phandle' argument to the function.  Given that the iommu FDT is the last DT that
declares a new phandle I could get away with it.

Otherwise, if there are other DTs that follows it and are assigning DTs using integer
increment, there's a risk of phandle collision.


> 
> We should be consistent, so switch this one to the pattern used by the
> rest of the file, or (preferably, IMO) switch them all over.

I agree that we should allocate phandles in an uniform manner, whatever that strategy
is.  To use alloc_phandle() everywhere we would need to take a look at how every board
is handling their own phandles first.  I believe this is worth doing, but out of scope
for this mostly "move stuff around" series we have here.

> 
>> +    qemu_fdt_add_subnode(fdt, iommu_node);
>> +
>> +    qemu_fdt_setprop(fdt, iommu_node, "compatible", comp, sizeof(comp));
>> +    qemu_fdt_setprop_cell(fdt, iommu_node, "#iommu-cells", 1);
>> +    qemu_fdt_setprop_cell(fdt, iommu_node, "phandle", iommu_phandle);
>> +
>> +    qemu_fdt_setprop_sized_cells(fdt, iommu_node, "reg", 2, addr, 2, size);
>> +    qemu_fdt_setprop_cell(fdt, iommu_node, "interrupt-parent", irq_chip);
>> +
>> +    qemu_fdt_setprop_cells(fdt, iommu_node, "interrupts",
>> +        iommu_irq_map[0], FDT_IRQ_TYPE_EDGE_LOW,
>> +        iommu_irq_map[1], FDT_IRQ_TYPE_EDGE_LOW,
>> +        iommu_irq_map[2], FDT_IRQ_TYPE_EDGE_LOW,
>> +        iommu_irq_map[3], FDT_IRQ_TYPE_EDGE_LOW);
>> +
>> +    qemu_fdt_setprop_cell(fdt, iommu_node, "msi-parent", msi_phandle);
>> +
>> +    *iommu_sys_phandle = iommu_phandle;
> 
> Could we just return it? Or have it passed in, so we don't need to return it?


I guess I could not use alloc_phandle() and receive the phandle from the caller.
It would be consistent with what we already do in other cases, and then when/if we
decide to change everything to alloc_phandle() we'll do it in a consistent manner.


I'll remove "iommu_phandle = qemu_fdt_alloc_phandle(fdt);" and make the caller provide a
valid phandle in iommu_phandle.  Thanks,

Daniel




