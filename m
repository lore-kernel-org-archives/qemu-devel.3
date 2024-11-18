Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A9DD591B3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 21:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD8sD-0008Og-GD; Mon, 18 Nov 2024 16:01:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD8s8-0008O0-4X
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 16:01:24 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD8s5-0004YG-W0
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 16:01:23 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43193678216so1488375e9.0
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 13:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731963679; x=1732568479; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wg+MEQtWiOOkqZ/ig3DhuzJIeaFSbDL7WmQiMbcryuE=;
 b=fgfL5XJli6VvszeP59hIKw271dkJvh/e5Dph7AFEifelk2exj7LJINAdjLof2ix6+M
 4golgy/41slKHfSAAqd5Ps0Y52Zcm2eDRxb8d/Yehj+mJlBST6JrouIF0AZxKd4LmMK7
 TNgZjyA76TW/ykwS1D+i0WEE1miTjzMR8a3ZsIv1VpJjLW1o7LHBIsQgi4SM9T2YdX/c
 WwPBDgQaZHg0aT+W6vQ8ROQ61g9Bgx6KuMDJipaXJpVDV27qTYs5Sqc7vWNK4tPzdkwB
 MhsB5L/RK3YD0E2jW8qxCGsUcDoNfB1c/m6V6/t6s+5F1QTvOZWe0mmrMP6Jnp7xc1SS
 TiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731963679; x=1732568479;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wg+MEQtWiOOkqZ/ig3DhuzJIeaFSbDL7WmQiMbcryuE=;
 b=nPH+VD+h+CYgjC8WXZ6dZEdt5hpGLsH6J7Ji2YljwkATwpFiz/msKH2/yOnJaMhmqZ
 JNWV3uc2FTtEmLZ/0Yb7SbqH7UeghxunSHh9iEMBmgtzrsvGbu6fmpM6GiK7vHwzPKDY
 zeD87yITUzfHlHzUMZ8+ZPL9kDKAtt0mh0vVzP19Ga0OGrHgGxJOcyYqMiyoTxo/U/q4
 ljP2JhIVS1mGZoG2Iqx4QDKiADfm5FAZoj+L/t/8ava4yD97yAcf2DL4HFkAhPK3PaHN
 eRypQdQ988uXLpvwIreyFZuvtuaLLxORFP6cB1hmMu5kT1H1mLS2826ZGtUYGAvFE7ZY
 +0/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxZYG586H7A9Xbk1qlcI2m1AiqaX6fS5MeWlm7zq++aDugRfKgl1Vyq6qNZ2NQ5bAgsz7M7ov2WrxE@nongnu.org
X-Gm-Message-State: AOJu0YwSlfUQrX3W8DQmpzkr1vU8fhZpDJ5pdNXRdrt++f/WTggyWz6U
 TlWXym1NlT2lgE4RManpimt3D0m1eiTbxHVzel6Fnlm+vt8KnjSg0r22+/kzNOo5jL8kt1Rq5Dl
 n
X-Google-Smtp-Source: AGHT+IG8pCCrIPDqUR6rAmp9nsGfqgKy0NGO1hDQNZ2YgIUKjoZMk9J+8GJ7SO6Xq3qrKwaBSZIzJQ==
X-Received: by 2002:a05:6000:1543:b0:382:228b:4c34 with SMTP id
 ffacd0b85a97d-382258f0863mr11606802f8f.2.1731963679607; 
 Mon, 18 Nov 2024 13:01:19 -0800 (PST)
Received: from [192.168.69.146] ([176.187.198.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3822ed2bc9esm10070251f8f.6.2024.11.18.13.01.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 13:01:18 -0800 (PST)
Message-ID: <a31c41d5-4301-43a3-a8f9-e7d5d262b025@linaro.org>
Date: Mon, 18 Nov 2024 22:01:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] hw/intc/loongarch_extioi: Fix undefined behaviour
 with bit array APIs
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20241108135514.4006953-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241108135514.4006953-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 8/11/24 14:55, Peter Maydell wrote:

> Peter Maydell (3):
>    bitops.h: Define bit operations on 'uint32_t' arrays
>    hw/intc/arm_gicv3: Use bitops.h uint32_t bit array functions
>    hw/intc/loongarch_extioi: Use set_bit32() and clear_bit32() for s->isr

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


