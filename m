Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D06CD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 06:16:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtiIk-0000XE-RX; Mon, 08 Apr 2024 02:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtiIh-0000WN-BA
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 02:16:15 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtiIf-00078l-Px
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 02:16:15 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a519ef3054bso323028766b.1
 for <qemu-devel@nongnu.org>; Sun, 07 Apr 2024 23:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712556972; x=1713161772; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BP3T5zLQvx9D9wEUd+ieh23y29+UA/ohzfRqaFA2kCc=;
 b=Hyi9FUrgrWJ4f2YSkZiLgBtqGd/vOiBCrlRq/9zKwE4sG1HZdTaez83A1ybuW2gs5l
 KSLf31NLdUHPHzzaZwQu7CtMHv39SmrSE6dg60M9v53gq8eqr+3AbMktbo5f64zezqhg
 tOe1eOhwD/bK1oEU9dD4vN6B0tVvIDrAS9WlSTzOHG7Nb2GCvIJD7BrPRYP+wJ1+Cfs0
 jNQzZgXe3g1sssXR+PwZTgv1dlqmZ/ahC9oIzDf4GTDexqyMNfm5cy8h4jZBaDKxjQgQ
 HPto03ysInDqQ2hcDNVIhxY23wXltyOFBuBO+lcxM5Ro5zZioflNOHPEeRA206y4jwMj
 TyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712556972; x=1713161772;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BP3T5zLQvx9D9wEUd+ieh23y29+UA/ohzfRqaFA2kCc=;
 b=ctXYwh+CT5AOl1JWR60LvyW+etiahVD+K/UNvkoC803ZqZnO4NWDzKr4YFRsPLjFvU
 A3NLdCo3qgLWYcygInCfvXJ5frerKGK9LwV5+jtLKvMUowYnTHpT9crZ54Zb3RxhuuD8
 SbONBnp7U3fGO8A87E3gCl5XfWeBarN/XE4mayu30I3Y23YGa2XblfVV4Qcva+Ritzvc
 bDelB4UTjuhTiDLooQrc9pBr77/tXImmt5lreopdEvUXvsKe70hWYgEjuncZipy6zePR
 OmArp4HQsqGDr+UfdZU31O7/YTcoEF/3jOOZXC0hR/Sf+NR0LHb4LULdylBxPYanHdl4
 P7pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFZ7JvqHLlJBDI/ucPT4RWr1JIXoFZx0VothVXDhiEkzwEg6QBTAVabJKLPWWScU/Z8vhR6zQwO+BFI5QWl/2wsxiTceM=
X-Gm-Message-State: AOJu0YwVZLaNEW4FWi4izeP0n8A31Yw3BqeSx05J0r6F2bZoKjaz7Txt
 gyM4uvixLTFs0mBoo2rhuQWOh/X8qDShWfD6BW9GJHDTc2WxXXSF3cTliEP6ivI=
X-Google-Smtp-Source: AGHT+IF+A87cOu+9L+HMSFwGXGp7NkMUxtfDHrU9kE9Rcy7VZKOFMm3QegAyxQgOMPJCbmMUiNp7WA==
X-Received: by 2002:a17:906:f584:b0:a51:dd18:bd21 with SMTP id
 cm4-20020a170906f58400b00a51dd18bd21mr587988ejd.16.1712556972078; 
 Sun, 07 Apr 2024 23:16:12 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 og15-20020a1709071dcf00b00a47423b4c33sm3991025ejc.128.2024.04.07.23.16.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Apr 2024 23:16:11 -0700 (PDT)
Message-ID: <c50e346f-1cfa-44b5-a1da-34a0e190162f@linaro.org>
Date: Mon, 8 Apr 2024 08:16:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] target/arm: Use insn_start from DisasContextBase
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jorgen.Hansen@wdc.com,
 Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
References: <20240406223248.502699-1-richard.henderson@linaro.org>
 <20240406223248.502699-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240406223248.502699-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

On 7/4/24 00:32, Richard Henderson wrote:
> To keep the multiple update check, replace insn_start
> with insn_start_updated.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate.h     | 12 ++++++------
>   target/arm/tcg/translate-a64.c |  2 +-
>   target/arm/tcg/translate.c     |  2 +-
>   3 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


