Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55193C27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 22:02:53 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFdcX-0000pP-BD; Fri, 07 Jun 2024 13:43:21 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFdcS-0000pH-Vb
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 13:43:17 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFdcQ-0002d8-JA
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 13:43:15 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6f4603237e0so1531456b3a.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 10:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717782193; x=1718386993; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IufZoOg872ZanaT4FKVzMcwzhePUO3CySZBDuK9mJ6U=;
 b=kaAAqwb8ylLGCYDe1BqBnR83HtzTKKD1L/JUWq49+rWJDXP6W7UUNmK5TBOd9W7HYh
 Pcu8P8M16H1CeNE/4S/PtOAP0jfDM0qwBN+rJOMw2gqyluh7tdA28cOYW/1XWncs6SA3
 /5ND8KO3jina8gmu0ABKF4z06vkPZlx8h0m0GCHzdmF5gvBCLiv48S3+m3ptixJYCzs6
 i+NgSaxSU6T1Puroh1Z9ajgrw4BbIOEmuBij/bs/++g7LgX8ylD6A5GooJ/dnWNOhqDU
 AMy9wik3SZ1LY3kHRGBgFwNa54qCxO9KxGFGEALtrqAzCrLsMJ+Oc1rZx7uLImrbeC5l
 /B3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717782193; x=1718386993;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IufZoOg872ZanaT4FKVzMcwzhePUO3CySZBDuK9mJ6U=;
 b=ditbvHSB+26lRyCZjrg5VTp6xLExBstvCsvLBIQrL/jeod23C44Hy4OBwBOtI4Oxe0
 KYjySbZfTp4tDCCxNRH8fyso+aQsUwd8OEM6WYq2eyWvjotk/yLhritlu4qVU+v4HbNl
 i5WFUjhIdITaJ2nGJfeucUAfklOgsaEjawmCt/u3xROvfIK/Qacj45Qx9mvWNeb/vt0Y
 94Cz6bpujdwYG7lEa515ilscUw5EtJcXcODWL0UEs5LVnuwTLRekKTkOOBVPbxl7HGCi
 NRXvOlkGEiCfnLPMfv3L717jol9r/yJdqIkXG9N582ebzKytg/Kz/eH86gRxbxVtnGDj
 lrnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPHJd9K2tw+J4nFccJ84v7dnRbkVLCKLFTOGQo9w29tXGJKgmfRVROTqKO5+cj4n5riLBHjRz8n/WrOTK+NQQbQ+7i7po=
X-Gm-Message-State: AOJu0Yx+Ojvq4aLQ2QZ9ivvbIoC3L6QFVHXxH5ju0TpQMc3Ss1s1oPry
 Cm/qxrcZbPx9epAUMSzyARb25oc6+Jhiusj4W1I+yT+1CT+AQVz8O9ig9xG7VDI=
X-Google-Smtp-Source: AGHT+IEIACjCmoLuTY6u9xtx35jlOC/rnwJKa6lhtf8FxGAw9Tf++0xUgboVIrIrZJ5NNM/LktS7nA==
X-Received: by 2002:a05:6a00:929a:b0:702:4a1d:c4a4 with SMTP id
 d2e1a72fcca58-703f8836de3mr11046209b3a.10.1717782192803; 
 Fri, 07 Jun 2024 10:43:12 -0700 (PDT)
Received: from [192.168.223.227] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-703fd371cc7sm2896155b3a.2.2024.06.07.10.43.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jun 2024 10:43:12 -0700 (PDT)
Message-ID: <e6e3f493-214b-4fd0-bff2-c9a7b0661a74@linaro.org>
Date: Fri, 7 Jun 2024 10:43:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] Add an "info pg" command that prints the current
 page tables
To: Don Porter <porter@cs.unc.edu>, qemu-devel@nongnu.org
Cc: dave@treblig.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 philmd@linaro.org
References: <20240606140253.2277760-1-porter@cs.unc.edu>
 <20240606140253.2277760-2-porter@cs.unc.edu>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240606140253.2277760-2-porter@cs.unc.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/6/24 07:02, Don Porter wrote:
> +/**
> + * get_pte - Copy the contents of the page table entry at node[i] into pt_entry.
> + *           Optionally, add the relevant bits to the virtual address in
> + *           vaddr_pte.
> + *
> + * @cs - CPU state
> + * @node - physical address of the current page table node
> + * @i - index (in page table entries, not bytes) of the page table
> + *      entry, within node
> + * @height - height of node within the tree (leaves are 1, not 0)
> + * @pt_entry - Poiter to a PTE_t, stores the contents of the page table entry
> + * @vaddr_parent - The virtual address bits already translated in walking the
> + *                 page table to node.  Optional: only used if vaddr_pte is set.
> + * @vaddr_pte - Optional pointer to a variable storing the virtual address bits
> + *              translated by node[i].
> + * @pte_paddr - Pointer to the physical address of the PTE within node.
> + *              Optional parameter.
> + */
> +void
> +x86_get_pte(CPUState *cs, hwaddr node, int i, int height,
> +            PTE_t *pt_entry, vaddr vaddr_parent, vaddr *vaddr_pte,
> +            hwaddr *pte_paddr)
> +
> +{
> +    X86CPU *cpu = X86_CPU(cs);
> +    CPUX86State *env = &cpu->env;
> +    int32_t a20_mask = x86_get_a20_mask(env);
> +    hwaddr pte;
> +
> +    if (env->hflags & HF_LMA_MASK) {
> +        /* 64 bit */
> +        int pte_width = 8;
> +        pte = (node + (i * pte_width)) & a20_mask;
> +        pt_entry->pte64_t = address_space_ldq(cs->as, pte,
> +                                              MEMTXATTRS_UNSPECIFIED, NULL);
> +    } else {
> +        /* 32 bit */
> +        int pte_width = 4;
> +        pte = (node + (i * pte_width)) & a20_mask;
> +        pt_entry->pte32_t = address_space_ldl(cs->as, pte,
> +                                              MEMTXATTRS_UNSPECIFIED, NULL);
> +    }
> +
> +    if (vaddr_pte) {
> +        int shift = 0;
> +        _mmu_decode_va_parameters(cs, height, &shift, NULL);
> +        *vaddr_pte = vaddr_parent | ((i & 0x1ffULL) << shift);
> +    }
> +
> +    if (pte_paddr) {
> +        *pte_paddr = pte;
> +    }
> +}

This fails to recurse with nested page tables, which definitely breaks the TCG walker.


r~


