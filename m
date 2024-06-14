Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1531C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 12:35:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI68l-0007l3-Nj; Fri, 14 Jun 2024 08:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sI68j-0007kf-Qk
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 08:34:45 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sI68h-00081o-S5
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 08:34:45 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a6265d3ba8fso243863966b.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2024 05:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718368481; x=1718973281; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ztpk4cEgoI92Jk1i/3O/V5DzxdGlU1Uh35xrKqy062c=;
 b=WoAESHiIJzLWEQRLBZWc82z9k6e+3Ca0SZsUexFr82QWPr9qD+6zYq/DaJOL/I4Ici
 tcBVwjkoxFpvRAgqs5/Ys1USBOiiq3haJurjsARclWOWI+zqUvdfasOQANCRYsRFqvnq
 YDKbTTXOfOdgCEU6vkTgepMTxXajktTIwRdpfT5VmoFMK9og22oIh8L5vOIl8h5TIM9z
 ZEBqTFcZAt70Lp0cO6UFRxbJ+whqyZP/MQO8lRk1fBgnRFxI1f0iA0UFa1RrB1qhG/TH
 GO2N/d9bhYKm30NEBetDxaBrKFT+xowfYoCstiU4wRRUvytdyioy4zhQS7h8o8fxTS2w
 umGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718368481; x=1718973281;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ztpk4cEgoI92Jk1i/3O/V5DzxdGlU1Uh35xrKqy062c=;
 b=PU+kVSVL13Gj99jBbwCdG3eoDZRGbPef5gIkUJLgcIiGArloiNMLbPMswvZC4pbKaL
 WpdLbP7MWgFDv2CvwVRjCUrdZm+ER352WeI9LSdbcJ46mr5fDhVPbR+v+UcXVosWnnIy
 wmLQ+WhTmY5ClbmP+RyuKw/1S19lyrpNardT2vBxKsQlsq5512XcQ9zY6Uw8DR6PoUbc
 jY2CL5Zxh1jRLDXBWBXVIlf6qqAWwLxMB1KizbKFqFBa/mvp3FvX7Vu81QBCdlZ/oAZD
 n0cMIihEiofzMF88+oVntOSdUjHm/sQV0RUcfKJmlc8vjYqMJdusvM0A/3xtHeGz/Ncf
 G6vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwm1JP9qzgGYFQIbxOqJe/c5khSNnZXQBtrB5/eQd/0goSWStlbZ5pgvHs3dsN4xHHHm35RwcltIzxslz7V0NyImd0H3A=
X-Gm-Message-State: AOJu0Yx1XqrokCK3H3E6geD/YxfIayrYOjV56TBkBc/TCKOJPqdgIiN9
 qHXrQ4N+ap3HVfJJqeHPBvS8h30xZ5+qEoESe4e/FKNT/JxKmDg7KCxxwT/6flo=
X-Google-Smtp-Source: AGHT+IFa3Hs4PkwnQ/v10ytOcapl8az8tbpVAy0KhgsIGgx79tLLUOT95Bk4HuGLWX+SZIWefO+uVg==
X-Received: by 2002:a17:906:4555:b0:a6f:523a:8e93 with SMTP id
 a640c23a62f3a-a6f60de2129mr165404166b.71.1718368480702; 
 Fri, 14 Jun 2024 05:34:40 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56f42badsm180661066b.184.2024.06.14.05.34.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jun 2024 05:34:40 -0700 (PDT)
Message-ID: <18b942c0-ffc9-48c6-aded-cd68fd54384a@linaro.org>
Date: Fri, 14 Jun 2024 14:34:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] target/arm: Make some MTE helpers widely available
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
References: <20240613172103.2987519-1-gustavo.romero@linaro.org>
 <20240613172103.2987519-6-gustavo.romero@linaro.org>
 <49457f87-2b07-4e62-98ee-893f57a3ca2a@linaro.org>
 <e1a79665-62c3-5511-b7ad-baf8e72a17b1@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e1a79665-62c3-5511-b7ad-baf8e72a17b1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 13/6/24 20:13, Gustavo Romero wrote:
> Hi Phil!
> 
> On 6/13/24 2:32 PM, Philippe Mathieu-Daudé wrote:
>> Hi Gustavo,
>>
>> On 13/6/24 19:20, Gustavo Romero wrote:
>>> Make the MTE helpers allocation_tag_mem_probe, load_tag1, and store_tag1
>>> available to other subsystems by moving them from mte_helper.c to a new
>>> header file, mte_helper.h.
>>>
>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>> ---
>>>   target/arm/tcg/mte_helper.c | 184 +------------------------------
>>>   target/arm/tcg/mte_helper.h | 211 ++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 212 insertions(+), 183 deletions(-)
>>>   create mode 100644 target/arm/tcg/mte_helper.h


>>> + */
>>> +
>>> +#ifndef TARGET_ARM_MTE_H
>>> +#define TARGET_ARM_MTE_H
>>> +
>>> +#include "exec/exec-all.h"
>>
>> Why do you need "exec/exec-all.h"?
> 
> Otherwise one gets:
> 
> In file included from ../target/arm/gdbstub.c:30:
> ../target/arm/tcg/mte_helper.h: In function ‘allocation_tag_mem_probe’:
> ../target/arm/tcg/mte_helper.h:77:9: error: implicit declaration of 
> function ‘cpu_loop_exit_sigsegv’; did you mean ‘cpu_loop_exit_noexc’? 
> [-Werror=implicit-function-declaration]
>     77 |         cpu_loop_exit_sigsegv(env_cpu(env), ptr, ptr_access,
>        |         ^~~~~~~~~~~~~~~~~~~~~
>        |         cpu_loop_exit_noexc
> ../target/arm/tcg/mte_helper.h:77:9: error: nested extern declaration of 
> ‘cpu_loop_exit_sigsegv’ [-Werror=nested-externs]
> 
> Any other idea on how to satisfy it?

OK, I'll fix once I get my include/exec/ rework merged.

>>> +#include "exec/ram_addr.h"
>>> +#include "hw/core/tcg-cpu-ops.h"
>>> +#include "qemu/log.h"
>>> +
>>> +/**
>>> + * allocation_tag_mem_probe:
>>> + * @env: the cpu environment
>>> + * @ptr_mmu_idx: the addressing regime to use for the virtual address
>>> + * @ptr: the virtual address for which to look up tag memory
>>> + * @ptr_access: the access to use for the virtual address
>>> + * @ptr_size: the number of bytes in the normal memory access
>>> + * @tag_access: the access to use for the tag memory
>>> + * @probe: true to merely probe, never taking an exception
>>> + * @ra: the return address for exception handling
>>> + *
>>> + * Our tag memory is formatted as a sequence of little-endian nibbles.
>>> + * That is, the byte at (addr >> (LOG2_TAG_GRANULE + 1)) contains two
>>> + * tags, with the tag at [3:0] for the lower addr and the tag at [7:4]
>>> + * for the higher addr.
>>> + *
>>> + * Here, resolve the physical address from the virtual address, and 
>>> return
>>> + * a pointer to the corresponding tag byte.
>>> + *
>>> + * If there is no tag storage corresponding to @ptr, return NULL.
>>> + *
>>> + * If the page is inaccessible for @ptr_access, or has a watchpoint, 
>>> there are
>>> + * three options:
>>> + * (1) probe = true, ra = 0 : pure probe -- we return NULL if the 
>>> page is not
>>> + *     accessible, and do not take watchpoint traps. The calling 
>>> code must
>>> + *     handle those cases in the right priority compared to MTE traps.
>>> + * (2) probe = false, ra = 0 : probe, no fault expected -- the 
>>> caller guarantees
>>> + *     that the page is going to be accessible. We will take 
>>> watchpoint traps.
>>> + * (3) probe = false, ra != 0 : non-probe -- we will take both 
>>> memory access
>>> + *     traps and watchpoint traps.
>>> + * (probe = true, ra != 0 is invalid and will assert.)
>>> + */
>>> +static inline uint8_t *allocation_tag_mem_probe(CPUARMState *env, 
>>> int ptr_mmu_idx,
>>> +                                         uint64_t ptr, MMUAccessType 
>>> ptr_access,
>>> +                                         int ptr_size, MMUAccessType 
>>> tag_access,
>>> +                                         bool probe, uintptr_t ra)
>>
>> Do we really need an inlined function? Since it calls non-inlined
>> methods, I don't really see the point.
> 
> inline is just a hint and I think that in general at least the overhead
> for calling this function is reduced, but it's hard to say what the
> compile heuristics will do exactly without looking at the compiled code.

My question is about having the function definition in an header,
instead of its prototype (and the definition in a .c source file).

> But I can remove it for this function and leave it just for 
> {load,store}_tag1.


