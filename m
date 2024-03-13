Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BD0C54E68
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 11:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkMN2-0004d1-Vy; Wed, 13 Mar 2024 07:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkMMi-0004Zd-I0
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 07:01:44 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkMMf-0008Hu-W4
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 07:01:43 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5131316693cso993772e87.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 04:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710327700; x=1710932500; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sQ1F7b8nXauwUDGhSJprQfRxHL2zsgsitKlyzIquU1c=;
 b=vLMqnwCvWY+N7c7m/7sWgIeU22lBnOyrPwejr4fsyxCdkO47aS2SeeUmU6bn4MqK8y
 dOqKQ+ZCeOqGmSlBCfmhNaa86/3o1NGLpmz9XK73kgWDAzkCwAueJtvvItJH7FvVso5A
 +9MVhvQkSzupROf5eLCApkQfL0pT3Z8FXT+ql4ri9/5AcK1FMV2LqX0sxcEiKdNB4vzz
 vo30BAB+e5WKvgNq8yp93uN4KD6OyloW+TRmj4sZsskQ0OxgMLoVSMVoOXghgwwzn0R1
 ZppxUgTFm7spfzXcV34YNhB4qpwkq8AH7IPBWGHVXHtimYt1rgbU4zAK2cKg0aEHHldm
 BEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710327700; x=1710932500;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sQ1F7b8nXauwUDGhSJprQfRxHL2zsgsitKlyzIquU1c=;
 b=JwAKeQXZhMIFEUtd3/nkqzrztLh/01YaxMQvCkJyuV3z3ibVb2WapyxIqOTH5kfP2v
 /Lahusznv20kbuiYNSzaRzjHNRm8+NwxybVKMG+xsGLq4yh0nKnyxFZYvcdOp3+nmhE0
 aH65Xuaoo91h83qNLTokPecbZnjXJL1wnJ6OxiLBscpgYMWVrhZ8wZHNLOELh6NaMuth
 UmGPS4g2y0kuwUri2w7BJtXtaOphWT3tFArTyvfjuAf+RYUEF+7tAaav6/UM8Wn3IdAD
 yqK5tDrQDI3KGfacjr9nt3RNb/cIXQYQYwC4NB0UAHNvMVhUH0jtk2pPciA6S2vTwwSN
 C8vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMm5pTOO7K58Kg9ml+Acs7wNHHAyJZulubhLkyyFdBEd4HE9W/vKiPYrRrxMVkTxTwpFgHr3T3QJYhJK2UZPWfRtGthaE=
X-Gm-Message-State: AOJu0YzSVNx9MA0DyFhpH7P5jC1RCPsjLHnmTIsJ46aR2r57+HHL+iXE
 PZwZ6KQIATRkjyWcUq7/EIk0WR3TbY9Iwh8KKbegkBL/eEm3k0ru3S0bgco3se92wJf+C3R5N+y
 tEp0=
X-Google-Smtp-Source: AGHT+IHCJZ87zLBJ0udk5R8GBNdA2cfcDbCuLB7BqvH4wQTG6NBduJaeqyCI/lV+wvXc6t9OljVRIg==
X-Received: by 2002:a05:6512:201a:b0:513:af02:3242 with SMTP id
 a26-20020a056512201a00b00513af023242mr4040052lfb.0.1710327700090; 
 Wed, 13 Mar 2024 04:01:40 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 fm26-20020a05600c0c1a00b00413ebdca679sm841873wmb.37.2024.03.13.04.01.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 04:01:39 -0700 (PDT)
Message-ID: <c6e4cb7c-a776-47b5-ab09-e2aa7535a764@linaro.org>
Date: Wed, 13 Mar 2024 12:01:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/16] esp.c: update esp_fifo_{push, pop}() to call
 esp_update_drq()
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 fam@euphon.net, laurent@vivier.eu, qemu-devel@nongnu.org
References: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
 <20240313085810.2655062-15-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240313085810.2655062-15-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
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

On 13/3/24 09:58, Mark Cave-Ayland wrote:
> This ensures that the DRQ line is always set correctly when reading/writing
> single bytes to/from the FIFO.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/scsi/esp.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


