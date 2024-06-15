Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28BBC27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2024 15:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIVQB-000810-Un; Sat, 15 Jun 2024 11:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sIVQ9-0007zj-RY
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 11:34:26 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sIVQ7-0004Gm-Vm
 for qemu-devel@nongnu.org; Sat, 15 Jun 2024 11:34:25 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f8ec7e054dso2090548b3a.2
 for <qemu-devel@nongnu.org>; Sat, 15 Jun 2024 08:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718465662; x=1719070462; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aZ4YiDQMOV5WP7i00JEgirUW6fvGO4o9nMl6qvLjMCg=;
 b=V2Si0/BViM2uNiKbyz4+3jB+4FSxseUpJplsMFsOPSNHtttLjzbKkdWh6gNrqh4xDa
 csrmknoGMjueCTrx0F99qA0qaCxhod5DZOrVz1DYgRNatbU0eKQvg9CilPibXxnhBP/F
 g1CBNTdCGSE4/+dC236HRWG5QSeej7ENnesBm9tzSFOJgcNbW66DDy3LBjPt1fjAwn20
 5ecOZB5QPBIqABBNngr08FUIFeiP/KfdGNlhN+9bvsLSgnF3SlRIGXx3NoBNGLDiMl2U
 pUhKQieKnVRjGAG1D4klUIw8sljtglrz4zE6qWngSvdVXDjAQwxurfTQGqQrL7T5i/SW
 Ss3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718465662; x=1719070462;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aZ4YiDQMOV5WP7i00JEgirUW6fvGO4o9nMl6qvLjMCg=;
 b=MDamZi7oDXHsRpSOReE9zCcVq8p/0F1rRxccHVLN1cK86s6IFuQx2kizeK8KkqvvdT
 ntA3g2UI8BN+1i5SGv3R1n7TF/DzJS2Cnc98y6GHpW2lOQvVqIs9E+uc89iN+2ncOl2l
 7S4SFktociIuqfRCA4LVnTlOMrA/XwmVLlG4RwpA94iogrZd3vTOuADyBeBArHLtQA5p
 Zqo44SgD36Z2DkSNMPwxh5ZGkY4hfAuyTTBkdR3I7RrSWrCDIjZ67IYoEkValrudy0bu
 c/eyOn8UDunivjgQC0NYG9869dbO/cRS8iVy1I0285qtTdLlwvECdOyNFLjVbFDzJgCB
 2ZYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWP3ITfRLti2pMrO7mSay0Wu6D1+ZOBHRYQxKDFHwgdq1HLDFusbVxrxJEeLSnbF9UAuYizf79mGs7fFA5b3qkUJnCKctw=
X-Gm-Message-State: AOJu0Yy78QsPf2NvuiAEwG22QxTweIQH2JEmbXwWW3dSi/jNRZ8z7IDd
 zwpvwsP+o/tr6/H7V73SOYZaabv+ckUdfIQa/b700/6n3SkbAjsEef624flBqHg=
X-Google-Smtp-Source: AGHT+IGg3KSRjyjyrTs5E2k6Erxkq4BzaU+wmpgtv9LkQwpNuYGkHbQ6BBumK+nDW863VAGH0ouQzA==
X-Received: by 2002:a05:6a00:4b53:b0:704:23dc:6473 with SMTP id
 d2e1a72fcca58-705d71d1d24mr7172900b3a.30.1718465661947; 
 Sat, 15 Jun 2024 08:34:21 -0700 (PDT)
Received: from [192.168.74.236] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705cc96eb9bsm4802942b3a.81.2024.06.15.08.34.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Jun 2024 08:34:21 -0700 (PDT)
Message-ID: <b429e991-4bda-4a58-9392-ad76a8a339c5@linaro.org>
Date: Sat, 15 Jun 2024 08:34:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] Add an "info pg" command that prints the current
 page tables
To: Don Porter <porter@cs.unc.edu>, qemu-devel@nongnu.org
Cc: dave@treblig.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 philmd@linaro.org
References: <20240606140253.2277760-1-porter@cs.unc.edu>
 <20240606140253.2277760-2-porter@cs.unc.edu>
 <e6e3f493-214b-4fd0-bff2-c9a7b0661a74@linaro.org>
 <08e2c726-0788-4c36-99be-88e6cd2c2825@cs.unc.edu>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <08e2c726-0788-4c36-99be-88e6cd2c2825@cs.unc.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 6/14/24 14:14, Don Porter wrote:
> On 6/7/24 1:43 PM, Richard Henderson wrote:
>> On 6/6/24 07:02, Don Porter wrote:
>>> +/**
>>> + * get_pte - Copy the contents of the page table entry at node[i] into pt_entry.
>>> + *           Optionally, add the relevant bits to the virtual address in
>>> + *           vaddr_pte.
>>> + *
>>> + * @cs - CPU state
>>> + * @node - physical address of the current page table node
>>> + * @i - index (in page table entries, not bytes) of the page table
>>> + *      entry, within node
>>> + * @height - height of node within the tree (leaves are 1, not 0)
>>> + * @pt_entry - Poiter to a PTE_t, stores the contents of the page table entry
>>> + * @vaddr_parent - The virtual address bits already translated in walking the
>>> + *                 page table to node.  Optional: only used if vaddr_pte is set.
>>> + * @vaddr_pte - Optional pointer to a variable storing the virtual address bits
>>> + *              translated by node[i].
>>> + * @pte_paddr - Pointer to the physical address of the PTE within node.
>>> + *              Optional parameter.
>>> + */
>>> +void
>>> +x86_get_pte(CPUState *cs, hwaddr node, int i, int height,
>>> +            PTE_t *pt_entry, vaddr vaddr_parent, vaddr *vaddr_pte,
>>> +            hwaddr *pte_paddr)
>>> +
>>> +{
>>> +    X86CPU *cpu = X86_CPU(cs);
>>> +    CPUX86State *env = &cpu->env;
>>> +    int32_t a20_mask = x86_get_a20_mask(env);
>>> +    hwaddr pte;
>>> +
>>> +    if (env->hflags & HF_LMA_MASK) {
>>> +        /* 64 bit */
>>> +        int pte_width = 8;
>>> +        pte = (node + (i * pte_width)) & a20_mask;
>>> +        pt_entry->pte64_t = address_space_ldq(cs->as, pte,
>>> + MEMTXATTRS_UNSPECIFIED, NULL);
>>> +    } else {
>>> +        /* 32 bit */
>>> +        int pte_width = 4;
>>> +        pte = (node + (i * pte_width)) & a20_mask;
>>> +        pt_entry->pte32_t = address_space_ldl(cs->as, pte,
>>> + MEMTXATTRS_UNSPECIFIED, NULL);
>>> +    }
>>> +
>>> +    if (vaddr_pte) {
>>> +        int shift = 0;
>>> +        _mmu_decode_va_parameters(cs, height, &shift, NULL);
>>> +        *vaddr_pte = vaddr_parent | ((i & 0x1ffULL) << shift);
>>> +    }
>>> +
>>> +    if (pte_paddr) {
>>> +        *pte_paddr = pte;
>>> +    }
>>> +}
>>
>> This fails to recurse with nested page tables, which definitely breaks the TCG walker.
> 
> Hi Richard,
> 
> Thank you again for all of the advice and feedback.
> 
> What do you think the correct semantics should be for nested paging?

That it works like hardware does.

> My understanding is that the current 'info mem' command on x86 does not recur on nested 
> page tables, but this does seem like a useful extension.  Same for 'info tlb'.

My understanding is that the two existing hmp commands are broken, and that the *only* 
correct page table walker is get_physical_address.

> In the case of 'info pg', I might want to print each page table separately, rather than a 
> combined/shadow view.

Without doing the nested page translation for the page tables themselves, you're not 
looking at the correct page from which to read the PTEs, and reading garbage.

> My reading of the tcg code is that it also walks the guest page tables first, then uses 
> probe_access_full() to query the guest->host physical translation, but I may be 
> misunderstanding the code: 
> https://github.com/qemu/qemu/blob/046a64b9801343e2e89eef10c7a48eec8d8c0d4f/target/i386/tcg/sysemu/excp_helper.c#L432

I'm talking about this, for the page tables themselves:

https://github.com/qemu/qemu/blob/046a64b9801343e2e89eef10c7a48eec8d8c0d4f/target/i386/tcg/sysemu/excp_helper.c#L69

A better example is for ARM, which has had its debug page table walker folded in:

https://github.com/qemu/qemu/blob/046a64b9801343e2e89eef10c7a48eec8d8c0d4f/target/arm/ptw.c#L553

If in_debug, don't use probe_access_full_mmu as a cache (and host page resolution), but 
explicitly recurse on get_phys_addr_gpc.


r~

