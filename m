Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5AC606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wqB4JB6h
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVWOH-00051g-98; Mon, 23 Nov 2026 10:55:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xVWO9-000519-Cg
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:55:29 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xVWO6-0004zj-9U
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:55:27 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3b49a6e8212so595841a91.2
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 07:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795449325; x=1796054125; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+BxwWhDaELWUH0+LYGqLWY38OKZfleshvKR2YXCe81M=;
 b=wqB4JB6hX6kyH75UOz+b8Q4ulzGAgBsUQnMi+KXgQ7GaGmaZO4d+ro1P1frM6eX0uN
 vpuO3KMX/T0+7XE8rJegFJDTGKU1uVlf0iDOt7pMc8cDunh55PeOGp0H36Bog2SMLTZ9
 70/GIB0RdVSjSKNkUBK1XMHt+hxghtU3OoG4nANNHjtcK1O3q85l32qxgnBNOC+1w5QX
 OPE1jueM/nf1Ft2dkESA3wW8RH+/Mo/5XfmDDQP+Bs2G9oak3O816eS0SxRH0djFPJ3S
 bHU6i7Vl/GSGVyDCGm0KyxiZEizQzcTS2AP5i8AO0Ij7zV0TctlbR7UCXi5qEbncWdW2
 kEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795449325; x=1796054125;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+BxwWhDaELWUH0+LYGqLWY38OKZfleshvKR2YXCe81M=;
 b=oCfqkv1bP7bRH5uaqfSnY+4xsLvy42Ng/XhPxQaF+uIaNVWA7IE2YFih/RXvHYi9FI
 3YZi7cOSxzXJ7G0N009QmHChfNYjhaz9KgEV1dCxHlJ+WMvHT4oiRTpcrIca2dK/4kth
 B5FY1ZJ1FmAh7p9enZ5X532gfMCGuuUL310sX2+xE2YMBhfKpCPHwt0CD6ci6EACPDQM
 Tr6toO98GKmRsGFa+Dq9YxBJmyqA8uEeeXsJUX8JqCx0+5EqXydQVBDIbJudzVpBVLuN
 TtyoHaZogRSqjQxYMaalXCpKz17BfBNApXp9F9q5eiYThk/DpjNluefQ8EY69NYT4KjT
 Y17g==
X-Forwarded-Encrypted: i=1;
 AL+hErF0pFLVEeBYtaURnsd58Dpm23L48lr1aieaU9CtSvKB043NKhw3nc/5ALQQYvXPTDyWPSzj/tJVyKif@nongnu.org
X-Gm-Message-State: APuU4Z+TGbXNVQ8+/2i2lOstVr2kP4jEtdwpbNR+5F1qoiUFqSkdJAMU
 a645sQp1KYnvo6ARiVCGoOxFWHqIz92Lnsr704oyar2ow84MEnZTQAprXbpP5FwaMFM=
X-Gm-Gg: AZFdTZeWB4WGESpjoPDjecMOpFQ3Vbw9PooRnFh2BklGzWqQ9shzJaID7SuDjvm/5EG
 cWIu1qXyVk5/6Usim+D8zu25wed4siLNh9gAnu4DOMKDKpXbWqzN1IjTyUlf81Mg2isr/8Kl9Qn
 Wh2zSRta8E7xVjnGiMv+Gb+EI5EaQXCM2auOh1SqXTUlcEXbL+IQWzoXtx21uixv8+pcSi8guCR
 wg0jo3Jo1vRp1NITYHZd2KsVp6jCcPLV5md9TlnHIiaFOfL+L5vYnVXhcGMqt7hC6X/vFEadIMm
 bfz5M3Co3HoGQYxIlE5+ICSinMTmWqqwBpSngfIt82fmr0Z26yL8Y6rIM5hmU76zYblM/ON/cP/
 Z4dS4yXOG03EapgpCP3yshdDDInz9zFshTkw2n6TZcG1EyOTIyDZihIH+PCXLmPpPDDYRG4oe34
 BNLcEoGKW0dbUzy2NMK7Gyzh7iE84wbGV6/OfiYsQEi5o9ZX2D/GsvIVeENffdFTPYVXnuhzhzI
 rS1PofqYE17L38yaUt94Zz7pJn0elUVfhnj755/Adh+nUHQhmn4BEZJhKjpNSnZIfhxzx7ndPX9
 d2t/fWgpBAuPyou0T/naGOSp81RhM8y01gHm8p4qogJTSe5u3mi2x0EhdpJi4gCh
X-Received: by 2002:a17:90b:3d8d:b0:3b3:b704:118c with SMTP id
 98e67ed59e1d1-3b41cb4f321mr10697699a91.65.1795449324577; 
 Mon, 23 Nov 2026 07:55:24 -0800 (PST)
Received: from [172.20.3.121] ([156.19.246.27])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03ee84425sm57292245ad.6.2026.11.23.07.55.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 07:55:24 -0800 (PST)
Message-ID: <067f8bd5-249b-4d20-8b27-f77594efdb4e@linaro.org>
Date: Mon, 23 Nov 2026 07:55:20 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Skip clean MMU modes when resetting TLB dirty
 flags
To: Murat Seker <muratseker@meta.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20261102022732.2418106-1-muratseker@meta.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261102022732.2418106-1-muratseker@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/1/26 18:27, Murat Seker wrote:
> tlb_reset_dirty() scans every MMU mode, including modes whose TLBs
> contain no entries. These scans waste work while holding the TLB lock.
> 
> Use the dirty MMU bitmap to scan only modes that may contain entries.
> A clear bit indicates an empty TLB, so skipping those modes preserves
> the dirty flag reset behavior and reduces time spent under the lock.

How much time?

For hosts with out ctz, like riscv without Zbb, does it slow things 
down?  Is a simple

     if (dirty & (1 << mmu_idx))

test just as good?


r~

> 
> Signed-off-by: Murat Seker <muratseker@meta.com>
> ---
>   accel/tcg/cputlb.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index dc83f3bad8..386f1beb5f 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -918,10 +918,15 @@ static inline void copy_tlb_helper_locked(CPUTLBEntry *d, const CPUTLBEntry *s)
>    */
>   void tlb_reset_dirty(CPUState *cpu, uintptr_t start, uintptr_t length)
>   {
> -    int mmu_idx;
> +    MMUIdxMap work;
>   
>       qemu_spin_lock(&cpu->neg.tlb.c.lock);
> -    for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
> +    /*
> +     * An mmu_idx that is clean in c.dirty has been flushed and holds no
> +     * entries, so only the dirty ones need scanning.
> +     */
> +    for (work = cpu->neg.tlb.c.dirty; work != 0; work &= work - 1) {
> +        int mmu_idx = ctz32(work);
>           CPUTLBDesc *desc = &cpu->neg.tlb.d[mmu_idx];
>           CPUTLBDescFast *fast = cpu_tlb_fast(cpu, mmu_idx);
>           unsigned int n = tlb_n_entries(fast);


