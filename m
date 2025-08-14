Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4050CA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 11:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umWNn-0004A4-Ii; Thu, 14 Aug 2025 07:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1umWNm-00049g-2H
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 07:44:34 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1umWNi-0001nH-OG
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 07:44:33 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45a1b065d58so5399185e9.1
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 04:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755171863; x=1755776663; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eVLQBc55JGB8LpkyBxTZFvPN4OlcM0zJGtN1Twz/c8k=;
 b=Yw57G4zFavBx+gW2CQHJnZjD01BI6YfWCOZSZKbtMBxEUevC3fW3Q9YKSGlGT/2fGN
 MjuKUJWZQ5LUvUhFynZOIU/AzAQKHPUzaTyHdFFQCdRlIq2kL6gdEMNVi17B9XiZ23gQ
 kEMEy5GaLyGU/FIetiVOwKPYxlW/T4f9oIVaEHZapbgogmMD7IZsFiyoZCfejZN5HwnI
 tcJWVQ93ViOZ2yDJ57rFiADtyCLwd6X0lRxvlHfnw3F6fyAeNLaHcNiuAGanFNOT3m9l
 vD1eaSxNhce6JZS6orTb2hjOEmJaOEi/inVYHpXYgStc4kGhKUKW6MnZBge8XzKJcA+q
 QMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755171863; x=1755776663;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eVLQBc55JGB8LpkyBxTZFvPN4OlcM0zJGtN1Twz/c8k=;
 b=b60fQzUn/r8AYmu8veyC1vA4GrNHyJ9LFOw9pFJtWxQ0krshBRkPHlTSPVvpUqHlC9
 6/wxSWBjMZJjmJTHWkpMeFDCpNA7PynuFB3o2HhmMqXLhq4WPiNakZKuFWc1UYp7p/Gj
 FSVxjp0c8+y/HFTvwQ5KhnwQXtApBd0aO0XkyPRdeEwSfBAeJk3i2bPOLsTW1jCPEd8F
 jxhM/m4chS3WFazHGKyTInvWqKtiAtWhAZD5RBGsyiDwlTfJBHMQYpjfskdIwp+GaTOb
 G5IikTNSEsjdwH+NYl4xMl3ZZnM8mwKO3/e91fDvLaXSE/gVjpDCOkkEBLzsbPHoY8y9
 Z2PA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYhvKhpJyTnJtgPoJ2Ps08XSvEPTD29RN/x7RIw4Dd6Ksb628HuT0cQvptW/1zQbJiKz68XWPNQEix@nongnu.org
X-Gm-Message-State: AOJu0YxtBi3DGwGr2q3EZAfMELZyeiXG+hblSecarshIw7/nBXDylSwr
 wH4e1C0/JVBIAIK3r0+JxAMQVVbEjO6+fobnPdwxuBjIOMEop9Jkf6l8CVTxkg/E10Y=
X-Gm-Gg: ASbGncuxrsazf0lj7hF3Tfc9xHttxXJFujDV3XtHl6P8tzM0orn5A1Zq0yYWrjIEAQ8
 ToHYfP9gAQBqIGV1/LSvDSfyxDlSP7AotAfTrtSYJW9Pkq3PTZLAITeJhmr+EtELXdj9OK4yLvV
 S4lJnUWMom/866BZdwutCtT9WlexTkFIIjs+IzkYTRYLgVgk1sH28UL0H9CQqxUdHZ0wLCtSxHg
 AxwyfW6esp06CEPpu4hKIaGnIjazi7G+ZwNxREAhO0XVRrMVh0GYVzAi4zmVqwI13nHBswuuRUK
 D94kwYv0WefXK4YdeZHOoxXbqKW2M+iKuuXy/qcQ8kYsvXN9QfnSMsFhOrf5aNVYOU7bAyHXTQq
 162ngfpeS/mYNtxawI+TstIpolq+gpNieSP2dKP5Crdw6vbhWLm6ou+x/+E+R63axNw==
X-Google-Smtp-Source: AGHT+IHO/9Du4c9yx0dboH91PeN4mbHjk3sSiI2SejP3xySGTxSCEfEdFFaRanBd7of0AXeJg/K/eg==
X-Received: by 2002:a05:600c:4ed0:b0:459:df48:3b19 with SMTP id
 5b1f17b1804b1-45a1b6466acmr24945855e9.18.1755171863130; 
 Thu, 14 Aug 2025 04:44:23 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c718769sm18770395e9.30.2025.08.14.04.44.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Aug 2025 04:44:22 -0700 (PDT)
Message-ID: <c37f5d33-bcf3-4553-b6ce-c11b3e6c3d99@linaro.org>
Date: Thu, 14 Aug 2025 13:44:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1] hw/intc/xics: Add missing call to register
 vmstate_icp_server
To: Fabian Vogt <fvogt@suse.de>, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org
References: <6187781.lOV4Wx5bFT@fvogt-thinkpad>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <6187781.lOV4Wx5bFT@fvogt-thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 14/8/25 13:35, Fabian Vogt wrote:
> An obsolete wrapper function with a workaround was removed entirely,
> without restoring the call it wrapped.
> 
> Without this, the guest is stuck after savevm/loadvm.
> 
> Fixes: 24ee9229fe31 ("ppc/spapr: remove deprecated machine pseries-2.9")
> Signed-off-by: Fabian Vogt <fvogt@suse.de>
> ---
>   hw/intc/xics.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index d9a199e883..200710eb6c 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -335,6 +335,8 @@ static void icp_realize(DeviceState *dev, Error **errp)
>               return;
>           }
>       }
> +
> +    vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server, icp);
>   }
>   
>   static void icp_unrealize(DeviceState *dev)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


