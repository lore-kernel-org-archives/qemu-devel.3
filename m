Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD702C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 16:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taHLs-00059n-Ln; Tue, 21 Jan 2025 11:43:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1taHLn-0004yh-S7
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:43:39 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1taHLk-0002xx-TW
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 11:43:39 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ee8e8e29f6so7784317a91.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 08:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1737477814; x=1738082614; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PzlNnZ7bHfF8xOUsFzOiVPDxH3rzYyw9DKtSJBA4V2Y=;
 b=Fq00Q3k+F3DUQ3Y6tpcpo5vC5xpG61tBkznVa8cDEy6vZFUT7NkW068/VC4GunrpgL
 FxJslBfLazl9U2otOzztjz9V2t8WEtouCLWBIrZzyXhBus5/kEMKitrWleyXgGWyVQMw
 pEC+mvyW8vwsayE6PRJn0I3xtOzs9DeyBBTmM4L8TSm2pYVsrRhj7OrzXFqn74jzVnF7
 ii8eCWynzOofJB11vIE/32CIAD4+uhfGw2s04ksgsSW2Rc3S0v514dSzKa5wX7ebOJDv
 NJ5FcMCcC2wAwgoQjkyJ2VxwBiAr7Rs4/4NF9fUUpqKpdVP1QC0yTRi1W3czJxllcyBW
 t2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737477814; x=1738082614;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PzlNnZ7bHfF8xOUsFzOiVPDxH3rzYyw9DKtSJBA4V2Y=;
 b=Pj/QCMdjV31cQaPpUyUKM2AFyCJTUZEe/QRHY4l1/d4PvZcKbDCMOglKxHXxjfZvoq
 eB+kzvE+ZAMZOzsIK4ASoZU9BrspyPBauHHJul6zZAEI5Zt9wFYKG+27jhXsZRY1lkJg
 IQy4KSshpnn1UpZ2WLc4drdwZaGxUEbESB2/9wyN2mxkDdTDwPiULDCHTmN7TrRl7wu/
 Le74G9pKx0GTrfb6Rrpwh+ptXUyV8G+qTn0/vLIQDmgqkg3+RTwQ9Bw7Pp5hkZqqnzIw
 8vbxR1rpuOl2Ku2V2CfrpYxxDQnc4e1Owkf78CKFGvSgzxx+aBe5zrKXZB5qcfh/mIn5
 pqZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3IsA7ehcT5y8IIIZSRGqLJ5mHGVa32mVKamylkAMtPBrVq7Fc9yC4U4T/Cl1tOq2IzzC7Uw6zbCsm@nongnu.org
X-Gm-Message-State: AOJu0YzvBqjjwE8UGW9E2dUFXtOSKA0jSDDQsBaj8aKs9iJ+6+39pWYp
 5c+TO2QxgmvWIId3ZHaXgtZjPuJQSXw3gKgJZdmUy9P6XqQlMVhMOXWSER86CGQ=
X-Gm-Gg: ASbGncu2NCabqyKQ04CemsEHw7uMkhv/DIPqyuFtoxRKC42RpaXcv6ESJEln8LYmVBD
 Ef+3R+YkwMJP6Crvyen4OGCJpouQcCHTqfwDu+vY1Z4HAhyvPV//FFCwNLrR4HynRmnyrItZD9Z
 UVP9r4rBvknyJHKW1aL8kynr3yaa1laAKVS4XI1yodz9rec7zsYUmCtNi71sUsLcoRgEHJFeckl
 A46FwBHB0jvg6ErtblexiYM9ihJGvyALtAsj14teKp1oy4Bo/233XhxfhrS2RtIhEwz70qU4HCk
 yHZZoc4/
X-Google-Smtp-Source: AGHT+IHN/XbFVND0mPxfRLj9wP8RRETxsKMwIuxMVFRdAKxJ0OTDPJv+ilkbW4fO+0KliMlUeb0FIA==
X-Received: by 2002:a17:90b:568b:b0:2ee:90a1:5d42 with SMTP id
 98e67ed59e1d1-2f782b179efmr31618036a91.0.1737477814403; 
 Tue, 21 Jan 2025 08:43:34 -0800 (PST)
Received: from [192.168.68.110] ([191.202.238.10])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7c30d60acsm4620282a91.47.2025.01.21.08.43.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 08:43:33 -0800 (PST)
Message-ID: <a8ca081c-e6be-482e-a574-3351d1b9a6cd@ventanamicro.com>
Date: Tue, 21 Jan 2025 13:43:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] target/riscv: throw debug exception before page
 fault
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20250120204910.1317013-1-dbarboza@ventanamicro.com>
 <20250120204910.1317013-3-dbarboza@ventanamicro.com>
 <a2154af7-906c-4fbc-acca-75cac0b5c951@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <a2154af7-906c-4fbc-acca-75cac0b5c951@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1029.google.com
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



On 1/21/25 12:47 PM, Richard Henderson wrote:
> On 1/20/25 12:49, Daniel Henrique Barboza wrote:
>> In the RISC-V privileged ISA section 3.1.15 table 15, it is determined
>> that a debug exception that is triggered from a load/store has a higher
>> priority than a possible fault that this access might trigger.
>>
>> This is not the case ATM as shown in [1]. Adding a breakpoint in an
>> address that deliberately will fault is causing a load page fault
>> instead of a debug exception. The reason is that we're throwing in the
>> page fault as soon as the fault occurs (end of riscv_cpu_tlb_fill(),
>> raise_mmu_exception()), not allowing the installed watchpoints to
>> trigger.
>>
>> Call cpu_check_watchpoint() in the page fault path to search and execute
>> any watchpoints that might exist for the address, never returning back
>> to the fault path. If no watchpoints are found cpu_check_watchpoint()
>> will return and we'll fall-through the regular path to
>> raise_mmu_exception().
>>
>> [1] https://gitlab.com/qemu-project/qemu/-/issues/2627
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2627
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   target/riscv/cpu_helper.c | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>> index e1dfc4ecbf..ae0a659ec7 100644
>> --- a/target/riscv/cpu_helper.c
>> +++ b/target/riscv/cpu_helper.c
>> @@ -27,6 +27,7 @@
>>   #include "exec/page-protection.h"
>>   #include "instmap.h"
>>   #include "tcg/tcg-op.h"
>> +#include "hw/core/tcg-cpu-ops.h"
>>   #include "trace.h"
>>   #include "semihosting/common-semi.h"
>>   #include "system/cpu-timers.h"
>> @@ -1708,6 +1709,24 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>>       } else if (probe) {
>>           return false;
>>       } else {
>> +        int wp_len = riscv_cpu_mxl(env) == MXL_RV64 ? 8 : 4;
> 
> Surely 'size' may be relevant?

Ooops. Yeah, no need to infer wp_len if we can use the access size. I'll do a v3.


Thanks,

Daniel

> 
> 
> r~
> 
>> +        int wp_access = 0;
>> +
>> +        if (access_type == MMU_DATA_LOAD) {
>> +            wp_access |= BP_MEM_READ;
>> +        } else if (access_type == MMU_DATA_STORE) {
>> +            wp_access |= BP_MEM_WRITE;
>> +        }
>> +
>> +        /*
>> +         * If a watchpoint isn't found for 'addr' this will
>> +         * be a no-op and we'll resume the mmu_exception path.
>> +         * Otherwise we'll throw a debug exception and execution
>> +         * will continue elsewhere.
>> +         */
>> +        cpu_check_watchpoint(cs, address, wp_len, MEMTXATTRS_UNSPECIFIED,
>> +                             wp_access, retaddr);
>> +
>>           raise_mmu_exception(env, address, access_type, pmp_violation,
>>                               first_stage_error, two_stage_lookup,
>>                               two_stage_indirect_error);
> 


