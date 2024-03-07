Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FCAC54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 10:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riB06-0002YB-JD; Thu, 07 Mar 2024 05:29:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riB05-0002Xw-4r
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:29:21 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1riB03-0000aH-O0
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 05:29:20 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a45cdb790dfso70276666b.3
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 02:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709807358; x=1710412158; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eUO1dloe2jvqo9cujxmxE4yBqQSlUVB9jIjPSzL8MWw=;
 b=UYXW3hcQ/D0BqcttTNwYiIhQx6vOMJvJVZWg1ezoVS/2nTQBvTr2YNBC+xgAIKl8mV
 tSvF804CDnE9clyySH/vXhmpm/N9JOSJfkj3ZdIJyYbQVdZwmANU49PlFCWrUJ7EsOEu
 c7e72l8k5Tp/WMNmHXhkmfy4SjYkUs8Xs2N7fJ0635mdfzL8G3xyV4yuiF8vAMeUbbfI
 g/JHXdKq09CjOEe2vEsZhQ1ONYSMD/Byw+/VUwtanpD6puS74g6dEe6b5im28vfGJ2Wb
 UeDYun6exPgYdtFV0uYwY91x4PrCayCF5IVVEg2c6cLpSsxZCNZ/Nn2SNc6DCHzbEP6P
 K8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709807358; x=1710412158;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eUO1dloe2jvqo9cujxmxE4yBqQSlUVB9jIjPSzL8MWw=;
 b=Z0vcDEIh+jPc0w+7hRRllomSE5fyh1RsylBgQGnkfAvDZnRMXJplMXweKB3C3tfAqM
 jVbr2sAjw6a+ZyLz5xmuvKAUuuUSWzA7yUYM2NhbKtI4QlN09etwm1M8noR22ZYEtbiK
 jYJNV+mWWWucrfz140hC1AagJbC+fW2x+e3/wGQeqWEbuKDx/1lP6QU/0WaGEZ5/hWzt
 pSvXS/4W/A/7awqKhm/7itmoZ9vJUEskYI1RSKO5hyOZx+REsY/MCnoUv/Nu8ofhMwAD
 vW0U7WRlJXSI1B8KnN2tO5oiJE8jc01OaLVPKAp3IeygRSYSWxx3m9RLgsT6HGpzJx17
 sIvw==
X-Gm-Message-State: AOJu0Yxf+c+1GgqUXI3sqEmttFGyzzRLYm656tRmGVgS7Dab12kAw/yD
 WG3jV/ym9GUyXJfxDrn9BdwceIqVHP1hFxnVs8ZWpsrGgDz3X6u71nIxe4Vrpzc=
X-Google-Smtp-Source: AGHT+IHq8iwjSVD2jqxmWIHmfANOrVUVNSZpC5tL0AmJqzUn98d8l9N7Qffia/RqfRZ1kHH3Ibnx4Q==
X-Received: by 2002:a17:906:f2cb:b0:a45:a814:1cac with SMTP id
 gz11-20020a170906f2cb00b00a45a8141cacmr5900286ejb.5.1709807358045; 
 Thu, 07 Mar 2024 02:29:18 -0800 (PST)
Received: from [192.168.69.100] (vau06-h02-176-184-43-100.dsl.sta.abo.bbox.fr.
 [176.184.43.100]) by smtp.gmail.com with ESMTPSA id
 qw28-20020a1709066a1c00b00a381ca0e589sm8063136ejc.22.2024.03.07.02.29.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Mar 2024 02:29:17 -0800 (PST)
Message-ID: <79e628ab-9cda-47b5-abf6-9b37c98682d2@linaro.org>
Date: Thu, 7 Mar 2024 11:29:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/19] MAINTAINERS: Add Akihiko Odaki as a elf2dmp
 reviewer
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240307-elf2dmp-v4-0-4f324ad4d99d@daynix.com>
 <20240307-elf2dmp-v4-15-4f324ad4d99d@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240307-elf2dmp-v4-15-4f324ad4d99d@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 7/3/24 11:20, Akihiko Odaki wrote:
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


