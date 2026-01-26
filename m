Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02ACCD19510
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 18:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkRT7-0003lt-ER; Mon, 26 Jan 2026 13:37:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vkRT0-0003ht-S0
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 13:37:42 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vkRSy-0002Ss-Jy
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 13:37:37 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47ee4539adfso52540915e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 10:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769452654; x=1770057454; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ipjvv4ealaSFnwt7TF94L1J5CHp40keYTo5K3NkfoNA=;
 b=WjZr88w7RyedHHyJd+oXD3nx6zqMCq3cYXSHjnn/5dg2YBfIKxkl9pW/3y5HI3oEYB
 bd/jcnt6TJE3M8qRxU8Z1k/7l/CzFBe8WK1N/r2RCPxdApkUX5k3YehkfhoQDQc/6RD+
 f+MYK+OqtbBYUSz/aKwSsOi/rE3rBkWbKqWgURi79anZ1oOcUiu3wUAaijxYWFLJ5En9
 q6/Q5o3u7Eh5TTZLvIU6vhY3xm40YyEs8V8NrQGZS8vfs+KptrGHXtx3Otj66vp4PjoC
 vbngfhyz8G7+JLCP9RWLaMsi8raFgE4rc46oMTvQLewZxyEFcYtwLNYQ4QiniTADNn75
 zhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769452654; x=1770057454;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ipjvv4ealaSFnwt7TF94L1J5CHp40keYTo5K3NkfoNA=;
 b=ct+Gz69oxieou1FLc4BUuWIYwwZ5KF69P7hr8Ls0m+lDGx1/5itAfPFIWDi82lN3uR
 uglOJtuDx8C8rIIZTjPfgH31JM1WLdql/qgm2Cfs8rOYQEefpoyWWEtX0uXGFmWG3iaR
 Qf72qRPI8cixtvQP+ZTzf1ouDiWVP89QLreYCsLeeTC3bs4V/onAHVHeFzr7+ozu9LK2
 7WFVILQpJEIYOLtD4T6Df7UUZuBmdeJZYK47dKbVHC0bvMnA6MSSQaJwrW1+yUHq7Jkj
 CJdNnK0D5mXgTMo0y9dMaQLKDehYC/99PR/fOCAZHS5kjBNlC8ZS5ftHBkmkdYgMxg/D
 CWNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8vpZLXd5fEUaJ+2JgPHJ5Lhr/F9AqTLAiWeb8V2C221Jf13Q4C1TaVAkbAcwbyYs3UcGBWuuTEx9m@nongnu.org
X-Gm-Message-State: AOJu0YzzmRen9LU0N51OPxJsevH5AEb7SeKg3Xf0XjJ06kChm9ToPDJ1
 xfxQKVBWClbAPqpk4CexsuiCACkOZvHAhhxyVuhts3mTx7uQCkrc0Mqm7ray9pSgQ+c=
X-Gm-Gg: AZuq6aJcLgkMDp33UxLa5kpM/DxUFNRwplymCmyhti08el3myVN30oHMGbiwKwCDUCa
 4wMa+rKuIBkx4THt26eIWeL1zCjQbgyduhGf6tvB4OhmdEnd+8dwztFFQPFc/z53NyD0mW9tbV7
 D6g4mE1spVtFt8r2jf/EfaXjv1a9R7I1vfmxLZAQiBKRYIvw2tvZ6dk85cpkkSE+yPzzAno4h+B
 85o4caJAsYz0vA7h2ORao9BLzx+l92jWJh6/J9RD5B8QYcSiLUUllF4bY7Rzj320osspx+d1wIP
 DMZeczm13GGF8E8rAfE0fAnBUhgKeXOk/eV3IbGb7q4wiD+TSzRFtN09/gZHasoyUMpTkXT6rHd
 z1KTTS+SLKYfa1QwOyDSVrNx8B6SjpDTLrY/6RTiHM72YQaUDS4YGjF2+5Eg/yhdbNxGxdWnNeL
 ogMvsllEpHtfLzuGhvDv2lH5WRMyckQM1M7MDMk5mee9MQ+FdZCvQbUQ==
X-Received: by 2002:a05:6000:184a:b0:430:ff0c:3615 with SMTP id
 ffacd0b85a97d-435ca13d0e3mr10597940f8f.53.1769452654386; 
 Mon, 26 Jan 2026 10:37:34 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f745dbsm33173927f8f.34.2026.01.26.10.37.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jan 2026 10:37:33 -0800 (PST)
Message-ID: <6d6ddb69-692a-46aa-bbd1-825249df2e05@linaro.org>
Date: Mon, 26 Jan 2026 19:37:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/adc: Fix out-of-bounds write in Aspeed ADC model
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Elhrj Saad <saadelhrj@gmail.com>
References: <20260126141820.719492-1-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260126141820.719492-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 26/1/26 15:18, Cédric Le Goater wrote:
> The 'regs' array has ASPEED_ADC_NR_REGS (52) elements, while the
> memory region covers offsets 0x00-0xFC. The aspeed_adc_engine_write()
> function has an out-of-bounds write vulnerability when accessing
> unimplemented registers.
> 
> Fix this by using 'return' instead of 'break' in the default case,
> which prevents execution from reaching the s->regs[reg] assignment for
> unimplemented registers.
> 
> Reported-by: Elhrj Saad <saadelhrj@gmail.com>
> Fixes: 5857974d5d11 ("hw/adc: Add basic Aspeed ADC model")
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/adc/aspeed_adc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

