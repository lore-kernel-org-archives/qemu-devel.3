Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAADAC4451C
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 09:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wl1FL-0001K4-BU; Sat, 18 Jul 2026 05:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wl1FJ-0001JT-Gy
 for qemu-devel@nongnu.org; Sat, 18 Jul 2026 05:22:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wl1FH-0005er-4m
 for qemu-devel@nongnu.org; Sat, 18 Jul 2026 05:22:09 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66I6QhsP109333
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2026 09:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HFTc35Qbzp9IgagBaDJM7DnhM5XVkuyMyRVESq9ntxQ=; b=AzLdpdYENpF/rpIe
 YbKhnAHaWwzcPLYl8oPdj3NU+ZR7jh4R3ik1RERac+IR6+9c12aXk6caTzz8xFqB
 5TcJUyNKgW5Ks2FD9QqdgCNTLEjnL+RunWYFsY1IkN78Hgqdw8IdOZe30tfb0LEb
 crHcn0PrXD53ucS/89VSo+QwCLOdl/vW3k93ZN+Zy+0EPDUnEaMmh6q+YQX4JryJ
 BGyHWpvFwgkDCnv1GL+t8HIOOmIAD7NVDNcOZdlyPKYHzN6rITZX6NJ8eDXJjRxL
 X1oLUtMn4DGULwUW9mYNyF5JFwZPu2E7sHmoAqfh028kultuQKo1iYMjfEW4xawJ
 jMAHqA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2d90ep6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2026 09:22:04 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-930b571432fso346057285a.0
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2026 02:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784366523; x=1784971323; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HFTc35Qbzp9IgagBaDJM7DnhM5XVkuyMyRVESq9ntxQ=;
 b=QZOz80Ux64gXZU4FieKkQMPIj7wsmZB6Ke7Y5rh8ULd83+9NBd4baYpJztPzlR+s1q
 27Vxew7eOC8Aows99coR221+XiZLEO1xGMUlgK3hl6l1CuQMeUzLfJ6xMe++o+jh8cNh
 82B88XqADKkjWSAPNe6TF3P81AXXRsrALBtYUswH/D9XkRhMcu42fzEVQIKKd7+iaQlx
 abWLJBeuupLH+6mPgln4mteXd0r7QkK32Igk1XaBc9GtClGf2vQi+7KhfDF9BzncBOYI
 9hrE+xseVCLLwkap+K84aVrsIB8fbNEmpWFNldq5Jh3BnYMZoeFvS/VVcZiGOVAztRDP
 NcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784366523; x=1784971323;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HFTc35Qbzp9IgagBaDJM7DnhM5XVkuyMyRVESq9ntxQ=;
 b=KGXco01LHb0rIyT/HjpfF0GBWpiLGslsIjkqRjRW3No4zSHhHMcw8Ucynq11Dk9rZe
 TP4uJmq47M0lOTC+NheH4WA2UFV6qHlKe1K2a1ZboHu+zMXZpYcvgnYQA+xn3G9U6TFo
 uv/kKnHOoEBX3GROt9fegFUIGpLZqjd6lMaERyxxkQPki55ObY4cE+IsOPBWhnBlsI4Z
 qkuyZbwHDX2Pd2dlrfvKEX1Pg8S8nsH4hvmyi4+X9WBg4/bBI6Avf92Fow4R/V45xmr2
 nBz3v8cqtAIkLyokOiVSIKyPXXl3fzfgMl6J8Nt1Me3zjSdtE8mIhPyIKu7ifYFnJEn3
 eG8w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqehXIcfxpLy5BaMzWGoqtz7Qb8bLZhdH8Xanov9R6rpf28KaF7LT2Tdo/lLaA4/CblsnTyG70t6FRJ@nongnu.org
X-Gm-Message-State: AOJu0Ywg/OeoqcepBRLNj/z4o9pZL84P/a5UFjEID37EB3SxJCfneCUr
 8dH09Re//1ogqVkrfkuxQmDM0nd/qR0yOFzMq1CUAdnQGyORs4MjLsJzTWWtSLI/Kn53i94X/7C
 3jobclZLhAUeYwIOEKXr2NJgML6JmqETC3bZUvi7mlC1FD/UkIeW5Bbor+w==
X-Gm-Gg: AfdE7cnYKGf4FV8odZcZWu6NGd3cOjyAjDUvUOb0eFQAGlcQ0M0qOWnuNNMMxuGyxSr
 PEF8E/B16cD4QjYy93DzkkAxJY6PHOwf2VNFoG/wXdkOmv3mOpT6/vjCf4i3SY/Y9f9itCyI3b/
 Ni0GVHvXXnSoVXx/WrFBUcbGq7Pl7RwKuTHlZMSJjumXUVWnMMiKjzIrSz4WhbzOeGCh8yy+wyR
 KCg3k+L0/ONWvgrVslTMWmmXR20TWmhlN4Pu/LwUMK9OYNLEjjeWy5tGSgd97rwThFseKcMKd1G
 NRusJqSDWnbEet9jkAmRGhgbQ2llI34+pWxn+gIdOW7pTmN4+oKs2a1Mh1MOEpzyuV7DK/MMpAy
 x0n7HFHBF1jZhVDGdvqjBgEJyqPysNTECuq1i0g==
X-Received: by 2002:a05:620a:bc7:b0:92e:c0ac:aeb4 with SMTP id
 af79cd13be357-930b4984cf6mr617191385a.38.1784366523262; 
 Sat, 18 Jul 2026 02:22:03 -0700 (PDT)
X-Received: by 2002:a05:620a:bc7:b0:92e:c0ac:aeb4 with SMTP id
 af79cd13be357-930b4984cf6mr617189185a.38.1784366522737; 
 Sat, 18 Jul 2026 02:22:02 -0700 (PDT)
Received: from [192.168.68.105] ([152.234.122.204])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-930b5300486sm374852285a.18.2026.07.18.02.22.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jul 2026 02:22:02 -0700 (PDT)
Message-ID: <19b3549e-8f13-4993-8da9-0d932f848068@oss.qualcomm.com>
Date: Sat, 18 Jul 2026 06:21:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/riscv-iommu: preserve requested perm in
 spa_fetch()
To: Andrew Jones <andrew.jones@oss.qualcomm.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, palmer@dabbelt.com
References: <20260717144525.1154204-1-andrew.jones@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260717144525.1154204-1-andrew.jones@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HpxG3UTS c=1 sm=1 tr=0 ts=6a5b45bc cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=J0RmenBMOwS19r/fhzI3tQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=_oshrryWAzALK6xgElcA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: G4wM_YERpjyWSKd64rFwXKvNkRiMl2Nw
X-Proofpoint-ORIG-GUID: G4wM_YERpjyWSKd64rFwXKvNkRiMl2Nw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE4MDA5NCBTYWx0ZWRfX29o4Cf3vwqt9
 vFon00vICIXrNCEx6RJ2UZBroQaOmNJBudqBVKS038vEusiHQwWgicDxTKNZmkixsje0PE0xLXY
 kFN/OXhH7iVVDs5brA62ljmxdhKOpqMIJmxQPoTepgN0GKxkROfWpKVbdk91pGslodeSac04SaE
 bmlxIyJSTl4iSEOanAf/k6Ac2f8JHNQHtl+z0r1XojbUbQ+aE9sgN9S1/yJHvGUD6XD0pL6MCVT
 vi6F6Zl0nE4YA6q7rl5wUUzRymy8NnLPol3o9adFjGkPmJbe+0xhfTCdFra45abKlTV1jY5W2K6
 2OJiUS0CzRetgLpvkHbpPRhrUUTx2dxdNWJHcQrYyh29jPi3IOiUmnq4xDowRN8SgO81itVBxKX
 Y6utK3jU2bLJBRuvR3TjkejargEAQfWHI5Nm1D9CGaOIkJBOejPwYrxzZJzXHOEmZFNg3KZE1tk
 +w914JFPnDBby1Foh/Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE4MDA5NCBTYWx0ZWRfXwITNrecmnDUW
 lWuHq0pu6a3fcl+RDJ+in8j2/QGdrBL1F7hK/2OabMp5Laa55hmR0LKQG4HHwJZ28i4y87otU/A
 4k/55n8UWR9jnk6dYZtW9WGORltxvnU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-18_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607180094
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



On 7/17/2026 11:45 AM, Andrew Jones wrote:
> b18e3f0e2d0f fixed spa_fetch() faults whose TTYP used the leaf PTE
> permission instead of the original request permission.  However, it kept
> that request-narrowed value in iotlb->perm after a successful walk, and
> riscv_iommu_translate() caches iotlb->perm for later accesses to the same
> IOVA.
> 
> That means a write to an RW mapping can cache the entry as write-only.
> A later read then hits the cache and faults even though the mapping allows
> it, which showed up in NVMe testing as bogus completions and controller
> timeouts.
> 
> Keep the requested permission in a separate req_perm and use it for all
> permission checks and fault-type decisions.  Accumulate the leaf
> permissions separately and copy them to iotlb->perm only after the full
> walk succeeds, so cached entries describe the mapping rather than the
> current request.  Since faults leave iotlb->perm as the original request,
> the S-stage and G-stage TTYP fixes remain intact.
> 
> Fixes: b18e3f0e2d0f ("hw/riscv/riscv-iommu.c: fix fault type for spa_fetch() faults")
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
> ---

Patch is good but it won't apply cleanly on master without applying the
other fix first:

[PATCH] hw/riscv/riscv-iommu: fix U-bit check to apply only to leaf S/VS-stage PTEs

You can either re-send this rebased on top of master or send these 2 fixes in a
patch series together, implying that one comes after the other.



Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/riscv/riscv-iommu.c | 50 ++++++++++++++++++++++++------------------
>   1 file changed, 29 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index ed9fb09f8bc7..323a041b4a55 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -281,7 +281,7 @@ static hwaddr riscv_iommu_napot_page_mask(hwaddr ppn, hwaddr addr, hwaddr *out)
>   static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>       IOMMUTLBEntry *iotlb)
>   {
> -    IOMMUAccessFlags pte_perm;
> +    IOMMUAccessFlags trans_perm = IOMMU_NONE;
>       dma_addr_t addr, base;
>       uint64_t satp, gatp, pte;
>       bool en_s, en_g;
> @@ -298,6 +298,14 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>       } pass;
>       MemTxResult ret;
>       bool pv = !!ctx->process_id;
> +    /*
> +     * Keep the request permission separate from iotlb->perm.  G-stage
> +     * walks translate S-stage PTE addresses before the real leaf is
> +     * reached, but permission checks and fault types must still use the
> +     * original request.  A successful walk leaves iotlb->perm with the
> +     * effective leaf permission for the translation cache.
> +     */
> +    const IOMMUAccessFlags req_perm = iotlb->perm;
>   
>       satp = get_field(ctx->satp, RISCV_IOMMU_ATP_MODE_FIELD);
>       gatp = get_field(ctx->gatp, RISCV_IOMMU_ATP_MODE_FIELD);
> @@ -316,7 +324,7 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>        * means we can't do an early MSI check unless we have
>        * strictly !en_s.
>        */
> -    if (!en_s && (iotlb->perm & IOMMU_WO) &&
> +    if (!en_s && (req_perm & IOMMU_WO) &&
>           riscv_iommu_msi_check(s, ctx, iotlb->iova)) {
>           iotlb->target_as = &s->trap_as;
>           iotlb->translated_addr = iotlb->iova;
> @@ -434,13 +442,13 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>                   masked_msbs = (addr >> (va_len - 1)) & mask;
>   
>                   if (masked_msbs != 0 && masked_msbs != mask) {
> -                    return (iotlb->perm & IOMMU_WO) ?
> +                    return (req_perm & IOMMU_WO) ?
>                                   RISCV_IOMMU_FQ_CAUSE_WR_FAULT_S :
>                                   RISCV_IOMMU_FQ_CAUSE_RD_FAULT_S;
>                   }
>               } else {
>                   if ((addr & va_mask) != addr) {
> -                    return (iotlb->perm & IOMMU_WO) ?
> +                    return (req_perm & IOMMU_WO) ?
>                                   RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS :
>                                   RISCV_IOMMU_FQ_CAUSE_RD_FAULT_VS;
>                   }
> @@ -465,8 +473,8 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>                                MEMTXATTRS_UNSPECIFIED);
>           }
>           if (ret != MEMTX_OK) {
> -            return (iotlb->perm & IOMMU_WO) ? RISCV_IOMMU_FQ_CAUSE_WR_FAULT
> -                                            : RISCV_IOMMU_FQ_CAUSE_RD_FAULT;
> +            return (req_perm & IOMMU_WO) ? RISCV_IOMMU_FQ_CAUSE_WR_FAULT
> +                                         : RISCV_IOMMU_FQ_CAUSE_RD_FAULT;
>           }
>   
>           sc[pass].step++;
> @@ -491,13 +499,13 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>                * non-user mode leaf PTE and !pv we need to fault.
>                */
>               break;
> -        } else if ((iotlb->perm & IOMMU_RO) && !(pte & PTE_R)) {
> +        } else if ((req_perm & IOMMU_RO) && !(pte & PTE_R)) {
>               break;                /* Read access check failed */
> -        } else if ((iotlb->perm & IOMMU_WO) && !(pte & PTE_W)) {
> +        } else if ((req_perm & IOMMU_WO) && !(pte & PTE_W)) {
>               break;                /* Write access check failed */
>           } else if (!ade && !(pte & PTE_A)) {
>               break;                /* Access bit not set */
> -        } else if ((iotlb->perm & IOMMU_WO) && !ade && !(pte & PTE_D)) {
> +        } else if ((req_perm & IOMMU_WO) && !ade && !(pte & PTE_D)) {
>               break;                /* Dirty bit not set */
>           } else if (pass == G_STAGE && !(pte & PTE_U)) {
>               /*
> @@ -532,21 +540,20 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>                   addr = iotlb->iova;
>                   continue;
>               }
> +
> +            /* Cache the effective permission, not this request's subset. */
> +            IOMMUAccessFlags leaf_perm = (pte & PTE_W) ?
> +                                         ((pte & PTE_R) ? IOMMU_RW : IOMMU_WO) :
> +                                         IOMMU_RO;
> +
> +            trans_perm = trans_perm == IOMMU_NONE ?
> +                         leaf_perm : trans_perm & leaf_perm;
> +
>               /* Translation phase completed (GPA or SPA) */
>               iotlb->translated_addr = base;
>   
> -            /*
> -             * Do a bit_and between the PTE bits and the original
> -             * request flags to determine the exact permission we
> -             * need, i.e. if the original request is RO and the
> -             * PTE has RW flags the actual perm is RO.
> -             */
> -            pte_perm = (pte & PTE_W) ? ((pte & PTE_R) ? IOMMU_RW : IOMMU_WO)
> -                                     : IOMMU_RO;
> -            iotlb->perm &= pte_perm;
> -
>               /* Check MSI GPA address match */
> -            if (pass == S_STAGE && (iotlb->perm & IOMMU_WO) &&
> +            if (pass == S_STAGE && (req_perm & IOMMU_WO) &&
>                   riscv_iommu_msi_check(s, ctx, base)) {
>                   /* Trap MSI writes and return GPA address. */
>                   iotlb->target_as = &s->trap_as;
> @@ -563,6 +570,7 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>                   continue;
>               }
>   
> +            iotlb->perm = trans_perm;
>               return 0;
>           }
>   
> @@ -587,7 +595,7 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>        */
>       iotlb->translated_addr = addr;
>   
> -    return (iotlb->perm & IOMMU_WO) ?
> +    return (req_perm & IOMMU_WO) ?
>                   (pass ? RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS :
>                           RISCV_IOMMU_FQ_CAUSE_WR_FAULT_S) :
>                   (pass ? RISCV_IOMMU_FQ_CAUSE_RD_FAULT_VS :


