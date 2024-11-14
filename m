Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5D8D6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBe8L-0007Rc-J2; Thu, 14 Nov 2024 12:59:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBe8G-0007R8-Cn
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 12:59:52 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBe8E-0002Bm-R0
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 12:59:52 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2e2dc61bc41so758252a91.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 09:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731607189; x=1732211989; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gDUCd09/i0qDkPVwFFg+c61szBJf4fAZ41YxmIC+P1Q=;
 b=bYvr+NUF62++X+NFUMKOHf8/++ApwFQv8uDbC497Xyr0pIue2Y9mASBEHS9YoU9TS/
 0srO5BCz6x4fV9Pl7Ez7aJB/BbkMDJhHbgewUG1dSSPVN4uu4Lko/nSKhB+IVXE07H2U
 Bo6+FWjixHgJAvWupejcjgohXmu1EJnrgMl/7RLbOqTkX17JoYGhinWbSTok3naaGKZy
 eu2aEIq1gFa+WBY5My/S2w5C0xyGPA5XQ/DOIsYdimm0nDfNmeVhQbJToD4XjaC4WaZv
 YjbbHFYUwaBwWWx4OiA1Z7zUWnv1ec3jYgeMxro7tV7+D7ocH8FTF/B1xtJaWwh4EIBY
 VLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731607189; x=1732211989;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gDUCd09/i0qDkPVwFFg+c61szBJf4fAZ41YxmIC+P1Q=;
 b=U3wNJqpIlgQcj5TbE6xuw9tkpMz0Xa1bxljKfRMX5GF7+ryrX3JiPIMl6SRA0+JxXv
 p721I8OVJjz03ftmwIgOXOPPoNQ0iS7IJ7/U3fle/n6l2YeAhrCL2FLGEp0jVaii9QLE
 uRElsOn0PT8QoMNUeZMlSpBg2RXuAEhcVf201ozGkVFfEOnyMVJg+ve4UM+uS9YUOzWD
 mMvE81biotnev/3fMo0upjipb0GeVhxkppI633fXwlSVP8B/OYW11ON2ZMexLKr7Peyn
 T755gvQ5tAQ0XW07dFPyUIJcPyst75LXKvcJXPCi+QzpQ1X4DyWjFAk9kyhhtZkaiZIi
 tQfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWUZx9IoEUiq6KE4SWjSo6JjcskcHdKkwI+dlJz3x5KGTZ+vRhe2Tx671OxJoE2Y7i4v6n3H4+87H2@nongnu.org
X-Gm-Message-State: AOJu0YzDq4liNrFk5pKx7gAlKm/5Jfejag4hEpjI/VrKLIr4uqFDFvsz
 H7YSzSlc5VFBPizTPK89d3W8/uuquTvO4vSL2D9VBGq61Q7WFdWdwDLpIrSEKJc=
X-Google-Smtp-Source: AGHT+IG+O7Za2vHwnuTF8J9X3YJcEyfEfeLQTEmRFrVVVRaEVFZlqpw9rWc31Cy+Wt0QojDDQlBVow==
X-Received: by 2002:a17:90b:4f42:b0:2e2:d3f6:6efc with SMTP id
 98e67ed59e1d1-2ea0639e436mr3057122a91.28.1731607189419; 
 Thu, 14 Nov 2024 09:59:49 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024a4f7esm1582346a91.29.2024.11.14.09.59.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 09:59:48 -0800 (PST)
Message-ID: <9fd8543a-1a8e-4000-9688-7303cb290dcc@linaro.org>
Date: Thu, 14 Nov 2024 09:59:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/54] accel/tcg: Add IntervalTreeRoot to CPUTLBDesc
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <20241114160131.48616-10-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114160131.48616-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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
> Add the data structures for tracking softmmu pages via
> a balanced interval tree.  So far, only initialize and
> destroy the data structure.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/core/cpu.h |  3 +++
>   accel/tcg/cputlb.c    | 11 +++++++++++
>   2 files changed, 14 insertions(+)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index db8a6fbc6e..1ebc999a73 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -35,6 +35,7 @@
>   #include "qemu/queue.h"
>   #include "qemu/lockcnt.h"
>   #include "qemu/thread.h"
> +#include "qemu/interval-tree.h"
>   #include "qom/object.h"
>   
>   typedef int (*WriteCoreDumpFunction)(const void *buf, size_t size,
> @@ -290,6 +291,8 @@ typedef struct CPUTLBDesc {
>       CPUTLBEntry vtable[CPU_VTLB_SIZE];
>       CPUTLBEntryFull vfulltlb[CPU_VTLB_SIZE];
>       CPUTLBEntryFull *fulltlb;
> +    /* All active tlb entries for this address space. */
> +    IntervalTreeRoot iroot;
>   } CPUTLBDesc;
>   
>   /*
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 31c45a6213..aa51fc1d26 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -89,6 +89,13 @@ QEMU_BUILD_BUG_ON(sizeof(vaddr) > sizeof(run_on_cpu_data));
>   QEMU_BUILD_BUG_ON(NB_MMU_MODES > 16);
>   #define ALL_MMUIDX_BITS ((1 << NB_MMU_MODES) - 1)
>   
> +/* Extra data required to manage CPUTLBEntryFull within an interval tree. */
> +typedef struct CPUTLBEntryTree {
> +    IntervalTreeNode itree;
> +    CPUTLBEntry copy;
> +    CPUTLBEntryFull full;
> +} CPUTLBEntryTree;
> +
>   static inline size_t tlb_n_entries(CPUTLBDescFast *fast)
>   {
>       return (fast->mask >> CPU_TLB_ENTRY_BITS) + 1;
> @@ -305,6 +312,7 @@ static void tlb_mmu_flush_locked(CPUTLBDesc *desc, CPUTLBDescFast *fast)
>       desc->large_page_mask = -1;
>       desc->vindex = 0;
>       memset(desc->vtable, -1, sizeof(desc->vtable));
> +    interval_tree_free_nodes(&desc->iroot, offsetof(CPUTLBEntryTree, itree));
>   }
>   
>   static void tlb_flush_one_mmuidx_locked(CPUState *cpu, int mmu_idx,
> @@ -326,6 +334,7 @@ static void tlb_mmu_init(CPUTLBDesc *desc, CPUTLBDescFast *fast, int64_t now)
>       fast->mask = (n_entries - 1) << CPU_TLB_ENTRY_BITS;
>       fast->table = g_new(CPUTLBEntry, n_entries);
>       desc->fulltlb = g_new(CPUTLBEntryFull, n_entries);
> +    memset(&desc->iroot, 0, sizeof(desc->iroot));
>       tlb_mmu_flush_locked(desc, fast);
>   }
>   
> @@ -365,6 +374,8 @@ void tlb_destroy(CPUState *cpu)
>   
>           g_free(fast->table);
>           g_free(desc->fulltlb);
> +        interval_tree_free_nodes(&cpu->neg.tlb.d[i].iroot,
> +                                 offsetof(CPUTLBEntryTree, itree));
>       }
>   }
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


