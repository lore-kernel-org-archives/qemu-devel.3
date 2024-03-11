Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17DAC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 08:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjbAt-0007oW-6H; Mon, 11 Mar 2024 04:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjbAr-0007kf-A7
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 04:38:21 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjbAo-0002ve-M6
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 04:38:21 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33e9def4a6dso85461f8f.2
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 01:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710146297; x=1710751097; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fgQQeSSsi8OrcJhbuYCEpP3VGCJcMiEz7pTuXYcw5ig=;
 b=pauC4xy6LSGjqACTzyV5LHI+xvCqAoC0EXjFFnVNRINxpN5E0coNXdIjcKyfgujbPk
 tHSo76l7tz7k8/vSx+i/iTIeophNR1Edu0jqw5jm2qqENQQ68/dFc2ROebLIFhqwQL5h
 qSuDG44IFoCezs8CCyV7SzkdZSifHGaAjsN/NUHfrBgyUg7OHSugPSLs0o9iTOAzr3UN
 NzC71H4BLu7UydJ+6DhSh2uHld6iM5ZJB1BrkokpbDpME4GFC4yqd4tLTsqRPc/PYFP+
 h20ikRggQ7v7QRh7JPpxlECisvDh2Wtkve8LMj+VYoRypRjyOXwjVy+8FWxhrqw3yQsg
 uWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710146297; x=1710751097;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fgQQeSSsi8OrcJhbuYCEpP3VGCJcMiEz7pTuXYcw5ig=;
 b=Tct7UwFo7JLgI45GAcXJmIPThwYdUOVJSBYuH8p5aLWQB2BNEDjPVxT6UUsEyRGVow
 k8TROaNjkyPR3n0tkspFGJGXGnf4BVSLiJf8bjBO2B+kARP3J05XfphORs8uNHKShuO3
 um+PYR1QKnoh5e2S4vBOiDC6Azf4eU5Alx2SF3dLtWvJzfOkYlemWhmTnuFgHGKsU2AH
 ZGKTnVgiW+8Mq+U2mX+wJrpsSj06HrSwnPCFp7hVX6/px1SnK5O4snKS77UWRIkig2eG
 jpiAaP9L9pnlqdYuestaat1mPV30frPlJkFl7S7aoiJCE4FLHC2pCZ2yXHYv0vN6xAIL
 scJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDaVZjz9zEsPiqCIr870L7sJ80pmBIzr9WDvcVZmA7F/xTT7Iu24F7IA7erCmqQd1MWbU7Kfo0rB3IA/9TG5m6SeuJB4Q=
X-Gm-Message-State: AOJu0Yw3qaBDyJvG5SG3TMloBwelB2KMNDQOk4E/qnGKNBXctXkaPCW0
 /bhaE3WYgTS17sJ2GqXlGbnNM7NcwJNpO84ss8yUwfmQWn5Jez4Hs7Ccd3FogPYsO6oIK0Sz2Tm
 Z
X-Google-Smtp-Source: AGHT+IFbNH685kUo/fqJmFdkb0ygVeT9BSXNKhB6hX3PTrl00rsLzEWgAuQ2HrQPEipnnqRX6gdteA==
X-Received: by 2002:adf:ef43:0:b0:33d:71e5:f556 with SMTP id
 c3-20020adfef43000000b0033d71e5f556mr4726263wrp.27.1710146296796; 
 Mon, 11 Mar 2024 01:38:16 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.167.228])
 by smtp.gmail.com with ESMTPSA id
 a9-20020a5d4d49000000b0033b483d1abcsm5847569wru.53.2024.03.11.01.38.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 01:38:16 -0700 (PDT)
Message-ID: <1b91c633-fd74-466b-a793-e971d181f90b@linaro.org>
Date: Mon, 11 Mar 2024 09:38:15 +0100
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
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Merged as 78abf93cc7, thanks.

