Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D534D0EE3F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 22:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szORN-0001wF-Kb; Fri, 11 Oct 2024 18:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1szORL-0001vY-GB
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 18:48:55 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1szORJ-0007QH-MH
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 18:48:55 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5369f1c7cb8so3384245e87.1
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 15:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728686931; x=1729291731; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tZhMRCgmLWFPhC4H+JhuZkE6JNbUMDBXIFaFEmfcb7o=;
 b=V8yrNxyXSR7BjWgsJBoxzbu6s3GDBYDUb39Ae9kLMCzGA4fiEOk2gfTHb9Wy4ADM34
 0u5pWjbpeChIyWpixsqw4l/4sEP3qmFNPB/QAaXdjLQ3TWU/vGtw3OpsuDINSaRVWV8T
 K56zENN6imFlxXI5Gy7y6S6ImuEOmhgeth0IHFHntQMdsdUoPOHyQa6EiPd4E4ABhypd
 i6HRWJGiqDvROPOjBzqTpYXWlJW/cuNwxymjug8WeqJoTrS9PHc/fBjB/PAGbDosFbNr
 w7xNy9lJwZzr3Si5CvjpZfKi+5sBcqTlKwzQ4sxWOlUSOyyGfvRIvZQzAfQZuMRTwmTe
 wjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728686931; x=1729291731;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tZhMRCgmLWFPhC4H+JhuZkE6JNbUMDBXIFaFEmfcb7o=;
 b=Pg1HaqY+4sIAI4G2dS1rjVAXTg/DgMrPDeKq4fHNHWEX47X6ltg/430KoSCuVq5vp8
 DvB4fvvX9U8e+V46ez8QZT0ankCc4bli7Xa5UP8b7ts8X5j7Q1LWK84DnlJos274U5f6
 rbIxp4KLehm2i6nYpLwkv+sBcOjBgK7Wvfen9QVc2k4I/kcLIlpgiuXv6z2V8PaccgFL
 WNcj9vFYoSeXIX/svI/Z7CO1YP9L8gDg8iWUuANjsoiLKX4Aaru38YNtb+Cm4rd42Rxz
 BoSRjvhVXbO1tG9J9HOz/HbSjfJXLYRseGotTM/KfKwu7pjGJ197Wk3UEy5WGg/qhZUR
 q96A==
X-Gm-Message-State: AOJu0YywCYJnF4Mt9roy+auDW0pbV2kr4fKFSc5Ob0TcNVR5eSsm2Zn7
 nS2KROgyhJK2w7QgzIdwkdqgn68m5iCzCVy+s0KsMC0M4+9iyaoCMGbwP2SmWjY=
X-Google-Smtp-Source: AGHT+IHNCgKTW+eZtvYaut9Md2M6WoxaqGwkLm8N0i65wPK/nBtbNw9xsANbBUvFnCkmP5krdoX/mw==
X-Received: by 2002:ac2:4c46:0:b0:536:796b:4d94 with SMTP id
 2adb3069b0e04-539e57316a5mr547872e87.41.1728686931250; 
 Fri, 11 Oct 2024 15:48:51 -0700 (PDT)
Received: from [192.168.222.92] ([91.209.212.130])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-539cb6c1237sm731915e87.3.2024.10.11.15.48.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2024 15:48:49 -0700 (PDT)
Message-ID: <61c38817-3b6e-4bc1-a65a-d2208869c53d@linaro.org>
Date: Fri, 11 Oct 2024 19:48:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/11] hw/sh4/r2d: Realize IDE controller before
 accessing it
To: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, Guenter Roeck <linux@roeck-us.net>
References: <20240208181245.96617-1-philmd@linaro.org>
 <20240208181245.96617-8-philmd@linaro.org>
 <3434b32e-036a-485c-b3c2-3dd111e6152d@roeck-us.net>
 <7735d722-1047-49b2-ae2b-c95ead698a54@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7735d722-1047-49b2-ae2b-c95ead698a54@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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

On 11/10/24 05:23, Thomas Huth wrote:
> On 03/05/2024 23.34, Guenter Roeck wrote:
>> Hi,
>>
>> On Thu, Feb 08, 2024 at 07:12:40PM +0100, Philippe Mathieu-Daudé wrote:
>>> We should not wire IRQs on unrealized device.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>> Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
>>
>> qemu 9.0 fails to boot Linux from ide/ata drives with the sh4
>> and sh4eb emulations. Error log is as follows.
>>
>> ata1.00: ATA-7: QEMU HARDDISK, 2.5+, max UDMA/100
>> ata1.00: 16384 sectors, multi 16: LBA48
>> ata1.00: configured for PIO
>> scsi 0:0:0:0: Direct-Access     ATA      QEMU HARDDISK    2.5+ PQ: 0 
>> ANSI: 5
>> sd 0:0:0:0: [sda] 16384 512-byte logical blocks: (8.39 MB/8.00 MiB)
>> sd 0:0:0:0: [sda] Write Protect is off
>> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't 
>> support DPO or FUA
>> ata1: lost interrupt (Status 0x58)
>>
>> [ and more similar errors ]
>>
>> qemu command line:
>>
>> qemu-system-sh4eb -M r2d -kernel arch/sh/boot/zImage \
>>     -snapshot -drive file=rootfs.ext2,format=raw,if=ide \
>>     -append "root=/dev/sda console=ttySC1,115200 noiotrap" \
>>     -serial null -serial stdio -monitor null -nographic -no-reboot
>>
>> Bisect points to this patch (see below). Reverting it fixes the problem.

Sorry Guenter for missing your email :(

> 
>   Hi Philippe!
> 
> Today I noticed that our sh4 test from tests/avocado/tuxrun_baselines.py 
> is failing (which is not run by default, that's why nobody noticed), and 
> bisection took me to the same result that Guenter already reported.

"not run by default" because flaky.

Having a quick look, the problem seems hw/ide/core.c uses non-QOM
shortcuts. In particular ide_bus_init_output_irq() expects a preset
IRQ. Not something trivial to fix.

> 
> So unless you have a clue how to fix it in a better way, I think we 
> should revert this patch?

This patch is what we want long term, and reveals a long standing issue.
I'm not objecting in reverting it short term (I doubt I'll have time to
look at it right now).

Regards,

Phil.

