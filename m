Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5E1C28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqd7H-00066G-VP; Fri, 07 Mar 2025 14:12:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd75-0005pw-VG
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:12:10 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqd73-000605-Tv
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:12:03 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-223594b3c6dso42005795ad.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741374720; x=1741979520; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pO31XiD3H9Op276gmvECOc5hjBFZk+ESYZCRPkxTRlQ=;
 b=vHbCraLQ4oHzT4TbMjvOdBh+9rESeRDPjtNoC9V9p9+ZlIfEhhCvlemXNxvECQR4g4
 Fgj7lHIt6GaNFr5EqSj2QQpjuG3pHxJYZ0q1qVH3ZJiCgRB+cHtn2R9I4gcRhHfu7NJe
 GuZbWFRCV0c7PK4gJGrzIlLbbfvvhvMnBFxfxlX6bTHNUo5s/iOb2IfGKgesXdunVS8w
 fMvEKstroNl/ObSfG2Twl/NN4BwUfCkkhEiRDV4skp8mJA9rPRszj+g12xXQu5RYwR5y
 uwoIYvY2XpHTWsa8F35GIkmhWya9XrugAk6qXVjI7oST3PJKa0GQCNjmv9ti+ySMdiY2
 56hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741374720; x=1741979520;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pO31XiD3H9Op276gmvECOc5hjBFZk+ESYZCRPkxTRlQ=;
 b=lXYL1FVrvGgPPz8rrdSoQ7eouCpeqZX/ennnlIV/VmpUxZt7E/m0682rktVxjCkq3N
 OQKjuwb9tm9M6klp0LAxMlTEQ93OPYXi8ZzPTpE5Z6X8Xm0KoQgMTXdxqofjWmMZ9xP+
 TFJbf8pmrlwY678N2MfblDm72HOj4kKRtVEsoG/eXit22xWxyvja4mY72Qh9Ue5nvjwj
 18Gu3qGHQKKscz9BFOaTPawE4kI4+VHJLXB7lmyfu3pFZ53/p5xotfVyEvAWMoLwMWSH
 lW3cX2r3oj+FeLuqSYUWT4TgFdKTsnz7PDpLakcQA04mHYOsbjfA2xT39/vUrgStxBQ2
 CI6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9sJN5Y0TleFjnLDMiJwAd4jTzDcYpXns6nJIedD28WPHutW6BQmoCzM5Q8FsAqnWMc3hzs6NI+4gM@nongnu.org
X-Gm-Message-State: AOJu0YwRVa6PO5IFQxbukTfSiIhFlUooiUkxIBTo6UIvlBNBDhcpS0iP
 2FOgWUbBZbDZjuhRJFzXFXrYlo/3X0NcVHoQzdVdAcX9CtZlCkdHQdB8s0uaE98=
X-Gm-Gg: ASbGnctuZ7YVW4sX39UnjNANjCv+kRUNp2qgNNXYBPFYJyTFe4NEPDL2wttsGDe44KT
 bcjRX469LY/12/0p7lur+u60KjdKaX31JdmVfMxOOfoll86z3xsgSq5HHu5Te8yzJGP/BBGJNw9
 gyrb6zn8Yw1Ws6zDU7YCNmd6ZzTATNrd8odTp0n8GRYhxsskzkW75Dqdkk+eGNeA8xlHoeuLSMz
 DvK0sJJqeNzAN7tUq4nqCuKzM8PBbxnw3oZd6Mz5tIthw+ghNTRBnmqBn4LskAiCV+6ToBZ2g36
 I62fw1W8P8gwWXR8c5IRzO0LzfT3PTn0UtO7dckTysPIhmMtvbrUQoMIXA==
X-Google-Smtp-Source: AGHT+IGVUrnDVPENMOVvIKfP07rxSD/8iHbWa0HaZiz+5HQ+7tEWSLyAEQQjsblmF9s0JsPcS6QPTA==
X-Received: by 2002:a05:6a00:c95:b0:725:96f2:9e63 with SMTP id
 d2e1a72fcca58-736aab16545mr8529817b3a.24.1741374720336; 
 Fri, 07 Mar 2025 11:12:00 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736abe02bdasm1926596b3a.31.2025.03.07.11.11.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:11:59 -0800 (PST)
Message-ID: <5884d2cc-12b6-41d3-b1e8-77d0d2e79059@linaro.org>
Date: Fri, 7 Mar 2025 11:11:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] include/exec: Split out exec/cpu-interrupt.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250307185645.970034-1-richard.henderson@linaro.org>
 <20250307185645.970034-3-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250307185645.970034-3-richard.henderson@linaro.org>
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

On 3/7/25 10:56, Richard Henderson wrote:
> Some of these bits are actually common to all cpus; while the
> reset have common reservations for target-specific usage.
> While generic code cannot know what the target-specific usage is,
> common code can know what to do with the bits, e.g. single-step.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu-all.h       | 53 +--------------------------
>   include/exec/cpu-interrupt.h | 70 ++++++++++++++++++++++++++++++++++++
>   include/exec/poison.h        | 13 -------
>   3 files changed, 71 insertions(+), 65 deletions(-)
>   create mode 100644 include/exec/cpu-interrupt.h
> 
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 8f7aebb088..9e6724097c 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -21,6 +21,7 @@
>   
>   #include "exec/page-protection.h"
>   #include "exec/cpu-common.h"
> +#include "exec/cpu-interrupt.h"
>   #include "exec/memory.h"
>   #include "exec/tswap.h"
>   #include "hw/core/cpu.h"
> @@ -109,58 +110,6 @@ static inline void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val
>   
>   CPUArchState *cpu_copy(CPUArchState *env);
>   
> -/* Flags for use in ENV->INTERRUPT_PENDING.
> -
> -   The numbers assigned here are non-sequential in order to preserve
> -   binary compatibility with the vmstate dump.  Bit 0 (0x0001) was
> -   previously used for CPU_INTERRUPT_EXIT, and is cleared when loading
> -   the vmstate dump.  */
> -
> -/* External hardware interrupt pending.  This is typically used for
> -   interrupts from devices.  */
> -#define CPU_INTERRUPT_HARD        0x0002
> -
> -/* Exit the current TB.  This is typically used when some system-level device
> -   makes some change to the memory mapping.  E.g. the a20 line change.  */
> -#define CPU_INTERRUPT_EXITTB      0x0004
> -
> -/* Halt the CPU.  */
> -#define CPU_INTERRUPT_HALT        0x0020
> -
> -/* Debug event pending.  */
> -#define CPU_INTERRUPT_DEBUG       0x0080
> -
> -/* Reset signal.  */
> -#define CPU_INTERRUPT_RESET       0x0400
> -
> -/* Several target-specific external hardware interrupts.  Each target/cpu.h
> -   should define proper names based on these defines.  */
> -#define CPU_INTERRUPT_TGT_EXT_0   0x0008
> -#define CPU_INTERRUPT_TGT_EXT_1   0x0010
> -#define CPU_INTERRUPT_TGT_EXT_2   0x0040
> -#define CPU_INTERRUPT_TGT_EXT_3   0x0200
> -#define CPU_INTERRUPT_TGT_EXT_4   0x1000
> -
> -/* Several target-specific internal interrupts.  These differ from the
> -   preceding target-specific interrupts in that they are intended to
> -   originate from within the cpu itself, typically in response to some
> -   instruction being executed.  These, therefore, are not masked while
> -   single-stepping within the debugger.  */
> -#define CPU_INTERRUPT_TGT_INT_0   0x0100
> -#define CPU_INTERRUPT_TGT_INT_1   0x0800
> -#define CPU_INTERRUPT_TGT_INT_2   0x2000
> -
> -/* First unused bit: 0x4000.  */
> -
> -/* The set of all bits that should be masked when single-stepping.  */
> -#define CPU_INTERRUPT_SSTEP_MASK \
> -    (CPU_INTERRUPT_HARD          \
> -     | CPU_INTERRUPT_TGT_EXT_0   \
> -     | CPU_INTERRUPT_TGT_EXT_1   \
> -     | CPU_INTERRUPT_TGT_EXT_2   \
> -     | CPU_INTERRUPT_TGT_EXT_3   \
> -     | CPU_INTERRUPT_TGT_EXT_4)
> -
>   #include "cpu.h"
>   
>   #ifdef CONFIG_USER_ONLY
> diff --git a/include/exec/cpu-interrupt.h b/include/exec/cpu-interrupt.h
> new file mode 100644
> index 0000000000..40715193ca
> --- /dev/null
> +++ b/include/exec/cpu-interrupt.h
> @@ -0,0 +1,70 @@
> +/*
> + * Flags for use with cpu_interrupt()
> + *
> + * Copyright (c) 2003 Fabrice Bellard
> + * SPDX-License-Identifier: LGPL-2.1-or-later
> + */
> +
> +#ifndef CPU_INTERRUPT_H
> +#define CPU_INTERRUPT_H
> +
> +/*
> + * The numbers assigned here are non-sequential in order to preserve binary
> + * compatibility with the vmstate dump.  Bit 0 (0x0001) was previously used
> + * for CPU_INTERRUPT_EXIT, and is cleared when loading the vmstate dump.
> + */
> +
> +/*
> + * External hardware interrupt pending.
> + * This is typically used for interrupts from devices.
> + */
> +#define CPU_INTERRUPT_HARD        0x0002
> +
> +/*
> + * Exit the current TB.  This is typically used when some system-level device
> + * makes some change to the memory mapping.  E.g. the a20 line change.
> + */
> +#define CPU_INTERRUPT_EXITTB      0x0004
> +
> +/* Halt the CPU.  */
> +#define CPU_INTERRUPT_HALT        0x0020
> +
> +/* Debug event pending.  */
> +#define CPU_INTERRUPT_DEBUG       0x0080
> +
> +/* Reset signal.  */
> +#define CPU_INTERRUPT_RESET       0x0400
> +
> +/*
> + * Several target-specific external hardware interrupts.  Each target/cpu.h
> + * should define proper names based on these defines.
> + */
> +#define CPU_INTERRUPT_TGT_EXT_0   0x0008
> +#define CPU_INTERRUPT_TGT_EXT_1   0x0010
> +#define CPU_INTERRUPT_TGT_EXT_2   0x0040
> +#define CPU_INTERRUPT_TGT_EXT_3   0x0200
> +#define CPU_INTERRUPT_TGT_EXT_4   0x1000
> +
> +/*
> + * Several target-specific internal interrupts.  These differ from the
> + * preceding target-specific interrupts in that they are intended to
> + * originate from within the cpu itself, typically in response to some
> + * instruction being executed.  These, therefore, are not masked while
> + * single-stepping within the debugger.
> + */
> +#define CPU_INTERRUPT_TGT_INT_0   0x0100
> +#define CPU_INTERRUPT_TGT_INT_1   0x0800
> +#define CPU_INTERRUPT_TGT_INT_2   0x2000
> +
> +/* First unused bit: 0x4000.  */
> +
> +/* The set of all bits that should be masked when single-stepping.  */
> +#define CPU_INTERRUPT_SSTEP_MASK \
> +    (CPU_INTERRUPT_HARD          \
> +     | CPU_INTERRUPT_TGT_EXT_0   \
> +     | CPU_INTERRUPT_TGT_EXT_1   \
> +     | CPU_INTERRUPT_TGT_EXT_2   \
> +     | CPU_INTERRUPT_TGT_EXT_3   \
> +     | CPU_INTERRUPT_TGT_EXT_4)
> +
> +#endif /* CPU_INTERRUPT_H */
> diff --git a/include/exec/poison.h b/include/exec/poison.h
> index 35721366d7..8ed04b3108 100644
> --- a/include/exec/poison.h
> +++ b/include/exec/poison.h
> @@ -46,19 +46,6 @@
>   
>   #pragma GCC poison TARGET_PHYS_ADDR_SPACE_BITS
>   
> -#pragma GCC poison CPU_INTERRUPT_HARD
> -#pragma GCC poison CPU_INTERRUPT_EXITTB
> -#pragma GCC poison CPU_INTERRUPT_HALT
> -#pragma GCC poison CPU_INTERRUPT_DEBUG
> -#pragma GCC poison CPU_INTERRUPT_TGT_EXT_0
> -#pragma GCC poison CPU_INTERRUPT_TGT_EXT_1
> -#pragma GCC poison CPU_INTERRUPT_TGT_EXT_2
> -#pragma GCC poison CPU_INTERRUPT_TGT_EXT_3
> -#pragma GCC poison CPU_INTERRUPT_TGT_EXT_4
> -#pragma GCC poison CPU_INTERRUPT_TGT_INT_0
> -#pragma GCC poison CPU_INTERRUPT_TGT_INT_1
> -#pragma GCC poison CPU_INTERRUPT_TGT_INT_2
> -
>   #pragma GCC poison CONFIG_ALPHA_DIS
>   #pragma GCC poison CONFIG_HPPA_DIS
>   #pragma GCC poison CONFIG_I386_DIS

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


