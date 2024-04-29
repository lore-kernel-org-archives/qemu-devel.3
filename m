Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E341AC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 14:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1SLw-0006Z6-K6; Mon, 29 Apr 2024 10:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1SLu-0006T9-EZ
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:51:34 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1SLs-0007jI-R0
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:51:34 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6f28bb6d747so3848861b3a.3
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 07:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714402291; x=1715007091; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QwfdFslcn0+t9dFmSrf8MhLx39J14rwdj1BP6IK2Wv0=;
 b=Bq1L+GROZnKJaev9exbpKzHnstyCTO1sg8npvwn5a1qNssQVEaICcsJ3sfF0f1Ejdj
 F4JYkJfAx6qo+WfJ4Tz7UNiZ/e8iNdOIadKIg7WAHfdAsQF1lZK1tcLhI20sUjBodXJn
 OSjdIcEQLnzrjxqHmHGmfRiuTb6mcxwHxh6ebTc7vY1t8EfJMPeUxe/cpyfLGuAjVx2s
 QYDYrnwgFxUmNPL5Ng9CT1edXZ/O9sZm/EwLlrJMU0l+Da+qUxbrYEUEuPMzZzREWcQ/
 8LJ5yo9rNHZCqNPGBq9AOrMSr2cJxFQA4y6y4oM1diPEttgWk4JuTBRTkLJG5vY32WL+
 DSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714402291; x=1715007091;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QwfdFslcn0+t9dFmSrf8MhLx39J14rwdj1BP6IK2Wv0=;
 b=rAh3Rxf5/F/wi9OEVqZx69BkDmsVhPj4csY4NpFXg8w4xo3jV4FjIZ3pV/W7ina3Xx
 S6lsd59EXbZu8yMBdNYD5IOyXM2nzkYMI9QBVWQaAtBapYvtr7+jc+cAnfihEuOuCWtN
 /ozp21uuPsUowu34aCT9HaEW2cIOi7Vs/NnqlUMcnENaTJeWhdc9GWCXL9ZDTJTc2h/7
 awg/N3EfROT0sSboAxqF5I+iMoxvi+/7tXBwikYae83zH6z0n9CTDPUJbx0YP4JMTQFQ
 BhsSYE55NbNCbOyaszGnIvQwNcRD5NgovZADtfiaS7wwfl0jFtlxWd6y0xtQT+xSUrkX
 yIiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDh7dcD5tRM34CbnzI9wngqMxqf6M8kN7dkyqqdVxCiVHr0H+V3EzqqXR+6e9jU2rV02EWOgpAuiS01aPgUIw3Dqoq0mI=
X-Gm-Message-State: AOJu0YxwE7NeDw9dlnEjS1nSlV5UDc2FGfzt7Q0kiaDNYg0GX+s19Zli
 3UWhIfqJG7W/9pUG68wtKePPxI7l1B1MrKLGuCPa5ZigAd6Sdx+gPrmgWQhaiWA=
X-Google-Smtp-Source: AGHT+IGN4bkkypHX4327A+UF+1jbP8ihG66sWet5L9SiVyNvitw9XbrLxPuBsS532EavLIrFBBafMA==
X-Received: by 2002:a05:6a20:104a:b0:1a9:b7d0:b6ff with SMTP id
 gt10-20020a056a20104a00b001a9b7d0b6ffmr9437083pzc.32.1714402290901; 
 Mon, 29 Apr 2024 07:51:30 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 p9-20020aa79e89000000b006f3efb03841sm3984230pfq.40.2024.04.29.07.51.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 07:51:30 -0700 (PDT)
Message-ID: <5395a311-d407-4131-9bbf-63a843c416fa@linaro.org>
Date: Mon, 29 Apr 2024 07:51:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/24] accel/tcg: Move @jmp_env from CPUState to TCG
 AccelCPUState
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240428221450.26460-1-philmd@linaro.org>
 <20240428221450.26460-17-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240428221450.26460-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

On 4/28/24 15:14, Philippe Mathieu-Daudé wrote:
> @jmp_env is specific to TCG accelerator, move it to its AccelCPUState.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/tcg/internal-common.h | 1 +
>   accel/tcg/tcg-accel-ops.h   | 1 +
>   accel/tcg/vcpu-state.h      | 2 ++
>   include/hw/core/cpu.h       | 1 -
>   accel/tcg/cpu-exec-common.c | 2 +-
>   accel/tcg/cpu-exec.c        | 6 +++---
>   6 files changed, 8 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

