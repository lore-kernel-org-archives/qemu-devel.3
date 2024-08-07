Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFCCC49EA1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 03:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbXDj-0005ch-Ae; Tue, 06 Aug 2024 23:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbXDh-0005cB-Uo
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 23:20:14 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbXDd-0008N5-34
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 23:20:10 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fc5549788eso12270725ad.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 20:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723000805; x=1723605605; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MmwYfMrfEiWvVC8027tT7K0UbV40TMN9Ov1lOL7dg4Q=;
 b=mBfWUign1o0ATvBUiUwPRhNQWsnwrmLP9rKiWSlKghgBV0aSr23PmjuHzr4ZbMRvpD
 ufnX8Cd6c3O2RLs21kozGEW5+ol7TDEMuQsaEeGDHml9dIJDArBvmJJ5eHcBRu1jueWf
 YaI4os890TQDrDWZ1KtqRuxWj77ECd2gWMZTLZ0/qjSTgdknNckBaccQMjrj0+6eKoGn
 hjQM5F04zbDO5EIp7z21evtDnS8idM8++iJk9uIouk6YSnwFKkx3fg3adrfFuCMAeJtY
 XFgicm+c9KrSkArWr7kF8kahQPximOK8EdccOIlcTPRDolS+Vss5nN5+o5FYktHJIYcE
 aLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723000805; x=1723605605;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MmwYfMrfEiWvVC8027tT7K0UbV40TMN9Ov1lOL7dg4Q=;
 b=cqTkNTvOtJ0oQzG6zxqNsuYj5zq+JDyMs0nCrhOXfme3MetIW2+2/J278uPywXjpLz
 dpZxY0KVUThXIhU6n+/BihQGbgoy4RCFwAgZRN6QvTbLv6GLs2DHM3EZn5Jt/6VRVgCX
 zlqRHyxvEQF9Lv5nq2mcXZ8nQuEzf5J8uc1h0Y3kK+7ev2fLrfV9RpD8hOpJ7wW/dR0f
 PUoynlsC5ICoeG+hb5JNI170aDMlzskF1F5jaKlqSRDj6nyBsrbboMz+RBa/39rc0OOr
 MHKioQ/99Y6UrFWWe61khGiUzi96sItGMWw+FkD108U7WGtPYEPvza+KwUy+1LgsivOK
 WhVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmXzXDacxxLqb7camI+PCYJ7nL1xZRuM9qqswrO4ohy8TXxyun1nh/JHjKyLfGoy5e1xfH6qQm1c2GSGdDWiKVtzsOizo=
X-Gm-Message-State: AOJu0YwSXAjGu9turuAxXGSW1nxj5bWxCROG3hTMwea21eoOyI0NB0l8
 q18aUTa0aqtEu7cKLcJ2ue/0Wdmk7OgFpoGbhy2+fGM8l3JkBKAqgZFGOFWipDA=
X-Google-Smtp-Source: AGHT+IGpnzBfN/BQCTtxgSGBU9l+13/XEE/ukKQlkMlgeHQh8r4km1ImlEqTD/JHCbELDLTM5t/7pQ==
X-Received: by 2002:a17:903:41cf:b0:1fc:5820:8940 with SMTP id
 d9443c01a7336-1ff57274b55mr222708755ad.20.1723000805122; 
 Tue, 06 Aug 2024 20:20:05 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:e01b:92e5:d779:1bc0?
 (2403-580a-f89b-0-e01b-92e5-d779-1bc0.ip6.aussiebb.net.
 [2403:580a:f89b:0:e01b:92e5:d779:1bc0])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff5905f9b9sm94250995ad.130.2024.08.06.20.19.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 20:20:04 -0700 (PDT)
Message-ID: <bea52a58-12a7-45d1-b610-d577a7540887@linaro.org>
Date: Wed, 7 Aug 2024 13:19:55 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/20] target/riscv: mmu changes for zicfiss shadow
 stack protection
To: Deepak Gupta <debug@rivosinc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: pbonzini@redhat.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 laurent@vivier.eu, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
References: <20240807000652.1417776-1-debug@rivosinc.com>
 <20240807000652.1417776-15-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240807000652.1417776-15-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 8/7/24 10:06, Deepak Gupta wrote:
> @@ -1105,15 +1119,45 @@ restart:
>           return TRANSLATE_FAIL;
>       }
>   
> +    /*
> +     * When backward CFI is enabled, the R=0, W=1, X=0 reserved encoding
> +     * is used to mark Shadow Stack (SS) pages. If back CFI enabled, allow
> +     * normal loads on SS pages, regular stores raise store access fault
> +     * and avoid hitting the reserved-encoding case. Only shadow stack
> +     * stores are allowed on SS pages. Shadow stack loads and stores on
> +     * regular memory (non-SS) raise load and store/AMO access fault.
> +     * Second stage translations don't participate in Shadow Stack.
> +     */
> +    sstack_page = (cpu_get_bcfien(env) && first_stage &&
> +                  ((pte & (PTE_R | PTE_W | PTE_X)) == PTE_W));
> +
>       /* Check for reserved combinations of RWX flags. */
>       switch (pte & (PTE_R | PTE_W | PTE_X)) {
> -    case PTE_W:
>       case PTE_W | PTE_X:
> +    case PTE_W:
> +        if (sstack_page) { /* if shadow stack page, PTE_W is not reserved */
> +            break;

This is oddly written, and duplicates checks.  Better as

     switch (pte & RWX) {
     case W | X:
         return TRANSLATE_FAIL;
     case W:
         if (bcfi && first_stage) {
             sstack_page = true;
             break;
         }
         return TRANSLATE_FAIL;
     }


> +    /* Illegal combo of instruction type and page attribute */
> +    if (!legal_sstack_access(access_type, is_sstack_insn,
> +                            sstack_page)) {
> +        /* shadow stack instruction and RO page then it's a page fault */
> +        if (is_sstack_insn && ((pte & (PTE_R | PTE_W | PTE_X)) == PTE_R)) {
> +                return TRANSLATE_FAIL;
> +        }
> +        /* In all other cases it's an access fault, so raise PMP_FAIL */
> +        return TRANSLATE_PMP_FAIL;
> +    }
> +
>       int prot = 0;
> -    if (pte & PTE_R) {
> +    /*
> +     * If PTE has read bit in it or it's shadow stack page,
> +     * then reads allowed
> +     */
> +    if ((pte & PTE_R) || sstack_page) {
>           prot |= PAGE_READ;
>       }

I feel like this logic could be simplified somehow.
I'll think about it.

> @@ -1409,6 +1461,11 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>       qemu_log_mask(CPU_LOG_MMU, "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
>                     __func__, address, access_type, mmu_idx);
>   
> +    /* If shadow stack instruction initiated this access, treat it as store */
> +    if (mmu_idx & MMU_IDX_SS_ACCESS) {
> +        access_type = MMU_DATA_STORE;
> +    }

I know you're trying to massage the fault type, but I think this is the wrong place.


r~

