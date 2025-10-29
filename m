Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670E6CCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 08:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE1lP-0004l0-L3; Wed, 29 Oct 2025 04:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE1lH-0004bm-HC
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:42:31 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vE1lC-0000GR-VD
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 04:42:30 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4711810948aso51859695e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 01:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761727344; x=1762332144; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V+OfLsRZ9s76E6R1qSZMXm3vCNDLMJ+dmweCI51a+Y8=;
 b=NtqBnbU+OxoE5EGMfBoVJ99WVC5vbEG/mtBL8WfOs+la29uSzgLdMkXUFBI2C1KZLd
 28NzV7aHwk9n6+fxJxxIJ6SQS+ZsWIrAaFJ9aqCrqg+zUHWUq5sZThTPpqOYmFOcTQCl
 pds1Jz0nOz8Y3VhQvbL3I1ybtPamDtmq19RXMQPe4FdWuBCn44MYy8wliU0l2ncHSM+/
 esr0U7c7tjq1eQVvWaBWux53gCZoaQL0rnnffQLBfX4wdro9HWkGYjwKiMUFrh0Tc/bj
 GlN1FokQWKhUo2oFa2v+TLFH+7cSYSfKoIKA53XNVqAwpIhY2lyj32KbWQI92NQJ72c9
 piGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761727344; x=1762332144;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V+OfLsRZ9s76E6R1qSZMXm3vCNDLMJ+dmweCI51a+Y8=;
 b=c/C3s1g692dKfD3xqUOomkqL7LIxdx9rn4P1/5neaOJtMRPVKlvrtqAoPsXGaDDWeT
 WVHqJmOv3tzHfGlGLXfeh2AqMrqCkCEg76bHNZze+IGTX50PJw0j+pe8bXTsPMG5umxL
 pqueeMHo+JR2dtxKxV1STvHqMPqW0umVbfZZNQ2ix1537qSZFrRanTLozve1o8vj0t5q
 fcDFbGPGBia7HPFXKfWrnwIgO20ZYsnMl4eujvdc6jRVuTZzQiHEx2LWcICT//xmtjBF
 MSMJZ51CVPsdkyK3Om7ad4goR9B/QTRxTKdkGycY8wiglFeX1C8TDBF9O0MdPdcuW1GO
 b+vA==
X-Gm-Message-State: AOJu0YzKyq13uxDbAkVXpzYf4Fa+zMhEk6nL9h3qsUD/8iCk4bEid1eX
 D5r4Cee6XXIqXRRSOWcwYfGX00ChDQzm14S/78NuxWkMZvHQ8e7xkJi4GMsbg580nOfn5weTzhb
 7M/DiPSI=
X-Gm-Gg: ASbGnctmMcgb1tbqO8Oko6xDcAnpRzlfnjPa72M3KdVqhjpVdBo2qPl7igTRw0ulFWz
 fWCHK5NOPcJgbHOgREOW9L4B0YsraaI9ZNv2oCYNgO1KeaobpHCIifbU/qlRh5apS1J2e/g+Frk
 schYT9dTNbc2wYI+fcuDID5o3YO2DGr8ZuNPzvzoJ053oHtYQzO1rQeriAWBCMPKy53kJdHWBY9
 xVxJDjNaiTaTAgcRw23uW++OfzvpgbtmIm2KBJTSVdrlAOtBSXqFhV3PvQqj7sOK0TvNBsc+4Gz
 PfUsd1aCWE6zeGzAY9AfXbR6NGei/sArzlqY/a4xJfYeLJ3seZY9VDAY/rc5UdQa7+x9EB25k2T
 9S6xTYd9brh0WNUcoPMiVukxxsPSUrtCXihV+uz0LjDpAqZRVCTQfGB3NEMJ6jpVMGhEw8IXwaS
 tjoj4dhJNx+ou4TTSm
X-Google-Smtp-Source: AGHT+IF7qHAmjxqM9hcGfYes2x71W0ZdCPTGWwEEtCLG7pyYWUxXVoOBdREM7l6ympAAN0aH27Ab6Q==
X-Received: by 2002:a05:600c:46ce:b0:475:de68:3c28 with SMTP id
 5b1f17b1804b1-4771e31da2cmr20024715e9.8.1761727343955; 
 Wed, 29 Oct 2025 01:42:23 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952b79absm24818086f8f.3.2025.10.29.01.42.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 01:42:23 -0700 (PDT)
Message-ID: <a4117d57-b6de-4dbf-9d1e-83b0123a4fb0@linaro.org>
Date: Wed, 29 Oct 2025 09:42:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/25] hw/nvme: Use memory_region_get_address()
To: qemu-devel@nongnu.org
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-16-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251028181300.41475-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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

On 10/28/25 19:12, Philippe Mathieu-Daudé wrote:
> MemoryRegion::addr is private data of MemoryRegion, use
> memory_region_get_address() to access it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/nvme/ctrl.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

