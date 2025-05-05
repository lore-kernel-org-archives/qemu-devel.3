Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2AC0CD5BD0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 15:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTLYU-0004Pj-K9; Sat, 30 May 2026 11:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTLY4-0004Ie-5Z
 for qemu-devel@nongnu.org; Sat, 30 May 2026 11:24:29 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTLY1-0004yH-FN
 for qemu-devel@nongnu.org; Sat, 30 May 2026 11:24:27 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-45eedcdaeaaso1776592f8f.3
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 08:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780154659; x=1780759459; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lxhLTXmJ0AJQAwAnZJU2eDKfxi5IxqiJLmQpm7J5aNc=;
 b=EMjwue4B1fwo+Odzkkc9FVHh8LckrY1zgqGseBv6EhnRg3/b5dKuCPEU4DQ6SXhV/i
 KWo0dFgNsLllN2myGrTRmyG/54zgdn+sp7xlw0MXA4xXkX+cPX3HOSwoFWE+Sf7GNVC0
 jfbkwbLID8ZUJIvA7sXnHN8s/3Y0z128rnQpmFjyyuOC6aHnviY9a1wgVmFK+nmB5XjW
 rURj/NR+DCvhP7gH61T08HZbuhMBzqgnUIe11ahGd99yaUy+dOQ+zEuBmVgwMncVZiUp
 xKIBQkLZWR9xI9mJ2KGwD0iC2Ffn88qsh9+zkIo9NR1mDuyQMvNiAmK3Iet6eUwwcULp
 CYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780154659; x=1780759459;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lxhLTXmJ0AJQAwAnZJU2eDKfxi5IxqiJLmQpm7J5aNc=;
 b=mm/o/UFnP5X4bGgmXypA4uTZ/AH800+qRC6XwVwUhTlEmSXJl40HsyvjfUDJYpf/nk
 2lvM03UewbKSWijohpSH59gbrJQO2ROf28BqVZ9DLjWpX9MPNMMu8wFeW9yWoH3b029O
 Y0xj0pSwlZtQ4YUNPvbpOWCm0LNathfnU/Rnz+cVu2+8ghN1EP4tHeFoRnJ7EUMs63g8
 KIVzC5cQhzZWiIcmtcPHWJg7NUjICJgdOk9JKHevj04/Gc1xCTO8HvVBY7KXN+OWkb3T
 hUbPN6AULriRXaNukgfavNudm7veM1546DR4vvilYTbpfwSsRdI6ek4qXdhxLQUl1spw
 yGcA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/DRzuI6VCjptLA+bBROsWiRXbR1ZOedYaBNeoJjoa2wVgXuccAE1kzNbBRApKpgXXRS9veh5t4IDCC@nongnu.org
X-Gm-Message-State: AOJu0Yxgvb5rM1zbXSluip7A7zrozkb4kbE9NrIbIDb7OyfRJL+KJ1Oj
 JaDmck4w3yb/guIhgAY3JiqaMvQbiHslgBebPLkDtj42IuJuUAA6ggWeYcSdHlRCRDG0ua7aY/6
 qHf3CQT38Fw==
X-Gm-Gg: Acq92OH3eh/0j7tDRAO4cxVd0TyFj/gkdj42WVLQgg7+FSt4ajgCDk0D7rGWrMdZ59x
 dKqdEED8FjiRCkT5tAgib9OHVCuOP9/X/oTnHFAzj/4b9gPytm0DpGlb6mitYgLE9i8Yrp8wT26
 Mod8lqfTcANkO0QSoSYNF3VsaGBGM6dnsLxwFkiAmaeT8vCwbgcEX6hP+gRZwuGKQJwcYzKN9oD
 NHLYfOTUgkd2HG6IINW/CxQvugwsXM03CzreIp5qSdGa8xHz+SuXjFmA/28ulLZ2kW6vsCHaKwc
 iwJPolRyYu/unBuXrn8ehtiJfqmM4bkdS75frrB9U7IREWfl3MqpWueQGnVvtqgeggB0pdKY6I3
 auLp8YOpE9pjVg9Zj7HUOaJwdb8mSOUbOLGYrwXRDgjOGalnQ51bHLbtFLm3j67qHm9VzAnRxaE
 k1DLXKtCQkvkRmK7ant+8vrHrzuFSdXJviuJxVuoTelS4yvl4DQacL3mhWkqpTu9n/4vje2efeF
 Awn
X-Received: by 2002:a5d:4a81:0:b0:44a:be4:d0e4 with SMTP id
 ffacd0b85a97d-45ef6b536d3mr5569965f8f.25.1780154659615; 
 Sat, 30 May 2026 08:24:19 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef34b47eesm12638888f8f.9.2026.05.30.08.24.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 May 2026 08:24:18 -0700 (PDT)
Message-ID: <a38648fb-35d8-4259-a44b-e3b31ee2318d@linaro.org>
Date: Mon, 5 May 2025 16:30:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] target/mips: Fill in TCGCPUOps.pointer_wrap
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: foss@percivaleng.com
References: <20250504205714.3432096-1-richard.henderson@linaro.org>
 <20250504205714.3432096-8-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250504205714.3432096-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 4/5/25 22:57, Richard Henderson wrote:
> Check 32 vs 64-bit addressing state.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/mips/cpu.c | 9 +++++++++
>   1 file changed, 9 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


