Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60799103D958
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2nqy-0004s5-Ox; Wed, 18 Mar 2026 06:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2nqr-0004rB-VU
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:10:11 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w2nqq-0005CT-6e
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:10:09 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43b47b95a77so2211193f8f.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 03:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773828607; x=1774433407; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3vK5xN/X3WGliUWg4AD991r4Wr2GK0P8FJz7TTAo808=;
 b=lfahO/YLe1PQoE7AjhvJbRq3WHIlIY3VBIQAO4iLpMSzRNLKSK20YKqzs7pJNnZJ1c
 KLZIBkQ94rpSyMmwQJIls98+M2QBmzPfYc7bEUB9bh8Co/pvDmiKAGHdKEV52FR6xVSC
 JtZ6HOcnlzFwWWlACeE5RdOhGwYWrCGqWS35BgxM/z0c8/2s+yUfyWeK6VE+fdCSJWRd
 JqBOaW/vlt9RILdFCXK+0dAi+lHR8LJah2ZW3SWmWWeW+SOeqQZdLThr3fxYmn8y1mnu
 ghRC5wAoeVm86JLVAySpQLcCzJVP9iSh+OnyDTc0lWyjUw/KTif9yo6EQKYNfsCNoU3b
 I7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773828607; x=1774433407;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3vK5xN/X3WGliUWg4AD991r4Wr2GK0P8FJz7TTAo808=;
 b=lEu4bcaQUt98GxTPRCNqRDOVUmcfpZnC4FJbbc5OYN35EG9AIubzbYG8XeSW58g4Fy
 xZGyTs4jndiW6xGaA47Xa1rb/iSz4IHBRo//mYQZQkx/Pdmpsqi3yU+fa3n7k2Vos/Y7
 CojIURsqSj6214TxHe6PARmQMZ6O9hCK8bCW5vKt6M+479M5A4tGPhVOL+NOqhEnuk4D
 WpNddYT2b5PVvZy8R1vTB9vQ4W/H5m+S4nlU3OVB2qe/xV0VacXGCLiCPH9AS4H/LYYZ
 71zcCKWi4FlqHkIazq6V+K8dPeiwnSSwwibY3Q+eS1YG/eZu0Y1bYp3QuteXVD5cd8eF
 TpEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8Bg+XLAsxa6h2/9hGc028GW9iRyXFvnjA8zAUgOStad4f2DAYppQs651qxab2p8cOITfDU6CG6aas@nongnu.org
X-Gm-Message-State: AOJu0Yypf7U+XwQ0Re1FRon8GCQPIB5RiUE1qIZkm50Vv7eeSySlZGbw
 sxLhwf8OU4B4nD4mMyo9hUTZ9l8ahbG3DRC/Pdj8BkI15ZOJrU49DZTKxdrMccmJ3jw=
X-Gm-Gg: ATEYQzzHKf3wpaWH82cIjAQGZPZVd27z9BrTdPJWc4WCUVDDMvwMNxop09BL5wfLene
 QrbyToQxqlFwtcNA9jfTPHRFw5YRnph9GzVOXIBlvZRXAPn9sS3OFxYkK3Lb8UIWxvQbZd3U2p2
 Hu/DTVZ+Y6syw7S//PgisFwExe3CqvUozw86NCBIsfsAUFp2ken7Lc6FOqk0lkRwDp5zJ8yiWHS
 L/6VDIhbahGicU+NY+KiCgX+yInA43YEfnEmpAIqjyXwq6+FsAPopM8PGC4ToNOV8G/R1Th/JAB
 ODmqbqHmvzlyEn+oAnwRGhPXpW5B0koKaVVMRRsFkZ8PVE8I6U8W/WPRivmNPucd/RKP1RIs1R0
 AeyMHboASHdqvaQz09R0wg4H0BC+rx+aniIcwXgsufJqXp/GImVvHNszztYrwh6u8RJ3yICktHA
 NBegZw7gpEwZPknUvSz2JB/L6GrCKHXoOjhcUtrkbIKTUA1Z9Oq56hTxqiMZcmenV7mw==
X-Received: by 2002:a05:6000:2409:b0:43b:446e:dfa9 with SMTP id
 ffacd0b85a97d-43b527c40bamr4961745f8f.31.1773828606625; 
 Wed, 18 Mar 2026 03:10:06 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b518a3dfasm6075402f8f.33.2026.03.18.03.10.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2026 03:10:06 -0700 (PDT)
Message-ID: <a70df26c-ccd1-4078-97d3-5cc24f19df34@linaro.org>
Date: Wed, 18 Mar 2026 11:10:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] riscv/tcg/tcg-cpu.c: Remove mttcg check for x-rv128
Content-Language: en-US
To: =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?=
 <frederic.petrot@univ-grenoble-alpes.fr>, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260101181442.2489496-1-frederic.petrot@univ-grenoble-alpes.fr>
 <20260101181442.2489496-3-frederic.petrot@univ-grenoble-alpes.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260101181442.2489496-3-frederic.petrot@univ-grenoble-alpes.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 1/1/26 19:14, frederic.petrot--- via wrote:
> We had to check that mttcg was not used when executing QEMU with
> -cpu x-rv128 as a single 128-bit access was done as two distinct 64-bit
> accesses.
> Now that we use the 128-bit ld/st that access the data atomically,
> this check is no longer necessary.
> 
> Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
> ---
>   target/riscv/tcg/tcg-cpu.c | 10 ----------
>   1 file changed, 10 deletions(-)
> 
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 440626ddfa..15d39f9912 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1305,16 +1305,6 @@ static bool riscv_tcg_cpu_realize(CPUState *cs, Error **errp)
>       }
>   
>   #ifndef CONFIG_USER_ONLY
> -    RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cpu);
> -
> -    if (mcc->def->misa_mxl_max >= MXL_RV128 && qemu_tcg_mttcg_enabled()) {
> -        /* Missing 128-bit aligned atomics */
> -        error_setg(errp,
> -                   "128-bit RISC-V currently does not work with Multi "
> -                   "Threaded TCG. Please use: -accel tcg,thread=single");
> -        return false;
> -    }
> -
>       CPURISCVState *env = &cpu->env;
>   
>       tcg_cflags_set(CPU(cs), CF_PCREL);

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

