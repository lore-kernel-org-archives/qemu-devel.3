Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C26CC021A0
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 20:06:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjOQs-0001GU-KC; Sat, 15 Feb 2025 15:06:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjOQq-0001Fz-Jq
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 15:06:32 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjOQo-0005P6-Rm
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 15:06:32 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-220c665ef4cso47641455ad.3
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 12:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739649989; x=1740254789; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y5iLVLJflAdT7kgWtcHYNhUCGKXZYdPEfb6LDrwM7gA=;
 b=hF1N7OGCKiDN71gt0gW113fTxvVbcGYywPt7Dz3diY1bbMz8kZE04ZmTZJA41uBwau
 gnXQGqQLdQVC2igrUrPPu6s8fvzCyG3fI/ei9PQ8OKZgzFK72y87eyCVKa1a4r9druew
 w7n6Lw/vKWlZOyPXr96TvXHNPoy3p05GUgXV8QOmT7igfQiPUGoZ8u8VHhC7tCFw3S+y
 3EIIpmq7Xa5limHhUINKlf7i9/owZWUUDuuWmthc029oK6yw7bDbF2E59eXPltxAGQer
 b4watBz9WexA/ASgHgLfveahPhhIriFRSIwBuplJRtefHrSBN2LhQ+l1S8UEWoyfjFqV
 0pJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739649989; x=1740254789;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y5iLVLJflAdT7kgWtcHYNhUCGKXZYdPEfb6LDrwM7gA=;
 b=eTqqiaZaiMWmDZrSni3E5DFHXzbeqc8vYCQT7ct7X3ffczIbYopLPeoXUVO8Gm3WBk
 6U/PKLFygakqq0H0MsYtYHXCVmUqV1JJ4JrcTHcB2oGmBtLgmfzE92taOMNOkMNgqLU5
 oMdHsGhJsXaq5cy2LLoGIWnnq3W2Od3HZ/exqLkmvtaMherlVlOxfkZ9aoGF+8Yj7wnn
 kVpN9AyhREoUzl05QtakFMYs0LS9QHr+SjOzCclc4bAI0KJVjIIzaiukMY8QGn+tou41
 /N4bI/iRYwIGpe//ynOAmtggLuOGgJX6S9nNr+Rbn5saMBn4G/2mSXhgu47vGfcdbVJV
 gJ2A==
X-Gm-Message-State: AOJu0Yw8aE32n5e/6OliSEs1IfLjxHqLD/SlQ9gDWRAtqsb/w3ry+/te
 ajOeUhTOeG/AV3wmZvf5Vfa5zpN49n6L5xXPMYiYb1Sgp+Mhfi0acyTfDbQEsDQH8+r7dU4DTr0
 e
X-Gm-Gg: ASbGncsBoc/A8THpz4mvHmhE72cLiKNinSmoYFntkzgXDqgvwiEpCkjVRzGNEcyiVRV
 hou0eWLyXqYUS3mpctyHp7PjONB2xDOhqR72hOk8g92cSWPRG5pdZJJ5eGFjYCv2BFJMnGatXqI
 8G35AWA32rTsEi/kBriF9mVIkJCwb6upEXLio9hEa9DbdhWaFAkErmOhadRU5VtUhFOHfIeA2sE
 EGGD+LLkHBEPvsrCWr5dFo28YDw4to7qzMgYR4fI46j6yQ/Y3ivAISs3mji9yQQBhH2h6zdxp/v
 Iqjo2Hd3KiTHn64eiTAs6TMJ6ITqp2xp3mxlhFVKvvgvMYVElr7/LJM=
X-Google-Smtp-Source: AGHT+IH77/KDUkeT7oKq2adIoO6TH5UPhRPDWfSMPVbZf2cHBFpty67VXUk3tpeCUjSFZjt7mvgT6Q==
X-Received: by 2002:a17:902:e5d0:b0:220:d1c3:2511 with SMTP id
 d9443c01a7336-22104056848mr58708705ad.26.1739649989479; 
 Sat, 15 Feb 2025 12:06:29 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5367ecbsm47824255ad.59.2025.02.15.12.06.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Feb 2025 12:06:29 -0800 (PST)
Message-ID: <89018dd4-7b71-44aa-9bda-79da6f461e99@linaro.org>
Date: Sat, 15 Feb 2025 12:06:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] tcg: Cleanups after disallowing 64-on-32
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20250205040341.2056361-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250205040341.2056361-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 2/4/25 20:03, Richard Henderson wrote:
> This is not complete by any means, but it's a start.
> 
> 
> r~
> 
> 
> Based-on: 20250204215359.1238808-1-richard.henderson@linaro.org
> ("[PATCH v3 00/12] meson: Deprecate 32-bit host support")
> 
> 
> Richard Henderson (11):
>    tcg: Drop support for two address registers in gen_ldst
>    tcg: Merge INDEX_op_qemu_*_{a32,a64}_*
>    tcg/arm: Drop addrhi from prepare_host_addr
>    tcg/i386: Drop addrhi from prepare_host_addr
>    tcg/mips: Drop addrhi from prepare_host_addr
>    tcg/ppc: Drop addrhi from prepare_host_addr
>    tcg: Replace addr{lo,hi}_reg with addr_reg in TCGLabelQemuLdst
>    plugins: Fix qemu_plugin_read_memory_vaddr parameters
>    accel/tcg: Fix tlb_set_page_with_attrs, tlb_set_page
>    include/exec: Change vaddr to uintptr_t
>    include/exec: Use uintptr_t in CPUTLBEntry

Queued.


r~

