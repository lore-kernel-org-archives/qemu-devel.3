Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE60DCD37AC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 20:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNcON-0007IP-HB; Thu, 14 May 2026 16:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wNcOE-0007Hb-75
 for qemu-devel@nongnu.org; Thu, 14 May 2026 16:10:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wNcOA-0000v4-JK
 for qemu-devel@nongnu.org; Thu, 14 May 2026 16:10:36 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EIpREC3795545
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 20:10:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CL1xSf9ptTIxSj7+unxG6pyDtdqcuY49OJA2sU//u0c=; b=VltjwKWRvorjfjPP
 M82WEkLq2VqfATjOO5i7vPYcJdCl3107Rzo2MK7pC/Y99d8t+mcVPMp13B2H1uWh
 D41CLQdnloRV2GPtaztE0xc3xAoxkyU7myhR1HSjZzCcYXVoYfaq8oqzmAmVBbCD
 VqGSK1dWoIaVcQTtXYG+ooPx/NLOXRS1utncBA3QwdBF8XfCaDM9dxsAC/w+3Ke5
 SAW5NqipMD6qSSqwo1UzufiWVYX7uDsY9aY3KdQc0QkMYtKaZ1wwwmBcctzNZMLn
 pk19p7uuqx9z8iUV4cHQ7lcQJwOWgLLQ97TtNAfwGhsEP8YxfHaDnIvh/+ANLXxP
 RO0vXQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1sr7p3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 20:10:31 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-91030497912so357668985a.0
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 13:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778789431; x=1779394231; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CL1xSf9ptTIxSj7+unxG6pyDtdqcuY49OJA2sU//u0c=;
 b=Qol1AWu9nxaCagR4mDp8eBHCVAM5JuAySZkR3aaYxTOupeRTOWa0Sal5sEERFUHWGK
 EqZnokwmoHJ7Tb0ylJITFzXZGJBp5lj+hp5kKV2RzhyrGQVK2RxFHA1WbKOwlRxzL6fS
 AV1uaUeU9+X/Qhenr1fKBGMe8SJs4H0xbE1lZuGHvrGkgBfuUjucDhbGjMBakrd27hK0
 +l/i3QeE7mB2gpbRJg7iRn8A7Qc+r5N/VLWORRxsJXhYeJ+oMjzjNV2DOxG1htoFkD2S
 4ozVfhOQ/EQ+pdf/9qjgoFqxfTZIQ1cR84fFnFJrTYkc9pJ0KbdpKY+6rCUmBnMTOc9T
 xg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778789431; x=1779394231;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CL1xSf9ptTIxSj7+unxG6pyDtdqcuY49OJA2sU//u0c=;
 b=R5Hkwu3cf+RKrwRMWQJWUEMXrIk2hhHzkPXK418ZZOXQSlSGc9u95S79zneMoVp0k+
 5o1JJhnAu5e0jsIq6Xr3jU8ROMnnzmwcZzG+nNGG3iD5+cKXtZkb5+YweB8C2ShSDiE/
 XLhQgCdcEmHd/M0GhALdClWkEoAs90z1MC5nqfXIjCioXRFVgBNtVG+POkE5/mLaO8aj
 T9664mifF157s6NKrLp2Acie0YM8BIvJTafQZT0GI9bIxaj30AuyNKFD15ipsDPVXNmY
 etp5TVDoob1SlsRv6EHCrsM0UDJqRJfM43wmScdF0Ait99lgvVNtStr355AVB2s52ZXm
 3gzQ==
X-Gm-Message-State: AOJu0YzHtAB5LoWxvTbgT5tENooSvYimEoA3DN9ETvzKUSMRFk1ymEaH
 z64z3brEcZ/epY2o+nwVVsO7LZhEyOKGXHm97CRibMKCSzwlHg39pBu+Hbb0k4zaU8wwz6FST9e
 bmvD431g5T5iWtEAoPoszJ3ATHfGUk6E5L8cK/ZbvfvXjYZ7heG8HZrMZBA==
X-Gm-Gg: Acq92OEnqnQ6yk3I6EbAjqWh5B1qD4bL8fSSEDf1cDebGZGLlXFZvinomiUmKCuSXzY
 bC7IVXYtlS6pncU4FJ2Gd6QetUeA6pN29RIqg2Bsp57AJ8j6acncoIK9zMkBrJJyNB5oH/Hdr5m
 I+hNZAoAhvMHG6zpeHJmaOKQM7QrjAj6bji4dyru+fDh6FLZ45mBYklPa1+qm09VRpzHBf/AgON
 /YkQJwbtl3z3apHbVQbyLDGHw0B66hX1nhDl+GODkgonyf02nqi7H5j7hGvIVaMmrjQLSLOMsHK
 4WesoDVxU/PEHvJ71ICzp2sNL7Pe4jUHXtuivLHdNc0IKYPNNC+ZB4HIhiJc4bQAZ7aIjDHJhuz
 VJR7pMVctvmtdvWfsy+9VRp1LI3JXX1iuDd5vFYcKivye+Sob3BhMQRSF9ME=
X-Received: by 2002:a05:620a:4542:b0:910:87f4:9a14 with SMTP id
 af79cd13be357-911ceb14a8amr184687685a.28.1778789430681; 
 Thu, 14 May 2026 13:10:30 -0700 (PDT)
X-Received: by 2002:a05:620a:4542:b0:910:87f4:9a14 with SMTP id
 af79cd13be357-911ceb14a8amr184679885a.28.1778789430142; 
 Thu, 14 May 2026 13:10:30 -0700 (PDT)
Received: from [192.168.68.103] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8c908f0cdf0sm32217796d6.18.2026.05.14.13.10.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 13:10:29 -0700 (PDT)
Message-ID: <c3a1ac8b-10c4-4262-bc67-f5f141bbe075@oss.qualcomm.com>
Date: Thu, 14 May 2026 17:10:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] hw/riscv/riscv-iommu: Avoid caching PCI device IDs
To: Chengbo Gao <gaochengbo@bosc.ac.cn>, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20260514020637.2819308-1-gaochengbo@bosc.ac.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260514020637.2819308-1-gaochengbo@bosc.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE5NyBTYWx0ZWRfX0+52YM1K8wEa
 Qv2riiZaYdQwiGkW+SGxKklSERqpd6szciGrBTqSOaF2B4Pbaws+nIo6+r5RzrxMBup5TwS20cn
 TdgsmMWW2FS+rCDsB/sAv4NIKxmix/hYpphWyvWVMrnntq13paeUgpOD3CxJgk7TM7ipmErb0GI
 AENLst1tVoJ2rLcxet5VKYqyInvb69ck5mxilXe14Uo19S560reyWQLGV3QdBk2qf0ppPN44CQk
 gkHACpNgOb1dtCG4YfmHZr45d8hOFTIsPew0aR+EPsss/scvP9jWcgeJmgwvYZzs5l6PZQRzr9v
 fDf2iPa5hkni170EpOlznsjeVxB+dgR3GVUIpIKB//CQ/3QrLtaOC7IEZ7CYBOy9e1qHFYPoyeU
 wdM1d7JFW3MudLnbA/4S47/jtI4JKkizUL6qG9i09kCvnRJH/iKWxwrTyyji3WFc5m97elodMHh
 54nfjxNekpte0o3bgfw==
X-Authority-Analysis: v=2.4 cv=cZXiaHDM c=1 sm=1 tr=0 ts=6a062c37 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=mHkEaqlKh9Ly4tyT5M0A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: fwTdhaBfudPAce0kFrd0OaBmHSFQO1BL
X-Proofpoint-ORIG-GUID: fwTdhaBfudPAce0kFrd0OaBmHSFQO1BL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_05,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605140197
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



On 5/13/2026 11:06 PM, Chengbo Gao wrote:
> PCI bus numbers may still be unassigned when QEMU initializes a PCI
> device's bus-master address space.  For devices behind bridges,
> pci_bus_num() can return 0 at that point because the guest has not yet
> programmed the bridge Secondary Bus Number register.
> 
> The RISC-V IOMMU currently stores a fixed device_id in RISCVIOMMUSpace
> when the address space is created.  If the guest later enumerates the
> device on a non-zero bus, DMA translation still uses the stale device_id
> and may look up the wrong device context in the DDT.
> 
> Store the stable PCIBus pointer and devfn in RISCVIOMMUSpace instead,
> and compute the device_id from the current bus number when it is needed.
> This keeps DMA translation and ATS invalidation in sync with guest PCI
> bus enumeration.
> 
> Signed-off-by: Chengbo Gao <gaochengbo@bosc.ac.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/riscv/riscv-iommu.c | 40 +++++++++++++++++++++++++---------------
>   1 file changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 7ba3240552..9a75639549 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -49,7 +49,8 @@ struct RISCVIOMMUSpace {
>       IOMMUMemoryRegion iova_mr;  /* IOVA memory region for attached device */
>       AddressSpace iova_as;       /* IOVA address space for attached device */
>       RISCVIOMMUState *iommu;     /* Managing IOMMU device state */
> -    uint32_t devid;             /* Requester identifier, AKA device_id */
> +    PCIBus *bus;                /* PCI bus of the requester */
> +    uint8_t devfn;              /* Requester identifier, AKA device_id */
>       bool notifier;              /* IOMMU unmap notifier enabled */
>       QLIST_ENTRY(RISCVIOMMUSpace) list;
>   };
> @@ -74,6 +75,15 @@ struct RISCVIOMMUEntry {
>   /* IOMMU index for transactions without process_id specified. */
>   #define RISCV_IOMMU_NOPROCID 0
>   
> +static uint32_t riscv_iommu_space_devid(RISCVIOMMUSpace *as)
> +{
> +    uint32_t devid = PCI_BUILD_BDF(pci_bus_num(as->bus), as->devfn);
> +
> +    /* FIXME: PCIe bus remapping for attached endpoints. */
> +    devid |= as->iommu->bus << 8;
> +    return devid;
> +}
> +
>   static uint8_t riscv_iommu_get_icvec_vector(uint32_t icvec, uint32_t vec_type)
>   {
>       switch (vec_type) {
> @@ -1343,15 +1353,13 @@ static void riscv_iommu_ctx_put(RISCVIOMMUState *s, void *ref)
>   }
>   
>   /* Find or allocate address space for a given device */
> -static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, uint32_t devid)
> +static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, PCIBus *bus,
> +                                            int devfn)
>   {
>       RISCVIOMMUSpace *as;
>   
> -    /* FIXME: PCIe bus remapping for attached endpoints. */
> -    devid |= s->bus << 8;
> -
>       QLIST_FOREACH(as, &s->spaces, list) {
> -        if (as->devid == devid) {
> +        if (as->bus == bus && as->devfn == devfn) {
>               break;
>           }
>       }
> @@ -1361,10 +1369,11 @@ static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, uint32_t devid)
>           as = g_new0(RISCVIOMMUSpace, 1);
>   
>           as->iommu = s;
> -        as->devid = devid;
> +        as->bus = bus;
> +        as->devfn = devfn;
>   
>           snprintf(name, sizeof(name), "riscv-iommu-%04x:%02x.%d-iova",
> -            PCI_BUS_NUM(as->devid), PCI_SLOT(as->devid), PCI_FUNC(as->devid));
> +            pci_bus_num(bus), PCI_SLOT(devfn), PCI_FUNC(devfn));
>   
>           /* IOVA address space, untranslated addresses */
>           memory_region_init_iommu(&as->iova_mr, sizeof(as->iova_mr),
> @@ -1374,8 +1383,8 @@ static AddressSpace *riscv_iommu_space(RISCVIOMMUState *s, uint32_t devid)
>   
>           QLIST_INSERT_HEAD(&s->spaces, as, list);
>   
> -        trace_riscv_iommu_new(s->parent_obj.id, PCI_BUS_NUM(as->devid),
> -                PCI_SLOT(as->devid), PCI_FUNC(as->devid));
> +        trace_riscv_iommu_new(s->parent_obj.id, pci_bus_num(bus),
> +                PCI_SLOT(devfn), PCI_FUNC(devfn));
>       }
>       return &as->iova_as;
>   }
> @@ -1696,7 +1705,7 @@ static void riscv_iommu_ats(RISCVIOMMUState *s,
>       pid = get_field(cmd->dword0, RISCV_IOMMU_CMD_ATS_PID);
>   
>       QLIST_FOREACH(as, &s->spaces, list) {
> -        if (as->devid == devid) {
> +        if (riscv_iommu_space_devid(as) == devid) {
>               break;
>           }
>       }
> @@ -2710,8 +2719,9 @@ static IOMMUTLBEntry riscv_iommu_memory_region_translate(
>           .addr_mask = ~0ULL,
>           .perm = flag,
>       };
> +    uint32_t devid = riscv_iommu_space_devid(as);
>   
> -    ctx = riscv_iommu_ctx(as->iommu, as->devid, iommu_idx, &ref);
> +    ctx = riscv_iommu_ctx(as->iommu, devid, iommu_idx, &ref);
>       if (ctx == NULL) {
>           /* Translation disabled or invalid. */
>           iotlb.addr_mask = 0;
> @@ -2723,8 +2733,8 @@ static IOMMUTLBEntry riscv_iommu_memory_region_translate(
>       }
>   
>       /* Trace all dma translations with original access flags. */
> -    trace_riscv_iommu_dma(as->iommu->parent_obj.id, PCI_BUS_NUM(as->devid),
> -                          PCI_SLOT(as->devid), PCI_FUNC(as->devid), iommu_idx,
> +    trace_riscv_iommu_dma(as->iommu->parent_obj.id, PCI_BUS_NUM(devid),
> +                          PCI_SLOT(devid), PCI_FUNC(devid), iommu_idx,
>                             IOMMU_FLAG_STR[flag & IOMMU_RW], iotlb.iova,
>                             iotlb.translated_addr);
>   
> @@ -2772,7 +2782,7 @@ static AddressSpace *riscv_iommu_find_as(PCIBus *bus, void *opaque, int devfn)
>   
>       /* Find first matching IOMMU */
>       while (s != NULL && as == NULL) {
> -        as = riscv_iommu_space(s, PCI_BUILD_BDF(pci_bus_num(bus), devfn));
> +        as = riscv_iommu_space(s, bus, devfn);
>           s = s->iommus.le_next;
>       }
>   


