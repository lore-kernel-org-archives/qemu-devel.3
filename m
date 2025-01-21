Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C990C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 23:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taNRF-0007Cs-JD; Tue, 21 Jan 2025 18:13:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taNRE-0007CS-1U
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 18:13:40 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taNRC-0005SV-Ag
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 18:13:39 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21619108a6bso107859795ad.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 15:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737501216; x=1738106016; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AR1Yd8p5mYWR9C9rJiJsxiYOh4BK5zPQ1mb74SRdRuI=;
 b=e+Icfgq1EAEvms57/ZhmF50aGOB/jh5RMo0DlKcrSd9wtADi3m7frAJeUY4hQ5BOQg
 K6e3K/x7Clzct8qiHwIk/qEUiT8wgDCo+QroCqs327u5ck1932JSk1tYqNO7nTZa9aY6
 UW+qs4BuOunSKAgkVTMJ4SeLnnGBKxtMS0CLI2khMRHw/B3plUOvgXCMaAnORC01PtS2
 8RbWMs0ss1maG7F6Nvl4ozeHjBFoSc/qQaz6E/kWHMo+kb2AV/fc0wPrBZ75Ca7s/Tk5
 d0USaU4SAUioWdY3R5Ia1tOBEU9vq5mZl8uyFaVcBj5Lh9gJrw7HHEwTii/v0o6fETxm
 fabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737501216; x=1738106016;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AR1Yd8p5mYWR9C9rJiJsxiYOh4BK5zPQ1mb74SRdRuI=;
 b=mNTDG3bIBfLIa/X/iN2WxyowiRZAW77V320araci9AgFXD9whxID7QV2sUK+Zffv2O
 A05Af8a8aE5cH3LNfUhNxYYqGSvayZxhiM1kN8gbY0U/URtSgISKDyZE8Ug6DxPo3+TE
 5KA76U50GnXatVYCFXUcQpuF+XYxjv3nGBFnFH9gwtVbW5w9Buj2kNFe9FxX/tvrDJbL
 UH4wvnXg0KMm0H6tk66EMURVtaD8DWRmEFwsiJcL+oDTjshkhgVeu2Eu5AZ/8YTuEZU6
 HUo9K3oEtYHxNT13BziH6yTwO88pkje89er1OiQgkIT44CY/Jtl9Q0OyNDsZZ+ckRjBR
 d23g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCDJnRnwACvDxLMpb02Ow2THy2nr4JZfBfWDw3MW40yTmMu4/Uw1UPiia0J5zxNZof1EmUnc1EuqiN@nongnu.org
X-Gm-Message-State: AOJu0YyDZn3L6QCQa8j76aHhSTCHlsmha84RqIYEjsHFcIy2Wd8VEyvX
 mdlmHkBJ4Q9lBTlYlVIqIvoAKuodDg2yxcn7c53b6w0Q070crCniGehYA8Tikm8=
X-Gm-Gg: ASbGncsTE/dMFYDbJKNDKGS5/BKdvxrAFxjPgGpwdN5tpmqQupma9RefQUh2bmsg3lj
 H//q1qLvACWrxzrnHWe8+baIDsghvn5nmmibn7yDrh2LDhjfcfRwV1wEW41AvV4df3s6aKbNwx9
 h5JS/Lu+6rJ8TLIWAziGyhBDyz6hlB5SvIiZLBElFwUp5iTxCkgJdbyx8KXM9n2mZVUVgZ9DDxz
 UvpNCJorjP/nKwkLbv0UhAvg9QIzg7w9l9faKWD1/KalylombMcn+KVBiOK/zug50ojtCptNlFE
 n693sNBp/EAeyfM5LSZQF2UQKhPqPEzJE8W9
X-Google-Smtp-Source: AGHT+IHXQnuU+/ycq/EyPTYTD8GP97SyYdkty0iH1kd2JLlAXarCpC5rZnnbM2BUNDx92dd71A/q9Q==
X-Received: by 2002:a17:902:f651:b0:215:8d49:e2a7 with SMTP id
 d9443c01a7336-21c3561cb39mr273079065ad.50.1737501216726; 
 Tue, 21 Jan 2025 15:13:36 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3ad20bsm82982245ad.128.2025.01.21.15.13.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 15:13:36 -0800 (PST)
Message-ID: <062800d7-10ea-4106-b3a3-7db7acc1b291@linaro.org>
Date: Tue, 21 Jan 2025 15:13:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] target/riscv: throw debug exception before page
 fault
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com
References: <20250121170626.1992570-1-dbarboza@ventanamicro.com>
 <20250121170626.1992570-3-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121170626.1992570-3-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 1/21/25 09:06, Daniel Henrique Barboza wrote:
> In the RISC-V privileged ISA section 3.1.15 table 15, it is determined
> that a debug exception that is triggered from a load/store has a higher
> priority than a possible fault that this access might trigger.
> 
> This is not the case ATM as shown in [1]. Adding a breakpoint in an
> address that deliberately will fault is causing a load page fault
> instead of a debug exception. The reason is that we're throwing in the
> page fault as soon as the fault occurs (end of riscv_cpu_tlb_fill(),
> raise_mmu_exception()), not allowing the installed watchpoints to
> trigger.
> 
> Call cpu_check_watchpoint() in the page fault path to search and execute
> any watchpoints that might exist for the address, never returning back
> to the fault path. If no watchpoints are found cpu_check_watchpoint()
> will return and we'll fall-through the regular path to
> raise_mmu_exception().
> 
> [1]https://gitlab.com/qemu-project/qemu/-/issues/2627
> 
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/2627
> Signed-off-by: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
> ---
>   target/riscv/cpu_helper.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

