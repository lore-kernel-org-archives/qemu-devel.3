Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D379D29C36
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 14:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhqWM-0007Bh-EM; Mon, 19 Jan 2026 09:46:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhqWK-0007BP-TX
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 09:46:21 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhqWI-0007bU-Sg
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 09:46:20 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4801c731d0aso24791165e9.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 06:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768833976; x=1769438776; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zBM34GMMd9Vu9jJ0AiZ+ilph2E5Sjgaso0FAsgPlhPY=;
 b=pUG6hOUfSyk9DjMTmgf4eEnPr9zyNW+sSaxHEMBPJ0yFTJtalBKFg9ybk5oklkqDW0
 arPH35PtQVMVkKpZhWl71VhDgcL29lWl7f92BjvRn/SJm+ZZfyJHuJ1imwx3Uj2LpgNc
 SdJdEpJm37TSCJSXc8Nqyd8Qk9QYxe6zVUJLSjj6gM6P2MzzAzbJd8xoXeJmliOM81RU
 nLny9nto5eFOpF2Zuy+6V5+Ias6cpYmEiZnYUq40zs3OygJSbbQtmPq8BTV8ERwGAHA7
 A3/jxGDw9r5wGIXavt0E+DcYiCtFMs3TW5DLNQPHa2y/AZmW86pF1svdqnw3zoK+onSk
 0HtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768833976; x=1769438776;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zBM34GMMd9Vu9jJ0AiZ+ilph2E5Sjgaso0FAsgPlhPY=;
 b=M0QtjzPiwqhltGPhY3HI9cBvhv/h2Ly3xjD6wwW1Rona+U/fsoIa8cM06eyhJkQa05
 XMFMUxoDsXb8PLBhDuCZO/UVqauyMZYqpf0DmUhS/lnWwVtFB2RM7spbRLDEC8GYMi7k
 j3B6V/cWwPl/lIMja91ZRU+C8Hk9q4Fx4Z8XqtndwoEbwgEeOpkdjGEfahIalGE6BoyA
 g/9S0w/t1vBgKTUudzGKI+q2DgI+3Jfdzr25EZ6/mCiJpYGznE6ZnSZan4ZSJFMTqbn1
 GBKvR/2FXG9VP8/+APmfWk/ORWJMB7ZNPECfbRVvkIHZKXCyCxeJFxdQMpPJxY8Mtso5
 9zGQ==
X-Gm-Message-State: AOJu0YzhG/6yzcymvYuKAqo1k4M5GI4NIPBeJUNQkq1R5ZVW+Lu/DmSf
 DOW28WTTkPV7t015FCIRDnpQ0lvfoc94dtrrDuKUL1kbMLHdpPJeHyaOOuVMjUZ41sbhXed8wwQ
 FqM4j8S8=
X-Gm-Gg: AY/fxX4B/YBqaK8inC/LxOe7enz1OWI8iT8nIP1LsdsL7ZgPIAFW3mSS04PPVm/FVa9
 Xosifg/XRkGwv4mlxot+4/pQRqX9BNY9kK4bi5UWXnvC3Zt30MKIgYOkJOlgivBK3THzTLvMrtT
 0lBF2WehxtFTUUYfOf0TPLEHCWLeVYQwEGdaOtkP5wrILXeHKa+srIvSzJaJoe10cJ6fMSeTOZt
 hTHBwqnCK1swn0h69KwILX30cpYN23GVwvZNaGw+I2tMzQx1mIM3MHGO1RcAao9cfHhFKfi94h0
 5nt7puTI8Y16mFVu9FNNzPOBScwOLYNuQrxMsfqoRVUIR8hr9EpKmvBGwkjX4U1gMv0kEAocTsl
 U8O/8+JsSedn+KGQC9Yy3gXCINS2bJvuCkGbQ8yZ3DsO7PASOmtN+hV1gbdPBNBi+UScdmN5AcK
 bzIUBNsgCYmw/PFb/o+rIeieHawQhGaE2RWctShqRxsxSluyrQtwufbQ==
X-Received: by 2002:a05:600c:1f12:b0:47e:e9c9:23bc with SMTP id
 5b1f17b1804b1-4801e34ce8emr136304785e9.30.1768833975670; 
 Mon, 19 Jan 2026 06:46:15 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435699980e5sm23628565f8f.41.2026.01.19.06.46.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 06:46:15 -0800 (PST)
Message-ID: <17bbdd07-bc29-4e28-a8b2-7df611cfa231@linaro.org>
Date: Mon, 19 Jan 2026 15:46:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] monitor: Remove 'monitor/hmp-target.h' header
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260119110358.66821-1-philmd@linaro.org>
 <20260119110358.66821-9-philmd@linaro.org>
In-Reply-To: <20260119110358.66821-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 19/1/26 12:03, Philippe Mathieu-Daudé wrote:
> The "monitor/hmp-target.h" header doesn't contain any
> target-specific declarations anymore. Merge it with
> "monitor/hmp.h", its target-agnostic counterpart.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>   MAINTAINERS                   |  2 +-
>   include/monitor/hmp-target.h  | 60 -----------------------------------
>   include/monitor/hmp.h         | 31 ++++++++++++++++++
>   hw/i386/sgx-stub.c            |  2 +-
>   hw/i386/sgx.c                 |  1 -
>   monitor/hmp-cmds.c            |  1 -
>   monitor/hmp-target.c          |  1 -
>   monitor/hmp.c                 |  1 -
>   stubs/target-monitor-defs.c   |  2 +-
>   target/i386/cpu-apic.c        |  2 +-
>   target/i386/monitor.c         |  1 -
>   target/i386/sev-system-stub.c |  2 +-
>   target/i386/sev.c             |  1 -
>   target/m68k/monitor.c         |  2 +-
>   target/ppc/ppc-qmp-cmds.c     |  1 -
>   target/riscv/monitor.c        |  2 +-
>   target/riscv/riscv-qmp-cmds.c |  1 -
>   target/sh4/monitor.c          |  1 -
>   target/sparc/monitor.c        |  1 -
>   target/xtensa/monitor.c       |  1 -
>   20 files changed, 38 insertions(+), 78 deletions(-)
>   delete mode 100644 include/monitor/hmp-target.h


> diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
> deleted file mode 100644
> index c56f8df505c..00000000000
> --- a/include/monitor/hmp-target.h
> +++ /dev/null
> @@ -1,60 +0,0 @@
> -/*
> - * QEMU monitor
> - *
> - * Copyright (c) 2003-2004 Fabrice Bellard
> - *
> - * Permission is hereby granted, free of charge, to any person obtaining a copy
> - * of this software and associated documentation files (the "Software"), to deal
> - * in the Software without restriction, including without limitation the rights
> - * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> - * copies of the Software, and to permit persons to whom the Software is
> - * furnished to do so, subject to the following conditions:
> - *
> - * The above copyright notice and this permission notice shall be included in
> - * all copies or substantial portions of the Software.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> - * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> - * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> - * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> - * THE SOFTWARE.
> - */
> -
> -#ifndef MONITOR_HMP_TARGET_H
> -#define MONITOR_HMP_TARGET_H
> -
> -typedef struct MonitorDef MonitorDef;
> -
> -struct MonitorDef {
> -    const char *name;
> -    int offset;
> -    uint64_t (*get_value)(Monitor *mon, const struct MonitorDef *md, int val);
> -    int type;
> -};
> -
> -#define MD_TULONG 0
> -#define MD_U32    1
> -
> -const MonitorDef *target_monitor_defs(void);
> -int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
> -
> -CPUArchState *mon_get_cpu_env(Monitor *mon);
> -CPUState *mon_get_cpu(Monitor *mon);
> -
> -void hmp_info_mem(Monitor *mon, const QDict *qdict);
> -void hmp_info_tlb(Monitor *mon, const QDict *qdict);
> -void hmp_mce(Monitor *mon, const QDict *qdict);
> -void hmp_info_local_apic(Monitor *mon, const QDict *qdict);
> -void hmp_info_sev(Monitor *mon, const QDict *qdict);
> -void hmp_info_sgx(Monitor *mon, const QDict *qdict);
> -void hmp_info_via(Monitor *mon, const QDict *qdict);
> -void hmp_memory_dump(Monitor *mon, const QDict *qdict);
> -void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict);
> -void hmp_info_registers(Monitor *mon, const QDict *qdict);
> -void hmp_gva2gpa(Monitor *mon, const QDict *qdict);
> -void hmp_gpa2hva(Monitor *mon, const QDict *qdict);
> -void hmp_gpa2hpa(Monitor *mon, const QDict *qdict);
> -
> -#endif /* MONITOR_HMP_TARGET_H */
> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> index 83721b5ffc6..9d70a7b78ad 100644
> --- a/include/monitor/hmp.h
> +++ b/include/monitor/hmp.h
> @@ -17,6 +17,37 @@
>   #include "qemu/readline.h"
>   #include "qapi/qapi-types-common.h"
>   
> +typedef struct MonitorDef {
> +    const char *name;
> +    int offset;
> +    uint64_t (*get_value)(Monitor *mon, const struct MonitorDef *md, int val);
> +    int type;
> +} MonitorDef;
> +
> +#define MD_TULONG 0
> +#define MD_U32    1
> +
> +const MonitorDef *target_monitor_defs(void);
> +
> +int target_get_monitor_def(CPUState *cs, const char *name, uint64_t *pval);
> +
> +CPUArchState *mon_get_cpu_env(Monitor *mon);
> +CPUState *mon_get_cpu(Monitor *mon);
> +
> +void hmp_info_mem(Monitor *mon, const QDict *qdict);
> +void hmp_info_tlb(Monitor *mon, const QDict *qdict);
> +void hmp_mce(Monitor *mon, const QDict *qdict);
> +void hmp_info_local_apic(Monitor *mon, const QDict *qdict);
> +void hmp_info_sev(Monitor *mon, const QDict *qdict);
> +void hmp_info_sgx(Monitor *mon, const QDict *qdict);
> +void hmp_info_via(Monitor *mon, const QDict *qdict);
> +void hmp_memory_dump(Monitor *mon, const QDict *qdict);
> +void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict);
> +void hmp_info_registers(Monitor *mon, const QDict *qdict);
> +void hmp_gva2gpa(Monitor *mon, const QDict *qdict);
> +void hmp_gpa2hva(Monitor *mon, const QDict *qdict);
> +void hmp_gpa2hpa(Monitor *mon, const QDict *qdict);

Eh build failure on MinGW, I suppose yet another preliminary
header cleanup is required:

In file included from ../hw/misc/mos6522.c:33:
include/monitor/hmp.h:43:6: error: redundant redeclaration of 
'hmp_info_via' [-Werror=redundant-decls]
    43 | void hmp_info_via(Monitor *mon, const QDict *qdict);
       |      ^~~~~~~~~~~~
In file included from ../hw/misc/mos6522.c:29:
include/hw/misc/mos6522.h:175:6: note: previous declaration of 
'hmp_info_via' with type 'void(Monitor *, const QDict *)'
   175 | void hmp_info_via(Monitor *mon, const QDict *qdict);
       |      ^~~~~~~~~~~~
cc1: note: unrecognized command-line option '-Wno-pragma-pack' may have 
been intended to silence earlier diagnostics
cc1: all warnings being treated as errors


