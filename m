Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 531C5C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 08:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl1vX-0002on-JR; Thu, 20 Feb 2025 03:28:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl1vM-0002di-Du
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 03:28:48 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tl1vJ-00012r-NU
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 03:28:47 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-439a4dec9d5so3498735e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 00:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740040124; x=1740644924; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o42TVScMkWBRcW50EFj59vXpjFTmKfRrsrDbs3gtzaI=;
 b=AeVCaEapfk6CPkVISyr1NviwauK2NljaqgGSGo/4EUDSbe5qqlA3IPdcXXN9bq+lN7
 bzwB0M+UxMEoudvWk7ZirnSxL26Nb4fPycbcJIX/9BJFuvPYwykGcKCOPVFG9RSf4yvZ
 xpAi+P0Q8aBvU6OdGkyVATQyHzNP6G6odkmb5/Jgvdi7+SXQ4QVTCIdFYy+I6viTALRY
 tHGpvt6ShRxyqFYxXTjMJehVgWHwhEKQr2SW/sAaLAXfbn1cZL3rJXiXuxEKdpAWetDE
 WtPgX/7TYqLMtPrXRx2zLKsM8COUQr7B5q2T70cIacsX710hXLOAWrncJpKiLbLUUylH
 PWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740040124; x=1740644924;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o42TVScMkWBRcW50EFj59vXpjFTmKfRrsrDbs3gtzaI=;
 b=LjdqGki9Zd9efaTuHgX4mYB7wLl9bz+rko3mStiVAHW/EF9cRItOBVaZ8Dc1n/9jct
 nCFBCe1mnbsjKfl7/IMvk3p+XqSF80Ntznj3OlUtmI5/qUA6lDagNqcPGuhgYIWnL0M0
 R97mWJnGW9aTnhEj1x8VuBWkzTX6mM7ZVsFLbChvRKSvlGEyiBUF+mAec3r3GWsPfXvD
 52Vi0/gihg2Xs29F8kKOGHtG83BJWu7T79jGTuVjCilF8B35+GKiEuY0gReNYL1RTF1x
 BXUdBAgRgkQi99qZxaUoIO+xQyiOHPYx+ca1ElG23IGz8US3pJcPuszrD1DE0wHLkV7g
 leUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVP/kKuTTHaEbZNDhPsTVrEcEFGonE609tVYhZVd0FMcktP9bdMgjYcF4u2EIId6j/pYPC7C+njxRv6@nongnu.org
X-Gm-Message-State: AOJu0YwFy39ecHrZtpMKG1ihfdcwAu2lgNPbeCo5973Jvg+ZhLkxxaPF
 V6EcAx6kTB68FI2+fXdJZST1ew2QBqUU5on3rR+apBIBleZG7SlAJPL9Q4ppnQ8uu3XDJT08Nls
 k5Bw=
X-Gm-Gg: ASbGncuu2LP47gDfqhn2Qyz9JfpSC88bJx6VqXf0p4i0sWuxYM5sRZ+HLV4iFQH61iG
 jmNf9xy6cQrIgqCZPGC/A+9FVyps6tvGL7ovT3wekKuHWuThpgBOsy3VXRkNiflIk/4PV01TZGU
 ULQg/gM7t6F1BHtU1H5RHCX58IH5pQnHvwy7G0sq/9tXTiDSvFXSG5wy4+KdtY74wXetHQ7rnFU
 X9TUD9kjRApkBWd8TL2sao0GpHDi3XuGpg1FX0t9G0YISs0NaFzkTUvpIPLEOHc0TkluUVZkHSL
 veO2aZp/RC5forFP7PoRO6fbI1JU5Ejvz15mr9Yjxo2ttnki/PA449r5J+g=
X-Google-Smtp-Source: AGHT+IHPTG0euoZqI2s0iNfGxqPzS5bcoKsS+brkfAysI0y2548v3uJvhG9NAadqPKFq839NR+HfeQ==
X-Received: by 2002:a05:600c:5246:b0:439:9d75:9e92 with SMTP id
 5b1f17b1804b1-4399d75b257mr49033445e9.28.1740040122491; 
 Thu, 20 Feb 2025 00:28:42 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258ddbe0sm20155678f8f.39.2025.02.20.00.28.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 00:28:42 -0800 (PST)
Message-ID: <d159a860-21b2-46e8-a74f-cd6be14ea525@linaro.org>
Date: Thu, 20 Feb 2025 09:28:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] hw/char/bcm2835_aux: Really use RX FIFO depth
To: Luc Michel <luc.michel@amd.com>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 Rayhan Faizel <rayhan.faizel@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <huth@tuxfamily.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, qemu-arm@nongnu.org
References: <20250219210841.94797-1-philmd@linaro.org>
 <20250219210841.94797-6-philmd@linaro.org>
 <Z7bmAqE4z2y_kNse@XFR-LUMICHEL-L2.amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z7bmAqE4z2y_kNse@XFR-LUMICHEL-L2.amd.com>
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

On 20/2/25 09:21, Luc Michel wrote:
> On 22:08 Wed 19 Feb     , Philippe Mathieu-Daudé wrote:
>> While we model a 8-elements RX FIFO since the PL011 model was
>> introduced in commit 97398d900ca ("bcm2835_aux: add emulation
>> of BCM2835 AUX block") we only read 1 char at a time!
> 
> I'm not sure I get why in this patch and the subsequent ones you keep
> mentioning the PL011 model while you modify other UARTs. I guess you
> mean "the BCM2835 AUX model" here?

Oops too much copy/pasting...

> 
> In any case:
> 
> Reviewed-by: Luc Michel <luc.michel@amd.com>

Thanks!

> 
>>
>> Have the IOCanReadHandler handler return how many elements are
>> available, and use that in the IOReadHandler handler.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/char/bcm2835_aux.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)


