Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588B8F531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCRxC-0007CR-U9; Mon, 13 Apr 2026 20:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCRx9-0007BW-Nq
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:48:32 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCRx8-0007YY-AI
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:48:31 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-358ed696623so2175223a91.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776127708; x=1776732508; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WkvlF6qPczmnYeE3GYMCHsrp99mpkagfHrJUEXOYIZg=;
 b=j4D2oTBKnXJFFKh9SkdUI3nSS2vJIASJc/bAaIqHiqeDb930zJPbPpyeQ7gPb8iYMY
 2lZuFdTDVlPa0fdBslyVivYs3Wn0zQYt7CqKmMC6RyZREJnqzZhHVO+ueqXZ7mjVq5JU
 P/brkWt+kO21h520+KUnOKdGjLQNpWbq2P8mpqLeKnvQpyio09jNDyD/sIUmSZdcqv8i
 vKOeNg/Q7PjLth1oV7feF3inwRkF4hyFqJgIdA7PeS7+z/XHU0WmSVI5GicksP2o+U+S
 NaushbwkoxsYEgfDisRLyrKLvKL+xgUT6kYMxlN/ENLnVdD0jdOMLQ6uSJaPauSFe2LR
 139Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776127708; x=1776732508;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WkvlF6qPczmnYeE3GYMCHsrp99mpkagfHrJUEXOYIZg=;
 b=pekEsWpg7MFSEOC7QENbmJHLjGQDrBWA6x4stP2p4vtC9j4UbCjsT7+9+gX42+xJw8
 rYGfxDPCWyuXLTpgxi5/fH7dnDgZ2FQtXAenBJcva9XipwNrUmPwsprjGE8SpwSfUJop
 hhM9dU43zSMd2wn50PxhITrn0kjljT+vThAxT3DQeG4IK7ypr0tDIJj1KKBwJn1vuY3X
 JjDHB0Jy2CoRNsohcqNWjx1JosEYGJbp5fPmY/intiHjt3J7EbTbPDHF9cauIq00Jxr4
 KoaJvHX3kHr54Rm2AzrFKv8nn1vmDD+IzxAsY+yhQRqYyQK4vU6BvtR1nZ2+tHOg5Rtb
 TQhg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/9mDtu7Wgh1VOtAfrNB+BJ2Qg9vLZkvFnroaP56Vp2qtRvaU8rL+V87xq34utXo7bGHXatTYko4R91@nongnu.org
X-Gm-Message-State: AOJu0YyZkUi+lKDReZi0LagjtQ38DHydng5Wtl8FnNKreiVM+idTw+Mg
 4ru3ZsjaKjxZvIHVVxzbzgp8U6luiegJ0whoDNUdOGzGDQhIAWDfnCRYHqrs1GFrwXk=
X-Gm-Gg: AeBDieuBh46G/oUEiZenSsBC/j2NhNLgefOGlizVEYjVk4/HtOE3tix8qO/PTZJ4kJv
 LdOA2f3s5wVk8r27Ba/pKGtws2wktBA3M7p75pWU3JaKomiTuqHrErq6WqeOjh+f4z0YQiVytMX
 5DlmYILrvWohpPIaYcb70/ufePKlUcr9YW8Jbv3xSjHeHRnqVMwKncfJ4cKw3iqWz0OOY3FQvIV
 /B3QBJSZZj6YytGdJadf2vuP+Bre7PdIHzPx8hY5EoTwdC4mJWMJ/CAWXWiWP8BtUxUkgzZB8Pn
 CrW9qUfVX6tYibb5N8R047G5gnRJ4ZKZdPqe5H18vUutRJlBSedmzVCfRlOHGWl2osktFQlem98
 4L1NkBVYZKLd83NQGhM6pskgTW5J4/JypLj8aIselQrwWaPkS1bJy8O0b0Z9GpC/SZ0U+tMhNku
 W9B8bSVXS+idoATJgFRcisAtztgQgvUqkehNqaKjMVbuEDqaKwVyFf5+6PGwtc404q0CYqXKS3q
 cFUaz6RhZZjWA==
X-Received: by 2002:a17:90a:d403:b0:35d:9560:3efc with SMTP id
 98e67ed59e1d1-35e427e6277mr13965107a91.14.1776127707746; 
 Mon, 13 Apr 2026 17:48:27 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:377f:61ec:6edd:e205?
 ([2401:d002:dc0f:2100:377f:61ec:6edd:e205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35fc2bc5575sm634015a91.3.2026.04.13.17.48.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 17:48:27 -0700 (PDT)
Message-ID: <3fc005b6-c4c6-47ec-944d-42b7d63e9d16@linaro.org>
Date: Tue, 14 Apr 2026 10:48:12 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/27] target/riscv: Register target_get_monitor_def in
 SysemuCPUOps
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org
References: <20260414003001.97571-1-philmd@linaro.org>
 <20260414003001.97571-17-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260414003001.97571-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 4/14/26 10:29, Philippe Mathieu-Daudé wrote:
> Rename target_get_monitor_def() as riscv_monitor_get_register_legacy()
> and register it as SysemuCPUOps::monitor_get_register() handler.
> Take care to sign-extend values for 32-bit HARTs.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/riscv/internals.h |  3 +++
>   target/riscv/cpu.c       |  1 +
>   target/riscv/monitor.c   | 11 +++++++----
>   3 files changed, 11 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

