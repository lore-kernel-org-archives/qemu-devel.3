Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE401E7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 13:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMSHz-0002dl-El; Sat, 14 Dec 2024 08:34:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMSHv-0002cc-JG
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 08:34:31 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMSHt-0007Sn-P6
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 08:34:31 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso16355275e9.1
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2024 05:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734183267; x=1734788067; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0ZbxlpViG1TsgZog67GaVzFQ+LOIA2rnkrsVrbST9Mg=;
 b=FgHjEkapDdFzDr8TB593OfGg0N+cUvm7cLBkaAP5j9FK12o9OkFzAedH9EuVM4K2/z
 Bl4nydQiGGtj+yfa98TYpXl5aPwyc1Y7MKQbzsZuJXQhl2BdzELi1WA5bfRloGweOURY
 BD6T7sracIYX0bK0RJtwFspPU41NYrO7DqdJ1N9O7w4rxrtpnmN4Pt1kNs0pb9K9g0Pu
 7HFf4lFgEOtgcW2flytlcDRpDNq79qOpqGELziEOi02dKx/vRBJjPvsS4qiVEZ0dzcLZ
 Pgae7qj6EO2WFypA2HXRYbMYUxCcgQcpx6C8Ax39pyNYU/flcFdWOHLYTmDgtb58Mt4d
 Sb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734183267; x=1734788067;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0ZbxlpViG1TsgZog67GaVzFQ+LOIA2rnkrsVrbST9Mg=;
 b=e5Evy689CFgh43xnqyzpEi0sh7bk33gS8kqYk2rRZgn2/pDoQpwjFaUY6AVsXM0yQR
 MR84jrOjRV9c7FRHfByVexdRfA3AXRec5tyFRztdswp8DAnTx3t3h1RonHfEAQTswA7F
 yXK17RtjYwKeWSbtfN7POeAVAKLfSWzKtQj46/U3vAooSEtyFqi+0CHKVZJ6fXGFMAQs
 QM3/4BQ0LFPHRZBKagl6tdDfd+eDSS07z6RIH9X7vNgBtbvjwIHlzBiuIDnk0YbqQKHW
 DUjYPPl01BkBKDa1BkWrPXsydrqNLc1Z9be9wKts4Tbu2fmpIfMWdp3INW40gYoSupaF
 4dIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4dYsUUADvDAzBIZZ1fJgX4zQ/c8GYT0k9Vo6A41HGXDaWBYzmW8p2Ly31MDxeL7IC/KD8TAuD8Ogg@nongnu.org
X-Gm-Message-State: AOJu0Yy6XafBrYLaHaXNAQ6Bkq2cbCvh0KUH40gsORGkd+LSKLoVA2mv
 M0TfHdikFjBrZz6DKlnkRauDEHY6ytXqpSibUHJXJoUvzpnbGV+I2bIbg1q//jjSfBFJlZez4Fp
 lFqg=
X-Gm-Gg: ASbGncsRDN37hs+ebq4T03OU1c2ha2Cu7bcuqeWD1k7VpTXwtgThgGYu4WM5D6Sgubc
 ykiOOpomA/m5bfsw1ybDcENTIMeePFQ2wte8fkMLyve8ZkfFDuem4j7LpEpvSdz/Qfy+2sGAc6M
 uMHxyMd8bVBNBP8+Fteekzz8G++4EJDI8s3WYRn4ewlZP1qA1AUa4LyR4vP6v4iKpObZ1rR1dov
 a2AHwryrmBkQqwshwEfuRJtbB3modikj+R2uk7T/oxFynO4U+8w1LEKPx6z7CMB9yoc4+bVVNuj
 W9kND1hQC3RkF3GDvA/LnJOipQ==
X-Google-Smtp-Source: AGHT+IHjLAzwE8VKbE+qRhCsBAoHruf3iu6yCtVlCbQZRBihv8/i92iMSFZHaltj80AxDJzanQuK2g==
X-Received: by 2002:a05:600c:4f0b:b0:434:9e17:190c with SMTP id
 5b1f17b1804b1-4362abd3ce0mr44250835e9.0.1734183266899; 
 Sat, 14 Dec 2024 05:34:26 -0800 (PST)
Received: from [192.168.224.213] (201.19.205.77.rev.sfr.net. [77.205.19.201])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43625553234sm81675435e9.3.2024.12.14.05.34.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2024 05:34:25 -0800 (PST)
Message-ID: <1c8c1ea5-0ec1-49ea-a568-3d19cc22e3fe@linaro.org>
Date: Sat, 14 Dec 2024 14:34:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/34] next-cube: convert next-pc device to use
 Resettable interface
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, huth@tuxfamily.org,
 qemu-devel@nongnu.org
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
 <20241212114620.549285-18-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241212114620.549285-18-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 12/12/24 12:46, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Acked-by: Thomas Huth <huth@tuxfamily.org>
> ---
>   hw/m68k/next-cube.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


