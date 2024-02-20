Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C0CC5475B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 16:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcSrI-0006ft-1I; Tue, 20 Feb 2024 11:20:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcSrG-0006dv-Ic
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 11:20:38 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rcSrA-0007wO-Vt
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 11:20:38 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6e0a37751cbso4290461b3a.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 08:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708446030; x=1709050830; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ASTCwZycZbDMgor8OFU1QIyaB6Iz5bzuzC5Qiyw7G0A=;
 b=hUrffK7vt3TcQYjbul4zLbmYygS+9qZdjS6EP2hhrFiWiYFlgGyOZHTqXH5DAnta8O
 G+da0zZfR1xLxFkPmj31NBC8X8yPZO6QWdM4hMSgWmcr3eUfFVHL5G/WGlGDj06NSoex
 ui1IyhzW3pxzkbAC83WbaZwGy5RO+bvftm3A3LQvaNrpQvWuYNMukOHcCMIaFP6HCZQB
 U7IMuSm/hcty1sOqT57d2tT57vFDDDnel+BXZFco6fQGxd+rkmJV/3EyXlRzwTtSqVYW
 Ub1QvoJjFc5/7aggQ8V2Sl5taBicl/5JhnEDTLuRIz+JTLIF3asdu4RWl1OkvwKEP4nQ
 lsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708446030; x=1709050830;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ASTCwZycZbDMgor8OFU1QIyaB6Iz5bzuzC5Qiyw7G0A=;
 b=R3BSnp/yudUvV66BakpYC0CBRfXB1ZmNnE9wNjXzSyuH9+1dEeFlEHXx/ZA8a/CCWF
 yN3VCasuMoKl70ySg4HVr9JJDzhjHtlRXEqQUlAs+HcKTBwJ16y5YSWrnXmtioavDSfr
 I+cMrsuzLxEUgmt928+karIBqENCiDkVhyG+lW3RiCGGGYFFNr4VIJb/np13eSw8szmo
 hfNYwuaqt06+DwEUrFYWTst8EDYBnAOUxrMy6BD7hHj4SFHlnMwauv5bM+/eOCoh10Pq
 GyY/nue12N6PPFQFygzYCeP/E1bSs2nqmXXWZFVjkFiLGXp5k9jdLrf47yMcE20EfGb6
 xAug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyJs0LXpIZy5FOAJiCQ/zH13qOFitJvAyBBe5mSr5rtR7LL9Ilsmkylnm0MqAxuVCVRQ31bottpmMGxvvgu6j4AoWijRc=
X-Gm-Message-State: AOJu0YzFn1DLTJ89eCr8UXHez3yxB2voj6hR8WGuUODvwVL6mrEWGbkT
 l2f+aH7iXS97j2h3bIII923H8522g7gwJIdwvfCOgLIGSYeMpNdK3Nqr3878cH0=
X-Google-Smtp-Source: AGHT+IEM6637sI44YihRW94sSVF+1yYYloLNqTBLY/iqNQ/yGJHoPbiVj0LZwyQt60ejL8YD5WcHAw==
X-Received: by 2002:a05:6a00:2d9b:b0:6e4:6dcd:8d28 with SMTP id
 fb27-20020a056a002d9b00b006e46dcd8d28mr5580508pfb.0.1708446030334; 
 Tue, 20 Feb 2024 08:20:30 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 n28-20020a056a000d5c00b006e477b4a16csm2088925pfv.44.2024.02.20.08.20.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 08:20:29 -0800 (PST)
Message-ID: <9df86826-44c2-4816-ae59-189773c51d95@ventanamicro.com>
Date: Tue, 20 Feb 2024 13:20:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Add missing include guard in pmu.h
Content-Language: en-US
To: frank.chang@sifive.com, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20240220110907.10479-1-frank.chang@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240220110907.10479-1-frank.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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



On 2/20/24 08:08, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Add missing include guard in pmu.h to avoid the problem of double
> inclusion.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/pmu.h | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
> index 505fc850d3..7c0ad661e0 100644
> --- a/target/riscv/pmu.h
> +++ b/target/riscv/pmu.h
> @@ -16,6 +16,9 @@
>    * this program.  If not, see <http://www.gnu.org/licenses/>.
>    */
>   
> +#ifndef RISCV_PMU_H
> +#define RISCV_PMU_H
> +
>   #include "cpu.h"
>   #include "qapi/error.h"
>   
> @@ -31,3 +34,5 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_event_idx event_idx);
>   void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_name);
>   int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
>                             uint32_t ctr_idx);
> +
> +#endif /* RISCV_PMU_H */

