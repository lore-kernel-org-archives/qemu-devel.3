Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2D3CEDDA3
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 00:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sygfN-0007l8-WD; Wed, 09 Oct 2024 20:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sygfK-0007iU-NW
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 20:04:26 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sygfJ-0000ep-83
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 20:04:26 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7e9ff6fb4c6so405883a12.3
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 17:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728518662; x=1729123462; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d0cC76b1pAmmOqkQ3Rr6TwcHb3Sfc+pPx3AM2zfU2Pc=;
 b=oksmuyph+7qcG5GvRv2CVKStj/1LYHpZOCM+oEl1MpU4kXuF3RHeMvlFo8XDECDMj/
 N0i6aedPfV/h7jKqNIz2NBMO4cP2dATivSJmDuJV/ttvO77NYFP1mVBTwKMDcd1Jd4Y7
 vvg86kDQ424QUX/ug3BFkFeS23sHl1TO5YXYoiUgiWQiZqiTgAQ+R6fHB/nRmPXX7deh
 ZBZpUL1ZQ8une5RCZaEdpT6dKf341u3pkHwaNbXYrJPsO+IowwIbt+Mx5l8VukFyZ9G/
 4PXlMHh/nX+3Gi8vvCdbqF+iJp4CtDHZzodreIvVunRwTcZT+0TQT2veguCSinUSJOi1
 GHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728518662; x=1729123462;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d0cC76b1pAmmOqkQ3Rr6TwcHb3Sfc+pPx3AM2zfU2Pc=;
 b=vHjesd+AV6YBTNEF72iy/FCXQzEyvucfH2fHWeWe42mSdOu+DG3kx8htnByPNcz7hk
 CgMxyTnPVl0YF3cv4t8YgFUbNmNnZ2wqDR89Wjn63zPMHzu3mZ1hP1+EBqMc3fYESJNX
 8Vtx7f6nMIZAtymgBBKr7mCXt5cA8oapuyESAnfSFB48PWgG3+IDIWtWjdy29wRGoe0u
 V79MSe8ngElyIwIE6UM7O8XX+rU8YV+l+6rVpxfeImq98G+9qSE3/L52agN82YdXJo5y
 OY3uHGQNH+AzyMCByGx20j7Pd3VSYVJU3ET2MHhJTeLcIdjAsmTwYTDcNHrsKuAhCh4Q
 Lmtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqx37ScCiNi9RnyhfhM2ZHOgJv3vXety4+L5B73x7EW41jCem8e/EGlam1VH6iPfxV8ofpOIQb5NPE@nongnu.org
X-Gm-Message-State: AOJu0Yx+zI0HnuHCcSleU6ODhkoO8O7a11sLYBrjURMQRtNhFmKfY+fm
 7dQL/RSoCvbPanQX8vulyQKaAxAwA7GS5eQw/kR5hHEnQ7qlDsV70U+UUfeQdJg=
X-Google-Smtp-Source: AGHT+IFMJbeKGMy8rX3C/FyZNlCM6fy4zfsXT2V+sVdHm2J32h2IMzpQUzWRb375Tjl2VSn6aKPP9g==
X-Received: by 2002:a05:6a21:1507:b0:1c0:e997:7081 with SMTP id
 adf61e73a8af0-1d8a3c44a20mr7734506637.29.1728518662300; 
 Wed, 09 Oct 2024 17:04:22 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d66319sm8313449b3a.156.2024.10.09.17.04.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 17:04:21 -0700 (PDT)
Message-ID: <a8424dd9-399a-498a-870a-dab6e6b96c7e@linaro.org>
Date: Wed, 9 Oct 2024 17:04:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/23] accel/tcg: Process IntervalTree entries in
 tlb_set_dirty
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241009150855.804605-1-richard.henderson@linaro.org>
 <20241009150855.804605-14-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241009150855.804605-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x530.google.com
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

On 10/9/24 08:08, Richard Henderson wrote:
> Update the addr_write copy within an interval tree node.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 95f78afee6..ec989f1290 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1063,13 +1063,18 @@ static void tlb_set_dirty(CPUState *cpu, vaddr addr)
>       addr &= TARGET_PAGE_MASK;
>       qemu_spin_lock(&cpu->neg.tlb.c.lock);
>       for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
> -        tlb_set_dirty1_locked(tlb_entry(cpu, mmu_idx, addr), addr);
> -    }
> +        CPUTLBDesc *desc = &cpu->neg.tlb.d[mmu_idx];
> +        CPUTLBEntryTree *node;
>   
> -    for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
> -        int k;
> -        for (k = 0; k < CPU_VTLB_SIZE; k++) {
> -            tlb_set_dirty1_locked(&cpu->neg.tlb.d[mmu_idx].vtable[k], addr);
> +        tlb_set_dirty1_locked(tlb_entry(cpu, mmu_idx, addr), addr);
> +
> +        for (int k = 0; k < CPU_VTLB_SIZE; k++) {
> +            tlb_set_dirty1_locked(&desc->vtable[k], addr);
> +        }
> +
> +        node = tlbtree_lookup_addr(desc, addr);
> +        if (node) {
> +            tlb_set_dirty1_locked(&node->copy, addr);
>           }
>       }
>       qemu_spin_unlock(&cpu->neg.tlb.c.lock);

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

