Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F04CD4F25
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtOv-0001r0-Px; Fri, 15 May 2026 10:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtOm-0001mC-Ou
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:20:20 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtOl-00079A-2m
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:20:20 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-44ccbd3290aso7598730f8f.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778854817; x=1779459617; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iGefz1iLrO7INFn06rk9AFAvSJOUdBvGgzxqOmdD3z4=;
 b=RPkpESI2tTvi86tScbx/4LyCeZ2zosgGK71i42w+jMVgR9P5AgtWefslFE0SRBL4u4
 lMH2M6Aur5LBXJuvUka1ZyN1S1D4yCat0yc/+wu8ixkXbY8WrRvDTabbHb7upg1SjHgS
 KSHybEVLPGZ3sGUYuAxkoFqog/Nv0tDzyrVvVkxSden1qvx6q5rM3bqZKt+nvTVMbM6W
 i2vtokvGMvpGoL4KvqSo3njRIDdK/kMDGa1jj4b3d64wujuGu+zZB7yvdq7L94Ntmar1
 JGC4oZ3/NeD1rtLOHH21W8dxRzwfT0m330gvg0yqtbYwSrSI+5+7ZVPx+8pi1enJuA9u
 yejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854817; x=1779459617;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iGefz1iLrO7INFn06rk9AFAvSJOUdBvGgzxqOmdD3z4=;
 b=c5AsrnoD9Hyq8wp1ZhPM6HuFQ2+S1DlO2MOcYv4/oIyiNnBAAMwWwXWjXFJxd6422k
 tkFdL5D+xkUh1EvJEQquRaSDFqp9T/LAM9phH+ZaBTgxil7AKyaSiDsHkjXtDH6BwWlX
 SCdtEhCJ3oF77GVigtq+ctJGlt12Z1ktO7iUq7yH3d56I8rqT2XIAbi1+PrOxSGcI3fS
 Wj3iwbf+IMxMpFt/orXByHR4hChTYuKdQ0mOZhxx1lJPc5ksvFrmfactW7efAUM70qq1
 vHjD6nIQTnWw07kfrsUkZNG+OMJz3iThvF8j62RKRAE91npRKkZqw8A7UTN89vYLKiM4
 nmuw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9u9EhrCfLEIsVqq8kZzKsoxZFoPj13jmHAX7In90hYvpAKZFR07cg7Id9+4ztGs+6DZoW3/WigwboD@nongnu.org
X-Gm-Message-State: AOJu0YzFnsDXHGxkz8Lbvax7OXWjMM5HYPjDDcX2PU8DGdC1wtd01fPc
 pjzPG958aeUbAGELZs5TKG7s/84+O8nMl2iWTtDGBuXqEIaHaGA6k7kzwvA2wUNWOKFHNW0qlvS
 f78Q7PB4=
X-Gm-Gg: Acq92OG52fAgRj4eBot5PC1Bue2+bKxeZyTVyuI/EJsIEqT+NL1YpHICnP6bIK+6FdR
 GpHC5iS/4UMHcW4jtc5k8Iu4KjVxSuIS/kv4uws+54N1Y5Ox3Mg8vXGzUW4Rr02YUTI+OoAmRi3
 L7SQjgEnQUt+6LDndImLQYhluogZ9O9/Br0w2zef8EagUqzmCksNb9SHkNaCuNePrtHE+laRcdI
 gAS4gPZPSzwoU3HuJJMDXUTqtKn//AsTgQlyuZjjHpTfc0r3bDoKfM9vty5EvVgqpxH2dNEAK+E
 KyHhOy4dWLaBeE1KD/xxqAPLReob7YVZ/xQKAJciddTDl8OUaACCx7emTZbeapZAFyHyOJys11h
 /nfkMKiUdzd/3yKH0s6t5jPAYf9px8ZPehyn9foqWa0LBqhmtTJgvwxq02zU04UtWMYbjjkLfMQ
 t2M1n0/nCbf9YtC+kU7cSEGG1Y0tTnY1482OiuYRd/zGsC40i1WUfMGkL+YzNcEOxltQ==
X-Received: by 2002:a05:6000:25c4:b0:449:e8c0:fd58 with SMTP id
 ffacd0b85a97d-45e5c58d95dmr5737249f8f.27.1778854817506; 
 Fri, 15 May 2026 07:20:17 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e767cb9sm14746668f8f.2.2026.05.15.07.20.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 07:20:16 -0700 (PDT)
Message-ID: <c84c0267-7997-4a19-9e08-e7ccf35d399b@linaro.org>
Date: Fri, 15 May 2026 16:20:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/microblaze: Convert to translate_for_debug
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20260515125727.349675-1-peter.maydell@linaro.org>
 <20260515125727.349675-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260515125727.349675-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 15/5/26 14:57, Peter Maydell wrote:
> The get_phys_addr_attrs_debug method of SysemuCPUOps is used only by
> x86 and microblaze.  Convert microblaze to the newer
> translate_for_debug method, as a step towards being able to remove
> get_phys_addr_attrs_debug.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/microblaze/cpu.c    |  2 +-
>   target/microblaze/cpu.h    |  4 ++--
>   target/microblaze/helper.c | 25 ++++++++++++++-----------
>   3 files changed, 17 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

