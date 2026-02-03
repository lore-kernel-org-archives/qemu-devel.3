Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5FFE87841
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnIgA-0008C5-FD; Tue, 03 Feb 2026 10:51:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vnIg8-0008Bh-G0
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:51:00 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vnIg6-0002eN-Vw
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:51:00 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-794ed669269so16999047b3.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770133857; x=1770738657; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nweXpAVR5yE3S3tJQvOq3J/9XiyMOVRCGPzODW4a0Ac=;
 b=T/Lp8pbQBps1QM7v+FZn3qy/N7f0ly48Xn7e/OBIVjPJv42fTTfe4OObXNbsfWAIqi
 s0AF2kmi8MJsWB0OoFqZoYNgopULuf/KPkL0PVG7OxrRtkNY1j0qTj6i2Tj5V7GUqABQ
 meeE8bDf8N1E/9EpZOBZtQJsKT/gwxSeVoE41gMK0TdCLNaNE8IG5gUIE2g3XgWZNtqT
 T5JPu6K6GvTotz0KQLVWdqRoHtYOpw/wQX379lG+d/eRXz9v03+FAedf5p6sJOres2rE
 TGCmlwwVe8fm4NQnPtPwtexh2Z9bvoUzwKuk0sVRL7/hzI6IRC9wb5vNq3gNPqpEM4Wc
 qoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770133857; x=1770738657;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nweXpAVR5yE3S3tJQvOq3J/9XiyMOVRCGPzODW4a0Ac=;
 b=dyz2SceRSgPac4mHUPQx9MGS6xyiruWXZxmFJDQN01uBrPD4jFlwY8//fc3/nchHXQ
 afe3EyzYnjw8GPkF/uqaE0dSW2CcotyizvN5yBxlvZ8ChydhSd3E/z56omyzrSNXxYC1
 oqR6hhRFZaUblBTXbluwgyrYXsrGkNx+gvw/Y/Uuhg0z6cWRK2iNgDJIJ1dpQ1xKG3/4
 v8Zqjuz81ngs1J2JdCKY2VekdhWN8n0MCLR7NK568ETqyKKU5eesBqQKbjyOxDp77TVd
 NdFrJV8pNr7HPYObbCA5gWUyI4NeQhxBvCFm/9Fg4q0uZ+CyP8oKZFPohMEH4SlbsOHr
 Fa+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp4QMXp6V7zAS4Dn5OKZLD2Fl39Dw2R9MGtkq4HBt+dLi7B1quqvQt0/HLsEp5wo+5XL8K9ktzLPlr@nongnu.org
X-Gm-Message-State: AOJu0Yxl4P8vWOqaWgDB33NJ7EF3QGVSfGM1hiCc0lBWS4IN+X53VKRb
 rFauDyJVP4qJZo6ftrhV8dEN3gz4dOmUocrS40gfrC20xe+NFuGivaWVruG62vAjZvc=
X-Gm-Gg: AZuq6aLy8i/xLw43L+00wjLzqm7mAzsuo14ql+U04PuDFuYcC1S7k+fCTwehrYgblLZ
 56mbJ4T2Kt+AuAVGRb1Ig4EQP2yMHhT0zBduyeHpZp6a+FO07D/8Iv/q1cKvanofBk+htmbmu8Q
 Egq+IAuwfDN6nkbOHWI1NA+NkLMklYPXT8wiDpOd7IC6xGKLHWQT/xzC3JOPNqP9XgmX3ltS+ue
 FR5R2g9sbTvBMAYrizyG3Iet0ZjtG6mJ9IpxSGMNwwg+FJaFpukyxUh0sB4bnRZBGMXe9KA9ctK
 VHVtJB7HxY2loYoj+uGg4oi09hftDF4KOT7wlWZgD5vqh5hMgaHhSmn4WI4rcpaHOr7ovoVzJBS
 pChAH8wUnik4zDmScC345WZkdKULfCtf9xjEZoIVTc9hCeFAydoD4oxShhaiiOWtxdszvN0i2UH
 pnOFoe1/7v/gE0s4smk2ms2a5wsHlfsSM6iGBG/zy+HjURDCKUcX/lhG29zhiJRlKF
X-Received: by 2002:a05:690c:883:b0:793:ad45:8e8b with SMTP id
 00721157ae682-794ecd7082fmr31685447b3.19.1770133857361; 
 Tue, 03 Feb 2026 07:50:57 -0800 (PST)
Received: from ?IPV6:2804:7f0:b403:fa9a:2608:2372:752c:1f85?
 ([2804:7f0:b403:fa9a:2608:2372:752c:1f85])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-794828a9d1asm112542207b3.31.2026.02.03.07.50.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 07:50:56 -0800 (PST)
Message-ID: <686af89f-29db-4cfb-a00a-ff680c4c6382@linaro.org>
Date: Tue, 3 Feb 2026 12:50:53 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Remove a redundant argument attrs in
 io_prepare()
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260203142737.2164763-1-jim.shu@sifive.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20260203142737.2164763-1-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=gustavo.romero@linaro.org; helo=mail-yw1-x1132.google.com
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

Hi Jim,

On 2/3/26 11:27, Jim Shu wrote:
> attrs is already in CPUTLBEntryFull, so this argument is redundant.
> Just remove it.
> 
> Clean up commit 94c6e9cf04409e38563080348d6136879f91ffee
> 
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> ---
>   accel/tcg/cputlb.c | 18 +++++-------------
>   1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 76546c66515..15ee29e7524 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1271,7 +1271,7 @@ static inline void cpu_unaligned_access(CPUState *cpu, vaddr addr,
>   
>   static MemoryRegionSection *
>   io_prepare(hwaddr *out_offset, CPUState *cpu, CPUTLBEntryFull *full,
> -           MemTxAttrs attrs, vaddr addr, uintptr_t retaddr)
> +           vaddr addr, uintptr_t retaddr)
>   {
>       MemoryRegionSection *section;
>       hwaddr mr_offset;
> @@ -1974,12 +1974,10 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
>       MemoryRegionSection *section;
>       MemoryRegion *mr;
>       hwaddr mr_offset;
> -    MemTxAttrs attrs;
>   
>       tcg_debug_assert(size > 0 && size <= 8);
>   
> -    attrs = full->attrs;
> -    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
> +    section = io_prepare(&mr_offset, cpu, full, addr, ra);
>       mr = section->mr;
>   
>       BQL_LOCK_GUARD();
> @@ -1994,13 +1992,11 @@ static Int128 do_ld16_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
>       MemoryRegionSection *section;
>       MemoryRegion *mr;
>       hwaddr mr_offset;
> -    MemTxAttrs attrs;
>       uint64_t a, b;
>   
>       tcg_debug_assert(size > 8 && size <= 16);
>   
> -    attrs = full->attrs;
> -    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
> +    section = io_prepare(&mr_offset, cpu, full, addr, ra);
>       mr = section->mr;
>   
>       BQL_LOCK_GUARD();
> @@ -2492,12 +2488,10 @@ static uint64_t do_st_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
>       MemoryRegionSection *section;
>       hwaddr mr_offset;
>       MemoryRegion *mr;
> -    MemTxAttrs attrs;
>   
>       tcg_debug_assert(size > 0 && size <= 8);
>   
> -    attrs = full->attrs;
> -    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
> +    section = io_prepare(&mr_offset, cpu, full, addr, ra);
>       mr = section->mr;
>   
>       BQL_LOCK_GUARD();
> @@ -2512,12 +2506,10 @@ static uint64_t do_st16_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
>       MemoryRegionSection *section;
>       MemoryRegion *mr;
>       hwaddr mr_offset;
> -    MemTxAttrs attrs;
>   
>       tcg_debug_assert(size > 8 && size <= 16);
>   
> -    attrs = full->attrs;
> -    section = io_prepare(&mr_offset, cpu, full, attrs, addr, ra);
> +    section = io_prepare(&mr_offset, cpu, full, addr, ra);
>       mr = section->mr;
>   
>       BQL_LOCK_GUARD();


Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

