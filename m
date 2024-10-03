Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98513CF34C3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 21:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swTQZ-0006MU-HL; Thu, 03 Oct 2024 17:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swTQH-0006HB-KH
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 17:31:45 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swTQE-0006DE-QH
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 17:31:44 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42cb6f3a5bcso18315765e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 14:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727991101; x=1728595901; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iV4qUultcJ3EMlxRUyNSvbx2EABLveRP2j1Xf4Oarv4=;
 b=cVMUKnPrqxaA59moXvg6NUGQ8tKgsKBwQSLcyiwCjv3yCdcMtfgjeeQ1DOcLBgmbyK
 yNWklgHRFbgrEC+uKRJNNe5lUrrb/eugCh9ks/9k5j/e/i7asHZEODvaxfht/fpHE/2s
 oAjV6ot+hUGyLYdDmRc3LtlWrFJAUNaqBWq36p6azEXw7JPcYHSeLLXIC+ZoEBVUCt0u
 zAKcxDcRtgj1Q/QFf9171Cxy9Gun1O687r8QT+RIJj3MCQZVrSLEGUOLXLRkRI+QlCBN
 s4m2zMeUlWl/r+7YH1PMc7NJaHWK0ypj3/h2wlHlxZ1stCzuCvzojyUonPdphzqhpru2
 ZAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727991101; x=1728595901;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iV4qUultcJ3EMlxRUyNSvbx2EABLveRP2j1Xf4Oarv4=;
 b=RPJM9nK4vFjzIzn2VbITouy6oNPPozN4Rq8i+nKguspsW2wLmXgiOXdey0WJZ492yH
 ElHAp0W/JJNvolgs0MKW1Ta1+Ek/G1Liy5GA8aS7SpNlWsYWJ9liI9Ir7EkwN60WsyRG
 0HFJSdMJpC0UzTbx+4y9jNFZppO2uOm8OnJdrEjr9pKkyJZ8TwWJ3LYDSycKqKCRIBek
 88YWcE99mzzZJ2RUUbrgrE1fBFvfMbOP1OFjitjI3O6TiZN/FTF4UQgXKTez9MUpHtOY
 ZgnslehQkhfjuSSI3N1rxHmEbzjnfw0gZ2bBe6UWgqGHm4YoJFLf+mLJChKloFSveXNb
 vM0w==
X-Gm-Message-State: AOJu0YyFouLPA0PZCbNsqmJtIHGdCsp90+y7AT3PbT8kjTK3d2VlPWq/
 S9mkHHMkEXngw8bsAV6hB5dB7gKI5xKacIyS/rsBfKdsWFXp12H/+Zj4LyqUqNg=
X-Google-Smtp-Source: AGHT+IH8v9IQWqfKATX+QRx7zWsJi2yjxHAr1w6KKlcYWRTw9f5a2czQBpEqVW01v6697HKfC++Asg==
X-Received: by 2002:a05:600c:19c9:b0:426:59fe:ac27 with SMTP id
 5b1f17b1804b1-42f85ae94dbmr3680655e9.26.1727991100968; 
 Thu, 03 Oct 2024 14:31:40 -0700 (PDT)
Received: from [172.33.27.23] (134.pool62-36-43.static.orange.es.
 [62.36.43.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f802b2805sm23962575e9.44.2024.10.03.14.31.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 14:31:40 -0700 (PDT)
Message-ID: <39a12ec9-91a8-4871-8a37-e5353a3a5e68@linaro.org>
Date: Thu, 3 Oct 2024 23:31:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd/sdcard: Fix handling of disabled boot partitions
To: Peter Maydell <peter.maydell@linaro.org>, jlu@pengutronix.de
Cc: qemu-devel@nongnu.org, Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
References: <20240906164834.130257-1-jlu@pengutronix.de>
 <CAFEAcA-_=vrtqVPUdu02ryUtdH5MwifEnHgeQVq=V4Z2Jp_dUg@mail.gmail.com>
 <d6e9f2f8d7185e90e7b80dff7b222fd99c899903.camel@pengutronix.de>
 <CAFEAcA-uMnP3Zyw5f2ha_9H1+QrnZXMau4FwEjP4UXNnjs-OqA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-uMnP3Zyw5f2ha_9H1+QrnZXMau4FwEjP4UXNnjs-OqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 1/10/24 15:01, Peter Maydell wrote:
> On Mon, 30 Sept 2024 at 21:05, Jan Lübbe <jlu@pengutronix.de> wrote:
>>
>> On Mon, 2024-09-30 at 15:18 +0100, Peter Maydell wrote:
>>> On Fri, 6 Sept 2024 at 17:51, Jan Luebbe <jlu@pengutronix.de> wrote:
>>>>
>>>> The enable bits in the EXT_CSD_PART_CONFIG ext_csd register do *not*
>>>> specify whether the boot partitions exist, but whether they are enabled
>>>> for booting. Existence of the boot partitions is specified by a
>>>> EXT_CSD_BOOT_MULT != 0.
>>>>
>>>> Currently, in the case of boot-partition-size=1M and boot-config=0,
>>>> Linux detects boot partitions of 1M. But as sd_bootpart_offset always
>>>> returns 0, all reads/writes are mapped to the same offset in the backing
>>>> file.
>>>>
>>>> Fix this bug by calculating the offset independent of which partition is
>>>> enabled for booting.
>>>
>>> Looking at the spec this change seems correct to me.
>>>
>>> Can you elaborate on when users might run into this bug?
>>> As far as I can see only aspeed.c sets boot-partition-size,
>>> and when it does so it also sets boot-config to 8. Or are
>>> we fixing this for the benefit of future board types?
>>
>> I stumbled across this when trying to use the eMMC emulation for the RAUC test
>> suite (with some unrelated local hacks, which I still need to clean up for
>> submission) [1]. Future boards would be affected as well.
>>
>> One other possible issue would be disabling the boot partition by using 'mmc
>> bootpart enable 0 0 /dev/mmcblk0' (or similar) from Linux. The layout of the
>> backing file shouldn't change in that case.
> 
> Thanks for the clarification. I've applied this patch to
> target-arm.next with the following paragraph added to the
> commit message:
>   This bug is unlikely to affect many users with QEMU's current set of
>   boards, because only aspeed sets boot-partition-size, and it also
>   sets boot-config to 8. So to run into this a user would have to
>   manually mark the boot partition non-booting from within the guest.
> 
> and I cc'd it to stable.

Thanks Jan for the fix and Peter for merging this patch!


