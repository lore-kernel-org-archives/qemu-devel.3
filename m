Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E670ED6A22D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 20:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBgmP-00047v-AA; Thu, 14 Nov 2024 15:49:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBgm6-0003sx-8p
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 15:49:12 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBgm1-000515-DY
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 15:49:10 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2e2e8c8915eso893376a91.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 12:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731617338; x=1732222138; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NvT91xuPxiPPi83Z5rvcALQMp9g2aGeDYw5FZ2UVvgA=;
 b=DWofB5B4e5W8YGFS810ui+So0aH6i6PgqglJWOvaM1noOQs7YY7IsTAb2WEj5MeITE
 zBBHO2jaKeXetBHbY6uTH5r/35Xr77vR9S8WAkC6in2+3MwoOSxXsxbhITUiDjmzMik6
 fMBcmrVltQasBLwPI5vOMFQ82qAMjhj5jRrwD71KWO6E5IM2TH3yDQvb7+EKh2ApJXRb
 INYMzdfA2TEdu5XdvaIKwo5ptjtB0v4tq2RHTph9WQuD0wD3bIGium3LydEBl2EYkkAY
 tPwben//yNKdjR41UKIAzhHQBWfV4EFPI8CweqUZXPrff8McQ1Cq0RA2euofvVec0g2T
 v4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731617338; x=1732222138;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NvT91xuPxiPPi83Z5rvcALQMp9g2aGeDYw5FZ2UVvgA=;
 b=C63H79r6QqTGyMg0QBuip60SzRZL1Wo1fVPypjv3JuBCaCdqqJgDWOdjUdJ7Ti8L7r
 WagV7yXL+CQpy2+bEHbwQYWZJVpBiLV0LFqWAcmlF8Z2t0JE8NUpM4jwfjlDjZt7lRKT
 kpiWxPlNXaWhXXx4yXx8Qrdoy8OcLLLjFdUfeN5/5Ry+SSbjuPvCDJk23q0epr+hFOg1
 0uSk89CejZvM+grJRnHt7dqMtFTaWkFHfwZL3B8TMYFRLnfLKD16ZKWKRnfWdoH/NPvv
 K8OT2mYkTDzkSb0A76dNz46tdrqAUHhgLbwY/hz0fzrT5Ko1oVYWmOf4SiyMQBeCYgNh
 lXvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlo4QCF7bZc0bQUbYQnGXl7R+zwaprbSKBsIzHJhdRxbNgflmk9EXv0uhJvNeA28s/dFVMc5leF/h8@nongnu.org
X-Gm-Message-State: AOJu0Ywwc+Aj3iSF3UsCbJfeGK7laqJKs17BNX9/4E7xqlNFpd+DKPmE
 qxDfwdH1prKNvL/k3gfNGj316jgTdNg447FrQCONoP1F0ABLi4181tnqOz5TpUs=
X-Google-Smtp-Source: AGHT+IE91X7Fcv7dxFSDLh9EGDMQ7wgTgogGy4GFohsdJZGpjj6piuiO4JPRxltr2nHCoXNPK4VLlg==
X-Received: by 2002:a17:90b:1c0c:b0:2e2:e2f1:aee with SMTP id
 98e67ed59e1d1-2ea154fc4a5mr343688a91.22.1731617337991; 
 Thu, 14 Nov 2024 12:48:57 -0800 (PST)
Received: from [192.168.0.4] ([71.212.136.242])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ee428sm1731777a91.50.2024.11.14.12.48.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 12:48:57 -0800 (PST)
Message-ID: <a1db36ca-47db-41c2-a60f-59514b33b757@linaro.org>
Date: Thu, 14 Nov 2024 12:48:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/24] exec/memory: Move qemu_map_ram_ptr() declaration to
 'exec/ram_addr.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-s390x@nongnu.org
References: <20241114011310.3615-1-philmd@linaro.org>
 <20241114011310.3615-24-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241114011310.3615-24-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/13/24 17:13, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/memory.h   | 2 +-
>   include/exec/ram_addr.h | 1 +
>   2 files changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 9458e2801d..58faa3eb08 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -28,6 +28,7 @@
>   #include "qemu/notify.h"
>   #include "qom/object.h"
>   #include "qemu/rcu.h"
> +#include "exec/ram_addr.h"
>   
>   #define RAM_ADDR_INVALID (~(ram_addr_t)0)
>   
> @@ -2973,7 +2974,6 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
>                                      MemTxAttrs attrs, void *buf,
>                                      hwaddr len, hwaddr addr1, hwaddr l,
>                                      MemoryRegion *mr);
> -void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr);
>   
>   /* Internal functions, part of the implementation of address_space_read_cached
>    * and address_space_write_cached.  */
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index e0620ddb03..c4f220ae93 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -73,6 +73,7 @@ void qemu_ram_set_migratable(RAMBlock *rb);
>   void qemu_ram_unset_migratable(RAMBlock *rb);
>   bool qemu_ram_is_named_file(RAMBlock *rb);
>   int qemu_ram_get_fd(RAMBlock *rb);
> +void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr);
>   
>   size_t qemu_ram_pagesize(RAMBlock *block);
>   size_t qemu_ram_pagesize_largest(void);


