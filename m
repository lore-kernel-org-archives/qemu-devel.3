Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E79D60CEC
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 21:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD9id-0000Pq-2I; Mon, 18 Nov 2024 16:55:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tD9ib-0000PU-DQ
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 16:55:37 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tD9iZ-0003Lz-LB
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 16:55:37 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7f12ba78072so153965a12.2
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 13:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731966933; x=1732571733; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dA+MulIiYgHuvyQqcYWIuqcIGUlNPRc2HgtUkT9P/xg=;
 b=UHzLUdv0RZGkccImjIPeVK5/OcZP35DZTJb2zPWtpmnH0/MpgLoVnKzfffoI3YbDA3
 CUoRwUtdLjZNiRkHuGIg7lmHjPzZy4X43hm5gQoxXKKVGJG4BrD+wDHCeJ/UnyEfFOTC
 F+5GT9D0AEYl7txulGuXCGAJbiazMhhoC84JRTencN3iZDLQSgdHbBMFnsSTbjNk7s0O
 K8PmeZHHUpBJai2gU5fsOTUEW6dO79oicFTzvQuF+I4ECexNYL/hKXKpMAHq1B3ecfk3
 qrdqevTSd9wJs2V1oi14wQvRe8CSMbrjygPUEF6AH6tBS43IZ38hjBqxsQ61TdamhPmu
 SUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731966933; x=1732571733;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dA+MulIiYgHuvyQqcYWIuqcIGUlNPRc2HgtUkT9P/xg=;
 b=SWFwnywNw9jgmY7JrYhPKRiN6/BJifwDzpE14v3PXKRaEuofp1nAZEpWzy2AhbRyuI
 ZU5bf4jWXi67FCb1IPGV8Klf3NIerJ84aGNqqm9BVvLyyARb2jmayU09nLPatmy9zhWk
 1i5Flpf5io8Pfy6g9s6bdUKhP8E9Hxy4sNFgg4CDPaw9GXGUYB94glSYp0fF4UCoIYwW
 aDpJZa3mcQgOJXMqCM7ilVloUpU48dcENhPQIDK5Tkvqt6DP447AJViHfxrm8K/5jx8T
 fjSkQijW/nQ6I3FxD5mN/MhjrmdoUXEQn5sKJ6rn7PqZcE8rOvnE1MjvvyDSVbL4tKmk
 3uTg==
X-Gm-Message-State: AOJu0Yz1QLb2ux9xIZux4UAK/SV9Ef7Ws96kG4DlNIT48MyJq/UbMho7
 jZPCNFf50XK02LYfwEZzoTkZXJgfzvjN6XSUcITNLFyBc26qugvsim10q3ouoDB4pLhzo12s81l
 S/jEvPw==
X-Google-Smtp-Source: AGHT+IEHH313/NtmBeh7FHg6z0RTL6z41KQMGqvqqDx2jaf8PIB9sNGkD+3DGcjpATGWQv5UazxudA==
X-Received: by 2002:a05:6a20:8401:b0:1db:f01a:cf12 with SMTP id
 adf61e73a8af0-1dc90bae9ebmr19791972637.34.1731966933521; 
 Mon, 18 Nov 2024 13:55:33 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7247711ce3esm6715708b3a.48.2024.11.18.13.55.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 13:55:33 -0800 (PST)
Message-ID: <38fa8f19-fa4f-4aad-823e-af35fb80bc61@linaro.org>
Date: Mon, 18 Nov 2024 13:55:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hvf: remove unused but set variable
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 alex.bennee@linaro.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Cameron Esfahani <dirty@apple.com>
References: <20241023182922.1040964-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241023182922.1040964-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52f.google.com
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

Gentle ping on this patch, hopefully it could be merged for 9.2.

