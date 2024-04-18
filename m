Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA342C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 14:59:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxTDZ-00045e-6F; Thu, 18 Apr 2024 10:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rxTDV-00045N-Dj
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 10:58:25 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rxTDP-00084B-3D
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 10:58:23 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1e36b7e7dd2so8530465ad.1
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 07:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713452296; x=1714057096; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cv+5C3l0uFMm1U+IbPueBo1xGfdc8hg5GiL8YRYk1tc=;
 b=r2iyJoHUmlhS0Jb3yR9x0KXIWRtIwVkAkI5dUp7BF5yCis9vOxpINraOcx1vroGx1S
 ZQ+XYZ1QxY5D8TlatqlHo1uGagYUm7Lq+M41vvtExPTxHI8Qv3mwYvAGAejr7rRvkpf4
 a9SZjo/70GVI+YqGODyu5Qk7WdSnq7grB/IVZjkJkl1/ebfOkcrAaeR6DgI2VEZiXMHq
 gcah5plvLHRTVVLaKz22CV/Xei+tyN5wlzOL9Ij7KQXEOosbB6pNX6GiM4eY566u3z7m
 dw7UsskerD13BHSwIOlxqBvC8KCivXNY27SXGug03aQcCCSHJ9jcm6lDk+WReTvxTcQ+
 532g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713452296; x=1714057096;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cv+5C3l0uFMm1U+IbPueBo1xGfdc8hg5GiL8YRYk1tc=;
 b=VvO2PdDzYHlj70f4wNczvyLy9oWmjBHPjvjCtLw4pCld7Tf7TB1XaAGa7q86FS4gtX
 /Q7+ZyeZLH+/C0fWfsjpqes5vy+T/8X5owEALd/QwlWwFBLbtfg4qH05KLlizsHPlV9t
 K0UQWRuT5KMv0c9oJkSSHgjj+WqGOWeodXxP3ir4VLozNpvtRXfOZPqcjrsad+kLMLwS
 8NODawsFUra0FC/N79bIh1u1BWv2KyZz3mYBt7dqf/iICBWLsTseUXLAvhqMUGLrcIDr
 5xeliZVHlH7D67d+KDcA99jkd5ZK/RyOOn56jNSG2D+55P0VHaNF+NFJoLUkcx//y0JV
 Ljtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAvxW/AbGN2AlvvXC9qC7YOxRkDlujrpIEfhas9PU4+anzfye9hMyOTAI0nk+SnEScZDH90o/beMJHBHBrwl5JgG8D4w8=
X-Gm-Message-State: AOJu0YzYYHwldiwDvB574Nfj99SCauUg659Uy841CbAqLMZJcciO/D0l
 7jXqvkYiel3WmMVwzSVwS5hzqgNkhu4lV8ZMfmbt5DFqnftGIBScC6u6SV/RegtihS6h/BlaLz2
 r
X-Google-Smtp-Source: AGHT+IFJ91h0quKCS+TNV8XUxE2hOMRpmVOcHQUWZ0zy3oEkVJj3r4KEEdOn/DgAb5VItjkcrs/2AA==
X-Received: by 2002:a17:903:240c:b0:1e4:514a:55af with SMTP id
 e12-20020a170903240c00b001e4514a55afmr3594938plo.68.1713452296024; 
 Thu, 18 Apr 2024 07:58:16 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a170903018e00b001e29acb2d18sm1621177plg.4.2024.04.18.07.58.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 07:58:15 -0700 (PDT)
Message-ID: <7c3b9a13-b503-47dc-ae02-ac9da8142605@linaro.org>
Date: Thu, 18 Apr 2024 07:58:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg: Fix the overflow in indexing tcg_ctx->temps
To: Zhiwei Jiang <jiangzw@tecorigin.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20240418102747.27703-1-jiangzw@tecorigin.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240418102747.27703-1-jiangzw@tecorigin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 4/18/24 03:27, Zhiwei Jiang wrote:
> Sometimes, when the address of the passed TCGTemp *ts variable is the same as tcg_ctx,

Pardon?  When would TCGTemp *ts == TCGContext *tcg_ctx?


> the index calculated in the temp_idx function, i.e., ts - tcg_ctx->temps,
> can result in a particularly large value, causing overflow in the subsequent array access.

Or, assert:

size_t temp_idx(TCGTemp *ts)
{
     ptrdiff_t n = ts - tcg_ctx->temps;
     assert(n >= 0 && n < tcg_ctx->nb_temps);
     return n;
}

>   static inline TCGTemp *tcgv_i32_temp(TCGv_i32 v)
>   {
> -    return (void *)tcg_ctx + (uintptr_t)v;
> +    return (void *)tcg_ctx->temps + (uintptr_t)v;
>   }

This will generate 0 for the first temp, which will test as NULL.



r~

