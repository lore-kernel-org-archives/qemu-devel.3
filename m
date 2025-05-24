Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6756C54F30
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 17:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIsLo-0007rq-Ty; Sat, 24 May 2025 13:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIsLn-0007rh-0r
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:07:59 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIsLl-0005TN-1t
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:07:58 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-442fda876a6so8077475e9.0
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 10:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748106475; x=1748711275; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CAkkoH0ZnZXtPEYSoJyrpulEYL7OphM9mDb67uMZDJ4=;
 b=vvfhMo88d+gwcTAmZtAFvvxk+wzRxlC1R4M2EBM8FbtHyqWiqKVo1678E2qg8KTovg
 Eu5sQeCF5fZNxLGPJgzI4WQxHAy+oxPgHEYYsqK7T1m4dmGEyQtHzp5Xho1m1booKpax
 mr4BmQw2ZbJkB+NB6S+oqcCLnma/m+TVKuJN6xbKQLtqVGjkGAWoYAzZYLcz1Sy3rYjs
 VuVE/ESFbQuweUMwQDqKwhh6X5SZ4pIOZ/K2SP6ngs+n5L04TTygbeAUTb1BZs+kKlZW
 FIOFLLrz+ZL0fVx+7lKEsDWEixrVe/BL2rgzMmM3uQQD0ZriNhn51T6a7Itb5/ciuBEf
 mdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748106475; x=1748711275;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CAkkoH0ZnZXtPEYSoJyrpulEYL7OphM9mDb67uMZDJ4=;
 b=Ou+oSgDF754ZtJ9U+Rz/W7DBxU/5Yc5mLBNAOY05RApQgRCdwwTV8pDMYP2rSnwYDt
 aWHOowcU2x/x6fAF5BEu8WIjzwmgpDqNdp4vfXnC8yu8RpGYUAm0EzNd5e+dmUAigi9V
 7YDV0jHpMC0rlUWvUgp89/65JGQgjUKS69pkDh3mPlddycII3h4K5Qo+SmYMOfzGX74r
 CAAp513GgXdZbo4rPVxAXF0BNsmFZEnnzJ5skD6ZiAUnPhIFX/6DanwIQ0OkiUP4Uqs9
 mBLe7rr369fhN9erV2PtYn1SXJPY1236oGcnRK2NcO3UaIsMoTCxQpclY5mhHrbh21mR
 a4dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRwme7HLaWalhph2rptod2kdsTNhVln0F2UPoFEhRRNu18Ojd8wun4b3hZg3zg/dw0kWc0Aq7qr+gu@nongnu.org
X-Gm-Message-State: AOJu0YzHBvwN0G1bYhHGDZp+UxfRzmCvNBjoCMg35iTi2TfWv7W73m2A
 9y5UI3WupjuR3wgkwIq6cITaZn3NcrnhgKmr+tA9DNYJyxGzvR6vFIQKAY43Tj7ptjU=
X-Gm-Gg: ASbGncv/DAR5xkSv37x/pSoHdPf63XNA9u0cBmAj2lC05pixN7Gyjc/frQXwtOSenwR
 3KNYueEQmhJ3QQX9TxYSLckzmGoztm5R6ulAx0yjhKo7tyIJS37Ff55OVIxB3D/Nc3W1/gstDwm
 oThW8q9qwAIDG6+Vj/mzhQS5SLmXU49SIX/TgMXereUTPjGon1D6rKt5P4rt5iBGulE1VSyZVxy
 qggZo0/gKLxcczAzSjV5hxpfnPfCQTyLoBkCV+waGnYrIshNvsphuK2UWkiT3r3BGw5hHhrryx5
 8v+Wh4O3IPlNqtaLaPacq2YAsPll0s49CzaV0Lj3bRWpl4u8BniGgXpgxgnbq899jg==
X-Google-Smtp-Source: AGHT+IH8nplpeKVAZinYGY7sJhG4R70BialpWNttVFDYPPQ1FSoBXajbkdFIF/xBvp/uHsu+y6pVYw==
X-Received: by 2002:a05:6000:2389:b0:3a4:d238:682b with SMTP id
 ffacd0b85a97d-3a4d2386cbamr513690f8f.51.1748106475433; 
 Sat, 24 May 2025 10:07:55 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f3814297sm178812385e9.28.2025.05.24.10.07.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 May 2025 10:07:54 -0700 (PDT)
Message-ID: <54ddae99-e399-465d-ac9e-7f01ed26207f@linaro.org>
Date: Sat, 24 May 2025 18:07:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/25] target/hppa: call plugin trap callbacks
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <cover.1747666625.git.neither@nut.email>
 <62a954b31818763a2f3e0806fb9c912f6dd44972.1747666625.git.neither@nut.email>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <62a954b31818763a2f3e0806fb9c912f6dd44972.1747666625.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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

On 5/19/25 16:19, Julian Ganz wrote:
> We identified a number of exceptions as interrupts, and we assume any
> unknown exception is also an interrupt. HPPA appears to not have any
> form of host-call.
> 
> This change places the hook for PA-RISC targets.
> 
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>   target/hppa/int_helper.c | 44 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 44 insertions(+)
> 
> diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
> index 7d48643bb6..e9325319a7 100644
> --- a/target/hppa/int_helper.c
> +++ b/target/hppa/int_helper.c
> @@ -24,6 +24,7 @@
>   #include "exec/helper-proto.h"
>   #include "hw/core/cpu.h"
>   #include "hw/hppa/hppa_hardware.h"
> +#include "qemu/plugin.h"
>   
>   static void eval_interrupt(HPPACPU *cpu)
>   {
> @@ -95,6 +96,7 @@ void hppa_cpu_do_interrupt(CPUState *cs)
>       CPUHPPAState *env = &cpu->env;
>       int i = cs->exception_index;
>       uint64_t old_psw, old_gva_offset_mask;
> +    uint64_t last_pc = cs->cc->get_pc(cs);
>   
>       /* As documented in pa2.0 -- interruption handling.  */
>       /* step 1 */
> @@ -208,6 +210,48 @@ void hppa_cpu_do_interrupt(CPUState *cs)
>       env->iasq_f = 0;
>       env->iasq_b = 0;
>   
> +    switch (i) {
> +    case EXCP_HPMC:
> +    case EXCP_POWER_FAIL:
> +    case EXCP_RC:
> +    case EXCP_EXT_INTERRUPT:
> +    case EXCP_LPMC:
> +    case EXCP_PER_INTERRUPT:
> +    case EXCP_TOC:
> +        qemu_plugin_vcpu_exception_cb(cs, last_pc);

Interrupts.  Why are these separate from default:?

r~

> +        break;
> +    case EXCP_ITLB_MISS:
> +    case EXCP_IMP:
> +    case EXCP_ILL:
> +    case EXCP_BREAK:
> +    case EXCP_PRIV_OPR:
> +    case EXCP_PRIV_REG:
> +    case EXCP_OVERFLOW:
> +    case EXCP_COND:
> +    case EXCP_ASSIST:
> +    case EXCP_DTLB_MISS:
> +    case EXCP_NA_ITLB_MISS:
> +    case EXCP_NA_DTLB_MISS:
> +    case EXCP_DMP:
> +    case EXCP_DMB:
> +    case EXCP_TLB_DIRTY:
> +    case EXCP_PAGE_REF:
> +    case EXCP_ASSIST_EMU:
> +    case EXCP_HPT:
> +    case EXCP_LPT:
> +    case EXCP_TB:
> +    case EXCP_DMAR:
> +    case EXCP_DMPI:
> +    case EXCP_UNALIGN:
> +    case EXCP_SYSCALL:
> +    case EXCP_SYSCALL_LWS:
> +        qemu_plugin_vcpu_exception_cb(cs, last_pc);
> +        break;
> +    default:
> +        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
> +        break;
> +    }
> +
>       if (qemu_loglevel_mask(CPU_LOG_INT)) {
>           static const char * const names[] = {
>               [EXCP_HPMC]          = "high priority machine check",


