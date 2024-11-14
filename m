Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69503D6A224
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBeIB-0008R6-Ff; Thu, 14 Nov 2024 13:10:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeI4-0008LD-Ih
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:10:01 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBeI3-0003np-2A
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:10:00 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21116b187c4so8192335ad.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731607797; x=1732212597; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wnErDPYJqPMf8yFGSPkiesdxoyLDeMnH4zvE60sXL/Y=;
 b=CNKIjB9ZnnH+kdgNBE9qxzl6R72nlxY73Ab1Vsc/2p3cwq2N8sE+XMJqGB4s1Z49Dz
 oxLXKl4o3dYkQSOqZHqkAe30brAzzxbq/yOK+OYWI/xsL0z9UGxwo00vn4bFBd3Rw4De
 jp0bvi038duiV3pkzDjA5OyN2p7pOwLhm1LxB6YvW+kdbA4C1Kt0rHOY0WnatdIEl781
 jr8L6NHxQ4b936/SuYwlkEGWFZIFzFSdT7F0eSXbzLeBvCW4HwYlhe7Q2rJ4BjZiQAYD
 Qtyl2q0/73+470//JxBWoonbgzfzyBURCDpfXWOnKKgYm8Dkkfhv3J1jUlkzzp++5rIZ
 jfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731607797; x=1732212597;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wnErDPYJqPMf8yFGSPkiesdxoyLDeMnH4zvE60sXL/Y=;
 b=UnV5TY6ymWn32MrZtB06ZqNzmvKyF6BE3ZLzz+/0pwduzm6HPbx8klD/hPazyL4TOf
 RsdBRR+RL8AUKUh3SUKWnGT2EsUqD79O+hMyDqIRs+6jmyasv4uaXdUjSqE8DW59gtEj
 1a1+dtgxlYRma9Hc0j/PERpQFD84D3NcmZYTbayA/q7LfMijyP/Cev414fg3z0c5EYcE
 HizwvdTodyOGEofYD0AogQfF3G8uiZO4EnktDPlpFKQ1/G4FJmPn8SJoCTS31dH4kLVx
 zPviZyMvgbj/gWrxynE5pQoCKP7lXUJk/qtFr16j2QJ7+1YbiHuejakviU1YhnlN3wPo
 HG3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW18+J7JV/lFymcZLhW/bfLnbXQUZmTMb3d6/cqPZPpc1wcQmYwij8UN7jzZV5Acd/uI2C+TEbsBL5a@nongnu.org
X-Gm-Message-State: AOJu0YxoJMi+FyySwSJkchPxx4NPCo9vvMYNWf59Q6dpnvdN45SjK+km
 ANsgPHuB5fZOQV7pjVwb/cx7zRtHLUJP7vtMFqp9fdXq+XTfCMtwv7HFZvCtBSv6E29ZxLrjNHh
 r9iBxjw==
X-Google-Smtp-Source: AGHT+IEk55vse7JMMI61mHNvGVvubF6+q2oxP/c4T4/0bIhwsBkC1PYpIE3QQMU/2j0QxF+4sHhOPg==
X-Received: by 2002:a17:903:1788:b0:211:6b25:d824 with SMTP id
 d9443c01a7336-211c50920aamr37116265ad.35.1731607796904; 
 Thu, 14 Nov 2024 10:09:56 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a9a89c2sm1540149b3a.94.2024.11.14.10.09.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:09:56 -0800 (PST)
Message-ID: <0cd1e8cc-4c99-496f-9830-ac96e03f5241@linaro.org>
Date: Thu, 14 Nov 2024 10:09:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/54] accel/tcg: Check original prot bits for read in
 atomic_mmu_lookup
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-24-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-24-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 11/14/24 08:00, Richard Henderson wrote:
> In the mist before CPUTLBEntryFull existed, we had to be
> clever to detect write-only pages.  Now we can directly
> test the saved prot bits, which is clearer.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index c975dd2322..ae3a99eb47 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1854,14 +1854,13 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>               flags &= ~TLB_INVALID_MASK;
>           }
>       }
> +    full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
>   
>       /*
>        * Let the guest notice RMW on a write-only page.
>        * We have just verified that the page is writable.
> -     * Subpage lookups may have left TLB_INVALID_MASK set,
> -     * but addr_read will only be -1 if PAGE_READ was unset.
>        */
> -    if (unlikely(tlbe->addr_read == -1)) {
> +    if (unlikely(!(full->prot & PAGE_READ))) {
>           tlb_fill_align(cpu, addr, MMU_DATA_LOAD, mmu_idx,
>                          0, size, false, retaddr);
>           /*
> @@ -1899,7 +1898,6 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>       }
>   
>       hostaddr = (void *)((uintptr_t)addr + tlbe->addend);
> -    full = &cpu->neg.tlb.d[mmu_idx].fulltlb[index];
>   
>       if (unlikely(flags & TLB_NOTDIRTY)) {
>           notdirty_write(cpu, addr, size, full, retaddr);

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


