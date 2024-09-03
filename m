Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E450FCD343A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 14:06:54 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slU6x-0001TI-J1; Tue, 03 Sep 2024 10:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slU6g-0001Qi-6V
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:02:11 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slU5t-0006y3-NI
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:01:54 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c25dd38824so1863112a12.0
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 07:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725372005; x=1725976805; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iyhyKKNbAioC/v2WSZKWMCCWw4390pMeuUWRxAfiFew=;
 b=rSbDGquA0Q+mOAzhJjDtIxtHCdUo08TmIl94OSrzb/QFVVqHblIF9c0kdOOBhLF9ER
 M0/IKfWv1flFufrnljOPIde+zqvBzkJR2xZKSRQGOe4DbfTyaMG1/nrwnll4aTQKRy45
 QMq2zr8tJ2X7P1H1DBA7hoXPc/2MyTLA/f4sa4QbI47+Q2qz/FEXmcbFqoNlv+CFNqwP
 VzKRA4QK7oLQcN8dMiHlJVUiawF5+/pOUNBaGtaBm4f+rJEEdUY4A4IuoCovPBKvBuzv
 X6J4xJcqlt0p0B5Z5QiWNrX2VKvi0xB0EiVYBqP+BtP4g04lswykgi+8E9I430lygQ2v
 eZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725372005; x=1725976805;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iyhyKKNbAioC/v2WSZKWMCCWw4390pMeuUWRxAfiFew=;
 b=JjYt5h1estT73fC9Bp/p0UaYXlPrheHSRPnV+dUvQnlqRXZmSpf4H/Km38q4/jQEN2
 i+rzcRVJLrQuVm0Zi4Wz1SZd+HEQ5sEVIKvbYXVWbvglAcluqsJ4AuED3vg8vyM+bovo
 7wq1uPWFMTmbbAvE7OaQtHrYNGcgIa9jqWqs2Pc7BpTc/dCC7m7u+6yhKafQHId7nPON
 NvR4kpDRBlpM0QNMPMrWZYJkyXYpjMWTJSOiR4vlh4cRQCrHnNmNZjJh4gTawpyxoDka
 kunSMRahRmVrq6vEmX2p9J/NImovmXsUdG9XMw99k0CkES/8y6JRIIPOghLYYEBoMZ3E
 JO5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcGeowvzeeujYgwLKdFhdHzFXAXh4wM9gleuUr+hMgaU41Ex2OJZZDMg9vVpBYVz28BIJZLKyoNu3v@nongnu.org
X-Gm-Message-State: AOJu0YwjZIBfnwP1JTt1GSHtil4XDxmPLtxEVe46PMIvF0fjS5N/R7lC
 8HQB447yLPkQKa+RLIfWBgw/bePAYsYNiXuDT7DXqiZj7D58ahC+LqXZq1/JLYY5RfojMjBbtWA
 H
X-Google-Smtp-Source: AGHT+IGxVnvqWywdrEidL9GTA1YPkDZTvG4++FPn4Dbd5jxG+KXUMpKIEeb8U8AEetk5eN/Yri8Kfg==
X-Received: by 2002:a5d:6190:0:b0:374:c7cd:8818 with SMTP id
 ffacd0b85a97d-374c7cd8a12mr4630236f8f.22.1725371552637; 
 Tue, 03 Sep 2024 06:52:32 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374b6f7ef8esm11309329f8f.8.2024.09.03.06.52.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 06:52:32 -0700 (PDT)
Message-ID: <cceb62dd-742c-471b-8b4c-6bfc304d4565@linaro.org>
Date: Tue, 3 Sep 2024 15:52:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/arm/boot: Report error msg if loading elf/dtb failed
To: Changbin Du <changbin.du@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20240903133940.3447430-1-changbin.du@huawei.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903133940.3447430-1-changbin.du@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 T_SCC_BODY_TEXT_LINE=-0.01, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 3/9/24 15:39, Changbin Du wrote:
> Print errors before exit. Do not exit silently.
> 
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> 
> ---
> v3: use load_elf_strerror() to format errno.
> v2: remove msg for arm_load_dtb.
> ---
>   hw/arm/boot.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index d480a7da02cf..6c895e05cbc0 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -839,6 +839,8 @@ static ssize_t arm_load_elf(struct arm_boot_info *info, uint64_t *pentry,
>                         1, data_swab, as);
>       if (ret <= 0) {
>           /* The header loaded but the image didn't */
> +        error_report("Couldn't load elf '%s': %s",
> +                     info->kernel_filename, load_elf_strerror(ret));
>           exit(1);
>       }
>   

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks!

