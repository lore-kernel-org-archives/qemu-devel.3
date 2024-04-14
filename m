Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E985C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2024 17:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rw3XQ-0005aa-1C; Sun, 14 Apr 2024 13:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rw3XI-0005ZX-1I
 for qemu-devel@nongnu.org; Sun, 14 Apr 2024 13:21:01 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rw3XF-0006go-Cn
 for qemu-devel@nongnu.org; Sun, 14 Apr 2024 13:20:59 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1e3dda73192so15487275ad.3
 for <qemu-devel@nongnu.org>; Sun, 14 Apr 2024 10:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713115253; x=1713720053; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IQ0BycpJRfJfihp4nSCh+JKfL8D62Gg0XgF+qv0uV/c=;
 b=yCm16ggK5MX8CHQI54GT1hOlibDXwZo6hXTw+F8EvQ5uXfHckDeZdiEmLOt3MS5rJ6
 AIh7Y9CTW0GgggboVopc8z8HZK6/orMtVpjjgU6DceYiXjIDSdVDiI3LIquSJ8+tCanf
 99hYQc52z8mCn+gIwwL/Fm8L7EMGw5uIey4oigb3qA79EaKKceqAD2lUOoMgDT/KFy5C
 w3U0Amc8erx1Doel14/3xRpUd9rfytmOl/PawAIMBDE1dpHQFF8FG4XCjFmo0oBMxlM1
 gFacfNxo/e9ttbbQUO79RHNSvyYRVeAEOHPn//C0DSuauODHYc1DvlqOsgXqvesFvZeB
 fL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713115253; x=1713720053;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IQ0BycpJRfJfihp4nSCh+JKfL8D62Gg0XgF+qv0uV/c=;
 b=QFs3XdX6xWHfPoHCnsGscsIsC73F67RZMQrEIcfozVYd6sKKp8EGQ1QR3yqKMj/I4E
 g51eGbt42nwqO2ZgTFYd5TDL8EQD+J8wwAiIrxM8Ix4VWPW2Dstv0wfSJyOzXK2DOMqE
 YZY9VWhn0DIbKDMFmu7vRDCjtDe6xkmrfuQEvPeohi1NK6dO6CpconLfqHLuKZogNv2X
 JkrYNR5r5bRls82toq5erHYWe5uCyWu7/g7dkqLwEMDcjG/tX28l/Zh/QfHrDjexLjxm
 3bkyHfPsxYaglPG7jXfJXRLmX8RLm6SSqXKqy7puEOiqL4zIaNwp5236CkO5a9/XrceE
 XOyg==
X-Gm-Message-State: AOJu0YxUQnMEenm1OaWMxh2ZAIyL/MGg+KxQpmm4bhJj2xgtKFFFUagq
 qRt5cHqsGnk7fNWBw8q0qnd2aAQO6UAZ5/XNFN7uqzyoq/w0YFU5QUEHnD8XFrg=
X-Google-Smtp-Source: AGHT+IEoIHJllmR6YrqZauUpHMVswyVwIXj8q1Y4xQim3V+GXEQGzt1eYbZzRvFgaM86iQV+015GCQ==
X-Received: by 2002:a17:902:d902:b0:1e2:82fc:bf71 with SMTP id
 c2-20020a170902d90200b001e282fcbf71mr6874201plz.22.1713115253443; 
 Sun, 14 Apr 2024 10:20:53 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a170902e54400b001e3f4f1a2aasm6273749plf.23.2024.04.14.10.20.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Apr 2024 10:20:53 -0700 (PDT)
Message-ID: <d831adc5-bfd7-482c-9e83-a10da1014b4b@linaro.org>
Date: Sun, 14 Apr 2024 10:20:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/sparc: resolve ASI_USERTXT correctly
To: M Bazz <bazz@bazz1.com>
Cc: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20240411212936.945-1-bazz@bazz1.com>
 <dfa87b87-8685-46ea-ae5d-3735124fc76a@linaro.org>
 <CAMFqb-anRmzo1HP8Gn2y0eD98+ZsG_a54c_fLMaMc=0AGAz7DA@mail.gmail.com>
 <48ec5cfe-e584-4e84-85d8-856bfd46345a@linaro.org>
 <CAMFqb-Y5mRrVk7dmEjt=EWerFu3qKAVjxE74=X6yfrRJJnqF5g@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAMFqb-Y5mRrVk7dmEjt=EWerFu3qKAVjxE74=X6yfrRJJnqF5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 4/13/24 18:54, M Bazz wrote:
> This thought just came to me. `lda` is a privileged instruction. It has to
> run in supervisor mode. So, I'm struggling to understand how the
> kernel permission was wrong. Isn't that the right permission for this instruction?

The "current" permission, as computed by

> -    case ASI_KERNELTXT: /* Supervisor code access */
> -        oi = make_memop_idx(memop, cpu_mmu_index(env_cpu(env), true));

was correct for ASI_KERNELTXT, because as you say "lda" is a supervisor-only instruction 
prior to sparcv9.

However, using the same value for ASI_USERTXT would be incorrect.  For ASI_USERTXT and 
ASI_USERDATA (and the new names for sparcv9, ASI_AIU*, "as-if user"), we need permissions 
for the user context.

That's what

> +        case ASI_USERTXT:     /* User text access */
> +            mem_idx = MMU_USER_IDX;

this is for in my patch.  This gets passed into the helper,

> +    case GET_ASI_CODE:
> +#if !defined(CONFIG_USER_ONLY) && !defined(TARGET_SPARC64)
> +        {
> +            MemOpIdx oi = make_memop_idx(da->memop, da->mem_idx);
> +            TCGv_i64 t64 = tcg_temp_new_i64();
> +
> +            gen_helper_ld_code(t64, tcg_env, addr, tcg_constant_i32(oi));

and then into the core memory access functions,

> +        ret = cpu_ldl_code_mmu(env, addr, oi, ra);

Unfortunately, we do not have any good documentation for tcg softmmu or the intended role 
of the mmu_idx.  Partly that's due to the final use of the mmu_idx is target-specific.

For sparc32, there are 3 mmu_idx:

> #define MMU_USER_IDX   0
> #define MMU_KERNEL_IDX 1
> #define MMU_PHYS_IDX   2

The interpretation of mmu_idx happens in target/sparc/mmu_helper.c, get_physical_address 
(note there are two versions, for sparc32 and sparc64).

Ignoring MMU_PHYS_IDX, which is handled early, the difference between kernel and user is

     is_user = mmu_idx == MMU_USER_IDX;
...
     full->prot = perm_table[is_user][access_perms];

This controls the read/write/execute permissions for the page.  Note that perm_table 
matches the Access Allowed table on page 248 of the Sparc V8 architecture manual.


r~

