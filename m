Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357E6CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 11:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNqg5-0006va-3q; Fri, 15 May 2026 07:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wNqg0-0006uo-0j
 for qemu-devel@nongnu.org; Fri, 15 May 2026 07:25:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wNqfy-00067L-0Z
 for qemu-devel@nongnu.org; Fri, 15 May 2026 07:25:55 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FBF1pO3219672
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 11:25:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CL1xSf9ptTIxSj7+unxG6pyDtdqcuY49OJA2sU//u0c=; b=Kmk/c65DWtM3Ww6w
 emsPj+jCqQFufK4xaTfkn9/8XoleIgwzJmPsBK5P+HIk2waqY+5x1jn3vLh2u0Cj
 hKPmuqqnbaPZbGuMRxD7Pvc+1jWVVTSJY2a39uZh0rIomH6bwAHzSfo1oblS129s
 Er+XOUiGLc1i9kK/Qa0d4HOi08vUJy4I0tqEbDZ8FIIVBq7reKakhW4foYiV7bSx
 wAWbI7rlBV5DC8HWKwuedtNwNCzOY5AriSafSi2VIdDrBiU2BnA0KB0iw3Jj6Lz2
 vEw5Pu4CYsNEPUCu7uh1s0zfXhL3qxCX0f8XvbNnAsAEaQXxTLF40p0fyYQCCa/6
 6nEK0w==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1s30qc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 11:25:51 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8b49260e3d5so133588296d6.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 04:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778844351; x=1779449151; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CL1xSf9ptTIxSj7+unxG6pyDtdqcuY49OJA2sU//u0c=;
 b=fFMVwp20+d+cNaBhhWXmmXh6rQUzpPR4BwJ0oTpVq72vDdHW1GRFXl7f+bBLF90Lu1
 yB38q2PwxZPtyuvE0RLJo++nEE8Ed7itGhFCKu9dLbeaS1HgqQ1u+GxAvtXmFu9aWEqb
 SfaULmAzDZToQmklzXvQZTAmyBi392OQ6L6RQrs7+16EdLuYMGcu+0iCoSxhnFCUQjND
 8smNU8I+I6P+1oNnAMAYOPL3shWiZgO9BcGDKvUVUwlAff3XygXH5vWSrafphecnzHS1
 UtmPyCERodJE14crG+fHqMG4oZwYtzC9qPfszb29bvtel2Dns6O0wj8hjhvJSMnqOKZ/
 3fQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778844351; x=1779449151;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CL1xSf9ptTIxSj7+unxG6pyDtdqcuY49OJA2sU//u0c=;
 b=DF5FIAFH5yZThnh/5Wh4LhZVHLlQVpbi+MGQj3Ppg0tssuChIa0yMok0Np0Ce6K8xQ
 iQohjxUfoDYi+bASKgrUpp3d3GxVmn19oXIoj2t75YquQbCFWZGVHsZy7klif4CE+rBC
 uk7ibADgaqEKEw0BJa4wMvxjthAqLXUQiotBwLe97WW8drta/2Reh7EAqKqYOLgFIgaQ
 nOS1DSpkmrKCXUxOG27x1BQzyrpL6OmuCyzLm+XnG4AGxWD+RFrcV+n0TLCGUZvy/uNO
 Gf2h/8xGygzUuLCC7PWAZxdHBw4kOTJ1bjYyms3/TYscm9WrasbCBVK92qFmKrJsD2PJ
 27Lw==
X-Gm-Message-State: AOJu0YxPlDGl6upbqB0n7pyJKvwZtvI6hWmuiCmcUuO1qnhcGKzGDh13
 LsPUP+KiXQtUvJepzcXrsd+bmDH1IVENqzV3ctC3oumjk1gbUOf/6+WcJg7Vj05HnqYi94jVOrU
 zb9zxK+DLLC9O0XtZGU2D1gV2oztflYGvzmM9/ZF9YXKM5jq/yJ6Dj02ovw==
X-Gm-Gg: Acq92OESPF0YkVY0aZKnHHkT73lGekb4IHXRnnMZYKF1fjAbPEyeIkLCaLNkStErJEH
 u1tlmWvDgGnPKni5sCTH9uL10o45YdvEUyUSNaYwc5cAmmI9zbhhp110N0tDJXPj5qGkAjTMd/c
 TRzTi5d98Zkq3wAIiRIZiP4iEQEWfxUb6Ogfx31cbFdApy7gEYqP2RQFUG9vFUQDeYUm8QRdsr0
 uVZ8TWE1PkvMoFH0BnffIrxJtEYC+Rh3/5U376lComhNy7FWaJOSJRcWELSU3xGtDpSV7FyKP0f
 eTyJ1zMzQRDkzf6d8Qp3EvxCZlIrqiDibWng3+33ZCQLCGuVF9FtuHU/HXu3gZF/R8AGn3SUE2l
 k4eThZIUXcl8PpMdfbMj6Rq4V9vb96lot6UprYvfLKMQv5K0W5tWUofcDW1I=
X-Received: by 2002:a05:6214:4a02:b0:8c9:bcd5:2856 with SMTP id
 6a1803df08f44-8ca0f6f95d0mr57543756d6.46.1778844351296; 
 Fri, 15 May 2026 04:25:51 -0700 (PDT)
X-Received: by 2002:a05:6214:4a02:b0:8c9:bcd5:2856 with SMTP id
 6a1803df08f44-8ca0f6f95d0mr57543096d6.46.1778844350811; 
 Fri, 15 May 2026 04:25:50 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8c90c164b19sm48687546d6.38.2026.05.15.04.25.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 04:25:50 -0700 (PDT)
Message-ID: <d2f5af2d-57d8-43dd-b599-7b280eb0fb6d@oss.qualcomm.com>
Date: Fri, 15 May 2026 08:25:46 -0300
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDExNSBTYWx0ZWRfX0omK5ALLlqve
 9VZx9Eu1JUfeXOh7zp/HOLn1Ra+qAi1SJ8lXxmN7Q3quZ6a5vDsPBxbRlrUiJYX0qcScNp1Ljdy
 VFTBOkeDg3bYpzGbhbExvnPOb105GSXVEe3cxWYnHug1Cpr1LN5ltAp6GNPkdWU9mVd1TzwDQgf
 Xz2PHejYoPnJ2PH70YqDmaGE7RMwmotuEpAMZHd45HnJ7iB0VB/XuYznZ+MW0/wB5cS8ffxrbc3
 ulksxGSgVPaMPJzOLGa6e/u61JUVBDGowF6R7q/Rw5nY6E/5sswTw3wfGie0zRz3nLiVOH77RSv
 RDp3lIO1uH0sGFBWxI9bQXEIzRXEqxdNvn9ckVwgbP3bSrwppqKXl2rCM8ooy6XWyZgZAK/97by
 R4CNJ0G/zP/frHjhV2ymtFYwC1XwOvtzua0zHICy7tya4ljcJmbaz1K9eJunOwxRkqiCQdf+a2l
 glxI9apKd/kcNl8T2eg==
X-Proofpoint-GUID: zjl6uA6Oj_ZhETK0fEDBkIAT7-VbIrma
X-Proofpoint-ORIG-GUID: zjl6uA6Oj_ZhETK0fEDBkIAT7-VbIrma
X-Authority-Analysis: v=2.4 cv=HJ7z0Itv c=1 sm=1 tr=0 ts=6a0702bf cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=mHkEaqlKh9Ly4tyT5M0A:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150115
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


