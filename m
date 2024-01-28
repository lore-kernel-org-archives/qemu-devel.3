Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EABC47258
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 16:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rU835-0006Rl-Sa; Sun, 28 Jan 2024 11:30:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rU832-0006IY-9Z
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 11:30:20 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rU82y-0003U9-MU
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 11:30:19 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a33735d22fcso142871466b.2
 for <qemu-devel@nongnu.org>; Sun, 28 Jan 2024 08:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706459414; x=1707064214; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a5rOXLlprbmBpgjE2OvyWMyBFiMFYe6qOSmPyh+H0bM=;
 b=UwVfiVRiYAR5K2HTldrg0AmY4nPP+1IX7KkAyhPXAI9ek65RWozeBLiQ8EFUIFXmFI
 3QHAcaymW4FNYClVduDvugmUW9SNRg2yeiQ9Jt0cu6g8lZTVqSoJ1ozgLN7vs6vwXqXS
 9TnaoXsCBboy2iuZ6GToE2x7sCUh6d1UGvX2w8day0Snv9gM8+Uymj9dJznvdAp6cnT2
 PpvDmO2Tuuo2/iXFK25PEx+ZxGOwY1ZA1KzCPRzkpOyxZrFtdfyHw6K3G7/9j0zd6xb2
 OBWtMEaZ7vg21wjTQCNedYqd+lT3g/hm7yNa4e6qRW/n2cJTPe2wafOhrdgArHiPQi5p
 2M0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706459414; x=1707064214;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a5rOXLlprbmBpgjE2OvyWMyBFiMFYe6qOSmPyh+H0bM=;
 b=hAHE0fsd/1oa0wRwcwcU5aT/jtCOUIk9LGHHA6DFCy3f6FuV2NVKG6XI0c4RSRzCWl
 u5JkhxUX3X28knAxJyaXsqFjK6wEfYsjUWW3qtjD1JeKFKmIY9y7dJeYZA2fA/+/Z2OL
 J09gPsYbziaJGlUb/INuMbSl/IUREhDbKq1hKu7MLr6/Ajbc0OpUxPot+bpj3V9xitJD
 URGRnTBtG4N9QKsMCZEEKk0tZkN6k+4kHckaoyrUZSo0kOjaNVH3D+V4PqLFObsNapMD
 HmZU5iFgMfoyZkCH6hPvqGRJ0jj9WqsqahDIwFT+GR+VipctlNmVGk9o0LpLAN/yIO+d
 Hmgg==
X-Gm-Message-State: AOJu0YxbdLECeVLn5MOIPCpG0yzi7iuRYmPmOOguoewgEWsqQnWHL4n2
 6LYcuKbIWWsF+UGhLA4WljlsjL/6Tlz47C3EdQg4r1FR1QLRbbLCK4afLiVziOI=
X-Google-Smtp-Source: AGHT+IEgd9VzB0phgPG1I/Nv940z2RzV2fhHYJM9jx6GsemKUPnUpjOIDytciZyT8wfZUdaFq92GuA==
X-Received: by 2002:a17:906:168a:b0:a31:9b4:aa2 with SMTP id
 s10-20020a170906168a00b00a3109b40aa2mr2869229ejd.51.1706459414650; 
 Sun, 28 Jan 2024 08:30:14 -0800 (PST)
Received: from [192.168.69.100] (sev93-h02-176-184-17-196.dsl.sta.abo.bbox.fr.
 [176.184.17.196]) by smtp.gmail.com with ESMTPSA id
 vh5-20020a170907d38500b00a3517d26918sm2440504ejc.107.2024.01.28.08.30.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jan 2024 08:30:14 -0800 (PST)
Message-ID: <c1f4af18-9af0-4833-8610-a58e69e6583a@linaro.org>
Date: Sun, 28 Jan 2024 17:30:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/33] tcg patch queue, pre-pull
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240128044213.316480-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240128044213.316480-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

On 28/1/24 05:41, Richard Henderson wrote:
> Collect some patch sets, cherry-pick from others, with a few
> changes of my own.  Patches that lack review:
> 
>    26-include-qemu-Add-TCGCPUOps-typedef-to-typedefs.h.patch
>    27-target-loongarch-Constify-loongarch_tcg_ops.patch
>    28-accel-tcg-Use-CPUState.cc-instead-of-CPU_GET_CLASS-i.patch
>    31-accel-tcg-Inline-need_replay_interrupt.patch
> 
> 
> r~
> 
> 
> Anton Johansson (11):
>    include/exec: Move vaddr defines to separate file
>    hw/core: Include vaddr.h from cpu.h
>    target: Use vaddr in gen_intermediate_code
>    include/exec: Use vaddr in DisasContextBase for virtual addresses
>    include/exec: typedef abi_ptr to vaddr
>    target: Uninline cpu_mmu_index()
>    target: Uninline cpu_get_tb_cpu_state()
>    include/exec: Move PAGE_* macros to common header
>    include/exec: Move cpu_*()/cpu_env() to common header
>    include/hw/core: Move do_interrupt in TCGCPUOps
>    include/hw/core: Remove i386 conditional on fake_user_interrupt

Nitpick: preferably s/^include\// in subject :)

