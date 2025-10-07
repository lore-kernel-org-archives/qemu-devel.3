Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE04CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 08:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6315-0006D6-UN; Tue, 07 Oct 2025 04:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6313-0006Ct-GF
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 04:25:49 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6311-000393-Uf
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 04:25:49 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3ee13baf2e1so4295816f8f.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 01:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759825545; x=1760430345; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rl6cDsv/7r4rpRe3gLIsMQdFDQ9m9DvjqvRBYv4oevM=;
 b=MOFn6T/EuNrEvia0SiBjygc16BdjSOgS1E/8QGXgNXskd4lzUsuYwLh32XuL9s4dXZ
 xHWedPiLnTC8skyPFJB2U4e/qQVwavMYbw+uv6IXSDXRTgTfnKMaaFJYzROgSJrFwJdL
 EcCPJZrAsnkKbXJUKasgaxFFsUVqSsMkrOs2GR7nJb7x3zrgZSyP8rLvM09yu5fvvaKJ
 yvJh+DuNNnOq4SUaHYvDZn7+I49T87VpDT+KV6A6uoCJNNvkBpQvADCiXdJfrbkv1UDm
 E0UcpiZVZGKd3c2jF5Jy/UX33NdSNDCBE2vYBPVljAZ6Q4lhaQnKex/3k8K1sHu2qGTD
 2p6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759825545; x=1760430345;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rl6cDsv/7r4rpRe3gLIsMQdFDQ9m9DvjqvRBYv4oevM=;
 b=CaOEQn4b5mY8nLSUJTaTxYrXKYTPYrbvfUYzvqtyVWQRM3/mQK8LfKHqeQsih8x0ZD
 /wH26VX6l/H/2yIADQohG/YvUmQWR5aW1+5vrfw1gU/yIxxaQKd/d8tHpbvfiziRqv4p
 NmQqYVnV8SWLwe8vP4Plg7IHNUN+4+MNh0mUuRd04pJU96NBrvfL1+aHB9pE7FFi0CRU
 axNsoBK3ZvtyMjttYp9RjxIQWe2vwPIL98+awIZbg3dgmCvNfrFR7qkQNNaDuBcZu1Ar
 fQ254QMZnKeeg4EX8o5h7YTkrZe7tA8EZ/Fv0cQbZsbZGBiB+8X83sWmAyRxRVm8w8kb
 UYXA==
X-Gm-Message-State: AOJu0YwVm2z9UmxVrRYPUl+PkLkM7TWkUGtsRM6V17Flc0biVmz7Qmz4
 KJw03kyCMouaL/an5fhdzkUwjSSU9rJ93prXijqOBJtfTXDUCgHJJXRnPlngxRbtPMYIc2hprtC
 FO7o1ZmXD1Q==
X-Gm-Gg: ASbGncuyZsdcx5hzbFdytZcNJZ1WNGNQUIYRwQWLed+N4XWVSYfInPFiOeArOucSgfs
 PswxeByGS/eupM0YCpH5ejL8aeVTvoAQONtFWmygHPp53c56fUyAZKifjGOTGLPzYxDnmCUz1CX
 hIOqToTNYzFRcFmSaK6sWgeXoq8b85NBtvIplmH6Tz7v/1u3rK+E3i6csUmz7ombDQAw0Ao1ywM
 kS2Ej/xaCbNxHNEkq2eM61n5oJtP03A3uZioqPJMyd2+DEibZplqJ95GfNNShxliPy2BKfOm8eg
 PvTabIB5Dbzf5wZLU0Y+CKVHngW2nkdRGLiW14/gjLeZA5UdglHciGxRicMfkLgahVEWu3wgEoF
 Rjaap/35iMoC8xM6ZdFNlCBeQnI1XWNkbQoRBfitibBooEvQdK1qd63hXfdirSyOQy5aIGerWsD
 8R00CWYUkSP7U9HGlalQ==
X-Google-Smtp-Source: AGHT+IH6GtF/djITbpu4YOd7RZDabLUXck9TL3YerSsXr2xrFv8hK/kyCrCPjm6CO78+tROyfShtkw==
X-Received: by 2002:a05:6000:1848:b0:405:3028:1bf2 with SMTP id
 ffacd0b85a97d-425671c2ecfmr9603455f8f.62.1759825545274; 
 Tue, 07 Oct 2025 01:25:45 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8efffasm24388801f8f.41.2025.10.07.01.25.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 01:25:44 -0700 (PDT)
Message-ID: <2fa345d4-57e6-4f31-b201-8d45e68257ea@linaro.org>
Date: Tue, 7 Oct 2025 10:25:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sparc/leon3: Remove unnecessary CPU() QOM cast
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Frederic Konrad <konrad.frederic@yahoo.fr>
References: <20251002033623.26800-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251002033623.26800-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 2/10/25 05:36, Philippe Mathieu-Daudé wrote:
> env_cpu() already returns a CPUState type, no need to cast.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/sparc/leon3.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Patch queued, thanks.

