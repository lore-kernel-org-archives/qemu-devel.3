Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B391C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 11:15:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCzDl-0008WL-Uj; Thu, 08 May 2025 07:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCzDk-0008Vt-QT
 for qemu-devel@nongnu.org; Thu, 08 May 2025 07:15:20 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCzDj-0003EU-8X
 for qemu-devel@nongnu.org; Thu, 08 May 2025 07:15:20 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22e6880d106so6257065ad.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 04:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746702918; x=1747307718; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZoygyoQ6JaTgf0lGZ8kSEymwPxAeuA1Rm+7OQNYgvT4=;
 b=laalllsPU8jvu3dTU37T5085byyn3xKuI3jORBGfowrGFMcvFPNWYfV87TRueFYO6j
 WfHrEoVi+nELq0gcaNF0sQ566kVpsdNwZzfzUyMI0QoOr5wAqzs2jRpk1QgtMOnW6Mzz
 zevka2S0TJq60f3E3pRckMW17+I/q5nWocRpWD5WMopceFX/5PqaR4/QpXaSGKvfG42J
 ejtX8ZWUOYjQpy2bALnGkb3Qp4L/flkaDME9b7DHeHPDry5MQJRddJRh5zEoHeWSlSUG
 sEAF8P3aZ4m/S/5bm6QjGHMEo4o/4YhDc9lE4qYwsQ3Zo5GsXSUljRaGap3eCfyAs4mF
 JTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746702918; x=1747307718;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZoygyoQ6JaTgf0lGZ8kSEymwPxAeuA1Rm+7OQNYgvT4=;
 b=kui/hzzGgFRAz7lXqkRhVfXzchBu34/l2gpwWwXD4Z8vY/uH0t0vR1xLxKyjlt1ohs
 5B+DaL9I5cYwj0Drw1c6HbfGv+eZWaThy5EzZrIVKdEmWVSGiVOnzZm4ttM7ZnaSfchI
 uS+SMnOIId1SSgQb7eZdw3oW6G1hH1kgFO8GPGbdT50Z/wb2QScAn+wSI0IX/GoYwibo
 9ZM+S8Mrd14DwlbfmHZ4IhzLM+W+NnpMWYMkI8600lAfy752kOWVzIkCt9UWxwXcWWjU
 MuBmiyhii404TMuey7l+6fHW1NicmrpQsksMahRreVUDjZUlgZrU+De2UpJ7ROjsWUXh
 0LuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6tdsPG9XfjPlycsNfUos3x1A2S41wrkRk/89izYu6h5ZgxOT+BD6wUzU6zQfCDIAZnRojJtdnjHml@nongnu.org
X-Gm-Message-State: AOJu0YzOFxO3Uro+SphdasYGtq82sGajdt4o0t8mQOq7Zt3NF4w/6FfA
 TedyscHIJfEnQrelciBCGBQQpWK4+uxP8Yh+OiJGJGkJZHDnW8ln+F69/RS9690=
X-Gm-Gg: ASbGncsSSSTcF2iDfKAADgBayQNBqAohPrmEw6r+WnZAvEd9YVJdHlgLAH0XOTA48Pc
 5RTvBBqLY29vbpOeSf/qCzNNU+DDhb2zGhrBEmyNiZXsDEfIgXJEGdv4AEzRuzNuxImKqaOH1Nv
 ckYD83IwgS4oSaFSyOSqtsn4VqSYqFSpWGDC41Ih3+n7S6AQA2K3XGi+sxT4BisZIkOrgYFni3I
 gDn/6NocstgUXJ/Ot+w1+n2277T1FFb2xlzjet5Ww1cycu60BHKleUKqN+VmVvR/kfASBM/HY3h
 LA6VEqKq8LDizJq1VWE9KQsRDh9FW21Shxid6nUGvAVohXuOdXEkXLGSkV+7qXexbmfwczqwvaC
 uubtTiXkj
X-Google-Smtp-Source: AGHT+IGONAW+hD2eF+8A3Hp0VPo6ruT0PGfiiKdyY5H+/DFGDqcszwpqDqttfrsKL4TrKy4xfZKuEQ==
X-Received: by 2002:a17:903:22ca:b0:21c:fb6:7c3c with SMTP id
 d9443c01a7336-22e5ea78834mr99727305ad.17.1746702917752; 
 Thu, 08 May 2025 04:15:17 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e150eb6e8sm109920955ad.26.2025.05.08.04.15.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 04:15:17 -0700 (PDT)
Message-ID: <c2432666-bb9e-431c-b1ce-50360046be71@linaro.org>
Date: Thu, 8 May 2025 13:15:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rust: pl011: Rename RX FIFO methods
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
References: <20250508082943.446512-1-pbonzini@redhat.com>
 <20250508082943.446512-2-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250508082943.446512-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x633.google.com
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

On 8/5/25 10:29, Paolo Bonzini wrote:
> In preparation of having a TX FIFO, rename the RX FIFO methods.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   rust/hw/char/pl011/src/device.rs | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


