Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F14DCD4F3C
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 07:20:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOsGC-0004t6-LA; Mon, 18 May 2026 03:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOsFz-0004qZ-Cg
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:19:19 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOsFu-0003N9-W3
 for qemu-devel@nongnu.org; Mon, 18 May 2026 03:19:17 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso13305795e9.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 00:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779088753; x=1779693553; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ub5R1/ef0Ryx4jMHZSqHnM/R6jS4gXRpo2qb1MJI2mk=;
 b=tuZAxP6qlwiTittF6vxgRp1fJjGA+r7Dn1ojO4xTjs3rX965yr4Ng9EbM/a+jD8DkX
 RwQxiRJeUscy2DQu3IQr10xykzOAHbQCarzcMhgaw0fLIck6vRwV3o8bArAVcQf7pLn8
 goYal0hxJ2ppVv6ZZ5W4EpOdOpzY6rRUu5bD3XB1uYVTeDLVrhFX6IH0Kb6fF9CMRh+G
 yyBWycaIYRrqyqcs/KDYlOZT9uKnOei03K4uH4nGv3hW+AQOq5FIOgzRx8DppXZlvNma
 0snjyoIK1eNTMRiF1xK8Q3g/DwsK/ZlLbG3Ajn1v6jWvg+ozCK7UX4/GefGWM/5ZEZLN
 S+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779088753; x=1779693553;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ub5R1/ef0Ryx4jMHZSqHnM/R6jS4gXRpo2qb1MJI2mk=;
 b=H+DOY+jt4xPIgSd6Kz6jaO1S7HdO58Hdeoivf5QR/nOEPqJi2FUb+20/W2mtPqTwJf
 JKZ8R3Brfo2MuA0Zvose/6YaWZJ8o0gNvbx1Y880z9cw2/+IIC6d3kc6Ge4eD6eMW3LV
 jSyxmeo1MBeWoenuTG70utlEPvgy0gOfG6Dq3/ZW2HUxU/aqDHR6+6qD2ClMigN8pz/M
 aFVlL94UhodVCvBfxHWiBJUtRNU40Va28IiVbZ80upitWwTec0KVfqUmGIVkg5RtrM7f
 xQSJGUuZXzkek8YVKs9Uhcd7Shaiiu154WSLWD6rBgBeIIH8+ENXGAT/Xd+Z6kZFMiOQ
 Nv4A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8mSB8Wkh0obasWDyYgKyeU/QQJzmIjQm7CYkoW/VSfa++XLY2la1P0DlTJi+ifVkVkHIKD2z9pX4Fg@nongnu.org
X-Gm-Message-State: AOJu0YzO1CRiO0Yab90OSITWcz6G/NORBFRIB8hb3t8r/ighmunwNv0O
 3uAGIU6iWaz9ioSHcngEETyX3AWMhzmxnfQfevgmhrLZ2qQdQ9UW5+qRu3jW2Y2Cf9w=
X-Gm-Gg: Acq92OFR/h6IvVE1HebcKLywf29TM+ojRrtkZ+L6XOfI25v1mef7j72mj2V01uW4Klp
 krBQzSPsAKOdI096yvXOyvWhAzSfwlmdQQdwqKLuPgft53LrrrqzdZyD5bmewH6qB0vqz7RbXvf
 6iuneJ/b3JIHZdT8kJ/Eo20VUc9669PQpA/LLREiQXsQxTLC6BrZNjXdryCeL0lyRzTYFijRwAQ
 fRn6UCKQEJYL5HkwhLRCrRPqH2/Sn7LDMLpDe/FQTflpKe9cOXZGbBxrUu8SfbAjBzujvNZQr5h
 ZWK56BR85YgpzljRLukK2HghsNDnrnUL8TAKZvYGXCosubcielirvN6F9kqAaxj1H+wBrEbtiFc
 4666dLRNeZHnHXVOhOL+RMBweeagyBdpgegHnXby/tpsWv3S5jYMeXRNdZVgdhxBtg6T9K7nRTP
 /6T0o0Klno0k/DDo3F2sfCTpcFo+lOBoUfxXcxxK3TFBbwXPaguqkNGb1+uJvn8dXkauNu08Btf
 p8R
X-Received: by 2002:a05:600c:1d0e:b0:48e:635a:18d9 with SMTP id
 5b1f17b1804b1-48fe60da96bmr205009605e9.15.1779088753046; 
 Mon, 18 May 2026 00:19:13 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a19c2dsm36156142f8f.21.2026.05.18.00.19.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 00:19:12 -0700 (PDT)
Message-ID: <3bb15715-b11e-46a6-bba5-46a85c036632@linaro.org>
Date: Mon, 18 May 2026 09:19:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] target/riscv: Use macros for PMP address alignment
Content-Language: en-US
To: Jay Chang <jay.chang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Anton Johansson <anjo@rev.ng>
References: <20260518070725.9816-1-jay.chang@sifive.com>
 <20260518070725.9816-3-jay.chang@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260518070725.9816-3-jay.chang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 18/5/26 09:07, Jay Chang wrote:
> Replace manual bit manipulation with alignment macros for better
> readability:
> 
> - TOR: Use ROUND_DOWN() to clear lower bits
> - NAPOT: Use ROUND_UP() to set lower bits
> 
> The behavior remains unchanged.
> 
> Signed-off-by: Jay Chang <jay.chang@sifive.com>
> ---
>   target/riscv/pmp.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index de2157c830..238c7c5162 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -247,8 +247,9 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
>       case PMP_AMATCH_TOR:
>           /* Bits pmpaddr[G-1:0] do not affect the TOR address-matching logic. */
>           if (g >= 1) {
> -            prev_addr &= ~((1ULL << g) - 1ULL);
> -            this_addr &= ~((1ULL << g) - 1ULL);
> +            target_ulong granule = 1ULL << g;

Maybe better to directly use uint64_t, in preparation of
https://lore.kernel.org/qemu-devel/20260515180437.23620-1-anjo@rev.ng/

> +            prev_addr = ROUND_DOWN(prev_addr, granule);
> +            this_addr = ROUND_DOWN(this_addr, granule);
>           }

