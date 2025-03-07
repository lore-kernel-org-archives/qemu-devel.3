Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B524C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 12:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqWpF-0005Nq-GG; Fri, 07 Mar 2025 07:29:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tqWp5-0005Ih-Ma
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:29:05 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tqWoz-0005Wy-38
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 07:29:03 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2239f8646f6so32944985ad.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 04:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1741350534; x=1741955334; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3bYZG+fVKIYVlHdgSro9z6bwtN8MwSi0A+I8g90w6Qg=;
 b=N42lZyN/3czBPf5fQpVD+7Cq7Dw5IujlTewiYGK2l9O/Rw4LipZsBKO9KlYeDSuwT3
 EZN38afD736DIvB7GY6pBXyHD+DvU3s7x1VGvnY3wmMO6P9lscEAjkbvD9A/cJXO5WcN
 a9JPLj5m/+djfx2EUTAxWWPnDNH5hV+T/7g7I16Y5T6cngZcVLmIzjrkjxojXVB07TfB
 d+XTZvl8/1DXQKDV2h/EmYgR7FhT7FiEjdeeTQjB2lshJWEp5E6cuu1y/T8gZ1/6kduU
 aDbquTknyv6YwVuTRb8b9mjM33JnkSblGneA2i+NLH+8MbVA6CB7PtLG46FE2SE2qMFV
 7hpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741350534; x=1741955334;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3bYZG+fVKIYVlHdgSro9z6bwtN8MwSi0A+I8g90w6Qg=;
 b=AphvG4TQ8qNNaEHRaTGYi3tWMO6Qws3kvvuGpiOSA5UR7piY7TE1JNRgZfwqR94jhT
 dMApgY3D90FMPNR+qo1lP9EkqLhyYZ9NWPIVIRMyL//DAu/nJSnVGmbF+dEtAEqp0099
 cjRE196N4OzkLiOjL08j3jEezPCdUvU3hJIaD6+UGp4kcM2BP3sq2OlO6fQs317PkSEk
 Svo2FlkzsEEtVanp88JV7V2cvdGxjO0wGFYK1G9AA8XhktiOP/k9iGNc8zuFRirVOQXD
 JjW0lQje1JKncfU+uPTvnIn1aDZI3q7GQmADp4tdVl5e8rmwC2D9H/6iimethpv+TNu1
 qUyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx4DhBY5OdnYVnP77pT0hfUYTU0ZVlRUnhk1/VqYqIrPs6Bj8L0jksmr7VZcqnZq/wq/7pjVEdS1Rr@nongnu.org
X-Gm-Message-State: AOJu0YyXO5fRN0+bLjBobdMDsUZAuHC/KmlF8Vep17U+mz07xqgbpose
 14DQxIBnfwcwSKNKH1edxdl3wQXRzRDbjK9HXf/MraSGrfcmAuy0FxUsYcwlibpaPsquyeGiDY4
 Y
X-Gm-Gg: ASbGncsUb2NQSr2Csop+Z2ACZf+adOA9zE4ejW1VfpEl/FX/YHLolCwKdVPDUND2PAn
 4Q0fDJPWlXzSBhr1kAy1gLEw5FpQVOMCOmouR0frLAX349PCMKDXsreksUax9QMbjLHlylXHPPx
 aH0BqYYwJ6mbjDVyENB9GsXfGg0wkRlVZReMOKV2Zmoqpqu1PjCX4Kr+jFkm0c+56oiQdm7DPVo
 uVmkSYWlpyHObhq2uIbCM38PRqpE+QROfi3uFRiItQqF36bzXP+Is1q9LOoQMI0ztgkJ7SdHiBj
 RaczH/rMEHIaYeKiNAyP/cancQGRmtXgKlTEfg+O5yaYJYOZ799P7Cd+Qis=
X-Google-Smtp-Source: AGHT+IGcd+Uwmu3bR3u8PMd4e76S6wNdcSkf7wwEuCVUikECQme1XrKwWzREFa/VvLREfcM0/fmH1Q==
X-Received: by 2002:a17:902:ce01:b0:223:635d:3e2a with SMTP id
 d9443c01a7336-22428a88b8amr48866455ad.23.1741350534161; 
 Fri, 07 Mar 2025 04:28:54 -0800 (PST)
Received: from [192.168.68.110] ([177.170.118.40])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-224109dd5d7sm28794385ad.4.2025.03.07.04.28.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 04:28:53 -0800 (PST)
Message-ID: <d9aa9aa0-f1d0-4430-a258-e480ea61f92f@ventanamicro.com>
Date: Fri, 7 Mar 2025 09:28:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/riscv/riscv-iommu: Fix process directory table walk
To: Jason Chien <jason.chien@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20250301173751.9446-1-jason.chien@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250301173751.9446-1-jason.chien@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 3/1/25 2:37 PM, Jason Chien wrote:
> The PPN field in a non-leaf PDT entry is positioned differently from that
> in a leaf PDT entry. The original implementation incorrectly used the leaf
> entry's PPN mask to extract the PPN from a non-leaf entry, leading to an
> erroneous page table walk.
> 
> This commit introduces new macros to properly define the fields for
> non-leaf PDT entries and corrects the page table walk.
> 
> Signed-off-by: Jason Chien <jason.chien@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/riscv/riscv-iommu-bits.h | 6 +++++-
>   hw/riscv/riscv-iommu.c      | 4 ++--
>   2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
> index b7cb1bc736..1017d73fc6 100644
> --- a/hw/riscv/riscv-iommu-bits.h
> +++ b/hw/riscv/riscv-iommu-bits.h
> @@ -415,12 +415,16 @@ enum riscv_iommu_fq_causes {
>   #define RISCV_IOMMU_DC_MSIPTP_MODE_OFF  0
>   #define RISCV_IOMMU_DC_MSIPTP_MODE_FLAT 1
>   
> +/* 2.2 Process Directory Table */
> +#define RISCV_IOMMU_PDTE_VALID          BIT_ULL(0)
> +#define RISCV_IOMMU_PDTE_PPN            RISCV_IOMMU_PPN_FIELD
> +
>   /* Translation attributes fields */
>   #define RISCV_IOMMU_PC_TA_V             BIT_ULL(0)
>   #define RISCV_IOMMU_PC_TA_RESERVED      GENMASK_ULL(63, 32)
>   
>   /* First stage context fields */
> -#define RISCV_IOMMU_PC_FSC_PPN          GENMASK_ULL(43, 0)
> +#define RISCV_IOMMU_PC_FSC_PPN          RISCV_IOMMU_ATP_PPN_FIELD
>   #define RISCV_IOMMU_PC_FSC_RESERVED     GENMASK_ULL(59, 44)
>   
>   enum riscv_iommu_fq_ttypes {
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index d46beb2d64..76e0fcd873 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -1042,10 +1042,10 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
>               return RISCV_IOMMU_FQ_CAUSE_PDT_LOAD_FAULT;
>           }
>           le64_to_cpus(&de);
> -        if (!(de & RISCV_IOMMU_PC_TA_V)) {
> +        if (!(de & RISCV_IOMMU_PDTE_VALID)) {
>               return RISCV_IOMMU_FQ_CAUSE_PDT_INVALID;
>           }
> -        addr = PPN_PHYS(get_field(de, RISCV_IOMMU_PC_FSC_PPN));
> +        addr = PPN_PHYS(get_field(de, RISCV_IOMMU_PDTE_PPN));
>       }
>   
>       riscv_iommu_hpm_incr_ctr(s, ctx, RISCV_IOMMU_HPMEVENT_PD_WALK);


