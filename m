Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C0CC0218C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 15:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taGTP-0007FD-Js; Tue, 21 Jan 2025 10:47:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taGTF-0007EQ-SI
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:47:22 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taGTD-0000Xj-R6
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:47:17 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21a7ed0155cso93486355ad.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 07:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737474434; x=1738079234; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PsRphco2/yF7/RPpBLBla6FWBK7HFRFdg3GEMcsicCo=;
 b=pD0Kk7IzS00jpvYT1SiT8A35on3O76Et/oz4K9A5zIyJWDwko2+Y3JPMdQySl/gTSM
 c39gEiJxksz54PrFKa5iVGeq2hyKkL+OOrgK3IKI+gsHFTfhcvGZlQOaP1T8cQyf/Ibq
 pxWlFuxJw9hYeFkA3VZkBOGJ1AfHONUR7k7gO0qE4mVMgr6/GWiv8tBmLD8MsB71UJZL
 SM+BjrewBaud8nA3Hob7yZ6LRPlao0ivpqd6+E5VDQpN8RJKVEsYa3H7EZl9kfIl1G5X
 JmBC0sckRKYP3EMXZF+6ejaaUKLVUpPHIlfjI2gYT+CZc+BgeQ8UzqR8Eoj7uV8dLgVn
 X26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737474434; x=1738079234;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PsRphco2/yF7/RPpBLBla6FWBK7HFRFdg3GEMcsicCo=;
 b=Ozy/feKr7xLC2Ljst9ilZGnUWb8GuNTWPZrX31M9mseKgkgdRrUe6rTkQnSilYzkCK
 WZ7+htWgy1WfEAyTTgoUIwlwY5sBc3aimBaLMc6IIHYL9b9Qh0QUh8TDea4C0JUYtYBl
 rvXlc0cI4BhuT0mbuJor/nC220Khe8WFgjNEsx6kA7vEdr4dDVe+np+ecCYFH3jv6wqY
 6bzfwhABpAIpNEjMw+Ine3PH4FRJsASHYFL5sFvLqOR9POInGJv9lWcTPCwMaa0q9uYd
 1+NPBAeCX3RGFPKZXAvD30oR0Ftn75ud8qbVdUedUijuzaSdp2Bzb5qLXZyiBdNZb/VX
 fo6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtHdHaPUrI1d5ORa7AfTK1tSCW3uwPG/6q4vwnbhZMva3Hq73fI/FgetWaKxgLPw6FbrWlfJQvNWwL@nongnu.org
X-Gm-Message-State: AOJu0YxUieXYuMH9JBigLPgjo6zFaTQSfwdh9pk/pWFBCiy+ltma9A3i
 q9BFRWNUfnMO02SsFOdE2vx1MSx8NeMN7zXO/NvpBt19uZTjN1VBFa9UHgtckog=
X-Gm-Gg: ASbGnctsViTx//0ACNKRfHzWAQHsJ3lHp/Lg8EjkB+xnO1eufWlqksZmLqvnZXHUv4s
 yANw0T1M+LSb5nhD8GLyRQEss9A52GKGF3pChArhKXNZ83WSiW76b1tJc2kDZpbXCekQGvfr/1j
 4lkLUHck9/35byDN4Rezcb22knrq8X+njkQBwh5/vMnc8emyFagybjGa07UUgBdtvP9AcVPIrzk
 jc+Gl1TQyAMQ6kOsCG6NmUFsbjBGOSx0Fl4ovavnHjht2ls0jRo6BFEgNrWdKBB1rjPf0PbvyNa
 6I2nvcVlJFtPtkRPT/mVLfGjnT9Q8AlkNdan
X-Google-Smtp-Source: AGHT+IFYB4xOIxG3I05AMrzGjS7l3XFq8FXmeUPffboOphdJ/Kts2W/YWI6N2YF5vDpkCYQ7Selghg==
X-Received: by 2002:a05:6a20:9185:b0:1ea:e93d:7574 with SMTP id
 adf61e73a8af0-1eb214c97a5mr29779720637.18.1737474434127; 
 Tue, 21 Jan 2025 07:47:14 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-aab358fc6d8sm5788145a12.51.2025.01.21.07.47.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 07:47:13 -0800 (PST)
Message-ID: <a2154af7-906c-4fbc-acca-75cac0b5c951@linaro.org>
Date: Tue, 21 Jan 2025 07:47:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] target/riscv: throw debug exception before page
 fault
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20250120204910.1317013-1-dbarboza@ventanamicro.com>
 <20250120204910.1317013-3-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250120204910.1317013-3-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 1/20/25 12:49, Daniel Henrique Barboza wrote:
> In the RISC-V privileged ISA section 3.1.15 table 15, it is determined
> that a debug exception that is triggered from a load/store has a higher
> priority than a possible fault that this access might trigger.
> 
> This is not the case ATM as shown in [1]. Adding a breakpoint in an
> address that deliberately will fault is causing a load page fault
> instead of a debug exception. The reason is that we're throwing in the
> page fault as soon as the fault occurs (end of riscv_cpu_tlb_fill(),
> raise_mmu_exception()), not allowing the installed watchpoints to
> trigger.
> 
> Call cpu_check_watchpoint() in the page fault path to search and execute
> any watchpoints that might exist for the address, never returning back
> to the fault path. If no watchpoints are found cpu_check_watchpoint()
> will return and we'll fall-through the regular path to
> raise_mmu_exception().
> 
> [1] https://gitlab.com/qemu-project/qemu/-/issues/2627
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2627
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   target/riscv/cpu_helper.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index e1dfc4ecbf..ae0a659ec7 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -27,6 +27,7 @@
>   #include "exec/page-protection.h"
>   #include "instmap.h"
>   #include "tcg/tcg-op.h"
> +#include "hw/core/tcg-cpu-ops.h"
>   #include "trace.h"
>   #include "semihosting/common-semi.h"
>   #include "system/cpu-timers.h"
> @@ -1708,6 +1709,24 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>       } else if (probe) {
>           return false;
>       } else {
> +        int wp_len = riscv_cpu_mxl(env) == MXL_RV64 ? 8 : 4;

Surely 'size' may be relevant?


r~

> +        int wp_access = 0;
> +
> +        if (access_type == MMU_DATA_LOAD) {
> +            wp_access |= BP_MEM_READ;
> +        } else if (access_type == MMU_DATA_STORE) {
> +            wp_access |= BP_MEM_WRITE;
> +        }
> +
> +        /*
> +         * If a watchpoint isn't found for 'addr' this will
> +         * be a no-op and we'll resume the mmu_exception path.
> +         * Otherwise we'll throw a debug exception and execution
> +         * will continue elsewhere.
> +         */
> +        cpu_check_watchpoint(cs, address, wp_len, MEMTXATTRS_UNSPECIFIED,
> +                             wp_access, retaddr);
> +
>           raise_mmu_exception(env, address, access_type, pmp_violation,
>                               first_stage_error, two_stage_lookup,
>                               two_stage_indirect_error);


