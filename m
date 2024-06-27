Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB28BC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 06:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMim5-0007cj-1l; Thu, 27 Jun 2024 02:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMilz-0007cP-Ip
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:38:23 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMilu-0006JX-JD
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 02:38:21 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-421eab59723so55770555e9.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 23:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719470297; x=1720075097; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3BlP+uWxvlAfGRDYj2rzA3MGMlRuPtVnejkXt6w7pQ4=;
 b=KoELuCf3kbflBf2n8NWWg3UUoMl5yDU80KDR/rlw1dQ1cmXkcT625vrZiXghVZAJgt
 MrOTlaWA3IAUZTSb9FGdyldvx97/x3Z2ZrhbaEhTHo+M3Bs+XpF4qb/goOEYpF6ht1OS
 0b5MUFba5OwcJ2hnnRicQJ+65HVlphv83Q3lTGjPka79082aTUihetONy+HQGhO96cRk
 BgkVk3vvhabT7aq9CusVziRyYSo1Or/Bt/MFiXvgcx1UF2gg6c2LGgn/XqkzEWK2ZcKH
 kdLpQVP540cqfa13kW7RBREVrH/4OMmnSmLZa7HBZQgc+XB44yZkWmHQyum9O22r5muI
 BiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719470297; x=1720075097;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3BlP+uWxvlAfGRDYj2rzA3MGMlRuPtVnejkXt6w7pQ4=;
 b=SVPgATTYU/KEIkhNUlXKnFbfzGYjjTsCm7WNtNL/oZFcr0hHIq25daZCnfEcNecwlq
 afIsiJJ7zrhzmuNIkb+9Af5vpeu85sKo2CmxEdFNptAAGXxRsuinFq7EcLongXvz8aET
 axr86a+4JgD+VpsbhyZPacpkP85Po7vpJgO13GpJtajg3h8u3unn5NEO2owMd8/1dLT/
 tnls8r3LpCtmRVroNMZGGwqkbF0jGWrGe6EDho3TkxpCm6jTaavw4bI6DVtJ5IIuCR0d
 YVxmwPHpglkYw4B20pwOWzXjkp8UjkXVm7Dbgob7jEvh2y51J4PvAjyN6qCJzr3hFarb
 LMdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkyq9ZVMCIXRzECsjvPeTN358Jg4G5U4JMbqgzHWO/2QrgdTVcbVwIyl+3QeFQYZsD9QWiJc90C2hkjuCUtgzDF87PgeA=
X-Gm-Message-State: AOJu0YxK7tzsOHx6r+TwsG63ZpaDiiDG+pAAZH4uuUn7wrALcNaoDCsO
 0gguzpfEK+bBhs6DOIRDDq5/znUaO9R9iIVtwIPjYbv52XpMH6Tm0KNuZI9xOlY=
X-Google-Smtp-Source: AGHT+IG22VlvrxqWlyjX/W3hwjUZBn8nDidsZ16RVybqijdV/lxoz1vGJPb775rWouYe6hbNbQ/1IA==
X-Received: by 2002:a05:600c:17d5:b0:425:6171:5d26 with SMTP id
 5b1f17b1804b1-42561715d5cmr19763795e9.36.1719470296830; 
 Wed, 26 Jun 2024 23:38:16 -0700 (PDT)
Received: from [192.168.236.175] (163.red-95-127-40.staticip.rima-tde.net.
 [95.127.40.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42564bc59f5sm11156645e9.42.2024.06.26.23.38.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 23:38:16 -0700 (PDT)
Message-ID: <acc08621-19c1-4ec3-9fc9-acb0eec79121@linaro.org>
Date: Thu, 27 Jun 2024 08:38:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] hw/intc/loongson_ipi: Fix for LoongArch
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Song Gao <gaosong@loongson.cn>,
 maobibo <maobibo@loongson.cn>
References: <20240627-ipi-fixes-v1-0-9b061dc28a3a@flygoat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240627-ipi-fixes-v1-0-9b061dc28a3a@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 27/6/24 06:13, Jiaxun Yang wrote:
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> Jiaxun Yang (2):
>        hw/intc/loongson_ipi: Gate MMIO regions creation with property
>        MAINTAINERS: Add myself as a reviewer of LoongArch virt machine

Maybe s/has-mmio/use-mmio/? Otherwise series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



