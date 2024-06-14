Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BF2C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 21:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIEFZ-0005rZ-95; Fri, 14 Jun 2024 17:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sIEFY-0005rP-DJ
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 17:14:20 -0400
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sIEFS-00020B-JO
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 17:14:20 -0400
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6b09072c9d9so20843076d6.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2024 14:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1718399652; x=1719004452; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5sP5JHcRU1kY29i/XT3PnYYFnnX8Pia+ADKz9m65QKc=;
 b=T96z5tKy0KXGMpkVKgWT4Z8oJj02ukJ/ZAOv7RO1Gjwk66+MZuc1g+SjGR6XMZ/3Vd
 OODmDP2NJOuzMB7ZoZQD5LSXDa7lkHN0YAzH+GjuQacCXcKdyzsfV6NZtGjbvn0AeBK+
 +Qj3SfiAGnWxkufJsF9DN5MnaBqrBZgk0aiiPvFpoACw9kbp9VhSO06T2uBgkfOKh8Vp
 UFTk8kQdI+8ViGB9nHlvROiKv0LteRc7wyOhEF06RL0G6W0RWLiH7UrcL5i3eTrUSF/l
 tXjevjlMOgBltRsDJHJwtHcqh8uhgDxnYJKQ9Xe0k2lOHJcyvO+RAP3zvzNEVgM1sH72
 UO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718399652; x=1719004452;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5sP5JHcRU1kY29i/XT3PnYYFnnX8Pia+ADKz9m65QKc=;
 b=r/CB2dWEBGVxbpLIID8h3nlizgTyoPJ3xT0zTe+7bUXA7YIhKA/W7z64NPSTPwbv8T
 DGV1vD+dOy28cMg8bexG7VinudBpy9gB/o26+mTd+SEvgV3Qzh8VpgZG9qPGlpKKOc+c
 stLmnKuAG972U/YR48gqh3xGdVeyfw6xT0op1jqsFPbMAV/MPCtA05dR3oCotWJmGVML
 2diPU4T9OQWE8ieFSu4AcYJIeasBMI54MrtfcprPVdfDiwufcsHVlsvqv0WWILtssmWw
 Ow9z6Lm0mpKVC2ZabHSvjEbrwgMkWji2gEBB7k4K10fG7yEr3mwlfwrNTzp1p8KfHLu4
 UA2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEPkLvj7ZKe5cgfXNUmFRFF1kp491scn5EwskgCW/4MSAG3CiQa4pgfrROTGyiGBy5old04mIrKisPnVEIvPfL2cdkul4=
X-Gm-Message-State: AOJu0YzmuVaKrGWuV1ziCtexShd0WW5I4ZMJnYKLx5F5NYeS+o1/u0+S
 9xFNsPHmL9eEFpr7U3oGeDkoKOl7D1Osgscc4EzFGZ/GTA76YG2iBLSe7sGxHQ==
X-Google-Smtp-Source: AGHT+IF/gAF8CH1Lj9WFy8ylE6K+TS9Yo78aulplPtfcoLlqD8OjPGKV4XE4fSOKAD8qVxDZ0fm+QQ==
X-Received: by 2002:a0c:db91:0:b0:6af:7b2e:1868 with SMTP id
 6a1803df08f44-6b2af288446mr82119546d6.18.1718399652095; 
 Fri, 14 Jun 2024 14:14:12 -0700 (PDT)
Received: from [192.168.86.22] ([136.56.85.135])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b2a5bf240csm22638806d6.18.2024.06.14.14.14.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jun 2024 14:14:11 -0700 (PDT)
Message-ID: <08e2c726-0788-4c36-99be-88e6cd2c2825@cs.unc.edu>
Date: Fri, 14 Jun 2024 17:14:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] Add an "info pg" command that prints the current
 page tables
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: dave@treblig.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 philmd@linaro.org
References: <20240606140253.2277760-1-porter@cs.unc.edu>
 <20240606140253.2277760-2-porter@cs.unc.edu>
 <e6e3f493-214b-4fd0-bff2-c9a7b0661a74@linaro.org>
Content-Language: en-US
From: Don Porter <porter@cs.unc.edu>
In-Reply-To: <e6e3f493-214b-4fd0-bff2-c9a7b0661a74@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=porter@cs.unc.edu; helo=mail-qv1-xf2c.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/7/24 1:43 PM, Richard Henderson wrote:
> On 6/6/24 07:02, Don Porter wrote:
>> +/**
>> + * get_pte - Copy the contents of the page table entry at node[i] 
>> into pt_entry.
>> + *           Optionally, add the relevant bits to the virtual 
>> address in
>> + *           vaddr_pte.
>> + *
>> + * @cs - CPU state
>> + * @node - physical address of the current page table node
>> + * @i - index (in page table entries, not bytes) of the page table
>> + *      entry, within node
>> + * @height - height of node within the tree (leaves are 1, not 0)
>> + * @pt_entry - Poiter to a PTE_t, stores the contents of the page 
>> table entry
>> + * @vaddr_parent - The virtual address bits already translated in 
>> walking the
>> + *                 page table to node.  Optional: only used if 
>> vaddr_pte is set.
>> + * @vaddr_pte - Optional pointer to a variable storing the virtual 
>> address bits
>> + *              translated by node[i].
>> + * @pte_paddr - Pointer to the physical address of the PTE within node.
>> + *              Optional parameter.
>> + */
>> +void
>> +x86_get_pte(CPUState *cs, hwaddr node, int i, int height,
>> +            PTE_t *pt_entry, vaddr vaddr_parent, vaddr *vaddr_pte,
>> +            hwaddr *pte_paddr)
>> +
>> +{
>> +    X86CPU *cpu = X86_CPU(cs);
>> +    CPUX86State *env = &cpu->env;
>> +    int32_t a20_mask = x86_get_a20_mask(env);
>> +    hwaddr pte;
>> +
>> +    if (env->hflags & HF_LMA_MASK) {
>> +        /* 64 bit */
>> +        int pte_width = 8;
>> +        pte = (node + (i * pte_width)) & a20_mask;
>> +        pt_entry->pte64_t = address_space_ldq(cs->as, pte,
>> + MEMTXATTRS_UNSPECIFIED, NULL);
>> +    } else {
>> +        /* 32 bit */
>> +        int pte_width = 4;
>> +        pte = (node + (i * pte_width)) & a20_mask;
>> +        pt_entry->pte32_t = address_space_ldl(cs->as, pte,
>> + MEMTXATTRS_UNSPECIFIED, NULL);
>> +    }
>> +
>> +    if (vaddr_pte) {
>> +        int shift = 0;
>> +        _mmu_decode_va_parameters(cs, height, &shift, NULL);
>> +        *vaddr_pte = vaddr_parent | ((i & 0x1ffULL) << shift);
>> +    }
>> +
>> +    if (pte_paddr) {
>> +        *pte_paddr = pte;
>> +    }
>> +}
>
> This fails to recurse with nested page tables, which definitely breaks 
> the TCG walker.

Hi Richard,

Thank you again for all of the advice and feedback.

What do you think the correct semantics should be for nested paging?

My understanding is that the current 'info mem' command on x86 does not 
recur on nested page tables, but this does seem like a useful 
extension.  Same for 'info tlb'.

In the case of 'info pg', I might want to print each page table 
separately, rather than a combined/shadow view.

My reading of the tcg code is that it also walks the guest page tables 
first, then uses probe_access_full() to query the guest->host physical 
translation, but I may be misunderstanding the code: 
https://github.com/qemu/qemu/blob/046a64b9801343e2e89eef10c7a48eec8d8c0d4f/target/i386/tcg/sysemu/excp_helper.c#L432

In patch 6 of the series, I replace the chunk of mmu_translate() in tcg 
that walks the guest page tables, but leave the portion alone that does 
the nested page walk.

I'm open to implementing a nested walker, but it might be better not to 
add more functionality/changes to this patch series.

Thank you,

Don


