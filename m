Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB1CC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 11:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKcv9-0003r8-1K; Fri, 21 Jun 2024 07:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sKcv6-0003p3-Mo
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 07:59:09 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sKcv5-00031L-3B
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 07:59:08 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f6b0a40721so14241955ad.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 04:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1718971145; x=1719575945; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lbHPVxCfUEIo/Lvv5FlLY0+ZEKSrlCY75Aivs8/Anw8=;
 b=Q6SChynm5N234dlNpVMjp+luuHym4vGbAmyWT0+B7UVz2zwOf0woSWFnqHhsIsPj3H
 qM47xebAJNT5tFArpvRJK6K1ozfwfzG4X6zCzr/mXJ1SuEyYFmn4vRUrmNqkzThSQTPA
 7naKpy3T7i/9RLGiTXNor75jJqKZslFrtpS2MQ/gMcBKon32dAHpmxHQKbZin76a9+wT
 jOdu846XtQiI9Kb4kdDduCzx55rjd/zVyDl8N1UVXC2zcx2k5TTCCVr7vLUpnSMjyS3b
 mKxWNwytywDwbY1dWBFRMNYkQFCDg3Z59dtVOew6VWO/eCEnVgXNIlrvkQSAyQFdN24N
 usaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718971145; x=1719575945;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lbHPVxCfUEIo/Lvv5FlLY0+ZEKSrlCY75Aivs8/Anw8=;
 b=OLLiblpeYkl/AUqE9CSExOV6hEBsrf+/WPBLz2ib3YzYyDtTSMcPddgoUUvUPF4Vl2
 S8kpYd6bWRJ5Pbxa5wVk48af7yfV3Nsg8fxjRbXKT+Di4Pln3SXXTfqMA7j/HGMPuUBG
 kGUHd8wTFM5cJD6UsovRzFfJrFy7Ju8AiFj11JkRHOTNZ+vEvma1644xVgaCpuAiHDsA
 i2Y7FYvof2kAVYzJhc1xbh0BMyMNd3JEyPVRpWLcQMiJYgrmjj17yXuQJKpqHQ3pO2jj
 l+YUoXNyRf9AaH4yDtHpL5Qj9iIMmeqE3YWQ1YUjva2ZJz1N7bFUsauVzXZ0Z2fuJbps
 DVKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCOusKJvfIqg02Jq8enOT5TjpNAc/u43pUgux4IJFAucOyjrGeGdYtrmuRvjJeR1Nla9PshkwmjbVhUHiNH40/3CyHPm0=
X-Gm-Message-State: AOJu0YzunPJx9VzyhN61lcVwWKZkfySVUI44OCCRnzd75tKfGnrwwJaf
 W9KkaEC3TVU0/HXJQhGLUHUXBwCuRStRAX6mwEeLLAXPfHHDd609tyKOW68MMao=
X-Google-Smtp-Source: AGHT+IGGg+QpDNlxCT08M+AjWUcbquPbcrGfl097fBJcBGPAHpDzWZUMqPtImjUwVwr5/gsKAHO4eA==
X-Received: by 2002:a17:902:dac6:b0:1f7:1b08:dda9 with SMTP id
 d9443c01a7336-1f9aa3bbc76mr89733755ad.8.1718971144608; 
 Fri, 21 Jun 2024 04:59:04 -0700 (PDT)
Received: from [192.168.68.109] ([179.193.8.144])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb3d49f4sm12435635ad.197.2024.06.21.04.59.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jun 2024 04:59:04 -0700 (PDT)
Message-ID: <03424117-eeac-4206-9f5d-933a138f0002@ventanamicro.com>
Date: Fri, 21 Jun 2024 08:58:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/13] hw/riscv/riscv-iommu: add s-stage and g-stage
 support
To: Jason Chien <jason.chien@sifive.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 tjeznach@rivosinc.com, ajones@ventanamicro.com, frank.chang@sifive.com
References: <20240523173955.1940072-1-dbarboza@ventanamicro.com>
 <20240523173955.1940072-10-dbarboza@ventanamicro.com>
 <0784610e-3266-4469-a090-d18a3166f18d@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <0784610e-3266-4469-a090-d18a3166f18d@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 6/18/24 7:30 AM, Jason Chien wrote:
> Hi Daniel,
> 
> On 2024/5/24 上午 01:39, Daniel Henrique Barboza wrote:
>> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>>
>> Add support for s-stage (sv32, sv39, sv48, sv57 caps) and g-stage
>> (sv32x4, sv39x4, sv48x4, sv57x4 caps). Most of the work is done in the
>> riscv_iommu_spa_fetch() function that now has to consider how many
>> translation stages we need to walk the page table.
>>
>> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   hw/riscv/riscv-iommu-bits.h |  11 ++
>>   hw/riscv/riscv-iommu.c      | 331 +++++++++++++++++++++++++++++++++++-
>>   hw/riscv/riscv-iommu.h      |   2 +
>>   3 files changed, 336 insertions(+), 8 deletions(-)
>>

(...)

>>       /* Set translation context. */
>>       ctx->tc = le64_to_cpu(dc.tc);
>> +    ctx->gatp = le64_to_cpu(dc.iohgatp);
>> +    ctx->satp = le64_to_cpu(dc.fsc);
>>       ctx->ta = le64_to_cpu(dc.ta);
>>       ctx->msiptp = le64_to_cpu(dc.msiptp);
>>       ctx->msi_addr_mask = le64_to_cpu(dc.msi_addr_mask);
>> @@ -564,14 +842,38 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
>>           return RISCV_IOMMU_FQ_CAUSE_DDT_INVALID;
>>       }
>> +    /* FSC field checks */
>> +    mode = get_field(ctx->satp, RISCV_IOMMU_DC_FSC_MODE);
>> +    addr = PPN_PHYS(get_field(ctx->satp, RISCV_IOMMU_DC_FSC_PPN));
>> +
>> +    if (mode == RISCV_IOMMU_DC_FSC_MODE_BARE) {
> According to section 2.3, if the function returns here, some necessary checks are skipped. I think this if scope should be moved down to after "if (ctx->pasid == RISCV_IOMMU_NOPASID) {...}".
>> +        /* No S-Stage translation, done. */
>> +        return 0;
>> +    }
>> +
>>       if (!(ctx->tc & RISCV_IOMMU_DC_TC_PDTV)) {
>>           if (ctx->pasid != RISCV_IOMMU_NOPASID) {
>>               /* PASID is disabled */
>>               return RISCV_IOMMU_FQ_CAUSE_TTYPE_BLOCKED;
>>           }
>> +        if (mode > RISCV_IOMMU_DC_FSC_IOSATP_MODE_SV57) {
>> +            /* Invalid translation mode */
>> +            return RISCV_IOMMU_FQ_CAUSE_DDT_INVALID;
>> +        }
>>           return 0;
>>       }
>> +    if (ctx->pasid == RISCV_IOMMU_NOPASID) {
>> +        if (!(ctx->tc & RISCV_IOMMU_DC_TC_DPE)) {
>> +            /* No default PASID enabled, set BARE mode */
>> +            ctx->satp = 0ULL;
>> +            return 0;
>> +        } else {
>> +            /* Use default PASID #0 */
>> +            ctx->pasid = 0;
>> +        }
>> +    }
>> +
> return if mode is bare.

I agree. Just moved the 'if (bare) return' check to this point as you
suggested.


Thanks,


Daniel


