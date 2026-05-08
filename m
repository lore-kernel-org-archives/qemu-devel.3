Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472B2CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 21:30:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLSlP-0004md-Gj; Fri, 08 May 2026 17:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wLSlO-0004mM-KQ
 for qemu-devel@nongnu.org; Fri, 08 May 2026 17:29:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1wLSlM-0004wx-K1
 for qemu-devel@nongnu.org; Fri, 08 May 2026 17:29:38 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648D2IuQ257891
 for <qemu-devel@nongnu.org>; Fri, 8 May 2026 21:29:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=lxs28VRXIfP0IGQvTYYzP8cr
 XF1DaNqHyCTeljnIdBc=; b=GXb4q2uNt25hC29GiU0beCp0A9RtG5scTK7W85EN
 mNvjeFFueXSri24khA6QCCYdXuH9nlerHWzR4w1+QVHKRggA2jcL5qF5xwMCKSOG
 uR/YHb2dlp2uKuZDg/MK89zPFGh5DMvs3Glb6sw0PwqtnaOOEQo3HYxb4dUUsMFA
 Q9HEQcr7ws3dmbIHKXL0EZ8o6NGedFzt4biDfj4gD2USAVlHOweWKWehAxZPRJfh
 iXKwhjC3jGnRQ/hn+c++RVx7YE887X7UrayizvyJz0VgBMvHv+YhsLOKG7025Bt+
 AT+w0ERLpogdvi1yyeDS5OdYh2u1xkqJIO1KRFuS6nE8dw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1auek6cd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 21:29:34 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-12df8bc580cso1600198c88.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 14:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778275774; x=1778880574; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lxs28VRXIfP0IGQvTYYzP8crXF1DaNqHyCTeljnIdBc=;
 b=LxLshurlyhaSvxswkd/ZXwaHYutTgt1TEZRsSQpiOmFGSz0Wy7N+6eCOsmZsxdlf5m
 OivKxNPT1uE+7bf9K+APRoouJBpjFMaT5p03pGEimjbUr/yImfrjdYH0NZUDdsqOV2ie
 K+37qK83LXGrBO5O0MA2tKTTS4qYTjxQ8JAfVcBCZ1Tl8F+1HvR76Md1o5IW8aTyXnee
 jwrmijdTagF1btqax9yYgfDXv22pwqMTfSoGFoWVsZIjB4X7/SJ6Pq7r3YUE1mNLj1js
 OVH7kNwtkVLvYy0ChgkqdBi5xBmk/HWiA9FvUkenNBe4rIL77clVc9OAFBIq4GTk6GCj
 uQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778275774; x=1778880574;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lxs28VRXIfP0IGQvTYYzP8crXF1DaNqHyCTeljnIdBc=;
 b=UlCKZoq7LY2g46ELcv2n/vJbu/7Uk8832EZOR2/0hr98LhizylmvtJ7SowhPyY1AUO
 1Nr3isJ6HadfBtxAhNnYj2pB52yF5uKkK7bcpWXThp0a3ixZipGWzyRwN3XNuJVG/H2H
 UeB617SB1ls4OZeETMg4kf8yCxCrP1O3admB5kSZHM1UP+hQ025xYPDbxD2p94D9zBvT
 4P8G4L5Bb9ASxhcZ4TY4sMmHDM/A1GlrG2B/PM/e8uyua3TpwSyzzvTGTvmsHjxzdzd1
 kL6oIaHqoVYKequP40g35wsA+DebyhZwljDmx2HwnfCid+H/bqITbbsXS3GL0Qe7Za5e
 Sxdw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8F31QtADi8zY8PP8Lfm35GgA6VVxh83C+baU0M7qDjjLz8xwm+lwzLzG41yYlxUNIjrnWEndXwqEfs@nongnu.org
X-Gm-Message-State: AOJu0YzS6SLeFMSUzFepbuz0vrb+lUVdOA5sYm0PuktY+MB74y/eK8as
 3jGRpF3WAAXTMdik0AAHT5XlBZ6lLFplpJZ7RyaglwjjAnvnfRfgEUMAMFyDQx/2p+5Qos6fGSL
 nlzTfEScfifwb+N6h7zQ7IhiRSTtYo4DMvrzZNU4aSaOr9OOm4evi+ocFjw==
X-Gm-Gg: AeBDieu8PZD1tR1LRYLpCgAFMhOyBQb2l/K+whww/hKFWDUIE8GBnntfo4SAGFiLVMI
 hA6Z5EHZNwpwtbvmnNhnrqAQWG6LLwjNxBkQzkiXskn9xlhISv1mi2FiRLa0jHby6VFAU94tGKA
 nijs8B1N37Nh3hlwL+OsC4or8nLVQsEErkMCsVOVCPFBi4LjO5zM5tkeTe+LDTHRyJx2o5bdx25
 hQJvCgBkJnSDxqAX+sGCY9DO78GlrTrCfs+rc4kMX0Pz0dzABJV0NGL0SJfQRAaycjHcitRJA2O
 NzJ3feH1G8oMfryszybKbkJXgwVKNW6GZ/JGCrOwr6vvUmnrGVo0g1ZDLTWVTplZjvC/j2mTJR/
 SB+Lw8KQbNfAVkAF9xqLMASHl5QumJVJIidHINXXY0Q==
X-Received: by 2002:a05:7022:6b84:b0:129:1d25:f1da with SMTP id
 a92af1059eb24-1323aa56cfamr4063692c88.3.1778275773562; 
 Fri, 08 May 2026 14:29:33 -0700 (PDT)
X-Received: by 2002:a05:7022:6b84:b0:129:1d25:f1da with SMTP id
 a92af1059eb24-1323aa56cfamr4063675c88.3.1778275773019; 
 Fri, 08 May 2026 14:29:33 -0700 (PDT)
Received: from localhost ([140.82.166.162]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1327810ff4dsm3972342c88.3.2026.05.08.14.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 14:29:32 -0700 (PDT)
Date: Fri, 8 May 2026 16:29:31 -0500
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, palmer@dabbelt.com,
 daniel.barboza@oss.qualcomm.com, tjeznach@rivosinc.com
Subject: Re: [PATCH] hw/riscv/riscv-iommu: Fix Svnapot 64KB pages
Message-ID: <h6bbn25obwet4wvv5u4pjtdsndqjsywzsh5kojpv34ow73p5b7@vqnlfxfwbaqv>
References: <20260508205129.377032-1-andrew.jones@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508205129.377032-1-andrew.jones@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDIxMSBTYWx0ZWRfX3ifkOCJNoqFo
 P0Qk6Mwp00oP+/7ixKpvM8kmNbxFZ+7zavTNY3H8d7wbIQ9l4X9AzRIvU5J8LNK4wLPaSVTVeK5
 c/rsYKs4s8wmgPl8bohpMZ5k360D9d4LopU7KxL7NVqL9x6HDLYm0I3f/jA8FejWJqdx3jn4L57
 r3oDCCkZyNTSfWEyOZL9+WOSTg9XMmcDDd2Q+2qqypQBi3Rzo8MREXbQsKSc/LY3UVOq/JEJC3L
 r6GSevzps+sflEusKZ5a1lZiC082umSMzOQvozac0VQvIx9dKqj6h6b7CJ496Ap5upQN0APKy5j
 Ree4S6WDwe4Eoy+xpOaiU5YsZlhIn7qlSL3ALVn3AMg5Sk3J6RMS6jNKhB7hAxNXRNwMQfrKYfz
 h6Xr+I0rnlbGJjq6I4+pn65JEDXD2jRi6cq6ye6Rirlk5MQBR0/y3KXt//nEOQMBc1x17SuOn+d
 ySdFG0SE20NNF9vJGrQ==
X-Proofpoint-GUID: LXnbiAEiaL2TCtcvUV0czM4_vTI0ZzqV
X-Proofpoint-ORIG-GUID: LXnbiAEiaL2TCtcvUV0czM4_vTI0ZzqV
X-Authority-Analysis: v=2.4 cv=fcydDUQF c=1 sm=1 tr=0 ts=69fe55be cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=cvcws7F5//HeuvjG1O1erQ==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=69wJf7TsAAAA:8 a=DFJLJhpOamtIQcbWox0A:9
 a=CjuIK1q_8ugA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080211
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=andrew.jones@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On Fri, May 08, 2026 at 03:51:29PM -0500, Andrew Jones wrote:
> The Svnapot extension encodes a 64KB leaf PTE by setting PTE_N and
> storing bits [3:0] of the PPN as a NAPOT size indicator. The IOMMU
> model wasn't checking PTE_N and therefore was using the raw (NAPOT-
> encoded) PPN directly in the physical address, yielding an address
> 32 KB above the correct base.
> 
> Fix both riscv_iommu_spa_fetch() and pdt_memory_read() by mirroring
> the Svnapot handling already present in target/riscv/cpu_helper.c:
> 
>   napot_bits  = ctz64(ppn) + 1          /* 4 for 64KB */
>   napot_mask  = (1 << napot_bits) - 1   /* 0xF */
>   phys_base   = PPN_PHYS(ppn & ~napot_mask)
>   page_offset = addr & (PPN_PHYS(napot_mask) | (TARGET_PAGE_SIZE - 1))
> 
> The spec only defines napot_bits == 4 (64KB); any other value is
> treated as a reserved encoding.
> 
> This is a fix, rather than new feature support, because the spec
> says "IOMMU implementations must support the Svnapot standard
> extension for NAPOT Translation Contiguity."
> 
> Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
> Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>

I should have added

Cc: qemu-stable@nongnu.org

because as soon as [1] is merged into Linux Linux will no longer boot
on any QEMU build without this patch.

[1] https://lore.kernel.org/all/20260508212339.381933-1-andrew.jones@oss.qualcomm.com/

Thanks,
drew

> ---
>  hw/riscv/riscv-iommu.c | 44 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 40 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 25a356d1d366..eb09cc974812 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -237,6 +237,25 @@ static bool riscv_iommu_msi_check(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>      return true;
>  }
>  
> +/* Returns the NAPOT page mask, or 0 for reserved encodings. */
> +static hwaddr riscv_iommu_napot_page_mask(hwaddr ppn, hwaddr addr, hwaddr *out)
> +{
> +    int napot_bits = ctz64(ppn) + 1;
> +    hwaddr napot_mask, page_mask;
> +
> +    /* The spec only defines 64KB (napot_bits == 4) */
> +    if (napot_bits != 4) {
> +        return 0;
> +    }
> +
> +    napot_mask = (1ULL << napot_bits) - 1;
> +    page_mask = PPN_PHYS(napot_mask) | (TARGET_PAGE_SIZE - 1);
> +
> +    *out = PPN_PHYS(ppn & ~napot_mask) | (addr & page_mask);
> +
> +    return page_mask;
> +}
> +
>  /*
>   * RISCV IOMMU Address Translation Lookup - Page Table Walk
>   *
> @@ -458,9 +477,20 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>          } else {
>              /* Leaf PTE, translation completed. */
>              sc[pass].step = sc[pass].levels;
> -            base = PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
> -            /* Update address mask based on smallest translation granularity */
> -            iotlb->addr_mask &= (1ULL << va_skip) - 1;
> +
> +            if (pte & PTE_N) {
> +                hwaddr mask = riscv_iommu_napot_page_mask(ppn, addr, &base);
> +
> +                if (!mask) {
> +                    break;
> +                }
> +                iotlb->addr_mask &= mask;
> +            } else {
> +                base = PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
> +                /* Update address mask based on smallest translation granularity */
> +                iotlb->addr_mask &= (1ULL << va_skip) - 1;
> +            }
> +
>              /* Continue with S-Stage translation? */
>              if (pass && sc[0].step != sc[0].levels) {
>                  pass = S_STAGE;
> @@ -997,7 +1027,13 @@ static MemTxResult pdt_memory_read(RISCVIOMMUState *s,
>              return MEMTX_ACCESS_ERROR; /* Misaligned PPN */
>          } else {
>              /* Leaf PTE, translation completed. */
> -            base = PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
> +            if (pte & PTE_N) {
> +                if (!riscv_iommu_napot_page_mask(ppn, addr, &base)) {
> +                    return MEMTX_ACCESS_ERROR;
> +                }
> +            } else {
> +                base = PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
> +            }
>              break;
>          }
>  
> -- 
> 2.43.0
> 

