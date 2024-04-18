Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C48EC41513
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 17:56:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxVza-0003Zh-TC; Thu, 18 Apr 2024 13:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rxVzN-0003Di-Tj
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 13:56:03 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rxVzL-00008G-Rv
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 13:56:01 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6eff9dc1821so1277225b3a.3
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 10:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713462958; x=1714067758; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zP8ACuq92MAE7laorulBFiM3jlDYj94Ot2dOcGK0PyM=;
 b=ec4IDYGyJz6Sg3NgEzUeMUqqH7dR097Zf7o6it9jQFgt24rBuVp9EW9qxnLBH4kS/f
 oR60zjWnSARzywg12NPntvlefZMfJTebEVt8AuaZohJ6W102N1Hg5ZOFUvVDIKqrL2Zd
 fjzfYN5ZE+nbKlsdW+jUJ1daHZFEZVCuGTdPZV2H/zhcCUmAw5FPSi3jHZpSgA0tbKVt
 R+vm1qKX4X+ilwoQbSNp8Q5yoAE7/ptICosToE87H8oa7OMuu5R1MOcnrwy9H8lN5JyE
 Avj4xqwQM0MQgms/ZhnRM3N5c4GVES44lg6MInHQXiAkz9pTRTMFty1lkVW2NXLl8DXz
 41/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713462958; x=1714067758;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zP8ACuq92MAE7laorulBFiM3jlDYj94Ot2dOcGK0PyM=;
 b=bP+YUtRAGcZ+0FsLhsp+fHQbMfpgVOWE/Y34j/55pf4vC9PxG/jSmPBU9GHkBEvWXr
 jsmdaITbqhtOxaJi8kD7qaSjj/NkboHSs+WRVFSo05YzqLljpMP4c7h5XuvjJi0GMtnf
 RFr0chr3poAhpeOzLfeyo181xQpWZHoV3m9pTTH7f5kkwp222oA6V9z5N0NgpI9XAnQK
 4Gaf5t41NSw5NxNSlnqE8kauAOT9kMr6t3B2dzetDJ9xlSAvaypmZMo420AMVYQ7/UIc
 u2tg7DoLFpdVBb1F7k5V4QeY7WC/mJrbPvn5SKGA8ASZAeNUL2E1htnGFGClCwtIxs8O
 hJ0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr/XhJXcYhSTTZRNSz0yKl933UB0Cp0zLdEeCmz1PDAgu+RJJ8epfd3a7OwjFlQjIucn4rs7CiLDGAa99wU1UViecBKw4=
X-Gm-Message-State: AOJu0YwRPvv2f8CzLN+UzRD4ZIWM9/NG/Vn8PAgAnovpasWMZ5Z/XWuO
 MaV/XKWm5bH05i3Z5CqfRR6DOjVOjG94dOXjloORL1/v/5aHvfe2bb39mp88NoHUeA3wo72LW3G
 HxiE=
X-Google-Smtp-Source: AGHT+IE3MpPoVShC5JZSHqlEt74B2j0kgXKL7niLqouEt/LaamABgbJ2BGHXCbgT4iKkZlGv0uBqng==
X-Received: by 2002:a05:6a21:670b:b0:1aa:5993:88f7 with SMTP id
 wh11-20020a056a21670b00b001aa599388f7mr4308623pzb.3.1713462958202; 
 Thu, 18 Apr 2024 10:55:58 -0700 (PDT)
Received: from ?IPV6:2604:3d08:937d:c610::fc11? ([2604:3d08:937d:c610::fc11])
 by smtp.gmail.com with ESMTPSA id
 fn10-20020a056a002fca00b006e72c8ece23sm1758764pfb.191.2024.04.18.10.55.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 10:55:57 -0700 (PDT)
Message-ID: <4b3019cb-224a-4a3d-8630-02c1e338f30d@linaro.org>
Date: Thu, 18 Apr 2024 10:55:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] target/i386: Split out gdb-internal.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240416040609.1313605-1-richard.henderson@linaro.org>
 <20240416040609.1313605-6-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240416040609.1313605-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

On 4/15/24 21:06, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/i386/gdb-internal.h | 65 ++++++++++++++++++++++++++++++++++++++
>   target/i386/gdbstub.c      |  1 +
>   2 files changed, 66 insertions(+)
>   create mode 100644 target/i386/gdb-internal.h
> 
> diff --git a/target/i386/gdb-internal.h b/target/i386/gdb-internal.h
> new file mode 100644
> index 0000000000..7cf4c1a656
> --- /dev/null
> +++ b/target/i386/gdb-internal.h
> @@ -0,0 +1,65 @@
> +/*
> + * x86 gdb server stub
> + *
> + * Copyright (c) 2003-2005 Fabrice Bellard
> + * Copyright (c) 2013 SUSE LINUX Products GmbH
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#ifndef I386_GDB_INTERNAL_H
> +#define I386_GDB_INTERNAL_H
> +
> +/*
> + * Keep these in sync with assignment to
> + * gdb_num_core_regs in target/i386/cpu.c
> + * and with the machine description
> + */
> +
> +/*
> + * SEG: 6 segments, plus fs_base, gs_base, kernel_gs_base
> + */
> +
> +/*
> + * general regs ----->  8 or 16
> + */
> +#define IDX_NB_IP       1
> +#define IDX_NB_FLAGS    1
> +#define IDX_NB_SEG      (6 + 3)
> +#define IDX_NB_CTL      6
> +#define IDX_NB_FP       16
> +/*
> + * fpu regs ----------> 8 or 16
> + */
> +#define IDX_NB_MXCSR    1
> +/*
> + *          total ----> 8+1+1+9+6+16+8+1=50 or 16+1+1+9+6+16+16+1=66
> + */
> +
> +#define IDX_IP_REG      CPU_NB_REGS
> +#define IDX_FLAGS_REG   (IDX_IP_REG + IDX_NB_IP)
> +#define IDX_SEG_REGS    (IDX_FLAGS_REG + IDX_NB_FLAGS)
> +#define IDX_CTL_REGS    (IDX_SEG_REGS + IDX_NB_SEG)
> +#define IDX_FP_REGS     (IDX_CTL_REGS + IDX_NB_CTL)
> +#define IDX_XMM_REGS    (IDX_FP_REGS + IDX_NB_FP)
> +#define IDX_MXCSR_REG   (IDX_XMM_REGS + CPU_NB_REGS)
> +
> +#define IDX_CTL_CR0_REG     (IDX_CTL_REGS + 0)
> +#define IDX_CTL_CR2_REG     (IDX_CTL_REGS + 1)
> +#define IDX_CTL_CR3_REG     (IDX_CTL_REGS + 2)
> +#define IDX_CTL_CR4_REG     (IDX_CTL_REGS + 3)
> +#define IDX_CTL_CR8_REG     (IDX_CTL_REGS + 4)
> +#define IDX_CTL_EFER_REG    (IDX_CTL_REGS + 5)
> +
> +#endif
> diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
> index ebb000df6a..9662509b82 100644
> --- a/target/i386/gdbstub.c
> +++ b/target/i386/gdbstub.c
> @@ -20,6 +20,7 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "include/gdbstub/helpers.h"
> +#include "gdb-internal.h"
>   
>   #ifdef TARGET_X86_64
>   static const int gpr_map[16] = {

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

