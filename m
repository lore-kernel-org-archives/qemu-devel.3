Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFEEC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 10:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMPci-00038l-RW; Wed, 26 Jun 2024 06:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sMPch-00038P-8b
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 06:11:31 -0400
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sMPcR-0001lY-QS
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 06:11:31 -0400
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-37636c38d6aso18043735ab.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 03:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1719396674; x=1720001474; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DjiWWnM1hfvZbOjlqPiz3jEFnnZGaZ5yXq21OIMhuJA=;
 b=e3cJGjb/TFJXmHtfjxgYW54XFOfGsdIGSYUgI/BAIJeotZf29nrI3cpvYTneKdUZu6
 MuyzLJ4BUYTImj70BCgUc1sRmgIN9jypZqDITAuRsRzXDGxzUm6bg7NcjWw2frvA532Y
 FxbZzG7WKqPq0i33GQz5cNMp0NtOVMdgv1xbV6T9ZMQhWp4iKVBvFX/mnwwEjGPhqZVX
 B46PrNw9y3huCFN5VWwdz2+jBhECs3CPbwYK23/LDK72nd1yhnu+5MrMSTlc+o3P5j7o
 SyVL8bDoemqDki8Jv6yLxW0RrFtoDpuNbez12Ekxuki0166ollGk8XX0yWi3ET6r3dmI
 toRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719396674; x=1720001474;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DjiWWnM1hfvZbOjlqPiz3jEFnnZGaZ5yXq21OIMhuJA=;
 b=WRgzZs43aDQ/PfZX8lti4cQMm0KhOiGwmlYm9G7SsxYYRggGL3RK6mZf1FZLvhsBjA
 QcgGTdEmiIFuavl1M4bdgFZqPGgNLYJfLH715BydOI70F3Mas6WuhnChFRBx8mKEEtpS
 Da5YiJzwZCWyJ9Z8YJmWtfm3a08aMqfVDq9EGlcDOS9AWFzxvMCNuyj81tayOrFd130x
 U756npG9HMfEqCEi3Sztt8tesvfF5oUHFcfuG+tAdPJunVErmxkG3euVkiUHeLNNsebW
 YPtn1PFL1b7zINUHeNHA0/NZuPVDZtmoEl3Kl+nbYJXofQ2xfM/qSACqUp8a2m2jO07A
 Wxcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0mkuhCJ1HilR1ilOVLk8WcSRQbBoPe2XVPp1bc3q/n69LmUsRUYMjBnN7NrYeL8wWvljgEoWeb077dIAHukPKkpgXCcY=
X-Gm-Message-State: AOJu0Yw+xsjV0xFgXo77Yy6UPF44yPrT+UDEeKWcfb5LN02UNGLvtQqy
 m52qsANVbIzgs3ZkrAW+dwpJAQTMcRocyY9Twp/LS1sjITFlWg6Vz4/5nl9/cXc=
X-Google-Smtp-Source: AGHT+IGNjI/c0gGiFMVYbC/+u5GmcntuDmGC2ltRRqadpfeZkIP0/aQY0dCifgsO6Btd1/n1FKZbag==
X-Received: by 2002:a05:6e02:1568:b0:376:1fae:4635 with SMTP id
 e9e14a558f8ab-3763f682e99mr134939565ab.24.1719396673840; 
 Wed, 26 Jun 2024 03:11:13 -0700 (PDT)
Received: from [192.168.68.109] ([179.193.8.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-716b3ee7d8dsm8526250a12.25.2024.06.26.03.11.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 03:11:13 -0700 (PDT)
Message-ID: <d2878e19-4913-4a67-a3da-7e2165d357d9@ventanamicro.com>
Date: Wed, 26 Jun 2024 07:11:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/riscv: Fix building on OpenBSD/riscv64
To: Brad Smith <brad@comstyle.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <Znu-pXYjX2ImMUda@humpty.home.comstyle.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <Znu-pXYjX2ImMUda@humpty.home.comstyle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-il1-x132.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 6/26/24 4:09 AM, Brad Smith wrote:
> tcg/riscv: Fix building on OpenBSD/riscv64
> 
> Signed-off-by: Brad Smith <brad@comstyle.com>
> ---

Please add in the commit msg a short description on the problem you're
facing in the OpenBSD build and how this change fixes it. We want to keep
a history on this kind of OS specific changes. There's also the possibility
that an alternative fix might apply.


Thanks,


Daniel


>   tcg/riscv/tcg-target.c.inc | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index 639363039b..aeae9a8ad8 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -2116,7 +2116,12 @@ static void sigill_handler(int signo, siginfo_t *si, void *data)
>   {
>       /* Skip the faulty instruction */
>       ucontext_t *uc = (ucontext_t *)data;
> +
> +#ifdef __OpenBSD__
> +    uc->sc_sepc += 4;
> +#else
>       uc->uc_mcontext.__gregs[REG_PC] += 4;
> +#endif
>   
>       got_sigill = 1;
>   }

