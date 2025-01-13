Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C256C02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 18:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXOvy-0003SF-PU; Mon, 13 Jan 2025 13:13:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXOvv-0003Rl-AZ
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 13:13:03 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXOvs-0003XF-F7
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 13:13:02 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso49072875e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 10:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736791977; x=1737396777; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=llEJBtTAgOvNF94M0sIjRQZqk+Ar8n6bj+dwLqpltaw=;
 b=cs25RmIm6A+x4yJ9EE2tptTkDuS0/TR1z04Yi+ROjTcxQ3y1BGUPy295eQ8UjCOG2P
 dw61gW0KN0Kk7wIV1rlx4OJFAmum5VnW95ZJkvH3WGnhd1WzTJqHFKJnC30vb0SdHM6S
 f3YMFy8pU6hQjGnf20nMGB419jRaB/EVTptpYQK3p5zJ7vdc5o5Z3Imhkx5holMdWG8X
 zU3SFZ8VTPX0nceinb4wlGprY+Kafldze8M9eQc/2q7lp741NOrRtPdvTG8XTz8KmJbe
 iWxkpGpZdWoWlkdphzMdAWl8qY7/01FVRfRE9egcaDfydo8NWSWBE5pj8qQ8rlh/6VWz
 buSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736791977; x=1737396777;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=llEJBtTAgOvNF94M0sIjRQZqk+Ar8n6bj+dwLqpltaw=;
 b=r/bBLTW8+pBhjtW5HTgbLJBSx29vvHrlQxq+QxOhyZwISoevM+/KHzxt5/b9Mll7/B
 iZI+IKE2gN2RbrUWeB8rMTvmMelOs5yC2uKLRjORYqiRR4SNalItpn1qRNqnSCLBGz+i
 p+UxAXY2y0YQ9t0BuYOn/jIhHAPWsMIi+a40xFAlf0RxXTNeVOFjuKoXJxt70mq+q6DM
 Tq1jcGXyI0WLwdr7JwfOtxfdQ7Aodzgj2JoWqMpL5hlG9RnNaFWM4MvNCwtmWySeYYYR
 uZ4m0xWbYzuLAcMOqnzZUB8kiX+pnyFdZKx+N24hhDQ9qJRxUq/xYaPqVtUipyEUEptP
 IFvw==
X-Gm-Message-State: AOJu0Yygt3urKnjQNYEUsWMwpDo8vmH1+4nUeKjYTllo0tV7wR6MO7L5
 yCD/PBJ/Wx0mGGiJCoc5eeEZueFqgZ0eJpt5nkMOOUb/AuPsG+JtXOYOPbyA0GrHwpllQTsm/GY
 olKk=
X-Gm-Gg: ASbGncv8Rb/dajRKtPifT0XLWZu4fHxRObM7Xmqu2RsgXVF/lVJpaBhG7Npy2OdGcVT
 oIeSJ3QX4qLVZYMvtS9i/7kJ7ljM9qfCuJAi1VhFqhneQv/y2QDcnLoJkA9Ag8MHT6R2QYdtiyU
 9fUs2iJ9jggwSKFUgaFCgNmcTb6DS07oFYFplu9w0jRPdFI97KUWM2Mf93PrwMG1+Ph4DMpj6oG
 iDKSUzuLQ8e1zTAdTyagkbuP11QBBU55bxsX+/t+bC032QVaFPI+CPjpszNJ25pkwjAnvFZLabz
 W6LDXU7KBcyqWeWnQ45yQ7tV
X-Google-Smtp-Source: AGHT+IHUZY/LebG7pdcbF4JaEtgt9XG0EiWPSHBCIAxZHb+f13k9X1LjuZlrU20qbO/R0R72iL9SIw==
X-Received: by 2002:a05:600c:46d0:b0:431:58cd:b259 with SMTP id
 5b1f17b1804b1-436e26f4d53mr202845255e9.31.1736791977274; 
 Mon, 13 Jan 2025 10:12:57 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2dc0bb7sm183460155e9.16.2025.01.13.10.12.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jan 2025 10:12:56 -0800 (PST)
Message-ID: <3b205b18-fcc0-4e3b-a4d9-890b1e235c9a@linaro.org>
Date: Mon, 13 Jan 2025 19:12:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/23] hw/mips: Remove all uses of &first_cpu
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen
 <chenhuacai@kernel.org>, Paul Burton <paulburton@kernel.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20250113004748.41658-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250113004748.41658-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 13/1/25 01:47, Philippe Mathieu-Daudé wrote:
> - Refactor the MIPS Bootloader API to take CPU argument

> Philippe Mathieu-Daudé (23):

>    hw/mips/bootloader: Propagate CPU env to bootcpu_supports_isa()
>    hw/mips/bootloader: Propagate CPU env to bl_gen_nop()
>    hw/mips/bootloader: Propagate CPU env to bl_gen_dsll()
>    hw/mips/bootloader: Propagate CPU env to bl_gen_jalr()
>    hw/mips/bootloader: Propagate CPU env to bl_gen_sw()
>    hw/mips/bootloader: Propagate CPU env to bl_gen_sd()
>    hw/mips/bootloader: Propagate CPU env to bl_gen_li()
>    hw/mips/bootloader: Propagate CPU env to bl_gen_dli()
>    hw/mips/bootloader: Propagate CPU env to bl_gen_load_ulong()
>    hw/mips/bootloader: Propagate CPU to bl_gen_jump_to()
>    hw/mips/bootloader: Propagate CPU to bl_gen_jump_kernel()
>    hw/mips/bootloader: Propagate CPU to bl_gen_write_ulong()
>    hw/mips/bootloader: Propagate CPU to bl_gen_write_u32()
>    hw/mips/bootloader: Propagate CPU to bl_gen_write_u64()

I'll respin propagating the other way around, less code churn.

