Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B94CFA460
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 19:13:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3gmc-0002LV-Sh; Wed, 23 Oct 2024 15:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3gmZ-0002Jv-C1
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 15:12:35 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t3gmW-00061v-Js
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 15:12:33 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20cb47387ceso656545ad.1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 12:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729710750; x=1730315550; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AKWk2ERymspw2FFqHKhwS1lnrhg1C+G+WeIETZ1rcZ8=;
 b=LZmKdaAoXK0gyFraVvEU5hTdbpILArh9CL4+/bSRzJXwLUL/LFrl+hcW5UpW7ITjdy
 Op8UE0SIY7SRg0TFraqjgF05g2GZJs3T3BR3t8sHPdxXxt2gD9hiBjYXuAz8VADBGTl9
 FHDM5pbE6ejeTrbF/XVCfwPiW92L06q7NsqNmpIcRLcWi54YRz3ShJaP7ZNYBjpkgkfq
 7ZF2JpaYYDwEefvUPFNMHRgpV8mllztJLbxhsOzdgUYu6PI8powUnc244Y1psiVJ6ixn
 E6pE37tL8FNna4mF6aY+xvcJiYc8u7loihiqIo5bv5IV+Pob9aFK6Ovtz3xBaprv2kv2
 7iMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729710750; x=1730315550;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AKWk2ERymspw2FFqHKhwS1lnrhg1C+G+WeIETZ1rcZ8=;
 b=M1EAzppMjVrjGdIbrjRYLOAjnuKDaZoNqif/oF+U0GKyuMVLvZ+PyC1Ei4ylGJ1+0A
 OGbe+t2A/5AbO7e8E9V9Cgm8GzJyUoujMiCkp6nGeL3oJNvZ5dh09RXEPOIWVe8uf1CV
 cJu6toy71DNEfAbnqEZam+CwlT/YcBnZgddu0FgZZ9h1w0xydvw9QHiic8pOeOl6kuT0
 bp2Q5wwf5FCzYDaBqTOQWq1+zQQm0CIIbqOdqzZzmYdpOww+yIu+RZsaSUn1wwxzeojj
 X+StP4wxKED24PL7S6+SKwcEFX5mW6Pj81CPqsLte1HOOtXUAagnBUpLUniQY8k88CbE
 sgBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjUykHo5qlxCuQ+3MnhfAcfLPoyPnTzGFJybdxll9U8FH/hSm62hvncDEtYR6M0h4diGnvpLhQ2yk3@nongnu.org
X-Gm-Message-State: AOJu0YxHX/as6B6LVaTRAyXBeYg3paedREl0W0qZLuIDJ767tq8wE13+
 h3eI5gnvtAIQyeDYwkSnynZg3XbOM32jZfh3YcKqEqCw6bTmR6PwlMHiK46DOm4=
X-Google-Smtp-Source: AGHT+IEabvK/ItouvLUAp9ZsYvch8GvIDmdv+WSoNbouyrOnpclbDtw04Pv7YG9c7VVt1nOhdJyaLQ==
X-Received: by 2002:a17:902:d4c9:b0:20c:c1bc:2253 with SMTP id
 d9443c01a7336-20fa9e6e995mr52842245ad.32.1729710750656; 
 Wed, 23 Oct 2024 12:12:30 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7eaeabb840dsm7122383a12.62.2024.10.23.12.12.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 12:12:30 -0700 (PDT)
Message-ID: <6c6768a9-2b0a-4480-8236-14aa2f67fd1f@linaro.org>
Date: Wed, 23 Oct 2024 12:12:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hvf: remove unused but set variable
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 alex.bennee@linaro.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Cameron Esfahani <dirty@apple.com>
References: <20241023182922.1040964-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241023182922.1040964-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 10/23/24 11:29, Pierrick Bouvier wrote:
> fixes associated warning when building on MacOS.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/i386/hvf/x86_task.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
> 
> diff --git a/target/i386/hvf/x86_task.c b/target/i386/hvf/x86_task.c
> index f09bfbdda5b..cdea2ea69d9 100644
> --- a/target/i386/hvf/x86_task.c
> +++ b/target/i386/hvf/x86_task.c
> @@ -122,7 +122,6 @@ void vmx_handle_task_switch(CPUState *cpu, x68_segment_selector tss_sel, int rea
>       load_regs(cpu);
>   
>       struct x86_segment_descriptor curr_tss_desc, next_tss_desc;
> -    int ret;
>       x68_segment_selector old_tss_sel = vmx_read_segment_selector(cpu, R_TR);
>       uint64_t old_tss_base = vmx_read_segment_base(cpu, R_TR);
>       uint32_t desc_limit;
> @@ -138,7 +137,7 @@ void vmx_handle_task_switch(CPUState *cpu, x68_segment_selector tss_sel, int rea
>       if (reason == TSR_IDT_GATE && gate_valid) {
>           int dpl;
>   
> -        ret = x86_read_call_gate(cpu, &task_gate_desc, gate);
> +        x86_read_call_gate(cpu, &task_gate_desc, gate);
>   
>           dpl = task_gate_desc.dpl;
>           x68_segment_selector cs = vmx_read_segment_selector(cpu, R_CS);
> @@ -167,11 +166,12 @@ void vmx_handle_task_switch(CPUState *cpu, x68_segment_selector tss_sel, int rea
>           x86_write_segment_descriptor(cpu, &next_tss_desc, tss_sel);
>       }
>   
> -    if (next_tss_desc.type & 8)
> -        ret = task_switch_32(cpu, tss_sel, old_tss_sel, old_tss_base, &next_tss_desc);
> -    else
> +    if (next_tss_desc.type & 8) {
> +        task_switch_32(cpu, tss_sel, old_tss_sel, old_tss_base, &next_tss_desc);
> +    } else {
>           //ret = task_switch_16(cpu, tss_sel, old_tss_sel, old_tss_base, &next_tss_desc);
>           VM_PANIC("task_switch_16");
> +    }
>   
>       macvm_set_cr0(cpu->accel->fd, rvmcs(cpu->accel->fd, VMCS_GUEST_CR0) |
>                                   CR0_TS_MASK);


