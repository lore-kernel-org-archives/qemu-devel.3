Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8559BE77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 14:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSHD9-0008A4-El; Mon, 30 Dec 2024 09:57:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSHD7-00089o-Ka
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 09:57:37 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSHD5-0006KH-Q0
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 09:57:37 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43623f0c574so62538065e9.2
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 06:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735570653; x=1736175453; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VrtkpifTu9ko9FfhJksxeRIJVXaPW7toti0ht/t8RnY=;
 b=YBQv+dvkhS9bZ9vOp4BrThHU+m+guzEg2RzMlbWHigJdPHOhJG1/bpEus9iGwvFo64
 q133twZjAHkN5qQ1HQ2RWoHAGvtAgpflWE187DG/QlpY0V7UlumqbxABOe5XJwhZlTMf
 myLjecvwFPjcck+FzA7+uJRr93n6VoNeUJ5PlLWG7YqlRUlrMHpdYYQ5M405LTxPcjfb
 8/USixUWV0kPwmO/3SdT+9iln4i+O7nU77iic1ThTNjfZ+DympU6btZVyzWFRRRAx0Vz
 3p9lruAh9KWcfhUXtchT6x9GzfCPEe1IaWPZ+LTBuCf1yIh6k9lScD3UBrxHNV1qhx4Z
 4kxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735570653; x=1736175453;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VrtkpifTu9ko9FfhJksxeRIJVXaPW7toti0ht/t8RnY=;
 b=RbcNEBaI31MF4XXAYuADxDpnGBuwLrQm1ePZ9a6olNV97JowZhlcYEj8cYyL9c24Te
 m/TikBagg6ioywtnevZ/5w2+f7vVCt7pFZNhoFTm36IZa0BjRL13kWkLX3LTAgqemDOx
 OoAreL8iT/CvEwq1NjpHi6L0M7+MXw3oSqnopHsqgp4IynfEMWcPxXeBPJJyGXwnCxs6
 8t55t9kSyi56nzWcHBsTllA8exZKqHvycWhc9F1oeuHPA/B1T4C0p/QwVSafPSXkrTlN
 O7TJe5mKQZdXm3HhNNA7kBbVu2R47HLeAq8pDCPWl/OAdfVkXcchC5epaA8KZPAUnVuZ
 NzXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAZ62Xj+e7dV+050orllS+Ts+dmeVRtyWc1xE1BvjILCfzEQyf5Cm3A9La8rfpjGZraz3PVIU4F9SL@nongnu.org
X-Gm-Message-State: AOJu0YxZtJN+gK5zaxjORY7njExIZqkm9Mb83SDNPkLrAlx47Wfpdc9S
 5YM8GmlrxUGRb3+HSsqeWhcpHSij2KV7NscCdnuBnx+ZULEoK5bfPtRZA3kwrLs=
X-Gm-Gg: ASbGncs1XY5O27im/ixhVaZj9ByBbDyuv+7i15CA1n/Ask0Ien9Y0QDI6PSN42egvDt
 MGv1nR3KCDHvNSt1dxh2sdQyFNipKAc6KpgKKuckEm6OnJ9hGx09DsY7AQ1GSexF3gcYh6ods9M
 6wZAAgoEil0rFPIZL0t4Mwf2PzFfd4XwsyCRQjNkdXltC9gQmFjlcPq2/t4QHoeB63J2KDA5kLE
 olzPCL1qczJqgQwlzIbANTRvxZ13y6O5h1l884eoLWuZ0OOokdkPay8RXkj3N7Ab1JngM7pG4FN
 HWzMkpw8g3aegxMudYMITboX
X-Google-Smtp-Source: AGHT+IFNaCK/9hfe4HaXNXMGz8Of/Pjkg0WT9IdaetSUWVMxRKZsXVjvCqTF/sRFzLyA+zOevtHL1Q==
X-Received: by 2002:a05:600c:3b86:b0:434:a1d3:a326 with SMTP id
 5b1f17b1804b1-4366854848dmr285190475e9.6.1735570652786; 
 Mon, 30 Dec 2024 06:57:32 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656a0b361sm391471675e9.0.2024.12.30.06.57.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Dec 2024 06:57:32 -0800 (PST)
Message-ID: <b7da9006-669d-46d5-938e-da1dd993cf9e@linaro.org>
Date: Mon, 30 Dec 2024 15:57:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/hppa: Add CPU reset method
To: deller@kernel.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>
References: <20241229234154.32250-1-deller@kernel.org>
 <20241229234154.32250-2-deller@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241229234154.32250-2-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 30/12/24 00:41, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> Add the CPU reset method, which resets all CPU registers and the TLB to
> zero. Then the CPU will switch to 32-bit mode (PSW_W bit is not set) and
> start execution at address 0xf0000004.
> Although we currently want to zero out all values in the CPUHPPAState
> struct, add the end_reset_fields marker in case the state structs gets
> extended with other variables later on which should not be reset.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> V4:
> - Drop initialization of exception_index in hppa_cpu_initfn()
> 
> V3:
> - Call reset function from hppa_machine_reset() instead
> 
> V2:
> - Add end_reset_fields marker
> - call reset function in hppa_cpu_initfn()
> ---
>   hw/hppa/machine.c |  6 +++---
>   target/hppa/cpu.c | 26 ++++++++++++++++++++++++--
>   target/hppa/cpu.h |  5 +++++
>   3 files changed, 32 insertions(+), 5 deletions(-)


> +static void hppa_cpu_reset_hold(Object *obj, ResetType type)
> +{
> +    HPPACPU *cpu = HPPA_CPU(obj);
> +    HPPACPUClass *scc = HPPA_CPU_GET_CLASS(cpu);
> +    CPUHPPAState *env = &cpu->env;
> +    CPUState *cs = CPU(cpu);
> +
> +    if (scc->parent_phases.hold) {
> +        scc->parent_phases.hold(obj, type);

This ends calling cpu_common_reset_hold() ...

> +    }
> +
> +    memset(env, 0, offsetof(CPUHPPAState, end_reset_fields));
> +    cpu_set_pc(cs, 0xf0000004);
> +    cpu_hppa_put_psw(env, hppa_is_pa20(env) ? PSW_W : 0);
> +    cpu_hppa_loaded_fr0(env);
> +
> +    cs->exception_index = -1;
> +    cs->halted = 0;

... which already sets these values. Why is that required?

> +}


