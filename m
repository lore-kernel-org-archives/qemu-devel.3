Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A33C0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 15:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taGaG-00039r-4R; Tue, 21 Jan 2025 10:54:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taGaE-00039T-Gq
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:54:30 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taGaD-0001g2-3Y
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:54:30 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so128543215ad.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 07:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737474868; x=1738079668; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7T7Lo+NWflz8c7dlsBgFML2crFfO9+i6EFhjEijDDbI=;
 b=FOVR9ClfI3Bd+qGWPkXz7CTqOhFydFA43d65kanWP5BEk7uQ1HX9zDbIUsBc2p3rzl
 ZL45IaXMsshH+Zd1HU4s4EWHjrNm5/0wxU4/99vUsiYFJmVsru/q2sAgHKJf9kd8l5Ir
 HO9TGfYxR0cmuQ1buswAeahsIAoKRU6ZSwYCmfxnv00FJZdRLZ9DxI7hrABnb0WRtQWn
 A4hx1UrmKSkGTqJtO8e/BaIVMhj1a9iA3h3H09ZnIDAVy9Job9CzpInm6O6iv7U6VkiC
 /XNixOHl8a3u22uwhFOnULB5zWW56TWNCgfXL8BoW/ihbm462RfK2jdObuRnQCF3z4LV
 UfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737474868; x=1738079668;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7T7Lo+NWflz8c7dlsBgFML2crFfO9+i6EFhjEijDDbI=;
 b=l+ge+XHRuApKSlq28035zYhxeG7NVKfPFT0eSV7cJg1X2shWOWxnW8xotvUkWhGYT5
 YJkyp2XNoWst4r4ploC34PbdG8WN+RLRJEoR4uTdvuDYVa4WxKm2VwSh8p17d5j0Bb0P
 sXGl6OjUMbEmSlzljjrrbdynK4s6Pj6L97oj7Swzh9JizAtjTVI3OD4EprT//0QqihaF
 Uh8+CJ80001OdsNqxMlaQyRIhd4P1E5oDWEOT6O0qsp7apcZSzfZY/jJzu3fHSJt5TNd
 sD2GCjpEcmINK2c5M2ntHtTaOxSHxPv5i3j55zlO/2uzdzWoSdwwjQL169ELxzkbgvQ4
 AcpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWK1MJs85diH9XAoj5ibXNPdfyGroqFknTzN21gFgkhN0kPS3SVmrsgpX+3MEW774XlSB+KlwfwTeBh@nongnu.org
X-Gm-Message-State: AOJu0YwUkyRH82YndTap97JamaK2OCFRr94QDQym1YIqgUjBS9ZgfRqU
 fI0Oaq9s3eLyZVJijl6oDJRpmEKnXOzXm5X4D02l/c7KWxoFXkxH6ltbjoxyP9FP9eXqV64ew7v
 G
X-Gm-Gg: ASbGncscy06+VW1igI4xQXkUu6uiBD2ZU4tWa/ehmI1TQMnDgRGLpYYu6BEYVoxmiAc
 gosmRpPPs87Y3gFRqGvx8Mt9EUmgiiw/ffFJ06DHuZC8VVpSiLNFSXwoGQK6Z04UZjj8mSzjEVb
 myHdwmmGd0ESJFOlyc+/W67Rh5LRA1+D8fsuYmFyrnPP41E35BpnEro31bwnhP/T8cKmqF1igMp
 t5JuxoOeNfW1By4jiBnLBPpCkc9MjRO502J4feCDu3VXExZUc7OZftckxLCm7nDQQNZFgMkw3Vx
 UjbyOINr+apQab6wuLc3+47lgKs6FQFR6CzJ
X-Google-Smtp-Source: AGHT+IEo8Bx4nU0VT9Y8DFX78+JCD2OxkjMunLwg8Wl4r62vj65l9qrdXRAMOz2bwhV9ksrG1HvkNw==
X-Received: by 2002:a05:6a00:66cb:b0:727:39a4:30cc with SMTP id
 d2e1a72fcca58-72d8c46e973mr35040674b3a.1.1737474867697; 
 Tue, 21 Jan 2025 07:54:27 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-a9bcfb92d9fsm9057698a12.46.2025.01.21.07.54.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 07:54:27 -0800 (PST)
Message-ID: <e819ed08-db0c-4c6d-a70d-38f17b47846f@linaro.org>
Date: Tue, 21 Jan 2025 07:54:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] cpus: Cache CPUClass early in instance_init()
 handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
References: <20250121114056.53949-1-philmd@linaro.org>
 <20250121114056.53949-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121114056.53949-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 1/21/25 03:40, Philippe Mathieu-Daudé wrote:
> Cache CPUClass as early as possible, when the instance
> is initialized.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   cpu-target.c         | 3 ---
>   hw/core/cpu-common.c | 3 +++
>   2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/cpu-target.c b/cpu-target.c
> index 667688332c9..89874496a41 100644
> --- a/cpu-target.c
> +++ b/cpu-target.c
> @@ -134,9 +134,6 @@ const VMStateDescription vmstate_cpu_common = {
>   
>   bool cpu_exec_realizefn(CPUState *cpu, Error **errp)
>   {
> -    /* cache the cpu class for the hotpath */
> -    cpu->cc = CPU_GET_CLASS(cpu);
> -
>       if (!accel_cpu_common_realize(cpu, errp)) {
>           return false;
>       }
> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> index cb79566cc51..ff605059c15 100644
> --- a/hw/core/cpu-common.c
> +++ b/hw/core/cpu-common.c
> @@ -238,6 +238,9 @@ static void cpu_common_initfn(Object *obj)
>   {
>       CPUState *cpu = CPU(obj);
>   
> +    /* cache the cpu class for the hotpath */
> +    cpu->cc = CPU_GET_CLASS(cpu);
> +
>       gdb_init_cpu(cpu);
>       cpu->cpu_index = UNASSIGNED_CPU_INDEX;
>       cpu->cluster_index = UNASSIGNED_CLUSTER_INDEX;


