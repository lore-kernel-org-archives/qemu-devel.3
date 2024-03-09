Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8444C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 17:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj0qu-0005g4-7L; Sat, 09 Mar 2024 12:51:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj0qs-0005fH-5P
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 12:51:18 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj0qq-0004u9-Gu
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 12:51:17 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-51341a5aafbso3480413e87.0
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 09:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710006675; x=1710611475; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yAxhNVtJwDIKHDe0PoI3UANPa3khkv5nuvF+KnPYjXs=;
 b=ISKeG2Q5mRzwwVuMtgzqTHDkYG7mEfuIsggBbBZBKSUWv1nABB4SQtn44ugBZowEU8
 l4Wc+OIK6pCj+OzReoHZBLnKRadQnSR+8WM8+T0AJOPKAXrX15QFaP5FwZi2RclvAzZI
 o7UKab+xqux3Sp2nBuw6DBn2dC8655YYRc9LHqkLCXKp817bvt1nJDVRfzWmH5dqsXUt
 ed+jd8JqOWYbPbGqGknIho643fph7xKvvdWAtJGsNLOKw2iekHk7KYy6/57WZOptJU3B
 lB/6pSvZjamilo5Dk2zbaJqKm+mZsYWkZG/7rKq8z1k/928nrvQl+wyHrVWDDBvqAOXA
 6MGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710006675; x=1710611475;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yAxhNVtJwDIKHDe0PoI3UANPa3khkv5nuvF+KnPYjXs=;
 b=e9uHRqKEkmKqb6KBIpF1Ot7qmABc/h9BM9/XAiVgo+DQ7Kujql0lH3SvquVN3sUv5M
 Yi1NPOBty9fiyo3+KUNEFckImrac9lxlSDn3TkGbb6LX11wTKll/ahxteMQ+2KR8kn2L
 BtcSxmEponDCxs58mtjQVi0VuqKMaAm6oiJ+21FhXG3bJDvybYdv/TgTxwe46Dbtczfp
 onuAzvEVXM5XmkwsXyMP0Zg9A7wEU0uCP9Chyd0bfI1AcqFBENMa9PsTuuE7+8sCxWwr
 TGpw4hRb0Zfna9/CZCIRhTHkLuT8XEP0LwlNbM3y3U/AzoQWisttrBC9ZvDy6VhZghls
 57Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWR2zwt2hM8o/hhLOE4wWwgFShahyJFrqph5cC+mKBu5gGh3lJ2ekgbwvVAAG/Rl8QkHYPKdDktGmZCvYWPUGoymZMfp6w=
X-Gm-Message-State: AOJu0YxSBwXe3m2HmAghDo77fpKcsEHizEeIf4gja+hZEZhk3ildoizt
 j4v6MajO8GhBZxprYO3mP9R+jN3EbTGMTgGlixyZDBV8fkLNJ/1Jigm7MO/FRo4=
X-Google-Smtp-Source: AGHT+IE7qh6psHH71ybVDgEVknOEPDiSTmmoxeqby0DxSBFwUDmdoT93iQXJ+UHaB1L+ITQKrOLDvQ==
X-Received: by 2002:a05:6512:31c8:b0:513:a0a3:8be2 with SMTP id
 j8-20020a05651231c800b00513a0a38be2mr1123163lfe.29.1710006674597; 
 Sat, 09 Mar 2024 09:51:14 -0800 (PST)
Received: from [192.168.69.100] ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a05600c450a00b004131388d948sm7586304wmo.0.2024.03.09.09.51.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Mar 2024 09:51:14 -0800 (PST)
Message-ID: <f24730db-c9b4-4d08-b55c-bfdc594994bf@linaro.org>
Date: Sat, 9 Mar 2024 18:51:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mac_newworld: change timebase frequency from 100MHz to
 25MHz for mac99 machine
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20240304073548.2098806-1-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240304073548.2098806-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 4/3/24 08:35, Mark Cave-Ayland wrote:
> MacOS X uses multiple techniques for calibrating timers depending upon the detected
> hardware. One of these calibration routines compares the change in the timebase
> against the KeyLargo timer and uses this to recalculate the clock frequency,
> timebase frequency and bus frequency if the calibration exceeds certain limits.
> This recalibration occurs despite the correct values being passed via the device
> tree, and is likely due to buggy firmware on some hardware.
> 
> The timebase frequency of 100MHz was set way back in 2005 by commit fa296b0fb4
> ("PIC fix - changed back TB frequency to 100 MHz") and with this value on a
> mac99,via=pmu machine the OSX 10.2 timer calibration incorrectly calculates the
> bus frequency as 400MHz instead of 100MHz. The most noticeable side-effect is
> the UI appears sluggish and not very responsive for normal use.
> 
> Change the timebase frequency from 100MHz to 25MHz which matches that of a real
> G4 AGP machine (the closest match to QEMU's mac99 machine) and allows OSX 10.2
> to correctly detect all of the clock frequency, timebase frequency and bus
> frequency.
> 
> Tested on various MacOS images from OS 9.2 through to OSX 10.4, along with Linux
> and NetBSD and I was unable to find any regressions from this change.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/ppc/mac_newworld.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


