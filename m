Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C316260A2606
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 18:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FWx+sNHI;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DUxVQJlw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQq97-00058F-TY; Tue, 10 Nov 2026 13:00:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQq96-00057x-Ju
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:00:37 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQq94-0007rC-Ba
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:00:36 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AAH5Sgr2900359
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 18:00:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ShpN89LBMVVV+LVkQNYEVu0VHsQJJmcxA48myNKptlY=; b=FWx+sNHIOhMCGfII
 A6fQ5VtbCegeyrxJX7mdLz1GY7jH85WmFJ/YFS6dXR13tSGBadR37OrMjSztDwyR
 R4U9Z0ZiD/5GpDF1IZV1I361E5DcT7MwrYl/iiogCCn3oQBRE9XjWGozazajXHBT
 hOrylZgOYdLlp9dEGtfz5QKUXf6pt6Kv+/NphTfMR/GzQT1kEs1IR+mItSpj8jG7
 d6liWN9rA3gt8T1aYkBNz297RK2LjHyjvVZs2MExJ4isrZCalf9t6QZZSJd1jdPX
 wB8hFf35JbcP1iAgNx+35LIkJkewULSccTcCZoJipQFYh4Qq30xJGjBpRbowL0zX
 mfon3w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv7c5g7vh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 18:00:31 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f2373e9b4so275687685a.1
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 10:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794333631; x=1794938431; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ShpN89LBMVVV+LVkQNYEVu0VHsQJJmcxA48myNKptlY=;
 b=DUxVQJlwZki1hOJ5/pygtHyPg6+RsBY1YLnzNctQ2u9lgiW/L2DPxqUW0sbRD6MkLy
 GS/4zMukAViwkmqgAwwYMAN0jSC0hl1M2uuymMU6noVetOCvFv82kFWzkt7CY/YMTB4K
 6xbhzZATjk8F9zWyfqyiNU9U1Q7+hOGxLljWyGO8KGCT3Bj7C3yKXWGZfMRr7H7o1amV
 w8YWxkVkbz1JrKf+raCCLnBuR7FOew58OiNMnuf2U4MoTg6aTbYZZKijJvrHCRUDybb0
 CPHEM6Im7KA1o+rtPmuA6fIkdOI5LewzrMRg6aNEp4fPy0dXMjqLNReL7uGfEmt2ru2r
 LbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794333631; x=1794938431;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ShpN89LBMVVV+LVkQNYEVu0VHsQJJmcxA48myNKptlY=;
 b=EErKtGl7rqKTnFMWuWWkYxty+TRCwHVPBWkdCvT5FJGcnsudleeouXrrrueL3Fvdfh
 9Yx9tU2y8kLx+kJW33sC4CiHg9MoC9zBWkKWxeED7qRNu0hK7P38HjskjjQYtrcajGEe
 rgNvWhfEN76P5B9jh1fQjXPXaIXgOHW18LvkPj35vS7EKvbyPRjZ6CDAuxY5WG1CmDEv
 ibpmJeYsR1Zy5dRjTG6J6OG/c7WbR7coyujyJleI+QroMRPKORxo0MF2mrargdSbdgk7
 TofrrBpYbi8ex+jEtc9JFObXSUqjcwMBfzibeR1H1wS1QFc77nDiWpWBW26MXRszY358
 jIkQ==
X-Forwarded-Encrypted: i=1;
 AL+hErENXPttlkSwP79PRsQxopPkTKGn+sEXv5qUlvSKhp07KInJvEFO3dIYH307YDZ8cJ+Z+QWHX0qiJy6H@nongnu.org
X-Gm-Message-State: APuU4Z+2K4ThDZO/qXuPO2roudJ+qlvCL0A8xEdYd1Qngn8C84+WqayW
 7TAq6xKGkASFVk81uDLA6k5wmXFbeOQ/D05J2q3kI/Ht0cVS3oAhfhswsEhY+rFgLSZenlHBbUp
 9SpJT1mOvSKDh7n4YGDMKCknkfz4Ht4MC/O3hJPS74+3ML2cPYdVRJECphA==
X-Gm-Gg: AYBFou1FMjY/w4XdoC2Pvd+I5QMy7og+UmC/YvXrorVRRjPCT3ntLaK85++2qy4O4rz
 WxeXDOR5tobqKXidPoVN5gmFj+J1++uqIfNnzJxE5JoIlEA/PpE/Ne2wa1b5Ux6jUainYUn2Eil
 DWA245Jx8eFxMQ7lV5QunvxBpDyZrPUnjfApIT6thRbTaLmSCr6ZH9KmxkBKLt6Kwq0AJ2sIFJu
 rED8tqiizkELsvv3pcuGcOELi/4PISeb0G6xZhF+1DDyWGTlMblT417j/XT9rG9QavV7p7FO68p
 mvpI48hm+P1nlDV3ef/xmhFQdbuSQnD15LIgWu0hbCPqoJHqQhLdrJk+Eiut+nZV9PwdJUj/r7D
 TqZWEmeQ52uq2poEfOYW6KaD1cTbxWEg8k/oIlAy8HnH6C+Yacj3A3Qime5xtAO6FIpl72uuml9
 xhx9blVlodwQ==
X-Received: by 2002:a05:620a:4588:b0:93e:bbda:dd06 with SMTP id
 af79cd13be357-9479f093c44mr600355185a.0.1794333630810; 
 Tue, 10 Nov 2026 10:00:30 -0800 (PST)
X-Received: by 2002:a05:620a:4588:b0:93e:bbda:dd06 with SMTP id
 af79cd13be357-9479f093c44mr600336585a.0.1794333629861; 
 Tue, 10 Nov 2026 10:00:29 -0800 (PST)
Received: from [192.168.68.105] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ef04ae351sm26469876d6.12.2026.11.10.10.00.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 10:00:29 -0800 (PST)
Message-ID: <bf2299c3-0f36-414a-9534-dc18fe380b0e@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 15:00:26 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/riscv: iommu: Fix implicit G-stage page-table
 accesses
To: Tan Chi <tanchi25@mails.ucas.ac.cn>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com
References: <20261108143934.129923-1-tanchi25@mails.ucas.ac.cn>
 <20261108143934.129923-2-tanchi25@mails.ucas.ac.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261108143934.129923-2-tanchi25@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA3MSBTYWx0ZWRfX6tJLmjZrl0XE
 +z6Am/gFfMMOuN150OYcfGKiD5lmH5wlojStkCdVbkUUp9PchijNMRXQQCxxny42QhYLdP+yhpb
 6Scc9XLGG5RJHlkA/xl1/FjdGNRWFoMCGFfC3NKz/8jBboMUuTdPLLeGqEkcrEclSxrAQCzbApj
 Nf4JvG2SrcBUysY0QplC5XRsX5jLxyS+YFFcbHkdeF2A4DR3vOn/i7JYpCtCf3n9Y3LA1be9Vz2
 GAnwIl4THYLtPlUcA2umPyv8IZXFJ8cjOBLMpNCyeBQdjfM3whS8KRHKMDXWxXvliNAEWOqYB6E
 2g3bmi7Uo5QL9XmEiSAA11rRiFYGuyYimd25umUu3LV/t2HW5vveDDGJ6pmBB4WPDKdmpm0tzYv
 SisJpthPSiUArcZri3Vy/fRWApOYy+Fr8Jq860vzksh0DY+gVyAM0ouqYOZfLUpoaLOg6OKqPqB
 Ogex73nGAIVa9Ya4GhQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA3MSBTYWx0ZWRfX8vil1s/gsiFh
 usD7REYSxfr0Y2HTrPa/B3hZRnYjEE7e+BGmpXj3XLRWC3Kol+fkfKWdomQtGnX6hpqcKAbrMH+
 FzCEXvdUMIAUeh6gET4YAa+3Wo7f3qk=
X-Proofpoint-ORIG-GUID: 9pgg-nBVlmEi8BZxk7wK3kDLrZdS2TXi
X-Authority-Analysis: v=2.4 cv=eq9KXYpX c=1 sm=1 tr=0 ts=6af35bbf cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=D8qwnNen2OYJ8iRmKIQA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 9pgg-nBVlmEi8BZxk7wK3kDLrZdS2TXi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100071
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/8/2026 11:39 AM, Tan Chi wrote:
> When translating a DMA write, G-stage accesses to first-stage page
> tables are implicit reads. The current implementation checks permissions
> using the original DMA access type, which may incorrectly require write
> permission for these reads.
> 
> Use read permission for implicit page-table accesses while preserving
> the original DMA access type for the final translation and fault
> reporting.
> 
> Also track the fault address separately from the translation result and
> set the implicit-access flag in iotval2 for guest-page faults. Route
> address-range failures through the common page-fault path to report the
> correct fault address.
> 
> Signed-off-by: Tan Chi <tanchi25@mails.ucas.ac.cn>
> ---
>   hw/riscv/riscv-iommu.c | 60 ++++++++++++++++++++++++++----------------
>   1 file changed, 38 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 0e6970773a..2dcc528599 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -273,13 +273,15 @@ static hwaddr riscv_iommu_napot_page_mask(hwaddr ppn, hwaddr addr, hwaddr *out)
>    * Keeping them separate for now, as error reporting and flow specifics are
>    * sufficiently different for separate implementation.
>    *
> - * @s        : IOMMU Device State
> - * @ctx      : Translation context for device id and process address space id.
> - * @iotlb    : translation data: physical address and access mode.
> - * @return   : success or fault cause code.
> + * @s               : IOMMU Device State
> + * @ctx             : Translation context for device id and process
> + *                    address space id.
> + * @iotlb           : translation data: physical address and access mode.
> + * @fault_iotval2   : Fault address and implicit-access flags for iotval2.
> + * @return          : success or fault cause code.
>    */
>   static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
> -    IOMMUTLBEntry *iotlb)
> +    IOMMUTLBEntry *iotlb, uint64_t *fault_iotval2)
>   {
>       IOMMUAccessFlags trans_perm = IOMMU_NONE;
>       dma_addr_t addr, base;
> @@ -299,10 +301,10 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>       MemTxResult ret;
>       bool pv = !!ctx->process_id;
>       /*
> -     * Keep the request permission separate from iotlb->perm.  G-stage
> +     * Keep the request permission separate from iotlb->perm. G-stage
>        * walks translate S-stage PTE addresses before the real leaf is
>        * reached, but permission checks and fault types must still use the
> -     * original request.  A successful walk leaves iotlb->perm with the
> +     * original request. A successful walk leaves iotlb->perm with the
>        * effective leaf permission for the translation cache.
>        */
>       const IOMMUAccessFlags req_perm = iotlb->perm;
> @@ -424,6 +426,14 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>           const dma_addr_t pte_addr = base + idx * sc[pass].ptesize;
>           const bool ade =
>               ctx->tc & (pass ? RISCV_IOMMU_DC_TC_GADE : RISCV_IOMMU_DC_TC_SADE);
> +        /*
> +         * G-stage accesses to S-stage page tables are implicit reads.
> +         * The original DMA permission is used for the final data access.
> +         */
> +        const bool implicit_read =
> +            pass == G_STAGE && en_s && sc[S_STAGE].step != sc[S_STAGE].levels;
> +        const IOMMUAccessFlags acc_perm =
> +            implicit_read ? IOMMU_RO : req_perm;
>   
>           if (ade && !(s->cap & RISCV_IOMMU_CAP_AMO_HWAD)) {
>               /* GADE/SADE are reserved bits if AMO_HWAD is cleared.  */
> @@ -442,15 +452,11 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>                   masked_msbs = (addr >> (va_len - 1)) & mask;
>   
>                   if (masked_msbs != 0 && masked_msbs != mask) {
> -                    return (req_perm & IOMMU_WO) ?
> -                                RISCV_IOMMU_FQ_CAUSE_WR_FAULT_S :
> -                                RISCV_IOMMU_FQ_CAUSE_RD_FAULT_S;
> +                    goto page_fault;
>                   }
>               } else {
>                   if ((addr & va_mask) != addr) {
> -                    return (req_perm & IOMMU_WO) ?
> -                                RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS :
> -                                RISCV_IOMMU_FQ_CAUSE_RD_FAULT_VS;
> +                    goto page_fault;
>                   }
>               }
>           }
> @@ -499,13 +505,13 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>                * non-user mode leaf PTE and !pv we need to fault.
>                */
>               break;
> -        } else if ((req_perm & IOMMU_RO) && !(pte & PTE_R)) {
> +        } else if ((acc_perm & IOMMU_RO) && !(pte & PTE_R)) {
>               break;                /* Read access check failed */
> -        } else if ((req_perm & IOMMU_WO) && !(pte & PTE_W)) {
> +        } else if ((acc_perm & IOMMU_WO) && !(pte & PTE_W)) {
>               break;                /* Write access check failed */
>           } else if (!ade && !(pte & PTE_A)) {
>               break;                /* Access bit not set */
> -        } else if ((req_perm & IOMMU_WO) && !ade && !(pte & PTE_D)) {
> +        } else if ((acc_perm & IOMMU_WO) && !ade && !(pte & PTE_D)) {
>               break;                /* Dirty bit not set */
>           } else if (pass == G_STAGE && !(pte & PTE_U)) {
>               /*
> @@ -587,13 +593,22 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>           }
>       } while (1);
>   
> +page_fault:
>       /*
>        * riscv_iommu_translate() will receive a fault and then call
> -     * riscv_iommu_report_fault() using iotlb->translated_addr
> -     * as iotval2.  Update translated_addr it with the latest
> -     * translated addr we have.
> +     * riscv_iommu_report_fault() using fault_iotval2 as iotval2.
> +     * Update fault_iotval2 with the latest translated address.
> +     * For guest-page faults, set the implicit first-stage
> +     * page-table access flag in the low bit.
>        */
> -    iotlb->translated_addr = addr;
> +    *fault_iotval2 = addr;

The previous logic was added as a failsafe to not leave iotval2 zeroed during
a fault (Gitlab #3559).  Now that you're adding a logic to calculate fault_iotval2
based on G_STAGE I think we can change the existing logic to closely match the
spec, i.e. iotval2 is supposed to be 0 for S_STAGE faults.

You can set:

*fault_iotval2 = 0;

At this point and then we'll calculate the right value if  pass == G_STAGE down
below.  I tested this change with Gitlab #3559 and it's still a pass.  You'll
probably want to re-run your own testcases again to be sure but I'm fairly certain
this is ok to do.


All the other changes LGTM.  Thanks,
Daniel

> +
> +    if (pass == G_STAGE) {
> +        bool implicit_read =
> +            en_s && sc[S_STAGE].step != sc[S_STAGE].levels;
> +        *fault_iotval2 = (addr & ~3ULL) |
> +                         (implicit_read ? 1 : 0);
> +    }
>   
>       return (req_perm & IOMMU_WO) ?
>                   (pass ? RISCV_IOMMU_FQ_CAUSE_WR_FAULT_VS :
> @@ -1740,6 +1755,7 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>       bool enable_pri;
>       hwaddr phys = 0;
>       int fault;
> +    uint64_t fault_iotval2 = 0;
>   
>       riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_URQ);
>   
> @@ -1776,7 +1792,7 @@ static int riscv_iommu_translate(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>       riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_TLB_MISS);
>   
>       /* Translate using device directory / page table information. */
> -    fault = riscv_iommu_spa_fetch(s, ctx, iotlb);
> +    fault = riscv_iommu_spa_fetch(s, ctx, iotlb, &fault_iotval2);
>   
>       if (!fault && iotlb->target_as == &s->trap_as) {
>           /* Do not cache trapped MSI translations */
> @@ -1827,7 +1843,7 @@ done:
>           }
>   
>           riscv_iommu_report_fault(s, ctx, ttype, fault, enable_pid,
> -                                 iotlb->iova, iotlb->translated_addr);
> +                                 iotlb->iova, fault_iotval2);
>           return fault;
>       }
>   


