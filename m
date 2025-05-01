Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59E8C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 19:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAZaC-0000mU-4f; Thu, 01 May 2025 15:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAZa2-0000gF-Dv
 for qemu-devel@nongnu.org; Thu, 01 May 2025 15:28:22 -0400
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAZa0-0000Du-72
 for qemu-devel@nongnu.org; Thu, 01 May 2025 15:28:21 -0400
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3d4436ba324so10744815ab.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 12:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746127698; x=1746732498; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nE/d6v4IGNsCc5cE6DF/N4iko97FJvkzG6xIWkN6qYI=;
 b=FkNyjHMVTuvoVpm8TLnat+Trm7mr5Gf7o8VQ0Tk8q7JXmjoHixrGhKPqjNTUNy2J5E
 dlRVB8roHu4xlHWXGCeHpOehVYk4pkquhcP4LRR3DPZvmIMtqmdbsWNRw5681cdmPP7w
 9Y0wnoB7JRBK9kCfSIGoo92OEiByo+vQx4eiZQnD19MVIHIXmq21vSyoYr0T/X14hJ/8
 0mP87b9cU4zXU1+Wc8uxh1/XcGDBR+V1jbokr2ax/EIwpzU0g93jzqy+chd5Qha0eozx
 kMSmztrVaD01bLoGMqBofZHw/O1pDk5LhZTw4rUiQIPkYYkHKksbqKwujRb/ZAcr0Bqc
 U/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746127698; x=1746732498;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nE/d6v4IGNsCc5cE6DF/N4iko97FJvkzG6xIWkN6qYI=;
 b=v3qsj3Q79HWkA6AMsLvII3J8nOPw2gk569LR4zX3cEdBVZ/j8NJAlw05E4XBCwv+aY
 FGEl+Kr+M5TqNPU4cVvRiqwYCkZUzuK9am1M6xNrvr0yL35VFu/iOiUJs6Fn5gOdT+FM
 3lmG2dwrjdGyRMyJXKS9EQFdWRxNYYK0llszsy4UQHzkehcpKsouWYoCHQAlEU8IVOea
 XJhBarytKvSgsz9j/iV3gRJ01Zt9pdiPgO3CdwR97laEiNwjcgL8LfnFoOT9CY5YMoZV
 ZTkaAJ8dWP8yR7fm4lkwQw4u1w4oEmdeoM0IBTsHVP3p9qpuW52BXoAcSwD7yGbt0ePi
 EAEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+LUz9cdW+T0tTGqMRCvvyt3OJxq21ySFCwJoob8W8tua4hC7ZuM1JG3bJ34XWqBV5WHbOMAUSNAea@nongnu.org
X-Gm-Message-State: AOJu0YykzZBySLDh4aKF2HN0mgkhqKjyHC+TNPw2d9LABzKdHVToE/8M
 5FA1Kr+PmuqFEULb/2pqeRg+iajeA9/tu/zYmKjcPr0eYt2a0B5GRjcNYiEQWMs=
X-Gm-Gg: ASbGncuIaXfX59hzCax/8xaPU4MzCwV2piPRXkxr5pDrLgqdp63XdCM60xYTrZ2UlgX
 G/MGgKXdWYXM4A7k3fxxDaPLprrlgYdandwf5FOBUm1e3/EOq6hTNRv4XNNFGZe1NbotoXoL1qw
 V8hrLZhEa6l6AZctu2IQYYCwg9Pa+B51MScrL1uh8s0BRRMuHWLQ6iTTDBYlqIsFv2jA2nAdWZG
 2Fx05xUHSXRget3bHJb7R21VtpdhERHDkX3qF1dQMMY2KeT9nph3LV4ELC76rORkDjWGy4sA4dj
 N805lYo07ntIqcGp0EvDPYJ5Ri3ELAT6rB1YvDSqPd3eb7hSGc0LphyYNbl36oasariUMBjivH1
 mcxyme+vOsMi8Nrmla3HP2KUP
X-Google-Smtp-Source: AGHT+IE4RafrimaLP7DXlBAwC7zDUl/SOUxW6inbiqP5la0qzJpi5CZnsNEjOu6aX7DEPEFOg1EwFw==
X-Received: by 2002:a05:6e02:15c8:b0:3d8:1768:242f with SMTP id
 e9e14a558f8ab-3d97c134260mr1865245ab.2.1746127698075; 
 Thu, 01 May 2025 12:28:18 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88aac80f6sm6839173.141.2025.05.01.12.28.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 12:28:17 -0700 (PDT)
Message-ID: <a9d29064-e4c7-4536-b918-057951dcc1ac@linaro.org>
Date: Thu, 1 May 2025 21:28:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/33] target/arm/helper: replace target_ulong by vaddr
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng, kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-21-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250501062344.2526061-21-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-il1-x12a.google.com
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

On 1/5/25 08:23, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 085c1656027..595d9334977 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -10641,7 +10641,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
>       ARMCPU *cpu = ARM_CPU(cs);
>       CPUARMState *env = &cpu->env;
>       unsigned int new_el = env->exception.target_el;
> -    target_ulong addr = env->cp15.vbar_el[new_el];
> +    vaddr addr = env->cp15.vbar_el[new_el];

Why not directly use the symbol type (uint64_t)? Anyway,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


