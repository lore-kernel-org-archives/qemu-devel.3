Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BCAC46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 04:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTaXk-00060C-Bi; Fri, 26 Jan 2024 23:43:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaXi-0005zw-Dy
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:43:46 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaXg-0008Qc-Ve
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:43:46 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6ddc5faeb7fso895738b3a.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 20:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706330623; x=1706935423; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VOsHL3itJx0oh4VlgtT+hMO/J6stuIUJZTB4MfKYbpg=;
 b=zljhNL6twwkRdetwhX8VL0ZGdU24PeMKyH18/7gD+U56xWrjMVhR3S2+EQBbYN4M1G
 NMoJ1Sf11w6ZGqevcJNoZs3s0GhJ40wJ4XjXX75YaYgXDdM4pmzu7FubKpcBKinD9axL
 6FQDkHDCG1HVmc2qiLOWC7aMR2XEl4kZib4Ld0uajQJOLVtyJStO7tAnNF8Vkk7SuikA
 HMtGg/GEkO+ciEqLeaAjsssjBZbvVTeceBrzwZbnH5GJ8BT2BffmxW1vHbgdSuHIetmG
 1t7MEDoYHiGksx+75m4CykyFfeAXkFw6evfeZzJQsOAotA/41q7uOkLemM0trrNUyp7e
 HRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706330623; x=1706935423;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VOsHL3itJx0oh4VlgtT+hMO/J6stuIUJZTB4MfKYbpg=;
 b=wwor+vmUIEsh4uZVGxiuKe5Dshnyf30A8TZF1A2+fKEdUv36kTPMPQo4yLcpZ+bBQv
 dKY1R/J5+VLHcr/Dp/BDLheIY60MCNc9qqY/dY9ks5imMTsgjfGOMKkCmB0uoGiMU5yD
 G9fKmdSc/wh+IGsoshu6KAc1nZiR9lqGCO9O9JRiGI2lWO8UMtqosiufbpeFch/beN7V
 Dpmr4i1IC1Qx9UpcjL0ByVHQXLKAA+ArEU63g0kWwwnbXNpbUYz/xO6Iix8jnILhJ2M1
 iBd6lelDaydOeSCYQX/dKcWu0ugcFzZNN5ShjVQywvlCzEvY0zx+WKI8i7KHcFGKb8vE
 6MLw==
X-Gm-Message-State: AOJu0YxJlgpfvr2Vynon/pllz6ug2u/2onwuLMaR7ShLBbPXrctNcqu7
 rfxP1wTHNA98tzN0YVM/acotJERVDeguPTY5ei8uOSXTHhR4CrSOlsGgxM1LrE4=
X-Google-Smtp-Source: AGHT+IGaJvSnas3PoZHf5McI2237U/+XXr1nXpF9u023cbbI/CkHCqzBOunNykGVm2mS8WeqFnzkpw==
X-Received: by 2002:a05:6a20:26a3:b0:19c:6a7a:2df0 with SMTP id
 h35-20020a056a2026a300b0019c6a7a2df0mr753667pze.66.1706330623419; 
 Fri, 26 Jan 2024 20:43:43 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e?
 ([2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e])
 by smtp.gmail.com with ESMTPSA id
 c24-20020aa78c18000000b006dddd283526sm1885981pfd.53.2024.01.26.20.43.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 20:43:42 -0800 (PST)
Message-ID: <1d05956b-958f-49d3-a2f2-0cd0092b810b@linaro.org>
Date: Sat, 27 Jan 2024 14:43:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/23] target/riscv: Prefer fast cpu_env() over slower
 CPU QOM cast macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240126220407.95022-1-philmd@linaro.org>
 <20240126220407.95022-18-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240126220407.95022-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 1/27/24 08:03, Philippe Mathieu-Daudé wrote:
> Mechanical patch produced running the command documented
> in scripts/coccinelle/cpu_env.cocci_template header.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/riscv/arch_dump.c   |  6 ++----
>   target/riscv/cpu.c         | 17 +++++------------
>   target/riscv/cpu_helper.c  | 14 ++++----------
>   target/riscv/debug.c       |  9 +++------
>   target/riscv/gdbstub.c     |  6 ++----
>   target/riscv/kvm/kvm-cpu.c |  6 ++----
>   target/riscv/tcg/tcg-cpu.c |  9 +++------
>   target/riscv/translate.c   |  3 +--
>   8 files changed, 22 insertions(+), 48 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

