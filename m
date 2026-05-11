Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E476CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMR33-0007aK-Nf; Mon, 11 May 2026 09:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMR2s-0007ZU-9K
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:51:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMR2p-0004GF-QG
 for qemu-devel@nongnu.org; Mon, 11 May 2026 09:51:41 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BD14OF452800
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 13:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CTi9U74sVfOJ8w4JyQ7PwEQT2To4DSoAn9WhH+BUXrs=; b=JBhOPpfpciwqtUz7
 jR3HhhpQ0nXnmZwD43UP06qCjI22GXnnTd5NueOiwM8p3Ecdm9J+g1UtoLfX1CYW
 aGEFLqoWVL9GatRtLtuczBYBlxUD7egMWy2LgXWtx74LcOYjj0kw5z8N7gBBgReu
 w3m9Ei5fEaBi5K+am5Tw+F59/1R9LIKHaMIdrWhk/6UIEboAzQfsvQ8n/WdSE9Pn
 ECAP2uEh5aOE0/mNc2giPZS5d9x7KylV0iqbUcZvZLdMBp7uN6rZIWWUcsmNuiby
 pqLAkrFrojZQ23LAoh2O6x/QtAyjeIcYWuEPWtqcWoDN0Qi/PcIj1AZH6P2QHT2a
 dJ92Pg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3ag6hc3y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 13:51:38 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-514ae0edeb6so38675981cf.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 06:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778507498; x=1779112298; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CTi9U74sVfOJ8w4JyQ7PwEQT2To4DSoAn9WhH+BUXrs=;
 b=UzJKlQ4DpQyXHmRjct+T48l1QE9PqowsZlB9OC422F3P0kgY03eLqEYzS2EvKZc+VT
 HFspBaKY8h4ikhkF2B2A4ahXz9jBzk/piAxT6DV9fZj9VNNVtcfE60LLwUuZAMPW8ABt
 OBt/BBoDsuf6LXoau1J4EmHS9tGVyciWjwt3ERFbrFeWlBUrytWielehkgjImB95bxtX
 Ftkjs1dMycCLR58w0qzYA4FLCMiOm+A9+mtzwq1X2xbvdo3zFUTDpyVluv0Z6v75dlvl
 HMG9YkXFVs/dUsFkA4/4aE05UxG8RFrvIO8pkdA20mXy6DKEwh3hAai9ye6HfaxySQe0
 kt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778507498; x=1779112298;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CTi9U74sVfOJ8w4JyQ7PwEQT2To4DSoAn9WhH+BUXrs=;
 b=EHgZ2Tn+PqqEeUmA1wSDRROjBQ3hZQRQRGYzdn6u2/x9n6Fi3MhNYrbwKiozmh+r1w
 yTW3ZUYpB9/Jf9HVAn6eYxXTYvW24XnBBnRdEu6HZC08C/oglGAcIQBENw+LAOHdQW1Z
 KPuP6j6jtMvgO9awY2MqqtpLTVFbb/e2IWuKnP+fAvFfxQRnA9wXpR6YAS5bjfLZpeTz
 48GAGYLoZgbZ1bCwXwt/RlQzPdabR1ObC9T1An++G1jpvCwsbSpkoKeAburLFjQtyrEt
 blmIvNe9acyND4aXwdTcyX9XcYCgb/gytgw2nhUXE6AGlh+IBkRMbP3PfYK2+97jg9Zo
 rXNA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+3sW5HExdbxjK6QzMH5UGUsOIKlTgo1AJeKz48mRdWanlwgqMAXOrdL10iJwF8U2AFRzS5dF/e5pLG@nongnu.org
X-Gm-Message-State: AOJu0Yx9+C/4L40hKP5y03Idh2Udueyo9JqfQbp/dWRbUbFlkayQGPW4
 L2yMwWxUg+rxBTL3kPD229dHjLlrbY3/9eu1fALun2/TJEF2kgu9eOW2QA4jyFNLjNUU+3kO1tY
 mgR4Qv/4BSy/ACO5es2wEQgC5wnVoqoX705e2omye002Efbwkx6erM3lQCw==
X-Gm-Gg: Acq92OE7UBygVYsTUd2GDWgrSuW9NZQsklpwU9RRBXHCCOMzRnm48BEVi+S5B+9PN4a
 CaXjz8R75m5DIQ6iUyKsyENZT1dJRxr/QUAaR7iKXltNqlkoC6HLPD15JlkDNUu+cr6LPKileQV
 TOlaWMIgJd4L+QTz6A5dvC8oL8xfap5ikbdUceI9MgK0KK42PzAn0iNJDwnypwwEYsZHoAQBt8j
 1A+imnAqqgM6De4dWBbmmZZWqKINrUeDKFa9xV3BpbCb2k+cS8lZDx2uXZOqvw3nlz0HIsryEgv
 w/N9eKYBslqT27to1GobfNYPnXfK/lkcUzyXqS0oCcwtxYq9rB0z4h0nUyn02DaWM4QLFOzMrfZ
 4U7pX3LmEVsgcYHkABPKBptFGV0jDkXmC87B/DQouW3UYcZn69WZnTXfgmWE=
X-Received: by 2002:ac8:5a0d:0:b0:50f:f030:920d with SMTP id
 d75a77b69052e-51475c618e8mr226944321cf.30.1778507497582; 
 Mon, 11 May 2026 06:51:37 -0700 (PDT)
X-Received: by 2002:ac8:5a0d:0:b0:50f:f030:920d with SMTP id
 d75a77b69052e-51475c618e8mr226943971cf.30.1778507496987; 
 Mon, 11 May 2026 06:51:36 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53d6442d0sm309542716d6.46.2026.05.11.06.51.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 06:51:36 -0700 (PDT)
Message-ID: <7b0b90cd-0c45-4c11-9655-10024918e7c1@oss.qualcomm.com>
Date: Mon, 11 May 2026 10:51:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/riscv/riscv-iommu: Fix Svnapot 64KB pages
To: Andrew Jones <andrew.jones@oss.qualcomm.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, tjeznach@rivosinc.com
References: <20260508205129.377032-1-andrew.jones@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260508205129.377032-1-andrew.jones@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fOsJG5ae c=1 sm=1 tr=0 ts=6a01deea cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=DFJLJhpOamtIQcbWox0A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE1NCBTYWx0ZWRfX0RY/gLgdYx17
 g3HTcNchZuDhZiU+mn+d9t9dpFan1x9T+dEdznOS8rBYVq48cSw853hw2u9btqe2X/m1yAGYIWM
 F0jsf8vNOa4rw6j4ISCaSmYBUYtnvYvArQvq1boa3ezmFnFYysFqGElEsA54ZxJtFwuMuNusyJ/
 FjckEXQKIr8vlacSMwRj1roA/cau84ffRu1/Tg6qQhv8wkpkijMiGkoQzzuFYWdmU/UZfO+jctF
 UiqzupbNhOBEp2U1PBFOKQEUZEeWpPydsLGP4iG4H0THnNjv2rzC/fsC2G7EONF1gbqQ+ZnDoRQ
 XzYK6KD/jsrB5bc73diicI4V3AojyIOYW5ioqmK+LFCGvNKxCC6qzMpQUML3S/37Zyvlalobtpd
 E7NGPfh2dV78SjnNmZwn2lAkviPi5DPHuJmBK6ZvDfq/z7TjyShZOecyzUwlQeWC8s1Ajr9tGR5
 Q+aQ0SuOIXe/GNx5USg==
X-Proofpoint-GUID: UG9M6KJKK_azTyKV_anMtMQbeUBCxTZk
X-Proofpoint-ORIG-GUID: UG9M6KJKK_azTyKV_anMtMQbeUBCxTZk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110154
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



On 5/8/2026 5:51 PM, Andrew Jones wrote:
> The Svnapot extension encodes a 64KB leaf PTE by setting PTE_N and
> storing bits [3:0] of the PPN as a NAPOT size indicator. The IOMMU
> model wasn't checking PTE_N and therefore was using the raw (NAPOT-
> encoded) PPN directly in the physical address, yielding an address
> 32 KB above the correct base.
> 
> Fix both riscv_iommu_spa_fetch() and pdt_memory_read() by mirroring
> the Svnapot handling already present in target/riscv/cpu_helper.c:
> 
>    napot_bits  = ctz64(ppn) + 1          /* 4 for 64KB */
>    napot_mask  = (1 << napot_bits) - 1   /* 0xF */
>    phys_base   = PPN_PHYS(ppn & ~napot_mask)
>    page_offset = addr & (PPN_PHYS(napot_mask) | (TARGET_PAGE_SIZE - 1))
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
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   hw/riscv/riscv-iommu.c | 44 ++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 40 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 25a356d1d366..eb09cc974812 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -237,6 +237,25 @@ static bool riscv_iommu_msi_check(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>       return true;
>   }
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
>   /*
>    * RISCV IOMMU Address Translation Lookup - Page Table Walk
>    *
> @@ -458,9 +477,20 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
>           } else {
>               /* Leaf PTE, translation completed. */
>               sc[pass].step = sc[pass].levels;
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
>               /* Continue with S-Stage translation? */
>               if (pass && sc[0].step != sc[0].levels) {
>                   pass = S_STAGE;
> @@ -997,7 +1027,13 @@ static MemTxResult pdt_memory_read(RISCVIOMMUState *s,
>               return MEMTX_ACCESS_ERROR; /* Misaligned PPN */
>           } else {
>               /* Leaf PTE, translation completed. */
> -            base = PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
> +            if (pte & PTE_N) {
> +                if (!riscv_iommu_napot_page_mask(ppn, addr, &base)) {
> +                    return MEMTX_ACCESS_ERROR;
> +                }
> +            } else {
> +                base = PPN_PHYS(ppn) | (addr & ((1ULL << va_skip) - 1));
> +            }
>               break;
>           }
>   


