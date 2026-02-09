Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBE4E7E0BC
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 18:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpVdI-0006ll-3X; Mon, 09 Feb 2026 13:05:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpVdF-0006km-Sd
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 13:05:09 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpVdD-0006h5-Vi
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 13:05:09 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2aad802a27aso11321175ad.1
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 10:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770660306; x=1771265106; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3Lu3Iqwxu5L/v1BCbgEcBq9k3jFyJtKxCnIscFcwWyE=;
 b=IyXzWgB97jYB93qKIq4bUTtDQOxI1XrkOmf4RF1pnu9+Zwa46LHYpUWc8oh8fI6lbS
 7h7RaI+MDjNapMPQUZeoHo4ygTU0iPXSt0d7Pu2oAoWsTpdFZR3hNG0dpzsazUJ+J86n
 5RBk1DrnRwTkqiAAKaw4FR5vTsh3fNVgoWADgJCFSxiY8vr05MwkVPeqHM2eiawA8KwQ
 K/L0sm1EClklCpBprBR4sqbxGSOI9//XdBN1bl9rv915NAeHzjzL2JHkobpgzpVBesxl
 TzgJxEbZ6qQIiMyn7OGWyXjaFhp33iCfcu++MMo+MZJ8nkke264aBGrgBW9q5+XxoMA8
 gxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770660306; x=1771265106;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Lu3Iqwxu5L/v1BCbgEcBq9k3jFyJtKxCnIscFcwWyE=;
 b=GUzVH38GffRiHQpws39ZhzqaSPBD2fs/Fg35d59BtrEDCGFMhJ0uo1m29qWjfFWp3a
 enoTTIjWNSktWWwdV7VskqKOiDvY9A4JiFMDCF8OFP7IbQNP6zlA3DQow0euI+zn8H0t
 s8H5MovE/HCOWEZDxf1gpZjh5sLTa9fBMVA2PHxog26cx83En9rMbXkiDyBaAGncAKaH
 DXSv3i0j6lrKnGtC3AAThudvxe+1fxdUyQgT+rW2KfOcbGhCKD6wMhAzV3ofBGNiKIPp
 iYYHnOatt4GKC1wILAmJuUWkd28F61Sr4SWoF/Z8bPF0PO+f6nppcGzBmo1/0DuN2xyl
 suFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeouqISFqSBANRk2MDRjVarrCXfYrgmqOJkLyHigi0810aAEtW+xK3sG0qk7yB61fWkl6ehqOQbw1U@nongnu.org
X-Gm-Message-State: AOJu0YxGfoHX7XdASXFfw81wKDgRgH3BZfo8xRntlnkzj0hXmjecsgJm
 M33sqRc8so4cb6pcA3REHfZhX015fkH6/6e2OmkFye2nrW86hDx3UvnXF6u2g9mJdsg=
X-Gm-Gg: AZuq6aJvQID5gtke3n+PPzYB7Ikj1jx8r7b89Izy5g9DTGeVRW+PLWMGWivx8feHiyB
 lFSPz4cpbj68CRvyX/CoyGLNScy5Cjyslhzbvo2RjWtnU5/H7Yn9mgZ7pUdVeDnlVKjIbDCSWpZ
 8x54sWT0crtrj0th11JzLnEyEjecSILGTvNtoMz7x7tNNg55YVqq3CMRltGgEvtv9fS3ixQLXQi
 5CLljaMCDJc0pXVX1K4rCcPbW3fsxllv25VxUvCDzql21NqMV6HWft7//q033hpORiXI1mLyuXz
 nSr+OqfDCnhMiz24If08ip6GxkH9CigLiWDH7JSH/4M6LvAz1OwkakCBSiub3bo4G2qiqt/ZuXJ
 xWuZVWiuJdtlZBxmzqMxk0A9VH6LhavTGM50fbf/1ZtHSpvqzJRHVXAVsy44JyHBsh9046VFpCL
 HUMWCP3plI0o9w3JHuRMz9CTTACuUSyGjhWkW5QrlNRHY8U7NkgMFAEe87
X-Received: by 2002:a17:902:fc86:b0:295:5132:1a99 with SMTP id
 d9443c01a7336-2a951934b1cmr109746735ad.44.1770660305996; 
 Mon, 09 Feb 2026 10:05:05 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82446e81823sm13496784b3a.12.2026.02.09.10.05.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Feb 2026 10:05:05 -0800 (PST)
Message-ID: <8e23079b-32dc-48a5-88a4-ce72d075053d@linaro.org>
Date: Mon, 9 Feb 2026 10:05:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: handling of non-page-aligned addresses in get_phys_page_debug
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <CAFEAcA8M6AL1xQsiiS1f5nA4XVV6n6mOhi1T3QWfhLb_01+8Tg@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <CAFEAcA8M6AL1xQsiiS1f5nA4XVV6n6mOhi1T3QWfhLb_01+8Tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

On 2/7/26 9:39 AM, Peter Maydell wrote:
> I was looking at a reported bug about semihosting when the MPU
> is being used on Arm CPUs:
> https://gitlab.com/qemu-project/qemu/-/issues/3292
> which turns out to be because in cpu_memory_rw_debug() instead
> of passing in the vaddr we're given to get_phys_page_debug() we
> first round it down to a target-page, then translate it, then
> add the page offset back in. This doesn't work if the target
> is dealing with memory protection/validity at a granularity
> smaller than a target-page, as the Arm MPU does.
> 
> I thought this was a bit odd, because the Arm page-table
> walk code will happily translate a non-page-aligned address
> for you, so I had a bit of a dig into our implementations and
> callers, and we seem to be inconsistent about whether you're
> supposed to handle non-page-aligned addresses here. (By "handle"
> I mean both "can take a non-page-aligned input" and also "the
> resulting physaddr includes the bits for the offset within the
> page and has not been rounded down to a page-base address".)
> 
> Implementations that don't handle non-aligned addresses:
>   * alpha, microblaze, sparc, x86, riscv, s390x
>     (but riscv only because it explicitly masks out the low bits
>     just before returning the physaddr!)
> Implementations that do handle non-aligned addresses:
>   * arm, avr, hppa, loongarch, m68k, mips, openrisc, rx, sh4,
>     tricore, xtensa
> Implementations that were too complex for me to determine the
> answer with a quick look:
>   * ppc
> 
> And at the callsites we have:
> 
> Callers that naturally always use page aligned addresses:
>   * hw/i386/vapic.c : always uses page-aligned addresses
>   * target/sparc/mmu_helper.c: uses in dump_mmu() are always page aligned
> 
> Callers that assume non-aligned addresses are handled:
>   * hw/xtensa/sim.c,xtfpga.c : we translate ELF program header p_addrs
>   * target/xtensa/xtensa-semi.c
>     (these two only work because xtensa is in the "handles" this group)
> 
> Callers that do some kind of "work around getting the page base",
> and mostly-work with both:
>   * monitor/hmp-cmds.c: in hmp_gva2gpa we round to a page base then
>     add back in the offset within the page
>   * plugins/api.c: ORs in the low bits, so can cope with both "get
>     exact answer" and "gives page base"
>   * target/s390x/helper.c: s390_cpu_get_phys_addr_debug is a wrapper
>     implementing "give actual page" in terms of cpu_get_phys_page_debug
>     by the usual "mask and put the page offset back in" approach
>   * physmem.c: cpu_memory_rw_debug rounds to a page base then adds
>     back in the offset within the page afterwards
> 
> Looking at this, my feeling is that we should:
>   * define that these APIs must handle non-page-aligned addresses
>   * fix the six or seven implementations that don't (either "properly" or
>     by adding in the "mask to page base then OR back in the page offset"
>     code to their get_phys_page_debug functions)
>   * clean up the callsites to not work around the lack of handling
>     of non-page-aligned addresses
>   * add/extend the get_phys_page_debug API so that a caller can get
>     the lg_page_size
>   * fix the cpu_memory_rw_debug vs Arm MPU bug by having it use that
>     lg_page_size to determine how much memory to access at once rather
>     than assuming it can read to the end of the page
> 
> Opinions ?
> 
> thanks
> -- PMM
> 

Given the initial need, it seems that yes, the only choice is that these 
API should handle non-page-aligned addresses.

However, we should as well check how many use cases really need to check 
memory protection with a granularity lower than page, because it does 
not seem to be something very common.
Is the Arm MPU the only one?
If yes, maybe something specific should be done for it instead of 
changing that for all arch/use cases.

Regards,
Pierrick

